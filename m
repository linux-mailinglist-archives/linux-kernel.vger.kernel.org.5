Return-Path: <linux-kernel+bounces-37441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBD83B039
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65F8B32C38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F57F7F5;
	Wed, 24 Jan 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0Spo3rG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CB7E798;
	Wed, 24 Jan 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117639; cv=none; b=SM5b9KGuTDOWuJvBhLDQYuqH5E4DdOYoO4WYv04H7pXwYIF0nD08nBcfzzgHN1yBG+DEFL/Gu1eOtzviOaqOMucn8Ij/6vqw71QKDZ9j248kH/fcx67xqIQQZebbr5qtlqzJdL3HMcpN/SazfTOu529JsTZZhoVabzuqsr5c5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117639; c=relaxed/simple;
	bh=F8O1LAlWtzyG7pKBPEZ8OXoCR4xC+gD0cGfc5INvsp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3jMwwyi5VsuDIioakMlAqN/H3q3qUuPXodj4uygpjYp0umlg+JlauraRueSn7Jzi1PN4i41qXr8hD6Tq6S+UWpJe+Aoef+7nrrtFnPs+1fqgwtdAf+F8eTR7BGey1r2r/sYREzd60aajIsGmEw2UH9VMdccOfeDQkDTanxoMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0Spo3rG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46AAC433C7;
	Wed, 24 Jan 2024 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706117638;
	bh=F8O1LAlWtzyG7pKBPEZ8OXoCR4xC+gD0cGfc5INvsp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0Spo3rGnbgB9zPHV4UIgRZdD+ZLoVGQFY2Eu1smFyFZaHu5L5OPcrsFb2P+VUiDd
	 LsK8KfQNiPp+twAUPul1m/4JYuSFohbWVFdIT+cJMA/7hiCVydYWQ/rGrZ1nEDpYF+
	 saudLPuSyYrdYkiYA8mFF57PrCNvPDuXeb+5kR3VnN3fEI1QP5VMROZ4NjiKOOVx0R
	 jByrTxfv6+39YfMDW5rYa9A6x0pxJ5AcNsedxJ73HgScC18dgziw/KCrD26cJA2KMx
	 FfXQngOx7sr9KzHMJBpSWEuOR8C+2E8h76e9LowWxURe1wrgOg4Wi+QSOq4VX18hnc
	 jD+a89wJ92Xgw==
Date: Wed, 24 Jan 2024 17:33:52 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: rtc: convert MT7622 RTC to the json-schema
Message-ID: <20240124-footnote-country-9dc331c51819@spud>
References: <20240123125043.27192-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mzfSYH7PP20o44ht"
Content-Disposition: inline
In-Reply-To: <20240123125043.27192-1-zajec5@gmail.com>


--mzfSYH7PP20o44ht
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:50:43PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This helps validating DTS files. Introduced changes:
> 1. Reworded title
> 2. Dropper redundant properties descriptions
> 3. Added required #include-s and adjusted "reg" in example
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/rtc/mediatek,mt7622-rtc.yaml     | 52 +++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-mt7622.txt    | 21 --------
>  2 files changed, 52 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/mediatek,mt7622=
-rtc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.ya=
ml b/Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
> new file mode 100644
> index 000000000000..e74dfc161cfc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/mediatek,mt7622-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7622 on-SoC RTC
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt7622-rtc
> +      - const: mediatek,soc-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: rtc
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt7622-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    rtc@10212800 {
> +        compatible =3D "mediatek,mt7622-rtc", "mediatek,soc-rtc";
> +        reg =3D <0x10212800 0x200>;
> +        interrupts =3D <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
> +        clocks =3D <&topckgen CLK_TOP_RTC>;
> +        clock-names =3D "rtc";
> +    };
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt b/Docum=
entation/devicetree/bindings/rtc/rtc-mt7622.txt
> deleted file mode 100644
> index 09fe8f51476f..000000000000
> --- a/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Device-Tree bindings for MediaTek SoC based RTC
> -
> -Required properties:
> -- compatible	    : Should be
> -			"mediatek,mt7622-rtc", "mediatek,soc-rtc" : for MT7622 SoC
> -- reg 		    : Specifies base physical address and size of the registers;
> -- interrupts	    : Should contain the interrupt for RTC alarm;
> -- clocks	    : Specifies list of clock specifiers, corresponding to
> -		      entries in clock-names property;
> -- clock-names	    : Should contain "rtc" entries
> -
> -Example:
> -
> -rtc: rtc@10212800 {
> -	compatible =3D "mediatek,mt7622-rtc",
> -		     "mediatek,soc-rtc";
> -	reg =3D <0 0x10212800 0 0x200>;
> -	interrupts =3D <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
> -	clocks =3D <&topckgen CLK_TOP_RTC>;
> -	clock-names =3D "rtc";
> -};
> --=20
> 2.35.3
>=20

--mzfSYH7PP20o44ht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbFKAAAKCRB4tDGHoIJi
0hieAQCSVtBR/QWefVi/R8aPudHESw7FQN1nfXuBKJuUNQjjlAD+NLxT1QNvQr9y
CoJayyLMfGR1nC0ul+pEvzRdrx6kUAA=
=LfgQ
-----END PGP SIGNATURE-----

--mzfSYH7PP20o44ht--

