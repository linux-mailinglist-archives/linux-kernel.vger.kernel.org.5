Return-Path: <linux-kernel+bounces-3788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D48171AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D60E1C21832
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011843787E;
	Mon, 18 Dec 2023 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sgpe9Tkw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44937862
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5cf4696e202so38357887b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702907991; x=1703512791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY15YxDdKSZ0D8Iy0CW6yGr0u1mIBXiISHgw6mfVrxM=;
        b=Sgpe9Tkw1MxJx/Hj1mD6aOLDz9LRjH7ZfzWQJISlJitQgeQhjqtlvBhFSxK/XA/lZY
         iGqehjauOHgNbPdlXrfdtGmLTuECaSmcJSfoJlI6bwn5MxSYGBB5TtpfxiIeWSE5/EpF
         UTOhBkQUeNsZePUOdIPY0F9pELqsmoTyRhkKrgcw5YEpaX3TlmubJVZThV4yokhxRF4s
         24LutZASDVRqJcXX2c5lOx+6MlMc++Z54FnvBnw9zZo94h9fKg8a0C3zet2CUrUe/Z4r
         KOLCPryjsZKXkERoIjc8NNxahVIcLP68sF338B7hnn5sWLrOA56bMv1s7hRFfOgnOhyc
         45ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907991; x=1703512791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY15YxDdKSZ0D8Iy0CW6yGr0u1mIBXiISHgw6mfVrxM=;
        b=haBEdiu3wYz7J1o4lcmu88aaO6t/wVuMIHt1EoyJNKsWC/nUQpkz1G5oNxAPd8Mjq+
         OcJ83HNCSDU2XwuCtkN8oDcjk5RrjEAig2G5MqjtTvVuj1SU5fIjjqaqLK/+crzsEoAO
         NYa9QyUpQ1geINBZs/INlIvsysJxErLvSwyHa1g6zYp5CLmRXATCR2BEu8zVmZcyAnlG
         F8VTF1mxSnynKnkoJa7hw+zNsvZxPkf5QzhhYi4qwXKRcznguzJw3tmHZdmMVHp34j3S
         OS7HpGijhK+ivUCtRJ8WP3wT7Y0URQu9cPCYOCXgacO81vlnNQ9iG29gTch7KTgVkur2
         i9Gw==
X-Gm-Message-State: AOJu0Yz1vxkycVHP7IoGHBFmDYzh9i6eGwom5XzvqslST7MA1ZaxNxBm
	d3NG1XP9klAF4q5KiUJmNDQoLU8LLzsng6AEyy8=
X-Google-Smtp-Source: AGHT+IHDTm4uPycg4NnOmmmHO8eB8Hxe6SvZg93QYIJIsVaMcke5f0Zbhd+84fF7mn/7zDbMIdfM8WX0GvJvBINN+B4=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:690c:385:b0:5d3:a348:b0c0 with
 SMTP id bh5-20020a05690c038500b005d3a348b0c0mr2399920ywb.5.1702907991281;
 Mon, 18 Dec 2023 05:59:51 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:52 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-4-sebastianene@google.com>
Subject: [PATCH v4 02/10] KVM: arm64: Add ptdump registration with debugfs for
 the stage-2 pagetables
From: Sebastian Ene <sebastianene@google.com>
To: will@kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com, mark.rutland@arm.com, 
	akpm@linux-foundation.org, maz@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	qperret@google.com, smostafa@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

