Return-Path: <linux-kernel+bounces-89953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA886F80A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302D81F20F06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481C17CE;
	Mon,  4 Mar 2024 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="paoEu9G1"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AC10F9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709513198; cv=none; b=FZA1XMpiABtK/so9554gPr3NmKGEKdmVSfeSMCv+JCJRCLC6Oit+f3MqDBacFbZthx7+HXSydmGeM7xL3asWKG21ioPSsakvr0GDMSFpvSIwytj2llor4hhxQhc2fTA2xJsb0C2tJLrG+IFbYgkPb3tlWuQYu+ZPpFh96kEgDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709513198; c=relaxed/simple;
	bh=whz8SZ4zzvdwOynQK667F9QpilEJ3sKMMjLkQpNy+ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsU54UyP1gODygM0NAz7IDMmju5f4vEtMrRQynXhWo0T9f8uwTo/mvaoyrqtjxes+PiLjbYVgv6GqmF4QQQgKz6iixUJCmBmPQnOXXC0hqT2qFQW+oN+BilMi0kbBLf0TaY7gtGEDFqCIvYKCZsyD6HRp6FzHi6SjBj3IQQqktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=paoEu9G1; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7DA202C061F;
	Mon,  4 Mar 2024 13:46:34 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709513194;
	bh=whz8SZ4zzvdwOynQK667F9QpilEJ3sKMMjLkQpNy+ns=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=paoEu9G1fMJVqDQFB66R6koOOVmXyHgGs1UjfCvY7qLXR5f2gVsPmn3uiI9e+3fVO
	 dT9z7LlEn766/TToAsQXN8lRbRfKN4j72loyIB/dBoF8dyHJwn5lJ0nkUKNo8Z9Jso
	 Zf448hMwjoVtdG2Kmz61NuyEB8UIv//WPmgLdNer5oLL6R2Uc8RFMENBcCnJpieSLJ
	 PCpEc0oFdzVZ4gVg62+Zmomj8PheI0babjHWOtPFSCLTspvkvzmBLtkYeHvxYpWa71
	 1vYO//nNRgooIM5EPCm+XRkvzn392hxDoY27G3S5B9m5KSLuJJbV3obDXT1s1M+ViN
	 NixkmfFltYhrg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e519ea0001>; Mon, 04 Mar 2024 13:46:34 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 13:46:34 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 4 Mar 2024 13:46:34 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy@kernel.org>
CC: "geert@linux-m68k.org" <geert@linux-m68k.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Thread-Topic: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Thread-Index: AQHaa3mtvfhJncEIXkulWlzHVNRh9LEiWOCAgAOQswCAAABbAA==
Date: Mon, 4 Mar 2024 00:46:34 +0000
Message-ID: <bf8e8c0b-76df-4e8d-8d8f-c4f1ee86c7d4@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
 <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
 <bee159a7-b125-4773-b6b2-867e02f11345@alliedtelesis.co.nz>
In-Reply-To: <bee159a7-b125-4773-b6b2-867e02f11345@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <46957656C503DD40B97E08C4C3700271@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e519ea a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=0L3zpohAsciqlFzk0AIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA0LzAzLzI0IDEzOjQ1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPg0KPiBPbiAyLzAzLzI0
IDA3OjE4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+PiBJIHdvdWxkIGRyb3AgdGhpcyBhcyBp
dCdzIGF2YWlsYWJsZSBpbiBVQVBJIGhlYWRlci4uLg0KPj4NCj4+IC4uLg0KPj4NCj4+PiArI2lu
Y2x1ZGUgPGxpbnV4L2JpdG1hcC5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgvY29udGFpbmVyX29m
Lmg+DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgv
Z3Bpby9jb25zdW1lci5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+
DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4+PiArI2lu
Y2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KPj4gLi4ud2hpY2ggeW91IGZvcmdvdCB0byBpbmNs
dWRlIGhlcmUuDQo+Pg0KPj4gLi4uDQo+IEFjdHVhbGx5IGRvIEkgbmVlZCB0bz8gSSdtIG5vdCB1
c2luZyBhbnl0aGluZyBpbiBtYXBfdG9fN3NlZ21lbnQuaCwgDQo+IHRoYXQncyBhbGwgdGFrZW4g
Y2FyZSBvZiBpbiB0aGUgbGluZS1kaXNwbGF5IGNvZGUuDQoNCk9vcHMgbm8gSSBzdGlsbCBuZWVk
IGl0IGZvciBtYXBfdG9fc2VnNygpLg0K

