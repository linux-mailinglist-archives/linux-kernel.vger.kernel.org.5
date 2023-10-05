Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447A67BA91B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjJESa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJESaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:30:25 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 11:30:22 PDT
Received: from smtpdh17-2.aruba.it (smtpdh17-2.aruba.it [62.149.155.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474CCAD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:30:22 -0700 (PDT)
Received: from localhost.localdomain ([146.241.127.78])
        by Aruba Outgoing Smtp  with ESMTPSA
        id oT65qaKjjlbdkoT66q4pRP; Thu, 05 Oct 2023 20:29:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1696530559; bh=uoy8unYGf/PDL0QHgI1ou/VGwV3b2picokEMkywfe4c=;
        h=From:To:Subject:Date:MIME-Version;
        b=UIlXd+h/1mkhskfL0e2yKPV8D4ZtTTeR/Yb/I+K0Y0UIoKneDtsmBJRU8lTw6Y01n
         Pgtf7XahkysJonv0ahJpf6IrU4yq0CE2aPIQaHUeYZuidTiNuOFOLZ4rProxDfAgqZ
         zU0BJbQfaZU4Hgnmzn18FpphC/LjQV0ZHJEQE087Mup4a5q7Glil9tQ6RmBqdlZdmn
         MREI1eGMZp8xhK2gnztI4/Kh2okx0M4i8/nVe/N7TayKZRCcSw1It0/fnrEkUBfwW8
         Zwx1nxEcZMgjkypMA1FU/GuTyZEnAEjhJwwD264q/MmT2t8lI5eBHImFHl3gpFiLvt
         TlbYHN6pETHGA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: [PATCH v4] net: phy: broadcom: add support for BCM5221 phy
Date:   Thu,  5 Oct 2023 20:29:15 +0200
Message-Id: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKZbZhtWqTGveJJPZrOv/DcPQmYEvNLwV0Z3/lp78N5WSSl2Zc8AapeMLbcF0AmY3RrTuoi3gTq3Bb8ee9tPoJ7qUOAglg1frdARobNBSBJPDk/Nsew+
 DnJ70WzpC4WpHanbD4Fcn3H20To6NpBM4jAWluRFp5sbSmNX/HSTThWMfvOOPrOSPfyK6989rRo1/5OP+m8ULx/ss9Lxp3INqjA5nIw1jE+fA1yqR/FbdNbk
 2101lo3jljIDZbAVCEBdv6A4qdE+bCpdNi3iHJoxi4RrcVQkokljrn8LQ1DR4oPusIj3vImUc8fFlTf5zAbsS1YgC4hr5+JgVN0gWq7qMLGf0eakzHw9R9rF
 +aW2Ubf/1rlkKMN8WpyZppIppeHSu5L5lSQk0rjvxnA5qhaKWUB+QtC9lsq1uDxydqOzHmmD9Vnr+230tZuYrwLKArdjQxfXNgFeH5tTE9Z1yv6z0vYD73DH
 5wN1awebaCYRjutdGT19Pf8mF6MDWA2MKSr4X1uUgxEz50OJEp29uyoEF7lTZoYPTYFkP6pNU8I2NsDFXpGQrzIL/9sqtHq1B3astp7+cP8kULmOaD1+QbhX
 LO6+tGJ21sihnPAmtbTApbkttsI4oloEv9do75UJiqp2SbOLix7KA0kkhvfm7KiPIqw7WHiUXdlliBUvra7v52yPO5Uze4rmNA/9RRgLHoaAT48b4PMLZ7jc
 uWdSuxEo3kE=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>

This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
callbacks and adding quirks for BCM5221 when needed.

Cc: Jim Reinhart <jimr@tekvox.com>
Cc: James Autry <jautry@tekvox.com>
Cc: Matthew Maron <matthewm@tekvox.com>
Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
---
V1->V2:
Suggested by Andrew Lunn:
* handle mdix_ctrl adding bcm5221_config_aneg() and bcm5221_read_status()
* reorder PHY_ID_BCM5241 in broadcom_tbl[]
Suggested by Russell King:
* add comment on phy_read(..., MII_BRCM_FET_INTREG)
* lock mdio bus when in shadow mode
Suggested by Florian Fainelli:
* reuse brcm_fet_*() callbacks checking for phy_id == PHY_ID_BCM5221

V2->V3:
* rebase on master branch

V3->V4:
Suggested by Russell King:
* improve code style
---
 drivers/net/phy/broadcom.c | 154 +++++++++++++++++++++++++++++--------
 include/linux/brcmphy.h    |  10 +++
 2 files changed, 131 insertions(+), 33 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 04b2e6eeb195..3a627105675a 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -704,16 +704,21 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 	if (err < 0 && err != -EIO)
 		return err;
 
+	/* Read to clear status bits */
 	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
 	if (reg < 0)
 		return reg;
 
 	/* Unmask events we are interested in and mask interrupts globally. */
-	reg = MII_BRCM_FET_IR_DUPLEX_EN |
-	      MII_BRCM_FET_IR_SPEED_EN |
-	      MII_BRCM_FET_IR_LINK_EN |
-	      MII_BRCM_FET_IR_ENABLE |
-	      MII_BRCM_FET_IR_MASK;
+	if (phydev->phy_id == PHY_ID_BCM5221)
+		reg = MII_BRCM_FET_IR_ENABLE |
+		      MII_BRCM_FET_IR_MASK;
+	else
+		reg = MII_BRCM_FET_IR_DUPLEX_EN |
+		      MII_BRCM_FET_IR_SPEED_EN |
+		      MII_BRCM_FET_IR_LINK_EN |
+		      MII_BRCM_FET_IR_ENABLE |
+		      MII_BRCM_FET_IR_MASK;
 
 	err = phy_write(phydev, MII_BRCM_FET_INTREG, reg);
 	if (err < 0)
@@ -726,42 +731,49 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 
 	reg = brcmtest | MII_BRCM_FET_BT_SRE;
 
-	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
-	if (err < 0)
-		return err;
+	phy_lock_mdio_bus(phydev);
 
-	/* Set the LED mode */
-	reg = phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
-	if (reg < 0) {
-		err = reg;
-		goto done;
+	err = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
+	if (err < 0) {
+		phy_unlock_mdio_bus(phydev);
+		return err;
 	}
 
-	reg &= ~MII_BRCM_FET_SHDW_AM4_LED_MASK;
-	reg |= MII_BRCM_FET_SHDW_AM4_LED_MODE1;
+	if (phydev->phy_id != PHY_ID_BCM5221) {
+		/* Set the LED mode */
+		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
+		if (reg < 0) {
+			err = reg;
+			goto done;
+		}
 
-	err = phy_write(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);
-	if (err < 0)
-		goto done;
+		err = __phy_modify(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
+				   MII_BRCM_FET_SHDW_AM4_LED_MASK,
+				   MII_BRCM_FET_SHDW_AM4_LED_MODE1);
+		if (err < 0)
+			goto done;
 
-	/* Enable auto MDIX */
-	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
-			   MII_BRCM_FET_SHDW_MC_FAME);
-	if (err < 0)
-		goto done;
+		/* Enable auto MDIX */
+		err = __phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
+				     MII_BRCM_FET_SHDW_MC_FAME);
+		if (err < 0)
+			goto done;
+	}
 
 	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
 		/* Enable auto power down */
-		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
-				   MII_BRCM_FET_SHDW_AS2_APDE);
+		err = __phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
+				     MII_BRCM_FET_SHDW_AS2_APDE);
 	}
 
 done:
 	/* Disable shadow register access */
