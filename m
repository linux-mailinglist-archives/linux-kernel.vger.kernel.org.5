Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E347E0C51
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjKCXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjKCXfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:35:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E26D54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:35:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc5b705769so23455915ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699054549; x=1699659349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw+uldh2RwvGjKOhMreCBsCH8sZS6gcDHUS2RnYpsko=;
        b=Hpl4ZxsFpgsqWlj5Ny8O3WhgqFihKaBz/L6zLNDczsJZcrsa2MpyUbREr7v4k2sJlE
         xPQDWbOCIiHohVeL+zqPJf+nkUfsdwoRdDFqgTpvZrBcF27SNhdvoNI9bYtVeHNrClCx
         VDJL4kS3PWfKQ7i39gTg9AGE7bBwr0lX41ATY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699054549; x=1699659349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mw+uldh2RwvGjKOhMreCBsCH8sZS6gcDHUS2RnYpsko=;
        b=DlCcnfgoWGgFC/WmOG27Sdw0U+YxQ0AR1AVqr+HBLKcW/sN4dlM/Sej3GsStJLRiMO
         y6x7ZjUkaTGnpzYs2eYnSgdQMPZEX6VA6mOB0198q4NGA/fWtIxON3CqtO7DEqplYQqh
         bptIlSRhk2vlrWGKaZ6ckBgrJHRPCBQfh5cpcm1qJ5zhLdob182TfTkDgJhCDL039kNd
         KrqF6Mwy1aKYpWA6TZUaAAgc75ff+X3raAi3SYwe5yeigO24JLz0Cys5IL1p+oWiuUr8
         GRL0kgVrtns8OtroPcPmXBHSG9aDYzjVVfJkPP2Zr7MkVthpx5URpnq5uYpu9ZHvRruZ
         f/bw==
X-Gm-Message-State: AOJu0Yz2cVXvRY2ruT2EL86eEzbHKdv5n2yjmM4LvN1wGn25JkqoHcLy
        7yCfZDR2+GVOSRwVpGDuYbwBtQ==
X-Google-Smtp-Source: AGHT+IEy9cZdR6sRdDcPylg21w3fn21uHyJ53vSXSY9OJb00KDbf/ag2V5ENuIhA6oI9Qy/7dL4rzQ==
X-Received: by 2002:a17:902:dacc:b0:1cc:4677:2f0e with SMTP id q12-20020a170902dacc00b001cc46772f0emr21613646plx.45.1699054548862;
        Fri, 03 Nov 2023 16:35:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5195:5e72:f5bb:e3f0])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b8b2a6c4a4sm1878114plb.172.2023.11.03.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:35:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
Date:   Fri,  3 Nov 2023 16:34:29 -0700
Message-ID: <20231103163434.3.I16675ebe5517c68453a1bd7f4334ff885f806c03@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: 36c436b03c58 ("arm64: dts: qcom: sdm845: Add watchdog bark interrupt")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bf5e6eb9d313..9648505644ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5088,7 +5088,7 @@ watchdog@17980000 {
 			compatible = "qcom,apss-wdt-sdm845", "qcom,kpss-wdt";
 			reg = <0 0x17980000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		apss_shared: mailbox@17990000 {
-- 
2.42.0.869.gea05f2083d-goog

