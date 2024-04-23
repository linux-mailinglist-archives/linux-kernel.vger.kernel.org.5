Return-Path: <linux-kernel+bounces-154783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E548AE0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6767BB21F52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79460DFB;
	Tue, 23 Apr 2024 09:22:46 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC36024B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864166; cv=none; b=WHDw2l/tNesGLYfyN2b1bpjeg1iDMp4KP1XuFTeiTinF3txCaa6iG+68kpqVp0gqcQEV7AWA82QZRfNdNEBeFZxuKnn0NFXdDxrlDO4nJXlILOkXSdpEQYdXAPRs1K3lx78JdTBHbnmXuniE8pe/8X7bZ6teOeJec7TMSx6utfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864166; c=relaxed/simple;
	bh=jSaqwWRzyD3rma7O32HTNPQWFdvY3OUANQ/kOAmLL4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HSGKb1XVC77crKBLRx4CFJq3t3ng9AB7zQHJRziM4kYul8Qw+9l0NQGxDr/bvvikW1q/XPQj3NXYjlu1yKKYxDmN2mewjuGfuwZ8xc7iFijiEqN6xjVgB6uMnxzGy1e3Wio4Ef6jlFjUsLXBzogkxowq1dePYylJKfhahSzvOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-3VO-Mr3mMy2V2AACXbi5fg-1; Tue, 23 Apr 2024 10:22:35 +0100
X-MC-Unique: 3VO-Mr3mMy2V2AACXbi5fg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Apr
 2024 10:22:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 23 Apr 2024 10:22:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thomas Gleixner' <tglx@linutronix.de>,
	=?utf-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
 =?utf-8?B?4KS+4KSwKQ==?= <maheshb@google.com>
CC: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "Sagi
 Maimon" <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John
 Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: RE: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
Thread-Topic: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
Thread-Index: AQHakUipE9fygZJ1Ok680rZNup1+trFzDfZAgAH4zUaAAIyhYA==
Date: Tue, 23 Apr 2024 09:22:06 +0000
Message-ID: <f2ac461445f44addb521ef79ecedc584@AcuMS.aculab.com>
References: <20240418042706.1261473-1-maheshb@google.com>
 <163538a0495840eca34f6fbd09533ae1@AcuMS.aculab.com>
 <CAF2d9jj6H+jOfUbbw1ZEHmgqroXmn+oFV8NwTyKJ_P_T4G_5xg@mail.gmail.com>
 <87edaxudr8.ffs@tglx>
