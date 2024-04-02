Return-Path: <linux-kernel+bounces-127615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E0894E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F5FB22743
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF355733B;
	Tue,  2 Apr 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="utgsGpse"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8133D1;
	Tue,  2 Apr 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049331; cv=none; b=ubrGIdjN5QZ9cBO4zhm8/Q9XEwGUU7uzdjZ8+DapLeOUzfeMq5OS4CWoy04B3zoZX+gf1tfXjmkrl1OaSeCVp59UBrwlrbX+6B3hDMKvUYfcoE1WamFHuRtzC7i2C08in8x7laUs2yChhEpaFCmoBmfHi0R/HA2ygR0Sxd4SFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049331; c=relaxed/simple;
	bh=rAwYcdGVio0uX/UWINAikdZ1Y/EW96aT37KzWfgNLh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cwxl23XoJpc4/xQWT/pISNwnG/UuLSJwBlS26VB9ZCO0Y+L1XGwUIi9muV1QIC/gGj9CED6yi7hrZEw/mENZLrH8imKga7dyrCZC106npNV8MnuzX/6RBywPrmBsiA886eApXcOSx9fspXOfiANZC9qej1SvR2KAC2BUZ4TXnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=utgsGpse; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712049330; x=1743585330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rAwYcdGVio0uX/UWINAikdZ1Y/EW96aT37KzWfgNLh0=;
  b=utgsGpsel3HOJNNT2moo4uxvwuiFirvJ1Fbw3LabwHGTychOCwnQWyfs
   vDfnMKnNL47iGrc3HrBsTaD5g6tReO+NWtXSfkyGUm3ZEDI8z5MSrxrDK
   E24WE7zNg7ZpHXJCYYHHn5Tb/1mFaMVLOTaQJ2RYO/+3e9vuGL59fIxG/
   w8WETb3LeajxFCUBANJiQvFFVHRaFCQmYc05vpWgAvvD2GAb0pHIv0DJh
   sEx0QqFsiIdy0BOccQrwFT44G+j/W8+dTEtRXfjcBrdZVBmRmZDF57nQ3
   hlYYkyUsCdUIX6QIoyetSODQQf+dDcJHWEW1SzPNnIDcgrS3iODvwAAjX
   Q==;
X-CSE-ConnectionGUID: zFoxbXw+T1mGEU4GLhIt2g==
X-CSE-MsgGUID: WLSS4/PNReG367SmyZjNsQ==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="249915446"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 02:15:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 02:14:53 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 02:14:51 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/2] Fix the regulator-state-standby definition
Date: Tue, 2 Apr 2024 12:12:26 +0300
Message-ID: <20240402091228.110362-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

make dtbs_check DT_SCHEMA_FILES=microchip,mcp16502.yaml

at91-sama7g5ek.dtb: mcp16502@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
regulator-state-standby 'regulator-suspend-voltage' does not match any of
the regexes 'pinctrl-[0-9]+' from schema
$id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#

at91-sama7g54_curiosity.dtb: pmic@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
regulator-state-standby 'regulator-suspend-voltage' does not match any of
the regexes 'pinctrl-[0-9]+' from schema
$id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#

This patch series proposes to correct the typo that was entered by mistake
into devicetree definition regulator-state-standby by replacing
regulator-suspend-voltage with regulator-suspend-microvolt.

Andrei Simion (2):
  ARM: boot: dts: microchip: at91-sama7g5ek: Replace
    regulator-suspend-voltage with the valid property
  ARM: boot: dts: microchip: at91-sama7g54_curiosity: Replace
    regulator-suspend-voltage with the valid property

 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts | 8 ++++----
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts          | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1


