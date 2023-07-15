Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586107547B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGOJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjGOJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:19:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615053AA9;
        Sat, 15 Jul 2023 02:18:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b7441bfa9eso33755491fa.0;
        Sat, 15 Jul 2023 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412723; x=1692004723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGXcNx91+FOFHQlW/JA8pAmtg5iwHFhAAWjc2IMaFzw=;
        b=A0p7JiCUuLra608+6ERjSXwqV/tZTvAa1cvPeOKST0ZUmCc2JK1pC5KLEaP5wPoSkU
         uEEGPIJ0XQO2RYAKJ9N847nEcajRUNg94Xk/uSdIQyC9jJQSUzfq1Lu2wXItkcxmQRtC
         BnEctr0DsMWTKOoR7cctgg2fIGYSLwNzynkPYnuftACXr+Kx9VjpteGvPkwPi24Ma04T
         gpxd84zh1lDMJ5OBFFt/qG9JBK8AOf8WuaIm+Pffd1RAdc/pBuODnlSpriWI5mgkdo5P
         +XRa17SpvD1Ospa3DQ/iMIT5X45lYk3ldvFrtAsTNt2judzzsjfmHXLW2je88uabRR8e
         U0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412723; x=1692004723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGXcNx91+FOFHQlW/JA8pAmtg5iwHFhAAWjc2IMaFzw=;
        b=YrsyRQqqdNhxswC+6ZnZGVxw0rHz+tsI1l0PbQ7Vth5yQS4DQgHf3O9F0qqJdNIpkg
         WmVOOrdypt+CP/ZO1Wi1udETdyfe1qPTP7VmUE7Ka74mv42D4MhYw8BQfZR43nD5yT6V
         RrP6eUnDfPnvEh71WjNYXobJc7u+3VJPywhbr95h22dVmvHAF59zMWoemTpzkO/L0j2J
         RUgH5qhpfSS4AeYmdoBTUs9IKkGvztllPBJes30YvYydfFfDa/1F3J0bKi2yWi27fv89
         jBkq7cmnuu1IYMJpss0krYWGgKTzR3HHEnUpuj/h4DQb6sV6RzMTjvpUSSO7MmanLMYF
         +u+A==
X-Gm-Message-State: ABy/qLZ98JPR1PvY6ROqiT3Y9YFkeJWafWqJHk+V1rLihSrK3Gdz9AjM
        0ew0+n9y8ezEAh3IFqfCNjrQ4HUWEPz2nQ==
X-Google-Smtp-Source: APBJJlHRiGNgyATPByBHmenaTUz4eKt9rBXQerMn4f8H6CVfT4bseu8g9+BtZhxSiCB7X2oIlbbmQQ==
X-Received: by 2002:a2e:3318:0:b0:2b6:cbdb:790c with SMTP id d24-20020a2e3318000000b002b6cbdb790cmr1864605ljc.1.1689412723220;
        Sat, 15 Jul 2023 02:18:43 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e9891000000b002b840f283a7sm561784ljj.36.2023.07.15.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:18:42 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v9 4/4] riscv: dts: allwinner: d1: Add GPADC node
Date:   Sat, 15 Jul 2023 12:18:16 +0300
Message-Id: <20230715091816.3074375-5-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230715091816.3074375-1-bigunclemax@gmail.com>
References: <20230715091816.3074375-1-bigunclemax@gmail.com>
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

Add declaration of the general purpose ADC for D1 and T113s SoCs.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 1bb1e5cae602..d59b4acf183a 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -144,6 +144,16 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x400>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <SOC_PERIPHERAL_IRQ(57) IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
-- 
2.39.2

