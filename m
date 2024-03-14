Return-Path: <linux-kernel+bounces-102870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A98487B7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99EF1F23D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD312E6D;
	Thu, 14 Mar 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ls/5eOvd"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454812B77
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397330; cv=none; b=XNZus/iu+3axmQDtCiK49f13cBNxjtLYGd3onDZLiWODJkXVisi59dCB94xdwlnxNjUbObOm4A9ZrqFLgfL9SVAvCyylgfJf1jh/PQk+0cOxFFWqO5e+GI2jEbsdjDrjaf9gEBJx+UY4luSVmS1vNhKTe6g2SyIy5yAjCT4FTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397330; c=relaxed/simple;
	bh=4tpcGpm0umup+WH1j8CHQx5js/8yuaDLpEUJO0xe2Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVijqb+TmAsqzYN0ysvlbM/FUphcCmLLas9GavwuXThyUZoMyR3rKF30uGfR5a4VDT6pGIbRVzovOTgMJJ4RGQvCSf6YaWZHY9O1hAFRmjdFWY+xATKUfB8CHkCjHYpnE1Amlq4qNES1PLaot6bkRjPjXgOMv5zMIdNEwJNNfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ls/5eOvd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d208be133bso7545031fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710397326; x=1711002126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o45KkxjZ9tKJqVD6VmXroti06fYJn7Sbl9n5jjCN4Hw=;
        b=ls/5eOvdaUBLD7rufe+942rsiONf8h0m3GfHhWGyR1qtsUv7qonpHpzWPK+TdBHLH1
         anJSjumucwDzofItgR/v+YE4P/GHxMgaoduP9+AY1rOT8uXvFSRbkOkWOCc/W1yETVcr
         NkUw30Np3Af8ygj6Abg4z0xoGmVeUY5W/wZt92aW7wuIWdLB//+jXeDWyveMh/F0H2e4
         CEBONSCClFs0sDEbX7gFipqYfhw+PlgOjusLwatXedvHQ8fA3JEOUcRwgDIbts2h6Wya
         XmuwZfC8wfuXmtNdCU9p7IjaG5Eg1B1cw23VqTL044E00aznVePi1ZEvcez+INb7u05z
         h1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710397326; x=1711002126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o45KkxjZ9tKJqVD6VmXroti06fYJn7Sbl9n5jjCN4Hw=;
        b=ebIMqg3aOIq+CkYCM15lNbVlcjwWaVQiPf9eCIr+q9FuEaFeX63YuFjEDqGzH+SuVB
         ef1rJ/27fXLxRhR5wgyoLsVaP7Ih4fgaIgJkfSQk0xLGl5dZlFvRp53bCpWCCS43YD2x
         sfRzr0XcNudvYxdewuXh3met47otUB82Q1XTSLeBDLTHBzXIov6nlLi/5U4JzSzyUySU
         ReCpIHOZN5T0Chn9uLtrTIAIrHtZaT6nVUFSmN3tSDtc0TXdAVC3MpiAve1tuCgiGj3G
         B5sLZdma1S3rqOlWtMYRqDCv157qCaMOLqRvk8mOu3LnNGmsujfNST8uR1it9XCglnaC
         Cr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOgMRip9CqrHkJfaWmiekH728Ps9e7yvqxLqz/f5Dg0dCcnT57jC0IuCrVh4/NGgrknCzAi543Mx6Bslw+m9kxgq2Z6wFd2SAYt+/R
X-Gm-Message-State: AOJu0YyUxEnyhcraqX60Ioegc3M3WH5x/OsXFu1S9GLDOZ81K4X/ycp/
	lb6GM02nU85rE1fWOHfqlGESQzELgHGSMX24cEdzteM9IfW00qXM8YzeswFXyZKO4iFoN5tS808
	DswVq8o76goY6A4HP73W1lNfuN8fNs2N7mYr4Ng==
X-Google-Smtp-Source: AGHT+IHu+QvRoWuFI/kI5mKUaIaRR9DK8XdT1S/1JTk0X18AOEfUreHuARqm4et6aYYJ9zmfygaPUFBXcZ6KAwzO5SE=
X-Received: by 2002:a2e:be11:0:b0:2d4:5321:9daf with SMTP id
 z17-20020a2ebe11000000b002d453219dafmr429496ljq.44.1710397325874; Wed, 13 Mar
 2024 23:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <343C92ABCFEE9906+ZfKPd/boCT8RAr3f@centos8>
