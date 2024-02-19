Return-Path: <linux-kernel+bounces-71941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36485ACD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFE0B2397C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB952F96;
	Mon, 19 Feb 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ttwwhAki"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CA44C93
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373579; cv=none; b=imEfIH2CCPO6+wnO72oGD2QZ05GGNaPgzXuFkhJSIxOp6aPJ7CaGIXW6xKCRpyqnBBXekEs9qYnNFx7+cnnitVvYNnftlgjgTMEam0BmUTJd0r5FQvqGMJFyZxEWCiyEgNFpnf26nZ+pR7SdN1+aHBGrjxMM1QC31YxB738rf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373579; c=relaxed/simple;
	bh=268rFhGmb3VNCaKibaD/7clueCk9/+z0fz5A5gKU1Vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4+lH9JGnZEZtpO2uXuWKFjTisvtGWvYygXyLeSRaonIdQiLeW7S/NHoKrwLk6qkuhee/njpsMCWQxXPztktQk69luR2aMPtgeOlBI12Ee0q7CWM4yF1RyZIkjfyr1mjjCqKmtsoEV5BjzWgPdMusJifmdsjU4ahrjfnOStRtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ttwwhAki; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9E1ED2C03CF;
	Tue, 20 Feb 2024 09:12:54 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708373574;
	bh=268rFhGmb3VNCaKibaD/7clueCk9/+z0fz5A5gKU1Vk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ttwwhAki/lPngdOSkc5WHdXAguJEiSJeg64M8nsRyAqxZfTk/gjPqac7rD8u6xfsy
	 uPtX4LrI8HOVbpKIZt1/MIXnZ85yb74H2Xm75UEcAJB69HSijpz7LCSM4z8vy8PV2Y
	 QyPrCIYiTOWiMjt1ASmfvWpzYtzo4rI+NJNqcLBjCZLcr8tUsd2VxiV47QUvW+GurT
	 /fUrpSbB44n8KZGZez5o3h2qyPlSl3XKjazbWu9t+vm01SknDKsQ1hiCrYAtZAL7n2
	 udwAx/O+nBMGBV6knNQqEag0ypy3UMjL7HBvlGiZwTueuSi+ONhPsMm52U9QmMy2Ml
	 jwcSMD0Jmq7jw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d3b6460001>; Tue, 20 Feb 2024 09:12:54 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 09:12:54 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Tue, 20 Feb 2024 09:12:54 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 20 Feb 2024 09:12:54 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Lee Jones <lee@kernel.org>
CC: Pavel Machek <pavel@ucw.cz>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Thread-Topic: Linux support for a 7 segment LED display
Thread-Index: AQHaXStZfYl8Vw6dm0yz1EAjpP4fVbEQ+CEAgABTpIA=
Date: Mon, 19 Feb 2024 20:12:54 +0000
Message-ID: <a70425d3-95be-4360-9828-d5403404e803@alliedtelesis.co.nz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <20240219151332.GC10170@google.com>
In-Reply-To: <20240219151332.GC10170@google.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A16C98420EE8346B511A26CC168F8DC@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d3b646 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=qMW7oTCNIhuhOx3iAzMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgTGVlLA0KDQpPbiAyMC8wMi8yNCAwNDoxMywgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBTdW4s
IDExIEZlYiAyMDI0LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPg0KPj4gSGkgQmxpbmtlbmxpZ2h0
IGVudGh1c2lhc3RzLA0KPj4NCj4+IEknbSBsb29raW5nIGZvciBzb21ldGhpbmcgdGhhdCBJIGZp
Z3VyZWQgbXVzdCBleGlzdHMgYnV0IG1heWJlIGl0J3Mgc28NCj4+IG5pY2hlIHRoYXQgbm8tb25l
IGhhcyBib3RoZXJlZCB0byB1cHN0cmVhbSBhIGRyaXZlciBmb3IgaXQuDQo+Pg0KPj4gSSBoYXZl
IGEgcmVxdWlyZW1lbnQgdG8gc3VwcG9ydCBhIDctc2VnbWVudCBMRUQgZGlzcGxheVsxXSAob25l
IHRoYXQgY2FuDQo+PiBkaXNwbGF5IGEgc2luZ2xlIGRpZ2l0IGZyb20gMC05KS4gSGFyZHdhcmUg
d2lzZSBpdCdzIGp1c3QgYSBidW5jaCBvZg0KPj4gaW5kaXZpZHVhbCBHUElPcyBjb25uZWN0ZWQg
dG8gZWFjaCBzZWdtZW50IChwbHVzIGFuIGV4dHJhIG9uZSBmb3IgYQ0KPj4gZG90KS4gSSBjYW4n
dCBzZWUgYW55dGhpbmcgb2J2aW91cyBpbiBkcml2ZXJzL2xlZHMgYnV0IG1heWJlIEknbSBsb29r
aW5nDQo+PiBpbiB0aGUgd3JvbmcgcGxhY2UuIE9yIG1heWJlIGl0J3MgdGhlIGtpbmQgb2YgdGhp
bmcgb24gUEMgaGFyZHdhcmUgdGhhdA0KPj4gaXMganVzdCBkcml2ZW4gYnkgdGhlIEJJT1Mgd2l0
aG91dCB0aGUgb3BlcmF0aW5nIHN5c3RlbSBrbm93aW5nIGFib3V0IGl0Lg0KPj4NCj4+IElzIHRo
ZXJlIGFuIGV4aXN0aW5nIGluLWtlcm5lbCBkcml2ZXIgZm9yIHN1Y2ggYSB0aGluZz8NCj4gV2h5
IHdvdWxkIExFRHMgY29ubmVjdGVkIHRvIGEgYnVuY2ggb2YgR1BJT3MgaW4gYSBzcGVjaWZpYyBm
YXNoaW9uDQo+IHJlcXVpcmUgYSBoYXJkd2FyZSBkcml2ZXI/ICBEb2Vzbid0IGRyaXZlcnMvbGVk
cy9sZWRzLWdwaW8uYyBhbHJlYWR5DQo+IHByb3ZpZGUgYWxsIHRoZSBzdXBwb3J0IHlvdSBuZWVk
Pw0KWWVzIEkgY291bGQgZXhwb3NlIHRoZSBpbmRpdmlkdWFsIHNlZ21lbnRzIGFzIGdwaW8tbGVk
c2J1dCBpdCB3b3VsZCBiZSANCm5pY2VyIGlmIHRoZXkgd29ya2VkIGluIGEgbW9yZSBjby1vcmRp
bmF0ZWQgZmFzaGlvbiBzbyBJIGRpZG4ndCBoYXZlIHRvIA0KY2FyZSBhYm91dCB0aGUgaW5kaXZp
ZHVhbCBzZWdtZW50cyBhbmQgY291bGQganVzdCBzYXkgImRpc3BsYXkgNyIgb3IgDQoiZGlzcGxh
eSAwIi4=

