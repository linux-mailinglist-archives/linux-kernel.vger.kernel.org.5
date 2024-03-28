Return-Path: <linux-kernel+bounces-123480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98A890941
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE48E2987F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984B137C58;
	Thu, 28 Mar 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5O94yj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DE3C08E;
	Thu, 28 Mar 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654130; cv=none; b=qDYtziT2drbvl4IS86sDsQOPcX1X9IBjwm5O5BqojgaaAmN98d6YC3esgQBLWeaGwIC+8Vidkrm8Qa4OPYZlZChTgw0unwei73d2cK5C5eKCCEAkMGPxA5OoJe+24pNpv/TWrEDvncvoyS56VftZECSH28CsGTU7OdoH/fBSNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654130; c=relaxed/simple;
	bh=Nw7UVEH0a9tRFeHtk6dToEX6iVYCsePji0jVeTefwOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSgpmCSzLA72YvzWidDUsb8qnD7XmVWr5TISHV00tugyEPfTpSuA/DXJYanjIgkgO7Yz0gkvWn5B88XSGeYcg8YokrQ2rexr0S2EbqbZ3OhcwnrIrj47tTvL+4US8U2s9bFRKznuWuH1af6Um0t/KqdcuOvnHPBWyOwLyvq6vJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5O94yj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C8EC433C7;
	Thu, 28 Mar 2024 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711654129;
	bh=Nw7UVEH0a9tRFeHtk6dToEX6iVYCsePji0jVeTefwOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5O94yj8jgo4OfsZ399hf3ZeVZFmihwlUWFwgqs8GpT4QyL8UeSlb4Z5kzFU6JWzp
	 to2Ukwwl6F/oSvjgjn4jsfCLOFrlGwSVrUjRTMaxOnMNkz2tJL12uavg7zNxkz6CoI
	 m+tq48/mYyYDSwRi0Xgt25Kb4VzEM0W21P/nMzgLAsfPVTrmTLl5batE5Yx1Qe2DHz
	 KA3r4sHbMDKW9DxVQ44PLSVgHa1SHV0F9AHEDCsXnB7WDUZYo/AY19/Q05Xz9hnhLG
	 LhFfy9tZ1xbFJ2IEtfaK0c8RgjFA1+NLhYM8YF+0nFKavBjCsXQ44c/FrcPibW2BTx
	 d772wANjHfR3g==
Date: Thu, 28 Mar 2024 19:28:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Lee <slee08177@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, roman.gushchin@linux.dev,
	dennis@kernel.org
Subject: Re: [PATCH] ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw
Message-ID: <ad9088ab-cd55-4c59-b0af-65e44475124a@sirena.org.uk>
References: <20240326010131.6211-1-slee08177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcY7Zu6uSdocuvCO"
Content-Disposition: inline
In-Reply-To: <20240326010131.6211-1-slee08177@gmail.com>
X-Cookie: Yes, but which self do you want to be?


--fcY7Zu6uSdocuvCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2024 at 06:01:31PM -0700, Stephen Lee wrote:

> This seems to show up in quite a few places in the alsa subsystem,
> should they be addressed altogether?

Probably worth it, yes.

--fcY7Zu6uSdocuvCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYFxOwACgkQJNaLcl1U
h9AMpAf+O5E+hqTgoIg1rWfMJgpCMlfl5IMhAkNW2/BrrNnRk7dJokixpLb2HEIA
PC2lh4j5vfmmGRtwF0SDdIrNuGAkTR5OGwm5wei4orBmS1HAVhBlu/+n85pBhG99
WyQaaqLdzMii5PZ3xLB82bh+mRJF0jlvb/3wLkzDKqF9F3sssPgNOXXihZ2O1K14
+wp5O0xoF0DYqsicJKEgPxTNU6GmW/ONkKuIeVkXGhTXnFQcbHGJ+nQzYzAIaWsC
9b/+Oyn2s/6+qTM17dPiPrLhKvz6AZ5N3zaA3HplS+Nk/Mxq7vHcVfwb2NyBL+CS
S9nQgr9W+PbToigTz3mN6t8tCL2lIg==
=E4V/
-----END PGP SIGNATURE-----

--fcY7Zu6uSdocuvCO--

