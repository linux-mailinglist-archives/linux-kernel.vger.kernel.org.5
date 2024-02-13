Return-Path: <linux-kernel+bounces-63736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D420D8533D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699721F2CCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8E5F852;
	Tue, 13 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x9VajuEs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299A5EE74;
	Tue, 13 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836181; cv=none; b=Prif1gKjONtLIZIbeNFzK8+n/cdZ/KEz8HUvdkz4v0FfiNNQmlE7yzxvUDHy3b9dBPnt2If8B2QAfnQO/fWu16rLj4J9mV2IcEY37tjRpakVipV9mqNiWunMuBvzHPW+s2iUKoFAzdrGYhJrxaSPxT1dk9xlIpJXD+PtuLrJO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836181; c=relaxed/simple;
	bh=fwm7IvpVj/fw5X0jlvNJTx3hGBMtAxLOyuATPE9ICMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLRisPU7h1Wi3G+hbyR7kjfxZSjA7jTEGSgybEVbTbVd35Ool0AVS44psS3c0DXXCKYSnYL2o4Tt0Hp9IyIj4e7KgsL5AnISeSz9rwhdp/JAql/hEVBgtFqxZRce8omdmR32UeDE/iwcjU+uVsQHLY1CxxsdkoGBuM40iNz+eT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x9VajuEs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836179; x=1739372179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fwm7IvpVj/fw5X0jlvNJTx3hGBMtAxLOyuATPE9ICMY=;
  b=x9VajuEs1B4XONcTUSFd1nyfVFtHZUHRqCPrertuYgnjMLQdnUBe0hRx
   pOau6lrSVJW5m0jwt3g42LirYGv+Az2SVNoOrAxJpPqJz/9t3NiInzleY
   3lSebh3Aj90hY8xB18myWLauJ0P0Z/ET8rKos3CSpz6rLR533jgO4kgBp
   rA6qTpp4YjHmsNK7lqJ/7d5HpsQDeG4lm3X5/yPaAeeMlufIroVsl6Ua3
   4nxHWHPHMeubjcx5AyksMCfn+ZfBj2rFUwGorC9KYnFyN9u0CeSj6txXN
   GuZwgaArlQQiS9872q0Lp0MBpj4AIg5oIBdNoqhQ1H2U2B1oMijrdh0QT
   A==;
X-CSE-ConnectionGUID: notrBuGtRbuSS13mA3DSPA==
X-CSE-MsgGUID: ht6/YnX5Q/SodX370MUNQQ==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="17608936"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:55:51 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:55:49 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 0/8] Add power-supply properties for sdmmc nodes on Microchip boards
Date: Tue, 13 Feb 2024 16:55:34 +0200
Message-ID: <20240213145542.23207-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds power-supply properties for sdmmc nodes on Microchip boards.

Changes in v4:
--------------

* Simplify the commit description for each board to have a better understanding.

Changes in v3:
--------------

* Update the commit description for each board in order to wrap the line at max 75 columns.

Changes in v2:
--------------

* Update the commit description for each board.
* The goal is to keep the vqmmc at 3V3 in order to use the sd high-speed mode.

Mihai Sain (8):
  ARM: dts: microchip: sam9x60_curiosity: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sam9x60ek: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sama5d27_som1_ek: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sama5d27_wlsom1: Add power-supply property for sdmmc1 node
  ARM: dts: microchip: sama5d27_wlsom1_ek: Add power-supply property for sdmmc0 node
  ARM: dts: microchip: sama5d29_curiosity: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sama5d2_icp: Add power-supply property for sdmmc0 node
  ARM: dts: microchip: sama5d2_xplained: Add power-supply property for sdmmc0 node

 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts  | 4 ++++
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts          | 4 ++++
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts   | 4 ++++
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   | 2 ++
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 4 ++++
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts        | 2 ++
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts   | 2 ++
 8 files changed, 24 insertions(+)

-- 
2.43.0


