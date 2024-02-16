Return-Path: <linux-kernel+bounces-68528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D536857BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C7E281661
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E977F14;
	Fri, 16 Feb 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NXHz7+A+"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC974E3C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083249; cv=none; b=M9x34KXV3ve7abLIZw8ozULpQHyGX/RApKBIeUrurWcWC0cNkQQXwwQKq6jH7rJCfO7qTSFYHcovuF1a2cV+ln/TWt9E6muQzCZzzFRZKJCmpmqHUORfx8Bel8jvjZzhFWA5qFWSiFJhk3sHu5Wc64wEEYgaxxiCyqhcSU6aUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083249; c=relaxed/simple;
	bh=rcuBOZf69sy6E6g9wii4otRHjZBQ8pUOPORx0Nb2wI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3Bdcb9A+ymSLALwVITt6SqUPJTuSRivgyDJoRsvGk6Zt0uc91GAuXCvVrnXXi7HxdiXJV032IJdHmPkwgdKe7Vr8YCEzgRYNNKeRxzLqDkFQPHG6nOAiAxWg5pINOHGEPxjpesTTpiD3gYps+VqTjh02ZOfmEXLPaRNi8KIugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NXHz7+A+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0e520362cso19527681fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708083245; x=1708688045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuwHXBJsXjsJpBet/LH76z5zKxgSa2WDTMrN/l1kYdY=;
        b=NXHz7+A+Z4lL0GBABO2c0VTZgcr3SUz5/MC08bC0LdEySzWBnEZT1QajAX/nI4utfH
         rVd4C7hRJ65chbuf5MW4KoD6YH4PQCIE8SfaEeiulLh32fgYBpgdNdDWultp8YpZNTKm
         AT5vPRPV0RWUG5lZQ9oOpYnqWgDZ0d/7IHE0NIuQKDKwNiO0II2haA+W8Z4fFXn3hQ3M
         weYFB5nXOveMillFC1zNoow5hWTe8eLZvQmgKQD2S646Vn2lLxiz/bpwJBgxJ2SHvyye
         yNQJPyp8xyCcq4OexD8wQMQnxI/ceDIkKN7i0gbfxRrFb8042vlyjhXa/zKfmhKSIJlG
         y/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083245; x=1708688045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuwHXBJsXjsJpBet/LH76z5zKxgSa2WDTMrN/l1kYdY=;
        b=uv0QnAuhQspaOVi0LD+1bEeiEFTy8NCMy+8llZbvohxWG4XF1QTK5qDiFCnydKgrHz
         +vmZ+99BNNDn04A4KNpsi0GHp4ZN2IDBUgIx0h7vQm6mhdBMWdeuuqJ2Ta21lDYiqfAi
         oXgEjd3yGayWq1Y3Xd1GfHod18gUt3v94JDAfF2ygAPjlyZdWgSZ0LoUeO3UXTDP2mSY
         75eb68tdBvnt5uT8XNzEZUulNOiFrQQWLBoHer9OyZ0t08+jkDp2IKGqeJTRAK068TuE
         iwrOK2XHGM5lOhepCEQRa/UzCVBTUIxk9fJrwHZdUxkRAQJPARBItBODACtFXN2UFir5
         e+zA==
X-Forwarded-Encrypted: i=1; AJvYcCUb3CmJTT5Olr/g94ys815ksP301BCX3IWDzPe1sQ2ol2IEthHI8fBg7k2QaN9GCJ90Otf0UYxr7LgGU72rF5tDHfyD9e9vBmtxIxw7
X-Gm-Message-State: AOJu0YxgyQElgfTvISuVUvENgLkZizceo+ZX5hXXvHMSRQ1rAUS/Jr6I
	tMK6SlUBIHlmXzCsI7y7BEO6AptiYxRWXID9gIEl9Wqlzf7/Ho50kwW5kjjkvRXbXxG1TYLLR2Y
	U2l31s4ZLTOB391uI1Ib97K6y7Jl7+e74FGHiImLf98ShFE+Zbtw=
