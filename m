Return-Path: <linux-kernel+bounces-72629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B685B66D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352A41C23D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69260DDC;
	Tue, 20 Feb 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dvifq2gp"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F895F554
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419459; cv=none; b=oxkKRdKLqc3zN0i2E0NPhx54JpuB++rymz6xNA5UdEAw6d7UZgE6RfGGDTWMuZh6H2i391cPCLmovysl7UqJ/gcZr8pTm61NZV2dhUwdR7oO4bz5C+FHJS+rOZlqwVDOb/XxLdbPyBglnbvGUFoeUafjrF65XIHLO2fLVGfLC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419459; c=relaxed/simple;
	bh=d3J2viCIupmNu/Zrz/TXpO4/KSnq3KH1ha9ME5ghR1w=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=aPzhYj/Qh4AzHC8pgDJOBhu4iXQ/gemG7YgZe47HpCHeO3tG9XCx/et/zXWrEKWwxWqXqBh59+NvchNEqRHK2ue0uxtA98qHS4L0+yhMm9Ao3B3j5OHN20DTRpAICKLw4afiazdvoXy0OVGSspf0km+yHNhUpORrFJPEIzo7x2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dvifq2gp; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240220085729euoutp02afb6d61807c26413710282e4b09636c6~1hnAVSdJD0613906139euoutp02L;
	Tue, 20 Feb 2024 08:57:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240220085729euoutp02afb6d61807c26413710282e4b09636c6~1hnAVSdJD0613906139euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708419449;
	bh=6Jrr4BErpksEcMV4nXO6UqABNIRBF9KHU7/F0KYEIJU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dvifq2gp76nXlC4cEs/gnf4WII2EsnAlggPKd2dqgh21MCcKgUsxG/nWVhUn2CLtf
	 OZ3TR07Lip2uRa5+0JyttTa9Uz6SiZub8dr4xE5cZaEIUqm7JKtsMkRJgk9YPgZKkE
	 D+0QD5rFgDXA/sOqWf0CJG9wQnecHhnTvy9MMQ0g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240220085729eucas1p1861faba1147f1de9f5021959fd68cb8c~1hnAKtA4P0622906229eucas1p1G;
	Tue, 20 Feb 2024 08:57:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.3B.09539.97964D56; Tue, 20
	Feb 2024 08:57:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240220085729eucas1p23994be6aaf97fe2f41fa1a29c61dd30c~1hm-zsUIc1250512505eucas1p2p;
	Tue, 20 Feb 2024 08:57:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240220085729eusmtrp1b456ef066080312b9669d778ca9cf87b~1hm-zJ9rL0761307613eusmtrp1q;
	Tue, 20 Feb 2024 08:57:29 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-02-65d469791c0c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.DA.09146.87964D56; Tue, 20
	Feb 2024 08:57:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240220085728eusmtip1538581640047c60aabeecc96ae099761~1hm-oA0pd0281902819eusmtip1P;
	Tue, 20 Feb 2024 08:57:28 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 20 Feb 2024 08:57:28 +0000
Date: Tue, 20 Feb 2024 09:57:26 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] scripts: check-sysctl-docs: adapt to new API
Message-ID: <20240220085726.bnlusgy5qdmcwpar@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="2i76zjxmk6xwic6d"
Content-Disposition: inline
In-Reply-To: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87qVmVdSDQ6/F7W4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo7hsUlJzMstSi/TtErgy+mZ8YSxoE6nY+PQaYwPj
	CsEuRk4OCQETiXUTNjB2MXJxCAmsYJT4vXYlI0hCSOALo8Sh//YQic+MEhvOzGWF6eh9P4EF
	IrGcUaL1wBQmuKq7z6ZBZbYySnw4tpQJpIVFQFXizu6nYHPZBHQkzr+5wwxiiwjYSKz89pm9
	i5GDg1nAQ2LvhFCQsDCQ+fP2LbBWXgEHidW/5rNB2IISJ2c+YQGxmQUqJJY332aDaJWWWP6P
	AyTMKeAqcfDWVWaIQ5Ul5rzeAWXXSpzacgvsTgmBJxwSZzd2MUIkXCQ+7JvGBmELS7w6voUd
	wpaROD25hwWiYTKjxP5/H9ghnNWMEssavzJBVFlLtFx5AtXhKLHncCMzyEUSAnwSN94KQhzK
	JzFp23SoMK9ER5sQRLWaxOp7b1gmMCrPQvLaLCSvzUJ4DSKsJ3Fj6hRMYW2JZQtfM0PYthLr
	1r1nWcDIvopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwHZ3+d/zTDsa5rz7qHWJk4mA8
	xKgC1Pxow+oLjFIsefl5qUoivO5NF1KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQn
	lqRmp6YWpBbBZJk4OKUamAR3JXD+nXlEwXuBp0dktalK9vRFXDu1vptdEm5cebqs8ciV146v
	Fq2z0vY6arvXxSqbkXERZ7V1fMz2D+dUr5qsnyz3ablrcf+x5CeN5lWfbv01naT/qWoLU92M
	Yqmykr9tM0I/bfEvrdwhW+/GGrZcZZl/w/Nd4RoWmkzW+mm5hyMsZvur2dm8eB/8R8f9T178
	XNeaQ1lq7GWrUz+6Xm0U/5oTzVMTEXe90O4Jg1rptZgN6gef7ujfsebTFRG2JatYfme/l9Yx
	4v2kYW4873XcgZb1BZ1ikzyj0n48XOlWG6eqMOv+bk4t3e0bjpTtNmieuVbm3tk5JxadEWsM
	VXBpMREx+Bmadvig9dx9SizFGYmGWsxFxYkA0tOgFMIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7oVmVdSDR71Wllc3jWHzeL3j2dM
	FjcmPGV0YPbYtKqTzePzJjmP/u5j7AHMUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
	5rFWRqZK+nY2Kak5mWWpRfp2CXoZf/69YS5oEalo/fWQuYFxmWAXIyeHhICJRO/7CSxdjFwc
	QgJLGSUeLj/JBJGQkdj45SorhC0s8edaFxtE0UdGif1L9jJBOFsZJbat+ATWwSKgKnFn91NG
	EJtNQEfi/Js7zCC2iICNxMpvn9m7GDk4mAU8JPZOCAUJCwOZP2/fAmvlFXCQWP1rPtSCGYxA
	zmo2iISgxMmZT1ggesskOs/lQpjSEsv/cYBUcAq4Shy8dZUZ4k5liTmvd0DZtRKf/z5jnMAo
	PAvJoFkIg2YhDAKpYAY6eefWO2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjSGppcW56brGhXnFi
	bnFpXrpecn7uJkZgRG479nPzDsZ5rz7qHWJk4mA8xKgC1Plow+oLjFIsefl5qUoivO5NF1KF
	eFMSK6tSi/Lji0pzUosPMZoCg3Ais5Rocj4wVeSVxBuaGZgamphZGphamhkrifN6FnQkCgmk
	J5akZqemFqQWwfQxcXBKNTBJ9b68ZK//lp0/zuDYvAeiPBe3We7QU/27wvZXy6ItfZMrQ9bY
	JJcoXbrwefHvmao+i85Y5cvtLJy75rKWYBDn3peR0qXes5ZKGWYVzzvnNLtcc5fN67qihqmO
	Zhz/Nim+zLlqdGrqtb7fG8+x6lT//qLFKHJASIx98e+TU1Zuf8zHpHm2ILXpq47mnsgLT8pu
	Wr9Ynroy2WxZ0ZmpKz391MROXbY8nMB6f/tk779diq5Pd2p179hSKlxT5ftoaT7/v0jrxNSa
	Ay6LzmneMj0yy4v9eVTIBe/Xjy1nXDtw9Zcd96RTD09s8zFpdOZe8euW1OYr3EnrpzWy5u1Y
	9i1ioucKEU02/c3e6826ohq5lViKMxINtZiLihMBNwl5bV0DAAA=
