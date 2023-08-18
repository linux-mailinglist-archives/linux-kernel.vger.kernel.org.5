Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A77814DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbjHRVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbjHRVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:41:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32394221
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:41:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so280455566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692394865; x=1692999665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96IMmmZrA7+LOMjVXBt5LauO5hLl+h8Byr56SGNcD5E=;
        b=2vmiGzAaxTuFV5Ofe5033kpMJWLm6PdVg2qNpIk+6jYWxfhiaEbxUok4/NlLRjUxDa
         mCV4TPsBq0kR83ozlatZ+5TYbBW8GKKH6dfpG3xy+L1j6kMebghjrqinobcuW1QcavWY
         EBJWRePyFYqJ/btGMh4YPjAhg6r11mjYJql/G7vN0GzGPWFUGeerLQWeQTC/ihdOcD2k
         m48lAzpSIvKJIFrunAnsFFLobDbzVUzXhi+xw2WjiZ6OERcm1TlFvgDBt4xjIg0wv8y7
         jDBXZGOWFn74eOriV+eLLCuExyAcSa44V2CJXgNdVPlhYd2DkQiJRYW31vuygJTT/hrI
         Xd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692394865; x=1692999665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96IMmmZrA7+LOMjVXBt5LauO5hLl+h8Byr56SGNcD5E=;
        b=FFkLwCgL79KRxK04CVE6N7jO0eGaYGe7iVb18SeMdO4vM6tDoM40qRkGNXfWKZnUw3
         3omY7XAHcttI5YFdjQwaEP3VRy928g/9eiFCSUW8ghojcLeHV2ERpk4IjwmOaiu4UC4K
         CU65qu0vjUf4/vG9JQMoe/9Fk7NbgaY19clpF2a8tQeFmb4yBPm4t1ukN/sv2AmzJqZF
         KNueayhUviM4Jz0N9FqB8H+LjoJiPeytdot5YfdCTZ1XzBLO2YABBY0oySiepXL7FEat
         +FYeePTrGYhDI8/D3tLyuvmfvM6fi9CeH35ApvyOEWsVt7Khqh8dhk1R8/BQI4t8eL0y
         WY4A==
X-Gm-Message-State: AOJu0YztMOYmaEmvWMBA8UAEGnuRFQ8ujU3PXWALKqHzJyNj4qcB7sIL
        58qUKEg1zSYt/wm/RaIPElzr1Au87/up2ewFTt9BDQ==
X-Google-Smtp-Source: AGHT+IEbozZG7SJ/ux7vw/uhn7UBpHEKdLMEh5J08FskeFyaNq3qmqbcHtEsAIkM+gOZDaD9Zlhvckuf9YHtPndgL90=
X-Received: by 2002:a17:906:300c:b0:99d:f1d7:d007 with SMTP id
 12-20020a170906300c00b0099df1d7d007mr413701ejz.24.1692394865022; Fri, 18 Aug
 2023 14:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org> <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
 <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
 <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
 <CALvZod6HUtYhDaXiwXSrcwfxLSrZ37sZhKY1Mg4kmpDFk13aYw@mail.gmail.com>
 <CAJD7tkYzr2cg-aQ899vfqB4jR7iP83t8f-Z4AH8d9iW-yw-nnQ@mail.gmail.com>
 <CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com>
 <ZN0eqq4hLRYQPHCI@slm.duckdns.org> <CAJD7tkYSk-73c1=5vmuRdykAQO=pJSkQFgRqkpdfnh7f-Zufkw@mail.gmail.com>
