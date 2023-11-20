Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E17F1956
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjKTRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:06:17 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202EDBE;
        Mon, 20 Nov 2023 09:06:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34272E000B;
        Mon, 20 Nov 2023 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700499972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psIdhG1r0J8G800d6Izk2n63b31U1ZZAZ9rXUyFBS5Q=;
        b=YSyItrHfbf+k8A4+8SzdiVoIgRTSJ9p7kJOCB82WPphGJs2ktpIZ9muRi7YGvMKk/5vBFk
        cd1VSLoR04Brb/ycw4nBEnHaLH0eEjz50Y1/HTU8EOn/2ft/JelSmEZ4wkrTXprO25PVm3
        /2SAU2ms060NioPTmpfGRnBgGQl1IDmAo/16epU7YcXywLS1o8IVTMYJbJCakl0RFTt5nx
        GTm4x0N4wd4SOKhp08d7PdVEg0sSHaNZbURoNnzs28vFVWneK/aCWjNllBNuDUTGLkOGoy
        1t5NiUl5Cv+BhYm6iXIwQ4Uufu7w54KUxdxxRTV/CVgGMMYggEojlueU63zNvQ==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 20 Nov 2023 18:06:07 +0100
Subject: [PATCH v2 7/7] arm64: dts: ti: k3-j7200: use J7200-specific USB
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231120-j7200-usb-suspend-v2-7-038c7e4a3df4@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
In-Reply-To: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
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
        "Thomas Petazzoni thomas.petazzoni"@bootlin.com,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On our platform, suspend-to-idle or suspend-to-RAM turn the controller
off. This compatible triggers reset on resume behavior to reconfigure
the hardware.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 709081cd1e7f..52c4ee0fa334 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -788,7 +788,7 @@ pcie1_ep: pcie-ep@2910000 {
 	};
 
 	usbss0: cdns-usb@4104000 {
-		compatible = "ti,j721e-usb";
+		compatible = "ti,j7200-usb", "ti,j721e-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
 		dma-coherent;
 		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;

-- 
2.42.0

