Return-Path: <linux-kernel+bounces-80274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89298862CCD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BEA1F224EC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125061B810;
	Sun, 25 Feb 2024 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ve1h7206"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F71BDCE;
	Sun, 25 Feb 2024 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892232; cv=none; b=drtVgvASGsPHGoxRdgdVC3i66YSQYf2WqHgVUpCjquSfy6y0KaiAKW8+OexBT+mKwMC5Ndcc1jSLSOmUAX7NQN79GIDBpZGOHVuaefBcp94mGexWF0siiOIJX/MIRhRrQPobXz95DJFOlBuSrKeqIkRUzcuP0NSzIPwj3uQPTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892232; c=relaxed/simple;
	bh=8mBiiw1K6hy4KkWF0bACSrn0c7z/Q+4n0AoXESCVheY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=vFwgKlZLq1SBxVbQchfUN1qkJlc693n95KHZ3Ucp/roFH4Kd1iDu8gZDizYLyYij6ukmns1BNQqQFTh6D0C1XR61R9kQ3bLiIV9GptYzEu/ZYHWQG/RkkiLzxE61OY2qewBrBva/CBrpMf6ZmFC2YTHqAHr6+plwlRnCbZkUIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ve1h7206; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240225201701euoutp016779edea2249c28248dbba8c4251c000~3NGveewUT3072430724euoutp01d;
	Sun, 25 Feb 2024 20:17:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240225201701euoutp016779edea2249c28248dbba8c4251c000~3NGveewUT3072430724euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708892221;
	bh=dhW+yOBdo3voypPsFOkyfZsFdQSuzWwwvrfGVCZWSrc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ve1h7206ul8aONip2vy8Phb+MlbhOJ6vVF0OIvcjntM+tpM9mqWlP+K8KfwCI3ID1
	 HOTXwV6WZmPDQZGECqRc4oQZKe2ZVDDHOJL2RysYp80pdVm1yf6sTFQIBQ6kcSDvMH
	 d57FtfZ+WeqCMaI3ZOx0KjBKjmGVElMLRIZOz1fM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240225201701eucas1p1d89fc1e57d360ca7c9b5e2c90cc56bf8~3NGvL1Hjs1109111091eucas1p1C;
	Sun, 25 Feb 2024 20:17:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8B.65.09814.D30ABD56; Sun, 25
	Feb 2024 20:17:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240225201700eucas1p1fcf1392cd0d4230c17d1ff296c5995e2~3NGut75Ky2582925829eucas1p1t;
	Sun, 25 Feb 2024 20:17:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240225201700eusmtrp1596f260bbede93134299c568c0b311d0~3NGutXJui0768107681eusmtrp1E;
	Sun, 25 Feb 2024 20:17:00 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-60-65dba03da3d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.F7.09146.C30ABD56; Sun, 25
	Feb 2024 20:17:00 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240225201700eusmtip186ccfa89ac58e360b12b80e5490a2b54~3NGui2XHm1504315043eusmtip1U;
	Sun, 25 Feb 2024 20:17:00 +0000 (GMT)
Received: from localhost (106.210.248.222) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 25 Feb 2024 20:16:59 +0000
Date: Sun, 25 Feb 2024 21:16:58 +0100
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>, <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] sysctl: introduce sysctl SYSCTL_U8_MAX and
 SYSCTL_LONG_S32_MAX
