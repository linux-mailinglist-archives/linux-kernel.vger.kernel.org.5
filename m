Return-Path: <linux-kernel+bounces-85652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998986B8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A551F2276B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5F5E07B;
	Wed, 28 Feb 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vChQXobm"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37C5E069
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150495; cv=none; b=TIx8x+qWi54Aze7SV+3mz3HSjJCjT8B1OKVC88loI/JsmuXdR+a/RR8mlyPjwBbDJTiAWA/k4rAPyegb8ILNlkYyQw0hoJyCYE2QYLWc2tWtDtBtqdDBdsKz/WmVaf7uk2Dh9SSYutcMDABCLmrZ0uEmqQ/xRPlb2Ds89OWf/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150495; c=relaxed/simple;
	bh=CYJRnX0LX9ltSDiucl861SMbveP4RK1Ry49h0GXLEh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGU3LA4UQiWYb2qkW1OtMMWeZUh4+gdhrTIC3T3BEFXopdWtIylQZGHRZoRWk8sK4raLkR0cjSeU2RI74wfsO85vMgTImipho+8g/NLNPvpxQoHN7xm6zXM7bexRPqPmvM7l+vXeQuicza+9sQwmrFOTkKMpUc7KX2BBk6Hs8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vChQXobm; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BA1742C0D33;
	Thu, 29 Feb 2024 09:01:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709150489;
	bh=CYJRnX0LX9ltSDiucl861SMbveP4RK1Ry49h0GXLEh8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=vChQXobm+IF8kqkGePewfAvbntcEoGzdOa3v3nr9Pyh5ctBrHqAH3QETyKQCH6X3R
	 CbSdXaf80Pm9HPbIpF2/VJ5KjlAGZcCGk3WvgiQwBb+Xj5sF8a79upEhzEuDyo3Xef
	 +X79p83/sYWTWHIe3mSIjR6GSvM/DX9btemu54Pknv6WNd6PeJ4QanHrwOLf182F9w
	 X5HkAxt+jo+4jMS6/wyvHTVEEDmR4uZWsFM4ubrbponEycCHzN26OtBXTH90bPlRC4
	 gMT4nT1KqXOe7mxUeLVWsTFv6Q1xOxqocpNZukHbrDDkxolRTxiLnboh3B0LjBBwnZ
	 mGoa91xe/E3tA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65df91190001>; Thu, 29 Feb 2024 09:01:29 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 09:01:29 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Thu, 29 Feb 2024 09:01:29 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Rob Herring <robh@kernel.org>
CC: "andy@kernel.org" <andy@kernel.org>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "javierm@redhat.com" <javierm@redhat.com>,
	"robin@protonic.nl" <robin@protonic.nl>, "lee@kernel.org" <lee@kernel.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Thread-Topic: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Thread-Index: AQHaacMcPIjrgF/Em0WhkdYBGa6MPrEe8JuAgABjxQA=
