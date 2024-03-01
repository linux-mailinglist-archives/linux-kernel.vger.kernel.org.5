Return-Path: <linux-kernel+bounces-88152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034586DDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634171C22D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B846A8B2;
	Fri,  1 Mar 2024 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Y7X6e/4b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NmnHWLkn"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7A6A8B9;
	Fri,  1 Mar 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284479; cv=none; b=tgnz9Dz4gyae5F2qoxY6f7fG7kr8lSS0GfsOaausgbAV+P61TktgKLULv/WV0PgeL4MQZnJkxN/93BQKZOQ8Xx1IW2BCaQ3bEUXKR9KCax/rN5Q2a+KUSq5CM0AP2CEfElOYaVnqKDHvmSOAxJkNDBYz3h42Kxx3XBahIm/pMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284479; c=relaxed/simple;
	bh=aL5CQ+G5H5XzR83P/AruggKM2ubSymJpW7MKuPTBGKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g10Z/AKXsMBBvX6BGEAN5CYe6BHsRLtqbFywl/+Cvv9LXnIYccgkdu/edDDR7XGuCLFWCod7wJz2B38IjSZpvhZu18CTScY6P7EKOc1pnyXyDlrNS6rmwESTQadH4ObUyBa+SiHgqL7jGO/MaGzBR9wfh3OD54vuX5R3/F6lB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Y7X6e/4b; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NmnHWLkn reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709284477; x=1740820477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3nkX6Fj4AoyKyoMjYF6lXx9IwApyCGGhrQ0iU4llyPg=;
  b=Y7X6e/4b2vvMdmoZK22PVWsrYeoFnyU1vmkD4X921ZPdYwV7hgKyB8rG
   07ZYDPN/33htEvSAVx2NVBnGPaM6YFqPhKxVQ4TeyrwbrcKKXDrk5Ukp2
   OXK09gaj2ejU0vS90W62apno6iSCVZ1PwPbuC2ldyhd3I3xcEc4+wGWZP
   Cb9aLl9Lqifrrml9ORXO+BJrzV1y+nTWdmAt0TjeuWzXJi4+82P7yc7BC
   gjN69h6Kr/ipmQ9iqXuPbpO/hlYNSxbeAOdd9UD7iPNsVGIPAUclfx9N5
   5d/rm1nlTBTgAP/c1V2B8pLpOg7eQpyOwW/3hBfscVBrIXa9lkeSLRLLa
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35682456"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 10:14:37 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 622DE173575;
	Fri,  1 Mar 2024 10:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709284472; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3nkX6Fj4AoyKyoMjYF6lXx9IwApyCGGhrQ0iU4llyPg=;
	b=NmnHWLknJLEtsz4Ao2II/7+Dmoy3Txa++ufr5UIozKrWmueb9AE7ZtmoEqObI+MTLCtz7g
	FmkAvqRgYiFZyDLffA8OaueQ4RqR2QbVNqUxyDx/yyHpyXxLcLXPbV1Q4EbtPC+gB+Z4D5
	55KifRyYqQu/JC53q8d1Hd2ckhgGGrcDNRIjAbxkGGrU3JXS6Lcs2AQ1H4/HXHaYT6ryzZ
	JmPIHQ8MfS6fkl0B3mzjaDsPnkNoT8yNX8wytp9W81dQ61Y529/C5WG72HIm043yrI1TqX
	49LJVDVfxQUQghlqk28pH0+hbpCZg4S5OOtMDhOyoTE2ndZtyLvLiJOx2zQWTg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 3/5] arm64: dts: imx8mq: Add empty DSI output endpoint
Date: Fri,  1 Mar 2024 10:14:11 +0100
Message-Id: <20240301091413.3050689-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
References: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Also add a corresponding label so overlays can reference that node.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 74523fa69a5e7..5e906428d5e70 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1290,6 +1290,13 @@ mipi_dsi_lcdif_in: endpoint@0 {
 							remote-endpoint = <&lcdif_mipi_dsi>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_dsi_out: endpoint {
+						};
+					};
 				};
 			};
 
-- 
2.34.1


