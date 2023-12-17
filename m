Return-Path: <linux-kernel+bounces-2804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20C816231
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C01C20C54
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF3481D2;
	Sun, 17 Dec 2023 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJYeMndj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D979481B7;
	Sun, 17 Dec 2023 20:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50317C433C8;
	Sun, 17 Dec 2023 20:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846348;
	bh=QZQeR7+cmdaZ25HquXncvbA8GkAKTHnMuVHURT1RTW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJYeMndjYAHRUb5DIgrE73sgH6cCgJgPn3HWmWmgcdnbyVv5sMwxSuLTEotn5eSjQ
	 D2tDqW8OMwyDzL8h39TXrikx2aA4nb9Yty38fBI3fxqtq5R6HgX31gRHQ++Fi/BUbq
	 aQ+yGk/c5S8qixlRVGgsgAzzV5arRGEcx+Z7RX/ZONmqITSWIIMnK3BvSF/iDL9Vrz
	 /9NKrJZjm9WkjAvMEN823qSHl+TdbF21jVW4WfqE+t3TXhFEjIjVDKAK29LIpS41Oj
	 Nubkk8zF2czicG24wwGaS4x92wD259TvlgJ03/7zl5lgrLL1zkeo2O3R92ON3Q6Lu0
	 VXtgMHr1NfGKg==
Date: Sun, 17 Dec 2023 20:52:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add SSD133x OLED controllers
Message-ID: <20231217-bacteria-amusable-77efb05770a4@spud>
References: <20231217100741.1943932-1-javierm@redhat.com>
 <20231217100741.1943932-2-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HF0go/XKn24LL76Q"
Content-Disposition: inline
In-Reply-To: <20231217100741.1943932-2-javierm@redhat.com>


--HF0go/XKn24LL76Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:07:03AM +0100, Javier Martinez Canillas wrote:
> Add a Device Tree binding schema for the OLED panels based on the
> Solomon SSD133x family of controllers.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  .../bindings/display/solomon,ssd133x.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd=
133x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd133x.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> new file mode 100644
> index 000000000000..eee8d8c9ca35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/solomon,ssd133x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Solomon SSD133x OLED Display Controllers
> +
> +maintainers:
> +  - Javier Martinez Canillas <javierm@redhat.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - solomon,ssd1331
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: solomon,ssd-common.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: solomon,ssd1331
> +    then:
> +      properties:
> +        width:
> +          default: 96
> +        height:
> +          default: 64

Do you envisage a rake of devices that are going to end up in this
binding? Otherwise, why not unconditionally set the constraints?

Cheers,
Conor.

--HF0go/XKn24LL76Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9fhgAKCRB4tDGHoIJi
0nZxAP9pT/ccPBJYrxczjDS0WHcjCAxC4mgf7EWpR9GMyB6OZgD+NL3uf89+ZHzM
obuRpn37wflN/lO+6u+cQFe0RY5IHQY=
=pmCw
-----END PGP SIGNATURE-----

--HF0go/XKn24LL76Q--

