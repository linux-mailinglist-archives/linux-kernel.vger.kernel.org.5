Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A077D8408
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbjJZN5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjJZN5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:57:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC810E9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:56:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so695633a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698328616; x=1698933416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcb5hCmOPF2OqkJ0FwSig4b2YnEFiQUNRhF2Rx+5vEY=;
        b=KvhcujXbFyg/Rv8Q5Px0bgmSd5YAvO6BUmbd5fgsLsVYCJqdgpGnbsQCZG7ccK8cvy
         Q6jh0W5tt3M6KB3NwjUs/RN6oaaFbPJkjT8KLtUF78oW8LBsR/ZJ1RDiDBaVadPsI6k+
         WMou4XRrsBy2KxU3ke2s6citdCN97zcHDkYm6R9WZT0LWDAzc/AlFhIX4/dkdOa2GDqN
         a10dk72lqFeTEuK8JZGCY5rjopL8XvkxEn3RJ/FlBel0XKgdqQhMFfJvbV8fdEpxGeF8
         M3GrOLD+aEZ0gbasZj5Yz+yON7xX2wTOlExY2+ZTuywFsQ6h73StGA3I+pNCzk3X+KgY
         aJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328616; x=1698933416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcb5hCmOPF2OqkJ0FwSig4b2YnEFiQUNRhF2Rx+5vEY=;
        b=o3bQcQapv8MqjuwDZGj2O7g8nacto3uxG6JRhWt7sxfNrASVNKJcfPemfDLFOGRTZe
         kJ/bPis9n/RAxnzEY6to1BvD54oIKhBqCmF+M2vu+Pik5/pJzTInPEnd8v36UmBben5S
         IddTCwkH6IMk1Lklm84IfX5amFHc5kVeoXWoZ7bXLH3l0YzsGaW4/p0hRsnUiZ0gX6AH
         MhEvu4ZVNKrtTAryd0yu/kPoVpaMsZLMnZ3MamcqwOItfpDEy2x6VhTFVEtuiSpx1p3X
         4cXLB/XUQ2P1LK4bf0ExT5ZE0Pn70+Zi4Uk8I86rMOaCfzJjjfIGzmYrWMCWlOKtTZON
         iDgA==
X-Gm-Message-State: AOJu0YwknnIAxuPfeW+PzVv48VTdBEwkY9sGaEqLn6XJTrh/Zmwm9env
        mdOPxl/3VPyqg1SPdyYgYm/uXTFsI05rld3C7Y6Qhg==
X-Google-Smtp-Source: AGHT+IEs0aNayRqtx/g9rMBMY9etWzPiCR1YOkgL4U3HIWllDDz/z+zVVuHJUp7JUorhVL/kIRfJCjjwBBQGHtZfjuM=
X-Received: by 2002:a17:90a:fd10:b0:27d:428e:3102 with SMTP id
 cv16-20020a17090afd1000b0027d428e3102mr15015021pjb.44.1698328616577; Thu, 26
 Oct 2023 06:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231023082911.23242-1-luxu.kernel@bytedance.com> <CAOnJCUKH0muFHWujXEqJtb4Uv6Kfh5DeJeR2qg9vj7Kc5w43dw@mail.gmail.com>
In-Reply-To: <CAOnJCUKH0muFHWujXEqJtb4Uv6Kfh5DeJeR2qg9vj7Kc5w43dw@mail.gmail.com>
From:   Xu Lu <luxu.kernel@bytedance.com>
Date:   Thu, 26 Oct 2023 21:56:45 +0800
Message-ID: <CAPYmKFuNr18_jJYZ6X4Rrty=bU0cXiuHpAqSt2+YqDWV6rAveg@mail.gmail.com>
Subject: Re: [External] Re: [RFC 00/12] riscv: Introduce Pseudo NMI
To:     Atish Patra <atishp@atishpatra.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, dengliang.1214@bytedance.com,
        liyu.yukiteru@bytedance.com, sunjiadong.lff@bytedance.com,
        xieyongji@bytedance.com, lihangjing@bytedance.com,
        chaiwen.cc@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 7:02=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Mon, Oct 23, 2023 at 1:29=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com>=
 wrote:
