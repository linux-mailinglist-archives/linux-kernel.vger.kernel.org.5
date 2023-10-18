Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1777CDDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjJRNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjJRNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:52:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDAA106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C148C433C8;
        Wed, 18 Oct 2023 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697637152;
        bh=K1Dhr3hZfDVKtLxR/ZTMbEg+7QkrSlzrgGTTVTTgxu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYGuBX65JLvJBpr6PoUDf/vrBelz9XtdvhtAQuC9ozyy4EobVjTTGfLCyklF7g6/r
         Pm9jNWxk2xpe6nQy6K9sh4fUiqVrf8x03esnGFS6i5bBKYJ/NKQQp0a6fxrW9YLngR
         2bLCiHk7zCl3NuWfBEyXCNGp2cIWJYl8f3Umti3RVzfk1EDih8PiEfpUWFJ4jyDIDM
         aniznZKREE9mQqpXk4Kv2rDXyzmspKhcmLM6oOiMT0CEw4fgHwBtokHsx4YMeZAdDh
         riB7FfryMlC/QSBJV639ZkFJMNGN74o4ebqWGDQMwxbE6Wmqba0+jXM823rGfYPnun
         Whc+m+nZlxYLw==
Date:   Wed, 18 Oct 2023 15:52:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: phy: bcm7xxx: Add missing 16nm EPHY
 statistics
Message-ID: <20231018135228.GP1940501@kernel.org>
References: <20231017205119.416392-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017205119.416392-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 01:51:19PM -0700, Florian Fainelli wrote:
> The .probe() function would allocate the necessary space and ensure that
> the library call sizes the nunber of statistics but the callbacks
> necessary to fetch the name and values were not wired up.
> 
> Reported-by: Justin Chen <justin.chen@broadcom.com>
> Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


