Return-Path: <linux-kernel+bounces-34188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9C837558
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079561F296D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4F4B5DE;
	Mon, 22 Jan 2024 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+6/MUcC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DA4B5B6;
	Mon, 22 Jan 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958994; cv=none; b=XZ311tgjFZRmGXR/0PX/EB6ZvLEAlHluzD+NAIcVRUSqGfD3ZpD0qdXFrkJefDdj3Hg3qNk3nkVdKVlClVkVc5X5Jjt0W74NWRl2Co5SXPCLiBNxyLUElIfnukyrXoFlas/Q9xHFsFPSASmqSjLNhEIjrxmzxp8+j7L3tWQj1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958994; c=relaxed/simple;
	bh=qF7v9gKuMw9t/7Pbo4CoNbMokg9kWqCVBCpB8sT9+GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SS3W+WEus5VYQN4LpUimuoLVcCTvr0yVHorCMijb+m6e/2BmGV6Btpd+wVw5g8PU2sZ+rmVAwGB2pZKKUGL/cdOeHHRQyHQKFdsf7HtJvjOPvyMsqaoQCZz1iPnm/6ZguXYInFXhu5lzmJx3yOiOoar4IpGEc5t0uPeB1a/EpEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+6/MUcC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so8275110a12.0;
        Mon, 22 Jan 2024 13:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958991; x=1706563791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjsPhbOjgbjTGbv/P6SbmLQoP1cqiWhsDGC0m8CVif4=;
        b=X+6/MUcCrXLTQDceOBkzICv7nFwxHpC5spoi6ayzQgGMzFpzdh6keQ6ZUmV/1hZ7e8
         yTUoPLYUJsBKJqRI7v9CDeFjR0atdfwnBz0ThJQMpS5erdw1AHbo4BYLbJ2Ev0a64oqz
         auxfZ1IlRA3Oi/6lmQTYsYV9OVshGnYhWBwlYnkP9YJykMR5DG0uIzE2vfwO0w+xnR3N
         7OkXJt/K94hoCdtFH++2Oh+ewcI7++mjEbB3GEqAnT91HaqOucFX3asVB7gDw/uDi/B5
         o2W04aXvAHLDc0r7xJeL/rngcbdVXFbetx+CMith8k91KlaMmhyzXxxbbNAQbXNksIXb
         qgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958991; x=1706563791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjsPhbOjgbjTGbv/P6SbmLQoP1cqiWhsDGC0m8CVif4=;
        b=BnfH7m9FhINgqqwvLozh75nleAPcdzXz97QqUMeZV9fCo0NtMAdgqt+Lo9zPxwLrkC
         elCEJzsPFQU6PMzVxRxzeUhG7TFomyYMtO0qyV4DtA9hgjSC+z1mN6gINBm2rf67AAWT
         OH1wLi/xadnd0WwN/QVPW75+rZldg2FQGn6Cewl3C8MeXNq1AdxX00/IV0QJ5jNNi+DU
         7DzqRmUE5zs7oj6+iUbbK8nd8ELfJ5ZUfa/DTBrabiCu3myWDXZxH6Tn+TiL3dkXUQWJ
         k7WwdSufR+fwPVnvBfkNJ8dn2dvDKpwHU5DO6hK0ULF8Mc5fpst8aoaRHnrSnZFyFR+B
         05UA==
X-Gm-Message-State: AOJu0YylpLYkthuP4NDj+ghW2NuSSpzTptn7iGd/35g3s3zT5qv14fbR
	FFarRquXooQQKvBWYpqxN/ipXV2gTVcKajzXy2OLy+c9IwWAyM+T
X-Google-Smtp-Source: AGHT+IHkdwUB8gTgDBXySxeS7a86lKPwKDuFks8PpzWbaBc+PcgWLPe2D5qeDCP06E401CNlIvg7uA==
X-Received: by 2002:a17:906:1551:b0:a23:7633:59ae with SMTP id c17-20020a170906155100b00a23763359aemr4905088ejd.9.1705958990854;
        Mon, 22 Jan 2024 13:29:50 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:50 -0800 (PST)
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
Subject: [PATCH v5 net-next 07/13] net: phy: marvell-88q2xxx: add suspend / resume ops
Date: Mon, 22 Jan 2024 22:28:40 +0100
Message-Id: <20240122212848.3645785-8-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add suspend/resume ops for Marvell 88Q2xxx devices.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 635827b4a692..4cb8fe524795 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -457,6 +457,38 @@ static irqreturn_t mv88q2xxx_handle_interrupt(struct phy_device *phydev)
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
@@ -562,6 +594,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.set_loopback		= genphy_c45_loopback,
 		.get_sqi		= mv88q2xxx_get_sqi,
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
+		.suspend		= mv88q2xxx_suspend,
+		.resume			= mv88q2xxx_resume,
 	},
 };
 
-- 
2.39.2


