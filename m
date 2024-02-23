Return-Path: <linux-kernel+bounces-78971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579A861B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0553DB222B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226AE143C64;
	Fri, 23 Feb 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EElgjbta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64987142636;
	Fri, 23 Feb 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712542; cv=none; b=FQiqA4axsGl9Hii8GrhCPkuog/1fGLw0nZZydQUfD/r0USYx9CF5giX4XRGAEpH2LhkGQdo04Uwj0EvIhBjgwGAiKa/2j/OtB4hhmgXdJgwwC3FmY3D2ChzEme1hgqFwWN3pAsEmbzJFHLKq9mHA+Zp+pNteS6bhq/auNagyVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712542; c=relaxed/simple;
	bh=Cqe8LWCCXqLI5nJcTymn6aKYDyIH6gIwWLFJZo8+z3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEeGFTGdUpzqnbVXcQhTu8NP0zZeoNygsJiN686eORrzc2zA7dksOrgiGEloy9Kug3vCf+J/7/6v43Hmueij7i6z2lNJac1gRlw68XIXUVYzSac2VkAwcd7AP5Tqmltrv2E5C9tKDF0eYegY888tnFsv2ePbfhXdEdVbEZMBQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EElgjbta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F09CC433C7;
	Fri, 23 Feb 2024 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712542;
	bh=Cqe8LWCCXqLI5nJcTymn6aKYDyIH6gIwWLFJZo8+z3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EElgjbtaShdUYdyHHnFLSRzMCcY/qTZuD/DGBY+Y5FOrU30PoSioGwAHJTe+P/7X2
	 CVRwj9barJ2QL4JrjzdV+vfmfBGJBde3AtH7gH9Be86Cd/VA9OjOULGymAZpzvMyCT
	 eJlKt2xf0+fD7oJMuwbUvGbqG31CQkUAt5CGa60z/0UFFjJea+8WkQAgIuxTCrtVx/
	 i/uf1izem6KHVFLxNbn08EUJ4MGtvhunnOU9kzlg5xBOmLv22Sq/4sXGVo69NrFhcM
	 TeDNJ8mtxQNXnNafq4moPHsbxLuWAZMazFEmAcfhT5pubkzWpWcqLX8NwoY/mORpdo
	 bRnN86oYQOZBQ==
Date: Fri, 23 Feb 2024 18:22:16 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add Crystal Clear Technology vendor
 prefix
Message-ID: <20240223-prepay-stadium-f09044e3e123@spud>
References: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
 <20240223134517.728568-2-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqbEmhW4lbBDVPaW"
Content-Disposition: inline
In-Reply-To: <20240223134517.728568-2-jeremie.dautheribes@bootlin.com>


--tqbEmhW4lbBDVPaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 02:45:15PM +0100, J=E9r=E9mie Dautheribes wrote:
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
> include "cct" as a vendor prefix for "Crystal Clear Technology". CCT is
> the vendor of the CMT430B19N00 TFT-LCD panel.
>=20

Acked-by: Conor Dooley <conor.dooley@microchip.com>

And add a
Link: http://www.cct.com.my/
as that actually explains why "cct" is the right choice.

Cheers,
Conor.

> Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index fef2e12b504e..96e47742e250 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -248,6 +248,8 @@ patternProperties:
>      description: Catalyst Semiconductor, Inc.
>    "^cavium,.*":
>      description: Cavium, Inc.
> +  "^cct,.*":
> +    description: Crystal Clear Technology Sdn. Bhd.
>    "^cdns,.*":
>      description: Cadence Design Systems Inc.
>    "^cdtech,.*":
> --=20
> 2.34.1
>=20

--tqbEmhW4lbBDVPaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjiWAAKCRB4tDGHoIJi
0teoAP4iP4DoqDwhJ9zjgyRVfThghCGI8b7Mrw0n/J2/EBLjRgEAmE3S4BaustQN
Vnu5lUdAAJ9L0D2ZLHvC+BoPqwMcTww=
=BaSE
-----END PGP SIGNATURE-----

--tqbEmhW4lbBDVPaW--

