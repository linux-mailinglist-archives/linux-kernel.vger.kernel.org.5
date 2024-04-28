Return-Path: <linux-kernel+bounces-161401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9198B4B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F80C1F21412
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D235A0E4;
	Sun, 28 Apr 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SlJ1ct7Q"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A886E573;
	Sun, 28 Apr 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304452; cv=none; b=Wk2nCSPSY6s59n3w1N6k+igLiBBiRWDUlp9kCrLkuEM+Zhe7vR8le16CgCzYmeiZaCGs31b03c23ny1ED2uoVQlzEeIgQhvsvbHEqY+KbHqW1go4BM9fV3EOtcm0fdIDgVXwBg3FkOjOvvLkAdz7PR6x1/YlSurL/5hizp1aYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304452; c=relaxed/simple;
	bh=38qZybaFIbJJQUgyJkChPDujC2+Dkdv/fBlW/vsmtsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSJ0vmdDZ7PWANLJL0ou+x/NsebPf/q2fuqE4WA6dFLxnFvZg0IjoWT1JmiAa0LOMk9TOH4GQRhXSnRGaF+aGtyWAXqvb4kdS75M8q1a377fRwSineXJ90D13stX5LxMGFgA+ZO8Fv1shKfmoDolvQoy/HetZIGIhj1rhzryV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SlJ1ct7Q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714304444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fUUlO8nSkAmh0ieyYyxQ3T6zIAKTL4UZHOPVrkuWOnQ=;
	b=SlJ1ct7Qbmgs/iRfAlf0K+hPxDYtqovcTVLtZoJUXu7iPQxNtw2vyh4VPwNfkmgoNJ1oby
	fRbsxecxQpE/TgsXDHSM1/ZCpXlFR0mXnfg1DFRk+kRfQaxjoCrFUDPhTaUU1stRMZ2iVw
	tK0iearS6rjrwl5oELDxFKl6WAFMO6ryubceAJx5HnKJ7n5YF2L3De4N0Oa/YXzCNofYKv
	/nPKzUdRm05Ds9+cGNRoj6aLghOw3r+p2D87+Y+5ZC4M8gX8KOvadRGpIVKUxdwnwRxkCX
	U+Ua4OO3Jx9D6R0Em1JcDP9qcH0DLqJrgBiitjLnXDf2FWaJSzF7dA4FGEBYGw==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: Add cache information to the SoC dtsi for A64
Date: Sun, 28 Apr 2024 13:40:35 +0200
Message-Id: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add missing cache information to the Allwinner A64 SoC dtsi, to allow
the userspace, which includes lscpu(1) that uses the virtual files provided
by the kernel under the /sys/devices/system/cpu directory, to display the
proper A64 cache information.

While there, use a more self-descriptive label for the L2 cache node, which
also makes it more consistent with other SoC dtsi files.

The cache parameters for the A64 dtsi were obtained and partially derived
by hand from the cache size and layout specifications found in the following
datasheets and technical reference manuals:

  - Allwinner A64 datasheet, version 1.1
  - ARM Cortex-A53 revision r0p3 TRM, version E

For future reference, here's a brief summary of the documentation:

  - All caches employ the 64-byte cache line length
  - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instruction
    cache and 32 KB of L1 4-way, set-associative data cache
  - The entire SoC has 512 KB of unified L2 16-way, set-associative cache

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57ac18738c99..86074d03afa9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -51,49 +51,76 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
-		L2: l2-cache {
+		l2_cache: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 

