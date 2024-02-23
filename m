Return-Path: <linux-kernel+bounces-78188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA9860FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCEB23AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61063121;
	Fri, 23 Feb 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pww1sWQy"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6714B835
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685987; cv=none; b=Bz1N+VAzFcT0f2SJvzS50LImtn1eEL4yr5uPh0PaOI/SR4N0ewMvAIufxy9lssLnSCbgiFz+fO9Cj1jOG7wWQ3KBkxeqNK3uZCgPveimt3rO1qurrx5Ymv86M5BVp8L+Ibqfutv4g34wOjNzl8Wi1NL6MM7U/P48fSonGIyQcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685987; c=relaxed/simple;
	bh=AgY6/+5lSJy92AKe5atEtB6RkciqKK/DFDWrTTlsCE0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=FQmtG8Q6LGstIXBmmgwMCCMkB+1S9ZHjHMMqSjqk4b2MhF4ORITRE5BWzFcfHEwYHWCM6S77rKKDm8eoFXpAAlcq3pE1ASbDp20MZamneFVSqVn/702ffQ6pQ8WTW9/9BLM4Wrw7/idDHpOlTX0IEXb6+kNSsLixgi4wk+BBE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Pww1sWQy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240223105943euoutp02ca614ac0fee869f5e55dbb989e935d85~2eNlzkKg11106911069euoutp02-;
	Fri, 23 Feb 2024 10:59:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240223105943euoutp02ca614ac0fee869f5e55dbb989e935d85~2eNlzkKg11106911069euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708685984;
	bh=eKC7rMJIIx0o6QvhUb6X2jveVsZzq/sAHJ1hJ2f+jgM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Pww1sWQyj3CIkcDL+P7BIxCjoOCK2tPFIxGJ5EMh7ATpetMO4rsOJ4f6zipVJkKCW
	 aYQHUJ827E3xm+7FwOf1AztcEJbZTWtZuJvJYawC0iRuAlgGF0ZkwCpNbV090RA6I8
	 k9+b24o5DwwFi5Z5RvTSZ+a6uY6opEUa6W/Xcopg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240223105943eucas1p194a39ac5709b1b9def36120b9bc60c2e~2eNlsdwhr1356213562eucas1p1z;
	Fri, 23 Feb 2024 10:59:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.7B.09552.F9A78D56; Fri, 23
	Feb 2024 10:59:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240223105943eucas1p1953a636307bae3ac85bace5352dbd96a~2eNlZbagG1496714967eucas1p17;
	Fri, 23 Feb 2024 10:59:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240223105943eusmtrp16d0c40eb30fa8b54a1bb04f6db77ca0b~2eNlY6ZR12523725237eusmtrp1V;
	Fri, 23 Feb 2024 10:59:43 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-b1-65d87a9ffff2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.CB.09146.F9A78D56; Fri, 23
	Feb 2024 10:59:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240223105943eusmtip1c553ff34b0f7c9104d0dfd1f83aee09b~2eNlKYlVy3083230832eusmtip1X;
	Fri, 23 Feb 2024 10:59:43 +0000 (GMT)
