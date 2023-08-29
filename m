Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472A378CEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjH2VnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbjH2Vmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:42:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1C107;
        Tue, 29 Aug 2023 14:42:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so6309312a12.1;
        Tue, 29 Aug 2023 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693345355; x=1693950155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGClNaEY6gM70Hb3navvOJbzGEwQs35GRI7P9s7Oey0=;
        b=W+CKLTzCe63bSk4PCJqyMCR53BAc7TTDN8bj1rvKWsl0Qyz2E4+etSisQxEVEaKg9U
         jCTCqGilQBzOazQ3TxZwWp69mtV+gCOQYnaOOAzMASsSGRYTXB3NpYFn74azUhM8x5Fe
         VXupuc9/sWPWT87U72Qoa/C0anJ6YcRPBBBRv9gET8V0pgqGczWJ6x8eHN0HM3eOzW3/
         ikaP2NcAcQ5ykBTQzaEn7AgFXUHQ2RZxO6kFqrZCJHPIELvu1N3zavDs04Dvl3jNQAw4
         emEgZ9D9529omIOtCyTdz5ob9Ph2P8mz4qTKi5v5wX2YP/IHHw14PfrNQDBAy0HSQ1Lo
         4xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693345355; x=1693950155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGClNaEY6gM70Hb3navvOJbzGEwQs35GRI7P9s7Oey0=;
        b=MP3u5USM+rnfyJjVmDI5w3XoVrYUNmES/N7vTik8wJUPXZ62mACTXm9gA8MgMwgogO
         vZ9mXFiRcdeYwaMAfhce6b2SWqmyHUrIkWh0tmOUQEVT+uqAWXS6JwdHmnqGwEJdQQH6
         fR41DedkLUf4ZWVLyCGLLaw47bCoTu9IVxYhf0BlNQuzWlD2qDC7kPsyuuzx4wIMcMl7
         35bC8rPBoXgHjyNDqNRihNBbyhYZpifNc9wUON/qobiiByDDf6F2WR+SLctg8DOfmOly
         KOpu65MGRcL+YfxWjQF4Kf2eh9OdzTTSO2v4jbz6LBfeJti2gsEeAbRPfzebECBMlXql
         IJ1w==
X-Gm-Message-State: AOJu0YzVG4EPHkkde/Xw5BIrLrEm/XA3C7RAdVgxLLo4lGOfd0NX8tDO
        9Mlv3x6Sp+7SVdSZrXzMZQ==
X-Google-Smtp-Source: AGHT+IGYuYw4UxD9N/zmzw+MRRW1M3ZFSNH98nsfl52O8isc+O7p9i4jDC25sDDeyeXvvlawKRa1OA==
X-Received: by 2002:aa7:c644:0:b0:52a:841:bc58 with SMTP id z4-20020aa7c644000000b0052a0841bc58mr377767edr.30.1693345355292;
        Tue, 29 Aug 2023 14:42:35 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:84d2:f616:9527:dd98])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm6113428eds.77.2023.08.29.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:42:35 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Switch to operating-points-v2 for RK3128's CPU
Date:   Tue, 29 Aug 2023 23:40:09 +0200
Message-ID: <20230829214004.314932-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829214004.314932-2-knaerzche@gmail.com>
References: <20230829214004.314932-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow frequency-scaling for the cpu-cores.
Operating frequencies and voltages have been taken from Rockchip's
downstream kernel.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 43 +++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 877854dd765d..71964262cd5f 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -36,10 +36,7 @@ cpu0: cpu@f00 {
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			resets = <&cru SRST_CORE0>;
-			operating-points = <
-				/* KHz    uV */
-				 816000 1000000
-			>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -48,6 +45,7 @@ cpu1: cpu@f01 {
 			compatible = "arm,cortex-a7";
 			reg = <0xf01>;
 			resets = <&cru SRST_CORE1>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		cpu2: cpu@f02 {
@@ -55,6 +53,7 @@ cpu2: cpu@f02 {
 			compatible = "arm,cortex-a7";
 			reg = <0xf02>;
 			resets = <&cru SRST_CORE2>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		cpu3: cpu@f03 {
@@ -62,6 +61,42 @@ cpu3: cpu@f03 {
 			compatible = "arm,cortex-a7";
 			reg = <0xf03>;
 			resets = <&cru SRST_CORE3>;
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+	};
+
+	cpu_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <950000 950000 1325000>;
+		};
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <950000 950000 1325000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <950000 950000 1325000>;
+		};
+		opp-696000000 {
+			opp-hz = /bits/ 64 <696000000>;
+			opp-microvolt = <975000 975000 1325000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1075000 1075000 1325000>;
+			opp-suspend;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1200000 1200000 1325000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1325000 1325000 1325000>;
 		};
 	};
 
-- 
2.42.0

