Return-Path: <linux-kernel+bounces-154993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F68AE417
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3AC1F23263
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B3F84D03;
	Tue, 23 Apr 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XShhd4kk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="a/+pDAvL"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9D12C528;
	Tue, 23 Apr 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871945; cv=none; b=kEO69x4JV9IG/8OANKalB2oGWDDP8Jaw3St/1Y1eSvP5e2s6gfaba4fjXZTuO7DMVqJS9xaTEDZyDzkAKt7iWPUkjTCNAmGfVFmPmasrafNBZlKupPFVkk8mKLVTcLbtOfoYqBRseaye+B3Je28b23dOmtKEQb4WjGy2oUiOFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871945; c=relaxed/simple;
	bh=Lb2kOyHxBVlOnPPlUA8MC8Rt8ZJwg9oOl++BmjHPGFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nt3BN4wec588d3+Q0LQnuy1G+CTxf0t00yjz+K1aBlIDS4RZGh9K+kmIvTFV7/sDnXNfDUJ2SeSaRDJhB0n8VhSRO+qOvN9WSJ6yaTwzCKZYqtxy+/YvhO385qyhxEfLpDpx95fC9/ErtabettizE+zs/sWUO1bSAebvFJwxwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XShhd4kk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=a/+pDAvL reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713871943; x=1745407943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHGaWNydXvipFKi2uOhyOlxIuJUsH0uNjrD85MUH+mY=;
  b=XShhd4kkrCLfwkYIIxpQwEm0EMSrp3prwzZATc6kzCqR9oFmyXqvkIiV
   xenkx+1DmH/DJVtSSagSs6CIrbLVK3YKZWoQAMDDPB3iEPr5ph5FSoR0l
   aysvRsr7Zs7xSqUgNc8nK/JpX8Oz0ufxFaZTzR/LkLSK0i0k3DKfOIvYW
   1oq0BcU/wA7HMgaFA6QMlYM5Ej4n6xpI+3q0iIBM7yxI+YX2KkJ/FnofI
   IKWgVOoMhiLULhv04z6Laq7x8lJmPb59/0fWrL8euHGQA5IAuTdvFCVQj
   ZkMpVsiCjcCTR0rF0ArSYZir0JMrxnf3H9tuPIp0XVkFvmmn8XIe88wL2
   g==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36565278"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 13:32:22 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFC0416F693;
	Tue, 23 Apr 2024 13:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713871938; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IHGaWNydXvipFKi2uOhyOlxIuJUsH0uNjrD85MUH+mY=;
	b=a/+pDAvLD4loevnWfiYm9xbOo+biD3JPBluf3IQVRNppTTUJbhYOWpEJ48rCcmS4Y+HfHg
	2Cy6ANh2lW8Ba1yFWjk5QOfNvcdqi8KyVJP3VWcavuiGumDcR8ho63b8zsOq0R6FiluPse
	64QwviCByZRLZCeXmA9+GSgg2bN2nIRneXR8c5aukEND4ILm7fYABTwycynwfxE77CygZG
	Y3Gh+YgoHI9wK+OKozwwbTKgaS6+NvK0hEnOE3TJzSjWY99DWbGMN9cR0cb/UxJn8SbF/7
	fkQXuwlxWYMdCZu4OetYMVXbJ7M63j/6iyYa5/qXG/ThvPZcciUE0QhddwB5MA==
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
Subject: [PATCH 4/6] arm64: dts: freescale: tqma8mpql: Add partitions subnode to spi-nor
Date: Tue, 23 Apr 2024 13:31:49 +0200
Message-Id: <20240423113151.2145120-5-alexander.stein@ew.tq-group.com>
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
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
index ebc29a950ba9a..336785a9fba89 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
@@ -45,12 +45,16 @@ &flexspi {
 
 	flash0: flash@0 {
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <80000000>;
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


