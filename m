Return-Path: <linux-kernel+bounces-161829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4248B51E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1B2814B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A214F64;
	Mon, 29 Apr 2024 06:57:11 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD051171A;
	Mon, 29 Apr 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373831; cv=none; b=cGbiH89T5WUOf8pRie63r6+5bmL7HYXPTKr1ckD2ypxTu4Doz2kVBLWdIOgHbrGlCjtwRFiOJW8fWDkTxnSkJX0ysR3Yix0CGgAT0hEbUvQpi+LFrmS6fm9GLVrjBgTbbJlELgdeTiLxrmomCDLXvd5rkFrQZ8uQ7Sim4t935MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373831; c=relaxed/simple;
	bh=MR5pQ4oGzc/Gg45kvMMaZTUyVg/11QT5xq/OzfSgyB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMpmD8UnQOaCm+J24xAuQEEfLP/lDNLiySa5uqkLXr0PZgxk7Dbq823K1MU79VhLuZMvI9QXErvY7Mxsw6X56oC/Pj6pyUsuHmIP+igI6VKwfge9Vgt3tZmzxB3WW1Q0fwTo5EoxjOwUfKpPUp1obzsQVuQxN9G+hwwbJ7PxRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T6uZUW13163003, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T6uZUW13163003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 14:56:35 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 14:56:35 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 14:56:35 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Mon, 29 Apr 2024 14:56:35 +0800
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
Thread-Index: AQHaf/Di2MMAmClaHUaVpFhOVxydUrFMk6cAgAHWPUCAIOE18IAJkr8AgAYkPkA=
Date: Mon, 29 Apr 2024 06:56:35 +0000
Message-ID: <7cb1e8d8b1f64aa0a9a5c7c63929b95f@realtek.com>
References: <20240327024545.138351-1-ricky_wu@realtek.com>
 <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com>
 <8b966794f2bb4fda8cc7d3e111bfef70@realtek.com>
 <CAPDyKFp=prNyPE8hT_9irx0DyFCboF8Ms6uh4Euxe0oyPq79fg@mail.gmail.com>
In-Reply-To: <CAPDyKFp=prNyPE8hT_9irx0DyFCboF8Ms6uh4Euxe0oyPq79fg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

