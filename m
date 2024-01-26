Return-Path: <linux-kernel+bounces-39537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED183D280
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654311F24EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A98C02;
	Fri, 26 Jan 2024 02:22:31 +0000 (UTC)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776D10F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235750; cv=none; b=iWNlH1zjZq8iWdxoNV6bGVsmRy4otqQkVOqBmMObcODBGeNvJ9u6PnHx3repj/HTEo4XyxrsjMj0YR7/5yJ/kqzY5OCtLwhFzgQQ6N2BTxykF7xL/A9IuX4q/Y3633DYAtFsJTNvAOeGEd18iUmeAIx4OcQsvGj1q0n3p5RJUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235750; c=relaxed/simple;
	bh=cgBR38TJwFWOrst3omJ+4iSijSjOLH9MK/17RMaPCGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o10lGJcxn3UuPpvbN4zZ6c/uobdO0wIMiw2EgG2SR0DNN91SfgqfVnFVoyqxEgjEw6wdfjaMNGif7deXz8dxuT27aYARPZbNTyQCULUKqJpcN5RHYv2b/YgxhWyrU83vWz0kGWN1qrhEdVP7fyr+CySy0L8PxHrpDPDl/v1mbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (unknown [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EF52D2C1077;
	Fri, 26 Jan 2024 15:22:16 +1300 (NZDT)
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65b317580001>; Fri, 26 Jan 2024 15:22:16 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:22:16 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 26 Jan 2024 15:22:16 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Ibrahim Tilki <Ibrahim.Tilki@analog.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHaT/57pfs9+wriS028zs2/xPWJRw==
Date: Fri, 26 Jan 2024 02:22:16 +0000
Message-ID: <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
In-Reply-To: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFAEA80C4FBAF146B167D37EF2B114EB@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=QyXUC8HyAAAA:8 a=y9Ms7NjFG32jJv2empEA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQWxsLA0KDQpPbiA0LzA0LzIzIDAzOjQzLCBJYnJhaGltIFRpbGtpIHdyb3RlOg0KPiBjaGFu
Z2Vsb2c6DQo+IHNpbmNlIHY1Og0KPiAgICAtIGR0LWJpbmRpbmc6IGFkZCBlbnVtIHZhbHVlICIy
IiB0byBhdXgtdm9sdGFnZS1jaGFyZ2FibGUNCj4gICAgLSBkdC1iaW5kaW5nOiByZW1vdmUgYWRp
LHRyaWNrbGUtZGlvZGUtZW5hYmxlDQo+ICAgIC0gZHQtYmluZGluZzogY2hhbmdlIGRlc2NyaXB0
aW9uIG9mIHRyaWNrbGUtcmVzaXN0b3Itb2htcw0KPiAgICAtIGR0LWJpbmRpbmc6IHJlb3JkZXIg
YXMgaW4gZXhhbXBsZSBzY2hlbWENCj4gICAgLSBwYXJzZSAid2FrZXVwLXNvdXJjZSIgd2hlbiBp
cnEgbm90IHJlcXVlc3RlZA0KPiAgICAtIHJlbW92ZSBsaW1pdGF0aW9uIG9uIG1heDMxMzI4IGly
cSBhbmQgY2xva291dA0KPiAgICAtIHJlbW92ZSBlcnJvciBhbmQgd2FybmluZyBtZXNzYWdlcyBk
dXJpbmcgdHJpY2tsZSBjaGFyZ2VyIHNldHVwDQo+DQo+IHNpbmNlIHY0Og0KPiAgICAtIGR0LWJp
bmRpbmc6IHJlbW92ZSBpbnRlcnJ1cHQgbmFtZXMuDQo+ICAgIC0gZHQtYmluZGluZzogYWRkIGRl
c2NyaXB0aW9uIGZvciAiaW50ZXJydXB0cyIgcHJvcGVydHkNCj4gICAgLSBkdC1iaW5kaW5nOiBy
ZXBsYWNlIGRlcHJlY2F0ZWQgcHJvcGVydHkgInRyaWNrbGUtZGlvZGUtZGlzYWJsZSINCj4gICAg
ICAgIGJ5ICJhdXgtdm9sdGFnZS1jaGFyZ2VhYmxlIg0KPiAgICAtIGR0LWJpbmRpbmc6IGFkZCBu
ZXcgcHJvcGVydHkgImFkaSx0cmlja2xlLWRpb2RlLWVuYWJsZSINCj4gICAgLSBkdC1iaW5kaW5n
OiByZW1vdmUgIndha2V1cC1zb3VyY2UiDQo+ICAgIC0gdXNlIGNsZWFyX2JpdCBpbnN0ZWFkIG9m
IF9fY2xlYXJfYml0DQo+ICAgIC0gdXNlIGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlciBpbnN0
ZWFkIG9mIG9mX2Nsa19hZGRfcHJvdmlkZXINCj4gICAgLSB1c2UgY2hpcF9kZXNjIHBvaW50ZXIg
YXMgZHJpdmVyIGRhdGEgaW5zdGVhZCBvZiBlbnVtLg0KPg0KPiBzaW5jZSB2MzoNCj4gICAgLSBh
ZGQgImJyZWFrIiB0byBmaXggd2FybmluZzogdW5hbm5vdGF0ZWQgZmFsbC10aHJvdWdoDQo+ICAg
ICAgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPg0KPiBz
aW5jZSB2MjoNCj4gICAgLSBkdC1iaW5kaW5nOiB1cGRhdGUgdGl0bGUgYW5kIGRlc2NyaXB0aW9u
DQo+ICAgIC0gZHQtYmluZGluZzogcmVtb3ZlIGxhc3QgZXhhbXBsZQ0KPiAgICAtIGRyb3Agd2F0
Y2hkb2cgc3VwcG9ydA0KPiAgICAtIHN1cHBvcnQgcmVhZGluZyAxMkhyIGZvcm1hdCBpbnN0ZWFk
IG9mIGZvcmNpbmcgMjRociBhdCBwcm9iZSB0aW1lDQo+ICAgIC0gdXNlICJ0bV95ZWFyICUgMTAw
IiBpbnN0ZWFkIG9mIHJhbmdlIGNoZWNrDQo+ICAgIC0gcmVmYWN0b3IgbWF4MzEzeHhfaW5pdCBm
b3IgcmVhZGFiaWxpdHkNCj4NCj4gSWJyYWhpbSBUaWxraSAoMik6DQo+ICAgIGRyaXZlcnM6IHJ0
YzogYWRkIG1heDMxM3h4IHNlcmllcyBydGMgZHJpdmVyDQo+ICAgIGR0LWJpbmRpbmdzOiBydGM6
IGFkZCBtYXgzMTN4eCBSVENzDQo+DQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2Fk
aSxtYXgzMTN4eC55YW1sIHwgIDE0NCArKysNCj4gICBkcml2ZXJzL3J0Yy9LY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDExICsNCj4gICBkcml2ZXJzL3J0Yy9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gICBkcml2ZXJzL3J0Yy9ydGMtbWF4
MzEzeHguYyAgICAgICAgICAgICAgICAgICAgfCAxMDUzICsrKysrKysrKysrKysrKysrDQo+ICAg
NCBmaWxlcyBjaGFuZ2VkLCAxMjA5IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hZGksbWF4MzEzeHgueWFt
bA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3J0Yy9ydGMtbWF4MzEzeHguYw0KDQpX
aGF0IGhhcHBlbmVkIHRvIHRoaXMgc2VyaWVzIGluIHRoZSBlbmQ/IEl0IGtpbmQgb2Ygd2VudCBv
ZmYgbXkgcmFkYXIgDQphbmQgSSBmb3Jnb3QgYWJvdXQgaXQuDQoNCldlJ3ZlIGJlZW4gY2Fycnlp
bmcgYSB2ZXJzaW9uIG9mIHRoZXNlIGNoYW5nZXMgaW4gb3VyIGxvY2FsIHRyZWUgZm9yIGEgDQp3
aGlsZSAoYW5kIHVzaW5nIGl0IHF1aXRlIGhhcHBpbHkgSSBzaG91bGQgYWRkKS4NCg0K

