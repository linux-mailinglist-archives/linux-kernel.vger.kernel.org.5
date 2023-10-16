Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE117CB303
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjJPSve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJPSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:51:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD4B4;
        Mon, 16 Oct 2023 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Wwyvx5/r8DlWIuvuE4BUh+Q9q3Bnv0KVmOjBo7ltZXc=; b=k/5f58raupQlNvFhnq37aIF13s
        qHQDwHS6afqKSVr1Rd9g4bmtP+l0nwuqh2BJTRap9cuKw9DPYVDFkPcHgr20mwrQoG6jLr+cMhBo3
        hFmo907zgy7HtutXDHVT+cWGmq3/YPJFvHF/Fcn/bBzY6afqxjpXZjj4+4S7k/2oiLZ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qsSgS-002Nqg-3b; Mon, 16 Oct 2023 20:51:20 +0200
Date:   Mon, 16 Oct 2023 20:51:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernek.org, Justin Chen <justin.chen@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:BROADCOM ETHERNET PHY DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
Message-ID: <00893dd5-8717-47cf-a0f5-b79f51a2ba99@lunn.ch>
References: <20231016184428.311983-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016184428.311983-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:44:28AM -0700, Florian Fainelli wrote:
> The .probe() function would allocate the necessary space and ensure that
> the library call sizes the nunber of statistics but the callbacks
> necessary to fetch the name and values were not wired up.
> 
> Reported-by: Justin Chen <justin.chen@broadcom.com>
> Fixes: 1b89b3dce34c ("net: phy: bcm7xxx: Add EPHY entry for 72165")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
