Return-Path: <linux-kernel+bounces-154523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382D8ADD17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747681C21803
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB820B20;
	Tue, 23 Apr 2024 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M10YeDSf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855D208A8;
	Tue, 23 Apr 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849578; cv=none; b=RmMK48ezrsezoeicgSZ1rQksV6fRLdPjqLivg6nVriNrXr8OMuQLyaxB32FhmPDysqZj7PwQllxDis5mSm2GAjLtltXnTph77CoKgJdivqlbnG3pXJQPwNtJdQGvk6rbcE/s7iUzJUINl/2q2Gu2+58l5LX/fpWfOf1YyMNpsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849578; c=relaxed/simple;
	bh=KkfWec4DHXYOlCcz3ys8cVUPAo0wL2CfqmIIIG6Mu6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiXGGfqMmt6V4HOjBszETGzsDZ/qif2ocghN4qhcJEILlUjxqeTOOFctUrqN7ISLian2TVonX4x2BAqsp4IwyZxV9hhBvOT9Q1hyfF4oXwkkeX7EEE5ZWlLJmU96QkLV8feu9c+jfldLxxNAcIbY1Gk9x5TCxH3gIjXy4ifNTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M10YeDSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2AFC116B1;
	Tue, 23 Apr 2024 05:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713849577;
	bh=KkfWec4DHXYOlCcz3ys8cVUPAo0wL2CfqmIIIG6Mu6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M10YeDSfihs5WeErjuPkQI43fpEKyw4McDp2QErbnMbV2ceFKquCa/cOP22VgtzFO
	 AKHc+ftJv2CJ8N5nP22MfHyBLJF71E4AhA3UYpj4q4dUh6IJlpkGz7kMG7GBNiSqvy
	 2qWes9nvtk2rh+uPXX4Y3RrzhhWc2KHxs6ciMkoukzNlPRmKRhqe8Qh1abLDDAuJGY
	 6kURJwoApeSlQPwHTQFgP+zvWf7NmJ0L212gYE0m5BRICa8CqXIiITei1VGWwYH1pY
	 x1FppOcNXILXMdJvHcMKm+pE/A6flno30P0SDgiQOWCEQl1eWkVXesvmfldVaEZ9YT
	 HHYQLRMVXhtqA==
Date: Tue, 23 Apr 2024 14:19:33 +0900
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-ID: <ZidE5UcQ6XSc0YBI@finisterre.sirena.org.uk>
References: <20240418000736.24338-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gr/VhAjSITvMtMIF"
Content-Disposition: inline
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
X-Cookie: TANSTAAFL


--gr/VhAjSITvMtMIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 01:07:31AM +0100, Andre Przywara wrote:
> This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
> original patches in an immutable branch already, so these here go on top.
> Patch 1 is new in v2, and adds the IRQ status and acknowledge registers

Lee, this looks like more of a regulator series than a MFD one (it's got
a couple of small updates to the MFD but it's mainly focused on the
regualtor functionality) so it probably makes sense to merge via the
regulator tree?

--gr/VhAjSITvMtMIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYnROQACgkQJNaLcl1U
h9B6dwf/WQ8Bv8qbVMbz0Gm7e/a/Wdgqm78Zlelv7iHv35hhBNwjhQSUvbVeeNd3
SvE5wUjhGoH1/xngdoEnzEkiUCJUX7EoO1wA/rs3gf4dBOobonElLVnpcU+/3J/L
DV3aAcxC/yz9a3UeJgPJovbCpGUQmE6VCDTPmwBddYNir9Cs8zKtadKLUxj2dJPi
iZIGXUjk0bPmbRHl0qd7WqrMz9wlHe6I6vUT1AF7L1rp5qaCzgsKr3JREE+i9RrR
2tmXPdb9s+vhhW39yVjxcIICpsEzCFSfsTDCgLSllEQ2pwO3RekFpoG+gpD8e+qN
cq4MQuCfcflgP6Dlv0G3Duo5eUIqNA==
=E4cf
-----END PGP SIGNATURE-----

--gr/VhAjSITvMtMIF--

