Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22557E9E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjKMO1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:27:08 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498BE10E5;
        Mon, 13 Nov 2023 06:27:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C9EF1C001D;
        Mon, 13 Nov 2023 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699885623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSePrEltdrZVOTvOhxdlRrK/qcL9Ks2P2izMU5tje1Y=;
        b=JKEFIsKBpS7AxZ3+kCpMqv8P5Lm/HTtIKtvBs8c7H0q2fKGbGECmfrHKImDfvuhobhcZ1u
        Gev9AUbdxWIBRLqbHb9k+OlVwvxQ+DY57PY32FuoA6asoyuyGrY/3aU1cw9zXPwh40A6Fl
        GkGACM+hTd3rwNT/kPle3JVOlWyYr2W7uGhaaJ0LHKZIJRVeUdOzSgyQm4/QJvm8+TYPlJ
        6zPY419LPYhfOWk8JRyDs1PWuCrxJXCxFtTxK1QPgkK2j2S5NxvA9kO5dbHI6Fl56yOGMF
        IXVctc1Up4doHSAd2pWgQRfsBDo87v3jFFRcn3Zy/HQI2ZibhVwnDVX29lxXVg==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 13 Nov 2023 15:27:01 +0100
Subject: [PATCH 6/6] arm64: dts: ti: k3-j7200: use J7200-specific USB
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231113-j7200-usb-suspend-v1-6-ad1ee714835c@bootlin.com>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
In-Reply-To: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On our platform, suspend-to-idle or suspend-to-RAM turn the controller
off thanks to a power-domain. This compatible triggers reset on resume
behavior to reconfigure the hardware.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 709081cd1e7f..581905d9199e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -788,7 +788,7 @@ pcie1_ep: pcie-ep@2910000 {
 	};
 
 	usbss0: cdns-usb@4104000 {
-		compatible = "ti,j721e-usb";
+		compatible = "ti,j7200-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
 		dma-coherent;
 		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;

-- 
2.41.0

