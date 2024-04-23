Return-Path: <linux-kernel+bounces-154996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A78AE41E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A60B241A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25290130A79;
	Tue, 23 Apr 2024 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="a678XM4+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QhwY3aun"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC912F5A2;
	Tue, 23 Apr 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871956; cv=none; b=Is4MurvCJg7anrPahqwuJlBT4Z8rpl1J/lFBwaSth7P3M8RQ19HD2LwZhYLNVCV5PAAlugZA+zOMk96U0a3FfMFUosOyiJ+Qd2IiBrC5rBWYP+WdWv04qjaZ350FyisejZBY3ipGWDJWSi/42rM9HylhewzzskU1UEKp+ZZP4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871956; c=relaxed/simple;
	bh=ZeYlrTotjERbxmW3X60SZKrwg2gt2Rp06cYW5JNsCOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8anTJQfscbCL4IUnQOGJceg0idLoCVaIt1eoOnG+geK+vGzsUp/vCVcjBe7RWijsV+itYyXhZ66tq06xT0SZjR5fUZM4JPnVHwG0KWtQF+9QKE4xFtVHTdmFjLa72d34gZcAlZ3wqoR5AvXFUDWhxJsTra0nishyIM7ADi+zmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=a678XM4+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QhwY3aun reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713871954; x=1745407954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pCLoCC6GOo9gQ9iL/Fi4GAoIoWICczCG1YlZoCwuv8U=;
  b=a678XM4+Ntc0d0Pnyi7hYH+N1YAEcu7M9rLTFzGBegyuTUnPy4CCEvP1
   qT166I4p87jmOv4bZ2NTNaDXoZ0wAsuYgLjR7eR0I60O1eIvxtbAUIgDC
   6ElIDnFc7l6eUS8iZDMz6/cPThghBDFqPPe5cAOxutkn2ySYOkLBpj46F
   zGSMMuyMjXqkVjD2BrUj3IseVrJthuJbBahw24hUm8VHOY8HXDuTazg7V
   Els1GH82Y5GIkzScVkJ93Vts+TuAhOq3mQ1qxwTZSMPMregjlNRG5C/Zk
   WfGpwFa3puBgj975InXdRwoYw6UhdnxiPcpN9EIbwRGktKnLx3eWz4xql
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36565292"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 13:32:33 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98CA61706D1;
	Tue, 23 Apr 2024 13:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713871949; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pCLoCC6GOo9gQ9iL/Fi4GAoIoWICczCG1YlZoCwuv8U=;
	b=QhwY3aund2zBHehIjbkKKf5Dw5G1hphylELqCTpdTSET2ekepXcgiNkrfK8NHecF4DHTxQ
	PkMULW0Skx2/pwI1AvLSueg82jzDHcxTw5mqVBM9ByNzx2sFDKp6tT75eh3Jwq/te5TvxS
	qWW7A1dtaw6RIsA3yk1XTot8iwyEHvUQ06kSTZRvTHc2ZKeUU8VwHyDdvEFAsf8br9I9RW
	sTu7McLyyPVLs8jH8+twgeMOqGBUZX+MLGCiXkK++YPJycnmzlffMRhvbfnpryK1SvvUdr
	ILKIdvSgwyC9g1njHtW9CNwYKOeoPpVL6UU6y0FWT0+58Yni7C8Yn85UAHXigg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: freescale: tqma8xx: Add partitions subnode to spi-nor
Date: Tue, 23 Apr 2024 13:31:51 +0200
Message-Id: <20240423113151.2145120-7-alexander.stein@ew.tq-group.com>
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
 arch/arm64/boot/dts/freescale/tqma8xx.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/tqma8xx.dtsi b/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
index d98469a7c47cc..366912bf3d5e5 100644
--- a/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
@@ -61,12 +61,16 @@ &flexspi0 {
 
 	flash0: flash@0 {
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
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


