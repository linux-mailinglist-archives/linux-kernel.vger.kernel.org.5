Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CAD7DE3B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjKAPQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjKAPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:15:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E44137
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:15:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cd444d9d0so43322131cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698851753; x=1699456553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka+Xo95ntz292nY8csJ3Hgsgw+UrjlMRzQhCOM/x1Z8=;
        b=16FnGJVv3gclY6/4YGPAcEyZaSh+UnHEGHpPeHJ/JufOwW4tMgYUgrF55R35qUrNKA
         H16ZgFswZXNP5Y7yXaz3cQRBOV7Wi1SccxlW/rDED1EZOgdJsMMDi2onJELpbk7Ypl3s
         WvfEsxoB0TVJLQlEIB/Zvo+Peqk7lLecEFw8lWBVDUjzJ8qfUT4JqetoP7EnEFdY9Iux
         5KGYE/jVKCDr0rzvsQsfJOdq67wPW0de1m0c4aIAHdIEtpQ8XODW+dku066e4u6m5cdP
         v4Z08EJ99kml6pihQKDNkUCHyREODyoPl9iCgim59Dy69Pktr3LS27pUkuHpgD8J7m3o
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851753; x=1699456553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka+Xo95ntz292nY8csJ3Hgsgw+UrjlMRzQhCOM/x1Z8=;
        b=rg2XRlQc6Dh1PWB6pxNYi05l4iwIHdaEJTki6ErOPcRTHRJ+0NgN5sv7Bzle65K1Zt
         ZVa8c5+EcJfe+wX4Z7jdfciWRhzS08l92CiSTABDn8nJE4fZVR549T0WXTLVuzM/kDLH
         YlR6+dkmFjYtkyydRRFbRraZRU/Ybk/CHheliaxnRPHD8Uq5clvzxVaVSbqvJUlOojHP
         +dXWjev493BWK7JHAS6yqS38YscclkiiWi9ZwSpyFZxXQh4ZgXCwF2rs/+yy0s/YD44L
         20E5jpkxHCpxMawRIN4fFH/P0qLl66Jx9ML7w0tXMO3FFKy/eGoCez7kamln4PNXKMRP
         RyhQ==
X-Gm-Message-State: AOJu0YzMnOrJuNdoY1ksj9di/qz0RtA2QrAERBI0O9kdbhDQ/Hwit8CT
        J5fp15rVnHNWKr7HQtQXMDobrA==
X-Google-Smtp-Source: AGHT+IF5VM81oYwvQ5MLi+2yCpaV4iGZi7hf18wZewZpjtXTb4AdQdd0hTRe/Ks5cWFOL83O5V3kYA==
X-Received: by 2002:a05:622a:c5:b0:418:22c2:a8ea with SMTP id p5-20020a05622a00c500b0041822c2a8eamr18228048qtw.1.1698851753449;
        Wed, 01 Nov 2023 08:15:53 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dn5-20020a05622a470500b004181a8a3e2dsm1477165qtb.41.2023.11.01.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:15:52 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add SPI support on STM32F746
Date:   Wed,  1 Nov 2023 11:08:10 -0400
Message-ID: <20231101150811.2747455-6-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
References: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for the STM32F746 SPI controllers.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 arch/arm/boot/dts/st/stm32f746.dtsi | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index cce6ab0e4617..15ad965f8d96 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -281,6 +281,26 @@ gcan3: gcan@40003600 {
 			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
 		};
 
+		spi2: spi@40003800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40003800 0x400>;
+			interrupts = <36>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(SPI2)>;
+			status = "disabled";
+		};
+
+		spi3: spi@40003c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40003c00 0x400>;
+			interrupts = <51>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(SPI3)>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
@@ -498,6 +518,26 @@ sdio1: mmc@40012c00 {
 			status = "disabled";
 		};
 
+		spi1: spi@40013000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40013000 0x400>;
+			interrupts = <35>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI1)>;
+			status = "disabled";
+		};
+
+		spi4: spi@40013400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40013400 0x400>;
+			interrupts = <84>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI4)>;
+			status = "disabled";
+		};
+
 		syscfg: syscon@40013800 {
 			compatible = "st,stm32-syscfg", "syscon";
 			reg = <0x40013800 0x400>;
@@ -562,6 +602,26 @@ pwm {
 			};
 		};
 
+		spi5: spi@40015000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40015000 0x400>;
+			interrupts = <85>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI5)>;
+			status = "disabled";
+		};
+
+		spi6: spi@40015400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40015400 0x400>;
+			interrupts = <86>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI6)>;
+			status = "disabled";
+		};
+
 		ltdc: display-controller@40016800 {
 			compatible = "st,stm32-ltdc";
 			reg = <0x40016800 0x200>;
-- 
2.42.0

