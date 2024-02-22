Return-Path: <linux-kernel+bounces-77448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7886056F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCCD287678
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D404512D21C;
	Thu, 22 Feb 2024 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Oxo74ydO"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD714B81E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639720; cv=none; b=i2vo22TGxZCb/Z4FjRdjEF0NRq+wVOWWeEC6Dgy11nSW7eszmMFM7YZT8c5GpEOeYOgTgUwQF09Tz2O9xuEFRKY8Qo+J/HKTRzkoFcBdmg8vjyP50oE3u+gMCQINARdSJ1NEKYIlcEznDf68YeWQa23D0Xbr2d8znk+xreV2g5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639720; c=relaxed/simple;
	bh=Tx8RCMPEpa9lmNVucWuuXOs8ydZRP2sri7PPKIHVxuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CnsFHKTFjq45eBw0dms3lelJ/zm9gabaUWRf/Cgl8UF5X4h2zeIfPlQIwc+lh6rLFNmGHXeiX3hhL67V0EvblFPgx0usPqWGyJ7FruPtobcYzf5lSchkm3q3HLRtdxK8ouRwkyXBEI4hDJXg2XDnfleJ5nS9RoP8g8lVdnZtkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Oxo74ydO; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 242AF2C05EA;
	Fri, 23 Feb 2024 11:08:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708639716;
	bh=Tx8RCMPEpa9lmNVucWuuXOs8ydZRP2sri7PPKIHVxuY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Oxo74ydOfgc3tycmKaw0+TxQwJ0kqT/tjyJrbqbqGMx1TybuWCyrwt7eJddsITWx7
	 kvodz7ILxVcwUCuBPXG3TSW+6p0v49PIJL4Fr4+zkbo4zYeTrjYb39VVlwCS4DGwF2
	 iyG+HAs6jMmRBOCGGP37o9JQR2GCsg/hjY0kDPEuqkSvKQ8HcpCV4KTAjuESRkKK00
	 ATG+gGZ6Vj3cue5eSf6hjIGaevarsPh1CWuLtxKDXY5vVRUReaZ3ZoHAMPGFVIGbA6
	 9a0mN+j4tPcJwm753wTrVwetK08UNxGEvoRzR0PT//M674S3aRTlZS2kSadtF46Qo3
	 2akTb+rDNJQ0w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d7c5e40000>; Fri, 23 Feb 2024 11:08:36 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 11:08:35 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Feb 2024 11:08:35 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 23 Feb 2024 11:08:35 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Pavel Machek <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Thread-Topic: Linux support for a 7 segment LED display
Thread-Index: AQHaXStZfYl8Vw6dm0yz1EAjpP4fVbEWGZeAgAAFVoCAAAGlAIAAAoWA
Date: Thu, 22 Feb 2024 22:08:35 +0000
Message-ID: <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain>
 <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
