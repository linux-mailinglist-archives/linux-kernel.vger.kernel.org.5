Return-Path: <linux-kernel+bounces-154992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63D8AE415
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00996B2390A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007912BE80;
	Tue, 23 Apr 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Utlq4mCS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ohKajoup"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464384A2E;
	Tue, 23 Apr 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871940; cv=none; b=VilXy2dscezDpors3mCd7rx/PIvprVHzRPz9NetHPjrla9qtEy4qMkrO97rsWei6s6A7wxbI3UOlHbECGFhZ8gIOuPVCjhhvTA1ROGHIJzfiIQ12QCWCL4wX9Qn+iLrZA0/Wjn8+c5WqyIBOwgTVU+VbdN7VFwr3pBOVcqbcBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871940; c=relaxed/simple;
	bh=A8JGaF3N6+izHH2NLVJpxGLzwWpau3xfnnyuJHXdKKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4oR+L4MnkDzsMbujTXCQNxol7WGcFX9pccrIkOWio8BVm7iXG3kuxTqekbSlZOeeJWQKDENyGzLHeyzEuLPZA3vNAMP04gAf1UXpynnkOhAc4cOM0fQKOaRox+WDrwMmdl8Mp565EZ+QGRmm2tdIwG6Hpp/1ESX+HidKRG/F78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Utlq4mCS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ohKajoup reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713871939; x=1745407939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QdSi3c2hCk307uljy0iamJEo2vwFvN1F0/IRX/AWjy0=;
  b=Utlq4mCSU2Nd0agWxcbaajtZCBKr/vy6oQ/YT9pS7DzL7jfWRhCCM27W
   tFNzlNcNT1hxKE2+iJ9gcRS3+anjKOTeGJK/JkcLj+z5H7K9rjokgmGYQ
   KXhmpme4PoSiCpasbfIPzChRP1tfpYn7Dqk5Z+WQAPx3g8pFWszQw2odb
   RJStoKuhFcOhUKU1tjovSUYHLfi+1pS4UgD2AVbyu65PbUUiVL3h6ML93
   /2s/oyAg5ZJ7B6nSv6oKbNcpWiIJEZrlLyfuOwfAgNjohIlifBKxtmGWY
   6IeudfqXDJyhCDENegffThJe7vfY32QzfQ57l/OW9dW/3XMucgszSb594
   A==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36565274"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 13:32:16 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C00616FD61;
	Tue, 23 Apr 2024 13:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713871932; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QdSi3c2hCk307uljy0iamJEo2vwFvN1F0/IRX/AWjy0=;
	b=ohKajoupL97ZlAnUNCkDo1O1Gqxt1a912/azd5+H3nqxfqBdZfRpwpJ1Ai8KGgCheApi6T
	Bc1C/Pz6bmsFpNRGim3LflGUA0cdmVrFQCLDBV4OvCcbcRTvJBOfqWijOs1Mhk0SeXVLoD
	PtxYuu6T61zPaknB7ibMQkZ9GwwZqZ2tfmoHLmXmpneaaT+1PgWk7UJqtbIqBJkpoU7o7k
	EHWrSENH2w/lZ+oN0vXEV4kIId8Wn/pJTCYCt3Rn/znozqoDWDbCfH+bH42y623u7dW3SG
	hOFNUbgLPILb6JwKQUfc2sRcceQ7yVgsNRM0dYb/9syUUGix0hmseoAeqUVuBw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: freescale: tqma8mqnl: Add partitions subnode to spi-nor
Date: Tue, 23 Apr 2024 13:31:48 +0200
Message-Id: <20240423113151.2145120-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423113151.2145120-1-alexander.stein@ew.tq-group.com>
References: <20240423113151.2145120-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The bootloader adds MTD partitions in this subnode if present, or in the
spi-nor node itself otherwise.
Setting #size-cells in MTD nodes itself is deprecated by mtd.yaml.
Fix all this by adding an empty partitions node which the bootloader will
fill with configured MTD partitions. Remove the deprecated properties
as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
index fb24b9aa1b938..e68a3fd73e17d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
@@ -60,11 +60,15 @@ &flexspi {
 	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		spi-max-frequency = <84000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
2.34.1


