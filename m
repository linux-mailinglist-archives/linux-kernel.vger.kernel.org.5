Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C139F80B1EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjLIDmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIDmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:42:31 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383010E6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 19:42:36 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a9b393f53so13175126d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 19:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1702093356; x=1702698156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVcVpotir+9SC/LAqnybKtsuMCoLAx3H5Z7j1TM2uo0=;
        b=fxF5vGjszmsVs5MtmsnyDgZjKZn/pCBm5XSdOXDzNdk4EIIdrX8qXNvR4vALQ0Ra6f
         UwUnUpBrivU/oWYkDdGKy5aHYp8Dn8x5CtTOe4dXA2z+NK/ffvjqRIVkWCAUTV3LG9r0
         6+p8Z7B0FVZHOV4iqLFe44/5bIsd3kLe1hnRKvgup1gguDm5JQt2ovijzqc9qqPyj+mQ
         5IJLArHppxL6GWq2zaIvMg+GcckujIj40lJw3Ae3F3X8LupMyKAj1aP8quyl4fYUNCPq
         vlNWRTYHWeGeA2MEVdC1UUc8ZRgSI069K43tnlfgzCn5LUZNY01ToihKrsLeQUKRx/nY
         l5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702093356; x=1702698156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVcVpotir+9SC/LAqnybKtsuMCoLAx3H5Z7j1TM2uo0=;
        b=DBwY+rVDO+CPP4B0l+HZ8o98Ju+jQzxbidpyGubWJqWbZ29GqU17lzJ3C3ZjqY2+4N
         mXBFjVYLl9g/wQD2yTZc41if6Ae9zyDeH9YPHASVlWYS2ekotrqC2uH6paX+1/O4zIRZ
         Q+ST2nHDlQoSbFjNRBtHNVLKvkjDEJMK1fXeVLA/lgV8ooa5gE87j+K9NF5V55NTP4F7
         89Lwb8n98CwAYhZnYR8XR1Sbad3wqUHHN9tkWUmMULiDlI4ZQYGwt5jgbHTTF2sWUNKy
         o0oIDsTJbNM0+nU9pwMtdYj4Kq94jF1CRuaT31u5cPypcPK97OcUEb2w3GqpzFdgvSLc
         n3Iw==
X-Gm-Message-State: AOJu0YzCRHrMF6Emn6Px6bNwZ2vAIlWYGyA0g5djCjCtUQlSJ23NZpHW
        MZ3xVO3Fs3cXmHwZwyY/NlDwFQ==
X-Google-Smtp-Source: AGHT+IFHVa7H9dXYIP02gQeFibjeRHvypv4nMxhcIPgsLSlpEep7cgigUlMQX/U2JeULB6y+GLpN5g==
X-Received: by 2002:a05:6214:4c1b:b0:67a:8874:fefb with SMTP id qh27-20020a0562144c1b00b0067a8874fefbmr765684qvb.29.1702093356024;
        Fri, 08 Dec 2023 19:42:36 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id z25-20020a0c8f19000000b0067a291f473esm1316083qvd.68.2023.12.08.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 19:42:35 -0800 (PST)
Date:   Fri, 8 Dec 2023 22:42:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Minchan Kim <minchan@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
Message-ID: <20231209034229.GA1001962@cmpxchg.org>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
 <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> I can give you three usage cases right now:
> 1) Google producting kernel uses SSD only swap, it is currently on
> pilot. This is not expressible by the memory.zswap.writeback. You can
> set the memory.zswap.max = 0 and memory.zswap.writeback = 1, then SSD
> backed swapfile. But the whole thing feels very clunky, especially
> what you really want is SSD only swap, you need to do all this zswap
> config dance. Google has an internal memory.swapfile feature
> implemented per cgroup swap file type by "zswap only", "real swap file
> only", "both", "none" (the exact keyword might be different). running
> in the production for almost 10 years. The need for more than zswap
> type of per cgroup control is really there.

We use regular swap on SSD without zswap just fine. Of course it's
expressible.

On dedicated systems, zswap is disabled in sysfs. On shared hosts
where it's determined based on which workload is scheduled, zswap is
generally enabled through sysfs, and individual cgroup access is
controlled via memory.zswap.max - which is what this knob is for.

This is analogous to enabling swap globally, and then opting
individual cgroups in and out with memory.swap.max.

So this usecase is very much already supported, and it's expressed in
a way that's pretty natural for how cgroups express access and lack of
access to certain resources.

I don't see how memory.swap.type or memory.swap.tiers would improve
this in any way. On the contrary, it would overlap and conflict with
existing controls to manage swap and zswap on a per-cgroup basis.

> 2) As indicated by this discussion, Tencent has a usage case for SSD
> and hard disk swap as overflow.
> https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.com/
> +Kairui

Multiple swap devices for round robin or with different priorities
aren't new, they have been supported for a very, very long time. So
far nobody has proposed to control the exact behavior on a per-cgroup
basis, and I didn't see anybody in this thread asking for it either.

So I don't see how this counts as an obvious and automatic usecase for
memory.swap.tiers.

> 3) Android has some fancy swap ideas led by those patches.
> https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kernel.org/
> It got shot down due to removal of frontswap. But the usage case and
> product requirement is there.
> +Minchan

This looks like an optimization for zram to bypass the block layer and
hook directly into the swap code. Correct me if I'm wrong, but this
doesn't appear to have anything to do with per-cgroup backend control.

> > zswap.writeback is a more urgent need, and does not prevent swap.tiers
> > if we do decide to implement it.
> 
> I respect that urgent need, that is why I Ack on the V5 path, under
> the understanding that this zswap.writeback is not carved into stones.
> When a better interface comes alone, that interface can be obsolete.
> Frankly speaking I would much prefer not introducing the cgroup API
> which will be obsolete soon.
> 
> If you think zswap.writeback is not removable when another better
> alternative is available, please voice it now.
> 
> If you squash my minimal memory.swap.tiers patch, it will also address
> your urgent need for merging the "zswap.writeback", no?

We can always deprecate ABI if something better comes along.

However, it's quite bold to claim that memory.swap.tiers is the best
way to implement backend control on a per-cgroup basis, and that it'll
definitely be needed in the future. You might see this as a foregone
conclusion, but I very much doubt this.

Even if such a file were to show up, I'm not convinced it should even
include zswap as one of the tiers. Zswap isn't a regular swap backend,
it doesn't show up in /proc/swaps, it can't be a second tier, the way
it interacts with its backend file is very different than how two
swapfiles of different priorities interact with each other, it's
already controllable with memory.zswap.max, etc.

I'm open to discussing usecases and proposals for more fine-grained
per-cgroup backend control. We've had discussions about per-cgroup
swapfiles in the past. Cgroup parameters for swapon are another
thought. There are several options and many considerations. The
memory.swap.tiers idea is the newest, has probably had the least
amount of discussion among them, and looks the least convincing to me.

Let's work out the requirements first.

The "conflict" with memory.zswap.writeback is a red herring - it's no
more of a conflict than setting memory.swap.tiers to "zswap" or "all"
and then setting memory.zswap.max or memory.swap.max to 0.

So the notion that we have to rush in a minimal version of a MUCH
bigger concept, just to support zswap writeback disabling is
misguided. And then hope that this format works as the concept evolves
and real usecases materialize... There is no reason to take that risk.
