Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B97D8EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjJ0GrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:47:12 -0400
X-Greylist: delayed 193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 23:47:07 PDT
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE08E116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:46:57 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8653b5c256a6-4ffb2;
        Fri, 27 Oct 2023 14:43:50 +0800 (CST)
X-RM-TRANSID: 2ee8653b5c256a6-4ffb2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.98])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5653b5c24402-686c7;
        Fri, 27 Oct 2023 14:43:49 +0800 (CST)
X-RM-TRANSID: 2ee5653b5c24402-686c7
From:   zhaimingbing <zhaimingbing@cmss.chinamobile.com>
To:     willy@infradead.org, James.Bottomley@hansenpartnership.com,
        rdunlap@infradead.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] mm: fix multiple typos in multiple files
Date:   Fri, 27 Oct 2023 14:43:45 +0800
Message-Id: <20231027064345.2434-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	nommu.c: Fix typo 'privatize'
	io-mapping.c: Fix typo 'pre-validation'

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 mm/io-mapping.c | 2 +-
 mm/nommu.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/io-mapping.c b/mm/io-mapping.c
index 01b362799..486598ba4 100644
--- a/mm/io-mapping.c
+++ b/mm/io-mapping.c
@@ -21,7 +21,7 @@ int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((vma->vm_flags & expected_flags) != expected_flags))
 		return -EINVAL;
 
-	/* We rely on prevalidation of the io-mapping to skip track_pfn(). */
+	/* We rely on pre-validation of the io-mapping to skip track_pfn(). */
 	return remap_pfn_range_notrack(vma, addr, pfn, size,
 		__pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
 			 (pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK)));
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0..40842b080 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -776,7 +776,7 @@ static int validate_mmap_request(struct file *file,
 			if (!(capabilities & NOMMU_MAP_DIRECT))
 				return -ENODEV;
 
-			/* we mustn't privatise shared mappings */
+			/* we mustn't privatize shared mappings */
 			capabilities &= ~NOMMU_MAP_COPY;
 		} else {
 			/* we're going to read the file into private memory we
-- 
2.33.0



