Return-Path: <linux-kernel+bounces-82677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF386882C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9D31F23C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288214D9E4;
	Tue, 27 Feb 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="iDThSa7G"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31441B962
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007761; cv=none; b=ZB7jt43q8yYlU1zpoBNtgGcg1QWlJwif8cQMf+7FWWItD4E+pJei6wYsWC5LY7//cJB9+SuwG4leL3JPUr7MJ05yGmHaY5yOUEOT6SxiX/+/jaGXPzHv3HnrAzi2+EvJz4GzJEDMGaYHX8xUwVQTFOcnQ1ukiJrrD/Rc+et+fAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007761; c=relaxed/simple;
	bh=6jNFMRONjBC5hI101lH7xzU+lTU1NDVXO/PbyiENPmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+CQbTG0kvwTuWf54dWvY/sPwSo9KlFAqkur1eoLwIzy4+VcI8K6lu1GlzJr1HEta7ksBFhIMnKP/GMGQUyCE6GDS1aU4Nk/hWR7qCigRN8RwgmOZFCP1O/90+n0qe0H9MTKoQMnN2/YLb0zCDkbWAbGe5KB5NswCFHZ9JcSAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=iDThSa7G; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A4B112C0546;
	Tue, 27 Feb 2024 17:22:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709007756;
	bh=6jNFMRONjBC5hI101lH7xzU+lTU1NDVXO/PbyiENPmk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iDThSa7GAGxVyVFYzyylfpzl7NK13suc3cJNBGsZ2Ljiluqw7jzeZJJaQ3USXreL8
	 +Kcn2S5R7msC1inaG9ytTxDMUaGCHiaFM5Qdy0ybvBQD/vtmUZW169xVD3SqhK5LuI
	 zQWgPhU1Y7R1L/zzVEhVm9/jsb8DxyhzM92jRkYksdJ7IZ/dZmmzVho6ISL6VC6+pi
	 pJEkKS9PsC1wo00CZvpQLJn3yP5svYnldDA8HlLL2I983t/NNFVfLDm54u9wDdAZHu
	 fsZvlVB0qBQfnSp/Chiq8QocMCENhEcwqTxmLGF4JqQBgfKMAZYAexQTSE/6tE+8u9
	 cvNX3ZI+OW56Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dd638c0001>; Tue, 27 Feb 2024 17:22:36 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 17:22:36 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Tue, 27 Feb 2024 17:22:36 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 27 Feb 2024 17:22:36 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, Ibrahim Tilki
	<Ibrahim.Tilki@analog.com>, Zeynep Arslanbenzer
	<Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v8 1/2] rtc: max31335: Add support for additional chips
Thread-Topic: [PATCH v8 1/2] rtc: max31335: Add support for additional chips
Thread-Index: AQHaaTSXXsc2JlLE/USpTZyAh1r7Yg==
Date: Tue, 27 Feb 2024 04:22:35 +0000
Message-ID: <ce50b1bc-0786-454e-9498-0b5ddbea0e2a@alliedtelesis.co.nz>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
 <20240227010312.3305966-2-chris.packham@alliedtelesis.co.nz>
 <20240227022919856ffa1d@mail.local>
