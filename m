Return-Path: <linux-kernel+bounces-3789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEBC8171B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C206C1C246CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E151D137;
	Mon, 18 Dec 2023 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdpVYKCD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94537884
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3333c009305so2212322f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702907993; x=1703512793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LD/nzFY+bvR1rFs9NYLk8iA9qjOdN0RioRORlh5RIvY=;
        b=vdpVYKCDfLhlgKQGMiVZJAA4KWBzuycpZ4G8H68n84/tISFGb/wkhKLxkXNVLrd+cQ
         lFceHAM7f4jZyQjFkAKtTG9lClSVpDh/GB+jSw3s4mAYSR7x8c/BzTwO764/TOdV1Neu
         aBHljePq8AR/BBYvbbvp3/FinedUKiO6eFJGpLt1qjNW6iQjnQIrSWbNPP3uEvWKF6Ij
         NVAOejGCu5DIszaxcXtSsY6DkRscW4lwuJ7i0fo6POG2hdMOI6ChSbPgVAhkw9YLVeCy
         amjNd+tPG2UnLGD3dgQFXHE/Sf/OuDMGbBzbhcC3cz2auSiVdeKaIhrYgP2WvliNZ9nH
         ZfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907993; x=1703512793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD/nzFY+bvR1rFs9NYLk8iA9qjOdN0RioRORlh5RIvY=;
        b=ljtdIEQqbo9pactMWU6a05FRT3a3Kubu1ljgrad/q0mT2F2AwwnRZtDNRZO6iJNUtu
         HFF12UbiiEb2Vv/0VUmk9mblFqEQ1s3oLmS7bFtbKhGb8HpIlAcsvAXR2kn/1EIgnInn
         rvPDJ6dm0oHTr6IiXTiiGN/puVrYGeaaftfzE659ApGct4cEhE/I2N750GAsI0wnVQ4F
         qpyib2PoUMUGsYeItSOGObrMRqii2kOIoaw3EJO1nYYKyU6GvU1+GJbMGUvRdonHPEwG
         jLyl5KF8OU2auW+FitEtdRJ71gTrLjiQUDc4FIX2hdM6CtMO7NhK0zhlt0rFhCUcaZp+
         ISkQ==
X-Gm-Message-State: AOJu0YxH142tbZ1+Z/1OdSXvE6m/Ez5t0ns31tdEqpWNT9zV3tCiFSG3
	KK9B+eE+Ik84rgIepZia7BZZ8MxpXzF8nQ4JKeE=
X-Google-Smtp-Source: AGHT+IEcnSKTTSrh78/RC8KORdrGIpZs/n1ecYZzGosf52yOA02mXkz/mRucWOXm1wghUliteBLHAeukkuvzSEjzuuI=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6000:1ac9:b0:336:4b35:ba52 with
 SMTP id i9-20020a0560001ac900b003364b35ba52mr32388wry.9.1702907993532; Mon,
 18 Dec 2023 05:59:53 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:53 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-5-sebastianene@google.com>
Subject: [PATCH v4 03/10] KVM: arm64: Invoke the snapshot interface for the
 host stage-2 pagetable
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

Allocate memory for the snapshot by creating a memory cache with empty
pages that will be used by the hypervisor during the page table copy.
Get the required size of the PGD and allocate physically contiguous
memory for it. Allocate contiguous memory for an array that is used to
keep track of the pages used from the memcache. Call the snapshot
interface and release the memory for the snapshot.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/ptdump.c | 107 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 5816fc632..e99bab427 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -25,6 +25,9 @@ static int kvm_ptdump_open(struct inode *inode, struct file *file);
 static int kvm_ptdump_release(struct inode *inode, struct file *file);
 static int kvm_ptdump_show(struct seq_file *m, void *);
 
