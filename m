Return-Path: <linux-kernel+bounces-63588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B78531D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533571C21EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5ED55C27;
	Tue, 13 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSkSsUoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B964205D;
	Tue, 13 Feb 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830816; cv=none; b=eHnAWyscxKigensXs+h+vevesB12vzcqa//4AxoyHFz/e+CigT9iEVCju4z3hCQoykwci+oreat9BQ7SZ7s76WgrPgHJNg0wMqvb1god4yuT3RfaTaqS0UuBSl3B0o4+vBWdEYZYNoVCKG5FGhGe0RhZtqq6LodTQFPIiKon4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830816; c=relaxed/simple;
	bh=j+kLwBvDzOosGdaB+n0WIx8jWxPFmdI1JoZl3OecFCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDk+WinsiO3SvV5a8gqUFbYs/6bRK/kaNwe1MZQ/4XqakHNDBI5dasxfm655ikg75KxhECamYr64DZIm5Y93B801KMwx1MirukmkfWOJLVUSTy0mWkmJ8Rv8xhfLesjxet1gpFW71di3DB3Z1jWx6Tkp1dHTPneBNTZntwxJsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSkSsUoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384F4C43390;
	Tue, 13 Feb 2024 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707830816;
	bh=j+kLwBvDzOosGdaB+n0WIx8jWxPFmdI1JoZl3OecFCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSkSsUoH0kFZQUBkWcqMfHjsCLQd18O1kGFqqZAkPTqkTQpe6Q6G7dUPzGR9VKLku
	 L6yV5aVKuKBeEWhTTbKM3bM43VrWoZ5BJD3O0qlyImW/uullvY5LfG1IGJ2vqFBUvi
	 bUUnm+aDSSxrrHk6clpsMh52o9kAgd1M6VF311jLZKtvD/9RnTKQ6T5hFlrH3tCNas
	 VeuT6E7RicehWYhccNoT96KmfYXH0oyAoXE1vcDeIhKWEAiqDLUUM4NnKX42fJg9Q6
	 doSi09etRiWXvOgK862+Rcoaec460nmknPimq8kc+fZSGDFFy90SeScMhtKc59zp6e
	 Vdp1nYCAHsbiw==
Date: Tue, 13 Feb 2024 07:26:54 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/17] dt-bindings: bus: imx-weim: convert to YAML
Message-ID: <20240213132654.GA1051154-robh@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-3-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213010347.1075251-3-sre@kernel.org>

On Tue, Feb 13, 2024 at 02:00:51AM +0100, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/bus/imx-weim.txt      | 117 ----------
>  .../fsl/fsl,imx-weim-peripherals.yaml         |  36 ++++
>  .../memory-controllers/fsl/fsl,imx-weim.yaml  | 201 ++++++++++++++++++
>  .../mc-peripheral-props.yaml                  |   1 +
>  .../fieldbus/arcx,anybus-controller.txt       |   2 +-
>  5 files changed, 239 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml


> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
> new file mode 100644
> index 000000000000..86d7e5011107
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX WEIM Bus Peripheral Nodes
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +description:
> +  This binding is meant for the child nodes of the WEIM node. The node
> +  represents any device connected to the WEIM bus. It may be a Flash chip,
> +  RAM chip or Ethernet controller, etc. These properties are meant for
> +  configuring the WEIM settings/timings and will accompany the bindings
> +  supported by the respective device.
> +
> +properties:
> +  reg: true
> +
> +  fsl,weim-cs-timing:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Timing values for the child node.
> +    minItems: 2
> +    maxItems: 6
> +
> +required:
> +  - compatible
> +  - reg
> +  - fsl,weim-cs-timing

This should be marked required in fsl,imx-weim.yaml instead to fix the 
errors.

Really, the other required ones should be in mc-peripheral-props.yaml as 
it applies to everyone.

> +
> +# the WEIM child will have its own native properties
> +additionalProperties: true

