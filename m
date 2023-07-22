Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5798575DCE7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGVOYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:24:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6812709
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:24:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso4510140e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690035844; x=1690640644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEMPNWlfZvC+ZaudeklsqNdBgq4KJbNHXO/19SnqXeY=;
        b=CX/YDMFJYKOCdP4a3Jzb9GeKS39qNoJnsb4Yyu9v6qEQLAaJVlyX1SWqDSTcUpt2ZK
         BZiZ+JKrNwJMX6vMEtpH8VemfrDrdfqabCOy44aT/eYluzqB6j1XE1BlCtP9sb+C+lg5
         jz8rmNydDqQwl6KIMCmZ6Y5ybbi+hhbq9GSygv3C4631CpO11YKRdVHrP9bJ9AN9hDrn
         rWJq32dZzLxFmfOLBTv2GDs2iwS5s2QB6D05rnSowXcgvca2gpAqGPyK2+TSnAeZucpl
         Y1mQVCR0WJiaomYBurfmWNz1WKzEpijS0NC1ICVMY/qfgp02mGbU8oDqh8+gln3VgBb8
         0eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690035844; x=1690640644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEMPNWlfZvC+ZaudeklsqNdBgq4KJbNHXO/19SnqXeY=;
        b=AWydWjEGPIHxbFzfQZaJsn1KlmxNYsSCsr+pZCJbumPFXLuUqsopnHkulS+dJkYbc/
         19ZFm0tSrRvlL2amPpz8859wCE0QbE1MGOxu6jAN2Dc9MHYtof2F35M+nDlkR4mrXQKw
         6GYs1G1N6CTjxUTKJFViKEg7zD2PjzysBm27Vj7an2hKkgOoQ/zVseKkpAAGHJ9344EQ
         izsRe2Xs9xEeBj1By30Nxw7PO5ThvHZ+ZEPATHZd1APa3hr5HBdc4AqkBW/5QICaU4d0
         k2jkFXyzK50CTYaNRVVyG9+6M35f20CHeojQ4vaaMQYjJ0lkWzR5+XDSVOPV9OBI4We6
         5AoQ==
X-Gm-Message-State: ABy/qLZjIDHRjJbeaoW2qoz5eN/llidxDTtM/FUt+gXJ1S1hFMZ1Xd4I
        EP1FiD/bhLPzCgUGZOlM2EhHFEgts3ENfi+GON0=
X-Google-Smtp-Source: APBJJlE6gDQMTodJm2ZziRpUo9Zx+TWL5mbtIxZ430omJ/panegE+Km6XqOQdW5hkmyT8FwWCoNnNQ==
X-Received: by 2002:a19:770a:0:b0:4f5:a181:97b8 with SMTP id s10-20020a19770a000000b004f5a18197b8mr2658409lfc.25.1690035843438;
        Sat, 22 Jul 2023 07:24:03 -0700 (PDT)
Received: from halip-Pc.42.fr ([93.188.41.70])
        by smtp.gmail.com with ESMTPSA id v10-20020a056512048a00b004fb86c89fa1sm1213642lfq.135.2023.07.22.07.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 07:24:03 -0700 (PDT)
From:   Aleksei Filippov <halip0503@gmail.com>
To:     shaggy@kernel.org, gregkh@linuxfoundation.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexei Filippov <halip0503@gmail.com>,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: [PATCH] jfs: validate max amount of blocks before allocation.
Date:   Sat, 22 Jul 2023 17:24:01 +0300
Message-Id: <20230722142401.71257-1-halip0503@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Filippov <halip0503@gmail.com>

The lack of checking bmp->db_max_freebud in extBalloc() can lead to
shift out of bounds, so this patch prevents undefined behavior,
because bmp->db_max_freebud == -1 only if there
is no free space.

Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
---
 fs/jfs/jfs_extent.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index ae99a7e232ee..a82751e6c47f 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -311,6 +311,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 	 * blocks in the map. in that case, we'll start off with the
 	 * maximum free.
 	 */
+
+	/* give up if no space left */
+	if (bmp->db_maxfreebud == -1)
+		return -ENOSPC;
+
 	max = (s64) 1 << bmp->db_maxfreebud;
 	if (*nblocks >= max && *nblocks > nbperpage)
 		nb = nblks = (max > nbperpage) ? max : nbperpage;
-- 
2.25.1

