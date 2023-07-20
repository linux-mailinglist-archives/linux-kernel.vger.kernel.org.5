Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8175A3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGTBYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGTBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B1A2101;
        Wed, 19 Jul 2023 18:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBF961862;
        Thu, 20 Jul 2023 01:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA41BC433C7;
        Thu, 20 Jul 2023 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689816281;
        bh=wO09obrXhA42IrXPHgzvPAi/kdWTqRkdn+YMTWPwnrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVHyTbl4nOmOsVP2DCrgfluLcPrbYUS8oBUlD1YPJIOVbCHhsHRYbB7m7oLq3lSHC
         4MSrIm9LW6TPIu+Kf57ymU5mG5sSH/mC1YIqjjjRg0ZJdbC4E/jSiV21/jMTL7zECx
         ihpcVsMuf7Age5tb5jAGIntTzuw94jAThuRLczu86K66gSH3CCukp/eXW8CSV0IXZh
         R/HTkCb7jXz9NukJFvNijvqHCITycrHmSk7KmH19c+TrFg/w4ghXVjb/fk2SwEkuv7
         0IX+sxsFdoqaIhDpKMPEdzIDeBabFXAd3kW6S40AxbkXgDjC/f5RruUb2En9FAONGm
         BcYwyHgqna9IA==
Date:   Wed, 19 Jul 2023 18:24:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230719182439.7af84ccd@kernel.org>
In-Reply-To: <20230720105042.64ea23f9@canb.auug.org.au>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 10:50:42 +1000 Stephen Rothwell wrote:
> Hi all,
> 
> On Sat, 8 Jul 2023 00:17:15 +0000 "Von Dentz, Luiz" <luiz.von.dentz@intel.com> wrote:
> >
> > There was a patch sent to net-next that was supposed to fix this:
> > 
> > [PATCH v1 net-next 2/2] net: scm: introduce and use scm_recv_unix helper
> > 
> > I am waiting for it to be merged.
> > 
> > 
> > ________________________________
> > From: Stephen Rothwell
> > Sent: Thursday, July 6, 2023 4:41 PM
> > To: Marcel Holtmann; Johan Hedberg
> > Cc: Von Dentz, Luiz; Linux Kernel Mailing List; Linux Next Mailing List
> > Subject: Re: linux-next: build failure after merge of the bluetooth tree
> > 
> > Hi all,
> > 
> > On Fri, 16 Jun 2023 08:32:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > >
> > > On Tue, 13 Jun 2023 13:02:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:    
> > > >    
> > >  After merging the bluetooth tree, today's linux-next build (arm    
> > > > multi_v7_defconfig) failed like this:
> > > >
> > > > ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!
> > > >
> > > > Caused by commit
> > > >
> > > >   817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> > > >
> > > > I have reverted that commit for today.    
> > >
> > > I am still reverting that commit.    
> > 
> > Ditto  
> 
> This is getting a bit ridiculous ... a build failure reported over a
> month ago with a fix
> (https://lore.kernel.org/netdev/20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com)
> posted 3 weeks ago, has not yet been fixed :-(
> 
> What is stopping that fix (with the appropriate followup) being added
> to the bluetooth tree?  Or just the fix being added to the net-next tree?
> 
> Yes, I know that the time period includes the merge window, but it has
> been more that a week since then.

Something weird. We did merge it, there was a sort-of-v2-called-v1:

https://lore.kernel.org/all/20230627174314.67688-1-kuniyu@amazon.com/

Merged as https://git.kernel.org/netdev/net-next/c/a9c49cc2f5b5

Dunno how it's supposed to fix this particular issue, tho, on a closer
look, as it still calls:

  scm_recv_unix() -> scm_pidfd_recv() -> pidfd_prepare()

:S
