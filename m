Return-Path: <linux-kernel+bounces-60408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F90850478
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACFC1F22952
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACC481BE;
	Sat, 10 Feb 2024 13:02:47 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772313D0DF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707570167; cv=none; b=u1laY42ohMsfiWzAlkRV+/2+RI7m/0L3cPgDODfL6iOJIjZlg4hZv3nub8021AhsNQyW9wL/oapACMErn8oF377k2X2dqVi35t78JZiGwYujwlwyMe5iXdfM/PhI783nmV3KD/oOqcPm18nIn6KC8eKcM9hYS92d1IdEsbbtHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707570167; c=relaxed/simple;
	bh=z++avKfPq9qDu4RZiReKmDmUzs0wTT/wjh7b/cwG4bU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=N51oPHjCR+mwqaXkABEAly0L1povNHzWXLAkvoIMSvXcNiJ47tQh+727OWNf8RLEP++V1cHQyc2JaNQOpku+trIrSGLha8UGix/rXvu9z3TJk52ivxhGMteXozh+bn3Wb7c/XtdTGPAiYjNzWm1/uOpDZF68H65Pa7cmxERIr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-tuk_flGuPWqAy7Bypew2Tg-1; Sat, 10 Feb 2024 13:02:41 +0000
X-MC-Unique: tuk_flGuPWqAy7Bypew2Tg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 13:02:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 13:02:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pavel Machek' <pavel@ucw.cz>, Justin Stitt <justinstitt@google.com>
CC: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] string: Allow 2-argument strscpy()
Thread-Topic: [RFC] string: Allow 2-argument strscpy()
Thread-Index: AQHaWe5TIJbv1x38yUWctvLGNyIGYrEDjCtw
Date: Sat, 10 Feb 2024 13:02:20 +0000
Message-ID: <7060edadcbac4452bd70d7894a50568d@AcuMS.aculab.com>
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
>=20
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

An alternative would be to convert xxx(tgt, src, 0) to
xxx(tgt, src, sizeof (tgt) - that is when the specified
length is a compile-time constant zero.

Either with:
=09(__builtin_constat_p(len) && (len) =3D=3D 0 ? sizeof (dst) : (len))
Or, leveraging is_constexpr() and doing (I've probably got the syntax wrong=
):
=09__Generic(0 ? (void *)(len) : (int *)0,
=09=09void *: len,
=09=09int *: sizeof (dst))

That probably needs a helper:
=09is_constzero(value, if_zero, if_non_zero)
to make it more generally useful.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


