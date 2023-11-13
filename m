Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFC7EA523
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKMU5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKMU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:57:45 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2087.outbound.protection.outlook.com [40.92.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B1189;
        Mon, 13 Nov 2023 12:57:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSQKwPDAUGqIAfT27m7hkl7XCvy7yRqIAu2MJfOatrKMqTgW2/RBQ6g1FLRcPwwZAVCdmndevNmcjj8SAY7IRo5i6Z2Wgyk3Zh1T2jP5RSDo8hOugvp9NlpN/NwaOfHAYpXWI50IWRgEmQGK6C5iDXcPpyuuUj/ck3Hd99mlmIm5cqf/ljEiXCvpQ/ZlE020tMH/hQKil25aOwidCOS7p1pOHPw1JtXajKYM4uslvdmCR0CnEzjW02BLiBMDdMDD4kFucLOS/7+q8f2VJizgZhKsjTuSwS2ZKbT9uIPM0vJI7mjXHyKh8uaFCxtVblt9+GGrrXcEreiVf9bPdPxjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0npqfrQsS8aEFQ7blMqD6BbxgF30OW3qISGQhdTSISc=;
 b=e5psXGp8cNSABSZRcjgoEZtc0uZUp/l6IHOuRl69Q49bBRIPOR22uvs18AyROa77gIZ2tvzoT4GwTDEdFZ3SkL7b0DzN+jJFmgbkqvuS+fRAc5y6VTYquw1FM8TH7mEtLD20LwXmBZXYZG5u39n0nEnhH9h697xCB4xab6BYa1px/AM1qFuhpu8PfsQy8vkiDrfg5l0hOXdabxmjSuXzGc5qncxYH/8sTZAOiWS9HautuCx+orZpOHj2tNVZt/0Li1g9NHwbGfrbwhPNerm9K8Rec/DDzfPDhXRCS2Ap1x+9RIx8Yj2IbvfbRT+lk7X7ABimE9OQmP3RN6UyFj5H7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0npqfrQsS8aEFQ7blMqD6BbxgF30OW3qISGQhdTSISc=;
 b=ho2PBQi8IIJzsItGegfRBJpBdqAT6tTn+r8ORYbcoxDqIUmFDD6Q2+W2A/YhpgakAFIAukW73f+rf8OsBDc/rYmUlUgHFJ+hX9u7P7lwPxwvXFyZqKjD+U5OM0Clr4SMDyjfcw3LR3nQBzQqB1t5Mb0DGLCDiXYq6vnX9RwTsUi592y8jwvzyjMmLmFu9G44NvE04Q6fUaxh9o6okEs1KPbe85nU7guzgGXm0B6Bo+ymbdVVlEOqS/Htf9iQCzq1PpOgnGyqbECFKw6AnfFPmMdy8h9qQxT+tMQxRL/g1R3ud0Our+ncr+kDMz8qc6ODuJdlSfw+GbdB6j825m0IAw==
Received: from PN0P287MB0216.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e7::9) by
 PN3P287MB1253.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:196::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 20:57:35 +0000
