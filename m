Return-Path: <linux-kernel+bounces-8649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA981BAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D361F251B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C60758212;
	Thu, 21 Dec 2023 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzxHlVex"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1653A16
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d3dfcc240so7677605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172255; x=1703777055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldki2kQSS5xwW+AeQkZhBQ2GExVZGYy+iS8PnV7iC50=;
        b=GzxHlVexXHKRcy2Zi32FitmZ4c2krSVta8PMTb514OtM4O/0yrW3WDUNDa6pPusy4q
         KwkfNoJF7tyHWQT9d+F7VgbhaeTpUcIn9QeY49pjeRAy4AeDpgMypn60wpVj7CwHiNRU
         h8geFu/rAbkN423KWIttlJOyWREtPLxul7uh6j897Z4y1Z/l4UWA3o2RE7WMs3mVRcLo
         nlQKCun2H5Tp9Tdj274BKvDg37vdGMLhnij7VgjRDSU/PrxTIf4Bp0V49jxeJ2fNDc+x
         rX32NWOZRK80zrexUbpuaxARcAj3UX39TKoMwXKYlBOMTty0zfjaukvv2gkjmo5PVFgp
         enSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172255; x=1703777055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldki2kQSS5xwW+AeQkZhBQ2GExVZGYy+iS8PnV7iC50=;
        b=a8YPzBwaxeeAvQOkfNGACtG3bZ7eNX41wBpO3uDHBD7sLXg16/bRmysOIvyj0MqXt9
         jzprDD7lwSgq90NFb/pw78GIpU37OXwUNfUuGzDVStUbiul6KuGgcCwQObCBLApu+hS+
         s/grxEJ9empAvNilwhI6ieukz0kcC/30yiUCW4xj7lQRF/ravAhSe3OEVAn9kGP4PFTb
         X3ndpheTIDxF5FxVAeLZ15ozqqb7SZ0I/4HkKrB2q7DhvWOZsHkyJ4envJE2V6ppuo9h
         H7fGZoRWTdntbkOQR+bDFmykVbj2BYFf7k+riyQSIyF+/GuquSlxce4g15LTOX57vqBq
         Xejw==
X-Gm-Message-State: AOJu0Yy4udUhJQ1IQ6amX0NVH7mhtSJKPHpfJ3F96ZgLXEnYxJ40mHjR
	9FNKA3sQ5oewJI9Oy1yJrtebTQ==
X-Google-Smtp-Source: AGHT+IH+ssk4EbOp8vSgZen/OElcpPHfwMVCJP0+M/6mrBqydeBIQBk7E0Gi56kUk+RCd4jQuTRBBQ==
X-Received: by 2002:a05:600c:22c3:b0:40d:284a:6b6e with SMTP id 3-20020a05600c22c300b0040d284a6b6emr556980wmg.153.1703172255409;
        Thu, 21 Dec 2023 07:24:15 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2db4:9d2a:db65:42d6])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm11466974wmo.19.2023.12.21.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:24:14 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	linux@armlinux.org.uk,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/5] thermal/cpufreq: Remove arch_update_thermal_pressure()
Date: Thu, 21 Dec 2023 16:24:05 +0100
Message-Id: <20231221152407.436177-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221152407.436177-1-vincent.guittot@linaro.org>
References: <20231221152407.436177-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_update_thermal_pressure() aims to update fast changing signal which
should be averaged using PELT filtering before being provided to the
scheduler which can't make smart use of fast changing signal.
cpufreq now provides the maximum freq_qos pressure on the capacity to the
scheduler, which includes cpufreq cooling device. Remove the call to
arch_update_thermal_pressure() in cpufreq cooling device as this is
handled by cpufreq_get_pressure().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e2cc7bd30862..e77d3b44903e 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -448,7 +448,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	struct cpumask *cpus;
 	unsigned int frequency;
 	int ret;
 
@@ -465,8 +464,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
-		cpus = cpufreq_cdev->policy->related_cpus;
-		arch_update_thermal_pressure(cpus, frequency);
 		ret = 0;
 	}
 
-- 
2.34.1


