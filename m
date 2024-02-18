Return-Path: <linux-kernel+bounces-70271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E358859572
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DB11C21395
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B122318;
	Sun, 18 Feb 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpAikeCL"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034F219FC;
	Sun, 18 Feb 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243120; cv=none; b=L/86m8m6PY0qR62T3kuXh1kyFg45ZcXBaU8nb2PcsKNJ/um4Jeh0I4BQNk+2wNsKN5aQj1saa1M0Wxn1hlq/8PqS77A+sgYgezRlwYYTGm8BBffdGyKj+ujyAoz/AzVAh70Hk9VzGLmCYmmhTfERmvDkpVemIaeZP//eOnR9UjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243120; c=relaxed/simple;
	bh=3U9U1nadvLg0Rjm7LYRaj0MxfV50Z5qtzpMXJXowUBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UunkRVNjrhfblQn+YawNQ893vjQLqBgZs8HFgffaT6eOqW2X0q2Dun0EMQP/uF1ac1ClMiiyH5G7WwSezjHa/3XpYkauK3D7Ox/321GU05BIYGPTXytmKlwDDeQBnQVRHgQ44zlNdgBapIcexgm9Po6tpYuP2muJCUmrkBapC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpAikeCL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d204e102a9so42396531fa.0;
        Sat, 17 Feb 2024 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243117; x=1708847917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6lP6DHwHLvm2vn7jETR5fRUC+QbfoDMTGIxPcHU+Ek=;
        b=EpAikeCLUyuO+aqY9QQj9JlYj+BeeBZiwMFiIwItY+/dDZ5y6FB8b8LOvGfJRD1wEF
         3C+O2GctgiHyZrL2nT1LQWS/X1HN5iF9Enuru1TW9gDKi4dosv/LMNCRXmM2ORzVQ7vk
         fGncGDnpBZM93+yJj5YHuvjn3UAiMrLWPCKOamc3hdxg/WOpJf/Yq1Dkhm50WkfHBoSR
         UuXLjBzh9nf6xhSnR24cjrq5Px0FN8ypXvq5Emv65vk/po1nFLooAf41Xeq5F5ysqT8V
         f0y67PF72KZe7m9QTqa2yPIEwQtrqNPF3cgJUrD+cXpxeYDhD4fZUXU/DQ4BFxJ3OhcD
         MHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243117; x=1708847917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6lP6DHwHLvm2vn7jETR5fRUC+QbfoDMTGIxPcHU+Ek=;
        b=MDZBDtIJ6zioRWgVhbAnES/GVkorQxnX8A2nmfoirTcbvA1QAHmH5+IzKtx4tNN9VI
         XGVkQJ6TdSUJQSYRbgwMZte1L21zYduHbyW9N4zg4WtsRkW3tKCkJyu7ehcQzMzonzMP
         NLWcFxx3uPX4cgPun7oBeX4iNwBkULCgmkcgaPpOLRAOP6Z+cBuGhP+AtOMSYH/YLs+y
         9yzA3VDLwvCvFEsxnr8yvevjXkPLYzamI5qSUXIv0K75VHGq4EysVqpWxqkCv/hmVOPS
         welpODFBSSPhKgSk51ZTbRmv33N53/0LQS6kYoYexkCTOE35CHJt263SnfkHlWhxgjOm
         Fjrw==
X-Forwarded-Encrypted: i=1; AJvYcCW05kpRnLzeAYWGkcGvVgq+8MbW3Xid7AsLHWyoKfF+7tDhu42i/FjGgTniJLnjnp5z/iwdjvTqhqCj8TiQdB2mhQAGsUM8QkbFzuJG6Um5GShVaX8m9WUP6gyIJ+ZZ4LmEZGTh
X-Gm-Message-State: AOJu0YyMPy8gGTLWWJV2v+QVbQ2U2m1ki0Rwib0FE8wh0T/9stlzU8AP
	txkr9ThuKb5faff4u19BWjrfcCG3Vot2IIIQqSq63g7mr0F8gZWbV3jK9G9Z
X-Google-Smtp-Source: AGHT+IFq43Up4WtdV4MGcvql2QzQRx7rryiB6CQSRv2Gaaw2YQM/tyjcvaRLAEOdd7NXQegMHGVe/w==
X-Received: by 2002:a05:6512:714:b0:512:9cbf:acf8 with SMTP id b20-20020a056512071400b005129cbfacf8mr2424995lfs.4.1708243116751;
        Sat, 17 Feb 2024 23:58:36 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:36 -0800 (PST)
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
Subject: [PATCH v7 net-next 13/14] net: phy: marvell-88q2xxx: remove duplicated assignment of pma_extable
Date: Sun, 18 Feb 2024 08:57:50 +0100
Message-Id: <20240218075753.18067-14-dima.fedrau@gmail.com>
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

Remove assignment of phydev->pma_extable in mv88q222x_revb0_config_init.
It is already done in mv88q2xxx_config_init, just call
mv88q2xxx_config_init.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index ebcc6b4046fb..75740f378c66 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -701,12 +701,6 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* The 88Q2XXX PHYs do have the extended ability register available, but
-	 * register MDIO_PMA_EXTABLE where they should signalize it does not
-	 * work according to specification. Therefore, we force it here.
-	 */
-	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
-
 	/* Configure interrupt with default settings, output is driven low for
 	 * active interrupt and high for inactive.
 	 */
@@ -715,7 +709,7 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
 					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
 
-	return 0;
+	return mv88q2xxx_config_init(phydev);
 }
 
 static int mv88q222x_cable_test_start(struct phy_device *phydev)
-- 
2.39.2


