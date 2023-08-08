Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1096D773E22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjHHQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjHHQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:24:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804144BD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:50:14 -0700 (PDT)
X-UUID: d8e4b8e435fc11ee9cb5633481061a41-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OiPbO3rF+CfVXHSxXFAV52USzmNtvdQVMsRETRR77vo=;
        b=s3eDzlgR2zjLkNstlgZXslgDWgDWebSiWNmeEoQfLj8S8dUt9gP2Vk4zD8xFDkVEfpgHeSMPsUj5CyzKnJHufmjyekZOkS4v8pMzPIVRE3uDILLPRHuyoZ4jq6eEtVLuxuA9iS0juRhlKZY2d5pgY/q9o0kerc27NojrNO/8Kbs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:5c80fc1e-5a9d-4553-b733-14b04035c3be,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:e77107a1-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d8e4b8e435fc11ee9cb5633481061a41-20230808
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1503624142; Tue, 08 Aug 2023 23:04:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 23:04:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 23:04:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU5pXD7g6PHYIfwxSTQIjM+KfKPPp8mwW8ppBkqXEAYhhwtBkPpPD2C1ViiuR5d6NpmOh08BDzXXj+7weiNCdfhMnWtociEUTG/dxUEieY/vRfK24o3uJrFypMLj9QfCVeQaG1ETdJMligx6DhNvTe30bYfgW24w3IwadgPc0QKDo/0o9zXqavNJmdRXMhmzTHXaeGoflHnt1HqTbalxOIWyOv13flbHFfoYwhcs0XAd2xPnC5Kfom9ZXrM8pBrLa4Q7OCUfTsaTKYObYDwoQ3jstqd3+hLV5cH59k8iwHKKl5HUzfyrLGTatYldqh4B+Ec/RxgRtt2W4P3zBAtZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiPbO3rF+CfVXHSxXFAV52USzmNtvdQVMsRETRR77vo=;
 b=INuggfBLAhpszqH5KPytCB3gjUhjFFsqoUWzEbF7YmTg8Jp7ZfheVG3R/hPcMy0EVthCs76tFD01YaA1lCU9Ye7ZXQvkj8C230VWYGF0RSpXAvgMD14y145tK90QgNXY6Xbbq5KZ4b3d6cvGhSUs8ar4jg/6AdDCGjaTQz2i86PpVb4xOzxcUk8e3KpUTDakzRJzJtyhbt+6HkB2+lH5P66lNz9nwNK5qp1vufMo6GtOgYh0ICFaGc7ABanDWDmjSNyiBqy0pJcJOt/TaEKTR683xuKUoqTgqbJjafxiPhYCRr472+w7vnlyReihkYAFD60om/JuIm30yCbH/C8vVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiPbO3rF+CfVXHSxXFAV52USzmNtvdQVMsRETRR77vo=;
 b=BY/hoqYHU8HYoJIJXLQYOu2203h/VJ5hL63vujgmZBgQ9dlL+osVUo6yBlyvIpcoSg/BSdqqCn8DH7LyNZIH+sc0crmSea61n5hXNfJ0A7CFIySwGg8Y5W5fjE9gZXfRLFgE7Zlm48VgZO35ai7UsgbjWxuFlGm1QIz+FFthPqQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7445.apcprd03.prod.outlook.com (2603:1096:990:19::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:04:13 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6652.028; Tue, 8 Aug 2023
 15:04:11 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Topic: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Index: AQHZye8xFsizTgWRg0G/DVBCFYkp76/gf00A
Date:   Tue, 8 Aug 2023 15:04:11 +0000
Message-ID: <a006a3d7d886e2aa34bfdd29cff0a4262d971440.camel@mediatek.com>
References: <20230807015110.30579-1-jason-jh.lin@mediatek.com>
         <20230807015110.30579-3-jason-jh.lin@mediatek.com>
         <02dc52cd-db64-af1c-0f07-5ef76b954c75@collabora.com>
In-Reply-To: <02dc52cd-db64-af1c-0f07-5ef76b954c75@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7445:EE_
x-ms-office365-filtering-correlation-id: d0064927-4e90-4b6b-cc15-08db9820b934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m665YS/j68wFyV5S9zHXsP37WSem3iLjsYDTGbDqcCZxqh/nQIFMK+bU6XaDb2hh3FQzm3UuaPxRP3gIBNMKpt7yXffFRbb6oJiuCBXCkdRSUpUzWhwPDfYfwCC+PUDyvsVhRTbaQivPwO0oIyDZtt80mdNeFfhuK19ADKRZwihDjyBWfUI4xdqhk8sdKDc56xOyiGvxN5KozIjEg54CxuH7aqRRsHGu6UQjJ4oQPxxUhKrcNlyVpr+i+ngUdQkd9vHyDDyT8DCJm7QhLq1lpKoOS8gw12O6DV6NhAxRJPZTgfCIfDZwX4c9rFKKCxQ8Y469wL5xpAsuC2a3PJdlDoEeUFNFPleFrjmvbqCAJ12gBlssAAiInVXqEy8Zk/v9CmIAB+kV7VWy2AM4PFNANLUFvi1fHdoQjYd8N0fhZLRW6KPQKFcE18Qba69h3NKznnVA9BK+YyRLZXgLhfPrMGf3hMwEQkIW1ksL8EQAPOPDmI8Ft2JhlblgG9EHWmvz/Jj6jrOra5e18AGP2xDDANyTPWYbnpatEPA30nepqkpNdQ3YUzia/nHNJWcSTGsQ/wnYx1d0kGdbGKVyEyZGgrRPlZGkFIUVK+NRNq2nfTobI+ZMl0shlxNUvctlXnGlqIvAfuYeJzHXGje1YE/RMBHPtVGztV0LdbRC8mUBXaXLKNhV7iksp3zBeq28CWXGHgGj6zTxKRkfuDglGPRdLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(396003)(376002)(186006)(1800799003)(451199021)(122000001)(478600001)(38100700002)(86362001)(54906003)(110136005)(4326008)(316002)(66556008)(66946007)(76116006)(64756008)(66476007)(66446008)(91956017)(71200400001)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(41300700001)(2906002)(83380400001)(85182001)(12101799016)(36756003)(38070700005)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmk3d2lYRjdDRWE0TUNCTjc2dkxLWVMyVU9IaC9wRDNPTHRFZmt3eitiV1Vt?=
 =?utf-8?B?YXZGQkRpZXZVZ0FzZjJJNXlJTGxjMTMrK2U5VUlFQWJsbzFIWUVJRW5ISmRV?=
 =?utf-8?B?c0h5TTROK0FpNXVKYnR2djVFb29UTVJiWVFzWTN3TWc1dXRuNlNCNi9zcVBI?=
 =?utf-8?B?bm8xdDd2UjVLQmcwZUdYK2hpY2diVGdQUEZ6UjFVRFlJU0hKWm1yTTNtbENO?=
 =?utf-8?B?bnB2VWhWdlJTQ1RnVXIzOWtqQzJrT1ZjRFZIZVd3QlBzbzduUCtvcER6RXlw?=
 =?utf-8?B?cXBhU2NOcHFLL0VKUmk0U0tsbmFuZjVWWWxSMVZVUUVVM1M2amt5ZkRJckRj?=
 =?utf-8?B?UWRQRmVmWFBQVHcwUzkwd0xOc1Z6M2Jld1BzZGFUbWVsV3hyWUpkOFBIeVY5?=
 =?utf-8?B?NHdoNGxWUk1hOTZCOUE5azd1SmhiMlh2enB5RXgxdE56ZCtEQk9nZ1NWTDQr?=
 =?utf-8?B?TmNwYlpiUEZ2WkxpNnFYNlZna09LSE5zd0paelJoUnRzZ2daVE9qejhmYkxU?=
 =?utf-8?B?anZkbkh5dkZtSjJYTnZpS3UxdWEvK3JtTmowWUtpbk1IL1dETEFPc3o0ei93?=
 =?utf-8?B?R1hHS0NkTndVcXJxek0wakVSK3BheUVSTGM5VElJbmlXVWhuaEJ5Q0xDdDFk?=
 =?utf-8?B?RjBRbDcwU3FKdXJPS1hGR1AyemtycGIyMDFzdW8zeTVDNisxWHNWR1pBSXhr?=
 =?utf-8?B?WkxkbDdwOWdHdmNwZS95MWRyaVVxbkJkazNMcHRTVHY0Qy9janQ3bk00eGFw?=
 =?utf-8?B?RFByT2NpT2ZMRURkTklVbVh0ZEhmQk1VRmNhU3RVWGxXeG5lczVMQ1JJVzRy?=
 =?utf-8?B?elczMDRxMFg2am9jUVRPQ2ttcjFCSTF2SjI4NGZBYkovYnl5ZzcrbVFrUE5V?=
 =?utf-8?B?RHFkUHRseVR2QVZNNFVGa1pSeTcrRnhLTHc5ZWZIYnNOUDhWeXVPcE1xNEty?=
 =?utf-8?B?TzZaQ0VCazkrK1FnRDJ1b2lUalF1azBhK0dBVTRvTlRVZmZDRkdQcWNpODFR?=
 =?utf-8?B?NHgySDRXeGNZQkxhT3JvZVBWUzRMVWVId0R3cE13U2NvdEVIeFpnSU4wVkUr?=
 =?utf-8?B?bzAwWk9ZV0E2UHlZL0dENmlnZlpPenNSZElvdEt1R2c0NnFCQXlib2ErT2Jv?=
 =?utf-8?B?S3NxcS9RM0FCclVQdktZSGlTSWpUdFJEZkV1Wlg4eG9TYzZvM214Qm5MQzI4?=
 =?utf-8?B?c01VbFY3ZUhiSmtvM3hheDdzbkprSk1MNWVWMXdxL3c1UmhKTllvMXJQTzE4?=
 =?utf-8?B?eERnUkJPWXh5UkJUMFowZU5PQklDK01hbWh3d01sRURXL1A2TmZSNnUvL2Zm?=
 =?utf-8?B?aUY2a1k4bUdHM1JLNEkwbUZiT1dteHpLTVJBMkJLbTkyQ2JlK2lOcmNxZFBr?=
 =?utf-8?B?SStqWmtGRjdDK01DRGNlekxxVUNnTG43Yk5EMW52OGFkTU41UWJLSXNwK0Nx?=
 =?utf-8?B?V2xGd3pWNXhvUytlL0pmbENtM1Z6N1NuTzdBSzRlOEw3MGhJNFdkU0Y4TkVm?=
 =?utf-8?B?cHdHZ2VXVHVxemhySnVmUFhuYUJaRnAvNTdrcVdqSUpjZE1WWVFVZGNFNlBq?=
 =?utf-8?B?Z1hPVG16MDhhSmQrUkl4cVpGWFMwSDltek5CU1l0TElybDI1UytUck1VaTFp?=
 =?utf-8?B?SFFxTzF0TWZqVkY1QnEzcUNkRkN6eEo2WWdzK21GUjlPSWhMYnQ5eHdkazV4?=
 =?utf-8?B?R3UzTEtYR1Y3RXllSFhIVFVFUlZMUjcvSC8vUDBWN3NXM2JoOXc0TjJzTlFu?=
 =?utf-8?B?RDRZWGZObzRlbTFra1dxQTl0dHFJN0xKMlBzZk1SdkR6NWYxRkxaV28zWmQ1?=
 =?utf-8?B?RGVUdTNFL3dLN1gvZmZ0bmhMdmd1cFgxSTUxRUs4U0tRVXljVWFDbTh0UGtv?=
 =?utf-8?B?ajBVZVc2dm1rT1J4Rno2cnIyN1RQSUY0NEE1ZkpDQVF0VTNROE85bjdPTmFR?=
 =?utf-8?B?d3FrKzhrQ0I5YmNrT0VGbE9wSWQ0YmJGV3JsTXM5YzE1dlBnS0dKKzFHc2ps?=
 =?utf-8?B?a21sUmxLRXEyeGhsZGtiUUI3WnQ5MnYzdHpDcHNkZmtnMTVveXRMeEZzajBB?=
 =?utf-8?B?Z04ycldlRGtPZjRtKzFjSDJxUnAxMlk0T3JqTEVDb3p4UFFSODZUNWdlVEsy?=
 =?utf-8?B?TEIyYUE5WkMycEs1bDJYWTI1dnY0cjhvODduNVhFYm4yTUwzeVpvZVFxNXpM?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <738F11092465D540BE7599C1F7585704@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0064927-4e90-4b6b-cc15-08db9820b934
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 15:04:11.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGeTKrqoc2LGE6DKvRC3Kq6LX0e+g1N2q8Gs6bpcbQkabarXOC5CmazN2hYyqDF0Y1CUDNlW3HSSFLnDmiIXbCBByjDk+TxMo9Dfw5cwQt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0wOC0w
OCBhdCAxNDo1NSArMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gSGkgSmFzb24sDQo+IA0K
PiBPbiA4LzcvMjMgMDQ6NTEsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiBUaGUgcGxhbmVfc3Rh
dGUgb2YgZHJtX2F0b21pY19zdGF0ZSBpcyBub3Qgc3luYyB0byB0aGUNCj4gPiBtdGtfcGxhbmVf
c3RhdGUNCj4gPiBzdG9yZWQgaW4gbXRrX2NydGMgZHVyaW5nIGNydGMgZW5hYmxpbmcuDQo+ID4g
DQo+ID4gU28gd2UgbmVlZCB0byB1cGRhdGUgdGhlIG10a19wbGFuZV9zdGF0ZSBzdG9yZWQgaW4g
bXRrX2NydGMgYnkgdGhlDQo+ID4gZHJtX2F0b21pY19zdGF0ZSBjYXJyaWVkIGZyb20gbXRrX2Ry
bV9jcnRjX2F0b21pY19lbmFibGUoKS4NCj4gPiANCj4gPiBXaGlsZSB1cGRhdGluZyBtdGtfcGxh
bmVfc3RhdGUsIE9WTCBsYXllciBzaG91bGQgYmUgZGlzYWJsZWQgd2hlbg0KPiA+IHRoZSBmYg0K
PiA+IGluIHBsYW5lX3N0YXRlIG9mIGRybV9hdG9taWNfc3RhdGUgaXMgTlVMTC4NCj4gPiANCj4g
PiBGaXhlczogMTE5ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3Ig
TWVkaWF0ZWsgU29DDQo+ID4gTVQ4MTczLiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkgu
TGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZSBpbiBS
RVNFTkQgdjQ6DQo+ID4gUmVtb3ZlIHJlZHVuZGFudCBwbGFuZV9zdGF0ZSBhc3NpZ25pbmcuDQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwg
MTQgKysrKysrKysrKy0tLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X3BsYW5lLmMgfCAxMSArKysrKysrKy0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fcGxhbmUuaCB8ICAyICsrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggZDQwMTQyODQyZjg1Li43ZGI0ZDY1NTFk
YTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
ID4gQEAgLTMyOCw3ICszMjgsNyBAQCBzdGF0aWMgdm9pZCBkZHBfY21kcV9jYihzdHJ1Y3QgbWJv
eF9jbGllbnQgKmNsLA0KPiA+IHZvaWQgKm1zc2cpDQo+ID4gICB9DQo+ID4gICAjZW5kaWYNCj4g
PiAgIA0KPiA+IC1zdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtfZHJt
X2NydGMgKm10a19jcnRjKQ0KPiA+ICtzdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0
cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjLA0KPiA+IHN0cnVjdCBkcm1fYXRvbWljX3N0YXRl
ICpzdGF0ZSkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgZHJtX2NydGMgKmNydGMgPSAmbXRrX2Ny
dGMtPmJhc2U7DQo+ID4gICAJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsNCj4gPiBA
QCAtNDA1LDExICs0MDUsMTcgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1
Y3QNCj4gPiBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiA+ICAgCS8qIEluaXRpYWxseSBjb25m
aWd1cmUgYWxsIHBsYW5lcyAqLw0KPiA+ICAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5
ZXJfbnI7IGkrKykgew0KPiA+ICAgCQlzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSA9ICZtdGtfY3J0
Yy0+cGxhbmVzW2ldOw0KPiA+IC0JCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRl
Ow0KPiA+ICsJCXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZTsNCj4gPiArCQlzdHJ1
Y3QgbXRrX3BsYW5lX3N0YXRlICpwbGFuZV9zdGF0ZSA9DQo+ID4gdG9fbXRrX3BsYW5lX3N0YXRl
KHBsYW5lLT5zdGF0ZSk7DQo+ID4gICAJCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXA7DQo+ID4g
ICAJCXVuc2lnbmVkIGludCBsb2NhbF9sYXllcjsNCj4gPiAgIA0KPiA+IC0JCXBsYW5lX3N0YXRl
ID0gdG9fbXRrX3BsYW5lX3N0YXRlKHBsYW5lLT5zdGF0ZSk7DQo+IA0KPiBhbnkgcmVhc29uIHdo
eSB5b3UgbW92ZWQgdGhlIGluaXRpYWxpemF0aW9uIG9mIHBsYW5lX3N0YXRlIGF0IHRoZSANCj4g
ZGVjbGFyYXRpb24gcGhhc2UgPw0KPiANCkkganVzdCBsaWtlIHRvIGFzc2lnbiBpdCBhdCB0aGUg
ZGVjbGFyYXRpb24gcGhhc2UuDQpCdXQgaXQncyBub3QgcmVsYXRlZCB0byB0aGlzIGZpeCBwYXRj
aCwgc28gSSdsbCBtb3ZlIGl0IGJhY2suDQpUaGFua3MuDQoNCj4gPiArCQkvKiBzeW5jIHRoZSBu
ZXcgcGxhbmUgc3RhdGUgZnJvbSBkcm1fYXRvbWljX3N0YXRlICovDQo+ID4gKwkJaWYgKHN0YXRl
LT5wbGFuZXNbaV0ucHRyKSB7DQo+ID4gKwkJCW5ld19zdGF0ZSA9DQo+ID4gZHJtX2F0b21pY19n
ZXRfbmV3X3BsYW5lX3N0YXRlKHN0YXRlLCBzdGF0ZS0+cGxhbmVzW2ldLnB0cik7DQo+IA0KPiBD
YW4gZHJtX2F0b21pY19nZXRfbmV3X3BsYW5lX3N0YXRlIGZhaWwgPyBhbmQgbmV3X3N0YXRlIGJl
Y29tZXMgbnVsbA0KPiA/DQoNCmRybV9hdG9taWNfZ2V0X25ld19wbGFuZV9zdGF0ZSgpIHdvbid0
IGZhaWwgYW5kIG5ld19zdGF0ZSB3b24ndCBiZQ0KTlVMTC4NCg0KQnV0IGlmIHN0YXRlLT5wbGFu
ZXNbaV0ucHRyIGlzIE5VTEwsIGl0J2xsIGNyYXNoIGluIGRybV9wbGFuZV9pbmRleCgpDQppbnNp
ZGUgZHJtX2F0b21pY19nZXRfbmV3X3BsYW5lX3N0YXRlKCkuDQoNCj4gDQo+IEkgc2VlIG10a19w
bGFuZV91cGRhdGVfbmV3X3N0YXRlIGFzc3VtZXMgbmV3X3N0YXRlIGJlaW5nIGEgY29ycmVjdCAN
Cj4gc3RhdGUvcG9pbnRlci4NCg0KVGhlIHVzYWdlIGlzIHRoZSBzYW1lIGFzIG10a19wbGFuZV9h
dG9taWNfdXBkYXRlKCkuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiANCj4gUmVnYXJk
cywNCj4gDQo=
