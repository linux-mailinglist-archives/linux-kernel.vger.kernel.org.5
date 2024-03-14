Return-Path: <linux-kernel+bounces-102911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF987B84B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70E21F213F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12AADDDA;
	Thu, 14 Mar 2024 07:08:24 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E349610E;
	Thu, 14 Mar 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400104; cv=none; b=UEMgPgN4JzSrqfyY3iwGtKtf2ZYicR4za0AsDp1plnf7Rby8KIE4ngawAjll7zfCUsLFBtsmVwwSwd5lDbpfum2nr+U+NcE8bVPQq/WGpXFl7ywGIfIyenTdD42Gy/OppprMeL2nZ2jY58BwxRqJ9pYzeMyfiHVlpZg3Hn1pNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400104; c=relaxed/simple;
	bh=VHQmqpvBmzUmxKyyeewCBIRvDYNSD5Sb7pCTFIjAXyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcSp/9MdygN+H3vM7x6bIjsTZyR0K+W4qh1uaAAtUIteqlhiVoTwOcCxJ0s+SqwOSMYO2Ekyxq/t6dhmh1DGdSU3xCSW6z9AVDeSCfK54FlGrseXMQlzpihpColaxDQmtezzHze5UFLFHn38yQASjTq7p3RRGnfy3IlaM8e9wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42E76L3B099275;
	Thu, 14 Mar 2024 15:06:21 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 582D3200BBEB;
	Thu, 14 Mar 2024 15:07:53 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 14 Mar 2024 15:06:22 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Thu, 14 Mar 2024 15:06:22 +0800
From: Liuye <liu.yeC@h3c.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZp?=
 =?gb2312?Q?x_the_deadlock_issue_in_KDB_debugging.?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUg?=
 =?gb2312?Q?deadlock_issue_in_KDB_debugging.?=
Thread-Index: AQHaafG3YC/Li+j42kau1FDQhHr2m7EfIsgAgAMadaD///fWgIAJrHcQgAeL+QCAAIb8YP//gGOAgAGAGvCAAFNzgIABn6DQ
Date: Thu, 14 Mar 2024 07:06:22 +0000
Message-ID: <56ed54fd241c462189d2d030ad51eac6@h3c.com>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan> <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan> <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
 <20240312102419.GC202685@aspen.lan>
 <410a443612e8441cb729c640a0d606c6@h3c.com>
 <20240313141745.GD202685@aspen.lan>
In-Reply-To: <20240313141745.GD202685@aspen.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 42E76L3B099275

