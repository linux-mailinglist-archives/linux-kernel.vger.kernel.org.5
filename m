Return-Path: <linux-kernel+bounces-973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC98148BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C5D1C2354B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39AE2D63C;
	Fri, 15 Dec 2023 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ixypsilon.net header.i=@ixypsilon.net header.b="bXdD6OAi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from uvw.ixypsilon.net (uvw.ixypsilon.net [81.223.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560F2D052;
	Fri, 15 Dec 2023 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixypsilon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixypsilon.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ixypsilon.net; s=20210903; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oj0QHgPdvHMo9GUAP8G/tq7iyDKRF1mzr5DOg7Hc4RM=; t=1702645766; x=1703855366; 
	b=bXdD6OAiLxWCqjFarQVPUWAR2T2uvBP8k0uC9bi9ODufz+P9UjOsJl9FiOZew7t0BVFVyaLLlYw
	XzFRMXKWQZFg2i6ntUEyBx1d0TsY6/37WR8JLPGQexT/GI/xez6OLtjmOQ7TCaAQP3wlzd37CBBTK
	5h6ravs3jj/NjnnI1D9XZDi/cjVQ0f5AihbKIE+/vpsp9I8Kyxd9GD9VaTzyrLDgvFr+yA7VszR8M
	d2Nnf1rbzm8G7L8fS2/owdMHvb9IlU+1VQL4eOPeg3ptYKYs2WicgzcWv7XoEh+5+uruiIpQv2wLx
	/uNU+AIriGRGTbCBquUMBX0PM52fKqP2Tdsw==;
Received: from [192.168.0.1] (helo=librem14.Hitronhub.home)
	by uvw.ixypsilon.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan.nagy@ixypsilon.net>)
	id 1rE7JH-0006gN-0U;
	Fri, 15 Dec 2023 13:28:56 +0100
From: Stefan Nagy <stefan.nagy@ixypsilon.net>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Increase maximum frequency of SPI flash for ROCK Pi 4A/B/C
Date: Fri, 15 Dec 2023 13:28:48 +0100
Message-Id: <20231215122848.59534-1-stefan.nagy@ixypsilon.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0

The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip (XTX Technology Limited XT25F32) which has a maximum clock frequency of 108 MHz. However, the Rockchip SPI controller driver limits the maximum SPI clock frequency to 50 MHz. Use this limit for spi-max-freq.

This patch has been tested on ROCK Pi 4A.

Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
index d5df8939a..30e63e62a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
@@ -19,6 +19,6 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <50000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
index bee6d7588..7122bf6c0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -37,7 +37,7 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <50000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index de2ebe4cb..8af75bc7c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -49,7 +49,7 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <50000000>;
 	};
 };
 
-- 
2.30.2


