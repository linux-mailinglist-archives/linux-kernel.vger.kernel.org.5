Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C58136C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443670AbjLNQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443583AbjLNQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:49:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404F125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:50:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1ca24776c3so167981166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702572602; x=1703177402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCLPI7bH+3S27i/ILivETHCwTpYXRhVoatws0XCHn9U=;
        b=vq7uD4xJO15C7SBL+ivqMJFUABME8/JpSAS81Yd6wp3EtqcyhXaFIti+67esf32X+e
         Ckpw7k+QozmCsbYHvMftZQDhgiyq0nLsDIYZ0psCvADDl13qFaJyeGZzmUFy9ISFSIo8
         dnPiNVo5dcAW4Zedkj1kiGMWxRFfA5GGPW7D7v7Q0BREkO7GtCkwbR4RYyhONVXM6VxH
         D2I/dAyABl7csp1D85vGTl+MMDqI5PQiI3zEzc9cJh7WVA1GuXm5Jb/steXTECeZuPnO
         zdhMqwcTLoH2xUkO3MdRr/XzBfpuExzYaj7nxKv/ZeXbdAPcnukpG7Yp6GvX9AmmIxa3
         KriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572602; x=1703177402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCLPI7bH+3S27i/ILivETHCwTpYXRhVoatws0XCHn9U=;
        b=JBQsY8PN3qIP8oJv3NzSBsK73BcGNFd5yN7j86JZH7whs1PIC2sG52Q+OocjY8c9Wt
         un2EQEcc5n71yzZmRFbJC5cMdZP23Pq47RQpOYZqg4FgOPjAQb8cgwkakjO0/9OCet0D
         LnEkrSUOfQOJFW0NTDWiTg2LtSxqBldOIpaayvvR/gNpxjcLt1v/Kktq0LC8aJ3uvzmB
         8qy7ilwjQiRXY+hT/vc7YRRfwlDacSy3lVErZ7McYJ2WJvzAawwIDHE63yX0eTFCyawO
         26N5fTIKKV4onKxANTnAWoZGnQhmcKG9l8BP6XsTlvgu17tt4tFvdLMpxQS8IkzvsLWk
         XuSg==
X-Gm-Message-State: AOJu0Yw8n62giHg3wVISkRglrzlJWqWTlCbQ8Ly5V+wtD5ua0FAH1mGp
        o+r00Vz0xIxF5lVV44I0MVZpsQ==
X-Google-Smtp-Source: AGHT+IGq8n5FAJnRu7vJoKg9pdIrJ0i+QFegnS0o0dKktJx5KEk5M5rmT9o0RECM1PTsL3maEhnQbQ==
X-Received: by 2002:a17:907:7622:b0:a18:81a3:a1fe with SMTP id jy2-20020a170907762200b00a1881a3a1femr11165268ejc.1.1702572601641;
        Thu, 14 Dec 2023 08:50:01 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tn9-20020a170907c40900b00a1f7ab65d3fsm8530308ejc.131.2023.12.14.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:50:01 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 14 Dec 2023 18:49:31 +0200
