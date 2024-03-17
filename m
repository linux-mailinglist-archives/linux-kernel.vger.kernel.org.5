Return-Path: <linux-kernel+bounces-105327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC987DC4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 05:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0EB1C20BCA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 04:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D20611E;
	Sun, 17 Mar 2024 04:13:05 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43225240
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710648784; cv=none; b=m97m57advhnWoAg5rRn7YHqqQ1wmMc3tMU1KGlxjvkICivNAVEkdnO98Kdm4yx8R1O9O2QfURjQdNa9yAwmUGk/1NB73ZZ1DVFigMKbG68NIsLi6cPyGaRNB5aE4EI/gFIgYbD3KTaLZw6e1+qYZgmtPOivEVcvYDQ+9nUc9fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710648784; c=relaxed/simple;
	bh=4RqFJoJu0gw7NWyNAozizYAx4+YrBQJuxUnxEkjr6JA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MTf5gjVrA5PH3jFXDD6/I/oXGnh+kC7Iuk9SIO1cw8PTi8hRJ+VO/xTUrrlb/5qUjvwnRttJqh4x3Fx2p4w3OIoqu352br24U98kTbev7GxQA6Vi4AWcYHOkkuGdE5nNJcR3HtTr0b648+u0Ley0DC9veAdBHr+EnAZfymVIhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42H4C4ix079769;
	Sun, 17 Mar 2024 12:12:04 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ty4KF26QYz2KXJwC;
	Sun, 17 Mar 2024 12:10:41 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sun, 17 Mar
 2024 12:12:02 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Sun, 17 Mar 2024 12:12:02 +0800
From: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?=
	<zhaoyang.huang@unisoc.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox
	<willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?=
	<Steve.Kang@unisoc.com>
Subject: resend the chart via outlook: [PATCH] mm: fix a race scenario in
 folio_isolate_lru
Thread-Topic: resend the chart via outlook: [PATCH] mm: fix a race scenario in
 folio_isolate_lru
Thread-Index: Adp4IUKBOWATSeRYTGKhXZldTMNPTQ==
Date: Sun, 17 Mar 2024 04:12:02 +0000
Message-ID: <434f550e46c54a8b82a1f20bf2cc878a@BJMBX01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 42H4C4ix079769

