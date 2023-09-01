Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985478F668
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347944AbjIAAeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjIAAeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:34:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74504E4F;
        Thu, 31 Aug 2023 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693528441; x=1725064441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uLDpYtegQrGofo08t+tmP0UTGXIY74L56c07XcHHjkw=;
  b=gZy1QRPtnpKP/m8XsoMvgjUsAMAYjle8G4N/LuZoZeYyeueLsLSj2X2N
   n8ZFQ8uD02lgMDcz1vxwkVO/bc4VtcFtA8mIkvcRwQbPfrqCj1ylo+TK4
   M6PtvCpoaF55auAdyPi+4NrOBnCv/lDGi7Q4cuk19Mbm2zLUg+9hovfqY
   NTm7uuyf++oIyQ4r8qLEMmPgHcrQ//mdz5R3jcxOyoadcII4al0t73BCv
   C2npgUp5AzFnkJmxEUDQQMwAmKn8zcRXxL37x3wBwe331IxAbpkFWqiVl
   1cuFdooobn29/QqKKxVpCUweKBCQy5BhibtmNa1VqQz5TWadkmbjeMlG7
   A==;
X-IronPort-AV: E=Sophos;i="6.02,218,1688400000"; 
   d="scan'208";a="347916363"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2023 08:34:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+JqpPeeH5eiJWQLi67X3aJq4xojeBTMAUIpvhYzFP5o9QgpeZ4wkZSiATJYGPv9S8B/zhbjMMhRIgjehGoUHyOXDuqxUla1zy2cnrNsS4FiwjF/guZljXLUYlQapU/lRUHmebD3T1k/ukQRUDCjUwtDaMOtsUS1l8vHPtJzdSt1EgMsoBGvRphAz/ddU9+VvBod9gGmB2Zvt5CfWpxj2rlNxTkN+3p05lHEs8WG4i1Rw9N1s3tgJrxXXEGcV2cj4raeIuMd+cyHlN9BZ4jZ6Ew8eNgFjEam8qKfYNh3WxW+HlCUSMEkjltl6zQw+P2ZUmY9UnR4XUDtDbhLO9xAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLDpYtegQrGofo08t+tmP0UTGXIY74L56c07XcHHjkw=;
 b=hmWf/tMTmP/jmN+YGIv1AHU/KNtqZrL44QGQPzaff5x06Sfdto+d+bbnEbV5QouM8+e92XmoaNLhaDETvfHFq5J9nl+/IsTXu9lrHYmvzCS9LpGar5U+ecKhM5vd77JEoCNjQWYkxmgYeCLBmWBis03PllbnUbwc6hS+gqn4RqCi6wFcWiu3kEjQmj+ihDFM++EVu6tPG7uGwBpWK0mIHTZl1Km/7s2FWnIL7fRkusCbuI9OXU8QDptohK1IOzjbkyIZsEq5X5W1YQs9Bu4LaPgFCHRJxOv/eqTKxSRFMyGWgelE9qenxxNunG6omiD1mDRgx1TJ348Xx6tHXuFqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLDpYtegQrGofo08t+tmP0UTGXIY74L56c07XcHHjkw=;
 b=nkfojBcEbE/77oWDaTMNHeFxU3P14UFgLJOHtdcK69RZKbDHxmemTYlZ40aMyuHeO2W40t/0xld27eUI0rNP8l8Fz0vlkHHPvVy2MNBTcMTJyO/7cUsHQ9GOt16BLTy5vXZQlkmm1yoU88Hly2le3mv8xliPRoz2/htsZDgNqvM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8746.namprd04.prod.outlook.com (2603:10b6:806:2f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.12; Fri, 1 Sep
 2023 00:33:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6768.009; Fri, 1 Sep 2023
 00:33:58 +0000
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
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsAgAC/9QCAAKx0AIAAYPoAgAAPCACAAGeugIAAC3qAgAAnFQCAA+SfgIAAuLaAgAAeDwCAAB+MgIAAed2AgAC/TQCAAMSCAIADF/eA
Date:   Fri, 1 Sep 2023 00:33:58 +0000
Message-ID: <6vka4vpos4eq6li4lq67ifggdygi3v4cch3u5vnpxw24bx73vu@p4uxhgiip4co>
References: <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
 <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
 <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
 <3b5b246f-386d-4afe-a20d-4b08770bd4cb@acm.org>
 <o5xnqvujzakhrudv7p64owiuzgozmean6blxow4vdxhdqozg5v@qznf2tzmey7k>
In-Reply-To: <o5xnqvujzakhrudv7p64owiuzgozmean6blxow4vdxhdqozg5v@qznf2tzmey7k>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8746:EE_
x-ms-office365-filtering-correlation-id: bf92da36-74ca-4587-5008-08dbaa8321d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Zewm1mDISvrIqn3TCLY7AHHPOiDOc28L8H/Ev+TVwI26YCh+0hAjsZGwNT+OtI0OdqjYWlzIbtoNnX8UxgHEoTiu/A7gJTE953SEjdsn2TkVrVHr/xw+6GMRm53ZD2fZ/qYNEuDZZ+EhBG5znQUsprcNGFLzTR6ZUei2Wtp1ZG/H3Qxmy/wkf2ZUxMxz+J2i6W54TNh7BT7p3yNCO9RCHbpAjb0Jrqf/Eqtki2mcduCLefO8ToPdZwkxLwmhIATMVJQZowE1Tf4kZ34OnIZBUsu4gt0D1kBDMIeOn7Lc1bW0LxYoGqNX2oq/2NMxSez1HIUeShLHPbD8B3j+uizh+J/qqYDKD4JyCfnwKgb1zeG5hoo9X/ZyJfFaZKyS9fQWU+ERg/Q437+JBeSuH1PhpYqZu0sPBDYQXGtGDEVUHvdwVxmAA6GJXbq6ksV7oCQtJ8yV92WAH8ljFFNfoF1ghWTFSsbW7cTv+Lxq9zq66GskXx/QpR/ge8uCoxnSiYnybe7MFsQBtb7ig2Tm7vj4ql8O37Ca7wCOc5MsFjzW2m+6Q0weTdWvfZ4uilHZJWOD2myJ/RKJKlP364c+hxpqjfnHkm4V5DR4AVhBsJdCWu/tVVNOFC8Jq1TNPY8D/xV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(366004)(396003)(376002)(1800799009)(186009)(451199024)(316002)(6916009)(64756008)(76116006)(66476007)(66446008)(66946007)(54906003)(91956017)(66556008)(8936002)(4326008)(8676002)(122000001)(6512007)(6486002)(6506007)(41300700001)(9686003)(26005)(44832011)(5660300002)(83380400001)(71200400001)(478600001)(4744005)(2906002)(38070700005)(38100700002)(33716001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+s4hrhgvN2Jt3soFl126fTj5mIy71Xhu5sKi7Pq2wB3k/4ePGpAJ/8IshB2/?=
 =?us-ascii?Q?mOYGz3nNugj8qJAnq4CCUVFjouNDvShCJjB84jmwPj8rgpfVxzOVPHcg1/hE?=
 =?us-ascii?Q?VDlwbupzRjykFT5fFPptd/GJb62B5DEOg8rJXk9U14vJ77eYTchT+60A333/?=
 =?us-ascii?Q?iONJWwRJqMVhysGLBD50OV/XMD5QriMjb4rF0EW/P1LaSw3uazOr9d06rF8A?=
 =?us-ascii?Q?AfNkjKKGvjta8FUEhTsPHBRRQ6DluSEaGrlFBJXoq/rcsdEozWtXxAZQ5MrD?=
 =?us-ascii?Q?S1t0p7hJNWiAHuM5p/zyH/5/hUS54QNH/ckyJeTsFDwC8xhQ7/D8CxvUDJ/q?=
 =?us-ascii?Q?QP0qDCV/g3Rc2jfYpl4UuZdttiZds8/wmQW/nl8MYSeSspnjfMalK5lyjfTS?=
 =?us-ascii?Q?Bb4S9PI1msPeUSSkuSU+bmEXyFNOXzXadeekZyhlFGOwhplSzkSXQQMRvhiK?=
 =?us-ascii?Q?Yh6kvDyajHEkMaxgtTh2kTym/EU0ZHCvGmeCNjUvZP5adp1F70Skoh0LQn2X?=
 =?us-ascii?Q?SX4M6ZhlE+q5dLn+nZgmJjEVy7Z3x/iZS/4k0h2Z9jTQoSMznsulbUgeZ0nq?=
 =?us-ascii?Q?J3bp6nkHGvcdhb4t9fSu9H4BwUtvlYsqkwTUxlUKQhy+iGMFU3RJ+cfa+ipJ?=
 =?us-ascii?Q?Rk6q+XpF3ZMRNEJrBVLBTDVpaHrGLl1cuyGXw3eFRZww8ewM8yNKKYvcLpTv?=
 =?us-ascii?Q?LKD6SLr0EsupM73pIfUiYvMmAHLd+4awcJzhtJHcJd5X4qvUwo6nsoUm+bwh?=
 =?us-ascii?Q?k2sMksi1jgA0KkZa1Iw+j69aQ6HHlRVwKgZddftBKeReoQxfw8G6pk+9SZE4?=
 =?us-ascii?Q?nu+EF6dDgi8TAeefunlrezpXiD+UMYqXBzb2gmCL0nSvEw6LYzKnG1fcWIpC?=
 =?us-ascii?Q?U5dd7oMxMTHFL98FLwPgVMkG8u0Z7aWMeimT8C9APPcoeazMRDTww4LENfI1?=
 =?us-ascii?Q?05A8pSZRSn3DBFKivrn+sda+cq3PXg1HcKptnthLdYN8xeBRrTeT2EhtUROO?=
 =?us-ascii?Q?cvgETB6Nm5DqvNmf2lLxsZTCrvuMMoT5NEGP+5r+2Vuu8nZmAkxxbKfC65pO?=
 =?us-ascii?Q?7+EvkW/ZduUW0pVjjB1/Oy0XrgPZXWvhPMrxRGJwZG+NQbN9mJlrJYDliLmS?=
 =?us-ascii?Q?RGdHeMsc1xUzcnMavO2+KYL2N/fn1hyK8ASFqp9NqqO+T6H709ej34gZamcw?=
 =?us-ascii?Q?27ysCaWmSxLRHB61u3AzubGy2zAQTCFW6wTRED3c1Q5ukeA/ugDqQJbLmpBj?=
 =?us-ascii?Q?BfNOcnugBUb9jMkCkJHLycj83ZycR+2K9wY5bgKzTquDOH6r3TUYBdRGoIbj?=
 =?us-ascii?Q?1yKBcXz+9diFaFpV5g51JDwmDs3R3udaVsJSIp4N65ScLzJS9ZUyZLXmAxAK?=
 =?us-ascii?Q?P5pH/qJzocH2XJfpl8tYOr+VemdDulJsyecl0c29GsetlhJK2dDdBbg+Rz6k?=
 =?us-ascii?Q?wld1hjqoR80hos2BgcUFnrbQyCl47N3Pek1n+5/W74YOLBSllQIMZZOiE0MZ?=
 =?us-ascii?Q?XUdw4TelNVumnnrulVfpI28TQkd/7WEeQnR2xCL0KuPMv2iZOCUqHIeVIHer?=
 =?us-ascii?Q?ErFNo+WKInw1aUZ2kYOyQ/AvXnXETs116N7oer0nR+/EjK49+WDBErYiXQup?=
 =?us-ascii?Q?I7nAEDX1C6iX0u3IyEw1SUM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F555F7A6C766A4A87DC462FAC2CF201@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uLYBqSET4g3e9mg2rMnzo/zMdA/dG+JATNgZu9cXqFpjJCPOm9VnXa5SDgm8?=
 =?us-ascii?Q?B9x8VT/BvkOC30NJ/BvKYpoqCHJmo7bKzlC1fs+7AZxstiwhBZQnvcygQLgn?=
 =?us-ascii?Q?kvz0JKIiDTa/0np+CeSgLUGnDdfHBLMLH3jfD65AII/I1q4zQSAEzSyMyRdI?=
 =?us-ascii?Q?827MVkr/pDTKmC1/mr0Pe22PmdayorqfThjpKztClXjBZk+uILX98B/F6n2U?=
 =?us-ascii?Q?HCdnRyydE/m0QMdIqhaMch8foPAS9/jSn54mGikur368rf8qJ7gywpeoVRG8?=
 =?us-ascii?Q?UTiyvb8erOnqM/d/RlgorhjCW/CwH2SnbMZOt+F1RV44UPL9GdEm9j1L/5rX?=
 =?us-ascii?Q?bbJyvfC15Npg2VH/PodpRe817orxLEvCyMn3uw11uIo0fHRrCtJUMThaqo/x?=
 =?us-ascii?Q?RSQ0SALwZ9jV6L9O+/0tGUEMW2PLR5R0CcDYXMf+/CparP2AQAJXFGDM0FqP?=
 =?us-ascii?Q?u9LkZNL4Xah34+qYFZs7rq93YjMh79DXwbNQz6Fa1T9uhMQSsmuNo+HMkDT8?=
 =?us-ascii?Q?Q09z+iV74KIN+278LDD/+IIhRkWCnX3NPKjt9yjJ1y1XzPMjiIHyNEXTwrQA?=
 =?us-ascii?Q?Ga1I95xSk3F7hLnNyFwzYcpyfFslhOLmFft0ADYjYsCUnos+h2CM3CT3xHCn?=
 =?us-ascii?Q?x8P0baVDrcxACSPDvrZbkpdzfwh+gvEtctC9a07psKHFn+K41eOipxDq4iCT?=
 =?us-ascii?Q?bxFcKR9bVjjxdiu7jwLxClioNIxTrCMy5dH4tk2FpQM69Vpg4fglTqCNCGXW?=
 =?us-ascii?Q?dCrzm/9fKiiCh1GdckOc32A07NIRBUchlyMosXpp/jxMxvypTFi+Cx2zDk2h?=
 =?us-ascii?Q?K/MigyyEfv+SDrw0Mo9FKTCJ6vC4/1pmqQ0i6RE65yzzqegfJB2h1RaFKpvV?=
 =?us-ascii?Q?t/fzhOhiHnZCjNlSJkeXzeADTdOZOLD1PirkBCwnKb3O1+aqkRAsH4VBLqUo?=
 =?us-ascii?Q?I5L1S0w0KCuQ9+mplILgkw=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf92da36-74ca-4587-5008-08dbaa8321d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 00:33:58.7741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXLkYgL56bJgDJbaaan97Zcbg8XPRc0yUN+vqP3hhR/qX9td8kQwCQsgepRPt3QQA718jha5Y1Kml98JoD60JeM3rFbBrntZpgSO1X/PgGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8746
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2023 / 01:19, Shinichiro Kawasaki wrote:
[...]
> Thank you for confirmation. It's good that we clarified this confusing po=
int :)
> I will revert the 26664dff17b6 ("Do not suppress any shellcheck warnings"=
) to
> suppress SC2119.

FYI, the commit 3d1c0fe2677d did the revert.

>=20
> Later on, I'll create a clean-up-patch for SC2119 which will revert relev=
ant
> commits 852996fea4f1 and 45b203cce8b (partially for the latter).

Also, I've applied the commit 2045e8d3df86 for the clean-up above. It shoul=
d be
all good now.=
