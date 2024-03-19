Return-Path: <linux-kernel+bounces-107568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60387FE38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F30F1C21F15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D580C13;
	Tue, 19 Mar 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hanU3ha/"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871077E591;
	Tue, 19 Mar 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853651; cv=none; b=WV5FE768q5vUil0aWtbqAJChZhoxapXUR1QvdlbSRILv4yZxRbaQp9ytmCDdpoFBphfT4uU/U7lNCA4N1OvTYx/ylV21JgrSJP7QekkZ/p8RKreoyg1U0KniZdSTr8Al/5B9koAPSwZbhxQaJPC1+gDSRxZJhMBs/tX4mCt1u0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853651; c=relaxed/simple;
	bh=reP5kh3mZu6dGLQ86ohHrExp+d46385Mi5nBuzrM8yk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qVxoqKyixOTyYKwp/t1J4iJNRphgR0h6FTxkrPPDcyFhEe08AaDPBwdskqNIZsKr1/c6fO2TyXnTToBj+v56TCR0yTCHuqpnlQVIhiBYgHUYjFU7uqJpnYSz8Y7D1g9DuF813Bk8M4Y1KEsXtsbLHZLHiC0ecXdaatsGGmXxBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hanU3ha/; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240319130719euoutp02dcae367966dafafb220c6c40c89f7d4b~_LFItX-Cw2646526465euoutp02E;
	Tue, 19 Mar 2024 13:07:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240319130719euoutp02dcae367966dafafb220c6c40c89f7d4b~_LFItX-Cw2646526465euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710853639;
	bh=rwCSpmbvgmVIa+CtjhH+6gVJz6mA1KgfwUGVJRhP+1c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hanU3ha/SNYbSw9HkWTIZGrJogxKhpgAyBarZoeLxqP4X290WOucBz0qWueq2dkSG
	 nMsFf92WTWSWy3FDyS3wsTcd4ChSfC9rFfuYKvWQ4R+wVdiAW8WAiEllZVl8Vcc8TP
	 Dk/QXqId2UnExKtc48lT8O2QmtOffy3Qy0kOe/5U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240319130719eucas1p192eafb04b220da84388078e006588b7e~_LFIT5mrM0336803368eucas1p1-;
	Tue, 19 Mar 2024 13:07:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 99.AB.09539.70E89F56; Tue, 19
	Mar 2024 13:07:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240319130719eucas1p15bdc63ff5fdd5c9e948ce84e1505352a~_LFH3y31M0336803368eucas1p1_;
	Tue, 19 Mar 2024 13:07:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240319130718eusmtrp2b2a1469d4ebfa20b01fc0a8139a96895~_LFHz_Llp1402714027eusmtrp2F;
	Tue, 19 Mar 2024 13:07:18 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-ce-65f98e070b25
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.F3.10702.60E89F56; Tue, 19
	Mar 2024 13:07:18 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240319130718eusmtip27bba48620de2046dae7c71d24286f732~_LFHpvDcT2764927649eusmtip28;
	Tue, 19 Mar 2024 13:07:18 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 13:07:18 +0000
