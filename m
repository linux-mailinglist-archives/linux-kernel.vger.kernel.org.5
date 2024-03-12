Return-Path: <linux-kernel+bounces-100762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C1879CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD121C214C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A9142910;
	Tue, 12 Mar 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="yuGTwXmH"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637E1386AA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275308; cv=none; b=fDSvLtfw7id6dxOnoc6dcMFyXGIuo8luJmkrDWBZcPCrJp0Hk66f08ur4GMKOPd19u/LzbrLB88ogL8GB/Ly3XBLsZyNmrDhOP+2uH/rHI32gdXfHb4IFk8AoKdLDAOsOtNQD/unY/PNYMtE8HyEC/nN9g6/b3R5OIpacMdaHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275308; c=relaxed/simple;
	bh=ykT9yKbx0+VuRmF6O/tIDeQGMwBH6YZOwESq74481ek=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hsm306Ni6Bt5TrAd5v5778/bm2+Mwv2Dtyoud/w2myfRegz/xkZt1fiEOCzQRRJ4yhBVfcgZLOTLLUqOI+fF5adwyCQdzmQswdAk7XkZSEq3gTMJRYp4WrsfOqI8AELGUmJN5OwlhTI7okWZp1vj/jmzXo+IjSj6TTA4kvlA0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=yuGTwXmH; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2E2552C02AF;
	Wed, 13 Mar 2024 09:28:22 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710275302;
	bh=ykT9yKbx0+VuRmF6O/tIDeQGMwBH6YZOwESq74481ek=;
	h=From:To:Subject:Date:From;
	b=yuGTwXmHHhGCLSDYlW7JI3fpOMjpVb8xwpDcPYkmd2PajbhWSTNQVwmST8V/022nX
	 kSolwWHiuOf+gX2GAH7gYfVRRpdzO5NXCW/n9tvY2r+nuLkQBTKIMPZAxbBzTX95UC
	 0GOLqhaCy9nYhLkvxGyyJbV4iovRIg2wNA41radpudRJBU5yS0EldINgfn1W+oqUbr
	 D4ELok+cT5aApxNBaZQ7EqcBTZ682ofZVD/HzM8ln5vEI6N9vDgnjV8g+/csUXuubU
	 jKUXg47SHE19H68dcyQI9pSvopSdiplxez4GW7juctBCeJ4SyD1EfpU4E7ioT3oa2I
	 iBgWmiF4SJeag==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65f0bae60000>; Wed, 13 Mar 2024 09:28:22 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 09:28:21 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 13 Mar 2024 09:28:21 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Adding an interrupt to a PCI device via an ACPI entry
Thread-Topic: Adding an interrupt to a PCI device via an ACPI entry
Thread-Index: AQHadLvTcmvpPwDP9EGYKm6sb+rMpA==
Date: Tue, 12 Mar 2024 20:28:21 +0000
Message-ID: <20b215fd-51bd-4450-a2ff-110e88d11e95@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8F7A06CA1840047A1649D8E4A28B4DC@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65f0bae6 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=2t1nXh0JOdlP8bczTaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQWxsLA0KDQpJcyB0aGVyZSBhIHdheSB0byBhZGQgaW5mb3JtYXRpb24gYWJvdXQgYSBQQ0kg
ZGV2aWNlIHZpYSBhbiBBQ1BJIGVudHJ5PyANCkknbSB0cnlpbmcgdG8gZGVhbCB3aXRoIGEgZGV2
aWNlIHRoYXQgaGFzIGFuIGVycmF0dW0gd2hlcmUgcmVndWxhciBQQ0ktZSANCk1TSSBpbnRlcnJ1
cHRzIGRvbid0IHdvcmsuIFRoZSB3b3JrYXJvdW5kIGlzIHRvIGNvbm5lY3QgYSBkZWRpY2F0ZWQg
SU5UIA0Kb3V0cHV0IGxpbmUgdG8gYW4gaW50ZXJydXB0IGlucHV0IG9uIHRoZSBib2FyZC4gVGhl
IGhhcmR3YXJlIGRlc2lnbiBoYXMgDQpkb25lIHRoaXMgYnV0IEknbSB0cnlpbmcgdG8gZmlndXJl
IG91dCBob3cgdG8gbWFrZSB0aGF0IHdvcmsgd2l0aCBBQ1BJIA0KZGVzY3JpYmluZyB0aGUgaGFy
ZHdhcmUuDQoNCkkga25vdyBpbiBkZXZpY2V0cmVlIGxhbmQgSSBjYW4gZG8gdGhpcyB3aXRoIHNv
bWV0aGluZyBsaWtlDQoNCiZwY2ljIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bXlkZXZpY2VAMSwwIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAicGNpMTIzNCw1Njc4IjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDAwMDAwMDAwIDAgMCAwIDA+Ow0K
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0
LXBhcmVudCA9IDwmaW50Yz47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCn07DQoNCkFuZCB0aGVuIHdoZW4gbXkgZHJpdmVy
IGlzIGJvdW5kIHRvIGRldmljZSB0aGUgdXN1YWwgaXJxIHJlc291cmNlIHN0dWZmIA0Kd2lsbCBn
aXZlIG1lIHRoZSByaWdodCBpbnRlcnJ1cHQgbGluZS4NCg0KSXMgdGhlcmUgYSB3YXkgb2YgZXhw
cmVzc2luZyB0aGlzIGtpbmQgb2YgdGhpbmcgaW4gQUNQST8NCg0KVGhhbmtzLA0KQ2hyaXMNCg==

