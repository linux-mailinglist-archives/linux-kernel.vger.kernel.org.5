Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71C784443
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjHVObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjHVObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:31:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD1CCB;
        Tue, 22 Aug 2023 07:31:08 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4106eb44e64so20167601cf.0;
        Tue, 22 Aug 2023 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714667; x=1693319467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6sct25lX4sUrzVvtbgru0gGAI5dfBonk2comaZJLUY=;
        b=dObJ+ke0E+dwNn1offtNGHg3ejXD8bySNJREscb6hMZ6q3KEXvSBT0yfP0EcGEIAaT
         zJyU0HXhDxq7oJywXX+ieP0HyNJ+IPsO0BR2eEnyePwK+9jVzw840AYKqL04RQDpwg94
         FpfvOWmKksuvJWPjEuYwUOI8nDV+ONNfpn63v9+bUJGb7TPZvQ/6hZW/mIUj0O3KHj3+
         1vYlxoBCIK/eCxaVwBqBGnCPQr21ondafqydJNq3DXf4IIIksl43PAQ/7iFqxceIy7vh
         OdpRO3pLRMAFFUlKRC01DNLjIsAGfxYJhbmJeh9HaC3c+rxPZfmqMkyAcR9tzmkfHtcZ
         WNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714667; x=1693319467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6sct25lX4sUrzVvtbgru0gGAI5dfBonk2comaZJLUY=;
        b=LMz4Jo3FFtD30UMs+WnP4bsc2kyUtz/7knI5NER2fQ25EUzN/JAbqXlsNULLD3MrMV
         SbFd1iQa7nMQW/1iNrzLj8wxwANIJIRZYtz7O1VLdSNwN5S7YlQu/WBJUM8m8N9GqPpd
         NRFNW7/QR2LDCQnSxdVkrQ6CEPVa0+vP7XPBUiYM+NzbHE9w+DJQlGAyc+7HdHN0l5sq
         UsEcCIDUlSTKsGnrNPx54vjC8R6o4KRdZ2/pkDvGQ9mNG109YUFi3wZrP0VuAKXLYw1b
         9OaEnPHJy0u/DSDJd9AmBgkE4sCzhSkGdQRWYMwEVe3SRTYP11RKdB/nsT9Z4Z9UV2Ng
         RPmw==
X-Gm-Message-State: AOJu0Yxvyh/qVKklQzoCsXTwuhBWts9qFCeV2j7pBN8yYpaYmIqv60DI
        R9jGrHUoVri6n8YevcOUzpQ=
X-Google-Smtp-Source: AGHT+IHnipY6DfRuV10f8OKJj+XWeOSAu84CYROHdYk3QWf3vo0uVJnKKINv+UEUuQeG7+8M12QOUQ==
X-Received: by 2002:ac8:7dcc:0:b0:3ff:2cce:c625 with SMTP id c12-20020ac87dcc000000b003ff2ccec625mr13222621qte.19.1692714667100;
        Tue, 22 Aug 2023 07:31:07 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b00407ffb2c24dsm3055750qtp.63.2023.08.22.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:31:06 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     robertcnelson@gmail.com, drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: am335x-pocketbeagle: remove dependency cycle
Date:   Tue, 22 Aug 2023 10:30:48 -0400
Message-ID: <20230822143051.7640-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230822143051.7640-1-twoerner@gmail.com>
References: <20230822143051.7640-1-twoerner@gmail.com>
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

Remove the self-referenceing "pinctrl-0" entry inside the pinmux clause.
This eliminates the set of boot messages (one for each referenced pin)
similar to the following:

        platform 44e10800.pinmux: Fixed dependency cycle(s) with /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0/pinmux@800/pinmux_P2_17_gpio

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 667dded1a167..d4d1770657da 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -217,11 +217,6 @@ &am33xx_pinmux {
 	compatible = "pinconf-single";
 	pinctrl-names = "default";
 
-	pinctrl-0 =   < &P2_03_gpio &P1_34_gpio &P2_19_gpio &P2_24_gpio
-			&P2_33_gpio &P2_22_gpio &P2_18_gpio &P2_10_gpio
-			&P2_06_gpio &P2_04_gpio &P2_02_gpio &P2_08_gpio
-			&P2_17_gpio >;
-
 	/* P2_03 (ZCZ ball T10) gpio0_23 0x824 PIN 9 */
 	P2_03_gpio: P2-03-gpio-pins {
 		pinctrl-single,pins = <
-- 
2.41.0.327.gaa9166bcc0ba

