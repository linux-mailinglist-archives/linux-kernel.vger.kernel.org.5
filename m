Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E307B02D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjI0L0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjI0L0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B31CDF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d4bbfc7so132690907b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813953; x=1696418753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQzoJulYm3NuHJDD1oClvJ2axH95rZ3WpVD9Pkot9xI=;
        b=e+wc4G9jv5/mzBgU/i3OKBcFlMeumBaluQUbWN9e76K3ffHxVWZpo4Vycp4VsxsrGv
         Uiz0k1VfJmCn96tvXEvRbQ/eyLk6l4fscmkWGcTF2TstZfIg1vq/avIHnzOCRSmWucob
         M9MUmEbKreJf5pkm7Z5VPsw2CWuiveAd46TzLKbba3/IieTsELwbzqAbqkNbJ13WsoB6
         fwTC2jDvnfqHFR8GzkmtNPRLzfgL4CjARkb0MjBYKJySzcWqB8rSkpg9kUjKl/lrlFS9
         0eaD19L0Ruzr3hxPkASbmIMBVAG4iZT0r4DMTgiCz2lZPIlm5pAAlXYZ4lEgUtaknFcR
         8p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813953; x=1696418753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQzoJulYm3NuHJDD1oClvJ2axH95rZ3WpVD9Pkot9xI=;
        b=geQYsFoH+NN7ZXuZLxKEnpgrp/1e4MLCIiG7ivSWWCbDgRCbWkY4+WLyPzNVeRF2XI
         ITzIeXCHXgtPtS9TQIVTAM/XXRllPQXeM3b49k5WBTkLpvjpaEbQyeMSyKwHWw0bFrIW
         TaUzx6esZKpCGGi6p2fSNPe9JTmqbHnTMm2ukbpm95SC7kY12ApY9wZ1RUQY5hHDUXt0
         6LVPZuWjnWf1+NKtQ5+8rMvEdFL+Vt7Jx1tI+mxZy3NP9r5oHGOSSeaWdSEL6M81pPfH
         c5ilQU0pU44trSOyXaV3hJ9/nbho9v5RleNL++j3qWD3eFMrbBiLxhjjDlemVtH/o9PN
         T50A==
X-Gm-Message-State: AOJu0Yzok7RiL6lqqeSJIDTJgPDuGdq015PZQkwR/uLAVDlBxcfbSCqh
        AMjSRct508iDpkL4tOTta3CZ5nVI18xL6HTPPqRs+bIGKH9JbiC3r4zn+7dms+abolK0nDnP4YM
        Ak25YxFltiFz04uwqMNLzoax6aMA0kEggVAl0ulGyPdK56nh1K1oGXkgq5aevx+oiLt7FFWDmUL
        OJPozvJIVsRQ==
X-Google-Smtp-Source: AGHT+IF6AtJPGcOJ2ewCwA+NHRoIzhsCObjvDaJp7WUbyeKw+9AprU6wdUMKeyMKs/9yDyr+Tg+q+tlR1jG5jcwYxMs=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a81:b709:0:b0:59b:f138:c835 with SMTP
 id v9-20020a81b709000000b0059bf138c835mr26425ywh.5.1695813952895; Wed, 27 Sep
 2023 04:25:52 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:13 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-8-sebastianene@google.com>
Subject: [PATCH 07/11] arm64: ptdump: Snapshot the host stage-2 pagetables
From:   Sebastian Ene <sebastianene@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, will@kernel.org, ryan.roberts@arm.com,
        mark.rutland@arm.com, maz@kernel.org, vdonnefort@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce callbacks invoked when the debugfs entry is accessed from the
userspace and store them in the ptdump state structure. Call these
functions when the ptdump registered entry with debugfs is open/closed.
When we open the entry we allocate memory for the host stage-2 snapshot,
we share it with the hypervisor and then we issue the hvc to copy the
page-tables to the shared buffer. When we close the debugfs entry we
release the associated memory resources and we unshare the memory from
the hypervisor.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |   5 ++
 arch/arm64/mm/ptdump.c          | 143 +++++++++++++++++++++++++++++++-
 arch/arm64/mm/ptdump_debugfs.c  |  34 +++++++-
 3 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 1f6e0aabf16a..35b883524462 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -19,7 +19,12 @@ struct ptdump_info {
 	struct mm_struct		*mm;
 	const struct addr_marker	*markers;
 	unsigned long			base_addr;
+	void (*ptdump_prepare_walk)(struct ptdump_info *info);
 	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
+	void (*ptdump_end_walk)(struct ptdump_info *info);
+	struct mutex			file_lock;
+	size_t				mc_len;
+	void				*priv;
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 25c0640e82aa..7d57fa9be724 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/kvm_pkvm.h>
 #include <asm/kvm_pgtable.h>
 
 
@@ -482,6 +483,139 @@ static struct mm_struct ipa_init_mm = {
 	.mm_mt		= MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS,
 					 ipa_init_mm.mmap_lock),
 };
