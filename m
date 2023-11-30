Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42C7FF371
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbjK3PUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346292AbjK3PUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF510EA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:48 -0800 (PST)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D29340C50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357644;
        bh=Hegf0srFkbsTjzBuIfrKZwGyBpbOFAxXtDxYBC/BJOY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Kaul0nEDY9wrTIMaTztWeKgS+89ygJVSiRsmrefksU8nUguLXzpAflqdpvyRMecG1
         YV99372DkzAIlSdLdWjh9PzdkKGoWZDRXRpLKsvr47/91Rqo7jKxANPbAv2xoY5nS5
         MxkOe86Gpii47WcidrHZWIDvZh7jdvCiTP/DteirxJ8nYkl3cH0+m9Rjxad3wHGnX7
         TPCpSUogy/YjMyPwZQ948iUv3Zx06CDxwiWAIphbp7opfiqEx0KYuhP0Tzfx+lU6nM
         0/GQskSVT954vDYw1rnr/dqZZU3YIIotRfd1YUuNh5o4zg74X8H6ATnoio7bPLLWJR
         s6eAqwxFPEohg==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b85fd1bdecso1280007b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357643; x=1701962443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hegf0srFkbsTjzBuIfrKZwGyBpbOFAxXtDxYBC/BJOY=;
        b=Qs/sVEQm4oTLyKRvsD5p7wb0DEKPM121z4SFJzLjAHbzFt01jzGiT9Zplwzqai4nUh
         fx3WOJGgGkhy6OmvHhosh60tPPqYjwZZ8f+UpFDG/fa3kfbzKLj7k6jQ4C98OD/BGBcr
         1n8G7+6+S8NwUNzZTMqGd6nohvcWUn4es7mw57Ie0XOv4BNcyI6T0YMMK5SWEplfOB/D
         udKtoEFhdhkGpInZAYDLQApYCLTENmaCM7ydPZIGU94pwcfXJvqXG5ljwast/15kavSB
         lKDBMklt/vvMKrVEmMfIRjeS2uV9SnVEQxNTzyMAgG/aZtv0p2p/ME6iVp+GJ+bN2Dyx
         oCCw==
X-Gm-Message-State: AOJu0YweCBPhZEsllHg2jn+z0dzmywlCJjQmpYmkj44lS2+Xs0j+XwiG
        WvZKQiYhv9muv3kXzUBuAKwpCjQqxEgvOVZwG5tph4XAcG5yuwJQyyYuFBio/FqI7KipdEDkOfS
        Lxx4dFuMnsDRdD8Lnrk2/hWTyMe99q+QdixqCtDtQuw==
X-Received: by 2002:a05:6808:20a0:b0:3b2:ee79:c0fd with SMTP id s32-20020a05680820a000b003b2ee79c0fdmr31848207oiw.1.1701357643557;
        Thu, 30 Nov 2023 07:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDv33VjZX5rToz283+PZ9me+zUyLCvtTvnVucpd5Vw8rGLY3r7NPHXqlLul8V0jCsywTS1sQ==
X-Received: by 2002:a05:6808:20a0:b0:3b2:ee79:c0fd with SMTP id s32-20020a05680820a000b003b2ee79c0fdmr31848188oiw.1.1701357643362;
        Thu, 30 Nov 2023 07:20:43 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:43 -0800 (PST)
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
Subject: [PATCH v2 8/8] riscv: dts: starfive: Enable SDIO wifi on JH7100 boards
Date:   Thu, 30 Nov 2023 16:19:32 +0100
Message-Id: <20231130151932.729708-9-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl and MMC controller nodes for the Broadcom wifi controller
on the BeagleV Starlight and StarFive VisionFive V1 boards.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index adcdbbc4f57f..42fb61c36068 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -13,6 +13,7 @@
 / {
 	aliases {
 		mmc0 = &sdio0;
+		mmc1 = &sdio1;
 		serial0 = &uart3;
 	};
 
@@ -64,6 +65,11 @@ soc {
 			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
 			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
 	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio 37 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &gpio {
@@ -146,6 +152,41 @@ GPO_SDIO0_PAD_CDATA_OEN_BIT3,
 		};
 	};
 
+	sdio1_pins: sdio1-0 {
+		clk-pins {
+			pinmux = <GPIOMUX(33, GPO_SDIO1_PAD_CCLK_OUT,
+				  GPO_ENABLE, GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+		sdio-pins {
+			pinmux = <GPIOMUX(29,
+				  GPO_SDIO1_PAD_CCMD_OUT,
+				  GPO_SDIO1_PAD_CCMD_OEN,
+				  GPI_SDIO1_PAD_CCMD_IN)>,
+				 <GPIOMUX(36,
+				  GPO_SDIO1_PAD_CDATA_OUT_BIT0,
+				  GPO_SDIO1_PAD_CDATA_OEN_BIT0,
+				  GPI_SDIO1_PAD_CDATA_IN_BIT0)>,
+				 <GPIOMUX(30,
+				  GPO_SDIO1_PAD_CDATA_OUT_BIT1,
+				  GPO_SDIO1_PAD_CDATA_OEN_BIT1,
+				  GPI_SDIO1_PAD_CDATA_IN_BIT1)>,
+				 <GPIOMUX(34,
+				  GPO_SDIO1_PAD_CDATA_OUT_BIT2,
+				  GPO_SDIO1_PAD_CDATA_OEN_BIT2,
+				  GPI_SDIO1_PAD_CDATA_IN_BIT2)>,
+				 <GPIOMUX(31,
+				  GPO_SDIO1_PAD_CDATA_OUT_BIT3,
+				  GPO_SDIO1_PAD_CDATA_OEN_BIT3,
+				  GPI_SDIO1_PAD_CDATA_IN_BIT3)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
 	uart3_pins: uart3-0 {
 		rx-pins {
 			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
@@ -225,6 +266,25 @@ &sdio0 {
 	status = "okay";
 };
 
+&sdio1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	cap-power-off-card;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio1_pins>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+	};
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
-- 
2.40.1

