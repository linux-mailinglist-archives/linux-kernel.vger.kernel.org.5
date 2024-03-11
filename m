Return-Path: <linux-kernel+bounces-99558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256AB8789F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2651F21831
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947756B77;
	Mon, 11 Mar 2024 21:19:54 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C556B62
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191993; cv=none; b=QtjrwUqw/OrV0Q4dvymbeVjFo7Sa6a+Ssu/1Y0Drx+pq3zaDHlaxk6Lz3BwrUDanEYzcFw8LHpViq17u/bF67t3VXuFHA++wMvtky0eOOos8m5ymneJnPIvc245ccKoyw01CgPzWXACgsmnncWIP9wwnCPo0mkfQOhHWvXOnUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191993; c=relaxed/simple;
	bh=i615CRNOuqDgExZzz9+KkVx63j4FWrsDahCeiTAgZuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TIXuVFY/qaVF7ZipVLsED0gFZy7GKfLgeiJcGQQEs/b4DbsL6X3s03GTIRRPAk4vD5/+ORiYMpeawzYJ3yCHTAAUhGdCDrT7NE0+W/gaqmH6YF9qDNM17anKEUZ7FAvtbl+I9MB7BIkKqcrKdUIia6N36JZ4BMqRAjEquXYZZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-70-yp59H5P9N3qvzFeyFl6C3w-1; Mon, 11 Mar 2024 21:19:43 +0000
X-MC-Unique: yp59H5P9N3qvzFeyFl6C3w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Mar
 2024 21:19:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Mar 2024 21:19:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
CC: 'Roman Smirnov' <r.smirnov@omp.ru>, Chao Yu <chao@kernel.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
Thread-Topic: [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
Thread-Index: AQHabtSs8qQLngIY8Ey8WBtnYc/JqbExQp7QgAHHeICAAAg9sA==
Date: Mon, 11 Mar 2024 21:19:48 +0000
Message-ID: <15882d97fc0c4742a119128ccc12b5dd@AcuMS.aculab.com>
References: <20240305080943.6922-1-r.smirnov@omp.ru>
 <b4f9780714e243a6af9f77ab00593ec1@AcuMS.aculab.com>
 <Ze9rb0dRKt98kK54@google.com>
In-Reply-To: <Ze9rb0dRKt98kK54@google.com>
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

From: Jaegeuk Kim
> Sent: 11 March 2024 20:37
> On 03/10, David Laight wrote:
> > From: Roman Smirnov
> > > Sent: 05 March 2024 08:10
> > >
> > > Cast expression type to unsigned long in __count_extent_cache()
> > > to prevent integer overflow.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Svace.
> >
> > Another broken analysis tool :-)
> >
> > > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> > > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > > ---
> > >  fs/f2fs/shrinker.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> > > index 83d6fb97dcae..bb86a06c5d5e 100644
> > > --- a/fs/f2fs/shrinker.c
> > > +++ b/fs/f2fs/shrinker.c
> > > @@ -33,7 +33,7 @@ static unsigned long __count_extent_cache(struct f2=
fs_sb_info *sbi,
> > >  {
> > >  =09struct extent_tree_info *eti =3D &sbi->extent_tree[type];
> > >
> > > -=09return atomic_read(&eti->total_zombie_tree) +
> > > +=09return (unsigned long)atomic_read(&eti->total_zombie_tree) +
> > >  =09=09=09=09atomic_read(&eti->total_ext_node);
> >
> > Makes diddly-squit difference.
> >
> > Both total_zombie_tree and totat_ext_node are 'int'.
> > If they are large enough that their sum wraps then the values
> > can individually wrap (to negative values).
> >
> > You really don't want to cast 'int' to 'unsigned long' here
> > at all - implicitly or explicitly.
> > The cast will first promote 'int' to 'signed long'.
> > So a negative value will get sign extended to a very big value.
>=20
> I thought, since total_zombie_tree won't get overflowed theoritically, th=
e first
> cast to (unsigned long) could expand the space to cover the following
> total_ext_node.

If will force the arithmetic be done as 'unsigned long' so the
second value will go through the integer promotion rules to
get from 'int' to 'unsigned long', there is an intermediate
stage of 'signed long'.
So (on 64bit) the 32bit signed value is sign extended to a
64bit signed value and the converted to 64 bit unsigned (same
bit pattern on 2s compliment systems).
The cast itself will have done the same sign extension on the
first value.

If toal_ext_node can get anywhere near 31 bits it is also likely
to get negative as well.
At which point very silly things happen is pretty much all cases
unless you only zero-extend to 64 bits.

>=20
> >
> > The best you can hope for is a 33bit result from wrapped 32bit
> > signed counters.
> > To get that you need to convert 'int' =3D> 'unsigned int' =3D> 'unsigne=
d long'.
> > One way would be:
> > =09return (atomic_read(&eti->total_zombie_tree) + 0u + 0ul) +
> > =09=09(atomic_read(&eti->total_ext_node) + 0u);
> >
> > Although changing the return type to 'unsigned int' would probably
> > be better.
> > I don't know what the values are, but if they are stats counters
> > then that would give a value that nicely wraps at 2^32 rather
> > that the strange wrap that the sum of two wrapping 32bit counters
> > has.
> >
> > OTOH it may be that they are counts - and just can't get any where
> > near that big.
> >
> > =09David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


