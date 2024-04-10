Return-Path: <linux-kernel+bounces-138681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD389F8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CE1281DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066916E879;
	Wed, 10 Apr 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN5UC6Kv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291E16ABC4;
	Wed, 10 Apr 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757028; cv=none; b=MXrkw9uh9eq6h4RI8AaRbl/3mxKaivDjA4mDr3x9d67cqOSTnNop8gZOksN1SD3Hh/dBBsjS7zhVZoX6mZ1kXHIhmjWjEZRahkhY4kozHMP2883KqpLG+xE2wDyDmFwoQLrehCKMNRDMNdVSgF3IOJsWiTU1bwc7dh5eq/bDZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757028; c=relaxed/simple;
	bh=ljr445iusAw39F2vSF8K2Sww11owRwWWcRfepDqn/3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INo5NcHUsyeZOAg+R5xh0cexYKcnMPxI+fw4Nu+VDWmSIbLdTFJZYEGeg7+9AkeqskRBZooHiCoORpurkKSN0NaogAO2Ww7fW5kJvQkahokhgExnrlIR5vmdq2k+zoJfI4I8VL2Y9/bMb84NV5U7ymJLs3yFfNsEA636zavOQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN5UC6Kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10870C43390;
	Wed, 10 Apr 2024 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757027;
	bh=ljr445iusAw39F2vSF8K2Sww11owRwWWcRfepDqn/3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RN5UC6KvcL2KelCAspbm3Ew/SAfruCtzSEZcjHpDuNjV/0+yr5pFYkW5M75Xs8IV6
	 9F3gufe0UjwbZnUWqXaazv8zkOhlIwS7TMa1sNmM7iYNibKjQlIGcsesue9lhYNpkA
	 z0NijGc0VxHCHon9TpzTObiYgP3eG4m1eRKSAn74Q84D8qLe6jiMloPtkodgwAy79n
	 qwR/lj8RXHpSJz/fvV2Eo+tbj3bIt9ELjT/LLwp0khwBIIlOtaz243uTErtb0rdzkp
	 FzCXuHqG/aQKVCN4Uo4gDaHjRfBi1IGIqpVHWBWqWk1oCvkagmCMF0F3k//STbysz3
	 K0aZZsBe5j3WA==
Date: Wed, 10 Apr 2024 14:50:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, vkoul@kernel.org, tiwai@suse.de,
	vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/4] ASoC: SOF: Intel: hda: disable SoundWire interrupt
 later
Message-ID: <1b5da72f-755c-4440-a5df-c0d76252a2f9@sirena.org.uk>
References: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
 <20240410023438.487017-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukQ+x4zcJGz078s9"
Content-Disposition: inline
In-Reply-To: <20240410023438.487017-2-yung-chuan.liao@linux.intel.com>
X-Cookie: A bachelor is an unaltared male.


--ukQ+x4zcJGz078s9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 02:34:35AM +0000, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The SoundWire interrupts can be masked at two levels
> a) in the Cadence IP
> b) at the HDaudio controller level

Acked-by: Mark Brown <broonie@kernel.org>

--ukQ+x4zcJGz078s9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYWmR4ACgkQJNaLcl1U
h9CMSAf9GJpquDoyEOhACCD+Fz5niy4JzZEgRbXhbitqIWrI24YDbKHBRYzL1ukT
8iNZwItYjgWzxfm8bKe7nmLHqLgpAyy4hW4Pr1wTUCfaVcmSrvKHABAE9trvVz7/
hBkGphUuL8zR93o7GMUBH1yr6BQAnq3x9l1WGJwECxs/dDNBhNWDd30HglGFxyoC
RX9ft0D/qZAhoU26CHrqwDJ3PMgoItNGSz3K3Veog1y+rIGU1Yn+GQNoPUj2hM6K
xlIuXO5Yb9hdeXRKiML2UDfKDwt2R96gxBEWCtNdoDCKEBgsbD/OoAXGjqZ53/eI
6wiZu4TGRETMl9nlKwK1y9fE5hc5Bw==
=ZGeT
-----END PGP SIGNATURE-----

--ukQ+x4zcJGz078s9--

