Return-Path: <linux-kernel+bounces-100338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A68795EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8931C21AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2E7AE5B;
	Tue, 12 Mar 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwAwZD7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32277AE77;
	Tue, 12 Mar 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253142; cv=none; b=syE4IrNWvyiZM3pqpBiHOhIUSEAXp/vbDdzWmGFieC6bLbi1V0izPG5warz33e+r4EXNaIO9aRCurRFr3lwF4FkdDL8KRVZgsnr6DB6VisRIoDotFBqsr5pDd7AUb8y7HZaNifjgqgLfiE5N446R4EsrwNdTTllpQ37JWj20dL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253142; c=relaxed/simple;
	bh=qcaliQaI4q5rgkTTGf/tDbUOaWz/QksttALwBTa+RbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xee1LviBUfDBoub6UO5jfMmtMIHk1z+Nc2d6+A0hyYdZXyTGXwwCfiS7HFDq8ynvEAsfPL7VvumWCXzWHDwUGj8d5bue5Urun/LRPybU30wJJdjRNYZnCVhC+f52+p3Oqy/koaUdAXPYfBo88/Ue7I8DuM1I1iHSSUPOdh6P2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwAwZD7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EE2C433F1;
	Tue, 12 Mar 2024 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253142;
	bh=qcaliQaI4q5rgkTTGf/tDbUOaWz/QksttALwBTa+RbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwAwZD7dikIcEo939lD9jYbaGLEcthcQyDIwId0bhMj8fEjmXx1LZuYbZo6sQrH/n
	 fOyIervzoPGmXIpfFQxTClPme9qSqUTpy5dRK7wabvazkopPz3MVG7g2RhCBeQKloT
	 5fH7fJ6GDJYQgR35JZEDm0TuCokOAG5whjWFN336o5h+gn5BoXV8jxh3Nt0sHa2wNY
	 jOBsZS1bkv15AQOxgKUkPJnffzagwCtWI6WodelT7r0JzAS+4/u930JQLnYwm91A0t
	 9FqMl5ZBi9GLoCzFQxSzRlkiqd/1GbaKO/mDjz8ltU6+GZlIDJfC8RvXazubfWsq3l
	 aYM/Rg9zf4nGA==
Date: Tue, 12 Mar 2024 14:18:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 4/4] regulator: axp20x: add support for the AXP717
Message-ID: <d9fd331f-90fd-4480-9d96-d15115d5c36d@sirena.org.uk>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-5-andre.przywara@arm.com>
 <4ae70e42-d345-4914-af40-5dfc9e2b3ef2@sholland.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="33rLmpi8FgeSxTrD"
Content-Disposition: inline
In-Reply-To: <4ae70e42-d345-4914-af40-5dfc9e2b3ef2@sholland.org>
X-Cookie: Oh, so there you are!


--33rLmpi8FgeSxTrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 05:22:41PM -0500, Samuel Holland wrote:
> On 3/9/24 19:02, Andre Przywara wrote:

> > The X-Powers AXP717 is a typical PMIC from X-Powers, featuring four
> > DC/DC converters and 15 LDOs, on the regulator side.
> >=20
> > Describe the chip's voltage settings and switch registers, how the
> > voltages are encoded, and connect this to the MFD device via its
> > regulator ID.

> This is missing support for the boost regulator.

That can always be added incrementally.

--33rLmpi8FgeSxTrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwZE8ACgkQJNaLcl1U
h9BO9Qf+L6+gXK5RHbVFoR3jorRoBXZraep2c80IwUHNvF6Tk3Z8NEt3CayouFV+
8+gUXVojszi/4jftrmEanBOxrS1OkoIykPimqKV1H+jBc2y5FdubBjMsPD5dwVls
UGk1+poTTlnCtUxhT+SY1yVFXT6ELnjg086txX+d16EGWoddHafq+w0wocCCMm4h
t2MgdK1laTRVT+1U5LqqyaZnV9Oe2tuO2/iE6RZNWctOkWuSdsffr321Ml8eOeg7
Z6zftvSTMnVbx0Wijf6ZtQKwmXMd7OdY1tkm7Oh3JI+K7U5LUZa7p8dc5qg/Oio/
uTdcJoU7UYzmPmRpdRYS+CHQQszQdw==
=zoNJ
-----END PGP SIGNATURE-----

--33rLmpi8FgeSxTrD--

