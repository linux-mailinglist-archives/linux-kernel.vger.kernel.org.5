Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996577C1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjHNUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjHNUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:40:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C88AE5E;
        Mon, 14 Aug 2023 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BlrSDh1oWixOHfKJbeuFZ7Gd0lCm0lENmSCCvEiVQRE=; b=zsOhdtaaUYZZaAbTkpIlzs/sac
        FkqYwD5s050zfzBo0NlJRgOLLpLFVCYsfgaVFiZV/4gG0IZvDEpD5oKs99JatBlyLW4woGB3XF+ra
        XVGlyPb87AXjDxPe+mU0A5KCO+WBiBvG9EDTaMORU4rPhoGjP36ed6DMRrzC3Q5YOIIk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVeLz-0045X0-Ny; Mon, 14 Aug 2023 22:39:55 +0200
Date:   Mon, 14 Aug 2023 22:39:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        richardcochran@gmail.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        alim.akhtar@samsung.com, linux-fsd@tesla.com,
        pankaj.dubey@samsung.com, swathi.ks@samsung.com,
        ravi.patel@samsung.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <4e745c2a-57bd-45da-8bd2-ee1cb2bab84f@lunn.ch>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
 <20230814112539.70453-2-sriranjani.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814112539.70453-2-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  fsd-rx-clock-skew:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the syscon node
> +          - description: offset of the control register
> +    description:
> +      Should be phandle/offset pair. The phandle to the syscon node.

What clock are you skew-ing here? And why?

> +    ethernet_1: ethernet@14300000 {
> +              compatible = "tesla,dwc-qos-ethernet-4.21";
> +              reg = <0x0 0x14300000 0x0 0x10000>;
> +              interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +              clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
> +                       <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
> +                       <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
> +                       <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
> +                       <&clock_peric PERIC_EQOS_PHYRXCLK>,
> +                       <&clock_peric PERIC_DOUT_RGMII_CLK>;
> +              clock-names = "ptp_ref",
> +                            "master_bus",
> +                            "slave_bus",
> +                            "tx",
> +                            "rx",
> +                            "master2_bus",
> +                            "slave2_bus",
> +                            "eqos_rxclk_mux",
> +                            "eqos_phyrxclk",
> +                            "dout_peric_rgmii_clk";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
> +                          <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
> +                          <&eth1_rx_ctrl>, <&eth1_mdio>;
> +              fsd-rx-clock-skew = <&sysreg_peric 0x10>;
> +              iommus = <&smmu_peric 0x0 0x1>;
> +              phy-mode = "rgmii";

I know it is just an example, but "rgmii" is generally
wrong. "rgmii-id" is generally what you need. And when i do see
"rgmii", it starts ringing alarm bells for me, it could mean your
RGMII delays are being handled wrongly.

       Andrew
