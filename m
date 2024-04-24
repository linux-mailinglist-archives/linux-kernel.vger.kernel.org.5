Return-Path: <linux-kernel+bounces-156714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999648B0732
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F31F224EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11792159913;
	Wed, 24 Apr 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rA2xWRWl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hFd+iLM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE771159572;
	Wed, 24 Apr 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954139; cv=none; b=on01fJw0GH4yu/aemXXeW4F8Nb3XWPOZ+IrG+lx9wpn7FwMeEvyKxcyjTFAJghh/X3qQrJ/aXCqtpYR9IiZzy7YMqeOZeeqNYB1mieTYi6pHz/2Jz5JE8vn9M5uqhkgXQkmUYOl+p0E0IuBq1v41NOoahh4q5eoRvfPUmTnQEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954139; c=relaxed/simple;
	bh=UTlW9J8REYe0N/IbNnYbHKmHOTqxCm4XrHhokwPl6Ts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WXRY8SD0UivsWj3i9AzsS6FmLCkI4eUuQFfddEh6s2I0Mk68PiSaYCb4W0LoxalqMN9nXCJVzDYjofHsi7COCVK4Hfc9y6CJMWyrvQArS0DDVFvkOKcZhomkpByFW2Xu1QrUZlwLCG+FEMVxm+NeYqtlV4Hl39WLZgNHdekeEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rA2xWRWl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hFd+iLM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:22:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713954136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ib9HlOEBMAxYA9OB0lAjuhLkPfnfgx8pWvopuOwFSQ=;
	b=rA2xWRWlikBuxS+H4qQxYVm0x3qkOqsB5WmnAv0k4RKF1ihTuagpGHEj/zgGimFe3d3gwU
	OMPDM4dTPr8bPLPdMJb3xZJBazPWZgK3j4P+Ph8pClVTnTe86Sboz1rUrPwzdExxL3IVxw
	dmd5aK6xuu3sI80KYFHbNrbMD8CkA2tL+djXRqwUG4Dp7WIsJqlwQ8fGmp8q8lEP2JlnxW
	lbuNl5R8g6amNupPnX60DvOkng10c75RvzKp0yIoLpb+m2votCrc4QGdzhoTQ85J4a6vIY
	13pvh2xn9QbCEqjwNhuYBQmyrGDQveOpKmz2ZmkGq7ER29ooNTgDk7IP9H1cnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713954136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ib9HlOEBMAxYA9OB0lAjuhLkPfnfgx8pWvopuOwFSQ=;
	b=hFd+iLM0i4WpKF4ukodbUBRQHbEWWExtbdVcQLrRbYuyZGHZUzjqDQMePo44EEXqyVsZAq
	0pydv0gYvDmhVQAQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] thermal/cpufreq: Remove arch_update_thermal_pressure()
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Dhruva Gole <d-gole@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240326091616.3696851-4-vincent.guittot@linaro.org>
References: <20240326091616.3696851-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395413551.10875.5850326292682493077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c281afe24fc51691e65f59ea66eefa14cbdfa0e7
Gitweb:        https://git.kernel.org/tip/c281afe24fc51691e65f59ea66eefa14cbdfa0e7
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 26 Mar 2024 10:16:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 12:08:00 +02:00

thermal/cpufreq: Remove arch_update_thermal_pressure()

arch_update_thermal_pressure() aims to update fast changing signal which
should be averaged using PELT filtering before being provided to the
scheduler which can't make smart use of fast changing signal.
cpufreq now provides the maximum freq_qos pressure on the capacity to the
scheduler, which includes cpufreq cooling device. Remove the call to
arch_update_thermal_pressure() in cpufreq cooling device as this is
handled by cpufreq_get_pressure().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20240326091616.3696851-4-vincent.guittot@linaro.org
---
 drivers/thermal/cpufreq_cooling.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9d1b145..280071b 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -477,7 +477,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	struct cpumask *cpus;
 	unsigned int frequency;
 	int ret;
 
@@ -494,8 +493,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
-		cpus = cpufreq_cdev->policy->related_cpus;
-		arch_update_thermal_pressure(cpus, frequency);
 		ret = 0;
 	}
 

