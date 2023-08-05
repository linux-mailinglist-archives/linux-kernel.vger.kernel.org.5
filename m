Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA2770F17
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjHEJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHEJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:32:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668B469F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 02:32:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99c4923195dso402161766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1691227928; x=1691832728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSb7V+l5INAZZY1BiIqNw95KAR1Jhg86zX4iEYTQuGQ=;
        b=Dh2UTNNMhDdp3D18SCMzub1XDaxi9J93/+Mk33+I/zqU0B7vsfOY1ag068EeG1dWZL
         BWrBI7OwDoYOIXftTZwEQk5O6L3bFUBO/QJ983iN6Sq4TeEFzPossnTk+9TVcNAKQ0Kz
         E1VWqzbPDCO/SfNj/q99vDee5HbikKoTKlX2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691227928; x=1691832728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSb7V+l5INAZZY1BiIqNw95KAR1Jhg86zX4iEYTQuGQ=;
        b=Efsb5DjXxiGEYh3wkMtsV2oQQnOyneuV+q8KcdVpgtAduzmH1iQevZUKsRCy9gRb30
         F0TV52O0k8DM4PecyczHlsg9UW7rOy0bTDeJ6wnE2FF29Wu08/SZvbNjimdqbzEoRH+6
         PW5HodrQ90P7lHcBs4tS6K417jozyCgUnKCNeEpxgc+P2xloItlwhjvI7Ycg5d9PDkCc
         FIhbTvuFHGXHOtpHdQ7kYbFD2yS6r/kJZaBb1t39mtGNoPR5fmfrn+7q6M5QnButGWVc
         W1dOQ7Y85/avu7PJVNUlVmEIA8XcfyqvwFZWgC8mhhcO0PkwMEdAZ0KcKkxIwOJ366Ya
         lHZg==
X-Gm-Message-State: AOJu0YyDk/o37ciymADNmXHj3bWH2uEqb+50rrXoKL3fSwHPQGeQs+Kh
        bQHMmP5VUZB4WHBL65Vb/OQvpcwnPFztHwqRJ9tP2R/3
X-Google-Smtp-Source: AGHT+IG6tPUj15ayZgNSb6hJwTs1tpYV27gmxLpUVe4h+xaQyP0nhYgPqh/GN2YCgDMxiER80YT/Lg==
X-Received: by 2002:a17:906:31c8:b0:99b:fdbb:31f1 with SMTP id f8-20020a17090631c800b0099bfdbb31f1mr3922911ejf.16.1691227928673;
        Sat, 05 Aug 2023 02:32:08 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-12-96.retail.telecomitalia.it. [82.52.12.96])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906430f00b0099b76c3041csm2491083ejm.7.2023.08.05.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:32:08 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RESEND PATCH v7 1/3] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Sat,  5 Aug 2023 11:32:00 +0200
Message-Id: <20230805093203.3988194-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805093203.3988194-1-dario.binacchi@amarulasolutions.com>
References: <20230805093203.3988194-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

