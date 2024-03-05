Return-Path: <linux-kernel+bounces-93059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D396B872A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118A31C216B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BE38398;
	Tue,  5 Mar 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fhE1w9pA"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1A1B59F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678053; cv=none; b=Q7tIgul1DsTe9e/00gSgwm2gN2F2+L7FXfOQ72wQdUoOiFyCxLxLW5wjQdS6nSDOWVNoKtXB2HTkgLBFyBGjPd4mScAwzArMEbp0tusDvVzEz5zqhH1EVUgnUmC5RJrKgHojdELSDQMOoNFr+0vAzGBkJnxot77N+pDwsAwUlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678053; c=relaxed/simple;
	bh=yXAS8Q/M5wAQ6lxqSDHqQMrOhV+zIOXBJpBNizgBLDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9WO98yKfy5KGf402s6u2ZW3ibH1k0dZ4Z/ogD9y+Kqqz+K9ylTHw67krkDlb6CNxi/r2B4eILpIMpmsZjUWeuxWuhGMsLZxBkTzI5zJXVREj8EpHdfM0yMNM/7I2+nyp1eFQXZRVE+bEPBiX7AKyzpIeihBUeD5XmDgKZzzWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=fhE1w9pA; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EA6652C0276;
	Wed,  6 Mar 2024 11:34:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709678048;
	bh=yXAS8Q/M5wAQ6lxqSDHqQMrOhV+zIOXBJpBNizgBLDg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fhE1w9pAF3TyKkQsRT8EvIn4zuNBnUy2581dmYY+GkJDh51jBO/sqX1prrJ7m+4Tk
	 kYmXROAP0RB4OWourt0dr4MigvJJosoEvZkDc0eptGV/i6uzMfBbDcnDhjwTmOeX6L
	 24A36dF9A+0TazYYpVvY578dPoaJjmIU6QZGCPATYDowIKPX1VEYJufltU7HwVgv8W
	 f3nso39pteYFO/0ppbO1EqqMX+BOL/UsRz6FztbEArk6XvFEQiVGy9T9HfrSZ37nKh
	 dJou7+skbIzDFa+QPdRV+gAdSwt02lxxusKfpJXtTHTqVYF4xz/m+gfJWq2MVD6hvo
	 ZIlp2iB0sCSaQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e79de00001>; Wed, 06 Mar 2024 11:34:08 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 11:34:08 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 6 Mar 2024 11:34:08 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 6 Mar 2024 11:34:08 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>, "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>, "lee@kernel.org" <lee@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] auxdisplay: Add 7-segment LED display driver
Thread-Topic: [PATCH v4 1/3] auxdisplay: Add 7-segment LED display driver
Thread-Index: AQHabrFznVZS/yT500enBvo87SpkS7En9WKAgABuK4CAAH+bAA==
Date: Tue, 5 Mar 2024 22:34:08 +0000
Message-ID: <216eb75d-5384-4654-9e86-4a9856494ad0@alliedtelesis.co.nz>
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
 <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXF+12PHa5A7WeyPMfvsGcJN13WaPuCbTmJU52Huq=osA@mail.gmail.com>
 <Zecy1RsSfpmH-cvG@smile.fi.intel.com>
In-Reply-To: <Zecy1RsSfpmH-cvG@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE804F8F084BE94898AF72044BE51326@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e79de0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=901g5MnNMaPkYE6KZxUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA2LzAzLzI0IDAzOjU3LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIFR1ZSwgTWFy
IDA1LCAyMDI0IGF0IDA5OjIzOjA3QU0gKzAxMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToN
Cj4+IE9uIFR1ZSwgTWFyIDUsIDIwMjQgYXQgNDo1OeKAr0FNIENocmlzIFBhY2toYW0NCj4+IDxj
aHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPiAuLi4NCj4NCj4+PiAr
ICAgICAgIHByaXYtPnNlZ21lbnRfZ3Bpb3MgPSBkZXZtX2dwaW9kX2dldF9hcnJheShkZXYsICJz
ZWdtZW50IiwgR1BJT0RfT1VUX0xPVyk7DQo+Pj4gKyAgICAgICBpZiAoSVNfRVJSKHByaXYtPnNl
Z21lbnRfZ3Bpb3MpKQ0KPj4+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwcml2LT5z
ZWdtZW50X2dwaW9zKTsNCj4+IFRoaXMgbmVlZHMgc29tZSB2YWxpZGF0aW9uIG9mIHByaXYtPnNl
Z21lbnRfZ3Bpb3MtPm5kZXNjcywgZWxzZSB0aGUNCj4+IGNhbGwgdG8gZ3Bpb2Rfc2V0X2FycmF5
X3ZhbHVlX2NhbnNsZWVwKCkgaW4gc2VnX2xlZF91cGRhdGUoKSBtYXkNCj4+IHRyaWdnZXIgYW4g
b3V0LW9mLWJvdW5kcyBhY2Nlc3Mgb2YgdGhlIHZhbHVlcyBiaXRtYXAuDQo+IEFsdGVybmF0aXZl
bHkgd2UgY2FuIGNhbGwgZ3Bpb2RfY291bnQoKSBiZWZvcmVoYW5kIGFuZCBjaGVjayBpdHMgcmVz
dWx0Lg0KVW5sZXNzIHRoZXJlIGFyZSBhbnkgb2JqZWN0aW9ucyBJIHRoaW5rIEknbGwgZ28gd2l0
aCB0aGUgbmRlc2NzIGNoZWNrIGFzIA0KaXQnbGwgYmUgZWFzaWVyIHRvIHVwZGF0ZSB0byB0aGUg
c3Vibm9kZSBzdHlsZSBpbiB0aGUgZnV0dXJlLiBJdCBkb2VzIA0KbWVhbiB0aGVyZSB3aWxsIGJl
IHNvbWUgZXh0cmEgYWxsb2NhdGlvbnMvZnJlZXMgKGhhbmRsZWQgdmlhIHRoZSBkZXZtXyANCkFQ
SXMpIGluIHRoZSBlcnJvciBjYXNlLg==

