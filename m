Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2F767A10
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjG2AtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjG2AtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:49:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600C64C05
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:48:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso2540826276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591651; x=1691196451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KOObXu2LRWfktefTbSv0nGlH9PUyJX357fkNUYIVNiM=;
        b=E/Mif1GxxzCSs4J0CWgiH+3lhdJsRRKDRQ8W1XxRfmPB4I7CNN0zq3CrBgCo19fyHi
         VJAI2yq7lC7SMbLhQEPJdvBYcuhv4RzCNiuAbLv27A7BkDnk5lbGB/jcljUI+lpDlO7n
         QGMql+IBF5Y1p6gCK3AH1gqw/qfsxG/P8dG7DIlS32d7JXFLZ73NVHJ6xFhuLgl3Zsh3
         nAD6cOLuSA0KQCAOJJrnPqEkk1GQkcdEOZ5A8Wc0VC5KVYIbrlRJlugNo8rQqAVuCTcl
         oZPvhlUQxzEH4F06u7ixjutZdHx51ed7ll0m32EG8+IBMjJ2uWJa6CkqIN5/UrId4k+F
         jEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591651; x=1691196451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOObXu2LRWfktefTbSv0nGlH9PUyJX357fkNUYIVNiM=;
        b=G+8QQPITcHKFw4Hzhk6cjbvHj7eqzFGoRSrGK30mF2y3yqe4+jvZ74qvtAIh8IXPpt
         EvxyrGwTidVp++j2cp7iraQfiI0/q4PTYrwV6xnTf7Jte3v9U7+dgyrWKftU0L0Lr4mp
         RWY0KqmDbC2OgCIil3PkWK/xrTpqFKkClp/mx5uJyX+7qpZnZd44+CxkhRN2WRCnMFAG
         oAZFhDq0l04XPJLgFa9RmW8rRQZfJu6oqLUwG2jYbWqBDa++mjAu1jwDHlJ0wkSEIaNo
         TEtnDSkKPEUeupGpYLYb8IQ4YTbFJsOT+JGD/ktarAIN/QBWRX9YvcvH94/ESZ9pQPKw
         cSOw==
X-Gm-Message-State: ABy/qLb+4xNHaPNnzOVKVsD6Mw/aUl0OjAumzR3U50EtwLJ/DSfzUE/7
        xZ9djG+qL8tBz4wrkp1v13CTtyb9tDQ=
X-Google-Smtp-Source: APBJJlETEtPrd5tLyKxSitU5wfRKgJHmcius0XTBz3cHnDezAzUc5h3YlC0Ha0SpYLSH1EyXRwy1oHmk3xQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:acde:0:b0:d1c:6a5e:3e46 with SMTP id
 x30-20020a25acde000000b00d1c6a5e3e46mr18569ybd.8.1690591651665; Fri, 28 Jul
 2023 17:47:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:47:14 -0700
In-Reply-To: <20230729004722.1056172-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729004722.1056172-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729004722.1056172-5-seanjc@google.com>
Subject: [PATCH v3 04/12] KVM: x86/mmu: Avoid pointer arithmetic when
 iterating over SPTEs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the pointer arithmetic used to iterate over SPTEs in
is_empty_shadow_page() with more standard interger-based iteration.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b16092d71d3f..08d08f34e6a3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1696,15 +1696,15 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 #ifdef MMU_DEBUG
 static int is_empty_shadow_page(u64 *spt)
 {
-	u64 *pos;
-	u64 *end;
+	int i;
 
-	for (pos = spt, end = pos + SPTE_ENT_PER_PAGE; pos != end; pos++)
-		if (is_shadow_present_pte(*pos)) {
+	for (i = 0; i < SPTE_ENT_PER_PAGE; i++) {
+		if (is_shadow_present_pte(spt[i])) {
 			printk(KERN_ERR "%s: %p %llx\n", __func__,
-			       pos, *pos);
+			       &spt[i], spt[i]);
 			return 0;
 		}
+	}
 	return 1;
 }
 #endif
-- 
2.41.0.487.g6d72f3e995-goog

