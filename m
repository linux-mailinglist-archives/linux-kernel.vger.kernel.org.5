Return-Path: <linux-kernel+bounces-73620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CD85C534
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB371C21919
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B114D43B;
	Tue, 20 Feb 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHdaNa0y"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648014A4F4;
	Tue, 20 Feb 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458697; cv=none; b=hv8nG5Q0Lo1ChHBxujXMO19MQuOmWdGLgLUpw/tt5koY8MzUV2Y/PNL31g0XQymK4TrguICQX7SAKWZE6eamTrRsLs3vYhz2pgwOGrIPhFvFGDNEPS7Ml45raL7R87CzS/DY8brIsmv2KZjGb+DkJ1GPkxwGrMDXpfYm1ouZVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458697; c=relaxed/simple;
	bh=qm4J52zhk5u0MtOFjSjMJaCZJdPHiRD6eD1ZnGm+OIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2XFSkXntTSR2nAr2+Qh+PBWAduAaM5aaMnCiFH55z35hFOe2erGtGXXx3CUoG91Z/dnqGpiMFUmojVYGVlmxUZHoprNnpb/0O9hP66JMrS9Fi48vAjNG23jQpKdMloIruyrIN3/SA+l4kClTcGzGOITokM56rTuGeHnD+gu5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHdaNa0y; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso44297291fa.2;
        Tue, 20 Feb 2024 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708458694; x=1709063494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh2L6RcGiFdKCx7zZiu22h0FVnPxtlYVoTMnMq0TsIY=;
        b=CHdaNa0yR9+h484haJUUQBi5AbzmS1u9pwNzwmQXfGQZ3uonhe9Zv5hsCRK2eGvtiH
         OCwXQY4L6/OA/yCQAeR2uxW4HyHVVVzI8LRzz7VooTwl+2oIPV+HlqiYO3ilwPmPfaHx
         WQIVMTF2C1Cd0NDrxlyNvCZMUYGBFxuKipmb783rRzcYWEnIs29Q1b3n+iWhfqVE2tqV
         AM8+0GwSe+fp6Mfp1oIzYpqQQJCeFXNBVJVx6P082EdLYdT36Q4gBxwDhhE/qObHdZn8
         T0stanRsqrrlajxdbp5QfspgHbNSLgR7pN/IcaMRbCCby8RZj/FM5UuhtDdOwwfS2Gno
         og7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458694; x=1709063494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh2L6RcGiFdKCx7zZiu22h0FVnPxtlYVoTMnMq0TsIY=;
        b=FKo53wLRddiGpY4K95FfnfkPFb8CSLxK5GZa8pnNm4aTY2SrxBjbmJ6DbXyuw5EXsO
         H4HGL3rSZPzl2JZAKlXgRlZhra50dcxJp8fpkLU6hmkeJjLijUykEIGwUioFIwStHndq
         p7Z5QCe7uXs9LRQy0Lg7Qlsj1TF6nrwaAD/PI4QiY8c6/phh0K7jnk5lmSELWxAW3o9q
         B3QlZcakak1q2EbW3GFUchhs/XlOVUbA74uaj5srHd5YCh9McIhUKy+qjePx6IKZKEp7
         7OjCNB14evr5clr+UyB7kF5dD0FnPPbH+o2WZ8jxBli4uFuONS+e0RMPcUn3FTQTeysO
         O2CA==
X-Forwarded-Encrypted: i=1; AJvYcCVQzNpGkNAfCDRty2Dzup1d9WUz+bA7HwjILayHPqJWyRaPYgFJ/hiuJzy9lxt9MngAZMstpEzBe3qraY8gvZJghiOUC+sEUF/v5FLwhIBHNpVTrXmo5cglYUAlzR0uEZ9MXvA+
X-Gm-Message-State: AOJu0YwSzzFCYwRuyv1x1R9loIj+LK12thovZn+N1E66xA90tWjlQj6r
	pYKa1vSQ232JYoQ8q5Bz3TwiiYk57Ke5SXkwHfLLpt6Z3oToM0yD
