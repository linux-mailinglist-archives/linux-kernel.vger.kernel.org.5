Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF917CF772
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjJSLvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjJSLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:51:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7736CF;
        Thu, 19 Oct 2023 04:51:01 -0700 (PDT)
X-UUID: c3a28d386e7511eea33bb35ae8d461a2-20231019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZWcUrgqDfyWTxG6jYi9ZzCpzFE23UrK6z0f3fSz3Jv4=;
        b=Yz6LpnElIfbfnx//HmvM4Nj9n6KNkkWVoBhh3JrN8zv63T1O2G10d8W2eNjiwBsrE/ieP9gR5HQgALFSoAyKQhK4yCezGCvH8mkFFS7kWzKmZdtpLld06ivh3K35QVoyFK9Tk1TxJSl2Wr7LqdPbOaE3A2Jy9gxsqy2a9/BD0Lc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:41df58c6-c781-4e90-9497-c1df7311d2da,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:74befcf0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c3a28d386e7511eea33bb35ae8d461a2-20231019
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2028969842; Thu, 19 Oct 2023 19:50:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Oct 2023 19:50:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Oct 2023 19:50:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1GNUHmFJP+oGNNo/NtA6WM7IUyvVrzmpIUoE8LKywR5AOFsgvQeNhgeF42aC9TUP7AxsifUbbMmYPHV+LmeH/gpQIsdKx0arkVDRsdyipELiJgK1KsopN0KwVxjHlrXNdUowFoZZBLzDmzeEpVpWqXpctart4qsZ6tSMbCk/yUs9DRsfnZZMbwlalBm5jWQON/HGhR6iC49+6UB50VXZfw3x+61spxZ5PdtwKK47x8XUeHoAzz9L3rnIDw6X7wvZezCKqjBu7v5b6YkOr3BeXGE1Q1IIKeGfBSg3jYF2FmeWpPykVLEMG8ZFN+hlGuIuI2G7zv1GlBxAOAJJ1vXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWcUrgqDfyWTxG6jYi9ZzCpzFE23UrK6z0f3fSz3Jv4=;
 b=NLBwiY4Y3iJ8T1xvkZ1NR1KzUVnBC75WJrW5NRulBk7lbUllWRAurfJN2vnJrTH2knoQYsz3YjXTz/SA9JD67Sjlw5RNI5DomWl0SRcvceZbRDqjdwiy9h0oa+n0zao9HYyswzcYdGEF8Qr3aPpowaJr7lvmcHMaJZpz/t3bzarGme9Vn58ocUJ06Qdm1Qp8P/Ph3p6J9tV2BEVvj53Ym+ksDkrAID/RxRXdtCOpGgLKuSh/g1ZnOzxNMZaebM7gD2wqJurevMOoudyRDq8nVYeMxN47D0H+/T4LjWJn9dBbCrt5126iM8AGSb7zB+igz/OQmNP/SQC1rnOtccColw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWcUrgqDfyWTxG6jYi9ZzCpzFE23UrK6z0f3fSz3Jv4=;
 b=ZmZ0QTUjY1FhwSLyov2UP2UP7L3Oa1oXmAdKPa/IlNRk/OCLHSCzLOZUDC5vJsQ82wz7x4Ae0OQJyCo6cjRCHlnPJ1DPB1MgEql6MRPCIkjbg7B31cHNWyHXt0Ibrujm6oLC2eFlHqXkJIZnfCKU8dttb+o4VmTmC2mJB9lFQ2A=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB5213.apcprd03.prod.outlook.com (2603:1096:405:6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 11:50:53 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:50:53 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v10 20/24] drm/mediatek: Add Padding to OVL adaptor
