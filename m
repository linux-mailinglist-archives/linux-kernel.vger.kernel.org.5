Return-Path: <linux-kernel+bounces-154994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF568AE419
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723811C22696
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B4412EBC9;
	Tue, 23 Apr 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CxM0G6v0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rAugLcGH"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC47E78E;
	Tue, 23 Apr 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871950; cv=none; b=Suvg5/UVbC8r0f1394D3mUcqKGub1v/z610vIeieew4P++SUWOSVYn7qQyJFROmdHa1y10kRjGWfCA5QDX/Yxx++q3vESD1uA+T+TwfdRL6Fkz3Qm3y0QMwznIpHFHMBSr6xLG7ouPQkMoLnFcw+6cIFXuYqfyijY56z+PUBlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871950; c=relaxed/simple;
	bh=jwSYTrGlB4VVA6AzwNKL6XCoUro5wTrrJWrgjhjZkpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlS+ugRIJWF3SZL7UVhbmNRooiW8sVKE4Z/u5ad+Ox914czN1+Cjnm7Z65sLqqEObEumRUgwWdQtE3KKZqzs4QLFLiuiuJgWMUljQ7zwjti+gB4Zno6pgiVl/AzzPFBKODJtn0jmjT7QjVNyyCGF3kaqXSeUktql3Hod998bY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CxM0G6v0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rAugLcGH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713871949; x=1745407949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iu1dWYNKDp9es51AFvUQfiaCrk+4XgYnKK2u7hGngWI=;
  b=CxM0G6v0LPUkSAyYByPq2oZgotPj4EVhaE9XL64iMVM/Hqk7ceHqqPAk
   wYfFq4bgzYbJHms3AUGY5MlgqBcqycNE0YoAA51dXNyUy4H/hwYoKCUh4
   EAvStUxARYzUNWmMBiNdtHB4PbjWlkNo4DOK7nowWsnDtduANebtyiMx7
   0LRxIO6uX2HjffRvFdEhpqwWN3pYoYqWt+m36zXqm4s5bgvd+VVjzO19h
   MjEahrzQjN+r3KQ5+fj/XJz03aQjY4OCjQC+04l1hW0j5NG/LZ+V8uENB
   Ue4PQJDFeCikWUnPp/ETowmFXwrotsIAO/qQvzRlVd9IysDBcErwzAI7v
   A==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36565285"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 13:32:28 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17F9A1702F4;
	Tue, 23 Apr 2024 13:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713871944; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iu1dWYNKDp9es51AFvUQfiaCrk+4XgYnKK2u7hGngWI=;
	b=rAugLcGHgiuz1Oyvl6KBwdn5BzeB5gtuK3wRKTe3q/S6eOlw8WCj2ZMN10oqBmqqv22yOO
	/+FtnEkC7DreL7u50alA2g5FHbDfPG3lfQqEIZRLf/4+AT1n/zuPSFbkpY4sgrIRJbHviZ
	QIWEgbhf289G9ydfkvTvQhqi0r1VptQBBrbaG7olMDe9v49yYGGKqbC4sGGA0WMKMlAxNX
	CTPsLHaq/fUWZo+Y1MSYaSkRKM6c8YM8HLXKLfYIkfKpg1K6BMmxiB8fDo01RZ2jP7o5ps
	y5eH6WFEgRBQXkOZBys3gaUmW8o2WAPqYHGpc4fLTB2/VQL7U04c3lBJKQJC5g==
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
Subject: [PATCH 5/6] arm64: dts: freescale: tqma8mq: Add partitions subnode to spi-nor
Date: Tue, 23 Apr 2024 13:31:50 +0200
Message-Id: <20240423113151.2145120-6-alexander.stein@ew.tq-group.com>
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
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
index 5ca6b22525469..01e5092e4c40a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
@@ -251,11 +251,15 @@ &qspi0 {
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


