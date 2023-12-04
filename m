Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBD8033EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjLDNIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjLDNH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C7196
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:08:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso4623405e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695280; x=1702300080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUks0VPbd9cYN7vszIiBuJ+mQVO4/oWNE01Kkc+iAPE=;
        b=YyhRklG/zHjIAoYyiIoq+useOhy/J6SIE0U9gMoYk3inYkmLYqyF0htPEDrnz01FZ5
         YeBHjDed25348xQjJhU6G5kzGmXbdO/ql43QzH8AaQ/qNQo7ExT3eRvEpx75UEAgzUP4
         Fg7u5TBtb+60m/QWrr9BovJqlcC5WZBdMrVJfmrxJNFphvYxWoGt0tMptZrTJtyOQ7GN
         yHXTbmTNrkglrrhGRUaWpiEq/ym/avJzyk7RQZjbFHX58aDjYRz718TJ0jhT4S0I+ahV
         BIrgvwlYauLbqvkUJ9KtnWTpyCC3Z2FR2hg+3xKFYTt0mvv6YJepPnmYoz9IRBNg7Tk+
         XRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695280; x=1702300080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUks0VPbd9cYN7vszIiBuJ+mQVO4/oWNE01Kkc+iAPE=;
        b=OZxS3TkwS5ZS1l40ivqQMbtoaQOmBRfSBXFBXtxxhYvlLLNJdBNsEsXBBkoqlAx8E4
         2t/7NZmDzTXBAVYgvYIKsKciZFiUT0Ia/1uphGJomjDO9mjXuCOu01WEpjcaS6pev5dP
         nbS/fWuxcsl1zsps66EQGGgj1pvWaqdgz2ZqyKLKksgV1Im14khU9+tyQOQengaOen0b
         8ZuysPUc3wOSaSVH1tVQtozKASuG/zSF+0E2eHsfOX2AT+51MZ25AjpLUAhpaV6dvuF+
         qqq55jwMs7292Drae7CkloHGf1n/XDOVGi/di39FvJJLoZc19HGY32ZGz6GBrZf+O4eq
         HskQ==
X-Gm-Message-State: AOJu0Yx0a5vSpiFTGA9c0M5189BDqaDHmv0Pf4CTaL2VCcz4uGeBN4W/
        /3Lxiep+ESh4ox0nFQJeGHgbJg==
X-Google-Smtp-Source: AGHT+IFM0QwwCk8522Vl3t4aRbxd9Q+q4yyucz746KxdgT4MpgGYyFNAZFhvVp/Nwh8zfZev+tmAwA==
X-Received: by 2002:a7b:c857:0:b0:40b:5e59:ccad with SMTP id c23-20020a7bc857000000b0040b5e59ccadmr423442wml.142.1701695279957;
        Mon, 04 Dec 2023 05:07:59 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:07:59 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:39 +0200
Subject: [PATCH v2 5/7] phy: qcom-qmp: qserdes-com: Add v7 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-5-21956ae0c5c3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5077; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4NLR4VFQwo4+fX7UwBPIiMq13lp/lzmGWpiGVxHOxcA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8l1+QvRIvoYU4BHdmt5lsW9MqdkS82wkNOD
 I/RF6dwMoOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PJQAKCRAbX0TJAJUV
 VvE8D/4kT2ifTcIAdfsBcf+LM4L0G7TndZkVJox9hn3jld3QtHxxah4jSkGFk1Q0E1Qw+Wn7tPG
 olswtGk47KAQFpB64L/0mnsSg6ORQwBEP9tvnvQ+suuieuEsDdR1rtHsP/iultNPMgpurjYeicF
 ByMhP48WgJWI0gxnha9weMMs8bdNfaTvlZpwWG/Oo6klSE0PjjSkUcJZ2vfpkU3laX/apLxJIYi
 dn5V6M8eweTEKy7tdc+dgJO+3LXLOq5YTxp62DCZmd3CCVAqMdLoCjkm1M6+H2DARbgpK8KivTG
 ZZN/wwSJChMx/+VnYCj/ijR2UqrtRCXOxcJ7aU/Chst54tIrbKnhL2oXZjYLadsKgst3M7jXrB4
 zpr7MNuFqr7bASZRsnTUybt2vDDrJCvCcX2TDKXWYpd0H/X4jSJzitNEdEHdf8T5LzEh2pj1hUG
 XoSOIg8Xti7l4ImK/n/Sx+YIp+8HGggOcQuiUFeGoWIixqOhAYB1dHssiIrVdGAHqACgJlq85AA
 8FKHt6irlVilmm9NG+XYsrbuOO0Jem3Qc54ZcF6nHl3oJI+NRrDa/Pzx6wJPWl9wZaWYNlwkunW
 KVT8bw6g+p7corClfaSg89oZHQu65qJHZ/tC3baIg3IiUxOaTmxVGznoDJbISe74SHxpyOefUeX
 UTNHCkAhTWyTDmw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1E80100 platform bumps the HW version of QMP phy to v7 for USB
and PCIE g3x2. Add the new qserdes com offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h | 86 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 +
 2 files changed, 88 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h
