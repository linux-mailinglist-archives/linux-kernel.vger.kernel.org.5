Return-Path: <linux-kernel+bounces-60412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8785048D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3CE1F221C7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148553814;
	Sat, 10 Feb 2024 13:51:49 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD02114
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707573108; cv=none; b=d5NgmClolLxoIK97HCoAN2WURTuKzcL6ZkgPGsikvRhcuEWyqIjzF7LWuzeHJnRi6h48nvA9j3EejmqHtYAMYO+bBCYAObdSfMFA9gU+MQaUp7NyVaqqB+2MDaLTzdVhy+l1RmAmrFNDutRxv2XJAkzKDgYoRPviolA7YoKv5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707573108; c=relaxed/simple;
	bh=mJNh+djTCqqKsg3FJVqIIWwHEHq7WgIc5UhFkuEM2bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EhDbk2vjkm23LxXdfEM5ljpsxxOgfnLsjVpw7bSr0LkJ5AqVoudN6vNS2U1iS5zj+lQod0TtswjIku5eo+DN1wix+0MvmL9yl9YALRvw1BFeSkkFoUjwfNclAc9noKHJdmkBE5teql6YidqPdYBYMMHu28xdpHnFtyX/YEY7lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-75-PUFwWm4HMsG8Z9qT-lEh4g-1; Sat, 10 Feb 2024 13:51:40 +0000
X-MC-Unique: PUFwWm4HMsG8Z9qT-lEh4g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 13:51:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 13:51:18 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pavel Machek' <pavel@ucw.cz>, Justin Stitt <justinstitt@google.com>
CC: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] string: Allow 2-argument strscpy()
Thread-Topic: [RFC] string: Allow 2-argument strscpy()
Thread-Index: AQHaWe5TIJbv1x38yUWctvLGNyIGYrEDmx4Q
Date: Sat, 10 Feb 2024 13:51:18 +0000
Message-ID: <4b396628800149c69e157f0340778fbf@AcuMS.aculab.com>
References: <20240129202901.work.282-kees@kernel.org>
 <20240129215525.4uxchtrywzzsrauc@google.com> <ZcPDMZFPY08S4MGR@duo.ucw.cz>
In-Reply-To: <ZcPDMZFPY08S4MGR@duo.ucw.cz>
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
Content-Transfer-Encoding: quoted-printable

From: Pavel Machek
> Sent: 07 February 2024 17:52
> > > Using sizeof(dst) is the overwhelmingly common case for strscpy().
> > > Instead of requiring this everywhere, allow a 2-argument version to b=
e
> > > used that will use the sizeof() internally.
> >
> > Yeah, this is definitely the case. I have a ton of patches replacing
> > strncpy with strscpy [1] and many of them match the pattern of:
> > | strscpy(dest, src, sizeof(dest))
> >
> > BTW, this hack for function overloading is insane. Never really looked =
into
> > it before.
>=20
> This hack is insane, but this is also highly confusing, please don't
> do this.

A much simpler 'hack' - here defaulting in 16.
Although you'd probably want a compile-time check on the
number of arguments.

And convert 'sizeof 'non-array' to (say) -1 and error
a length that is a constant -1.

=09David

extern int func_2(void *, const void *, int);

#define func_1(_p0, _p1, len, ...) func_2(_p0, _p1, len)
#define func(_p0, ...) func_1(_p0, __VA_ARGS__, 16)

int f1(void *p0, const void *p1)
{
    return func(p0, p1);
}

int f2(void *p0, const void *p1, int len)
{
    return func(p0, p1, len);
}

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


