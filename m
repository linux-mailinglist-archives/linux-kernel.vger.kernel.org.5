Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1977805F23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjLEULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjLEULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:11:12 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58884183;
        Tue,  5 Dec 2023 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jJ9sUxistCYfXxn3AjS422gVO2JAhtrQB/n0qsuzpCI=; b=K2GrCTqPGZyOyLOd4c8Hy7pukH
        2n1l946J8qDLN59IrvFOKa//pddhem8F/rnq0m1bdxy6du0518ZbcAAbucA6svtLRytGX82xdSBsG
        oQEyIxyG7c54gl1NOemmR7yL2PFEtvzWqV518z6YtG6koHC9QdVC26wGREVOo1Fzx3YE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rAbky-0028ZN-Ig; Tue, 05 Dec 2023 21:11:00 +0100
Date:   Tue, 5 Dec 2023 21:11:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        workflows@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <a3572abc-b49a-44e7-b36c-cf462bcc09ac@lunn.ch>
References: <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
 <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
 <ZW89errbJWUt33vz@shell.armlinux.org.uk>
 <20231205072912.2d79a1d5@kernel.org>
 <ZW9LroqqugXzqAY9@shell.armlinux.org.uk>
 <d2762241-f60a-4d61-babe-ce9535d9adde@quicinc.com>
 <ZW9oc9TO93kOq20s@shell.armlinux.org.uk>
 <91dcd8c3-ae86-4350-838d-62ddb62fa2bb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91dcd8c3-ae86-4350-838d-62ddb62fa2bb@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Having worked with closed-source systems, especially VxWorks, for many
> years (where the header files contain all the documentation), it just
> seems strange to embed the documentation in the .c files.

The key words here might be closed-source. With such black boxes, you
don't have access the sources. You cannot look at the source to
understand how a function works. In the open source world, the
comments partially function as an introduction to reading the code and
understanding what it does. You are also encouraged to change the code
if needed, which in the closed source world you cannot do.

Given this discussion, i now think putting the documentation in the .c
file makes more sense. For the generated documentation it does not
matter, but for the reader of the code, having it in the .c files does
seem to make sense.

     Andrew
