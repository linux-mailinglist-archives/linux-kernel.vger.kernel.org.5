Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC57AD1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjIYHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:41:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F28103;
        Mon, 25 Sep 2023 00:41:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E87051F38D;
        Mon, 25 Sep 2023 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695627684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CQnJityth03MjKwOvKQL0o16b7IPcbMBFQLaKRocuTI=;
        b=kj08/0h41LkrVpFjzbRDfKtPyfb8A9wff/lNCGoZORwH3/vbR7S1O0z7SQg/WlPBzlzRF9
        psrRMbPTeardaGcQnl1uLAlznmSm7WRdR2+NiBarxr0RZup33ctRJwZsZWbILA95SR/1N7
        2JSgKrJckBdee7P9tpf6LgjjwHT79jQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C775913A67;
        Mon, 25 Sep 2023 07:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QMWyLaQ5EWXuQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 25 Sep 2023 07:41:24 +0000
Date:   Mon, 25 Sep 2023 09:41:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZRE5pHgr28SaOmMC@dhcp22.suse.cz>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
 <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
 <ZQ4cjqQLhgX1pOVX@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ4cjqQLhgX1pOVX@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-09-23 16:00:30, Roman Gushchin wrote:
> On Wed, Sep 20, 2023 at 03:47:37PM +0200, Michal Hocko wrote:
> > On Wed 20-09-23 15:25:23, Jeremi Piotrowski wrote:
> > > On 9/20/2023 1:07 PM, Michal Hocko wrote:
> > [...]
> > > > I mean, normally I would be just fine reverting this API change because
> > > > it is disruptive but the only way to have the file available and not
> > > > break somebody is to revert 58056f77502f ("memcg, kmem: further
> > > > deprecate kmem.limit_in_bytes") as well. Or to ignore any value written
> > > > there but that sounds rather dubious. Although one could argue this
> > > > would mimic nokmem kernel option.
> > > > 
> > > 
> > > I just want to make sure we don't introduce yet another new behavior in this legacy
> > > system. I have not seen breakage due to 58056f77502f. Mimicing nokmem sounds good but
> > > does this mean "don't enforce limits" (that should be fine) or "ignore writes to the limit"
> > > (=don't event store the written limit). The latter might have unintended consequences.
> > 
> > Yes it would mean that the limit is never enforced. Bad as it is the
> > thing is that the hard limit on kernel memory is broken by design and
> > unfixable.  This causes all sorts of unexpected kernel allocation
> > failures that this is simply unsafe to use.
> > 
> > All that being said I can see the following options
> > 1) keep the current upstream status and not export the file
> > 2) revert both 58056f77502f and 86327e8eb94 and make it clear
> >    that kmem.limit_in_bytes is unsupported so failures or misbehavior
> >    as a result of the limit being hit are likely not going to be
> >    investigated or fixed.
> > 3) reverting like in 2) but never inforce the limit (so basically nokmem
> >    semantic)
> 
> Since it's a part of cgroup v1 interface, which is in a frozen state as a whole,
> and there is no significant (performance, code complexity) benefit of
> additionally deprecating kmem.limit_in_bytes, I vote for 2).
> 1) is also an option.

We have a stronger agrement over 3)
http://lkml.kernel.org/r/ZRE5VJozPZt9bRPy@dhcp22.suse.cz. Please speak
up if you disagree.

-- 
Michal Hocko
SUSE Labs
