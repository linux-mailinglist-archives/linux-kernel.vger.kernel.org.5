Return-Path: <linux-kernel+bounces-20648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8078282ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD4D1F25C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5535887;
	Tue,  9 Jan 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XS6t1Pvs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB673714C;
	Tue,  9 Jan 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94E51124F;
	Tue,  9 Jan 2024 10:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704791823;
	bh=EMEKdhlgpVaeI/UFFuuWKHAvayHYKBnc3hWBbb8Ogi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XS6t1PvsuiInuTInPlG4BRm3BSQIngB4LMiQB5n0mCKZ8zqzRbbLdT/FU/Orjwx1s
	 An6j1TLY6G+aBmUPjlf508ARJpep2IVa9HKIeSw4xKBEp2K1WvCROjs+y9K3ht+iK2
	 hKc1OA6igPfspTXmuxaNlCrvD0YImOdol77vGSWI=
Date: Tue, 9 Jan 2024 11:18:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc: "conor@kernel.org" <conor@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"10572168@qq.com" <10572168@qq.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
Message-ID: <20240109091816.GI20868@pendragon.ideasonboard.com>
References: <20231123115104.32094-1-zhi.mao@mediatek.com>
 <20231123115104.32094-2-zhi.mao@mediatek.com>
 <20231123-magical-rupture-83251807e995@spud>
 <20231207102505.GI29417@pendragon.ideasonboard.com>
 <96fee4c737300e6b834ae0761c161edb6bf48aec.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96fee4c737300e6b834ae0761c161edb6bf48aec.camel@mediatek.com>

Hi Zhi,

Your e-mail still came as HTML, with the same footer. Please fix this
first, I'm afraid we can't communicate properly on mailing lists
otherwise.

On Tue, Jan 09, 2024 at 09:11:32AM +0000, Zhi Mao (毛智) wrote:
> On Thu, 2023-12-07 at 12:25 +0200, Laurent Pinchart wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Nov 23, 2023 at 05:31:35PM +0000, Conor Dooley wrote:
> > > On Thu, Nov 23, 2023 at 07:51:03PM +0800, Zhi Mao wrote:
> > > > Add YAML device tree binding for GC08A3 CMOS image sensor,
> > > > and the relevant MAINTAINERS entries.
> > > >
> > > > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > >
> > > Please test your bindings.
> > >
> > > > ---
> > > >  .../bindings/media/i2c/galaxycore,gc08a3.yaml | 128
> > ++++++++++++++++++
> > > >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> > > >  2 files changed, 130 insertions(+)
> > > >  create mode 100644
> > Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > > >
> > > > diff --git
> > a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > > > new file mode 100644
> > > > index 000000000000..089ea321da91
> > > > --- /dev/null
> > > > +++
> > b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > > > @@ -0,0 +1,128 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > http://devicetree.org/schemas/media/i2c/galaxycore,gc08a3.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: GalaxyCore gc08a3 1/4" 8M Pixel MIPI CSI-2 sensor
> > > > +
> > > > +maintainers:
> > > > +  - Zhi Mao <zhi.mao@mediatek.com>
> > > > +
> > > > +description: |-
> > >
> > > The |- is not needed, you have no formatting to preserve.
> > >
> > > > +  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
> > > > +  interface and CCI (I2C compatible) control bus. The output
> > format
> > > > +  is raw Bayer.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: GalaxyCore,gc08a3
> > >
> > > Please remove the capitals.
> > >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Reference to the mclk clock.
> > >
> > > Pointless, just use maxItems: 1.
> > >
> > > > +
> > > > +  assigned-clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  assigned-clock-rates:
> > > > +    maxItems: 1
> > > > +
> > > > +  enable-gpios:
> > > > +    description: Reference to the GPIO connected to the RESETB
> > pin. Active low.
> > > > +    maxItems: 1
> > > > +
> >
> > If that's the RESETB pin, it should be reset-gpios.
> [mtk]: yes, it's reset-pin, fixed in patch:v3.
> and some other comments also fixed, please review patch:v3.
> 
> https://lore.kernel.org/linux-media/20240109022715.30278-1-zhi.mao@mediatek.com/
> >
> > > > +  vddio-supply:
> > > > +    description: Definition of the regulator used for the VDDIO
> > power supply.
> > > > +
> > > > +  vdda-supply:
> > > > +    description: Definition of the regulator used for the VDDA
> > power supply.
> > > > +
> > > > +  vddd-supply:
> > > > +    description: Definition of the regulator used for the VDDD
> > power supply.
> > >
> > > These descriptions can all be replaced with "foo-supply: true" IMO.
> > >
> > > > +  port:
> > > > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +    properties:
> > > > +      endpoint:
> > > > +        $ref: /schemas/media/video-interfaces.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          data-lanes:
> > > > +            oneOf:
> > > > +              - items:
> > > > +                  - const: 1
> > > > +                  - const: 2
> > > > +                  - const: 3
> > > > +                  - const: 4
> > > > +              - items:
> > > > +                  - const: 1
> > > > +                  - const: 2
> > > > +
> > > > +          link-frequencies: true
> > > > +
> > > > +        required:
> > > > +          - data-lanes
> > > > +          - link-frequencies
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - clocks
> > >
> > > > +  - assigned-clocks
> > > > +  - assigned-clock-rates
> > >
> > > Why are these required?
> > >
> > > > +  - vddio-supply
> > > > +  - vdda-supply
> > > > +  - vddd-supply
> > > > +  - port
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > +
> > > > +    i2c {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        sensor0@2 {
> > > > +            status = "okay";
> > > > +            compatible = "GalaxyCore,gc08a3";
> > > > +            reg = <0x31>;
> > > > +
> > > > +            clocks = <&topckgen CLK_TOP_CAMTG>,
> > > > +                <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
> > > > +            clock-names = "xvclk", "freq_mux";
> > > > +            clock-frequency = <24000000>;
> > > > +
> > > > +            assigned-clocks = <&topckgen CLK_TOP_CAMTG>,
> > > > +                    <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
> > > > +            assigned-clock-parents = <&topckgen
> > CLK_TOP_UNIVPLL_192M_D8>;
> > > > +            assigned-clock-rates = <0>, <24000000>;
> > > > +
> > > > +            enable-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
> > > > +
> > > > +            pinctrl-names = "default";
> > > > +            pinctrl-0 = <&camera_pins_cam0>;
> > > > +
> > > > +            avdd-supply = <&mt6359_vfe28_ldo_reg>;
> > > > +
> > > > +            port {
> > > > +                sensor0_out_2: endpoint {
> > > > +                    data-lanes = <1 2 3 4>;
> > > > +                    link-frequencies = /bits/ 64 <336000000
> > 207000000>;
> > > > +                    remote-endpoint = <&seninf_csi_port_0_in_2>;
> > > > +                };
> > > > +            };
> > > > +        };
> > > > +
> > > > +    };
> > > > +
> > > > +...
> > > > diff --git a/Documentation/devicetree/bindings/vendor-
> > prefixes.yaml b/Documentation/devicetree/bindings/vendor-
> > prefixes.yaml
> > > > index 309b94c328c8..a0bbec0bfee2 100644
> > > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > > @@ -502,6 +502,8 @@ patternProperties:
> > > >      description: Fujitsu Ltd.
> > > >    "^fxtec,.*":
> > > >      description: FX Technology Ltd.
> > > > +  "^GalaxyCore,.*":
> > > > +    description: GalaxyCore Inc.
> > > >    "^gardena,.*":
> > > >      description: GARDENA GmbH
> > > >    "^gateway,.*":
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> 
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 

-- 
Regards,

Laurent Pinchart

