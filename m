Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD087C8C74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjJMRjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjJMRjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:39:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E5BF;
        Fri, 13 Oct 2023 10:39:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2145286f8f.3;
        Fri, 13 Oct 2023 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218747; x=1697823547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j92zsh9SBwqH2Fdc6L1hiUwgh6lWWdZdBcoBjn6jH8s=;
        b=hMKglrNfOapyAW6/MLhAAvlw/MGdL7ufr5kXFfr5wmbjT+A3u/VojcCzeUn28DMcNJ
         As5BCON/1IVL991yWSQ9MNuJ7+7aXoBdgNWbT0nrCUqJdLRS312sK2v/TC5NdaCNXzA4
         OeDshhVSxZSbxrtA6KBKy/IHFCFvJnoaEuZVF427fHjQNWu6mmGEtL7GNA4o1m+Bb4aR
         yCK8syxKq+2bTRJaVBd7LEBKWb6i/52e93rxz3N6Q3VLLODoPFWyggZwgbEugh06D1jU
         y+gDb3fV8kHthPFUbFl6540IoZVkWuqOkbmpnrOmdoUG/OrrLn4SgQ4/r5DHImdLMSrz
         5hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218747; x=1697823547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j92zsh9SBwqH2Fdc6L1hiUwgh6lWWdZdBcoBjn6jH8s=;
        b=B0NdGpvKx1jRl51mn6gZ9PGKb4ZF/xEP/DzXBoU/LYkIiHr43ZM2iPM01WoGAA7/WD
         DprOdAHopJs4mvlNMz2L3cV4kbAo5DUlcbvNN3MOBMdQ7sZLylp2mzW0iJ6GdoAYKA5V
         CbA5N6zy4NH+e0DFMykjQCXOuq1AWUTnY1rpQ7nl7UGafPrJ2ZA+mSt8CAdmW8HDbsOp
         AEISNBTIDQDQY6GujMlxaUvh6xHJPhH7m14NWDto6ShbFw6IwlHp5t1Bwm2Zhm1w/Abi
         wA5NoyZDmaIZMsT19k9DcoaIIwhV1yb/ev+5R8DjC63bk3Vcj8/DTR8Tgc4NiLkN/1m5
         xEFA==
X-Gm-Message-State: AOJu0YyfVbmmOWFl9V844cpi7QgH9OnWfb+LqhXqyX2/Zltc+c67bmx2
        dVTsYyZl2Yhg2YLG2waQIyc=
X-Google-Smtp-Source: AGHT+IG4ETJjJ8HGBycc3ZzcoZGV+DGc5LxYsbp8ZAUtaxsLQx4ZXnADZ+5W/M1mU8hoomCKwn8Wng==
X-Received: by 2002:adf:f30d:0:b0:32d:8942:9ffa with SMTP id i13-20020adff30d000000b0032d89429ffamr6146012wro.23.1697218747447;
        Fri, 13 Oct 2023 10:39:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c42cb00b0040652e8ca13sm692074wme.43.2023.10.13.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:06 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Date:   Fri, 13 Oct 2023 19:38:54 +0200
Message-Id: <20231013173854.7399-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013173854.7399-1-ansuelsmth@gmail.com>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
Use opp-supported-hw binding to correctly enable and disable the
frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
* Use new krait compatible

Changes v4:
* Readd OPP patch for IPQ8064
---
 arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi | 30 +++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 67 ++++++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi | 65 +++++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
index 5d3ebd3e2e51..72d9782c3d6f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
@@ -6,3 +6,33 @@ / {
 	model = "Qualcomm Technologies, Inc. IPQ8062";
 	compatible = "qcom,ipq8062", "qcom,ipq8064";
 };
