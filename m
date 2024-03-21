Return-Path: <linux-kernel+bounces-110645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82A8861B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562E1B21A84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81EA13664B;
	Thu, 21 Mar 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="ta915xDV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="CEqLLd8X"
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF5135A72;
	Thu, 21 Mar 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052965; cv=none; b=T/RwyAvDoDmnD1wRkprD7R4p7WAp653Dx/l/JHFsUKm+iGstn7nVqguHpw30pvjaGvXMQtLPGmVfMfvg81vt/1LSn1qYVWwa5PMsWjcXcpTkpVjpInWhNPBntukBhn6ozhaNSM2NsaJcOTFFJSBtCaAN/1NmViwjUwZxEBR0UNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052965; c=relaxed/simple;
	bh=UCAnAAtSuPVWQEsZqwrA6E+E+a+w9YR1nZK0vA5uF7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKVnVEojhl/lUsLXxiGXEfXZ+TyMP1kwWOzXm2jtEDj7T//cip8vijo74MeLGn9SF5ZsC9C3DvFmJyls4+jUXlSFLNGcKrysIFGxIRAhwpSif83AGvtu0EVo9+5VSt66xp4XqOHm54rNRXVHgSCVhsry9gFdL/11GilKAPIDHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=ta915xDV; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=CEqLLd8X; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Sq1hRxPihYAm9AttFJqQInvc9/J+1ZCvq0CMmPYhARw=;
	t=1711052963;x=1711142963; 
	b=ta915xDVccSwdLnwqi7jxkU3bgQR3LcY2PfoMMLPXROSXf83Dh+hgvVfa5rd+GuuFAV28VeBXXKPmdm9wvoBMP3RfXb7EVx23aglqSaiaB068RHeXxPtNDD1yPTfRDmRY1dW6jjvt4WGyQhIzsPMv1ZBf31CF6RImI3V0LhOzH0=;