+
+static phys_addr_t ptdump_host_pa(void *addr)
+{
+	return __pa(addr);
+}
+
+static void *ptdump_host_va(phys_addr_t phys)
+{
+	return __va(phys);
+}
+
+static size_t stage2_get_pgd_len(void)
+{
+	u64 mmfr0, mmfr1, vtcr;
+	u32 phys_shift = get_kvm_ipa_limit();
+
+	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	vtcr = kvm_get_vtcr(mmfr0, mmfr1, phys_shift);
+
+	return kvm_pgtable_stage2_pgd_size(vtcr);
+}
+
+static void stage2_ptdump_prepare_walk(struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot;
+	int ret, pgd_index, mc_index, pgd_pages_sz;
+	void *page_hva;
+
+	snapshot = alloc_pages_exact(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
+	if (!snapshot)
+		return;
+
+	memset(snapshot, 0, PAGE_SIZE);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp, virt_to_pfn(snapshot));
+	if (ret)
+		goto free_snapshot;
+
+	snapshot->pgd_len = stage2_get_pgd_len();
+	pgd_pages_sz = snapshot->pgd_len / PAGE_SIZE;
+	snapshot->pgd_hva = alloc_pages_exact(snapshot->pgd_len,
+					      GFP_KERNEL_ACCOUNT);
+	if (!snapshot->pgd_hva)
+		goto unshare_snapshot;
+
+	for (pgd_index = 0; pgd_index < pgd_pages_sz; pgd_index++) {
+		page_hva = snapshot->pgd_hva + pgd_index * PAGE_SIZE;
+		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
+					virt_to_pfn(page_hva));
+		if (ret)
+			goto unshare_pgd_pages;
+	}
+
+	for (mc_index = 0; mc_index < info->mc_len; mc_index++) {
+		page_hva = alloc_pages_exact(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
+		if (!page_hva)
+			goto free_memcache_pages;
+
+		push_hyp_memcache(&snapshot->mc, page_hva, ptdump_host_pa);
+		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
+					virt_to_pfn(page_hva));
+		if (ret) {
+			pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+			free_pages_exact(page_hva, PAGE_SIZE);
+			goto free_memcache_pages;
+		}
+	}
+
+	ret = kvm_call_hyp_nvhe(__pkvm_copy_host_stage2, snapshot);
+	if (ret)
+		goto free_memcache_pages;
+
+	info->priv = snapshot;
+	return;
+
+free_memcache_pages:
+	page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	while (page_hva) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+		free_pages_exact(page_hva, PAGE_SIZE);
+		page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	}
+unshare_pgd_pages:
+	pgd_index = pgd_index - 1;
+	for (; pgd_index >= 0; pgd_index--) {
+		page_hva = snapshot->pgd_hva + pgd_index * PAGE_SIZE;
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+	}
+	free_pages_exact(snapshot->pgd_hva, snapshot->pgd_len);
+unshare_snapshot:
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+				  virt_to_pfn(snapshot)));
+free_snapshot:
+	free_pages_exact(snapshot, PAGE_SIZE);
+	info->priv = NULL;
+}
+
+static void stage2_ptdump_end_walk(struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	void *page_hva;
+	int pgd_index, ret, pgd_pages_sz;
+
+	if (!snapshot)
+		return;
+
+	page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	while (page_hva) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+		free_pages_exact(page_hva, PAGE_SIZE);
+		page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	}
+
+	pgd_pages_sz = snapshot->pgd_len / PAGE_SIZE;
+	for (pgd_index = 0; pgd_index < pgd_pages_sz; pgd_index++) {
+		page_hva = snapshot->pgd_hva + pgd_index * PAGE_SIZE;
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+	}
+
+	free_pages_exact(snapshot->pgd_hva, snapshot->pgd_len);
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+				  virt_to_pfn(snapshot)));
+	free_pages_exact(snapshot, PAGE_SIZE);
+	info->priv = NULL;
+}
 #endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
 
 static int __init ptdump_init(void)
@@ -495,11 +629,16 @@ static int __init ptdump_init(void)
 
 #ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
 	stage2_kernel_ptdump_info = (struct ptdump_info) {
-		.markers	= ipa_address_markers,
-		.mm		= &ipa_init_mm,
+		.markers		= ipa_address_markers,
+		.mm			= &ipa_init_mm,
+		.mc_len			= host_s2_pgtable_pages(),
+		.ptdump_prepare_walk	= stage2_ptdump_prepare_walk,
+		.ptdump_end_walk	= stage2_ptdump_end_walk,
 	};
 
 	init_rwsem(&ipa_init_mm.mmap_lock);
+	mutex_init(&stage2_kernel_ptdump_info.file_lock);
+
 	ptdump_debugfs_register(&stage2_kernel_ptdump_info,
 				"host_stage2_kernel_page_tables");
 #endif
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 7564519db1e6..14619452dd8d 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -15,7 +15,39 @@ static int ptdump_show(struct seq_file *m, void *v)
 	put_online_mems();
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(ptdump);
+
+static int ptdump_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct ptdump_info *info = inode->i_private;
+
+	ret = single_open(file, ptdump_show, inode->i_private);
+	if (!ret && info->ptdump_prepare_walk) {
+		mutex_lock(&info->file_lock);
+		info->ptdump_prepare_walk(info);
+	}
+	return ret;
+}
+
+static int ptdump_release(struct inode *inode, struct file *file)
+{
+	struct ptdump_info *info = inode->i_private;
+
+	if (info->ptdump_end_walk) {
+		info->ptdump_end_walk(info);
+		mutex_unlock(&info->file_lock);
+	}
+
+	return single_release(inode, file);
+}
+
+static const struct file_operations ptdump_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= ptdump_release,
+};
 
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.42.0.515.g380fc7ccd1-goog

