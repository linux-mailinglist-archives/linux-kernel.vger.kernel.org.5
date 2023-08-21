Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81B2782D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjHUPse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjHUPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:48:33 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BFBFD;
        Mon, 21 Aug 2023 08:48:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:12ae:0:640:5b3c:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id DEE546005C;
        Mon, 21 Aug 2023 18:48:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7mKGOJgDamI0-Z1f7fceh;
        Mon, 21 Aug 2023 18:48:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692632907;
        bh=xFn7Cyu/7fJeQMrS8j7WfSw7yg5kq6A45q2hWGDSDCo=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=nIdrsfV13E+vQZMVffLIv3XWHUevWnXahqn2nliBUi7In5Ssd735kzm2pNCQwr8R5
         Yf4WB+wRrLJK747uV3SNbqn8PJISddHaHrg/TGzRTDaInf0jIUupzOGPRZ2cJLJAli
         2E1tyit67DB/4wf7yizbmjeefWfT+qUeDvfYcOjU=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com, jonas@kwiboo.se,
        megi@xff.cz, Muhammed Efe Cetin <efectn@6tel.net>
Subject: [PATCH v3 2/3] arm64: dts: rockchip: Add sfc node to rk3588s
Date:   Mon, 21 Aug 2023 18:47:58 +0300
Message-ID: <70557b7843994a57c6d3422e00643cb75a698d0b.1692632346.git.efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692632346.git.efectn@6tel.net>
References: <cover.1692632346.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sfc node to rk3588s.dtsi from downstream kernel.

Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 5544f66c6ff4..1a820a5a51eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1424,6 +1424,17 @@ sata-port@0 {
 		};
 	};
 
+	sfc: spi@fe2b0000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xfe2b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
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

