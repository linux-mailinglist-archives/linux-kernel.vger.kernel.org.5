Return-Path: <linux-kernel+bounces-64359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81B853D72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B717B2A4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429B634F2;
	Tue, 13 Feb 2024 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Q9Vabi"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110963405;
	Tue, 13 Feb 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860435; cv=none; b=u6vpkYuf2Sh8qSHlaNETos6n4HDiZs47FyR+FOewikKUA/U8bjG0FKZx3QN+im3d05lHCvzky7YHlWVpg0alXNsM/HxsEZDaJg4jlJxu+hWAV4b0ASwwG+2fbtXgR+Tz6MG9dmgE8opA1R+45LvENygyU5ujMfF30t4fqvi0mtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860435; c=relaxed/simple;
	bh=gF3/8s9rdHbLqFLOpYOvq2ihfs6x9vepRDOvp4fgqQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PApg1x0XdD5n9pE/YI/YaumCMv1+IXibBEEv9Py0BtOUGRUp0j7/jTGhFlreb0GaDYh0miy8M6y8x5LYysiphHVg4B119Hy7ssnpL6OPy9WwEzCfv3OCVor2rp6TmhfSBmuR7yBrkF80HvD+d+v7ycbUKSdGgD2qYWhiHjHxgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Q9Vabi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-562092d8135so1109671a12.3;
        Tue, 13 Feb 2024 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860431; x=1708465231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhBVbpbbNuAZsJD1zsfWWGeNA5wuPbJ+/FGELo9o7pw=;
        b=a7Q9VabitixcH+zk4fDn9LsKDHooTy4AYI6Fh2AQF05wI65gGDz0P78s6mvCmkw3Dk
         YIELNJevD/NxRjDwPLQrXZMpDFwbaIloexm09+XDu+rdJbDC49XX09IKX7rKS0/r3bso
         ob4X3JWV+BAcycXSYkFGMQFXsclGN2b1zzh6MMaS0f6J9XMZGoO0A7esjwVLQrKqluwa
         DkRClwkMI5TXN7i2NCGH6nliFsQI/UwPlziGOPt+RMyHcjg7niy+QXX9By1sYGC8Vnh4
         x2cOus+2aL00uuTB6XeEpi1X2SySff4zy9uLRFZqKvpN9RuYsIchLyNPNzMY3UqYVM4v
         4a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860431; x=1708465231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhBVbpbbNuAZsJD1zsfWWGeNA5wuPbJ+/FGELo9o7pw=;
        b=o1X6buqKvmXLjf6sfMKuovj6HFfxW+DJEo8+K+67QiTG0QQSG3UJTUSMNnEkZwebMX
         R0MIR875eR228JaAa1OQDJzLCV2cKy0i6ir+SxJQbdWhMb/xsmeAcPNki40hooVdmd5z
         juocjrN/KDZCzV+/nPCWtZnNgcwnXADSyj/iAhtgMfiYORxRvJTIZYjyd9bWE1uH9Nss
         be7QdHYaO++vjFnuz95NmPrhuXtRlrHwEVGE1lhIYW9xpcUdrb3jzZjGJ/hwbLlGWTd/
         ZU+Y05LgxdexXF+LF1hIHRoDTXkIRc0E1K7/us7mtRlHsnpY+u1dNbxI71qEOCVi9a6H
         C6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3GIetEPbe6ps5ACpADNcv9obDfMy4/0mzFLCUd73a/RzgqabKetOK0IhkVk1ghY3YiJGThxFQW8UT2sw8wVe1x9oWJR8rp5G97UoeQC1Avip6YO30+pT7qiZVd+CRTHAeiCCY
X-Gm-Message-State: AOJu0Yx/t5v3ozirJy8HBXXWjDqiX6omnwhaziktsGWazasBRd3Cj2Lf
	jsxTWVQohKtaH8uuA+bEVJPaMO0wOsvtZFuxOfXMssLvfHS/rBKR
X-Google-Smtp-Source: AGHT+IEJMc1vyqAvUkZlj04OkDPqcOi6uUp/jUrwB2UCcHIfyOZ7RKXL9TF8KBF2sBefPwkCSpJJMA==
X-Received: by 2002:aa7:d40f:0:b0:561:347f:ec5e with SMTP id z15-20020aa7d40f000000b00561347fec5emr658984edq.32.1707860431349;
        Tue, 13 Feb 2024 13:40:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV14mgLi7UAldNfOM7ldyU+z5AKMxT9vIVRrtCfdDFhRce6x/g8zjelO2mDlObMgoiw2QVv0jLgEDSRUaBnRR3oarP/ik89IPGODjEg9L1HliXXwcIe9Ney9T6Jd7DNVDaVgxpFgntrAOtXUkt9n6vwQdRLA/rgRLywrM1muX3te+s45fBqjyrHJG4I/eJrobXpYbeQFHf2xDr7b4HOrvJ8V35dzkFyFeYcUHn49YjLougZpBjLZN1Lr6iWTwxNYLlP3dyxiCOzTN9cw+h//FemK+uPhR05mSYv4kX1z66ddbmKdtOCBhl4GCZMLs+vmDUDJr7co25b8O1LJz61mHFDkAk=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:31 -0800 (PST)
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
Subject: [PATCH v6 net-next 07/14] net: phy: marvell-88q2xxx: add suspend / resume ops
Date: Tue, 13 Feb 2024 22:39:46 +0100
Message-Id: <20240213213955.178762-8-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
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


