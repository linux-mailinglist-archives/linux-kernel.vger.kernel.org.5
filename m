Return-Path: <linux-kernel+bounces-110337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA7885D67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43F91C21918
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338E12CD8D;
	Thu, 21 Mar 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yq8vpY+t"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5223778
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038487; cv=none; b=FKWMfEw2KRG+SD74H/1f/N5WdBvYHm1VbcxRm8n5NVOkCmFLfWwEBQ6Tv4W0S+Rsvh2ONEIVJ+dHP3RIEXsZ0ej7LK8MaSXsh8Il73CUyI1mGs1eCNiZ1DruPcrpwNCwXPrmo4AIZpgqgiX7AYw4A6M0K3+kYybdc1XM2cFOFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038487; c=relaxed/simple;
	bh=3O+ThSixqFiFFV7oMaTqHQ64XBw7tqoXet36ynwh20c=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=eKcfEBZNfWaCQHe2YTxBUYHs0a7ftSSA2XsxzcIoQez71vG8Yd5FJn5eGJvMgbw/ZTvYObMGNkZHJJ035O6NpF1IthRsulw6D471BehIMWjuD3u2vCeg9Ms4ENUxdWFyZBEXgKX1lBWExHc3aQLyyw7ovRtgy7HdQ0Qecbd8xAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Yq8vpY+t; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240321162802euoutp0271a411bbc063c6567678e1908c7cd468~_1G8y5TG-1501915019euoutp02O;
	Thu, 21 Mar 2024 16:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240321162802euoutp0271a411bbc063c6567678e1908c7cd468~_1G8y5TG-1501915019euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711038482;
	bh=DA06jphwwAHfUlhMATkGzqb4Fnd8rcp5fBg8U4crZuY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Yq8vpY+tQNxy+OqUfkyeOwSwePDVZV4GS69RYukkDbyQISIzG20XpBk5Idz+peRq8
	 xbkYV70i7nf/TJcssL/SX+tTA8WbTWvzyxv9EqU2AFgn9wIrE1KxsATxYKjHWaO9BV
	 rproL/5q2Xai1Y0ENIgjy10WlVQRRJg/4wA+KGuI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240321162802eucas1p18562baf6b0a0d92858642ff0db375ab7~_1G8oHCbE0092100921eucas1p1I;
	Thu, 21 Mar 2024 16:28:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.40.09552.2106CF56; Thu, 21
	Mar 2024 16:28:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240321162801eucas1p274d32d72b08523becf86d9e5b7f08b83~_1G8I2S9z0199501995eucas1p2F;
	Thu, 21 Mar 2024 16:28:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240321162801eusmtrp1c5699a337380e128593df2cbc86b1969~_1G8IBh_B2381123811eusmtrp13;
	Thu, 21 Mar 2024 16:28:01 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-8d-65fc60129377
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.A4.10702.1106CF56; Thu, 21
	Mar 2024 16:28:01 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240321162801eusmtip2d081bcbe9ba73c0f9b02e706acd19243~_1G7znQUg0461604616eusmtip2V;
	Thu, 21 Mar 2024 16:28:01 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Mar 2024 16:28:00 +0000
Date: Thu, 21 Mar 2024 17:27:58 +0100
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, Iurii Zaikin <yzaikin@google.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] sysctl: support encoding values directly in the
 table entry
