Return-Path: <linux-kernel+bounces-8545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF5081B937
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B391F2776D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251705992B;
	Thu, 21 Dec 2023 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mabOuG0i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECF58236;
	Thu, 21 Dec 2023 13:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E897AC433C8;
	Thu, 21 Dec 2023 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703167119;
	bh=P5LqH2Y7SWkKlwY3y6xyxJudJDH6IG5UM2gLj1IEnsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mabOuG0ivwRlO6G4naCOKEZhMk2uR1LZdjj+a9DUlp0T7/PrKZiLNXL4AIt5KCvaO
	 H7T/aA+uHk2GAokUTNGQ6M0Ncepd824C9Ejf+f5xRqEEkNf4nAyQZBEEMWUdfqKvJ6
	 6FSsNIrjb4KiYuhWaVA86cypqaqRA2dk6cqsuduZNxj/6ryGNliWHkU+mUVggy+0DN
	 jtqcmJDcfOzwWA4hzor5T2NNCtL7F6XmYqZRudrGGHJwDx2RIdCUAcQmRxn0TXdtRH
	 guDu5adgXbyWiD4ppjx3rJ/LjE460/Y5oxvSBou6WI8hkdRhTY9wEi0vv9th1tg5f4
	 EjOhJrkqtlRSA==
Date: Thu, 21 Dec 2023 13:58:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <f1210b31-25af-4cbd-b73e-2a72aa6c41bf@sirena.org.uk>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-2-xingyu.wu@starfivetech.com>
 <20231221-saddlebag-tricolor-d02a17d66795@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Je10eHLduGuAy2yb"
Content-Disposition: inline
In-Reply-To: <20231221-saddlebag-tricolor-d02a17d66795@spud>
X-Cookie: Results are not typical.


--Je10eHLduGuAy2yb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 21, 2023 at 01:53:00PM +0000, Conor Dooley wrote:
> On Thu, Dec 21, 2023 at 11:32:22AM +0800, Xingyu Wu wrote:

> > +  cdns,i2s-max-channels:
> > +    description: |
> > +      Number of I2S max stereo channels supported by the hardware.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 8

> Mark, is there no common property for this kind of thing? That said,
> there's one device here so the number is known at present.
> Another note, this property is not required, so it should have a
> default.

I wouldn't expect this to be a property in the first place, as currently
presented this is specific to a single instance of the IP in a single
SoC.  In general this is something that is obvious from the compatible
and doesn't need a property, it's only plausibly useful for Cadence and
Designware which is a very short list of vendors.

--Je10eHLduGuAy2yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWERIkACgkQJNaLcl1U
h9BcGQgAheM9EAPMjgBTsuBAaQIPvCR4hci5mQpv4BAqe9xyf3i1kt8jh0saB1Ml
+ziuaF1AQrBoBkJSd3RSSfTgeOCplifgqtoVthIhI4LUyIYK13WCbvhVG92shYYv
ASQfO03KLvk559mAIHA/oW62eF/YzEpTHJsorSHUHeWoqAltTitK/51n8QAHfeJP
sukuTUG9MgYX+t5mA+qVKl6NRLvcFaw9hosbXSqaTXPwSAHDn/8LHMiTcsFu3BBE
XvmoBdRS0hYA6Ek5er3o22Td8pNjS9/uWyO/ZYYdURpPx6/foStm12WLQcsneEEN
B8egzLRTfz4+EzLBIJw5q1Um04byyg==
=bQAA
-----END PGP SIGNATURE-----

--Je10eHLduGuAy2yb--

