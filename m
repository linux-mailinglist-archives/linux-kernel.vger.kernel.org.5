Return-Path: <linux-kernel+bounces-93748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB3873491
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F072B285FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A160259;
	Wed,  6 Mar 2024 10:25:12 +0000 (UTC)
Received: from out187-18.us.a.mail.aliyun.com (out187-18.us.a.mail.aliyun.com [47.90.187.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732E5FDC8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720712; cv=none; b=ruzISdTa0IcHsIYHFq1rj4N47PcWtFQSkfX3MObcQMiX0yv/xXnB2OBijFEszS93w9E9IUx2PT9WWZLbtvrajq/LfsG+8u81Hkepf48If6NZNCmnTeFrT2uCj70IlTiYv68xq1EHUUAy/d+mXlSDZCYDVZ/2SJXZhSoLYsn1Je0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720712; c=relaxed/simple;
	bh=oOu1pkOWoktHS4cvFVRB8OTOFr1IdzINy46KO6Q5sFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M4Elo8Z0JnLQIAGhbteLiSv+QoJBdOSuCemX3y9X0uB4mu9axMmKnn/sKnUjVjsrKKhibzG5w2130Zx0G2PeKkcgPZDD0L6tedm63MopeT3Nfh32EUhV0ww1rZs6zSuVp0MQuNfEJ7kcpsxxfxmAy2WJiuZuPAFE3myfIoSBOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=47.90.187.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-I5_1709720375;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-I5_1709720375)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:40 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 0/9] um: Minor fixes and cleanups
Date: Wed, 06 Mar 2024 18:19:16 +0800
Message-Id: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A series of minor fixes and cleanups for UML.

Most changes in this series are very straightforward. Please consider
picking this series for v6.9.

There are still some remaining -Wmissing-prototypes warnings. I plan to
send a followup RFC series first to fix those warnings.

Feedbacks on this series would be appreciated. Thanks!

Changes since v2:
https://lore.kernel.org/lkml/20240205114708.25235-1-tiwei.btw@antgroup.com/
- Add "um: Move declarations to proper headers";
- Add "um: Fix -Wmissing-prototypes warnings for text_poke*";
- Add "um: Fix -Wmissing-prototypes warnings for __warp_* and foo";
- Make do_set_thread_area() static;
- Add the missing header for calibrate_delay_is_known;

Tiwei Bie (9):
  um: Make local functions and variables static
  um: Fix the declaration of vfree
  um: Remove unused functions
  um: Fix the return type of __switch_to
  um: Add missing headers
  um: Stop tracking host PID in cpu_tasks
  um: Move declarations to proper headers
  um: Fix -Wmissing-prototypes warnings for text_poke*
  um: Fix -Wmissing-prototypes warnings for __warp_* and foo

 arch/um/drivers/pcap_kern.c                |  4 +-
 arch/um/drivers/ubd_user.c                 |  2 +-
 arch/um/include/asm/ptrace-generic.h       |  3 ++
 arch/um/include/shared/as-layout.h         |  1 -
 arch/um/include/shared/kern_util.h         |  1 +
 arch/um/include/shared/um_malloc.h         |  2 +-
 arch/um/kernel/kmsg_dump.c                 |  2 +-
 arch/um/kernel/mem.c                       |  2 +
 arch/um/kernel/physmem.c                   |  3 +-
 arch/um/kernel/process.c                   | 48 +++++-----------------
 arch/um/kernel/ptrace.c                    |  3 --
 arch/um/kernel/reboot.c                    |  1 +
 arch/um/kernel/skas/mmu.c                  |  1 +
 arch/um/kernel/skas/process.c              |  5 +--
 arch/um/kernel/time.c                      |  7 ++--
 arch/um/kernel/tlb.c                       |  7 +---
 arch/um/kernel/um_arch.c                   |  1 +
 arch/um/kernel/um_arch.h                   |  2 +
 arch/um/os-Linux/drivers/ethertap_kern.c   |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c     |  2 +-
 arch/um/os-Linux/main.c                    |  5 +++
 arch/um/os-Linux/signal.c                  |  4 +-
 arch/um/os-Linux/start_up.c                |  1 +
 arch/x86/um/asm/ptrace.h                   |  6 +++
 arch/x86/um/bugs_32.c                      |  1 +
 arch/x86/um/bugs_64.c                      |  1 +
 arch/x86/um/elfcore.c                      |  1 +
 arch/x86/um/fault.c                        |  1 +
 arch/x86/um/os-Linux/mcontext.c            |  1 +
 arch/x86/um/os-Linux/registers.c           |  2 +-
 arch/x86/um/os-Linux/tls.c                 |  1 +
 arch/x86/um/ptrace_32.c                    |  2 -
 arch/x86/um/shared/sysdep/kernel-offsets.h |  3 ++
 arch/x86/um/tls_32.c                       |  2 +-
 arch/x86/um/user-offsets.c                 |  3 ++
 35 files changed, 63 insertions(+), 70 deletions(-)

-- 
2.34.1


