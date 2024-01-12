Return-Path: <linux-kernel+bounces-24882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1A82C42C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DF31F248A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52870175A3;
	Fri, 12 Jan 2024 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjSL5aKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542E1B585;
	Fri, 12 Jan 2024 17:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DAAC433C7;
	Fri, 12 Jan 2024 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079059;
	bh=1iKtOHGK5dbeKaVrIFz5lHMuGkeVlaDW9VTBqF628Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjSL5aKbZ34Pzcb5zxFRhJmQRALsnxiMOMjoy1Ge3UcW7Z98aa5EhZqcxS2gbpeVr
	 ETu6cWCg+YbLwckvU1wQE6Beie/Bm78MNMt0WPMpdooCfQIIC/ZJXCq9obWu2vBmgN
	 wEFEVHQeomn5gjFIvpbfxJv3UICofiCo5uDvN71OiRlTX90hxpa+cqT6daNtX7bsJi
	 BKInXQ+9D1uA/vXpfTk2g2ev1CYMKKLFJX6q56cZkCnqffMLzE1tzt9Lyzlvg2O58E
	 97atUhkOirmrsKA2I5rqP4F5Q5Bbjik1sSvfViE67CJw3wIMCCBEldeHMtTxtsgswV
	 gTfFDwlTQ3kfw==
Date: Fri, 12 Jan 2024 17:04:14 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtu3: Add MT8195 MTU3 ip-sleep
 support
Message-ID: <20240112-immodest-cuddly-1c0045fa2861@spud>
References: <20240112133222.240038-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVXqlph5rFkFrGvl"
Content-Disposition: inline
In-Reply-To: <20240112133222.240038-1-angelogioacchino.delregno@collabora.com>


--EVXqlph5rFkFrGvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 02:32:21PM +0100, AngeloGioacchino Del Regno wrote:
> Of the four USB controllers present on the MediaTek MT8195 SoC, three
> of them (0, 2 and 3) are behind MTU3: add wakeup controls for them.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/D=
ocumentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index a59d91243ac8..d4e187c78a0b 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -185,7 +185,10 @@ properties:
>              2 - used by mt2712 etc, revision 2 with following IPM rule;
>              101 - used by mt8183, specific 1.01;
>              102 - used by mt8192, specific 1.02;
> -          enum: [1, 2, 101, 102]
> +            103 - used by mt8195, IP0, specific 1.03;
> +            105 - used by mt8195, IP2, specific 1.05;
> +            106 - used by mt8195, IP3, specific 1.06;
> +          enum: [1, 2, 101, 102, 103, 105, 106]
> =20
>    mediatek,u3p-dis-msk:
>      $ref: /schemas/types.yaml#/definitions/uint32
> --=20
> 2.43.0
>=20

--EVXqlph5rFkFrGvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaFxDgAKCRB4tDGHoIJi
0uvOAQCyWfE54y99jJzttlHBXQCvcZUHCZa1dEP9+XG1alVbZQD/Wgq9GEpo+OdO
3RZ4iVo5U/IXF0RkrGu7V56LCksIhAU=
=4QFj
-----END PGP SIGNATURE-----

--EVXqlph5rFkFrGvl--

