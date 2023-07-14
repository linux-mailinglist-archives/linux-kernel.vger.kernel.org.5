Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808E753DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjGNOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:40:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4190199
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:40:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qKJxv-0006eR-RA; Fri, 14 Jul 2023 16:40:15 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qKJxv-0005ir-C7; Fri, 14 Jul 2023 16:40:15 +0200
Date:   Fri, 14 Jul 2023 16:40:15 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, marex@denx.de,
        frieder.schrempf@kontron.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add DEBIX SOM A and SOM A I/O
 Board support
Message-ID: <20230714144015.epiwqqjhw54wsjl6@pengutronix.de>
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <20230704184109.991104-3-m.felsch@pengutronix.de>
 <0a664d16-22e7-6061-db0e-9669ab40af73@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a664d16-22e7-6061-db0e-9669ab40af73@linaro.org>
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

On 23-07-05, Krzysztof Kozlowski wrote:
> On 04/07/2023 20:41, Marco Felsch wrote:
> > Add support for the Debix SOM A + SOM A I/O board. The commit enables
> > only the basic features like:
> >  - 2x UART
> >  - 2x Network
> >  - eMMC/µSD
> >  - CAN
> >  - QSPI
> 
> ...
> 
> > +&i2c1 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c1>;
> > +	status = "okay";
> > +
> > +	pmic@25 {
> > +		compatible = "nxp,pca9450c";
> > +		reg = <0x25>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_pmic>;
> > +
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <3 GPIO_ACTIVE_LOW>;
> 
> Wrong flag.

Sure, I will fix this. Thanks.

Regards,
  Marco
