Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99978033E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjLDNIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjLDNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CEF11F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:07:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0f3a7717so1509905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695276; x=1702300076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWmmLlilX3gbcvar7gsjgLRS+VNIOWMovsTuXDoyOuQ=;
        b=rAWRFq+anjUoGgxmqCmNldqJiK6MJ1laXyje0zREPK8eGi3M7H2zBLgzmh51jtqFcD
         ie/lxLfjDsVoD3nBXZoX+L0qIX3nqsGGISzyyMHJsbtBigcuZzmAfLEoyg5GYuBvMRJt
         blqTqrMUgKZ0lXGx7q+U9P8Q7ekPAnpnhd4Rx2iO8fXARc+y8lkiuEnoUiY/OtqPck+f
         gg/vBHeAQqWryWyl6bb3Jr6NIMfePlaDKlk697m+iWrJGia6/NfYbylJDlgPvUNTbaK+
         GIuPu/nKTFA1Z5PhALfBymftKXQ8RsAkuuGWUndzF2errfeV30Yba7JATKMG4/53ArH3
         nxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695276; x=1702300076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWmmLlilX3gbcvar7gsjgLRS+VNIOWMovsTuXDoyOuQ=;
        b=ZCJhrQYtdL0GPPHt9FzWEmlDCjdNtIXOHZv2oTcCFBWzxZmU/d5ziv9xnTI2Rc7Ir3
         LYulRI7ARZf2nfrZPMPMyk952gpWPmjs76sI6SXTZm1Ak5UiB83QGs4O5POA53blCLZg
         XeOXWNG8Yq6GxJNDg40JpmOQUBrrGhgnNahx/OYTeme/UDZ8sFaWkpTvqMXwxN6zkQT9
         tqYbHyqKYuhWdmX4Fx98dyxW5BA4MWoLpPlsoY90/YhzZNa1Q57wBGEFT+7Gqn/vZSK3
         HdK2v0M1t8zfpcKBYUmGZ9iAb52wu/13scIfUzDPz5gXlAmKd1UIh5ToaSprKRkmlN0v
         0s3w==
X-Gm-Message-State: AOJu0YzGReuB/Wthne8ZMZ2XdzA6lkS+P3qXF2yAXXB4SnwBAmuiBmTi
        PSOqi45ZjkzTmT2OOfAIiktRzQVph2ScU0koIwM=
X-Google-Smtp-Source: AGHT+IFO8TkC0YafqknzyJiHbazgApgqHTkVMt//R57Dc2eL4peWblxNN5ojXphtRGfK3amw+JdtUA==
X-Received: by 2002:a05:600c:4712:b0:40b:5e22:30e with SMTP id v18-20020a05600c471200b0040b5e22030emr1336235wmo.122.1701695276223;
        Mon, 04 Dec 2023 05:07:56 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:07:55 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:36 +0200
Subject: [PATCH v2 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-2-21956ae0c5c3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=BcYxyyV5U8qIZKRy35xFhfItj4d9siglk0tFq0+vIS8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8ho92yuYXpr2ZC24qzfXEwRLKyy2TQE4a33
 dGVHGv4zDaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PIQAKCRAbX0TJAJUV
 VuqdD/9m3AXtVNuH8aSMki/XqjE84QzISF3tonZMyckA2cAQ+3LJkoHbps5WtRcxSjlEItR8lXI
 u0Yq8Pdjs4CqL1h47q6IXwtUF8mNnir1dJRB6Rz9mTd9321RqSW/RH0jLkFSng938odhEtfXCnv
 sw/lrZ1/9LZQCEtxNuak4hatZyxuw/YYGxqiK/5XCchIPvIsQrhO9w1VH3/Eicd9rAGwQoTHohQ
 vkZ0JahRjYosHQl1J81NjN+muMOGIVpbJA1bN6j4Pjz5dGYywCkd65tVuO06w0ykbPO4pJ72Y+m
 OubgPImwaGiaAbEnL9I7suZeisPKr8Kki1cylAns8U+89YqaAdipV5rEdNsNZsLs/vANCXw3PJO
 vihRGKFw5HXX1eXSww7hMaQq9UaxBPvqRqiWqdGwUtfmyFVm/aQeL8Yvx7gjxg0bsi323X0O/ZL
 pfdG4ctc5jl+5iEJVLgZTgtenzOwjKwhMcYwu1GRch7orMMgnF3crr6/W+sA/vLTKCmedHeLvAb
 k3eJxZKnzpkdQqWpoJESIZur8Xrb3KMT6WKbbu3p+wx+LZqP7F1uUIpWo34V8+q+oaILB0eKMe8
 IKCSU/0M6oEHH3DOgVUSGuTMtCzzAcZZHnOuKPWfmEvgThgSIPQzK4x4MvO7Mu5XYwaO6ko6+Xi
 A78xEOJkSzKVzSw==
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

Add some missing v6.20 registers offsets that are needed by the new
Snapdragon X Elite (X1E80100) platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
index 5385a8b60970..6ed5339fd2ea 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
@@ -15,10 +15,13 @@
 
 #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2			0x08
 #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3			0x0c
+#define QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2			0x18
 #define QSERDES_V6_20_RX_UCDR_PI_CONTROLS			0x20
 #define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3		0x34
 #define QSERDES_V6_20_RX_IVCM_CAL_CTRL2				0x9c
 #define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET			0xa0
+#define QSERDES_V6_20_RX_DFE_1					0xac
+#define QSERDES_V6_20_RX_DFE_2					0xb0
 #define QSERDES_V6_20_RX_DFE_3					0xb4
 #define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL			0xe8
 #define QSERDES_V6_20_RX_GM_CAL					0x10c
@@ -41,5 +44,6 @@
 #define QSERDES_V6_20_RX_MODE_RATE3_B4				0x220
 #define QSERDES_V6_20_RX_MODE_RATE3_B5				0x224
 #define QSERDES_V6_20_RX_MODE_RATE3_B6				0x228
+#define QSERDES_V6_20_RX_BKUP_CTRL1				0x22c
 
 #endif

-- 
2.34.1

