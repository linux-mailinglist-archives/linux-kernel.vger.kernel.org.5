Return-Path: <linux-kernel+bounces-160599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A68B3FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA0281017
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F941BC5C;
	Fri, 26 Apr 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYzwGi5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0A18C36
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158485; cv=none; b=PVHCMKx8d9R8ilz066eaKksjH/YlYwEoNdOQ8wmJlhz8KC7SnAnDDUqNiNVcbJv+D0Dio3Qk0Lor/gvbo+E84dHrXGS1lfh9bxXFPguPRUc5VpUTv5DSusTqdLZlctKBJByYJyu/LfjM4cU/YDxHFnCQ0xhZb77ZawtZA/vZkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158485; c=relaxed/simple;
	bh=dpY8OiyiXN06eVO+/tKwn8ABB6M/597kWqbEZbQ1yxk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dJrprCQQ2LcLQF91JDfIwEPHgnmnZdTfK7sLS4MCQI8V0ikxV/hgyjLa333PcftHLNbthVohzZNYzWOpzlVvCloEIDiglogYuAerjOou+6d0Hk1A4h/yZd6nmqFUrpt/qcra5JEJNnI6A8GcqLEGI+8b4KB5/mmQ5Sa/KcbSkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYzwGi5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F2C113CD;
	Fri, 26 Apr 2024 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714158484;
	bh=dpY8OiyiXN06eVO+/tKwn8ABB6M/597kWqbEZbQ1yxk=;
	h=Date:To:Cc:From:Subject:From;
	b=lYzwGi5G07CpiImAEAdt5yVn6OntP6B0IisKUrZuik7Y84U3OTiCWfyxhAfkFpxEN
	 zuBMYTqEc5gKXgAm4LXFYa/XXWPFzi6DxxVa1u51eHQ19oxjzwUhMXtvy1pZIVxs0d
	 VnucSDMpIQ0Q+idiQg7oDjQBy44VfMkq0b9GDPsPYsXLl4H25oROAh3eseGW+IFrc/
	 tP4j9/y1H53v8aItTLXZQ22rmpxiLTroiQjvSs8+Tp6Om4ng9a7EibuQRVIleApotK
	 c3WrCf1GaxCF++0cog2H0Tm9TVci+O/gJoHAdW2klAi/aVz+1vGa/jVxF/w3Ct2HH/
	 vB2FEaTazuf8Q==
Message-ID: <80a2b41e-74da-43cb-8532-fc3b17879201@kernel.org>
Date: Fri, 26 Apr 2024 12:08:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>
From: Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARX fixes for 6.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A few fixes for ARC, please pull !

Thx,
-Vineet
--------------------->
The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
tags/arc-6.9-fixes

for you to fetch changes up to 61231eb8113ce47991f35024f9c20810b37996bf:

  ARC: [plat-hsdk]: Remove misplaced interrupt-cells property
(2024-04-16 10:45:57 -0700)

----------------------------------------------------------------
ARC fixes for 6.9

 - Incorrect VIPT aliasing assumption

 - Miscll build warning fixes and some typos

----------------------------------------------------------------
Alexey Brodkin (1):
      ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Bjorn Helgaas (1):
      ARC: Fix typos

Vineet Gupta (2):
      ARC: Fix -Wmissing-prototypes warnings
      ARC: mm: fix new code about cache aliasing

 arch/arc/Kconfig                          |  1 -
 arch/arc/boot/Makefile                    |  4 ++--
 arch/arc/boot/dts/axc003.dtsi             |  4 ++--
 arch/arc/boot/dts/hsdk.dts                |  1 -
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi      |  2 +-
 arch/arc/include/asm/cachetype.h          |  9 ---------
 arch/arc/include/asm/dsp.h                |  2 +-
 arch/arc/include/asm/entry-compact.h      | 10 +++++-----
 arch/arc/include/asm/entry.h              |  4 ++--
 arch/arc/include/asm/irq.h                |  2 +-
 arch/arc/include/asm/irqflags-compact.h   |  2 +-
 arch/arc/include/asm/mmu_context.h        |  2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h |  2 +-
 arch/arc/include/asm/ptrace.h             |  2 +-
 arch/arc/include/asm/shmparam.h           |  2 +-
 arch/arc/include/asm/smp.h                |  4 ++--
 arch/arc/include/asm/thread_info.h        |  2 +-
 arch/arc/include/uapi/asm/swab.h          |  2 +-
 arch/arc/kernel/entry-arcv2.S             |  8 ++++----
 arch/arc/kernel/entry.S                   |  4 ++--
 arch/arc/kernel/head.S                    |  2 +-
 arch/arc/kernel/intc-arcv2.c              |  2 +-
 arch/arc/kernel/kprobes.c                 |  7 ++++---
 arch/arc/kernel/perf_event.c              |  2 +-
 arch/arc/kernel/setup.c                   |  2 +-
 arch/arc/kernel/signal.c                  |  7 ++++---
 arch/arc/kernel/traps.c                   |  2 +-
 arch/arc/kernel/vmlinux.lds.S             |  4 ++--
 arch/arc/mm/tlb.c                         |  4 ++--
 arch/arc/mm/tlbex.S                       |  8 ++++----
 30 files changed, 50 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arc/include/asm/cachetype.h

