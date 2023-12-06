Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3C80728A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378948AbjLFOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378925AbjLFOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:35:39 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79875D40;
        Wed,  6 Dec 2023 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=zSAHOiDjyRqwPc9zqqOqQG05HXYA3HkbrsvV9T3NPok=; b=lrHWrDALDYQv8PqlWjl6yBc6PI
        DpibrXcRpoKkGEf8z93PRpQS5tHZTQfc+pMZ6vVp3x6XNA5v0TF+0/E2jGATADQlnel1MfMP5mpcR
        zQzRhHHwq88RyEiaAGuwmZ+XmZzR0VMQVTwv2sDe0BW/xV0P4SS40c3sIKyMKTv7+bVj5b3rRI7YH
        qmCBFsouvF/cK6xCPM490KpR7vJnKpv5tQSZj9tNYkOvk3GlstkF0ZyJYD8D02yBho/rFKfsPsWiL
        iQdBnQfR1RjtMPqvygWeb2ObNVyuEwwBeXbH0eP/X6WjBiCchvKwJK27Qlq2OTJT+XSn8FAxPj6EU
        wd64QgdA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1rAt01-00AX1t-0T;
        Wed, 06 Dec 2023 15:35:41 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 06 Dec 2023 15:35:29 +0100
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm MSM8909 DT
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-icc-msm8909-v1-1-fe0dd632beff@kernkonzept.com>
References: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com>
In-Reply-To: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Skladowski <a39.skl@gmail.com>

Add bindings for Qualcomm MSM8909 Network-On-Chip interconnect devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
[Stephan: Drop separate mm-snoc that exists downstream since it's
 actually the same NoC as SNoC in hardware]
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

