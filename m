Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963F7A0252
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjINLSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjINLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:18:10 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED852101
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:18:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bfc2b26437so12194631fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690285; x=1695295085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w6tggu3w0rnURlQWc2TjYOylJS7t75MUFO6fIbxQowU=;
        b=xgHp/SHvYIO414qHUQ4ByVJKxM8dlkynGgzmmWVpXTDfOYLc/FOktPIT6Oc6eWFg9W
         noqE8bL3WWv/0Bb4wb1+HlmkZgVES0kKpnXKk4/lq/+CHq0zs1lMHJo/w0U4016YamXM
         V3spEJRp6RpqjRH7LlIZibpPQ0Oz3VV7mLXcHTMJM9ltilR2rIoAOnXOH91lES1rTM0N
         r+eVPFIu120858EFpcGaKcnsd9lQmbVhR/ajwx0tNp6wdocCHcdmepUp6QlAft8kVTui
         u/9u0KxbNvPZGVo8JDjSPG7RXB8xaBWBQ71xO37Gl7uGnC7os/ic6nuhLderreqENqrF
         aPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690285; x=1695295085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6tggu3w0rnURlQWc2TjYOylJS7t75MUFO6fIbxQowU=;
        b=ck16skmZ4CAkhBuTt0VeWV808kQmqDPVqzahgk5dzjVdB2tjyKxLP4jDPnHNgh/AKD
         zi+lo3a3Hq1SkWmpN1bOfhRkb5b7DxZ04cjtCDjmqRx5cXW3iBQSoNv9SdtLcU28x41N
         GuykMfYH6qYE99znH5NdJyYUBzNmIlrDi2ikLV7y06gkKGz34RDvSb/muNqfCLTIQoAO
         wzrwmwef4Rp5ygzdbsK24D75zLhDuba9578C0w2E9IS4EJFmO1iVtOF7ytXuOicoTQe6
         pZUB3uh02oZ50DKy+pesxL+LYfLRHdfaMk1xlZp1E75UmLtkS9g3Evi2A8A+a/ovef4K
         Soow==
X-Gm-Message-State: AOJu0YyKlJNB2WmkQPaXvoawfrxNBl9RbmEO9tb91iRszEAnzkyobZcw
        NpS+iIUCrO2wk9RunEbPaDVeUQ==
X-Google-Smtp-Source: AGHT+IFFVQfYZxgU51JniE1rKigE/3fz3t0WhNHu29fyri1xMYFqe7wzn52XOTD5PaH+1d9DT+vqDA==
X-Received: by 2002:a2e:90c6:0:b0:2bb:97af:f37a with SMTP id o6-20020a2e90c6000000b002bb97aff37amr5113252ljg.28.1694690284896;
        Thu, 14 Sep 2023 04:18:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p19-20020a2e9a93000000b002b70a64d4desm241807lji.46.2023.09.14.04.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:18:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 09/17] pmdomain: renesas: Move Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:18:01 +0200
Message-Id: <20230914111801.586648-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: <linux-renesas-soc@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig         |   1 +
 drivers/pmdomain/renesas/Kconfig | 109 +++++++++++++++++++++++++++++++
 drivers/soc/renesas/Kconfig      | 105 -----------------------------
 3 files changed, 110 insertions(+), 105 deletions(-)
 create mode 100644 drivers/pmdomain/renesas/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index d7b554c5c384..e8181782751c 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -8,5 +8,6 @@ source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
+source "drivers/pmdomain/renesas/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
new file mode 100644
index 000000000000..80bf2cf8b60e
--- /dev/null
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0
+if SOC_RENESAS
+
+config SYSC_RCAR
+	bool "System Controller support for R-Car" if COMPILE_TEST
+
+config SYSC_RCAR_GEN4
+	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
+
+config SYSC_R8A77995
+	bool "System Controller support for R-Car D3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7794
+	bool "System Controller support for R-Car E2" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77990
+	bool "System Controller support for R-Car E3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7779
+	bool "System Controller support for R-Car H1" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7790
+	bool "System Controller support for R-Car H2" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7795
+	bool "System Controller support for R-Car H3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7791
+	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77965
+	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77960
+	bool "System Controller support for R-Car M3-W" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77961
+	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A779F0
+	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A7792
+	bool "System Controller support for R-Car V2H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77980
+	bool "System Controller support for R-Car V3H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77970
+	bool "System Controller support for R-Car V3M" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A779A0
+	bool "System Controller support for R-Car V3U" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779G0
+	bool "System Controller support for R-Car V4H" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_RMOBILE
+	bool "System Controller support for R-Mobile" if COMPILE_TEST
+
+config SYSC_R8A77470
+	bool "System Controller support for RZ/G1C" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7745
+	bool "System Controller support for RZ/G1E" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7742
+	bool "System Controller support for RZ/G1H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7743
+	bool "System Controller support for RZ/G1M" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774C0
+	bool "System Controller support for RZ/G2E" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774E1
+	bool "System Controller support for RZ/G2H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774A1
+	bool "System Controller support for RZ/G2M" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774B1
+	bool "System Controller support for RZ/G2N" if COMPILE_TEST
+	select SYSC_RCAR
+
+endif
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5a75ab64d1ed..650f4dd96dec 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -350,109 +350,4 @@ config PWC_RZV2M
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
-config SYSC_RCAR
-	bool "System Controller support for R-Car" if COMPILE_TEST
-
-config SYSC_RCAR_GEN4
-	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
-
-config SYSC_R8A77995
-	bool "System Controller support for R-Car D3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7794
-	bool "System Controller support for R-Car E2" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77990
-	bool "System Controller support for R-Car E3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7779
-	bool "System Controller support for R-Car H1" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7790
-	bool "System Controller support for R-Car H2" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7795
-	bool "System Controller support for R-Car H3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7791
-	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77965
-	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77960
-	bool "System Controller support for R-Car M3-W" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77961
-	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A779F0
-	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A7792
-	bool "System Controller support for R-Car V2H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77980
-	bool "System Controller support for R-Car V3H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77970
-	bool "System Controller support for R-Car V3M" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A779A0
-	bool "System Controller support for R-Car V3U" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A779G0
-	bool "System Controller support for R-Car V4H" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_RMOBILE
-	bool "System Controller support for R-Mobile" if COMPILE_TEST
-
-config SYSC_R8A77470
-	bool "System Controller support for RZ/G1C" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7745
-	bool "System Controller support for RZ/G1E" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7742
-	bool "System Controller support for RZ/G1H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7743
-	bool "System Controller support for RZ/G1M" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774C0
-	bool "System Controller support for RZ/G2E" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774E1
-	bool "System Controller support for RZ/G2H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774A1
-	bool "System Controller support for RZ/G2M" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774B1
-	bool "System Controller support for RZ/G2N" if COMPILE_TEST
-	select SYSC_RCAR
-
 endif # SOC_RENESAS
-- 
2.34.1

