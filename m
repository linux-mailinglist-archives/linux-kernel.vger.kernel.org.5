Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A6774446
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjHHSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjHHSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:03 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A047A0FC;
        Tue,  8 Aug 2023 10:22:41 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 49E94408F4;
        Tue,  8 Aug 2023 15:10:40 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1691489441; bh=j7da2n+mSgbTjlclhAj0t2xfxus9GDBFVbDFbPAlExU=;
        h=From:Date:Subject:To:Cc:From;
        b=lJtmSunRFPLSmUsvO9YyMgV/kOdO45cRD9yZkxUiEqyRCFJOM8KRxclTPM9mMLy85
         7rcZ5Rwqze+pbbN82zCPCY1elovbUwNjfbighuKwYkI49z+4KSOXGNjCUnC6d5WiXj
         vMi032kh8F388Zdxb+blbOg2rfnVj49+JbhpSHNOSiHCkC6n84YqKukmSrIU7VLanW
         MorMTXJ3OuR/cQ7EI+r/+R2DbJKyO4LtIZgPxo4xeywQYF7cPu7wMlI8AIi4dEhtKd
         QdTQ0hNqtZzmh8xTtWZrler47qvEEWS6yajNTfhTyYJ5vCJKbds3qk6zX9CfGoHFa+
         24g8Vlch8e2Qg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 08 Aug 2023 15:10:13 +0500
Subject: [PATCH] arm64: dts: qcom: sc7180: Split up TF-A related PSCI
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-sc7180-tfa-fw-v1-1-666d5d8467e5@trvn.ru>
X-B4-Tracking: v=1; b=H4sIAIQU0mQC/x3MQQqAIBBA0avErBsYK1C7SrQQG2s2FhoVSHdPW
 r7F/wUyJ+EMY1Mg8SVZ9lih2gb85uLKKEs1dNT1ZMhg9loZwjM4DDdaa3q1aGfJDlCbI3GQ5/9
 N8/t+NwSja18AAAA=
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12709; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=j7da2n+mSgbTjlclhAj0t2xfxus9GDBFVbDFbPAlExU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk0hSfbBZH2sqsXP0N+kCcP8s3Z2nzarS1qYkTT
 lTQyUDTkbiJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZNIUnwAKCRBDHOzuKBm/
 dWbhD/93ef/iHle2n6/LqGxfsKDkG5mWc9E7vlOzUQMPCTuTnDXYStAMRtSEJMB5+UwSyTayhKf
 aE0EyTCzOm0UsboO6fe2qHdwd8iSR5Vz16iihPPBHY/J5uNIXzokCuZn28ZpHgwuANa8FnBiNv3
 bGjQOWTjhZ1JKOYcuPlonL4ST5Th/KdrfT5A7vsHb2M356VJP8fgC2bpiRDI5l7HYVSPD0XELy9
 bfItecesCI+Vjl2uOUu6JRMP75EZK5vQEPwGOHr+ZMZC3dd/U/22X+yU3/5iv1CNf3ppenFwB3p
 JnzjaX124MKUwW1iBPEPNSmE8pLS1UuZbkp1zs7WytC+MvlmA1ZuIxeElEKtRtquUg43M5QG8+w
 f2Zscks58TAYPt3y1fpRBOYfGN1kWrQ7/M6edtpl1Rp5K4lvfHF/Gm2r+j4lWlq3yEe9p/RTU8M
 zuFJgApRfRHgBobLFtvwUTuXKSDIMBcxMfHcKkiX2gW6qeToDIbuGCTZ5yTkMkzL83dlWU8LYWc
 BQxuo2lfPgf2uJNuQchz2ljUmY/tBzrKMgwGK8jgElcMuRn2SnAnsUwGgY4uJnrd4+0ZwcHKwR7
 /ZHNBB8VSVt+Dc6DTrIuFpqK8Dj+AkL1X0w2mcidxsHz82Vc/Zvs2OiP0/S4mG/V+BOhnpXlpE6
 YoALrDIshbCaetQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initially submitted, the sc7180 support only targeted CROS devices
that make use of alternative TF-A firmware and not the official Qualcomm
firmware. The PSCI implementations in those firmwares differ however so
devices that use qcom firmware, like WoA laptops such as aspire1 need
different setup.

This commit adjusts the SoC dtsi to the OSI mode PSCI setup, common to
the Qualcomm firmware and introduces new sc7180-firmware-tfa.dtsi that
overrides the PSCI setup for the PC mode and uses TF-A specific
psci-suspend-param. This dtsi is added to all boards that appear to use
TF-A.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
This series unlocks low power states on various 7c devices such as
Aspire 1 and a few not-yet-submitted WoA laptops as well as for all the
sm7125 devices proposed on the lists [1]. It should create no change for
existing TF-A users.

