Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B69801CAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjLBMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjLBMmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:42:04 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D312E;
        Sat,  2 Dec 2023 04:42:09 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1a22b7f519so197944866b.2;
        Sat, 02 Dec 2023 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701520928; x=1702125728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp5m4S58xFYf/pPupXKRpoAWOKmXYjV8KokdiBbVmdU=;
        b=crWVOoSYBTQ3ncE0rILuyNQWTTbwIGHuzhfrsnpewN96rxMxM0ZwbK/6oPTzzyfW/g
         s/4KCAKQFGLT+dhc07wPqu7NIngV7EfRNoCHvqMu1kUX04tiZxw8QlkzT8VKij9OOKDR
         gWd0jaC0IgeUISU+8nktatVdZDXihJwmgw6XY0zSZoLmuJq+ftpJ3r+WYyiW5rTz7DFR
         XW0xdj1oZ8Er9E5vL8jijIFTLEJel+5PyvctxrDCLSeKzqnn8YB7b5wDrGUoRrQyvVv8
         bpEDrB9lp4Ln8DrC8JwmoqEK5G9DxE+4aKWfWGL5TjZRSvNV3BH1BPt7FiloDIHDLqzS
         lkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701520928; x=1702125728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp5m4S58xFYf/pPupXKRpoAWOKmXYjV8KokdiBbVmdU=;
        b=qrgu1cHbLwp7oH3AQ2JeRiet9qm5hh/lWGfGD29/OL6yKhGvqXLZV8pgqfo3mNXekG
         NSdBXFouc5GpRQLaJfssLyLh/eMqoiQh0og2cFb6Tl37mdF1Lv3k8kh8GSRfLEsOdz5F
         QeBXSeN9Ci7K4CG/gB1Uaw8OwikluwQfzK0rDTb+0GCb5fn7c1blb5yaVeiUPH3Miv0Y
         xgLezHvjjkqdLHyooeh3KJZDgNeYHHTYU1IeC2T7WuFgMEX6Q8ACWLnNyAh+AFnyax53
         ILyegJKSBdLuRt2P0qd76+VrVOaR9Q/W0HSV8om0WgCc0wF3l2TKDm6wfdy7vb34WCyg
         f8Wg==
X-Gm-Message-State: AOJu0YyjkVhLjKL0H9Wl/rwkrwpITu+2B6LpNEL1QVxldtU6Dv0CqyBZ
        dbfBPyKZL27BQ/CQm97kqg==
X-Google-Smtp-Source: AGHT+IFCBdPcJSe8T9O23Y89jCIHxaJaMUXndtVnA4rBtUOnvJCImr6VCsKo/XMoFtC8T+88bYhlPQ==
X-Received: by 2002:a17:906:51d0:b0:a19:a1ba:baba with SMTP id v16-20020a17090651d000b00a19a1bababamr1018772ejk.96.1701520928353;
        Sat, 02 Dec 2023 04:42:08 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id q19-20020a1709060e5300b009a19701e7b5sm3009602eji.96.2023.12.02.04.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:42:08 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Enable gmac for XPI-3128
Date:   Sat,  2 Dec 2023 13:41:59 +0100
Message-ID: <20231202124158.65615-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202124158.65615-2-knaerzche@gmail.com>
References: <20231202124158.65615-2-knaerzche@gmail.com>
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

Add the required properties and enable the gmac node for XPI-3128 board.

The minimum reset timing requirements for the phy have been taken from
DP83848J's datasheet [0]

[0] https://www.ti.com/lit/ds/symlink/dp83848j.pdf

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index 61b9f069c8a2..e979425f11a0 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -11,6 +11,7 @@ / {
 	compatible = "geniatech,xpi-3128", "rockchip,rk3128";
 
 	aliases {
+		ethernet0 = &gmac;
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
@@ -255,6 +256,18 @@ &emmc {
 	status = "okay";
 };
 
+&gmac {
+	clock_in_out = "output";
+	phy-supply = <&vcc_lan>;
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
+	assigned-clocks = <&cru SCLK_MAC_SRC>;
+	assigned-clock-rates= <50000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rmii_pins>;
+	status = "okay";
+};
+
 &gpio0 {
 	gpio-line-names = /* GPIO0 A0-A7 */
 			  "", "", "HEADER_5", "HEADER_3",
@@ -315,6 +328,21 @@ &gpio3 {
 			  "", "", "", "";
 };
 
+&mdio {
+	phy0: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		max-speed = <100>;
+		/* T2.2.4 min. 1 us */
+		reset-assert-us = <10>;
+		/* T2.2.1 + T2.2.2 + T2.2.3 min. 6.05 us */
+		reset-deassert-us = <20>;
+		reset-gpios = <&gpio2 RK_PD0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp83848c_rst>;
+	};
+};
+
 &pinctrl {
 	dp83848c {
 		dp83848c_rst: dp83848c-rst {
-- 
2.43.0

