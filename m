Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70600805F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjLEU3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:29:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6B181;
        Tue,  5 Dec 2023 12:29:13 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d55c8ab0cso18679355ab.2;
        Tue, 05 Dec 2023 12:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701808153; x=1702412953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MBM4ZA5oNd9/yj6ChXURBgLtdL7sP8s8g23+U8L60Y=;
        b=fSKty53HK1LnDPHwi91klboedE4IsFeoF+lq+GIpAse/K6v0kax0ViXIuM+ysKGZTm
         oDNxzc2aLK5vQi2jPQXLl9XOsIvR9Zd1ba/1BvyJeDRCuP+52NkP9nUbP/f8aRuX0Cj/
         6OHZ+hQTmyddYaWdQ5zh3e0mBi18LjcXoocu4O+EatfR+EGxNv3EV6QHKXuFLemjIPXo
         /i9iL0cbY/2nbPza6M0ya20Vi8BN2NFbab8GU2dPT39+bjHoF88E6X2syg40GRoiT9eS
         pHj89wEplgpaCZQalo5uCV5ePsLXkabEyKOnixvA2uuR9fjL/tOriZSXdvaQPCpc3p8K
         JF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808153; x=1702412953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MBM4ZA5oNd9/yj6ChXURBgLtdL7sP8s8g23+U8L60Y=;
        b=rC5Qd1UI8ez9nGH3p6ce2G0+q5bfdmYw2DEkNBMoXMq7R84D5oiPZMOepoNZ1eiV+h
         Yn6FVDC/HBtP4Dma4qtMy6PISus5ufhHgyRE3KDAC/yXzwfN6j1F0LxSvHUXlCqLqLiQ
         XGjWHdTIOJ0Vt1lvQ4Kp+j2GMxF+Z1gxTyduanrR7K79uSjWxkc7Il6eNzjTLHnQab3r
         o+JsLX+nZSRlyQ1Gsnbkfuy7Xevzwwa80UdMJLUIWe8Yg9JOzw/totcDLWC1BHLReMZ/
         2rewCTnflhPJd6O/Wecv24Wsf50DdAjhIVDtRBjMevI6Nhu3UIJnuc4AKHcFdUdPAu2a
         Tn0g==
X-Gm-Message-State: AOJu0YyIIPYZbt4SLCSYsvXVwX1MuxZ8N822zRkVh1gDZjqUTB4Xtc5M
        PppJ9MJAlrhVNsf2wViIuiA=
X-Google-Smtp-Source: AGHT+IFSuXyE46UX/3konTQtWRnivgvUzbNkI7eysY6+/pVHYGf+RIpa/OB7avY+BS52+PvkyBGOcw==
X-Received: by 2002:a05:6e02:1d12:b0:35c:f2f6:7b1b with SMTP id i18-20020a056e021d1200b0035cf2f67b1bmr7324672ila.26.1701808152987;
        Tue, 05 Dec 2023 12:29:12 -0800 (PST)
Received: from celestia.nettie.lan ([2001:470:42c4:101:3fb7:1e39:b284:286f])
        by smtp.gmail.com with ESMTPSA id cw2-20020a05663849c200b004302370a169sm3296320jab.157.2023.12.05.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:29:12 -0800 (PST)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Joshua Riek <jjriek@verizon.net>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [RESEND PATCH] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
Date:   Tue,  5 Dec 2023 12:28:59 -0800
Message-ID: <20231205202900.4617-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3588 PCIe 3.0 controller seems to have unpredictable behavior when
no CLKREQ/PERST/WAKE pins are configured in the pinmux. In particular, it
will sometimes (varying between specific RK3588 chips, not over time) shut
off the DBI block, and reads to this range will instead stall
indefinitely.

When this happens, it will prevent Linux from booting altogether. The
PCIe driver will stall the CPU core once it attempts to read the version
information from the DBI range.

Fix this boot hang by adding the correct pinctrl configuration to the
PCIe 3.0 device node, which is the proper thing to do anyway. While
we're at it, also add the necessary configuration to the PCIe 2.0 node,
which may or may not fix the equivalent problem over there -- but is the
proper thing to do anyway. :)

Fixes: 2806a69f3fef6 ("arm64: dts: rockchip: Add Turing RK1 SoM support")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 9570b34aca2e..129f14dbd42f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -214,7 +214,7 @@ rgmii_phy: ethernet-phy@1 {
 &pcie2x1l1 {
 	linux,pci-domain = <1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_reset>;
+	pinctrl-0 = <&pcie30x1m1_pins>;
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -226,7 +226,7 @@ &pcie30phy {
 &pcie3x4 {
 	linux,pci-domain = <0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_reset>;
+	pinctrl-0 = <&pcie30x4m1_pins>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
@@ -245,17 +245,7 @@ hym8563_int: hym8563-int {
 		};
 	};
 
-	pcie2 {
-		pcie2_reset: pcie2-reset {
-			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	pcie3 {
-		pcie3_reset: pcie3-reset {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
 		vcc3v3_pcie30_en: pcie3-reg {
 			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.41.0

