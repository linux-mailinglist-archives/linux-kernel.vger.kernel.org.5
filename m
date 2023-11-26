Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6E7F9682
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjKZX3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjKZX2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:28:43 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6B1AB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:47 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 404BC40C57
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041326;
        bh=3BV4Vz9z3QHFiX3Dv1bjv4P8f3k40Tur0+jRMIWhjwA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FZoeHXHWvyz/kKxWZ6nr5oB4aFa9WsY+qk3Wv8LVQj9uyUcoJgP+MSCse8L//XXhI
         cz5BhPCDmHQYL4D9JG41A2tQA4/1QgmdoQJryJQQcshLXcgCyby1nOUidDxLkKfPTf
         apNH1sVwOstou57IwQHut81xyexvY9oSNjjo5IS3frF64EgKmcoaygRP8+Zp3ABYNB
         vclZhZkwl+K2ApRdAEQTuW/oAHadgakkAgDuKAfmgjI9Z6XoR+hzvtY44z5Dzbqy+V
         uKyHdFU2I2cFHYOPF4odsIb1+dIpluTRf9Xz4LO0wkV3RxpP2TCnMEHh8KOahhT9Z1
         PBHC7ofGKSg7g==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2859052aed9so2355090a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041325; x=1701646125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BV4Vz9z3QHFiX3Dv1bjv4P8f3k40Tur0+jRMIWhjwA=;
        b=GwGtZZ+ixyrQfhRm4zf7k8hcYLZ0FTHs1WqgI4ZTccsTma75sLd4lrcm9g3V7AxVuU
         0Jf5ZVxv8SCB5mcFKYsGSEmoIGT3/EXi8L3IkTn5Dk7M4cs/qi25G7duyQX+vKvnR1mL
         wYjJ4vcOYvKlPv8Ub2r1X5ErA+BkCZIrOdpUmqd2ciM6sgW4zxAueeBr+dbZFwfAvxrK
         r87dC+xzcNXZ6kdcKj45NoFZTaJXjzqE7kiGxQgJLABbOulQWC8m8DLNKcj2b8F8S0XC
         auMW/dIw75RScZG++YtUPoxbGlpYgn3WcjIfbELXa86DPcc50jIGZPHuzhWoPhhwflvx
         iEfw==
X-Gm-Message-State: AOJu0YzEZ+iHloslhgGGTA3XqAPAjx78LfZ2Rz0pI2EhzoQsVpiI4px7
        MkfRYzpMnDbfVczJ/bxRYVCn5BqBw7cfbh4S6nprFcbv2jSuKnlj8Aq28dL5F9tbojeyMh+LiA+
        nOsAqgbY+jI/GcrC4EncyvLNFVA8GV/2fQwzzx/i1jw==
X-Received: by 2002:a17:902:efc5:b0:1cc:32b7:e5b9 with SMTP id ja5-20020a170902efc500b001cc32b7e5b9mr8690140plb.67.1701041324949;
        Sun, 26 Nov 2023 15:28:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu5REQhM9BvA/Q6QjZJDOHExkoWf96BeljpTfWoUEfeaxHnVUPLtF62hI5iumuW9CPgiN14g==
X-Received: by 2002:a17:902:efc5:b0:1cc:32b7:e5b9 with SMTP id ja5-20020a170902efc500b001cc32b7e5b9mr8690128plb.67.1701041324714;
        Sun, 26 Nov 2023 15:28:44 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:28:44 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v1 7/8] riscv: dts: starfive: Enable SD-card on JH7100 boards
Date:   Mon, 27 Nov 2023 00:27:45 +0100
Message-Id: <20231126232746.264302-8-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

