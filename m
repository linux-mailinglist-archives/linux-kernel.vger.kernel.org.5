Return-Path: <linux-kernel+bounces-123651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52371890C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E301C261B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B021272AC;
	Thu, 28 Mar 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AaAcK9tX"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1AE128369
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660104; cv=none; b=F+VClqjIQxsD0AxhCfiMNqDFS94x9tKJF2pI39qXnQttbZMngog0BpW8f+DvuYfAym2jL2JAWBwWFIwSwDU4PYvFbtQKlusBrvVXn4L5IfPSNbjEgjPD7XwhxI2w8xnEmVVWX2TgpHF2hD8vo/8j20SXvRbcXmvKFsm8XA33+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660104; c=relaxed/simple;
	bh=oZd9JBcpx9IwUglGDbMHXiBDr8ix8ejHChr90afzZfc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=NVGD9qhb8Iu97OVH5gMDZjiiLARlw7xJ/I2cAa5X289y3NUXAKbPu9DZtqTZpo8P0lObNeI8D+GzP5WRzKx21sEsbAuOIxX9tvENfuiikXxaO8eTwDvTWRLDr1UgWV2hPap32c1O2ikiQQt9yGj8eMzHOMVKfso/xer3Zz2LhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AaAcK9tX; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240328210814euoutp017da8358fd3170697a30ca320a9ddd89e~BCcmADaps2533125331euoutp011;
	Thu, 28 Mar 2024 21:08:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240328210814euoutp017da8358fd3170697a30ca320a9ddd89e~BCcmADaps2533125331euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711660094;
	bh=vvXs0bfSGGGOUgmuTrXt9N8TxC7TmITkgFAEWXNypZE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AaAcK9tXaAProSi4hdMKeu3o8uteqEb40OG7iDz0tcjtZgedfepsy/sGl2MfczG+W
	 OgSJ/P8ugCOllznKq9qGu8WIn5zwAKL0ZV9QKexVXxQImQAfvy7qctixO0oMuyeqoU
	 pKgAt+PuomDGWwWYzGEVE+qIQSZqFL9YNzhExasA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240328210814eucas1p1066d2dcb7fc6cfc6687302968f4caeae~BCcl50xsp1058410584eucas1p1a;
	Thu, 28 Mar 2024 21:08:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.5C.09814.E3CD5066; Thu, 28
	Mar 2024 21:08:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240328210813eucas1p2265c4b7416260c57320742d7c870f342~BCclVAFg32538025380eucas1p2i;
	Thu, 28 Mar 2024 21:08:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240328210813eusmtrp2110ba9284f747d9b3336a2f31b311384~BCclUkBkK0861508615eusmtrp2I;
	Thu, 28 Mar 2024 21:08:13 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-0b-6605dc3eee26
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.E9.10702.D3CD5066; Thu, 28
	Mar 2024 21:08:13 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240328210813eusmtip21f52b226371cd93ea4f1320f268c8b73~BCclFYcBc0676906769eusmtip2F;
	Thu, 28 Mar 2024 21:08:13 +0000 (GMT)
Received: from localhost (106.210.248.208) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 28 Mar 2024 21:08:12 +0000
Date: Thu, 28 Mar 2024 22:07:55 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Eric Dumazet <edumazet@google.com>, Luis Chamberlain
	<mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: treewide: constify
 ctl_table_header::ctl_table_arg
