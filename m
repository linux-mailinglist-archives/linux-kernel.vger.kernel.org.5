Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54078136C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443703AbjLNQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443619AbjLNQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:50:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F9114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:50:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so11526461a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702572605; x=1703177405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xX/n0g5EwVAr63DPP+HMCiUOVUpkPp/mNAHdSRNRYg=;
        b=CwxhmIDaV7yjelUjDBNRFwLCfE3BaH0ULxIGYvdFVJuVITWmk8H+Fd+QI7OugmPl8o
         OalrRU45FRcDn7HZb0gpAlSmkD8VCmjfS5ieU/aVj2VKEk1Ab1RqeC3FLGjwYjyXgexi
         CWxntVXNOqXLkOE+0JPCJoCcwgJtACJypAw+IlFH3rJ/shS8JUP19ZcxDx4soUTR1Hsr
         Rd+M1RROizQs1aPlA5lNbwT34ZvNyU9a4pWTHSMqKo0Bn4uRsqVc3jyi+E4Wqy/2l9ND
         wwASXRrs0K09lSWOVxPwkbeyjY1nQWkDvRLh6FxOHQj9dNTQAS1QsDFLtj1c9fILogzF
         Ru4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572605; x=1703177405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xX/n0g5EwVAr63DPP+HMCiUOVUpkPp/mNAHdSRNRYg=;
        b=q0p5Bktjjb34d2LXiZ5HkDDB4nXcQDjzyTji0XUhZoZOxKUtUppSzx/TRb2rfRegkr
         Zo00cVGKizw743S/tCVSomUlPZm0iiBnlLx7uPbc5LgmaRFyasEC8xriEHgcdjBLXJyy
         yk8z0xazSHQvy1Uq5yCw8iW8mwSoOIMWhBC7oLxJiylmOL5FEG8+i7WYrNrPOLwz4tAn
         ITgat+pIu/0l7WozDsGamPJYcFDxavVWZ7+2Tb2EKF5NvhnT/XF57F+CDeaa7/935s0n
         8OtrSSzCHeDp9VdvRpI++07y572OFbfP6YYZZ1pi4a5kb5MppOAP9YrasaPkTerWNszn
         LXQA==
X-Gm-Message-State: AOJu0Yxfl1fln7xZUlnXKuo6uJshrK4nXQ7GN8dP2PoSlZOLMRxgcFb2
        fiLpPF4acUHuTkI9tYfJGayfSg==
X-Google-Smtp-Source: AGHT+IEv/mPZucAVltI8281Jo7h8qiV9A6OS6aysTH6sQLX8y8ZWWUMVH0DlY+Un9zfENIPCM1u2Qg==
X-Received: by 2002:a17:906:3849:b0:a19:a1ba:da2b with SMTP id w9-20020a170906384900b00a19a1bada2bmr5057433ejc.82.1702572604614;
        Thu, 14 Dec 2023 08:50:04 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tn9-20020a170907c40900b00a1f7ab65d3fsm8530308ejc.131.2023.12.14.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:50:04 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 14 Dec 2023 18:49:33 +0200
Subject: [PATCH v2 04/10] dt-bindings: clock: qcom: Document the X1E80100
 TCSR Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-clock-controllers-v2-4-2b0739bebd27@linaro.org>
References: <20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org>
In-Reply-To: <20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=RNTWLyTiZiBUhS5TEQLKFH3Bk5qTv5ogmNaSck4H5Kg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlezIs5mzHZwtUq86DwQ713DJtXqzNNk+F07rvG
 uz3j3UgGUmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXsyLAAKCRAbX0TJAJUV
 Vq1pD/42wcyEr/3/mveMXveopNGd8fA/bKC3uhzJZcqbbU6v6kKE/JUDlkPrgjnBlFkHWTEcFVB
 geaXl//MlupXMIYBAPRTWKrO+9Okbg2MHC3cBkMWm37pcMYvmzfpTikcBgT/vdJqlgo7Id7GLIZ
 +Pe94sWQeZJ87hhPq3wR3Yhf9kTNaVNM0GxLR5jCdaQ4lwQM7dUQfLnLoFOUMGGCAnhKnja+zm7
 s199wukLWFSINGMwCP1U0yu/H77IkadMsRBVwk9xoeTU0fRjMd5t/M3OSCLqPtnTbH8zCFjn4tX
 YjtkXDbEQ9VbRB9EI1xsLByteTxIgFR3CJvNgxvcskmcBiBWap14eN24EWtHCQ2zqO2D6/Ov4FA
 fRfBgzcV5mnLtX0k4+st2akxVx4nfSbNj/kOlI7G6qFn3kNt9rdeg6iSIXH36ms9zsxrpwtxBIQ
 K48gGJLcfczzYASeumVDBZOWzcZ2v8LriWBD6y295SsxpWTtOh5p5Xq4lKN3S7O3UW4ucvCGrcu
 reXZQB/0KHJzZfqh6Pg41omqeFkJKRekKr926Ps/YV1BWIoT2fUd0GZt9sjnQz0jCZS/CiyDiOM
 IIaYBoKn29E4JlGSfb1KctC/CqKhRDlS+ZzJDtNEMd8GZsnHZE1O3OTFPWEbGtSKfhULwddyPSi
 xZqkwznRug0aBZw==
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

Add bindings documentation for the X1E80100 TCSR Clock Controller.

Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |  1 +
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index af16b05eac96..48fdd562d743 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
+          - qcom,x1e80100-tcsr
       - const: syscon
 
   clocks:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-tcsr.h b/include/dt-bindings/clock/qcom,x1e80100-tcsr.h
new file mode 100644
index 000000000000..bae2c4654ee2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-tcsr.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_TCSR_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_TCSR_CC_H
+
+/* TCSR CC clocks */
+#define TCSR_PCIE_2L_4_CLKREF_EN				0
+#define TCSR_PCIE_2L_5_CLKREF_EN				1
+#define TCSR_PCIE_8L_CLKREF_EN					2
+#define TCSR_USB3_MP0_CLKREF_EN					3
+#define TCSR_USB3_MP1_CLKREF_EN					4
+#define TCSR_USB2_1_CLKREF_EN					5
+#define TCSR_UFS_PHY_CLKREF_EN					6
+#define TCSR_USB4_1_CLKREF_EN					7
+#define TCSR_USB4_2_CLKREF_EN					8
+#define TCSR_USB2_2_CLKREF_EN					9
+#define TCSR_PCIE_4L_CLKREF_EN					10
+#define TCSR_EDP_CLKREF_EN					11
+
+#endif

-- 
2.34.1

