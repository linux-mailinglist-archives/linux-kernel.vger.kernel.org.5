Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CC803F11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjLDUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:12:57 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25CCE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:13:04 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so19263241fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720782; x=1702325582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG2n1RagWpJyioFCtKEQGNRIi6T2whr4+NS0jQsnqJc=;
        b=LbmNSRC3pKCuJDLGJ1XvjqON7WRsUw/WxQRwsRCTFTX1GU5HHIbhEtKUzW2OkIcdEc
         Vxu/WtcT2oScSIl9cqfTNSh+kZUnp03wTRnt4SgViF+Brzt9B4BNnOjGiG4kEdq+BOuy
         NyXq93+m7svRiRSsKoxHPSDSMk4cixiZ2woezxPVJ1MJUpOjk2JibFK8m3my77OKqMHx
         WlG0DgNhKabuhcANCuQPY0EM3gFotMWyGXVwUIntsGYLsMVdbMw2zy9e/cFQVVtPoQTt
         PRbq0GyX8YQMEHoX5YQ6mzdWBcGFere4JC2/j3saUGZUUbeb4jfJ9THN+PKR46lcfFF5
         QB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720782; x=1702325582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG2n1RagWpJyioFCtKEQGNRIi6T2whr4+NS0jQsnqJc=;
        b=bEr9owkNgjn5Ezgk70Aa6C51+jRunsiBLTfVX+Ze7KKTGzBdoTi0lzLF4uOEa8zPLR
         vPLZS8GB2ztfN/VksnY+2VeUX4WSsqmhgKOPdiCsP+yH8jFVPVfR95cdGre06Rye5Oq0
         TOzCNmvEEE10CCYsawRwCuYCVKGCah8SRJg0sfhNBVzRku9MQ0y/TAZnnSfswyV+SNAv
         d3O30aTNow0hRizCl4mmWZJVGxHaaZY+7pkcOTBLWxliGybpGS7s8hSCmQW5wubb20Pd
         wsY4EUetBfMa2Ac6AeS8qkQHh5VdUykwcz8/bXzeLzEgqfna4NdpARASvLgW5wXh7P7Z
         A43A==
X-Gm-Message-State: AOJu0YzpBQaxlGHvzgOsrq0ORI2Tsyv2ox0Y3oCnwvrDiyn0dLU5LCVW
        8fZOg8Ay7Eh09ncLYd9Lx8djfVrR+Vjzel1AFDe7Sw==
X-Google-Smtp-Source: AGHT+IEAqW8tj2cjKzLL1LEqxk6D1GCavzEx5M1oQoWziuX/KyNNqhq2NyR/1wV/bzk3AHA7UVHZ98keWs1mbybvl0w=
X-Received: by 2002:a2e:9a87:0:b0:2c9:efa3:e1e8 with SMTP id
 p7-20020a2e9a87000000b002c9efa3e1e8mr1610758lji.33.1701720782130; Mon, 04 Dec
 2023 12:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
In-Reply-To: <20231202083129.3pmds2cddy765szr@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 4 Dec 2023 12:12:25 -0800
Message-ID: <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> [...]
> > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >  {
> > -     if (memcg_should_flush_stats(root_mem_cgroup))
> > -             do_flush_stats();
> > +     static DEFINE_MUTEX(memcg_stats_flush_mutex);
> > +
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> > +     if (!memcg)
> > +             memcg =3D root_mem_cgroup;
> > +
> > +     if (memcg_should_flush_stats(memcg)) {
> > +             mutex_lock(&memcg_stats_flush_mutex);
>
> What's the point of this mutex now? What is it providing? I understand
> we can not try_lock here due to targeted flushing. Why not just let the
> global rstat serialize the flushes? Actually this mutex can cause
> latency hiccups as the mutex owner can get resched during flush and then
> no one can flush for a potentially long time.

I was hoping this was clear from the commit message and code comments,
but apparently I was wrong, sorry. Let me give more context.

In previous versions and/or series, the mutex was only used with
flushes from userspace to guard in-kernel flushers against high
contention from userspace. Later on, I kept the mutex for all memcg
flushers for the following reasons:

(a) Allow waiters to sleep:
Unlike other flushers, the memcg flushing path can see a lot of
concurrency. The mutex avoids having a lot of CPUs spinning (e.g.
concurrent reclaimers) by allowing waiters to sleep.

(b) Check the threshold under lock but before calling cgroup_rstat_flush():
The calls to cgroup_rstat_flush() are not very cheap even if there's
nothing to flush, as we still need to iterate all CPUs. If flushers
contend directly on the rstat lock, overlapping flushes will
unnecessarily do the percpu iteration once they hold the lock. With
the mutex, they will check the threshold again once they hold the
mutex.

(c) Protect non-memcg flushers from contention from memcg flushers.
This is not as strong of an argument as protecting in-kernel flushers
from userspace flushers.

There has been discussions before about changing the rstat lock itself
to be a mutex, which would resolve (a), but there are concerns about
priority inversions if a low priority task holds the mutex and gets
preempted, as well as the amount of time the rstat lock holder keeps
the lock for:
https://lore.kernel.org/lkml/ZO48h7c9qwQxEPPA@slm.duckdns.org/

I agree about possible hiccups due to the inner lock being dropped
while the mutex is held. Running a synthetic test with high
concurrency between reclaimers (in-kernel flushers) and stats readers
show no material performance difference with or without the mutex.
Maybe things cancel out, or don't really matter in practice.

I would prefer to keep the current code as I think (a) and (b) could
cause problems in the future, and the current form of the code (with
the mutex) has already seen mileage with production workloads.
