Return-Path: <linux-kernel+bounces-105408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884887DD80
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3F31F211DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55861B970;
	Sun, 17 Mar 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m531+jw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEA1BDE2;
	Sun, 17 Mar 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686698; cv=none; b=oSzKH3MwbY0glAr3KMvGrXe9x9cQKw7TXwL2Eqb+yzQ8lXei8fRchye3RUPPJivQoENU82B3k3bep6eaMctDGw7xZK9dclDTNf1dZx4ZuBoxVmUPuJcw1RiQN2p/bI30JdTKVNhvmzEVbgNlqi+WZsJyMbgo7eCaLCGu9yf9HFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686698; c=relaxed/simple;
	bh=040ClMnMOubXuR/GfXC2GDP6Mg4LDxBRovgnDWRi93o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+CB+Ok0dfL9titSrdGeOkTSDm9Lj+T12snEB3ACoTadGZiO5ESkkEoZVe/RLQ5Y/wedxGiXlAUoylO4kRmbbQXmCRW9jq2b0dk/PiAT1GsIFPN2b+MB2X4z/KofvHgY+KPe7FTIoBXMhwucXI791dJPH1L+1XCyc6hpcqCr9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m531+jw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E017EC433C7;
	Sun, 17 Mar 2024 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710686697;
	bh=040ClMnMOubXuR/GfXC2GDP6Mg4LDxBRovgnDWRi93o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m531+jw2JyDjNyV7Jhoj1LbSb9OTrwNHSA7NgGOMYZG4iO1QzxsBIygE4z4HHasVa
	 PRyNcJ4YVQqFXE9cDmN1pGNSicuOdg4EycAQK9zmTgLpTItyNzYpafXWqftlbFWcbj
	 7dlbIGrUAt97rjgcGMMzDHuBhs6/rCAEB51u/i/NnIoLmuP4su0fomoplcQEooqBY/
	 ELzp6bPJtDWd4PlImi1X54nTPIoB6vm7J5wh4WXJp5d/fQJhunId3uAqbEi+GmHjlS
	 eJ5RQWaDp2DScnEHPZ8RJxjQrv6wYTWuRi6bSjub54KlSZ0ANnlSYL0fU7PLSTc3kH
	 qKqmbhPbnoFAQ==
Date: Sun, 17 Mar 2024 14:44:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heiko@sntech.de, ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de, mchehab@kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH v4 2/2] dt-bindings: media: rockchip-vpu: Add rk3588
 vdpu121 compatible string
Message-ID: <20240317-writing-retention-c8a57e758737@spud>
References: <20240316071100.2419369-1-liujianfeng1994@gmail.com>
 <20240316071100.2419369-3-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3/L/mig3SrrmSlrg"
Content-Disposition: inline
In-Reply-To: <20240316071100.2419369-3-liujianfeng1994@gmail.com>


--3/L/mig3SrrmSlrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 03:11:00PM +0800, Jianfeng Liu wrote:
> Add Hantro G1 VPU compatible string for RK3588.
> RK3588 has the same Hantro G1 ip as RK3568, which are both
> known as VDPU121 in TRM of RK3568 and RK3588.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3/L/mig3SrrmSlrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcB5AAKCRB4tDGHoIJi
0lriAPwKRJpwfToOLfnybP9HSIVLYqpIOXUjdvkZuRIveQdYbAD+PUwBltLI0VFW
cH/YWdogBRxbQ5iNczKu1CNd8Lpdzgo=
=4u7o
-----END PGP SIGNATURE-----

--3/L/mig3SrrmSlrg--

