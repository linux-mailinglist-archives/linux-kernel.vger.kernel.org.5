Return-Path: <linux-kernel+bounces-96559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D92875E24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F4B1C211EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA64F606;
	Fri,  8 Mar 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qQPPDfgY"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE04EB2C;
	Fri,  8 Mar 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881374; cv=none; b=qYOmeSjp+wIe/ZFN0mDqii3lK8EAJ9mZAXQ10y4o/NhwVK4jrE/c5kfXG2pWWOfctsUpa7LOYv+dISUz521NE+tYDdGFuCW+lgPhfVgVpvzYma4yUuzKHcAh7OFGHbcU5a5vQg46EdWkw6uhoZWP4DDpPvQS4/Syv6ki6Ix55is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881374; c=relaxed/simple;
	bh=7ruNXrmUyAheCWWLm1oSc73QJzGRd+8WlblR1mjKBek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlnbCz7uZfdqKMI6PZcvQXmGHbTAReju3do+bSALYmhisfLDBzdBHMFO+lb8u96Qc8ApRcI5U2va9ldEaI+8tFQT+hkpk2QXHeUifCv65wAc3EWjDIspuXFsyBDKKroraa/8dggQ1aEl35EdhKUQu6H88S9vXzA/8xoljVIlMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qQPPDfgY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: de863916dd1911eeb8927bc1f75efef4-20240308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HYLVEQAeXAzYFBzdQ4HfU1if9wh4fJliGECJyMJTAJ8=;
	b=qQPPDfgYZKLDdx9pcCa3FdpS2ikSnVhTCqfgdxbpQk56Y+bRo0l4SiuKUEeH7sf8+eIcNxUW08JEDV+r2ZsFzBRJIhMYhlpJiUaXnkYuw+w+ajmGexkQn2wEBpOW7vS9AbnWJgBRyGgILvvnOKlXb9eaAlHFao2Vw9yO+gfPcdY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:02625fd9-44b2-4266-9b6c-ef32ac9f58b8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:78eec384-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: de863916dd1911eeb8927bc1f75efef4-20240308
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <poshao.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1744216713; Fri, 08 Mar 2024 15:02:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Mar 2024 15:02:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Mar 2024 15:02:46 +0800
From: PoShao Chen <poshao.chen@mediatek.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <lukasz.luba@arm.com>, <dietmar.eggemann@arm.com>, <rafael@kernel.org>,
	<mingo@kernel.org>, <rafael.j.wysocki@intel.com>, <rui.zhang@intel.com>,
	<vincent.guittot@linaro.org>, <daniel.lezcano@linaro.org>,
	<viresh.kumar@linaro.org>, <amit.kachhap@gmail.com>,
	<clive.lin@mediatek.com>, <ccj.yeh@mediatek.com>,
	<ching-hao.hsu@mediatek.com>, <poshao.chen@mediatek.com>
Subject: [PATCH 2/2] thermal: cooling: Fix unneeded conversions in cpufreq_cooling and devfreq_cooling
Date: Fri, 8 Mar 2024 14:59:22 +0800
Message-ID: <20240308065922.10329-2-poshao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240308065922.10329-1-poshao.chen@mediatek.com>
References: <20240308065922.10329-1-poshao.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.870000-8.000000
X-TMASE-MatchedRID: 3q/Jq05zu+qDyGVXKzWcEuqwWVBfMuvo0w14HFJQjaMsfFlFugSGUNno
	quRwHY3BbK1J8N978RWUfobZwcvQE8rNY6Kxr3NKH5YQyOg71ZZMkOX0UoduuQqiCYa6w8tvVSd
	AA6mVeIYriEKQi78d2HDtxegKT7/su7+GodKzwZdSGsgQwHevX30tCKdnhB589yM15V5aWpj6C0
	ePs7A07SAJgyd9wrc88jzsfqJeP5v2wn0UK+VrFyU//YpP2DKvF3MvGKttLrWWf4RCoUdnMg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.870000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	63E754CAFDDC1C375A2A74378AEF2BADBE63BB297FA8F76FEEF00283DE88C6372000:8

Fix the incorrect division of power values by MICROWATT_PER_MILLIWATT for
non-microwatt units in the Energy Model (EM) by adding an
em_is_microwatts() check. This ensures that power values are only converted
when the EM specifies microwatts, allowing for accurate interpretation of
power according to the unit defined by the EM.

Signed-off-by: PoShao Chen <poshao.chen@mediatek.com>
---
 drivers/thermal/cpufreq_cooling.c |  6 ++++--
 drivers/thermal/devfreq_cooling.c | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9d1b1459700d..5324b9766843 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -120,7 +120,8 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	}
 
 	power_mw = table[i + 1].power;
-	power_mw /= MICROWATT_PER_MILLIWATT;
+	if (em_is_microwatts(cpufreq_cdev->em))
+		power_mw /= MICROWATT_PER_MILLIWATT;
 	rcu_read_unlock();
 
 	return power_mw;
@@ -139,7 +140,8 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 	for (i = cpufreq_cdev->max_level; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
 		em_power_mw = table[i].power;
-		em_power_mw /= MICROWATT_PER_MILLIWATT;
+		if (em_is_microwatts(cpufreq_cdev->em))
+			em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (power >= em_power_mw)
 			break;
 	}
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 50dec24e967a..c28e0c4a63d6 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -222,7 +222,8 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 			dfc->res_util = table[state].power;
 			rcu_read_unlock();
 
-			dfc->res_util /= MICROWATT_PER_MILLIWATT;
+			if (em_is_microwatts(dfc->em_pd))
+				dfc->res_util /= MICROWATT_PER_MILLIWATT;
 
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
 
@@ -247,7 +248,8 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		*power = table[perf_idx].power;
 		rcu_read_unlock();
 
-		*power /= MICROWATT_PER_MILLIWATT;
+		if (em_is_microwatts(dfc->em_pd))
+			*power /= MICROWATT_PER_MILLIWATT;
 		/* Scale power for utilization */
 		*power *= status.busy_time;
 		*power >>= 10;
@@ -279,7 +281,8 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 	*power = table[perf_idx].power;
 	rcu_read_unlock();
 
-	*power /= MICROWATT_PER_MILLIWATT;
+	if (em_is_microwatts(dfc->em_pd))
+		*power /= MICROWATT_PER_MILLIWATT;
 
 	return 0;
 }
@@ -321,7 +324,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	for (i = dfc->max_state; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
 		em_power_mw = table[i].power;
-		em_power_mw /= MICROWATT_PER_MILLIWATT;
+		if (em_is_microwatts(dfc->em_pd))
+			em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (est_power >= em_power_mw)
 			break;
 	}
-- 
2.18.0


