Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F159C7D3711
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjJWMnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJWMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:43:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA63C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:43:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9cb5e0fcso2357343f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698064994; x=1698669794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFdh5G+nv58LZOrSzNGUC39fRLszbh4b6sgwuqs17uQ=;
        b=Jq3+3DKWdu8apJHp+H1//2gmdtsQ/dQ1duaBcMM5PdDAzAMbAT32NXJZedxY7C+LLl
         cg7kG40ONzNNo6vuualrv2I/htvAZedmGlkBJXfG1ssZmFeAZUPgN+4bTftBRkojN1GW
         xht91bYtbYv0USUccSUtua7NMP7dtW72zqHYySy/9/knHgHED+bWpzSScX9ZCHVJAHvx
         eEBi7vNECvMyBlcoiVyy/5FDkjkZ4LbtCkFFGRUY3MfYgOUWsPeF59hdBJbLnuOvQ2vR
         Simo4A6Ceu0k2sr8RTK0kg5JrIsvwQMXtj0NZSFKTJH6e17XIursLJm/opWL7ptOHqeG
         RrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064994; x=1698669794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFdh5G+nv58LZOrSzNGUC39fRLszbh4b6sgwuqs17uQ=;
        b=r2BGe+Pe8zIBwi9r5lMHyZgE9ZfU9jOiq7SeKS+kUjJPs7z++XPGzrEJMDWzFlC55v
         nyeEh+4CXDECGvd6sEqZwNuegczZnaRcaBir3BZPD6oDWOFl0HCzBR/NBKxJh0Z59ve+
         bkavornjKVQjKnyi/zqtpNlzZzm7uW7qLq4usKmJBbqdvrDWctu1q9MTAr7VuzM5MxPu
         vZ211NMSlCjnEs6zPTAbaGNCUKZEgN8H+OQ9B/NfdxNL+FvsE0r1AIJn7zibOT8DLdUf
         cYXqcQkppcBZ0f8Y8gJTJavDRQG8JtVGxHAj72wtWtQ0LH53Bv4JLuoFmnp8L9pKT+47
         3aIQ==
X-Gm-Message-State: AOJu0YyCeN5iF6O1wmg25z3r5rNz1pGEMfIZWEswpcTy9xjL9rGxDKlX
        R5eNy4ZpPIpett9s3Tk2gBx21iM/IAo+QEeZ
X-Google-Smtp-Source: AGHT+IEwsKOgRUhhbfQLT339ns73v1EyjcSeeaaESooiiWcUg6nS9KIIoGR28XZAwZJZUvXTBn1MdA==
X-Received: by 2002:adf:fe48:0:b0:323:15d7:900e with SMTP id m8-20020adffe48000000b0032315d7900emr5583684wrs.53.1698064994353;
        Mon, 23 Oct 2023 05:43:14 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm7766632wrm.23.2023.10.23.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:43:14 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     willy@infradead.org, James.Bottomley@hansenpartnership.com,
        rdunlap@infradead.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH v2] mm: Fixed multiple typos in multiple files
Date:   Mon, 23 Oct 2023 17:43:00 +0500
Message-Id: <20231023124300.36829-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    memcontrol.c: Fixed type 'relies'

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

