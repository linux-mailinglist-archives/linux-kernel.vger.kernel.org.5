Return-Path: <linux-kernel+bounces-51522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3D848C26
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA221F23DFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5E12E50;
	Sun,  4 Feb 2024 08:26:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068A12B69;
	Sun,  4 Feb 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035200; cv=none; b=skJEYcVmLABtAd2JoZ47L+yNweRmJ9/hMzWjlIXJ1O7RmA2gIhVPeYnJidDcHWbyMV8Kyx5dBup/qRyqZaBnaWI+hRTGIZ2m7Kh1p/nzOfx6laAE1LTHgqSBBXN27zBmOT1lgrBipPBeBuilhCvNUCnukIx0S+JHDkfRCpOpkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035200; c=relaxed/simple;
	bh=p/f7riMkZxcC6ClGf9vpDtgKU0i1cmddSajVqTGwbYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6MclFVXZl6Y48bPFk/rQIs8x5X2GypSjbIGaW4POs4733tl6tK3JxG+Z1dFMarNG/TEl1el/GrhXYmk6xjjDtv0WGL7lNTHRJbaUrpXURK9Qi3czlVHs33QIIvvUXiJzkI/3umwE+dPTPoLVQFPuHrPKvg+xPvlRCWbSavJ3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TSMyh23QKz1xnCm;
	Sun,  4 Feb 2024 16:25:32 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 71B6814013B;
	Sun,  4 Feb 2024 16:26:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 16:26:35 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Tong Tiangen <tongtiangen@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH -next v5 3/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC
Date: Sun, 4 Feb 2024 16:26:27 +0800
Message-ID: <20240204082627.3892816-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204082627.3892816-1-tongtiangen@huawei.com>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)

In the x86 mce processing, error_context() use MCE_IN_KERNEL_COPYIN for
user-to-kernel copy(EX_TYPE_UACCESS) and kernel-to-kernel copy
(EX_TYPE_DEFAULT_MCE_SAFE).

"COPYIN" only stands for user-to-kernel copy and can't stands for
kernel-to-kernel copy, this can cause some misunderstandings. So rename
MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/include/asm/mce.h         | 8 ++++----
 arch/x86/kernel/cpu/mce/core.c     | 2 +-
 arch/x86/kernel/cpu/mce/severity.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de3118305838..cb628ab2f32f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -151,11 +151,11 @@
 
 /*
  * Indicates an MCE that happened in kernel space while copying data
- * from user. In this case fixup_exception() gets the kernel to the
- * error exit for the copy function. Machine check handler can then
- * treat it like a fault taken in user mode.
+ * from user or kernel. In this case fixup_exception() gets the kernel
+ * to the error exit for the copy function. Machine check handler can
+ * then treat it like a fault taken in user or kernel mode.
  */
-#define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
+#define MCE_IN_KERNEL_COPY_MC	BIT_ULL(7)
 
 /*
  * This structure contains all data related to the MCE log.  Also
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 04acdc3534c8..644748a5d98e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1608,7 +1608,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
 
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+		if (m.kflags & MCE_IN_KERNEL_COPY_MC)
 			queue_task_work(&m, msg, kill_me_never);
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index b2cce1b6c96d..b4b1d028cbb3 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -294,7 +294,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 			return IN_KERNEL;
 		fallthrough;
 	case EX_TYPE_DEFAULT_MCE_SAFE:
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
+		m->kflags |= MCE_IN_KERNEL_COPY_MC;
 		fallthrough;
 	case EX_TYPE_FAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
-- 
2.25.1


