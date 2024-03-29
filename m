Return-Path: <linux-kernel+bounces-125075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672B891FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C694E2878F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D810145B2E;
	Fri, 29 Mar 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXvkl0Tv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FD39ADD;
	Fri, 29 Mar 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719878; cv=none; b=MipSldJIFfFOR2KJ4idcjSU1VgIiGzuEh71kWSNDf3VRnWzU3vJAlPW4X2Z3ie/k7NCmirQ1pJ8KdyWsy20EFk1qyVMUmQ0LmxGi9DheoMyh3vnqlxwKrgLZWdnOD4VOsu4WVT52NSi+S4Y8CCwtIMaDeLV4kIskl1UMeSySc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719878; c=relaxed/simple;
	bh=7025wz2wTMy76FRP8y1NIXVAZaINC6zDkDUlwU/4nHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1jEDt4vJziXLKikGGmjrghXnK2V3R2jSAh6RTp/u+qd0NroIAkCEFPE3+6nO2zgog2unjeq2Ykl7lT94I9LFcHgj4FZ/dnIp/Vrx3EmQp6b0ADygsUwSHGU5EZUJsr3zW/Hv5Rw3y0Yl1xgE6KiLbNOtyD5u0EKSzKHT3S24k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXvkl0Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A014C433C7;
	Fri, 29 Mar 2024 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711719878;
	bh=7025wz2wTMy76FRP8y1NIXVAZaINC6zDkDUlwU/4nHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXvkl0TvfT1+PxySECL0GKFAzG2EXVy1HCpd5gZnIqzeTXBZvHatPstdISGNRqszL
	 2/i4DKB83b2SNCZUJDAlZNPafhEXwSVUhjhruU9MKWBNhKGBGHzWW1X1FcQddEop3p
	 yHGyhRYIyGl1RcwKILJmofwP++QLodfEFEwAG1dSZL5joltypUwc1zHUYfl5bXBxh0
	 6rdAumZ3x7dJbewJNr6pIjj/5MhIAPBiXGNc53uL4vFTq4Yv8h1u0U4fUAPCcumGIY
	 9jPrCc3KCgYXDk7f9Is+rOncUhjzUoW/bjCf08fkbnmSw1ADXT7CIQqx/73YFT9O8u
	 CKvEfz4rAMYWQ==
Date: Fri, 29 Mar 2024 13:44:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v6 0/2] ASoC: nau8325: Modify driver code and dtschema.
Message-ID: <ZgbFv+c3fjME+x+Y@finisterre.sirena.org.uk>
References: <20240329085402.3424749-1-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/2UC1HPubXxRHY8b"
Content-Disposition: inline
In-Reply-To: <20240329085402.3424749-1-wtli@nuvoton.com>
X-Cookie: You might have mail.


--/2UC1HPubXxRHY8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2024 at 04:54:00PM +0800, Seven Lee wrote:
> Revise properties description and use standard units in dtschema.
> The unit conversion driver based on the attribute must also be
> changed accordingly.

My applying the prior version raced with you sending this new one, could
you please send incremental patches with the changes from your v6?

--/2UC1HPubXxRHY8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYGxb4ACgkQJNaLcl1U
h9Cfzgf9FewcTdv1e2tZdg1Pri5qt9/MGVkmSh9R+8D3z1zz/pMx57wCFowDzuFs
e2FhXyaKTw8pbOXDQ6dW2Bym80xTEE6jgiSsJGPNqwT/Tep2qRdz9v9gyHyvkDZ5
hlWs1eM+NdKc9b+C98+05o+A81/Arw+deZH7ilf4rFMsLVgPgtWGkdu+B+Xd8lW5
lY7bC5SIgVK8R7kd4bg5VX9ZfqdBFPMOGEVZ6INAkHhbTOZ8mDG2/eJZ1xwXWeAr
W7jqj22t5ohZSdwBR7xCfcdaDYig6rK1Kufa+7FlC5UHGF+jZswr3GssgjNLsjeN
P+O3wgSbI2ye0QnscPtEoDJBchz4IA==
=wIjS
-----END PGP SIGNATURE-----

--/2UC1HPubXxRHY8b--