X-Google-Smtp-Source: AGHT+IG7WVQ3sOGjNRiD7Ie0FPaU+sIvqO0ooi6DSe0gJqv4a+IDAgKhxxitOXxwE90nbC1lBxUACpq+6lPeGCjDbiA=
X-Received: by 2002:a05:651c:1693:b0:2d0:b285:ffc4 with SMTP id
 bd19-20020a05651c169300b002d0b285ffc4mr2795678ljb.35.1708083244457; Fri, 16
 Feb 2024 03:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com> <ZcSoqkexSipQsrLZ@andrea>
In-Reply-To: <ZcSoqkexSipQsrLZ@andrea>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 17:03:51 +0530
Message-ID: <CAK9=C2XOnVeosVugF0sOFHuuFExVDBajLpV_b3Z4iFBW0Ke+aA@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Thu, Feb 8, 2024 at 3:40=E2=80=AFPM Andrea Parri <parri.andrea@gmail.com=
> wrote:
>
> Hi Anup,
>
> I understand that some refactoring is in progress, but I don't see the
> report below; adding it here hoping that it can be useful towards v13.
> (Unfortunately, I didn't have enough time to debug this yet...)
>
>
> >   irqchip/sifive-plic: Convert PLIC driver into a platform driver
>
> I'm seeing the following LOCKDEP warning with this series, bisected to
> the commit above.  This is a defconfig + PROVE_LOCKING=3Dy build, booted
> using -machine virt,aia=3Dnone.
>
> [    0.953473] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.953704] WARNING: possible irq lock inversion dependency detected
> [    0.953955] 6.8.0-rc1-00039-gd9b9d6eb987f #1122 Not tainted
> [    0.954224] --------------------------------------------------------
> [    0.954444] swapper/0/0 just changed the state of lock:
> [    0.954664] ffffaf808109d0c8 (&irq_desc_lock_class){-...}-{2:2}, at: h=
andle_fasteoi_irq+0x24/0x1da
> [    0.955699] but this lock took another, HARDIRQ-unsafe lock in the pas=
t:
> [    0.955942]  (&handler->enable_lock){+.+.}-{2:2}
> [    0.955974]
>
>                and interrupts could create inverse lock ordering between =
them.
>
> [    0.956507]
>                other info that might help us debug this:
> [    0.956775]  Possible interrupt unsafe locking scenario:
>
> [    0.956998]        CPU0                    CPU1
> [    0.957247]        ----                    ----
> [    0.957439]   lock(&handler->enable_lock);
> [    0.957607]                                local_irq_disable();
> [    0.957793]                                lock(&irq_desc_lock_class);
> [    0.958021]                                lock(&handler->enable_lock)=
;
> [    0.958246]   <Interrupt>
> [    0.958342]     lock(&irq_desc_lock_class);
> [    0.958501]
>                 *** DEADLOCK ***

I was able to reproduce this warning.

Further digging, it turns out the locking safety issue existed
before PLIC was converted into platform driver but was never
caught by the lock dependency because previously it was
being probed very early using IRQCHIP_DECLARE().

I will include a separate patch in v13 to fix this warning.

Thanks,
Anup



