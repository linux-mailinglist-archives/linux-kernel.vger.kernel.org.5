Return-Path: <linux-kernel+bounces-48787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9672084615F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DA3B2A4B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C787C6C1;
	Thu,  1 Feb 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFQ8HPYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20484FC7;
	Thu,  1 Feb 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816840; cv=none; b=k5YOYB48goo4z9heRGCnmndW6PuUpii0bYoYXE6IyUvTmQckIkQCCterDaFAl4M4ruC4bDvR51nejF6MhMR/DmsM2M97xx2a4G1uw9uoceaM14JcRWx2dWa6KCoOzmFj5QLPTDzxd/4EqoZNExG5dFk6PQ9kIzOYwFMDFtmE1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816840; c=relaxed/simple;
	bh=jiEbi8QNujD3qdmkGJ2lzsWGIhAaTaj5nJA5MFhPzIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFFauZja26rTnoexmQk1d+f+gLvkKmXd/z8zlvPMUp3mPSrzPl/grabNrmW9twIjyRymCDUkF3ZN5nRH4RGITHqC72T8c4OCuyZJtoXY65yRNtODkPz4JqOe1OHk818/Tz1jr6qYM0CPkBKmucPRicU9bb9HKzhEeg15Y+3Gfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFQ8HPYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BBBC433F1;
	Thu,  1 Feb 2024 19:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706816840;
	bh=jiEbi8QNujD3qdmkGJ2lzsWGIhAaTaj5nJA5MFhPzIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFQ8HPYfLUZ9XI/F0aOi4FyO+QDE0GrDcw+xEVqwTRymAhcZ353kD6nFNd0BdJyqR
	 yiXGUiNIZMiYjJW/WRivqt5UXGkzNP9fPWRq1B66aZ6IvGHin7KOeuWM79UJz4tAzJ
	 JiRS9ooAQkyqelgqNjBWPvmDndxjxyYeNiNxCroc10DIYm/NTIn2cYuu+oERc/DZi6
	 wSUe9XkqlLYzvw8mt/twkKtgzYxpxAUq81a4csfopthA00AKcPuTkM15wNREubYQgT
	 Vg+J5TAuZug51DQH+0C1Czc6JqOWOag8s0bSLq0yIhyqAWIM4D3snS5M2sg2nVd9/J
	 f3wlkV9EzFckA==
Date: Thu, 1 Feb 2024 19:47:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: robh+dt@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	mripard@kernel.org, markyao0591@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi:
 remove port property
Message-ID: <20240201-raffle-frays-6b5a47faab69@spud>
References: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JSTTUbvKmVnod5va"
Content-Disposition: inline
In-Reply-To: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>


--JSTTUbvKmVnod5va
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:14:29PM +0100, Johan Jonker wrote:
> The hdmi-connector nodes are now functional and the new way to model
> hdmi ports nodes with both in and output port subnodes. Unfortunately
> with the conversion to YAML the old method with only an input port node
> was used. Later the new method was also added to the binding.
> A binding must be unambiguously, so remove the old port property
> entirely and make port@0 and port@1 a requirement as all
> upstream dts files are updated as well and because checking
> deprecated stuff is a bit pointless.
> Update the example to avoid use of the removed property.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Changed V2:
>   rename title from deprecate to remove
>   reword
> ---
>  .../display/rockchip/rockchip,dw-hdmi.yaml    | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-hdmi.yaml
> index 7e59dee15a5f..391c2a7e79de 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi=
=2Eyaml
> @@ -97,8 +97,8 @@ properties:
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>=20
> -    patternProperties:
> -      "^port(@0)?$":
> +    properties:
> +      port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Input of the DWC HDMI TX
>          properties:
> @@ -108,11 +108,14 @@ properties:
>              description: Connection to the VOPB
>            endpoint@1:
>              description: Connection to the VOPL
> -    properties:
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Output of the DWC HDMI TX
>=20
> +    required:
> +      - port@0
> +      - port@1
> +
>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -147,7 +150,11 @@ examples:
>          clock-names =3D "iahb", "isfr";
>=20
>          ports {
> -            port {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
>                  #address-cells =3D <1>;
>                  #size-cells =3D <0>;
>=20
> @@ -155,11 +162,20 @@ examples:
>                      reg =3D <0>;
>                      remote-endpoint =3D <&vopb_out_hdmi>;
>                  };
> +
>                  hdmi_in_vopl: endpoint@1 {
>                      reg =3D <1>;
>                      remote-endpoint =3D <&vopl_out_hdmi>;
>                  };
>              };
> +
> +            port@1 {
> +                reg =3D <1>;
> +
> +                hdmi_out_con: endpoint {
> +                    remote-endpoint =3D <&hdmi_con_in>;
> +                };
> +            };
>          };
>      };
>=20
> --
> 2.39.2
>=20

--JSTTUbvKmVnod5va
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbv1QgAKCRB4tDGHoIJi
0qLhAP9gtjdsYMXoFDWX44wSIhRtbVkUz0tifEeaurm8VymPqAD/brjU7Mi8vOW3
Mr/QJdIlrf73AZ+4HC3l5fUMhqFzKQM=
=bE0f
-----END PGP SIGNATURE-----

--JSTTUbvKmVnod5va--