Message-ID: <20240328210755.awnuhfwws3323j3d@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="np2kr66pm2g23oxb"
Content-Disposition: inline
In-Reply-To: <20240322-sysctl-const-table-arg-v1-1-88436d34961b@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87p2d1jTDP4e4bZ4euwRu8XlXXPY
	LH7/eMZkcWPCU0YHFo8Fm0o9Nq3qZPP4vEnOo7/7GHsASxSXTUpqTmZZapG+XQJXxvT/O9gL
	fkpXXJnfwtrAeEuki5GDQ0LARKJhlk0XIxeHkMAKRom2vUvYIJwvjBLLvq5ih3A+M0q871jO
	1MXICdax8M8VqKrljBJ7D3WxgiTAqg58CYNIbGWU6G2ezA6SYBFQlZixZRpYN5uAjsT5N3eY
	QWwRARuJld8+s4PcwSyQJ/Hyvi9IWFggUOLU7dOMIDavgIPE2r0LmSBsQYmTM5+wgNjMAhUS
	fQcXMUG0Skss/8cBEuYU8JfoPLwJ6k5libsdp9kg7FqJU1tuMYGcJiHwhUNi+qI5UEUuEu9f
	L4MqEpZ4dXwLO4QtI/F/53yohsmMEvv/fWCHcFYDw6XxK1S3tUTLlSdQHY4Sv1ZuZIEEKp/E
	jbeCEIfySUzaNp0ZIswr0dEmBFGtJrH63huWCYzKs5C8NgvJa7MQXoMI60ncmDqFDUNYW2LZ
	wtfMELatxLp171kWMLKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExPp/8d/7KDcfmr
	j3qHGJk4GA8xqgA1P9qw+gKjFEtefl6qkgjvzqMsaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MPJule/NP/L21td3h+ru5BUbVDxOWaVjvUJSbuqs1
	YmaGSZDEZoWE1p+r3mg1NRf+Olr2+xbr2Q17nKMMozWe7I74oXV5TlLslD3/lnY9XGwwde6c
	4mDPj0cnuinVrjrYK3NE7Y9EkGvH6tNbMw9wb/S5k3Lf3irhhlD/mcqoaWqL/J/9V2c4pHfp
	2i6Vr1u4jv6bfio84ew93erV7pebm51WHrVy4HQKcpjySmmV6r3rt5vmOmR9mWW78GKxXU4k
	b+kkreyw21q3v0vYXJ/JeXn2GdOcnXLvC641LY1dwfCpwCt213xVvr1eq5qlvGYxb31d8U+b
	fbVx65/uXTrequKVs1yWtdrYvFb4c2naDSWW4oxEQy3mouJEABXJkJnKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7q2d1jTDB58VrB4euwRu8XlXXPY
	LH7/eMZkcWPCU0YHFo8Fm0o9Nq3qZPP4vEnOo7/7GHsAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrKHyxkLvktX7Fl9jrGB8YZIFyMnh4SA
	icTCP1fYuhi5OIQEljJKLP64nwkiISOx8ctVVghbWOLPtS6ooo+MEv9XXmaEcLYySvy+O5MR
	pIpFQFVixpZpYN1sAjoS59/cYQaxRQRsJFZ++8wOYjML5ElM6VgAVi8sEChx6vZpMJtXwEFi
	7d6FYL1CAosYJZof20PEBSVOznzC0sXIAdRbJtHYogVhSkss/8cBUsEp4C/ReXgT1M3KEnc7
	TrNB2LUSn/8+Y5zAKDwLyaBZCINmIQyaBXaajsTOrXfYMIS1JZYtfM0MYdtKrFv3nmUBI/sq
	RpHU0uLc9NxiI73ixNzi0rx0veT83E2MwBjdduznlh2MK1991DvEyMTBeIhRBajz0YbVFxil
	WPLy81KVRHh3HmVJE+JNSaysSi3Kjy8qzUktPsRoCgzCicxSosn5wOSRVxJvaGZgamhiZmlg
	amlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXANGVXe+v52eHHZ00LnfzyO2tI3pPMBu20
	C9x3/ppwMgqnLJkpfnP+R57adAa5EPmja15FLoqI2K1g7pd3Z90kgRKvxFvTWNft3ej7fNeG
	uUYbkzpEtR8Yr2FTdmoq4DrxkX1hVFbOu3di3rHrWZpENh7JmXFM22yG+MmL7z7vLBbawmvF
	t/rkrju2K79/u+vHNjkl7fX2bxO7o7tUzqvkxBmnlq5z3Jl3Pzfh1bcOC7aWN79WCrOGL35Q
	cIT53OTu//o/3YqzDxoIuDrauEQqblxdWSH932Vz0G1J1/w/IWsE/OawGM646/gvp0KncJ3D
	Rj01maebrH+2f5K/xrjiBIPcfM4ffgbz2b9ZdGu3KbEUZyQaajEXFScCAG0KhOBmAwAA
X-CMS-MailID: 20240328210813eucas1p2265c4b7416260c57320742d7c870f342
X-Msg-Generator: CA
X-RootMTR: 20240322203446eucas1p27f8eecc9a9f4686394aa1ff2e525dd03
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240322203446eucas1p27f8eecc9a9f4686394aa1ff2e525dd03
References: <CGME20240322203446eucas1p27f8eecc9a9f4686394aa1ff2e525dd03@eucas1p2.samsung.com>
	<20240322-sysctl-const-table-arg-v1-1-88436d34961b@weissschuh.net>

