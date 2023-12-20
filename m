Return-Path: <linux-kernel+bounces-7442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF281A7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423321C22B71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAD4AF68;
	Wed, 20 Dec 2023 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WQLSZXuD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D11495D5;
	Wed, 20 Dec 2023 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703107074;
	bh=xs6TIYSXHQI0In49A4/5cc954c7s8z1QQPzJQM1D+vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQLSZXuD9bQ3Aid8sl5ikYYAXwKMcp71zth2mQQnhv6+3UX7tjfmgCL9+v23ERUdm
	 4HFY9l3dmrnhKyLj/ywyZt0lu85Bi1BW9Oy+azKbcq0hpkdTfHSki/BkS3SBeI9pKJ
	 PcPiLeezH+4S2NuHI1fGyIHwLEbUp2Jjn8YUt9vcFlFfDuR0+z0O7+bsRUlv0UzZxC
	 ow520/mexsYB/4tKzRl4CtwfKroHQ02qYALz/ETQ4bIRgJ/Yc0Tn4JhIBL2bRl2SNx
	 rEA+s7N7DetUzzJHcqqzFo4346lmo4MIUFb1gxr/EbYqXzUUPC9uhMMCvFTqhXJTse
	 +bh5jMS8p5TmQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 36A403781FF7;
	Wed, 20 Dec 2023 21:17:54 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v6 2/4] riscv: dts: starfive: jh7100-common: Setup pinmux and enable gmac
Date: Wed, 20 Dec 2023 23:17:40 +0200
Message-ID: <20231220211743.2490518-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
References: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pinmux configuration for DWMAC found on the JH7100 based boards and
enable the related DT node, providing a basic PHY configuration.

Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index 42fb61c36068..bcba08e5bdf2 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -72,7 +72,91 @@ wifi_pwrseq: wifi-pwrseq {
 	};
 };
 
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+	};
+};
+
 &gpio {
+	gmac_pins: gmac-0 {
+		gtxclk-pins {
+			pins = <PAD_FUNC_SHARE(115)>;
+			bias-pull-up;
+			drive-strength = <35>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+		miitxclk-pins {
+			pins = <PAD_FUNC_SHARE(116)>;
+			bias-pull-up;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+		tx-pins {
+			pins = <PAD_FUNC_SHARE(117)>,
+			       <PAD_FUNC_SHARE(119)>,
+			       <PAD_FUNC_SHARE(120)>,
+			       <PAD_FUNC_SHARE(121)>,
+			       <PAD_FUNC_SHARE(122)>,
+			       <PAD_FUNC_SHARE(123)>,
+			       <PAD_FUNC_SHARE(124)>,
+			       <PAD_FUNC_SHARE(125)>,
+			       <PAD_FUNC_SHARE(126)>;
+			bias-pull-up;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+		rxclk-pins {
+			pins = <PAD_FUNC_SHARE(127)>;
+			bias-pull-up;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <6>;
+		};
+		rxer-pins {
+			pins = <PAD_FUNC_SHARE(129)>;
+			bias-pull-up;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+		rx-pins {
+			pins = <PAD_FUNC_SHARE(128)>,
+			       <PAD_FUNC_SHARE(130)>,
+			       <PAD_FUNC_SHARE(131)>,
+			       <PAD_FUNC_SHARE(132)>,
+			       <PAD_FUNC_SHARE(133)>,
+			       <PAD_FUNC_SHARE(134)>,
+			       <PAD_FUNC_SHARE(135)>,
+			       <PAD_FUNC_SHARE(136)>,
+			       <PAD_FUNC_SHARE(137)>,
+			       <PAD_FUNC_SHARE(138)>,
+			       <PAD_FUNC_SHARE(139)>,
+			       <PAD_FUNC_SHARE(140)>,
+			       <PAD_FUNC_SHARE(141)>;
+			bias-pull-up;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
 			pinmux = <GPIOMUX(62, GPO_LOW,
-- 
2.43.0


