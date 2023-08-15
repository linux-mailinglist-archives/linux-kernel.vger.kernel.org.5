Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261177CD22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbjHONFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjHONF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:05:26 -0400
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 06:05:24 PDT
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBAFE7C;
        Tue, 15 Aug 2023 06:05:23 -0700 (PDT)
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by forward200b.mail.yandex.net (Yandex) with ESMTP id 58B2B6A59A;
        Tue, 15 Aug 2023 15:59:23 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:17a3:0:640:53a6:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id F26A4600E5;
        Tue, 15 Aug 2023 15:59:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3xeYJg5Wma60-F18sllHy;
        Tue, 15 Aug 2023 15:59:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692104357;
        bh=sgHEBJ/UfvG71gn4poD3opvIRRXcBrkFCebOtOAyTGY=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=a2ww5X+y/F8n/yRvaLidHJR47P0kSJQrGupng7h4WPPW1g3QWeDkcvRYHiIlrY2BL
         wRbxPrPazCnx30yPr5AJsXKyBlTEe7GHP1tb2l8YOsfcigGoK8QQY/evP+27J2LwyG
         C1DGCOZdypkAHfmlfMsh1aftWGLsloom3P19yJbM=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com,
        Muhammed Efe Cetin <efectn@6tel.net>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add sfc node to rk3588s
Date:   Tue, 15 Aug 2023 15:59:00 +0300
Message-ID: <b96e8d517d431d13eedd9c9606523076d72033bf.1692102057.git.efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692102057.git.efectn@6tel.net>
References: <cover.1692102057.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sfc node to rk3588s.dtsi from downstream kernel.

Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 5544f66c6ff4..a38a0158fce0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1424,6 +1424,19 @@ sata-port@0 {
 		};
 	};
 
+	sfc: spi@fe2b0000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xfe2b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		assigned-clocks = <&cru SCLK_SFC>;
+		assigned-clock-rates = <100000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sdmmc: mmc@fe2c0000 {
 		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe2c0000 0x0 0x4000>;
-- 
2.41.0

