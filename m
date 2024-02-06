Return-Path: <linux-kernel+bounces-54855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2084B485
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725E71C23A06
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1A1332B6;
	Tue,  6 Feb 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FKGaskRL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C4132C1B;
	Tue,  6 Feb 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221049; cv=none; b=EV6FteGLJi/2mErs/h9bn/mtb/oWYintKkSNONnh1/tjNjyRB4iAUZzHqBSOcD+8RqEtUp1nEJp5xptoEwTo60qMAbStzcZsS9Fj5NELMPWmFPXeEiucrvfY7EsNkVs6aJU9ptiAcJRC1bex5/p3EfRNkTlXNzXZFpNz1CQubEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221049; c=relaxed/simple;
	bh=gxp0aYbQ2ugpPKEyUXMzSsLLT/uKXw4HcUWO4ZTthg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCFMHSBBgG95yP/OiaPOxTGXeNpoNhvusdg7qVYUquo6rjzAqMrSpmDzUYmDcApt14CZY3yFsYJjxp7Q3A6hvU0pDOmFyxFLzuw4tdZbjXa0hrQS42oxwnSo8EA9HCBNTm4YxrtQPxAHVt4isL+so5DpNPGeBTNCFYrMs7EuiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FKGaskRL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221047; x=1738757047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxp0aYbQ2ugpPKEyUXMzSsLLT/uKXw4HcUWO4ZTthg0=;
  b=FKGaskRLlCi5dZ6p0l0ayQBpx8W3VS4ipooE2TLbcs9q75aqWPZXwMvb
   N+4FIEkokILXtObRRhoswTOWsjnHa8ouugSvHCPBITRiLPo3XGl4RHaFM
   4nEaPUco1wGdSsTfg8IvtH8BHYNF1Gi8cA5FweB0c4HK0Si6HzYpgykB/
   /5sjC7DhaKtWP67T8b+oRWImuMILLYx2x21ddb0/tHqPbOwOdVsAp0sF5
   4tRnlQf88LJQPZqyyjljoTem0iLObzPZsRDtKUYH3BmNu/H3rpqvDQC1N
   pNEvIUseCLU4YvH90NgdclaDdofK/dUvhEA81D5fazKVZlaatuCFTB3cw
   Q==;
X-CSE-ConnectionGUID: /iuDP2QxSliEsbGRCUpaQw==
X-CSE-MsgGUID: x2dTOowiTDySOs3/yErIIg==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="17200244"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:48 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:46 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 7/8] ARM: dts: microchip: sama5d2_icp: Add power-supply property for sdmmc0 node
Date: Tue, 6 Feb 2024 14:03:21 +0200
Message-ID: <20240206120322.88907-8-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206120322.88907-1-mihai.sain@microchip.com>
References: <20240206120322.88907-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.
The sdmmc controller from SAMA5D2 MPU has support for
IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..adcb3240e5f5 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -712,6 +712,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_io_reg>;	// 3.3V
+	vqmmc-supply = <&vdd_io_reg>;	// 3.3V
 	status = "okay";
 };
 
-- 
2.43.0


