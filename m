Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAC7518F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjGMGmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjGMGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:42:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624E106;
        Wed, 12 Jul 2023 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZT+ZP4gLMq+7/P1Ak/8Bkb5D3BtAhEM5pNeOau8WjUI=; b=Ti662E+d3nUaNeg5Fk1rdN+p4v
        kNAuIrmvPhzfuKr6LDbfZPJDc57/6jfxBA2eK9qzhUrRFFaxJNfwJ8E1zBnH24VfzNzTpVdabJ7Xw
        4k/rF1lNW4DOUuWRmYUdzUS0tF+vM1TqxWqsT4I2FWSmrJmf6CAVtMZgRBVsTYzcQvtEUldx0VRVG
        +dOW8MZrm6Rv52jS/d5A8y/BSli7r8F++XBQcBzWoOlOZpNd4xa5fb6SDXCMkAHZbzRwTCunoYF9c
        yB2P1Vqx0Pqjg5aMInsDeJN9YnbYIMfzcOPmu+kliuKvuR4yPy7YxEZ5aqX/sWQFX0qOJeardEC/Y
        b/r2NKHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57626)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qJq1e-0005ls-1e;
        Thu, 13 Jul 2023 07:42:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qJq1d-0005ts-Jb; Thu, 13 Jul 2023 07:42:05 +0100
Date:   Thu, 13 Jul 2023 07:42:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Haener, Michael" <michael.haener@siemens.com>
Cc:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
References: <20230704065916.132486-1-michael.haener@siemens.com>
 <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
 <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
 <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:51:51AM +0000, Haener, Michael wrote:
> On Wed, 2023-07-05 at 01:31 +0200, Andrew Lunn wrote:
> > On Tue, Jul 04, 2023 at 07:17:55AM +0000, Haener, Michael wrote:
> > > On Tue, 2023-07-04 at 08:59 +0200, M. Haener wrote:
> > > > From: Michael Haener <michael.haener@siemens.com>
> > > > 
> > > > This patch series brings SERDES support for the mv88e632x family.
> > > 
> > > Changelog:
> > > v2: rebased onto Russell Kings series dsa/88e6xxx/phylink
> > 
> > Russell King will be interested in a Tested-by: for his patchset.
> > That will also help get that patchset merged so yours can then
> > follow. So please keep an eye on the netdev list, and repost your
> > patches once Russells have been merged.
> > 
> >         Andrew
> 
> Once the other patch is merged, I will rebase this patch and resubmit.

From your response, I can only assume you have not understood Andrew's
comment.

Andrew is asking you to _test_ my patch set, and _then_ give a
Tested-by. It's useless to do that after my patch set has been merged.
This will give more confidence to my patch set when I submit it. Since
I'll be doing so maybe later today, you'll probably have to reply to
the series once it's been posted.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
