Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414EB77BFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjHNSTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHNSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:18:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7910E3;
        Mon, 14 Aug 2023 11:18:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99d6d5054bcso861685866b.1;
        Mon, 14 Aug 2023 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037113; x=1692641913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUHvcmtjpBkUa0SBqcJy0lr9ht+UJKtloUpURLnUdDw=;
        b=oX2nvUVDie32EJdDYkJVp5WxIcjt4iN9G0NGMaiyCZ0TAKeF3h6Ebo32U9qJDevDBU
         bhhMyROxbD7PnmD1oRcITMc4rQiuvXTKBuGq0NQ24mLWzV7Nd4tij+xIIalwxdFvPmkK
         ZScjLQiQuJgoAt6cRT9L1ua21t/Tcnw0z9ux4S+dk1+IKrbj29i+ll4IQVS3sAElXcFB
         LvZ1+hrm839cpPzEcL2mWCwFnZj76jnxk/NIiRIEGUEmG5Pikixy2y+GP1poY5MT1Y3Q
         hNQPPtB4fAAnfkh7dejZgu0kiIa8Fm862GzToheS2pGvruSjTYNhByTDM3dNiNnz/294
         wztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037113; x=1692641913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUHvcmtjpBkUa0SBqcJy0lr9ht+UJKtloUpURLnUdDw=;
        b=lOx8rT4hQTPycgjOLddmDlkXnz93ttWBtEfEUWk4sF+KooZueeYiDWuP488bNJqQrl
         4AGFJ8Wo5Jbu1Aal8d+WxzWUtC7TTGMDjct3bohsWuftpzmplxaTUa07fugPvD6M/dSx
         l7zTkAYW0+Yuv4Uf5UxA5dGIor9qnEVIk1as+3dofWwNU7ABPafKYCVASA1AyU6vZk+c
         9U+C4NQ0XPeLjUt6Dk/lgBjD0yngMT+OuJIxA4EJHfKBsp05vZfrAt11u7951K73Cfqy
         XFtuPMluMXmU3ZODvxEc89tLYHo113aECGaYFE+NUdeS7HF4IDbJtIidbjdSrxPNjBvn
         0U4g==
X-Gm-Message-State: AOJu0Yzws7OLZnXM8K3JJP2TMFm42HCVEFL/nlUL+oP6CarfkDQ+7CUQ
        DYyDZAPdqiPybFXbkLj8o/MYiytSfeY=
X-Google-Smtp-Source: AGHT+IEewhGDlHSgt5R/Swu0Cg/wZGfU6CqlzFAie2hkwI9lwUVi3Ax+Gu4y+TgIiXf3Nt2KCNigsg==
X-Received: by 2002:a17:907:2c59:b0:99c:ae54:6654 with SMTP id hf25-20020a1709072c5900b0099cae546654mr11429382ejc.14.1692037113040;
        Mon, 14 Aug 2023 11:18:33 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5947659ejb.103.2023.08.14.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:18:32 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     alex@shruggie.ro, sre@kernel.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, agross@kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] power: reset: qcom-pon: removed unneeded call to platform_set_drvdata()
Date:   Mon, 14 Aug 2023 21:18:23 +0300
Message-Id: <20230814181823.3662-1-aboutphysycs@gmail.com>
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
 drivers/power/reset/qcom-pon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 1344b361a475..34478d60e2c1 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -80,8 +80,6 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, pon);
-
 	return devm_of_platform_populate(&pdev->dev);
 }
 
-- 
2.34.1