In-Reply-To: <CAJD7tkYSk-73c1=5vmuRdykAQO=pJSkQFgRqkpdfnh7f-Zufkw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 18 Aug 2023 14:40:28 -0700
Message-ID: <CAJD7tkYGeYzQ=zVm_Ewgqfc4u1udSvjThLxOrghmMHO=rqvaDA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 3:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Aug 16, 2023 at 12:08=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Aug 16, 2023 at 10:11:20AM -0700, Shakeel Butt wrote:
> > > These options are not white and black and there can be something in
> > > between but let me be very clear on what I don't want and would NACK.
> >
> > I'm not a big fan of interfaces with hidden states. What you're proposi=
ng
> > isn't strictly that but it's still a bit nasty. So, if we can get by wi=
thout
> > doing that, that'd be great.
>
> Agreed. I will try to send patches soon implementing option (2) above,
> basically removing unified flushing. I will try to document any
> potential regressions that may happen and how we may fix them. Ideally
> we see no regressions.
>
> >
> > > I don't want a global sleepable lock which can be taken by potentiall=
y
> > > any application running on the system. We have seen similar global
> > > locks causing isolation and priority inversion issues in production.
> > > So, not another lock which needs to be taken under extreme condition
> > > (reading stats under OOM) by a high priority task (node controller)
> > > and might be held by a low priority task.
> >
> > Yeah, this is a real concern. Those priority inversions do occur and ca=
n be
> > serious but causing serious problems under memory pressure usually requ=
ires
> > involving memory allocations and IOs. Here, it's just all CPU. So, at l=
east
> > in OOM conditions, this shouldn't be in the way (the system wouldn't ha=
ve
> > anything else to do anyway).
> >
> > It is true that this still can lead to priority through CPU competition=
 tho.
> > However, that problem isn't necessarily solved by what you're suggestin=
g
> > either unless you want to restrict explicit flushing based on permissio=
ns
> > which is another can of worms.
>
> Right. Also in the case of a mutex, if we disable preemption while
> holding the mutex, this makes sure that whoever holding the mutex does
> not starve waiters. Essentially the difference would be that waiters
> will sleep with the mutex instead of spinning, but the mutex holder
> itself wouldn't sleep.
>
> I will make this a separate patch, just in case it's too
> controversial. Switching the spinlock to a mutex should not block
> removing unified flushing.
>
> >
> > My preference is not exposing this in user interface. This is mostly ar=
ising
> > from internal implementation details and isn't what users necessarily c=
are
> > about. There are many things we can do on the kernel side to make trade=
-offs
> > among overhead, staleness and priority inversions. If we make this an
> > explicit userland interface behavior, we get locked into that semantics
> > which we'll likely regret in some future.
> >
>
> Yeah that's what I am trying to do here as well.  I will try to follow
> up on this discussion with patches soon.
>
> Thanks everyone!

So status update. I tried implementing removing unified flushing. I
can send the patches if it helps visualize things, but essentially
mem_cgroup_flush_stats{_ratelimited} takes a memcg argument that it
passes to cgroup_flush_stats(). No skipping if someone else is
flushing (stats_flush_ongoing) and no threshold at which we start
flushing (stats_flush_threshold).

I tested this by some synthetic reclaim stress test that I wrote,
because reclaim is the easiest way to stress in-kernel flushing. I
basically create 10s or 100s cgroups and run workers in them that keep
allocating memory beyond the limit. I also run workers that
periodically read the stats.

Removing unified flushing makes such a synthetic benchmark 2-3 times
slower. This is not surprising, as all these concurrent reclaimers
used to just skip flushing, regardless of whether or not they get
accurate stats. Now I don't know how realistic such a benchmark is,
but if there's a workload somewhere that runs into such conditions it
will surely regress.

Sorry if the above is difficult to visualize. I can send the patches
and the test script if it makes things easier, I just didn't want to
overwhelm the thread.

I think there are 2 options going forward:
(a) If we believe removing unified flushing is the best way forward
for most use cases, then we need to find a better way of testing this
approach practically. Any suggestions here are useful.

(b) Decide that it's too expensive to remove unified flushing
completely, at least for in-kernel flushers that can see a lot of
concurrency. We can only remove unified flushing for userspace reads.
Only flush the memcg being read and never skip (essentially what Ivan
tried). There are already some flushing contexts that do this (e.g.
zswap memcg charging code). I believe as long as there isn't a lot of
concurrency in these paths it should be fine to skip unified flushing
for them, and keep it only for in-kernel flushers.

Any thoughts on this?
