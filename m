Return-Path: <linux-kernel+bounces-15403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACD822B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD92B1C228F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781F18C32;
	Wed,  3 Jan 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q88nAwV3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B218E00
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4ba539f6cso16700565ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704278823; x=1704883623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcomVPZKfMGPSapPmMcKFhoGRvIlj/vDUxSMo893ZHM=;
        b=Q88nAwV358ImRo9NxQvURw6r8yQtcMULqrWmXOsqBDIerESmW2jyNTiPbuAfpYwdCj
         ihc22JWGLT6NQJPlo+5+SbsuncaU4P2GNRFiK3+55c5r5UT0PHm9CUQ/lc5GNxTYdVRQ
         /rdMA0blWNFkZEI3kY3jHJTB+TS99uVBw5i6Q2pybG/5v/ythtwMh0lc4PSEsi0RqD59
         BD2fE+AqrCHAiTulN7QA4r68+8niilZ9Ghvfngq8uuDIZGjvilIiylBCJmeeaquT0hKj
         POd+MfjAdwm3g5W5DeskJQ/L8I53JJl5qkACV735m/syi1GOvl7HTz0MCsr9wzAKb6RJ
         QHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278823; x=1704883623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcomVPZKfMGPSapPmMcKFhoGRvIlj/vDUxSMo893ZHM=;
        b=qnvHbe/FdlACdxv6co0pi+YhyyziIz0/QXjlSTLIczOsEfkvmxpSkISu+G5blABIho
         STnqPgz87Y0Qb3AKzHICHPosmgu6dSzR10kQ3D8kgD6n1yv25MkCCyL+Jrkj/AE+u+yw
         5auEiS84fAdk0KvY3IKj+JlXAePpbYqvbaTq2ixjZgPWUJlxtlMnd9qwszyaG+ohDda8
         Og69s4oCVT0PMrqEwnQZdC9ENlEiEbCASudmfrQN3u2rM1KQjIPnK6lIgr/nLGkijmtT
         VMXJeJxqG6hNBkH6uQVisdbn+PxaL2bs6NJf0+n5+g2+bGw/IgwP3j5Z4OOs9SepCsXf
         TkXw==
X-Gm-Message-State: AOJu0YwqNLDYqJU2JF1fgcHeZMIXeB+3J5zlgIs5cQxdqJRgH0M8/cTw
	ahno51jALE9lz1/lIj0n7TPaBquJyGAheQ==
X-Google-Smtp-Source: AGHT+IHxJm1WJIvAAPzcbupFAoa0cmuN/4umyS3/k+XyyGf8idZn7fFh32P7Qqsme1ttAANK9+BeyA==
X-Received: by 2002:a05:6a20:160d:b0:198:308f:2f45 with SMTP id l13-20020a056a20160d00b00198308f2f45mr172098pzj.92.1704278823290;
        Wed, 03 Jan 2024 02:47:03 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id p56-20020a056a0026f800b006d99d986624sm18832025pfw.151.2024.01.03.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:47:02 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Relocate dev_pm_opp_sync_regulators()
Date: Wed,  3 Jan 2024 16:16:58 +0530
Message-Id: <619d355a4500cd766639be3696016daa56214cc3.1704278811.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this to a more relevant place in the file. No functional changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 82 +++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a6e80f566e9b..29f8160c3e38 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -3012,6 +3012,47 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
 
+/**
+ * dev_pm_opp_sync_regulators() - Sync state of voltage regulators
+ * @dev:	device for which we do this operation
+ *
+ * Sync voltage state of the OPP table regulators.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_sync_regulators(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct regulator *reg;
+	int i, ret = 0;
+
+	/* Device may not have OPP table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	/* Regulator may not be required for the device */
+	if (unlikely(!opp_table->regulators))
+		goto put_table;
+
+	/* Nothing to sync if voltage wasn't changed */
+	if (!opp_table->enabled)
+		goto put_table;
+
+	for (i = 0; i < opp_table->regulator_count; i++) {
+		reg = opp_table->regulators[i];
+		ret = regulator_sync_voltage(reg);
+		if (ret)
+			break;
+	}
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
+
 /**
  * dev_pm_opp_enable() - Enable a specific OPP
  * @dev:	device for which we do this operation
@@ -3135,44 +3176,3 @@ void dev_pm_opp_remove_table(struct device *dev)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
-
-/**
- * dev_pm_opp_sync_regulators() - Sync state of voltage regulators
- * @dev:	device for which we do this operation
- *
- * Sync voltage state of the OPP table regulators.
- *
- * Return: 0 on success or a negative error value.
- */
-int dev_pm_opp_sync_regulators(struct device *dev)
-{
-	struct opp_table *opp_table;
-	struct regulator *reg;
-	int i, ret = 0;
-
-	/* Device may not have OPP table */
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return 0;
-
-	/* Regulator may not be required for the device */
-	if (unlikely(!opp_table->regulators))
-		goto put_table;
-
-	/* Nothing to sync if voltage wasn't changed */
-	if (!opp_table->enabled)
-		goto put_table;
-
-	for (i = 0; i < opp_table->regulator_count; i++) {
-		reg = opp_table->regulators[i];
-		ret = regulator_sync_voltage(reg);
-		if (ret)
-			break;
-	}
-put_table:
-	/* Drop reference taken by _find_opp_table() */
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
-- 
2.31.1.272.g89b43f80a514


