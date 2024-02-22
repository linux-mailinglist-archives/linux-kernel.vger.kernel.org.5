Return-Path: <linux-kernel+bounces-77465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2D8605B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72320286BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34D17BC1;
	Thu, 22 Feb 2024 22:30:53 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE1DDB0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641053; cv=none; b=iQH7vgwvyFR+JMYce8g2LmsyV+SA5t2SwF4jQ1CCJ51/Fbbe+PCXlQoUO71SiCUFYcVyDD/nFuR7AbsJxaHjlTXZEDoT359ZmcvtzSgDmf1YYz4y4KfcWnLo5DVynXubstJ3SEBV7JXn2p03D6ICSmr+A4AW93pSCNrzXMviKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641053; c=relaxed/simple;
	bh=9K2TkXTtpGHwF4trUhJe9FBOVST8II0WVSKn8XHMPHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BZodE53ZdY+x81XWdU+XkJYWKNBMOoFDgeMAIW5YPPuOA82otMbmC5PZ1l39iUnyEutC/OCA0j3bRxP96NygAcKFjAHr0HWS7NmRy6vJj0lIRklkGF6Wct5S4wU8bCb2WFxer1uZGJ17t0ySQfDBGub3ekiwDD7rzxCq4mo0Hew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-5HTgjfU-MUShVYi32w2fHw-1; Thu, 22 Feb 2024 22:30:47 +0000
X-MC-Unique: 5HTgjfU-MUShVYi32w2fHw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Feb
 2024 22:30:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 22 Feb 2024 22:30:46 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Justin Stitt' <justinstitt@google.com>, Andy Whitcroft
	<apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray
	<dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones
	<lee@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Kees Cook <keescook@chromium.org>, "Finn
 Thain" <fthain@linux-m68k.org>
Subject: RE: [PATCH v2] checkpatch: add check for snprintf to scnprintf
Thread-Topic: [PATCH v2] checkpatch: add check for snprintf to scnprintf
Thread-Index: AQHaZRMM8CNyJsqITEut/pZzq7c0N7EW8e/A
Date: Thu, 22 Feb 2024 22:30:46 +0000
Message-ID: <dd2b4ac483b54a41aff11a04b6906fd6@AcuMS.aculab.com>
References: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
In-Reply-To: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
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

RnJvbTogSnVzdGluIFN0aXR0DQo+IFNlbnQ6IDIxIEZlYnJ1YXJ5IDIwMjQgMjI6MTINCj4gDQo+
IEkgYW0gZ29pbmcgdG8gcXVvdGUgTGVlIEpvbmVzIHdobyBoYXMgYmVlbiBkb2luZyBzb21lIHNu
cHJpbnRmIC0+DQo+IHNjbnByaW50ZiByZWZhY3RvcmluZ3M6DQo+IA0KPiAiVGhlcmUgaXMgYSBn
ZW5lcmFsIG1pc3VuZGVyc3RhbmRpbmcgYW1vbmdzdCBlbmdpbmVlcnMgdGhhdA0KPiB7dn1zbnBy
aW50ZigpIHJldHVybnMgdGhlIGxlbmd0aCBvZiB0aGUgZGF0YSAqYWN0dWFsbHkqIGVuY29kZWQg
aW50byB0aGUNCj4gZGVzdGluYXRpb24gYXJyYXkuICBIb3dldmVyLCBhcyBwZXIgdGhlIEM5OSBz
dGFuZGFyZCB7dn1zbnByaW50ZigpDQo+IHJlYWxseSByZXR1cm5zIHRoZSBsZW5ndGggb2YgdGhl
IGRhdGEgdGhhdCAqd291bGQgaGF2ZSBiZWVuKiB3cml0dGVuIGlmDQo+IHRoZXJlIHdlcmUgZW5v
dWdoIHNwYWNlIGZvciBpdC4gIFRoaXMgbWlzdW5kZXJzdGFuZGluZyBoYXMgbGVkIHRvDQo+IGJ1
ZmZlci1vdmVycnVucyBpbiB0aGUgcGFzdC4gIEl0J3MgZ2VuZXJhbGx5IGNvbnNpZGVyZWQgc2Fm
ZXIgdG8gdXNlIHRoZQ0KPiB7dn1zY25wcmludGYoKSB2YXJpYW50cyBpbiB0aGVpciBwbGFjZSAo
b3IgZXZlbiBzcHJpbnRmKCkgaW4gc2ltcGxlDQo+IGNhc2VzKS4gIFNvIGxldCdzIGRvIHRoYXQu
Ig0KDQpXaGlsZSBnZW5lcmFsbHkgdHJ1ZSwgdGhlcmUgYXJlIHBsYWNlcyB0aGF0IHJlYWxseSBk
byB3YW50IHRvDQpkZXRlY3QgKGFuZCBlcnJvcikgb3ZlcmZsb3cuDQpUaGF0IGlzbid0IHBvc3Np
YmxlIHdpdGggc2NucHJpbnRmKCkuDQoNCkknbSBub3Qgc3VyZSB3aGF0IHRoZSBzb2x1dGlvbiBp
cyB0aG91Z2guDQpIYXZpbmcgYSBmdW5jdGlvbiB0aGF0IHJldHVybnMgYSBuZWdhdGl2ZSB2YWx1
ZSBvbiBvdmVyZmxvdyBpcyBhbHNvDQpsaWtlbHkgdG8gZ2V0IG1pc3VzZWQuDQpzZXFfcHJpbnRm
KCkgKG9yIHdoYXRldmVyIGl0IGlzIGNhbGxlZCkgbWF5IGxldCB5b3UgY2hlY2ssDQpidXQgaXQg
aXMgaGFyZGx5IGEgY2hlYXAgd3JhcHBlciBhbmQgYSBiaXQgb2YgYSBQSVRBIHRvIHVzZS4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==