X-Google-Smtp-Source: AGHT+IE0uB67JIW5GgBoh+sWq5kdhOomUj2tauYSPRIJ1xo33wjPZfkuNU9PbDI3HaFeWna9el6yvw==
X-Received: by 2002:a05:651c:102c:b0:2d2:3a60:e6bb with SMTP id w12-20020a05651c102c00b002d23a60e6bbmr4288545ljm.52.1708458694171;
        Tue, 20 Feb 2024 11:51:34 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fs14-20020a05600c3f8e00b00411a595d56bsm15494853wmb.14.2024.02.20.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:51:33 -0800 (PST)
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
Subject: [net-next RFC PATCH v2 3/3] net: phy: bcm7xxx: rework phy_driver table to new multiple PHY ID format
Date: Tue, 20 Feb 2024 20:50:50 +0100
Message-ID: <20240220195103.15809-4-ansuelsmth@gmail.com>
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

Rework bcm7xxx PHY driver table to new multiple PHY format
implementation to reduce code duplication and final size of the compiled
module.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm7xxx.c | 140 ++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 58 deletions(-)

diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 97638ba7ae85..6ff09c92f7fa 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -845,16 +845,6 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id		= (_oui),					\
 	.phy_id_mask	= 0xfffffff0,					\
 	.name		= _name,					\
-	/* PHY_GBIT_FEATURES */						\
-	.flags		= PHY_IS_INTERNAL,				\
-	.config_init	= bcm7xxx_28nm_config_init,			\
-	.resume		= bcm7xxx_28nm_resume,				\
-	.get_tunable	= bcm7xxx_28nm_get_tunable,			\
-	.set_tunable	= bcm7xxx_28nm_set_tunable,			\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
 }
 
 #define BCM7XXX_28NM_EPHY(_oui, _name)					\
@@ -862,16 +852,6 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id		= (_oui),					\
 	.phy_id_mask	= 0xfffffff0,					\
 	.name		= _name,					\
-	/* PHY_BASIC_FEATURES */					\
-	.flags		= PHY_IS_INTERNAL,				\
-	.config_init	= bcm7xxx_28nm_ephy_config_init,		\
-	.resume		= bcm7xxx_28nm_ephy_resume,			\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,			\
-	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,			\
 }
 
 #define BCM7XXX_40NM_EPHY(_oui, _name)					\
@@ -879,12 +859,6 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id         = (_oui),					\
 	.phy_id_mask    = 0xfffffff0,					\
 	.name           = _name,					\
-	/* PHY_BASIC_FEATURES */					\
-	.flags          = PHY_IS_INTERNAL,				\
-	.soft_reset	= genphy_soft_reset,				\
-	.config_init    = bcm7xxx_config_init,				\
-	.suspend        = bcm7xxx_suspend,				\
-	.resume         = bcm7xxx_config_init,				\
 }
 
 #define BCM7XXX_16NM_EPHY(_oui, _name)					\
@@ -892,41 +866,91 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.phy_id		= (_oui),					\
 	.phy_id_mask	= 0xfffffff0,					\
 	.name		= _name,					\
