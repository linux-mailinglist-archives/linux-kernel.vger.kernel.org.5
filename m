Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46D779072B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351946AbjIBJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjIBJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 05:51:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A210E0;
        Sat,  2 Sep 2023 02:51:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so28173425e9.3;
        Sat, 02 Sep 2023 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693648279; x=1694253079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbb5oQMsQ8lmQSEo8cUIG7jOpdgmCm7bwk/9zmNVbiQ=;
        b=sWiE6DmTwFtvnxjwaVJX1lnq1ATgCvtupRczHbqz1o5VASUpw6hnzWPrRqdk/WuW1q
         Xv4bJ+h3z4TTSKMktLY1+JTz4Io8gQpxto1e90yNBqeGsbSzhbOyw27GYxAq+Ev3bWQP
         8BA/dRHEQJob6jULxb+LcahwC2hmXbBX0PP0K7V/RMR+BqTRbKOUVvdZLdh8U3ohuDmN
         fb31xImgqpuMi7V1hP2m2JPP32wBMMYZH23SfbdEvb8v18Z5DuII7xXx2JNqyAsOfFKe
         HtEK5wnzH/QAn6ZyU5fcVIE5B9y8711lexZ/OA+BUFLB0dMMgspfh0Zm5yXsv243vXWO
         GQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693648279; x=1694253079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fbb5oQMsQ8lmQSEo8cUIG7jOpdgmCm7bwk/9zmNVbiQ=;
        b=M2djMBneaeu21EkFwqGT2J8wlQvV4mwjCIyoKp9TAW9sYwWQW4gPGEbn3HzI4KzpfS
         EkvEEC899F+1qwnaYpyQiC3PNqcsSGPjzxEZER/iX9Nja00ZHJw3IYjss0m5ArxrTcpu
         LtfhpjXjL7HgFE+6ZuI8XfxFdKAfZ7YdGtQihGGaTJTD4xNfEGC1te4Mr/L5TsrddLyK
         DTrN5EfEr+qpq85FZmHQa3HsymuT7m+pqaVDsFLnuvwiH4ROIl/WWv1YwHzNt/4QoM6p
         LH+i48Wnw4uNHDtLl2miLUJrVxmc7425EOAPJrzGXzOscqaJo9X2G3F6crblc5b0uotN
         XDXw==
X-Gm-Message-State: AOJu0Yz+ZCFWEdFwSDs7BY2I4zEaoaFo/HqRYS4DIyBtsx7uFqO2g9GU
        SOdQfBHR3/S1yULQDBxwSAU=
X-Google-Smtp-Source: AGHT+IGmQa/GauRsf0/aiYROnGceuCwUpNyZyYJJQm+ebKyOLg4+r2rLhUqGi6WPLcJtraEtJNsWhg==
X-Received: by 2002:a05:600c:2153:b0:3fe:e8b4:436f with SMTP id v19-20020a05600c215300b003fee8b4436fmr3465957wml.14.1693648278261;
        Sat, 02 Sep 2023 02:51:18 -0700 (PDT)
Received: from localhost.localdomain ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fc04d13242sm10786628wmi.0.2023.09.02.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 02:51:17 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
X-Google-Original-From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
To:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] fbdev/g364fb: fix build failure with mips
Date:   Sat,  2 Sep 2023 10:51:02 +0100
Message-Id: <20230902095102.5908-1-sudip.mukherjee@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
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

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Fix the typo which resulted in the driver using FB_DEFAULT_IOMEM_HELPERS
instead of FB_DEFAULT_IOMEM_OPS as the fbdev I/O helpers.

Fixes: 501126083855 ("fbdev/g364fb: Use fbdev I/O helpers")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/video/fbdev/g364fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
index 7a1013b22fa7..ee6fe51e0a6b 100644
--- a/drivers/video/fbdev/g364fb.c
+++ b/drivers/video/fbdev/g364fb.c
@@ -112,7 +112,7 @@ static int g364fb_blank(int blank, struct fb_info *info);
 
 static const struct fb_ops g364fb_ops = {
 	.owner		= THIS_MODULE,
-	FB_DEFAULT_IOMEM_HELPERS,
+	FB_DEFAULT_IOMEM_OPS,
 	.fb_setcolreg	= g364fb_setcolreg,
 	.fb_pan_display	= g364fb_pan_display,
 	.fb_blank	= g364fb_blank,
-- 
2.39.2

