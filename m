Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6357AA187
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjIUVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIUVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EB958C0B;
        Thu, 21 Sep 2023 10:19:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD971FEEE;
        Thu, 21 Sep 2023 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695282738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/0oYUclWySzO4UEPbzCuo3zYsDaVkz6hpk5DqEwIcE=;
        b=Jiw05hdmZB0DhYYIEhnqVdYUHb3kJrZBFq7kscrw26w2oZw+aLFwI4+vQgabJLGMtsYVEX
        qioOOJkV2NTvpd559t3IitKAnSVb/9yrMkWTwxlNvgZy6NlBRSLPZJcAYjZo9oZ6pcvEcE
        b1a0G34c7tFDVbN65GfAruRXpRHGdx0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11792134B0;
        Thu, 21 Sep 2023 07:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wySoAzL2C2UbBgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 21 Sep 2023 07:52:18 +0000
Date:   Thu, 21 Sep 2023 09:52:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZQv2MXOynlEPW/bX@dhcp22.suse.cz>
References: <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
 <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
 <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
 <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
 <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz>
 <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-09-23 14:46:52, Shakeel Butt wrote:
> On Wed, Sep 20, 2023 at 1:08 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > > have a strong opinion against it. Also just to be clear we are not
> > > talking about full revert of 58056f77502f but just the returning of
> > > EOPNOTSUPP, right?
> >
> > If we allow the limit to be set without returning a failure then we
> > still have options 2 and 3 on how to deal with that. One of them is to
> > enforce the limit.
> >
> 
> Option 3 is a partial revert of 58056f77502f where we keep the no
> limit enforcement and remove the EOPNOTSUPP return on write. Let's go
> with option 3. In addition, let's add pr_warn_once on the read of
> kmem.limit_in_bytes as well.

How about this?
--- 
From 81ae0797d8da1b9cfbf357b4be4787a5bbf46bb4 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 21 Sep 2023 09:38:29 +0200
Subject: [PATCH] mm, memcg: reconsider kmem.limit_in_bytes deprecation

This reverts commits 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
and partially reverts 58056f77502f ("memcg, kmem: further deprecate
kmem.limit_in_bytes") which have incrementally removed support for the
kernel memory accounting hard limit. Unfortunately it has turned out
that there is still userspace depending on the existence of
memory.kmem.limit_in_bytes [1]. The underlying functionality is not
really required but the non-existent file just confuses the userspace
which fails in the result. The patch to fix this on the userspace side
has been submitted but it is hard to predict how it will propagate
through the maze of 3rd party consumers of the software.

Now, reverting alone 86327e8eb94c is not an option because there is
another set of userspace which cannot cope with ENOTSUPP returned when
writing to the file. Therefore we have to go and revisit 58056f77502f
as well. There are two ways to go ahead. Either we give up on the
deprecation and fully revert 58056f77502f as well or we can keep
kmem.limit_in_bytes but make the write a noop and warn about the fact.
This should work for both known breaking workloads which depend on the
existence but do not depend on the hard limit enforcement.

[1] http://lkml.kernel.org/r/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
Fixes: 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
Fixes: 58056f77502f ("memcg, kmem: further deprecate kmem.limit_in_bytes")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  7 +++++++
 mm/memcontrol.c                                | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 5f502bf68fbc..ff456871bf4b 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -92,6 +92,13 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
+ memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
+                                     memory hard limit. Kernel hard limit is not
+                                     supported since 5.16. Writing any value to
+                                     do file will not have any effect same as if
+                                     nokmem kernel parameter was specified.
+                                     Kernel memory is still charged and reported
+                                     by memory.kmem.usage_in_bytes.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a4d3282493b6..ac7f14b2338d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3097,6 +3097,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 				   unsigned int nr_pages)
 {
+	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	int ret;
 
@@ -3107,6 +3108,10 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 		goto out;
 
 	memcg_account_kmem(memcg, nr_pages);
+
+	/* There is no way to set up kmem hard limit so this operation cannot fail */
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		WARN_ON(!page_counter_try_charge(&memcg->kmem, nr_pages, &counter));
 out:
 	css_put(&memcg->css);
 
@@ -3867,6 +3872,13 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		case _MEMSWAP:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
+		case _KMEM:
+			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
+				     "Writing any value to this file has no effect. "
+				     "Please report your usecase to linux-mm@kvack.org if you "
+				     "depend on this functionality.\n");
+			ret = 0;
+			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
