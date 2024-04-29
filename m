Return-Path: <linux-kernel+bounces-162490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA78B5BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EA51C218F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E7781737;
	Mon, 29 Apr 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="R/pc/Wc+"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044C7EF1C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402259; cv=none; b=W2vQuuUgYmv1IwuDTXczFpWDBXCfnYl9U4V3MR6sWNKgLooCZCvFYFLu16R0/9GNAju+LqIVGYZWShQhAsQFEqOnAydh6eaNEHk50rndvZO1PuqlAS1+EHek8/tWo3QSQ0yC1+7jtw+axlspVvC71ppafmZGDWt/FXfgcVywN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402259; c=relaxed/simple;
	bh=ta4hw3RJe3RLJyhrYAahLj+IfUyV8pprABjjd5hupD0=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=GABZahlPAEaa3vmEKbZtTUovMqD6IkAAg/Pcgc3JzUgT6CkvF587c2sbp3Ktw+rsX00MA4Wb2blT7H9+ag1p1/96cb+o8fcS0Ykw5iQRzFa6qHxvmh+Vx/jI0f1GWeeEHHc3XC/cEtVZV/v2Z8g6qyeHhc49xzVZJtV3RdTroNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=R/pc/Wc+; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401927; bh=ta4hw3RJe3RLJyhrYAahLj+IfUyV8pprABjjd5hupD0=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=R/pc/Wc+3xgD24HE1IGkzNHeLQarLD6Dsr3hEkxHFYqDW0dM7fd29VYL3Xk0IfEVq
	 u8XdiNBTA9LNRyymrwKSZyRqlGMGKcbARbrTK3kv7tda+NKtoixGcVBQ8IFIbq5+Ev
	 nmuyOBTf0RtDfIvmbj3tIC7YyCRPrUOmeUu9HIyGhP0U0W4sFyKGyNiz13VGTg/54H
	 O23z1nsQ6zTkGuTTA4wJmJbwTVjMk0tkFu1fjNOf/bxuHSdR8v0hhWy1AgAbhQc/Fo
	 DH32ieTI2bMg20Fsv7oUyMDx323yUmA/ehB11iBhIwjjtOOhr92k7NKcYqFhioVXYB
	 wv2jIrtEb36Mg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMq5ftlz8k;
	Mon, 29 Apr 2024 16:45:27 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:27 +0200
Message-Id: <2680c3b712b36a3ddc279b7efcd87dbf2f24ccaf.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 01/12] regulator/core: _regulator_get: simplify error
 returns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc:	linux-kernel@vger.kernel.org

Remove unnecessary stores to `regulator`.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dabac9772741..62dd3ac19e6d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2222,15 +2222,13 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	}
 
 	if (rdev->exclusive) {
-		regulator = ERR_PTR(-EPERM);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EPERM);
 	}
 
 	if (get_type == EXCLUSIVE_GET && rdev->open_count) {
-		regulator = ERR_PTR(-EBUSY);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EBUSY);
 	}
 
 	mutex_lock(&regulator_list_mutex);
@@ -2238,32 +2236,28 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	mutex_unlock(&regulator_list_mutex);
 
 	if (ret != 0) {
-		regulator = ERR_PTR(-EPROBE_DEFER);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	ret = regulator_resolve_supply(rdev);
 	if (ret < 0) {
-		regulator = ERR_PTR(ret);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(ret);
 	}
 
 	if (!try_module_get(rdev->owner)) {
-		regulator = ERR_PTR(-EPROBE_DEFER);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	regulator_lock(rdev);
 	regulator = create_regulator(rdev, dev, id);
 	regulator_unlock(rdev);
 	if (regulator == NULL) {
-		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	rdev->open_count++;
-- 
2.39.2


