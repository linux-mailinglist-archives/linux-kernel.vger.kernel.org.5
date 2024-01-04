Return-Path: <linux-kernel+bounces-16270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F7823BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E2F285C82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE3918ECE;
	Thu,  4 Jan 2024 05:58:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738F2CA6;
	Thu,  4 Jan 2024 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4045wM8L11475824, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4045wM8L11475824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 13:58:23 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 4 Jan 2024 13:58:22 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 Jan 2024 13:58:22 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Thu, 4 Jan 2024 13:58:22 +0800
From: =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] Add gpio driver support for Realtek DHC SoCs
Thread-Topic: [PATCH v5 0/2] Add gpio driver support for Realtek DHC SoCs
Thread-Index: AQHaOXtdJNg44qAIYUmtF1DI0I5vCbDHWqyAgAHXWcA=
Date: Thu, 4 Jan 2024 05:58:22 +0000
Message-ID: <57250f26c03e4e938f0b68d07ee5e27f@realtek.com>
References: <20231228104800.24913-1-tychang@realtek.com>
 <CAMRc=MeB6UBf2cCrB8XHtfKigmS3Gb41SV-G6F+0X7Dd+7oatw@mail.gmail.com>
In-Reply-To: <CAMRc=MeB6UBf2cCrB8XHtfKigmS3Gb41SV-G6F+0X7Dd+7oatw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

