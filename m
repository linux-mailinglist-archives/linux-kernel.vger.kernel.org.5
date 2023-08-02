Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4076C7DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjHBIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjHBIEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:04:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B610DB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:04:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe110de3b6so3777915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690963442; x=1691568242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ/J00kEJAH5Xut374nMK9bufEJjwUvOp4VXeqDa+Tk=;
        b=TR4+KtOpPWWB7zMxB9PgPgMQ/dmKpI2IOf32w75D9jzFT4t3NfzAhSGg405n8kCuhn
         kyYUR4xFpYscU7oxOcPiJc2yOOlfvs9R4fNuiNBCQmV9beI/91TN+kKBuM5CI0EE8VBO
         vMHyHKRvn3MFWlA61V26A+Rzez+kE2tM2iMadEmGEeYqCOIHazGf32wjXpL/NVOu7Dps
         iJ2qq5Nn5iSwo9aR9TjLTcE+F1O+/en60hHyXmTZuO7Bt3BDY1tGvRzQETlyKtaTCMnY
         oZhJX722C9T9OKR3dBJH9VHSZYG/uY3H9NJNAbfFSAZBZ5dJrFpk3B4IiHaTcFimTrUV
         qTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963442; x=1691568242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ/J00kEJAH5Xut374nMK9bufEJjwUvOp4VXeqDa+Tk=;
        b=CzR5XYoueq/iKV0LJWtBg5vhuzcJM9FJIjejimfV2iPHlBMqV9ShcuTLts76HZ3/yr
         eBiYW72sPZTd+vXj7rYwQGEDf9/FjyplflFB+6ZTUueIIp6xxAQGpjBavbcbU5HbpdyB
         2FOpEWzjF8TUfV6+aBk5yt3B2axjlLKre/+IQ2yO8JgJYi2719x/mGRhVBbMqAblQpDB
         MMgM5O5i4v+kin+3wUX13A5CJrHOrP7QWRirvkkn1oWERouKh2/ebpEmZ7kD8hcOBAOq
         Zc8riUwmbxGYRQFDf3wDDKXDLpcGS8Vxbj947uq6X58ILr8Wtzk8XoCjuRtlFMLTnibA
         ++rA==
X-Gm-Message-State: ABy/qLZr6CY64chaWVOz+tT0C9rasqHiqcbsH0L1/F4EVXh3uNMitp+Q
        ZhjhiY35RJ7EpBNaYh2RLX6hgA==
X-Google-Smtp-Source: APBJJlGkfK1cMubjw5jAx7xv31P0b4h+hmVBpPD+Xx9CKLBF6Ee3UXefcdhFfKa5u+4OBBC3XEAG3Q==
X-Received: by 2002:a7b:c394:0:b0:3fe:1b5e:82 with SMTP id s20-20020a7bc394000000b003fe1b5e0082mr3691989wmj.20.1690963441714;
        Wed, 02 Aug 2023 01:04:01 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm18338098wrv.71.2023.08.02.01.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:04:01 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 00/10] riscv: Allow userspace to directly access perf counters
Date:   Wed,  2 Aug 2023 10:03:18 +0200
Message-Id: <20230802080328.1213905-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv used to allow direct access to cycle/time/instret counters,
bypassing the perf framework, this patchset intends to allow the user to
mmap any counter when accessed through perf.

**Important**: The default mode is now user access through perf only, not
the legacy so some applications will break. However, we introduce a sysctl
perf_user_access like arm64 does, which will allow to switch to the legacy
mode described above.

This version needs openSBI v1.3 *and* a kernel fix that went upstream lately
(https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/).

base-commit-tag: v6.5-rc1

Changes in v6:
- Replaced csr_read() preprocessor parsing of csr number with the
  input constraint, as suggested by Ian
- Added a defined(__riscv) and a comment to make things clearer, as
  suggested by Ian

Changes in v5:
- Fix typo from Atish
- Add RB from Atish and Andrew
- Improve cover letter and patch 7 commit log to explain why we made the
  choice to break userspace for security reasons, thanks Atish and Rémi
- Rebase on top of v6.5-rc1

Changes in v4:
- Fixed some nits in riscv_pmu_sbi.c thanks to Andrew
- Fixed the documentation thanks to Andrew
- Added RB from Andrew \o/

Changes in v3:
- patch 1 now contains the ref to the faulty commit (no Fixes tag as it is only a comment), as Andrew suggested
- Removed RISCV_PMU_LEGACY_TIME from patch 3, as Andrew suggested
- Rename RISCV_PMU_PDEV_NAME to "riscv-pmu-sbi", patch4 is just cosmetic now, as Andrew suggested
- Removed a few useless (and wrong) comments, as Andrew suggested
- Simplify arch_perf_update_userpage code, as Andrew suggested
- Documentation now mentions that time CSR is *always* accessible, whatever the mode, as suggested by Andrew
- Removed CYCLEH reference and add TODO for rv32 support, as suggested by Atish
- Do not rename the pmu instance as Atish suggested
- Set pmc_width only if rdpmc is enabled and CONFIG_RISCV_PMU is set and the event is a hw event
- Move arch_perf_update_userpage https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/
- **Switch to user mode access by default**

Changes in v2:
- Split into smaller patches, way better!
- Add RB from Conor
- Simplify the way we checked riscv architecture
- Fix race mmap and other thread running on other cpus
- Use hwc when available
- Set all userspace access flags in event_init, too cumbersome to handle sysctl changes
- Fix arch_perf_update_userpage for pmu other than riscv-pmu by renaming pmu driver
- Fixed kernel test robot build error
- Fixed documentation (Andrew and Bagas)
- perf testsuite passes mmap tests in all 3 modes

Alexandre Ghiti (10):
  perf: Fix wrong comment about default event_idx
  include: riscv: Fix wrong include guard in riscv_pmu.h
  riscv: Make legacy counter enum match the HW numbering
  drivers: perf: Rename riscv pmu sbi driver
  riscv: Prepare for user-space perf event mmap support
  drivers: perf: Implement perf event mmap support in the legacy backend
  drivers: perf: Implement perf event mmap support in the SBI backend
  Documentation: admin-guide: Add riscv sysctl_perf_user_access
  tools: lib: perf: Implement riscv mmap support
  perf: tests: Adapt mmap-basic.c for riscv

 Documentation/admin-guide/sysctl/kernel.rst |  27 ++-
 drivers/perf/riscv_pmu.c                    | 113 +++++++++++
 drivers/perf/riscv_pmu_legacy.c             |  28 ++-
 drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
 include/linux/perf/riscv_pmu.h              |  12 +-
 include/linux/perf_event.h                  |   3 +-
 tools/lib/perf/mmap.c                       |  66 +++++++
 tools/perf/tests/mmap-basic.c               |   6 +-
 8 files changed, 431 insertions(+), 20 deletions(-)

-- 
2.39.2

