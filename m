Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D317D3714
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjJWMoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:44:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1EA4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:44:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084095722aso26641265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698065051; x=1698669851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BkZRd/nHdW+WFHWWBpjALYN0SW0pUOeRbQK7UPlimYM=;
        b=L89AmZQCB9iLHyYABe2q4kIcxj7cE2ivu43J/gjhJdahI5pU+36fOzei6+6lL00Mlq
         gKFkZw6201ej9qqBvuY6vnRF7z8OxsjgbhRIlB39LF/FKlPm8FF9aaHRXHAgwWPQ7Dp7
         B1ZmAYTtbpftdeZS9XPTrILrvEuoTvmByJgtiI7IYPSkmxdh+s2Hbf1wLsjIuPjHuXen
         uC4o27pLZCo7NLN9x8vhp8zoG2M3LvbfGBtQOKnTW8n+RpNjFK2/lVz0nBikswRPEZGv
         8IHV3sTHz8A52ETxod+2WnvSHJSlUyAJI9Wb99k2delZ5rhLmnICGS4uie9SM+lhTA8q
         YXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065051; x=1698669851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkZRd/nHdW+WFHWWBpjALYN0SW0pUOeRbQK7UPlimYM=;
        b=klMrFg84X084RwR8zwhCV1BmiYvv3YNMhOutUGTltIrdtqsObtanCjMGt/wLwG+cii
         /dlwknN4upO6uQniiXuiT/BhXh8IMWIc+agDmYNPzxLruDhisJRHrSGQRVJe7YRT62qF
         MDrULmJ6MdIYrgj5x84gP0+9oCUiA6asH9bvUWkDhpltWMaT6wIk2DLpe8oA2YBDDu48
         7ivHYHHhMIEbfXo+pgPRqBCHXHLAKIeokAvbcUwy1gaXqBjOiLG5KeO+eWxKDw5/Or2F
         S9uM/5GrQ3GmIqtWTtzT8V6NFf8lgJmaItPWUhQ0HS1g0e9ET5Qm3iVg291Ne5In4FBv
         Lskw==
X-Gm-Message-State: AOJu0YyI74ikrGYfw+Cx/734O2IBoTcVQcwlzlMOtaCDKRTdZDI1utng
        po/ksgvyMPDmwcr67VTuZixc2v8O8/O0nq/q
X-Google-Smtp-Source: AGHT+IGw+nUZMaJ9mJIq7rzL1i64NwpFMYW0i1QgrS3kX1Y10Na1RE0woSyN1ZqRE9qNTnnTquWm1w==
X-Received: by 2002:a05:600c:4fd6:b0:406:84a0:bc87 with SMTP id o22-20020a05600c4fd600b0040684a0bc87mr6918063wmq.15.1698065051179;
        Mon, 23 Oct 2023 05:44:11 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b00407460234f9sm9389753wmb.21.2023.10.23.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:44:10 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     willy@infradead.org, James.Bottomley@hansenpartnership.com,
        rdunlap@infradead.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH v2] mm: Fixed multiple typos in multiple files
Date:   Mon, 23 Oct 2023 17:44:05 +0500
Message-Id: <20231023124405.36981-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    memcontrol.c: Fixed typo 'relies'

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

changes since v1:

mm: Fixed multiple typos in multiple files

    debug_vm_pgtable.c: Fixed typo
    internal.h: Fixed typo
    memcontrol.c: Fixed typo
    mmap.c: Fixed typo
---
 mm/debug_vm_pgtable.c | 4 ++--
 mm/internal.h         | 2 +-
 mm/memcontrol.c       | 4 ++--
 mm/mmap.c             | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 48e329ea5ba3..e651500e597a 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1322,8 +1322,8 @@ static int __init debug_vm_pgtable(void)
 	 * true irrespective of the starting protection value for a
 	 * given page table entry.
 	 *
-	 * Protection based vm_flags combinatins are always linear
-	 * and increasing i.e starting from VM_NONE and going upto
+	 * Protection based vm_flags combinations are always linear
+	 * and increasing i.e starting from VM_NONE and going up to
 	 * (VM_SHARED | READ | WRITE | EXEC).
 	 */
 #define VM_FLAGS_START	(VM_NONE)
diff --git a/mm/internal.h b/mm/internal.h
index b52a526d239d..b61034bd50f5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -601,7 +601,7 @@ extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
  * range.
  * "fully mapped" means all the pages of folio is associated with the page
  * table of range while this function just check whether the folio range is
- * within the range [start, end). Funcation caller nees to do page table
+ * within the range [start, end). Function caller needs to do page table
  * check if it cares about the page table association.
  *
  * Typical usage (like mlock or madvise) is:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be2ad117515e..929b4e0f4669 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -842,7 +842,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	memcg = pn->memcg;
 
 	/*
-	 * The caller from rmap relay on disabled preemption becase they never
+	 * The caller from rmap relies on disabled preemption because they never
 	 * update their counter from in-interrupt context. For these two
 	 * counters we check that the update is never performed from an
 	 * interrupt context while other caller need to have disabled interrupt.
@@ -8104,7 +8104,7 @@ static struct cftype memsw_files[] = {
  *
  * This doesn't check for specific headroom, and it is not atomic
  * either. But with zswap, the size of the allocation is only known
- * once compression has occured, and this optimistic pre-check avoids
+ * once compression has occurred, and this optimistic pre-check avoids
  * spending cycles on compression when there is already no room left
  * or zswap is disabled altogether somewhere in the hierarchy.
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index b59f5e26b6fb..27539ffe2048 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1223,7 +1223,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * Does the application expect PROT_READ to imply PROT_EXEC?
 	 *
 	 * (the exception is when the underlying filesystem is noexec
-	 *  mounted, in which case we dont add PROT_EXEC.)
+	 *  mounted, in which case we don't add PROT_EXEC.)
 	 */
 	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
 		if (!(file && path_noexec(&file->f_path)))
-- 
2.27.0

