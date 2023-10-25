Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897A17D6958
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjJYKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjJYKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:45:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A203132;
        Wed, 25 Oct 2023 03:45:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso8544680a12.3;
        Wed, 25 Oct 2023 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698230702; x=1698835502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6esSzcgffSka4qrRFDqhwYHqVtJjmpE8kipUoxPN9Z4=;
        b=hFEjF4nbPVd/18u1QyV+LGqIXrWWXrUxJHAgL6I9T9jmvnNWh37q/1Kr/aDTemHv9U
         yfiawR/Rq+lDV7xRa2ASf2vIKFAN28tqV73qvTigmDPw5IVwp9W1GIsUib2spmZZekcH
         Ihn/KGlOQwIWGRRusxvA4PIRBi6gVo0OyimhAOKGMU/BbcESBGrACl2zC1TSs070xOR5
         rWPnum/+yGwBFDGqe6RiMxvoLQNgp5wsmH+NVpr9S9wkHA8NqIfBndlp78MNWkRmTzP4
         iAkuHLvLYkggwaRAkd0h98U29vLf1j7yvFKgPj7t8bfjMytn+cQYCdnvHFfcta7Tz8Ki
         E0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230702; x=1698835502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6esSzcgffSka4qrRFDqhwYHqVtJjmpE8kipUoxPN9Z4=;
        b=BgEWyX00WamPdniLPwLlqOMwSC9lrvaxOys55EixbQ7mZX0N5aPj19gywZBesF2PzN
         e4pIVOMuV/UsHBwTukoq5I4QlcWPZ1gXQU7geC7mEFNDlfnsma1LzdJMdOdAfigN0dB2
         gX0znZxvcjD3I0qXuBIdjZPzy7ANq1kdtZCxor7ZBwv6GB4Q0ss1S7e/dKnTyE2NQPae
         d+zwCfwlgtDoGvW9znEFQk0Yhkj8r+iJsj2bPjJttv17nMDdvqAHrHpm7IwHPnUb3xJp
         RoTYCW4IQu+9EbpPE9cTjawqMlLG9/NmVWTT3zL14haYHESTe0W/TNa0DQ9A1Y64W4/e
         lH2g==
X-Gm-Message-State: AOJu0YwQOGgYsJ5T0tZMHTtr5c1rx36C4MYbgJd6ijhPsqoCRaDPCxOE
        i3PxBFBFi5rk3eDSDanjrWA=
X-Google-Smtp-Source: AGHT+IHlVSCIv2/e+AGd9vK/u4tmuy5rxvIBQ3v6CFdi9Vqs5/M/OB0Iws7GcCAwI+4bydHmrcRLgw==
X-Received: by 2002:a17:907:6eaa:b0:9c4:b8c9:1bf4 with SMTP id sh42-20020a1709076eaa00b009c4b8c91bf4mr14206819ejc.19.1698230702080;
        Wed, 25 Oct 2023 03:45:02 -0700 (PDT)
Received: from fedora.. (dh207-97-46.xnet.hr. [88.207.97.46])
        by smtp.googlemail.com with ESMTPSA id t11-20020a1709066bcb00b009be14e5cd54sm9626292ejs.57.2023.10.25.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:45:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/3] clk: qcom: ipq6018: add USB GDSCs
Date:   Wed, 25 Oct 2023 12:44:10 +0200
Message-ID: <20231025104457.628109-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025104457.628109-1-robimarko@gmail.com>
References: <20231025104457.628109-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 has GDSC-s for each of the USB ports, so lets define them as such
and drop the curent code that is de-asserting the USB GDSC-s as part of
the GCC probe.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/Kconfig       |  1 +
 drivers/clk/qcom/gcc-ipq6018.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ad1acd9b7426b..2aefa2231b51b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -164,6 +164,7 @@ config IPQ_GCC_5332
 
 config IPQ_GCC_6018
 	tristate "IPQ6018 Global Clock Controller"
+	select QCOM_GDSC
 	help
 	  Support for global clock controller on ipq6018 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index cc20a16d8973c..9d5ee2ac012a1 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -23,6 +23,7 @@
 #include "clk-alpha-pll.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "gdsc.h"
 #include "reset.h"
 
 enum {
@@ -4691,6 +4692,22 @@ static struct clk_branch gcc_dcc_clk = {
 	},
 };
 
+static struct gdsc usb0_gdsc = {
+	.gdscr = 0x3e078,
+	.pd = {
+		.name = "usb0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc usb1_gdsc = {
+	.gdscr = 0x3f078,
+	.pd = {
+		.name = "usb1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static const struct alpha_pll_config ubi32_pll_config = {
 	.l = 0x3e,
 	.alpha = 0x6667,
@@ -5138,6 +5155,11 @@ static const struct qcom_reset_map gcc_ipq6018_resets[] = {
 	[GCC_Q6_AXIM_ARES] = {0x59110, 4},
 };
 
+static struct gdsc *gcc_ipq6018_gdscs[] = {
+	[USB0_GDSC] = &usb0_gdsc,
+	[USB1_GDSC] = &usb1_gdsc,
+};
+
 static const struct of_device_id gcc_ipq6018_match_table[] = {
 	{ .compatible = "qcom,gcc-ipq6018" },
 	{ }
@@ -5160,6 +5182,8 @@ static const struct qcom_cc_desc gcc_ipq6018_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq6018_resets),
 	.clk_hws = gcc_ipq6018_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq6018_hws),
+	.gdscs = gcc_ipq6018_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_ipq6018_gdscs),
 };
 
 static int gcc_ipq6018_probe(struct platform_device *pdev)
@@ -5170,15 +5194,6 @@ static int gcc_ipq6018_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/* Disable SW_COLLAPSE for USB0 GDSCR */
-	regmap_update_bits(regmap, 0x3e078, BIT(0), 0x0);
-	/* Enable SW_OVERRIDE for USB0 GDSCR */
-	regmap_update_bits(regmap, 0x3e078, BIT(2), BIT(2));
-	/* Disable SW_COLLAPSE for USB1 GDSCR */
-	regmap_update_bits(regmap, 0x3f078, BIT(0), 0x0);
-	/* Enable SW_OVERRIDE for USB1 GDSCR */
-	regmap_update_bits(regmap, 0x3f078, BIT(2), BIT(2));
-
 	/* SW Workaround for UBI Huyara PLL */
 	regmap_update_bits(regmap, 0x2501c, BIT(26), BIT(26));
 
-- 
2.41.0

