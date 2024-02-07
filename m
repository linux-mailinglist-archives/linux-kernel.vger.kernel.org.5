Return-Path: <linux-kernel+bounces-56766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AB84CEDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8B51F28508
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999098121D;
	Wed,  7 Feb 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV/1//8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467381201;
	Wed,  7 Feb 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323212; cv=none; b=AwoIuKuZoAy8sWkav1UtyNxT4JG7fuIEkKFJKjKsTGvLoG3Nht5xBmPt95bwBrqYUVFIjRTAApZLWsRfU6FbKGdJCgPdsgbUhXChr1gNBUORyJLFm7f6mnpfAYG1kZRseq2WW8dlAQ3nwYvK67QYVVI226M6z9qEwHigKNGZghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323212; c=relaxed/simple;
	bh=PowRBFjz75WWYEtFZnydwXqExpiqvShTdLKPfWCIPg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncTquXr4MQkU3/87YR8QFxogfOQ+4zO0pQJGvTQXzLqPhlbvC5zQ+oJB4+E3+dYDKtiP60W+LIHrJVi4479yU/2SZDp1U8AWvTDlwJtlUPWWQnxK5VOXVWqKqWUI6AoXh06PuGBGQMiQCCh5Dqr9UsB25cH7w1ekdpc/oeaBfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV/1//8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECBFC433F1;
	Wed,  7 Feb 2024 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707323212;
	bh=PowRBFjz75WWYEtFZnydwXqExpiqvShTdLKPfWCIPg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tV/1//8gmuYg8UQWVRYRPGpWBRe7tk8hpqX4Fa+hCjQTh5jOhH9qCqY2+w/SbpPnD
	 OtwhsPh/2f/eXCURP++4uL52+aLyCtoZGc9nrGdtLDpx0gIiUlxYVdD8FzIZeyIdEF
	 8JXAK0CS38f4Bsv+SUWIIcdKeNTNp+EniAbRPvVN6qdrGEpJYZdSy1VH3lU+5PkhNa
	 U3C7vH3eqFU7cSmLVWPS70PQnUZGdO1PXTiUwW1qOqrCMhwWG35BQ8/w65/aWTGuUV
	 opE5xg02jBDPibX3mNGIEQPctLXuER6gxILCfsVoTBA+4UKpX7S1OkOg/e4xLtCEMG
	 PMksVQD0be53Q==
Date: Wed, 7 Feb 2024 16:26:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs35l56: Fix deadlock in ASP1 mixer register
 initialization
Message-ID: <ZcOvREgHBiQVuB9n@finisterre.sirena.org.uk>
References: <20240207161602.1030342-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EMCHHW87nQ+T4IA8"
Content-Disposition: inline
In-Reply-To: <20240207161602.1030342-1-rf@opensource.cirrus.com>
X-Cookie: You might have mail.


--EMCHHW87nQ+T4IA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 04:16:02PM +0000, Richard Fitzgerald wrote:

> +	if (!cs35l56->asp1_mixer_widgets_initialized) {
> +		ret = cs35l56_sync_asp1_mixer_widgets_with_firmware(cs35l56);
> +		if (ret)
> +			return ret;
> +	}

Might it make sense to factor the check for init into the function since
it looks like all the callers do it and I'd expect that'd be the case
for any new ones?

--EMCHHW87nQ+T4IA8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDr0MACgkQJNaLcl1U
h9DaLAgAhU2r1USCPLg8AOzumIzQ20m/PAOaACMu81xCBh4JH5D7EHv+uNOBql0p
/wxF88FtoX/xe5ZsN9JzyjApP9Y1dSSsBUgRbTqge/5ixuZHKgzuDDbqwt+fDSky
dODR1k+1Yw85DtKlAmk2aA0bbMV0QpjQ+iuRt4nauR3IHF/p9kSTPzqaf33eiBJL
kO3rT10QH8IQWtzKwnltiTnKMlBrnsgzlzyJ/oLfMyN26g5yWCdaTWoY/LCxMmmL
dfWnPVXJ7+Cpq+xAi2mhDX78Fb/X+uGK9KeE9bIKwZITWGuc5z9ITkkr20fruvCQ
e8meSxc2yddRLmf5q8DFlPjU46T0DQ==
=j0DP
-----END PGP SIGNATURE-----

--EMCHHW87nQ+T4IA8--

