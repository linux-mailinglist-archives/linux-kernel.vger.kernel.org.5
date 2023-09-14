Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B87A0254
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjINLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjINLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:18:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCC212B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:18:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50078eba7afso1404058e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690304; x=1695295104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxUofEX7JvW4d1sce0CQyOiNxdylns5iYNZqQoeIs6k=;
        b=jt2dV+xCcdsHan5nRusfwoJ2jmHu2siafSZKt52McWqoJyFf5L/I6uL12536fu2trV
         zfSXXW86lz62V5ed3JYSmxQ0jpivpOGB/Uo/3VPQ+zZHzMq4hChJp8VTj4VZnfM79/bm
         cMpUtAv+eq6ysfzY9ByNyxS2fZ5+gveqftCF7UvPJofuIpbez2+Y27WAhbeI2lXU+Pia
         wiCIgQVxPT9MVS4qm8JUzhexDWMznxMkDifQYVrN7mCTnpkM68NHq+5Bjst99khUDKX9
         +9h9MZP02GlNARGn3dq88xuzLteLfhxNXzARlHRcGO7a3UeaV7qqTvt04FE2TjkwZ1HG
         oQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690304; x=1695295104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxUofEX7JvW4d1sce0CQyOiNxdylns5iYNZqQoeIs6k=;
        b=xTBXqBfl62AChVs2rv3maPdA4p9saKWTbir1H6ArNXHVKQ309kiT8is+y7NcksYPPo
         7PCuaX7NrkQahFuewbEOh42dTkYroMDuL7ZZxW1Btx3o1J0Zfo0tARPvTDVguTPQdAI9
         LN7S2T1NA7UVlptX+RYreqgY8sn3wtUcrC2y1o/Z7Hrt63wfr2Apso+WTtOt0ieFL5vH
         Wn4BttZF2qQ3pm5sZDc1jAhHChZvZ0+7vWqrN5JQR7ZqJRIHBwHF6zxzgpu9It6msGhS
         K2xU+U+ong+2aO6ZC4LtMxuyZCVDwhL1juGtTogC7lw0XH+99pCb11xZi0qXcStfLHZM
         UEtQ==
X-Gm-Message-State: AOJu0YwtoGjrIufIki7lgniJuD8IDjg3Ac2JmHWpm7pg9VSPiahQdIEI
        fiUpXAu7jJZcKfz8zyVxETxsNQ==
X-Google-Smtp-Source: AGHT+IECyQHUqtnFN9/j9xE0JHalnzMd/YBsRnoVECOTPF6IR0x4USQA3KdxsBpACd9No4jnwUmqcA==
X-Received: by 2002:a05:6512:20cc:b0:500:bfcb:1bf6 with SMTP id u12-20020a05651220cc00b00500bfcb1bf6mr3670193lfr.57.1694690303682;
        Thu, 14 Sep 2023 04:18:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id r10-20020ac252aa000000b004fb9c625b4asm231711lfm.210.2023.09.14.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:18:23 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 11/17] pmdomain: samsung: Move Kconfig option to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:18:19 +0200
Message-Id: <20230914111819.586688-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig         | 1 +
 drivers/pmdomain/samsung/Kconfig | 8 ++++++++
 drivers/soc/samsung/Kconfig      | 4 ----
 3 files changed, 9 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pmdomain/samsung/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 74066c5daa37..1e2c5f531638 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -10,5 +10,6 @@ source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
+source "drivers/pmdomain/samsung/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/samsung/Kconfig b/drivers/pmdomain/samsung/Kconfig
new file mode 100644
index 000000000000..0debfe36b00a
--- /dev/null
+++ b/drivers/pmdomain/samsung/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+if SOC_SAMSUNG
+
+config EXYNOS_PM_DOMAINS
+	bool "Exynos PM domains" if COMPILE_TEST
+	depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
+
+endif
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 7a8f291e7704..27ec99af77e3 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -48,10 +48,6 @@ config EXYNOS_PMU_ARM_DRIVERS
 	bool "Exynos PMU ARMv7-specific driver extensions" if COMPILE_TEST
 	depends on EXYNOS_PMU
 
-config EXYNOS_PM_DOMAINS
-	bool "Exynos PM domains" if COMPILE_TEST
-	depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
-
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
 	depends on PM && (ARCH_S3C64XX || ARCH_S5PV210)
-- 
2.34.1

