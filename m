Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729D175AEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGTMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGTMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:49:28 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401E2137;
        Thu, 20 Jul 2023 05:49:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A276E240014;
        Thu, 20 Jul 2023 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689857364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KM2SNsZ/HAYwDzPK1l8Fn0Kjjd/fx0+8gmsPG5KrJWc=;
        b=FEh8dN41ecWrK2JCCbjB9zBgE9WkGGualnGygAJrZVYFkXIxDGxSUpQykjxr0AzozyZ7cU
        qz7K48c92QfNUdV05PdDAbooql7esT72PoDftVnhRhv0z5LSafebmRZPVg8GdxNM112wpI
        6rKWJorJxONEzQO1uNbQY3PgEoNRkEhXnJP8HczlydnmBqvFkFTRxKw7j6eMNsY38tQFT5
        Pye+lsCX9jqxH9R3wowxWVVUc5ua1IG70OeATVmszNu+hYev8lenMrAwDsL2sITr3/7InS
        4cjaEtZT8ky9/jYANrNEnwpxxFsV98nKM86XXin2SI9R+EYsD4SexDjroj9E8A==
Date:   Thu, 20 Jul 2023 14:49:16 +0200
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
Message-ID: <20230720144916.01d49adb@booty>
In-Reply-To: <DB7PR04MB45050B15EDA7A2A3940840308C3EA@DB7PR04MB4505.eurprd04.prod.outlook.com>
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
        <20230719184831.75ae8658@booty>
        <DB7PR04MB45050B15EDA7A2A3940840308C3EA@DB7PR04MB4505.eurprd04.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu,

On Thu, 20 Jul 2023 10:13:57 +0000
Xu Yang <xu.yang_2@nxp.com> wrote:

> Hi Luca,
> 
> > > > -----Original Message-----
> > > >
> > > > Hello Xu,
> > > >
> > > > On Tue, 18 Jul 2023 08:31:48 +0000
> > > > Xu Yang <xu.yang_2@nxp.com> wrote:
> > > >  
> > > > > > -----Original Message-----
> > > > > >
> > > > > > Ciao Francesco,
> > > > > >
> > > > > > On Thu, 6 Jul 2023 12:23:43 +0200
> > > > > > Francesco Dolcini <francesco@dolcini.it> wrote:
> > > > > >  
> > > > > > > Hello Luca,
> > > > > > >
> > > > > > > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:  
> > > > > > > > Yes, your understanding is correct, talked with Xu(in CC), he will take this
> > > > > > > > soon.  
> > > > > > >
> > > > > > > A series was posted
> > > > > > >
> > > > > > > I had no time to try or look at it yet.  
> > > > > >
> > > > > > Thanks for keeping me up to date on this topic, which is still totally
> > > > > > relevant to me.
> > > > > >
> > > > > > I looked at the series, but it does not seem to be addressing the
> > > > > > problem with USB host not detecting new devices when VBUS is not
> > > > > > directly connected, e.g. in the Colibri imx6ull SoM.
> > > > > >
> > > > > > Xu, do you confirm the series at the link is _not_ solving the problem
> > > > > > being discussed here?  
> > > > >
> > > > > Have you tried this patchset? The upstream driver couldn't get correct
> > > > > USB role from HW_USBPHY_CTRL register when the ID pin is float. This is
> > > > > what this patchset is trying to fix. With this patch, condition
> > > > > "(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be false when
> > > > > controller acts as host role, then __mxs_phy_disconnect_line(phy, true)
> > > > > will never be called. So I think it doesn't matter whether VBUS is connected
> > > > > or not when act as host mode. If you still have issue after apply this patchset,
> > > > > please let me know.  
> > > >
> > > > I tested this patchset on top of v6.5-rc2 and I confirm USB detection
> > > > is still broken on the Colibri iMX6ULL. With or without the patches
> > > > the behavior is the same: USB devices are detected only during boot,
> > > > and anything connected after boot are never detected.  
> > >
> > > Thanks for your feedback. As you said this issue will disappear with below change, right?
> > >
> > >       diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > >       index e1a2b2ea098b..ec5ee790455e 100644
> > >       --- a/drivers/usb/phy/phy-mxs-usb.c
> > >       +++ b/drivers/usb/phy/phy-mxs-usb.c
> > >       @@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_phy_data = {
> > >        };
> > >
> > >        static const struct mxs_phy_data imx6ul_phy_data = {
> > >       -       .flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> > >        };
> > >
> > >        static const struct mxs_phy_data imx7ulp_phy_data = {  
> > 
> > Exactly.
> >   
> > > So I guess something in __mxs_phy_disconnect_line(mxs_phy, true) is causing this behavior.
> > > Could you please help to find which line to comment to make this issue disappear?  
> 
> To correct what I said:  __mxs_phy_disconnect_line(mxs_phy, false) should
> be called.
> 
> I think the enable wakeup sequence should be follow for host-only port:
> mxs_phy_set_wakeup(mxs_phy, true)
>     mxs_phy_disconnect_line(mxs_phy, true);
>         __mxs_phy_disconnect_line(mxs_phy, false);
> 
> And disable wakeup sequence:
> mxs_phy_set_wakeup(mxs_phy, false)
>     mxs_phy_disconnect_line(mxs_phy, false);
>         __mxs_phy_disconnect_line(mxs_phy, false);
> 
> So "bool variable disconnect is false" all the time.
> 
> > 
> > I did some tests and detection works by doing _any_ of the following
> > two changes (or both of them).
> > 
> > Change 1:
> > 
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -359,10 +359,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
> >         void __iomem *base = mxs_phy->phy.io_priv;
> >         u32 reg;
> > 
> > -       if (disconnect)
> > -               writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
> > -                       base + HW_USBPHY_DEBUG_CLR);
> > -  
> 
> Since disconnect = false, this code didn't get executed all the time.
> Remove this will have no impact. But your test results didn't align
> to this. Could you please help check the sequence? Is disconnect
> true or false when __mxs_phy_disconnect_line is called?

What I observe is that __mxs_phy_disconnect_line(..., true) is called.
This happens during boot and after unplugging a device in case one was
detected during boot.

This is because in mxs_phy_disconnect_line() [0]:
 - on = 1
 - !vbus_is_on = 1
 - !mxs_phy_is_otg_host(mxs_phy) = 1

Which one(s) of those three would you expect to be 0?

Some additional info about the !mxs_phy_is_otg_host(mxs_phy) value:
with or without CONFIG_USB_OTG, it always has the same value because
phyctrl always has the BM_USBPHY_CTRL_OTG_ID_VALUE bit set.

[0]
https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/usb/phy/phy-mxs-usb.c#L415

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
