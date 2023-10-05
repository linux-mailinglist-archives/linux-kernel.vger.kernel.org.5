Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72D7B9EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJEOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJEOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980BB22C90;
        Thu,  5 Oct 2023 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/eKCeJNe5cUfyu+XUYUXDRKj9pXdqaIZiHZwEA87Tv0=; b=OkF1GMCVjNcoTVw6/Yirr3F4LW
        2NpGcfL/ebet0DWCN7OKh2dMXutVNZGS67WbWRTE0fuztTBEdwcRC/BppQw897e1hm9VCCrqhFqbz
        NCMWCYTOxt/LVd59pKQ1S+aClMls1ObQ7ICFs/MCxk61aMydUFD1CnaIClX3OPnA4/Gw9IBWEI2jn
        FFw0ewBWaLxXpIP+s2ISGlgoSTODT3XbwumigYxib+GYf4m7YBET0lf+KHUYWePi01NaRwsXpnvbm
        +yCw5+EVLy4K85mTLzESuglVhkBHUdbZ0Jr2PXYNSnJbqqC6xtDjdLl6EoRsslxlwetDTlNlR9YVc
        m/NSvQpw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47980)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qoLqz-0003tB-1l;
        Thu, 05 Oct 2023 11:45:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qoLqz-0001we-4M; Thu, 05 Oct 2023 11:45:13 +0100
Date:   Thu, 5 Oct 2023 11:45:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: Re: [PATCH v3] net: phy: broadcom: add support for BCM5221 phy
Message-ID: <ZR6TuaIRQtVUDE8o@shell.armlinux.org.uk>
References: <20230928185949.1731477-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928185949.1731477-1-giulio.benetti@benettiengineering.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 08:59:49PM +0200, Giulio Benetti wrote:
> +	/* Read to clear status bits */
>  	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
>  	if (reg < 0)
>  		return reg;
>  
>  	/* Unmask events we are interested in and mask interrupts globally. */
> -	reg = MII_BRCM_FET_IR_DUPLEX_EN |
> -	      MII_BRCM_FET_IR_SPEED_EN |
> -	      MII_BRCM_FET_IR_LINK_EN |
> -	      MII_BRCM_FET_IR_ENABLE |
> -	      MII_BRCM_FET_IR_MASK;

Note this style of formatting, where MII_BRCM_xxx line up with the
first...

> +	if (phydev->phy_id == PHY_ID_BCM5221)
> +		reg = MII_BRCM_FET_IR_ENABLE |
> +		MII_BRCM_FET_IR_MASK;

That should be repeated here.

> +	else
> +		reg = MII_BRCM_FET_IR_DUPLEX_EN |
> +		MII_BRCM_FET_IR_SPEED_EN |
> +		MII_BRCM_FET_IR_LINK_EN |
> +		MII_BRCM_FET_IR_ENABLE |
> +		MII_BRCM_FET_IR_MASK;

and here.

>  
>  	err = phy_write(phydev, MII_BRCM_FET_INTREG, reg);
>  	if (err < 0)
> @@ -726,42 +731,50 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>  
>  	reg = brcmtest | MII_BRCM_FET_BT_SRE;
>  
> -	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> -	if (err < 0)
> -		return err;
> +	phy_lock_mdio_bus(phydev);
>  
> -	/* Set the LED mode */
> -	reg = phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
> -	if (reg < 0) {
> -		err = reg;
> -		goto done;
> +	err = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> +	if (err < 0) {
> +		phy_unlock_mdio_bus(phydev);
> +		return err;
>  	}
>  
> -	reg &= ~MII_BRCM_FET_SHDW_AM4_LED_MASK;
> -	reg |= MII_BRCM_FET_SHDW_AM4_LED_MODE1;
> +	if (phydev->phy_id != PHY_ID_BCM5221) {
> +		/* Set the LED mode */
> +		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
> +		if (reg < 0) {
> +			err = reg;
> +			goto done;
> +		}
>  
> -	err = phy_write(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);
> -	if (err < 0)
> -		goto done;
> +		reg &= ~MII_BRCM_FET_SHDW_AM4_LED_MASK;
> +		reg |= MII_BRCM_FET_SHDW_AM4_LED_MODE1;
>  
> -	/* Enable auto MDIX */
> -	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
> -			   MII_BRCM_FET_SHDW_MC_FAME);
> -	if (err < 0)
> -		goto done;
> +		err = __phy_write(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);

I think this can be simplified to:

		err = __phy_modify(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
				   MII_BRCM_FET_SHDW_AM4_LED_MASK,
				   MII_BRCM_FET_SHDW_AM4_LED_MODE1);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
