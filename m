Return-Path: <linux-kernel+bounces-70270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D07859570
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE7283A75
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB021353;
	Sun, 18 Feb 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RepRNznH"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F42210F9;
	Sun, 18 Feb 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243117; cv=none; b=rTmhSpYGhNby8egkG9yNkQ5xFgRPg3swHkICOzXB/hd0NAQO7T2J0hMWINYYqhtTk4YET7snvSbb9jhTajpzoiKsYYYiwE4omSH0ejwfC8uEQSPIqCI2KfnRkwPKsgQGmoJrNgNhCpC9COU3+JAHp6FDq7+b4HzVtKf6cTXiWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243117; c=relaxed/simple;
	bh=qtqYlODExvRuMNQTFEJhebFMDpvaefrby/rQ80F2z7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgVkFvPw6Wo07CA8zAdpyZhfAFGQV1RjqejtJinXREhYfScBYbg+yCQCGh0U3tr9o5z57TlIGdzldeZd2EuSERSlt3n8GkUzP1updEBXCnDW3KPLGEn9Pswo9hhSEZ/oEA2bI0HaL7Hood2iIgijxVws1jpERKczEg/LEAzYMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RepRNznH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a293f2280c7so466331666b.1;
        Sat, 17 Feb 2024 23:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243114; x=1708847914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oGxiX3DP59U1b6opp4bM7FWUx7s6k2h0K8Wum1QSsU=;
        b=RepRNznH8QH0PPXsfZaIykU8oeMBZfppq7CM6nq12vy2D+k/s8Eb4/Td86i1E0cKNr
         Bpn50F/DZ2SV6dKzsWIE2cfudzgdNKgC/LArbTewv/cq4Ee/JzDlPU20UXh0e/fKU+aQ
         +QstWgU6g64ppXVD4bKK6ThErErIaxQbwEJtYj7bE1rsETKTdplkprQcali0VHdhPJz9
         byp6AagO6yQmv1mnQMv9amVVwTEF1kLOYknksfcHoZ3RDBSl0U2RKdyQmYxD8XZGLM9f
         AyXme3XsCTpLbWp2tyAOqqTJOu2dWtFhZqkVVhq09VZXf9UOyDmi/+3R34Pq9sRgNmWs
         h3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243114; x=1708847914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oGxiX3DP59U1b6opp4bM7FWUx7s6k2h0K8Wum1QSsU=;
        b=QSEA/LYFvuZMkNq5zs6X7RSHvstu/WgMcuxS12XUz9PZGP+FudpI9iSbcSr25j5wPc
         1QTb/74THiCPky54AtIevKNV5Yc6gZ26R52npewHDx9Bj/yRFdaydQoF4qzTvZqib8NA
         bKSbFsngBiyfIdjg2rEOeQGW1SQASWuF7HjeBk4uG628Ag+tvA+tz7OtE0BvXwcKsuPe
         9/vegJ58yYXYz2fnpMIO0gR2sULtrOTLqnZG3NmWJjAEkdGnC35/xhNH66sX0+e0GUTS
         6BmYEAK83YMv5udUTTQLzLL+Qq/VO8lw+n4uu7MBxmvmKauy3WfmWnqRJ6Y6fzuf5aj/
         cIrg==
X-Forwarded-Encrypted: i=1; AJvYcCXvIuU9Q2uun/7cLHTmQW7dZYrFZ2+0OQ34PPch7VEJQLO8MynmtLrvxnD3T2ONK8vKMEuaezXC+FPNG4ueDmPL1irzo2dmFU58UEPG8XJ+BuYAlatB38DIQlm/lIG4gum4nWey
X-Gm-Message-State: AOJu0YzULhxlOdPzLnTgQByxmsKhUbJvzXJvyTq5o6REg5CaZ3I5wMuM
	cx2CI6Bq+9LV839Y7njAGOjfrAj3fwOZZfafZwrMpGopQlPjX/6S
X-Google-Smtp-Source: AGHT+IFkjTD7qVoCb2nmNqmOovYb/5JoE/O6ewWqQ7UbZB9DeCBYISSiBjBNUrJ0HH76Dp+OUEFC7Q==
X-Received: by 2002:a17:906:1b46:b0:a3e:5589:6099 with SMTP id p6-20020a1709061b4600b00a3e55896099mr992240ejg.70.1708243113775;
        Sat, 17 Feb 2024 23:58:33 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:33 -0800 (PST)
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
Subject: [PATCH v7 net-next 12/14] net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
Date: Sun, 18 Feb 2024 08:57:49 +0100
Message-Id: <20240218075753.18067-13-dima.fedrau@gmail.com>
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

mv88q2xxx_config_init calls genphy_c45_read_pma which is done by
mv88q2xxx_read_status, it calls also mv88q2xxx_config_aneg which is
also called by the PHY state machine. Let the PHY state machine handle
the phydriver ops in their intendend way.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Eichenberger <eichest@gmail.com>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 58aa10d35731..ebcc6b4046fb 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -370,20 +370,13 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 
 static int mv88q2xxx_config_init(struct phy_device *phydev)
 {
-	int ret;
-
 	/* The 88Q2XXX PHYs do have the extended ability register available, but
 	 * register MDIO_PMA_EXTABLE where they should signalize it does not
 	 * work according to specification. Therefore, we force it here.
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
-	/* Read the current PHY configuration */
-	ret = genphy_c45_read_pma(phydev);
-	if (ret)
-		return ret;
-
-	return mv88q2xxx_config_aneg(phydev);
+	return 0;
 }
 
 static int mv88q2xxx_get_sqi(struct phy_device *phydev)
-- 
2.39.2


