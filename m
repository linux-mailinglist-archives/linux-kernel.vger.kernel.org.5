Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E24A7F3022
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjKUODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjKUODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:03:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899BD7C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:03:14 -0800 (PST)
Received: from notapiano.myfiosgateway.com (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C366666072F6;
        Tue, 21 Nov 2023 14:03:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700575392;
        bh=yUohD6aXpsVPXyRnfHGaODud/RNyySajyAvFPq63i+g=;
        h=From:To:Cc:Subject:Date:From;
        b=WCIEqg+Kxhhvdb4voS/8eLPQOAP0oV/IQaekZdVD3luoTWJ4GT7pSRkhPjQGCQXgQ
         a77f9xv6uVaN2rpeDq3hqTBEFbMHPsDTJNmC66qwBi7PKBngfXt3as3WEsQEaqKGO8
         ux2od1fDXLOxHkvqjpXbZj5PeCFD3WIKtd0TTKebMxrA6IglJ2GVOX03a3LHFshMvc
         Div2v2ntwRNdDnb4h6ukaMccvv1oWbvHlhlfWgRB88OMNhxp2TcZJHrv9TQ0bwOjFu
         3LNR5pdrye7Uyaf8k2qFzkifoorFyoxQRL29hQ/bI1BvXoTzJbIROE82xz8hYqwJ+D
         1VV4GGfFH6rmg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable configs for MT8195-Cherry-Tomato Chromebook
Date:   Tue, 21 Nov 2023 09:02:57 -0500
Message-ID: <20231121140304.458376-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable missing configs needed to boot the MT8195-Cherry-Tomato
Chromebook with full support on the defconfig.

The configs enabled bring in support for the DSP and sound card,
display, thermal sensor and keyboard backlight.

Additionally, CONFIG_USB_ONBOARD_HUB is set to builtin to allow for
booting from an USB flash drive without a ramdisk.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
This patch relies on another patch [1] fixing support for the Mediatek
DP when enabled as a module.

[1] https://lore.kernel.org/all/20231120202837.396760-1-nfraprado@collabora.com

 arch/arm64/configs/defconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..97026a99c10c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -252,6 +252,7 @@ CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_INTEL_STRATIX10_RSU=m
+CONFIG_MTK_ADSP_IPC=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
@@ -675,6 +676,8 @@ CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_MTK_THERMAL=m
+CONFIG_MTK_LVTS_THERMAL=m
 CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
@@ -877,6 +880,7 @@ CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MEDIATEK=m
+CONFIG_DRM_MEDIATEK_DP=m
 CONFIG_DRM_MEDIATEK_HDMI=m
 CONFIG_DRM_MXSFB=m
 CONFIG_DRM_MESON=m
@@ -913,6 +917,8 @@ CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m
 CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
 CONFIG_SND_SOC_MT8192=m
 CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
+CONFIG_SND_SOC_MT8195=m
+CONFIG_SND_SOC_MT8195_MT6359=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
@@ -930,6 +936,10 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_RZ=m
+CONFIG_SND_SOC_SOF_TOPLEVEL=y
+CONFIG_SND_SOC_SOF_OF=y
+CONFIG_SND_SOC_SOF_MTK_TOPLEVEL=y
+CONFIG_SND_SOC_SOF_MT8195=m
 CONFIG_SND_SUN8I_CODEC=m
 CONFIG_SND_SUN8I_CODEC_ANALOG=m
 CONFIG_SND_SUN50I_CODEC_ANALOG=m
@@ -1024,7 +1034,7 @@ CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_QCOM_EUD=m
 CONFIG_USB_HSIC_USB3503=y
-CONFIG_USB_ONBOARD_HUB=m
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
@@ -1183,6 +1193,7 @@ CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
 CONFIG_CROS_EC_RPMSG=m
 CONFIG_CROS_EC_SPI=y
+CONFIG_CROS_KBD_LED_BACKLIGHT=m
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCMI=y
@@ -1279,6 +1290,7 @@ CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
+CONFIG_MTK_ADSP_MBOX=m
 CONFIG_QCOM_IPCC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
-- 
2.42.1

