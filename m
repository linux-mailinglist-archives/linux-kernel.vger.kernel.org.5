Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B3760141
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGXVff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGXVfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:35:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B27F126;
        Mon, 24 Jul 2023 14:35:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so7134864e87.2;
        Mon, 24 Jul 2023 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234529; x=1690839329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGqd0Dpk0QJClHF7xv6N5WpusRf7KZmTiJZbeW3YVpA=;
        b=bSo1bzBSvbXk9nqAD97BGglxykvznOQ1gf/1zYxmZeCE8L1R/RYrEUc23gkSoQG5b8
         OiGVU3nLrwYUzG3piGFUzrlD4ZLGf5m7vmiXzV8j9YdW/J60doQdsXBm7X6es4kGhpAP
         mfYubkIN6x9wEBtPmx3fLSNAT6FEBnrzej2RGRjG2dXe+BWflZTTbYaBA7mm+IJ0+ecJ
         +1pa1LkyANOg23vHe9P4hN1azoy4vCW56+Bhbis14qz84AUYZToVQeoOpW7pBkBJ/dUe
         Wm7X5+DZdKg5OF22X5KvFlgnRgfkpG+3ub3dEa8xr8FK7kZ/s9Soqj8dqBVUR29zhyN3
         kSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234529; x=1690839329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGqd0Dpk0QJClHF7xv6N5WpusRf7KZmTiJZbeW3YVpA=;
        b=CJtmJuobxtHUjSdBj0AOrpGYjoBBrdixUbWzR+oytteH2mCb87zvUHqYuarZ2xW2wt
         pmM6JJ0U6cCvtS3X2ONvx3HGuItgwYqvBGOrOKWBvNsC/VSf/xemrcby03ILkhzvvWaB
         OfYl5PNXeMxE9DK9kcPvTw4+BGHSnSuIXMYcwowddB0G5V1Bs+47vNPgaCQ+UnxWxu2l
         Hc5Cb0MPSLTKtrc+8lPo2nLQ4LVZtIraQlDJd6RFJ1JVN66L/7KoEfElxYPAtqInfh6h
         33sw+2irRL4NR2nrFLoV3DoIZY9ox04dy7koj5na+V+kWPPjuAApMqphV/QvLNBDg6qE
         kN+Q==
X-Gm-Message-State: ABy/qLbLOdY6h3z3yE3gXP8hpCyn+y2BX6qJAd9Lr+yyHry8dvmK0zjg
        PFNyzMVBXkRQpcawbraHV2w=
X-Google-Smtp-Source: APBJJlGlS0ny6UsHvHlYOypOEI7Ao8qoTKmL9cK2lJ/LoBv1hnPDT+AUsLfEL5/cbRhNbMkryxxkDQ==
X-Received: by 2002:a05:6512:480d:b0:4fb:9129:705b with SMTP id eo13-20020a056512480d00b004fb9129705bmr5710559lfb.6.1690234529045;
        Mon, 24 Jul 2023 14:35:29 -0700 (PDT)
Received: from new-nest.cgt.local ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id m26-20020a056512015a00b004fb745fd22fsm2406675lfo.32.2023.07.24.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:35:28 -0700 (PDT)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] arm64: dts: pinephone: Add pstore support for PinePhone A64
Date:   Tue, 25 Jul 2023 00:34:57 +0300
Message-Id: <20230724213457.24593-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reserves some memory in the DTS and sets up a
pstore device tree node to enable pstore support.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Gbp-Pq: Topic pinephone
Gbp-Pq: Name 0161-arm64-dts-pinephone-Add-pstore-support-for-PinePhone.patch
---
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..84f9410b0b70 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -19,6 +19,22 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pstore_mem: ramoops@61000000 {
+			compatible = "ramoops";
+			reg = <0x61000000 0x100000>;
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x20000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
-- 
2.39.2

