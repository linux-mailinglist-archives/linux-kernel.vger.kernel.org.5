Return-Path: <linux-kernel+bounces-107865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E58802B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CFB1F24FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD21118E;
	Tue, 19 Mar 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e1PIb1lt"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02B3207
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867057; cv=none; b=IsYppHYY0CyNl1146lUZwDSjXvQz39NhbHJeIVGOkqk2eAneUdg2WcGQl5OsJuO5zXKPyS2uhDVHbNVuvitw6k3E0V5ZZG0RmpxcA6Vxb8adjjYKfN/LEjz6O0/B7Q+lwFpID6T2tJUy2Gt/e+YARP+K5mHLm18TGZHPo9uYcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867057; c=relaxed/simple;
	bh=tf6sVJtf46r0yLEuBHfvivUCDDt13rAGZ24GmJuvbMM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=c9kA1mDG8emBMF8eqgGpQdzW9cAuv1U0UXbG5CUGdGHwCA+8K1prPul5C+dFYCtEaAt8Wd6qBEUogAyf6ZMjk7ocRaoVA4QpsQ//etAJhj6z8h4HH4zo+kn8ica9OxFCpVDqCb5rVx2Ncnjn57RUlv2E/ky7iIJK3aJJe7U0GgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e1PIb1lt; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240319165053euoutp012c8ca69642136bdf5001c38f00ac4e68~_OIUrA27J1670116701euoutp01I;
	Tue, 19 Mar 2024 16:50:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240319165053euoutp012c8ca69642136bdf5001c38f00ac4e68~_OIUrA27J1670116701euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710867053;
	bh=Xzjdr/6Hg/nbLvWStbvSdHhTjsBaIyhrKySz08ObNq4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=e1PIb1lt5AqgVCSyN5S+qHhT03wxGd5V1vumTocI/hA/sZSerzSr5ZinyoEjNyBhu
	 1F0jufvaBC2Nj9e1XciXgj5QLjgX5mkE9WWEQobyAV9WIyAYTIDKJ0YVxjob9+x7wg
	 m+zXtg45jdibsnCnU7iZauO8d/0ESpPQR9Rr+eHI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240319165052eucas1p2f11cb77e77ebb312c866a37659664db6~_OIUejyHM2675626756eucas1p2V;
	Tue, 19 Mar 2024 16:50:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BD.BA.09539.C62C9F56; Tue, 19
	Mar 2024 16:50:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240319165052eucas1p287a74af773588c4f82efc6b2be4e47c5~_OIUDlkNP2884828848eucas1p2Z;
	Tue, 19 Mar 2024 16:50:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240319165052eusmtrp2cc5efd943a47a36b70d5655e7cec8332~_OIUC_4rY2588125881eusmtrp2E;
	Tue, 19 Mar 2024 16:50:52 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-1e-65f9c26c6617
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.E7.10702.C62C9F56; Tue, 19
	Mar 2024 16:50:52 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240319165052eusmtip2a2fa49a570c84b8dd60aa588106a8f8c~_OIT0M2Yn1761717617eusmtip2O;
	Tue, 19 Mar 2024 16:50:52 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 16:50:51 +0000
Date: Tue, 19 Mar 2024 17:50:49 +0100
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, Dave Young <dyoung@redhat.com>, Iurii Zaikin
	<yzaikin@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 1/9] sysctl: support encoding values directly
 in the table entry
