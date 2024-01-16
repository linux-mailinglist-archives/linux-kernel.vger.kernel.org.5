Return-Path: <linux-kernel+bounces-27969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679982F87B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079A51F264F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A31339A2;
	Tue, 16 Jan 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ps4JSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE513398C;
	Tue, 16 Jan 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434704; cv=none; b=ByiALo4V7qp+8j1unNOrc4eDlShgc23KdG4kZ6daDxdC7bRnmKmkmzoiS9C5MrFgLr8yNDikKUeJxymOYGSrrsyCSTY+6MBU42n81tAFuosIv9ag1hlPfovByeo2nm6ZAOXH0V+Z20RMuMbatV045+ehTO95E5vsc3M2jE97G6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434704; c=relaxed/simple;
	bh=PRZN9YTZt/ZgWb3fRzdwcprIRBSH4482/juVxFqgRk4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=DqhdDCWtrf2yKIGaI1u/44EnGRod/mppykhAnlWC2zkvWI3m3FsfRr1atpP0p0HqPW+92sWpRtLlVCrwj+GsXOGBvCfA0BiDUyqHBhtovcmhECHRfVZZOiake50F9N4+VuFLxdFnR3llVwgQ7H8LD3c9TibbCDtohCPtebntHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ps4JSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBE0C43394;
	Tue, 16 Jan 2024 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434704;
	bh=PRZN9YTZt/ZgWb3fRzdwcprIRBSH4482/juVxFqgRk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/ps4JSBsB8bcp+CuHOd0jbsdnHhdThoS2opLiRo508Y+KP2chxeX1PhbLbPwKrRV
	 zaKHjzTuI5hnR5ivJ0svlT3VpeINFn6/6KUnvo7b6l0OU0yCy/fb6R3ZshaBTLc8CD
	 n+WhYeqS4Zd4eykP2/y6FkKgPogOyF4Q71f6t2N11DRJlNi/Wsr6wMQEhC0oEewue5
	 a03KIphNolu1mAP7cXQiRWaY4sqkb8/4OVgvcHSRR5nCCd237MXx2e8RENQcUFAQ3O
	 UXPxa5Fu7m5oX4yZZHTTozDddU+7J8Xuq/kwwv0/3htivmRbdT5qarANmLw/1SfI4A
	 FwW3Cu/Ql1BgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 058/104] ARM: dts: imx1: Fix sram node
Date: Tue, 16 Jan 2024 14:46:24 -0500
Message-ID: <20240116194908.253437-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit c248e535973088ba7071ff6f26ab7951143450af ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

The node name should be sram.

Change the node name and pass the required properties to fix the
following dt-schema warnings:

imx1-apf9328.dtb: esram@300000: $nodename:0: 'esram@300000' does not match '^sram(@.*)?'
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx1.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx1.dtsi b/arch/arm/boot/dts/nxp/imx/imx1.dtsi
index e312f1e74e2f..4aeb74479f44 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx1.dtsi
@@ -268,9 +268,12 @@ weim: weim@220000 {
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


