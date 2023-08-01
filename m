Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD76A76B1A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHAKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjHAKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:21:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A526BD;
        Tue,  1 Aug 2023 03:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxeKtzXEMZ7WkwaRsV2MfigGEayl9AFT8+SKIeTRBacIlarOCzP7ZOUJT1L2uCXWfW8fT/t9ZiWMJyd9DXGxWg9mTUBlIw0gI/yqi7luam8//29yyXg/A7agnFs7wmCBROrWJWzXBPtirgb+0qSakXGmXKiG01AqtJ23XwKbXcQTd1QS0Wr1UvWdKYX5dr1aywWl+jOjM5dZwJoXq5+dJn16b1yheK0BwjKH9LgQ54MVR7WlBdEGhnFG0IRLVO6g3svVr7c9cSq9bKjbCm8ayI1wk00rJccSmnBkJRiCRhxBoa2L3P5WozjtckZ2V0XaojYYhQdR7r+XDgr8rZBhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SvGw6R0j2E7bWlMiJkFJUTZK1y4xupAol0iVkNFKI8=;
 b=fsIEvnXbyQ7WTY9ElbaPtI453HP+qSoODmeukPXri4IVg7X/W8UOURd2WU+EODzVo8/VeFnBQtciQeBlfpd4tfLXhR04T7ObIGp9DAZuiD5Z1+nB6PTBQQ2GqXw+U44fDE+eQSVqO4Gc9Qvtmm+GqlTlagIMQTlrQhzSAQ+Yal8OCFQA019aFrh0veTEWiY1idd8F1c3ktp030K0mEUeHBmV3cvshQ5h25Z6TCRJx5xEi9J/gIU/hLarCHNs/xSIzkrdqLQT5QIwqByRboNk2rysUJ904L3MBo8jY3biXrnCgjd3h5Od9NkjFzK4Pu5s3s8fezF0NBwTgoeyEDFDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SvGw6R0j2E7bWlMiJkFJUTZK1y4xupAol0iVkNFKI8=;
 b=oPEvgrglADH3KBrc3UGSIUkmBtv5HUqfr76PoLfYM0rKY69ycgn7T8YaUjivCWPyxKjaB8McYBzuh89+o8Cazyw8HgngNmfI2+/lWNrxK+mU11z/iMh34z0VjM8B4S0Dfz4LlqnogVZxCZq8dNXLWujbYFVi1IDpR+/k1zHKUnY=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DBBPR04MB7770.eurprd04.prod.outlook.com (2603:10a6:10:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 10:17:11 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::8023:8aa8:aa19:cf90]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::8023:8aa8:aa19:cf90%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 10:17:11 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 3/3] arm64: dts: imx93-11x11-evk: add
 pca9451a support
Thread-Topic: [EXT] Re: [PATCH v1 3/3] arm64: dts: imx93-11x11-evk: add
 pca9451a support
Thread-Index: AQHZk4yW+KgeEbOXlUai7nJW30C13q90PAWAgGFCM6A=
Date:   Tue, 1 Aug 2023 10:17:11 +0000
Message-ID: <AM6PR04MB59252C1614813A96577F1513E10AA@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-4-joy.zou@nxp.com>
 <d178be98-189c-44af-a55a-e0a46747fe61@sirena.org.uk>
