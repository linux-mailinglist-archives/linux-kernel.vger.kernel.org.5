Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512FC7E5C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjKHRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:31:31 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F31BE3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:31:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so94644051fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699464688; x=1700069488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2y+UIxR7t0y8KyRRopsN2Qm2b1Bu/DmgpnCpFpmBbc=;
        b=l+dg7yc2e939hWvSotlBekxHDbFdUuhU0LNEV/AKaFEyYsiYi4d8Puxs2Z6ZXFe8TQ
         MHM+SqGYIVjYol56q6UWptEdc02HR5kK0znoKKCHZE5G9INwxf/GC2ctAMQhcEr1DZcz
         /uYfAC8+BLfcViA7PULL0/UeUWPlxdSrDT1lYlrM2WvlzWCiKWoe8QFxgDS6Bsd9K32x
         kITbq0ICMA/AmdVDR42XgWznj8ma6YfXgfn6mxkRhHXKL3x4NpM9oLvA/pwH3IA1swzK
         bkzBtQ0ehX3cK5isEkAVXQIipFOyJFb07AP9W2xJAXpobOAHBvZSuAwxC89w+AdVD/dl
         iupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464688; x=1700069488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2y+UIxR7t0y8KyRRopsN2Qm2b1Bu/DmgpnCpFpmBbc=;
        b=GRbw/QzhFA1fE6iFKkqFhTAjABDjs/EWs3Rr9pL9PJmdU8Wb/9o08cWYpTr/x+As0F
         7OVCDen2pYXHZS3tIYTDJszUzqynOOM1ghC9JLh8GvknSR1VJmtojSOa53QXeYsC+2b+
         aVgUoIWcp7Zj68doYIKWG9lQ/DprPw2B6uTcQEEXZzc7zO6OaF/t/iMwlh8d3WKN6ycX
         yObFFxkDjZaKOEGl1WKH3FzmiipoSagXZAXqnY+1gkuFhSIET/e1trjUEBppqpIqY4DP
         YO8VjMXkjH8zEkcHDhi9LRorWVWS3tX/B1Ygf1K8b0qUJ7lx3Z1BmM6/PVeGMBrkniWj
         /+iA==
X-Gm-Message-State: AOJu0YzhBAZchSNTWt8ifhFQ5mHacWydcakZYZxdt8Y6VVggqEs7Xcen
        dt+BBZSLSqQ7DC9lNisRabH9yBg0If+uK0iXttgNLg==
X-Google-Smtp-Source: AGHT+IFxwqRCM017IGRoE/j1galivZMI9ibJrcoLcNp7ZxDZWPie8AVUUtT7psUw58yv+O6zl0BLG009pUTZ+uXiXs4=
X-Received: by 2002:a05:651c:2dd:b0:2c0:318a:6ee1 with SMTP id
 f29-20020a05651c02dd00b002c0318a6ee1mr1957557ljo.49.1699464687676; Wed, 08
 Nov 2023 09:31:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3@eucas1p2.samsung.com>
 <20231108112909.591987-1-m.szyprowski@samsung.com> <CALs-Hst6fmesQy6g=ZxfKFs5W85quWQRcwP_=okBWKqMA3CQsw@mail.gmail.com>
 <4a49e782-465d-434d-b101-8ca478914b72@samsung.com>
In-Reply-To: <4a49e782-465d-434d-b101-8ca478914b72@samsung.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 8 Nov 2023 09:30:51 -0800
Message-ID: <CALs-HsvE3u7OGTm84KRr-LfVVmhs4xspHL1GqEuRo--C6TVu8A@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix potential panic during CPU hot-plug
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 9:18=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Dear Evan,
>
> On 08.11.2023 17:47, Evan Green wrote:
> > On Wed, Nov 8, 2023 at 3:29=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com>  wrote:
> >> Commit 584ea6564bca ("RISC-V: Probe for unaligned access speed") added=
 a
