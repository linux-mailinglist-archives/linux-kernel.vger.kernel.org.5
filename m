Return-Path: <linux-kernel+bounces-73410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6C85C221
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FF283739
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04C76C89;
	Tue, 20 Feb 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="iDJrZOw2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="kPIi3D3e"
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAD76906;
	Tue, 20 Feb 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449174; cv=none; b=bUVO3QyA3ZAPS9eaweE2YzByRld4gsQzzf4xtfaU/YJtb5KqDbOFyRrwzP1TD0i3rDpmoeUb5H+FfTuFITGPqJTDYpDyNe8j3MaErTa+IPhYWbmwUY160B8lSEwdUBhlhKlBmL7YfulgmHh7ABL57OBLsx4/2rsJkJQdKFPvNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449174; c=relaxed/simple;
	bh=IfWBiBnC6x0+LkvqgwL8k/fjmPIznCxz/wa8+JdMMug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYY4BNrgurRiYQhF9MCYck63ngPJaqnIK4aoQQW7Y/DjA9pTNuPIYdK5Z0YkI0NwnPZLeDdYjfGrwvxbwLjUk0Kpe1DdvBoRITecTuie1qH68WrdZAgkLNgUtGKcrU1n8GwVh2dJl3J2PkTUmyiK1PHKcIY/m2q+4ClwH1wIj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=iDJrZOw2; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=kPIi3D3e; arc=none smtp.client-ip=79.137.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Nm24Y+It91QAbekGbcuNy/QiT2Iy13eLi44Y9pz6oz0=;
	t=1708449172;x=1708539172; 
	b=iDJrZOw2A0fyYXX3D+0eHeJbgzxt+X5eavWtqB1Rzv28t2BaKVxCZbkjXLMBUCsENGbW83IO6h5yBY/cRxW2olgV/irgWs3x2OipXb3TU51+rer8QvjBvGJnx4M91KX+H3DIfRCx34+LmlQWbXo1FcWkDOxqMnKr3wMZdzZgCns=;
