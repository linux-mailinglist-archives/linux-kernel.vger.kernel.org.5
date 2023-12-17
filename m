Return-Path: <linux-kernel+bounces-2551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F94815EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACD4282A13
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C8321A1;
	Sun, 17 Dec 2023 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ixypsilon.net header.i=@ixypsilon.net header.b="b9hjBFI8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from uvw.ixypsilon.net (uvw.ixypsilon.net [81.223.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AD32197;
	Sun, 17 Dec 2023 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixypsilon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixypsilon.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ixypsilon.net; s=20210903; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hGbSCr3F1tJTGQuFnfxCa5FlfqtL9YcTXhadpvN5MCI=; t=1702812737; x=1704022337; 
	b=b9hjBFI81d5RghdNvYKZOWdDVuu1B/y98FrOm/HnqL56qfEhSL0VNq5x3LMCriIcQ4iGsNOGwX1
	nfHEMZv0lckC6muBZffvgZv7njhRmdz8JlADLeHmcBSaWCA/yJlE0VN/S5YDkbobHG3ctcttAw1kk
	OQzi7o9KD+Etq8dmsVGv/rKSPi+k2BKIghym0hxFCBngkami7ZjTL45ZuAdqJi6Va8urBaRIn75t9
	LOBtjExHuUIZdh5lneVK0MuZQOXJBhWVKLSskQ4EQCKHd8op+K3S5Qlk0lCQfAg/xTVnOZ2WI/z2g
	WTrfMCLylWSFWUFrD7EfJTu99Kz0hfNOnnfg==;
Received: from [192.168.0.1] (helo=librem14.Hitronhub.home)
	by uvw.ixypsilon.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan.nagy@ixypsilon.net>)
	id 1rEpNS-0001IQ-1u;
	Sun, 17 Dec 2023 12:32:12 +0100
From: Stefan Nagy <stefan.nagy@ixypsilon.net>
To: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Increase maximum frequency of SPI flash for ROCK Pi 4A/B/C
Date: Sun, 17 Dec 2023 12:32:08 +0100
Message-Id: <20231217113208.64056-1-stefan.nagy@ixypsilon.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0

The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip (XTX
Technology Limited XT25F32) with a maximum clock frequency of 108 MHz.
Use this value for the device node's spi-max-frequency property.

This patch has been tested on ROCK Pi 4A.

Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
---
Changes from v1:
- Use the maximum clock frequency the SPI chip actually supports
  instead of the SPI clock frequency limit of 50 MHz set by the
  Rockchip SPI driver.
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
index d5df8939a..c68f45849 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
@@ -19,6 +19,6 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <108000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
index bee6d7588..6ea3180e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -37,7 +37,7 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <108000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index de2ebe4cb..5274938bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -49,7 +49,7 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <108000000>;
 	};
 };
 
-- 
2.30.2


