Return-Path: <linux-kernel+bounces-70261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315E85955D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E53228206F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53CE572;
	Sun, 18 Feb 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOIgmlz7"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA017BD7;
	Sun, 18 Feb 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243090; cv=none; b=upSp/MkrM0YcPlqkzRVu+qV4nRWrTbuU6h9m84lTqppE3/pb7reIaaJ5z8WHv6D4YQ0SH7bxzhz0Xu7zcHKEXa0ycolPdo62CILecRX9Sjocp7T6cC1nCdVp4PRwYbbX1ljSXIvNKZ8wc3pYCsLbV2BT6s8BtBmHyaJsz2itXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243090; c=relaxed/simple;
	bh=fVx+88lC405JmaqvU4kHNZU3L2yhs/oiP/GJV8DFJuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nV6egH/drXybPI6xx1ht19w8D3pJy8SdABqsh1wJxo4vhmnXEp66hK4Y9NJhFS9YKID5risXns1+0RNTejSWZwQq1qTmucBrmWcAVVybBTG7cb9V188mKZ4o26sVQaw5E9KFAxsR3OX++oyRYtTAia+gyUAs/aTiAwyC3VHCzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOIgmlz7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso4060151a12.1;
        Sat, 17 Feb 2024 23:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243087; x=1708847887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoozvBpHXRYWFOVYUVcvnJG+XHdV4MDAR4eyxjGBsXQ=;
        b=ZOIgmlz780+cdrrNe7kbvweVDYSp6tUK2ohCUoCghW6X598lOCY1Islo6vuKu0lUwb
         u0/AWfiFTn7EJE2g1kOJ74A5kDVU/WpWPXSKrJ4IWCuBaDFyLN1BJv6EDEt+f4dwKOcK
         tFoJux+/1bJQ9cuo5RGjyvV6IeMlAOqb6J0l5yOf7DZBQo05yXuF5G3QYzp2G6/fhtFz
         wcGI4qvieg854cdQVGJ1TYEcEJFPXp2P/hpstXpeWcG7THV/PoJbBUmkwCa6FSu5vP9Z
         UWG5NTdU7BMDrAZMp4cghj4g50oG2uojYnlHXGFMtCEN2kWfmRokGMriMxg0IYRxfIfq
         pZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243087; x=1708847887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoozvBpHXRYWFOVYUVcvnJG+XHdV4MDAR4eyxjGBsXQ=;
        b=Itfmp7GUXdo/Cz76QSF2wIEmBx2J8mvOfprJQcuYKNDWMPoAY8sDghpLBsj7Ax9D1T
         IYVH9pgRDezujWj9TNAhrqQgO11iVWHqisy0ohTYvxPm/tghlp90+5itMcYsdVQNvdYI
         d1bA+oVyTJk9BWiU/VppMUL+MWgfd/+ZJw+RwxjosNjimq++HRkClajEeZPrta3KqbfZ
         o8qAHP/Ay5ewV1MOFYH5jRcyFzZ9a3U5KJ0A7GVcMpQMEZRfq3DwXxGpQ9GzZoaGjUzB
         tV9A4oXpTWBJAv9QbbpTihS7sBtSXPD+sL40Qm4NkwhsDMll9pw0foAgOjcu8Kc3AKkV
         heeA==
X-Forwarded-Encrypted: i=1; AJvYcCXm0iI2eki/k0VvP+BeYr5eesuEZewL3bYFxtWmZjh1Hz4rluCNobOL8hwa+p1WZM7YwhvRBQ8SmaConX4WKC2Y7s7GhMG1nxu5G7UM0HhQoSMF1XgIBnFe8WRyi23bYAQfhd8Y
X-Gm-Message-State: AOJu0YzApirAVCxMEHfxZoPisnK1DUARascP7M6XSr97dlCC/6C1JLYY
	sq4XKEdFeMUTOP+dH3Ag445gzXDfItvOvkz01D8W1CKNQSghyq+5
X-Google-Smtp-Source: AGHT+IFC+szXzWHSDcsGUuis7Z4UB+aU/EuJR0JOC8IytpPgyl6+trDyieIwKwFyzfY/xl4C7T7jIg==
X-Received: by 2002:a17:907:10cf:b0:a3d:8554:44a0 with SMTP id rv15-20020a17090710cf00b00a3d855444a0mr5790488ejb.57.1708243086527;
        Sat, 17 Feb 2024 23:58:06 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:06 -0800 (PST)
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
Subject: [PATCH v7 net-next 03/14] net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
Date: Sun, 18 Feb 2024 08:57:40 +0100
Message-Id: <20240218075753.18067-4-dima.fedrau@gmail.com>
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

Set 100BT1 and 1000BT1 linkmode advertisement bits to adv_l_mask to
enable detection.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 46c87a903efd..b78b6b32d9f9 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -208,7 +208,8 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
 
 	adv_l_mask = MDIO_AN_T1_ADV_L_FORCE_MS | MDIO_AN_T1_ADV_L_PAUSE_CAP |
 		MDIO_AN_T1_ADV_L_PAUSE_ASYM;
-	adv_m_mask = MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
+	adv_m_mask = MDIO_AN_T1_ADV_M_1000BT1 | MDIO_AN_T1_ADV_M_100BT1 |
+		MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
 
 	switch (phydev->master_slave_set) {
 	case MASTER_SLAVE_CFG_MASTER_FORCE:
-- 
2.39.2


