Return-Path: <linux-kernel+bounces-110211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E092D885B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B23B22EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C218624F;
	Thu, 21 Mar 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V3AHlL5A"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E888624A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034512; cv=none; b=QFltuVz6udqtaTuHCM/ozbBin6WAup3kHcDA3tTwhfzO6GgcE6fC2zDYqTOHvBtzp2hpqBzgGNCqcuGYet61oPnIftTiESade2H8r2VtBek7M97Yo5JmJcA78OMcxKV++OF6Sa6Dk1Ek654A37TH55gPi4ifBbcx77njo2wIXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034512; c=relaxed/simple;
	bh=RgcRDxOyOZNHcZTBr/peoHDwOtK0HcDYlRR2XnOWvM8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=Z+RD1gyDUGxHDzdTYGx99zC2yFm0Ft9tx5+IE1v1EtLixsCE4CFUDYlZrrzOKgRgAQmY0I1nurwBYY/0TwSaijPJcre4XGo3hC7Re9BGTylp4T7DlVw2sA0446xwU8mNm+IMfWeOpsZnge/5blmgiPA36OfpZ2Bxg/TcRm8uuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V3AHlL5A; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240321152146euoutp01e05f0984c7b63dfd56a1722265a71e47~_0NGSYImY1123211232euoutp01e;
	Thu, 21 Mar 2024 15:21:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240321152146euoutp01e05f0984c7b63dfd56a1722265a71e47~_0NGSYImY1123211232euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711034507;
	bh=LjvqyTukDYOzB0G/O3zGlon0p/qycGVrAwYA8iediLY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=V3AHlL5AI2V1jdAZvCzXjB/Aj80APaX6fvSBj025b2FW5T9iIC5Pkdb+H+3wysy7A
	 Avzy5ZL32oApPNKbt1+XKulVFRhUtqBCT4OiQ8vBXwdnX0zI0y8irbBIskmA9cXXar
	 G1GQJe7EGy7jr3lZ+8ybil9oafKHTdW74tJXClb0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240321152146eucas1p13bc436761052994b0b5fb4bb1a12b8cf~_0NGIEQjT3062130621eucas1p1n;
	Thu, 21 Mar 2024 15:21:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id CA.13.09814.A805CF56; Thu, 21
	Mar 2024 15:21:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240321152146eucas1p1956acf109d76413088511707cec7f15e~_0NF1XAHa3065430654eucas1p1i;
	Thu, 21 Mar 2024 15:21:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240321152146eusmtrp28dc499570ff3d4b829e6a213732dc2d6~_0NF0annj0715907159eusmtrp2H;
	Thu, 21 Mar 2024 15:21:46 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-36-65fc508a2c32
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.2B.10702.A805CF56; Thu, 21
	Mar 2024 15:21:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240321152146eusmtip199360d00d372e19a5e2fc3fb3cea4895~_0NFppink2015520155eusmtip1m;
	Thu, 21 Mar 2024 15:21:46 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Mar 2024 15:21:45 +0000
