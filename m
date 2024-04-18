Return-Path: <linux-kernel+bounces-150050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A678A99A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2662A280F19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2315FA6D;
	Thu, 18 Apr 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SAeahBO2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J/FEiehb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D415F302;
	Thu, 18 Apr 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442600; cv=none; b=bOrtgLOL/2kbShIC5d35tyWlfkUeCKrvMUnUHxXDb2/dsx3NlKd2EvPtpre/38hucxz5/x/4fFQrrp+4RFAMi+le102NtMXUwPl2U7ZznqOVzlrseMtiXPyZP0ApyDUYyGNWLm5ntHMRfXnr/ZbEW6+GpP4l1ukXcUvH2WL7FiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442600; c=relaxed/simple;
	bh=hfn0K+tyg5dmSYVIRyO5XG3tfVG0zj5BqWnh4yKNMlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPsK+Hig206Y6pEgVkGYOzuLhcxHfHIgddXXcYo34B9TnlfzJCVRceER3zjDKHM9xrSyxo7dorZV7lotgWoZamKuMuAkvueP4iOUSwHoP7YESyI6XwyDtWLUqJldX61bOfGmkvWGj8NTmqVpPM9YJtsjeehHy6oArxDf7mCWXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SAeahBO2; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=J/FEiehb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713442597; x=1744978597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+b8ok4o3krDte4VgtMzaA20YggUMVxMjScx2DsaWec8=;
  b=SAeahBO2Nluj7yhQQ9tmN1p6y83u71rsJ6jKjWrplA7YimmbL98WQBrv
   kmOBBchm/Tv6i3RxUdO5rFeXds6vVj1dLCNu5vVTGB+eem4s1ApSjbGO1
   YvSIfET3gKgPe+wedjNDpA7LIsXyfKA/QtSxbJnek6iVZLub3zGAWTl4O
   Kgbe8j9HeXIFvy9QqqST47mREWGwCbs03afnLyoDpvsi4YBNLHhRsFVYo
   Ve1EHIuTseMgzGKZjhTsIdXtTS7Ehq85KGjOqRAwdQUSvcDMYXAZxWDpu
   hest9qbpXCfLW0xYWLiiNfMY8Tcmr3/HePOex1T78hoJ1QHWS8sn3F6y0
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,212,1708383600"; 
   d="scan'208";a="36491695"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Apr 2024 14:16:35 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B26661615A0;
	Thu, 18 Apr 2024 14:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713442591;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+b8ok4o3krDte4VgtMzaA20YggUMVxMjScx2DsaWec8=;
	b=J/FEiehbw1MV4zEII82mqSJYFIn0DGnDVMJar5vEkAndmS1P+IIO1/UN7IYLw2TDaJD3M0
	R7NjzMbln3V502A1TMWZ6Q3OnVoGJqVP61n1Hc5Xkn9+ksUGgmhlYDHxUHr1b2LImVWHIg
	5QHgW6m/lzRIX8sdhwdj1z2z72GJH0FI7bka1qAkbvvOAwRdMfAB09Oz+3ADrZ7/QkGzpw
	i5Q2ndqYq/Udq1yQdXGJs6/NBTilQz/6V3uuR5QsHLn8gfXQbRAZWBFI4fSNLTNNwnbC7m
	jSSj95amWqeXfdlAhMzOjmyIwTb4znNL7BNNxmtbGtuvFJxUI4NPI/fOoqWa+g==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Fabio Estevam <festevam@denx.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net 2/2] net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches
Date: Thu, 18 Apr 2024 14:16:08 +0200
Message-ID: <67dc4da11986fd7fd192fbb183813bf5a721001f.1713442039.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2b924dcdf8adfe2c0b6b5998e47e836dd8f9e1b1.1713442039.git.matthias.schiffer@ew.tq-group.com>
References: <2b924dcdf8adfe2c0b6b5998e47e836dd8f9e1b1.1713442039.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

88E6250-family switches have the quirk that the EEPROM Running flag can
get stuck at 1 when no EEPROM is connected, causing
mv88e6xxx_g2_eeprom_wait() to time out. We still want to wait for the
EEPROM however, to avoid interrupting a transfer and leaving the EEPROM
in an invalid state.

