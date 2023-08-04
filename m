Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67476FE7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHDKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHDKaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:30:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08C49C6;
        Fri,  4 Aug 2023 03:29:54 -0700 (PDT)
X-UUID: d7a1ecca32b111ee9cb5633481061a41-20230804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=QUYKBZIHDS78H+SoeMbqreoNHR0R+McSH/roD2ZXNGM=;
        b=p819Sb9J/boOd8D+pzvegZvRhePkMb8GH51DTiB6zw1U6zyrALzIjPAe6iZTVShf+rkanWjK59AadvWb1AvX87gxJHmdbFA4sBRxjJIaQ9pPd/9OLgiw3QLWdxBfOYlUYlDL1DzbgD/Lcj96OW35EAWbDDcO9SAyrU8nMAhuMgw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:a869000a-2a2e-47d2-b420-3b6f59a2fa64,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.30,REQID:a869000a-2a2e-47d2-b420-3b6f59a2fa64,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:1fcc6f8,CLOUDID:cb99d042-d291-4e62-b539-43d7d78362ba,B
        ulkID:230804174539M8Q0PJE0,BulkQuantity:9,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: d7a1ecca32b111ee9cb5633481061a41-20230804
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 286557825; Fri, 04 Aug 2023 18:29:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Aug 2023 18:29:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Aug 2023 18:29:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8XrupXeOvxjeRUdeRe5I7cKQWzDtYI2RVLZ6qUGwNDAHjWyuaFXcsLybjg1EdS+BBtXV4PsyvuYB6p9drNwnfHGUMpLBLOBTn0t0ojTGzjBd1N3YpvviPbLoah7RGK/vlDjaLswsDRzYTTXIMGQGQvgJpDFeHlNV9KlVicVzmFKj6vSTwXjI3gXJSUVGwdIklr7RAl1Shxosb80hCyqBv3XavDKOlF5Uv/Qam2cZn2X5xJjLyOSABGjyt+OCARykteqUqii/qHy1EIi/23z9jrwbCF/sqQjaPWSZ9T1z1GxVjW+RaQqQwWwT3ZMhhhCJYIR0blq5W+/gXOH2AdTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUYKBZIHDS78H+SoeMbqreoNHR0R+McSH/roD2ZXNGM=;
 b=GSLCab7a9bAPVyyUE91OPm9/Jjo+pbIF9b97Ww6P3HTu1SWxDqCA5g2ebvUM5Dq5Q4rh2S6bMhf0X2pdLptrBQ3x7G83KzFbZ4ybxwPI8A7jUs9Lr4e5MojKME4R/xv9AegxegvcYjLJw9soco9ChXcBKf1jbd51so4qlWO6iDWbo4yRo+P0hQalFHw1HfRr4gRO90/2l3B7+1ZBMEJPTL/HnsOVs+f6t5e9DwDeay+KaidNKJPO3AE8yAsQ6CA1khE5BaB8aJSX2RbQVqFaSQuSrHwxgomUwHP30/jYEB7eUvf/RProoBFYjsJ6RZ6Q+X+rBGZmFRi6P2WlkjdOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUYKBZIHDS78H+SoeMbqreoNHR0R+McSH/roD2ZXNGM=;
 b=JvdIdD46LVPdtWSsP7MTKs3NKsMdQ0wQdtFabkq1aSOtsq05TvLjK4TxgT/lbPtseTWFD8CcxQmqPYtRnnIdVn4r0RdU/UlDwix8pbdK+UoGAK+NSpivF89Kf1JW0+/NwqwWlR7d+C9yawTQow8HfSlJWh76Dysexw5shQysW+s=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by SG2PR03MB6504.apcprd03.prod.outlook.com (2603:1096:4:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 10:29:47 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d040:b1d4:ab0b:b28e]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d040:b1d4:ab0b:b28e%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 10:29:47 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Topic: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Index: AQHZwTM8FwajV4doNE2aIAHm/Atkhq/PIgoAgAX/CwCABM1WAIAADFqA
Date:   Fri, 4 Aug 2023 10:29:46 +0000
Message-ID: <906b79e1bb9254d1ea813e4c06a87331c76b45eb.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-7-maso.huang@mediatek.com>
         <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
         <5d005f518d974b7912c832101b5cfbde77f57270.camel@mediatek.com>
         <c2cb5781-f2da-eef8-50db-6bfbaaed685e@linaro.org>