Message-ID: <20240225201658.h6nod4c4uxclq53a@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="xhnys3c7pu7tlmrh"
Content-Disposition: inline
In-Reply-To: <tencent_95D22FF919A42A99DA3C886B322CBD983905@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djPc7q2C26nGpxewWrx+vAnRos551tY
	LNbtamWyeHrsEbvFme5ciwvb+lgtLu+aw2ZxY8JTRotjC8Qsvp1+w2jRsnoXqwO3x+yGiywe
	W1beZPJY0HOe2WPBplKPTas62Tze77vK5vF5k1wAexSXTUpqTmZZapG+XQJXxpPjXgV7lSu2
	Nj1nbGBcJ9fFyMkhIWAiMbtnC3MXIxeHkMAKRokrT5vYIZwvjBK3P66DynxmlPj26h4TTMuO
	7euhEssZJbbveMoGVzVx+Qeo/q2MEqtmrGMEaWERUJX4+3QaG4jNJqAjcf7NHWYQW0RAXuLc
	k1VgDcwCV5kkJt2YAlYkLBApcevdbjCbV8BBouHGa1YIW1Di5MwnLCA2s0CFxNF7b4BsDiBb
	WmL5Pw6QMKeAk0TTk3XMEKcqS6zfdg7KrpU4teUWE8guCYH9nBKbNtxjhUi4SEzt3sQOYQtL
	vDq+BcqWkTg9uYcFomEyo8T+fxCvSQisZpRY1vgVGhrWEi1XnkB1OErM7j/EDnKRhACfxI23
	ghCH8klM2jadGSLMK9HRJgRRrSaxGuj+CYzKs5C8NgvJa7MQXoMI60gs2P2JDUNYW2LZwtfM
	ELatxLp171kWMLKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEyCp/8d/7KDcfmrj3qH
	GJk4GA8xqgA1P9qw+gKjFEtefl6qkghvuMzNVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qiny
	qUIC6YklqdmpqQWpRTBZJg5OqQYmLrOKZ7obK8X28acpm+o9unb27puFDo49rZNaP24OW3N+
	DufB32ze5tLcrhZzNwY4TVq/adPcAstZyjbuxansltrmF1+t99FWOPLbMCX3Ya7rpW+XAzRV
	pP/MN3Ba8/D49UmGv/9+erI0xVFermTF5UqTXcbn9SJr5nP9Wj9XLKyQ3zxPImuyzeMLmZ/+
	5ux78nXJZw0vSaaWTa/qmRsUDH5u251zWNz4r9HC2d7zI4N47TvKvm67LJU7ZeHavx+ZnvCv
	i0tcFz1B4l6le0jrqZVcKbf3P+w426In/rzn+sHHKlW35fm1Sj/bn7397fGzoD+ha9z2dXQc
	818rcDP77aM/kW9sk1jZfi40XJsRosRSnJFoqMVcVJwIAHXTy+79AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4XV2bBbdTDV7dVbV4ffgTo8Wc8y0s
	Fut2tTJZPD32iN3iTHeuxYVtfawWl3fNYbO4MeEpo8WxBWIW306/YbRoWb2L1YHbY3bDRRaP
	LStvMnks6DnP7LFgU6nHplWdbB7v911l8/i8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJC
	z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49Hfo6wFu5UrPm5uYm1gXCPXxcjJISFgIrFj
	+3rmLkYuDiGBpYwSJ6YtYIZIyEhs/HKVFcIWlvhzrYsNxBYS+MgosbNdBqJhK6PE6aYzTCAJ
	FgFVib9Pp4EVsQnoSJx/cwdskIiAvMS5J6vYQRqYBa4ySRx/NZ0RJCEsEClx691usAZeAQeJ
	hhuvWSGmngY64/JjqISgxMmZT1i6GDmAusskpq7ThDClJZb/4wCp4BRwkmh6sg7qaGWJ9dvO
	Qdm1Ep//PmOcwCg8C8mgWQiDZiEMAqlgFtCSuPHvJROGsLbEsoWvmSFsW4l1696zLGBkX8Uo
	klpanJueW2yoV5yYW1yal66XnJ+7iRGYBLYd+7l5B+O8Vx/1DjEycTAeYlQB6ny0YfUFRimW
	vPy8VCUR3nCZm6lCvCmJlVWpRfnxRaU5qcWHGE2BgTiRWUo0OR+YnvJK4g3NDEwNTcwsDUwt
	zYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjsYtPz6jZy32ldHGe4Q2p18UpF97kWYedX
	t2+eosWTUrj8BqNr9asP0Veeip6dOEFApnTez8s9ed+jdxjZvRXk+xbX9PvQs44/8XMPKc7b
	szDkTG38q0nOuqdWZbR5ih3kqzBx3SoqqR4zT/XbDDUThgKtXZ7mqy4aXi6vXDSjeLPFXMlD
	ZqJnmdbVT7NuX6couKpVVbD6R7Fe5vp/RjYvLu1JNT0W1Sa4OHshN//eywfakxied23/rTL3
	5XS2rq0yjtWsTpuynhUFFVTuiN6k6abwqClR54jp653rPF9oeP/TWqUsmxbx7HT0lKdHFA2v
	Xn65fXrRgmcds94xvcvcrsvls9twx87bJ+0kjZuVWIozEg21mIuKEwGPcGKRlwMAAA==
