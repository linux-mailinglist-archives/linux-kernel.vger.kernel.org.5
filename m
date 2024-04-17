Return-Path: <linux-kernel+bounces-147934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083888A7B86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57D4283238
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98BB495CB;
	Wed, 17 Apr 2024 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVW2VMuD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209A48CC7;
	Wed, 17 Apr 2024 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329129; cv=none; b=gyL+XTDKTB7JzKGx1JCqmHNCwgMTFlaUn0I5jpmWxGIOMMijmlSLgtcFa3NLOQbqRdVBGV4OXCdcmSPLFOefFeYqINvXLG7wcAna11J9kV7SLK/sWyzqFwK+VrpbD2E5qiX0BP0FrKQkIOUfLR/KAle5yuwf1rgqIJ9yqbgByZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329129; c=relaxed/simple;
	bh=0uYmzNbmhVT0zrBveQiXWQNqO5I2h3S7etrYhBY3kPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH7C1DCqbXh0g+7uoBOe7nE36ZSiYxnXLTkqgJV9euqe/AjcGj+SEQlsV9UflRuxgBql6jTCvt5+4ITpntuArdlvUfP0efYSJBSN8bB/mSm4azyejIAqOYABXItZTSXwdnjyNca++YKc/nJ4aEPk5iDdyigQTJWfKoZhOQHGQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVW2VMuD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so302996a91.1;
        Tue, 16 Apr 2024 21:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713329127; x=1713933927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix5I1EmrcVwkdm6oev/n0e0cu3EKBfKkUwQi0q2AcII=;
        b=TVW2VMuDg6OO4JMpHlfWTuwsJHOzFcIGuT80xSaP5nihoMec23me1mtWonY65sXudO
         gnOeV+sMm38wnwe+vtiVt60n5U0WLvS89tfDPXEKKs1nRBC340XObOUbXWTWNRFT8CaB
         51LuvNKG1XiUHlaDrWzD8edAqah2YW/fpSYWBSoBtGV/UWfcVjbGlgJGDaAOaHfpXumM
         ChrfH6A4f+3HYHUOr9EutRSZDD9E5s8yod520FHjXrsjbLICtZzN6ecN4K6OGfNgqiLR
         2jUVvxJyP3aiOQhPgL6IbBnD9aTz5LnJdwyqMyu1Iocr1n3d4+iEVWwVBFqhGvnEdyzT
         YDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713329127; x=1713933927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix5I1EmrcVwkdm6oev/n0e0cu3EKBfKkUwQi0q2AcII=;
        b=lR1ZfD2BTZxkGPByIq18d8vfiu3TqfzohYoJM0gZz5QBvtg7UnSUw4y6//4d/AAWYm
         goDpyDaOE+5hSTHKNZi8Lg7rCecjMC+CHD0XEby5bstZiYjpQeDbkNTsUEok7a5Nj7Si
         zoEG/oXlQIwciSATwIj61ve5gkwjZjsYWUn3eA5CGIpDiQ8yr8M6BuHwPKf4KR4x/+zp
         63u/q74b/VOituXJ69h+/UL6lUAGnuAwukBF11adPiKi0pTTyTg8s1Pt1YnbAwVPtuFp
         FfY9UYtnjUE2X0lodYq9Dqy4ACYajv+gc+ZgbG2+AjIzIknRLb/Xxmol1dNAiu+IM3Z9
         eq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUY57fBrKl92pI2jY+4cutCm/Sz0mNCRQdPaW2eHreeYdkHz0bMShPM+jXukiViYJBTvodDCadwykia7P3DXwU23VbwATKUIWK5g5O5F4ZCt3HmwhZvWWdmGHpsVMrl54Ogk+5z5UGtxXfzND2tMJvqwrzOoeCGuvoySXfXVPI3kgaCuy2ojiyURA==
X-Gm-Message-State: AOJu0YwZjeJEe4ft4HAsWqK3sqVdPkvAV1Hhx9Rzw4ckYf71k7H3/LUb
	3CSHCprBUztZajNWuN1pEb/a/dKP08M9eTR9Ww3DfZf5iKmUJHIrQfuavg==
X-Google-Smtp-Source: AGHT+IHcijOFiGcrpds/8InYTdLVg2ob8g6xgqf32vPTH6ClkmhGxpsSjcOf+6Heyl309B3TS6AIdw==
X-Received: by 2002:a17:90b:3010:b0:2a5:c1ca:801 with SMTP id hg16-20020a17090b301000b002a5c1ca0801mr6393726pjb.23.1713329126906;
        Tue, 16 Apr 2024 21:45:26 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id z88-20020a17090a6d6100b002a2dbbbb36asm511458pjj.37.2024.04.16.21.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:45:26 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Wed, 17 Apr 2024 10:14:48 +0530
Message-ID: <20240417044459.1908-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417044459.1908-1-linux.amoon@gmail.com>
References: <20240417044459.1908-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro has the advantage over SET_SYSTEM_SLEEP_PM_OPS that we don't
have to care about when the functions are actually used.

Also make use of pm_sleep_ptr() to discard all PM_SLEEP related
stuff if CONFIG_PM_SLEEP isn't enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
   is disabled
---
 drivers/devfreq/exynos-bus.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 153340b6685f..b89e04eb8430 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -454,7 +454,6 @@ static void exynos_bus_shutdown(struct platform_device *pdev)
 	devfreq_suspend_device(bus->devfreq);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int exynos_bus_resume(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
@@ -482,11 +481,9 @@ static int exynos_bus_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops exynos_bus_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(exynos_bus_suspend, exynos_bus_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_bus_pm,
+				exynos_bus_suspend, exynos_bus_resume);
 
 static const struct of_device_id exynos_bus_of_match[] = {
 	{ .compatible = "samsung,exynos-bus", },
@@ -499,7 +496,7 @@ static struct platform_driver exynos_bus_platdrv = {
 	.shutdown	= exynos_bus_shutdown,
 	.driver = {
 		.name	= "exynos-bus",
-		.pm	= &exynos_bus_pm,
+		.pm	= pm_sleep_ptr(&exynos_bus_pm),
 		.of_match_table = exynos_bus_of_match,
 	},
 };
-- 
2.44.0


