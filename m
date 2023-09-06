Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712079379B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjIFJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjIFJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:00:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19824E50;
        Wed,  6 Sep 2023 02:00:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2EE1AAF2;
        Wed,  6 Sep 2023 10:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693990758;
        bh=4wPXFKoJ8tbHdlnTo39VoR7+ojgp/oBrZhSOyNoere8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+xaMIK2jsOnY15WbPObM6RNDALiX6P7Dl+xwCCN0E4XdBsbgbrLzL2bAekobM1Zs
         dWCuoJ7QA66cUgSEzTSacvfAq7+hl2oDEXJ4Cieill4SSJh1QU5/MvTlxoXbxUoYCb
         fJpAdVOLYM1NshP9Rx+CGeiicIlPlIqwEFVcxKJs=
Date:   Wed, 6 Sep 2023 12:00:58 +0300
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
Message-ID: <20230906090058.GB17308@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
 <20230906083237.GL7971@pendragon.ideasonboard.com>
 <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:48:23AM +0200, Krzysztof Kozlowski wrote:
> On 06/09/2023 10:32, Laurent Pinchart wrote:
> > On Wed, Sep 06, 2023 at 09:27:07AM +0200, Krzysztof Kozlowski wrote:
> >> On 06/09/2023 01:31, Paul Elder wrote:
> >>> Add overlays for the Pumpkin i350 to support THP7312 cameras.
> >>>
> >>> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/Makefile         |  4 +
> >>>  .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
> >>>  .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
> >>>  .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
> >>>  4 files changed, 173 insertions(+)
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> >>> index 20570bc40de8..ceaf24105001 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >>> @@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> >>>  
> >>> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
> >>> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
> >>>  mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
> >>> +
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> >>> new file mode 100644
> >>> index 000000000000..478697552617
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> >>> @@ -0,0 +1,23 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (c) 2023 Ideas on Board
> >>> + * Author: Paul Elder <paul.elder@ideasonboard.com>
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +/plugin/;
> >>> +
> >>> +&{/} {
> >>> +	vsys_v4p2: regulator@0 {
> >>
> >> Hm? Is this a bus?
> > 
> > There are multiple instances of "numbered" regulators in upstream DT
> > files, for instance arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
> 
> That's the only example I saw... I fixed it now.
> 
> > has a regulator@0. There are similar instances for clocks.
> > 
> > I understand why it may not be a good idea, and how the root node is
> > indeed not a bus. In some cases, those regulators and clocks are grouped
> > in a regulators or clocks node that has a "simple-bus" compatible. I'm
> > not sure if that's a good idea, but at least it should validate.
> > 
> > What's the best practice for discrete board-level clocks and regulators
> > in overlays ? How do we ensure that their node name will not conflict
> > with the board to which the overlay is attached ?
> 
> Top-level nodes (so under /) do not have unit addresses. If they have -
> it's an error, because it is not a bus. Also, unit address requires reg.
> No reg? No unit address. DTC reports this as warnings as well.

I agree with all that, but what's the recommended practice to add
top-level clocks and regulators in overlays, in a way that avoids
namespace clashes with the base board ?

> >>> +		orientation = <0>;
> >>> +		rotation = <0>;
> >>> +
> >>> +		thine,rx,data-lanes = <4 1 3 2>;
> >>
> >> NAK for this property.
> > 
> > Please explain why. You commented very briefly in the bindings review,
> > and it wasn't clear to me if you were happy or not with the property,
> > and if not, why.
> 
> Because it is duplicating endpoint. At least from the description.

The THP7312 is an external ISP. At the hardware level, it has an input
side, with a CSI-2 receiver and an I2C master controller, and an output
side, with a CSI-2 transmitter and an I2C slave controller. A raw camera
sensor is connected on the input side, transmitting image data to the
THP7312, and being controlled over I2C by the firmware running on the
THP7312. From a Linux point of view, only the output side of the THP7312
is visible, and the combination of the raw camera sensor and the THP7312
acts as a smart camera sensor, producing YUV images.

As there are two CSI-2 buses, the data lanes configuration needs to be
specified for both sides. On the output side, connected to the SoC and
visible to Linux, the bindings use a port node with an endpoint and the
standard data-lanes property. On the input side, which is invisible to
Linux, the bindings use the vendor-specific thine,rx,data-lanes
property. Its semantics is identical to the standard data-lanes
property, but it's not located in an endpoint as there's no port for the
input side.

-- 
Regards,

Laurent Pinchart
