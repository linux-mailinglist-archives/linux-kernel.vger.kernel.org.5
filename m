Return-Path: <linux-kernel+bounces-9192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BE81C220
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A311C21CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1473A79945;
	Thu, 21 Dec 2023 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJU5Dytp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E241C96;
	Thu, 21 Dec 2023 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3fe03b6b7so3478415ad.1;
        Thu, 21 Dec 2023 15:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703202614; x=1703807414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWD0Seqn+C4pMMZodPpqXRuromc9xBSV+i2Crj+WzE8=;
        b=SJU5Dytpzj3fVo7qgrdus9DE1WSEECmZp79oWrM8etVQ+vM9mBYPRu+ED2vv1n6jxG
         MG2kRkP7vnRR+9+i7pLSbXAEGgDB1zrPaCknogx9eLQ2tv3MtgTwywY/XVgXiYR1eyhI
         piCeX4AaIK/m9g9Jn7a5UmZhEf7T4V/YAnFAjP6H4zdkHA/UnWn3jD2S4hggNBM3wxnR
         sBho3wqoi0yGZaehURNDpsVmexnMmmC9Titjj+S2gBmswRRAFj4kuFm316vs52O/wbR6
         FpvOibDDZfMLfEXmtUND5P7YgUrDuiNg5+uaGVW530ZIoguHv8PNN/o5yJeye4WeQYv/
         OjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202614; x=1703807414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWD0Seqn+C4pMMZodPpqXRuromc9xBSV+i2Crj+WzE8=;
        b=Ol00YR4COTIFDv4SCZKq1ThB9Ms8e6uAiSKvA0fTOLRvIbW3G4IIQkARNJfwLn1SRv
         YlnM2lB64XXo83jqefTHUhlkot46amZ5gmPB+G1cjI8j4xgDc6S4aouJZSd9O7N6WFDh
         7+il3ehpZrgiK2QoxWyxi5bpLJ/wdKFw7rGFIP8wBbS3RVENmyVUVdFhdoUhXIkSf7DL
         FoVDd5W13RgCE8sKCkqgp/fmQZvDDGKYnSEl6SANycMROluoP6w2XuFJrw5KOnP+z/b3
         NU/nAXHXcjp/aLwfiao7w7IxjcnpvwMvWj//3b7KFDBrcsM6/kyYkNJ7JsGZxMeuYE0t
         Cm3w==
X-Gm-Message-State: AOJu0Yy7MoLHfXVHWgYeis+rlGLCMBa45e31FJC9/CI4RR5nuPVSGs/G
	3lZPKi4kddQzq87cFRIlVDsL8q17EH0=
X-Google-Smtp-Source: AGHT+IHrE41MOMPtngw4cPoeH5P9m+8nCSlviTr7ecIa4eSYcRTgPf2Oby0qGLjbRgYq+bnjB3rwxw==
X-Received: by 2002:a17:903:244e:b0:1d3:e7cc:e2a6 with SMTP id l14-20020a170903244e00b001d3e7cce2a6mr927602pls.0.1703202614046;
        Thu, 21 Dec 2023 15:50:14 -0800 (PST)
Received: from olv-ct-22.c.googlers.com.com (255.176.125.34.bc.googleusercontent.com. [34.125.176.255])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001d1cd7e4ad2sm2232985pli.125.2023.12.21.15.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:50:13 -0800 (PST)
From: Chia-I Wu <olvaffe@gmail.com>
To: cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: revert back to PSCI PC mode for herobrine
Date: Thu, 21 Dec 2023 15:50:01 -0800
Message-ID: <20231221235010.3178415-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This effectively reverts 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add
power-domains for cpuidle states") for sc7280-herobrine.  Those devices
use the TF-A firmware and do not support the OSI mode.

v2: improved commit message

Fixes: 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for cpuidle states")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 .../boot/dts/qcom/sc7280-firmware-tfa.dtsi    | 107 ++++++++++++++++++
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   4 +-
 3 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi b/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
new file mode 100644
index 0000000000000..b3fc03da244d6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/*
+ * Devices that use SC7280 with TrustedFirmware-A
+ * need PSCI PC mode instead of the OSI mode provided
+ * by Qualcomm firmware.
+ */
+
+&CPU0 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU1 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU2 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU3 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU4 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU5 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU6 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU7 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+/delete-node/ &domain_idle_states;
+
+&idle_states {
+	CLUSTER_SLEEP_0: cluster-sleep-0 {
+		compatible = "arm,idle-state";
+		idle-state-name = "cluster-power-down";
+		arm,psci-suspend-param = <0x40003444>;
+		entry-latency-us = <3263>;
+		exit-latency-us = <6562>;
+		min-residency-us = <9926>;
+		local-timer-stop;
+	};
+};
+
+/delete-node/ &CPU_PD0;
+/delete-node/ &CPU_PD1;
+/delete-node/ &CPU_PD2;
+/delete-node/ &CPU_PD3;
+/delete-node/ &CPU_PD4;
+/delete-node/ &CPU_PD5;
+/delete-node/ &CPU_PD6;
+/delete-node/ &CPU_PD7;
+/delete-node/ &CLUSTER_PD;
+
+&apps_rsc {
+	/delete-property/ power-domains;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9ea6636125ad9..09b2d370bf7e0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -19,6 +19,7 @@
 
 #include "sc7280-qcard.dtsi"
 #include "sc7280-chrome-common.dtsi"
+#include "sc7280-firmware-tfa.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 66f1eb83cca7e..354bf2868eba6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -383,7 +383,7 @@ core7 {
 			};
 		};
 
-		idle-states {
+		idle_states: idle-states {
 			entry-method = "psci";
 
 			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
@@ -427,7 +427,7 @@ BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 			};
 		};
 
-		domain-idle-states {
+		domain_idle_states: domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
 				idle-state-name = "cluster-power-down";
-- 
2.43.0.195.gebba966016-goog


