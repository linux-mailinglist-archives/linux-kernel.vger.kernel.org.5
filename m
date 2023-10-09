Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3D7BE963
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbjJISdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376281AbjJISdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:33:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B2A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:33:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c6185cafb3so296995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876421; x=1697481221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbawRUEwL9/zR8hpVKzzXxK+1LBrSHSBk1bYuOQZmBA=;
        b=YZEz0bktkrehiO+IUVn17qS+9zbtJodkAWUBOg/+dLNinbFifPM7YKm+fQA5Oue+LW
         DLccQM/VQ9WxaNoEqZdMokt8fDG+j8Po8prHUJodKDBCVIVazCBaLPgRXk+alsZpok+h
         FBPt4c0q6kLjvvsAMal+IEAiVzrXtiwBnAjW6ypXns2gyh63Y9PvEncyAkzH5jh/ucu6
         8d2oVFlJBIfBy0azSkIcmjwTnPjmze+CQVqtbhT3iw+lR7qxT+nyegIxCHTEK2Kz+3Ub
         ICnFwNkT/PxuVR3F5RPY7s6Ezq0wdJuzwloOJb/2N/M8dT9Pfw1r2SOJI3aQXzliWKz9
         ouEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876421; x=1697481221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbawRUEwL9/zR8hpVKzzXxK+1LBrSHSBk1bYuOQZmBA=;
        b=qCS1olhVzY8f3XfhyI30lnePFL24tqEhLOS7CqAx2Ov/ow+mt4hzXbndZzfL9s5GxQ
         bbt7YgBbkvn/kcNfaZM99Qp8DnseoWldg9ZzlzXjSFvJAoH3uBH4y0Y4NN8jE+jiZZ6e
         rNHYNlu0RQ5v5yt9L4rzwlQXZ/Fn7/pMkZ9APOcuXJF8Ji3tWsvKxObaoAxbzHv15OY5
         qtCvF9aqwtPO157czu2aw/Y78GFQ9T/Sqvx9NLGPEiHkRNuOiHvbtOOnFhh1tLPwp9Tv
         b78VGW8owwqLE1x8OtrHXLT3ZpxiOiRHJ/sfXrhCXWD7Eyw4cw5ENCMeXEQiy/Pjk0tl
         lD7A==
X-Gm-Message-State: AOJu0Yx1J/h110g0tRRBQmbswkQ5Fb4fvj5/Tk4ThQ/X+6VJfeMgAvfB
        ELSXuMvVPWAsz+/9DyzvaBjtKdFaN2qtoqLBRwDfQQ==
X-Google-Smtp-Source: AGHT+IFIJSSW6R6i1TDa7gjcURkjDyXJSxHM1LIWjVeLdl2+mRZ0a1ao35LJlIjyfG384hkX4eXIrzP6CEwTJXWByJo=
X-Received: by 2002:a17:903:183:b0:1b9:d96c:bca7 with SMTP id
 z3-20020a170903018300b001b9d96cbca7mr744200plg.25.1696876421161; Mon, 09 Oct
 2023 11:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <ZR/mvd8Uw8PG+jx0@gmail.com> <20231008173535.GD2338308@google.com>
In-Reply-To: <20231008173535.GD2338308@google.com>
From:   Vineeth Pillai <vineethrp@google.com>
Date:   Mon, 9 Oct 2023 14:33:30 -0400
Message-ID: <CA+HDTgSwoO+uXQ0xmmBzaDy3ViZcZ765P6_GsAmxKedRVKyY_A@mail.gmail.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 1:35=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
[...snip...]
> > The patch does make _nohz_idle_balance() run more parallel, as previous=
ly
> > it would be generally run by the first-idle CPU in nohz.idle_cpus_mask =
(at
> > least for next_balance updates), but I think it's still SMP-safe, as al=
l
> > key data structure updates are already rq-locked AFAICS.
>
> One thing I am confused about in the original code is:
>
> tick_nohz_idle_stop_tick() is what sets the nohz.idle_cpus_mask.
> However, nohz_run_idle_balance() is called before that can happen, in
> do_idle(). So it is possible that NOHZ_NEWILB_KICK is set for a CPU but i=
t is
> not yet in the mask.
>
> So will this code in _nohz_idle_balance() really run in such a scenario?
>
>                 if (flags & NOHZ_STATS_KICK)
>                         has_blocked_load |=3D update_nohz_stats(rq);
>
> AFAICS, this loop may not select the CPU due to its absence from the mask=
:
>         for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1)
>
I have traced this a bit further. As Joel mentioned, the
nohz.idle_cpus_mask shouldn't contain this cpu when
nohz_run_idle_balance () is called from do_idle(), but on tracing I
have seen that it does have it mostly with HIGHRES. And I feel this is
a bug. We call nohz_balance_enter_idle() when we turn off the tick,
but we don't always call nohz_balance_exit_idle() when we turn the
tick back on. We call it only on the next tick on this cpu in
nohz_balancer_kick. If a wakeup happens on this cpu while the tick is
off, we re-enable the tick, but do not remove ourselves from the
nohz.idle_cpus_mask. So, ILB will consider this cpu to be a valid pick
until the next tick on this cpu where it gets removed. I am not sure
if this is intentional.

If this is a bug and we fix it by calling nohz_balance_exit_idle
during restart_tick, then we might not probably need NOHZ_NEWIDLE_KICK
flag and could use NOHZ_STATS_KICK as there will not be any overlap
between nohz_run_idle_balance and nohz_idle_balance.

Thanks,
Vineeth
