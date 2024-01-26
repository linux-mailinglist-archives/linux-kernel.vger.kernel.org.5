Return-Path: <linux-kernel+bounces-39702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98B83D520
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AE6B21176
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C851000;
	Fri, 26 Jan 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XIoCNx+y"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E150A8D;
	Fri, 26 Jan 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254259; cv=none; b=EwcsJ8h3eMcY7wRws56QR9F2oCk77BbI4o4PtGjRHsjEvdqdIAYo1lakMq9cDCGd1/CFlq0oLNOv3pE1vPankKKOcJHDvVlb7hUTD12Mom3IkXUKCcurqZvErdJXLEaUkzep3N/hcBHoOkaYbrOdBn1H7tRhdtrtF4Csvmty8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254259; c=relaxed/simple;
	bh=T6L7SWVY4qBbbIEtg0mEMeQ7qLVvRAyp9VHlIZ2Cjzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JphvEhACGg2CIxIYo4GMEKFltysDmCTfXAazL69zoQdNaRx/N5pGO+7Ek8BK9LEqIX35QixhLhaRaEPBInk9je6YbD2mvutN0yFqLuIKhECsKKswxu1zcMWL4OsOwfBaGTA3JG7J7OAM8R/Ck73sg/almno4CrqAbvwzp5jRQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XIoCNx+y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706254258; x=1737790258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T6L7SWVY4qBbbIEtg0mEMeQ7qLVvRAyp9VHlIZ2Cjzo=;
  b=XIoCNx+yUR09cLDpyZKz8tlzuU8y/lu96bwC8rQDuAU+9u2dcjz1Xg65
   SdEhjQmWs7GrZAe7EMuUj/YcjQNf1BW0xefstHkMoIbq/mCsWkeW4Bm3N
   6phIKcxMUXBZ8LjbGYlR8JdYEsDE7CBnKNA9njoo7wx/jmTCOQjHTlnQH
   +BerkDFXEymwrHWEFt4ee2PodKz+5umEh0joEvNKQPZ/T2ZsTxdYhBsjE
   E2BwKeWvIPG8aeO1CZKj0zqZimldLembuEqzr2+1ckLFUqPi1Mj9LX+qY
   zthByPpo1kIdxnkBfc+CDS/XcSQBIRob+v8TeK1qnZJClzNwTA0D2uuHn
   A==;
X-CSE-ConnectionGUID: zvdhg0uCSMy8breF/KPcKw==
X-CSE-MsgGUID: PWXQXDrIS5WuMCB4NGmdZw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="246060281"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2024 00:30:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 00:30:49 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 00:30:46 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Divya Koppera <divya.koppera@microchip.com>
Subject: [PATCH net-next] net: micrel: Fix set/get PHC time for lan8814
Date: Fri, 26 Jan 2024 08:30:42 +0100
Message-ID: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When setting or getting PHC time, the higher bits of the second time (>32
bits) they were ignored. Meaning that setting some time in the future like
year 2150, it was failing to set this.

The issue can be reproduced like this:

 # phc_ctl /dev/ptp1 set 10000000000
 phc_ctl[12.290]: set clock time to 10000000000.000000000 or Sat Nov 20 17:46:40 2286

 # phc_ctl /dev/ptp1 get
 phc_ctl[15.309]: clock time is 1410065411.018055420 or Sun Sep  7 04:50:11 2014

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Divya Koppera <divya.koppera@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
Based on discussion here [1], this patch from the series was changed
to target net-next instead of net.

[1] https://lore.kernel.org/netdev/20240119082103.edy647tbf2akokjy@DEN-DL-M31836.microchip.com/T/#m88b55103ee8c05599f2fa02c1588e195d95d6a49
---
 drivers/net/phy/micrel.c | 61 +++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index dad720138baaf..40bea9293ddd7 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -154,11 +154,13 @@
 #define PTP_CMD_CTL_PTP_LTC_STEP_SEC_		BIT(5)
 #define PTP_CMD_CTL_PTP_LTC_STEP_NSEC_		BIT(6)
 
+#define PTP_CLOCK_SET_SEC_HI			0x0205
 #define PTP_CLOCK_SET_SEC_MID			0x0206
 #define PTP_CLOCK_SET_SEC_LO			0x0207
 #define PTP_CLOCK_SET_NS_HI			0x0208
 #define PTP_CLOCK_SET_NS_LO			0x0209
 
