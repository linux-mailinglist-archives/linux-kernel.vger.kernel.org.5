Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E797EF8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjKQUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:39:04 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD0D4D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:39:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso21415165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700253540; x=1700858340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ETgvrJcyf+GAZnQOzgEhP5ISVDHjC8tSZ7J4fXmHUs=;
        b=NVv7tBMhCQdRWa7yseaAUUpULk3Mri/bgmtAcvrSCZnPsE5pnZzoTtHADTkXI4fiwC
         kqNRGvQS9i4tAhO3WFbS85I1i/9X5RP9p7kN7K5R2Cs+YXSVxe2w7So/ptvBqjEoD90o
         D+p1OrOlArurGxNVEgrDdK7pJUDSpVjOozjGv0FS2NkqFYCMAKVEWSJf/Qjeu5JKVJCC
         RCMnpi+4fYpoBB70+tPFMUsezRXe3CkQ6lG7sTKX/GKkuw8fmeLsRRsBP5bNyIjvfXf6
         haD75XX9K27YbeJ0t0JDIuebQGjhdaowlpVzfFRoQQsmckB1wF4GgGrWS5ZcwVJQUV4P
         qphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253540; x=1700858340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ETgvrJcyf+GAZnQOzgEhP5ISVDHjC8tSZ7J4fXmHUs=;
        b=Zve8koUHJze2lZ+DTRLyCBqjNQXK6cUoH5jEAMuxQDJE50TMG8lPVV1uCCWK02ryjv
         qsPvr8KbMu0wMrzngxXWlgeNlmLlhKW5WTwn00LkuImorBh3VG4V4nobKzAn7NXcSfIy
         NrtDgWbxT1y8mRUAO1g3G78OkECwYpamLJ1PklXs4XB/OvMONmKV7rTxQwvJxbwHV6Wf
         86JzYp9QZUZIpuTtmN3X7dyjAtLrDOTLU0Dd6FQLUjQrUHwq5tJwZD+62TTT/8Ww2+5u
         msIxbAumQdGoG5DoQRZfKetZpcL4ZbM12BQgS/+PNXeOecLML+0zRtQetQDPJPOya5y8
         fW9w==
X-Gm-Message-State: AOJu0YyyjYnIfcjXUOOwXlFYte0/CvJV7+tIL2zypA9qKrhiqeMEvauM
        uNZwNIXg4OXJX5sl6ocd5ShgqLMxsKo=
X-Google-Smtp-Source: AGHT+IFiuEUBAekE+jWCaO/fNCPjfjb6h+uNLtJcA/CX3wX3J72Mgq0MlYYDv3o9VqGqm721rrLDJw==
X-Received: by 2002:a17:903:1247:b0:1cc:510c:a0b9 with SMTP id u7-20020a170903124700b001cc510ca0b9mr860978plh.34.1700253540200;
        Fri, 17 Nov 2023 12:39:00 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:4344:b98f:50f2:673a])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001bdd7579b5dsm1746528plt.240.2023.11.17.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:38:59 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: adjust nat and block release logic
Date:   Fri, 17 Nov 2023 12:38:55 -0800
Message-ID: <20231117203855.3415891-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Fixes: 0f503e443ccb ("f2fs-tools: do not reuse corrupted quota inodes")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 55eddca..2bb759c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3094,10 +3094,13 @@ static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino,
 		release_block_cnt(sbi, dealloc);
 		get_node_info(sbi, nid, &ni);
 		release_block(sbi, ni.blk_addr, dealloc);
+
+		if (dealloc)
+			release_nat_entry(sbi, nid);
 	}
 
 	/* clear data counters */
-	if(!(node->i.i_inline & F2FS_INLINE_DATA)) {
+	if (!(node->i.i_inline & (F2FS_INLINE_DATA | F2FS_INLINE_DENTRY))) {
 		ofs = get_extra_isize(node);
 		for (i = 0; i < ADDRS_PER_INODE(&node->i); i++) {
 			block_t addr = le32_to_cpu(node->i.i_addr[ofs + i]);
-- 
2.43.0.rc0.421.g78406f8d94-goog

