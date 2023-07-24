Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7CF75EAA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGXEuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXEui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:50:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E477B1B6;
        Sun, 23 Jul 2023 21:50:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B5F5C809F;
        Mon, 24 Jul 2023 04:50:33 +0000 (UTC)
Date:   Mon, 24 Jul 2023 07:50:32 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, afd@ti.com,
        krzysztof.kozlowski+dt@linaro.org, kristo@kernel.org,
        robh+dt@kernel.org, conor+dt@kernel.org, rogerq@kernel.org,
        s-vadapalli@ti.com, a-bhatia1@ti.com, r-ravikumar@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Message-ID: <20230724045032.GU5194@atomide.com>
References: <20230721132029.123881-1-j-choudhary@ti.com>
 <20230721132029.123881-3-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721132029.123881-3-j-choudhary@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Jayesh Choudhary <j-choudhary@ti.com> [230721 13:21]:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 7ad152a1b90f..1e2a26ac9c65 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -252,6 +252,30 @@ vdd_sd_dv: regulator-TLV71033 {
>  };
>  
>  &main_pmx0 {
> +	main_cpsw2g_pins_default: main-cpsw2g-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
> +			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
> +			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
> +			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
> +			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
> +			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
> +			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
> +			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
> +			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
> +			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
> +			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
> +			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
> +		>;
> +	};

We are standardizing pinctrl-single to use pin group node naming with -pins
suffix, so in this case main-cpsw2g-default-pins. The same applies for all
pin group node names. And please use -pins also for a single pin groups as
new pins may need to be added later on in some cases.

These changes are to make dtbs checks work for pinctrl-single yaml binding
as we mostly use a generic compatible and don't want to add all kind of
custom node name matches.

Regards,

Tony
