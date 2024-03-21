Return-Path: <linux-kernel+bounces-110668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9B886212
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A81F21339
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA53135418;
	Thu, 21 Mar 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="SiTpG/W/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="DBRV8xdy"
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6257F514;
	Thu, 21 Mar 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054174; cv=none; b=XcBJeEQDGNxcUwfIIYRoUp9IwduW7AzdElSua6yYRTIdq/1+OXwRtM4relyP899lD0GqSDlFVkGgYLXpMc2CxHtdiaqSKBQwCiD8DhwfnRlI70L+zgppQ4TDF/ZXtFAXYjOSllY8YwBiIEnS0erKZOT3OcBFuzFRzRU7qbG1eqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054174; c=relaxed/simple;
	bh=HZPHNpjyg4/sxUKZpKWDtoxzAlyv2vqc7mhPM4BQr+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgUGmt+1r8nyTvNDfcm5ibrN+ANcj/HkIVLn6mBKplDA4e1dvuSnXrNQJ6FC+8Iz3S15F0QN0eSb5P8lCgTNMyHm6CpGm4JfZwizIh4Zjd8LAQll9uGxfyxyPwo5WZn/1K6Rxf1Dl2e7AG1WgnmAJ8QUH0vtohEFRptJeAqqkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=SiTpG/W/; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=DBRV8xdy; arc=none smtp.client-ip=79.137.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=0Ix7UQVnD0ilprUP5MbXlA5LpK3uivJ93HU7Jpk8/G4=;
	t=1711054171;x=1711144171; 
	b=SiTpG/W/WIsELxs+/Y0ErmmQubF238+X6/3uVUGtveN75Ru9gtGIgm6xK2kH6Ei/Gjspz73ZaI1Oos439Nc/j+mEj6e85wV1HzsUa0jCSyJcIhV/eF6y5dz43CRJrXOqKf44mPdIV51//QNeb2JGM8qDT6ByksWVnlu2twDljSs=;
