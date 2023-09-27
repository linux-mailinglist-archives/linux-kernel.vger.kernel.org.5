Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C327AFF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjI0JDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjI0JDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:03:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E31A7;
        Wed, 27 Sep 2023 02:03:02 -0700 (PDT)
X-UUID: a7ae21ae5d1411eea33bb35ae8d461a2-20230927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2oFyl0bCNi4UiolAJgxMkYAczqsNJ6ZdLVqICxI1Z6U=;
        b=iGcInU9CFXCuJOvxkO+uK8FjdcvglT0NjpFOgI4TbYWwIaiNOKmT3CXiGgxFA7k6IcLmFDUZNg+G8F2MEeXlBKrzdga6Ptcsg1Lbi5goH6tQ2OfDgt64h/TT/oUU0ZRXuMRMan4qSKo3P7h2TCew1iwZiOUFVxJEUwnKiNA5MuI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ee40ed1a-ae5d-43fc-8de8-3e143b481460,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:4a5031f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a7ae21ae5d1411eea33bb35ae8d461a2-20230927
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1638934091; Wed, 27 Sep 2023 17:02:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Sep 2023 17:02:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Sep 2023 17:02:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfj7T2l57fH5AYzhhe9cCPuHymP2fue3mtOpx1KFNYq0w8DZAaCFE1YrJ0+nm7z+UKwjPEwq0PXLaB3jAcvFejBgeva1XEqcNPMqriLMkT1xBU8PqkvdogC8a1zCutHslrRoEOoCv6PybPAB5rTdzuVo/uspuzSzR7pEGSYyN5q+G6ByY1e1uBNZwMsxv4qsdC/nVgJEF3VO9RqFBfRvDOdNhThesYE3b2rDeDW2cWw/h0Bu/mJp1Ep3hRh4vSaqAgKyHGuhxY2iFArbK456Qpj9WvHLIYb3BsZ0/GG+efqSZBjnxBOnr4Q+JuwvV8WU0lgMt72JIcgabqdtlU93EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oFyl0bCNi4UiolAJgxMkYAczqsNJ6ZdLVqICxI1Z6U=;
 b=RGXXX1EVr825ROs9yQmCgPLSf1Hxyk0TuAzsjB8SNqnDpESSU+kvUn7hIr1iyXYjmUVa/xTRxi3ONMbmwErM3VQ7foB1lE/hh9ypOT3hvh5Un4Ycnjt0MPNv6fhqlCJoNqaxhbYkGWIfOumwYxNkzHEPSBg5sv5AuNcBX8KBz9haVHbOvpja4SJnAgr9+KwtDmD5xrNqxc6WhX1R2PNOao6yoZ8yb7do5Z5Nfo94r5QCVEftVF6a95lyBUOwCfbWYVYrFAIeTzsBEXG9/Y/oCLEeWY5H93UKtN6+fu7ZYMCNDPIpRkMHi3hqh2d9LaIahwnJciw2dm7xKIDcejWW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oFyl0bCNi4UiolAJgxMkYAczqsNJ6ZdLVqICxI1Z6U=;
 b=rTdhIQQb5QOlPAKvVRl7CGbNgQl6Z7KA94FDRDMR+9Wn3SBGWO9bYlnJLDGEyWGIE+uOq66IbDVpZyAb/YsOHl3l+UKdSxSWc0b27dv6nzosSqKf76Y2qFFOo1orzoeOP4snjYt9z3qybi9dN8IhZ9l8FFh/bpKHbtHbl84cks8=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 09:02:55 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::2d8b:d64e:65cb:b7af]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::2d8b:d64e:65cb:b7af%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 09:02:55 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: mediatek: mt8195: add MDP3 nodes
