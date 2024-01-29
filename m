Return-Path: <linux-kernel+bounces-43160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F37840C99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27B81F239E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FE2157056;
	Mon, 29 Jan 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3WIpMrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49241155A5F;
	Mon, 29 Jan 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547460; cv=none; b=suK5P2xT4iAH6ZlFEkmTJqja/4GiDB3ojk6kqB3fIU+SvP6TcEinPO3CbiS81wM1ht2EtRNI9myhsOj/YudbIN8yqP1WZdhpf80Gdt8S89bHu9CCzVFbVUpB0kXDkEVQVfa5BMa6C+kwtcGZfm9VbSgdVeYYdFvqMrvuwykDbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547460; c=relaxed/simple;
	bh=PY5cU+3UW7naDT2PjlI20f6EMZrbPVmbCyvO5POAvBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUbgY62fQFRdVNm7Ay10Equ7U0pX1TYFuXIycBZBX/xL9W+PnYNGT11M0ucKjiPCH/VBgjNyzviwCmgGL5NkAnZTFCP9WkOLC65m/MS0sMk1lLmsmETM3KmA6fqkpOxtL/yMPYD5HBIUtlnhJ/taB06bBR2YzPWRsssl0TQAPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3WIpMrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF12C433F1;
	Mon, 29 Jan 2024 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547459;
	bh=PY5cU+3UW7naDT2PjlI20f6EMZrbPVmbCyvO5POAvBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3WIpMrNEurrwyWrWFlIwOAON/JCCzeu2JMaXdahxyUfDn7e+HeDM07Gj/eUZxQj6
	 IH6iRzCvbQVwEGelrJByDP0aLwyNbSSIytcP3jrR6gnKoqem7pMw9qCT5BHH5YUZ+2
	 P+tpXLDr2N5lvQ0NKm3H9GHcGbO9gP9PULvOPuPSNH9ohoHgeNUez4UMmSJl73swg9
	 1eXcAN8WVcJMYmrGV6Ma+g3kFDhoTw4J73hBZleXxcq7IyMYGmu/D7LpfguBeEQQ10
	 FEKLyz/CIghkRFw99dYtQIcFR5k2Fi2Tqm3zqLbVZdulLkw1oyZNkLciZYXVPR1r7b
	 kTBW9KXOwGn2w==
Date: Mon, 29 Jan 2024 16:57:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kishore Manne <nava.kishore.manne@amd.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Describe soc-vvmem subnode
Message-ID: <20240129-vastly-hunk-0680e152c03c@spud>
References: <3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LOozDfvasueM032q"
Content-Disposition: inline
In-Reply-To: <3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com>


--LOozDfvasueM032q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 01:25:06PM +0100, Michal Simek wrote:
> Describe soc-nvmem subnode as the part of firmware node. The name can't be
> pure nvmem because dt-schema already defines it as array property that's
> why different name should be used.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> Dt binding for nvmem node has been already merged and it is the part of
> linux-next tree.
> Here is the reference to it just in case:
> https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-ty@li=
naro.org
>=20
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml   | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqm=
p-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zy=
nqmp-firmware.yaml
> index 7586fbff7ad6..108772ef574f 100644
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
>      $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml
>      description: The ZynqMP SoC uses the PCAP (Processor Configuration P=
ort) to
> @@ -110,6 +116,9 @@ examples:
>      firmware {
>        zynqmp_firmware: zynqmp-firmware {
>          #power-domain-cells =3D <1>;
> +        soc-nvmem {
> +          compatible =3D "xlnx,zynqmp-nvmem-fw";
> +        };

Would it not be better to have an actual nvmem-layout in here? The
~empty node here looks rather odd.

Also, there's a type in $subject of nvmem.

Thanks,
Conor.

>          gpio {
>            compatible =3D "xlnx,zynqmp-gpio-modepin";
>            gpio-controller;
> --=20
> 2.36.1
>=20

--LOozDfvasueM032q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfY/wAKCRB4tDGHoIJi
0rNqAP99TXsDxAY96t3sGZNtC3Vrmw+Zgegwmy/rGInLx2ByGwEAtZQ/EQisxfOm
tWkHHbHJ9y+fW5zSNHf2/eVQEco79Q4=
=PUQx
-----END PGP SIGNATURE-----

--LOozDfvasueM032q--

