Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D17D6702
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjJYJif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:38:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35347CE;
        Wed, 25 Oct 2023 02:38:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C8D5966071C9;
        Wed, 25 Oct 2023 10:38:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698226709;
        bh=ZrAdIgYw0YdPdTX7tItDF5DGAV3QupHqDDWzmNm1c+c=;
        h=From:To:Cc:Subject:Date:From;
        b=EhfPYNC3T4Ms23Bb5R5utO6DTa+B1SQAOTbXoR8CVO3FmUBTc3XdlwGhViTjyvpVT
         QpMUqAvl77CKwtxzmoNF2QBw+YY/EkHnerpKFbJ9Uzrcd1gsExqWDPytB1EcdvqKmu
         nFNZXOzldsNOuzweFKFPHt5gXDzWnikp+G4dF0GkQ8I7lv0ByFzNiKlY2l9lrhvtC2
         m0H806Mds/D3QD6Dg1unFBQZ2FkJPf0NJnYoYseVoVPPfI162tAghcfJ6n7LxiOASI
         vxZJ6nBT8j6mJ/S5QiFeAoNGTwcO9B2uaYugUFePyc/CmuK8A23U+pO9CJlTej0/H7
         wZfymARrR2Jeg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     hsinyi@chromium.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, erin.lo@mediatek.com,
        eddie.huang@mediatek.com, pihsun@chromium.org,
        fparent@baylibre.com, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, michael.kao@mediatek.com,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/8] MediaTek ARM64 devicetrees fixes and improvements
Date:   Wed, 25 Oct 2023 11:38:08 +0200
Message-ID: <20231025093816.44327-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some cleanup and adds some fixes to the MediaTek
ARM64 devicetrees.

In short:
 - Changes all instances of interrupt-parent = <...>; interrupts = <...>
   to one single interrupts-extended = <...> line
 - Moves interrupts from MT6358 dtsi to board files (as those are board
   specific, not PMIC specific!)
 - Fixes various devicetree warnings

AngeloGioacchino Del Regno (8):
  arm64: dts: mediatek: mt8183: Use interrupts-extended where possible
  arm64: dts: mediatek: mt8173: Use interrupts-extended where possible
  arm64: dts: mediatek: Use interrupts-extended where possible
  arm64: dts: mediatek: Move MT6358 PMIC interrupts to MT8183 boards
  arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory
  arm64: dts: mediatek: mt8183-evb: Fix unit_address_vs_reg warning on
    ntc
  arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
  arm64: dts: mediatek: mt8183: Move thermal-zones to the root node

 arch/arm64/boot/dts/mediatek/mt6358.dtsi      |   2 -
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   3 +-
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |   3 +-
 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   9 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |  24 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts   |   7 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   8 +-
 .../mediatek/mt8183-kukui-audio-da7219.dtsi   |   3 +-
 .../mediatek/mt8183-kukui-audio-ts3a227e.dtsi |   3 +-
 .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |   3 +-
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |   3 +-
 .../mt8183-kukui-jacuzzi-fennel-sku6.dts      |   3 +-
 .../mt8183-kukui-jacuzzi-fennel-sku7.dts      |   3 +-
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     |   3 +-
 .../dts/mediatek/mt8183-kukui-kodama.dtsi     |   3 +-
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |   3 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  12 +-
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |   4 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 242 +++++++++---------
 .../dts/mediatek/mt8395-genio-1200-evk.dts    |   6 +-
 20 files changed, 165 insertions(+), 182 deletions(-)

-- 
2.42.0

