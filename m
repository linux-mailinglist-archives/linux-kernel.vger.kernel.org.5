Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69B79372F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjIFIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjIFIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:32:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB3CF0;
        Wed,  6 Sep 2023 01:32:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD1124D;
        Wed,  6 Sep 2023 10:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693989057;
        bh=8PS+3+ct+TlytlOBH+xgkomraO+qI22hRRiHVvboPPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfFeb/q5mcrQO1LHWJqr90i6oINRUFf8/MEyZvTeo62sf5JmvT7dwuKUuvKAD7pGm
         P6gJPh0tMd3Nm0ErxDc4hqNmgWH2RpZl0x4IO/DQ+7PsQZHxJE5yD/imZAObI3MJG5
         87fW4VV9fs7nJuP8Vwo2l8/zONXEBPyP7sz7PhnM=
Date:   Wed, 6 Sep 2023 11:32:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Message-ID: <20230906083237.GL7971@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Sep 06, 2023 at 09:27:07AM +0200, Krzysztof Kozlowski wrote:
> On 06/09/2023 01:31, Paul Elder wrote:
> > Add overlays for the Pumpkin i350 to support THP7312 cameras.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile         |  4 +
> >  .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
> >  .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
> >  .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
> >  4 files changed, 173 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index 20570bc40de8..ceaf24105001 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> >  
> > +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
> > +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
> >  mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
> > +
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> > new file mode 100644
> > index 000000000000..478697552617
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Ideas on Board
> > + * Author: Paul Elder <paul.elder@ideasonboard.com>
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&{/} {
> > +	vsys_v4p2: regulator@0 {
> 
> Hm? Is this a bus?

There are multiple instances of "numbered" regulators in upstream DT
files, for instance arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
has a regulator@0. There are similar instances for clocks.

I understand why it may not be a good idea, and how the root node is
indeed not a bus. In some cases, those regulators and clocks are grouped
in a regulators or clocks node that has a "simple-bus" compatible. I'm
not sure if that's a good idea, but at least it should validate.

What's the best practice for discrete board-level clocks and regulators
in overlays ? How do we ensure that their node name will not conflict
with the board to which the overlay is attached ?

> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vsys-v4p2";
> > +		regulator-min-microvolt = <4200000>;
> > +		regulator-max-microvolt = <4200000>;
> > +	};
> > +
> > +	camera61_clk: cam_clk24m {
> 
> And this is not on a bus? It's the same / node!
> 
> Please work on mainline, which means take mainline code and change it to
> your needs. Do not take downstream poor code and change it...
> 
> No underscores in node names. Also generic node names, so at least with
> generic prefix or suffix.
> 
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <24000000>;
> > +		#clock-cells = <0>;
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> > new file mode 100644
> > index 000000000000..740d14a19d75
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Ideas on Board
> > + * Author: Paul Elder <paul.elder@ideasonboard.com>
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
> > +#include "mt8365-pumpkin-common-thp7312.dtsi"
> > +
> > +&i2c3 {
> > +	camera@61 {
> > +		compatible = "thine,thp7312";
> > +		reg = <0x61>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&cam0_pins_default>;
> > +		reset-gpios = <&pio 118 GPIO_ACTIVE_LOW>;
> > +		clocks = <&camera61_clk>;
> > +
> > +		vddcore-supply = <&vsys_v4p2>;
> > +		vhtermrx-supply = <&vsys_v4p2>;
> > +		vddtx-supply = <&vsys_v4p2>;
> > +		vddhost-supply = <&vsys_v4p2>;
> > +		vddcmos-supply = <&vsys_v4p2>;
> > +		vddgpio_0-supply = <&vsys_v4p2>;
> > +		vddgpio_1-supply = <&vsys_v4p2>;
> > +		DOVDD-supply = <&vsys_v4p2>;
> > +		AVDD-supply = <&vsys_v4p2>;
> > +		DVDD-supply = <&vsys_v4p2>;
> > +
> > +		orientation = <0>;
> > +		rotation = <0>;
> > +
> > +		thine,rx,data-lanes = <4 1 3 2>;
> 
> NAK for this property.

Please explain why. You commented very briefly in the bindings review,
and it wasn't clear to me if you were happy or not with the property,
and if not, why.

> > +
> > +		port {
> > +			isp1_out: endpoint {
> > +				remote-endpoint = <&seninf_in1>;
> > +				data-lanes = <4 2 1 3>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&pio {
> > +	cam0_pins_default: cam0_pins_default {
> 
> No underscores in node names.
> 
> > +		pins_rst {
> 
> Ditto

-- 
Regards,

Laurent Pinchart
