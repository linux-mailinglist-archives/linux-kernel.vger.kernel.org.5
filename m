Return-Path: <linux-kernel+bounces-141929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24A8A252E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709501F22012
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764F8495;
	Fri, 12 Apr 2024 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcG37mzX"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4CD531
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896453; cv=none; b=JcXS/y4gg+NgAra4JdeajIAHAtI1d4ujeNgR7RqCyRgtNlfXm+1mhrRNh5+iHJTkjbsHhH9FeQkYHVqnMcJlpdwrEG7wBSz8CssWtmgExdQPl9nl8m7w41+e2swgSMPZHQUeGHNFLLb3M1h9XEKgkBpmgoArOVzQ19dHHyh8Uuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896453; c=relaxed/simple;
	bh=hnHGiSG/U2a/XxCUkClEliTTjPWqOmnXRc4DYAUGGkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVxggUo5IFXMx1QTekCMunfHr0cIu/ZVFLUU0CyBBfyimGLKho2fnYWi7sO6xyDtp/kgnL02hk/bO9MU3QuBC9+fRhWH8VMuE71+RpnYHPUu7WIT9ZR78No2wQAyorSPQ2k3whFyN9f2SNO6CsseAg6eNNwM6jCTtOhfZhK9Pfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcG37mzX; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4db10f7970aso185332e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712896451; x=1713501251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfQBclGF2ok2HY6dYc6H8LYHQ/mj/70qriA+Xp1XP7s=;
        b=BcG37mzX2DF+S/261jCo6384cQJeY5hml76THWnup/I5qB2uuSvfPywVFupAQi+DUg
         rETR48yy5sKB9QB24/k0noayxF/fW7pzV5Jm8iiM2DIwww3oaFpfEt6ghWXrU8n1Cqfc
         TpIgc6G/LOMf+udFMmPUZ0dY1inem9/N4A0xVHC39YFFWa+j8HGwqJiUYsllezC9UUK2
         8U+VeqXhE19PzKawIGIsjzkhzriLpC889G3/HKVj/GZE3U30e3dPCVEeSSZQeQKsgvAa
         kSFcoQ08YW9oO2DzmMUMADoKctAJ6doKMbYANLoauqVYRJb/HKf/ZDe6ZbMtoIPEg/KA
         k2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712896451; x=1713501251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfQBclGF2ok2HY6dYc6H8LYHQ/mj/70qriA+Xp1XP7s=;
        b=H+izA5XpYgZu+wCb5+kG0UP5nx6pKb6YsZQZw5zwcZnkvHfFHoTEOVhQUmUoxBaytV
         Vy+jObiavFJhWglbNyo28bWrEqRZF2bebLsliQMA9u322H9//BxdH+fxHEgYOoGJW8/c
         9whPV1oRv8Fo2yCixKToFfszjJxG9YKauTugm/SQb5RKacIl6OnQu4ZMW/QkDNBIOQj8
         aYmqBvC/eOPgXw3W5ZcYedOSVQGhyN504KxJWkUGw6FtonOn3EMh8T2kBHEamyOZcIjU
         ENW1HOwbeQAxs0CICBgxOb9z1Y+q6z2L6F2QPHlOiEZhn+WIDpw8wWzNU0qEOpZ7ac2w
         A+zw==
X-Forwarded-Encrypted: i=1; AJvYcCXYnq1F0jV5zIo5kU71Dk/kdN9SE/Um5f8ktcSpx5cNEpB374aTWi1OfmXEio7QyLFHoHF8uzcihSkaJCXuPOagk/dr//KLYJ/K3m8g
X-Gm-Message-State: AOJu0YyAeTUR5WBoQCW/9w2EF7TXPBaStFAmNBFdKkkOkXlaMo6Ab5sd
	CQgMEu4XvVWto4KZ265pzF9a0A4WV9kjBGxgQduwAt0hoXyVLt1Jx2UdUNI+7LTrVQRsI08o0zX
	2bln41ozijIrzA3sabCJG9SaQ+cc=
X-Google-Smtp-Source: AGHT+IF/BdOsXegcEzNxCKRTrga2W3wsq3bl5UoN2e7XAhLKt1u2XY5qdlMdTZpSQxP9dxk5RRnyrqz0EkCwhbUVxWA=
X-Received: by 2002:a05:6122:3296:b0:4d4:2069:eafb with SMTP id
 cj22-20020a056122329600b004d42069eafbmr1667573vkb.9.1712896450616; Thu, 11
 Apr 2024 21:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404121129.c53d5406-oliver.sang@intel.com>
