Return-Path: <linux-kernel+bounces-98323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F74877869
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181FCB20BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819123A1D4;
	Sun, 10 Mar 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xFP4aJVG"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA73A1A1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102132; cv=none; b=h3LdSwevAHgz4XanP7aSg37Ut+sZg5tC3d+q4wVwjkXVmO1BRf9GXWgYcULuIcJBPOJUb3D1C9zuuGHYaeBB3cfOSXAGnjY9uwKCPP5EycvhMUPABn2Jgi92Q1kK/agFltEtZnccaBpwK9PbP3Sj1qKW5Gj9YNVxgxwvM4DFdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102132; c=relaxed/simple;
	bh=o9SIpBod496TCXf9hkprvKa/SX2yV9yWsqEpQqjVfcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqxaK56qo+WrDv4UoEZDVscfFLEPF+FWrQS0Yp6nUj2hFTDYHoMa9Y68zbqY2GaRu32X9S+5M4eiBwqAvZKy/1DYzaVaslQn9UU/rOuMAmc4tG99ybRENuMj2SulU6JVhOEnrBnrmqHOnCM1gOk8XLCuHIWYGyV+oE7pui3gm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xFP4aJVG; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D84322C04C9;
	Mon, 11 Mar 2024 09:22:01 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710102121;
	bh=o9SIpBod496TCXf9hkprvKa/SX2yV9yWsqEpQqjVfcs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=xFP4aJVGu+YQtLyGlazQED5LYfQU+4uSS1cNjw776A6gCn3MU2m41DKEI0No7jGo7
	 AWE5VC0H1xFfRRtUAxM/DXxtMOgw/UobcNNVVbBhpli0tHD5xIu2W7iEFANssD5wqf
	 91kdWyiZeZZe/Xv1Rj/jHkl8QKYZ9HHNxW1IlTxa+H8zSWqrK83EnR3snG4y3Qu6SC
	 jMxaj0jLmJ+YrkqWcH18zo0b7DZ6dC9Em3Kx5g15w2BvMUz2w25CYx/MkTFqQ8Wqkd
	 mS9ltFQlZoSofUyTnypbYorSc8KjbTrqqBI4qACnUvzfXMUKfBWYLfVF21E1mh2VhR
	 DR+eql2SWE5Dg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65ee16690001>; Mon, 11 Mar 2024 09:22:01 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 09:22:01 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 11 Mar 2024 09:22:01 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 11 Mar 2024 09:22:01 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann
	<arnd@kernel.org>
CC: Gregory Clement <gregory.clement@bootlin.com>, Andy Shevchenko
	<andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Lee Jones <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on
 x530
Thread-Topic: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on
 x530
Thread-Index: AQHacCEP50uDUqyXjk+YznxFpDHUm7EsnIcAgAAm+YCAAAZbAIAABFUAgAPI1gA=
Date: Sun, 10 Mar 2024 20:22:01 +0000
Message-ID: <6c3451ed-6346-45e2-940e-851cb99a1b63@alliedtelesis.co.nz>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
 <87edclgoon.fsf@BL-laptop>
 <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
 <8177b94d-82c9-42b6-85eb-728dec762162@app.fastmail.com>
 <CAHp75VfiaWFricM4Or771P0LJVoFoEmQtoJo1hySo=BRS-59DQ@mail.gmail.com>
In-Reply-To: <CAHp75VfiaWFricM4Or771P0LJVoFoEmQtoJo1hySo=BRS-59DQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2BFEDE75258504288D9C927195E3235@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65ee1669 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=sQGCJnOpldAfCmytSDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0

