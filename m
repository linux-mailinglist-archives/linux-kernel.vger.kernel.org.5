Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBB81399B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbjLNSNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572979AbjLNSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:13:48 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A8116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so106465771fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577633; x=1703182433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tC67f/rlpMpveywW17PnxYzUi/Glfsd8AP6R8y378/w=;
        b=cln9RAwOuYvElTMK4ZHTDkUWfsbWwFug/0gLM48BVqe9c6QtQL8d9P4JKqLe1hEtuc
         QJ2xdK7cQvgcQUO3KCZrlCH5oRQZwd/kNFtTWC+C7LozGH1a7Xh9qnvmAr4aJ9uEZbDR
         tcvvQsU+wQVr/Klc22LHK4bnrklt/RnBCWJkXF2CL3y6pQlkvkYz/xa016kcrsEi0gdp
         lxJaGiQAiy0FMZrlWpXBNW+8kI3Bs2Lh3UlUJYr8Joxp57ZdVTjLANCqiXt5/X1KrKCF
         WDXTWEMecEsbXerEop1GPTjDscfSl/YAQITgPRJVKRx3h2vC8fbpau5kFo8U3/eDW+7A
         vxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577633; x=1703182433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC67f/rlpMpveywW17PnxYzUi/Glfsd8AP6R8y378/w=;
        b=CjHseFWyzd0khPIxnbjatws5w2vncNX4rU+DZIA/CRw175g1wea5MDbDh8qwS79Vgz
         ymBvdB/KVIYoxcFW3kGeYxrxeQBLnrbKSvq0dUElEwG9xZbf/4S0XAw07zuUX5nIRULl
         NBbKTu66mqgjjYGnOk2ZRIc5BGyXGTLfaj5vnMSGsnwDvuJu9LyMzNlrmgx1ePAN1hCA
         X9X7JMup93eWMURaOx6UoI5wXDQ2FHBuFZrmaLknwSR4SNvlILwLR/SCrVhXmNBzulaL
         WZhWUzSHyKRtLD44q7bmQpdGkWYXddoMVB5TKQT/zf7jWmZKgHgnqTjFlhVMZDNgVy/V
         vR5w==
X-Gm-Message-State: AOJu0YxFjulNxc6mwQFoK+RN6hiwWL0o8q3ntdPM8ubF3rqc2LuzZ5a+
        WCvgoNcbX6Ueo5aZ1XjpcN4HtA==
X-Google-Smtp-Source: AGHT+IGcbEe+tBDd6I6AyNkwGs0Ia75MCyM7k6vMNAGHeogC80Iy8W/qiWyD2+XvGIc/Gbj8bqpTqg==
X-Received: by 2002:a19:8c1c:0:b0:50b:ef5a:d022 with SMTP id o28-20020a198c1c000000b0050bef5ad022mr2770578lfd.41.1702577633070;
        Thu, 14 Dec 2023 10:13:53 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:13:40 +0100
Subject: [PATCH 3/6] arm64: dts: qcom: sc8180x: Add missing MDP clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-3-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Gustave Monce <gustave.monce@outlook.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROT clock is required for the MDP block to function (looks like some
others depend on it), and whike the LUT clock's purpose is not clear,
it's likely better to turn on all of MDP's dependencies rather than not
doing so.

Add these clocks under the MDP node. This also makes Primus work without
clk_ignore_unused (as far as the dmesg-visible errors go, anyway).

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 09b4e66367bf..c970dfb11fe5 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2702,11 +2702,15 @@ mdss_mdp: mdp@ae01000 {
 				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
 					 <&gcc GCC_DISP_HF_AXI_CLK>,
 					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
-					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+					 <&dispcc DISP_CC_MDSS_ROT_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>;
 				clock-names = "iface",
 					      "bus",
 					      "core",
-					      "vsync";
+					      "vsync",
+					      "rot",
+					      "lut";
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
 						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;

-- 
2.40.1

