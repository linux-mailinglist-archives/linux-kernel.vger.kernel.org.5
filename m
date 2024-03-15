Return-Path: <linux-kernel+bounces-104143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F887C9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC31C22319
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08A15E88;
	Fri, 15 Mar 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp7RNCfS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5821AAAE;
	Fri, 15 Mar 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490068; cv=none; b=SjhKnNi5jE66seTzuR8l9XzRX7D0WowVYnb/lzmvyBz0qG9A1o0Z6pKbLMe4Q6qA/lmf/feijt9eSVs0i49nXBdtK05PsthhmOne7WDe6k9Pj39uTiYtJ3YhErmCaizSLMS/uAU0nkIkpQ8ypjvMk4PSxXQYMGwQZ4aSAiqz/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490068; c=relaxed/simple;
	bh=I9CZHjGLseY19YFTtusPH4FEw4b8ZHI1OZ1poZl29Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPzn25tJImT9Zu4gwmKLV79NXInitESoYXjHeqpr3b0jnJ+kn1wcCGarmHxT2Ud8krEPO+mXfROJnd8HG3gq2PP4p3QjcV0z/FWSDfonmys8EZiwa5egVWVXSQ/E4KWtfVeFQp5F+MCJ8vuIT2uH08rmDQ8VmYg2bE7gRazP6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp7RNCfS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so2252868e87.0;
        Fri, 15 Mar 2024 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710490064; x=1711094864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PKCiNmwzWlVeb44V5zJD+USqe8HMNhcEB2r7dumJco=;
        b=kp7RNCfSm2t5gB/CntMxTmPupEsszDq6DPYBDofg65CaRmuZCzg6vM4zF/NXmJqHH4
         8yQMOBnx7fSkoCDMWoPuBA5fY5ZUXJfhjGQpFr2X3HDbJGwWX5A842KJURGF8HsRc87a
         0Abg8Ypd/19ZuMHU/zdvSAPecH4id3njuN/5bEqcqOA6Ipdn6C4kJyZhKQ4jnJPLPfQ0
         MRpEMJA/oXdsdo9tDi3n2O7TM+ZggRAHvAiFdkm3rcJ1Ia4cBAy0kNQoi82cnt4c1i5a
         07tz7uGYxSIaDENHm1xJzjWvUsor1qRMxBBaxKqmZJc1ftXRsIQQiCEUo50XA6Q6NtgO
         28eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490064; x=1711094864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PKCiNmwzWlVeb44V5zJD+USqe8HMNhcEB2r7dumJco=;
        b=NthTcEvl+96UIMngxJJ/vQkRCHRJAsKiUgSot8wuoieP4CZSrzVHo7J8pLVf6/jPfS
         xo1oOZg9O5UMotiHyS6Lo2ibtUCEv+f4teI/70dqN0iM0qOzHJchg/Pe9bBk/hNTtc/p
         4cE+pRvcpg3P5NQdMTMfxvVtdbmlUuyn6p29BmqB9t7pLvmiOYCHoQ5OwruFVClm6na+
         jo2O+L9oATH4/sbKge7/dG0FtqC/CcFpxztgBC95Lv6DPP5ad2CyJd7vp5gt6aamnoGs
         RjteFPTjmnrB0Dl7edDemBOCeYGfKk4lTCEOyKZo4MUEaIfWwfJUaNUuI1uaDyCaD+Nv
         Hrmg==
X-Forwarded-Encrypted: i=1; AJvYcCVpuk3BlkwWuHI9PHo0Y2gkguO3SwHRdm68sq+5zPX2yLWgauIxsLhR214B/4RixaDKkl9JNeeHh6a0biDYRfhsWdUQT6eL0OT/jxGKhkCj32DvNZkL1LyrtNlqeu63UkJsliJG
X-Gm-Message-State: AOJu0YyDxSwoeWkyYvuENyNJVU7PmYV9YYtBEvcRu7oQ0tBAVIcfhbK1
	uwg/NtbnJ2+Jsv95GnFSykdDc6kDVezQsfX09JNITPMf9Rcge8g=
X-Google-Smtp-Source: AGHT+IGGFlDBe2VZdzwHilcJKmzNzqi5YhmYuqrSAunBcPK03IlR8xn2HJOQFeCLPiNH+44BvmAkNQ==
X-Received: by 2002:a05:6512:3b96:b0:513:c227:70bd with SMTP id g22-20020a0565123b9600b00513c22770bdmr1985223lfv.60.1710490063677;
        Fri, 15 Mar 2024 01:07:43 -0700 (PDT)
Received: from frutis-latitude7490.lan (public-gprs367196.centertel.pl. [37.47.65.157])
        by smtp.googlemail.com with ESMTPSA id l24-20020a19c218000000b00513d1ff9eb2sm475518lfc.208.2024.03.15.01.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:07:42 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: 
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH net-next] net: phy: aquantia: add support for AQR114C PHY ID
Date: Fri, 15 Mar 2024 09:06:50 +0100
Message-ID: <20240315080657.3460084-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for AQR114C PHY ID. This PHY advertise 10G speed
but supports only up to 5G speed.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 71bfddb8f453..e1fdfa537452 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -28,6 +28,7 @@
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
+#define PHY_ID_AQR114C	0x31c31c22
 #define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -962,6 +963,25 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR114C),
+	.name		= "Aquantia AQR114C",
+	.probe		= aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init	= aqr111_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status	= aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
+	.get_sset_count	= aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
 	.name		= "Aquantia AQR813",
@@ -999,6 +1019,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
-- 
2.44.0


