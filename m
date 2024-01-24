Return-Path: <linux-kernel+bounces-37430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC983B09A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C1CB30EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723907F7E8;
	Wed, 24 Jan 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mVolzOCP"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABCF7E79A;
	Wed, 24 Jan 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117418; cv=none; b=IG80uqEDfNfmmMN/ai/KIXVX5HZjnaOCwJkw2Atv4ctFhJgLLwszrUZbdcyfvH94K3rFILLZZT3L/ch32GBu2DQmzlJF5ZaPhU2AfhuOgY5Vjpmdn9VV0DB4Y2JpA4jv08LdH0dqhHriQj+3wjB/AGNUFzFQMdbNHnQ5un7mXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117418; c=relaxed/simple;
	bh=pvI+MdgET5RIzh4OhseZv9ITJ5vJ3r2qlytuGPthtbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMMz17vRgFW/uNoj1P86nRnNqci6XJ0YnmjaL/8hHEaGidNI3sFIQkjWxwRXFo2IlEJc3ETmgHlN5zPCuWGRINP7tESMGlw57itO+C8RJpicrZP9pgQaalVEU6Bz/PMuB3t+IgF4LyP5D7HLahnJOeOVmu6OedbobbDMJeKP/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mVolzOCP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA1FD20003;
	Wed, 24 Jan 2024 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706117414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDJPwgnovDPZQtAnXZHhrhDNXtdN2BbUYDsnE5iArNU=;
	b=mVolzOCPVR+lxctmATLnQTHk4XMcD68acOR4A0c9we6uG8asCXhfcSc+YaoDS30d/2LjvO
	AISia/Qos/zBCf3VLdQL5f9dT5FZ6VccdjYGftW2FmfLbT0vPSRcKqIiwb0oWwRt4eyJVY
	gmvu4QKQQAk41BWtsNp3SIU3ZW/7d2rRiLzpfm2fcNUk/6fRR6ncNGDd/c5YOQRZKCY8ja
	7yxHhLBOlL8zNE6myAxm0ZdG8O+lBwiyuI2su77WxAAiyGzB2dpxorEFJYOYEziVmxw+Kw
	tEwATAwPhXMunV+sZBaQLLSZ+HCYf1FTzSOKNCNsGKJYSfsX25VnsZZf7mIQog==
Date: Wed, 24 Jan 2024 18:30:08 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Regan <dregan@broadcom.com>
Cc: dregan@mail.com, richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 william.zhang@broadcom.com, anand.gore@broadcom.com,
 kursad.oney@broadcom.com, florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@linaro.org
Subject: Re: [PATCH v3 02/10] ARM: dts: broadcom: bcmbca: Add NAND
 controller node
Message-ID: <20240124183008.04a1bcb0@xps-13>
In-Reply-To: <20240124030458.98408-3-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-3-dregan@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi David,

dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:50 -0800:

> From: William Zhang <william.zhang@broadcom.com>
>=20
> Add support for Broadcom STB NAND controller in BCMBCA ARMv7 chip dts
> files.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> ---
> Changes in v3: None
> ---
> Changes in v2: None
> ---
>  arch/arm/boot/dts/broadcom/bcm47622.dtsi    | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm63138.dtsi    | 10 +++++++++-
>  arch/arm/boot/dts/broadcom/bcm63148.dtsi    | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm63178.dtsi    | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm6756.dtsi     | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm6846.dtsi     | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm6855.dtsi     | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm6878.dtsi     | 17 +++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm947622.dts    |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm963138.dts    |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm963138dvt.dts | 12 +++++-------
>  arch/arm/boot/dts/broadcom/bcm963148.dts    |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm963178.dts    |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm96756.dts     |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm96846.dts     |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm96855.dts     |  4 ++++
>  arch/arm/boot/dts/broadcom/bcm96878.dts     |  4 ++++
>  17 files changed, 165 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/broadcom/bcm47622.dtsi b/arch/arm/boot/dts=
/broadcom/bcm47622.dtsi
> index 7cd38de118c3..55ff18043d96 100644
> --- a/arch/arm/boot/dts/broadcom/bcm47622.dtsi
> +++ b/arch/arm/boot/dts/broadcom/bcm47622.dtsi
> @@ -138,6 +138,23 @@ hsspi: spi@1000 {
>  			status =3D "disabled";
>  		};
> =20
> +		nand_controller: nand-controller@1800 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcm=
nand";
> +			reg =3D <0x1800 0x600>, <0x2000 0x10>;
> +			reg-names =3D "nand", "nand-int-base";
> +			brcm,nand-use-wp =3D <0>;
> +			status =3D "disabled";
> +
> +			nandcs: nand@0 {
> +				compatible =3D "brcm,nandcs";
> +				reg =3D <0>;
> +				nand-on-flash-bbt;
> +				brcm,nand-ecc-use-strap;

Describing the NAND chip in a SoC DTSI does not look relevant to me.
Even more if you add something like this nand-ecc-use-strap setting
which is very board dependent.

Same applies to your arm64 DT patch.

Thanks,
Miqu=C3=A8l

