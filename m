Return-Path: <linux-kernel+bounces-164510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F598B7E67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8229F2835E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F01802A7;
	Tue, 30 Apr 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKCf087I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2A17BB20;
	Tue, 30 Apr 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498016; cv=none; b=iuZ2Q60LSbVJHFiXWFAUc9P/J7LRgDvqy+eMgtdKwJXG8fkUnYVdwfrJnIgy1OGhfIUzF3HKsL1EiTdALcArj+Y0I5VWU01KuncutfgIVKw4spsilwRnZ6sZBVqxZokHAQaipSU5+PuEDBi+JfE+fDke1SKn8gH6fiBlnqB0p/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498016; c=relaxed/simple;
	bh=0KeV2u9ksY0YfA2yFgfKkgJQrLCCtz23h5HZRBAWiFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtDllCa8fzfgZ4vgXi1+sUZ+vTDqx3Cu/ZuUSVRoQBLCbkfWMcLRJ2alcnxnyoxZZg0rJJezDeMIoHOGNpagJDf4ELdLA5BFDEQxK19EM+PSgAxzBeugDdpQ6tBLUlE0WHoz6MjLMWPXI7vjkq+OEocD/SmY876EiauTslXp5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKCf087I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316FBC2BBFC;
	Tue, 30 Apr 2024 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714498015;
	bh=0KeV2u9ksY0YfA2yFgfKkgJQrLCCtz23h5HZRBAWiFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKCf087IOPhdKhN23Rh+4nYolxBmxLSO7gl4cTkAbF6IGcHWam/bcbmhNLA0+5hfG
	 NefAyi4QAhJonrQ2T0uvSS/DlYCnplWB39GhCHO53EgsgQ0NYC1sXg3abQ1zUvVNcs
	 r/5CFiGjbedNdrNPSNYdu6m6+ypoEZuI1adiGctzrgRXmlEEwbj5c6pqJ+PG1/apNU
	 5LXjHQvUrx64k0PqjL/h9GDYReGsYZOrdMZD7n2E5GDIqxY4N/HalTeDmOGf4NGWXQ
	 bhuZMNQP0cxZiOxT/nJ2sEjm8HcuCNshVJZmBpkiQLQRi6SCzJHBgcwS1ntMIyxLXW
	 U4TKnxxq7IBeQ==
Date: Tue, 30 Apr 2024 18:26:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	andy@kernel.org, nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240430-sandfish-bring-16ce723b8612@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
 <20240430162946.589423-6-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QgM2jKZVHy6EjSwK"
Content-Disposition: inline
In-Reply-To: <20240430162946.589423-6-alisa.roman@analog.com>


--QgM2jKZVHy6EjSwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:
> From: Alisa-Dariana Roman <alisadariana@gmail.com>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

btw, the whole series has a from != signoff email problem. My git
send-email handles that for me without me having to do anything by
inserting a From: header in the patches, like so:
https://lore.kernel.org/all/20240424-tabby-plural-5f1d9fe44f47@spud/

I am not sure what option you're missing to suggest, but it may be as
setting the `--from` arg (or sendemail.from in your gitconfig).

Thanks,
Conor.


--QgM2jKZVHy6EjSwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEp2AAKCRB4tDGHoIJi
0kziAQDcAT7+brax7bXTdBP5X+1u8YLuwr8T//H8T5XVPYXs8wD/X5FEQlyk1Qg+
BoUHQ4cGSH7Sp4iWyYrKn7r9j82Wkwk=
=ue30
-----END PGP SIGNATURE-----

--QgM2jKZVHy6EjSwK--

