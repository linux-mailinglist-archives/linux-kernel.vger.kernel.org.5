Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA676BD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjHATGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjHATGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DD1BE3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690916714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zSSGuAEUWvHjtwjF2gl9W+Rk28AvcJoOE90ZXEQ90k=;
        b=ZIJMzHCg6ffdkHv6rr7MrpZyqDllafaOQQGNZ2AyrUPuLrEDanNnh8GeAvaUGyCUV8RpQ1
        DosrcWeO0+vflF9eWJbcBLoy2O0VoBNSnZXXkPS/XR4WJ3vrE/ukYtdb70wnwaiOHv0D5W
        OCu4iZ4DkZIhmR4SxLDd9wB3h1aTOT4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-cPu_OjluPkCJfSVcCUDW9Q-1; Tue, 01 Aug 2023 15:05:13 -0400
X-MC-Unique: cPu_OjluPkCJfSVcCUDW9Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4053d10ee39so58454861cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690916713; x=1691521513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zSSGuAEUWvHjtwjF2gl9W+Rk28AvcJoOE90ZXEQ90k=;
        b=Unwc2f4LAJ57ZhLa1SCPX18mHQIiDj33RsmVK+HUJtMX7mhnBBm4FSiegA9zB9TBLS
         YYiTSt0OzDKspQSiN8h6bWR5kpPlNM/TXxpaKDNfdXImR5zt+nNbBZGtZtB6lWIJeV62
         Lo0pPqZdfZH/+XuEdLUaeBSMsuYrFmLifVSZN46GA3Dm5QB4zMbhLu2h2gpu3ynqTvZ9
         mC9mwwLGtrYBaXst7O0PlO63ZLbClIK3CfkG32OYUDfqt5LxQsTnP/w0Hf6WLXcSGMV/
         Wi1ir4QceiPOikr1syjkIYpYzfJeS+PmzuEXpoTdqgwLCU7at2JQ7QY4aerGJl/FQpDA
         sMGw==
X-Gm-Message-State: ABy/qLY0TG9ygW8F4VWSgPB3HfU6GYJPtPloYxcjOT8fkEiVG1ll2nAw
        y2apEq+rNb4d14B1dOOZ7y0WtpUyaDHG6RU6W1BvyJ7z4ix64/FzxPzevHuVt+Cgx3lMeA0upjy
        lSvvhk2TUKMuZthzQQDmNj/Wj/g8UQTtgZajXrF5z
X-Received: by 2002:ac8:4e95:0:b0:40f:d397:d1d5 with SMTP id 21-20020ac84e95000000b0040fd397d1d5mr3466118qtp.49.1690916712855;
        Tue, 01 Aug 2023 12:05:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQUKu8fiF8JWX+7vi4hnZrY+5e7nKWuBaVJm2q11PuWFO4uaYfYywhuA/wAC/lqZcDnm1HVWJ9gWnXYO2koko=
X-Received: by 2002:ac8:4e95:0:b0:40f:d397:d1d5 with SMTP id
 21-20020ac84e95000000b0040fd397d1d5mr3466102qtp.49.1690916712598; Tue, 01 Aug
 2023 12:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230729083737.38699-2-leobras@redhat.com>
In-Reply-To: <20230729083737.38699-2-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Tue, 1 Aug 2023 16:05:01 -0300
Message-ID: <CAJ6HWG4=2xXo6Ck5-P9gYsOy+SaLemz3apnKaU3z+HwgUvuspg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Improve RT performance & latency w/ local_lock_t()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Peter Xu

On Sat, Jul 29, 2023 at 5:38=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> The problem:
> We have a few scenarios in mm that make use of local_locks() +
> schedule_work_on() due to reduced overhead on the most common local
> references. This scenario is not ideal for RT workloads though: even on
> isolated cpus, those tasks will schedule-out the sensitive RT workloads t=
o
> perform those jobs, and usually cause missing deadlines with this.
>
> The idea:
> In PREEMPT_RT, local_locks() end up becoming spinlocks(), so there should
> be no harm in just getting another cpu's spinlock to perform the work
> on the per-cpu structure: the cacheline invalidation will already happen
> due to the usage by schedule_work_on(), and on local functions the lockin=
g
> already happens anyway.
>
> This will avoid schedule_work_on(), and thus avoid scheduling-out an
> RT workload. Given the usually brief nature of those scheduled tasks, the=
ir
> execution end up being faster than doing their scheduling.
>
> =3D=3D=3D=3D=3D=3D
>
> While I really belive the solution, there are problems with this patchset=
,
> which I need your suggestions for improvement:
>
> 1) Naming is horrible: I could not think on a good name for the new lock
> functions, so I lazely named it local_lock_n().
> The naming should have been making clear that we are in fact dealing
> with a local_lock but it can in some scenarios be addressing another cpu'=
s
> local_lock, and thus we need the extra cpu parameter.
>
> Dealing with this local & remote duality, all I thought was:
> mostly_local_lock(), (or local_mostly_lock())
> local_maybe_remote_lock()  <- LOL
> remote_local_lock()
> per_cpu_local_lock()
> local_lock_cpu()
>
> Please help !
>
>
> 2) Maybe naming is this hard because the interface is not the best.
> My idea was to create a simple interface to easily replace functions
> already in use, but maybe there is something better I could not see.
>
> Please contribute!
>
> 3) I am lazely setting work->data without atomic operations, which may
> be bad in some scenario. If so, even thought it can be costly, since it
> happens outside of the hotpath (local per-cpu areas) it should be no
> problem adding the atomic operation for non-RT kernels.
>
> For RT kernels, since the whole operation hapens locally, there should be
> no need of using the atomic set.
>
> Please let me know of any idea, or suggestion that can improve this RFC.
>
> Thanks a lot!
> Leo
>
> Leonardo Bras (4):
>   Introducing local_lock_n() and local queue & flush
>   swap: apply new local_schedule_work_on() interface
>   memcontrol: apply new local_schedule_work_on() interface
>   slub: apply new local_schedule_work_on() interface
>
>  include/linux/local_lock.h          | 18 ++++++++++
>  include/linux/local_lock_internal.h | 52 +++++++++++++++++++++++++++++
>  mm/memcontrol.c                     | 17 ++++++----
>  mm/slub.c                           | 17 ++++++----
>  mm/swap.c                           | 18 +++++-----
>  5 files changed, 100 insertions(+), 22 deletions(-)
>
> --
> 2.41.0
>

