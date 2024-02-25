Return-Path: <linux-kernel+bounces-80270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32481862CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB746283268
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52E1B807;
	Sun, 25 Feb 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gZovTVVO"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25718AF9;
	Sun, 25 Feb 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892165; cv=none; b=uXRkejba7dBg+CaUrEvba8QorG0perE2/BrXbU3FCoZbpQX7yWxFOzY9FnP3BwJT99/6G1+EccUgGjDf49+th00N0+7ESePealdTgiNay09EkEzzhB9AfWFTtsWgIeHd3iRTAT+yQi3e5tyKVKEuz1CuwYqF/rPA9+jd7kqHb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892165; c=relaxed/simple;
	bh=zVHT6qg7Q5TERe+A/8/jIeRbV59ssNLoCY8pt8bWEVI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=df6AajhS9oF2ta73h95LLMYy6aI99lhRvXgx9OMuBDAw+AQYEOKmqTcsn5UwnAIEsS7YbgvXcsx7dWmAqD5rALEA6/Td+7lCTdMjwHYJ8erFwlsEkAOA3F5rUda+mvnmSeU6mrKXg2RC14I+hj3f18hB+RZ6SkFB3SjH51kpot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gZovTVVO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240225201553euoutp02e243c6ee786f22b8213f6302430dbb50~3NFwb1Oq52782727827euoutp02B;
	Sun, 25 Feb 2024 20:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240225201553euoutp02e243c6ee786f22b8213f6302430dbb50~3NFwb1Oq52782727827euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708892153;
	bh=GLTvN8ul0ZOWzIqY8mZZquo/0GoP3vFoHZSTu5lZqTU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gZovTVVOvly0G+CLojHrpQjNrxQgBrPx7d3hACs1ZjH4u4/5csriP7NRahynkx6Jm
	 sC/VfQAd2ZaM7uYtr5bUTmRkOE/QZ9dzy1YQdLZqZEehH80fD7tItlaRz7wSX8d/V2
	 E52fA0Wsa/lMaQul8yN0W4f8ZGxU/gvThEBWXTYE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240225201553eucas1p19dd099965a3127f38a082dbdee487e6e~3NFwGj55e1107411074eucas1p1o;
	Sun, 25 Feb 2024 20:15:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F3.EE.09552.9FF9BD56; Sun, 25
	Feb 2024 20:15:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240225201552eucas1p26fcbeafc5bc4a2557d1f6b1dffdeba65~3NFvnv7L61070010700eucas1p23;
	Sun, 25 Feb 2024 20:15:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240225201552eusmtrp229d55440e4e003aa7dec8552c5982f2a~3NFvnEJTi1215212152eusmtrp2O;
	Sun, 25 Feb 2024 20:15:52 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-72-65db9ff932b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.11.10702.8FF9BD56; Sun, 25
	Feb 2024 20:15:52 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240225201552eusmtip25e1ab13463aac078a8421f5300b5b1f3~3NFvYzTsz0324703247eusmtip2N;
	Sun, 25 Feb 2024 20:15:52 +0000 (GMT)
Received: from localhost (106.210.248.222) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 25 Feb 2024 20:15:51 +0000
Date: Sun, 25 Feb 2024 21:15:49 +0100
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>, <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] introduce sysctl SYSCTL_U8_MAX and
 SYSCTL_LONG_S32_MAX
