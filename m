Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A577F48C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbjKVOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjKVOUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:20:00 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC439101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:19:55 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-589d6647c6cso3335972eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700662795; x=1701267595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBhwIjltHwcn2ZfqYwpg0QIfI2aQg/5DqMt6hZem3dk=;
        b=jBFXRhrPmOue3xgyOPPlFnlOj1iVUDkBd3EORYf5pzpyOvGGliZZisW5VgqNDcHCWh
         9egA2QVFsA4vbl3D4rzd6xY3MA+cUFf6Naz+PZTGofgEWS0DenBzTIxmyJP4AnVhgP+8
         TuMeKN7BcRDcLnh/GK2tdrq9ISmKQDHUrBBZUJah42XxVTAwUXlZsjM2D5m63jEunrDx
         hID2dNImk3MmzeE8nYFawH7vbQ7uYSqt0fBAWLbu7OJkesVmFAUd9PPdMzgkY2ivzRAA
         CRI9BCsZQAUB4F0aSkzYUprlkVxkalZp/QyKDoDj3YZOXravmrSOg6qa+PNF29JWMJC1
         PxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662795; x=1701267595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBhwIjltHwcn2ZfqYwpg0QIfI2aQg/5DqMt6hZem3dk=;
        b=jvjXFAa/hCRVOe7+ohqv9ljzqobWbkapmO9DXxPhRh9mQQskhWwFh47WS1pZ0BXxVg
         IKFh/0BtOQ/MMXMTg5cbOfJJ8/wSEUMaAgiWuF5kDDPtbSd5ahpHvK6UgC9NcbdDqoI4
         nzeyfij/dvJ/Wi6O+b1Ttqzb7qVJ5xHPGokdDki6I80lQFm0H1IztMUQXkLQUhI1S8Q4
         ZOIXFkgnLC5EreDlcCIamh3y0EPxp3jvUX+G1TRaH4B9lo1Z51zEpBvXgkb4AJu/fIVN
         f00AIyxdBduhmLFZloVvEl9dmB1TiFRuL1Dsw5BtqLrpo8sRiv/CkHDiFn65766gq5Ml
         9KQw==
X-Gm-Message-State: AOJu0Yyz0GT99XwUpuqv7zF1yiJpj9lfwnFFBZGOcgqll/Sdxplgcu9n
        LqQU5dYKOHlXwI7qzF9LzJvmfYG165B3i7kM6hZ/rA==
X-Google-Smtp-Source: AGHT+IEc2PVfVWfvOMes5lbLlaO0pNJZHbNND/52Csx+KnUa7GnQlhFXcXBk3di+CcEiQ2ztVQOq9cPQTgO8c8hIoA8=
X-Received: by 2002:a05:6358:9226:b0:16b:c6f5:5e3b with SMTP id
 d38-20020a056358922600b0016bc6f55e3bmr1827963rwb.26.1700662794926; Wed, 22
 Nov 2023 06:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20231116123016.140576-1-naresh.kamboju@linaro.org> <20231120153623.49c5119b@gandalf.local.home>
In-Reply-To: <20231120153623.49c5119b@gandalf.local.home>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Nov 2023 19:49:43 +0530
Message-ID: <CA+G9fYsDAOPBVyBhxKMuHW_YUGA0KZTZiZ2pT_msyGuRNsbw8w@mail.gmail.com>
Subject: Re: selftests: ftrace: WARNING: __list_del_entry_valid_or_report
 (lib/list_debug.c:62 (discriminator 1))
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, lkft@linaro.org,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,



On Tue, 21 Nov 2023 at 02:06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 16 Nov 2023 18:00:16 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > Following kernel crash noticed while running selftests: ftrace on arm64 Juno-r2
> > device running stable-rc linux-6.6.y kernel.
> >
> > This kernel crash is hard to reproduce.
> >
>
> Can you test this patch.

I have applied your patch on top of Linux stable-rc linux-6.6.y and tested
selftests: ftrace: for 100 iterations on arm64 Juno-r2 device.

Out of 100 test runs I see the following exception only once.
I do not see crashes related to the previous report.


