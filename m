Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD907EABFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKNIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjKNIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2402819B5;
        Tue, 14 Nov 2023 00:46:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso4619454b3a.2;
        Tue, 14 Nov 2023 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951568; x=1700556368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHhSpVpoa8KYOjWaZwduZV1w+B3zSOWFnG1dbpteVKA=;
        b=gxEpY1lJatMoM4W/ncumjdVT3M/5Wl0N37iAzYmFzgshyc7AVQn5h1OnhNq1Htl/U+
         1NTbDy1pu8gRVLELDHkXeXix80sZ3Zhil3Gyf2kO5/K9PG+HnF/4490bsHhrazvq3Q7T
         LKYBwRlHYWoWVdiVGGR4bk4xAyfls+MfZE3dLB7nuVvk6FedxeXMC/wyTtZ6YHKKujwu
         8a59DczDj+RPJcfJzf6q0oZLPH6T7h8RsGTXHOlqQrpmWEpmhXMkMufjg1NkmsGwGiyR
         U9KhkOs3utxfheBSw9zppKwHWcjTuyRiH/3Y2Ue/RRZ3CvL7zsiX3qv8drA4LUIZ5SE3
         J4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951568; x=1700556368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHhSpVpoa8KYOjWaZwduZV1w+B3zSOWFnG1dbpteVKA=;
        b=Y2f5rPux75pDM4gjGiZnfuN6OCJ9NXvhy6DulgQ4bJdt+SEJ5SP9jic5RI+NOcvfkv
         /CoOjmnSOyFCqSSqvJQQCYA5LfCdAtObTvYluINZ6EJ4wse6kQShRX3qq41tqiMvr5hB
         83E8Xdz9oDEHlOqYqgRTzCy2bCMo721z7Ya0I/6eyO+ysI6X2b6I8oiwhimPwKrYOXCZ
         UHjDeHyvRsRo2hskvrhEgAP+XR93uIMeF3Cpg6I+vDKs/2gRsmN2ewBbNTUW7mZJdaAH
         gHNoo9NkhWaKM4yvveI+6eSYpjVuHxoBzReacUbKVXjsNoSXh0gcvhcSpwzpErCHKKKK
         1/KQ==
X-Gm-Message-State: AOJu0Ywy4ATsEbhEh3LTfiD0LFRFf1JaeUYZdsrXcMt+cUyWznf2EB1D
        i63keg/mHla6OwsDJePClYQeadPiV/o=
X-Google-Smtp-Source: AGHT+IGFSaFthI1x5h/jmjZZ8o9XSzcdZ6vQLRr9hW8bf4bAhYCK9NAQQD2uwZx4JDIYMvFKBpU8xw==
X-Received: by 2002:a05:6a00:4e51:b0:6b8:69fa:8ff with SMTP id gu17-20020a056a004e5100b006b869fa08ffmr6053039pfb.17.1699951568593;
        Tue, 14 Nov 2023 00:46:08 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:46:07 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] nilfs2: Convert nilfs_btnode_commit_change_key to use a folio
Date:   Tue, 14 Nov 2023 17:44:35 +0900
Message-Id: <20231114084436.2755-20-konishi.ryusuke@gmail.com>
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

Saves one call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index da3e4366625f..fb1638765d54 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -238,15 +238,15 @@ void nilfs_btnode_commit_change_key(struct address_space *btnc,
 {
 	struct buffer_head *obh = ctxt->bh, *nbh = ctxt->newbh;
 	__u64 oldkey = ctxt->oldkey, newkey = ctxt->newkey;
-	struct page *opage;
+	struct folio *ofolio;
 
 	if (oldkey == newkey)
 		return;
 
 	if (nbh == NULL) {	/* blocksize == pagesize */
-		opage = obh->b_page;
-		if (unlikely(oldkey != opage->index))
-			NILFS_PAGE_BUG(opage,
+		ofolio = obh->b_folio;
+		if (unlikely(oldkey != ofolio->index))
+			NILFS_PAGE_BUG(&ofolio->page,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
@@ -257,8 +257,8 @@ void nilfs_btnode_commit_change_key(struct address_space *btnc,
 		__xa_set_mark(&btnc->i_pages, newkey, PAGECACHE_TAG_DIRTY);
 		xa_unlock_irq(&btnc->i_pages);
 
-		opage->index = obh->b_blocknr = newkey;
-		unlock_page(opage);
+		ofolio->index = obh->b_blocknr = newkey;
+		folio_unlock(ofolio);
 	} else {
 		nilfs_copy_buffer(nbh, obh);
 		mark_buffer_dirty(nbh);
-- 
2.34.1

