Return-Path: <linux-kernel+bounces-9399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C639D81C503
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E6C1C22D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E28C14;
	Fri, 22 Dec 2023 06:21:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA279C4;
	Fri, 22 Dec 2023 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM6KXLd81950065, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM6KXLd81950065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 14:20:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 22 Dec 2023 14:20:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 14:20:34 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::99d6:b187:8b72:6226]) by
 RTEXMBS03.realtek.com.tw ([fe80::99d6:b187:8b72:6226%2]) with mapi id
 15.01.2507.035; Fri, 22 Dec 2023 14:20:34 +0800
From: =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot
	<lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: RE: [PATCH v3 2/6] irqchip: Add interrupt controller support for Realtek DHC SoCs
Thread-Topic: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Thread-Index: AQHaIocg6atZJ97H502y6uXXYTUFxrCfC+8AgASpsgCADjI3AIAC1ELQ
Date: Fri, 22 Dec 2023 06:20:33 +0000
Message-ID: <e96f77598aec446c9a68c01afe61cfd9@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com> <87cyvgsocp.ffs@tglx>
 <d9556a14e8d64f83b89a2d1d231003f4@realtek.com> <87sf3wlwlz.ffs@tglx>
In-Reply-To: <87sf3wlwlz.ffs@tglx>
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

SGkgVGhvbWFzLA0KDQo+Pj5PbiBXZWQsIE5vdiAyOSAyMDIzIGF0IDEzOjQzLCBKYW1lcyBUYWkg
d3JvdGU6DQo+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcmVhbHRla19pbnRjX2NsZWFyX2ludHNf
Yml0KHN0cnVjdA0KPj4+PiArcmVhbHRla19pbnRjX2RhdGEgKmRhdGEsIGludCBiaXQpIHsNCj4+
Pj4gKyAgICAgd3JpdGVsKEJJVChiaXQpICYgfjEsIGRhdGEtPmJhc2UgKyBkYXRhLT5pbmZvLT5p
c3Jfb2Zmc2V0KTsNCj4+Pg0KPj4+VGhhdCAnJiB+MScgc29sdmVzIHdoYXQgYXNpZGUgb2YgcHJl
dmVudGluZyBiaXQgMCBmcm9tIGJlaW5nIHdyaXR0ZW4/DQo+Pj4NCj4+IFRoZSBJU1IgcmVnaXN0
ZXIgdXNlcyBiaXQgMCB0byBjbGVhciBvciBzZXQgSVNSIHN0YXR1cy4NCj4+IFdyaXRlIDAgdG8g
Y2xlYXIgYml0cyBhbmQgd3JpdGUgMSB0byBzZXQgYml0cy4NCj4+IFRoZXJlZm9yZSwgdG8gY2xl
YXIgdGhlIGludGVycnVwdCBzdGF0dXMsIGJpdCAwIHNob3VsZCBjb25zaXN0ZW50bHkgYmUNCj4+
IHNldCB0byAnMCcuDQo+DQo+QW5kIGhvdyBkb2VzIEJJVChiaXQpIHdpdGggMSA8PSBiaXQgPD0g
MzEgZW5kIHVwIGhhdmluZyBiaXQgMCBzZXQ/DQo+DQo+QWxzbyBhIGNvbW1lbnQgZXhwbGFpbmlu
ZyB0aGUgcmVhc29uaW5nIGhlcmUgd291bGQgYmUgaGVscGZ1bC4NCg0KVG8gcGVyZm9ybSB0aGUg
Y2xlYXJpbmcgYWN0aW9uIGluIHRoZSBJU1IgcmVnaXN0ZXIsIGl0J3MgZXNzZW50aWFsIHRoYXQg
Yml0IDAgcmVtYWlucyBzZXQgdG8gMC4NClRoaXMgaXMgYmVjYXVzZSBiaXQgMCBpbiB0aGUgSVNS
IHJlZ2lzdGVyIGhhcyBhIHNwZWNpZmljIGZ1bmN0aW9uIGZvciBjb250cm9sbGluZyB0aGUgaW50
ZXJydXB0IHN0YXR1cy4NCldoZW4gQklUKGJpdCkgaXMgdXNlZCB3aXRoIDEgPD0gYml0IDw9IDMx
LCBpdCBnZW5lcmF0ZXMgYSBiaXRtYXNrIHdpdGggb25seSB0aGF0IHBhcnRpY3VsYXIgYml0IHNl
dCB0byAxLCBhbmQgYWxsIG90aGVyIGJpdHMsIGluY2x1ZGluZyBiaXQgMCwgc2V0IHRvIDAuDQpU
aGUgJyYgfjEnIG9wZXJhdGlvbiBpcyB0aGVuIGFwcGxpZWQgdG8gZW5zdXJlIHRoYXQgZXZlbiBp
ZiBiaXQgMCB3YXMgc29tZWhvdyBzZXQsIGl0IHdpbGwgYmUgY2xlYXJlZCwgbWFpbnRhaW5pbmcg
dGhlIHJlZ2lzdGVyJ3MgZnVuY3Rpb25hbGl0eS4gDQoNCkZvciBleGFtcGxlLCBzdXBwb3NlIHRo
ZSBjdXJyZW50IHZhbHVlIG9mIHRoZSBJU1IgcmVnaXN0ZXIgaXMgMHg0LCBhbmQgd2Ugd2FudCB0
byBjbGVhciBiaXQgMy4NCkluIHRoYXQgY2FzZSwgd3JpdGluZyAweDQgKHdoaWNoIHJlcHJlc2Vu
dHMgYml0IDMgc2V0IHRvIDEpIHRvIHRoZSBJU1IgcmVnaXN0ZXIgd2lsbCBjbGVhciBiaXQgMy4N
Cg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0KDQo=

