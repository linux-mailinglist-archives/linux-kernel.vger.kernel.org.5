Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837F7B02D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjI0L0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjI0L0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:05 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0574CFB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:56 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-3200597bfc5so8330093f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813955; x=1696418755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jN3lkJwQH7CcPgPrstq/ICC5W9G0uqc/IaOXXHWKors=;
        b=DxTCiJis/AcQO8gAQpI86m+UiwbN46965ejxBx2PWsrdb+yxy4TuLbIlT4SW5p/Ga1
         kjR4GogANb+jCAnbGFSHqmYP408FsAcpEZqL5SVatcnIlSUDISGtsmZL64Q5TGMrq9ZB
         rM+LJ1ss4Up9KoVM6bZ52KR+MFJutCA4BLUlsLlFS3hQLbNkcfuBCBj2X2Whp8u/ASOl
         T82OsLTkwU4HWhFd+1pFRivw9dg392DlMX9YqZ/hN0i7j6XNdhQy/J7utvWXfpw4HE1C
         sSRfCu+b06TNVDrzrOiWPPjfBv8FTVexuKdxZSa7TP0jLwoQFG5WyGGyoW1J2mfLNdpl
         Xpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813955; x=1696418755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN3lkJwQH7CcPgPrstq/ICC5W9G0uqc/IaOXXHWKors=;
        b=wmXo/ZTokViqGCiP2DcGaFuUdwN0NxbPU/yJIC1v+1AV8wbO/ybnnXhii7XeZc14VJ
         JwK3l6D0kAG4iYkV30mAYVHli3yhACH0S2RMgDGYdGnXDf+4dDH7ZQnymKm+zKM3Rykl
         gyIe4Z9H70nIbnxO15Dwt1MejRn3X+wxafl6FqBjBt3J7AalrBfO7KIP3BQnHqBkYuUO
         LYCiFLZNx/wtZaAOp5HxrNeAPGfxAURzXhRnGtqTh8uqsKxddhXLIBTdKKpbTBOIWTpf
         oNz72VWTbD0Q+eC5sUNo8WivWJ6Ks2ZKRy5eRfAr+mGNpbGDpLK0EiZuuE+1PusZdiu1
         BSyQ==
X-Gm-Message-State: AOJu0Yz4lxkdBjt67yBNrgzlCBexReKLOoBAyWWj9c5rmXwtMAqIx8j9
        l9RFUmrTcipfcATBjt3jkBZs5XWl5aGf80UNBvA3HfNtjruIkLV4wqXxrRdJQVOESnUILNRQWxi
        wi/7sUof84hk4MUUQj9yWYLbeeqyXL20WANqnHGElhcx5TyZ2R4c4pHK2KKX71DqetpqzKJp7eU
        cC///coXX//w==
X-Google-Smtp-Source: AGHT+IE3A820cQ/y4mbsComz1ykZCVHcGo3U5+ifA660U100IZXWLdK4GFVh/vkC156Eah7o4bmqEF4qbdLspVFDzw8=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:4203:0:b0:321:9ba4:1d78 with SMTP
 id n3-20020a5d4203000000b003219ba41d78mr7707wrq.4.1695813954971; Wed, 27 Sep
 2023 04:25:54 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:14 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-9-sebastianene@google.com>
Subject: [PATCH 08/11] arm64: ptdump: Parse the host stage-2 page-tables from
 the snapshot
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

Add a walker function which configures ptdump to parse the page-tables
from the snapshot. Convert the physical address of the pagetable's start
address to a host virtual address and use the ptdump walker to parse the
page-table descriptors.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 7d57fa9be724..c0e7a80992f4 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -616,6 +616,58 @@ static void stage2_ptdump_end_walk(struct ptdump_info *info)
 	free_pages_exact(snapshot, PAGE_SIZE);
 	info->priv = NULL;
 }
+
+static u32 stage2_get_max_pgd_index(u32 ipa_bits, u32 start_level)
+{
+	u64 end_ipa = BIT(ipa_bits) - 1;
+	u32 shift = ARM64_HW_PGTABLE_LEVEL_SHIFT(start_level - 1);
+
+	return end_ipa >> shift;
+}
+
+static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	struct pg_state st;
+	struct kvm_pgtable *pgtable;
+	u32 pgd_index, pgd_pages, pgd_shift;
+	u64 start_ipa = 0, end_ipa;
+	pgd_t *pgd;
+
+	if (snapshot == NULL || !snapshot->pgtable.pgd)
+		return;
+
+	pgtable = &snapshot->pgtable;
+	info->mm->pgd = phys_to_virt((phys_addr_t)pgtable->pgd);
+	pgd_shift = ARM64_HW_PGTABLE_LEVEL_SHIFT(pgtable->start_level - 1);
+	pgd_pages = stage2_get_max_pgd_index(pgtable->ia_bits,
+					     pgtable->start_level);
+
+	for (pgd_index = 0; pgd_index <= pgd_pages; pgd_index++) {
+		end_ipa = start_ipa + (1UL << pgd_shift);
+
+		st = (struct pg_state) {
+			.seq		= s,
+			.marker		= info->markers,
+			.level		= pgtable->start_level,
+			.pg_level	= &stage2_pg_level[0],
+			.ptdump		= {
+				.note_page	= note_page,
+				.range		= (struct ptdump_range[]) {
+					{start_ipa,	end_ipa},
+					{0,		0},
+				},
+			},
+		};
+
+		ipa_address_markers[0].start_address = start_ipa;
+		ipa_address_markers[1].start_address = end_ipa;
+
+		pgd = &info->mm->pgd[pgd_index * PTRS_PER_PTE];
+		ptdump_walk_pgd(&st.ptdump, info->mm, pgd);
+		start_ipa = end_ipa;
+	}
+}
 #endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
 
 static int __init ptdump_init(void)
@@ -634,6 +686,7 @@ static int __init ptdump_init(void)
 		.mc_len			= host_s2_pgtable_pages(),
 		.ptdump_prepare_walk	= stage2_ptdump_prepare_walk,
 		.ptdump_end_walk	= stage2_ptdump_end_walk,
+		.ptdump_walk		= stage2_ptdump_walk,
 	};
 
 	init_rwsem(&ipa_init_mm.mmap_lock);
-- 
2.42.0.515.g380fc7ccd1-goog

