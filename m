Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61278EE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjHaNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjHaNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:16:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B671A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:16:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bd3317144fso666924a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693487812; x=1694092612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv6vlTMJy2ho8geEqPUuJ2REKrug7GrLSZ8XpNgzcaA=;
        b=A2JZY0xa1vyX9ulNoQLF6c/L8xe3CzgFEM91LZWXjHm03i3b8kQti8U+pZjYlpKfb0
         i4541kP5eWYBTplk0UD2Hwsii6pPvWxWux6UxYNG+vbGymyr7JwSwFY3SSiPws0TYEU/
         3+N7NkH2UArOS9Datkz1E59r/wMhtNa205DHKfjlt1liwZL6sy087/njHUy7HBp67Gcg
         z3w2vSGiQwXnQvlsfJb1KEgGkK7WP2v0o1WmQL6zLf2QUQCht09iet/aUOkNNngyEwuz
         yD4kcifh0Vrn7Vn0TBRZGCM2Ogx3DIJlx0PpnDDsjdpo71UrIsUI79NviO5I0QY4xRQD
         yJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487812; x=1694092612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vv6vlTMJy2ho8geEqPUuJ2REKrug7GrLSZ8XpNgzcaA=;
        b=KZIvAytQXITjHK8RxuVtmzuRlxjXN5bIDrN1pmpU0QI1v4gZHdn6WsyaySh/NCGVQ/
         tiCZjODg1QRjGJTMRo2/27DFNnWovO3B9gyJQjs5mtuAGAYunI004IYWrl7enDjJnjfs
         bl7JIojCMBEtTJGzBfkNY99aPRr38Js8X6y5kJy/JbGg3Tu4s6ph6rR61GQOpJjSq2Ir
         5AO4kS+dZMDA5jSkqaWwa5rhuSlcKug0YEEJI+d/+1KLZXeF0KnBlc+Mms/kHWIstBhj
         N0+6p7MU+6mybdRQEBGnWfRzqQyHFNcLUDT8qo33VTrfaBCvhqGHOhqbqq5ykP2ZmQB2
         oCKQ==
X-Gm-Message-State: AOJu0Yy2kPS+ENjWBd1EFHwffVgrVFHZZqYLaYz2pGMeulS5H+yh85LC
        fgogldq6gfR5Lefixlm2McU12o1GwWlR63gsumZiQw==
X-Google-Smtp-Source: AGHT+IFoQDyCMV7B/82pOJRq6Nw13HD+b28HUNnPHQBjVtfgBqweiF1dvG9pFWSHvgRaYryVIiWd8QSpss+Kv0oN/ok=
X-Received: by 2002:a05:6358:340f:b0:13a:4f34:8063 with SMTP id
 h15-20020a056358340f00b0013a4f348063mr5169461rwd.32.1693487812052; Thu, 31
 Aug 2023 06:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230831101026.3122590-1-mark.rutland@arm.com>
 <CAFA6WYPSbzi5ZKaEdsigtJgdxaK0NXSa_Qyc+_qAvUjqonw10g@mail.gmail.com> <ZPCQi68pQms78tsh@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZPCQi68pQms78tsh@FVFF77S0Q05N.cambridge.arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 31 Aug 2023 18:46:41 +0530
Message-ID: <CAFA6WYNayyOpfu_o8NaoBGvCVSpdfd+ozSUEaqGB=uyX+nAuGg@mail.gmail.com>
Subject: Re: [PATCH] lkdtm/bugs: add test for panic() with stuck secondary CPUs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        keescook@chromium.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Aug 31, 2023 at 06:15:29PM +0530, Sumit Garg wrote:
> > Hi Mark,
> >
> > Thanks for putting up a test case for this.
> >
> > On Thu, 31 Aug 2023 at 15:40, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Upon a panic() the kernel will use either smp_send_stop() or
> > > crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
> > > which may or may not be an NMI. Generally it's preferable that this is an
> > > NMI so that CPUs can be stopped in as many situations as possible, but
> > > it's not always possible to provide an NMI, and there are cases where
> > > CPUs may be unable to handle the NMI regardless.
> > >
> > > This patch adds a test for panic() where all other CPUs are stuck with
> > > interrupts disabled, which can be used to check whether the kernel
> > > gracefully handles CPUs failing to respond to a stop, and whe NMIs stops
> >
> > s/whe/when/
> >
> > > work.
> > >
> > > For example, on arm64 *without* an NMI, this results in:
> > >
> > > | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> > > | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> > > | Kernel panic - not syncing: panic stop irqoff test
> > > | CPU: 2 PID: 24 Comm: migration/2 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
> > > | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> > > | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
> > > | Call trace:
> > > |  dump_backtrace+0x94/0xec
> > > |  show_stack+0x18/0x24
> > > |  dump_stack_lvl+0x74/0xc0
> > > |  dump_stack+0x18/0x24
> > > |  panic+0x358/0x3e8
> > > |  lkdtm_PANIC+0x0/0x18
> > > |  multi_cpu_stop+0x9c/0x1a0
> > > |  cpu_stopper_thread+0x84/0x118
> > > |  smpboot_thread_fn+0x224/0x248
> > > |  kthread+0x114/0x118
> > > |  ret_from_fork+0x10/0x20
> > > | SMP: stopping secondary CPUs
> > > | SMP: failed to stop secondary CPUs 0-3
> > > | Kernel Offset: 0x401cf3490000 from 0xffff800080000000
> > > | PHYS_OFFSET: 0x40000000
> > > | CPU features: 0x00000000,68c167a1,cce6773f
> > > | Memory Limit: none
> > > | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
> > >
> > > On arm64 *with* an NMI, this results in:
> >
> > I suppose a more interesting test scenario to show difference among
> > NMI stop IPI and regular stop IPI would be:
> >
> > - First put any CPU into hard lockup state via:
> >    $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> >
> > - And then provoke following from other CPU:
> >    $ echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
>
> I don't follow. IIUC that's only going to test whether a HW watchdog can fire
> and reset the system?
>
> The PANIC_STOP_IRQOFF test has each CPU run panic_stop_irqoff_fn() with IRQs
> disabled, and if one CPU is stuck in the HARDLOCKUP test, we'll never get all
> CPUs into panic_stop_irqoff_fn(), and so all CPUs will be stuck with IRQs
> disabled, spinning.
>
> The PANIC_STOP_IRQOFF test itself tests the different between an NMI stop IPI
> and regular stop IPI, as the results in the commit message shows. Look for the
> line above that says:
>
> | SMP: failed to stop secondary CPUs 0-3
>
> ... which is *not* present in the NMI case (though we don't have an explicit
> "stoppped all CPUs" message).

Ah, I see your point as I missed that difference when I first looked
up the panic() logs. So it's the post panic() CPU stop behaviour that
we are testing here. Thanks for the explanation.

-Sumit
