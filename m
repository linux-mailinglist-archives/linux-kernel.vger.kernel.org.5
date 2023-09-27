Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EFE7B02D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjI0L0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjI0LZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:25:53 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B71B6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:49 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-3200597bfc5so8329904f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813947; x=1696418747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sg+l4AZqIjzZdAaAwEVRBA1XU/OEUMwb2p3CABcyD1c=;
        b=jOKDwqBtMbeCeYiTjWu4QKR1urFyjADm+DhAq3yU9D4EPymCSj0CyrZ5D8ZeCsHRSA
         rcu+dZD9uWUoVPRF0V80XsleivemJAe3tu/OirdbOXXT75G4bNTChWBfD61VpjKvs7r/
         ThOb/17hfeG1Y9KFoNxIUILqtoby/UwdjCGGWeskQ0IYnRNZOhCTiR1EXTQ9+YoDLkVv
         tZkD5qyC/PI3kROAvBY9hu2edJV1JdvnXp3WPgwUnwSZOp6+00QgjCF3VjFCa1+XP1nY
         4huVFdcllD21Hej5vR0zo6TywNjcRWXhXilFx+To1A6mjVby2/WAN2MV22hAe6NrkzAw
         9+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813947; x=1696418747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg+l4AZqIjzZdAaAwEVRBA1XU/OEUMwb2p3CABcyD1c=;
        b=KHNW3sMgZQEvPrWuHMQgZmdpuqBv2pS3hIJoddPirBoQ3EwjFAlNUIrVJyfvvAnkxR
         VnmDX4vWCNjj2dTH2RcETmIXb0SB1/CA+ps0hBA8ZGlv2/Zh3GKq9hFriVQx3brwE4dU
         k6pl+SpWrCXoIFSBHHs7tkwZRbPTZC8vQ18lRDjg8VE8eT7S0eJxD73rFdwDzzWb5Bqc
         g/Uk1vhGHD9ufAItKyoRtjJ0qo5BNwB6wslsKkYCGdLto6Fo59GiOPMB/xRPE+dk3w4T
         OnFBFqT3kztB2Ljgq+wMaS5YMPTix2kPO7PwPMu7fMhqIUBIfu4IXqrl/XenKeLqMRB5
         NAgw==
X-Gm-Message-State: AOJu0YzGNb6Hg7diXHR5M536fxTsBkBBuPCG49/nmS771rXnarY27l3W
        tS3bd3AiiAcsiH2INhhLYgdoYmL+HBlBTxU/Xcsw0aFhyXtNHCX16zpT0jiuYuwHmG0oAuox5nB
        qs+Ig5mhwySuADWB4al/AbxqKJUq29eTIbKgZwdqsaKBn9Tv/nZWEy9pPVeoYO9kJsK+SfSrBat
        KSJwjg1KFV3Q==
X-Google-Smtp-Source: AGHT+IHPrx/jXai9ztlh+8kqBcUIhuwWCWlP9e5KVrE4MuvGMOnAf2SPceNMd1VhY9NqEPpwFuLqE/msc13mlIHYKUU=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:4145:0:b0:31f:f72b:520c with SMTP
 id c5-20020a5d4145000000b0031ff72b520cmr7783wrq.6.1695813947441; Wed, 27 Sep
 2023 04:25:47 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:11 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-6-sebastianene@google.com>
Subject: [PATCH 05/11] arm64: ptdump: Introduce stage-2 pagetables format description
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

Add an array which holds human readable information about the format of
a stage-2 descriptor. The array is then used by the descriptor parser
to extract information about the memory attributes.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index d531e24ea0b2..8c4f06ca622a 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/kvm_pgtable.h>
 
 
 enum address_markers_idx {
@@ -171,6 +172,66 @@ static const struct prot_bits pte_bits[] = {
 	}
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
 struct pg_level {
 	const struct prot_bits *bits;
 	const char *name;
@@ -202,6 +263,30 @@ static struct pg_level pg_level[] = {
 	},
 };
 
+static struct pg_level stage2_pg_level[] = {
+	{ /* pgd */
+		.name	= "PGD",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* p4d */
+		.name	= "P4D",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* pud */
+		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* pmd */
+		.name	= (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* pte */
+		.name	= "PTE",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	},
+};
+
 static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
 			size_t num)
 {
@@ -340,6 +425,12 @@ static void __init ptdump_initialize(void)
 		if (pg_level[i].bits)
 			for (j = 0; j < pg_level[i].num; j++)
 				pg_level[i].mask |= pg_level[i].bits[j].mask;
+
+	for (i = 0; i < ARRAY_SIZE(stage2_pg_level); i++)
+		if (stage2_pg_level[i].bits)
+			for (j = 0; j < stage2_pg_level[i].num; j++)
+				stage2_pg_level[i].mask |=
+					stage2_pg_level[i].bits[j].mask;
 }
 
 static struct ptdump_info kernel_ptdump_info = {
-- 
2.42.0.515.g380fc7ccd1-goog

