Return-Path: <linux-kernel+bounces-52174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C397A8494F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0226E1C2074B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662E11CB2;
	Mon,  5 Feb 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LHRGZhjJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B512C11197;
	Mon,  5 Feb 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120074; cv=none; b=oK2d98XFzSavBPGYBIwMEmFly5+GPxFD0cXdemVD4WzsSgshI543K4ajavHXm38ER5ohaimtp6tvnh+nS8WaYnSnStuR9yrOeTvmAPLOGuoP1Bbye2d+tBVRj8950GPL/1VVdJ99qdD2ROd7ea1wpTRTkLVTSu3LkTUoXq1CjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120074; c=relaxed/simple;
	bh=520kbFokQfIobK/X/hSbAVFhFZ2E7Qd+bcOJ67BSKjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdudzmX42yB0L/yIC/BcyBTdHteGNQbSgsMV69pucUcltCzu6EwaehhyriwPU50gpMsTHzqDbEwQ8ahhDYxIgXbbD02HkZjAipoyp/f7IUA2rttEqBOnL7fPjio6Z1lh5dHzTMU6yqXncDiN+/aFpukLX92GG+JQXub8cTpt6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LHRGZhjJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120072; x=1738656072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=520kbFokQfIobK/X/hSbAVFhFZ2E7Qd+bcOJ67BSKjQ=;
  b=LHRGZhjJEzewHdupdPef+mWdI8xVZ0vuYudEbsNwKtzv3ZIITG6g9Xhn
   qDOYSfjzl5JZWrOkF0k47Xj2vmVFCPaS6GeyE2Ubs2Aq69em6TFxdG+Ub
   bec//65TGJ0J43PTPm0nVZCE8LXtKwkRZzOB78LcQ+UojZ/KxQ7/uS09J
   yFyuxqCLSUrhk/9kIt8pjmKrGM51rVVDGtz6HcI5Sfhkrh7th/fwJmgzA
   L0eca150jtUNS1iFwFGNwYm+2rJT30aNLznh8ncZLhIHEFY3PF/vMjtwV
   JnhxXWw1Hy1veWel5TZO51gYByuXDpkd9Tkg+NQJTOFSGJFfvP0IyCB2u
   g==;
X-CSE-ConnectionGUID: z0tAOx4kRimGrwt021s81A==
X-CSE-MsgGUID: 8lxLQdceQHiS+2N39cTx4Q==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:01:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:50 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:47 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 7/8] ARM: dts: microchip: sama5d2_icp: Add power-supply property for sdmmc0 node
Date: Mon, 5 Feb 2024 10:00:25 +0200
Message-ID: <20240205080027.4565-8-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205080027.4565-1-mihai.sain@microchip.com>
References: <20240205080027.4565-1-mihai.sain@microchip.com>
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
The sdmmc controller from SAMA5D2 MPU has support for IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by the UHS cards,
keep the vqmmc at 3V3 to use the sd high-speed mode.

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


