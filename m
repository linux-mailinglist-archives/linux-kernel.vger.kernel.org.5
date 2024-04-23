Return-Path: <linux-kernel+bounces-154990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33A8AE411
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1ED1C2279B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C386267;
	Tue, 23 Apr 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="G80+gpWt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="poKuUsrc"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BA82898;
	Tue, 23 Apr 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871931; cv=none; b=VjCIMLPj5NPpBsMt5JndZ411OZuBOj4j3B4j23cH+tDDDpVO70p3GanpYnhXPoVmsYHVVBIU33YzLDJ9YLQus+ewseQD8p/cjGFRWmhXqYH4JwvDYLHNQoYERnGRDwzNmsAWrStuM3Gcf9ULnVA71us6h6lRYp7JAteB8PY5c6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871931; c=relaxed/simple;
	bh=aH67okvChfjNK/qdROTeGr50aua0GAV9FbdIPCD96iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsOBLe/v45/gUWpXymQNzMB9D6Ten5cAazBlXGIeKAIURZIk5vgyAZeWOMBbIfNoMR6f1spslIygAkSq/nrH/W6ryInKCYRJjYyezvHR/INgSwrsNZYSolY7dHKxjaqPQSO/DQm0nK004VsIS5a8jtZrZArAsvHjxJke0d+zqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=G80+gpWt; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=poKuUsrc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713871928; x=1745407928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wofwYl3aLeJL4MtGjQakxRMPKOMFpPo928i/DlFFhz4=;
  b=G80+gpWtVjNFF1Ld4uS/Wt09LCm87BJcVxC25oH2KeBSKtRFXLy/cRYo
   7Xc8OC3wsuXySZVc+XeFXQ9wS82AIC5oYSNQTNSWQwJyshdgU+dIMoIqR
   0rG3QvgNv1py8ti1OykgTVP9CYYrf0qUAUkfztrI+haBlIE9FiuKWPiHr
   3MGf9Q4ikGfWIrO4a5TVR6v5ggMKSOfy0tcUwtP3j6upVPu10t4hDE5KH
   6TlU2KRXhR9KmFH2CoU8S1z8gz0FHiGwzbEkps+xl/T+/cHK1WNtXobr0
   r944OvXQHocDu18pqHAycRebGTlNaS6lDVOdStBi8DWW5ZLPKRODJEXTQ
   g==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36565268"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 13:32:05 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6625170860;
	Tue, 23 Apr 2024 13:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713871921; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wofwYl3aLeJL4MtGjQakxRMPKOMFpPo928i/DlFFhz4=;
	b=poKuUsrc+vn61XYDxhlFXS5YMQGSZr+rfRDdko1Alu+5GLUVKeKYaMEaQkz/13VAzCA753
	usN3p5ZlQA2/kcc+eEIqbFNLlb7YUHEnC+LK6vsGK3tvnTpT10GH4qE5x4n+/bO8gKZk5D
	8DbDN/Q7c7zELNcYwKEBfsDXXMmINdo89EBgx3/t7krjCAU5VgVuLrAp/MmMe3lgaxTaVn
	gt0Rz9d6IDrrCYFUngmBtGAMrGG6277Vaj63TESCKLrtmOBNS6pE4ZHUqNXtfSWxOC053U
	mqmkWMI0s5J0gyhOYmmfJiL6vo8geIAxM5Olu3KMQUaNErU0eMYSm7AEEyhOGQ==
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
Subject: [PATCH 1/6] arm64: dts: freescale: tqma9352: Add partitions subnode to spi-nor
Date: Tue, 23 Apr 2024 13:31:46 +0200
Message-Id: <20240423113151.2145120-2-alexander.stein@ew.tq-group.com>
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
spi-nor node itself otherwise. Direct children cause warnings like:
425e0000.spi: ofpart partition /soc@0/bus@42000000/spi@425e0000/flash@0/
  partition@600000 (/soc@0/bus@42000000/spi@425e0000/flash@0) #size-cells
  is wrongly set to <0>, assuming <1> for parsing partitions.

This is due flexspi node having #size-cells = <0>. Setting #size-cells in
MTD nodes itself is deprecated by mtd.yaml.
Fix all this by adding an empty partitions node which the bootloader will
fill with configured MTD partitions.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 9d2328c185c90..edbd8cad35bca 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -75,6 +75,12 @@ flash0: flash@0 {
 		spi-max-frequency = <62000000>;
 		spi-tx-bus-width = <4>;
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


