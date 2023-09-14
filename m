Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999D7A024F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjINLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbjINLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:18:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5892113
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502e0b7875dso1439495e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690276; x=1695295076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0VQhcoNLNdF2hx3KPbex70/0qm7FIzVv2M9Uuzf9Fw=;
        b=UI2/jrQExavD+yFADzOdKG84ojUmC3d+lagDmIGjgUlMWUs/v3C6kVD8X8fWbnnptc
         5TCsbYmwMB3ZxWkVlDc+O0UBqrsOwtjUhzpQlcND479rsJGTtJJ3KFn8pbxfC6+ntLYx
         fyOtFYYG/vU1XcS+9L0s4pK1w1HmLp2+quXlv6eNo7hivW2fxVrqd9FbqRIDH3SXDXxC
         DdmoLW5uJ5gCHMcTkz+yALuYKKw59UFLi+TNgLDEMGr0kOn7MrCrKwELO3F9XRx2L5OH
         ocOImPRVvmnEpKuNpD/fqIgYrYsr2vMeMTGobzZT6is5tnVqOaO1ZUcgmyNA/LJ7s93Z
         wEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690276; x=1695295076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0VQhcoNLNdF2hx3KPbex70/0qm7FIzVv2M9Uuzf9Fw=;
        b=T7wbRXmENdkQvlec4PQe6axWhZw0EUIhNxmJK9IP2dPvy+vbMMlipkaD7Gzp/kBJ/C
         V+XJh578cTwQKJsTgXzLrI9PtiZYa2HS9fefiEWq2J7Zzpv39zKIawYEXoi3Foa+RCpd
         +p5uYRFPmgGfdXpDNg0Zu4vPAPkHT21lcRBe+hsERreRzIQPNLsww54fFCy9SgoXPLVC
         CMWNkaGrHBnZ1xiuC+KJ7WKFccgBAv7syrifvSzhoEwGRUX0Kr61ocEAaSykT6RU6Ewo
         4vHIRy+iqHYS28REuVf0aLkVPhrwHArUMBQIRnZ3zYAUzDZsfDfoNlpN/zqf43kpSWVm
         eUeA==
X-Gm-Message-State: AOJu0YxjEKqqDYkbvuVABYU1JxMhCUgMtAu3rluUuaoE5o40nfpIUQu+
        DcxKc5mYyXj2MxfVBToI+0dAfQ==
X-Google-Smtp-Source: AGHT+IFzbzNrbUhVTufPQvnBjGY+RhRHGIrGu01HNr1LOR9JVppeqQfxnWwuIVvHuE5VImtOF16wYA==
X-Received: by 2002:a05:6512:3e26:b0:500:9524:f733 with SMTP id i38-20020a0565123e2600b005009524f733mr4664580lfv.20.1694690275954;
        Thu, 14 Sep 2023 04:17:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d27-20020ac25edb000000b0050234d02e64sm240423lfq.15.2023.09.14.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:17:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 08/17] pmdomain: qcom: Move Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:17:53 +0200
Message-Id: <20230914111753.586627-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig      |  1 +
 drivers/pmdomain/qcom/Kconfig | 41 +++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/Kconfig      | 37 -------------------------------
 3 files changed, 42 insertions(+), 37 deletions(-)
 create mode 100644 drivers/pmdomain/qcom/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 5929f2d31588..d7b554c5c384 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -7,5 +7,6 @@ source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
+source "drivers/pmdomain/qcom/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/qcom/Kconfig b/drivers/pmdomain/qcom/Kconfig
new file mode 100644
index 000000000000..c67308337805
--- /dev/null
+++ b/drivers/pmdomain/qcom/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Qualcomm Power Domains"
+
+config QCOM_CPR
+	tristate "QCOM Core Power Reduction (CPR) support"
+	depends on ARCH_QCOM && HAS_IOMEM
+	select PM_OPP
+	select REGMAP
+	help
+	  Say Y here to enable support for the CPR hardware found on Qualcomm
+	  SoCs like QCS404.
+
+	  This driver populates CPU OPPs tables and makes adjustments to the
+	  tables based on feedback from the CPR hardware. If you want to do
+	  CPUfrequency scaling say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called qcom-cpr
+
+config QCOM_RPMHPD
+	tristate "Qualcomm RPMh Power domain driver"
+	depends on QCOM_RPMH && QCOM_COMMAND_DB
+	help
+	  QCOM RPMh Power domain driver to support power-domains with
+	  performance states. The driver communicates a performance state
+	  value to RPMh which then translates it into corresponding voltage
+	  for the voltage rail.
+
+config QCOM_RPMPD
+	tristate "Qualcomm RPM Power domain driver"
+	depends on PM && OF
+	depends on QCOM_SMD_RPM
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  QCOM RPM Power domain driver to support power-domains with
+	  performance states. The driver communicates a performance state
+	  value to RPM which then translates it into corresponding voltage
+	  for the voltage rail.
+
+endmenu
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 715348869d04..b3634e10f6f5 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -26,22 +26,6 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
-config QCOM_CPR
-	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on ARCH_QCOM && HAS_IOMEM
-	select PM_OPP
-	select REGMAP
-	help
-	  Say Y here to enable support for the CPR hardware found on Qualcomm
-	  SoCs like QCS404.
-
-	  This driver populates CPU OPPs tables and makes adjustments to the
-	  tables based on feedback from the CPR hardware. If you want to do
-	  CPUfrequency scaling say Y here.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called qcom-cpr
-
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
@@ -157,27 +141,6 @@ config QCOM_RPMH
 	  of hardware components aggregate requests for these resources and
 	  help apply the aggregated state on the resource.
 
-config QCOM_RPMHPD
-	tristate "Qualcomm RPMh Power domain driver"
-	depends on QCOM_RPMH && QCOM_COMMAND_DB
-	help
-	  QCOM RPMh Power domain driver to support power-domains with
-	  performance states. The driver communicates a performance state
-	  value to RPMh which then translates it into corresponding voltage
-	  for the voltage rail.
-
-config QCOM_RPMPD
-	tristate "Qualcomm RPM Power domain driver"
-	depends on PM && OF
-	depends on QCOM_SMD_RPM
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  QCOM RPM Power domain driver to support power-domains with
-	  performance states. The driver communicates a performance state
-	  value to RPM which then translates it into corresponding voltage
-	  for the voltage rail.
-
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM || COMPILE_TEST
-- 
2.34.1

