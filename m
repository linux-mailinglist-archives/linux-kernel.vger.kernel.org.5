Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0018798628
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbjIHKuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjIHKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:49:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD751BF3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:49:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50079d148aeso3235011e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694170191; x=1694774991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f5qLUYHSj8oeYz4Th2usJC3BZwZBpvuKh12o/V+/Ws=;
        b=dMjNSDAwBV3an2m9HdPddHCfUD1Yd/9Fu9+MxLpC3HBC+rw+IYX3g7STjloVnAW3dL
         Pamkxae7RZWb/f1GqNMBfvNQ205b0pdfUfX8FLgcN7WTdSrrPxwB3JNDrw5fQNPPtq5r
         wKCkjsHHN6OQ0oRxJ0wiFJOnB5x5yw9aKQMNyq+LooZsMDkJSKCC4yxqMVpGtDLBn4pL
         IMUzV04PfguHIf/XdpBTpM8nVPFbOd/zzuwEn2662G53nHdUnA3Cy8BiwX21VKsK1oh1
         zSfzdTogwAT0wtsptpeiqU0Cmy/ROJPHqZgyX4oEhweHF8Ho4B1BlRE78yR46sKJJ9o7
         QmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694170191; x=1694774991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3f5qLUYHSj8oeYz4Th2usJC3BZwZBpvuKh12o/V+/Ws=;
        b=Vxgd3YYr+loMsThMSpMORaKk3u+6N8SmWKjj8VkWRv123lAXua7GrvaZdIB7xloY3j
         8sO1LRCCnXSittQW+wZdkyzvoxI+OabR6ev9sBnKNPT/3RJoC5c4F9Vw3pIZYVTPkVnK
         8J1FR/8vztXh2a+kUawTPhN9Eqc9rO7GNjuFsSK4R9Ksy4rIWpELCw/8rnbeyWlkzyOR
         EyXUJL7gxtBkUW9G5UMRGLZgjr0uzkPhVA2c2fqbX0uKu3mAU25pWO8x1+J5Km9kWA0i
         V1SrWJMQ6qNN+oqfuid3jv+PqQ2FkcM5cFgdvMA3rbsvmxNWaLUWUfUhCMhzktGheELT
         hWtg==
X-Gm-Message-State: AOJu0YzsdbHHH7uvm4vjeTgBDVIEp9UDlmf7UUYl4ByXvcmPJvChiVQw
        nIlm6zpLWu/5Mtqrvf8bMa82Rg==
X-Google-Smtp-Source: AGHT+IFtNorHnHtd+HAXeiKT49c5jnsqc7uyi8vlt1znsjoQU3bWjIK9Wjw8rwOmPld42mFUjSI+sw==
X-Received: by 2002:a05:6512:63:b0:4fe:629:9265 with SMTP id i3-20020a056512006300b004fe06299265mr1419124lfo.20.1694170191574;
        Fri, 08 Sep 2023 03:49:51 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id y15-20020ac255af000000b0050089b26eb0sm243321lfg.132.2023.09.08.03.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:49:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 08 Sep 2023 12:49:49 +0200
Subject: [PATCH 2/2] ARM: dts: ixp4xx: Use right restart keycode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230908-ixp4xx-dts-v1-2-98d36264ed6d@linaro.org>
References: <20230908-ixp4xx-dts-v1-0-98d36264ed6d@linaro.org>
In-Reply-To: <20230908-ixp4xx-dts-v1-0-98d36264ed6d@linaro.org>
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "reset" key on a few IXP4xx routers were sending KEY_ESC
but what we want to send is KEY_RESTART which will make
OpenWrt and similar userspace do a controlled reboot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts | 2 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts  | 2 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts | 2 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts
index b9d46eb06507..fa133c913606 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts
@@ -57,7 +57,7 @@ gpio_keys {
 
 		button-reset {
 			wakeup-source;
-			linux,code = <KEY_ESC>;
+			linux,code = <KEY_RESTART>;
 			label = "reset";
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
index 5a5e16cc7335..73d3c11dd0d4 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
@@ -44,7 +44,7 @@ button-sync {
 		};
 		button-reset {
 			wakeup-source;
-			linux,code = <KEY_ESC>;
+			linux,code = <KEY_RESTART>;
 			label = "reset";
 			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts
index 8da6823e1dbe..26f02dad6a54 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts
@@ -63,7 +63,7 @@ button-power {
 		};
 		button-reset {
 			wakeup-source;
-			linux,code = <KEY_ESC>;
+			linux,code = <KEY_RESTART>;
 			label = "reset";
 			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts
index 706ba531faf0..2eec5f63d399 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts
@@ -65,7 +65,7 @@ button-power {
 		};
 		button-reset {
 			wakeup-source;
-			linux,code = <KEY_ESC>;
+			linux,code = <KEY_RESTART>;
 			label = "reset";
 			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
 		};

-- 
2.41.0

