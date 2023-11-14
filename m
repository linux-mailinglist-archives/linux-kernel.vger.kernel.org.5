Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F567EABE9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjKNIqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjKNIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:01 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B41A4;
        Tue, 14 Nov 2023 00:45:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bee11456baso4572438b3a.1;
        Tue, 14 Nov 2023 00:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951551; x=1700556351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EviPGa1LuLnC0+KfNNg7CsK+qd6t9X5DweSPa1hqKSw=;
        b=nfaNMqe2ce7ZdK9sMCxgmLjRywnB0lFVHldlnrAe8+qaMg1sIgxRtwjutw+lU1pt+N
         ydrdGY6bTudLyqjXBnMoM2KHisnfSCpFF5uItaWDQHsL7laicwgaFxjK5NXKnx2YQGVa
         VGR6O+BzQ5KXsFJHaAfDKmlESDw8Mm/4S05+S3dUJtacxQnm6cPDcAVzSj23FDTv8eXL
         AH80PqtQpfZsg9mIV9zOB6ff1E0o3qsopkYy2maQDUpDDX6cMS0bvk98NWh3kSaSL/sO
         tH40xfNdCcQPGcx2GieZdXisv+lxbvXOC6++TLS3gj3x0H3IuMf1f9etwUQr9I8kNDNT
         BC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951551; x=1700556351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EviPGa1LuLnC0+KfNNg7CsK+qd6t9X5DweSPa1hqKSw=;
        b=Il3NK1V4YbIYqj9TD85AWVRIvKfzjhrpHumedAyma27vvJlMobyoKSBu0Ni/1DL9mm
         hlyHiw3YuvPAY4PnqiVyp7zMt1T3BIeOyVHXVjxQvmvPMbXIMdKq9O0R7LPuTJFKoD59
         KTj2Dm8PzZAwBnRPt6El+B7YGF/ysbdDLqqNxOAPtKTgOAabwK3VSvslwYUYMIaRtmoV
         iqBf2l8cu/jXIfwDW4Ejp0Piew/4oMA9rWFkiRHogK+jQsr8Q626ifui3DpI7BlAhga/
         xrDMoXuxrd6XKOBaFGxZiM80pTpZZfvpYVr86WHoUq6SYqldcTTQQ2zUJe/5nAwjaCdj
         afXw==
X-Gm-Message-State: AOJu0YwlnxEg4dXd1z3su2t/BuRqzOlyV4b5tiaPL/wAH9BC/wadpgam
        2M7OqjKwVpqaofs9jEVdggzyYSqODkM=
X-Google-Smtp-Source: AGHT+IEfv8RULvG3qEaRcFJz2uh6XDPh43f89p1HvsAAZrxDSdlfFIcC2XZ/2MCbcxK+wCZ3urbAhQ==
X-Received: by 2002:aa7:8184:0:b0:68e:496a:7854 with SMTP id g4-20020aa78184000000b0068e496a7854mr5991985pfi.18.1699951551295;
        Tue, 14 Nov 2023 00:45:51 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:50 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] nilfs2: Convert nilfs_segctor_prepare_write to use folios
Date:   Tue, 14 Nov 2023 17:44:26 +0900
Message-Id: <20231114084436.2755-11-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
References: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new folio APIs, saving 17 hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 8c675c118c66..52995838f2de 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1665,39 +1665,39 @@ static int nilfs_segctor_assign(struct nilfs_sc_info *sci, int mode)
 	return 0;
 }
 
-static void nilfs_begin_page_io(struct page *page)
+static void nilfs_begin_folio_io(struct folio *folio)
 {
-	if (!page || PageWriteback(page))
+	if (!folio || folio_test_writeback(folio))
 		/*
 		 * For split b-tree node pages, this function may be called
 		 * twice.  We ignore the 2nd or later calls by this check.
 		 */
 		return;
 
-	lock_page(page);
-	clear_page_dirty_for_io(page);
-	set_page_writeback(page);
-	unlock_page(page);
+	folio_lock(folio);
+	folio_clear_dirty_for_io(folio);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 }
 
 static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 {
 	struct nilfs_segment_buffer *segbuf;
-	struct page *bd_page = NULL, *fs_page = NULL;
+	struct folio *bd_folio = NULL, *fs_folio = NULL;
 
 	list_for_each_entry(segbuf, &sci->sc_segbufs, sb_list) {
 		struct buffer_head *bh;
 
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
-			if (bh->b_page != bd_page) {
-				if (bd_page) {
-					lock_page(bd_page);
-					clear_page_dirty_for_io(bd_page);
-					set_page_writeback(bd_page);
-					unlock_page(bd_page);
+			if (bh->b_folio != bd_folio) {
+				if (bd_folio) {
+					folio_lock(bd_folio);
+					folio_clear_dirty_for_io(bd_folio);
+					folio_start_writeback(bd_folio);
+					folio_unlock(bd_folio);
 				}
-				bd_page = bh->b_page;
+				bd_folio = bh->b_folio;
 			}
 		}
 
@@ -1705,28 +1705,28 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				    b_assoc_buffers) {
 			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
-				if (bh->b_page != bd_page) {
-					lock_page(bd_page);
-					clear_page_dirty_for_io(bd_page);
-					set_page_writeback(bd_page);
-					unlock_page(bd_page);
-					bd_page = bh->b_page;
+				if (bh->b_folio != bd_folio) {
+					folio_lock(bd_folio);
+					folio_clear_dirty_for_io(bd_folio);
+					folio_start_writeback(bd_folio);
+					folio_unlock(bd_folio);
+					bd_folio = bh->b_folio;
 				}
 				break;
 			}
-			if (bh->b_page != fs_page) {
-				nilfs_begin_page_io(fs_page);
-				fs_page = bh->b_page;
+			if (bh->b_folio != fs_folio) {
+				nilfs_begin_folio_io(fs_folio);
+				fs_folio = bh->b_folio;
 			}
 		}
 	}
-	if (bd_page) {
-		lock_page(bd_page);
-		clear_page_dirty_for_io(bd_page);
-		set_page_writeback(bd_page);
-		unlock_page(bd_page);
+	if (bd_folio) {
+		folio_lock(bd_folio);
+		folio_clear_dirty_for_io(bd_folio);
+		folio_start_writeback(bd_folio);
+		folio_unlock(bd_folio);
 	}
-	nilfs_begin_page_io(fs_page);
+	nilfs_begin_folio_io(fs_folio);
 }
 
 static int nilfs_segctor_write(struct nilfs_sc_info *sci,
-- 
2.34.1