--np2kr66pm2g23oxb
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 09:34:36PM +0100, Thomas Wei=DFschuh wrote:
> To be able to constify instances of struct ctl_tables it is necessary to
> remove ways through which non-const versions are exposed from the
> sysctl core.
> One of these is the ctl_table_arg member of struct ctl_table_header.
>=20
> Constify this reference as a prerequisite for the full constification of
> struct ctl_table instances.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> This patch is only sent to LKML and the sysctl maintainers to avoid
> spamming lots of maintainers for trivial changes.
>=20
> It is based upon the branch sysctl/constfy.
>=20
> It was implemented by manually searching for "ctl_table_arg"
> throughout the tree and inspecing each found site.
>=20
> If somebody comes up with a cocciscript for this, I'll be happy to use
> that.
> ---
>  drivers/net/vrf.c                       | 2 +-
>  include/linux/sysctl.h                  | 2 +-
>  ipc/ipc_sysctl.c                        | 2 +-
>  ipc/mq_sysctl.c                         | 2 +-
>  kernel/ucount.c                         | 2 +-
>  net/ax25/sysctl_net_ax25.c              | 2 +-
>  net/bridge/br_netfilter_hooks.c         | 2 +-
>  net/core/sysctl_net_core.c              | 2 +-
>  net/ieee802154/6lowpan/reassembly.c     | 2 +-
>  net/ipv4/devinet.c                      | 2 +-
>  net/ipv4/ip_fragment.c                  | 2 +-
>  net/ipv4/route.c                        | 2 +-
>  net/ipv4/sysctl_net_ipv4.c              | 2 +-
>  net/ipv4/xfrm4_policy.c                 | 2 +-
>  net/ipv6/addrconf.c                     | 2 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
>  net/ipv6/reassembly.c                   | 2 +-
>  net/ipv6/sysctl_net_ipv6.c              | 6 +++---
>  net/ipv6/xfrm6_policy.c                 | 2 +-
>  net/mpls/af_mpls.c                      | 4 ++--
>  net/mptcp/ctrl.c                        | 2 +-
>  net/netfilter/nf_conntrack_standalone.c | 2 +-
>  net/netfilter/nf_log.c                  | 2 +-
>  net/sctp/sysctl.c                       | 2 +-
>  net/smc/smc_sysctl.c                    | 2 +-
>  net/unix/sysctl_net_unix.c              | 2 +-
>  net/xfrm/xfrm_sysctl.c                  | 2 +-
>  27 files changed, 30 insertions(+), 30 deletions(-)

I was expecting a lot more ppl cced for such an extensive patch; I only
see Eric Dumazet <edumazet@google.com>, Luis Chamberlain <mcgrof@kernel.org=
>,
and myself in the "To:" list. I'm missing the network maintainers. How
are you calculating the CC? Are you using get_maintainer.pl?

Best

--=20

Joel Granados

--np2kr66pm2g23oxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYF3CsACgkQupfNUreW
QU+eYAwAhRzxTFP5Wm3qobBtjk7UiR8hMUce0eDVXA1XztUCVcnXYClaG5Mohmhb
duIlXItHpNkH5oA43vRC8TULuMz5SD9T4zopVjrQMomap/oxZzTWOOxZ0XbNNJzT
S8IgbbmevvoxJSohtLK3HiF+ImdDOQIzOZ2Ksbx0i/JIKa1oLlKAAKpeqke8MLg0
2Pg8IZOdn4nBerrVvqGuMEfN+PVoU3BmczTd1LXB0kneYZzF+VMkWZsJi6cAhfJh
2vUXPcv6PFuInn7nOwX2mNrq0o9uG7VN5INaPCTXVLkxigZ0f1hGBLeby0duAtxH
NifxkaZ84pxobyJyrrboixpjQMw2pUVOWvGUkSMHmlpRk9j1Zv09HzhwUhwp1jmA
jtbLeN0sZO8WR66LxSNkZFsCuptzK8+kIs7u40j65Su1PAS8BCGQt9ZRgPidDknx
h6jxaBeGLEgGy7czCkBhmRTCDpDORBLWLomrHMJi7jYpx6ojrznQvsgQPJs9gzan
eXm/e6SC
=LHak
-----END PGP SIGNATURE-----

--np2kr66pm2g23oxb--

