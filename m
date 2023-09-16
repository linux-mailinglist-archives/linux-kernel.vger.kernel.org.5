Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123597A2ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 10:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjIPI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIPI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 04:28:53 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F73219AE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 01:28:47 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 12D484027B;
        Sat, 16 Sep 2023 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1694852925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GVGLP4sXCvXg67LcRpaaAYteUCW2+dlenIoOw/S7NEc=;
        b=h8DlS+6G8clN/LvlYe8pYU3APP7sNw6fo5lqRAjbqBYTXVzpZjX+KIXom+yoT+50/B+py+
        1HCLy54GEq5WMymZF8AqVeR2+N8xHBVydZ/sQT8cvfNYvvwyT4QSVkZeGZ6pcs6WakCmeC
        Tynzs7pUVbYo7YD+uNVUXViMRlvgWN8=
Received: from frank-G5.. (fttx-pool-217.61.145.236.bambit.de [217.61.145.236])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 3A1A54062D;
        Sat, 16 Sep 2023 08:28:44 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: 
Date:   Sat, 16 Sep 2023 10:28:40 +0200
Message-Id: <20230916082840.6967-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d2233f37-f5ce-463b-884b-b3c514ac7b50
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Subject: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays for
 bpi-r3

Build devicetree binaries for testing overlays and providing users
full dtb without using overlays.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
based on discussion here:
https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=q=EYjUdjE1_8g1MKtvw3vVzx5A@mail.gmail.com/
https://lore.kernel.org/all/CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com/
---
 arch/arm64/boot/dts/mediatek/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c99c3372a4b5..18be027bf6b4 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -13,6 +13,14 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
+mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := mt7986a-bananapi-bpi-r3.dtb mt7986a-bananapi-bpi-r3-emmc.dtbo mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
+mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := mt7986a-bananapi-bpi-r3.dtb mt7986a-bananapi-bpi-r3-emmc.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
+mt7986a-bananapi-bpi-r3-sd-nand-dtbs := mt7986a-bananapi-bpi-r3.dtb mt7986a-bananapi-bpi-r3-sd.dtbo mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
+mt7986a-bananapi-bpi-r3-sd-nor-dtbs := mt7986a-bananapi-bpi-r3.dtb mt7986a-bananapi-bpi-r3-sd.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
-- 
2.34.1

