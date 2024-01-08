Return-Path: <linux-kernel+bounces-19643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2112827033
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88F21C22930
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A594596D;
	Mon,  8 Jan 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni9Y6ind"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFB45945
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eabd1c701so2100283e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 05:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704721727; x=1705326527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3x2TdodL+Fcapt/Lz+/UzPzH9/xPlS0RgAh88kWjJrE=;
        b=ni9Y6indTFLW4HjOoRre86ECBsygbT1d/sQ75lAMHQYJEw0ZtRmix3ke/qIUqdOq9P
         wAO4ULL41UN1X70RbmuvKJQDzlHvssLK00B7dqTVD0znZfmmEGd9uTWV+Dmq4+HiTcrL
         mp/DML+fK9u9oj/EwxZugoHykEugTvEq9H6Rh+bwWPPE2F3AGWbrI1eqEJbz5hEG+uVJ
         MmTs7DdGY0rY98AT/AAhLLDmC1R8P3CBSi2D2U6ADNpM3V9pV6fLQFUQixh/j/Kgiija
         rgD7MGKeoQYX53IkqcbkAzOHfaylQJMIvXrCLfamKAMGDubDs38H6lGqN01uDKJc5Wzi
         TAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721727; x=1705326527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x2TdodL+Fcapt/Lz+/UzPzH9/xPlS0RgAh88kWjJrE=;
        b=JLz59xPvOk41rIg6LqQpVSUXbC3CgAov2rLoRDH0ZX57teazMVT1Aps2EY95qvjZhk
         On4B5KxQ7eZWkoW0tleiYFn16mloMBmVwT8i0aOje5QAVRhvNoliCa+BnINk7zB0+Jfz
         Q/JzkiVt7yDvCZpqn2K/SZmybIEEn8ejh2L7ygy2Mof3IGLU6aker6uImXf9xfIQcuqH
         lq3XqbGPHwSnH/DlKxz1c0Tj+ASf3rpk4msVzVPm0I8+CLo/yk1PWJzScgHBDH2ujtPB
         vACIJthCHnH/iLv0uAb+VGORHI++IZTFdXJ1A8lNo5aswJQdDQbTaq0Igc8+VKI17kNc
         tUmQ==
X-Gm-Message-State: AOJu0YyFJEKo2F2R6onsphXvQ8NKfZuRyA1qOcxIuRCA2OxVchlsQxtp
	AWSxoktg9ZFBFvRINQPWV7g/7gxJmurEuA==
X-Google-Smtp-Source: AGHT+IF8wvH8PrEkvaQ5eneyPSBxwlk4AX9BIBBL2hHuP2Fx1us01yJftrMyoHDAiZOd2XE/MC7YJA==
X-Received: by 2002:a05:6512:318e:b0:50e:7a9e:5c1d with SMTP id i14-20020a056512318e00b0050e7a9e5c1dmr1884615lfe.0.1704721726995;
        Mon, 08 Jan 2024 05:48:46 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:53aa:59bc:34ea:bb2c])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c3ba200b0040d5b984668sm11165003wms.9.2024.01.08.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:48:46 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
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
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: qyousef@layalina.io,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/5] Rework system pressure interface to the scheduler
Date: Mon,  8 Jan 2024 14:48:38 +0100
Message-Id: <20240108134843.429769-1-vincent.guittot@linaro.org>
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
- Rework cpufreq_update_pressure()

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
 drivers/cpufreq/cpufreq.c                     | 36 +++++++++++
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
 18 files changed, 144 insertions(+), 119 deletions(-)
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)

-- 
2.34.1


