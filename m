Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6325F7F04A7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 08:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjKSHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 02:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSHKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 02:10:22 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49FB1BB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 23:10:18 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2ea7cca04so2322907b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 23:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700377818; x=1700982618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHLaUi85HqGEFshr/i8Oa6i6d3yOkcWZkUBdwoWoo+w=;
        b=SuajwuBmnCoUUrobYy+oz3Tmm7bjt3RYdeZLsuMV+83qa5cs7AcsYAUd93iUCn4fb8
         tYm7HJPjyk+B3l5o8FsZ1CqsrZAfgH4PgraT1NG1ejKw21DfIYSlQomCzzWyVqab0V8t
         uDbtrXr3Fr67IsfNCY+ciBkKq/gFB1quvQwsAIJBAMqKKqEKBTJy+vQK/1Yz2zVBu9/R
         INN7BNDQe4+6JjcNzmrssm9SdZ76XWAdrWhf4ZL08snMMmk3OQGxJMNEN+PVaghHbVQj
         Hn0f3r/PP6whL5LCJOF2DciWTwSaWh459zPq7vdVGLLO1gEu3t/BB+viOoRnx0gqC2Z5
         myxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700377818; x=1700982618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHLaUi85HqGEFshr/i8Oa6i6d3yOkcWZkUBdwoWoo+w=;
        b=XqPtDaEBPymH9E2u5Sfw0WRs6dQ1bvSz/XmN32QRyc37LxFGD0JWcsUNEoC2fxq0EF
         yv9Mzq9dP8tB6KuToawoCveAzVJ3nGj1EtPjO13ebXhUTNuY0nETnMbeP7CC+RiVeHvD
         i5CeFJd2b0dw5v/Dz0oOETGfzuFt8g16Ay0/VwsscJQegscasgHil2lbYwIwagtChyYZ
         U4O2CPrrgat6vLXrzAU9MdyREgPfUZogCph8wWgVveAkz/eF2MrHYDndv1a11kRY10tb
         8mN92bvjRi5WPcTYMAbG4DCflZZv23WGLIHoyoxv6OD7oWPTbNla/VPLqL7jrrExNSp7
         9t6w==
X-Gm-Message-State: AOJu0Yxe+JHlY4omrljljsnneBlmTSglj6nRd8jzDBJBCkCUgb4GNx9+
        mdLWSL2kmJZks2tKwy/a/mE=
X-Google-Smtp-Source: AGHT+IGdI1r69QIT8do+8fs8hBqvSL7czmTd2bbdsTlGPw8CA9NyhwQ+I2advBnHd/u/ZcZE7zfu5g==
X-Received: by 2002:a05:6808:1812:b0:3a7:c13:c8d1 with SMTP id bh18-20020a056808181200b003a70c13c8d1mr6421607oib.17.1700377817862;
        Sat, 18 Nov 2023 23:10:17 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([2405:201:1f:605f:7810:25a6:651c:f965])
        by smtp.gmail.com with ESMTPSA id c24-20020aa781d8000000b006bde2480806sm3851256pfn.47.2023.11.18.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 23:10:17 -0800 (PST)
From:   attreyee-muk <tintinm2017@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com
Cc:     attreyee-muk <tintinm2017@gmail.com>,
        syzkaller-bugs@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Tried removing the error
Date:   Sun, 19 Nov 2023 12:25:54 +0530
Message-Id: <20231119065553.130111-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respected maintainers, 

Looking at the code and the call trace reported by Syzbot, I understood
that the issue lies in the drm_gem.c file in
drm_gem_object_handle_put_unlocked(obj);. As per my understanding, I
believe that a warning is given out when the DRM GEM object handle gets
destroyed along with the function getting returned immediately. To take
care of the warning only, I think that the WARN_ON can be removed with
only the function getting returned when the object handle gets
destroyed, without a warning. Or else, we can even have a message
logging in the place of a direct warning which will give out the
information that the object handle has been destroyed. I also think that
the WARN_ON is given for debugging purposes and hence proposing a
solution if the warning can be replaced with a simple message log.

I am looking forward to getting help in this regard from the respected maintainers. 

Thank You
Attreyee Mukherjee

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

