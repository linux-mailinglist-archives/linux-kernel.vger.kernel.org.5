Return-Path: <linux-kernel+bounces-70491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E0C859894
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A88B21240
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B26F085;
	Sun, 18 Feb 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="ktLip7Bj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="N/WPlfUZ"
Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9F1E4A7;
	Sun, 18 Feb 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281194; cv=none; b=SYE2S+OY40n5JdxYpKK4mlnAPV1iAhpb2mwPemNLJuvSvBCoajeQN+i/CY0UhK/0ZVtk3g9ou1BXHep9sBDi3OTcGzhv6naVTOtYDC4JmB3qXIr4Rx2G2vhJ+xhnZomH7Xl3SvSBV02j1H4TJKu017AcBPjhVUNFcGVRzYc6Dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281194; c=relaxed/simple;
	bh=MJ2yJDIDjq12zEnVXgNJlO8R8+B73qPnMVwMS6xFYdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImnGulobLhuzDFvlNODDFSY5HFiJsUnU54JbIQvaAh9y+S5W1ByFN87aYknzQKxiElIW4oZl5RWTaY5O7UAhrYVtzz9nme6U6CUkhNHJV+030ExX6u0pQLBYRtyoPPCrz2FUARPwuP9O/8ZNRdzSEAJMp5thDYzk5eKPcbkKwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=ktLip7Bj; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=N/WPlfUZ; arc=none smtp.client-ip=79.137.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=5atT5maYDjrdnQKU7RIdGLNehtccSbhrS0G6TsWGU/E=;
	t=1708281192;x=1708371192; 
	b=ktLip7Bj1k4Bqtg3xp/djPbGTwBj+VN4uCiMiqx7ZPk9m/m45pE82/e6G0GjhbvdjIC78QXHVkw9E7A36jmodV/tFMGPof0GKuNZRKf9orw9YYlAHpcNh5T3fbw+9/oh5uGWbaXgY4zCAdV/s1OuWeRUlwxguar16LE30iAp1bU=;
