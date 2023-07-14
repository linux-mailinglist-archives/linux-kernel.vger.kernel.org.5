Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA01753DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjGNOis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjGNOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:38:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B434C1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:38:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qKJwC-0006LT-5p; Fri, 14 Jul 2023 16:38:28 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qKJwA-0005b8-QV; Fri, 14 Jul 2023 16:38:26 +0200
Date:   Fri, 14 Jul 2023 16:38:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add DEBIX SOM A and SOM A I/O
 Board support
Message-ID: <20230714143826.p3blstr5dpsgr46j@pengutronix.de>
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <20230704184109.991104-3-m.felsch@pengutronix.de>
 <CAOMZO5C21f9+ByLVHMaK9wHcCSF3R9W1c1ZCfirx7TuX=786Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C21f9+ByLVHMaK9wHcCSF3R9W1c1ZCfirx7TuX=786Rw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 23-07-04, Fabio Estevam wrote:
> Hi Marco,
> 
> On Tue, Jul 4, 2023 at 3:41 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > +&fec {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_fec>;
> > +       phy-mode = "rgmii-id";
> > +       phy-handle = <&ethphy1>;
> > +       fsl,magic-packet;
> > +       phy-reset-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> > +       phy-reset-duration = <10>;
> > +       phy-reset-post-delay = <150>;
> 
> These properties are deprecated. Please move them under the mdio node.

right

> > +               /*
> > +                * Since USB1 is binded to peripheral mode we need to ensure
> 
> s/binded/bound

sure

> > +/* µSD Card */
> > +&usdhc2 {
> > +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 = <&pinctrl_usdhc2>;
> > +       pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> > +       pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> > +       vmmc-supply = <&reg_usdhc2_vmmc>;
> > +       bus-width = <4>;
> > +       disable-wp;
> > +       no-sdio;
> > +       no-mmc;
> > +
> 
> No need for this blank line.

I added the blank lines for a better separation, but I can drop these.

> > +       assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
> > +       assigned-clock-rates = <400000000>;
> > +
> 
> Ditto.
> 
> > +
> > +       pmic@25 {
> > +               compatible = "nxp,pca9450c";
> > +               reg = <0x25>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_pmic>;
> > +
> > +               interrupt-parent = <&gpio1>;
> > +               interrupts = <3 GPIO_ACTIVE_LOW>;
> > +
> > +               regulators {
> > +                       buck1: BUCK1 {
> > +                               regulator-name = "BUCK1";
> > +                               regulator-min-microvolt = <600000>;
> > +                               regulator-max-microvolt = <2187500>;
> > +                               regulator-boot-on;
> > +                               regulator-always-on;
> > +                               regulator-ramp-delay = <3125>;
> > +                       };
> > +
> > +                       buck2: BUCK2 {
> > +                               regulator-name = "BUCK2";
> > +                               regulator-min-microvolt = <600000>;
> > +                               regulator-max-microvolt = <2187500>;
> > +                               regulator-boot-on;
> > +                               regulator-always-on;
> > +                               regulator-ramp-delay = <3125>;
> > +                               nxp,dvs-run-voltage = <950000>;
> > +                               nxp,dvs-standby-voltage = <850000>;
> > +                       };
> > +
> > +                       buck4: BUCK4{
> 
> Missing space after BUCK4.

yes.

> > +                               regulator-name = "BUCK4";
> > +                               regulator-min-microvolt = <600000>;
> > +                               regulator-max-microvolt = <3400000>;
> > +                               regulator-boot-on;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       buck5: BUCK5{
> 
> Ditto.

yes.

> > +&usdhc3 {
> > +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 = <&pinctrl_usdhc3>;
> > +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> > +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> > +       bus-width = <8>;
> > +       non-removable;
> > +
> 
> No need for this blank line.
> 
> 
> > +       assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
> > +       assigned-clock-rates = <400000000>;
> > +
> 
> Ditto.

Removed these as well. Thanks for your review :)

Regards,
  Marco