Received: from PN0P287MB0216.INDP287.PROD.OUTLOOK.COM
 ([fe80::2be6:2e27:ab75:94d6]) by PN0P287MB0216.INDP287.PROD.OUTLOOK.COM
 ([fe80::2be6:2e27:ab75:94d6%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 20:57:35 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Topic: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Index: AQHaFnQHbfx65PIcfUeDQNMgO0n18w==
Date:   Mon, 13 Nov 2023 20:57:35 +0000
Message-ID: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4CH2jFEsO6t0RwspeU/egfp+WU2qlgXyw/+qec1w3zELEga83PO0RHo4HdYquK5KA+dt/tdB8/w=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0216:EE_|PN3P287MB1253:EE_
x-ms-office365-filtering-correlation-id: ce0424b6-7156-4e83-7476-08dbe48b29f6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwUSlU0YTAhbUCDjegvDBiRm+NXMqDALpZfqmCv6PGmAXm6TvFplpXsralyj3BYPbG41wnaaLT9a+1u9fj5Hxb81ljI0fKZCVzDbwHv3XqdL0pOatrvA94jz+qiPRoBkVyp04wRFQ8hEAzVwgAI8ojvcYlspORGiX2PrDzTZIiIKAeAJwv6u/4wGug+oiaWkB4e8mZNhOIXst8X1cVStRyHcDMmDTXDVqpQ0OjwCB7mg/3gMveNKVYXrJcuVfBiblZYr93rLJlKNNOMnD+/cQUyNUB70VZsUDTGoS28yDexwlr3N6QImZX9RKQg11XWnM7BYpRFfjYNk6SQx5tGw6IFklDLNkYyUXF40RHa8jlyqNy0kRjlx+O6cbPIn9RBN8RJxtMqtoAZ7wbu/ezkd7zKs99VsXIwXnRpeI6ZwLBPnV1X7B7J4aAqUYig3yMMvYchufCcFAOzWvEIzo6pIYhiTFkhRF6N9dH3Ftw+InAUUDqirbC97ukyI0FwG4Z7dgkH9pPoZe3vbks+kXc8rK+gvZlrJRC87rDGYlgoorC5s0FM/7CpSdU69wi6Mr71aV2r/l/620y4UW8a5BdKxPUgVIuSRLISQcIT430BRI1po2O261EeOakPNe/v5V9V3vd58sFtOl9nNavTNOWbUvQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnY5clpHVDlwa0Q0WXpOaWhrelkvbGNWOENpcDE0TDNOOHlmQnI2Q2lYZ0lw?=
 =?utf-8?B?bjRXTlpOZTk0MXE1Wk1nb3Mwdlo0VEJtalFEdWUxRlZkMGJzQ0o2eFk1Qk9P?=
 =?utf-8?B?YVVySkFzNUxDaDdmcU5HSjcwRitDb21SSzBWbDZCcllTUHNBcHFlR08yMTdm?=
 =?utf-8?B?TjVJNXYxWS92aU04THpaQktEcHZJb093UzI5eFpLbGprdmVMNEVwQXRxTnZH?=
 =?utf-8?B?Ri9oTlMzaUVhMW85cGlBKzR5UktNcHM0bmdLWEQ1RVE0K3pac3QzTUUrNlc3?=
 =?utf-8?B?d201ZnQ2bVZ3YTArWG1najBlOWdQakVtQnNSQVZYTjJqakVPbGl4eFdycXVT?=
 =?utf-8?B?MDhYVm1rS3lKVk5LM1BTdFprZmNlN3NWaTh2Yk53YThBOTVqWk5JeFBwRUw5?=
 =?utf-8?B?R2c0dXVXMGxXYkFtTzR1MXA3NlNPOVo3bFQzRmhZUGFvcjZaTGVmZ2dIcVFU?=
 =?utf-8?B?QzRJSE1HeVlTb2tEaUtrMEJpczE1dnhOYTZobEF2OGkvRjNnUjlXYndaSHp4?=
 =?utf-8?B?WVc5aUV0aHhBYmJ5V3FrN29nOU5mZmowdnkydWVSOHAzRzRaUUIvOWxmQ0kr?=
 =?utf-8?B?SDlPUkZ5d3BjZHVjV3drRWhTV1l0TVhBYkZIOGtNNmRzWFc3RHg5WXg0dk50?=
 =?utf-8?B?WUtMMml0NDU1aXhVYXJuNXFOR1lRZHlCUTlZZDBIRUJzTVYxZW9kOVN0a0Yr?=
 =?utf-8?B?WlYvVXVoLzZGNzB3bXUyM2hxYlVldlRTdVBUQkFSUmNGdjZWTmN5NFpIMkl1?=
 =?utf-8?B?NXZzUFJ2RHZOeWdWQnh2eWJVTis1K2lmZWc5aVJ4NHhzdU5DRW5QK1oxZ1gy?=
 =?utf-8?B?UGdQOHJlbUhvblpyUGI2cURaTmNSVld2Skpxa1BFa3VIV2ZuTkEwdUk2S21p?=
 =?utf-8?B?djdBeFlXYnMvRDEraGFQdzJzT1VmMTV1RlVobmpqZ3krbEkzOFpoSEdMOEJ4?=
 =?utf-8?B?VUVKUk9qOTZ0KytQdnZ2K1BTZWV1aURLaEYyTjN6MG5sNTU4MFNBdVRQMHRD?=
 =?utf-8?B?ZWJHanMxczc0dElpZmN3QmtzY2xuSy9XdnlOdHgzdk9Ga3FjTkVRdW5XOWRE?=
 =?utf-8?B?SFZOVW54MmY3ZDFzU3hSUnYrTzc4blBiMGpvTXYxZGdCVW96TGNBNWk0WitO?=
 =?utf-8?B?TDNCd2V1K3luM2IvT3pteENLNCtaYzdwU3B2aGN5RFc0QnRzSFZwaEpOSHJv?=
 =?utf-8?B?OXo5K0l4M3lhUmFFc1hscXNkZGxsRDduaDhNMkZlUHBFQUJXdEZuSzRQTGg4?=
 =?utf-8?B?Q2dVL3ZPRG9MR25tSGloc0dwSnlTWnkzUEQ3dG0rbzBmQW9kdWNPNDA0Yzlp?=
 =?utf-8?B?anFEenl5eDI5bmx0TTE0dkZ6TDR2YzJMYXgrZFBXQjgwNUdiVmkrcTN1K2Nq?=
 =?utf-8?B?WXBZUzA1amk2V004S0VUdCt3SjhEbVVqdm5kY1VieURsZmFTWlFzVEZ5Rkhl?=
 =?utf-8?B?aVYvbGNIOUlVakd3WUU3TElxZllTc2pFbGpoV1c5SWRpTXllOUdHeGRGd3FY?=
 =?utf-8?B?ZlR4cWN6RXBpNXZXd3ROSEZaWFVxVVRuQzhwOVJWRE5EUjk4NGt6NEgxcmhs?=
 =?utf-8?B?MGF2aTQ3WmwyWmJ5ajF0dW1MVkxZNm9sNzQ5dmQ3VmIzUkNGeGRrNThndlZW?=
 =?utf-8?B?aS80YlNOVVVZang3Q0Y2WWpyTkVycGhnWFZZajl2SjQ3VHdjblVYRmRBbm1i?=
 =?utf-8?B?S1FKMFZtbUhmRXpTSVNGUWg3L1FBalZ5MFFDMnlrdldQVzFmdXQ2WUs0NTJs?=
 =?utf-8?Q?yUGYY5bfARffD0udPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CAF9392B1927846B787F21BAC5482BA@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0216.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0424b6-7156-4e83-7476-08dbe48b29f6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 20:57:35.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1253
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RhcnRpbmcgZnJvbSBrZXJuZWwgNi41LCBhIHJlZ3Jlc3Npb24gaW4gdGhlIGtlcm5lbCBpcyBj
YXVzaW5nIEJsdWV0b290aCB0byBub3Qgd29yayBvbiBUMiBNYWNzIHdpdGggQkNNNDM3NyBjaGlw
Lg0KDQpKb3VybmFsY3RsIG9mIGtlcm5lbCA2LjQuOCB3aGljaCBoYXMgQmx1ZXRvb3RoIHdvcmtp
bmcgaXMgZ2l2ZW4gaGVyZTogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vdTlVM2tiRkoNCg0KSm91cm5h
bGN0bCBvZiBrZXJuZWwgNi41LjIsIHdoaWNoIGhhcyBCbHVldG9vdGggYnJva2VuIGlzIGdpdmVu
IGhlcmU6IGh0dHBzOi8vcGFzdGViaW4uY29tL2FWSE5GTVJzDQoNCkFsc28sIHRoZSBidWcgaGFz
buKAmXQgYmVlbiBmaXhlZCBldmVuIGluIDYuNi4xLCBhcyByZXBvcnRlZCBieSB1c2Vycy4NCg0K
U29tZSByZWxldmFudCBiaXRzIGltbzoNCg0KICAgIOKAoiBTZXAgMTkgMjE6MjQ6MzYgUnVkeVVi
dU1icCBrZXJuZWw6IGhjaV9iY200Mzc3IDAwMDA6NzM6MDAuMTogY2FuJ3QgZGlzYWJsZSBBU1BN
OyBPUyBkb2Vzbid0IGhhdmUgQVNQTSBjb250cm9sDQoNCiAgICDigKIgTm92IDE0IDAxOjI5OjI4
IFJ1ZHlVYnVNYnAga2VybmVsOiBDYWxsIFRyYWNlOg0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6Mjgg
UnVkeVVidU1icCBrZXJuZWw6IDxUQVNLPg0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6MjggUnVkeVVi
dU1icCBrZXJuZWw6IGR1bXBfc3RhY2tfbHZsKzB4NDgvMHg3MA0KICAgIOKAoiBOb3YgMTQgMDE6
Mjk6MjggUnVkeVVidU1icCBrZXJuZWw6IGR1bXBfc3RhY2srMHgxMC8weDIwDQogICAg4oCiIE5v
diAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogX191YnNhbl9oYW5kbGVfc2hpZnRfb3V0
X29mX2JvdW5kcysweDE1Ni8weDMxMA0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6MjggUnVkeVVidU1i
cCBrZXJuZWw6ID8gdHR3dV9kb19hY3RpdmF0ZSsweDgwLzB4MjkwDQogICAg4oCiIE5vdiAxNCAw
MToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogPyByYXdfc3Bpbl9ycV91bmxvY2srMHgxMC8weDQw
DQogICAg4oCiIE5vdiAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogPyB0cnlfdG9fd2Fr
ZV91cCsweDI5Mi8weDZjMA0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6MjggUnVkeVVidU1icCBrZXJu
ZWw6ID8gc2NoZWRfc2xpY2UrMHg3Ni8weDE0MA0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6MjggUnVk
eVVidU1icCBrZXJuZWw6ID8gcmV3ZWlnaHRfZW50aXR5KzB4MTVjLzB4MTcwDQogICAg4oCiIE5v
diAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogX19yZWdfb3AuY29sZCsweDE0LzB4MzgN
CiAgICDigKIgTm92IDE0IDAxOjI5OjI4IFJ1ZHlVYnVNYnAga2VybmVsOiBiaXRtYXBfcmVsZWFz
ZV9yZWdpb24rMHhlLzB4MjANCiAgICDigKIgTm92IDE0IDAxOjI5OjI4IFJ1ZHlVYnVNYnAga2Vy
bmVsOiBiY200Mzc3X2hhbmRsZV9hY2srMHg4Yy8weDEzMCBbaGNpX2JjbTQzNzddDQogICAg4oCi
IE5vdiAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogYmNtNDM3N19wb2xsX2NvbXBsZXRp
b25fcmluZysweDE5Ni8weDMzMCBbaGNpX2JjbTQzNzddDQogICAg4oCiIE5vdiAxNCAwMToyOToy
OCBSdWR5VWJ1TWJwIGtlcm5lbDogPyByY3VfZ3Bfa3RocmVhZF93YWtlKzB4NTcvMHg5MA0KICAg
IOKAoiBOb3YgMTQgMDE6Mjk6MjggUnVkeVVidU1icCBrZXJuZWw6IGJjbTQzNzdfaXJxKzB4Nzcv
MHgxNDAgW2hjaV9iY200Mzc3XQ0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6MjggUnVkeVVidU1icCBr
ZXJuZWw6IF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHg0Yy8weDFiMA0KICAgIOKAoiBOb3Yg
MTQgMDE6Mjk6MjggUnVkeVVidU1icCBrZXJuZWw6IGhhbmRsZV9pcnFfZXZlbnQrMHgzOS8weDgw
DQogICAg4oCiIE5vdiAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogaGFuZGxlX2VkZ2Vf
aXJxKzB4OGMvMHgyNTANCiAgICDigKIgTm92IDE0IDAxOjI5OjI4IFJ1ZHlVYnVNYnAga2VybmVs
OiBfX2NvbW1vbl9pbnRlcnJ1cHQrMHg0Zi8weDExMA0KICAgIOKAoiBOb3YgMTQgMDE6Mjk6Mjgg
UnVkeVVidU1icCBrZXJuZWw6IGNvbW1vbl9pbnRlcnJ1cHQrMHg0NS8weGIwDQogICAg4oCiIE5v
diAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogYXNtX2NvbW1vbl9pbnRlcnJ1cHQrMHgy
Ny8weDQwDQogICAg4oCiIE5vdiAxNCAwMToyOToyOCBSdWR5VWJ1TWJwIGtlcm5lbDogUklQOiAw
MDMzOjB4N2YxN2I1ZmQ4YmNh
