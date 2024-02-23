Return-Path: <linux-kernel+bounces-78094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6B860ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0031D1C2320A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB05C5D47F;
	Fri, 23 Feb 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HarJJ8X5"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CD5CDF4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682378; cv=none; b=MVphQdnW9/ppjHFq2hnIPv8exGf5eajjhjIH/CExcv2TG9ZkMTMbrN9uZnJyN83iVVEBmKfdx8Or66G+Iuek0pkFop2kCYogrszWkEGTstrUVJTP46J9I8FHbB1/tdx6cnfX6FKJwyCMA4zg8WE0fKsj7Tc+sF8Y+yn2AMdLN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682378; c=relaxed/simple;
	bh=cFTksA3d1co4t7MZJLSztTvKeJ36y8PccsN5Ft6WoOI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=bb9xevZTtMJuHuPePKhq3PQ+bXB+7H2mJ/TexW2p0Xp9UzSzR87TV+Kk4IF35QLOqpdBFh9BQcein3szqdDvgWLoo+t4qCPhcSAj428cGi/Ah6agb2q6U35I7zOOnRNOpoTOtifz531QlCbA0bTo7Qz3xGCPu8gErgWyaeg0GMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HarJJ8X5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240223095922euoutp02db4a4366cb9924df4dd6c843f869bd9b~2dY42cR260811808118euoutp022;
	Fri, 23 Feb 2024 09:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240223095922euoutp02db4a4366cb9924df4dd6c843f869bd9b~2dY42cR260811808118euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708682362;
	bh=3XP7aqUsbKUFkgKNyQaR29smn8YfFpP0N1LJoAmUhOc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HarJJ8X5/j6D4a9M8rwIcWRcX9qdJHRuBMl4JBwfrhyE+raEj0OUXbcFaPI8xBvpH
	 NlLQABXX8cS8ry+YGRYxan+XMoR77OvErVEVWjzrbr/3v+UG7sbx3wYyGGVt6okajA
	 WZQRtD5j7u7Nr/q0LwHCwW490RDY2FTLjlLlPyTY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240223095922eucas1p2511c3bcd33cd5ae96cb75aa948ff5a7f~2dY4sIRiE2065420654eucas1p2I;
	Fri, 23 Feb 2024 09:59:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.96.09814.A7C68D56; Fri, 23
	Feb 2024 09:59:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240223095921eucas1p1a1d188b8de65d17a87e46706bdb7ceef~2dY4UIdZn2309623096eucas1p1Z;
	Fri, 23 Feb 2024 09:59:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240223095921eusmtrp22f4e77d04ea324110d3917851c26ba60~2dY4TnCV93008230082eusmtrp2_;
	Fri, 23 Feb 2024 09:59:21 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-55-65d86c7aac96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.40.09146.97C68D56; Fri, 23
	Feb 2024 09:59:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240223095921eusmtip240f48805f397135ebf20dbda2c8bb4b6~2dY4Gjh-Q2794027940eusmtip2e;
	Fri, 23 Feb 2024 09:59:21 +0000 (GMT)
Received: from localhost (106.210.248.222) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 23 Feb 2024 09:59:20 +0000
Date: Fri, 23 Feb 2024 10:59:18 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] ipc: remove linebreaks from arguments of
 __register_sysctl_table
