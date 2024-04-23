Return-Path: <linux-kernel+bounces-154991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D318AE413
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BC51C22374
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67E127E0B;
	Tue, 23 Apr 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YIZvAZy7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KriSuQqY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB2C83CD5;
	Tue, 23 Apr 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871934; cv=none; b=gYQeG1z5ZfBo1EABjshmPguIauQSnnnGBAb0aTgm6f9ki0G20CHpx6fmNTQAr4MZv5ozRNCY8d+nTRi1vdE973TJHFnxgbiLHrgpLwmW5SGmrVKrzmSmQND5nu0BwJLTvtQVBBtesIKuW+oeoximYjK8a5+goDTefxSYXG/Aty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871934; c=relaxed/simple;
	bh=b4tnc9QTsbzXFSRUBz+Hjbd31NF3VBKT/VyV3uaV9Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsymoLPM9yZGmVHQ3yg9Mm8pVIDkFL9DbwHi2kIgqMQ7Gj4/bndJzkDzEiFqd+k0Dg7Q7eS0o7l9xYUvf8dsUV9EoHDnYZqRsAXtkL0qTB14jjH9MtC9TwmVKpcUw6YG4U5a2+k1z4nhYAat1lYUszQDe6ZbVlZcFwTYHLUHkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YIZvAZy7; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KriSuQqY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713871932; x=1745407932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snX5lHY+6h5NMtxReHQmGgvtWgJjZ/5Cp+LMYtyS3Do=;
  b=YIZvAZy7KZJ63Pohx9n3kX+XxwQ6ADjRh7w/lOO2eaPwsI6joVKS08g4
   8MVAsV05VqGSrDJgYVGwG4LE4kLk+EhHhx+twI4je9JfLV6FMa8I4o9Sg
   jlA7ABN1BdcO7UcdCgSyxCcKMFq4OQPFNhztr/r+d3qxMNwHhkFaLLtX5
   ZAtnQHwve/e5/GZoHH6o16STCRQecELmGCi4L4XBdBrTpf2bPnp+Wh2Hg
   4CvNANZvcHLElnwVuLENHszim3mqMqAuS2sSQLsqeRwWD2mJhPnmk2PbB
   034+di6Bgqc0m7kWKbks70H+oe9w3k5ssKv47MQ10QTEBnY8Lo4dmlanf
   g==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36565272"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 13:32:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2588416FAE8;
	Tue, 23 Apr 2024 13:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713871926; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=snX5lHY+6h5NMtxReHQmGgvtWgJjZ/5Cp+LMYtyS3Do=;
	b=KriSuQqY7DKVcSU613RwUXc74k/09NQ3qauZE1DhgeTTAtwFhkTbpsF9S/MlfSqH7wcwGe
	TZ1Adp8wGYS3vvFiNaMef/UFdU5pUe8TfM3g+NML1DTk2ZJTo5W1K+fdLuR5jDLqQPwI4k
	MFo5uIaylX7wP4JYj+pknJ+CWuAO3NYKLFFU6nDLtH6fFHtNzsnn7Fo+VtJiMQYJ+PneEC
	2Wi5vZKUwG7aJdh6++mst/a123OKXJBZt1APUHI2W/OI493tXIL2J35w81R/2kVlCio5wI
	ihFgcPVetrmpEt5R09R0vkTAGzYWBbDioiQYEHxQWWZlrYzs35JMRP5E9FCioQ==
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
Subject: [PATCH 2/6] arm64: dts: freescale: tqma8mqml: Add partitions subnode to spi-nor
Date: Tue, 23 Apr 2024 13:31:47 +0200
Message-Id: <20240423113151.2145120-3-alexander.stein@ew.tq-group.com>
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
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
index 8c0c6e7159247..ca0205b9019e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
@@ -62,11 +62,15 @@ &flexspi {
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


