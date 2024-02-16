Return-Path: <linux-kernel+bounces-68337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5D8578F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD371C214D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A81BC3F;
	Fri, 16 Feb 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uNUjB6Gw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006E1BDCE;
	Fri, 16 Feb 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076221; cv=none; b=eV0JCAULSM1mhbCaIqS5UxKxmavdBg6ibDnnJLLgA7tGwZF12EvfCFvcuz+g37dyvY+KQUCkPnvLHgYfEc9/S7uoru7DsIz0wV695leTKqqCGR0n4gwqd6MkQKWls/9xn3dk1IrcFUI7pKAJJPfvo/TI+AorONVnJPbdfIHCzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076221; c=relaxed/simple;
	bh=FqIG4hQ/2p90XglkBfcZ3NnAeisl+tmJAkWr6NZhF0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeaHNi2vczmQWIcfTaNgoPE68Zd1SaAh1ZR8kG5ys2a5nY5j8UaK/fq9EDn4ER86JGkZrD2ezugz6OJ5WWlDZ8dIFhNoM5EfMZ4sGV82CZuzDEt8ly4ZxUOvDqmSpWeQBo61pXQoX8Wzi0xpjGMNXGE8srl6q+X+208iQCz/zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uNUjB6Gw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8B746B3;
	Fri, 16 Feb 2024 10:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708076212;
	bh=FqIG4hQ/2p90XglkBfcZ3NnAeisl+tmJAkWr6NZhF0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNUjB6Gw3OxkvkHlmGSI/pkrf1LZkc1jpT/X9oJcmmrO5PwnbIe8er7efnoLnnde4
	 EJCR+DW8RAqM7mraBwyYb41PjGtQ2zQu7cWh/h/nBhV0w0TvfPG5Urbm3zm5QqRtJz
	 JzCOTixie+sNZIGN5ZidIK9mD6GREBUJXuiNf14Q=
Date: Fri, 16 Feb 2024 11:37:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
	marex@denx.de, frieder.schrempf@kontron.de,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 09/12] dt-bindings: display: imx: add binding for
 i.MX8MP HDMI TX
Message-ID: <20240216093700.GA10584@pendragon.ideasonboard.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-10-aford173@gmail.com>
 <5916132.MhkbZ0Pkbq@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5916132.MhkbZ0Pkbq@steina-w>

On Fri, Feb 16, 2024 at 10:05:26AM +0100, Alexander Stein wrote:
> Hi all,
> 
> Am Samstag, 3. Februar 2024, 17:52:49 CET schrieb Adam Ford:
> > From: Lucas Stach <l.stach@pengutronix.de>
> > 
> > The HDMI TX controller on the i.MX8MP SoC is a Synopsys designware IP
> > core with a little bit of SoC integration around it.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > 
> > ---
> > V3:  Change name and location to better idenfity as a bridge and
> >      HDMI 2.0a transmitter
> > 
> >      Fix typos and feedback from Rob and added ports.
> > ---
> >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 102 ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> > b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> > new file mode 100644
> > index 000000000000..3791c9f4ebab
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX8MP DWC HDMI TX Encoder
> > +
> > +maintainers:
> > +  - Lucas Stach <l.stach@pengutronix.de>
> > +
> > +description:
> > +  The i.MX8MP HDMI transmitter is a Synopsys DesignWare
> > +  HDMI 2.0a TX controller IP.
> > +
> > +allOf:
> > +  - $ref: /schemas/display/bridge/synopsys,dw-hdmi.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8mp-hdmi-tx
> > +
> > +  reg-io-width:
> > +    const: 1
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: iahb
> > +      - const: isfr
> > +      - const: cec
> > +      - const: pix
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Parallel RGB input port
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: HDMI output port
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> 
> Is this really correct that port@1 is required? AFAICS this host already 
> supports HPD and DDC by itself, so there is no need for a dedicated HDMI 
> connector.

The chip has an HDMI output, so there's an output port.

> With the current state of the drivers this output port is completely ignored 
> anyway. Yet it works for a lot of people.

DT bindings describe the hardware. From a DT point of view, tt's fine
for drivers to ignore the port (that may or may not be true from a DRM
point of view, but that's a separate discussion).

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - power-domains
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mp-clock.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/imx8mp-power.h>
> > +
> > +    hdmi@32fd8000 {
> > +        compatible = "fsl,imx8mp-hdmi-tx";
> > +        reg = <0x32fd8000 0x7eff>;
> > +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&clk IMX8MP_CLK_HDMI_APB>,
> > +                 <&clk IMX8MP_CLK_HDMI_REF_266M>,
> > +                 <&clk IMX8MP_CLK_32K>,
> > +                 <&hdmi_tx_phy>;
> > +        clock-names = "iahb", "isfr", "cec", "pix";
> > +        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
> > +        reg-io-width = <1>;
> > +        ports {
> > +           #address-cells = <1>;
> > +           #size-cells = <0>;
> > +           port@0 {
> > +             reg = <0>;
> > +
> > +             hdmi_tx_from_pvi: endpoint {
> > +               remote-endpoint = <&pvi_to_hdmi_tx>;
> > +             };
> > +          };
> > +
> > +          port@1 {
> > +            reg = <1>;
> > +              hdmi_tx_out: endpoint {
> > +                remote-endpoint = <&hdmi0_con>;
> > +              };
> > +          };
> > +        };
> > +    };

-- 
Regards,

Laurent Pinchart

