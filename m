Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5707F3C79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjKVDg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVDgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:36:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E8D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:36:21 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bde80aad05so4913218a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700624181; x=1701228981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJYNaQAAZrepl2ZxYcQuq32w1uSGi1gYODywwNvp7o0=;
        b=I9IVZou+mln/G5lz7sEoAmv4xyJHZOg4FNUVnfL6u1pXoZ/oWmGiFwwXQksBLxyEL8
         H1dtzHoBOnFaW2CJ85wfA5OyYVrzROzwpF5DvTBMYEjpaSni84Lo2Mm6pmfLSEwQl8UL
         7SLgvPEjFgvRIcNTlBWmskEl3n+XiGb/RFQ8R9Exz5igaa94YDJq7tob1q0lr4lGvhVS
         z+rCggmEkcWf1XJxCbKd341rsA0+9oq/zZCl/2lY4ux18P0eRnM6o6r6KvJi1akx3fxV
         h0WTQwmoPVbp2YSCFG7X6z1/YdXcfPXoqCrx3xD6knzbi5z9bk1d7DkoLf1/J4uiBY7L
         1xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700624181; x=1701228981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJYNaQAAZrepl2ZxYcQuq32w1uSGi1gYODywwNvp7o0=;
        b=uz63LRl9OJqrM6+qCBQn2wNpdArmMeWW/1NwnQp5HJ91TRsznm8TFCg8P+R557EuDF
         LYHEM719ZUn1DziQgx+oeir+VarlXEWASl3AjzpKxttmEjn7W+VJMGkm9SUY4+9asUIF
         b6mKXL7w6LONStPZvKbmeKpbjz9Y14+CLSjVNbx/KL/QsoIbNYAEfDDCJONtGeALFTkd
         JH8xYub3K/FVYsgNkQkTT+s7/hGXezNi6FPkUUcJ5qRv2Sy7x0Bei0aPrXjbPyAdCRvZ
         5DA+xuZCJIkz4mlNeKW//tyDGEkq9M1gO3S17gO9KYh6EpFsVPswoXd3SrUrAZhFhOzC
         qzcw==
X-Gm-Message-State: AOJu0YxpVE9obtxwWtOotwy7+cYFFz/Ut3BCtm5bXnC59Egu/mwO3zup
        sjKx6XqJfKGyFOxiFkGhsh7FNiPgtxvIUUga7AQ=
X-Google-Smtp-Source: AGHT+IGW1CvL3fMk+EADXesb7N7kbsBPKsNqSw9Ed6EbWFpBAMADHekxE5TH/KJmblqo4vXFd5NoDcvFM33si+Lblgw=
X-Received: by 2002:a05:6a20:914b:b0:18a:e3d9:ef5c with SMTP id
 x11-20020a056a20914b00b0018ae3d9ef5cmr1324769pzc.4.1700624181156; Tue, 21 Nov
 2023 19:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20231120121623.119780-1-alexyonghe@tencent.com>
 <ZVuudtAtDqHqYJr8@slm.duckdns.org> <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
 <ZV0jmGSismObVncD@slm.duckdns.org>
