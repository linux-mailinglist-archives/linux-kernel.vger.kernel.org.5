Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35E806978
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbjLFIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377221AbjLFIQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:16:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE310F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:16:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28647f4ebd9so4423329a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701850568; x=1702455368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVirJMyPevVIgzIpiwvmS8AQpGiAuX4zW9DZNPcO3bw=;
        b=wAf17vlbCWUDHkHwv3CWbrZbKxLvzalr0UVnG6+Ryf77CWXeZrUGbg1684tlI06Njn
         QKcvt1/u5/FauZ4gUaTPH0jEiO4Z88QcADNaDOBWaLGPZREk6cM7KCZ3hfLkSQSLQC4Q
         sU71M9KbIIvZdYCWgrmSXlK3i2gF+gftPII2fU1b6v3Yzg4PC/3AQ1VFmvVjwZW9veQ5
         KCx26J13a9Fq6JTj3il0H5yzTZ4sTYKRNzjfCCO+6GcrdxkmxD6/XwvH31kkPwupcIph
         0nUrtNGRBtDHTHQJUImaUf7/Yq5L0RwCgb4RjPOyF6f0WdF1AswplXvHSFAgo1HCz+uP
         VEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850568; x=1702455368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVirJMyPevVIgzIpiwvmS8AQpGiAuX4zW9DZNPcO3bw=;
        b=SXa9TVOU2FGn/zO2ug+F1Ws/Q1aryZMtd9lykGO37Zq+aCADNaWNPZJZP/B+Q1vIEF
         gfm53BmwTVNyUTQDRedxuk22vFVmb5undwibrNm5n78pNC6UE3w3cI6IGXw6pKImBBR5
         zr1D4nSm/BvtgPf4Z/rnbBubtttTihkk+u0v1GutMQ7Yl6fbxzLW52mTPBv/4xeyRg12
         NFoVuVZRaQR8Mq8mEskJVe+jcJlLTd+5zoS4f9pB6c8rMYNiItyHLC/zMFOAtIcIeTab
         voub78RRnky4E2Qh5fQUNcYkBXcxhquqAYNPcJMaNN2TBQ4l/99/L8+L2pWzStAdj2h3
         jpgw==
X-Gm-Message-State: AOJu0Yy+iO+2vfbPfaLmroUp7Gg/ABr4pmI4RykE48/ysslVSvXjcxg+
        mq/P16kgoPvp5NOFMATfI8ZiVA==
X-Google-Smtp-Source: AGHT+IFSfT6V9PieGVxLQ0jzN0gmpf040pMnGvleNScmRHV5uFBPZW+tOcTFxYmRoUAPPO9G/z8W1w==
X-Received: by 2002:a17:90b:30cb:b0:286:c398:841b with SMTP id hi11-20020a17090b30cb00b00286c398841bmr391653pjb.58.1701850568162;
        Wed, 06 Dec 2023 00:16:08 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id hg6-20020a17090b300600b00286ead49257sm1993982pjb.21.2023.12.06.00.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:16:07 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rAn4e-004XpP-2g;
        Wed, 06 Dec 2023 19:16:04 +1100
Date:   Wed, 6 Dec 2023 19:16:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZXAtxBKZmKhFxwYB@dread.disaster.area>
References: <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
 <ZWk0dI0PISWBbbKr@dread.disaster.area>
 <ZWo7ncdgPsj6rP7_@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWo7ncdgPsj6rP7_@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:01:33PM -0800, Roman Gushchin wrote:
> On Fri, Dec 01, 2023 at 12:18:44PM +1100, Dave Chinner wrote:
> > On Thu, Nov 30, 2023 at 11:01:23AM -0800, Roman Gushchin wrote:
> > > On Wed, Nov 29, 2023 at 10:21:49PM -0500, Kent Overstreet wrote:
> > > > On Thu, Nov 30, 2023 at 11:09:42AM +0800, Qi Zheng wrote:
> > > > > For non-bcachefs developers, who knows what those statistics mean?
> > 
> > > Ok, a simple question then:
> > > why can't you dump /proc/slabinfo after the OOM?
> > 
> > Taken to it's logical conclusion, we arrive at:
> > 
> > 	OOM-kill doesn't need to output anything at all except for
> > 	what it killed because we can dump
> > 	/proc/{mem,zone,vmalloc,buddy,slab}info after the OOM....
> > 
> > As it is, even asking such a question shows that you haven't looked
> > at the OOM kill output for a long time - it already reports the slab
> > cache usage information for caches that are reclaimable.
> > 
> > That is, if too much accounted slab cache based memory consumption
> > is detected at OOM-kill, it will calldump_unreclaimable_slab() to
> > dump all the SLAB_RECLAIM_ACCOUNT caches (i.e. those with shrinkers)
> > to the console as part of the OOM-kill output.
> 
> You are right, I missed that, partially because most of OOM's I had to deal
> with recently were memcg OOM's.
> 
> This changes my perspective at Kent's patches, if we dump this information
> already, it might be not a bad idea to do it nicer. So I take my words back
> here.
> 
> > 
> > The problem Kent is trying to address is that this output *isn't
> > sufficient to debug shrinker based memory reclaim issues*. It hasn't
> > been for a long time, and so we've all got our own special debug
> > patches and methods for checking that shrinkers are doing what they
> > are supposed to. Kent is trying to formalise one of the more useful
> > general methods for exposing that internal information when OOM
> > occurs...
> > 
> > Indeed, I can think of several uses for a shrinker->to_text() output
> > that we simply cannot do right now.
> > 
> > Any shrinker that does garbage collection on something that is not a
> > pure slab cache (e.g. xfs buffer cache, xfs inode gc subsystem,
> > graphics memory allocators, binder, etc) has no visibility of the
> > actuall memory being used by the subsystem in the OOM-kill output.
> > This information isn't in /proc/slabinfo, it's not accounted by a
> > SLAB_RECLAIM_ACCOUNT cache, and it's not accounted by anything in
> > the core mm statistics.
> > 
> > e.g. How does anyone other than a XFS expert know that the 500k of
> > active xfs_buf handles in the slab cache actually pins 15GB of
> > cached metadata allocated directly from the page allocator, not just
> > the 150MB of slab cache the handles take up?
> > 
> > Another example is that an inode can pin lots of heap memory (e.g.
> > for in-memory extent lists) and that may not be freeable until the
> > inode is reclaimed. So while the slab cache might not be excesively
> > large, we might have an a million inodes with a billion cumulative
> > extents cached in memory and it is the heap memory consumed by the
> > cached extents that is consuming the 30GB of "missing" kernel memory
> > that is causing OOM-kills to occur.
> > 
> > How is a user or developer supposed to know when one of these
> > situations has occurred given the current lack of memory usage
> > introspection into subsystems?
> 
> What would be the proper solution to this problem from your point of view?
> What functionality/API mm can provide to make the life of fs developers
> better here?

What can we do better?

The first thing we can do better that comes to mind is to merge
Kent's patches that allow the shrinker owner to output debug
information when requested by the infrastructure.

Then we - the shrinker implementers - have some control of our own
destiny.  We can add whatever we need to solve shrinker and OOM
problems realted to our shrinkers not doing the right thing.

But without that callout from the infrastructure and the
infrastructure to drive it at appropriate times, we will make zero
progress improving the situation. 

Yes, the code may not be perfect and, yes, it may not be useful to
mm developers, but for the people who have to debug shrinker related
problems in production systems we need all the help we can get. We
certainly don't care if it isn't perfect, just having something we
can partially tailor to our iindividual needs is far, far better
than the current situation of nothing at all...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
