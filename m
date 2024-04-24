Return-Path: <linux-kernel+bounces-157756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF78B1562
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E131C21B41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533B1586F4;
	Wed, 24 Apr 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL63qqX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7F15687F;
	Wed, 24 Apr 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995865; cv=none; b=dq703JpJenD4diSCbjmZnjAat/+KpsTcuAGkpxsF1+iVEetCvkRZqno8PHd6EO2phn2C1lvfFpeQHIQrr8qZCJPbw6Ok86jGwI5xQlA/lK++HxkX78nu9r/ooF/j47TDc7oWcGn8LXrh8MITFp/c5bPkWU+vcYORODZNJOoJV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995865; c=relaxed/simple;
	bh=iA5er1v7o8xOSguwB/KZCt1Mz1Z6XF4dQ/9cOa/ZGMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJN1ZHAN9CkftDYMtGMkND/Oih9bWNk6jll8nIHkKZylE1HoJ7r9wNTzA2bM4EXU11EHTsnJ1MaewtEBY3ZyCqA+KP+vbNzuWLZwpNh481dNAQqA2z6sqn+GEmFYHiZ7VT2+XqOYmayB52IUu3GSbjCj0y4ivK5sW/n3EX5HQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL63qqX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F14C113CD;
	Wed, 24 Apr 2024 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713995865;
	bh=iA5er1v7o8xOSguwB/KZCt1Mz1Z6XF4dQ/9cOa/ZGMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DL63qqX8i3ZFMOMJJPIpHSxyDW1eb6aZJpUvgCNNmt8eNfVsVS81/OuLlUjyI4rMz
	 9Wx0J/3echd9pxR7MK3eb5xC7bCD0NGOi08FHVGUltq6B60RhHJXH1sGhyY0aiKRSO
	 NyWpyFtgiWce7GevhcZG5o3lBAalBegjBcYCidJkKdYxZyi6C0LSQYOL4J/Uz4sGML
	 jIazZv1mr8a71FzC/7Xc+1qwbTaqas5Tgxgd8btL8w68axLhcpsOWKKNSeuv5gWC4W
	 MxExK7THeqKisCIgF6/A+O3P2htwE7z/pABFcU+ywLjIvZWMoMtXjMsPhnoKHDzXl2
	 3iEh/FDYwbgJQ==
Date: Wed, 24 Apr 2024 16:57:42 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: phy-imx8-pcie: Add header file
 for i.MX8Q HSIO SerDes PHY
Message-ID: <20240424215742.GB460126-robh@kernel.org>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
 <1713939683-15328-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713939683-15328-2-git-send-email-hongxing.zhu@nxp.com>

On Wed, Apr 24, 2024 at 02:21:21PM +0800, Richard Zhu wrote:
> Add lane index and HSIO configuration definitions of the i.MX8Q HSIO
> SerDes PHY into header file.

This belongs in the binding patch. It is part of the binding.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/phy/phy-imx8-pcie.h | 62 +++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
> index 8bbe2d6538d8..60447b95a952 100644
> --- a/include/dt-bindings/phy/phy-imx8-pcie.h
> +++ b/include/dt-bindings/phy/phy-imx8-pcie.h
> @@ -11,4 +11,66 @@
>  #define IMX8_PCIE_REFCLK_PAD_INPUT	1
>  #define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
>  
> +/*
> + * i.MX8QM HSIO subsystem has three lane PHYs and three controllers:
> + * PCIEA(2 lanes capable PCIe controller), PCIEB (only support one
> + * lane) and SATA.
> + *
> + * Meanwhile, i.MX8QXP HSIO subsystem has one lane PHY and PCIEB(only
> + * support one lane) controller.
> + *
> + * In the different use cases. PCIEA can be bound to PHY lane0, lane1
> + * or Lane0 and lane1. PCIEB can be bound to lane1 or lane2 PHY. SATA
> + * can only be bound to last lane2 PHY.
> + *
> + * +-------------------------------+------------------+
> + * | i.MX8QM                       | i.MX8QXP         |
> + * |-------------------------------|------------------|
> + * |       | PCIEA | PCIEB | SATA  |       | PCIEB    |
> + * |-------------------------------|-------|----------|
> + * | LAN 0 | X     |       |       | LAN 0 | *        |

LAN? Local Area Network? Just use 'Lane'.

Don't need this column                 ^^^^^^^

> + * |-------------------------------|-------|----------|
> + * | LAN 1 | X     | *     |       |       |          |
> + * |-------------------------------|-------|----------|
> + * | LAN 2 |       | *     | *     |       |          |
> + * +-------------------------------+------------------+
> + * NOTE:
> + * *: Choose one only.
> + * X: Choose any of these.
> + *
> + * Define i.MX8Q HSIO PHY lane index here to specify the lane mask.
> + */
> +#define IMX8Q_HSIO_LANE0	0x1
> +#define IMX8Q_HSIO_LANE1	0x2
> +#define IMX8Q_HSIO_LANE2	0x4

Thinking about this some more, in most cases of the phy binding where 
individual lanes can be assigned, each lane is a phys entry.

PCIEA:
phys = <&hsio_phy 0 PHY_MODE_PCIE>;
or:
phys = <&hsio_phy 0 PHY_MODE_PCIE>, <&hsio_phy 1 PHY_MODE_PCIE>;

PCIEB:
phys = <&hsio_phy 1 PHY_MODE_PCIE>;
or:
phys = <&hsio_phy 2 PHY_MODE_PCIE>;

SATA:
phys = <&hsio_phy 2 PHY_MODE_SATA>;

> +
> +/*
> + * Regarding the design of i.MX8QM HSIO subsystem, HSIO module can be
> + * confiured as following three use cases.
> + *
> + * Define different configurations refer to the use cases, since it is
> + * mandatory required in the initialization.
> + *
> + * On i.MX8QXP, HSIO module only has PCIEB and one lane PHY.
> + * Define "IMX8Q_HSIO_CFG_PCIEB" for i.MX8QXP platforms.
> + *
> + * +----------------------------------------------------+----------+
> + * |                               | i.MX8QM            | i.MX8QXP |
> + * |-------------------------------|--------------------|----------|
> + * |                               | LAN0 | LAN1 | LAN2 | LAN0     |

s/LAN/Lane/

> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEAX2SATA    | PCIEA| PCIEA| SATA |          |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEAX2PCIEB   | PCIEA| PCIEA| PCIEB|          |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEAPCIEBSATA | PCIEA| PCIEB| SATA |          |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEB          | -    | -    | -    | PCIEB    |
> + * +----------------------------------------------------+----------+
> + */
> +#define IMX8Q_HSIO_CFG_PCIEAX2SATA	0x1
> +#define IMX8Q_HSIO_CFG_PCIEAX2PCIEB	0x2
> +#define IMX8Q_HSIO_CFG_PCIEAPCIEBSATA	(IMX8Q_HSIO_CFG_PCIEAX2SATA | IMX8Q_HSIO_CFG_PCIEAX2PCIEB)
> +#define IMX8Q_HSIO_CFG_PCIEB		IMX8Q_HSIO_CFG_PCIEAX2PCIEB

Again, I don't see why you need all this. You now have mode and lanes, 
and per SoC data in the driver, so you should be able to figure out what 
you need from this.

Rob

