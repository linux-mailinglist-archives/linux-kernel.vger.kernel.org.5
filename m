Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78BE7DB9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjJ3MZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJ3MZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:25:29 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B2C9;
        Mon, 30 Oct 2023 05:25:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01B14C000D;
        Mon, 30 Oct 2023 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698668724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O38TB7h/YzOAey2sGfW287IT4IVL6B3BrPOAPkm8UIo=;
        b=MCHa1e6znpDzXz2tB9Ujs0sd4lWbONa2wh6T8PvtdDHTzLHFj2qlDnAKIrou2OuP/Br4LW
        zAqwxVD9YMxo21Wqq+CPwBNwb/ITm5qIJYvUlRYpXu4FXeKzZWcRxd5Ak5TAEHHeQfIE8h
        fLT8CafGbdgI/z0WZ5lG5HLHMMK8O+psXFzcS8JMB/2jLzhvTr+9XdZtxlzEMtI4ct8/4e
        3JbRpNr/ID6M6cma5pFlZRMyBTBJfJnjFZjxJjtNQMgo5rA/qSKJsriod+/yqONtSw0nyb
        47TL+xdkp0Z0bSR8MLImyH3BbhrtDWAkj8Hs9aw02PCnSgKw0VyliqGiZ3jQpw==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v9 3/3] arm64: dts: rockchip: Add the camera interface
Date:   Mon, 30 Oct 2023 13:25:14 +0100
Message-ID: <022988cdb104c01587f1abd3105f7c9a20b1f1c5.1698666612.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1698666612.git.mehdi.djait@bootlin.com>
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PX30 has a video capture component, supporting the BT.656
parallel interface. Add a DT description for it.

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 42ce78beb413..3a4e859e5a49 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1281,6 +1281,18 @@ isp_mmu: iommu@ff4a8000 {
 		#iommu-cells = <0>;
 	};
 
+	cif: video-capture@ff490000 {
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