Message-ID: <20240223095918.karsamdx3a2w3v7w@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="bsfhvc4vn6y5qzwj"
Content-Disposition: inline
In-Reply-To: <20240219-sysctl-check-v3-2-6940d5ff747b@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSe0hTcRjtt3u9u1usrlPpQ6OHpWHa7EnLWVRYLKOyyCITc+VNS3eVXR9L
	irKnGuh62MhGZqJLDS3LaYUVg+Yr7TGrzbIXS0gXKpYk2qrtLgr673znfOfjHPhITFzj4Uvu
	Y9JpFaNI8SeEuME0+mRedoqFnm/SYlLzXR0hHfvey5NaNJ/QSkxeV5VHyIfrpskLT5v4UViM
	MDyBTtmXSatCV8QLky4ZjxFphV7qZoOZfwRVUflIQAK1GIbeNxL5SEiKqWsIWq7beNzwFcGH
	znb3MIzA8agQ+2Pp6r/nwQl6BH05esIpcFt1YZxQj6CkpAZ3CjgVAF0/ylyYoELgif2N65I3
	FQ6VI8P8fESSGCWHJk20k/ai4kD/sB05aRG1Eo6/EDhpEeUJrRdtrisYpQbLmAZxTj/QO0gn
	LaDWQHlFK8HFnAW1hk535EPQdrvb1QUoOwnW6kYPTogA3ekGN/aCvubbfA5PhZ93StyGcwge
	OAb53FCNoCLnG4/bksHxLpvbsQrsI8OuREBNAssXTy7oJDhr0GIcLYLck2JuOxCq39pxDZpV
	/E+14n+qFf+txtESsBSdJ/6jg6GitB/j8HKoqRnAryB+FZpCZ7DKRJpdyNBZElahZDOYRMme
	VGUd+v1G7Y7mr41I3zckMSIeiYxo9m/zxxvVT5EvzqQytL+36HmyhRaLEhQHsmlV6i5VRgrN
	GpEfiftPEQUkTKfFVKIinU6m6TRa9UflkQLfIzxBxyLzVCZXlrRxsvDnnLto7WrZlYPiV20G
	vDze9GXR4cum1te9Yk3PQKhXv7Ug+JRGH5m3osE6Gp4UYTYmWrVotwCXzfh8NDPbWlZU2y2U
	8pcFaKRVLVebOpS1Op9k9kBp5WZJV1OWdnz7s1Xq/d6ROjmTuSN8/c53t9KXjm/vtjFb7uSU
	n1MX+J6SXdskCh04OHLLY8K0uLedo0FhjvGevJD76FtY7omW5dp6n4m6wbSZQ31b09eNLQje
	EHppS8JjJR5TcAbj90Sy27A1trC9xr0xSz5FLQvS2D1Hh6KX2AdjXwZ1zNwWq9NdOJMVmN/p
	Z37Yu/DmDPVFXlFaxIMOf5xNUiyYi6lYxS9U/AsSwQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7qVOTdSDW7sVLO4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQyDjZcZyvoFa6492gHYwPjCoEuRk4OCQETiSuvd7N2MXJx
	CAksZZR49HsqE0RCRmLjl6usELawxJ9rXWwQRR8ZJRZv+8gOkhAS2MooceK0GojNIqAqceXv
	YhYQm01AR+L8mzvMILaIgI3Eym+fgeo5OJgFPCT2TggFCQsLxEksP3CaESTMK+Ag0XKVE2L8
	ZUaJnVOmgLXyCghKnJz5BGwks0CZxI5TT6DGSEss/8cBEuYUcJVYuuwkG8SZyhLrt51jhrBr
	JT7/fcY4gVF4FpJJs5BMmoUwCSKsI7Fz6x02DGFtiWULXzND2LYS69a9Z1nAyL6KUSS1tDg3
	PbfYUK84Mbe4NC9dLzk/dxMjMCK3Hfu5eQfjvFcf9Q4xMnEwHmJUAep8tGH1BUYplrz8vFQl
	Ed5L2TdShXhTEiurUovy44tKc1KLDzGaAsNwIrOUaHI+MFXklcQbmhmYGpqYWRqYWpoZK4nz
	ehZ0JAoJpCeWpGanphakFsH0MXFwSjUwSW9SlBGx4eT4Wz/JSWfikd0lvOcCN9Qq2r+ZoOL3
	5gXDNmPmVb2/HvyXYLDRUOXcIaLatixlR4hP8rapN75wnTp67rir8MRss09HMv/M7VnresOC
	v/CMTOTBgogvKvxrHvjK71tUd+JWc9q6ZrlOX6WP6wSqxK/MO7SD+X741rrlT076BUwpneG2
	dh3DCvddKT/6dlWvtmIUfK5UuD354+y9Zdt6VEQ/9fmWybhO+cAnuyhoQvf3a40y01Y6nPeZ
	xzWtWiT6wsIF5n3rg8+f287UuvOkzxwTzQuf6nvak5bG7YkTuLBTzaYgLn/r5AffEg/wBW3/
	sqY3Wevuw6vKL++eqC981C1dpjY33reOR4mlOCPRUIu5qDgRAMfTbihdAwAA
