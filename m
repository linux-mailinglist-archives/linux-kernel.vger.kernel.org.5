Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4E7E87A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjKKBh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjKKBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:37:54 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8164686
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:37:51 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-280997b23eeso2587411a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699666671; x=1700271471;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht3AJHcFshZgfyUBgkQ6SpFcmhkxhD1wFBZ8f4r5U8Q=;
        b=kXDmy9HdhWbQVEVvcsbGWYl7mEKh+cok91aDj5yePTmby1Jk5qzd7JvUSfgWUeLJkC
         /3Z5u2+oQEfvwdld/0gzJNfDQv/YUz0ek58oKXWUvWxPBN37z9hJky87HVH6xb4X7QaA
         mZSQlpFl5D49ngf6I3IUcUhEljnSNyrFcOVQZ0r/VBdktSKYPRZ9qY/ggEzKtEuUaOkC
         izG3zGCu92uDk4ELg7/83act/L/m2qM+QMOyjNsxj8rZeUx8gUNGz+qbT542tZ63ZHcD
         NgKDLZVYqeIzW00A+IQqHvdpOb9O8byN+ZEHPQIlw9mQQO6aqN+tDyH4aUAc3zarC+8S
         JkIw==
X-Gm-Message-State: AOJu0Ywc6VwOL56HzSJ8zSqg3EqQYBwDY0jo6tPLnJYi6Xul6HFOCczh
        Q3EuOWx5JYkgZxfzy4OWwQTFd1e6G9SJZxHN4qaK2ipVs9O/gJo=
X-Google-Smtp-Source: AGHT+IE94UzeZVEgRTPrFlYzrwd2JEbuDCmY3/uTx852QHtzKYKVOnwdAHB821u12lO3Nu5sP5ZL0PxFcoGk49A2DBy9uRdu8Hq3
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2dcc:b0:280:2f43:1f32 with SMTP id
 sk12-20020a17090b2dcc00b002802f431f32mr196239pjb.2.1699666671364; Fri, 10 Nov
 2023 17:37:51 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:37:51 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ef35d0609d67c95@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test 305230142ae0
Author: eadavis@qq.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 305230142ae0

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..d2b6e4d18c89 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = root->free_objectid++;
+	while (find_qgroup_rb(root->fs_info, root->free_objectid++);
+	*objectid = root->free_objectid;
 	ret = 0;
 out:
 	mutex_unlock(&root->objectid_mutex);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..05b4b8dd0fcb 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -425,4 +425,6 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
+static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+                                            u64 qgroupid);
 #endif
-- 
2.25.1