In-Reply-To: <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C48A7FB9DB3C444A0FF566E32D76E71@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d7c5e4 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=pGLkceISAAAA:8 a=BwnNMnuW0JF0vIrjb1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=t7wjxaoyUiyY0pDiBwSR:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAyMy8wMi8yNCAxMDo1OSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUaHUsIEZl
YiAyMiwgMjAyNCBhdCAxMTo1M+KAr1BNIENocmlzIFBhY2toYW0NCj4gPENocmlzLlBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+PiBPbiAyMy8wMi8yNCAxMDozNCwgYW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToNCj4+PiBTdW4sIEZlYiAxMSwgMjAyNCBhdCAwODo0
NjoxMlBNICswMDAwLCBDaHJpcyBQYWNraGFtIGtpcmpvaXR0aToNCj4+Pj4gSGkgQmxpbmtlbmxp
Z2h0IGVudGh1c2lhc3RzLA0KPj4+Pg0KPj4+PiBJJ20gbG9va2luZyBmb3Igc29tZXRoaW5nIHRo
YXQgSSBmaWd1cmVkIG11c3QgZXhpc3RzIGJ1dCBtYXliZSBpdCdzIHNvDQo+Pj4+IG5pY2hlIHRo
YXQgbm8tb25lIGhhcyBib3RoZXJlZCB0byB1cHN0cmVhbSBhIGRyaXZlciBmb3IgaXQuDQo+Pj4+
DQo+Pj4+IEkgaGF2ZSBhIHJlcXVpcmVtZW50IHRvIHN1cHBvcnQgYSA3LXNlZ21lbnQgTEVEIGRp
c3BsYXlbMV0gKG9uZSB0aGF0IGNhbg0KPj4+PiBkaXNwbGF5IGEgc2luZ2xlIGRpZ2l0IGZyb20g
MC05KS4gSGFyZHdhcmUgd2lzZSBpdCdzIGp1c3QgYSBidW5jaCBvZg0KPj4+PiBpbmRpdmlkdWFs
IEdQSU9zIGNvbm5lY3RlZCB0byBlYWNoIHNlZ21lbnQgKHBsdXMgYW4gZXh0cmEgb25lIGZvciBh
DQo+Pj4+IGRvdCkuIEkgY2FuJ3Qgc2VlIGFueXRoaW5nIG9idmlvdXMgaW4gZHJpdmVycy9sZWRz
IGJ1dCBtYXliZSBJJ20gbG9va2luZw0KPj4+PiBpbiB0aGUgd3JvbmcgcGxhY2UuIE9yIG1heWJl
IGl0J3MgdGhlIGtpbmQgb2YgdGhpbmcgb24gUEMgaGFyZHdhcmUgdGhhdA0KPj4+PiBpcyBqdXN0
IGRyaXZlbiBieSB0aGUgQklPUyB3aXRob3V0IHRoZSBvcGVyYXRpbmcgc3lzdGVtIGtub3dpbmcg
YWJvdXQgaXQuDQo+Pj4+DQo+Pj4+IElzIHRoZXJlIGFuIGV4aXN0aW5nIGluLWtlcm5lbCBkcml2
ZXIgZm9yIHN1Y2ggYSB0aGluZz8NCj4+PiBObywgYW5kIGNhbid0IGJlLiBIZXJlIGlzIGp1c3Qg
YSBtYXBwaW5nIHRhYmxlIGFuZCBvdGhlciBkcml2ZXJzIHRoYXQgdXNlDQo+Pj4gNy1zZWdtZW50
IExFRCBkaXNwbGF5cyB0byBiZSBjb25uZWN0ZWQgdG8uDQo+Pj4NCj4+PiBXaGF0IHlvdSBuZWVk
IGlzIHNvbWV0aGluZyBlbHNlLCBpLmUuIHNwZWNpYWwgY2FzZSBvZiBsZWRzLWdwaW8gKHdoaWNo
IHNob3VsZA0KPj4+IGJlIHNvbWV3aGVyZSBlbHNlKSB0aGF0IGRvZXMgc29tZXRoaW5nIGxpa2Ug
dGhpcy4gVG8gbWUgaXQgc291bmRzIGxpa2UgYQ0KPj4+IG1peHR1cmUgYmV0d2VlbiBsaW5lLWRp
c3BsYXkuaCAoZnJvbSBhdXhkaXNwbGF5KSBhbmQgZ3Bpby1hZ2dyZWdhdG9yLg0KPj4+DQo+Pj4g
SG93IG1hbnkgZGlnaXRzIGRvIHlvdSB3YW50IHRvIGNvbm5lY3Q/IEhvdyBhcmUgdGhleSBnb2lu
ZyB0byBiZSBjb25uZWN0ZWQNCj4+PiAoc3RhdGljIGRpc3BsYXksIG9yIGR5bmFtaWMgd2hlbiB5
b3UgbmVlZCB0byByZWZyZXNoIGluIGNlcnRhaW4gcGVyaW9kcyBvZg0KPj4+IHRpbWUpPyBEZXBl
bmRpbmcgb24gdGhlIGFuc3dlciBpdCBtaWdodCB0YWtlIG9uZSBvciBhbm90aGVyIGFwcHJvYWNo
Lg0KPj4gSXQgc291bmRzIGxpa2UgYSBhdXhkaXNwbGF5IGRyaXZlciBtaWdodCBiZSB0aGUgd2F5
IHRvIGdvLiBNeSBoYXJkd2FyZQ0KPj4gaGFwcGVucyB0byBoYXZlIGEgc2luZ2xlIDdzZWcgYmxv
Y2sgYnV0IHRoZXJlJ3Mgbm8gcmVhc29uIHRoZSBkcml2ZXINCj4+IG5lZWRzIHRvIGJlIHJlc3Ry
aWN0ZWQgdG8gdGhhdC4gQXQgc29tZSBwb2ludCBpdCBvYnZpb3VzbHkgYmVjb21lcw0KPj4gYmV0
dGVyIHRvIGZpdCBzb21ldGhpbmcgbGlrZSB0aGUgaHQxNmszMyB0byBvZmZsb2FkIHRoZSBjaGFy
YWN0ZXINCj4+IGRpc3BsYXkgYnV0IGZvciBvbmUgb3IgMiBkaWdpdHMgYSBQQ0E5NTN4IHBsdXMg
dGhlIExFRCBibG9jayB3b3VsZCBkbw0KPj4ganVzdCBmaW5lLg0KPiBJIGhhdmUgaGM1OTUgKFNQ
SSBHUElPKSBjb25uZWN0ZWQgdG8gYSBzaW5nbGUgZGlnaXQgNy1zZWdtZW50IExFRC4NCj4gU2lu
Y2UgaXQgY2FuIGJlIGFsc28gc2VyaWFsaXplZCwgbGluZSBkaXNwbGF5IEFQSXMgc2VlbSBwbGF1
c2libGUgdG8NCj4gZml0LiBXaGF0IHdlIG5lZWQgaXMgYSBwcm94eSBiZXR3ZWVuIHRoZSB0d28u
IEFuZCBJIHRoaW5rDQo+IGdwaW8tYWdncmVnYXRvciBpcyB0aGUgYmVzdCBmb3IgdGhhdC4gSXQg
bmVlZHMgYW4gYWRkaXRpb25hbA0KPiBjb21wYXRpYmxlIHN0cmluZyBhbmQgdGhlIHJlZ2lzdHJh
dGlvbiBmb3IgbGluZSBkaXNwbGF5IChvdmVyYWxsDQo+IHNvbWV0aGluZyBsaWtlIDUwIExvQ3Mp
LiBXZSBjYW4gZXZlbiBjYWxsIHRoYXQgaGFyZHdhcmUgY29tcGF0aWJsZSBhcw0KPiBsaW5lLWRp
c3BsYXktZ3BpbyAob3Igc28pLg0KPg0KPiBDYzogR2VlcnQgYW5kIEtyenlzenRvZiAoZm9yIHRo
ZSBjb21tZW50cyBvbiB0aGUgaWRlYSBhYm92ZSkuDQoNCldvdWxkIHRoZSBncGlvLWFnZ3JlZ2F0
b3IgYmUgbmVjZXNzYXJ5PyBJIHdhcyB0aGlua2luZyBzb21ldGhpbmcgbGlrZSANCnRoaXMgaW4g
dGhlIGRldmljZXRyZWUNCg0KXHsNCiDCoMKgwqAgbGVkLTdzZWcgew0KIMKgwqDCoCDCoMKgwqAg
Y29tcGF0aWJsZSA9ICJraW5nYnJpZ2h0LHNhMzYiOw0KIMKgwqDCoMKgwqDCoMKgIHNlZy1ncGlv
cyA9IDwmZ3Bpb04gMCBHUElPX0FDVElWRV9ISUdIPiwNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCA8
JmdwaW9OIDEgR1BJT19BQ1RJVkVfSElHSD4sDQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgPCZncGlv
TiAyIEdQSU9fQUNUSVZFX0hJR0g+LA0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIDwmZ3Bpb04gMyBH
UElPX0FDVElWRV9ISUdIPiwNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCA8JmdwaW9OIDQgR1BJT19B
Q1RJVkVfSElHSD4sDQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgPCZncGlvTiA1IEdQSU9fQUNUSVZF
X0hJR0g+LA0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIDwmZ3Bpb04gNiBHUElPX0FDVElWRV9ISUdI
PjsNCiDCoMKgwqAgfTsNCn07DQoNCj4NCj4+IFRoZSBpbmZvcm1hdGlvbiB3ZSB3YW50IHRvIGRp
c3BsYXkgaXMgbW9zdGx5IHN0YXRpYyAoYmFzaWNhbGx5IGEgbnVtZXJpYw0KPj4gdW5pdCBpZGVu
dGlmaWVyKSBidXQgdGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIG1heSB3YW50IHRvIGFsdGVybmF0
ZQ0KPj4gYmV0d2VlbiB0aGlzIGFuZCAiRiIgdG8gaW5kaWNhdGUgc29tZSBmYXVsdCBjb25kaXRp
b24uDQo+

