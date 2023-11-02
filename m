Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82F7DFA18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377238AbjKBSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377347AbjKBSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDFDB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698950290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4TMeJ+np4weC9A1EJ0nwAbg03A0sROonQrm4coY6tYI=;
        b=VmzPs2uK+KUJg6NLniiQmJgcqFyNM0WgPZnuGJX9ecqYUKqF+lMLoX/kZMCGxrXwjF7zFD
        WG7Q2QXAycUpex8WuSNg5dISpRu+aSqtCZROfqKrY7tG6ScyPXCjlT2XPwrZsKQFvxmF34
        j3fn6atoDYdUwBBaCcZLwYjGPIGpF5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-qLjsdeYKNlODMT0Ln3aBBg-1; Thu, 02 Nov 2023 14:38:09 -0400
X-MC-Unique: qLjsdeYKNlODMT0Ln3aBBg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084f909b4cso2626065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698950287; x=1699555087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TMeJ+np4weC9A1EJ0nwAbg03A0sROonQrm4coY6tYI=;
        b=l1sa1/6Eyv9HZP6R0CU9Sg5SJX64NoaNMYBtefZu/LZzK5yZBbWgrSvTP4g3NUWIqs
         Sw23aq4ASdLNXwfgz3n9AHHct15S9opP+YCjIG9pNE4dgF6LKHp3YEQgkhNi1b7EEDfP
         kyRQ3tza10Wqa8e16HCNo7ydIMnKhuixlpZzNEkaCJu0XwUsCnpLvK7cwWkvli13vxz7
         wfLrMZMOJiw1cDJQ5OYPZtAIHNrqyhKRulSnOdvyzAh6g07OmcY5VZhyzKROACQKnvN6
         q//Qa2e/+hRj/0kcyfJQmf1uHDWTEgBLXN7thL22hsbKCHTGk9dBO0a6syfM144mDXp/
         TFLA==
X-Gm-Message-State: AOJu0Yxq95SupyGlD62JnLJBDVHOGs4PnmwsxpJIQdGvEAzEfZj8iDe9
        anknDzfbqPwtemAvDmpH8RRKji5HOWQoY+shvDQkLZyTHxBvMjeYs0hwGAsKiaUY8zwSp5ctNJt
        2RKIVwH9p5tbZHDyTK3SQz30+
X-Received: by 2002:a05:600c:35d6:b0:3fe:21a6:a18 with SMTP id r22-20020a05600c35d600b003fe21a60a18mr15734354wmq.3.1698950287728;
        Thu, 02 Nov 2023 11:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2LMtKNka+8H7xT/HXHVzvSunLZOLL2dRHM5nf8ghfToyNM+Y4NcP0YwDWUwqyeLZhv+q0aA==
X-Received: by 2002:a05:600c:35d6:b0:3fe:21a6:a18 with SMTP id r22-20020a05600c35d600b003fe21a60a18mr15734346wmq.3.1698950287375;
        Thu, 02 Nov 2023 11:38:07 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c0b4f00b004094e565e71sm306179wmr.23.2023.11.02.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:38:06 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] fs/nilfs2: copy userspace-array safely
Date:   Thu,  2 Nov 2023 19:37:51 +0100
Message-ID: <20231102183751.47413-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioctl.c utilizes memdup_user() to copy a userspace array. This is done
without an overflow-check.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Linus recently merged this new wrapper for Kernel v6.7
---
 fs/nilfs2/ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 40ffade49f38..6a9dceebb18d 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -877,11 +877,11 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 
 	/*
 	 * argv[4] points to segment numbers this ioctl cleans.  We
-	 * use kmalloc() for its buffer because memory used for the
-	 * segment numbers is enough small.
+	 * use kmalloc() for its buffer because the memory used for the
+	 * segment numbers is small enough.
 	 */
-	kbufs[4] = memdup_user((void __user *)(unsigned long)argv[4].v_base,
-			       nsegs * sizeof(__u64));
+	kbufs[4] = memdup_array_user((void __user *)(unsigned long)argv[4].v_base,
+				     nsegs, sizeof(__u64));
 	if (IS_ERR(kbufs[4])) {
 		ret = PTR_ERR(kbufs[4]);
 		goto out;
-- 
2.41.0

