Return-Path: <linux-kernel+bounces-100799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A1879D69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601F6283C73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3E14372B;
	Tue, 12 Mar 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hhvx0OEE"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8177143736
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278713; cv=none; b=dS+T+bIYhQI16fTgZA6/06EbMSBMzxPoe+nil/dUKerj2q6a2bqH11vZCKoqOaplKWnIhSbymevAQKL3ARF4uhsEoiE2hU4QOR4c8lk09JFPHJlVa8LAXtkmcn7IGrFVtHk8qMKm5OhR2nXrp1DwMQIZy5O09Pywec/gTduO+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278713; c=relaxed/simple;
	bh=j+yEwyamaUCXJSLGv8ZZia2aKUXSvlfJ5JuGwVu7BDI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ok61IHtWSjfEFXyBYO+8gkhXte0gf4XvhUGou+Y0ARRplqKW5a0swM1wIZCz0lGlgFYP0iZCx2ktiN+05WE3VSdpMfSYH5VPeLWtFK9PClUt9C20yAkm9hWtfLJez1ClYH4NdJCka8ZnGZQvG/2OiCBIjoOhdsE89uJ3m6eInCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=hhvx0OEE; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 440E12C02A7;
	Wed, 13 Mar 2024 10:25:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710278708;
	bh=j+yEwyamaUCXJSLGv8ZZia2aKUXSvlfJ5JuGwVu7BDI=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=hhvx0OEEA11/O5EjlxdgjyEi7CYoYjellvmTzlgrx7ZsMgD7QAkV9vrf2whl3fQx8
	 B8xNWvcfJRLdmuN7HDxkOG8ofN8+kOoNHSxlcfrYkGLIWZE2wp3PpzI9M/WvisZFqk
	 A3fl5T/adjhYjWrPTZ8OtdEi4pLYVxo98JB1BcauH3TqPcMe3s6MraWEciLdKsVZkx
	 YhnvPO/bDTVDkE92M5hT5l4SZ8Sfu3d26wlqWbAJQyQGNHLi0HQ+ddoOtD9QoLyTxZ
	 BFkYNUVzF6/jE8JO5WKR4hBfpKJXu8ey011HB6eVHFPn2Bw8s8os16ZA9M8uLztkTe
	 6IUY8kL5tjiOg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65f0c8340000>; Wed, 13 Mar 2024 10:25:08 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 10:25:07 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 13 Mar 2024 10:25:07 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Adding an interrupt to a PCI device via an ACPI entry
Thread-Topic: Adding an interrupt to a PCI device via an ACPI entry
Thread-Index: AQHadLvTcmvpPwDP9EGYKm6sb+rMpLEzxByA
Date: Tue, 12 Mar 2024 21:25:07 +0000
Message-ID: <2e69f8b2-f4ee-4ffb-b60e-1ec56920c44e@alliedtelesis.co.nz>
References: <20b215fd-51bd-4450-a2ff-110e88d11e95@alliedtelesis.co.nz>
In-Reply-To: <20b215fd-51bd-4450-a2ff-110e88d11e95@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8F59A39C70C47428905179CA369E40B@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65f0c834 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=VwQbUJbxAAAA:8 a=B6gf8EdhjJN4HKKAV2IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hN4QJW1WrX8A:10 a=CYH-uuMP9ukA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxMy8wMy8yNCAwOToyOCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gSGkgQWxsLA0KPg0K
PiBJcyB0aGVyZSBhIHdheSB0byBhZGQgaW5mb3JtYXRpb24gYWJvdXQgYSBQQ0kgZGV2aWNlIHZp
YSBhbiBBQ1BJIA0KPiBlbnRyeT8gSSdtIHRyeWluZyB0byBkZWFsIHdpdGggYSBkZXZpY2UgdGhh
dCBoYXMgYW4gZXJyYXR1bSB3aGVyZSANCj4gcmVndWxhciBQQ0ktZSBNU0kgaW50ZXJydXB0cyBk
b24ndCB3b3JrLiBUaGUgd29ya2Fyb3VuZCBpcyB0byBjb25uZWN0IA0KPiBhIGRlZGljYXRlZCBJ
TlQgb3V0cHV0IGxpbmUgdG8gYW4gaW50ZXJydXB0IGlucHV0IG9uIHRoZSBib2FyZC4gVGhlIA0K
PiBoYXJkd2FyZSBkZXNpZ24gaGFzIGRvbmUgdGhpcyBidXQgSSdtIHRyeWluZyB0byBmaWd1cmUg
b3V0IGhvdyB0byBtYWtlIA0KPiB0aGF0IHdvcmsgd2l0aCBBQ1BJIGRlc2NyaWJpbmcgdGhlIGhh
cmR3YXJlLg0KPg0KPiBJIGtub3cgaW4gZGV2aWNldHJlZSBsYW5kIEkgY2FuIGRvIHRoaXMgd2l0
aCBzb21ldGhpbmcgbGlrZQ0KPg0KPiAmcGNpYyB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBteWRldmljZUAxLDAgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAicGNpMTIzNCw1Njc4IjsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwMDAwMDAwMCAw
IDAgMCAwPjsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbnRlcnJ1cHQtcGFyZW50ID0gPCZpbnRjPjsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVWRUxfTE9X
PjsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+IH07DQo+DQo+IEFuZCB0
aGVuIHdoZW4gbXkgZHJpdmVyIGlzIGJvdW5kIHRvIGRldmljZSB0aGUgdXN1YWwgaXJxIHJlc291
cmNlIA0KPiBzdHVmZiB3aWxsIGdpdmUgbWUgdGhlIHJpZ2h0IGludGVycnVwdCBsaW5lLg0KPg0K
PiBJcyB0aGVyZSBhIHdheSBvZiBleHByZXNzaW5nIHRoaXMga2luZCBvZiB0aGluZyBpbiBBQ1BJ
Pw0KDQpMb29raW5nIGF0IA0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3Qv
ZmlybXdhcmUtZ3VpZGUvYWNwaS9lbnVtZXJhdGlvbi5odG1sI3BjaS1oaWVyYXJjaHktcmVwcmVz
ZW50YXRpb24gDQpzZWVtcyBwcm9taXNpbmcuDQoNCg==

