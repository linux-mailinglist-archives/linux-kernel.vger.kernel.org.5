Return-Path: <linux-kernel+bounces-2829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D661816289
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB728282560
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440C48CE6;
	Sun, 17 Dec 2023 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twzqiBMv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13E49F6A;
	Sun, 17 Dec 2023 21:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF3CC433C8;
	Sun, 17 Dec 2023 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702849419;
	bh=ttHVxZrSl0fzPqXZ/8WzdupCtgmAwzVZdpIUtIeSJd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twzqiBMvBBonVZLV/2nXWJRdlkicH/UcNNNRecOo0pRinoOSn3+4ywPuL+byA3TI7
	 jL2VhDL/HvKCO0JHjCDpR82blUWfrx1uoQ60IAsrTVQaXxGgIxdaEhV7nqkAFp6igE
	 xBDvqZVnDNI9ETHGAfNtpk5Yi55EZdPX0YIlY2XbgkIbqv4lImAxt73kELE2nv+Gfw
	 n1D2yywvZvdV8svhzqB9JAuzG7qO1Oyxg0gGTbmy1UWAWYs/Fqzi5PBJYdUrmWTc2u
	 KKK0MOc69dsL96sHo7YPi/0nN77KnQfDSeshj/Ld1vYnJD0Yr4xDeFUKKkS8NPYnig
	 YWLf1Sx096RHw==
Date: Sun, 17 Dec 2023 21:43:33 +0000
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
Message-ID: <20231217-hunk-cross-4bf51740957c@spud>
References: <20231217100741.1943932-1-javierm@redhat.com>
 <20231217100741.1943932-2-javierm@redhat.com>
 <20231217-bacteria-amusable-77efb05770a4@spud>
 <87fs00ms4b.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvs7ymLunVDhuv2O"
Content-Disposition: inline
In-Reply-To: <87fs00ms4b.fsf@minerva.mail-host-address-is-not-set>


--uvs7ymLunVDhuv2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 10:33:24PM +0100, Javier Martinez Canillas wrote:
> Conor Dooley <conor@kernel.org> writes:
>=20
> Hello Connor,
>=20
> > On Sun, Dec 17, 2023 at 11:07:03AM +0100, Javier Martinez Canillas wrot=
e:
>=20
> [...]
>=20
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - solomon,ssd1331
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +
> >> +allOf:
> >> +  - $ref: solomon,ssd-common.yaml#
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: solomon,ssd1331
> >> +    then:
> >> +      properties:
> >> +        width:
> >> +          default: 96
> >> +        height:
> >> +          default: 64
> >
> > Do you envisage a rake of devices that are going to end up in this
> > binding? Otherwise, why not unconditionally set the constraints?
> >
>=20
> Because these are only for the default width and height, there can be
> panels using the same controller but that have a different resolution.
>=20
> For example, there are panels using the SSD1306 controller that have
> 128x32 [0], 64x32 [1] or 128x64 [2] resolutions.

This, as you know, does not matter here.

> But answering your question, yes I think that more devices for this
> SSD133x family are going to be added later. Looking at [3], there is
> at least SSD1333 that has a different default resolutions (176x176).

That's fair enough though. I'd probably err on the side of introducing
this complexity when the other users actually show up though.

>=20
> I think that even the SSD135x family could be supported by the same
> modsetting pipeline, but I need to get one to figure it out.
>=20
> [0]: https://es.aliexpress.com/item/1005003648174074.html
> [1]: https://www.buydisplay.com/white-0-49-inch-oled-display-64x32-iic-i2=
c-ssd1306-connector-fpc
> [2]: https://es.aliexpress.com/item/1005001582340858.html?gatewayAdapt=3D=
glo2esp
> [3]: https://www.solomon-systech.com/product-search/?technology=3Doled-di=
splay
>=20
> > Cheers,
> > Conor.
>=20
> --=20
> Best regards,
>=20
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>=20

--uvs7ymLunVDhuv2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9rhQAKCRB4tDGHoIJi
0urZAQDdCk0O4EIhlmjwki+Jl0RqsfAslhFufBpKGUbKX4BvywD7Bb1X9ZmooXs8
SNyUI6YvgDljaImUgx8KU/1k38YgfQA=
=0pmm
-----END PGP SIGNATURE-----

--uvs7ymLunVDhuv2O--

