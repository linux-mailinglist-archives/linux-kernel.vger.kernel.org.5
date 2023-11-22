Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6167F431F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbjKVKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343796AbjKVKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:04:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0BA1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso9194748a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647456; x=1701252256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQR+FwOhW+4znWOcODnwJLSOHCpztagEF4Jo6brt37c=;
        b=DYXOn4ns85VSAcHK64gG0d/mec4IvRmwo2x2qZWSq0dv/qVZBZ+Jv1FBINiIG4gT/A
         MNeW+QztMYIXQf45gL4bY+epNORAXsauDNNA33ybibgt1It2jN5G48UpZa5WISRYWymi
         rgx5fhxy0Pns/BC/cqpF1jGX6SjnvNYr/Q/yKTeA0+58AWJoQv0qK0Bfo3jgkTs593ZB
         Pw/7bjFdQYqwVnHz62c4YwhCxOT5NrM2KTO8vbHS8eCkUVIx8WBAaYSfL5Xj3CblMEnE
         fhE8HclOj15RuZU3cIXI+LGT3he6ZWigErLlWuilRLqGFBx0J5lI4kDGnjS9FVR7BMU9
         5DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647456; x=1701252256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQR+FwOhW+4znWOcODnwJLSOHCpztagEF4Jo6brt37c=;
        b=bM1frhq/pOXmYWdl+8NO+QMReJgw7ENmiaJXdd4EA+TAqDktw/fUMgtnu3qaOoMKUK
         1uw2Ydw+8F6alvJSLf3FsvW9eX6seNQtOb4vxOoa30Ffzd1yhvr92SbTiMqM6JZObG+W
         VaPzhvG/AR4JZxaa0b/PCrOa+JXw9jvhEKNJh9WPBwGbH52UcKIu1i8hoYQOBQ/YrhN+
         QMs/E5Y/o9unqFjotsqI5HzmIfwXhy3BWPZeogqtiStbEakoObVj+fmsqr1MTMAp0LRZ
         sq/DhwHCCwoTNkh9lu+wXRvN8ydNbg5HpcIebfYINNVwL+o1yStsZQ0sd4CRxKaBJkjG
         Ij4w==
X-Gm-Message-State: AOJu0YxDnn3h/2bKfocl9NmEu5xRYd39y3vVpOToGq7y4/j7LQUOC244
        skgOvQBTeFyI4KHuDxRtxkn5hA==
X-Google-Smtp-Source: AGHT+IFruNFuilsWN9k+BJEv2RT9etp8k1n+3oECwf2s5E+SmoC/tSjyKIApoMLCcrKybjgZrQwoRQ==
X-Received: by 2002:aa7:cd0b:0:b0:543:7f7d:4a3f with SMTP id b11-20020aa7cd0b000000b005437f7d4a3fmr1442164edw.30.1700647456027;
        Wed, 22 Nov 2023 02:04:16 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm6110456edi.28.2023.11.22.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:04:15 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 12:03:58 +0200
Subject: [PATCH 6/7] phy: qcom-qmp: qserdes-txrx: Add V6 N4 register
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-6-d9340d362664@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3380; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=V5aDYla2oajQuDh4yCHt0Oi7qh0FHOyH6K0sEcW0K0g=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXdIVY1h5uD6cRoI8WYfZO32XKCK+eEibKDJk6
 LViEKSEiAqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3SFQAKCRAbX0TJAJUV
 VoooD/9Ka+JvStPWHtIvAdVVGxU8TJkNPKpCS6dXyA3Jc3Q/JYFLxbNKKkFAi5d3vQQ1BGQyNDB
 oC1n90M0s/86BZ6uXsGd0y+7khuHDs+EmfqMNYogaWHfRQw/yxT0s6bTc8UI1D1Z40PatjlEjQz
 b/tSmlq8t0p9SR/ndSwm5YlGV8hEGIj+bj81p9rBt0YZLdS7LLsHHvrJO1EpzjU1O9LoasKUMvi
 kv48D2bhjC1yZMZ1RCRyn+fsNQDLVnGL+kR5JSh1nvISn9V2xWGCcfIHmDWjHN8rPw9l/FLmHmn
 YEqKQftAJOGNBrMkIcCuBU9F4+Eb1BcaSmPBD26NgyXNlEVOn9ZqtQCkkIoNBfg3w/NkVXek6Vb
 blnjnjfLOIqQ/CwCqGdO1iCxoeTqYBvjzMb4OLVmMSmr+WHcnn5lN/m3CMEQOrIbNktJguPaHhE
 agTLdfh2QgX5BVE6BbbMP/FVKPmYsGLrIEVz9RCW1QjOdpvHYVjzHqWGV5Clre8DfekCmcfXcpt
 0IYsPCI/HiIz9Eq0pG+cwQI3OeHguO6z/d+QaWBvvOGE0eG1/L1W0EKwvlJVcvf00iaRl9b66NS
 ZFSVqVMm50LMszSomKrM3iP5ejKz0MZVPomYTYkM1ZcY+Hpxv7zzH3ASM4ocTIuyXD6NECCIrfk
 Qa+7s82d92Wf8bg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a variant of V6 offsets that are different, the QMP PHY N4,
and it is found on the X1E80100 platform.

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

