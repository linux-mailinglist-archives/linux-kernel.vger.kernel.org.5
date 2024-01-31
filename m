Return-Path: <linux-kernel+bounces-46211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1D843C48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D728CE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FAC7995B;
	Wed, 31 Jan 2024 10:20:45 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4F762DC;
	Wed, 31 Jan 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696444; cv=none; b=iZ8s1PXPREu+N47QzUhNmd5UIpXUbfkhI4hqJ2uFOwQghGZYmDFrBC6JoNl9FYCq/PZAJd2gHzzDVDSuEbBYs4gvRrR3pq8KCciRMtBjfVe2qZFuD8oZ3dAJnzSvRpjAQL8ZTtzteyG02l7sGQnIdwSwvrzQrkN/CjHIVw5/MTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696444; c=relaxed/simple;
	bh=ncR9ZVIZnZgWBEFvpVMj29/3lFamrXl8RVdJlKMnu6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u2/IMq7VMxtlEk07+oNCNPGoiwZnSNPAcW/8Hl0Zy1ADVwjd2pACFeGZgQjbE0fb2fVpo9bIkUTLCXv0E7QQpk+4Pyf6Y6wVLFOcATSSrlnBxcP4m4+kIsAbrMokxQ9z5RBvZ3avAdOWdILmv6vrQmE8lKywKf6lgiQW/GKd14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C9EF57E010C;
	Wed, 31 Jan 2024 18:20:14 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/3] arm64: dts: qcom: ipq6018: separate CPU OPP tables
Date: Wed, 31 Jan 2024 18:20:01 +0800
Message-Id: <20240131102003.2061203-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk0fVhpPHhoZHk8ZGUxDSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkhKQkhLVUpLS1VLWQY+
X-HM-Tid: 0a8d5f08985f03a2kunmc9ef57e010c
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6NRw5AjMJTU9CC04eAUgI
	HwgwFDlVSlVKTEtNTUJNT0pNS09JVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFNTk5LNwY+

Some IPQ6000 SoCs do not come with PMIC (MP5496) chip,
which causes cpufreq to be unavailable due to lack of
cpu-supply. Separate CPU OPP tables from soc.dtsi to
support versions with and without PMIC chip.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts |  1 +
 arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi    | 74 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 56 ---------------
 3 files changed, 75 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index f5f4827c0e17..06dfc2cb6b7f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "ipq6018.dtsi"
+#include "ipq6018-opp.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ6018/AP-CP01-C1";
diff --git a/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi
new file mode 100644
index 000000000000..9c0bed2d8bf5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * IPQ60xx with PMIC (MP5496) CPU OPP tables
+ */
+
+/ {
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&cpu_speed_bin>;
+		opp-shared;
+
+		opp-864000000 {
+			opp-hz = /bits/ 64 <864000000>;
+			opp-microvolt = <725000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <787500>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <862500>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-microvolt = <925000>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <987500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1062500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+	};
+};
+
+&CPU0 {
+	operating-points-v2 = <&cpu_opp_table>;
+	cpu-supply = <&ipq6018_s2>;
+};
+
+&CPU1 {
+	operating-points-v2 = <&cpu_opp_table>;
+	cpu-supply = <&ipq6018_s2>;
+};
+
+&CPU2 {
+	operating-points-v2 = <&cpu_opp_table>;
+	cpu-supply = <&ipq6018_s2>;
+};
+
+&CPU3 {
+	operating-points-v2 = <&cpu_opp_table>;
+	cpu-supply = <&ipq6018_s2>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 5e1277fea725..ea72fd5739ac 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -41,8 +41,6 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
-			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 		};
 
 		CPU1: cpu@1 {
@@ -53,8 +51,6 @@ CPU1: cpu@1 {
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
-			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 		};
 
 		CPU2: cpu@2 {
@@ -65,8 +61,6 @@ CPU2: cpu@2 {
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
-			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 		};
 
 		CPU3: cpu@3 {
@@ -77,8 +71,6 @@ CPU3: cpu@3 {
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
-			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 		};
 
 		L2_0: l2-cache {
@@ -95,54 +87,6 @@ scm {
 		};
 	};
 
-	cpu_opp_table: opp-table-cpu {
-		compatible = "operating-points-v2-kryo-cpu";
-		nvmem-cells = <&cpu_speed_bin>;
-		opp-shared;
-
-		opp-864000000 {
-			opp-hz = /bits/ 64 <864000000>;
-			opp-microvolt = <725000>;
-			opp-supported-hw = <0xf>;
-			clock-latency-ns = <200000>;
-		};
-
-		opp-1056000000 {
-			opp-hz = /bits/ 64 <1056000000>;
-			opp-microvolt = <787500>;
-			opp-supported-hw = <0xf>;
-			clock-latency-ns = <200000>;
-		};
-
-		opp-1320000000 {
-			opp-hz = /bits/ 64 <1320000000>;
-			opp-microvolt = <862500>;
-			opp-supported-hw = <0x3>;
-			clock-latency-ns = <200000>;
-		};
-
-		opp-1440000000 {
-			opp-hz = /bits/ 64 <1440000000>;
-			opp-microvolt = <925000>;
-			opp-supported-hw = <0x3>;
-			clock-latency-ns = <200000>;
-		};
-
-		opp-1608000000 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <987500>;
-			opp-supported-hw = <0x1>;
-			clock-latency-ns = <200000>;
-		};
-
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1062500>;
-			opp-supported-hw = <0x1>;
-			clock-latency-ns = <200000>;
-		};
-	};
-
 	pmuv8: pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-- 
2.25.1


