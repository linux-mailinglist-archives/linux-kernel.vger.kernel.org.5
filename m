Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD478EA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbjHaK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHaK22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:28:28 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFF9C5;
        Thu, 31 Aug 2023 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wnCzNlSkE5F1zMwOiuhnLrO8y6BR8P83DNKq+cd66L8=; b=ZBOgF45Taa4/lnz9gOK4Q7kkEx
        wiHtJVoX++1Dz95Wk9dDKq9AU/33l8hCG2WMcZ5zFlPICqLUi/eXT7J7TPu0UtIp4CvlZ1yBKxNK2
        hdEs52sGIrUV6UIzegyqhuYRVUA9WzVJ3WatxMBk1adOy6BV7hQ/tg+zwIpK/7lbjqLJFkV36SwlE
        Pb9Tst2LNeNwX9SBJ6gGqWOIkT3DjGrhrSgOtO/Au71EREeLJqsREdA4quruoGpsvHn8CqyqQcAO0
        KSGBAjNaoACjh+Ad+GPE4oAUBp0FSkyFqfPoP8cbMPuIESOHfLS4r0VeVpLE1xVRHV6leXH8xssQ7
        SG9NO5iQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36888)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbeu9-0002hL-34;
        Thu, 31 Aug 2023 11:28:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbeu8-0006iI-6t; Thu, 31 Aug 2023 11:28:00 +0100
Date:   Thu, 31 Aug 2023 11:28:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <ZPBrMMPiWubgFEZ0@shell.armlinux.org.uk>
References: <20230831072527.537839-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831072527.537839-1-lukma@denx.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:25:27AM +0200, Lukasz Majewski wrote:
> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
> index 8bef1ab62bba..eed474fc7308 100644
> --- a/include/linux/micrel_phy.h
> +++ b/include/linux/micrel_phy.h
> @@ -44,6 +44,7 @@
>  #define MICREL_PHY_50MHZ_CLK	0x00000001
>  #define MICREL_PHY_FXEN		0x00000002
>  #define MICREL_KSZ8_P1_ERRATA	0x00000003
> +#define MICREL_NO_EEE	0x00000004

Erm... Maybe someone should clarify this... we have in the code the
following tests for these "flags":

	/* Support legacy board-file configuration */
	if (phydev->dev_flags & MICREL_PHY_50MHZ_CLK) {
	        priv->rmii_ref_clk_sel = true;
	        priv->rmii_ref_clk_sel_val = true;
	}

	/* Skip auto-negotiation in fiber mode */
	if (phydev->dev_flags & MICREL_PHY_FXEN) {
	        phydev->speed = SPEED_100;
	        return 0;
	}

	if (phydev->dev_flags & MICREL_KSZ8_P1_ERRATA)
		return -EOPNOTSUPP;

	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
	 * in this switch shall be regarded as broken.
	 */
	if (phydev->dev_flags & MICREL_NO_EEE)
	        phydev->eee_broken_modes = -1;

Is it intentional that setting MICREL_PHY_50MHZ_CLK on its own also
activates the MICREL_KSZ8_P1_ERRATA and vice versa? Is it intentional
that setting MICREL_PHY_FXEN also activates MICREL_KSZ8_P1_ERRATA and
vice versa?

To me, this looks horribly broken, and this patch just perpetuates the
brokenness (but at least 0x4 doesn't overlap with the other flags.)

If it is intentional, then MICREL_KSZ8_P1_ERRATA should be defined to
make it explicit - in other words, as
(MICREL_PHY_FXEN|MICREL_PHY_50MHZ_CLK). If not, all these flags should
be defined using (1 << n) or BIT() to make it explicit that they're a
bit, and not just a hex number that gets incremented when the next flag
is added.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
