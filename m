Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158097723AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjHGMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjHGMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:18:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F32127
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:18:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2680a031283so2451812a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691410722; x=1692015522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDr2gyLexJ7RwQ2pb56tdD4TsGEQkiPtjXB7Nphmo3c=;
        b=HPbBKMQGbEN0sjjuejM5poJbsvoy01sTUqXR9Czy1lJkcI9FdTOAF1roYZjU8L8bWx
         nuZzjWOsGgwpBvFCkgxRyuNaLXvJDOe546/bU4+Am87WurQ3FqS0M/FGkJ9uXQG3B43T
         I8NKCR1xR0jWV6VII4z1P8io34Lg43GddtIHGlkocIx5udmHjyKbdtlDg7hFjC/eInWC
         BfYMDWxm9+ttVv8LAwe4MmUtwKZMpFpy1KTHOT8OOnp7UN4G2U0/k/z2puzwjt/nr/qS
         GQe4dGiEPN4EcPWEKSi00VaMA7mNJkrwCeUSWTXIC0kQR0ccleWSEf4M7j1ILSRZ1tGO
         vW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410722; x=1692015522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDr2gyLexJ7RwQ2pb56tdD4TsGEQkiPtjXB7Nphmo3c=;
        b=iftWxWG1UymWgZu69+NAi7xQz/hWQEC7wurz8bRqPrL6C5EPe417FqnO3u2iYCyGC6
         UTAdxPiImZ6/rJsri2A0fya1lsToL80srYN/C5gI5i0NMSaRc7mwnzrX/BLKt3TCwO3k
         n0Ystn8Gdljb/LAw6ANvzKA0KZoKKszF87b+CPHM3fV7V4BjSaGRW8+zTXGiSDPC9StM
         q+96OLeygNpfhSnA5NnmPd4yz/N7EkME81x4f81RlLCk4v0vhs65P4eAK/CAEGskLFgN
         SCr6CgRDgmfMS3MgTDyoEI79R5P7Roq/kcqVbgvtpL3h9bv27JdCcxKaKfasRVBJiECb
         Mwcw==
X-Gm-Message-State: AOJu0YwBfa8EsEIecgZZnRCdbOwiJH2NZIE6rMRbZ2anlvLR1958i6og
        KrKnOp+xOfqx9/YWQy6ro14=
X-Google-Smtp-Source: AGHT+IEE+iXc72yHVCPHrWgWCKsvBmuqdwtO2FailrTLgk6SocY5C4KjjV3MuPbcf9YUCw5KP9DAFw==
X-Received: by 2002:a17:90a:16d6:b0:268:7ce2:ad20 with SMTP id y22-20020a17090a16d600b002687ce2ad20mr7732071pje.21.1691410721874;
        Mon, 07 Aug 2023 05:18:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:dd73:b66e:8c4d:2c58])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090a010200b002636dfcc6f5sm6389667pjb.3.2023.08.07.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:18:41 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel: locking: Updates return value check
Date:   Mon,  7 Aug 2023 17:48:34 +0530
Message-Id: <20230807121834.7438-1-atulpant.linux@gmail.com>
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

Updating the check of return value from debugfs_create_file
and debugfs_create_dir to use IS_ERR.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
---

changes since v1:
    Adding linux-kernel@vger.kernel.org mailing list and retaining
    Acked-by tag from Waiman Long

 kernel/locking/lock_events.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index fa2c2f951c6b..e68d82099558 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -146,7 +146,7 @@ static int __init init_lockevent_counts(void)
 	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
 	int i;
 
-	if (!d_counts)
+	if (IS_ERR(d_counts))
 		goto out;
 
 	/*
@@ -159,14 +159,14 @@ static int __init init_lockevent_counts(void)
 	for (i = 0; i < lockevent_num; i++) {
 		if (skip_lockevent(lockevent_names[i]))
 			continue;
-		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
-					 (void *)(long)i, &fops_lockevent))
+		if (IS_ERR(debugfs_create_file(lockevent_names[i], 0400, d_counts,
+					 (void *)(long)i, &fops_lockevent)))
 			goto fail_undo;
 	}
 
-	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
+	if (IS_ERR(debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
 				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
-				 &fops_lockevent))
+				 &fops_lockevent)))
 		goto fail_undo;
 
 	return 0;
-- 
2.25.1

