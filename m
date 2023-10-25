Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF117D721E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJYRJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjJYRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:08:53 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C511111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:08:51 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 7A26362673;
        Wed, 25 Oct 2023 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1698253725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZcR70W2aaviUYh6DeqIY7yeaQVzt5WB1qm/b2mX/Og=;
        b=ABCXw35oowNiQDqR+e1jhWA3UGJmLRmFRVrljB5wCfYAyjykl375M+OQv+/DcBAeTyviCU
        QoaCWiTIbBoJnxnfHf+mNaoOhbA3kWagcQpqZYh3tfpg4Ra/K//er97q4mpa8q4Au/9orh
        PPeZix8FitLSng9njIXRNsCM/OlUbn8=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id CE3F73607E4;
        Wed, 25 Oct 2023 17:08:44 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 4/5] arm64: dts: mt7986: add dtbs with applied overlays for bpi-r3
Date:   Wed, 25 Oct 2023 19:08:31 +0200
Message-Id: <20231025170832.78727-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025170832.78727-1-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: cc576bb0-6b33-412d-8270-f0ec18aa8843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Build devicetree binaries for testing overlays and providing users
full dtb without using overlays.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=q=EYjUdjE1_8g1MKtvw3vVzx5A@mail.gmail.com/
https://lore.kernel.org/all/CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com/

v2:
make full dtbs multiline for better readability
---
 arch/arm64/boot/dts/mediatek/Makefile | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c99c3372a4b5..24eeba0703ce 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,11 +8,33 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
+
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
+mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-emmc.dtbo \
+	mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
+mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-emmc.dtbo \
+	mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
+mt7986a-bananapi-bpi-r3-sd-nand-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-sd.dtbo \
+	mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
+mt7986a-bananapi-bpi-r3-sd-nor-dtbs := \
+	mt7986a-bananapi-bpi-r3.dtb \
+	mt7986a-bananapi-bpi-r3-sd.dtbo \
+	mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
+
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
-- 
2.34.1

