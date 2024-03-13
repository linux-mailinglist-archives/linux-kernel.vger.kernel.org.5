Return-Path: <linux-kernel+bounces-102529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049C87B365
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1621C2230D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99553E22;
	Wed, 13 Mar 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EZaNJU13"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452D1A38DB;
	Wed, 13 Mar 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364905; cv=none; b=K5Ivf0Q3JAN3i+obI4HCI2vMmXFg7qBPfn8Cf/uPMujWoT1s1ST7gXYVLfR8J+396o7iEnoHS1tYlDAhEI9NHvZFoG2CDFa23e4B153UNV/NOFsX7qndp8ftgyGn6+0jL66xQEyCL1A33KIEK5F0ZYi4qOYHZLTMlW/T87J2Tak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364905; c=relaxed/simple;
	bh=SpKyPDhdUaclvqwD0w0SBBHsdGTcEavK9/1NEyIyJ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLCLRJQZFbCFR0xSsKFQo5ZpSaRgijsECEo9Uzan8w5YpMrSbjPfWpjFLni5edYyVE2KOI4eQRk8o1BsHzFAc3PlFGSRxRvDhKBFiG91tfqEZeHl4HPFkyh5gTDeFXuPXnTdFYxn9dJbQzfLlW1TRaITdooaS6o6jY5dMs3TgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EZaNJU13; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [95.214.66.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F902899;
	Wed, 13 Mar 2024 22:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710364878;
	bh=SpKyPDhdUaclvqwD0w0SBBHsdGTcEavK9/1NEyIyJ6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZaNJU132v9GHYBCDIhE9Rr8BmzGK9eDNCz6eYfiZssFXR0yiKWnswn95ClwH8KZf
	 LnwVT/n+H37h5va5YW3vMG1jyUoQAoMUcJgizCpxY/eKkLUHQ2ZnzeTwI4M7pWQn74
	 dji/Eirs9MST8usKx3oAD2kD6Z/ZtkrkOTZzwuJ8=
Date: Wed, 13 Mar 2024 23:21:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	willl will <will@willwhang.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	tomi.valkeinen@ideasonboard.com, Rob Herring <robh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] media: dt-bindings: media: Add bindings for IMX283
Message-ID: <20240313212149.GA4372@pendragon.ideasonboard.com>
References: <20240313070705.91140-1-umang.jain@ideasonboard.com>
 <20240313070705.91140-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313070705.91140-2-umang.jain@ideasonboard.com>

On Wed, Mar 13, 2024 at 12:36:58PM +0530, Umang Jain wrote:
> - Add dt-bindings documentation for Sony IMX283 sensor driver
> - Add MAINTAINERS entry for Sony IMX283 binding documentation
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/media/i2c/sony,imx283.yaml       | 107 ++++++++++++++++++
>  MAINTAINERS                                   |   8 ++
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> new file mode 100644
> index 000000000000..e4f49f1435a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Ideas on Board Oy
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/sony,imx283.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony IMX283 Sensor
> +
> +maintainers:
> +  - Kieran Bingham <kieran.bingham@ideasonboard.com>
> +  - Umang Jain <umang.jain@ideasonboard.com>
> +
> +description:
> +  IMX283 sensor is a Sony CMOS active pixel digital image sensor with an active
> +  array size of 5472H x 3648V. It is programmable through I2C interface. The
> +  I2C client address is fixed to 0x1a as per sensor data sheet. Image data is
> +  sent through MIPI CSI-2.
> +
> +properties:
> +  compatible:
> +    const: sony,imx283
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: Clock frequency from 6 to 24 MHz.
> +    maxItems: 1
> +
> +  vadd-supply:
> +    description: Analog power supply (2.9V)
> +
> +  vdd1-supply:
> +    description: Interface power supply (1.8V)
> +
> +  vdd2-supply:
> +    description: Digital power supply (1.2V)

Those two supplies are named vddd1 and vddd2 in the datasheet.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +  reset-gpios:
> +    description: Sensor reset (XCLR) GPIO
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            anyOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +
> +          link-frequencies: true
> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        camera@1a {
> +            compatible = "sony,imx283";
> +            reg = <0x1a>;
> +            clocks = <&imx283_clk>;
> +
> +            assigned-clocks = <&imx283_clk>;
> +            assigned-clock-parents = <&imx283_clk_parent>;
> +            assigned-clock-rates = <12000000>;
> +
> +            vadd-supply = <&camera_vadd_2v9>;
> +            vdd1-supply = <&camera_vdd1_1v8>;
> +            vdd2-supply = <&camera_vdd2_1v2>;
> +
> +            port {
> +                imx283: endpoint {
> +                    remote-endpoint = <&cam>;
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <360000000>;
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73d898383e51..32f790c3a5f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20368,6 +20368,14 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
>  F:	drivers/media/i2c/imx274.c
>  
> +SONY IMX283 SENSOR DRIVER
> +M:	Kieran Bingham <kieran.bingham@ideasonboard.com>
> +M:	Umang Jain <umang.jain@ideasonboard.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> +
>  SONY IMX290 SENSOR DRIVER
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-media@vger.kernel.org

-- 
Regards,

Laurent Pinchart

