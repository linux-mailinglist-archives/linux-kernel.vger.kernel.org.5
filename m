Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF747F405B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjKVIkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjKVIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:40:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC8D50;
        Wed, 22 Nov 2023 00:39:54 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM8dGP612151468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM8dGP612151468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 16:39:16 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 22 Nov 2023 16:39:16 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 22 Nov 2023 16:39:16 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Wed, 22 Nov 2023 16:39:16 +0800
From:   =?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] irqchip: Introduce RTD1319 support using the Realtek common interrupt controller driver
Thread-Topic: [PATCH v2 3/6] irqchip: Introduce RTD1319 support using the
 Realtek common interrupt controller driver
Thread-Index: AQHaGXMRAc9+C1rDtE6lI5Jgwdoqg7CC4VmAgAMpvDA=
Date:   Wed, 22 Nov 2023 08:39:16 +0000
Message-ID: <e27e80181691451eba58ece50ea4de5e@realtek.com>
References: <20231117162709.1096585-4-james.tai@realtek.com>
 <a045008a-5a97-4903-b5e4-a761f7e4c20a@suswa.mountain>
In-Reply-To: <a045008a-5a97-4903-b5e4-a761f7e4c20a@suswa.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [49.216.22.4]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuLA0KDQo+c21hdGNoIHdhcm5pbmdzOg0KPmRyaXZlcnMvaXJxY2hpcC9pcnEtcmVhbHRl
ay1pbnRjLWNvbW1vbi5jOjE3OSByZWFsdGVrX2ludGNfcHJvYmUoKSB3YXJuOg0KPmlnbm9yaW5n
IHVucmVhY2hhYmxlIGNvZGUuDQo+ZHJpdmVycy9pcnFjaGlwL2lycS1yZWFsdGVrLWludGMtY29t
bW9uLmM6MTg3IHJlYWx0ZWtfaW50Y19wcm9iZSgpIHdhcm46DQo+J2RhdGEtPmJhc2UnIGZyb20g
b2ZfaW9tYXAoKSBub3QgcmVsZWFzZWQgb24gbGluZXM6IDE3NiwxODIuDQo+DQo+dmltICsxNzkg
ZHJpdmVycy9pcnFjaGlwL2lycS1yZWFsdGVrLWludGMtY29tbW9uLmMNCj4NCj40MGU1ZmY0ZWFl
ZjcyYiBKYW1lcyBUYWkgMjAyMy0xMS0xOCAgMTU1ICBpbnQgcmVhbHRla19pbnRjX3Byb2JlKHN0
cnVjdA0KPnBsYXRmb3JtX2RldmljZSAqcGRldiwgY29uc3Qgc3RydWN0IHJlYWx0ZWtfaW50Y19p
bmZvICppbmZvKSA0MGU1ZmY0ZWFlZjcyYg0KPkphbWVzIFRhaSAyMDIzLTExLTE4ICAxNTYgIHsN
Cj40MGU1ZmY0ZWFlZjcyYiBKYW1lcyBUYWkgMjAyMy0xMS0xOCAgMTU3ICAgICAgICBzdHJ1Y3Qg
cmVhbHRla19pbnRjX2RhdGENCj4qZGF0YTsNCj40MGU1ZmY0ZWFlZjcyYiBKYW1lcyBUYWkgMjAy
My0xMS0xOCAgMTU4ICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPQ0KPiZwZGV2LT5kZXY7DQo+
NDBlNWZmNGVhZWY3MmIgSmFtZXMgVGFpIDIwMjMtMTEtMTggIDE1OSAgICAgICAgc3RydWN0IGRl
dmljZV9ub2RlICpub2RlDQo+PSBkZXYtPm9mX25vZGU7DQo+NDBlNWZmNGVhZWY3MmIgSmFtZXMg
VGFpIDIwMjMtMTEtMTggIDE2MCAgICAgICAgaW50IHJldCwgaTsNCj40MGU1ZmY0ZWFlZjcyYiBK
YW1lcyBUYWkgMjAyMy0xMS0xOCAgMTYxDQo+NDBlNWZmNGVhZWY3MmIgSmFtZXMgVGFpIDIwMjMt
MTEtMTggIDE2MiAgICAgICAgZGF0YSA9IGRldm1fa3phbGxvYyhkZXYsDQo+c3RydWN0X3NpemUo
ZGF0YSwgc3Vic2V0X2RhdGEsIGluZm8tPmNmZ19udW0pLCBHRlBfS0VSTkVMKTsNCj40MGU1ZmY0
ZWFlZjcyYiBKYW1lcyBUYWkgMjAyMy0xMS0xOCAgMTYzICAgICAgICBpZiAoIWRhdGEpDQo+NDBl
NWZmNGVhZWY3MmIgSmFtZXMgVGFpIDIwMjMtMTEtMTggIDE2NCAgICAgICAgICAgICAgICByZXR1
cm4NCj4tRU5PTUVNOw0KPjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4ICAxNjUN
Cj40MGU1ZmY0ZWFlZjcyYiBKYW1lcyBUYWkgMjAyMy0xMS0xOCAgMTY2ICAgICAgICBkYXRhLT5i
YXNlID0NCj5vZl9pb21hcChub2RlLCAwKTsNCj40MGU1ZmY0ZWFlZjcyYiBKYW1lcyBUYWkgMjAy
My0xMS0xOCAgMTY3ICAgICAgICBpZiAoIWRhdGEtPmJhc2UpDQo+NDBlNWZmNGVhZWY3MmIgSmFt
ZXMgVGFpIDIwMjMtMTEtMTggIDE2OCAgICAgICAgICAgICAgICByZXR1cm4NCj4tRU5PTUVNOw0K
PjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4ICAxNjkNCj40MGU1ZmY0ZWFlZjcy
YiBKYW1lcyBUYWkgMjAyMy0xMS0xOCAgMTcwICAgICAgICBkYXRhLT5pbmZvID0gaW5mbzsNCj40
MGU1ZmY0ZWFlZjcyYiBKYW1lcyBUYWkgMjAyMy0xMS0xOCAgMTcxDQo+NDBlNWZmNGVhZWY3MmIg
SmFtZXMgVGFpIDIwMjMtMTEtMTggIDE3Mg0KPnJhd19zcGluX2xvY2tfaW5pdCgmZGF0YS0+bG9j
ayk7DQo+NDBlNWZmNGVhZWY3MmIgSmFtZXMgVGFpIDIwMjMtMTEtMTggIDE3Mw0KPjQwZTVmZjRl
YWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4ICAxNzQgICAgICAgIGRhdGEtPmRvbWFpbiA9DQo+
aXJxX2RvbWFpbl9hZGRfbGluZWFyKG5vZGUsIDMyLCAmcmVhbHRla19pbnRjX2RvbWFpbl9vcHMs
IGRhdGEpOw0KPjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4ICAxNzUgICAgICAg
IGlmICghZGF0YS0+ZG9tYWluKQ0KPjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4
ICAxNzYgICAgICAgICAgICAgICAgcmV0dXJuDQo+LUVOT01FTTsNCj40MGU1ZmY0ZWFlZjcyYiBK
YW1lcyBUYWkgMjAyMy0xMS0xOCAgMTc3DQo+NDBlNWZmNGVhZWY3MmIgSmFtZXMgVGFpIDIwMjMt
MTEtMTggIDE3OCAgICAgICAgZGF0YS0+c3Vic2V0X2RhdGFfbnVtDQo+PSBpbmZvLT5jZmdfbnVt
Ow0KPjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4IEAxNzkgICAgICAgIGZvciAo
aSA9IDA7IGkgPA0KPmluZm8tPmNmZ19udW07IGkrKykgew0KPjQwZTVmZjRlYWVmNzJiIEphbWVz
IFRhaSAyMDIzLTExLTE4ICAxODAgICAgICAgICAgICAgICAgcmV0ID0NCj5yZWFsdGVrX2ludGNf
c3Vic2V0KG5vZGUsIGRhdGEsIGkpOw0KPjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTEx
LTE4ICAxODEgICAgICAgICAgICAgICAgV0FSTihyZXQsDQo+ImZhaWxlZCB0byBpbml0IHN1YnNl
dCAlZDogJWQiLCBpLCByZXQpOw0KPjQwZTVmZjRlYWVmNzJiIEphbWVzIFRhaSAyMDIzLTExLTE4
ICAxODIgICAgICAgICAgICAgICAgcmV0dXJuDQo+LUVOT01FTTsNCj4NCj5UaGlzIGxvb3AganVz
dCByZXR1cm5zIC1FTk9NRU0uICBNaXNzaW5nIGlmIHN0YXRlbWVudD8NCj5ObyBjbGVhbiB1cCBl
aXRoZXIuICBOZWVkcyB0byByZWxlYXNlIHJlc291cmNlcyBiZWZvcmUgcmV0dXJuaW5nLg0KDQpJ
IHdpbGwgZml4IGl0IGluIG5leHQgcGF0Y2hlcy4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRi
YWNrLg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0KDQo=