In-Reply-To: <87edaxudr8.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVGhvbWFzIEdsZWl4bmVyDQo+IFNlbnQ6IDIzIEFwcmlsIDIwMjQgMDE6MjUNCi4uLg0K
PiA+PiBJdCByZWFsbHkgd291bGQgYmUgbmljZSBpZiB0aG9zZSBiaWcgYWRqdXN0bWVudHMgZGlk
bid0IGFmZmVjdA0KPiA+PiBDTE9DS19NT05BVE9OSUMuIChhcyBhbiBleGFtcGxlIHRyeSBzZW5k
aW5nIFJUUCBhdWRpbyBldmVyeSAyMG1zKQ0KPiANCj4gVGhleSBkb24ndCBhZmZlY3QgQ0xPQ0tf
TU9OQVRPTklDIGF0IGFsbCBiZWNhdXNlIHRoZXJlIGlzIG5vIHN1Y2ggY2xvY2sgOikNCj4gDQo+
ID4gSG1tLCBwcm9iYWJseSB0aGlzIGlzIG91dCBvZiBjb250ZXh0IGZvciB0aGlzIHBhdGNoIGFu
ZCBwcm9iYWJseSBhDQo+ID4gcXVlc3Rpb24gZm9yIHRoZSB0aW1lIG1haW50YWluZXJzIC8gZXhw
ZXJ0cz8NCj4gDQo+IFRoZSBxdWFudGl0eSBvZiB0aGUgaW5pdGlhbCBmcmVxdWVuY3kgYWRqdXN0
bWVudHMgZGVwZW5kcyBvbiB0aGUNCj4gYWNjdXJhY3kgb2YgdGhlIGluaXRpYWwgY2xvY2sgZnJl
cXVlbmN5IGNhbGlicmF0aW9uIHdoaWNoIGlzIG9uIG1vc3QNCj4gc2FuZSBzeXN0ZW1zIHdpdGhp
biArLy0gNTAwcHBtLg0KPiANCj4gICAgICA1MDBwcG0gb2YgMjBtcyA9PSAxMHVzDQo+IA0KPiBJ
ZiB0aGUgY2xvY2sgY2FsaWJyYXRpb24gaXMgb2ZmIGJ5IGEgbGFyZ2VyIG1hcmdpbiB0aGVuIHRo
YXQgbmVlZHMgdG8gYmUNCj4gZml4ZWQuDQoNClRoZSBpbml0aWFsIGFkanVzdG1lbnQgZGVwZW5k
cyBvbiB0aGUgYWNjdXJhY3kgb2YgdGhlIGluaXRpYWwgUlRDDQp2YWx1ZSByZWFkIGZyb20gdGhl
IGxvY2FsIGhhcmR3YXJlLg0KVGhpcyBpcyB1bmxpa2VseSB0byBiZSBtb3JlIGFjY3VyYXRlIHRo
YW4gMSBzZWNvbmQgYW5kIGNhbiBlYXNpbHkNCmJlIGEgZmV3IHNlY29uZHMgb3V0Lg0KDQpDb3Jy
ZWN0aW5nIHRoaXMgY2F1c2VzIE5UUCB0byBhZGp1c3QgdGhlIGNsb2NrIGF0IGl0cyBtYXhpbXVt
IGRyaWZ0DQpyYXRlIGZvciBhIHdoaWxlIC0gSSdtIHN1cmUgSSd2ZSBzZWVuIHRoaXMgaGFwcGVu
IGZvciBtaW51dGVzLg0KT25jZSB0aGlzIGNvbXBsZXRlcyB0aGVyZSBpcyBhICdzdGVwIGNoYW5n
ZScgaW4gdGhlIGZyZXF1ZW5jeSBhZGp1c3RtZW50Lg0KDQpPbmNlIHRoZSBzeXN0ZW0gaGFzIGJl
ZW4gcnVubmluZyBmb3IgYSB3aGlsZSB0aGUgYWRqdXN0bWVudHMgYXJlIG1pbm9yLg0KVGltZSBy
dW5zIGFsdGVybmF0ZWx5IGZhc3QgYW5kIHNsb3cgdG8gbWFpbnRhaW4gbG9uZyB0ZXJtIGFjY3Vy
YWN5Lg0KDQpUaGlzIGlzIG5vdGljZWFibGUgaWYgeW91IHVzZSBzY2hlZHVsZV9ocnRpbWVvdXRf
cmFuZ2UoLCwgSFJUSU1FUl9NT0RFX0FCUykNCnRvIHN5bmNocm9uaXplIHRvIGFuIGFjY3VyYXRl
IGV4dGVybmFsIGNsb2NrIFsxXS4NCihXaXRob3V0IE5UUCBpdCBoYXMgdG8gYWRqdXN0IGZvciB0
ZW1wZXJhdHVyZSBjaGFuZ2luZyB0aGUgZnJlcXVlbmN5LikNCg0KCURhdmlkDQoNClsxXSBJbWFn
aW5lIHNvbWUgaGFyZHdhcmUgdGhhdCBjb3VudHMgdXNlY3MgYWZ0ZXIgdGhlIDEtc2Vjb25kIEdQ
UyBwdWxzZS4NCmFuZCBhIGRyaXZlciB0aGF0IGFkanVzdHMgYSBzbGVlcCB0byB3YWtlIHVwIHdo
ZW4gdGhhdCBjb3VudCBpcyBiZXR3ZWVuDQooc2F5KSA0MDAgYW5kIDYwMC4NClVzaW5nIGEgdGlt
ZXIgYW5kIGEgc2luZ2xlIHJlYWRsKCkgaXMgZmFyIGZhc3RlciB0aGFuIHRha2luZyBhbiBpbnRl
cnJ1cHQuDQooSW4gb3VyIGNhc2UgaXQgaXMgYSAxMG1zIHB1bHNlIGRlcml2ZWQgZnJvbSB0aGUg
Y2xvY2sgcmVjb3ZlcmVkIGZyb20NCmFuIEUxL1QxIHRlbGVjb21zIGxpbmsuKQ0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


