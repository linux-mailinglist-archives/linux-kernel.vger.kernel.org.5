Return-Path: <linux-kernel+bounces-167693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94B8BAD86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B5D1F22852
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF6153838;
	Fri,  3 May 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fu9yoDt2"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4515357D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742354; cv=none; b=dlDz3odtJynOAaYb0ohJseOCxMVQ6Zcb5nYiJ7BDe0HzPdonPaXlQq8doJ8EwmnZJdnh+eVxiDGFLoTe9MuMpZg/ZHGm307Pvq0JYyvVijpxw6AeriT7bbE/v/0guA0seQKMZ3SzaJ7SpegsI/VHEIFUrt44lSzxJsIbfcsM5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742354; c=relaxed/simple;
	bh=dbK614Ny0Ax0eFq+sq8LyhVNe+/7K/IG3ecTbPe+KeQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=JuB71rYboze7qUV3gJ5WRdNd5zGzhz+s2S9rW7K2I+ZyaB1oP2oUjBkJxvSRiJqghgSfpeJT8HrXSU6iyg+lo8pbdKRE2Z7Xt2mRaLtfokuxymOm+IgOtwkLW0hRe779cqBdjpZvOaOmMK6OPzKShWV//E1W1cOWtSARdv8fWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fu9yoDt2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240503131904euoutp021fd6b571b71fd1d5338becd30d275a1a~L-RPZTFR02451024510euoutp02J;
	Fri,  3 May 2024 13:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240503131904euoutp021fd6b571b71fd1d5338becd30d275a1a~L-RPZTFR02451024510euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714742344;
	bh=etJsDlA9FEYnPJDiYXGITIvR7FE1m/kBa/g7gmo9+hU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fu9yoDt20viYTS+3TLs78ICZ9KZQAvwdNyagUyD1ciP/yMSSmOA4MptHi5rQtIizx
	 R1i26A5aaKa+b7ZUo+wMxne6Sc05sGJzpqUU3rNyaztjO9XHVDD6XkrKEUNr/U6erw
	 u7PiAx5RrsBEC7ZR6xsqStlgy02+kEP5Xp84zt4w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240503131904eucas1p2ac80a8197e8d141141078ab2ed68ffa5~L-RO1KlpI2734527345eucas1p2D;
	Fri,  3 May 2024 13:19:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.FC.09620.844E4366; Fri,  3
	May 2024 14:19:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503131903eucas1p16f1517f4dc0eec69433ef194071151a4~L-ROXHn251728917289eucas1p1p;
	Fri,  3 May 2024 13:19:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240503131903eusmtrp17fb546bfc62c1975c7029383043b0792~L-ROWdkbG1648916489eusmtrp1L;
	Fri,  3 May 2024 13:19:03 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-86-6634e4486e8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.FD.08810.744E4366; Fri,  3
	May 2024 14:19:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240503131903eusmtip2e902030fbdbd323a01f8aa7587635977~L-ROGvfN-0536805368eusmtip2O;
	Fri,  3 May 2024 13:19:03 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 14:19:02 +0100
Date: Fri, 3 May 2024 15:18:57 +0200
From: Joel Granados <j.granados@samsung.com>
To: Wen Yang <wen.yang@linux.dev>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] sysctl: move the extra1/2 boundary check of u8 to
 sysctl_check_table_array
