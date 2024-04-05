Return-Path: <linux-kernel+bounces-132757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BE8999CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84461F248AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D043160781;
	Fri,  5 Apr 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="rVEFTvJV"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1D15F300;
	Fri,  5 Apr 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310121; cv=none; b=kkkAl7YqyyYyZPyD05uYEjgkKRtjcc3ZuCPrqo45cztPEdF0rO7c8CXLvdUlV7xH0EhjqhVSoXaLDGfIWgL8IJK9N6dkNdVjXYV3jjqilSPxjP75A8WE8QQmTtbuyNY8EdbYOeNQx88E0rlVmITUGr2XEK4ZiwZFJaEHGzlglBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310121; c=relaxed/simple;
	bh=ZcOerhmDTyl3W/0mikjVoprKLaRbhLbMr5B5dPhdLbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5tcuHwiqu/IxIU0zyVfSrhFZnl63L7ZQHKLnF7zkvQ3L6b26tjd4ge0uqSb3MoxAoCPKMP2VN7n51JRnJS3ijyQCQafnG5NfhSOZPycWbTECnvxGVmvRKhZaqJ2p1d/XCGnKI3C4eR7wSrz76IHeyVdvZUUNEgbuB4lsO3Lz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=rVEFTvJV; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id EBDBE100002;
	Fri,  5 Apr 2024 12:41:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712310098; bh=exxj3SM6SDla62q2JnE6KpTdEW+tLbPYFoaJcDDjiCk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=rVEFTvJVYuBk8YQaTZ+E40GhNjXrfT8k6cuAWc0TqZ1FXgkxUIJD44+EjJYoOm4TJ
	 raiil9rNugUF5L9NAehigNcJ55coI413o7d9Ml2Nhuwtg8FIvB8LANWbQ3kmYuAqPz
	 wBdlCSjkp6GP38gN+Hz7B6vgCYVZzrhMccZrVo9/OVRFFJ8FIXE8krzV4OwWZGvfjd
	 VUmj2IkfHLNoY8iH0dnQuiJ19YYtGiB+z62dAGgPFGk4zfxNMflCYaAPZbzUh1AJbB
	 Cw4VkYi7EARXvsWigIv0R0OICSsGv/9HsK1dpI8r8KmtUjXVigl0whxxPu5aYcyPeW
	 fqZDy1GLijIsg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  5 Apr 2024 12:40:19 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Apr 2024
 12:40:13 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Ionela Voinescu <ionela.voinescu@arm.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] cppc_cpufreq: Fix possible null pointer dereference
Date: Fri, 5 Apr 2024 12:40:05 +0300
Message-ID: <20240405094005.18545-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184599 [Apr 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/05 09:29:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/05 07:02:00 #24662400
X-KSMG-AntiVirus-Status: Clean, skipped

cppc_cpufreq_get_rate() and hisi_cppc_cpufreq_get_rate() can be called from
different places with various parameters. So cpufreq_cpu_get() can return
null as 'policy' in some circumstances.
Fix this bug by adding null return check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/cpufreq/cppc_cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 64420d9cfd1e..5f7e04e8497b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -741,6 +741,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -ENODEV;
+
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 delivered_perf;
 	int ret;
@@ -822,6 +825,9 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -ENODEV;
+
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 desired_perf;
 	int ret;
-- 
2.30.2