In-Reply-To: <343C92ABCFEE9906+ZfKPd/boCT8RAr3f@centos8>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 14 Mar 2024 11:51:53 +0530
Message-ID: <CAK9=C2UfK=rap06A4GLbbhSvGJYpLHb9LMqU_GuxFo0FVQnJHw@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] Linux RISC-V AIA Support
To: 20240307140307.646078-1-apatel@ventanamicro.com
Cc: tglx@linutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	maz@kernel.org, bjorn@kernel.org, atishp@atishpatra.org, 
	ajones@ventanamicro.com, sunilvl@ventanamicro.com, saravanak@google.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dawei.li@shingroup.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 11:17=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> w=
rote:
>
> Hi Anup,
>
> Thanks for the great work on AIA!
>
> Firstly I must apologize for the top posting cuz I miss the series mail f=
or
> my inbox. And for the record, I am replying to [1].
>
> After I checkout riscv_aia_v16 branch at https://github.com/avpatel/linux=
git,
> some call traces about spurious interrupt are screaming:
>
> [    1.244292] irq 11: nobody cared (try booting with the "irqpoll" optio=
n)
> [    1.244707] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc6-00055-=
gd7d4d086b79a #14
> [    1.244932] Hardware name: riscv-virtio,qemu (DT)
> [    1.245130] Call Trace:
> [    1.245337] [<ffffffff80005f32>] dump_backtrace+0x1c/0x24
> [    1.245559] [<ffffffff809023f4>] show_stack+0x2c/0x38
> [    1.245761] [<ffffffff8090ec8c>] dump_stack_lvl+0x3c/0x54
> [    1.245979] [<ffffffff8090ecb8>] dump_stack+0x14/0x1c
> [    1.246116] [<ffffffff8090368c>] __report_bad_irq+0x3e/0xae
> [    1.246276] [<ffffffff8006a938>] note_interrupt+0x1f4/0x23e
> [    1.246382] [<ffffffff800679e2>] handle_irq_event_percpu+0x42/0x50
> [    1.246508] [<ffffffff80067a2c>] handle_irq_event+0x3c/0x68
> [    1.246628] [<ffffffff8006b7a4>] handle_fasteoi_irq+0xac/0x176
> [    1.246788] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
> [    1.246928] [<ffffffff80473f0e>] imsic_handle_irq+0x72/0x12a
> [    1.247041] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
> [    1.247165] [<ffffffff80472470>] riscv_intc_aia_irq+0x26/0x38
> [    1.247291] [<ffffffff8090ed0a>] handle_riscv_irq+0x4a/0x74
> [    1.247430] [<ffffffff80918af6>] call_on_irq_stack+0x32/0x40
> [    1.247626] handlers:
> [    1.247721] [<000000004ebb6fe3>] vm_interrupt
> [    1.248314] Disabling IRQ #11
> [    1.303510] irq 12: nobody cared (try booting with the "irqpoll" optio=
n)
> [    1.303700] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc6-00055-=
gd7d4d086b79a #14
> [    1.304768] Hardware name: riscv-virtio,qemu (DT)
> [    1.305460] Call Trace:
> [    1.305868] [<ffffffff80005f32>] dump_backtrace+0x1c/0x24
> [    1.306621] [<ffffffff809023f4>] show_stack+0x2c/0x38
> [    1.307295] [<ffffffff8090ec8c>] dump_stack_lvl+0x3c/0x54
> [    1.308025] [<ffffffff8090ecb8>] dump_stack+0x14/0x1c
> [    1.308698] [<ffffffff8090368c>] __report_bad_irq+0x3e/0xae
> [    1.309698] [<ffffffff8006a938>] note_interrupt+0x1f4/0x23e
> [    1.310568] [<ffffffff800679e2>] handle_irq_event_percpu+0x42/0x50
> [    1.311542] [<ffffffff80067a2c>] handle_irq_event+0x3c/0x68
> [    1.312298] [<ffffffff8006b7a4>] handle_fasteoi_irq+0xac/0x176
> [    1.313127] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
> [    1.315375] [<ffffffff80473f0e>] imsic_handle_irq+0x72/0x12a
> [    1.316163] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
> [    1.317078] [<ffffffff80472470>] riscv_intc_aia_irq+0x26/0x38
> [    1.318036] [<ffffffff8090ed0a>] handle_riscv_irq+0x4a/0x74
> [    1.318934] [<ffffffff8090f3e6>] do_irq+0x4a/0x4c
> [    1.319831] [<ffffffff809189ac>] ret_from_exception+0x0/0x64
> [    1.320860] [<ffffffff8091845c>] _raw_spin_unlock_irqrestore+0x1a/0x2e
> [    1.321887] [<ffffffff80473d06>] imsic_local_timer_callback+0x50/0x5c
> [    1.322957] [<ffffffff8008ade4>] call_timer_fn.isra.0+0x14/0x5e
> [    1.323781] [<ffffffff8008b44a>] run_timer_softirq+0x388/0x3a8
> [    1.324579] [<ffffffff80918c7e>] __do_softirq+0x100/0x252
> [    1.325304] [<ffffffff80018464>] irq_exit_rcu+0x7c/0xa6
> [    1.326126] [<ffffffff8090ed24>] handle_riscv_irq+0x64/0x74
> [    1.327535] [<ffffffff80918af6>] call_on_irq_stack+0x32/0x40
> [    1.328703] handlers:
> [    1.330724] [<000000008b6c4f15>] serial8250_interrupt
> [    1.331573] Disabling IRQ #12
> [    1.350231] Run /sbin/init as init process
>
> And I take a look on /proc/interrupts, spurious interrupts are happening:
> ~ # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5   =
    CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12=
      CPU13      CPU14      CPU15
