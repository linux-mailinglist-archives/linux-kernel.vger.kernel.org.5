Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E577B02D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjI0L0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjI0L0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD2810C8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d865f1447a2so14060895276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813957; x=1696418757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aTzF9ImfQCjyHb9gICzxGcnOKx1R67tU4HaWRcwYMY=;
        b=0vyhyX5EwdaNG5zIrkHU5B+gC8s+5XjJoQ7458GnxzwxAOnB+HUse+BSWI8BggZhRQ
         8MWj9rnWzjShBQKHLpT0Fv7Svoj5GpjJ/P4QNs5tVDWtuldkbZGpY5B+gHxrOEXeFsXw
         y8s7XdounxB1fDCGAjU4/jla/g2GUCtewPqNGNNP5dBNbbrlLSY4SqcCVdf3KYnKbkJv
         45OY7jd37i8/eri3YW/P4NYldkzcMOKZ5j3dq+ldB/RW3ABWOqsMDszkC38dySLCh+dV
         LQ6YvI2fQsqBSY2a/B9dK5RpTsl1phFO7FnLjbaAJM2K022Ev8bQGvXGysDgMqdS/kpf
         MeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813957; x=1696418757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aTzF9ImfQCjyHb9gICzxGcnOKx1R67tU4HaWRcwYMY=;
        b=UmxbL6zzSjydvPwYUTNCUCNYsgutfPG9lPoIxtDzo6ar6pquX0Oo/gDEPkx8JoYdkI
         m2nqqa6fpqlb9l3X4o/FJzg9FGziGOsRGJzaH2lOzUbiygDryv9IhHgs8hhXHWapvsVD
         7r2gFG+HYYiqc2okVzAwE0w9/KjQubSdXnwuJ6EaUhzYr1Z+3RbhuB7LS7DtWjy615eh
         iOGjyBx8a607RM+3AYuqaTK2wleEMBcj3cGJL0aAe9+9qZtjiNTNwYjxGrZX0hRYFbSN
         6cCwTT2wDL5N7ZhpTO8tjV0bNzPGMAxPRlURUghyeopoP7rnwy6u0N0jRl2M92g/u/ib
         k21g==
X-Gm-Message-State: AOJu0Yzv8TXs3iR8WiJ0Y/sLQk6ePqBbFGaoGrDRYYL0817N0dbr3SYD
        a62P25z6AdV74R2B6LaEuVqA8JpYbtHNPSrks+gpPrKB/dLAFN0b8SeZtnrT/8SUPsu5AGcNV+Q
        BwJdlNwepm6xb3y3UzMbPif4s6QozbdmNQzX0bt7HZLcfpEH2aKhE4t+pnjRNdaH+KDg+95FJWE
        XBULo1y3aqDw==
X-Google-Smtp-Source: AGHT+IG6h3rnlp4xVqACIWObRx+O5lQYvZ6fB17pdr4CMpXNCGOlT19u1x/ijiUE/ePxxqJedNwhi9JWzaBRFnuDi0w=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a25:320c:0:b0:d7b:9830:c172 with SMTP
 id y12-20020a25320c000000b00d7b9830c172mr23368yby.0.1695813957189; Wed, 27
 Sep 2023 04:25:57 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:15 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-10-sebastianene@google.com>
Subject: [PATCH 09/11] arm64: ptdump: Interpret memory attributes based on
 runtime configuration
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

When FWB is used the memory attributes stored in the descriptors have a
different bitfield layout. Introduce two callbacks that verify the current
runtime configuration before parsing the attribute fields.
Add support for parsing the memory attribute fields from the page table
descriptors.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index c0e7a80992f4..964758d5e76d 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -85,13 +85,22 @@ struct pg_state {
 	bool check_wx;
 	unsigned long wx_pages;
 	unsigned long uxn_pages;
+	struct ptdump_info *info;
 };
 
+/*
+ * This callback checks the runtime configuration before interpreting the
+ * attributes defined in the prot_bits.
+ */
+typedef bool (*is_feature_cb)(const void *ctx);
+
 struct prot_bits {
 	u64		mask;
 	u64		val;
 	const char	*set;
 	const char	*clear;
+	is_feature_cb   feature_on;  /* bit ignored if the callback returns false */
+	is_feature_cb   feature_off; /* bit ignored if the callback returns true */
 };
 
 static const struct prot_bits pte_bits[] = {
@@ -173,6 +182,34 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static bool is_fwb_enabled(const void *ctx)
+{
+	const struct pg_state *st = ctx;
+	const struct ptdump_info *info = st->info;
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	struct kvm_pgtable *pgtable = &snapshot->pgtable;
+
+	bool fwb_enabled = false;
+
+	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+		fwb_enabled = !(pgtable->flags & KVM_PGTABLE_S2_NOFWB);
+
+	return fwb_enabled;
+}
+
+static bool is_table_bit_ignored(const void *ctx)
+{
+	const struct pg_state *st = ctx;
+
+	if (!(st->current_prot & PTE_VALID))
+		return true;
+
+	if (st->level == CONFIG_PGTABLE_LEVELS)
+		return true;
+
+	return false;
+}
+
 static const struct prot_bits stage2_pte_bits[] = {
 	{
 		.mask	= PTE_VALID,
@@ -214,6 +251,27 @@ static const struct prot_bits stage2_pte_bits[] = {
 		.val	= PTE_TABLE_BIT,
 		.set	= "   ",
 		.clear	= "BLK",
+		.feature_off	= is_table_bit_ignored,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_VALID,
+		.set	= "DEVICE/nGnRE",
+		.feature_off	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_FWB_DEVICE_nGnRE) | PTE_VALID,
+		.set	= "DEVICE/nGnRE FWB",
+		.feature_on	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_VALID,
+		.set	= "MEM/NORMAL",
+		.feature_off	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_FWB_NORMAL) | PTE_VALID,
+		.set	= "MEM/NORMAL FWB",
+		.feature_on	= is_fwb_enabled,
 	}, {
 		.mask	= KVM_PGTABLE_PROT_SW0,
 		.val	= KVM_PGTABLE_PROT_SW0,
@@ -289,13 +347,19 @@ static struct pg_level stage2_pg_level[] = {
 };
 
 static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
-			size_t num)
+		      size_t num)
 {
 	unsigned i;
 
 	for (i = 0; i < num; i++, bits++) {
 		const char *s;
 
+		if (bits->feature_on && !bits->feature_on(st))
+			continue;
+
+		if (bits->feature_off && bits->feature_off(st))
+			continue;
+
 		if ((st->current_prot & bits->mask) == bits->val)
 			s = bits->set;
 		else
@@ -651,6 +715,7 @@ static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 			.marker		= info->markers,
 			.level		= pgtable->start_level,
 			.pg_level	= &stage2_pg_level[0],
+			.info		= info,
 			.ptdump		= {
 				.note_page	= note_page,
 				.range		= (struct ptdump_range[]) {
-- 
2.42.0.515.g380fc7ccd1-goog

