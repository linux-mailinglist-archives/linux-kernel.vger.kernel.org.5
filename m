Return-Path: <linux-kernel+bounces-98280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DD8777D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158671C20BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846E39863;
	Sun, 10 Mar 2024 17:46:17 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA622095
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710092777; cv=none; b=gpatwqQ5NtT2C5Fxt3BvEgNQhgSJ1BVRDuVyrFa5ovL4gmbO527pvSCLBsyXMdYwZQ1OYVRuVjfwf84AeAtJoLDs+R4qIJSeYIzg9eL2Be0778mVFKPabTg0NSTzbmFHVlw2cJMzqgFxo0mbOyQa2wn40KExek+mH1mDSFBOyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710092777; c=relaxed/simple;
	bh=lB8sugSUXfFyv+Sre1/DGzaB1T5lAslkw2tMj3pndpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HsOKmx/CEOKrHlC/mvgJVweXThJkfyR0pnyuDwp7YMbCXAEzQhwmw1lBNrFFWeGxHHghI9VPCn439IV/Frf/KAE8CLnPBCsu450UQ0RPGnhV/oC7dQJVUbn2ghqpuwGoTbWComXt6Flqc8P1pAJOKShPKdLbEjU/GzFGLULAmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-114-TNp10J7jNWOsLS4FIbmhqQ-1; Sun, 10 Mar 2024 17:46:05 +0000
X-MC-Unique: TNp10J7jNWOsLS4FIbmhqQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Mar
 2024 17:46:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Mar 2024 17:46:15 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Roman Smirnov' <r.smirnov@omp.ru>, Jaegeuk Kim <jaegeuk@kernel.org>,
	"Chao Yu" <chao@kernel.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich
	<k.yankevich@omp.ru>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
Thread-Topic: [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
Thread-Index: AQHabtSs8qQLngIY8Ey8WBtnYc/JqbExQp7Q
Date: Sun, 10 Mar 2024 17:46:14 +0000
Message-ID: <b4f9780714e243a6af9f77ab00593ec1@AcuMS.aculab.com>
References: <20240305080943.6922-1-r.smirnov@omp.ru>
In-Reply-To: <20240305080943.6922-1-r.smirnov@omp.ru>
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

From: Roman Smirnov
> Sent: 05 March 2024 08:10
>=20
> Cast expression type to unsigned long in __count_extent_cache()
> to prevent integer overflow.
>=20
> Found by Linux Verification Center (linuxtesting.org) with Svace.

Another broken analysis tool :-)

> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  fs/f2fs/shrinker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index 83d6fb97dcae..bb86a06c5d5e 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -33,7 +33,7 @@ static unsigned long __count_extent_cache(struct f2fs_s=
b_info *sbi,
>  {
>  =09struct extent_tree_info *eti =3D &sbi->extent_tree[type];
>=20
> -=09return atomic_read(&eti->total_zombie_tree) +
> +=09return (unsigned long)atomic_read(&eti->total_zombie_tree) +
>  =09=09=09=09atomic_read(&eti->total_ext_node);

Makes diddly-squit difference.

Both total_zombie_tree and totat_ext_node are 'int'.
If they are large enough that their sum wraps then the values
can individually wrap (to negative values).

You really don't want to cast 'int' to 'unsigned long' here
at all - implicitly or explicitly.
The cast will first promote 'int' to 'signed long'.
So a negative value will get sign extended to a very big value.

The best you can hope for is a 33bit result from wrapped 32bit
signed counters.
To get that you need to convert 'int' =3D> 'unsigned int' =3D> 'unsigned lo=
ng'.
One way would be:
=09return (atomic_read(&eti->total_zombie_tree) + 0u + 0ul) +
=09=09(atomic_read(&eti->total_ext_node) + 0u);

Although changing the return type to 'unsigned int' would probably
be better.
I don't know what the values are, but if they are stats counters
then that would give a value that nicely wraps at 2^32 rather
that the strange wrap that the sum of two wrapping 32bit counters
has.

OTOH it may be that they are counts - and just can't get any where
near that big.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


