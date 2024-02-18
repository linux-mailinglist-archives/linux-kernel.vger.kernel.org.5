Return-Path: <linux-kernel+bounces-70272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEAF859574
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9B28300D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33E225CC;
	Sun, 18 Feb 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+i+JDPK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6922325;
	Sun, 18 Feb 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243123; cv=none; b=fRlKGrV2SvNYNmRdwNuygV2qRTScSPoC7Kfge0x3M3543NpvVZRbKlO0AEKoKW3nQx5JQCc8pu0tEb+VzyKhnpXjmYmqmgIqZPwwixM+isIO0RXcs1Wo/REr0Cg2zcjY/KRfvMaek+qBAdF5OQJWnhEOh6Rk8W4/Kg6VDVDOgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243123; c=relaxed/simple;
	bh=NKH0ZFPcCFBnqG7yf+u2px5oQxf4WU5hZN0TqksNx/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWGZhbvsBAChB0ZfLfHMOKqe0C6C6gSJkXPdfQCqhVKqLPeyJl8HhyoHs3vXnqQW299jrNTs+96l7/mVoFqVmeI0n7tmQIP4Y0bpP5EpCMBrIIzXjmqDZkfwOsgjtz9i0UTH137w0BxU8FaLB6m/mjDDUJo0TEsVwnSInsFTO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+i+JDPK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d6d160529so244420866b.0;
        Sat, 17 Feb 2024 23:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243120; x=1708847920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raGAwOephnSsA9G7MZk1sb2g9wF+qqd4XeQDzxVbWtw=;
        b=L+i+JDPKG/DQj45ZwmH5Q/C3I8fgxbAy/4qOdRzxSyWLkTInaimwvf5Zg2bdYYOXCk
         4oEAD1APjCSW29NPgdH6e29q64rp6WpWQoQvtGWxgG6qC9yrpcH176eaBDqHL3IcTdjL
         UvNiByP76KnsJTCQWr+/klCAYtnRYhZXrBec/Dn+Mn4tudUz8EW1dUxffAq5rQTaNBdb
         anwd7JmEw95Jpq+wnI4J1wVD39Lg1LXtagiinetZ2QKrEjesz8fhn3KpMD0mqDbYXdZt
         aYu/BjoGpAChM3CzYokP5syQg/4hpUa9tneWPw3+U+2KyoCKF5HVLdIEkNSFauBMM0rG
         9sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243120; x=1708847920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raGAwOephnSsA9G7MZk1sb2g9wF+qqd4XeQDzxVbWtw=;
        b=WuRBuS0CNCH6Uolg4EcbLe6tIJj9UJCU9saHogukchKFEw3QlCXJO9jycTS73bKSyH
         d3Y/dD/cq3xnjP+vFGB1Px8y3OmYCadD7+ZZfvPLvOIL1X6m0GnFRKZpFwV+yun9P3DP
         UsxLC78L74e003ymC4K/D6PZi0gA2Bo4NU9ihEg7NnABRQqRgx0T/zoXxfaeSjtbevJe
         F0tBdzNo5BEYkaYpSI/Z49TCWoqwTVJ4y10uRM+rM/cYTT9+8M5t/fdeqfEzilONc3ep
         QeFZLC5pwXjbpGz3TrYK0r/pa0AB1323EjgnfUtCnDE2bcY+IdK5RENfC/cCBN7f/FYN
         KxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0CZuJImXgh2p51yRL46m3NUW/w1vRMsjpJPzV9XprnYPYz/lZ/5lcarw+mI8wYF/x2hZBa/Txu+ILI5vw/0HPQo62FQqVjV/hVSYuiz0SI4QI1ZVS8to6Z9JyXRGGkSts9CrD
X-Gm-Message-State: AOJu0Yz4Nyu2o0BWktZyOD6K8VoxI8Q1OiyveHkNf/YplKYK96hiRxSk
	DnSfk9drs9oZ9gypbpTUHd3FUDhJ8J5IeMh6VXDAXbkP4tSoJ9IJ
X-Google-Smtp-Source: AGHT+IHEDPtHdS3hJq+jdRNZaHpln8fDc6cfXgK7v1fk7Ak49LJFyjTCVPjb0c+zNEtTZ60qnVPivA==
X-Received: by 2002:a17:906:1854:b0:a3e:73c8:d383 with SMTP id w20-20020a170906185400b00a3e73c8d383mr473319eje.49.1708243119850;
        Sat, 17 Feb 2024 23:58:39 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:39 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 14/14] net: phy: marvell-88q2xxx: move interrupt configuration
Date: Sun, 18 Feb 2024 08:57:51 +0100
Message-Id: <20240218075753.18067-15-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move interrupt configuration from mv88q222x_revb0_config_init to
mv88q2xxx_config_init. Same register and bits are used for the 88q2xxx
devices.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 75740f378c66..6b4bd9883304 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -376,6 +376,14 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev))
+		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+
 	return 0;
 }
 
@@ -701,14 +709,6 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* Configure interrupt with default settings, output is driven low for
-	 * active interrupt and high for inactive.
-	 */
-	if (phy_interrupt_is_valid(phydev))
-		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
-
 	return mv88q2xxx_config_init(phydev);
 }
 
-- 
2.39.2


