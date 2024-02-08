Return-Path: <linux-kernel+bounces-58504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6491E84E73F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D982832D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006584FA4;
	Thu,  8 Feb 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbbMaIqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8B82D6E;
	Thu,  8 Feb 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415401; cv=none; b=Swlf8UC9aOcVZQZqdXiUSVjVzJWl8pDOwx06kWaTL0uPiBGCp1/rKq+li09fjRvvYoa6Bsa0g/HBJbfF3CWj7hlUY/FCT4qgHe6nT3ohUG9nnMwiz4bl1YySuUFSi4ERCmYlgs0OUChlfmPZl040FFM/dcct73Do29sdyAZRTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415401; c=relaxed/simple;
	bh=SflXpkK8SwfV6EA0RSn49xTMuoxJ95n7w6hQuP1ovoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqQDRfHwjRZBCmpzuFPDGVPxXy+h25vEMaAYkbSXcXdvdmirzDnRNxwexPTh+qQwsiA6t6kUOGYfyYFl1gvq0fLzvB0lq5Q2Cz6zgPcBClst05PT9OTec9cyPoLG8b7yVOfpUvQKd//Uj9MwcGCIIAba6p4rkYnRBgW53Ubdnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbbMaIqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE3AC433F1;
	Thu,  8 Feb 2024 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415400;
	bh=SflXpkK8SwfV6EA0RSn49xTMuoxJ95n7w6hQuP1ovoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbbMaIqHXQgLF2N3WdPp7XnxKM1r58M64i0EGmKM4Z/JSbAjw1OYE2czzzdru5sJW
	 ZVFIpda5xLbbOuvw3soXdKhsRtVD68ZqsZaUUVzti9lWga5ZQUU2WkTzL6MJv/pBl8
	 QRe6T2u9ZnyNktHTeqqswLct5MTVvKHLxsi0fzVk5N3DxM7jODRZrCXzKh83bkOR5c
	 usKz4FivKf7DRzua/9FFbsIiNdfeLnv9yosO4c0JvFDnlasejjxtRPlLslcxrAatva
	 8LmeopxvFw4XJbeaHuq8XqtXhrnie7dfqg1s5kfyQSjk3nn69j0cNXhZgFoqexuLvk
	 tN5SFYD6XM0lA==
Date: Thu, 8 Feb 2024 18:03:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	robh+dt@kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240208-occupancy-shudder-514d8569e261@spud>
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rp3tYQwRmI9LNr60"
Content-Disposition: inline
In-Reply-To: <20240208172459.280189-5-alisa.roman@analog.com>


--Rp3tYQwRmI9LNr60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

On Thu, Feb 08, 2024 at 07:24:58PM +0200, Alisa-Dariana Roman wrote:

> +patternProperties:
> +  "^channel@([0-7a-f])$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 0
> +        maximum: 7

There are only 8 possible channels, at indices 0 to 7, so why is the
pattern property more permissive than that? Shouldn't "^channel@[0-7]$"
suffice?

> +
> +       diff-channels:

> +        description: |
> +          The differential channel pair for Ad7194 configurable channels. The
> +          first channel is the positive input, the second channel is the
> +          negative input.

This duplicates the description in adc.yaml

> +        items:
> +          minimum: 1
> +          maximum: 16

Hmm, this makes me wonder: why doesn't this match the number of channels
available and why is 0 not a valid channel for differential measurements?

Thanks,
Conor.

--Rp3tYQwRmI9LNr60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUXYwAKCRB4tDGHoIJi
0kl+AQC98IfDjABHtVsFckhffOx27fA9Ms+JQBbJ5iVop4SrEwEAkr5hI1PonKfm
IEj2BwHwm0qUl7HTq928BlyZg9nkHgo=
=qjtc
-----END PGP SIGNATURE-----

--Rp3tYQwRmI9LNr60--

