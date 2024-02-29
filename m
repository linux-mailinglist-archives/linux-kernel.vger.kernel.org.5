Return-Path: <linux-kernel+bounces-87402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B886D3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407AEB24062
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45013F44E;
	Thu, 29 Feb 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Rpe+d1bi"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D813F01E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237487; cv=none; b=mTNpH1QywgGi5LPpIxYkYS0jrjtc98D1Wdzu4T7Kyn1lgbsmrZfh9cJSq8t5RB8P6bPRO5M2MyVUGWduBVmOqfLnf77pKhRuFpD8JIuWZGt+IVXlYJpmr5aKMx9A/ucEyvOx2KSj89mAAPZ2ugMELc/dR5F5fu5R6NjK+4N44bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237487; c=relaxed/simple;
	bh=6glfyAt7HD0QySJPKpEWjGAIV3jv8UfvEXwnk6/EZhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tP72jknOAG+KIO2EdFeI2302r7+MhSJ/BKqQd8D9EjDoaqw4soa2IbpCYaUYjQ7704Q90wmYmpEIMHSk38gxDZG7FqL4DALrh72x6Oo9VXhP46GAK0tpuPh2pobu6rXAH3o2zMaCJjjONUSvgrWyrrbgttGiseRvJ7xTSoYFLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Rpe+d1bi; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BEDC12C075F;
	Fri,  1 Mar 2024 09:11:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709237476;
	bh=6glfyAt7HD0QySJPKpEWjGAIV3jv8UfvEXwnk6/EZhc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Rpe+d1bi4mfpx3SWctRt3lo7VQ8MDGmpwC8vouP4AdSmuJW5VSBpSPM5emtrI/i0k
	 imPCg2GMpKoKtolSGdDONkqG6bi8wMtSapXmeEHT78qFVhjzWqlkAbrunpNLMvF30/
	 4UxINDCLCi2qCO8wLasFYUVjHNnUOxXTfHViljSlZdEGV0WMRd0ZUtq7AjWiSYYX93
	 mvWw8k+dz7XkCo+2xHaYxwkk5VNI/kHggoxVyl5RYlD/+J1JwSP9MeqEu5jlkEoQZn
	 vbgvAw29hxLNMO2DIED0ZW9JpLF0RtX4LihYKc8d595GCKiZwijTml/dr40qzF7dpp
	 diFDs9jTohnUg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e0e4e40001>; Fri, 01 Mar 2024 09:11:16 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 09:11:16 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Mar 2024 09:11:16 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 1 Mar 2024 09:11:16 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Conor Dooley <conor@kernel.org>
CC: "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "Zeynep
 Arslanbenzer" <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v8 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v8 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHaaRjAl7efaZl90kO9VhcwpC4GlbEezqKAgACMsYCAAWzPgIAAIqOA
Date: Thu, 29 Feb 2024 20:11:16 +0000
Message-ID: <b2ebc2a7-0347-40a0-8302-c84ba898fd16@alliedtelesis.co.nz>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
 <20240227010312.3305966-3-chris.packham@alliedtelesis.co.nz>
 <20240228-embark-rimmed-d81bab3d42b8@spud>
 <bd43a198-6287-40b2-be15-2734c5d2742d@alliedtelesis.co.nz>
 <20240229-skeletal-ultimatum-27cd91e8d8a8@spud>
