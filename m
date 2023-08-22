Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50E7841D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjHVNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjHVNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:18:28 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC9318B;
        Tue, 22 Aug 2023 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2lIcLfTeAkulo3/H5kBv7hWxcKrJVGCdBc02mXquA0A=; b=fqEw+jcR2Ygggy1RqFXLbwlKD/
        XXH5/vdnzj/UBDV4hU4wVv//n5uVbEOoQRuY5bfjsEBJYLbVAhnNhngmIFVqkpUEwF05sdIlxm7P7
        xu2Cf1XXfyqqlhv9NIF9FKzKHf1ccf6IF8FEHFXk/wuXafk/0HC3ETExNi84rCFR7Q3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYRGl-004mQl-Ea; Tue, 22 Aug 2023 15:18:03 +0200
Date:   Tue, 22 Aug 2023 15:18:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: bcm2711: Describe Ethernet LEDs
Message-ID: <70dbbc50-0672-4e0a-9d3d-f04f6ca94edc@lunn.ch>
References: <20230821192714.3104006-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821192714.3104006-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:27:11PM -0700, Florian Fainelli wrote:
> Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
> as the Raspberry Pi 4 CM board.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 18 ++++++++++++++++++
>  .../arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> index d5f8823230db..41db78cb0836 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> @@ -5,6 +5,7 @@
>  #include "bcm283x-rpi-led-deprecated.dtsi"
>  #include "bcm283x-rpi-usb-peripheral.dtsi"
>  #include "bcm283x-rpi-wifi-bt.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
> @@ -197,6 +198,23 @@ &genet_mdio {
>  	phy1: ethernet-phy@1 {
>  		/* No PHY interrupt */
>  		reg = <0x1>;
> +
> +		leds {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			leds@0 {
> +				color = <LED_COLOR_ID_GREEN>;
> +				default-state = "keep";
> +				reg = <0>;
> +			};
> +
> +			leds@1 {
> +				color = <LED_COLOR_ID_AMBER>;
> +				default-state = "keep";
> +				reg = <1>;

Hi Florian

When we submitted leds in DT nodes as part of the merge, Rob wanted
the function property set. armada-370-rd.dts has:

function = LED_FUNCTION_WAN

because that port would typically be connected to your cable router
etc. But LED_FUNCTION_LAN also exists. This property can influence
naming so adding it later could be an ABI violation.

     Andrew
