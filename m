Return-Path: <linux-kernel+bounces-55589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476A84BE96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8401F28D71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2717BA6;
	Tue,  6 Feb 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="GoqGQ/17"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAD1B7EE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250880; cv=none; b=UYtub5cZ7yES8C2iUgmLHiZixBDzf1pvKCvW48Mhk+T/8mghsldU3N2TeHBvY+n1yXhxMHd7JuL4MRzU5ZofLeFRSjN0o6DyGFUn3RRqEBBgJKyVZMCXzXBRLSq2zvpGDg4C+5NgdcMCefoi37onPs85bGUBHMWC9NIeb90DIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250880; c=relaxed/simple;
	bh=XcVg65BGIZYZoHoeF+lv8Ujc+NbICo71nt7G5QDW0ck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahp+CsYCBM400wZguYDF0HksCrwnhcV+7wRnUI5pW1CJenVtDZG+cCGGgR86GbYO+iixWmFAv5SjrlDzf7NkhixufC16Kuv3Ho4Cvb6toWeDfig8hbuZVnef+TQYvx9FPedfM9vN4lrG1snjeLoWPVUyaaHmqbNqCC4Nhwnp/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=GoqGQ/17; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6A3122C03C7;
	Wed,  7 Feb 2024 09:21:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1707250875;
	bh=XcVg65BGIZYZoHoeF+lv8Ujc+NbICo71nt7G5QDW0ck=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GoqGQ/17KNMGtELxfczF3LaYK4P6KN4jpT880+1YSiwINufez/YAOYqSAFZ598eCY
	 0sUm0EqCfU6oys0pkeuFai/7UZE7GxI611iyD0LT0mdSI8egAFlkYPTTxvUeBchmTa
	 KmBTflwW+Ua0WG+3S7Tht8nuF6GhX4ZnlQIq9v9PDBuoPLbnNIVu1f/28uzDVsPCWp
	 n8QddB6IW5HcqyYqbsIhzsJVopxCUIf++piQXc9KYOzh/7yBKSR0J11MAD3iLasUGf
	 5aP4QbjRkeQ3Zx9zdk6pxZrSgH/PhZonl2ZOZUXl6HVD9FizT2GClxhz8zTxXH60g6
	 DTvLmubwbDDxw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65c294bb0001>; Wed, 07 Feb 2024 09:21:15 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 09:21:15 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 7 Feb 2024 09:21:15 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"noname.nuno@gmail.com" <noname.nuno@gmail.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, Ibrahim Tilki
	<Ibrahim.Tilki@analog.com>, Zeynep Arslanbenzer
	<Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHaVYLoSYVIRNhkz0qX+dhUYUZib7D13rcAgAcQZQA=
Date: Tue, 6 Feb 2024 20:21:15 +0000
Message-ID: <948e9596-e05c-4da4-909d-355917a03407@alliedtelesis.co.nz>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
 <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
In-Reply-To: <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <247FE9472555B04C8C1BF337DB0082C5@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=FK3tp2vlBLUDyu3EqQgA:9 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0