In-Reply-To: <20240229-skeletal-ultimatum-27cd91e8d8a8@spud>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CD15E643CE2B44DBF275BC624BD8CA5@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e0e4e4 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=RvubkdDkdtG1ID0tNhQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxLzAzLzI0IDA3OjA3LCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIFdlZCwgRmViIDI4
LCAyMDI0IGF0IDA4OjIxOjM1UE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAy
OS8wMi8yNCAwMDo1OCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+IE9uIFR1ZSwgRmViIDI3LCAy
MDI0IGF0IDAyOjAzOjEwUE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4NCj4+Pj4g
ICAgICBpbnRlcnJ1cHRzOg0KPj4+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4+PiArICAgICAgQWxh
cm0xIGludGVycnVwdCBsaW5lIG9mIHRoZSBSVEMuIFNvbWUgb2YgdGhlIFJUQ3MgaGF2ZSB0d28g
aW50ZXJydXB0DQo+Pj4+ICsgICAgICBsaW5lcyBhbmQgYWxhcm0xIGludGVycnVwdCBtdXhpbmcg
ZGVwZW5kcyBvbiB0aGUgY2xvY2tpbi9jbG9ja291dA0KPj4+PiArICAgICAgY29uZmlndXJhdGlv
bi4NCj4+Pj4gICAgICAgIG1heEl0ZW1zOiAxDQo+Pj4gVGhlIG1heEl0ZW1zOiAxIGxvb2tzIG9k
ZCBoZXJlIHdoZW4geW91IHN0YXRlICJzb21lIG9mIHRoZSBSVENzIGhhdmUgdHdvDQo+Pj4gaW50
ZXJydXB0IGxpbmVzIiwgd2hpY2ggbWFrZXMgaXQgc291bmQgYXMgaWYgdGhlcmUgYXJlIGFjdHVh
bGx5IHR3bw0KPj4+IGludGVycnVwdHMgdGhhdCBzaG91bGQgYmUgZXhwb3NlZCBoZXJlLiBJZiB0
aG9zZSB0d28gaW50ZXJydXB0cyBnZXQNCj4+PiBtdXhlZCB0byB0aGUgc2FtZSBwaW4gZm9yIG91
dHB1dCBJJ2Qgc3VnZ2VzdCB0aGF0IHlvdSBjbGFyaWZ5IHRoYXQgaGVyZS4NCj4+IFRoaXMgbWF5
IGVuZCB1cCBjaGFuZ2luZyBpZiBJIGNhbiBjb21lIHVwIHdpdGggc29tZXRoaW5nIHRoYXQgQWxl
eGFuZHJlDQo+PiBpcyBoYXBweSB3aXRoLiBCYXNpY2FsbHkgKHNvbWUgb2YpIHRoZSBjaGlwcyBo
YXZlIGEgY29uZmlndXJhYmxlIHBpbg0KPj4gdGhhdCBjYW4gZWl0aGVyIGJlIGRlZGljYXRlZCB0
byB0aGUgQUxBUk0xIG91dHB1dCAoYW5ub3lpbmdseSBsYWJlbGxlZA0KPj4gYXMgSU5UQikgb3Ig
dG8gYSBjbG9jayBvdXRwdXQuIFRoZXJlIGlzIGFuIElOVEEgbGluZSB0aGF0IGhhcyBvdGhlcg0K
Pj4gaW50ZXJydXB0cyBhbmQgaWYgdGhlIGNsb2NrIG91dHB1dCBvcHRpb24gaXMgdXNlZCB0aGVu
IGl0IGFsc28gaGFzDQo+PiBBTEFSTTEuIFRoZSBkcml2ZXIgZG9lc24ndCBjdXJyZW50bHkgZG8g
YW55dGhpbmcgd2l0aCB0aGUgb3RoZXINCj4+IGludGVycnVwdCBzb3VyY2VzIHNvIGFzIHdyaXR0
ZW4gdGhpcyBuZWVkcyB0byBjb3JyZXNwb25kIHRvIHdoaWNoZXZlcg0KPj4gaW50ZXJydXB0IG91
dHB1dCBpcyBhc3NlcnRlZCBmb3IgQUxBUk0xLg0KPiBTbyB5b3UncmUgc2F5aW5nIHRoYXQgZGVw
ZW5kaW5nIG9uIHdoZXRoZXIgb3Igbm90IHRoZSBjbG9jayBvdXRwdXQgaXMNCj4gdXNlZCwgdGhl
cmUgY291bGQgYmUgdHdvIGludGVycnVwdHM/DQpDb3JyZWN0Lg0KPiBXaXRob3V0IGxvb2tpbmcg
ZnVydGhlciwgaXQgc291bmRzIGxpa2UgeW91IHNob3VsZCBiZSBzZXR0aW5nIG1heEl0ZW1zDQo+
IHRvIDEgaWYgI2Nsb2NrLWNlbGxzIGlzIHByZXNlbnQgYW5kIHRvIDIgaWYgaXQgaXMgbm90Lg0K
TXkgaWRlYSB3YXMgYW4gZXhwbGljaXQgcHJvcGVydHkgYWJvdXQgdGhlIGZ1bmN0aW9uIG9mIHRo
ZSBJTlRCL0NMS09VVCANCnBpbi4gVGhlIGN1cnJlbnQgY29kZSBkb2VzIHVzZSAjY2xvY2stY2Vs
bHMgYXMgYSBwcm94eSBmb3IgdGhpcyAoYW5kIA0KQWxleGFuZHJlIGhhcyBzb21lIGNvbmNlcm5z
IHdpdGggaG93IHRoaXMgaXMgaGFuZGxlZCkuDQo+ICAgVGhlbiBpZiB0aGVyZSBhcmUNCj4gdHdv
IGludGVycnVwdHMgcHJvdmlkZWQsIHRoZSBkcml2ZXIgaXMgZnJlZSB0byBjb25maWd1cmUgd2hh
dGV2ZXIgd2F5IGl0DQo+IHdhbnRzLiBJZiB0aGVyZSBhcmVuJ3QsIHNlbmQgZXZlcnl0aGluZyB0
byBJTlRBLg0KPg0KPiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQpSaWdodCBub3cgdGhlIG9u
bHkgaW50ZXJydXB0IHRoYXQgdGhlIFJUQyBjYXJlcyBhYm91dCBpcyBmb3IgQUxBUk0xIA0KKHdo
aWNoIG1vdmVzIGJldHdlZW4gSU5UQSBhbmQgSU5UQiBkZXBlbmRpbmcgb24gdGhlIGNsb2NrIGNv
bmZpZykuIFRoZXJlIA0KYXJlIG90aGVyIGhhcmR3YXJlIGV2ZW50cyBhbmQgYW4gQUxBUk0yIHRo
YXQgY2FuIGdlbmVyYXRlIGFuIGludGVycnVwdCANCmJ1dCB0aGVzZSBhcmUgaWdub3JlZC4gSSBk
b24ndCB0aGluayB0aGUgcnRjIGZyYW1ld29yayBzdXBwb3J0cyBtb3JlIA0KdGhhbiBvbmUgYWxh
cm0uDQoNCkJpbmRpbmcgd2lzZSBJIHRoaW5rIHRoaXMgc2hvdWxkIHRha2UgMSBvciAyIGludGVy
cnVwdHMuIEZvciBzaW1wbGljaXR5IA0KdGhlIGZpcnN0IGludGVycnVwdCBzaG91bGQgYWx3YXlz
IGNvcnJlc3BvbmQgdG8gQUxBUk0xICh3aGljaCBjb3VsZCBiZSANCklOVEIgb3IgSU5UQSBkZXBl
bmRpbmcgb24gdGhlIGhhcmR3YXJlIGRlc2lnbikuIFRoZSAybmQgaW50ZXJydXB0IChpZiANCnN1
cHBsaWVkKSB3b3VsZCBiZSBmb3IgdGhlIG90aGVyIGV2ZW50cyAod2hpY2ggd2UgZG9uJ3QgY3Vy
cmVudGx5IGRvIA0KYW55dGhpbmcgd2l0aCkuDQo=