Date: Tue, 19 Mar 2024 14:07:16 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] net: always initialize sysctl ownership
Message-ID: <20240319130716.vne4nhb3mbwtabfb@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="77xvdswkctbb3d3j"
Content-Disposition: inline
In-Reply-To: <20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djP87rsfT9TDT7vkbSYc76FxeLwoheM
	Fv+3tbBbPD32iN3iwrY+VovLu+awWfz+8YzJ4saEp4wWxxaIWXw7/YbRgctjy8qbTB47Z91l
	91iwqdRj06pONo/3+66yeXzeJOfR332M3WPKoXaWAI4oLpuU1JzMstQifbsErowL3zewFOwW
	r5hzKaCBsVOki5GTQ0LARGLCxYWsXYxcHEICKxglfn96xQjhfGGU+HfgOZTzmVHi0ua/rDAt
	fy69Z4JILGeUWPL6NlgCrGryVSOIxFZGiek3rzKDJFgEVCW6nvaDFbEJ6Eicf3MHLC4iYCOx
	8ttndpAGZoErTBJ/pn9mAUkIAyVmzz3PCGLzCjhILN38jhXCFpQ4OfMJWA2zQIXEznkHgc7g
	ALKlJZb/4wAJcwr4Sqyav5IZ4lJliev7FrNB2LUSp7bcArtaQmA/p8TkR5fZIRIuEj9brrJA
	2MISr45vgYrLSPzfOR+qYTKjxP5/H9ghnNWMEssavzJBVFlLtFx5AtXhKDHpxkZ2kIskBPgk
	brwVhDiUT2LStunMEGFeiY42IYhqNYnV996wTGBUnoXktVlIXpuF8BpEWE/ixtQpbBjC2hLL
	Fr5mhrBtJdate8+ygJF9FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmASPP3v+KcdjHNf
	fdQ7xMjEwXiIUQWo+dGG1RcYpVjy8vNSlUR42bl/pgrxpiRWVqUW5ccXleakFh9ilOZgURLn
	VU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwBfU/L649M/t0UKx/Y87VgxE2++Zt0V3zx9MvkXHD
	cc5fgkERk9xT52pePv/StnmK/roLud2lTx6WmwlKVDDV21naJ3jt+tr06rFG2eKF6jfTev/w
	vJmR1X9nWqD36RrrlD1XdR982OQmfHnLVq9LIf93xzgul5a38/HIm2G6ns2m0l+u75hhXnE5
	j+lkxQ2nhK4kngqaLqXI17cxf5VtveWftwUZ7z+vV2z3NePknq0sX2zxcfvFGz8ddmivPffh
	CONNv1NbEpZrHYjuW94joLNo66NZz/wni00oKe531duquP9TUVKaUdnEfZNPrqm6XFfD7NH6
	YNrjfb7VzQ+unA1Re/6xou86R/jNK9eWKbEUZyQaajEXFScCAE8K7o39AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42I5/e/4PV22vp+pBhPfm1rMOd/CYnF40QtG
	i//bWtgtnh57xG5xYVsfq8XlXXPYLH7/eMZkcWPCU0aLYwvELL6dfsPowOWxZeVNJo+ds+6y
	eyzYVOqxaVUnm8f7fVfZPD5vkvPo7z7G7jHlUDtLAEeUnk1RfmlJqkJGfnGJrVK0oYWRnqGl
	hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbPfd2MBTvFKz71bGRrYGwX6WLk5JAQMJH4
	c+k9UxcjF4eQwFJGiQ0tv1kgEjISG79cZYWwhSX+XOtiA7GFBD4ySkxdywnRsJVR4viM32BF
	LAKqEl1P+8FsNgEdifNv7jCD2CICNhIrv31mB2lgFrjCJPFn+mewDcJAidlzzzOC2LwCDhJL
	N79jhdiwgFGifY4ERFxQ4uTMJ2D1zAJlEmderQAaxAFkS0ss/8cBEuYU8JVYNX8lM8ShyhLX
	9y1mg7BrJT7/fcY4gVF4FpJJs5BMmoUwCSKsI7Fz6x02DGFtiWULXzND2LYS69a9Z1nAyL6K
	USS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMBFsO/Zzyw7Gla8+6h1iZOJgPMSoAtT5aMPqC4xS
	LHn5ealKIrzs3D9ThXhTEiurUovy44tKc1KLDzGaAkNxIrOUaHI+MEXllcQbmhmYGpqYWRqY
	WpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw5Tw9c0wsPft8wG276DbfkvNMXcsnOspe
	3hRsFfmieMKspfH/5MOm7Du6LLT68AeXeKbzDXvOfXvFsldgitDJGpvZG5/f2nGB6eaGEztF
	2p8UzX9odL43N35Z97xrXwO3hFhyHOyb5Ny9IDJug1SBxUztA/7XNH8U6LEwmekxOgUaurBG
	/Xjhn5Tv+fNkvOUpp+VLlrxZVv7i+LwAv1MW3peFNGZKacz+yPjg9OkdbzNZcviuT+jgNqzb
	Y8FSxiN2ZE76oc21aRsX5+69sk0/Jvmk7fTtRW0bFJ84MzbPb7ELPfNhbVr46zhh7aXS9bPv
	cCt439JxP//dRPpOgsp6nuh+DR1PKWnfbRkB95cwK7EUZyQaajEXFScCAFh/ZZaZAwAA
