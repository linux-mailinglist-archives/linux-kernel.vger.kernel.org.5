Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52978EC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjHaLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbjHaLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:51:53 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE9E45;
        Thu, 31 Aug 2023 04:51:48 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34cb5c41777so2563735ab.1;
        Thu, 31 Aug 2023 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693482708; x=1694087508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYuphCJVTBw5X395ddLzbAIWgxz1eVkD4K/+xpz52Vg=;
        b=DT9OI/zrC5ed9TS3nsKQnJhQ6dDu8zJP6nG+b5viZth5xhyClKq7mjJG8Yzp2Ymgjk
         Xk3lRo2lUkrMaCgyR5ASrt6a9KHO5awpjs+gW0Q1g+UjgE1YiCdIGp+5O2C8GdZ7qbx7
         vGP9ZNfwFWlqi0T8lPw+qbrcKij3/San9OHIDVOqfkQrpGEjGhcHIXaN3DNrmjjO1f6x
         JVV3OL2dfPx8yKklcI+aBDuAf0XT+iX/neDUfw9ccEy5D+ZOQeF9HItsY65wjgwdN6MR
         E31ueVHt2spLLsnls+qVBXgXlyPEsVHFcs6nuAzk05geIfunbTl+XBZPr6jGYYU9HgTY
         TVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482708; x=1694087508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYuphCJVTBw5X395ddLzbAIWgxz1eVkD4K/+xpz52Vg=;
        b=PJtLmK5/+lTxDCpyt0aQbLdYeq4RKOXVahox3yZf0KiUZMelkcsiGAm1hFkPURQ3Zf
         wjSnQmDQ/hWbduIVWMX9xCOlQRnG2B7BPA/PcRMv1LGr5PaNCESFJyuhgU/eGsrPZlTc
         iykA7auFwyBmT9+FsCmeFL0m9qyXJCHMJ19ky5tiECL8JnMmMlAx8sPAoYt3cecycS7b
         jzcrSjw3DJkkpoxLy7BivDmuPRbfagekFy6vS215BPr8GuU2pu7J66jo46MkZ2GKjF6F
         1yF7vHhBHc/ACZfGGCKsAQQ0KvdFz/aMgDNpoiClposcpxRdKVB4igf1H9SiyEeG44Vd
         ITHA==
X-Gm-Message-State: AOJu0Yy9pncFAf9VrnBpcY313y9n/zb4Labau7FeqdeWlFFLbTlyKKTw
        s27q1zBFQg0IMdU4YkQRP8argpMKU34=
X-Google-Smtp-Source: AGHT+IHJcAeSKb3dVp1FGvE0rQrWpXkXhudpoKU555XVw9oWPRW92roA3e+JUwqYENI6MTcO0fwnYg==
X-Received: by 2002:a05:6e02:ee7:b0:34c:b992:58b1 with SMTP id j7-20020a056e020ee700b0034cb99258b1mr4955572ilk.2.1693482707727;
        Thu, 31 Aug 2023 04:51:47 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2a0f:e1d5:3688:f2b8])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0042b1d495aecsm353529jap.123.2023.08.31.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:51:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
Date:   Thu, 31 Aug 2023 06:51:28 -0500
Message-Id: <20230831115128.254226-4-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831115128.254226-1-aford173@gmail.com>
References: <20230831115128.254226-1-aford173@gmail.com>
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

The baseboard has a connector for a pulse density microphone.
This is connected via the micfil interface and uses the DMIC
audio codec with the simple-audio-card.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index acd265d8b58e..ee64c6ffb551 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -49,6 +49,12 @@ ss_ep: endpoint {
 		};
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -147,6 +153,22 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
 		enable-active-high;
 	};
 
+	sound-dmic {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sound-pdm";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+
+		dailink_master: simple-audio-card,cpu {
+			sound-dai = <&micfil>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&dmic_codec>;
+		};
+	};
+
 	sound-wm8962 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8962";
@@ -174,6 +196,11 @@ simple-audio-card,codec {
 	};
 };
 
+&audio_blk_ctrl {
+	assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>, <&clk IMX8MP_AUDIO_PLL2>;
+	assigned-clock-rates = <393216000>, <135475200>;
+};
+
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
@@ -364,6 +391,15 @@ hd3ss3220_out_ep: endpoint {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MP_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
@@ -545,6 +581,13 @@ MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21 0x10	/* PCIe_nRST */
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__AUDIOMIX_PDM_CLK		0xd6
+			MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_PDM_BIT_STREAM00	0xd6
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-- 
2.39.2

