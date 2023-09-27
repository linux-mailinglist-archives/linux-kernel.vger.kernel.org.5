Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046E57B02D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjI0L0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjI0L0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:26:09 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AECC9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:26:01 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-32323283257so5369910f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813960; x=1696418760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxbnVeeBsmxebuYPX9n5F7ayQvPWmM0quJncxxttJX8=;
        b=cORnPyxnYUUDBEx8bFQsUJFhOFPxcisp5LuuwGrzGxDZYmQlbYb2sp29gySnKTpzqQ
         WZAE3x0kIcTFCrbRRXEZpeprCNaPrvHa7Kul4Vlh+gKKdp3fWzrgMpXWlvuEHJ9cK8rb
         GXH6Ax6RiiOXxZ3nKhGbEA4K+GWp4B192o2hrNfUzNvBiLCi7lb+RKzQP4jXcwhX7MSX
         aqQ7CLQeH4tvYIJVKoOeo3x4SJvALRIFNWc45igJw/gNCOZr9ntfV8yfbBoE4WRdIvcn
         k+lFfUzez+fx27EcTC3HD4D3YNruPFxaA2J7rISMCOKn5lNr75xWf48hmpySDJrDR+Hl
         HBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813960; x=1696418760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxbnVeeBsmxebuYPX9n5F7ayQvPWmM0quJncxxttJX8=;
        b=C/7XUlqw6PKK4BITEeJVBMKHD+sCeyWT5XMnXPs4Gi0ypQJLPjwnTLHKWXXSkRhDGk
         bMp3Fg4O14vSI4+VB9hk7NqCU6IzADiLDlY/YeN0xxk8yd5weAzvr+NjHP3DB90llQbE
         dYtsCzWOEtRvE8nVMcTQouKgj2Yl2h9PRfXRTmaosg4U9fLtvJC5xby0sIbiOYcat1ZM
         b1UH7Ew8XdZYpgHoEHF/8aA54h+sDl0p6vHJ/9n+0DOdQS2hVS9gF6wzHckz+mQKRQEc
         pOJFO6TLD53dkV0mS813Ya/6ahUVR9CoMA8vkgLZf4mYYRZtt2Kg2MyXu6W0PHNPzWNS
         wudQ==
X-Gm-Message-State: AOJu0Yws4SWiteOGieqTK0XUF05mVKbzEcARqsBM95m4P0cFEmNl1V/A
        QHp7aO+kSeDY3mw5BokU8KZlolwABqkYGp7j1jAKXU99SdUVQKTUm846ppHMO0rBSVVLrWeSRDo
        YXOjcY/T155RJ1qoneP/MpHGsUQVTJs0qLYvcjP5h7oNBhR0UDdwfAG4sklD72MzyB4CR5TE+7R
        YDCiRfZBefEw==
X-Google-Smtp-Source: AGHT+IF71lumBuTGUXS9V0C8ymppFqSSNoTvIEFjI96Wmj9/Vmv0u514CiXmzi1QXxPKCgHvxgS+7DFmPSfrLre53Hs=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:adf:ed84:0:b0:317:6e79:423c with SMTP
 id c4-20020adfed84000000b003176e79423cmr7347wro.3.1695813959676; Wed, 27 Sep
 2023 04:25:59 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:16 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-11-sebastianene@google.com>
Subject: [PATCH 10/11] arm64: ptdump: Interpret pKVM ownership annotations
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

Add support for interpretting pKVM invalid stage-2 descriptors that hold
ownership information. We use these descriptors to keep track of the
memory donations from the host side.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h          |  7 +++++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  7 -------
 arch/arm64/mm/ptdump.c                        | 10 ++++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 913f34d75b29..938baffa7d4d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -87,6 +87,13 @@ typedef u64 kvm_pte_t;
  */
 #define KVM_INVALID_PTE_LOCKED		BIT(10)
 
+/* This corresponds to page-table locking order */
+enum pkvm_component_id {
+	PKVM_ID_HOST,
+	PKVM_ID_HYP,
+	PKVM_ID_FFA,
+};
+
 static inline bool kvm_pte_valid(kvm_pte_t pte)
 {
 	return pte & KVM_PTE_VALID;
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9cfb35d68850..cc2c439ffe75 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -53,13 +53,6 @@ struct host_mmu {
 };
 extern struct host_mmu host_mmu;
 
-/* This corresponds to page-table locking order */
-enum pkvm_component_id {
-	PKVM_ID_HOST,
-	PKVM_ID_HYP,
-	PKVM_ID_FFA,
-};
-
 extern unsigned long hyp_nr_cpus;
 
 int __pkvm_prot_finalize(void);
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 964758d5e76d..45ff4ebae01a 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -272,6 +272,16 @@ static const struct prot_bits stage2_pte_bits[] = {
 		.val	= PTE_S2_MEMATTR(MT_S2_FWB_NORMAL) | PTE_VALID,
 		.set	= "MEM/NORMAL FWB",
 		.feature_on	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_INVALID_PTE_OWNER_MASK | PTE_VALID,
+		.val	= FIELD_PREP_CONST(KVM_INVALID_PTE_OWNER_MASK,
+					   PKVM_ID_HYP),
+		.set	= "HYP",
+	}, {
+		.mask	= KVM_INVALID_PTE_OWNER_MASK | PTE_VALID,
+		.val	= FIELD_PREP_CONST(KVM_INVALID_PTE_OWNER_MASK,
+					   PKVM_ID_FFA),
+		.set	= "FF-A",
 	}, {
 		.mask	= KVM_PGTABLE_PROT_SW0,
 		.val	= KVM_PGTABLE_PROT_SW0,
-- 
2.42.0.515.g380fc7ccd1-goog

