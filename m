Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6E7E1805
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjKEXhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjKEXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:37:32 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85110CF;
        Sun,  5 Nov 2023 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699227433; bh=lwv4Dikhxy25O18egd5yTFSrEBYSBkOsdKQ7nX6VsKs=;
 b=B7C6swaBQFQSIxCMkRIiHOtBleUZKdIuNo2E4XTTuN/gzYueGRE1ZeaOv+HRgNWXBBf56ElaN
 38OGuiOUwOu33WFXKYt41JrCY7IOPUd0ofskkRL79KrBTls+1Mgjj/3CNO0ay18GJMDHkfOBdwE
 A7vi2xuEVBD12dNes3m+gzgMPL1Vu5Dy/3F8ukT3RLSqquuq8nqWdYNNN0z6nCuukv/VIACGaOR
 dLgyOotKRuKkWMxufmSTIob2yP67zaRQr8h4nD/dbjF/aVQIGyqIrHmpMDXQSy2/oqV+y75Pz1b
 VOdrGLFRT1s6qX7f9WqavpexJa5Inwpc9row4kv5YuHQ==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] ARM: dts: rockchip: Add vdec node for RK3288
Date:   Sun,  5 Nov 2023 23:36:14 +0000
Message-ID: <20231105233630.3927502-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231105233630.3927502-1-jonas@kwiboo.se>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654827281b004d4cddbe0cab
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Bee <knaerzche@gmail.com>

RK3288 contains a Rockchip VDEC block that only support HEVC
decoding. Add a vdec node for this.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index cb9cdaddffd4..cdeb9c72dae1 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1277,6 +1277,21 @@ vpu_mmu: iommu@ff9a0800 {
 		power-domains = <&power RK3288_PD_VIDEO>;
 	};
 
+	hevc: video-codec@ff9c0000 {
+		compatible = "rockchip,rk3288-vdec";
+		reg = <0x0 0xff9c0000 0x0 0x440>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_HEVC>, <&cru HCLK_HEVC>,
+			 <&cru SCLK_HEVC_CABAC>, <&cru SCLK_HEVC_CORE>;
+		clock-names = "axi", "ahb", "cabac", "core";
+		assigned-clocks = <&cru ACLK_HEVC>, <&cru HCLK_HEVC>,
+				  <&cru SCLK_HEVC_CABAC>, <&cru SCLK_HEVC_CORE>;
+		assigned-clock-rates = <400000000>, <100000000>,
+				       <300000000>, <300000000>;
+		iommus = <&hevc_mmu>;
+		power-domains = <&power RK3288_PD_HEVC>;
+	};
+
 	hevc_mmu: iommu@ff9c0440 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff9c0440 0x0 0x40>, <0x0 0xff9c0480 0x0 0x40>;
@@ -1284,7 +1299,7 @@ hevc_mmu: iommu@ff9c0440 {
 		clocks = <&cru ACLK_HEVC>, <&cru HCLK_HEVC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-		status = "disabled";
+		power-domains = <&power RK3288_PD_HEVC>;
 	};
 
 	gpu: gpu@ffa30000 {
-- 
2.42.0

