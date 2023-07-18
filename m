Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7E75828C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGRQx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGRQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:53:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624D10F7;
        Tue, 18 Jul 2023 09:53:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99313a34b2dso720302966b.1;
        Tue, 18 Jul 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699201; x=1692291201;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=595x0bsqvrRtiLq7E28reIDk1uKUdT4YG5heiFGbh+k=;
        b=rKUdKCtl14dEO7NC99N8r+MENRKDpCH5VUPJgYmSeWEFYqM0pHzPRnOjJJGWGtr8DL
         fqMqpumtL5wmYbpm+54YU5x6YVPlKSJmTE6faCpo3WhB0scVug/wBBlPkonzf4BzhCso
         qmW7gVp+gxiG+wG2oUle/wuJ9F+kZwVWEJMZRyMBBc+QLuUiLcNrKYYMhIDn6zL6asRF
         3ARn7uGVKcoffKgdg3j+EK/mfiTDKM1Xwj8x9uNNqCbF02+3bSJcI8Gtetg3k52iAOmf
         QoXmldvF5beGKmgkwTaJ1UyvYKxksWR6lqSxqcEUFPMIO9pbxUSCK8KojfjHT4zN8ELk
         scvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699201; x=1692291201;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=595x0bsqvrRtiLq7E28reIDk1uKUdT4YG5heiFGbh+k=;
        b=d1u3L3kCZTl8o82yX17I7IYQsDf/ZtLX2ZR489PsZmqrRFo7mJQsqcAaIM+6PuYPXB
         0Xf/zouABV+dXiLYya+QOwUxFw2kU+UKMOalEesRp+xVQskxY5jwyKDFJ1AGNkhmtUCL
         04bl96tc7MdgIG9CATlqISsaoEkYf6ZYOFdDT86pJ9pyq8SwlkeLEHTQI/9VVXPLhbE9
         KAGrbksAdm6B5UH1LiKdM3z+RGdhGqc/v5gtad6aulilvQl0iXaKNZ93KA7f/MiaXmeW
         ADOmMKwpsCdo39TD8T11CG0+QYK+f37nS/sc2RkoPhf8QBEuSUk8nxmRQrL7Ztu0Y+bG
         /dHw==
X-Gm-Message-State: ABy/qLYFT4Qd26vemUCm0Iyt4dGW1Di/IUyebxyXBYhnH2ZQHLAvaTGb
        sKVA6GX9XVq5429JvlGKKK4=
X-Google-Smtp-Source: APBJJlGEIjSyU2QmhaIYCcljiA0h0ys3G0ahC5oDFsdPO1fW9PWSxa5zALQi03lhWfSDvgSP+7UoyA==
X-Received: by 2002:a17:906:209c:b0:991:b554:e64b with SMTP id 28-20020a170906209c00b00991b554e64bmr414804ejq.54.1689699201188;
        Tue, 18 Jul 2023 09:53:21 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id lf26-20020a170906ae5a00b009887f4e0291sm1233018ejb.27.2023.07.18.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:53:20 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:53:19 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: bcm28155-ap: use node labels
Message-ID: <20230718165319.GA5179@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use node labels instead of nodename@address for BCM28155 AP board
to simplify its DTS file.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
  - keep &pmu (bcm59056) related stuff last in the file
  - drop already applied patches
  - drop cover letter (since this is now a single patch)

V1 - https://lore.kernel.org/lkml/cover.1685127525.git.stano.jakubek@gmail.com/

 arch/arm/boot/dts/broadcom/bcm28155-ap.dts | 94 +++++++++++-----------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm28155-ap.dts b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
index 0a8ad1d673d8..2f3634545e64 100644
--- a/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
@@ -15,64 +15,64 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+};
 
-	serial@3e000000 {
-		status = "okay";
-	};
-
-	i2c@3e016000 {
-		clock-frequency = <400000>;
-		status = "okay";
-	};
+&bsc1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
 
-	i2c@3e017000 {
-		clock-frequency = <400000>;
-		status = "okay";
-	};
+&bsc2 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
 
-	i2c@3e018000 {
-		clock-frequency = <400000>;
-		status = "okay";
-	};
+&bsc3 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
 
-	i2c@3500d000 {
-		clock-frequency = <100000>;
-		status = "okay";
+&pmu_bsc {
+	clock-frequency = <100000>;
+	status = "okay";
 
-		pmu: pmu@8 {
-			reg = <0x08>;
-		};
+	pmu: pmu@8 {
+		reg = <0x08>;
 	};
+};
 
-	sdio2: mmc@3f190000 {
-		non-removable;
-		max-frequency = <48000000>;
-		vmmc-supply = <&camldo1_reg>;
-		vqmmc-supply = <&iosr1_reg>;
-		status = "okay";
-	};
+&pwm {
+	status = "okay";
+};
 
-	sdio4: mmc@3f1b0000 {
-		max-frequency = <48000000>;
-		cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
-		vmmc-supply = <&sdldo_reg>;
-		vqmmc-supply = <&sdxldo_reg>;
-		status = "okay";
-	};
+&sdio2 {
+	non-removable;
+	max-frequency = <48000000>;
+	vmmc-supply = <&camldo1_reg>;
+	vqmmc-supply = <&iosr1_reg>;
+	status = "okay";
+};
 
-	pwm: pwm@3e01a000 {
-		status = "okay";
-	};
+&sdio4 {
+	max-frequency = <48000000>;
+	cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&sdldo_reg>;
+	vqmmc-supply = <&sdxldo_reg>;
+	status = "okay";
+};
 
-	usbotg: usb@3f120000 {
-		vusb_d-supply = <&usbldo_reg>;
-		vusb_a-supply = <&iosr1_reg>;
-		status = "okay";
-	};
+&uartb {
+	status = "okay";
+};
 
-	usbphy: usb-phy@3f130000 {
-		status = "okay";
-	};
+&usbotg {
+	vusb_d-supply = <&usbldo_reg>;
+	vusb_a-supply = <&iosr1_reg>;
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
 };
 
 #include "bcm59056.dtsi"
-- 
2.25.1