X-CMS-MailID: 20240223095921eucas1p1a1d188b8de65d17a87e46706bdb7ceef
X-Msg-Generator: CA
X-RootMTR: 20240219201941eucas1p292f4407f82ea9f76bd91fd0c50611010
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240219201941eucas1p292f4407f82ea9f76bd91fd0c50611010
References: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
	<CGME20240219201941eucas1p292f4407f82ea9f76bd91fd0c50611010@eucas1p2.samsung.com>
	<20240219-sysctl-check-v3-2-6940d5ff747b@weissschuh.net>

--bsfhvc4vn6y5qzwj
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 09:19:23PM +0100, Thomas Wei=DFschuh wrote:
> Calls to __register_sysctl_table will be validated by
> scripts/check-sysctl-docs. As this script is line-based remove the
> linebreak which would confuse the script.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  ipc/ipc_sysctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 8c62e443f78b..e4008288a3ba 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -259,8 +259,7 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
>  				tbl[i].data =3D NULL;
>  		}
> =20
> -		ns->ipc_sysctls =3D __register_sysctl_table(&ns->ipc_set,
> -							  "kernel", tbl,
> +		ns->ipc_sysctls =3D __register_sysctl_table(&ns->ipc_set, "kernel", tb=
l,
>  							  ARRAY_SIZE(ipc_sysctls));
>  	}
>  	if (!ns->ipc_sysctls) {
This is very interesting and points to a bigger issue with the
check-sysctl-docs: which is that the AWK record separator is "\n" and it
require that the lines being analyzed follow a strict pattern; even if
that meant having a loooong line (not the case in this patch).

The final solution would be to change the separator to something less
line based to something more C based like RS=3D";{}". This is not a
blocker to this patchset as it actually fixes a broken script. But is an
interesting observation for whomever wants to continue this work.

Thx Thomas.

Best

--=20

Joel Granados

--bsfhvc4vn6y5qzwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXYbHUACgkQupfNUreW
QU9BngwAilWHaCGV02c63TsG6KffhHuQxvdozwA1Rr5Uq6I1Y0RM7O4gj8nqDbjP
AqPechNONJekobgOreItUGnUBzVuwqMzKArhkiazI928Z++hdiZq9vzqJACnmOM9
H0nJ8kEXfvcbm1/vmKYPJZAmMNeVzAo9vby8I+zQCEg1Cmp8PrlWEVit3WKasLRF
GPbg35wAXa9NZkMwt/nMyrqQ81veLZYx0HY3qknsixO5sdJ2+8G9y4ZnIX0WQMXb
6gyekKElut7gPjOf9xOQWSR5ekHFMkqbvF62edVPxNpNnatEA4TTdx4XpyaCA4Ey
uYJtvAcyXR8l2l5lfQaai/badSAcq7oJKoqXwO7UBWo0c6KOd0u4nNLpVmOM5995
7qrn5QJEkm9illA0OfOkQlYTpChCu2cp9vbFyveSaOg1l/029gu3/3jJu3tJEvY3
CeUFNyB1EmDSTZyEWeaXeQ2JfUq+1VGQoLnvTlFSYY938wprdOHPtmxvd6+audgM
/oAp2JtU
=kfHz
-----END PGP SIGNATURE-----

--bsfhvc4vn6y5qzwj--

