Return-Path: <linux-kernel+bounces-7936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FE81AF71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122A1B23551
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2971817983;
	Thu, 21 Dec 2023 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYOlgOl1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72D17736;
	Thu, 21 Dec 2023 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-552fba34d69so512136a12.3;
        Wed, 20 Dec 2023 23:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703143763; x=1703748563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8LbFzfRGhyEo7Z2rCSlcZvKPzGkHjgBRwyUpOjEIyo=;
        b=mYOlgOl1+R/AzIrLlQJSUaVRq5kF6uqQaAzDuUaAVwV83oLYSGIhZAXCqUtmHlniGx
         RymLjNF0GZne6Kjg7Fy8H/MtFPYIiMtM1e4ZC3UmodN7LBRAxD2RZ52nj5YdhMtDKSfk
         wSS4eMWGoREXG42ooYQXyPe7VgSvcBNFp1LtMDG4qlq4kzr1sbkvdd8iunes3B+l+N8L
         cPtceum5HKaZf+W7/ysrbSDUA+Ehmc/ZnWxEw7rLtMvFZJe6sDgkkMalR816mqbYNEtZ
         KItqXSMRDA5lcwp/rTLDsrkslCf26PyBBupWskehi0qWesGJJovJOYgEzp6iPmgjuYA6
         5DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143763; x=1703748563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8LbFzfRGhyEo7Z2rCSlcZvKPzGkHjgBRwyUpOjEIyo=;
        b=k0SnozMwARQkCFG4/Gr3SDtHFuk/9rvslwwx8OJVuurPpY0QMvAB2Hg0TJI8oTtwyP
         W2UyWh26Zo8iGgXmRrikkWbdPBhzvpM/hT7+q0Yi/XcIKWsXkXd6C+8FxWxVK7KZ2auO
         PqZSEyHHOH9tj+ozqh7z6gWaxXvZ8C8SHNWV14NUZl8ctV169T7h1XheOS47FQM+leP0
         Ew+GXpMwEdeb9z2qAZFOaUeRCQ+xlp+fxpWtuqowCkpQShEze1yrg8g1+ECkdACctm8P
         sxnUnMPJJ/aPCz+B9zYh0Ltdqbzna5a1L4Roo7EjJtN0ZdNgJ/26QQr/TOpDhgy6dQwl
         btWw==
X-Gm-Message-State: AOJu0YyETpvyJgGeqjqxELKggsvEdHneByk2GCxcONL8SAxVpewAAGhC
	vaAs7F4N9dtlsJqk41Gj+fk=
X-Google-Smtp-Source: AGHT+IEYeYYj+MIyh63kgMuWG38T243oBrSQ8LXQuntoCvMz328oRVA+s9Ukj/S8pnwkH7zInK1lJg==
X-Received: by 2002:a50:cbcc:0:b0:54c:d2:ea39 with SMTP id l12-20020a50cbcc000000b0054c00d2ea39mr11263707edi.18.1703143763176;
        Wed, 20 Dec 2023 23:29:23 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm787819edb.64.2023.12.20.23.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:29:22 -0800 (PST)
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
Subject: [PATCH v3 3/4] net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
Date: Thu, 21 Dec 2023 08:28:50 +0100
Message-Id: <20231221072853.107678-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221072853.107678-1-dima.fedrau@gmail.com>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set 100BT1 and 1000BT1 linkmode advertisement bits to adv_l_mask to
enable detection.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 8e6fd4962c48..81ee2915bfc7 100644
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


