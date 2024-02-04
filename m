Return-Path: <linux-kernel+bounces-51683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34D848E37
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F991F21A3D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9B225AF;
	Sun,  4 Feb 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WFXe4dUJ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54F224EA;
	Sun,  4 Feb 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054662; cv=none; b=snWAN0UIx3mjdmNWBFrKgOo2Wr3Y2ucKT+c5+NqhZV9ensNTUWCkKL89JkIlactwajnjvUjv9AIjCzUrEdKsCx93oxuSSxJsQ3bNGV3HG4Y7eDP+yXBDvAXsZOTofi1a7YOjHQUobSJpd7fMYO3sH+x/9keB/m2/zI5d+wqm3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054662; c=relaxed/simple;
	bh=4/u6c8A7HPqivSqSRYin51hS3p0zUCCOPF4PXCVBzYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLiyQBk7ybijItT0mXRFi1Gs0bUI/v7w42qp3BZOwY/U5OMYiyQdEUi2Lwb62fX+PCkF7s6TLw6NAkPeDx0BzMZxsErpyfL+CEDBkQwY6LjMQ3qy1UyybC85y1I81VkUj1OyaRkehKu8m+mtl7YQHQOpnsxmsK0X2nTqhHTzMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WFXe4dUJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [151.216.142.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9F6C720;
	Sun,  4 Feb 2024 14:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707054574;
	bh=4/u6c8A7HPqivSqSRYin51hS3p0zUCCOPF4PXCVBzYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFXe4dUJuMzaOEeLaWAsJL0smy/yif2Tw2PnsZJwJZ0fYQAKJsFHBBLkxOO8SOxAJ
	 FLUVjjt/qc56Z5GGKRLMPL2MEeq/6pHs41aZU6UJx1idAkEaqURxI8C8Nweik+Ssb4
	 3N2pN5Ch1jqlWKbR+g87QY5aTUTVAvPlY2I3AvMA=
Date: Sun, 4 Feb 2024 15:50:56 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, sakari.ailus@linux.intel.com,
	shengnan.wang@mediatek.com, yaya.chang@mediatek.com,
	10572168@qq.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
	yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jacopo.mondi@ideasonboard.com, hverkuil-cisco@xs4all.nl,
	heiko@sntech.de, jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	linus.walleij@linaro.org, hdegoede@redhat.com,
	tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
	andy.shevchenko@gmail.com, bingbu.cao@intel.com,
	dan.scally@ideasonboard.com, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/2] media: dt-bindings: i2c: add GalaxyCore GC08A3
 image sensor
Message-ID: <20240204135056.GA6804@pendragon.ideasonboard.com>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
 <20240204061538.2105-2-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204061538.2105-2-zhi.mao@mediatek.com>

Hi Zhi,

Thank you for the patch.

On Sun, Feb 04, 2024 at 02:15:37PM +0800, Zhi Mao wrote:
> Add YAML device tree binding for GC08A3 CMOS image sensor,
> and the relevant MAINTAINERS entries.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/media/i2c/galaxycore,gc08a3.yaml | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> new file mode 100644
> index 000000000000..8c09e8c121e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2023 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc08a3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GalaxyCore gc08a3 1/4" 8M Pixel MIPI CSI-2 sensor
> +
> +maintainers:
> +  - Zhi Mao <zhi.mao@mediatek.com>
> +
> +description:
> +  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
> +  interface and CCI (I2C compatible) control bus. The output format
> +  is raw Bayer.
> +
> +properties:
> +  compatible:
> +    const: galaxycore,gc08a3
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dovdd-supply: true
> +
> +  avdd-supply: true
> +
> +  dvdd-supply: true
> +
> +  reset-gpios:
> +    description: Reference to the GPIO connected to the RESETB pin.
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +    description:
> +      Output port node, single endpoint describing the CSI-2 transmitter.
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            oneOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +              - items:
> +                  - const: 1
> +                  - const: 2
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
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - reset-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor@31 {
> +            compatible = "galaxycore,gc08a3";
> +            reg = <0x31>;
> +
> +            clocks = <&gc08a3_clk>;
> +
> +            reset-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
> +
> +            avdd-supply = <&gc08a3_avdd>;
> +            dovdd-supply = <&gc08a3_dovdd>;
> +            dvdd-supply = <&gc08a3_dvdd>;
> +
> +            port {
> +                sensor_out: endpoint {
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <336000000 207000000>;
> +                    remote-endpoint = <&seninf_csi_port_0_in>;
> +                };
> +            };
> +        };
> +    };
> +
> +...

-- 
Regards,

Laurent Pinchart

