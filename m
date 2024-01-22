Return-Path: <linux-kernel+bounces-34192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0EA837562
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47401F2A487
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40BB4CE10;
	Mon, 22 Jan 2024 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYf7qlfG"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF24CB4C;
	Mon, 22 Jan 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959006; cv=none; b=HO3idUmmxpvUCdSQEGkrhyapnvG+befkdgWAVk6ZH1cfBd4jaw2JcrWml6/pnkSVZENzHUQWWfoXK5Um4TA0YFKKva0xOvGF6K9tvGgszbOizzUewcHpETZyOMAvj26e7/M/nvyyGNuCBBiOLARbWYj+PB5QuoGazSZcK7HSJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959006; c=relaxed/simple;
	bh=rYEk5PXX3bm174ZejWqLRN/iYkeUI/hJjTiG7hIUGEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7MQJuKq2KIoB91KilSbxnzw452v+qFWgg+H8HEokZ65VH/QzLyYpZ5PJvAYRjN83l8O5NSn71aPVOhmBSVUjFAL4xdUKirHU8jS/GI5nLx1OgkSlXkK98gmQmmo6BqrI+miTYVQ4W4iUjFeBOPPttWwYqwfGvo/3uO6OxlBKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYf7qlfG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a271a28aeb4so392435266b.2;
        Mon, 22 Jan 2024 13:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705959003; x=1706563803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYmMCIQOGGjhf869AevyULb0R6NuG+Zi7GyczzrAbQk=;
        b=HYf7qlfGjdJ0Y1FlGmd1xblv/ymZ6SbmR4lRdqd8Vuuy/0Uwlwk0S9NwOl0cPTee9B
         O3Tqe6H32iefdnY2pG4mcRQEZSW4HV/xxneQoZZK9OH61JBWHt/gUJMnW3hDx4GkghVo
         2KxBVqp/CMiRNR0DNC/uM3EzCYBFC2vymvMV/GqkqfI9/tlHuCbT9cTY2J84rH5FFUqe
         U13QBNBXI4chyQTrgUUlb8gy4Gzx1SL81sHKta89uoke5uiIT0uAJxVfIWeL9H8ySPx8
         g0N/bxM60wG+x3jBtR6Miwopeu7WHCw3KgHYh2SYOS05IqBM7evY5c8MVa7B8FXG532n
         obeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959003; x=1706563803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYmMCIQOGGjhf869AevyULb0R6NuG+Zi7GyczzrAbQk=;
        b=tyhy2Jy5cnvxOSlcZ0m6Ed5s5Q/TGgrnqNSXyEyAgcWUdi6gGAsSfaW8+3SkBHbBnj
         bsShoGPz8YQYEQmK0WkBxS4bOd0R/4LvaZMIFvhjI1rWMYmnGmbc7LDxp1Hd6vj4zrV/
         IGWNWsu7aRXLhZEi9YOQ8V9Q88E9XAsbJ8QKBNbHFpEqHObrw2T+bDp95TP+Q3b31wTH
         oTBoGovFvct4eY9QJ6X0Mp8AUsnMgpnizTMnK8b8KrBcBN262qaHd5VWs06Il6yXJ2fL
         TIFDlacKAemloCx6KmwHvfpD3NQNeURUZBX4PyTShmnfV3BQppwiTAL5UE1l6qlBdm/5
         WiFQ==
X-Gm-Message-State: AOJu0YwW1aWmPrW5wKsfRxRlPjseb3TvYL9Tr/dOGAEE+voj3fbOri/R
	WRmDMgWIWZs8qhw1bKv/NaXpK7YoarIWFvZMtdspgeDyCtkbG4pH
X-Google-Smtp-Source: AGHT+IEh8gY7ulZMKN26Nwjj+prGzUAWT6kGkArUfnqY72/QfGKsDBYIapIyofawlDvD0UmtN8E1/A==
X-Received: by 2002:a17:906:da8e:b0:a2e:7b28:1f03 with SMTP id xh14-20020a170906da8e00b00a2e7b281f03mr2857729ejb.90.1705959003013;
        Mon, 22 Jan 2024 13:30:03 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:30:02 -0800 (PST)
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
Subject: [PATCH v5 net-next 11/13] net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
Date: Mon, 22 Jan 2024 22:28:44 +0100
Message-Id: <20240122212848.3645785-12-dima.fedrau@gmail.com>
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

Switch to mv88q2xxx_config_aneg for Marvell 88Q2220 devices and remove
the mv88q222x_config_aneg function which is basically a copy of the
mv88q2xxx_config_aneg function.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 8bd68b3c3ea1..e40ea351fcde 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -688,17 +688,6 @@ static int mv88q222x_soft_reset(struct phy_device *phydev)
 	return 0;
 }
 
-static int mv88q222x_config_aneg(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_c45_config_aneg(phydev);
-	if (ret)
-		return ret;
-
-	return mv88q222x_soft_reset(phydev);
-}
-
 static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 {
 	int ret, i;
@@ -833,7 +822,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
-		.config_aneg		= mv88q222x_config_aneg,
+		.config_aneg		= mv88q2xxx_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
 		.config_init		= mv88q222x_revb0_config_init,
 		.read_status		= mv88q2xxx_read_status,
-- 
2.39.2


