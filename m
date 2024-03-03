Return-Path: <linux-kernel+bounces-89894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798C86F6FA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEDAB20E8C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42F79DC2;
	Sun,  3 Mar 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mhWOQBAk"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0159768E5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709496722; cv=none; b=Bl9JGe8vT83wnbeFkP8nUU/qQqrohxq3gjEFH8lGZK3vc2lPXkEPpYJYxYz0TV/3vcAmN4vrjLcz0ZpL+IPXdSjE2RZlZ3hgfr1KyxZx2kx66QNqUpdeWkzsjJ3TshsD9/zhsQzwWuB0TEJoYMGnlVz6LBsRks8uFceG0VqWH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709496722; c=relaxed/simple;
	bh=D5OGeOVlSMJFlPOZTuFHfjaOK2r326Q2K1gwABPtfFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UG9Y3+s51NMlbs+sKoVB1jOn/j5sTLiRfT8mjWhcMx+EPipwT8pN0a40U5ZRYhNJLIhweGOesMepDCfvLV0LzJwGTjTOEdvcHKnYUQAnRvu71s+8fVgKY4qVOA+m/BGRvzVD2vWfA1ppXcvvNkyMjXODZ+E1X+QDvL61CEujvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=mhWOQBAk; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C0A8B2C05EA;
	Mon,  4 Mar 2024 09:11:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709496717;
	bh=D5OGeOVlSMJFlPOZTuFHfjaOK2r326Q2K1gwABPtfFY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mhWOQBAkr2eARYcr/1YYJLYVRchHZB5mGYvYsXMbHcd2u9dNDMik+79ob3gek3Sbn
	 kc69Vff/ZbhZTX/EgLpPsOGVlrx9rLVoMvhU96PTqt3J/rAMyzpYfPIkUR/E4SOcYo
	 AbtJl+8msnUvGb/llae2aVT9xnqTeOE5tF4cgFgvryjqUPYoN3H6VXo/pYAcNXurCY
	 T7I67LLYMcBHOVIhnIeSiqYPOIuhSVweRWn/boS/peNz7TZpRlztJhBrPRz9BZi1l5
	 h5opVHchzfex5Sfg/e+x2mHOhuIC+sE/K/mvZb8cwRuAd6fPbFeEC0cT513t7FrYql
	 WvxrRL1HHFNuA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e4d98d0001>; Mon, 04 Mar 2024 09:11:57 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 09:11:57 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 4 Mar 2024 09:11:57 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
	<andy@kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>, "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
Thread-Topic: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
Thread-Index: AQHaa3mtyWWtVlg2vEC72XlMinhTXbEiWoIAgAKUiACAAK4qgA==
Date: Sun, 3 Mar 2024 20:11:57 +0000
Message-ID: <7248b6f6-86e7-4df1-8c48-c53f70c909b9@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
 <ZeIdXIx5zYjKQiSO@smile.fi.intel.com>
 <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FEBCA6EDEF9754691E92F9FAC177CD3@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e4d98d a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=VwQbUJbxAAAA:8 a=_l-1M7-265V4-iQ9KdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAzLzAzLzI0IDIyOjQ4LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+IEhpIEFuZHks
