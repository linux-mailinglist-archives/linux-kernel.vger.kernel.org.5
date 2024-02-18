Return-Path: <linux-kernel+bounces-70527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A14D8598DD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD3282061
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC674E25;
	Sun, 18 Feb 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlHJZJsR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091E73170;
	Sun, 18 Feb 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282853; cv=none; b=K6SuHhTiP/grTzurJ0UXHAzhS0hyaQZUWn16rfnPya2mDOtZdRacG28mds/ve10L9T1CJPmIYlp5k6OduPwEre8vP/Lbla67j5Yr1vDT9LS1yoGAAgHhz8Up7esF4aWWIyzvDVUS/0k5mXbbCs5NIlmiCZP8lXWYLygjwNj9KnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282853; c=relaxed/simple;
	bh=J026UxEVxVrHqoetNwJqWqAaKMfc2Oh3wU+/mVBHyOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkv/oWlPlvOaoMNEn2adve1RlRec/cy+XTgLl422thoxtJZBaVeIrDSaRRbOkvTOxyqgsg2iRn8cA3VeC3Q6Zf2Jbwve4MzSAg0WYsLjQQCwFMl5LfKF+KY580oVPHHeFHYNFl3FDX1igT/U4H1vDOjubu/i3xzP2TFjmdazOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlHJZJsR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d375993f4so404464f8f.1;
        Sun, 18 Feb 2024 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282849; x=1708887649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dU1BBPhidy3QSkuNfiM8Gww7zKe+F20tB7LQibq13Y=;
        b=jlHJZJsRwtvvtq3CnNmeZB02912zk1C6OLoMGWcclvjnhCNtq6EKLq5xYNEvEX9mn2
         NuzmH6xetL0+P/8BMZEkQLM40FLoA4DbIh6DRVm4hY/rntPxnVJTYVTcsuczLV4i2Xfj
         GK8fT+OjD7DWfTC1acbKhb6uQBID595B1zUnZKeAgpEtY4KLwK3dOXh7zoPoUvh6cpx3
         I2vRBKdvUhxLFBOvoujNRnmB8FOdIIzuryNYsO2E4+qjHsrHT1cBhPSMQy55OHLdJEax
         5xDtKAV/9glQIkmCdlptHudiozMTHWMSrj9qlbsIrE1n8r6OANz+1Ef7aE5D3LpzayCI
         ijEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282849; x=1708887649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dU1BBPhidy3QSkuNfiM8Gww7zKe+F20tB7LQibq13Y=;
        b=YS1KjdDLpDwemmbdmhT/uP4XxDfGztsvU0PUn5K0GPx64iGwt114fFhYhWXWfjPzWx
         lrh9G7iRXXGm705TFFG1bQnMzwi6csfJAEj6TksIM70qJcy+5kyAYKY1namlgT8ujIA1
         uN7jBNyytU3Rt5HTijgY4tlCwr+SlhxW1QMapeP1rh/KzxGMzCntnYovCP8D9++yJANe
         6Cy5ZMb5jUi4V2RA5pmTEURrn4hkor7m9LTEQyI73qMOROEw4hgkMtFZNgql00K0azuW
         7JjQ9t4prUupu7K8XyftJydDIucZmZvJRePjigIFTchAAb7YY9Hx3DkL2Fqto1NW6gUj
         HRqg==
X-Forwarded-Encrypted: i=1; AJvYcCUBR5zWAfUn6r7i5n090HC7V/BTBzdR38zt0wRbONwoypPK+MxtbOMPzkCxBg/7Oe+nwFaE12wvtCJRwNS7H4ezaP5N72GzNxzHZs1ljnkW1fhcIUxkM3s3Gz/dhhQgfAGnlYuQ
X-Gm-Message-State: AOJu0YyXl7qmUgtjHCnizDaJRVhhzlAFnU/Hkf/zRW7icKZW7EQFnaq6
	pHPvwrKrpQNWPl18Y1RTmATUWeZMaJFr06ScBg9Reuz7Z6qOe+uN
X-Google-Smtp-Source: AGHT+IGzqfvL0CYD2TWIRsZSWYbNVUZS4lbeGA2/6uQTiXorzHsvazPUrackIa058ILS91+PgJlWdA==
X-Received: by 2002:adf:f3c2:0:b0:33d:35ef:ac2e with SMTP id g2-20020adff3c2000000b0033d35efac2emr2915574wrp.17.1708282849381;
        Sun, 18 Feb 2024 11:00:49 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:49 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 5/6] net: phy: aquantia: group common OPs for PHYs where possible
