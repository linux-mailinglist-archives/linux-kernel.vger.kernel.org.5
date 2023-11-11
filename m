Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8E7E8A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjKKJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjKKJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:56:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA583AAE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:56:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40842752c6eso22135895e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699696579; x=1700301379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RE4gk8qOMI692JXd8T3R7RG4N511es9dGQ0TIFnoh7I=;
        b=vsenM7kHRjNRy2V9xkKx1xxjB06Se6nEFO0wfA2TAUK00QOFiVvksTzB5LdLZMepXt
         nfx/Q+CVOHkaf101WP5cHmLWliODxp0H/efvY4pzpmeABLcjxEBpeueysSxJIaD+Xuuf
         spvPH8KTMw/IocZBCkG0LEltART6sncO2T4mlwU9BKfAg0o7ZpkIgHczJoFhNiiAE0pY
         boiHa1liNjEvto87liwvUEbADqsQHtfFy97vpKgfTVz6YpGWUtDmNXTzyy71q10RFjZ2
         GrJUaEJ/E43jutNeviqRkvvOMYc22QFYvWXK1+uGzkvUSSxZrsajwSxqCoQImR5fRD8K
         YvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699696579; x=1700301379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RE4gk8qOMI692JXd8T3R7RG4N511es9dGQ0TIFnoh7I=;
        b=epanQ2l6swxTN2GXDCPq/yf1mGB+iEviFYl3v1I/HR+ay3pWawaJmYJc3rds9lFHUY
         loqwpwJGmQsDFVKmp50ALpq9pMDj1i9BNgw1EgO1PX2el0uyYiXdud8m18+2hpSGVRw1
         LELYROJ3s8Ey0RQEmJvSau4rEc093hG8ZShcpDAEzWk2KA8qUZ3I/DQjGsFKEluzN+3a
         rUUC6wI6W5HI4+FxSeoOW4y80jVTUxCVtpLSWRkKgPszK+Q5IIPf9QX8rk1iHcnPaPHK
         v8V5acfNT45dX/J+GZkI2g3enbWHVZOi4ACoChJD7mAGw01cKHFPeCbmUgU5RcD96wTz
         7lLA==
X-Gm-Message-State: AOJu0Yzaj4oqN9wWzhcTI49Cjvlou/ohrSkPIlkppcai/EHbGn0zE9LF
        eDE4RBWuXQNkAMUmOohID1PrDA==
X-Google-Smtp-Source: AGHT+IGv7j7NdcOXCDkTnkYToIXJwQDuMI2NozWZOgrcK2f/y6YgXdTK5Q+N7SsLslrLts7lOXqySg==
X-Received: by 2002:a05:600c:45c9:b0:405:40ab:7693 with SMTP id s9-20020a05600c45c900b0040540ab7693mr1309396wmo.31.1699696579243;
        Sat, 11 Nov 2023 01:56:19 -0800 (PST)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b0032dcb08bf94sm1152867wrr.60.2023.11.11.01.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:56:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: correct LED panic indicator
Date:   Sat, 11 Nov 2023 10:56:16 +0100
Message-Id: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "panic-indicator" default trigger but a property with that
name:

  sdm845-db845c.dtb: leds: led-0: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)

Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c7eba6c491be..7e7bf3fb3be6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -67,8 +67,8 @@ led-0 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8998_gpios 13 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "panic-indicator";
 			default-state = "off";
+			panic-indicator;
 		};
 
 		led-1 {
-- 
2.34.1