> >
> > Sorry to resend this patch series as I forgot to Cc the open list befor=
e.
> > Below is formal content.
> >
> > The existing RISC-V kernel lacks an NMI mechanism as there is still no
> > ratified resumable NMI extension in RISC-V community, which can not
> > satisfy some scenarios like high precision perf sampling. There is an
> > incoming hardware extension called Smrnmi which supports resumable NMI
> > by providing new control registers to save status when NMI happens.
> > However, it is still a draft and requires privilege level switches for
> > kernel to utilize it as NMIs are automatically trapped into machine mod=
e.
> >
> > This patch series introduces a software pseudo NMI mechanism in RISC-V.
> > The existing RISC-V kernel disables interrupts via per cpu control
> > register CSR_STATUS, the SIE bit of which controls the enablement of al=
l
> > interrupts of whole cpu. When SIE bit is clear, no interrupt is enabled=
.
> > This patch series implements NMI by switching interrupt disable way to
> > another per cpu control register CSR_IE. This register controls the
> > enablement of each separate interrupt. Each bit of CSR_IE corresponds
> > to a single major interrupt and a clear bit means disablement of
> > corresponding interrupt.
> >
> > To implement pseudo NMI, we switch to CSR_IE masking when disabling
> > irqs. When interrupts are disabled, all bits of CSR_IE corresponding to
> > normal interrupts are cleared while bits corresponding to NMIs are stil=
l
> > kept as ones. The SIE bit of CSR_STATUS is now untouched and always kep=
t
> > as one.
> >
> > We measured performacne of Pseudo NMI patches based on v6.6-rc4 on SiFi=
ve
> > FU740 Soc with hackbench as our benchmark. The result shows 1.90%
> > performance degradation.
> >
> >   "hackbench 200 process 1000" (average over 10 runs)
> >   +-----------+----------+------------+
> >   |           | v6.6-rc4 | Pseudo NMI |
> >   +-----------+----------+------------+
> >   |   time    | 251.646s |  256.416s  |
> >   +-----------+----------+------------+
> >
> > The overhead mainly comes from two parts:
> >
> >   1. Saving and restoring CSR_IE register during kernel entry/return.
> >   This part introduces about 0.57% performance overhead.
> >
> >   2. The extra instructions introduced by 'irqs_enabled_ie'. It is a
> >   special value representing normal CSR_IE when irqs are enabled. It is
> >   implemented via ALTERNATIVE to adapt to platforms without PMU. This
> >   part introduces about 1.32% performance overhead.
> >
>
> We had an evaluation of this approach earlier this year and concluded
> with the similar findings.
> The pseudo NMI is only useful for profiling use case which doesn't
> happen all the time in the system
> Adding the cost to the hotpath and sacrificing performance for
> everything for something for performance profiling
> is not desirable at all.

Thanks a lot for your reply!

First, please allow me to explain that CSR_IE Pseudo NMI actually can suppo=
rt
more than PMU profiling. For example, if we choose to make external major
interrupt as NMI and use ithreshold or eithreshold in AIA to control which =
minor
external interrupts can be sent to CPU, then we actually can support multip=
le
minor interrupts as NMI while keeping the other minor interrupts still
normal irqs.
This is what we are working on now.

Also, if we take virtualization scenarios into account, CSR_IE Pseudo NMI c=
an
support NMI passthrough to VM without too much effort from hypervisor, if o=
nly
corresponding interrupt can be delegated to VS-mode. I wonder if SSE suppor=
ts
interrupt passthrough to VM?

