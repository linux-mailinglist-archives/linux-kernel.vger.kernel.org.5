Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4B757BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGRMZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:25:12 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529B10C2;
        Tue, 18 Jul 2023 05:25:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9902FF810;
        Tue, 18 Jul 2023 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689683108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4Rr8+epwqNuJFPu2SACGV9w10aPsDPcHxXMePCOL88=;
        b=lEN3rjIS+6LEnVAAxqiebzncG6Ze0Kr2g3l6Jvjfq8deS4FFsNsnfyUB9N1d2zfvxggwsr
        DJzn6ShRi56lqKZXlxnD2yDE/3Ag9qAf/N3CTYY425/87kSrRffUWuzSwvAdVqgt5VbK/+
        iaMKW3dgvuhbdeInCWoUvjVdEGm9UM3PP572udluQvH+/Etsm2H+bKY9myuCrPcPUQgYVV
        cG4ykhi8Ht9YxB1tVfyozFiLWQYqLCN1MwHzmu7AVAu0+jWNPSjSLmI6GYQN87ZdPs605b
        zKQVKnl9TrFY5Rsh0R03yE4b9zCATn6xvtHFqhitsgRdwtWqFUgHE7UjTcUMKA==
Date:   Tue, 18 Jul 2023 14:25:04 +0200
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
Message-ID: <20230718142504.075d0186@booty>
In-Reply-To: <DB7PR04MB450573F8EA936E049F053A258C38A@DB7PR04MB4505.eurprd04.prod.outlook.com>
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

On Tue, 18 Jul 2023 08:31:48 +0000
Xu Yang <xu.yang_2@nxp.com> wrote:

> > -----Original Message-----
> > 
> > Ciao Francesco,
> > 
> > On Thu, 6 Jul 2023 12:23:43 +0200
> > Francesco Dolcini <francesco@dolcini.it> wrote:
> >   
> > > Hello Luca,
> > >
> > > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:  
> > > > Yes, your understanding is correct, talked with Xu(in CC), he will take this
> > > > soon.  
> > >
> > > A series was posted
> > >
> > > I had no time to try or look at it yet.  
> > 
> > Thanks for keeping me up to date on this topic, which is still totally
> > relevant to me.
> > 
> > I looked at the series, but it does not seem to be addressing the
> > problem with USB host not detecting new devices when VBUS is not
> > directly connected, e.g. in the Colibri imx6ull SoM.
> > 
> > Xu, do you confirm the series at the link is _not_ solving the problem
> > being discussed here?  
> 
> Have you tried this patchset? The upstream driver couldn't get correct
> USB role from HW_USBPHY_CTRL register when the ID pin is float. This is
> what this patchset is trying to fix. With this patch, condition 
> "(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be false when
> controller acts as host role, then __mxs_phy_disconnect_line(phy, true)
> will never be called. So I think it doesn't matter whether VBUS is connected
> or not when act as host mode. If you still have issue after apply this patchset,
> please let me know.

I tested this patchset on top of v6.5-rc2 and I confirm USB detection
is still broken on the Colibri iMX6ULL. With or without the patches
the behavior is the same: USB devices are detected only during boot,
and anything connected after boot are never detected.

For the archives, I'm replying also to the patch series.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
