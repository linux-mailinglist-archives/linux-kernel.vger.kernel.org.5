Return-Path: <linux-kernel+bounces-80316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB7862D49
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF931C20859
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E91B968;
	Sun, 25 Feb 2024 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLZo7J00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2241B94E;
	Sun, 25 Feb 2024 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708897963; cv=none; b=gYhmb1Ifi7u9tpuMfIlRL42dfifLXUYE9EYbDt6aBDXL5hbICf8YYcVf1fJAK7HI39i40snc2M6bbTtRN0ACLeEbqnHMlM51K8Pi/EKIexGK0lcg2LF0/OOGbnTNxkR0ckOvK8M6rTndkSjgidEmbRQh1YN8lNslIaiROaAWmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708897963; c=relaxed/simple;
	bh=ximVVDVSkTdhIQPOy7oFobVeW12EKfl7i+5B7/RQeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaphVLFp2VIQsriQ3BJhNW3UFv9dl706Z4QpdVM4M7uR4N8jrtq6vYnHvjIfck9VkC0FEnzPYhQWS6FijBcaY6jiDEtfFIsGHpbnycM3edaHmMkh+L066A4ykTrvHMCtlW7TU7CSiKO3ieQJdDRs4ZFNBCjLR3q7cgE//dn0e04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLZo7J00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9233C433C7;
	Sun, 25 Feb 2024 21:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708897962;
	bh=ximVVDVSkTdhIQPOy7oFobVeW12EKfl7i+5B7/RQeR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLZo7J001ZR4ecvTvfGGCNNVlcw0ks3ElC2FK3G0FkJFwj2+UyhqtuS4eXjrsRHTB
	 lKKDWy/MnkXAkrrntimJTqxw5MYmaZ+QtcXaS3ZuesEqfIEPqtudcjkBvaYBL6lECL
	 LdIsXiOffhmG69PrcIa4U/3XtdCCAD5UdUtZbvT+TAYYjxYJi37ywMKKit4NduUtf8
	 wuYOo1M2GPcl4EdtYUtzVLc6d6DaRayAX87cqdnhO6UU1xRn8/X0ggy/4i8qny9Cl1
	 GhqnIFxVXigJ174baiyX9KE8kLGxGFpOQEt/WD6tzxh0cGXnrSyUChbaUGIuNUx2ib
	 ii2NpWPqcRLCg==
Date: Sun, 25 Feb 2024 21:52:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Conor Dooley <Conor.Dooley@microchip.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the riscv-soc-fixes tree
Message-ID: <20240225-retriever-stunning-b1bebf658c92@spud>
References: <20240226080721.48140d3f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pIfFv1KDzs+tGoum"
Content-Disposition: inline
In-Reply-To: <20240226080721.48140d3f@canb.auug.org.au>


--pIfFv1KDzs+tGoum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 08:07:21AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>=20
>   8bbccdd8c264 ("cache: ax45mp_cache: Align end size to cache boundary in=
 ax45mp_dma_cache_wback()")
>=20
> This is commit
>=20
>   9bd405c48b0a ("cache: ax45mp_cache: Align end size to cache boundary in=
 ax45mp_dma_cache_wback()")
>=20
> in Linus' tree.

Ah, I rebased out an accidental merge commit before sending a PR.
I'll go drop the duplicate, thanks.


--pIfFv1KDzs+tGoum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdu2lwAKCRB4tDGHoIJi
0lQsAPwMMkkGMObCH+k85N3y0+joNtEXxBd8rTDTqivfRXbc6wD/bNhGBaK2kl8H
tKAggsbLqxAEOpF8QqREGzY42RJP9QA=
=NGlb
-----END PGP SIGNATURE-----

--pIfFv1KDzs+tGoum--