-	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
+	err2 = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
 	if (!err)
 		err = err2;
 
+	phy_unlock_mdio_bus(phydev);
+
 	return err;
 }
 
@@ -840,23 +852,86 @@ static int brcm_fet_suspend(struct phy_device *phydev)
 
 	reg = brcmtest | MII_BRCM_FET_BT_SRE;
 
-	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
-	if (err < 0)
+	phy_lock_mdio_bus(phydev);
+
+	err = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
+	if (err < 0) {
+		phy_unlock_mdio_bus(phydev);
 		return err;
+	}
+
+	if (phydev->phy_id == PHY_ID_BCM5221)
+		/* Force Low Power Mode with clock enabled */
+		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
+	else
+		/* Set standby mode */
+		reg = MII_BRCM_FET_SHDW_AM4_STANDBY;
 
-	/* Set standby mode */
-	err = phy_modify(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
-			 MII_BRCM_FET_SHDW_AM4_STANDBY,
-			 MII_BRCM_FET_SHDW_AM4_STANDBY);
+	err = __phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);
 
 	/* Disable shadow register access */
-	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
+	err2 = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
 	if (!err)
 		err = err2;
 
+	phy_unlock_mdio_bus(phydev);
+
 	return err;
 }
 
+static int bcm5221_config_aneg(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = genphy_config_aneg(phydev);
+	if (ret)
+		return ret;
+
+	switch (phydev->mdix_ctrl) {
+	case ETH_TP_MDI:
+		val = BCM5221_AEGSR_MDIX_DIS;
+		break;
+	case ETH_TP_MDI_X:
+		val = BCM5221_AEGSR_MDIX_DIS | BCM5221_AEGSR_MDIX_MAN_SWAP;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = 0;
+		break;
+	default:
+		return 0;
+	}
+
+	return phy_modify(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_MAN_SWAP |
+						 BCM5221_AEGSR_MDIX_DIS,
+						 val);
+}
+
+static int bcm5221_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Read MDIX status */
+	ret = phy_read(phydev, BCM5221_AEGSR);
+	if (ret < 0)
+		return ret;
+
+	if (ret & BCM5221_AEGSR_MDIX_DIS) {
+		if (ret & BCM5221_AEGSR_MDIX_MAN_SWAP)
+			phydev->mdix_ctrl = ETH_TP_MDI_X;
+		else
+			phydev->mdix_ctrl = ETH_TP_MDI;
+	} else {
+		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+	}
+
+	if (ret & BCM5221_AEGSR_MDIX_STATUS)
+		phydev->mdix = ETH_TP_MDI_X;
+	else
+		phydev->mdix = ETH_TP_MDI;
+
+	return genphy_read_status(phydev);
+}
+
 static void bcm54xx_phy_get_wol(struct phy_device *phydev,
 				struct ethtool_wolinfo *wol)
 {
@@ -1221,6 +1296,18 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = brcm_fet_handle_interrupt,
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
+}, {
+	.phy_id		= PHY_ID_BCM5221,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "Broadcom BCM5221",
+	/* PHY_BASIC_FEATURES */
+	.config_init	= brcm_fet_config_init,
+	.config_intr	= brcm_fet_config_intr,
+	.handle_interrupt = brcm_fet_handle_interrupt,
+	.suspend	= brcm_fet_suspend,
+	.resume		= brcm_fet_config_init,
+	.config_aneg	= bcm5221_config_aneg,
+	.read_status	= bcm5221_read_status,
 }, {
 	.phy_id		= PHY_ID_BCM5395,
 	.phy_id_mask	= 0xfffffff0,
@@ -1296,6 +1383,7 @@ static struct mdio_device_id __maybe_unused broadcom_tbl[] = {
 	{ PHY_ID_BCM50610M, 0xfffffff0 },
 	{ PHY_ID_BCM57780, 0xfffffff0 },
 	{ PHY_ID_BCMAC131, 0xfffffff0 },
+	{ PHY_ID_BCM5221, 0xfffffff0 },
 	{ PHY_ID_BCM5241, 0xfffffff0 },
 	{ PHY_ID_BCM5395, 0xfffffff0 },
 	{ PHY_ID_BCM53125, 0xfffffff0 },
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index c55810a43541..1394ba302367 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -11,6 +11,7 @@
 
 #define PHY_ID_BCM50610			0x0143bd60
 #define PHY_ID_BCM50610M		0x0143bd70
+#define PHY_ID_BCM5221			0x004061e0
 #define PHY_ID_BCM5241			0x0143bc30
 #define PHY_ID_BCMAC131			0x0143bc70
 #define PHY_ID_BCM5481			0x0143bca0
@@ -331,6 +332,15 @@
 
 #define BCM54XX_WOL_INT_STATUS		(MII_BCM54XX_EXP_SEL_WOL + 0x94)
 
+/* BCM5221 Registers */
+#define BCM5221_AEGSR			0x1C
+#define BCM5221_AEGSR_MDIX_STATUS	BIT(13)
+#define BCM5221_AEGSR_MDIX_MAN_SWAP	BIT(12)
+#define BCM5221_AEGSR_MDIX_DIS		BIT(11)
+
+#define BCM5221_SHDW_AM4_EN_CLK_LPM	BIT(2)
+#define BCM5221_SHDW_AM4_FORCE_LPM	BIT(1)
+
 /*****************************************************************************/
 /* Fast Ethernet Transceiver definitions. */
 /*****************************************************************************/
-- 
2.34.1

