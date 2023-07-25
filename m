Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63083761F76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGYQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGYQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA726BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:49:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so67323a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690303760; x=1690908560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzDnwBHcCNYgqCk2X/jo3Kq9KdDwUHbWe6RB2ZMyEY4=;
        b=TCeibtGzLYGEID9kWxkcEtw7CfPkAoacYLEFrpGofFAW/cwxJNvuVRO7xOrtRnhnBu
         /6NAx3fyvPUOBZlewhv6OBQ48SEh5bTvfrSwhafPAz85kLpjgqJY/zPt5xKjeHUJ9YYU
         h2uOvAw6xEXpLAFpLOG8lpr26WPuV+18888K43zo9y4ud6YsXkNfVpshAIHZo+qq5dnR
         gisfnSAWAPILtaY+i7iJ3iI0jPwWmMcCcODWFy6Di7HXvPre5aOXBA6hB3qpq5M1y3t1
         sDV9axljxmhYHgUq/7MiU9KMswKdhM0sfI4KA2ytYabpK20zG7VKLPHSlZ4QTadM+moV
         ae5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303760; x=1690908560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzDnwBHcCNYgqCk2X/jo3Kq9KdDwUHbWe6RB2ZMyEY4=;
        b=aV0FuZ0T4nDxdi52o1AFT4hsO1WV7x6me2MAWEwVWyGA2dwT0c+wuykrVTeXeHsZt0
         /1GKndDku4OW5wIaE9GjE74UqzPcyJvOzquNAhPpbjY45dqBrFxRNtE3HJTH8ChKktZn
         v+YItxfoqCIa/qpp7O5wkAjH2uCFBoUn/7hQSRtYAPXWLnqaovju7H4FS1qirh7Yv5bi
         v7ti2GMJM+iTTGJ+CTEks1NZXiRs0ScBYOPo40Qc0q6iVs1i7ZrHsE33aMZdtAsSMKzK
         jz7XBRuFEjkJwlCRTbmn7Pu+BRxL8H+Cj1s1rMRRQRyKglF50PS+PsuLkIlfABTDGl/G
         o9gA==
X-Gm-Message-State: ABy/qLaUf5lq21XRZowc4xqNkA11qBb/b/E+Qlzs/G5TrAZrnlpSPJTf
        97igjH8E2s58oPkaiTjLVW2zUg==
X-Google-Smtp-Source: APBJJlFOAdT8ihjLNFzNTm1qELLYzD+sgpFi/cCe33I18hmaJCMJ2jFnwf9gzGqteNMJbgb69iFOWg==
X-Received: by 2002:a17:907:7daa:b0:986:38ab:ef99 with SMTP id oz42-20020a1709077daa00b0098638abef99mr3300571ejc.9.1690303760401;
        Tue, 25 Jul 2023 09:49:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906274500b009932337747esm8379401ejd.86.2023.07.25.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:49:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: qcom: apq8064: drop incorrect regulator-type
Date:   Tue, 25 Jul 2023 18:49:16 +0200
Message-Id: <20230725164917.371714-1-krzysztof.kozlowski@linaro.org>
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

regulator-fixed does not have a "regulator-type" property:

  qcom-apq8064-ifc6410.dtb: regulator-ext-3p3v: Unevaluated properties are not allowed ('regulator-type' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts | 1 -
 arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index c57c27cd8a20..c0dd6399f597 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -36,7 +36,6 @@ ext_3p3v: regulator-ext-3p3v {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-name = "ext_3p3v";
-		regulator-type = "voltage";
 		startup-delay-us = <0>;
 		gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 96307550523a..b0c5e7bd5e74 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -58,7 +58,6 @@ ext_3p3v: regulator-ext-3p3v {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-name = "ext_3p3v";
-		regulator-type = "voltage";
 		startup-delay-us = <0>;
 		gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-- 
2.34.1

