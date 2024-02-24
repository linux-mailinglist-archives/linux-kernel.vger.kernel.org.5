Return-Path: <linux-kernel+bounces-79813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECC86271E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8303C281B59
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102384C60B;
	Sat, 24 Feb 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMdVmFg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72F4C62A;
	Sat, 24 Feb 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804227; cv=none; b=ZbI5S5OvOj5I5H9IfZf1u6X91/IM/XI1iwgUWTbs/hupFdtCPsERZsgtDQDPggQQMOeeued3d6gh0RcLZs9FxFGs54s3Op/EWY1vgSd8ZyQWLcUpqhAEj7CvogkQxOO81Z8huYCc1+dWp7tx+gnSfy+QunwoUS4dB9vNo0bLZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804227; c=relaxed/simple;
	bh=jUjbcrmBdSoT6UEmaAHxZ4HtVcfMr4YFxSXUAg99ZDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llrXH4Rl122E5LjzdRMnLnCs8KtHPT5WGCIRBAoTaj2CBHPVVn0IO6iNxLqryDhc2EvTSTdxyz9+ITonSjFbuvhYHwxPMgshZCWIa3a6lRuX1+nEYcpRza1Jn3w1Mn1paALTNfAhN65/iub2YmWxFF266hD/FmpGEFZhyQ9rEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMdVmFg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD87C433C7;
	Sat, 24 Feb 2024 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708804226;
	bh=jUjbcrmBdSoT6UEmaAHxZ4HtVcfMr4YFxSXUAg99ZDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMdVmFg9SZXsnZF/G2iL5OmPjbm6KM+K30qKAmoemFHExQw1oR+fGQV6prRgvctoz
	 HoP+F2G1lBKS70IgswLX/5eBVcT8erZxLcYyac6bb1fwJTTc6l+7QMkXs6jvYSzRmh
	 eW8VT29nXbFcPHmwM67idULOK02xbqLdO5+yKbZOZT0HK+obgSHtEf48WxyiFH4AgY
	 bryzL5Lg0WwV0J4YLVoMmm0NYTFPI+smnnpGfgKVf9TyIp6dvSLPOtCWIk/QIGn87/
	 ofFZ1kyy11w3bfyOxoZmk3BftWoHqDZCPNDDaX5e3VSOX/jiKHxmDBDB56pnDxoAki
	 osMone8Bz8GQw==
Date: Sat, 24 Feb 2024 19:50:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, tudor.ambarus@linaro.org,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/39] dt-bindings: crypto: add sam9x7 in Atmel TDES
Message-ID: <20240224-willpower-crewmate-7b433999d01f@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172445.671783-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wAYqK0v+us/roCxH"
Content-Disposition: inline
In-Reply-To: <20240223172445.671783-1-varshini.rajendran@microchip.com>


--wAYqK0v+us/roCxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:54:45PM +0530, Varshini Rajendran wrote:
> Add DT bindings for atmel TDES.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--wAYqK0v+us/roCxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpIfQAKCRB4tDGHoIJi
0kcZAQCLTx3n0ifSkfQ1CzJAHTEbTiGBk2r3CIY0lS8cZ4ZM2QD/VizY07kOiBzM
c4Z1DJjpFBDSAnmenvYYgAIV+4O9tAs=
=Av39
-----END PGP SIGNATURE-----

--wAYqK0v+us/roCxH--

