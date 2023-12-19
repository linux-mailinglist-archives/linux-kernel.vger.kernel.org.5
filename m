Return-Path: <linux-kernel+bounces-4644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA1818039
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F300B24039
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49E5253;
	Tue, 19 Dec 2023 03:30:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AD7472;
	Tue, 19 Dec 2023 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BJ3Tvt563890721, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BJ3Tvt563890721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 11:29:57 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 19 Dec 2023 11:29:58 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 19 Dec 2023 11:29:57 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Tue, 19 Dec 2023 11:29:57 +0800
From: =?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot
	<lkp@intel.com>
Subject: RE: [PATCH v3 6/6] irqchip: Introduce RTD1619B support using the Realtek common interrupt controller driver
Thread-Topic: [PATCH v3 6/6] irqchip: Introduce RTD1619B support using the
 Realtek common interrupt controller driver
Thread-Index: AQHaIoclxtugOACQwUu27mSTyHUs1bCfDsWAgBD/vVA=
Date: Tue, 19 Dec 2023 03:29:57 +0000
Message-ID: <a5cb8869bbc342c2a1451a63bf6ce0d9@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-7-james.tai@realtek.com> <877closnvs.ffs@tglx>
In-Reply-To: <877closnvs.ffs@tglx>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

SGkgVGhvbWFzLA0KDQo+T24gV2VkLCBOb3YgMjkgMjAyMyBhdCAxMzo0MywgSmFtZXMgVGFpIHdy
b3RlOg0KPj4gK3N0YXRpYyBpbnQgcmVhbHRla19pbnRjX3J0ZDE2MTliX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KSB7DQo+PiArICAgICBzdHJ1Y3QgcmVhbHRla19pbnRjX2RhdGEgKmRhdGEg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4+ICsgICAgIGNvbnN0IHN0cnVjdCByZWFsdGVrX2lu
dGNfaW5mbyAqaW5mbyA9IGRhdGEtPmluZm87DQo+PiArDQo+PiArICAgICBkYXRhLT5zYXZlZF9l
biA9IHJlYWRsKGRhdGEtPmJhc2UgKyBpbmZvLT5zY3B1X2ludF9lbl9vZmZzZXQpOw0KPj4gKw0K
Pj4gKyAgICAgd3JpdGVsKERJU0FCTEVfSU5UQywgZGF0YS0+YmFzZSArIGluZm8tPnNjcHVfaW50
X2VuX29mZnNldCk7DQo+PiArICAgICB3cml0ZWwoQ0xFQU5fSU5UQ19TVEFUVVMsIGRhdGEtPmJh
c2UgKyBpbmZvLT51bXNrX2lzcl9vZmZzZXQpOw0KPj4gKyAgICAgd3JpdGVsKENMRUFOX0lOVENf
U1RBVFVTLCBkYXRhLT5iYXNlICsgaW5mby0+aXNyX29mZnNldCk7DQo+PiArDQo+PiArICAgICBy
ZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCByZWFsdGVrX2ludGNfcnRkMTYx
OWJfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPj4gKyAgICAgc3RydWN0IHJlYWx0ZWtf
aW50Y19kYXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiArICAgICBjb25zdCBz
dHJ1Y3QgcmVhbHRla19pbnRjX2luZm8gKmluZm8gPSBkYXRhLT5pbmZvOw0KPj4gKw0KPj4gKyAg
ICAgd3JpdGVsKENMRUFOX0lOVENfU1RBVFVTLCBkYXRhLT5iYXNlICsgaW5mby0+dW1za19pc3Jf
b2Zmc2V0KTsNCj4+ICsgICAgIHdyaXRlbChDTEVBTl9JTlRDX1NUQVRVUywgZGF0YS0+YmFzZSAr
IGluZm8tPmlzcl9vZmZzZXQpOw0KPj4gKyAgICAgd3JpdGVsKGRhdGEtPnNhdmVkX2VuLCBkYXRh
LT5iYXNlICsgaW5mby0+c2NwdV9pbnRfZW5fb2Zmc2V0KTsNCj4+ICsNCj4+ICsgICAgIHJldHVy
biAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgcmVh
bHRla19pbnRjX3J0ZDE2MTliX3BtX29wcyA9IHsNCj4+ICsgICAgIC5zdXNwZW5kX25vaXJxID0g
cmVhbHRla19pbnRjX3J0ZDE2MTliX3N1c3BlbmQsDQo+PiArICAgICAucmVzdW1lX25vaXJxICA9
IHJlYWx0ZWtfaW50Y19ydGQxNjE5Yl9yZXN1bWUsIH07DQo+DQo+U28gdGhpcyBpcyB0aGUgNHRo
IGNvcHkgb2YgdGhlIHNhbWUgY29kZSwgcmVhbGx5PyBXaHkgaXMgdGhpcyBub3QgcGFydCBvZiB0
aGUNCj5jb21tb24gY29kZT8NCj4NClllcyBpdCBpcyB0aGUgc2FtZSBjb2RlLiANCkkgaGFkIG9y
aWdpbmFsbHkgYXNzdW1lZCB0aGF0IGVhY2ggcGxhdGZvcm0gd291bGQgcmVxdWlyZSBzb21lIGRp
ZmZlcmVudCBzZXR0aW5ncywgDQpidXQgSSd2ZSByZWFsaXplZCB0aGF0IHRoZXJlIGlzIG5vIHN1
Y2ggcmVxdWlyZW1lbnQgaW4gdGhlIGN1cnJlbnQgYXJjaGl0ZWN0dXJlLg0KSSB3aWxsIG1vdmUg
dGhpcyBwYXJ0IHRvIHRoZSBjb21tb24gY29kZS4NCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNr
Lg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0KDQo=