KHJlc2VuZCBhcyBwbGFpbiB0ZXh0LCBzb3JyeSBmb3IgdGhlIG5vaXNlKQ0KDQoNCk9uIDIvMDIv
MjQgMjE6MjgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDAyLzAyLzIwMjQgMDM6
NTIsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBGcm9tOiBJYnJhaGltIFRpbGtpPElicmFoaW0u
VGlsa2lAYW5hbG9nLmNvbT4NCj4+DQo+PiBEZXZpY2V0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlv
biBmb3IgQW5hbG9nIERldmljZXMgTUFYMzEzWFggUlRDcw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IElicmFoaW0gVGlsa2k8SWJyYWhpbS5UaWxraUBhbmFsb2cuY29tPg0KPj4gU2lnbmVkLW9mZi1i
eTogWmV5bmVwIEFyc2xhbmJlbnplcjxaZXluZXAuQXJzbGFuYmVuemVyQGFuYWxvZy5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNp
cy5jby5uej4NCj4+IC0tLQ0KPiAuLi4NCj4NCj4+ICsgIGNsb2NrczoNCj4+ICsgICAgZGVzY3Jp
cHRpb246DQo+PiArICAgICAgUlRDIHVzZXMgdGhpcyBjbG9jayBmb3IgY2xvY2sgaW5wdXQgd2hl
biBzdXBwbGllZC4gQ2xvY2sgaGFzIHRvIHByb3ZpZGUNCj4+ICsgICAgICBvbmUgb2YgdGhlc2Ug
Zm91ciBmcmVxdWVuY2llcyAtIDFIeiwgNTBIeiwgNjBIeiBvciAzMi43NjhrSHouDQo+PiArICAg
IG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBhZGksdGMtZGlvZGU6DQo+PiArICAgIGRlc2NyaXB0
aW9uOg0KPj4gKyAgICAgIFNlbGVjdCB0aGUgZGlvZGUgY29uZmlndXJhdGlvbiBmb3IgdGhlIHRy
aWNrbGUgY2hhcmdlci4NCj4+ICsgICAgICBzY2hvdHRreSAtIFNjaG90dGt5IGRpb2RlIGluIHNl
cmllcy4NCj4+ICsgICAgICBzdGFuZGFyZCtzY2hvdHRreSAtIHN0YW5kYXJkIGRpb2RlICsgU2No
b3R0a3kgZGlvZGUgaW4gc2VyaWVzLg0KPj4gKyAgICBlbnVtOiBbc2Nob3R0a3ksIHN0YW5kYXJk
K3NjaG90dGt5XQ0KPj4gKw0KPj4gKyAgdHJpY2tsZS1yZXNpc3Rvci1vaG1zOg0KPj4gKyAgICBk
ZXNjcmlwdGlvbjogU2VsZWN0ZWQgcmVzaXN0b3IgZm9yIHRyaWNrbGUgY2hhcmdlci4NCj4+ICsg
ICAgZW51bTogWzMwMDAsIDYwMDAsIDExMDAwXQ0KPiBQbGVhc2UgcmVtaW5kIHVzIGFuZCBkb2N1
bWVudCBpbiBjb21taXQgbXNnLCB3aHkgdGhpcyBjYW5ub3QgYmUgcGFydCBvZg0KPiBtYXgzMTMz
NSBiaW5kaW5nPyBMb29rcyBleGFjdGx5IHRoZSBzYW1lLg0KDQpUaGF0IGlzIGFuIGluY3JlZGli
bHkgZ29vZCBwb2ludC4gVGhlIG1heDMxMzM1IGJpbmRpbmcgY292ZXJzIG9uZSANCnNwZWNpZmlj
IGNoaXAuIFRoaXMgYmluZGluZyBjb3ZlcnMgbW9yZSBhbmQgd2l0aCB0aGF0IHRoZXJlIGFyZSBh
IGZldyANCm1vcmUgcHJvcGVydGllcyB0aGF0IHRoZSBtYXgzMTMzNSBvbiBpdCdzIG93biBkb2Vz
bid0IGhhdmUgKGUuZy4gdGhlIA0KY2xvY2sgY29uc3VtZXIsIHRoZSBhYmlsaXR5IHRvIGhhdmUg
ZGlmZmVyZW50IGkyYyBhZGRyZXNzZXMpLiBCaW5kaW5nIA0Kd2lzZSBJIGNvdWxkIHByb2JhYmx5
IHJvbGwgYWxsIG9mIHRoZSBtYXgzMTMzNSBpbnRvIHRoaXMgbWF4MzEzeHggYmluZGluZy4NCg0K
RHJpdmVyIHdpc2UgdGhpbmdzIGFyZSBhIGJpdCB0cmlja2llci4gSSd2ZSBvbmx5IGdvdCBhY2Nl
c3MgdG8gb25lIG9mIA0KdGhlIHZhcmlhbnRzIHNvIEkgYW0gaG9waW5nIHRvIGxldmVyYWdlIHRo
ZSB3b3JrIElicmFoaW0gaGFkIGFscmVhZHkgDQpkb25lLiBJIGNvdWxkIGF0dGVtcHQgdG8gaW5j
b3Jwb3JhdGUgbWF4MzEzMzUgc3VwcG9ydCBpbnRvIHRoZSBtYXgzMTN4eCANCmRyaXZlciBidXQg
SSB3b3VsZG4ndCByZWFsbHkgYmUgYWJsZSB0byB0ZXN0IGl0IHByb3Blcmx5IGFuZCB0aGVyZSBp
cyBhIA0KcmVhc29uYWJseSBoaWdoIGNoYW5jZSBvZiByZWdyZXNzaW5nIHNvbWV0aGluZy4NCg0K
Pj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPg==

