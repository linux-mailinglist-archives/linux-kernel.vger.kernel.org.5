Return-Path: <linux-kernel+bounces-63761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FF85342A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F39B27306
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421D5FF03;
	Tue, 13 Feb 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FMdph/Tf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7505F876;
	Tue, 13 Feb 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836571; cv=none; b=eaPtO0qApNa2UbP2Xs4HLS9c7se2lgjUMYZ3BT4LlaorBD00n6PnPSSDvLk6RxW5lVbrgTTHEPVvSKnoPL3swAKKIcoMDfmmM0hUWj6hHqQBppE7RpG7xfns36Vbs8ARNgYS9zmpe0D73nIlW6zRXK4boQOntqy2ZWWbInSRduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836571; c=relaxed/simple;
	bh=H/NS1wz5MszGxQxdUf73HQI/xDuCHCwLKSnrFRWGIE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhDzt0GRwqzXEbxLnVFvdYRXnqcOcg03CXjSaIDxLVptSrShg721wqldhe5LrVNBjdSR77/1i/uuZjKb66DKOh94dizIZpDKgIPefwZ8AHy7R3kpuI/dNDGbjGz7peVu+chmS/zLkmV3UHUYYpa6JhIOPqWi8MvRQ9XnaMZnqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FMdph/Tf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707836568;
	bh=H/NS1wz5MszGxQxdUf73HQI/xDuCHCwLKSnrFRWGIE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FMdph/Tfazefc6tQLDDjsOyJotzmOHrI6PRjS2Bqoj6POtkSkpRtye/VeeT74A6jo
	 p2sxF4JcUa8uEAky/PuFY2s21pYfCa5HJhToGfcjS76/WxG8gXE5D3WMCGj0pBH7PD
	 XUBtyMx6D4/rJ8uSs70pIjoviTtbcPvg9SEPQtBvSLohHODJjlJDkv/N6++vv8QIXa
	 i1XVleHx6KfY+IrfXguG/4Tm0B1/T6AzFShqGQpMU0bgU94qoDERMDh7pLVUdTseD0
	 jcDteJKEwVYFwx659jVHVGlzrzG3TOvF4jJyOMCRJv+O7JxAzK0RSJ5nbusjnkpaRV
	 ATrSs9tl2f9cg==
Received: from [192.168.1.42] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B12B63782074;
	Tue, 13 Feb 2024 15:02:45 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 13 Feb 2024 10:02:38 -0500
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8186: Add missing xhci
 clock to usb controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240213-mt8186-ssusb-domain-clk-fix-v2-2-1f981d35f3fd@collabora.com>
References: <20240213-mt8186-ssusb-domain-clk-fix-v2-0-1f981d35f3fd@collabora.com>
In-Reply-To: <20240213-mt8186-ssusb-domain-clk-fix-v2-0-1f981d35f3fd@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

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
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index e0e5721d6b53..8c55b7225cf6 100644
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


