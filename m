Return-Path: <linux-kernel+bounces-77427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0067860532
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6521C24F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617412D200;
	Thu, 22 Feb 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Pd/t9EQL"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD073F20
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638833; cv=none; b=At0vsxLITSchirNMA6DokmMwi/ieAipFEjDwq9smAYeDPdjOFkUE0LZ8USvjSfgYzHKWBat5JbqNsu/EY1Y09Xv5A8s0pH4nx/p0yZKV4aMQgQ/mXgm9hVJ3NAHCDXSg5QVO1r33H3t4TrsxyGwPQ0BJGqj517+OuVcT3P6FnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638833; c=relaxed/simple;
	bh=vWsxH17dxqDERI+04yYKFZ2rz4W2M0nObcAj7CTld4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HvSpigKK24k1OApFNKlkFHb/HUe+ZsJuEUZ26FRBaZWasiPvSePB730yMdH8kAYQE1OlDxBNYqqo9OIQ798otE6etPj4BNamBzVHoYvDR7gwkh5+A98T2gOyi03FneSu3SQWbqxTBe0UCwS6Azc5Zw3nTs2X20J6b1x6ViYH/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Pd/t9EQL; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C33532C05EA;
	Fri, 23 Feb 2024 10:53:42 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708638822;
	bh=vWsxH17dxqDERI+04yYKFZ2rz4W2M0nObcAj7CTld4w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Pd/t9EQLDNmH8UT10LAgWoDjZ/IeIx62XIDmhvEzT9XV5LVSZLAdfUUy9XfnArGNy
	 lAXi+RBudkjadKu6PnRvKMahRj/eOTWdUqL1DaNiZB0KL879dPkCy3j+tJZkhtg5dz
	 KjaEiTbX6BErkxeH1dxS++G626SQbPCDKVPTe3pQ+O+ZSpY2pOJExb2kSSXfw3GMFa
	 jSnqRyZwFqq3UCV8c3LZtcxRM8QvUzJJ4PuKggStol62gLAAHXGRY5+wph8ilnaOQa
	 q5m+sa3PPkTJzC1PeeNEmW04ixoVD0MDGFyT8zGKVUGTYTgM6YzWv1oY8Ybw0j1gtc
	 EP5/m2rSGXspQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d7c2660001>; Fri, 23 Feb 2024 10:53:42 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 10:53:42 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Feb 2024 10:53:42 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 23 Feb 2024 10:53:42 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Thread-Topic: Linux support for a 7 segment LED display
