Return-Path: <linux-kernel+bounces-57993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8605A84E016
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AF4B2A22B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3AB6F53C;
	Thu,  8 Feb 2024 11:56:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F66EB51;
	Thu,  8 Feb 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393371; cv=none; b=HYemXiI0La8kkNixRt+Z74q1hwZeRj/QsvQ7AK8Mv9SHbdHVxpULwzLjMss5YuoaQsE3t9K++fONQkG/iUEH5Csj17PvMGDrB7MOsEJmJXCwSR/4wuic8Sr1/+1q2ruNYb4ZpdAHMGThvFndl/we2kSgP5agqZ55wxW55O2KSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393371; c=relaxed/simple;
	bh=8DMwt8yyB/AH6UsoAjLC//3tT+olnUYsZlQ9JSoRWMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKnfBiCmA1HgEiLNVQe4qcRWX6talPygQWMp4cPoLcazqKZ8gnHnl8Z072WW5qrt4Eg6YiGA7gBK3uasREEtjMW6w65fsvltGuXWd41Cs7yIaEW8xs8Z8VpQh03EH8Syxj+IojgmWCL80OQoI1uPhu13I2b3RrwPPvvARjtPVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6494DA7;
	Thu,  8 Feb 2024 03:56:50 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 994823F5A1;
	Thu,  8 Feb 2024 03:56:05 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: [PATCH v8 01/23] PM: EM: Add missing newline for the message log
Date: Thu,  8 Feb 2024 11:55:35 +0000
Message-Id: <20240208115557.1273962-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing newline for the string long in the error code path.

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7b44f5b89fa1..8b9dd4a39f63 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -250,7 +250,7 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 
 	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
 	if (!policy) {
-		dev_warn(dev, "EM: Access to CPUFreq policy failed");
+		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
 		return;
 	}
 
-- 
2.25.1