In-Reply-To: <c2cb5781-f2da-eef8-50db-6bfbaaed685e@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|SG2PR03MB6504:EE_
x-ms-office365-filtering-correlation-id: 01408884-fa4c-47e6-f2bc-08db94d5b9d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gc9Kai52I98DhBCkWAlkZTEmRIwGlw9cq2ujA4QuiB7zckXeve0BuwrDirn7Koo+jj+3X2DRUOWLRHnkXDvvUPRU6hFwj7c9iA3w/FmT/FxBUeVS6uTAxl8+IasZ4LKhYOwjKGcrafkPszgVwoQhmIOtE0TxGv3Vx/2gnLDlIrI25JSboX34F+alruyXR1jCiK9bD6+bwtnMeTbg8Rq7npiiShkNPTYGvafU2BDSL1McFFKY4GtCTpvUhYCkoMfmS/nl+uflXKIAmERQN3xenH/LrS7aOXZfaBU3jJnid3EdHHZIEV3FJPbYhYmNH4fmcpna+R2BOg+T0g49C/1/r+ScvxPKfJssBEtoo2YR7MUrEbit2v/2voqaDfpybGOGdw8nxZCmvfzTXH8dIWgGCGi2830dKoLCILuvD3du6rNdZ6YoIZUFbNDxs6PSC75NI8sZGadKGQlDVeSldQqoxJKkA09pYhfZgnC1ORC3NDPkEP7OvAVSX643Kc4w6J3Nie6hxeebZYSJ6+u4BwFFTA52uah77AvxKvHmMoPGXPx1+ACw06JWYNPen9C93BqYAnDIrxBDHZOrxX12AHZPqNQw8SKi5tiXcQp5HfD7BpSLxt0wa4P6Q15AQxplV6ojRvRC1TykNYgyDryLJPIl/A/5nOxXRALeHdzVqT2DDt9nvC40IfJShmtYMLegDfZ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(1800799003)(186006)(6506007)(53546011)(38100700002)(122000001)(26005)(38070700005)(2616005)(85182001)(2906002)(921005)(36756003)(83380400001)(7416002)(5660300002)(478600001)(8676002)(8936002)(110136005)(86362001)(71200400001)(6486002)(41300700001)(6512007)(316002)(91956017)(66446008)(66946007)(64756008)(76116006)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1Q0MWlNUU9EeFdpQXRDeDZ5Q0RObmprM2pOdVAzTGYwN1NiQnBSRGR0b2oy?=
 =?utf-8?B?cStMTE1tbE1pdERVTUE4TFkraEk4eElhZ21IWUc3RElrZFlsOXhuSk4zTDZw?=
 =?utf-8?B?ckZMRnltT2pNT2Vza0R6M1R6NlJ4YktPQmFSZW9IWWs3MmxQR3g1dUp2eGxD?=
 =?utf-8?B?RmtZdDNsR3ByVittVzZQQXJBNGg1MGhTV1V4N0JaWVMvWlorYTV6eEZGK3Bt?=
 =?utf-8?B?ZlNlNkpaSVhLd1d6N045bXdUV2NRbVZXNDVmWldCZUpDb0NLK0lyc3FXVktE?=
 =?utf-8?B?VEhObTRvaWVDRTVKV2tubFc4dVhqdVJselNETHArZXhGRGs1VnQvSFdWeUNt?=
 =?utf-8?B?L2tTNFpvaGx2WllGSWhtb1pQb3dXRUtpclgweWZ3bkE4cE9YUEM3WlVhb1ll?=
 =?utf-8?B?YjVIOEx0dGFVNnVTeFd6UUhSZmlJbEFXWmpmR0kzZC8zcHhXUVZybnFtQ28w?=
 =?utf-8?B?UC9HRVg0T0ZjYU5WZjdzU0o4Z09GdU1rdk9PVHh6RHdXSWFnbHVveWNlRGUw?=
 =?utf-8?B?RjE0NGVBYkh5RE5rQk9teXVobEtlT3BwOHExTGNzWVRrUXZ5dlM4WndLcWp0?=
 =?utf-8?B?bVhwenJ1Wm1WMjY2RDZmZTJYcUFuUEVvYzJpK0dTOFBBa2NEUVVKazEya1NX?=
 =?utf-8?B?Z1A0YTl1dG1TUzRuWXJrM2dyZjdGMVg4YThHQmN4VTNlTkwxTWkvVHNPWmJV?=
 =?utf-8?B?Q1E0Ny95SlpZTmptNVFzVTROVzVoM2VVL25PaUhHUHMwZUVYMmdlYnFQUVd0?=
 =?utf-8?B?aHFpVzdIcHhmNVIwWVJiME02a2Q3bkNFNzcvbE9qV1dQdWRWbE14VXFqd3g0?=
 =?utf-8?B?ekR6cXZmSE5iclczOWNwMUdnaFdQRVIrd09keWx6dGgySElKcGVBZWtQa1lI?=
 =?utf-8?B?UmtwNUU5a3pKQ2lzblVzb1BOUXp3V1E3RDd0VGxIdXo3anZXaTV3emQ1cXp4?=
 =?utf-8?B?Sm9sUy8wUWZnN0toS0IzODFqUFdyMzc4UkhGV1Z1Nnl6eTRoVlRLNGc3UjU4?=
 =?utf-8?B?OUg2bUZOdm5RSThycnE4cm5wRVdlMjMxNGh2bEt5bEdURUZFa05DVis4QVlq?=
 =?utf-8?B?bDhEb1NDbUsrREMxOTV2anc3M2xmbGdJdFM2Q250ZnJGMjJuaDdDVGV0ZDQ0?=
 =?utf-8?B?bDNmOVFweDdScmxJRndydElWVkRacUpoMHAyd3FSbnozZk1xanFITEJpTHVv?=
 =?utf-8?B?R0lSNVFOY29YTTFsUTNlN1ltM1hibi9WY3o3RFBUWEg5bGRRbDdlSnNqdXg5?=
 =?utf-8?B?T09UU1oxemswbXo5TVlsTnRCOFBQQUc5SkRvTlZxU3FPNUZDdmhnek9VcEJQ?=
 =?utf-8?B?MXRGdzB0WGxQVVRFM1ZreTlibTJOZjl0aGU3UHpmSy9oNTR4RUxvMTdieWhX?=
 =?utf-8?B?Rlc4VzdZMG1iejBRbmZFWkY2ZzdjaGhTOTR2b2tyRDlRaHJnTVZETE45ckZk?=
 =?utf-8?B?RzdyeVpaT0tRbXRIeGdOeWF2aWlJalNUL1lZSkxZN1dYcGZrdlkzNkRnck5F?=
 =?utf-8?B?STdrMUJZSEtkLzI4dWVFbnZHSzEzVVJsclRnTjI1Uzk4RXg3LzRsQUxUYlZj?=
 =?utf-8?B?MXY5MU1pTnJ0WUxJMmgzR3NBSFNuTEQzYlpkZWtqVmdZQ0o1UjQ3SVBJTTUx?=
 =?utf-8?B?cFZMZDdTc0ZSUmh5ZWpXZVoxcldjOGlJbTJmYXVheldlQTYxaHg1bzJzWXZT?=
 =?utf-8?B?ZFRicE4xMkUyeFFzOEMyeFdSZDBibmlFL0h5OGpNVmxsRE4vd3NpeWtRQ2FH?=
 =?utf-8?B?VjFQVDFTWWFQRzJPeDA4Y0RsVzBzZGJtbytaUHY1RklkQ29FTTFTc3hsUjVs?=
 =?utf-8?B?cFMreTFoSGNNTEkrQmNqMys3ZVo2RS9rUC9CNlpSYzRpaSt1ZEJVVXhqVEpG?=
 =?utf-8?B?dC9mSkprN3ZXb2lXSlNvSmtIcytxNW5nc3gyWEVKOXJxbmtqeFBaQ0VjeXNR?=
 =?utf-8?B?OFF4NXQrbUlQM2RMUDRCMlBEcUJqT1JRdXhvOEJNQzNYY2d1NjJvaVJ4Vm1Z?=
 =?utf-8?B?NW11V3MvZlJ2QWM1N2N0eHVLQ3BzUlN3Qm9SdExwSk9GRyszNU9yN3BFcGF3?=
 =?utf-8?B?SDNZaFllZ3V6aCtQdjFWeWdXdXdYQzI2U2EvQ1ByeG9uSytzQXZwR0oxcFBS?=
 =?utf-8?B?VjNYa25iR2hSVlhkN29KSmozUkJuRnNaeFBnZVIwZDFwYWNLLzZKN2UveWhi?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74841E6568E3B948B5A66D35E3FDD098@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01408884-fa4c-47e6-f2bc-08db94d5b9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 10:29:46.9467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfES30MNI740D4oavCv74vrTp8YgqN6xHr93gU6lvZFw1M40qOZMPTIPYd/RPyjuUUU2BLgIFJAQ7ZbiBWn9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDExOjQ1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDAxLzA4LzIwMjMgMTA6MjUsIE1hc28gSHVhbmcgKOm7