Pk9uIFdlZCwgTWFyIDEzLCAyMDI0IGF0IDAxOjIyOjE3QU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDEwOjA0OjU0QU0gKzAwMDAsIExpdXllIHdyb3Rl
Og0KPj4gPj4gPk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDA4OjM3OjExQU0gKzAwMDAsIExpdXll
IHdyb3RlOg0KPj4gPj4gPj4gSSBrbm93IHRoYXQgeW91IHNhaWQgc2NoZWR1bGVfd29yayBpcyBu
b3QgTk1JIHNhdmUsIHdoaWNoIGlzIHRoZSANCj4+ID4+ID4+IGZpcnN0IGlzc3VlLiBQZXJoYXBz
IGl0IGNhbiBiZSBmaXhlZCB1c2luZyBpcnFfd29ya19xdWV1ZS4gQnV0IA0KPj4gPj4gPj4gZXZl
biBpZiBpcnFfd29ya19xdWV1ZSBpcyB1c2VkIHRvIGltcGxlbWVudCBpdCwgdGhlcmUgd2lsbCBz
dGlsbCANCj4+ID4+ID4+IGJlIGEgZGVhZGxvY2sgcHJvYmxlbSBiZWNhdXNlIHNsYXZlIGNwdTEg
c3RpbGwgaGFzIG5vdCByZWxlYXNlZCANCj4+ID4+ID4+IHRoZSBydW5uaW5nIHF1ZXVlIGxvY2sg
b2YgbWFzdGVyIENQVTAuDQo+PiA+PiA+DQo+PiA+PiA+VGhpcyBkb2Vzbid0IHNvdW5kIHJpZ2h0
IHRvIG1lLiBXaHkgZG8geW91IHRoaW5rIENQVTEgd29uJ3QgDQo+PiA+PiA+cmVsZWFzZSB0aGUg
cnVuIHF1ZXVlIGxvY2s/DQo+PiA+Pg0KPj4gPj4gSW4gdGhpcyBleGFtcGxlLCBDUFUxIGlzIHdh
aXRpbmcgZm9yIENQVTAgdG8gcmVsZWFzZSANCj4+ID4+IGRiZ19zbGF2ZV9sb2NrLg0KPj4gPg0K
Pj4gPlRoYXQgc2hvdWxkbid0IGJlIGEgcHJvYmxlbS4gQ1BVMCB3aWxsIGhhdmUgcmVsZWFzZWQg
dGhhdCBsb2NrIGJ5IHRoZSANCj4+ID50aW1lIHRoZSBpcnEgd29yayBpcyBkaXNwYXRjaGVkLg0K
Pj4NCj4+IFJlbGVhc2UgZGJnX3NsYXZlX2xvY2sgaW4gQ1BVMC4gQmVmb3JlIHRoYXQsIHNoY2Vk
dWxlX3dvcmsgbmVlZHMgdG8gYmUgDQo+PiBoYW5kbGVkLCBhbmQgd2UgYXJlIGJhY2sgdG8gdGhl
IHByZXZpb3VzIGlzc3VlLg0KPg0KPlNvcnJ5IGJ1dCBJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQg
d2hhdCBwcm9ibGVtIHlvdSB0aGluayBjYW4gaGFwcGVuIGhlcmUuIFdoYXQgaXMgd3Jvbmcgd2l0
aCBjYWxsaW5nIHNjaGVkdWxlX3dvcmsoKSBmcm9tIHRoZSBJUlEgd29yayBoYW5kbGVyPw0KPg0K
PkJvdGggaXJxX3dvcmtfcXVldWUoKSBhbmQgc2NoZWR1bGVfd29yaygpIGFyZSBjYWxscyB0byBx
dWV1ZSBkZWZlcnJlZCB3b3JrLiBJdCBkb2VzIG5vdCBtYXR0ZXIgd2hlbiB0aGUgd29yayBpcyBx
dWV1ZWQgKHByb3ZpZGluZyB3ZSBhcmUgbG9jayBzYWZlKS4gV2hhdCBtYXR0ZXJzIGlzIHdoZW4g
dGhlIHdvcmsgaXMgYWN0dWFsbHkgZXhlY3V0ZWQuDQo+DQo+UGxlYXNlIGNhbiB5b3UgZGVzY3Jp
YmUgdGhlIHByb2JsZW0geW91IHRoaW5rIGV4aXN0cyBiYXNlZCBvbiB3aGVuIHRoZSB3b3JrIGlz
IGV4ZWN1dGVkLg0KDQpDUFUwIGVudGVycyB0aGUgS0RCIHByb2Nlc3Mgd2hlbiBwcm9jZXNzaW5n
IHNlcmlhbCBwb3J0IGludGVycnVwdHMgYW5kIHRyaWdnZXJzIGFuIElQSSAoTk1JKSB0byBvdGhl
ciBDUFVzLiANCkFmdGVyIGVudGVyaW5nIGEgc3RhYmxlIHN0YXRlLCBDUFUwIGlzIGluIGludGVy
cnVwdCBjb250ZXh0LCB3aGlsZSBvdGhlciBDUFVzIGFyZSBpbiBOTUkgY29udGV4dC4gDQpCZWZv
cmUgb3RoZXIgQ1BVcyBlbnRlciBOTUkgY29udGV4dCwgdGhlcmUgaXMgYSBjaGFuY2UgdG8gb2J0
YWluIHRoZSBydW5uaW5nIHF1ZXVlIG9mIENQVTAuIA0KQXQgdGhpcyB0aW1lLCB3aGVuIENQVTAg
aXMgcHJvY2Vzc2luZyBrZ2Rib2NfcmVzdG9yZV9pbnB1dCwgY2FsbGluZyBzY2hlZHVsZV93b3Jr
LCBuZWVkX21vcmVfd29ya2VyIGhlcmUgZGV0ZXJtaW5lcyB0aGUgY2hhbmNlIHRvIHdha2UgdXAg
cHJvY2Vzc2VzIG9uIHN5c3RlbV93cS4gDQpUaGlzIHdpbGwgY2F1c2UgQ1BVMCB0byBhY3F1aXJl
IHRoZSBydW5uaW5nIHF1ZXVlIGxvY2sgb2YgdGhpcyBjb3JlLCB3aGljaCBpcyBoZWxkIGJ5IG90
aGVyIENQVXMuIA0KYnV0IG90aGVyIENQVXMgYXJlIHN0aWxsIGluIE5NSSBjb250ZXh0IGFuZCBo
YXZlIG5vdCBleGl0ZWQgYmVjYXVzZSB3YWl0aW5nIGZvciBDUFUwIHRvIHJlbGVhc2UgdGhlIGRi
Z19zbGF2ZV9sb2NrIGFmdGVyIHNjaGVkdWxlX3dvcmsuDQoNCkFmdGVyIHRoaW5raW5nIGFib3V0
IGl0LCB0aGUgcHJvYmxlbSBpcyBub3Qgd2hldGhlciBzY2hlZHVsZV93b3JrIGlzIE5NSSBzYWZl
LCBidXQgdGhhdCBwcm9jZXNzZXMgb24gc3lzdGVtX3dxIHNob3VsZCBub3QgYmUgYXdha2VuZWQg
aW1tZWRpYXRlbHkgd2hlbiBzY2hlZHVsZV93b3JrIGlzIGNhbGxlZC4gDQpJIHJlcGxhY2VkIHNj
aGVkdWxlX3dvcmsgd2l0aCBzY2hlZHVsZV9kZWxheWVkX3dvcmssIGFuZCB0aGlzIHNvbHZlZCBt
eSBwcm9ibGVtLg0KDQpUaGUgbmV3IHBhdGNoIGlzIGFzIGZvbGxvd3M6DQoNCkluZGV4OiBkcml2
ZXJzL3R0eS9zZXJpYWwva2dkYm9jLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBkcml2ZXJzL3R0eS9zZXJp
YWwva2dkYm9jLmMgKHJldmlzaW9uIDU3ODYyKQ0KKysrIGRyaXZlcnMvdHR5L3NlcmlhbC9rZ2Ri
b2MuYyAod29ya2luZyBjb3B5KQ0KQEAgLTkyLDEyICs5MiwxMiBAQA0KICAgICAgICBtdXRleF91
bmxvY2soJmtnZGJvY19yZXNldF9tdXRleCk7DQogfQ0KDQotc3RhdGljIERFQ0xBUkVfV09SSyhr
Z2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrLCBrZ2Rib2NfcmVzdG9yZV9pbnB1dF9oZWxwZXIpOw0K
K3N0YXRpYyBERUNMQVJFX0RFTEFZRURfV09SSyhrZ2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrLCBr
Z2Rib2NfcmVzdG9yZV9pbnB1dF9oZWxwZXIpOw0KDQogc3RhdGljIHZvaWQga2dkYm9jX3Jlc3Rv
cmVfaW5wdXQodm9pZCkNCiB7DQogICAgICAgIGlmIChsaWtlbHkoc3lzdGVtX3N0YXRlID09IFNZ
U1RFTV9SVU5OSU5HKSkNCi0gICAgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCZrZ2Rib2NfcmVz
dG9yZV9pbnB1dF93b3JrKTsNCisgICAgICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmso
JmtnZGJvY19yZXN0b3JlX2lucHV0X3dvcmssMipIWik7DQogfQ0KDQogc3RhdGljIGludCBrZ2Ri
b2NfcmVnaXN0ZXJfa2JkKGNoYXIgKipjcHRyKQ0KQEAgLTEyOCw3ICsxMjgsNyBAQA0KICAgICAg
ICAgICAgICAgICAgICAgICAgaS0tOw0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KLSAg
ICAgICBmbHVzaF93b3JrKCZrZ2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrKTsNCisgICAgICAgZmx1
c2hfZGVsYXllZF93b3JrKCZrZ2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrKTsNCiB9DQogI2Vsc2Ug
LyogISBDT05GSUdfS0RCX0tFWUJPQVJEICovDQogI2RlZmluZSBrZ2Rib2NfcmVnaXN0ZXJfa2Jk
KHgpIDANCg==

