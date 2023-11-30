Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10E7FF402
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbjK3PyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbjK3PyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:54:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0B10D0;
        Thu, 30 Nov 2023 07:54:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEE1489D;
        Thu, 30 Nov 2023 16:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701359612;
        bh=NmKT9aIjebdgY3EDWpUbTKENWW9j1zh38cDwsp1VpD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/UyJrHB4E1mb96H7irt2Npff6AWHPyufrZKb5RonThvFux1ZsDx8xyKrD0yIlNMx
         W1lI6k6tVz4DTmM5eEtKPc9Onwv0vXrkv68G5ksgvhdYaLT0UPeY3DEwyioIaZhruI
         ohVq+v0Izp+JSozv9TlACD8MfUrbeZPVXhVOLheo=
Date:   Thu, 30 Nov 2023 17:54:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Elder <paul.elder@ideasonboard.com>,
        kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Add overlays for ISP instances
Message-ID: <20231130155414.GT8402@pendragon.ideasonboard.com>
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <5734628.DvuYhMxLoT@steina-w>
 <20231130142048.GR8402@pendragon.ideasonboard.com>
 <1874751.tdWV9SEqCh@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1874751.tdWV9SEqCh@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:34:11PM +0100, Alexander Stein wrote:
> Am Donnerstag, 30. November 2023, 15:20:48 CET schrieb Laurent Pinchart:
> > On Thu, Nov 30, 2023 at 10:51:22AM +0100, Alexander Stein wrote:
> > > Am Mittwoch, 29. November 2023, 16:16:37 CET schrieb Laurent Pinchart:
> > > > On Wed, Nov 29, 2023 at 11:20:07AM +0100, Alexander Stein wrote:
> > > > > Am Mittwoch, 29. November 2023, 10:31:13 CET schrieb Paul Elder:
> > > > > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > 
> > > > > > Add two overlay to enable each ISP instance. The ISP is wired
> > > > > > directly
> > > > > > to the CSIS for now, bypassing the ISI completely.
> > > > > 
> > > > > I'm not sure if this is worth adding in a separate overlay.
> > > > 
> > > > The trouble is that, at this point, selection between the ISP and the
> > > > ISI can only be performed through DT :-S That's why this is implemented
> > > > as an overlay.
> > > 
> > > I feel a better place would be the overlay which actually adds the sensor.
> > > This knows best whether ISI or ISP should be used.
> > 
> > Any sensor could be used with either the ISI or the ISP, so I don't
> > think the camera module overlay would be the best place for this. Unless
> > you want to duplicate all camera module overlays, with an ISI version
> > and an ISP version :-)
> 
> True, that's a really good argument for having these small overlays.
> But how to deal with dtc warnings?
> > imx8mp-isp1.dtbo: Warning (graph_port): /fragment@2: graph port node name 
> should be 'port'
> > imx8mp-isp1.dtso:34.17-36.3: Warning (graph_endpoint): /fragment@2/
> __overlay__: graph endpoint node name should be 'endpoint'
> > imx8mp-isp1.dtso:34.17-36.3: Warning (graph_endpoint): /fragment@2/
> __overlay__: graph connection to node '/fragment@1/__overlay__/ports/port@1/
> endpoint' is not bidirectional

See below :-)

> But for the small overlay itself:
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> > > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > > > ---
> > > > > > 
> > > > > >  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> > > > > >  .../arm64/boot/dts/freescale/imx8mp-isp1.dtso | 36 +++++++++++++++++++
> > > > > >  .../arm64/boot/dts/freescale/imx8mp-isp2.dtso | 36 +++++++++++++++++++
> > > > > >  3 files changed, 74 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > > > b/arch/arm64/boot/dts/freescale/Makefile index
> > > > > > 300049037eb0..f97dfac11189
> > > > > > 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > > > @@ -113,6 +113,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
> > > > > > 
> > > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> > > > > > 
> > > > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mp-isp1.dtbo
> > > > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mp-isp2.dtbo

Overlays need to be validated in the context of a base DT on which they
apply. For instance, in the same Makefile, we have

--------
dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx.dtb
...
imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33-dtbs += imx8mm-tqma8mqml-mba8mx.dtb imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtbo
dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtb
--------

