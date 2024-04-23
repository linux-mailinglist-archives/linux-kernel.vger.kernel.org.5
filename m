Return-Path: <linux-kernel+bounces-154626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0E8ADE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246251F22DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527546522;
	Tue, 23 Apr 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="A47FWdeL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VLL3+KC+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84347A5D;
	Tue, 23 Apr 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858515; cv=none; b=rMWHY7lSoGu/LF+8QwWBHTwgjtJHC1DVerAkc7j1tzkebczNd+2V9oWX6wzSWpkwVnnFQPfJSS/4fA70L55TuYIt+ju+B9HMJsjtC1SC6XE3azt6YDnzrMNoTo+jJ9b0aYtGo/RvwUlQVCSKgz5bYVhvQxjFFtt77d3Aiq1lY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858515; c=relaxed/simple;
	bh=50WUH8/gJdefZq4G72BFoplcUbcPUBwyyq+E5uJJwpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RnyH+Uchd6ihNDFSQhnueNcBW21Jp8L7zRNv0i+UxNF/9wUq0h2AsgrfkhyfeLxcoMR8A/za/c2DtJV3MoxXBkNmiMfu+TtGm1puLNFXhbE/VdrZziq4Ch/+qX1q7zNeoKHLMpboRevgqo9AvH0zXTI4yvRk4uIBZodWncT0Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=A47FWdeL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VLL3+KC+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713858512; x=1745394512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=olb7YuiDqyB6vPx9JqkzKaHx9bpQLEFyzOe5hqPoF6Y=;
  b=A47FWdeLjnMefa+N9ydnCq6UXYXF6gVb3h8UaXSd11h7ZtvhgYIQh3+I
   3+ZndWtLjgN8dOZqxnfsRwSCElnadNZpLJ+CT1xeRdGgnBUWhVKCyAKDI
   Sv2zUDnD2cofOAxaETXnxShQPep2AaX+LL2hTe65r0pTxhBfoSjIETSOj
   eAUtT2fqInhdCGM6FWK94p7HIH45hviRfxfrl6ZZfbe92UhWLue0TjCgQ
   oG+JWS0T3wEpq+v6bcGSq+ymrsmveeBcG50gnhMQgkjTAJJ1YqD0f82sy
   sZH+y/QDpwjPRMuZNsfoMfnM0K1QdKFkIHnDrzmsIGXaNu1c6fg2rD/hr
   A==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36558060"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 09:48:28 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DB0D1750DA;
	Tue, 23 Apr 2024 09:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713858503;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=olb7YuiDqyB6vPx9JqkzKaHx9bpQLEFyzOe5hqPoF6Y=;
	b=VLL3+KC+GYUdsXj6WQoLpvHXIiz4he0woIZyf+LhtGP7xYHCuHzoppErbXlLo3cYItX/vl
	ZuXMtI568VBJ+D3x7V4yVIqh+j+BvQ7JbV8fo4GBrSB/uJ9X8GLE0q8A39YREKN6PHm1Iw
	XrcJd8S4VkKoKpRi5DavdOkSXHZRaJIM6/dhrl3sTxMFh/ZCXMsj3EhXNvSwAs5r1GgO1g
	znsQ11Y6jeuAGmEpNpZKjNR0rqqrwyU97hirzPdg+xlAEkY75MkPOBkfuyEErS5SQ3ZHvS
	Qd296WKXtS7hb/SKYcZvTJY4IoPUFzf3ewy00DmgL2g49kMgvapVNx0DAW9zSQ==
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
Subject: [PATCH net v2 1/2] net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
Date: Tue, 23 Apr 2024 09:47:48 +0200
Message-ID: <addee2a493823b4a7e0ea966b1713f4ed6c04a2e.1713858017.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Instead of calling mv88e6xxx_g2_eeprom_wait() directly from
mv88e6xxx_hardware_reset(), add configurable pre- and post-reset hard
reset handlers. Initially, the handlers are set to
mv88e6xxx_g2_eeprom_wait() for all families that have get/set_eeprom()
to match the existing behavior. No functional change intended (except
for additional error messages on failure).

Fixes: 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: Moved comment back to mv88e6xxx_hardware_reset()


 drivers/net/dsa/mv88e6xxx/chip.c | 50 +++++++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/chip.h |  6 ++++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 59b5dd0e2f41d..21853689f6b39 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3123,6 +3123,7 @@ static int mv88e6xxx_software_reset(struct mv88e6xxx_chip *chip)
 static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 {
 	struct gpio_desc *gpiod = chip->reset;
+	int err;
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
@@ -3131,17 +3132,26 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 		 * mid-byte, causing the first EEPROM read after the reset
 		 * from the wrong location resulting in the switch booting
 		 * to wrong mode and inoperable.
+		 * For this reason, switch families with EEPROM support
+		 * generally wait for EEPROM loads to complete as their pre-
+		 * and post-reset handlers.
 		 */
-		if (chip->info->ops->get_eeprom)
-			mv88e6xxx_g2_eeprom_wait(chip);
+		if (chip->info->ops->hardware_reset_pre) {
+			err = chip->info->ops->hardware_reset_pre(chip);
+			if (err)
+				dev_err(chip->dev, "pre-reset error: %d\n", err);
+		}
 
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
 		usleep_range(10000, 20000);
 
-		if (chip->info->ops->get_eeprom)
-			mv88e6xxx_g2_eeprom_wait(chip);
+		if (chip->info->ops->hardware_reset_post) {
+			err = chip->info->ops->hardware_reset_post(chip);
+			if (err)
+				dev_err(chip->dev, "post-reset error: %d\n", err);
+		}
 	}
 }
 
@@ -4371,6 +4381,8 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4561,6 +4573,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4661,6 +4675,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4755,6 +4771,8 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4813,6 +4831,8 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4869,6 +4889,8 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4928,6 +4950,8 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4981,6 +5005,8 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.watchdog_ops = &mv88e6250_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6250_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5028,6 +5054,8 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5087,6 +5115,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5133,6 +5163,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5183,6 +5215,8 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5338,6 +5372,8 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5400,6 +5436,8 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5462,6 +5500,8 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5527,6 +5567,8 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.watchdog_ops = &mv88e6393x_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6393x_port_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 85eb293381a7e..c34caf9815c5c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -487,6 +487,12 @@ struct mv88e6xxx_ops {
 	int (*ppu_enable)(struct mv88e6xxx_chip *chip);
 	int (*ppu_disable)(struct mv88e6xxx_chip *chip);
 
+	/* Additional handlers to run before and after hard reset, to make sure
+	 * that the switch and EEPROM are in a good state.
+	 */
+	int (*hardware_reset_pre)(struct mv88e6xxx_chip *chip);
+	int (*hardware_reset_post)(struct mv88e6xxx_chip *chip);
+
 	/* Switch Software Reset */
 	int (*reset)(struct mv88e6xxx_chip *chip);
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


