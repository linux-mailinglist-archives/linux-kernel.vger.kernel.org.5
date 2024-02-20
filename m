Return-Path: <linux-kernel+bounces-73383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D085C1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62B31C21C18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB067768F9;
	Tue, 20 Feb 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Bbo36STV"
Received: from smtp54.i.mail.ru (smtp54.i.mail.ru [95.163.41.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819D69D01;
	Tue, 20 Feb 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447980; cv=none; b=ubcf9Lo8NPpc2RDkU0AEU737Af5IwQ8hmfwebqxFL8keBaZJ0GZyIYfBmFp/BBvpX2NTk7k4SBHBUmMXLsZz4HXEQ5eiKomPXAej9TTV7rMnYIZmCI/ju0Z6bW5Dl0sO+e6XJ531mIVwQQFIfPIMKvUd8POxJnX/VNrcZ/vmIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447980; c=relaxed/simple;
	bh=l7SFpQhbw6SePjwOm2i/2LpLRNoK2liXFOknTeCtwyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRQivHeAH980etX5lB3xUaWuZaqlDJMp4f9VW1CmkxcSISmU0O4JgJIC7NnvkatjjmUr2orprIvzEQUCwPfm8JdNsuJ55fn/eVkRa8gjXSImEk6MeoPS9+mwOnC3LgVaai5LOOK6VrkrFFcjC4J43k/MprTeznPoIRX7/zigWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Bbo36STV; arc=none smtp.client-ip=95.163.41.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=hCg350n+JEevpHfKu9TM4FH+RAcMDQ2ro8+v9e7z7GM=; t=1708447977; x=1708537977; 
	b=Bbo36STV/C857y3roE0EQMkw5GsLJhXcUf6AYcFKXSh84gHsUw5mxShCaLacNeX5SaR5cTIqHdt
	cA1VsetjD7lrC1Ordm66Ii19mJq+vY0vJg6qsrZoRukjr+gMF3/IR3nbBDpdVvOKX4VQDmZHdlhaq
	0LPHx2G1T9kt8ODHUz4=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMU-0000000GhgU-2LJk; Tue, 20 Feb 2024 19:52:55 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	david@mainlining.org,
	adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 5/8] dt-bindings: clock: qcom: Add SM7150 CAMCC clocks
Date: Tue, 20 Feb 2024 19:52:37 +0300
Message-ID: <20240220165240.154716-6-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220165240.154716-1-danila@jiaxyga.com>
References: <20240220165240.154716-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD20216FAE178C97F62E8BCB89B89319DA15CC00894C459B0CD1B930D32AFAFE664F0B40A02D48E7B53F4A103FE687D70D84BEEAC3EACB7F7CF7DDE1C7414A75FA687D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE740ED6E8A51A4BC6EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063742A7510D47EF3C8B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86E6F8F86BE2CFFF4CF466CB8E830073EF6E4E15C06CE43DBCC7F00164DA146DAFE8445B8C89999728AA50765F790063765D76192D7FB77C9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80839144E5BB460BAF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C724336BCC0EE1BA803F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3E4E4C6D06EECBC45BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C33A60492226029A77089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A52EB04C5E82EAA5015002B1117B3ED69619D16998361557C992B673A2F5DDD7E7823CB91A9FED034534781492E4B8EEAD3B90412627F530F9A71A35648BE338CE9510FB958DCE06DB58C12E6D310A6D53A16EC4B4EECACEB3
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF728A2848334A6442D00B234958B0B5DD5B985B44823DE3244AE63E04343CD514DDCE95BB4BF576A6F1AD97FD9824DBCDF83C14C228CD2018C96C255941595840D58718203108B480146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCnP8GoQlAWD7w==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFE0D8E165B5AC4796CFE00E7EA783AF305DBE5843F163867CD2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add device tree bindings for the camera clock controller on Qualcomm
SM7150 platform.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../bindings/clock/qcom,sm7150-camcc.yaml     |  60 ++++++++++
 include/dt-bindings/clock/qcom,sm7150-camcc.h | 113 ++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
new file mode 100644
index 000000000000..7be4b10c430c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm7150-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on SM7150
+
+maintainers:
+  - Danila Tikhonov <danila@jiaxyga.com>
+  - David Wronek <david@mainlining.org>
+  - Jens Reidel <adrian@travitia.xyz>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and power
+  domains on SM7150.
+
+  See also:: include/dt-bindings/clock/qcom,sm7150-camcc.h
+
+properties:
+  compatible:
+    const: qcom,sm7150-camcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board XO Active-Only source
+      - description: Sleep clock source
+
+  power-domains:
+    maxItems: 1
+    description:
+      CX power domain.
+
+required:
+  - compatible
+  - clocks
+  - power-domains
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@ad00000 {
+      compatible = "qcom,sm7150-camcc";
+      reg = <0xad00000 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>;
+      power-domains = <&rpmhpd RPMHPD_CX>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm7150-camcc.h b/include/dt-bindings/clock/qcom,sm7150-camcc.h
new file mode 100644
index 000000000000..cc187e40fbc0
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-camcc.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_SM7150_H
+
+/* Hardware clocks */
+#define CAM_CC_PLL0_OUT_EVEN					0
+#define CAM_CC_PLL0_OUT_ODD					1
+#define CAM_CC_PLL1_OUT_EVEN					2
+#define CAM_CC_PLL2_OUT_EARLY					3
+#define CAM_CC_PLL3_OUT_EVEN					4
+#define CAM_CC_PLL4_OUT_EVEN					5
+
+/* CAM_CC clock registers */
+#define CAM_CC_PLL0						6
+#define CAM_CC_PLL1						7
+#define CAM_CC_PLL2						8
+#define CAM_CC_PLL2_OUT_AUX					9
+#define CAM_CC_PLL2_OUT_MAIN					10
+#define CAM_CC_PLL3						11
+#define CAM_CC_PLL4						12
+#define CAM_CC_BPS_AHB_CLK					13
+#define CAM_CC_BPS_AREG_CLK					14
+#define CAM_CC_BPS_AXI_CLK					15
+#define CAM_CC_BPS_CLK						16
+#define CAM_CC_BPS_CLK_SRC					17
+#define CAM_CC_CAMNOC_AXI_CLK					18
+#define CAM_CC_CAMNOC_AXI_CLK_SRC				19
+#define CAM_CC_CAMNOC_DCD_XO_CLK				20
+#define CAM_CC_CCI_0_CLK					21
+#define CAM_CC_CCI_0_CLK_SRC					22
+#define CAM_CC_CCI_1_CLK					23
+#define CAM_CC_CCI_1_CLK_SRC					24
+#define CAM_CC_CORE_AHB_CLK					25
+#define CAM_CC_CPAS_AHB_CLK					26
+#define CAM_CC_CPHY_RX_CLK_SRC					27
+#define CAM_CC_CSI0PHYTIMER_CLK					28
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				29
+#define CAM_CC_CSI1PHYTIMER_CLK					30
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				31
+#define CAM_CC_CSI2PHYTIMER_CLK					32
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				33
+#define CAM_CC_CSI3PHYTIMER_CLK					34
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC				35
+#define CAM_CC_CSIPHY0_CLK					36
+#define CAM_CC_CSIPHY1_CLK					37
+#define CAM_CC_CSIPHY2_CLK					38
+#define CAM_CC_CSIPHY3_CLK					39
+#define CAM_CC_FAST_AHB_CLK_SRC					40
+#define CAM_CC_FD_CORE_CLK					41
+#define CAM_CC_FD_CORE_CLK_SRC					42
+#define CAM_CC_FD_CORE_UAR_CLK					43
+#define CAM_CC_ICP_AHB_CLK					44
+#define CAM_CC_ICP_CLK						45
+#define CAM_CC_ICP_CLK_SRC					46
+#define CAM_CC_IFE_0_AXI_CLK					47
+#define CAM_CC_IFE_0_CLK					48
+#define CAM_CC_IFE_0_CLK_SRC					49
+#define CAM_CC_IFE_0_CPHY_RX_CLK				50
+#define CAM_CC_IFE_0_CSID_CLK					51
+#define CAM_CC_IFE_0_CSID_CLK_SRC				52
+#define CAM_CC_IFE_0_DSP_CLK					53
+#define CAM_CC_IFE_1_AXI_CLK					54
+#define CAM_CC_IFE_1_CLK					55
+#define CAM_CC_IFE_1_CLK_SRC					56
+#define CAM_CC_IFE_1_CPHY_RX_CLK				57
+#define CAM_CC_IFE_1_CSID_CLK					58
+#define CAM_CC_IFE_1_CSID_CLK_SRC				59
+#define CAM_CC_IFE_1_DSP_CLK					60
+#define CAM_CC_IFE_LITE_CLK					61
+#define CAM_CC_IFE_LITE_CLK_SRC					62
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK				63
+#define CAM_CC_IFE_LITE_CSID_CLK				64
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC				65
+#define CAM_CC_IPE_0_AHB_CLK					66
+#define CAM_CC_IPE_0_AREG_CLK					67
+#define CAM_CC_IPE_0_AXI_CLK					68
+#define CAM_CC_IPE_0_CLK					69
+#define CAM_CC_IPE_0_CLK_SRC					70
+#define CAM_CC_IPE_1_AHB_CLK					71
+#define CAM_CC_IPE_1_AREG_CLK					72
+#define CAM_CC_IPE_1_AXI_CLK					73
+#define CAM_CC_IPE_1_CLK					74
+#define CAM_CC_JPEG_CLK						75
+#define CAM_CC_JPEG_CLK_SRC					76
+#define CAM_CC_LRME_CLK						77
+#define CAM_CC_LRME_CLK_SRC					78
+#define CAM_CC_MCLK0_CLK					79
+#define CAM_CC_MCLK0_CLK_SRC					80
+#define CAM_CC_MCLK1_CLK					81
+#define CAM_CC_MCLK1_CLK_SRC					82
+#define CAM_CC_MCLK2_CLK					83
+#define CAM_CC_MCLK2_CLK_SRC					84
+#define CAM_CC_MCLK3_CLK					85
+#define CAM_CC_MCLK3_CLK_SRC					86
+#define CAM_CC_SLEEP_CLK					87
+#define CAM_CC_SLEEP_CLK_SRC					88
+#define CAM_CC_SLOW_AHB_CLK_SRC					89
+#define CAM_CC_XO_CLK_SRC					90
+
+/* CAM_CC GDSCRs */
+#define CAM_CC_BPS_GDSC						0
+#define CAM_CC_IFE_0_GDSC					1
+#define CAM_CC_IFE_1_GDSC					2
+#define CAM_CC_IPE_0_GDSC					3
+#define CAM_CC_IPE_1_GDSC					4
+#define CAM_CC_TITAN_TOP_GDSC					5
+
+#endif
-- 
2.43.2


