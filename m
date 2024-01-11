Return-Path: <linux-kernel+bounces-23190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D982A8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488151F276E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E3E55F;
	Thu, 11 Jan 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CvRmlcUc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF521DF5E;
	Thu, 11 Jan 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EC6EC85;
	Thu, 11 Jan 2024 09:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704960857;
	bh=kkDLkfafgifBK/qqR8wZuC6H24XJLUeDEmU02c9PAoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvRmlcUcAL2fz+ZsrBcQVO8RmcXC6wU94oBlgnTtNbUx2QLsZU6CuMjcNkXRlPZiz
	 wAcnB2yYLfTYNexZ3WwUDVElCb7FIENGFR9fpBIX5L3HXZFNP4gQMpXke1rFkBNNnS
	 /owabKPwRi670NCL+inSeVDAvBPK9DD4veH6MKlM=
Date: Thu, 11 Jan 2024 10:15:30 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Louis Kuo <louis.kuo@mediatek.com>,
	Phi-Bang Nguyen <pnguyen@baylibre.com>,
	Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: media: add mediatek ISP3.0 sensor
 interface
Message-ID: <20240111081530.GB30988@pendragon.ideasonboard.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-2-jstephan@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110141443.364655-2-jstephan@baylibre.com>

Hi Julien,

Thank you for the patch.

On Wed, Jan 10, 2024 at 03:14:38PM +0100, Julien Stephan wrote:
> From: Louis Kuo <louis.kuo@mediatek.com>
> 
> This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
> some Mediatek SoC, such as the mt8365
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Link: https://lore.kernel.org/r/20230807094940.329165-2-jstephan@baylibre.com
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../media/mediatek,mt8365-seninf.yaml         | 259 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 266 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> new file mode 100644
> index 000000000000..0a7b7d949df7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> @@ -0,0 +1,259 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2023 MediaTek, BayLibre
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Sensor Interface 3.0
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +  - Julien Stephan <jstephan@baylibre.com>
> +  - Andy Hsieh <andy.hsieh@mediatek.com>
> +
> +description:
> +  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface found in
> +  multiple MediaTek SoCs. It can support up to three physical CSI-2
> +  input ports, configured in DPHY (2 or 4 data lanes) or CPHY depending on the soc.

s/soc/SoC/

And while at it, you can reflow the text to 80 columns.

> +  On the output side, SENINF can be connected either to CAMSV instance or
> +  to the internal ISP. CAMSV is used to bypass the internal ISP processing
> +  in order to connect either an external ISP, or a sensor (RAW, YUV).
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8365-seninf
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Seninf camsys clock
> +      - description: Seninf top mux clock
> +
> +  clock-names:
> +    items:
> +      - const: camsys
> +      - const: top_mux
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      phandle to the PHYs connected to CSI0/A, CSI1, CSI2 and CSI0B
> +
> +  phy-names:
> +    minItems: 1
> +    items:
> +      - const: csi0
> +      - const: csi1
> +      - const: csi2
> +      - const: csi0b
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI0 or CSI0A port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI1 port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI2 port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI0B port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 2
> +
> +      port@4:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for cam0
> +
> +      port@5:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for cam1
> +
> +      port@6:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv0
> +
> +      port@7:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv1
> +
> +      port@8:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv2
> +
> +      port@9:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv3
> +
> +    required:
> +      - port@0
> +      - port@1
> +      - port@2
> +      - port@3
> +      - port@4
> +      - port@5
> +      - port@6
> +      - port@7
> +      - port@8
> +      - port@9
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +    soc {
> +          #address-cells = <2>;
> +          #size-cells = <2>;
> +
> +          seninf: seninf@15040000 {
> +                compatible = "mediatek,mt8365-seninf";
> +                reg = <0 0x15040000 0 0x6000>;
> +                interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
> +                clocks = <&camsys CLK_CAM_SENIF>,
> +                         <&topckgen CLK_TOP_SENIF_SEL>;
> +                clock-names = "camsys", "top_mux";
> +
> +                power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +
> +                phys = <&mipi_csi0 PHY_TYPE_DPHY>;
> +                phy-names = "csi0";
> +
> +                ports {
> +                      #address-cells = <1>;
> +                      #size-cells = <0>;
> +
> +                      port@0 {
> +                            reg = <0>;
> +                            seninf_in1: endpoint {
> +                              clock-lanes = <2>;
> +                              data-lanes = <1 3 0 4>;
> +                              remote-endpoint = <&isp1_out>;

Indentation issue, you need two more spaces here.

With these small issues fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +                            };
> +                      };
> +
> +                      port@1 {
> +                          reg = <1>;
> +                      };
> +
> +                      port@2 {
> +                            reg = <2>;
> +                      };
> +
> +                      port@3 {
> +                            reg = <3>;
> +                      };
> +
> +                      port@4 {
> +                            reg = <4>;
> +                            seninf_camsv1_endpoint: endpoint {
> +                                remote-endpoint = <&camsv1_endpoint>;
> +                            };
> +                      };
> +
> +                      port@5 {
> +                            reg = <5>;
> +                      };
> +
> +                      port@6 {
> +                            reg = <6>;
> +                      };
> +
> +                      port@7 {
> +                            reg = <7>;
> +                      };
> +
> +                      port@8 {
> +                            reg = <8>;
> +                      };
> +
> +                      port@9 {
> +                            reg = <9>;
> +                      };
> +
> +                };
> +          };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41e0862cfa7d..4444e719cf8e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13611,6 +13611,13 @@ M:	Sean Wang <sean.wang@mediatek.com>
>  S:	Maintained
>  F:	drivers/char/hw_random/mtk-rng.c
>  
> +MEDIATEK ISP3.0 DRIVER
> +M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +M:	Julien Stephan <jstephan@baylibre.com>
> +M:	Andy Hsieh <andy.hsieh@mediatek.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> +
>  MEDIATEK SMI DRIVER
>  M:	Yong Wu <yong.wu@mediatek.com>
>  L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)

-- 
Regards,

Laurent Pinchart

