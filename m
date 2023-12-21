Return-Path: <linux-kernel+bounces-9100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496E81C073
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9211BB2139E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D976DD9;
	Thu, 21 Dec 2023 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDxOhkzO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545676DB6;
	Thu, 21 Dec 2023 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-58962bf3f89so183781a12.0;
        Thu, 21 Dec 2023 13:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703195306; x=1703800106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aacouOcWfy0uLQPDK6KV+FB6xgizIHygVWnh4T+IL0=;
        b=fDxOhkzOOZ87oWmHU3j8lbW9/oCJcYk2RFiSwtNyeGr2b2tBfQniIE7fdP6AKZRqOi
         Ld0ACzkOOtKf5hcLtCLZslL5R/rSQvaGJkxJMgsJ6Fuc4+bdzZGRUaIQLipsLVc1Bked
         dAwEWDp9nobcEmwhnV++VS2HCxQ0Jb+loBmXRXYq3K4uVPfzp/4gdHeNeBZqHl3s1NaK
         chOI5iVf2jtQLcWF1xzZ87jw12waYadt4kcgGgy7tZvt/H8g2QSYYguJ/PhlnQcEMDDm
         hfNdmTxdIJQIDZHwldSPbEhLQmoWEJfuTatlx5fE7qHfVLVsN1XXCEiaJ062zu6Bf5S7
         caGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195306; x=1703800106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aacouOcWfy0uLQPDK6KV+FB6xgizIHygVWnh4T+IL0=;
        b=v1rOTgQLd3AsBbrtTPUvYBXB2R8U4ac15pVDf5bAtod76UWWlbgh3fqowIAsD2ZbQ6
         K9X445opxFlsCXbyyOtdg0vhXD09cTo1SndoAhOrbeevtYULgZgrxp11CotgzGBADH3P
         Ed5qvPU5EgtMRRJYblNlBFGCmeWv4lQy2o88tlBFtMA5bfdZFtHZkQ8O46XZ10tY1IAL
         +RmXea/JvIc7yadKhXb8gR8Cs68ouAh6lfJVbgp6IRF5bC0fs7fx8MbuFYV0XOy9vEjK
         u6cBbLUadAHUhxkEcZprlhXCfr7Wks7sd/GJAxjsmSdQlz0pgcs8FwHMkJm4LKYxTww4
         9tug==
X-Gm-Message-State: AOJu0YwWEyhQLNQFZyUadwBzhvAV/xg2i4PkGLSOOgwYRs9uBhGR9cjB
	c2ehKUK/eXmIyZnwI1wiGRY=
X-Google-Smtp-Source: AGHT+IHdgJo2QpFvb27GHdPapdFDZTihUk7M68E1vt7ojkgQggytWYtbRV0KomYGJgOYc02kZ2OTPQ==
X-Received: by 2002:a17:90a:8b11:b0:28b:a5ea:732e with SMTP id y17-20020a17090a8b1100b0028ba5ea732emr757329pjn.2.1703195306212;
        Thu, 21 Dec 2023 13:48:26 -0800 (PST)
Received: from olv-ct-22.c.googlers.com.com (255.176.125.34.bc.googleusercontent.com. [34.125.176.255])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a2a4700b0028bcbee2badsm2480659pjg.10.2023.12.21.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:48:25 -0800 (PST)
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
Subject: [PATCH] arm64: dts: qcom: sc7280: revert back to PSCI PC mode
Date: Thu, 21 Dec 2023 13:48:13 -0800
Message-ID: <20231221214822.3063219-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This effectively reverts 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add
power-domains for cpuidle states") for sc7280-herobrine.

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