+static phys_addr_t get_host_pa(void *addr);
+static void *get_host_va(phys_addr_t pa);
+
 static const struct file_operations kvm_ptdump_fops = {
 	.open		= kvm_ptdump_open,
 	.read		= seq_read,
@@ -32,6 +35,11 @@ static const struct file_operations kvm_ptdump_fops = {
 	.release	= kvm_ptdump_release,
 };
 
+static struct kvm_pgtable_mm_ops ptdump_host_mmops = {
+	.phys_to_virt	= get_host_va,
+	.virt_to_phys	= get_host_pa,
+};
+
 static int kvm_ptdump_open(struct inode *inode, struct file *file)
 {
 	struct kvm_ptdump_register *reg = inode->i_private;
@@ -78,11 +86,110 @@ static void kvm_ptdump_debugfs_register(struct kvm_ptdump_register *reg,
 
 static struct kvm_ptdump_register host_reg;
 
+static size_t host_stage2_get_pgd_len(void)
+{
+	u32 phys_shift = get_kvm_ipa_limit();
+	u64 vtcr = kvm_get_vtcr(read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1),
+				read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1),
+				phys_shift);
+	return (kvm_pgtable_stage2_pgd_size(vtcr) >> PAGE_SHIFT);
+}
+
+static phys_addr_t get_host_pa(void *addr)
+{
+	return __pa(addr);
+}
+
+static void *get_host_va(phys_addr_t pa)
+{
+	return __va(pa);
+}
+
+static void kvm_host_put_ptdump_info(void *snap)
+{
+	void *mc_page;
+	size_t i;
+	struct kvm_pgtable_snapshot *snapshot;
+
+	if (!snap)
+		return;
+
+	snapshot = snap;
+	while ((mc_page = pop_hyp_memcache(&snapshot->mc, get_host_va)) != NULL)
+		free_page((unsigned long)mc_page);
+
+	if (snapshot->pgd_hva)
+		free_pages_exact(snapshot->pgd_hva, snapshot->pgd_pages);
+
+	if (snapshot->used_pages_hva) {
+		for (i = 0; i < snapshot->used_pages_indx; i++) {
+			mc_page = get_host_va(snapshot->used_pages_hva[i]);
+			free_page((unsigned long)mc_page);
+		}
+
+		free_pages_exact(snapshot->used_pages_hva, snapshot->num_used_pages);
+	}
+
+	free_page((unsigned long)snapshot);
+}
+
+static void *kvm_host_get_ptdump_info(struct kvm_ptdump_register *reg)
+{
+	int i, ret;
+	void *mc_page;
+	struct kvm_pgtable_snapshot *snapshot;
+	size_t memcache_len;
+
+	snapshot = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+	if (!snapshot)
+		return NULL;
+
+	memset(snapshot, 0, sizeof(struct kvm_pgtable_snapshot));
+
+	snapshot->pgd_pages = host_stage2_get_pgd_len();
+	snapshot->pgd_hva = alloc_pages_exact(snapshot->pgd_pages, GFP_KERNEL_ACCOUNT);
+	if (!snapshot->pgd_hva)
+		goto err;
+
+	memcache_len = (size_t)reg->priv;
+	for (i = 0; i < memcache_len; i++) {
+		mc_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+		if (!mc_page)
+			goto err;
+
+		push_hyp_memcache(&snapshot->mc, mc_page, get_host_pa);
+	}
+
+	snapshot->num_used_pages = DIV_ROUND_UP(sizeof(phys_addr_t) * memcache_len,
+					     PAGE_SIZE);
+	snapshot->used_pages_hva = alloc_pages_exact(snapshot->num_used_pages,
+						  GFP_KERNEL_ACCOUNT);
+	if (!snapshot->used_pages_hva)
+		goto err;
+
+	ret = kvm_call_hyp_nvhe(__pkvm_host_stage2_snapshot, snapshot);
+	if (ret) {
+		pr_err("ERROR %d snapshot host pagetables\n", ret);
+		goto err;
+	}
+
+	snapshot->pgtable.pgd = get_host_va((phys_addr_t)snapshot->pgtable.pgd);
+	snapshot->pgtable.mm_ops = &ptdump_host_mmops;
+
+	return snapshot;
+err:
+	kvm_host_put_ptdump_info(snapshot);
+	return NULL;
+}
+
 void kvm_ptdump_register_host(void)
 {
 	if (!is_protected_kvm_enabled())
 		return;
 
+	host_reg.get_ptdump_info = kvm_host_get_ptdump_info;
+	host_reg.put_ptdump_info = kvm_host_put_ptdump_info;
+
 	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
 				    kvm_debugfs_dir);
 }
-- 
2.43.0.472.g3155946c3a-goog