imx8mm-tqma8mqml-mba8mx.dts is the base board DT, and
imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtso the overlay. As far as I
understand, when compiling dtbs, the build system will compile
imx8mm-tqma8mqml-mba8mx.dtb and
imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33-dtb. To create the latter, it
will compile imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtbo and apply it
to imx8mm-tqma8mqml-mba8mx.dtb. Then, it will validate the DTBs
specified as part of dtb-$(CONFIG_ARCH_MXC), which are
imx8mm-tqma8mqml-mba8mx.dtb standlone, and through
imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33-dtbs
imx8mm-tqma8mqml-mba8mx.dtb with the overlay applied.

TL;DR: a v2 of this patch should fix the Makefile, and be compile-tested
with make dtbs.

Rob, Conor or Krzysztof can correct me if I'm wrong.

> > > > > > 
> > > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso new file mode
> > > > > > 100644
> > > > > > index 000000000000..cf394ed224ab
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > > > @@ -0,0 +1,36 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Copyright 2022 Ideas on Board Oy
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +/plugin/;
> > > > > > +
> > > > > > +#include <dt-bindings/media/video-interfaces.h>
> > > > > > +
> > > > > > +&isi_0 {
> > > > > > +	status = "disabled";
> > > > > 
> > > > > ISI is disabled by default. What is your intention here?
> > > > 
> > > > It could be enabled by an overlay for a camera module. Ideally we want
> > > > to be able to enable both the ISI and ISP at runtime, but that's not
> > > > possible yet and will require a very large amount of work.
> > > 
> > > Again IMHO this is part of sensor setup, in a very specific overlay. To
> > > put it into different words: I barely see the gain of this small overlay.
> > > 
> > > Runtime switching would require a combined media controller including both
> > > ISI and ISP, no?
> > 
> > Correct, that's the hard part.
> > 
> > > > > > +
> > > > > > +	ports {
> > > > > > +		port@0 {
> > > > > > +			/delete-node/ endpoint;
> > > > > 
> > > > > This doesn't work in overlays. See [1]. Otherwise the OF graph
> > > > > connections
> > > > > look fine to me. I'm using the same in my local overlay.
> > > > 
> > > > Interesting, I wasn't aware of that. Maybe we should fix it :-)
> > > > 
> > > > > [1] https://lore.kernel.org/all/CAMuHMdWu4KZbBkvEofUV2wuA1g2S=XHHM3RUN1cNrcZBkhsPZA@mail.gmail.com/
> > > > > 
> > > > > > +		};
> > > > > > +	};
> > > > > > +};
> > > > > > +
> > > > > > +&isp_0 {
> > > > > > +	status = "okay";
> > > > > > +
> > > > > > +	ports {
> > > > > > +		port@1 {
> > > > > > +			isp0_in: endpoint {
> > > > > > +				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
> > > > > > +				remote-endpoint = <&mipi_csi_0_out>;
> > > > > > +			};
> > > > > > +		};
> > > > > > +	};
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi_0_out {
> > > > > > +	remote-endpoint = <&isp0_in>;
> > > > > > +};
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso new file mode
> > > > > > 100644
> > > > > > index 000000000000..14e2e7b2617f
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > > > @@ -0,0 +1,36 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Copyright 2022 Ideas on Board Oy
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +/plugin/;
> > > > > > +
> > > > > > +#include <dt-bindings/media/video-interfaces.h>
> > > > > > +
> > > > > > +&isi_0 {
> > > > > > +	status = "disabled";
> > > > > > +
> > > > > > +	ports {
> > > > > > +		port@1 {
> > > > > > +			/delete-node/ endpoint;
> > > > > > +		};
> > > > > > +	};
> > > > > > +};
> > > > > > +
> > > > > > +&isp_1 {
> > > > > > +	status = "okay";
> > > > > > +
> > > > > > +	ports {
> > > > > > +		port@1 {
> > > > > > +			isp1_in: endpoint {
> > > > > > +				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
> > > > > > +				remote-endpoint = <&mipi_csi_1_out>;
> > > > > > +			};
> > > > > > +		};
> > > > > > +	};
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi_1_out {
> > > > > > +	remote-endpoint = <&isp1_in>;
> > > > > > +};

-- 
Regards,

Laurent Pinchart