In-Reply-To: <20240227022919856ffa1d@mail.local>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <225F68B96E1BA144A07C34DCAF01936C@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dd638c a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=sVLDwT0inrkDDW06gAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQWxleGFuZHJlLA0KDQpGaXJzdCBvZmYgYXBvbG9naWVzIGlmIEkndmUgc3RydWNrIGEgbmVy
dmUsIHRoYXQgd2FzIG5ldmVyIG15IGludGVudGlvbi4gDQpJIHRob3VnaHQgY2xlYW5pbmcgdXAg
YW4gaW5mbGlnaHQgcGF0Y2ggc2VyaWVzIHRvIGdldCBpdCBsYW5kZWQgd291bGQgYmUgDQphIHN0
cmFpZ2h0IGZvcndhcmQgdGhpbmcuDQoNCk9uIDI3LzAyLzI0IDE1OjI5LCBBbGV4YW5kcmUgQmVs
bG9uaSB3cm90ZToNCj4gT24gMjcvMDIvMjAyNCAxNDowMzowOSsxMzAwLCBDaHJpcyBQYWNraGFt
IHdyb3RlOg0KPj4gLQltYXgzMTMzNS0+Y2xrb3V0LmNsayA9IGRldm1fY2xrX2dldF9lbmFibGVk
KGRldiwgTlVMTCk7DQo+PiAtCWlmIChJU19FUlIobWF4MzEzMzUtPmNsa291dC5jbGspKQ0KPj4g
LQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKG1heDMxMzM1LT5jbGtvdXQuY2xr
KSwNCj4+IC0JCQkJICAgICAiY2Fubm90IGVuYWJsZSBjbGtvdXRcbiIpOw0KPiBUaGlzIGlzIHNv
IHVnbHkgYW5kIHNob3VsZCBoYXZlIG5ldmVyIHBhc3NlZC4gSSB3ZW50IHdlYWsgaW4gZnJvbnQg
b2YNCj4gQW50b25pdSdzIGluc2lzdGFuY2UgYnV0IEknbSB2ZXJ5IGNsb3NlIGZyb20gcmlwcGlu
ZyBvdXQgdGhlIHdob2xlDQo+IGRyaXZlciBmcm9tIHRoZSBrZXJuZWwgbm93Lg0KPg0KPiBTZXJp
b3VzbHksIHJlYWQgYWxsIHRoZSBjb21tZW50cyB0aGF0IGhhdmUgYmVlbiBtYWRlIGFyb3VuZCB0
aGUgSVJRL2Nsaw0KPiBzdHVmZiBhbmQgY29tZSBiYWNrIHdpdGggYSBwcm9wZXIgc29sdXRpb24u
DQoNClllYWggSSdtIG9ubHkganVzdCBnZXR0aW5nIHRvIGdyaXBzIHdpdGggdGhpcy4NCg0KTm8g
aWRlYSBhYm91dCB0aGUgTUFYMzEzMzUgaXRzZWxmIGJ1dCBmcm9tIHRoZSBNQVgzMTMzNCBpdCBs
b29rcyBsaWtlIA0KdGhlIGFsYXJtMSBpbnRlcnJ1cHQgd2lsbCBtb3ZlIGZyb20gSU5UQSB0byBJ
TlRCLiBJIHRoaW5rIHJhdGhlciB0aGFuIA0KbWVzc2luZyBhYm91dCB3aXRoIHRoZSBjbG9jayBz
dHVmZiB3ZSdkIGJlIGJldHRlciBvZmYgd2l0aCBhIA0KcGluLTYtZnVuY3Rpb24gPSAiYWxhcm0x
IiB8ICJjbGtvdXQiIHByb3BlcnR5Lg0KDQo+DQo+PiArc3RhdGljIGludCBtYXgzMTMzNV9pcnFf
aW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmRldm5hbWUpDQo+PiArew0KPj4g
KwlzdHJ1Y3QgbWF4MzEzMzVfZGF0YSAqbWF4MzEzMzUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJc3dpdGNoIChtYXgzMTMzNS0+aWQpIHsNCj4+ICsJ
Y2FzZSBJRF9NQVgzMTMyODoNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIElEX01BWDMxMzMxOg0K
Pj4gKwljYXNlIElEX01BWDMxMzM0Og0KPj4gKwkJaWYgKG1heDMxMzM1LT5jbGtvdXQuY2xrKSB7
DQo+PiArCQkJLyoNCj4+ICsJCQkgKiBpbnRlcnJ1cHQgbXV4aW5nIGRlcGVuZHMgb24gY2xrb3V0
IHNvIGVuYWJsZSBjbGtvdXQNCj4+ICsJCQkgKiBpZiBjb25maWd1cmVkIGJlZm9yZSByZXF1ZXN0
aW5nIGludGVycnVwdA0KPj4gKwkJCSAqLw0KPj4gKwkJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJs
ZShtYXgzMTMzNS0+Y2xrb3V0LmNsayk7DQo+IERvIEkgZ2V0IHRoaXMgcmlnaHQgdGhhdCB0aGlz
IGlzIGFib3V0IGVuYWJsaW5nIGl0cyBvd24gb3V0cHV0IGNsb2NrPw0KPiBXaHkgd291bGQgeW91
IG5lZWQgdG8gZG8gdGhhdD8gU29tZXRoaW5nIGVsc2UgbXVzdCBiZSB0aGUgY29uc3VtZXIsIG5v
dA0KPiB0aGUgcHJvdmlkZXIgaXRzZWxmLg0KDQpJIGRvbid0IHRoaW5rIGl0IGRvZXMuIEl0J3Mg
anVzdCB0aGF0IGJhc2VkIG9uIHRoZSBFTkNMS08gc2V0dGluZyBhbGFybTEgDQp3aWxsIGJlIG91
dHB1dCBvbiBhIGRpZmZlcmVudCBwaW4uIEkgZG9uJ3QgdGhpbmsgdGhlcmUncyByZWFsbHkgYSBw
cm9wZXIgDQp3YXkgb2YgZGlzYWJsaW5nIENMS09VVCBkeW5hbWljYWxseS4gRWl0aGVyIGl0J3Mg
ZW5hYmxlZCBhbmQgYWxsIHRoZSANCmludGVycnVwdHMgYXJlIG9uIHRoZSBJTlRBIHBpbiBvciBp
dCdzIGRpc2FibGVkIGFuZCBhbGFybTEgaXMgbW92ZWQgdG8gDQp0aGUgSU5UQi4gWW91IGNhbiBj
aGFuZ2UgdGhlIGNsa291dCBmcmVxdWVuY3kgYnV0IG5vdCBvdXRyaWdodCBkaXNhYmxlIA0KaXQg
KHdpdGhvdXQgaGF2aW5nIGEgc2lkZS1lZmZlY3QgdGhhdCBpbXBhY3RzIHRoZSBpbnRlcnJ1cHQg
YXNzaWdubWVudCkuDQoNClNvIEkgdGhpbmsgbXkgc3VnZ2VzdGlvbiBvZiBtYWtpbmcgaXQgcGFy
dCBvZiB0aGUgaGFyZHdhcmUgZGVzY3JpcHRpb24gDQppcyBwcm9iYWJseSB0aGUgc2Vuc2libGUg
dGhpbmcgdG8gZG8uIEl0IGFmZmVjdHMgaG93IHRoZSBpbnRlcnJ1cHRzIGFyZSANCnBoeXNpY2Fs
bHkgY29ubmVjdGVkIHNvIEkgdGhpbmsgaXQgZG9lcyBiZWxvbmcgaW4gdGhlIGRldmljZSB0cmVl
Lg0KDQo+DQo+PiArCQkJaWYgKHJldCkNCj4+ICsJCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCByZXQsDQo+PiArCQkJCQkJICAgICAiY2Fubm90IGVuYWJsZSBjbGtvdXRcbiIpOw0KPj4gKwkJ
fQ0KPj4gKwkJYnJlYWs7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlpZiAobWF4MzEzMzUtPmNsa2lu
KSB7DQo+PiArCQkJaWYgKG1heDMxMzM1LT5jbGtvdXQuY2xrICYmIG1heDMxMzM1LT5pcnEgPiAw
KQ0KPj4gKwkJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FT1BOT1RTVVBQLA0KPj4gKwkJ
CQkJCSAgICAgImlycSBub3QgcG9zc2libGUgd2hlbiBib3RoIGNsa2luIGFuZCBjbGtvdXQgYXJl
IGNvbmZpZ3VyZWRcbiIpOw0KPiBUaGlzIGlzIG5vdCB0cnVlLCB0aGUgUlRDIGlzIGFsd2F5cyBh
IGNsb2NrIHByb3ZpZGVyLiBXaGF0IGlzIG5vdA0KPiBwb3NzaWJsZSBpcyBtdXhpbmcgdGhlIGNs
b2NrIG9uIHRoZSBwaW4gaW4gYSBmZXcgY29uZmlndXJhdGlvbnMuDQoNClllYWggSSBkb24ndCB1
bmRlcnN0YW5kIHRoYXQgZWl0aGVyLiBOb3Qgc3VyZSB3aGF0IGNsa2luIGhhcyB0byBkbyB3aXRo
IA0KYW55dGhpbmcgaGVyZS4gVGhlIGNsa291dCBzdHVmZiBhZmZlY3RzIHdoaWNoIGlycSBwaW5z
IGFyZSBpbiBwbGF5Lg0K

