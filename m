Return-Path: <linux-kernel+bounces-73385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4685C1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFF91C21CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F376C87;
	Tue, 20 Feb 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="XFXcNI9k"
Received: from smtp54.i.mail.ru (smtp54.i.mail.ru [95.163.41.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1176906;
	Tue, 20 Feb 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447984; cv=none; b=kzwNCHQzdnb+VbLRCMY5ABThsjwFZdPxso4hJ0zzCQJxZu2ZQVMerlyGKi7yj8foiw4Nl3Vo3g+QXxS34bd7W6VYG1enuqUnVtuMn9q1Fq6kRC0u45wCtwInf8IXnASiLJDrWmM/oZhd5NGhEA1XouebsZeU3LYHiwDBPG3OuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447984; c=relaxed/simple;
	bh=kkvHLO5D6R2fb0lacT+7Yr4kOA/UjRvi5KmYEo9bDlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+LkPl4ubeUc+cFgG6iM+0Pmj+xfIUx6jFbiMybzhc8oLQEHBUmnekua6qFiyCl17KHg4U+cUjrdKpOlPTKY/9xkuCAiR/EogIZMflRaB9Z4oe40BZA0P6FOKJ1eYIy6oslADNi/Aadzq1zKBBpAuKVAZ0lvg7euKbXhN+IAO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=XFXcNI9k; arc=none smtp.client-ip=95.163.41.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=HaAenO38aYgO3SX3T9goWNj7c1EzuyFyfEsEIPj1S/4=; t=1708447982; x=1708537982; 
	b=XFXcNI9kvWHhe+HhxPnbw5YN4X6mrLYkTOzllDL3Tnn03E6yUJmX3mDEgpwfahtOK5Ccz2YNZBI
	xwFFkQj48UBnNGsVbnF0xjydyutc/gDJ5jcMMdiNTf6zjCquUSwZgSEDGtjuBYQShWCfB8IFY7Wyg
	RUkkKc3sPmGgg15QLgA=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMZ-0000000GhgU-1ZrZ; Tue, 20 Feb 2024 19:53:00 +0300
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
Subject: [PATCH 7/8] dt-bindings: clock: qcom: Add SM7150 VIDEOCC clocks
Date: Tue, 20 Feb 2024 19:52:39 +0300
Message-ID: <20240220165240.154716-8-danila@jiaxyga.com>
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
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD99B083F863FC6FF42EC5F4F79E60DB7F058691BDE7945F3E11313CFAB8367EF908E2BE116634AD74DE0BE94819879355D40A02D48E7B53F4AF30574DC6270D4CFEAC3EACB7F7CF7DD2890F9C47E136152
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72FFC9A718DD021A9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BA14B6CBCF09CA1D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E6A98B7A8BE353A4CF466CB8E830073E9335B4519B81B677CC7F00164DA146DAFE8445B8C89999728AA50765F7900637E5FAC37A846F0F679FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3BCA4DA3BE1BC1572CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22493E8FAB8B759CF4B776E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B91FD04232D5959003AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B716A69B0CBCFD959EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5A69A0A92706172085002B1117B3ED6967FF201458AAAB7725D145BB8EF0DE66B823CB91A9FED034534781492E4B8EEAD09F854029C6BD0DAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF115F93CAFAD33D0038C2C4FEB9685B1924DB645ED3E7AF1A0C94E78BA73A3412A30287D0F4871F18F1AD97FD9824DBCD610CB4A06F248B18C96C25594159584067FC32A11DA7A536146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmJuJMkNLWqCQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFE56704ABB56AC4A0FF86EB3745487767D0507B13466E2BB032C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add device tree bindings for the video clock controller on Qualcomm
SM7150 platform.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../bindings/clock/qcom,sm7150-videocc.yaml   | 58 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm7150-videocc.h   | 28 +++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-videocc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
new file mode 100644
index 000000000000..037ffc71e70e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm7150-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller on SM7150
+
+maintainers:
+  - Danila Tikhonov <danila@jiaxyga.com>
+  - David Wronek <david@mainlining.org>
+  - Jens Reidel <adrian@travitia.xyz>
+
+description: |
+  Qualcomm video clock control module provides the clocks, resets and power
+  domains on SM7150.
+
+  See also:: include/dt-bindings/clock/qcom,videocc-sm7150.h
+
+properties:
+  compatible:
+    const: qcom,sm7150-videocc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board Always On XO source
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
+    videocc: clock-controller@ab00000 {
+      compatible = "qcom,sm7150-videocc";
+      reg = <0x0ab00000 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>;
+      power-domains = <&rpmhpd RPMHPD_CX>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm7150-videocc.h b/include/dt-bindings/clock/qcom,sm7150-videocc.h
new file mode 100644
index 000000000000..ac30b3d45496
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-videocc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM7150_H
+
+#define VIDEO_PLL0			0
+#define VIDEO_CC_IRIS_AHB_CLK		1
+#define VIDEO_CC_IRIS_CLK_SRC		2
+#define VIDEO_CC_MVS0_AXI_CLK		3
+#define VIDEO_CC_MVS0_CORE_CLK		4
+#define VIDEO_CC_MVS1_AXI_CLK		5
+#define VIDEO_CC_MVS1_CORE_CLK		6
+#define VIDEO_CC_MVSC_CORE_CLK		7
+#define VIDEO_CC_MVSC_CTL_AXI_CLK	8
+#define VIDEO_CC_VENUS_AHB_CLK		9
+#define VIDEO_CC_XO_CLK			10
+#define VIDEO_CC_XO_CLK_SRC		11
+
+/* VIDEO_CC GDSCRs */
+#define VENUS_GDSC			0
+#define VCODEC0_GDSC			1
+#define VCODEC1_GDSC			2
+
+#endif
-- 
2.43.2