Subject: [PATCH v2 02/10] dt-bindings: clock: qcom: Document the X1E80100
 Display Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-clock-controllers-v2-2-2b0739bebd27@linaro.org>
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
        Rajendra Nayak <quic_rjendra@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5335; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SR7cwWuwrAzLkn1MdxMzxwbh9Ip0B4d2L9ip2mgk18A=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlezIpi30e8lln4R7lDumKOeGLEZdoa3JvB2ff1
 5QXDrnfzgOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXsyKQAKCRAbX0TJAJUV
 Vq4/D/9axF7cl2Jnan1OcgTc30CwTnL4lT5WgbnpxI0t6ENlr1NUwdo6d6tc/izfn0MC18w3Qpp
 a6Ef5W3QFeDYPDm3oualZej3kXtl4vGYhRqRpdxJV6nNZ93sie9TDd17pCtQ8pwRas6pPaIGGXi
 iVBPasGF4+zBbfZV8sTDHsj7bNYdMSgNs7Yv6Gi45ykIpJSaHmE8+/WvixQPCD3aJHPgQT7ionm
 ubwG8UnN6t231Gad0OIPQ8ZUd8trqAXQ0ZWk3LaKIGQuBsbqQGviKKDKQR8SQ1WdXZN7509qo8+
 eiRZso3Uh7E8z9sZX2dy6KSjnvijRH6PY9hN2ZuZBJffh5GNTGmPzRi3Ex8jbAJ+c0WAcqHii5B
 kIElUbOaDnKnfHRHHAasua4Zev9GdwgHqFD5UwIFWXB1Stur5UZYstdivn2edeAn8q+Vnhp/eNJ
 TzcNI0PA02C3wKg0ygkcvKngXlFbatjsIDDcQyWJRIpSbCUwgw20Cmah5bMSwJPHJAHVeDnkVU4
 jr6g7sBHQcmUbCa/RQv+oBOVWtmsaaeEbgugyqvnC5LzVFYqt/1DTB0hM4ArJJnhl7QsxwGIoTO
 FJrEI70uhCX8D5uFzR71TAwb2iWsfc+n8MxXFG0i1ZfCAIlGYtjyZ8fF3TXK+pWjFLcYQk3v4pU
 D+JOQSdfproMJ8Q==
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

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings documentation for the X1E80100 Display Clock Controller.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |  2 +
 include/dt-bindings/clock/qcom,x1e80100-dispcc.h   | 98 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index 369a0491f8d6..bad0260764d4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -17,12 +17,14 @@ description: |
   See also:
   - include/dt-bindings/clock/qcom,sm8550-dispcc.h
   - include/dt-bindings/clock/qcom,sm8650-dispcc.h
+  - include/dt-bindings/clock/qcom,x1e80100-dispcc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8550-dispcc
       - qcom,sm8650-dispcc
+      - qcom,x1e80100-dispcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-dispcc.h b/include/dt-bindings/clock/qcom,x1e80100-dispcc.h
new file mode 100644
index 000000000000..6bbb5c2d0b16
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-dispcc.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_DISP_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_DISP_CC_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_ACCU_CLK					0
+#define DISP_CC_MDSS_AHB1_CLK					1
+#define DISP_CC_MDSS_AHB_CLK					2
+#define DISP_CC_MDSS_AHB_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_CLK					4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				7
+#define DISP_CC_MDSS_BYTE1_CLK					8
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				11
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				12
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				13
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				14
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				15
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			16
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			17
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				18
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			19
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				20
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			21
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		22
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				23
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				24
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				25
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				26
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			28
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				29
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			30
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				31
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			32
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		33
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				34
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				35
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				36
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				37
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			39
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				40
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			41
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				42
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			43
+#define DISP_CC_MDSS_DPTX2_USB_ROUTER_LINK_INTF_CLK		44
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				45
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				46
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				47
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				48
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			49
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			50
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				51
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			52
+#define DISP_CC_MDSS_ESC0_CLK					53
+#define DISP_CC_MDSS_ESC0_CLK_SRC				54
+#define DISP_CC_MDSS_ESC1_CLK					55
+#define DISP_CC_MDSS_ESC1_CLK_SRC				56
+#define DISP_CC_MDSS_MDP1_CLK					57
+#define DISP_CC_MDSS_MDP_CLK					58
+#define DISP_CC_MDSS_MDP_CLK_SRC				59
+#define DISP_CC_MDSS_MDP_LUT1_CLK				60
+#define DISP_CC_MDSS_MDP_LUT_CLK				61
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				62
+#define DISP_CC_MDSS_PCLK0_CLK					63
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				64
+#define DISP_CC_MDSS_PCLK1_CLK					65
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				66
+#define DISP_CC_MDSS_RSCC_AHB_CLK				67
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				68
+#define DISP_CC_MDSS_VSYNC1_CLK					69
+#define DISP_CC_MDSS_VSYNC_CLK					70
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				71
+#define DISP_CC_PLL0						72
+#define DISP_CC_PLL1						73
+#define DISP_CC_SLEEP_CLK					74
+#define DISP_CC_SLEEP_CLK_SRC					75
+#define DISP_CC_XO_CLK						76
+#define DISP_CC_XO_CLK_SRC					77
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+/* DISP_CC GDSCR */
+#define DISP_CC_MDSS_CORE_GDSC					0
+#define DISP_CC_MDSS_CORE_INT2_GDSC				1
+
+#endif

-- 
2.34.1