While arch/*/mem/ptdump handles the kernel pagetable dumping code,
introduce KVM/ptdump which deals with the stage-2 pagetables. The
separation is necessary because most of the definitions from the
stage-2 pagetable reside in the KVM path and we will be invoking
functionality **specific** to KVM.

This registers a wrapper on top of debugfs_create_file which allows us
to hook callbacks on the debugfs open/show/close. The callbacks are used
to prepare the display portion of the pagetable dumping code.
Guard this functionality under the newly introduced PTDUMP_STAGE2_DEBUGFS.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/Kconfig      | 13 +++++
 arch/arm64/kvm/Makefile     |  1 +
 arch/arm64/kvm/arm.c        |  2 +
 arch/arm64/kvm/kvm_ptdump.h | 18 +++++++
 arch/arm64/kvm/ptdump.c     | 96 +++++++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be..0014e55e2 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -71,4 +71,17 @@ config PROTECTED_NVHE_STACKTRACE
 
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
index c0c050e53..190eac175 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e5f75f1f1..ee8d7cb67 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -40,6 +40,7 @@
 #include <asm/kvm_pkvm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/sections.h>
+#include <kvm_ptdump.h>
 
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_pmu.h>
@@ -2592,6 +2593,7 @@ static __init int kvm_arm_init(void)
 	if (err)
 		goto out_subs;
 
+	kvm_ptdump_register_host();
 	kvm_arm_initialised = true;
 
 	return 0;
diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
new file mode 100644
index 000000000..98b595ce8
--- /dev/null
+++ b/arch/arm64/kvm/kvm_ptdump.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+//
+// Copyright (C) Google, 2023
+// Author: Sebastian Ene <sebastianene@google.com>
+
+#ifndef __KVM_PTDUMP_H
+#define __KVM_PTDUMP_H
+
+#include <asm/ptdump.h>
+
+
+#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
+void kvm_ptdump_register_host(void);
+#else
+static inline void kvm_ptdump_register_host(void) { }
+#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
+
+#endif /* __KVM_PTDUMP_H */
diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
new file mode 100644
index 000000000..5816fc632
--- /dev/null
+++ b/arch/arm64/kvm/ptdump.c
@@ -0,0 +1,96 @@
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
+struct kvm_ptdump_register {
+	void *(*get_ptdump_info)(struct kvm_ptdump_register *reg);
+	void (*put_ptdump_info)(void *priv);
+	int (*show_ptdump_info)(struct seq_file *m, void *v);
+	void *priv;
+};
+
+static int kvm_ptdump_open(struct inode *inode, struct file *file);
+static int kvm_ptdump_release(struct inode *inode, struct file *file);
+static int kvm_ptdump_show(struct seq_file *m, void *);
+
+static const struct file_operations kvm_ptdump_fops = {
+	.open		= kvm_ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= kvm_ptdump_release,
+};
+
+static int kvm_ptdump_open(struct inode *inode, struct file *file)
+{
+	struct kvm_ptdump_register *reg = inode->i_private;
+	void *info = NULL;
+	int ret;
+
+	if (reg->get_ptdump_info) {
+		info = reg->get_ptdump_info(reg);
+		if (!info)
+			return -ENOMEM;
+	}
+
+	if (!reg->show_ptdump_info)
+		reg->show_ptdump_info = kvm_ptdump_show;
+
+	ret = single_open(file, reg->show_ptdump_info, info);
+	if (ret && reg->put_ptdump_info)
+		reg->put_ptdump_info(info);
+
+	return ret;
+}
+
+static int kvm_ptdump_release(struct inode *inode, struct file *file)
+{
+	struct kvm_ptdump_register *reg = inode->i_private;
+	struct seq_file *seq_file = file->private_data;
+
+	if (reg->put_ptdump_info)
+		reg->put_ptdump_info(seq_file->private);
+
+	return 0;
+}
+
+static int kvm_ptdump_show(struct seq_file *m, void *)
+{
+	return -EINVAL;
+}
+
+static void kvm_ptdump_debugfs_register(struct kvm_ptdump_register *reg,
+					const char *name, struct dentry *parent)
+{
+	debugfs_create_file(name, 0400, parent, reg, &kvm_ptdump_fops);
+}
+
+static struct kvm_ptdump_register host_reg;
+
+void kvm_ptdump_register_host(void)
+{
+	if (!is_protected_kvm_enabled())
+		return;
+
+	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
+				    kvm_debugfs_dir);
+}
+
+static int __init kvm_host_ptdump_init(void)
+{
+	host_reg.priv = (void *)host_s2_pgtable_pages();
+	return 0;
+}
+
+device_initcall(kvm_host_ptdump_init);
-- 
2.43.0.472.g3155946c3a-goog


