Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61208787842
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbjHXSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbjHXSvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:51:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1231BCD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:51:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99cdb0fd093so10757166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692903088; x=1693507888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIntCscqhDfEHiFTt/nLdYcoh0FY54rWEh/TsH/OwaQ=;
        b=YTj/bsBvUZUTjYN49dDIHhjUbcqUZnmwFrUEPy7wBE1yP8CClRJZcB2EqH8BTQ9L1p
         9rfVxKZVqXDZQGgj5YVz4GBx700Sa82keEh+vFvHbV2cDP51G+M+h52AeHFmD3rhQT/S
         KAjaYgd0InsPnpsp6p4u+LcvCftNLUwhzZ+GmDpg07XyqQf+hQVd/5t4uAHmpkqoqyIx
         vmLOEMUE89WpXkh3oTDnsYgyIlxzeAz8grVxGy6Iux4RvAMQlX6In2y406zdh46ESotF
         J2SvKFOD1STNKGBtkA7auuwY6QebYfK0veMj/+Eb8DraUFnVMB4WLcrBRvcODMDC0zcu
         v8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903088; x=1693507888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIntCscqhDfEHiFTt/nLdYcoh0FY54rWEh/TsH/OwaQ=;
        b=U416mGJmcCD8Ke3C//8RAQz28dKXx993OCyBWwKg8u/tGsMcz5BEISCih+15+HlgNS
         A/qiO28+H09KVboFF1lzo9s3fw8GTXx1g9pdEFNj4Z3KipXM5+31cBPMkcI5N/MITUeg
         bM6FbSz/brzmvUUmMWbJg2ku67Afr7lC4NO2455G+sADCThx+vjD13P/cJ8NZ56rpU7V
         pG9N4kPFaOC2aqCbyy1ElzyWGt38/qrmGgFI2QvrPsecHDMlt/tyvLCSCgrn4BBV5dRj
         8EPK6U0eFuOYp6VIAB1ZURoTDi3GIeboRDjnWOJjK3sKKpYXoIoebeirulbdrcTKXGsb
         HTWw==
X-Gm-Message-State: AOJu0YwQZMcTEQVj3wq4ILfcR+4uNEryK/82XdaiZ8iy2lA8HMmb6wjU
        s59G9w5nuPZ5vJ9fSk4ajsu6OY1pwswHPRoa0AkoEg==
X-Google-Smtp-Source: AGHT+IF+IFNG4EAVUrKQsHTGpc++b97oZVHRYbXxJwtABfkADfSJsBlQZ57k7Xe37dAiSU1MfBG0ZsgWcdHrULKljiE=
X-Received: by 2002:a17:906:24e:b0:99c:c8ec:bd4a with SMTP id
 14-20020a170906024e00b0099cc8ecbd4amr14264570ejl.60.1692903087746; Thu, 24
 Aug 2023 11:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com> <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
In-Reply-To: <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 24 Aug 2023 11:50:51 -0700
Message-ID: <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:15=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, Aug 24, 2023 at 12:13=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> >
> > On Wed 23-08-23 07:55:40, Yosry Ahmed wrote:
> > > On Wed, Aug 23, 2023 at 12:33=E2=80=AFAM Michal Hocko <mhocko@suse.co=
m> wrote:
> > > >
> > > > On Tue 22-08-23 08:30:05, Yosry Ahmed wrote:
> > > > > On Tue, Aug 22, 2023 at 2:06=E2=80=AFAM Michal Hocko <mhocko@suse=
.com> wrote:
> > > > > >
> > > > > > On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
> > > > [...]
> > > > > So to answer your question, I don't think a random user can reall=
y
> > > > > affect the system in a significant way by constantly flushing. In
> > > > > fact, in the test script (which I am now attaching, in case you'r=
e
> > > > > interested), there are hundreds of threads that are reading stats=
 of
> > > > > different cgroups every 1s, and I don't see any negative effects =
on
> > > > > in-kernel flushers in this case (reclaimers).
> > > >
> > > > I suspect you have missed my point.
> > >
> > > I suspect you are right :)
> > >
> > >
> > > > Maybe I am just misunderstanding
> > > > the code but it seems to me that the lock dropping inside
> > > > cgroup_rstat_flush_locked effectivelly allows unbounded number of
> > > > contenders which is really dangerous when it is triggerable from th=
e
> > > > userspace. The number of spinners at a moment is always bound by th=
e
> > > > number CPUs but depending on timing many potential spinners might b=
e
> > > > cond_rescheded and the worst time latency to complete can be really
> > > > high. Makes more sense?
> > >
> > > I think I understand better now. So basically because we might drop
> > > the lock and resched, there can be nr_cpus spinners + other spinners
> > > that are currently scheduled away, so these will need to wait to be
> > > scheduled and then start spinning on the lock. This may happen for on=
e
> > > reader multiple times during its read, which is what can cause a high
> > > worst case latency.
> > >
> > > I hope I understood you correctly this time. Did I?
> >
> > Yes. I would just add that this could also influence the worst case
> > latency for a different reader - so an adversary user can stall others.
>
> I can add that for v2 to the commit log, thanks.
>
> > Exposing a shared global lock in uncontrolable way over generally
> > available user interface is not really a great idea IMHO.
>
> I think that's how it was always meant to be when it was designed. The
> global rstat lock has always existed and was always available to
> userspace readers. The memory controller took a different path at some
> point with unified flushing, but that was mainly because of high
> concurrency from in-kernel flushers, not because userspace readers
> caused a problem. Outside of memcg, the core cgroup code has always
> exercised this global lock when reading cpu.stat since rstat's
> introduction. I assume there hasn't been any problems since it's still
> there. I was hoping Tejun would confirm/deny this.

One thing we can do to remedy this situation is to replace the global
rstat lock with a mutex, and drop the resched/lock dropping condition.
Tejun suggested this in the previous thread. This effectively reverts
0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex with a spinlock")
since now all the flushing contexts are sleepable.

My synthetic stress test does not show any regressions with mutexes,
and there is a small boost to reading latency (probably because we
stop dropping the lock / rescheduling). Not sure if we may start
seeing need_resched warnings on big flushes though.

One other concern that Shakeel pointed out to me is preemption. If
someone holding the mutex gets preempted this may starve other
waiters. We can disable preemption while we hold the mutex, not sure
if that's a common pattern though.