Date: Thu, 21 Mar 2024 16:21:43 +0100
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] encode the values directly in the table entry
Message-ID: <20240321152143.yxoonjy3m6bdddkf@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="rhtofu2dfldrnkgy"
Content-Disposition: inline
In-Reply-To: <tencent_C5E6023F97E7CC2A046AAEA09BC9ACF43907@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7pdAX9SDWbP0bF4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi5bVu1gd2DxmN1xk8VjQc57ZY9OqTjaPz5vkPKYcamcJYI3isklJ
	zcksSy3St0vgyrj99xZLwUzFiocdOxgbGL9LdTFycEgImEjM+KjZxcjJISSwglHi7r7gLkYu
	IPsLo8SRhgYWCOczo0TPtmmMIFUgDRc/PmGESCxnlPhxZz8jRDtQ1dyVDhCJrUCJ7qesIAkW
	AVWJ/7+XgNlsAjoS59/cYQaxRQTkJc49WcUO0sAscJRRYvv8LjaQhLCAp8SjPa9ZQGxeAQeJ
	Wae62SBsQYmTM5+AxZkFKiQuLjzFDPIDs4C0xPJ/HCBhTgEniaPzPzFDXKoscX3fYjYIu1bi
	1JZbTCC7JAT6OSV+rNoM9Y6LxIaWh1BFwhKvjm9hh7BlJP7vnA/VMJlRYv+/D+wQzmpGiWWN
	X5kgqqwlWq48gepwlJj/axcLJFT5JG68FYQ4lE9i0rbpzBBhXomONiGIajWJ1ffesExgVJ6F
	5LVZSF6bhfAaRFhHYsHuT2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjeGppcW56arFRXmq5XnFi
	bnFpXrpecn7uJkZg+jr97/iXHYzLX33UO8TIxMF4iFEFqPnRhtUXGKVY8vLzUpVEeNm5f6YK
	8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhPLEnNTk0tSC2CyTJxcEo1MLkZKV9YInXj
	xuO0u7P/nlkzqy6asX7+hdbmsLznR6RUWxJ7lf7eLC4pmqX+00xipuDv/DzR/V9eSBQlbpWw
	Ofp2bpeTjYGgs0Cd5cXPSp56DTN3lf9O0Qty2N4xSz/Nd+K85wYbi+/5/jv26M/cPzd5X3se
	NFg3y8L33OY3qw4/WhUYLWVRzZc75ZXfwRcbqrj6vnE8l9zN9EnncHGj8cEj6/mSH7j+fLts
	jcQaZrcEN/mtF8U6zJuCdt+VeHZkmmBIOZfS1zMrate0r1v9QsCq0f32z09NRvsmhbI7nIow
	9f53WPXnNa7sS79Es++Wn17dc/SMr+SUvTVbUv8HF/8ok2trDljhqz3r13eGx1eVWIozEg21
	mIuKEwFNm7Rb2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7pdAX9SDV72S1i8PvyJ0eL/thZ2
	izPduRaXd81hs7gx4SmjRcvqXawObB6zGy6yeCzoOc/ssWlVJ5vH501yHlMOtbMEsEbp2RTl
	l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZcyZuYqxYLpi
	xdRXXawNjF+luhg5OSQETCQufnzC2MXIxSEksJRR4uXpjYwQCRmJjV+uskLYwhJ/rnWxQRR9
	ZJRYMeMpK4SzlVHi1ca9bCBVLAKqEv9/LwHrYBPQkTj/5g4ziC0iIC9x7skqdpAGZoGjjBLb
	53eBNQgLeEo82vOaBcTmFXCQmHWqG2rFVEaJ6U+/sUIkBCVOznwCVsQsUCZxraETKM4BZEtL
	LP/HARLmFHCSODr/EzPEqcoS1/ctZoOwayU+/33GOIFReBaSSbOQTJqFMAkirCVx499LJgxh
	bYllC18zQ9i2EuvWvWdZwMi+ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCStx37uWUH48pX
	H/UOMTJxMB5iVAHqfLRh9QVGKZa8/LxUJRFedu6fqUK8KYmVValF+fFFpTmpxYcYTYHBOJFZ
	SjQ5H5hi8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamLbsncr+
	SWZSn84pa6EbEvyy+/42PpKau7XF3U3K5NB5rb6O5qRkY9PKJbErwvtZJGIuZ2++mvWm+rOi
	woJjIrtk0ppPrLOc3H06/cCKxzUWc0UCFB45nd+onBBl+ix8z8ou96+H7GTZWYpSfh76Obnt
	7foe59+fbvroJ6axbU2RdS2f8+bwPZOjLLErbwVUPwnc1iZR3LvhastXoT1fruuZFS/9/2D6
	fI4Hj59UTmArz4njY9m8OSbVzGzF0fOFllFODxbUeM6Kbe+xOyhbH5FnLBVz8vQ5lmd7PC5f
	2/G/ksNE7+jSXH958Y49ulumNszk0PY7yZLn0fOt//DfaIlTwqJCNqkyVfPv/zBmU2Ipzkg0
	1GIuKk4EABPQAKl5AwAA
X-CMS-MailID: 20240321152146eucas1p1956acf109d76413088511707cec7f15e
X-Msg-Generator: CA
X-RootMTR: 20240309103209eucas1p25311b485e321e701eeacbdb3e2ba8758
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240309103209eucas1p25311b485e321e701eeacbdb3e2ba8758
References: <CGME20240309103209eucas1p25311b485e321e701eeacbdb3e2ba8758@eucas1p2.samsung.com>
	<tencent_C5E6023F97E7CC2A046AAEA09BC9ACF43907@qq.com>

