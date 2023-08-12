Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7080777A065
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHLOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjHLOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:20:01 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BBBA;
        Sat, 12 Aug 2023 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=IP9B9RcAGhD7kYJQbkxUcYc7o+AERXkJxjqGRCoR6ME=; b=aukyRRfbCtEqsPFvyqesLZDxj6
        rQr/DOumuVNLN8sEal0sB7aF+FYAfoxZt+E3M1hqnL17f0y7OuhZHmkbB4voKjvjYe/Eyj3qMCQAR
        VKCf/qtPteK6hZcqd9iOpmRctGKSUAueU6TyisJB2qU6EIdOFvKD3g6U9rwdztE47a4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUpSy-003uhy-E2; Sat, 12 Aug 2023 16:19:44 +0200
Date:   Sat, 12 Aug 2023 16:19:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Message-ID: <187506b6-f6a1-4e50-b287-f01984c1e334@lunn.ch>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
 <0188dd19-7fcb-4bfe-945d-6cb5b57ae80a@lunn.ch>
 <6f7fd397-2b63-be20-fa9c-c26298226088@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7fd397-2b63-be20-fa9c-c26298226088@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This table has some sort of sorting. I would put this new entry before
> > PHY_ID_BCM5241.
> > 
> > >   #define PHY_ID_BCM50610			0x0143bd60
> > >   #define PHY_ID_BCM50610M		0x0143bd70
> > >   #define PHY_ID_BCM5241			0x0143bc30
> > > +#define PHY_ID_BCM5221			0x004061e0
> > 
> > The value looks odd. Is the OUI correct? Is that a broadcom OUI?
> 
> Yes it is correct and yes it is assigned to Broadcom.

I found a datasheet for this PHY and it does list this OUI. I just
noticed it is the only device supported by this driver which uses this
OUI, so i just wanted to check.

     Andrew
