Return-Path: <linux-kernel+bounces-62398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7747851FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B621C225F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C084CE02;
	Mon, 12 Feb 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eFEm9K9Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5474EB43;
	Mon, 12 Feb 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773589; cv=none; b=VaPtDwbx6rP5mj7HYz1Ed3bFQu8iTPlWP0KRo6fldS3wtGxbggeo89Mh03ClcfNQP4Mce95zZVa8i+AqOjwd3K0aQwoZkJE1JdMNQfzGwy/mFXcNuPZAfEnOOfr1NmTdct6/xIEbEW0CSNT59ZBIMuTVdWpNqznr7g6K6Q++o14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773589; c=relaxed/simple;
	bh=uL2VF2cuPmkBo5+K9BYWgnyBPmjt/fB97ck51Phazr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D8mIM9d8RxT/0yRcm1MyxM3HnN0nnYmhUWIRFqQWkw7gWQlguIky7gbZC0dxz7+C8X0QCgRt8fC7bu6iIkPsJczwRA8V6qJbdkASeB4qA8Aw6TUO+4e2ztXhXv1UjbWxeOpWs6O4axWzNf+1qu2o/y5ysr9a+iCX53+ffCPB6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eFEm9K9Q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707773584;
	bh=uL2VF2cuPmkBo5+K9BYWgnyBPmjt/fB97ck51Phazr0=;
	h=From:Date:Subject:To:Cc:From;
	b=eFEm9K9QpelSO+d7WVm/xhJd8+qlJVpl+tnlGZsb8vckGa1tyIHVKBBxNBVdg5h3g
	 3xn2YJbATiyjnp+W1pamAs+m/yX7gjozx61rrNayDWpJYrw3Mm+FAxyt0f8gSibUTl
	 qiGnQfhI+E8SQMHzYAK+vBlQHnYB7bbVTYnW9KGqXIytwVtQnB045arzq3sWOmOPKf
	 +CP8ZGVO7vSS1mcVCImsZCKPeOTOOYrmVnN74ekEC0A65d7GaICBVkMBcLCKWe5rb4
	 F3i/YS4CiM3Sm0Ddj0/LX3jrrkpA3LtymZwNI9RTJ2/HmANT99dOlTnnyrZmWQzK8R
	 a1cANRtoq1K7Q==
Received: from [192.168.1.38] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9619237813D5;
	Mon, 12 Feb 2024 21:33:01 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 12 Feb 2024 16:32:44 -0500
Subject: [PATCH] arm64: dts: mediatek: mt8186: Add missing clocks to ssusb
 power domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-mt8186-ssusb-domain-clk-fix-v1-1-26cb98746aa3@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHuOymUC/x3MQQqDMBBA0avIrDuQRJHUq5QuYjLRoRpLRkUQ7
 25w+f7inyCUmQS66oRMOwsvqUC/KvCjSwMhh2IwyjTKaIPzarVtUWSTHsMyO07opx9GPtC1b03
 kbd3EAOXwz1Tyc/98r+sGwYRV3W0AAAA=
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

The ssusb power domains currently don't list any clocks, despite
depending on some, and thus rely on the bootloader leaving the required
clocks on in order to work.

When booting with the upstream arm64 defconfig, the power domain
controller will defer probe until modules have loaded since it has an
indirect dependency on CONFIG_MTK_CMDQ, which is configured as a module.
However at the point where modules are loaded, unused clocks are also
disabled, causing the ssusb domains to fail to be enabled and
consequently the controller to fail probe:

mtk-power-controller 10006000.syscon:power-controller: /soc/syscon@10006000/power-controller/power-domain@4: failed to power on domain: -110
mtk-power-controller: probe of 10006000.syscon:power-controller failed with error -110

Add the missing clocks to the ssusb power domains so the power
controller can boot without relying on bootloader state.

Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index adaf5e57fac5..02f33ec3cbd3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -931,11 +931,19 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
 
 				power-domain@MT8186_POWER_DOMAIN_SSUSB {
 					reg = <MT8186_POWER_DOMAIN_SSUSB>;
+					clocks = <&topckgen CLK_TOP_USB_TOP>,
+						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
+						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
+					clock-names = "sys_ck", "ref_ck", "xhci_ck";
 					#power-domain-cells = <0>;
 				};
 
 				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
 					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
+					clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
+						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
+						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
+					clock-names = "sys_ck", "ref_ck", "xhci_ck";
 					#power-domain-cells = <0>;
 				};
 

---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240212-mt8186-ssusb-domain-clk-fix-a691eec834fd

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


