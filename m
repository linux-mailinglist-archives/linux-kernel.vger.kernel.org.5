Return-Path: <linux-kernel+bounces-128844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9789606A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0D1C22420
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA912CD8A;
	Tue,  2 Apr 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDP2Y1TE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DB58ACC;
	Tue,  2 Apr 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101968; cv=none; b=B4v07jlsaXSmwoPvOSEcFSLiBuKwoXU/6yyjlm19j2i0WTLIsJzSc5UkSMVZSJ+bJVKwlqYoZ+EMyS0riP2/1/78/unxneXgY1bwy5K/z2wJRVEGKsPcTSdumnAuSXW6kVs/OQ5XIqa6tEP0HPeJSGJ5+iRKDFXlSEKapMYfrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101968; c=relaxed/simple;
	bh=Sy+6YgLbSYi6oUc8tga6IWA67M+fCiu2k4czpLDfdQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4MfEu9CxlSQKEBsZOVsctGD2uFhX9wvlT02ABSfVXoc/yDo3qsFIAGXiH9cVsLN4DiPd7zajaJhVQX+1KcZEJ/jWTypu2OsS0UXx8ks/luNLh9qpr560x4dKcifm30MzUY6o651P1PyJONXK/fMVp1tSdCaTkskn6as3hyfFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDP2Y1TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9454FC433F1;
	Tue,  2 Apr 2024 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712101968;
	bh=Sy+6YgLbSYi6oUc8tga6IWA67M+fCiu2k4czpLDfdQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDP2Y1TEdx9ub3IEWbp2hjtEP2iYAn9/TrZpwVK0WL8kpwQPFgvozZIu5taUdEXtp
	 6JXpwDlalACNgNnCrDzZQ1kH0ckcA16oOgpJ7XqZFgPrwmv1mcz1OaQ4jvagYwxMK6
	 rxR7/xdmdp14Um7wLxKHqX1Wotg419oiYP8N8MpS/lAiRDec0/SsJpYW8bPepKAo45
	 zV7ESl4VVsevDgRICya+nHIQNJRGBzv+6g9OAjTCjPvSXVt5GbTRLUTkFfCIL/JKKl
	 qgP2bJopMMfGzdVF1ysCvap7yreGKcY0V2TgrTcNvMlKtQlqJvHNvlbDaVOr9bEQpI
	 7bEE3l4yuVKtQ==
Date: Wed, 3 Apr 2024 00:52:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.8 SPI Chip Select Regression
Message-ID: <467644bf-85d0-429a-bd11-7155b1cb5fbc@sirena.org.uk>
References: <Zgx5glZznSCheksj@euler>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yKmDki0JYO3XvI4S"
Content-Disposition: inline
In-Reply-To: <Zgx5glZznSCheksj@euler>
X-Cookie: ((lambda (foo) (bar foo)) (baz))


--yKmDki0JYO3XvI4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2024 at 04:32:50PM -0500, Colin Foster wrote:
> Hi Amit,

Amit, please respond to these issues - you never replied to the mails
about the other regressions this introduced either...

> [    3.459990] omap2_mcspi 48030000.spi: chipselect 0 already in use
> [    3.466135] spi_master spi0: spi_device register error /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
> [    3.477495] spi_master spi0: Failed to create SPI device for /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0

> Is this a known issue? Is there anything I either might need to do to a
> device tree, or something you might suggest to help troubleshoot this?

This is not known, and given that you say there's only one chip select
in use on the system seems clearly bogus.  There were some regressions
with trying to use more than the hard coded maximum number of chip
selects but they have a different error pattern.  It's late so I'll not
look properly right now but...

Do you know what chip select 0 is - if you add a WARN_ON() to
spi_set_chipselect() it should show a prior call to the function, or is
it some logic bug that somehow is not manifesting on other systems that
use chip select 0?  Though looking quickly there has been some factoring
out since that commit was merged...  just to confirm, did you bisect to
find the problematic commit?  If you could show the DT for your setup
that'd help, especially if this is a GPIO chip select.

--yKmDki0JYO3XvI4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMmkwACgkQJNaLcl1U
h9C7ugf+NYa3Oer0QJuuMbd9DVStpdXnyTAl8KM/vPEDBPt6ux/DAUBgbFohe1FF
7J+HArHr/ORgXcNuXn91SjjuhmQ0f2/E6l8r31DawceOrD7weSpwwxjG0HTB1HQp
NPdoeCiXMfC99pvFvqvQH5nB3yco7G9HonnYdj17+WLKNA7QkcBkzZRAd3m6iSDS
YLPv84McisH22eDM2E+26EG0JYJ7fSaxAcgndAIjrNYi/2TDB8WTS5R67OJ5fvnP
yRCXkt51gXiECR6B3C5EkmV/UbapKv/xVkHEiRojpbyrOHx2LSwbteJSRPTtsCgV
+bgVB3MraL0E+pWEGKu7nOTjaZ6swg==
=2p7w
-----END PGP SIGNATURE-----

--yKmDki0JYO3XvI4S--

