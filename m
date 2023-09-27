Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B147B0146
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjI0KHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0KHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:07:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308D9F;
        Wed, 27 Sep 2023 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5mb7UCtt287u2AVEC7nzPtWN+9oSM3yaJpQba5of3yE=; b=Va9dLphGmqpENDkTS6gwTlMqwx
        0c14obnirREEyoX2zg8A7Y64yHA0eyr/715AuPZ0dQX5hX8MuyqCX0LWgfvbVll3wI+u48n4zTWpP
        tRJ0oPlubXP58nk4pu4o3ZVCAaE8jFmy8JFiuXGABZa62y535Vlb+gj+58vU8EG+IvWf1ckHCDBUv
        u+P6djzEDOCzqV+SQAI/rCrBrdgl0YdGf/KNuDAw9iAc+lLxKfrtG4MmkwANH4RjR3fInHljY2PBw
        IuK/Ioi0XcyTXv/DRDGtjQvmxZTC5mzTbAg4sa0jx2fIH/7RkWWYcpWYcdy1V094sm5F1vsgqvys5
        lDG9NabQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39180)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qlRRY-0003kJ-1H;
        Wed, 27 Sep 2023 11:06:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qlRRZ-0001L9-3B; Wed, 27 Sep 2023 11:06:57 +0100
Date:   Wed, 27 Sep 2023 11:06:57 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone
 GPON-ONU-34-20BI
Message-ID: <ZRP+wSOstlNS3S5A@shell.armlinux.org.uk>
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
 <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
 <5615a39b3402e7499fd531c928845e102fba6f1c.camel@redhat.com>
 <ZRP7FU3BglzFBfgX@shell.armlinux.org.uk>
 <6513fc16.7b0a0220.d972c.48cf@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6513fc16.7b0a0220.d972c.48cf@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:55:32AM +0200, Christian Marangi wrote:
> On Wed, Sep 27, 2023 at 10:51:17AM +0100, Russell King (Oracle) wrote:
> > On Thu, Sep 21, 2023 at 04:40:45PM +0200, Paolo Abeni wrote:
> > > Hi Russel,
> > > 
> > > On Tue, 2023-09-19 at 14:40 +0100, Russell King (Oracle) wrote:
> > > > On Tue, Sep 19, 2023 at 02:47:20PM +0200, Christian Marangi wrote:
> > > > > Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> > > > > NRZ in their EEPROM.
> > > > > 
> > > > > The module also require the ignore tx fault fixup similar to Huawei MA5671A
> > > > > as it gets disabled on error messages with serial redirection enabled.
> > > > 
> > > > I'll send you shortly a different approach for the "ignore tx fault"
> > > > thing that I'd like you to test please.
> > > 
> > > Said patch is not blocking this one, am I correct?
> > 
> > Correct, but Christian has not responded in any way despite me sending
> > him the patch that I'd like tested, which is very disappointing.
> >
> 
> I'm with you with the disappointment... I was helping a guy adding
> support for this upstream and then magically disappeared... Tried to
> send private email asking to test your followup patch but still no
> response... Sorry for not answering your email, was hoping to have a
> response and just give you a positive feedback but I think this won't
> come...

In my experience, unfortunately, this is what happens in circumstances
like this. There are some cases where it doesn't happen but inevitably
when it's someone who's popped up with a problem, that's all they care
about. After a while one gets jaded over it.

Thanks for trying anyway.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
