Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807F76B940
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjHAP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjHAP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:59:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A0B1734
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:59:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686e29b058cso4231886b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690905545; x=1691510345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8o0I7bFXQoXFBsz+yibAQciwoQ0SJuiPD2PCWU7Otw=;
        b=Uub44S7G5XTNBy2dGdavccZncFCbbvHkhOkp4BaauD/bbItRPLE7kciaVVN0dK3r2S
         /LL5WFJ21zlsVCeBC5aAIMLpy6KQoUSgd11wqkYQloJwtGuNelKHQjwbAkCVNXu2v5cd
         /c94tYTpFGQ3yqEL90uMQlweLNtRqd6uGltFaRuBouUO4Zyr//2C86CzodU1Lk72PlgZ
         ZjTXOQC6K0+/hOnaKa5H2pYF9JUBB/cubcywFEaqKA8nlAZwUPqPHhVg6QY6KgBQMnjo
         Z8IKnBAeo+LngrtM8JO8/MydM4epst3k/8+OYBit4zBMmN18YCYm83hszSRIrsU5wq75
         ci/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905545; x=1691510345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8o0I7bFXQoXFBsz+yibAQciwoQ0SJuiPD2PCWU7Otw=;
        b=U99HlY3QhBY98912TKqB5yhXunXchldt/zfifAANTsi6RyZ1b8l5cB3k9eVuCTTGeK
         wwiAQKr6UnRwDT3qbEBRGTpP/3BBuhEbRh1TK1bKpOPH1h0rlKmbbuvAARgO90ksvS92
         AeDUYq05bCcm9CJkSbmvfsg66hGxXpC4+Ij0+BXoogQK3Ih/wfHf3UI4AaWWD48yJStW
         533qwcAp46the0D0j9iA7KarzHqtiVngAtmIUBqzxLsAtNuEe1XGVcWV/9KF4lTMK/RJ
         gljoQfRCoS7nzg3UwnCgzaZ08qjvWjS56F2lYsT08YePHwI9VHzHRXy8UvSbZ3uWXXQx
         FOVg==
X-Gm-Message-State: ABy/qLbyIxD7wEXwUjBdo4KwgcDCoz/MCvLjBXUWt1HxJxEkZpML5pNk
        iI3I0qDfXQIaTF9K8IemnVc8m3sAJCYDmzE5
X-Google-Smtp-Source: APBJJlEtXowFwkc4FOkij4g4rGFxTUIlYcIn941XhpISwMvMx+UpJ6LXLW9pVb9qsntfJieSX+qvlg==
X-Received: by 2002:a05:6a21:6da1:b0:13d:697a:c31c with SMTP id wl33-20020a056a216da100b0013d697ac31cmr9136804pzb.27.1690905545276;
        Tue, 01 Aug 2023 08:59:05 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a00271900b00653fe2d527esm9520998pfv.32.2023.08.01.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:59:04 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     salah.triki@gmail.com, luisbg@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com
Subject: [PATCH RESEND] fs/befs: fix shift-out-of-bounds in befs_check_sb
Date:   Tue,  1 Aug 2023 21:28:23 +0530
Message-Id: <20230801155823.206985-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The consistency check for the block_size by using the block_shift caused
integer overflow. Thus a max limit to the block_shift was defined named
BEFS_MAX_BLOCK_SHIFT in befs.h. Also check for the block_shift was added
so that overflow does not occur.

Reported-by: syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/befs/befs.h  |  2 +-
 fs/befs/super.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/befs/befs.h b/fs/befs/befs.h
index 7cd47245694d..5490024adb33 100644
--- a/fs/befs/befs.h
+++ b/fs/befs/befs.h
@@ -13,7 +13,7 @@
 
 /* used in debug.c */
 #define BEFS_VERSION "0.9.3"
-
+#define BEFS_MAX_BLOCK_SHIFT 31
 
 typedef u64 befs_blocknr_t;
 /*
diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..f2aeb2ed6e77 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -88,6 +88,17 @@ befs_check_sb(struct super_block *sb)
 		return BEFS_ERR;
 	}
 
+	/*
+	 * block_shift check added so that overflow does not
+	 * occur during the block_size check
+	 */
+
+	if (befs_sb->block_shift > BEFS_MAX_BLOCK_SHIFT) {
+		befs_error(sb, "block_size too large. "
+			   "Corruption likely.");
+		return BEFS_ERR;
+	}
+
 	/*
 	 * block_shift and block_size encode the same information
 	 * in different ways as a consistency check.
-- 
2.37.2