Message-ID: <20240319165049.d7m4jvwb4qyjtjhq@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="awwnjpzdp4nogjz5"
Content-Disposition: inline
In-Reply-To: <tencent_0D6ABA209A4980742DE6003FBFE7FE2A3207@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djPc7o5h36mGnQc17N4ffgTo0XDxAYW
	i//bWtgtznTnWlzeNYfN4saEp4wWLat3sVos2+nnwOExu+Eii8eCnvPMHgs2lXpsWtXJ5vF+
	31U2j8+b5DymHGpnCWCP4rJJSc3JLEst0rdL4Mr42/OGveBuXMXKznesDYxfPLsYOTkkBEwk
	bl7eydrFyMUhJLCCUeLNoQeMIAkhgS+MElc+mUEkPgMl7p5ig+mYs7KPGSKxnFFicetbNriq
	rVd6WCCcrYwSh373gc1iEVCVWN/ZBmazCehInH9zhxnEFhGQlzj3ZBU7SAOzQBeTxPxNm9lB
	EsICCRIvJneBNfAKOEh86LzACmELSpyc+YQFxGYWqJBo7pkAFOcAsqUllv/jAAlzCjhJLPi1
	nBniVGWJ6/sWQ51dK3Fqyy0mkF0SAqs5Jf713GSESLhIPLv0AqpBWOLV8S3sELaMxP+d86Ea
	JjNK7P/3gR2qm1FiWeNXJogqa4mWK0+gOhwljvw5zgZykYQAn8SNt4IQh/JJTNo2nRkizCvR
	0SYEUa0msfreG5YJjMqzkLw2C8lrsxBegwjrSCzY/YkNQ1hbYtnC18wQtq3EunXvWRYwsq9i
	FE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITHOn/x3/tINx7quPeocYmTgYDzGqADU/2rD6
	AqMUS15+XqqSCC87989UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalF
	MFkmDk6pBqaGXWvcMpzXTa+oN2wWm69fLDzzdJfWAeV1e9b3inksfP8hVUuy+UHNtYwP2SWf
	ThkWVLOukVS9y6B+55POp78yHz6rKv14dWllw9drS1MiH+y4LxTu0jLFvWupu0tm5yybzwGa
	LRMPZXZ9Szxt7JX2srI9vUJna2J17PwjHdVMqvPUvWfW3v4hmy0fvutazXJli/zA+lrJo9Xa
	T1eaP5PNTV+79Nvexw42WROE9TiC00/zegbfja66Yn/38J9+ifu3F2R3X5/jsLTOZsG5e7oT
	d05w1VXQTfoToeD5UJp94cFeP1sNpmURa6aHhike25as+cKRoX/i3jiPxBuekaUZ7YZzTvgd
	/5KXOe3FHiWW4oxEQy3mouJEAFgV6/buAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7o5h36mGpzdLWjx+vAnRouGiQ0s
	Fv+3tbBbnOnOtbi8aw6bxY0JTxktWlbvYrVYttPPgcNjdsNFFo8FPeeZPRZsKvXYtKqTzeP9
	vqtsHp83yXlMOdTOEsAepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJdxfs959oLbcRX3N31naWD85NnFyMkhIWAiMWdlH3MXIxeHkMBSRolFx3qZ
	IRIyEhu/XGWFsIUl/lzrYoMo+sgo0Xl3JyuEs5VR4s+HC0wgVSwCqhLrO9sYQWw2AR2J82/u
	gE0SEZCXOPdkFTtIA7NAF5PE/E2b2UESwgIJEi8md4E18Ao4SHzovAA1dSqjxP7LvawQCUGJ
	kzOfsIDYzAJlEj/P9AHFOYBsaYnl/zhAwpwCThILfi2HOltZ4vq+xWwQdq3E57/PGCcwCs9C
	MmkWkkmzECZBhLUkbvx7yYQhrC2xbOFrZgjbVmLduvcsCxjZVzGKpJYW56bnFhvpFSfmFpfm
	pesl5+duYgRG+7ZjP7fsYFz56qPeIUYmDsZDjCpAnY82rL7AKMWSl5+XqiTCy879M1WINyWx
	siq1KD++qDQntfgQoykwGCcyS4km5wPTUF5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
	dmpqQWoRTB8TB6dUA9PmpXpN2UUpqfvPnpg9k6eHcbq58aJcUfkD/7vevFfkyjive7WrYnu7
	7yneoqb37WkGZx9PqEu69ct/Wv+OxD1rdY+0yGUdNVePeviyev5rMcG/2RNPl85uWmfk81Lx
	8dY11U43vyp++rmrJ0T18vEzhX49LStPv1zsEDZ12ryj21Z9ZizzZsibuO2niHOr5OT55xxq
	OCO/ysS/PXLsjkHJ34scF3tv1b5cIq///+LllaeW/jrpbb20Y7OYQGvXZOli2W/2vcZbBWNL
	fFOytQK663tP3j6hNGGisMnMrlq2GW+eBT1hPW7Itqu7wzTsnEis0Wy+m5EH07NurJKNSH3k
	Xnng95G2lhWh9a1HHMOVWIozEg21mIuKEwF01J7ZiwMAAA==
