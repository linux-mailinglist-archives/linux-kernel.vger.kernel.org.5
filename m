Return-Path: <linux-kernel+bounces-63737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6F8533D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5881C27BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6765F85B;
	Tue, 13 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nfJhwCAO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1085F470;
	Tue, 13 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836181; cv=none; b=Za8BJIpdYz2BJ+Czpogw1UFUDBXx7s7ylnYe0n/SxIXx/PKrt3rfKWIbpFGeE4g/whPBuKjxeYKAWobMFwDKCgLwINk6IpX1rll7KTvbHm3yxuLNFcmxSqju0NdOH+NssHxdpLqMr1AcjY///SRv6QotIe+z985Jbido+szB/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836181; c=relaxed/simple;
	bh=/Wv43IiatSBhgQeyU96qzaAXk4T1DS9aljrYWfQxzn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9bMdbKMfb6N0n5MgqeKEMglbpwkewJBpTIbwwqRxfc8a4kVkGk64VU0WNXdBDcNc92D7Gue2ljysSMl+US/cfUAx3nTvp8xyuPrB0dL/5mwBKv2L0jAH0ywfRtifAVrEtpuBpCG7okEzDPMaQm8l3vJPqe3CIv1Oq9U0pfSJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nfJhwCAO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836179; x=1739372179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Wv43IiatSBhgQeyU96qzaAXk4T1DS9aljrYWfQxzn0=;
  b=nfJhwCAOVT5Pr+KmqRPh5XbJhC9cUYIFwvnIn/t+9UGDPr0o1GHNabJ1
   4qM19p76bBJZSfUIv7m9J0NF8iLiAiKnYE7b2jaPL1CAwq7rbAXqyfOxk
   8TsKBJkNDfAlAUhw5XjDWpuIXBDHwEJtBjMR3Vm8YGKIE6kXHUdulGOCf
   3DAEfaidmbSwM0GBxZPFoo1bwsUwvLm8sOgJHAF8+oSvYuJ+Q2rb+JpnR
   7mjHRoQpWCJiCdcMI5mIy5+C5uAKcaQfKON9aZ05+O65FRT3hiS4iswOA
   qKk/AgYTb+l4ExYHCWAS0sDsSXMoSpz53AU1RlON4TUjAzurNsfARqfJD
   g==;
X-CSE-ConnectionGUID: 1b1+m5inQImh9toRpU0rhA==
X-CSE-MsgGUID: Jn5SHDitSUyOh98e+vyU4w==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="16174937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:56:08 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:56:05 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 6/8] ARM: dts: microchip: sama5d29_curiosity: Add power-supply properties for sdmmc nodes
Date: Tue, 13 Feb 2024 16:55:40 +0200
Message-ID: <20240213145542.23207-7-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213145542.23207-1-mihai.sain@microchip.com>
References: <20240213145542.23207-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..4a86597d089a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -504,6 +504,8 @@ &sdmmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	disable-wp;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
@@ -512,6 +514,8 @@ &sdmmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	disable-wp;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


