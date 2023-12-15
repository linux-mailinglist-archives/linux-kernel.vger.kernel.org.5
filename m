Return-Path: <linux-kernel+bounces-498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A58141FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD3DB22238
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8BD297;
	Fri, 15 Dec 2023 06:50:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0809CA68;
	Fri, 15 Dec 2023 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BF6oWWU11442510, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BF6oWWU11442510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 14:50:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 15 Dec 2023 14:50:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 15 Dec 2023 14:50:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 15 Dec 2023 14:50:33 +0800
From: =?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?= <tychang@realtek.com>
To: Andy Shevchenko <andy@kernel.org>, Michael Walle <michael@walle.cc>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
Thread-Topic: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Thread-Index: AQHaKPU79lITdFvfw06smVDh+ZvZWbCdTzKAgAeXZrCAAdUdAIABjNeAgAAKpoCAAJR9c4AA01hw
Date: Fri, 15 Dec 2023 06:50:32 +0000
Message-ID: <be8db58b51d04043a255a702a08cdaba@realtek.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
 <23574204547646779d02f0109c20b3ff@realtek.com>
 <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
 <0f0b3b65a838aea6797ae78c47d6af49@walle.cc>
 <ZXsV96xhuvVSyc1f@smile.fi.intel.com>
In-Reply-To: <ZXsV96xhuvVSyc1f@smile.fi.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

