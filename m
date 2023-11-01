Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441A57DE433
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjKAPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:53:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D6DA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:53:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e22a4004so4663185b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698854004; x=1699458804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5ijsHSrTzTaxlFkHmCRGPyrWJzfsbcZIn4Auv8liUM=;
        b=AEbphMcc/1kYwbvUcuW8HXmZSehJcQhyetl3rYWPoZeenKBTjA4O7tc8TboZh70fMj
         tMA4fJtqHXXNd5gqLD3iZmM7Got6bI/DiIPZS+JCybTYDwPWYwa73cX16nl/N1uaLqTc
         mWODMBjByf6HwEVh9tqwmNQFUikpqsivG7bDr4EZ0/GErpvrs5djzAdj5JAU4XuCmqpM
         gAI+8l0ImJIDL4Zr38uSO2MgoST4t5V5M3LWfjTqWtH+gNlPn42an8rDP0oPVa4UD1UL
         KkgLSsaOsgVziuBlhw3sFdh78WZkHdFIIcSDuOjhmwjNoRaKU9Mwfo4EhEWHJNLRy1uI
         fQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698854004; x=1699458804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5ijsHSrTzTaxlFkHmCRGPyrWJzfsbcZIn4Auv8liUM=;
        b=xOrjIUCiwxHBgi5eDJrie2VdpSl9P2B4D64R21x9LbRr5Hx6Ucz+dpKY/9JtpxOWvb
         os6LAvVQ2IfVuzkejA6STyIfG7orFv2w0DPNWM/gF/YNcVQ7i8YG9co5gQA1wgxZ30w+
         VKZiA5tUtkSbIe441Wgtnm5bxbXc2GCCuIyp6G0JHPLE2CqGq9WlWWfsOvaSxgIICPTJ
         meFGv8Rii7kkzDQR3BdLOsqOr08zNm9wqdsbYmJevLJttpfi8lR5XYGKb9DgV2YoZG20
         2lOZxDnTIQWjv/aiMJkkJ27ZEulVbqtAkqjlr4o5dw/xCdcsb21uubcN+dKYSwUotUDa
         o9Ug==
X-Gm-Message-State: AOJu0YxP3RzBGFkVM40oolvKJHIDMeVas7ZDLyZSMKBLuKmb0H4rOpCu
        UqCghlgXyR3MIuT+zu9yKpXrSMWfgC8HAkQU3yo=
X-Google-Smtp-Source: AGHT+IHmmkiKXyy1l5dnqihVt3MujYnYJ9NEfXdzQwBgQiBgEoWkDDo9dz27bVWORqna0JEi7yol+Q==
X-Received: by 2002:a05:6808:698:b0:3a1:b28f:814c with SMTP id k24-20020a056808069800b003a1b28f814cmr17366198oig.1.1698854003784;
        Wed, 01 Nov 2023 08:53:23 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id q12-20020a05620a0c8c00b00775ab978009sm1549551qki.36.2023.11.01.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:53:23 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] ARM: dts: stm32: add STM32F746 syscfg clock
Date:   Wed,  1 Nov 2023 11:51:54 -0400
Message-ID: <20231101155153.2767482-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscfg syscon was missing its clock, therefore any attempt to
read/write it after clk_disable_unused() silently failed. This was
preventing external pin interrupts from working if they were initialized
after this point.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 arch/arm/boot/dts/st/stm32f746.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index 4942753d011e..cce6ab0e4617 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -501,6 +501,7 @@ sdio1: mmc@40012c00 {
 		syscfg: syscon@40013800 {
 			compatible = "st,stm32-syscfg", "syscon";
 			reg = <0x40013800 0x400>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SYSCFG)>;
 		};
 
 		exti: interrupt-controller@40013c00 {
-- 
2.42.0

