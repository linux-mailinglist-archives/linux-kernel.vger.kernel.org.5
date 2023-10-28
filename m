Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDC7DA6C6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjJ1Lwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1Lwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:52:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB158E5;
        Sat, 28 Oct 2023 04:52:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso6050683a12.0;
        Sat, 28 Oct 2023 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698493948; x=1699098748; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=p3yIj4MxJoXsY1l5kfuXPltfXi7n2cDW+TvhlxHHneo=;
        b=FxvgljSvQ8psX1UckB7hjvfbqs0MJRtq1080LHTrJnxJdgcdq5Puf3O1TgryqCh48U
         VB0txuFPFKdZUam2whF4g6HELs9/dgYfVgPtyT9flcUocYuQEJbVUt0tnazmAy2mh8+d
         2pYE6oEW9yp938OrZXY7iJJnZZtZJIcs25TdBDS/qg4JT3IpS6yFvXMQTUgTw8Aq0+5P
         ai60d92Umoi7CFFeVArGT3QYfHBSW/JZ7HidxxEz/OcFcCRTAWVtUlm11wvO+lXZz13Q
         dg5cQPZv5kEimNpOF9rs0aMaumXxnSnLAuOmL5i3vEWtQsDf9DV66Pvx+Czox0VetptF
         ORjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698493948; x=1699098748;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3yIj4MxJoXsY1l5kfuXPltfXi7n2cDW+TvhlxHHneo=;
        b=IqAZ2MQtuXvFHM+aRCrYKx9qrzqu6laGO8U3KEW/m0Rw+ALGUYzH+BMbW2AHP2a1GK
         HECgmwXdJONrvJmqtN0tUga7hZ4JmZBTWltuvLPoTZe6s1lEUTU0lzTo2FCY4h/NpAKo
         K1arSXOLN8b7oTKxLfMDMZICPZi1+iE7SsFuLjx47OuAbZhj/a57EBepyhakUZi3EtvE
         OJcdu9oP7IewV8jQpQkw6TQCTZ/v9ocqvOo2LApxbyL8226v/ulQurU3u0r5FrI4tpmc
         AOE+oF/djkqfuLjV028HGDlW2eaO964HQ5i/AYCPuDoQWAW8nRNKfMEIuS9/rGxHK5IX
         JaNg==
X-Gm-Message-State: AOJu0YxstIRscRjnNR60hiTUvEcI8UJaihcf1Bnpc/TfVVY6E7VNqpAR
        4E1SyZPWoof2vTDWa6l3xSg=
X-Google-Smtp-Source: AGHT+IFI4uOcehhO9ugmzK7w9JyCtkm9OUmjHyfrjWIVOr/Mw3yrwtRU7RI6idUUbAr4H2+uleKffg==
X-Received: by 2002:aa7:c912:0:b0:530:ec02:babd with SMTP id b18-20020aa7c912000000b00530ec02babdmr7645910edt.9.1698493948071;
        Sat, 28 Oct 2023 04:52:28 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id 22-20020a508e56000000b00542db304680sm904386edx.63.2023.10.28.04.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 04:52:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 13:52:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events changes for v6.7
Message-ID: <ZTz194jcY008KDCm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-10-28

   # HEAD: 744940f1921c8feb90e3c4bcc1e153fdd6e10fe2 perf/x86/amd/uncore: Pass through error code for initialization failures, instead of -ENODEV

Performance events changes for v6.7 are:

 - Add AMD Unified Memory Controller (UMC) events introduced with Zen 4
 - Simplify & clean up the uncore management code
 - Fall back from RDPMC to RDMSR on certain uncore PMUs
 - Improve per-package and cstate event reading
 - Extend the Intel ref-cycles event to GP counters
 - Fix Intel MTL event constraints
 - Improve the Intel hybrid CPU handling code
 - Micro-optimize the RAPL code
 - Optimize perf_cgroup_switch()
 - Improve large AUX area error handling

 - Misc fixes and cleanups

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/cpu: Fix the AMD Fam 17h, Fam 19h, Zen2 and Zen4 MSR enumerations

Dan Carpenter (1):
      perf/x86/amd/uncore: Fix uninitialized return value in amd_uncore_init()

David Reaver (1):
      perf/x86/rapl: Fix "Using plain integer as NULL pointer" Sparse warning

Kan Liang (8):
      perf/x86/intel: Use the common uarch name for the shared functions
      perf/x86/intel: Factor out the initialization code for SPR
      perf/x86/intel: Factor out the initialization code for ADL e-core
      perf/x86/intel: Apply the common initialization code for ADL
      perf/x86/intel: Clean up the hybrid CPU type handling code
      perf/x86/intel: Add common intel_pmu_init_hybrid()
      perf/x86/intel: Fix broken fixed event constraints extension
      perf/x86/intel: Extend the ref-cycles event to GP counters

Kees Cook (1):
      perf/x86/rapl: Annotate 'struct rapl_pmus' with __counted_by

Lucy Mielke (1):
      perf/x86/intel/pt: Fix kernel-doc comments

Peter Zijlstra (1):
      perf: Optimize perf_cgroup_switch()

Sandipan Das (6):
      perf/x86/amd/uncore: Refactor uncore management
      perf/x86/amd/uncore: Move discovery and registration
      perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable
      perf/x86/amd/uncore: Add group exclusivity
      perf/x86/amd/uncore: Add memory controller support
      perf/x86/amd/uncore: Pass through error code for initialization failures, instead of -ENODEV

Shuai Xue (1):
      perf/core: Bail out early if the request AUX area is out of bound

Tero Kristo (2):
      perf/x86/cstate: Allow reading the package statistics from local CPU
      perf/core: Allow reading package events from perf_event_read_local

Uros Bizjak (2):
      perf/x86/rapl: Stop doing cpu_relax() in the local64_cmpxchg() loop in rapl_event_update()
      perf/x86/rapl: Use local64_try_cmpxchg in rapl_event_update()

Xiu Jianfeng (1):
      perf/core: Rename perf_proc_update_handler() -> perf_event_max_sample_rate_handler(), for readability


 arch/x86/events/amd/uncore.c      | 1116 ++++++++++++++++++++++++-------------
 arch/x86/events/core.c            |    6 +-
 arch/x86/events/intel/core.c      |  485 ++++++++--------
 arch/x86/events/intel/cstate.c    |    3 +
 arch/x86/events/intel/ds.c        |    4 +-
 arch/x86/events/intel/pt.c        |    8 +-
 arch/x86/events/perf_event.h      |   37 +-
 arch/x86/events/rapl.c            |   22 +-
 arch/x86/include/asm/msr-index.h  |   10 +-
 arch/x86/include/asm/perf_event.h |    9 +
 include/linux/perf_event.h        |    3 +-
 kernel/events/core.c              |  145 ++---
 kernel/events/ring_buffer.c       |    6 +
 kernel/sysctl.c                   |    2 +-
 14 files changed, 1130 insertions(+), 726 deletions(-)
