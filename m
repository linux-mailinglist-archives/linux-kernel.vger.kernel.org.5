Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF407AE679
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjIZHNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:13:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F3DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:13:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d9cda925so6124181b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695712402; x=1696317202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87h+GCoyZ7JZR2wvMjstdo1iWnzZgP8yLm+iAVVZmYo=;
        b=cWzCCnmo+ApEgtgfHTs49L2+MDjJ5gnSSf/HuQyv4iDQ6RuLEfeXsCAPvRQai5EgKT
         Tu1cI3tc8Fsuo1DJfz/kChS2Oa14UJr5RvCui4V5DIy66AnLwTZ12oqpfO2ddrq9dld0
         F2akXfmBznBSuGQv6Wu3djmFdhuGhdwQfhuNXTVnymeyR1J4/lJJfDw0OCX1BuSP49AX
         wzbrdckrubbX7nyZqN2xai3QRZLfFgxLQDt4kZnbZBKmLgUCcxyl77j99iUCOC19E7P/
         kBxcDtTBGZ/vrRnO/O6s2JuBXC/wYzxAiJTbnr+j5+DWxgTNsSRKWoHAnZQLukm7uSMH
         yZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695712402; x=1696317202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87h+GCoyZ7JZR2wvMjstdo1iWnzZgP8yLm+iAVVZmYo=;
        b=TrzzE4zEaqFpryw180HjBFUz5tWz0Vdc9ws2kyfIAD4tM3V2uXVFj1OXQhyGapj6ep
         atAE4PacpL6vk+b/Ul63HX5dgwmu3+15kcb/JrUUs1FPwMcKRIjMij9cXBNGb7JcyLM0
         WRELSy56CTvOzRVIZOH9rMNw2YNSTfvoGI6XVT9RbsHm7ed8KZZFCHFvB/S64Ym6EoLX
         lJOT1+6JOxwsg5iFLkMAeou1zX31h++DJjTTCNb4x+ZCCwJKpgKwlFz5VgtMEuguYCFf
         QPUUDEo/RdP0BoPjr+8bpYCU+kQ964zswonTrZy7hUkMpMTVjdtAzQebK06KojOv6wGk
         fYkA==
X-Gm-Message-State: AOJu0YyDJMoVE/5732x5VlR9nt9op1RYV1Qjt9yV78vqGpiM+1kHqOtT
        hTYXu+mnC5c2i5t09FG94ao=
X-Google-Smtp-Source: AGHT+IFhvxFIiuQd2QO1RrEAsFmMm/JK3ySEofVvDMnYzpK0MvEckVCTgtX6J87sbWMTaneW/v/2sg==
X-Received: by 2002:a05:6a00:24cf:b0:68f:e810:e86f with SMTP id d15-20020a056a0024cf00b0068fe810e86fmr7799333pfv.28.1695712402114;
        Tue, 26 Sep 2023 00:13:22 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id t12-20020aa7938c000000b00686236718d8sm9177662pfe.41.2023.09.26.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 00:13:21 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] jfs: fix array-index-out-of-bounds in diAlloc
Date:   Tue, 26 Sep 2023 12:43:12 +0530
Message-Id: <20230926071312.14086-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is not check against the agno of the iag while
allocating new inodes to avoid fragmentation problem. Added the check
which is required.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/jfs/jfs_imap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 799d3837e7c2..ace8a1506380 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1355,6 +1355,8 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	if (agno < 0)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
-- 
2.37.2

