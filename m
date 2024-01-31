Return-Path: <linux-kernel+bounces-46722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9E84432C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E021F2B2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC486AC5;
	Wed, 31 Jan 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJC8mHyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374B128388;
	Wed, 31 Jan 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715276; cv=none; b=oB1SCZ59E024OnP6IOANITRJiTCReJavdEoNwk9H0WW13j0NVxYFxb5RFCgiKtQUfovfu1fRiE9Am5BCcm4Wwcd7rX9EVjnfDqxJfsBP3QWB3Jr4KI7rMFuZXITtPM3G4AONGz2vI9H7qugZJbQowki1R1uXR+ju3hQVKxACGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715276; c=relaxed/simple;
	bh=QQqV3bbP03G+xG6vuCBmBmlw0AuFNj3Mn7JBpxImoks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjONLFL04ePJ3ntutPxy6O36c9TJ9idLA/azkts/oK0N/U3is9FBwu79BYxQ97+X6kAiGh0JzWJk9uB+TFgW6DpvnSIZ+Ahs90SdeN+HQQLcBJJu7cb6rlaFFQarLk/FL0MeVnjPnnqABt4wB/kI8sYTU5u/9D3gXQqz6zkNf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJC8mHyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54928C433C7;
	Wed, 31 Jan 2024 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715275;
	bh=QQqV3bbP03G+xG6vuCBmBmlw0AuFNj3Mn7JBpxImoks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJC8mHyRJukMpVXa+Q8paQVnxkyN/CR9xP7DeuQ8PirxyucA+ii0WGa7vu2fuD8fn
	 1NpgVrHoE1qaIACClRdbeUxEK4cKtchV+p7JwgF2DMK6x/XqOl+2xs2kdoUUIBR3kW
	 aJts20Rx7rG8rRAN1BEAdP9NeMDbY/O0trbrSaGQT/JEJokCIacgus+gEXuwJB3nLa
	 ZQvDVoeWxPfQQ9Jt16vxksL2lTXTElR8AnhAUtPZUvFB/JMIri1avLjwa4FK3PglQe
	 nl0hcWEIxM4zriZzPF8NhU75O4H4B/bx6ToP+BLjQwpfxLdqS3bQfmaR0R18M952/p
	 04vdePHFeujlA==
Date: Wed, 31 Jan 2024 15:34:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kishore Manne <nava.kishore.manne@amd.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: firmware: xilinx: Describe soc-nvmem
 subnode
Message-ID: <20240131-portal-glazing-16fa36efb3cb@spud>
References: <24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8eTPnKnItRAdl1X"
Content-Disposition: inline
In-Reply-To: <24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com>


--p8eTPnKnItRAdl1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:17:28AM +0100, Michal Simek wrote:
> Describe soc-nvmem subnode as the part of firmware node. The name can't be
> pure nvmem because dt-schema already defines it as array property that's
> why different name should be used.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
> Changes in v2:
> - Fix typo in subject
> - Make example bigger requested by Conor
>=20
> Dt binding for nvmem node has been already merged and it is the part of
> linux-next tree.
> Here is the reference to it just in case:
> https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-ty@li=
naro.org
>=20
> v1 available here:
> https://lore.kernel.org/r/3869498c995cbb123127122f429e90de0a3f4014.170653=
1104.git.michal.simek@amd.com
>=20
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqm=
p-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zy=
nqmp-firmware.yaml
> index 870b94813a43..741f17c830f4 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmw=
are.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmw=
are.yaml
> @@ -62,6 +62,12 @@ properties:
>        interface.
>      type: object
> =20
> +  soc-nvmem:
> +    $ref: /schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
> +    description: The ZynqMP MPSoC provides access to the hardware relate=
d data
> +      like SOC revision, IDCODE and specific purpose efuses.
> +    type: object
> +
>    pcap:
>      $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
>      description: The ZynqMP SoC uses the PCAP (Processor Configuration P=
ort) to
> @@ -110,6 +116,18 @@ examples:
>      firmware {
>        zynqmp_firmware: zynqmp-firmware {
>          #power-domain-cells =3D <1>;
> +        soc-nvmem {
> +          compatible =3D "xlnx,zynqmp-nvmem-fw";
> +          nvmem-layout {
> +            compatible =3D "fixed-layout";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            soc_revision: soc-revision@0 {
> +                reg =3D <0x0 0x4>;
> +            };
> +          };
> +        };
>          gpio {
>            compatible =3D "xlnx,zynqmp-gpio-modepin";
>            gpio-controller;
> --=20
> 2.36.1
>=20

--p8eTPnKnItRAdl1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpohgAKCRB4tDGHoIJi
0p05AP9bj66WPLZDJjQs7HxXFevKfbYnJv+06hgUHoKnu22e4AEA/ySr0RIBsROL
8ZrTNyAnnycNZUDPJk2tZKTechOleQ8=
=dgZy
-----END PGP SIGNATURE-----

--p8eTPnKnItRAdl1X--

