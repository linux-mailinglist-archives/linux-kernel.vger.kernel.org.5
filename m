Return-Path: <linux-kernel+bounces-84304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02D86A4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179ADB24993
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01581C3E;
	Wed, 28 Feb 2024 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UJfLddb0"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AECEDD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082697; cv=none; b=AxWgvF3n/mbr7M/NW/jUx7enzR7O7dPM9//bWkYXr9c/MKi7fTUBsW22RirrHZcp7NKeV82uot7ra0/vcj6vhTpP2KO0WXh/ssjH++8xoLdU8nQff5rllPkChFknf0/a3z7xsDpnsStXoLUmBdFkYNgsOLiqbAavQa/C+dOAdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082697; c=relaxed/simple;
	bh=IcRzNIfL75SA47x9dzDBtcF3lyp2M6OmXVZB7D3m9dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAOQl9tFfEaN9YvI8rUVRxHt+oiRK55Ie9PWg05tPDkR65iNM10PBLf3/Ie5WGBYjIhDhe6wDcXJK/HABBXX2ST1q0i3BQivITbM4ZgUxOe7SUiCksNWPNHvrjFZYW8ASrujzbPHhYxt0Y3DipRI7rVeZKL7YsAYK3HmabRfZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=UJfLddb0; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7DAF02C05BB;
	Wed, 28 Feb 2024 14:11:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709082688;
	bh=IcRzNIfL75SA47x9dzDBtcF3lyp2M6OmXVZB7D3m9dc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UJfLddb03bXbdcmUuCfhIUk73jt5iH9CV3YekUNnyySQVtc5OzrEhvc9MAR4bFeHq
	 1hqFh+aqupeaB7UyOcGgMyImXpOPaNkrzqjLqwGOVk2wIYmVKx61XWjIBsBeAZegx8
	 ebBqG1I8xmQL8feeHP913s/Mnje2TaR6vNDQqEoWL6cMF0VUA37FW8rSFfdPAJmk1g
	 xu5C54Wb2ktHp59wj0fdhp4Khjn6b67j72WGjBDYl6/o98raL7kSi16km9obrFhaXO
	 dmYxuCjckQCHapi6oBGfGTrnCB+9AGauA7WvqJgQgyiPFMLRIh6NirnJJoUfYqLFKI
	 AaJsM81XF8saA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65de8840000a>; Wed, 28 Feb 2024 14:11:28 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 14:11:28 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 28 Feb 2024 14:11:28 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 28 Feb 2024 14:11:27 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "andy@kernel.org" <andy@kernel.org>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>, "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "javierm@redhat.com"
	<javierm@redhat.com>, "robin@protonic.nl" <robin@protonic.nl>,
	"lee@kernel.org" <lee@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: marvell: Indicate USB activity on x530
Thread-Topic: [PATCH v2 4/4] ARM: dts: marvell: Indicate USB activity on x530
Thread-Index: AQHaacMbtvQKrwfF6E+AeUPYWRr7/7EeB2qAgAARPYA=
Date: Wed, 28 Feb 2024 01:11:27 +0000
Message-ID: <dec8e014-ebd4-46bb-a7e1-421a65008a38@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-5-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfGfwxh_VVa8N_rYb-MK9AsufqtLRXvquuJwBGnEqh+gw@mail.gmail.com>
In-Reply-To: <CAHp75VfGfwxh_VVa8N_rYb-MK9AsufqtLRXvquuJwBGnEqh+gw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4468C1D113BACB4EBDFC78153780225A@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65de8840 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=Oe2OvPflw9Sbgrn8BdcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOC8wMi8yNCAxMzowOSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUdWUsIEZl
YiAyNywgMjAyNCBhdCAxMToyMuKAr1BNIENocmlzIFBhY2toYW0NCj4gPGNocmlzLnBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+PiBVc2UgdGhlIGRvdCBvbiB0aGUgNyBzZWdt
ZW50IExFRCBibG9jayB0byBpbmRpY2F0ZSBVU0IgYWNjZXNzIG9uIHRoZQ0KPj4geDUzMC4NCj4g
Tm90IHN1cmUgaWYgaXQncyBhIGdvb2QgaWRlYS4gSSBoYXZlIHNvbWUgcGxhbnMgZm9yIHRoZSBj
b21wcmVzc2VkDQo+IGZvcm1hdCwgaS5lLiB1c2UgRFAgZm9yIGRvdHMgKG9yIGNvbXBhdGlibGUg
cGllY2VzKSBzbyB3ZSBtYXkgcHJpbnQgdXANCj4gdG8gZG91YmxlIGNoYXJhY3RlcnMgd2l0aCB0
aGF0IChlLmcuLCAnNi40LjUuMy4nIGFzIGEgc2luZ2xlIHN0cmluZyBvbg0KPiBhIDQtZGlnaXQg
ZGlzcGxheSkuDQo+DQo+IFRoYXQgc2FpZCwgSSB3b3VsZCBsaWtlIHRvIGRlZmVyIHRoaXMgZm9y
IGEgd2hpbGUuDQo+DQpJbiBvdXIgY2FzZSB0aGlzIGlzIGhvdyB3ZSd2ZSBtYXRjaGVkIHVwIG90
aGVyIGRldmljZXMgd2hpY2ggaGF2ZSBhIDMgDQpMRUQgdG93ZXIgZm9yICJwb3dlciIsICJmYXVs
dCIgYW5kICJ1c2IiIHdpdGggZGV2aWNlcyB3aGljaCBoYXZlIGEgDQo3LXNlZ21lbnQgTEVEIGlu
c3RlYWQuIEkganVzdCB3YW50ZWQgdG8gcmVmbGVjdCByZWFsaXR5IGluIHRoZSB1cHN0cmVhbSBk
dHMuDQoNCkl0IGFsc28gYW5zd2VycyB0aGUgcXVlc3Rpb24gIndoYXQgYWJvdXQgdGhlIERQIExF
RCI/DQo=

