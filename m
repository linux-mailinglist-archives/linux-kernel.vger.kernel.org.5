Return-Path: <linux-kernel+bounces-104681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8687D249
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527511C21D46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854BF5FBAE;
	Fri, 15 Mar 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhZW/+od"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0436026F;
	Fri, 15 Mar 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521664; cv=none; b=Nb+rbCmhyxYXnPoA9K94Hk2wXrps/VrgeLwKO0r5y+vfSvMMI12CPdI449p/ORTSr9SN38/TsWth0d39Oc+0rj/1klHWHfrEgPKQvD2dtLN1NNS4rPgXvOmnD7cIxbO6oUNi8ozhO/ApNnE/7HTPo6d+b1SdMLPSWWnWAn6QEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521664; c=relaxed/simple;
	bh=8hnOEeLZTKNopoewYVMGy8CGA1IX2Tb3FpvrD/17hVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbYArAcWqsSRUeZmcSqOAc7XFvy78fMq6ZY0T2agcQVuqffuNVj8pDTOFwMIKfKC1Bxf5e8NJ2W5gS/AjdbN7/gjtrRl6/mhLzija030y6O9kwjIf8/tlPLa+WDpczIgDNOC8ww2hKBX3wUXuOnKJ207iVpbacUHvUEMpM2OKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhZW/+od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3892FC433C7;
	Fri, 15 Mar 2024 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521664;
	bh=8hnOEeLZTKNopoewYVMGy8CGA1IX2Tb3FpvrD/17hVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhZW/+odc2HllbJoa5yn9sj76E4iGyfuvtpWzbM/eXWcIDZZaaEsEvTBacf87xgk1
	 735tuAKAjMCV+1N9lEkU5NV0jKF75HpnMqCxkBGZ0XiIhGXipkAmVdUo25Tzc7Di/F
	 FGlnSh1oozXDN6frIICmD5nTZxKIu5+457fXMMtGDZmXI9269IFJsMYm5M/MSvACfB
	 3cn2KeFoYxr4NXmjIohcUoazKSx7zr7vciyopFpJBv9aAGsorP4FVet5jBiNPB0dQ3
	 fsOy7WINLSLugkOWqYxIJkTyXw6VRXQBW7Oa75GmfShpXsZKxWANCrlnCXGCi5sTIP
	 TgNL1cDH7L62A==
Date: Fri, 15 Mar 2024 10:54:22 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 1/6] dt-bindindgs: clock: nxp: support i.MX95 VPU CSR
 module
Message-ID: <20240315165422.GA1472059-robh@kernel.org>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240314-imx95-blk-ctl-v4-1-d23de23b6ff2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-imx95-blk-ctl-v4-1-d23de23b6ff2@nxp.com>

On Thu, Mar 14, 2024 at 09:25:10PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX95 VPU_CSR contains control and status registers for VPU
> status, pending transaction status, and clock gating controls.
> 
> This patch is to add clock features for VPU CSR.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-vpu-csr.yaml          | 50 ++++++++++++++++++++++
>  include/dt-bindings/clock/nxp,imx95-clock.h        | 14 ++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
> new file mode 100644
> index 000000000000..4a1c6dcfe3f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nxp,imx95-vpu-csr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX95 VPUMIX Block Control
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nxp,imx95-vpu-csr
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See
> +      include/dt-bindings/clock/nxp,imx95-clock.h
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@4c410000 {
> +      compatible = "nxp,imx95-vpu-csr", "syscon";
> +      reg = <0x4c410000 0x10000>;
> +      #clock-cells = <1>;
> +      clocks = <&scmi_clk 114>;
> +      power-domains = <&scmi_devpd 21>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
> new file mode 100644
> index 000000000000..9d8f0a6d12d0
> --- /dev/null
> +++ b/include/dt-bindings/clock/nxp,imx95-clock.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMX95_H
> +#define __DT_BINDINGS_CLOCK_IMX95_H
> +
> +#define IMX95_CLK_VPUBLK_WAVE			0
> +#define IMX95_CLK_VPUBLK_JPEG_ENC		1
> +#define IMX95_CLK_VPUBLK_JPEG_DEC		2
> +#define IMX95_CLK_VPUBLK_END			3

If this number can change, then it is not ABI and doesn't go in this 
header. With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>

