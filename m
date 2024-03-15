Return-Path: <linux-kernel+bounces-104722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93287D2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04001C21A59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2284F1E2;
	Fri, 15 Mar 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp4OKRwl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFF4CB55;
	Fri, 15 Mar 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523604; cv=none; b=P2ZEEt1l7qGqiGmcbrgo8PRa7nedhmU3UC72Ohave3yeSwviBF9VO2qSF9qnPd/iQPaZ84NeBps/6zZz4Nu8Rg6LNNjFoXB49e8e1GlgbGu2XdMqubOY0FOfh2Mpqe6Rbkc7TdJAbeERINV7Eqg0AlnH4A98dRbsEEK2iMEeIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523604; c=relaxed/simple;
	bh=b0NPVoRfXgblGxVCKQfzT2OEWtrPIrXoAQnfrFqKt10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBFargpL9gNgfJvNiwwx7jhxl9X36vTsi/hdY0WhsZau89/wdM/qV0CVwrKLtw1JmK0DXyS+DM5VYhsl2DAEYgZZcrm40cwiVLoweGLlabWyZNx5qvyfSmyB/WjPPaVo0ePxnVFFrX1AnTY6VKVIW5waiL/PA8iSegkH/VAONi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp4OKRwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60598C433C7;
	Fri, 15 Mar 2024 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523603;
	bh=b0NPVoRfXgblGxVCKQfzT2OEWtrPIrXoAQnfrFqKt10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bp4OKRwlby5YQT52s4vye+yeKgE8iovOoAuuNQxzS551d8W2aDpmMmSiLvH27hv2W
	 5xI0s31RCpBrsbKeDvSbMW/V4B5ZMKKlyOOd8xhfSddg567dS+MBH4+Y/c/oYh6ZXM
	 lLKO0kQ2twUimmlPqhuP7FGLgSk0oEMzoXyM9rY3u/l9nxCEOUssiAFrcNk1Or7FEB
	 yizi9Ex+SutWy0bcIYOD5rx3ZvOZOEmKKgIAEWcrNX4XTodnrF45+Ap2kDjTUhgWfq
	 lUSw11rj+UK17zIMtmI09ha6S5RD9plEOfk+6jOV8YqyGEUglJ4Lweff4yahlEX61t
	 ob0wCHkTWEpEw==
Date: Fri, 15 Mar 2024 11:26:41 -0600
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
Subject: Re: [PATCH v4 3/6] dt-bindindgs: clock: nxp: support i.MX95 Display
 Master CSR module
Message-ID: <20240315172641.GB1506658-robh@kernel.org>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240314-imx95-blk-ctl-v4-3-d23de23b6ff2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-imx95-blk-ctl-v4-3-d23de23b6ff2@nxp.com>

On Thu, Mar 14, 2024 at 09:25:12PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 DISPLAY_MASTER_CSR includes registers to control DSI clock settings,
> clock gating, and pixel link select. Add dt-binding for it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../clock/nxp,imx95-display-master-csr.yaml        | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
> new file mode 100644
> index 000000000000..ed0ec3a24d09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nxp,imx95-display-master-csr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX95 Display Master Block Control
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nxp,imx95-display-master-csr
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

Forget this header changes here?

