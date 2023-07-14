Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114F6754193
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjGNRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjGNRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:53 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306223ABF;
        Fri, 14 Jul 2023 10:52:18 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-785ccf19489so88241339f.3;
        Fri, 14 Jul 2023 10:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357070; x=1691949070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLv94wsoBBZ7d+EdEhh5zJTvgGpi6n9qD3d4Savs9Jc=;
        b=CMF1ShqObDglJsYDZHAwd70HDaITO9cpTIEQ3yb4nRH8PPamu3GUYP23UwXulUD05F
         YtWmW0C9ePyfAO576zLx8v6TWAr6PkQLpLqPw6jVNk28M9m8dLeVAclX7/VDsxWmCShp
         15UrfRUonPgoHL3O3gv1/oHojs7EcsUuQ8wSg+CliKM1HslYcUKx+vwk3FI60Lx6U676
         drsFREdC7IRr9KDI4Oh9z7P40e6vRIusAeNaf5SYrksu+BnajfcOKgemsMS5Au9sNgja
         u8q51C984Z9uaM2BTNwf6Pdd8y14Zb6xF5qrMpQJls733uOQn1YEUyEJTPevJCKAVqlt
         zqsQ==
X-Gm-Message-State: ABy/qLbplYNlgrNJWPAay35wY3NTIaNcO6W5d8twKSoD0T8s33bFFMOO
        ZEgAuhCzJrU0sk9/eKltPw==
X-Google-Smtp-Source: APBJJlFNjy6HiNBGMn5U6dVY8e4F68GquR67qkJulZVMMhQwviKf2K65FuVhbV+ByBj4XJAhRwBYSg==
X-Received: by 2002:a6b:3113:0:b0:787:129a:1e6c with SMTP id j19-20020a6b3113000000b00787129a1e6cmr5413859ioa.4.1689357070351;
        Fri, 14 Jul 2023 10:51:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i12-20020a02c60c000000b0042b00378ec9sm2659829jan.34.2023.07.14.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:09 -0700 (PDT)
Received: (nullmailer pid 4065465 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: qcom-wled: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:29 -0600
Message-Id: <20230714175029.4065326-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/backlight/qcom-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index c6996aa288e6..10129095a4c1 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -9,8 +9,8 @@
 #include <linux/backlight.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 /* From DT binding */
-- 
2.40.1