The condition to wait for recommended by the hardware spec is the EEInt
flag, however this flag is cleared on read, so before the hardware reset,
is may have been cleared already even though the EEPROM has been read
successfully.

For this reason, we revive the mv88e6xxx_g1_wait_eeprom_done() function
that was removed in commit 6ccf50d4d474
("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent") in a
slightly refactored form, and introduce a new
mv88e6xxx_g1_wait_eeprom_done_prereset() that additionally handles this
case by triggering another EEPROM reload that can be waited on.

On other switch models without this quirk, mv88e6xxx_g2_eeprom_wait() is
kept, as it avoids the additional reload.

Fixes: 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |  4 +-
 drivers/net/dsa/mv88e6xxx/global1.c | 89 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  2 +
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8650d8646120a..7a68114bf1976 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4948,8 +4948,8 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.watchdog_ops = &mv88e6250_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
-	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
-	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_pre = mv88e6250_g1_wait_eeprom_done_prereset,
+	.hardware_reset_post = mv88e6xxx_g1_wait_eeprom_done,
 	.reset = mv88e6250_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 49444a72ff095..9820cd5967574 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,6 +75,95 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
+static int mv88e6250_g1_eeprom_reload(struct mv88e6xxx_chip *chip)
+{
+	/* MV88E6185_G1_CTL1_RELOAD_EEPROM is also valid for 88E6250 */
+	int bit = __bf_shf(MV88E6185_G1_CTL1_RELOAD_EEPROM);
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL1, &val);
+	if (err)
+		return err;
+
+	val |= MV88E6185_G1_CTL1_RELOAD_EEPROM;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL1, val);
+	if (err)
+		return err;
+
+	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_CTL1, bit, 0);
+}
+
+/* Returns 0 when done, -EBUSY when waiting, other negative codes on error */
+static int mv88e6xxx_g1_is_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
+	if (err < 0) {
+		dev_err(chip->dev, "Error reading status");
+		return err;
+	}
+
+	/* If the switch is still resetting, it may not
+	 * respond on the bus, and so MDIO read returns
+	 * 0xffff. Differentiate between that, and waiting for
+	 * the EEPROM to be done by bit 0 being set.
+	 */
+	if (val == 0xffff || !(val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE)))
+		return -EBUSY;
+
+	return 0;
+}
+
+/* As the EEInt (EEPROM done) flag clears on read if the status register, this
+ * function must be called directly after a hard reset or EEPROM ReLoad request,
+ * or the done condition may have been missed
+ */
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	const unsigned long timeout = jiffies + 1 * HZ;
+	int ret;
+
+	/* Wait up to 1 second for the switch to finish reading the
+	 * EEPROM.
+	 */
+	while (time_before(jiffies, timeout)) {
+		ret = mv88e6xxx_g1_is_eeprom_done(chip);
+		if (ret != -EBUSY)
+			return ret;
+	}
+
+	dev_err(chip->dev, "Timeout waiting for EEPROM done");
+	return -ETIMEDOUT;
+}
+
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip)
+{
+	int ret;
+
+	ret = mv88e6xxx_g1_is_eeprom_done(chip);
+	if (ret != -EBUSY)
+		return ret;
+
+	/* Pre-reset, we don't know the state of the switch - when
+	 * mv88e6xxx_g1_is_eeprom_done() returns -EBUSY, that may be because
+	 * the switch is actually busy reading the EEPROM, or because
+	 * MV88E6XXX_G1_STS_IRQ_EEPROM_DONE has been cleared by an unrelated
+	 * status register read already.
+	 *
+	 * To account for the latter case, trigger another EEPROM reload for
+	 * another chance at seeing the done flag.
+	 */
+	ret = mv88e6250_g1_eeprom_reload(chip);
+	if (ret)
+		return ret;
+
+	return mv88e6xxx_g1_wait_eeprom_done(chip);
+}
+
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 1095261f5b490..3dbb7a1b8fe11 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -282,6 +282,8 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


