Return-Path: <linux-kernel+bounces-82281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30238681BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F141C23820
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8B130E2F;
	Mon, 26 Feb 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="btkjh9cW"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F82130AFB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978212; cv=none; b=aDqUtVewCVDvUkFL4mldqKOcUuh271IxwML067uT9YdGhuuVxNp6NXvy/LIXeNXicOsLB7uY/OKTmi9055oD4JJPM4jRe7jFGzjkF+o3K3TPWWZH48vPyIBH/cWArUzAdn6cm6sgQybgShCOKYqP/8N8Co50hraQepkuS4r2Atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978212; c=relaxed/simple;
	bh=GRYJpD2GQd/of/ZDHnJWCMiKf8wHoLY63Vq9FcSatco=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgUbmITliQPpeb0unY/CzegjpUR1F79GhCDnYAnDVgILf7tl/cyx/S/9ewrJOvGPzBRc6FbMV/ism+gSwvygtIRtTXjRm974tfoUjn8KBL+ss7Y1y99NRnKwdvu2/9ULTbF2UldAVwcyJiZ62uVG3KDbPH8NmkEh1x6XgZqV0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=btkjh9cW; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F27402C0546;
	Tue, 27 Feb 2024 09:10:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708978207;
	bh=GRYJpD2GQd/of/ZDHnJWCMiKf8wHoLY63Vq9FcSatco=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=btkjh9cWgjC15A+oKPu+0FfP/F7ME5kXBv1NXor1jCUZKMFb4P9URALK7obEceKUX
	 p4DfIK1yJ6QyTkBwD3VLQNVj/3c6XyvLMJCv/K85jnRq6vQzdi/iwoWsk1WhRumr3N
	 2J7nhz67S6sDvwTugzTCrAlpI+PGTZagTbkpdK0qleEamL95qbiGNMoriV2/3+fCNF
	 aamyvVoOre7Dqo71hvp3HCQWOdaUsVbjdf1ro1JKJtvsWPnnOHo8tYB82riMhHuKDb
	 6+iRth2Cyoq4wbo3PJtTYynoOwdVdGQDQnn5oKLrRi4vVkvTcYqhZJV2THMhvWcnPC
	 Ib/UVnZVtneEg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dcf01f0003>; Tue, 27 Feb 2024 09:10:07 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 09:10:07 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 27 Feb 2024 09:10:07 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "ojeda@kernel.org" <ojeda@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"lee@kernel.org" <lee@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
Thread-Topic: [PATCH 0/3] auxdisplay: 7 segment LED display
Thread-Index: AQHaaDJtdshPwhTk10iKhi7EmCZrNrEb8MQAgABEfoA=
Date: Mon, 26 Feb 2024 20:10:07 +0000
Message-ID: <fd1c8657-62e6-449c-b47f-a2c3223b405c@alliedtelesis.co.nz>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <20240226-scabby-fiber-87d5d6e45028@thorsis.com>
In-Reply-To: <20240226-scabby-fiber-87d5d6e45028@thorsis.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D6E7C3A283E947B23B5378B5F90F56@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dcf01f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=62ntRvTiAAAA:8 a=VwQbUJbxAAAA:8 a=nA1LQh-uExD0dWyk3wUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

