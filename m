Return-Path: <linux-kernel+bounces-3347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA519816B50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302EBB21333
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065C0168DD;
	Mon, 18 Dec 2023 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sB82Qz9j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9315490
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58e256505f7so2075204eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702896077; x=1703500877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAExNJX/YhcccIuIFbir4pLgBR3qGdMXJeV+rbaaqC4=;
        b=sB82Qz9jn/1vXf4iFqaX9zthIM9P/nBvrrAvvXXwNIRSw+AbpaN8yo8cd1tN7VBVVI
         IH8rRyuX11TC3hgVUc9oPFwkaWrZboMF4w8yv8VJSndgHOsNiS6ipBIh0KGYJ5hwT5zq
         Tby6S+s5AJpUMpsqMID6vOtMDo8ddkO6t+Qvf5RHmHGiZGM1YMOKQg7qrzcrqH9PmcS8
         JMSGIvDiXhpXbHPN8RKGaQGoaCByyXMMBCvHCUq8W2a4R1qSSGcweJQmmgyTPf4TBTHN
         so7pghIxgm90hz8+4JA9UQ4zfGBce/nZaDD0AjrWattLIQ0wcnkAGXlEAyXiKGvOI2ss
         QUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702896077; x=1703500877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAExNJX/YhcccIuIFbir4pLgBR3qGdMXJeV+rbaaqC4=;
        b=bL43pAZ/uCu4DkCqh1Q4n9Uh5xb+cdU79h4OqFuOqHZZSwtUzsoMWpY3vkzZ0rZe0T
         x6WYHnTWaUfFWnjHquwYaXKEPz5gJtahUcNsOGVP4llnx1BCjR40AXjPwjjS/eVd36a0
         GcR+08HjcI0l/cjscz2F2rlnQDlDOqixguIA7bDaNZH/WF4iDLeWqRtdzqRNRbgwMDcq
         EXNG6xqV/qvKAX8HdtPRcGVYnkaT84njOaRSnyCQOsZbXpVMzpPiaQiMPMbOFrgmQai8
         D7Ry2S3XwtDe6cbKw/FJHYKxlRm/qkubQJUsKkaOfAj5YcOAW0CIx26VU90xxm1q4kBh
         tyYw==
X-Gm-Message-State: AOJu0YxmbrPZYAWeN215sOiBCiu202TlGA21sVFmNfPAMwuwAJArqqOf
	WVAbrDQ/Lj7tjndOX4DCtUdRCshU19nP9V5efu4=
X-Google-Smtp-Source: AGHT+IGDKrqtxtZbZ8QYlYUWKhg2x8cwPY4Y/RPNofta2lY7xmBPtEBlNRLdIG8f3YPqu7ksXNPzqA==
X-Received: by 2002:a05:6820:607:b0:590:2df8:1bc7 with SMTP id e7-20020a056820060700b005902df81bc7mr12054984oow.1.1702896076749;
        Mon, 18 Dec 2023 02:41:16 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a1ac2000000b005907ad9f302sm574970oof.37.2023.12.18.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:41:16 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [v1 00/10] RISC-V SBI v2.0 PMU improvements and Perf sampling in KVM guest
Date: Mon, 18 Dec 2023 02:40:57 -0800
Message-Id: <20231218104107.2976925-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements SBI PMU improvements done in SBI v2.0[1] i.e. PMU snapshot
and fw_read_hi() functions. 

SBI v2.0 introduced PMU snapshot feature which allows the SBI implementation
to provide counter information (i.e. values/overlfow status) via a shared
memory between the SBI implementation and supervisor OS. This allows to minimize
the number of traps in when perf being used inside a kvm guest as it relies on
SBI PMU + trap/emulation of the counters. 

The current set of ratified RISC-V specification also doesn't allow scountovf
to be trap/emulated by the hypervisor. The SBI PMU snapshot bridges the gap
in ISA as well and enables perf sampling in the guest. However, LCOFI in the
guest only works via IRQ filtering in AIA specification. That's why, AIA
has to be enabled in the hardware (at least the Ssaia extension) in order to
use the sampling support in the perf. 

Here are the patch wise implementation details.

PATCH 1,6,7 : Generic cleanups/improvements.
PATCH 2,3,10 : FW_READ_HI function implementation
PATCH 4-5: Add PMU snapshot feature in sbi pmu driver
PATCH 6-7: KVM implementation for snapshot and sampling in kvm guests

The series is based on v6.70-rc3 and is available at:

https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v1

The kvmtool patch is also available at:
https://github.com/atishp04/kvmtool/tree/sscofpmf

