Return-Path: <linux-kernel+bounces-49035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001D846514
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67934B21710
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047B137B;
	Fri,  2 Feb 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YRVx3k6h"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D910F2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833744; cv=none; b=Hs/vJsmcuvD0sD6rH+uD6x/3dDjIbqOXhjaX8GCMWofzmtGYTWbNTp9CJzbMJA1TvxEykmVL77R9xK01GlGgyTiA7YdiEb1ZpEQzxB4j+tKOA5irjO+bunAzW5l4zXjugdA2R+G5QKTxwdC+2lYPBEgkLF4Wg5xTkhj/8QJAqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833744; c=relaxed/simple;
	bh=mpV+cPmML3Jk+/Tuf2IR1WVkBy6cc/QDf4lHr7ZmniI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rR3xEy33Zm9HETNTRPwQhXjGnHZytMjjRaUXd7odt84b5jL5ht7z5RP78vd7hepuSoDKZKbiF+EGcnWDi21YSewTRsTtF60DS+4ngf4JIzjCfwtPKqnB0Exl8KUVFlTPWMmromK85xBNKiine01+Kgwg8jwrBbRL9OLlLtOkT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=YRVx3k6h; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9B3362C0362;
	Fri,  2 Feb 2024 13:28:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1706833732;
	bh=mpV+cPmML3Jk+/Tuf2IR1WVkBy6cc/QDf4lHr7ZmniI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YRVx3k6hiE/5oHswxkWaJ2DEEXEHro9ARHiM/faZemR788Jpj7qLOIy3ZPfMilN30
	 PwAqQ1h36a2MWycmFSBwZVQ6zNsg24ZCuV1yC5FqDcnmUoGZ8GCC3IQSPpnvff2xn2
	 bKbhna/Lg8SMcPGp9Qc3HhCaf7PNclilVmDfhzFQzKFq9fM10NeXZHJIwo3Yj306Un
	 IMmZgFxyl5XOaZ9lLwzEVmuI1DeyoYj/nD/bZGNQbEWdJ3AtQU9R3aaQiU6id3PCov
	 jKoBmsU7bkeFqve+9jq0BGzEz8cd7m/iC/EJaw9bNbv7/xhIw+ZvhErAKyRb4/X58m
	 TthxVLy2UacCw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65bc37440001>; Fri, 02 Feb 2024 13:28:52 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 13:28:52 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 2 Feb 2024 13:28:52 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "antoniu.miclaus@analog.com"
	<antoniu.miclaus@analog.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHaT/57pfs9+wriS028zs2/xPWJR7Dq3xGAgARtWACAAErGAIAFzH2A
Date: Fri, 2 Feb 2024 00:28:52 +0000
Message-ID: <c69ab341-468a-4bca-96b7-793342c421a7@alliedtelesis.co.nz>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
 <1b42866bb6f05b7d68e9b8304e42359fccdf2bad.camel@gmail.com>
 <170c8d6b-3246-493f-8cd9-6ac580cabc28@alliedtelesis.co.nz>
 <84827fd6461c9650443608e33afe9eb011793656.camel@gmail.com>
