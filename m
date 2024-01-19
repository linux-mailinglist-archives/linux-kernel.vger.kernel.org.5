Return-Path: <linux-kernel+bounces-31558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE15833009
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF341F23638
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52957865;
	Fri, 19 Jan 2024 21:01:22 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9357302;
	Fri, 19 Jan 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698082; cv=none; b=AIZ2NhrKof8Rf98eZV3kRglrMMleiXBpRo2TSDG+OvpuUaSQ7VxNpMJzToiQbW5GZfebgED2VXlMqwfq35aBDcR2xThYg3euR4XxkUQG7ViDMvPc1onbCxZmi8KyRqtWtRVPQMVsB60ldJjArmaZ7GkGFCPZm18M6QB6eUJ9yQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698082; c=relaxed/simple;
	bh=v4s0HXJ/I8JQ3heLTrKQMmV7i3OSZG42/QKaEOyi/lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH64xK5RSvWxa2UVx52IlK+NlBpbejlrnQcOzl5+mpA19mjdFEKPj1VM/cm6+8DWp/uMoDLUMgYfVSgOp3/zUN/4eE5XybdlFOmEUGzHcZJmZ5SNXtx4c9JwILsnxjYQZZ9irw3SmW0sA0LVLB+jy3DnbCvrJ9M3gGYzTW/xSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dbb003be79so1512271b3a.0;
        Fri, 19 Jan 2024 13:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698080; x=1706302880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lj50u8kXspOZzoOFdiIZuTON2LhOLKNsOg0lxXWMDQ=;
        b=XMR0nlj8pGMXTRY5p7TtXTI2xTm4OvfDDRgpG0hba3OR2rBUqdI8o/h4Wthxf+S1lE
         /tjAl9RSSl9Wcf5x4Miy+wGzmGef+BGNWU7CU/eIK8WXQWJzL+HTtaTBHk3c69ZhszBK
         739NwAijX6zbp7M4BCZ+D8CUou7/wKXb5PbCM7hXCsWTcDNlI1zSTgx3p3NSKbbpxG6F
         JlZV2bX9GNTrkf1HH3Ei6Qp3h12y14KRjyz+InRdgtdDGICXCkRrf2uuu5doTvpeHF4e
         bmBGAH9VOq5kOw4qpGH7OAwyibZSVNET9OYa3Jul/PMfArpOSr7wenGM5dgLSJos4Fe8
         xB/w==
X-Gm-Message-State: AOJu0YzQuzOIf3yPM2Lbk3+LspOpSC1i+tjpF4+hv6za38O27/O7ltEG
	oG/lmA2+E/NTAdSNVihXOc/FHGKYk7iw2OuYJvCYjxiNVpwIVPr7ADY954KwLNz0Ad+t32qEoiy
	clo+/rwFoqp3xrqmCYkB9xbEyuRXGL7sM
X-Google-Smtp-Source: AGHT+IE62CtDRQvCVg1v07ioRTxcJGM1k8mWFDMDqxbK7QUYh05SHUHWNFcXBpKg1rcDfhI2X+X04b436xuCavptkuw=
X-Received: by 2002:a17:90b:3642:b0:28d:fd67:fa9c with SMTP id
 nh2-20020a17090b364200b0028dfd67fa9cmr637793pjb.37.1705698079688; Fri, 19 Jan
 2024 13:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111204348.669673-2-namhyung@kernel.org> <202401191023.d52a4ad4-oliver.sang@intel.com>
In-Reply-To: <202401191023.d52a4ad4-oliver.sang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 13:01:08 -0800
Message-ID: <CAM9d7cjPAB5OpwgeBeuYkPbU6L+0+0FOJyBq=0HL+uOar275mQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf/core: Reduce PMU access to adjust sample freq
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 18, 2024 at 6:41=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_arch/x86/events/core.c:#x86_pmu_sta=
rt" on:
>
> commit: d6da92786f901cc4ce3588f101182758da295dbb ("[PATCH v2 2/2] perf/co=
re: Reduce PMU access to adjust sample freq")
> url: https://github.com/intel-lab-lkp/linux/commits/namhyung-kernel-org/p=
erf-core-Reduce-PMU-access-to-adjust-sample-freq/20240112-044505
> base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.g=
it perf-tools-next
> patch link: https://lore.kernel.org/all/20240111204348.669673-2-namhyung@=
kernel.org/
> patch subject: [PATCH v2 2/2] perf/core: Reduce PMU access to adjust samp=
le freq
>
> in testcase: will-it-scale
> version: will-it-scale-x86_64-75f66e4-1_20240111
> with following parameters:
>
>         nr_task: 16
>         mode: thread
>         test: pipe1
>         cpufreq_governor: performance
>
>
>
> compiler: gcc-12
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)

