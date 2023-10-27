Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9965A7D8FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0Hdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0Hdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:33:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DE116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:33:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578b4981526so1448958a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698392026; x=1698996826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v4aKVUmZEJXqE3Dgyye9qe1xErv8gH+qC4+xzfDdXg=;
        b=Yv3V6IEBXH+Mj6J5EfyuyRO/Bx4PZzr2umOsUxi1JboBpZy7v7UP+cO8JI+P5+cjg8
         xMWN87sfvGP/TPycVdaYfPhet5TLbMMNydaAQ+E4C5oGrmRea4Yv5BoARoh9AQ8sbTOn
         WZqKd8pfekf6n9/WNJtBxqPioIEQGWmrFM3mGJjVClgiSkt2SaRR1BzpA0JE5R9YHbZ4
         A1LB0s/n3wa4mdLMhZIbJCsBIvZirM/UCnm3hvLmfobykdl9mbINhNtCr1RyKO0NUn6D
         95FxcRUR71IiD1017TPd3N9cb9EEZG5ujIuyEYSxYBIyHZGwcUsCIxRPbkxADEGTvA96
         TmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698392026; x=1698996826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v4aKVUmZEJXqE3Dgyye9qe1xErv8gH+qC4+xzfDdXg=;
        b=ZHnhcgsyd4FhA2D1SsaSIUzxP7LHfuGTewhN6Q5I3vD1PVvAKkhA3EpYmP8OBXwBup
         /7xXgGPd4ey2GAA1P4SQ+cDakOSvVMzh5+UQmbXwNjiOgEnY+W3gfrX+jgQPfFZh2dJA
         CLIkn6A8pLablSAc6AkCzbeR+eTrZV+dWYyxDQjBXB/MiKzbA9Wmcb6omXI8UupE9CNP
         H2yj8zsWOnYvuaIWKGKq7UKbwXhYWupF8MdwXN6n4jXceJ7tSRbI2Pp2uesRI6WoVybQ
         lt3+ToyIvZ/HNSl5gfFFwwyjM981HviXKbem0J1+et6atBwJPckjFMhQipBB6CILq8R2
         txmg==
X-Gm-Message-State: AOJu0Yxz/OquU1Brvoe788UhxkeYKVqDzlS1P+kxwv3xVF+emBydV1Sl
        pItwKPYqBrtNaKTb+0HB33H0ZcbBdUxC3QQcuj5vIw==
X-Google-Smtp-Source: AGHT+IFho3fxu17k6Hf2i/nGqfNVxIjvdxlkP5e7jX5m9GXIcIoLNfNwkRmuSFWbfEVF0iKMJwSt7/UHQeIqBBeoot8=
X-Received: by 2002:a17:90a:3c86:b0:27d:6d9c:6959 with SMTP id
 g6-20020a17090a3c8600b0027d6d9c6959mr1742120pjc.25.1698392026187; Fri, 27 Oct
 2023 00:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
 <CAOnJCUKH0muFHWujXEqJtb4Uv6Kfh5DeJeR2qg9vj7Kc5w43dw@mail.gmail.com>
 <CAPYmKFuNr18_jJYZ6X4Rrty=bU0cXiuHpAqSt2+YqDWV6rAveg@mail.gmail.com> <CAOnJCU+dn5b1N_NOjODKBa8GKNC2XTyRvsECk_VFFO1U3pdOdQ@mail.gmail.com>
In-Reply-To: <CAOnJCU+dn5b1N_NOjODKBa8GKNC2XTyRvsECk_VFFO1U3pdOdQ@mail.gmail.com>
From:   Xu Lu <luxu.kernel@bytedance.com>
Date:   Fri, 27 Oct 2023 15:33:34 +0800
Message-ID: <CAPYmKFvOhmxixGDwYGjjQVhwhd6PbeiMpJrJD+9VLWLFJS8y2w@mail.gmail.com>
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

On Fri, Oct 27, 2023 at 3:42=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Thu, Oct 26, 2023 at 6:56=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com>=
 wrote:
> >
> > On Thu, Oct 26, 2023 at 7:02=E2=80=AFAM Atish Patra <atishp@atishpatra.=
org> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 1:29=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.=
com> wrote:
> > > >
> > > > Sorry to resend this patch series as I forgot to Cc the open list b=
efore.
> > > > Below is formal content.
> > > >
> > > > The existing RISC-V kernel lacks an NMI mechanism as there is still=
 no
> > > > ratified resumable NMI extension in RISC-V community, which can not
> > > > satisfy some scenarios like high precision perf sampling. There is =
an
> > > > incoming hardware extension called Smrnmi which supports resumable =
NMI
> > > > by providing new control registers to save status when NMI happens.
> > > > However, it is still a draft and requires privilege level switches =
for
> > > > kernel to utilize it as NMIs are automatically trapped into machine=
 mode.
