Return-Path: <linux-kernel+bounces-4721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC5818128
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4031F23D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2292746A;
	Tue, 19 Dec 2023 05:51:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD0749D;
	Tue, 19 Dec 2023 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BJ5p64813981591, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BJ5p64813981591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:51:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 19 Dec 2023 13:51:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 19 Dec 2023 13:51:06 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Tue, 19 Dec 2023 13:51:06 +0800
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
Subject: RE: [PATCH v3 3/6] irqchip: Introduce RTD1319 support using the Realtek common interrupt controller driver
Thread-Topic: [PATCH v3 3/6] irqchip: Introduce RTD1319 support using the
 Realtek common interrupt controller driver
Thread-Index: AQHaIociD8/C4U5vBESKdaYAQOIKRbCfDcIAgBEkQIA=
Date: Tue, 19 Dec 2023 05:51:06 +0000
Message-ID: <981d456fe3724831903b3851f442f755@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-4-james.tai@realtek.com> <87a5qkso1t.ffs@tglx>
In-Reply-To: <87a5qkso1t.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
b3RlOg0KPj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBSVEQxMzE5IHBsYXRmb3JtLg0KPj4NCj4+IFJl
cG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+IENsb3NlczoN
Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzExMDYxMjA4LmhK
bXhHcXltLWxrcEBpbnRlbC4NCj4+IGNvbS8NCj4NCj5BZ2FpbjogVGhlc2UgdGFncyBhcmUganVz
dCB3cm9uZy4NCg0KSSB3aWxsIHJlbW92ZSBpdC4NCg0KPj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZv
cm1fZHJpdmVyIHJlYWx0ZWtfaW50Y19ydGQxMzE5X2RyaXZlciA9IHsNCj4+ICsgICAgIC5wcm9i
ZSA9IHJ0ZDEzMTlfaW50Y19wcm9iZSwNCj4+ICsgICAgIC5kcml2ZXIgPSB7DQo+PiArICAgICAg
ICAgICAgIC5uYW1lID0gInJlYWx0ZWtfaW50Y19ydGQxMzE5IiwNCj4+ICsgICAgICAgICAgICAg
Lm9mX21hdGNoX3RhYmxlID0gcmVhbHRla19pbnRjX3J0ZDEzMTlfZHRfbWF0Y2hlcywNCj4+ICsg
ICAgICAgICAgICAgLnN1cHByZXNzX2JpbmRfYXR0cnMgPSB0cnVlLA0KPj4gKyAgICAgICAgICAg
ICAucG0gPSAmcmVhbHRla19pbnRjX3J0ZDEzMTlfcG1fb3BzLA0KPj4gKyAgICAgfSwNCj4NCj4g
ICAgICAgIC5wcm9iZSAgPSBydGQxMzE5X2ludGNfcHJvYmUsDQo+ICAgICAgICAuZHJpdmVyID0g
ew0KPiAgICAgICAgICAgICAgICAubmFtZSAgICAgICAgICAgICAgICAgICA9ICJyZWFsdGVrX2lu
dGNfcnRkMTMxOSIsDQo+ICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSAgICAgICAgID0N
Cj5yZWFsdGVrX2ludGNfcnRkMTMxOV9kdF9tYXRjaGVzLA0KPiAgICAgICAgICAgICAgICAuLi4u
DQo+DQo+UGxlYXNlLg0KPg0KSSB3aWxsIGZpeCBpdC4NCg0KPj4gK307DQo+PiArDQo+PiArc3Rh
dGljIGludCBfX2luaXQgcmVhbHRla19pbnRjX3J0ZDEzMTlfaW5pdCh2b2lkKSB7DQo+PiArICAg
ICByZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZyZWFsdGVrX2ludGNfcnRkMTMxOV9k
cml2ZXIpOw0KPj4gK30NCj4+ICtjb3JlX2luaXRjYWxsKHJlYWx0ZWtfaW50Y19ydGQxMzE5X2lu
aXQpOw0KPg0KPldoYXQ/IFRoaXMgY2FuIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBTbyBob3cgaXMg
Y29yZV9pbml0Y2FsbCgpIGluIGFueSB3YXkgY29ycmVjdA0KPmhlcmU/IG1vZHVsZV9pbml0KCkg
cGVyaGFwcz8NCj4NCkkgd2FudCB0aGUgZHJpdmVyIHRvIGJlIGJ1aWxkYWJsZSBhcyBhIG1vZHVs
ZS4gQmFzZWQgb24gbXkgdGVzdCwgdGhlICdjb3JlX2luaXRjYWxsKCknIHdvcmtzLg0KQnV0LCBJ
IHdpbGwgdXNlICdtb2R1bGVfaW5pdCgpJyBpbnN0ZWFkLg0KDQpUaGFua3MgZm9yIHlvdXIgZmVl
ZGJhY2suDQoNClJlZ2FyZHMsDQpKYW1lcw0KDQoNCg==

