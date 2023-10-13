Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1A7C891F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjJMPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJMPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:51:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2BBB;
        Fri, 13 Oct 2023 08:51:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40651a72807so23084165e9.1;
        Fri, 13 Oct 2023 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697212266; x=1697817066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RhLoqrItwtCxMOzJhwgADMg5oDWC1ONfcjuGejQ/NE=;
        b=g3FUgl0ZTlnW2/ebtKRR28TuAZiEFZVvAShMO2lqIg+F6lwI3BnEPWSqRcLGIMM1GS
         2gjN6ErQMMJIAcdWKLz+xctxO7xAZJlVdqRCPK+g7pkbfL8FZaSbCeK4f8jQLHxpx0Ed
         NVBTOBfTxiwyn2V8/V1OdXAC/V2SDTEoxYeXX3fMGsSNQkj9mqsOC/lRUGcmNsb5Uwcm
         BUx/fClCoY00XDvvm0Mx21e50wP/jYMc7eAuuWEt5lSH8o2eg19Ot7bkoU/2RhGwu9c3
         8W/PGxEnH16GHoYUWcIrVJBe298yJUEBfGz0BePpMOkMcrpevl8TbaRx6EoPma/mAQQw
         G0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212266; x=1697817066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RhLoqrItwtCxMOzJhwgADMg5oDWC1ONfcjuGejQ/NE=;
        b=i5+N9nm9e7VQeUSqHo6DA1AEjc0BEXQtNpzyF09ktNtboXtHVftZFKYU7GFSlxITzD
         a4xvwOz+bTPwpejkQ+TGXYIu7PIauTbWKr2tkA+3/5N0YraWuWSz6mI0sKpbuaqQiH6I
         et3PWYlbejVs+X6L/TOX3luRL8mZl4vP9ZY3s0NI6CKK1zJEeg1rdCrkEFXmwLUn1QPI
         ArUFj989090FDccxMRqm9Vo3ZNdb5UzYe4jo1rCi+GP1koOVgJlVArhYKdgxcXzel7qe
         E9Jg2VrCfPdzcIFDgOn8RqvfI99pS4rEGbg0HmUXrJhzBPkfUPi0XF1mZidQFRllBOGW
         e78Q==
X-Gm-Message-State: AOJu0YxKznuXd+48PW7OxGvylVQ6qxGgyXb1KdDNhkk1zbyOWGSndHL/
        W8+zxZIvQnnxH7NrYPMx7NE=
X-Google-Smtp-Source: AGHT+IG3kMFrRsMFJPLDfxnJyruCfzfhEuyok9xizDfq18YdXoGo6Sp6pkVxSyYPAWWFX9eLwr227Q==
X-Received: by 2002:a05:600c:2113:b0:401:73b2:f043 with SMTP id u19-20020a05600c211300b0040173b2f043mr25230019wml.1.1697212265734;
        Fri, 13 Oct 2023 08:51:05 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b004063c9f68f2sm488649wmb.26.2023.10.13.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:51:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH] thermal: max77620: Remove duplicate error message
Date:   Fri, 13 Oct 2023 17:51:04 +0200
Message-ID: <20231013155104.1781197-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
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

From: Thierry Reding <treding@nvidia.com>

The thermal_of_zone_register() function already prints an error message
when appropriate, so remove the extra one from the MAX77620 thermal
driver.

This fixes a spurious error message when no thermal zone was defined
for the MAX77620 in device tree.

Reported-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/max77620_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 919b6ee208d8..85a12e98d6dc 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -114,12 +114,8 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 
 	mtherm->tz_device = devm_thermal_of_zone_register(&pdev->dev, 0,
 				mtherm, &max77620_thermal_ops);
-	if (IS_ERR(mtherm->tz_device)) {
-		ret = PTR_ERR(mtherm->tz_device);
-		dev_err(&pdev->dev, "Failed to register thermal zone: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(mtherm->tz_device))
+		return PTR_ERR(mtherm->tz_device);
 
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
 					max77620_thermal_irq,
-- 
2.42.0

