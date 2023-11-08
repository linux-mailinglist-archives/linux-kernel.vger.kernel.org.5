Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100DC7E4FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjKHFDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHFDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:03:52 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D59E193;
        Tue,  7 Nov 2023 21:03:50 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f084cb8b54so3119756fac.1;
        Tue, 07 Nov 2023 21:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699419829; x=1700024629;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mXIe3ow1mFEMt04rvTqBGGASGscS5l/XOeHbFK93js=;
        b=Yr96nqVp7B1aLdDOSTrWLLMgdSZpJLSbQkZk6YwX/a4y759L8DA0hPhFnknUdjkHSV
         X04rfk7X/BExrT8+kFHWg/e2m4kDpu7NzqcNoF/wNV/EQaeFn4wTHdqJQ/sUPFJTl/hB
         qPAuJxIfKtRgltNk+aDiO/xgQ2ZaM8HBiIDghzlPGAl4v/n4TdNqVO31n5uMoYy0L9SU
         ZqY1DnVd5/gLVB553ZuGkuONRIR1MsU6uTFC8Vk2pCm5dSG0zexwcBW6S1E2gQJzJT2y
         U6ltSm4ZVmvYz3SsXmND3YveBXVBKM0L6CpXiJygsiXCaqDf9xf3bJjVtT6s8wZ8xjei
         oVjw==
X-Gm-Message-State: AOJu0YyNDB6dE5gnT8/hbjd4v8QI25DUBMYdd6SnG6KfVjY1rSV9f88w
        oi5DVKTH3lzouDjF6Xnbr+IUB6/2vbVyBOiGscFKLGYtcNg=
X-Google-Smtp-Source: AGHT+IGobaHBjxJLeayKmXGfu42hh/r4EY3452A+r0Rm+imGMJdTaYEM+XIsp7nExNHYn72iv24l8Ob10tzwet5DPzQ=
X-Received: by 2002:a05:6870:1699:b0:1e9:bba3:4902 with SMTP id
 j25-20020a056870169900b001e9bba34902mr709700oae.37.1699419829348; Tue, 07 Nov
 2023 21:03:49 -0800 (PST)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 8 Nov 2023 00:03:38 -0500
Message-ID: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
Subject: [GIT PULL] turbostat for Linux-6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these turbostat patches.

Turbostat features are now table-driven (Rui Zhang)
Add support for some new platforms (Sumeet Pawnikar, Rui Zhang)
Gracefully run in configs when CPUs are limited (Rui Zhang, Srinivas Pandruvada)
misc minor fixes.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to b8337e6a780dad9505f9d44da07c0a5c52fa0a04:

  tools/power turbostat: version 2023.11.07 (2023-11-07 23:28:30 -0500)

----------------------------------------------------------------
Chen Yu (1):
      tools/power/turbostat: Enable the C-state Pre-wake printing

Len Brown (2):
      tools/power/turbostat: bugfix "--show IPC"
      tools/power turbostat: version 2023.11.07

Srinivas Pandruvada (1):
      tools/power/turbostat: Move process to root cgroup

Sumeet Pawnikar (2):
      tools/power/turbostat: Add initial support for ArrowLake
      tools/power/turbostat: Add initial support for LunarLake

Zhang Rui (80):
      tools/power/turbostat: Fix failure with new uncore sysfs
      tools/power/turbostat: Fix a knl bug
      tools/power/turbostat: Enable TCC Offset on more models
      tools/power/turbostat: Support alternative graphics sysfs knobs
      tools/power/turbostat: Replace raw value cpu model with Macro
      tools/power/turbostat: Remove redundant duplicates
      tools/power/turbostat: Remove pseudo check for two models
      tools/power/turbostat: Add skeleton support for table driven