>
> That's why, an SBI extension Supervisor Software Events (SSE) is under
> development.
> https://lists.riscv.org/g/tech-prs/message/515
>
> Instead of selective disabling of interrupts, SSE takes an orthogonal
> approach where M-mode would invoke a special trap
> handler. That special handler will invoke the driver specific handler
> which would be registered by the driver (i.e. perf driver)
> This covers both firmware first RAS and perf use cases.
>
> The above version of the specification is a bit out-of-date and the
> revised version will be sent soon.
> Clement(cc'd) has also done a PoC of SSE and perf driver using the SSE
> framework. This resulted in actual saving
> in performance for RAS/perf without sacrificing the normal performance.
>
> Clement is planning to send the series soon with more details.

The SSE extension you mentioned is a brilliant design and does solve a lot =
of
problems!

We have considered implementing NMI via SBI calls before. The main problem
is that if a driver using NMI needs to cooperate with SBI code, extra
coupling will
be introduced as the driver vendor and firmware vendor may not be the same =
one.
We think perhaps it is better to keep SBI code as simple and stable as poss=
ible.

Please correct me if there is any misunderstanding.

Thanks again and looking forward to your reply.

>
> > Limits:
> >
> >   CSR_IE is now used for disabling irqs and any other code should
> >   not touch this register to avoid corrupting irq status, which means
> >   we do not support masking a single interrupt now.
> >
> >   We have tried to fix this by introducing a per cpu variable to save
> >   CSR_IE value when disabling irqs. Then all operatations on CSR_IE
> >   will be redirected to this variable and CSR_IE's value will be
> >   restored from this variable when enabling irqs. Obviously this method
> >   introduces extra memory accesses in hot code path.
> >
>
>
>
> > TODO:
> >
> >   1. The adaption to hypervisor extension is ongoing.
> >
> >   2. The adaption to advanced interrupt architecture is ongoing.
> >
> > This version of Pseudo NMI is rebased on v6.6-rc7.
> >
> > Thanks in advance for comments.
> >
> > Xu Lu (12):
> >   riscv: Introduce CONFIG_RISCV_PSEUDO_NMI
> >   riscv: Make CSR_IE register part of context
> >   riscv: Switch to CSR_IE masking when disabling irqs
> >   riscv: Switch back to CSR_STATUS masking when going idle
> >   riscv: kvm: Switch back to CSR_STATUS masking when entering guest
> >   riscv: Allow requesting irq as pseudo NMI
> >   riscv: Handle pseudo NMI in arch irq handler
> >   riscv: Enable NMIs during irqs disabled context
> >   riscv: Enable NMIs during exceptions
> >   riscv: Enable NMIs during interrupt handling
> >   riscv: Request pmu overflow interrupt as NMI
> >   riscv: Enable CONFIG_RISCV_PSEUDO_NMI in default
> >
> >  arch/riscv/Kconfig                 | 10 ++++
> >  arch/riscv/include/asm/csr.h       | 17 ++++++
> >  arch/riscv/include/asm/irqflags.h  | 91 ++++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/processor.h |  4 ++
> >  arch/riscv/include/asm/ptrace.h    |  7 +++
> >  arch/riscv/include/asm/switch_to.h |  7 +++
> >  arch/riscv/kernel/asm-offsets.c    |  3 +
> >  arch/riscv/kernel/entry.S          | 18 ++++++
> >  arch/riscv/kernel/head.S           | 10 ++++
> >  arch/riscv/kernel/irq.c            | 17 ++++++
> >  arch/riscv/kernel/process.c        |  6 ++
> >  arch/riscv/kernel/suspend_entry.S  |  1 +
> >  arch/riscv/kernel/traps.c          | 54 ++++++++++++++----
> >  arch/riscv/kvm/vcpu.c              | 18 ++++--
> >  drivers/clocksource/timer-clint.c  |  4 ++
> >  drivers/clocksource/timer-riscv.c  |  4 ++
> >  drivers/irqchip/irq-riscv-intc.c   | 66 ++++++++++++++++++++++
> >  drivers/perf/riscv_pmu_sbi.c       | 21 ++++++-
> >  18 files changed, 340 insertions(+), 18 deletions(-)
> >
> > --
> > 2.20.1
> >
>
>
> --
> Regards,
> Atish
