Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA828033E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjLDNIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjLDNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:54 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6794BB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:07:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c039e9719so22933685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695275; x=1702300075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsQY5wdtf2BXxOhs26sA3XI/MGPOIVweT0ZY3rFx6EE=;
        b=EldaDQFaDRQlEIuVGXgyHXAPX/4DvDyFHNNtHmfuJEPTW9BVgjdBmIiG+HqMOZYfsn
         QolV4eKMlJo82i1V/QbG0l7eWE8fb5KibUZTj0Q6iAeDGzsiC0pQ4bTa0Eir5p/9kO2y
         l3PGIcf1W3cYLqHbSg12ktnH0W6mlC687QTr9qFlindX57A4QCBEax69cdhVGF5Ex7zS
         Z6ELDYc2Ol/YKhnJ/N7mNSeXmqAZ3vMw9aTp8ZhpBWgGwE3rVv4SlW0s7DY5UkW+wnAv
         cJRIwHe3i1ABu7MuByRBuExLb+9JuJ5NEfVlfz0yP517CKDvQ7I/OKVLVBD8ca+2tnUo
         uoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695275; x=1702300075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsQY5wdtf2BXxOhs26sA3XI/MGPOIVweT0ZY3rFx6EE=;
        b=mC+Gu1bGHGbU+L0ASwluTcMdbATLo1D/9al0mRqtRbHgP3DA54qo6yGeX0fq+Zv9l9
         TsQBFcJIIMlAkpS/j6Br/VV9qwFAPn/5wgxmTwcUvcZbG8E5HdAEHcsicPS5f7SwxRIV
         2bv5BU7Lmo7PRdIc3YgkfNBvzm7hBGEDsVtMm9goS4sylDSuSwNN40CP0YK2iwgs0sdq
         oXoHl507AHnHrAQ0P6aL55yUfLw+kNW2yZBRAdtC+M4fpAJi4lDAPcTweb14sG0daFbE
         uu00GNOQgicxSP8zBxNaebqZtqwTypOVPyXnPlKSwbK4hvGHM4ZCLRmts2Qb8euJVNZe
         uDag==
X-Gm-Message-State: AOJu0Yy4fP+iwbR+1NO7zKYBI0WqQPZORhN/4i3yzisw6yNfw34Uuph1
        6c7mmYaTi7HzVLvSbxeU8VoBEA==
X-Google-Smtp-Source: AGHT+IE5PF2K2I01b86bWxz5dAGsWqtl6UUACFW1WGvkmBa+gXUxXtHlDeiNNr6m3FbwH7gatMkkBA==
X-Received: by 2002:a05:600c:a01:b0:40b:5e21:ec47 with SMTP id z1-20020a05600c0a0100b0040b5e21ec47mr2400526wmp.121.1701695275025;
        Mon, 04 Dec 2023 05:07:55 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:07:54 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:35 +0200