Test log:
----
# ok 8 trace_pipe and trace_marker
...
[  282.726999] Unexpected kernel BRK exception at EL1
[  282.731840] Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
[  282.738752] Modules linked in: ftrace_direct ftrace_direct_too
hdlcd tda998x onboard_usb_hub drm_dma_helper cec crct10dif_ce
drm_kms_helper fuse drm backlight dm_mod ip_tables x_tables [last
unloaded: ftrace_direct]
[  282.758152] CPU: 0 PID: 987 Comm: rmmod Not tainted 6.6.2-rc1 #1
[  282.764191] Hardware name: ARM Juno development board (r2) (DT)
[  282.770138] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  282.777133] pc : ring_buffer_lock_reserve
(kernel/trace/ring_buffer.c:3304 (discriminator 1)
kernel/trace/ring_buffer.c:3819 (discriminator 1))
[  282.782230] lr : trace_function (kernel/trace/trace.c:992
kernel/trace/trace.c:3078)
[  282.786360] sp : ffff80008428ba20
[  282.789695] x29: ffff80008428ba20 x28: ffff00082bb367c0 x27: 0000000000000000
[  282.796898] x26: ffff800080371d84 x25: 0000000000000000 x24: ffff00097ed1e4b0
[  282.804100] x23: ffff000800018400 x22: 0000000000000000 x21: 0000000000000018
[  282.811302] x20: ffff000800018400 x19: ffff000800041400 x18: ffffffffffffffff
[  282.818504] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081d2ec58
[  282.825706] x14: ffffffffffffffff x13: ffff80008428beb0 x12: 000002550000ffff
[  282.832908] x11: ffff800083343078 x10: ffff80008428bbc0 x9 : ffff8000803e3110
[  282.840110] x8 : ffff80008428ba98 x7 : 0000000000000000 x6 : 0000000000000009
[  282.847311] x5 : 0000000000000081 x4 : fffffffffffffffb x3 : 0000000000000001
[  282.854513] x2 : ffffffffffffffff x1 : 0000000000000000 x0 : 0000000000000000
[  282.861715] Call trace:
[  282.864179] ring_buffer_lock_reserve
(kernel/trace/ring_buffer.c:3304 (discriminator 1)
kernel/trace/ring_buffer.c:3819 (discriminator 1))
[  282.868920] trace_function (kernel/trace/trace.c:992
kernel/trace/trace.c:3078)
[  282.872702] tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:279
kernel/trace/trace_irqsoff.c:397 kernel/trace/trace_irqsoff.c:619
kernel/trace/trace_irqsoff.c:616)
[  282.877009] trace_hardirqs_off.part.0
(kernel/trace/trace_preemptirq.c:78 (discriminator 1))
[  282.881748] trace_hardirqs_off (kernel/trace/trace_preemptirq.c:94)
[  282.885791] obj_cgroup_charge (mm/memcontrol.c:3236 (discriminator
1) mm/memcontrol.c:3364 (discriminator 1))
[  282.889918] kmem_cache_alloc (mm/slab.h:503 (discriminator 2)
mm/slab.h:714 (discriminator 2) mm/slub.c:3460 (discriminator 2)
mm/slub.c:3486 (discriminator 2) mm/slub.c:3493 (discriminator 2)
mm/slub.c:3502 (discriminator 2))
[  282.893873] __anon_vma_prepare (mm/rmap.c:197)
[  282.897999] __handle_mm_fault (mm/memory.c:4111 (discriminator 2)
mm/memory.c:3670 (discriminator 2) mm/memory.c:4981 (discriminator 2)
mm/memory.c:5122 (discriminator 2))
[  282.902213] handle_mm_fault (mm/memory.c:5287)
[  282.906077] do_page_fault (arch/arm64/mm/fault.c:513
arch/arm64/mm/fault.c:626)
[  282.909856] do_translation_fault (arch/arm64/mm/fault.c:714)
[  282.914068] do_mem_abort (arch/arm64/mm/fault.c:846 (discriminator 1))
[  282.917591] el0_da (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:547)
[  282.920590] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:700)
[  282.924894] el0t_64_sync (arch/arm64/kernel/entry.S:595)
[ 282.928593] Code: 88037c22 35ffffa3 17fffff8 94549eb9 (d4207d00)
All code
========
   0: 88037c22 stxr w3, w2, [x1]
   4: 35ffffa3 cbnz w3, 0xfffffffffffffff8
   8: 17fffff8 b 0xffffffffffffffe8
   c: 94549eb9 bl 0x1527af0
  10:* d4207d00 brk #0x3e8 <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: d4207d00 brk #0x3e8
[  282.934716] ---[ end trace 0000000000000000 ]---
[  282.939358] note: rmmod[987] exited with irqs disabled
[  282.945441] note: rmmod[987] exited with preempt_count 2
[  282.951337] ------------[ cut here ]------------
[  282.955980] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128
ct_kernel_exit.constprop.0 (kernel/context_tracking.c:128
(discriminator 1))
[  282.965683] Modules linked in: ftrace_direct ftrace_direct_too
hdlcd tda998x onboard_usb_hub drm_dma_helper cec crct10dif_ce
drm_kms_helper fuse drm backlight dm_mod ip_tables x_tables [last
unloaded: ftrace_direct]
[  282.985075] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
   6.6.2-rc1 #1
