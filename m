Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676C88033EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjLDNIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjLDNH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2468106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:08:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so44073005e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695281; x=1702300081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8/wN9bVDO/fT20ixO2JSLBwr82UnvTKWcapBaXM3F4=;
        b=DbAKtXVWf43mlPXkXv0/KIyWFqnVBLJyJbtOB2d2JQ10o/bQt0S1eHnJ8OgUHL7Q+a
         BJHifupkmQZeh9JoCUe0N1W0ESb5JyVcdD3Ke+2EjfYL29Br+ZlGZhD1/u1XlzCFa3fl
         SPo6w9mDkN6noHK3dHVcOILhLv4VqabipItPBo4EfpysZPYPEfS32gaIdepB5OIRZ9UE
         dqNjOgTHcA7KoPO/6w7W8GutzM5v3y+XXIcC+ysVy6ysx/x1ru3qYw8sIYqm73dqWwah
         lQU0NRikw9XX4mNIIOzs3J8cbKIrw8dec8ZOQKjpjyptow6x0GeB9+4aRM6eJ9Ed6EgG
         Bq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695281; x=1702300081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8/wN9bVDO/fT20ixO2JSLBwr82UnvTKWcapBaXM3F4=;
        b=kCLbiWP+lxB73WN6wmYo37wuV0FPTUhAzHA6dUdVDozYkD+jRQTcCYh8vqv2VJ84pu
         Fqg9KCGUyDiRn0ZkPxUl8qKhS3KcDk+lcW4K0zW1/xrO/n5iR3bL8+I3vR/PAQ34IA9D
         flvQhCST4ittPWd3sKwZaU/To7OqnDn8frlilReeq0SU9apImuPH9F5HglygvZTnpKYz
         fyx57SfurN2nSfnUJO6iu552g3Dtg1nVrBPfiFd/+TGZHiF2mqjtWPPsQd0Ra4V2/di7
         LNxoyPncIJuqEXcVVQoO2gPrgxRTlIifKQZdyMsx2vVR1dFWcNoYJtpJV0Rg1JnS38q6
         6/VA==
X-Gm-Message-State: AOJu0YzgbW8/QUVJfuJ+5l7SaMHnMu+QwIrre+xTiUymJ/hjDQjok2YI
        8ftyvbRQstxabWWZb0KdjLfWYg==
X-Google-Smtp-Source: AGHT+IGMHdhbuGPecflZBTUfmHubu9TYXaV9juwkLdp562K9OLSvK7kIuiTPaL0q9Tvs7zvDkHPeug==
X-Received: by 2002:a05:600c:1c0f:b0:40b:2b3d:9f45 with SMTP id j15-20020a05600c1c0f00b0040b2b3d9f45mr2992488wms.14.1701695281231;
        Mon, 04 Dec 2023 05:08:01 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:08:00 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:40 +0200
Subject: [PATCH v2 6/7] phy: qcom-qmp: qserdes-txrx: Add V6 N4 register
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-6-21956ae0c5c3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=mP9L6SpjvbccTHuSpfnLLqvU2TjJIjDbq/c6nbRWGbY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8mxqFzFRVpj609aNo824m4dO2D7XDmVu0TQ
 oE3S7/PiQKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PJgAKCRAbX0TJAJUV
 VnSvEACZJJyxW+F8fnfg/mEQ7/u1gyGZdebSgUfKaO+y8k1oZU61qguHffG8zKbvKmx4+CeylZX
 a9sZImVFvS0nCm0WhqSQ1SGe671FKhDNX3JPSaoXtP4mKRG/dkoy+fC2bf0GLm60JqF3SxtGt8S
 SPKiKI65pILqAEAiUC29EP6sr/asvcdQkkgHVyVNT2BtsyeRLudKrmE8LmfF5YPCB0qqbK9GTr7
 AatXhi4CYTrhOxPWS2c34Khu/MBnU4rdRFerR5jY9zrPJqS0ArE+6qctDxPiZ4ABIVAehErr+Rl
 CX7k5T+X+11hChFYyCLnM9TjenvGS+k/TMp5nTgb6rw0rP/Zqss4O5OOQ+0Fzu0EagaJT+OAMrq
 I30ALYdWyY/OSEk2f0U0DuZFBqADcbfFFyi2W3gcFFrB0dxTyx5cFPtM+I8CYxJYcZtg/TTd+R6
 8jWUFvROeoVbVW49djUPXDytB+yiNVTuml3fyQVTP6a3r6Os3oglhGa8kXIrE6/qxYXkCKCnFCr
 DvDj1Sdk/Dalmmix2GbEZlZoV5WPUeqL99koaIZpRdHSpNPL7WZ7Gl3GRDqXIVmNsApYkwHXTR2
 QZZm5B9j0855kb6J/ec1I7wT1gdHiFuGA49/IKFksw6arllGZULhmTI64dzxy/n50+YDIswkk/D
 H+gDO6W/DXuqzuQ==
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

