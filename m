Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F97E2C80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjKFS56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:57:57 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C7BB;
        Mon,  6 Nov 2023 10:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=x0KdJV1T5bwu5vuWgfbzxKBUcidqlaq+cthXaDBuzok=; b=H1Hra38O3Zm+m9TWfOFNzqgNhY
        FXJ5HiNpAB0PHcU7xEe4Zc5hGuOs0fNPSpW3lYJEjU6qONoxdgM3nvJ49TnTqO8KHGvr5PJZfaxFB
        gvIRs4cdddEk/F29yYazWGVCGkafQij+Y8jRCLiU0f4YjkFl4sfUoRcdmOwl04XSS02I=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37940 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r04n5-0005zO-OZ; Mon, 06 Nov 2023 13:57:40 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon,  6 Nov 2023 13:57:36 -0500
Message-Id: <20231106185736.668966-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH] arm64: dts: imx8mn-var-som-symphony: add vcc supply for PCA9534
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The following warning is shown when probing device:

    pca953x 1-0020: supply vcc not found, using dummy regulator

Add fixed 3.3v regulator as vcc supply to silence the warning.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index a7a57442cb81..583b9859df3a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -79,6 +79,7 @@ pca9534: gpio@20 {
 		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 		#gpio-cells = <2>;
 		wakeup-source;
+		vcc-supply = <&reg_3v3_fixed>;
 
 		/* USB 3.0 OTG (usbotg1) / SATA port switch, set to USB 3.0 */
 		usb3-sata-sel-hog {

base-commit: d2f51b3516dade79269ff45eae2a7668ae711b25
-- 
2.39.2

