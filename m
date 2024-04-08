Return-Path: <linux-kernel+bounces-135351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074FD89BF5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832E628115F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91193757E3;
	Mon,  8 Apr 2024 12:46:14 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF174267;
	Mon,  8 Apr 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580374; cv=none; b=tAbGTFOE/4XsvgUb6qutV7w7l3sKD1UAkY3OnoCMPCW0nnBTcmx653GoNB+swnMbTtHlt7t7B+qaDJcml9qAueea0XQUPtGDXsLQOxN1KnN8fmVTad5ewmK0Q2jFLUqRz8qnvtbZolBkd4cczAeVQyaXFsnVzOIjwek6/eoVw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580374; c=relaxed/simple;
	bh=bHERJTLT8zBhplQm5nyHmVmmC98fDNKu15QS6DQ0fWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XHxkwiFotq0Xj6MIvPjVJkWvcROwEmYH0Q05nFI48aYpNGF9bbYehJ58B2euSMK/l07iRi+ipo5MA1BdqZUFd0euI6cgysW4ou6Lc+gnyuC0OI/yMR41Li212OxuxlpM8pFNKjAzQaru//WGCVlekXWC2zm3RWQzsTgKqwOmnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:8840:aaa3:4cf8:b210:c09d])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 446BB7E013A;
	Mon,  8 Apr 2024 20:40:10 +0800 (CST)
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
Subject: [PATCH 1/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
Date: Mon,  8 Apr 2024 20:40:05 +0800
Message-Id: <20240408124005.182565-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGBpIVksaGENPHUlJHUtNT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBQ0NPS0EaGhpIQU8YHUNBGUlKS0EYS0IfWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8ebdb921fc03a2kunm446bb7e013a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6CRw*SzMRSiIhDCIWLDot
	HT8KFAxVSlVKTEpJTkNLS0pLQ05MVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBQ0NPS0EaGhpIQU8YHUNBGUlKS0EYS0IfWVdZCAFZQUlLT083Bg++

There is a mx25u12835f spi flash on this board, enable it.

[    2.525805] spi-nor spi4.0: mx25u12835f (16384 Kbytes)

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index a5e974ea659e..d8738cc47c73 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -757,6 +757,18 @@ &sdmmc2 {
 	status = "okay";
 };
 
+&sfc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <50000000>;
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