Thread-Index: AQHaXStZfYl8Vw6dm0yz1EAjpP4fVbEWGZeAgAAFVoA=
Date: Thu, 22 Feb 2024 21:53:42 +0000
Message-ID: <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain>
In-Reply-To: <Zde966nsJ76QOuzm@surfacebook.localdomain>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC46E06F84DF9B4AA76C4B696AFBAC35@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d7c266 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=pGLkceISAAAA:8 a=Uzj4q5aa05oE0FIBGyMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyMy8wMi8yNCAxMDozNCwgYW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToNCj4g
U3VuLCBGZWIgMTEsIDIwMjQgYXQgMDg6NDY6MTJQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSBraXJq
b2l0dGk6DQo+PiBIaSBCbGlua2VubGlnaHQgZW50aHVzaWFzdHMsDQo+Pg0KPj4gSSdtIGxvb2tp
bmcgZm9yIHNvbWV0aGluZyB0aGF0IEkgZmlndXJlZCBtdXN0IGV4aXN0cyBidXQgbWF5YmUgaXQn
cyBzbw0KPj4gbmljaGUgdGhhdCBuby1vbmUgaGFzIGJvdGhlcmVkIHRvIHVwc3RyZWFtIGEgZHJp
dmVyIGZvciBpdC4NCj4+DQo+PiBJIGhhdmUgYSByZXF1aXJlbWVudCB0byBzdXBwb3J0IGEgNy1z
ZWdtZW50IExFRCBkaXNwbGF5WzFdIChvbmUgdGhhdCBjYW4NCj4+IGRpc3BsYXkgYSBzaW5nbGUg
ZGlnaXQgZnJvbSAwLTkpLiBIYXJkd2FyZSB3aXNlIGl0J3MganVzdCBhIGJ1bmNoIG9mDQo+PiBp
bmRpdmlkdWFsIEdQSU9zIGNvbm5lY3RlZCB0byBlYWNoIHNlZ21lbnQgKHBsdXMgYW4gZXh0cmEg
b25lIGZvciBhDQo+PiBkb3QpLiBJIGNhbid0IHNlZSBhbnl0aGluZyBvYnZpb3VzIGluIGRyaXZl
cnMvbGVkcyBidXQgbWF5YmUgSSdtIGxvb2tpbmcNCj4+IGluIHRoZSB3cm9uZyBwbGFjZS4gT3Ig
bWF5YmUgaXQncyB0aGUga2luZCBvZiB0aGluZyBvbiBQQyBoYXJkd2FyZSB0aGF0DQo+PiBpcyBq
dXN0IGRyaXZlbiBieSB0aGUgQklPUyB3aXRob3V0IHRoZSBvcGVyYXRpbmcgc3lzdGVtIGtub3dp
bmcgYWJvdXQgaXQuDQo+Pg0KPj4gSXMgdGhlcmUgYW4gZXhpc3RpbmcgaW4ta2VybmVsIGRyaXZl
ciBmb3Igc3VjaCBhIHRoaW5nPw0KPiBObywgYW5kIGNhbid0IGJlLiBIZXJlIGlzIGp1c3QgYSBt
YXBwaW5nIHRhYmxlIGFuZCBvdGhlciBkcml2ZXJzIHRoYXQgdXNlDQo+IDctc2VnbWVudCBMRUQg
ZGlzcGxheXMgdG8gYmUgY29ubmVjdGVkIHRvLg0KPg0KPiBXaGF0IHlvdSBuZWVkIGlzIHNvbWV0
aGluZyBlbHNlLCBpLmUuIHNwZWNpYWwgY2FzZSBvZiBsZWRzLWdwaW8gKHdoaWNoIHNob3VsZA0K
PiBiZSBzb21ld2hlcmUgZWxzZSkgdGhhdCBkb2VzIHNvbWV0aGluZyBsaWtlIHRoaXMuIFRvIG1l
IGl0IHNvdW5kcyBsaWtlIGENCj4gbWl4dHVyZSBiZXR3ZWVuIGxpbmUtZGlzcGxheS5oIChmcm9t
IGF1eGRpc3BsYXkpIGFuZCBncGlvLWFnZ3JlZ2F0b3IuDQo+DQo+IEhvdyBtYW55IGRpZ2l0cyBk
byB5b3Ugd2FudCB0byBjb25uZWN0PyBIb3cgYXJlIHRoZXkgZ29pbmcgdG8gYmUgY29ubmVjdGVk
DQo+IChzdGF0aWMgZGlzcGxheSwgb3IgZHluYW1pYyB3aGVuIHlvdSBuZWVkIHRvIHJlZnJlc2gg
aW4gY2VydGFpbiBwZXJpb2RzIG9mDQo+IHRpbWUpPyBEZXBlbmRpbmcgb24gdGhlIGFuc3dlciBp
dCBtaWdodCB0YWtlIG9uZSBvciBhbm90aGVyIGFwcHJvYWNoLg0KDQpJdCBzb3VuZHMgbGlrZSBh
IGF1eGRpc3BsYXkgZHJpdmVyIG1pZ2h0IGJlIHRoZSB3YXkgdG8gZ28uIE15IGhhcmR3YXJlIA0K
aGFwcGVucyB0byBoYXZlIGEgc2luZ2xlIDdzZWcgYmxvY2sgYnV0IHRoZXJlJ3Mgbm8gcmVhc29u
IHRoZSBkcml2ZXIgDQpuZWVkcyB0byBiZSByZXN0cmljdGVkIHRvIHRoYXQuIEF0IHNvbWUgcG9p
bnQgaXQgb2J2aW91c2x5IGJlY29tZXMgDQpiZXR0ZXIgdG8gZml0IHNvbWV0aGluZyBsaWtlIHRo
ZSBodDE2azMzIHRvIG9mZmxvYWQgdGhlIGNoYXJhY3RlciANCmRpc3BsYXkgYnV0IGZvciBvbmUg
b3IgMiBkaWdpdHMgYSBQQ0E5NTN4IHBsdXMgdGhlIExFRCBibG9jayB3b3VsZCBkbyANCmp1c3Qg
ZmluZS4NCg0KVGhlIGluZm9ybWF0aW9uIHdlIHdhbnQgdG8gZGlzcGxheSBpcyBtb3N0bHkgc3Rh
dGljIChiYXNpY2FsbHkgYSBudW1lcmljIA0KdW5pdCBpZGVudGlmaWVyKSBidXQgdGhlcmUgYXJl
IGNhc2VzIHdoZXJlIHdlIG1heSB3YW50IHRvIGFsdGVybmF0ZSANCmJldHdlZW4gdGhpcyBhbmQg
IkYiIHRvIGluZGljYXRlIHNvbWUgZmF1bHQgY29uZGl0aW9uLg0K

