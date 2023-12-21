Return-Path: <linux-kernel+bounces-8646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22181BA96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4FC28AD66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A77539F4;
	Thu, 21 Dec 2023 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QggNSoTd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B647360AD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c31f18274so11455655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172251; x=1703777051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XnYWAWl26fljdZ1eq0DEOr8xRmoWq9IceEo0OwSXEM=;
        b=QggNSoTdaYxq6TU52fd+iZ0QgGGxnXa5MzBPetB2T6yNaQ9CJjxWSGTreX9zZQTmAm
         +LpTVF/Ju8qtYCcM/w79mtsPCVjKDDsTRy2nCkkf0Ff83OjBrmJZlA68rUZqsl9lPJR8
         sK3FHAkUfoc/9xR1TPtWSGkEP2QGsMDX7J+GTV3+ppEUmGRpLE6s5xdMF27+45tvnyd9
         8CDepM0xiobzvOIpL34qXyXMXKlYPbV5mvMIgoYGDlKHUfHuJ336tb6xa5erTwwx2Es8
         x76cldVkhK6ZET+KWP67ceCp0zfVu171c3vas+D71REVpSyUJXWGeFA4+JUad3C5jmMb
         l0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172251; x=1703777051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XnYWAWl26fljdZ1eq0DEOr8xRmoWq9IceEo0OwSXEM=;
        b=GaGqmffNdpehPExuQUHj3NiDPSzAPEz0ZHYK+b4v3Wd78wl8FdaItg+wF5Vxl/5o5h
         b0c0iRFlfatYYKscWDN9RR40KbNQBAgfa7Cq8S9SxMYhynMmKkc8GqNuBAKkOYlBmgz3
         ATMPT137tUtPq05EMuzbZFiMg9gyTqr+WvJZju8oX/WsgJMSg7ZU64LQqcodkbc4JCwo
         rguoBCFQOol2eWKAK+zEWEFRcAi1i/VgK/i1aG6lFhlX8vUqJK/6W9hWRSNFb/e0gk+b
         RZ5zPAOJtLbcJNHh6GuDG0kzyw6ZBYZkdfsgXx6Hp0s89bW97EV7aniD3HAgH7JNJq0y
         YI8g==
X-Gm-Message-State: AOJu0Yxtf0p0No1a5fDWK3nURXTO14HD8mD7+mnIBs+99NPfjy6fTEXR
	unMI3+/2HADragBHNgKeS9QMAg==
X-Google-Smtp-Source: AGHT+IGHy1A1RTCdL6pRPW1PyWOXhl6RuneTu+2GCu8vndp3F2NPHNxrmP0VXwZLO7mpsjJUq7SHGA==
X-Received: by 2002:a1c:7411:0:b0:40d:177e:c024 with SMTP id p17-20020a1c7411000000b0040d177ec024mr840724wmc.187.1703172250872;
        Thu, 21 Dec 2023 07:24:10 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2db4:9d2a:db65:42d6])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm11466974wmo.19.2023.12.21.07.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:24:10 -0800 (PST)
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
Subject: [PATCH v2 0/5] Rework system pressure interface to the scheduler
Date: Thu, 21 Dec 2023 16:24:02 +0100
Message-Id: <20231221152407.436177-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the consolidation and cleanup of CPU capacity in [1], this serie
reworks how the scheduler gets the pressures on CPUs. We need to take into
account all pressures applied by cpufreq on the compute capacity of a CPU
for dozens of ms or more and not only cpufreq cooling device or HW
mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
- one from cpufreq and freq_qos
- one from HW high freq mitigiation.

The next step will be to add a dedicated interface for long standing
capping of the CPU capacity (i.e. for seconds or more) like the
scaling_max_freq of cpufreq sysfs. The latter is already taken into
account by this serie but as a temporary pressure which is not always the
best choice when we know that it will happen for seconds or more.

[1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/

Change since v1:
- Use struct cpufreq_policy as parameter of cpufreq_update_pressure()
- Fix typos and comments
- Make sched_thermal_decay_shift boot param as deprecated

Vincent Guittot (5):
  cpufreq: Add a cpufreq pressure feedback for the scheduler
  sched: Take cpufreq feedback into account
  thermal/cpufreq: Remove arch_update_thermal_pressure()
  sched: Rename arch_update_thermal_pressure into
    arch_update_hw_pressure
  sched/pelt: Remove shift of thermal clock

 .../admin-guide/kernel-parameters.txt         |  1 +
 arch/arm/include/asm/topology.h               |  6 +-
 arch/arm64/include/asm/topology.h             |  6 +-
 drivers/base/arch_topology.c                  | 26 ++++----
 drivers/cpufreq/cpufreq.c                     | 34 ++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
 drivers/thermal/cpufreq_cooling.c             |  3 -
 include/linux/arch_topology.h                 |  8 +--
 include/linux/cpufreq.h                       | 10 +++
 include/linux/sched/topology.h                |  8 +--
 .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
 include/trace/events/sched.h                  |  2 +-
 init/Kconfig                                  | 12 ++--
 kernel/sched/core.c                           |  8 +--
 kernel/sched/fair.c                           | 63 +++++++++----------
 kernel/sched/pelt.c                           | 18 +++---
 kernel/sched/pelt.h                           | 16 ++---
 kernel/sched/sched.h                          | 22 +------
 18 files changed, 142 insertions(+), 119 deletions(-)
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)

-- 
2.34.1


