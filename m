Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F407E88F6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjKKDjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjKKDjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:39:19 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836761FEF;
        Fri, 10 Nov 2023 19:39:16 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1e9a757e04eso1934289fac.0;
        Fri, 10 Nov 2023 19:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699673956; x=1700278756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahlpqsctH1VRnueWF+JaC2Li/R0xH14IQP2HTxHkR4Y=;
        b=gBHKD3ej76E9MQMEVdIAcww4YTQY9kPHOcsfA4ubHzbolmIS8JBset0yJOIFDMNj/k
         +JNsOOD3489AeREu6nSvXWZtP4B2A6DlVcmT0tX7/S078LA+AOpria+h1v7ORt9x44FB
         TJRtszSiC/1oArGm6Ph9WQR0alMMzJvqkrCC3oGCIMNeXauHnS4vkybsg2R+hBbOh2/0
         L5eG8OzuJHA0hJc4DVe+2gOG1L3SIXOBK5PY3kj/TwwMsyeTM6ssDxqexZmydYU/iHaF
         +qkOcIRQ8LBjUsz4ndtbK0tIGwIqtqzD6Tri32zGn4ekUK3XtSgIQt/t4B96Hh1xzpp0
         bTiQ==
X-Gm-Message-State: AOJu0YwxYpuE9JAW6aGvVLbt8gXJM9f/0qYVF/XK1jvIGHCoDcZ+CB5i
        y5DVUFzTQ6Kaa1VvYzny6vadpGTAr0H7zX2W7SfAYgpI
X-Google-Smtp-Source: AGHT+IEu/KIseL3eYLtC3vD7pzVOV4vETyO5SV7cuz2l+hRsngOBkiJy6qW7p2MymEHXrvHUUix5Q3a9NDmdSYikGrg=
X-Received: by 2002:a05:6870:c69c:b0:1e9:dfe6:38b4 with SMTP id
 cv28-20020a056870c69c00b001e9dfe638b4mr470115oab.15.1699673955808; Fri, 10
 Nov 2023 19:39:15 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
 <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
In-Reply-To: <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 10 Nov 2023 22:39:04 -0500
Message-ID: <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
Subject: [GIT PULL] turbostat for Linux-6.7 (with signed tag)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

(Same code as previous pull request, with addition of a signed tag.
 Hopefully it verifies okay at your end.)

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
