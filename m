Return-Path: <linux-kernel+bounces-18327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2B1825B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FE5285CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F791DFF3;
	Fri,  5 Jan 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nZhuiscr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3201DFC3;
	Fri,  5 Jan 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704486725; x=1705091525; i=markus.elfring@web.de;
	bh=XGJHY7BedW17ZVM0oJStSYNJNEGaJoAYc7/aRbjvsHk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=nZhuiscruCjRi7o9uQUzT7emYJry3MpX8LYVmegrvIMK9eUKV8PQnO1tjibz6A5T
	 qmTUdVb3Q8zrGHA5TqIY3JEFGHTekMk8TPPEGvix0SIifr31K0dtkzk+DISGzGI0H
	 YkIoS0NvOJAH8n2U58hh0XyE3GYYH+5lEr44zA5jkIkbFh0oAZRCY2Hf4OZyxqnD+
	 VOpM2TEQUjUvLFiqyVdzWAo6hyYxxs/zIgqnjoVdzmqELX9igW5M3dcBVM/Js5Hs/
	 9k2nf8XUYp8gtiVuETI/6Cz+YbHqEwRRSDIqeIk+8B/5fHuvDp314xi/d5E+O+6pc
	 umhbXxM6ws/ijYVomg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1r9nfM3ug0-015UC2; Fri, 05
 Jan 2024 21:32:04 +0100
Message-ID: <71892e93-1545-4d04-9570-a15672f60e81@web.de>
Date: Fri, 5 Jan 2024 21:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Improve exception handling in
 squashfs_decompressor_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de>
In-Reply-To: <f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Da2fsFoH9DyjyKLEhNG5crxXXvNF9eQ324haxaVQO6ouX0qrq4p
 FoNEhMV+Ywrn993YlIs6lVdmca+/cViI2F9a6pXEf+MEGmOh1FmuYN0LM3mw4ote1T8siDU
 PCjwfOXktl9gL3xQ2tMl/PXTYuXmv5lluB5LdlSYmPYtzeDddRsACp+HkvL78bc3AkBMofj
 PU29q75GXd8fRwwwaLsOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PrI7ZW5BXWo=;rKRQjP/bvgnDb+9M7QFvxNffpeG
 3nLrZqmPUGvofAN6ogHB8IeUxhRwGYW54sjhYh6qn33T9LW4At0WBlA4qsTc1hFOcQEJiKe46
 o87JoNVJGg7FcGuzxyallP8ypIdzNV4BL4v0yo2yepmoC9sndWGRpXKa8WSPWMKWRC/XLiHmS
 5A2vWqm0oHqHh+t/YJYbUbquHYxv4Z9jF4u4OkyboXz3P/kWyMoONQKPp74CqCv6imOS4nQEI
 /Th+80fPjtTrNK0CtE6APy0ZUx1v/rhji04Mt43an2a5E3fYNWUJQJHqppztkP+H3N4q7vrNh
 sAFzqVoqEzhftCB0xNk+DUbjiSo+cotgO8fuPgeWL6/AGLFkCr8ZBHHAYKUsS2W8y6lonvwF7
 k0jKB3vQxU/p/vG2Tve4ck2FuLVv1RvYnxPsRZ/5uyAgG7XBcCGh5zMzyyJUekHY66iVkgfBz
 Ez9Luy0acgWcTnT8HEOHhAbjEapcOaNldgpeKk+HcyBVmLF3O5uSC7uJjyv9Xh5S+aTvKSMqm
 G4+2tfBcMjMjCBR9eC2+HQwk7cSFW9+GlHgwF9goJO3uBpUP+bc+ErETWi5URwktt0OOhMp/q
 00GaBNbabX7z6pokXZlJkNUwH0PNRi74xvHinQ1pOscvsv/b9Tu7tPrC8f4fPmOyktKtVVD0D
 mtMCul58YjzqrQ8LepEcd8aPaK2q9EI/oqYZqHrDe3CqVjDRrkDKwzaeaK4hFmRNi3S9rMUBx
 Tg9N5ZnmCIcQDFULcG7TQFgOe4ue6SGC+6n1CphwvmqRBwAri97wV4lZMGt9YJCtZpTJPFk4U
 kIvAc9rLTe6Zj9sMmOHMIwvWbqUg3gtaVouf43zeylfNZz0wPy6mzXNKGa/7Tqmg7daiqFmw6
 CuEXaKkw3XXIn8xQt4GUEGLWBKAywj5QVO9EMgLxLKu2d+0gf3DzvGuVr1gtHPwNpt+/vj5tr
 rhbIBgNcAApLfOAeUAsIEsP1wEs=

> Date: Thu, 30 Mar 2023 18:03:47 +0200
>
> The label =E2=80=9Cout=E2=80=9D was used to jump to a kfree() call despi=
te of
> the detail in the implementation of the function
> =E2=80=9Csquashfs_decompressor_create=E2=80=9D that it was determined al=
ready
> that a corresponding variable contained a null pointer because of
> a failed memory allocation.
>
> Thus perform the following adjustments:
>
> 1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
>    at the beginning.
>
> 2. Use more appropriate labels instead.
>
> 3. Omit extra initialisations (for the variables =E2=80=9Cdecomp_strm=E2=
=80=9D and =E2=80=9Cerr=E2=80=9D)
>    which became unnecessary with this refactoring.
>
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/squashfs/decompressor_multi.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor=
_multi.c
> index 416c53eedbd1..0a054ba4c541 100644
> --- a/fs/squashfs/decompressor_multi.c
> +++ b/fs/squashfs/decompressor_multi.c
> @@ -62,12 +62,12 @@ static void *squashfs_decompressor_create(struct squ=
ashfs_sb_info *msblk,
>  				void *comp_opts)
>  {
>  	struct squashfs_stream *stream;
> -	struct decomp_stream *decomp_strm =3D NULL;
> -	int err =3D -ENOMEM;
> +	struct decomp_stream *decomp_strm;
> +	int err;
>
>  	stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);
>  	if (!stream)
> -		goto out;
> +		return ERR_PTR(-ENOMEM);
>
>  	stream->comp_opts =3D comp_opts;
>  	mutex_init(&stream->mutex);
> @@ -81,22 +81,25 @@ static void *squashfs_decompressor_create(struct squ=
ashfs_sb_info *msblk,
>  	 * file system works.
>  	 */
>  	decomp_strm =3D kmalloc(sizeof(*decomp_strm), GFP_KERNEL);
> -	if (!decomp_strm)
> -		goto out;
> +	if (!decomp_strm) {
> +		err =3D -ENOMEM;
> +		goto free_stream;
> +	}
>
>  	decomp_strm->stream =3D msblk->decompressor->init(msblk,
>  						stream->comp_opts);
>  	if (IS_ERR(decomp_strm->stream)) {
>  		err =3D PTR_ERR(decomp_strm->stream);
> -		goto out;
> +		goto free_decomp_stream;
>  	}
>
>  	list_add(&decomp_strm->list, &stream->strm_list);
>  	stream->avail_decomp =3D 1;
>  	return stream;
>
> -out:
> +free_decomp_stream:
>  	kfree(decomp_strm);
> +free_stream:
>  	kfree(stream);
>  	return ERR_PTR(err);
>  }

Is this patch still in review queues?

See also:
https://lore.kernel.org/cocci/f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00120.html

Regards,
Markus

