Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E882977A76B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjHMP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHMP1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:27:04 -0400
Received: from out-73.mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B3170C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:26:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1691940417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjSZAQLAbmApo8nRZBSOQV7jJl0PWK6IV0REqbLJEbQ=;
        b=V5cmvrG4sTyUHO2eSk5GZ2qJlXgTdLzkIAosnevwwcdkVEugiFdE/QrJUQOBlhY0w7uKSZ
        nepxO0mS4Tv8uwvp/Vmof9yNFZ+XATPwoL0QX+G90UH1P+nF/sqChoMl9kOXVAsngDS1wH
        DSL+MZCM3AzL8nV6fo0CG/SJVmzu4GM=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        Jack Matthews <jm5112356@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/6] ARM: dts: qcom: add device tree for Microsoft Lumia 640
Date:   Sun, 13 Aug 2023 16:23:12 +0100
Message-ID: <20230813152623.64989-4-rayyan@ansari.sh>
In-Reply-To: <20230813152623.64989-1-rayyan@ansari.sh>
References: <20230813152623.64989-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an initial device tree for the Microsoft Lumia 640, codenamed
"dempsey".

Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>
Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Co-authored-by: Jack Matthews <jm5112356@gmail.com>
Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Signed-off-by: Jack Matthews <jm5112356@gmail.com>
Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm/boot/dts/qcom/Makefile                 |  1 +
 .../dts/qcom/qcom-msm8226-microsoft-dempsey.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-dempsey.dts

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index b2569059ce8d..13896c6974f6 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq4019-ap.dk07.1-c2.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-ipq8064-rb3011.dtb \
+	qcom-msm8226-microsoft-dempsey.dtb \
 	qcom-msm8226-microsoft-moneypenny.dtb \
 	qcom-msm8226-samsung-s3ve3g.dtb \
 	qcom-msm8660-surf.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-dempsey.dts b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-dempsey.dts
new file mode 100644
index 000000000000..2c664b5934ec
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-dempsey.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Jack Matthews <jm5112356@gmail.com>
+ * Copyright (c) 2023, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+ * Copyright (c) 2023, Dominik Kobinski <dominikkobinski314@gmail.com>
+ * Copyright (c) 2023, Rayyan Ansari <rayyan@ansari.sh>
+ */
+
+/dts-v1/;
+
+#include "qcom-msm8226-microsoft-common.dtsi"
+
+/ {
+	model = "Microsoft Lumia 640";
+	compatible = "microsoft,dempsey", "qcom,msm8226";
+	chassis-type = "handset";
+};
-- 
2.41.0

