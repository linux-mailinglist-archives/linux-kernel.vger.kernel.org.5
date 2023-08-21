Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A73C782315
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjHUFR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHUFR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:17:58 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A425A6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:17:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a751d2e6ecso2302002b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1692595076; x=1693199876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVPFeVwGL8kP97WkDZ9WBoD6Na/u2oCcPIlsc2AFaUc=;
        b=VV0RPIxB5zDYAG/m0z51lWJ8XTOXDuhqGb5oy9EuIelkhJdU4qAetIlGJHhcXbYUfH
         c/Qyuw8bikofrkW0tVXacc7Q8GJpG6emZtgmMU5khzsDOX3INnUkQVAqeqwmLZu6T93d
         8BF6L9yFrX3j5z2pxDlCEKHzPuLwTBx6j5O9eoqqXSPH+U+Jo2Y6BGvyYyQsm3jNIOFq
         BDf7A6wASDzhKK+s+QcB57hA/j/CUA5+ubuae0EHnx2Ippr/n3AvVvsOmMidPdP+OKL6
         bEFqZhvF0kwN/hXqaTAIjYG6VZgVST6thQDZeq9feKsiE3d9Y6ZYF86aHa34qFR8W5U4
         YHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692595076; x=1693199876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVPFeVwGL8kP97WkDZ9WBoD6Na/u2oCcPIlsc2AFaUc=;
        b=eaQx6WyvE97+TGIBuCM8yndGqoMHO8GrPj6ogzWtukCrEDMrSenEC74NAHApP2mw9Y
         +WjAohH4OLdGhYwBgYw2NbNYTvgJfIwO/yRh+iSglLhmeDhlOBjzru6dVuqwUS9ilzy3
         gMK3BNvtMI1djUXGfkSH8dT2EMgxJxBHsAlVtwdQAql09hzN105cX3XaZFOvX9WNOj2o
         bAh+vQeNJhctTBN/dQGtaS9OFQUlsJ1EnxZPRGJHaybawYi4S5ZXSgZZfIXdot1wjBFb
         PSAEuQJzpD/bYinPZi8zsX9fe0eZxBYYf0EmtLY93qKQU+10fFd3M+s9CP3rsEXq50P9
         bCEQ==
X-Gm-Message-State: AOJu0YyWOnyPq1y4X+5xa+zv6/+/CvqzpqRGk1CONY4RA4jHjB7RXo3S
        TSZBjUBWc7F6zZ8+W6YogOI2xnA7JktFCvA8rCE=
X-Google-Smtp-Source: AGHT+IF2XjOgsLrZeQVWU/wJsvi/ZqJyXhxvOiJgQon66xT0p0eKU1gXE4hD4zzROmCzxETerwGVXQ==
X-Received: by 2002:aca:2419:0:b0:3a3:6450:f5c4 with SMTP id n25-20020aca2419000000b003a36450f5c4mr7536481oic.4.1692595076353;
        Sun, 20 Aug 2023 22:17:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id j3-20020a62e903000000b006879493aca0sm5233715pfh.26.2023.08.20.22.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 22:17:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qXxIW-004RoY-2P;
        Mon, 21 Aug 2023 15:17:52 +1000
Date:   Mon, 21 Aug 2023 15:17:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] xfs: fix per-cpu CIL structure aggregation racing
 with dying cpus
Message-ID: <ZOLzgBOuyWHapOyZ@dread.disaster.area>
References: <20230804223854.GL11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804223854.GL11352@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:38:54PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In commit 7c8ade2121200 ("xfs: implement percpu cil space used
> calculation"), the XFS committed (log) item list code was converted to
> use per-cpu lists and space tracking to reduce cpu contention when
> multiple threads are modifying different parts of the filesystem and
> hence end up contending on the log structures during transaction commit.
> Each CPU tracks its own commit items and space usage, and these do not
> have to be merged into the main CIL until either someone wants to push
> the CIL items, or we run over a soft threshold and switch to slower (but
> more accurate) accounting with atomics.
> 
> Unfortunately, the for_each_cpu iteration suffers from the same race
> with cpu dying problem that was identified in commit 8b57b11cca88f
> ("pcpcntrs: fix dying cpu summation race") -- CPUs are removed from
> cpu_online_mask before the CPUHP_XFS_DEAD callback gets called.  As a
> result, both CIL percpu structure aggregation functions fail to collect
> the items and accounted space usage at the correct point in time.
> 
> If we're lucky, the items that are collected from the online cpus exceed
> the space given to those cpus, and the log immediately shuts down in
> xlog_cil_insert_items due to the (apparent) log reservation overrun.
> This happens periodically with generic/650, which exercises cpu hotplug
> vs. the filesystem code.
> 
> Applying the same sort of fix from 8b57b11cca88f to the CIL code seems
> to make the generic/650 problem go away, but I've been told that tglx
> was not happy when he saw:
> 
> "...the only thing we actually need to care about is that
> percpu_counter_sum() iterates dying CPUs. That's trivial to do, and when
> there are no CPUs dying, it has no addition overhead except for a
> cpumask_or() operation."
> 
> I have no idea what the /correct/ solution is, but I've been holding on
> to this patch for 3 months.  In that time, 8b57b11cca88 hasn't been
> reverted and cpu_dying_mask hasn't been removed, so I'm sending this and
> we'll see what happens.
> 
> So, how /do/ we perform periodic aggregation of per-cpu data safely?
> Move the xlog_cil_pcp_dead call to the dying section, where at least the
> other cpus will all be stopped?  And have it dump its items into any
> online cpu's data structure?

I suspect that we have to stop using for_each_*cpu() and hotplug
notifiers altogether for this code.

That is, we simply create our own bitmap for nr_possible_cpus in the
CIL checkpoint context we allocate for each checkpoint (i.e. the
struct xfs_cil_ctx). When we store something on that CPU for that
CIL context, we set the corresponding bit for that CPU. Then when we
are aggregating the checkpoint, we simply walk all the cpus with the
"has items" bit set and grab everything.

This gets rid of the need for hotplug notifiers completely - we just
don't care if the CPU is online or offline when we sweep the CIL
context for items at push time - if the bit is set then there's
stuff to sweep...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
