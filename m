Return-Path: <linux-kernel+bounces-130445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53F897831
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCE71C217E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD9153BFE;
	Wed,  3 Apr 2024 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTkYfxzS"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177531534F2;
	Wed,  3 Apr 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168781; cv=none; b=j8yvTezLRhonC4+9kRAQh9KTg8UMVsoF5gypL22BWYnN06zKGLEzOoqn5w179gZLbaZe5IuiRMrRw1DIBclhLBd6yK6OG8ivw0075UsTO5yRGJkghXhXXZsbKUO0Z39eGT1tUV0+j4zQW6DQZWEicc2pmYAbq/uo1lEf4Hryobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168781; c=relaxed/simple;
	bh=Of2GYAaUswv6LvHoA0UkUvxuxYZ5tgWnA6txjalqaVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEupv8KtqOomDOuY91BcOFIr/VbZVgmCMw9fBcqM1Cf9Gpv88jfqC6XvyfD7v++J638/xEiWLbOCnAbfi8hwKuaCqsFvbAGUnMkX2Nh2qLvMTBaA21q5uUdB+8h+SnrgMboS7z7gSpmqs3OnhewAHbTOMXn/MsSRAgIf0ElEoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTkYfxzS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so115405b3a.0;
        Wed, 03 Apr 2024 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168779; x=1712773579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbtoEoj4oChBiO+Y87ED1v4ExuftqHcGwPMYfmQNkfA=;
        b=hTkYfxzSBkzMxBSDsk2ykPM/vOwPUOKkblnOjqQcFsuuJ1jvrWKV6qn/L9PADoQQe5
         zFh+hDaB93AMoIi/u/8eA+z71fef63BvlMCRnhG9LKJEdEf7SeDiUe56knH/Q97A8EMp
         4gdoSSdqIOaH4M8bDAZVrkQQn0aOYAMjyCGa3VPCr6G48O/a0hcu5d/ZmspoJeaJtSPk
         zv8Klh0R3zxsy64+P/mxdOiqX4VIn0SimqTzZp8ljgc2pUpDqXtS7yqh95haAlar7Law
         FfdBbmA05hKkrAvPLZM/TVpvaHg/RBnSiTK5PK4HMMqgoCR2nMzEBHGxnhPijXo+f3E0
         Ne0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168779; x=1712773579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbtoEoj4oChBiO+Y87ED1v4ExuftqHcGwPMYfmQNkfA=;
        b=YyCRetmz9GRms93Mfo/15zOXn1w/KlfSONgwgKZyRhRcx7B7vuoXuXYIOmESTl2KT/
         X+L6Jy0zz9h3Z97S6VbGAH8FdkVjGSAUK93NQAyD8XhKG9giqlfG3pnQ2Yjoo8G3QVJv
         fWaonDx5zBTfWXMG65aS7tZf/bJdDlVM3tzicjZuZ6oFKa1Q014IJb2z9HWf9sXEF3fo
         1+HE3iZrABNcDwNbMiM/LzJDqBvMcVeOMXZpI1DMIpC3Xws+/eRpf5cAdobxN+urzw2p
         bnK+p6OISQINb5aLNOFglfrm/23EBfwka3g8599iLvHO60BalPxfU2SasiRFPVKB1E1m
         pv0g==
X-Forwarded-Encrypted: i=1; AJvYcCWteOvDQztVyzmRk54tVABNWzJNC1ccUKRxFXXvqZyI3yrTCE1qzYAFgkrvOkvZtKWNYH8Lm+eCqnqus0mKloyQ94AdNtDIbwexO7KAN2s+BwTL5FUnvky6Y3tx9+zgmYcSE96VWTCjFfMx8wJIoXOiwNjpLEwOL7tQ/GWjU/6xHUqpVEMIVf7eHQ==
X-Gm-Message-State: AOJu0Yx7kPpNOyynBqGHWwkQ+tAzmup33uUtzTS8WfBYis2E+9JAWf9K
	DI46jN4E6WPMf2JMGoEbZVV6n81ZQft7jKCXf7jv6X3VQ7rHNqdG
X-Google-Smtp-Source: AGHT+IHQ9uuUuPoQFrr8foz2IR4qr+5ODebDBIJMqbDQ/OLXs1tkY8YgMX5XpBIC998RHg3OwMlolg==
X-Received: by 2002:a05:6a00:b81:b0:6ea:92de:3603 with SMTP id g1-20020a056a000b8100b006ea92de3603mr406437pfj.16.1712168779381;
        Wed, 03 Apr 2024 11:26:19 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id kq10-20020a056a004b0a00b006eae3aac040sm10609776pfb.31.2024.04.03.11.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:26:18 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PM / devfreq: exynos: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Wed,  3 Apr 2024 23:45:05 +0530
Message-ID: <20240403181517.5993-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403181517.5993-1-linux.amoon@gmail.com>
References: <20240403181517.5993-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
they will simply be discarded by the compiler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
added __maybe_unused to suspend/resume functions

[0] https://lore.kernel.org/all/20240226183308.4730-1-linux.amoon@gmail.com/
---
 drivers/devfreq/exynos-bus.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 153340b6685f..09822f8fa209 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -454,8 +454,7 @@ static void exynos_bus_shutdown(struct platform_device *pdev)
 	devfreq_suspend_device(bus->devfreq);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int exynos_bus_resume(struct device *dev)
+static int __maybe_unused exynos_bus_resume(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	int ret;
@@ -469,7 +468,7 @@ static int exynos_bus_resume(struct device *dev)
 	return 0;
 }
 
-static int exynos_bus_suspend(struct device *dev)
+static int __maybe_unused exynos_bus_suspend(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	int ret;
@@ -482,7 +481,6 @@ static int exynos_bus_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops exynos_bus_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(exynos_bus_suspend, exynos_bus_resume)
@@ -499,7 +497,7 @@ static struct platform_driver exynos_bus_platdrv = {
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


