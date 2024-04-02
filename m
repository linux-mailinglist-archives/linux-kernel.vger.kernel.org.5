Return-Path: <linux-kernel+bounces-128457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC966895B14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8121C20A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0364D15AAC4;
	Tue,  2 Apr 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDkYPJtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454915AAB2;
	Tue,  2 Apr 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080181; cv=none; b=UVPp1nS68IKPImLxtgtChzq5YxVKfAtEkxq8Tq8DWi+xNbKlCtE6S0nyBS2Zy4Ds7b9ZsEMyLybFmEc5Q2VDmxvI5kcy1nmy1z6rx+HMeyMX0AtrZpK9hlvnN/7sq38e8CTZSMEe1R5gVlF8HI0nkvf6EhMGxQUBOnMNHaYts88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080181; c=relaxed/simple;
	bh=566AJgdZXmrFN+ekvp09FWTpHUyB+KGinr1X4+QWtJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUYp97gqRxw1/qk71qXxKS4kgOi0kYyt+BagtVMxBdhw5YzM1URMIuy8A2sy9CQq4h0dLAPSN9vxRJMqIcARrVFoXDavgdKNrdJg+AjskiDaUzYL6mWZOEbkFhbhsyg1j4hR8JsMXK9fxh6IDC3o4AKfYdLQ1scP3mEDQzfTiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDkYPJtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A090C433F1;
	Tue,  2 Apr 2024 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080180;
	bh=566AJgdZXmrFN+ekvp09FWTpHUyB+KGinr1X4+QWtJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDkYPJtl861/dTLCEZH4Eil9YfUeRUJaD9NFyUb8A7Sj/SSP/rdPdtZ9UrYRt8pAp
	 wp7eI2cvrPtUIQjxdAqg76ULw004bo+4RAvyy+1n491MhL2LHgajPkAU10TpE+n5v/
	 5HH4F0VmA70YC1j0DKtJl+kXIowosYYn5iXFXxd6V88/SJwTDPnCSup4+zuefWDhab
	 kilRAxZ1WXl9HYOV/WAxr+7sgfrixLbbQtDOFiSpsmnqAn/hZmG7ktfVbmn17VHhVX
	 Zy3FzP45PWq4TG0ojT4sxkjY450HOW+Ovr1wl+o1aDPqVW7flNe4IATw2b62eiPKOc
	 pYBf5iK5LUs/Q==
Date: Tue, 2 Apr 2024 18:49:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Add R-Car V4M support
Message-ID: <20240402-roaming-tablet-c2ac92e3f34e@spud>
References: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RgvgiAsiJwyNFvDx"
Content-Disposition: inline
In-Reply-To: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>


--RgvgiAsiJwyNFvDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:36:05PM +0200, Geert Uytterhoeven wrote:
> Document support for the Compare Match Timer Type0 (CMT0) and Type1
> (CMT1) in the Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--RgvgiAsiJwyNFvDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxFMAAKCRB4tDGHoIJi
0hEbAP9Ey3DDiFRcd/uXh82t6Zl2cmLLKCqJDt9tI//7dXlg4QD/Yx9Rxum1O0js
PuPI7WN3qyYAVZ/E3zUMPWP0iAKHhQs=
=3cvo
-----END PGP SIGNATURE-----

--RgvgiAsiJwyNFvDx--

