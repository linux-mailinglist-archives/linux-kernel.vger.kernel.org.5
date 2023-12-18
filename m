Return-Path: <linux-kernel+bounces-3798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963C8171C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD47B23379
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35625A85A;
	Mon, 18 Dec 2023 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPU6vkoG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785F5A846
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40c2c144e60so25228105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702908009; x=1703512809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5rhLwUQ1ywrBkBuwEQIDGD2rpJ8EK3ecZScs+lwiHfY=;
        b=jPU6vkoGAADAxyYkA4LZSSorgWHYuJVLsk3Lk5lWKH1W+p1cpHvihFYtLb4p0In0a1
         olCJ/G/YMY4tBeJC67T8tVqTQqV9q5d8dPjtTVAqGVG//alBGK2unY5xF5NbLFiQw12A
         adxUHtko0H2mvUG+NEpgbMM/t/78+CHsMIjWUYfM0iopTrkfjOIQJL3ip2p0GSqqIq+4
         yrjRE72lsz+D8mAKOGF9QJ4k+9wp4vMHNonqsXJOs692F+axdPgrO6cTa3FzE8g17FNF
         JUQMm5IvKzlLvgAIUo20hCi2aVIEn17DZy3nIgnutoJ+ZibC/USginz9bkLGrl04YR45
         tD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908009; x=1703512809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rhLwUQ1ywrBkBuwEQIDGD2rpJ8EK3ecZScs+lwiHfY=;
        b=gcpa71mfXoSy+oCz/mP+MCTffSgm856tNIjdX2Ujg9nxCgEvTSIV8jIovgZU740vtt
         l5tQu3eV3bwVSbD/7SI8MDsi8W82QICM1P05UDg/5ZBWfIrSgrbH37qD362+l5ukrfSG
         g5fFcNhlWAr5yHoqmYQyD2yqVXuakVMDGY96TsiZfsp/OUMpose47nj6G7xvhzZ71Flw
         deP2ukyrX/KF56vzQuzTKAfVUjVTr/S+9+aatxwzTJnDYIiN/4u1P9w/+Uz/W3ejYxyo
         Dmwf6mx4dyMWfgDcRNiyPzHFAXfcKbje02SLeq0u65f9iBwz9E/aYrFnUViKxzQBnGJ/
         EGBQ==
X-Gm-Message-State: AOJu0YzgrRzkuwq7XEHv0M0qY/OLdJ+8DkZNJJIvjP8VBVjOjZnAEUd9
	knY8ybLeNJY0M+4Ml3X+6CPz3cZGcLNZsmdtqQI=
X-Google-Smtp-Source: AGHT+IHEoseKyYRphf3NMbsIOuRZOeFVPDEEXSm6Ts7CS70/UVcEBiTuIn3NWzoz1j965+zBJY2oLLctkSjyPvjToeI=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3b95:b0:407:8ee2:998c with
 SMTP id n21-20020a05600c3b9500b004078ee2998cmr167649wms.3.1702908009341; Mon,
 18 Dec 2023 06:00:09 -0800 (PST)
Date: Mon, 18 Dec 2023 13:59:00 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-12-sebastianene@google.com>
Subject: [PATCH v4 10/10] arm64: ptdump: Add guest stage-2 pagetables dumping
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

Register a debugfs file on guest creation to be able to view their
second translation tables with ptdump. This assumes that the host is in
control of the guest stage-2 and has direct access to the pagetables.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/debug.c      |  6 ++++++
 arch/arm64/kvm/kvm_ptdump.h |  3 +++
 arch/arm64/kvm/ptdump.c     | 35 ++++++++++++++++++++++++++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb..7c4c2902d 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -13,6 +13,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
+#include <kvm_ptdump.h>
 
 #include "trace.h"
 
@@ -342,3 +343,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 }
+
+int kvm_arch_create_vm_debugfs(struct kvm *kvm)
+{
+	return kvm_ptdump_register_guest(kvm);
+}
diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
index 98b595ce8..5f5a455d0 100644
--- a/arch/arm64/kvm/kvm_ptdump.h
+++ b/arch/arm64/kvm/kvm_ptdump.h
@@ -6,13 +6,16 @@
 #ifndef __KVM_PTDUMP_H
 #define __KVM_PTDUMP_H
 
+#include <linux/kvm_host.h>
 #include <asm/ptdump.h>
 
 
 #ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
 void kvm_ptdump_register_host(void);
+int kvm_ptdump_register_guest(struct kvm *kvm);
 #else
 static inline void kvm_ptdump_register_host(void) { }
+static inline int kvm_ptdump_register_guest(struct kvm *kvm) { return -1; }
 #endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
 
 #endif /* __KVM_PTDUMP_H */
diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 4296e739f..62a753d6b 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -181,6 +181,8 @@ static int kvm_ptdump_open(struct inode *inode, struct file *file)
 		info = reg->get_ptdump_info(reg);
 		if (!info)
 			return -ENOMEM;
+	} else {
+		info = inode->i_private;
 	}
 
 	if (!reg->show_ptdump_info)
@@ -239,15 +241,14 @@ static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
 	return 0;
 }
 
-static int kvm_ptdump_show(struct seq_file *m, void *)
+static int kvm_ptdump_show_common(struct seq_file *m,
+				  struct kvm_pgtable *pgtable)
 {
 	u64 ipa_size;
 	char ipa_description[32];
 	struct pg_state st;
 	struct addr_marker ipa_addr_markers[3] = {0};
 	struct pg_level pg_level_descr[KVM_PGTABLE_MAX_LEVELS] = {0};
-	struct kvm_pgtable_snapshot *snapshot = m->private;
-	struct kvm_pgtable *pgtable = &snapshot->pgtable;
 	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
 		.cb	= kvm_ptdump_visitor,
 		.arg	= &st,
@@ -282,6 +283,26 @@ static int kvm_ptdump_show(struct seq_file *m, void *)
 	return kvm_pgtable_walk(pgtable, 0, ipa_size, &walker);
 }
 
+static int kvm_host_ptdump_show(struct seq_file *m, void *)
+{
+	struct kvm_pgtable_snapshot *snapshot = m->private;
+
+	return kvm_ptdump_show_common(m, &snapshot->pgtable);
+}
+
+static int kvm_ptdump_show(struct seq_file *m, void *)
+{
+	struct kvm *guest_kvm = m->private;
+	struct kvm_s2_mmu *mmu = &guest_kvm->arch.mmu;
+	int ret;
+
+	write_lock(&guest_kvm->mmu_lock);
+	ret = kvm_ptdump_show_common(m, mmu->pgt);
+	write_unlock(&guest_kvm->mmu_lock);
+
+	return ret;
+}
+
 static void kvm_ptdump_debugfs_register(struct kvm_ptdump_register *reg,
 					const char *name, struct dentry *parent)
 {
@@ -393,11 +414,19 @@ void kvm_ptdump_register_host(void)
 
 	host_reg.get_ptdump_info = kvm_host_get_ptdump_info;
 	host_reg.put_ptdump_info = kvm_host_put_ptdump_info;
+	host_reg.show_ptdump_info = kvm_host_ptdump_show;
 
 	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
 				    kvm_debugfs_dir);
 }
 
+int kvm_ptdump_register_guest(struct kvm *kvm)
+{
+	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
+			    kvm, &kvm_ptdump_fops);
+	return 0;
+}
+
 static int __init kvm_host_ptdump_init(void)
 {
 	host_reg.priv = (void *)host_s2_pgtable_pages();
-- 
2.43.0.472.g3155946c3a-goog