>
> [    0.958715] no locks held by swapper/0/0.
> [    0.958870]
>                the shortest dependencies between 2nd lock and 1st lock:
> [    0.959152]  -> (&handler->enable_lock){+.+.}-{2:2} {
> [    0.959372]     HARDIRQ-ON-W at:
> [    0.959522]                       __lock_acquire+0x884/0x1f5c
> [    0.959745]                       lock_acquire+0xf0/0x292
> [    0.959913]                       _raw_spin_lock+0x2c/0x40
> [    0.960090]                       plic_probe+0x322/0x65c
> [    0.960257]                       platform_probe+0x4e/0x92
> [    0.960432]                       really_probe+0x82/0x210
> [    0.960598]                       __driver_probe_device+0x5c/0xd0
> [    0.960784]                       driver_probe_device+0x2c/0xb0
> [    0.960964]                       __driver_attach+0x72/0x10a
> [    0.961151]                       bus_for_each_dev+0x60/0xac
> [    0.961330]                       driver_attach+0x1a/0x22
> [    0.961496]                       bus_add_driver+0xd4/0x19e
> [    0.961666]                       driver_register+0x3e/0xd8
> [    0.961835]                       __platform_driver_register+0x1c/0x24
> [    0.962030]                       plic_driver_init+0x1a/0x22
> [    0.962201]                       do_one_initcall+0x80/0x268
> [    0.962371]                       kernel_init_freeable+0x296/0x300
> [    0.962554]                       kernel_init+0x1e/0x10a
> [    0.962713]                       ret_from_fork+0xe/0x1c
> [    0.962884]     SOFTIRQ-ON-W at:
> [    0.962994]                       __lock_acquire+0x89e/0x1f5c
> [    0.963169]                       lock_acquire+0xf0/0x292
> [    0.963336]                       _raw_spin_lock+0x2c/0x40
> [    0.963497]                       plic_probe+0x322/0x65c
> [    0.963664]                       platform_probe+0x4e/0x92
> [    0.963849]                       really_probe+0x82/0x210
> [    0.964054]                       __driver_probe_device+0x5c/0xd0
> [    0.964255]                       driver_probe_device+0x2c/0xb0
> [    0.964428]                       __driver_attach+0x72/0x10a
> [    0.964603]                       bus_for_each_dev+0x60/0xac
> [    0.964777]                       driver_attach+0x1a/0x22
> [    0.964943]                       bus_add_driver+0xd4/0x19e
> [    0.965343]                       driver_register+0x3e/0xd8
> [    0.965527]                       __platform_driver_register+0x1c/0x24
> [    0.965732]                       plic_driver_init+0x1a/0x22
> [    0.965908]                       do_one_initcall+0x80/0x268
> [    0.966078]                       kernel_init_freeable+0x296/0x300
> [    0.966268]                       kernel_init+0x1e/0x10a
> [    0.966436]                       ret_from_fork+0xe/0x1c
> [    0.966599]     INITIAL USE at:
> [    0.966716]                      __lock_acquire+0x3fc/0x1f5c
> [    0.966891]                      lock_acquire+0xf0/0x292
> [    0.967048]                      _raw_spin_lock+0x2c/0x40
> [    0.967206]                      plic_probe+0x322/0x65c
> [    0.967360]                      platform_probe+0x4e/0x92
> [    0.967522]                      really_probe+0x82/0x210
> [    0.967678]                      __driver_probe_device+0x5c/0xd0
> [    0.967853]                      driver_probe_device+0x2c/0xb0
> [    0.968025]                      __driver_attach+0x72/0x10a
> [    0.968185]                      bus_for_each_dev+0x60/0xac
> [    0.968348]                      driver_attach+0x1a/0x22
> [    0.968513]                      bus_add_driver+0xd4/0x19e
> [    0.968678]                      driver_register+0x3e/0xd8
> [    0.968839]                      __platform_driver_register+0x1c/0x24
> [    0.969035]                      plic_driver_init+0x1a/0x22
> [    0.969239]                      do_one_initcall+0x80/0x268
> [    0.969431]                      kernel_init_freeable+0x296/0x300
> [    0.969610]                      kernel_init+0x1e/0x10a
> [    0.969766]                      ret_from_fork+0xe/0x1c
> [    0.969936]   }
> [    0.970010]   ... key      at: [<ffffffff824f4138>] __key.2+0x0/0x10
> [    0.970224]   ... acquired at:
> [    0.970353]    lock_acquire+0xf0/0x292
> [    0.970482]    _raw_spin_lock+0x2c/0x40
> [    0.970609]    plic_irq_enable+0x7e/0x140
> [    0.970739]    irq_enable+0x2c/0x60
> [    0.970882]    __irq_startup+0x58/0x60
> [    0.971008]    irq_startup+0x5e/0x13c
> [    0.971126]    __setup_irq+0x4de/0x5da
> [    0.971248]    request_threaded_irq+0xcc/0x12e
> [    0.971394]    vm_find_vqs+0x62/0x50a
> [    0.971518]    probe_common+0xfe/0x1d2
> [    0.971635]    virtrng_probe+0xc/0x14
> [    0.971751]    virtio_dev_probe+0x154/0x1fc
> [    0.971878]    really_probe+0x82/0x210
> [    0.972008]    __driver_probe_device+0x5c/0xd0
> [    0.972147]    driver_probe_device+0x2c/0xb0
> [    0.972280]    __driver_attach+0x72/0x10a
> [    0.972407]    bus_for_each_dev+0x60/0xac
> [    0.972540]    driver_attach+0x1a/0x22
> [    0.972656]    bus_add_driver+0xd4/0x19e
> [    0.972777]    driver_register+0x3e/0xd8
> [    0.972896]    register_virtio_driver+0x1c/0x2a
> [    0.973049]    virtio_rng_driver_init+0x18/0x20
> [    0.973236]    do_one_initcall+0x80/0x268
> [    0.973399]    kernel_init_freeable+0x296/0x300
> [    0.973540]    kernel_init+0x1e/0x10a
> [    0.973658]    ret_from_fork+0xe/0x1c
>
> [    0.973858] -> (&irq_desc_lock_class){-...}-{2:2} {
> [    0.974036]    IN-HARDIRQ-W at:
> [    0.974142]                     __lock_acquire+0xa82/0x1f5c
> [    0.974309]                     lock_acquire+0xf0/0x292
> [    0.974467]                     _raw_spin_lock+0x2c/0x40
> [    0.974625]                     handle_fasteoi_irq+0x24/0x1da
> [    0.974794]                     generic_handle_domain_irq+0x1c/0x2a
> [    0.974982]                     plic_handle_irq+0x7e/0xf0
> [    0.975143]                     generic_handle_domain_irq+0x1c/0x2a
> [    0.975329]                     riscv_intc_irq+0x2e/0x46
> [    0.975488]                     handle_riscv_irq+0x4a/0x74
> [    0.975652]                     call_on_irq_stack+0x32/0x40
> [    0.975817]    INITIAL USE at:
> [    0.975923]                    __lock_acquire+0x3fc/0x1f5c
> [    0.976087]                    lock_acquire+0xf0/0x292
> [    0.976244]                    _raw_spin_lock_irqsave+0x3a/0x64
> [    0.976423]                    __irq_get_desc_lock+0x5a/0x84
> [    0.976594]                    irq_modify_status+0x2a/0x106
> [    0.976764]                    irq_set_percpu_devid+0x62/0x78
> [    0.976939]                    riscv_intc_domain_map+0x1e/0x54
> [    0.977133]                    irq_domain_associate_locked+0x42/0xe4
> [    0.977363]                    irq_create_mapping_affinity+0x98/0xd4
> [    0.977570]                    sbi_ipi_init+0x70/0x142
> [    0.977744]                    init_IRQ+0xfe/0x11a
> [    0.977906]                    start_kernel+0x4ae/0x790
> [    0.978082]  }
> [    0.978151]  ... key      at: [<ffffffff824bbee0>] irq_desc_lock_class=
+0x0/0x10
> [    0.978389]  ... acquired at:
> [    0.978494]    mark_lock+0x3fe/0x8c2
> [    0.978624]    __lock_acquire+0xa82/0x1f5c
> [    0.978766]    lock_acquire+0xf0/0x292
> [    0.978897]    _raw_spin_lock+0x2c/0x40
> [    0.979029]    handle_fasteoi_irq+0x24/0x1da
> [    0.979171]    generic_handle_domain_irq+0x1c/0x2a
> [    0.979326]    plic_handle_irq+0x7e/0xf0
> [    0.979460]    generic_handle_domain_irq+0x1c/0x2a
> [    0.979618]    riscv_intc_irq+0x2e/0x46
> [    0.979751]    handle_riscv_irq+0x4a/0x74
> [    0.979888]    call_on_irq_stack+0x32/0x40
>
> [    0.980110]
>                stack backtrace:
> [    0.980358] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc1-00039-=
gd9b9d6eb987f #1122
> [    0.980662] Hardware name: riscv-virtio,qemu (DT)
> [    0.980913] Call Trace:
> [    0.981042] [<ffffffff80007198>] dump_backtrace+0x1c/0x24
> [    0.981246] [<ffffffff80ae020a>] show_stack+0x2c/0x38
> [    0.981456] [<ffffffff80aedac4>] dump_stack_lvl+0x5a/0x7c
> [    0.981648] [<ffffffff80aedafa>] dump_stack+0x14/0x1c
> [    0.981813] [<ffffffff80ae17a4>] print_irq_inversion_bug.part.0+0x162/=
0x176
> [    0.982031] [<ffffffff8007c6e6>] mark_lock+0x3fe/0x8c2
> [    0.982198] [<ffffffff8007d888>] __lock_acquire+0xa82/0x1f5c
> [    0.982377] [<ffffffff8007f59e>] lock_acquire+0xf0/0x292
> [    0.982549] [<ffffffff80af9962>] _raw_spin_lock+0x2c/0x40
> [    0.982721] [<ffffffff8008f3fe>] handle_fasteoi_irq+0x24/0x1da
> [    0.982904] [<ffffffff8008a4a4>] generic_handle_domain_irq+0x1c/0x2a
> [    0.983112] [<ffffffff80581dc0>] plic_handle_irq+0x7e/0xf0
> [    0.983293] [<ffffffff8008a4a4>] generic_handle_domain_irq+0x1c/0x2a
> [    0.983495] [<ffffffff8057fb1a>] riscv_intc_irq+0x2e/0x46
> [    0.983671] [<ffffffff80aedb4c>] handle_riscv_irq+0x4a/0x74
> [    0.983856] [<ffffffff80afa756>] call_on_irq_stack+0x32/0x40
>
>
> When I switch to -machine virt,aia=3Daplic-imsic (same config as above), =
I
> get:
>
> [    0.971406] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.971439] WARNING: possible recursive locking detected
> [    0.971497] 6.8.0-rc1-00039-gd9b9d6eb987f #1122 Not tainted
> [    0.971583] --------------------------------------------
> [    0.971612] swapper/0/1 is trying to acquire lock:
> [    0.971662] ffffaf83fefa8e78 (&lpriv->ids_lock){-...}-{2:2}, at: imsic=
_vector_move+0x92/0x146
> [    0.971927]
>                but task is already holding lock:
> [    0.971975] ffffaf83fef6ee78 (&lpriv->ids_lock){-...}-{2:2}, at: imsic=
_vector_move+0x86/0x146
> [    0.972045]
>                other info that might help us debug this:
> [    0.972085]  Possible unsafe locking scenario:
>
> [    0.972114]        CPU0
> [    0.972133]        ----
> [    0.972153]   lock(&lpriv->ids_lock);
> [    0.972191]   lock(&lpriv->ids_lock);
> [    0.972228]
>                 *** DEADLOCK ***
>
> [    0.972258]  May be due to missing lock nesting notation
>
> [    0.972306] 6 locks held by swapper/0/1:
> [    0.972338]  #0: ffffaf8081f65970 (&dev->mutex){....}-{3:3}, at: __dri=
ver_attach+0x6a/0x10a
> [    0.972413]  #1: ffffaf808217c240 (&desc->request_mutex){+.+.}-{3:3}, =
at: __setup_irq+0xa2/0x5da
> [    0.972492]  #2: ffffaf808217c0c8 (&irq_desc_lock_class){....}-{2:2}, =
at: __setup_irq+0xbe/0x5da
> [    0.972555]  #3: ffffffff81892ac0 (mask_lock){....}-{2:2}, at: irq_set=
up_affinity+0x38/0xc6
> [    0.972617]  #4: ffffffff81892a80 (tmp_mask_lock){....}-{2:2}, at: irq=
_do_set_affinity+0x3a/0x164
> [    0.972681]  #5: ffffaf83fef6ee78 (&lpriv->ids_lock){-...}-{2:2}, at: =
imsic_vector_move+0x86/0x146
> [    0.972753]
>                stack backtrace:
> [    0.972852] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1-00039-=
gd9b9d6eb987f #1122
> [    0.972900] Hardware name: riscv-virtio,qemu (DT)
> [    0.972987] Call Trace:
> [    0.973019] [<ffffffff80007198>] dump_backtrace+0x1c/0x24
> [    0.973054] [<ffffffff80ae020a>] show_stack+0x2c/0x38
> [    0.973083] [<ffffffff80aedac4>] dump_stack_lvl+0x5a/0x7c
> [    0.973112] [<ffffffff80aedafa>] dump_stack+0x14/0x1c
> [    0.973139] [<ffffffff8007ad5e>] print_deadlock_bug+0x282/0x328
> [    0.973168] [<ffffffff8007e15c>] __lock_acquire+0x1356/0x1f5c
> [    0.973198] [<ffffffff8007f59e>] lock_acquire+0xf0/0x292
> [    0.973225] [<ffffffff80af9adc>] _raw_spin_lock_irqsave+0x3a/0x64
> [    0.973255] [<ffffffff80581210>] imsic_vector_move+0x92/0x146
> [    0.973285] [<ffffffff80581a04>] imsic_irq_set_affinity+0x8e/0xc6
> [    0.973315] [<ffffffff8008c86a>] irq_do_set_affinity+0x142/0x164
> [    0.973345] [<ffffffff8008cc22>] irq_setup_affinity+0x68/0xc6
> [    0.973374] [<ffffffff8008fa82>] irq_startup+0x72/0x13c
> [    0.973401] [<ffffffff8008d40c>] __setup_irq+0x4de/0x5da
> [    0.973430] [<ffffffff8008d5d4>] request_threaded_irq+0xcc/0x12e
> [    0.973460] [<ffffffff806346d8>] vp_find_vqs_msix+0x114/0x376
> [    0.973491] [<ffffffff80634970>] vp_find_vqs+0x36/0x136
> [    0.973518] [<ffffffff80633280>] vp_modern_find_vqs+0x16/0x4e
> [    0.973547] [<ffffffff80ab31f8>] p9_virtio_probe+0x8e/0x31c
> [    0.973576] [<ffffffff8062d982>] virtio_dev_probe+0x154/0x1fc
> [    0.973605] [<ffffffff80693738>] really_probe+0x82/0x210
> [    0.973632] [<ffffffff80693922>] __driver_probe_device+0x5c/0xd0
> [    0.973661] [<ffffffff806939c2>] driver_probe_device+0x2c/0xb0
> [    0.973690] [<ffffffff80693b46>] __driver_attach+0x72/0x10a
> [    0.973718] [<ffffffff8069191a>] bus_for_each_dev+0x60/0xac
> [    0.973746] [<ffffffff80693164>] driver_attach+0x1a/0x22
> [    0.973773] [<ffffffff80692ade>] bus_add_driver+0xd4/0x19e
> [    0.973801] [<ffffffff8069487e>] driver_register+0x3e/0xd8
> [    0.973829] [<ffffffff8062d1ce>] register_virtio_driver+0x1c/0x2a
> [    0.973858] [<ffffffff80c3da52>] p9_virtio_init+0x36/0x56
> [    0.973887] [<ffffffff800028fe>] do_one_initcall+0x80/0x268
> [    0.973915] [<ffffffff80c01144>] kernel_init_freeable+0x296/0x300
> [    0.973944] [<ffffffff80af05dc>] kernel_init+0x1e/0x10a
> [    0.973972] [<ffffffff80afa716>] ret_from_fork+0xe/0x1c
>
>
> FWIW, the full Qemu command I used was as follows:
>
>         sudo /home/andrea/Downloads/qemu/build/qemu-system-riscv64 \
>                 -append "root=3D/dev/root rw rootfstype=3D9p rootflags=3D=
version=3D9p2000.L,trans=3Dvirtio,cache=3Dmmap,access=3Dany raid=3Dnoautode=
tect security=3Dnone loglevel=3D7" \
>                 -cpu rv64,sv57=3Doff,svadu=3Doff,svnapot=3Doff \
>                 -device virtio-net-device,netdev=3Dnet0 \
>                 -device virtio-rng-device,rng=3Drng0 \
>                 -device virtio-9p-pci,fsdev=3Droot,mount_tag=3D/dev/root =
\
>                 -fsdev local,id=3Droot,path=3D/home/andrea/Downloads/jamm=
y/,security_model=3Dnone \
>                 -kernel /home/andrea/linux/arch/riscv/boot/Image \
>                 -m 16G \
>                 -machine virt,aia=3D<either "none" or "aplic-imsic"> \
>                 -monitor telnet:127.0.0.1:55555,server,nowait \
>                 -netdev user,id=3Dnet0,host=3D10.0.2.10,hostfwd=3Dtcp::10=
022-:22 \
>                 -nographic \
>                 -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
>                 -serial mon:stdio \
>                 -smp 5
>
>
>   Andrea