Message-ID: <20240225201549.dwynbcvr2jmpfist@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="fyvuwnu2tzwfq6rq"
Content-Disposition: inline
In-Reply-To: <tencent_275FF7F351D515B570D0F82447BA30F3AA06@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djPc7o/599ONejdJWrx+vAnRos551tY
	LNbtamWyeHrsEbvFme5ciwvb+lgtLu+aw2ZxY8JTRotjC8Qsvp1+w2jRsnoXqwO3x+yGiywe
	W1beZPJY0HOe2WPBplKPTas62Tze77vK5vF5k1wAexSXTUpqTmZZapG+XQJXRufBe+wFc6Ur
	fk3IaGBcI9bFyMkhIWAi8X36AqYuRi4OIYEVjBIrL/2Bcr4wSqx63MMCUiUk8JlR4twxdZiO
	qV9uQBUtZ5TYM2EOK4QDVPTr92U2CGcro8S2czPA2lkEVCUW77jECGKzCehInH9zhxnEFhGQ
	lzj3ZBU7SAOzwFUmiUk3prCBJIQFAiUWT30FVsQr4CCxdeYpJghbUOLkzCdgQ5kFKiRuPj4M
	NJQDyJaWWP6PAyTMKeAkcWHdFGaIU5Ul1m87B2XXSpzacgvsbAmB/ZwS3Y1n2SESLhLzp11h
	hbCFJV4d3wIVl5H4v3M+VMNkRon9/z6wQzirGSWWNX5lgqiylmi58gSqw1Fi0pLrLCAXSQjw
	Sdx4KwhxKJ/EpG3TmSHCvBIdbUIQ1WoSq++9YZnAqDwLyWuzkLw2C+E1iLCOxILdn9gwhLUl
	li18zQxh20qsW/eeZQEj+ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAFHj63/GvOxhX
	vPqod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ8IbL3EwV4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYJrcL5m+8rhvol/K2QaWW2tNuzyKziWuM5Tft3/q
	XW6p+KlhRdcnXbgREnPP88VlkR+CRhUxT6YlXFDk93glnHZBU2F79NK1VR9adxbKL1xUlPi3
	THWvsVrvw7Szd9UPb37ZNGvDl+3dq3K470hru+pP6uCZ+TlYq3Y3412euzL/e/ISTl1LN5//
	8v7zA/GfN7b8jPO7UL19Deukrxc2anWb3jyru+ararDjTa4bs86K5p88Med60215M+b5yWIi
	x1x+OUYe2q7GpnW7yaV53xfvwylb2nd8eBJeb10e+f7ln11WCtNaG0I7WbmY1VLqPSJO3Nv7
	0Waah5vJphX7dtzqecCnY3d3M6PVq/JzcROVWIozEg21mIuKEwE6o2SO/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42I5/e/4Pd0f82+nGnx9Ymjx+vAnRos551tY
	LNbtamWyeHrsEbvFme5ciwvb+lgtLu+aw2ZxY8JTRotjC8Qsvp1+w2jRsnoXqwO3x+yGiywe
	W1beZPJY0HOe2WPBplKPTas62Tze77vK5vF5k1wAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWF
	npGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexs2vd9kKZktXNLZPYWlgXCXWxcjJISFgIjH1
	yw0mEFtIYCmjxOvpJRBxGYmNX66yQtjCEn+udbF1MXIB1XxklFj5YgIzhLOVUeLMhrMsIFUs
	AqoSi3dcYgSx2QR0JM6/ucMMYosIyEuce7KKHaSBWeAqk8TxV9PBioQFAiUWT30FVsQr4CCx
	deYpJoipUxkl9uw+zwaREJQ4OfMJ2AZmgTKJ1uOvgOIcQLa0xPJ/HCBhTgEniQvrpjBDnKos
	sX7bOSi7VuLz32eMExiFZyGZNAvJpFkIkyDCWhI3/r1kwhDWlli28DUzhG0rsW7de5YFjOyr
	GEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAhPBtmM/t+xgXPnqo94hRiYOxkOMKkCdjzasvsAo
	xZKXn5eqJMIbLnMzVYg3JbGyKrUoP76oNCe1+BCjKTAYJzJLiSbnA1NUXkm8oZmBqaGJmaWB
	qaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk5iT64uqv88yxOKUww2vPAy72rLeZcu9
	2NXr1HqVq9cyzl96PmfH5gvt+1X1I6ZGi6zLfbC7Zd+N+OfPqlk+Zf9IbOPhvHA2Xf/oLntR
	h1N3M3889+vuZT6RLnSUq+CX87oEMw/9nxecVRfud6sQ8+fx+/aASVlezM1OkDtwbUwS15OL
	N+Zt7K1rm2QvxPNG33W+lEOh1IG1dcqmuS6XvbtiWzv9Xl4JczAvyv3PefLmkX2TgvSueRyT
	OcjfxM6e1izjoOEj6H3qf+93J/5XUU7novYINqQXLj799VArj5EHz/Ydj/ZGpU2stCn5M2Ft
	hM/sK6LPTznukzrMsHvLkndveXM3B12zWSn0JI9biaU4I9FQi7moOBEAniZeWJkDAAA=