SGkgQWxleCwNCg0KT24gMjcvMDIvMjQgMDU6MDQsIEFsZXhhbmRlciBEYWhsIHdyb3RlOg0KPiBI
ZWxsbyBDaHJpcywNCj4NCj4gQW0gTW9uLCBGZWIgMjYsIDIwMjQgYXQgMTA6MzQ6MjBBTSArMTMw
MCBzY2hyaWViIENocmlzIFBhY2toYW06DQo+PiBUaGlzIHNlcmllcyBhZGRzIGEgZHJpdmVyIGZv
ciBhIDcgc2VnbWVudCBMRUQgZGlzcGxheS4NCj4+DQo+PiBJJ2QgbGlrZSB0byBnZXQgc29tZSBm
ZWVkYmFjayBvbiBob3cgdGhpcyBjb3VsZCBiZSBleHRlbmRlZCB0byBzdXBwb3J0ID4xDQo+PiBj
aGFyYWN0ZXIuIFRoZSBkcml2ZXIgYXMgcHJlc2VudGVkIGlzIHN1ZmZpY2llbnQgZm9yIG15IGhh
cmR3YXJlIHdoaWNoIG9ubHkgaGFzDQo+PiBhIHNpbmdsZSBjaGFyYWN0ZXIgZGlzcGxheSBidXQg
SSBjYW4gc2VlIHRoYXQgZm9yIHRoaXMgdG8gYmUgZ2VuZXJpY2FsbHkgdXNlZnVsDQo+PiBzdXBw
b3J0aW5nIG1vcmUgY2hhcmFjdGVycyB3b3VsZCBiZSBkZXNpcmVhYmxlLg0KPj4NCj4+IEVhcmxp
ZXIgSSBwb3N0ZWQgYW4gaWRlYSB0aGF0IHRoZSBjaGFyYWN0ZXJzIGNvdWxkIGJlIHJlcHJlc2Vu
ZGVkIGJ5DQo+PiBzdWItbm9kZXNbMV0gYnV0IHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHdh
eSBvZiBoYXZpbmcgdGhhdCBhbmQga2VlcGluZyB0aGUNCj4+IGNvbnZlbmllbmNlIG9mIHVzaW5n
IGRldm1fZ3Bpb2RfZ2V0X2FycmF5KCkgKHVubGVzcyBJJ3ZlIG1pc3NlZCBzb21ldGhpbmcpLg0K
Pj4NCj4+IFsxXSAtIGh0dHBzOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPXRy
YmM1ZUFSVm8tNWdlcFJud2JBS2JRbWlHazFiT1NwcVpEUXg5Yng3dyZ1PWh0dHBzJTNhJTJmJTJm
bG9yZSUyZWtlcm5lbCUyZW9yZyUyZmxrbWwlMmYyYThkMTllZS1iMThiLTRiN2MtODY5Zi03ZDYw
MWNlYTMwYjYlNDBhbGxpZWR0ZWxlc2lzJTJlY28lMmVueiUyZg0KPiBSZWFkIHRoYXQgdGhyZWFk
IG91dCBvZiBjdXJpb3NpdHkgYW5kIEknbSBzb3JyeSBpZiBJJ20gbGF0ZSB0byB0aGUNCj4gcGFy
dHksIGJ1dCBJIHdvbmRlcmVkIHdoeSB0aGlzIGlzIGxpbWl0ZWQgdG8gTEVEcyBjb25uZWN0ZWQg
dG8gR1BJT3M/DQo+DQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHNvbWVob3cgc3RhY2sgdGhp
cyBvbiB0b3Agb2Ygc29tZSBleGlzdGluZw0KPiBMRURzPyAgSSBtZWFuIHlvdSBjb3VsZCB3aXJl
IGEgNyBzZWdtZW50IGRldmljZSB0byBhbG1vc3QgYW55IExFRA0KPiBkcml2ZXIgSUMgd2l0aCBl
bm91Z2ggY2hhbm5lbHMsIGNvdWxkbid0IHlvdT8NCg0KTWFpbmx5IGJlY2F1c2UgdGhlIEdQSU8g
dmVyc2lvbiBpcyB0aGUgaGFyZHdhcmUgSSBoYXZlLiBJIGRvIHdvbmRlciBob3cgDQp0aGlzIG1p
Z2h0IHdvcmsgd2l0aCBzb21ldGhpbmcgbGlrZSB0aGUgcGNhOTU1MSB3aGljaCByZWFsbHkgaXMg
anVzdCBhIA0KZmFuY3kgdmVyc2lvbiBvZiB0aGUgcGNhOTU1NCBvbiBteSBib2FyZC4gQSBuYWl2
ZSBpbXBsZW1lbnRhdGlvbiB3b3VsZCANCmJlIHRvIGNvbmZpZ3VyZSBhbGwgdGhlIHBjYTk1NTEg
cGlucyBhcyBHUElPcyBhbmQgdXNlIHdoYXQgSSBoYXZlIGFzLWlzLiANCk1ha2luZyBhIGxpbmUg
ZGlzcGxheSBvdXQgb2YgTEVEIHRyaWdnZXJzIG1pZ2h0IGJlIGFub3RoZXIgd2F5IG9mIGRvaW5n
IA0KaXQgYnV0IG5vdCBzb21ldGhpbmcgSSByZWFsbHkgd2FudCB0byBwdXJzdWUuDQoNCj4NCj4g
R3JlZXRzDQo+IEFsZXgNCj4NCj4+IENocmlzIFBhY2toYW0gKDMpOg0KPj4gICAgYXV4ZGlzcGxh
eTogQWRkIDcgc2VnbWVudCBMRUQgZGlzcGxheSBkcml2ZXINCj4+ICAgIGR0LWJpbmRpbmdzOiBh
dXhkaXNwbGF5OiBBZGQgYmluZGluZ3MgZm9yIGdlbmVyaWMgNyBzZWdtZW50IExFRA0KPj4gICAg
QVJNOiBkdHM6IG1hcnZlbGw6IEFkZCA3IHNlZ21lbnQgTEVEIGRpc3BsYXkgb24geDUzMA0KPj4N
Cj4+ICAgLi4uL2F1eGRpc3BsYXkvZ2VuZXJpYyxncGlvLTdzZWcueWFtbCAgICAgICAgIHwgIDQw
ICsrKysrDQo+PiAgIC4uLi9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zODUtYXRsLXg1MzAuZHRz
ICB8ICAxMyArLQ0KPj4gICBkcml2ZXJzL2F1eGRpc3BsYXkvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgfCAgIDcgKw0KPj4gICBkcml2ZXJzL2F1eGRpc3BsYXkvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKw0KPj4gICBkcml2ZXJzL2F1eGRpc3BsYXkvc2VnLWxlZC5jICAgICAg
ICAgICAgICAgICAgfCAxNTIgKysrKysrKysrKysrKysrKysrDQo+PiAgIDUgZmlsZXMgY2hhbmdl
ZCwgMjEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hdXhkaXNwbGF5L2dlbmVyaWMs
Z3Bpby03c2VnLnlhbWwNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYXV4ZGlzcGxh
eS9zZWctbGVkLmMNCj4+DQo+PiAtLSANCj4+IDIuNDMuMg0KPj4NCj4+

