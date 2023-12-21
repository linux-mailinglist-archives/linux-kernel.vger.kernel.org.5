Return-Path: <linux-kernel+bounces-9101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570181C075
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608D51C21C31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AC7764C;
	Thu, 21 Dec 2023 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dQurDrPJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6776DA1;
	Thu, 21 Dec 2023 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703195348;
	bh=b9Yp2PAnVISSm0WHMH3Z5e0RPRkc/4VmLXSJfgUlSmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQurDrPJevVU7/RJQvy3AJex2v7fD817ZarcEHnbGjMnjYSYGy6ndkhYf7wlexo5B
	 tyfy6B9v8lWXEbsBRx4mIn0TdUHIAi3xEUgLLIh3lbFF2NKJbBApRmQPvpGbjysW2S
	 sUPje6gDINbtEh/YmDm9wsdNRGwT2yhpD8doGmHZx2ajYuiSHSflX45gUULdquX9M9
	 L9qQnF5SluIKQSaJ91gYR96YO3S+8ocrP68yk3fm+r2E36T+TfCiLJO/cAwCnLoEdz
	 fknfqBpfNv4N1LTVKwWOmSEdFuZFkBlFeV21LAw/L7HOaey+QZDctry6aFUT+l1YLW
	 eUPky6bz7zitw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx3wh2djhz4xNG;
	Fri, 22 Dec 2023 08:49:08 +1100 (AEDT)
Date: Fri, 22 Dec 2023 08:49:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Peter Rosin <peda@axentia.se>
Cc: Vinod Koul <vkoul@kernel.org>, Jan Kuliga <jankul@alatek.krakow.pl>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mux tree
Message-ID: <20231222084907.6e27d919@canb.auug.org.au>
In-Reply-To: <20231222084746.3d9dcb90@canb.auug.org.au>
References: <20231222084746.3d9dcb90@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vpXvG4_ydzIJ=ETNiJ8aezx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vpXvG4_ydzIJ=ETNiJ8aezx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 22 Dec 2023 08:47:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> In commit
>=20
>   2e142cebb164 ("dmaengine: xilinx: xdma: Rework xdma_terminate_all()")
>=20
> Fixes tag
>=20
>   Fixes: 49a701d8dc1e ("dmaengine: xilinx: xdma: Add terminate_all/synchr=
onize callbacks")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Maybe you meant
>=20
> Fixes: 5c392d106e7 ("dmaengine: xilinx: xdma: Add terminate_all/synchroni=
ze callbacks")
>=20
> Also, please keep all the commit message tags together at the end of
> the commit message.

Sorry, that is in the dmaengine tree, not the mux tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/vpXvG4_ydzIJ=ETNiJ8aezx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWEstMACgkQAVBC80lX
0GwMEggAiHN7ECpogxHQFer5C/2W19SVkv2rOlK9bFlAMMnUFdxPSmzDZFhGXQho
oSnZ5fpLKX80ZUm/1e5TRnSVIwRrqlC8N5+xAjdVwPAZqo9j2GYQ32Yq/AShi7Is
OUdQND+pinm6OG3HiV0qK8bWjqRF3iO5TLNX+Er4+9lSNQKsfyKNNzXn7wZUyKyp
+Ek8HbmjCWIJDVbSoNYKziR2gj8PLEST3fqzTSlbKTNM0GJKhRpyb86R44aaddya
PnmZ6iK/16afGiz/cni7yb6tIqKLSsTABTAwHutZMIvm8q84VktL6tdQ9+eMM0Fw
HinfcJxfyttXBMcldZ8z1NJmISDpQQ==
=ticy
-----END PGP SIGNATURE-----

--Sig_/vpXvG4_ydzIJ=ETNiJ8aezx--

