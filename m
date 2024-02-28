Return-Path: <linux-kernel+bounces-85672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3986B903
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC424284206
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878B79B7C;
	Wed, 28 Feb 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="pS46KXor"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E7F7442A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151700; cv=none; b=RBR9SQEHkocIEXY33jvTK93Oj6NHt/bxmUqwrHHnT54/xLZkJfxVCVjdNhMeocYluQCIxresjApG6rD4YQ+hsap6SZAqvd7OWlEvH1ritTNpsD53RF5Yl8JxRuVp+nT6sI/hHgnf0kEtI41KfDNEF0QVhz9gWnevSKDFRNL1NEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151700; c=relaxed/simple;
	bh=TxBC+4TssxTTp9f7D6m7kXVTU++hbQdHbjHGF5wBotw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftrrMTQFk6Hv2SiY0wDSZuQ3BbETcXbsbhxMyT2FOczudYhyGNPOcdZahqQVJEjwMVek+sONhyqzBxpwA200wkktV8h7R6HyniZFo/AO6bBEowj++VUPdVcIV+FLbaPa7enU2nfTaFMY3jV6/uHtEKWJJseCxdNdOnshK514mqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=pS46KXor; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CCCE22C0F4B;
	Thu, 29 Feb 2024 09:21:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709151695;
	bh=TxBC+4TssxTTp9f7D6m7kXVTU++hbQdHbjHGF5wBotw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=pS46KXore/zJ3sM5YVVFYzpt2SlSb2DlBLls3BzuYZOHp2ZK79MtlQwIqZi7qMYCy
	 eliAB4k5MtYpIOBHJGjuEVE/TI1Xc3BEWTS3v1tSi9ZS+1YL94P4C2wViV4Sa9BpXY
	 rB74C5w5/+6tuiq1wAhav6/V32c0NiLLy68UM06KmbhUormTzuyvoKGf5/uZAqc1jM
	 EYoCDx8EEvL0rFxntXmFf5Ly6t5uNh6BZOG9q5rFI9t0tfcm/RSHYx47g+P8afdnb0
	 h8ZEIRUZw6Yog5Xgmivhf47biiLLvK9vH/dXt62VBATwaEOJJ2rHyhPq40+GbXoQnO
	 5Itbs3PfE2Ycg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65df95cf0001>; Thu, 29 Feb 2024 09:21:35 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 09:21:35 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Thu, 29 Feb 2024 09:21:35 +1300
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
Thread-Index: AQHaaRjAl7efaZl90kO9VhcwpC4GlbEezqKAgACMsYA=
Date: Wed, 28 Feb 2024 20:21:35 +0000
Message-ID: <bd43a198-6287-40b2-be15-2734c5d2742d@alliedtelesis.co.nz>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
 <20240227010312.3305966-3-chris.packham@alliedtelesis.co.nz>
 <20240228-embark-rimmed-d81bab3d42b8@spud>