Thanks for the report.  It seems the code calls x86_pmu_stop() without
PERF_EF_UPDATE so we cannot simply skip the stop callback for
frequency events.  I'll update it in v3.

Thanks,
Namhyung

>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202401191023.d52a4ad4-oliver.san=
g@intel.com
>
>
> [  102.087071][   C94] ------------[ cut here ]------------
> [ 102.092623][ C94] WARNING: CPU: 94 PID: 0 at arch/x86/events/core.c:150=
7 x86_pmu_start (arch/x86/events/core.c:1507 (discriminator 1))
> [  102.101826][   C94] Modules linked in: intel_rapl_msr intel_rapl_commo=
n skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp btrfs coret=
emp blake2b_generic xor kvm_intel kvm raid6_pq libcrc32c irqbypass crct10di=
f_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 sd_mod =
sg rapl ipmi_ssif nvme nvme_core ahci intel_cstate acpi_ipmi t10_pi libahci=
 ast crc64_rocksoft_generic drm_shmem_helper mei_me ipmi_si crc64_rocksoft =
i2c_i801 ioatdma libata intel_uncore drm_kms_helper joydev crc64 mei ipmi_d=
evintf lpc_ich i2c_smbus intel_pch_thermal dca wmi ipmi_msghandler acpi_pad=
 acpi_power_meter drm fuse ip_tables
> [  102.158393][   C94] CPU: 94 PID: 0 Comm: swapper/94 Not tainted 6.7.0-=
rc6-00192-gd6da92786f90 #1
> [ 102.167472][ C94] RIP: 0010:x86_pmu_start (arch/x86/events/core.c:1507 =
(discriminator 1))
> [ 102.172832][ C94] Code: 00 00 4c 0f ab 65 00 48 89 df e8 16 08 01 00 48=
 89 df 5b 5d 41 5c e9 4a c6 33 00 0f 0b 5b 5d 41 5c c3 cc cc cc cc 0f 0b eb=
 f3 <0f> 0b eb b6 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 00                   add    %al,(%rax)