Received: from [10.12.4.2] (port=51846 helo=smtp29.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rnP2J-00DkXb-Kp; Thu, 21 Mar 2024 23:29:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Sq1hRxPihYAm9AttFJqQInvc9/J+1ZCvq0CMmPYhARw=; t=1711052955; x=1711142955; 
	b=CEqLLd8XMV2QhePLZYHMyRlW3SY0n+UG/FBEdGbjW+Z+TVhzny0r2hyRdpfpEY3yb074RHaXryt
	t+MNbOf9l26PXw2EABp7NQZisI/62QRorqirMWaIlj/pOBEVZd3HPbFXtq/NISsllU/WG2WTCUX8q
	jAPlyofFRZ8br1Y1+V8=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rnP24-00000005qz4-3IYt; Thu, 21 Mar 2024 23:29:01 +0300
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
Subject: [PATCH v2 2/7] dt-bindings: clock: qcom: Add SM7150 DISPCC clocks
Date: Thu, 21 Mar 2024 23:28:09 +0300
Message-ID: <20240321202814.59835-3-danila@jiaxyga.com>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92CB91DAA594FB6BF71C75EE959EE1452C6A7FC4172EA4E06182A05F53808504017E14CB40AD01A4BD27678DDAA8063141FA0925F93B6C68CDF7EF9FDA0AB3C107CBF1C18CED4D92F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D96557C5EC1D5BA4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377845AD97F799C6E88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8942956B234B440AFB82A659056168E43CC4E6D586A026F63CC7F00164DA146DAFE8445B8C89999728AA50765F7900637FD2911E685725BF8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80CABCCA60F52D7EBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB355ED1E20F5346AC0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C345DE7C2FFE6F0182BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C300D476B8B50F5EBD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A50D55FE74290F1C885002B1117B3ED696832F311C8EC727D719AC5B239BAD4335823CB91A9FED034534781492E4B8EEADF1165EFABA1780A6C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF1C9DFCA7A9F93B4AF8C72C6C9FD115B0B449D7D7687BC38B68149F144258457BD9E67331CBA3B6E4A5E652D4FCD6795A56DBC3CC9D26ED0807F407391B6C10D8CFE9BC3599BF4691146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes272kSmbAhPK2g==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498123F80C9C64FBB36E1356DD24693B53BC3F09FA5D26EF7C3B8ED3E8F5D8AFB91F2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A873E06F0BBE0AC598D6090D1BBB74CFF8AFBFA1F544574268F3CF0E9FE49B6993595096ACAD5B569E7C7848CBABB1B253D7A9D56C70A0D868007C99212A9577
X-7FA49CB5: 0D63561A33F958A599A767676139B63AAE0945276848E927E39289C7DD464A8E8941B15DA834481FA18204E546F3947C712411567E54C8E9F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637473B9BD420DAE8D3389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C369A9B21EF3CACE7135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes26NDhdSSlNHZw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add device tree bindings for the display clock controller on Qualcomm
SM7150 platform.

Co-developed-by: David Wronek <david@mainlining.org>
Signed-off-by: David Wronek <david@mainlining.org>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 000000000000..fc1fefe8fd72
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
+#ifndef _DT_BINDINGS_CLK_QCOM_DISPCC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_DISPCC_SM7150_H
+
+/* DISPCC clock registers */
+#define DISPCC_PLL0				0
+#define DISPCC_MDSS_AHB_CLK			1
+#define DISPCC_MDSS_AHB_CLK_SRC			2
+#define DISPCC_MDSS_BYTE0_CLK			3
+#define DISPCC_MDSS_BYTE0_CLK_SRC		4
+#define DISPCC_MDSS_BYTE0_DIV_CLK_SRC		5
+#define DISPCC_MDSS_BYTE0_INTF_CLK		6
+#define DISPCC_MDSS_BYTE1_CLK			7
+#define DISPCC_MDSS_BYTE1_CLK_SRC		8
+#define DISPCC_MDSS_BYTE1_DIV_CLK_SRC		9
+#define DISPCC_MDSS_BYTE1_INTF_CLK		10
+#define DISPCC_MDSS_DP_AUX_CLK			11
+#define DISPCC_MDSS_DP_AUX_CLK_SRC		12
+#define DISPCC_MDSS_DP_CRYPTO_CLK		13
+#define DISPCC_MDSS_DP_CRYPTO_CLK_SRC		14
+#define DISPCC_MDSS_DP_LINK_CLK			15
+#define DISPCC_MDSS_DP_LINK_CLK_SRC		16
+#define DISPCC_MDSS_DP_LINK_INTF_CLK		17
+#define DISPCC_MDSS_DP_PIXEL1_CLK		18
+#define DISPCC_MDSS_DP_PIXEL1_CLK_SRC		19
+#define DISPCC_MDSS_DP_PIXEL_CLK		20
+#define DISPCC_MDSS_DP_PIXEL_CLK_SRC		21
+#define DISPCC_MDSS_ESC0_CLK			22
+#define DISPCC_MDSS_ESC0_CLK_SRC		23
+#define DISPCC_MDSS_ESC1_CLK			24
+#define DISPCC_MDSS_ESC1_CLK_SRC		25
+#define DISPCC_MDSS_MDP_CLK			26
+#define DISPCC_MDSS_MDP_CLK_SRC			27
+#define DISPCC_MDSS_MDP_LUT_CLK			28
+#define DISPCC_MDSS_NON_GDSC_AHB_CLK		29
+#define DISPCC_MDSS_PCLK0_CLK			30
+#define DISPCC_MDSS_PCLK0_CLK_SRC		31
+#define DISPCC_MDSS_PCLK1_CLK			32
+#define DISPCC_MDSS_PCLK1_CLK_SRC		33
+#define DISPCC_MDSS_ROT_CLK			34
+#define DISPCC_MDSS_ROT_CLK_SRC			35
+#define DISPCC_MDSS_RSCC_AHB_CLK		36
+#define DISPCC_MDSS_RSCC_VSYNC_CLK		37
+#define DISPCC_MDSS_VSYNC_CLK			38
+#define DISPCC_MDSS_VSYNC_CLK_SRC		39
+#define DISPCC_XO_CLK_SRC			40
+#define DISPCC_SLEEP_CLK			41
+#define DISPCC_SLEEP_CLK_SRC			42
+
+/* DISPCC GDSCR */
+#define MDSS_GDSC				0
+
+#endif
-- 
2.44.0


