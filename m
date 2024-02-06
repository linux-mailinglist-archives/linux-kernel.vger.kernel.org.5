Return-Path: <linux-kernel+bounces-54854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E743284B484
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11D02881E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0A1332B2;
	Tue,  6 Feb 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NdWmnjNW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DD132C15;
	Tue,  6 Feb 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221049; cv=none; b=cpaau7KReZROtRFgxmxE0P15WAeB57zrMYQRuk3/MML5Ya/mEhI+gwrvFUwucQdY2PRio2g70ulO+ve9Ecr3sKf8GK5xK7382XLAG/zucnSA/Tta5EJqwDzXJSzKknDIm7bujomMgG/nlZ0AEd30VpaRigJa9ithatQ2M0oMiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221049; c=relaxed/simple;
	bh=q5AQrYWB5lwDHhGNPklEX9DOip1NJmdov5PmWLB1Rm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=badzPTVTtnySBdxB8/PTJN7G2vWT5GHz97xT9s4zjtH5bXkYA6mYCX4GQKuwV4UbcCcsjazjPfHWvOzgqAnKPp9yc2Jj+kD1n+UUkzUnF6AiZcg1+LpHyQ4504JuAUgt7NLRKTU59vDxyjnAcuv5li4qfpJ4H+pC1GuOCkyo/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NdWmnjNW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221047; x=1738757047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5AQrYWB5lwDHhGNPklEX9DOip1NJmdov5PmWLB1Rm4=;
  b=NdWmnjNWOcEqLI766G5BC87BxFkxC4Akqw7Og+R4f2XlYNIUUpSmWDzo
   uSdcPhm4iXj4Hi4gvMzSkCRwG6eokrHKH6o0WEkZqLPmhLvKP+hYy+1Hf
   JnsnoIQ9T340M0k51cimPykOEB01b+6bpjLH4RsfKZzS76Uyxek7Pqhm1
   KNR/qlR/Aa6DuV8JgRJGpeYC+qxTs0YiKl/q07dVz76GIIxE9lINZuCWv
   hV4CAT0KQ/eXoM9trgfcancVP0qJC1C/wZg9yI26ml5bFU02BZjEiI+VD
   ogWrFjOVjoTppBllxzF2qjnmByGLuV1RNwwCqSPvpsExha12p4Z0Kzv1D
   Q==;
X-CSE-ConnectionGUID: /iuDP2QxSliEsbGRCUpaQw==
X-CSE-MsgGUID: uLKTaMpvRyWh4wCyip561Q==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="17200246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:51 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:48 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 8/8] ARM: dts: microchip: sama5d2_xplained: Add power-supply property for sdmmc0 node
Date: Tue, 6 Feb 2024 14:03:22 +0200
Message-ID: <20240206120322.88907-9-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 6680031387e8..9b7e56790a5a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -67,6 +67,8 @@ sdmmc0: sdio-host@a0000000 {
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
 			non-removable;
 			mmc-ddr-3_3v;
+			vmmc-supply = <&vdd_3v3_reg>;
+			vqmmc-supply = <&vdd_3v3_reg>;
 			status = "okay";
 		};
 
-- 
2.43.0


