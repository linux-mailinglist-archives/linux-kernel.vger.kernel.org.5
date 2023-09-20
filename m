Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61347A7A08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjITLHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjITLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:07:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC689E;
        Wed, 20 Sep 2023 04:07:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A2D921C89;
        Wed, 20 Sep 2023 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695208031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZM62khM9FxGPIIvx68TVvW1jtj2aPa/D+qo+qZGdyOk=;
        b=WlQEqs3rft1VUSfH4TwqG44CQcpS3cp1YzjSM1DGSLQSUYCNiI1sxGI4veqcYOEEzBM1zy
        uVQpQ3hzhtwKwjHpM/f5UDbRjmLT1Ky6hHAmf3fUlknmevXyTVhmJfXnZHPphoKezatdSD
        f6FzOkTePV/aTjsTrJLv1ti98/OJm9M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67E63132C7;
        Wed, 20 Sep 2023 11:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hHLnFl/SCmXmLQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 20 Sep 2023 11:07:11 +0000
Date:   Wed, 20 Sep 2023 13:07:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-09-23 12:04:48, Jeremi Piotrowski wrote:
> On 9/20/2023 10:43 AM, Michal Hocko wrote:
> > On Wed 20-09-23 01:11:01, Jeremi Piotrowski wrote:
> >> On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
> >>> 6.1-stable review patch.  If anyone has any objections, please let me know.
> >>>
> >>> ------------------
> >>
> >> Hi Greg/Michal,
> >>
> >> This commit breaks userspace which makes it a bad commit for mainline and an
> >> even worse commit for stable.
> >>
> >> We ingested 6.1.54 into our nightly testing and found that runc fails to gather
> >> cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
> >> into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
> >> fine.
> > 
> > Could you expand some more on why is the file read? It doesn't support
> > writing to it for some time so how does reading it helps in any sense?
> > 
> > Anyway, I do agree that the stable backport should be reverted.
> > 
> 
> This file is read together with all the other memcg files. Each prefix:
> 
> memory
> memory.memsw
> memory.kmem
> memory.kmem.tcp
> 
> is combined with these suffixes
> 
> .usage_in_bytes
> .max_usage_in_bytes
> .failcnt
> .limit_in_bytes
> 
> and read, the values are then forwarded on to other components for scheduling decisions.
> You want to know the limit when checking the usage (is the usage close to the limit or not).

You know there is no kmem limit as there is no way to set it for some
time (since 5.16 - i.e. 2 years ago). I can see that users following old
kernels could have missed that though.

> Userspace tolerates MEMCG/MEMCG_KMEM being disabled, but having a single file out of the
> set missing is an anomaly. So maybe we could keep the dummy file just for the
> sake of consistency? Cgroupv1 is legacy after all.

What we had was a dummy file. It didn't allow to write any value so it
would have always reported unlimited. The reason I've decided to remove
the file was that there were other users not being able to handle the
write failure while they are just fine not having the file. So we are
effectively between a rock and hard place here. Either way something is
broken. The other SW got fixed as well but similar to your case it takes
some time to absorb the change through all 3rd party users.

> >>> Address this by wiping out the file completely and effectively get back to
> >>> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
> >>
> >> On reads, the runc code checks for MEMCG_KMEM=n by checking
> >> kmem.usage_in_bytes.

Just one side note. Config options get renamed and their semantic
changes over time so I would just recomment to never make any
dependencies on any specific one. 

> >> If it is present then runc expects the other cgroup files
> >> to be there (including kmem.limit_in_bytes). So this change is not effectively
> >> the same.
> >>
> >> Here's a link to the PR that would be needed to handle this change in userspace
> >> (not merged yet and would need to be propagated through the ecosystem):
> >>
> >> https://github.com/opencontainers/runc/pull/4018.
> > 
> > Thanks. Does that mean the revert is still necessary for the Linus tree
> > or do you expect that the fix can be merged and propagated in a
> > reasonable time?
> > 
> 
> We can probably get runc and currently supported kubernetes versions patched in time
> before 6.6 (or the next LTS kernel) hits LTS distros.
> 
> But there's still a bunch of users running cgroupv1 with unsupported kubernetes
> versions that are still taking kernel updates as they come, so this might get reported
> again next year if it stays in mainline.

I can see how 3rd party users are hard to get aligned but having a fix
available should allow them to apply it or is there any actual roadblock
for them to adapt as soon as they hit the issue?

I mean, normally I would be just fine reverting this API change because
it is disruptive but the only way to have the file available and not
break somebody is to revert 58056f77502f ("memcg, kmem: further
deprecate kmem.limit_in_bytes") as well. Or to ignore any value written
there but that sounds rather dubious. Although one could argue this
would mimic nokmem kernel option.

-- 
Michal Hocko
SUSE Labs
