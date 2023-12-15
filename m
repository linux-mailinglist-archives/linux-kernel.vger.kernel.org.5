Return-Path: <linux-kernel+bounces-407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747048140A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11571C22249
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262A53A7;
	Fri, 15 Dec 2023 03:30:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070CDF46;
	Fri, 15 Dec 2023 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BF3TmrgE1329966, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BF3TmrgE1329966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 11:29:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 15 Dec 2023 11:29:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 15 Dec 2023 11:29:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 15 Dec 2023 11:29:48 +0800
From: =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
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
Thread-Index: AQHaKPU79lITdFvfw06smVDh+ZvZWbCdTzKAgAeXZrCAAdUdAIABjNeAgAAKpoCAAVHkAA==
Date: Fri, 15 Dec 2023 03:29:48 +0000
Message-ID: <e710818ae24542f08564ba671adcebee@realtek.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
 <23574204547646779d02f0109c20b3ff@realtek.com>
 <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
In-Reply-To: <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

SGkgQW5keSwNCg0KPj4gPj4gPj4gKyAgICAgaWYgKGlycSA9PSBkYXRhLT5pcnFzWzBdKQ0KPj4g
Pj4gPj4gKyAgICAgICAgICAgICBnZXRfcmVnX29mZnNldCA9ICZydGRfZ3Bpb19ncGFfb2Zmc2V0
Ow0KPj4gPj4gPj4gKyAgICAgZWxzZSBpZiAoaXJxID09IGRhdGEtPmlycXNbMV0pDQo+PiA+PiA+
PiArICAgICAgICAgICAgIGdldF9yZWdfb2Zmc2V0ID0gJnJ0ZF9ncGlvX2dwZGFfb2Zmc2V0Ow0K
Pj4gPj4gPg0KPj4gPj4gPkNhbid0IGl0IGJlIGRvbmUgYmVmb3JlIGVudGVyaW5nIGludG8gY2hh
aW5lZCBJUlEgaGFuZGxlcj8NCj4+ID4+DQo+PiA+PiBJIHdpbGwgcmV2aXNlIGl0Lg0KPj4gPg0K
Pj4gPlRoaW5raW5nIGFib3V0IHRoaXMgbW9yZSwgcGVyaGFwcyB5b3UgY2FuIHJlZ2lzdGVyIHR3
byBJUlEgY2hpcHMgd2l0aA0KPj4gPmRpZmZlcmVudCBmdW5jdGlvbnMsIHNvIHRoaXMgd29uJ3Qg
YmUgcGFydCBvZiB0aGUgdmVyeSBjcml0aWNhbA0KPj4gPmludGVycnVwdCBoYW5kbGVyIChhcyB3
ZSBhbGwgd2FudCB0byByZWR1Y2Ugb3ZlcmhlYWQgaW4gaXQgYXMgbXVjaCBhcw0KPnBvc3NpYmxl
KS4NCj4+ID5Bbnl3YXksIHRoaW5rIGFib3V0IHRoaXMgYW5kIHRyeSBkaWZmZXJlbnQgb3B0aW9u
cywgY2hvb3NlIHRoZSBvbmUNCj4+ID55b3UgdGhpbmsgdGhlIGJlc3QuDQo+Pg0KPj4gSW4gdGhl
IHByZXZpb3VzIHBhdGNoICh2MSksIEkgaGFkIHJlZ2lzdGVyZWQgdHdvIElSUSBjaGlwcyB3aXRo
DQo+PiBkaWZmZXJlbnQgaGFuZGxlcnMuIEhvd2V2ZXIsIHRoZXNlIHR3byBoYW5kbGVycyBhcHBl
YXJlZCBxdWl0ZSBzaW1pbGFyDQo+PiBhbmQgdGhlIGdwaW9faXJxX2NoaXAgb25seSBhbGxvd3Mg
dGhlIHJlZ2lzdHJhdGlvbiBvZiBhIHNpbmdsZQ0KPj4gaGFuZGxlci4gVGhlcmVmb3JlLCBJIGVu
ZGVkIHVwIHJlZ2lzdGVyaW5nIG9uZSBoYW5kbGVyIGZvciBib3RoIElSUXMNCj4+IGFuZCBpbmNs
dWRlZCBjb25kaXRpb25hbCBjaGVja3Mgd2l0aGluIHRoZSBoYW5kbGVyIHRvIGRpZmZlcmVudGlh
dGUgYmV0d2Vlbg0KPnRoZSB0d28uDQo+DQo+V2hhdCBpcyB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0
IHRoYXQgeW91IGhhdmUgdGhhdCBjb25kaXRpb24gaW4gdGhlIGludGVycnVwdA0KPmhhbmRsZXI/
DQo+DQoNCkkgYmVsaWV2ZSB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IGlzIG1pbmltYWwgc2luY2Ug
dGhpcyBjb25kaXRpb25hbCBjaGVjayBpcw0KYSBzaW1wbGUgb3BlcmF0aW9uIGFpbWVkIGF0IHJl
dHJpZXZpbmcgdGhlIGNvcnJlc3BvbmRpbmcgb2Zmc2V0IG9mIHRoZQ0KaW50ZXJydXB0IHN0YXR1
cyByZWdpc3RlcnMuDQpPciBpcyB0aGVyZSBzb21ldGhpbmcgSSBtaWdodCBub3QgaGF2ZSBjb25z
aWRlcmVkPw0KDQpUaGFua3MsDQpUenV5aSBDaGFuZw0KDQo=

