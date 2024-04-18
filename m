Return-Path: <linux-kernel+bounces-150125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8CB8A9ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AA31F259B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ECA168AE6;
	Thu, 18 Apr 2024 13:02:09 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6E1607B5;
	Thu, 18 Apr 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445329; cv=none; b=rnpkA7Fsojgc2LzYqQusWqrFnb46S9j9YJm535x58n84I8irf4z5ptuAnCuM3YF9Sc31V/s95S+F+0OB3BzqSpOp7lrM5L9bsNIMOIs0+nvsJq3gbHCav0/aN3+ki/0eZOVF+NbV28q8crD/Bqmsmohe1QryZizqZU8Hf/5s++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445329; c=relaxed/simple;
	bh=/4TbSl+/XlQAezi/+7GU+ly3xBlxiEZD7VFvHU6iy/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoZl+Aami9vO4K9nm8vGFUGLYbOS3D2tQBYeroTIcOYOHt0WK/s6WS4d5JLPqpsBlbhfHPMRA9Fgn2G0x2fwIAvUZy3JvOYUWTAedvOsqD9GO0ikcNkrNS8b52s6WJIdi9wINnSSd8bdJs69jo5667wDNz/f6XlH+g169pOte78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:5e10:18fd:e06e:24de:a3c9])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 958F67E0179;
	Thu, 18 Apr 2024 21:01:27 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: correct the model name for Radxa ROCK 3A
Date: Thu, 18 Apr 2024 21:01:20 +0800
Message-Id: <20240418130120.67663-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418130120.67663-1-amadeus@jmu.edu.cn>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTktIVk0YS04eTxpNSksfSVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBTh5KS0FKQx0fQR5LTR5BSU8fHkEaSBhCWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JSklVSktLVUpCWQY+
X-HM-Tid: 0a8ef14c37a403a2kunm958f67e0179
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTo6Vio4DTMOEUoJDCNDUT4P
	GCkaCz1VSlVKTEpIT09OSUNDSkpCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTh5KS0FKQx0fQR5LTR5BSU8fHkEaSBhCWVdZCAFZQUlISk43Bg++

According to https://radxa.com/products/rock3/3a,
the name of this board should be "Radxa ROCK 3A".
Also update compatible to match the model name.

Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index c62230308457..e859c075bd46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -8,8 +8,8 @@
 #include "rk3568.dtsi"
 
 / {
-	model = "Radxa ROCK3 Model A";
-	compatible = "radxa,rock3a", "rockchip,rk3568";
+	model = "Radxa ROCK 3A";
+	compatible = "radxa,rock-3a", "rockchip,rk3568";
 
 	aliases {
 		ethernet0 = &gmac1;
-- 
2.25.1


