Return-Path: <linux-kernel+bounces-159321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306B8B2D18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE71D284AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6453157A6B;
	Thu, 25 Apr 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJLC5U/l"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70D156658;
	Thu, 25 Apr 2024 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084066; cv=none; b=tCxFhCrPte2DAfmo/E6fqEMnbiPdyPbyygfQjrAse4d6Zv/PwZ4u7SNJTzgO6ONghfp4Yub/77rWyN7NkjxBb6hnNgkR6rUTHTaekZJvtPy0V1E/kjJW6nhlWnWiAkBHgBkPgB+L+mY3b1Y9n9C1H8ZsQF5/Le0KHhx6QFmM9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084066; c=relaxed/simple;
	bh=gK3IDBMN0QPgUq6nFSZArygjbcNekpXpG97aut6lPG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o324jLOl8NfEhAU30+zgnpwTBOp+S1s3jLIKFdNv/6WNJL8nvZyqRRvKX9xo5ywQSAHTB0JtJIeEYpJA4dKHVkzYAAzMMmMtgSObVdd89eyspnNayL8nxq/EkH+ir17tcrg+X0EirotQWyKeSeUkFOgv8Uk/NL3k7L/2Sted9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJLC5U/l; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1558497276.1;
        Thu, 25 Apr 2024 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714084064; x=1714688864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoVri07CqNZY64mEc3hs+qcgGhmd3HVXaDxx+6B0MGI=;
        b=eJLC5U/lf0YGxLdQbtqMS9oRumMIJr3EphcQOhIMiE9IkmZzk3I4LoJ1/ZdaHORPQs
         n23/4SwGxoCauRJgbsCfeXw8lFMB8vbViNEopcXQIVieTgLlEClr48BMwuvn792Os5LI
         2k00n4l3TKcyj4VQcztFgSlgVdslVfYEkLkKqsSNb/Ghqw/kGE97Wm5zTyPdeVEoL1bm
         +0/I+YCXzrAp17Hs4DnQt8wLXtl1qv9aDzB+/UkcAfub+w3KNWHXxAgU3Yx8LjdAeDMg
         hu8daBjhFh+6HqNhm3GZPXz4C4V/aVXhsNa8ZvMkt6lghflfbMms7gb5fL6vrXzZuME8
         6MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084064; x=1714688864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoVri07CqNZY64mEc3hs+qcgGhmd3HVXaDxx+6B0MGI=;
        b=v4R6eTapbOfrxXBaA7QIbk95SZKTmBVHpL+a0KOwQb68zmgC7sOk1NZZEXq3Wqss2B
         WayBmGqpC7GGaUhSL+iRSXJYQoslERicmz6HAIoGUJHKIhdiatM56Wr36piELiMTqFEH
         qBrmKRnTKpTIcjpgwOi0JkvbxQ3IClgdw0+NwjsRhnq6Aovd8W4fzBNF9XLRfaz3HZBn
         R92NA8PqRjGjkfa8YYjg6S53G9ODml6CZ59EF3MXmpyD2LvDrawK/1G6CoXIHXp5JUAR
         2BtXd+EcZQRnql18elJtA1ldMCkl0M+VR04XSEE2EDZUd0KrNuMktwKpMYe8B69MKyZH
         wU3A==
X-Forwarded-Encrypted: i=1; AJvYcCW2VKLpxgsU1q/4ANM5AZ//XGWfowJznl6Qw0tNP1TnP5LURZGn/IoOr3xMBp1IegdzyaP5Oy+ny/tD+2HgblhibVNqYE5UgtjHWLTQXltHTM72oB52y04G+ya/noRUack8JdZrdLU70RboSPuwW5skFWjfz+PDhuPbcA8h
X-Gm-Message-State: AOJu0YyNIGgKn6Nmnmfr1ZKAmnTyMa/dfXulkCazyp8DVL9ytSE+hukm
	1G30cCNgXJl85jSkB0fb6aalTVGFzfF/How5EDfIq7TYKJie0vuh
X-Google-Smtp-Source: AGHT+IESMuDGkoaNG9vzCw/0iUCruRbWVeEiVuftls4E/HAtJJKvtxtx6D4CCeuAZFkVQJhKei1H3Q==
X-Received: by 2002:a25:accd:0:b0:dc6:bcb3:5d8e with SMTP id x13-20020a25accd000000b00dc6bcb35d8emr1198547ybd.20.1714084063710;
        Thu, 25 Apr 2024 15:27:43 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t4-20020a05622a180400b004371724f711sm7341928qtc.80.2024.04.25.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:27:43 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/3] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
Date: Thu, 25 Apr 2024 15:27:20 -0700
Message-Id: <20240425222721.2148899-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425222721.2148899-1-opendmb@gmail.com>
References: <20240425222721.2148899-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ndo_set_rx_mode function is synchronized with the
netif_addr_lock spinlock and BHs disabled. Since this
function is also invoked directly from the driver the
same synchronization should be applied.

Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1f84b37032a..5452b7dc6e6a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) controller driver
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet: " fmt
@@ -3334,7 +3334,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
-- 
2.34.1