new file mode 100644
index 000000000000..9fe7326e4190
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V7_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V7_H_
+
+/* Only for QMP V7 PHY - QSERDES COM registers */
+
+#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1			0x00
+#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1			0x04
+#define QSERDES_V7_COM_CP_CTRL_MODE1				0x10
+#define QSERDES_V7_COM_PLL_RCTRL_MODE1				0x14
+#define QSERDES_V7_COM_PLL_CCTRL_MODE1				0x18
+#define QSERDES_V7_COM_CORECLK_DIV_MODE1			0x1c
+#define QSERDES_V7_COM_LOCK_CMP1_MODE1				0x20
+#define QSERDES_V7_COM_LOCK_CMP2_MODE1				0x24
+#define QSERDES_V7_COM_DEC_START_MODE1				0x28
+#define QSERDES_V7_COM_DEC_START_MSB_MODE1			0x2c
+#define QSERDES_V7_COM_DIV_FRAC_START1_MODE1			0x30
+#define QSERDES_V7_COM_DIV_FRAC_START2_MODE1			0x34
+#define QSERDES_V7_COM_DIV_FRAC_START3_MODE1			0x38
+#define QSERDES_V7_COM_HSCLK_SEL_1				0x3c
+#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE1			0x40
+#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE1			0x44
+#define QSERDES_V7_COM_VCO_TUNE1_MODE1				0x48
+#define QSERDES_V7_COM_VCO_TUNE2_MODE1				0x4c
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x54
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x58
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x5c
+#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0			0x60
+#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0			0x64
+#define QSERDES_V7_COM_CP_CTRL_MODE0				0x70
+#define QSERDES_V7_COM_PLL_RCTRL_MODE0				0x74
+#define QSERDES_V7_COM_PLL_CCTRL_MODE0				0x78
+#define QSERDES_V7_COM_PLL_CORE_CLK_DIV_MODE0			0x7c
+#define QSERDES_V7_COM_LOCK_CMP1_MODE0				0x80
+#define QSERDES_V7_COM_LOCK_CMP2_MODE0				0x84
+#define QSERDES_V7_COM_DEC_START_MODE0				0x88
+#define QSERDES_V7_COM_DEC_START_MSB_MODE0			0x8c
+#define QSERDES_V7_COM_DIV_FRAC_START1_MODE0			0x90
+#define QSERDES_V7_COM_DIV_FRAC_START2_MODE0			0x94
+#define QSERDES_V7_COM_DIV_FRAC_START3_MODE0			0x98
+#define QSERDES_V7_COM_HSCLK_HS_SWITCH_SEL_1			0x9c
+#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE0			0xa0
+#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE0			0xa4
+#define QSERDES_V7_COM_VCO_TUNE1_MODE0				0xa8
+#define QSERDES_V7_COM_VCO_TUNE2_MODE0				0xac
+#define QSERDES_V7_COM_BG_TIMER					0xbc
+#define QSERDES_V7_COM_SSC_EN_CENTER				0xc0
+#define QSERDES_V7_COM_SSC_PER1					0xcc
+#define QSERDES_V7_COM_SSC_PER2					0xd0
+#define QSERDES_V7_COM_PLL_POST_DIV_MUX				0xd8
+#define QSERDES_V7_COM_PLL_BIAS_EN_CLK_BUFLR_EN			0xdc
+#define QSERDES_V7_COM_CLK_ENABLE1				0xe0
+#define QSERDES_V7_COM_SYS_CLK_CTRL				0xe4
+#define QSERDES_V7_COM_SYSCLK_BUF_ENABLE			0xe8
+#define QSERDES_V7_COM_PLL_IVCO					0xf4
+#define QSERDES_V7_COM_PLL_IVCO_MODE1				0xf8
+#define QSERDES_V7_COM_SYSCLK_EN_SEL				0x110
+#define QSERDES_V7_COM_RESETSM_CNTRL				0x118
+#define QSERDES_V7_COM_LOCK_CMP_EN				0x120
+#define QSERDES_V7_COM_LOCK_CMP_CFG				0x124
+#define QSERDES_V7_COM_VCO_TUNE_CTRL				0x13c
+#define QSERDES_V7_COM_VCO_TUNE_MAP				0x140
+#define QSERDES_V7_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V7_COM_VCO_TUNE_MAXVAL2				0x158
+#define QSERDES_V7_COM_CLK_SELECT				0x164
+#define QSERDES_V7_COM_CORE_CLK_EN				0x170
+#define QSERDES_V7_COM_CMN_CONFIG_1				0x174
+#define QSERDES_V7_COM_SVS_MODE_CLK_SEL				0x17c
+#define QSERDES_V7_COM_CMN_MISC_1				0x184
+#define QSERDES_V7_COM_CMN_MODE					0x188
+#define QSERDES_V7_COM_PLL_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1			0x1a4
+#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2			0x1a8
+#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3			0x1ac
+#define QSERDES_V7_COM_ADDITIONAL_MISC				0x1b4
+#define QSERDES_V7_COM_ADDITIONAL_MISC_2			0x1b8
+#define QSERDES_V7_COM_ADDITIONAL_MISC_3			0x1bc
+#define QSERDES_V7_COM_CMN_STATUS				0x1d0
+#define QSERDES_V7_COM_C_READY_STATUS				0x1f8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 21f6a56e7ae3..3a0512c3e07a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -26,6 +26,8 @@
 #include "phy-qcom-qmp-qserdes-txrx-v6_20.h"
 #include "phy-qcom-qmp-qserdes-ln-shrd-v6.h"
 
+#include "phy-qcom-qmp-qserdes-com-v7.h"
+
 #include "phy-qcom-qmp-qserdes-pll.h"
 
 #include "phy-qcom-qmp-pcs-v2.h"

-- 
2.34.1

