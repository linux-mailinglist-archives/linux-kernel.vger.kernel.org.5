Return-Path: <linux-kernel+bounces-143321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC30D8A3735
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69C41C21F22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44427442;
	Fri, 12 Apr 2024 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk6meqIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED379249E8;
	Fri, 12 Apr 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954656; cv=none; b=OdygsbpCZAjaajYqiDKKSfKci1bDUbAKvZ5TFcYgGMouhcbNYSQutyw9e+znuNmyntHrF+9Igfn9TUSw3+wmE43lw0lop0amX1W1gRLEZBWJPK5erqM/l4Uj9Fj9QalDNYA4gB0sP6yrRgmsKn3IIcNjuNcZBRmux8LG0kVgZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954656; c=relaxed/simple;
	bh=tbwmwgn+93O/SPG6Jq7D3DigC50YGQE/RYOTKsK0Izo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUxXgyMVYNZY5MCSNcBHRK+KFl/V1AKywoO8YX1lqrr6SiDExEI3DSRuWAxBRiC/GgAKyhoJzb/npbCJRiBZINRuiy9uIeZVn+rgavh/SAUmqlgsS+vwLldwycntmhI1O4hTic/Y8ozeZzRDyVf4GmPVdwvqK+F3Hzs1CvujAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk6meqIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D43C113CD;
	Fri, 12 Apr 2024 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712954655;
	bh=tbwmwgn+93O/SPG6Jq7D3DigC50YGQE/RYOTKsK0Izo=;
	h=From:To:Cc:Subject:Date:From;
	b=mk6meqIM1uViiPnfITf5lHdtLtYjdp952115uLMKuj10WOEJO2FPS49mHusgKEwJ4
	 +Hux8u8J+z9UJTTLe3mLCPAXT7YYZTNcJU/0MZ1ZXOi5mhkybUHfJj7HRQkcNTTYXw
	 cevKsalI7CC7kcMiSLXwXdQdBq5JAWGQJ/yIFeWkDXKb97TOtgglrFMd3ySF2oRC3+
	 LWwXmSmCDVI9SoBxCDwvS7K2jeOk+sJLFwLhwHv47NjvZ9jQPTjPMVDxfT1FyEky5V
	 kQFKWugcdszCdAKT6Vq4RzixjwyGIbpv3QRoH++tV8YHHmt5CPgqK2JBHj7WWknCtS
	 YFJ15d20DCq5Q==
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: helios4: Fix USB interface compatible string
Date: Fri, 12 Apr 2024 15:44:04 -0500
Message-ID: <20240412204405.3703638-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct compatible string for a USB interface node begins with
"usbif", not "usb". Fix the Rockchip RK3399 based Kobol Helios64 board.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index dfb2a0bdea5b..9586bb12a5d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -611,7 +611,7 @@ device@4 {
 				#size-cells = <0>;
 
 				interface@0 {	/* interface 0 of configuration 1 */
-					compatible = "usbbda,8156.config1.0";
+					compatible = "usbifbda,8156.config1.0";
 					reg = <0 1>;
 				};
 			};
-- 
2.43.0


