Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE97E03AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377679AbjKCNQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjKCNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:16:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599BE19D;
        Fri,  3 Nov 2023 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XUoUlhIW7TwMqkgphOP0uuquEKi9nLTWmd6P0wlkvck=; b=HVsdk43gWifGDK+Mlw/qeo0e6u
        WetGuSwRM3dD6HJfbhCVxWwiNaDHSx2Xro9bORaaUGP8NrGsiaGEHNvixSni0v0P35b/jEvCooAf4
        rYSn5zejZ5R8rXLMqEUX7Jj3vlByYhtVv7dYyYFibKbKhskzy4BTZKOVjtfTWnvX0sywdu1yRxFlg
        gbLL1uCW87i1+EG1EGxKJomNvngp2eIpcnotD9kRcizXara6IbyG1uvuwbgMtKHhmhpmDFFUbLNCP
        tkpdZyDojnNh9S2saxIOhWgNn3QsrZPPNY6drVgBAAFIiFLE/kiVdagMQeoqjUVXxmK0SYPfuckrD
        jogBtwEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44854)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qyu20-0005Yh-0l;
        Fri, 03 Nov 2023 13:16:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qyu20-0008RM-RX; Fri, 03 Nov 2023 13:16:12 +0000
Date:   Fri, 3 Nov 2023 13:16:12 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: Add SKOV IMX8MP CPU revB
 board
Message-ID: <ZUTynJpOSZVowuJk@shell.armlinux.org.uk>
References: <20231103105305.2459143-1-o.rempel@pengutronix.de>
 <20231103105305.2459143-2-o.rempel@pengutronix.de>
 <1ee285d7-6bc9-43ad-9ec9-a8aaed4452b5@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee285d7-6bc9-43ad-9ec9-a8aaed4452b5@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> > +				phy-mode = "rgmii-txid";
> > +				tx-internal-delay-ps = <2000>;
> 
> Is this actually needed? rgmii-txid should add 2ns delay. Since this
> apparently works, i'm assuming setting tx-internal-delay-ps to 2ns
> does nothing, otherwise you would have a 4ns delay.

Umm... I think we're getting confused again.

Mode		Local end		Remote end
RGMII		No added delays		No added delays
RGMII-TXID	No added delays		2ns delay on TX
RGMII-RXID	No added delays		2ns delay on RX
RGMII-ID	No added delays		2ns delay on both TX and RX

In the case of a network interface with a PHY, "local end" is the
MAC and "remote end" is the PHY.

For a switch port connected to an external PHY, the switch port is
as the "MAC" as above.

For a switch port connected to an ethernet MAC:
 - for the MAC declaration, the local end is the MAC. There is no
   communication of the interface mode with the remote end under
   Linux, so this is irrelevant for Linux. However, this is an
   implementation, and it should be chosen according to the hardware.

 - for the switch port declaration, the local end is the switch port.
   There is no communication of the interface mode with the remote
   end under Linux. However, it should be chosen according to the
   hardware.

So, if the 2ns delay is implemented on the RX lines (from the switch
perspective) then shouldn't the MAC side be using "rgmii-txid" to
indicate that the delay is being applied by the remote end (switch).
The switch side should be using "rgmii" because no delays are required
from the remote end (MAC), and the delay on the TX lines should be
specified using "tx-internal-delay-ps"?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
