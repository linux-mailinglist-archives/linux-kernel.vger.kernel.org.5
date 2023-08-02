Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F876CEDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHBNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHBNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:35:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CD2701;
        Wed,  2 Aug 2023 06:35:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so11314021e87.2;
        Wed, 02 Aug 2023 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690983318; x=1691588118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIdVDpJXzS+NvG6cPE69v+Vo8D8lHdK5ntY+IO2Phoo=;
        b=D2kDCBtAttEWumqYhWLnqvzu6wleezJOq2vuwf5ntVyQ2rTwT6EjhipQarm7eSaZM0
         c1p/UpO91vnGCCn0bVnT2mogT1Dl0G55aWrYyug7/TMfrZa6rXcHSGBgIpxgtgX0N8zw
         UzzjBeDVkF95OdNCm7kbjHxJyxForQRSK20cO1Uh8XysUwBmVSrXe92W1R7b6k97Za1C
         1CXlFiyofIeMw1Xu8uL38AzhkKL1DPVDlapdESRsHP0Oo+gsxx/J/fU5bkKfl2w37Kk5
         R/Ij0OLkqBVnu9lbCq9ix8ykKxNtTirJVLgLpPmx1M0hJNdUwbI/JJ4w2udZ9a2XfuGp
         VNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983318; x=1691588118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIdVDpJXzS+NvG6cPE69v+Vo8D8lHdK5ntY+IO2Phoo=;
        b=h/zcyyqPB94MXbVhYctbh2iOVxn/TfXDljKpyvrkmIubsYF7levmqNh48dCbG5KZM5
         r74l2ssc8IVQmolQvhMk7fctsBl9/A24BOs4VSIjVR2tRM7nmh+qC9zLd8pavWpAQLAe
         7zuP07U/lEsHS0DEVX8o8WtN2KHH600Oj6+kWx+rl5Npe/gtHX6H/xA6OriJTigiAF+Y
         c1p5FV6yoeZeW9sAvsxunxBVpwQ/CWhe3sByRCMFILHT4iIQjwd/j4EWP3xLoigZVeyy
         fKnsji9XJYz2vJ7MFtIGIH2BH9lC21t84Uy2lFICycgA+b6u4mRLQl4pi5BZfIEhX8EU
         qmjw==
X-Gm-Message-State: ABy/qLYwPGj5JVOpPu1ylfcD0sfMEYiWQBoAtvwpN0t6SAUpvNCqLNSD
        tSfA4K+QrdsF9JmkgPGbo3OzOJYF8PV1mA==
X-Google-Smtp-Source: APBJJlEHTtK/CnKxbSzEwYziNluvzwpl4TyauHGwMYXt4Y6XTzcawP+k/3a8BYfEbHGb3QZCY1jRUg==
X-Received: by 2002:a19:501a:0:b0:4fe:2f8a:457e with SMTP id e26-20020a19501a000000b004fe2f8a457emr4109315lfb.43.1690983317800;
        Wed, 02 Aug 2023 06:35:17 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d68f000000b00522594a614fsm8547719edr.13.2023.08.02.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:35:17 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org
Cc:     alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        lars@metafoo.de, jic23@kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2] iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drvdata()
Date:   Wed,  2 Aug 2023 16:35:09 +0300
Message-Id: <20230802133509.29381-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---

Changelog V1->V2:

* https://lore.kernel.org/linux-iio/CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com/T/#t
* Adjusted the returning values of the function


 drivers/iio/trigger/stm32-lptimer-trigger.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index df2416e33375..ab1cc6a05f26 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -88,11 +88,7 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	priv->trg = stm32_lptim_triggers[index];
 
-	ret = stm32_lptim_setup_trig(priv);
-	if (ret)
-		return ret;
-
-	return 0;
+	return stm32_lptim_setup_trig(priv);
 }
 
 static const struct of_device_id stm32_lptim_trig_of_match[] = {
-- 
2.34.1

