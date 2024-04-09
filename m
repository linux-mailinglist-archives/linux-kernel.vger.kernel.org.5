Return-Path: <linux-kernel+bounces-137593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6089E45F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DEC1C227D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7B1586C3;
	Tue,  9 Apr 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vrz8AUch"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA951581E5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694516; cv=none; b=q0ZMG0oytfWAc5MxwgUy8y2d6LsWzkh1LrFf2qkSt/ABgAfZJrLejzW5lzMp83lNMvex7DHyvRWh23zZS+wh43/y3j/bS672ZVjJdYxIFQ0JT4BKMwN7dbFQwZxZwVIIP8ydQR/zu1+NKwGBfJX9zxcibvz8Ino6iz0uS+otJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694516; c=relaxed/simple;
	bh=8OOvMkG0dzbrmWTRiEqTJY0erNa/5bhSb/mAAXafOtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MF+Z3z1K78fVjMZFhoqMxaWU+p751UOKccQEaSftyDvcqOWwt2UKTV82mHXmIeRDdktFICiQr+Rlg85BwpQTrkHhosUx9KVl33f9zos9gw7NV/BFlR7CUD5CHQyTkMr1ZkyJF3zRvoBarSc8J24ZJnbG9hHuO8kHD52GK2GspFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vrz8AUch; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 69A7D2C02AD;
	Wed, 10 Apr 2024 08:28:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712694508;
	bh=8OOvMkG0dzbrmWTRiEqTJY0erNa/5bhSb/mAAXafOtI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=vrz8AUchlzQ8UIP691kh09qkwnk4r2zlUxJphudcAg2jvlMnTsvv7AhYHDmppKANx
	 Yj9TrXE1EgUDDkXN2ucxpnG7O8ydhB3bkF84IHzCoNH5i+A/tys0gr/rIB86d3iolU
	 SmmwOMIpXeQywCF9fdhRFOzGFKlqLSOhWnpPqL6HUmW1ZvtSGnK8ks7eiuQ3Fk3q0T
	 VUDikmjBoUFwYrvQldUMWI0yxGSv+7Lt6e78Kne0SP8lm8OEzJsWFq7SHKF4COuB/k
	 UTHl8SgBMe9Xi0ddtJrYbeIEaxgKMqrnqXn7SuQKgKN6UpHGlnKKiUgZv/IY9uZ9pG
	 PbgRRjJYZmrnw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6615a4ec0001>; Wed, 10 Apr 2024 08:28:28 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.9; Wed, 10 Apr 2024 08:28:28 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 10 Apr 2024 08:28:27 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 10 Apr 2024 08:28:27 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andy@kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: Re: [PATCH] auxdisplay: seg-led-gpio: Convert to platform remove
 callback returning void
Thread-Topic: [PATCH] auxdisplay: seg-led-gpio: Convert to platform remove
 callback returning void
