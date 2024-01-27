Return-Path: <linux-kernel+bounces-41235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85683EDCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752E41F226C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C828DCA;
	Sat, 27 Jan 2024 15:11:36 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9828DBC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368295; cv=none; b=kKjVKNhdNINw0k19BFu6VmuUwQXMKAAv5t+rlC+d6T+1UZmu5IUQgjkr/r2KMDp0P4qV8fHsnuS312SUzBR7vHlolfDb6j5PIdww1E6VzN6C7M4/OPmPte7w4H3sRGMdledK74mixBdfGssI+AWvrIS4ZCR/C9EzNbXUAoxslqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368295; c=relaxed/simple;
	bh=qPQLddFg1VKJakANQS/CI60niMgi+hg3nsQbsO6CWtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OThiCb2zjQNLQ/EKWTG30Y9K1B8ePuIQG9+EvY359CkSNdLrGlXhimvSGzXzQz4a9gUd6Hg2zMFvH+OJNHZaVKOdvKOoASwmXPiVLNKRMfe+rKDrs65WzuhwR4UQC5sU9qGaaMlC5wKBU2wzfn4mslkg1GazFzuQ4WNzvYWYeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-SCilWEytP4u2p2i3FRz1dw-1; Sat, 27 Jan 2024 15:11:30 +0000
X-MC-Unique: SCilWEytP4u2p2i3FRz1dw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Jan
 2024 15:11:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Jan 2024 15:11:11 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Kees Cook
	<keescook@chromium.org>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] Enable -Wstringop-overflow globally
Thread-Topic: [GIT PULL] Enable -Wstringop-overflow globally
Thread-Index: AQHaUKg1nGzb4cAoNk2Qdc8/rj/X/LDtw4CA
Date: Sat, 27 Jan 2024 15:11:11 +0000
Message-ID: <f00e15fcba05497a87e91182a33c888f@AcuMS.aculab.com>
References: <Za6JwRpknVIlfhPF@work>
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com>
 <202401261423.7AF702239@keescook>
 <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
In-Reply-To: <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgSmFudWFyeSAyMDI0IDIyOjM2DQo+IA0K
PiBPbiBGcmksIDI2IEphbiAyMDI0IGF0IDE0OjI0LCBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9t
aXVtLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBJIHRoaW5rIHhlIGhhcyBzb21lIG90aGVyIHdlaXJk
IHByb2JsZW1zIHRvby4gVGhpcyBtYXkgYmUgcmVsYXRlZCAodW5kZXINCj4gPiBhbGxvY2F0aW5n
KToNCj4gPg0KPiA+IC4uL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5jOiBJbiBmdW5jdGlvbiAn
eGVfdm1hX2NyZWF0ZSc6DQo+ID4gLi4vZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmM6ODA2OjIx
OiB3YXJuaW5nOiBhbGxvY2F0aW9uIG9mIGluc3VmZmljaWVudCBzaXplICcyMjQnIGZvciB0eXBl
DQo+ICdzdHJ1Y3QgeGVfdm1hJyB3aXRoIHNpemUgJzM2OCcgWy1XYWxsb2Mtc2l6ZV0NCj4gPiAg
IDgwNiB8ICAgICAgICAgICAgICAgICB2bWEgPSBremFsbG9jKHNpemVvZigqdm1hKSAtIHNpemVv
ZihzdHJ1Y3QgeGVfdXNlcnB0ciksDQo+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF4N
Cj4gDQo+IFRoYXQgY29kZSBpcyBpbmRlZWQgb2RkLCBidXQgdGhlcmUncyBhIGNvbW1lbnQgaW4g
dGhlIHhlX3ZtYSBkZWZpbml0aW9uDQo+IA0KPiAgICAgICAgIC8qKg0KPiAgICAgICAgICAqIEB1
c2VycHRyOiB1c2VyIHBvaW50ZXIgc3RhdGUsIG9ubHkgYWxsb2NhdGVkIGZvciBWTUFzIHRoYXQg
YXJlDQo+ICAgICAgICAgICogdXNlciBwb2ludGVycw0KPiAgICAgICAgICAqLw0KPiAgICAgICAg
IHN0cnVjdCB4ZV91c2VycHRyIHVzZXJwdHI7DQo+IA0KPiBhbHRob3VnaCBJIGFncmVlIHRoYXQg
aXQgc2hvdWxkIHByb2JhYmx5IHNpbXBseSBiZSBtYWRlIGEgZmluYWwNCj4gdmFyaWFibHktc2l6
ZWQgYXJyYXkgaW5zdGVhZCAoYW5kIHRoZW4geW91IG1ha2UgdGhhdCBhcnJheSBzaXplIGJlDQo+
IDAvMSkuDQoNClRoYXQgZW50aXJlIGNvZGUgaXMgb2RkLg0KSXQgaXNuJ3Qgb2J2aW91cyB0aGF0
IHRoZSBmbGFnIHZhbHVlcyB0aGF0IGNhdXNlIHRoZSBzaG9ydCBhbGxvY2F0ZQ0KYXJlIHRoZSBz
YW1lIG9uZXMgdGhhdCBjb250cm9sIHdoZXRoZXIgdGhlIGV4dHJhIGRhdGEgaXMgYWNjZXNzZWQu
DQoNCk5ldmVyIG1pbmQgdGhlIG9kZGl0aWVzIHdpdGggdGhlICdmbGFncyB8PSAnIGFzc2lnbm1l
bnRzIGludCB0aGUNCidyZW1hcCBuZXh0JyBwYXRoLg0KDQpBbnlvbmUga25vdyBob3cgbWFueSBv
ZiB0aGVzZSBhY3R1YWxseSBnZXQgYWxsb2NhdGVkIChhbmQgdGhlaXINCmxpZmV0aW1lcyk/DQpI
b3cgbXVjaCBkaWZmZXJlbmNlIHdvdWxkIGl0IG1ha2UgdG8gYWxsb2NhdGUgMzY4IChtYXliZSAz
ODQ/KQ0KYnl0ZXMgaW5zdGVhZCBvZiAyMjQgKGxpa2VseSAyNTYpLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K


