Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5797A3EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbjIQWlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjIQWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B512D;
        Sun, 17 Sep 2023 15:40:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-403012f27e3so44636355e9.3;
        Sun, 17 Sep 2023 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990433; x=1695595233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzm9ZqjvlbCK0SNFX+TbEk59mYOrgBPner6DepnRFUs=;
        b=jWIKQ39oDrDUCkUhPcCAP2YKqL8LQrFWAuoPYs5oa6/WcgEklDOBebTnpL1di7pmyk
         IB2cx3qnoGhUR9+DYYSibj8n7mgvOVnjbtmbvdaQWptg8Li9k2504ESc0KHuURItErY5
         qoKCwH916xGxsL2vryMLmBeVzf6LbHrdlOMq71IVko5isXDfgpTiBFimjZQ85cnfT5dx
         0jAxRKd8OQaDqkz0bkmBe/JcVCogPInq+cMuNFDhJCTaXgb/IJ/Dnc805YpBWz8Vtu3M
         jPPb39XJ5a3UiRxuuT/qUaUPSRcejbnFLvwbwnXSMOraR3v/faQB5Io7VkxLqyYmS3Hx
         +hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990433; x=1695595233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzm9ZqjvlbCK0SNFX+TbEk59mYOrgBPner6DepnRFUs=;
        b=BMBgEmxRkNzxV45WAZM8j+jbpuoyvWPnJrqaPUu+9IYtPcQptxlKXZnrjHfqjGhFsS
         wfSddRAWiGpVznbZn4Z21AmRmz4QQqh4nLkOIigCueSWDBGqmzjhyjb7fp1ns/UIexSH
         LjYQxDVx3Gg6/5YuB2/hwkezwtKowGRM3DkNCieNzMnGPck7Q6GYvFlwp092VvTouEBb
         WjicOpaWC8/qKWbCs3Wt0KhXXTEPf6p8QbSjZV1SRfIyrBsGKFi1f40I+Y4ulqEyPYnx
         VTGXnZNys4kRbRYYojKo9336xOtE8tlmqjnkFA/hcA8AauaTqmK5RTJSq2CAzpx9wBQi
         wGYQ==
X-Gm-Message-State: AOJu0Yylus33jOgu8RlVPZqQvHhsLTCUkJ9p7Ap5RzjArm+ryGeLAt4N
        AEYoFJRRy9s7MAuvnIVoqeA=
X-Google-Smtp-Source: AGHT+IGWN1013/FPAnQNrT8Yy8PnHN/jWTSwQasqirYksiAE84RBS07CHFOeC869nuq6MRWGumVInw==
X-Received: by 2002:a5d:6f0e:0:b0:321:4c7e:45e2 with SMTP id ay14-20020a5d6f0e000000b003214c7e45e2mr1505903wrb.8.1694990432669;
        Sun, 17 Sep 2023 15:40:32 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:32 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:39:58 +0200
Subject: [PATCH 02/13] arm64: dts: imx8mp: re-parent
 IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-2-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ford <aford173@gmail.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Similar to commit 07bb2e368820 ("arm64: dts: imx8mp: Fix video clock
parents") the parent of IMX8MP_CLK_MEDIA_MIPI_PHY1_REF should be set in
the media_blk_ctrl. Currently, if mipi_dsi is not in use, its parent is
set to IMX8MP_VIDEO_PLL1_OUT, and might therefore clash with the
constraints coming from a panel.

Cc: Adam Ford <aford173@gmail.com>
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c946749a3d73..9539d747e28e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1640,11 +1640,6 @@ mipi_dsi: dsi@32e60000 {
 				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
 				clock-names = "bus_clk", "sclk_mipi";
-				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_APB>,
-						  <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
-							 <&clk IMX8MP_CLK_24M>;
-				assigned-clock-rates = <200000000>, <24000000>;
 				samsung,pll-clock-frequency = <24000000>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_DSI_1>;
@@ -1747,13 +1742,16 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
 						  <&clk IMX8MP_CLK_MEDIA_APB>,
 						  <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
 						  <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
-						  <&clk IMX8MP_VIDEO_PLL1>;
+						  <&clk IMX8MP_VIDEO_PLL1>,
+						  <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
 							 <&clk IMX8MP_VIDEO_PLL1_OUT>,
-							 <&clk IMX8MP_VIDEO_PLL1_OUT>;
+							 <&clk IMX8MP_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MP_CLK_24M>;
 				assigned-clock-rates = <500000000>, <200000000>,
-						       <0>, <0>, <1039500000>;
+						       <0>, <0>, <1039500000>,
+						       <24000000>;
 				#power-domain-cells = <1>;
 
 				lvds_bridge: bridge@5c {

-- 
2.34.1

