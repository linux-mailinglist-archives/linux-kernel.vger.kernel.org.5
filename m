Return-Path: <linux-kernel+bounces-145980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8EE8A5DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF97F1F225C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FD15885D;
	Mon, 15 Apr 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF9eMSCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F30157A61;
	Mon, 15 Apr 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221411; cv=none; b=kdkEREADhb32cXHF7clkQg0XdMYANHZdTpu+L+Ub5bNBofjcfoE9HoDxvw9F6KYIW18wwLjUcuq9quOWl5khnMkguDvSE7Fw+Dw10VgXN44NftFLqT1Xz5FcOvWMqOteYIdG3RzUekbcmjyK0ovXFommUR7PXpPV51DEtpfwwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221411; c=relaxed/simple;
	bh=XQflHWjLtfBqmLW9YuWPGSLd+/yNt5LVkKKP+zVIWbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+gfASvNEsc3ieO9eZaBuPJk9igO+NvgpWJAMg7eqXIMehpAH1SclmYGcNlqJAu4EAxM4zb0qAVztmWjGHMu6LxI/zX0uVS4k0hT7FxRyIo42jVFXuHLZhPmCs/STKLzkxA9jfrWMvL8wSnUCSiu4pecqkg0uVcMRtxtD0BSAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF9eMSCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E21CC113CC;
	Mon, 15 Apr 2024 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713221410;
	bh=XQflHWjLtfBqmLW9YuWPGSLd+/yNt5LVkKKP+zVIWbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GF9eMSCCyHkgZppLsVudsI8BK8v4ia6whL8QBseAqO5yBcpF1QBcFy3P0GRAiHq7w
	 HjKOPgJe8GX3FfDue0lxTpFw9QeEzkopqN15sILVi084PRqgyRKwUYmaroPjLN+lIZ
	 Qf6pxik+Wz3cqMzs5ZWTe0FmyfAewI1clCQjav1Et/EaiVXNwvAVakS5OSd8dYIClX
	 vSjP8CuNQtonclIB/2/ASHhr3QD5jeoH5gnuDCJK0KitPOiJAWVqQ2aFDptSm7cDIt
	 xAU+ZV5HeGVbzQkTE4EiUYReC+JVxst3k20HyykiumBOw6diO9gVy+vSFfwDBHWZty
	 NeF+teqebAZ5g==
Date: Mon, 15 Apr 2024 17:50:08 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Message-ID: <20240415225008.GA215835-robh@kernel.org>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>

On Fri, Apr 12, 2024 at 08:29:25AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
> patch is to add i.MX95 Pinctrl OEM extensions properties.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/pinctrl/nxp,imx95-pinctrl.yaml        | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> new file mode 100644
> index 000000000000..4bf7a6192813
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nxp,imx95-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
> +
> +maintainers:
> +  - Peng Fan <peng.fan@arm.com>
> +
> +patternProperties:
> +  '-pins$': false

Why?

> +  'grp$':
> +    type: object

Missing 'additionalProperties: false'

> +
> +    properties:
> +      $nodename:
> +        pattern: "^[0-9a-f]+$"

Drop. That has no effect. You just defined the nodename above.

> +
> +      pins:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: name of the pin

Needs to define the possible values.

> +
> +      nxp,func-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: high impedance mode ("third-state", "floating")

We already have a standard property for high impendance. You should know 
that since you obviously copied the description...

> +
> +      nxp,pin-conf:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: latch weakly

Same here.

> +
> +      nxp,daisy-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: pull up the pin. Takes as optional argument on hardware
> +          supporting it the pull strength in Ohm.

And here...

> +
> +      nxp,daisy-conf:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: pull down the pin. Takes as optional argument on hardware
> +          supporting it the pull strength in Ohm.

And here...

> +
> +additionalProperties: true
> 
> -- 
> 2.37.1
> 

