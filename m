Return-Path: <linux-kernel+bounces-123538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1E890A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249E91C23A44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6BB12FF95;
	Thu, 28 Mar 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bW8CmYKO"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F71EA6E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656113; cv=none; b=rbPj2ElfHdtmc0gZCWZ/Mhy5hh6WsdxG+sgr3Y/y79XxrQHafrF5FLdW0W9MDYjPHro98lfb+tbrrIZcL0DQAtHgA/Q+J0Y+nH4ZjcRKaOZcDwqTiQo++ESR/+PLSezHigzJhZmRSXYOE5CrkZ1M+oNW+c+H6oiFyblPzY7ozmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656113; c=relaxed/simple;
	bh=P8jZccudYkqES945q0Ut1Lb+avcA1ifhBKmqB9AvAko=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=uV+H/u0ZF1cZzmFYvhJYhT3t2BkJUATBbaRcItSGHzGoEOmnda5xP1jXWcJoY+ViFWzNP/BBYqMKOUb9CobXCSDCaJjo7LUDKd/RDxwIzgWcGwzLl+kSg+2WQinMiNXhdqaG1QtQ1dS1ZIbm8PtGRrVsGsGdljGNThsXsPEqpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bW8CmYKO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240328200142euoutp023a41cb17ab6dc2fca591e4d337c23501~BBif-pFE82272322723euoutp02z;
	Thu, 28 Mar 2024 20:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240328200142euoutp023a41cb17ab6dc2fca591e4d337c23501~BBif-pFE82272322723euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711656102;
	bh=FUHAmFE1jPsyGY3FGfhuWJKOZo6nqnOFwAUmyJ4+EqA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bW8CmYKOxd6yFp+xzPDfzaxIkYhYOmyuMz0Ss9ggagFf3lwZBuRYhLsV2SCEVTo+t
	 vPsHOkaPkwVHGdUSr7xkQWuCgZuEJ4dPQCNxkRNLnz/oQLXZCCy2RRUou5LlPXU/e2
	 rTyrwXX0ZAvX1hrgpe6GiLmi5RVBDAzEuEQcpVsg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240328200141eucas1p2b144a36d6e3d9e37af6be159a6c76c00~BBifsSxo40307803078eucas1p2x;
	Thu, 28 Mar 2024 20:01:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.4C.09539.5ACC5066; Thu, 28
	Mar 2024 20:01:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240328200141eucas1p2f85de76e86cb8cc192b0d495279af934~BBifZQt_t0306403064eucas1p2o;
	Thu, 28 Mar 2024 20:01:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240328200141eusmtrp1a6a835c9571e235918655c002e49daad~BBifYvtSX2279422794eusmtrp1I;
	Thu, 28 Mar 2024 20:01:41 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-c5-6605cca5d2ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.39.10702.5ACC5066; Thu, 28
	Mar 2024 20:01:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240328200141eusmtip155b8fac5558877af60a9ccb98b044aa7~BBifPuWQF0094500945eusmtip1N;
	Thu, 28 Mar 2024 20:01:41 +0000 (GMT)
Received: from localhost (106.210.248.208) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 28 Mar 2024 20:01:40 +0000
Date: Thu, 28 Mar 2024 17:53:41 +0100
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>, "Eric W . Biederman"
	<ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: move the extra1/2 boundary check of u8 to
 sysctl_check_table_array
