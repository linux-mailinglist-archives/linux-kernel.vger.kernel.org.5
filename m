Return-Path: <linux-kernel+bounces-114176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF848888DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8231C2777E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB7249F2F;
	Sun, 24 Mar 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKq7VpeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23D2062F2;
	Sun, 24 Mar 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321499; cv=none; b=P29kcCbS+7j8mkX4zAo7x8ZMpEK7BKuyrs6hEyWpQ1/NJgOMqRtbVQQO11PlKVrdm+3zJJJ65bOs2jeGaIsfyjBO3qP8Y6VEvL6MnqHpTV+WuD/4JQa+P/tlUTyDq+GpvVdSzIpcveIAPIhy+CX0FYLT7MF9lzeepx1MnfSQR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321499; c=relaxed/simple;
	bh=8AaEs2Sq3uwPfjgBGNCVId+9i+0GuIBA1mhuf3MjHLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0yU6NgWVrpnzbhv0Gw3md/72FXYQ5LcusgyCkWZX1BQ9g0NeQbz8CZZOWs6K+WMc/WZqVC0di9RGQuar6bJqeX5vMflG2d4OOeVKiTqPPBu02cOK2B4gkY3auPoIxW4F2bKb4AB828f/cZqumXLpADjSaEAsFrbVwaxgVU7E2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKq7VpeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D9C433C7;
	Sun, 24 Mar 2024 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321498;
	bh=8AaEs2Sq3uwPfjgBGNCVId+9i+0GuIBA1mhuf3MjHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKq7VpeRBODDX4tbfwx/53A0yU3JQv/EdtRFLkmP/5tBjpZ9SaWBuHof9HCmN0xZd
	 ZoYQVHZSas5LVntA2BKfjoblywvp6b07H/cEpSa0Dnef//UVID748OVOBgc5+qcLsl
	 +9MA7b6cZYcpNOeG28YcTR4OiJInBOcQcL2XP9rD1P3BY09U8qB20h1aSS7IugIoWp
	 OJsmi5Mw3hy2WRScBro6fP/RiaHjPo+5sJKjXVGsb4oqaqYeN7RSwwG2KRRVSTVy3o
	 bYOB6y3yKHCR0VoGoDSK6B6qyqAWcfk3fdDXWYHF3RG51vFCylLIENYqpNVf+WGsdF
	 T/9/ubuZP67mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 223/638] arm64: dts: mediatek: mt8186: Add missing xhci clock to usb controllers
Date: Sun, 24 Mar 2024 18:54:20 -0400
Message-ID: <20240324230116.1348576-224-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