Received: from [10.12.4.36] (port=55826 helo=smtp59.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rblyJ-00EwaK-Fc; Sun, 18 Feb 2024 21:33:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=5atT5maYDjrdnQKU7RIdGLNehtccSbhrS0G6TsWGU/E=; t=1708281183; x=1708371183; 
	b=N/WPlfUZDGQEWU2xtizwWjY1FZV1OBF3J1VK/QY3G8ElBTbO+mLyXfvmk2N9c0R11UbD7EK7KTi
	3Vr2OsiTuXOk53xj6CZwxBvnpEQzD0uyzNEOwMu0Q0JQ4rIJTaWq1GctQMnNC3X5GS4l9HQxKaj+L
	n81pCEexYk/lhqw5do8=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbly5-00000001iw9-17VM; Sun, 18 Feb 2024 21:32:49 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	djakov@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
Date: Sun, 18 Feb 2024 21:32:38 +0300
Message-ID: <20240218183239.85319-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218183239.85319-1-danila@jiaxyga.com>
References: <20240218183239.85319-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021F4B2298ADA324AF81BB1825BF5AE0A1600894C459B0CD1B9C8630333785299FBC7109C2D567B645AF811A5454975A9D5F215CD5087B8A2F9ED199C4BD4F2E418
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE714CDB4604828AA7AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375D6F9E2FC7F7A8E98638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FA71D38757B880BAF545006DEB2F19AE3D306521FC39FF6FCC7F00164DA146DAFE8445B8C89999728AA50765F7900637028599BB38096F4F389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C2B5EEE3591E0D35F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C2D01283D1ACF37BA03F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3C4D4DFE5459F50CDBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF27ED053E960B195E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3E83E68DE7309FD8D35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A51776F85113EA989E5002B1117B3ED696129A5A87CC4926201BDDAE3D1EA49BEA823CB91A9FED034534781492E4B8EEAD2739D626790C8313C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF475E32FCC0DB6F1DCCED3347300F09686276AE96264BBA897E12443A8523B167C7834276CD05239734E84B500378195FE647307F233F13794C37877C5488D6FEB27352AD52E18ED2AF108DC32EA72A8402C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxus34xW/pUfPgQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498103638563C1357B8AAC4385294E02B5FB6DB0AB1FB1DDF49D292E6202043E14132C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C279666E6C2610F6A049FFFDB7839CE9E8F5A60B08382AFE39D35204CB2A6F5F08588E9B1301C8CB485B1AF99D2ECD754
X-7FA49CB5: 0D63561A33F958A56B65E4262AB866C3A855EB6D6F904B2FB9B34D7F4F05369A8941B15DA834481FA18204E546F3947C16F36C0CB6DCE122F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F3DB775AA22245C5389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C36153467CB5E707FD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxutFcYvFH/pLCg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The Qualcomm SM7150 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../interconnect/qcom,sm7150-rpmh.yaml        |  88 ++++++++++
 .../interconnect/qcom,sm7150-rpmh.h           | 150 ++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
new file mode 100644
index 000000000000..604822ed4adc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm7150-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM7150
+
+maintainers:
+  - Danila Tikhonov <danila@jiaxyga.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm7150-aggre1-noc
+      - qcom,sm7150-aggre2-noc
+      - qcom,sm7150-compute-noc
+      - qcom,sm7150-config-noc
+      - qcom,sm7150-dc-noc
+      - qcom,sm7150-gem-noc
+      - qcom,sm7150-mc-virt
+      - qcom,sm7150-mmss-noc
+      - qcom,sm7150-system-noc
+
+  reg:
+    maxItems: 1
+
+  '#interconnect-cells': true
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    allOf:
+      - $ref: qcom,rpmh-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm7150-camnoc-virt
+
+      '#interconnect-cells': true
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mc_virt: interconnect@1380000 {
+        compatible = "qcom,sm7150-mc-virt";
+        reg = <0x01380000 0x40000>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    system_noc: interconnect@1620000 {
+        compatible = "qcom,sm7150-system-noc";
+        reg = <0x01620000 0x40000>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+
+        camnoc_virt: interconnect-0 {
+            compatible = "qcom,sm7150-camnoc-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm7150-rpmh.h b/include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
new file mode 100644
index 000000000000..1f610eb832aa
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Qualcomm SM7150 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM7150_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM7150_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QUP_0			1
+#define MASTER_TSIF			2
+#define MASTER_EMMC			3
+#define MASTER_SDCC_2			4
+#define MASTER_SDCC_4			5
+#define MASTER_UFS_MEM			6
+#define A1NOC_SNOC_SLV			7
+#define SLAVE_SERVICE_A1NOC		8
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QUP_1			2
+#define MASTER_CNOC_A2NOC		3
+#define MASTER_CRYPTO_CORE_0		4
+#define MASTER_IPA			5
+#define MASTER_PCIE			6
+#define MASTER_QDSS_ETR			7
+#define MASTER_USB3			8
+#define A2NOC_SNOC_SLV			9
+#define SLAVE_ANOC_PCIE_GEM_NOC		10
+#define SLAVE_SERVICE_A2NOC		11
+
+#define MASTER_CAMNOC_HF0_UNCOMP	0
+#define MASTER_CAMNOC_RT_UNCOMP		1
+#define MASTER_CAMNOC_SF_UNCOMP		2
+#define MASTER_CAMNOC_NRT_UNCOMP	3
+#define SLAVE_CAMNOC_UNCOMP		4
+
+#define MASTER_NPU			0
+#define SLAVE_CDSP_GEM_NOC		1
+
+#define MASTER_SPDM			0
+#define SNOC_CNOC_MAS			1
+#define MASTER_QDSS_DAP			2
+#define SLAVE_A1NOC_CFG			3
+#define SLAVE_A2NOC_CFG			4
+#define SLAVE_AHB2PHY_NORTH		5
+#define SLAVE_AHB2PHY_SOUTH		6
+#define SLAVE_AHB2PHY_WEST		7
+#define SLAVE_AOP			8
+#define SLAVE_AOSS			9
+#define SLAVE_CAMERA_CFG		10
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG	11
+#define SLAVE_CAMERA_RT_THROTTLE_CFG	12
+#define SLAVE_CLK_CTL			13
+#define SLAVE_CDSP_CFG			14
+#define SLAVE_RBCPR_CX_CFG		15
+#define SLAVE_RBCPR_MX_CFG		16
+#define SLAVE_CRYPTO_0_CFG		17
+#define SLAVE_CNOC_DDRSS		18
+#define SLAVE_DISPLAY_CFG		19
+#define SLAVE_DISPLAY_THROTTLE_CFG	20
+#define SLAVE_EMMC_CFG			21
+#define SLAVE_GLM			22
+#define SLAVE_GRAPHICS_3D_CFG		23
+#define SLAVE_IMEM_CFG			24
+#define SLAVE_IPA_CFG			25
+#define SLAVE_CNOC_MNOC_CFG		26
+#define SLAVE_PCIE_CFG			27
+#define SLAVE_PDM			28
+#define SLAVE_PIMEM_CFG			29
+#define SLAVE_PRNG			30
+#define SLAVE_QDSS_CFG			31
+#define SLAVE_QUP_0			32
+#define SLAVE_QUP_1			33
+#define SLAVE_SDCC_2			34
+#define SLAVE_SDCC_4			35
+#define SLAVE_SNOC_CFG			36
+#define SLAVE_SPDM_WRAPPER		37
+#define SLAVE_TCSR			38
+#define SLAVE_TLMM_NORTH		39
+#define SLAVE_TLMM_SOUTH		40
+#define SLAVE_TLMM_WEST			41
+#define SLAVE_TSIF			42
+#define SLAVE_UFS_MEM_CFG		43
+#define SLAVE_USB3			44
+#define SLAVE_VENUS_CFG			45
+#define SLAVE_VENUS_CVP_THROTTLE_CFG	46
+#define SLAVE_VENUS_THROTTLE_CFG	47
+#define SLAVE_VSENSE_CTRL_CFG		48
+#define SLAVE_CNOC_A2NOC		49
+#define SLAVE_SERVICE_CNOC		50
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_GEM_NOC_CFG		1
+#define SLAVE_LLCC_CFG			2
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_SYS_TCU			1
+#define MASTER_GEM_NOC_CFG		2
+#define MASTER_COMPUTE_NOC		3
+#define MASTER_MNOC_HF_MEM_NOC		4
+#define MASTER_MNOC_SF_MEM_NOC		5
+#define MASTER_GEM_NOC_PCIE_SNOC	6
+#define MASTER_SNOC_GC_MEM_NOC		7
+#define MASTER_SNOC_SF_MEM_NOC		8
+#define MASTER_GRAPHICS_3D		9
+#define SLAVE_MSS_PROC_MS_MPU_CFG	10
+#define SLAVE_GEM_NOC_SNOC		11
+#define SLAVE_LLCC			12
+#define SLAVE_SERVICE_GEM_NOC		13
+
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI_CH0			1
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_HF0		1
+#define MASTER_CAMNOC_NRT		2
+#define MASTER_CAMNOC_RT		3
+#define MASTER_CAMNOC_SF		4
+#define MASTER_MDP_PORT0		5
+#define MASTER_MDP_PORT1		6
+#define MASTER_ROTATOR			7
+#define MASTER_VIDEO_P0			8
+#define MASTER_VIDEO_P1			9
+#define MASTER_VIDEO_PROC		10
+#define SLAVE_MNOC_SF_MEM_NOC		11
+#define SLAVE_MNOC_HF_MEM_NOC		12
+#define SLAVE_SERVICE_MNOC		13
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_PIMEM			4
+#define MASTER_GIC			5
+#define SLAVE_APPSS			6
+#define SNOC_CNOC_SLV			7
+#define SLAVE_SNOC_GEM_NOC_GC		8
+#define SLAVE_SNOC_GEM_NOC_SF		9
+#define SLAVE_OCIMEM			10
+#define SLAVE_PIMEM			11
+#define SLAVE_SERVICE_SNOC		12
+#define SLAVE_QDSS_STM			13
+#define SLAVE_TCU			14
+
+#endif
-- 
2.43.2