Thread-Index: AQHailzEd5M7gfjxC0uqkJ46xIih+7FfmxCA
Date: Tue, 9 Apr 2024 20:28:27 +0000
Message-ID: <ba9558d8-13d2-416f-834e-e03835abea07@alliedtelesis.co.nz>
References: <20240409090306.29284-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240409090306.29284-2-u.kleine-koenig@pengutronix.de>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <067142CFCD7D1F4691A674F223F26735@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=AuZN3/9P c=1 sm=1 tr=0 ts=6615a4ec a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=gfvt5pmtKoRt069fGZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA5LzA0LzI0IDIxOjAzLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gVGhlIC5yZW1v
dmUoKSBjYWxsYmFjayBmb3IgYSBwbGF0Zm9ybSBkcml2ZXIgcmV0dXJucyBhbiBpbnQgd2hpY2gg
bWFrZXMNCj4gbWFueSBkcml2ZXIgYXV0aG9ycyB3cm9uZ2x5IGFzc3VtZSBpdCdzIHBvc3NpYmxl
IHRvIGRvIGVycm9yIGhhbmRsaW5nIGJ5DQo+IHJldHVybmluZyBhbiBlcnJvciBjb2RlLiBIb3dl
dmVyIHRoZSB2YWx1ZSByZXR1cm5lZCBpcyBpZ25vcmVkIChhcGFydA0KPiBmcm9tIGVtaXR0aW5n
IGEgd2FybmluZykgYW5kIHRoaXMgdHlwaWNhbGx5IHJlc3VsdHMgaW4gcmVzb3VyY2UgbGVha3Mu
DQo+DQo+IFRvIGltcHJvdmUgaGVyZSB0aGVyZSBpcyBhIHF1ZXN0IHRvIG1ha2UgdGhlIHJlbW92
ZSBjYWxsYmFjayByZXR1cm4NCj4gdm9pZC4gSW4gdGhlIGZpcnN0IHN0ZXAgb2YgdGhpcyBxdWVz
dCBhbGwgZHJpdmVycyBhcmUgY29udmVydGVkIHRvDQo+IC5yZW1vdmVfbmV3KCksIHdoaWNoIGFs
cmVhZHkgcmV0dXJucyB2b2lkLiBFdmVudHVhbGx5IGFmdGVyIGFsbCBkcml2ZXJzDQo+IGFyZSBj
b252ZXJ0ZWQsIC5yZW1vdmVfbmV3KCkgd2lsbCBiZSByZW5hbWVkIHRvIC5yZW1vdmUoKS4NCj4N
Cj4gVHJpdmlhbGx5IGNvbnZlcnQgdGhpcyBkcml2ZXIgZnJvbSBhbHdheXMgcmV0dXJuaW5nIHpl
cm8gaW4gdGhlIHJlbW92ZQ0KPiBjYWxsYmFjayB0byB0aGUgdm9pZCByZXR1cm5pbmcgdmFyaWFu
dC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBh
Y2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvYXV4ZGlz
cGxheS9zZWctbGVkLWdwaW8uYyB8IDYgKystLS0tDQo+DQo+IEhlbGxvLA0KPg0KPiB0aGUgZHJp
dmVycyBiZWxvdyBvZiBkcml2ZXJzL2F1eGRpc3BsYXkgd2VyZSBhbHJlYWR5IGNvbnZlcnRlZCB0
byBzdHJ1Y3QNCj4gcGxhdGZvcm1fZHJpdmVyOjpyZW1vdmVfbmV3IGR1cmluZyB0aGUgdjYuOS1y
YzEgZGV2ZWxvcG1lbnQgY3ljbGUuIFRoaXMNCj4gZHJpdmVyIHdhcyBhZGRlZCBmb3IgdjYuOS1y
YzEgc3RpbGwgdXNpbmcgdGhlIG9sZCBwcm90b3R5cGUuDQo+DQo+IFRoZXJlIGFyZSBzdGlsbCBt
b3JlIGRyaXZlcnMgdG8gYmUgY29udmVydGVkLCBzbyB0aGVyZSBpcyBmcm9tIG15IHNpZGUNCj4g
bm8gbmVlZCB0byBnZXQgdGhpcyBpbnRvIHY2LjksIGJ1dCB0aGUgbmV4dCBtZXJnZSB3aW5kb3cg
d291bGQgYmUgbmljZS4NCj4NCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2F1eGRpc3BsYXkvc2VnLWxlZC1ncGlvLmMgYi9kcml2ZXJzL2F1eGRpc3BsYXkvc2Vn
LWxlZC1ncGlvLmMNCj4gaW5kZXggMzVhOGRiYjFlOWQyLi4xODNhYjMwMTFjYmIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvYXV4ZGlzcGxheS9zZWctbGVkLWdwaW8uYw0KPiArKysgYi9kcml2ZXJz
L2F1eGRpc3BsYXkvc2VnLWxlZC1ncGlvLmMNCj4gQEAgLTgxLDE0ICs4MSwxMiBAQCBzdGF0aWMg
aW50IHNlZ19sZWRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJcmV0
dXJuIGxpbmVkaXNwX3JlZ2lzdGVyKCZwcml2LT5saW5lZGlzcCwgZGV2LCAxLCAmc2VnX2xlZF9s
aW5lZGlzcF9vcHMpOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQgc2VnX2xlZF9yZW1vdmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3N0YXRpYyB2b2lkIHNlZ19sZWRfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qgc2Vn
X2xlZF9wcml2ICpwcml2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAgDQo+ICAg
CWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmcHJpdi0+d29yayk7DQo+ICAgCWxpbmVkaXNwX3Vu
cmVnaXN0ZXIoJnByaXYtPmxpbmVkaXNwKTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAgIH0NCj4g
ICANCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZWdfbGVkX29mX21hdGNo
W10gPSB7DQo+IEBAIC05OSw3ICs5Nyw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHNlZ19s
ZWRfb2ZfbWF0Y2gpOw0KPiAgIA0KPiAgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNl
Z19sZWRfZHJpdmVyID0gew0KPiAgIAkucHJvYmUgPSBzZWdfbGVkX3Byb2JlLA0KPiAtCS5yZW1v
dmUgPSBzZWdfbGVkX3JlbW92ZSwNCj4gKwkucmVtb3ZlX25ldyA9IHNlZ19sZWRfcmVtb3ZlLA0K
PiAgIAkuZHJpdmVyID0gew0KPiAgIAkJLm5hbWUgPSAic2VnLWxlZC1ncGlvIiwNCj4gICAJCS5v
Zl9tYXRjaF90YWJsZSA9IHNlZ19sZWRfb2ZfbWF0Y2gsDQo+DQo+IGJhc2UtY29tbWl0OiA0Y2Vj
ZTc2NDk2NTAyMGMyMmNmZjc2NjViMThhMDEyMDA2MzU5MDk1

