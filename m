Return-Path: <linux-kernel+bounces-162417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA418B5AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B401F21285
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196047E103;
	Mon, 29 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jg/UPbul"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A47C0AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399559; cv=none; b=bEdc7dVgq9BrKIxCL4avpYDNcnzO/acFidEZR6XsTXCLc9RWWORaFoU6TJazdehrBRIqUuDyuM55/YAZa9dp2K71CMZEXbr1E/1yZxblxk9NjZ25dPMt+dH5Gi+Ob0Wll6y3+zHMPEmX6kK9zfjtlH+cclYcY/i18Ehf0x2AfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399559; c=relaxed/simple;
	bh=DBZiNtJHVVXl6UzU8xo+RguK8DX+TTi3BYBsrhBX+dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiuqNnoMtTBtcy9bXBWHDURMtRgQ/uQKQrOgNVHRxO1A0yg1egrTfaFcTCPahF9LVlT9SPDwUB8RPvABXyyVUqMfLY2QRr+SgPNBqwcfLR+Bbe4ntOW9lu4li9jRtwHRdHhA1SMqvQzGYHMrwiQQLQKzztSjSIafq4x0rJVFHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jg/UPbul; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so52665591fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399556; x=1715004356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhlwXdsIIQqTLzsLYWWuKXNc3rr4XrNJUhlJgkxDb2g=;
        b=jg/UPbulxiW3Cy8fmJZG/BSq9n743kqRqw8it/B7Qc1nB9nDvkxQFmPA+ihIwBi2G8
         9KyFaxJuYXKQPfbvDICSH6fFS155mOwcs6bIOQLpjtsflv9qP+DpZMEcgDXXECIpsQoI
         7ZK4wi0IPlZ2TAJqOhRZ+s5W1UPySxdkvq2ER1EB5azdxXYfxGIz/YwkLvPmvs1X34Py
         wzMHemo6/E5BmlDTQg2O+e1rRBnFjV+mql6ARerH3KjELMErYkalzCsnbGWQF4vDLl8t
         UazNyzQGODQpq83bPgVn/qV3gXAafhnR6WDeRmc3WV4lEfN2ahetWfnIAv3eSicCZHJp
         SbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399556; x=1715004356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhlwXdsIIQqTLzsLYWWuKXNc3rr4XrNJUhlJgkxDb2g=;
        b=hvX7Ldgs/FcP/i04O2AJs3CF08L6utZDc8QWMP3t44NDAPzMGmW64Fw85r8dld0HCf
         H7AhvVsj0BpL/BN0wGWi+rlQlwrSP9rsmpYBhg8fkI2A4WE2d05rCoNyc6YKVVAb4IjT
         RLxgNDyK4Y40VE6QMPPIhlFtl87SyX1tXhcx4vb6dfCk45iqDBVu/WrxDNIO43tZ7SRx
         dZETM7n17it3zEHwfc+C62RyjIxgIwrXCenqP1d8KEjFDMzKoX6ly/0Y14uO/q5DChna
         OQM7u9Sp5upinVnaUHyrdvm1iXzMG67gdZ8LS2nE+D+ZNW8eVEfA2Mgp/1AvIiJTYYv+
         27nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt4U6uPZDuCtkpmZb4oN8AIBAtzPNNaZCajPZs4aGlFdTHW2KU926pa3GH5fzhEtLv2RZsvwcNYoS6zRWABJkRkGx+bHdP//rt7EQc
X-Gm-Message-State: AOJu0YyYEvll03DXn+I6JbcNrhtzmErnehKkN/ZijfIcLwebci6kbCeW
	qtj2NBjXz1pGAmofL+2ZG94/CgctLu5kERbxQUv4fOqdV23M9k/nKZUB9hux27M=
X-Google-Smtp-Source: AGHT+IHPdwyXQU3aNRNl39I+1zVVIQFncsJfd0yL3gfsj/5GlxoblfJ4b4uEsKSkTrkhND9uPVuJKw==
X-Received: by 2002:a05:651c:221b:b0:2e0:752c:1f2e with SMTP id y27-20020a05651c221b00b002e0752c1f2emr2172687ljq.1.1714399553969;
        Mon, 29 Apr 2024 07:05:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:53 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
Date: Mon, 29 Apr 2024 16:05:27 +0200
Message-Id: <20240429140531.210576-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429140531.210576-1-ulf.hansson@linaro.org>
References: <20240429140531.210576-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to hold the genpd-lock, while assigning the
dev->pm_domain. In fact, it becomes a problem on a PREEMPT_RT based
configuration as the genpd-lock may be a raw spinlock, while the lock
acquired through the call to dev_pm_domain_set() is a regular spinlock.

To fix the problem, let's simply move the calls to dev_pm_domain_set()
outside the genpd-lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index abd3c069df8b..1e3f8dea4654 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1726,7 +1726,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
@@ -1735,6 +1734,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
 	genpd_unlock(genpd);
+	dev_pm_domain_set(dev, &genpd->domain);
  out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1791,12 +1791,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 		genpd->gd->max_off_time_changed = true;
 
 	genpd_clear_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	dev_pm_domain_set(dev, NULL);
+
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
-- 
2.34.1