Thread-Topic: [PATCH v10 20/24] drm/mediatek: Add Padding to OVL adaptor
Thread-Index: AQHaAlEpIYYc1XC6tkSPO2BtlpGtkLBQ03mAgAAC24CAAAnqAIAAICQA
Date:   Thu, 19 Oct 2023 11:50:53 +0000
Message-ID: <c1d57c8abceba9418b0904b95e44d10ef879199a.camel@mediatek.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
         <20231019055619.19358-21-shawn.sung@mediatek.com>
         <0a3b0755-73e3-4698-9a3a-be38578ceb3f@collabora.com>
         <9939f8f5fbc2fcc469db212cf53fd3be0231384f.camel@mediatek.com>
         <fdeea37a-6683-44dd-b946-ee708a0b9000@collabora.com>
In-Reply-To: <fdeea37a-6683-44dd-b946-ee708a0b9000@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB5213:EE_
x-ms-office365-filtering-correlation-id: 3c47f441-1e3a-424b-2e0a-08dbd099a618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HxP3J4Zn7djyFbVzM+ZQt/0mLGYjUvUOYl6I0E2YGJepfAtuAar6y9F7wMcT6wl2Nnxv7wwwdYSa+ZTW7jCTMVP46KLQpaVzvEHPgYu7edW2NznXQ9orL83f21Xi0Qh1XfGw0VO1tJZf4Trp8Q8eIbC6GQ3qzHRT1VjWWcTMGVwHVVUbNuO5RI9F2QmOjUfs+VKJITpoHcoBDHW+p3Tbkla9jXAC2EGXhTacocKnTQBhguGR5YHZAlY3Cds93F2RjcqrznAoUrD67f3TSJTphX/A3gkcrzk0PIf/bxEbl0hvD5VqfalARwui6su3Qwq2aQ+WCV1AQqJE7DjcbPzwAB84uA3frxdThaiKZNY0KrESTOGA/m4YHTVYlE+XIA6G508rKBcI5TASh0UK7e0Cc6anD0dRZBCHdjrDwP3Wn7z2fVj3hWFSEVVUyWyVFk3ulob/A8+6Ssgmr+ZsKVFv6edGAG58w4Ov7FQfMcgeuuNprlyqnor8+DZY5MtJYCnXmbDUE3WpjU0xHPokHMJJVPoypxpi3m6x+f+an98n7Fti2CoJA1NXP0RGJDc+nDkW53z2G2+gycSXb+Tkg7MMiTdnPTSKm9GE+ufn0QaYjw0bnOUJ8MRHJTh9CPxLV7968NDWs8royKvngVALwPcOpf4Y4ThbGN1q712JW0fddHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(110136005)(66946007)(66446008)(54906003)(4001150100001)(64756008)(5660300002)(41300700001)(76116006)(6486002)(6506007)(26005)(6512007)(2616005)(4326008)(71200400001)(4744005)(2906002)(66556008)(7416002)(8676002)(8936002)(122000001)(316002)(478600001)(66476007)(38100700002)(38070700005)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlFCZHE1TnB3UTNmK0hHdG9zNENPNHA2clZBa05ma2wvR2tXSGpPMzlDV3c2?=
 =?utf-8?B?c3E0eDVzL3lvS2swdHJ1b0hCZ3dCKzIwM0VpWThveDhGdmJwK0FZeS9SZWtv?=
 =?utf-8?B?VytyWlFhYkFUbmplSjVlVUtUaU00a1pSTGJVblFhb3NSamVBbWtQZCtLclhL?=
 =?utf-8?B?aGJnTFpLOWhqTGY5Z013aVNKTmEvbnFSUFN4bjhVOWVLQ3pnMkJkMXpOcTdw?=
 =?utf-8?B?K2VxQ2ZEOUFsUjJyVzZRdTBka2Vhc2NQRnowRG1hZzQrV3MrdkplKzNWejk4?=
 =?utf-8?B?YTdzaUJCQUM0Z0txNWlmc2cxSjRVeDV1SlpDbERQSkw3Q2hBSUFjK3dldDdp?=
 =?utf-8?B?ekFWMEEydnNiU3ZSVGxTei9QTDRDR01vdlJ2bzFpczVDSk1mNEw2MWZZSkho?=
 =?utf-8?B?dVdXeHdnV0RFVk52cUJrY1ArdVZyYnNKTjNxQ0dFUnZyNWgzNmtwTE1ENDBE?=
 =?utf-8?B?MHozdDlrZ000TWd4YVhvam03Y2U1YURjeEdWempWb3RDS2kyVWFjRm04MkQ1?=
 =?utf-8?B?bDlSWTZpaTBRTFVvSnRxQ1l0V3Jwb1g1ZmhnbDJuVm1xekQ5T2YwODlYcVpz?=
 =?utf-8?B?S3UxOHM3Vll0VWJmbVdtd00xc1BQaVlNZEhLZyt1RGVWWGF3NDBEemxLNSsz?=
 =?utf-8?B?N3RyM2pmb2w1RjNkd3NCWVhOWkRIYTdnMTdNSUNwZHgwc0lIWEE5alFqUjBR?=
 =?utf-8?B?MWFHT2dhNk9xRlQ4aFVjMUg1eng2TFJja21MNGN2SDFDekZ5bEtmWTd2ajBM?=
 =?utf-8?B?OFlZRy85KzFQYmx3cVI4Z0krcFJoczhIbXlQbndsS1JlZVFrM09kTFdQaGwr?=
 =?utf-8?B?SUJkRzhONm5Wd2ZDYUxPdm43eDFlZjlKeTl3VjFLUDNWOFZaOVVYQzBBaWh5?=
 =?utf-8?B?Q0UrTnBkTFYrWUk3bllRa2tNenJsSStZSVcrSlMweXk2emhWZDhxdHJ1b2lK?=
 =?utf-8?B?QVp1Wnlwa1B4MWtnRXFQbElaMmpHRGZGSEZ6Q1IvZTRvK1MxR1orTVJVaHNh?=
 =?utf-8?B?Q3YzMGhjT1JMRzBGVmVoSldWdFZUNC9tMDZVaXpwV2h5YnRkdG5ac3hVQ21C?=
 =?utf-8?B?T05RSng1U05rc0ovOXp0MFZFSDFDR2JjL2g0ZmFwQWxoZFlFTi9PSkl4RnJB?=
 =?utf-8?B?UXpUNDgxc2JrSHk5RDkva0p3T0tHL2M0T2o5OGhRVlNFbTN5bE54Z1BhSjd2?=
 =?utf-8?B?TU15OC9XUzFIL1ZLQWYwY1JLc3dlREhaakg3Yy9HUElYNVpPWVZNRThSYWl5?=
 =?utf-8?B?YmV1eHQ4U3dhd05vY1E3STM1ZWJ2NWcrWWhBZ1cyVHFnam9scTZ2T2YrVW5x?=
 =?utf-8?B?SWdvWmo5dHQxMTlxRUxZcy9WNzYraHJFUnNZQ3lZWjhIbTVDTkZMVWhEaVdF?=
 =?utf-8?B?b3IvUlU2TmQ4SlBXRmhJL2xsMDJUaHNqRHl4ZHBnU3kzVkgybHBFTHhlbUxw?=
 =?utf-8?B?dVRuTE9iM0w2Tk53aXdGVzBQUDZCVTRKRHdOcU9SbzVGcTZRMTBYdjVBK3Nt?=
 =?utf-8?B?emRkY2JBdEFMRE5CZW8vNU9nYzIwVm9FNjgvVHdkSnN1RGRJRDdIWS9XeGpt?=
 =?utf-8?B?dE1tQkU0WlQ3MzNMVU9LYTdCSXkreGFxYjB3ODR6cUozNGUxWlkvZ3BkY3ha?=
 =?utf-8?B?Ym5NQ3BuVzN2YU9hMzdmcWtaZDc4YkZub1kzZXFpeEExenJrNlpaN2ltT2tw?=
 =?utf-8?B?UWRpeStEZTkyTy91NkorK2lxU1pRYk43MmJhSE9teGh6cVV5RTY1M1hSUUxQ?=
 =?utf-8?B?V09MZVpGUGx3L0N2RW5rVEdielRLTjBPQUNoRDdja3NjT3hpTHpTYmhxbEhW?=
 =?utf-8?B?TWJuUVZXdlVhOW13MmdURk0rOFg2blNpQ1VpV1lOWHF5YlZtVitUZDhEWE5V?=
 =?utf-8?B?ZkdhdkxIc1pnb2VXZElndXp5QXRGZ1dFMVlaYXlzZ1dYNkFWWjlwOHBQNzRo?=
 =?utf-8?B?eXpUSndBRW41MEZ3QkpzUnk1QS83WU1TWERiZ3FkRWwxWFBBdUZoZ1ZuQTZv?=
 =?utf-8?B?S0dwaWZIR1Z2bnZDMHRrc0VJV2dwL2ZsbEZDZzNYWmx0a2FuZjQrVkhTbDQy?=
 =?utf-8?B?bnNoREUzMXVZbFUvTXRhWURESEx2VmRRY2ZPbGhac0ZQS2c1Rk9uK3dma3dM?=
 =?utf-8?B?MnI1ejlPcmNNSzV1UTAxRVRSbnBsdis3em9mZ0dUN2QrQWwvUzNTM1N1VkMz?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1B0CB77D911264DB41D44E7558123AF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c47f441-1e3a-424b-2e0a-08dbd099a618
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 11:50:53.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMPhBPWl10/ByPssuGwPRdjLBEF+dwyJl1sND+p4Tlc9qYE4Mq258ekHL2KdgFuEjCAmov4ghu6GFEtWBo5OIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTE6NTUgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiANCj4gVGhhdCdzIGxpa2UgbWFueSBvdGhlciBj
b21wb25lbnRzIGluIE1lZGlhVGVrLCBzbyB3ZSBjYW4ga2VlcCB0aGUNCj4gbXRrLWRpc3AtcGFk
ZGluZw0KPiBuYW1lLi4uLiBpbiBkZXZpY2V0cmVlLCB3ZSB3aWxsIGFueXdheSB1c2UgIm1lZGlh
dGVrLG10ODE5NS1tZHAzLQ0KPiBwYWRkaW5nIiBhcyBvbmUgb2YNCj4gdGhlIGNvbXBhdGlibGUg
c3RyaW5nKHMpLg0KPiANCj4gVGhpcyBpcyB0aGUgb25seSB3YXkgdGhhdCB3ZSBoYXZlIHRvIGFj
dHVhbGx5IGRpc3Rpbmd1aXNoIGJldHdlZW4NCj4gY29tcG9uZW50cyB1c2VkDQo+IGZvciBNRFAz
IGFuZCBjb21wb25lbnRzIHVzZWQgZm9yIHRoZSBkaXNwbGF5IHN1YnN5c3RlbSwgaWYgd2Uga2Vl
cA0KPiB0aGVtICJnZW5lcmljIg0KPiB3ZSB3b24ndCB1bmRlcnN0YW5kIHdoYXQncyBnb2luZyBv
biBpbiBjYXNlIG9mIGlzc3Vlcy4NCj4gDQo+IFRoZSBkcml2ZXIgbmFtZSBzaG91bGQgY29udGFp
biAiZGlzcCIgZm9yIGNvbnNpc3RlbmN5IHdpdGggYWxsIG9mIHRoZQ0KPiBjb21wb25lbnQNCj4g
ZHJpdmVycyBpbiBtZWRpYXRlay1kcm07IGlmIHRoaXMgd2Fzbid0IGluIHRoaXMgZm9sZGVyLCB3
ZSBjb3VsZCd2ZQ0KPiBkcm9wcGVkIHRoZQ0KPiAiZGlzcCIgaW4gdGhlIG5hbWUsIGJ1dCB0aGF0
J3Mgbm90IHRoZSBjYXNlLg0KPiANCj4gQ29uc2lzdGVuY3kgaXMgIzEuDQo+IA0KPiBDaGVlcnMs
DQo+IEFuZ2Vsbw0KPiANCg0KR290IGl0LiBUaGFuayB5b3UgZm9yIG1ha2luZyB0aGF0IGNsZWFy
Lg0KV2lsbCBjaGFuZ2UgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQ2hlZXJzLA0KU2hhd24N
Cg==
