Return-Path: <linux-kernel+bounces-24399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A182BC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E928257F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6D5D742;
	Fri, 12 Jan 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U6UnVReg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616A5C919;
	Fri, 12 Jan 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F96BC67;
	Fri, 12 Jan 2024 08:40:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705045229;
	bh=MO4/NjAx26u9xJe2adlZSy9KUvlbrcggy/xFbm+XEuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6UnVRegzaVTm42OrnsGkNMEHYm4Rn5PJNsaKSnU37eepdVp/Tv2BLSt+t19UZdic
	 kfh6h1Pa8LGdVl/KzIiIgWMtwZ47KwhnlMj0rZi1PQhA66Bbr5qkzGsg3f9+wLTZ/N
	 4ewFUQryZb+sEPuJLkQDvHj39Gp9QBPBk5Rnq+W4=
Date: Fri, 12 Jan 2024 09:41:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>,
	Phi-bang Nguyen <pnguyen@baylibre.com>,
	Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	Louis Kuo <louis.kuo@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: media: add mediatek ISP3.0 camsv
Message-ID: <20240112074141.GA21256@pendragon.ideasonboard.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-3-jstephan@baylibre.com>
 <feb4e04f-8282-4b52-b785-07bf15008e06@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feb4e04f-8282-4b52-b785-07bf15008e06@linaro.org>

On Fri, Jan 12, 2024 at 08:34:45AM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2024 15:14, Julien Stephan wrote:
> > From: Phi-bang Nguyen <pnguyen@baylibre.com>
> > 
> > This adds the bindings, for the ISP3.0 camsv module embedded in
> > some Mediatek SoC, such as the mt8365
> > 
> > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > Link: https://lore.kernel.org/r/20230807094940.329165-4-jstephan@baylibre.com
> > ---
> >  .../bindings/media/mediatek,mt8365-camsv.yaml | 109 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> > new file mode 100644
> > index 000000000000..097b1ab6bc72
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> > @@ -0,0 +1,109 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2023 MediaTek, BayLibre
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/mediatek,mt8365-camsv.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek CAMSV 3.0
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +  - Julien Stephan <jstephan@baylibre.com>
> > +  - Andy Hsieh <andy.hsieh@mediatek.com>
> > +
> > +description:
> > +  The CAMSV is a set of DMA engines connected to the SENINF CSI-2
> > +  receivers. The number of CAMSVs depend on the SoC model.
> 
> DMA should not go to media, but to dma

They're not generic DMA engines. The CAMSV is a video capture device
that includes a DMA engine, much like pretty much all the other video
capture devices.

> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8365-camsv
> > +
> > +  reg:
> > +    items:
> > +      - description: camsv base
> > +      - description: img0 base
> > +      - description: tg base
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: cam clock
> > +      - description: camtg clock
> > +      - description: camsv clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: cam
> > +      - const: camtg
> > +      - const: camsv
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for camsv0
> 
> This explains me nothing. What type of connection point? How does it fit
> the pipeline going to the display?

The description seems wrong, it should state

        description: Connection to the SENINF output

or something similar.

> It seems you represented DMA as some other device to make your drivers
> easier... That's not how it works.
> 
> > +
> > +    required:
> > +      - port@0
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - iommus
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> > +    #include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
> > +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        camsv1: camsv@15050000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

-- 
Regards,

Laurent Pinchart

