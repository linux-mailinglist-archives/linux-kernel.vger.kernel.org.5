Return-Path: <linux-kernel+bounces-10009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC8481CEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C25B24243
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD72C850;
	Fri, 22 Dec 2023 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNf1xIRh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C942C1A0;
	Fri, 22 Dec 2023 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ca5b616de0so257255a12.1;
        Fri, 22 Dec 2023 11:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703271795; x=1703876595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYf4+b6nJenqyB0MnEgStJgZKc62c4Xv2ZM4C0n+Guo=;
        b=nNf1xIRhGlfq3M2GeZMfsglIoVefog9uVHkaft+n7nq8j/8KdGuvKoDK7pcXtAdkEL
         0BwMpSCBTLXoYtQsmqG3ghXv14z8JA2YQmAHnAi+Sb/DmbiCUOKq/HUj2VlgM5uolHRA
         KDnimMKugefhHHSfovSbOmMyjWPqI/gf/1w2Ceyeg4OSKpyv5v568x79H2yUBIRG+bBM
         GXAXNYVGn5OWqMFfXP9Pp9QTfwMnMNy/i3z7PcP51Gd4U56BQwdSn6Tz6uvYtnuRSOYc
         mjS1yIiKWDr+udsZt2Sgg13DmIU9X6SDsyr/NU73zWEqNffIRrhX/RyzTpIlsryfAVCq
         zhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703271795; x=1703876595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYf4+b6nJenqyB0MnEgStJgZKc62c4Xv2ZM4C0n+Guo=;
        b=Fj8Rs74tqZC6fsgXEJ2k5IyLjLr3Dljx1poh96yhe0bfSoFUgUyYkgjfs8jsW+JZSs
         6HR1pKvJZSJwg7Tp9zPeMldI1zf4TwcD7nYc0QiqR1TmhK+RMquSwKo2OT3R3VulaoRJ
         ALFtUrbLmUNKUjC8KX2wKeqGY4xrpzzsHh7pLgE/O/jfgWzhNxkyFHhVgLlhgx1mdUFI
         MQXceiSWo0skkcr1q8lHgexu4w6s7/HV3+lhmEMgXZmP872hS/+1nA83QaG4/+I/wDw0
         3N9Vg01s229yazvQLoVvOA7SS0bO718jI/7aH0WZ4PJ7xhDjcIABgUIbolrtBwmZtl8v
         SRGA==
X-Gm-Message-State: AOJu0Yy0o8kH1TZUrlOgY0KWW/xTkS4lmmrmgJ0VRLP0cgjlVW0aL81U
	O9YcOxxAnSnrwasAFMeuRzPb4inGIzw=
X-Google-Smtp-Source: AGHT+IEHcNjG05G0/4uHjCl9x+1D12h2cUawoNnGiNBQVGz6nBA4X3KMQEAc0eaV1NRc/pAhqlSDZg==
X-Received: by 2002:a05:6a21:1ca2:b0:189:f553:6cd2 with SMTP id sf34-20020a056a211ca200b00189f5536cd2mr2960849pzb.3.1703271795249;
        Fri, 22 Dec 2023 11:03:15 -0800 (PST)
Received: from olv-ct-22.c.googlers.com.com (255.176.125.34.bc.googleusercontent.com. [34.125.176.255])
        by smtp.gmail.com with ESMTPSA id v124-20020a626182000000b006d96d753ca0sm3815268pfb.38.2023.12.22.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 11:03:14 -0800 (PST)
From: Chia-I Wu <olvaffe@gmail.com>
To: cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: qcom: sc7280: revert back to PSCI PC mode for herobrine
Date: Fri, 22 Dec 2023 11:03:03 -0800
Message-ID: <20231222190311.3344572-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for
cpuidle states") transitioned all SC7280 devices to PSCI OS initiated
mode, which doesn't work on TFA-based SC7280 devices.  This effectively
revert the commit for sc7280-herobrine.

Fixes: 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for cpuidle states")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---

v2: improved commit message
v3: improved commit message.  I hope it's better now!

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


