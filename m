Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC707E0334
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbjKCMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKCMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:53:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB7F83
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:53:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qytff-0007Wx-6h; Fri, 03 Nov 2023 13:53:07 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qytfe-006Jv8-9h; Fri, 03 Nov 2023 13:53:06 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qytfe-000CD8-6q; Fri, 03 Nov 2023 13:53:06 +0100
Date:   Fri, 3 Nov 2023 13:53:06 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: Add SKOV IMX8MP CPU revB
 board
Message-ID: <20231103125306.GB40819@pengutronix.de>
References: <20231103105305.2459143-1-o.rempel@pengutronix.de>
 <20231103105305.2459143-2-o.rempel@pengutronix.de>
 <1ee285d7-6bc9-43ad-9ec9-a8aaed4452b5@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ee285d7-6bc9-43ad-9ec9-a8aaed4452b5@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Nov 03, 2023 at 01:35:46PM +0100, Andrew Lunn wrote:
> > +			port@2 {
> > +				reg = <2>;
> > +				label = "cpu";
> > +				ethernet = <&eqos>;
> > +				/* 2ns rgmii-rxid is implemented on PCB.
> > +				 * Switch should add only rgmii-txid.
> > +				 */
> 
> Its unusual to actually see that. Its even more unusual its only one
> clock line. Can you actually see it on the PCB?

Yes. I even made a delay calculation by measuring this trace on PCB,
just to make sure I see it correctly.

> > +				phy-mode = "rgmii-txid";
> > +				tx-internal-delay-ps = <2000>;
> 
> Is this actually needed? rgmii-txid should add 2ns delay. Since this
> apparently works, i'm assuming setting tx-internal-delay-ps to 2ns
> does nothing, otherwise you would have a 4ns delay.

Without it the driver will complain:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/dsa/microchip/ksz_common.c?h=v6.6#n3496

but it works as expected.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
