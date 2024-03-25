Return-Path: <linux-kernel+bounces-117767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10B88AF52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF4B1C616F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0ABD52F;
	Mon, 25 Mar 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/JFiSKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFD4A33;
	Mon, 25 Mar 2024 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393523; cv=none; b=Cxdg35NXqJNyjNQIf/g/UklVciOLlWQkn6y9jtYjR7Yafy+rn12XhzlFm3tgOhOMYEBQqGckx153vS1xavCl8amsacgLSiA50yymaA7xMk47+B6dIhiSQasmIOaU6ZXYP7U7RWrZ/fBSLW4ozTXh0bfXQmUfCnNxuT8CIygSe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393523; c=relaxed/simple;
	bh=imG8xgxcPx30/lu9EJ3K96nuumxUx7F7pd9ZvWzDEV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEAKLqGBauc9Zk1VdWd4yemX1PnQNPiuovxDO+GXmPgmo5iP0WCLHXZmmGSX44f6WYyKhXXCuYc0VW9xg5ymwbyUtEWpydeKSSe/hdeyl+g5D/qLQq/itGAiLpMGQRaKQVHudDyUvnynp/rARmIyEDYxudpWOFmo3kg8HZXnde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/JFiSKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B2C433C7;
	Mon, 25 Mar 2024 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393522;
	bh=imG8xgxcPx30/lu9EJ3K96nuumxUx7F7pd9ZvWzDEV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/JFiSKoWsiSp0ACzCjFZpKAiiw5bw7e7o0gffKtyrp1Le6QiasdS2VMaw+dcPEyW
	 i6CaFyzqAXBBahSk6mspmgg46bbIGM4MCYXc429wnHJsrBJf8ldSMv142nAt7LqTp2
	 nstYltr3iAz++qCRZNwwYQ/0abtHsXWl5MiV00lbBAmXKunyLMTO8J62i57htp3gMf
	 tcaDwv/CDNkb7B9TYayQefSi06TQqYyttqRurO2//9biidVQNxr+ESbD+4za11wlmz
	 eKjw7bNqRm4jNM2BzfYfTdi0OLYbfQkenWiTqEzIPqaOd0YHogecZDiq+TJgT+QsB9
	 3GGkejg4dZBgQ==
Date: Mon, 25 Mar 2024 19:05:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: health: maxim,max30102: fix compatible
 check
Message-ID: <20240325-partake-nearby-4e129032a347@spud>
References: <20240316-max30102_binding_fix-v1-1-e8e58f69ef8a@gmail.com>
 <20240317-bakery-numeric-a34b928efa6d@spud>
 <20240324110715.0832e6d6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SaQXNpdG6TnkXA9f"
Content-Disposition: inline
In-Reply-To: <20240324110715.0832e6d6@jic23-huawei>


--SaQXNpdG6TnkXA9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 11:07:15AM +0000, Jonathan Cameron wrote:
> On Sun, 17 Mar 2024 14:37:39 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Sat, Mar 16, 2024 at 11:56:57PM +0100, Javier Carrasco wrote:
> > > The "maxim,green-led-current-microamp" property is only available for
> > > the max30105 part (it provides an extra green LED), and must be set to
> > > false for the max30102 part.
> > >=20
> > > Instead, the max30100 part has been used for that, which is not
> > > supported by this binding (it has its own binding).
> > >=20
> > > This error was introduced during the txt to yaml conversion.
> > >=20
> > > Fixes: 5a6a65b11e3a ("dt-bindings:iio:health:maxim,max30102: txt to y=
aml conversion")
> > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com> =20
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Applied to the fixes-togreg branch of iio.git (which I'll rebase on rc1 o=
nce available)
> and marked for stable.  Not really a critical thing to backport, but mayb=
e it is worth
> doing as risk is very low

Yeah, I figure stuff like this is worth just backporting in case someone
is using a stable tree to add some new board.

--SaQXNpdG6TnkXA9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHK7QAKCRB4tDGHoIJi
0sjGAP4q/vqH88hSy9HXL/nd2BnMWzzYbl8iHBLAShDeoazxqQD/c/M5csTskIJh
JJU63H9Qfuj0zPvcDluLcbuq9eVSnQc=
=XyhC
-----END PGP SIGNATURE-----

--SaQXNpdG6TnkXA9f--

