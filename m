Return-Path: <linux-kernel+bounces-104236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F196C87CB08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AADF28443E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884B1804F;
	Fri, 15 Mar 2024 10:00:27 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754B18622;
	Fri, 15 Mar 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496826; cv=none; b=i8bYbn9XA4FIeJSwz7+BSfOf0MjsjjmlhPDp/dNa7ddeyaWLoM7BLG9EUh0AojaZx3CQQV+nvMFi23KNW6ybD6ZMQg2IHsuT8UAmgUpiGz/9o5vsDTQEtW+a83UwETYZkVXKk7tI6KLFCsRY2Nc8WUSIasb1ibQIT8LFl0E3dKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496826; c=relaxed/simple;
	bh=/v8SprZqCNRj7ne2Yu30kI1h09rkuhN11RGZYRHLGfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bxT5DNt2MVy72oovdVrieqQ73vzrGqsiM6Ag4waUMZRtTpYiyFcUOPAtsYCZsBa2KNxfrLnHqSFdxM4pMbDM1Gc1j8fF1XaXRzomQroZPM7QT75q0b4n9zn6G943LYU8dyBtL5fqOnNVHYd0XaGQDRqIAfajY6rCXt7CchTeGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42F9x6i7048252;
	Fri, 15 Mar 2024 17:59:06 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id EB7F02329740;
	Fri, 15 Mar 2024 18:00:40 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 15 Mar 2024 17:59:08 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Fri, 15 Mar 2024 17:59:08 +0800
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
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBr?=
 =?gb2312?Q?db:_Fix_the_deadlock_issue_in_KDB_debugging.?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZp?=
 =?gb2312?Q?x_the_deadlock_issue_in_KDB_debugging.?=
Thread-Index: AQHaafG3YC/Li+j42kau1FDQhHr2m7EfIsgAgAMadaD///fWgIAJrHcQgAeL+QCAAIb8YP//gGOAgAGAGvCAAFNzgIABn6DQ///fkwAAPGYiUA==
Date: Fri, 15 Mar 2024 09:59:08 +0000
Message-ID: <ae45b2736f364629afe6806c354cec14@h3c.com>
References: <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com> <20240301105931.GB5795@aspen.lan>
 <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
 <20240312102419.GC202685@aspen.lan>
 <410a443612e8441cb729c640a0d606c6@h3c.com>
 <20240313141745.GD202685@aspen.lan>
 <56ed54fd241c462189d2d030ad51eac6@h3c.com>
 <20240314130916.GE202685@aspen.lan>
In-Reply-To: <20240314130916.GE202685@aspen.lan>
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
X-MAIL:h3cspam02-ex.h3c.com 42F9x6i7048252

