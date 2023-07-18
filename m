Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27067576DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGRImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGRImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:42:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE76A6;
        Tue, 18 Jul 2023 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PUFHK/0lkljVDIbxvCvY/jgMbVxQaKpPjRRBnR2abHA=; b=WVdMWGPc/cqXGwQzk2aV/7TJPo
        8Eevg/IQq9+aDbDRk2L2XIL4yAWSpa4wWorm1rMZAIN6Z7NpUps8HMLAJNnUJWgqsapRs1FJ+Emq7
        Rz9cbbIYhvVFcoFFPMcKYLcr84+svfcE5KpBYcYTIIHhrxqpgNiwNovPj++/Zasa/iBOWZHmwsMZS
        EGOgbkbBlu1GRWftmyc+djhXIJN0xy1x0n3mrRTDPn58hkWr03iMnoOlZFjnrsm7rGyIF7NvFENoD
        C9CJEpyX1VB+qg+UAY5iRlyqBiNIaf9SIF3VprsskFMMUJvw4e2mOhSt1BJoKJiynAKtDtsDLF0Ly
        q056U4Ow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52264)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qLgHW-0005ay-1G;
        Tue, 18 Jul 2023 09:42:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qLgHV-0002u4-FG; Tue, 18 Jul 2023 09:42:05 +0100
Date:   Tue, 18 Jul 2023 09:42:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc:     "Haener, Michael" <michael.haener@siemens.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Message-ID: <ZLZQXYvJXl44v7MN@shell.armlinux.org.uk>
References: <20230718065937.10713-1-michael.haener@siemens.com>
 <20230718065937.10713-4-michael.haener@siemens.com>
 <ZLZDi22lqZfHKFUZ@shell.armlinux.org.uk>
 <ZLZDzXQN3MKfOSwk@shell.armlinux.org.uk>
 <bd7215b802b114b75de4568cc1642f791b233338.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7215b802b114b75de4568cc1642f791b233338.camel@siemens.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 08:24:47AM +0000, Sverdlin, Alexander wrote:
> Hello Russell,
> 
> On Tue, 2023-07-18 at 08:48 +0100, Russell King (Oracle) wrote:
> > On Tue, Jul 18, 2023 at 08:47:23AM +0100, Russell King (Oracle) wrote:
> > > On Tue, Jul 18, 2023 at 08:59:31AM +0200, M. Haener wrote:
> > > > From: Michael Haener <michael.haener@siemens.com>
> > > > 
> > > > The 88e632x family has several SERDES 100/1000 blocks. By adding these
> > > > operations, these functionalities can be used.
> > > > 
> > > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > > ---
> > > > Changelog:
> > > > v3: rebased onto main branch
> > > > v2: rebased onto Russell Kings series dsa/88e6xxx/phylink
> > > 
> > > I think you're missing something - you seem to be adding support to read
> > > the statistics from these blocks, but you're not actually driving them
> > > at all in terms of reading their status or configuring them.
> > > 
> > > You need to modify drivers/net/dsa/mv88e6xxx/pcs-6352.c for that.
> > 
> > ... and this is why you need to be able to test on recent kernels!
> 
> are you absolutely sure about it?

Yes.

> mv88e6352_serdes_get_stats() remained in serdes.c after your rework and
> as I see it, your rework is about link status, but you didn't touch
> registers and statistics.

What I said was:

"but you're not actually driving them at all in terms of reading their
status or configuring them"

I was not commenting on obtaining statistics, but the status/control
of the blocks, which is now in the PCS drivers.

So, right now it looks to me that _all_ this series is doing is
providing support to read statistics from the PCS blocks and nothing
more, so the cover message for this series is misleading. It is not
adding support for the serdes blocks. It is only adding support for
reading statistics from the serdes blocks.

Either correct the patch series to do what the cover message says it's
doing, or change the cover message to properly describe what the series
is doing. It needs to be consistent.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
