Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D0801CDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjLBNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjLBNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:05:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883BB11D;
        Sat,  2 Dec 2023 05:05:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1a2615e909so207105866b.3;
        Sat, 02 Dec 2023 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701522318; x=1702127118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adSEYqN8FGT+ykmMCmzGxY6EhaQvEvBv0NcW+fx7a08=;
        b=eaoV3+erqP0DuXtfJ+cBOitCErT8AF4ouCGzaAUnEYSk1/842VnTWz/HEFs7cIR3e4
         AsDNizfAetALQCx8TkuBWuUwSXeeHZZc7RoMerncCdTDhbAtuVL28J+S50lxa6IyRY6c
         an3m6IMen1zofjgHgwOU1/gKrW/lB+8yQvVhbdbeEAEgEZn8p9M9zDi2YMGyaPMkP96d
         U/oGmlsEqcmYmMb8Mxz5Yr2YYlFTAOZagwYOJScqWlYT9TAj3MoYyeyMpXQbXYwMjXa1
         StGS5Ugp5M24mHHxMHBr9bYl7Z0gruclzUhHHEIUq+qt01GSu3+TDDYh0ZrZGpGfGfzX
         vpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701522318; x=1702127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adSEYqN8FGT+ykmMCmzGxY6EhaQvEvBv0NcW+fx7a08=;
        b=cE3x0u5bALL7EmsCf41LMg3uxgtP99/TD12mlzeptrIwMaeeddpEL04pIeR8OTIL/Q
         cAJErUtUrTxhHXBlNABv3Z5DcGAEZa5xaKoCmjHIPWMrGxnMJZsAXStEFaJnGMDlVHCg
         aAUK2x9UMWuyk9bzNyf9LUVr/hNzUIrCUuiyKZCj8OcUwDzsuwsuJwx3GvP8vbt++t9a
         pB+oqM9W0i/2As8k5pz+ZhAMqDIVq1YkiZFYWDv+j1k+rOoEYHpt2EOJlLsIWb+VN5AT
         bn6xMAgvYaiaqi8rkHeIo/W5A6C9ir9LY0Gg0d1oEN1doNHRhERvDwica6w1sIW8T7qr
         SWWg==
X-Gm-Message-State: AOJu0YzVY7Kl/hA1u6oMqQQYVOwzg9WwdOjWUKQfgKAeQLAlkiXpGIK3
        bauqTCZqTxkEPftXozKDGWjCwuptbQ==
X-Google-Smtp-Source: AGHT+IHHKc1ev66uYDB6740dr47fDqVGRCOAVGOBwZCTvCIbkuLo5yoSsdkiAEidwCwLC9bdgrsyPw==
X-Received: by 2002:a17:906:3f5a:b0:a19:a19b:4236 with SMTP id f26-20020a1709063f5a00b00a19a19b4236mr1174545ejj.161.1701522318035;
        Sat, 02 Dec 2023 05:05:18 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id bs5-20020a170906d1c500b00a0bf09c9483sm3045324ejb.35.2023.12.02.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 05:05:17 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/3] ARM: dts: rockchip: Move gpio aliases to SoC dtsi for RK3128
Date:   Sat,  2 Dec 2023 14:05:05 +0100
Message-ID: <20231202130506.66738-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202130506.66738-2-knaerzche@gmail.com>
References: <20231202130506.66738-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC TRM, SoC datasheet and board schematics always refer to the
same gpio numbers - even if not all are used for a specific board.
In order to not have to re-define them for every board move the
aliases to SoC dtsi for RK3128 like it's being done for most other
Rockchip ARM SoCs.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128-evb.dts      | 4 ----
 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 4 ----
 arch/arm/boot/dts/rockchip/rk3128.dtsi         | 7 +++++++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-evb.dts b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
index c38f42497cbd..776a483cc26b 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
@@ -12,10 +12,6 @@ / {
 	compatible = "rockchip,rk3128-evb", "rockchip,rk3128";
 
 	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
 		i2c1 = &i2c1;
 		mmc0 = &emmc;
 	};
diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index 61b9f069c8a2..b448e2b96e08 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -11,10 +11,6 @@ / {
 	compatible = "geniatech,xpi-3128", "rockchip,rk3128";
 
 	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
 		mmc0 = &emmc;
 		mmc1 = &sdmmc;
 		serial0 = &uart1;
diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 4e8b38604ecd..5b751284d6ca 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -15,6 +15,13 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+	};
+
 	arm-pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0

