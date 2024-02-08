Return-Path: <linux-kernel+bounces-58557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A084E803
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173FE1F2D66B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B224B34;
	Thu,  8 Feb 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+9rN5Ln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A520DCD;
	Thu,  8 Feb 2024 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418157; cv=none; b=d4rVEZGGsrTt9i6GkRcPpwrlYKyM8l33Gl1pG2rPLStsL7YnurWOoekbMAD/LucL97UVj++gpJyRMgREWfQbqqRnB+EUXZ8g936A6heZGSx4rey5fuaBSPk3u46VIG7BELhhqgJotAHLC6de35Pc3fQNQ+L7QhTyrH52sio3n4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418157; c=relaxed/simple;
	bh=pGYQLPjZv7rykpN/0QEQ5VmbaThkoGQZ3hKi9ODsEb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFSVrxifzfuuy+H7pp2nJrd5PChQq0QHgbknJlbPMQ4U78vXT+CKhXipUav0xtEks5Nru1lCV1AfUSSojWkZS6TwwZHLa6ntrTJrcUSUEoj1dEfn7p+i5yBgGsm3557bBELPjK6SoaY21GKXW5p5vltR3GH9bzSgKj7Gz27+wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+9rN5Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64471C43390;
	Thu,  8 Feb 2024 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707418156;
	bh=pGYQLPjZv7rykpN/0QEQ5VmbaThkoGQZ3hKi9ODsEb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+9rN5LnWApR2bGtYvhy3yPoZPwm+UGQNmmHnt5bOQAHe/vb60JGAqJwb/2ihNj2q
	 ElPZypWqm/xqNu2L8zoSKR1QSKGu4IGwAoGHrd0gwMVDsZvaSd6rhEGko5QSTCtiip
	 DjghH+8vFgbLOIy6YaWBcIDzfh1tqSpIAGxtEz8/agvYACCxzIzpzCcftm65bSuw2o
	 YVKV6RAlN3RN0IzPpeBFMsFzJUT9n9Wl7rjqvPixCFUWOrSqx+gSxBz+6aOPaoDzj+
	 njFflNaeHksNxluvRskKHFu8+qxB6O9OTR6u5rowNFDBechGraU/DOlhu1QO1mR+sY
	 wMs1JqHVdLUZA==
Date: Thu, 8 Feb 2024 18:49:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>,
	alexandre.belloni@bootlin.com, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, claudiu.beznea@tuxon.dev,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Message-ID: <20240208-acuteness-visible-b60cd37c2b32@spud>
References: <20240208092015.263210-1-dharma.b@microchip.com>
 <170740748922.3230402.17318224112819715619.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r4efttuvWDjAulLz"
Content-Disposition: inline
In-Reply-To: <170740748922.3230402.17318224112819715619.robh@kernel.org>


--r4efttuvWDjAulLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Dharma,

On Thu, Feb 08, 2024 at 03:51:31PM +0000, Rob Herring wrote:
>=20
> On Thu, 08 Feb 2024 14:50:15 +0530, Dharma Balasubiramani wrote:
> > Convert the Atmel AIC binding document to DT schema format using
> > json-schema.
> >=20
> > Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> > ---
> > Note: I get the following warnings on latest kernel but not in 6.7.
> > Should I be worried?
> > usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-file=
s] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [=
FILE_OR_DIR [FILE_OR_DIR ...]]
> > yamllint: error: one of the arguments FILE_OR_DIR - is required

Hard to say, how were you envoking the command? There were some issues
recently with dt_binding_check, but I thought those had been fixed.

> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/interrupt-controller/atmel,aic.example.=
dtb: /example-1/dma-controller@ffffec00: failed to match any schema with co=
mpatible: ['atmel,at91sam9g45-dma']

But you didn't see this warning?
I think you can resolve it by just dropping the "user" example from the
binding entirely. I don't think it adds anything at all.

Cheers,
Conor.

--r4efttuvWDjAulLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUiJwAKCRB4tDGHoIJi
0sS9AQD3W68n9wb+XelY1CiPyQBNW4qjE+93A8BUi7FjnLX8tgEA9kvG6FUrzJ6Z
Pf80Be18OKj8VCwO4NCuzfqcDK7XKAc=
=Jla7
-----END PGP SIGNATURE-----

--r4efttuvWDjAulLz--

