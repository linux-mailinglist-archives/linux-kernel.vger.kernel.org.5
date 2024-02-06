Return-Path: <linux-kernel+bounces-55296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EBC84BA8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AF81C2359A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C5134CF5;
	Tue,  6 Feb 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="ERIDsCH8"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC113475E;
	Tue,  6 Feb 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235397; cv=none; b=GIpYMvaRBcBFzgqfIRr6kO+toG2VhyfhhgDp3rEypTj2Ho7Ci0qcg9SqYa1fa4ztddy9HN/XscHnMXqeBkdnFahTaXDns5645U6mgR4Cl/ZtBBZlJGrf6M1kiJ0Ezl0RnwBRoXh5OqkhJfUG7Th6UcnH2He5sqiFvvIGzenBekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235397; c=relaxed/simple;
	bh=FwS54/PYqrUZiY7LxxdxSfAFIu5FraPSc4TQ7aShN3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=npna4m11DZwvM0+L0LNpDYctUZs+xFLWWUW7tZupIps4Zt1+SDWjsRQuSW8qBeuiNLbgoMlEqu/upTHZLpiUTGN+1QELGG/xq9BbqxHrQcNYuDSbWWqUWOv3DUi/D7h7Ue+t8eJLARhcErNpQWVGJCSPz+todXo5Xrmw7OHIcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=ERIDsCH8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1707235389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCNSmZUNy207qqwBIb7GldZJs6ZNLGxpkyWc6+ezBmo=;
	b=ERIDsCH8L/DuCVRwH71hqYtjBJw0TtTTblEe1zg1vXbqeZcE5DJ7iutSBZD2wV6VZpeZeI
	W8FoC9EnzfHFYLLRJ/R+eKkAIr/Lc/bFcp0EEO+M9YCmsNmuSJd6jT8b9Pnzr3C5ztG4h3
	r8NUzLJLP0kCqIGW3OopWiKQROwXxOY=
From: Henrik Grimler <henrik@grimler.se>
Date: Tue, 06 Feb 2024 17:02:27 +0100
Subject: [PATCH v2] ARM: dts: samsung: exynos5420-galaxy-tab-common: add
 wifi node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-galaxy-tab-s-cleanup-v2-1-89025c6c66c5@grimler.se>
X-B4-Tracking: v=1; b=H4sIABJYwmUC/3WNQQ6CMBBFr0Jm7ZhOqYCuvIdhUegIkyCQFgmEc
 HcLe5fvJf/9DQJ74QCPZAPPswQZ+gj6kkDd2r5hFBcZtNIpaVLY2M4uK062woB1x7b/jkjG2Xt
 R6TRTGcTp6Pkty5l9lZFbCdPg1/NlpsMeQaMo/ROcCRU6w5QXt1wbcs/Gy6djfw0M5b7vP2l8a
 Cm5AAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2519; i=henrik@grimler.se;
 h=from:subject:message-id; bh=FwS54/PYqrUZiY7LxxdxSfAFIu5FraPSc4TQ7aShN3A=;
 b=owEBbQGS/pANAwAIAbAHbkkLcWFrAcsmYgBlwlg0er+4/CLb0qwwpf95RB9X42yX26KC0zeOp
 b4BmsKT2SyJATMEAAEIAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCZcJYNAAKCRCwB25JC3Fh
 a1ZVB/9gyUlCTrObtkaHhdcNuPOwchwxWirjKeoJtQBDS+IX8ly8ND2fzsCgFqPOuuQlAy7d00E
 GSE5+55NpE7lJwCXP7LyrxV6cYetIOnlf2fnhG0DchAxzswoPe47VcT84I1kBVCkYTldoFH32bD
 r3HM84ILghZndJw8dFrzCuo1ZQveliS0jBS2Gnr96CHUKh36ptt7U8Q+jfWTgz+Vf0ixsThWOB+
 CCdv+MxpxPSQ0h+ZvMYCYnkOpgVf3AeW72aJ1iMnnidQQaODJVBiTlJ9oXwKDaSzIY/eQkf1ImS
 pSJVt5dOpv8n+z509v1VtYEu4fiNERcm9MRgRKGvHvn/OsrN
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

By using brcm/brcmfmac4354-sdio.bin from linux-firmware together with
nvram.txt from vendor firmware wifi works well on the chagall-wifi and
klimt-lte.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Describe wifi node for exynos5420-chagall-wifi and
exynos5420-klimt-wifi, and decrease available memory.
---
Changes in v2:
- Drop patch 1 and 3 (the latter was applied)
- Fixup patch 2 so it applies cleanly after dropping patch 1
- Link to v1: https://lore.kernel.org/r/20240130-galaxy-tab-s-cleanup-v1-0-d4e17857241d@grimler.se
---

Changes since v1:
- Fix conflicts after dropping patch 1
---
 .../dts/samsung/exynos5420-galaxy-tab-common.dtsi  | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
index 3532f1e8e902..246040967082 100644
--- a/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
@@ -30,6 +30,7 @@ / {
 
 	aliases {
 		mmc0 = &mmc_0;
+		mmc1 = &mmc_1;
 		mmc2 = &mmc_2;
 	};
 
@@ -87,6 +88,13 @@ key-volume-down {
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
+
+	mmc1_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpy7 7 GPIO_ACTIVE_LOW>;
+		clocks = <&s2mps11_osc S2MPS11_CLK_BT>;
+		clock-names = "ext_clock";
+	};
 };
 
 &cci {
@@ -620,6 +628,25 @@ &mmc_0 {
 	vqmmc-supply = <&ldo3_reg>;
 };
 
+/* WiFi */
+&mmc_1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	card-detect-delay = <200>;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&mmc1_pwrseq>;
+	non-removable;
+	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus1>,
+		    <&sd1_bus4>, <&wifi_en>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&ldo2_reg>;
+	samsung,dw-mshc-ciu-div = <1>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	status = "okay";
+};
+
 /* External sdcard */
 &mmc_2 {
 	status = "okay";
@@ -649,6 +676,11 @@ s2mps11_irq: s2mps11-irq-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
+
+	wifi_en: wifi-en-pins {
+		samsung,pins = "gpy7-7";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
 };
 
 &rtc {

---
base-commit: 9a5dbb835fd396c78da34b26ee91db6d529d096d
change-id: 20231210-galaxy-tab-s-cleanup-14da98b23606

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>


