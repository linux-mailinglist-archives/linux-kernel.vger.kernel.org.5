Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFA7CA31E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjJPJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjJPJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:00:55 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2E110;
        Mon, 16 Oct 2023 02:00:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D21C1FF809;
        Mon, 16 Oct 2023 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697446847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U2Vlzghfoo774zsU4ZxMClCDoCsWFp/EPSf+mUw5k4=;
        b=LagqZu5LS7LeKgaZjdbuW3+VQtomTg9zDQpJooDgVRjqRzS1DY3UfD5rBcXDsWswJAmIbH
        kCXVSZz5VDP0wMtZisDgZrgaIbC+uOrWqmODoPnI8Kv7wdBvO3BAlUEhPTJsHT0Tu5Qzhp
        vpbJaCa+0Yt1/vAO9jJ6pQ+OEymR4GXQv7uGi8kFtWTUrYCEuL/i/OgT14j9usOcrNBek2
        f0OwZETwJ9sPVm/MsgNRjclE/01PnNgWv5VgYcS/6nZ/oBwDCWaI1n3YuAnTGK7e9tJ+5j
        96Q9LqiIz/ovImlydJdZynYJDFHFqXIy5VHTvkJrHxQfvmHPAOL7bhCjA21AKQ==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v8 3/3] arm64: dts: rockchip: Add the camera interface
Date:   Mon, 16 Oct 2023 11:00:05 +0200
Message-ID: <936393d5f2d4b583efbb1ac81f21e8d41fb452cb.1697446303.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697446303.git.mehdi.djait@bootlin.com>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PX30 has a camera interface, supporting CSI2 and BT656
modes. Add a DT description for this interface.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 42ce78beb413..7aaa88a15d07 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1281,6 +1281,18 @@ isp_mmu: iommu@ff4a8000 {
 		#iommu-cells = <0>;
 	};
 
+	vip: vip@ff490000 {
+		compatible = "rockchip,px30-vip";
+		reg = <0x0 0xff490000 0x0 0x200>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
+		clock-names = "aclk", "hclk", "pclk";
+		power-domains = <&power PX30_PD_VI>;
+		resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+		reset-names = "axi", "ahb", "pclkin";
+		status = "disabled";
+	};
+
 	qos_gmac: qos@ff518000 {
 		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff518000 0x0 0x20>;
-- 
2.41.0