DQo+DQo+IE9uIEZyaSwgTWFyIDEsIDIwMjQgYXQgNzoyNOKAr1BNIEFuZHkgU2hldmNoZW5rbyA8
YW5keUBrZXJuZWwub3JnPiB3cm90ZToNCj4+IE9uIEZyaSwgTWFyIDAxLCAyMDI0IGF0IDAyOjQy
OjAzUE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4gVXNlIHRoZSBkb3Qgb24gdGhl
IDctc2VnbWVudCBMRUQgYmxvY2sgdG8gaW5kaWNhdGUgVVNCIGFjY2VzcyBvbiB0aGUNCj4+PiB4
NTMwLg0KPj4gQXMgSSBzYWlkLCBJJ20gbm90IGdvaW5nIHRvIGFwcGx5IHRoaXMgZXZlbiB3aXRo
IEFja3MuDQoNCkknbGwgZHJvcCB0aGlzIG9uZSBmb3IgdGhlIG5leHQgcm91bmQuDQoNCj4gSSBn
dWVzcyB5b3Ugc2hvdWxkIG5vdCBhcHBseSBhbnkgb2YgdGhlIGR0cyBwYXRjaGVzIHRvIHRoZQ0K
PiBhdXhkaXNwbGF5IHRyZWUgYW55d2F5Pw0KDQpUaGF0J3MgT0sgYnkgbWUuIEkndmUganVzdCBi
ZWVuIGluY2x1ZGluZyB0aGVtIHNvIHRoZXJlIGlzIGFuIGluLXRyZWUgDQp1c2VyIG9mIHRoZSBk
cml2ZXIuIEl0IGFsc28gc2hvd3MgaG93IEkndmUgYmVlbiB0ZXN0aW5nIHRoaW5ncy4NCg0KSSBj
YW4gc2VuZCB0aGVtIHZpYSB0aGUgQVJNIG1haW50YWluZXJzIG9uY2UgdGhlIGR1c3Qgc2V0dGxl
cyBvbiB0aGUgDQpmaXJzdCB0d28gcGF0Y2hlcy4NCg0KPg0KPj4gVGhlIHByb2JsZW0gaGVyZSBh
cyBJIHNlZSBpdCBpcyB0aGUgZnV0dXJlIGRlY2lzaW9uIG9uIGhvdyBEUCBzaG91bGQNCj4+IGJl
aGF2ZSBsaWtlLiAgSWYgeW91IHB1dCB0aGlzIGludG8gRFQsIHdlIHdpbGwgdG8gc3VwcG9ydCB0
aGlzIHRvIHRoZSBlbmQNCj4+IG9mIHRoZSBwbGF0Zm9ybS4NCj4gQXMgdGhlcmUgZXhpc3QgNy1z
ZWcgZGlzcGxheXMgKGFuZCB3aXJpbmdzKSB3aXRoIGFuZCB3aXRob3V0IERQLA0KPiB0aGUgNy1z
ZWcgZHJpdmVyIGFuZCBEVCBiaW5kaW5ncyBzaG91bGQgaGFuZGxlIGJvdGggY2FzZXMuICBIb3cg
dG8NCj4gd2lyZS91c2UgdGhlIERQIExFRCBpcyB1cCB0byB0aGUgaGFyZHdhcmUgZGVzaWduZXIg
LyBEVFMgd3JpdGVyLg0KPg0KPiBJIGFncmVlIGl0J3MgYSB0aGluIGJvdW5kYXJ5IGJldHdlZW4g
aGFyZHdhcmUgZGVzY3JpcHRpb24gYW5kIHNvZnR3YXJlDQo+IHBvbGljeSwgdGhvdWdoLiAgSXMg
dGhhdCB5b3VyIG1haW4gY29uY2Vybj8NCg0KSW4gdGhpcyBzcGVjaWZpYyBjYXNlIEknZCBqdXN0
aWZ5IHRoZSAoYWIpdXNlIG9mIHRoZSBEUCBMRUQgb24gdGhpcyANCnByb2R1Y3QgYXMgYW4gb3B0
aW1pemF0aW9uIHNvIHdlIGRvbid0IGhhdmUgdG8gZmluZCBib2FyZCBzcGFjZSBmb3IgYSANCnNl
cGFyYXRlIExFRCB0byBpbmRpY2F0ZSBVU0IgYWN0aXZpdHkuDQoNCkkgZG8gaGF2ZSBhbiBpZGVh
IGZvciBoYW5kbGluZyB0aGUgRFAgZm9yIHRoZSBtb3JlIGdlbmVyYWwgY2FzZS4gDQpCYXNpY2Fs
bHkgaWYgOCBzZWdtZW50IEdQSU9zIGFyZSBzdXBwbGllZCB3ZSBjYW4gdXNlIGEgc2xpZ2h0bHkg
DQpkaWZmZXJlbnQgc2VnbWVudMKgbWFwIChtYXA3cGx1czE/KSBzbyB0aGF0IGNoYXJhY3RlcnMg
dGhhdCBhcmUgYmV0dGVyIA0KcmVwcmVzZW50ZWQgYXMgZG90cyB1c2UgdGhhdCBpbnN0ZWFkLg0K
DQo=