Received: from [10.12.4.2] (port=36382 helo=smtp29.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rnP2H-004MG7-Oq; Thu, 21 Mar 2024 23:29:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=0Ix7UQVnD0ilprUP5MbXlA5LpK3uivJ93HU7Jpk8/G4=; t=1711052953; x=1711142953; 
	b=DBRV8xdyKOBQK/DK/4g4SJMU0UkwTw9Of1OfNQKLdH1kEW0dqugwf71fajK/BRwloqR2380xjEC
	fbWpL3TTJrBf/sYeW0tjZPJ7sVe4Q8Gqu/VKbblHvjy6AZUkvLl8FfVzVSwUqjxMuipLHbZRW71kk
	2Hf/OhCv2XwxIBE8W48=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rnP28-00000005qz4-0BFd; Thu, 21 Mar 2024 23:29:04 +0300
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
Subject: [PATCH v2 4/7] dt-bindings: clock: qcom: Add SM7150 CAMCC clocks
Date: Thu, 21 Mar 2024 23:28:11 +0300
Message-ID: <20240321202814.59835-5-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321202814.59835-1-danila@jiaxyga.com>
References: <20240321202814.59835-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD94D5EF110843E6A67041C1113DA195F221E799EC26425FE70182A05F5380850404C228DA9ACA6FE27CAB500903F237B16D27678DDAA806314833AE9DB030A9CE2DF7EF9FDA0AB3C10067A636123F0E402
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F40AD8E56E74C9F0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AE7D31454303AF298638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D81A42D0D4569EDAA9B82A659056168E438E377E9CC675BA16CC7F00164DA146DAFE8445B8C89999728AA50765F79006370BDD70ABAC747F53389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80839144E5BB460BAF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CD166953D3EA3826B03F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C399CBCF38BF184368BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C300D476B8B50F5EBD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A544324F61052108955002B1117B3ED696518264D6529E45F00E58516B1639A14B823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2D54D3759785CDF1167C89469BEA86B6B1A96B7C95E2C1F8834F389C57814A3A711F655CCE117FA3A5E652D4FCD6795A7E207234AAC1F2CC07F407391B6C10D813D6F8A6DB5305FE146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes24/rK3e0W88Gw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498123F80C9C64FBB36E77EA6416FFE467E12BEA6E6C0A1AFFF5C8E14A62ABA6C34A2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A873E06F0BBE0AC5D1A1832AEB7E2E7987A76C223ACA296568F3CF0E9FE49B6993595096ACAD5B569A584B40064F9CC5DF241553FEE5617DFFBABD1C50683FF6
X-7FA49CB5: 0D63561A33F958A56F40FAFF33DEA24814718FCAEAA40BFC9D32D75DE86F511E8941B15DA834481FA18204E546F3947C36C7B98ACBF5D372F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063758A860CC8F9F2A6C389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C39C2627E4F2648A8635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes24jQsBjPlLsWA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add device tree bindings for the camera clock controller on Qualcomm
SM7150 platform.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 000000000000..ce73ef0fe95d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-camcc.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAMCC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_CAMCC_SM7150_H
+
+/* Hardware clocks */
+#define CAMCC_PLL0_OUT_EVEN					0
+#define CAMCC_PLL0_OUT_ODD					1
+#define CAMCC_PLL1_OUT_EVEN					2
+#define CAMCC_PLL2_OUT_EARLY					3
+#define CAMCC_PLL3_OUT_EVEN					4
+#define CAMCC_PLL4_OUT_EVEN					5
+
+/* CAMCC clock registers */
+#define CAMCC_PLL0						6
+#define CAMCC_PLL1						7
+#define CAMCC_PLL2						8
+#define CAMCC_PLL2_OUT_AUX					9
+#define CAMCC_PLL2_OUT_MAIN					10
+#define CAMCC_PLL3						11
+#define CAMCC_PLL4						12
+#define CAMCC_BPS_AHB_CLK					13
+#define CAMCC_BPS_AREG_CLK					14
+#define CAMCC_BPS_AXI_CLK					15
+#define CAMCC_BPS_CLK						16
+#define CAMCC_BPS_CLK_SRC					17
+#define CAMCC_CAMNOC_AXI_CLK					18
+#define CAMCC_CAMNOC_AXI_CLK_SRC				19
+#define CAMCC_CAMNOC_DCD_XO_CLK					20
+#define CAMCC_CCI_0_CLK						21
+#define CAMCC_CCI_0_CLK_SRC					22
+#define CAMCC_CCI_1_CLK						23
+#define CAMCC_CCI_1_CLK_SRC					24
+#define CAMCC_CORE_AHB_CLK					25
+#define CAMCC_CPAS_AHB_CLK					26
+#define CAMCC_CPHY_RX_CLK_SRC					27
+#define CAMCC_CSI0PHYTIMER_CLK					28
+#define CAMCC_CSI0PHYTIMER_CLK_SRC				29
+#define CAMCC_CSI1PHYTIMER_CLK					30
+#define CAMCC_CSI1PHYTIMER_CLK_SRC				31
+#define CAMCC_CSI2PHYTIMER_CLK					32
+#define CAMCC_CSI2PHYTIMER_CLK_SRC				33
+#define CAMCC_CSI3PHYTIMER_CLK					34
+#define CAMCC_CSI3PHYTIMER_CLK_SRC				35
+#define CAMCC_CSIPHY0_CLK					36
+#define CAMCC_CSIPHY1_CLK					37
+#define CAMCC_CSIPHY2_CLK					38
+#define CAMCC_CSIPHY3_CLK					39
+#define CAMCC_FAST_AHB_CLK_SRC					40
+#define CAMCC_FD_CORE_CLK					41
+#define CAMCC_FD_CORE_CLK_SRC					42
+#define CAMCC_FD_CORE_UAR_CLK					43
+#define CAMCC_ICP_AHB_CLK					44
+#define CAMCC_ICP_CLK						45
+#define CAMCC_ICP_CLK_SRC					46
+#define CAMCC_IFE_0_AXI_CLK					47
+#define CAMCC_IFE_0_CLK						48
+#define CAMCC_IFE_0_CLK_SRC					49
+#define CAMCC_IFE_0_CPHY_RX_CLK					50
+#define CAMCC_IFE_0_CSID_CLK					51
+#define CAMCC_IFE_0_CSID_CLK_SRC				52
+#define CAMCC_IFE_0_DSP_CLK					53
+#define CAMCC_IFE_1_AXI_CLK					54
+#define CAMCC_IFE_1_CLK						55
+#define CAMCC_IFE_1_CLK_SRC					56
+#define CAMCC_IFE_1_CPHY_RX_CLK					57
+#define CAMCC_IFE_1_CSID_CLK					58
+#define CAMCC_IFE_1_CSID_CLK_SRC				59
+#define CAMCC_IFE_1_DSP_CLK					60
+#define CAMCC_IFE_LITE_CLK					61
+#define CAMCC_IFE_LITE_CLK_SRC					62
+#define CAMCC_IFE_LITE_CPHY_RX_CLK				63
+#define CAMCC_IFE_LITE_CSID_CLK					64
+#define CAMCC_IFE_LITE_CSID_CLK_SRC				65
+#define CAMCC_IPE_0_AHB_CLK					66
+#define CAMCC_IPE_0_AREG_CLK					67
+#define CAMCC_IPE_0_AXI_CLK					68
+#define CAMCC_IPE_0_CLK						69
+#define CAMCC_IPE_0_CLK_SRC					70
+#define CAMCC_IPE_1_AHB_CLK					71
+#define CAMCC_IPE_1_AREG_CLK					72
+#define CAMCC_IPE_1_AXI_CLK					73
+#define CAMCC_IPE_1_CLK						74
+#define CAMCC_JPEG_CLK						75
+#define CAMCC_JPEG_CLK_SRC					76
+#define CAMCC_LRME_CLK						77
+#define CAMCC_LRME_CLK_SRC					78
+#define CAMCC_MCLK0_CLK						79
+#define CAMCC_MCLK0_CLK_SRC					80
+#define CAMCC_MCLK1_CLK						81
+#define CAMCC_MCLK1_CLK_SRC					82
+#define CAMCC_MCLK2_CLK						83
+#define CAMCC_MCLK2_CLK_SRC					84
+#define CAMCC_MCLK3_CLK						85
+#define CAMCC_MCLK3_CLK_SRC					86
+#define CAMCC_SLEEP_CLK						87
+#define CAMCC_SLEEP_CLK_SRC					88
+#define CAMCC_SLOW_AHB_CLK_SRC					89
+#define CAMCC_XO_CLK_SRC					90
+
+/* CAMCC GDSCRs */
+#define BPS_GDSC						0
+#define IFE_0_GDSC						1
+#define IFE_1_GDSC						2
+#define IPE_0_GDSC						3
+#define IPE_1_GDSC						4
+#define TITAN_TOP_GDSC						5
+
+#endif
-- 
2.44.0


