Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60037E8C34
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKKStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKKStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:49:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13D387F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 10:49:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e623356e59so259303066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699728550; x=1700333350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBjWuK6uQXGIKHduZ8AN5oNf5XntV1J39aO51HeYD4U=;
        b=AxkmwkLuZ/HqnlzeqB7G1cBO8chjF5hZ6I4ds/lh8hYbji0DWaDUsOw8DitleeUocQ
         TGXjHCsO6gFxilAsWUsXC3lr+01Tj/Y25E0J/TtJyxEYfzZ6jR/sf0x93anp493nHoeH
         NKPGgOPi5yEeT91INTVFpV3D3MeOH4hGy9C6VPBC45NA5ea+vgbPVG7RDMisMNXwO/OP
         qN7nbCd+2to4F2ZWnhGQEO9BMvI3bXQf876cC85w9bpRAkpelme6i5iTMjqD1At0GSm1
         FrCa6JwOc9r9MEU6wzqmFpDPwRkrAIztIB6EhkaS1rVN281kdab9W//01ljIF9qJdnQQ
         GTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699728550; x=1700333350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBjWuK6uQXGIKHduZ8AN5oNf5XntV1J39aO51HeYD4U=;
        b=GqaevuCc06v68hGIFn9ugthch2Bp8FKffd4T0VgyJ4Pkn+09pEPJSkINqNCbwIOLc/
         PnhMWavA90Yyu2wPgQXdeFF+pc7+fi0cI15M9M/KILKl+YPxsHA2oRj1yj0uTxFvuI7Z
         2C7HS1dMy7+4JRbnFSm9wpqImiQL5kICP7wqo7PqZjMQeDUIk9vM0wEScqslbSh6G+iI
         TNj+wfmUgaaqUFH1RWQiix6YUFnTuTtxzpIbrEPUVMe4rTeFD36OoqugH17vMPM8V2jE
         eJhjkUNmuoC/v9Qii0YRYVaCcKh0qEtQ5DW62he2FP7qjq8hkZfcJQRT5g9Vk6rOrRG4
         bDxQ==
X-Gm-Message-State: AOJu0YzGTii3upw6tuzxpNXXmq6ZYC3YuRmg0yfHaQ+woEQn5rzcgKi6
        bdAm4gKf8azgx1ALUfbx/a0=
X-Google-Smtp-Source: AGHT+IHxs4ZZDHKX2Bf2cadQYnfMI5lpoc2bluBz2IkAAhatv8n7pFshrwDkx+JHmldZuV9I1J5zPQ==
X-Received: by 2002:a17:906:cb95:b0:9c7:5186:de1a with SMTP id mf21-20020a170906cb9500b009c75186de1amr1843824ejb.8.1699728550001;
        Sat, 11 Nov 2023 10:49:10 -0800 (PST)
Received: from yjn-Lenovo-V14-G2-ITL.Speedport_W_724V_01011603_07_008 (p200300cddf0851c5b3ad9068140f415f.dip0.t-ipconnect.de. [2003:cd:df08:51c5:b3ad:9068:140f:415f])
        by smtp.gmail.com with ESMTPSA id cw16-20020a170906c79000b00992e94bcfabsm1418219ejb.167.2023.11.11.10.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 10:49:09 -0800 (PST)
From:   York Jasper Niebuhr <yjnworkstation@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: Fix process_vm_rw page counts
Date:   Sat, 11 Nov 2023 19:48:59 +0100
Message-Id: <20231111184859.44264-1-yjnworkstation@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. There is a "-1" missing in the page number calculation in
process_vm_rw_core. While this can't break anything, it can cause
unnecessary allocations in certain cases:

Consider handling an iovec ranging over PVM_MAX_PP_ARRAY_COUNT pages
that is also aligned to a page boundary. While pp_stack could hold
references to such an amount of pinned pages, nr_pages yields
(PVM_MAX_PP_ARRAY + 1) in process_vm_rw_core. Consequently, a larger
buffer is allocated with kmalloc for no reason.

For any page boundary aligned iovec that is a multiple of PAGE_SIZE and
larger than PVM_MAX_PP_ARRAY_COUNT pages, nr_pages will be too big by 1
and thus kmalloc allocates excess space for one more pointer.

2. max_pages_per_loop is constant and there is no reason to have it as a
variable. A macro does the job just fine and saves memory.

3. Replaced "sizeof(struct pages *)" with "sizeof(struct page *)" to
have matching types for allocation and prevent confusion.

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>

---
 mm/process_vm_access.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 0523edab03a6..b308e96cd05a 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -53,7 +53,10 @@ static int process_vm_rw_pages(struct page **pages,
 }
 
 /* Maximum number of pages kmalloc'd to hold struct page's during copy */
-#define PVM_MAX_KMALLOC_PAGES (PAGE_SIZE * 2)
+#define PVM_MAX_KMALLOC_PAGES 2
+
+/* Maximum number of pages that can be stored at a time */
+#define PVM_MAX_USER_PAGES (PVM_MAX_KMALLOC_PAGES * PAGE_SIZE / sizeof(struct page *))
 
 /**
  * process_vm_rw_single_vec - read/write pages from task specified
@@ -79,8 +82,6 @@ static int process_vm_rw_single_vec(unsigned long addr,
 	unsigned long start_offset = addr - pa;
 	unsigned long nr_pages;
 	ssize_t rc = 0;
-	unsigned long max_pages_per_loop = PVM_MAX_KMALLOC_PAGES
-		/ sizeof(struct pages *);
 	unsigned int flags = 0;
 
 	/* Work out address and page range required */
@@ -92,7 +93,7 @@ static int process_vm_rw_single_vec(unsigned long addr,
 		flags |= FOLL_WRITE;
 
 	while (!rc && nr_pages && iov_iter_count(iter)) {
-		int pinned_pages = min(nr_pages, max_pages_per_loop);
+		int pinned_pages = min_t(unsigned long, nr_pages, PVM_MAX_USER_PAGES);
 		int locked = 1;
 		size_t bytes;
 
@@ -171,7 +172,7 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 		iov_len = rvec[i].iov_len;
 		if (iov_len > 0) {
 			nr_pages_iov = ((unsigned long)rvec[i].iov_base
-					+ iov_len)
+					+ iov_len - 1)
 				/ PAGE_SIZE - (unsigned long)rvec[i].iov_base
 				/ PAGE_SIZE + 1;
 			nr_pages = max(nr_pages, nr_pages_iov);
@@ -184,8 +185,8 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 	if (nr_pages > PVM_MAX_PP_ARRAY_COUNT) {
 		/* For reliability don't try to kmalloc more than
 		   2 pages worth */
-		process_pages = kmalloc(min_t(size_t, PVM_MAX_KMALLOC_PAGES,
-					      sizeof(struct pages *)*nr_pages),
+		process_pages = kmalloc(min_t(size_t, PVM_MAX_KMALLOC_PAGES * PAGE_SIZE,
+					      sizeof(struct page *)*nr_pages),
 					GFP_KERNEL);
 
 		if (!process_pages)

base-commit: 8728c14129df7a6e29188a2e737b4774fb200953
-- 
2.34.1

