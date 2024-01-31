Return-Path: <linux-kernel+bounces-46613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A4A8441FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F17F28EC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937B83CBC;
	Wed, 31 Jan 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj4FB7cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6D8288D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711954; cv=none; b=pevmlxmkCr7Za18tD8NpOVTYDJNejn6LsEi5hHaMMAt06L9s69YGxOgUwkvnUa9B3JObdPbD7Ze8/VGpHlyd1S8JfGHckW72cxF28ETkFdj/iw+UoAFDN8tv5cjPAwacAOrXwKwt08pTPLYmBsMFxHZVW7b1zvz+v35/QdCd64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711954; c=relaxed/simple;
	bh=kPVuRNBlbzCQ8svyAWwrt4hdHVJyuCK8Z2Wnf0wDU8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgICSkthN+eqD7KC+iscusZzCWkDtc4v3Mwzca5oWBn5eo9ofY7j7qIGYBOBHnFjMf4bSXvPD9noDXaoFQk/lqGtHLUkNLb4MaxqUT1UY3b1DJVcdgDusZ9aMgm1mzK8QJ/hhLw3cHpx11mH7YufPAcAgoxhfKlXu23Iq4K60Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj4FB7cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55899C433B2;
	Wed, 31 Jan 2024 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706711954;
	bh=kPVuRNBlbzCQ8svyAWwrt4hdHVJyuCK8Z2Wnf0wDU8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rj4FB7cg6MVpGG4kOsX6275iESuieAs7+JGNjuERRZAWT2Q6HiQna0FS2YsD7/cz6
	 3lqYCRdJLm31w7eMhpb0VHlsz7rmoT4fuQbjQoSzLzj2j+aywq//j3ZxdzacMjZBMB
	 F2t6pzAsNtC9JODfDTVMoyg8XM4Vy3tcDahULpWKbmEZZGPGJuGADyeyvkC1IzuY2I
	 Zoq950v5yYLAu7x4gZwKVEbsbTBxaXV6ckvAoOqjWhegAOEKttwImu0iIonlTw0Ryr
	 jDxithQzDIRpRu8xED5pgIAp//jM6M+SE9kJOjcJhB+ng9fqc3YF8On/oriujnBkeS
	 KZFtD1y49Cvow==
Date: Wed, 31 Jan 2024 14:39:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] MAINTAINERS: Setup proper info for SOPHGO vendor
 support
Message-ID: <20240131-uneven-grinch-79e678a2e995@spud>
References: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4CLUouC3q9dmuLiV"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>


--4CLUouC3q9dmuLiV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 09:40:42AM +0800, Inochi Amaoto wrote:
> Add git tree that maintaines sophgo vendor code.
> Also replace Chao Wei with myself, since he does not have enough time.
> Since sophgo vendor code is maintained, remove itself from
> `RISC-V MISC SOC`
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Acked-by: Chao Wei <chao.wei@sophgo.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

I assume you guys will take this in your tree.

Cheers,
Conor.

> ---
>  MAINTAINERS | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39219b144c23..125debc7d755 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18848,6 +18848,7 @@ F:	Documentation/devicetree/bindings/riscv/
>  F:	arch/riscv/boot/dts/
>  X:	arch/riscv/boot/dts/allwinner/
>  X:	arch/riscv/boot/dts/renesas/
> +X:	arch/riscv/boot/dts/sophgo/
>=20
>  RISC-V PMU DRIVERS
>  M:	Atish Patra <atishp@atishpatra.org>
> @@ -20446,12 +20447,13 @@ F:	drivers/char/sonypi.c
>  F:	drivers/platform/x86/sony-laptop.c
>  F:	include/linux/sony-laptop.h
>=20
> -SOPHGO DEVICETREES
> -M:	Chao Wei <chao.wei@sophgo.com>
> +SOPHGO DEVICETREES and DRIVERS
>  M:	Chen Wang <unicorn_wang@outlook.com>
> +M:	Inochi Amaoto <inochiama@outlook.com>
> +T:	git https://github.com/sophgo/linux.git
>  S:	Maintained
> -F:	arch/riscv/boot/dts/sophgo/
> -F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
> +N:	sophgo
> +K:	sophgo
>=20
>  SOUND
>  M:	Jaroslav Kysela <perex@perex.cz>
> --
> 2.43.0
>=20

--4CLUouC3q9dmuLiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpbjQAKCRB4tDGHoIJi
0jpXAP9uGodd2YeCPx+ouxY8zU/sUXURwKAb9IO8UXPFQDq6SAEAvJFHhGrZ8qai
KQA26Es1UGjNKAgoszwpNmGQqXt4jwY=
=eYUb
-----END PGP SIGNATURE-----

--4CLUouC3q9dmuLiV--

