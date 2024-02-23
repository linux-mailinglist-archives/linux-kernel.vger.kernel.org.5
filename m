Return-Path: <linux-kernel+bounces-78243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0886109F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739D6B26C70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BA7B3FD;
	Fri, 23 Feb 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJc0hWRq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80867C72;
	Fri, 23 Feb 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688355; cv=none; b=mfZEOerEfiOw7av7s/3ptxDPecAmJA/mBXDbznGXOYaIv1gX9vfQ729gaAUlIS++HPhIlhSwXok4HP0G2r5LGHd65xZeYu2hpLP3Tcim8f3D7AH8VFCKjuI1v892XtHq5cg7NvXNQc4IfrM6J+YjdyITsOZM9lR9/B4+btlmSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688355; c=relaxed/simple;
	bh=W1EZlzIrLFHKafLcbOnnHszzlaYoezY3kK+xhHhq64I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJemMv3f6/kcCtFSf8O+k7uTSF8FATeZPHGTjxs42Zaq/sLUPE9KF8qvE6P9/tjUvMUN2XSYkXrvg24YR2GWb4f1e5Xvfa4JAXTXvL66BGeUzxrD2DPb48VsLoeucFZWulWkaZMz+sC03/MdQ8nfMKHLYugShhp88NRwj8Wcqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJc0hWRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135CFC433C7;
	Fri, 23 Feb 2024 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708688355;
	bh=W1EZlzIrLFHKafLcbOnnHszzlaYoezY3kK+xhHhq64I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJc0hWRqnYwibP/uyaZ7etm2qnhJct/f568CwQewP0Nj4B3GHIPmPAD+4pO8ae23s
	 1DvwoKw4TXi8tFLE9+NJvZXl0wNAdrDS1toPC8Nx/WHrvpYoyeLGymEgI5bjsPtejU
	 akXSGAsIFIMzt1JSfxqdj++8Op8hOOEreZNQeRYxJviBE1FzdjUHkm4CA6F/oOyQCg
	 IxDMM/uRLag2XNyXjU93buJEz7tE1R61sn4Q9OZ9Fupq/as8gzOpVfAiFyzpucXv24
	 1PBH/biuAHCUrH8ytb4A894hIuXa0pRbh+SnLcwvRVY/BriA9ZriGGJJnaSEH74ikt
	 Bgkb1Gs07qxQQ==
Date: Fri, 23 Feb 2024 11:39:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
Message-ID: <20240223-amino-barbell-59214fa9aa95@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
 <20240221-islamic-quartered-3863e44bc862@spud>
 <tencent_DF3D7C2E8248DA188E3FB8DF31FE21478D08@qq.com>
 <20240222-crawlers-prankish-ecf425d1f0b5@spud>
 <tencent_AF1B1DF96C041FB57D1C4770356254431E09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YWxBLTxQFvyXO2f2"
Content-Disposition: inline
In-Reply-To: <tencent_AF1B1DF96C041FB57D1C4770356254431E09@qq.com>


--YWxBLTxQFvyXO2f2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:42:01PM +0800, Yangyu Chen wrote:
> To sum up, I agree with the reasons to refuse it for debugging purposes. I
> am wondering what to do next. After reviewing the code carefully, I found
> this feature not only for K210 but also for other SoCs. But for other SoC=
s,
> it is broken as it will link multiple dtbs to the kernel, but the kernel
> will always pick up the first dtb to use as discussed on this thread [2].
> That is because SOC_BUILTIN_DTB_DECLARE is removed from this patch [3] th=
en
> no code to select for multiple dtbs now. And makefiles on other soc which=
 is
> on the mainline kernel currently will build every dtb object file from th=
is
> patch [4]. So this feature for other SoCs is broken now.
>=20
> Choices might be one of the following:
>=20
> 1. Remove BUILTIN_DTB feature if K210 support get removed
> 2. Continue to add this feature to get this work for other socs
>=20
> I prefer to continue to get this feature to work. Not only for my debuggi=
ng
> purposes but also for fixes.

My email might have been a bit unclear because I responded to things out
of order. My final thoughts were that we should apply a v2 (or 3 etc) of
this patch if for no other reason than fixing BUILTIN_DTB. I could not
really justify refusing your changes when a patch fixing BUILTIN_DTB for
the non-k210 platforms that support it would look almost identical to
this patch. Apologies if you misunderstood.

I left some comments on the patch itself with a v2 in mind.

Thanks,
Conor.

--YWxBLTxQFvyXO2f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdiD3gAKCRB4tDGHoIJi
0ix7AP4yMMgNUyiA1o4UrMBOtHcThn4TBnzGlxw++LdHRXz5dQD/X0dO6ukK7Mq+
8u/+x6VnQEcRzl+/0IyWAT/pD/FS8ws=
=7EAC
-----END PGP SIGNATURE-----

--YWxBLTxQFvyXO2f2--

