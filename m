Return-Path: <linux-kernel+bounces-82487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D986853B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940B5B21827
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9593441F;
	Tue, 27 Feb 2024 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="l+5WlXwQ"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE704184D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995161; cv=none; b=jItYi+d6ZrXFCQYywkr+QQ2I5hSjL8ZHACErjEUJseJ6nIFKvDoqzWf0dnbVbCayfZJmGjXQWB3uYNmxE3fHs9E1+Jva8xh2tQav0+liV57ahtvGQl5hJIHskmeBaZfE/PROBvod68CZLgnyAnQUwfKAng3Ql4W0Cqi/J1uXoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995161; c=relaxed/simple;
	bh=xqvZPX41mc0xu6d3eepwLQoId1v2MVWMK9mSHF/PNeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n42xOOBCh8o/dd7ZUBgHvTLf/MFA2GGMVo2A5wYl5XUbxxDe4KtSgXw5yCg0IdiwMKaX/m/x5lTp+C7wWIPRbRlJHL/vyPJyqnVum62tT9dkZ3WOhaD23DNQjOmpht/bo7aO7YrsCwSl6cfUjw0a/mM1ZbSkWf3FCNOXdWHkdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=l+5WlXwQ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D3B1A2C0546;
	Tue, 27 Feb 2024 13:52:30 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708995150;
	bh=xqvZPX41mc0xu6d3eepwLQoId1v2MVWMK9mSHF/PNeA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=l+5WlXwQ4EHSZCmxyRoXvfZS6bllBcSy338/QHedSExwU8RAcTqmC63qGr7AONOxl
	 tEGdphs1wUXq6/zVjFlv/8/2wnyApibYNlU8l4CleBwKlvTh6a9yuFoPuKlPKyYabk
	 8Zp0IWu37nMCk7ey8ed3W7JU9qjO2SWOKGc5mDPJU7/h7xQKvw5bfFSVkEGpvlZigM
	 PLBWhUV9BSlnEIFn/sLWn8PcK0K/cYok6Oyk/4yNTAkspFcoDJ2M+dgrYca6+gTwb9
	 vTnFHYnsYHJbmPK72L+35tf5SkWUOLywc/Sa4zMH6T546UlAR79HshOd966GA85LuK
	 aQOnWO8N904Lg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dd324e0001>; Tue, 27 Feb 2024 13:52:30 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 13:52:30 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Tue, 27 Feb 2024 13:52:30 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 27 Feb 2024 13:52:30 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "ojeda@kernel.org" <ojeda@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"lee@kernel.org" <lee@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
