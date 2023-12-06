Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47FC8064C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376630AbjLFBqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjLFBqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:46:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C310D2;
        Tue,  5 Dec 2023 17:46:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce93552cb5so13893b3a.3;
        Tue, 05 Dec 2023 17:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701827185; x=1702431985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cnQl6rrS5sD2qm7iZDbkr4tzTgzBdd00wWO4ndD9wA=;
        b=NMqJL9ijvtpDq2XsJRVd9HT8LlB0A1FyzhVTyG1b7vGGSjbP4hAJipT9iA9hi9N81T
         bauUBCm8RbpnvHtyvsbNruOfmUwblQFlEvVJRzx+3A55FJahRlJ+6mx6k4+hCcPzs0+O
         RthwNY+hpJiIvoC4uaeKj2EjpkeB+z7/1Bwa9sVyIS+McbRkAItF1nPfjj7aaLuMeeFj
         2s4war9zckih0+UtJGmKmcJ/g0cmF8SzkRPZB165Uj1ycokt9T6VHB9+epJcLWjTkrax
         lAGZ5F2rYmOzoEZJcyNFjCFsHGfJcMVSJ88/+fS6QuMo/6cRBeccILb8ggq0X8V4QTmG
         kkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701827185; x=1702431985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cnQl6rrS5sD2qm7iZDbkr4tzTgzBdd00wWO4ndD9wA=;
        b=SR9jBChRWynvIMusrEdaLg0dYPyj+CGiZTyt5vC9r0R4tm2iMaexDUi6RTUXOUDPhf
         dhIMuZ5vizbUQyFykRa0I34+TcP2RrjtDr9idtrf2IHYCowTFShJnRUjvrbzZnvYzlae
         lT0sj2iDTxFaXGsUBufYRz8zIrg4fPOJVVxI9ghJpdyLCiJ7ivYrs6JFcS9skJbMwFHs
         tWuIqqkMBCYMQeiFMefhLp/aI525gqfB/hfxeIyW5b/k5rrK1p2X9ZXeJ3Kvj9P5+VmL
         +ekOIEUVjnOnISFukhAnZdwwUs3jcD5wK+PHiQivbCcfBBFeUa/6CsxDRpry3zavib0U
         hyjQ==
X-Gm-Message-State: AOJu0YxjlmFTreWoDznKDKj5tWSwpKu3xwIIb3k+A0pVkvq41H4yi7zj
        yH+/YQ0LLvsxy9UO97A5gdQ=
X-Google-Smtp-Source: AGHT+IFqZIF0L0TdIRuIyFI+gFrBEpQshPZzrdrVeAEPVN7bKujNKkDJbF0q2wFqRT0+BZ2BX5T3tQ==
X-Received: by 2002:a05:6a00:22cc:b0:6ce:5b63:3017 with SMTP id f12-20020a056a0022cc00b006ce5b633017mr63296pfj.53.1701827185024;
        Tue, 05 Dec 2023 17:46:25 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.69])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006ce781f6f85sm1250956pfo.43.2023.12.05.17.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 17:46:24 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, andy@kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, jim.t90615@gmail.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v8 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Date:   Wed,  6 Dec 2023 09:45:29 +0800
Message-Id: <20231206014530.1600151-3-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206014530.1600151-1-jim.t90615@gmail.com>
References: <20231206014530.1600151-1-jim.t90615@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO controller to the NPCM7xx devicetree

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v8:
   - no changed
Changes for v7:
   - no changed
Changes for v6:
   - remove bus-frequency
   - check with dtbs_check

---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..df91517a4842 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -372,6 +372,30 @@ &fanin12_pins &fanin13_pins
 				status = "disabled";
 			};
 
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@80000 {
 				reg = <0x80000 0x1000>;
 				compatible = "nuvoton,npcm750-i2c";
-- 
2.25.1

