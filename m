Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3652A767AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjG2BZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjG2BZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:25:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002E3AA8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:25:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f954d7309fso3319061e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690593948; x=1691198748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTTYf0zH8+8az2BIYrB+cQedxz4R5dEs1EX+ZP0IuQc=;
        b=lkDc/FL8v9S4aBnCpuoMg+IVrEE9MT1MjaC/ehwLD1lw0DTZlmYdQ1vqW7SgleoHjq
         uPVs2VM64kDFyeOIlSnG5vT+Gvcq/Mu2ZOY1qpSs164KFE2KGbg4M4hQ2ILiTSHM5IUp
         3gIlB6oYd3hZsEU+c+4SllZduG1/dOqXsCXfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593948; x=1691198748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTTYf0zH8+8az2BIYrB+cQedxz4R5dEs1EX+ZP0IuQc=;
        b=ed49+D+ihU+G6gIydLUdXmd9gjZwHhDL5fgBNQKeyrG271egkZkl1NNE7sUTuntGx2
         R/kj4SypeGND4mm/eEWuuVQ6AnMa2+WLAEMxGUHhzoFyexYEbSYxXS0X7fE5ZL67KouH
         IQktXWPQinuJvw1HpHwLPfxXyfG3bS/YF9KmIbMLO77ZD8t5ikJUANKrp1bf2SgQ/zaE
         M4nJkAxUrXF1OyFzcFDFAsF8kS8DsEzue/0iQFj+VFfgNRp569vdhFOD+DTj6BE+/m7C
         60ulg1jqixqpd/XOw6ARb4brPvV13627f2+Ym7M4Q4f/+pqRg9I4sjOqD1sRFvuWnper
         /cTA==
X-Gm-Message-State: ABy/qLZdyiQVeOVB4CuNGbASKFV+kYo8QU9+CaF18iilYtLqRXaTo/ss
        bU72gPVE/C0SfZKi2cfhxbnCVvnbR2zyTCFE5sT+mw==
X-Google-Smtp-Source: APBJJlGetBE3tjvmodmJHl1fiuy7SMeZpXSZmjyzctDl2QvbXPvsgsOEMJMQg+C7AU9SreMe4/KEiLkadgmCttrzPHo=
X-Received: by 2002:a05:6512:3b82:b0:4f9:6adf:3981 with SMTP id
 g2-20020a0565123b8200b004f96adf3981mr2880284lfv.33.1690593947935; Fri, 28 Jul
 2023 18:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <99B56FC7-9474-4968-B1DD-5862572FD0BA@joelfernandes.org> <a174c501-48df-404e-ae61-10ddaeb8e557@paulmck-laptop>
In-Reply-To: <a174c501-48df-404e-ae61-10ddaeb8e557@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 28 Jul 2023 21:25:35 -0400
Message-ID: <CAEXW_YS3hK8Y5TKCPvnNC9fsbmmMvcjx2f-G4uCXX=F2WNz-HQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
To:     paulmck@kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_PORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 6:58=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> > On Fri, Jul 28, 2023 at 05:17:59PM -0400, Joel Fernandes wrote:
> >
> >   On Jul 27, 2023, at 7:18 PM, Joel Fernandes <joel@joelfernandes.org>
> >   wrote:
> >
> > =EF=BB=BF
> >
> >   On Jul 27, 2023, at 4:33 PM, Paul E. McKenney <paulmck@kernel.org>
> >   wrote:
> >
> >   =EF=BB=BFOn Thu, Jul 27, 2023 at 10:39:17AM -0700, Guenter Roeck wrot=
e:
> >
> >   On 7/27/23 09:07, Paul E. McKenney wrote:
> >
> >   ...]
> >
> >   No. However, (unrelated) in linux-next, rcu tests sometimes result
> >   in apparent hangs
> >
> >   or long runtime.
> >
> >   [    0.778841] Mount-cache hash table entries: 512 (order: 0, 4096
> >   bytes, linear)
> >
> >   [    0.779011] Mountpoint-cache hash table entries: 512 (order: 0,
> >   4096 bytes, linear)
> >
> >   [    0.797998] Running RCU synchronous self tests
> >
> >   [    0.798209] Running RCU synchronous self tests
> >
> >   [    0.912368] smpboot: CPU0: AMD Opteron 63xx class CPU (family:
> >   0x15, model: 0x2, stepping: 0x0)
> >
> >   [    0.923398] RCU Tasks: Setting shift to 2 and lim to 1
> >   rcu_task_cb_adjust=3D1.
> >
> >   [    0.925419] Running RCU-tasks wait API self tests
> >
> >   (hangs until aborted). This is primarily with Opteron CPUs, but also
> >   with others such as Haswell,
[...]
> >   Building
> >   x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:me
> >   m2G:virtio:cd ... running ......... passed
[...]
> >   I freely confess that I am having a hard time imagining what would
> >
> >   be CPU dependent in that code.  Timing, maybe?  Whatever the reason,
> >
> >   I am not seeing these failures in my testing.
> >
> >   So which of the following Kconfig options is defined in your
> >   .config?
> >
> >   CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
> >
> >   If you have more than one of them, could you please apply this patch
> >
> >   and show me the corresponding console output from the resulting
> >   hang?
> >
> > FWIW, I am not able to repro this issue either. If a .config can be
> > shared of the problem system, I can try it out to see if it can be
> > reproduced on my side.
> >
> > I do see this now on 5.15 stable:
> >
> >TASKS03 ------- 3089 GPs (0.858056/s)
> >QEMU killed
> >TASKS03 no success message, 64 successful version messages
> >!!! PID 3309783 hung at 3781 vs. 3600 seconds
> >
> > I have not looked too closely yet. The full test artifacts are here:
> >
> > [1]Artifacts of linux-5.15.y 5.15.123 :
> > /tools/testing/selftests/rcutorture/res/2023.07.28-04.00.44 [Jenkins]
> > [2]box.joelfernandes.org
> > [3]apple-touch-icon.png
> >
> > Thanks,
> >
> > - Joel
> >
> > (Apologies if the email is html, I am sending from phone).
>
> Heh.  I have a script that runs lynx.  Which isn't perfect, but usually
> makes things at least somewhat legible.

