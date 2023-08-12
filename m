Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCC779FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbjHLL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjHLL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A931E7E;
        Sat, 12 Aug 2023 04:27:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so4536033e87.2;
        Sat, 12 Aug 2023 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839638; x=1692444438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF7IV/t2RnprYmLwfCnYmyCQpWT6QNpR/xfog5JcW0k=;
        b=mrSilgtXyIjVgz3RGl4U1tDbBtEZ15EsoDGG//y24OaFWUFe+uOnVqBlF9G06W/h2j
         CL7boTuFOG/3vLcN+OiGWEVjwodaeWNOUQ+evLNqXQn+wBHU403KhbCxhp9YDfNWhinz
         p8hdLQoE6pDLPS3ZGe+2dorr3T2zVpTgCOYs8z7XoErSvsToN/KAy+w7TM0cgrBcRChd
         de9U9Ti4A+5kO4KAR+jZtiRF4ML2PZhPLvOLZcv1kp9QIPwQWjrPINZ6gkYzlM8F67yj
         QeldAXeBHTaEQT9y0hBe8nOFCtF8YsiehYD8Fr74UXaft5qoyqox0nrXtkRejii63bm/
         rIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839638; x=1692444438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF7IV/t2RnprYmLwfCnYmyCQpWT6QNpR/xfog5JcW0k=;
        b=f+jfDcq7lCfhbzs/kkbiXAPrC4YXqoSCBHS5M8DF8A1MgKVlTGckyq2r7dMc7e/P8n
         yIFvhjJYfaXAGMt+HEqv47M5aMVLjkbRckTrhPeA/EAgnFE8fP6Ec2QD7ryEYR/dMsVM
         CmsqTf9u5qU/w2VGdCnGkGM8XC6dp/k8ti8QtsK5O6pre8rkyCoFYO0hFdG/yxdMDGz0
         IW5C6UGwCP/xUte5eU/F5Q8P7ram+0gCGacccLrD7JN3RV8nagACplkQKPMHY/ZTivxD
         pIuVQjHOlvGySw2elR0W1j7UgpDCnBeyaJJRvSRllRPmIZK2p2Rp35srLaUy5o2wTyvC
         OcXw==
X-Gm-Message-State: AOJu0YylwQG7DM6ZWFqIg6R1k8sOBjSiDbg88FSfOW2A1o0Agv2uQYMz
        lE2yhJaoMDypuWCyrccJd5o/v/643pTsVw==
X-Google-Smtp-Source: AGHT+IEyIrZJpbCI0kGvUIiGJg9EDT8jtoIJfftz9EptJb9uUSUdEItjjsJFcnd5+yGtZ0Zlp5scZQ==
X-Received: by 2002:a05:6512:2814:b0:4fe:d0f:b4f7 with SMTP id cf20-20020a056512281400b004fe0d0fb4f7mr3915409lfb.65.1691839637721;
        Sat, 12 Aug 2023 04:27:17 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:17 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] arm64: dts: qcom: msm8976: Fix ipc bit shifts
Date:   Sat, 12 Aug 2023 13:24:50 +0200
Message-Id: <20230812112534.8610-8-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update bits to match downstream irq-bitmask values.

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 7385d5edec04..ab6d3834e436 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -384,7 +384,7 @@ adsp_smp2p_in: slave-kernel {
 	smp2p-modem {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 13>;
+		qcom,ipc = <&apcs 8 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -407,7 +407,7 @@ modem_smp2p_in: slave-kernel {
 	smp2p-wcnss {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 17>;
+		qcom,ipc = <&apcs 8 18>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <4>;
@@ -433,9 +433,9 @@ smsm {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 8 12>;
+		qcom,ipc-1 = <&apcs 8 13>;
 		qcom,ipc-2 = <&apcs 8 9>;
-		qcom,ipc-3 = <&apcs 8 18>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps@0 {
 			reg = <0>;
-- 
2.41.0

