Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93177D721C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjJYRJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJYRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:08:51 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241C183
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:08:46 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 305336264B;
        Wed, 25 Oct 2023 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1698253724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70qdNXbgp7mMO78/SPuLeWZa4xfLIughW1Q+g0cjqr0=;
        b=NSf1eKQaOyAzpcKZ6qbk7UroE2dniPWMCSzt4J5Q+8XsuVI1Gp19jh/UWX2fOcfndOVZAN
        3r48n5dvmPqh4tJo+gVR7Eekj6zmRjUM4dMX1uBKkp1G2h3BTIajHHVpQ4QPXYlV1X0twm
        z2waVg0YfD85CvzFaJw6hD0MZ9Ugkeg=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 8B60F3607E4;
        Wed, 25 Oct 2023 17:08:43 +0000 (UTC)
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
Subject: [PATCH v2 2/5] arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
Date:   Wed, 25 Oct 2023 19:08:29 +0200
Message-Id: <20231025170832.78727-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025170832.78727-1-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 55a383b4-c02b-4178-bc07-5f480166bd68
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

