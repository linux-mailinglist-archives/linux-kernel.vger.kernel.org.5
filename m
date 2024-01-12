Return-Path: <linux-kernel+bounces-24609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B182BF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05934B21133
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902767E68;
	Fri, 12 Jan 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="M4NkbJwx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529663510
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5595997ffso7842315ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705058254; x=1705663054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/r2CUr6NQRTkWJSfnfsoonlWRwu5UcKq/JbWJG+yiE=;
        b=M4NkbJwxobpQJ7ua2oUyJczplkO+iu/aA34PxNETzX0lcPZK2joRbNVragVcvi/z5f
         3kWYzoaf4ruaee2pT5yaknX7oifCW829Y03ISQtxg0pZUX63VYgRveNzKr3ERyqdS+yo
         OqRca7vrXEFws68h/zqKsqF9Ij6jcPfXRNgjk545bYg3prqm4A6ZtIC605K79hXPFU4Y
         w/CA1ubZzjjWr2V6ksIalhHpNoc9qBgQ6vZHZ7r431HV68C1H0gUt65PaJJWgF31R2qG
         kG80P2xLoIvk8j8asxw0afKimBtAL3GeRoTNOMfyraBDILkldKY/oiLwQbVJFv7OvqKz
         xJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705058254; x=1705663054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/r2CUr6NQRTkWJSfnfsoonlWRwu5UcKq/JbWJG+yiE=;
        b=tTCcbFIUteIrGEOn/LNsfGn7PKigGu8m0LZ3156pg2ge/GJk6NmC1rQNlUQxE4BpHP
         gq7QykpElw/pyzaNy7j2jsyuZqVKUyrsetw2m8hAyboQYSaEzvnu/XX8Kkm477hAJHRY
         c8nqukPwLnas4EWtbkt2/IWxuD1JrNxMsb6zlkc6Mkitbu1BR3Op24ui5aGsaghhqnQP
         d/WGHstuDtXmL6Fj6tGzOMMRxo5R36dFsROUC0q2G5Y40Dcl5eWgbACoEx2stDBKnvDv
         6gV0l3aQFkKdpgoWg6pzTYrKSaZ0s2MGJvmV86BRNF/850BKdT0HJiTbG2U4qDvDDYIr
         brjA==
X-Gm-Message-State: AOJu0YxT2Z/hrP6gGOjVFW4kFhUG65cI0uN4l5volGBa7QEI7ga7+tak
	7Zi68wuRfYTSXe3hJwTlb3RJPEtyqZl63g==
X-Google-Smtp-Source: AGHT+IGQohed/oEcJo01neyqBjBHsaj+nu3i/3udCsZR7M7O8D2uGXWtzMc93+BA3NLF+ZCUdujm1w==
X-Received: by 2002:a17:90a:ad8b:b0:28e:1609:88e4 with SMTP id s11-20020a17090aad8b00b0028e160988e4mr326280pjq.3.1705058254520;
        Fri, 12 Jan 2024 03:17:34 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:a276:8a4e:2aa1:5f09])
        by smtp.gmail.com with ESMTPSA id sd12-20020a17090b514c00b0028cef021d45sm3794179pjb.17.2024.01.12.03.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:17:34 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <apatel@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 0/3] riscv: add support for SBI Supervisor Software Events
Date: Fri, 12 Jan 2024 12:17:12 +0100
Message-ID: <20240112111720.2975069-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SBI Supervisor Software Events (SSE) extensions provides a mechanism
to inject software events from an SBI implementation to supervisor
software such that it preempts all other supervisor level traps and
interrupts [1].

Various events are defined and can be send asynchronously to supervisor
software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
as platform specific events. Events can be either local (per-hart) or
global. Events can be nested on top of each other based on priority and
can interrupt the kernel at any time.

First patch adds the SSE definitions. Second one adds support for SSE
itself. Implementation is split between arch specific code and generic
part (similarly to what is done for ARM SDEI). Finally, the last patch
add support for SSE events in the SBI PMU driver. If the SSE event is
available from the SBI then, it will be used instead of the normal
interrupt.

Amongst the specific points that needs to be handle is the interruption
at any point of the kernel execution and more specifically during
exception handling. Due to the fact that the exception entry
implementation uses the SCRATCH CSR as both the current task struct and
as the temporary register to switch the stack and save register, it is
difficult to reliably get the current task struct if we get interrupted
at this specific moment. A fixup-like mechanism allows to mark the
location of the current task struct depending on the entry level
(user/kernel) and the location. This is then used in the SSE assembly to
determine where is located the current task_struct.

Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
handled and does not adds any overhead to existing code. Moreover, it
provides "true" NMI-like interrupts which can interrupt the kernel at
any time (even in exception handling). This is particularly crucial for
RAS errors which needs to be handled as fast as possible to avoid any
fault propagation. Additionally, SSE event handling is faster that the
standard IRQ handling path with almost half executed instruction (700 vs
1590). Some complementary tests/perf measurements will be done.

For testing purpose, one can use the provided SBI implementation at [3].
This series also needs patch [4] to fix a bug in the PMU driver.

Link: https://lists.riscv.org/g/tech-prs/message/744 [1]
Link: https://lore.kernel.org/lkml/20231023082911.23242-10-luxu.kernel@bytedance.com/T/ [2]
Link: https://github.com/rivosinc/opensbi/tree/sse_v2 [3]

---

Changes in v2:
 - Implemented specification v2
 - Fix various error handling cases
 - Added shadow stack support

v1: https://lore.kernel.org/linux-riscv/20231026143122.279437-1-cleger@rivosinc.com/

Clément Léger (3):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  perf: RISC-V: add support for SSE event

 arch/riscv/include/asm/asm-prototypes.h |   4 +
 arch/riscv/include/asm/asm.h            |  42 +-
 arch/riscv/include/asm/sbi.h            |  47 ++
 arch/riscv/include/asm/scs.h            |   7 +
 arch/riscv/include/asm/sse.h            |  12 +
 arch/riscv/include/asm/thread_info.h    |   1 +
 arch/riscv/kernel/Makefile              |   1 +
 arch/riscv/kernel/asm-offsets.c         |  26 ++
 arch/riscv/kernel/entry.S               | 202 +++++++++
 arch/riscv/kernel/sbi.c                 |   4 +
 arch/riscv/kernel/sse.c                 | 130 ++++++
 arch/riscv/kernel/stacktrace.c          |  13 +
 arch/riscv/kernel/vmlinux.lds.S         |   6 +
 drivers/firmware/Kconfig                |  10 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/riscv_sse.c            | 567 ++++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c            |  46 +-
 include/linux/riscv_sse.h               |  76 ++++
 18 files changed, 1176 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sse.c
 create mode 100644 drivers/firmware/riscv_sse.c
 create mode 100644 include/linux/riscv_sse.h

-- 
2.43.0