feature enumeration
      tools/power/turbostat: Abstract MSR_MISC_FEATURE_CONTROL support
      tools/power/turbostat: Abstract MSR_MISC_PWR_MGMT support
      tools/power/turbostat: Abstract BCLK frequency support
      tools/power/turbostat: Abstract Package cstate limit decoding support
      tools/power/turbostat: Abstract Nehalem MSRs support
      tools/power/turbostat: Remove a redundant check
      tools/power/turbostat: Rename some functions
      tools/power/turbostat: Abstract Turbo Ratio Limit MSRs support
      tools/power/turbostat: Rename some TRL functions
      tools/power/turbostat: Abstract Config TDP MSRs support
      tools/power/turbostat: Abstract TCC Offset bits support
      tools/power/turbostat: Abstract Perf Limit Reasons MSRs support
      tools/power/turbostat: Abstract Automatic Cstate Conversion support
      tools/power/turbostat: Abstract hardcoded Crystal Clock frequency
      tools/power/turbostat: Redefine RAPL macros
      tools/power/turbostat: Simplify the logic for RAPL enumeration
      tools/power/turbostat: Abstract RAPL MSRs support
      tools/power/turbostat: Abstract Per Core RAPL support
      tools/power/turbostat: Abstract RAPL divisor support
      tools/power/turbostat: Abstract fixed DRAM Energy unit support
      tools/power/turbostat: Abstract hardcoded TDP value
      tools/power/turbostat: Remove unused family/model parameters for
RAPL functions
      tools/power/turbostat: Abstract TSC tweak support
      tools/power/turbostat: Add skeleton support for cstate enumeration
      tools/power/turbostat: Adjust cstate for models with .has_nhm_msrs set
      tools/power/turbostat: Adjust cstate for has_snb_msrs() models
      tools/power/turbostat: Adjust cstate for models with .cst_limit set
      tools/power/turbostat: Adjust cstate for has_snb_msrs() models
      tools/power/turbostat: Adjust cstate for has_slv_msrs() models
      tools/power/turbostat: Adjust cstate for is_jvl() models
      tools/power/turbostat: Adjust cstate for is_dnv() models
      tools/power/turbostat: Adjust cstate for is_skx()/is_icx()/is_spr() models
      tools/power/turbostat: Adjust cstate for is_bdx() models
      tools/power/turbostat: Adjust cstate for has_c8910_msrs() models
      tools/power/turbostat: Adjust cstate for
is_slm()/is_knl()/is_cnl()/is_ehl() models
      tools/power/turbostat: Use fine grained IRTL output
      tools/power/turbostat: Abstract IRTL support
      tools/power/turbostat: Abstract MSR_CORE_C1_RES support
      tools/power/turbostat: Abstract MSR_MODULE_C6_RES_MS support
      tools/power/turbostat: Abstract MSR_CC6/MC6_DEMOTION_POLICY_CONFIG support
      tools/power/turbostat: Abstract MSR_ATOM_PKG_C6_RESIDENCY support
      tools/power/turbostat: Abstract MSR_KNL_CORE_C6_RESIDENCY support
      tools/power/turbostat: Abstract extended cstate MSRs support
      tools/power/turbostat: Abstract aperf/mperf multiplier support
      tools/power/turbostat: Abstract cstate prewake bit support
      tools/power/turbostat: Delete intel_model_duplicates()
      tools/power/turbostat: Improve probe_platform_features() logic
      tools/power/turbostat: Relocate cstate probing code
      tools/power/turbostat: Relocate pstate probing code
      tools/power/turbostat: Rename uncore probing function
      tools/power/turbostat: Rename rapl probing function
      tools/power/turbostat: Relocate graphics probing code
      tools/power/turbostat: Relocate lpi probing code
      tools/power/turbostat: Relocate thermal probing code
      tools/power/turbostat: Reorder some functions
      tools/power/turbostat: Relocate more probing related code
      tools/power/turbostat: Introduce probe_pm_features()
      tools/power/turbostat: Enable MSR_CORE_C1_RES on recent Intel
client platforms
      tools/power/turbostat: Remove PC7/PC9 support on ADL/RPL
      tools/power/turbostat: Introduce cpu_allowed_set
      tools/power/turbostat: Obey allowed CPUs when accessing CPU counters
      tools/power/turbostat: Obey allowed CPUs during startup
      tools/power/turbostat: Abstract several functions
      tools/power/turbostat: Obey allowed CPUs for primary thread/core detection
      tools/power/turbostat: Obey allowed CPUs for system summary
      tools/power/turbostat: Handle offlined CPUs in cpu_subset
      tools/power/turbostat: Abstrct function for parsing cpu string
      tools/power/turbostat: Handle cgroup v2 cpu limitation
      tools/power/turbostat: Add MSR_CORE_C1_RES support for spr_features
      tools/power/turbostat: Add initial support for GraniteRapids
      tools/power/turbostat: Add initial support for SierraForest
      tools/power/turbostat: Add initial support for GrandRidge

 tools/power/x86/turbostat/turbostat.c | 3074 ++++++++++++++++-----------------
 1 file changed, 1537 insertions(+), 1537 deletions(-)
