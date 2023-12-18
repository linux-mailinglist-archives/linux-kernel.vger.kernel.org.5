Return-Path: <linux-kernel+bounces-3787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482298171AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E40B1C21E50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3F1D123;
	Mon, 18 Dec 2023 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kscIP+Zg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67041D137
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40d17446f11so11114535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702907989; x=1703512789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k7cehEzikJK7Gdbm4Te2RqGLAqH3crGDKksVzZAStI=;
        b=kscIP+Zgs/Fde4gk3Ywe8F56MHfj+o2iWqmmG6WTN0SanmoIMaZMhc7smQMnuKZsr0
         yTr7FADeCrp33LW7GTzmlueju4+XhKM9t1hkySIjvL+Qeh34USknrP3U2DT8YMJIXui6
         eWQpPYcapy/FPsOfewRl2DJidvZPZFb2T68U8225JuJ8684vQoxNDlKB/5WsuIo25+T1
         4GipAKmBv3j0IMh3gI+cYaznTPODUeQLCi3o2/HW2W6on9KM6Dh3vm7czGsGQzhDx4n8
         cqwYvfP7b+oas6PvgeFug+kTifEnG1rVtJsPZg4A2nM436G4i3ZK9/SyNoLU2Mp6VRg2
         OD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907989; x=1703512789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6k7cehEzikJK7Gdbm4Te2RqGLAqH3crGDKksVzZAStI=;
        b=B6ezxvy/SfHGdzUvdoWHlY0MBZhX1VKwDWlH7Cm0yItH5SX4ikGHNaXDKI8r+0d/fm
         o4BDt68A9Tcj1p3grhPtSjCWGSL6tVJ0ZO7Y9fUXTh7709LXu1aQl8tfwnZdNYjpxuNu
         /MSxqOW9Ayx4wLvhQVS9vzHsmXWNHnln2XRvcqvwyrcw2wJF7WTDGV16MgMieS/foVaf
         TALc1OwyOEN5rKdIRwb0LhZqisipBDnxgaioty3TblSYBUmxBpYSIT4V0ZiL158L5T+T
         2K5TOyUm3qK2N2E+cVaIka+HCNq+KtbqbVNy53p3sBkeWcLGCBSom3A+xXPZg3RlGYsy
         heQg==
X-Gm-Message-State: AOJu0YxxEj+PUFgf+WPWtlB5+MT2gN0vKHrGnWi69S8U5pRt9YKsCXFl
	g4LJk/eOhZWBIEiSnLgu+4L0dXG0tyWSvqL6ayw=
X-Google-Smtp-Source: AGHT+IEFl7UeJkAWNGeuMCf/woxCmNRLzb6+Y/KXy9tkOKGuWrtl+ZOKH9Agd0lSddYxe/N6Z/QJtu8jdu20gfmQMmA=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:1c07:b0:40b:2c9e:e144 with
 SMTP id j7-20020a05600c1c0700b0040b2c9ee144mr333270wms.1.1702907989006; Mon,
 18 Dec 2023 05:59:49 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:51 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-3-sebastianene@google.com>
Subject: [PATCH v4 01/10] KVM: arm64: Add snapshot interface for the host
 stage-2 pagetable
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

Introduce a new hvc that allows the pKVM hypervisor to snapshot the host
stage-2 pagetables. The caller is expected to allocate & free the memory
for the pagetable snapshot. The below diagram shows the sequence of
events.

[--- HOST ---]
(1) allocate memory for the snapshot
(2) invoke the __pkvm_copy_host_stage2(snapshot) interface
|____
	[--- HYP ---]
	(3) donate the snapshot from HOST -> HYP
	(4) save the host stage-2 pagetables in the snapshot
	(5) donate the snapshot from HYP -> HOST
	[--- return from HYP ---]
[--- HOST ---]
(6) free the memory for the snapshot