It also requires Ssaia ISA extension to be present in the hardware in order to
get perf sampling support in the guest. In Qemu virt machine, it can be done
by the following config.

```
-cpu rv64,sscofpmf=true,x-ssaia=true
```

There is no other dependancies on AIA apart from that. Thus, Ssaia must be disabled
for the guest if AIA patches are not available. Here is the example command.

```
./lkvm-static run -m 256 -c2 --console serial -p "console=ttyS0 earlycon" --disable-ssaia -k ./Image --debug 
```

The series has been tested only in Qemu.
Here is the snippet of the perf running inside a kvm guest.

===================================================
# perf record -e cycles -e instructions perf bench sched messaging -g 5
...
# Running 'sched/messaging' benchmark:
...
[   45.928723] perf_duration_warn: 2 callbacks suppressed
[   45.929000] perf: interrupt took too long (484426 > 483186), lowering kernel.perf_event_max_sample_rate to 250
# 20 sender and receiver processes per group
# 5 groups == 200 processes run

     Total time: 14.220 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.117 MB perf.data (1942 samples) ]
# perf report --stdio
# To display the perf.data header info, please use --header/--header-only optio>
#
#
# Total Lost Samples: 0
#
# Samples: 943  of event 'cycles'
# Event count (approx.): 5128976844
#
# Overhead  Command          Shared Object                Symbol               >
# ........  ...............  ...........................  .....................>
#
     7.59%  sched-messaging  [kernel.kallsyms]            [k] memcpy
     5.48%  sched-messaging  [kernel.kallsyms]            [k] percpu_counter_ad>
     5.24%  sched-messaging  [kernel.kallsyms]            [k] __sbi_rfence_v02_>
     4.00%  sched-messaging  [kernel.kallsyms]            [k] _raw_spin_unlock_>
     3.79%  sched-messaging  [kernel.kallsyms]            [k] set_pte_range
     3.72%  sched-messaging  [kernel.kallsyms]            [k] next_uptodate_fol>
     3.46%  sched-messaging  [kernel.kallsyms]            [k] filemap_map_pages
     3.31%  sched-messaging  [kernel.kallsyms]            [k] handle_mm_fault
     3.20%  sched-messaging  [kernel.kallsyms]            [k] finish_task_switc>
     3.16%  sched-messaging  [kernel.kallsyms]            [k] clear_page
     3.03%  sched-messaging  [kernel.kallsyms]            [k] mtree_range_walk
     2.42%  sched-messaging  [kernel.kallsyms]            [k] flush_icache_pte

===================================================

[1] https://github.com/riscv-non-isa/riscv-sbi-doc

Changes from RFC->v1:
1. Addressed all the comments on RFC series.
2. Removed PATCH2 and merged into later patches.
3. Added 2 more patches for minor fixes.
4. Fixed KVM boot issue without Ssaia and made sscofpmf in guest dependant on
   Ssaia in the host.

Atish Patra (10):
RISC-V: Fix the typo in Scountovf CSR name
RISC-V: Add FIRMWARE_READ_HI definition
drivers/perf: riscv: Read upper bits of a firmware counter
RISC-V: Add SBI PMU snapshot definitions
drivers/perf: riscv: Implement SBI PMU snapshot function
RISC-V: KVM: No need to update the counter value during reset
RISC-V: KVM: No need to exit to the user space if perf event failed
RISC-V: KVM: Implement SBI PMU Snapshot feature
RISC-V: KVM: Add perf sampling support for guests
RISC-V: KVM: Support 64 bit firmware counters on RV32

arch/riscv/include/asm/csr.h          |   5 +-
arch/riscv/include/asm/errata_list.h  |   2 +-
arch/riscv/include/asm/kvm_vcpu_pmu.h |  14 +-
arch/riscv/include/asm/sbi.h          |  12 ++
arch/riscv/include/uapi/asm/kvm.h     |   1 +
arch/riscv/kvm/aia.c                  |   5 +
arch/riscv/kvm/main.c                 |   1 +
arch/riscv/kvm/vcpu.c                 |   8 +-
arch/riscv/kvm/vcpu_onereg.c          |   9 +-
arch/riscv/kvm/vcpu_pmu.c             | 246 ++++++++++++++++++++++++--
arch/riscv/kvm/vcpu_sbi_pmu.c         |  15 +-
drivers/perf/riscv_pmu.c              |   1 +
drivers/perf/riscv_pmu_sbi.c          | 230 ++++++++++++++++++++++--
include/linux/perf/riscv_pmu.h        |   6 +
14 files changed, 510 insertions(+), 45 deletions(-)

--
2.34.1


