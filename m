Return-Path: <linux-kernel+bounces-54847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741384B46A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4841C2376D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F7131E28;
	Tue,  6 Feb 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BNbzBAtW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC7131724;
	Tue,  6 Feb 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221021; cv=none; b=pRckQUocDxGrW0wSkAsznHfSR4TUKVjtEvHYm4qAlnkShSNp//8oVZxfv0GHiCLHMiVdnkTQlQHSBnVVBAHui32bdQJilpJv6A83PFxrlr2zvgEyOf82e62rFwxtZxNTqan5yXrh/VZl1Cs4oBz2f6vfIx8r5wFJom7qjKCYTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221021; c=relaxed/simple;
	bh=9zvRD5YBoXZNvbT8j3wz0CT4k5SQ3aFUhwCi16/u9Jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gftcp+WHNO8au1xlLSeCLZ2e8+WRDmiViJZ+H3vOdcByFjqezwZ9dBUIO+TepSQy9DBkTaxIC8KcrA+bKyjXwUoHSO47EIQzmUw8z0Xpt5b4FKhBQ+cs033HVNgbH3dPDZeUhabJTEqAz/V4nZFS6OwypIzVFni1lEo5OpIMy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BNbzBAtW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221020; x=1738757020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zvRD5YBoXZNvbT8j3wz0CT4k5SQ3aFUhwCi16/u9Jo=;
  b=BNbzBAtWAyKQx3m3PNp1ugRxdkPc8yujua+lyVXUn0JNwn5Rxurw/gyL
   y0diGzTfUTYr2TN7qIg3nV4MgM6zwpew/NfwsTcL/Y36M7Lq1dK16w5GJ
   PsQv5+qEFQet/pvU6iRO1dxCmG9Jpq/Y/Z1W09KyspIkoYfpWqW87gUkr
   YZMwu19/pRNYE1omjr7lRs+1/B6KTG+jMzWZf8+a5RaCxF3vs0xKBudGj
   Pfg6SCLRlDt7M+xLb8er1HZbUalB5NQx1y5tuaTC5Pumh3oj6aKuQrhLP
   7PoTgYhp/efcc848XZ8fQoeOATtQV0v5VPYZdHRJOJk8zss6RdkwfkKKB
   w==;
X-CSE-ConnectionGUID: yTxsI0ESSbahg8PzMhJ7Cg==
X-CSE-MsgGUID: aPB2pkhHS0eSAZPWNdbBXA==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="183097590"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:30 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:27 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 0/8] Add power-supply properties for sdmmc nodes on Microchip boards
Date: Tue, 6 Feb 2024 14:03:14 +0200
Message-ID: <20240206120322.88907-1-mihai.sain@microchip.com>
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

-- 
2.43.0


