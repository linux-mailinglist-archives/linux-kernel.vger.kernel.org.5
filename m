Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3B768380
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjG3CoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 22:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3CoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 22:44:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E278171B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 19:44:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so10692865e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 19:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690685059; x=1691289859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqHefzyFteg+XSDK8TjKUuurTQ3TCfNZauRn+ePIKMo=;
        b=gXoCipM3JNjuSxLXeoHktA0KnI//yFn4IVN8FhRDX5diqBLvf7kmjZJkx8/zvLpoMd
         YMkI32C7Kgd4pzLaEaM/wXQ4/aj+YnAIB9CNCxXh1hIdnmDZxfV1ZJb6EIDc2Nqb2IKg
         r+1undnpElhnplFjgtHTKzZdI0Drq+J5FO+7aD7oOAP4WVVBXRD0y8MlR9NqNcrzIvox
         hnGuMj1pzzqqarPUxOO1DSVBWqfknv5BkM7Pi48VbhWf7cCjT9WAVQOLiKf9mV4+lkBm
         AWYaRYoREkFEUo0bhZbrlv0v1H10GIRp8dynCQbpcnGh9TYj5TQrBEfktvZOGLeM7l+b
         iEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690685059; x=1691289859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqHefzyFteg+XSDK8TjKUuurTQ3TCfNZauRn+ePIKMo=;
        b=XKeA1dm/hpGAukerB1RSnpzWFvTPunW1Dkn9j4pLK5nZgMisjb0bSAbL+hBlKdWkz8
         bgyO8BOvjeyuiasHo4rNiF3N47vQbPBUrT0MA7XIwGAelGA7Nj/NKVpm/FHLmrzyBlSp
         qmK2N4Y23/uN6y17zDtTkilHb0tXaOGwhVUJPy/jdfNLdLfuHSrqGvF2zPZ8Tr6Udknp
         EIAIQB22Tuu4pW54jTlwjd5ttUK5rJZqO1soXuS7vIICiVUqDt4eXmDso4qDETTEb10k
         Vyk+RmnZe7fTwxiXIXChlGljWVKOsoB7QdfQWbHMWMOGgcF+cYIS9HK1ZR1cRqe8Ee9d
         mhiA==
X-Gm-Message-State: ABy/qLamokTyoyT8SW/zpRuKU0uCK9Zf/RWIznXvy5yPDK2uUA1mrF8D
        df+XXGWtDBeUR+AXdAIGtFM0mqaATvm/aQ==
X-Google-Smtp-Source: APBJJlEE8MLjjKflCvHpsP/H7m9aoURgnzXKKE84/Y3Hi32rKhJDx0/7XiMEuIRyHbxImEembeW4iA==
X-Received: by 2002:a7b:ca47:0:b0:3fc:2d2:caa8 with SMTP id m7-20020a7bca47000000b003fc02d2caa8mr5066443wml.29.1690685058197;
        Sat, 29 Jul 2023 19:44:18 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b00317046f21f9sm8749546wrx.114.2023.07.29.19.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 19:44:17 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com
Subject: [PATCH v2] ext4: Fix rec_len verify error
Date:   Sun, 30 Jul 2023 10:44:09 +0800
Message-Id: <20230730024409.1738559-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
a problem occurred when more than 13 million files were directly created
under a directory:

EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum

When enough files are created, the fake_dirent->reclen will be 0xffff.
it doesn't equal to the blocksize 65536, i.e. 0x10000.

But it is not the same condition when blocksize equals to 4k.
when enough file are created, the fake_dirent->reclen will be 0x1000.
it equals to the blocksize 4k, i.e. 0x1000.

The problem seems to be related to the limitation of the 16-bit field
when the blocksize is set to 64k. To address this, Modify the check so
as to handle it properly.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
v1->v2:
  Use a better way to check the condition, as suggested by Andreas.

 fs/ext4/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..fffed95f8531 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -445,8 +445,9 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == blocksize)
 		count_offset = 8;
 	else if (le16_to_cpu(dirent->rec_len) == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-- 
2.27.0