> >> test for unaligned access speed. It is being performed when given CPU =
is
> >> onlined. Then, another test for misaligned access emulation has been
> >> added in commit 71c54b3d169d ("riscv: report misaligned accesses
> >> emulation to hwprobe"). This unaligned access speed doesn't really cha=
nge
> >> after the boot, so it is sufficient to do this test only once. This ha=
s
> >> been partially added by commit c20d36cc2a20 ("riscv: don't probe
> >> unaligned access speed if already done"), but this optimisation works
> >> only if RISCV_HWPROBE_MISALIGNED_EMULATED is returned by the latter
> >> check. Otherwise the 'misaligned_access_speed' pcpu varliable is
> >> overwritten with RISCV_HWPROBE_MISALIGNED_UNKNOWN value, what makes th=
e
> >> first check to be always performed.
> >>
> >> Recently I've noticed that the first check introduced a regression in =
the
> >> CPU hot-plug mechanism. This can be observed as a following panic on
> >> QEmu:
> >>
> >> CPU1: off
> >> cpu1: Ratio of byte access time to unaligned word access is 7.00, unal=
igned accesses are fast
> >> CPU1: off
> >> CPU1: failed to come online
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 215 at kernel/smp.c:437 __flush_smp_call_function=
_queue+0x90/0x292
> >> Modules linked in:
> >> CPU: 0 PID: 215 Comm: bash Not tainted 6.5.0-rc1+ #7524
> >> Hardware name: riscv-virtio,qemu (DT)
> >> epc : __flush_smp_call_function_queue+0x90/0x292
> >>   ra : smpcfd_dying_cpu+0xe/0x1c
> >> ...
> >> [<ffffffff800c904a>] __flush_smp_call_function_queue+0x90/0x292
> >> [<ffffffff800c9ae8>] smpcfd_dying_cpu+0xe/0x1c
> >> [<ffffffff80012b2e>] cpuhp_invoke_callback+0x124/0x322
> >> [<ffffffff800142f8>] _cpu_up+0x218/0x322
> >> [<ffffffff8001445e>] cpu_up+0x5c/0x98
> >> [<ffffffff80014bb8>] cpu_device_up+0x14/0x1c
> >> [<ffffffff8066d68e>] cpu_subsys_online+0x10/0x18
> >> [<ffffffff806680e8>] device_online+0x56/0x72
> >> [<ffffffff80668190>] online_store+0x8c/0xae
> >> [<ffffffff80662dde>] dev_attr_store+0xe/0x1a
> >> [<ffffffff802b53bc>] sysfs_kf_write+0x2e/0x4c
> >> [<ffffffff802b4750>] kernfs_fop_write_iter+0xe8/0x14e
> >> [<ffffffff80230170>] vfs_write+0x2a4/0x3e0
> >> [<ffffffff802303e8>] ksys_write+0x5e/0xc8
> >> [<ffffffff80230460>] sys_write+0xe/0x16
> >> [<ffffffff80a4a8de>] do_trap_ecall_u+0xe0/0xf4
> >> [<ffffffff80003e8c>] ret_from_exception+0x0/0x64
> >> irq event stamp: 12335
> >> hardirqs last  enabled at (12335): [<ffffffff8007e542>] console_unlock=
+0x156/0x186
> >> hardirqs last disabled at (12334): [<ffffffff8007e52c>] console_unlock=
+0x140/0x186
> >> softirqs last  enabled at (12154): [<ffffffff80a560d0>] __do_softirq+0=
x3b0/0x470
> >> softirqs last disabled at (12147): [<ffffffff80019340>] __irq_exit_rcu=
+0xa6/0xd0
> >> ---[ end trace 0000000000000000 ]---
> >> ------------[ cut here ]------------
> >> kernel BUG at kernel/irq_work.c:245!
> >> Kernel BUG [#1]
> >> Modules linked in:
> >> CPU: 0 PID: 215 Comm: bash Tainted: G        W          6.5.0-rc1+ #75=
24
> >> Hardware name: riscv-virtio,qemu (DT)
> >> epc : irq_work_run_list+0x30/0x32
> >>   ra : irq_work_run+0x2a/0x4c
> >> ...
> >> [<ffffffff8011a346>] irq_work_run_list+0x30/0x32
> >> [<ffffffff8011a372>] irq_work_run+0x2a/0x4c
> >> [<ffffffff800c9aec>] smpcfd_dying_cpu+0x12/0x1c
> >> [<ffffffff80012b2e>] cpuhp_invoke_callback+0x124/0x322
> >> [<ffffffff800142f8>] _cpu_up+0x218/0x322
> >> [<ffffffff8001445e>] cpu_up+0x5c/0x98
> >> [<ffffffff80014bb8>] cpu_device_up+0x14/0x1c
> >> [<ffffffff8066d68e>] cpu_subsys_online+0x10/0x18
> >> [<ffffffff806680e8>] device_online+0x56/0x72
> >> [<ffffffff80668190>] online_store+0x8c/0xae
> >> [<ffffffff80662dde>] dev_attr_store+0xe/0x1a
> >> [<ffffffff802b53bc>] sysfs_kf_write+0x2e/0x4c
> >> [<ffffffff802b4750>] kernfs_fop_write_iter+0xe8/0x14e
> >> [<ffffffff80230170>] vfs_write+0x2a4/0x3e0
> >> [<ffffffff802303e8>] ksys_write+0x5e/0xc8
> >> [<ffffffff80230460>] sys_write+0xe/0x16
> >> [<ffffffff80a4a8de>] do_trap_ecall_u+0xe0/0xf4
> >> [<ffffffff80003e8c>] ret_from_exception+0x0/0x64
> >> Code: 8526 6084 f0ef f71f fce5 60e2 6442 64a2 6105 8082 (9002) 1101
> >> ---[ end trace 0000000000000000 ]---
> >> Kernel panic - not syncing: Fatal exception in interrupt
> >> SMP: stopping secondary CPUs
> >> SMP: failed to stop secondary CPUs 0-1
> >> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> >>
> >> To avoid calling those checks in the CPU hot-plug paths again and agai=
n,
> >> simply move the check at the beginning of the check_unaligned_access()
> >> function and rely on the value determined during the system boot.
> >>
> >> Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> >> Fixes: c20d36cc2a20 ("riscv: don't probe unaligned access speed if alr=
eady done")
> >> Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to h=
wprobe")
> >> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> > Hi Marek,
> > Thanks for the patch. I happened to spot that bug too
> > (check_unaligned_access_emulated() clobbering the per-cpu variable
> > back to unknown). Since I was rearranging that code to try to run the
> > speed measurements in parallel, I moved that check around to hopefully
> > solve the same issue you're reporting. Can you see if this patch also
> > fixes your issue:
> > https://lore.kernel.org/lkml/20231106225855.3121724-1-evan@rivosinc.com=
/
> > . It's also in Palmer's for-next tree as 55e0bf49a0d0 ("RISC-V: Probe
> > misaligned access speed in parallel").
>
> Thanks for for the information. Yes, Your patch also fixes this issue,
> but it is a bit invasive (it perfectly fits for the -next material
> though). Maybe my little cleanup could be applied as a fix during -rc
> cycle? It has an advantage that it can be easily backported to v6.6-stabl=
e.

That's fine with me.

Reviewed-by: Evan Green <evan@rivosinc.com>
