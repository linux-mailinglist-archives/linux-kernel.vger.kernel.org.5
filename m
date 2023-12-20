Return-Path: <linux-kernel+bounces-6755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F961819D10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FE2B266C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B620DF3;
	Wed, 20 Dec 2023 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="PNv9U6YK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [159.69.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75C20B02;
	Wed, 20 Dec 2023 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description;
	bh=3RDmDVlnk2mcGyH1E2TgKjgnExaduXtEXQzTUb/7LfE=; b=PNv9U6YK4dcik1VaX+PEEqvsXr
	RHRqWbas9TGMFLf3Owq7P+rXwsp2q3PJqDY50o9HaG95EpX+AamE90oyZHB4Qi3tzia+8yfmAWAI7
	9f3rzI9G5svTx/AiIS5Sf4C020jEaeXvXbb8APIi1l6Xji0mrlOP2jbebBHRW/6lO9WZ3rbDTNvoI
	WPpnhOZ+lLSXtOsBvUmqqyJYdlLAkOhcxK7xD7fkS5nBToVhQa2euOdgw9gmT/qMbmxrCs4xLuHj2
	IQd8UjKTq6itXrAH8kNDmPFPmBK1EEirVOJydrPc5AmPPS0LArncyqzu2WN0e1OsYw7nmYxHGgdmt
	xPS2jDvA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
	by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
	id 1rFtya-00DKtz-0D;
	Wed, 20 Dec 2023 11:38:56 +0100
From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date: Wed, 20 Dec 2023 11:38:49 +0100
Subject: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm MSM8909 DT
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-icc-msm8909-v2-1-3b68bbed2891@kernkonzept.com>
References: <20231220-icc-msm8909-v2-0-3b68bbed2891@kernkonzept.com>
In-Reply-To: <20231220-icc-msm8909-v2-0-3b68bbed2891@kernkonzept.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>, 
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

From: Adam Skladowski <a39.skl@gmail.com>

Add bindings for Qualcomm MSM8909 Network-On-Chip interconnect devices.

[Stephan: Drop separate mm-snoc that exists downstream since it's
 actually the same NoC as SNoC in hardware]

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  3 +
 include/dt-bindings/interconnect/qcom,msm8909.h    | 93 ++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 08c1c6b9d7cf..5aaa92a7cef7 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -23,6 +23,9 @@ properties:
 
   compatible:
     enum:
+      - qcom,msm8909-bimc
+      - qcom,msm8909-pcnoc
+      - qcom,msm8909-snoc
       - qcom,msm8916-bimc
       - qcom,msm8916-pcnoc
       - qcom,msm8916-snoc
diff --git a/include/dt-bindings/interconnect/qcom,msm8909.h b/include/dt-bindings/interconnect/qcom,msm8909.h
new file mode 100644
index 000000000000..76365d8aec21
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8909.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm MSM8909 interconnect IDs
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8909_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8909_H
+
+/* BIMC fabric */
+#define MAS_APPS_PROC			0
+#define MAS_OXILI			1
+#define MAS_SNOC_BIMC_0			2
+#define MAS_SNOC_BIMC_1			3
+#define MAS_TCU_0			4
+#define MAS_TCU_1			5
+#define SLV_EBI				6
+#define SLV_BIMC_SNOC			7
+
+/* PCNOC fabric */
+#define MAS_AUDIO			0
+#define MAS_SPDM			1
+#define MAS_DEHR			2
+#define MAS_QPIC			3
+#define MAS_BLSP_1			4
+#define MAS_USB_HS			5
+#define MAS_CRYPTO			6
+#define MAS_SDCC_1			7
+#define MAS_SDCC_2			8
+#define MAS_SNOC_PCNOC			9
+#define PCNOC_M_0			10
+#define PCNOC_M_1			11
+#define PCNOC_INT_0			12
+#define PCNOC_INT_1			13
+#define PCNOC_S_0			14
+#define PCNOC_S_1			15
+#define PCNOC_S_2			16
+#define PCNOC_S_3			17
+#define PCNOC_S_4			18
+#define PCNOC_S_5			19
+#define PCNOC_S_7			20
+#define SLV_TCSR			21
+#define SLV_SDCC_1			22
+#define SLV_BLSP_1			23
+#define SLV_CRYPTO_0_CFG		24
+#define SLV_MESSAGE_RAM			25
+#define SLV_PDM				26
+#define SLV_PRNG			27
+#define SLV_USB_HS			28
+#define SLV_QPIC			29
+#define SLV_SPDM			30
+#define SLV_SDCC_2			31
+#define SLV_AUDIO			32
+#define SLV_DEHR_CFG			33
+#define SLV_SNOC_CFG			34
+#define SLV_QDSS_CFG			35
+#define SLV_USB_PHY			36
+#define SLV_CAMERA_SS_CFG		37
+#define SLV_DISP_SS_CFG			38
+#define SLV_VENUS_CFG			39
+#define SLV_TLMM			40
+#define SLV_GPU_CFG			41
+#define SLV_IMEM_CFG			42
+#define SLV_BIMC_CFG			43
+#define SLV_PMIC_ARB			44
+#define SLV_TCU				45
+#define SLV_PCNOC_SNOC			46
+
+/* SNOC fabric */
+#define MAS_QDSS_BAM			0
+#define MAS_BIMC_SNOC			1
+#define MAS_MDP				2
+#define MAS_PCNOC_SNOC			3
+#define MAS_VENUS			4
+#define MAS_VFE				5
+#define MAS_QDSS_ETR			6
+#define MM_INT_0			7
+#define MM_INT_1			8
+#define MM_INT_2			9
+#define MM_INT_BIMC			10
+#define QDSS_INT			11
+#define SNOC_INT_0			12
+#define SNOC_INT_1			13
+#define SNOC_INT_BIMC			14
+#define SLV_KPSS_AHB			15
+#define SLV_SNOC_BIMC_0			16
+#define SLV_SNOC_BIMC_1			17
+#define SLV_IMEM			18
+#define SLV_SNOC_PCNOC			19
+#define SLV_QDSS_STM			20
+#define SLV_CATS_0			21
+#define SLV_CATS_1			22
+
+#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_MSM8909_H */

-- 
2.39.2


