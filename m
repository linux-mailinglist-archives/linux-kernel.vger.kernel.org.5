Return-Path: <linux-kernel+bounces-45076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB095842B70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918741F2529D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A215530D;
	Tue, 30 Jan 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGv+MwpS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5D12838F;
	Tue, 30 Jan 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637919; cv=none; b=McrekkDAmkVBWB/TQHUACBe5I2R1O4aG9gcWIEuxz7DK+C++2ZiMla0VdishDJJ9XdaMcRgcGgPsfPB1dVCbBpc6rmXZogALg6akavgdY80lBiIhkAyjAIpcZdPSG9neYhffXFC7ZjxQqNaGiD6Pqq4Z3z0Pf9vqhKLjal4C2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637919; c=relaxed/simple;
	bh=OHFyP+aVZkV7WimrQq/9Ode6oDV20xNJ8JZxFNZOJXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+VA7opj67d3PWnY70mDElvYQEtPJMmTFoggYtEm7HGjTiFN6o3XmENU6kXzHutjytl2bweww9xlAwkaUBLda6BbUN7aRF9Fe6IasMseS46O61cybsYHDfDB2+I/14vO2pXe8Z146GnvdipEMMSf7GERuv1FOvO1mUg8Gr3zKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGv+MwpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9799DC433F1;
	Tue, 30 Jan 2024 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637918;
	bh=OHFyP+aVZkV7WimrQq/9Ode6oDV20xNJ8JZxFNZOJXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGv+MwpSdmQpUE4V4KrGsARR0kZl/6LfSla4MYaIOS/7m5dJYsFNCOklV2tWNqPKA
	 SqzavLyRXyUwmo0/Uzs2JQLi9E0DnW7G5EAp3VwFxj2za1v2G0c3aVWgAVbhWcRLUg
	 fqNhtSPyAoyxgVo+tGYuj898fFG7WRtEG2sKk6Fp1udaVUxjrvOj78sPG32yeHiFn3
	 Z0Pdlo7wU+Nwhe8OAjOYuZLOhgz1yr1Fk4NaDOkSoSzcvaUrfbbWw8hX6A5fEzyRJi
	 OBlVS5cJtow93FGnk3HZi+Nu0RqrqDPBdqOJcG1fDOqhcWTCYO/5h6ypxItg261KMM
	 /gnBErPmEAAvQ==
Date: Tue, 30 Jan 2024 18:05:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: robh+dt@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	mripard@kernel.org, markyao0591@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] dt-bindings: display: rockchip,dw-hdmi: add
 power-domains property
Message-ID: <20240130-crispy-unmatched-afcce4aec17e@spud>
References: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
 <1ba8b40d-005a-4665-afd9-a4eacf3e3031@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iFecx6ZOPfafH63"
Content-Disposition: inline
In-Reply-To: <1ba8b40d-005a-4665-afd9-a4eacf3e3031@gmail.com>


--2iFecx6ZOPfafH63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 03:57:23PM +0100, Johan Jonker wrote:
> Most Rockchip hdmi nodes are part of a power domain.
> Add a power-domains property.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Fix example.

Just a note, in the future please explain why simply reordering the
properties constitutes "fixing" the example. I figure your intention is
to align with the (new) documentation about property ordering.

Thanks,
Conor.

>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/display/rockchip/rockchip,dw-hdmi.yaml   | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-hdmi.yaml
> index cd0a42f35f24..6f421740b613 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi=
=2Eyaml
> @@ -94,6 +94,9 @@ properties:
>        - const: default
>        - const: unwedge
>=20
> +  power-domains:
> +    maxItems: 1
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>=20
> @@ -141,16 +144,18 @@ examples:
>      #include <dt-bindings/clock/rk3288-cru.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/rk3288-power.h>
>=20
>      hdmi: hdmi@ff980000 {
>          compatible =3D "rockchip,rk3288-dw-hdmi";
>          reg =3D <0xff980000 0x20000>;
> -        reg-io-width =3D <4>;
> -        ddc-i2c-bus =3D <&i2c5>;
> -        rockchip,grf =3D <&grf>;
>          interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>          clocks =3D <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>;
>          clock-names =3D "iahb", "isfr";
> +        ddc-i2c-bus =3D <&i2c5>;
> +        power-domains =3D <&power RK3288_PD_VIO>;
> +        reg-io-width =3D <4>;
> +        rockchip,grf =3D <&grf>;
>=20
>          ports {
>              #address-cells =3D <1>;
> --
> 2.39.2
>=20
>=20

--2iFecx6ZOPfafH63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbk6WQAKCRB4tDGHoIJi
0vTuAP9WxYdzOWJ6nFmWTJinRfGUrrU/M+NVw8FPcWb7jZGUGwEAyMAn+FmqPdNy
c+ri0fW3UOjKkRIGQMzaUxqa0kHx1wo=
=nMOD
-----END PGP SIGNATURE-----

--2iFecx6ZOPfafH63--

