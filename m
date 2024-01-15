Return-Path: <linux-kernel+bounces-26248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E022982DD80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8CDB21C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD817BCB;
	Mon, 15 Jan 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSmmcdu8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435517BB1;
	Mon, 15 Jan 2024 16:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFB1C3277D;
	Mon, 15 Jan 2024 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705335432;
	bh=R7wYv89WuvE+UdIk/00VqgnE5zrK2xX9FX1H5cIHu4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSmmcdu8Ut/hJbGoxzczBG3o82C+I8aeXFwsON62BLraBsvzsCAShnE03PlTlzLLn
	 CPmHxbM4A+kCVFM0v9EQAVSTW6PUyTV1611SCU4ElEjwGi+3edZk7gLTCLNOUp1F3B
	 1BEo5XovFEv8Xwe6bX8hwBGOVEHbuI8wO2pXjuDlwztaN9FBASREtXuD8N+pVcuAP7
	 DhmWCTkRnyJWPQbKsguH7KuWWum4homKcB+Gvs0Oqa9c0aVKs8hyIkd0BzTNKbIbmE
	 MVWhMU8B6P/5ioWw+00td5+LIc4tC3pFY5aKYX72V8es44m2GT+liSZK9NgKpAXkFx
	 o2KPNXdThNGGA==
Date: Mon, 15 Jan 2024 16:17:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, praneeth@ti.com, nm@ti.com,
	vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com,
	kristo@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add support for
 common1 region
Message-ID: <20240115-craftsman-capricorn-d2930678c222@spud>
References: <20240115125716.560363-1-devarsht@ti.com>
 <20240115125716.560363-2-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6UE2VM8YXmjg8HrJ"
Content-Disposition: inline
In-Reply-To: <20240115125716.560363-2-devarsht@ti.com>


--6UE2VM8YXmjg8HrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 06:27:15PM +0530, Devarsh Thakkar wrote:
> TI keystone display subsystem present in AM65 and other SoCs such as AM62

Do all 3 SoCs supported by this binding (am625 am62a7 am65x) have this
common1 register? If not, you should limit it the platforms that do have
it.

Thanks,
Conor.

> support two separate register spaces namely "common" and "common1" which
> can be used by two separate hosts to program the display controller as
> described in respective Technical Reference Manuals [1].
>=20
> The common1 register space has similar set of configuration registers as
> supported in common register space except the global configuration
> registers which are exclusive to common region.
>=20
> This adds binding for "common1" register region too as supported by the
> hardware.
>=20
> [1]:
> AM62x TRM:
> https://www.ti.com/lit/pdf/spruiv7 (Section 14.8.9.1 DSS Registers)
>=20
> AM65x TRM:
> https://www.ti.com/lit/pdf/spruid7 (Section 12.6.5 DSS Registers)
>=20
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index b6767ef0d24d..55e3e490d0e6 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -37,6 +37,7 @@ properties:
>        - description: OVR2 overlay manager for vp2
>        - description: VP1 video port 1
>        - description: VP2 video port 2
> +      - description: common1 DSS register area
> =20
>    reg-names:
>      items:
> @@ -47,6 +48,7 @@ properties:
>        - const: ovr2
>        - const: vp1
>        - const: vp2
> +      - const: common1
> =20
>    clocks:
>      items:
> @@ -147,9 +149,10 @@ examples:
>                      <0x04a07000 0x1000>, /* ovr1 */
>                      <0x04a08000 0x1000>, /* ovr2 */
>                      <0x04a0a000 0x1000>, /* vp1 */
> -                    <0x04a0b000 0x1000>; /* vp2 */
> +                    <0x04a0b000 0x1000>, /* vp2 */
> +                    <0x04a01000 0x1000>; /* common1 */
>              reg-names =3D "common", "vidl1", "vid",
> -                    "ovr1", "ovr2", "vp1", "vp2";
> +                    "ovr1", "ovr2", "vp1", "vp2", "common1";
>              ti,am65x-oldi-io-ctrl =3D <&dss_oldi_io_ctrl>;
>              power-domains =3D <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
>              clocks =3D        <&k3_clks 67 1>,
> --=20
> 2.34.1
>=20

--6UE2VM8YXmjg8HrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVaggAKCRB4tDGHoIJi
0ofxAP9644IoFXpzq15LHVlrL0JW2/U7emx4AxBos1MWHgBw7wD+J8ZVW2G1GO2O
Vy00E4ucrIaKQkVECBpcSKeGws8qFgA=
=J3/J
-----END PGP SIGNATURE-----

--6UE2VM8YXmjg8HrJ--

