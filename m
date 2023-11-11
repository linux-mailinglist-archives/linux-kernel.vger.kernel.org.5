Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EC27E8A83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKKLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjKKLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:16:40 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBD4220;
        Sat, 11 Nov 2023 03:16:37 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c398717726so2644815b3a.2;
        Sat, 11 Nov 2023 03:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699701397; x=1700306197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdIfWloVBdEvW1NG4WAbQaqnvny2qdQuJ9vc8aGDWBo=;
        b=dGozbbaPlFve3vgfcrPVjdbXq4p+EqSS6kusBwHWvEdsZZPK1smJle8K3ZnWMTmipT
         oHQzC4EH5/0HJ8vRcvbC27xann6gn5AW9p8ZYRRMV/XLSa30BhXe6P1WcU/jCzt6c5Hj
         LrLH3OOBl7/g5+zZ5N317FXsVB9fVe4TKRn/rScY8q68pmv0VgM21IhrghQZT5rZzvsp
         1VAaDi+SFGAJX4M0ANOakp5NhBOWyiq95xrmYv0tDx+YfCQz4gKU+dL4cdJDHg2TaTW3
         ks6x0DZBfvUYUSzVEaNs9kL3yb5Do+6Qcxi0uJv1bcPv6Nbrgb3tTOu6YSzA/uDvud17
         fcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699701397; x=1700306197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdIfWloVBdEvW1NG4WAbQaqnvny2qdQuJ9vc8aGDWBo=;
        b=bc405eSjeEyooicChiy3r1rSaGsR6pJeLQPfDRMbaXpky/40O8NK9hezfu0g2VdHq/
         ZWFLjLUWwHKFMKl+BVt9xhnuetqelKVf/5wO/OjUTdcicVX+GHL8OAbu5eEJSjUVXDWC
         /3dZRwuluH5EQxrEsvVpHI61O96FFMQaxIX2sBze0sEEqhS99fFhmG9sjMFce+vdZ0CH
         9x65h/0td81sCmNC733D0ZX0mYScEoA/ktJH4p4Bg1AXfF7lOaO6IWH84ipbDJrLzAHf
         u5Ez+2fvplo6AAjPjB3bW7CRCwHuj57wMR2+rKA2rzTiWDv/SwGt1sURMEsFecXmy6e4
         yNEQ==
X-Gm-Message-State: AOJu0Yy1GZrPq7er8lhcPObb1YJXZ7bvJF8a7GYfgGxG6lRvVodg1tZ2
        yE+9/Tpi0YKAdTZpYw8CSIo=
X-Google-Smtp-Source: AGHT+IFh0XZy7zvKvjhxAfnYkqMCzQjdz2EV+ZIVZqjc4fhAaCnvWFjh+X55ab/JLv0N3aWRuDXNKA==
X-Received: by 2002:a05:6a00:10c1:b0:690:c75e:25c8 with SMTP id d1-20020a056a0010c100b00690c75e25c8mr1361316pfu.7.1699701396667;
        Sat, 11 Nov 2023 03:16:36 -0800 (PST)
Received: from localhost ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b006870ed427b2sm1140235pfd.94.2023.11.11.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 03:16:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 11 Nov 2023 01:16:29 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     John Groves <john@jagalactic.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU9ijZHZZjRgUctq@mtj.duckdns.org>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU74L9oxWOoTTfpM@memverge.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 10, 2023 at 10:42:39PM -0500, Gregory Price wrote:
> On Fri, Nov 10, 2023 at 05:05:50PM -1000, tj@kernel.org wrote:
...
> I've been considering this as well, but there's more context here being
> lost.  It's not just about being able to toggle the policy of a single
> task, or related tasks, but actually in support of a more global data
> interleaving strategy that makes use of bandwidth more effectively as
> we begin to memory expansion and bandwidth expansion occur on the
> PCIE/CXL bus.
> 
> If the memory landscape of a system changes, for example due to a
> hotplug event, you actually want to change the behavior of *every* task
> that is using interleaving.  The fundamental bandwidth distribution of
> the entire system changed, so the behavior of every task using that
> memory should change with it.
> 
> We've explored adding weights to: mempolicy, memory tiers, nodes, memcg,
> and now additionally cpusets. In the last email, I'd asked whether it
> might actually be worth adding a new mpol component of cgroups to
> aggregate these issues, rather than jam them into either component.
> I would love your thoughts on that.

