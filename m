Return-Path: <linux-kernel+bounces-18892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627378264B7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A06281C4C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B911134DE;
	Sun,  7 Jan 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5ahOiB9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD868134D9;
	Sun,  7 Jan 2024 15:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBA1C433C8;
	Sun,  7 Jan 2024 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641183;
	bh=WuaxcPfuNzKvlyOWSf/bOm0f8ErEd90QXyhmgOJXUaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5ahOiB9U31TLZFb7USUSSE/coAfIkDK4kw6qSumgLuQlv25xs04E3H1rR/3JRerF
	 GQC2dzpgxI1Pl2OH+vo29psSLaPWoNJc6QBovD1n4mWN9HIKkrl33Twbv8d+i5TEBi
	 RzhKd1UbMrsQhvst1w+xTI5gXklUt8ueQjliiNvV+NBPbmxiyBkYopCpygGdQlHxrt
	 Mg1HRrkreSuIhi8aN9KTKdqyXFnTkipZKwBObAvbGsttUjm1yTNdzUls2icjhzCUU6
	 TkR0MkosiYYpdtMeJ3dxOt56mtE3RTF8rNZzkhuTaYqr6kpZfAPL1kN3d+KcF1l1tl
	 LlXqU7nx7a/tg==
Date: Sun, 7 Jan 2024 15:26:19 +0000
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
Message-ID: <ZZrCmykT2eY3+6Uh@finisterre.sirena.org.uk>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
 <008ee9d6-6259-43df-9af3-2dc9877cfe94@sirena.org.uk>
 <CY8DP6O8C72H.2XTJT3P7XZAKE@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s8USj2oRmKnie6rD"
Content-Disposition: inline
In-Reply-To: <CY8DP6O8C72H.2XTJT3P7XZAKE@gimli.ms.mff.cuni.cz>
X-Cookie: You might have mail.


--s8USj2oRmKnie6rD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 07, 2024 at 10:49:20AM +0100, Karel Balej wrote:
> On Fri Jan 5, 2024 at 4:18 PM CET, Mark Brown wrote:

> > Why are we adding an of_compatible here?  It's redundant, the MFD split
> > is a feature of Linux internals not of the hardware, and the existing
> > 88pm8xx MFD doesn't use them.

> in a feedback to my MFD series, Rob Herring pointed out that there is no
> need to have a devicetree node for a subdevice if it only contains
> "compatible" as the MFD driver can instantiate subdevices itself. I
> understood that this is what he was referring to, but now I suspect that
> it is sufficient for the mfd_cell.name to be set to the subdevice driver
> name for this - is that correct?

That's what I'd expect, yes.

--s8USj2oRmKnie6rD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWawpoACgkQJNaLcl1U
h9DhFwf+Jz6UXXtD4QhjnIO3kEzlyxFuWrVQTr+TtTr7riXooGHR8h4MPzuSIScr
WdXeG9UwpiOW1ZsTZu4Gf7hV9TuHwzbGwn1a00Kaz4OqezE9NaTXNpYm6AE8ePCY
zz+uBysvMyx3Fs1AZQJTr2iIc9feFljq71sHJCDDtVABBMHQXq2zMU5RTG6tIo93
InC8rg0MP0QOo8rZVRpAPgz/ABt42acJ3k+JEfu2gnlR9v83Fq5B4ngOHPm1dztc
XDYPM/gKAPZ+7TicoXlH72Rj2hMaNBwEDSgx5A+PdrqFUrvuIBaH6KJRTNCGWDWb
lcAjyGUtrpj/G92M1YuYXHgxOzKunQ==
=bmif
-----END PGP SIGNATURE-----

--s8USj2oRmKnie6rD--

