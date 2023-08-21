Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D6782A36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjHUNOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjHUNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:14:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DE135;
        Mon, 21 Aug 2023 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=D+Evs2ldTgHIJLnwm1dUWAxe+Hr0v4gc4CgnDjem250=; b=WH3lLGhTpskfQMFY1y8k4SsKZp
        H7PpPcR0SJgpeou8r0qY3vusN9fkIuBT1whM7vwqtURxYVCJmeeXGEDukeelygBVkn6vUsrUDzf+6
        d8Nz6UE/wVpwajht70R4QERgTYwK8tW3L2Yyiq519XiBbPTOf4YsJG3PHLxu1K3roq4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qY4iE-004goS-3A; Mon, 21 Aug 2023 15:12:54 +0200
Date:   Mon, 21 Aug 2023 15:12:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <97f3744d-afbf-4562-9168-5b9e211fac1f@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
 <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
 <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, please allow me to explain again.
> The RTL90xx Series supports I2C, MDC/MDIO and SPI slave to access the registers of Ethernet Switch Core and the external CPU could manage it via these pins.

I was wondering if you had mis-understood my question. The bus
'master' is the device which controls the bus. SPI and MDIO has one
bus master, and there can be multiple clients on the bus. I2C in
theory can have multiple bus masters on one bus, bit it is not done
too often. Your switch is a client.

So my question was, are the bus masters also on PCIE enpoints within
the chip. From an architecture standpoint, it would make sense they
are, all you need is one 4x PCIE slot, and this chip gives you
everything you need. But you can also make use of the SoCs I2C, SPI or
MDIO bus.

    Andrew