> > > >
> > > > This patch series introduces a software pseudo NMI mechanism in RIS=
C-V.
> > > > The existing RISC-V kernel disables interrupts via per cpu control
> > > > register CSR_STATUS, the SIE bit of which controls the enablement o=
f all
> > > > interrupts of whole cpu. When SIE bit is clear, no interrupt is ena=
bled.
> > > > This patch series implements NMI by switching interrupt disable way=
 to
> > > > another per cpu control register CSR_IE. This register controls the
> > > > enablement of each separate interrupt. Each bit of CSR_IE correspon=
ds
> > > > to a single major interrupt and a clear bit means disablement of
> > > > corresponding interrupt.
> > > >
> > > > To implement pseudo NMI, we switch to CSR_IE masking when disabling
> > > > irqs. When interrupts are disabled, all bits of CSR_IE correspondin=
g to
> > > > normal interrupts are cleared while bits corresponding to NMIs are =
still
> > > > kept as ones. The SIE bit of CSR_STATUS is now untouched and always=
 kept
> > > > as one.
> > > >
> > > > We measured performacne of Pseudo NMI patches based on v6.6-rc4 on =
SiFive
> > > > FU740 Soc with hackbench as our benchmark. The result shows 1.90%
> > > > performance degradation.
> > > >
> > > >   "hackbench 200 process 1000" (average over 10 runs)
> > > >   +-----------+----------+------------+
> > > >   |           | v6.6-rc4 | Pseudo NMI |
> > > >   +-----------+----------+------------+
> > > >   |   time    | 251.646s |  256.416s  |
> > > >   +-----------+----------+------------+
> > > >
> > > > The overhead mainly comes from two parts:
> > > >
> > > >   1. Saving and restoring CSR_IE register during kernel entry/retur=
n.
> > > >   This part introduces about 0.57% performance overhead.
> > > >
> > > >   2. The extra instructions introduced by 'irqs_enabled_ie'. It is =
a
> > > >   special value representing normal CSR_IE when irqs are enabled. I=
t is
> > > >   implemented via ALTERNATIVE to adapt to platforms without PMU. Th=
is
> > > >   part introduces about 1.32% performance overhead.
> > > >
> > >
> > > We had an evaluation of this approach earlier this year and concluded
> > > with the similar findings.
> > > The pseudo NMI is only useful for profiling use case which doesn't
> > > happen all the time in the system
> > > Adding the cost to the hotpath and sacrificing performance for
> > > everything for something for performance profiling
> > > is not desirable at all.
> >
> > Thanks a lot for your reply!
> >
> > First, please allow me to explain that CSR_IE Pseudo NMI actually can s=
upport
> > more than PMU profiling. For example, if we choose to make external maj=
or
> > interrupt as NMI and use ithreshold or eithreshold in AIA to control wh=
ich minor
> > external interrupts can be sent to CPU, then we actually can support mu=
ltiple
> > minor interrupts as NMI while keeping the other minor interrupts still
> > normal irqs.
> > This is what we are working on now.
> >
>
> What's the use case for external interrupts to behave as NMI ?
>
> Note: You can do the same thing with SSE as well if required. But I
> want to understand the
> use case first.

For example, some high precision event devices designed as timer or
watchdog devices (please refer to [1][2]) which may not be per cpu.

[1] https://lwn.net/Articles/924927/
[2] https://lore.kernel.org/lkml/1445961999-9506-1-git-send-email-fu.wei@li=
naro.org/T/

>
> > Also, if we take virtualization scenarios into account, CSR_IE Pseudo N=
MI can
> > support NMI passthrough to VM without too much effort from hypervisor, =
if only
> > corresponding interrupt can be delegated to VS-mode. I wonder if SSE su=
pports
> > interrupt passthrough to VM?
> >
>
> Not technically interrupt pass through but hypervisor can invoke the
> guest SSE handler
> with the same mechanism. In fact, the original proposal specifies the
> async page fault
> as another use case for SSE.
>
> > >
> > > That's why, an SBI extension Supervisor Software Events (SSE) is unde=
r
> > > development.
> > > https://lists.riscv.org/g/tech-prs/message/515
> > >
> > > Instead of selective disabling of interrupts, SSE takes an orthogonal
> > > approach where M-mode would invoke a special trap
> > > handler. That special handler will invoke the driver specific handler
> > > which would be registered by the driver (i.e. perf driver)
> > > This covers both firmware first RAS and perf use cases.
> > >
> > > The above version of the specification is a bit out-of-date and the
> > > revised version will be sent soon.
> > > Clement(cc'd) has also done a PoC of SSE and perf driver using the SS=
E
> > > framework. This resulted in actual saving
> > > in performance for RAS/perf without sacrificing the normal performanc=
e.
> > >
> > > Clement is planning to send the series soon with more details.
> >
> > The SSE extension you mentioned is a brilliant design and does solve a =
lot of
> > problems!
> >
> > We have considered implementing NMI via SBI calls before. The main prob=
lem
> > is that if a driver using NMI needs to cooperate with SBI code, extra
> > coupling will
> > be introduced as the driver vendor and firmware vendor may not be the s=
ame one.
> > We think perhaps it is better to keep SBI code as simple and stable as =
possible.
> >
>
> Yes. However, we also gain significant performance while we have a 2%
> regression with
> current pseudo-NMI approach. Quoting the numbers from SSE series[1]:
>
> "Additionally, SSE event handling is faster that the
> standard IRQ handling path with almost half executed instruction (700 vs
> 1590). Some complementary tests/perf measurements will be done."

I think maybe there are two more issues to be considered.

1) The instructions may increase as the supported event ids increases.
More instructions will be introduced to maintain the mapping between
event id and handler_context. Besides, some security check is needed
to avoid the fact that the physical address passed by S-mode software
does not belong to it (for example, the address may belong to an
enclave).