Received: from [10.12.4.25] (port=52674 helo=smtp54.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcTMa-008CBN-Ak; Tue, 20 Feb 2024 19:53:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Nm24Y+It91QAbekGbcuNy/QiT2Iy13eLi44Y9pz6oz0=; t=1708447980; x=1708537980; 
	b=kPIi3D3eH0kHucdUnBoec/UrX5QvpbumP+WN5+chy7cky4+N3URY7B2d96lfOJhj6kpN9Vk2oUJ
	YotK4cjKLtPdIXBMN/psO3YUZIg9TC9v5IChOEaLeovt3LPriUq+37vLDgZ5iA5S8BkG2TRgaOcws
	5XXxzKDKVzd+yICxKiA=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMQ-0000000GhgU-2ooi; Tue, 20 Feb 2024 19:52:51 +0300
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
Subject: [PATCH 3/8] dt-bindings: clock: qcom: Add SM7150 DISPCC clocks
Date: Tue, 20 Feb 2024 19:52:35 +0300
Message-ID: <20240220165240.154716-4-danila@jiaxyga.com>
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
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021A4088691FB60B4B8D975C14E9881615F00894C459B0CD1B9B70527C2C0076ED440A02D48E7B53F4A097DE6D425965C6EEAC3EACB7F7CF7DDACCB5262BB601CA2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BB0F1327467DA3D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E78B284398E2029E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B022B0635E15FAB2CF466CB8E830073E74665D96575DAA80CC7F00164DA146DAFE8445B8C89999728AA50765F79006370B730A9793D99025389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8BC0ADEB1C81BB362F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDA532D2019E286A79735652A29929C6C4AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C35D2D8BA2D8626268BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C33A60492226029A77089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A55B32E0DCCD16A4035002B1117B3ED69677CAF9731D008F3FB2920F75BA9A967F823CB91A9FED034534781492E4B8EEADB71243024C627CEAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB4A757186E45D9E5F80AFEFC0A66F172A59C6538203067E79D7B34FF9617EF3E673DC415E80A8BD9F1AD97FD9824DBCDB3C78CE4FDFE3C75C96C2559415958408E83764CD87F979B146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCnXLMBeDm8O0A==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFEA4C2FF93DD6D44FAC680E66E7F4C3C8C4311A3CBC79DEAA52C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C744797BB8E8ABB18049FFFDB7839CE9E76E35804B2850F208C4DF7D3620E155493BC64D59D4B362F611E60463AB16E4A
X-7FA49CB5: 0D63561A33F958A5973C95C0FF11898D8E44522BA26A14484DA9FFD629F04F298941B15DA834481FA18204E546F3947CA90F9F3818B5FC68F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006374A812122049E91A1389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C367B172B3F0F4CA5635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmJuJMkNLWqCQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add device tree bindings for the display clock controller on Qualcomm
SM7150 platform.

Co-developed-by: David Wronek <david@mainlining.org>
Signed-off-by: David Wronek <david@mainlining.org>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../bindings/clock/qcom,sm7150-dispcc.yaml    | 75 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm7150-dispcc.h    | 59 +++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-dispcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
new file mode 100644
index 000000000000..b8d6e1d05ce2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm7150-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller for SM7150
+
+maintainers:
+  - Danila Tikhonov <danila@jiaxyga.com>
+  - David Wronek <david@mainlining.org>
+  - Jens Reidel <adrian@travitia.xyz>
+
+description: |
+  Qualcomm display clock control module provides the clocks, resets and power
+  domains on SM7150.
+
+  See also:: include/dt-bindings/clock/qcom,sm7150-dispcc.h
+
+properties:
+  compatible:
+    const: qcom,sm7150-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board Always On XO source
+      - description: GPLL0 source from GCC
+      - description: Sleep clock source
+      - description: Byte clock from MDSS DSI PHY0
+      - description: Pixel clock from MDSS DSI PHY0
+      - description: Byte clock from MDSS DSI PHY1
+      - description: Pixel clock from MDSS DSI PHY1
+      - description: Link clock from DP PHY
+      - description: VCO DIV clock from DP PHY
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
+    #include <dt-bindings/clock/qcom,sm7150-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sm7150-dispcc";
+      reg = <0x0af00000 0x200000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+               <&sleep_clk>,
+               <&mdss_dsi0_phy 0>,
+               <&mdss_dsi0_phy 1>,
+               <&mdss_dsi1_phy 0>,
+               <&mdss_dsi1_phy 1>,
+               <&dp_phy 0>,
+               <&dp_phy 1>;
+      power-domains = <&rpmhpd RPMHPD_CX>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm7150-dispcc.h b/include/dt-bindings/clock/qcom,sm7150-dispcc.h
new file mode 100644
index 000000000000..285cb3e1a375
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-dispcc.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ * Copyright (c) 2024, David Wronek <david@mainlining.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM7150_H
+
+/* DISP_CC clock registers */
+#define DISP_CC_PLL0				0
+#define DISP_CC_MDSS_AHB_CLK			1
+#define DISP_CC_MDSS_AHB_CLK_SRC		2
+#define DISP_CC_MDSS_BYTE0_CLK			3
+#define DISP_CC_MDSS_BYTE0_CLK_SRC		4
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC		5
+#define DISP_CC_MDSS_BYTE0_INTF_CLK		6
+#define DISP_CC_MDSS_BYTE1_CLK			7
+#define DISP_CC_MDSS_BYTE1_CLK_SRC		8
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC		9
+#define DISP_CC_MDSS_BYTE1_INTF_CLK		10
+#define DISP_CC_MDSS_DP_AUX_CLK			11
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC		12
+#define DISP_CC_MDSS_DP_CRYPTO_CLK		13
+#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC		14
+#define DISP_CC_MDSS_DP_LINK_CLK		15
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC		16
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK		17
+#define DISP_CC_MDSS_DP_PIXEL1_CLK		18
+#define DISP_CC_MDSS_DP_PIXEL1_CLK_SRC		19
+#define DISP_CC_MDSS_DP_PIXEL_CLK		20
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC		21
+#define DISP_CC_MDSS_ESC0_CLK			22
+#define DISP_CC_MDSS_ESC0_CLK_SRC		23
+#define DISP_CC_MDSS_ESC1_CLK			24
+#define DISP_CC_MDSS_ESC1_CLK_SRC		25
+#define DISP_CC_MDSS_MDP_CLK			26
+#define DISP_CC_MDSS_MDP_CLK_SRC		27
+#define DISP_CC_MDSS_MDP_LUT_CLK		28
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK		29
+#define DISP_CC_MDSS_PCLK0_CLK			30
+#define DISP_CC_MDSS_PCLK0_CLK_SRC		31
+#define DISP_CC_MDSS_PCLK1_CLK			32
+#define DISP_CC_MDSS_PCLK1_CLK_SRC		33
+#define DISP_CC_MDSS_ROT_CLK			34
+#define DISP_CC_MDSS_ROT_CLK_SRC		35
+#define DISP_CC_MDSS_RSCC_AHB_CLK		36
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK		37
+#define DISP_CC_MDSS_VSYNC_CLK			38
+#define DISP_CC_MDSS_VSYNC_CLK_SRC		39
+#define DISP_CC_XO_CLK_SRC			40
+#define DISP_CC_SLEEP_CLK			41
+#define DISP_CC_SLEEP_CLK_SRC			42
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC				0
+
+#endif
-- 
2.43.2


