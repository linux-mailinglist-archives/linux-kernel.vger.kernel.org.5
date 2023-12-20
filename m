Return-Path: <linux-kernel+bounces-6206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6778195E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0201F264E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD1F4E5;
	Wed, 20 Dec 2023 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZjIwzZtz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C148801;
	Wed, 20 Dec 2023 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703033206;
	bh=iMWme+6zGpNz1ABUL0D3e0tP60KgxhOrUzSt158sqTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjIwzZtzxUzh9/vXd2wv0vZebYaWrrafMQ9XAu+ioH0qCroUEvd68paqnPiMyeWkO
	 Lpm456xiYpsKucLthYi5RqMLBvBs8Q89qp6f3AOvJRPl6nbcgk+YJLmuPxpE1NZwcw
	 tBlsOyq7Hs0MU/5uWf6HALQGTx4/qoJrwygIf3s7psoWpbad15JNT55kIbKS15nst7
	 thHhD1ygdt1cRyKWJZdZR5Oskilr8+ZUNmdLJCGW+EFAm3WAA73J/7kMnm0EDzxzji
	 L7LnLnn20C7RrLCWtF2TTBesJexLbhBJKclkbjzSwG5mKEG5M6qJGec7sioPJLX+iT
	 x+IJ0N40WIl8g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE48737814AA;
	Wed, 20 Dec 2023 00:46:45 +0000 (UTC)
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
Subject: [PATCH v5 4/4] riscv: dts: starfive: beaglev-starlight: Setup phy reset gpio
Date: Wed, 20 Dec 2023 02:46:37 +0200
Message-ID: <20231220004638.2463643-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com>
References: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
RGMII-ID which doesn't require any particular setup, other than defining
a reset gpio, as opposed to VisionFive V1 for which the RX internal
delay had to be adjusted.

Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../boot/dts/starfive/jh7100-beaglev-starlight.dts    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
index 7cda3a89020a..b79426935bfd 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
@@ -11,3 +11,14 @@ / {
 	model = "BeagleV Starlight Beta";
 	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
 };
+
+&mdio {
+	phy: ethernet-phy@7 {
+		reg = <7>;
+		reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gmac {
+	phy-handle = <&phy>;
+};
-- 
2.43.0


