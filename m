Return-Path: <linux-kernel+bounces-48820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230D846207
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729C6B284AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00E3B19E;
	Thu,  1 Feb 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P5AynUl/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0981E48B;
	Thu,  1 Feb 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820149; cv=none; b=QJELNiKHPWELBqzKtXgoG38hK5NMoLym4YAPrNbA0lpB3Ifh6aR4aCokeTmqBtENhkIaFP0jXWZeF0YBboLvMiIkuwEwhJfpnVmIDEUShCi4+LE6VgT7UEtAQs/+m+JoHE5dAl9nlDn6xV9vdNGROmPjmbrScn0NI5n3jp0d/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820149; c=relaxed/simple;
	bh=bFJvUoef9xdUvduLzwvR1dgdMRczwphCznQNMwnf6as=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DaGJLwpRYDh2cUHrrcGJsJWJSl1VyP9+ec+7JjfoZSR5HJt+5Dq/KheX7Fhhr5+apJ1okX5Qt88sCcOuL4o2FKsHmZ3r8DkjM383/C9/EUHbWaYE9lmo0LeE0lEEPvckeN6jts/4y4Q4ShJYJC20M7NW6NuBwbIpo63gnFZKoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P5AynUl/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706820147; x=1738356147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bFJvUoef9xdUvduLzwvR1dgdMRczwphCznQNMwnf6as=;
  b=P5AynUl/xCoDXl90jEZtNSoFTwGKmYMIBJajTrYhHJfzPlvEhzxKsMDp
   ZO31YnvQe12llWVyCIF/PuRIIUc01+d8t0tjtmj1NduHvhOPaEToYlWok
   rS2V3JfCtLQKNKXZANqS7pQHmRs3wHBtOEPVdfq+vrxjH6FSrLu+PTGuO
   LqsR4AMbKqfLnD2GB77vOdeRiltmBIQMpgtaIHa1XQXt1JF2dCXqZRHuM
   KelcuQLFcYU+ougq27u1u/NRJcFlXTQM6ocgGkYREis90BJcyTbLcdouC
   Ao+PXudajMCSROVeUXFI/Tc/iMD8GHI/JRGpMPvov8fA7b2CNCMGrLPLG
   w==;
X-CSE-ConnectionGUID: Q09uTIAUTuimtNqrhQiWBQ==
X-CSE-MsgGUID: 3RcJp7R+TUm53xfjLnWyyw==
X-IronPort-AV: E=Sophos;i="6.05,236,1701154800"; 
   d="scan'208";a="15646434"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 13:42:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 13:42:19 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 13:42:16 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: micrel: Fix the frequency adjustments
Date: Thu, 1 Feb 2024 21:42:03 +0100
Message-ID: <20240201204203.2691424-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

By default lan8841's 1588 clock frequency is 125MHz. But when adjusting
the frequency, it is using the 1PPM format of the lan8814. Which is the
wrong format as lan8814 has a 1588 clock frequency of 250MHz. So then
for each 1PPM adjustment would adjust less than expected.
Therefore fix this by using the correct 1PPM format for lan8841.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 40bea9293ddd7..9b69735819896 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -120,6 +120,12 @@
  */
 #define LAN8814_1PPM_FORMAT			17179
 
+/* Represents 1ppm adjustment in 2^32 format with
+ * each nsec contains 8 clock cycles.
+ * The value is calculated as following: (1/1000000)/((2^-32)/8)
+ */
+#define LAN8841_1PPM_FORMAT			34360
+
 #define PTP_RX_VERSION				0x0248
 #define PTP_TX_VERSION				0x0288
 #define PTP_MAX_VERSION(x)			(((x) & GENMASK(7, 0)) << 8)
@@ -4115,8 +4121,8 @@ static int lan8841_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 		faster = false;
 	}
 
-	rate = LAN8814_1PPM_FORMAT * (upper_16_bits(scaled_ppm));
-	rate += (LAN8814_1PPM_FORMAT * (lower_16_bits(scaled_ppm))) >> 16;
+	rate = LAN8841_1PPM_FORMAT * (upper_16_bits(scaled_ppm));
+	rate += (LAN8841_1PPM_FORMAT * (lower_16_bits(scaled_ppm))) >> 16;
 
 	mutex_lock(&ptp_priv->ptp_lock);
 	phy_write_mmd(phydev, 2, LAN8841_PTP_LTC_RATE_ADJ_HI,
-- 
2.34.1