Sorry I was too optimistic about the iPhone's capabilities when it
came to mailing list emails.
Here's what I said:
--------------
I do see this now on 5.15 stable:

TASKS03 ------- 3089 GPs (0.858056/s)
QEMU killed
TASKS03 no success message, 64 successful version messages
!!! PID 3309783 hung at 3781 vs. 3600 seconds

Link to full logs/artifacts:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/la=
stFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.07.28-04=
.00.44/
----------------

> This looks like the prototypical hard hang with interrupts disabled,
> which could be anywhere in the kernel, including RCU.  I am not seeing
> this.  but the usual cause when I have seen it in the past was deadlock
> of irq-disabled locks.  In one spectacular case, it was a timekeeping
> failure that messed up a CPU-hotplug operation.
>
> If this is reproducible, one trick would be to have a script look at
> the console.log file, and have it do something (NMI? sysrq?  something
> else?) to qemu if output ceased for too long.
>
> One way to do this without messing with the rcutorture scripting is to
> grab the qemu-cmd file from this run, and then invoke that file from your
> own script, possibly with suitable modifications to qemu's parameters.

Would it be better to have such monitoring as part of rcutorture
testing itself? Alternatively there is the NMI hardlockup detector
which I believe should also detect such cases and dump stacks.

thanks,

 - Joel

>
> Thoughts?
>
>                                                         Thanx, Paul
>
> > Cheers,
> > - Joel
> >
> >                             Thanx, Paul
> >
> >   --------------------------------------------------------------------
> >   ----
> >
> >   commit 709a917710dc01798e01750ea628ece4bfc42b7b
> >
> >   Author: Paul E. McKenney <paulmck@kernel.org>
> >
> >   Date:   Thu Jul 27 13:13:46 2023 -0700
> >
> >     rcu-tasks: Add printk()s to localize boot-time self-test hang
> >
> >     Currently, rcu_tasks_initiate_self_tests() prints a message and
> >   then
> >
> >     initiates self tests on up to three different RCU Tasks flavors.
> >   If one
> >
> >     of the flavors has a grace-period hang, it is not easy to work out
> >   which
> >
> >     of the three hung.  This commit therefore prints a message prior
> >   to each
> >
> >     individual test.
> >
> >     Reported-by: Guenter Roeck <linux@roeck-us.net>
> >
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >   diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >
> >   index 56c470a489c8..427433c90935 100644
> >
> >   --- a/kernel/rcu/tasks.h
> >
> >   +++ b/kernel/rcu/tasks.h
> >
> >   @@ -1981,20 +1981,22 @@ static void test_rcu_tasks_callback(struct
> >   rcu_head *rhp)
> >
> >   static void rcu_tasks_initiate_self_tests(void)
> >
> >   {
> >
> >   -    pr_info("Running RCU-tasks wait API self tests\n");
> >
> >   #ifdef CONFIG_TASKS_RCU
> >
> >   +    pr_info("Running RCU Tasks wait API self tests\n");
> >
> >     tests[0].runstart =3D jiffies;
> >
> >     synchronize_rcu_tasks();
> >
> >     call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> >
> >   #endif
> >
> >   #ifdef CONFIG_TASKS_RUDE_RCU
> >
> >   +    pr_info("Running RCU Tasks Rude wait API self tests\n");
> >
> >     tests[1].runstart =3D jiffies;
> >
> >     synchronize_rcu_tasks_rude();
> >
> >     call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
> >
> >   #endif
> >
> >   #ifdef CONFIG_TASKS_TRACE_RCU
> >
> >   +    pr_info("Running RCU Tasks Trace wait API self tests\n");
> >
> >     tests[2].runstart =3D jiffies;
> >
> >     synchronize_rcu_tasks_trace();
> >
> >     call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
> >
> >References
> >
> > Visible links:
> > 1. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.=
15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.0=
7.28-04.00.44/
> > 2. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.=
15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.0=
7.28-04.00.44/
> > 3. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.=
15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.0=
7.28-04.00.44/
> >
> > Hidden links:
> > 5. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.=
15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.0=
7.28-04.00.44/