In-Reply-To: <202404121129.c53d5406-oliver.sang@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 16:33:59 +1200
Message-ID: <CAGsJ_4xn7JpnRkP3oqucR7Vpd+gtG-O0REBbX-oze9HnQbSobg@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] cf5dec6389: WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
To: kernel test robot <oliver.sang@intel.com>
Cc: Barry Song <v-songbaohua@oppo.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:19=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_arch/x86/mm/fault.c:#do_user_addr_f=
ault" on:
>
> commit: cf5dec6389f307a43c6c494660e28f16c7e0265a ("mm: fix powerpc build =
issue")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master a053fd3ca5d1b927a8655f239c84b0d790218fd=
a]
>
> in testcase: boot
>
> compiler: clang-17
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +----------------------------------------------------+------------+------=
------+
> |                                                    | d9130022ad | cf5de=
c6389 |
> +----------------------------------------------------+------------+------=
------+
> | WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault | 0          | 6    =
      |
> | EIP:do_user_addr_fault                             | 0          | 6    =
      |
> | EIP:string                                         | 0          | 6    =
      |
> | BUG:unable_to_handle_page_fault_for_address        | 0          | 6    =
      |
> | Oops:#[##]                                         | 0          | 6    =
      |
> | Kernel_panic-not_syncing:Fatal_exception           | 0          | 6    =
      |
> +----------------------------------------------------+------------+------=
------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404121129.c53d5406-oliver.san=
g@intel.com

Hi Oliver,
thanks for your report! I can't see the direct connection between this cras=
h
and dynamical allocated mthp_stats.

however,  as we are moving to dynamic alloc_percpu, there is
a possibility the memory for mthp_stats is not allocated though.

on x86, we have the below,

static inline int has_transparent_hugepage(void)
{
        return boot_cpu_has(X86_FEATURE_PSE);
}

if this is false, we don't allocate mthp_stats at all.

I will check mthp_stats is not NULL before accessing it in patchset v5.

>
>
> [  122.507941][  T251] ------------[ cut here ]------------
> [  122.508786][  T251] ------------[ cut here ]------------
> [ 122.509528][ T251] WARNING: CPU: 1 PID: 251 at arch/x86/mm/fault.c:1308=
 do_user_addr_fault (arch/x86/mm/fault.c:1308)
> [  122.510801][  T251] Modules linked in: crc32_pclmul aesni_intel crypto=
_simd evdev drm drm_panel_orientation_quirks firmware_class zstd_decompress=
 zstd_common autofs4
> [  122.512743][  T251] CPU: 1 PID: 251 Comm: dpkg-deb Tainted: G        W=
        N 6.9.0-rc2-00330-gcf5dec6389f3 #1
