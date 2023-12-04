Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5E8033EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjLDNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbjLDNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:08:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F7DF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:08:04 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf69afa99so1223844e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695282; x=1702300082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFaNDvAciUYjYjthOi5eKX9jiH9kiUBWf4wtlJjm6Ro=;
        b=AM/7MkGeVG0hLmvR/xAV+ZOcsR+fFlbB0FboIMTjryU4y83P0IHAd1sO5kc65EomTK
         C1ImlXzup4TPIolt7C5RaIR7Sycu1VIla7HrDwcjcvzyjq6OORF9EBAYVf43l5klDv35
         luMpU7PQ/j57KnDFI99MvTX+uAMmtwvqB97DSDhl+Xt72G33+OaH7N/F0294c02wybTd
         qEkxL/goSa+C8ntMYXolHbZ+g2ofVx6teJspwpUHCEfCeUBGes+KgZwTcxgqSCNFRSRX
         mVupR/7tuLfGTY7lAiCJYogR4+m8Tts/I+ne8B7wHeqgo489BRUuIqt+6g2PFiewJG8/
         9LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695282; x=1702300082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFaNDvAciUYjYjthOi5eKX9jiH9kiUBWf4wtlJjm6Ro=;
        b=LtZ1/9M52KnqgtlRrXAwQ3Q89FYFRTiSTIrQ3FiPlYJJi1P0fWPW2IP0Lw18j5H6P/
         I8isZTsb7aLfqTjMY7320g5bvSouqGlzROcvmJlaCsOtDqt4zoFMwAFB4ln8Z0/LVaeJ
         vB0CF0a8CcQltEDtKxh6iZSHt9HjKQBCQWk7VAtsgujOFX8Vl8sIEy4R9RZah7Ei1ASN
         JEWppYmCaYOfv/pMvDmk3PVNpE6XTAl/stDMUSd5K4zfCsoFhptfBv6CTZNV5A0ukUkC
         CEXayyhZiPXRx9bxXGdUQ+0/crdeNwYypcuNDXxpRXDSAX05lFT/rm5DFjLARMJgr1t2
         y2Jg==
X-Gm-Message-State: AOJu0YwDy1vh563SKsqW3NeC2zqk6HzJtxnyAvw2lI/uC0TBrqZyS7VJ
        hUYDhKvqYSR+whmB2OeEjOWlIA==
X-Google-Smtp-Source: AGHT+IGSMQhmuuR24eEKa3Yf6WfYllNbOcdr0y63lmh5viDT4S9MLSqk1Cwbe6aM71GCsQJ8cWpCoA==
X-Received: by 2002:a05:6512:3b09:b0:50b:e60f:4baa with SMTP id f9-20020a0565123b0900b0050be60f4baamr2186715lfv.47.1701695282584;
        Mon, 04 Dec 2023 05:08:02 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:08:02 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:41 +0200
Subject: [PATCH v2 7/7] phy: qcom-qmp: qserdes-txrx: Add v7 register
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-7-21956ae0c5c3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4572; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=DSABUphv7ANB5Lh18JmO/Nn4c0WU8ibscamqugkwAE4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8n73wEcEj219yAts+JXiqh7cb9UyOalp/Sx
 NrlXUnvMoKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PJwAKCRAbX0TJAJUV
 VomXEACFgS/Yn56v/EvRarO7w86BRhpfJkdC1P/7PlkjHrw4VACEkM6uP4FzXmoyMubetibLZLx
 cG0Ply6pniwF9SrEBIAGr0R9PNp+oMb9vJ2zFEJCfpQAFLMC8hc4p3B9aDGe23fLK6b1V8mxb4H
 hs7O/3HSzX+ZW48k86jlH6YccsbD+2fnNOiA2qcRaUp061tvWvxrYne0P0TgoDIT6DKc/xE7xbQ
 l24HKBsfx0JjK0tiK13jfwDflHtrQ+Twt8LFeo5ze8+1Dp7tWbZ/y73Xf6J8f2cRf5pECCzGam5
 gdvE7uhGu/Mo6m+kYbi4/pIhI6oE5jEQqgTsd06z7zODcU1d1Xi2gUXMS4Pw99jAQN5s1cvfzZC
 axO4OLVnhLex45mqW0phLs3753wT8wi45WBLyo1xTYLFiCv74hv1hqRg6j7daSi1vvB+xEEqeUh
 zZmJ/Vw/FGY4PKmjbcvL9QB4OtEkPNPc2+iuhSG5PV162ishn+/75yh9Dh0g9F1g3h09l4mZlsY
 4jpI/3waQAN60V+79TPto8p3Yswl+sv/9dPkDlu+huzF79FSqOXeuTaktrUWB3OyHMLuanHAewZ
 26J74DDfFNcSViO1UXw4wmdQLtoXkqCNQmyC4QQXP831M1IH1oQ7z/hi3WM99J2x68IKl0TOHTS
 9tN2GkEP/Mib6zA==
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

The X1E80100 platform bumps the HW version of QMP phy to v7 for USB and PCIE.
Add the new qserdes TX RX offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    | 78 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  1 +
 2 files changed, 79 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h
