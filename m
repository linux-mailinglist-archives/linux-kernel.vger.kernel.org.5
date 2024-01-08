Return-Path: <linux-kernel+bounces-19459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09A826D35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB701C22220
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B1219E2;
	Mon,  8 Jan 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRktUcaS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CE2575A;
	Mon,  8 Jan 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55753dc5cf0so1978262a12.0;
        Mon, 08 Jan 2024 03:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704715008; x=1705319808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=C3jG1+g9orZDYd7ZrTJDWqqE7ECfbqn0Ds9F5CofQDU=;
        b=JRktUcaSPjA7qWP9BdYV+v1ipsl6xKpJCF4NnkXssLwwTEnXdZVkVA6SW3/AVHSOk4
         r96qBzCFW7ykV0AG9PwXQrgYdYa9LAupPO7gWgFEGU1LiPbXo5Sd5rbBGaM3sM0Tjtnp
         mQ4Z2ZLQqu88zh18E6bjKgTVZkolj2kk23nnh0WfMzhE0p5JzhD0rZZP8KF9qE/SRaLm
         0kdykSVwlKoT7kfnwZupSz6mAioZChGgXBp8Ph8kj5GPREvBM8vaG7clsdSn8tN3KQlS
         5Oli9UXXLMIIB7nYcEMYeK6O0yb4PxDuhgUTlAzlI8IoydCFAASK3TvDNilPM2UGx/dq
         XaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715008; x=1705319808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3jG1+g9orZDYd7ZrTJDWqqE7ECfbqn0Ds9F5CofQDU=;
        b=fWSFxPOzPlWn9mlrtb9QkwiimfXUCs0nlgRtDpGxmxl7X6Nt/FeFLlP74mIbKcO0ud
         zqDdIps4PkGEsuC04Bj997V6/i4ENcOROhbIYNMFBT2V4FiB5BxT7LEQTQiu2l5V3BID
         mAKsebSb56vuUBp5bDOruW0PHni/3uUJNw+fguXANHtG/+qJuDuo4clEBtyxl7qeGI9R
         i/+GExdbAe4YoGZPm3+jf4s64WyyOPqZlygYu9UU/VV0fpXpDSPaE5/b2UHrvy/S/+Wj
         GwjYjyTLEmJP/vuGyHB3mTngV7/6zaUSe+gkE0Xg1On0rInud4or+2gFzrs6gzzrjmoq
         MCoA==
X-Gm-Message-State: AOJu0Yz/TtEWpihKI7BCgHzrws2TPlOT5+QMlMzcyeTdndWfaXzRBdLl
	EmknPjDkndfXNRfrK5Rukgk=
X-Google-Smtp-Source: AGHT+IGy21YwV3E1QafQojen3DyVqfppJ4D76r3UB+dxIfeD0HkrBsUD3Khz9wpI/ph4CzMSw1ec0w==
X-Received: by 2002:a17:906:859:b0:a27:7075:7613 with SMTP id f25-20020a170906085900b00a2770757613mr1417201ejd.67.1704715007931;
        Mon, 08 Jan 2024 03:56:47 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709061f5400b00a2b086c29e1sm146372ejk.127.2024.01.08.03.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:56:47 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:56:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] Performance events changes for v6.8
Message-ID: <ZZvi/bFoxFRnS4vp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-01-08

   # HEAD: fdd041028f2294228e10610b4fca6a1a83ac683d perf/x86/intel/uncore: Factor out topology_gidnid_map()

Performance events changes for v6.8 are:

 - Add branch stack counters ABI extension to better capture
   the growing amount of information the PMU exposes via
   branch stack sampling. There's matching tooling support.

 - Fix race when creating the nr_addr_filters sysfs file

 - Add Intel Sierra Forest and Grand Ridge intel/cstate
   PMU support.

 - Add Intel Granite Rapids, Sierra Forest and Grand Ridge
   uncore PMU support.

 - Misc cleanups & fixes.

 Thanks,

	Ingo

------------------>
Alexander Antonov (2):
      perf/x86/intel/uncore: Fix NULL pointer dereference issue in upi_fill_topology()
      perf/x86/intel/uncore: Factor out topology_gidnid_map()

Greg KH (1):
      perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Kan Liang (14):
      perf: Add branch stack counters
      perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag
      perf: Add branch_sample_call_stack
      perf/x86/intel: Reorganize attrs and is_visible
      perf/x86/intel: Support branch counters logging
      perf/x86/intel/cstate: Cleanup duplicate attr_groups
      x86/smp: Export symbol cpu_clustergroup_mask()
      perf/x86/intel/cstate: Add Sierra Forest support
      perf/x86/intel/cstate: Add Grand Ridge support
      perf/x86/intel/uncore: Generic uncore_get_uncores and MMIO format of SPR
      perf/x86/uncore: Use u64 to replace unsigned for the uncore offsets array
      perf/x86/intel/uncore: Support Granite Rapids
      perf/x86/intel/uncore: Support IIO free-running counters on GNR
      perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge

Namhyung Kim (1):
      perf/x86/amd: Reject branch stack for IBS events

Peter Zijlstra (1):
      perf: Fix the nr_addr_filters fix


 .../testing/sysfs-bus-event_source-devices-caps    |   6 +
 arch/powerpc/perf/core-book3s.c                    |   2 +-
 arch/x86/events/amd/core.c                         |   2 +-
 arch/x86/events/amd/ibs.c                          |   3 +
 arch/x86/events/core.c                             |   4 +-
 arch/x86/events/intel/core.c                       | 145 +++++++++++---
 arch/x86/events/intel/cstate.c                     | 162 ++++++++++++----
 arch/x86/events/intel/ds.c                         |   4 +-
 arch/x86/events/intel/lbr.c                        |  85 ++++++++-
 arch/x86/events/intel/uncore.c                     |  12 ++
 arch/x86/events/intel/uncore.h                     |  10 +-
 arch/x86/events/intel/uncore_discovery.c           |   5 +-
 arch/x86/events/intel/uncore_discovery.h           |   2 +-
 arch/x86/events/intel/uncore_nhmex.c               |   2 +-
 arch/x86/events/intel/uncore_snbep.c               | 208 ++++++++++++++++-----
 arch/x86/events/perf_event.h                       |  12 ++
 arch/x86/events/perf_event_flags.h                 |   2 +
 arch/x86/include/asm/msr-index.h                   |   5 +
 arch/x86/include/asm/perf_event.h                  |   4 +
 arch/x86/kernel/smpboot.c                          |   1 +
 include/linux/perf_event.h                         |  22 ++-
 include/uapi/linux/perf_event.h                    |  13 ++
 kernel/events/core.c                               |  46 +++--
 23 files changed, 627 insertions(+), 130 deletions(-)

