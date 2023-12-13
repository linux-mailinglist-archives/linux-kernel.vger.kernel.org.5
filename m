Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB3811FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjLMUSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:18:40 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA6E8;
        Wed, 13 Dec 2023 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WtvYARQIvVa42V3Ts7AHp1j9HKVZUD4Uobx17kdWS4k=; b=CRhE5vntcCn8A/MP0nkCfEkUIT
        2396T3Xj4sTyz/+OIZCSmi4+zRL7syDn04N10WK0Ag9CiU3zb1upFRkgA3nqJ5bFgjemfhA3CUagM
        F04TfXvMKSdjxUFsNP7o5QYyzZTVsTpYcGR1E3C+8qE4OqQ5x2KusZIG88vGinB+zQ69cj3OJqrRi
        z7JGr3P7bgQg3lFBOVkaRAPy6DFFrVdlbodpQu3QESxVckNkxmI4RBt75Mpk6PhgQX7B9SK7HGeuh
        /i46O8eM4aqXfXIk1/S8k2WegjW2ml65/o6FtuAohLz7m5BmbaiwIkfE5jkAi0hur6iHCS3aZpez+
        nfVtkA7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47214)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDVgj-0000Y3-0e;
        Wed, 13 Dec 2023 20:18:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDVgk-0001om-Rm; Wed, 13 Dec 2023 20:18:38 +0000
Date:   Wed, 13 Dec 2023 20:18:38 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: phy: leds: use new define for link
 speed modes number
Message-ID: <ZXoRntVeW/YL/H5n@shell.armlinux.org.uk>
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
 <20231213181554.4741-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213181554.4741-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 07:15:54PM +0100, Christian Marangi wrote:
> Use new define __LINK_SPEEDS_NUM for the speeds array instead of
> declaring a big enough array of 50 elements to handle future link speed
> modes.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phy_led_triggers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
> index f550576eb9da..40cb0fa9ace0 100644
> --- a/drivers/net/phy/phy_led_triggers.c
> +++ b/drivers/net/phy/phy_led_triggers.c
> @@ -84,7 +84,7 @@ static void phy_led_trigger_unregister(struct phy_led_trigger *plt)
>  int phy_led_triggers_register(struct phy_device *phy)
>  {
>  	int i, err;
> -	unsigned int speeds[50];
> +	unsigned int speeds[__LINK_SPEEDS_NUM];
>  
>  	phy->phy_num_led_triggers = phy_supported_speeds(phy, speeds,
>  							 ARRAY_SIZE(speeds));

Yes, I agree the original code is utterly horrid, and there should be a
definition for its size. However, this is about the only place it would
be used - if you look at the code in phy_supported_speeds() and in
phy_speeds() which it calls, there is nothing in there which would know
the speed.

The only two solution I can think would be either a new function:

size_t phy_num_supported_speeds(struct phy_device *phydev);

or have phy_speeds() return the number of entries if "speeds" was NULL.

Then kmalloc_array() the speed array - but that seems a bit on the
side of things. The code as it stands is safe, because the passed
ARRAY_SIZE() limits the maximum index into speeds[] that will be
written, and it will result in the slower speeds not being added
into the array.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
