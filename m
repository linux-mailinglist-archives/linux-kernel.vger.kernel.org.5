Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC574754D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 04:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGPCHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 22:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGPCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 22:07:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5219026BC;
        Sat, 15 Jul 2023 19:07:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so3365784b3a.2;
        Sat, 15 Jul 2023 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689473264; x=1692065264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxPKP+V63M+GAwl6cI9knHuACfwcn/poMoNn2DZ9j0Q=;
        b=maqptTndPqULB5ypjjyUO6QWY/CCmqQfuQ22BeKNxDGjnfpKAxIRd5Yo8srtiEJm6r
         VSbtYd+H1G8GQD2vNDWV8uzuiWuLaHNwF5z7/WlTat5oTbzgCpLKTsDaTbogSBnIPO9+
         0fa0s5CdrNLNBNd0pYYrGBSNN51SacrOMb5FisJJxAJr5aCmTZ5lpDKQzafYiw4HpCYJ
         LoWhavYuycSuRf/RBSkSYcM0Hd5HSSqBCiOL/xLprtH6mht8oxpM9hEnHhLa1miQUOzv
         rEmCwHuV0wVQs7oAatoljttMVUGP8INKiAJF+jtQPbntHsyYfVyLx1irBJRLsTKcGO8J
         uUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689473264; x=1692065264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxPKP+V63M+GAwl6cI9knHuACfwcn/poMoNn2DZ9j0Q=;
        b=Any1660DchiSE6TTT7C7wYT7KTrbrUv6ep18F769Gsg8NDW6PQW65E+fGDDXLbOZRM
         bmR5HM5/fsGsGuDkbtHWpPVS04OoLDHWFWNj2uC6LxK5gfGQnbQ8NNEApjCelpWHPlwg
         seRBHAK3l3G52O5Bb7c5mr1ggSVO1Hx/0v9n9b9fUfwmzLgl1TWjnxV2TMCGeIBREpZ7
         dJgatya7S+fbz2L8jqYAJ6ydCf8HaGZsuFDt35ikIlOwEzFwCYZWgY/d5jZkjnY5Sns1
         co20yUCVgq6PPocBvfVBbTC18Qw/uH2ROyoryltPq4gZYNM2PYpWNyV83OdyWlSHKKqa
         HaWg==
X-Gm-Message-State: ABy/qLaNTsmPTwfVPSkP2FWjxXk9NlVPr5lVf1G6cUBFuQ8on7751jCm
        fNu7b/5kSACr/5wd9BvBTxw=
X-Google-Smtp-Source: APBJJlHEPYkOKT5jLCWlGHAJMeapR2MN8SKYZoxlKlvz/mSLtVR91AkoKITKVKNTtuzSikVpZFcJGQ==
X-Received: by 2002:a05:6a00:15d0:b0:682:3120:1450 with SMTP id o16-20020a056a0015d000b0068231201450mr12250405pfu.30.1689473263757;
        Sat, 15 Jul 2023 19:07:43 -0700 (PDT)
Received: from localhost.localdomain ([121.32.71.42])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b0065da94fe921sm9429905pfn.50.2023.07.15.19.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 19:07:43 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     claudiu.beznea@microchip.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v6] pwm: atmel: Enable clk when pwm already enabled in bootloader
Date:   Sun, 16 Jul 2023 10:06:52 +0800
Message-Id: <20230716020652.18557-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The driver would never call clk_enable() if the PWM channel was already
enabled in bootloader which lead to dump the warning message "the PWM
clock already disabled" when turning off the PWM channel.

Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
the PWM channel was already enabled in bootloader.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 47 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..fc89282db645 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -36,7 +36,7 @@
 #define PWM_SR			0x0C
 #define PWM_ISR			0x1C
 /* Bit field in SR */
-#define PWM_SR_ALL_CH_ON	0x0F
+#define PWM_SR_ALL_CH_MASK	0x0F
 
 /* The following register is PWM channel related registers */
 #define PWM_CH_REG_OFFSET	0x200
@@ -464,6 +464,42 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
+static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+{
+	unsigned int i, cnt = 0;
+	int ret = 0;
+	u32 sr;
+
+	sr = atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
+	if (!sr)
+		return 0;
+
+	cnt = bitmap_weight((unsigned long *)&sr, atmel_pwm->chip.npwm);
+
+	if (!on)
+		goto disable_clk;
+
+	for (i = 0; i < cnt; i++) {
+		ret = clk_enable(atmel_pwm->clk);
+		if (ret) {
+			dev_err(atmel_pwm->chip.dev,
+				"failed to enable clock for pwm %pe\n",
+				ERR_PTR(ret));
+
+			cnt = i;
+			goto disable_clk;
+		}
+	}
+
+	return 0;
+
+disable_clk:
+	while (cnt--)
+		clk_disable(atmel_pwm->clk);
+
+	return ret;
+}
+
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
@@ -496,16 +532,23 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
+	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	if (ret < 0)
+		goto unprepare_clk;
+
 	ret = pwmchip_add(&atmel_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
-		goto unprepare_clk;
+		goto disable_clk;
 	}
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
 	return ret;
 
+disable_clk:
+	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+
 unprepare_clk:
 	clk_unprepare(atmel_pwm->clk);
 	return ret;
-- 
2.25.1

