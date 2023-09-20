Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D47A7636
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjITIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:44:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C7994;
        Wed, 20 Sep 2023 01:43:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A55041FDDA;
        Wed, 20 Sep 2023 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695199437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjxBNZGORuJZTEppU8GKxjtCs5dciR43Qw/lEOGS50I=;
        b=EQnrAlU/3fuFatTWKEmawTXMpJeQzH/U6qvScECWhU41Pu6gX6JI12bG3Nr+YOhd9n7IOo
        q8G2eBepsmnJIuhaaiZ09mWIDB/3QPPqGQwfCCcOqZZEnyN5J9MY7jj18kpt1ks8tb3pEO
        K+ubfa53ezr2wkkyOZuUPYWxTXmLf34=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EDBD132C7;
        Wed, 20 Sep 2023 08:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZkT2G82wCmWvXQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 20 Sep 2023 08:43:57 +0000
Date:   Wed, 20 Sep 2023 10:43:56 +0200
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
Message-ID: <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-09-23 01:11:01, Jeremi Piotrowski wrote:
> On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> 
> Hi Greg/Michal,
> 
> This commit breaks userspace which makes it a bad commit for mainline and an
> even worse commit for stable.
> 
> We ingested 6.1.54 into our nightly testing and found that runc fails to gather
> cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
> into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
> fine.

Could you expand some more on why is the file read? It doesn't support
writing to it for some time so how does reading it helps in any sense?

Anyway, I do agree that the stable backport should be reverted.

> > Address this by wiping out the file completely and effectively get back to
> > pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
> 
> On reads, the runc code checks for MEMCG_KMEM=n by checking
> kmem.usage_in_bytes. If it is present then runc expects the other cgroup files
> to be there (including kmem.limit_in_bytes). So this change is not effectively
> the same.
> 
> Here's a link to the PR that would be needed to handle this change in userspace
> (not merged yet and would need to be propagated through the ecosystem):
> 
> https://github.com/opencontainers/runc/pull/4018.

Thanks. Does that mean the revert is still necessary for the Linus tree
or do you expect that the fix can be merged and propagated in a
reasonable time?

-- 
Michal Hocko
SUSE Labs
