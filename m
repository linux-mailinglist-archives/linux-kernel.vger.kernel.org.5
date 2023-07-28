Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF6766443
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjG1GfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjG1GfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:35:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8963A90
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:34:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so2212776a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1690526066; x=1691130866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4zfk9+w42D4Vl03+U/DigAoB0zXZh0Gh/1uuAJ0hLQ=;
        b=coD2+ErD1H/tMiWFxYbwD3Apev1+9aIZlthe+ztq56bfnfXpmVs8LMwr64b3MY2U1a
         oF6wJrG/o0Eduv4oKOZywDGBQ4zqrofs0hX5dNl/+y9TezfNxlLuAFhIv4lGE+W+MRBV
         sYoj8QzbajZeb5hGULBH0zSd2zcTAzjPUN8FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526066; x=1691130866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4zfk9+w42D4Vl03+U/DigAoB0zXZh0Gh/1uuAJ0hLQ=;
        b=bBEcbQLl4UDN4dTRCCkDnDL/wO0gqnXzusQfA3lEzYwPz+sZ+GjAKC5aW4AbsFAelC
         idaUfC04eEYFJZqtME0VfLD0nU8M/aCh8igZqr1BqchphBCneBH1+S+tV7LnzznfMcFP
         yh8wxJKKjAZQnHq7eSGktz/+RWgj6MzKZskyZcjoStF9ngSH0K+6fcnkK69naCoMrMhp
         QUL9Bei1dvUQv6IMw6S3iY3EQyCnDS7rzbPtpRDF2pnHKp2uMJp368wRw4LZds2XbOcn
         M4G3FFBZKXJ1E6hQSagpVUkt5p09lW6pKRHa5xfi9XhUf5DSWv+BKE31n/MLijYYilFU
         eiyg==
X-Gm-Message-State: ABy/qLZmcB+r+2autMFT7i7eHEodTmc4t0xLKhHYMZj/4fIMgR/PHd+h
        EyhhsfDhE95ylzpfeH/gZnoE8RndpwhUK8/SwZs=
X-Google-Smtp-Source: APBJJlExcM9nsUMinTrlbRyT2/HWEEoSamyFcmaPaQEvX5nWwoO/D+suXZBHBjXeV/Vd57iiM5ytww==
X-Received: by 2002:aa7:d847:0:b0:520:f5dd:3335 with SMTP id f7-20020aa7d847000000b00520f5dd3335mr928262eds.41.1690526066222;
        Thu, 27 Jul 2023 23:34:26 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-62-70.retail.telecomitalia.it. [95.232.62.70])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm1425057edo.18.2023.07.27.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:34:25 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v7 3/3] ARM: dts: stm32: support display on stm32f746-disco board
Date:   Fri, 28 Jul 2023 08:34:16 +0200
Message-Id: <20230728063417.2980091-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728063417.2980091-1-dario.binacchi@amarulasolutions.com>
References: <20230728063417.2980091-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Rocktech RK043FN48H display on stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

Changes in v7:
- Add 'Reviewed-by' tag I forgot in v6.
  https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/

Changes in v6:
- Remove dma nodes from stm32f746-disco.dts, they are not used by LTDC,
  so there is no need to enable them.

Changes in v5:
I am confident that framebuffer sizing is a real requirement for STM32 boards,
but I need some time to understand if and how to introduce this functionality.
Therefore, I drop the following patches to allow the series to be fully merged:
 - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
 - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
 - [6/6] drm/stm: set framebuffer bit depth through DTS property

Changes in v4:
- Use DTS property instead of module parameter to set the framebuffer bit depth.

Changes in v3:
- drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
- drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

 arch/arm/boot/dts/st/stm32f746-disco.dts | 43 ++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index c11616ed5fc6..c00d34179e2e 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -60,10 +60,41 @@ memory@c0000000 {
 		reg = <0xC0000000 0x800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			no-map;
+			size = <0x80000>;
+			linux,dma-default;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
 
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h";
+		backlight = <&backlight>;
+		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -99,6 +130,18 @@ &i2c1 {
 	status = "okay";
 };
 
+&ltdc {
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.34.1