>    2:   4c 0f ab 65 00          bts    %r12,0x0(%rbp)
>    7:   48 89 df                mov    %rbx,%rdi
>    a:   e8 16 08 01 00          callq  0x10825
>    f:   48 89 df                mov    %rbx,%rdi
>   12:   5b                      pop    %rbx
>   13:   5d                      pop    %rbp
>   14:   41 5c                   pop    %r12
>   16:   e9 4a c6 33 00          jmpq   0x33c665
>   1b:   0f 0b                   ud2
>   1d:   5b                      pop    %rbx
>   1e:   5d                      pop    %rbp
>   1f:   41 5c                   pop    %r12
>   21:   c3                      retq
>   22:   cc                      int3
>   23:   cc                      int3
>   24:   cc                      int3
>   25:   cc                      int3
>   26:   0f 0b                   ud2
>   28:   eb f3                   jmp    0x1d
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   eb b6                   jmp    0xffffffffffffffe4
>   2e:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>   35:   00 00 00 00
>   39:   66                      data16
>   3a:   66                      data16
>   3b:   2e                      cs
>   3c:   0f                      .byte 0xf
>   3d:   1f                      (bad)
>   3e:   84 00                   test   %al,(%rax)
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   eb b6                   jmp    0xffffffffffffffba
>    4:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>    b:   00 00 00 00
>    f:   66                      data16
>   10:   66                      data16
>   11:   2e                      cs
>   12:   0f                      .byte 0xf
>   13:   1f                      (bad)
>   14:   84 00                   test   %al,(%rax)
> [  102.192917][   C94] RSP: 0018:ffffc9000ddb0e00 EFLAGS: 00010046
> [  102.199175][   C94] RAX: 0000000000000001 RBX: ffff88b01d17a290 RCX: 0=
000000000000349
> [  102.207339][   C94] RDX: 0000000000002ff0 RSI: 0000000000000002 RDI: f=
fff88b01d17a290
> [  102.215509][   C94] RBP: ffff88afa149a220 R08: 0000000000000000 R09: 0=
000000000000014
> [  102.223684][   C94] R10: 000000000000000f R11: 00000000000f4240 R12: 0=
000000000000003
> [  102.231855][   C94] R13: 0000000000000001 R14: ffff88afa14b9680 R15: 0=
00000000000005e
> [  102.240038][   C94] FS:  0000000000000000(0000) GS:ffff88afa1480000(00=
00) knlGS:0000000000000000
> [  102.249178][   C94] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  102.255986][   C94] CR2: 00007f9cdf69ec98 CR3: 000000303e01c002 CR4: 0=
0000000007706f0
> [  102.264179][   C94] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [  102.272365][   C94] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [  102.280552][   C94] PKRU: 55555554
> [  102.284322][   C94] Call Trace:
> [  102.287830][   C94]  <IRQ>
> [ 102.290895][ C94] ? x86_pmu_start (arch/x86/events/core.c:1507 (discrim=
inator 1))
> [ 102.295695][ C94] ? __warn (kernel/panic.c:677)
> [ 102.299980][ C94] ? x86_pmu_start (arch/x86/events/core.c:1507 (discrim=
inator 1))
> [ 102.304768][ C94] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [ 102.309473][ C94] ? handle_bug (arch/x86/kernel/traps.c:237)
> [ 102.314006][ C94] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discri=
minator 1))
> [ 102.318879][ C94] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h=
:568)
> [ 102.324101][ C94] ? x86_pmu_start (arch/x86/events/core.c:1507 (discrim=
inator 1))
> [ 102.328888][ C94] perf_adjust_freq_unthr_events (kernel/events/core.c:4=
181 (discriminator 4))
> [ 102.335069][ C94] perf_adjust_freq_unthr_context (kernel/events/core.c:=
4216)
> [ 102.341244][ C94] perf_event_task_tick (arch/x86/include/asm/current.h:=
41 kernel/events/core.c:4363)
> [ 102.346458][ C94] scheduler_tick (kernel/sched/core.c:5665)
> [ 102.351240][ C94] update_process_times (kernel/time/timer.c:2079)
> [ 102.356442][ C94] tick_sched_handle (kernel/time/tick-sched.c:256)
> [ 102.361381][ C94] tick_nohz_highres_handler (kernel/time/tick-sched.c:1=
525)
> [ 102.367021][ C94] ? __pfx_tick_nohz_highres_handler (kernel/time/tick-s=
ched.c:1503)
> [ 102.373345][ C94] __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kern=
el/time/hrtimer.c:1752)
> [ 102.378720][ C94] hrtimer_interrupt (kernel/time/hrtimer.c:1817)
> [ 102.383748][ C94] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/a=
pic.c:1065 arch/x86/kernel/apic/apic.c:1082)
> [ 102.389818][ C94] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/api=
c.c:1076 (discriminator 14))
> [  102.395636][   C94]  </IRQ>
> [  102.398759][   C94]  <TASK>
> [ 102.401872][ C94] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm=
/idtentry.h:649)
> [ 102.408032][ C94] RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidl=
e.c:291)
> [ 102.414008][ C94] Code: 00 e8 9e 46 19 ff e8 d9 f1 ff ff 8b 53 04 49 89=
 c5 0f 1f 44 00 00 31 ff e8 07 2e 18 ff 45 84 ff 0f 85 d2 00 00 00 fb 45 85=
 f6 <0f> 88 83 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d 0c c4 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 e8                   add    %ch,%al
>    2:   9e                      sahf
>    3:   46 19 ff                rex.RX sbb %r15d,%edi
>    6:   e8 d9 f1 ff ff          callq  0xfffffffffffff1e4
>    b:   8b 53 04                mov    0x4(%rbx),%edx
>    e:   49 89 c5                mov    %rax,%r13
>   11:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   16:   31 ff                   xor    %edi,%edi
>   18:   e8 07 2e 18 ff          callq  0xffffffffff182e24
>   1d:   45 84 ff                test   %r15b,%r15b
>   20:   0f 85 d2 00 00 00       jne    0xf8
>   26:   fb                      sti
>   27:   45 85 f6                test   %r14d,%r14d
>   2a:*  0f 88 83 01 00 00       js     0x1b3            <-- trapping inst=
ruction
>   30:   49 63 d6                movslq %r14d,%rdx
>   33:   48 8d 04 52             lea    (%rdx,%rdx,2),%rax
>   37:   48 8d 04 82             lea    (%rdx,%rax,4),%rax
>   3b:   49 8d 0c c4             lea    (%r12,%rax,8),%rcx
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 88 83 01 00 00       js     0x189
>    6:   49 63 d6                movslq %r14d,%rdx
>    9:   48 8d 04 52             lea    (%rdx,%rdx,2),%rax
>    d:   48 8d 04 82             lea    (%rdx,%rax,4),%rax
>   11:   49 8d 0c c4             lea    (%r12,%rax,8),%rcx
>   15:   48                      rex.W
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240119/202401191023.d52a4ad4-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

