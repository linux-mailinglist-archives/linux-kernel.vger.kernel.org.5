Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097BA7DC189
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjJ3VEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJ3VEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98EDD;
        Mon, 30 Oct 2023 14:04:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF20C433C7;
        Mon, 30 Oct 2023 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698699887;
        bh=y9rk2ohWAObBgP8LK1Pq91qTHCX8Gka2xPsQCvxmDoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hLuBStOxwKnDut2uT/Ihuauupp1MLlTY3iV1CNeXjIuiqLHbUYNizGJNoU+f2nIXL
         rUgY87bUpTZl5roLlFSrcQmFcXZYjWJuAOOU9jkfbzyJiPVCQquZDtfMNLK1RDY3qc
         J3Nch24SToejeb5rqWlC3K7ueIeD6jmbOXhtIDquTnwGJMb4HLy59lc+9eb8ZtOukE
         VJUHlgD9H1QHf9doU3L4wJCVh/8JLm4dHvs6CMt9frvhfuhJnz8xDOD998xpvHy9IN
         tvx6ug6JsgitW2TxUKYv7WRYha72N26Iaol8eqeU71uPzQqBTRFSQX9hDhOrEf3CRg
         ioo5v1ImlzXcw==
Date:   Mon, 30 Oct 2023 14:04:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kira <nyakov13@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com, Coiby Xu <coiby.xu@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Sven Joachim <svenjoac@gmx.de>,
        Ian Kent <raven@themaw.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Message-ID: <20231030140444.38b64181@kernel.org>
In-Reply-To: <ZT_YntDOYEdlpx5x@d3>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
        <2023103001-drew-parmesan-c61a@gregkh>
        <ZT_YntDOYEdlpx5x@d3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 12:33:55 -0400 Benjamin Poirier wrote:
> > I'm all this, if you want to, but I would like it out of staging.  So  
> 
> I'd like it out of staging as well. Since nobody wants to maintain it, I
> think it should be deleted. However, my understanding is that Jakub is
> willing to take it back into drivers/net/ as-is given that there is at
> least one user. Jakub, did I understand that correctly?

Yes, of all the bad options this one seems least.. unusual.

To be clear - we can take the revert to net, and then the follow up /
move would go to net-next (after -rc1, for v6.8)? My initial thought 
was to get the move done in 6.7 as well, but I guess that'd be churn 
we don't want at this stage..
