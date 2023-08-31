Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447CD78F108
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjHaQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjHaQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:16:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68ADE50
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:16:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso1363834a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693498610; x=1694103410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toidrVNWtAC2lj32oW5IOdBKnQPrjUfxHNOgT2JWR+s=;
        b=CyZ43+10RIRo56VsCEM5vidVMya8MdfKm/+QThQj0HR5R/qAlm+3sVJuLeEOnvmPBI
         HHUfiwHu8PJT2Sj2KzBHXtBBPHhzHv+T34Flcj7gIoSfTLQVe/y1ZqRLUAtnyDOhMQ9h
         k2jNy9EKDeCoSJoxglMKpIECjZgPjavlYpwEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498610; x=1694103410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toidrVNWtAC2lj32oW5IOdBKnQPrjUfxHNOgT2JWR+s=;
        b=fvxQ2DoHsw6PYbHXXIsGxhGQ95XMRFJhyXbknDqtJtcS1S93QrgWpfeT+9OAlC6uoH
         63WB1VhWpbo+hgNj/O0bp+6XFN8yJxr9BeOFK7f6kBhImSZGSx3QJdDSJdj1GVjereiF
         ae4ZTYvdYyFVBxBfDqBS7sVUCvInmXXWbVui26B1zXdOwv9eKIqyMXdJc0gHr1l/lPQI
         Qj+Ji9MQ8SOcApPkKpqZdul5Qeg6TnEzrsBWmYj57JnAPMJqgXBZHZuD+T2NGq+p9udI
         QKqX5f78VbwmtOAlP7/iPQEWIyrrwEQ2xUdSlc6WkPz/vOv4wayzB/l4Jmsbi+rw4vWd
         IgMQ==
X-Gm-Message-State: AOJu0YwSgR3TzxvOHAkkhkYlPv6U4HfaXByEo3U2bJT/G146YGZmIsiP
        ANOGLWxdFpr4U22JwAXBz2sYHBOcqRSa+OqyPpkaSKRF
X-Google-Smtp-Source: AGHT+IFeUffUXoa2Qv7ydYyYdBX3K2M88vnH67r3GOKTbIl4yjA+1zaQVDbFBLYF7Y4G27kG+ZQklA==
X-Received: by 2002:a50:fb88:0:b0:523:4933:b024 with SMTP id e8-20020a50fb88000000b005234933b024mr35334edq.14.1693498609847;
        Thu, 31 Aug 2023 09:16:49 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id e23-20020aa7d7d7000000b00525683f9b2fsm947236eds.5.2023.08.31.09.16.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 09:16:49 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso93365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:16:47 -0700 (PDT)
X-Received: by 2002:a05:600c:5124:b0:400:fffe:edf6 with SMTP id
 o36-20020a05600c512400b00400fffeedf6mr145835wms.1.1693498607636; Thu, 31 Aug
 2023 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230831101026.3122590-1-mark.rutland@arm.com>
In-Reply-To: <20230831101026.3122590-1-mark.rutland@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Aug 2023 09:16:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wb0TRE1AEr=f7f-iGWrnF=Wabdde5XJW2XNjMpy+uJGQ@mail.gmail.com>
Message-ID: <CAD=FV=Wb0TRE1AEr=f7f-iGWrnF=Wabdde5XJW2XNjMpy+uJGQ@mail.gmail.com>
Subject: Re: [PATCH] lkdtm/bugs: add test for panic() with stuck secondary CPUs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        sumit.garg@linaro.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 3:10=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Upon a panic() the kernel will use either smp_send_stop() or
> crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
> which may or may not be an NMI. Generally it's preferable that this is an
> NMI so that CPUs can be stopped in as many situations as possible, but
> it's not always possible to provide an NMI, and there are cases where
> CPUs may be unable to handle the NMI regardless.
>
> This patch adds a test for panic() where all other CPUs are stuck with
> interrupts disabled, which can be used to check whether the kernel
> gracefully handles CPUs failing to respond to a stop, and whe NMIs stops
> work.
>
> For example, on arm64 *without* an NMI, this results in:
>
> | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> | Kernel panic - not syncing: panic stop irqoff test
> | CPU: 2 PID: 24 Comm: migration/2 Not tainted 6.5.0-rc3-00077-ge6c782389=
895-dirty #4
> | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a=
4
> | Call trace:
> |  dump_backtrace+0x94/0xec
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0x74/0xc0
> |  dump_stack+0x18/0x24
> |  panic+0x358/0x3e8
> |  lkdtm_PANIC+0x0/0x18
> |  multi_cpu_stop+0x9c/0x1a0
> |  cpu_stopper_thread+0x84/0x118
> |  smpboot_thread_fn+0x224/0x248
> |  kthread+0x114/0x118
> |  ret_from_fork+0x10/0x20
> | SMP: stopping secondary CPUs
> | SMP: failed to stop secondary CPUs 0-3
> | Kernel Offset: 0x401cf3490000 from 0xffff800080000000
> | PHYS_OFFSET: 0x40000000
> | CPU features: 0x00000000,68c167a1,cce6773f
> | Memory Limit: none
> | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
>
> On arm64 *with* an NMI, this results in:
>
> | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> | Kernel panic - not syncing: panic stop irqoff test
> | CPU: 1 PID: 19 Comm: migration/1 Not tainted 6.5.0-rc3-00077-ge6c782389=
895-dirty #4
> | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a=
4
> | Call trace:
> |  dump_backtrace+0x94/0xec
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0x74/0xc0
> |  dump_stack+0x18/0x24
> |  panic+0x358/0x3e8
> |  lkdtm_PANIC+0x0/0x18
> |  multi_cpu_stop+0x9c/0x1a0
> |  cpu_stopper_thread+0x84/0x118
> |  smpboot_thread_fn+0x224/0x248
> |  kthread+0x114/0x118
> |  ret_from_fork+0x10/0x20
> | SMP: stopping secondary CPUs
> | Kernel Offset: 0x55a9c0bc0000 from 0xffff800080000000
> | PHYS_OFFSET: 0x40000000
> | CPU features: 0x00000000,68c167a1,fce6773f
> | Memory Limit: none
> | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---

Since Sumit didn't notice it and I had to use a "diff" tool to help me
spot the difference in your two examples, maybe telegraph for the
reader of the commit message that the important thing is the lack of
"SMP: failed to stop secondary CPUs" in your example.


> +static void lkdtm_PANIC_STOP_IRQOFF(void)
> +{
> +       atomic_t v =3D ATOMIC_INIT(0);
> +
> +       cpus_read_lock();
> +       stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);

It broke my brain just a little bit that stop_machine() isn't backed
by "IPI_CPU_STOP" since the point of this was to test the patch
modifying how "IPI_CPU_STOP" worked. ;-) Assuming I didn't mess up, I
guess stop_machine() is just used to get all the CPUs running with
interrupts disabled and then the last CPU does a panic. The _panic_
then tests "IPI_CPU_STOP" / "IPI_CPU_CRASH_STOP".

Probably this is obvious to everyone but me, so no action is needed
unless you agree that it's confusing and can think of a good comment /
commit message addition to help.


In any case, after Sumit's feedback is addressed:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