Message-ID: <20240328165341.3ov54gwjymghtp2g@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="o5jgyvl67e7knwjj"
Content-Disposition: inline
In-Reply-To: <tencent_8599CCEFED19AF4A8A5A358862B226FD8A05@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSe0hTYRzl2+69uxutblfBX5pZS1eo2Utx1YoMs1FBEVSwXq68Tm2bsfmq
	KCyGqUmNLGxmZVFamy0bNdRepkwrLR+9lmkvVomzLM3oISu3aw/ov/M7j49z4CO59G3cn0zW
	pDFajUIlIgSYreFby7SzzXjijHbbLImrvh9Jftr0PEnzfrXkQU0JIXEY3iCJ3lyDLyRkx7Lb
	MFlpQQtXZjXlEbIB6wTZ4bp92EpcLpAmMKrkDEY7fUG8IOnpUyNn25WJWef1ViwbnQzIR3wS
	qEiov9eN5yMBSVPnEJxwtHPY4zOCD4NG3OOiqQEE7mr574ThrmEkUY7A7mrk/jHVGsWscAXB
	7WeXeR4Bo0LgR57F+xJBhUNLb6c34EsFwX2niecJcCk7gl69yyv4UAnQnjPkxUJqIRSU5xAs
	Hgt3jE7Mg7lUFlQd6Rj2kMM4AMrdpIfmU4ugtKQGY5tOhq7cJoLFu+Du5Q7vNKAO8qG27zHO
	CrFQUfWWw2If6GlkSwM1HpoKCzA2UIjgpvsjjz3MCMr2DI4k5oH+oXMkEQPVlW5vI6BGg+P9
	WLboaDhkKxqhhZCbQ7NuMZif92IGNLn4n2nF/0wr/juNpcOh9Go/8R8dBmWnXFwWzweLpQ8r
	RTwT8mPSdWolo5upYTIjdAq1Ll2jjNiSqrai4Q/W5G7sr0LHez5F1CEOiepQ8HD4daW5Fflj
	mlQNI/IVVtuxRFqYoNi+g9GmbtKmqxhdHQogMZGfMCQhiKEppSKN2cow2xjtb5VD8v2zOfLB
	qPzZW+j1p98Gi7+ve555adXXwFFTvlw/OibSKc2LexTUrMQqcnOmZkpvRvNmCQoMHYeGxNtT
	pN/Pvfu6wTEwd/cinwuXKlsDAw2OdvGCi4uTna+i56OMUZtvKQ/0uyw/O+c+CB+jrhcl7m0s
	e7IyJjw0ffWK0Iy0ljZBJY1POkZfVQUs1WZUHI0xMSp0Nq52hnmJyogPFJ3ZsTWsJ96KLtq7
	ThEO2rfnQ9vGkrjCssK1G5alxO+MPY3Ld/Gla8xZD2OJE3OUncFdWVHfIqNmJ8lNK7qdhuii
	himfnA194qLm5WG2dS9TxiXZW19MHUqx+En9IuO7r01fHHgg5AZXJMJ0SYqZoVytTvEL3YbG
	Q9sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7pLz7CmGZzuVbR4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi5bVu1gd2DxmN1xk8VjQc57ZY9OqTjaPz5vkPKYcamcJYI3SsynK
	Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3i7/BV7wWaF
	iq/PRBsY50p3MXJySAiYSEw4NYG1i5GLQ0hgKaPEs6l/GCESMhIbv1xlhbCFJf5c62KDKPrI
	KHHj+H5mCGcro8TjuStYQKpYBFQlfneuA+tgE9CROP/mDjOILSIgL3HuySp2kAZmgaOMEm9a
	XoMlhAVSJC61/QGzeQUcJHqWt0GtmMoocXXvFEaIhKDEyZlPgDZwAHWXSRxezglhSkss/8cB
	UsEp4CSxYM4uFohLlSXudpxmg7BrJT7/fcY4gVF4FpJBsxAGzUIYBFLBLKAlcePfSyYMYW2J
	ZQtfM0PYthLr1r1nWcDIvopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwhrcd+7llB+PKVx/1
	DjEycTAeYlQB6ny0YfUFRimWvPy8VCUR3p1HWdKEeFMSK6tSi/Lji0pzUosPMZoCA3Eis5Ro
	cj4wueSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTCleb6z1r6x
	Ie9wts783dd6j8yp9Hp/vsnslU2Xm55j26PrWyastFZWWv6ZuUhX+4KuvdAM+6hnW97kzNP/
	3L4h74n6ffOjaU/n7Mo6EfPkxN+rRZpaCnPnBiQr/XzD/tDiYO3JJo9stm0+7DcXb926sW5m
	+NoZX/fJVTyRDNBnT3GTif6eLH764I85jOmrS60XJehW7nhVdjhXk3NFy/1c8VN3JIpjgju8
	P5dUHmHoZZ2+1GFNMN8LC4cUUcV7x454Cx5nUfQK4qwO+8t+QPKBTfj/U89NHY8FWTIfuMqZ
	uFjkn7b2uqxJb9v6pCs3n/edHnzm6D+On7zRxWdEf/otvx1Yy/5S+PKSn0cmhPkosRRnJBpq
	MRcVJwIAwITzbXYDAAA=
X-CMS-MailID: 20240328200141eucas1p2f85de76e86cb8cc192b0d495279af934
X-Msg-Generator: CA
X-RootMTR: 20240302152805eucas1p22ac49edeee0be22bcf5562daeba11716
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240302152805eucas1p22ac49edeee0be22bcf5562daeba11716
References: <CGME20240302152805eucas1p22ac49edeee0be22bcf5562daeba11716@eucas1p2.samsung.com>
	<tencent_8599CCEFED19AF4A8A5A358862B226FD8A05@qq.com>

