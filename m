Return-Path: <linux-kernel+bounces-67709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D1856F79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998DD286033
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120B13EFE9;
	Thu, 15 Feb 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7b/kcNP"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A613B7BE;
	Thu, 15 Feb 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033429; cv=none; b=gKGIws6HTnCoMdOenFHfWg+H+wEWTenl2ynGQH79yTBkpeVgFAZdPjoVIHT5D8hSs0k5zB5g6ajrh3lmLvIr4ZUnt1acuG5DCQMaeQTUheKxRPK6AcNGCDch0Gf000l3KfCLwywU2i02DYvXO1RcBGGv9LvVd6gkZyznup+D5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033429; c=relaxed/simple;
	bh=QaEZlqJFcTfiTUOyjsDsoswbJ0CUnBjYeZ73Th5EEfE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F+2shX/gIbphkHkAMFOqbb8MkuRZZMrJbRfi/OOfRtHi+S4pOtO7sg58cRgBwcF85L7qnRALbWDWvGqbELD+QTlYe+705jvFftAG74FBaACw01XFQXNWhkxVtvUZC52MaNFh5GnUtNoHGs8n0j/oSVQ9lPmx9wE/51+4L/Pntd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7b/kcNP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b28aadb28so713258f8f.3;
        Thu, 15 Feb 2024 13:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708033426; x=1708638226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a10Ci9q0vKOTRsi2gPzKUjUwhpFZoCzWi4g8A+iVQbI=;
        b=Z7b/kcNP0VXMGOYKSi7gWcGluT6MhBpNqGm2hXk+ZUCxHFVRSBLV42FTKAzZ6xO00S
         l+zTKwzeTGbXjr7j0MoyFquPzKLT6ZBsGjPASHdsqY6ymAbY0l5HLs6bQVnYwYzO/nNl
         iJxqy+Thddzh982+CfHiKpJJmDv0wsgXU1+O5bNeeNIfuvnjg4U0Zg93l5z4BJkrGvWa
         0nX+Htixt3Nh3aCL8qE+1GAJ0dkAG2ISgZQTJlLCZOyQcrEcmit/eeC+qT9hQ3pbx4Kj
         rBkSFEz6aXHyQHGbx+sgOXIjEih/NQ56p3MiXSAxQQys7wdyhEWLcJLwG5w5GWk+90AT
         5o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033426; x=1708638226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a10Ci9q0vKOTRsi2gPzKUjUwhpFZoCzWi4g8A+iVQbI=;
        b=msjVx4vcU2jR65C8EMtjfQNBKG2a5ycqDx5Wdj4KQxahlt2FOxEWTp38phE4GwM4xy
         SCmdrU6u6cgSrAihoBo7UFUOmClc0/ONKGF12SNyqZtw49BRBTlhYHfYN11EmphJUHXp
         gYYd8tBLGNURRnBpNYrDzoBH5NlmxNuD1KX/Q7YbUKmjCycpeTN6Qh8jIo/eiojqEeV/
         UDk7VyDr8Ibo3GUI5YuDjz177wb1dqqJEcJIYKKzPUkC/9afnBmZZtqdpIfhVqqSu4bk
         b4gU8Lc0/wVaEUcfsvJEMD9e3txoEpi909CWcr6vPzg5tU6hJQlc1JvnvAA+kBk7uDUy
         8nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcTkpnuMija3WEUChkd+yRTSSrDIoOgxD+9flJXmeF5L9GRs9sEAo92OcWVeuiFoyV3arTj1FUvbC3/AQ6HjA2dYKfHvSj2nW8y517TgHHmsupHO5w5w/X0722keIK1PQLnMPA
X-Gm-Message-State: AOJu0YwlCjOGCCTIWCuWuAExqZTjwHlL+7S0+8ubvoa6QNyfIjYUWjaD
	n08DEP234kfgSptmWUxvs/Gya7T6dVgJyQDPnsDUVcTSDjyhSho/
X-Google-Smtp-Source: AGHT+IHfgLD79KYgorlZdaTvX73xBlXRjpZdgwQp5SX3Eg5atbw0+Uw2AGN/UX8xO/2hsrCDjlrhfA==
X-Received: by 2002:adf:979a:0:b0:33d:f4b:d484 with SMTP id s26-20020adf979a000000b0033d0f4bd484mr1681844wrb.16.1708033426035;
        Thu, 15 Feb 2024 13:43:46 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm284740wrx.47.2024.02.15.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 13:43:45 -0800 (PST)
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
Subject: [net-next PATCH] net: phy: aquantia: add AQR813 PHY ID
Date: Thu, 15 Feb 2024 22:43:30 +0100
Message-ID: <20240215214331.18162-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aquantia AQR813 is the Octal Port variant of the AQR113. Add PHY ID for
it to provide support for it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
This is based on the AQR113 patch that has been already reviewed
and accepted (still not in net-next as a rebase was needed)

 drivers/net/phy/aquantia/aquantia_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index a6a7980585f5..71bfddb8f453 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -28,6 +28,7 @@
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
+#define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
@@ -961,6 +962,25 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
+	.name		= "Aquantia AQR813",
+	.probe		= aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init	= aqr107_config_init,
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
 };
 
 module_phy_driver(aqr_driver);
@@ -979,6 +999,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
 
-- 
2.43.0


