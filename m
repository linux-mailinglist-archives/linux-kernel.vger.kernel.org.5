Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16677F0477
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 06:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjKSFLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 00:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjKSFLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 00:11:08 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520AB131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:11:02 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-281035fa272so4100696a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700370662; x=1700975462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57Ko5YMUmiKs7TvU5kH/5QHtCs9i6krLFRw5XGCRsa8=;
        b=q7iYUBkMe0MoREhQFhsTzQhMFnPLDUhVDOUsJ7X1vyf3N/BlBvMKp7Lf+npxvIbCzY
         LOrWVfArxZXgKp4xHBYKIhbLQP4CFVBZ4EvaMQZnqrAnYueWZw/n9gT2NItl6eHaMscl
         CHNk2wIuYtIxzDfvHQSJdDy7oDt/YhRZN1PmdkxztfzgostrvJepsZSZJsTJ5KMf6Udd
         D2yyTwWrVBlvHAVEsBm3BFLEUqnopFXEiZb7YA61XYCTdA2+veI8V2ZBV3gvzthruRwg
         FpALgQ6WzC8NI9kJFbzonzHzIrWuJmFyPBMD49r6F09nf2JfUzQUDL7PRWhHUULPl05C
         H3kw==
X-Gm-Message-State: AOJu0Yzq9qvX2t1Sz2ykBFNTP4dFPlJbeCvJASDeKjK0lFCR94DihYgD
        xePxqn0dvMhyulC9XU2Q5GrauZyec6iScm5d+Tg3gczUTNCju90=
X-Google-Smtp-Source: AGHT+IE2W97HtZ9LEbVVxFWuQ1JPnQ7KNiCAShcJ4s2tEPspwYbmZ5eZjkGryx5jQ1TTCtmnR+lrin/vzA1e6Ri5XsX12Lp5l6VP
MIME-Version: 1.0
X-Received: by 2002:a17:902:7006:b0:1cc:3135:acbc with SMTP id
 y6-20020a170902700600b001cc3135acbcmr995747plk.9.1700370661932; Sat, 18 Nov
 2023 21:11:01 -0800 (PST)
Date:   Sat, 18 Nov 2023 21:11:01 -0800
In-Reply-To: <000000000000dad29506056fbc93@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a862f060a7a6543@google.com>
Subject: Re: [syzbot] [PATCH] Tried removing the error
From:   syzbot <syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Tried removing the error
Author: tintinm2017@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 44a948b80ee1..b6be9400cd11 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,7 +222,7 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 	struct drm_device *dev = obj->dev;
 	bool final = false;
 
-	if (WARN_ON(READ_ONCE(obj->handle_count) == 0))
+	if (READ_ONCE(obj->handle_count) == 0)
 		return;
 
 	/*
-- 
2.34.1