2) I am wondering whether the control flow from user thread -> M-mode
-> S-mode -> M-mode -> user thread will sacrifice locality and cause
more cache misses.

Looking forward to your more measurements!

>
> Major infrastructure development is one time effort. Adding additional
> sources of SSE effort will be minimal once
> the framework is in place. The SSE extension is still in draft stage
> and can accomodate any other use case
> that you may have in mind. IMHO, it would better to define one
> performant mechanism to solve the high priority
> interrupt use case.

I am concerned that every time a new event id is added, both the SBI
and driver code need to be modified simultaneously, which may increase
coupling and complexity.

Regards,

Xu Lu.

>
> [1] https://www.spinics.net/lists/kernel/msg4982224.html
> > Please correct me if there is any misunderstanding.
> >
> > Thanks again and looking forward to your reply.
> >
> > >
> > > > Limits:
> > > >
> > > >   CSR_IE is now used for disabling irqs and any other code should
> > > >   not touch this register to avoid corrupting irq status, which mea=
ns
> > > >   we do not support masking a single interrupt now.
> > > >
> > > >   We have tried to fix this by introducing a per cpu variable to sa=
ve
> > > >   CSR_IE value when disabling irqs. Then all operatations on CSR_IE
> > > >   will be redirected to this variable and CSR_IE's value will be
> > > >   restored from this variable when enabling irqs. Obviously this me=
thod
> > > >   introduces extra memory accesses in hot code path.
> > > >
> > >
> > >
> > >
> > > > TODO:
> > > >
> > > >   1. The adaption to hypervisor extension is ongoing.
> > > >
> > > >   2. The adaption to advanced interrupt architecture is ongoing.
> > > >
> > > > This version of Pseudo NMI is rebased on v6.6-rc7.
> > > >
> > > > Thanks in advance for comments.
> > > >
> > > > Xu Lu (12):
> > > >   riscv: Introduce CONFIG_RISCV_PSEUDO_NMI
> > > >   riscv: Make CSR_IE register part of context
> > > >   riscv: Switch to CSR_IE masking when disabling irqs
> > > >   riscv: Switch back to CSR_STATUS masking when going idle
> > > >   riscv: kvm: Switch back to CSR_STATUS masking when entering guest
> > > >   riscv: Allow requesting irq as pseudo NMI
> > > >   riscv: Handle pseudo NMI in arch irq handler
> > > >   riscv: Enable NMIs during irqs disabled context
> > > >   riscv: Enable NMIs during exceptions
> > > >   riscv: Enable NMIs during interrupt handling
> > > >   riscv: Request pmu overflow interrupt as NMI
> > > >   riscv: Enable CONFIG_RISCV_PSEUDO_NMI in default
> > > >
> > > >  arch/riscv/Kconfig                 | 10 ++++
> > > >  arch/riscv/include/asm/csr.h       | 17 ++++++
> > > >  arch/riscv/include/asm/irqflags.h  | 91 ++++++++++++++++++++++++++=
++++
> > > >  arch/riscv/include/asm/processor.h |  4 ++
> > > >  arch/riscv/include/asm/ptrace.h    |  7 +++
> > > >  arch/riscv/include/asm/switch_to.h |  7 +++
> > > >  arch/riscv/kernel/asm-offsets.c    |  3 +
> > > >  arch/riscv/kernel/entry.S          | 18 ++++++
> > > >  arch/riscv/kernel/head.S           | 10 ++++
> > > >  arch/riscv/kernel/irq.c            | 17 ++++++
> > > >  arch/riscv/kernel/process.c        |  6 ++
> > > >  arch/riscv/kernel/suspend_entry.S  |  1 +
> > > >  arch/riscv/kernel/traps.c          | 54 ++++++++++++++----
> > > >  arch/riscv/kvm/vcpu.c              | 18 ++++--
> > > >  drivers/clocksource/timer-clint.c  |  4 ++
> > > >  drivers/clocksource/timer-riscv.c  |  4 ++
> > > >  drivers/irqchip/irq-riscv-intc.c   | 66 ++++++++++++++++++++++
> > > >  drivers/perf/riscv_pmu_sbi.c       | 21 ++++++-
> > > >  18 files changed, 340 insertions(+), 18 deletions(-)
> > > >
> > > > --
> > > > 2.20.1
> > > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish
>
>
>
> --
> Regards,
> Atish
