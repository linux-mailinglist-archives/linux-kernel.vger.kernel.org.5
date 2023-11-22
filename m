Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6487F431C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjKVKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbjKVKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:04:19 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1507183
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso4182104a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647453; x=1701252253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1RITL8OxHsMLxeDHkjC7KO7ENhom6ryWU8RnZhuNzA=;
        b=eYA2p69VgujvgwhDYfsPWkFmcg8/Sq+VolkzIFqCDLxBp0auNCKTpo23Pi3MtLT6fS
         3A+XA/VRSetTCRs2UZLlE8vwGIpQSgLmiHstM6bZJBT0jzf3D5Y3AUOrZfdQWGfTckrb
         yVtSWjmACU0kYYkcY2myQqXFGZdOpUc/aFb4eUl1IbA/lAh3wq79sIjtYa5rcFnW0w/Q
         2jIgfhd9vc/9MR0e8RVurMi6bFyXgngEPjn9Y8johjYlfystBBUUq5GBD6DRySgoTXv2
         K3w3aQE656IGj1JfJonWRi3dgMjeKBAKpQr7IvC0gSsW++OWT30ysPjqPPUBH8JvKXQj
         J+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647453; x=1701252253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1RITL8OxHsMLxeDHkjC7KO7ENhom6ryWU8RnZhuNzA=;
        b=vDwNODCBkwx08WdxdABPnC596WKCujt69Lz00qWwCpPv9OhJ7r1LT38S7GE3Jtt85z
         0U8al6Ww4lc2FlrFZG44pZW2B+roapfPL1x2cZM0BWoULrEqoZi+QfyAIEhy9lOg0j/f
         13alFSXJsFXNegCCc0wBWwcKRbXQi+0QFcaFkpB97mSk7p3rcKzHAlecdk+9BTbSoipd
         1rZPsnJVHBCJWYhVXMUXV+jYxIryC/mlvmT+s/h0rZDl8/2U1HlgR0DOgEnuakGMvr/s
         xr9wNE9y0JvBEYx5lA5z6fgZFuHtb+I3bDrt5t5rl7jj2uM6wPPKTLgWHdf0AVX30vIc
         PdEg==
X-Gm-Message-State: AOJu0Yxt5vybUSycgacauhYzj2o+PQSmiTIC2NlD1BULtFhARsj44PAu
        RG974+Ywqnv5NS+BLjobMw1EeA==
X-Google-Smtp-Source: AGHT+IFg40vAD4gBPaLU21jOoVJQZlT6/h/8bJelp/ZTMRjvISy9S9dqXtTVKARnwEZDg+nt5Bhv2g==
X-Received: by 2002:a50:ef03:0:b0:533:9df5:ede with SMTP id m3-20020a50ef03000000b005339df50edemr1409247eds.14.1700647453483;
        Wed, 22 Nov 2023 02:04:13 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm6110456edi.28.2023.11.22.02.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:04:13 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 12:03:56 +0200
Subject: [PATCH 4/7] phy: qcom-qmp: pcs-usb: Add v7 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-4-d9340d362664@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=LT5rjK1uiRAEbfGyqfhSN1OpzVOqugP1A59DYdF7d9k=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXdISFRKy1XkwISL/zdm5baaZ9mvX8+WRzgPTS
 uglR4SQSE2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3SEgAKCRAbX0TJAJUV
 VtjYEACgyQcQAzYoXRTEQTC4k+Z+E8UvZ9oO6a7eZSV2cENJKik4H3VUg9NoF87HbZemKAsAwse
 HoCT4K69S1nBmev8DXaiqGgG+/bha6Cx0KoeR46sRDZa+IW9CK+3jBaKL3Fe12Xou+GCOLRs0R2
 WIuezzSwJMELkrzJ2U1BQeNVTBEhgx0dT3hWFlOYVVlQdbv5eFxThYA8eWS0p8/t+x8yXT1UuD1
 m2svfDs9zy6WC6T7u7WH+pHipyclh9rKUStm1SbjKFpMxUMHlxFe4Ur5uFwG7Vsash7O9604KmI
 hUG1Ls5f0pVsPuiyQJBEmrQvSzp5BsipoRkU3eGpnObEoStzD07lLsY+ptgfvUlFqkC1ad3iWOH
 VkEmEVWz/sr4i2fVoUVc7JM7aVP+gCRrNsf6DQeFoDRfuWuyZO121sVGd3p0CKTNlbm+GJx1ayl
 72/cI3NiIYyyqPL8CeMlt+7EYsWnbX9l6HjkniuplkDgQoYrkHKDueNNe+lBtIfuvrb9nevPLXO
 /bTCPjJxuGoH6KcRVuTbx4QR6jDVexjQ9hhmy6NOH3sFUDhTCQ3Q5t4/vZTv/Q5wBoQzgkzmj/+
 2z1RRjx5ZL0n4qjxVxUpsZTW4fT2k4NSoEcSN0X8HK2ItByavKHqN1olRPCOSlGwKHQssO9f8k5
 Iuoe+yI6Oq0BHcg==
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

The X1E80100 platform bumps the HW version of QMP phy to v7 for USB.
Add the new PCS USB specific offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
new file mode 100644
index 000000000000..dbb75964cef7
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V7_H_
+#define QCOM_PHY_QMP_PCS_USB_V7_H_
+
+/* Only for QMP V6 PHY - USB3 have different offsets than V5 */
+#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG1		0xc4
+#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG2		0xc8
+#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG3		0xcc
+#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG6		0xd8
+#define QPHY_USB_V7_PCS_REFGEN_REQ_CONFIG1		0xdc
+#define QPHY_USB_V7_PCS_USB3_POWER_STATE_CONFIG1	0x90
+#define QPHY_USB_V7_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_USB_V7_PCS_RCVR_DTCT_DLY_P1U2_L		0x190
+#define QPHY_USB_V7_PCS_RCVR_DTCT_DLY_P1U2_H		0x194
+#define QPHY_USB_V7_PCS_CDR_RESET_TIME			0x1b0
+#define QPHY_USB_V7_PCS_ALIGN_DETECT_CONFIG1		0x1c0
+#define QPHY_USB_V7_PCS_ALIGN_DETECT_CONFIG2		0x1c4
+#define QPHY_USB_V7_PCS_PCS_TX_RX_CONFIG		0x1d0
+#define QPHY_USB_V7_PCS_EQ_CONFIG1			0x1dc
+#define QPHY_USB_V7_PCS_EQ_CONFIG5			0x1ec
+
+#define QPHY_USB_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
+#define QPHY_USB_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_USB_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_USB_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
+
+#endif

-- 
2.34.1