Subject: [PATCH v2 1/7] phy: qcom-qmp: qserdes-com: Add some more v6
 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-1-21956ae0c5c3@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-0-21956ae0c5c3@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-0-21956ae0c5c3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=tCAG5xQlxlUAJwFjT/XmANZmT3YOrqILBnsoD1MYGiU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8gk0Yri/6zMgTbOZMbz8A66t/pjZD42HvAw
 kGedsaDxzaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PIAAKCRAbX0TJAJUV
 VlovD/9I7vtpFHu4EM/qgykbiRo8NVmgcgclYF+NF20GTl4UJjJUv0ZiI0RNhLMqXmlFr6+U095
 nk6/qvTzzZFC3Zisc/9VoUIoqcfh5j61UKPo5b/9U0lKBrVjXrzNrl6QP1P/L37t/DZVjDaNzJp
 HxNE9l4WU1QRaAc4oQSygffrUwUOKOBMzknx8LGq3ANxDTqqcG4uzNtc3WFgQHViiObJiD3b7d8
 6hK8hmUhWWgfy5NtMnxoBAP2ZoSkF6DVwwzHTNw1RtSqFawAGndGcZ+z3fjDQmHCO/jLQ8am9YA
 1gzDXp54Et41IGpAevGGM6ouvzPxQF3qECH09DHEzajaH/7IZSWG9bI0ecoG9prCFHLB0ejVWMf
 zCRYLBHg9SCh0NL56wfRd7r0uaRV4c8gZRn2nrqRdrnrR5nO4IaJngxT5ozVNKf3+ULXUSvv5eh
 yAG7ne8e32TDA6PrwOhBvoJNUPWrvZQ0iYj+D4dt/OpxiTnqf/a4u4YVFOblkwfDCqhUiOVctD4
 jxGoNi1Sm86svnRxYzVqIgOZXccztS9aSbR91+hI5/1lGv/jTrvxfP34rEm7U7+STMU5TXOqlFQ
 7r7ibedP7rrPzuTdAP3BZaklblSgDUGitoLIqGPUoe2Zy1uJZXPEXxWUuh1Bxs60qXPnNzSYTMd
 AxHqHRRaMq79LMw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some missing V6 registers offsets that are needed by the new
Snapdragon X Elite (X1E80100) platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h  | 5 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
index f420f8faf16a..ec7291424dd1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
@@ -22,6 +22,8 @@
 #define QSERDES_V6_COM_DIV_FRAC_START2_MODE1			0x34
 #define QSERDES_V6_COM_DIV_FRAC_START3_MODE1			0x38
 #define QSERDES_V6_COM_HSCLK_SEL_1				0x3c
+#define QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE1			0x40
+#define QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE1			0x44
 #define QSERDES_V6_COM_VCO_TUNE1_MODE1				0x48
 #define QSERDES_V6_COM_VCO_TUNE2_MODE1				0x4c
 #define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
@@ -48,6 +50,7 @@
 #define QSERDES_V6_COM_VCO_TUNE2_MODE0				0xac
 #define QSERDES_V6_COM_BG_TIMER					0xbc
 #define QSERDES_V6_COM_SSC_EN_CENTER				0xc0
+#define QSERDES_V6_COM_SSC_ADJ_PER1				0xc4
 #define QSERDES_V6_COM_SSC_PER1					0xcc
 #define QSERDES_V6_COM_SSC_PER2					0xd0
 #define QSERDES_V6_COM_PLL_POST_DIV_MUX				0xd8
@@ -56,6 +59,7 @@
 #define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
 #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
 #define QSERDES_V6_COM_PLL_IVCO					0xf4
+#define QSERDES_V6_COM_PLL_IVCO_MODE1				0xf8
 #define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
 #define QSERDES_V6_COM_RESETSM_CNTRL				0x118
 #define QSERDES_V6_COM_LOCK_CMP_EN				0x120
@@ -63,6 +67,7 @@
 #define QSERDES_V6_COM_VCO_TUNE_CTRL				0x13c
 #define QSERDES_V6_COM_VCO_TUNE_MAP				0x140
 #define QSERDES_V6_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V6_COM_VCO_TUNE_MAXVAL2				0x158
 #define QSERDES_V6_COM_CLK_SELECT				0x164
 #define QSERDES_V6_COM_CORE_CLK_EN				0x170
 #define QSERDES_V6_COM_CMN_CONFIG_1				0x174
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
index 8883e1de730e..23ffcfae9efa 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
@@ -23,6 +23,7 @@
 #define QSERDES_V6_TX_PARRATE_REC_DETECT_IDLE_EN		0x60
 #define QSERDES_V6_TX_BIST_PATTERN7				0x7c
 #define QSERDES_V6_TX_LANE_MODE_1				0x84
+#define QSERDES_V6_TX_LANE_MODE_2				0x88
 #define QSERDES_V6_TX_LANE_MODE_3				0x8c
 #define QSERDES_V6_TX_LANE_MODE_4				0x90
 #define QSERDES_V6_TX_LANE_MODE_5				0x94

-- 
2.34.1

