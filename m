Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56580DE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjLKWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345077AbjLKWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:46:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE8CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:18 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bee606265so5276239e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702334777; x=1702939577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVuml0wTQI2Sh4+KLUTzQhGG7DP8PaZ2ByvLlSAt3kM=;
        b=vRvB1UR8Gx0+5ud6Jjod0KaJmC4+0g8/dYBluzhDFIda7bsrOj+D3CXqMBw1K897tC
         XBzuTXf2SHiTSxmxuOck59S7qT4xiJRoTBIvTs+koqyEfZnQ8iWcZkPJ6Hpo4h0OZH71
         dEV92Aeka9qq6CbXyeEDPsZNjWa+yIMfWlW69auw0JEsUPdY7xwslKQHbgz0SVGBWlFf
         FJdXtzcIORK2xTi7drjvMcofC2nsp9tgHl112STJHXjX6ILqUqc80Z8gUhPi7UofUkZv
         Q5f598jQm+vBYIdkj1oX0fc9lAZ5KuHHeqxAJEg9xgyb2el+6sk/9Zp+UXyXs755m6V0
         FXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334777; x=1702939577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVuml0wTQI2Sh4+KLUTzQhGG7DP8PaZ2ByvLlSAt3kM=;
        b=bT4bkOvlMAZNmDemYb+d2IKoUzgNxw3dQIisUNOjCgMJoRsaKw+Xh0Uo+a3OcQFQMt
         yDh7jJQkR7qzSj8bpqvvkCa7YNLdp7yUT1cx1hGLO8vk7+bGJUyZxTq4FmdkdtWa/Ycb
         9PpaB9vQD5Qa1X2kWEL39rucUgFfGeSLi0s6R7MChLJm0P+D4k0d4TTIxVLi2RDx0kXR
         65IWZcbTzUDUnN/UjViJOoHU5jSK2dOE84yhzoCTm6a3+SoHJE2+X4TSmVMOaOVfavnb
         l9Y048A0Wm25bzQs/ikVS94AeYaYM8zEciShl6lia/1YjD/IM75+NSvrhNYwxFH8BPLb
         +s6w==
X-Gm-Message-State: AOJu0YzFDz+oReM2IZHGA5LgrlQpA0I2ZFWjuSsX9Zn1qUursDWBQZAJ
        3Uyic6Trrdo8Y5YHuLl8dMw85A==
X-Google-Smtp-Source: AGHT+IG9L6Qk+j/0AR9e+xyWPUF485AB4JdFSdAddVyAled9jrF2XHO2pQ1Ku056LMEzBmg9n93eRQ==
X-Received: by 2002:ac2:428b:0:b0:50d:ae2:2a9f with SMTP id m11-20020ac2428b000000b0050d0ae22a9fmr2075279lfh.24.1702334777135;
        Mon, 11 Dec 2023 14:46:17 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm4091789edb.59.2023.12.11.14.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:46:16 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 12 Dec 2023 00:45:44 +0200
Subject: [PATCH 04/10] dt-bindings: clock: qcom: Document the X1E80100 TCSR
 Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-x1e80100-clock-controllers-v1-4-0de1af44dcb3@linaro.org>
References: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
In-Reply-To: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
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
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=FOfc9+LMTvDZfP7GW0tpcJIBG56UMDNwWt5KwU5RA5M=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBld5EoLtTNiIaAQ2h5mkx/v4NusoVb2sMUJthPh
 Bfqi3vJMpyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXeRKAAKCRAbX0TJAJUV
 Vjd2EACErzhicYKDln9GwLSFKvqpNnKglF14qp5zpALpWI+a87uXTEfQnSvtg8ec5Yn5S2y5+9H
 um5nG2Hphp6sGvUfvNOa7s05FlKGMTUOMPnH3ERFWelNG39PrRgVLDOMJWeDQzSrchfpkgkFzZi
 zDu5NjZ/0W1emwv+0fIut0cZwmIB1lDbd1M2g8GwiefFwTstqBuUzoGDN/YVS/P+3QqWrAbS+uS
 tQf/4SCspGyWBuRqAWk4MtWksoVmUvc++b7X1X2gGiFSSH15W024G3F0YgCkfTtonCNGwwvq0au
 KGEHso2Fgy3NIv0hJZ975WQWw5q70sitPw0vDfcrL0ToVy8Kf/0QTuZlB+4ziaiUFybCWTTadhD
 3CbRzXNEDwWb62ENrV6WHijX64A7uS9+p+WLWydK07iCYBQ9oACzcQ+C07sPX3Rgez+6K8qge7J
 XBWhwDL4bZkcQG3pkGKz6fiBFK0u70il9EnQ0vRWpn5GXToJswB7Xd7lqNTA+hFbqOX5AGXVXkI
 KaEPCAy9M0D0PWxAvvJ5dLQiMgBK/kuwmjEhDtVzSfEuD0VVjJCqN0xvwYmKwTun1Lvp1QE6Iv+
 ATrSCtRd75KZ3QYWaN3mR1LdFCa38hE0wdItYUs+HRnpHq9KqKAIzjme4m8VwwDxkN53SjdWHJf
 RTMZWapFpaz4Hhw==
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

Add bindings documentation for the X1E80100 TCSR Clock Controller.

Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
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