In-Reply-To: <ZV0jmGSismObVncD@slm.duckdns.org>
From:   zhuangel570 <zhuangel570@gmail.com>
Date:   Wed, 22 Nov 2023 11:36:09 +0800
Message-ID: <CANZk6aRpPAhY_5wS-4igRwSZ5Ohv0RJJ5kgr9_M-W192nH-aVA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Make sure that wq_unbound_cpumask is never empty
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 5:39=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> During boot, depending on how the housekeeping and workqueue.unbound_cpus
> masks are set, wq_unbound_cpumask can end up empty. Since 8639ecebc9b1
> ("workqueue: Implement non-strict affinity scope for unbound workqueues")=
,
> this may end up feeding -1 as a CPU number into scheduler leading to oops=
es.
>
>   BUG: unable to handle page fault for address: ffffffff8305e9c0
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   ...
>   Call Trace:
>    <TASK>
>    select_idle_sibling+0x79/0xaf0
>    select_task_rq_fair+0x1cb/0x7b0
>    try_to_wake_up+0x29c/0x5c0
>    wake_up_process+0x19/0x20
>    kick_pool+0x5e/0xb0
>    __queue_work+0x119/0x430
>    queue_work_on+0x29/0x30
>   ...
>
> An empty wq_unbound_cpumask is a clear misconfiguration and already
> disallowed once system is booted up. Let's warn on and ignore
> unbound_cpumask restrictions which lead to no unbound cpus. While at it,
> also remove now unncessary empty check on wq_unbound_cpumask in
> wq_select_unbound_cpu().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Yong He <alexyonghe@tencent.com>
> Link: http://lkml.kernel.org/r/20231120121623.119780-1-alexyonghe@tencent=
.com
> Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for =
unbound workqueues")
> Cc: stable@vger.kernel.org # v6.6+
> ---
> Hello,
>
> Yong He, zhuangel570, can you please verify that this patch makes the oop=
s
> go away? Waiman, this touches code that you've recently worked on. AFAICS=
,
> they shouldn't interact or cause conflicts. cc'ing just in case.

Sure.
I port this patch to my 6.7 branch, and the kernel could boot successfully =
on BM
and VM, with the same configurations, also I can see the new added warning,=
 so
this patch solves the oops.

So, one last check, do you think we still need to check return value from
cpumask_any_distribute() to make sure kick_pool() set a correct wake_cpu?

Tested-by: Yong He <alexyonghe@tencent.com>

>
> Thanks.
>
>  kernel/workqueue.c |   22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 6e578f576a6f..0295291d54bc 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1684,9 +1684,6 @@ static int wq_select_unbound_cpu(int cpu)
>                 pr_warn_once("workqueue: round-robin CPU selection forced=
, expect performance impact\n");
>         }
>
> -       if (cpumask_empty(wq_unbound_cpumask))
> -               return cpu;
> -
>         new_cpu =3D __this_cpu_read(wq_rr_cpu_last);
>         new_cpu =3D cpumask_next_and(new_cpu, wq_unbound_cpumask, cpu_onl=
ine_mask);
>         if (unlikely(new_cpu >=3D nr_cpu_ids)) {
> @@ -6515,6 +6512,17 @@ static inline void wq_watchdog_init(void) { }
>
>  #endif /* CONFIG_WQ_WATCHDOG */
>
> +static void __init restrict_unbound_cpumask(const char *name, const stru=
ct cpumask *mask)
> +{
> +       if (!cpumask_intersects(wq_unbound_cpumask, mask)) {
> +               pr_warn("workqueue: Restricting unbound_cpumask (%*pb) wi=
th %s (%*pb) leaves no CPU, ignoring\n",
> +                       cpumask_pr_args(wq_unbound_cpumask), name, cpumas=
k_pr_args(mask));
> +               return;
> +       }
> +
> +       cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
> +}
> +
>  /**
>   * workqueue_init_early - early init for workqueue subsystem
>   *
> @@ -6534,11 +6542,11 @@ void __init workqueue_init_early(void)
>         BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(lon=
g long));
>
>         BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
> -       cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ)=
);
> -       cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_=
cpumask(HK_TYPE_DOMAIN));
> -
> +       cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
> +       restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TY=
PE_WQ));
> +       restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(H=
K_TYPE_DOMAIN));
>         if (!cpumask_empty(&wq_cmdline_cpumask))
> -               cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, &wq_c=
mdline_cpumask);
> +               restrict_unbound_cpumask("workqueue.unbound_cpus", &wq_cm=
dline_cpumask);
>
>         pwq_cache =3D KMEM_CACHE(pool_workqueue, SLAB_PANIC);
>
