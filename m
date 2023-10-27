Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64487D9CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjJ0Paw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjJ0Pat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:30:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B99AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:30:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso2122743b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698420647; x=1699025447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Evqr8X6UfMuvTJbckZTyJVytbmNduRUqY597JEFkmzE=;
        b=fjNkqMH2jnQmJPfTWwCO4o+v5rgGOiJ0mMFZbs9hN1fr7ZJQF9M/5cF2WNRKkoIYeQ
         itCmpAJTvoTJv/VHjglDEgGPjMcS9yilzvozzCg1u5QxgZ+/hvHshoxHNQU7oNkP/xro
         A7l7GZp1YqJTzXrn1ZIqtg3Tf2fIITtB3qEQ/Byups/ul+6HPRy/WIFgLzvgmPwl/kdO
         eM7//lO24A6RlpVN7Q/1vwe11ahaYVkfzR8ehWdQf5OUuc5GTN5dPE1jbr6tMEjBQOvf
         2B8/W4d/37pWqe5aaV4gzO3O2/qPbK/EBE+Xe8nSS6p6/GMUS5l7iPqtvDdztMJKUX72
         WEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420647; x=1699025447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Evqr8X6UfMuvTJbckZTyJVytbmNduRUqY597JEFkmzE=;
        b=BvB1g3XQB3NT+esclHhC0rWmUqSRBJV9YjhCfUa8SPV7V8MaX3L/PTMPxj5AOhqYmy
         8eEMx+CfihSEv5cM/zdLHJAj5nTGbNjyGDREAP7IANMvi3xQL+pDsPrHDN3J+5UyA2sB
         bMOSGF0F1L214xc3ftvqOe7Eco01qm3+kCrJ/5i9uVLKoJbUT2qnwOwMsmzrmlc8NPBH
         zRaCOiL4EQ+Dqw5K4We9Tka3IwWvLrie6k8Fe+OtI3IW4x9LNawPn/mo/yX+f4nukKNl
         6kvNViKed1rZNJ+HexzVtNJgEBuUMGilAWIfK0xD3BM6wHvSwRjzZZnyEwNz6yMgFp6D
         Py2g==
X-Gm-Message-State: AOJu0Yw97MNIZLlsvOYXqgHHkwdKUsTe+CCSv8Lo6B3VAGSY/POJr+zF
        y6sVpbX+zzPsrdRkq/EOjyhRCTmao7A=
X-Google-Smtp-Source: AGHT+IF0MMBAZtbKnTDtmgBEnAgN51HU36zoqrUZaap1glWuBrZ5gLRtDPcyNJyJWmYF4uKRZZqpZw==
X-Received: by 2002:a05:6a00:1302:b0:690:422f:4f17 with SMTP id j2-20020a056a00130200b00690422f4f17mr3285641pfu.4.1698420646936;
        Fri, 27 Oct 2023 08:30:46 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:d9fe:c408:7e52:ad85])
        by smtp.gmail.com with ESMTPSA id d3-20020a056a00244300b006bde8e1f0adsm1551946pfj.98.2023.10.27.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:30:46 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: use total_node_count when creating a new node block in fsck
Date:   Fri, 27 Oct 2023 08:30:43 -0700
Message-ID: <20231027153043.1381438-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We might allocate more node blocks than total_valid_node_count, when we
recreate quota files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/segment.c b/fsck/segment.c
index 4b05fd4..4ea0a6f 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -36,8 +36,8 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 				ERR_MSG("Not enough space\n");
 				return -ENOSPC;
 			}
-			if (is_node && fsck->chk.valid_node_cnt >
-					sbi->total_valid_node_count) {
+			if (is_node && fsck->chk.valid_node_cnt >=
+						sbi->total_node_count) {
 				ERR_MSG("Not enough space for node block\n");
 				return -ENOSPC;
 			}
-- 
2.42.0.820.g83a721a137-goog

