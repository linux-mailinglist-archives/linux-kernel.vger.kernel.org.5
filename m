Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74D759B59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGSQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGSQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:48:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B21BF2;
        Wed, 19 Jul 2023 09:48:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63728FF802;
        Wed, 19 Jul 2023 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689785317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKDmPUsTotuvgM8MSiKrmp7WDzMVYFV4Cjd7anLXrXo=;
        b=Ik2teUmfo0wnP/ByQx4yLDuXDr9fSqxD0pDRf5TZXTjBH6M/k8OCT6oMi30+bfGiw0ALkP
        t0abRvexgfIdDy5GvQMBQ1cg92YaF+MyvZZCHxtKJ0qQPphxGn8uBpWUYDutRKL7U6btFW
        CY3ovATDDERETU8GW1kB5p8XdUVkjUPtjHBVuCYp9LJg/+EF2NDX7FMfn6IVQYFoFlXDNs
        cvSC8LKXUaV4Zg4tdGmNEByU68+XO59W8+exdE0NTOTvm1mI/dCs0I18xrHk26v3A5l2LX
        UrucgJTXqVZabnVYEqrhamESPEUGJXjzlgTKPeHFH3cee3MxE4i5tmJLcV/p9g==
Date:   Wed, 19 Jul 2023 18:48:31 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Xu Yang <xu.yang_2@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling
 runtime-pm
Message-ID: <20230719184831.75ae8658@booty>
In-Reply-To: <DB7PR04MB4505560E7DCBC2523FD7A0FE8C39A@DB7PR04MB4505.eurprd04.prod.outlook.com>
References: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
        <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <20230505120618.2f4cf22c@booty>
        <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
        <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
        <20230508151756.785ec07e@booty>
        <20230529121825.71e9b6d6@booty>
        <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZKaWL3+ClI7iNr/4@francesco-nb.int.toradex.com>
        <20230717184537.6d6ed607@booty>
        <DB7PR04MB450573F8EA936E049F053A258C38A@DB7PR04MB4505.eurprd04.prod.outlook.com>
        <20230718142504.075d0186@booty>
        <DB7PR04MB4505560E7DCBC2523FD7A0FE8C39A@DB7PR04MB4505.eurprd04.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xu,

thanks for the follow up.

On Wed, 19 Jul 2023 11:23:26 +0000
Xu Yang <xu.yang_2@nxp.com> wrote:

> Hi Luca,
> 
> > -----Original Message-----
> > 
> > Hello Xu,
> > 
> > On Tue, 18 Jul 2023 08:31:48 +0000
> > Xu Yang <xu.yang_2@nxp.com> wrote:
> >   
> > > > -----Original Message-----
> > > >
> > > > Ciao Francesco,
> > > >
> > > > On Thu, 6 Jul 2023 12:23:43 +0200
> > > > Francesco Dolcini <francesco@dolcini.it> wrote:
> > > >  
> > > > > Hello Luca,
> > > > >
> > > > > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:  
> > > > > > Yes, your understanding is correct, talked with Xu(in CC), he will take this
> > > > > > soon.  
> > > > >
> > > > > A series was posted
> > > > >
> > > > > I had no time to try or look at it yet.  
> > > >
> > > > Thanks for keeping me up to date on this topic, which is still totally
> > > > relevant to me.
> > > >
> > > > I looked at the series, but it does not seem to be addressing the
> > > > problem with USB host not detecting new devices when VBUS is not
> > > > directly connected, e.g. in the Colibri imx6ull SoM.
> > > >
> > > > Xu, do you confirm the series at the link is _not_ solving the problem
> > > > being discussed here?  
> > >
> > > Have you tried this patchset? The upstream driver couldn't get correct
> > > USB role from HW_USBPHY_CTRL register when the ID pin is float. This is
> > > what this patchset is trying to fix. With this patch, condition
> > > "(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be false when
> > > controller acts as host role, then __mxs_phy_disconnect_line(phy, true)
> > > will never be called. So I think it doesn't matter whether VBUS is connected
> > > or not when act as host mode. If you still have issue after apply this patchset,
> > > please let me know.  
> > 
> > I tested this patchset on top of v6.5-rc2 and I confirm USB detection
> > is still broken on the Colibri iMX6ULL. With or without the patches
> > the behavior is the same: USB devices are detected only during boot,
> > and anything connected after boot are never detected.  
> 
> Thanks for your feedback. As you said this issue will disappear with below change, right?
> 
> 	diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> 	index e1a2b2ea098b..ec5ee790455e 100644
> 	--- a/drivers/usb/phy/phy-mxs-usb.c
> 	+++ b/drivers/usb/phy/phy-mxs-usb.c
> 	@@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_phy_data = {
> 	 };
> 
> 	 static const struct mxs_phy_data imx6ul_phy_data = {
> 	-       .flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> 	 };
> 
> 	 static const struct mxs_phy_data imx7ulp_phy_data = {

Exactly.

> So I guess something in __mxs_phy_disconnect_line(mxs_phy, true) is causing this behavior.
> Could you please help to find which line to comment to make this issue disappear?

I did some tests and detection works by doing _any_ of the following
two changes (or both of them).

Change 1:

--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -359,10 +359,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
        void __iomem *base = mxs_phy->phy.io_priv;
        u32 reg;
 
-       if (disconnect)
-               writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
-                       base + HW_USBPHY_DEBUG_CLR);
-
        if (mxs_phy->port_id == 0) {
                reg = disconnect ? ANADIG_USB1_LOOPBACK_SET
                        : ANADIG_USB1_LOOPBACK_CLR;

Change 2:

--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -372,9 +372,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
        } else if (mxs_phy->port_id == 1) {
                reg = disconnect ? ANADIG_USB2_LOOPBACK_SET
                        : ANADIG_USB2_LOOPBACK_CLR;
-               regmap_write(mxs_phy->regmap_anatop, reg,
-                       BM_ANADIG_USB2_LOOPBACK_UTMI_DIG_TST1 |
-                       BM_ANADIG_USB2_LOOPBACK_TSTI_TX_EN);
        }
 
        if (!disconnect)

I hope this clarifies something to you.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
