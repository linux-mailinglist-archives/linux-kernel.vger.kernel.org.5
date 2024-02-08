Return-Path: <linux-kernel+bounces-58246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A063A84E36F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F994B2317B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FB79DD8;
	Thu,  8 Feb 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GsyBZ8Du"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685178B4A;
	Thu,  8 Feb 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403502; cv=none; b=aqZzIU2yJAPZ8JKM0ctoHGZzzSe2uk3yzhj+EzHJ7DlLbNyCisl2EB5xSXQc6K99qch1o5HJEQ6LzXu3vwFaSKg0iwvg6xk6H54HDyZnGygYKvHHU0/sW7Hjk4JWwO4vDwWvZ9UiEWbD/ou4gDBCwpUE5KVPFbx0yV+B3Wfyvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403502; c=relaxed/simple;
	bh=Xm7DzbnQu2Q8/mxLnKdHxr/2KsYmswX72X95G2g9xgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baBkULZJ39EAuLU4j+oXglcRm/KSoiA4l2S/TqyKGEsyG5IZC8EVOORlTsjAs7decH5J4Gank6Jo5wYlkNNogouh3cMz5RhZ9q6Gc31Wxw13ccvb/ZoWjbpSMNC7+DVig4GLu1hHKaz62MoLKa+G8SxXrMMa98dNinIRkog/Y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GsyBZ8Du; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707403499; x=1738939499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hH9tUy1Ax16/EICUN8RJkG7wisVKzi/kLqYs+DajzB0=;
  b=GsyBZ8DuRDobwSmomC0BvS9LRDeLRgrGgj3m5ZWsTMq3kw1Cy5addMtJ
   kDnageym2vGnn3LStv1WOy8Wf+LDzBSe/u5oP80dBBcPJk4se2n3KMqD1
   nn/TvtybxRaIvEt6Fvg5k9LeLmhKok9cBhh4QJrUE8P8SKhnmaFFrY/9q
   nveB3gvpI1Pe2ImHmDVEerFVCvzxQMgbFQya4bIah78TIE0FkSgiWbRDd
   7U6gvJfWgQkYYaRTxQDKFVEyOLhvFoawhZI5ny6FPMRfn5+ZalgySq3Ue
   USZkQqu/bzMrXzfsx6PIUkeRrSmK8+VwQvBsdL6mDlGAR1H21l9ErM8Wp
   g==;
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="35319043"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Feb 2024 15:43:47 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0541D280075;
	Thu,  8 Feb 2024 15:43:47 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com" <linux@ew.tq-group.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: freescale: minor whitespace cleanup
Date: Thu, 08 Feb 2024 15:43:47 +0100
Message-ID: <3548464.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240208105217.128748-1-krzysztof.kozlowski@linaro.org>
References: <20240208105217.128748-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Krzysztof,

Am Donnerstag, 8. Februar 2024, 11:52:26 CET schrieb Krzysztof Kozlowski:
> The DTS code coding style expects exactly one space before '{'
> character.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 2 +-
>  arch/arm64/boot/dts/freescale/mba8xx.dtsi     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts index
> 69dd8e31027c..24bb253b938d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -37,7 +37,7 @@ m33_reserved: noncacheable-section@a8600000 {
>  			no-map;
>  		};
>=20
> -		rsc_table: rsc-table@1fff8000{
> +		rsc_table: rsc-table@1fff8000 {
>  			reg =3D <0 0x1fff8000 0 0x1000>;
>  			no-map;
>  		};
> diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> b/arch/arm64/boot/dts/freescale/mba8xx.dtsi index
> 6164fefb9218..3b4c5fa21f31 100644
> --- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> @@ -466,7 +466,7 @@ pinctrl_pca9538: pca9538grp {
>  		fsl,pins =3D <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19=09
0x00000020>;
>  	};
>=20
> -	pinctrl_pcieb: pcieagrp{
> +	pinctrl_pcieb: pcieagrp {
>  		fsl,pins =3D <IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00=09
0x06000041>,
>  			   <IMX8QXP_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01=09
0x06000041>,
>  			   <IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02=09
0x04000041>;


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