--o5jgyvl67e7knwjj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 11:27:45PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20

<--- snip --->

> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 6ef887c19c48..84e759a8328f 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -367,6 +367,35 @@ static void sysctl_test_api_dointvec_write_single_gr=
eater_int_max(
>  	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
>  }
> =20
> +/*
> + * Test that registering an invalid extra value is not allowed.
> + */
> +static void sysctl_test_register_sysctl_sz_invalid_extra_value(
> +		struct kunit *test)
> +{
> +	unsigned char data =3D 0;
> +	struct ctl_table table[] =3D {
I'm pretty sure that this is going to clash with the constification that
Thomas is working on. Please re-work this patch knowing that these
ctl_tables are going to have to change to const at some point.

> +		{
> +			.procname	=3D "foo",
> +			.data		=3D &data,
> +			.maxlen		=3D sizeof(u8),
> +			.mode		=3D 0644,
> +			.proc_handler	=3D proc_dou8vec_minmax,
> +			.extra1		=3D SYSCTL_ZERO,
> +			.extra2		=3D SYSCTL_ONE_THOUSAND,
> +		},
> +		{}
Don't use the sentinel here. We are removing them and all new sysctl
tables (even the test ones) should be created without them

> +	};
> +	unsigned int size =3D ARRAY_SIZE(table);
You do not need size here. When you use register_sysctl, the size will
be automatically calculated for you.

> +
> +	KUNIT_EXPECT_NULL(test, register_sysctl_sz("foo", table, size));
> +	table[0].extra1 =3D SYSCTL_ONE_THOUSAND;
> +	KUNIT_EXPECT_NULL(test, register_sysctl_sz("foo", table, size));
> +	table[0].extra1 =3D SYSCTL_ONE_HUNDRED;
> +	table[0].extra2 =3D SYSCTL_TWO_HUNDRED;
> +	KUNIT_EXPECT_NOT_NULL(test, register_sysctl_sz("foo", table, size));
Replace all these by register_sysctl please.

> +}
> +
>  static struct kunit_case sysctl_test_cases[] =3D {
>  	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
>  	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
> @@ -378,6 +407,7 @@ static struct kunit_case sysctl_test_cases[] =3D {
>  	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
>  	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
>  	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
> +	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
>  	{}
>  };
> =20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f67b39d3d6e5..28888744626a 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -977,16 +977,10 @@ int proc_dou8vec_minmax(struct ctl_table *table, in=
t write,
>  	if (table->maxlen !=3D sizeof(u8))
>  		return -EINVAL;
> =20
> -	if (table->extra1) {
> -		min =3D *(unsigned int *) table->extra1;
> -		if (min > 255U)
> -			return -EINVAL;
> -	}
> -	if (table->extra2) {
> -		max =3D *(unsigned int *) table->extra2;
> -		if (max > 255U)
> -			return -EINVAL;
> -	}
> +	if (table->extra1)
> +		min =3D *(unsigned char *) table->extra1;
> +	if (table->extra2)
> +		max =3D *(unsigned char *) table->extra2;
> =20
>  	tmp =3D *table;
> =20
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--o5jgyvl67e7knwjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYFoJUACgkQupfNUreW
QU8CjQv+Pgocvz4Gd33upP9+RQKbhhX72UVKZFRIIwEViy/M93mkHVAH/OzSwA6x
TMht01qmi2ZtFJjUM4N6WdHnzLtflrDKLqUasdOjvF5ufrBKxa0dj548Xfqg4xHi
06vRchhZbfaRK3Sj5F3E4X3gNAkgY0sfz/ugRw7ZUAx0logTh8lxk/7Yz7kyY/fN
AZGL/3ITwopK/7hb8csHFLndg94LGXTgpvj9yZtql+cKfgRng2AU2MGISUkSJpz1
QBkLDP1Njp48t+YeY5oN4qyeFihD6v/ZaIpGBUFsluVCThMy5I0OEg27O3s++nZX
PTdjkxOR57S1cvn6vlTXgjDgUy8AS5QlxzP2gKPcuhdMdIyGFHFliftG70GnFmk2
05JIeM1HEGxEM+UMgxSsnsEilZoegTZ/KrYMdLJ62fIYdlcaZucCVZhf/BHVoRtA
yTWvNlY3mu0t5uTJwkdDMdPnmnJC1oAtLqGp7PXSY/7s4y3c9M5hG4DPjpK+FPsR
6kWYpr5x
=kGut
-----END PGP SIGNATURE-----

--o5jgyvl67e7knwjj--