PiA+DQo+ID4gU29mdCByZW1pbmRlcg0KPiA+DQo+ID4gSWYgdGhpcyBzb2x1dGlvbiwgeW91IHN0
aWxsIGhhdmUgY29uY2VydCBvbiBzZC5jLg0KPiA+IGNhbiB3ZSBqdXN0IGRvIHRoaXMgY2hlY2sg
Y2FyZCBmbG93IGluIG1tYyBob3N0IHBvd2VyIHVwIGNhbGxfYmFjaz8NCj4gPg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gX21tY19zZF9yZXN1bWUNCj4gPiA+ID4gPiBhZGQgZ2V0X2NkIGJlZm9yZSBj
YWxsIHBvd2VydXAsIG1ha2Ugc3VyZSB0aGUgY2FyZCBleGlzdA0KPiA+ID4gPg0KPiA+ID4gPiBQ
bGVhc2UgZWxhYm9yYXRlIG1vcmUgb24gd2hhdCBwcm9ibGVtIHlvdSBhcmUgdHJ5aW5nIHRvIHNv
bHZlLCB0aGUNCj4gPiA+ID4gYWJvdmUgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8gbWUsIHNv
cnJ5Lg0KPiA+ID4gPg0KPiA+ID4gPiBZZXMsIHRoZSBjYXJkIG1heSBiZSByZW1vdmVkIHdoaWxl
IHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGVkLiBUaGVuLCBldmVuDQo+ID4gPiA+IGlmIC0+Z2V0X2Nk
KCkgaW5kaWNhdGVzIHRoYXQgdGhlcmUgaXMgbm8gY2FyZCBpbnNlcnRlZCBpbiB0aGUNCj4gPiA+
ID4gU0QtY2FyZC1zbG90LCB3ZSBtYXkgc3RpbGwgaGF2ZSB0aGUgY2FyZCBiZWluZyByZWdpc3Rl
cmVkIC0gYW5kIHRoZW4NCj4gPiA+ID4gd2UgbmVlZCB0byB1bnJlZ2lzdGVyIGl0Lg0KPiA+ID4g
PiBUaGF0IHNhaWQsIHdlIG5lZWQgdG8gY2FsbCBtbWNfcG93ZXJfdXAoKSBpbiBvcmRlciB0byB0
cnkgdG8NCj4gPiA+ID4gY29tbXVuaWNhdGUgd2l0aCB0aGUgY2FyZCBhZ2Fpbi4gQXQgbGVhc3Qg
dGhhdCBpcyB3aGF0IHRoZQ0KPiA+ID4gPiBtbWNfcmVzY2FuKCkgd29yayBhc3N1bWVzIHdoZW4g
aXQgcnVucyB0aGUgYnVzX29wcy0+ZGV0ZWN0KCkgY2FsbGJhY2sNCj4gPiA+ID4gYXQgc29tZSBw
b2ludCBsYXRlciBpbiB0aW1lLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdlIHNhdyB0aGUgcG93
ZXIgdXAgaW4gYSBzaG9ydCB0aW1lIGZyb20gd2F2ZWZvcm0gd2hlbiByZW1vdmluZyB0aGUNCj4g
Y2FyZCwNCj4gPiA+IFNvIHdlIHNhdyBtbWNfc2RfcmVzdW1lIGNhbGwgdGhlIHBvd2VyIHVwIGRp
ZCBub3QgY2hlY2sgdGhlIGNhcmQgZXhpc3QuDQo+IA0KPiBXZWxsLCB0aGF0IGRvZXNuJ3QgcmVh
bGx5IHRlbGwgbWUgaWYgdGhhdCBpcyBhIHByb2JsZW0gb3Igbm90Pw0KPiANCj4gRG9lc24ndCB0
aGUgZmlyc3QgY29tbWFuZCBzZW50IHRvIHRoZSBTRCBjYXJkICh0aGF0IGhhcyBiZWVuIHJlbW92
ZWQpDQo+IGZhaWwgaWYgdGhlcmUgaXMgbm8gY2FyZCBpbnNlcnRlZCBhbnl3YXk/DQo+IA0KPiA+
ID4NCj4gPiA+IFdlIHRoaW5rIHRoaXMgdGhlIHNob3J0IHRpbWUgcG93ZXIgdXAgbWF5YmUgY2F1
c2UgT0NQIGlmIG5vIGNhcmQgZXhpc3QuDQo+IA0KPiBPQ1A/DQoNCk9DUDogb3ZlciBjdXJyZW50
IHByb3RlY3Rpb24NCldlIHRoaW5rIHRoaXMgc2hvcnQgdGltZSBwb3dlciB1cCBoYXMgc2hvcnQg
Y2lyY3VpdCByaXNrIHdoZW4gbm8gY2FyZCBleGlzdA0KVGhhdCBpcyB3aHkgd2Ugd2FudCB0byBj
aGVjayBjYXJkIGV4aXN0IG9yIG5vdCB3aGVuIHBvd2VyIHVwIA0KDQoNCj4gDQo+ID4gPiBBbmQg
dGhpcyBwb3dlciB1cCB3ZSB0aGluayBpcyB1bm5lY2Vzc2FyeSB3aGVuIG5vIGNhcmQgZXhpc3Qu
DQo+IA0KPiBJdCBtYXkgbm90IGJlIG5lY2Vzc2FyeSwgYnV0IGluIHdoYXQgd2F5IGRvZXMgaXQg
aHVydD8NCj4gDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFJpY2t5IFd1IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+
ID4gPiAgZHJpdmVycy9tbWMvY29yZS9zZC5jIHwgMyArKysNCj4gPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvc2QuYyBiL2RyaXZlcnMvbW1jL2NvcmUvc2QuYyBpbmRleA0KPiA+
ID4gPiA+IDFjODE0OGNkZGE1MC4uMzVlMDM2NjcyY2ZiIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvc2QuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUv
c2QuYw0KPiA+ID4gPiA+IEBAIC0xNzUwLDYgKzE3NTAsOSBAQCBzdGF0aWMgaW50IF9tbWNfc2Rf
cmVzdW1lKHN0cnVjdA0KPiBtbWNfaG9zdA0KPiA+ID4gPiAqaG9zdCkNCj4gPiA+ID4gPiAgICAg
ICAgIGlmICghbW1jX2NhcmRfc3VzcGVuZGVkKGhvc3QtPmNhcmQpKQ0KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICsgICAgICAgaWYgKGhv
c3QtPm9wcy0+Z2V0X2NkICYmICFob3N0LT5vcHMtPmdldF9jZChob3N0KSkNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICAgICAgICAg
bW1jX3Bvd2VyX3VwKGhvc3QsIGhvc3QtPmNhcmQtPm9jcik7DQo+ID4gPiA+ID4gICAgICAgICBl
cnIgPSBtbWNfc2RfaW5pdF9jYXJkKGhvc3QsIGhvc3QtPmNhcmQtPm9jciwgaG9zdC0+Y2FyZCk7
DQo+ID4gPiA+ID4gICAgICAgICBtbWNfY2FyZF9jbHJfc3VzcGVuZGVkKGhvc3QtPmNhcmQpOw0K
PiA+ID4gPiA+IC0tDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K

