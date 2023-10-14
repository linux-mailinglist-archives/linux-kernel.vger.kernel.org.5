Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E317C94A0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjJNMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:34:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E1BB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 05:34:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32c9f2ce71aso2414217f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697286841; x=1697891641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDH206rkdDwqeGeZI60K6Y3FC8WDVcH/aLBoYF3ffx4=;
        b=eR5bRFPX+Kvx8etQmUnN7Xx3SOjmgYvo29vTYC33A37qmmmisUJpIxgiZHxWaghm/A
         S3lCzjeTiB1PfCOIi2nKQVrYPry2JyOYYO0+bNWJ2FMedqY5nS40WztYs8j//5B9Sred
         IxxSt0eWRhyVCGx7xaS01g88K1SankRqO1z7/Q+l0xSVAwJ/QO6CJmrPYxz/l2lT8nvL
         CNe8fHgb6ftxqR/8fEV/Dxnnr4Pq3HEg3sKH2Sdrakd8ezsNf/Ok/TCdxuRv+AyeFucp
         E4W7v7qyUO1OkrvYt41kZAAOIKodGKvpW+5eSMlfp8xfSTkSOhOh/i+XuBM3odr9hpjF
         qgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697286841; x=1697891641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDH206rkdDwqeGeZI60K6Y3FC8WDVcH/aLBoYF3ffx4=;
        b=NM7x7LNwTjDmyBG9zhEuaqTetSsXOXJCdVUY7IqHqSe5znQzNkN1U5xo2n3QkoV5CI
         2hPCrdMK2EkNo2f0xf8oY7MgPV+3N6paeE3UnhFlPyi/1PmXIN0JhTuEAJYXPuSU3BFX
         e4fhqhPUTRyzTaRneeSUdVlkIVmTAlc0tFqrM3hJARxYu+gnbG1Ej+kBAa2ubbsdgoIK
         BhkeZjt0c0fOf05GPsvpcBxs2d1J5730z3xu9CeCppcL2Zvq9Oy5I0W0jQUu903shdQ2
         4vvliOGIOY9LxbHI8TDxkulrdQ/Ues5i1NII17EALry9sBiJcabkGZaPPNOjSX8Wagfq
         WebQ==
X-Gm-Message-State: AOJu0YyJgtRG9CO0aNL3YVFGi3hVi+/l4InDGfdGFN7SDCl8/HABSHZg
        Oh9jM27mibes7DCbdvLfl2I=
X-Google-Smtp-Source: AGHT+IFQsyz/65TzcP40OxDwUgUKBK64YgeXBDrEyLNkcDl8s13bVoKIVznklKCSxxiyD9/vykgNow==
X-Received: by 2002:a5d:5889:0:b0:329:6be4:e199 with SMTP id n9-20020a5d5889000000b003296be4e199mr26297663wrf.13.1697286840567;
        Sat, 14 Oct 2023 05:34:00 -0700 (PDT)
Received: from localhost.localdomain ([111.88.101.202])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b0040770ec2c19sm1931465wmq.10.2023.10.14.05.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 05:34:00 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] mm: Fixed multiple typos in multiple files
Date:   Sat, 14 Oct 2023 17:33:49 +0500
Message-Id: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
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

debug_vm_pgtable.c: Fixed typo
internal.h: Fixed typo
memcontrol.c: Fixed typo
mmap.c: Fixed typo

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
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
index be2ad117515e..7987a092e530 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -842,7 +842,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	memcg = pn->memcg;
 
 	/*
-	 * The caller from rmap relay on disabled preemption becase they never
+	 * The caller from rmap relay on disabled preemption because they never
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