[  282.992767] Hardware name: ARM Juno development board (r2) (DT)
[  282.998713] pstate: 200003c5 (nzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  283.005708] pc : ct_kernel_exit.constprop.0
(kernel/context_tracking.c:128 (discriminator 1))
[  283.010965] lr : ct_idle_enter (kernel/context_tracking.c:321)
[  283.014915] sp : ffff800083283b90
[  283.018249] x29: ffff800083283b90 x28: 00000000826a40ac x27: 0000000000000000
[  283.025452] x26: 00000000fef770dc x25: 0000000000000001 x24: ffff000822878880
[  283.032654] x23: 0000000000000001 x22: 00000000000003c0 x21: 0000000000010000
[  283.039856] x20: ffff80008172c118 x19: ffff00097ed16da0 x18: 0000000000000010
[  283.047059] x17: 0000000000000000 x16: 3030303030303020 x15: 0000000000000000
[  283.054260] x14: 0000000000000000 x13: 3220746e756f635f x12: 0000000000000003
[  283.061462] x11: ffff800083343078 x10: ffff800083283bc0 x9 : ffff800080039620
[  283.068665] x8 : ffff800083283af8 x7 : 0000000000000000 x6 : 000000000000003f
[  283.075867] x5 : 4000000000000002 x4 : ffff8008fc5b4000 x3 : ffff800083283b90
[  283.083069] x2 : ffff800082762da0 x1 : 4000000000000000 x0 : ffff800082762da0
[  283.090271] Call trace:
[  283.092736] ct_kernel_exit.constprop.0
(kernel/context_tracking.c:128 (discriminator 1))
[  283.097646] ct_idle_enter (kernel/context_tracking.c:321)
[  283.101249] cpu_suspend (arch/arm64/kernel/suspend.c:130)
[  283.104854] psci_cpu_suspend_enter (drivers/firmware/psci/psci.c:488)
[  283.109244] psci_enter_idle_state
(drivers/cpuidle/cpuidle-psci.c:190 (discriminator 10))
[  283.113544] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:267)
[  283.117757] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 (discriminator 2))
[  283.121361] do_idle (kernel/sched/idle.c:134
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
[  283.124619] cpu_startup_entry (kernel/sched/idle.c:380 (discriminator 1))
[  283.128572] rest_init (include/linux/cpumask.h:1058 init/main.c:700)
[  283.131913] arch_call_rest_init+0x18/0x20
[  283.136042] start_kernel (init/main.c:882 (discriminator 1))
[  283.139734] __primary_switched (arch/arm64/kernel/head.S:524)
[  283.143775] ---[ end trace 0000000000000000 ]---

Links:
- https://lkft.validation.linaro.org/scheduler/job/7043802#L1756

--
Linaro LKFT
https://lkft.linaro.org

> Note, there's a similar bug on 6.7-rc1 which I'll fix first. And when
> that's accepted, I'll push this one for v6.6. This may be two patches as
> one if the d_invalidate() issue, and another is a memory leak fix.
>
> -- Steve
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5fcfb634fec2..b60048469df1 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -289,6 +289,8 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>                 ef = dentry->d_fsdata;
>                 if (ef)
>                         free_ef(ef);
> +               else
> +                       kfree(ei);
>                 return;
>         }
>
> @@ -342,7 +344,6 @@ static void eventfs_post_create_dir(struct eventfs_file *ef)
>  static struct dentry *
>  create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
>  {
> -       bool invalidate = false;
>         struct dentry *dentry;
>
>         mutex_lock(&eventfs_mutex);
> @@ -387,23 +388,24 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
>                         eventfs_post_create_dir(ef);
>                 dentry->d_fsdata = ef;
>         } else {
> -               /* A race here, should try again (unless freed) */
> -               invalidate = true;
> -
>                 /*
> +                * If we are here then the directory is being freed.
> +                * The simple_recursive_removal() will get rid of the dentry
> +                * here.
> +                */
> +               dentry = NULL;
> +                /*
>                  * Should never happen unless we get here due to being freed.
>                  * Otherwise it means two dentries exist with the same name.
>                  */
>                 WARN_ON_ONCE(!ef->is_freed);
>         }
>         mutex_unlock(&eventfs_mutex);
> -       if (invalidate)
> -               d_invalidate(dentry);
>
> -       if (lookup || invalidate)
> +       if (lookup)
>                 dput(dentry);
>
> -       return invalidate ? NULL : dentry;
> +       return dentry;
>  }
>
>  static bool match_event_file(struct eventfs_file *ef, const char *name)
> --
> 2.42.0
>
