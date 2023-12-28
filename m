Return-Path: <linux-kernel+bounces-12392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E587481F420
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F28B216EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3F1137B;
	Thu, 28 Dec 2023 02:27:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F2ED8;
	Thu, 28 Dec 2023 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BS2R7hZ41639675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BS2R7hZ41639675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 10:27:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 28 Dec 2023 10:27:07 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 10:27:06 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Thu, 28 Dec 2023 10:27:06 +0800
From: =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
Thread-Topic: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Thread-Index: AQHaNKykAxQglRQ65UeKSWnkfMw4BLC0wdMAgAYrmgCAAeOVgIABL1Sw
Date: Thu, 28 Dec 2023 02:27:06 +0000
Message-ID: <532f905a4df6444c85c7932bca60aeca@realtek.com>
References: <20231222075812.6540-1-tychang@realtek.com>
 <20231222075812.6540-3-tychang@realtek.com>
 <ZYWLdG9kxm2ql0uf@smile.fi.intel.com>
 <63983de33ce2415abb8b5b745db58911@realtek.com>
 <ZYxOLXiV6IQQ7IlD@smile.fi.intel.com>
In-Reply-To: <ZYxOLXiV6IQQ7IlD@smile.fi.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

SGkgQW5keSwNCg0KPk9uIFR1ZSwgRGVjIDI2LCAyMDIzIGF0IDA3OjM0OjM3QU0gKzAwMDAsIFRZ
X0NoYW5nW+W8teWtkOmAuF0gd3JvdGU6DQo+PiA+T24gRnJpLCBEZWMgMjIsIDIwMjMgYXQgMDM6
NTg6MTJQTSArMDgwMCwgVHp1eWkgQ2hhbmcgd3JvdGU6DQo+DQo+Li4uDQo+DQo+PiA+PiArc3Rh
dGljIGludCBydGRfZ3Bpb19ncGFfb2Zmc2V0KHN0cnVjdCBydGRfZ3BpbyAqZGF0YSwgdW5zaWdu
ZWQgaW50DQo+PiA+PiArb2Zmc2V0KSB7DQo+PiA+PiArICAgICByZXR1cm4gZGF0YS0+aW5mby0+
Z3BhX29mZnNldFtvZmZzZXQgLyAzMV07IH0NCj4+ID4+ICsNCj4+ID4+ICtzdGF0aWMgaW50IHJ0
ZF9ncGlvX2dwZGFfb2Zmc2V0KHN0cnVjdCBydGRfZ3BpbyAqZGF0YSwgdW5zaWduZWQNCj4+ID4+
ICtpbnQNCj4+ID4+ICtvZmZzZXQpIHsNCj4+ID4+ICsgICAgIHJldHVybiBkYXRhLT5pbmZvLT5n
cGRhX29mZnNldFtvZmZzZXQgLyAzMV07IH0NCj4+ID4NCj4+ID5UaGUgLyAzMSBzby1vLW8gY291
bnRlciBpbnR1aXRpdmUsIHBsZWFzZSBhZGQgYSBjb21tZW50IGluIGVhY2ggY2FzZQ0KPj4gPnRv
IGV4cGxhaW4gd2h5IFtpdCdzIG5vdCAzMiBvciBvdGhlciBwb3dlci1vZi0yXS4NCj4+ID4NCj4+
DQo+PiBJbiBvdXIgaGFyZHdhcmUgZGVzaWduLCB0aGUgYml0IDAgb2YgdGhlIGdwZGEgYW5kIGdw
YSBzdGF0dXMgcmVnaXN0ZXJzIGRvZXMgbm90DQo+Y29ycmVzcG9uZCB0byBhIEdQSU8uDQo+PiBJ
ZiBiaXQgMCBpcyBzZXQgdG8gMSwgdGhlIG90aGVyIGJpdCBjYW4gYmUgc2V0IHRvIDEgYnkgd3Jp
dGluZyAxLg0KPj4gSWYgYml0IDAgaXMgc2V0IHRvIDAsIHRoZSBvdGhlciBiaXQgY2FuIGJlIGNs
ZWFyIHRvIDAgYnkgd3JpdGluZyAxLg0KPj4NCj4+IFRoZXJlZm9yZSwgZWFjaCBzdGF0dXMgcmVn
aXN0ZXIgb25seSBjb250YWlucyB0aGUgc3RhdHVzIG9mIDMxIEdQSU9zLiBJIHdpbGwgYWRkDQo+
dGhlIGNvbW1lbnQgZm9yIHRoaXMuDQo+DQo+WWVzLCBwbGVhc2UgYWRkIGluIGFsbCBwbGFjZXMs
IHdoaWxlIGl0J3MgYSBkdXAsIGl0IGhlbHBzIHVuZGVyc3RhbmRpbmcgdGhlIHBvaW50DQo+d2l0
aG91dCBsb29raW5nIGFyb3VuZCBmb3IgYSB3aGlsZS4NCj4NCj4uLi4NCj4NCj4+ID4+ICsgICAg
IGZvciAoaSA9IDA7IGkgPCBkYXRhLT5pbmZvLT5udW1fZ3Bpb3M7IGkgKz0gMzEpIHsNCj4+ID4N
Cj4+ID5TYW1lLCBhZGQgZXhwbGFuYXRpb24gd2h5IDMxLg0KPj4gPg0KPj4gPk5vdGUsIEkgYWN0
dWFsbHkgcHJlZmVyIHRvIHNlZSB1c2Ugb2YgdmFsaWRfbWFzayBpbnN0ZWFkIG9mIHRoaXMgd2Vp
cmRuZXNzLg0KPj4gPlRoZW4geW91IHdpbGwgbmVlZCB0byBjb21tZW50IG9ubHkgb25jZSBhbmQg
dXNlIDMyIChhbG1vc3Q/KSBldmVyeXdoZXJlLg0KPj4gPg0KPj4NCj4+IFRoZSByZWFzb24gcmVt
YWlucyBjb25zaXN0ZW50IHdpdGggdGhlIHByZXZpb3VzIGV4cGxhbmF0aW9uLiBFYWNoDQo+PiBz
dGF0dXMgcmVnaXN0ZXIgZXhjbHVzaXZlbHkgaG9sZHMgdGhlIHN0YXR1cyBvZiAzMSBHUElPcy4N
Cj4NCj5BcyBwZXIgYWJvdmUsIGFkZCBhIGNvbW1lbnQuDQo+DQo+PiA+PiArICAgICAgICAgICAg
IHJlZ19vZmZzZXQgPSBnZXRfcmVnX29mZnNldChkYXRhLCBpKTsNCj4+ID4+ICsNCj4+ID4+ICsg
ICAgICAgICAgICAgc3RhdHVzID0gcmVhZGxfcmVsYXhlZChkYXRhLT5pcnFfYmFzZSArIHJlZ19v
ZmZzZXQpID4+IDE7DQo+PiA+PiArICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKHN0YXR1cyA8
PCAxLCBkYXRhLT5pcnFfYmFzZSArDQo+PiA+PiArIHJlZ19vZmZzZXQpOw0KPj4gPj4gKw0KPj4g
Pj4gKyAgICAgICAgICAgICBmb3JfZWFjaF9zZXRfYml0KGosICZzdGF0dXMsIDMxKSB7DQo+PiA+
PiArICAgICAgICAgICAgICAgICAgICAgaHdpcnEgPSBpICsgajsNCj4+ID4NCj4+ID5OaWNlLCBi
dXQgeW91IGNhbiBkbyBiZXR0ZXINCj4+ID4NCj4+ID4gICAgICAgICAgICAgICAgLyogQml0IDAg
aXMgc3BlY2lhbC4uLiBibGEtYmxhLWJsYS4uLiAqLw0KPj4gPiAgICAgICAgICAgICAgICBzdGF0
dXMgPSByZWFkbF9yZWxheGVkKGRhdGEtPmlycV9iYXNlICsgcmVnX29mZnNldCk7DQo+PiA+ICAg
ICAgICAgICAgICAgIHN0YXR1cyAmPSB+QklUKDApOw0KPj4gPiAgICAgICAgICAgICAgICB3cml0
ZWxfcmVsYXhlZChzdGF0dXMsIGRhdGEtPmlycV9iYXNlICsgcmVnX29mZnNldCk7DQo+PiA+DQo+
PiA+ICAgICAgICAgICAgICAgIGZvcl9lYWNoX3NldF9iaXQoaiwgJnN0YXR1cywgMzIpIHsNCj4+
ID4gICAgICAgICAgICAgICAgICAgICAgICBod2lycSA9IGkgKyBqIC0gMTsNCj4+ID4NCj4+DQo+
PiBHaXZlbiB0aGF0IGVhY2ggc3RhdHVzIHJlZ2lzdGVyIGFjY29tbW9kYXRlcyB0aGUgc3RhdHVz
IG9mIG9ubHkgMzENCj4+IEdQSU9zLCBJIHRoaW5rIHV0aWxpemluZyB0aGUgdXBwZXIgZm9ybWF0
IGFuZCBpbmNsdWRpbmcgZXhwbGFuYXRvcnkNCj4+IGNvbW1lbnRzIHdvdWxkIGJlIGFwcHJvcHJp
YXRlLiBJdCBjYW4gaW5kaWNhdGUgdGhlIHN0YXR1cyByZWdpc3RlcnMgb25seQ0KPmNvbnRhaW5z
IDMxIEdQSU9zLg0KPj4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBp
bmNvcnJlY3QuDQo+DQo+VGhlIGFib3ZlIGlzIGp1c3QgYSBjb2RlIGhhY2sgdG8gaGVscCBiaXRv
cHMgdG8gb3B0aW1pc2UuIDMyIGlzIHBvd2VyLW9mLTIgd2hpY2gNCj5taWdodCBiZSB0cmVhdGVk
IGJldHRlciBieSB0aGUgY29tcGlsZXIgYW5kIGhlbmNlIHByb2R1Y2UgYmV0dGVyIGNvZGUuDQo+
DQo+WWV0LCBpdCdzIGFuIGludGVycnVwdCBoYW5kbGVyIHdoZXJlIHdlIHdhbnQgdG8gaGF2ZSB0
aGUgb3BzIGFzIHNob3J0ZXIgYXMNCj5wb3NzaWJsZSwgc28gZXZlbiBtaWNyby1vcHRpbWl6YXRp
b25zIGFyZSBnb29kIHRvIGhhdmUgaGVyZSAoSSBkb24ndCBpbnNpc3QgdG8NCj5mb2xsb3cgdGhl
IHNhbWUgaWRlYSBlbHNld2hlcmUpLg0KPg0KDQpJIHVuZGVyc3RhbmQuIFRoYW5rIHlvdSBmb3Ig
ZXhwbGFpbmluZy4gSSB3aWxsIHJldmlzZSBpdC4NCg0KPj4gPj4gKyAgICAgICAgICAgICAgICAg
ICAgIH0NCj4+ID4+ICsgICAgICAgICAgICAgfQ0KPj4gPj4gKyAgICAgfQ0KPg0KDQpUaGFua3Ms
DQpUenV5aSBDaGFuZw0K

