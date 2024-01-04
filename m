Return-Path: <linux-kernel+bounces-16575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7582407A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34221C23B20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC821101;
	Thu,  4 Jan 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BCIiI5a9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23111210F3;
	Thu,  4 Jan 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404BJQfJ124161;
	Thu, 4 Jan 2024 05:19:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704367166;
	bh=gEI1DUvl7fwMGnh7BriCsJR03yIbeB6SbxVvjDA9xHg=;
	h=From:To:CC:Subject:Date;
	b=BCIiI5a9PeRs0T+tkg67xaVWYXo85oT6EKzgsRzyOcJr+aOblB0QhLpEyANNkOLRV
	 Ra0gpt21YLCm/FMycxD/NDXIKKrIJSaGhDriliaDketlmqnGL5z7AiYdaW5RKcHhLf
	 62VDJ30ArdkfeUuVCP6fcyWcpm3ImUNbQa+y8cac=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404BJQtm117077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 05:19:26 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 05:19:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 05:19:26 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404BJMmS111184;
	Thu, 4 Jan 2024 05:19:23 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <a-nandan@ti.com>, <kristo@kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j721e: Add support for DFS in J721E A72
Date: Thu, 4 Jan 2024 16:49:22 +0530
Message-ID: <20240104111922.832040-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add 2G, 1G, 500M and 250M as the supported frequencies for A72. This
enables support for Dynamic Frequency Scaling (DFS). Note that Dynamic
Voltage and Frequency Scaling (DVFS) is not supported on J7 devices.

J721E SoC has three different speed grade devices (see [1], 7.5
Operating Performance Points) which as of today are indiscernible in
software, users of a different speed grade device must manually change
the DTS to ensure their maximum speed frequency is supported.

To obtain clock-latency-ns, the maximum time was found to switch from/to
any frequency for a CPU and this value was rounded off and set.

[1] https://www.ti.com/lit/gpn/tda4vm

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Test and boot logs:
https://gist.github.com/nehamalcom/33608837ab5ad3332ff11a7fa7a602e2

Changes since v1:
https://lore.kernel.org/all/20231214075637.176586-1-n-francis@ti.com/
- removed OPPs 1.5G and 750M as they introduced boot regression in
  J721E-SK
- Nishanth
	- indicated DVFS not supported in commit message
	- moved critical data sheet info from below tear line to commit
	  message
	- added opp-shared property
	- added clock-latency-ns property

 arch/arm64/boot/dts/ti/k3-j721e.dtsi | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index a200810df54a..5de6c70bd989 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -48,6 +48,9 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
+			clocks = <&k3_clks 202 2>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,6 +65,34 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
+			clocks = <&k3_clks 203 0>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp6-2000000000 {
+			opp-hz = /bits/ 64 <2000000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp4-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp2-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp1-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			clock-latency-ns = <300000>;
 		};
 	};
 
-- 
2.34.1


