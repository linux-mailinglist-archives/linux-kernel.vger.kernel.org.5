Return-Path: <linux-kernel+bounces-17614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201B825038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53D51C22C13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65B22EFB;
	Fri,  5 Jan 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HMjVKDVT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464422EE9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5571e662b93so473014a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704444774; x=1705049574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlR3eGbuxTGTlVk7TBXSN+A3q/aUvoki5BPHPBxyzFU=;
        b=HMjVKDVT6oLS3C46DLHwtJ6jaBLWh/egO/J2Xf3pX66cytbokTmi9GrTelmxw1W8mE
         zmPy5wTFZ09YD6/fV04LbR4CgLp7arOuEOeRdcjD2j1FOqEvdZZdwv2DC338dQR/IpvP
         qP6ruEBSD8wXZSFjh27JmqE21Dpk+4Mn7945r5EgQNnTwXscfXzN7Fetc2eOObaT2pce
         EmnVS2Hu4TWgS0OABSICE85s7JWstabcWfbtY1E33mt5NA4bmXOEr/BqPwNUBRspgYxf
         a/qIeB2rTqAA1qwu7JX9S7gWt9hOb5YyMHnz+7vv3DVNOUTNZNHkA2vCLE7TkYgnGXyX
         qcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704444774; x=1705049574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlR3eGbuxTGTlVk7TBXSN+A3q/aUvoki5BPHPBxyzFU=;
        b=YUadC4qzTQQcEdImRs0ne4e37ZJ5Y1xInoilKNVViqRYrfsLbl6fJjG3PLTIFHZLEG
         0coXtlTmDtcF6AmOUaB0L9yaj/dRI1mL2HhScwVqM8YUFK7u23x1W68honxYsaVNiyot
         /90dKOJfHMLCZQ2jERGv4sDEP5qwbJFZQxqKOWXU5mQC2m53f9UVFtXZZJqebZBwGSk/
         6lRzgEOjqYtytN7po/aRqeYE1XVANUNjaFjoyYSPiSdsGtkLAQ0TZXkmicOdi/AVXKcn
         aLLlz+eB+OSoGg1yJfKG6m1PpQ4sUsLPBUzd1/BIyp7uuPS/86fLGxch5GSqjWBOVsfK
         8NbQ==
X-Gm-Message-State: AOJu0YxMVhSa4TGMvKwJSUux9D0eMyV5BOrE+UhopIJCdPSlNptaD9sI
	xgsvkM65qidfZUUIzqxBpqWAK9ibGU3L0Q==
X-Google-Smtp-Source: AGHT+IGGcGtR2xGcz7wsEG3qJlCZkp0/nPzS23NJF2ePsVqr7NPQcQC7UCGcqRfoUm7uiccebSoiTA==
X-Received: by 2002:a50:9b04:0:b0:554:1ef2:37ff with SMTP id o4-20020a509b04000000b005541ef237ffmr1255716edi.12.1704444774693;
        Fri, 05 Jan 2024 00:52:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402344200b005534057c72dsm720124edc.18.2024.01.05.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:52:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yuiko.oshino@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
Date: Fri,  5 Jan 2024 10:52:42 +0200
Message-Id: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ/G3S SMARC Module has 2 KSZ9131 PHYs. In this setup, the KSZ9131 PHY
is used with the ravb Ethernet driver. It has been discovered that when
bringing the Ethernet interface down/up continuously, e.g., with the
following sh script:

$ while :; do ifconfig eth0 down; ifconfig eth0 up; done

the link speed and duplex are wrong after interrupting the bring down/up
operation even though the Ethernet interface is up. To recover from this
state the following configuration sequence is necessary (executed
manually):

$ ifconfig eth0 down
$ ifconfig eth0 up

The behavior has been identified also on the Microchip SAMA7G5-EK board
which runs the macb driver and uses the same PHY.

The order of PHY-related operations in ravb_open() is as follows:
ravb_open() ->
  ravb_phy_start() ->
    ravb_phy_init() ->
      of_phy_connect() ->
        phy_connect_direct() ->
	  phy_attach_direct() ->
	    phy_init_hw() ->
	      phydev->drv->soft_reset()
	      phydev->drv->config_init()
	      phydev->drv->config_intr()
	    phy_resume()
	      kszphy_resume()

The order of PHY-related operations in ravb_close is as follows:
ravb_close() ->
  phy_stop() ->
    phy_suspend() ->
      kszphy_suspend() ->
        genphy_suspend()
	  // set BMCR_PDOWN bit in MII_BMCR

In genphy_suspend() setting the BMCR_PDWN bit in MII_BMCR switches the PHY
to Software Power-Down (SPD) mode (according to the KSZ9131 datasheet).
Thus, when opening the interface after it has been  previously closed (via
ravb_close()), the phydev->drv->config_init() and
phydev->drv->config_intr() reach the KSZ9131 PHY driver via the
ksz9131_config_init() and kszphy_config_intr() functions.

KSZ9131 specifies that the MII management interface remains operational
during SPD (Software Power-Down), but (according to manual):
- Only access to the standard registers (0 through 31) is supported.
- Access to MMD address spaces other than MMD address space 1 is possible
  if the spd_clock_gate_override bit is set.
- Access to MMD address space 1 is not possible.

The spd_clock_gate_override bit is not used in the KSZ9131 driver.

ksz9131_config_init() configures RGMII delay, pad skews and LEDs by
accessesing MMD registers other than those in address space 1.

The datasheet for the KSZ9131 does not specify what happens if registers
from an unsupported address space are accessed while the PHY is in SPD.

To fix the issue the .soft_reset method has been instantiated for KSZ9131,
too. This resets the PHY to the default state before doing any
configurations to it, thus switching it out of SPD.

Fixes: bff5b4b37372 ("net: phy: micrel: add Microchip KSZ9131 initial driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..f31f03dd87dd 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4842,6 +4842,7 @@ static struct phy_driver ksphy_driver[] = {
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &ksz9131_type,
 	.probe		= kszphy_probe,
+	.soft_reset	= genphy_soft_reset,
 	.config_init	= ksz9131_config_init,
 	.config_intr	= kszphy_config_intr,
 	.config_aneg	= ksz9131_config_aneg,
-- 
2.39.2


