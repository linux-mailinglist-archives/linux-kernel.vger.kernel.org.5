Return-Path: <linux-kernel+bounces-70265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A3C859565
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29491282835
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEDB1EB3B;
	Sun, 18 Feb 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF+J06eR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E829F9F0;
	Sun, 18 Feb 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243102; cv=none; b=TfzoCs8D1HxfXDt5iQtL7dp8+sInSUXtgwIsXx0qZE0+tz58rD8gLu71prO1C2B24uaxjKsoVezFhmV6zkMyyjLsXnX3NCbSoq9zPy7FA240QWO2rnx4VFpO4QE5lIojA9udpY7nmqGFQJFczaCSWWm9T5lUpcER/GD6TA2UXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243102; c=relaxed/simple;
	bh=gF3/8s9rdHbLqFLOpYOvq2ihfs6x9vepRDOvp4fgqQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWxrtK8q0NUtqSQp4jkQxUgPJw5JfbU76qnt4L8yiX+KnQ+IgTWvWWKQEP490/mAy70nkQy6cNWR6v9wyUmGS9rc0g7g/+v4ZRwrqNkNdAVN1T4YXw3KrKiacPhFmryhwq3ub6h+F3hjvGN8wTSRkGvK35ZACwNxl+pQ6hdnhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF+J06eR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e706f50beso21174466b.0;
        Sat, 17 Feb 2024 23:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243098; x=1708847898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhBVbpbbNuAZsJD1zsfWWGeNA5wuPbJ+/FGELo9o7pw=;
        b=UF+J06eRuTKEybgI3F7Q6T0axVSufvnzJRa66G4WNugpSHoo+6tT8FAKniDhsMC7Jr
         MnS3MqrtkAoEmAeCXKFccW7sxSnkbjB6hLWZUTO8B5KqX1qbkI3Hy1kQ32YGIxjIYXow
         Xmynojjjrbh4hBJGjWshUZ+px7aFlhhKxFMcEFi4pzgvSAXHcGydT4tWZqPujYzAkzr5
         ScSbpZ86yNPuI4z3Dm6wKjP3ykMbL9+X2jX3ld0Oo+awtWb2N3OqyPWaYFDHFgCCSakJ
         svOHM2FE04aZSjq+EAIB75MXtg4Gw1qTbglQbTg3kZnNiPeOUO8oJsAXN3GS33kCEGZj
         LMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243098; x=1708847898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhBVbpbbNuAZsJD1zsfWWGeNA5wuPbJ+/FGELo9o7pw=;
        b=ag5tKA7+i0fl2PMkWs9knMwKGPn1HTCRvjc8qB9V0nKobo+Ioxb/wi3AZllTZ3dP99
         HWgXoMI9R/61Ll+6Cy9aihs1cdoF5av9WrTS3Lwe3BO5nRZrXEyJhvqApsYAZ2uH94tp
         VuT7Op1A6knBWjECxhNVxGic7/bTt/Kby3pxLsKrCo2d32ecY/PC6zy3ObstQJmbo6RW
         izEU97JOHTH0qRt2ztPh/k7H2g2dm0/tENhF+g6ZEG4D95dgqBiHC1kfc7e7IEawfRv8
         ye0pWvbcaTRm++xMNjuO/jo5rCdO238gMORtbCa+huYc/cHUkORijj0FPBVhptaHHp/U
         zPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLqwBM/UzSinJbgB6nntMu45wsHX8tFks/DjiuP22XMdjO66+eiIBvP/leCXviaJrTMZIy0GyhjSbPpgid9SRwANxWVAgwfJ+UkFRxqGWzpzea2+OReGsEYw9cs8uLOkdzcPJX
X-Gm-Message-State: AOJu0Yw3OVlFyu8dGAQgCmWQe2EgEhfn/vEyE7qVGV8QhgDAesGD6Byy
	iTWne7nqnKoyBbGct70y+UhNsf5yktTNdV1w1fNoIhRzw04g21+A
X-Google-Smtp-Source: AGHT+IG3FzcKr25nULijxUuqWGKsk13wSncNCW4A+KbfHbPk6ScXYFTqGgsHTrQrUHFjXkamhq4aLQ==
X-Received: by 2002:a17:906:3786:b0:a3e:3bc2:bdf with SMTP id n6-20020a170906378600b00a3e3bc20bdfmr1391538ejc.60.1708243098705;
        Sat, 17 Feb 2024 23:58:18 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:18 -0800 (PST)
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
Subject: [PATCH v7 net-next 07/14] net: phy: marvell-88q2xxx: add suspend / resume ops
Date: Sun, 18 Feb 2024 08:57:44 +0100
Message-Id: <20240218075753.18067-8-dima.fedrau@gmail.com>
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

Add suspend/resume ops for Marvell 88Q2xxx devices.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 7c7517af346b..8b8275552014 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -461,6 +461,38 @@ static irqreturn_t mv88q2xxx_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int mv88q2xxx_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Disable PHY interrupts */
+	if (phy_interrupt_is_valid(phydev)) {
+		phydev->interrupts = PHY_INTERRUPT_DISABLED;
+		ret = mv88q2xxx_config_intr(phydev);
+		if (ret)
+			return ret;
+	}
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+				MDIO_CTRL1_LPOWER);
+}
+
+static int mv88q2xxx_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Enable PHY interrupts */
+	if (phy_interrupt_is_valid(phydev)) {
+		phydev->interrupts = PHY_INTERRUPT_ENABLED;
+		ret = mv88q2xxx_config_intr(phydev);
+		if (ret)
+			return ret;
+	}
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+				  MDIO_CTRL1_LPOWER);
+}
+
 static int mv88q222x_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -566,6 +598,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.set_loopback		= genphy_c45_loopback,
 		.get_sqi		= mv88q2xxx_get_sqi,
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
+		.suspend		= mv88q2xxx_suspend,
+		.resume			= mv88q2xxx_resume,
 	},
 };
 
-- 
2.39.2


