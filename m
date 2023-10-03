Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB557B7309
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJCVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjJCVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:08:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167DDAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:08:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso10566085ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696367279; x=1696972079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eP5y3XrI52G/EWwodsmSHUCB5YkZESEmXXN8PSy41u4=;
        b=idmHIXyxZOGlji01Q5Pk2DW954gjXOUkToqenRAzXHccfobPDg57FaRaMGZbt5ui81
         zQwssW9Ky87NSFMVhBZUNmWMUOJO0iQb1aEeUFTeNt29XQflYu8kXPrsUh+9QBJv9002
         8p9raJZSaNjPFB0hpOwIpTn7dFTjIIJPmK/VqzSvX1jQVD36/Fn49yuO3VdKPL59lP19
         9dFvOlUG3f3hTma2d4us0VmHlsTTvH2pPMf0NZ+PZHOz2zrOmbsii9ytHCXy4Lx0bZvR
         7VoYgi3sMCWI9M44CPR/SWK9pnEy/Y9c1Ot1z1AJvgzLxEhYtwwGnSLreaGIJ9JbLlGF
         C40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367279; x=1696972079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eP5y3XrI52G/EWwodsmSHUCB5YkZESEmXXN8PSy41u4=;
        b=qTRGH3Tl8vfZGox1wH1JHI6DVneKtzsMdUhGUzX0TMkgr6GH6V3YWxCzdCxcJr0oP6
         tU926R4FJYi7iTHRSN4/D9IH3chGfm4w28hWtA14B9P2ylD67/sFxoZdiKjT0OHmwowJ
         nNGZphzmLDNVvtLPyx04tD5VNjx1NwnGU92Y2BlLxCq1+HA1xvW8VC4QgaNY95etzmYP
         rwBrO69cZx2ez7GIx3yyU9CTid9h5sx6fbhkrH1WIGnZECJ331b8VFcZuJECqsOTtPlZ
         Box7/iOq5vfDRUMX2k7Zr+D9qfjXPHzS9MBNmRtcJ1P4WGzWONafhQsuw7icEiwZgt2m
         W9Lg==
X-Gm-Message-State: AOJu0YzQRw5JztorMVRkIMOZSE06Srm4AYlVLN2zGiE+xJL6kKdsBNav
        w6Rj7RrdFyvfrYtue7ykqlIi2up/KCY=
X-Google-Smtp-Source: AGHT+IGLbAqS6OCs+muiuq3M+y8rKqOE/s0qEoEGOJldOdpZE22VGPL1c3dW6J2MFAI/bB/fb8Z7xA==
X-Received: by 2002:a17:90a:348d:b0:273:e8c0:f9b with SMTP id p13-20020a17090a348d00b00273e8c00f9bmr464500pjb.15.1696367279212;
        Tue, 03 Oct 2023 14:07:59 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:1d9:902f:6531:9779])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a19d200b00278ff752eacsm21887pjj.50.2023.10.03.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:07:58 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: make checked node progress correct
Date:   Tue,  3 Oct 2023 14:07:54 -0700
Message-ID: <20231003210754.275175-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

Let's say we have 100 nodes to be checked. With post-increment of
checked_node_cnt, when we reach the last node, we cannot print out 100%
progress. So, go with pre-increment.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78ffdb6..23b9433 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -517,7 +517,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		if (!c.show_file_map && sbi->total_valid_node_count > 1000) {
 			unsigned int p10 = sbi->total_valid_node_count / 10;
 
-			if (sbi->fsck->chk.checked_node_cnt++ % p10)
+			if (++sbi->fsck->chk.checked_node_cnt % p10)
 				return 0;
 
 			printf("[FSCK] Check node %"PRIu64" / %u (%.2f%%)\n",
-- 
2.42.0.582.g8ccd20d70d-goog