X-CMS-MailID: 20240220085729eucas1p23994be6aaf97fe2f41fa1a29c61dd30c
X-Msg-Generator: CA
X-RootMTR: 20240219201941eucas1p13b89861348f250d5e9b6b3b7441a56ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240219201941eucas1p13b89861348f250d5e9b6b3b7441a56ed
References: <CGME20240219201941eucas1p13b89861348f250d5e9b6b3b7441a56ed@eucas1p1.samsung.com>
	<20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>

--2i76zjxmk6xwic6d
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

Thx for your V3. I'll put it on my sysctl todo list for friday.

Best

On Mon, Feb 19, 2024 at 09:19:21PM +0100, Thomas Wei=DFschuh wrote:
> The script expects the old sysctl_register_paths() API which was removed
> some time ago. Adapt it to work with the new
> sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.
>=20
> Per-namespace tables via __register_sysctl_table() are also handled.
>=20
> Note that the script is already prepared for a potential constification
> of the ctl_table structs.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - Handle per-namespace tables
> - Link to v2: https://lore.kernel.org/r/20231226-sysctl-check-v2-1-2d4f50=
b30d34@weissschuh.net
>=20
> Changes in v2:
> - Remove unused global variable "paths"
> - Remove docs for deleted variables "children" and "paths"
> - Link to v1: https://lore.kernel.org/r/20231220-sysctl-check-v1-1-420ced=
4a69d7@weissschuh.net
>=20
> ---
> Thomas Wei=DFschuh (3):
>       scripts: check-sysctl-docs: adapt to new API
>       ipc: remove linebreaks from arguments of __register_sysctl_table
>       scripts: check-sysctl-docs: handle per-namespace sysctls
>=20
>  ipc/ipc_sysctl.c          |  3 +--
>  scripts/check-sysctl-docs | 65 +++++++++++++++++++++++------------------=
------
>  2 files changed, 33 insertions(+), 35 deletions(-)
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20231220-sysctl-check-8802651d945d
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--2i76zjxmk6xwic6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXUaXQACgkQupfNUreW
QU/AFgv/XEA3IprJj+PBJmCrtoq5UR/KHlhkecyLtD2L3yZay1hq/4F4Ydd86hNa
2PVyHKkpSnyD0cvEAi9KFBqjFuVxVpFfZ64jPykxSHDGrGCRRnLoDaQCClRCxkLC
4T8aCSHyWZkkW3mcfxRA+LWolzhGKl9F5ySM8DiSuP+5HXrCQejFoyasuX3ctjnt
BX2OMrCkr5djUcLr94r7cHPp/gOzkE1Zi6BJY/VjwwbihdmNlE2ErftmyLWuK66W
w18vKfYdwua8ZKEFuXo021mwIpI+paTIaxCCovvJcwUOdmhfFDpwR87S3D5P+ObK
kUy/YsVe1R5QLNGh5AHoNW4WS69fBeEDb9yf9UTKVTuCOb6BEFjR5dzECTSlZWrp
omMqk8Rdu2ZM3j5b9u+cU37T6sWQ8KhdSQABbgyUQ/KPdnt84axSOdcyFYRVKS3D
fSx18kyq/jSp1L58RQPncU73M7Igcv0MlU51ktOk0pf5s90VgeqW98eLTxr7t59M
l9Vvhnuq
=tMNS
-----END PGP SIGNATURE-----

--2i76zjxmk6xwic6d--

