Return-Path: <linux-kernel+bounces-3794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D18171BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55B41F262EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC7101D4;
	Mon, 18 Dec 2023 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FrIEjvL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8B3D558
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5cf4696e202so38360597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702908002; x=1703512802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaxQbDI0z91PmFyzqzSN6rlfHYYOk4E9JSBlc3pa6ug=;
        b=4FrIEjvLeTIHrtK29j+9GyEuxlhjS1nWcfEm73ttYKSTcqS+oqHW68b41m6CpofbM+
         B03diqU77gw79A+u+iLVBWAr/KyYo2+Z6w3/UghA9GjnUVXGSXmJSNvO+bCjxsnXaPbL
         x90MynyVjocMkyGF07+xuqmsG9NUqxniyKofTDds3bcjm0uxbKskWeO2jA03jTSYNgLr
         AhUDT9MsY1RQm21VLg7u4zzegZpwMsaUkPqC+CXnZmyMjUE5z+kbcTCsMnOMyWqtKpbW
         jBcOA7Ccwwg5C9jsFp4liHWXN5SfVRZHWuFVOcDWIBSTcsYW5ss999AH13MYkC4iFLqy
         LTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908002; x=1703512802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaxQbDI0z91PmFyzqzSN6rlfHYYOk4E9JSBlc3pa6ug=;
        b=QkWNa89O6D/C4yTpllpqYW3PHrVTFzf1i1Qnn7bxRfIXUNthnh6wPqOHZXBqFd6nZB
         hFLpB2RHxd0X4scwiyAppkIzyiEA5TDFxu2sFzWtB3PonaTKY6JGE5Kysm8g5MTRVZcO
         /BRY/8uQl31DOEV33MYRecGn0qsXj+DKaBUcY8pdEmNrbDH60StyQIBE9hWnj97Oy2NH
         HEolSbiDh78D9moNc4DqyI6/kDO0keUPLQtb4u4UPwbD1ErzKKSUnKB3cocR9R/UElVd
         TkxeThzPjq3w9I26MqciDRIlY/TXma0nYrkKNFwO7HL/ZBfmNUdl6YS/coef+EeMbX/X
         gPrA==
X-Gm-Message-State: AOJu0Yw9rELfGm73iBeYnq+4O9nLiacOT0a4CmKdyquHQn/Og0ez8Wxr
	P6VtYgTj3vpKlHi30IlgWOqspRhDK5TN/adoG8I=
X-Google-Smtp-Source: AGHT+IFdxs9UOFdPERhZjY8OFaYu75oZ041FHbjTLNFGBMLYUBQ7MdtHx0C9eihZ77Ez9vOgv3CrKRgqSuQvLgOuiJs=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:690c:891:b0:5d3:40f3:56bf with
 SMTP id cd17-20020a05690c089100b005d340f356bfmr2377671ywb.1.1702908002759;
 Mon, 18 Dec 2023 06:00:02 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:57 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-9-sebastianene@google.com>
Subject: [PATCH v4 07/10] KVM: arm64: Walk the pagetable snapshot and parse
 the ptdump descriptors
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

Define the attributes for the stage-2 pagetables that will be used by
the ptdump parser code to interepret and show the descriptors. Build the
pagetable level description dynamically and use the KVM pagetable walker
to visit the PTEs. Display the number of the bits used by the IPA
address space and the start level.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/ptdump.c | 135 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index e99bab427..80c338e03 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -40,6 +40,66 @@ static struct kvm_pgtable_mm_ops ptdump_host_mmops = {
 	.virt_to_phys	= get_host_pa,
 };
 
+static const struct prot_bits stage2_pte_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.set	= "XN",
+		.clear	= "  ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.set	= "R",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.set	= "W",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_NG,
+		.val	= PTE_NG,
+		.set	= "FnXS",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_CONT,
+		.val	= PTE_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_TABLE_BIT,
+		.val	= PTE_TABLE_BIT,
+		.set	= "   ",
+		.clear	= "BLK",
+	}, {
+		.mask	= KVM_PGTABLE_PROT_SW0,
+		.val	= KVM_PGTABLE_PROT_SW0,
+		.set	= "SW0", /* PKVM_PAGE_SHARED_OWNED */
+	}, {
+		.mask   = KVM_PGTABLE_PROT_SW1,
+		.val	= KVM_PGTABLE_PROT_SW1,
+		.set	= "SW1", /* PKVM_PAGE_SHARED_BORROWED */
+	}, {
+		.mask	= KVM_PGTABLE_PROT_SW2,
+		.val	= KVM_PGTABLE_PROT_SW2,
+		.set	= "SW2",
+	}, {
+		.mask   = KVM_PGTABLE_PROT_SW3,
+		.val	= KVM_PGTABLE_PROT_SW3,
+		.set	= "SW3",
+	},
+};
+
 static int kvm_ptdump_open(struct inode *inode, struct file *file)
 {
 	struct kvm_ptdump_register *reg = inode->i_private;
@@ -73,9 +133,82 @@ static int kvm_ptdump_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kvm_ptdump_build_levels(struct pg_level *level, unsigned int start_level)
+{
+	static const char * const level_names[] = {"PGD", "PUD", "PMD", "PTE"};
+	int i, j, name_index;
+
+	if (start_level > 2) {
+		pr_err("invalid start_level %u\n", start_level);
+		return -EINVAL;
+	}
+
+	for (i = start_level; i < KVM_PGTABLE_MAX_LEVELS; i++) {
+		name_index = i - start_level;
+		name_index += name_index * start_level;
+
+		level[i].name	= level_names[name_index];
+		level[i].num	= ARRAY_SIZE(stage2_pte_bits);
+		level[i].bits	= stage2_pte_bits;
+
+		for (j = 0; j < level[i].num; j++)
+			level[i].mask |= level[i].bits[j].mask;
+	}
+
+	return 0;
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
 static int kvm_ptdump_show(struct seq_file *m, void *)
 {
-	return -EINVAL;
+	u64 ipa_size;
+	char ipa_description[32];
+	struct pg_state st;
+	struct addr_marker ipa_addr_markers[3] = {0};
+	struct pg_level pg_level_descr[KVM_PGTABLE_MAX_LEVELS] = {0};
+	struct kvm_pgtable_snapshot *snapshot = m->private;
+	struct kvm_pgtable *pgtable = &snapshot->pgtable;
+	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
+		.cb	= kvm_ptdump_visitor,
+		.arg	= &st,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	if (kvm_ptdump_build_levels(pg_level_descr, pgtable->start_level) < 0)
+		return -EINVAL;
+
+	snprintf(ipa_description, sizeof(ipa_description),
+		 "IPA bits %2u start lvl %1u", pgtable->ia_bits,
+		 pgtable->start_level);
+
+	ipa_size = BIT(pgtable->ia_bits);
+	ipa_addr_markers[0].name = ipa_description;
+	ipa_addr_markers[1].start_address = ipa_size;
+
+	st = (struct pg_state) {
+		.seq		= m,
+		.marker		= &ipa_addr_markers[0],
+		.level		= -1,
+		.pg_level	= &pg_level_descr[0],
+		.ptdump	= {
+			.note_page	= note_page,
+			.range		= (struct ptdump_range[]) {
+				{0, ipa_size},
+				{0, 0},
+			},
+		},
+	};
+
+	return kvm_pgtable_walk(pgtable, 0, ipa_size, &walker);
 }
 
 static void kvm_ptdump_debugfs_register(struct kvm_ptdump_register *reg,
-- 
2.43.0.472.g3155946c3a-goog