Message-ID: <20240321162758.tkituzvff5rwnvd2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="izn2qnfca3crqd72"
Content-Disposition: inline
In-Reply-To: <tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7pCCX9SDfoW8Fq8PvyJ0eL/thZ2
	izPduRaXd81hs7gx4SmjRcvqXawWy3b6ObB7zG64yOKxoOc8s8eCTaUem1Z1snl83iTnMeVQ
	O0sAWxSXTUpqTmZZapG+XQJXxtX3VxkLvlhWnD0yma2Bcbl+FyMnh4SAicSavUsYuxi5OIQE
	VjBKrLx8jQXC+cIose7sNCjnM6PE/f6brDAt/ya+ArOFBJYzSvT2scEV/do+mxEisZVR4v08
	JRCbRUBV4s2yr2ANbAI6Euff3GEGsUUE5CXOPVnFDtLMLPCKUeL5y8tMIAlhgUiJr0uugdm8
	Ag4SbydeYoawBSVOznzCAmIzC1RIHJn/DSjOAWRLSyz/xwES5hRwkvjXvIwN4lBliev7FkPZ
	tRKnttxiAtklITCbU+Ll9VtQ37hIfJp3nwXCFpZ4dXwLO4QtI3F6cg8LRMNkRon9/z6wQzir
	GSWWNX5lgqiylmi58gSqw1Hi+JqzTCAXSQjwSdx4KwhxKJ/EpG3TmSHCvBIdbUIQ1WoSq++9
	YZnAqDwLyWuzkLw2C+E1iLCOxILdn9gwhLUlli18zQxh20qsW/eeZQEj+ypG8dTS4tz01GLj
	vNRyveLE3OLSvHS95PzcTYzAhHb63/GvOxhXvPqod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ
	8LJz/0wV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYAqy
	P3iVfdG2Fqnv3f/nHHTK//swjIvt41sp1VdF545MfrR56Qthk2fmftlGFdbdSw7PePPRp0W7
	oztsvWrJ4X1Pao3zjaUv9jn/5O5uvmb+tWWaLmPZ2trnG1ZLFZreU/ntu+U9x4errtHf5Wt/
	lG5X26VVpZKtlT/ra4f5LwkOg5fy9hpZ20z+37tauN9gQUeFTvy2mOuubf/LtkkLi93tXpNQ
	KeNhuM5dff/3TbpvJUJ3855ltTrWNJM93+DGQ1epnoXPItmuv1d1nrx4fkv/+tKu4FwH660P
	bjF90pmYWpgu6q244typNpYr/19e8J7YpN1ofEkpc/v9qR8exbJ9O31AyihD+Ij2G8EfDEos
	xRmJhlrMRcWJAHCaL8/jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7qCCX9SDe4+VbN4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi5bVu1gtlu30c2D3mN1wkcVjQc95Zo8Fm0o9Nq3qZPP4vEnOY8qh
	dpYAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9
	jB+fvzMXfLKs+Pl2NmMD41L9LkZODgkBE4l/E1+xgthCAksZJRZty4CIy0hs/HKVFcIWlvhz
	rYuti5ELqOYjo8SbRRPYIZytjBJfGtvYQKpYBFQl3iz7CtbBJqAjcf7NHWYQW0RAXuLck1Vg
	DcwCrxglnr+8zASSEBaIlPi65BqYzSvgIPF24iVmiKknGCUm/l0GlRCUODnzCUsXIwdQd5nE
	/6MiEKa0xPJ/HCAVnAJOEv+al7FBXKoscX3fYii7VuLz32eMExiFZyEZNAth0CyEQSAVzAJa
	Ejf+vWTCENaWWLbwNTOEbSuxbt17lgWM7KsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3rb
	sZ9bdjCufPVR7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4WXn/pkqxJuSWFmVWpQfX1Sak1p8
	iNEUGIgTmaVEk/OBySavJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNT
	qoFJZ+aEjf52Ry7t9Jju1FFSbhXPedtsVt/T8yaCjFPaG4IXbOrsisp6L7R64/lz3t1BgkUq
	8Wkbpy349yK4vNemR/54yAcdUdGdCsHKyUZcyUsa45TDta/FlwQGXGAV+bDZvr3lgO6ks58+
	aU0InnVSps/PW52ZffacvBOy3poBZk0WVSvnlUVpn5r4bfeRm05f/+nbSp8SeMC/Yul2f5kH
	fv2BMl1vt27M/bz7iQ/rv3vH7rmZP1EuCqt/VaTqqyq3ZsGfctNlZ4PPX5t+jHtzhfrn90wG
	R54GzJA6k6Jhusta/gfvj80qz9jfH3+/x8VC899My13ZN2Zpbdr36eX5kx1XmTa1ifllxGVv
	339EiaU4I9FQi7moOBEAUhsA934DAAA=