+
+&opp_table_cpu {
+	opp-384000000 {
+		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
+		opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
+	};
+
+	opp-600000000 {
+		opp-microvolt-speed0-pvs0 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs1 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs2 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs3 = <850000 807500 892500>;
+	};
+
+	opp-800000000 {
+		opp-microvolt-speed0-pvs0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs1 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs2 = <995000 945250 1044750>;
+		opp-microvolt-speed0-pvs3 = <900000 855000 945000>;
+	};
+
+	opp-1000000000 {
+		opp-microvolt-speed0-pvs0 = <1150000 1092500 1207500>;
+		opp-microvolt-speed0-pvs1 = <1075000 1021250 1128750>;
+		opp-microvolt-speed0-pvs2 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs3 = <950000 902500 997500>;
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 6198f42f6a9c..54699472f187 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -30,6 +30,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			operating-points-v2 = <&opp_table_cpu>;
 		};
 
 		cpu1: cpu@1 {
@@ -40,6 +41,7 @@ cpu1: cpu@1 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			operating-points-v2 = <&opp_table_cpu>;
 		};
 
 		L2: l2-cache {
@@ -49,6 +51,71 @@ L2: l2-cache {
 		};
 	};
 
+	opp_table_cpu: opp-table-cpu {
+		compatible = "operating-points-v2-krait-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+			opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
+			opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt-speed0-pvs0 = <1050000 997500 1102500>;
+			opp-microvolt-speed0-pvs1 = <975000 926250 1023750>;
+			opp-microvolt-speed0-pvs2 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs3 = <850000 807500 892500>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt-speed0-pvs0 = <1100000 1045000 1155000>;
+			opp-microvolt-speed0-pvs1 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs2 = <995000 945250 1044750>;
+			opp-microvolt-speed0-pvs3 = <900000 855000 945000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1092500 1207500>;
+			opp-microvolt-speed0-pvs1 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs2 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs3 = <950000 902500 997500>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0-pvs0 = <1200000 1140000 1260000>;
+			opp-microvolt-speed0-pvs1 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs2 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs3 = <1000000 950000 1050000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt-speed0-pvs0 = <1250000 1187500 1312500>;
+			opp-microvolt-speed0-pvs1 = <1175000 1116250 1233750>;
+			opp-microvolt-speed0-pvs2 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs3 = <1050000 997500 1102500>;
+			opp-supported-hw = <0x6>;
+			clock-latency-ns = <100000>;
+		};
+	};
+
 	thermal-zones {
 		sensor0-thermal {
 			polling-delay-passive = <0>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
index ea49f6cc416d..d9ead31b897b 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
@@ -6,3 +6,68 @@ / {
 	model = "Qualcomm Technologies, Inc. IPQ8065";
 	compatible = "qcom,ipq8065", "qcom,ipq8064";
 };
+
+&opp_table_cpu {
+	opp-384000000 {
+		opp-microvolt-speed0-pvs0 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs1 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs2 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs3 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs4 = <875000 831250 918750>;
+		opp-microvolt-speed0-pvs5 = <825000 783750 866250>;
+		opp-microvolt-speed0-pvs6 = <775000 736250 813750>;
+	};
+
+	opp-600000000 {
+		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs1 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs2 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs3 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs4 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs5 = <850000 807500 892500>;
+		opp-microvolt-speed0-pvs6 = <800000 760000 840000>;
+	};
+
+	opp-800000000 {
+		opp-microvolt-speed0-pvs0 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs1 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs2 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs3 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs4 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs5 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs6 = <850000 807500 892500>;
+	};
+
+	opp-1000000000 {
+		opp-microvolt-speed0-pvs0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs1 = <1075000 1021250 1128750>;
+		opp-microvolt-speed0-pvs2 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs3 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs4 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs5 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs6 = <900000 855000 945000>;
+	};
+
+	opp-1400000000 {
+		opp-microvolt-speed4-pvs0 = <1175000 1116250 1233750>;
+		opp-microvolt-speed4-pvs1 = <1150000 1092500 1207500>;
+		opp-microvolt-speed4-pvs2 = <1125000 1068750 1181250>;
+		opp-microvolt-speed4-pvs3 = <1100000 1045000 1155000>;
+		opp-microvolt-speed4-pvs4 = <1075000 1021250 1128750>;
+		opp-microvolt-speed4-pvs5 = <1025000 973750 1076250>;
+		opp-microvolt-speed4-pvs6 = <975000 926250 1023750>;
+	};
+
+	opp-1725000000 {
+		opp-hz = /bits/ 64 <1725000000>;
+		opp-microvolt-speed0-pvs0 = <1262500 1199375 1325625>;
+		opp-microvolt-speed0-pvs1 = <1225000 1163750 1286250>;
+		opp-microvolt-speed0-pvs2 = <1200000 1140000 1260000>;
+		opp-microvolt-speed0-pvs3 = <1175000 1116250 1233750>;
+		opp-microvolt-speed0-pvs4 = <1150000 1092500 1207500>;
+		opp-microvolt-speed0-pvs5 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs6 = <1050000 997500 1102500>;
+		opp-supported-hw = <0x4>;
+		clock-latency-ns = <100000>;
+	};
+};
-- 
2.40.1

