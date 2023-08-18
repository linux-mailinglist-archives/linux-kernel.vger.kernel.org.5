Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C23F780EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378028AbjHRPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378003AbjHRPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:48 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD13E5F;
        Fri, 18 Aug 2023 08:10:47 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64bd231c95cso3109046d6.1;
        Fri, 18 Aug 2023 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371446; x=1692976246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmdkJVdFz/V7Zt8mJfhJXtTYea+Vk2ji53hyZ/nqh5o=;
        b=hALjcEibEzL67Tcf52GlQv2Hq/WsZmtG4agXpQye2HtAU32pd9aTvA5EIUsVG1u0RI
         08BtLAvkIpssONbFQywm7DFW0nSKZ/S9sMWBAhi4HgpO38It2r9vDKPdy0lDAD2SVIY8
         1pYPOPvrxG8x3aJT+WWXPBrW7KM2xn3JuWJNapLgF8sD8o5roYSKokrojJ4qbNARn6UM
         aFofgcHGNFPVUAV1rMZJVNwyuxrOweqgpyi3fZ9fRtoOb7JH1tX2n3/WfGILToV7owyP
         gxS7o/Ky4WUzeiMjPy+voNxUIhRekrfRy5pyeEQwC7bfsKWEYFg56VHNtUS6QsBRBMmS
         wv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371446; x=1692976246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmdkJVdFz/V7Zt8mJfhJXtTYea+Vk2ji53hyZ/nqh5o=;
        b=eY/vMnaK8nR5UFCXctboPxM5rXjJ98jLLiTAeX6QBpnIKdUTZZOzU7mFKYFqEnHLeB
         GAF2F3dG+GEvLSLbvCBa7j5ZPu7Guu+SXZ3H8uljLz0knkqorPGu1d8ONvarlnl67iEl
         cylgVvuv/c7d/Evlhnv1zlV8Na45m0rLkpKo7zlbdVZM7ybwlNUwwej13bFVuz9vrTrN
         vwPaA0qbJPU6ykCENyKQ+tttcgip+o2mKAjYR28J8aT7KihdQMoOYK5W/CkKMQe4FwYG
         +BXirICNgZMarpOI5zKrWefU1h6PHUCDOTsKbD2E1QrXa6wz4J1kI4QycVTvHg4zvb8V
         u2Cw==
X-Gm-Message-State: AOJu0YycbykVEmQPVLGBE1xskUezNe1ZtnFn6Bw+E8SXxZzUUSSqCd15
        rTHWkYTwKD3AShOzXkDh8qumOAam6QI=
X-Google-Smtp-Source: AGHT+IE4yMrt5Kl+NhaD3Iv4mwd47UAYLucL8KO15YQx3vciuRoQnbAbUzfpuYPhpHOEcTyQb4c5sg==
X-Received: by 2002:a05:6214:2d0f:b0:649:914:6495 with SMTP id mz15-20020a0562142d0f00b0064909146495mr2914231qvb.62.1692371446581;
        Fri, 18 Aug 2023 08:10:46 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0076cbcf8ad3bsm576239qkj.55.2023.08.18.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:10:45 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: am335x-pocketbeagle: update LED information
Date:   Fri, 18 Aug 2023 11:10:34 -0400
Message-ID: <20230818151039.40566-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230818151039.40566-1-twoerner@gmail.com>
References: <20230818151039.40566-1-twoerner@gmail.com>
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

The "label" property is deprecated. Replace the "label" property with
"color" and "description" properties.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 5dfe4d4bab93..1c11245f6864 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -8,6 +8,7 @@
 
 #include "am33xx.dtsi"
 #include "am335x-osd335x-common.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "TI AM335x PocketBeagle";
@@ -24,28 +25,32 @@ leds {
 		compatible = "gpio-leds";
 
 		led-usr0 {
-			label = "beaglebone:green:usr0";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		led-usr1 {
-			label = "beaglebone:green:usr1";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		led-usr2 {
-			label = "beaglebone:green:usr2";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_CPU;
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
 
 		led-usr3 {
-			label = "beaglebone:green:usr3";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-- 
2.41.0.327.gaa9166bcc0ba