DQpPbiA4LzAzLzI0IDIzOjM0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIEZyaSwgTWFy
IDgsIDIwMjQgYXQgMTI6MTnigK9QTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4gT24gRnJpLCBNYXIgOCwgMjAyNCwgYXQgMTA6NTYsIEFuZHkgU2hldmNoZW5rbyB3
cm90ZToNCj4+PiBPbiBGcmksIE1hciA4LCAyMDI0IGF0IDk6MzbigK9BTSBHcmVnb3J5IENMRU1F
TlQNCj4+PiA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPiB3cm90ZToNCj4+Pj4gQ2hyaXMg
UGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cml0ZXM6DQo+Pj4+
DQo+Pj4+PiBUaGUgQWxsaWVkIFRlbGVzaXMgeDUzMCBwcm9kdWN0cyBoYXZlIGEgNy1zZWdtZW50
IExFRCBkaXNwbGF5IHdoaWNoIGlzDQo+Pj4+PiB1c2VkIGZvciBub2RlIGlkZW50aWZpY2F0aW9u
IHdoZW4gdGhlIGRldmljZXMgYXJlIHN0YWNrZWQuIFJlcHJlc2VudA0KPj4+Pj4gdGhpcyBhcyBh
IGdwaW8tNy1zZWdtZW50IGRldmljZS4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+Pj4+IEFja2Vk
LWJ5OiBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290bGluLmNvbT4NCj4+Pj4N
Cj4+Pj4gTm9ybWFsbHksIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIHRha2VuIGluIG12ZWJ1IGFuZCB0
aGVuIG1lcmdlZCBieQ0KPj4+PiBhcm0tc29jLiBIb3dldmVyLCBJIGhhdmVuJ3Qgc2VlbiBhbnkg
b3RoZXIgcGF0Y2ggdG91Y2hpbmcgdGhpcyBmaWxlIChzbw0KPj4+PiBubyByaXNrIG9mIG1lcmdl
IGNvbmZsaWN0KSBhbmQgSSB0aGluayBpdCdzIHRvbyBsYXRlIGZvciBtZSB0byBtYWtlIGENCj4+
Pj4gbmV3IHB1bGwgcmVxdWVzdCB0byBhcm0tc29jLiBTbyBJJ20gbm90IGFnYWluc3QgaXQgYmVp
bmcgdGFrZW4gd2l0aCB0aGUNCj4+Pj4gcmVzdCBvZiB0aGUgcGF0Y2hlcy4gSG93ZXZlciwgSSB0
aGluayBpdCB3b3VsZCBiZSBhIGdvb2QgaWRlYSB0byBzZWUNCj4+Pj4gd2hhdCBBcm5kIHRoaW5r
cyBhYm91dCBpdC4NCj4+PiBBcm5kIHdhc24ndCBDYydlZCwgbm93IEkgYWRkZWQgaGltLg0KPj4g
SSBhbHJlYWR5IGhhdmUgYSAnbGF0ZScgYnJhbmNoIGZvciBzdHVmZiB0aGF0IGZvciBzb21lIHJl
YXNvbg0KPj4gd2FzIHRvbyBsYXRlIGJlIHBhcnQgb2YgdGhlIG5vcm1hbCBwdWxsIHJlcXVlc3Rz
IGJ1dCBzaG91bGQNCj4+IHN0aWxsIG1ha2UgaXQgaW50byA2LjkuIElmIHRoaXMgb25lIGlzIGlt
cG9ydGFudCwgSSBkb24ndA0KPj4gbWluZCB0YWtpbmcgaXQuDQo+Pg0KPj4gT24gdGhlIG90aGVy
IGhhbmQsIGZyb20gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHRoaXMgb25lIGRvZXNuJ3QNCj4+IHNl
ZW0gdGhhdCB1cmdlbnQsIHNvIEkgZG9uJ3Qgc2VlIG11Y2ggaGFybSBpbiBkZWxheWluZyBpdA0K
Pj4gdG8gdjYuMTAsIGFuZCB1c2luZyB0aGUgbm9ybWFsIHByb2Nlc3MgZm9yIGl0Lg0KPiBUaGFu
a3MsIEkgd2lsbCBkZWZlciB0aGlzIG9uZSB0aGVuLg0KPiBDaHJpcywgcGxlYXNlIGhhbmRsZSB0
aGlzIG9uZSBhZnRlciB2Ni45LXJjMSBpcyBvdXQuIFRoZSBmaXJzdCB0d28gSSdtDQo+IGdvaW5n
IHRvIHRha2UgdG9kYXkuDQo+DQpObyBwcm9ibGVtLiBJIGNhbiBzZW5kIHRoZSBkdHMgY2hhbmdl
cyBzZXBhcmF0ZWx5Lg0KDQpGWUkgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIC1mIGFyY2gv
YXJtL2Jvb3QvZHRzL21hcnZlbGwgaXNuJ3QgDQpwaWNraW5nIHVwIEFybmQgc2hvdWxkIGl0Pw0K

