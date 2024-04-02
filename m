Return-Path: <linux-kernel+bounces-128580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9634E895CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A3A1C21E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39B15CD52;
	Tue,  2 Apr 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMv5ovEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2E15B96A;
	Tue,  2 Apr 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086341; cv=none; b=EiI7azE2WLHl3m+HfXVCyBLNbNMvfI1IKmNaeLrmvUM6fJo1/+WcA2gHgAY3dtTSiN7JNkDRRwneH5SyzhRH9p/trU3n4m/9NIuGXwD4Fj3QsNLgi6F7/fEJiWeQrx+Yv9+V9sd9ZRP++0mZI1ckArdlnVwUMElisuLaggas8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086341; c=relaxed/simple;
	bh=Za804mpkHpVgJYpy6pm2d5QEWIM7Bjgll26VyAOfJaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGwBxsq0px2ekXneC3lEIDuPQBK7ZfusexzVZeslLZe9+lh9VhfaCmNGD4u5i7P3m2BLX4xUhD3rsG3sBjHy73Ns0BRi/4Vqu63rzCq4rkLIMUONZdiVDh6gr+N+g7Cg3W4AqKppD5T8A3EmlqMp9odrnlJg3OPxHdKQpoMOCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMv5ovEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC9C433F1;
	Tue,  2 Apr 2024 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086341;
	bh=Za804mpkHpVgJYpy6pm2d5QEWIM7Bjgll26VyAOfJaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMv5ovEFf72zOSvz12jMIpq34lIh24JbM8wjCvSeRLEIGHHIdiaUOf4S81cZUDQ4H
	 aYsYKArXVSgjDqW9qh0sgpdUSxe/+F4otJ5ee1ZbDkZHIu8RR7Pd6u9GDp94CDUgLQ
	 vVWQb0OMHeh6CQN/AMDv8D7rBUtqfULvMJ1lkqTNa1gTKxzu6AmCepgucRoNLdpue+
	 1ZDwCYy3smw2S8hFN1LKBsgOVB6ZNOz28a/ywgk56sfMKBYBoezmQkpKqaCkQ3o44J
	 oG8/zKZKrmTxNofjIay5nXXYl0jx5URkF/ssKrtBByM0dtFYUk44cGrPx+SQLOXDS0
	 DYE82B8X1d6jw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 9/9] arm64: dts: hisilicon: hi6220: correct tsensor unit addresses
Date: Tue,  2 Apr 2024 21:31:48 +0200
Message-Id: <20240402193148.62323-9-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct unit address to fix dtc W=1 warnings:

  hi6220.dtsi:855.31-862.5: Warning (simple_bus_reg): /soc/tsensor@0,f7030700: simple-bus unit address format error, expected "f7030700"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index be808bb2544e..a589954c29e2 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -852,7 +852,7 @@ watchdog0: watchdog@f8005000 {
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		tsensor: tsensor@0,f7030700 {
+		tsensor: tsensor@f7030700 {
 			compatible = "hisilicon,tsensor";
 			reg = <0x0 0xf7030700 0x0 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


