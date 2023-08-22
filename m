Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560BA783DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjHVKbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjHVKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:31:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D2E59;
        Tue, 22 Aug 2023 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692700225; x=1724236225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pwtLrY2yFbQ4mfSvNplbVi+axGrpFJcf0UCfMSIHTIc=;
  b=B1A67gFxcrqkJb30gnLvfkZAnQzHuk/OvPKFF708Sa7GAXJrckHkibnM
   zENNNQl1mU2XVnMq9e6voxKKcU4Eb/Vp3ZRz9lbzlchp/MpvRdBDBRHaa
   7tgpLze8bZXWUd6vYnn4QHGXyuo3B/8XINT+k7xGL1V6F7+UNIoEAHXSp
   xEzqDUG+7vnCTAnP5eEAiovPJ2k9HAnDbacv54LFov58o5/HtCi953uXg
   l0fbxbYA7AalIqPwXkM551yrtwBty4HAT6eGUHOFn/9tnVXNjuB1Luxvq
   OM0YvUan46IOymVYMGf7cEI0giIKnmjaXGcnPSEHfTdR070okzzzdrmK/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684771200"; 
   d="scan'208";a="246374988"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 18:30:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5g5l96Nfdg25FUqe0Hpx8YBIKP5mB9/OLkXXCsXEBa8Kvc+ti++dIPIiYeXzu8n3ahqpynrbKOvpHWtOrAEzM8ClaTuVn5+4pBiIB/5VstHJy7hAxZB3v8SYAPfurCxjqGa6DN5k13zMgqVLUCiJYCGadfDj5qjF4rloN1L2mTudy0NVaVyJ80u2Xi65wUNttFoJxs7kns6TJjipmHtDHo/EFoyi8RilsxR1JZAZGjsRJJ//XNF20toHLGOlOx3xzeyMCSdUKUeWF/3wmZ18FKXAaNHyRxAKAVdF80O3oxK8nl4pWcxiNR0qZSBEvOJ2ozJ5ZBEa387aoXLQo0Nug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwtLrY2yFbQ4mfSvNplbVi+axGrpFJcf0UCfMSIHTIc=;
 b=dmoF9wq6pGqmbv8Ol8HH7RRC6G6QPNqn+52Bkz+zfJdT/JLK4ftcXeSsUrqlry2Z5XJ/iYZZBWxRcMgawgSIN8WPwMTrVn2X+bLg70dtdmprbJl5UylV4TzrlpCNAGP55fJk8ROn8YUjM9r9Xows51CAozI2YjWLgUepg3WBDOeQtbxhbIWApwQnCG7T69dIfbd6FJazeHktewCgsCYxBAdr1PUP/4iiZvNqS6QONr8YUaBXJ2mPW622Yfj5vRxF1ZhrxtyZhrdZk+E40CFc99ZP5jyGoq1Ld2w1xC/BVyuQTaF91a7QRrgiHkTHEMpOT8/zO2j6akKtDhlrQKkcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwtLrY2yFbQ4mfSvNplbVi+axGrpFJcf0UCfMSIHTIc=;
 b=fMOjvaDtakDIzwKS8P6d67iCZdsRMTxBffE/O9u4FPuNr4KdcNNiq6CTmueZB3SNYESXaWnjcZL9ClEEj5Ou/Xuue3TQNErXDjhz0akiAcYGuldGDbeJR3Yp8Jmf07vFE6/+nkBwAgKCMZpeJ9jWNYJCKbc87xe20b8kkq61sOA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN0PR04MB8144.namprd04.prod.outlook.com (2603:10b6:408:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Tue, 22 Aug
 2023 10:30:14 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 10:30:14 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Li Nan <linan666@huaweicloud.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Thread-Topic: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Thread-Index: AQHZ1DaPr2epsK7l90GFuVSrpD3hoq/2C2CAgAATd4A=
Date:   Tue, 22 Aug 2023 10:30:14 +0000
Message-ID: <ZOSONbLwc6RtQnS0@x1-carbon>
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <ZONr0f26IT/QKsSu@x1-carbon>
 <f33816ef-ce26-1501-99b6-c75f91c6d8f5@huaweicloud.com>
In-Reply-To: <f33816ef-ce26-1501-99b6-c75f91c6d8f5@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN0PR04MB8144:EE_
x-ms-office365-filtering-correlation-id: 27b34ee4-033a-4c0f-0dff-08dba2fac59a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQpZcms+rMhKroOH+woo0EcfNueeoYTslRPgEaNepDyM7K1ixnmtFlZ859zDfqTZu3kZ6QfwFfWNFmqK2bYLrvivwVETSAcjy+5Y8fngO/JAWp/YTIwNILPgFJ3+Pq2927mIDCmqVGRRxCDh94USYaxBPD0f9Y7w7hUww/l0eZUwBuovtQWIk4RwCwgwlgZUs0DfoQL+EjLnIkpa9H9KrzCweS0SyQu5AzgWHLeKwVx7wCywT422rCKzt9z4LUD/xqMwMOKtoxHnMpUj5GsrDfD/ZtmeEcbyRV/kPrfbW6CdbUsmGxCaqATe3A0vL83ImYfTaYIAuIHsD0lBsNltW3dsEtimHa/KtmSo2PJQTha69vWB3f3JMx1yUeYIewVdix7S5Au1viOnwn/zmWRZ/wVMyK4DdYtOPxWt49MKj3jRcnChj7twLlZaGVyYSaPJfipvdrVSPQdycajyfKCxdmQfUma9I6D/SsunzREdRqD52Tz+1IYaDV7LJeA3g7Enkw2KSghW4WdA0jygt8KI0IyZGnf+tTgjIg2qGePPP2PLS5YtbRIYRZRoyzi6G6bMnHlRfOXQAt279bDguwdam4C95M6YmLW9+uMl1aOKfB1buRUYcoEbTgoJ15BEsTOBrTazbPFITe5eSr8uzIxE/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(1800799009)(186009)(76116006)(66446008)(83380400001)(2906002)(66476007)(71200400001)(66946007)(6506007)(6486002)(6916009)(9686003)(66556008)(64756008)(8676002)(5660300002)(26005)(91956017)(8936002)(4326008)(478600001)(966005)(41300700001)(316002)(54906003)(6512007)(86362001)(38070700005)(122000001)(82960400001)(33716001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVdGemxvaUZHL1ZSQUpsZFJrRXM3eE9GR21aMWhGVXRwaEJSanFtOVVMaWdn?=
 =?utf-8?B?TVdKWGkyMEVhZ0JBbmQvVGVtYnpTZWYveGlkNTY2dkV6ZUVlSS94OUd6MnNN?=
 =?utf-8?B?bEFVVDRoVThyLzAwT1NxR1VpOTJwWDhqV0hSM1NmQjFMUFRjVXYwcVJMVXZj?=
 =?utf-8?B?UGY3VGE3bDc2bmIzcDUwbk5rcU9uNUN5RzExZWI1SEZWN2FqRUV3ZzE5bmI3?=
 =?utf-8?B?NjYzb0YzRXYyNGJyTmx3QzVsdnY0RW05YWY2VFZlVkhFS2VMQ1M5U2lmS2ln?=
 =?utf-8?B?NlNBYmNFSmZ3cFlPRlcrKzJkRnNaNENtUHpxRk1xR1NCbEVNS1JEVFp5OVhE?=
 =?utf-8?B?ZmJQbmxubTU4UitQMDhUa3pLWDBvdmlCSTlCZ3lyRFFtY1ZJZXB4cy9tK1dX?=
 =?utf-8?B?VTBFQ2JHM1dLWGd3ZHZSWDNGa1pxSGZXVTJaV1R2KzNJTVFBOUt0aStuekFu?=
 =?utf-8?B?RGJyNFNTMERsMXhDSmZCc0JFWFhYbVQzZkdlWmxoc2hoSDVCZWNiWTNEa3hC?=
 =?utf-8?B?bmxoa0MrSlJQS3BBNTdIWlloSTc2RkhEc1hrbjZOZWdOdnFkeExuSy9xOWdy?=
 =?utf-8?B?amxwTUVzRWpOcDBXZ2lCQzQzb2RSN2lRWURMMUZJTFJGNm8wMHk4alNzOURV?=
 =?utf-8?B?akVTTHRFZVZReGJxd3liUnB4cTl4WEVGN1lhZ3FuSWJ4VEE5dkFacm11Z2xQ?=
 =?utf-8?B?NzYxU2U3Wjc4YTJBMitoYzhYbWpOTDlKb3VTT3VGOWU3WlFIakpwM1NnbzFU?=
 =?utf-8?B?bUVrSlRCT2tOckY5Nnc2KytnM3ZweDJudmlkT2x6cG1QUS9XNG1oVVZjRGps?=
 =?utf-8?B?emxCbW5vWHdkM3A3TzlEY09XK3VCQTBRallNNi9ZanRubTBRNjZHVW5oMy9t?=
 =?utf-8?B?bXJROUJSa01kK2tXNnhTbjZQWE5IbjR4d0tZSTcyZTFSV1BpUlpFMVpKZkRM?=
 =?utf-8?B?ajk0LzE2UDIrRC9vUXNDbU1UcldwamdrbmFYZHY1SGovUncvOHpXZWlTbVly?=
 =?utf-8?B?Z2Fyc0xBa1B5allSV3p5SUM5WFlXQ2RzQ0lxNzBMOGFWU0pySG04eFZWSTVm?=
 =?utf-8?B?YVE5U2dtZzBNenBMcmM0MkIzVnB2ZS9ZMWY3Y0MyL255M1hlOGNYSllSS2ox?=
 =?utf-8?B?Y0JDc1pZeTBRdHZ0azVOV3dQWk9uRjM1bFY1amttazU2WTdUMmJOYWpWa3BB?=
 =?utf-8?B?VlJ2dnU5d2dTZkVXZk9FcCtJa3pBVy9LMGQvMDcyOUZhalJSZzVjN1RrRjNS?=
 =?utf-8?B?SUV5NDNYbXNsYjF6SGhTN2FqVDBOekY4eUhzMWxTcEFSZGs3NXA3aE85NkFK?=
 =?utf-8?B?ZlM0MUwrRFI3WjhQR0xQbHc1U2hDVVBvbHI1Z256YjVicVk2T3V1REduSjdB?=
 =?utf-8?B?VUpCanY0d3FIZU5QSkxCQVdkaXJ0SS9KY2szUmFCRTVaUk9na3FjM3lCSXU4?=
 =?utf-8?B?UDdwbVYrSnphU2M3eGhYaGNCaFVESlpzdlVPNDExNGpWeFV0UDdVTnRXNEps?=
 =?utf-8?B?UjhGdHBKVWN6T2dpLzlValZKTFJhZFNuZ3lFOXE5WWtWb0ZMazFnMDhMMlNW?=
 =?utf-8?B?Wm5LWjUra1JYV3ZZckxYQTd6Ym9aWnFkRG81UmNzdmhqdWRab2d4emtzdFRD?=
 =?utf-8?B?UXR4eEJ1Zm5PZ2g3OGNXckwxa3lKNUR6cHl2bmZlSmJSV25CZWVQcnBzRlpY?=
 =?utf-8?B?Q1VNeThBbTJHU0MwZENNQk9lcnF2QXRQdkVOd0VRcVBPeThDOElENWdzTkJC?=
 =?utf-8?B?clBOb3I0akQyRVVCNVhwSFdqWmtSL2sreEV5L1UrblZ1NVVNN1hnd0pBdExa?=
 =?utf-8?B?cVh3TDNzZmZiSUtiSW92eGEwdkxZOGxEVmxFY0tLL3FDKzVBTDRyWWRRVjBt?=
 =?utf-8?B?OGZhRDM5NjdJYmJ1MjRmRERMOVhEY1hVc1UwK2gwM0xYRGcxeC9HaGZ6OEVS?=
 =?utf-8?B?a2JtRlVDN3VMVDNPNmx1RTQvd0sxbUJZZkhuOStTYlZTeWNUbUNUTmV6d29t?=
 =?utf-8?B?M01idzB5UDd2MWFha1Fsank5RnY2c1dlMnBFSXlqR1I0WVJDU1lGZXR1OVhp?=
 =?utf-8?B?bnRQY0txSDVxblR1WGh2UkZmRUVqMWJud2J2QnMyL05ncjJsV2kyTFdoejBn?=
 =?utf-8?B?ZkNHTnNTeThtMzVNallXUVJkZVlNdnFmdkc1NnU2WEJRNXY4ZThNMkgvQW5B?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D9360F0405FDB4B80FEBF6C03223668@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XRPrpfbkOoDNs9LGSV3NW60j8YSzH8qDSm+khsKe4CU/8XrnAxDLeGA+s/aWBDNi7DBXXdR1CzAT2Ip82ewLKl0YdjCxokMzcgKnYwrcZg7JSgEOWn9uPBYeNkuBwog59eEIfFi++pG0Wz9sDIm/pHE7DsHy7kyVevJJsSkfEDSEdrMTvgPK5fJEambHLI/tqoadZE8+UE11GaHc0Qz+P2IVR87KrcQE8xhot48VPpy00rrrunZljDWgjGfVWnKu2h8Wt0MAU7jf2FJcm1Kp50oTpjZPkqvm0rkzX0ts9nWfISpr5IFBX/lQJSYy9NFTxVatEXswrfhbulBd5ImLrqTKRRfVJXRqKmzwZDe2j1HeOKWbJ0ALBiGD13g1Tistn5aUVpDfoGgkLiJWkMA/z1Bn8lKox/X0mOYuFwtuXJiGmLWKUUbKJLmfYbP+hSjvX00GxJaX9b5FN0ymb47FhhL6x10scbpwmO8c4yIZlSCjPPQe9D+STaDlc5DwxKNglOOK/jC+ktq3xoYsLPw/weRxa0b2gOKef+38PTOM5+TYuIRj2AuNYeuvV7rCsK0UkTmNfgq2VCdIdWENoCcF1w+8MvKJwP7VQujJPf+jly21Tm/RCz88rwvZ9+Vz+G+WnFfgcpfVDoj5Z5PdNUbA3VDxtfUyUYf+4HjKhSv/kSsEWXQ4J3xUO1J6dXFdKlViF1XQdA9PqcgkjFemq8pFeMSYDxJb3kqKMFTKqCxIbVsa63r4+lhabq57eEhrYeqP2dvtGf4A1a5TZ17jH4H/qV86uHKm+Q9aRFoafgcLoXegPww48a/QvBr2WXhnOdsyit8bbDqswQeRUfH3iNnOwGBssjzRAdeIAzcPBvRqe+hm/QIvkh6J4qNXZW5Tp72y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b34ee4-033a-4c0f-0dff-08dba2fac59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 10:30:14.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUdYeiR3nBVoxijvdeTfaJLHihzgL9mr3mdgLjWa9TPqK1XhSKmCEpMwV3rPh4qb8rCYfRT+v6sOxjkRyYCYJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMjIsIDIwMjMgYXQgMDU6MjA6MzNQTSArMDgwMCwgTGkgTmFuIHdyb3RlOg0K
PiBUaGFua3MgZm9yIHlvdXIgcmVwbHksIE5pa2xhcy4NCj4gDQo+IOWcqCAyMDIzLzgvMjEgMjE6
NTEsIE5pa2xhcyBDYXNzZWwg5YaZ6YGTOg0KPiA+IE9uIFRodSwgQXVnIDEwLCAyMDIzIGF0IDA5
OjQ4OjQ4QU0gKzA4MDAsIGxpbmFuNjY2QGh1YXdlaWNsb3VkLmNvbSB3cm90ZToNCj4gDQo+IFtz
bmlwXQ0KPiANCj4gPiANCj4gPiBIZWxsbyBMaSBOYW4sDQo+ID4gDQo+ID4gSSBkbyBub3QgdW5k
ZXJzdGFuZCB3aHkgdGhlIGNvZGUgaW46DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRz
L2xpbnV4L2Jsb2IvdjYuNS1yYzcvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMjTDcyMi1MNzMxDQo+
ID4gDQo+ID4gZG9lcyBub3Qga2ljayBpbiwgYW5kIHJlcGVhdHMgRUguDQo+ID4gDQo+ID4gDQo+
ID4gRUhfUEVORElORyBpcyBjbGVhcmVkIGJlZm9yZSAtPmVycm9yX2hhbmRsZXIoKSBpcyBjYWxs
ZWQ6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvdjYuNS1yYzcv
ZHJpdmVycy9hdGEvbGliYXRhLWVoLmMjTDY5Nw0KPiA+IA0KPiA+IFNvIGFoY2lfZXJyb3JfaW50
cigpIGZyb20gdGhlIHNlY29uZCBlcnJvciBpbnRlcnJ1cHQsIHdoaWNoIGlzIGNhbGxlZCBhZnRl
cg0KPiA+IHRoYXdpbmcgdGhlIHBvcnQsIHNob3VsZCBoYXZlIGNhbGxlZCBhdGFfc3RkX3NjaGVk
X2VoKCksIHdoaWNoIGNhbGxzDQo+ID4gYXRhX2VoX3NldF9wZW5kaW5nKCksIHdoaWNoIHNob3Vs
ZCBoYXZlIHNldCBFSF9QRU5ESU5HOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9s
aW51eC9ibG9iL3Y2LjUtcmM3L2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jI0w4ODQNCj4gPiANCj4g
PiANCj4gPiANCj4gPiBNeSBvbmx5IGd1ZXNzIGlzIHRoYXQgYWZ0ZXIgdGhhd2luZyB0aGUgcG9y
dDoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi92Ni41LXJjNy9k
cml2ZXJzL2F0YS9saWJhdGEtZWguYyNMMjgwNw0KPiA+IA0KPiA+IFRoZSBzZWNvbmQgZXJyb3Ig
aXJxIGNvbWVzLCBhbmQgc2V0cyBFSF9QRU5ESU5HLA0KPiA+IGJ1dCB0aGVuIHRoaXMgc2lsbHkg
Y29kZSBtaWdodCBjbGVhciBpdDoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGlu
dXgvYmxvYi92Ni41LXJjNy9kcml2ZXJzL2F0YS9saWJhdGEtZWguYyNMMjgyNS1MMjgzNw0KPiA+
IA0KPiANCj4gWWVhaCwgSSB0aGluayBzby4NCj4gDQo+ID4gSSB0aGluayB0aGUgYmVzdCB3YXkg
d291bGQgYmUgaWYgd2UgY291bGQgaW1wcm92ZSB0aGlzICJzcHVyaW91cyBlcnJvcg0KPiA+IGNv
bmRpdGlvbiBjaGVjayIuLi4gYmVjYXVzZSBpZiB0aGlzIGlzIGluZGVlZCB0aGUgY29kZSB0aGF0
IGNsZWFycyBFSF9QRU5ESU5HDQo+ID4gZm9yIHlvdSwgdGhlbiB0aGlzIGNvZGUgYmFzaWNhbGx5
IG1ha2VzIHRoZSAiZ290byByZXBlYXQiIGNvZGUgaW4NCj4gPiBhdGFfc2NzaV9wb3J0X2Vycm9y
X2hhbmRsZXIoKSB1c2VsZXNzLi4uDQo+ID4gDQo+ID4gDQo+ID4gQW4gYWx0ZXJuYXRpdmUgdG8g
aW1wcm92aW5nIHRoZSAic3B1cmlvdXMgZXJyb3IgY29uZGl0aW9uIGNoZWNrIiBtaWdodCBiZSBm
b3INCj4gPiB5b3UgdG8gdHJ5IHNvbWV0aGluZyBsaWtlOg0KPiA+IA0KPiANCj4gV2UgaGF2ZSB1
c2VkIHRoaXMgc29sdXRpb24gYmVmb3JlLCBidXQgaXQgd2lsbCBjYXNlIFdBUk5fT04gaW4NCj4g
YXRhX2VoX2ZpbmlzaCgpIGFzIGJlbG93Og0KPiANCj4gICBXQVJOSU5HOiBDUFU6IDEgUElEOiAx
MTggYXQgLi4vZHJpdmVycy9hdGEvbGliYXRhLWVoLmM6NDAxNg0KPiBhdGFfZWhfZmluaXNoKzB4
MTVhLzB4MTcwDQoNCk9rLg0KDQpIb3cgYWJvdXQgaWYgeW91IHNpbXBseSBtb3ZlIHRoZSBXQVJO
X09OIHRvIGF0YV9zY3NpX3BvcnRfZXJyb3JfaGFuZGxlcigpDQphcyB3ZWxsOg0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMgYi9kcml2ZXJzL2F0YS9saWJhdGEtZWguYw0K
aW5kZXggMzVlMDM2NzliMGJmLi41YmUyZmM2NTExMzEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2F0
YS9saWJhdGEtZWguYw0KKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMNCkBAIC03NDEsNiAr
NzQxLDEyIEBAIHZvaWQgYXRhX3Njc2lfcG9ydF9lcnJvcl9oYW5kbGVyKHN0cnVjdCBTY3NpX0hv
c3QgKmhvc3QsIHN0cnVjdCBhdGFfcG9ydCAqYXApDQogICAgICAgICAgICAgICAgICovDQogICAg
ICAgICAgICAgICAgYXAtPm9wcy0+ZW5kX2VoKGFwKTsNCiANCisgICAgICAgICAgICAgICBpZiAo
IWFwLT5zY3NpX2hvc3QtPmhvc3RfZWhfc2NoZWR1bGVkKSB7DQorICAgICAgICAgICAgICAgICAg
ICAgICAvKiBtYWtlIHN1cmUgbnJfYWN0aXZlX2xpbmtzIGlzIHplcm8gYWZ0ZXIgRUggKi8NCisg
ICAgICAgICAgICAgICAgICAgICAgIFdBUk5fT04oYXAtPm5yX2FjdGl2ZV9saW5rcyk7DQorICAg
ICAgICAgICAgICAgICAgICAgICBhcC0+bnJfYWN0aXZlX2xpbmtzID0gMDsNCisgICAgICAgICAg
ICAgICB9DQorDQogICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShhcC0+bG9j
aywgZmxhZ3MpOw0KICAgICAgICAgICAgICAgIGF0YV9laF9yZWxlYXNlKGFwKTsNCiAgICAgICAg
fSBlbHNlIHsNCkBAIC05NjIsNyArOTY4LDcgQEAgdm9pZCBhdGFfc3RkX2VuZF9laChzdHJ1Y3Qg
YXRhX3BvcnQgKmFwKQ0KIHsNCiAgICAgICAgc3RydWN0IFNjc2lfSG9zdCAqaG9zdCA9IGFwLT5z
Y3NpX2hvc3Q7DQogDQotICAgICAgIGhvc3QtPmhvc3RfZWhfc2NoZWR1bGVkID0gMDsNCisgICAg
ICAgaG9zdC0+aG9zdF9laF9zY2hlZHVsZWQtLTsNCiB9DQogRVhQT1JUX1NZTUJPTChhdGFfc3Rk
X2VuZF9laCk7DQogDQpAQCAtMzk0OCwxMCArMzk1NCw2IEBAIHZvaWQgYXRhX2VoX2ZpbmlzaChz
dHJ1Y3QgYXRhX3BvcnQgKmFwKQ0KICAgICAgICAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAg
ICAgICAgIH0NCiAgICAgICAgfQ0KLQ0KLSAgICAgICAvKiBtYWtlIHN1cmUgbnJfYWN0aXZlX2xp
bmtzIGlzIHplcm8gYWZ0ZXIgRUggKi8NCi0gICAgICAgV0FSTl9PTihhcC0+bnJfYWN0aXZlX2xp
bmtzKTsNCi0gICAgICAgYXAtPm5yX2FjdGl2ZV9saW5rcyA9IDA7DQogfQ0KIA0KIC8qKg0KDQoN
Cg0KS2luZCByZWdhcmRzLA0KTmlrbGFz
