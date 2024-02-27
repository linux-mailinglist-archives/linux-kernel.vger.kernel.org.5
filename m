Return-Path: <linux-kernel+bounces-83628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D4869C77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5681C23545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716A4EB45;
	Tue, 27 Feb 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IpJjC/Lu"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71D2576B;
	Tue, 27 Feb 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051936; cv=none; b=OHAPSEkg3TiY/iB7JtuwTqZZ2OnJtpCGbC8xLUVbxNpSgvnTGk30fYdlfaKh+GrXApQ/G/lskG99NwsytjFij4I8HPzVrNdobgqLUH0oypOgOdc3r69aruAW9GSERRUnTPY8WrY9udTokWYNvx8JStPM7FEL2A7TM+r8kCIOC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051936; c=relaxed/simple;
	bh=1IoZXMC1FAl+Q4jvjN+QVZ8Gg6WkcDFeKX+wwqu8edc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XdaXfaEyCNIM3C9uwsZcmjKsBP1d3rx27OT6Bgri/FLUlIsGNoTo+PSOmZCZ2KNna5meHjw2N1LfqeVv8+iE1yvZ1I8socWecAW9KL79/A2dUBrUtFiSyhZDRkNzbMboaDeVX6v4uitA17aZn6UqTjo6VMwSIfwI7SwFOSny5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IpJjC/Lu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 506B51BF204;
	Tue, 27 Feb 2024 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709051931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXbl2mGg/fnH2m6J+jYG9ljSlv6ApYY+HEqrYS8n/8s=;
	b=IpJjC/LuJtuaeJEc7hJzBiD5+6HsM1sYggGNhS1SMtXWsndQj0rPxQ7mpE61Q/m2LYI5br
	aY381mYvPNCHjNafhHJ7RxIjREI9uZmRQ0MGZEgFMKeGI7+IrBEeXCRmh6mhGtNvGeQTVJ
	pjwaYRWmNNVUPO4GWzpwcuDmr1rpaPXjCKSs4/6DMs6Uo3iP3SNfCPyqPz+ypFYUsVpose
	h2cftDAqNCCd3LniGekZTvs6mRauRbJvyljGp6YxvkKzhkByLluzSNltrpZNFz+XnSlWbB
	onoGvPoRhSXBG8nURecnsndxfQg8NrANZxai4ttVJAQeZtF4NtmtHGM18U31jg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>
Subject: Re: [PATCH] arm64: dts: marvell: reorder crypto interrupts on
 Armada SoCs
In-Reply-To: <20240123122258.24218-1-zajec5@gmail.com>
References: <20240123122258.24218-1-zajec5@gmail.com>
Date: Tue, 27 Feb 2024 17:38:49 +0100
Message-ID: <87y1b5j206.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Hi Rafa=C5=82 Mi=C5=82ecki,

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Match order specified in binding documentation. It says "mem" should be
> the last interrupt.
>
> This fixes:
> arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-n=
ames:0: 'ring0' was expected
>         from schema $id: http://devicetree.org/schemas/crypto/inside-secu=
re,safexcel.yaml#
> arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-n=
ames:1: 'ring1' was expected
>         from schema $id: http://devicetree.org/schemas/crypto/inside-secu=
re,safexcel.yaml#
> arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-n=
ames:2: 'ring2' was expected
>         from schema $id: http://devicetree.org/schemas/crypto/inside-secu=
re,safexcel.yaml#
> arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-n=
ames:3: 'ring3' was expected
>         from schema $id: http://devicetree.org/schemas/crypto/inside-secu=
re,safexcel.yaml#
> arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-n=
ames:4: 'eip' was expected
>         from schema $id: http://devicetree.org/schemas/crypto/inside-secu=
re,safexcel.yaml#
> arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-n=
ames:5: 'mem' was expected
>         from schema $id: http://devicetree.org/schemas/crypto/inside-secu=
re,safexcel.yaml#
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index e300145ad1a6..1cc3fa1c354d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -431,14 +431,14 @@ xor11 {
>  			crypto: crypto@90000 {
>  				compatible =3D "inside-secure,safexcel-eip97ies";
>  				reg =3D <0x90000 0x20000>;
> -				interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +				interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names =3D "mem", "ring0", "ring1",
> -						  "ring2", "ring3", "eip";
> +					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names =3D "ring0", "ring1", "ring2",
> +						  "ring3", "eip", "mem";
>  				clocks =3D <&nb_periph_clk 15>;
>  			};
>=20=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-cp11x.dtsi
> index 4ec1aae0a3a9..7e595ac80043 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -511,14 +511,14 @@ CP11X_LABEL(sdhci0): mmc@780000 {
>  		CP11X_LABEL(crypto): crypto@800000 {
>  			compatible =3D "inside-secure,safexcel-eip197b";
>  			reg =3D <0x800000 0x200000>;
> -			interrupts =3D <87 IRQ_TYPE_LEVEL_HIGH>,
> -				<88 IRQ_TYPE_LEVEL_HIGH>,
> +			interrupts =3D <88 IRQ_TYPE_LEVEL_HIGH>,
>  				<89 IRQ_TYPE_LEVEL_HIGH>,
>  				<90 IRQ_TYPE_LEVEL_HIGH>,
>  				<91 IRQ_TYPE_LEVEL_HIGH>,
> -				<92 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "mem", "ring0", "ring1",
> -				"ring2", "ring3", "eip";
> +				<92 IRQ_TYPE_LEVEL_HIGH>,
> +				<87 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "ring0", "ring1", "ring2", "ring3",
> +					  "eip", "mem";
>  			clock-names =3D "core", "reg";
>  			clocks =3D <&CP11X_LABEL(clk) 1 26>,
>  				 <&CP11X_LABEL(clk) 1 17>;
> --=20
> 2.35.3
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