Received: from localhost (106.210.248.222) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 23 Feb 2024 10:59:42 +0000
Date: Fri, 23 Feb 2024 11:59:40 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] scripts: check-sysctl-docs: adapt to new API
Message-ID: <20240223105940.ivcirunqxwm6ryno@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="5oi4fpnfz37t7ubv"
Content-Disposition: inline
In-Reply-To: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe2xLYRiHfT1np6elclZm71rXbjWs6lZJMUslk1RctriEWILGPtvYOmm3
	mbsJG9swl1l02EpsXSfF2IygUcmKZnUdtWEhI9Rcum6iSKN1KiT+e87v9z7nvG9yaEJoCRPR
	GdocrNNqMiUUn2xq8TnHV21y4YnmIrny0dXjlPLHt7ccpavsDVIR6gbzXkrtbRiuPlDSwk0m
	lvPjU3FmRh7WTUhYxU+/2/udWt8clV///CDagV5FFCMeDYwCKiu9YcWITwsZEwK39R03WAiZ
	XgTVlkS28CIo/NSH/hjlbW2ILWoROIwmgjUCU6/ck9miEcHXxtO/DZKRwqFOBxVkipHBve7n
	v4XBTDzUffUGPkfTBKOG62VLgvGgAPo62jlBFjAqKPCx4wImHO4c6yKDTDD5YLznC2NVMdT6
	6WDMY2bDzfY2gt0zGs41OUO8Fe5eCr6SH+B3NOztMXPYIhHOXSzgsjwI3PZLIR4KjsOlJCsc
	RmD1f+GyD/UIagr6QvYM2PW4K2TMgmu3CojgRsAMBNfHcHbRgXCoqSIUC2BPoZCdHg31L7vJ
	MhRt+Oc0wz+nGf6exsZycJUfof6L46DG+IFgeSZYLJ/JasQ1o0icq89Kw/opWrxBrtdk6XO1
	afLV2VkNKPAbOfz2vmZkcnvkNsShkQ3FBOTX5+vvIxGpzdZiyWDBw3UuLBSkajZuwrrslbrc
	TKy3ITFNSiIF0tQRWMikaXLwOozXY92flkPzRDs4WBG1sKi8c/rUEUkRLuop9kWOMQ5XeVPV
	8t6SIYmVqpMZT+tWv9h2OapCtnxXxIO1rqOGOdW1NusNkTSWNI2dmtJ/+5T0QmV3+6hFvP2W
	Ei/3yub9vcmGE6WbPzryeJ6chLxwt/CUWBNhLt0gXTPpTeOT5sr+kPDsx4CWR4tlHZpYvXue
	bGmF+DY/boHCY99paDWtcJ5N+XDeKXmv8IzvUdjvy6nJDlmM9uRn0TJb99wUv7q62NpaNcPS
	r+bZRGWV3bSFdD6wtXbdmJYUfSH26uJ9POuTtDMNrhh//Mgizkyf8JbkoPR9x0Vx7EpRXWdP
	XP78n1tOw9zOYbvHGT0qCalP10waR+j0ml+FxcL3wQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rzq26kGuzql7C4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQyenZfYCvYJlmxec9dxgbG+6JdjJwcEgImElOvXmXsYuTi
	EBJYyijxcMkDRoiEjMTGL1dZIWxhiT/Xutggij4ySrxZ+owVwtkK1PH1FFgHi4CqxKT7p9lA
	bDYBHYnzb+4wg9giAjYSK799Zu9i5OBgFvCQ2DshFCQsDGT+vH2LCcTmFXCQaPwJUg4ycwaj
	xOpfq9kgEoISJ2c+YQGxmQXKJK52L2KFmCMtsfwfB0iYU8BV4uCtq8wQhypLrN92Dsqulfj8
	9xnjBEbhWUgmzUIyaRbCJIiwjsTOrXfYMIS1JZYtfM0MYdtKrFv3nmUBI/sqRpHU0uLc9Nxi
	Q73ixNzi0rx0veT83E2MwKjcduzn5h2M81591DvEyMTBeIhRBajz0YbVFxilWPLy81KVRHgv
	Zd9IFeJNSaysSi3Kjy8qzUktPsRoCgzEicxSosn5wHSRVxJvaGZgamhiZmlgamlmrCTO61nQ
	kSgkkJ5YkpqdmlqQWgTTx8TBKdXAlGVvm8flv/ttWMKT/Y+di00mb3t9OvmzguOW0gPCM3Nu
	dX4yXeDI2fCbreCUav/mxzNn/p8Q3tzZFbenk+l2whWWLxt2v/vE5ff2o1H3Wr42VuGdtgXz
	hcu2cxVvs1qgV3M6VWQbP1NpX8oEay+jbbkaLbnMYdu71MxeuUj5zXN3Vjtx6MKTjIp6HXGr
	7e5iWyZ+kutwfMOxv0248d+kOXvfLQ9QT1JrefH7x9XL58r+eTFerQucoNpuFZDif2L19UVh
	ziEO3PdcxHTn1ydaK83afyl9P8daU569P67v+/Pw4orJ09jCTr+sKN+dkCnY8pyn8Nlb1cTk
	X2sPP1ZlDV7/+/fNlPnRqWKHMhecVWIpzkg01GIuKk4EAEjWdkxfAwAA
X-CMS-MailID: 20240223105943eucas1p1953a636307bae3ac85bace5352dbd96a
X-Msg-Generator: CA
X-RootMTR: 20240219201941eucas1p13b89861348f250d5e9b6b3b7441a56ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240219201941eucas1p13b89861348f250d5e9b6b3b7441a56ed
References: <CGME20240219201941eucas1p13b89861348f250d5e9b6b3b7441a56ed@eucas1p1.samsung.com>
	<20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>

--5oi4fpnfz37t7ubv
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
This is fantastic because we went from a totally broken script to one
that has only some false negatives.

I used the following script to test:
for admin_guide in sunrpc kernel index user net abi vm fs ; do
  ./scripts/check-sysctl-docs -vtable=3D"${admin_guide}" Documentation/admi=
n-guide/sysctl/${admin_guide}.rst $(git grep -l sysctl)
done

Before the patch it gives me 205 "No implementations" out of 205
And after the patch it gave me 42 "No implementations" out of 285

There is still some work to be done, especially for the "fs" part
of this script where there remains some strangeness on how we parse the
rst file.

As this patch has not functional changes, I'll merge it in to
sysctl-next

Thx

Reviewed-by: Joel Granados <j.granados@samsung.com>
--=20

Joel Granados

--5oi4fpnfz37t7ubv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXYepsACgkQupfNUreW
QU9jDgv+Ni9k5Mq/XHSlq1ekVVesL3Wb4fAdDZfedRc7pwFQVKzGtidwzIw9r3iP
Hl1+0HVE1n7uAFR1qeOOsiGgbbl0ogMCFL6LPuomGu+zDPeG/+6SUfVvcfdwiCab
EFVK8NvFOnCfFKJx3eKkM1cTZtfgBnTqILeEPN5dmat/sjxhuceEPOAW3ytwh0T5
D+TjG2bTLD6AXO+2D2PAfFSfq7kmYWRVM7ag0Z30ruwxa9v4/EOo0vqkW8CE8uDs
kL9Lh3GeM+l8UlRZ5cvnnDjp+ANGdqml0Vy77ucXyKQ6q1/bdU0zkNLkKKuEBNxk
C+W+w3lS52d5c2P/LUqPUTpMP9ihDZ71xwRGIW4TTZQFH09JL2/sJaep+wlcCAre
KXUpA1DyeC8GHjQm1ThWutAzJXl40qICpQpMR58wd468uZ8vQjIaX3aKBnhLd0nh
bujJRlZaBconwVOZ75OSYT58l9E7tHEgU/RglEGstfuBL0bRV/23Rxg2hZ5OgcbK
42LcXrYr
=zO+w
-----END PGP SIGNATURE-----

--5oi4fpnfz37t7ubv--

