Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C238380878C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379280AbjLGMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379238AbjLGMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:19:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AA84
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:19:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so652593a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951582; x=1702556382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8/wN9bVDO/fT20ixO2JSLBwr82UnvTKWcapBaXM3F4=;
        b=PL1ZtwNTzc2+wi+bibQoXq2hergR+BWvfeLcN+VmgGCLfaRc7MXu9og+ULxaUdHfdv
         K1nRQAS6D0FhZVVxulKj1LseX7+EifPuT63HfTIlgGfzhUy5GQGhagFnU7q2Sy3pqRMc
         ddznF53gZisoVSX6RnIx/SotgIb1zDcmTDN1RTRSh47ZweJxGAbWAL+qcLymLB127HI8
         QSvLJojOJxXuV0inRCwCT6Di9xLRtv9tZRw7fFps3+9XGHREz1Hvv2uqbnp7RGB8yMSD
         1HJ1dVdR/YR5INboeNVfXVa0+wFKN6Yr3RPSgEqr1z2SMymzXmaXV8znir7vETZ6UoX5
         Vz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951582; x=1702556382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8/wN9bVDO/fT20ixO2JSLBwr82UnvTKWcapBaXM3F4=;
        b=TDu+tBKle7XbrXmD8IMpG4wq1auCUhSKQ1xaagAAFqII+kwDE0u3haoQARBaFsHWdh
         MaZt40GF0YD36v4m66tsGCwKknrWiZTYf5/f9srA8r/O1pCeVlFpwB4hAbYw8e/yFcAu
         F5RbUj/n4KgHbEuTDazZO1dcqbVhn+NF2G09yBtHAYdVzZlGwmIZt7Vv13fGDLBGW1ft
         klq0pV+7WrkoIOMGXtCkcxVburjTrfoH1MkVSBV4fq9S9SV2KjVTPSPzB6AXQzhd5ako
         F/p0kHj0BKrGB81G8ve5MKZ9Y10tRYKfqn0BKfm+Sa6DIiuZBZfK+LqX9Bti1drTHh8s
         3T7A==
X-Gm-Message-State: AOJu0YyQfGzIm9FzeCcJPYOp1OuF8Wx90K6Zeh/F1pZDPGPVByvdABVk
        N5Uo5DqoatTj5J6YeRBGIjU2Ug==
X-Google-Smtp-Source: AGHT+IFM4jfhmjYf4Mr1kYFBvBAD+grQ/qtplvT+cAK0RXakzXW3dxwq4ULR/FPsbKFcz8j/n20www==
X-Received: by 2002:a17:906:73d2:b0:9d3:f436:61e5 with SMTP id n18-20020a17090673d200b009d3f43661e5mr1841709ejl.29.1701951581963;
        Thu, 07 Dec 2023 04:19:41 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm761394ejz.62.2023.12.07.04.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:19:41 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 07 Dec 2023 14:19:15 +0200
Subject: [PATCH v3 6/7] phy: qcom-qmp: qserdes-txrx: Add V6 N4 register
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-6-dfd1c375ef61@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=mP9L6SpjvbccTHuSpfnLLqvU2TjJIjDbq/c6nbRWGbY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcbhT6HtWXSLcyCrc1rPAIG5k0A7Aqpz1UiuVn
 stZx52K9lOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXG4UwAKCRAbX0TJAJUV
 VkWaD/4oTYB78IX2ull9QOh/gUlChoWzOkm8FSM57hA++T1WkbykJlyP64dzTB5vtnOAnTQrLCs
 MNGmGZZ1FkO43Gk1RtkDdltfOGFQrnF58TAeHmATijghVFssRU7HoQOlkoUQ+fIuUzKfqnLzkgx
 ewiSR1jG0cAZMjUFEpektIvdYHlFWXytRzB8b9LzWghly5XvCr42Z6SZTLt8owDt/VNFy6f15S0
 MfbzzFVbAMPtBeaJEhunGE65GEjyrFagCizYt+upuHJFtfx5x1Fi9aj0KiGA9fsrkYpbaWWik7T
 veDOjOIGGNytCwrPe9gVf9tZBDMbckRswl3LLlxoAt6yeoQi+9pD9OCjZjEcBfU2Kbqg8LWD7A0
 k1PHtoNGehmnTP3/mZn1i7Ihx3FC+/3A+PRvPer75wcOvKoORLa6EKKMaTiOQCxW90wJAzu03KC
 eli3jlZoU1DPCjwPQ9I43oWGcr7+0iYOiqnXK1sETyIeH7cOBBuluyK/Ie4jUOSLn9TKun3ZWPM
 npobcNTMEmtLoLNWPMi5SvHg29Sxj5dtoSTBrS/JYiZ3OwBiP63rOxf306v/q5+ppXo0eU+M0aS
 7XREsSEcWghj4klSEbmgUVYFJPIfkYdxND+1btWuNJL0ugXUJ+64kLq7FJn0OciP+q7saf2ojUY
 q6xG6fA/HGXFjRA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a variant of V6 offsets that are different, the QMP PHY N4,