new file mode 100644
index 000000000000..91f865b11347
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V7_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V7_H_
+
+#define QSERDES_V7_TX_CLKBUF_ENABLE				0x08
+#define QSERDES_V7_TX_RESET_TSYNC_EN				0x1c
+#define QSERDES_V7_TX_PRE_STALL_LDO_BOOST_EN			0x20
+#define QSERDES_V7_TX_TX_BAND					0x24
+#define QSERDES_V7_TX_INTERFACE_SELECT				0x2c
+#define QSERDES_V7_TX_RES_CODE_LANE_TX				0x34
+#define QSERDES_V7_TX_RES_CODE_LANE_RX				0x38
+#define QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX			0x3c
+#define QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX			0x40
+#define QSERDES_V7_TX_PARRATE_REC_DETECT_IDLE_EN		0x60
+#define QSERDES_V7_TX_BIST_PATTERN7				0x7c
+#define QSERDES_V7_TX_LANE_MODE_1				0x84
+#define QSERDES_V7_TX_LANE_MODE_2				0x88
+#define QSERDES_V7_TX_LANE_MODE_3				0x8c
+#define QSERDES_V7_TX_LANE_MODE_4				0x90
+#define QSERDES_V7_TX_LANE_MODE_5				0x94
+#define QSERDES_V7_TX_RCV_DETECT_LVL_2				0xa4
+#define QSERDES_V7_TX_TRAN_DRVR_EMP_EN				0xc0
+#define QSERDES_V7_TX_TX_INTERFACE_MODE				0xc4
+#define QSERDES_V7_TX_VMODE_CTRL1				0xc8
+#define QSERDES_V7_TX_PI_QEC_CTRL				0xe4
+
+#define QSERDES_V7_RX_UCDR_FO_GAIN				0x08
+#define QSERDES_V7_RX_UCDR_SO_GAIN				0x14
+#define QSERDES_V7_RX_UCDR_FASTLOCK_FO_GAIN			0x30
+#define QSERDES_V7_RX_UCDR_SO_SATURATION_AND_ENABLE		0x34
+#define QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_LOW			0x3c
+#define QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_HIGH			0x40
+#define QSERDES_V7_RX_UCDR_PI_CONTROLS				0x44
+#define QSERDES_V7_RX_UCDR_SB2_THRESH1				0x4c
+#define QSERDES_V7_RX_UCDR_SB2_THRESH2				0x50
+#define QSERDES_V7_RX_UCDR_SB2_GAIN1				0x54
+#define QSERDES_V7_RX_UCDR_SB2_GAIN2				0x58
+#define QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE			0x60
+#define QSERDES_V7_RX_TX_ADAPT_POST_THRESH			0xcc
+#define QSERDES_V7_RX_VGA_CAL_CNTRL1				0xd4
+#define QSERDES_V7_RX_VGA_CAL_CNTRL2				0xd8
+#define QSERDES_V7_RX_GM_CAL					0xdc
+#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL2			0xec
+#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL3			0xf0
+#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL4			0xf4
+#define QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW			0xf8
+#define QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH			0xfc
+#define QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x110
+#define QSERDES_V7_RX_SIDGET_ENABLES				0x118
+#define QSERDES_V7_RX_SIGDET_CNTRL				0x11c
+#define QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL			0x124
+#define QSERDES_V7_RX_RX_MODE_00_LOW				0x15c
+#define QSERDES_V7_RX_RX_MODE_00_HIGH				0x160
+#define QSERDES_V7_RX_RX_MODE_00_HIGH2				0x164
+#define QSERDES_V7_RX_RX_MODE_00_HIGH3				0x168
+#define QSERDES_V7_RX_RX_MODE_00_HIGH4				0x16c
+#define QSERDES_V7_RX_RX_MODE_01_LOW				0x170
+#define QSERDES_V7_RX_RX_MODE_01_HIGH				0x174
+#define QSERDES_V7_RX_RX_MODE_01_HIGH2				0x178
+#define QSERDES_V7_RX_RX_MODE_01_HIGH3				0x17c
+#define QSERDES_V7_RX_RX_MODE_01_HIGH4				0x180
+#define QSERDES_V7_RX_RX_MODE_10_LOW				0x184
+#define QSERDES_V7_RX_RX_MODE_10_HIGH				0x188
+#define QSERDES_V7_RX_RX_MODE_10_HIGH2				0x18c
+#define QSERDES_V7_RX_RX_MODE_10_HIGH3				0x190
+#define QSERDES_V7_RX_RX_MODE_10_HIGH4				0x194
+#define QSERDES_V7_RX_DFE_EN_TIMER				0x1a0
+#define QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET			0x1a4
+#define QSERDES_V7_RX_DCC_CTRL1					0x1a8
+#define QSERDES_V7_RX_VTH_CODE					0x1b0
+#define QSERDES_V7_RX_SIGDET_CAL_CTRL1				0x1e4
+#define QSERDES_V7_RX_SIGDET_CAL_TRIM				0x1f8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 63b3cbfcb50f..6923496cbfee 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -28,6 +28,7 @@
 #include "phy-qcom-qmp-qserdes-ln-shrd-v6.h"
 
 #include "phy-qcom-qmp-qserdes-com-v7.h"
+#include "phy-qcom-qmp-qserdes-txrx-v7.h"
 
 #include "phy-qcom-qmp-qserdes-pll.h"
 

-- 
2.34.1

