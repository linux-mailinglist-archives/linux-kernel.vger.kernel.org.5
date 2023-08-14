Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776977B9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjHNN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjHNN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:28:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83493D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99357737980so576581466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1692019735; x=1692624535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdPyv6Fu9+Y66puo5x11N4oIzMH43gN51/s59ClZHmA=;
        b=IuSnIBz6z82KUjtI6wiKj8hJa4qftmemd9mgMzAI8h4Fv1kKPo/PALBaB1etMp0+fL
         g9B6+R4et7rMOQeiLPpqPatGThPnvfTBcOExV/MYm4EA0QtAOJV3H9QQUDF840RuySA7
         NfCiwGniqosro+lHICC4CutCFEeVaYoc+qF9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019735; x=1692624535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdPyv6Fu9+Y66puo5x11N4oIzMH43gN51/s59ClZHmA=;
        b=JXLrMjfw1g60S/mMTiROHYmnPcopbeGPTRc3uPm8D5V+YWRax3Ad1mMmLHcVOK8vhS
         JjG8kdmA5Kh5GxOB2VRq8gRqM6Rd/RvkZtkSm2s0VzCa5oRuqm6Ny2fL7wsmcYTJ7kfa
         /RXv21sHK1kG5tzh2lJZkh/p7CL8cv05p9Do76cCfYuPmSc2aMsu4GEz4u40YNa15qhp
         SzjIhojBIX6ikiEUCWcu307/FUktv1jAlTBI15OoPso4W4esVUHMmlxZINYZ73OsHYld
         yikxHyC6JCxuoRrfaV7IiJxDAXUpb33GJEaFr+lcpu1vM6MOZFT5lta+dQcONjBZjtMV
         k3Lw==
X-Gm-Message-State: AOJu0YxveknAEuiarHFcy6Ci8ttrtnQyudjzrrF2q4cAtpADTpeivb7F
        98GmxVM0J569Vo1vbKKl+X4BHirWX+3yPNVUaTUv53FC
X-Google-Smtp-Source: AGHT+IGFjehVMqUTz4FbuoG5ps0I4stw/UjQAKeX7ZcjzJkQpFgCENcR7WDugJj6HQ82X4gP+YQRew==
X-Received: by 2002:a17:906:9ca:b0:99c:441:ffa with SMTP id r10-20020a17090609ca00b0099c04410ffamr7926229eje.29.1692019734816;
        Mon, 14 Aug 2023 06:28:54 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-204.pool80180.interbusiness.it. [80.180.23.204])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b0099d02ca4327sm5662066ejb.54.2023.08.14.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:28:54 -0700 (PDT)
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
Subject: [PATCH v8 4/4] ARM: dts: stm32: support display on stm32f746-disco board
Date:   Mon, 14 Aug 2023 15:28:44 +0200
Message-Id: <20230814132844.113312-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
References: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Rocktech RK043FN48H display on stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

Changes in v8:
- Add the 'power-supply' property to panel-rgb node.
- Move backlight and panel-rgb nodes after the vcc-3v3 node.

Changes in v7:
- Add 'Reviewed-by' tags I forgot in v6.
  https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/
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

 arch/arm/boot/dts/st/stm32f746-disco.dts | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index 4e785039ba5a..bf91f6b1c0f3 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -60,6 +60,19 @@ memory@c0000000 {
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
@@ -85,6 +98,25 @@ vcc_3v3: vcc-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h";
+		power-supply = <&vcc_3v3>;
+		backlight = <&backlight>;
+		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
 };
 
 &clk_hse {
@@ -99,6 +131,18 @@ &i2c1 {
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
 	vmmc-supply = <&vcc_3v3>;
-- 
2.34.1

