Return-Path: <linux-kernel+bounces-128754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA3895EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B791B23C82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B715E7F3;
	Tue,  2 Apr 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Avem7cbd"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579A15B567
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095093; cv=none; b=tPeRkESuayspHZ/bKg/waGyiQd2Mf39LrVKaO/MGdjKqzUf6YlQh9uFelR7aOssbODKOMvZH9Xg4EFjVBlnvCA0kFXRGiLyDLtRaCtW+PqUQow1WauwVnqQ2RvbLZOtlXCNXlVSacODGPld6kT45u745rQG+3aKMbqec22Fg5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095093; c=relaxed/simple;
	bh=ho8LS5e07cVTEdtNzsdbgJ/d8Ttv+hqIl6IuPR/i25Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WUOdeq6ZsWz6SZ8NKpbRrbq6NH87km20C/xA9TtL6DBDN6D6MaveD8dmasN+jOZMI5f9hzYhnQfXaK/vMgSZnBC6hZ1hjJPtBCSZk0c7Xv7mrFAJjgaqvVJ6MM1R+sw2X8nDFDQwKCmzJkOr5qxYpKc0h+yhE9msj7w6abXwGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Avem7cbd; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C476B2C03B0;
	Wed,  3 Apr 2024 10:58:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712095087;
	bh=ho8LS5e07cVTEdtNzsdbgJ/d8Ttv+hqIl6IuPR/i25Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Avem7cbdxSLBd862TEerRE7JHcvdc4UhTAN5+/4XI8GbM8fyDSvQN9BaPT/gNIAP4
	 ibYSEu3cKRyF7bT5XBskaFhjMYmvxS7DMI0yUVq0YHRP4CwGiG4GVEj6d5V60fDpFC
	 PSxJVhdrbnG7yB2QpB8Go6aVi/XJhTNzA501paSZ6LaGcwVrLBT3QSlRZJFUpBh50v
	 F3n03ighhx6gKBejhdsdgZEaAxbBVea/8IBch0BZR4dvkw28fsToQsXHwb9cJz1JIg
	 QrHXeo2n9iZEA3LXAMjRfx7aPT2pawpcg6p6cHjtc+p9PAUhnf87+fPbjm2daS9XMf
	 pquGPWUNJgrjQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B660c7f6f0003>; Wed, 03 Apr 2024 10:58:07 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Apr 2024 10:57:44 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 3 Apr 2024 10:57:44 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: hwmon: label vs temp%d_label
Thread-Topic: hwmon: label vs temp%d_label
Thread-Index: AQHahTvINn4/LiD+qEqZV7u6Rj72trFUnPeAgAAGZwCAAAnRAA==
Date: Tue, 2 Apr 2024 21:57:44 +0000
Message-ID: <9f58389e-0eb6-4ff1-9152-aa38dbfc5f8b@alliedtelesis.co.nz>
References: <9a09bf46-d097-4e5b-bdb3-cc9dc6f5d01c@alliedtelesis.co.nz>
 <fdd952dd-2f3c-4f66-8e73-68f1dadde237@roeck-us.net>
 <448b5cfb-b433-4b38-98ae-066bda44f1fd@alliedtelesis.co.nz>