Pg0KPk9uIFNhdCwgTWFyIDE2LCAyMDI0IGF0IDEwOjU54oCvUE0gTWF0dGhldyBXaWxjb3ggPHdp
bGx5QGluZnJhZGVhZC5vcmc+DQo+d3JvdGU6DQo+Pg0KPj4gT24gU2F0LCBNYXIgMTYsIDIwMjQg
YXQgMDQ6NTM6MDlQTSArMDgwMCwgWmhhb3lhbmcgSHVhbmcgd3JvdGU6DQo+PiA+IE9uIEZyaSwg
TWFyIDE1LCAyMDI0IGF0IDg6NDbigK9QTSBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFk
Lm9yZz4NCj53cm90ZToNCj4+ID4gPg0KPj4gPiA+IE9uIFRodSwgTWFyIDE0LCAyMDI0IGF0IDA0
OjM5OjIxUE0gKzA4MDAsIHpoYW95YW5nLmh1YW5nIHdyb3RlOg0KPj4gPiA+ID4gRnJvbTogWmhh
b3lhbmcgSHVhbmcgPHpoYW95YW5nLmh1YW5nQHVuaXNvYy5jb20+DQo+PiA+ID4gPg0KPj4gPiA+
ID4gUGFuaWNbMV0gcmVwb3J0ZWQgd2hpY2ggaXMgY2F1c2VkIGJ5IGxydXZlYy0+bGlzdCBicmVh
ay4gRml4IHRoZQ0KPj4gPiA+ID4gcmFjZSBiZXR3ZWVuIGZvbGlvX2lzb2xhdGVfbHJ1IGFuZCBy
ZWxlYXNlX3BhZ2VzLg0KPj4gPiA+ID4NCj4+ID4gPiA+IHJhY2UgY29uZGl0aW9uOg0KPj4gPiA+
ID4gcmVsZWFzZV9wYWdlcyBjb3VsZCBtZWV0IGEgbm9uLXJlZmVyZWQgZm9saW8gd2hpY2ggZXNj
YXBlZCBmcm9tDQo+PiA+ID4gPiBiZWluZyBkZWxldGVkIGZyb20gTFJVIGJ1dCBhZGQgdG8gYW5v
dGhlciBsaXN0X2hlYWQNCj4+ID4gPg0KPj4gPiA+IEkgZG9uJ3QgdGhpbmsgdGhlIGJ1ZyBpcyBp
biBmb2xpb19pc29sYXRlX2xydSgpIGJ1dCByYXRoZXIgaW4gaXRzDQo+PiA+ID4gY2FsbGVyLg0K
Pj4gPiA+DQo+PiA+ID4gICogQ29udGV4dDoNCj4+ID4gPiAgKg0KPj4gPiA+ICAqICgxKSBNdXN0
IGJlIGNhbGxlZCB3aXRoIGFuIGVsZXZhdGVkIHJlZmNvdW50IG9uIHRoZSBmb2xpby4gVGhpcyBp
cyBhDQo+PiA+ID4gICogICAgIGZ1bmRhbWVudGFsIGRpZmZlcmVuY2UgZnJvbSBpc29sYXRlX2xy
dV9mb2xpb3MoKSAod2hpY2ggaXMgY2FsbGVkDQo+PiA+ID4gICogICAgIHdpdGhvdXQgYSBzdGFi
bGUgcmVmZXJlbmNlKS4NCj4+ID4gPg0KPj4gPiA+IFNvIHdoZW4gcmVsZWFzZV9wYWdlcygpIHJ1
bnMsIGl0IG11c3Qgbm90IHNlZSBhIHJlZmNvdW50DQo+PiA+ID4gZGVjcmVtZW50ZWQgdG8gemVy
bywgYmVjYXVzZSB0aGUgY2FsbGVyIG9mIGZvbGlvX2lzb2xhdGVfbHJ1KCkgaXMgc3VwcG9zZWQN
Cj50byBob2xkIG9uZS4NCj4+ID4gPg0KPj4gPiA+IFlvdXIgc3RhY2sgdHJhY2UgaXMgZm9yIHRo
ZSB0aHJlYWQgd2hpY2ggaXMgY2FsbGluZw0KPj4gPiA+IHJlbGVhc2VfcGFnZXMoKSwgbm90IHRo
ZSBvbmUgY2FsbGluZyBmb2xpb19pc29sYXRlX2xydSgpLCBzbyBJIGNhbid0IGhlbHAgeW91DQo+
ZGVidWcgZnVydGhlci4NCj4+ID4gVGhhbmtzIGZvciB0aGUgY29tbWVudHMuICBBY2NvcmRpbmcg
dG8gbXkgdW5kZXJzdGFuZGluZywNCj4+ID4gZm9saW9fcHV0X3Rlc3R6ZXJvIGRvZXMgdGhlIGRl
Y3JlbWVudCBiZWZvcmUgdGVzdCB3aGljaCBtYWtlcyBpdA0KPj4gPiBwb3NzaWJsZSB0byBoYXZl
IHJlbGVhc2VfcGFnZXMgc2VlIHJlZmNudCBlcXVhbCB6ZXJvIGFuZCBwcm9jZWVkDQo+PiA+IGZ1
cnRoZXIoZm9saW9fZ2V0IGluIGZvbGlvX2lzb2xhdGVfbHJ1IGhhcyBub3QgcnVuIHlldCkuDQo+
Pg0KPj4gTm8sIHRoYXQncyBub3QgcG9zc2libGUuDQo+Pg0KPj4gSW4gdGhlIHNjZW5hcmlvIGJl
bG93LCBhdCBlbnRyeSB0byBmb2xpb19pc29sYXRlX2xydSgpLCB0aGUgZm9saW8gaGFzDQo+PiBy
ZWZjb3VudCAyLiAgSXQgaGFzIG9uZSByZWZjb3VudCBmcm9tIHRocmVhZCAwIChiZWNhdXNlIGl0
IG11c3Qgb3duDQo+PiBvbmUgYmVmb3JlIGNhbGxpbmcgZm9saW9faXNvbGF0ZV9scnUoKSkgYW5k
IGl0IGhhcyBvbmUgcmVmY291bnQgZnJvbQ0KPj4gdGhyZWFkIDEgKGJlY2F1c2UgaXQncyBhYm91
dCB0byBjYWxsIHJlbGVhc2VfcGFnZXMoKSkuICBJZg0KPj4gcmVsZWFzZV9wYWdlcygpIHdlcmUg
bm90IHJ1bm5pbmcsIHRoZSBmb2xpbyB3b3VsZCBoYXZlIHJlZmNvdW50IDMgd2hlbg0KPj4gZm9s
aW9faXNvbGF0ZV9scnUoKSByZXR1cm5lZC4NCj5Db3VsZCBpdCBiZSB0aGlzIHNjZW5hcmlvLCB3
aGVyZSBmb2xpbyBjb21lcyBmcm9tIHB0ZSh0aHJlYWQgMCksIGxvY2FsDQo+ZmJhdGNoKHRocmVh
ZCAxKSBhbmQgcGFnZSBjYWNoZSh0aHJlYWQgMikgY29uY3VycmVudGx5IGFuZCBwcm9jZWVkDQo+
aW50ZXJtaXhlZCB3aXRob3V0IGxvY2sncyBwcm90ZWN0aW9uPyBBY3R1YWxseSwgSU1PLCB0aHJl
YWQgMSBhbHNvIGNvdWxkIHNlZSB0aGUNCj5mb2xpbyB3aXRoIHJlZmNudD09MSBzaW5jZSBpdCBk
b2Vzbid0IGNhcmUgaWYgdGhlIHBhZ2UgaXMgb24gdGhlIHBhZ2UgY2FjaGUgb3INCj5ub3QuDQo+
DQo+bWFkaXZpc2VfY29sZF9hbmRfcGFnZW91dCBkb2VzIG5vIGV4cGxpY2l0IGZvbGlvX2dldCB0
aGluZyBzaW5jZSB0aGUgZm9saW8NCj5jb21lcyBmcm9tIHB0ZSB3aGljaCBpbXBsaWVzIGl0IGhh
cyBvbmUgcmVmY250IGZyb20gcGFnZWNhY2hlDQo+DQo+I3RocmVhZCAwKG1hZGl2aXNlX2NvbGRf
YW5kX3BhZ2VvdXQpICAgICAgICAjMQ0KPihscnVfYWRkX2RyYWluLT5mYmF0Y2hfcmVsZWFzZV9w
YWdlcykNCj4jMihyZWFkX3BhZ2VzLT5maWxlbWFwX3JlbW92ZV9mb2xpb3MpDQo+cmVmY250ID09
IDEocmVwcmVzZW50IHBhZ2UgY2FjaGUpDQo+DQo+cmVmY250PT0yKGFub3RoZXIgb25lIHJlcHJl
c2VudCBMUlUpDQo+ICAgZm9saW8gY29tZXMgZnJvbSBwYWdlIGNhY2hlDQo+Zm9saW9faXNvbGF0
ZV9scnUNCj5yZWxlYXNlX3BhZ2VzDQo+ICAgICAgICAgICAgICAgICBmaWxlbWFwX2ZyZWVfZm9s
aW8NCj4NCj4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZmNudD09MShkZWNyZWFz
ZSB0aGUgb25lIG9mIHBhZ2UgY2FjaGUpDQo+DQo+IGZvbGlvX3B1dF90ZXN0emVybyA9PSB0cnVl
DQo+DQo+ICA8Tm8gbHJ1dmVjX2RlbF9mb2xpbz4NCj4NCj4gbGlzdF9hZGQoZm9saW8tPmxydSwg
cGFnZXNfdG9fZnJlZSkgLy9jdXJyZW50IGZvbGlvIHdpbGwgYnJlYWsgTFJVJ3MgaW50ZWdyaXR5
DQo+c2luY2UgaXQgaGFzIG5vdCBiZWVuIGRlbGV0ZWQNCj4NCj5JbiBjYXNlIG9mIGdtYWlsJ3Mg
d3JhcCwgc3BsaXQgYWJvdmUgY2hhcnQgdG8gdHdvIHBhcnRzDQo+DQo+I3RocmVhZCAwKG1hZGl2
aXNlX2NvbGRfYW5kX3BhZ2VvdXQpICAgICAgICAjMQ0KPihscnVfYWRkX2RyYWluLT5mYmF0Y2hf
cmVsZWFzZV9wYWdlcykNCj5yZWZjbnQgPT0gMShyZXByZXNlbnQgcGFnZSBjYWNoZSkNCj4NCj5y
ZWZjbnQ9PTIoYW5vdGhlciBvbmUgcmVwcmVzZW50IExSVSkNCj5mb2xpb19pc29sYXRlX2xydQ0K
PnJlbGVhc2VfcGFnZXMNCj4NCj4gZm9saW9fcHV0X3Rlc3R6ZXJvID09IHRydWUNCj4NCj4gIDxO
byBscnV2ZWNfZGVsX2ZvbGlvPg0KPg0KPiBsaXN0X2FkZChmb2xpby0+bHJ1LCBwYWdlc190b19m
cmVlKQ0KPg0KPiAvL2N1cnJlbnQgZm9saW8gd2lsbCBicmVhayBMUlUncyBpbnRlZ3JpdHkgc2lu
Y2UgaXQgaGFzIG5vdCBiZWVuIGRlbGV0ZWQNCj4NCj4jMSAobHJ1X2FkZF9kcmFpbi0+ZmJhdGNo
X3JlbGVhc2VfcGFnZXMpDQo+IzIocmVhZF9wYWdlcy0+ZmlsZW1hcF9yZW1vdmVfZm9saW9zKQ0K
PnJlZmNudD09Mihhbm90aGVyIG9uZSByZXByZXNlbnQgTFJVKQ0KPiAgIGZvbGlvIGNvbWVzIGZy
b20gcGFnZSBjYWNoZQ0KPnJlbGVhc2VfcGFnZXMNCj4gICAgICAgICAgICAgICAgIGZpbGVtYXBf
ZnJlZV9mb2xpbw0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWZjbnQ9PTEoZGVj
cmVhc2UgdGhlIG9uZSBvZiBwYWdlIGNhY2hlKQ0KPmZvbGlvX3B1dF90ZXN0emVybyA9PSB0cnVl
ICA8Tm8gbHJ1dmVjX2RlbF9mb2xpbz4gIGxpc3RfYWRkKGZvbGlvLT5scnUsDQo+cGFnZXNfdG9f
ZnJlZSkgLy9jdXJyZW50IGZvbGlvIHdpbGwgYnJlYWsgTFJVJ3MgaW50ZWdyaXR5IHNpbmNlIGl0
IGhhcyBub3QgYmVlbg0KPmRlbGV0ZWQNCj4+DQo+PiA+ICAgICMwIGZvbGlvX2lzb2xhdGVfbHJ1
ICAgICAgICAgICMxIHJlbGVhc2VfcGFnZXMNCj4+ID4gQlVHX09OKCFmb2xpb19yZWZjbnQpDQo+
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZvbGlvX3B1
dF90ZXN0emVybygpKQ0KPj4gPiAgICBmb2xpb19nZXQoZm9saW8pDQo+PiA+ICAgIGlmIChmb2xp
b190ZXN0X2NsZWFyX2xydSgpKQ0KDQpSZXNlbmQgdGhlIGNoYXJ0IHZpYSBvdXRsb29rDQojdGhy
ZWFkIDAobWFkaXZpc2VfY29sZF9hbmRfcGFnZW91dCkgICAgICAgICMxKGxydV9hZGRfZHJhaW4t
PmZiYXRjaF9yZWxlYXNlX3BhZ2VzKSAgICAgICAjMihyZWFkX3BhZ2VzLT5maWxlbWFwX3JlbW92
ZV9mb2xpb3MpDQpyZWZjbnQgPT0gMShyZXByZXNlbnQgcGFnZSBjYWNoZSkgICAgICAgICAgICAg
cmVmY250PT0yKGFub3RoZXIgb25lIHJlcHJlc2VudCBMUlUpICAgICAgICAgIGZvbGlvIGNvbWVz
IGZyb20gcGFnZSBjYWNoZQ0KZm9saW9faXNvbGF0ZV9scnUgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWxlYXNlX3BhZ2VzICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaWxlbWFwX2Zy
ZWVfZm9saW8NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAJCQkJCQkJ
CQkJIHJlZmNudD09MShkZWNyZWFzZSB0aGUgb25lIG9mIHBhZ2UgY2FjaGUpDQoJCQkJCQkJCQkJ
Zm9saW9fcHV0X3Rlc3R6ZXJvID09IHRydWUNCgkJCQkJCQkJCSAgCTxObyBscnV2ZWNfZGVsX2Zv
bGlvPg0KCQkJCQkJCQkJCWxpc3RfYWRkKGZvbGlvLT5scnUsIHBhZ2VzX3RvX2ZyZWUpIC8vY3Vy
cmVudCBmb2xpbyB3aWxsIGJyZWFrIExSVSdzIGludGVncml0eSBzaW5jZSBpdCBoYXMgbm90IGJl
ZW4gZGVsZXRlZA0K

