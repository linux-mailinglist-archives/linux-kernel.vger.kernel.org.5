Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8584477645D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjHIPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjHIPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:48:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CC1FEF;
        Wed,  9 Aug 2023 08:48:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso49059855e9.0;
        Wed, 09 Aug 2023 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691596113; x=1692200913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNAUmWM3JtAR5Xew43AJylljCyPA085c+UJjgn20Ff0=;
        b=gJc1PuCJ9nZ3KJbXveQg/jHhaY4wMbzpez59erprqt6jsCW8e09eL94FmjSLwcjpg+
         5Ev+MWraTPfz5JUXbm2bx/R+m4F9Uh8EZnRm5+mGMkb9ynxBb/7DiKPoa1u5SXeY+vyR
         i4D0sB3KdRSDJ1774jN4bzh92GTpem+n3VEVBcmACOssC+I/WPXUFKbsjSHr0464nSJx
         KyJXlvArXI4ziCAA1djMX+ZT1G63uxvu1uIvP6UN8dABiP+mjDktH9KvD6BrDidutZKC
         kd2+E+Yk1lHg38QwW+30MpGhhT8unVJAIQMsR+jyH1CvYXlqateStkpDfnNqSa5xOuVS
         MUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596113; x=1692200913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNAUmWM3JtAR5Xew43AJylljCyPA085c+UJjgn20Ff0=;
        b=YDyxpO/Qd2ZLjEF60pFTvO/jCzQOvOnufdGGrjQtsFdrRJy5XkyUg7Yd3u2s3rXaAR
         bZm966H0PuvmyMA7ikaC/+FCLTJ9z8Sb0oFsdQ5HXS/XFv6WBiDJyaS7m6p9bMWg2o+o
         /SasMencU5DvYYsUh9RTBcBVwili3zrX5kNkQafOdl3vcLVCmfRET/s2/PizC0r4sh15
         l1uz0/v+S+4ijS9P5y80GEm6JsO+P42vGN/QLd0IERjtRoBCd1QGa8dUHNu8GwjiMFu4
         VfHadMBGCmOhRnRSdbLtXpc58/ujyivhR/J9cq830psI6hSIttSjSiADgI/7ZQ4DSgo/
         97kw==
X-Gm-Message-State: AOJu0Yy+rgBaF1ThOiUo8dtm4eG8SeVPzVCuKukZUcQy30NwJ16ei9U8
        sCZTrTSmdbfELX62iYUWUYbTmVHyUVm2Vw==
X-Google-Smtp-Source: AGHT+IGkxOkZaTOhnw8brA33PBkFL5ObnWyNyyI7poJwX7Ye2KMDU+ApM9qS2/XT8Dwzw6RAah+HsA==
X-Received: by 2002:a05:600c:2197:b0:3fe:63ca:ccf6 with SMTP id e23-20020a05600c219700b003fe63caccf6mr2435578wme.16.1691596112921;
        Wed, 09 Aug 2023 08:48:32 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id y9-20020a1c4b09000000b003fe215e4492sm2312396wma.4.2023.08.09.08.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 08:48:32 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     florian.fainelli@broadcom.com, rui.zhang@intel.com,
        amitk@kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, mmayer@broadcom.com,
        alex@shruggie.ro, Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: broadcom: brcstb_thermal: removed unneeded platform_set_drvdata()
Date:   Wed,  9 Aug 2023 18:48:13 +0300
Message-Id: <20230809154813.16033-1-aboutphysycs@gmail.com>
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 72d1dbe60b8f..2997c589ac7d 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -334,7 +334,6 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->tmon_base);
 
 	priv->dev = &pdev->dev;
-	platform_set_drvdata(pdev, priv);
 	of_ops = priv->temp_params->of_ops;
 
 	thermal = devm_thermal_of_zone_register(&pdev->dev, 0, priv,
-- 
2.34.1

