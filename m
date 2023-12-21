Return-Path: <linux-kernel+bounces-7871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F6981AE88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3148285116
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB790B647;
	Thu, 21 Dec 2023 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zv0M382b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7559474;
	Thu, 21 Dec 2023 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+XoCK53Gvu/al13C+ucC/sWMObI4hSS6KAdW71BQpfs=; b=Zv0M382bWEcWJmtA3dhuJ0koDy
	jdd6oUNr3xlkxv99M7I0n5xSjhQL1Prj2y+L2rUL8jgGkFbphsKGUwMHmtBA3h2H70+gOedzVojd0
	Y2qMMx09fGWkTq1RdTK/AE3h1RKok8zqmd7qiQxhzHF9imST1Y1f41gbSy1RW/fAzOwPKrY9me8B7
	1J4G6QMvkgiugjFlbp3kn35Cj/+lM7anql28zBC9IeC+BLansdc6Y+BNHmicYAjdGSpJUAMePcirS
	kd82j1oh8zvn5VlaxnsIiuR2BnZtVssTOnA9lfLRFLdsULM0BV6pHcqFtTWBzoVDYvjVCg30EMwDI
	NYY/tqJQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGByD-001m5e-1V;
	Thu, 21 Dec 2023 05:51:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: cpuidle_cooling: fix kernel-doc warning and a spello
Date: Wed, 20 Dec 2023 21:51:44 -0800
Message-ID: <20231221055144.24862-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct one misuse of kernel-doc notation and one spelling error as
reported by codespell.

cpuidle_cooling.c:152: warning: cannot understand function prototype: 'struct thermal_cooling_device_ops cpuidle_cooling_ops = '

For the kernel-doc warning, don't use "/**" for a comment on data.
kernel-doc can be used for structure declarations but not definitions.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/cpuidle_cooling.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -66,7 +66,7 @@ static unsigned int cpuidle_cooling_runt
  * @state : a pointer to the state variable to be filled
  *
  * The function always returns 100 as the injection ratio. It is
- * percentile based for consistency accross different platforms.
+ * percentile based for consistency across different platforms.
  *
  * Return: The function can not fail, it is always zero
  */
@@ -146,7 +146,7 @@ static int cpuidle_cooling_set_cur_state
 	return 0;
 }
 
-/**
+/*
  * cpuidle_cooling_ops - thermal cooling device ops
  */
 static struct thermal_cooling_device_ops cpuidle_cooling_ops = {

