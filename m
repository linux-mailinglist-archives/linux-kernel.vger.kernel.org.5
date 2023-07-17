Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE30C756083
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGQKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGQKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:33:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EC219AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:33:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b89cfb4571so34832645ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689589983; x=1692181983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATTO38/iOwVxNwj2oDkWC8K05sDZoQ4wq1YyEPI7+d8=;
        b=MyOhzNAQ9J1iPOmPtoVjZ4DgBGmtH/yypeJvaYJuXuHKJWwG3hmX1TR6Htx4j6Tde8
         J1wj0/3c7wtqzGEFhVGk8UeNk43zxTSKQDASwRZeVLrigBUrmKKgGy6/C0YS3j+IiELZ
         jESzbOjERN6CT+e7sri3mg0D//U4ofZZRc2eh1rU2+aObRLTSOlpTrndBN04QgHsOA5r
         m3je/+qdgFfY2qVbwGPUCpvkbtoBEWVIbAtHmrzTZ+cOqAPCQWcR/PzqBkMndlVHYhOD
         p8ZOep23FpvRle3w/tnzVxtSDiZiTrTs98vx54qWjhLcQE84EpAnnld2qQiCefx5ha+j
         fU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589983; x=1692181983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATTO38/iOwVxNwj2oDkWC8K05sDZoQ4wq1YyEPI7+d8=;
        b=U/MUuZnOZ+FnH7silYXCmGsDjSN+1sJAsPh6gx8vWY3DpdsQWPL+MiX2C0o8mwSO0C
         4nlEzhJtnF56ZmDboG8Qy1nrjRIvUWsljqJmyMDaDz8G6CjWUu6MKwENz7glTiHYYlQg
         1wwrkkEl9DsMZdskR+Ou8W7D1EwcfsiGFexqkjF1YXeNj6pjYepLY6gj8SR0IC3vStZ9
         U1ziG35kVQu0/kHjIEBsOBRlS0kt46W+bT9cfPrcgTe7MjAiJiz8RTcIZ0jMpw4M50Wa
         E11KLEztwTzcHZQkKnJ5ApD8+xC/KeckkslWrYAS2pRdBcUyPH91CjX1XV6JYvVVuJE3
         Xncg==
X-Gm-Message-State: ABy/qLYzy6mo1pHExLuHjgAZ57Gq/x0rNIPIkm/pbuOH61sWejhB8jN1
        7tG03qLYKy/BK91bNQqJR27PSg==
X-Google-Smtp-Source: APBJJlFeyZDPDWURFC6I/5UxqTtOXcwxmB92C9PgveQcu/vBRWYlKgTJnm6kdl0bBnm/qdhLmlHGEA==
X-Received: by 2002:a17:902:efc3:b0:1b8:b461:595e with SMTP id ja3-20020a170902efc300b001b8b461595emr12182599plb.48.1689589982808;
        Mon, 17 Jul 2023 03:33:02 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b9de67285dsm12633616plb.156.2023.07.17.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:33:02 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v8 2/4] usb: misc: eud: Add driver support for SM6115 / SM4250
Date:   Mon, 17 Jul 2023 16:02:34 +0530
Message-Id: <20230717103236.1246771-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.

On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
needs to be accessed only via the secure world (through 'scm'
calls).

Also, the enable bit inside 'tcsr_check_reg' needs to be set
first to set the eud in 'enable' mode on these SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/usb/misc/Kconfig    |  2 +-
 drivers/usb/misc/qcom_eud.c | 62 ++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 99b15b77dfd57..51eb5140caa14 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -146,7 +146,7 @@ config USB_APPLEDISPLAY
 
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 7f371ea1248c3..136cac90228a0 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -11,9 +11,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/usb/role.h>
 
 #define EUD_REG_INT1_EN_MASK	0x0024
@@ -30,15 +32,25 @@
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
 
+#define EUD_EN2_EN		BIT(0)
+#define EUD_EN2_DISABLE		(0)
+#define TCSR_CHECK_EN		BIT(0)
+
+struct eud_soc_cfg {
+	u32 tcsr_check_offset;
+};
+
 struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
+	const struct eud_soc_cfg	*eud_cfg;
 	void __iomem			*base;
 	void __iomem			*mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
 	bool				usb_attached;
+	phys_addr_t			secure_mode_mgr;
 };
 
 static int enable_eud(struct eud_chip *priv)
@@ -46,7 +58,11 @@ static int enable_eud(struct eud_chip *priv)
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->secure_mode_mgr)
+		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_EN);
+	else
+		writel(EUD_EN2_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
@@ -54,7 +70,11 @@ static int enable_eud(struct eud_chip *priv)
 static void disable_eud(struct eud_chip *priv)
 {
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->secure_mode_mgr)
+		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
+	else
+		writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -178,6 +198,8 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
+	phys_addr_t tcsr_check;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -200,9 +222,34 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	/*
+	 * EUD block on a few Qualcomm SoCs needs secure register access.
+	 * Check for the same via SoC specific config data.
+	 */
+	chip->eud_cfg = of_device_get_match_data(&pdev->dev);
+	if (chip->eud_cfg) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get secure_mode_mgr reg base\n");
+
+		chip->secure_mode_mgr = res->start;
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr-base");
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get tcsr reg base\n");
+
+		tcsr_check = res->start + chip->eud_cfg->tcsr_check_offset;
+
+		ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);
+		if (ret)
+			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
+	} else {
+		chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(chip->mode_mgr))
+			return PTR_ERR(chip->mode_mgr);
+	}
 
 	chip->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
@@ -228,8 +275,13 @@ static void eud_remove(struct platform_device *pdev)
 	disable_irq_wake(chip->irq);
 }
 
+static const struct eud_soc_cfg sm6115_eud_cfg = {
+	.tcsr_check_offset = 0x25018,
+};
+
 static const struct of_device_id eud_dt_match[] = {
 	{ .compatible = "qcom,sc7280-eud" },
+	{ .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eud_dt_match);
-- 
2.38.1

