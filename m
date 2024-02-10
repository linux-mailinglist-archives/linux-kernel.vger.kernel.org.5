Return-Path: <linux-kernel+bounces-60392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5B850456
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF1A1C2172D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF53DBAE;
	Sat, 10 Feb 2024 12:04:50 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED073AC01
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707566689; cv=none; b=l543hAT6OU6E9BCGzTOLco90SE3yX4SR27zn0nmdE3YyqoRC6eSFXrNP/05HfgSqEstIhr4Wmk7w44skaUmzD/9UlkU7kpL6zWntAf/bBQy47DHvgVgCQoSBz8zfQ7syjfCErXjvP5+SS6cToYtJ2t5MdUpfrJgeoJeQAKbXoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707566689; c=relaxed/simple;
	bh=LmGQplIF0L+TLh7WXfLUfpjsi68X6k0Q41MVwaSa2Fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Walp4kzj0Gva2CnKSglztmGq8fyneT68FU1mIEYGamSdKQQVRLIc/Jxd4V9LDKkhi2VtOODdHQsm9dlelxrOxD7Is+b7y7c7WQ7HLa34d0Tth3cy3np0+PrWukUjH0ZpzflypeYrTyiDnpDDYChUIP2Yet0PrJRbRcGhLCpflPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-y6Y1z5q0NDKk8VFe6X7J-Q-1; Sat, 10 Feb 2024 12:04:34 +0000
X-MC-Unique: y6Y1z5q0NDKk8VFe6X7J-Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 12:04:13 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 12:04:13 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Abhishek Pandit-Subedi
	<abhishekpandit@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pmalani@chromium.org" <pmalani@chromium.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Herve Codina <herve.codina@bootlin.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: RE: [PATCH] minmax: Add notes to min_t and max_t
Thread-Topic: [PATCH] minmax: Add notes to min_t and max_t
Thread-Index: AQHaW7Nx45oiUu9p/0WW4Q/mr4OAO7EDcOQQ
Date: Sat, 10 Feb 2024 12:04:13 +0000
Message-ID: <65ba51bc65b24c13af4ce02e79f78dee@AcuMS.aculab.com>
References: <20240209150657.1.I45addf7579e1233fa97c05ba72120cd1c57b4310@changeid>
 <202402091551.16A4A2A7F@keescook>
In-Reply-To: <202402091551.16A4A2A7F@keescook>
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

From: Kees Cook
> Sent: 09 February 2024 23:56
>=20
> On Fri, Feb 09, 2024 at 03:07:02PM -0800, Abhishek Pandit-Subedi wrote:
> > Both min_t and max_t are problematic as they can hide issues when
> > comparing differently sized types (and especially differently signed
> > types). Update the comments to nudge users to other options until
> > there is a better fix for these macros.
> >
> > Link: https://lore.kernel.org/all/01e3e09005e9434b8f558a893a47c053@AcuM=
S.aculab.com/
> > Link: https://lore.kernel.org/all/CAHk-
> =3DwhwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com/
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> > Andy Shevchenko made me aware of this particular footgun in
> > https://lore.kernel.org/linux-usb/ZcZ_he1jYx8w57mK@smile.fi.intel.com/.
> >
> > While David + others work on the full fix, I'm hoping to apply a
> > bandaid in the form of comments so the problem doesn't get worse by dev=
s
> > (**cough** me **cough**) inadvertently doing the wrong thing.

I'm not sure that adding a comment here actually helps.
If you read it you probably know what is happening!

With the changes I did (which I think got back-ported at least
one release) it is actually moderately unlikely that you'll need
to use min_t() or max_t() (and especially clamp_val() - definitely
an accident waiting to happen).

I think there is only one clamp_val() that can't just be replaced
with clamp().

I did post an updated set that really just reduce the generated
line length - I probably need to report them to wake people up.

> I think a better example for the docs would be something like u16
> (rather than size_t) which shows very quickly the potential for
> truncation. See, for example:
>=20
> https://lore.kernel.org/all/20230811054528.never.165-kees@kernel.org/

(I'd found that one when I tried to build with min_t() being min().
The bug was reported not long after!)

Or an example using 'unsigned char' - there are some very dubious
ones lurking.

Also look at the code in tcp/udp that validates the length argument
to getsockopt().
It checks for negative after doing min_t(unsigned, len, 4).
It has always been thus, well before min_t() was added.

..
> >  /**
> >   * min_t - return minimum of two values, using the specified type
> > + *
> > + * Note: Downcasting types in this macro can cause incorrect results. =
Prefer to
> > + * use min() which does typechecking.
> > + *
> > + * Prefer to use clamp if you are trying to compare to size_t.
> > + *
> > + * Don't:
> > + *   min_t(size_t, buf_size, sizeof(foobar))
> > + *
> > + * Do:
> > + *  clamp(buf_size, 0, sizeof(foobar))

I'm not at all sure that is actually helpful.
It might be better to just note that min_t(unsigned type, int val, xxx)
will convert a negative value to a large positive one.

In you case size_t is just the wrong type.
You need to change the type of the constant (to int) not the
type of the variable.
So you want:
=09min(buf_size, (int)sizeof(foobar))

I'm not at all sure that min_t() (casting both args) is actually
a good idea, requiring the codes explicitly cast one (usually only
one needs a cast) is likely to be less buggy, more obvious, and
less typing.

I think min_t() exists because it is an exact replacement for
a static inline function where the cast was implicit in the call.

Linus didn't like the change that would allow:
=09min(int_size, sizeof(fubar))
(ie implicitly casting unsigned constants to int before
the compare.)
It does make the defines rather more complicated.

Thinking... it might me easier to add smin() (cf umin())
that will convert an unsigned constant to int
(and error for non-constant unsigned arguments).
That would be much safer than min_t() and save all the extra
complication min() would need, and also annotate the source.

A long term plan would be to remove all the min_t() and max_t().
Sorting out some patches for simple cases (both args unsigned
and the same size would be a start) isn't that hard.
But they do need to get applied.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


