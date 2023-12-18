Return-Path: <linux-kernel+bounces-3632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A33816EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CAD1F22B80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC272075;
	Mon, 18 Dec 2023 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gza/QDN4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9C72065;
	Mon, 18 Dec 2023 12:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9EDC433C8;
	Mon, 18 Dec 2023 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903541;
	bh=4+ufg4U6B7iRusa3p5Wt3FTx1kc9V97mZVSoGLfCtDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gza/QDN4OnNzIxVDNVqCwSfFLJobDj+xGTSycJ3FB1i4d8nTVCqzvcIQjYTtMMNON
	 DMGpN9/GxtZyXZjp4ci5nP2tuhDNYHPLFZRmcWd2SO+iJeB7p2MDB+Odd9uhAhlHE+
	 WZesJAd9yBcTgNI84BIiN0pD5F/gEL7AJnFZo11ElUlOUo3sB4sZ8p1l+/nyfRg9+h
	 7R73DUI1bO4Wp3v0zohcErl546UO1xXfaklu/p03i1DctXwXE/KUKfffofu3Z6E8eR
	 44fYaw9rHVgaPBBsRY43nPRbqakIwsWEHWeEni0P8Mb0UqYo2RgK11/bd3UZsZD9N+
	 jC3unz3d5a2uA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	git@xen0n.name,
	zhoubinbin@loongson.cn,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/15] MIPS: dts: loongson: drop incorrect dwmac fallback compatible
Date: Mon, 18 Dec 2023 07:45:00 -0500
Message-ID: <20231218124513.1380056-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124513.1380056-1-sashal@kernel.org>
References: <20231218124513.1380056-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.68
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 4907a3f54b12b8209864572a312cf967befcae80 ]

Device binds to proper PCI ID (LOONGSON, 0x7a03), already listed in DTS,
so checking for some other compatible does not make sense.  It cannot be
bound to unsupported platform.

Drop useless, incorrect (space in between) and undocumented compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 3 +--
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index 8143a61111e33..c16b521308cb1 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -123,8 +123,7 @@ gmac@3,0 {
 				compatible = "pci0014,7a03.0",
 						   "pci0014,7a03",
 						   "pciclass0c0320",
-						   "pciclass0c03",
-						   "loongson, pci-gmac";
+						   "pciclass0c03";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
 				interrupts = <12 IRQ_TYPE_LEVEL_LOW>,
diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 2f45fce2cdc4a..ed99ee316febb 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -186,8 +186,7 @@ gmac@3,0 {
 				compatible = "pci0014,7a03.0",
 						   "pci0014,7a03",
 						   "pciclass020000",
-						   "pciclass0200",
-						   "loongson, pci-gmac";
+						   "pciclass0200";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


