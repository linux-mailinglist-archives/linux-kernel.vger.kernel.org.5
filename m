Return-Path: <linux-kernel+bounces-86275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD786C333
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4640CB232AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72C4878F;
	Thu, 29 Feb 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOw6KgVw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF59446AB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194341; cv=none; b=Az5Z1LgojCMIWKrTesbwMzU8ttqaPjn9zmIIutybplgP6MSRyz1cUyDnpFtJSSoM9F4h+hqo982CTLq3xtkp7Rdzloowt92ZkF9RB4ER5EbXTaw58V7OAWHXEinTAM4VqB8/tcyuzjfkBaapUe14y4mrVhTiVwWFbPSynvWcPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194341; c=relaxed/simple;
	bh=hkNoVgg/s16Yvv+JgdnS3mrdqjwPqt8dZTRUoWVH0HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdnHOu1l88vuKrMnbT7mQ6auHHM3BmHup883gybx0KHlDsV+QJx0JhUp8v+isNUl+iaNJn9E9HcygmPRLkbcMsyUyFtisT3GQz8yWZrcMPZjf5mJtAF/PuCdEL6pEEp1QG/3IvrI29uTSYe8flFlMaObO+IQ2RK0ZaXMpJgoHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOw6KgVw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so5394345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709194339; x=1709799139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fL2ppWiNvWh5i4XwlQmZabTMeBWWyC5WjuRP+1u4wQE=;
        b=dOw6KgVwELpncbuyIwR3KA0mx1xGCFVgQFRUEdtVjJ70s27tO3jkfS2mZO65+eh3/G
         NwbR/VxjYOrNtvqoeoAwwpyFw40qslJCffMeaQvGXz9ffIDxc9bKPVzPbrHSEuwkd8bT
         pOLfc/LZvgGzbLn+5NqTDjaDfa11XpOqk7oSXoKEHfuSHbTJCpeIfAa9kVrb8/sWq8DI
         H7CYTFTt4bbd56T8T238mk0qFewed7aOCk2B5o/CpqfP0juIzVfeuetbXpvSgHZ1+Dz9
         kvAg+OxLuMOQkFqri5qPk5FYDg2ohebbQ4FlmeKVDNT0hPzp6P6nZFFT+BD0c9iOAuaW
         posg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194339; x=1709799139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fL2ppWiNvWh5i4XwlQmZabTMeBWWyC5WjuRP+1u4wQE=;
        b=QldlegXrJUkdEkMTpPb7sAJa1+2cLL9UUsmHb0MQI6P+HtjB/oTLhS8JFg/hDme2Rh
         +xgBJcsLWVcfMoTvLJTy6dwyaIf8bq+eMPUFYxhrDYzBxJy91t1lc9CgEltOynnf6BX+
         1eyUElnPDeyp5/dD8Wrh6m2Fq++Pgbauo++wylyFeAoBinJNi92CDE/cUMEDQ4tFGmr0
         IdLobhAySje8tcF46OlyMlq+qrrtSCO4vdFPjUcnoAQ1SeTaLiqVnvb2uNKunJ1RrnC0
         UY/PpztIeXno+XIMFDSLiulTOEJ8D+UlrELafyLGST08UaMPXON+DrZGZrnjzOA2DO8Q
         IVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfJ6eRlY7r+Z/e+2maphGqSJFs6IX4a1fU1CK/FB7acy00tz9AtSGsBghkCR4S83MqA6wDkMph/w+R0gQBIKCAtEfWur8z9cKClVWn
X-Gm-Message-State: AOJu0YxuxAu6Ec5T/KjPn/AtPxxe52ThRXTublo8OaDMeE/U9UVdLHOs
	IoZi1ZBnKGQFR4KG/0bthV28xQZvZGC0q5kLYBVY7EEOUUz5rKyPsdAoKGK8unw=
X-Google-Smtp-Source: AGHT+IHnUsF+3dAIEpXcDmeHdire3xJOHx1UF2DJ1pIGXDkG1kh/CZYK/U94b3pDJNDqCv2cx4wyhQ==
X-Received: by 2002:a17:903:1c3:b0:1dc:b887:35bd with SMTP id e3-20020a17090301c300b001dcb88735bdmr1953757plh.5.1709194338594;
        Thu, 29 Feb 2024 00:12:18 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b001d8f111804asm803441plc.113.2024.02.29.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:12:17 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
	Roman Stratiienko <r.stratiienko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
Date: Thu, 29 Feb 2024 13:42:07 +0530
Message-Id: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offlining a CPU and bringing it back online is a common operation and it
happens frequently during system suspend/resume, where the non-boot CPUs
are hotplugged out during suspend and brought back at resume.

The cpufreq core already tries to make this path as fast as possible as
the changes are only temporary in nature and full cleanup of resources
isn't required in this case. For example the drivers can implement
online()/offline() callbacks to avoid a lot of tear down of resources.

On similar lines, there is no need to unregister the cpufreq cooling
device during suspend / resume, but only while the policy is getting
removed.

Moreover, unregistering the cpufreq cooling device is resulting in an
unwanted outcome, where the system suspend is eventually aborted in the
process.  Currently, during system suspend the cpufreq core unregisters
the cooling device, which in turn removes a kobject using device_del()
and that generates a notification to the userspace via uevent broadcast.
This causes system suspend to abort in some setups.

This was also earlier reported (indirectly) by Roman [1]. Maybe there is
another way around to fixing that problem properly, but this change
makes sense anyways.

Move the registering and unregistering of the cooling device to policy
creation and removal times onlyy.

Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
Link: https://patchwork.kernel.org/project/linux-pm/patch/20220710164026.541466-1-r.stratiienko@gmail.com/ [1]
Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..4133c606dacb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1571,7 +1571,8 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver))
+	/* Register cpufreq cooling only for a new policy */
+	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1655,11 +1656,6 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	else
 		policy->last_policy = policy->policy;
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
-		cpufreq_cooling_unregister(policy->cdev);
-		policy->cdev = NULL;
-	}
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
@@ -1720,6 +1716,15 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		return;
 	}
 
+	/*
+	 * Unregister cpufreq cooling once all the CPUs of the policy are
+	 * removed.
+	 */
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+
 	/* We did light-weight exit earlier, do full tear down now */
 	if (cpufreq_driver->offline)
 		cpufreq_driver->exit(policy);
-- 
2.31.1.272.g89b43f80a514


