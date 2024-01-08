Return-Path: <linux-kernel+bounces-19287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475C826AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C80F1C21CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DC14AA0;
	Mon,  8 Jan 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnRVUNpu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E314297;
	Mon,  8 Jan 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so4399877a12.1;
        Mon, 08 Jan 2024 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706732; x=1705311532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBEjqA+Yux9LdtGIMQNFjjykLZZmBxi30+k6T2PulHk=;
        b=NnRVUNpupbC9ZoraSqBBHy/irg8q7y4R8+3WmmtiHnh/Lc8rkcQln93VYhmQMOpPpE
         2GqDfp60QnVD3ew+qB0fYBwixfibMNU1l2SSFztlswjsnhhGreZUycyUWjk/1Zq9/wfF
         XEpGeejJCRptoTxKOSTBB/IDt6upcDR1sG3lLerwNCRVEhYZad2Zw/A+9rBInq7jDCwE
         C9XJWEwKRWikEREdVXSYtF4/hltcn0NSE98Y6I3MG1r32ungOEPODdIH4+93usQhV8Dv
         sv5tc1hko1UkXB4lX62HOvfBXLKflfhDtfODAvUx1jKn4wMiLYHEDoHOs4j4fW2t/7UU
         N1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706732; x=1705311532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBEjqA+Yux9LdtGIMQNFjjykLZZmBxi30+k6T2PulHk=;
        b=PSFk4QATjwsWwsH5Pk0KTjUT1mX4aWGaUN5tejJTZct2iC+H8PcigTzRwUVqagROk6
         2jkszFBT/vKrcPCa4Qbxlf0jWeWLYkO7jc9ClYfJvhniKHtiJQPdDZlPQ/mz3crP3DN0
         ss7b2gOvEOxWnNZGinDYwzK/fMrIeKL0rwQEkJ/cXh9xwy2gMP67ZOpsFnzF0mb/91hb
         s6bOHml5CQQxcQeVG5/bAR5+le2nM1mgn6eHpYey/tEVFfmZRko+3RFm9VSRCkwzSH8G
         6qG8Ahc+rAa3fDx77UdoGhvlN6UCBU2kDKOqhgpB8Jl394vLwjYR3SUdgTzpR+3nugHA
         cijw==
X-Gm-Message-State: AOJu0YwPMSK/+4iqaQNLv9koFNTmqLUGzx6nu9CS8w8fpk2RHIQIWKLy
	mCFmJEmejXtmsJI+Kn+U/tY=
X-Google-Smtp-Source: AGHT+IF3NjP2L7Lsesort1rSt8AXVSN0R4/0a07M3ql+v7eWqTQHPtLLiPQNr6nU/WxQiBfEEFtskA==
X-Received: by 2002:a17:906:1797:b0:a28:bd9c:8363 with SMTP id t23-20020a170906179700b00a28bd9c8363mr3058304eje.57.1704706732133;
        Mon, 08 Jan 2024 01:38:52 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b00a2ae71cee2asm326851eja.177.2024.01.08.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:38:51 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 4/5] net: phy: marvell-88q2xxx: fix typos
Date: Mon,  8 Jan 2024 10:36:59 +0100
Message-Id: <20240108093702.13476-5-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108093702.13476-1-dima.fedrau@gmail.com>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename mv88q2xxxx_get_sqi to mv88q2xxx_get_sqi and
mv88q2xxxx_get_sqi_max to mv88q2xxx_get_sqi_max.
Fix linebreaks and use everywhere hexadecimal numbers written with
lowercase letters instead of mixing it up.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..dcebb4643aff 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -14,7 +14,7 @@
 #define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
 
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
-#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR	0x00FF
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LINK		0x0200
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_RX		0x1000
@@ -27,6 +27,8 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_RX_STAT			33328
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -63,7 +65,8 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 		 * the link was already down.
 		 */
 		if (!phy_polling_mode(phydev) || !phydev->link) {
-			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+					   MDIO_PCS_1000BT1_STAT);
 			if (ret < 0)
 				return ret;
 			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
@@ -71,7 +74,8 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 		}
 
 		if (!link) {
-			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+					   MDIO_PCS_1000BT1_STAT);
 			if (ret < 0)
 				return ret;
 			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
@@ -95,7 +99,8 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 	 * we always read the realtime status.
 	 */
 	if (!phy_polling_mode(phydev) || !phydev->link) {
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_100BT1_STAT1);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_100BT1_STAT1);
 		if (ret < 0)
 			return ret;
 		else if (ret & MDIO_MMD_PCS_MV_100BT1_STAT1_LINK)
@@ -200,7 +205,7 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	return mv88q2xxx_config_aneg(phydev);
 }
 
-static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi(struct phy_device *phydev)
 {
 	int ret;
 
@@ -208,7 +213,8 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		/* Read the SQI from the vendor specific receiver status
 		 * register
 		 */
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_RX_STAT);
 		if (ret < 0)
 			return ret;
 
@@ -218,7 +224,7 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		 * but can be found in the Software Initialization Guide. Only
 		 * revisions >= A0 are supported.
 		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xfc5d, 0xff, 0xac);
 		if (ret < 0)
 			return ret;
 
@@ -227,10 +233,10 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 			return ret;
 	}
 
-	return ret & 0x0F;
+	return ret & 0x0f;
 }
 
-static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
 {
 	return 15;
 }
@@ -246,8 +252,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q2xxx_soft_reset,
 		.set_loopback		= genphy_c45_loopback,
-		.get_sqi		= mv88q2xxxx_get_sqi,
-		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+		.get_sqi		= mv88q2xxx_get_sqi,
+		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
 };
 
-- 
2.39.2