g+WKoOeruSkgd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIzLTA3LTI4IGF0IDE0OjUxICswMjAwLCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0K
PiA+PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAg
T24gMjgvMDcvMjAyMyAxMTowOCwgTWFzbyBIdWFuZyB3cm90ZToNCj4gPj4+IEFkZCBtdDc5ODYg
YXVkaW8gYWZlIGRvY3VtZW50Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVh
bmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+Pg0KPiA+PiBUaGFuayB5b3UgZm9yIHlv
dXIgcGF0Y2guIFRoZXJlIGlzIHNvbWV0aGluZyB0byBkaXNjdXNzL2ltcHJvdmUuDQo+ID4+DQo+
ID4+PiArDQo+ID4+PiArcmVxdWlyZWQ6DQo+ID4+PiArICAtIGNvbXBhdGlibGUNCj4gPj4+ICsg
IC0gcmVnDQo+ID4+PiArICAtIGludGVycnVwdHMNCj4gPj4+ICsgIC0gY2xvY2tzDQo+ID4+PiAr
ICAtIGNsb2NrLW5hbWVzDQo+ID4+PiArICAtIGFzc2lnbmVkLWNsb2Nrcw0KPiA+Pj4gKyAgLSBh
c3NpZ25lZC1jbG9jay1wYXJlbnRzDQo+ID4+DQo+ID4+IFlvdSBzaG91bGQgY29uc3RyYWluIHlv
dXIgY2xvY2tzIHBlciB2YXJpYW50cy4gSSBkb3VidCB0aGF0IHRoZXkNCj4gYXJlDQo+ID4+IHJl
YWxseSBzbyBmbGV4aWJsZS9vcHRpb25hbCBvbiBlYWNoIFNvQy4uLiBvciBtYXliZSBtaXNzaW5n
IGNsb2Nrcw0KPiA+PiBhcmUNCj4gPj4gcmVzdWx0IG9mIHVuaW1wbGVtZW50ZWQgcGFydHMgaW4g
dGhlIGRyaXZlcj8gQnV0IHRoZW4gdGhpcyBzaG91bGQNCj4gbm90DQo+ID4+IHJlYWxseSBhZmZl
Y3QgYmluZGluZ3MuIEJpbmRpbmdzIHN0aWxsIHNob3VsZCByZXF1aXJlIHN1Y2ggY2xvY2tzLg0K
PiA+PiBZb3VyDQo+ID4+IERUUyBjYW4gYWx3YXlzIHByb3ZpZGUgYSA8MD4sIGlmIG5lZWRlZC4N
Cj4gPj4NCj4gPj4NCj4gPiANCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4gDQo+ID4gQWZ0ZXIgaW50
ZXJuYWwgY2hlY2ssIGFzc2lnbmVkLWNsb2NrcyBhbmQgYXNzaWduZWQtY2xvY2stcGFyZW50cw0K
PiBhcmUNCj4gPiBub3QgcmVxdWlyZWQgb24gdGhpcyBTb0MuIA0KPiA+IE1heWJlIHdlIGNhbiBq
dXN0IGRyb3AgdGhlc2UgdHdvIG9wdGlvbnM/DQo+IA0KPiBJdCdzIHNlcGFyYXRlIGlzc3VlLCBi
dXQgeWVzIC0gd2h5IHJlcXVpcmluZyB0aGVtPw0KPiANCj4gSSB3cm90ZSBhYm91dCBtaXNzaW5n
IGNvbnN0cmFpbnRzIGZvciB5b3VyIGNsb2NrcyBpbiB0aGUgYmluZGluZ3MuDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KSGkgS3J6eXN6dG9mLA0KDQpPSywgSSdsbCBy
ZW1vdmUgYXNzaWduZWQtY2xvY2sgYW5kIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMuDQpBbmQgY29u
c3RyYWluIHRoZSBjbG9ja3MgZm9yIGRpZmZlcmVudCBTb0MgaW4gdGhlIGJpbmRpbmcgaW4gdjQg
cGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCk1hc28NCg==