X-CMS-MailID: 20240319130719eucas1p15bdc63ff5fdd5c9e948ce84e1505352a
X-Msg-Generator: CA
X-RootMTR: 20240315162041eucas1p1b9254ef7e70f21b24b88d0999c34e9bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240315162041eucas1p1b9254ef7e70f21b24b88d0999c34e9bd
References: <CGME20240315162041eucas1p1b9254ef7e70f21b24b88d0999c34e9bd@eucas1p1.samsung.com>
	<20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net>

--77xvdswkctbb3d3j
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 05:20:31PM +0100, Thomas Wei=DFschuh wrote:
> The sysctl core does not initialize these fields when the set_ownership
> callback is present.
This is a bit ambiguous as these values get set in the new_inode(sb)
call. What is really happening is that the GLOBAL_ROOT_[U|G]ID is not
getting the correct default.

> So always do it in the callback.
>=20
> Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container=
's owner")
I think this is incorrect and here is why:
1. At the point of committing this code, the default behavior was
   dictated by the new_inode call. Which calculated the value from
   super_block *sb. This was Aug 10 2016 (approx).
2. The issue comes when a new default behavior is added by setting
   GLOBAL_ROOT_[U|G]ID in 5ec27ec735ba0 ("fs/proc/proc_sysctl.c: fix the
   default values of i_uid/i_gid on /proc/sys inodes"). This commit was
   in 2019 and missed adjusting net_ctl_set_ownership.

> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  net/sysctl_net.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> index 051ed5f6fc93..03e320ddacc9 100644
> --- a/net/sysctl_net.c
> +++ b/net/sysctl_net.c
> @@ -62,12 +62,10 @@ static void net_ctl_set_ownership(struct ctl_table_he=
ader *head,
>  	kgid_t ns_root_gid;
> =20
>  	ns_root_uid =3D make_kuid(net->user_ns, 0);
> -	if (uid_valid(ns_root_uid))
> -		*uid =3D ns_root_uid;
> +	*uid =3D uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
> =20
>  	ns_root_gid =3D make_kgid(net->user_ns, 0);
> -	if (gid_valid(ns_root_gid))
> -		*gid =3D ns_root_gid;
> +	*gid =3D gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
>  }
> =20
>  static struct ctl_table_root net_sysctl_root =3D {
>=20
> ---
> base-commit: e5eb28f6d1afebed4bb7d740a797d0390bd3a357
> change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--77xvdswkctbb3d3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5jgIACgkQupfNUreW
QU9aBQv4y/kPkCfk3e1MiGhyEft349vB7oaq5TDecvH3jR+qdMK7I45JAJYT8FIh
nfuQEbUynAleV37MLpjGyMYfRCLeIZz/Lq3U35qqdbR/1qDCzaKLRXZy6LteIn6D
kjQ2A8F/HFNELD1zouCdYEBGkSgjXXuUWxQW78/JPuKQzQd4GcezlJAnn9J0nvJL
heG00PUNuEskrEPPQhxN2mxbQ0hs2RHZx5XVquBstCGMhOVNgWnpiR5267JpH8sN
khRQSr0XsSF8bn5rGteOm1WFiPt5cUJVZFj/XbJfEi/Qw+gPGtqNCXhl5gYvKhl6
f3fuAR1K5EM1nAFXd114hVIE6O8xMYCSnOwK7rUCZ9qQ2P6m8KrA8X47YygqT3GG
m8E5unPdQTp7oUNCAU+3AkJ3tXToxhD7xPS4QmwRrZH2BFCoHCMUhsNcX2myYfd8
5A5V1ypil7iBoCuAK0qWzrL3YDhO+rvv9T2Gtce5HJ5g+RqEaGnwTxnc2FYbsxzC
CGJcQIA=
=jgTh
-----END PGP SIGNATURE-----

--77xvdswkctbb3d3j--

