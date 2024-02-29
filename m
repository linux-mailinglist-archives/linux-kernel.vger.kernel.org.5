Return-Path: <linux-kernel+bounces-87631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901586D6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F082855F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474574BF3;
	Thu, 29 Feb 2024 22:19:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8ED6D52F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245167; cv=none; b=Ul59s4QSCkJ6vFiBgs+MfwquayQrBG0DVyD6titcTu9CftsJjb4+hCAhzSY9UBbJF9GQyu6kmt3pxVZceWPgRln55fyMfbZNCxO4SJ2ZRYSVLORyPBI+yU+WmzOjDHVTE/3QWiikcS1wq3VDSPwPrvyIrM1ylSS3aJZycFsKnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245167; c=relaxed/simple;
	bh=M6UYG5sei6C0Rzgn8R/42e/WauTCqLiaOxNsgR5MJLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mp/SgmvYj5S6O8v0m51GDf8dWQF7NtahbGTOiAug27MBHmnAj3nD8gfJcY3JEzEEgjkrgsDlLPi5P/uJEqOxnvTjXiJdHh8zgM8ZyLbwwFhWRPRLC93ChbaFvDo4VoIxOl8oZC3SdvFl3NYHpjprxYcpFgbJlv7wL13qCCh3xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-3uv_vksaP4C8KFqGrkfj8Q-1; Thu, 29 Feb 2024 22:19:21 +0000
X-MC-Unique: 3uv_vksaP4C8KFqGrkfj8Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Feb
 2024 22:19:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Feb 2024 22:19:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, linux-m68k
	<linux-m68k@lists.linux-m68k.org>
Subject: RE: Linux 6.8-rc6
Thread-Topic: Linux 6.8-rc6
Thread-Index: AQHaaYe1QmzCGfJCBU23M4aIzXNkALEh5vKA
Date: Thu, 29 Feb 2024 22:19:20 +0000
Message-ID: <b4fa177d6fcc42deb7db0dc0f9d36fe2@AcuMS.aculab.com>
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
 <6bb3f88b-bf57-442a-8b46-cb4784dd4cab@roeck-us.net>
 <CAMuHMdVYjw9CEBUzxuJ-10wudK_mvJZgqP3gR4kuv-FDYBZ-Aw@mail.gmail.com>
 <8403d8e3-c8ac-476b-8b8e-2c8b6ed8f464@roeck-us.net>
In-Reply-To: <8403d8e3-c8ac-476b-8b8e-2c8b6ed8f464@roeck-us.net>
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

Li4uDQo+ID4+IEkgc3VzcGVjdCB0aGlzIG1heSBiZSBjYXVzZWQgYnkgdGhlIHRlc3QgYXNzdW1p
bmcgdGhhdCBzdGFjayBncm93dGggaXMNCj4gPj4gZG93bndhcmQsIGJ1dCBJIGRvbid0IHJlYWxs
eSB1bmRlcnN0YW5kIHRoZSB0ZXN0IHdlbGwgZW5vdWdoIHRvIGJlIHN1cmUuDQo+ID4+IEknbGwg
ZGlzYWJsZSB0aGlzIHNldCBvZiB0ZXN0cyBmb3IgbTY4ayBnb2luZyBmb3J3YXJkLCBzbyBJIGFt
IG5vdCBnb2luZw0KPiA+PiB0byByZXBvcnQgdGhlIHByb2JsZW0gYWdhaW4gaW4gdGhlIGZ1dHVy
ZS4NCj4gPg0KPiA+IE9uIG02OGssIHRoZSBzdGFjayBkb2VzIGdyb3cgZG93bndhcmQuDQo+IA0K
PiBTb3JyeSwgSSBtZWFudCB0byBzYXkgdXB3YXJkLCBidXQgYXBwYXJlbnRseSBJIHdhcyB3cm9u
Zy4NCg0KTWF5YmUgYmVjYXVzZSBtNjhrIG9ubHkgaGFzIDIgYnl0ZSBhbGlnbm1lbnQgZm9yIDMy
IGJpdCBpdGVtcy4NClRoYXQgY2F1c2VzIGdyaWVmIGluIG1hbnkgcGxhY2VzLg0KQWx0aG91Z2gg
a21hbGxvYygpIHJldHVybmluZyBhIGxhcmdlciBhbGlnbm1lbnQgd291bGQgZml4IHNvbWUNCm9m
IHRoZW0gd2l0aG91dCB1c2luZyBtdWNoIG1vcmUgbWVtb3J5Pw0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