-	/* PHY_BASIC_FEATURES */					\
-	.flags		= PHY_IS_INTERNAL,				\
-	.get_sset_count	= bcm_phy_get_sset_count,			\
-	.get_strings	= bcm_phy_get_strings,				\
-	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
-	.probe		= bcm7xxx_28nm_probe,				\
-	.config_init	= bcm7xxx_16nm_ephy_config_init,		\
-	.config_aneg	= genphy_config_aneg,				\
-	.read_status	= genphy_read_status,				\
-	.resume		= bcm7xxx_16nm_ephy_resume,			\
 }
 
 static struct phy_driver bcm7xxx_driver[] = {
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM72113, "Broadcom BCM72113"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM72116, "Broadcom BCM72116"),
-	BCM7XXX_16NM_EPHY(PHY_ID_BCM72165, "Broadcom BCM72165"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7250, "Broadcom BCM7250"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7255, "Broadcom BCM7255"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7260, "Broadcom BCM7260"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7268, "Broadcom BCM7268"),
-	BCM7XXX_28NM_EPHY(PHY_ID_BCM7271, "Broadcom BCM7271"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7278, "Broadcom BCM7278"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7364, "Broadcom BCM7364"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7366, "Broadcom BCM7366"),
-	BCM7XXX_16NM_EPHY(PHY_ID_BCM74165, "Broadcom BCM74165"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM74371, "Broadcom BCM74371"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439, "Broadcom BCM7439"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439_2, "Broadcom BCM7439 (2)"),
-	BCM7XXX_28NM_GPHY(PHY_ID_BCM7445, "Broadcom BCM7445"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7346, "Broadcom BCM7346"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7362, "Broadcom BCM7362"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7425, "Broadcom BCM7425"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7429, "Broadcom BCM7429"),
-	BCM7XXX_40NM_EPHY(PHY_ID_BCM7435, "Broadcom BCM7435"),
-	BCM7XXX_16NM_EPHY(PHY_ID_BCM7712, "Broadcom BCM7712"),
+{
+	.name		= "Broadcom BCM7XXX 16NM EPHY",
+	.ids		= (struct phy_driver_id []){
+		BCM7XXX_16NM_EPHY(PHY_ID_BCM72165, "Broadcom BCM72165"),
+		BCM7XXX_16NM_EPHY(PHY_ID_BCM74165, "Broadcom BCM74165"),
+		BCM7XXX_16NM_EPHY(PHY_ID_BCM7712, "Broadcom BCM7712"),
+	},
+	.ids_count	= 3,
+	/* PHY_BASIC_FEATURES */
+	.flags		= PHY_IS_INTERNAL,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+	.config_init	= bcm7xxx_16nm_ephy_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.resume		= bcm7xxx_16nm_ephy_resume,
+},
+{
+	.name		= "Broadcom BCM7XXX 28NM GPHY",
+	.ids		= (struct phy_driver_id []){
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7250, "Broadcom BCM7250"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7278, "Broadcom BCM7278"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7364, "Broadcom BCM7364"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7366, "Broadcom BCM7366"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM74371, "Broadcom BCM74371"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7439, "Broadcom BCM7439"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7439_2, "Broadcom BCM7439 (2)"),
+		BCM7XXX_28NM_GPHY(PHY_ID_BCM7445, "Broadcom BCM7445"),
+	},
+	.ids_count	= 8,
+	/* PHY_GBIT_FEATURES */
+	.flags		= PHY_IS_INTERNAL,
+	.config_init	= bcm7xxx_28nm_config_init,
+	.resume		= bcm7xxx_28nm_resume,
+	.get_tunable	= bcm7xxx_28nm_get_tunable,
+	.set_tunable	= bcm7xxx_28nm_set_tunable,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+},
+{
+	.name		= "Broadcom BCM7XXX 28NM EPHY",
+	.ids		= (struct phy_driver_id []){
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM72113, "Broadcom BCM72113"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM72116, "Broadcom BCM72116"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7255, "Broadcom BCM7255"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7260, "Broadcom BCM7260"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7268, "Broadcom BCM7268"),
+		BCM7XXX_28NM_EPHY(PHY_ID_BCM7271, "Broadcom BCM7271"),
+	},
+	.ids_count	= 6,
+	/* PHY_BASIC_FEATURES */
+	.flags		= PHY_IS_INTERNAL,
+	.config_init	= bcm7xxx_28nm_ephy_config_init,
+	.resume		= bcm7xxx_28nm_ephy_resume,
+	.get_sset_count	= bcm_phy_get_sset_count,
+	.get_strings	= bcm_phy_get_strings,
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,
+	.probe		= bcm7xxx_28nm_probe,
+	.read_mmd	= bcm7xxx_28nm_ephy_read_mmd,
+	.write_mmd	= bcm7xxx_28nm_ephy_write_mmd,
+},
+{
+	.name		= "Broadcom BCM7XXX 40NM EPHY",
+	.ids		= (struct phy_driver_id []){
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7346, "Broadcom BCM7346"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7362, "Broadcom BCM7362"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7425, "Broadcom BCM7425"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7429, "Broadcom BCM7429"),
+		BCM7XXX_40NM_EPHY(PHY_ID_BCM7435, "Broadcom BCM7435"),
+	},
+	.ids_count	= 5,
+	/* PHY_BASIC_FEATURES */
+	.flags          = PHY_IS_INTERNAL,
+	.soft_reset	= genphy_soft_reset,
+	.config_init    = bcm7xxx_config_init,
+	.suspend        = bcm7xxx_suspend,
+	.resume         = bcm7xxx_config_init,
+},
 };
 
 static struct mdio_device_id __maybe_unused bcm7xxx_tbl[] = {
-- 
2.43.0


