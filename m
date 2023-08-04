Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BD76FA30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjHDGgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjHDGgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:36:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07349D6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:36:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68783b2e40bso1233496b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691130993; x=1691735793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0fil/ay504EfjcdWFREMD3U7F+7l/jraDTXT6w75DQ=;
        b=BJpJvAmOYCxWBDBW91TmeILmfv16LSN4o3X/tVVWCbADvEticbmzbdHwmhvFFI0tzP
         w4PPopOclvok3MUQTd3B+ZRw5HSYU4ipl0mJMqLWWLk73MIw2Kvd0c9EKKYxNhjG7QVJ
         A/FxKGgllTL+15SV3wqcvlxWr2ZZ5Juk8l9Ub0qmfFs4sQRBfL8zqB/Acqp0sR2eXCga
         0JFRWMgEXoTBhwa+WRsZnTpqdJ6AVlH1vs146d4Ogjm6BCgvVob6kPvC0WjWYqkYmsNE
         vmM3xJ8NNnKQsIIBxwq6oPfIEykxDjQlP/c04qzwpdX7uLmCUpS08Ip88cgpNlD/8vbi
         hPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691130993; x=1691735793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0fil/ay504EfjcdWFREMD3U7F+7l/jraDTXT6w75DQ=;
        b=kIHed2n51x6qQBpVaSUDI8IHReG6Dgj3Vo1HP0E7asBAbVDFzHPIjOFPDEi1ep0H+F
         wW0naXlcXECoO5G+ja1se1qC5Sv80cLJUTT5mSD0QNWvuRY2Rg5MFpjdDrWO8XxcB+MC
         9a+OdHtqHNyiuiPP+kcoTN9e7dyAkJ1dRdq97TUPCz+zlpkrSavqDmzs22i7jLu86HE+
         dJpYtdP3lyNmmXq99iI+88JExIVF6MgZ0IjA9szigVb0tTnxx5D6qiSS2gmNupf0Y4Ls
         Yph3AiI6rHVZ/tC9xRAKmRlGbci2ofU0+qJ44lqmDw/omPStmxA7YZcZkmOl3OP/eDtb
         rxVA==
X-Gm-Message-State: AOJu0YyRwaVao48Y/xyjga///o5rGdHw2nmm0/kSfsK1B8G3QHtrUPBa
        FzdGizRjewutpKxgI/3AauP/jGTzh3dAPQ==
X-Google-Smtp-Source: AGHT+IEZGXjGXsR9qbt90/LIDV8TJFV6MLNaW615Y3f98NtgsknjXYzep8cr297zaDqpya8rCwL2vg==
X-Received: by 2002:aa7:8884:0:b0:682:a6bd:e952 with SMTP id z4-20020aa78884000000b00682a6bde952mr883561pfe.6.1691130993277;
        Thu, 03 Aug 2023 23:36:33 -0700 (PDT)
Received: from haorong.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id a18-20020aa780d2000000b00682bec0b680sm848424pfn.89.2023.08.03.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 23:36:32 -0700 (PDT)
Date:   Thu, 3 Aug 2023 23:36:30 -0700
From:   Haorong Lu <ancientmodern4@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mathis Salmen <mathis.salmen@matsal.de>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: signal: handle syscall restart before get_signal
Message-ID: <ZMycbvkIgNA9b7n2@haorong.ba.rivosinc.com>
References: <20230803224458.4156006-1-ancientmodern4@gmail.com>
 <CAJF2gTR+-pBXLsEQM7srOyLyXXpTHRQmDjAaZfkXScFMjhpJhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTR+-pBXLsEQM7srOyLyXXpTHRQmDjAaZfkXScFMjhpJhQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 09:08:53AM +0800, Guo Ren wrote:
