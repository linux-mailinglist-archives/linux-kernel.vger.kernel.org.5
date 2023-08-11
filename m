Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42967799F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjHKVxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjHKVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:53:44 -0400
Received: from smtpdh19-su.aruba.it (smtpdh19-su.aruba.it [62.149.155.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F82712
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:53:42 -0700 (PDT)
Received: from localhost.localdomain ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Ua4Wq7aKXFroIUa4cqW64A; Fri, 11 Aug 2023 23:53:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691790821; bh=sgLKTG2jgUCHzbZ0AC5kRxPygfCZIK1iFs84y1o2j2k=;
        h=From:To:Subject:Date:MIME-Version;
        b=jalyRI6EQNn6aUL6iQvydrergSSz/TqtmgKSnViuLZ3n4ZfrYvojaVfjDb2brbucT
         XsiQn1PcAUN6NpYnp0ZHj7etLAvFw1h5TwvX5ZCE7gERdiu4rU6cZF6ukD75BkSKKS
         q7pwlH1xe9/CxKryN3euiYzSnqfQJUXEIyH+jCaAAwDvylI/X96Iu4vr/FGIZeNa2V
         xBT1KmwdPpvJq3UJfNEGLwVQFymA+VE+zFUtwIu4DWMD+r5FkDbgZNnlYP1yza6YBu
         z5pvcPHLift7hYiwv9WIVXaFJ6YDt61lK604wKfhjgQ16uuOHV3WdGM0LuNk2YRaRr
         pX+jb5hgwIS6Q==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Date:   Fri, 11 Aug 2023 23:53:22 +0200
Message-Id: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNDKmphGz4qnBWbzJRlED2AkkE0sAmkq+e+n2OZih68PFVNiooO28McspQwHO+nqr5ZeFH+4raGnERqeit6xQMtDc9IXvckGqbSQWI6oF+TV/scRqhbF
 MOSG5jrvLNEXZcgRdvKQ/tgt+aVsg14y91PqVPnkgmKZ2weDF+AkoqmueqEyMUdzqjEIPx9rdOFCTKQjhddO3RtvnbisJRwzTFfpHAP0GhmyKleN+bDMHPyv
 bLl8PbfF8raGVDilL4Ubr4DJFUO8yBt5/EUeJu6L3fff3p9bcmYeBH8MNf6f+1G6EbseyellWUoMX4A3CJNUQOSAqvF/1khAcOnRua1fKWV1wBEhdTnt/+tw
 HOHZi+R7UmYGurrFPJK+ZfvrXfImdacmjYIuSMrXrHcoP+OSXZ/dyggR7F9vqjpDctB4kGOJEyFRHpxUAvuGMTUhDaBwTHEkSp28y+/Nyp7a8hTrFW6/bHNO
 GC/bgT7uQOxZfPuWRQCkuXFlDZvywM2FoeI8BfQ96r+zPN6b72GunLt6AL65TjhljCbXbopGLwgVjEG3EOl7IjYdr1UMH/vk+j6mp4473WNSp2hqYtgIH0oK
 ns+vnhaN/2xjWa+F9N0rzWJEgEK136vQ2V/JQwdx2YYYOhesqEzFAl5tPX+GXQdSJbcZ/Q47DqotIDynLeZThWzlOka1G4pz4Kt67UPg3C2CTCVIPgCRPlLB
 0So5HQPU8cU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the BCM5221 PHY support by reusing
brcm_fet_config_intr() and brcm_fet_handle_interrupt() and
implementing config_init()/suspend()/resume().

Sponsored by: Tekvox Inc.
Cc: Jim Reinhart <jimr@tekvox.com>
Cc: James Autry <jautry@tekvox.com>
Cc: Matthew Maron <matthewm@tekvox.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/net/phy/broadcom.c | 144 +++++++++++++++++++++++++++++++++++++
 include/linux/brcmphy.h    |   8 +++
 2 files changed, 152 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 59cae0d808aa..99f6c0485f01 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -754,6 +754,84 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 	return err;
 }
 
+static int bcm5221_config_init(struct phy_device *phydev)
+{
+	int reg, err, err2, brcmtest;
+
+	/* Reset the PHY to bring it to a known state. */
+	err = phy_write(phydev, MII_BMCR, BMCR_RESET);
+	if (err < 0)
+		return err;
+
+	/* The datasheet indicates the PHY needs up to 1us to complete a reset,
+	 * build some slack here.
+	 */
+	usleep_range(1000, 2000);
+
+	/* The PHY requires 65 MDC clock cycles to complete a write operation
+	 * and turnaround the line properly.
+	 *
+	 * We ignore -EIO here as the MDIO controller (e.g.: mdio-bcm-unimac)
+	 * may flag the lack of turn-around as a read failure. This is
+	 * particularly true with this combination since the MDIO controller
+	 * only used 64 MDC cycles. This is not a critical failure in this
+	 * specific case and it has no functional impact otherwise, so we let
+	 * that one go through. If there is a genuine bus error, the next read
+	 * of MII_BRCM_FET_INTREG will error out.
+	 */
+	err = phy_read(phydev, MII_BMCR);
+	if (err < 0 && err != -EIO)
+		return err;
+
+	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
+	if (reg < 0)
+		return reg;
+
+	/* Unmask events we are interested in and mask interrupts globally. */
+	reg = MII_BRCM_FET_IR_ENABLE |
+	      MII_BRCM_FET_IR_MASK;
+
+	err = phy_write(phydev, MII_BRCM_FET_INTREG, reg);
+	if (err < 0)
+		return err;
+
+	/* Enable auto MDIX */
+	err = phy_clear_bits(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_DIS);
+	if (err < 0)
+		return err;
+
+	/* Enable shadow register access */
+	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
+	if (brcmtest < 0)
+		return brcmtest;
+
+	reg = brcmtest | MII_BRCM_FET_BT_SRE;
+
+	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
+	if (err < 0)
+		return err;
+
+        /* Exit low power mode */
+	err = phy_clear_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
+			 BCM5221_SHDW_AM4_FORCE_LPM);
+	if (err < 0)
+		goto done;
+
+	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
+		/* Enable auto power down */
+		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
+				   MII_BRCM_FET_SHDW_AS2_APDE);
+	}
+
+done:
+	/* Disable shadow register access */
+	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
+	if (!err)
+		err = err2;
+
+	return err;
+}
+
 static int brcm_fet_ack_interrupt(struct phy_device *phydev)
 {
 	int reg;
@@ -882,6 +960,61 @@ static int bcm54xx_phy_set_wol(struct phy_device *phydev,
 	return 0;
 }
 
+static int bcm5221_suspend(struct phy_device *phydev)
+{
+	int reg, err, err2, brcmtest;
+
+	/* Enable shadow register access */
+	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
+	if (brcmtest < 0)
+		return brcmtest;
+
+	reg = brcmtest | MII_BRCM_FET_BT_SRE;
+
+	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
+	if (err < 0)
+		return err;
+
+	/* Force Low Power Mode with clock enabled */
+	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
+			   BCM5221_SHDW_AM4_EN_CLK_LPM |
+			   BCM5221_SHDW_AM4_FORCE_LPM);
+
+	/* Disable shadow register access */
+	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
+	if (!err)
+		err = err2;
+
+	return err;
+}
+
+static int bcm5221_resume(struct phy_device *phydev)
+{
+	int reg, err, err2, brcmtest;
+
+	/* Enable shadow register access */
+	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
+	if (brcmtest < 0)
+		return brcmtest;
+
+	reg = brcmtest | MII_BRCM_FET_BT_SRE;
+
+	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
+	if (err < 0)
+		return err;
+
+	/* Exit Low Power Mode with clock enabled */
+	err = phy_clear_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
+			     BCM5221_SHDW_AM4_FORCE_LPM);
+
+	/* Disable shadow register access */
+	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
+	if (!err)
+		err = err2;
+
+	return err;
+}
+
 static int bcm54xx_phy_probe(struct phy_device *phydev)
 {
 	struct bcm54xx_phy_priv *priv;
@@ -1208,6 +1341,16 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = brcm_fet_handle_interrupt,
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
+}, {
+	.phy_id		= PHY_ID_BCM5221,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "Broadcom BCM5221",
+	/* PHY_BASIC_FEATURES */
+	.config_init	= bcm5221_config_init,
+	.config_intr	= brcm_fet_config_intr,
+	.handle_interrupt = brcm_fet_handle_interrupt,
+	.suspend	= bcm5221_suspend,
+	.resume		= bcm5221_resume,
 }, {
 	.phy_id		= PHY_ID_BCM5395,
 	.phy_id_mask	= 0xfffffff0,
@@ -1288,6 +1431,7 @@ static struct mdio_device_id __maybe_unused broadcom_tbl[] = {
 	{ PHY_ID_BCM53125, 0xfffffff0 },
 	{ PHY_ID_BCM53128, 0xfffffff0 },
 	{ PHY_ID_BCM89610, 0xfffffff0 },
+	{ PHY_ID_BCM5221, 0xfffffff0 },
 	{ }
 };
 
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 5d732f48f787..3d7786cc997d 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -12,6 +12,7 @@
 #define PHY_ID_BCM50610			0x0143bd60
 #define PHY_ID_BCM50610M		0x0143bd70
 #define PHY_ID_BCM5241			0x0143bc30
+#define PHY_ID_BCM5221			0x004061e0
 #define PHY_ID_BCMAC131			0x0143bc70
 #define PHY_ID_BCM5481			0x0143bca0
 #define PHY_ID_BCM5395			0x0143bcf0
@@ -330,6 +331,13 @@
 
 #define BCM54XX_WOL_INT_STATUS		(MII_BCM54XX_EXP_SEL_WOL + 0x94)
 
+/* BCM5221 Registers */
+#define BCM5221_AEGSR			0x1C
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

