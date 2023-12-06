Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88B7806324
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjLFADK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjLFADI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:03:08 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B461A2;
        Tue,  5 Dec 2023 16:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZowHgJwHbLNG5um7ode501HNWFXI0JGKi/xZLjVzRjk=; b=sYYj1LXeyhNfrnBTuKq34KJWRh
        yzr/Xd/92Q0hojZYD+xj8Ut4AfIWBL59l5G9u0mqVTiRy+u1wtIUXb5jgmhgmo1+3umZUrK+gCMIs
        kB0hoWmBXoWiwWYKwN7fFbZJdNCIsK2AkWh2JHXCz7ScY9IE+wOle4XwOdARHbU7pG+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rAfNX-0029lB-NZ; Wed, 06 Dec 2023 01:03:03 +0100
Date:   Wed, 6 Dec 2023 01:03:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Only resume phy if it is suspended
Message-ID: <7e3208aa-3adf-47ec-9e95-3c88a121e8a3@lunn.ch>
References: <20231205234229.274601-1-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205234229.274601-1-justin.chen@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:42:29PM -0800, Justin Chen wrote:
> Resuming the phy can take quite a bit of time. Lets only resume the
> phy if it is suspended.

Humm...

https://lore.kernel.org/netdev/6d45f4da-c45e-4d35-869f-85dd4ec37b31@lunn.ch/T/

If Broadcom PHYs are slow to resume, maybe you should solve this in
the broadcom resume handler, read the status from the hardware and
only do the resume if the hardware is suspended.

     Andrew
