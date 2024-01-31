Return-Path: <linux-kernel+bounces-46741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71756844371
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B4B24C46
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FA12A14C;
	Wed, 31 Jan 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leXEIIdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778B80BEF;
	Wed, 31 Jan 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716440; cv=none; b=IlqnAioajTm6ApbZzTFIdEJCNja7uYU8swa1P4zJDwiBEMzLxCBDCTqsOfw5Q26vKA0/mMDdx4vfoJQNW3cU4l9j4aNeu5D+KKHhMlfRjAknps6mkJp/JLu5Op2LRqQ7wwN+5GLcFC99BfoDK5H8aBp5Nhq0G+MN1W+VPbeAp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716440; c=relaxed/simple;
	bh=UniOl+JmqBJs3N7JkzLKxtaT2fSCqC1agl/ADUxyc38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTWl4HDD5In7Tl5nQbd/JQkUFNKFp+DgZGedKcjo+WIHknJYPJ2ir1vBzr10VzUe4mVQFJW60nI5G3aII3ev26GFQ6Zovjjn1bFiK7Tu24t0wYN9/IeGK1OIXIfP6IfztRp7qUZ4V4EyXYvfLYNSgiYusRUnDDpOGxqa//JOCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leXEIIdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4B8C433C7;
	Wed, 31 Jan 2024 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706716439;
	bh=UniOl+JmqBJs3N7JkzLKxtaT2fSCqC1agl/ADUxyc38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leXEIIdz8FN/YNq5ERSujskQfEb1FbMhoc3mIHN2GCQa5DU+j4TPkmPaauRiCon9T
	 kcBVY9gUICedtjhHgaVU4/cpDjnxrSjNqrRN3RE5thMYSGK+kju05eB+up4SM5QeME
	 3NdIRI6il2sj2k3u1oUfSxji/1aHYP7x7SrjrQe3a35GgqxJnDkcFIwAz/ITR4/vsc
	 C5w1vbV5ekNaxe5e8pRuUaGsao4WuFzgOuLgyNFy2q1fEPJ3EvRb6UiTsE5NS0Onre
	 Qihp0+W8hXfaf/O3LlrEUtKoi2LIzDBBwDLNjS4nlwkn7+xW16gWWyPlc/Oe3niXHa
	 +7+wUX3g2aKZg==
Date: Wed, 31 Jan 2024 15:53:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [drm-drm-misc:drm-misc-next v2] dt-bindings: nt35510: document
 'port' property
Message-ID: <20240131-gap-making-59055befaf04@spud>
References: <20240131092852.643844-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OTnjAHXq7E9wBgWK"
Content-Disposition: inline
In-Reply-To: <20240131092852.643844-1-dario.binacchi@amarulasolutions.com>


--OTnjAHXq7E9wBgWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:28:44AM +0100, Dario Binacchi wrote:
> Allow 'port' property (coming from panel-common.yaml) to be used in DTS:
>=20
>   st/stm32f769-disco-mb1166-reva09.dtb: panel@0: 'port' does not match an=
y of the regexes: 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


>=20
> ---
>=20
> Changes in v2:
> - Rework the patch to drop errors found by command
>   'make DT_CHECKER_FLAGS=3D-m dt_binding_check'.
>=20
>  .../devicetree/bindings/display/panel/novatek,nt35510.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35=
510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.=
yaml
> index a4afaff483b7..91921f4b0e5f 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
> @@ -31,6 +31,7 @@ properties:
>    vddi-supply:
>      description: regulator that supplies the vddi voltage
>    backlight: true
> +  port: true
> =20
>  required:
>    - compatible
> --=20
> 2.43.0
>=20

--OTnjAHXq7E9wBgWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbptEQAKCRB4tDGHoIJi
0lmqAP9d7CWkSjo5G5rBveppth6+9eZOCItnUiJ1RmQBGMywiwD/WqGtiZfAmocN
H09ibibMntUfs22aOpJVsigqLYtfAA0=
=dN+W
-----END PGP SIGNATURE-----

--OTnjAHXq7E9wBgWK--

