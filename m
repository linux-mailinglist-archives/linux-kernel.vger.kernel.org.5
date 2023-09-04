Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75610791AF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353274AbjIDP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351711AbjIDP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:57:15 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2EE6A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:57:10 -0700 (PDT)
Received: from v0.lan (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 92F80200DC;
        Mon,  4 Sep 2023 17:57:08 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Mon, 04 Sep 2023 17:57:05 +0200
Subject: [PATCH 5/6] arm64: dts: allwinner: h616: Add CPU Operating
 Performance Points table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230904-cpufreq-h616-v1-5-b8842e525c43@somainline.org>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
In-Reply-To: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693843024; l=4851;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=ZyTs95wiIyvmN1gbK2qSdTK4VyZDXqdQv5Y0SxAq2Rk=;
 b=Pmytw8jIYJK6fsuUEfiSHlfEP7WedUyOYqucysSFK6q9uyb86M3hCB9byZG+4ySi6JIZ6Mv7Y
 3mP/BIvEH4zCImrvZJin4j5kU9yhS/7gi8UWRE9b3aNJqYNGB1/QKb7
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Operating Performance Points table for the CPU cores to
enable Dynamic Voltage & Frequency Scaling on the H616.

Also add the needed cpu_speed_grade nvmem cell.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 .../boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 129 +++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |   4 +
 2 files changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
new file mode 100644
index 000000000000..4c7eaba511a9
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2023 Martin Botka <martin@somainline.org>
+
+/ {
+	cpu_opp_table: cpu-opp-table {
+		compatible = "allwinner,sun50i-h616-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		opp-shared;
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+			opp-microvolt-speed3 = <900000>;
+			opp-microvolt-speed4 = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed4 = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x12>;
+		};
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+			opp-microvolt-speed3 = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0xd>;
+		};
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed4 = <940000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x12>;
+		};
+
+		opp-936000000 {
+			opp-hz = /bits/ 64 <936000000>;
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+			opp-microvolt-speed3 = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0xd>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt-speed0 = <950000>;
+			opp-microvolt-speed1 = <940000>;
+			opp-microvolt-speed2 = <950000>;
+			opp-microvolt-speed3 = <950000>;
+			opp-microvolt-speed4 = <1020000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt-speed0 = <1000000>;
+			opp-microvolt-speed2 = <1000000>;
+			opp-microvolt-speed3 = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0xd>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0 = <1050000>;
+			opp-microvolt-speed1 = <1020000>;
+			opp-microvolt-speed2 = <1050000>;
+			opp-microvolt-speed3 = <1050000>;
+			opp-microvolt-speed4 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed2 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			opp-microvolt-speed4 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1d>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed2 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0xd>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt-speed1 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0xa>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 063db9634e5f..78e79c591dba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -143,6 +143,10 @@ sid: efuse@3006000 {
 			ths_calibration: thermal-sensor-calibration@14 {
 				reg = <0x14 0x8>;
 			};
+
+			cpu_speed_grade: cpu_speed_grade@0 {
+				reg = <0x0 2>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {

-- 
2.42.0