Date: Sun, 18 Feb 2024 20:00:31 +0100
Message-ID: <20240218190034.15447-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218190034.15447-1-ansuelsmth@gmail.com>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group common OPS for PHY where possible by defining multiple PHYs for
similar PHY drivers instead of duplicating them for each PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 170 +++++++++--------------
 1 file changed, 64 insertions(+), 106 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index a6a7980585f5..4a788fc8e26a 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -770,16 +770,26 @@ static int aqr111_config_init(struct phy_device *phydev)
 
 static struct phy_driver aqr_driver[] = {
 {
-	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
-	.name		= "Aquantia AQ1202",
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQ2104),
-	.name		= "Aquantia AQ2104",
+	.name		= "Aquantia AQ1202/AQ2104/AQR106/AQR405",
+	.ids		= (const struct mdio_device_id []){
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
+			.name		= "Aquantia AQ1202"
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQ2104),
+			.name           = "Aquantia AQ2104",
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
+			.name           = "Aquantia AQR106",
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
+			.name           = "Aquantia AQR405",
+		},
+		{ /* sentinel */ },
+	},
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -796,16 +806,22 @@ static struct phy_driver aqr_driver[] = {
 	.resume		= aqr107_resume,
 },
 {
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
-	.name		= "Aquantia AQR106",
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR107),
-	.name		= "Aquantia AQR107",
+	.name		= "Aquantia AQR107/AQR112/AQR412",
+	.ids		= (const struct mdio_device_id []){
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR107),
+			.name		= "Aquantia AQR107"
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
+			.name           = "Aquantia AQR112",
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
+			.name           = "Aquantia AQR412",
+		},
+		{ /* sentinel */ },
+	},
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqr107_config_init,
@@ -842,27 +858,22 @@ static struct phy_driver aqr_driver[] = {
 	.link_change_notify = aqr107_link_change_notify,
 },
 {
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
-	.name		= "Aquantia AQR111",
-	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
-	.get_sset_count	= aqr107_get_sset_count,
-	.get_strings	= aqr107_get_strings,
-	.get_stats	= aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
-	.name		= "Aquantia AQR111B0",
+	.name		= "Aquantia AQR111/AQR111B0",
+	.ids		= (const struct mdio_device_id []){
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
+			.name		= "Aquantia AQR111"
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
+			.name           = "Aquantia AQR111B0",
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
+			.name           = "Aquantia AQR106",
+		},
+		{ /* sentinel */ },
+	},
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init	= aqr111_config_init,
@@ -880,71 +891,18 @@ static struct phy_driver aqr_driver[] = {
 	.link_change_notify = aqr107_link_change_notify,
 },
 {
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
-	.name		= "Aquantia AQR405",
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
-	.name		= "Aquantia AQR112",
-	.probe		= aqr107_probe,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
-	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings	= aqr107_get_strings,
-	.get_stats	= aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
-	.name		= "Aquantia AQR412",
-	.probe		= aqr107_probe,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr	= aqr_config_intr,
-	.handle_interrupt = aqr_handle_interrupt,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
-	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings	= aqr107_get_strings,
-	.get_stats	= aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
-	.name		= "Aquantia AQR113",
-	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr113c_config_init,
-	.config_aneg    = aqr_config_aneg,
-	.config_intr    = aqr_config_intr,
-	.handle_interrupt       = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
-	.get_tunable    = aqr107_get_tunable,
-	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
-	.get_sset_count = aqr107_get_sset_count,
-	.get_strings    = aqr107_get_strings,
-	.get_stats      = aqr107_get_stats,
-	.link_change_notify = aqr107_link_change_notify,
-},
-{
-	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
-	.name           = "Aquantia AQR113C",
+	.name		= "Aquantia AQR113/AQR113C",
+	.ids		= (const struct mdio_device_id []){
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
+			.name		= "Aquantia AQR113"
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
+			.name           = "Aquantia AQR113C",
+		},
+		{ /* sentinel */ },
+	},
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init    = aqr113c_config_init,
-- 
2.43.0


