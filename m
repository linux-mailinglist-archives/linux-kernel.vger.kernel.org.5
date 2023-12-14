Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2C812515
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjLNCM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:12:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A14BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:13:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6F8C433C8;
        Thu, 14 Dec 2023 02:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702519984;
        bh=dl6bXVaGaetNPS9qavZlOhXzgfopeDUt7Z61/X4VyoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RlmDPF4HcFSOaulqr9YRAlXmJOHOUkkswDfB69BFAsHj1mvKwWsexJCcqxVnTGnRX
         VyBaPY4qI1b43x63UTY365dISncZ5khk26S1E3hp7j5tSfBOddKT1QcyI47GQWimYW
         4zB6NpZd0mSLuXJ4C2d0wObLVAyHZ+Bsc5DNIOMa+e5uqXeyi9394zmtYnY/MV9//j
         /MkBKi+r5Dj+TDVxjnH8g9SUjiv7WmakCvCWT1ms3fQgDwj8Ji3fN4/m77S9SPsPag
         Pvkv8dmW9MMkXybAS9LeYMsFaoeExSRA96aslaxgfvUzMEORj6Pk7XFOv0vEOqyClT
         TgqWUUWLk3ulA==
Date:   Wed, 13 Dec 2023 18:13:03 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231213181303.34833b32@kernel.org>
In-Reply-To: <6579db46.5d0a0220.d624a.80b4@mx.google.com>
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
        <20231213105730.1731-3-ansuelsmth@gmail.com>
        <ZXnSB4YsuWZ0vdj2@shell.armlinux.org.uk>
        <6579d3df.050a0220.41f9b.a309@mx.google.com>
        <ZXnYKLOeStCuVXY7@shell.armlinux.org.uk>
        <6579db46.5d0a0220.d624a.80b4@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 17:26:43 +0100 Christian Marangi wrote:
> I tend to use cover letters only for big series, sorry for not being
> very clear about this.

FWIW in netdev the rule of thumb is "if there's more than 2 patches,
there's probably extra context". Even the 2 patch exception for cover
letters is mostly for when people post code + test, as two separate
patches. Cover letter stating that you have a series for xyz
pending, which will need this, seems like a straightforward ask..