X-CMS-MailID: 20240321162801eucas1p274d32d72b08523becf86d9e5b7f08b83
X-Msg-Generator: CA
X-RootMTR: 20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
	<CGME20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a@eucas1p1.samsung.com>
	<tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com>

--izn2qnfca3crqd72
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2024 at 06:31:18PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20
> Eric points out: "by turning .extra1 and .extra2 into longs instead of
> keeping them as pointers and needing constants to be pointed at somewhere
> ... The only people I can see who find a significant benefit by
> consolidating all of the constants into one place are people who know how
> to stomp kernel memory."
I'm assuming that this is the "why" of the commit. Please change it so
it is more direct. Something like "Directly encode numeric values in
macros in order to ...". If you want to add Eric's opinion please add it
as a link (Please follow Documentation/process/submitting-patches.rst)


>=20
> This patch supports encoding values directly in table entries through the
> following work:
> - extra1/extra2 and min/max are placed in one union to ensure that the
>   previous code is not broken, then we have time to remove unnecessary
>   extra1/extra2 progressively;
> - since type only has two states, use one bit to represent it;
Please remove this optimization from your commit. This will conflict
with work that Thomas is doing here
https://lore.kernel.org/all/20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@wei=
ssschuh.net=20

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
As I said before. Please remove this from your patch.

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
This extra_flag is needed because now you have lost the extra bit of
information that the NULL pointer gave you. This is effectively adding 2
bits per ctl_table element for all ctl_table types; event the ones that
do not need min max. So how much will we actually save with all this?
once you have added these 2 bits and removed the static variables from
the files that are not using the pointers? Is saving read only memory
the only reason for this? If that is the case, please add some
calculations of how much we save to see if it actually make sense. To
calculate the memory gains/losses you can use the bloat-o-meter script
under the scripts directory (something similar to what we did here
https://lore.kernel.org/all/20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d=
9@samsung.com)

I'll hold off on reviewing the other patches in this set until this is a
bit more clear.

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
=2E..

Best
--=20

Joel Granados

--izn2qnfca3crqd72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX8YA0ACgkQupfNUreW
QU8Dtgv/R+vs8reT8chyCAo5fHLsuI4wL2HmyFz4ewopKinHpQknmxlxnqLUR30W
E0lwjP1szd85og0ujN6Dvxco2ppPkahdUK1fuqQa5AF1+aj09gd1riBB9ebZCUj9
Zlg4vxFObhLHoyrYnGo9pyCPGvvCTgyzR+dywtwUe6M13gKTtNJtrZPcsSHv/5Ul
bxcleWONu4quZlxXr3fU0YOh1ZgXAOyluCnIWoXdNW8OHhh/CXL/8Xq3JtyoZRBg
JDYMp9YWM6itZeUIHd0DgBvFo3/xrJ8Fi3+4Xj5L3yG6UwDX0vQ0cVXyRk/5iiml
RauiPoJJbJpSaQ4GmYFzsrVht4q4s+S6SWmB75T9U9YGU+qiH22Fc9WSsgCwI+4m
83UdyG87h+czaOHWWucwRPi2M5iZepZlH67/s6mwsRIlFsn3ExtYnXLPxp+InRfD
/T1ZrNdCN18GBQ2x4jMTW/Mr2aYnef2d4sxXpEH/N2UqlCvTQo/3nP0yc89vv71L
ojdYAadJ
=yr5U
-----END PGP SIGNATURE-----

--izn2qnfca3crqd72--