and it is found on the X1E80100 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h | 51 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  1 +
 2 files changed, 52 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h
new file mode 100644
index 000000000000..a814ad11af07
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V6_N4_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V6_N4_H_
+
+#define QSERDES_V6_N4_TX_RES_CODE_LANE_OFFSET_TX	0x30
+#define QSERDES_V6_N4_TX_RES_CODE_LANE_OFFSET_RX	0x34
+#define QSERDES_V6_N4_TX_LANE_MODE_1			0x78
+#define QSERDES_V6_N4_TX_LANE_MODE_2			0x7c
+#define QSERDES_V6_N4_TX_LANE_MODE_3			0x80
+
+#define QSERDES_V6_N4_RX_UCDR_FO_GAIN_RATE2		0x8
+#define QSERDES_V6_N4_RX_UCDR_SO_GAIN_RATE2		0x18
+#define QSERDES_V6_N4_RX_UCDR_PI_CONTROLS		0x20
+#define QSERDES_V6_N4_RX_IVCM_CAL_CODE_OVERRIDE		0x94
+#define QSERDES_V6_N4_RX_RX_IVCM_CAL_CTRL2		0x9c
+#define QSERDES_V6_N4_RX_RX_IVCM_POSTCAL_OFFSET		0xa0
+#define QSERDES_V6_N4_RX_DFE_3				0xb4
+#define QSERDES_V6_N4_RX_VGA_CAL_CNTRL1			0xe0
+#define QSERDES_V6_N4_RX_VGA_CAL_MAN_VAL		0xe8
+#define QSERDES_V6_N4_RX_GM_CAL				0x10c
+#define QSERDES_V6_N4_RX_SIGDET_ENABLES			0x148
+#define QSERDES_V6_N4_RX_SIGDET_CNTRL			0x14c
+#define QSERDES_V6_N4_RX_SIGDET_DEGLITCH_CNTRL		0x154
+#define QSERDES_V6_N4_RX_DFE_CTLE_POST_CAL_OFFSET	0x194
+#define QSERDES_V6_N4_RX_Q_PI_INTRINSIC_BIAS_RATE32	0x1dc
+#define QSERDES_V6_N4_RX_UCDR_PI_CTRL1			0x23c
+#define QSERDES_V6_N4_RX_UCDR_PI_CTRL2			0x240
+#define QSERDES_V6_N4_RX_UCDR_SB2_GAIN2_RATE2		0x27c
+#define QSERDES_V6_N4_RX_DFE_DAC_ENABLE1		0x298
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B0		0x2b8
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B1		0x2bc
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B2		0x2c0
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B3		0x2c4
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B4		0x2c8
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B5		0x2cc
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B6		0x2d0
+#define QSERDES_V6_N4_RX_MODE_RATE2_B0			0x2d4
+#define QSERDES_V6_N4_RX_MODE_RATE2_B1			0x2d8
+#define QSERDES_V6_N4_RX_MODE_RATE2_B2			0x2dc
+#define QSERDES_V6_N4_RX_MODE_RATE2_B3			0x2e0
+#define QSERDES_V6_N4_RX_MODE_RATE2_B4			0x2e4
+#define QSERDES_V6_N4_RX_MODE_RATE2_B5			0x2e8
+#define QSERDES_V6_N4_RX_MODE_RATE2_B6			0x2ec
+#define QSERDES_V6_N4_RX_RX_SUMMER_CAL_SPD_MODE		0x30c
+#define QSERDES_V6_N4_RX_RX_BKUP_CTRL1			0x310
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 3a0512c3e07a..63b3cbfcb50f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -24,6 +24,7 @@
 #include "phy-qcom-qmp-qserdes-com-v6.h"
 #include "phy-qcom-qmp-qserdes-txrx-v6.h"
 #include "phy-qcom-qmp-qserdes-txrx-v6_20.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6_n4.h"
 #include "phy-qcom-qmp-qserdes-ln-shrd-v6.h"
 
 #include "phy-qcom-qmp-qserdes-com-v7.h"

-- 
2.34.1

