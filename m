Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E27F4317
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbjKVKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjKVKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:04:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CE198
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548f35e6a4bso2857121a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647450; x=1701252250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37pl4HMRaLDQ9/dj8EKKJfS1KLcArLtO6z5a7AglAAw=;
        b=iZjH4zgdC5hBooeWE1g5C0EJP35DWq8nK9MKCMBuLO5qFtW2aT3SLDfrwkOQ1mETje
         ho4yOMoatAQfMVO7bqhX5W4gJJbW0fphhjym6r5E49YXsChQaunwa+S9j+9IEJ3bA5A8
         i4Xciz7szC4tRN4Z0bcwPsEIFG7BT7N4x19s2NQE3geuRmAnnk8ek5Kb8RKgVb61knTw
         51DWmT5izj7nOUU/kl1XQI7F76gqAfr3D39Es82QQkS44XML/t+neOcJOSHc5ZU7xArW
         209T3Q4pn4AiE8VsE5iuBoD8dX6pCSd0rz4IsEJr6ttakCrAiIiMHdU+LKXm7F5K5V7o
         o98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647450; x=1701252250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37pl4HMRaLDQ9/dj8EKKJfS1KLcArLtO6z5a7AglAAw=;
        b=ES2DvPViyOdl4ScM1PGnUmFZU7nidD0U/d+bHoJXNNy9E5DlU3gJ1IwAgQYRNLOEHd
         A/7efYWdLGqdt9meu6QOcGZvnJqgzFlTRQiXRwwQmBXVWCtW+R6SLQJrxuvjEKsbMEi9
         eCLhJwmRfPn0KbI9npeBNPM9LD0xbWpAvY/OGJ9l/dUGZRRI9yDlckyib7N4/3oumXsX
         3YyqZBlEx/6bAqOKHPy47GdsivlbFS5cGo9aoH8WM9ErtUiWMTVS6kxbsgaylkScj+wK
         USZSeltBI70lt1ACLlAcmkCxjZUSkKHrwFRT6m5i3WSLqmo6LatnHPnohvczdUTZ1vFI
         0HrQ==
X-Gm-Message-State: AOJu0YyaXKLH2BOurj6NYfwJicghwvgeeJ75uQFKHdNcg4Iop+dsxQt9
        BjMiYSB/4WYp1LjtE3LlC7K4+Q==
X-Google-Smtp-Source: AGHT+IFWU0iEv8BqhoV9DV+1eqEuqLkQxxovBx4eY0rIvhqZbZqTHH27JWzfm+iKIpLrGqEimllvtw==
X-Received: by 2002:aa7:d8c2:0:b0:543:566f:2e89 with SMTP id k2-20020aa7d8c2000000b00543566f2e89mr1545070eds.37.1700647449802;
        Wed, 22 Nov 2023 02:04:09 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm6110456edi.28.2023.11.22.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:04:09 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 12:03:53 +0200
Subject: [PATCH 1/7] phy: qcom-qmp: qserdes-com: Add some more v6 register
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-1-d9340d362664@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=wuMKuc8sVyzIHG6Zfhec3C34NmF6yKe0sA4KnFTG0yQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXdIOpu4pjNY+PIV9zXxRsqB/b+GHqkbuLaTx5
 TFsZbeY9TSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3SDgAKCRAbX0TJAJUV
 VrZXD/9+eXGz1JvGFxI8N3bHnDjKGj/dkgLOOFlJrq4RVUMw7ZXu4wZoeea9CTDpWjmf9pR0DE/
 d22IEP5rv2kl2KN2SVuTBnVrFtOZlQAurk+NeUcgWSnhmb3aZ9UrediFpviRC7MBz0ESMDFb4rx
 1GJnQA16R/ZmZmD6fG4WzE3GBJnp+3sbd0t5hgdWYfcFxnqxyPFi3xcyOQXMGHiAziNSBJdtNmw
 pNRz7hogIIw30pLlEYCb+9U0oQVChgkJ4gX/sy1zdfZ9/pwiZh0JpjpUdiKeZxXbd+Hf4tbsTSe
 U62/3zFbRy9za7B7OXqh0rDczc+E9LMo1jB8V/JO6Gz9PyyVRg2QjrH5Nvcn7FGC4v4reevqI5H
 tNNc5oCxuppVcfx3PjA68LfFU9YjnGlVRu6TSA//QkByqAAi000iFwdHgL2eyAa/h64qNqKFVnA
 q7cayY0zJMnTFyFzkGiXqsjgpQY25XrmuNPxo6hvglBf2swe5NGJz2X3ZAO9T6V+N2C2zxJ00ig
 z0ZSlo9Ncb3bdPxzgcsO/SyGKz6b/FHi/L8VPoj53uLkDQn3h38gRCDF5tg5gHB4LITNATQjYl6
 +WH6IFTsdkeoTgXmSbX51d9oPWy27ShMHwMaEXxpESUV2Q1sPw704KwI7NEXcp30c5LzB/T2aNP
 Qm6esAaYkkzZxtw==
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

