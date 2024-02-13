Return-Path: <linux-kernel+bounces-64048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9AC853962
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE721C27D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB287605AA;
	Tue, 13 Feb 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALsnNTxf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B16088D;
	Tue, 13 Feb 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847363; cv=none; b=G2mXO6UwYZgaG3KGOF0Thw6BRP3BOWJZMgrfYGeEDTTOh//oXZdZLHn/Fy1zbBm0U3wKiqlS7Zoxo5C86Lc0ZNQCmPvguxU4qvGsaesaZ/7c5xyDmxvjK5/vmmozs3ovKqBq4iIZQxYCjAo+Y6euduniKFIhET7fd331ue7RsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847363; c=relaxed/simple;
	bh=8mhEJdVwOEi6aObqDezu6duU7QCywcy9Cr7WOE8j2zY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dBRqBkahEP+vpGT8WETrU80BkX7hMg876jGun6fkSz9D+fD0vqfFC8oILaLxOFvUFTx6is2LhgBOeEsVaYlLJR5z/eDDt4JswXqJTSC8YG7DS0h9RoOTwLNp88CYSWv4tdVfYupQ0FIFN+lqrEUBNycem6NZ4XofWIVL+zx4cVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALsnNTxf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so518248f8f.0;
        Tue, 13 Feb 2024 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707847360; x=1708452160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbeBTq4/LfNyHORgmD6XWujV5RVtjEVSRBBFTbCsnHs=;
        b=ALsnNTxfC22apUuDDYYyAneZ6UwwyWcLapTtPbFB297jrj7vQWID/5n1ifoDhE+IMC
         9wTZb61fxgqgbzJFiMUcz6xNNJnTi1sWyeRhHgGe80Nx6q2ijqDDbXm3BJGEm7It7IJS
         anTfMpXgdugN4b0HLTUXJTYwx5Z6rHXYGt87aSDN3fE0WZ0OjkwsEUFvpOtWh9hDgvMi
         qUwXJ/CMMS5MzhIhefNtGrFZBhfojunOEofHXInVWEJ/8mxl6YrtPZxoGk0neSIoerjl
         aGvxlNO7sPFI/QibnxUwZVyzckC6b9BJr8f59TMJOZfCZwkT43FmEwILSCmvpXLh9a8Z
         OMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847360; x=1708452160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbeBTq4/LfNyHORgmD6XWujV5RVtjEVSRBBFTbCsnHs=;
        b=ZtATjE5v82030BYLNeLUwhZIzKnZ43WMR9zmWaqWu5Myuw9h8aGjI1Ayqy4WurZVVK
         zw6bifzOou2lEpGFIdxtBxttU2d4IStAg75ge5+xM1qKX2/G03fxMbRBH+3IT0QBs8xS
         23jGIPOlcEiYWPVDmoxVKUflcK2t5B4Y2Om9GGj8rnQwo8BPvMnv0jWsFzG+MwpnffVA
         jwWUD8BKdgSclxUMuf2tTTrmxW3ZckrHTkRG7bNCPGL+egeDTrot1Je4In5mdj0vsDAs
         ySN5Bea5ts5IANMSlCCL9A+P4DHs1f1gLD00Fnq06obGHheCfKjAFfT4oH/0Qt1N6wSw
         SFcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+kB1y9r8ZR1h45k5rVlJDOHXYVWQ4lU5svAYA8sSQG0neb/DMl3vsuIpT5vFu1U6PbwpBUEyMCQTQFq5JKCdk3Zp7me9qTeGXvTdYN9Y+PM7wakGAXplpOML6GfJQt63MIV8m
X-Gm-Message-State: AOJu0YzR8kyFqxPTa9cakO6D0IyQyPG8ZlFnZV+Dlv7vz6D5/767jIK7
	r41Gdxw5NVKF6ieCvZftvIoXha4fbM+EBqD3YV08GWKr7pYIti+8
X-Google-Smtp-Source: AGHT+IFvY5EqsQhoUmKf6I4dsYUzkHcap67TCG+Iol9S3200KJGxI7ckF0sz1bvwQZNKmUNyKD/pxw==
X-Received: by 2002:adf:f64c:0:b0:33b:69ee:9809 with SMTP id x12-20020adff64c000000b0033b69ee9809mr29430wrp.44.1707847359410;
        Tue, 13 Feb 2024 10:02:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFXRClYhpuflhYv6i4vlhftQVYRlaT8r64eVdssehUVpzPMuHYlzQZUypqEjmjyPw3I99WCB5cu+vhcY2QL3+n1fgAr6V2UWiSaP29eya1k0sga4wbt71dgkAct64Uj+UdwytSejZH5P02UvmxZA3PgApcZeLP6o/ZrpVPK+0YnnUQHBFnCgW4cy5HDyMqq5FQp8TkFnkNRhu/BQVOUiCGFqzFbZEdMTrxCDBoyTOa1bwhyMixzg1iKfCy8LiqBnwFVQSkz/EP+vy7BsVSmc8LHjnUHBYfWvbMpqhyfJeXiYVCbzNkpsvIT5dLFN/2eiqxIHjpR61JDOnvRrpnv++w+oDVB/B/yM0/a4KanPfzaQ4d9rjH0vo+TdzDB2CDqwcQ6SSxgwo=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z11-20020a5d44cb000000b0033b43a5f53csm10034737wrr.103.2024.02.13.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:02:39 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH] net: phy: aquantia: add AQR113 PHY ID
Date: Tue, 13 Feb 2024 19:02:26 +0100
Message-ID: <20240213180228.15859-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aquantia AQR113 PHY ID. Aquantia AQR113 is just a chip size variant of
the already supported AQR133C where the only difference is the PHY ID
and the hw chip size.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 97a2fafa15ca..aba3a52af11d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -24,6 +24,7 @@
 #define PHY_ID_AQR405	0x03a1b4b0
 #define PHY_ID_AQR112	0x03a1b662
 #define PHY_ID_AQR412	0x03a1b712
+#define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -863,6 +864,25 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
+	.name		= "Aquantia AQR113",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr113c_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt       = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
 	.name           = "Aquantia AQR113C",
@@ -896,6 +916,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR405) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ }
 };
-- 
2.43.0


