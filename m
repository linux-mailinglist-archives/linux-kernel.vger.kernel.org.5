Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0509A77BE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjHNQxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjHNQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52D493
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe82ac3ab4so6719918e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031987; x=1692636787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2ufyMbSr52063L2gnL8kN/obI1LGUR1mTFo5Z71Gt0=;
        b=GglBhYhLBWsgSFaydUqo+KhsoE0BrTqGrOWQVvnnT4PX52Ffzq6SmE5b0dDKwd7RCX
         tYAYlXX+lduDlUpgH1gLTROmCnTBC8Ddb/J7p2SiayIy9Nje2tYPnY1w/yVMZ0XLWY/F
         F0BRcZhRs9AImD+dc3SqNh9eLZlQ9GoWLPLO3TupndBCyT3IFDeTEregkpAgrZIJENIP
         V32fFB64Qo7S5Mqc7vGGsAnprEykjcwXfWlpjj6TurRwiN/b+A8l23rffovbrh5ZHCV2
         1SizAtemXksoG1PEK2sANfqOkJBn4t/uV+I7ju24yJbt4OliLbehVO7fgVJumX1eibUC
         9/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031987; x=1692636787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2ufyMbSr52063L2gnL8kN/obI1LGUR1mTFo5Z71Gt0=;
        b=i3MDc8keqKOqSGPSsuQeNvRxjwmGbssmKUx/V4NyNWSIYYEqjq4VwGVXL8Wdkq/K0O
         VV+8H9f70Db58aaZayZwSo3FMWFyWL8dfU/1N2ZwOpADkWe6AvKS+QRXdw7Ax+4jnWvH
         nJwKwTG93GK8x+UUxcc5IPId38TblS0bsvuYY3KNcVcWYhy2ZIxWt+pV7Oz1fkAV0vtM
         azUW6LxcbdCb7skDbZ2vItDVL79/vA9gkuUnxm5YC8JDpWrc/xaFM+bn+zIs40o44ndC
         XIA4OMYrjI72Z4BIedkIN7VplhBd2/mTWOUnSWAogdolX9nIGf8TuPKVlYuunFBcMDVm
         vyLw==
X-Gm-Message-State: AOJu0Yz6Ar3RBtrZCwbSCNgzlu65zLTdulAOFRgcexcFOBYt0T5V/OfX
        /YJ7PM60n4E6wxOSjE7r8L2XNQ==
X-Google-Smtp-Source: AGHT+IFdg9uVenlYJHORc+fwzALYzmsHo0yCiWMSWe4UJRfRtYgCjRKfM4GY7z/v9seYXIM3fdtrEQ==
X-Received: by 2002:a05:6512:368b:b0:4ff:745b:4f1f with SMTP id d11-20020a056512368b00b004ff745b4f1fmr2413845lfs.30.1692031987111;
        Mon, 14 Aug 2023 09:53:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/22] nvmem: qfprom: do some cleanup
Date:   Mon, 14 Aug 2023 17:52:38 +0100
Message-Id: <20230814165252.93422-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Use devm_platform_ioremap_resource() and
devm_platform_get_and_ioremap_resource() to simplify code.
BTW convert to use dev_err_probe() instead of open it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c1e893c8a247..14814cba2dd6 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -374,8 +374,7 @@ static int qfprom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* The corrected section is always provided */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->qfpcorrected = devm_ioremap_resource(dev, res);
+	priv->qfpcorrected = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->qfpcorrected))
 		return PTR_ERR(priv->qfpcorrected);
 
@@ -402,12 +401,10 @@ static int qfprom_probe(struct platform_device *pdev)
 		priv->qfpraw = devm_ioremap_resource(dev, res);
 		if (IS_ERR(priv->qfpraw))
 			return PTR_ERR(priv->qfpraw);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		priv->qfpconf = devm_ioremap_resource(dev, res);
+		priv->qfpconf = devm_platform_ioremap_resource(pdev, 2);
 		if (IS_ERR(priv->qfpconf))
 			return PTR_ERR(priv->qfpconf);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-		priv->qfpsecurity = devm_ioremap_resource(dev, res);
+		priv->qfpsecurity = devm_platform_ioremap_resource(pdev, 3);
 		if (IS_ERR(priv->qfpsecurity))
 			return PTR_ERR(priv->qfpsecurity);
 
@@ -427,12 +424,8 @@ static int qfprom_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->vcc);
 
 		priv->secclk = devm_clk_get(dev, "core");
-		if (IS_ERR(priv->secclk)) {
-			ret = PTR_ERR(priv->secclk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Error getting clock: %d\n", ret);
-			return ret;
-		}
+		if (IS_ERR(priv->secclk))
+			return dev_err_probe(dev, PTR_ERR(priv->secclk), "Error getting clock\n");
 
 		/* Only enable writing if we have SoC data. */
 		if (priv->soc_data)
-- 
2.25.1

