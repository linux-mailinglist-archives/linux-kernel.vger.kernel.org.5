Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893C97F5225
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbjKVVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjKVVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:12:15 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AF41A5;
        Wed, 22 Nov 2023 13:12:11 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 46e09a7af769-6ce2c5b2154so138977a34.3;
        Wed, 22 Nov 2023 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687531; x=1701292331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03wqCqNdJaIR+mhkCLDXmbEtw/nvWV7JtWUH8CKfPbk=;
        b=XqCNkqjEfiPy1oagjqduRGn0KoZZ2/7EmcihPDgvLrZuPbYETIeHN2OYQhnKzHfVD5
         /hE3vIr+g4LZUfBtqIh8MnS5lrVjGjSMP7zKGUmMxkeqUCB61gYZw5gNnWkd/+pkgs1v
         eT6R5sDBh8PRvQmkd1e3ihEzXJs6pnPklAjlm1BRK8onom7eusCg9r6aJupS0FORMeC6
         Bf45VYTJ7+ozSrPCOgVAgiz4JgzvQLhXUFonrrlH/cf1FP488iy6myPMvYeGGcPPoYLV
         xy66gkJCPjyuOVakQVOuc0h7acbe2zKjufT5iTU5LfmSY+0i5CqrBWZfptytvlqM/vW6
         6lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687531; x=1701292331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03wqCqNdJaIR+mhkCLDXmbEtw/nvWV7JtWUH8CKfPbk=;
        b=uzRgK8DLPrjQ22NeKM9p3RY/O6KnSxHlgzwPXUtvKfHKv5fIYK5OqtV9sjza7Hk+e8
         0iEUJyLdWKPNkmY/bYUSMoa+ONCQqUW9wbp+uuWwFtizc3d+GCUUSBBFrluxDBm+GVCv
         uo7EUlxCXsOjXes91epV+Rbj2tFdveGjkSqRlrAk9tNTGFt5hp2GGWsRbsLY2MGFYL/f
         nEb7iR9Q1ru+8A0/BqprWu4qCgdivvqZodAWuzHYRg1RniWpWDqdZTUnV58mdx1QTKxE
         TrF/5ZPnx4VRkwobSozQSLzE1M3XeMxi6Ifz3lry59mwFS5SMdsLy4CeJCKgx21i41UY
         lB1A==
X-Gm-Message-State: AOJu0YwhQuuH4h9gmfdOVWgMrFLMcBmnfrQ1/NxmXtu0tTToC8qhsBtI
        FsVyVAXv5sVI79Io985dbnSKXNVRusY8
X-Google-Smtp-Source: AGHT+IHcsK0aMfpRQrTeevPOO7K62/8e0CbVC+qqs3g2eVJvgvGpmbk4gG2Ep5IyIbhkFCI7iShlQA==
X-Received: by 2002:a05:6830:1102:b0:6b9:6419:1cde with SMTP id w2-20020a056830110200b006b964191cdemr3959734otq.22.1700687530930;
        Wed, 22 Nov 2023 13:12:10 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:10 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
        ying.huang@intel.com, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 02/11] mm/mempolicy: swap cond reference counting logic in do_get_mempolicy
Date:   Wed, 22 Nov 2023 16:11:51 -0500
Message-Id: <20231122211200.31620-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for making get/set mempolicy possible from outside the
context of the task being changed, we will need to take a reference
count on the task mempolicy in do_get_mempolicy.

do_get_mempolicy, operations on one of three policies

1) when MPOL_F_ADDR is set, it operates on a vma mempolicy
2) if the task does not have a mempolicy, default_policy is used
3) otherwise the task mempolicy is operated on

When the policy is from a vma, and that vma is a shared memory region,
the __get_vma_policy stack will take an additional reference

Change the behavior of do_get_mempolicy to unconditionally reference
whichever policy is operated on so that the cleanup logic can mpol_put
unconditionally, and mpol_cond_put is only called when a vma policy is
used.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 410754d56e46..37da712259d7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -900,9 +900,9 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			     unsigned long addr, unsigned long flags)
 {
 	int err;
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm;
 	struct vm_area_struct *vma = NULL;
-	struct mempolicy *pol = current->mempolicy, *pol_refcount = NULL;
+	struct mempolicy *pol = NULL, *pol_refcount = NULL;
 
 	if (flags &
 		~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR|MPOL_F_MEMS_ALLOWED))
@@ -925,29 +925,38 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		 * vma/shared policy at addr is NULL.  We
 		 * want to return MPOL_DEFAULT in this case.
 		 */
+		mm = current->mm;
 		mmap_read_lock(mm);
 		vma = vma_lookup(mm, addr);
 		if (!vma) {
 			mmap_read_unlock(mm);
 			return -EFAULT;
 		}
-		pol = __get_vma_policy(vma, addr, &ilx);
+		/*
+		 * __get_vma_policy can refcount if a shared policy is
+		 * referenced.  We'll need to do a cond_put on the way
+		 * out, but we need to reference this policy either way
+		 * because we may drop the mmap read lock.
+		 */
+		pol = pol_refcount = __get_vma_policy(vma, addr, &ilx);
+		mpol_get(pol);
 	} else if (addr)
 		return -EINVAL;
+	else {
+		/* take a reference of the task policy now */
+		pol = current->mempolicy;
+		mpol_get(pol);
+	}
 
-	if (!pol)
+	if (!pol) {
 		pol = &default_policy;	/* indicates default behavior */
+		mpol_get(pol);
+	}
+	/* we now have at least one reference on the policy */
 
 	if (flags & MPOL_F_NODE) {
 		if (flags & MPOL_F_ADDR) {
-			/*
-			 * Take a refcount on the mpol, because we are about to
-			 * drop the mmap_lock, after which only "pol" remains
-			 * valid, "vma" is stale.
-			 */
-			pol_refcount = pol;
 			vma = NULL;
-			mpol_get(pol);
 			mmap_read_unlock(mm);
 			err = lookup_node(mm, addr);
 			if (err < 0)
@@ -982,11 +991,11 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 	}
 
  out:
-	mpol_cond_put(pol);
+	mpol_put(pol);
 	if (vma)
 		mmap_read_unlock(mm);
 	if (pol_refcount)
-		mpol_put(pol_refcount);
+		mpol_cond_put(pol_refcount);
 	return err;
 }
 
-- 
2.39.1

