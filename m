Return-Path: <linux-kernel+bounces-9739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14181CA7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB691F23A42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62919465;
	Fri, 22 Dec 2023 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm5QMgQ4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A26179AE;
	Fri, 22 Dec 2023 13:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42371C433C8;
	Fri, 22 Dec 2023 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703250242;
	bh=P6RchKud5vgMjzbvRjvY3ZB1//7tLLhnXqUKBSc92I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pm5QMgQ4DLb1krxsWqV35IGAmLhCCz25h2kZ38RlD06CeeuKavLCsKuBniU2q85Fq
	 729zCkjw8x/amd5OacXBI9y8bcqVi+BhXVvJNp5wxzuAfbwetJL2Hfue28eQ4c+fTl
	 3W81bX555/Lq51zVZxD8xs50tUIGCido9PcQY5UGHIPKliwou2l3Y6aBMopPO6OhsI
	 zrg+3lBsUeWxNYErcFskeA7I2AwUlb4ecrONZeV3s//WUuguZrWFXdYP98vYy1tuWj
	 TovdIyInkeiYE8LNXQ81wRn5kF103bz5zu5BRmxhbNAPI5aUYle+Qr5l8/oLrP2xMn
	 mQiwk3W5uSQqQ==
Date: Fri, 22 Dec 2023 13:03:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: ASoC: Add Cadence I2S controller for
 StarFive JH8100 SoC
Message-ID: <229ffec0-3a8d-4ce8-a4bb-ef6ece639ad8@sirena.org.uk>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-2-xingyu.wu@starfivetech.com>
 <20231221-saddlebag-tricolor-d02a17d66795@spud>
 <f1210b31-25af-4cbd-b73e-2a72aa6c41bf@sirena.org.uk>
 <11c932a8-5596-4186-9c9d-ec8ca5a6ea35@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+SYfEWNEZ7TqPiO"
Content-Disposition: inline
In-Reply-To: <11c932a8-5596-4186-9c9d-ec8ca5a6ea35@starfivetech.com>
X-Cookie: Familiarity breeds attempt.


--w+SYfEWNEZ7TqPiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 22, 2023 at 05:55:14PM +0800, Xingyu Wu wrote:

> The Cadence I2S can support 8 channels. But on the JH8100 SoC, two
> instances of this just provide 4 channels to use, one just provides 2
> channels, and the other one can provide 8 channels. Should I use the
> property name of 'jh8100,i2s-max-channels' instead for some special
> instances on the JH8100 SoC?

No, your current name is fine if the binding is generic for all Cadence
users.  I do think it would be good to have a separate compatible for
these two channel instances, if there's been one customisation there may
well have been others.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--w+SYfEWNEZ7TqPiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFiTsACgkQJNaLcl1U
h9At3gf9HMiV97V67JGVkqTyZ1zrmOry8r0gKK8wtSM1JZMTyh+tLXWfvH3z5QF+
7R4AzB7A+oYf8tMW7lTlkWL2SFXaWHXL57EgRuWJ72f9/pSQeOVsCdyPb/SlTDho
DXCYHa/88/UPXJeQmvV7spyAvPbMcgid6rThjtPUXPhIH1TzhuwOTDf4jbBRScwe
bpwsDzd4Tp31yJSGHJ+fmCWfCY5aMBg32/4a9PUmkgLtFzNXbs2T4d4nz3TQxIQW
yGSB0T5OfmrTi/l8UZX0OicD4M5P6EF6YPSq/t1tz/h3n7Dr44zdeI6eOrbIv3BR
7ini0mK6YD9+oBUCxvPHtKrUS0fHCA==
=sDbc
-----END PGP SIGNATURE-----

--w+SYfEWNEZ7TqPiO--