When the host kernel invokes this interface, the memory is donated from
the host to the hypervisor. By doing this the memory is unmapped from the
host's translation regime to prevent the host from modifying the buffer
while the hypervisor uses it. The hypervisor walks the host stage-2
pagetable copy while re-creating the original mappings. When the copying
is done, the memory is donated from the hypervisor back to the host.
The pages that have been used from the memcache are donated back to the
host from a temporary array. The hvc is executing synchronously and the
preemption is disabled for the current CPU while running inside the
hypervisor so calling this interface blocks the current CPU until the
snapshoting is done.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_pgtable.h          |  43 ++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  12 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 186 ++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c                  |  43 ++++
 6 files changed, 286 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 24b5e6b23..9df3367d8 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -81,6 +81,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_init_vm,
 	__KVM_HOST_SMCCC_FUNC___pkvm_init_vcpu,
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_stage2_snapshot,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d3e354bb8..f73efd8a8 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -10,6 +10,7 @@
 #include <linux/bits.h>
 #include <linux/kvm_host.h>
 #include <linux/types.h>
+#include <asm/kvm_host.h>
 
 #define KVM_PGTABLE_MAX_LEVELS		4U
 
@@ -351,6 +352,28 @@ struct kvm_pgtable {
 	kvm_pgtable_force_pte_cb_t		force_pte_cb;
 };
 
+/**
+ * struct kvm_pgtable_snapshot - Snapshot page-table wrapper.
+ * @pgtable:		The page-table configuration.
+ * @mc:			Memcache used for pagetable pages allocation.
+ * @pgd_hva:		Host virtual address of a physically contiguous buffer
+ *			used for storing the PGD.
+ * @pgd_pages:		The size of the phyisically contiguous buffer in pages.
+ * @used_pages_hva:	Host virtual address of a physically contiguous buffer
+ *			used for storing the consumed pages from the memcache.
+ * @num_used_pages		The size of the used buffer in pages.
+ * @used_pages_indx		The current index of the used pages array.
+ */
+struct kvm_pgtable_snapshot {
+	struct kvm_pgtable			pgtable;
+	struct kvm_hyp_memcache			mc;
+	void					*pgd_hva;
+	size_t					pgd_pages;
+	phys_addr_t				*used_pages_hva;
+	size_t					num_used_pages;
+	size_t					used_pages_indx;
+};
+
 /**
  * kvm_pgtable_hyp_init() - Initialise a hypervisor stage-1 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
@@ -756,4 +779,24 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
  */
 void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
 				phys_addr_t addr, size_t size);
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+/**
+ * kvm_pgtable_stage2_snapshot() - Given a memcache and a destination
+ *				pagetable where we have the original PGD
+ *				copied, build a snapshot table with page table
+ *				pages from the given memcache.
+ *
+ * @to_pgt:	Destination pagetable
+ * @mc:		The memcache where we allocate the destination pagetables from
+ */
+int kvm_pgtable_stage2_snapshot(struct kvm_pgtable *to_pgt,
+				void *mc);
+#else
+static inline int kvm_pgtable_stage2_snapshot(struct kvm_pgtable *to_pgt,
+					      void *mc)
+{
+	return -EPERM;
+}
+#endif	/* CONFIG_NVHE_EL2_DEBUG */
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 0972faccc..ca8f76915 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -69,6 +69,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
+int __pkvm_host_stage2_snapshot(struct kvm_pgtable_snapshot *snapshot);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2385fd03e..7b215245f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -314,6 +314,17 @@ static void handle___pkvm_teardown_vm(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_teardown_vm(handle);
 }
 
