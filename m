Return-Path: <linux-kernel+bounces-52183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5D84950D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911671C231D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32B12B8B;
	Mon,  5 Feb 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="USsfFyb9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595311716;
	Mon,  5 Feb 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120259; cv=none; b=A1W72dO1mlhE3rXiiulDgdIMoOkYITKu5Z/PV+FkD62f94GkB3PwpcSvKK9VhFTh6YaHBGcBbadITKEb7NNe3kp84qgKf+3CuY2UeV33T0EOEgxXCLxDgVw5h4ERKFtWyzopyMuBEAU+jHxq9a6+O5/OHy3YaOG8pOwCOcQL4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120259; c=relaxed/simple;
	bh=wHJZoqIwYywtidkx1yfqKVvRCuC5bsMb4/F4Nf1VpF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4bknvGmMEiFMXL4nE5VcqGR8deJw2K//XVt5eoOz+ia1fhq0tpR/BPKkfeIcCLX7VMiZREBef7MxvbcNeLSERh10IHtk8l1X+eyQlxeI4/7u4O+C4gi7GcXtvL/1NCE1OA2uvk+EszqYxjYwRlNYj9J+rjDM8iGJaNf4les61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=USsfFyb9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120257; x=1738656257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wHJZoqIwYywtidkx1yfqKVvRCuC5bsMb4/F4Nf1VpF0=;
  b=USsfFyb9bUF+ICK/y8uDZC6zFMAzDmJqZ696AtJtYA3GmIfPS7RofaTx
   KbMNchlW7bIWKMa0C28C7XzeRMrRQhYo4vGKrm7pg+84piIMLExEz4iMm
   J07qE+4VRTgug3yv4dQCF9+OwVJmhOL83iHmNRngV88/ZHi1FH+qRvUt9
   ErSZSpx5rocpX8p/TBNfj29vIln9tmESaHjJZZiLeg0P1GhaGCiVmEbnP
   sywt4R9EenULbuS4AG31cBynN5QNQ9azEMJOUpaBXxqJ4l805M6IKDFaA
   X2okFnXRVSM5IgWGLFOByC44KbMwS9toQpC31o+F1iEAH5/zNkDLZsWGo
   w==;
X-CSE-ConnectionGUID: /sWzmiszTQ2ztYFgEFabog==
X-CSE-MsgGUID: Mu8PqQLmSz6ZXDJ29R+fmw==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:01:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:45 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:42 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 5/8] ARM: dts: microchip: sama5d27_wlsom1_ek: Add power-supply property for sdmmc0 node
Date: Mon, 5 Feb 2024 10:00:23 +0200
Message-ID: <20240205080027.4565-6-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..7b36e1970bb7 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -199,6 +199,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


