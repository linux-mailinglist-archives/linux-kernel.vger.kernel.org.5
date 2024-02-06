Return-Path: <linux-kernel+bounces-55639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400084BF58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549301C23269
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00B1BDE2;
	Tue,  6 Feb 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fBOh7NY6"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1611B949
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255675; cv=none; b=ffH2aeJFz51nHuUodJZwyGGlYClKZgTYzcaGkxzAAMhLy68Yu8hyXBmMA85ED95B77QySlOudbCZP4HW/9Lu+WRQCaRA5MSKz0jaeSstVVEESqOmEEbUVQx+bja5YH3Il6qMG1uTEtGxdtn4uJgsPzWAVTDfRStnLZcSK24HtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255675; c=relaxed/simple;
	bh=uOxvRZjWNwkxRtu86aHxJDkAO2BjK7XIqVjXIUgiQ5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3JY3X1MMYbuRnrLDd7huo4FwAq4o57GG2jdo43QwTb/gE3vUpJhj2SZbosG9obpBenbuuQl1+Utkyd79ysyltKS0HoCzu/QLfAtdLpKW8i/0SAl6SdbYAFTB4G0yphpmVmh8+84naYzPVp2waozGayKBWgEI3ymnSkc8+AmCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=fBOh7NY6; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D5D3A2C03C7;
	Wed,  7 Feb 2024 10:41:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1707255670;
	bh=uOxvRZjWNwkxRtu86aHxJDkAO2BjK7XIqVjXIUgiQ5U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fBOh7NY6wh98aJpdzy+LHWdjP6dmfZ5yr0nuuoelldx6w/bMSnFJZ52GDGBzcmX0a
	 TiHx03WrCiqXsnwzY8bXFGAmpArRaSFtuOFZQqnAp+1VFuu3nOjU1sI4jDqopRvaik
	 zl7K6TlsiGOt8K22WKqARPmHi953M3oEeraJAvH/yZx8MqzMlJss5BwcoB8Muumlz2
	 DTHU8x856z6X9CJ91EC7cf4FzZq0fu+10kDYhqs6Zj6ZtT6hlEdABfgo1tLYRDun0T
	 qS9ReWYvplzUJ0KEO/eqti+ppZbuDysrsIX8iC47Ux2NRxaYLkl5L3gte1pBZwqLaj
	 S/ux18Sx37S/w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65c2a7760001>; Wed, 07 Feb 2024 10:41:10 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 10:41:10 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 7 Feb 2024 10:41:10 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "antoniu.miclaus@analog.com"
	<antoniu.miclaus@analog.com>, "noname.nuno@gmail.com"
	<noname.nuno@gmail.com>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHaVYLoSYVIRNhkz0qX+dhUYUZib7D13rcAgAcP3QCAAA7jgIAAB/mA
Date: Tue, 6 Feb 2024 21:41:10 +0000
Message-ID: <e7a21789-9253-4185-98ed-e335d0167df4@alliedtelesis.co.nz>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
 <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
 <5d4b7fa1-5cc2-4a4a-8fa4-d2c7a8d070b7@alliedtelesis.co.nz>
 <20240206211237d9192660@mail.local>
In-Reply-To: <20240206211237d9192660@mail.local>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE219FA9D6C5E9419656103F92C71157@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=xpRG_LZ1dNQA:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=DibEwSMzcXL41q65tJIA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA3LzAyLzI0IDEwOjEyLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4gT24gMDYvMDIv
MjAyNCAyMDoxOToyMCswMDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gVGhhdCBpcyBhbiBp
bmNyZWRpYmx5IGdvb2QgcG9pbnQuIFRoZSBtYXgzMTMzNSBiaW5kaW5nIGNvdmVycyBvbmUgc3Bl
Y2lmaWMgY2hpcC4gVGhpcyBiaW5kaW5nIGNvdmVycyBtb3JlIGFuZCB3aXRoIHRoYXQgdGhlcmUg
YXJlIGEgZmV3IG1vcmUgcHJvcGVydGllcyB0aGF0IHRoZSBtYXgzMTMzNSBvbiBpdCdzIG93biBk
b2Vzbid0IGhhdmUgKGUuZy4gdGhlIGNsb2NrIGNvbnN1bWVyLCB0aGUgYWJpbGl0eSB0byBoYXZl
IGRpZmZlcmVudCBpMmMgYWRkcmVzc2VzKS4gQmluZGluZyB3aXNlIEkgY291bGQgcHJvYmFibHkg
cm9sbCBhbGwgb2YgdGhlIG1heDMxMzM1IGludG8gdGhpcyBtYXgzMTN4eCBiaW5kaW5nLg0KPj4N
Cj4+IERyaXZlciB3aXNlIHRoaW5ncyBhcmUgYSBiaXQgdHJpY2tpZXIuIEkndmUgb25seSBnb3Qg
YWNjZXNzIHRvIG9uZSBvZg0KPj4gdGhlIHZhcmlhbnRzIHNvIEkgYW0gaG9waW5nIHRvIGxldmVy
YWdlIHRoZSB3b3JrIElicmFoaW0gaGFkIGFscmVhZHkNCj4+IGRvbmUuIEkgY291bGQgYXR0ZW1w
dCB0byBpbmNvcnBvcmF0ZSBtYXgzMTMzNSBzdXBwb3J0IGludG8gdGhlDQo+PiBtYXgzMTN4eCBk
cml2ZXIgYnV0IEkgd291bGRuJ3QgcmVhbGx5IGJlIGFibGUgdG8gdGVzdCBpdCBwcm9wZXJseSBh
bmQNCj4+IHRoZXJlIGlzIGEgcmVhc29uYWJseSBoaWdoIGNoYW5jZSBvZiByZWdyZXNzaW5nIHNv
bWV0aGluZy4NCj4gQnV0IEkgd29uJ3QgdGFrZSBhIHNlcGFyYXRlIGRyaXZlci4gRXZlcnl0aGlu
ZyB3b3VsZCBiZSBiZXR0ZXIgaWYgQW5hbG9nDQo+IHdhcyBzaGFyaW5nIHRoZSBkYXRhc2hlZXRz
Li4uDQoNClRoZSBkYXRhc2hlZXRzIGFyZSBwcmV0dHkgYWNjZXNzaWJsZSBzbyBJJ2QgZ2l2ZSBB
bmFsb2cgYSBwYXNzIG9uIHRoYXQgDQoodGhleSdyZSBjZXJ0YWlubHkgYmV0dGVyIHRoYW4gc29t
ZSB2ZW5kb3JzKS4gSSdsbCBpbmNsdWRlIHNvbWUgbGlua3Mgb24gDQp0aGUgbmV4dCB1cGRhdGUu
DQoNCkknbGwgYXR0ZW1wdCB0byByb2xsIHRoZSBtYXgzMTMzNSBpbnRvIHRoZSBtYXgzMTN4eCBk
cml2ZXIuDQo=

