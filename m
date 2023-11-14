Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFEE7EABF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjKNIq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjKNIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:29 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7336AD56;
        Tue, 14 Nov 2023 00:46:03 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-586ba7cdb6bso3058872eaf.2;
        Tue, 14 Nov 2023 00:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951562; x=1700556362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHyiqrpjh6fekzP9HnVZDAdWYJgQZ8Vlg/OwNXBLqa8=;
        b=fXhUrO2zYA4qTOqnQniFqP2O5p9F746F/jGCmtf2IdJYJ5YBQiZTPawyKfCkcGJy86
         lSJgppNl5FwfTKVPwLTM1FIdfo0n5vwtSDqp7xEnaEY/+mjmovkw7BAglZyFEKPEUAcW
         2E4KhPjPNJskhp8PGZeAcKFrvIcJHyFNQEUpen3SooVpL3kU9J9w+aWU0FvcVKpNj7m9
         jfEtKazjGYX49pLbttlVMUbQpQMV54EAfohuX2T46cpkmnJY2W/ayJU+1hnvvyRKgGQO
         CMtcufbxG34gRY0EXv9Nw8D5tAtOghFGJweWtbWlRmKNbz4eqg3bAtLQoKbLZbqKL16N
         EXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951562; x=1700556362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHyiqrpjh6fekzP9HnVZDAdWYJgQZ8Vlg/OwNXBLqa8=;
        b=iUVbnsC4M5gj6Of/6oafddbsfMsyuQ2D/mJzeawxpZ/GRNPwly2fgsOGC+c36+KW8u
         /vnfiBwvcH7T27LgY/2kceqGb652h/8dpAoxdvcYvebq7wpkwYZLdojTNhvv3yQC50b8
         En2D2ZjI1MSoQUNTEbhf+oIyT2KgXc9Mq4wQelOk8jJOlIt9KuCHpJK0ka25UW/UMft7
         JFYduwEDFZ/HWkJeiW7mwDhApmAr83+pn79GqvyWjPCJEODLTJJkydsXOe+YCuxe8yUA
         8npPzCQbLyhgyY6Gt3X9wggztrruqsA1mFbmNJqogBkIYDaPkBGdLRFWTAv9W8H4rwWz
         0f2Q==
X-Gm-Message-State: AOJu0Yxers+XxcaPA2IeT2GTM+iBskHEt5hQSpKCFIOtxDjekttz7gih
        AsOO08TZjmZOW3tcT0EmeJXJjvzz+Hg=
X-Google-Smtp-Source: AGHT+IGz2LlV6lwJ83IC/wPiFp4spN3YnuFCNFlP9ivoxhAV6QRnu6E5QKVLMg+O8P77py0aOvmnMA==
X-Received: by 2002:a05:6870:bd4c:b0:1ea:8b10:247e with SMTP id og12-20020a056870bd4c00b001ea8b10247emr13073968oab.27.1699951562547;
        Tue, 14 Nov 2023 00:46:02 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:46:02 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] nilfs2: Convert nilfs_btnode_submit_block to use a folio
Date:   Tue, 14 Nov 2023 17:44:32 +0900
Message-Id: <20231114084436.2755-17-konishi.ryusuke@gmail.com>
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

Saves two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 691a50410ea9..5ef9eebd8d2e 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -75,7 +75,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 {
 	struct buffer_head *bh;
 	struct inode *inode = btnc->host;
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	bh = nilfs_grab_buffer(inode, btnc, blocknr, BIT(BH_NILFS_Node));
@@ -83,7 +83,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 		return -ENOMEM;
 
 	err = -EEXIST; /* internal code */
-	page = bh->b_page;
+	folio = bh->b_folio;
 
 	if (buffer_uptodate(bh) || buffer_dirty(bh))
 		goto found;
@@ -130,8 +130,8 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 	*pbh = bh;
 
 out_locked:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.34.1

