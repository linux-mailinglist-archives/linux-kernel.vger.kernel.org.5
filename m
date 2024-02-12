Return-Path: <linux-kernel+bounces-61874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BF8517A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA0B1C21A04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC90A3C08D;
	Mon, 12 Feb 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAn74EIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727E39FE2;
	Mon, 12 Feb 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750562; cv=none; b=UAbDXUFACfQ/6flIsKrkgs+/JDve1SPu59FVfbUZ/BgkxkcKsTZee6LXiHS1oAU40/J8+/IcFcvvuYEUThb19afDyCX6MU5jMH1kLRUOyOzNajx32XlHTb7uQ5SJTzPWXTVg1S0eq7JUiqMph1LWCAp0JW32plTX+axHQxSjoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750562; c=relaxed/simple;
	bh=yAOkRRvjwv0S1+/IBcGtUlV6pwova0U+FDIhzivG/SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs9E3j0uhtaQVf27fmOwT6ofB2D8hSU1fJxf4fPe9xEljAOrvsiTO7gXQ3M1SGb4VIA+tsHtYzqy94pLFL9OKlTjE22mdotupsXhFCdQGviwdUGwa5TSHNaz06hVoA+GK2SaUKjqFKiGfRynXbcEOv7x6OBxFKAA+qtWsaUGXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAn74EIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B400C433C7;
	Mon, 12 Feb 2024 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707750561;
	bh=yAOkRRvjwv0S1+/IBcGtUlV6pwova0U+FDIhzivG/SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAn74EIu+LiKxryemabhTTWmxdG1H0OUYxtdtUk58L2JJvitUNU/cMpLvib/7e3ZF
	 GyaJqLf6R4obxWHl4A0CKWxZ8v7s618EBSNbo2zgkcofKhrbkXvwfh76F5vSFpoDFx
	 f7Sa0BwsgQH9IIRjrjhbDNvUOmyjJJI/DLQGMq1UNzwQ8MGGNgOE/dvxhlK3cQh+0D
	 M/kzmJQ309gKGHseJLhnah/1om5lt8ZO4vUNLItyn9PUadYFPzLDKRuklI1uRN30r0
	 pIlGc6QAo328AEFxAzio0CfqAUQJU00ms9+dOggbBKjWvtMplKBzp4qqQB6pLi7UJ3
	 kqSSOTJlM9Mlg==
Date: Mon, 12 Feb 2024 09:09:19 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Message-ID: <20240212150919.GA322668-robh@kernel.org>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-1-3cb743020933@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-imx95-bbm-misc-v1-1-3cb743020933@nxp.com>

On Fri, Feb 02, 2024 at 02:34:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX SCMI Extension protocol BBM and MISC binding.

No idea what BBM and MISC are.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/nxp,scmi.yaml     | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
> new file mode 100644
> index 000000000000..00d6361bbbea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/nxp,scmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX System Control and Management Interface (SCMI) Protocol Extension
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +allOf:
> +  - $ref: arm,scmi.yaml#
> +
> +properties:
> +  protocol@11:

Wrong unit-address?

> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false

Description of what this protocol is needed.

> +
> +    properties:
> +      reg:
> +        const: 0x81
> +
> +  protocol@13:
> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x84
> +
> +      wakeup-sources:

Is this somehow generic?

> +        description: each entry consists of 2 integers and represents the source and edge

What does 'edge' mean in this context?

> +        items:
> +          items:
> +            - description: the wakeup source
> +            - description: the wakeup edge

Constraints?

> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +        scmi {


Need a compatible here so this actually gets tested.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            protocol@81 {
> +              reg = <0x81>;
> +            };
> +
> +            protocol@84 {
> +              reg = <0x84>;
> +              wakeup-sources = <6 1
> +                                7 1
> +                                8 1
> +                                9 1
> +                                10 1>;

<> around each entry. e.g. "<6 1>"

> +            };
> +         };
> +    };
> +...
> 
> -- 
> 2.37.1
> 

