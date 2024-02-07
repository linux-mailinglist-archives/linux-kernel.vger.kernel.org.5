Return-Path: <linux-kernel+bounces-56653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522184CD3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BE7B24692
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A537FBAB;
	Wed,  7 Feb 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mT7hu7CU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CE7F7CB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317366; cv=none; b=NmKdxB23+vheXpX/znlkzYogfLYxYeHgoZCmlIyzMMGvP7sYYN/1Vo2nKNUaa/IWQc25MjKZKjcqdY+4oKPFf/dWiGkykoP4M81Qv53bNHIYU+CYMDry1lJLLRXKLWc6vz+pyG1NL4IJLbuLMCLWOe7Jim2ztOu2tvG6C0mfXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317366; c=relaxed/simple;
	bh=rNGGZUY2dBsJq36eaQaTKYVIz8wf7Lh+KRhuF6gF5W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhogigeS7Z02GU5TAarZXSBQ4WjKuW93vl1qFnXgESzuHNWDzFjDHuZ/dxSPlddUdwN0ysYamkogJSrF1MxqhFSOfZvfCFH70hJus8PUoNsBK7ERRW9nn63P3wb4n/YS7nP1QtEFa44nlD8v8HzlnNHkJ75QQpwnpePUErXjpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mT7hu7CU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60484a61250so13945727b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707317364; x=1707922164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1F3sgOZBAQMU7R2Rlac0l+wJat72mlIsX+wYVgtE5c=;
        b=mT7hu7CUGFOIS+XLPewRqWmTVYeEXNsJCow9FtMkZvi4rOgj5qMvlSo2CPDrEJHc3A
         T1J7oTJWracl5M8TZxDssHBdqeahrPGQfMAqwDctQRsnOEup2inS0VUxWApvwGpEYpsq
         qAn+aBEmza8uX/stXyWMuCB+t4zjqDhKqojNLNif57sBKFoY5ek6YMMFDdvAT/yi4X2x
         vWZCJq17Auf9wH4d+YmtqRcrpBCCdeW1zg5+YKuZIMNNtfr2svs7KaVsIXDboXZJl8rZ
         aZmMF4L8iDs/SmzUTgheCZKErzuvzSS6AUhBGCvNnQxRK9khFTdkw4IqdIJ2A/QsgdEO
         Pn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317364; x=1707922164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1F3sgOZBAQMU7R2Rlac0l+wJat72mlIsX+wYVgtE5c=;
        b=cqCod8HM7TMCNxXvRjPNGZePm9nAgq8DildUYknDIoJ84eOH26Jm3TrbMZV8pa0iCR
         ymUlfFM9bqDcIsIXnQ+jwoaUH44OXNOLyYjN2fpLdlL1MPUgMofPiblriHtSQDodfaix
         QHw8xYqJSc8P2cuPqUGwUDVggHTJ7FvHG6jwxUNmVE/teJmluGSYnwlB6yJ2nWH1e5+W
         aebgjbIM6K806r+AW5EgpMl5s1aSOMzDFnY7o5E4VeHCWstg9rQBkJeU4A7NE6KkABra
         BR2FNwH6jDjIaS6DfW1V+uBA0geOfT0qVe5ZvCPlgq5X/DdPj7PSpjtWPHpoT5dzP09s
         k1XA==
X-Gm-Message-State: AOJu0YzOuyQuVqGUo2od9oJl2MgTA2LPgUdD0+1oFym0H5XWb1hfjE6m
	DGjFAIDmodq8+EqPIPVd0deq47zvrH/2Ama/+bB5FUjoehzbVNxTcgwt0r1s2P8UwpkrvxbDoPJ
	+uIyMlRt0g52rlmOc53aHONpkEA==
X-Google-Smtp-Source: AGHT+IEC9mYi5t2mpH+RrbaTrZi6L4zjhcBIBP8lvg21KvfSYfviuojbe9O+9+vO64zGP+pdG6Z5ql7eX/H03dtdRo4=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2187:b0:dc2:1cd6:346e with
 SMTP id dl7-20020a056902218700b00dc21cd6346emr1222350ybb.8.1707317364293;
 Wed, 07 Feb 2024 06:49:24 -0800 (PST)
Date: Wed,  7 Feb 2024 14:48:32 +0000
In-Reply-To: <20240207144832.1017815-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207144832.1017815-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207144832.1017815-5-sebastianene@google.com>
Subject: [PATCH v5 3/4] KVM: arm64: Register ptdump with debugfs on guest creation
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com, 
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev, 
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com, 
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org, 
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

