Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1754B7FA0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjK0NUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjK0NUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:20:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD3AA;
        Mon, 27 Nov 2023 05:20:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A30DB6605835;
        Mon, 27 Nov 2023 13:20:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701091236;
        bh=U01xvbnT/mSsl9CGN0alnznWYP0QePGrsCETHRIiTB4=;
        h=From:To:Cc:Subject:Date:From;
        b=DRB86tVsQiup4pC8UN6u1wD8FXSHJ//4EtVEPAwxTpM22gF7N3A1WCZ+Z57IBi2O0
         THwGKGvoPlzoQZfkdA/T12FKzYzyt4COlrN1vXp5XysOIcfCZtqQjGJvELWCRo/tzM
         9b/lLu+jrKDEK3zDIa5ZJmFnoi5B8nSP4XguLRaHB4iaRMAgDjsAkl7HdrSL93vnY/
         v+aLaFJ3VVeIYCIGduNIGaLp3B5RrBHkzFtJluoB5yLgwZwESxGIvP2yfTzit2sTNc
         Ym0hgd7va6OZhKdtHD19UcPfTssfc6GZ5+bpUoOKgUokORYvNA8MC8A/wNMWIgRar5
         glZwXeWUSjluQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com
Subject: [PATCH] arm64: dts: mediatek: cherry: Fix interrupt cells for MT6360 on I2C7
Date:   Mon, 27 Nov 2023 14:20:26 +0100
Message-ID: <20231127132026.165027-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change interrupt cells to 2 to suppress interrupts_property warning.

Fixes: 0de0fe950f1b ("arm64: dts: mediatek: cherry: Enable MT6360 sub-pmic on I2C7")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 9d0f3d25cb07..ecc7a96ae358 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -466,7 +466,7 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 
 	pmic@34 {
-		#interrupt-cells = <1>;
+		#interrupt-cells = <2>;
 		compatible = "mediatek,mt6360";
 		reg = <0x34>;
 		interrupt-controller;
-- 
2.42.0