In-Reply-To: <84827fd6461c9650443608e33afe9eb011793656.camel@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <97DB4FBBE2A3344DB1A6742C47561F68@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=QyXUC8HyAAAA:8 a=npl0IYgviOQm-zOkIj0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOS8wMS8yNCAyMDo1NSwgTnVubyBTw6Egd3JvdGU6DQo+IE9uIE1vbiwgMjAyNC0wMS0y
OSBhdCAwMzoyOCArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IE9uIDI2LzAxLzI0IDIw
OjUxLCBOdW5vIFPDoSB3cm90ZToNCj4+PiBPbiBGcmksIDIwMjQtMDEtMjYgYXQgMDI6MjIgKzAw
MDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+IEhpIEFsbCwNCj4+Pj4NCj4+Pj4gT24gNC8w
NC8yMyAwMzo0MywgSWJyYWhpbSBUaWxraSB3cm90ZToNCj4+Pj4+IGNoYW5nZWxvZzoNCj4+Pj4+
IHNpbmNlIHY1Og0KPj4+Pj4gIMKgwqDCoCAtIGR0LWJpbmRpbmc6IGFkZCBlbnVtIHZhbHVlICIy
IiB0byBhdXgtdm9sdGFnZS1jaGFyZ2FibGUNCj4+Pj4+ICDCoMKgwqAgLSBkdC1iaW5kaW5nOiBy
ZW1vdmUgYWRpLHRyaWNrbGUtZGlvZGUtZW5hYmxlDQo+Pj4+PiAgwqDCoMKgIC0gZHQtYmluZGlu
ZzogY2hhbmdlIGRlc2NyaXB0aW9uIG9mIHRyaWNrbGUtcmVzaXN0b3Itb2htcw0KPj4+Pj4gIMKg
wqDCoCAtIGR0LWJpbmRpbmc6IHJlb3JkZXIgYXMgaW4gZXhhbXBsZSBzY2hlbWENCj4+Pj4+ICDC
oMKgwqAgLSBwYXJzZSAid2FrZXVwLXNvdXJjZSIgd2hlbiBpcnEgbm90IHJlcXVlc3RlZA0KPj4+
Pj4gIMKgwqDCoCAtIHJlbW92ZSBsaW1pdGF0aW9uIG9uIG1heDMxMzI4IGlycSBhbmQgY2xva291
dA0KPj4+Pj4gIMKgwqDCoCAtIHJlbW92ZSBlcnJvciBhbmQgd2FybmluZyBtZXNzYWdlcyBkdXJp
bmcgdHJpY2tsZSBjaGFyZ2VyIHNldHVwDQo+Pj4+Pg0KPj4+Pj4gc2luY2UgdjQ6DQo+Pj4+PiAg
wqDCoMKgIC0gZHQtYmluZGluZzogcmVtb3ZlIGludGVycnVwdCBuYW1lcy4NCj4+Pj4+ICDCoMKg
wqAgLSBkdC1iaW5kaW5nOiBhZGQgZGVzY3JpcHRpb24gZm9yICJpbnRlcnJ1cHRzIiBwcm9wZXJ0
eQ0KPj4+Pj4gIMKgwqDCoCAtIGR0LWJpbmRpbmc6IHJlcGxhY2UgZGVwcmVjYXRlZCBwcm9wZXJ0
eSAidHJpY2tsZS1kaW9kZS1kaXNhYmxlIg0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgIGJ5ICJhdXgt
dm9sdGFnZS1jaGFyZ2VhYmxlIg0KPj4+Pj4gIMKgwqDCoCAtIGR0LWJpbmRpbmc6IGFkZCBuZXcg
cHJvcGVydHkgImFkaSx0cmlja2xlLWRpb2RlLWVuYWJsZSINCj4+Pj4+ICDCoMKgwqAgLSBkdC1i
aW5kaW5nOiByZW1vdmUgIndha2V1cC1zb3VyY2UiDQo+Pj4+PiAgwqDCoMKgIC0gdXNlIGNsZWFy
X2JpdCBpbnN0ZWFkIG9mIF9fY2xlYXJfYml0DQo+Pj4+PiAgwqDCoMKgIC0gdXNlIGRldm1fb2Zf
Y2xrX2FkZF9od19wcm92aWRlciBpbnN0ZWFkIG9mIG9mX2Nsa19hZGRfcHJvdmlkZXINCj4+Pj4+
ICDCoMKgwqAgLSB1c2UgY2hpcF9kZXNjIHBvaW50ZXIgYXMgZHJpdmVyIGRhdGEgaW5zdGVhZCBv
ZiBlbnVtLg0KPj4+Pj4NCj4+Pj4+IHNpbmNlIHYzOg0KPj4+Pj4gIMKgwqDCoCAtIGFkZCAiYnJl
YWsiIHRvIGZpeCB3YXJuaW5nOiB1bmFubm90YXRlZCBmYWxsLXRocm91Z2gNCj4+Pj4+ICDCoMKg
wqDCoMKgIFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+
Pj4+DQo+Pj4+PiBzaW5jZSB2MjoNCj4+Pj4+ICDCoMKgwqAgLSBkdC1iaW5kaW5nOiB1cGRhdGUg
dGl0bGUgYW5kIGRlc2NyaXB0aW9uDQo+Pj4+PiAgwqDCoMKgIC0gZHQtYmluZGluZzogcmVtb3Zl
IGxhc3QgZXhhbXBsZQ0KPj4+Pj4gIMKgwqDCoCAtIGRyb3Agd2F0Y2hkb2cgc3VwcG9ydA0KPj4+
Pj4gIMKgwqDCoCAtIHN1cHBvcnQgcmVhZGluZyAxMkhyIGZvcm1hdCBpbnN0ZWFkIG9mIGZvcmNp
bmcgMjRociBhdCBwcm9iZSB0aW1lDQo+Pj4+PiAgwqDCoMKgIC0gdXNlICJ0bV95ZWFyICUgMTAw
IiBpbnN0ZWFkIG9mIHJhbmdlIGNoZWNrDQo+Pj4+PiAgwqDCoMKgIC0gcmVmYWN0b3IgbWF4MzEz
eHhfaW5pdCBmb3IgcmVhZGFiaWxpdHkNCj4+Pj4+DQo+Pj4+PiBJYnJhaGltIFRpbGtpICgyKToN
Cj4+Pj4+ICDCoMKgwqAgZHJpdmVyczogcnRjOiBhZGQgbWF4MzEzeHggc2VyaWVzIHJ0YyBkcml2
ZXINCj4+Pj4+ICDCoMKgwqAgZHQtYmluZGluZ3M6IHJ0YzogYWRkIG1heDMxM3h4IFJUQ3MNCj4+
Pj4+DQo+Pj4+PiAgwqDCoCAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYWRpLG1heDMxM3h4
LnlhbWwgfMKgIDE0NCArKysNCj4+Pj4+ICDCoMKgIGRyaXZlcnMvcnRjL0tjb25maWfCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDExICsN
Cj4+Pj4+ICDCoMKgIGRyaXZlcnMvcnRjL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCAxICsNCj4+Pj4+ICDCoMKgIGRyaXZl
cnMvcnRjL3J0Yy1tYXgzMTN4eC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxMDUzDQo+Pj4+PiArKysrKysrKysrKysrKysrKw0KPj4+Pj4gIMKgwqAgNCBmaWxlcyBj
aGFuZ2VkLCAxMjA5IGluc2VydGlvbnMoKykNCj4+Pj4+ICDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPj4+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hZGksbWF4MzEz
eHgueWFtbA0KPj4+Pj4gIMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcnRjL3J0Yy1t
YXgzMTN4eC5jDQo+Pj4+IFdoYXQgaGFwcGVuZWQgdG8gdGhpcyBzZXJpZXMgaW4gdGhlIGVuZD8g
SXQga2luZCBvZiB3ZW50IG9mZiBteSByYWRhcg0KPj4+PiBhbmQgSSBmb3Jnb3QgYWJvdXQgaXQu
DQo+Pj4+DQo+Pj4+IFdlJ3ZlIGJlZW4gY2FycnlpbmcgYSB2ZXJzaW9uIG9mIHRoZXNlIGNoYW5n
ZXMgaW4gb3VyIGxvY2FsIHRyZWUgZm9yIGENCj4+Pj4gd2hpbGUgKGFuZCB1c2luZyBpdCBxdWl0
ZSBoYXBwaWx5IEkgc2hvdWxkIGFkZCkuDQo+Pj4+DQo+Pj4gSGkgQ2hyaXMsDQo+Pj4NCj4+PiBB
bHNvIG5vdCBzdXJlLi4uLiBJbiB0aGUgbWVhbnRpbWUgSWJyYWhpbSBsZWZ0IEFESSBzbyBpZiB0
aGlzIGlzIG5vdCBpbg0KPj4+IHNoYXBlIHRvDQo+Pj4gYmUgbWVyZ2VkIGhlIHdvbid0IGJlIGFi
bGUgdG8gcmUtc3Bpbi4gSWYgdGhlcmUncyBhIG5lZWQgZm9yIGEgcmUtc3BpbiwNCj4+PiBwbGVh
c2UNCj4+PiBsZXQgbWUga25vdyBzbyBJIGNhbiBzZWUgaW50ZXJuYWxseSBpZiB0aGVyZSdzIHNv
bWVvbmUgd2hvIGNhbiBjb250aW51ZSB0aGlzDQo+Pj4gd29yay4gSSB3b3VsZCBkbyBpdCBteXNl
bGYgaWYgSSBoYWQgdGhlIEhXLg0KPj4gSSd2ZSBnb3QgYSBib2FyZCB3aXRoIGEgbWF4MzEzMzEg
c28gSSBjYW4gdGVzdCB0aGF0LiBJIGRvbid0IGhhdmUgYW55IG9mDQo+PiB0aGUgaW50ZXJydXB0
cyBob29rZWQgdXAgc28gSSB3b24ndCBiZSBhYmxlIHRvIHRlc3QgdGhhdC4gTG9va3MgbGlrZQ0K
Pj4gdGhlcmUgd2FzIHNvbWUgb3V0c3RhbmRpbmcgZGlzY3Vzc2lvbiBhcm91bmQgdGhlIHRyaWNr
bGUtY2hhcmdlDQo+PiBkZXZpY2V0cmVlIHByb3BlcnRpZXMgc28gSSdkIG5lZWQgdG8gZmlndXJl
IG91dCB3aGF0IHdhcyB3YW50ZWQgdGhlcmUuDQo+PiBJJ2xsIHRyeSB0byBwaWNrIHVwIHRoZSBs
YXN0IHNlcmllcyBmcm9tIHRoZSBtYWlsaW5nIGxpc3QgYW5kIGdvIGZyb20gdGhlcmUuDQoNCkkg
c2VlIHRoYXQgaW4gdGhlIG1lYW50aW1lIEFudG9uaXUgaGFzIGxhbmRlZCBhIG1heDMxMzM1IGRy
aXZlci4gRG9lcyANCmFueW9uZSBrbm93IG9mZi1oYW5kIGhvdyBjbG9zZSB0aGUgbWF4MzEzMzUg
aXMgdG8gdGhlIG90aGVyIG1heDMxM3h4IA0KdmFyaWFudHM/IFNob3VsZCBJIGxlYXZlIHRoZW0g
c2VwYXJhdGUgb3IgYXR0ZW1wdCB0byBpbnRlZ3JhdGUgdGhlIHR3by4NCg0K

