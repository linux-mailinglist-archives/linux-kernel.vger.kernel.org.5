Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09E87E1806
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjKEXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjKEXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:37:35 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4010F4;
        Sun,  5 Nov 2023 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699227437; bh=o5ziTLSsHO2+zMABFhPKuCD5zrXCPdvx5uCAiQ5gwDc=;
 b=sXgR1cliebbC1WiVmU0GCDa3yRVGCBFosbu0l2DwtxPUP0+wMUSdsxgsCagP9xJCnzbjVFfHY
 ZmL5diGzo0QkFZp6d2Pbe7EqUkhjkxoT3YsA2OXwuWfuANq0UE+zwnr54474rPH58jixfgfl1SE
 BYcFHOfy2ah5N1JbuTLm7E6zPIUh8/138aaK3JZk5XxssK25S4AGdQjyRpIA0MqCTxbGAHtmYtk
 ITZp83hCkHwfU0rdy8HPq3pnKJh/Ht3v5u9pZ5dDUblu6F9Itf5uXLfyAI5QgrtXUa8rB4n84ri
 PwpYksBnHqKKwWl1d1yw1qjx11/AW36TftKrn7XgOPEA==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] arm64: dts: rockchip: Expand reg size of vdec node for RK3328
Date:   Sun,  5 Nov 2023 23:36:15 +0000
Message-ID: <20231105233630.3927502-9-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6548272d1b004d4cddbe0cb8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the reg size for the vdec node to include cache/performance
registers the rkvdec driver writes to.

Fixes: 17408c9b119d ("arm64: dts: rockchip: Add vdec support for RK3328")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index e729e7a22b23..cc8209795c3e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -668,7 +668,7 @@ vpu_mmu: iommu@ff350800 {
 
 	vdec: video-codec@ff360000 {
 		compatible = "rockchip,rk3328-vdec", "rockchip,rk3399-vdec";
-		reg = <0x0 0xff360000 0x0 0x400>;
+		reg = <0x0 0xff360000 0x0 0x480>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
 			 <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
-- 
2.42.0

