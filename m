Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33938781ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjHTPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHTPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:50:26 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DBD1BE3;
        Sun, 20 Aug 2023 08:47:31 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id B1CB2605B4;
        Sun, 20 Aug 2023 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1692545512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xl/Xr1AYEB8pKmlNDvd2VVnVn8pANzbVbDszA4un1gQ=;
        b=th3qTgfFD3yL+mMx19zZzBzjkPzEfQONvx9weyw/T/jL3BhxHSSlp2k0LM7CfIRnbpk95g
        M7ABmp0r78vOopAbLMTbQbpB58pYi4ZfCctkHPNKwCrK96kMSeM0+tUVfPfTSF1s9W1s3L
        fQMl+ttO27oQkmBGb/ik4IUGj6gyT80=
Received: from frank-G5.. (fttx-pool-80.245.78.65.bambit.de [80.245.78.65])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 12CAD406A8;
        Sun, 20 Aug 2023 15:31:52 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/3] arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
Date:   Sun, 20 Aug 2023 17:31:33 +0200
Message-Id: <20230820153135.42588-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820153135.42588-1-linux@fw-web.de>
References: <20230820153135.42588-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 00bc8e6c-d91a-4620-80c0-866337966e05
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

All SFP power supplies are connected to the system VDD33 which is 3v3/8A.
Set 3A per SFP slot to allow SFPs work which need more power than the
default 1W.

Fixes: 8e01fb15b815 ("arm64: dts: mt7986: add Bananapi R3")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index af4a4309bda4..f9702284607a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -126,6 +126,7 @@ sfp1: sfp-1 {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c_sfp1>;
 		los-gpios = <&pio 46 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <3000>;
 		mod-def0-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
 		tx-disable-gpios = <&pio 20 GPIO_ACTIVE_HIGH>;
 		tx-fault-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
@@ -137,6 +138,7 @@ sfp2: sfp-2 {
 		i2c-bus = <&i2c_sfp2>;
 		los-gpios = <&pio 31 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <3000>;
 		tx-disable-gpios = <&pio 15 GPIO_ACTIVE_HIGH>;
 		tx-fault-gpios = <&pio 48 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.34.1

