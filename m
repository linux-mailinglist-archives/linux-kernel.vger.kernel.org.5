Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD47585BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGRTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGRTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBBD1995;
        Tue, 18 Jul 2023 12:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B18D60BA3;
        Tue, 18 Jul 2023 19:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE1BC433C7;
        Tue, 18 Jul 2023 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709573;
        bh=r40iy3DmR5NfuY8P/YmJjY+9faNDmei1QHEOjouRvPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kvqKNJdI4ioAzzWEg4FgcRAOQIAc+uexOP/c7AmY5g4N9lhqoZB3iBbE9dNfnLJ73
         FuWIH+HrXi+7DchUubOeh144kmG4USpf4yFOlaPN6vxBOZyOVUK2BPKcAsSu7usFTv
         ekOnGDEGIF+4Lotc5Trf2eNM+TXE0Gg54wmbYqyJRPDwIxq4MXedJj2YRBTkBLWxwn
         Xpun/Fk1UYRAS/swcQwosR3lL2ZacJ4hvni3hVM/uZVF9ugMsbEmCDBWmyp569TsGI
         +xoX8HAz3aw/eaQaXsbklZBncuJ1WFZ5bsh+3HMJ0Yz5Nn0h1JS0tFvMqid28p682S
         c03I7F7RHieBA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ayush Jain <ayush.jain3@amd.com>,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        James Clark <james.clark@arm.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.5
Date:   Tue, 18 Jul 2023 16:46:02 -0300
Message-ID: <20230718194602.444597-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c:

  Merge tag 'linux-watchdog-6.5-rc2' of git://www.linux-watchdog.org/linux-watchdog (2023-07-10 10:04:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.5-1-2023-07-18

for you to fetch changes up to 2480232c61b888a160153b9022858ac8c4362d5f:

  perf test task_exit: No need for a cycles event to check if we get an PERF_RECORD_EXIT (2023-07-17 10:27:44 -0300)

----------------------------------------------------------------
perf tools fixes for v6.5:

- Don't group events when computing metrics that require more than the
  maximum number of simultaneously enabled events on AMD systems.

- Fix multi CU handling in 'perf probe', add a 'perf test' entry to regress
  test it.

- Make the 'perf test task_exit' stop generating samples by using the
  'dummy' event, all it is testing is if a PERF_RECORD_EXIT is generated
  at the end of a perf session. This makes this perf test to stop
  sometimes failing on some systems due to a full ring buffer.

- Avoid SEGV if PMU lookup fails for legacy cache terms.

- Fix libsubcmd SEGV/use-after-free when commands aren't excluded.

- Fix OpenCSD (ARM64's CoreSight hardware tracing) library path resolution when
  specifying CSLIBS= in the make command line.

- Fix broken feature check for libtracefs due to external lib changes,
  use the provided pkgconfig file instead to future proof it.

- Sync drm, fcntl, kvm, mount, prctl, socket, vhost, asound, arm64's
  cputype headers with the kernel sources, in some cases this made the
  tools become aware of new kernel APIs such as ioctls and the cachestat
  sysctl.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (11):
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync files changed by new cachestat syscall with the kernel sources
      tools headers uapi: Sync linux/fcntl.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools include UAPI: Sync linux/mount.h copy with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools include UAPI: Sync the sound/asound.h copy with the kernel sources
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      perf test task_exit: No need for a cycles event to check if we get an PERF_RECORD_EXIT

Georg Müller (2):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()
      perf probe: Read DWARF files from the correct CU

Ian Rogers (2):
      libsubcmd: Avoid SEGV/use-after-free when commands aren't excluded
      perf parse-events: Avoid SEGV if PMU lookup fails for legacy cache terms

James Clark (1):
      perf build: Fix library not found error when using CSLIBS

Sandipan Das (1):
      perf vendor events amd: Fix large metrics

Thomas Richter (1):
      perf build: Fix broken feature check for libtracefs due to external lib changes

 tools/arch/arm64/include/asm/cputype.h             |  8 ++
 tools/build/feature/Makefile                       |  2 +-
 tools/include/uapi/asm-generic/unistd.h            |  5 +-
 tools/include/uapi/drm/i915_drm.h                  | 95 +++++++++++++++++++++-
 tools/include/uapi/linux/fcntl.h                   |  5 ++
 tools/include/uapi/linux/kvm.h                     |  6 +-
 tools/include/uapi/linux/mman.h                    | 14 ++++
 tools/include/uapi/linux/mount.h                   |  3 +-
 tools/include/uapi/linux/prctl.h                   | 11 +++
 tools/include/uapi/linux/vhost.h                   | 31 +++++++
 tools/include/uapi/sound/asound.h                  | 81 +++++++++++++++++-
 tools/lib/subcmd/help.c                            | 18 ++--
 tools/perf/Makefile.config                         |  4 +-
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 .../pmu-events/arch/x86/amdzen1/recommended.json   |  3 +-
 .../pmu-events/arch/x86/amdzen2/recommended.json   |  3 +-
 .../pmu-events/arch/x86/amdzen3/recommended.json   |  3 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   | 77 ++++++++++++++++++
 tools/perf/tests/task-exit.c                       |  4 +-
 tools/perf/trace/beauty/include/linux/socket.h     |  5 ++
 tools/perf/trace/beauty/move_mount_flags.sh        |  2 +-
 tools/perf/trace/beauty/msg_flags.c                |  8 ++
 tools/perf/util/dwarf-aux.c                        |  4 +-
 tools/perf/util/parse-events.c                     |  8 ++
 27 files changed, 381 insertions(+), 23 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_uprobe_from_different_cu.sh
