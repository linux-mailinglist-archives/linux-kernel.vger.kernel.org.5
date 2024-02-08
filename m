Return-Path: <linux-kernel+bounces-57982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583084DFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69C81F21B27
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E16DCFB;
	Thu,  8 Feb 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqQYPjSV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317A6BFD8;
	Thu,  8 Feb 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392625; cv=none; b=KqhzVgcj8cYnLeimr/T8GFZAscAV/Ww9Ldq73lki9nGT5OEoun5z8MX0zOcgseom7bJm4dQ1SBpN82juxnDcDbRq7KH8uWn3EN0rOUcemjJv3qQ/mo1lqguULmz8bLp2u6aQspMPytFBTWOqh0kwcrkfQQX8j2+e4UYpl+Q71Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392625; c=relaxed/simple;
	bh=sXaznuLQFte0Sc5MhURr7zZ+aE2lbpmdzE+up/klwvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzodEfewsc/MAxB2iyZvGk5bXhhFknizHP/GWIbJqjrRsb1FUhtb5OM26IP7is1+bCCEL7lomyC2H9g70STN8lIqMksLMqr132soUeQIQWO8TjQWrOa5JdkavYRKNECc+Y+D9nX4Xbb2UyQzYv4sO3d6aIw3OxzCuuqPv3IiTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqQYPjSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A575C433F1;
	Thu,  8 Feb 2024 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707392624;
	bh=sXaznuLQFte0Sc5MhURr7zZ+aE2lbpmdzE+up/klwvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqQYPjSV5E03JsSMbhKVx0moLti0yvirhf5lzNqTIc9Omia1rLyUdY9nOrHTQWLap
	 XhTjFP4L5c1BT+RWEM1UF9X56dgJUjD91EW6lST2OddA74Lef4EiREDQ6SP9a2vyKn
	 MLxftJhS7Bod+YPh09CQLaOYxLBTvsKFiGjG25PdZwMlzAlpKlQvZjTYCz+/YOAirg
	 Wk2YhJ6RHE1TEcu740MMNK/Lr9mRhr3LjxV9S/rvuxwxelflv2z7KjdMkuv+kpXKfI
	 VVWBdw4d6IjDqjOctIpcY7CDxxZVg9j0JCIjmyTmt55TR4sVLKZ/DlM5Yd8t2cFv3L
	 WQdG9a0O09d7A==
Date: Thu, 8 Feb 2024 11:43:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi tree
Message-ID: <ZcS+bSeeOo2UpbOA@finisterre.sirena.org.uk>
References: <20240208145200.7590dc62@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QWeM8vMH8sgUbsgC"
Content-Disposition: inline
In-Reply-To: <20240208145200.7590dc62@canb.auug.org.au>
X-Cookie: You might have mail.


--QWeM8vMH8sgUbsgC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 08, 2024 at 02:52:00PM +1100, Stephen Rothwell wrote:
> Introduced by commit

>   148b93a5062d ("ASoC: Intel: avs: Expose FW version with sysfs")

> You need to make the "<dev>" part unique.

Since it ended up in the wrong tree anyway I'll just drop this.

--QWeM8vMH8sgUbsgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXEvmwACgkQJNaLcl1U
h9D08Qf8CRALc0W8HqUSnOfy7MNPpjNEZiD+0BeEBPZNyLxXa4J2kftp5S/x8fLR
hvqeADboxKSlWy2vqDf3OmPJ4WuFj+930xstwyMwZtR57ILjTJ9BcmSYkclHS7XD
lsxDv2H8Gz4qRnLrytWkPxsZMQ6VLR42QQR0yWkfnIUeUBKLA30jJbPNhYJLIk/2
Crsh7uM5ZFo2WkhXCCmm1Kz+8jvze8iJTlYQXscckHEdVjoLsfOCzUI+we/rOExH
xiP9o1QBJjMPk8Js2pO5htmmm1ZhWQQ4S+9LqZnALmEVeyx5g3x9i4k3qmbOQI06
JFgN7XUqXONMMhhQlyA/puR8JWfW2A==
=Zhjh
-----END PGP SIGNATURE-----

--QWeM8vMH8sgUbsgC--