In-Reply-To: <448b5cfb-b433-4b38-98ae-066bda44f1fd@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E4797FE8919541839B36BC94601FB7@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=AuZN3/9P c=1 sm=1 tr=0 ts=660c7f6f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=X1bIBW7fO_EA:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=qt3E4JZEwYn9eQaJMkwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAzLzA0LzI0IDEwOjIyLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPg0KPiBPbiAzLzA0LzI0
IDA5OjU5LCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPj4gT24gVHVlLCBBcHIgMDIsIDIwMjQgYXQg
MDg6MjQ6MzdQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+PiBIaSBHdWVudGVyLCBK
ZWFuLA0KPj4+DQo+Pj4gSSd2ZSBnb3QgYSByZXF1aXJlbWVudCB0byBhZGQgc29tZSBtZWFuaW5n
ZnVsIG5hbWVzIHRvIHNvbWUgaHdtb24NCj4+PiBzZW5zb3JzIChMTTc1IHNwZWNpZmljYWxseSkg
c28gdGhhdCB3ZSBjYW4gcHJvdmlkZSBzb21lIGluZGljYXRpb24gb2YNCj4+PiB3aGVyZSBvbiBh
IGJvYXJkIHRoZSBzZW5zb3IgaXMgbG9jYXRlZCAoZS5nLiAiSW50YWtlIiB2cyAiRXhoYXVzdCIg
dnMNCj4+PiAiTmVhciB0aGF0IHJlYWxseSBob3QgY2hpcCIpLg0KPj4+DQo+Pj4gSSBzZWUgdGhh
dCB0aGUgc3lzZnMgQUJJIGRvY3VtZW50cyBib3RoICJsYWJlbCIgZm9yIHRoZSBjaGlwIGFuZA0K
Pj4+ICJ0ZW1wWzEtKl1fbGFiZWwiIChhcyB3ZWxsIGFzIHNpbWlsYXIgZmFuIGFuZCBWaW4gYXR0
cmlidXRlcykuIFRoZQ0KPj4+IGxhdHRlciBzZWVtIHRvIGJlIHN1cHBvcnRlZCBieSB0aGUgaHdt
b24gY29yZSBidXQgSSBkb24ndCBzZWUgYW55dGhpbmcNCj4+PiBmb3IgdGhlIGZvcm1lciAoSSdt
IHN0cnVnZ2xpbmcgdG8gZmluZCBhbnkgZHJpdmVyIHRoYXQgc3VwcG9ydHMgYQ0KPj4+IGNoaXAt
d2lkZSBsYWJlbCkuDQo+Pj4NCj4+PiBBc3N1bWluZyBJIHdhbnQgdG8gaGF2ZSBhIGxhYmVsIGFk
ZGVkIGluIHRoZSBkZXZpY2UgdHJlZSB0byBhIGxtNzUgDQo+Pj4gd291bGQNCj4+PiBzb21ldGhp
bmcgbGlrZSB0aGUgZm9sbG93aW5nIGJlIGFjY2VwdGFibGUNCj4+Pg0KPj4+IMKgIMKgwqDCoMKg
wqAgc2Vuc29yQDQ4IHsNCj4+PiDCoCDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm5hdGlv
bmFsLGxtNzUiOw0KPj4+IMKgIMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDQ4PjsNCj4+PiDCoCDC
oMKgwqDCoMKgwqDCoCBsYWJlbCA9ICJJbnRha2UiOw0KPj4+IMKgIMKgwqDCoMKgwqAgfTsNCj4+
Pg0KPj4+IEknZCB0aGVuIHVwZGF0ZSB0aGUgbG03NSBkcml2ZXIgdG8gZ3JhYiB0aGF0IGZyb20g
dGhlIGRldmljZXRyZWUgYW5kIA0KPj4+IHVzZQ0KPj4+IGl0IHRvIHByb3ZpZGUgdGhlIGh3bW9u
X3RlbXBfbGFiZWwgYXR0cmlidXRlLg0KPj4+DQo+PiBIYXZlIHlvdSB0cmllZCBqdXN0IGRlY2xh
cmluZyB0aGUgbGFiZWwgcHJvcGVydHkgYXMgeW91IHN1Z2dlc3RlZCBhYm92ZQ0KPj4gaW4geW91
ciBzeXN0ZW0gd2l0aG91dCBkb2luZyBhbnl0aGluZyBlbHNlLCBhbmQgbG9va2VkIGF0IHRoZSBn
ZW5lcmF0ZWQNCj4+IHN5c2ZzIGF0dHJpYnV0ZXMgPw0KPg0KPiBJIGhhdmUgbm90LiBCdXQgaW4g
bXkgZGVmZW5zZSBJJ20gYWxzbyB1c2luZyBhbiBvbGRlciBrZXJuZWwgTFRTIHRoYXQgDQo+IGRv
ZXNuJ3QgaGF2ZSBjb21taXQgZTFjOWQ2ZDYxZGRmICgiaHdtb246IEFkZCAibGFiZWwiIGF0dHJp
YnV0ZSIpLiBCdXQgDQo+IG5vdyB0aGF0IEkga25vdyBpdCBleGlzdHMgSSBjYW4gY2FycnkgaXQg
YXMgYSBsb2NhbCBwYXRjaCB1bnRpbCB3ZSANCj4gbmV4dCB1cGRhdGUuDQoNClJlbGF0ZWQgaXMg
dGhlcmUgYW4gbG0tc2Vuc29ycyBjaGFuZ2UgdGhhdCB1c2VzIHRoaXMgYXR0cmlidXRlIGZvciAN
CmRpc3BsYXkgcHVycG9zZXM/DQoNCkkgZG8gaGF2ZSBhIGNvdXBsZSBvZiBQUnMgb3BlbiBvbiB0
aGUgbG0tc2Vuc29ycyBnaXRodWIgcHJvamVjdCBJJ2QgbGlrZSANCnRvIHNlZSBtZXJnZWQgYnV0
IGdpdmVuIHJlY2VudCBldmVudHMgdGhpcyBzaG91bGQgYWJzb2x1dGVseSBub3QgYmUgDQpjb25z
dHJ1ZWQgYXMgYSBjcml0aWNpc20gb2YgYW55b25lIG1haW50YWluaW5nIGxtLXNlbnNvcnMgbWVy
ZWx5IGEgcXVlcnkgDQphcyB0byB3aGV0aGVyIFBScyBhcmUgdGhlIHJpZ2h0IHBhdGggZm9yIGNo
YW5nZXMgb3IgaWYgdGhleSBzaG91bGQgYmUgDQpzZW50IHRvIGEgbWFpbGluZyBsaXN0IHNvbWV3
aGVyZS4NCg0K

