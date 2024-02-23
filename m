Return-Path: <linux-kernel+bounces-78242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9459D86109D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33ACE28179A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6D7B3DF;
	Fri, 23 Feb 2024 11:38:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52F78665;
	Fri, 23 Feb 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688295; cv=none; b=syIIPLhE0tHQHdNd/fEpwDYlo9DJlwLq97A/Hdl0ESRjwbtARO3ZYFqIFDItl/FDDqw13sSuyvJlYs9gQk7173WgGPW42S0Dsb3nxUoQHan4G6Sy0Jj1CloTfiTS/BgpUg1kbO/06r+Gtj3Ym77lCuoVoOg0EIgiC3/wNhan6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688295; c=relaxed/simple;
	bh=1w5motAc41BNaAEB9ZtHEo966w0phI8Cd6L7pC6Oe/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXSNZFzmyEiMlkquTuESLgCoQIy7J5lH+/zM8Rpynf6SdR1DV5D3gn+TXBuPvyNWVnf11nBSgMy69OMPsSt828avUO6RnJ2VsLCf0yGlVk1eHD7ICOwlRaVLOYH2GWDYGfp1FcmaidBUQwzQyeVCjUeQaM9OE0+mfWEyzL9huOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A1911FB;
	Fri, 23 Feb 2024 03:38:52 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828FC3F762;
	Fri, 23 Feb 2024 03:38:11 -0800 (PST)
Date: Fri, 23 Feb 2024 11:38:09 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Message-ID: <ZdiDob6oBc7Jh28a@pluto>
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
> 

Hi,

just a few remarks down below only about the SCMI related stuff...

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

.. (SCMI) Vendor Protocols

> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +allOf:
> +  - $ref: arm,scmi.yaml#
> +
> +properties:
> +  protocol@11:

protocol@81 ?

> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x81
> +
> +  protocol@13:

protocol@84 ?

> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x84
> +
> +      wakeup-sources:
> +        description: each entry consists of 2 integers and represents the source and edge
> +        items:
> +          items:
> +            - description: the wakeup source
> +            - description: the wakeup edge
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +        scmi {
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
> +            };
> +         };
> +    };
> +...
> 

Thanks,
Cristian

