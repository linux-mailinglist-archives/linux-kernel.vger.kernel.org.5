Return-Path: <linux-kernel+bounces-46213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92D843C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C111C2942C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D817AE7D;
	Wed, 31 Jan 2024 10:20:47 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12D6A03D;
	Wed, 31 Jan 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696446; cv=none; b=HHSVP2mJvTKMcSX3UZxt9ZJFWTJq0L50l4KAfcHY3kkDWHvLN06j/bajy61/M4wy6UDOfCQE5topP4ZL18kpEh1Wb8gXa4kfCZ9epQGaVeM+qNsDARARGRgj2tiK42kUftyIGgWee7o9SXAtlcXuYx58rKRt6roDuS+N7M8LeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696446; c=relaxed/simple;
	bh=7jTUgTyTWrplhYBlMlvbaK6LbEm/08eY9/FwIaaP0K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDUeZDKizpujE9xAN88wXm8JbfCjbJik/SJTKh6N0tic+reU5vc1sT9RXPVaJqwXj6l7mkHSbr/9grsn2sROcTxwNkck1HaLMGXveKGJtxXw82wJVD39VjIUQ/yUlOeu96RYorILtbYPZ7P5SqShZZ7BgbAyJmkP2Q6l5Lu4lvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 16B5D7E0142;
	Wed, 31 Jan 2024 18:20:21 +0800 (CST)
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
Subject: [PATCH 2/3] arm64: dts: qcom: ipq6018: add ipq6000 CPU OPP tables
Date: Wed, 31 Jan 2024 18:20:02 +0800
Message-Id: <20240131102003.2061203-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131102003.2061203-1-amadeus@jmu.edu.cn>
References: <20240131102003.2061203-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR5DVh1MGh8YGkhLH0NJQlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkxKT0xDVUpLS1VKQktLWQY+
X-HM-Tid: 0a8d5f08b0d503a2kunm16b5d7e0142
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6Nww*IjMITU8LIU4aAU46
	HU8wCwxVSlVKTEtNTUJNT0lKQkNCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFJQkxDNwY+

Some IPQ6000 SoCs don't have pmic chips, and fused 1.2GHz.
Add a separate CPU OPP tables for these SoCs.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi b/arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi
new file mode 100644
index 000000000000..acb4774da33e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * IPQ6000 without PMIC (MP5496) CPU OPP tables
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
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <200000>;
+		};
+	};
+};
+
+&CPU0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&CPU1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&CPU2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&CPU3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
-- 
2.25.1


