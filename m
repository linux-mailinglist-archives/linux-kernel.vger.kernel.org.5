Return-Path: <linux-kernel+bounces-73653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7E85C585
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92CB1F227DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FA137C41;
	Tue, 20 Feb 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="y7A1TlMQ"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91477656
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459657; cv=none; b=XvzV0DayB1FqV432BYTv1TXA4jbW93coCOuPA9hAYd8mYkNYXOVxvVID4mrVtYZN0mYK+sFx90NClb2a8AZ06LehMpgzL+zKKvlTZhrDzLNiG+qI5v7nYWYBU0vsDDKjJnnB2EbOcR8xfWgDFqw292W27BDX08rxqXAsCFpozqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459657; c=relaxed/simple;
	bh=5rCYzkQFVFIHAf9a7O0phsyRdMzbC6SiF2iVZeHA5bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DQK/XFVr/5CzYIOBrQt6glW3FjYdFa5r7F4fgZ9K7cyDAUuchYAHKHQbQJ09deb00fpuqNLyoqzuB409fakKh2ULXWuUhzTt8MVEgT22xkd11Eylil2GfAiBsqd04ljXWPkqHlr74mEE8x4SjW3QeHjI6qXyY+sA+QzVkPtd4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=y7A1TlMQ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8C4532C0220;
	Wed, 21 Feb 2024 09:07:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708459647;
	bh=5rCYzkQFVFIHAf9a7O0phsyRdMzbC6SiF2iVZeHA5bo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=y7A1TlMQPEsD8C+7VTDZm7HIBwpym8rB5VlkwrsJhGU3SIcyS17rLmpUuIhDJw44/
	 1Z8Pr7fhRh/1qahEzTem3RXPHsPeTUvt3Mg/PhznFBp8DpAh/lk9Bfdd761xqpfLLq
	 388Zd7/Ibvt74cUWWtbFqar/CwTf4kPbV/jxXoxbtvbDl0AoQatikP0Vke9wF7vKsA
	 3wSbjynms8Duk17f48Pyav5HI+DieTsWJUzMgXhCPdUaOU+5wced5KazfEwvljkE0X
	 dSFhCWnBF9ehWBrAJLn/p7K7GqEOgSSjrjCdHbJTJVrXY/10ENkzVebXaJwcD4pP5C
	 adDb7amMX/KRA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d5067f0001>; Wed, 21 Feb 2024 09:07:27 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 21 Feb 2024 09:07:27 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 21 Feb 2024 09:07:27 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>, "antoniu.miclaus@analog.com"
	<antoniu.miclaus@analog.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "Zeynep
 Arslanbenzer" <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v7 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v7 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHaY4GQvEfO48xYrkysKF0fEIRwDbESyOEAgAAHBgA=
Date: Tue, 20 Feb 2024 20:07:27 +0000
Message-ID: <08d0ac81-8e14-459d-a71e-34392d833371@alliedtelesis.co.nz>
References: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
 <20240219221827.3821415-2-chris.packham@alliedtelesis.co.nz>
 <9281dd01-d20e-4eed-96ae-6aa63c9eb678@roeck-us.net>
In-Reply-To: <9281dd01-d20e-4eed-96ae-6aa63c9eb678@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7FA6D8E21F0B14CB99E42D8EDAFF80C@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d5067f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=Y7msoDIFLYruvLPsntIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0

T24gMjEvMDIvMjQgMDg6NDIsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+IE9uIDIvMTkvMjQgMTQ6
MTgsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBGcm9tOiBJYnJhaGltIFRpbGtpIDxJYnJhaGlt
LlRpbGtpQGFuYWxvZy5jb20+DQo+Pg0KPj4gQWRkaW5nIHN1cHBvcnQgZm9yIEFuYWxvZyBEZXZp
Y2VzIE1BWDMxM1hYIHNlcmllcyBSVENzLg0KPj4NCj4NCj4gQWRkaW5nIC0+IEFkZA0KPg0KPiBU
aGUgc3ViamVjdCBzaG91bGQgcmVhbGx5IGJlIHNvbWV0aGluZyBsaWtlICJydGM6IG1heDMxMzM1
OiBBZGQgc3VwcG9ydA0KPiBmb3IgYWRkaXRpb25hbCBjaGlwcyIsIHdpdGggZGV0YWlscyBpbiB0
aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoNCkFjay4NCg0KPiBBbGwgdGhvc2UgKGluIG15IG9waW5p
b24gdW5uZWNlc3NhcnkpIGZ1bmN0aW9uLCBkYXRhIHN0cnVjdHVyZSwNCj4gYW5kIHZhcmlhYmxl
IHJlbmFtZXMgbWFrZXMgaXQgcmVhbGx5IGRpZmZpY3VsdCB0byByZXZpZXcgdGhlIGNvZGUuDQo+
IEkgZG9uJ3Qgc2VlIHRoZSBwb2ludCBvZiB0aGF0LCBzbyBwbGVhc2UgZG9uJ3QgZXhwZWN0IGFu
eSBmdXJ0aGVyDQo+IGZlZWRiYWNrIGFib3V0IHRoZSBod21vbiBjaGFuZ2VzIGZyb20gbWUuIA0K
DQpTb3JyeSBhYm91dCB0aGF0LiBJbiByZWFsaXR5IHdoYXQgaGFwcGVuZWQgaXMgdGhhdCBzb21l
b25lIHN0YXJ0ZWQgDQp0cnlpbmcgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSByYW5nZSB0aGVuIHRo
ZXkgbGVmdCBBbmFsb2cgRGV2aWNlcyB3aXRoIA0KdGhlIHBhdGNoIHN0aWxsIGluIGZsaWdodC4g
SW4gdGhlIG1lYW4gdGltZSBzb21lb25lIGVsc2UgZnJvbSBBRCBsYW5kZWQgDQphIGRyaXZlciBm
b3IgYSBzaW5nbGUgdmFyaWFudCAod2l0aCBubyBwdWJsaWMgZGF0YXNoZWV0KS4gSSdtIGxlZnQg
DQp0cnlpbmcgdG8gcGljayB1cCB0aGUgcGllY2VzLg0KDQpUaGlzIGlzIGVmZmVjdGl2ZWx5IHRo
ZSBvcmlnaW5hbCBtYXgzMTN4eCBzZXJpZXMgcGF0Y2ggd2l0aCB0aGUgbWF4MzEzMzUgDQpjaGFu
Z2VzIGluY29ycG9yYXRlZCBhcyBiZXN0IEkgY2FuLiBJIGNhbiBwcm9iYWJseSByZW5hbWUgbW9y
ZSB0aGluZ3Mgc28gDQp0aGVyZSBpcyBsZXNzIGRlbHRhIGFnYWluc3QgdGhlIG1heDMxMzM1IGRy
aXZlci4NCg0KPiBUaGFua3MsDQo+IEd1ZW50ZXINCj4=

