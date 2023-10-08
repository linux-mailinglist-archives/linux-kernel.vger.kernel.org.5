Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA627BCECD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbjJHOCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344807AbjJHOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:02:52 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F954CA;
        Sun,  8 Oct 2023 07:02:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-352753fb42eso15719425ab.1;
        Sun, 08 Oct 2023 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696773770; x=1697378570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i817gm/mHayZlPnquKIwRuj/bCQb7oFHdZW9Ygf1Wzw=;
        b=gappIRqrv8KXeXcqhkFYSSf4OzssNhdwzyyny+Xg+5XbnWM5VdGHYfASdOlQU1ik8I
         sswI079Ash/546f2iTQEew1Jnv+SY9MfU8VJxuXYlpA+anLF/wllBobTHXCS7DjI5qDK
         CYGAJdRVLp9C8+w7y+pVmzNzKTSXljp8AwKGsBAsusNYK0k9EO5FdJ1sic7Y7JXzDPmX
         o5UKUjRJIXXQTLIZ1weG8c7NWTLwUQ6v4nXoRHoEF37nBco02SDN0UtSUpAkX7TIdwpg
         DkvCtfS2+UO8T3+QHoCmdI/G7n7COSLjLHHM0szI5pVf69D0/Kj0G3VVTuoUabgRr2JP
         NTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773770; x=1697378570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i817gm/mHayZlPnquKIwRuj/bCQb7oFHdZW9Ygf1Wzw=;
        b=tbTCf+YYMZcVLyuB010WS3BUBtpjEkH0bHXLrid79JFgMNxVEauHAzOpTn7Se+J4iQ
         YcYbbb6heAlSPvf2MgI1jgQxr6f4d7++OEYj20xGfqxlB5jfQbdaLrE88eyEhLrMvsPG
         AOTgdT1CUPGMzn1RZj2va0LngB1Oj/IMna2IC8DMGfKzWsWiK/blN70bOG6Fk+oooOmG
         gCD8WgG221Ia74B6OHnTkF4lczi1HFs4ZO0ZpB+m404Ot88feCztGJFoBaM3iLIvRovy
         GRG5NfiZ6UBmZ1mmzPTmkYro7vhMopxOsCplXot2h/JF4ZdpL04QdiRLdH6PBdS28u0l
         hVyg==
X-Gm-Message-State: AOJu0YycHapCU+4ujvtMrzKy81lJHhOxxXD/vqwcGlPpDjQZ1O7C4a4E
        QAm+h7Qdp4QGs8kuhzlrgZo=
X-Google-Smtp-Source: AGHT+IHRU/p6K757tMjeqS8Ii2krhvKfRulLKOsvixbCZCCoLxXOmhUGypkPJ7IguLsJm9buWGS/YQ==
X-Received: by 2002:a05:6e02:d45:b0:345:66f5:3404 with SMTP id h5-20020a056e020d4500b0034566f53404mr13375528ilj.0.1696773770370;
        Sun, 08 Oct 2023 07:02:50 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:a2fe:632a:2360:50d3])
        by smtp.gmail.com with ESMTPSA id 2-20020a921302000000b0035134f1a240sm2272901ilt.86.2023.10.08.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:02:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] arm64: dts: imx8mm-beacon: Migrate sound card to simple-audio-card
Date:   Sun,  8 Oct 2023 09:02:35 -0500
Message-Id: <20231008140239.6601-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Instead of using a custom glue layer connecting the wm8962 CODEC
to the SAI3 sound-dai, migrate the sound card to simple-audio-card.
This also brings this board in line with the imx8mn-beacon and
imx8mp-beacon.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index b10e2a703a44..313e93663d6f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -98,18 +98,30 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
+	sound-wm8962 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8962";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "Headphone", "Headphones",
+					    "Microphone", "Headset Mic",
+					    "Speaker", "Speaker";
+		simple-audio-card,routing = "Headphones", "HPOUTL",
+					    "Headphones", "HPOUTR",
+					    "Speaker", "SPKOUTL",
+					    "Speaker", "SPKOUTR",
+					    "Headset Mic", "MICBIAS",
+					    "IN3R", "Headset Mic";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
+			frame-master;
+			bitclock-master;
+		};
 	};
 };
 
@@ -192,6 +204,7 @@ wm8962: audio-codec@1a {
 			0x0000 /* 4:FN_DMICCDAT */
 			0x0000 /* 5:Default */
 		>;
+		#sound-dai-cells = <0>;
 	};
 
 	pca6416_0: gpio@20 {
-- 
2.40.1

