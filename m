Return-Path: <linux-kernel+bounces-52175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340348494F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D30281EE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FED1118F;
	Mon,  5 Feb 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RObLZ/qU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BC10A34;
	Mon,  5 Feb 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120103; cv=none; b=iFqwjdb5aDVzbuYKULEOaqgRZ7F3eckYgiOFb7hG1bwoDqQxjukKe53xfXHcFe1L7t3Ppt6hV1hhpzlmykH2yYV2nneALrvNzmV/Qivi0aMZDL78PEURj4aDbzuO8WClbYhRCAkyNFVHviiMqK5D3RfnKCNgHYLxdwkDOXS4ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120103; c=relaxed/simple;
	bh=dCiQEjZoGmS16QNi8n3ozD6UbwOROTNyLBweriIMicY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2qWMq+BVx+JsbymsTgNOEpL7r9EKm5IJaB//bZgVlI9DPnVa9Vgpy5aK78+92NtFIgcdNFgQy4a9xfH7LNJAkeTzD254QnHZt3giuYHg6XQMXXkC0ZcR4dhOnrPQGmIMZyfI/s6IqemROBcWZOIRVX93piT6oOZXUxcPC5lYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RObLZ/qU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120102; x=1738656102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dCiQEjZoGmS16QNi8n3ozD6UbwOROTNyLBweriIMicY=;
  b=RObLZ/qUfoA+Q8RIbQjt1fatz/LRfVnNGpsTSIY3lM+IVWA91Cz4veLO
   xqGP9AjUP1cGktH0ko8y9BHCeULtNmAUl6hmRckg0ukWUK6CccoEv+Fir
   SOXmEX8AjzqHlGSGR7zO+PAjUdc8YZrGGFUFx3FTBYD76FDtbWaxpZF6l
   kgq8lE6NIZvOAyEykEKoI1b7hA9TaKVpbfmRu+Chz8kN6kyfVIs6cMBeT
   8xdT6dw5K/XKTcEHPemJC9WvEOyUE7jdu028xfcCCua1rXvGm5GSNhUI6
   5Zc9gC69BgS4VeoeQCIXSTMMCPx5HAKbQR0nsOlX7Omuxiu+OSQ5G5JsK
   Q==;
X-CSE-ConnectionGUID: 1JwZkZwXTgeqgwiZYsse8Q==
X-CSE-MsgGUID: c+ObYE+uSCWH8hIRClp1+w==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="15756771"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:00:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:32 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:30 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 0/8] Add power-supply properties for sdmmc nodes on Microchip boards
Date: Mon, 5 Feb 2024 10:00:18 +0200
Message-ID: <20240205080027.4565-1-mihai.sain@microchip.com>
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


