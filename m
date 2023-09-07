Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76979738B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbjIGP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245070AbjIGPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:25:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBC10FF;
        Thu,  7 Sep 2023 08:25:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007616b756so1820537e87.3;
        Thu, 07 Sep 2023 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100325; x=1694705125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=927dFowXauJqC2YOXBDk/4qoxBXJD8XdbGuXvoshWHY=;
        b=TVQOC9ei3D8cMaMe8xv0kbqBWxGtGobzeOHD0Iac2eAWpQjBW2/NaG47WHpzP3nESy
         GlaA7rF9qqAXViIiW6GsFjpI6T3C+SQDlhm7HnOmXka5Qlwb7BVNWjmNNQMReZCYRXa4
         Sf2siy46df9LPmQnKwmdRv8EdrXOa2NteXNO9MUzDg/cT84mfYscnNcHL/Hjf9+7SV/h
         N/yjjhsJPF/t/apEqUFkL3RDzMweRCdAl72+yGZYAOP37grKAeq7GHXLpNA9+kQbzMGI
         l3jBlFMa3Rgb0TBM9BOB67DE4STHdKkhL/NWNLijKJDkSPGYIKNEISlpbGklOQUrdeed
         EtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100325; x=1694705125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=927dFowXauJqC2YOXBDk/4qoxBXJD8XdbGuXvoshWHY=;
        b=fz8J26C2H/o4ufvp+fbB2gVTxj7sjh++bDVdsf1F1wROot3lPLZNrFNSABy0CFJrYL
         wrncCamN+Me8jqZgomaPal36TiQ2e2fP/2VBAudUBliLPe2AjxfTDate44A7D741vslk
         tAW+bE3NfGJEOywusPXmaiHcwJwcbZlgdarpjFlSUqI9LaD0HRSBrjMItiW1WhhiX0tg
         Ek+YpuuRZiYlyUX1koRR+Y9qS/23g24aHfE9Mv8dIV/rgn5aeZQIPXDpeUDba6Ix09Z9
         IxN53HMb6kgnG2nd9CDXAl2BB+zAp5G5UEDhc79M+/Sm/KYgToaj/YQ+323jpajarhCF
         n+bA==
X-Gm-Message-State: AOJu0Yz0LLynDrM8LQyYeiMBRd5gJ3SiLJKVUpt642K9fcWO2s1PTDl8
        XEo7QUAnh329NztpU/+glwi/InyBVm0=
X-Google-Smtp-Source: AGHT+IH9O6jeW0XIr3SNBsUTJS7++/h8X1hnBWZyxkOvHJj1QJ0k19xawmaY+Y2sK27mo7gAVRC44Q==
X-Received: by 2002:a5d:6d4c:0:b0:317:5182:7b55 with SMTP id k12-20020a5d6d4c000000b0031751827b55mr4719128wri.42.1694095818965;
        Thu, 07 Sep 2023 07:10:18 -0700 (PDT)
Received: from localhost ([2a02:810d:1640:10d8:bdda:474a:9786:1e73])
        by smtp.gmail.com with ESMTPSA id n17-20020a1c7211000000b003fe1630a8f0sm2588711wmc.24.2023.09.07.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:10:18 -0700 (PDT)
From:   Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Joerg Schambacher <joerg.hifiberry@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
Date:   Thu,  7 Sep 2023 18:08:51 +0200
Message-Id: <20230907160851.14241-1-joerg.hifiberry@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS5754/6 power amplifiers use the same pcm512x driver with
only minor restictions described in the bindings document.

Signed-off-by: Joerg Schambacher <joerg.hifiberry@gmail.com>
---
 .../devicetree/bindings/sound/pcm512x.txt     | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
index 3aae3b41bd8e..b16cd0463695 100644
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
@@ -1,12 +1,12 @@
-PCM512x audio CODECs
+PCM512x and TAS575x audio CODECs/amplifiers
 
 These devices support both I2C and SPI (configured with pin strapping
-on the board).
+on the board). The TAS575x devices only support I2C.
 
 Required properties:
 
-  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141" or
-                 "ti,pcm5142"
+  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141",
+                 "ti,pcm5142", "ti,tas5754" or "ti,tas5756"
 
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
@@ -25,6 +25,7 @@ Optional properties:
     through <6>.  The device will be configured for clock input on the
     given pll-in pin and PLL output on the given pll-out pin.  An
     external connection from the pll-out pin to the SCLK pin is assumed.
+    Caution: the TAS-desvices only support gpios 1,2 and 3
 
 Examples:
 
@@ -50,3 +51,16 @@ Examples:
 		pll-in = <3>;
 		pll-out = <6>;
 	};
+
+	tas5756: tas5756@4f {
+		compatible = "ti,tas5756";
+		reg = <0x4f>;
+
+		AVDD-supply = <&reg_3v3_analog>;
+		DVDD-supply = <&reg_1v8>;
+		CPVDD-supply = <&reg_3v3>;
+
+		clocks = <&sck>;
+		pll-in = <1>;
+		pll-out = <2>;
+	};
-- 
2.34.1