>  10:         83        222        350        163         71        101   =
     193         68         54         60        174         50         51 =
        48         48         46  RISC-V INTC   5 Edge      riscv-timer
>  11:     100001          0          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  APLIC-MSI-d000000.aplic   8 Level   -fast=
eoi   virtio0
>  12:          0     100000          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  APLIC-MSI-d000000.aplic  10 Level   -fast=
eoi   ttyS0
>  13:          0          0          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  APLIC-MSI-d000000.aplic  11 Level   -fast=
eoi   101000.rtc
> IPI0:         3          8          4          7          7          6   =
       5          4          7          7          7          5          6 =
        10          4          5  Rescheduling interrupts
> IPI1:       727        517        431        448        497        456   =
     514        476        488        466        455        456        443 =
       443        439        433  Function call interrupts
> IPI2:         0          0          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  CPU stop interrupts
> IPI3:         0          0          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  CPU stop (for crash dump) interrupts
> IPI4:         0          0          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  IRQ work interrupts
> IPI5:         0          0          0          0          0          0   =
       0          0          0          0          0          0          0 =
         0          0          0  Timer broadcast interrupts
>
> But when I switched back to V15, everything is fine.
>
> Here are some of info _maybe_ helpful:
> kernel: d7d4d086b79a11ad8bbcaf732c7830faa3f3192f
> qemu: e1007b6bab5cf97705bf4f2aaec1f607787355b8
> qemu cmdline: qemu-system-riscv64 -M virt,aia=3Daplic-imsic -m 256M -nogr=
aphic -kernel ~/src/linux/arch/riscv/boot/Image -drive file=3Drootfs.img,fo=
rmat=3Draw,id=3Dhd0  -device virtio-blk-device,drive=3Dhd0 -append "root=3D=
/dev/vda rw console=3DttyS0" -smp 16
> config: defconfig(make ARCH=3Driscv defconfig)
>
> And I am happy to provide any extra info if needed.
>
> After I take a git diff and check your changelog:
> [Quoting from [1]]
>  - Simplified aplic_msi_irq_eoi() in PATCH7 based on the section "4.9.2 S=
pecial
>    consideration for level-sensitive interrupt sources"  of the RISC-V AI=
A
>    specification and also provided handler name.
>
> I apologize if I miss something.
>
> [1] https://lore.kernel.org/lkml/20240307140307.646078-1-apatel@ventanami=
cro.com/

The QEMU APLIC emulation of the setipnum register was broken. The
corresponding QEMU fixes are already accepted and queued by the
maintainer.

Please refer, https://lore.kernel.org/all/20240306095722.463296-1-apatel@ve=
ntanamicro.com/

Regards,
Anup

