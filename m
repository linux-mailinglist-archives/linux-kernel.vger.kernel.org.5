Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B112757EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjGROFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjGROEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:04:53 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400261FD3;
        Tue, 18 Jul 2023 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DjU8QbWwoYzSGBCbnklVIsE6FxMt00a2BFKbWomZUJc=; b=LnRMIpe7rVTL9UeO05+vSQqoSd
        K0jcAOh+HhQNmQ5+PyRUU76awBMAhKxcK6Lrk+mzJVOXaKGrGDKP6dWKTbnQ4EJFQCgh/2mpszRt1
        p9v9wBd4hq7IqnZjhPT2ym2L10N0kB+crm6AEYrpaG78+tumxZx6fSR1PUtdDGDjOC6Q=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53212 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qLlIm-0004C8-Rm; Tue, 18 Jul 2023 10:03:45 -0400
Date:   Tue, 18 Jul 2023 10:03:44 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230718100344.ebeae4ee79c299bcd6fee733@hugovil.com>
In-Reply-To: <20230718063715.GL9559@dragon>
References: <20230705174932.3652479-1-hugo@hugovil.com>
        <20230718063715.GL9559@dragon>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 14:37:15 +0800
Shawn Guo <shawnguo@kernel.org> wrote:

> On Wed, Jul 05, 2023 at 01:49:32PM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
> > nano SOM.
> > 
> > The PTN5150 circuitry on newer versions of the Symphony EVK board has
> > a non-standard configuration in which the PTN5150 IRQ pin is left
> > unconnected, and the PTN5150 ID pin is connected to GPIO1_IO11. This
> > requires changes to the ptn5150 driver to support this new mode.
> > Variscite have indicated their intention to submit those changes
> > upstream.
> > 
> > In the meantime, import device tree changes from linux-5.15 branch of
> > varigit repos to at least make the USB OTG port operate correctly in
> > host mode.
> > 
> > Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")
> 
> Has USB OTG been ever worked at all?  If the answer is no, it's not
> a fix but a new feature, and I would suggest you rework the patch
> subject and drop the Fixes tag.

Hi Shawn,
it never worked for me since commit 7358e05bddca, but it may have
something to do with the new hardware board version (>=1.4a) that I
have. It probably worked for older boards (< 1.4a) altough I cannot
confirm it without old hardware.

Let me know if you want me to remove the Fixes tag.

Hugo.


> 
> Shawn
> 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > Link: [v1] https://lkml.org/lkml/2023/7/4/702
> > 
> > Changes from v1:
> > - Add comments about PTN5150 IRQ/ID line connections
> > - Remove "typec1_con: connector" node
> > - Change IRQ type to IRQ_TYPE_EDGE_FALLING
> > 
> >  .../dts/freescale/imx8mn-var-som-symphony.dts | 32 +++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> > index 406a711486da..a7a57442cb81 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> > @@ -1,11 +1,14 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >  /*
> > + * Supports Symphony evaluation board versions >= 1.4a.
> > + *
> >   * Copyright 2019-2020 Variscite Ltd.
> >   * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> >   */
> >  
> >  /dts-v1/;
> >  
> > +#include <dt-bindings/usb/pd.h>
> >  #include "imx8mn-var-som.dtsi"
> >  
> >  / {
> > @@ -100,14 +103,26 @@ enet-sel-hog {
> >  		};
> >  	};
> >  
> > +	/*
> > +	 * For Symphony board version <= 1.4, the PTN5150 IRQ pin is connected
> > +	 * to GPIO1_IO11 on the SoM (R106 present, R132 absent). From Symphony
> > +	 * board version >= 1.4a, the PTN5150 ID pin is connected to GPIO1_IO11
> > +	 * on the SoM (R106 absent, R132 present).
> > +	 */
> >  	extcon_usbotg1: typec@3d {
> >  		compatible = "nxp,ptn5150";
> >  		reg = <0x3d>;
> >  		interrupt-parent = <&gpio1>;
> > -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pinctrl_ptn5150>;
> >  		status = "okay";
> > +
> > +		port {
> > +			typec1_dr_sw: endpoint {
> > +				remote-endpoint = <&usb1_drd_sw>;
> > +			};
> > +		};
> >  	};
> >  };
> >  
> > @@ -148,8 +163,21 @@ &uart3 {
> >  };
> >  
> >  &usbotg1 {
> > +	dr_mode = "otg";
> > +	hnp-disable;
> > +	srp-disable;
> > +	adp-disable;
> > +	usb-role-switch;
> >  	disable-over-current;
> > -	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
> > +	samsung,picophy-pre-emp-curr-control = <3>;
> > +	samsung,picophy-dc-vol-level-adjust = <7>;
> > +	status = "okay";
> > +
> > +	port {
> > +		usb1_drd_sw: endpoint {
> > +			remote-endpoint = <&typec1_dr_sw>;
> > +		};
> > +	};
> >  };
> >  
> >  &iomuxc {
> > 
> > base-commit: d528014517f2b0531862c02865b9d4c908019dc4
> > -- 
> > 2.30.2
> > 
> 
