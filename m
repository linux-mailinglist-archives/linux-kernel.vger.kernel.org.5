Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4198A757588
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGRHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjGRHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:41:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C0173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:40:33 -0700 (PDT)
X-UUID: 5cc8d78c253e11ee9cb5633481061a41-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Zg1DM8Pxelj9VFjm3qJpXewc7jikp6hxdOEC/xD5mVg=;
        b=u7h6jfj8knP8H/q32qbzMEzkLkECbB6SDiUttGWW9IccblTMr6GwgvQhrz652T17l87xIlSe7bY9yjE1xX1pOGDTLtcpXwZuKG9DKqx4wF85e20m/sYtfBz7URIUiTBmoRxYbVynZ1fCs7NXSuYrA35+yXT/HBN8wmLO22go6aE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:91bcf52b-6abc-4821-8b24-412fae64fc1c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:8720bf87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5cc8d78c253e11ee9cb5633481061a41-20230718
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 758485827; Tue, 18 Jul 2023 15:40:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 15:40:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 15:40:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhniAmWnK1cOUYEzQcY9O2LZQOShfmct45fzXkE6jLY+mnXa9aYeO1jxF1LnwEOU/CGITeOsAredINjvBVOMcHXeB1fK8G1JxDRpmaY1Wz6Y2lMWguRySfsbuPAbfUncN+3WrBT6bU040VUa4dSHe2Gyp2JIQllkMcvGI7BWcMbdy5d9xh2p0UhyxfutPjHUmOfz+ErT/j4m36qf7wodJHi4Yd+S85wfnctvnIy8/BPWUpl+CjRE38vPRM3Zq245lizHaxurqqVZcHJfM6iMleCbb+vIKdsXiQWfr4zJGITLaWvZQRJOLDjlpO3b/69ks5Dfu93NO9U7mz11TwChfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg1DM8Pxelj9VFjm3qJpXewc7jikp6hxdOEC/xD5mVg=;
 b=jN23hrLSZzKC0tgGzKgVhRxHWqstR1XdcyNpVWbC8/q2M1Q239yXcKwPNPajc0EzfIbYiLIN9aTGR4v4KoIB8VO/Zb8x01Kyd+L0PrNSHftgfeEjs41zE+wbKwq3aCc9hqjJRVOUGCBPY2Jiup3wOx45VCpRN5ci6/dsj7fZrpc/wtJcprEDOEZS1PoQl796RW9S9ysI9H4Z2ee8q3zK1F1QdgMs7sb6yxzShgJH/wNsk+uhNjLqesVxryDvDeh68pz3JU49079aGIB9FLjCa83o+cL9mZDEDZMsR9CFx5p536rVHEv3nNCSYDXMIVrDni5w9in38JT8kYr7C50UUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg1DM8Pxelj9VFjm3qJpXewc7jikp6hxdOEC/xD5mVg=;
 b=QhDQ2LY+BwCZJNiuNR0XV+mwV8yhz7XZJi1syPcLZH1u/pFhlIXwa01iob0AV9+TfYyykziPfcBpcV+ZwnBXSFw44aO1mNeupyXCajl5lWpKV4tHxhdrtFjkj3uae7QiKiXZl44Oi4SNjdtDBmbMBXIJfnFYgb34SJke2lB884A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7048.apcprd03.prod.outlook.com (2603:1096:101:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 07:40:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:40:23 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v5 01/10] drm/mediatek: dp: Move AUX and panel poweron/off
 sequence to function
Thread-Topic: [PATCH v5 01/10] drm/mediatek: dp: Move AUX and panel
 poweron/off sequence to function
Thread-Index: AQHZtWjg2T8LEMHKhkan2IgdAHwQ1q+/K2UA
Date:   Tue, 18 Jul 2023 07:40:23 +0000
Message-ID: <827cc3730c949e38eafd3786631135bcc7c7591c.camel@mediatek.com>
References: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
         <20230713090152.140060-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230713090152.140060-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7048:EE_