Thread-Topic: [PATCH v6 2/2] arm64: dts: mediatek: mt8195: add MDP3 nodes
Thread-Index: AQHZ7SEQyr7yMSAUSUyihLRfG56LCLAmg5OAgAfk9wA=
Date:   Wed, 27 Sep 2023 09:02:55 +0000
Message-ID: <70f42b1e85717c84b1ee64757a7163420c64aed0.camel@mediatek.com>
References: <20230922065017.10357-1-moudy.ho@mediatek.com>
         <20230922065017.10357-3-moudy.ho@mediatek.com>
         <a41148b8-295a-58ad-7c72-2713d89e4f83@collabora.com>
In-Reply-To: <a41148b8-295a-58ad-7c72-2713d89e4f83@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SEYPR03MB6700:EE_
x-ms-office365-filtering-correlation-id: f0d933f9-1c51-48b8-74d5-08dbbf3889da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3cHPEb4ddu1+U8H0AxPqraSVyD4i5ej8OytsODIBmgzmCWZWbY1HmRK43Cw+Hhq7Vqyhh2o/3G+Au3EWBclX8AnpuSdtCSP94fg/YT/6vK+6Y7WFCatKhudksWhMxWgGODUji8E0Ih4Smg9UlKlAslNrQu/MNLYURfXI7hVtwNfKlIozq75rGBHMnN5AVzElQuus9ZuSMRTMGnOey/GYkOPhK2AM8ZhTQO5LCD9Jj03lfteiL06EQ4JR2iQP4nG1P5xpVlfz0GWO8ivm50ioq9nhzMyZm45KAh+FPGeo81q/yrqnjbtSTSGa5gwq/+v8SqSynbKeb6AoX2pnLT/nGsXGO9Q09OWE8xz3eLJ6TqtfHqXiI+svQQF+mPrM8ZyMkwmhseMTGlyaMqrl6ITPPN5aPfzkbY3Kw8gv/GLU0Gzqd7Fl9xtd+zNM+RJRLKrhRnH6z8BTbT2BM1V7Mkg7n2DsHqUi5ckDvMrazNP1FqObXQKXP9n7xZ793vvr2h2NCw2l2zJhT1w1GwMDsSu/1MGeQ856s/oi4Fo2bGPFu6W3pT4pQ83tFs/9li5ODjK5PFTCOoiMByvcFly8RF7EMJsxHj0x6sfOa481s9U0SxLX71zXBTtafpKv1PgimsH8uBl7lWP0gm0rhquNHvqw8rJNWYm6kB+KVZmKjp0DfzpgUAORoP9WN6s9E7UnC2i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(66946007)(41300700001)(316002)(4326008)(83380400001)(2906002)(66446008)(54906003)(8936002)(5660300002)(8676002)(85182001)(36756003)(86362001)(76116006)(66476007)(71200400001)(26005)(6512007)(66556008)(6486002)(478600001)(64756008)(6506007)(38070700005)(110136005)(122000001)(38100700002)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJEcE1ZRzlRUUl5WkIrNW1jWHhIeDZnbmhnME1YSlhNbW5UVVJxdSt2Y0ZW?=
 =?utf-8?B?cXVZa29aM3l2VStnaW85cnVEa2M0anB6VkNUUDF5VEpZeFdHOW1zMGtNVTJt?=
 =?utf-8?B?cUszeFdVeGNXVEZOQjh1eFlVUURJNGIySk9mUUNpT21LVURISG9sRFIyK3Vh?=
 =?utf-8?B?cmM5ckFCb244dGdYdUxBc2k0eXczazhyL2x2WFZuRVJ4TVBWNzF1VFcrU2V3?=
 =?utf-8?B?UXFXczZCWXZSb3crQ2FGVWNGWm54V3ppTW90cm9OYW82MmpzQVJiMElRZmo2?=
 =?utf-8?B?MmtFb25ZSHluN2pMTmpWUCtYWVU0K3JoSzNvR3ROS1kwYXNJWGVud1JvT3pR?=
 =?utf-8?B?M0d1aXVuOGpWUkpjWjR2YXhwcXowR2JVNW1jUzN1ZlMyeld3SnhLN3dIOTA5?=
 =?utf-8?B?NzFWT2RudDhoUG1kTUxmc1hFbFZONUVnUGJTcm51VEcyU1phZ0R3VkxIWGdK?=
 =?utf-8?B?cEZ1Z0R3RzBqL0poa0JGUFpmVkpaUlRWZFB1MXVUMkNvZWZMcFVSbFZtRmpS?=
 =?utf-8?B?NThDYWRBMGFzSXdSSDFqbFVMa3I3YTkwU1cxTCtOZ3BJbnJDYmx1cE9RU2Vm?=
 =?utf-8?B?dmo0eVRJNmhTODZrVjhmL2VwTGhKK2U3RzBDZmxmU29ldWhXZnFXZGdnMTJH?=
 =?utf-8?B?TmRlRTZ5aHBrWUFrMEZ4NlhFWFBheEFEbEZ1V1F6WGo2RGZoTTlJZTc0QjFp?=
 =?utf-8?B?aHpWaWhnNXpsMTFXOGxYdGMyamFDMmNVak9LSG1XVXdqMnpCVVJnZkFRODlt?=
 =?utf-8?B?eTZiT3YxS0IxdUVWSjBycFZLQ2pndkxHVkNpMTVNN01wUUFpZU1ieHVyN01z?=
 =?utf-8?B?SzdmejMvaXZ2Ym1ETExHdXBpQlBsazZkUm8xWGh1akZoWWxtVFRJbVk3OHJH?=
 =?utf-8?B?VFJFbTFCVDRGRzdqazdvaW1kdTNTQkpmcjJIVkYvRElEV3loaVlhU0lta1ZJ?=
 =?utf-8?B?NkxCLzBxTUtzZHI3ckZvazB4aGg0K3Z0eEZKa0pESHRGR082d2pKWjFBQTFm?=
 =?utf-8?B?Q1FrK09jZFUvTmdrL21qdmM0RGd2VkJxUHVVenlycEx0TVg5dVphaTU2dUN1?=
 =?utf-8?B?d1dSdHozdmR0ZjVXVjg1WnBSRjhCMldrWUU2UkJocXR3c29qamFDYzlUZm9u?=
 =?utf-8?B?QkV2SWtrUkczMkFOdlVudWxUWFlabGo1Rm5seHlvakl1bU5kamsyQUh0czdj?=
 =?utf-8?B?MWZOUEhNOFN5bExmMExKYUtDOXdJekt4NFRHNU15dWhnWXBUbnVrWW9OQTNW?=
 =?utf-8?B?cG84SkZhYmlHTGhiTWJSblRzQzV0am5WeE8zSFdSekpndGJ3RkY0L1R3eERO?=
 =?utf-8?B?bnhtMjhhQmExMWlXTWM5WDVSUzQza0U0OVBUbWl0QVhSeUc5Yi8ydnF3TlQ2?=
 =?utf-8?B?VEV2UlliYzVvdXhybzg2b1I3Q1dzdzNERDlaNkE2UDJHMllkcHUvc0d1Ylcv?=
 =?utf-8?B?RWtpY1FoTGFZcnJmWkVmdGtaWXJocDh2ZGp2SW9ac1M4VWxNRUFtcXgyTFZ6?=
 =?utf-8?B?M2k2ejNaUFBkaE01Y1VpaDcrcjFxdmpuZkQ0SnZNYWcxL2EvRkhhNjRSMG8x?=
 =?utf-8?B?aUtJS2dubDRWTUdsZ2lsbFRYV2dGQk8zZ0FNUmdPQUwrYWNtTmpHRTk2WEwv?=
 =?utf-8?B?OWpaQnpDN1ZIZ1Zwd3pjYTRRZnp0MERwNkhkSVJEelZpMmdsNjI2cENnU3Ez?=
 =?utf-8?B?dC9pbXVlOXJUUGQ1OVNJM1paSTNzOFVUYnIwUzhuM1QyL05kdjlEWUVSTE03?=
 =?utf-8?B?SlY3TkEzU1JPR1dYTCsxbXhsbFpVcGRZYTN0WDhFVzdIaTNVbHU0cW5Ra0Vj?=
 =?utf-8?B?eDhubXo4eTBRY0dDWUhhRUFZMHpyRVYvSVhNL0NTSFpnL2psRk1sY0VnUGwz?=
 =?utf-8?B?NStnK0pZY2xFUTNnWFVyYnM2UkVyV1ZFVzNKaXFKWVhlWjh5YVJoY3kyVjkw?=
 =?utf-8?B?ODJJVjZxLzZrVVNsOFllSXBKYTFYQkZwWWl5OHZ4NWtOeDJad3A1T28vZjFw?=
 =?utf-8?B?WFU2Zjc5ZlNVZzBaOEU2alQ2UzMyZktJTU02SEpiSDJkNHVqaC9McEZqTzU0?=
 =?utf-8?B?bXJqSFp3WGVjcHBpN2JLTW5meit3N3RvVWYxK1QxbmdrMDd2b05GOGhuOEdv?=
 =?utf-8?B?Y0dGSE5SV21kYS9oS3J2SzFVVnlLNEdzTHJSZTJRL1JPME53bjZkWk9EUkZD?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD221A89D0229946B5B1CA4A979F5F7D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d933f9-1c51-48b8-74d5-08dbbf3889da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:02:55.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUPjg331/CmIqzJ39vDaGDQmJ2jLSfwUBJiIuVPA1wbXLNKAQQZIOONG+eXrGK7tQm6ScVh6S9EQ3boKflJvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6700
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDEwOjI5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjIvMDkvMjMgMDg6NTAsIE1vdWR5IEhvIGhhIHNjcml0dG86DQo+
ID4gQWRkIGRldmljZSBub2RlcyBmb3IgTWVkaWEgRGF0YSBQYXRoIDMgKE1EUDMpIG1vZHVsZXMu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTW91ZHkgSG8gPG1vdWR5LmhvQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0
c2kgfCAzODgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDM4OCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiBpbmRleCA0ZGJiZjhmZGFiNzUuLmNmNjFiYTdiODk1
NiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5k
dHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0K
PiA+IEBAIC0xOTYwLDYgKzE5NjAsMTE0IEBADQo+ID4gICAJCQkjY2xvY2stY2VsbHMgPSA8MT47
DQo+ID4gICAJCX07DQo+ID4gICANCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+ICsNCj4gPiArCQlk
aXNwbGF5QDE0MDA2MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
bWRwMy1yc3oiOw0KPiANCj4gUGxlYXNlIGFsd2F5cyBhZGQgYSBTb0Mtc3BlY2lmaWMgY29tcGF0
aWJsZSAoYm90aCBoZXJlIGFuZCBpbg0KPiBiaW5kaW5ncykuDQo+IA0KPiBjb21wYXRpYmxlID0g
Im1lZGFpdGVrLG10ODE5NS1tZHAzLXJzeiIsICJtZWRpYXRlayxtdDgxODMtbWRwMy1yc3oiOw0K
PiANCj4gPiArCQkJcmVnID0gPDAgMHgxNDAwNjAwMCAwIDB4MTAwMD47DQo+ID4gKwkJCW1lZGlh
dGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UxDQo+ID4gU1VCU1lTXzE0MDBYWFhYIDB4NjAwMCAw
eDEwMDA+Ow0KPiA+ICsJCQltZWRpYXRlayxnY2UtZXZlbnRzID0NCj4gPiA8Q01EUV9FVkVOVF9W
UFAwX01EUF9SU1pfSU5fUlNaX1NPRj4sDQo+ID4gKwkJCQkJICAgICAgPENNRFFfRVZFTlRfVlBQ
MF9NRFBfUlNaXw0KPiA+IEZSQU1FX0RPTkU+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JnZwcHN5czAg
Q0xLX1ZQUDBfTURQX1JTWj47DQo+ID4gKwkJfTsNCj4gPiArDQo+IA0KPiAuLnNuaXAuLg0KPiAN
Cj4gPiArDQo+ID4gKwkJZG1hLWNvbnRyb2xsZXJAMTQwMGMwMDAgew0KPiA+ICsJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE4My1tZHAzLXdyb3QiOw0KPiANCj4gc2FtZSBoZXJlDQo+IA0K
PiA+ICsJCQlyZWcgPSA8MCAweDE0MDBjMDAwIDAgMHgxMDAwPjsNCj4gPiArCQkJbWVkaWF0ZWss
Z2NlLWNsaWVudC1yZWcgPSA8JmdjZTENCj4gPiBTVUJTWVNfMTQwMFhYWFggMHhjMDAwIDB4MTAw
MD47DQo+ID4gKwkJCW1lZGlhdGVrLGdjZS1ldmVudHMgPQ0KPiA+IDxDTURRX0VWRU5UX1ZQUDBf
TURQX1dST1RfU09GPiwNCj4gPiArCQkJCQkgICAgICA8Q01EUV9FVkVOVF9WUFAwX01EUF9XUk9U
DQo+ID4gX1ZJRE9fV0RPTkU+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JnZwcHN5czAgQ0xLX1ZQUDBf
TURQX1dST1Q+Ow0KPiA+ICsJCQlpb21tdXMgPSA8JmlvbW11X3ZwcCBNNFVfUE9SVF9MNF9NRFBf
V1JPVD47DQo+ID4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNwbQ0KPiA+IE1UODE5NV9QT1dFUl9E
T01BSU5fVlBQU1lTMD47DQo+ID4gKwkJCSNkbWEtY2VsbHMgPSA8MT47DQo+ID4gKwkJfTsNCj4g
PiArDQo+ID4gICAJCW11dGV4QDE0MDBmMDAwIHsNCj4gPiAgIAkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTk1LXZwcC1tdXRleCI7DQo+ID4gICAJCQlyZWcgPSA8MCAweDE0MDBmMDAwIDAg
MHgxMDAwPjsNCj4gPiBAQCAtMjEwNyw2ICsyMjE1LDI4NiBAQA0KPiA+ICAgCQkJcG93ZXItZG9t
YWlucyA9IDwmc3BtDQo+ID4gTVQ4MTk1X1BPV0VSX0RPTUFJTl9WUFBTWVMxPjsNCj4gPiAgIAkJ
fTsNCj4gPiAgIA0KPiANCj4gLi5zbmlwLi4NCj4gDQo+ID4gKw0KPiA+ICsJCWRpc3BsYXlAMTRm
MTQwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1tZHAzLXJzeiI7
DQo+IA0KPiBhbmQgaGVyZQ0KPiANCj4gPiArCQkJcmVnID0gPDAgMHgxNGYxNDAwMCAwIDB4MTAw
MD47DQo+ID4gKwkJCW1lZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UxDQo+ID4gU1VCU1lT
XzE0ZjFYWFhYIDB4NDAwMCAweDEwMDA+Ow0KPiA+ICsJCQltZWRpYXRlayxnY2UtZXZlbnRzID0N
Cj4gPiA8Q01EUV9FVkVOVF9WUFAxX1NWUFAxX01EUF9SU1pfU09GPiwNCj4gPiArCQkJCQkgICAg
ICA8Q01EUV9FVkVOVF9WUFAxX1NWUFAxX01EDQo+ID4gUF9SU1pfRlJBTUVfRE9ORT47DQo+ID4g
KwkJCWNsb2NrcyA9IDwmdnBwc3lzMSBDTEtfVlBQMV9TVlBQMV9NRFBfUlNaPjsNCj4gPiArCQl9
Ow0KPiA+ICsNCj4gPiArCQlkaXNwbGF5QDE0ZjE1MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODMtbWRwMy1yc3oiOw0KPiANCj4gLi4uYW5kIGhlcmUNCj4gDQo+ID4g
KwkJCXJlZyA9IDwwIDB4MTRmMTUwMDAgMCAweDEwMDA+Ow0KPiA+ICsJCQltZWRpYXRlayxnY2Ut
Y2xpZW50LXJlZyA9IDwmZ2NlMQ0KPiA+IFNVQlNZU18xNGYxWFhYWCAweDUwMDAgMHgxMDAwPjsN
Cj4gPiArCQkJbWVkaWF0ZWssZ2NlLWV2ZW50cyA9DQo+ID4gPENNRFFfRVZFTlRfVlBQMV9TVlBQ
Ml9NRFBfUlNaX1NPRj4sDQo+ID4gKwkJCQkJICAgICAgPENNRFFfRVZFTlRfVlBQMV9TVlBQMl9N
RA0KPiA+IFBfUlNaX0ZSQU1FX0RPTkU+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JnZwcHN5czEgQ0xL
X1ZQUDFfU1ZQUDJfTURQX1JTWj47DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJZGlzcGxheUAx
NGYxNjAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLW1kcDMtcnN6
IjsNCj4gDQo+IC4uLi4uLmFuZCBoZXJlLg0KPiANCj4gPiArCQkJcmVnID0gPDAgMHgxNGYxNjAw
MCAwIDB4MTAwMD47DQo+ID4gKwkJCW1lZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UxDQo+
ID4gU1VCU1lTXzE0ZjFYWFhYIDB4NjAwMCAweDEwMDA+Ow0KPiA+ICsJCQltZWRpYXRlayxnY2Ut
ZXZlbnRzID0NCj4gPiA8Q01EUV9FVkVOVF9WUFAxX1NWUFAzX01EUF9SU1pfU09GPiwNCj4gPiAr
CQkJCQkgICAgICA8Q01EUV9FVkVOVF9WUFAxX1NWUFAzX01EDQo+ID4gUF9SU1pfRlJBTUVfRE9O
RT47DQo+ID4gKwkJCWNsb2NrcyA9IDwmdnBwc3lzMSBDTEtfVlBQMV9TVlBQM19NRFBfUlNaPjsN
Cj4gPiArCQl9Ow0KPiA+ICsNCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+ICsNCj4gPiArCQlkbWEt
Y29udHJvbGxlckAxNGYyMzAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTgzLW1kcDMtd3JvdCI7DQo+IA0KPiAuLi5hZ2Fpbi4uLiBhbmQgZm9yIHRoZSBvdGhlciB0d28g
b2NjdXJyZW5jZXMgb2Ygd3JvdCBhcyB3ZWxsLg0KPiANCj4gQXBhcnQgZnJvbSB0aGF0LCBsb29r
cyBnb29kLg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpIaSBBbmdlbG8sDQoNClRo
YW5rIHlvdSBmb3IgdGhlIGFkdmljZSwgSSB3aWxsIGluY2x1ZGUgdGhlIGFwcHJvcHJpYXRlIGNv
bXBhdGlibGUNCm5hbWVzIHRvIHRoZSBzcGVjaWZpZWQgbG9jYXRpb25zLg0KDQpTaW5jZXJlbHks
DQpNb3VkeQ0KPiA+ICsJCQlyZWcgPSA8MCAweDE0ZjIzMDAwIDAgMHgxMDAwPjsNCj4gPiArCQkJ
bWVkaWF0ZWssZ2NlLWNsaWVudC1yZWcgPSA8JmdjZTENCj4gPiBTVUJTWVNfMTRmMlhYWFggMHgz
MDAwIDB4MTAwMD47DQo+ID4gKwkJCW1lZGlhdGVrLGdjZS1ldmVudHMgPQ0KPiA+IDxDTURRX0VW
RU5UX1ZQUDFfU1ZQUDFfTURQX1dST1RfU09GPiwNCj4gPiArCQkJCQkgICAgICA8Q01EUV9FVkVO
VF9WUFAxX1NWUFAxX01EDQo+ID4gUF9XUk9UX0ZSQU1FX0RPTkU+Ow0KPiA+ICsJCQljbG9ja3Mg
PSA8JnZwcHN5czEgQ0xLX1ZQUDFfU1ZQUDFfTURQX1dST1Q+Ow0KPiA+ICsJCQlpb21tdXMgPSA8
JmlvbW11X3Zkbw0KPiA+IE00VV9QT1JUX0w1X1NWUFAxX01EUF9XUk9UPjsNCj4gPiArCQkJcG93
ZXItZG9tYWlucyA9IDwmc3BtDQo+ID4gTVQ4MTk1X1BPV0VSX0RPTUFJTl9WUFBTWVMxPjsNCj4g
PiArCQkJI2RtYS1jZWxscyA9IDwxPjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQlkbWEtY29u
dHJvbGxlckAxNGYyNDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LW1kcDMtd3JvdCI7DQo+ID4gKwkJCXJlZyA9IDwwIDB4MTRmMjQwMDAgMCAweDEwMDA+Ow0KPiA+
ICsJCQltZWRpYXRlayxnY2UtY2xpZW50LXJlZyA9IDwmZ2NlMQ0KPiA+IFNVQlNZU18xNGYyWFhY
WCAweDQwMDAgMHgxMDAwPjsNCj4gPiArCQkJbWVkaWF0ZWssZ2NlLWV2ZW50cyA9DQo+ID4gPENN
RFFfRVZFTlRfVlBQMV9TVlBQMl9NRFBfV1JPVF9TT0Y+LA0KPiA+ICsJCQkJCTxDTURRX0VWRU5U
X1ZQUDFfU1ZQUDJfTURQX1dST1QNCj4gPiBfRlJBTUVfRE9ORT47DQo+ID4gKwkJCWNsb2NrcyA9
IDwmdnBwc3lzMSBDTEtfVlBQMV9TVlBQMl9NRFBfV1JPVD47DQo+ID4gKwkJCWlvbW11cyA9IDwm
aW9tbXVfdmRvDQo+ID4gTTRVX1BPUlRfTDVfU1ZQUDJfTURQX1dST1Q+Ow0KPiA+ICsJCQlwb3dl
ci1kb21haW5zID0gPCZzcG0NCj4gPiBNVDgxOTVfUE9XRVJfRE9NQUlOX1ZQUFNZUzE+Ow0KPiA+
ICsJCQkjZG1hLWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCWRtYS1jb250
cm9sbGVyQDE0ZjI1MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
bWRwMy13cm90IjsNCj4gPiArCQkJcmVnID0gPDAgMHgxNGYyNTAwMCAwIDB4MTAwMD47DQo+ID4g
KwkJCW1lZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UxDQo+ID4gU1VCU1lTXzE0ZjJYWFhY
IDB4NTAwMCAweDEwMDA+Ow0KPiA+ICsJCQltZWRpYXRlayxnY2UtZXZlbnRzID0NCj4gPiA8Q01E
UV9FVkVOVF9WUFAxX1NWUFAzX01EUF9XUk9UX1NPRj4sDQo+ID4gKwkJCQkJPENNRFFfRVZFTlRf
VlBQMV9TVlBQM19NRFBfV1JPVA0KPiA+IF9GUkFNRV9ET05FPjsNCj4gPiArCQkJY2xvY2tzID0g
PCZ2cHBzeXMxIENMS19WUFAxX1NWUFAzX01EUF9XUk9UPjsNCj4gPiArCQkJaW9tbXVzID0gPCZp
b21tdV92cHANCj4gPiBNNFVfUE9SVF9MNl9TVlBQM19NRFBfV1JPVD47DQo+ID4gKwkJCXBvd2Vy
LWRvbWFpbnMgPSA8JnNwbQ0KPiA+IE1UODE5NV9QT1dFUl9ET01BSU5fVlBQU1lTMT47DQo+ID4g
KwkJCSNkbWEtY2VsbHMgPSA8MT47DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gICAJCWltZ3N5czog
Y2xvY2stY29udHJvbGxlckAxNTAwMDAwMCB7DQo+ID4gICAJCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5NS1pbWdzeXMiOw0KPiA+ICAgCQkJcmVnID0gPDAgMHgxNTAwMDAwMCAwIDB4MTAw
MD47DQo+IA0KPiANCg==