Date: Wed, 28 Feb 2024 20:01:29 +0000
Message-ID: <d666668b-f371-47e0-846e-6e8a56b4bb2f@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <20240228140423.GA3307293-robh@kernel.org>
In-Reply-To: <20240228140423.GA3307293-robh@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <941A10E010CE7B4F94E49388093D5DA1@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65df9119 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=62ntRvTiAAAA:8 a=UDFYyeKIAAAA:8 a=gEfo2CItAAAA:8 a=ZkCM13O6FiSmS0rTvWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=ItlKd2BftxWApCZtRiMt:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOS8wMi8yNCAwMzowNCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFdlZCwgRmViIDI4
LCAyMDI0IGF0IDEwOjIyOjQyQU0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBBZGQg
YmluZGluZ3MgZm9yIGEgZ2VuZXJpYyA3IHNlZ21lbnQgTEVEIGRpc3BsYXkgdXNpbmcgR1BJT3Mu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxp
ZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+Pg0KPj4gTm90ZXM6DQo+PiAgICAgIENoYW5nZXMg
aW4gdjI6DQo+PiAgICAgIC0gVXNlIGNvbXBhdGlibGUgPSAiZ2VuZXJpYy1ncGlvLTdzZWciIHRv
IGtlZXAgaHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD03YjNmNWZVSkd0
WS1LYWxhNVpPT3hhT1ZZdDJCd04tWkxza1lpM2hXRFEmdT1odHRwJTNhJTJmJTJmY2hlY2twYXRj
aCUyZXBsIGhhcHB5DQo+Pg0KPj4gICAuLi4vYXV4ZGlzcGxheS9nZW5lcmljLWdwaW8tN3NlZy55
YW1sICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0MCBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXV4ZGlzcGxheS9nZW5lcmljLWdwaW8tN3NlZy55YW1sDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hdXhk
aXNwbGF5L2dlbmVyaWMtZ3Bpby03c2VnLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXV4ZGlzcGxheS9nZW5lcmljLWdwaW8tN3NlZy55YW1sDQo+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi40NmQ1M2ViZGY0MTMNCj4+IC0tLSAv
ZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hdXhk
aXNwbGF5L2dlbmVyaWMtZ3Bpby03c2VnLnlhbWwNCj4+IEBAIC0wLDAgKzEsNDAgQEANCj4+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
Cj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9zY2FubWFpbC50cnVzdHdh
dmUuY29tLz9jPTIwOTg4JmQ9N2IzZjVmVUpHdFktS2FsYTVaT094YU9WWXQyQndOLVpMc1lkaENR
QVdRJnU9aHR0cCUzYSUyZiUyZmRldmljZXRyZWUlMmVvcmclMmZzY2hlbWFzJTJmYXV4ZGlzcGxh
eSUyZmdlbmVyaWMlMmNncGlvLTdzZWclMmV5YW1sJTIzDQo+PiArJHNjaGVtYTogaHR0cDovL3Nj
YW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD03YjNmNWZVSkd0WS1LYWxhNVpPT3hhT1ZZ
dDJCd04tWkxzWVkwWDlXRGcmdT1odHRwJTNhJTJmJTJmZGV2aWNldHJlZSUyZW9yZyUyZm1ldGEt
c2NoZW1hcyUyZmNvcmUlMmV5YW1sJTIzDQo+PiArDQo+PiArdGl0bGU6IEdQSU8gYmFzZWQgTEVE
IHNlZ21lbnQgZGlzcGxheQ0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBDaHJpcyBQ
YWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiArDQo+PiArcHJv
cGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGNvbnN0OiBnZW5lcmljLWdwaW8t
N3NlZw0KPiAnZ2VuZXJpYycgZG9lc24ndCBhZGQgYW55dGhpbmcgb2YgdmFsdWUuIDdzZWcgaXMg
a2luZCBvZiB2YWd1ZS4gU28sDQo+IGdwaW8tNy1zZWdtZW50Pw0KDQpBY2suDQoNCj4+ICsNCj4+
ICsgIHNlZ21lbnQtZ3Bpb3M6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEFuIGFy
cmF5IG9mIEdQSU9zIG9uZSBwZXIgc2VnbWVudC4NCj4+ICsgICAgbWluSXRlbXM6IDcNCj4gSG93
IGRvZXMgb25lIGtub3cgd2hpY2ggR1BJTyBpcyB3aGljaCBzZWdtZW50Pw0KDQpJJ3ZlIGV4cGFu
ZGVkIHRoZSBkZXNjcmlwdGlvbiBpbiB2My4NCg0KKyBBbiBhcnJheSBvZiBHUElPcyBvbmUgcGVy
IHNlZ21lbnQuIFRoZSBmaXJzdCBHUElPIGNvcnJlc3BvbmRzIHRvIHRoZSBBDQorIHNlZ21lbnQg
dGhlIGxhc3QgR1BJTyBjb3JyZXNwb25kcyB0byB0aGUgRyBzZWdtZW50Lg0KDQpEbyB5b3UgdGhp
bmsgdGhhdCdzIHN1ZmZpY2llbnQgb3IgZG8gSSBuZWVkIHRvIGFkZCBtb3JlPyBJbiB0aGUgZHJp
dmVyIA0KaXRzZWxmIEkndmUgcHV0IGEgbGl0dGxlIGFzY2lpIGFydCBkaWFncmFtIG9mIHRoZSBz
ZWdtZW50cy4NCg==