Message-ID: <20240503131857.7oqxlxckdmd2qzyn@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="u4b4sobnu47ymwhr"
Content-Disposition: inline
In-Reply-To: <20240419033639.259471-1-wen.yang@linux.dev>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87oeT0zSDLa+Zrd4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi/dr7rM6sHnMbrjI4rFpVSebx8KGqcwenzfJeUw51M4SwBrFZZOS
	mpNZllqkb5fAlXHy1la2gvkCFdd3dLE2ML7h7WLk5JAQMJGYO7+VsYuRi0NIYAWjxNIlr9gg
	nC+MErPfzoByPjNKHP+6gQWmZd+/JhaIxHJGifvdT9jhqh6+74IatoVRYtufc8wgLSwCKhKz
	b35jA7HZBHQkzr+5AxYXEVCUmLt3ERNIA7PAUUaJ7fO7wIqEBVIkrj+6xgRi8wo4SCxr28II
	YQtKnJz5BOwOZoEKidcfFgOt5gCypSWW/+MACXMKWEpM7lrIDHGqssSR7XPZIexaiVNbboHt
	khDo55SYtmwfI0TCRWJT7xUoW1ji1fEtUA0yEqcn97BANExmlNj/7wM7hLOaUWJZ41cmiCpr
	iZYrT8CukBBwlFjyTwrC5JO48VYQ4k4+iUnbpjNDhHklOtqEIBrVJFbfe8MygVF5FpLPZiH5
	bBbCZxBhHYkFuz+xYQhrSyxb+JoZwraVWLfuPcsCRvZVjOKppcW56anFxnmp5XrFibnFpXnp
	esn5uZsYgSns9L/jX3cwrnj1Ue8QIxMH4yFGFaDmRxtWX2CUYsnLz0tVEuHVnmycJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cAkfWDS53e3hBunVXe3
	iTmdun0kyibjmFeW+QqH7LvXk9Pld3UL/VEwFFF+5BO2P/HrQ/Hy/VcPqhdv+zvj+sL/u05w
	Km55c311kmjDu+yun/l3w79zLI0+qKl0T6+wyKLk0t5dflnS1vJu63nELm/KvXZrs8WqyC2b
	yj+dEg54m8YoWzfZUyDl5YbmXoeqVxlts1XX3sw4f+X7vA1vr21JTM6NkYhNux+UenHK6YdT
	jk34umLVnmMfDl5P2KjW/fL4he8OS/sn6Af4s0Sf6+Z9Mr1nI28Vp40j94yCbxNFPkmduXYs
	IrG0V1FQ81No15aTTv4LXswpjxFoyzS+8keqLXKp9YT+VBtb/9biGSffK7EUZyQaajEXFScC
	ACBlu7TcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7ruT0zSDKae0bB4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi/dr7rM6sHnMbrjI4rFpVSebx8KGqcwenzfJeUw51M4SwBqlZ1OU
	X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Fjf0rBXIGK
	ezdOsjQwvuLtYuTkkBAwkdj3r4kFxBYSWMooceWNOURcRmLjl6usELawxJ9rXWxdjFxANR8Z
	JSZvmMQO4WxhlDh/fD47SBWLgIrE7Jvf2EBsNgEdifNv7jCD2CICihJz9y5iAmlgFjjKKLF9
	fhdYkbBAisT1R9eYQGxeAQeJZW1bGCGm9jBKrF55ASohKHFy5hOw+5gFyiS6Ph0EuokDyJaW
	WP6PAyTMKWApMblrITPEqcoSR7bPZYewayU+/33GOIFReBaSSbOQTJqFMAkirCVx499LJgxh
	bYllC18zQ9i2EuvWvWdZwMi+ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzCKtx37uXkH47xX
	H/UOMTJxMB5iVAHqfLRh9QVGKZa8/LxUJRFe7cnGaUK8KYmVValF+fFFpTmpxYcYTYHBOJFZ
	SjQ5H5he8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamHa4dssf
	mpWy70VZfrrU5vymxAsycX7f5vBpsZuwabtclDD2nT0tJ2zFxS/blq2Uc04Lut91e5HY29Uf
	dfuvf0lmjvUwNF5y7bmt2uPsSRs2yJ72nvYiaPeb5OkxpZZHchceji3ytz/rYfktq0suds78
	N8LirnenXspo6M1xS3d6y5AaY68owRTedfLTjWPfnl6/sOys7BV7dv3/0ZLbApK1PnXrcMRy
	3Diw2JhNl+mS7PbSQh6vC/Y/+JuFur9pGE8LLP60wX/O7PDfV3YfXHIx+SIz72v+a3ez2OK3
	/5ebe9Z46uJwZ+mO+e1Xez6kr1mt7fLiep2E9f/zlXcWvFQ7KWSQkDszfWr2DN4LO5VYijMS
	DbWYi4oTAQFzQkd3AwAA
X-CMS-MailID: 20240503131903eucas1p16f1517f4dc0eec69433ef194071151a4
X-Msg-Generator: CA
X-RootMTR: 20240419033727eucas1p1c7c7bbd508cf24066b5971c1015bd00c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240419033727eucas1p1c7c7bbd508cf24066b5971c1015bd00c
References: <CGME20240419033727eucas1p1c7c7bbd508cf24066b5971c1015bd00c@eucas1p1.samsung.com>
	<20240419033639.259471-1-wen.yang@linux.dev>

--u4b4sobnu47ymwhr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:36:39AM +0800, Wen Yang wrote:
> Move boundary checking for proc_dou8ved_minmax into module loading, there=
by
> reporting errors in advance. And add a kunit test case ensuring the
> boundary check is done correctly.
>=20
=2E..
> +	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
>  	{}
>  };
> =20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e0b917328cf9..c0a1164eaf59 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -977,16 +977,10 @@ int proc_dou8vec_minmax(struct ctl_table *table, in=
t write,
>  	if (table->maxlen !=3D sizeof(u8))
>  		return -EINVAL;
> =20
> -	if (table->extra1) {
> +	if (table->extra1)
>  		min =3D *(unsigned int *) table->extra1;
> -		if (min > 255U)
> -			return -EINVAL;
> -	}
> -	if (table->extra2) {
> +	if (table->extra2)
>  		max =3D *(unsigned int *) table->extra2;
> -		if (max > 255U)
> -			return -EINVAL;
> -	}
> =20
>  	tmp =3D *table;
> =20
> --=20
> 2.25.1
>=20

Queueing this up for 6.11. I'll put it into sysclt-testing.

Reviewed-by: Joel Granados <j.granados@samsung.com>
--=20

Joel Granados

--u4b4sobnu47ymwhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY05EEACgkQupfNUreW
QU/uCAv+N3mG6q8G+JDitzIbzSsE8qy8zA2NFeABhlaHgZRkij0LB6zmqhr4a7zK
n2rGDkPvUPDKfpb9tAzaQdsRUsqt1/jh5re6pZTfmP1w3G0bgEdRN2TIUv1hH5Cy
cVqPJKWngxusOQSkSEDqalhgIJvptorO7B18rLVMAyL32r/VLpKiPHCP2v8FIuBv
jTveLrEylGNsnfI/zdSFz1JX83jXWpP4fQF8tBbR597bc0aApPSU2uZetkkFXoTA
PxeSg6THZdiEJNgJ60HkhEMSd/gDgSzkTlIgOEsuWjq2qqq1GANfX5PjW6PL73lb
DuqCySBtk1Mg6D2Y4TZUYDHdZPIra228I0HVrv7uUw1z8A36m80YSwKPPDUnLxdW
73C5rFqHFjlsKdogYPPbB9ktMW6jnbyRjmjfiol9asqfjINJMqQPgN4K+0O/o0um
6oBRwdN2hSPgfW0j3cbcA5ruKrDLFylZjRUoLcHt0ZxAqDLSLSvLsBoET/jpTBQr
J8++X6yL
=L8lR
-----END PGP SIGNATURE-----

--u4b4sobnu47ymwhr--

