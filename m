Return-Path: <linux-kernel+bounces-4704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B458180D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE321C2186D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289D63D1;
	Tue, 19 Dec 2023 05:10:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBB5393;
	Tue, 19 Dec 2023 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BJ5AGnrC3951940, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BJ5AGnrC3951940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:10:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 19 Dec 2023 13:10:17 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 13:10:16 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Tue, 19 Dec 2023 13:10:16 +0800
From: =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To: Rob Herring <robh+dt@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v3 3/6] irqchip: Introduce RTD1319 support using the Realtek common interrupt controller driver
Thread-Topic: [PATCH v3 3/6] irqchip: Introduce RTD1319 support using the
 Realtek common interrupt controller driver
Thread-Index: AQHaIociD8/C4U5vBESKdaYAQOIKRbCj5z+AgAwrEXA=
Date: Tue, 19 Dec 2023 05:10:16 +0000
Message-ID: <a8c07be6cb1f4b5db506b5b5cbe296b4@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-4-james.tai@realtek.com>
 <CAL_Jsq+WJ2me4CoPN14pof4aMegC1F6ei6q_Nt8+RYG3bfJM4g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+WJ2me4CoPN14pof4aMegC1F6ei6q_Nt8+RYG3bfJM4g@mail.gmail.com>
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

SGkgUm9iLA0KDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJx
LXJlYWx0ZWstcnRkMTMxOS5jDQo+PiBAQCAtMCwwICsxLDIxOCBAQA0KPj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vci1sYXRlciBPUiBCU0QtMi1DbGF1c2UpDQo+PiAr
LyoNCj4+ICsgKiBSZWFsdGVrIFJURDEzMTkgaW50ZXJydXB0IGNvbnRyb2xsZXIgZHJpdmVyDQo+
PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjMgUmVhbHRlayBTZW1pY29uZHVjdG9yIENv
cnBvcmF0aW9uICAqLw0KPj4gKw0KPj4gKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+PiArI2lu
Y2x1ZGUgPGxpbnV4L2lvLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2lycWNoaXAuaD4NCj4+ICsj
aW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+DQo+WW91IHByb2JhYmx5IGRvbid0IG5lZWQg
dGhpcyBoZWFkZXIgYW5kIHRoZSBpbXBsaWNpdCBpbmNsdWRlcyBpdCBtYWtlcyBhcmUNCj5kcm9w
cGVkIG5vdyBpbiBsaW51eC1uZXh0LiBQbGVhc2UgY2hlY2sgd2hhdCB5b3UgYWN0dWFsbHkgbmVl
ZCBhbmQgbWFrZSB0aGVtDQo+ZXhwbGljaXQuDQo+DQpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4g
SSB3aWxsIGFkanVzdCBpdC4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K

