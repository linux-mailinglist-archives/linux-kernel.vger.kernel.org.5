Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC07797C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjHKT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHKT26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:28:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0030E6;
        Fri, 11 Aug 2023 12:28:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso21438945e9.0;
        Fri, 11 Aug 2023 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691782136; x=1692386936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXWmRapdmWSpOJGcCnf+eTbv0hwO0eR2fATZocuX9i0=;
        b=M4zMHdklTi41Vs2EVIqzFP2uvzg71K+uZTT7l1mwsTIvPH7npW6JMwx+UepkXInA2Q
         U3aTBo6YuIKIw82euChV6xBdwwQPGA3nRTfc6Omf9XUBWnzctWHOe2ZD9WVM45y0Q7Cj
         azumh/Tu3XaF+dnqtICRy4ld5RAE3SFxYN7IFo+2r37jC8gBeXV5UAgKJA7fHMnHvVvr
         Lpvp+rQ+9rC+/j7rGuviRy4oY5Jlm58VyTaLLuisnaErMCR560KlYf4H21ZL0hz4GvFJ
         9oy2ToFc1t/CDvu8Psl5qCBO39bybfdeyZdE5XY6y0bMp9GgQ1rAfodrqhhWMLswYfkF
         gx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691782136; x=1692386936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXWmRapdmWSpOJGcCnf+eTbv0hwO0eR2fATZocuX9i0=;
        b=iV+YSpX/kdUJek4FeGyuvEfhU7CUqCKRWAuEncdgYvkqacS9DSFW3UWx7GBmTjjCMi
         j0e8qlcv8UQwNtOKgIJQuJp7Mx5ejZKe/ewzazD9OcspugvVcFR3jRXW493wdLMFyOrv
         9kHN7EmjAnrRHLIWg+YbPUDs+15VHKBjggL/BH+Aydps7Xqag2w9FDOBbJVdxJ4UAVD6
         sI0b6vvC8IMtBci8EqN1Jt9Va5OAs3G5KRnUBOVVJdnMA0HGqEjPo03iMB0pXfoGLCug
         Bee8B3T3HVnnneVryW0wUbsp8qQlY/LnsyKSs9BTUnT7sdpzJ6bt6xEUwJ7WBMbxd9LV
         asLw==
X-Gm-Message-State: AOJu0Yy8DgaHY7/M8tzJ4Gx6XztyrhIxUcjiMafjKlXwLRUj0FlMeHOM
        MYPnzCvfdK3+2mvfHjmc/TI=
X-Google-Smtp-Source: AGHT+IFbYgQt8ICnMPepR4vjBncTPqeCwItzMpL0iUVa8ME8CdhVjlBBG5eEBluNJoJzLV9WIwI0EQ==
X-Received: by 2002:a1c:7c10:0:b0:3fd:2dd9:6d58 with SMTP id x16-20020a1c7c10000000b003fd2dd96d58mr2153458wmc.26.1691782136239;
        Fri, 11 Aug 2023 12:28:56 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id f20-20020a1c6a14000000b003fe8b249df1sm1871152wmc.41.2023.08.11.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:28:55 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rdunlap@infradead.org, void0red@hust.edu.cn, daniel@makrotopia.org,
        bchihi@baylibre.com, aouledameur@baylibre.com,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: mediatek: auxadc_thermal: removed call to platform_set_drvdata()
Date:   Fri, 11 Aug 2023 22:28:47 +0300
Message-Id: <20230811192847.3838-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index f59d36de20a0..99a1c35c68e7 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1283,8 +1283,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
 					      auxadc_phys_base, ctrl_id);
 
-	platform_set_drvdata(pdev, mt);
-
 	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
 					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev))
-- 
2.34.1

