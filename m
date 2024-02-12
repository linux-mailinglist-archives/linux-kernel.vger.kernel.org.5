Return-Path: <linux-kernel+bounces-61455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469AB8512A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0DC1C2204A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0939AD8;
	Mon, 12 Feb 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTLBdJQ2"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84439AC5;
	Mon, 12 Feb 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738650; cv=none; b=GkboYvZlip2J9bBuIdIPYqYkoD58BhbP1ohocMF2iqohR58U5cRCxXVZz6Lx69Dioq6QKI1gIbHqEIy8ZqVnG4rRnZbbH+B6C7vfYHD406TdFHJsPjxq5kpBhKyE/gPVY35AQB/YU48qXMyYYZ5C94qg1QTnKYPwVdpHq03V0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738650; c=relaxed/simple;
	bh=/kq5w1POb6DWCXoFZuLee/5Hf4I/xNQaA8461i2aYSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1bg31JkKIFkvKMqkdpc5g4l15MPJFBRTYTB7kHxunr0DhRYKCowTngf6db3UypbupvdKaJqggY0pJOmMcsSuENO0ku6cT2g7DpnYpB61t3YyJCdszHyadZL/XZ0Pb3mkjditRlweJUFytDUrue2PjLZzzaMX+0UCKoCIaW4JSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTLBdJQ2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so3747899a12.3;
        Mon, 12 Feb 2024 03:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707738647; x=1708343447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DI/JPUx6NGwjBeuZnuCsSQdfuZnc/sODY2AjTvUNJeU=;
        b=FTLBdJQ283KTR3DsSkmPReJMxq+6GmAgDKfzHv58ydao6ChRYDucKmH57R5O6Cf06k
         fYWex8vEV+Z01Up50kAa1sPXAB/lPo/N0C6GSDItfSqifeIbGq4Vf7U+sCE0FX2e4lJl
         MZoFoH4U+DA1hhJJWwmqGdsbDKUxrI9FYkwEThX9MQBBVSces5AUDkboQDNL4Ljkst23
         QOeL2szXyTTMW/O6lZgGSA2+yGVMY7XP7rzzQpk4S1ilCKyp7KXagtCVy5Rga16+4hEp
         vDO3QvORc6Km/66mYvobUnezm4VOnUtC4hFEyzu6VdQjubpFWSdYr4Y5bihP9RxdO9XT
         O2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738647; x=1708343447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI/JPUx6NGwjBeuZnuCsSQdfuZnc/sODY2AjTvUNJeU=;
        b=jTQa4tWLjcZoDd0Yz/33y5ONVqPBuIf0v92sRdSjEFYdFU8HaJZf6ODL+E2W9KdDYu
         lcluKooKDN7RYOcLMMtGwJZpvzxx7qxuChWNfIN9w9XLXiWWVNlN6vt1DCjh6wfuhuV1
         XrGJNFcNwQu7MQ1VfFN1bb/wDY48zKG7xMwf/XfCbEufnFFgshbkjthOkCTp+RciUJgJ
         16Cg/XsFDgUmkLrkmVtCjlgQxYjwCD81yTAKcgzDbHktYlKO8+AmHGXAtxLqdMPutiTL
         pJBw23Ua7rNLlp7u/8L+VRF6bBkWiGW+noN14ZIA5L4sjjYsWrmJ9n3iqazqHViS1tJq
         qB5A==
X-Gm-Message-State: AOJu0YxJ8chfxpTBZ6UKU76bh3BTZWi1MT4mjDhtShGrxXK7pIWK0Cfb
	Qi+kvHK11jFshxqBoc2t5To2H0suvGXEIXPB7y+NEH12hvBrIrpoN/20mkq2bpI=
X-Google-Smtp-Source: AGHT+IFcNWXSpVUAtM81ZjcoJhdC3f4B9acvTAZjJbOBfs2ULW0y91rwCOZxrk8rrBNqgASUjBtIxg==
X-Received: by 2002:a17:906:2787:b0:a3c:c451:2115 with SMTP id j7-20020a170906278700b00a3cc4512115mr845655ejc.77.1707738646617;
        Mon, 12 Feb 2024 03:50:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvVnYjwl1kXCkY6Q5HCHxosLviHu0mbZd4UfAyKqv/n4THscQ62fBfKS0esaHexyd7rx/jI8u3C4ruKxWli4Q/3iGG+VrFG6IOMgbY4mNC7CJ4YU1vAf9baLjz74PpeNf7ph4jCRpOvOQhGSxDvv5HUOrQGEC6a57CzVLBjACv6guMqWBVuf2SGTE8KqtJBvSDLYKj0mO3Iozednaii92VE5UZmu7C9TwJh5tGJiaE5NwhylMcoOPqtcH41jRzk96pKfZJJr+uQOwmpOSxlFf4cnBrBXfHlUIzmHgX8enw4w0RDuGX0kkGbV8mBD5aBxRg2wAcwrNwvqNVys5J4KR3jlvydQfwBsGwUJAE/Pj8g3UjuGEe6Vf+ICImwdeN+RvHvE03uecQLUG9IFfP4Js3k0TKvz7SjprkDf5Q1D4=
Received: from fedora.. (cpe-109-60-83-183.zg3.cable.xnet.hr. [109.60.83.183])
        by smtp.googlemail.com with ESMTPSA id n7-20020a170906118700b00a3845a75eb7sm126534eja.189.2024.02.12.03.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:50:46 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next] net: phy: qca807x: move interface mode check to .config_init_once
Date: Mon, 12 Feb 2024 12:49:34 +0100
Message-ID: <20240212115043.1725918-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we are checking whether the PHY package mode matches the
individual PHY interface modes at PHY package probe time, but at that time
we only know the PHY package mode and not the individual PHY interface
modes as of_get_phy_mode() that populates it will only get called once the
netdev to which PHY-s are attached to is being probed and thus this check
will always fail and return -EINVAL.

So, lets move this check to .config_init_once as at that point individual
PHY interface modes should be populated.

Fixes: d1cb613efbd3 ("net: phy: qcom: add support for QCA807x PHY Family")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/qcom/qca807x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 01815f947060..780c28e2e4aa 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -562,6 +562,11 @@ static int qca807x_phy_package_config_init_once(struct phy_device *phydev)
 	struct qca807x_shared_priv *priv = shared->priv;
 	int val, ret;
 
+	/* Make sure PHY follow PHY package mode if enforced */
+	if (priv->package_mode != PHY_INTERFACE_MODE_NA &&
+	    phydev->interface != priv->package_mode)
+		return -EINVAL;
+
 	phy_lock_mdio_bus(phydev);
 
 	/* Set correct PHY package mode */
@@ -718,11 +723,6 @@ static int qca807x_probe(struct phy_device *phydev)
 	shared = phydev->shared;
 	shared_priv = shared->priv;
 
-	/* Make sure PHY follow PHY package mode if enforced */
-	if (shared_priv->package_mode != PHY_INTERFACE_MODE_NA &&
-	    phydev->interface != shared_priv->package_mode)
-		return -EINVAL;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.43.0


