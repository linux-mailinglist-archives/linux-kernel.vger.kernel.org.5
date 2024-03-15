Return-Path: <linux-kernel+bounces-104717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A599987D2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFEC1C2212E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0769482E2;
	Fri, 15 Mar 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDIRyhBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47B2A8E5;
	Fri, 15 Mar 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523452; cv=none; b=o46xlcvn7DmbO/xB2hOzH6LieTzltFhtCMQWby33Tbz+/wcsgHnqHZZ0gJKm3hRnbB9lq8dr7/Urj+MTrT3LRwOGjhjsC+BE98+wkFGgctDZNxRqQsEYtjLSjUj7lBAzyWmPALzsk9YwFeq4gLPFuaaLGHY5SJZF1ITH0u9Wz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523452; c=relaxed/simple;
	bh=P4ahuRqKcidMxXgK+Vt8kDvXfaSyEoM6o0sLAnkmz8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia77GXD/lzlNYShHR1dH4y+Dsz4UbHL60DcrC+piaQ5UzEC1TFlmDHWoVVa3y0boK1oKYIB2c7meAqLwoWZsO60/cfR6rcvryBG7eN+CRBtk90SW5YKE4pe1CqhYQC6RzJQzolYm5+YrtZuBCOtXN5CUhE+t8AwsazLGUtjyfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDIRyhBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD8C433C7;
	Fri, 15 Mar 2024 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523451;
	bh=P4ahuRqKcidMxXgK+Vt8kDvXfaSyEoM6o0sLAnkmz8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDIRyhBj+o7szPndtNfibGKwc6B/jmsPBQrnW4leDPaJq2jC3GYZhfTPg3rZw/T4J
	 UoZaf6MUTmg6m1hY4ah5sznYGxq0ri35iUeAk8gAmGzlD26PL43Yq5VUAtNf9r8RgZ
	 fHzKRtC2d3NGOYtFwwMfTVpfdD04NAW37cRVpbnx5fGcX8rlEYUUcn3ZG6iLj3UvG5
	 i/dS/yLOEiBMuUFWB3L6gGwRcQHW6x3jWcj4IzTMvL0USM+067bzArXCv8dCbSmruA
	 3gDqwiRv0SYucUSJOoY5Wwjn77KIJ9gmcx4uJmAAV0kv+WnHkvPO/L4ZDurN7U+Dqv
	 s3SFEZB1M1B0A==
Date: Fri, 15 Mar 2024 11:24:09 -0600
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
Subject: Re: [PATCH v4 2/6] dt-bindindgs: clock: nxp: support i.MX95 Camera
 CSR module
Message-ID: <20240315172409.GA1506658-robh@kernel.org>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240314-imx95-blk-ctl-v4-2-d23de23b6ff2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314-imx95-blk-ctl-v4-2-d23de23b6ff2@nxp.com>

On Thu, Mar 14, 2024 at 09:25:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX95 Camera CSR is a set of registers that provides various
> configuration and status of the Camera modules’ operations. Registers
> are available to enable clock gating to the ISP and CSI-2 pixel
> formatters, enable transport of various pixel data and non-pixel data
> types, control their routing, and other functions. Status registers
> provide pixel data type error information and pending transaction
> from Camera NoC initiators.
> 
> This patch is to add clock features for Camera CSR.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-camera-csr.yaml       | 50 ++++++++++++++++++++++
>  include/dt-bindings/clock/nxp,imx95-clock.h        |  7 +++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-camera-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-camera-csr.yaml
> new file mode 100644
> index 000000000000..e62494e3a8b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-camera-csr.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nxp,imx95-camera-csr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX95 Camera MIX Block Control
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nxp,imx95-camera-csr
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
> +      compatible = "nxp,imx95-camera-csr", "syscon";
> +      reg = <0x4ac10000 0x10000>;
> +      #clock-cells = <1>;
> +      clocks = <&scmi_clk 62>;
> +      power-domains = <&scmi_devpd 3>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
> index 9d8f0a6d12d0..c671c4dbb4d5 100644
> --- a/include/dt-bindings/clock/nxp,imx95-clock.h
> +++ b/include/dt-bindings/clock/nxp,imx95-clock.h
> @@ -11,4 +11,11 @@
>  #define IMX95_CLK_VPUBLK_JPEG_DEC		2
>  #define IMX95_CLK_VPUBLK_END			3
>  
> +#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
> +#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
> +#define IMX95_CLK_CAMBLK_ISP_AXI		2
> +#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
> +#define IMX95_CLK_CAMBLK_ISP			4
> +#define IMX95_CLK_CAMBLK_END			5

Same issue here. With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>

