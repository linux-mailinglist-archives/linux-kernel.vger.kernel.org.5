Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA232808792
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379264AbjLGMTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjLGMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:19:35 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F920D4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:19:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1eb422b412so125291966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951579; x=1702556379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7On32Ao7taWCroDJzXI//r1UxZ6SeERvRI44tfdfGvE=;
        b=UwvpqHpzs6/+ieL8wNn4QJnj7vChjexHVFRCh1UxYg+56OpiXmpkyuKLsTNFGn+sSr
         gyCYWvPZVlG+7jtKwDyrb1PPw46oU/5VWtHUdpAc+13Bq345w74Ff5ZpJMc3GWYHW1sm
         DWCeGvEJISZdxa4yOg7ISfW59/A22RDHv0juxqhgIeJpkJaEiZWobxABZlu3IevfJ/w0
         OFtK7eMpiMY1Yw4KIxjqcKiFVao+o7SKzOh0e72wKa4ONc3FZbG+0OA22FJhEolgrxLH
         O1ccMi80jr1NxlbLTEAM41Coruy2mOyh4hssKMTqo6R6u/DcBek3YIQrj+3L62qn2F1K
         Of/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951579; x=1702556379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7On32Ao7taWCroDJzXI//r1UxZ6SeERvRI44tfdfGvE=;
        b=cYKH+oA/hJxXfd5+K8UkUkSNJej6cYgLP52b7orXztPNvYb0+XIYErAOK36tIgWb/I
         aSt04JqmjMSbi+rQPDF2TrZZNTJ6d3yYGw9s1WbUFL+tWp9cXoGaRtUYtdJHwRWb/PiK
         NF6sHP1LPuATwZA0urCBIF/giFmeKuxbvM14IwpPuh8ABRksF+cFYop/bErTmpLtbTl4
         gOW0XzjiZ2RqQh2y09RAw9Kqod47wbuq9+mWU5Ke9lwYyQzH74XjHj9j8FAIkfeMkTb4
         rNGzjiBOQYx1qL5YfyKEC9W67p1NReDvAEdeOkKyW0gDNRBQ3FoMlRjZVsrkUdBPdr83
         fneg==
X-Gm-Message-State: AOJu0YzPjnwdkjboPup0xk432tyrfHYgDW+B0VkqQDT19of+NKVrPXTP
        xBZVf3LOi5TSw/uZM1ogsCvoKA==
X-Google-Smtp-Source: AGHT+IF61+QjWE2AWz41aasoYB8cRvYzAzPEIV5U9doaUwbMp6/Fx2hixokB3I8/2YAu02VxHQVUYw==
X-Received: by 2002:a17:906:bc4f:b0:a1d:6780:8fef with SMTP id s15-20020a170906bc4f00b00a1d67808fefmr2619897ejv.72.1701951579736;
        Thu, 07 Dec 2023 04:19:39 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm761394ejz.62.2023.12.07.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:19:39 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 07 Dec 2023 14:19:13 +0200
Subject: [PATCH v3 4/7] phy: qcom-qmp: pcs-usb: Add v7 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-4-dfd1c375ef61@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=094Egkf62OVqF7D0untdpemc272H0gSJ6WbJhC5msA4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcbhQMxZFgnrlpDPmWBSqqG6wCOokWQjV8TfhW
 YkzQvmz4pOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXG4UAAKCRAbX0TJAJUV
 Vr4rD/9LuG7frASaJswBxrabFG8ybpg4BmpxcBxFemfvMleShmPjSXU6i0D91hXkwFBKpWXgeFM
 750TMGcVrZQIDjV05bc5DwxAkGcbQPUX+zGHy6RsT8fZl5HVHn1h+ZCsYfAWd6T37AWNT/ju4Zo
 MsFyAqkHeSWAp/CiTyonIKIYBSPMCs9ohNrLcB1EXQgJCTrCwgKCfSHaq0cVOgV4gkPKhr+scL1
 faadenslWvQMLcFCiIJuJV939PnHavI6kTHc7TRG5QrgzJfOUNGYZqmZzE6p72gcyakznSc/KSQ
 YVaPe2HfGD3sx+1k6zuM74Ddf89NoGhRwuJdJ5wqSRg69VSZ2LTThGqJJmby8o5UTIQ19ohTfr9
 9jYQPCjFYui7I5RRxISp1qlvNzuFNF4BiCTrVVCcj8GjFgL/rr7EDBkAHH+tiRqTQYS09vF9TUB
 5cViI6ULLuLNM7EoWJIK8opvAjPX3+OvN6U3ob/qS8iVkbj8TJeUyuaNpElkzUWR+iBuMAxv8Qb
 YcZFVtPTBCl1zE4iabH+BTqnpwCfZ0H3T33KlOUva1WvYN8A4XP2BmZh36bDsC0gWOwnRw+kBNx
 AhZlBum8Wpj3wTTebkHrXXkNRWs98UsUYcAeXvad2a9xb/ujopTQS4bC+dtkyqm+gzPzs5xz7py
 DE4GK5p7nVKiwxg==
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

The X1E80100 platform bumps the HW version of QMP phy to v7 for USB.
Add the new PCS USB specific offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
new file mode 100644
index 000000000000..24368d45ae76
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V7_H_
+#define QCOM_PHY_QMP_PCS_USB_V7_H_
+
+#define QPHY_V7_PCS_USB3_POWER_STATE_CONFIG1		0x00
+#define QPHY_V7_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x08
+#define QPHY_V7_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x14
+#define QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
+#define QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
+
+#endif

-- 
2.34.1

