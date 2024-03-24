Return-Path: <linux-kernel+bounces-113708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0988862A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B86D1F24B00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A586276;
	Sun, 24 Mar 2024 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5EFysCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B681DB41F;
	Sun, 24 Mar 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320693; cv=none; b=pOr3ig7XbUo1RjtSqcS/rexh3+ABqfgNjsD6gz94LI8hZuvR66jqnFp/1XeA70OuD3VTGzR+el5FdAcDeVo9+2oVfMMV2JA51Q7WrRfOe7su/ElkigEyOOu6Qa8tKJwEkz4/D15TZQW6ulr/DNilL7xE+vZZnz2mPxh5PQIgwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320693; c=relaxed/simple;
	bh=8AaEs2Sq3uwPfjgBGNCVId+9i+0GuIBA1mhuf3MjHLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNM0ZB6DV42UGgNJMwP2GXYIhJidd1rhIiz3brXk/pl28kuJATwxHFtHgPloTxzmBKEpi2XECO2EzZGq1DDb9akxXs4xN7ZhMfWCCq5eNstUhF3HgjTXWSguerne8HQKmbPjvOxycGX++5e8Z0aarXJ0IZQw6hUw6vxlOxt3T4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5EFysCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C898C433C7;
	Sun, 24 Mar 2024 22:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320692;
	bh=8AaEs2Sq3uwPfjgBGNCVId+9i+0GuIBA1mhuf3MjHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5EFysCH7wticDpK2X8H3gHlTJdAXgEBI/3r3eB8VMGcVTpvirU32FDruqJdvktUp
	 93rclCPrkQiaa55/LaO5M3rWfeHwt+TG5ZC8uCOJnQ39HpZ2bspnHlweW+27GJkvRV
	 DfoR9e8jE2xLonGHiDc9sHbpIP5LLHWrUYqZW1IH/c72jpUwF2mWHe/8AiDjfcDTxM
	 r/8N8fcrDCWe5p9wC54M3HTEULuoCwE2SrZQYz8cxS/CJyMR3qzXGfwR48nIQvPc7c
	 9z0f6F67b5MRn4Q5SND8kK+nCxM+M+BB4z9EEgoWThtGloNyFt+LVBBLo7/H5vOPfI
	 WN+eI1UH0A3ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 255/713] arm64: dts: mediatek: mt8186: Add missing xhci clock to usb controllers
Date: Sun, 24 Mar 2024 18:39:41 -0400
Message-ID: <20240324224720.1345309-256-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 1af98c3e53da5a8f627855cecd68b017e753ffd3 ]

The mtu3 usb controllers don't list the xhci clock, though they require
it, and thus rely on the bootloader leaving it on in order to work.

When booting with the upstream arm64 defconfig, the usb controllers will
defer probe until modules have loaded since they have an indirect
dependency on CONFIG_MTK_CMDQ, which is configured as a module. However
at the point where modules are loaded, unused clocks are also disabled,
causing the usb controllers to probe without the xhci clock enabled and
fail to probe:

mtu3 11201000.usb: clks of sts1 are not stable!
mtu3 11201000.usb: device enable failed -110
mtu3 11201000.usb: mtu3 hw init failed:-110
mtu3 11201000.usb: failed to initialize gadget
mtu3: probe of 11201000.usb failed with error -110

(and same for the one at 11281000)

Add the missing clock for the usb controllers so that they can
successfully probe without relying on the bootloader state.

Fixes: f6c3e61c5486 ("arm64: dts: mediatek: mt8186: Add MTU3 nodes")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20240213-mt8186-ssusb-domain-clk-fix-v2-2-1f981d35f3fd@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4fd25f0f313d2..84ec6c1aa12b9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1536,8 +1536,9 @@ ssusb0: usb@11201000 {
 			clocks = <&topckgen CLK_TOP_USB_TOP>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
-				 <&infracfg_ao CLK_INFRA_AO_ICUSB>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+				 <&infracfg_ao CLK_INFRA_AO_ICUSB>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>;
 			phys = <&u2port0 PHY_TYPE_USB2>;
 			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB>;
@@ -1601,8 +1602,9 @@ ssusb1: usb@11281000 {
 			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_HCLK>,
-				 <&clk26m>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+				 <&clk26m>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH 0>;
 			phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
 			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB_P1>;
-- 
2.43.0


