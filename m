Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227E27B02D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjI0L0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjI0L0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0B1B5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a1eb48d346so60705237b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813950; x=1696418750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fj32EN9jrUIkb2wzfxrKtc2Y3Ax+u71fUp4xcpv8B/Q=;
        b=TdvtmnogFqxrm62pBVa4QdvHDHxnVRzB/GlMjAWwqwnZZTdDgOaDI7tacsyk7xHbxU
         19UIChUc5KojmO2Rt5T9vKlTqnKnmtkujA+dM2qR+HGQ7V5aX8v9qdV5jnXMkYFCp7h0
         Hh3BMApEE3XfQcr645tLOxcN/y+McWep0y0FslgjCT4Xddu9Dhui6j2w9DsY4Pz9L2tJ
         xfj13VwHgqKHR2XHQ8YKx1pRDLfo89qGYV7+N/q8zVH9HYEiIiiX/zCQGZIV8KbXhCZK
         IaplWuAW7zUjrf7cXcwHBYvxwGoZzF8nKlu225z/Zndn4slHsbs+v4s2CXACOqoSwhU4
         twAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813950; x=1696418750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj32EN9jrUIkb2wzfxrKtc2Y3Ax+u71fUp4xcpv8B/Q=;
        b=gi7dP/HjdSqShHIYW76FREHHkbKAHXuRVfaV6a5r1UkV/YfVnRB/DMQlpfrtj7uezJ
         GObcWTgg9afrv6r83nx/SIBSz8JIUebA2l4obbyo6qYpkvxq3z9zkgd6cXQf60nMmdYt
         dJf2qdWSPwvh2saVd+LdzKLgfqe6uKCJnp+jaIiTLLWN1zbKxP+VGuo4mewEwKSctVc9
         omXcF6blILMwlgZf+dddPyJNmlqLltJ08ZfcWlfQavHTbrSoMDxyVDe8mzPmC8erAehN
         X+XsMdFTy1f3mqX3OpWKQUdxaR1cBUT/HrO+Uukx7TN8fH+e/JhMM6jsjI/3WyoiJc6k
         4qBg==
X-Gm-Message-State: AOJu0Yxh8w7lMXhUIoscXO52//E3qHDH1Vhyme4oX1IqUiIpCpWlWPze
        qBFQENYF08qA98ovOJMYMgNmO5aZ5+YmlDIMFqJ/AepO2HP0XH4D7JKV0KwCnQa6vdBo9yJ9p0K
        6nmY7Aq2L0UZeQchoWEu2+QAanVEQ1KPqQte2rL07XjMotd2pTb4JcUXaAzCRCRsULPTYhQLiag
        TcMUx+lWV+uA==
X-Google-Smtp-Source: AGHT+IHxCJ923kxJMZh2TT9e3CG4y38u82v/079rxMmN4eNxHyioud7MJSX14GEDAGr1IVx94nj6U1Gvg9BdVTgumEg=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:1613:b0:d80:ff9:d19e with
 SMTP id bw19-20020a056902161300b00d800ff9d19emr23618ybb.9.1695813950463; Wed,
 27 Sep 2023 04:25:50 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:12 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-7-sebastianene@google.com>
Subject: [PATCH 06/11] arm64: ptdump: Register a debugfs entry for the host
 stage-2 page-tables
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

Initialize the structures used to keep the state of the stage-2 ptdump
walker. To satisfy the ptdump API for parsing no VMA regions, initialize
a memory structure. Since we are going to parse a snapshot of the host
stage-2 paget-tables we don't rely on the locking from the memory
structure.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/Kconfig | 12 ++++++++++++
 arch/arm64/mm/ptdump.c | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be42e..2974bb5c4838 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -71,4 +71,16 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config NVHE_EL2_PTDUMP_DEBUGFS
+	bool "Present the stage-2 pagetables to debugfs"
+	depends on NVHE_EL2_DEBUG && PTDUMP_DEBUGFS
+	help
+	  Say Y here if you want to show the pKVM host stage-2 kernel pagetable
+	  layout in a debugfs file. This information is only useful for kernel developers
+	  who are working in architecture specific areas of the kernel.
+	  It is probably not a good idea to enable this feature in a production
+	  kernel.
+
+	  If in doubt, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 8c4f06ca622a..25c0640e82aa 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -469,6 +469,21 @@ void ptdump_check_wx(void)
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
 
+#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
+static struct ptdump_info stage2_kernel_ptdump_info;
+static struct addr_marker ipa_address_markers[] = {
+	{ 0,	"IPA start"},
+	{ -1,	"IPA end"},
+	{ -1,	NULL},
+};
+
+/* Initialize a memory structure used by ptdump to walk the no-VMA region */
+static struct mm_struct ipa_init_mm = {
+	.mm_mt		= MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS,
+					 ipa_init_mm.mmap_lock),
+};
+#endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
+
 static int __init ptdump_init(void)
 {
 	address_markers[PAGE_END_NR].start_address = PAGE_END;
@@ -477,6 +492,17 @@ static int __init ptdump_init(void)
 #endif
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+
+#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
+	stage2_kernel_ptdump_info = (struct ptdump_info) {
+		.markers	= ipa_address_markers,
+		.mm		= &ipa_init_mm,
+	};
+
+	init_rwsem(&ipa_init_mm.mmap_lock);
+	ptdump_debugfs_register(&stage2_kernel_ptdump_info,
+				"host_stage2_kernel_page_tables");
+#endif
 	return 0;
 }
 device_initcall(ptdump_init);
-- 
2.42.0.515.g380fc7ccd1-goog

