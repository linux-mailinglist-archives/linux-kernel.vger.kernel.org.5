Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D877B9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjHNN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjHNN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:28:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B0D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9936b3d0286so613525066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1692019733; x=1692624533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzDesMH0Rl8r5eYsX/SIRdNEzTscR6QCg7fSNhCB0vk=;
        b=MQgLNcDYQmvN7uT6SDWKD3NsfK4SledTLTrDPRLfkNlRqZC6jYQJviTAMkbpRD6B8L
         rEvMsDFoOWVc8ZQMwPCWnrOGeRfv0ClQH5mPeBGH12edBFScvSlgwlaEsDzDJ012ogQF
         HIBGaZ5G5asPiSgniOZ4j+HV2/FCk2hD8vsis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019733; x=1692624533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzDesMH0Rl8r5eYsX/SIRdNEzTscR6QCg7fSNhCB0vk=;
        b=A+ygXQqfV58TmDECO8HKFbEzqE+miHf/wW0WaCvWmiGBf+pxpTaDh8YjyPosI4Ifft
         Mt/7Aw6SXE+TJ38Qi8+mXs05GeL8CEOlkGLeHkFpUZ88tcX6ckyAvXt/O/7IKOMe0dIb
         lX6ezITz8batfpULtgokE4QZEVQal+eujamdPNpk++Tx73YGeMKOKPTFTh+5Q4ZDZaQP
         OhVI5qLP9TYQfEO5arrZ1/yAg/tUZR50PNagkUM6YL/ClC5IggXNAL8/2vhH9hKLBn9H
         NnR8TsldXQd+z1436CpLBxab2sUnbE/4Q1BA7pIo/UB3E3L+75if5qxF21gSnKyYw7Pe
         T3BQ==
X-Gm-Message-State: AOJu0YxygV/44WjG6jjGgwq5Z5lkQWJ712yCJhMah8PqCjZ8Ksf/D5vX
        PogEXGyU1Wkx1zmAr19YewIwWF0csIK11TALWRTmYw==
X-Google-Smtp-Source: AGHT+IETZ6FarzVDypPuqWg73eGRUFR/48vMRN3Lk2qC2taThkHQZ1OzGY5Od1lINS8WuYxn/U+QSw==
X-Received: by 2002:a17:907:1def:b0:99c:22e3:3eed with SMTP id og47-20020a1709071def00b0099c22e33eedmr8170672ejc.73.1692019733450;
        Mon, 14 Aug 2023 06:28:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-204.pool80180.interbusiness.it. [80.180.23.204])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b0099d02ca4327sm5662066ejb.54.2023.08.14.06.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:28:53 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 3/4] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco
Date:   Mon, 14 Aug 2023 15:28:43 +0200
Message-Id: <20230814132844.113312-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
References: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the schematics of document UM1907, the power supply for the micro SD
card is the same 3v3 voltage that is used to power other devices on the
board. By generalizing the name of the voltage regulator, it can be
referenced by other nodes in the device tree without creating
misunderstandings.

This patch is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/st/stm32f746-disco.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index c11616ed5fc6..4e785039ba5a 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -79,9 +79,9 @@ vcc5v_otg_fs: vcc5v-otg-fs-regulator {
 		regulator-always-on;
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -101,7 +101,7 @@ &i2c1 {
 
 &sdio1 {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpioc 13 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default", "opendrain";
 	pinctrl-0 = <&sdio_pins_a>;
-- 
2.34.1