X-CMS-MailID: 20240225201552eucas1p26fcbeafc5bc4a2557d1f6b1dffdeba65
X-Msg-Generator: CA
X-RootMTR: 20240225040621eucas1p281f4ae53ecc8c0e1979fdc0c6b09643f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240225040621eucas1p281f4ae53ecc8c0e1979fdc0c6b09643f
References: <CGME20240225040621eucas1p281f4ae53ecc8c0e1979fdc0c6b09643f@eucas1p2.samsung.com>
	<tencent_275FF7F351D515B570D0F82447BA30F3AA06@qq.com>

--fyvuwnu2tzwfq6rq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 12:05:30PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20
> The boundary check of multiple modules uses these static variables (such =
as
> two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
> Therefore, add them to the shared sysctl_vals and sysctl_long_vals to avo=
id
> duplication.

Having a hard time understanding what you are trying to do here: is it
that there are variables that are being defined statically in two (or
more) different files and you want to consolidate them into sysctl
variables?

> This also reduce the size a bit=20
What size are you referring to? by how much?

The cover letter came separately and the patches are replying to a
non-existent mail. Is this due to some funkiness that Tencent does tot
he outgoing mail?

>=20
> Wen Yang (8):
>   sysctl: introduce sysctl SYSCTL_U8_MAX and SYSCTL_LONG_S32_MAX
>   rxrpc: delete these duplicate static variables n_65535 and four
>   net: ipv6: delete these duplicate static variables two_five_five and
>     minus_one
>   svcrdma: delete the duplicate static variables zero
>   sysctl: delete these duplicate static variables i_zero and
>     i_one_hundred
>   epoll: delete these duplicate static variables long_zero and long_max
>   fs: inotify: delete these duplicate static variables it_zero and
>     it_int_max
>   ucounts: delete these duplicate static variables ue_zero and
>     ue_int_max
>=20
>  fs/eventpoll.c                   |  7 ++-----
>  fs/notify/inotify/inotify_user.c | 11 ++++-------
>  include/linux/sysctl.h           | 15 +++++++++------
>  kernel/sysctl.c                  |  4 ++--
>  kernel/ucount.c                  |  7 ++-----
>  lib/test_sysctl.c                |  6 ++----
>  net/ipv6/addrconf.c              | 12 +++++-------
>  net/rxrpc/sysctl.c               | 16 +++++++---------
>  net/sunrpc/xprtrdma/svc_rdma.c   | 21 ++++++++++-----------
>  9 files changed, 43 insertions(+), 56 deletions(-)
>=20
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
>=20
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--fyvuwnu2tzwfq6rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXbn/UACgkQupfNUreW
QU9kLAv9FqslWcRQ6KC6WwNTikWhzrzgrjZpzN1hdf0MLPWsdFPeRtbtjsm3F6Fj
V3ydFdpu4uBaQah6Y6Uis/W3UfS15jC44kUKn0k7omRX1UetnRdN10MGCgOj+8Zo
O4u9QXiZBMzQYuSB/Dci//W8oIlkaoS90HIManxSNZqMIiKU8ir4TXE27QtuRre+
dx8gxdMIgcMYDUQ1Gp7NwmOOfQ2CUgbr5Ubw4jJch2PrdkRESJgPXIHuIZp98clJ
l0c5Zz5bTQZqod9niihBNI2zpx7VxKnrVsAvkFL/Z0FbPx9KTWhR1dICmVuQUocF
Vloa/YqXz6FqYC5hybHukVbig+ovddDIUmzpJfmcq7YzMTz1E6+6AUgrflGfF+/7
yzjBf09p++O4I8V7b2wqkkSE6pOlmonZ826oOvJ698wShVOTO8AwB2I0EVwmsHmX
b8WlG2u420aoW4skd/IS/cCmvR2rtZVdbitERshRR/t/b4lqcqxaqa8oSztj8L2B
c09Q6QXz
=P4/J
-----END PGP SIGNATURE-----

--fyvuwnu2tzwfq6rq--