Thread-Topic: [PATCH 0/3] auxdisplay: 7 segment LED display
Thread-Index: AQHaaDJtdshPwhTk10iKhi7EmCZrNrEbCy6AgAF4+YA=
Date: Tue, 27 Feb 2024 00:52:30 +0000
Message-ID: <584172eb-4eda-40d1-9ee5-99d0ef944481@alliedtelesis.co.nz>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc9OBtxdKSmk9Uu9G3j+mfN8+9prTEVx3LyUcdBYFEqwg@mail.gmail.com>
In-Reply-To: <CAHp75Vc9OBtxdKSmk9Uu9G3j+mfN8+9prTEVx3LyUcdBYFEqwg@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D07B55D1697EBB48B5F19332387FD09F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dd324e a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=62ntRvTiAAAA:8 a=VwQbUJbxAAAA:8 a=ur-VQpc8FRseSrnZ0GYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNi8wMi8yNCAxNToyMywgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBTdW4sIEZl
YiAyNSwgMjAyNCBhdCAxMTozNOKAr1BNIENocmlzIFBhY2toYW0NCj4gPGNocmlzLnBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+PiBUaGlzIHNlcmllcyBhZGRzIGEgZHJpdmVy
IGZvciBhIDcgc2VnbWVudCBMRUQgZGlzcGxheS4NCj4+DQo+PiBJJ2QgbGlrZSB0byBnZXQgc29t
ZSBmZWVkYmFjayBvbiBob3cgdGhpcyBjb3VsZCBiZSBleHRlbmRlZCB0byBzdXBwb3J0ID4xDQo+
PiBjaGFyYWN0ZXIuIFRoZSBkcml2ZXIgYXMgcHJlc2VudGVkIGlzIHN1ZmZpY2llbnQgZm9yIG15
IGhhcmR3YXJlIHdoaWNoIG9ubHkgaGFzDQo+PiBhIHNpbmdsZSBjaGFyYWN0ZXIgZGlzcGxheSBi
dXQgSSBjYW4gc2VlIHRoYXQgZm9yIHRoaXMgdG8gYmUgZ2VuZXJpY2FsbHkgdXNlZnVsDQo+PiBz
dXBwb3J0aW5nIG1vcmUgY2hhcmFjdGVycyB3b3VsZCBiZSBkZXNpcmVhYmxlLg0KPj4NCj4+IEVh
cmxpZXIgSSBwb3N0ZWQgYW4gaWRlYSB0aGF0IHRoZSBjaGFyYWN0ZXJzIGNvdWxkIGJlIHJlcHJl
c2VuZGVkIGJ5DQo+PiBzdWItbm9kZXNbMV0gYnV0IHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBh
IHdheSBvZiBoYXZpbmcgdGhhdCBhbmQga2VlcGluZyB0aGUNCj4+IGNvbnZlbmllbmNlIG9mIHVz
aW5nIGRldm1fZ3Bpb2RfZ2V0X2FycmF5KCkgKHVubGVzcyBJJ3ZlIG1pc3NlZCBzb21ldGhpbmcp
Lg0KPiBJdCBzZWVtcyB5b3UgZGlkbid0IGtub3cgdGhhdCB0aGUgdHJlZSBmb3IgYXV4ZGlzcGxh
eSBoYXMgYmVlbiBjaGFuZ2VkLg0KPiBDYW4geW91IHJlYmFzZSB5b3VyIHN0dWZmIG9uIHRvcCBv
Zg0KPiBodHRwczovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD12ZmJiNWZuVTU5
a3ZJUkVmZEQtMjFQYWIzMGJwTXB1VE0ySXB2Mjhub3cmdT1odHRwcyUzYSUyZiUyZmdpdCUyZWtl
cm5lbCUyZW9yZyUyZnB1YiUyZnNjbSUyZmxpbnV4JTJma2VybmVsJTJmZ2l0JTJmYW5keSUyZmxp
bnV4LWF1eGRpc3BsYXklMmVnaXQlMmZsb2clMmYlM2ZoJTNkZm9yLW5leHQlM2YNCj4gSXQgd2ls
bCByZWR1Y2UgeW91ciBjb2RlIGJhc2UgYnkgfjUwJS4NCj4NCj4gV1JUIHN1Ym5vZGVzLCB5b3Ug
Y2FuIGdvIHdpdGggZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25vZGUoKSBhbmQNCj4gcmV0cmlldmUg
Z3BpbyBhcnJheSBwZXIgZGlnaXQuIEl0IG1lYW5zIHlvdSB3aWxsIGhhdmUgYW4gYXJyYXkgb2YN
Cj4gYXJyYXlzIG9mIEdQSU9zLg0KDQpTbyB3b3VsZCB0aGUgZm9sbG93aW5nIHdvcms/DQoNCiDC
oMKgwqAgY291bnQgPSBkZXZpY2VfZ2V0X2NoaWxkX25vZGVfY291bnQoZGV2KTsNCiDCoMKgwqAg
c3RydWN0IGdwaW9fZGVzY3MgKipjaGFyc8KgID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpj
aGFycykgKiANCmNvdW50LCBHRlBfS0VSTkVMKTsNCg0KIMKgwqDCoCBpID0gMDsNCiDCoMKgwqAg
ZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25vZGUoZGV2LCBjaGlsZCkgew0KIMKgwqDCoCDCoMKgwqAg
Y2hhcnNbaV0gPSBkZXZtX2dwaW9kX2dldF9hcnJheShkZXYsICJzZWdtZW50IiwgR1BJT0RfT1VU
X0xPVyk7DQogwqDCoMKgIH0NCg0KSSBoYXZlbid0IHVzZWQgdGhlIGNoaWxkLiBUaGUgZGV2bV9n
cGlvZF9nZXRfYXJyYXkoKSB3aWxsIGJlIGxvb2tpbmcgYXQgDQp0aGUgZndub2RlIG9mIHRoZSBw
YXJlbnQuDQoNCg==

