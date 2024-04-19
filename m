Return-Path: <linux-kernel+bounces-151073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0078AA8AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773881F21565
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BD3A28E;
	Fri, 19 Apr 2024 06:53:45 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775663E;
	Fri, 19 Apr 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509625; cv=none; b=m1iET2V89g78yaoR3TAyr74uhzmh0z4owmb1W5V5JWyvpdAK5d1/pjwAv9lnRjhyNGVrFWiXG/tKtsH52NNEvo3uNpq5zCrN0+YKdr/qqDmCvFnA72iFPypOBoyW2UewyCdznvzmOv3CCtWg62J2wrC54zsLBtkoB+h3o5aTqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509625; c=relaxed/simple;
	bh=vO6jtl95JtCYDR2yKdhkHYFHamW52HJiQ3BpdOR+C0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=GpFqajwtdUIeVoJUwnKm/HpqkiNQCXWtQf0GZUuV1afLPtqU3xn0JBB2VwnOUUrCF6JTnE2ZsJUNRXsMQy34TEu5hA7cXolfo4uUmOyEd05GxCTUyF9+XnMV5WyLAvfxnG5EhIb6mv0puJy+nJocBR+qSDJoKiy+LqEKYeb4srQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43J6rGOU11095324, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43J6rGOU11095324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 14:53:16 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 14:53:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 14:53:16 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Fri, 19 Apr 2024 14:53:16 +0800
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
Thread-Index: AQHaf/Di2MMAmClaHUaVpFhOVxydUrFMk6cAgAHWPUCAIOE18A==
Date: Fri, 19 Apr 2024 06:53:16 +0000
Message-ID: <8b966794f2bb4fda8cc7d3e111bfef70@realtek.com>
References: <20240327024545.138351-1-ricky_wu@realtek.com>
 <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

U29mdCByZW1pbmRlcg0KDQpJZiB0aGlzIHNvbHV0aW9uLCB5b3Ugc3RpbGwgaGF2ZSBjb25jZXJ0
IG9uIHNkLmMuDQpjYW4gd2UganVzdCBkbyB0aGlzIGNoZWNrIGNhcmQgZmxvdyBpbiBtbWMgaG9z
dCBwb3dlciB1cCBjYWxsX2JhY2s/IA0KDQo+ID4gPg0KPiA+ID4gX21tY19zZF9yZXN1bWUNCj4g
PiA+IGFkZCBnZXRfY2QgYmVmb3JlIGNhbGwgcG93ZXJ1cCwgbWFrZSBzdXJlIHRoZSBjYXJkIGV4
aXN0DQo+ID4NCj4gPiBQbGVhc2UgZWxhYm9yYXRlIG1vcmUgb24gd2hhdCBwcm9ibGVtIHlvdSBh
cmUgdHJ5aW5nIHRvIHNvbHZlLCB0aGUNCj4gPiBhYm92ZSBkb2Vzbid0IG1ha2UgbXVjaCBzZW5z
ZSB0byBtZSwgc29ycnkuDQo+ID4NCj4gPiBZZXMsIHRoZSBjYXJkIG1heSBiZSByZW1vdmVkIHdo
aWxlIHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGVkLiBUaGVuLCBldmVuDQo+ID4gaWYgLT5nZXRfY2Qo
KSBpbmRpY2F0ZXMgdGhhdCB0aGVyZSBpcyBubyBjYXJkIGluc2VydGVkIGluIHRoZQ0KPiA+IFNE
LWNhcmQtc2xvdCwgd2UgbWF5IHN0aWxsIGhhdmUgdGhlIGNhcmQgYmVpbmcgcmVnaXN0ZXJlZCAt
IGFuZCB0aGVuDQo+ID4gd2UgbmVlZCB0byB1bnJlZ2lzdGVyIGl0Lg0KPiA+IFRoYXQgc2FpZCwg
d2UgbmVlZCB0byBjYWxsIG1tY19wb3dlcl91cCgpIGluIG9yZGVyIHRvIHRyeSB0bw0KPiA+IGNv
bW11bmljYXRlIHdpdGggdGhlIGNhcmQgYWdhaW4uIEF0IGxlYXN0IHRoYXQgaXMgd2hhdCB0aGUN
Cj4gPiBtbWNfcmVzY2FuKCkgd29yayBhc3N1bWVzIHdoZW4gaXQgcnVucyB0aGUgYnVzX29wcy0+
ZGV0ZWN0KCkgY2FsbGJhY2sNCj4gPiBhdCBzb21lIHBvaW50IGxhdGVyIGluIHRpbWUuDQo+ID4N
Cj4gDQo+IFdlIHNhdyB0aGUgcG93ZXIgdXAgaW4gYSBzaG9ydCB0aW1lIGZyb20gd2F2ZWZvcm0g
d2hlbiByZW1vdmluZyB0aGUgY2FyZCwNCj4gU28gd2Ugc2F3IG1tY19zZF9yZXN1bWUgY2FsbCB0
aGUgcG93ZXIgdXAgZGlkIG5vdCBjaGVjayB0aGUgY2FyZCBleGlzdC4NCj4gDQo+IFdlIHRoaW5r
IHRoaXMgdGhlIHNob3J0IHRpbWUgcG93ZXIgdXAgbWF5YmUgY2F1c2UgT0NQIGlmIG5vIGNhcmQg
ZXhpc3QuDQo+IEFuZCB0aGlzIHBvd2VyIHVwIHdlIHRoaW5rIGlzIHVubmVjZXNzYXJ5IHdoZW4g
bm8gY2FyZCBleGlzdC4NCj4gDQo+IA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2t5
IFd1IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbW1j
L2NvcmUvc2QuYyB8IDMgKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMgYi9kcml2
ZXJzL21tYy9jb3JlL3NkLmMgaW5kZXgNCj4gPiA+IDFjODE0OGNkZGE1MC4uMzVlMDM2NjcyY2Zi
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9zZC5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL21tYy9jb3JlL3NkLmMNCj4gPiA+IEBAIC0xNzUwLDYgKzE3NTAsOSBAQCBzdGF0aWMg
aW50IF9tbWNfc2RfcmVzdW1lKHN0cnVjdCBtbWNfaG9zdA0KPiA+ICpob3N0KQ0KPiA+ID4gICAg
ICAgICBpZiAoIW1tY19jYXJkX3N1c3BlbmRlZChob3N0LT5jYXJkKSkNCj4gPiA+ICAgICAgICAg
ICAgICAgICBnb3RvIG91dDsNCj4gPiA+DQo+ID4gPiArICAgICAgIGlmIChob3N0LT5vcHMtPmdl
dF9jZCAmJiAhaG9zdC0+b3BzLT5nZXRfY2QoaG9zdCkpDQo+ID4gPiArICAgICAgICAgICAgICAg
Z290byBvdXQ7DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIG1tY19wb3dlcl91cChob3N0LCBob3N0
LT5jYXJkLT5vY3IpOw0KPiA+ID4gICAgICAgICBlcnIgPSBtbWNfc2RfaW5pdF9jYXJkKGhvc3Qs
IGhvc3QtPmNhcmQtPm9jciwgaG9zdC0+Y2FyZCk7DQo+ID4gPiAgICAgICAgIG1tY19jYXJkX2Ns
cl9zdXNwZW5kZWQoaG9zdC0+Y2FyZCk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0K
PiA+DQo+ID4gS2luZCByZWdhcmRzDQo+ID4gVWZmZQ0K