SGkgQW5keSwNCg0KPk9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDAzOjM1OjE4UE0gKzAxMDAsIE1p
Y2hhZWwgV2FsbGUgd3JvdGU6DQo+DQo+PiA+ID4gPj4gPj4gVGhpcyBkcml2ZXIgZW5hYmxlcyBj
b25maWd1cmF0aW9uIG9mIEdQSU8gZGlyZWN0aW9uLCBHUElPDQo+PiA+ID4gPj4gPj4gdmFsdWVz
LCBHUElPIGRlYm91bmNlIHNldHRpbmdzIGFuZCBoYW5kbGVzIEdQSU8gaW50ZXJydXB0cy4NCj4+
ID4gPiA+PiA+DQo+PiA+ID4gPj4gPldoeSBncGlvLXJlZ21hcCBjYW4ndCBiZSB1c2VkPw0KPj4g
PiA+ID4+DQo+PiA+ID4gPj4gSSB3aWxsIHRyeSB0byB1c2UgZ3Bpby1yZW1hcCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KPj4gPiA+ID4NCj4+ID4gPiA+SWYgaXQgYXBwZWFycyB0aGF0IGl0IG1ha2Vz
IGNvZGUgdWdsaWVyIC8gY29tcGxpY2F0ZWQsIHBsZWFzZSBhZGQNCj4+ID4gPiA+dGhlIG5vdGUg
c29tZXdoZXJlIHRvIGFuc3dlciB0aGUgYWJvdmUgcXVlc3Rpb24uDQo+PiA+ID4NCj4+ID4gPiBJ
J3ZlIHRyYWNlZCB0aGUgZ3Bpby1yZWdtYXAuYyBmaWxlLiBJdCBhcHBlYXJzIHRoYXQgZm9yIHRo
ZSBkcml2ZXINCj4+ID4gPiB0byByZWdpc3RlciBncGlvX2lycV9jaGlwLCBpdCBtdXN0IGNyZWF0
ZSB0aGUgaXJxX2RvbWFpbiBhbmQgYWRkDQo+PiA+ID4gaXQgaW50byBncGlvX3JlZ21hcF9jb25m
aWcuDQo+PiA+ID4gQWRkaXRpb25hbGx5LCB0aGUgZHJpdmVyIG5lZWRzIHRvIHJlZ2lzdGVyIHRo
ZSBpcnEgaGFuZGxlciBieSBpdHNlbGYuDQo+PiA+ID4gSG93ZXZlciwgdGhpcyBwcm9jZXNzIGNh
biBiZSBtYW5hZ2VkIGJ5IHRoZSBncGlvbGliIGlmIHRoZSBkcml2ZXINCj4+ID4gPiBmaWxscyBp
biB0aGUgc3RydWN0IGdwaW9faXJxX2NoaXAgaW5zaWRlIHN0cnVjdCBncGlvX2NoaXAgYmVmb3Jl
DQo+PiA+ID4gaW52b2tpbmcgZ3Bpb2NoaXBfYWRkX2RhdGEuDQo+PiA+DQo+PiA+IEhtbS4uLiBJ
IHRob3VnaHQgdGhpcyBpcyBzb2x2YWJsZSBpc3N1ZS4NCj4+ID4gTWljaGFlbCwgaXMgdGhlcmUg
YSBsaW1pdGF0aW9uIGluIEdQSU8gcmVnbWFwIHRoYXQgdGhpcyBkcml2ZXIgY2FuJ3QNCj4+ID4g
YmUgY29udmVydGVkPw0KPj4NCj4+IGdwaW8tcmVnbWFwIGlzIGRlc2lnbmVkIHRoYXQgcmVnbWFw
LWlycSAoZHJpdmVycy9iYXNlL3JlZ21hcC9pcnEuYykNCj4+IGNhbiBiZSB1c2VkLiBTbywgaWYg
cmVnbWFwLWlycSBmaXQgdGhpcyBkcml2ZXIsIHRoZW4gaXQgY2FuIGJlIHVzZWQNCj4+IHRvZ2V0
aGVyIHdpdGggZ3Bpby1yZWdtYXAuDQo+Pg0KPj4gRnJvbSBhIHF1aWNrIGdsYW5jZSBhdCB0aGUg
cGF0Y2gsIGl0IGxvb2tzIGxpa2UgdGhlIGdwaW8gcG9ydGlvbiBtaWdodA0KPj4gZml0IGdwaW8t
cmVnbWFwLg0KPj4NCj4+ID4gPiBNb3Jlb3ZlciwgYXBhcnQgZnJvbSBtYW5hZ2luZyB0aGUgcmVn
aXN0ZXJzIGZvciBncGlvIGRpcmVjdGlvbiBhbmQNCj4+ID4gPiB2YWx1ZSwgdGhlcmUgYXJlIHNl
dmVyYWwgb3RoZXIgcmVnaXN0ZXJzIHRoYXQgcmVxdWlyZQ0KPj4gPiA+IGFjY2VzcyhpbnRlcnJ1
cHQgZW5hYmxlLCBkZWJvdW5jZS4uLikuDQo+PiA+ID4gVGhlIEdQSU8gSVJRIHN0YXR1cyByZWdp
c3RlcnMgYXJlIGxvY2F0ZWQgYXQgZGlmZmVyZW50IGJhc2UNCj4+ID4gPiBhZGRyZXNzZXMgYW5k
IGFyZSBub3QgY29udGlndW91cy4gSXQgbWF5IG5lZWQgdG8gY3JlYXRlIGFuDQo+PiA+ID4gYWRk
aXRpb25hbCByZWdtYXAgYW5kIGFzc2lnbiB0aGUgYWNjZXNzIHRhYmxlIHRvIHRoaXMgcmVnbWFw
Lg0KPj4gPg0KPj4gPiBBRkFJSyB0aGlzIGlzIG5vdCBhIHByb2JsZW0gYXMgeW91IGNhbiBwcm92
aWRlIHlvdXIgb3duIHhsYXRlDQo+PiA+IGZ1bmN0aW9uIHRoYXQgd2lsbCB0YWtlIGNhcmUgYWJv
dXQgcmVnaXN0ZXIgbWFwcGluZy4NCj4+DQo+PiBKdXN0IGZvciB0aGUgZ3BpbyBwYXJ0LiBJSVJD
IHJlZ21hcCBoYXMgaXQgb3duIHRyYW5zbGF0aW9uIChyZWdtYXAgZmllbGRzKS4NCj4+DQo+PiA+
ID4gV2l0aCB0aGUgYWJvdmUgY29uc2lkZXJhdGlvbiwgSSB0ZW5kIHRvIGtlZXAgdXNpbmcgdGhl
IGV4aXN0aW5nDQo+PiA+ID4gbWV0aG9kLg0KPj4gPg0KPj4gPiBJIHdvdWxkIGxpa2UgdG8gaGVh
ciBmcm9tIE1pY2hhZWwgaWYgaXQncyBpbmRlZWQgYSBiaWcgb2JzdGFjbGUuDQo+Pg0KPj4gU28s
IHJlZ2FyZGluZyB0aGUgaXJxIHBvcnRpb24sIGFnYWluLCBpdCBtdXN0IGZpdCB0aGUgcmVnbWFw
LWlycS4gRm9yDQo+PiB0aGUgYWRkaXRpb25hbCByZXF1aXJlbWVudCB0byBzZXQgdGhlIGRlYm91
bmNlLCB5b3UgY2FuIGFkZCBhDQo+PiAuc2V0X2NvbmZpZyB0byBncGlvX3JlZ21hcF9jb25maWcg
YW5kIHN1cHBseSB5b3VyIG93biBzZXRfY29uZmlnIGNhbGxiYWNrLg0KPlNlZSBhbHNvIFsxXS4N
Cj4NCj5UaGFuayB5b3UsIE1pY2hhZWwsIGZvciB0aGUgcHJvbXB0IGFuc3dlci4gSXQncyBpbnNp
Z2h0ZnVsIHRvIG1lLCBJIHdpbGwgdHJ5IHRvDQo+cmVtZW1iZXIgdGhlc2UgYXNwZWN0cyBmb3Ig
dGhlIGZ1dHVyZSByZXZpZXdzLg0KPg0KPj4gWzFdDQo+Pg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWdwaW8vZDRhNmE2NDBjMzczYjZkOTM5ZTE0NzY5MWVmYTU5NmNAd2ENCj4+IGxs
ZS5jYy8NCj4NCg0KSSBoYXZlIGxvb2tlZCBpbnRvIHJlZ21hcC1pcnEsIGl0IGFwcGVhcnMgdGhh
dCB1c2luZyB0aGUgZGVmYXVsdCBpcnENCnRocmVhZF9mbihyZWdtYXBfaXJxX3RocmVhZCkgaXMg
cmVxdWlyZWQuIEhvd2V2ZXIsIGR1ZSB0byBoYXJkd2FyZSBsaW1pdGF0aW9uLA0Kd2UgbmVlZCB0
byBpbnNwZWN0IHRoZSBJUlFfVFlQRSB0byBkZXRlcm1pbmUgd2hldGhlciB0byBtYW5hZ2UgdGhl
IGlycSB3aXRoaW4NCnRoZSBpcnEgaGFuZGxlci4gSSB0aGluayBvdXIgaXJxIHBvcnRpb24gZG9l
cyBub3QgcGVyZmVjdGx5IGZpdCB0aGUgcmVnbWFwLWlycS4NCk1vcmVvdmVyLCBpdCBzZWVtcyB0
aGF0IHRoZSBncGlvLXJlZ21hcC5jIGZpbGUgbmVlZHMgdG8gYmUgbW9kaWZpZWQgaWYgdGhlIEdQ
SU8gZHJpdmVyDQpyZXF1aXJlcyBkZWJvdW5jZSBzZXR0aW5ncy4gSSB0aGluayB0aGUgZ3Bpby1y
ZWdtYXAgbWF5IG5vdCBiZSBhcHByb3ByaWF0ZSBmb3Igb3VyIGRyaXZlci4NCkRvIHlvdSBoYXZl
IGFueSBzdWdnZXN0aW9ucz8NCg0KVGhhbmtzLA0KVHp1eWkgQ2hhbmcNCg==