--rhtofu2dfldrnkgy
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2024 at 06:31:17PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20
> The boundary check of multiple modules uses these static variables (such =
as
> two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
This message is a bit cryptic. I had to do a fair amount of research to
get what you meant here. Having the context in front is OK with me, but
I would add a bit more information so the reader does not have to go to
the code and grep for the variables that you mean. Something like this:
"When using a sysctl proc_handler that requires a boundary check (like
proce_dointvec_minmax) it is common to use a const variable like n_65535
in net/rxrpc/sysctl.c or OTHER EXAMPLES...). This is suboptimal because
YOUR REASONS HERE"


>=20
> Eric points out: "by turning .extra1 and .extra2 into longs instead of
> keeping them as pointers and needing constants to be pointed at somewhere
> ... The only people I can see who find a significant benefit by
> consolidating all of the constants into one place are people who know how
> to stomp kernel memory."
I think it would be better to just link to the lore discussion.=20

>=20
> This patch series achieves direct encoding values in table entries and st=
ill
> maintains compatibility with existing extra1/extra2 pointers.
> Afterwards, we can remove these unnecessary static variables progressivel=
y and
> also gradually kill the shared const array.
Two things:
1. Please name the const array: sysctl_vals
2. What is missing from this patchset to completely kill sysctl_vals?

>=20
> Wen Yang (9):
>   sysctl: support encoding values directly in the table entry
>   kernel/sysctl-test: add some kunit test cases for min/max detection
>   rxrpc: delete these unnecessary static variables n_65535, four,
>     max_500, etc
>   net: ipv6: delete these unnecessary static variables two_five_five and
>     minus_one
>   svcrdma: delete these unnecessary static variables min_ord, max_ord,
>     etc
>   sysctl: delete these unnecessary static variables i_zero and
>     i_one_hundred
>   epoll: delete these unnecessary static variables long_zero and
>     long_max
>   fs: inotify: delete these unnecessary static variables it_zero and
>     it_int_max
>   ucounts: delete these unnecessary static variables ue_zero and
>     ue_int_max
>=20
>  fs/eventpoll.c                   |  19 +-
>  fs/notify/inotify/inotify_user.c |  49 +++--
>  include/linux/sysctl.h           | 108 ++++++++++-
>  kernel/sysctl-test.c             | 300 +++++++++++++++++++++++++++++++
>  kernel/sysctl.c                  |  61 +++++--
>  kernel/ucount.c                  |   8 +-
>  lib/test_sysctl.c                |  12 +-
>  net/ipv6/addrconf.c              |  15 +-
>  net/rxrpc/sysctl.c               | 169 ++++++++---------
>  net/sunrpc/xprtrdma/svc_rdma.c   |  21 +--
>  10 files changed, 571 insertions(+), 191 deletions(-)
>=20
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-kernel@vger.kernel.org
>=20
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--rhtofu2dfldrnkgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX8UIYACgkQupfNUreW
QU8J2gv/Wn96kRUWj6M/Gm9p4gkRJQnz6ahfI8r0J3+R4q3wadjt0PQKuOMdozaG
ld8xIwkJE5EFU8ZUAtEfA6e4wWuiDYP51C2xAmXMys1ZGLwpkikq75ZEJWdGBypO
pFlv9n/XbJh0rgz6ArJ5p7X46h3oo0P7ad5OPsKC/hHvJGw9dhIfPRskNi9yMjQ2
O63HjrVg67eLviSklenG0bNlSjZS+3IsgqjSMV5yHxeqA7SfIegFkQUB2WN5he1k
Pbcu0CQ3oPYZT/cBMPOzDHg5Q0/CdfjBOPCqVInluHzXJYYtOm32ybkPuKu6aJEY
ErYBabw96H+dNU5b4GK2NxGBT42iCsWv+CmxTmgFCVJXekcSs0B7dLyyiOb5Wrn9
MxvCpB5g2fIoKHo6btbHi+Clcrc0zwthe45LVuCfd+rUGs0SMyvLJB5nPfCPGdLG
JaPL+UQzV77SR/3qQ5XuCxdtgZjeMmFiBACMZmtQLKhW1hoqF2SXQnp+vunfyksK
WiHPHbPP
=aSag
-----END PGP SIGNATURE-----

--rhtofu2dfldrnkgy--