x-ms-office365-filtering-correlation-id: 2bf581f1-c8d5-4b29-d4c2-08db87623eac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9D79yrlVD5IdQbWJXrBwCJ7tWmJt1PAOMHvA6iNqueWG8UXdDjYCg5rRm5HdVYvG0rQ6ae2HeC5nZeYoNOy8Xu68qb1L/Q5+vEaSrgV6IdBwxADWJFMDpv2kLe+61v1dX8Lf8yKQG1osFE/dvCC9tdWfhnqCfWNx3MgJ5+0pTcVFkttbvHUM0BsPvzEyvozQsshQLEAWdtBk45cpXPAC8hH77nLffRhzplzQD0YK96ocr5dbG6pciMgXTsyNs+OtARHlyrhrKWQrfIfeLTxTVDjggRWlkoKKirPsH93vmC12BruD9l0ylZhHIDN7LTGABWYF8DejdR4vynb0q2SvGitJkkSqIkMcm+gHS+kCK5FtjwW+jU/02V1l4fUSQ5XeKXVVDwGtcSfXnGyiFYXW8rrVwVZIvXmWh92As/aU0EoOsFT8SBHpXusUJWWDOd7zFHPRFAizbP5t8+hi7LSCgubqqcOIZDX42MR7k17x5h1Kj+kwMyMoHbFhU4OjGproBpct3OenRhAGyFW6hHdU/GWxJ5+mv9WjQQA0biC1251uXIknCpJR5tjh3GhWbR6T38glk32oRGv/zmKW7M2qMryOkUt/QiqdnwVCBQtW6bpnYU16YKwgbfOf7f7NGiHilo7+eO78uRsLEoMk/dBuXzxEIoJP1cOtTtbBQcRNnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(71200400001)(478600001)(6486002)(110136005)(54906003)(186003)(6506007)(6512007)(26005)(76116006)(2906002)(316002)(41300700001)(66446008)(66946007)(4326008)(66476007)(66556008)(64756008)(8676002)(5660300002)(8936002)(7416002)(122000001)(38100700002)(36756003)(85182001)(86362001)(38070700005)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHpvM3ZjWUVSbmNmbjJ6WjVWTW05LzEzVytLV2RiVk1hNU1kZXFGMlBWbm5m?=
 =?utf-8?B?MEtaZUxBQXlmbnoyUDJFa2xOcFJacHk2dTFEay93T0cxeFdMN2IxRDUyaEg1?=
 =?utf-8?B?YnhLVUdjb1AwZ3ljdnlEWkFCZy83WUQvYWZoZGN4S1d6NUFaTmNYSHpJZEYz?=
 =?utf-8?B?blNMeWEyMk9mTVlvTjJsSysvSHRvZlNsTURtVnN4RUdCZzdPUkJOUVlJSzBo?=
 =?utf-8?B?aGhtcUh4SUpNb29aSVFPd3R6WFZmU1F2RG1NTWtwYndQajlVQ2hxblRCanRT?=
 =?utf-8?B?WGVVQWhub1Byb3N5amExMnM1Ymx4ZS9ObDVzQW9talcyajBCOTI0akY5eGQ5?=
 =?utf-8?B?dUNpa1ZjeXVEU1VjakdVei9Qc09VVTZzWnN3WkNrVTdadEhsa1Bhd0RxaDVZ?=
 =?utf-8?B?NzBJNFVKS0ZGQmJnT2dzOWlhUlA3VFJwaGtSWkFuYmFMYkhDVFBLZ2dyTXdy?=
 =?utf-8?B?Wi90bC9ncnA1Q3FVcExkZUNWUXpEQkxzVlM3WlhMRGtvdkE3N3E0SytqVDNL?=
 =?utf-8?B?Nkt5czFQM0U5RlE1a29tNWtFSURSblo3S0JXL0pEQVpPaHB4cUxZbFBObGgz?=
 =?utf-8?B?VEdaYlBEa3B0cGk2TjNHM1kxRG9UVkx3UTFRYVdpNDBISFJ1L3pHaGVWM2NQ?=
 =?utf-8?B?UEsvV1p1eHVrRENXb0orVG5NMzMrTUlNYlZjamlWaFNTOE9JcmJlbVNKbmNX?=
 =?utf-8?B?N0FVTVlqYjNXTkFuZWNyMnM4RFhSRis2S0pHN1VMRitDS0xBMzFCUU5YMFYv?=
 =?utf-8?B?UjY2ek9IdTVieWtxQ092MCt0RGhRU2kwSVJVZlp1ZGFJeE50T1lnb1Nna1dj?=
 =?utf-8?B?c0lvYzlDclVVR05oT09VS3JKWlZiUVNRUnAvd0ZCRVB5cktzQlhTeDQ3c29k?=
 =?utf-8?B?TklpaTVsS1g2NlY4NlZrWmhsYmwrb0dNNWg5R290ZWVad0pIeXlnTi84c0VV?=
 =?utf-8?B?TThsbElrZ1RXMVBBbG05L1ZqR0xzZklOT1ZJR2dwV0ZoajVJb25IVGtRY1Bt?=
 =?utf-8?B?WWhlYVVleHBhWjh0OFJXNnN3KzFaUWdsSHdNQVNtS1l6MXJZdTByM0c0R0JF?=
 =?utf-8?B?NVVtSDE2aytEYmR6S3NIK3RkUjdaY0RZenlabWhYVFAxN2ZEOUx5T1czV0dz?=
 =?utf-8?B?Tng2RTFPWnJyMG9LOVZObVlvOGpHVWlKUzVnWDhwN0owTVZFOVc0bmVhRGl6?=
 =?utf-8?B?cmwxK0ZsRHV5Rm9tYlRpL0ZWTFZBTlMzOTBPUVhTdmExQlFzdTM5MFhJbk1w?=
 =?utf-8?B?SnVMTTVrSUdqdjdLaUk1V1k2cUJsZUpBbnNuK1c1RFZLRHFHSysyb3p4R0JU?=
 =?utf-8?B?cEt1c0hmTnlSRHFhaGJCdWlUWEJLQUtqd0NqdzJwVi9ZZjBNNDRHZjZSWHRY?=
 =?utf-8?B?UTRsQXdaYXpnakZycUZ6b0pZdHQ1V2NZSy93SVpORzBlZS9iWUpncWp6Tk5X?=
 =?utf-8?B?NHNMaGdEd2ROdlE4UHIzQWRkZnFUWXN0ZE5OWitiY2RuMTZhSFVBaWt0UWM3?=
 =?utf-8?B?UnFaKy8vWDhKamU3NzhZcHJsWnozaW9QQlU1RUlNcUN1ZWdlNFlSdmpqUnlm?=
 =?utf-8?B?MEpvQ2d6dU0xM2N5L2RLT1R0cWh5R002QmZHQjA0dWR5UDljdm9QSlVOdDJy?=
 =?utf-8?B?cC9hajdpUHUyVW8vOTVaQnFTWkloUy9jVHd1emNMZVBCMUhoMWg1WUptcldn?=
 =?utf-8?B?VldrY3ZHQzBjQ3kxUzUwb1RxVDZjK1U3WFVETXFDZnovSWQxTWd0cUU4S3Q4?=
 =?utf-8?B?dWdiMTIzZlRoSUM1dnNNaWdJaUdmT1pmdTdONERrTUZhV1NJN3dxM3phTzlR?=
 =?utf-8?B?VUZIbW52OGdaRGtDcTV2eVJUbi8rUVpicDIrd3FRaWJQMit6MTljK1RQV2NV?=
 =?utf-8?B?QVVTYUE4Q3VsbDUwN0Z2dC9XbS9aQzN0OXdCdjdUdmxmZHp0OHB4NnpKQThO?=
 =?utf-8?B?a09Zc2RuNWgzdzM2aEp1c1hiWDlmZm5aT2FRaXFNUnFBc0hBVDIxOUVVWDFC?=
 =?utf-8?B?RnE2S1EvVm52VzY3SnhHZCt6d1pIdG5Wcll6bVJwMmhtamFIdDMxWGtXbklo?=
 =?utf-8?B?UkxwVTR4c1o3OW1sUDhBelNPMzVraHBYL2JVTFRCZm1qZ2NZQm9Nd01Ubk8z?=
 =?utf-8?Q?JDTvSZyUPe0Qs0S/i7GRrbHx0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BC6207507F36E45955D315CA54D51BE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf581f1-c8d5-4b29-d4c2-08db87623eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:40:23.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZqA/il+7ljXaNWDI2Jc4U17CXHKCkYk13YQAYI3x8epaPjaPA0EhKCLV9GgUL9c31E026xZ+dfj+9n/BXyeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA3LTEzIGF0IDExOjAxICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBFdmVyeXRpbWUgd2Ug
