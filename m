Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B1808795
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379235AbjLGMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379215AbjLGMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:19:33 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141184
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:19:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so7845191fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951577; x=1702556377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWmmLlilX3gbcvar7gsjgLRS+VNIOWMovsTuXDoyOuQ=;
        b=gpw8Bzo0EVf7TQ6YYmZt4QT34L3lVhETrD2WgnffxFJTm1Ai4hzPC7gHInybE0b8/T
         ZVtmyCRchPkJvXjQmklCy++H4EIWm1BMbOTa064xYbk0gDfkDDEgUTSb1pVoCN/TYiVp
         E3Y+JzqRA5g6UiCDueQjPoEsLWtv6z22e+4tGgw8LqHzYcHLFgdV4SF8Te3/GsvJssAq
         Ht4fmvR1uUkTtOKu1kJoTrs9rydLGGcFl5+YuB8VkoV0p3LakLiqFU+lqSvKpG+qt/iu
         DO1fi8erXuKIK9ancuj2JitjeVkmLvKvJNNDT/qQchABwsj6KUb60OlpSmzxrRY5wES6
         Abiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951577; x=1702556377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWmmLlilX3gbcvar7gsjgLRS+VNIOWMovsTuXDoyOuQ=;
        b=War2eeSWAefjA+qhqz0aT2XEQ3KKw1/BL/GbinJyDX97lQ9uW+Z8mHVOkGr9wRt61Z
         m2kVhypfWZlVvFd5/JQZhR7ijQmtXRqVLzoobVZEttHJgctCdP7+jX85szMDXbo2/2JI
         BuyBzSHQ6R4IKbWW5PwCNIAoet6YAQV855mNT7fhu6qMrjsLGPC57MPUhry1SwBLb9PL
         vkdfvWMekWlMm4Ne0PKv7RCYkNihz+wG8ddyeDMfTxsZOXgg3lIHe8BlTlmJz7tn4FXL
         50wwkWzDnIdg2tgQ/Ql8FoUOh99gnLChUDY0mWdv2gDQJQhPRUQtRXnOo1dN4FQR1IKt
         Sj8Q==
X-Gm-Message-State: AOJu0YzmlF8LimUABk6KF3+WTA+fF0DcSbToxxuSmLII4BF+0n5/SW3M
        yF1U9Gr+xsFwM8NsTAP2RrZSSpCy8YvX2J+UFIU=
X-Google-Smtp-Source: AGHT+IGFQJGebxxN2tcnm9tcmVkKmdrdb1Nyp89hL+C6X5axtSsbHQfpQqOxwa32AGkCQ0y3vNmGng==
X-Received: by 2002:a05:651c:221e:b0:2ca:2966:e74a with SMTP id y30-20020a05651c221e00b002ca2966e74amr1142174ljq.26.1701951577479;
        Thu, 07 Dec 2023 04:19:37 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm761394ejz.62.2023.12.07.04.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:19:37 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 07 Dec 2023 14:19:11 +0200
Subject: [PATCH v3 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-2-dfd1c375ef61@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=BcYxyyV5U8qIZKRy35xFhfItj4d9siglk0tFq0+vIS8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcbhNzm0ldeFCauD/xTqB8qGmAbsCGebx5egGn
 jEIL/FSMBmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXG4TQAKCRAbX0TJAJUV
 Vm3sEACCt4aFQ6xVg4JADwBmQFo3r5PEQiodTm7vosEVIMVrs+/Jc3FJPe6KGscStDIHQSQY+j5
 5GmeTH3v8WvriwOnmQw9ut+QJj7JzUnnefNn+b5sirSvoUidZNQv5TeudjhBruqekkNTOSZ1DGG
 6iyEXxNcE1Po5JbaZ4GSATn+WVjTulB9Rn+v5GgwYpBC5zYllazYC5Y7dW0S0JhTytGn7QUYIN4
 nm4dZcmpSNz62suN9aUJpAfAh5cyFe0KMsM+RxfLVZdiw4X7eMAU1jo5FPBPefvfMmGhVjtfrLN
 r3ZL/pSieuz07ewzvx0fA81TMjvjCiHBR9iSrorvii30j8Ulu0VZCLv7tkTN4BzCgeILCLt2SLO
 ueikdn3oKyIChAXP6PKkM05Jpb7ubHLgWYkrDYSlSg1FOHgXpTmXvLqzq2nKKbAUv8kFT5RzrD1
 JKdV0SHfI5Gcwz7WhnSzc5rJjODshqR63FLkuNvMemkt/rT0D7Qq/+t48j11w3FIb6mA3djVLgk
 DCj/91V0phkGc+Ga8Vj0ue0nox6aCSzz9qdGRjwzihhuRjpAsVTdzf1KPUWYLreN3V8RStQI7m4
 R1tpE8zWXRR9R84EwpJXWi8FUO6i+gMTItdIrO+UYFOqSJ0Hupfc3IjH1hEfISTFCe9h5zpAoGX
 xV17KgGBtYR/wmQ==
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

