Return-Path: <linux-kernel+bounces-161400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA58B4B89
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEDC1C2099E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1825813E;
	Sun, 28 Apr 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jEsaHxT+"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93A57876;
	Sun, 28 Apr 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304450; cv=none; b=P6NvslyIbWffUiJXAxrOPIhXmRSnrzChaoL5zFAOfM84msx8330bYymgqnx890VVH6Yy86cUJiN8qpqiGVgFpJdAwiBg6/opzBZQNmvFwXS1i7ihEdVvGK6blEKZlDzwxc0HvrKhl9Dx/3WpHu0cNZRGBEbr+R3HZBvJw0s9TyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304450; c=relaxed/simple;
	bh=4qMEkoFsIAMskrIOxbExs0rTAt41YA8CssKoQ++e7tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9mT+qQhHcBCWYYqAewO7uh5Wki2kAoGUvSegFX83oy0Xq5vxmyjiKkRS/lcuOEj0mlcBvaGPhwWavNfP7lCIXfaiCCE6RurPnE6fqquZAHIGKb/srKvGJqd9AgYV8mV5hrutnxpqOCB/qgL/3BgV7mt+rjPL8oZofg5eTTX+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jEsaHxT+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714304445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+4FNoNxkXA3lHy8/kRgdBQW+poGAHHKvQpgJQdlQzY=;
	b=jEsaHxT+V7ZWLuIP9v2cO19KyNFujzleqGJpnDYNHiyJob6YQ7BzSsV7/N395OiVCfIAq1
	2hSNW7wP8AnRvx89AWDIw+V85XW16UeM7V2yNgk2CBznDIPjWUHsSaTzdKScuD+Syu54Oy
	pygVa0IRc7R4gJOIIGZZHvODzQFKxvFGR2csicLxLPPiLTvYQWan+mTxAmz6L3/MurqVid
	+vI1qM0VfMBMv+Oqnt+Ytyz9oVrWZTHonr0OJrPxQ6JIu2YhugOGrikKt9u04pj0SqIGfB
	HCX+F3TjtNjN/Iy/CToO6eygIDfRf34M/id8Gs5to+pBSXbwQAEAdARXI2i2IA==
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
Subject: [PATCH] arm64: dts: allwinner: Add cache information to the SoC dtsi for H6
Date: Sun, 28 Apr 2024 13:40:36 +0200
Message-Id: <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
In-Reply-To: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add missing cache information to the Allwinner H6 SoC dtsi, to allow
the userspace, which includes lscpu(1) that uses the virtual files provided
by the kernel under the /sys/devices/system/cpu directory, to display the
proper H6 cache information.

Adding the cache information to the H6 SoC dtsi also makes the following
warning message in the kernel log go away:

  cacheinfo: Unable to detect cache hierarchy for CPU 0

The cache parameters for the H6 dtsi were obtained and partially derived
by hand from the cache size and layout specifications found in the following
datasheets and technical reference manuals:

  - Allwinner H6 V200 datasheet, version 1.1
  - ARM Cortex-A53 revision r0p3 TRM, version E

For future reference, here's a brief summary of the documentation:

  - All caches employ the 64-byte cache line length
  - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instruction
    cache and 32 KB of L1 4-way, set-associative data cache
  - The entire SoC has 512 KB of unified L2 16-way, set-associative cache

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d11e5041bae9..1a63066396e8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -29,36 +29,73 @@ cpu0: cpu@0 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
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
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
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
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
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
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 