cnVuIGJyaWRnZSBkZXRlY3Rpb24gYW5kL29yIEVESUQgcmVhZCB3ZSBydW4gYSBwb3dlcm9uDQo+
IGFuZCBwb3dlcm9mZiBzZXF1ZW5jZSBmb3IgYm90aCB0aGUgQVVYIGFuZCB0aGUgcGFuZWw7IG1v
cmVvdmVyLCB0aGlzDQo+IGlzIGFsc28gZG9uZSB3aGVuIGVuYWJsaW5nIHRoZSBicmlkZ2UgaW4g
dGhlIC5hdG9taWNfZW5hYmxlKCkNCj4gY2FsbGJhY2suDQo+IA0KPiBNb3ZlIHRoaXMgcG93ZXIg
b24vb2ZmIHNlcXVlbmNlIHRvIGEgbmV3IG10a19kcF9hdXhfcGFuZWxfcG93ZXJvbigpDQo+IGZ1
bmN0aW9uIGFzIHRvIGNvbW1vbml6ZSBpdC4NCj4gTm90ZSB0aGF0LCBiZWZvcmUgdGhpcyBjb21t
aXQsIGluIG10a19kcF9icmlkZ2VfYXRvbWljX2VuYWJsZSgpIG9ubHkNCj4gdGhlIEFVWCB3YXMg
Z2V0dGluZyBwb3dlcmVkIG9uIGJ1dCB0aGUgcGFuZWwgd2FzIGxlZnQgcG93ZXJlZCBvZmYgaWYN
Cj4gdGhlIERQIGNhYmxlIHdhc24ndCBwbHVnZ2VkIGluIHdoaWxlIG5vdyB3ZSB1bmNvbmRpdGlv
bmFsbHkgc2VuZCBhIEQwDQo+IHJlcXVlc3QgYW5kIHRoaXMgaXMgZG9uZSBmb3IgdHdvIHJlYXNv
bnM6DQo+ICAtIEZpcnN0LCB3aGV0aGVyIHRoaXMgcmVxdWVzdCBmYWlscyBvciBub3QsIGl0IHRh
a2VzIHRoZSBzYW1lIHRpbWUNCj4gICAgYW5kIGFueXdheSB0aGUgRFAgaGFyZHdhcmUgd29uJ3Qg
cHJvZHVjZSBhbnkgZXJyb3IgKG9yLCBpZiBpdA0KPiAgICBkb2VzLCBpdCdzIGlnbm9yYWJsZSBi
ZWNhdXNlIGl0IHdvbid0IGJsb2NrIGZ1cnRoZXIgY29tbWFuZHMpDQo+ICAtIFNlY29uZCwgdHJh
aW5pbmcgdGhlIGxpbmsgYmV0d2VlbiBhIHNsZWVwaW5nL3N0YW5kYnkvdW5wb3dlcmVkDQo+ICAg
IGRpc3BsYXkgbWFrZXMgbGl0dGxlIHNlbnNlLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IFRlc3RlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgNzYgKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA0
NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5k
ZXggNjRlZWU3NzQ1MmMwLi44YjdkZWQxNzQ2ZjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwLmMNCj4gQEAgLTEyNTEsNiArMTI1MSwyOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYXVk
aW9fbXV0ZShzdHJ1Y3QgbXRrX2RwDQo+ICptdGtfZHAsIGJvb2wgbXV0ZSkNCj4gIAkJCSAgIHZh
bFsyXSwgQVVfVFNfQ0ZHX0RQX0VOQzBfUDBfTUFTSyk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2
b2lkIG10a19kcF9hdXhfcGFuZWxfcG93ZXJvbihzdHJ1Y3QgbXRrX2RwICptdGtfZHAsIGJvb2wN
Cj4gcHdyb24pDQo+ICt7DQo+ICsJaWYgKHB3cm9uKSB7DQo+ICsJCS8qIHBvd2VyIG9uIGF1eCAq
Lw0KPiArCQltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVE9QX1BXUl9TVEFURSwN
Cj4gKwkJCQkgICBEUF9QV1JfU1RBVEVfQkFOREdBUF9UUExMX0xBTkUsDQo+ICsJCQkJICAgRFBf
UFdSX1NUQVRFX01BU0spOw0KPiArDQo+ICsJCS8qIHBvd2VyIG9uIHBhbmVsICovDQo+ICsJCWRy
bV9kcF9kcGNkX3dyaXRlYigmbXRrX2RwLT5hdXgsIERQX1NFVF9QT1dFUiwNCj4gRFBfU0VUX1BP
V0VSX0QwKTsNCj4gKwkJdXNsZWVwX3JhbmdlKDIwMDAsIDUwMDApOw0KPiArCX0gZWxzZSB7DQo+
ICsJCS8qIHBvd2VyIG9mZiBwYW5lbCAqLw0KPiArCQlkcm1fZHBfZHBjZF93cml0ZWIoJm10a19k
cC0+YXV4LCBEUF9TRVRfUE9XRVIsDQo+IERQX1NFVF9QT1dFUl9EMyk7DQo+ICsJCXVzbGVlcF9y
YW5nZSgyMDAwLCAzMDAwKTsNCj4gKw0KPiArCQkvKiBwb3dlciBvZmYgYXV4ICovDQo+ICsJCW10
a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiArCQkJCSAg
IERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTEwsDQo+ICsJCQkJICAgRFBfUFdSX1NUQVRFX01BU0sp
Ow0KPiArCX0NCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgbXRrX2RwX3Bvd2VyX2VuYWJsZShz
dHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICB7DQo+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19k
cCwgTVRLX0RQX1RPUF9SRVNFVF9BTkRfUFJPQkUsDQo+IEBAIC0xOTM2LDE2ICsxOTU5LDkgQEAg
c3RhdGljIGVudW0gZHJtX2Nvbm5lY3Rvcl9zdGF0dXMNCj4gbXRrX2RwX2JkZ19kZXRlY3Qoc3Ry
dWN0IGRybV9icmlkZ2UgKmJyaWRnZSkNCj4gIAlpZiAoIW10a19kcC0+dHJhaW5faW5mby5jYWJs
ZV9wbHVnZ2VkX2luKQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JaWYgKCFlbmFibGVkKSB7
DQo+IC0JCS8qIHBvd2VyIG9uIGF1eCAqLw0KPiAtCQltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2Rw
LCBNVEtfRFBfVE9QX1BXUl9TVEFURSwNCj4gLQkJCQkgICBEUF9QV1JfU1RBVEVfQkFOREdBUF9U
UExMX0xBTkUsDQo+IC0JCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiArCWlmICghZW5hYmxl
ZCkNCj4gKwkJbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgdHJ1ZSk7DQo+ICANCj4g
LQkJLyogcG93ZXIgb24gcGFuZWwgKi8NCj4gLQkJZHJtX2RwX2RwY2Rfd3JpdGViKCZtdGtfZHAt
PmF1eCwgRFBfU0VUX1BPV0VSLA0KPiBEUF9TRVRfUE9XRVJfRDApOw0KPiAtCQl1c2xlZXBfcmFu
Z2UoMjAwMCwgNTAwMCk7DQo+IC0JfQ0KPiAgCS8qDQo+ICAJICogU29tZSBkb25nbGVzIHN0aWxs
IHNvdXJjZSBIUEQgd2hlbiB0aGV5IGRvIG5vdCBjb25uZWN0IHRvDQo+IGFueQ0KPiAgCSAqIHNp
bmsgZGV2aWNlLiBUbyBhdm9pZCB0aGlzLCB3ZSBuZWVkIHRvIHJlYWQgdGhlIHNpbmsgY291bnQN
Cj4gQEAgLTE5NTcsMTYgKzE5NzMsOCBAQCBzdGF0aWMgZW51bSBkcm1fY29ubmVjdG9yX3N0YXR1
cw0KPiBtdGtfZHBfYmRnX2RldGVjdChzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlKQ0KPiAgCWlm
IChEUF9HRVRfU0lOS19DT1VOVChzaW5rX2NvdW50KSkNCj4gIAkJcmV0ID0gY29ubmVjdG9yX3N0
YXR1c19jb25uZWN0ZWQ7DQo+ICANCj4gLQlpZiAoIWVuYWJsZWQpIHsNCj4gLQkJLyogcG93ZXIg
b2ZmIHBhbmVsICovDQo+IC0JCWRybV9kcF9kcGNkX3dyaXRlYigmbXRrX2RwLT5hdXgsIERQX1NF
VF9QT1dFUiwNCj4gRFBfU0VUX1BPV0VSX0QzKTsNCj4gLQkJdXNsZWVwX3JhbmdlKDIwMDAsIDMw
MDApOw0KPiAtDQo+IC0JCS8qIHBvd2VyIG9mZiBhdXggKi8NCj4gLQkJbXRrX2RwX3VwZGF0ZV9i
aXRzKG10a19kcCwgTVRLX0RQX1RPUF9QV1JfU1RBVEUsDQo+IC0JCQkJICAgRFBfUFdSX1NUQVRF
X0JBTkRHQVBfVFBMTCwNCj4gLQkJCQkgICBEUF9QV1JfU1RBVEVfTUFTSyk7DQo+IC0JfQ0KPiAr
CWlmICghZW5hYmxlZCkNCj4gKwkJbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgZmFs
c2UpOw0KPiAgDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gQEAgLTE5ODIsMTUgKzE5OTAsNyBA
QCBzdGF0aWMgc3RydWN0IGVkaWQgKm10a19kcF9nZXRfZWRpZChzdHJ1Y3QNCj4gZHJtX2JyaWRn
ZSAqYnJpZGdlLA0KPiAgDQo+ICAJaWYgKCFlbmFibGVkKSB7DQo+ICAJCWRybV9hdG9taWNfYnJp
ZGdlX2NoYWluX3ByZV9lbmFibGUoYnJpZGdlLCBjb25uZWN0b3ItDQo+ID5zdGF0ZS0+c3RhdGUp
Ow0KPiAtDQo+IC0JCS8qIHBvd2VyIG9uIGF1eCAqLw0KPiAtCQltdGtfZHBfdXBkYXRlX2JpdHMo
bXRrX2RwLCBNVEtfRFBfVE9QX1BXUl9TVEFURSwNCj4gLQkJCQkgICBEUF9QV1JfU1RBVEVfQkFO
REdBUF9UUExMX0xBTkUsDQo+IC0JCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiAtDQo+IC0J
CS8qIHBvd2VyIG9uIHBhbmVsICovDQo+IC0JCWRybV9kcF9kcGNkX3dyaXRlYigmbXRrX2RwLT5h
dXgsIERQX1NFVF9QT1dFUiwNCj4gRFBfU0VUX1BPV0VSX0QwKTsNCj4gLQkJdXNsZWVwX3Jhbmdl
KDIwMDAsIDUwMDApOw0KPiArCQltdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVl
KTsNCj4gIAl9DQo+ICANCj4gIAluZXdfZWRpZCA9IGRybV9nZXRfZWRpZChjb25uZWN0b3IsICZt
dGtfZHAtPmF1eC5kZGMpOw0KPiBAQCAtMjAxMCwxNSArMjAxMCw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
ZWRpZCAqbXRrX2RwX2dldF9lZGlkKHN0cnVjdA0KPiBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ICAJ
fQ0KPiAgDQo+ICAJaWYgKCFlbmFibGVkKSB7DQo+IC0JCS8qIHBvd2VyIG9mZiBwYW5lbCAqLw0K
PiAtCQlkcm1fZHBfZHBjZF93cml0ZWIoJm10a19kcC0+YXV4LCBEUF9TRVRfUE9XRVIsDQo+IERQ
X1NFVF9QT1dFUl9EMyk7DQo+IC0JCXVzbGVlcF9yYW5nZSgyMDAwLCAzMDAwKTsNCj4gLQ0KPiAt
CQkvKiBwb3dlciBvZmYgYXV4ICovDQo+IC0JCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1U
S19EUF9UT1BfUFdSX1NUQVRFLA0KPiAtCQkJCSAgIERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTEws
DQo+IC0JCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiAtDQo+ICsJCW10a19kcF9hdXhfcGFu
ZWxfcG93ZXJvbihtdGtfZHAsIGZhbHNlKTsNCj4gIAkJZHJtX2F0b21pY19icmlkZ2VfY2hhaW5f
cG9zdF9kaXNhYmxlKGJyaWRnZSwgY29ubmVjdG9yLQ0KPiA+c3RhdGUtPnN0YXRlKTsNCj4gIAl9
DQo+ICANCj4gQEAgLTIxNzgsMTUgKzIxNzAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYnJpZGdl
X2F0b21pY19lbmFibGUoc3RydWN0DQo+IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gIAkJcmV0dXJu
Ow0KPiAgCX0NCj4gIA0KPiAtCS8qIHBvd2VyIG9uIGF1eCAqLw0KPiAtCW10a19kcF91cGRhdGVf
Yml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiAtCQkJICAgRFBfUFdSX1NUQVRF
X0JBTkRHQVBfVFBMTF9MQU5FLA0KPiAtCQkJICAgRFBfUFdSX1NUQVRFX01BU0spOw0KPiAtDQo+
IC0JaWYgKG10a19kcC0+dHJhaW5faW5mby5jYWJsZV9wbHVnZ2VkX2luKSB7DQo+IC0JCWRybV9k
cF9kcGNkX3dyaXRlYigmbXRrX2RwLT5hdXgsIERQX1NFVF9QT1dFUiwNCj4gRFBfU0VUX1BPV0VS
X0QwKTsNCj4gLQkJdXNsZWVwX3JhbmdlKDIwMDAsIDUwMDApOw0KPiAtCX0NCj4gKwltdGtfZHBf
YXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVlKTsNCj4gIA0KPiAgCS8qIFRyYWluaW5nICov
DQo+ICAJcmV0ID0gbXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+IC0tIA0KPiAyLjQwLjENCg==