X-CMS-MailID: 20240319165052eucas1p287a74af773588c4f82efc6b2be4e47c5
X-Msg-Generator: CA
X-RootMTR: 20240319155826eucas1p2af22771faac0985e0097d38e96daac4b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240319155826eucas1p2af22771faac0985e0097d38e96daac4b
References: <CGME20240319155826eucas1p2af22771faac0985e0097d38e96daac4b@eucas1p2.samsung.com>
	<tencent_0D6ABA209A4980742DE6003FBFE7FE2A3207@qq.com>

--awwnjpzdp4nogjz5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a resend on the one 10 days ago. Right?
I have it in my todo list and will get to it eventually. Please stop
resending it if there is no change.

Thx

On Tue, Mar 19, 2024 at 11:57:42PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20
> Eric pointed out:
> - by turning .extra1 and .extra2 into longs instead of keeping them as
>   pointers and needing constants to be pointed at somewhere.
> - The only people I can see who find a significant benefit by consolidati=
ng
>   all of the constants into one place are people who know how to stomp
>   kernel memory.
>=20
> This patch supports encoding values directly in table entries through the
> following work:
> - extra1/extra2 and min/max are placed in one union to ensure that the
>   previous code is not broken, then we have time to remove unnecessary
>   extra1/extra2 progressively;
> - since type only has two states, use one bit to represent it;
> - two bits were used to represent the information of the above union( 0:
>   using extra1/extra2, 1: using min, 2: using max, 3: using both min/max);
> - added some helper macros.
>=20
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/sysctl.h | 108 ++++++++++++++++++++++++++++++++++++++---
>  kernel/sysctl.c        |  61 +++++++++++++++++------
>  2 files changed, 148 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index ee7d33b89e9e..1ba980219e40 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -61,6 +61,25 @@ extern const int sysctl_vals[];
> =20
>  extern const unsigned long sysctl_long_vals[];
> =20
> +#define	SYSCTL_NUMERIC_NEG_ONE			((long)-1)
> +#define	SYSCTL_NUMERIC_ZERO			(0L)
> +#define	SYSCTL_NUMERIC_ONE			(1L)
> +#define	SYSCTL_NUMERIC_TWO			(2L)
> +#define	SYSCTL_NUMERIC_THREE			(3L)
> +#define	SYSCTL_NUMERIC_FOUR			(4L)
> +#define	SYSCTL_NUMERIC_ONE_HUNDRED		(100L)
> +#define	SYSCTL_NUMERIC_TWO_HUNDRED		(200L)
> +#define	SYSCTL_NUMERIC_THREE_HUNDRED		(300L)
> +#define	SYSCTL_NUMERIC_FIVE_HUNDRED		(500L)
> +#define	SYSCTL_NUMERIC_ONE_THOUSAND		(1000L)
> +#define	SYSCTL_NUMERIC_TWO_THOUSAND		(2000L)
> +#define	SYSCTL_NUMERIC_THREE_THOUSAND		(3000L)
> +#define	SYSCTL_NUMERIC_16K			(16384L)
> +#define	SYSCTL_NUMERIC_U8_MAX			((long)U8_MAX)
> +#define	SYSCTL_NUMERIC_U16_MAX			((long)U16_MAX)
> +#define	SYSCTL_NUMERIC_INT_MAX			((long)INT_MAX)
> +#define	SYSCTL_NUMERIC_LONG_MAX			(LONG_MAX)
> +
>  typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
> =20
> @@ -131,6 +150,18 @@ static inline void *proc_sys_poll_event(struct ctl_t=
able_poll *poll)
>  #define DEFINE_CTL_TABLE_POLL(name)					\
>  	struct ctl_table_poll name =3D __CTL_TABLE_POLL_INITIALIZER(name)
> =20
> +enum {
> +	SYSCTL_TABLE_TYPE_DEFAULT,
> +	SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
> +};
> +
> +enum {
> +	SYSCTL_TABLE_EXTRA_PTR,
> +	SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,
> +	SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,
> +	SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX
> +};
> +
>  /* A sysctl table is an array of struct ctl_table: */
>  struct ctl_table {
>  	const char *procname;		/* Text ID for /proc/sys, or zero */
> @@ -138,20 +169,39 @@ struct ctl_table {
>  	int maxlen;
>  	umode_t mode;
>  	/**
> -	 * enum type - Enumeration to differentiate between ctl target types
> +	 * type - Indicates to differentiate between ctl target types
>  	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
>  	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
>  	 *                                       empty directory target to serve
>  	 *                                       as mount point.
>  	 */
> -	enum {
> -		SYSCTL_TABLE_TYPE_DEFAULT,
> -		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
> -	} type;
> +	u8 type:1;
> +
> +	/**
> +	 * extra_flags
> +	 * @SYSCTL_TABLE_EXTRA_PTR: flag indicating that this uses extra1/extra=
2.
> +	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MIN: flag indicating that this uses mi=
n/max
> +					      and min has been initialized.
> +	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MAX: flag indicating that this uses mi=
n/max
> +					      and max has been initialized.
> +	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX: flag indicating that this uses=
 min/max
> +						 and both have been initialized.
> +	 *
> +	 */
> +	u8 extra_flags:2;
> +	union {
> +		struct {
> +			void *extra1;
> +			void *extra2;
> +		};
> +		struct {
> +			long min;
> +			long max;
> +		};
> +	};
> +
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
> -	void *extra1;
> -	void *extra2;
>  } __randomize_layout;
> =20
>  struct ctl_node {
> @@ -213,6 +263,50 @@ struct ctl_table_root {
>  #define register_sysctl(path, table)	\
>  	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> =20
> +#define CTL_TABLE_ENTRY(_name, _data, _len, _mode, _func)		      \
> +	{								      \
> +		.procname =3D _name,					      \
> +		.data =3D _data,						      \
> +		.maxlen =3D _len,						      \
> +		.mode =3D _mode,						      \
> +		.proc_handler =3D _func,					      \
> +		.extra_flags =3D SYSCTL_TABLE_EXTRA_PTR,			      \
> +	}
> +
> +#define CTL_TABLE_ENTRY_MIN(_name, _data, _len, _mode, _func, _min)	    =
  \
> +	{								      \
> +		.procname =3D _name,					      \
> +		.data =3D _data,						      \
> +		.maxlen =3D _len,						      \
> +		.mode =3D _mode,						      \
> +		.proc_handler =3D _func,					      \
> +		.min =3D _min,						      \
> +		.extra_flags =3D SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,	      \
> +	}
> +
> +#define CTL_TABLE_ENTRY_MAX(_name, _data, _len, _mode, _func, _max)	    =
  \
> +	{								      \
> +		.procname =3D _name,					      \
> +		.data =3D _data,						      \
> +		.maxlen =3D _len,						      \
> +		.mode =3D _mode,						      \
> +		.proc_handler =3D _func,					      \
> +		.max =3D _max,						      \
> +		.extra_flags =3D SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,	      \
> +	}
> +
> +#define CTL_TABLE_ENTRY_MINMAX(_name, _data, _len, _mode, _func, _min, _=
max)  \
> +	{								      \
> +		.procname =3D _name,					      \
> +		.data =3D _data,						      \
> +		.maxlen =3D _len,						      \
> +		.mode =3D _mode,						      \
> +		.proc_handler =3D _func,					      \
> +		.min =3D _min,						      \
> +		.max =3D _max,						      \
> +		.extra_flags =3D SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,	      \
> +	}
> +
>  #ifdef CONFIG_SYSCTL
> =20
>  void proc_sys_poll_notify(struct ctl_table_poll *poll);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 157f7ce2942d..144c441236ab 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -822,6 +822,20 @@ struct do_proc_dointvec_minmax_conv_param {
>  	int *max;
>  };
> =20
> +static void do_int_conv_param_init(const struct ctl_table *table,
> +		struct do_proc_dointvec_minmax_conv_param *param)
> +{
> +	if (table->extra_flags =3D=3D SYSCTL_TABLE_EXTRA_PTR) {
> +		param->min =3D table->extra1;
> +		param->max =3D table->extra2;
> +	} else {
> +		param->min =3D (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN)=
 ?
> +			(int *)&table->min : NULL;
> +		param->max =3D (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX)=
 ?
> +			(int *)&table->max : NULL;
> +	}
> +}
> +
>  static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
>  					int *valp,
>  					int write, void *data)
> @@ -867,10 +881,9 @@ static int do_proc_dointvec_minmax_conv(bool *negp, =
unsigned long *lvalp,
>  int proc_dointvec_minmax(struct ctl_table *table, int write,
>  		  void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct do_proc_dointvec_minmax_conv_param param =3D {
> -		.min =3D (int *) table->extra1,
> -		.max =3D (int *) table->extra2,
> -	};
> +	struct do_proc_dointvec_minmax_conv_param param;
> +
> +	do_int_conv_param_init(table, &param);
>  	return do_proc_dointvec(table, write, buffer, lenp, ppos,
>  				do_proc_dointvec_minmax_conv, &param);
>  }
> @@ -889,6 +902,20 @@ struct do_proc_douintvec_minmax_conv_param {
>  	unsigned int *max;
>  };
> =20
> +static void do_uint_conv_param_init(const struct ctl_table *table,
> +		struct do_proc_douintvec_minmax_conv_param *param)
> +{
> +	if (table->extra_flags =3D=3D SYSCTL_TABLE_EXTRA_PTR) {
> +		param->min =3D table->extra1;
> +		param->max =3D table->extra2;
> +	} else {
> +		param->min =3D (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN)=
 ?
> +			(unsigned int *)&table->min : NULL;
> +		param->max =3D (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX)=
 ?
> +			(unsigned int *)&table->max : NULL;
> +	}
> +}
> +
>  static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>  					 unsigned int *valp,
>  					 int write, void *data)
> @@ -936,10 +963,9 @@ static int do_proc_douintvec_minmax_conv(unsigned lo=
ng *lvalp,
>  int proc_douintvec_minmax(struct ctl_table *table, int write,
>  			  void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct do_proc_douintvec_minmax_conv_param param =3D {
> -		.min =3D (unsigned int *) table->extra1,
> -		.max =3D (unsigned int *) table->extra2,
> -	};
> +	struct do_proc_douintvec_minmax_conv_param param;
> +
> +	do_uint_conv_param_init(table, &param);
>  	return do_proc_douintvec(table, write, buffer, lenp, ppos,
>  				 do_proc_douintvec_minmax_conv, &param);
>  }
> @@ -1038,8 +1064,16 @@ static int __do_proc_doulongvec_minmax(void *data,=
 struct ctl_table *table,
>  	}
> =20
>  	i =3D data;
> -	min =3D table->extra1;
> -	max =3D table->extra2;
> +	if (table->extra_flags =3D=3D SYSCTL_TABLE_EXTRA_PTR) {
> +		min =3D table->extra1;
> +		max =3D table->extra2;
> +	} else {
> +		min =3D (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
> +			&table->min : NULL;
> +		max =3D (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
> +			&table->max : NULL;
> +	}
> +
>  	vleft =3D table->maxlen / sizeof(unsigned long);
>  	left =3D *lenp;
> =20
> @@ -1274,10 +1308,9 @@ int proc_dointvec_jiffies(struct ctl_table *table,=
 int write,
>  int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
>  			  void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct do_proc_dointvec_minmax_conv_param param =3D {
> -		.min =3D (int *) table->extra1,
> -		.max =3D (int *) table->extra2,
> -	};
> +	struct do_proc_dointvec_minmax_conv_param param;
> +
> +	do_int_conv_param_init(table, &param);
>  	return do_proc_dointvec(table, write, buffer, lenp, ppos,
>  			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
>  }
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--awwnjpzdp4nogjz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5wmgACgkQupfNUreW
QU8ndgv/bkdmOja/hof1ULkEBwf6L+9zlPykni2lXJGXqv1I7FIFEMg/nFQcIJJr
yW5kjWUcIV/uv867RfcJnVpYMtmmEQQwL84/zk0KLzV+IpYPSqCcwgIsji8RI4GH
qPvaeeKnfbNYfPcXbnNNTZipe/MKx9M3r870ihXa4bf0kj6QItl9Koz2IiqxT+UN
BtYW3aXldn3S5taIbrVo5FnISq2BNkYu0XlgHogAl6ixI8oin/vIZ170FosrVMM9
1C6qAM2IbVVz7JWXGg79/DhBOcdkLfkRJCTzVYz2JdcmMjTNSdssTUOc6a41ZfGK
1hXXulqGd/e3+A5WSnkyYeBOATzlyLTZQdSr6rC3LnYVSzTeMbF0do3vn290R0Dp
RGChv9Fbvt8Jxt3uUAW2Ddd2b9VB4/NntgRzvDSFdST7w+61SWR8w5C6wEVFumTj
OXa+ZBBv/GCPY0mCtlvx4uxJZsxGCB8BWZS8nqDxxDyeXlgJDQll6qI9O3LYlsdG
QvslUi/M
=J3F2
-----END PGP SIGNATURE-----

--awwnjpzdp4nogjz5--

