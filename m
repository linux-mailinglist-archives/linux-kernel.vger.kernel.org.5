Return-Path: <linux-kernel+bounces-105886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8C87E5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6D61F2271B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF812C1AA;
	Mon, 18 Mar 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="g1OFT+2s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="suwAP0up"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1622C1A5;
	Mon, 18 Mar 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754532; cv=none; b=TVc+VDfwaKMWuUgZgSrsz9vNzdRZsRw8eWX6kyqjXgX8B/ihSTOq822RSkN+yLlppx0F/n4rEbKKLV0nBKkODVMFDFnIbjM7uUMmKihlqhEMQBh++YGTd87p385k8qrNkALw2MvmAeFVLWF0oYBJ9WWv81R8+ZSFXXz+MKFW3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754532; c=relaxed/simple;
	bh=hHjo493pZgNAF6FPMoBG6TgRCysgj/KGj2NcRPg4Ego=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6whMX6I0GvnnzmU/yH0iCcGZDPnEPNSSHgZ6lrYhBVyTpe5RG7X4A7IT/+bikJn2hY/mzxrD7fhQ5vo0iW4AhW/V6/Z1I/ZYnJW2uPjy15ReaKefqC3hHiJGILmENdUIc0SQT6rdsjB3hQ3nlE50zFVPOnpLjjuhZXlpOYDGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=g1OFT+2s; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=suwAP0up reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710754528; x=1742290528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aN2IIFrVH4CYkyRywlFNeTp/faziqn7wqwrzQ+C8QGM=;
  b=g1OFT+2sW/h8wvfrHJ468/9ItTftSliFzyzcLUNgPlHAaAIS1y0Ik2o4
   eoA9/jGb/m8GVVn1+86YeMTXg7kHM02sFlr5tIsl6ZLyCSu6+TJOnJdXH
   hWHvTjuRiyDKoO121okbzapRhuFFqtaDdXG6IlaqG9YbHa/NMvK9+94OI
   CS8jYOsnjURbzIpb59q2j71sXEC2cngj9PyC2If7dRK7Osx73gKKo3mCv
   pMMFgNO5MXRcFc7cvciqvC4ydsK/18ELo0nSpPA50LuaiSIiJWZHxoP/H
   KCYzcwUp6nA8SSi+f/FPJEPxjn0I+s6Fj95+u6J0zNjoVXraEpKgvFgJm
   w==;
X-IronPort-AV: E=Sophos;i="6.07,134,1708383600"; 
   d="scan'208";a="35955371"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Mar 2024 10:35:19 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5615A16F79E;
	Mon, 18 Mar 2024 10:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710754515;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aN2IIFrVH4CYkyRywlFNeTp/faziqn7wqwrzQ+C8QGM=;
	b=suwAP0upO/OwYZOKTKJRn1XFOr8KgaW2+5BIGRdA7lHpFbPfP7O3pg//sFURYuH3YvbpNb
	V3UD4zJt0pvyOGDvrMoB8jNUYwB9Mm9h0rQXRQmuJsS4CZWsAA3M3LMqYSAybgBUEbkdGU
	FyqymaRgiz/mnz5THO/vebFSfEu5QqkK/EovIAYlvRqD9+TBevUY6xgcHZ0rSjHfG7SEnP
	MgOJuIIzHnMcunN3Q6GSRhR3hVrwJV02eGFziClv6Dy8wBfZ0MMRzfphvMtcLaPTJTTIo+
	UCB44mUguFtrM5IH5AUiGIVQ2Ac9ZLaYSNAc+OKv04nOCiMWkE3Wh3/9VW0N0g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/1] ARM: dts: imx6ul: tqma6ul + mba6ulx: Fix pinctrl node names
Date: Mon, 18 Mar 2024 10:35:18 +0100
Message-ID: <2727312.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240317162214.ssspjf2xfpid32k6@pengutronix.de>
References: <20240314150054.2957840-1-alexander.stein@ew.tq-group.com> <20240317162214.ssspjf2xfpid32k6@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Marco,

Am Sonntag, 17. M=E4rz 2024, 17:22:14 CET schrieb Marco Felsch:
> Hi Alexander,
>=20
> just a minor, please see below.
>=20
> On 24-03-14, Alexander Stein wrote:
> > imx6ul pinctrl nodes end with 'grp'. Fix node names.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi | 2 +-
> >  arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi               | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arc=
h/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
> > index 57e647fc3237..f04c6f71f538 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
> > @@ -202,7 +202,7 @@ MX6UL_PAD_UART2_RX_DATA__GPIO1_IO21	0x4001b8b0
> >  		>;
> >  	};
> > =20
> > -	pinctrl_pmic: pmic {
> > +	pinctrl_pmic: grp {
> 			^
> 			pmicgrp

Nice catch. Will be fixed in v2. Thanks.

Best regards,
Alexander

> =20
> >  		fsl,pins =3D <
> >  			/* PMIC irq */
> >  			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x1b099
> > diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts=
/nxp/imx/mba6ulx.dtsi
> > index e78d0a7d8cd2..5258ef81e6c7 100644
> > --- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
> > @@ -505,7 +505,7 @@ MX6UL_PAD_CSI_HSYNC__UART6_DCE_CTS	0x1b0b1
> >  		>;
> >  	};
> > =20
> > -	pinctrl_uart6dte: uart6dte {
> > +	pinctrl_uart6dte: uart6dtegrp {
> >  		fsl,pins =3D <
> >  			MX6UL_PAD_CSI_PIXCLK__UART6_DTE_TX	0x1b0b1
> >  			MX6UL_PAD_CSI_MCLK__UART6_DTE_RX	0x1b0b1
> > @@ -537,7 +537,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
> >  		>;
> >  	};
> > =20
> > -	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> > +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> >  		fsl,pins =3D <
> >  			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
> >  			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170b9
> > @@ -552,7 +552,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
> >  		>;
> >  	};
> > =20
> > -	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> > +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> >  		fsl,pins =3D <
> >  			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
> >  			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170f9
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