In-Reply-To: <20240228-embark-rimmed-d81bab3d42b8@spud>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <79808D2C7F25F941B81BDA6EF24E4E81@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65df95cf a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=mQj2jn3d1LK7cqRs_WYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOS8wMi8yNCAwMDo1OCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAy
NywgMjAyNCBhdCAwMjowMzoxMFBNICsxMzAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPg0KPj4g
ICAgIGludGVycnVwdHM6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEFsYXJtMSBp
bnRlcnJ1cHQgbGluZSBvZiB0aGUgUlRDLiBTb21lIG9mIHRoZSBSVENzIGhhdmUgdHdvIGludGVy
cnVwdA0KPj4gKyAgICAgIGxpbmVzIGFuZCBhbGFybTEgaW50ZXJydXB0IG11eGluZyBkZXBlbmRz
IG9uIHRoZSBjbG9ja2luL2Nsb2Nrb3V0DQo+PiArICAgICAgY29uZmlndXJhdGlvbi4NCj4+ICAg
ICAgIG1heEl0ZW1zOiAxDQo+IFRoZSBtYXhJdGVtczogMSBsb29rcyBvZGQgaGVyZSB3aGVuIHlv
dSBzdGF0ZSAic29tZSBvZiB0aGUgUlRDcyBoYXZlIHR3bw0KPiBpbnRlcnJ1cHQgbGluZXMiLCB3
aGljaCBtYWtlcyBpdCBzb3VuZCBhcyBpZiB0aGVyZSBhcmUgYWN0dWFsbHkgdHdvDQo+IGludGVy
cnVwdHMgdGhhdCBzaG91bGQgYmUgZXhwb3NlZCBoZXJlLiBJZiB0aG9zZSB0d28gaW50ZXJydXB0
cyBnZXQNCj4gbXV4ZWQgdG8gdGhlIHNhbWUgcGluIGZvciBvdXRwdXQgSSdkIHN1Z2dlc3QgdGhh
dCB5b3UgY2xhcmlmeSB0aGF0IGhlcmUuDQoNClRoaXMgbWF5IGVuZCB1cCBjaGFuZ2luZyBpZiBJ
IGNhbiBjb21lIHVwIHdpdGggc29tZXRoaW5nIHRoYXQgQWxleGFuZHJlIA0KaXMgaGFwcHkgd2l0
aC4gQmFzaWNhbGx5IChzb21lIG9mKSB0aGUgY2hpcHMgaGF2ZSBhIGNvbmZpZ3VyYWJsZSBwaW4g
DQp0aGF0IGNhbiBlaXRoZXIgYmUgZGVkaWNhdGVkIHRvIHRoZSBBTEFSTTEgb3V0cHV0IChhbm5v
eWluZ2x5IGxhYmVsbGVkIA0KYXMgSU5UQikgb3IgdG8gYSBjbG9jayBvdXRwdXQuIFRoZXJlIGlz
IGFuIElOVEEgbGluZSB0aGF0IGhhcyBvdGhlciANCmludGVycnVwdHMgYW5kIGlmIHRoZSBjbG9j
ayBvdXRwdXQgb3B0aW9uIGlzIHVzZWQgdGhlbiBpdCBhbHNvIGhhcyANCkFMQVJNMS4gVGhlIGRy
aXZlciBkb2Vzbid0IGN1cnJlbnRseSBkbyBhbnl0aGluZyB3aXRoIHRoZSBvdGhlciANCmludGVy
cnVwdCBzb3VyY2VzIHNvIGFzIHdyaXR0ZW4gdGhpcyBuZWVkcyB0byBjb3JyZXNwb25kIHRvIHdo
aWNoZXZlciANCmludGVycnVwdCBvdXRwdXQgaXMgYXNzZXJ0ZWQgZm9yIEFMQVJNMS4NCg0KPiBP
dGhlcndpc2UsIHRoaXMgbG9va3MgZ29vZCB0byBtZSAtIGFsdGhvdWdoIEkgZG8gd29uZGVyIGlm
IHRoZQ0KPiBhdXRob3JzaGlwIG9uIHRoZSBjb21taXQgKGF0dHJpYnV0ZWQgdG8gdGhlIGFuYWxv
ZyBndXlzKSBpcyBzdGlsbA0KPiBhY2N1cmF0ZS4NCg0KSSB0aGluayB0aGUgYmluZGluZyBpcyBz
dGlsbCBwcmV0dHkgY2xvc2UgdG8gdGhlIGxhc3QgdmVyc2lvbiBzZW50IG91dCANCmJ5IHRoZSBh
bmFsb2cgZm9sa3MuIFRoZSBkcml2ZXIgYXQgdGhpcyBwb2ludCBpcyBwcm9iYWJseSB1bnJlY29n
bml6YWJsZSANCmV2ZW4gdGhvdWdoIEkndmUgb25seSByZWFsbHkgcmVuYW1lZCBzdHVmZiBhbmQg
bW92ZWQgZnVuY3Rpb25zIGFyb3VuZC4NCg0KSSB3YXMga2luZCBvZiBob3BpbmcgbXkgcHJvZGRp
bmcgd291bGQgYmUgbWV0IHdpdGggYSAib2ggd2UndmUgYWxyZWFkeSANCmRvbmUgdGhpcyBpbiBv
dXIgU0RLLCBoZXJlJ3MgdGhlIGxhdGVzdCB2ZXJzaW9uIiBidXQgdGhhdCBoYXNuJ3QgDQpoYXBw
ZW5lZC4gSSdtIGZhaXJseSBjbG9zZSB0byBkcm9wcGluZyBhbnl0aGluZyBpbiB0aGlzIHNlcmll
cyB0aGF0IA0KaXNuJ3QgcmVsYXRlZCB0byB0aGUgTUFYMzEzMzQgYXMgdGhhdCBpcyB0aGUgb25s
eSBoYXJkd2FyZSBJIGNhbiANCmFjdHVhbGx5IHRlc3QuDQoNCj4NCj4gVGhhbmtzLA0KPiBDb25v
ci4=

