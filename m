Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209E79304A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbjIEUsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIEUsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:48:33 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:48:30 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5034113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:48:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37F3C433C8;
        Tue,  5 Sep 2023 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693946910;
        bh=/OBGVPSLoF4kXGH1AeHs0t7JFWo4oDqDHK3FiK3OxfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pmtjt2Smg53XsBWTdFubwGFOewywLgUmOmzIFJIALjRU4fs6g+D+N+vUi95P2AaUP
         jf2+K6+XR8yu+T3LrPUtRej7cn01+dlBtFqxdC6/FGYMbPSrGeQjmQPkqSDvzZ3QZ7
         KRdAyVrW1TfUS4gCujAJdWi5bzrjOsIkVjn7He2QjTQw3lpttlbMUWnQRLkgYCPeXp
         YFFpmOhMEhVhC3xnjfMjAk8WP8oprmL93kgRlZpCfNq6UBVJfRKAxahD0ZYAH7wX21
         JHj7Dw5qOUHDqNHBVvpvKWYpOTHz7HXXGmtPMkAqzEWQ35bQ0MYhMW6z4yE1zKv3hd
         PDDgd/tadjBYw==
Date:   Tue, 5 Sep 2023 13:48:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230905134828.74d37681@kernel.org>
In-Reply-To: <20230905093315.784052-1-lukma@denx.de>
References: <20230905093315.784052-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Sep 2023 11:33:15 +0200 Lukasz Majewski wrote:
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") (for KSZ9477).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

No need to repost for just this, but if there is a v5:
 - no empty line between Fixes and other tags
 - add the comment after '#' i.e.:

Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") # for KSZ9477