+#define PTP_CLOCK_READ_SEC_HI			0x0229
 #define PTP_CLOCK_READ_SEC_MID			0x022A
 #define PTP_CLOCK_READ_SEC_LO			0x022B
 #define PTP_CLOCK_READ_NS_HI			0x022C
@@ -2592,35 +2594,31 @@ static bool lan8814_rxtstamp(struct mii_timestamper *mii_ts, struct sk_buff *skb
 }
 
 static void lan8814_ptp_clock_set(struct phy_device *phydev,
-				  u32 seconds, u32 nano_seconds)
+				  time64_t sec, u32 nsec)
 {
-	u32 sec_low, sec_high, nsec_low, nsec_high;
-
-	sec_low = seconds & 0xffff;
-	sec_high = (seconds >> 16) & 0xffff;
-	nsec_low = nano_seconds & 0xffff;
-	nsec_high = (nano_seconds >> 16) & 0x3fff;
-
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, sec_low);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, sec_high);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, nsec_low);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, nsec_high);
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, lower_16_bits(sec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, upper_16_bits(sec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_HI, upper_32_bits(sec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, lower_16_bits(nsec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, upper_16_bits(nsec));
 
 	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_LOAD_);
 }
 
 static void lan8814_ptp_clock_get(struct phy_device *phydev,
-				  u32 *seconds, u32 *nano_seconds)
+				  time64_t *sec, u32 *nsec)
 {
 	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_READ_);
 
-	*seconds = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
-	*seconds = (*seconds << 16) |
-		   lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
+	*sec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_HI);
+	*sec <<= 16;
+	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
+	*sec <<= 16;
+	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
 
-	*nano_seconds = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
-	*nano_seconds = ((*nano_seconds & 0x3fff) << 16) |
-			lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
+	*nsec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
+	*nsec <<= 16;
+	*nsec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
 }
 
 static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
@@ -2630,7 +2628,7 @@ static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
 							  ptp_clock_info);
 	struct phy_device *phydev = shared->phydev;
 	u32 nano_seconds;
-	u32 seconds;
+	time64_t seconds;
 
 	mutex_lock(&shared->shared_lock);
 	lan8814_ptp_clock_get(phydev, &seconds, &nano_seconds);
@@ -2660,38 +2658,37 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 {
 	u32 nano_seconds_step;
 	u64 abs_time_step_ns;
-	u32 unsigned_seconds;
+	time64_t set_seconds;
 	u32 nano_seconds;
 	u32 remainder;
 	s32 seconds;
 
 	if (time_step_ns >  15000000000LL) {
 		/* convert to clock set */
-		lan8814_ptp_clock_get(phydev, &unsigned_seconds, &nano_seconds);
-		unsigned_seconds += div_u64_rem(time_step_ns, 1000000000LL,
-						&remainder);
+		lan8814_ptp_clock_get(phydev, &set_seconds, &nano_seconds);
+		set_seconds += div_u64_rem(time_step_ns, 1000000000LL,
+					   &remainder);
 		nano_seconds += remainder;
 		if (nano_seconds >= 1000000000) {
-			unsigned_seconds++;
+			set_seconds++;
 			nano_seconds -= 1000000000;
 		}
-		lan8814_ptp_clock_set(phydev, unsigned_seconds, nano_seconds);
+		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
 		return;
 	} else if (time_step_ns < -15000000000LL) {
 		/* convert to clock set */
 		time_step_ns = -time_step_ns;
 
-		lan8814_ptp_clock_get(phydev, &unsigned_seconds, &nano_seconds);
-		unsigned_seconds -= div_u64_rem(time_step_ns, 1000000000LL,
-						&remainder);
+		lan8814_ptp_clock_get(phydev, &set_seconds, &nano_seconds);
+		set_seconds -= div_u64_rem(time_step_ns, 1000000000LL,
+					   &remainder);
 		nano_seconds_step = remainder;
 		if (nano_seconds < nano_seconds_step) {
-			unsigned_seconds--;
+			set_seconds--;
 			nano_seconds += 1000000000;
 		}
 		nano_seconds -= nano_seconds_step;
-		lan8814_ptp_clock_set(phydev, unsigned_seconds,
-				      nano_seconds);
+		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
 		return;
 	}
 
-- 
2.34.1