X-CMS-MailID: 20240225201700eucas1p1fcf1392cd0d4230c17d1ff296c5995e2
X-Msg-Generator: CA
X-RootMTR: 20240225040629eucas1p12649e57aa00bbabc99c525b98eb74670
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240225040629eucas1p12649e57aa00bbabc99c525b98eb74670
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
	<CGME20240225040629eucas1p12649e57aa00bbabc99c525b98eb74670@eucas1p1.samsung.com>
	<tencent_95D22FF919A42A99DA3C886B322CBD983905@qq.com>

--xhnys3c7pu7tlmrh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 12:05:31PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20
> The boundary check of multiple modules uses these static variables (such =
as
> two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
> Therefore, add them to the shared sysctl_vals and sysctl_long_vals to avo=
id
> duplication.
>=20
> Also rearranged sysctl_vals and sysctl_long_vals in numerical order.
>=20
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/sysctl.h | 15 +++++++++------
>  kernel/sysctl.c        |  4 ++--
>  2 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index ee7d33b89e9e..b7a13e4c411c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -45,19 +45,22 @@ struct ctl_dir;
>  #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
>  #define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
>  #define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
> -#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
> -#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
> -#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
> +#define SYSCTL_U8_MAX			((void *)&sysctl_vals[7])
> +#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
> +#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
> +#define SYSCTL_U16_MAX			((void *)&sysctl_vals[10])
> +#define SYSCTL_INT_MAX			((void *)&sysctl_vals[11])
> +#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
> =20
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and=
 GID */
> -#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
> -#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
> +#define SYSCTL_MAXOLDUID		SYSCTL_U16_MAX
> =20
>  extern const int sysctl_vals[];
> =20
>  #define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
>  #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
> -#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
> +#define SYSCTL_LONG_S32_MAX	((void *)&sysctl_long_vals[2])
> +#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[3])
> =20
>  extern const unsigned long sysctl_long_vals[];
> =20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 157f7ce2942d..e1e00937cb29 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -82,10 +82,10 @@
>  #endif
> =20
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] =3D { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_M=
AX, 65535, -1 };
> +const int sysctl_vals[] =3D { 0, 1, 2, 3, 4, 100, 200, U8_MAX, 1000, 300=
0, 65535, INT_MAX, -1, };
Why do you insert the new values instead of just appending?
I figure that the patch would be much smaller if you appended.

>  EXPORT_SYMBOL(sysctl_vals);
> =20
> -const unsigned long sysctl_long_vals[] =3D { 0, 1, LONG_MAX };
> +const unsigned long sysctl_long_vals[] =3D { 0, 1, S32_MAX, LONG_MAX, };
Same here. Why insert instead of append?
>  EXPORT_SYMBOL_GPL(sysctl_long_vals);
> =20
>  #if defined(CONFIG_SYSCTL)
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--xhnys3c7pu7tlmrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXboDoACgkQupfNUreW
QU/BSgv/XumlvLIqQzPZ2K8w08RnGaSRuoZb7SFKrMlCLvNKIEHUiqKoONhvu1S/
lM+a2IGc9elUAMVlLdBslxR4FxHTOveKJgpTmrvuU3iPTHgU2l3ZTXtKzOWn2THT
mFY8UpSgUBaU/kYb/aq+BgBcHmJcBmvlFjmghPHdcz7hxpfh/Qp0B+qPpl6g/PSp
wl/QC/sJFjUggUTdUuEIJau5eL6xGmARCf5w8vVZUVxQvKQYO3F/epQXLNQNH7mD
GP8IJbml9MZYM+kJ0NqWAMsOyjVqUqDDmTQhVXkqUVDkvUWHMOSndkcNk7hkNkG+
klvjyMu3eyFdiPmwAOVH2/76xBU4TyoDsXrF6sWU5lkWFxLyEIeWvbpyTFsAZSGl
9c+aSWaRK8agw3KBkJQBmxKpImO9yV0jDKVASo9fGGxoXvz0yL2USzonTJG7HF3w
UNZKbYz+2brykoIga1OkjhSgo7Q41/ixzvOoFL83eiSGs2jDoTXeM6BUI+rpKe+w
Ba4pv/mZ
=Pa77
-----END PGP SIGNATURE-----

--xhnys3c7pu7tlmrh--

