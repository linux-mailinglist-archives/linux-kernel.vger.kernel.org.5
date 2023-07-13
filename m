Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4659A75270C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjGMPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjGMP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175226BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso7850515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262172; x=1691854172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8SU39DO66SASFui1yC/ujei8u3JvD1we93aqyvWpak=;
        b=rDidEdglgROfogmvKHpDKuVP8nk8yf1uwNuRsYH+4VhUkTjVkFD8MFlXgwK48yhQ4E
         ZXbHVkoUDBr8tvPtBRSbtUCV/VXW8RHSYaiJUPCWr1s1EMha36wU/fGeyGXlcmjd3Jcv
         HT4AM+4cSEEUL0lRhagb5tEqKAinBMensMiFy2s7fZXmvEwUdlQn5G6dxirCUI5+mJur
         r1m6L6fPQm2KG2aOxsmxgjs2pOFZJE6PjflAp6G7ZSVr2/jqQJ4/s3sOEzzDUVrQ0orw
         G+wkjRs69TnZoAUHnZGhSok5wBgwvyX91AReJd8UO8u6W39EkjjdV/tKzq291PT/1HfR
         sBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262172; x=1691854172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8SU39DO66SASFui1yC/ujei8u3JvD1we93aqyvWpak=;
        b=ADAJeQ3gwJHP9Bl4oYfzMgn2CMh6C31WwXugAbd/W99LWl0BimnptIUQOtgzEtREyF
         JGxuixcd63zYbhHvjgGQ/xLySFRcCRyWH1WHS7Yb+FAL55aRa4J2xk/hhvQFMQaGlRMw
         Uzn8AenTMJ8tYKnXnOQsA5V8LbQwjyk0beN6LEuCMWytUK0auZgBvKIz/SSD69nTrS4p
         9422EDnHwp9ksf40TpX9y1d4gVYbKvMhdz+DQxcybE17Y8BfmtNw4Fx0+lNl2hc11rWt
         H+vKEGinYwV559eYkXOrLvzRnKYID8IGRtjxvrhJx7lD7/+q43DXue1fE34aiCYCQtcn
         UlgA==
X-Gm-Message-State: ABy/qLYsSgFImHeIyXkNZPH32Lxt10VhCcRh/dmkZpe1goLfFLeWF8hU
        H489IPYDNoPPVAswRLNx8I3c5CR5ywMh02eQpx9D/w==
X-Google-Smtp-Source: APBJJlGV6M46/wD02lu2eFgeSurNYpA1cSnMuEPCjmzmcUifEKW23Mn+MD1jNuzq/AJmyyQcxqewkg==
X-Received: by 2002:adf:cd86:0:b0:314:1fd7:188b with SMTP id q6-20020adfcd86000000b003141fd7188bmr2162397wrj.17.1689262172285;
        Thu, 13 Jul 2023 08:29:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b003143aa0ca8asm8285924wrv.13.2023.07.13.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:29:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
Date:   Thu, 13 Jul 2023 17:29:25 +0200
Message-Id: <20230713152926.82884-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The davicom,dm9000 Ethernet Controller accepts two reg addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/s3c6410-mini6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts b/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
index 17097da36f5e..0b07b3c31960 100644
--- a/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
@@ -51,7 +51,7 @@ srom-cs1-bus@18000000 {
 
 		ethernet@18000000 {
 			compatible = "davicom,dm9000";
-			reg = <0x18000000 0x2 0x18000004 0x2>;
+			reg = <0x18000000 0x2>, <0x18000004 0x2>;
 			interrupt-parent = <&gpn>;
 			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 			davicom,no-eeprom;
-- 
2.34.1

