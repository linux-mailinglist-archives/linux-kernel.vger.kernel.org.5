Return-Path: <linux-kernel+bounces-17246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D93824A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A191C2299F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0292D62D;
	Thu,  4 Jan 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5LY7I24"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F32D025;
	Thu,  4 Jan 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5d898162so6950625e9.3;
        Thu, 04 Jan 2024 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704403870; x=1705008670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVBS1V62Gpoj3fBJkStvgTfzmgRQagXDXgLPu017kk0=;
        b=c5LY7I24NEe89e4PXA8zy6EsErxP0DtNXdQp+vFlYC+I8duqpeagHmJQVs59cpSxY4
         BTUvAvqlXs6n5Ie3Ht0McIl49ZmrP6AlC2BbZ0eDeYxwvJXNW0SyWP8NBivUwmDJFIYz
         iqWNeiBjNf6cflX962+WAIdNOJTBAKjxNRLNrY/NkHHQHSwwRSdH2hO9Az6wjd8MehE6
         JZaedFddZnk5juWv+/d8VNNL9J6mCqGUNQ4Re9RJAGtk7nPkQyvOVS7WGtG3w/HZRyOQ
         yv7/5Xc8F/r0Ugg4HqoGqMMMGoOXZxTKmZRgAo8d8hSVs0UjNyRLlnjzj/WoW/IPBlLA
         8aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403870; x=1705008670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVBS1V62Gpoj3fBJkStvgTfzmgRQagXDXgLPu017kk0=;
        b=w4cJuFXBqkagvehY4DUXiJJDY1Tb7Amg6GSHWvsGnxg6JazP4tJTZe1kn5lcSlnD4y
         3Jg2yFEsqMh3QHO4OwIA51Hjjd2PAXfDz54M3eNYNBBBYMCfOdE8+WcNuN3WyPs6+qpM
         NalRHfUVLYz2q3zcWg6iT84lJNOiXBPdFJ/6PqgnJNs4/yoStrDOwCJp7f4NGtsG3WCt
         LiG8yI8tPKBNzFCoJ5IHekqJwDXJkF7fCJSI2Ten05sxMYttB+J9L5eneEu6QndSxvLj
         PZlssam/f2QVvOI/0tKXDBQRAyaguZBgAb//W1MALG6s1g5cR4rDp/AL03T9NloC13Pg
         Bbgg==
X-Gm-Message-State: AOJu0Ywzy7rvDOF0Mx1oxgO643ysjj44bq3EFo0PWzA5VfC71VMFqWKb
	vRjda+/lMatylSSwFpAorTc=
X-Google-Smtp-Source: AGHT+IFzoncIKDP68tvJFBWtJj/p4CDKi2jg/rck1Vya0sE2kB95KzRCIh8IVeqB2zvYWLuZdVYz1A==
X-Received: by 2002:a05:600c:b58:b0:40d:87b7:2462 with SMTP id k24-20020a05600c0b5800b0040d87b72462mr707284wmr.40.1704403870094;
        Thu, 04 Jan 2024 13:31:10 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05600c4e8e00b0040d3dc78003sm407291wmq.17.2024.01.04.13.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:31:09 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 4/4] net: phy: at803x: make read_status more generic
Date: Thu,  4 Jan 2024 22:30:41 +0100
Message-ID: <20240104213044.4653-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104213044.4653-1-ansuelsmth@gmail.com>
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make read_status more generic in preparation on moving it to shared
library as other PHY Family Driver will have the exact same
implementation.

The only specific part was a check for AR8031/33 if 1000basex was used.
The check is moved to a dedicated function specific for those PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b44b91c58696..2f50170738f3 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1020,13 +1020,9 @@ static int at803x_read_specific_status(struct phy_device *phydev,
 
 static int at803x_read_status(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	struct at803x_ss_mask ss_mask = { 0 };
 	int err, old_link = phydev->link;
 
-	if (priv->is_1000basex)
-		return genphy_c37_read_status(phydev);
-
 	/* Update the link, but return if there was an error */
 	err = genphy_update_link(phydev);
 	if (err)
@@ -1620,6 +1616,17 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+/* AR8031 and AR8033 share the same read status logic */
+static int at8031_read_status(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+
+	if (priv->is_1000basex)
+		return genphy_c37_read_status(phydev);
+
+	return at803x_read_status(phydev);
+}
+
 /* AR8031 and AR8035 share the same cable test get status reg */
 static int at8031_cable_test_get_status(struct phy_device *phydev,
 					bool *finished)
@@ -2283,7 +2290,7 @@ static struct phy_driver at803x_driver[] = {
 	.read_page		= at803x_read_page,
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
-	.read_status		= at803x_read_status,
+	.read_status		= at8031_read_status,
 	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.43.0


