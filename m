Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3D782F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjHURMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHURMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:12:30 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B699B1;
        Mon, 21 Aug 2023 10:12:28 -0700 (PDT)
Received: from p200300ccff3fc7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff3f:c700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qY8Ro-002tQX-2y; Mon, 21 Aug 2023 19:12:12 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qY8Rn-002KPw-2b;
        Mon, 21 Aug 2023 19:12:11 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        andreas@kemnade.info, u.kleine-koenig@pengutronix.de,
        Jonathan.Cameron@huawei.com, linus.walleij@linaro.org,
        heiko@sntech.de, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen rotation
Date:   Mon, 21 Aug 2023 19:11:51 +0200
Message-Id: <20230821171151.555091-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821171151.555091-1-andreas@kemnade.info>
References: <20230821171151.555091-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display is in landscape orientation, but the touchscreen is in portrait
orientation. Specify that properly in the devicetree.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
index 815119c12bd4..5636fb3661e8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
@@ -141,8 +141,10 @@ zforce: touchscreen@50 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		vdd-supply = <&ldo1_reg>;
 		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-		x-size = <1072>;
-		y-size = <1448>;
+		touchscreen-size-x = <1072>;
+		touchscreen-size-y = <1448>;
+		touchscreen-swapped-x-y;
+		touchscreen-inverted-x;
 	};
 
 	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
-- 
2.39.2

