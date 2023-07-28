Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3F76643F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjG1Ge7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjG1Ges (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE74200
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:34:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2981688e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1690526063; x=1691130863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSb7V+l5INAZZY1BiIqNw95KAR1Jhg86zX4iEYTQuGQ=;
        b=YD4Cp6NO75tumNAqCVjMej9Rug0LbmNWvceQr0SzbwAKu2Nygozw4URutDcKKYfext
         DusewMKsW8+lLIjRK0r++OK7/20chp1hOy3DcfnF0h7ZXU9l5SJiXO8SroYMZ0xNXUri
         JT2QOSm017MWFpT6zSsy3Qzr1/5s69EccMGEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526063; x=1691130863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSb7V+l5INAZZY1BiIqNw95KAR1Jhg86zX4iEYTQuGQ=;
        b=MC9hGyXCGu9AkmmfUyugXDWImzKjB4vLXWwgu+7xzOZ4UX3RRe8DQ8poyBrGxk2Kwq
         S7Rrm5uId/l1Vo2ahVrV/KzaiQpy3i99ERM8/cFOLRd+kIseE6/N4BpPaxN2m0j+F+fb
         Y5zkvWvWhvRQLI4UYe5b/uHXyrnyZZqmyVyAbTHlwc4OuAEGWGrJ3jx/2G6ZdIuRRQ0f
         2rWh1odsbIUdcpWMJ+X3dETajlFyInsU1Zp48Z9I4pKLbcpnPrTUSHEYsQJiDtEMLX4K
         QtKp+JqD4P71ao8Da+oKifWqSmqeGfSPqLuY0Cp9tJj9aQLx5/rn33mY+LSS+XK6TdKM
         dYgw==
X-Gm-Message-State: ABy/qLbOaEQ5vH9SJL8DhTJZZ/lzZ1SFAAitvSaMrdLN16af53R3divw
        PTfPDQShrCSHrN6ocb+UeVLm/3WxG/NxXbMpG9o=
X-Google-Smtp-Source: APBJJlEOqWif6a+SBSBCiAAO7oieIt/NQUYY623dGOgj4qHsxvy+5BMXSEmHibFtUpg/cSz5KRNRHQ==
X-Received: by 2002:a05:6512:4007:b0:4fb:829b:196e with SMTP id br7-20020a056512400700b004fb829b196emr1042929lfb.2.1690526063051;
        Thu, 27 Jul 2023 23:34:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-62-70.retail.telecomitalia.it. [95.232.62.70])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm1425057edo.18.2023.07.27.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:34:22 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v7 1/3] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Fri, 28 Jul 2023 08:34:14 +0200
Message-Id: <20230728063417.2980091-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728063417.2980091-1-dario.binacchi@amarulasolutions.com>
References: <20230728063417.2980091-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

Changes in v7:
- Add 'Reviewed-by' tag I forgot in v6.
  https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/

 arch/arm/boot/dts/st/stm32f746.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index d1802efd067c..36eda1562e83 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -507,6 +507,16 @@ pwm {
 			};
 		};
 
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.34.1