> On Fri, Aug 4, 2023 at 6:45 AM Haorong Lu <ancientmodern4@gmail.com> wrote:
> >
> > In the current riscv implementation, blocking syscalls like read() may
> > not correctly restart after being interrupted by ptrace. This problem
> > arises when the syscall restart process in arch_do_signal_or_restart()
> > is bypassed due to changes to the regs->cause register, such as an
> > ebreak instruction.
> >
> > Steps to reproduce:
> > 1. Interrupt the tracee process with PTRACE_SEIZE & PTRACE_INTERRUPT.
> > 2. Backup original registers and instruction at new_pc.
> > 3. Change pc to new_pc, and inject an instruction (like ebreak) to this
> >    address.
> > 4. Resume with PTRACE_CONT and wait for the process to stop again after
> >    executing ebreak.
> > 5. Restore original registers and instructions, and detach from the
> >    tracee process.
> > 6. Now the read() syscall in tracee will return -1 with errno set to
> >    ERESTARTSYS.
> >
> > Specifically, during an interrupt, the regs->cause changes from
> > EXC_SYSCALL to EXC_BREAKPOINT due to the injected ebreak, which is
> > inaccessible via ptrace so we cannot restore it. This alteration breaks
> > the syscall restart condition and ends the read() syscall with an
> > ERESTARTSYS error. According to include/linux/errno.h, it should never
> > be seen by user programs. X86 can avoid this issue as it checks the
> > syscall condition using a register (orig_ax) exposed to user space.
> > Arm64 handles syscall restart before calling get_signal, where it could
> > be paused and inspected by ptrace/debugger.
> >
> > This patch adjusts the riscv implementation to arm64 style, which also
> > checks syscall using a kernel register (syscallno). It ensures the
> > syscall restart process is not bypassed when changes to the cause
> > register occur, providing more consistent behavior across various
> > architectures.
> >
> > For a simplified reproduction program, feel free to visit:
> > https://github.com/ancientmodern/riscv-ptrace-bug-demo.
> >
> > Signed-off-by: Haorong Lu <ancientmodern4@gmail.com>
> > ---
> >  arch/riscv/kernel/signal.c | 85 +++++++++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 39 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> > index 180d951d3624..d2d7169048ea 100644
> > --- a/arch/riscv/kernel/signal.c
> > +++ b/arch/riscv/kernel/signal.c
> > @@ -391,30 +391,6 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
> >         sigset_t *oldset = sigmask_to_save();
> >         int ret;
> >
> > -       /* Are we from a system call? */
> > -       if (regs->cause == EXC_SYSCALL) {
> > -               /* Avoid additional syscall restarting via ret_from_exception */
> > -               regs->cause = -1UL;
> > -               /* If so, check system call restarting.. */
> > -               switch (regs->a0) {
> > -               case -ERESTART_RESTARTBLOCK:
> > -               case -ERESTARTNOHAND:
> > -                       regs->a0 = -EINTR;
> > -                       break;
> > -
> > -               case -ERESTARTSYS:
> > -                       if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
> > -                               regs->a0 = -EINTR;
> > -                               break;
> > -                       }
> > -                       fallthrough;
> > -               case -ERESTARTNOINTR:
> > -                        regs->a0 = regs->orig_a0;
> > -                       regs->epc -= 0x4;
> > -                       break;
> > -               }
> > -       }
> > -
> >         rseq_signal_deliver(ksig, regs);
> >
> >         /* Set up the stack frame */
> > @@ -428,35 +404,66 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
> >
> >  void arch_do_signal_or_restart(struct pt_regs *regs)
> >  {
> > +       unsigned long continue_addr = 0, restart_addr = 0;
> > +       int retval = 0;
> >         struct ksignal ksig;
> > +       bool syscall = (regs->cause == EXC_SYSCALL);
> >
> > -       if (get_signal(&ksig)) {
> > -               /* Actually deliver the signal */
> > -               handle_signal(&ksig, regs);
> > -               return;
> > -       }
> > +       /* If we were from a system call, check for system call restarting */
> > +       if (syscall) {
> > +               continue_addr = regs->epc;
> > +               restart_addr = continue_addr - 4;
> > +               retval = regs->a0;
> >
> > -       /* Did we come from a system call? */
> > -       if (regs->cause == EXC_SYSCALL) {
> >                 /* Avoid additional syscall restarting via ret_from_exception */
> >                 regs->cause = -1UL;
> >
> > -               /* Restart the system call - no handlers present */
> > -               switch (regs->a0) {
> > +               /*
> > +                * Prepare for system call restart. We do this here so that a
> > +                * debugger will see the already changed PC.
> > +                */
> > +               switch (retval) {
> >                 case -ERESTARTNOHAND:
> >                 case -ERESTARTSYS:
> >                 case -ERESTARTNOINTR:
> > -                        regs->a0 = regs->orig_a0;
> > -                       regs->epc -= 0x4;
> > -                       break;
> >                 case -ERESTART_RESTARTBLOCK:
> > -                        regs->a0 = regs->orig_a0;
> > -                       regs->a7 = __NR_restart_syscall;
> > -                       regs->epc -= 0x4;
> > +                       regs->a0 = regs->orig_a0;
> > +                       regs->epc = restart_addr;
> >                         break;
> >                 }
> >         }
> >
> > +       /*
> > +        * Get the signal to deliver. When running under ptrace, at this point
> > +        * the debugger may change all of our registers.
> > +        */
> > +       if (get_signal(&ksig)) {
> > +               /*
> > +                * Depending on the signal settings, we may need to revert the
> > +                * decision to restart the system call, but skip this if a
> > +                * debugger has chosen to restart at a different PC.
> > +                */
> > +               if (regs->epc == restart_addr &&
> > +                   (retval == -ERESTARTNOHAND ||
> > +                    retval == -ERESTART_RESTARTBLOCK ||
> > +                    (retval == -ERESTARTSYS &&
> > +                     !(ksig.ka.sa.sa_flags & SA_RESTART)))) {
> > +                       regs->a0 = -EINTR;
> > +                       regs->epc = continue_addr;
> > +               }
> > +
> > +               /* Actually deliver the signal */
> > +               handle_signal(&ksig, regs);
> > +               return;
> > +       }
> > +
> > +       /*
> > +        * Handle restarting a different system call. As above, if a debugger
> > +        * has chosen to restart at a different PC, ignore the restart.
> > +        */
> > +       if (syscall && regs->epc == restart_addr && retval == -ERESTART_RESTARTBLOCK)
> > +               regs->a7 = __NR_restart_syscall;
> > +
> I thought your patch contains two parts:
> 1. bugfix
> 2. Some coding conventions or adjusting some logic of the original signal.
> 
> Could we separate them into two pieces and make the bugfix one
> minimalistic? Then, people could easier to review your patches.

Hi Guo, thanks for your feedback!

AFAIU modifying logic of these two functions are the means to fix this
bug. These changes should not affect specific signals as they merely
invert the order of handling (syscall restart && pending signals).

Since syscall restart involves many different conditions, providing a
minimal bugfix could be hard and might introduce other issues. And 
actually there is not too many changes:

- move syscall restatrt before get_signal to prevent it being bypassed
  when regs->cause has been changed

- simplify duplicated ERESTARTSYS hanlder in handle_signal to a small
  "if branch" between get_signal and handle_signal

I met this bug accidentally when developing riscv version of a user-
space checkpoint/restore tool. Frankly, I'm fairly new to this area.
Interested to see if there're better solutions to this :)

Best,
Haorong

> 
> >         /*
> >          * If there is no signal to deliver, we just put the saved
> >          * sigmask back.
> > --
> > 2.41.0
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
