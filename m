Return-Path: <linux-kernel+bounces-78957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE36861B52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6D71C254A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A011448F3;
	Fri, 23 Feb 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="RpbAmOyl"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501F141987;
	Fri, 23 Feb 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712115; cv=pass; b=ELH3YXjLbI84b9xJtr2UJWjwfK4JaenrU8zXUrQ+JjPNDhnn8JrVhaNksSfMCzC8cn/fH01TOYgnD46oayVapWtj8QyBKylcBBKj+g1SAYedIq/Tz+YJSldPQWbLJsOQERRbU4Pw8Ta/cpdiOEP8vz2EyRjd6+Jha1IMW4O4ueo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712115; c=relaxed/simple;
	bh=vW6K6F1wIHMJu+ei/OKI8GNIPUdGz3I6yFBJFhPrs9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sV327S/kqXYA3tjvaU2oDi/J34kymp4u2qq8cEXKcOeuVw8aIFaK8sBWJMGEm+3wnQJx/pIXLUse3H86QhmAigvnLqEPIy7eIHI5vuyG8FGMOQLdHNxftcYT0MSaMppecIP0O1I2gFt+u9URf9RKE3mRA3LYKXrrfAmtIZl6fbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=RpbAmOyl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ThJ8910mTzyyn;
	Fri, 23 Feb 2024 20:15:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708712105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa5OLBki+wJAUWQKXeTEXqd/31Z9fCA2pAdQTW32zog=;
	b=RpbAmOyllID+SUyTYoco8Irls8g2fHMWE8jkVCbUeqaYX5wx7hSje9ubBGLxkVA371EIE6
	acYpWWGtHHAdTBpWQQeMw2b/ZeDhWHUAhFSqsFFGuytB65bYd+cF+YEvXQtYFY05jW0Z2u
	dbFdvvp68Mps7fPF9PibulJfY5Wt4iQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708712105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa5OLBki+wJAUWQKXeTEXqd/31Z9fCA2pAdQTW32zog=;
	b=EhkKf2Wh74gtkvmuzMJg+l3mgx/ZQ2cETOGrZcnN0uWIjQAU/csUOMYgga4Ki2C6JL4FDk
	Bg4qmW7wmnOSO07mJCsjPkzsO7w6ee7tQaPJBco2ufZMjE7ZyKO3FEXWO1WG9Ga1sa2O9m
	1r+/12Ako1j8PWjhox6nUui7MRIYdRc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708712105; a=rsa-sha256; cv=none;
	b=S6OuJ8hhRP2YFox1Qu3d1y0fXql9o5qo0pywxX8GVOnf0n1dNYH+vostpDzlF4I2v5vXI+
	GsBbAZSGP8vjmE4MdOP7j+v5JSu7PytgiBR9hfHp62eFqw57IpaLcM3fSm0i5Q2qKgZgYk
	sKNLCK+4sRmzVfQtTNYYR3zGwdlsj8o=
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/5] MMC: OMAP: fix deferred probe
Date: Fri, 23 Feb 2024 20:14:38 +0200
Message-Id: <20240223181439.1099750-5-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
References: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a deferred probe, GPIO descriptor lookup will fail with EBUSY. Fix by
using managed descriptors.

Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index aa40e1a9dc29..50408771ae01 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1259,18 +1259,18 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	slot->pdata = &host->pdata->slots[id];
 
 	/* Check for some optional GPIO controls */
-	slot->vsd = gpiod_get_index_optional(host->dev, "vsd",
-					     id, GPIOD_OUT_LOW);
+	slot->vsd = devm_gpiod_get_index_optional(host->dev, "vsd",
+						  id, GPIOD_OUT_LOW);
 	if (IS_ERR(slot->vsd))
 		return dev_err_probe(host->dev, PTR_ERR(slot->vsd),
 				     "error looking up VSD GPIO\n");
-	slot->vio = gpiod_get_index_optional(host->dev, "vio",
-					     id, GPIOD_OUT_LOW);
+	slot->vio = devm_gpiod_get_index_optional(host->dev, "vio",
+						  id, GPIOD_OUT_LOW);
 	if (IS_ERR(slot->vio))
 		return dev_err_probe(host->dev, PTR_ERR(slot->vio),
 				     "error looking up VIO GPIO\n");
-	slot->cover = gpiod_get_index_optional(host->dev, "cover",
-						id, GPIOD_IN);
+	slot->cover = devm_gpiod_get_index_optional(host->dev, "cover",
+						    id, GPIOD_IN);
 	if (IS_ERR(slot->cover))
 		return dev_err_probe(host->dev, PTR_ERR(slot->cover),
 				     "error looking up cover switch GPIO\n");
@@ -1402,8 +1402,8 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	platform_set_drvdata(pdev, host);
 
-	host->slot_switch = gpiod_get_optional(host->dev, "switch",
-					       GPIOD_OUT_LOW);
+	host->slot_switch = devm_gpiod_get_optional(host->dev, "switch",
+						    GPIOD_OUT_LOW);
 	if (IS_ERR(host->slot_switch))
 		return dev_err_probe(host->dev, PTR_ERR(host->slot_switch),
 				     "error looking up slot switch GPIO\n");
-- 
2.39.2


