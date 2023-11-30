Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A77FF36D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjK3PUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346248AbjK3PUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181010D5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:40 -0800 (PST)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1204144440
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357639;
        bh=3BV4Vz9z3QHFiX3Dv1bjv4P8f3k40Tur0+jRMIWhjwA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=o56eawEOKUS33+zf1gpfg/Nb0+3qmEWbj31k7V4GKPb37ZblnGfcXUOt6TSbHmjdU
         91rh/pC/spn9uZDhGFn6480ZUdl46d34ERbFpIBLnOUXK0h/Rgbl8RNV3QqNuppwG7
         tV7+iIeSGsIbTVwdT2Vbizqi7mMJowMm2VCWaXgM0pDm9CiiQAFPs4iu/Byy7hZkwE
         UF+VvgyiHbI2kmEmfWxSQ+eI1IaL7OFgeRJ0Hv9jNWiog1TZb/v47/u43Ny/YgT/bw
         FsKumJkCavrVmKqpEJkINsNEMkRUZu95FgPNByNJWM7QuZJgI6C6gBDy9/qdbZeOGz
         kg1oAt5IZK4VA==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b5665e00b6so1173943b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357636; x=1701962436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BV4Vz9z3QHFiX3Dv1bjv4P8f3k40Tur0+jRMIWhjwA=;
        b=ct1MF8rkwJHcJqQsv+YNOAZpZgdTr8ah0HHkJfk7jUt1R+e9rU6R3ojYN/dR1lMVlV
         BatGl+tWgB/GD/3esyMvCx2o4MvuTjOL9e40ZcxznHBFvtfZyB3x0AxTqDU3tLIXOT6J
         7LyuLtHM7HwcQMBZ3s7+JwtFPAIn6XFYoOwQcXsX0ziJPB3lFR7ADYM2TSRRNPUmlmNz
         ZAZaU/vkR5JvXNHJuEBkeI0WwxzNd4B6iamgSNzO2Th9GylCUclHJmgRPXyVqY0tacF6
         GFgab3gV1O8XeFsd+aL7otS0WzC42mhyqsMiq4orexcwX3aloVS1P5xNupYxYiYGZ6tW
         EGZg==
X-Gm-Message-State: AOJu0YwwPEbVMYDc6DamoEOLTKj6O0vJc95jwXzzVHTAcgKmhj5cGWpn
        VQvnbm9ybaV3+49ECwVXWt10SE7gA3pZTuuy/XB2/akIsFuWkQiB6r78VtNNZBggRfWbOeLTEbY
        ymdfmK7rQqk0C9jlNlkrqSkff3jIG39eUifuqnIrTvA==
X-Received: by 2002:a05:6808:e83:b0:3b6:a7f2:f1fe with SMTP id k3-20020a0568080e8300b003b6a7f2f1femr26367626oil.47.1701357636381;
        Thu, 30 Nov 2023 07:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2rYNqi7HKvMn1CUtmkwOZKqWlU0WJNU5JfZrmmn+Bj6zgpLKPHoDP66fIgr2qToAWBfFRIA==
X-Received: by 2002:a05:6808:e83:b0:3b6:a7f2:f1fe with SMTP id k3-20020a0568080e8300b003b6a7f2f1femr26367602oil.47.1701357636165;
        Thu, 30 Nov 2023 07:20:36 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:35 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 7/8] riscv: dts: starfive: Enable SD-card on JH7100 boards
Date:   Thu, 30 Nov 2023 16:19:31 +0100
Message-Id: <20231130151932.729708-8-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl and MMC device tree nodes for the SD-card on the
BeagleV Starlight and StarFive VisionFive V1 boards.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index 3af88e6970a3..adcdbbc4f57f 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -12,6 +12,7 @@
 
 / {
 	aliases {
+		mmc0 = &sdio0;
 		serial0 = &uart3;
 	};
 
@@ -108,6 +109,43 @@ GPO_I2C2_PAD_SDA_OEN,
 		};
 	};
 
+	sdio0_pins: sdio0-0 {
+		clk-pins {
+			pinmux = <GPIOMUX(54, GPO_SDIO0_PAD_CCLK_OUT,
+				  GPO_ENABLE, GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+		sdio-pins {
+			pinmux = <GPIOMUX(55, GPO_LOW, GPO_DISABLE,
+				  GPI_SDIO0_PAD_CARD_DETECT_N)>,
+				 <GPIOMUX(53,
+				  GPO_SDIO0_PAD_CCMD_OUT,
+				  GPO_SDIO0_PAD_CCMD_OEN,
+				  GPI_SDIO0_PAD_CCMD_IN)>,
+				 <GPIOMUX(49,
+				  GPO_SDIO0_PAD_CDATA_OUT_BIT0,
+				  GPO_SDIO0_PAD_CDATA_OEN_BIT0,
+				  GPI_SDIO0_PAD_CDATA_IN_BIT0)>,
+				 <GPIOMUX(50,
+				  GPO_SDIO0_PAD_CDATA_OUT_BIT1,
+				  GPO_SDIO0_PAD_CDATA_OEN_BIT1,
+				  GPI_SDIO0_PAD_CDATA_IN_BIT1)>,
+				 <GPIOMUX(51,
+				  GPO_SDIO0_PAD_CDATA_OUT_BIT2,
+				  GPO_SDIO0_PAD_CDATA_OEN_BIT2,
+				  GPI_SDIO0_PAD_CDATA_IN_BIT2)>,
+				 <GPIOMUX(52,
+				  GPO_SDIO0_PAD_CDATA_OUT_BIT3,
+				  GPO_SDIO0_PAD_CDATA_OEN_BIT3,
+				  GPI_SDIO0_PAD_CDATA_IN_BIT3)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
 	uart3_pins: uart3-0 {
 		rx-pins {
 			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
@@ -178,6 +216,15 @@ &osc_aud {
 	clock-frequency = <27000000>;
 };
 
+&sdio0 {
+	broken-cd;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_pins>;
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
-- 
2.40.1

