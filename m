Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285317573C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGRGMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjGRGLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:11:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65D19AD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:26 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9defb366eso805316a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660686; x=1692252686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYiFLzJcgS5ZH0B0OriyMRTUX2STtvU6MnH5HLZczGY=;
        b=CW+vd5hwuP2riG2Y3RncYwSYFhxK2KZcb+Gb6Z0jNIhq1MULcVgSsylmQdYTC8ki7w
         F4nDAW4nAcxLKr/WM+5K08RP/qNzDiiDDajh2OVmw+GnT1++zLAg+h5L8vYxizWizTq7
         Ruksy/6OVq8dPKAHrzGVtYEjOEcAQdP6MOVsItGF+ebVXQRN4Hzkcttkm4+C6e16lHEw
         H8cEWzy7oZQP0EaLVXbS+2hecYIZ288y/C3ZGVd9uVW8NQryNuWAb0ChLLPOf9DGSQ3I
         GDP3loriMXrpeaNQfJYwAu+yp2xI3tcd0nbyr6gujc+T4b/TPIM5IfwAuXGivnvLaROD
         Zj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660686; x=1692252686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYiFLzJcgS5ZH0B0OriyMRTUX2STtvU6MnH5HLZczGY=;
        b=S3nQHWWfJx3PuY0KuH8MHXDPik3SQPhE6GtNqUe+0nrjqCkMwr424qMwxBwn6eikHy
         ACc8tjYEDZWGW36cmsl72ldNokar6VRj4DEOMZ1IiJ+eIoIiwz8macU1RaED+d/1C809
         eUmYvrUX12pdsnYSCf6w06VGWFh0S5YLEr09tSWvWZI9857p/0pqkfn3OYfnzO5mqjxL
         p33P/9F0dqznwDFF4xyv3yLZBbl4HW9XBnX4z5FowdeDWgi/23gZU5deiRF53ROiaJjm
         Tn0pgJ02C7difRbIccS5FVRJNQCrBqG3+vs+HazrItDx0TuZQER+PInNujegq0pT6XF+
         LHnA==
X-Gm-Message-State: ABy/qLa6terPxgFgYOXiHhpzGj7AJk9U1ucmSb9ZED9CSsRQsKjZd2dw
        l9vmNuQi0SPAr9E9jxy5wBubrg==
X-Google-Smtp-Source: APBJJlGitC/u99kqY0gVhuwzkq5zSgoHAKolJgtP0kHG1YRXPRGYAB8mYprBbArc/l08DTEmTKCY7A==
X-Received: by 2002:a05:6358:280d:b0:12f:2573:45b4 with SMTP id k13-20020a056358280d00b0012f257345b4mr10617711rwb.26.1689660685783;
        Mon, 17 Jul 2023 23:11:25 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067db7c32419sm778106pfn.15.2023.07.17.23.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:11:25 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
Subject: [PATCH v9 4/7] usb: misc: eud: Add driver support for SM6115 / SM4250
Date:   Tue, 18 Jul 2023 11:40:49 +0530
Message-Id: <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
References: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/usb/misc/qcom_eud.c | 76 ++++++++++++++++++++++++++++++++++---
 2 files changed, 72 insertions(+), 6 deletions(-)

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
index 7f371ea1248c3..a5b28fc24116a 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -11,9 +11,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/usb/role.h>
 
 #define EUD_REG_INT1_EN_MASK	0x0024
@@ -30,6 +33,10 @@
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
 
+#define EUD_EN2_EN		BIT(0)
+#define EUD_EN2_DISABLE		(0)
+#define TCSR_CHECK_EN		BIT(0)
+
 struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
@@ -39,6 +46,7 @@ struct eud_chip {
 	int				irq;
 	bool				enabled;
 	bool				usb_attached;
+	phys_addr_t			secure_mode_mgr;
 };
 
 static int enable_eud(struct eud_chip *priv)
@@ -46,7 +54,11 @@ static int enable_eud(struct eud_chip *priv)
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
@@ -54,7 +66,11 @@ static int enable_eud(struct eud_chip *priv)
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
@@ -175,9 +191,37 @@ static void eud_role_switch_release(void *data)
 	usb_role_switch_put(chip->role_sw);
 }
 
+static int eud_find_secure_reg_addr(struct device *dev, u64 *addr)
+{
+	struct device_node *tcsr;
+	struct device_node *np = dev->of_node;
+	struct resource res;
+	u32 offset;
+	int ret;
+
+	tcsr = of_parse_phandle(np, "qcom,secure-eud-reg", 0);
+	if (!tcsr)
+		return 0;
+
+	ret = of_address_to_resource(tcsr, 0, &res);
+	of_node_put(tcsr);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(np, "qcom,secure-eud-reg", 1, &offset);
+	if (ret < 0)
+		return ret;
+
+	*addr = res.start + offset;
+
+	return 0;
+}
+
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
+	phys_addr_t tcsr_check = 0;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -200,9 +244,30 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	/*
+	 * EUD block on a few Qualcomm SoCs needs secure register access.
+	 * Check for the same via vendor-specific dt property.
+	 */
+	ret = eud_find_secure_reg_addr(&pdev->dev, &tcsr_check);
+	if (ret < 0)
+		return ret;
+
+	if (tcsr_check) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get secure_mode_mgr reg base\n");
+
+		chip->secure_mode_mgr = res->start;
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
@@ -230,6 +295,7 @@ static void eud_remove(struct platform_device *pdev)
 
 static const struct of_device_id eud_dt_match[] = {
 	{ .compatible = "qcom,sc7280-eud" },
+	{ .compatible = "qcom,sm6115-eud" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eud_dt_match);
-- 
2.38.1