Pk9uIFRodSwgTWFyIDE0LCAyMDI0IGF0IDA3OjA2OjIyQU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPk9uIFdlZCwgTWFyIDEzLCAyMDI0IGF0IDAxOjIyOjE3QU0gKzAwMDAsIExpdXllIHdyb3Rl
Og0KPj4gPj4gPk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDEwOjA0OjU0QU0gKzAwMDAsIExpdXll
IHdyb3RlOg0KPj4gPj4gPj4gPk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDA4OjM3OjExQU0gKzAw
MDAsIExpdXllIHdyb3RlOg0KPj4gPj4gPj4gPj4gSSBrbm93IHRoYXQgeW91IHNhaWQgc2NoZWR1
bGVfd29yayBpcyBub3QgTk1JIHNhdmUsIHdoaWNoIGlzIA0KPj4gPj4gPj4gPj4gdGhlIGZpcnN0
IGlzc3VlLiBQZXJoYXBzIGl0IGNhbiBiZSBmaXhlZCB1c2luZyANCj4+ID4+ID4+ID4+IGlycV93
b3JrX3F1ZXVlLiBCdXQgZXZlbiBpZiBpcnFfd29ya19xdWV1ZSBpcyB1c2VkIHRvIA0KPj4gPj4g
Pj4gPj4gaW1wbGVtZW50IGl0LCB0aGVyZSB3aWxsIHN0aWxsIGJlIGEgZGVhZGxvY2sgcHJvYmxl
bSBiZWNhdXNlIA0KPj4gPj4gPj4gPj4gc2xhdmUgY3B1MSBzdGlsbCBoYXMgbm90IHJlbGVhc2Vk
IHRoZSBydW5uaW5nIHF1ZXVlIGxvY2sgb2YgDQo+PiA+PiA+PiA+PiBtYXN0ZXIgQ1BVMC4NCj4+
ID4+ID4+ID4NCj4+ID4+ID4+ID5UaGlzIGRvZXNuJ3Qgc291bmQgcmlnaHQgdG8gbWUuIFdoeSBk
byB5b3UgdGhpbmsgQ1BVMSB3b24ndCANCj4+ID4+ID4+ID5yZWxlYXNlIHRoZSBydW4gcXVldWUg
bG9jaz8NCj4+ID4+ID4+DQo+PiA+PiA+PiBJbiB0aGlzIGV4YW1wbGUsIENQVTEgaXMgd2FpdGlu
ZyBmb3IgQ1BVMCB0byByZWxlYXNlIA0KPj4gPj4gPj4gZGJnX3NsYXZlX2xvY2suDQo+PiA+PiA+
DQo+PiA+PiA+VGhhdCBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtLiBDUFUwIHdpbGwgaGF2ZSByZWxl
YXNlZCB0aGF0IGxvY2sgYnkgDQo+PiA+PiA+dGhlIHRpbWUgdGhlIGlycSB3b3JrIGlzIGRpc3Bh
dGNoZWQuDQo+PiA+Pg0KPj4gPj4gUmVsZWFzZSBkYmdfc2xhdmVfbG9jayBpbiBDUFUwLiBCZWZv
cmUgdGhhdCwgc2hjZWR1bGVfd29yayBuZWVkcyB0byANCj4+ID4+IGJlIGhhbmRsZWQsIGFuZCB3
ZSBhcmUgYmFjayB0byB0aGUgcHJldmlvdXMgaXNzdWUuDQo+PiA+DQo+PiA+IFNvcnJ5IGJ1dCBJ
IHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgd2hhdCBwcm9ibGVtIHlvdSB0aGluayBjYW4gaGFwcGVu
IA0KPj4gPiBoZXJlLiBXaGF0IGlzIHdyb25nIHdpdGggY2FsbGluZyBzY2hlZHVsZV93b3JrKCkg
ZnJvbSB0aGUgSVJRIHdvcmsgDQo+PiA+IGhhbmRsZXI/DQo+PiA+DQo+PiA+IEJvdGggaXJxX3dv
cmtfcXVldWUoKSBhbmQgc2NoZWR1bGVfd29yaygpIGFyZSBjYWxscyB0byBxdWV1ZSANCj4+ID4g
ZGVmZXJyZWQgd29yay4gSXQgZG9lcyBub3QgbWF0dGVyIHdoZW4gdGhlIHdvcmsgaXMgcXVldWVk
IChwcm92aWRpbmcgDQo+PiA+IHdlIGFyZSBsb2NrIHNhZmUpLiBXaGF0IG1hdHRlcnMgaXMgd2hl
biB0aGUgd29yayBpcyBhY3R1YWxseSBleGVjdXRlZC4NCj4+ID4NCj4+ID4gUGxlYXNlIGNhbiB5
b3UgZGVzY3JpYmUgdGhlIHByb2JsZW0geW91IHRoaW5rIGV4aXN0cyBiYXNlZCBvbiB3aGVuIA0K
Pj4gPiB0aGUgd29yayBpcyBleGVjdXRlZC4NCj4+DQo+PiBDUFUwIGVudGVycyB0aGUgS0RCIHBy
b2Nlc3Mgd2hlbiBwcm9jZXNzaW5nIHNlcmlhbCBwb3J0IGludGVycnVwdHMgYW5kIA0KPj4gdHJp
Z2dlcnMgYW4gSVBJIChOTUkpIHRvIG90aGVyIENQVXMuICBBZnRlciBlbnRlcmluZyBhIHN0YWJs
ZSBzdGF0ZSwNCj4+IENQVTAgaXMgaW4gaW50ZXJydXB0IGNvbnRleHQsIHdoaWxlIG90aGVyIENQ
VXMgYXJlIGluIE5NSSBjb250ZXh0Lg0KPj4gQmVmb3JlIG90aGVyIENQVXMgZW50ZXIgTk1JIGNv
bnRleHQsIHRoZXJlIGlzIGEgY2hhbmNlIHRvIG9idGFpbiB0aGUgDQo+PiBydW5uaW5nIHF1ZXVl
IG9mIENQVTAuDQo+DQo+Rm9jdXNpbmcgb24gdGhlIHJ1biBxdWV1ZSBsb2NrcyBpbiB0aGlzIGFu
YWx5c2lzIGlzIGEgbWlzdGFrZS4gQmVmb3JlIHRoZSBvdGhlciBDUFVzIGVudGVyIE5NSSBjb250
ZXh0IHRoZXJlIGlzIGEgY2hhbmNlIGZvciB0aGVtIHRvIG9idGFpbg0KPiphbnkqIGxvY2tzLCBp
bmNsdWRpbmcgdGhlIHRpbWVyIHdoZWVsIGxvY2tzLg0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuIEkg
ZGlkIG5vdCBjb25zaWRlciBpdCBjb21wcmVoZW5zaXZlbHkuDQoNCj4+IEF0IHRoaXMgdGltZSwg
d2hlbiBDUFUwIGlzIHByb2Nlc3Npbmcga2dkYm9jX3Jlc3RvcmVfaW5wdXQsIGNhbGxpbmcgDQo+
PiBzY2hlZHVsZV93b3JrLCBuZWVkX21vcmVfd29ya2VyIGhlcmUgZGV0ZXJtaW5lcyB0aGUgY2hh
bmNlIHRvIHdha2UgdXAgDQo+PiBwcm9jZXNzZXMgb24gc3lzdGVtX3dxLg0KPj4NCj4+IFRoaXMg
d2lsbCBjYXVzZSBDUFUwIHRvIGFjcXVpcmUgdGhlIHJ1bm5pbmcgcXVldWUgbG9jayBvZiB0aGlz
IGNvcmUsIA0KPj4gd2hpY2ggaXMgaGVsZCBieSBvdGhlciBDUFVzLiAgYnV0IG90aGVyIENQVXMg
YXJlIHN0aWxsIGluIE5NSSBjb250ZXh0IA0KPj4gYW5kIGhhdmUgbm90IGV4aXRlZCBiZWNhdXNl
IHdhaXRpbmcgZm9yIENQVTAgdG8gcmVsZWFzZSB0aGUgDQo+PiBkYmdfc2xhdmVfbG9jayBhZnRl
ciBzY2hlZHVsZV93b3JrLg0KPj4NCj4+IEFmdGVyIHRoaW5raW5nIGFib3V0IGl0LCB0aGUgcHJv
YmxlbSBpcyBub3Qgd2hldGhlciBzY2hlZHVsZV93b3JrIGlzIA0KPj4gTk1JIHNhZmUsIGJ1dCB0
aGF0IHByb2Nlc3NlcyBvbiBzeXN0ZW1fd3Egc2hvdWxkIG5vdCBiZSBhd2FrZW5lZCANCj4+IGlt
bWVkaWF0ZWx5IHdoZW4gc2NoZWR1bGVfd29yayBpcyBjYWxsZWQuDQo+DQo+SSBkaXNhZ3JlZSB3
aXRoIHRoaXMgY29uY2x1c2lvbi4NCj4NCj5UaGUgcHJvYmxlbSAqaXMqIHRoYXQgc2NoZWR1ZV93
b3JrKCkgaXMgbm90IE5NSS1zYWZlLg0KPg0KPllvdSBjYW5ub3Qgc29sdmUgYW4gTk1JIHNhZmV0
eSBwcm9ibGVtIGJ5IHJlcGxhY2luZyBzY2hlZHVsZV93b3JrKCkgd2l0aCBhbm90aGVyIGZ1bmN0
aW9uIHRoYXQgaXMgYWxzbyBub3QgTk1JLXNhZmUuIFRoYXQgc2ltcGx5IGNoYW5nZXMgdGhlIGxv
Y2tzIHRoYXQgbmVlZCB0byBiZSB0YWtlbiB0byBwcm92b2tlIGEgZGVhZGxvY2suDQo+DQo+DQo+
PiBJIHJlcGxhY2VkIHNjaGVkdWxlX3dvcmsgd2l0aCBzY2hlZHVsZV9kZWxheWVkX3dvcmssIGFu
ZCB0aGlzIHNvbHZlZCANCj4+IG15IHByb2JsZW0uDQo+DQo+VGhpcyBtYXkgc3RvcCBzb21lIHNw
ZWNpZmljIHJlcHJvZHVjdGlvbiBmcm9tIHRha2luZyBwbGFjZSBidXQgaXQgZG9lcyBub3QgZml4
IHRoZSBwb3RlbnRpYWwgZGVhZGxvY2suDQo+DQo+SSBzdGlsbCBiZWxpZXZlIHRoYXQgdXNpbmcg
aXJxX3dvcmsgaXMgdGhlIG9ubHkgd2F5IHRvIHNvbHZlIHRoaXMgcHJvcGVybHkuIFBsZWFzZSB0
cnkgdGhlIGZvbGxvd2luZyBjaGFuZ2U6DQoNCkkgdHJpZWQgdGhlIGZvbGxvd2luZyBwYXRjaCBh
bmQgaXQgYWxzbyByZXNvbHZlZCB0aGUgaXNzdWUuDQpUaGFuayB5b3UgZm9yIHlvdXIgZ3VpZGFu
Y2UgYW5kIHN1Z2dlc3Rpb25zLiBJIHdpbGwgb3JnYW5pemUgdGhpcyBpc3N1ZSBhbmQgcmVzZW5k
IGEgcGF0Y2guDQoNCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2tnZGJvYy5jIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2tnZGJvYy5jIGluZGV4IDdjZTdiYjE2NDAwNTQuLjE2MWIyNWVj
YzVlMTUgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2tnZGJvYy5jDQo+KysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2tnZGJvYy5jDQo+QEAgLTIyLDYgKzIyLDcgQEANCj4gI2luY2x1
ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+
DQo+ICNpbmNsdWRlIDxsaW51eC9zZXJpYWxfY29yZS5oPg0KPisjaW5jbHVkZSA8bGludXgvaXJx
X3dvcmsuaD4NCj4NCj4gI2RlZmluZSBNQVhfQ09ORklHX0xFTgkJNDANCj4NCj5AQCAtOTksMTAg
KzEwMCwxNyBAQCBzdGF0aWMgdm9pZCBrZ2Rib2NfcmVzdG9yZV9pbnB1dF9oZWxwZXIoc3RydWN0
IHdvcmtfc3RydWN0ICpkdW1teSkNCj4NCj4gc3RhdGljIERFQ0xBUkVfV09SSyhrZ2Rib2NfcmVz
dG9yZV9pbnB1dF93b3JrLCBrZ2Rib2NfcmVzdG9yZV9pbnB1dF9oZWxwZXIpOw0KPg0KPitzdGF0
aWMgdm9pZCBrZ2Rib2NfcXVldWVfcmVzdG9yZV9pbnB1dF9oZWxwZXIoc3RydWN0IGlycV93b3Jr
ICp1bnVzZWQpIA0KPit7DQo+KwlzY2hlZHVsZV93b3JrKCZrZ2Rib2NfcmVzdG9yZV9pbnB1dF93
b3JrKTsNCj4rfQ0KPisNCj4rc3RhdGljIERFRklORV9JUlFfV09SSyhrZ2Rib2NfcmVzdG9yZV9p
bnB1dF9pcnFfd29yaywgDQo+K2tnZGJvY19xdWV1ZV9yZXN0b3JlX2lucHV0X2hlbHBlcik7DQo+
Kw0KPiBzdGF0aWMgdm9pZCBrZ2Rib2NfcmVzdG9yZV9pbnB1dCh2b2lkKQ0KPiB7DQo+IAlpZiAo
bGlrZWx5KHN5c3RlbV9zdGF0ZSA9PSBTWVNURU1fUlVOTklORykpDQo+LQkJc2NoZWR1bGVfd29y
aygma2dkYm9jX3Jlc3RvcmVfaW5wdXRfd29yayk7DQo+KwkJaXJxX3dvcmtfcXVldWUoJmtnZGJv
Y19yZXN0b3JlX2lucHV0X2lycV93b3JrKTsNCj4gfQ0KPg0KPiBzdGF0aWMgaW50IGtnZGJvY19y
ZWdpc3Rlcl9rYmQoY2hhciAqKmNwdHIpIEBAIC0xMzMsNiArMTQxLDcgQEAgc3RhdGljIHZvaWQg
a2dkYm9jX3VucmVnaXN0ZXJfa2JkKHZvaWQpDQo+IAkJCWktLTsNCj4gCQl9DQo+IAl9DQo+Kwlp
cnFfd29ya19zeW5jKCZrZ2Rib2NfcmVzdG9yZV9pbnB1dF9pcnFfd29yayk7DQo+IAlmbHVzaF93
b3JrKCZrZ2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrKTsNCj4gfQ0KPiAjZWxzZSAvKiAhIENPTkZJ
R19LREJfS0VZQk9BUkQgKi8NCg==

