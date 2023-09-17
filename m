Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD17A3EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbjIQWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjIQWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D312B;
        Sun, 17 Sep 2023 15:40:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40472f9db24so38546675e9.2;
        Sun, 17 Sep 2023 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990443; x=1695595243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q73v8D96q+uYzZz3PWeYupivBABq+k9drLmqWm/npWw=;
        b=XPdwnmPX7Uo7XL0MbzYRHJBLD3Qw1RopjLmq1dHP420FJsWcPnZhdz6HzDovzG4q7D
         jNqqR1Yu0OYo6njNu5hoW2O1jS6tvX+G15gBPt2LiM9CwOtSKrymr03w9R1+mELWjtWL
         ZHASdkxqnU7eBMtCEy04e2vkKq1WkcsNsMDxiB6CEglVw7jkp+bMZVUlDztKRvYd66th
         3cHPWcXPJWIYeeSj88mw+tsFXjKRDhyGwZGaCTzspmxK6q7q4BJTLdt1JAgp4mamg8DM
         q7JGxATn5DCBfSGHM34b72Vg1IivD6AyKL/GPgxw2AEiAOotWSYTfNwpKEUrlvBUS7kl
         lfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990443; x=1695595243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q73v8D96q+uYzZz3PWeYupivBABq+k9drLmqWm/npWw=;
        b=h2ZcKw13tugWoXulXCBIbN1+E2BSd5cVc6XI8uvWxrf4u3yXI6gezkv2J1fv8WWAbx
         5SDcHj92wf1vnUOJGVNgQ8kqpj6IVdCwDcjQGo15i64vc5yDg+BpQnkreXS60/TkudB4
         PCtXSFmvuKMSN7NXQ+dD2RdGpYIJBVJiUvAxlX+mcZoXNCzcZdN8Anl6Q5k92GH/B11H
         vTyP1yZqMFNFdWMG/EWxXjrbmZ9XGYEku2mPiARyFsOskluwGZmYBGJuWdOQ/0O5nOF4
         YPVp4S3Lq/XwDdyGK2yjES3Jc9yShVD+eAVKcI9Plin5pfcGj1GxauKZNeXITA2cRgnI
         XKQw==
X-Gm-Message-State: AOJu0YwEhkbUj4rBs0pHcRwHmJQK86otKeGESt6yd5L3MmiLtJGz9JLg
        kQwVvgw+6pYOP7Awj/SAEYA=
X-Google-Smtp-Source: AGHT+IEpn3SKMcUCwDs+OcB12/E+cy0JKanTR9ByM5/NTtb05D1WNb8Mw67ZleN3ZGoklRFRYUBneQ==
X-Received: by 2002:a7b:cd9a:0:b0:401:73b2:f039 with SMTP id y26-20020a7bcd9a000000b0040173b2f039mr5934394wmj.7.1694990442771;
        Sun, 17 Sep 2023 15:40:42 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:42 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:09 +0200
Subject: [PATCH 13/13] arm64: dts: imx8mp: remove assigned-clock-rate of
 IMX8MP_VIDEO_PLL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-13-1d008b3237c0@skidata.com>
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
        Lucas Stach <l.stach@pengutronix.de>
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

Similar to commit 16c984524862 ("arm64: dts: imx8mp: don't initialize
audio clocks from CCM node").

With commit b09c68dc57c9 ("clk: imx: pll14xx: Support dynamic rates") in
place, the clock consumer (e.g. a panel) is able to set a more suitable
rate for the IMX8MP_VIDEO_PLL1. As composite-8m is now able to propagate
the rate through, avoid setting a rate in the dtsi.

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9539d747e28e..f40b40ee8f9e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1742,7 +1742,6 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
 						  <&clk IMX8MP_CLK_MEDIA_APB>,
 						  <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
 						  <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
-						  <&clk IMX8MP_VIDEO_PLL1>,
 						  <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
@@ -1750,8 +1749,7 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
 							 <&clk IMX8MP_VIDEO_PLL1_OUT>,
 							 <&clk IMX8MP_CLK_24M>;
 				assigned-clock-rates = <500000000>, <200000000>,
-						       <0>, <0>, <1039500000>,
-						       <24000000>;
+						       <0>, <0>, <24000000>;
 				#power-domain-cells = <1>;
 
 				lvds_bridge: bridge@5c {

-- 
2.34.1

