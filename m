Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9678CAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbjH2RSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjH2RSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F46CF1;
        Tue, 29 Aug 2023 10:17:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so612301566b.2;
        Tue, 29 Aug 2023 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329461; x=1693934261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilnrPdFJtUf7kFovTN/fYGCIN4J3UZgI+cSnZSR/2yQ=;
        b=CojAhc332OPw8G4b1MSX2JQIfQDCWoVAGTFpYoYl0/vT085fGy4ePtubR/tl/ZlsIA
         l0uDDPewODZRXUPwQabgplzdC4JNc4myOQVV6TKtNZzHR/zTCdmDxbWrYTQ913Ug93dE
         Ljr8rF4aJIPgyle1ezaRXAKcCZkTsru1CJ6/LLnQPkaX9LMtCAx5R9bEMXBX7q51ItgT
         0PKjUs7ecYytckB82/OClp4+JYvRuR7KQWln7xSZiha8hHm+Z6Wsm4jgAPRIziHgSxMb
         QrTk4sU11HDveeQ1zL7bqYeR/6WYcSm4kFKKf6s8v0QQbLee2Jbv0SA/0k8j+1waMlo6
         r0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329461; x=1693934261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilnrPdFJtUf7kFovTN/fYGCIN4J3UZgI+cSnZSR/2yQ=;
        b=XmFj2unGwRBYu2ZxrSqSCUOu8qkvXNz5cxOG/KNfdqQSJdqsjK3uj0WVKgbZaL5M+D
         SaCdfPJPIf+YQwWIHTiIS/g9rZp7E9gPU6KQcjeFwv4OsBxLuCtX0VGE4YLGPvynDC9g
         qsqP9QvbPk3kRoOIiK2mF5EDFpRFpq4+y8Oq4vLQaki25T9xwzNRKeUGh6X2tIncKE4K
         UYgsylsRHu0RuUwJP57pXM3muKTVqMSUdEE3XwdG6k+ierbcrzqzlyEy0UEWn/UtMmU7
         lddasKFQ/9GqDqEWnLDwAepAtGGyqkNFn518HJjAN7ZbjwPGDDSdNYSXWaoSVkqUcxdY
         rrXg==
X-Gm-Message-State: AOJu0Yz5ACJU00fAtUXhNbw4st2mcWMdnOp7DtzKMIeaYOxFmrhPaVmV
        LvDELnod0Xo8plomwvhNQg==
X-Google-Smtp-Source: AGHT+IFOS5fuKXmCLh8kzU0y1GLYjtXxy7bOhVtFki5w2Fgr+bDQyC2qYgPIiQH2f3gYvZC+LV/EnQ==
X-Received: by 2002:a17:906:3d29:b0:99d:f29b:f2e4 with SMTP id l9-20020a1709063d2900b0099df29bf2e4mr21968075ejf.29.1693329461237;
        Tue, 29 Aug 2023 10:17:41 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:40 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 17/31] ARM: dts: rockchip: Add CPU resets for RK312x
Date:   Tue, 29 Aug 2023 19:16:33 +0200
Message-ID: <20230829171647.187787-18-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset controls for all 4 cpu cores.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index 7aba97b2c990..b195ac525c37 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -34,6 +34,7 @@ cpu0: cpu@f00 {
 			reg = <0xf00>;
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
+			resets = <&cru SRST_CORE0>;
 			operating-points = <
 				/* KHz    uV */
 				 816000 1000000
@@ -45,18 +46,21 @@ cpu1: cpu@f01 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf01>;
+			resets = <&cru SRST_CORE1>;
 		};
 
 		cpu2: cpu@f02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf02>;
+			resets = <&cru SRST_CORE2>;
 		};
 
 		cpu3: cpu@f03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf03>;
+			resets = <&cru SRST_CORE3>;
 		};
 	};
 
-- 
2.42.0

