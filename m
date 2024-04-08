Return-Path: <linux-kernel+bounces-135319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2D89BEF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1D82859E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8676BB22;
	Mon,  8 Apr 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjBPIqoq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622A64A9F;
	Mon,  8 Apr 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579318; cv=none; b=rHLC5IabbvDw2hQy/fRtp3iKv4NMJ6KVHev4yV/mUZ9mAfECY2pNY0ZVopw8X8770XnD3Rcu5C08t9qP+S6/TYx+dC0qC8jeo4ltd6GFuTllLLmle37n6wipIf8qWuGQS8rStIs26Q3I4Q8teeZbjmBuygbKSYCg1acv0wIQ+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579318; c=relaxed/simple;
	bh=hll3DacUxkX1DG2Z4CS8KDhqm+gORNkbU2vd95sIbds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGPDauRaNt2HWQXRC+tmNqpYVfnxFpeCQsZuUraR+P4MCOTGeSbL4Jex3eezoEA1O2oaUp4yosvIHjpMMN8lS0FmSuRpa86dj2ZNqWGtxFMOgNmyDium/s65lFkGlvUapGeySxLsdlHGR8gjSPxcHwL7/NuK+a7q6thQLh+NABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjBPIqoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DD0C433C7;
	Mon,  8 Apr 2024 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712579318;
	bh=hll3DacUxkX1DG2Z4CS8KDhqm+gORNkbU2vd95sIbds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjBPIqoqy4Jryx4KPSeMe1vNPYhMuUTMLOfA8GX1dYUBqdCh0h+PdGXfRpXtlKgG3
	 roJcAofrtp/jG1lwtGsd8U6Cg4Gj5y7P27tKibdzqCII75Xsd0nDmfuFclj3bNhlM+
	 hzNsJYinkfVqz/RVoL+K67CDPVu4K2beh9MceRluXYRSZkuFdw9ImcdFDs3+ad/0uQ
	 fRlP1Bhiz1QZBFVmps8qRyfmCoZUo2vPKxeX5BX1w+nhB6PW0mFE4uxKXgRP7Td081
	 mSDldBHF1k8W5889XPv/c/1c8dZ0cL649jAnAuep43BWWFWgOQka08GBEiehSmXwUh
	 boQMX2ydrYr0A==
Date: Mon, 8 Apr 2024 13:28:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	linux-sound@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <ccfe882c-652d-45d2-a9e3-d320ebe01834@sirena.org.uk>
References: <20240408141216.3eb1128c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8M0lz2wDOChcIaG7"
Content-Disposition: inline
In-Reply-To: <20240408141216.3eb1128c@canb.auug.org.au>
X-Cookie: Drive defensively.  Buy a tank.


--8M0lz2wDOChcIaG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 02:12:16PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:

Copying in Amadeusz and Cezary, this is from the recent AVS changes.

>=20
> In file included from include/linux/bits.h:22,
>                  from include/linux/gfp_types.h:5,
>                  from include/linux/gfp.h:5,
>                  from include/linux/slab.h:16,
>                  from sound/soc/intel/avs/icl.c:9:
> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(=
struct avs_icl_memwnd2) =3D=3D 65536"
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                         ^~~~~~~~~~~~~~
> include/linux/build_bug.h:77:34: note: in expansion of macro '__static_as=
sert'
>    77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARG=
S__, #expr)
>       |                                  ^~~~~~~~~~~~~~~
> sound/soc/intel/avs/icl.c:73:1: note: in expansion of macro 'static_asser=
t'
>    73 | static_assert(sizeof(struct avs_icl_memwnd2) =3D=3D 65536);
>       | ^~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   c2b10acb62c1 ("ASoC: Intel: avs: Add assert_static to guarantee ABI siz=
es")
>=20
> PAGE_SIZE is 64K for this build.
>=20
> I have applied this patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 8 Apr 2024 13:50:53 +1000
> Subject: [PATCH] ASoC: Intel: avs: stop building when PAGE_SIZE =3D=3D 64K
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 4b9e498e3303..abe5cba82d50 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -211,7 +211,7 @@ config SND_SOC_INTEL_KEEMBAY
> =20
>  config SND_SOC_INTEL_AVS
>  	tristate "Intel AVS driver"
> -	depends on X86 || COMPILE_TEST
> +	depends on X86
>  	depends on PCI
>  	depends on COMMON_CLK
>  	select SND_SOC_ACPI if ACPI
> --=20
> 2.43.0
>=20
> --=20
> Cheers,
> Stephen Rothwell



--8M0lz2wDOChcIaG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT4vEACgkQJNaLcl1U
h9Ayvgf/YAICd/vVUBHM+ODLX0Ene/RRxDnpjoWl4N3GLQpdZy9xAE0OTn8doxRe
vUGOPjUnd8cLtOoztpk/6AyfJvfKo45WrsqFPu7yhw+XE/lvBtg7jdNVU5RttxeR
znv+nK9ti6vv/jre6ziRDzIGk9eBP+jnitumWX8mVxDDNcwwMJ7T7GxXI8qN8KQu
NOxyiyf2CxEGnO3ErDEAX+HcYIu7+ub01Mwvmitqj+8o9q7ErG+g29L29GhdhT2l
vjJIcTnbVbprdBjV0ZlIxyhTfh9sBQ5lQ8jlSgD9KIYXORgDoOLlEwNgYkR8xhT7
CAZuu3EfyMS+tiJbag+915R+3OaOeQ==
=plHR
-----END PGP SIGNATURE-----

--8M0lz2wDOChcIaG7--

