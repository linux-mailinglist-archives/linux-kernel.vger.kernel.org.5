Return-Path: <linux-kernel+bounces-6457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B87819929
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EE61F2791A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2B14F98;
	Wed, 20 Dec 2023 07:13:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1D134C9;
	Wed, 20 Dec 2023 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK7DQ6q8553745, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK7DQ6q8553745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 15:13:26 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 20 Dec 2023 15:13:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:13:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 15:13:25 +0800
From: =?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?= <tychang@realtek.com>
To: Michael Walle <michael@walle.cc>
CC: Andy Shevchenko <andy@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
Thread-Topic: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Thread-Index: AQHaKPU79lITdFvfw06smVDh+ZvZWbCdTzKAgAeXZrCAAdUdAIABjNeAgAAKpoCAAJR9c4AA01hwgASLaYCAA3sUsA==
Date: Wed, 20 Dec 2023 07:13:25 +0000
Message-ID: <70fbe20aaf334d758d87974b4acdb3fc@realtek.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
 <23574204547646779d02f0109c20b3ff@realtek.com>
 <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
 <0f0b3b65a838aea6797ae78c47d6af49@walle.cc>
 <ZXsV96xhuvVSyc1f@smile.fi.intel.com>
 <be8db58b51d04043a255a702a08cdaba@realtek.com>
 <202312181420.3BIEK9gtC1692907@rtits1.realtek.com.tw>
In-Reply-To: <202312181420.3BIEK9gtC1692907@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

SGkgTWljaGFlbCwNCg0KPkhpLA0KPg0KPj4gSSBoYXZlIGxvb2tlZCBpbnRvIHJlZ21hcC1pcnEs
IGl0IGFwcGVhcnMgdGhhdCB1c2luZyB0aGUgZGVmYXVsdCBpcnENCj4+IHRocmVhZF9mbihyZWdt
YXBfaXJxX3RocmVhZCkgaXMgcmVxdWlyZWQuIEhvd2V2ZXIsIGR1ZSB0byBoYXJkd2FyZQ0KPj4g
bGltaXRhdGlvbiwgd2UgbmVlZCB0byBpbnNwZWN0IHRoZSBJUlFfVFlQRSB0byBkZXRlcm1pbmUg
d2hldGhlciB0bw0KPj4gbWFuYWdlIHRoZSBpcnEgd2l0aGluIHRoZSBpcnEgaGFuZGxlci4gSSB0
aGluayBvdXIgaXJxIHBvcnRpb24gZG9lcw0KPj4gbm90IHBlcmZlY3RseSBmaXQgdGhlIHJlZ21h
cC1pcnEuDQo+PiBNb3Jlb3ZlciwgaXQgc2VlbXMgdGhhdCB0aGUgZ3Bpby1yZWdtYXAuYyBmaWxl
IG5lZWRzIHRvIGJlIG1vZGlmaWVkIGlmDQo+PiB0aGUgR1BJTyBkcml2ZXIgcmVxdWlyZXMgZGVi
b3VuY2Ugc2V0dGluZ3MuIEkgdGhpbmsgdGhlIGdwaW8tcmVnbWFwDQo+PiBtYXkgbm90IGJlIGFw
cHJvcHJpYXRlIGZvciBvdXIgZHJpdmVyLg0KPj4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25z
Pw0KPg0KPkNhbid0IHNheSBhbnl0aGluZyByZWdhcmRpbmcgdGhlIGludGVycnVwdCBoYW5kbGlu
ZyBidXQgYWRkaW5nIGxpdGVyYWxseSBvbmUgbGluZQ0KPnRvIGdwaW8tcmVnbWFwIHNob3VsZG4n
dCBiZSBhIHJlYXNvbiBub3QgdG8gdXNlIGl0Lg0KPg0KDQpJIGFncmVlIHRoYXQgdGhpcyBzaG91
bGQgbm90IGJlIHRoZSByZWFzb24uIFNvcnJ5IGFib3V0IHRoYXQuDQpIb3dldmVyLCB0aGUgaW50
ZXJydXB0IGhhbmRsZXIgaXNzdWUgbWF5IHN0aWxsIGJlIHRoZSBsaW1pdGF0aW9uIGZvciBvdXIg
cGxhdGZvcm0uDQoNClRoYW5rcywNClR6dXlpIENoYW5nDQo=