In-Reply-To: <d178be98-189c-44af-a55a-e0a46747fe61@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|DBBPR04MB7770:EE_
x-ms-office365-filtering-correlation-id: 153f9439-708c-49cf-0089-08db92787863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /EclawBuQREMUhVGoOffiLNzriBg1FSxTDsRDGp0zTN1VYFgz1KOPH3lmNhsF4rm9qi7O6cwea1L+a4POHgK7X9lVmpdhtDv38oZcTYUMg1uJfAd0vjI626oR+25fzorEMEZUrglyPiWYGcVVmIstJ7R4kHp5l2MQdA1cT5SkCF5+nMFWJIuoftohwQWY47Ex4aaLaUgLqKcFPHsYdUThUMm5Odjoj9dvN7iGgmLeGbpeX6B7k7wSHRLd4J7LrEqYw8MK21JZ2DcFfveXWQaAc935HDVfXiMiGfo5XNM3Ey+xeMD49GKwiwQqaMYOqVcjBKz7EewrnmnBVqYVpqGFnPzJ3BIBPcHoUW2YHFpN1raZ3/esXcArq/kAoMfB0CTPPVn/cMvzTJUzgMp5zDCmBjAZlFkW+2U/mYY8nPuEPZrCF+2wywSCAZTk0U/O3fzi9laJVzUtawJ8MikaKzTiv4uViro0Fsi2L2TVUWaEUgv+1IqR/8ZeG9ujDQf7AUi6ytJNaLvmUBUGZz+E/UZnFJ/8q1dUhEC8k22lBXrvNW5Ccs3TAWY0BlUK2+VNh1SUFjgYQGIlVxDbo5sQEzNTzgFnPA+14dUX7cfMbiXpkA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(86362001)(66476007)(316002)(8936002)(6916009)(8676002)(66446008)(64756008)(4326008)(5660300002)(41300700001)(7416002)(122000001)(54906003)(38100700002)(33656002)(66556008)(52536014)(66946007)(76116006)(38070700005)(478600001)(45080400002)(2906002)(71200400001)(44832011)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(53546011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bEtBQ0xOQzNpQVpOUUx5dDZsREdGbEhmSis4NkRwRUNHTVRHVnBhYVpDZVZo?=
 =?gb2312?B?MlBBUzVtalNKOXlpSlg0SXd3TFgxUHo4UmRtTytMVWttYVJjaExKUTRHLytr?=
 =?gb2312?B?U01rdnZqL3haWXZFTDZIbDJjOW5zOWVqdGRaMzAxSndFSWE1ZkJTZkdhTjRK?=
 =?gb2312?B?ZzZUMHJ4aW1qZGU3ODhsRElINGNuV1NNblM5NFJ4c1k2QzZjODVvTDNDVGky?=
 =?gb2312?B?Znd3NUFNdHFnZU9nN2l5MlhUNjZ3cnlWNm96K3pCa28rY1didnluaFVZSldo?=
 =?gb2312?B?WmwwOU1UenBNZjFSSnY3VkdJUHBUTVFVVmtId0tVQVMwQ1dvbnBGWXVja1hv?=
 =?gb2312?B?S3VPRGVkRlV0V2FCRUEwMjFKTnp6YkI4T3kzK3lLQVFTZldSVHF3OGtEZTBC?=
 =?gb2312?B?UXpaV2tWdFFXejBadW5DQ0h1Y1EvNTNSRHdlaEZIbHA3bTU5Vms0bVFLd2gx?=
 =?gb2312?B?Z2JzL0VaRXRES2FzaEhOZUJFSEM0RGphVlNWRVE1a3I5VzFkQXNGT0U3c05U?=
 =?gb2312?B?T1FlVitVNUw2L0NwQnUwQUZRblJFbjdXT0JTQmpoZ2VqYTBtRFE5d0dhblho?=
 =?gb2312?B?bDVCdVJXT2VpNCtvaG5SNjNNRkFmb2NodTVHb0pmWEsrdldyQ3hMUDdnd2tZ?=
 =?gb2312?B?QjJrSGVOWXlrVExMTVhwcWdrMi9BQnJoa2I2YTJLRTF1UXRaOGNRelhyQ2xz?=
 =?gb2312?B?UThOU3dVS3haNHNZWnh6N3lNVm8rK2Z6SzVFT1pMdHZmQXhXeUY5VUZIamo3?=
 =?gb2312?B?M0l2Rm1wcVBrZVZrZ2FqS1RhQ3N2VmJpeTg4MnFGWkZqbGlTZWVQczc1UVpo?=
 =?gb2312?B?VlpOenFCSFdLTHpQZExzWnVnV28rZzFnUElaSGErMG5XZGtZN2lQVUMyRlRk?=
 =?gb2312?B?UlVucXdyWStIUFMyUm8vOTJkQ1VqTVRsUTJXMWp0TWZHaFFQRDB4aTBodDE2?=
 =?gb2312?B?Tm9XQTNTMFA2cW5nTXNjZXB0a05NTGlEUDI4ZENuUWRUUUNMdnNVWURDMTNL?=
 =?gb2312?B?MmRLR09xZnc3WU9LSktWTmpwOXVpbzdOZmRJTDVKaHZTcGl3MjNwckk4cFBT?=
 =?gb2312?B?ZkR5NXI2UGFwQXM5VHpncHZ0RmtQSHl1bTc1aEhCQStxR21XODFlajlENXJw?=
 =?gb2312?B?WGk5NDdyemF4OTJvaktsY0lpTWhFVG5sS2M5OHZQWnJEczEwbHpWNHVTN1ll?=
 =?gb2312?B?NERUbzRDSytnaUlpcnVvTlNlMmxBT0RpbW41L2l6NE03NTJTYXdWM1VsbzNz?=
 =?gb2312?B?RjhFWWlqWVBUWXhtY3V3VXRuajl6V2J1VzA4QnFiR0dFeTNyUTNBays3cHZ3?=
 =?gb2312?B?VGhKUFJkaGF1b3JHQTQ1ZWJjOEhRd2pEeStONitSRjg2VTRRQnllK1hxREhM?=
 =?gb2312?B?aHcwWnpyUFR4OXRwNWVHc1QwR2lnTXRTanBKaHZMUW1rU3YyRmFBQk9lWEZF?=
 =?gb2312?B?UWozZi9vb1ZCZVI0bnJ3b2JldlBiek8xMEE0cTZEbDVxNGptWHcvclArc3Az?=
 =?gb2312?B?bWo3dDZkc1RlTUNUYXFhTzBZMXFMVU5sOEVyYXdka2lmbnV0WlQ0ejVkQTN1?=
 =?gb2312?B?bmlzSVU0a054dVNsN1VrcjRZMnY0N1ZZcEh6ZEt2U05hTzQ0eWRUNU1ORmFy?=
 =?gb2312?B?YUUxRzhUeFdNR3hNUWdiQktlcGtSTFlqOUkwcUhmTStud0ZQYW9BdmdTemxH?=
 =?gb2312?B?WkVOR3BoWFFFSFdDNVBMeW1FYVVuUkI5MERDWkRaeGRKUVVpS3dNSzErcmUr?=
 =?gb2312?B?bFQrcFZBSXQ2dlgyZHJuNHdQc2l5Uk1NU1BLVVdaeEJSNW9JV2VsVFdvMGs1?=
 =?gb2312?B?K0FpeU9XUFh5WFJMQXpzbElJbXJaM01GK09MYkh4a2xHWEtKMzhvOVpqOG1t?=
 =?gb2312?B?R1ordXUrdXZGY2pmTjYvZkRweVFuMzFOYUZkQzJ3cGp3TC80b2lJcFlGUlJh?=
 =?gb2312?B?WG03RC9iRnRJVzJQQnlESXJnMzdGZ2NuenRLaVhpRmVqaGJiblczWEFzTTBy?=
 =?gb2312?B?QjBVUXBEa3RrdmpIam1sWWhGTWo3OTduMEs0TXBxa09uQlhIMXRzeHYwMmF5?=
 =?gb2312?B?NkFJUlFhUFVWaWdTdUZjNSszVi8yeVVUUTFVYk5hcGE4djNQUEFVamN4ajFi?=
 =?gb2312?Q?S/iQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153f9439-708c-49cf-0089-08db92787863
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 10:17:11.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mW6VLlQ+wKVW/BQDYGu0lce+PesntrE33oFqvJrExyVsKKiajHaqhIJXHlSne/wc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqNdTCMzHI1SAxOToxOA0KPiBUbzogSm95IFpv
dSA8am95LnpvdUBueHAuY29tPg0KPiBDYzogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsg
bGdpcmR3b29kQGdtYWlsLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsN
Cj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxIDMvM10gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBhZGQgcGNhOTQ1
MWENCj4gc3VwcG9ydA0KPiANCj4gT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMDI6NTc6MjRQTSAr
MDgwMCwgSm95IFpvdSB3cm90ZToNCj4gDQo+ID4gKwkJcmVndWxhdG9ycyB7DQo+ID4gKwkJCWJ1
Y2sxOiBCVUNLMSB7DQo+ID4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJCVUNLMSI7DQo+ID4gKwkJ
CQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw2NTAwMDA+Ow0KPiA+ICsJCQkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MjIzNzUwMD47DQo+IA0KPiBUaGVzZSBsb29rIGEgbG90IGxpa2Ug
dGhlIG1heGltdW0gcmFuZ2VzIHRoZSByZWd1bGF0b3Igc3VwcG9ydHMgd2hpY2gNCj4gcHJvYmFi
bHkgaXNuJ3Qgd2hhdCdzIHNhZmUgZm9yIHRoZSBib2FyZC4NClNvcnJ5IGZvciBsYXRlIHJlcGx5
LiBCZWNhdXNlIG15IG91dGxvb2sgZmlsdGVyIHJ1bGUgaGFzIGlzc3VlLg0KVGhlIG1heGltdW0g
cmFuZ2VzIGlzIHRoZSBQTUlDIHN1cHBvcnQgYWNjb3JkaW5nIHRvIGRhdGFzaGVldCwgYnV0IHdl
IGRvbid0IHVzZSBhY3R1YWxseSB0aGUgbWF4aW11bSB2YWx1ZSwgdGhlIGFjdHVhbCB1c2UgbWF4
aW11bSB2YWx1ZSBpcyAwLjk1Vi4gU28gaXQncyBzYWZlIGZvciB0aGUgYm9hcmQuDQpEbyB5b3Ug
aG9wZSB1cyB0byBsaXN0IG9ubHkgdGhlIHZvbHRhZ2UgcmFuZ2VzIGFjdHVhbGx5IHVzZWQ/DQpU
aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBlZmZvcnRzLg0KQlINCkpv
eSBab3UNCg==