With this, at least on Aspire 1 I can observe the qcom_stats counting
suspend time:

    # grep "" -R /sys/kernel/debug/qcom_stats/
    ddr:Count: 2
    ddr:Last Entered At: 2787856692
    ddr:Last Exited At: 3030611778
    ddr:Accumulated Duration: 761257025
    cxsd:Count: 2
    cxsd:Last Entered At: 2787867135
    cxsd:Last Exited At: 3030596907
    cxsd:Accumulated Duration: 761205999
    aosd:Count: 2
    aosd:Last Entered At: 2787867643
    aosd:Last Exited At: 3030595637
    aosd:Accumulated Duration: 761202409
    modem:Count: 59
    modem:Last Entered At: 2784580484
    modem:Last Exited At: 3032145065
    modem:Accumulated Duration: 1834999138

The suspend-param values and timings are verified with the downstream
atoll.dtsi and are similar to some other platforms [2].

[1] https://lore.kernel.org/linux-arm-msm/20230723190725.1619193-1-davidwronek@gmail.com/
[2] https://lore.kernel.org/linux-arm-msm/20230531-topic-rsc-v1-2-b4a985f57b8b@linaro.org/
---
 arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi | 107 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts           |   1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi      |   1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi              | 127 +++++++++++++++++-----
 4 files changed, 206 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi b/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi
new file mode 100644
index 000000000000..ee35a454dbf6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/*
+ * Devices that use SC7180 with TrustedFirmware-A
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
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU5 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index a1c50be4ad95..0146fb0036d4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "sc7180.dtsi"
+#include "sc7180-firmware-tfa.dtsi"
 #include "pm6150.dtsi"
 #include "pm6150l.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index af16e36bcb40..5a33e16a8b67 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/sc7180-lpass.h>
 
 #include "sc7180.dtsi"
+#include "sc7180-firmware-tfa.dtsi"
 /* PMICs depend on spmi_bus label and so must come after sc7180.dtsi */
 #include "pm6150.dtsi"
 #include "pm6150l.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 9af94e267f84..a79c0f2e1879 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -79,9 +79,8 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -109,9 +108,8 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_100>;
@@ -134,9 +132,8 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_200>;
@@ -159,9 +156,8 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_300>;
@@ -184,9 +180,8 @@ CPU4: cpu@400 {
 			reg = <0x0 0x400>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_400>;
@@ -209,9 +204,8 @@ CPU5: cpu@500 {
 			reg = <0x0 0x500>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_500>;
@@ -234,9 +228,8 @@ CPU6: cpu@600 {
 			reg = <0x0 0x600>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_600>;
@@ -259,9 +252,8 @@ CPU7: cpu@700 {
 			reg = <0x0 0x700>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_700>;
@@ -314,7 +306,7 @@ core7 {
 			};
 		};
 
-		idle-states {
+		idle_states: idle-states {
 			entry-method = "psci";
 
 			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
@@ -356,15 +348,34 @@ BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 				min-residency-us = <5555>;
 				local-timer-stop;
 			};
+		};
 
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
+		domain_idle_states: domain-idle-states {
+			CLUSTER_SLEEP_PC: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				idle-state-name = "cluster-l3-power-collapse";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <3048>;
+				min-residency-us = <6118>;
+			};
+
+			CLUSTER_SLEEP_CX_RET: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				idle-state-name = "cluster-cx-retention";
+				arm,psci-suspend-param = <0x41001244>;
+				entry-latency-us = <3638>;
+				exit-latency-us = <4562>;
+				min-residency-us = <8467>;
+			};
+
+			CLUSTER_AOSS_SLEEP: cluster-sleep-2 {
+				compatible = "domain-idle-state";
 				idle-state-name = "cluster-power-down";
-				arm,psci-suspend-param = <0x40003444>;
+				arm,psci-suspend-param = <0x4100b244>;
 				entry-latency-us = <3263>;
 				exit-latency-us = <6562>;
-				min-residency-us = <9926>;
-				local-timer-stop;
+				min-residency-us = <9826>;
 			};
 		};
 	};
@@ -567,6 +578,61 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD1: cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD2: cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD3: cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD4: cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD5: cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD6: cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD7: cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CLUSTER_PD: cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_PC
+					      &CLUSTER_SLEEP_CX_RET
+					      &CLUSTER_AOSS_SLEEP>;
+		};
 	};
 
 	reserved_memory: reserved-memory {
@@ -3597,6 +3663,7 @@ apps_rsc: rsc@18200000 {
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sc7180-rpmh-clk";

---
base-commit: a8726072d7bfe7b2795f4ba99e07bb514c095063
change-id: 20230808-sc7180-tfa-fw-99831d7a9094

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

