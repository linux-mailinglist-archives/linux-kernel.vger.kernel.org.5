Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC89D79B57D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjIKUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbjIKOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:10:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83767CF0;
        Mon, 11 Sep 2023 07:10:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573f722b86eso3127515a12.1;
        Mon, 11 Sep 2023 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694441413; x=1695046213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG+QQTyt98Cm72ivgjgEOlvbZ6Se1TfTAJhHJ/imZoc=;
        b=QdMpOpjmvM8Ri7saBQQGuiqKEEqIsgBnzwkLyTaOZHwDVOUXOnAFIwwCSetC3FxeTQ
         hN/8jFNqKehs1tu7w0R0AOsR+mc/TbvryfxZk6nIRy5kjI+ttja0EGP26ALaAn1JDYAM
         A4LTdSh/yofH/Hj4kUnfgcWL3NdxTvTG8EByHaVHNc4oO3PcHvkMeyEIsMntOYVwgGTQ
         vuHGAOz89pFp5VwpPXO6p//jV7LC4rGSqX0bYehfWoYa5yKsYTlaXtKfjWPoc6ugJugC
         adHyzZmPntDTpzFNPG/wY+hlgu6jobWdrPt7K6xNuhSKnrvS1NMChq1gXlO36rZAp+OU
         fqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694441413; x=1695046213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG+QQTyt98Cm72ivgjgEOlvbZ6Se1TfTAJhHJ/imZoc=;
        b=grVf+beWtNMbdwPBp/IYG+6Eg8jK4tMH6Jgy3nRb1iUzZ7IyV1IwKbXS2iHbBtbf7o
         MblkWiqYmbE7sXqRvzIFpkbBiXXvXrKUoqcVAaPfu+EMyQlGbqzThmxRhfHGdBztrdGP
         vqRoGpuq8xy0mP3e+cyBmwY8Ui8JQoqNgeQGz0BC0k74wQJyAhp7YhuD6BMfv+Z2Eamj
         gwu0UVrLtGNNPR85pzJFOibG17wcyWcu5D5MjzbyT/NOgBgOVZq2c2bfleNbhM9/4rKp
         /XKwhWOuZPIiC21lgi731VpP3FI2KAF9wOFseSo5ijjtN7I3m5rs113rzkZscYTgJLBJ
         J2Yg==
X-Gm-Message-State: AOJu0Yz3ls9KkWNIyETAq/w+OsrjIbDYXcSzpnnfZ5TaNq436ZUR8J25
        S6ri7/HLB8hnSdY2QJr13ZM=
X-Google-Smtp-Source: AGHT+IFT4CEbs6SG9WihA55ZqVVaa3LXFeCN3WNFsIoBVr7gxXea0G3VaJfy+znmNvPWvXDNljjNPQ==
X-Received: by 2002:a17:90a:ff11:b0:263:f435:ef2d with SMTP id ce17-20020a17090aff1100b00263f435ef2dmr7794285pjb.10.1694441412732;
        Mon, 11 Sep 2023 07:10:12 -0700 (PDT)
Received: from LT05.. ([165.173.5.104])
        by smtp.gmail.com with ESMTPSA id mj11-20020a17090b368b00b0026fb228fafasm7509866pjb.18.2023.09.11.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:10:11 -0700 (PDT)
From:   longqi <longqi90@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     longqi <longqi90@gmail.com>
Subject: [PATCH] fixes the pin settings of two LEDs on board nanopi neo plus2
Date:   Mon, 11 Sep 2023 22:09:59 +0800
Message-Id: <20230911140959.2046340-1-longqi90@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: longqi <longqi90@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 4c3921ac236c..0cb7a07ab1de 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -26,14 +26,15 @@ leds {
 		compatible = "gpio-leds";
 
 		led-0 {
-			label = "nanopi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
+			label = "nanopi:red:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+			linux,default-trigger = "default-on";
 		};
 
 		led-1 {
-			label = "nanopi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			label = "nanopi:green:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
+			linux,default-trigger = "heartbeat";
 		};
 	};
 
-- 
2.34.1

