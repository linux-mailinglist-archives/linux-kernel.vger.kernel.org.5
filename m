Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C4811FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442507AbjLMUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442421AbjLMUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:10:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CCDD;
        Wed, 13 Dec 2023 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PwOVL8mVKeFXsW0HcBL1U5ZeoAlOHIL4hxG+Ermm0Do=; b=oqrxxd8tZUp4TaF8Qx7f1USJ1+
        Fk0puhRMdQ1N94CmXAtd/ycvks7V8GFGMVLbTXDeapF7YvARte1MdPW22s1nZDz7RCHKik8n90hdx
        uYcTPoyaEfrgERS6cPOT22a506hCaeXtC6RCIGWKVKaQEfP6Rk+tAgC105YHDKHUmgB3PpTmG38R0
        ImWfo63KfDElgqlIqBaX4Lcl7T0EJBt6JS6dFQ/vrK4KVcoIqwSspzpNNQKE0X3qAoN/1ilToPqCH
        et2Bq1Locx3qPSg6Ak7iyYklE0KYJB+wjbyPo2Mh+VgY3TtZU3U/UFJhH7bNaXawD2H09mmkYIb7A
        /Cku/XiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36782)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDVZ6-0000XV-0W;
        Wed, 13 Dec 2023 20:10:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDVZ4-0001oW-BG; Wed, 13 Dec 2023 20:10:42 +0000
Date:   Wed, 13 Dec 2023 20:10:42 +0000
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
Subject: Re: [net-next PATCH 1/2] net: ethtool: add define for link speed
 mode number
Message-ID: <ZXoPwmDsy7geZe6N@shell.armlinux.org.uk>
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
 <20231213181554.4741-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213181554.4741-2-ansuelsmth@gmail.com>
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

NAK.

You *clearly* didn't look before you leaped.

On Wed, Dec 13, 2023 at 07:15:53PM +0100, Christian Marangi wrote:
> +enum ethtool_link_speeds {
> +	SPEED_10 = 0,
> +	SPEED_100,
> +	SPEED_1000,
...

and from the context immediately below, included in your patch:
>  #define SPEED_10		10
           ^^^^^^^^
>  #define SPEED_100		100
           ^^^^^^^^^
>  #define SPEED_1000		1000
           ^^^^^^^^^^

Your enumerated values will be overridden by the preprocessor
definitions.

Moreover, SPEED_xxx is an already taken namespace and part of the UAPI,
and thus can _not_ be changed. Convention is that SPEED_x will be
defined as the numeric speed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