While arch/*/mem/ptdump handles the kernel pagetable dumping code,
introduce KVM/ptdump which shows the guest stage-2 pagetables. The
separation is necessary because most of the definitions from the
stage-2 pagetable reside in the KVM path and we will be invoking
functionality **specific** to KVM.

When a guest is created, register a new file entry under the guest
debugfs dir which allows userspace to show the contents of the guest
stage-2 pagetables when accessed.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/Kconfig      | 13 ++++++
 arch/arm64/kvm/Makefile     |  1 +
 arch/arm64/kvm/debug.c      |  7 ++++
 arch/arm64/kvm/kvm_ptdump.h | 20 ++++++++++
 arch/arm64/kvm/ptdump.c     | 79 +++++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 6c3c8ca73e7f..28097dd72174 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -68,4 +68,17 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config PTDUMP_STAGE2_DEBUGFS
+       bool "Present the stage-2 pagetables to debugfs"
+       depends on PTDUMP_DEBUGFS && KVM
+       default n
+       help
+         Say Y here if you want to show the stage-2 kernel pagetables
+         layout in a debugfs file. This information is only useful for kernel developers
+         who are working in architecture specific areas of the kernel.
+         It is probably not a good idea to enable this feature in a production
+         kernel.
+
+         If in doubt, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index c0c050e53157..190eac17538c 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..aef52836cd90 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -14,6 +14,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 
+#include <kvm_ptdump.h>
+
 #include "trace.h"
 
 /* These are the bits of MDSCR_EL1 we may manipulate */
@@ -342,3 +344,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 }
+
+int kvm_arch_create_vm_debugfs(struct kvm *kvm)
+{
+	return kvm_ptdump_guest_register(kvm);
+}
diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
new file mode 100644
index 000000000000..a7c00a28481b
--- /dev/null
+++ b/arch/arm64/kvm/kvm_ptdump.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) Google, 2023
+ * Author: Sebastian Ene <sebastianene@google.com>
+ */
+
+#ifndef __KVM_PTDUMP_H
+#define __KVM_PTDUMP_H
+
+#include <linux/kvm_host.h>
+#include <asm/ptdump.h>
+
+
+#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
+int kvm_ptdump_guest_register(struct kvm *kvm);
+#else
+static inline int kvm_ptdump_guest_register(struct kvm *kvm) { return 0; }
+#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
+
+#endif /* __KVM_PTDUMP_H */
diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
new file mode 100644
index 000000000000..a4e984da8aa7
--- /dev/null
+++ b/arch/arm64/kvm/ptdump.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Debug helper used to dump the stage-2 pagetables of the system and their
+// associated permissions.
+//
+// Copyright (C) Google, 2023
+// Author: Sebastian Ene <sebastianene@google.com>
+
+#include <linux/debugfs.h>
+#include <linux/kvm_host.h>
+#include <linux/seq_file.h>
+
+#include <asm/kvm_pkvm.h>
+#include <kvm_ptdump.h>
+
+
+static int kvm_ptdump_guest_open(struct inode *inode, struct file *file);
+static int kvm_ptdump_guest_show(struct seq_file *m, void *);
+
+static const struct file_operations kvm_ptdump_guest_fops = {
+	.open		= kvm_ptdump_guest_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int kvm_ptdump_guest_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kvm_ptdump_guest_show, inode->i_private);
+}
+
+static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
+			      enum kvm_pgtable_walk_flags visit)
+{
+	struct pg_state *st = ctx->arg;
+	struct ptdump_state *pt_st = &st->ptdump;
+
+	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
+	return 0;
+}
+
+static int kvm_ptdump_show_common(struct seq_file *m,
+				  struct kvm_pgtable *pgtable,
+				  struct pg_state *parser_state)
+{
+	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
+		.cb     = kvm_ptdump_visitor,
+		.arg	= parser_state,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
+}
+
+static int kvm_ptdump_guest_show(struct seq_file *m, void *)
+{
+	struct kvm *guest_kvm = m->private;
+	struct kvm_s2_mmu *mmu = &guest_kvm->arch.mmu;
+	struct pg_state parser_state = {0};
+	int ret;
+
+	write_lock(&guest_kvm->mmu_lock);
+	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
+	write_unlock(&guest_kvm->mmu_lock);
+
+	return ret;
+}
+
+int kvm_ptdump_guest_register(struct kvm *kvm)
+{
+	struct dentry *parent;
+
+	parent = debugfs_create_file("stage2_page_tables", 0400,
+				     kvm->debugfs_dentry, kvm,
+				     &kvm_ptdump_guest_fops);
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+	return 0;
+}
-- 
2.43.0.594.gd9cf4e227d-goog


