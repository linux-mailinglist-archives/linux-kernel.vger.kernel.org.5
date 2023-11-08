Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3687E5EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKHTa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjKHTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:30:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B892591;
        Wed,  8 Nov 2023 11:29:51 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FF6066076A4;
        Wed,  8 Nov 2023 19:29:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699471790;
        bh=5EEmjqlfCXr8f+nuvWUkqpYUqLb0BgV0iKNe92KcenM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gCZrvwAHe2TWO1Wo0jrUc/A2yRzfk3/yQekgz37lh4W33cS+Z8pyvKZE+I0DgW+qw
         SPSRKV12dyF8KpweC/+/Z1NMlc4sizlTBsDp5LNlhdzzkGGUsKinbZjP0OBanO4cSi
         UWUp00EdVpvfuVRnETm5bP9i+ZVX1HyY7oi6TWdytPzedss0vxYrkhJTFNZcDrIrWM
         bEh20O2cNrWjY7u2IOmHAtjAmS6+YCwj8TgK9igVNoPyeJfNeuzUOuY7Y7FRmZx/iZ
         L1ylJBm1QB0GyZLZPf4Xfabboyo3oE9wf2GI2bUl/ykicufXncFeckeFp0VuuZ/ER1
         ybWRNxRgYEDYg==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Wed, 08 Nov 2023 20:29:27 +0100
Subject: [PATCH v14 8/8] arm64: dts: ti: k3-j721s2-main: add wave5 video
 encoder/decoder node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-wave5-v14-rebased-v14-8-0b4af1258656@collabora.com>
References: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
In-Reply-To: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        devicetree@vger.kernel.org,
        Robert Beckett <bob.beckett@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699471762; l=1390;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=ZxxGJD9eMM+hOducG8IQEAUt1ctZIrZFPl7ACJTXwpI=;
 b=ULMruYYepXYnx5ZGL4Yi0xYANNcVDQIfUYv/ik3kVlgeqK+GSY0iMkrim4bQ7fwkp96nVNkrAIuV
 +0w4Pj09BzCLigutmVsX7EYmHYm2lxWd/1imKbSYl0IMU+WucExb
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darren Etheridge <detheridge@ti.com>

Add the Chips and Media wave521cl video decoder/encoder node on J721S2.

This functional block also requires an SRAM buffer as a bandwidth saving
temporary store so we need to add a carve out of 126K for this as
specified in the documentation.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 084f8f5b6699..70ed17c4c81b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -28,6 +28,10 @@ atf-sram@0 {
 			reg = <0x0 0x20000>;
 		};
 
+		vpu_sram: vpu-sram@20000 {
+			reg = <0x20000 0x1f800>;
+		};
+
 		tifs-sram@1f0000 {
 			reg = <0x1f0000 0x10000>;
 		};
@@ -716,6 +720,16 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	vpu: video-codec@4210000 {
+		compatible = "ti,k3-j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 179 2>;
+		clock-names = "vcodec";
+		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		sram = <&vpu_sram>;
+	};
+
 	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x00 0x04f80000 0x00 0x1000>,

-- 
2.25.1
