Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006C7F1D22
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjKTTK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjKTTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:10:24 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C21E3;
        Mon, 20 Nov 2023 11:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nQggdxI9MQ2FS/W0GEG8D1cdBawPg8AZAzpNVf/hhDE=; b=wv7i7KIsLK5sNs6GxBZ1eTPvBs
        8D8waGZ6Bwkk1VOH7PyCYlBdY9FsgioEi1s1ihGrbcNKiF9AfI7TAtw9C3PUA/kTAIHd12QNvdw4o
        DOtwmu10YB8J+ElXm/wS/syMFmzPx6OXbkbgALZ95FKgsPgKIEkAwVFlO2KcY8A133LpHG23/UDXt
        DxGwZ0Ee1yOjGDnINBC/yfQAQU9K0KOT2AdYYXMPnLAMhzilCsGlSHatd15UG/R4Zf831IuuTQvtR
        o6JmuUipByC7p2R4IlIWia1+wi6WZUEDC0JRDZ+tVZBruY6fC5yfCeWJPrdORF0W9FOWHPCbxrmm4
        v6qFC6bA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60598)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r59ef-00062L-1c;
        Mon, 20 Nov 2023 19:09:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r59ed-0003Q4-V6; Mon, 20 Nov 2023 19:09:55 +0000
Date:   Mon, 20 Nov 2023 19:09:55 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <ZVuvA5V6IWa4fIs3@shell.armlinux.org.uk>
References: <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
 <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:39:35PM +0100, Andrew Lunn wrote:
> > What about my use case of having a NIC which can stamp at a low rate
> > at the PHY (for PTP) and high rate at the DMA block (for congestion
> > control)? Both stamp points have the same PHC index.
> 
> How theoretical is that? To me, it seems more likely you have two PHC.
> 
> The PHY stamping tends to be slow because of the MDIO bus. If the MAC
> has fast access to the PHC, it means its not on the MDIO bus. It
> probably means you have the PHY integrated into the MAC/SoC, so the
> MAC can access it. But if its integrated like this, i don't see why
> PHY stamping should be particularly slow. So you can probably use it
> for congestion control. And then you don't need DMA stamping.
> 
> Do you know of real hardware with a MAC and a PHY sharing a PHC?

Not so much a MAC and PHY sharing a PHC, but I notice in USXGMII-M,
there is the ability for the PHY to pass the timestamp back to the MAC
through the USXGMII-M connection - which would eliminate the problems
of accessing the PHY to get that the timestamps.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
