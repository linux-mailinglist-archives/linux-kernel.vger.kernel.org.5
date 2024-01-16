Return-Path: <linux-kernel+bounces-27916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804BF82F7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4A1F25E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBBB23754;
	Tue, 16 Jan 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3XuQ87A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21B23755;
	Tue, 16 Jan 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434581; cv=none; b=m066INPrsIj+fKJfKuIbxBINsP8BKW7WcxHjPf0s5U2XUcZAEfXNBMggisvXy9LwxgH6vNpBPYydsa1pQ17Z8NREH1kANywuc3j0hj5kuLhOe+Kiqfxcx43UaU7vc0SBPhYhSRq84WuWf8/0GaHQg6Yiw57GvRZ0hKgFG78dVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434581; c=relaxed/simple;
	bh=+UJWIP4sIIHNnSIgUjVDGzFwOL2oMirSDv1gutfKvms=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=NxTti/FdxWFDsgl1/l3szzPvE1jQxzKPnAsdSYUdDAWAWJCP6DD8eGSY37laPPNo78rvIIUr0rF8K3JJo8BKlwy+c/t0PhpGX5Fg6tjVpizDiVT7bdkP15GJnGfm/pkXwWu5Wa468l8rXgkdGYDJnhzJDmzdejfRT7+Pdq50oVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3XuQ87A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66398C433F1;
	Tue, 16 Jan 2024 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434580;
	bh=+UJWIP4sIIHNnSIgUjVDGzFwOL2oMirSDv1gutfKvms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3XuQ87AwD+WdRCTXpoAHot1j6TIeNXciWWlpkHcsKcRFWwrAZxt2iOL1NYaEoKyX
	 +5Ovp+i1TQjLsR1/K1zRa1QJaRqAS2osRR58NsMNdjIEPQrdxFY6q33DpgHNdPpPWN
	 DiEyv8SEMHDH8JR0SB/lnnWP2prhIv7X3ulfIEHIQ7KXYeHK+VCsjmED1RCS0O3jGC
	 vFBMhkYhEgJbtV0V2nl2+9WQlqQgw4pXKON8HQtkrd7EV4xeUc5J44PIMBz/Bro/2F
	 n7jmfs2DABm1sTQfpAM3mbEr1acNFQ0MNgAUDcFCbOtNmo1FkncpNl2VzWlvZg/t4Y
	 UK6z/Ggv9u1nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 009/104] ARM: dts: qcom: strip prefix from PMIC files
Date: Tue, 16 Jan 2024 14:45:35 -0500
Message-ID: <20240116194908.253437-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 455a4c46e023ab84263eae0fc7acca9a5ee8b7ac ]

As the vendor DTS files were moved to per-vendor subdirs, there no need
to use common prefixes. Drop the `qcom-' prefix from PMIC dtsi file.
This makes 32-bit qcom/ dts files closer to arm64 ones.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230928110309.1212221-8-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/{qcom-pm8226.dtsi => pm8226.dtsi}      | 0
 arch/arm/boot/dts/qcom/{qcom-pm8841.dtsi => pm8841.dtsi}      | 0
 arch/arm/boot/dts/qcom/{qcom-pm8941.dtsi => pm8941.dtsi}      | 0
 arch/arm/boot/dts/qcom/{qcom-pma8084.dtsi => pma8084.dtsi}    | 0
 arch/arm/boot/dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi}        | 0
 arch/arm/boot/dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi}        | 0
 arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts          | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts       | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts              | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts  | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts           | 4 ++--
 arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts               | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts                   | 2 +-
 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi    | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts      | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts      | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts       | 2 +-
 .../dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts   | 4 ++--
 arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts                     | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts                     | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts         | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts                     | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)
 rename arch/arm/boot/dts/qcom/{qcom-pm8226.dtsi => pm8226.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pm8841.dtsi => pm8841.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pm8941.dtsi => pm8941.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pma8084.dtsi => pma8084.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi} (100%)

diff --git a/arch/arm/boot/dts/qcom/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom/pm8226.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pm8226.dtsi
rename to arch/arm/boot/dts/qcom/pm8226.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom/pm8841.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pm8841.dtsi
rename to arch/arm/boot/dts/qcom/pm8841.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom/pm8941.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pm8941.dtsi
rename to arch/arm/boot/dts/qcom/pm8941.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pma8084.dtsi
rename to arch/arm/boot/dts/qcom/pma8084.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom/pmx55.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pmx55.dtsi
rename to arch/arm/boot/dts/qcom/pmx55.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pmx65.dtsi b/arch/arm/boot/dts/qcom/pmx65.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pmx65.dtsi
rename to arch/arm/boot/dts/qcom/pmx65.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
index aa0e0e8d2a97..a39f5a161b03 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 
 /delete-node/ &adsp_region;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
index de19640efe55..59b218042d32 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 #include <dt-bindings/input/ti-drv260x.h>
 
 /delete-node/ &adsp_region;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
index b887e5361ec3..feb78afef3a6 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 
 /delete-node/ &adsp_region;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
index f516e0426bb9..cffc069712b2 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
@@ -7,7 +7,7 @@
 
 #include <dt-bindings/input/input.h>
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 
 /delete-node/ &adsp_region;
 /delete-node/ &smem_region;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
index 6d1b2439ae3a..950fa652f985 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
@@ -4,8 +4,8 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "qcom-msm8974.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 
 /delete-node/ &mpss_region;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
index 116e59a3b76d..1df24c922be9 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-apq8084.dtsi"
-#include "qcom-pma8084.dtsi"
+#include "pma8084.dtsi"
 
 / {
 	model = "Qualcomm APQ8084/IFC6540";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts b/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
index c6b6680248a6..d4e6aee034af 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-apq8084.dtsi"
-#include "qcom-pma8084.dtsi"
+#include "pma8084.dtsi"
 
 / {
 	model = "Qualcomm APQ 8084-MTP";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
index 60bdfddeae69..da99f770d4f5 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
index 68a2f9094e53..23ae474698aa 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
index 42d253b75dad..6c4153689b39 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
index 8230d0e1d95d..c0ca264d8140 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
index 3e2c86591ee2..325feb89b343 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pma8084.dtsi"
+#include "pma8084.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/leds/common.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 11468d1409f7..0798cce3dbea 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
index 7e97ad5803d8..247069361909 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
@@ -9,7 +9,7 @@
 #include "qcom-sdx55.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pm8150b.dtsi>
-#include "qcom-pmx55.dtsi"
+#include "pmx55.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX55 MTP";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
index 51058b065279..082f7ed1a01f 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
@@ -8,7 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "qcom-sdx55.dtsi"
-#include "qcom-pmx55.dtsi"
+#include "pmx55.dtsi"
 
 / {
 	model = "Thundercomm T55 Development Kit";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
index 8fadc6e70692..e336a15b45c4 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
@@ -8,7 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "qcom-sdx55.dtsi"
-#include "qcom-pmx55.dtsi"
+#include "pmx55.dtsi"
 
 / {
 	model = "Telit FN980 TLB";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
index fcf1c51c5e7a..b87c5434cc29 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
@@ -8,7 +8,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pmk8350.dtsi>
 #include <arm64/qcom/pm7250b.dtsi>
-#include "qcom-pmx65.dtsi"
+#include "pmx65.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX65 MTP";
-- 
2.43.0


