Return-Path: <linux-kernel+bounces-153540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9FD8ACF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C4B250FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5031514CB;
	Mon, 22 Apr 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfRDfnea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA222625;
	Mon, 22 Apr 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796149; cv=none; b=E2n3QqqdK1nTdyj2bsFhzBwmzUhbrnq+N9ZRqb/XLFreYmdKN5Q7D7YSJsnS6dTysIToe0CzaXjtJWPQies2nodv64ihyOW5RtfJk5LEdA4gTLTSGsEHutC7IanQCFP4P8hM3MV7Esoj22A6jO72RD3y7fhJzeiqThSUPFm86xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796149; c=relaxed/simple;
	bh=nmeYAAMfDWtKUdUh/u8ThViBJ0dDSRUKYjrXdRvF6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk5tc97QjJe5WGaVQmnBirKGPDHi9VBQGBFoOLNDXUFkuDKqeh3a3Q9GmagD9uHYH7r94Vd+WKuZR/L0w74pB/Pb53QPoTSuL8E/iy9zgjG4Sv61ajQsc47JXzieQhvO35v6gGn+kZmV76HsaJEVUKnrvjsU56zCCIKQ60fxhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfRDfnea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD59AC113CC;
	Mon, 22 Apr 2024 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713796149;
	bh=nmeYAAMfDWtKUdUh/u8ThViBJ0dDSRUKYjrXdRvF6lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfRDfneaSpgilD9soWxDDn0jOddgL/VpXa7qjJiBlx/K9yvsRNHVqEFSLMC1OwCBu
	 qBO92RbLZ5ORv4KE5larndiZ2zpBeYThVL2UbyunWRvegwvKbO7Eeh1tNrPJKVC1pV
	 bjXhXuSQ/8/TtphYEC7Dm/JyUNsU2mcM6Elf/ni7/D4V4h6Fs1yrOqOOkePhstaxMt
	 nR9w+C5q2/N5Nopw7gBw4gZiU0p+Yo+6v3mXzgkOQrLxX6N7eku+AdB3tQzbXGD07y
	 jj/53hn69mBR5hV5s88sbNzq7FqfiXD7qRPxTv33LSGQi8nScMqcUfReFi+lB7zfgM
	 LbsDLu7EGYlLg==
Date: Mon, 22 Apr 2024 09:29:06 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: mfd: add schema for 8ulp AVD-SIM
Message-ID: <20240422142906.GB1207218-robh@kernel.org>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-3-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418203720.8492-3-laurentiumihalcea111@gmail.com>

On Thu, Apr 18, 2024 at 11:37:19PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for i.MX8ULP's AVD-SIM module.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/mfd/fsl,imx8ulp-avd-sim.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
> new file mode 100644
> index 000000000000..4020c6e37f80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/fsl,imx8ulp-avd-sim.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP Audio-Video Domain System Integration Module
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The AVD-SIM module provides configuration options for components of AVD.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8ulp-avd-sim
> +      - const: syscon
> +      - const: simple-mfd

'simple-mfd' means you have child nodes, but you have none defined.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

If you do add child nodes, 'simple-mfd' also means there is not any 
dependency on the parent node such as needing this clock to be enabled 
for the child nodes.

Rob

