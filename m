Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E521752B20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjGMTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjGMTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:41:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6B0269D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:41:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso2020155e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689277310; x=1691869310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrpif+TWcUEv65hsE9Ro9qWNgOPp3o8fXtbJS5f3czc=;
        b=mvANe6FUTFFsZW4UGXUmDE5e/+U3bTLPc89o7LHrg/t8xq93mTvJRAWKXcqde1/Afs
         txJeEUorkXBqspyHS67REz4bzKahCZAO9gTwSeLIxBmPpIiYIByspj1QKx4h2qiS4LBd
         eQc6RWHCHOMhd1e1All9kZd43l9Qp2yznObCYrPBmw1ROsCdMDttHn0N7tkmrZhfL+yA
         /1qX2D4hYfLWjP8LVPRvFrorGqknmu1SuZl/e8ztl4i+SdvMjO4OcApKFV4MSr1z5hgT
         EjjL+ijNuI4OQvcqN4gCaMOH5AZTGCDVs9ZTdnoQvJgB8cencJKL1UkCNqj8jI31ZBb7
         ZRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689277310; x=1691869310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vrpif+TWcUEv65hsE9Ro9qWNgOPp3o8fXtbJS5f3czc=;
        b=AEnWyCibxNebuieg3wCrMWmg1izpmoJ1nqphUGuU6vZdyoX8xz8+SFF7TVpjZACLNr
         QVlk5q4ES6ZD6QWs6jN3eqga9Jf+iQRwFV3SQrGQ4bV1/qZlHCROTgvFWdlZS9WOLoOa
         1/+8pdNLPMFmHtof2H3dHFSHSiUGP7Dx/flTG05YTS8EswMIpyGjYXxjMz+RuK+BmJXl
         ACrD3jlHTQ1kjHZ9RnDtDvA093c3oPMM8xv6Ow2ssrcvqER4QaXSdf1jYixR92wVpNBl
         VMvnb5hfWo4SCYleGw9zEJwER6toDE/Qagchzik6CLA1z5LafT2NC2Wd4jlbunvV2FRX
         ckSw==
X-Gm-Message-State: ABy/qLZJVbw6p4mJEX/+W5ca0a/RJeRMdfgJmCJYFunEtWZxiYHIqLYm
        kVREFj21Q6p5ru+Ks8pUCog=
X-Google-Smtp-Source: APBJJlFl6v/ohCAnvgIKUIS+NR9JCG7//DZMAWP2vTcunaM/0M22+S8+kTL8+J/Sol9e3EKe3Yn/KQ==
X-Received: by 2002:a19:8c04:0:b0:4fb:7592:7e03 with SMTP id o4-20020a198c04000000b004fb75927e03mr2191338lfd.20.1689277309388;
        Thu, 13 Jul 2023 12:41:49 -0700 (PDT)
Received: from fedora.. ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id q14-20020ac2514e000000b004fb79feb288sm1223258lfd.152.2023.07.13.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:41:48 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com
Subject: [PATCH] ntfs3: fix OOB read in ntfs_init_from_boot
Date:   Thu, 13 Jul 2023 22:41:46 +0300
Message-Id: <20230713194146.93568-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Syzbot was able to create a device which has the last sector of size
512.

After failing to boot from initial sector, reading from boot info from
offset 511 causes OOB read.

To prevent such reports add sanity check to validate if size of buffer_head
if big enough to hold ntfs3 bootinfo

Fixes: 6a4cd3ea7d77 ("fs/ntfs3: Alternative boot if primary boot is corrupted")
Reported-by: syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/ntfs3/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1a02072b6b0e..e04e89b7335e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -855,6 +855,11 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 check_boot:
 	err = -EINVAL;
+
+	/* Corrupted image; do not read OOB */
+	if (bh->b_size - sizeof(*boot) < boot_off)
+		goto out;
+
 	boot = (struct NTFS_BOOT *)Add2Ptr(bh->b_data, boot_off);
 
 	if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1)) {
-- 
2.40.1

