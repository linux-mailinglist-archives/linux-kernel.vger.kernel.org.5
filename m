Return-Path: <linux-kernel+bounces-124305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0150A89155A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FA8282F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A240862;
	Fri, 29 Mar 2024 09:03:40 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C53FB8D;
	Fri, 29 Mar 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703020; cv=none; b=o1qY9MKLd7wV2Sc5bDHcoF8UIXhNwd+/6UAmru/t8yFCGytr1CJhuYE64UySv/97jNRsUlCjRkqZ9veTZXVxU0UD+3ey7cOYsm6CzwQqW2s0rH/svEbvcKEf3YIaI71K1Cbz/L1SmQUDo1DYWoMJILvN57U48wGtMwUSgQtyBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703020; c=relaxed/simple;
	bh=ssMs2fsOpy/An9vC4sIE90j8WGcxFV/Y8XaqyuHtBnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUt4VuEihVThzv0qpOQI+WUIWGCu4GEhBNZRk9Ws6GFfTdA72dQrDpkccxX7dqUgIVBMnh6w1Me0bBAOlqQk5dMJAbmp8JgeArTY8vNx8xo8TKQl/vZby6KiyivmUGrr8r9wwTsbTUAg39FAhImnjclwFqqHny6i3VUCMON5Wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T934ybC3661992, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T934ybC3661992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 17:03:04 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 17:03:05 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 17:03:04 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Fri, 29 Mar 2024 17:03:04 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "wenchao.chen@unisoc.com" <wenchao.chen@unisoc.com>,
        "ricardo@marliere.net" <ricardo@marliere.net>,
        "marex@denx.de"
	<marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: resume not check card exist before powerup
Thread-Topic: [PATCH] mmc: core: resume not check card exist before powerup
Thread-Index: AQHaf/Di2MMAmClaHUaVpFhOVxydUrFMk6cAgAHWPUA=
Date: Fri, 29 Mar 2024 09:03:04 +0000
Message-ID: <99ead06da8a94f518d40f7aba475ed35@realtek.com>
References: <20240327024545.138351-1-ricky_wu@realtek.com>
 <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com>
In-Reply-To: <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

PiBPbiBXZWQsIDI3IE1hciAyMDI0IGF0IDAzOjQ2LCBSaWNreSBXdSA8cmlja3lfd3VAcmVhbHRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gX21tY19zZF9yZXN1bWUNCj4gPiBhZGQgZ2V0X2NkIGJl
Zm9yZSBjYWxsIHBvd2VydXAsIG1ha2Ugc3VyZSB0aGUgY2FyZCBleGlzdA0KPiANCj4gUGxlYXNl
IGVsYWJvcmF0ZSBtb3JlIG9uIHdoYXQgcHJvYmxlbSB5b3UgYXJlIHRyeWluZyB0byBzb2x2ZSwg
dGhlDQo+IGFib3ZlIGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNlIHRvIG1lLCBzb3JyeS4NCj4gDQo+
IFllcywgdGhlIGNhcmQgbWF5IGJlIHJlbW92ZWQgd2hpbGUgdGhlIHN5c3RlbSBpcyBzdXNwZW5k
ZWQuIFRoZW4sIGV2ZW4NCj4gaWYgLT5nZXRfY2QoKSBpbmRpY2F0ZXMgdGhhdCB0aGVyZSBpcyBu
byBjYXJkIGluc2VydGVkIGluIHRoZQ0KPiBTRC1jYXJkLXNsb3QsIHdlIG1heSBzdGlsbCBoYXZl
IHRoZSBjYXJkIGJlaW5nIHJlZ2lzdGVyZWQgLSBhbmQgdGhlbg0KPiB3ZSBuZWVkIHRvIHVucmVn
aXN0ZXIgaXQuDQo+IFRoYXQgc2FpZCwgd2UgbmVlZCB0byBjYWxsIG1tY19wb3dlcl91cCgpIGlu
IG9yZGVyIHRvIHRyeSB0bw0KPiBjb21tdW5pY2F0ZSB3aXRoIHRoZSBjYXJkIGFnYWluLiBBdCBs
ZWFzdCB0aGF0IGlzIHdoYXQgdGhlDQo+IG1tY19yZXNjYW4oKSB3b3JrIGFzc3VtZXMgd2hlbiBp
dCBydW5zIHRoZSBidXNfb3BzLT5kZXRlY3QoKSBjYWxsYmFjaw0KPiBhdCBzb21lIHBvaW50IGxh
dGVyIGluIHRpbWUuDQo+IA0KDQpXZSBzYXcgdGhlIHBvd2VyIHVwIGluIGEgc2hvcnQgdGltZSBm
cm9tIHdhdmVmb3JtIHdoZW4gcmVtb3ZpbmcgdGhlIGNhcmQsDQpTbyB3ZSBzYXcgbW1jX3NkX3Jl
c3VtZSBjYWxsIHRoZSBwb3dlciB1cCBkaWQgbm90IGNoZWNrIHRoZSBjYXJkIGV4aXN0Lg0KDQpX
ZSB0aGluayB0aGlzIHRoZSBzaG9ydCB0aW1lIHBvd2VyIHVwIG1heWJlIGNhdXNlIE9DUCBpZiBu
byBjYXJkIGV4aXN0Lg0KQW5kIHRoaXMgcG93ZXIgdXAgd2UgdGhpbmsgaXMgdW5uZWNlc3Nhcnkg
d2hlbiBubyBjYXJkIGV4aXN0LiAgDQoNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kg
V3UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3Jl
L3NkLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZC5jIGIvZHJpdmVycy9tbWMvY29y
ZS9zZC5jDQo+ID4gaW5kZXggMWM4MTQ4Y2RkYTUwLi4zNWUwMzY2NzJjZmIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9tbWMvY29yZS9zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9z
ZC5jDQo+ID4gQEAgLTE3NTAsNiArMTc1MCw5IEBAIHN0YXRpYyBpbnQgX21tY19zZF9yZXN1bWUo
c3RydWN0IG1tY19ob3N0DQo+ICpob3N0KQ0KPiA+ICAgICAgICAgaWYgKCFtbWNfY2FyZF9zdXNw
ZW5kZWQoaG9zdC0+Y2FyZCkpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+DQo+
ID4gKyAgICAgICBpZiAoaG9zdC0+b3BzLT5nZXRfY2QgJiYgIWhvc3QtPm9wcy0+Z2V0X2NkKGhv
c3QpKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArDQo+ID4gICAgICAgICBt
bWNfcG93ZXJfdXAoaG9zdCwgaG9zdC0+Y2FyZC0+b2NyKTsNCj4gPiAgICAgICAgIGVyciA9IG1t
Y19zZF9pbml0X2NhcmQoaG9zdCwgaG9zdC0+Y2FyZC0+b2NyLCBob3N0LT5jYXJkKTsNCj4gPiAg
ICAgICAgIG1tY19jYXJkX2Nscl9zdXNwZW5kZWQoaG9zdC0+Y2FyZCk7DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==

