Return-Path: <linux-kernel+bounces-73619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1385C531
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD62282765
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B614C5AF;
	Tue, 20 Feb 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6wiOCNP"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7514A4D8;
	Tue, 20 Feb 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458697; cv=none; b=k+Aguj+E2SCCQgddKwKJdYfh70ulNLZDya8Dzj6UplMbR+eNwLOK4+gTOeTGiAHR8VfiSJydQae10pmmi8ozrqRCG8uvmm5lRQh5Bf/H32qxIDqNgQTs/Oa54oXDacEKzXKJjS2Bv70DqU0nntu92mMZFsoB8XelUSHmbQpCgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458697; c=relaxed/simple;
	bh=hjaKrHSb+4g9Yg7pV+2zqt9Ih3ost52YRYTyHUox8bg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzVPPAyzjlawRZRts0fBIF1Ar/31qwaJZnZ3BOv3aI3Lq2s5jrLVc+SaxrnrXlAYmSR2pNkgZR+cVNKprueLH39++qiWF+N7zs1OECuwJ0MbFc8XtPWljn1TBqNQZp64KVKeHIunfemA64fiNstgzhmSGvpmezYogl9WaOGHyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6wiOCNP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d228a132acso48437741fa.0;
        Tue, 20 Feb 2024 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708458693; x=1709063493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpZVqpYazuNuHsJB29QHePKiHOfgklBcmo3nGloFXBI=;
        b=a6wiOCNPHHJx3xwckXfl2fvxWlHvr8FNJwKeeUCb3kYvsezixLXNFuK5RCJAOcCcv/
         B63gV0j7Z3t7BBTHFSuZ/YQVe+nE7Ah/HRxab/FxcHGKBHR/siZcwT5HmORUpAEV0msY
         soErWhuQdOnqW8nS6kWfn0QatZPJVEhoZAlPAU/Z+8mZ6dN/eP+CAWYigX7RYFU8Zijd
         m4SZOwEvdy8ab4xUiQSyiOhl6hA5MpKGwK54D6Y+aG1bVXuYTcMZCHzEq1McmrXU/Vlr
         zwu9Kh7EZ2JMlHEatzftx9Vu89uAjDvdcieTXNjcYJBEJzgdHs9AtcI0We/a1JVFGELY
         g4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458693; x=1709063493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpZVqpYazuNuHsJB29QHePKiHOfgklBcmo3nGloFXBI=;
        b=qfAAZNHKL/MK0wAx2HCrGtKyzwuLjDM0rapW9OU+tn4RU+GLOzZlYKh/xx1B9nTeLj
         358qVdspeTe3zQ7RgftbYMK0P00DFjmAD2Yfn9VJ9BxZSMwqcmXhoGld59R/dIkU8cXX
         zLzpxa+0bwZPiQLpqcuBxa1nACbBRotAONTVhUBf6+h4l3MujExS4OprOS7x1sm1B6jF
         wJV1T3hAaek5DqUzySmpf30vxpZdF0XGvusRmQ2ky/zNM11siAd7M2Fk3RKB1fUBaZYH
         C+bfQUKE/+udMpfW7E0E3LADOr1vH/5Dd/NY3yIaN7lj11ikE4wCkjd20HyEEQzThU/U
         s0+g==
X-Forwarded-Encrypted: i=1; AJvYcCWz9Vd26oscDxpWxT6p7Td/GhnHrh/v5qcIaw2x9kGTphOgKKJ67lVTzHe2ZBDjIx2epM1FmHNa4Gm+PwsvBnVO/a7eqC6e/ahILeU7efEad7WlFNQIcDChM2v2+CAonfLw10S5
X-Gm-Message-State: AOJu0YyhcewvmLpNoIMhhTmQV8+lU0m9duW7XfaSx2T943ssrpSEmEfn
	V7WDuBnjf8/QGS3dcRmTWdR5EvPILqOkXzQmnm4Lzxf4U8Xfk0bu
X-Google-Smtp-Source: AGHT+IEc+GHrYRqg9yAJXOiqtFZdJ8XVxniOTa5Oyho+LxK0d1F9vxP0vGDWOFhicCChZS7KO0fNWw==
X-Received: by 2002:a2e:a9a5:0:b0:2d2:3a31:c39f with SMTP id x37-20020a2ea9a5000000b002d23a31c39fmr5112734ljq.35.1708458692821;
        Tue, 20 Feb 2024 11:51:32 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fs14-20020a05600c3f8e00b00411a595d56bsm15494853wmb.14.2024.02.20.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:51:32 -0800 (PST)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 2/3] net: phy: aquantia: group common OPs for PHYs where possible
Date: Tue, 20 Feb 2024 20:50:49 +0100
Message-ID: <20240220195103.15809-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220195103.15809-1-ansuelsmth@gmail.com>
References: <20240220195103.15809-1-ansuelsmth@gmail.com>
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
index a6a7980585f5..e8c89fdbda94 100644
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
+	.ids		= (struct phy_driver_id []){
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
+	},
+	.ids_count	= 4,
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
+	.ids		= (struct phy_driver_id []){
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
+	},
+	.ids_count	= 3,
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
+	.ids		= (struct phy_driver_id []){
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
+	},
+	.ids_count	= 3,
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
+	.ids		= (struct phy_driver_id []){
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
+			.name		= "Aquantia AQR113"
+		},
+		{
+			PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
+			.name           = "Aquantia AQR113C",
+		},
+	},
+	.ids_count	= 2,
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
 	.config_init    = aqr113c_config_init,
-- 
2.43.0


