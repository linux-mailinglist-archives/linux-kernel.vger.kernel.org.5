Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A816878D1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbjH3BT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbjH3BTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:19:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF35EE;
        Tue, 29 Aug 2023 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693358359; x=1724894359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gsiAFncK8KNzjV2cTljCjRICb2O0RrNCQLusPPk5rR0=;
  b=VjVKKJoAAHFupNAeGMP/jTiSEF2VLHZdtIGEyBV2kz8t1YvjZhFphU+b
   VbuX0OULxipHNeZZg3ek8IuPTlL3TzTUnEhay/4sNTnKI68T+vF1DBnx+
   oVSEkh1iYT3iKxyHX9Q74r4hqevs9wjzn4B5B2SMrOoEhwbLCknr9Etxn
   1WOfKjtHUtppgPCD98IYW3RWTTUP2sOoqPtsR8QSOnfuPDaWzePrK68oK
   vE7XS35yvQNS1xiJTG9ML5CPqxMTV6Jp0ql27FMD0bgp5tKJHGnSlAdy3
   yr4HDd1qpZXgsk7VFv6DobdR8cnK9f7BoV5oQkvO3dcg368jIqP/QLn/l
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,212,1688400000"; 
   d="scan'208";a="347722745"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2023 09:19:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9b3cJ+K0xmMxe7A85pAtmk9/+PG6/DhLJsfHwvzUKHpO7Z71EapPfCt0+C0+f6FxEA+iT175YuxFk18jb+VU6JV09gC68PLkpQKst7h/XV72iLSb6fU86nMD/whX4DdBLUj4OFpWslw5742JIlNTiAVZTt5aqQtXCcXIAutEa+jSQK7RER88YKW2xyysF1Fw3sAW6xOcAyOdGC7e2DM2CiyPgqPAH6sAD5vjwravTdi5VTxPU/6NbTQwPqHrLvdkPEnmY4KyIMOrvw2KGCbd2NEi9WQhCoE9Apn84XIKoC448U1AhJZOva+YbIu2e6Pn+q5CXRae5o3gMjg+FNzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/OBbleZd3bWcz5eb+K8y/jzV6JqRsI3FgXdztfh/xs=;
 b=fVg226jHQYR7nyvg1IzlrTI0itWqTe27XBiPMEoXC84i9P803Uzl8R00uYCz++RdFsjsTFsTM/qocPSYZWZNtL1BWymmgxQkDHy6EAQnln0FGk518Y21h+Uk75R+8KbdkhW+h/6/FrJUE5V9KH0XTyOarrBApxzU6u6JpSBJz3pr5zGYdd4y2n9QyDCorhdFbv0/LbJ//swNde9MAX+1R0TFFl1arOe7A+CkDArFO+aHDyqoegroUo/VqupHpEl7QUsL5SqtPeG3qIFk7CzukymNIZwqaA6/gcm9BR3uHZfvIQbUez+5W3tiKWP4yyRvUynaoKypLqQRawbAe/mWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/OBbleZd3bWcz5eb+K8y/jzV6JqRsI3FgXdztfh/xs=;
 b=TTaZt4bNJxc9bHpx7Ssx+OOo61k8HOBh1S4pQz22IAg5OU0ZhWA4kbwbFsNP837S12VmDzqIpFDSDebhxSlAD0tmfy2MsuO29FtGnp1NZzuFF44nGskSGS1xFzq0X2f5Nj2+vdBHbu2dLEnTa+i/Ylzit30ve1nuixgWks3apyk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6303.namprd04.prod.outlook.com (2603:10b6:208:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 01:19:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 01:19:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Topic: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsAgAC/9QCAAKx0AIAAYPoAgAAPCACAAGeugIAAC3qAgAAnFQCAA+SfgIAAuLaAgAAeDwCAAB+MgIAAed2AgAC/TQCAAMSCAA==
Date:   Wed, 30 Aug 2023 01:19:14 +0000
Message-ID: <o5xnqvujzakhrudv7p64owiuzgozmean6blxow4vdxhdqozg5v@qznf2tzmey7k>
References: <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
 <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
 <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
 <3b5b246f-386d-4afe-a20d-4b08770bd4cb@acm.org>
In-Reply-To: <3b5b246f-386d-4afe-a20d-4b08770bd4cb@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6303:EE_
x-ms-office365-filtering-correlation-id: 1b3a8454-c908-4d45-2d58-08dba8f71f70
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Unm0wKO3LKCU7dPWcFKLQAMvHF2LWGAfZzyJRQteVD8b6MoBnSZ8Cisol82/VMLv/JCVhKtDtm5Ui9RhLZekVDLnNszPAxmt+YUA47f1dEjs9qpeUPcSq5sKfV9NziKzXf9G3brB21d+Vd6eeXa5bfpRPtKYsalsBAE/SvdVEvgdMr95Ut27h3exHEJXTP8zDuHdMCwo9NdiSLiQxYfLgHgEeKnh/avmo0DzKd2Zi7XnD0EJolnoanJrsHwY9T8AA4xeufXlQHa9KtFsUepF3UiPwr0KWsbs4x2wJdjhoeKkzdq/qYLiaf7iT2Mo3yQqpSfXGiDU9WmedzANH8ql72CQ08OXT8qEDNrqRt2gmgN6R+hRdOIUgdvKpYUh+D16mWapgIAILKrvfqqUAIPKtA3NLTFX1WjWLh+uozvE6m5CQpE07oNgngVr3bflHXYLdEBQLyCFuI+BOHmTLtanvUxAbEwnimfbcbHAJ8fvKidGCQXUk7NtvTZUUOexu9IE0Jh++BX7PC+AYfeu36jUMBqEjvb8Dms/rPwhOlwMMMUZXT0de9FwwRsc05Oea9D77uDNSAqqrJDHkWzbfU0CMYgKx72PbYG2gbUpzYT/24=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(66556008)(66476007)(6916009)(54906003)(64756008)(66446008)(2906002)(66946007)(91956017)(76116006)(316002)(41300700001)(9686003)(6512007)(53546011)(44832011)(71200400001)(6506007)(6486002)(5660300002)(26005)(83380400001)(86362001)(966005)(38070700005)(38100700002)(8936002)(122000001)(8676002)(33716001)(4326008)(478600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+wlrWiHKe45x7vu7gNAni4SfXTav95aeeoilg+jdYo7XNfGqEe2+FmuHIKL?=
 =?us-ascii?Q?1dHl38RGvrvosaeyiJ07UyRNkp6DypLE9fBPcnGuJOwBmKJtsunhuSYtn3qD?=
 =?us-ascii?Q?uS5O14o4MCBaedgtziB8jU0/KzQfpVU0Y5PxoE5TULIyaNSimVAymjm8kcyp?=
 =?us-ascii?Q?+dhO+INgW2sZD99hnBgSYXBnx4Yq01FyQGHmgq7BjtUvAq0l9LOB/qpOKlns?=
 =?us-ascii?Q?5EIYqd8T2JxP//8AqFEhoCkPNcVkKUDfEC4bl7wdmtLvWKlihUqtiIAvdccw?=
 =?us-ascii?Q?ZakCvR7reP1gIdedO3aJwyvb0hZTo2roUTrBogueX8rx2fOjgWIxAF0KV91X?=
 =?us-ascii?Q?LBBdkURmwXO4vijRpMXcNnBjIDl25dXPADUnwBIyuxqgl4zA8hZuzKgvWpV/?=
 =?us-ascii?Q?E2HnAZT7s7VfQiLu8qIvAU2lK/t4Cbnp4ZyhKQ0Eod7boAJ98CrB/49QOgTi?=
 =?us-ascii?Q?eLK65hrz4toa6QFrWZ/nJX2SM5hrWqh+xQVxli14tO1jb6JQXtCiD5OOszOQ?=
 =?us-ascii?Q?CCXrwuZenWzbEvUidRcj5YOLX2S/T6Tmmwae3cNQpRaCHp8VJifVBnKcH5vp?=
 =?us-ascii?Q?gBGHF05xiQTyHdVnw2OOz0dylrzXUEQFsVtps4BAPyt6OWvz7HsUqmun/sQi?=
 =?us-ascii?Q?v/q7Zv4C0qbmF1wvjUfowzn+DMz6TACtFXOjQ0iw5HPDHikfVAyki+ZkEQY7?=
 =?us-ascii?Q?wf3O76EroT4wSjh+WBRkXqSW3pwUvc4C/N8/vdIXDPNIf0FhlQIN34xmQnMj?=
 =?us-ascii?Q?cNrMPGYxSFTujTDIB+JMTZya7i6VMz4nFIWXnkgLX6nPhaj5UF5RGY2ylQld?=
 =?us-ascii?Q?cZmjG2C/qFQj6tnl2iJd0dZu8MEWiEW8Jml6e03xYohT8MV1+aNescp+uXOI?=
 =?us-ascii?Q?5w+pRwmtKjQ1Dx3DDq5slwQ/TRBQbQp4iZOl91/Ag2a3GUI2/fwxM9jqmGOU?=
 =?us-ascii?Q?9YHYSFXadSLFiVtmz5h2vHhntzId1IYuvlWLOCM0Co+vOQHlmuz6Rz1e3WTe?=
 =?us-ascii?Q?19sBZgGzpt0HN+ZNP3YiOJs3Z7kfaz7WMnxQeKA9xLMLr2Xo+MkYzd3IHEJX?=
 =?us-ascii?Q?TKQqDkrhJBFBpIAgwb0M46evQmqFwm/a8NC60tDCXrz4yAsrRx3z0GC661Cs?=
 =?us-ascii?Q?g2SSSmS0u6pjaW71U7xOAwDQaomaKruXfFuNL0solYWg/qX5bMmQBT3AB9jv?=
 =?us-ascii?Q?Rc6oKA6QRjvEm6lv+x7WErNTmGXnRql0CusXL4siXErXgqYcghChy4sZN8cA?=
 =?us-ascii?Q?g56ADKo/Jy6Y1G7L9PWubt8Ynqn5dI1kV4RRdqGI+Ly+9dFkreHcVLdUj0vT?=
 =?us-ascii?Q?9gcQ/HUQA8tcMTSNp0Sidfz0SrBFTodxjMvRXlBqykE81/9GN60GfrXdrYBF?=
 =?us-ascii?Q?h/MiHkOrzyPVuGJHcfQyewqSnXlYEZ0g7qJZh0q+vJ8Bg//vuGAN3Tglo9Mp?=
 =?us-ascii?Q?n4xnBe6sR21Y0G3JU+OrTixvaFCP7a57W4SGcNwMOIm5VoX1UqWbbwH/XlNc?=
 =?us-ascii?Q?7VdCXq4e65rRdxmfDDgies3cl1ChC2rGAYO4dL0RCBULISF47nbC/VIgbKmE?=
 =?us-ascii?Q?/fHu5/63GZkVFAp0HhrX5RlXSrwYNRwuVCVcT9e1yCwJrIXoZgdyL3H4umjk?=
 =?us-ascii?Q?MQEiULSXsh3cKD1OSz4su40=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E1FE76385F7D94EADAD6CFE95378B17@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KO+bkUkJIBEzUSTlYMVCob9omuX4a7JX2crnDQGAzR87rb7ZJ8IAkgwL+N9r?=
 =?us-ascii?Q?M7UXEPSeFzFwnJCvVOu107mqvn9/BA/TiR4LtaI57U/z+BzJZhr/AxXghQk6?=
 =?us-ascii?Q?zpmrwLukIM+IcB3hSMk30EDPRydlNYL+pA3G12p6RgvVFpnwKfAfezVa6iIQ?=
 =?us-ascii?Q?B9zUI9+wak0Q7fZwwrB65C5+KRMCj4yXqeuReIt8UC6tdv5ipXxo8MBm3YAa?=
 =?us-ascii?Q?x50O9YQT9K+8ci/0CwFmA9apIJWfNsqE8Pb1oGwQlstaYLfG48rI/G9by/i7?=
 =?us-ascii?Q?BLdoAPKi9YzrDKjmX1VAA6S83/gsmxOZhRupJLd7xyofIruv1WYHcXYH9Bei?=
 =?us-ascii?Q?bv2a5XqkwkXgki4hQxnWzx0Lmop24q8Hl1egDTiH0EeCe7GuZ0OaKMF5b8v1?=
 =?us-ascii?Q?2Qk8osgPG2zeDqhVMPI25mxCJ8AjM976nOOmpr9HTLSnluUs2RWEMa4USeB0?=
 =?us-ascii?Q?EE0NptJT5+Y7MZUu3sGryt/SuFhlbpUywGAlF2tqRMrDDEQrQFnprmtKg6jn?=
 =?us-ascii?Q?DWulq2WpkgrEF/gVe8DJvUlHKAyn1O0K1azb5T2jNqsBun/QkG6m1MuDtjCk?=
 =?us-ascii?Q?KBjBrDQBcTPLXAi0fFJTjjaWXv7pFBxYO4mRc8MUagTqR0svv/R7iK8IF+Py?=
 =?us-ascii?Q?4xMBqtNKiA51jr1ZfAvyAK/WXUcJ2iQjQuEbhK1OQSTetHRwMOQnh8w078+8?=
 =?us-ascii?Q?XuQrnMdMKqAmunMD1Q4FLkCIIHwNv2wyIpuaYGyeb+hNQNGuFl+xwgzBW0rM?=
 =?us-ascii?Q?pEiFNocE3LEdSQHaPcpIluiKzyLYMlnz9JWURBPrxbZpV+scd5Dwb9U8RV5i?=
 =?us-ascii?Q?XMU4ep+/1539IXG0D4AvscLbrNj6Q4H+YA83jpXeeU9mZdjysJahLPl7WyLW?=
 =?us-ascii?Q?N4Yc8wilkqgOOmihnArcgOCb5kXlUhgk4E334NTxo8apHN+SqvMUU5/iJk4Y?=
 =?us-ascii?Q?ew/EFKPC3HbhHSwVcOFMPA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3a8454-c908-4d45-2d58-08dba8f71f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 01:19:14.0639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b51FMIyhx213bfMSM88jhfZCe+vpqpLDXK64g7WAmsuiWgUHSmdDdKO+IbkGSC4jCvSZ/n/2CKUabTiVPZRAdbqJ8Cv8jASVCmxjXhg+3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6303
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 29, 2023 / 06:35, Bart Van Assche wrote:
> On 8/28/23 19:11, Shinichiro Kawasaki wrote:
> > This is the unclear point for me. Does bash really pass the arguments l=
ist of
> > the caller to the callee when functions are called without arguments?
> >=20
> > Looking back the commit 852996fea4f1, you explained that bash does, and=
 I
> > agreed. But now in my environment bash doesn't. I tried the script belo=
w in my
> > environment, and see nothing printed.
> >=20
> >    funcA() { echo "$1" ; }
> >    funcB() { funcA; }
> >    funcB foo
> >=20
> > Then the arguments of funcB is not passed to funcA. How does it run in =
your
> > environment?
>=20
> I see the same result that you see. It seems that I misinterpret the text
> produced by shellcheck if it reports warning SC2119. After having reread
> https://github.com/koalaman/shellcheck/wiki/SC2119, I'm OK with
> suppressing warning SC2119 because that warning doesn't seem useful to
> me.

Thank you for confirmation. It's good that we clarified this confusing poin=
t :)
I will revert the 26664dff17b6 ("Do not suppress any shellcheck warnings") =
to
suppress SC2119.

Later on, I'll create a clean-up-patch for SC2119 which will revert relevan=
t
commits 852996fea4f1 and 45b203cce8b (partially for the latter).

Daniel, let's go ahead with current approach: allow calling _nvmet_target_s=
etup
without arguments.
