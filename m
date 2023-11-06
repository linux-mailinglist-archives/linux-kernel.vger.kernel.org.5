Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBB7E185B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 02:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjKFBfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 20:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFBfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 20:35:10 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B5DD;
        Sun,  5 Nov 2023 17:35:06 -0800 (PST)
X-UUID: b3e7e0e67c4411eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4TaKHWEepruBWCb1XFVSLEIW1qCpOagJMEfLYE5RBx0=;
        b=ZcG+rm17dzlLQipic3Bf1QddL6QW1DWibONPO950x1ajbn4GhRUm/DRtvC8/jEWZ8LRYLFwGNfI9AUsYejHyvb9Jjketj4RNg7okc2m/mO1gx6i/TVP7nVdAhm5cjD3UPwmqG0nhdd2EAJBemqmOQlSo95FCRA5hlY8lS9VhuTs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:5737cd6e-7d5e-436c-8e8e-1bf586486cd9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:5a192efc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b3e7e0e67c4411eea33bb35ae8d461a2-20231106
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 792458493; Mon, 06 Nov 2023 09:35:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 09:35:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 09:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mpm/4T33CaFP61SKBHbQgHwUSUyi9cci9mtk4gSJqQIsPSpDzqxZQnciq+BQmFK7Yi9IvykPTmWvvwbPZ7cdty+D0Q38V9z65ddNzxiZfdHZ9NISmCX03u7dc9voI0wyEuieQgV42GxSeqHQ0BbumKvK64ELaR3g+tMoX+wLbcYysXkAlyn7stK1AigQA//H6aHwnq0ChdNfQgxgrpLDWWFPYP6iB+b5iPuDE9yJ5iMBy8t0/+RVTjkQCIAh/wgsK6NiRsY2ozI20EAeNDPoy3Clh3IzI6HbtmxkF/HBN13M6zAfjMHVBLr1gOqO+WdDH+4tLlb+cumBf0MvogYuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TaKHWEepruBWCb1XFVSLEIW1qCpOagJMEfLYE5RBx0=;
 b=AIir1EcqWlVNGZO6SBjEAfqjS99xLuzJCaEBLZ7Z+Tf2eZ4gn+6aMU0U51EuTkLI3i6TPRqoBf8eOBNkP51AAJ6K+mM63UhNdhW7GbysPu3BUz3xdilq1X7RHLlGxWqlqcgdQRPbwu5KNzlLndGNlIaUcQksHtbUjFpbkOtoXYFUqpH/2TxbtG/MyFZSAVK6P/tnBCRvg+6VsmfAM/yeuObKAUZfd8uPBXLSFI1WmbGqC0Ghpfh1v7eBQEQf7dSxdT+hnCi7Quq8Nb+Mvgw/CEgwHGA3Hk6W/B2p3URFJz8qmbLdTculFqdWz6ceeX54oo7pgL1vf4FiWgOTfbXH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TaKHWEepruBWCb1XFVSLEIW1qCpOagJMEfLYE5RBx0=;
 b=jddTZOSKvXEJwEsgO9ftd8UVxY7KCQcNPmrsaTemulEQzfQoHgPSMTV8jpj2SDOu0Y7MDmO5hoaZlfZtoSmr0VD6TrPx3ovdTjw5P9K/j97/jqJgOdGwkBcdLhKi8S1uiu3gboc+ameO3GnPUDDH7D+6pYoe9uo3nJwOrQAUPxQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8058.apcprd03.prod.outlook.com (2603:1096:400:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 01:33:56 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 01:33:56 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaBWwJYGbjWCm+FECrWQohGGln37Bb3XkAgA/s8QCAAM1bAA==
Date:   Mon, 6 Nov 2023 01:33:56 +0000
Message-ID: <a33a28a785aa207cdbf301f2b0666bbef3783fa5.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-8-jason-jh.lin@mediatek.com>
         <3af3f0919045e806b7cc2c36fb99bff8918f874e.camel@mediatek.com>
         <966e530d745c128f299e67b5bcd2437f5f313ec8.camel@mediatek.com>
In-Reply-To: <966e530d745c128f299e67b5bcd2437f5f313ec8.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8058:EE_
x-ms-office365-filtering-correlation-id: 764fb89f-882d-46f6-7324-08dbde6871a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3Fk7Yd6hXYqDRtIp16X1AToD/LAaoxd1oE87UPFz+nl3uiCmoCNZfIoCSFQzKStApT31YFViT9XOxGcFzibXVFyswrl+Wtc8EzzH1wA3YSDfd3WIQMLDaTBBO5awkpor6C9bu6vHwg1XmpUbwtcVhQlPqTlR7Zi9tR8OAun9TY4/eatSjDDeJGizec/P/g7+yDEosblZDgInEfRgobtcRY3Ngr7mK2qnIlY79H8t3GwBIsRi17kNGSNIl4KwnW91kB66Mg1diQIAb/+5ca5CT9bj8b4z4pr+9wYnuzAu00i9oogQs670nrapRKwbKbRyjpilBD0Sbss6CaGHtFPjdJKuzrFcVI6iXq8OoUw3fYtk1T47qiRhFga2kW9IKh8o/PUQq6SbNsLPdYPXgC1EArlLzvBV+Dum2YF440aqjyECmxJclit9TdcehmMYodTz+e0fjlK68QPlejjF26vzI8vTlWKPVfIIougLbEJ3bAT0hp2vw4Og2N+j7iOVdkHW8YmaT/MsaCOC5qaEZvVKfJk3dMZcMUdLUvuIpcqXwjXMftX1tXusJ/pce5rs1QAWZ3g1D88HD+hIunO2ERtZOUhVDQUaqnQ2LzX3cIGjeSnv0qzdq1vcunhRkRRI55mCeTUg543f04Dtvtb2oK0LI0lnJPjmYaRMdRAODIQc+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4001150100001)(6506007)(2616005)(6512007)(6486002)(71200400001)(478600001)(83380400001)(26005)(5660300002)(2906002)(7416002)(64756008)(76116006)(66476007)(66446008)(66946007)(41300700001)(66556008)(316002)(110136005)(4326008)(54906003)(8676002)(8936002)(38070700009)(85182001)(38100700002)(36756003)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDFUZ0pjd0RVUzNKOCtSVld0MksraGN6bHY5bVd3MVpFaklTV1ZaWEU5cXVT?=
 =?utf-8?B?OXpWQWt5R2V2ZHpqUUoydmpJWHUrcVlpMXQza3ZlYjNuSWZNWDM0YUxqY2VK?=
 =?utf-8?B?WlY4bWJ4WTROb3pyU1M1SXhwdVdNcDM2WVRqazlWRzZZcVVJK3lEWWVPcTFZ?=
 =?utf-8?B?c0NsQWlsWnNDWW94bGR5ZUs1cmUwZU1BR0dsVWxHVDQxV1NRNFN3VWlJNWtQ?=
 =?utf-8?B?ajVQV281NStsenNoQzhTeTltNTZDTVFYb0F2MXBuV0VCQ2x0NDdsRDg3eGIr?=
 =?utf-8?B?WGswK1Z0SUladGJrdVRMc05MSjBvZXg2WXV4SUtJSURCWlpxNmg4K1JBOVVO?=
 =?utf-8?B?OGdwTkx5VE5pTGlqV2h0TkpHUzJSUEJ4NGF2MzdhL0dySkpCV1lUNkEvY3VT?=
 =?utf-8?B?Y3VPb1BFb2QwM3V0Zm5LSlBQY1RHMTYwV1RCWUFraWFsbkZmcExZT1Y5c244?=
 =?utf-8?B?NnlHNHdJdSt2Q2xEVDZ3eFVkOHVhZ3czTGF4eXNKd1dtMVRtVGJBN0ZWUDVu?=
 =?utf-8?B?bEtXSHJucWpnWXQwZGlnWnh4cCt5VmZIcFBtVndUc1RPRmM4ZGVuNzdyRG8x?=
 =?utf-8?B?dlBPSWdEVnkyUHQzdnIyRy9YSVdITURZclJTa0R3SUx1bGxtbmpkbElGcWxU?=
 =?utf-8?B?NFVjOHR6L2N5Y2dpbC9OMURLQlRFaDBzZ1EvdDBjd0psbVhTdkRmUGlWbllX?=
 =?utf-8?B?bFNqS3ZTL1NRV2QrY201NkgwVUUxdUcvZ2U5Q0E3ZFZSK05QRy9KUXRoWDVX?=
 =?utf-8?B?Rk9oK3Y4Ujk1WU9LRUhYRDB1YmV4WHJrcWZaVEhZejZyd1d4Q1lxRC93OHI0?=
 =?utf-8?B?YVo4ZUpDbDNBVmtxeFJ6aGd6NitHdGliaEJtbUFTLzdnS1pta2l5aHFJUmEz?=
 =?utf-8?B?MWk3YmpHa2RDei9keVFjaEF2SEY0NUFDazdaL1kzVmg1QkNXZlk5VSsvUFoy?=
 =?utf-8?B?TFBxM3pTWUFjNlhCL3Y1eGpVVkxuNVphcDhISS8yTlFyRURSRENiYzExSGo1?=
 =?utf-8?B?WmdLVFlES3NVVTRESXBuU3pEd1U1VDhma1JSelA4SU9sdmdSQkM4c0tnNVJ5?=
 =?utf-8?B?eUxNeXdGUmlaOXBLM2Z3bkFYWnF3emxmRW9lQkVtNkRrQTdOWmVwNHBqR2xQ?=
 =?utf-8?B?enlIUzRPM05NcmNTVE04dmJXMlovZ0hkbmQvSU5DRElUdkk3UHJwNGJzUHVj?=
 =?utf-8?B?c1NLTEVYTjhHNU8zY0Iza0VkUnJQV3JlYjlpQkVxS082cDFqREZFWmkzN3Fl?=
 =?utf-8?B?VzZNbUJQTWdlckttSTkyOWVYdVhZeFlxVzcrK0RESEpDUXZUdWExb1lLeTVM?=
 =?utf-8?B?dXUxbSt3Y1NySFpvUTUxSFJSNTVxZFp5REFlcDZtTTdoT3Q4UW1sRTlNTEtV?=
 =?utf-8?B?OEVtdkVCY092cG5KSVFndGZGSWpDUm1IRWxRWEVzZzlSejRud0pEK1BCVVJS?=
 =?utf-8?B?Q3pyZHBQaTgray8yTVZ6RzFteVBSU1FPQXZzMC9ObHlKTG5xOG0xWFMrNTJI?=
 =?utf-8?B?QnJkTEdhMnZ4UG0raVAvSWxDWU9LVVZ6QlBvVFJBS21iY1VuZ0xkV29FQjAr?=
 =?utf-8?B?MGxZQ3ZyNmxURGtFZ2Z1Y2RoKy9RaDJVV05JN2NRTXZEaEJTRjhzYUdBcVhL?=
 =?utf-8?B?TTZsV1dBTThSTGVuUllLcDVSdFVBdHJ5eC82b3BwTW4wYk5KdU5yZ1B0MVBj?=
 =?utf-8?B?WnlTaU9GOE9hK3JIaytqdDh3QThVeVoxcXJLeXZJS2w5ZUdXWWJYQUpHZGpx?=
 =?utf-8?B?UFlzdWpXd2wvblRKby9rOTRkSDkvM3FyWE94anQ1cHBZcXBZcTdDU3ZBTFZO?=
 =?utf-8?B?WGRkVG95aEszUi9iTGMrcHhtS0JRNDRFdWNJZG5ObXV5L3BEZ1JQRUpBMEJw?=
 =?utf-8?B?RTVYdW9IUUlXT1gxK0Z4eU5TR3dab0VsVnFGRVlrNHFmSFVyOFNucnV3L0J6?=
 =?utf-8?B?cHdmNWtXQXJkVE5Vd1ExLzg3Q2t6MGgyR1ZIb1VNR2pkaFNwVDBFbldoTXRU?=
 =?utf-8?B?QnhrUjVnTkMwWk52aTkvR3dQOTUrWlhQRkpxZnYwK3FPdG05UVc5M2YzK2hi?=
 =?utf-8?B?WEs1MXZyajRuVFF4MW4vYkJTM2Z3SFJ3cXRDVW80MWRPTk5mQng1SGNtNENC?=
 =?utf-8?Q?xsic8i85FDjD7OTWgNQrg5v6I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBD143AB9EC4CC47A40E14A2CB22DF5E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764fb89f-882d-46f6-7324-08dbde6871a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 01:33:56.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3RKFxHUKx1knYdaQRIoYTz89S6O0x2AXtGayoZd1CgeYs0uQydtNgZwhBelQfNZfcDX/F1KMWnLU8aD+gsYRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjE4ICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gVGh1LCAyMDIzLTEwLTI2IGF0IDEwOjA3ICsw
MDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgSmFzb246DQo+ID4gDQo+ID4g
T24gTW9uLCAyMDIzLTEwLTIzIGF0IDEyOjQ1ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
ID4gPiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBwb3J0IGZvciBvdmwuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9k
cnYuaCAgICAgICB8ICAzICsrDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jICAgICAgIHwgMzENCj4gPiA+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiA+ICAu
Li4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAxMiArKysrKysr
DQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyAgIHwg
IDIgKysNCj4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2Rydi5oDQo+ID4gPiBpbmRleCAyMjU0MDM4NTE5ZTEuLmRlYzkzN2IxODNhOCAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gPiBA
QCAtOSw2ICs5LDcgQEANCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaD4N
Cj4gPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tdXRleC5oPg0KPiA+ID4g
KyNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ID4gPiAgI2luY2x1ZGUgIm10a19kcm1f
cGxhbmUuaCINCj4gPiA+ICAjaW5jbHVkZSAibXRrX21kcF9yZG1hLmgiDQo+ID4gPiAgDQo+ID4g
PiBAQCAtNzksNiArODAsNyBAQCB2b2lkIG10a19vdmxfY2xrX2Rpc2FibGUoc3RydWN0IGRldmlj
ZSAqZGV2KTsNCj4gPiA+ICB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwg
dW5zaWduZWQgaW50IHcsDQo+ID4gPiAgCQkgICAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGlu
dCB2cmVmcmVzaCwNCj4gPiA+ICAJCSAgICB1bnNpZ25lZCBpbnQgYnBjLCBzdHJ1Y3QgY21kcV9w
a3QgKmNtZHFfcGt0KTsNCj4gPiA+ICt1NjQgbXRrX292bF9nZXRfc2VjX3BvcnQoc3RydWN0IG10
a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50DQo+ID4gPiBpZHgpOw0KPiA+ID4gIGludCBt
dGtfb3ZsX2xheWVyX2NoZWNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwN
Cj4gPiA+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICptdGtfc3RhdGUpOw0KPiA+ID4gIHZv
aWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQg
aWR4LA0KPiA+ID4gQEAgLTExMiw2ICsxMTQsNyBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9jbGtf
ZGlzYWJsZShzdHJ1Y3QNCj4gPiA+IGRldmljZQ0KPiA+ID4gKmRldik7DQo+ID4gPiAgdm9pZCBt
dGtfb3ZsX2FkYXB0b3JfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcs
DQo+ID4gPiAgCQkJICAgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+
ID4gPiAgCQkJICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdA0KPiA+ID4gKmNt
ZHFfcGt0KTsNCj4gPiA+ICt1NjQgbXRrX292bF9hZGFwdG9yX2dldF9zZWNfcG9ydChzdHJ1Y3Qg
bXRrX2RkcF9jb21wICpjb21wLA0KPiA+ID4gdW5zaWduZWQNCj4gPiA+IGludCBpZHgpOw0KPiA+
ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYs
IHVuc2lnbmVkDQo+ID4gPiBpbnQNCj4gPiA+IGlkeCwNCj4gPiA+ICAJCQkJICBzdHJ1Y3QgbXRr
X3BsYW5lX3N0YXRlICpzdGF0ZSwNCj4gPiA+ICAJCQkJICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFf
cGt0KTsNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
DQo+ID4gPiBpbmRleCAyYmZmZTQyNDU0NjYuLjc2ZTgzMmU0ODc1YSAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gPiBAQCAtNDYsNiAr
NDYsNyBAQA0KPiA+ID4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX0FERFIob3ZsLCBuKQkJKChvdmwp
LT5kYXRhLQ0KPiA+ID4gPmFkZHIgKw0KPiA+ID4gMHgyMCAqIChuKSkNCj4gPiA+ICAjZGVmaW5l
IERJU1BfUkVHX09WTF9IRFJfQUREUihvdmwsIG4pCQkoKG92bCktPmRhdGEtDQo+ID4gPiA+IGFk
ZHIgKyAweDIwICogKG4pICsgMHgwNCkNCj4gPiA+IA0KPiA+ID4gICNkZWZpbmUgRElTUF9SRUdf
T1ZMX0hEUl9QSVRDSChvdmwsIG4pCQkoKG92bCktPmRhdGEtDQo+ID4gPiA+IGFkZHIgKyAweDIw
ICogKG4pICsgMHgwOCkNCj4gPiA+IA0KPiA+ID4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX1NFQ1VS
RQkJCTB4MGZjMA0KPiA+ID4gIA0KPiA+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9CSVRTCTE2
DQo+ID4gPiAgI2RlZmluZSBHTUNfVEhSRVNIT0xEX0hJR0gJKCgxIDw8IEdNQ19USFJFU0hPTERf
QklUUykgLyA0KQ0KPiA+ID4gQEAgLTEyNiw4ICsxMjcsMTkgQEAgc3RydWN0IG10a19kaXNwX292
bCB7DQo+ID4gPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YQkqZGF0YTsNCj4gPiA+
ICAJdm9pZAkJCQkoKnZibGFua19jYikodm9pZCAqZGF0YSk7DQo+ID4gPiAgCXZvaWQJCQkJKnZi
bGFua19jYl9kYXRhOw0KPiA+ID4gKwlyZXNvdXJjZV9zaXplX3QJCQlyZWdzX3BhOw0KPiA+ID4g
IH07DQo+ID4gPiAgDQo+ID4gPiArdTY0IG10a19vdmxfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtf
ZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludA0KPiA+ID4gaWR4KQ0KPiA+ID4gK3sNCj4gPiA+
ICsJaWYgKGNvbXAtPmlkID09IEREUF9DT01QT05FTlRfT1ZMMCkNCj4gPiA+ICsJCXJldHVybiAx
VUxMIDw8IENNRFFfU0VDX0RJU1BfT1ZMMDsNCj4gPiA+ICsJZWxzZSBpZiAoY29tcC0+aWQgPT0g
RERQX0NPTVBPTkVOVF9PVkwxKQ0KPiA+ID4gKwkJcmV0dXJuIDFVTEwgPDwgQ01EUV9TRUNfRElT
UF9PVkwxOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+
ID4gPiAgc3RhdGljIGlycXJldHVybl90IG10a19kaXNwX292bF9pcnFfaGFuZGxlcihpbnQgaXJx
LCB2b2lkDQo+ID4gPiAqZGV2X2lkKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IG10a19kaXNw
X292bCAqcHJpdiA9IGRldl9pZDsNCj4gPiA+IEBAIC00NDksOCArNDYxLDIyIEBAIHZvaWQgbXRr
X292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZQ0KPiA+ID4gKmRldiwNCj4gPiA+IHVuc2ln
bmVkIGludCBpZHgsDQo+ID4gPiAgCQkJICAgICAgRElTUF9SRUdfT1ZMX1NSQ19TSVpFKGlkeCkp
Ow0KPiA+ID4gIAltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIG9mZnNldCwgJm92bC0+
Y21kcV9yZWcsIG92bC0NCj4gPiA+ID4gcmVncywNCj4gPiA+IA0KPiA+ID4gIAkJCSAgICAgIERJ
U1BfUkVHX09WTF9PRkZTRVQoaWR4KSk7DQo+ID4gPiAtCW10a19kZHBfd3JpdGVfcmVsYXhlZChj
bWRxX3BrdCwgYWRkciwgJm92bC0+Y21kcV9yZWcsIG92bC0NCj4gPiA+ID4gcmVncywNCj4gPiA+
IA0KPiA+ID4gLQkJCSAgICAgIERJU1BfUkVHX09WTF9BRERSKG92bCwgaWR4KSk7DQo+ID4gPiAr
DQo+ID4gPiArCWlmIChzdGF0ZS0+cGVuZGluZy5pc19zZWMpIHsNCj4gPiA+ICsJCWNvbnN0IHN0
cnVjdCBkcm1fZm9ybWF0X2luZm8gKmZtdF9pbmZvID0NCj4gPiA+IGRybV9mb3JtYXRfaW5mbyhm
bXQpOw0KPiA+ID4gKwkJdW5zaWduZWQgaW50IGJ1Zl9zaXplID0gKHBlbmRpbmctPmhlaWdodCAt
IDEpICoNCj4gPiA+IHBlbmRpbmctPnBpdGNoICsNCj4gPiA+ICsJCQkJCXBlbmRpbmctPndpZHRo
ICogZm10X2luZm8tDQo+ID4gPiA+IGNwcFswXTsNCj4gPiA+IA0KPiA+ID4gKw0KPiA+ID4gKwkJ
bXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4KSwgJm92bC0+Y21kcV9yZWcsDQo+
ID4gPiBvdmwtPnJlZ3MsDQo+ID4gPiArCQkJCSAgIERJU1BfUkVHX09WTF9TRUNVUkUsIEJJVChp
ZHgpKTsNCj4gPiA+ICsJCW10a19kZHBfc2VjX3dyaXRlKGNtZHFfcGt0LCBvdmwtPnJlZ3NfcGEg
Kw0KPiA+ID4gRElTUF9SRUdfT1ZMX0FERFIob3ZsLCBpZHgpLA0KPiA+ID4gKwkJCQkgIHBlbmRp
bmctPmFkZHIsIENNRFFfSVdDX0hfMl9NVkEsIDAsDQo+ID4gPiBidWZfc2l6ZSwgMCk7DQo+ID4g
DQo+ID4gV2h5IHBhc3Mgb3ZsLT5yZWdzX3BhIGludG8gY21kcSBkcml2ZXI/IGNtZHEganVzdCBu
ZWVkIHN1YnN5cyBhbmQNCj4gPiBvZmZzZXQuDQo+IA0KPiBZZXMsIHRoYXQncyBub3QgbmVjZXNz
YXJ5IGFuZCBJIGNhbiByZWZpbmUgdGhhdCBpbiB0aGUgZnV0dXJlLg0KPiBCZWNhdXNlDQo+IHRo
aXMgY2hhbmdlIHdpbGwgYWxzbyBuZWVkIHRvIG1vZGlmeSB0aGUgY29kZSBpbiBDTURRIFBUQSwg
c28gSSdsbA0KPiBmaXgNCj4gb3RoZXIgaXNzdWVzIGluIG5vcm1hbCB3b3JsZCBmaXJzdC4gVGhl
biBJJ2xsIHJlZmluZSB0aGlzIHBsYWNlIGFmdGVyDQo+IGENCj4gZmV3IHZlcnNpb24uDQoNCkFk
ZCBUT0RPIGluZm9ybWF0aW9uIHNvIHRoYXQgd2Ugd291bGQgbm90IGZvcmdldCB0aGlzLg0KDQo+
IA0KPiA+IEluIGFkZGl0aW9uLCB3aHkgcGFzcyBidWZfc2l6ZT8NCj4gPiANCj4gDQo+IFRoaXMg
YnVmX3NpemUgaXMgdGhlIHBhcmFtZXRlciBmb3IgTTRVIFBUQSB0byB2ZXJpZnkgdGhlIHJhbmdl
IG9mDQo+IHNlY3VyZSBhZGRyZXNzIGluIHRoZSBzZWN1cmUgd29ybGQuDQoNCldoeSBuZWVkIHRo
aXMgdmVyaWZpY2F0aW9uPyBJbiBub3JtYWwgdmlkZW8gcGxheWJhY2ssIE00VSBkb2VzIG5vdA0K
dmVyaWZ5IHRoZSBzaXplLiBJZiBoYXJkd2FyZSBhY2Nlc3Mgb3V0IHJhbmdlIG9mIGFsbG9jYXRl
ZCBidWZmZXIsIGl0DQp3b3VsZCBjYXVzZSBNNFUgdG8gaGF2ZSB0cmFuc2xhdGlvbiBmYXVsdC4g
SSB0aGluayBzZWN1cmUgdmlkZW8gY291bGQNCmFsc28gaGF2ZSB0cmFuc2xhdGlvbiBmYXVsdCBz
byB0aGUgc2l6ZSB2ZXJpZmljYXRpb24gaXMgbm90IG5lY2Vzc2FyeS4NCg0KUmVnYXJkcywNCkNL
DQoNCg0KPiANCj4gUmVnYXJkcywNCj4gSmFzb24tSkguTGluDQo+IA0KPiA+IFJlZ2FyZHMsDQo+
ID4gQ0sNCj4gPiANCg==
