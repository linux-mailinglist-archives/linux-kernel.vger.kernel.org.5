Return-Path: <linux-kernel+bounces-110643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D661B8861AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75D6B21CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E7134CF7;
	Thu, 21 Mar 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="zMBKtZwS"
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [95.163.41.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F4134CD3;
	Thu, 21 Mar 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052955; cv=none; b=r3K2zpUycvGrZmbo0gXCuZm3gmNpILPKxCFKUIc8UrVLIlKEmRo8Sm+V1XA0NEm3+V6E6LbHV6oRNTRTN0ECyCKMF/PAq9NUGHXoQQEXbwTdgLHNGD7QgIit2mwguZm9tFrUSwxEs1oC7Lnk+77lKmPF7Qw2bF6Pq0a3IuJxmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052955; c=relaxed/simple;
	bh=cLWAvoXIuG2er/5a7LNr2lD4EAoPAxqIMzub1Hf3S1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsbVBCym/FUMTyIGdshUFnBVt5Nv8ssJ/WDRqeABMNGFVQwUMObrgsNwwr+fXEIPNAGiFi+9bNIXdh/zw4Nv5qNgTxiOFqWYT78SylvwUY33jgDWCpAlrMlHnswUNB/ZtnQrzc+fHjO1D9Cqdr7+si1yufUIokmPZGWabCi1UYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=zMBKtZwS; arc=none smtp.client-ip=95.163.41.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=K+5KlMN21LdFThHBEYgFrodhlXF/ngKkx8ddu8jznCQ=; t=1711052952; x=1711142952; 
	b=zMBKtZwSPk24AMgIATtUEPczeh20yGvR/wxX7k0wgeubFRUU8fzZMfbBIAqu3I9C6b0IfSE3Z2h
	VSg+Ur1Jy7Mh3xdHuJ720gso2jBSaiTI5GlXCRbsCmOzAkAIJF7AjbXYNO8A7bSd97Yzv7vbwD9qS
	dm7CJfJ44vE4y+f8AB4=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rnP2D-00000005qz4-349d; Thu, 21 Mar 2024 23:29:10 +0300
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
Subject: [PATCH v2 6/7] dt-bindings: clock: qcom: Add SM7150 VIDEOCC clocks
Date: Thu, 21 Mar 2024 23:28:13 +0300
Message-ID: <20240321202814.59835-7-danila@jiaxyga.com>
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
Authentication-Results: smtp29.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92CB91DAA594FB6BF67B30F6EBAB4B2B55AC96DE1341DF4CE182A05F538085040B7367EAEECB24D37D27678DDAA80631470D4D15E520FC7C0DF7EF9FDA0AB3C108B3203750C901C87
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7705F446BE41E38A1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371A4E0E763A740679EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871B93669BB60C80329A2E791B4B5905063CE834D507070DD98A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE79AE9BAF3542BD4619FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C390BCC82C2C62A6D1117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF53A3A193078A0227BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6060BBCF8C42F83A376E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B697DDD8CAF9594832089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A58300506F94444C5C5002B1117B3ED6969265FF17F2B7A9260E58516B1639A14B823CB91A9FED034534781492E4B8EEADD0953842B444AAC3C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB8ACE48CB86DC2D324F07548B29EB861539BB72F0DD305A4D124267E3C0D58D566401EE05C14F77DA5E652D4FCD6795AA610F3CF0D02C18307F407391B6C10D8B711E7A1DA1CE9CA146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes27urFJl+VXrbg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498123F80C9C64FBB36EF33F69C7E48EA1FBFCA5F338C581A81CE648D228684D36CB2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add device tree bindings for the video clock controller on Qualcomm
SM7150 platform.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 000000000000..d86e0fbb159a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7150-videocc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEOCC_SM7150_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEOCC_SM7150_H
+
+#define VIDEOCC_PLL0			0
+#define VIDEOCC_IRIS_AHB_CLK		1
+#define VIDEOCC_IRIS_CLK_SRC		2
+#define VIDEOCC_MVS0_AXI_CLK		3
+#define VIDEOCC_MVS0_CORE_CLK		4
+#define VIDEOCC_MVS1_AXI_CLK		5
+#define VIDEOCC_MVS1_CORE_CLK		6
+#define VIDEOCC_MVSC_CORE_CLK		7
+#define VIDEOCC_MVSC_CTL_AXI_CLK	8
+#define VIDEOCC_VENUS_AHB_CLK		9
+#define VIDEOCC_XO_CLK			10
+#define VIDEOCC_XO_CLK_SRC		11
+
+/* VIDEOCC GDSCRs */
+#define VENUS_GDSC			0
+#define VCODEC0_GDSC			1
+#define VCODEC1_GDSC			2
+
+#endif
-- 
2.44.0


