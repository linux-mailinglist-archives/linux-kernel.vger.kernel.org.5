Return-Path: <linux-kernel+bounces-35783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E6D839675
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CB2B23661
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A57FBD9;
	Tue, 23 Jan 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJXCGcAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EE80041;
	Tue, 23 Jan 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031123; cv=none; b=qM0+zKp6yPADujUJJ+dnCWpZSJAP1SnB6AiFuo4U0+Y7GKUi0gZpmsx6oyuA8v4ayTuhLOV0Mn1e+KlXGbm4VBvv/gXeRYHnte32EvazLn4INiqVaysfEPf6VzDAxyyTKrYwWjbDA38T1ahOrbLPBacPLnjbQoQuYxtTOS+AsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031123; c=relaxed/simple;
	bh=vnQPALudVridAeOMTUYJfy1JXdOlGYJ/2iBszYF0y1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvNKXcA4/iqQbOixMbAMBQPTV34IBSBnXuGvSf/DI5pOIx/V7odTMInFjM5dIBaOBKBQD+kRE+aWHjsAnnVyfsB0wGrRJD7uUxvKAEuSqR/N4G/sKTMIrwcs0cUZ4lHyWpBk2qS0GW6JFa3myIQEZA9xUmF0W5BtZRE+yKRJdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJXCGcAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C84C433F1;
	Tue, 23 Jan 2024 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706031123;
	bh=vnQPALudVridAeOMTUYJfy1JXdOlGYJ/2iBszYF0y1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJXCGcAMreUU3SZda8JNybHRCNdxaVUb9TCrzM/U8zlIbMPugud/RZL+Lu6913Mlk
	 6KHgOHWnCYW4pUKhk9C6dFyK9TBK11vzGOXydBcO72VeESZXT/tGh+hrOOViUrcaAh
	 32Xy8I5XTpK0iWv/yf3F+CX3XLp7LE3L7yOE9iF0QkpuccmyeiMhLkW2xfjLCVkl34
	 pgMqfuuPStmQh4h2ZhgtLglNrXfTi65EjGQ2gllF0o6syNo6tyXGohA1VFvphOqgiQ
	 K3MrlLzpUv5Rh/ilgJ/gdR8rjjnk2vl8SHnhS1+ZSyTLK4eUaQk3sP4km/UdhVPVEM
	 jtrYUP7Qt9Avw==
Date: Tue, 23 Jan 2024 17:31:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Message-ID: <991d84b4-e184-4fd6-900f-601f8c31d518@sirena.org.uk>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>
 <Za/e15zUOEaa1b7d@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wv42auelfj9rWUAH"
Content-Disposition: inline
In-Reply-To: <Za/e15zUOEaa1b7d@e133380.arm.com>
X-Cookie: Stay together, drag each other down.


--Wv42auelfj9rWUAH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 03:44:23PM +0000, Dave Martin wrote:
> On Mon, Jan 22, 2024 at 08:41:51PM +0000, Mark Brown wrote:
> > When we documented that we always clear state not shared with FPSIMD we

> Where / when?

In the document that is being modified when it was written.

> > -* In practice the affected registers/bits will be preserved or will be replaced
> > -  with zeros on return from a syscall, but userspace should not make
> > -  assumptions about this.  The kernel behaviour may vary on a case-by-case
> > -  basis.

> This was originally an intentionally conservative statement, to allow
> the kernel the flexibility to relax the register zeroing behaviour in
> the future.  It would have permitted not always disabling a task's SVE
> across a syscall, for example.  There were some concerns about security
> and testability that meant that we didn't use this flexibility to begin
> with.

> If we are making an irrevocable commitment not to use this flexibility
> ever, then this comment can go, but if we're not totally sure then I
> think it would be harmless to keep it (?)

I think everyone except for Catalin had felt that the original
discussion had concluded that there was a commitment to always clear the
non-shared bits and was disappointed to learn that the documentation
said otherwise.  When I tried to take advantage of this as part of
optimising the system call overhead for SVE there were eventually
complaints.

> (Feel free to point me to the relevant past discussion that I may have
> missed.)

See the discussion on my syscall optimisation series:

    https://lore.kernel.org/all/20220620124158.482039-8-broonie@kernel.org/

--Wv42auelfj9rWUAH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWv+A0ACgkQJNaLcl1U
h9DaTQf/VjPt7AYgYvOmXYGPovG834fzOlz6CVgNxigTvGcW3z+gY79+oinyH3q6
SPl5DS4zSoGVMu1vR41R+l+TdmTCphxjEZIVLmk+wuMommfT+71leHQj4Gr7nNSj
N8R/mUpOe0y4FgGyPvs6ljvso5Cyls6WtTR0j8syqAkRH08f5fnY7piCt1oHaeBm
i0USNyjfJWShZmvsLqw8MSObZMZfZhlkPmIuNbqPbujiAIIybcvBQIevf5rSnUef
NgwBhKTP4+HHBsTcVTOgMphiN5zJBjQnEv/NJlAk6iW7lcxTdbSW4i7luACv2DZs
GWtM3WgGNAQP1pAITjoRPNzzGLOmog==
=I+eN
-----END PGP SIGNATURE-----

--Wv42auelfj9rWUAH--

