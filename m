Return-Path: <linux-kernel+bounces-84271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F586A467
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A63E1F2C2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273E4A1A;
	Wed, 28 Feb 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="U6ft25rg"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC01865
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079935; cv=none; b=KpG2uZvotnDMXsD/tQ73q8gnzeaxzETSKE4/xeBqaMjsuczyzzotyfGDk24BIgvRFzUqWMgKCkHygctGx6oN0WHd02/Lvrrfyzych9PJvgs5fTzCDtUmBmuIsRbdipyKoMQ6vZXM8dZpu6DHyLyOf3I0jZ/Ip1Vqjk/1w4/3s9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079935; c=relaxed/simple;
	bh=XP6dv8iCnebWOSoWMLEi6vykQWmtPg9ncav7VG34hnk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btO/tWcj3MLUZdjWzCo9kX/ZORpOyRnONLkCCW02jhDH0rvrHd9jquNryCcnd6jgDOUdJ7+mCUg+JhDJB43l62P89PZ8J3dlOe1VEH9n4736xvlPqWtl4o3dvmXWdwxxts9z1/FaIN3k1OWS7HP8CfvGr2Vg2B5WB4e7V5sDIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=U6ft25rg; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C6A552C02AB;
	Wed, 28 Feb 2024 13:25:30 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709079930;
	bh=XP6dv8iCnebWOSoWMLEi6vykQWmtPg9ncav7VG34hnk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=U6ft25rgT7e3qRBoHG5yMaCfzpTiX3wfDLceMyjSg0rddwnN7r7s8c73VA+iwNw86
	 sHi+aS7J7FuTcmUP79+G7leQzFsnyMa1BMX/r8Ac8566gfx1S4mdj+flld1ptMiYFg
	 QWcWXXVn1qZbJUIRjeY9F6xm4G8s0wbZbsnnUMjUj/MHYxFuBASSADNQuDEv7p2cs+
	 ASN+q77J6TIc/RT9XmRLXww042YU75wEKTpgh1Bz6MmI6ph9nXeijn8W9rgnDzR7h7
	 y6hPKo0gd2xUH5MtFsSYCbGWC8gvfwOErIzqKCyKbID/RDZsTDJxcfCCR5PyJOqxrt
	 wvS5QYRFKffVg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65de7d7a0001>; Wed, 28 Feb 2024 13:25:30 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 13:25:30 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 28 Feb 2024 13:25:30 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 28 Feb 2024 13:25:30 +1300
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
Subject: Re: [PATCH v2 0/4] auxdisplay: 7 segment LED display
Thread-Topic: [PATCH v2 0/4] auxdisplay: 7 segment LED display
Thread-Index: AQHaacMcK15M5ExM7Eu6ISEctSZ1pbEeBi2AgAAFooA=
Date: Wed, 28 Feb 2024 00:25:30 +0000
Message-ID: <2ad735ed-963c-4e75-b83e-687ea2c0aef5@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc7yFX6TLhc0ADx+76_+2Li=WgQiSqpcwkFSpP3pPdC5Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc7yFX6TLhc0ADx+76_+2Li=WgQiSqpcwkFSpP3pPdC5Q@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9A95B9DD2D338448DC9573927C807FE@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65de7d7a a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=hz1frt1X8FHgNVay5PQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOC8wMi8yNCAxMzowNSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUdWUsIEZl
YiAyNywgMjAyNCBhdCAxMToyMuKAr1BNIENocmlzIFBhY2toYW0NCj4gPGNocmlzLnBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+PiBUaGlzIHNlcmllcyBhZGRzIGEgZHJpdmVy
IGZvciBhIDcgc2VnbWVudCBMRUQgZGlzcGxheS4NCj4+DQo+PiBBdCB0aGlzIHBvaW50IEkndmUg
ZGVjaWRlZCBub3QgdG8gcHVyc3VlIHN1cHBvcnRpbmcgPjEgY2hhcmFjdGVyLiBJIGhhZA0KPj4g
YSBsb29rIGF0IHdoYXQgd291bGQgYmUgcmVxdWlyZWQgdG8gYWRkIGEgZGV2bV9md25vZGVfZ3Bp
b2RfZ2V0X2FycmF5KCkNCj4+IGFuZCBnb3QgYm9nZ2VkIGRvd24gaW4gT0YgYW5kIEFDUEkgY29k
ZSBmb3IgY291bnRpbmcgR1BJT3MuDQo+IE91dCBvZiBjdXJpb3NpdHksIHdoeSBkaWQgaXQgaGFw
cGVuPyBncGlvZF9jb3VudCgpIHdvcmtzIGluIGFuIGFnbm9zdGljIHdheS4NCj4NCkF0IGZpcnN0
IEkgdGhvdWdoIEkgY291bGQgY3JlYXRlIGEgZndub2RlX2dwaW9kX2NvdW50KCkgb3V0IG9mIHRo
ZSBib2R5IA0Kb2YgZ3Bpb2RfY291bnQoKS4gQnV0IGJvdGggb2ZfZ3Bpb19nZXRfY291bnQoKSBh
bmQgYWNwaV9ncGlvX2NvdW50KCkgDQp0YWtlIHRoZSBkZXYgbm90IHRoZSBmd25vZGUuIEl0IGxv
b2tzIGxpa2UgZ3Bpb2RfY291bnQoKSAoYW5kIA0Kb2ZfZ3Bpb19zcGlfY3NfZ2V0X2NvdW50KCkp
IGNvdWxkIHByb2JhYmx5IGJlIHJlLXdyaXR0ZW4gKG9yIGFic3RyYWN0ZWQpIA0KdG8gdGFrZSB0
aGUgZGV2aWNlX25vZGUgaW5zdGVhZCBvZiB0aGUgZGV2aWNlLiBJIHN0YXJ0ZWQgbG9va2luZyBh
dCANCmFjcGlfZ3Bpb19jb3VudCgpIGJ1dCBJIGNvdWxkbid0IHF1aXRlIHNlZSBob3cgSSBjb3Vs
ZCBhZGFwdCB0aGlzLg0KDQpJJ20gZGVmaW5pdGVseSBub3Qgc2F5aW5nIGl0IGNhbid0IGJlIGRv
bmUuIEp1c3QgdGhhdCB5b3UgcHJvYmFibHkgZG9uJ3QgDQp3YW50IGFuIG9jY2FzaW9uYWwgY29u
dHJpYnV0b3IgbGlrZSBtZSBtZXNzaW5nIHdpdGggc29tZSBvZiB0aGVzZSBjb3JlIA0KZGV2aWNl
IGFic3RyYWN0aW9ucy4NCg==