> [  122.514132][  T251] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 122.515462][ T251] EIP: do_user_addr_fault (arch/x86/mm/fault.c:1308)
> [ 122.516186][ T251] Code: 03 00 00 83 c4 04 e9 ba fd ff ff 0f 0b e9 b3 f=
d ff ff 89 f9 89 da 56 e8 ff 06 00 00 8b 55 e8 8b 4d e4 83 c4 04 e9 c8 fc f=
f ff <0f> 0b 89 f9 89 da 56 e8 b5 00 00 00 83 c4 04 e9 87 fd ff ff 8b 45
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   03 00                   add    (%rax),%eax
>    2:   00 83 c4 04 e9 ba       add    %al,-0x4516fb3c(%rbx)
>    8:   fd                      std
>    9:   ff                      (bad)
>    a:   ff 0f                   decl   (%rdi)
>    c:   0b e9                   or     %ecx,%ebp
>    e:   b3 fd                   mov    $0xfd,%bl
>   10:   ff                      (bad)
>   11:   ff 89 f9 89 da 56       decl   0x56da89f9(%rcx)
>   17:   e8 ff 06 00 00          call   0x71b
>   1c:   8b 55 e8                mov    -0x18(%rbp),%edx
>   1f:   8b 4d e4                mov    -0x1c(%rbp),%ecx
>   22:   83 c4 04                add    $0x4,%esp
>   25:   e9 c8 fc ff ff          jmp    0xfffffffffffffcf2
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   89 f9                   mov    %edi,%ecx
>   2e:   89 da                   mov    %ebx,%edx
>   30:   56                      push   %rsi
>   31:   e8 b5 00 00 00          call   0xeb
>   36:   83 c4 04                add    $0x4,%esp
>   39:   e9 87 fd ff ff          jmp    0xfffffffffffffdc5
>   3e:   8b                      .byte 0x8b
>   3f:   45                      rex.RB
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   89 f9                   mov    %edi,%ecx
>    4:   89 da                   mov    %ebx,%edx
>    6:   56                      push   %rsi
>    7:   e8 b5 00 00 00          call   0xc1
>    c:   83 c4 04                add    $0x4,%esp
>    f:   e9 87 fd ff ff          jmp    0xfffffffffffffd9b
>   14:   8b                      .byte 0x8b
>   15:   45                      rex.RB
> [  122.518827][  T251] EAX: 80000000 EBX: 00000000 ECX: ecd11e00 EDX: ece=
af3c0
> [  122.519822][  T251] ESI: 80000040 EDI: ecf11cdc EBP: ecf11cb8 ESP: ecf=
11c8c
> [  122.520643][  T251] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAG=
S: 00010046
> [  122.521539][  T251] CR0: 80050033 CR2: 80000040 CR3: 2cc98000 CR4: 000=
40690
> [  122.522448][  T251] Call Trace:
> [ 122.522885][ T251] ? show_regs (arch/x86/kernel/dumpstack.c:478)
> [ 122.523435][ T251] ? __warn (kernel/panic.c:240 kernel/panic.c:694)
> [ 122.523958][ T251] ? do_user_addr_fault (arch/x86/mm/fault.c:1308)
> [ 122.524553][ T251] ? report_bug (lib/bug.c:199)
> [ 122.525103][ T251] ? exc_overflow (arch/x86/kernel/traps.c:252)
> [ 122.525624][ T251] ? handle_bug (arch/x86/kernel/traps.c:239)
> [ 122.526180][ T251] ? exc_invalid_op (arch/x86/kernel/traps.c:260)
> [ 122.526753][ T251] ? handle_exception (arch/x86/entry/entry_32.S:1054)
> [ 122.527347][ T251] ? xas_create_range (lib/xarray.c:729)
> [ 122.527986][ T251] ? xas_create_range (lib/xarray.c:729)
> [ 122.528578][ T251] ? exc_overflow (arch/x86/kernel/traps.c:252)
> [ 122.529134][ T251] ? do_user_addr_fault (arch/x86/mm/fault.c:1308)
> [ 122.529801][ T251] ? exc_overflow (arch/x86/kernel/traps.c:252)
> [ 122.530345][ T251] ? do_user_addr_fault (arch/x86/mm/fault.c:1308)
> [ 122.530992][ T251] ? __this_cpu_preempt_check (lib/smp_processor_id.c:6=
7)
> [ 122.531680][ T251] exc_page_fault (arch/x86/include/asm/irqflags.h:19 a=
rch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/=
x86/mm/fault.c:1519 arch/x86/mm/fault.c:1569)
> [ 122.532252][ T251] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c=
:1524)
> [ 122.533061][ T251] handle_exception (arch/x86/entry/entry_32.S:1054)
> [ 122.533679][ T251] EIP: string (lib/vsprintf.c:646)
> [ 122.534266][ T251] Code: 54 24 04 85 f6 75 4b 31 f6 eb 79 89 04 24 89 5=
4 24 04 c1 fa 10 74 78 31 ff eb 0c 90 90 90 90 90 90 90 47 39 fa 74 6e 8d 3=
4 39 <0f> b6 04 3b 84 c0 74 69 3b 74 24 08 73 ea 88 06 eb e6 89 c6 0f b7
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   54                      push   %rsp
>    1:   24 04                   and    $0x4,%al
>    3:   85 f6                   test   %esi,%esi
>    5:   75 4b                   jne    0x52
>    7:   31 f6                   xor    %esi,%esi
>    9:   eb 79                   jmp    0x84
>    b:   89 04 24                mov    %eax,(%rsp)
>    e:   89 54 24 04             mov    %edx,0x4(%rsp)
>   12:   c1 fa 10                sar    $0x10,%edx
>   15:   74 78                   je     0x8f
>   17:   31 ff                   xor    %edi,%edi
>   19:   eb 0c                   jmp    0x27
>   1b:   90                      nop
>   1c:   90                      nop
>   1d:   90                      nop
>   1e:   90                      nop
>   1f:   90                      nop
>   20:   90                      nop
>   21:   90                      nop
>   22:   47 39 fa                rex.RXB cmp %r15d,%r10d
>   25:   74 6e                   je     0x95
>   27:   8d 34 39                lea    (%rcx,%rdi,1),%esi
>   2a:*  0f b6 04 3b             movzbl (%rbx,%rdi,1),%eax               <=
-- trapping instruction
>   2e:   84 c0                   test   %al,%al
>   30:   74 69                   je     0x9b
>   32:   3b 74 24 08             cmp    0x8(%rsp),%esi
>   36:   73 ea                   jae    0x22
>   38:   88 06                   mov    %al,(%rsi)
>   3a:   eb e6                   jmp    0x22
>   3c:   89 c6                   mov    %eax,%esi
>   3e:   0f                      .byte 0xf
>   3f:   b7                      .byte 0xb7
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f b6 04 3b             movzbl (%rbx,%rdi,1),%eax
>    4:   84 c0                   test   %al,%al
>    6:   74 69                   je     0x71
>    8:   3b 74 24 08             cmp    0x8(%rsp),%esi
>    c:   73 ea                   jae    0xfffffffffffffff8
>    e:   88 06                   mov    %al,(%rsi)
>   10:   eb e6                   jmp    0xfffffffffffffff8
>   12:   89 c6                   mov    %eax,%esi
>   14:   0f                      .byte 0xf
>   15:   b7                      .byte 0xb7
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240412/202404121129.c53d5406-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