As for CXL and the changing memory landscape, I think some caution is
necessary as with any expected "future" technology changes. The recent
example with non-volatile memory isn't too far from CXL either. Note that
this is not to say that we shouldn't change anything until the hardware is
wildly popular but more that we need to be cognizant of the speculative
nature and the possibility of overbuilding for it.

I don't have a golden answer but here are general suggestions: Build
something which is small and/or useful even outside the context of the
expected hardware landscape changes. Enable the core feature which is
absolutely required in a minimal manner. Avoid being maximalist in feature
and convenience coverage.

Here, even if CXL actually becomes popular, how many are going to use memory
hotplug and need to dynamically rebalance memory in actively running
workloads? What's the scenario? Are there going to be an army of data center
technicians going around plugging and unplugging CXL devices depending on
system memory usage?

Maybe there are some cases this is actually useful but for those niche use
cases, isn't per-task interface with iteration enough? How often are these
hotplug events going to be?

> > > So one concrete use case: kubernetes might like change cpusets or move
> > > tasks from one cgroup to another, or a vm might be migrated from one set
> > > of nodes to enother (technically not mutually exclusive here).  Some
> > > memory policy settings (like weights) may no longer apply when this
> > > happens, so it would be preferable to have a way to change them.
> > 
> > Neither covers all use cases. As you noted in your mempolicy message, if the
> > application wants finer grained control, cgroup interface isn't great. In
> > general, any changes which are dynamically initiated by the application
> > itself isn't a great fit for cgroup.
> 
> It is certainly simple enough to add weights to mempolicy, but there
> are limitations.  In particular, mempolicy is extremely `current task`
> focused, and significant refactor work would need to be done to allow
> external tasks the ability to toggle a target task's mempolicy.
> 
> In particular I worry about the potential concurrency issues since
> mempolicy can be in the hot allocation path.

Changing mpol from outside the task is a feature which is inherently useful
regardless of CXL and I don't quite understand why hot path concurrency
issues would be different whether the configuration is coming from mempol or
cgroup but that could easily be me not being familiar with the involved
code.

...
> > 3. Cgroup can be convenient when group config change is necessary. However,
> >    we really don't want to keep adding kernel interface just for changing
> >    configs for a group of threads. For config changes which aren't high
> >    frequency, userspace iterating the member processes and applying the
> >    changes if possible is usually good enough which usually involves looping
> >    until no new process is found. If the looping is problematic, cgroup
> >    freezer can be used to atomically stop all member threads to provide
> >    atomicity too.
> > 
> 
> If I can ask, do you think it would be out of line to propose a major
> refactor to mempolicy to enable external task's the ability to change a
> running task's mempolicy *as well as* a cgroup-wide mempolicy component?

I don't think these group configurations fit cgroup filesystem interface
very well. As these aren't resource allocations, it's unclear what the
hierarchical relationship means. Besides, it feels awkard to be keep adding
duplicate interfaces where the modality changes completely based on the
operation scope.

There are ample examples where other subsystems use cgroup membership
information and while we haven't expanded that to syscalls yet, I don't see
why that'd be all that difference. So, maybe it'd make sense to have the new
mempolicy syscall take a cgroup ID as a target identifier too? ie. so that
the scope of the operation (e.g. task, process, cgroup) and the content of
the policy can stay orthogonal?

Thanks.

-- 
tejun
