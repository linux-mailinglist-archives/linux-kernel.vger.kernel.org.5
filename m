Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705B47F1D70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjKTTlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKTTlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:41:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED391;
        Mon, 20 Nov 2023 11:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700509268; x=1732045268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cwIrP8xSl17q1ERD81V8W8TIDeksLzSBAeCjh3kGnLY=;
  b=DNMpM+4Lkw3KYtjcBvsTV9Ht0vAU4044QxcTBkJ8YAz0M2Wd3bMMyRUx
   N5smE6/GxVnaUJ3/g5ENeSf6p4iHIdQO8CC/KKc8AKkg+OTktQ469HwFo
   pmqwJzY/buxTeat/X3Ir6aVhzD13m9f9qL9nFaMLoV5mqYmjcb6Z5Gdsn
   8fdO6kxIcvBWWMQq1o3HW0TcasHvhswsSSg+3/M34oyTcjIBBDWM2+S9Y
   S8g6yJImf6j0paWr5dbjouiKGFEh4LwMT8LKOllOhYyMscvI3+5xOgM+F
   HkHCmByMmKe3EOp4Dv58qTQufvHzqPpHVNAB+OvbWh++0e8y/dE3fMSr3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376727999"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="376727999"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 11:41:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="795562857"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="795562857"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2023 11:41:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D21936B; Mon, 20 Nov 2023 21:33:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [rft, PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove unused member in struct lpi_pingroup
Date:   Mon, 20 Nov 2023 21:26:08 +0200
Message-ID: <20231120193353.1670732-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The group is not used anywhere, remove it. And if needed, it should be
struct pingroup anyway.

While at it, replace kernel.h with what exactly being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

_Seems_ like this (I only read the code), hence rft.

 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h      |  6 +----
 .../pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   | 16 -------------
 .../pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c | 20 ----------------
 .../pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c   | 20 ----------------
 .../pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c   | 15 ------------
 .../pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 16 -------------
 .../pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c   | 24 -------------------
 7 files changed, 1 insertion(+), 116 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
index 206b2c0ca828..a9b2f65c1ebe 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
@@ -6,8 +6,8 @@
 #ifndef __PINCTRL_LPASS_LPI_H__
 #define __PINCTRL_LPASS_LPI_H__
 
+#include <linux/array_size.h>
 #include <linux/bits.h>
-#include <linux/kernel.h>
 
 #include "../core.h"
 
@@ -45,11 +45,8 @@ struct pinctrl_pin_desc;
 
 #define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
 	{						\
-		.group.name = "gpio" #id,			\
-		.group.pins = gpio##id##_pins,		\
 		.pin = id,				\
 		.slew_offset = soff,			\
-		.group.num_pins = ARRAY_SIZE(gpio##id##_pins),	\
 		.funcs = (int[]){			\
 			LPI_MUX_gpio,			\
 			LPI_MUX_##f1,			\
@@ -67,7 +64,6 @@ struct pinctrl_pin_desc;
 #define LPI_FLAG_SLEW_RATE_SAME_REG			BIT(0)
 
 struct lpi_pingroup {
-	struct group_desc group;
 	unsigned int pin;
 	/* Bit offset in slew register for SoundWire pins only */
 	int slew_offset;
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index 99156217c6a5..6bb39812e1d8 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -36,22 +36,6 @@ enum lpass_lpi_functions {
 	LPI_MUX__,
 };
 
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static int gpio14_pins[] = { 14 };
-
 static const struct pinctrl_pin_desc sc7280_lpi_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
diff --git a/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
index b33483056f42..c0369baf3398 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
@@ -45,26 +45,6 @@ enum lpass_lpi_functions {
 	LPI_MUX__,
 };
 
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static int gpio14_pins[] = { 14 };
-static int gpio15_pins[] = { 15 };
-static int gpio16_pins[] = { 16 };
-static int gpio17_pins[] = { 17 };
-static int gpio18_pins[] = { 18 };
-
 static const struct pinctrl_pin_desc sc8280xp_lpi_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
index e8a6f6f6af54..316d6fc69131 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
@@ -36,26 +36,6 @@ enum lpass_lpi_functions {
 	LPI_MUX__,
 };
 
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static int gpio14_pins[] = { 14 };
-static int gpio15_pins[] = { 15 };
-static int gpio16_pins[] = { 16 };
-static int gpio17_pins[] = { 17 };
-static int gpio18_pins[] = { 18 };
-
 static const struct pinctrl_pin_desc sm6115_lpi_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
index cb10ce8d5d28..9791d9ba5087 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
@@ -36,21 +36,6 @@ enum lpass_lpi_functions {
 	LPI_MUX__,
 };
 
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-
 static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
index 297cc95ac3c0..5b9a2cb216bd 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
@@ -36,22 +36,6 @@ enum lpass_lpi_functions {
 	LPI_MUX__,
 };
 
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static int gpio14_pins[] = { 14 };
-
 static const struct pinctrl_pin_desc sm8350_lpi_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
index 2e7896791fc0..a028cbb49947 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
@@ -52,30 +52,6 @@ enum lpass_lpi_functions {
 	LPI_MUX__,
 };
 
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static int gpio14_pins[] = { 14 };
-static int gpio15_pins[] = { 15 };
-static int gpio16_pins[] = { 16 };
-static int gpio17_pins[] = { 17 };
-static int gpio18_pins[] = { 18 };
-static int gpio19_pins[] = { 19 };
-static int gpio20_pins[] = { 20 };
-static int gpio21_pins[] = { 21 };
-static int gpio22_pins[] = { 22 };
-
 static const struct pinctrl_pin_desc sm8450_lpi_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
-- 
2.43.0.rc1.1.gbec44491f096

