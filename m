Return-Path: <linux-kernel+bounces-17985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA282566B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819061C22ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880622E62B;
	Fri,  5 Jan 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV5ZLP4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1D2E3FF;
	Fri,  5 Jan 2024 15:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D59C433C8;
	Fri,  5 Jan 2024 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704467930;
	bh=J7uVfB9FRbKLIHfheAJC7XP3EW7xV+y/495rmPm4z+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TV5ZLP4GVMasYAqO06Km5GN46e4tOMkjbfl6MsSkSFd58HtYzrmrGzwnIPrdS4bDJ
	 hntw+SjIhGjTwFgxrLahdP1Hha3G4aFKjGy5gKlrEzUihLQhvKudPHcH4tGLiA4qR8
	 Yvi2y7qSCMGD7+gs7MjJc6683oTWwMrF5NTo/flJ/xI39sfGW1//Noa6gCq6NToP2/
	 ko44QZOTUK+1PSgrwrVvNELkWetjCvssQroRp0iAvLftZz+CusWTkd78KYZUaJo0pX
	 Aw5ZAu6OZs/94Rt8w1lmrT6pOeb49iMWfplhGf2OBjmPKpWzmLKeyDk19S/mHN1aQB
	 QFxNcCPtgE80A==
Date: Fri, 5 Jan 2024 15:18:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] regulator: add 88pm88x regulators driver
Message-ID: <008ee9d6-6259-43df-9af3-2dc9877cfe94@sirena.org.uk>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z19JQyAf+moSHib9"
Content-Disposition: inline
In-Reply-To: <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
X-Cookie: Your step will soil many countries.


--Z19JQyAf+moSHib9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 28, 2023 at 10:39:13AM +0100, Karel Balej wrote:

> @@ -68,6 +68,21 @@ static struct mfd_cell pm886_devs[] = {
>  		.num_resources = ARRAY_SIZE(pm88x_onkey_resources),
>  		.resources = pm88x_onkey_resources,
>  	},
> +	{
> +		.name = "88pm88x-regulator",
> +		.id = PM88X_REGULATOR_ID_LDO2,
> +		.of_compatible = "marvell,88pm88x-regulator",
> +	},

Why are we adding an of_compatible here?  It's redundant, the MFD split
is a feature of Linux internals not of the hardware, and the existing
88pm8xx MFD doesn't use them.

--Z19JQyAf+moSHib9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYHdMACgkQJNaLcl1U
h9CmhQf/XJh7ujIuJ4+E3GvWjXwe7MGXOtALsEaqIGC4T2BCAber0xlL7cukDmYc
n7d+xRKRyBKt1w7xZTl9ZJ3q8Y9B2tlf9Gh+GcvcTk9q8xv+7r65NfMzbCJJ8l+l
jr9XfSVl3MXYCJ8Fp4/cuZdz3uifzyUHKSc2zVsETYihrnzPeMPuVBE3RBI4PgZ2
I4fqKaDwEDWmAUcvzIhZuo6+3Hl92xFNlaH7U45m5Y2KloMxzkzUp5lKx7T1Ztgn
xG1VOKREcO8UqksDJz5uig+sgR1CbjxDmf1f/2uTbdWWIz/i6+9FKZ5FbcHNaoms
jSL2gBg5Ou/JXADNybSPGKueWHLZ8g==
=O4ep
-----END PGP SIGNATURE-----

--Z19JQyAf+moSHib9--

