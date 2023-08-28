Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3078B9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjH1Uot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjH1Uol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:44:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3210D;
        Mon, 28 Aug 2023 13:44:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso34735195e9.0;
        Mon, 28 Aug 2023 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693255477; x=1693860277;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2FyVA2TlJZnmeF54TfcG2/RAnF7PPTQDQJw9GqMjnA=;
        b=SadDLLa9UbY1oVbjZzTDBurpQ52fU/61/LtXNWWptMCvrW9Cv4BIpdAAIBGMrkfpU/
         7J88bitMQ2bqpeCd1HlTVV3GNsYeC6ardz2sZM6KWnt5yQ9T168PDV0GuIAjGk4Nd3j+
         3OaTFsOdqa0yFFlwVjzKsWwcfqUI6P6ialhKomFik81PbGXbJPMlLvtW5OS2XwQDxIyQ
         8T0AwVJp/j2zdWZ8D1dqnioRtMkkj7J/Ej+5aXrCmC2ANtg3q7Ztzsg+bFnDAzERxGjq
         FEtyXV9BGV1qCmUerN1o2KOOd2vXWbC8WtzxjqejXfsoSGi7Tsx+iu+UtkxvVAqmJvK+
         IkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255477; x=1693860277;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2FyVA2TlJZnmeF54TfcG2/RAnF7PPTQDQJw9GqMjnA=;
        b=ejGKXG0ohllzYimCR20yO3/kr7nKoDC2SO549gcQWD3fAvQnIGD/K1fXVGkeCkuVxg
         T38WDLQegsP/j6h/0SskyT92l18lUeuKi8HgrXh/hJOZZVFH16LhfQdRqCrFZQvpbHUl
         +fHNPr1WGX70XLyffXX9xyaWwRUPAvnczpESN3wDetJdqn6oI8O9XBBqdQEbAqt8W35i
         H4r5icb43+hnxLUIfiLJESQCUOFl5/ZhofyE0jK9X8bAHuJxKgkl/w1Q3pcLaO66mB02
         sJA6XhiQMxfGe1gLbvVDkKV68RK+hNbgYda3VFix1pgmp9Gm76KnKHBcxjikh/s5chXL
         VKzg==
X-Gm-Message-State: AOJu0YxebYc2BqU5gbLxevD3IcWhVBldlY1Xe6p9ngoNEX2r9MKIfCHb
        l6sbY2yl4fUM/HfXeUcB5wprpT/7E4w=
X-Google-Smtp-Source: AGHT+IHVSlI1U5x+qxvq4TQ3s4a4KfBNbuOuwX4TBSW8f3Npk+xJoWCph0VLzn23LmuRgXj5cqrozA==
X-Received: by 2002:a1c:6a17:0:b0:401:b701:5424 with SMTP id f23-20020a1c6a17000000b00401b7015424mr6978403wmc.9.1693255477172;
        Mon, 28 Aug 2023 13:44:37 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fbb06af219sm11742064wmi.32.2023.08.28.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:44:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Aug 2023 22:44:34 +0200
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
Subject: [GIT PULL] perf event changes for v6.6
Message-ID: <ZO0HMo6QD+l/uvWz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-08-28

   # HEAD: 2c65477f14a359db9f1edee5dd8e683d3dae69e2 perf/x86/uncore: Remove unnecessary ?: operator around pcibios_err_to_errno() call

Perf events changes for v6.6:

- AMD IBS improvements
- Intel PMU driver updates
- Extend core perf facilities & the ARM PMU driver to better handle ARM big.LITTLE events
- Micro-optimize software events and the ring-buffer code
- Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Ilpo Järvinen (1):
      perf/x86/uncore: Remove unnecessary ?: operator around pcibios_err_to_errno() call

James Clark (4):
      arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
      perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
      arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
      perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability

Kan Liang (1):
      perf/x86/intel: Add Crestmont PMU

Namhyung Kim (1):
      perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src

Peter Zijlstra (3):
      x86/cpu: Fix Gracemont uarch
      x86/cpu: Fix Crestmont uarch
      x86/cpu: Update Hybrids

Ravi Bangoria (3):
      perf/amd: Prevent grouping of IBS events
      perf/mem: Introduce PERF_MEM_LVLNUM_UNC
      perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA

Uros Bizjak (4):
      perf/x86: Use local64_try_cmpxchg
      perf/core: Use local64_try_cmpxchg in perf_swevent_set_period
      locking/arch: Avoid variable shadowing in local_try_cmpxchg()
      perf/ring_buffer: Use local_try_cmpxchg in __perf_output_begin

YueHaibing (1):
      perf: Remove unused extern declaration arch_perf_get_page_size()


 arch/loongarch/include/asm/local.h                 |   4 +-
 arch/mips/include/asm/local.h                      |   4 +-
 arch/x86/events/amd/ibs.c                          | 190 +++++++++++----------
 arch/x86/events/core.c                             |  11 +-
 arch/x86/events/intel/core.c                       |  54 +++++-
 arch/x86/events/intel/cstate.c                     |  12 +-
 arch/x86/events/intel/ds.c                         |   9 +-
 arch/x86/events/intel/uncore.c                     |   2 +-
 arch/x86/events/intel/uncore_snbep.c               |   2 +-
 arch/x86/events/msr.c                              |  10 +-
 arch/x86/events/perf_event.h                       |   2 +
 arch/x86/events/rapl.c                             |   2 +-
 arch/x86/include/asm/intel-family.h                |  18 +-
 arch/x86/include/asm/local.h                       |   4 +-
 arch/x86/kernel/cpu/intel_epb.c                    |   2 +-
 arch/x86/mm/init.c                                 |   2 +-
 drivers/edac/i10nm_base.c                          |   2 +-
 drivers/idle/intel_idle.c                          |  10 +-
 drivers/perf/arm_pmu.c                             |  10 +-
 drivers/platform/x86/intel/pmc/core.c              |   2 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |   2 +-
 drivers/powercap/intel_rapl_common.c               |   2 +-
 drivers/powercap/intel_rapl_msr.c                  |   2 +-
 drivers/thermal/intel/intel_tcc_cooling.c          |   2 +-
 include/linux/perf_event.h                         |  14 +-
 include/uapi/linux/perf_event.h                    |   3 +-
 kernel/events/core.c                               |  18 +-
 kernel/events/ring_buffer.c                        |   5 +-
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 29 files changed, 230 insertions(+), 172 deletions(-)