SGkgQmFydG9zeiwNCg0KPk9uIFRodSwgRGVjIDI4LCAyMDIzIGF0IDExOjQ44oCvQU0gVHp1eWkg
Q2hhbmcgPHR5Y2hhbmdAcmVhbHRlay5jb20+DQo+d3JvdGU6DQo+Pg0KPj4gVGhlc2UgcGF0Y2hl
cyBhZGQgdGhlIGJpbmRpbmdzIGFuZCB0aGUgZ3BpbyBkcml2ZXIgZm9yIFJlYWx0ZWsNCj4+IERI
QyhEaWdpdGFsIEhvbWUgQ2VudGVyKSBSVEQgU29DcywgaW5jbHVkaW5nIFJURDEyOTUsIFJURDEz
OTUsDQo+PiBSVEQxNjE5LCBSVEQxMzE5LCBSVEQxNjE5QiwgUlREMTMxOUQgYW5kIFJURDEzMTVF
Lg0KPj4NCj4+IENoYW5nZSBsb2c6DQo+PiB2NC0+djU6DQo+PiAxLiBBZGQgbW9yZSBkZXNjcmlw
dGlvbiBpbiB0aGUgS2NvbmZpZy4NCj4+IDIuIEFkZCBjb21tZW50IGZvciB0aGUgY291bnRlci1p
bnR1aXRpdmUgbnVtYmVyIDMxLg0KPj4gMy4gQ29udmVydCB0byB1c2UgY2xlYW51cCBBUEkgYW5k
IG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoKSBtYWNyby4NCj4+IDQuIFNpbXBsaWZ5IHNvbWUgb2Yg
dGhlIGNvZGUgYXMgc3VnZ2VzdGVkIGluIHBhdGNoIHY0Lg0KPj4gdjMtPnY0Og0KPj4gMS4gQXJy
YW5nZSB0aGUgY29tcGF0aWJsZSBsaXN0IGluIGFscGhhbnVtZXJpY2FsIG9yZGVyLg0KPj4gMi4g
UmVtb3ZlIHRoZSBzaXplIGNoZWNrIGZvciB0aGUgb2Zmc2V0IGFycmF5Lg0KPj4gMy4gQWRkIHRo
ZSBkZWJvdW5jZSBjYWxsYmFjay4NCj4+IDQuIENvbmR1Y3RlZCBhIHJldmlldyBvZiB0aGUgY3Jp
dGljYWwgc2VjdGlvbiwgZW1wbG95aW5nIHJhd19zcGlubG9ja190IGZvcg0KPmxvY2tpbmcgcHVy
cG9zZXMuDQo+PiA1LiBBZGQgZ3Bpb2NoaXBfZW5hYmxlX2lycS9ncGlvY2hpcF9kaXNhYmxlX2ly
cSB0byBmdWxmaWxsIHRoZSBpbW11dGFiaWxpdHkNCj5yZXF1aXJlbWVudHMuDQo+PiA2LiBVc2Ug
aXJxZF90b19od2lycSB0byBnZXQgaHdpcnEuDQo+PiB2Mi0+djM6DQo+PiAxLiBSZW1vdmUgZ2Vu
ZXJpYyBjb21wYXRpYmxlIGFuZCB1c2UgU29DLXNwZWNpZmljIGNvbXBhdGlibGUgaW5zdGVhZC4N
Cj4+IDIuIEFkZCB0aGUgbWlzc2luZyBkZXNjcmlwdGlvbnMgZm9yIHRoZSBydGRfZ3Bpb19pbmZv
IHN0cnVjdHVyZSBtZW1iZXJzLg0KPj4gMy4gQXNzaWduIGdwaW9fY2hpcCBmd25vZGUuDQo+PiB2
MS0+djI6DQo+PiAxLiBBZGQgZGVzY3JpcHRpb24gZm9yIERIQyBSVEQgU29DcyBpbiB0aGUgYmlu
ZGluZ3MuDQo+PiAyLiBSZXZpc2UgdGhlIGNvbXBhdGlibGUgbmFtZXMgaW4gdGhlIGJpbmRpbmdz
Lg0KPj4gMy4gVHJhbnNpdGlvbmVkIGZyb20gT0YgQVBJIHRvIHBsYXRmb3JtX2RldmljZSBBUEku
DQo+PiA0LiBVc2UgdTggZm9yIHRoZSBvZmZzZXQgYXJyYXkgd2l0aGluIHRoZSBydGRfZ3Bpb19p
bmZvIHN0cnVjdHVyZS4NCj4+IDUuIFJlY29yZCB0aGUgc2l6ZSBvZiBlYWNoIGFycmF5IHdpdGhp
biB0aGUgcnRkX2dwaW9faW5mbyBzdHJ1Y3R1cmUgYW5kDQo+PiAgICBpbXBsZW1lbnQgY2hlY2tz
IHRvIHByZXZlbnQgb3V0LW9mLWJvdW5kcyBhY2Nlc3MuDQo+PiA2LiBVc2UgR1BJT0xJQl9JUlFD
SElQIGhlbHBlcnMgdG8gcmVnaXN0ZXIgaW50ZXJydXB0cy4NCj4+IDcuIFVzZSBkeW5hbWljIGFs
bG9jYXRpb24gZm9yIEdQSU8gYmFzZS4NCj4+DQo+PiBUenV5aSBDaGFuZyAoMik6DQo+PiAgIGR0
LWJpbmRpbmdzOiBncGlvOiByZWFsdGVrOiBBZGQgcmVhbHRlayxydGQtZ3Bpbw0KPj4gICBBZGQg
R1BJTyBzdXBwb3J0IGZvciBSZWFsdGVrIERIQyhEaWdpdGFsIEhvbWUgQ2VudGVyKSBSVEQgU29D
cy4NCj4+DQo+PiAgLi4uL2JpbmRpbmdzL2dwaW8vcmVhbHRlayxydGQtZ3Bpby55YW1sICAgICAg
IHwgIDY5ICsrDQo+PiAgZHJpdmVycy9ncGlvL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDEzICsNCj4+ICBkcml2ZXJzL2dwaW8vTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPj4gIGRyaXZlcnMvZ3Bpby9ncGlvLXJ0ZC5jICAgICAgICAgICAgICAg
ICAgICAgICB8IDYwNA0KPisrKysrKysrKysrKysrKysrKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwg
Njg3IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL3JlYWx0ZWsscnRkLWdwaW8ueWFtbA0KPj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwaW8vZ3Bpby1ydGQuYw0KPj4NCj4+IC0tDQo+PiAy
LjQzLjANCj4+DQo+DQo+SSBhcHBsaWVkIHRoaXMgc2VyaWVzLiBGb3IgdGhlIGZ1dHVyZTogdGhl
IGNvbW1pdCBzdWJqZWN0IHNob3VsZCBoYXZlIHRoZSAiZ3BpbzoNCj5ydGQ6IC4uLiIgcHJlZml4
LiBJIGFkZGVkIGl0IHRoaXMgdGltZS4NCj4NCg0KVGhhbmsgeW91LiBJJ2xsIG1ha2Ugc3VyZSB0
byB0YWtlIG5vdGUgb2YgaXQgbmV4dCB0aW1lLg0KDQpUaGFua3MsDQpUenV5aSBDaGFuZw0K