+static void handle___pkvm_host_stage2_snapshot(struct kvm_cpu_context *host_ctxt)
+{
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	DECLARE_REG(struct kvm_pgtable_snapshot *, snapshot_hva, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_host_stage2_snapshot(snapshot_hva);
+#else
+	cpu_reg(host_ctxt, 0) = SMCCC_RET_NOT_SUPPORTED;
+#endif
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -348,6 +359,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_init_vm),
 	HANDLE_FUNC(__pkvm_init_vcpu),
 	HANDLE_FUNC(__pkvm_teardown_vm),
+	HANDLE_FUNC(__pkvm_host_stage2_snapshot),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 8d0a5834e..aaf07f9e1 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -266,6 +266,192 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
 	return 0;
 }
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+static void *snap_zalloc_page(void *mc)
+{
+	struct hyp_page *p;
+	void *addr;
+	struct kvm_pgtable_snapshot *snap;
+	phys_addr_t *used_pg;
+
+	snap = container_of(mc, struct kvm_pgtable_snapshot, mc);
+	used_pg = kern_hyp_va(snap->used_pages_hva);
+
+	/* Check if we have space to track the used page */
+	if (snap->used_pages_indx * sizeof(phys_addr_t) > snap->num_used_pages * PAGE_SIZE)
+		return NULL;
+
+	addr = pop_hyp_memcache(mc, hyp_phys_to_virt);
+	if (!addr)
+		return addr;
+	used_pg[snap->used_pages_indx++] = hyp_virt_to_phys(addr);
+
+	memset(addr, 0, PAGE_SIZE);
+	p = hyp_virt_to_page(addr);
+	memset(p, 0, sizeof(*p));
+
+	return addr;
+}
+
+static void snap_free_pages_exact(void *addr, unsigned long size)
+{
+	u8 order = get_order(size);
+	unsigned int i;
+	struct hyp_page *p;
+
+	for (i = 0; i < (1 << order); i++) {
+		p = hyp_virt_to_page(addr + (i * PAGE_SIZE));
+		hyp_page_ref_dec(p);
+	}
+}
+
+static void *pkvm_setup_snapshot(struct kvm_pgtable_snapshot *snap_hva)
+{
+	unsigned long i;
+	void *pgd, *used_pg;
+	phys_addr_t mc_page, next_mc_page;
+	struct kvm_pgtable_snapshot *snap;
+
+	snap = (void *)kern_hyp_va(snap_hva);
+	if (!PAGE_ALIGNED(snap))
+		return NULL;
+
+	if (__pkvm_host_donate_hyp(hyp_virt_to_pfn(snap), 1))
+		return NULL;
+
+	pgd = kern_hyp_va(snap->pgd_hva);
+	if (!PAGE_ALIGNED(pgd))
+		goto error_with_snapshot;
+
+	if (__pkvm_host_donate_hyp(hyp_virt_to_pfn(pgd), snap->pgd_pages))
+		goto error_with_snapshot;
+
+	mc_page = snap->mc.head;
+	for (i = 0; i < snap->mc.nr_pages; i++) {
+		if (!PAGE_ALIGNED(mc_page))
+			goto error_with_memcache;
+
+		if (__pkvm_host_donate_hyp(hyp_phys_to_pfn(mc_page), 1))
+			goto error_with_memcache;
+
+		mc_page = *((phys_addr_t *)hyp_phys_to_virt(mc_page));
+	}
+
+	used_pg = kern_hyp_va(snap->used_pages_hva);
+	if (!PAGE_ALIGNED(used_pg))
+		goto error_with_memcache;
+
+	if (__pkvm_host_donate_hyp(hyp_virt_to_pfn(used_pg), snap->num_used_pages))
+		goto error_with_memcache;
+
+	return snap;
+error_with_memcache:
+	mc_page = snap->mc.head;
+	for (; i >= 0; i--) {
+		next_mc_page = *((phys_addr_t *)hyp_phys_to_virt(mc_page));
+		WARN_ON(__pkvm_hyp_donate_host(hyp_phys_to_pfn(mc_page), 1));
+		mc_page = next_mc_page;
+	}
+
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(pgd), snap->pgd_pages));
+error_with_snapshot:
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(snap), 1));
+	return NULL;
+}
+
+static void pkvm_teardown_snapshot(struct kvm_pgtable_snapshot *snap)
+{
+	size_t i;
+	phys_addr_t mc_page, next_mc_page;
+	u64 *used_pg = kern_hyp_va(snap->used_pages_hva);
+	void *pgd = kern_hyp_va(snap->pgd_hva);
+
+	for (i = 0; i < snap->used_pages_indx; i++) {
+		mc_page = used_pg[i];
+		WARN_ON(__pkvm_hyp_donate_host(hyp_phys_to_pfn(mc_page), 1));
+	}
+
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(used_pg),
+				       snap->num_used_pages));
+
+	mc_page = snap->mc.head;
+	for (i = 0; i < snap->mc.nr_pages; i++) {
+		next_mc_page = *((phys_addr_t *)hyp_phys_to_virt(mc_page));
+		WARN_ON(__pkvm_hyp_donate_host(hyp_phys_to_pfn(mc_page), 1));
+		mc_page = next_mc_page;
+	}
+
+	snap->pgtable.mm_ops = NULL;
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(pgd), snap->pgd_pages));
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(snap), 1));
+}
+
+static int pkvm_host_stage2_snapshot(struct kvm_pgtable_snapshot *snap)
+{
+	int ret;
+	void *pgd;
+	size_t required_pgd_len;
+	struct kvm_pgtable_mm_ops mm_ops = {0};
+	struct kvm_s2_mmu *mmu;
+	struct kvm_pgtable *to_pgt, *from_pgt;
+
+	if (snap->used_pages_indx != 0)
+		return -EINVAL;
+
+	from_pgt = &host_mmu.pgt;
+	mmu = &host_mmu.arch.mmu;
+	required_pgd_len = kvm_pgtable_stage2_pgd_size(mmu->vtcr);
+	if (snap->pgd_pages < (required_pgd_len >> PAGE_SHIFT))
+		return -ENOMEM;
+
+	if (snap->mc.nr_pages < host_s2_pgtable_pages())
+		return -ENOMEM;
+
+	to_pgt = &snap->pgtable;
+	pgd = kern_hyp_va(snap->pgd_hva);
+
+	mm_ops.zalloc_page		= snap_zalloc_page;
+	mm_ops.free_pages_exact		= snap_free_pages_exact;
+	mm_ops.phys_to_virt		= hyp_phys_to_virt;
+	mm_ops.virt_to_phys		= hyp_virt_to_phys;
+	mm_ops.page_count		= hyp_page_count;
+
+	to_pgt->ia_bits		= from_pgt->ia_bits;
+	to_pgt->start_level	= from_pgt->start_level;
+	to_pgt->flags		= from_pgt->flags;
+	to_pgt->mm_ops		= &mm_ops;
+
+	host_lock_component();
+
+	to_pgt->pgd = pgd;
+	memcpy(to_pgt->pgd, from_pgt->pgd, required_pgd_len);
+	ret = kvm_pgtable_stage2_snapshot(to_pgt, &snap->mc);
+
+	host_unlock_component();
+
+	return ret;
+}
+
+int __pkvm_host_stage2_snapshot(struct kvm_pgtable_snapshot *snap_hva)
+{
+	int ret;
+	struct kvm_pgtable_snapshot *snap;
+	kvm_pteref_t pgd;
+
+	snap = pkvm_setup_snapshot(snap_hva);
+	if (!snap)
+		return -EPERM;
+
+	ret = pkvm_host_stage2_snapshot(snap);
+	if (!ret) {
+		pgd = snap->pgtable.pgd;
+		snap->pgtable.pgd = (kvm_pteref_t)__hyp_pa(pgd);
+	}
+	pkvm_teardown_snapshot(snap);
+	return ret;
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
 void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
 {
 	void *addr;
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 1966fdee7..82fef9620 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1598,3 +1598,46 @@ void kvm_pgtable_stage2_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *p
 	WARN_ON(mm_ops->page_count(pgtable) != 1);
 	mm_ops->put_page(pgtable);
 }
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+static int snapshot_walker(const struct kvm_pgtable_visit_ctx *ctx,
+			   enum kvm_pgtable_walk_flags visit)
+{
+	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
+	void *copy_table, *original_addr;
+	kvm_pte_t new = ctx->old;
+
+	if (!stage2_pte_is_counted(ctx->old))
+		return 0;
+
+	if (kvm_pte_table(ctx->old, ctx->level)) {
+		copy_table = mm_ops->zalloc_page(ctx->arg);
+		if (!copy_table)
+			return -ENOMEM;
+
+		original_addr = kvm_pte_follow(ctx->old, mm_ops);
+
+		memcpy(copy_table, original_addr, PAGE_SIZE);
+		new = kvm_init_table_pte(copy_table, mm_ops);
+	}
+
+	*ctx->ptep = new;
+
+	return 0;
+}
+
+int kvm_pgtable_stage2_snapshot(struct kvm_pgtable *to_pgt, void *mc)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= snapshot_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF |
+			  KVM_PGTABLE_WALK_TABLE_PRE,
+		.arg = mc
+	};
+
+	if (!to_pgt->pgd)
+		return -ENOMEM;
+
+	return kvm_pgtable_walk(to_pgt, 0, BIT(to_pgt->ia_bits), &walker);
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
-- 
2.43.0.472.g3155946c3a-goog


