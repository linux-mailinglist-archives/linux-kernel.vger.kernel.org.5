Return-Path: <linux-kernel+bounces-136823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A989D8AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AB1F248A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116512D1FF;
	Tue,  9 Apr 2024 12:00:34 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57942129E93;
	Tue,  9 Apr 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664033; cv=none; b=plWUY/uMdhfVL/otakyMxfJddJ3UFDibO1EkMbcAU3zuhm9Mw5w4Awd8Bqk6US81PL6vFUZjnKjBBFesNUB9b/mIxiTEk2Jns6pc372P9sStZjg92k7e+KemJKMriFBRvR3cpZIXwrqcgMZYzhicd1B98U9iNxS03t4DZLhfdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664033; c=relaxed/simple;
	bh=/N5LnswQDIOwLZ0EXDovhttSUbVYl0RtpMGq05Sndbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4hhAAApdI4ZW7AMRyzk2u3TiOaF0Qva+2+ekA5JiO8My7V2hgQeRiQaZuR4P4sbBy9dgKo8L1UssFgYLCqQomV8HdHYEOXsiJzgimSkHbvUV4dywo/+d+HDOQXiACwgNOiCTzReGUjbGBbu1w/OGmSk47MJ+h1ZJQeb6MdZ4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:8f70:2795:b738:b1bf:b2bc])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 412497E0148;
	Tue,  9 Apr 2024 20:00:11 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [v2 1/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
Date: Tue,  9 Apr 2024 20:00:03 +0800
Message-Id: <20240409120003.309358-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409120003.309358-1-amadeus@jmu.edu.cn>
References: <20240409120003.309358-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkkeVktKGh1PQh9CQh0eHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBQx1MS0FJTEJOQRlMSENBGUoZHUEZSRkYWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8ec2bae2dd03a2kunm412497e0148
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6NRw4NzMNERk#USE3TCkK
	TwEwCThVSlVKTEpJTU1PS0pKQ0tPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBQx1MS0FJTEJOQRlMSENBGUoZHUEZSRkYWVdZCAFZQUlJQkg3Bg++

There is a mx25u12835f spi flash on this board, enable it.

[    2.525805] spi-nor spi4.0: mx25u12835f (16384 Kbytes)

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index a5e974ea659e..c62230308457 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -757,6 +757,20 @@ &sdmmc2 {
 	status = "okay";
 };
 
+&sfc {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <104000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <1>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.25.1


