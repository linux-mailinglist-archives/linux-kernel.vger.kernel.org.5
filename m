Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D0E7DE645
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbjKATLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjKATLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:11:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7850D115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 12:11:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5b31ca2428bso332537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698865893; x=1699470693; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OLjSi51ajxUjjQEuNO1JP+vwPlcLzwt3l2vj8sbLBzM=;
        b=IGqpMZn60eLmLOBPm81UoKZyscKsf9KOKy4vS6QqoUFBDw09I3vZx7s00h/mJaq0bW
         ByVDCCvs9oyCXWj33HZy18aQF+1JGVGHM/22Hd+OfUDvpL2tjSl2E8aQ0ClSgaaj++SY
         RhjUe+2DmxIP0MWBEAmYhYdGHi1EMfKk4D/08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698865893; x=1699470693;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLjSi51ajxUjjQEuNO1JP+vwPlcLzwt3l2vj8sbLBzM=;
        b=fpYETcP6PagecI0RREGsJPOnRDwkv4A4kyqtvs6efWJ6lD1Kb9IlOsOH87YSBRQfeF
         6LbYOAy4RJ9Cw+XQkcQde32Fx+2qP/qci7+RX4KyrXUk8iXFZd6bapsk7CZY0rh0/s1t
         w7vYx52JKlibbRUN4HG9e+gZom3WR36Nf55ZaCz3G92kNe8BRGY7OsYAuISsqEVuEuo8
         sknIdKHMj262pAG/i7+Rp2HfH3nxtBTWcs3KbzfAuY9CdK5fq6I0jkAXR2zDi2b+OtOQ
         rfzExSnvzLimhOmhuWfaJ71beRi7efdK7UX9YeNWoqftPulCOfWq1EPce+mA1qNaPtdz
         IiHw==
X-Gm-Message-State: AOJu0YyLnFfQgNqxBwyhm458gFTWhOqPw7dnj8mNKwjVJ/GhEYKl91tO
        l1+JvlGbzJOFEeAbkja3cp3yBw==
X-Google-Smtp-Source: AGHT+IHjeANyqqsiv4i2HLTgyyr6WuaAmH5rTcUadGdgMkoo80EwEkVVeZIt2b6qmF4KgjvKSc81DA==
X-Received: by 2002:a05:690c:4803:b0:5b3:1c41:733f with SMTP id hc3-20020a05690c480300b005b31c41733fmr6238428ywb.5.1698865893440;
        Wed, 01 Nov 2023 12:11:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r190-20020a819ac7000000b005a7be2919a1sm309719ywg.14.2023.11.01.12.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 12:11:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------pgoIIQXok7NiCOCxYvBxRLbq"
Message-ID: <a5251d1f-a217-48fb-808c-f5ad6edb6c17@linuxfoundation.org>
Date:   Wed, 1 Nov 2023 13:11:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest next update for Linux 6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------pgoIIQXok7NiCOCxYvBxRLbq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for Linux 6.7-rc1.

This kselftest update for Linux 6.7-rc1 consists of:

-- kbuild kselftest-merge target fixes
-- fixes to several tests
-- resctrl test fixes and enhancements
-- ksft_perror() helper and reporting improvements
-- printf attribute to kselftest prints to improve reporting
-- documentation and clang build warning fixes

Bulk of the patches are for resctrl fixes and enhancements.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

   Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.7-rc1

for you to fetch changes up to 5247e6dbed0041147a83137f89cd45043301de5c:

   selftests/resctrl: Fix MBM test failure when MBA unavailable (2023-10-18 14:33:44 -0600)

----------------------------------------------------------------
linux_kselftest-next-6.7-rc1

This kselftest update for Linux 6.7-rc1 consists of:

-- kbuild kselftest-merge target fixes
-- fixes to several tests
-- resctrl test fixes and enhancements
-- ksft_perror() helper and reporting improvements
-- printf attribute to kselftest prints to improve reporting
-- documentation and clang build warning fixes

Bulk of the patches are for resctrl fixes and enhancements.

----------------------------------------------------------------
Björn Töpel (2):
       kbuild: Let builtin have precedence over modules for kselftest-merge
       kbuild: Merge per-arch config for kselftest-merge target

Ilpo Järvinen (16):
       selftests/resctrl: Ensure the benchmark commands fits to its array
       selftests/resctrl: Correct benchmark command help
       selftests/resctrl: Remove bw_report and bm_type from main()
       selftests/resctrl: Simplify span lifetime
       selftests/resctrl: Reorder resctrl FS prep code and benchmark_cmd init
       selftests/resctrl: Make benchmark command const and build it with pointers
       selftests/resctrl: Remove ben_count variable
       selftests/resctrl: Cleanup benchmark argument parsing
       selftests/resctrl: Fix uninitialized .sa_flags
       selftests/resctrl: Extend signal handler coverage to unmount on receiving signal
       selftests/resctrl: Remove duplicate feature check from CMT test
       selftests/resctrl: Move _GNU_SOURCE define into Makefile
       selftests/resctrl: Refactor feature check to use resource and feature name
       selftests/resctrl: Fix feature checks
       selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests
       selftests/resctrl: Fix MBM test failure when MBA unavailable

Javier Carrasco (5):
       selftests/user_events: add gitignore file
       selftests/tdx: add gitignore file
       selftests/dmabuf-heaps: add gitignore file

       selftests: uevent filtering: fix return on error in uevent_listener
       selftests: static_keys: fix test name in messages

Juntong Deng (1):
       selftests/damon: Add executable permission to test scripts

Justin Stitt (1):
       selftests/rseq: fix kselftest Clang build warnings

Maciej Wieczor-Retman (10):
       selftests: Add printf attribute to kselftest prints
       selftests/cachestat: Fix print_cachestat format
       selftests/openat2: Fix wrong format specifier
       selftests/pidfd: Fix ksft print formats
       selftests/sigaltstack: Fix wrong format specifier
       selftests/kvm: Replace attribute with macro
       selftests/mm: Substitute attribute with a macro
       selftests/resctrl: Fix wrong format specifier
       selftests/resctrl: Fix schemata write error check
       selftests/resctrl: Move run_benchmark() to a more fitting file

Marcos Paulo de Souza (1):
       Documentation: kselftests: Remove references to bpf tests

Mark Brown (5):
       kselftest: Add a ksft_perror() helper
       selftests/exec: Convert execveat test to generate KTAP output
       selftests: timers: Convert posix_timers test to generate KTAP output
       selftests: timers: Convert nsleep-lat test to generate KTAP output
       selftests/clone3: Report descriptive test names

Muhammad Usama Anjum (4):
       selftests: capabilities: remove duplicate unneeded defines
       selftests: clone3: remove duplicate defines
       selftests: core: remove duplicate defines
       selftests: firmware: remove duplicate unneeded defines

Swapnil Sapkal (2):
       selftests/amd-pstate: Fix broken paths to run workloads in amd-pstate-ut
       selftests/amd-pstate: Added option to provide perf binary path

Yu Liao (2):
       selftests/ftrace: add loongarch support for kprobe args char tests
       selftests/ftrace: Add riscv support for kprobe arg tests


zhujun2 (2):
       selftests/efivarfs: create-read: fix a resource leak
       selftests:modify the incorrect print format

Documentation/dev-tools/kselftest.rst              |   6 +-
  Makefile                                           |   4 +-
  .../x86/amd_pstate_tracer/amd_pstate_trace.py      |   3 +-
  tools/testing/selftests/amd-pstate/gitsource.sh    |  17 +-
  tools/testing/selftests/amd-pstate/run.sh          |  21 +-
  tools/testing/selftests/amd-pstate/tbench.sh       |   4 +-
  tools/testing/selftests/cachestat/test_cachestat.c |   2 +-
  tools/testing/selftests/capabilities/Makefile      |   2 +-
  tools/testing/selftests/capabilities/test_execve.c |   8 -
  .../testing/selftests/capabilities/validate_cap.c  |   8 -
  tools/testing/selftests/clone3/clone3.c            | 265 +++++++++++++++------
  .../clone3/clone3_cap_checkpoint_restore.c         |   2 -
  .../selftests/clone3/clone3_clear_sighand.c        |   4 -
  tools/testing/selftests/clone3/clone3_selftests.h  |  13 -
  tools/testing/selftests/clone3/clone3_set_tid.c    |   2 -
  tools/testing/selftests/core/close_range_test.c    |  28 ---
  tools/testing/selftests/damon/debugfs_attrs.sh     |   0
  .../damon/debugfs_duplicate_context_creation.sh    |   0
  .../selftests/damon/debugfs_empty_targets.sh       |   0
  .../damon/debugfs_huge_count_read_write.sh         |   0
  .../selftests/damon/debugfs_rm_non_contexts.sh     |   0
  tools/testing/selftests/damon/debugfs_schemes.sh   |   0
  .../testing/selftests/damon/debugfs_target_ids.sh  |   0
  tools/testing/selftests/damon/lru_sort.sh          |   0
  tools/testing/selftests/damon/reclaim.sh           |   0
  tools/testing/selftests/damon/sysfs.sh             |   0
  .../damon/sysfs_update_removed_scheme_dir.sh       |   0
  tools/testing/selftests/dmabuf-heaps/.gitignore    |   1 +
  tools/testing/selftests/efivarfs/create-read.c     |   2 +
  tools/testing/selftests/exec/execveat.c            |  87 ++++---
  tools/testing/selftests/firmware/fw_namespace.c    |   4 -
  .../ftrace/test.d/kprobe/kprobe_args_char.tc       |   6 +
  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   3 +
  .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   4 +
  tools/testing/selftests/kselftest.h                |  46 ++--
  tools/testing/selftests/kvm/include/test_util.h    |   8 +-
  tools/testing/selftests/mm/mremap_test.c           |   2 +-
  tools/testing/selftests/mm/pkey-helpers.h          |   2 +-
  tools/testing/selftests/openat2/openat2_test.c     |   2 +-
  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c  |   2 +-
  tools/testing/selftests/pidfd/pidfd_test.c         |  12 +-
  tools/testing/selftests/resctrl/Makefile           |   2 +-
  tools/testing/selftests/resctrl/cache.c            |   7 +-
  tools/testing/selftests/resctrl/cat_test.c         |  21 +-
  tools/testing/selftests/resctrl/cmt_test.c         |  37 ++-
  tools/testing/selftests/resctrl/mba_test.c         |   6 +-
  tools/testing/selftests/resctrl/mbm_test.c         |  11 +-
  tools/testing/selftests/resctrl/resctrl.h          |  24 +-
  tools/testing/selftests/resctrl/resctrl_tests.c    | 180 +++++++-------
  tools/testing/selftests/resctrl/resctrl_val.c      |  86 +++++--
  tools/testing/selftests/resctrl/resctrlfs.c        | 162 +++++--------
  tools/testing/selftests/rseq/param_test.c          |  20 +-
  tools/testing/selftests/sigaltstack/sas.c          |   2 +-
  .../selftests/static_keys/test_static_keys.sh      |   8 +-
  tools/testing/selftests/tdx/.gitignore             |   1 +
  tools/testing/selftests/timers/nsleep-lat.c        |  26 +-
  tools/testing/selftests/timers/posix_timers.c      |  81 +++----
  tools/testing/selftests/uevent/uevent_filtering.c  |   8 +-
  tools/testing/selftests/user_events/.gitignore     |   4 +
  59 files changed, 697 insertions(+), 559 deletions(-)
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/lru_sort.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/reclaim.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/sysfs.sh
  mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
  create mode 100644 tools/testing/selftests/dmabuf-heaps/.gitignore
  create mode 100644 tools/testing/selftests/tdx/.gitignore
  create mode 100644 tools/testing/selftests/user_events/.gitignore
----------------------------------------------------------------
--------------pgoIIQXok7NiCOCxYvBxRLbq
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.7-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.7-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5yc3QgYi9E
b2N1bWVudGF0aW9uL2Rldi10b29scy9rc2VsZnRlc3QucnN0CmluZGV4IGRlZWRlOTcyZjI1
NC4uYWIzNzZiMzE2YzM2IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9r
c2VsZnRlc3QucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5y
c3QKQEAgLTExMiw3ICsxMTIsNyBAQCBZb3UgY2FuIHNwZWNpZnkgbXVsdGlwbGUgdGVzdHMg
dG8gc2tpcDo6CiBZb3UgY2FuIGFsc28gc3BlY2lmeSBhIHJlc3RyaWN0ZWQgbGlzdCBvZiB0
ZXN0cyB0byBydW4gdG9nZXRoZXIgd2l0aCBhCiBkZWRpY2F0ZWQgc2tpcGxpc3Q6OgogCi0g
ICQgIG1ha2UgVEFSR0VUUz0iYnBmIGJyZWFrcG9pbnRzIHNpemUgdGltZXJzIiBTS0lQX1RB
UkdFVFM9YnBmIGtzZWxmdGVzdAorICAkICBtYWtlIFRBUkdFVFM9ImJyZWFrcG9pbnRzIHNp
emUgdGltZXJzIiBTS0lQX1RBUkdFVFM9c2l6ZSBrc2VsZnRlc3QKIAogU2VlIHRoZSB0b3At
bGV2ZWwgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGUgZm9yIHRoZSBsaXN0IG9m
IGFsbAogcG9zc2libGUgdGFyZ2V0cy4KQEAgLTE2NSw3ICsxNjUsNyBAQCBUbyBzZWUgdGhl
IGxpc3Qgb2YgYXZhaWxhYmxlIHRlc3RzLCB0aGUgYC1sYCBvcHRpb24gY2FuIGJlIHVzZWQ6
OgogVGhlIGAtY2Agb3B0aW9uIGNhbiBiZSB1c2VkIHRvIHJ1biBhbGwgdGhlIHRlc3RzIGZy
b20gYSB0ZXN0IGNvbGxlY3Rpb24sIG9yCiB0aGUgYC10YCBvcHRpb24gZm9yIHNwZWNpZmlj
IHNpbmdsZSB0ZXN0cy4gRWl0aGVyIGNhbiBiZSB1c2VkIG11bHRpcGxlIHRpbWVzOjoKIAot
ICAgJCAuL3J1bl9rc2VsZnRlc3Quc2ggLWMgYnBmIC1jIHNlY2NvbXAgLXQgdGltZXJzOnBv
c2l4X3RpbWVycyAtdCB0aW1lcjpuYW5vc2xlZXAKKyAgICQgLi9ydW5fa3NlbGZ0ZXN0LnNo
IC1jIHNpemUgLWMgc2VjY29tcCAtdCB0aW1lcnM6cG9zaXhfdGltZXJzIC10IHRpbWVyOm5h
bm9zbGVlcAogCiBGb3Igb3RoZXIgZmVhdHVyZXMgc2VlIHRoZSBzY3JpcHQgdXNhZ2Ugb3V0
cHV0LCBzZWVuIHdpdGggdGhlIGAtaGAgb3B0aW9uLgogCkBAIC0yMTAsNyArMjEwLDcgQEAg
b3B0aW9uIGlzIHN1cHBvcnRlZCwgc3VjaCBhczo6CiB0ZXN0cyBieSB1c2luZyB2YXJpYWJs
ZXMgc3BlY2lmaWVkIGluIGBSdW5uaW5nIGEgc3Vic2V0IG9mIHNlbGZ0ZXN0c2BfCiBzZWN0
aW9uOjoKIAotICAgICQgbWFrZSAtQyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyBnZW5fdGFy
IFRBUkdFVFM9ImJwZiIgRk9STUFUPS54egorICAgICQgbWFrZSAtQyB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cyBnZW5fdGFyIFRBUkdFVFM9InNpemUiIEZPUk1BVD0ueHoKIAogLi4gX3Rh
cidzIGF1dG8tY29tcHJlc3M6IGh0dHBzOi8vd3d3LmdudS5vcmcvc29mdHdhcmUvdGFyL21h
bnVhbC9odG1sX25vZGUvZ3ppcC5odG1sI2F1dG9fMDAyZGNvbXByZXNzCiAKZGlmZiAtLWdp
dCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggNTc2OThkMDQ4ZTJjLi5mZDgzMjk0NzRl
ODYgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC0xMzY3LDggKzEz
NjcsOCBAQCBrc2VsZnRlc3QtJTogaGVhZGVycyBGT1JDRQogUEhPTlkgKz0ga3NlbGZ0ZXN0
LW1lcmdlCiBrc2VsZnRlc3QtbWVyZ2U6CiAJJChpZiAkKHdpbGRjYXJkICQob2JqdHJlZSkv
LmNvbmZpZyksLCAkKGVycm9yIE5vIC5jb25maWcgZXhpc3RzLCBjb25maWcgeW91ciBrZXJu
ZWwgZmlyc3QhKSkKLQkkKFEpZmluZCAkKHNyY3RyZWUpL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzIC1uYW1lIGNvbmZpZyB8IFwKLQkJeGFyZ3MgJChzcmN0cmVlKS9zY3JpcHRzL2tjb25m
aWcvbWVyZ2VfY29uZmlnLnNoIC1tICQob2JqdHJlZSkvLmNvbmZpZworCSQoUSlmaW5kICQo
c3JjdHJlZSkvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMgLW5hbWUgY29uZmlnIC1vIC1uYW1l
IGNvbmZpZy4kKFVUU19NQUNISU5FKSB8IFwKKwkJeGFyZ3MgJChzcmN0cmVlKS9zY3JpcHRz
L2tjb25maWcvbWVyZ2VfY29uZmlnLnNoIC15IC1tICQob2JqdHJlZSkvLmNvbmZpZwogCSQo
USkkKE1BS0UpIC1mICQoc3JjdHJlZSkvTWFrZWZpbGUgb2xkZGVmY29uZmlnCiAKICMgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCmRpZmYgLS1naXQgYS90b29scy9wb3dlci94ODYvYW1kX3Bz
dGF0ZV90cmFjZXIvYW1kX3BzdGF0ZV90cmFjZS5weSBiL3Rvb2xzL3Bvd2VyL3g4Ni9hbWRf
cHN0YXRlX3RyYWNlci9hbWRfcHN0YXRlX3RyYWNlLnB5CmluZGV4IDkwNGRmMGVhMGExZS4u
ZmViOWY5NDIxYzdiIDEwMDc1NQotLS0gYS90b29scy9wb3dlci94ODYvYW1kX3BzdGF0ZV90
cmFjZXIvYW1kX3BzdGF0ZV90cmFjZS5weQorKysgYi90b29scy9wb3dlci94ODYvYW1kX3Bz
dGF0ZV90cmFjZXIvYW1kX3BzdGF0ZV90cmFjZS5weQpAQCAtMzAsOCArMzAsNyBAQCBpbXBv
cnQgZ2V0b3B0CiBpbXBvcnQgR251cGxvdAogZnJvbSBudW1weSBpbXBvcnQgKgogZnJvbSBk
ZWNpbWFsIGltcG9ydCAqCi1zeXMucGF0aC5hcHBlbmQoJy4uL2ludGVsX3BzdGF0ZV90cmFj
ZXInKQotI2ltcG9ydCBpbnRlbF9wc3RhdGVfdHJhY2VyCitzeXMucGF0aC5hcHBlbmQob3Mu
cGF0aC5qb2luKG9zLnBhdGguZGlybmFtZShfX2ZpbGVfXyksICIuLiIsICJpbnRlbF9wc3Rh
dGVfdHJhY2VyIikpCiBpbXBvcnQgaW50ZWxfcHN0YXRlX3RyYWNlciBhcyBpcHQKIAogX19s
aWNlbnNlX18gPSAiR1BMIHZlcnNpb24gMiIKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2FtZC1wc3RhdGUvZ2l0c291cmNlLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYW1kLXBzdGF0ZS9naXRzb3VyY2Uuc2gKaW5kZXggNWYyMTcxZjAxMTZkLi40Y2Rl
NjJmOTA0NjggMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FtZC1wc3Rh
dGUvZ2l0c291cmNlLnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FtZC1wc3Rh
dGUvZ2l0c291cmNlLnNoCkBAIC0xLDQgKzEsNCBAQAotIyEvYmluL3NoCisjIS9iaW4vYmFz
aAogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAogCiAjIFRlc3RpbmcgYW5k
IG1vbml0b3IgdGhlIGNwdSBkZXNpcmUgcGVyZm9ybWFuY2UsIGZyZXF1ZW5jeSwgbG9hZCwK
QEAgLTY2LDEyICs2NiwxNSBAQCBwb3N0X2NsZWFyX2dpdHNvdXJjZSgpCiAKIGluc3RhbGxf
Z2l0c291cmNlKCkKIHsKLQlpZiBbICEgLWQgJGdpdF9uYW1lIF07IHRoZW4KKwlpZiBbICEg
LWQgJFNDUklQVERJUi8kZ2l0X25hbWUgXTsgdGhlbgorCQlwdXNoZCAkKHB3ZCkgPiAvZGV2
L251bGwgMj4mMQorCQljZCAkU0NSSVBURElSCiAJCXByaW50ZiAiRG93bmxvYWQgZ2l0c291
cmNlLCBwbGVhc2Ugd2FpdCBhIG1vbWVudCAuLi5cblxuIgogCQl3Z2V0IC1PICRnaXRfdGFy
ICRnaXRzb3VyY2VfdXJsID4gL2Rldi9udWxsIDI+JjEKIAogCQlwcmludGYgIlRhciBnaXRz
b3VyY2UgLi4uXG5cbiIKIAkJdGFyIC14emYgJGdpdF90YXIKKwkJcG9wZCA+IC9kZXYvbnVs
bCAyPiYxCiAJZmkKIH0KIApAQCAtNzksMTIgKzgyLDE0IEBAIGluc3RhbGxfZ2l0c291cmNl
KCkKIHJ1bl9naXRzb3VyY2UoKQogewogCWVjaG8gIkxhdW5jaGluZyBhbWQgcHN0YXRlIHRy
YWNlciBmb3IgJDEgIyQyIHRyYWNlcl9pbnRlcnZhbDogJFRSQUNFUl9JTlRFUlZBTCIKLQku
L2FtZF9wc3RhdGVfdHJhY2UucHkgLW4gdHJhY2VyLWdpdHNvdXJjZS0kMS0kMiAtaSAkVFJB
Q0VSX0lOVEVSVkFMID4gL2Rldi9udWxsIDI+JjEgJgorCSRUUkFDRVIgLW4gdHJhY2VyLWdp
dHNvdXJjZS0kMS0kMiAtaSAkVFJBQ0VSX0lOVEVSVkFMID4gL2Rldi9udWxsIDI+JjEgJgog
CiAJcHJpbnRmICJNYWtlIGFuZCB0ZXN0IGdpdHNvdXJjZSBmb3IgJDEgIyQyIG1ha2VfY3B1
czogJE1BS0VfQ1BVU1xuIgotCWNkICRnaXRfbmFtZQotCXBlcmYgc3RhdCAtYSAtLXBlci1z
b2NrZXQgLUkgMTAwMCAtZSBwb3dlci9lbmVyZ3ktcGtnLyAvdXNyL2Jpbi90aW1lIC1vIC4u
LyRPVVRGSUxFX0dJVC50aW1lLWdpdHNvdXJjZS0kMS0kMi5sb2cgbWFrZSB0ZXN0IC1qJE1B
S0VfQ1BVUyA+IC4uLyRPVVRGSUxFX0dJVC1wZXJmLSQxLSQyLmxvZyAyPiYxCi0JY2QgLi4K
KwlCQUNLVVBfRElSPSQocHdkKQorCXB1c2hkICRCQUNLVVBfRElSID4gL2Rldi9udWxsIDI+
JjEKKwljZCAkU0NSSVBURElSLyRnaXRfbmFtZQorCSRQRVJGIHN0YXQgLWEgLS1wZXItc29j
a2V0IC1JIDEwMDAgLWUgcG93ZXIvZW5lcmd5LXBrZy8gL3Vzci9iaW4vdGltZSAtbyAkQkFD
S1VQX0RJUi8kT1VURklMRV9HSVQudGltZS1naXRzb3VyY2UtJDEtJDIubG9nIG1ha2UgdGVz
dCAtaiRNQUtFX0NQVVMgPiAkQkFDS1VQX0RJUi8kT1VURklMRV9HSVQtcGVyZi0kMS0kMi5s
b2cgMj4mMQorCXBvcGQgPiAvZGV2L251bGwgMj4mMQogCiAJZm9yIGpvYiBpbiBgam9icyAt
cGAKIAlkbwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYW1kLXBzdGF0
ZS9ydW4uc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hbWQtcHN0YXRlL3J1bi5zaApp
bmRleCBkZTRkOGU5Yzk1NjUuLmIwNTNlZWE4YmIxOSAxMDA3NTUKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYW1kLXBzdGF0ZS9ydW4uc2gKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYW1kLXBzdGF0ZS9ydW4uc2gKQEAgLTgsOSArOCwxMiBAQCBlbHNlCiAJRklM
RV9NQUlOPURPTkUKIGZpCiAKLXNvdXJjZSBiYXNpYy5zaAotc291cmNlIHRiZW5jaC5zaAot
c291cmNlIGdpdHNvdXJjZS5zaAorU0NSSVBURElSPWBkaXJuYW1lICIkMCJgCitUUkFDRVI9
JFNDUklQVERJUi8uLi8uLi8uLi9wb3dlci94ODYvYW1kX3BzdGF0ZV90cmFjZXIvYW1kX3Bz
dGF0ZV90cmFjZS5weQorCitzb3VyY2UgJFNDUklQVERJUi9iYXNpYy5zaAorc291cmNlICRT
Q1JJUFRESVIvdGJlbmNoLnNoCitzb3VyY2UgJFNDUklQVERJUi9naXRzb3VyY2Uuc2gKIAog
IyBhbWQtcHN0YXRlLXV0IG9ubHkgcnVuIG9uIHg4Ni94ODZfNjQgQU1EIHN5c3RlbXMuCiBB
UkNIPSQodW5hbWUgLW0gMj4vZGV2L251bGwgfCBzZWQgLWUgJ3MvaS44Ni94ODYvJyAtZSAn
cy94ODZfNjQveDg2LycpCkBAIC0yMiw2ICsyNSw3IEBAIE9VVEZJTEU9c2VsZnRlc3QKIE9V
VEZJTEVfVEJFTkNIPSIkT1VURklMRS50YmVuY2giCiBPVVRGSUxFX0dJVD0iJE9VVEZJTEUu
Z2l0c291cmNlIgogCitQRVJGPS91c3IvYmluL3BlcmYKIFNZU0ZTPQogQ1BVUk9PVD0KIENQ
VUZSRVFST09UPQpAQCAtMTUxLDYgKzE1NSw3IEBAIGhlbHAoKQogCVstcCA8dGJlbmNoIHBy
b2Nlc3MgbnVtYmVyPl0KIAlbLWwgPGxvb3AgdGltZXMgZm9yIHRiZW5jaD5dCiAJWy1pIDxh
bWQgdHJhY2VyIGludGVydmFsPl0KKwlbLWIgPHBlcmYgYmluYXJ5Pl0KIAlbLW0gPGNvbXBh
cmF0aXZlIHRlc3Q6IGFjcGktY3B1ZnJlcT5dCiAJXG4iCiAJZXhpdCAyCkBAIC0xNTgsNyAr
MTYzLDcgQEAgaGVscCgpCiAKIHBhcnNlX2FyZ3VtZW50cygpCiB7Ci0Jd2hpbGUgZ2V0b3B0
cyBobzpjOnQ6cDpsOmk6bTogYXJnCisJd2hpbGUgZ2V0b3B0cyBobzpjOnQ6cDpsOmk6Yjpt
OiBhcmcKIAlkbwogCQljYXNlICRhcmcgaW4KIAkJCWgpICMgLS1oZWxwCkBAIC0xODksNiAr
MTk0LDEwIEBAIHBhcnNlX2FyZ3VtZW50cygpCiAJCQkJVFJBQ0VSX0lOVEVSVkFMPSRPUFRB
UkcKIAkJCQk7OwogCisJCQliKSAjIC0tcGVyZi1iaW5hcnkKKwkJCQlQRVJGPWByZWFscGF0
aCAkT1BUQVJHYAorCQkJCTs7CisKIAkJCW0pICMgLS1jb21wYXJhdGl2ZS10ZXN0CiAJCQkJ
Q09NUEFSQVRJVkVfVEVTVD0kT1BUQVJHCiAJCQkJOzsKQEAgLTIwMiw4ICsyMTEsOCBAQCBw
YXJzZV9hcmd1bWVudHMoKQogCiBjb21tYW5kX3BlcmYoKQogewotCWlmICEgY29tbWFuZCAt
diBwZXJmID4gL2Rldi9udWxsOyB0aGVuCi0JCWVjaG8gJG1zZyBwbGVhc2UgaW5zdGFsbCBw
ZXJmLiA+JjIKKwlpZiAhICRQRVJGIC12OyB0aGVuCisJCWVjaG8gJG1zZyBwbGVhc2UgaW5z
dGFsbCBwZXJmIG9yIHByb3ZpZGUgcGVyZiBiaW5hcnkgcGF0aCBhcyBhcmd1bWVudCA+JjIK
IAkJZXhpdCAka3NmdF9za2lwCiAJZmkKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2FtZC1wc3RhdGUvdGJlbmNoLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYW1kLXBzdGF0ZS90YmVuY2guc2gKaW5kZXggNDljOTg1MDM0MWY2Li4yYTk4ZDljOTIw
MmUgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FtZC1wc3RhdGUvdGJl
bmNoLnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FtZC1wc3RhdGUvdGJlbmNo
LnNoCkBAIC02NCwxMSArNjQsMTEgQEAgcG9zdF9jbGVhcl90YmVuY2goKQogcnVuX3RiZW5j
aCgpCiB7CiAJZWNobyAiTGF1bmNoaW5nIGFtZCBwc3RhdGUgdHJhY2VyIGZvciAkMSAjJDIg
dHJhY2VyX2ludGVydmFsOiAkVFJBQ0VSX0lOVEVSVkFMIgotCS4vYW1kX3BzdGF0ZV90cmFj
ZS5weSAtbiB0cmFjZXItdGJlbmNoLSQxLSQyIC1pICRUUkFDRVJfSU5URVJWQUwgPiAvZGV2
L251bGwgMj4mMSAmCisJJFRSQUNFUiAtbiB0cmFjZXItdGJlbmNoLSQxLSQyIC1pICRUUkFD
RVJfSU5URVJWQUwgPiAvZGV2L251bGwgMj4mMSAmCiAKIAlwcmludGYgIlRlc3QgdGJlbmNo
IGZvciAkMSAjJDIgdGltZV9saW1pdDogJFRJTUVfTElNSVQgcHJvY3NfbnVtOiAkUFJPQ0VT
U19OVU1cbiIKIAl0YmVuY2hfc3J2ID4gL2Rldi9udWxsIDI+JjEgJgotCXBlcmYgc3RhdCAt
YSAtLXBlci1zb2NrZXQgLUkgMTAwMCAtZSBwb3dlci9lbmVyZ3ktcGtnLyB0YmVuY2ggLXQg
JFRJTUVfTElNSVQgJFBST0NFU1NfTlVNID4gJE9VVEZJTEVfVEJFTkNILXBlcmYtJDEtJDIu
bG9nIDI+JjEKKwkkUEVSRiBzdGF0IC1hIC0tcGVyLXNvY2tldCAtSSAxMDAwIC1lIHBvd2Vy
L2VuZXJneS1wa2cvIHRiZW5jaCAtdCAkVElNRV9MSU1JVCAkUFJPQ0VTU19OVU0gPiAkT1VU
RklMRV9UQkVOQ0gtcGVyZi0kMS0kMi5sb2cgMj4mMQogCiAJcGlkPWBwaWRvZiB0YmVuY2hf
c3J2YAogCWtpbGwgJHBpZApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
Y2FjaGVzdGF0L3Rlc3RfY2FjaGVzdGF0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9j
YWNoZXN0YXQvdGVzdF9jYWNoZXN0YXQuYwppbmRleCA0ODA0YzdkYzdiMzEuLmIxNzFmZDUz
YjAwNCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2FjaGVzdGF0L3Rl
c3RfY2FjaGVzdGF0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2FjaGVzdGF0
L3Rlc3RfY2FjaGVzdGF0LmMKQEAgLTI3LDcgKzI3LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdCBkZXZfZmlsZXNbXSA9IHsKIHZvaWQgcHJpbnRfY2FjaGVzdGF0KHN0cnVjdCBj
YWNoZXN0YXQgKmNzKQogewogCWtzZnRfcHJpbnRfbXNnKAotCSJVc2luZyBjYWNoZXN0YXQ6
IENhY2hlZDogJWx1LCBEaXJ0eTogJWx1LCBXcml0ZWJhY2s6ICVsdSwgRXZpY3RlZDogJWx1
LCBSZWNlbnRseSBFdmljdGVkOiAlbHVcbiIsCisJIlVzaW5nIGNhY2hlc3RhdDogQ2FjaGVk
OiAlbGx1LCBEaXJ0eTogJWxsdSwgV3JpdGViYWNrOiAlbGx1LCBFdmljdGVkOiAlbGx1LCBS
ZWNlbnRseSBFdmljdGVkOiAlbGx1XG4iLAogCWNzLT5ucl9jYWNoZSwgY3MtPm5yX2RpcnR5
LCBjcy0+bnJfd3JpdGViYWNrLAogCWNzLT5ucl9ldmljdGVkLCBjcy0+bnJfcmVjZW50bHlf
ZXZpY3RlZCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jYXBh
YmlsaXRpZXMvTWFrZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jYXBhYmlsaXRp
ZXMvTWFrZWZpbGUKaW5kZXggNmU5ZDk4ZDQ1N2Q1Li40MTFhYzA5ODMwOGYgMTAwNjQ0Ci0t
LSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhcGFiaWxpdGllcy9NYWtlZmlsZQorKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jYXBhYmlsaXRpZXMvTWFrZWZpbGUKQEAgLTIs
NyArMiw3IEBACiBURVNUX0dFTl9GSUxFUyA6PSB2YWxpZGF0ZV9jYXAKIFRFU1RfR0VOX1BS
T0dTIDo9IHRlc3RfZXhlY3ZlCiAKLUNGTEFHUyArPSAtTzIgLWcgLXN0ZD1nbnU5OSAtV2Fs
bAorQ0ZMQUdTICs9IC1PMiAtZyAtc3RkPWdudTk5IC1XYWxsICQoS0hEUl9JTkNMVURFUykK
IExETElCUyArPSAtbGNhcC1uZyAtbHJ0IC1sZGwKIAogaW5jbHVkZSAuLi9saWIubWsKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhcGFiaWxpdGllcy90ZXN0X2V4
ZWN2ZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2FwYWJpbGl0aWVzL3Rlc3RfZXhl
Y3ZlLmMKaW5kZXggZGYwZWYwMmI0MDM2Li5lM2EzNTJiMDIwYTcgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhcGFiaWxpdGllcy90ZXN0X2V4ZWN2ZS5jCisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhcGFiaWxpdGllcy90ZXN0X2V4ZWN2ZS5jCkBA
IC0yMCwxNCArMjAsNiBAQAogCiAjaW5jbHVkZSAiLi4va3NlbGZ0ZXN0LmgiCiAKLSNpZm5k
ZWYgUFJfQ0FQX0FNQklFTlQKLSNkZWZpbmUgUFJfQ0FQX0FNQklFTlQJCQk0NwotIyBkZWZp
bmUgUFJfQ0FQX0FNQklFTlRfSVNfU0VUCQkxCi0jIGRlZmluZSBQUl9DQVBfQU1CSUVOVF9S
QUlTRQkJMgotIyBkZWZpbmUgUFJfQ0FQX0FNQklFTlRfTE9XRVIJCTMKLSMgZGVmaW5lIFBS
X0NBUF9BTUJJRU5UX0NMRUFSX0FMTAk0Ci0jZW5kaWYKLQogc3RhdGljIGludCBuZXJyczsK
IHN0YXRpYyBwaWRfdCBtcGlkOwkvKiAgbWFpbigpIHBpZCBpcyB1c2VkIHRvIGF2b2lkIGR1
cGxpY2F0ZSB0ZXN0IGNvdW50cyAqLwogCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9jYXBhYmlsaXRpZXMvdmFsaWRhdGVfY2FwLmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9jYXBhYmlsaXRpZXMvdmFsaWRhdGVfY2FwLmMKaW5kZXggY2RmYzk0MjY4ZmU2
Li42MGI0ZTdiNzE2YTcgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nh
cGFiaWxpdGllcy92YWxpZGF0ZV9jYXAuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9jYXBhYmlsaXRpZXMvdmFsaWRhdGVfY2FwLmMKQEAgLTksMTQgKzksNiBAQAogCiAjaW5j
bHVkZSAiLi4va3NlbGZ0ZXN0LmgiCiAKLSNpZm5kZWYgUFJfQ0FQX0FNQklFTlQKLSNkZWZp
bmUgUFJfQ0FQX0FNQklFTlQJCQk0NwotIyBkZWZpbmUgUFJfQ0FQX0FNQklFTlRfSVNfU0VU
CQkxCi0jIGRlZmluZSBQUl9DQVBfQU1CSUVOVF9SQUlTRQkJMgotIyBkZWZpbmUgUFJfQ0FQ
X0FNQklFTlRfTE9XRVIJCTMKLSMgZGVmaW5lIFBSX0NBUF9BTUJJRU5UX0NMRUFSX0FMTAk0
Ci0jZW5kaWYKLQogI2lmIF9fR0xJQkNfXyA+IDIgfHwgKF9fR0xJQkNfXyA9PSAyICYmIF9f
R0xJQkNfTUlOT1JfXyA+PSAxOSkKICMgZGVmaW5lIEhBVkVfR0VUQVVYVkFMCiAjZW5kaWYK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTMuYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTMuYwppbmRleCBlNjBjZjRk
YThmYjAuLjk0MjlkMzYxMDU5ZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvY2xvbmUzL2Nsb25lMy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25l
My9jbG9uZTMuYwpAQCAtNyw2ICs3LDcgQEAKICNpbmNsdWRlIDxpbnR0eXBlcy5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KKyNpbmNs
dWRlIDxzdGRib29sLmg+CiAjaW5jbHVkZSA8c3RkaW50Lmg+CiAjaW5jbHVkZSA8c3RkaW8u
aD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KQEAgLTEwMyw4ICsxMDQsOCBAQCBzdGF0aWMgaW50
IGNhbGxfY2xvbmUzKHVpbnQ2NF90IGZsYWdzLCBzaXplX3Qgc2l6ZSwgZW51bSB0ZXN0X21v
ZGUgdGVzdF9tb2RlKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCB0ZXN0X2Nsb25l
Myh1aW50NjRfdCBmbGFncywgc2l6ZV90IHNpemUsIGludCBleHBlY3RlZCwKLQkJICAgICAg
IGVudW0gdGVzdF9tb2RlIHRlc3RfbW9kZSkKK3N0YXRpYyBib29sIHRlc3RfY2xvbmUzKHVp
bnQ2NF90IGZsYWdzLCBzaXplX3Qgc2l6ZSwgaW50IGV4cGVjdGVkLAorCQkJZW51bSB0ZXN0
X21vZGUgdGVzdF9tb2RlKQogewogCWludCByZXQ7CiAKQEAgLTExNCw5MiArMTE1LDIxMCBA
QCBzdGF0aWMgdm9pZCB0ZXN0X2Nsb25lMyh1aW50NjRfdCBmbGFncywgc2l6ZV90IHNpemUs
IGludCBleHBlY3RlZCwKIAlyZXQgPSBjYWxsX2Nsb25lMyhmbGFncywgc2l6ZSwgdGVzdF9t
b2RlKTsKIAlrc2Z0X3ByaW50X21zZygiWyVkXSBjbG9uZTMoKSB3aXRoIGZsYWdzIHNheXM6
ICVkIGV4cGVjdGVkICVkXG4iLAogCQkJZ2V0cGlkKCksIHJldCwgZXhwZWN0ZWQpOwotCWlm
IChyZXQgIT0gZXhwZWN0ZWQpCi0JCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgKKwlpZiAocmV0
ICE9IGV4cGVjdGVkKSB7CisJCWtzZnRfcHJpbnRfbXNnKAogCQkJIlslZF0gUmVzdWx0ICgl
ZCkgaXMgZGlmZmVyZW50IHRoYW4gZXhwZWN0ZWQgKCVkKVxuIiwKIAkJCWdldHBpZCgpLCBy
ZXQsIGV4cGVjdGVkKTsKLQllbHNlCi0JCWtzZnRfdGVzdF9yZXN1bHRfcGFzcygKLQkJCSJb
JWRdIFJlc3VsdCAoJWQpIG1hdGNoZXMgZXhwZWN0YXRpb24gKCVkKVxuIiwKLQkJCWdldHBp
ZCgpLCByZXQsIGV4cGVjdGVkKTsKLX0KLQotaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKLXsKLQl1aWRfdCB1aWQgPSBnZXR1aWQoKTsKLQotCWtzZnRfcHJpbnRfaGVhZGVy
KCk7Ci0Ja3NmdF9zZXRfcGxhbigxOSk7Ci0JdGVzdF9jbG9uZTNfc3VwcG9ydGVkKCk7Ci0K
LQkvKiBKdXN0IGEgc2ltcGxlIGNsb25lMygpIHNob3VsZCByZXR1cm4gMC4qLwotCXRlc3Rf
Y2xvbmUzKDAsIDAsIDAsIENMT05FM19BUkdTX05PX1RFU1QpOwotCi0JLyogRG8gYSBjbG9u
ZTMoKSBpbiBhIG5ldyBQSUQgTlMuKi8KLQlpZiAodWlkID09IDApCi0JCXRlc3RfY2xvbmUz
KENMT05FX05FV1BJRCwgMCwgMCwgQ0xPTkUzX0FSR1NfTk9fVEVTVCk7Ci0JZWxzZQotCQlr
c2Z0X3Rlc3RfcmVzdWx0X3NraXAoIlNraXBwaW5nIGNsb25lMygpIHdpdGggQ0xPTkVfTkVX
UElEXG4iKTsKLQotCS8qIERvIGEgY2xvbmUzKCkgd2l0aCBDTE9ORV9BUkdTX1NJWkVfVkVS
MC4gKi8KLQl0ZXN0X2Nsb25lMygwLCBDTE9ORV9BUkdTX1NJWkVfVkVSMCwgMCwgQ0xPTkUz
X0FSR1NfTk9fVEVTVCk7Ci0KLQkvKiBEbyBhIGNsb25lMygpIHdpdGggQ0xPTkVfQVJHU19T
SVpFX1ZFUjAgLSA4ICovCi0JdGVzdF9jbG9uZTMoMCwgQ0xPTkVfQVJHU19TSVpFX1ZFUjAg
LSA4LCAtRUlOVkFMLCBDTE9ORTNfQVJHU19OT19URVNUKTsKLQotCS8qIERvIGEgY2xvbmUz
KCkgd2l0aCBzaXplb2Yoc3RydWN0IGNsb25lX2FyZ3MpICsgOCAqLwotCXRlc3RfY2xvbmUz
KDAsIHNpemVvZihzdHJ1Y3QgX19jbG9uZV9hcmdzKSArIDgsIDAsIENMT05FM19BUkdTX05P
X1RFU1QpOwotCi0JLyogRG8gYSBjbG9uZTMoKSB3aXRoIGV4aXRfc2lnbmFsIGhhdmluZyBo
aWdoZXN0IDMyIGJpdHMgbm9uLXplcm8gKi8KLQl0ZXN0X2Nsb25lMygwLCAwLCAtRUlOVkFM
LCBDTE9ORTNfQVJHU19JTlZBTF9FWElUX1NJR05BTF9CSUcpOworCQlyZXR1cm4gZmFsc2U7
CisJfQogCi0JLyogRG8gYSBjbG9uZTMoKSB3aXRoIG5lZ2F0aXZlIDMyLWJpdCBleGl0X3Np
Z25hbCAqLwotCXRlc3RfY2xvbmUzKDAsIDAsIC1FSU5WQUwsIENMT05FM19BUkdTX0lOVkFM
X0VYSVRfU0lHTkFMX05FRyk7CisJcmV0dXJuIHRydWU7Cit9CiAKLQkvKiBEbyBhIGNsb25l
MygpIHdpdGggZXhpdF9zaWduYWwgbm90IGZpdHRpbmcgaW50byBDU0lHTkFMIG1hc2sgKi8K
LQl0ZXN0X2Nsb25lMygwLCAwLCAtRUlOVkFMLCBDTE9ORTNfQVJHU19JTlZBTF9FWElUX1NJ
R05BTF9DU0lHKTsKK3R5cGVkZWYgYm9vbCAoKmZpbHRlcl9mdW5jdGlvbikodm9pZCk7Cit0
eXBlZGVmIHNpemVfdCAoKnNpemVfZnVuY3Rpb24pKHZvaWQpOwogCi0JLyogRG8gYSBjbG9u
ZTMoKSB3aXRoIE5TSUcgPCBleGl0X3NpZ25hbCA8IENTSUcgKi8KLQl0ZXN0X2Nsb25lMygw
LCAwLCAtRUlOVkFMLCBDTE9ORTNfQVJHU19JTlZBTF9FWElUX1NJR05BTF9OU0lHKTsKK3N0
YXRpYyBib29sIG5vdF9yb290KHZvaWQpCit7CisJaWYgKGdldHVpZCgpICE9IDApIHsKKwkJ
a3NmdF9wcmludF9tc2coIk5vdCBydW5uaW5nIGFzIHJvb3RcbiIpOworCQlyZXR1cm4gdHJ1
ZTsKKwl9CiAKLQl0ZXN0X2Nsb25lMygwLCBzaXplb2Yoc3RydWN0IF9fY2xvbmVfYXJncykg
KyA4LCAwLCBDTE9ORTNfQVJHU19BTExfMCk7CisJcmV0dXJuIGZhbHNlOworfQogCi0JdGVz
dF9jbG9uZTMoMCwgc2l6ZW9mKHN0cnVjdCBfX2Nsb25lX2FyZ3MpICsgMTYsIC1FMkJJRywK
LQkJCUNMT05FM19BUkdTX0FMTF8wKTsKK3N0YXRpYyBzaXplX3QgcGFnZV9zaXplX3BsdXNf
OCh2b2lkKQoreworCXJldHVybiBnZXRwYWdlc2l6ZSgpICsgODsKK30KIAotCXRlc3RfY2xv
bmUzKDAsIHNpemVvZihzdHJ1Y3QgX19jbG9uZV9hcmdzKSAqIDIsIC1FMkJJRywKLQkJCUNM
T05FM19BUkdTX0FMTF8wKTsKK3N0cnVjdCB0ZXN0IHsKKwljb25zdCBjaGFyICpuYW1lOwor
CXVpbnQ2NF90IGZsYWdzOworCXNpemVfdCBzaXplOworCXNpemVfZnVuY3Rpb24gc2l6ZV9m
dW5jdGlvbjsKKwlpbnQgZXhwZWN0ZWQ7CisJZW51bSB0ZXN0X21vZGUgdGVzdF9tb2RlOwor
CWZpbHRlcl9mdW5jdGlvbiBmaWx0ZXI7Cit9OwogCi0JLyogRG8gYSBjbG9uZTMoKSB3aXRo
ID4gcGFnZSBzaXplICovCi0JdGVzdF9jbG9uZTMoMCwgZ2V0cGFnZXNpemUoKSArIDgsIC1F
MkJJRywgQ0xPTkUzX0FSR1NfTk9fVEVTVCk7CitzdGF0aWMgY29uc3Qgc3RydWN0IHRlc3Qg
dGVzdHNbXSA9IHsKKwl7CisJCS5uYW1lID0gInNpbXBsZSBjbG9uZTMoKSIsCisJCS5mbGFn
cyA9IDAsCisJCS5zaXplID0gMCwKKwkJLmV4cGVjdGVkID0gMCwKKwkJLnRlc3RfbW9kZSA9
IENMT05FM19BUkdTX05PX1RFU1QsCisJfSwKKwl7CisJCS5uYW1lID0gImNsb25lMygpIGlu
IGEgbmV3IFBJRF9OUyIsCisJCS5mbGFncyA9IENMT05FX05FV1BJRCwKKwkJLnNpemUgPSAw
LAorCQkuZXhwZWN0ZWQgPSAwLAorCQkudGVzdF9tb2RlID0gQ0xPTkUzX0FSR1NfTk9fVEVT
VCwKKwkJLmZpbHRlciA9IG5vdF9yb290LAorCX0sCisJeworCQkubmFtZSA9ICJDTE9ORV9B
UkdTX1NJWkVfVkVSMCIsCisJCS5mbGFncyA9IDAsCisJCS5zaXplID0gQ0xPTkVfQVJHU19T
SVpFX1ZFUjAsCisJCS5leHBlY3RlZCA9IDAsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJH
U19OT19URVNULAorCX0sCisJeworCQkubmFtZSA9ICJDTE9ORV9BUkdTX1NJWkVfVkVSMCAt
IDgiLAorCQkuZmxhZ3MgPSAwLAorCQkuc2l6ZSA9IENMT05FX0FSR1NfU0laRV9WRVIwIC0g
OCwKKwkJLmV4cGVjdGVkID0gLUVJTlZBTCwKKwkJLnRlc3RfbW9kZSA9IENMT05FM19BUkdT
X05PX1RFU1QsCisJfSwKKwl7CisJCS5uYW1lID0gInNpemVvZihzdHJ1Y3QgY2xvbmVfYXJn
cykgKyA4IiwKKwkJLmZsYWdzID0gMCwKKwkJLnNpemUgPSBzaXplb2Yoc3RydWN0IF9fY2xv
bmVfYXJncykgKyA4LAorCQkuZXhwZWN0ZWQgPSAwLAorCQkudGVzdF9tb2RlID0gQ0xPTkUz
X0FSR1NfTk9fVEVTVCwKKwl9LAorCXsKKwkJLm5hbWUgPSAiZXhpdF9zaWduYWwgd2l0aCBo
aWdoZXN0IDMyIGJpdHMgbm9uLXplcm8iLAorCQkuZmxhZ3MgPSAwLAorCQkuc2l6ZSA9IDAs
CisJCS5leHBlY3RlZCA9IC1FSU5WQUwsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19J
TlZBTF9FWElUX1NJR05BTF9CSUcsCisJfSwKKwl7CisJCS5uYW1lID0gIm5lZ2F0aXZlIDMy
LWJpdCBleGl0X3NpZ25hbCIsCisJCS5mbGFncyA9IDAsCisJCS5zaXplID0gMCwKKwkJLmV4
cGVjdGVkID0gLUVJTlZBTCwKKwkJLnRlc3RfbW9kZSA9IENMT05FM19BUkdTX0lOVkFMX0VY
SVRfU0lHTkFMX05FRywKKwl9LAorCXsKKwkJLm5hbWUgPSAiZXhpdF9zaWduYWwgbm90IGZp
dHRpbmcgaW50byBDU0lHTkFMIG1hc2siLAorCQkuZmxhZ3MgPSAwLAorCQkuc2l6ZSA9IDAs
CisJCS5leHBlY3RlZCA9IC1FSU5WQUwsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19J
TlZBTF9FWElUX1NJR05BTF9DU0lHLAorCX0sCisJeworCQkubmFtZSA9ICJOU0lHIDwgZXhp
dF9zaWduYWwgPCBDU0lHIiwKKwkJLmZsYWdzID0gMCwKKwkJLnNpemUgPSAwLAorCQkuZXhw
ZWN0ZWQgPSAtRUlOVkFMLAorCQkudGVzdF9tb2RlID0gQ0xPTkUzX0FSR1NfSU5WQUxfRVhJ
VF9TSUdOQUxfTlNJRywKKwl9LAorCXsKKwkJLm5hbWUgPSAiQXJndW1lbnRzIHNpemVvZihz
dHJ1Y3QgY2xvbmVfYXJncykgKyA4IiwKKwkJLmZsYWdzID0gMCwKKwkJLnNpemUgPSBzaXpl
b2Yoc3RydWN0IF9fY2xvbmVfYXJncykgKyA4LAorCQkuZXhwZWN0ZWQgPSAwLAorCQkudGVz
dF9tb2RlID0gQ0xPTkUzX0FSR1NfQUxMXzAsCisJfSwKKwl7CisJCS5uYW1lID0gIkFyZ3Vt
ZW50cyBzaXplb2Yoc3RydWN0IGNsb25lX2FyZ3MpICsgMTYiLAorCQkuZmxhZ3MgPSAwLAor
CQkuc2l6ZSA9IHNpemVvZihzdHJ1Y3QgX19jbG9uZV9hcmdzKSArIDE2LAorCQkuZXhwZWN0
ZWQgPSAtRTJCSUcsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19BTExfMCwKKwl9LAor
CXsKKwkJLm5hbWUgPSAiQXJndW1lbnRzIHNpemVvZihzdHJ1Y3QgY2xvbmVfYXJnKSAqIDIi
LAorCQkuZmxhZ3MgPSAwLAorCQkuc2l6ZSA9IHNpemVvZihzdHJ1Y3QgX19jbG9uZV9hcmdz
KSArIDE2LAorCQkuZXhwZWN0ZWQgPSAtRTJCSUcsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNf
QVJHU19BTExfMCwKKwl9LAorCXsKKwkJLm5hbWUgPSAiQXJndW1lbnRzID4gcGFnZSBzaXpl
IiwKKwkJLmZsYWdzID0gMCwKKwkJLnNpemVfZnVuY3Rpb24gPSBwYWdlX3NpemVfcGx1c184
LAorCQkuZXhwZWN0ZWQgPSAtRTJCSUcsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19O
T19URVNULAorCX0sCisJeworCQkubmFtZSA9ICJDTE9ORV9BUkdTX1NJWkVfVkVSMCBpbiBh
IG5ldyBQSUQgTlMiLAorCQkuZmxhZ3MgPSBDTE9ORV9ORVdQSUQsCisJCS5zaXplID0gQ0xP
TkVfQVJHU19TSVpFX1ZFUjAsCisJCS5leHBlY3RlZCA9IDAsCisJCS50ZXN0X21vZGUgPSBD
TE9ORTNfQVJHU19OT19URVNULAorCQkuZmlsdGVyID0gbm90X3Jvb3QsCisJfSwKKwl7CisJ
CS5uYW1lID0gIkNMT05FX0FSR1NfU0laRV9WRVIwIC0gOCBpbiBhIG5ldyBQSUQgTlMiLAor
CQkuZmxhZ3MgPSBDTE9ORV9ORVdQSUQsCisJCS5zaXplID0gQ0xPTkVfQVJHU19TSVpFX1ZF
UjAgLSA4LAorCQkuZXhwZWN0ZWQgPSAtRUlOVkFMLAorCQkudGVzdF9tb2RlID0gQ0xPTkUz
X0FSR1NfTk9fVEVTVCwKKwl9LAorCXsKKwkJLm5hbWUgPSAic2l6ZW9mKHN0cnVjdCBjbG9u
ZV9hcmdzKSArIDggaW4gYSBuZXcgUElEIE5TIiwKKwkJLmZsYWdzID0gQ0xPTkVfTkVXUElE
LAorCQkuc2l6ZSA9IHNpemVvZihzdHJ1Y3QgX19jbG9uZV9hcmdzKSArIDgsCisJCS5leHBl
Y3RlZCA9IDAsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19OT19URVNULAorCQkuZmls
dGVyID0gbm90X3Jvb3QsCisJfSwKKwl7CisJCS5uYW1lID0gIkFyZ3VtZW50cyA+IHBhZ2Ug
c2l6ZSBpbiBhIG5ldyBQSUQgTlMiLAorCQkuZmxhZ3MgPSBDTE9ORV9ORVdQSUQsCisJCS5z
aXplX2Z1bmN0aW9uID0gcGFnZV9zaXplX3BsdXNfOCwKKwkJLmV4cGVjdGVkID0gLUUyQklH
LAorCQkudGVzdF9tb2RlID0gQ0xPTkUzX0FSR1NfTk9fVEVTVCwKKwl9LAorCXsKKwkJLm5h
bWUgPSAiTmV3IHRpbWUgTlMiLAorCQkuZmxhZ3MgPSBDTE9ORV9ORVdUSU1FLAorCQkuc2l6
ZSA9IDAsCisJCS5leHBlY3RlZCA9IDAsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19O
T19URVNULAorCX0sCisJeworCQkubmFtZSA9ICJleGl0IHNpZ25hbCAoU0lHQ0hMRCkgaW4g
ZmxhZ3MiLAorCQkuZmxhZ3MgPSBTSUdDSExELAorCQkuc2l6ZSA9IDAsCisJCS5leHBlY3Rl
ZCA9IC1FSU5WQUwsCisJCS50ZXN0X21vZGUgPSBDTE9ORTNfQVJHU19OT19URVNULAorCX0s
Cit9OwogCi0JLyogRG8gYSBjbG9uZTMoKSB3aXRoIENMT05FX0FSR1NfU0laRV9WRVIwIGlu
IGEgbmV3IFBJRCBOUy4gKi8KLQlpZiAodWlkID09IDApCi0JCXRlc3RfY2xvbmUzKENMT05F
X05FV1BJRCwgQ0xPTkVfQVJHU19TSVpFX1ZFUjAsIDAsCi0JCQkJQ0xPTkUzX0FSR1NfTk9f
VEVTVCk7Ci0JZWxzZQotCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoIlNraXBwaW5nIGNsb25l
MygpIHdpdGggQ0xPTkVfTkVXUElEXG4iKTsKK2ludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCit7CisJc2l6ZV90IHNpemU7CisJaW50IGk7CiAKLQkvKiBEbyBhIGNsb25lMygp
IHdpdGggQ0xPTkVfQVJHU19TSVpFX1ZFUjAgLSA4IGluIGEgbmV3IFBJRCBOUyAqLwotCXRl
c3RfY2xvbmUzKENMT05FX05FV1BJRCwgQ0xPTkVfQVJHU19TSVpFX1ZFUjAgLSA4LCAtRUlO
VkFMLAotCQkJQ0xPTkUzX0FSR1NfTk9fVEVTVCk7CisJa3NmdF9wcmludF9oZWFkZXIoKTsK
Kwlrc2Z0X3NldF9wbGFuKEFSUkFZX1NJWkUodGVzdHMpKTsKKwl0ZXN0X2Nsb25lM19zdXBw
b3J0ZWQoKTsKIAotCS8qIERvIGEgY2xvbmUzKCkgd2l0aCBzaXplb2Yoc3RydWN0IGNsb25l
X2FyZ3MpICsgOCBpbiBhIG5ldyBQSUQgTlMgKi8KLQlpZiAodWlkID09IDApCi0JCXRlc3Rf
Y2xvbmUzKENMT05FX05FV1BJRCwgc2l6ZW9mKHN0cnVjdCBfX2Nsb25lX2FyZ3MpICsgOCwg
MCwKLQkJCQlDTE9ORTNfQVJHU19OT19URVNUKTsKLQllbHNlCi0JCWtzZnRfdGVzdF9yZXN1
bHRfc2tpcCgiU2tpcHBpbmcgY2xvbmUzKCkgd2l0aCBDTE9ORV9ORVdQSURcbiIpOworCWZv
ciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHRlc3RzKTsgaSsrKSB7CisJCWlmICh0ZXN0c1tp
XS5maWx0ZXIgJiYgdGVzdHNbaV0uZmlsdGVyKCkpIHsKKwkJCWtzZnRfdGVzdF9yZXN1bHRf
c2tpcCgiJXNcbiIsIHRlc3RzW2ldLm5hbWUpOworCQkJY29udGludWU7CisJCX0KIAotCS8q
IERvIGEgY2xvbmUzKCkgd2l0aCA+IHBhZ2Ugc2l6ZSBpbiBhIG5ldyBQSUQgTlMgKi8KLQl0
ZXN0X2Nsb25lMyhDTE9ORV9ORVdQSUQsIGdldHBhZ2VzaXplKCkgKyA4LCAtRTJCSUcsCi0J
CQlDTE9ORTNfQVJHU19OT19URVNUKTsKKwkJaWYgKHRlc3RzW2ldLnNpemVfZnVuY3Rpb24p
CisJCQlzaXplID0gdGVzdHNbaV0uc2l6ZV9mdW5jdGlvbigpOworCQllbHNlCisJCQlzaXpl
ID0gdGVzdHNbaV0uc2l6ZTsKIAotCS8qIERvIGEgY2xvbmUzKCkgaW4gYSBuZXcgdGltZSBu
YW1lc3BhY2UgKi8KLQl0ZXN0X2Nsb25lMyhDTE9ORV9ORVdUSU1FLCAwLCAwLCBDTE9ORTNf
QVJHU19OT19URVNUKTsKKwkJa3NmdF9wcmludF9tc2coIlJ1bm5pbmcgdGVzdCAnJXMnXG4i
LCB0ZXN0c1tpXS5uYW1lKTsKIAotCS8qIERvIGEgY2xvbmUzKCkgd2l0aCBleGl0IHNpZ25h
bCAoU0lHQ0hMRCkgaW4gZmxhZ3MgKi8KLQl0ZXN0X2Nsb25lMyhTSUdDSExELCAwLCAtRUlO
VkFMLCBDTE9ORTNfQVJHU19OT19URVNUKTsKKwkJa3NmdF90ZXN0X3Jlc3VsdCh0ZXN0X2Ns
b25lMyh0ZXN0c1tpXS5mbGFncywgc2l6ZSwKKwkJCQkJICAgICB0ZXN0c1tpXS5leHBlY3Rl
ZCwKKwkJCQkJICAgICB0ZXN0c1tpXS50ZXN0X21vZGUpLAorCQkJCSAiJXNcbiIsIHRlc3Rz
W2ldLm5hbWUpOworCX0KIAogCWtzZnRfZmluaXNoZWQoKTsKIH0KZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfY2FwX2NoZWNrcG9pbnRfcmVz
dG9yZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lM19jYXBfY2hl
Y2twb2ludF9yZXN0b3JlLmMKaW5kZXggNTJkM2YwMzY0YmRhLi4zMWI1NmQ2MjU2NTUgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfY2FwX2No
ZWNrcG9pbnRfcmVzdG9yZS5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25l
My9jbG9uZTNfY2FwX2NoZWNrcG9pbnRfcmVzdG9yZS5jCkBAIC0yNyw5ICsyNyw3IEBACiAj
aW5jbHVkZSAiLi4va3NlbGZ0ZXN0X2hhcm5lc3MuaCIKICNpbmNsdWRlICJjbG9uZTNfc2Vs
ZnRlc3RzLmgiCiAKLSNpZm5kZWYgTUFYX1BJRF9OU19MRVZFTAogI2RlZmluZSBNQVhfUElE
X05TX0xFVkVMIDMyCi0jZW5kaWYKIAogc3RhdGljIHZvaWQgY2hpbGRfZXhpdChpbnQgcmV0
KQogewpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25l
M19jbGVhcl9zaWdoYW5kLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xv
bmUzX2NsZWFyX3NpZ2hhbmQuYwppbmRleCA0N2E4YzBmYzM2NzYuLjU0YThiMjQ0NWJlOSAx
MDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lM19jbGVh
cl9zaWdoYW5kLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25l
M19jbGVhcl9zaWdoYW5kLmMKQEAgLTE2LDEwICsxNiw2IEBACiAjaW5jbHVkZSAiLi4va3Nl
bGZ0ZXN0LmgiCiAjaW5jbHVkZSAiY2xvbmUzX3NlbGZ0ZXN0cy5oIgogCi0jaWZuZGVmIENM
T05FX0NMRUFSX1NJR0hBTkQKLSNkZWZpbmUgQ0xPTkVfQ0xFQVJfU0lHSEFORCAweDEwMDAw
MDAwMFVMTAotI2VuZGlmCi0KIHN0YXRpYyB2b2lkIG5vcF9oYW5kbGVyKGludCBzaWdubykK
IHsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9u
ZTNfc2VsZnRlc3RzLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xvbmUz
X3NlbGZ0ZXN0cy5oCmluZGV4IGU4MWZmYWFlZTAyYi4uM2QyNjYzZmU1MGJhIDEwMDY0NAot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xvbmUzX3NlbGZ0ZXN0cy5o
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfc2VsZnRlc3Rz
LmgKQEAgLTE1LDEwICsxNSw2IEBACiAKICNkZWZpbmUgcHRyX3RvX3U2NChwdHIpICgoX191
NjQpKCh1aW50cHRyX3QpKHB0cikpKQogCi0jaWZuZGVmIENMT05FX0lOVE9fQ0dST1VQCi0j
ZGVmaW5lIENMT05FX0lOVE9fQ0dST1VQIDB4MjAwMDAwMDAwVUxMIC8qIENsb25lIGludG8g
YSBzcGVjaWZpYyBjZ3JvdXAgZ2l2ZW4gdGhlIHJpZ2h0IHBlcm1pc3Npb25zLiAqLwotI2Vu
ZGlmCi0KICNpZm5kZWYgX19OUl9jbG9uZTMKICNkZWZpbmUgX19OUl9jbG9uZTMgLTEKICNl
bmRpZgpAQCAtMzIsMTggKzI4LDkgQEAgc3RydWN0IF9fY2xvbmVfYXJncyB7CiAJX19hbGln
bmVkX3U2NCBzdGFjazsKIAlfX2FsaWduZWRfdTY0IHN0YWNrX3NpemU7CiAJX19hbGlnbmVk
X3U2NCB0bHM7Ci0jaWZuZGVmIENMT05FX0FSR1NfU0laRV9WRVIwCi0jZGVmaW5lIENMT05F
X0FSR1NfU0laRV9WRVIwIDY0CS8qIHNpemVvZiBmaXJzdCBwdWJsaXNoZWQgc3RydWN0ICov
Ci0jZW5kaWYKIAlfX2FsaWduZWRfdTY0IHNldF90aWQ7CiAJX19hbGlnbmVkX3U2NCBzZXRf
dGlkX3NpemU7Ci0jaWZuZGVmIENMT05FX0FSR1NfU0laRV9WRVIxCi0jZGVmaW5lIENMT05F
X0FSR1NfU0laRV9WRVIxIDgwCS8qIHNpemVvZiBzZWNvbmQgcHVibGlzaGVkIHN0cnVjdCAq
LwotI2VuZGlmCiAJX19hbGlnbmVkX3U2NCBjZ3JvdXA7Ci0jaWZuZGVmIENMT05FX0FSR1Nf
U0laRV9WRVIyCi0jZGVmaW5lIENMT05FX0FSR1NfU0laRV9WRVIyIDg4CS8qIHNpemVvZiB0
aGlyZCBwdWJsaXNoZWQgc3RydWN0ICovCi0jZW5kaWYKIH07CiAKIHN0YXRpYyBwaWRfdCBz
eXNfY2xvbmUzKHN0cnVjdCBfX2Nsb25lX2FyZ3MgKmFyZ3MsIHNpemVfdCBzaXplKQpkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lM19zZXRfdGlk
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xvbmUzX3NldF90aWQuYwpp
bmRleCAwMjI5ZTllYmI5OTUuLmVkNzg1YWZiNjA3NyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lM19zZXRfdGlkLmMKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lM19zZXRfdGlkLmMKQEAgLTIzLDkgKzIzLDcg
QEAKICNpbmNsdWRlICIuLi9rc2VsZnRlc3QuaCIKICNpbmNsdWRlICJjbG9uZTNfc2VsZnRl
c3RzLmgiCiAKLSNpZm5kZWYgTUFYX1BJRF9OU19MRVZFTAogI2RlZmluZSBNQVhfUElEX05T
X0xFVkVMIDMyCi0jZW5kaWYKIAogc3RhdGljIGludCBwaXBlXzFbMl07CiBzdGF0aWMgaW50
IHBpcGVfMlsyXTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NvcmUv
Y2xvc2VfcmFuZ2VfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29yZS9jbG9z
ZV9yYW5nZV90ZXN0LmMKaW5kZXggNzQ5MjM5OTMwY2E4Li41MzQ1NzZmMDZkZjEgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NvcmUvY2xvc2VfcmFuZ2VfdGVzdC5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NvcmUvY2xvc2VfcmFuZ2VfdGVzdC5j
CkBAIC0xNiwzNCArMTYsNiBAQAogI2luY2x1ZGUgIi4uL2tzZWxmdGVzdF9oYXJuZXNzLmgi
CiAjaW5jbHVkZSAiLi4vY2xvbmUzL2Nsb25lM19zZWxmdGVzdHMuaCIKIAotI2lmbmRlZiBf
X05SX2Nsb3NlX3JhbmdlCi0JI2lmIGRlZmluZWQgX19hbHBoYV9fCi0JCSNkZWZpbmUgX19O
Ul9jbG9zZV9yYW5nZSA1NDYKLQkjZWxpZiBkZWZpbmVkIF9NSVBTX1NJTQotCQkjaWYgX01J
UFNfU0lNID09IF9NSVBTX1NJTV9BQkkzMgkvKiBvMzIgKi8KLQkJCSNkZWZpbmUgX19OUl9j
bG9zZV9yYW5nZSAoNDM2ICsgNDAwMCkKLQkJI2VuZGlmCi0JCSNpZiBfTUlQU19TSU0gPT0g
X01JUFNfU0lNX05BQkkzMgkvKiBuMzIgKi8KLQkJCSNkZWZpbmUgX19OUl9jbG9zZV9yYW5n
ZSAoNDM2ICsgNjAwMCkKLQkJI2VuZGlmCi0JCSNpZiBfTUlQU19TSU0gPT0gX01JUFNfU0lN
X0FCSTY0CS8qIG42NCAqLwotCQkJI2RlZmluZSBfX05SX2Nsb3NlX3JhbmdlICg0MzYgKyA1
MDAwKQotCQkjZW5kaWYKLQkjZWxpZiBkZWZpbmVkIF9faWE2NF9fCi0JCSNkZWZpbmUgX19O
Ul9jbG9zZV9yYW5nZSAoNDM2ICsgMTAyNCkKLQkjZWxzZQotCQkjZGVmaW5lIF9fTlJfY2xv
c2VfcmFuZ2UgNDM2Ci0JI2VuZGlmCi0jZW5kaWYKLQotI2lmbmRlZiBDTE9TRV9SQU5HRV9V
TlNIQVJFCi0jZGVmaW5lIENMT1NFX1JBTkdFX1VOU0hBUkUJKDFVIDw8IDEpCi0jZW5kaWYK
LQotI2lmbmRlZiBDTE9TRV9SQU5HRV9DTE9FWEVDCi0jZGVmaW5lIENMT1NFX1JBTkdFX0NM
T0VYRUMJKDFVIDw8IDIpCi0jZW5kaWYKLQogc3RhdGljIGlubGluZSBpbnQgc3lzX2Nsb3Nl
X3JhbmdlKHVuc2lnbmVkIGludCBmZCwgdW5zaWduZWQgaW50IG1heF9mZCwKIAkJCQkgIHVu
c2lnbmVkIGludCBmbGFncykKIHsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2RhbW9uL2RlYnVnZnNfYXR0cnMuc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9k
YW1vbi9kZWJ1Z2ZzX2F0dHJzLnNoCm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL2RlYnVnZnNfZHVw
bGljYXRlX2NvbnRleHRfY3JlYXRpb24uc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9k
YW1vbi9kZWJ1Z2ZzX2R1cGxpY2F0ZV9jb250ZXh0X2NyZWF0aW9uLnNoCm9sZCBtb2RlIDEw
MDY0NApuZXcgbW9kZSAxMDA3NTUKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2RhbW9uL2RlYnVnZnNfZW1wdHlfdGFyZ2V0cy5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2RhbW9uL2RlYnVnZnNfZW1wdHlfdGFyZ2V0cy5zaApvbGQgbW9kZSAxMDA2NDQK
bmV3IG1vZGUgMTAwNzU1CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9k
YW1vbi9kZWJ1Z2ZzX2h1Z2VfY291bnRfcmVhZF93cml0ZS5zaCBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2RhbW9uL2RlYnVnZnNfaHVnZV9jb3VudF9yZWFkX3dyaXRlLnNoCm9sZCBt
b2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2RhbW9uL2RlYnVnZnNfcm1fbm9uX2NvbnRleHRzLnNoIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZGFtb24vZGVidWdmc19ybV9ub25fY29udGV4dHMuc2gKb2xkIG1v
ZGUgMTAwNjQ0Cm5ldyBtb2RlIDEwMDc1NQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZGFtb24vZGVidWdmc19zY2hlbWVzLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZGFtb24vZGVidWdmc19zY2hlbWVzLnNoCm9sZCBtb2RlIDEwMDY0NApuZXcgbW9k
ZSAxMDA3NTUKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL2Rl
YnVnZnNfdGFyZ2V0X2lkcy5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL2Rl
YnVnZnNfdGFyZ2V0X2lkcy5zaApvbGQgbW9kZSAxMDA2NDQKbmV3IG1vZGUgMTAwNzU1CmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kYW1vbi9scnVfc29ydC5zaCBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL2xydV9zb3J0LnNoCm9sZCBtb2RlIDEw
MDY0NApuZXcgbW9kZSAxMDA3NTUKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2RhbW9uL3JlY2xhaW0uc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kYW1vbi9y
ZWNsYWltLnNoCm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL3N5c2ZzLnNoIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvZGFtb24vc3lzZnMuc2gKb2xkIG1vZGUgMTAwNjQ0Cm5ldyBtb2RlIDEw
MDc1NQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZGFtb24vc3lzZnNf
dXBkYXRlX3JlbW92ZWRfc2NoZW1lX2Rpci5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2RhbW9uL3N5c2ZzX3VwZGF0ZV9yZW1vdmVkX3NjaGVtZV9kaXIuc2gKb2xkIG1vZGUgMTAw
NjQ0Cm5ldyBtb2RlIDEwMDc1NQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvZG1hYnVmLWhlYXBzLy5naXRpZ25vcmUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9k
bWFidWYtaGVhcHMvLmdpdGlnbm9yZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwMDAwMDAuLmI1MDBlNzZiOTA0NQotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2RtYWJ1Zi1oZWFwcy8uZ2l0aWdub3JlCkBAIC0wLDAgKzEgQEAKK2Rt
YWJ1Zi1oZWFwCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9lZml2YXJm
cy9jcmVhdGUtcmVhZC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZWZpdmFyZnMvY3Jl
YXRlLXJlYWQuYwppbmRleCA5Njc0YTE5Mzk2YTMuLjdiYzdhZjRlYjJjMSAxMDA2NDQKLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZWZpdmFyZnMvY3JlYXRlLXJlYWQuYworKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9lZml2YXJmcy9jcmVhdGUtcmVhZC5jCkBAIC0z
Miw4ICszMiwxMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJcmMgPSBy
ZWFkKGZkLCBidWYsIHNpemVvZihidWYpKTsKIAlpZiAocmMgIT0gMCkgewogCQlmcHJpbnRm
KHN0ZGVyciwgIlJlYWRpbmcgYSBuZXcgdmFyIHNob3VsZCByZXR1cm4gRU9GXG4iKTsKKwkJ
Y2xvc2UoZmQpOwogCQlyZXR1cm4gRVhJVF9GQUlMVVJFOwogCX0KIAorCWNsb3NlKGZkKTsK
IAlyZXR1cm4gRVhJVF9TVUNDRVNTOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZXhlYy9leGVjdmVhdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZXhl
Yy9leGVjdmVhdC5jCmluZGV4IDY3YmY3MjU0YTQ4Zi4uYmY3OWQ2NjRjOGU2IDEwMDY0NAot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9leGVjL2V4ZWN2ZWF0LmMKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZXhlYy9leGVjdmVhdC5jCkBAIC0yMyw2ICsyMyw5IEBA
CiAKICNpbmNsdWRlICIuLi9rc2VsZnRlc3QuaCIKIAorI2RlZmluZSBURVNUU19FWFBFQ1RF
RCA1MQorI2RlZmluZSBURVNUX05BTUVfTEVOIChQQVRIX01BWCAqIDQpCisKIHN0YXRpYyBj
aGFyIGxvbmdwYXRoWzIgKiBQQVRIX01BWF0gPSAiIjsKIHN0YXRpYyBjaGFyICplbnZwW10g
PSB7ICJJTl9URVNUPXllcyIsIE5VTEwsIE5VTEwgfTsKIHN0YXRpYyBjaGFyICphcmd2W10g
PSB7ICJleGVjdmVhdCIsICI5OSIsIE5VTEwgfTsKQEAgLTQzLDcxICs0Niw4NSBAQCBzdGF0
aWMgaW50IGV4ZWN2ZWF0XyhpbnQgZmQsIGNvbnN0IGNoYXIgKnBhdGgsIGNoYXIgKiphcmd2
LCBjaGFyICoqZW52cCwKIHN0YXRpYyBpbnQgX2NoZWNrX2V4ZWN2ZWF0X2ZhaWwoaW50IGZk
LCBjb25zdCBjaGFyICpwYXRoLCBpbnQgZmxhZ3MsCiAJCQkJaW50IGV4cGVjdGVkX2Vycm5v
LCBjb25zdCBjaGFyICplcnJub19zdHIpCiB7CisJY2hhciB0ZXN0X25hbWVbVEVTVF9OQU1F
X0xFTl07CiAJaW50IHJjOwogCiAJZXJybm8gPSAwOwotCXByaW50ZigiQ2hlY2sgZmFpbHVy
ZSBvZiBleGVjdmVhdCglZCwgJyVzJywgJWQpIHdpdGggJXMuLi4gIiwKLQkJZmQsIHBhdGg/
OiIobnVsbCkiLCBmbGFncywgZXJybm9fc3RyKTsKKwlzbnByaW50Zih0ZXN0X25hbWUsIHNp
emVvZih0ZXN0X25hbWUpLAorCQkgIkNoZWNrIGZhaWx1cmUgb2YgZXhlY3ZlYXQoJWQsICcl
cycsICVkKSB3aXRoICVzIiwKKwkJIGZkLCBwYXRoPzoiKG51bGwpIiwgZmxhZ3MsIGVycm5v
X3N0cik7CiAJcmMgPSBleGVjdmVhdF8oZmQsIHBhdGgsIGFyZ3YsIGVudnAsIGZsYWdzKTsK
IAogCWlmIChyYyA+IDApIHsKLQkJcHJpbnRmKCJbRkFJTF0gKHVuZXhwZWN0ZWQgc3VjY2Vz
cyBmcm9tIGV4ZWN2ZWF0KDIpKVxuIik7CisJCWtzZnRfcHJpbnRfbXNnKCJ1bmV4cGVjdGVk
IHN1Y2Nlc3MgZnJvbSBleGVjdmVhdCgyKVxuIik7CisJCWtzZnRfdGVzdF9yZXN1bHRfZmFp
bCgiJXNcbiIsIHRlc3RfbmFtZSk7CiAJCXJldHVybiAxOwogCX0KIAlpZiAoZXJybm8gIT0g
ZXhwZWN0ZWRfZXJybm8pIHsKLQkJcHJpbnRmKCJbRkFJTF0gKGV4cGVjdGVkIGVycm5vICVk
ICglcykgbm90ICVkICglcylcbiIsCi0JCQlleHBlY3RlZF9lcnJubywgc3RyZXJyb3IoZXhw
ZWN0ZWRfZXJybm8pLAotCQkJZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisJCWtzZnRfcHJp
bnRfbXNnKCJleHBlY3RlZCBlcnJubyAlZCAoJXMpIG5vdCAlZCAoJXMpXG4iLAorCQkJICAg
ICAgIGV4cGVjdGVkX2Vycm5vLCBzdHJlcnJvcihleHBlY3RlZF9lcnJubyksCisJCQkgICAg
ICAgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgi
JXNcbiIsIHRlc3RfbmFtZSk7CiAJCXJldHVybiAxOwogCX0KLQlwcmludGYoIltPS11cbiIp
OworCWtzZnRfdGVzdF9yZXN1bHRfcGFzcygiJXNcbiIsIHRlc3RfbmFtZSk7CiAJcmV0dXJu
IDA7CiB9CiAKIHN0YXRpYyBpbnQgY2hlY2tfZXhlY3ZlYXRfaW52b2tlZF9yYyhpbnQgZmQs
IGNvbnN0IGNoYXIgKnBhdGgsIGludCBmbGFncywKIAkJCQkgICAgIGludCBleHBlY3RlZF9y
YywgaW50IGV4cGVjdGVkX3JjMikKIHsKKwljaGFyIHRlc3RfbmFtZVtURVNUX05BTUVfTEVO
XTsKIAlpbnQgc3RhdHVzOwogCWludCByYzsKIAlwaWRfdCBjaGlsZDsKIAlpbnQgcGF0aGxl
biA9IHBhdGggPyBzdHJsZW4ocGF0aCkgOiAwOwogCiAJaWYgKHBhdGhsZW4gPiA0MCkKLQkJ
cHJpbnRmKCJDaGVjayBzdWNjZXNzIG9mIGV4ZWN2ZWF0KCVkLCAnJS4yMHMuLi4lcycsICVk
KS4uLiAiLAotCQkJZmQsIHBhdGgsIChwYXRoICsgcGF0aGxlbiAtIDIwKSwgZmxhZ3MpOwor
CQlzbnByaW50Zih0ZXN0X25hbWUsIHNpemVvZih0ZXN0X25hbWUpLAorCQkJICJDaGVjayBz
dWNjZXNzIG9mIGV4ZWN2ZWF0KCVkLCAnJS4yMHMuLi4lcycsICVkKS4uLiAiLAorCQkJIGZk
LCBwYXRoLCAocGF0aCArIHBhdGhsZW4gLSAyMCksIGZsYWdzKTsKIAllbHNlCi0JCXByaW50
ZigiQ2hlY2sgc3VjY2VzcyBvZiBleGVjdmVhdCglZCwgJyVzJywgJWQpLi4uICIsCi0JCQlm
ZCwgcGF0aD86IihudWxsKSIsIGZsYWdzKTsKKwkJc25wcmludGYodGVzdF9uYW1lLCBzaXpl
b2YodGVzdF9uYW1lKSwKKwkJCSAiQ2hlY2sgc3VjY2VzcyBvZiBleGVjdmVhdCglZCwgJyVz
JywgJWQpLi4uICIsCisJCQkgZmQsIHBhdGg/OiIobnVsbCkiLCBmbGFncyk7CisKIAljaGls
ZCA9IGZvcmsoKTsKIAlpZiAoY2hpbGQgPCAwKSB7Ci0JCXByaW50ZigiW0ZBSUxdIChmb3Jr
KCkgZmFpbGVkKVxuIik7CisJCWtzZnRfcGVycm9yKCJmb3JrKCkgZmFpbGVkIik7CisJCWtz
ZnRfdGVzdF9yZXN1bHRfZmFpbCgiJXNcbiIsIHRlc3RfbmFtZSk7CiAJCXJldHVybiAxOwog
CX0KIAlpZiAoY2hpbGQgPT0gMCkgewogCQkvKiBDaGlsZDogZG8gZXhlY3ZlYXQoKS4gKi8K
IAkJcmMgPSBleGVjdmVhdF8oZmQsIHBhdGgsIGFyZ3YsIGVudnAsIGZsYWdzKTsKLQkJcHJp
bnRmKCJbRkFJTF06IGV4ZWN2ZWF0KCkgZmFpbGVkLCByYz0lZCBlcnJubz0lZCAoJXMpXG4i
LAotCQkJcmMsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCQlrc2Z0X3ByaW50X21zZygi
ZXhlY3ZlYXQoKSBmYWlsZWQsIHJjPSVkIGVycm5vPSVkICglcylcbiIsCisJCQkgICAgICAg
cmMsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwo
IiVzXG4iLCB0ZXN0X25hbWUpOwogCQlleGl0KDEpOyAgLyogc2hvdWxkIG5vdCByZWFjaCBo
ZXJlICovCiAJfQogCS8qIFBhcmVudDogd2FpdCBmb3IgJiBjaGVjayBjaGlsZCdzIGV4aXQg
c3RhdHVzLiAqLwogCXJjID0gd2FpdHBpZChjaGlsZCwgJnN0YXR1cywgMCk7CiAJaWYgKHJj
ICE9IGNoaWxkKSB7Ci0JCXByaW50ZigiW0ZBSUxdICh3YWl0cGlkKCVkLC4uLikgcmV0dXJu
ZWQgJWQpXG4iLCBjaGlsZCwgcmMpOworCQlrc2Z0X3ByaW50X21zZygid2FpdHBpZCglZCwu
Li4pIHJldHVybmVkICVkXG4iLCBjaGlsZCwgcmMpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X2Zh
aWwoIiVzXG4iLCB0ZXN0X25hbWUpOwogCQlyZXR1cm4gMTsKIAl9CiAJaWYgKCFXSUZFWElU
RUQoc3RhdHVzKSkgewotCQlwcmludGYoIltGQUlMXSAoY2hpbGQgJWQgZGlkIG5vdCBleGl0
IGNsZWFubHksIHN0YXR1cz0lMDh4KVxuIiwKLQkJCWNoaWxkLCBzdGF0dXMpOworCQlrc2Z0
X3ByaW50X21zZygiY2hpbGQgJWQgZGlkIG5vdCBleGl0IGNsZWFubHksIHN0YXR1cz0lMDh4
XG4iLAorCQkJICAgICAgIGNoaWxkLCBzdGF0dXMpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X2Zh
aWwoIiVzXG4iLCB0ZXN0X25hbWUpOwogCQlyZXR1cm4gMTsKIAl9CiAJaWYgKChXRVhJVFNU
QVRVUyhzdGF0dXMpICE9IGV4cGVjdGVkX3JjKSAmJgogCSAgICAoV0VYSVRTVEFUVVMoc3Rh
dHVzKSAhPSBleHBlY3RlZF9yYzIpKSB7Ci0JCXByaW50ZigiW0ZBSUxdIChjaGlsZCAlZCBl
eGl0ZWQgd2l0aCAlZCBub3QgJWQgbm9yICVkKVxuIiwKLQkJCWNoaWxkLCBXRVhJVFNUQVRV
UyhzdGF0dXMpLCBleHBlY3RlZF9yYywgZXhwZWN0ZWRfcmMyKTsKKwkJa3NmdF9wcmludF9t
c2coImNoaWxkICVkIGV4aXRlZCB3aXRoICVkIG5vdCAlZCBub3IgJWRcbiIsCisJCQkgICAg
ICAgY2hpbGQsIFdFWElUU1RBVFVTKHN0YXR1cyksIGV4cGVjdGVkX3JjLAorCQkJICAgICAg
IGV4cGVjdGVkX3JjMik7CisJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiJXNcbiIsIHRlc3Rf
bmFtZSk7CiAJCXJldHVybiAxOwogCX0KLQlwcmludGYoIltPS11cbiIpOworCWtzZnRfdGVz
dF9yZXN1bHRfcGFzcygiJXNcbiIsIHRlc3RfbmFtZSk7CiAJcmV0dXJuIDA7CiB9CiAKQEAg
LTEyOSwxMSArMTQ2LDkgQEAgc3RhdGljIGludCBvcGVuX29yX2RpZShjb25zdCBjaGFyICpm
aWxlbmFtZSwgaW50IGZsYWdzKQogewogCWludCBmZCA9IG9wZW4oZmlsZW5hbWUsIGZsYWdz
KTsKIAotCWlmIChmZCA8IDApIHsKLQkJcHJpbnRmKCJGYWlsZWQgdG8gb3BlbiAnJXMnOyAi
CisJaWYgKGZkIDwgMCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJGYWlsZWQgdG8gb3BlbiAn
JXMnOyAiCiAJCQkiY2hlY2sgcHJlcmVxdWlzaXRlcyBhcmUgYXZhaWxhYmxlXG4iLCBmaWxl
bmFtZSk7Ci0JCWV4aXQoMSk7Ci0JfQogCXJldHVybiBmZDsKIH0KIApAQCAtMTYyLDggKzE3
Nyw3IEBAIHN0YXRpYyBpbnQgY2hlY2tfZXhlY3ZlYXRfcGF0aG1heChpbnQgcm9vdF9kZmQs
IGNvbnN0IGNoYXIgKnNyYywgaW50IGlzX3NjcmlwdCkKIAkJY2hhciAqY3dkID0gZ2V0Y3dk
KE5VTEwsIDApOwogCiAJCWlmICghY3dkKSB7Ci0JCQlwcmludGYoIkZhaWxlZCB0byBnZXRj
d2QoKSwgZXJybm89JWQgKCVzKVxuIiwKLQkJCSAgICAgICBlcnJubywgc3RyZXJyb3IoZXJy
bm8pKTsKKwkJCWtzZnRfcGVycm9yKCJGYWlsZWQgdG8gZ2V0Y3dkKCkiKTsKIAkJCXJldHVy
biAyOwogCQl9CiAJCXN0cmNweShsb25ncGF0aCwgY3dkKTsKQEAgLTE5MywxMiArMjA3LDEy
IEBAIHN0YXRpYyBpbnQgY2hlY2tfZXhlY3ZlYXRfcGF0aG1heChpbnQgcm9vdF9kZmQsIGNv
bnN0IGNoYXIgKnNyYywgaW50IGlzX3NjcmlwdCkKIAkgKi8KIAlmZCA9IG9wZW4obG9uZ3Bh
dGgsIE9fUkRPTkxZKTsKIAlpZiAoZmQgPiAwKSB7Ci0JCXByaW50ZigiSW52b2tlIGNvcHkg
b2YgJyVzJyB2aWEgZmlsZW5hbWUgb2YgbGVuZ3RoICV6dTpcbiIsCi0JCQlzcmMsIHN0cmxl
bihsb25ncGF0aCkpOworCQlrc2Z0X3ByaW50X21zZygiSW52b2tlIGNvcHkgb2YgJyVzJyB2
aWEgZmlsZW5hbWUgb2YgbGVuZ3RoICV6dTpcbiIsCisJCQkgICAgICAgc3JjLCBzdHJsZW4o
bG9uZ3BhdGgpKTsKIAkJZmFpbCArPSBjaGVja19leGVjdmVhdChmZCwgIiIsIEFUX0VNUFRZ
X1BBVEgpOwogCX0gZWxzZSB7Ci0JCXByaW50ZigiRmFpbGVkIHRvIG9wZW4gbGVuZ3RoICV6
dSBmaWxlbmFtZSwgZXJybm89JWQgKCVzKVxuIiwKLQkJCXN0cmxlbihsb25ncGF0aCksIGVy
cm5vLCBzdHJlcnJvcihlcnJubykpOworCQlrc2Z0X3ByaW50X21zZygiRmFpbGVkIHRvIG9w
ZW4gbGVuZ3RoICV6dSBmaWxlbmFtZSwgZXJybm89JWQgKCVzKVxuIiwKKwkJCSAgICAgICBz
dHJsZW4obG9uZ3BhdGgpLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKIAkJZmFpbCsrOwog
CX0KIApAQCAtNDA1LDI4ICs0MTksMzEgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQogCQljb25zdCBjaGFyICppbl90ZXN0ID0gZ2V0ZW52KCJJTl9URVNUIik7CiAKIAkJ
aWYgKHZlcmJvc2UpIHsKLQkJCXByaW50ZigiICBpbnZva2VkIHdpdGg6Iik7CisJCQlrc2Z0
X3ByaW50X21zZygiaW52b2tlZCB3aXRoOlxuIik7CiAJCQlmb3IgKGlpID0gMDsgaWkgPCBh
cmdjOyBpaSsrKQotCQkJCXByaW50ZigiIFslZF09JyVzJyIsIGlpLCBhcmd2W2lpXSk7Ci0J
CQlwcmludGYoIlxuIik7CisJCQkJa3NmdF9wcmludF9tc2coIlx0WyVkXT0nJXNcbiciLCBp
aSwgYXJndltpaV0pOwogCQl9CiAKIAkJLyogQ2hlY2sgZXhwZWN0ZWQgZW52aXJvbm1lbnQg
dHJhbnNmZXJyZWQuICovCiAJCWlmICghaW5fdGVzdCB8fCBzdHJjbXAoaW5fdGVzdCwgInll
cyIpICE9IDApIHsKLQkJCXByaW50ZigiW0ZBSUxdIChubyBJTl9URVNUPXllcyBpbiBlbnYp
XG4iKTsKKwkJCWtzZnRfcHJpbnRfbXNnKCJubyBJTl9URVNUPXllcyBpbiBlbnZcbiIpOwog
CQkJcmV0dXJuIDE7CiAJCX0KIAogCQkvKiBVc2UgdGhlIGZpbmFsIGFyZ3VtZW50IGFzIGFu
IGV4aXQgY29kZS4gKi8KIAkJcmMgPSBhdG9pKGFyZ3ZbYXJnYyAtIDFdKTsKLQkJZmZsdXNo
KHN0ZG91dCk7CisJCWV4aXQocmMpOwogCX0gZWxzZSB7CisJCWtzZnRfcHJpbnRfaGVhZGVy
KCk7CisJCWtzZnRfc2V0X3BsYW4oVEVTVFNfRVhQRUNURUQpOwogCQlwcmVyZXF1aXNpdGVz
KCk7CiAJCWlmICh2ZXJib3NlKQogCQkJZW52cFsxXSA9ICJWRVJCT1NFPTEiOwogCQlyYyA9
IHJ1bl90ZXN0cygpOwogCQlpZiAocmMgPiAwKQogCQkJcHJpbnRmKCIlZCB0ZXN0cyBmYWls
ZWRcbiIsIHJjKTsKKwkJa3NmdF9maW5pc2hlZCgpOwogCX0KKwogCXJldHVybiByYzsKIH0K
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Zpcm13YXJlL2Z3X25hbWVz
cGFjZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlybXdhcmUvZndfbmFtZXNwYWNl
LmMKaW5kZXggNGM2ZjBjZDgzYzViLi4wNDc1N2RjN2U1NDYgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Zpcm13YXJlL2Z3X25hbWVzcGFjZS5jCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Zpcm13YXJlL2Z3X25hbWVzcGFjZS5jCkBAIC0xNywxMCAr
MTcsNiBAQAogI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAK
LSNpZm5kZWYgQ0xPTkVfTkVXTlMKLSMgZGVmaW5lIENMT05FX05FV05TIDB4MDAwMjAwMDAK
LSNlbmRpZgotCiBzdGF0aWMgY2hhciAqZndfcGF0aCA9IE5VTEw7CiAKIHN0YXRpYyB2b2lk
IGRpZShjaGFyICpmbXQsIC4uLikKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2twcm9iZV9hcmdzX2NoYXIudGMgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2twcm9iZS9rcHJvYmVfYXJnc19jaGFy
LnRjCmluZGV4IGZmNzQ5OWViOThkNi4uMjFkYjZiNzIwNzU0IDEwMDY0NAotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2twcm9iZS9rcHJvYmVfYXJnc19j
aGFyLnRjCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3By
b2JlL2twcm9iZV9hcmdzX2NoYXIudGMKQEAgLTI4LDYgKzI4LDEyIEBAIHMzOTAqKQogbWlw
cyopCiAgIEFSRzE9JXI0CiA7OworbG9vbmdhcmNoKikKKyAgQVJHMT0lcjQKKzs7CityaXNj
diopCisgIEFSRzE9JWEwCis7OwogKikKICAgZWNobyAiUGxlYXNlIGltcGxlbWVudCBvdGhl
ciBhcmNoaXRlY3R1cmUgaGVyZSIKICAgZXhpdF91bnRlc3RlZApkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2JlX2FyZ3Nf
c3RyaW5nLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJv
YmUva3Byb2JlX2FyZ3Nfc3RyaW5nLnRjCmluZGV4IGEyMDJiMmVhNGJhZi4uNGUwODZmODcx
Y2VlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5k
L2twcm9iZS9rcHJvYmVfYXJnc19zdHJpbmcudGMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2JlX2FyZ3Nfc3RyaW5nLnRjCkBAIC0z
MSw2ICszMSw5IEBAIG1pcHMqKQogbG9vbmdhcmNoKikKICAgQVJHMT0lcjQKIDs7CityaXNj
diopCisgIEFSRzE9JWEwCis7OwogKikKICAgZWNobyAiUGxlYXNlIGltcGxlbWVudCBvdGhl
ciBhcmNoaXRlY3R1cmUgaGVyZSIKICAgZXhpdF91bnRlc3RlZApkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2JlX2FyZ3Nf
c3ludGF4LnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJv
YmUva3Byb2JlX2FyZ3Nfc3ludGF4LnRjCmluZGV4IDFkZjYxZTEzYTgxMi4uOGYxMjkyYWQ4
MGZmIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5k
L2twcm9iZS9rcHJvYmVfYXJnc19zeW50YXgudGMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2JlX2FyZ3Nfc3ludGF4LnRjCkBAIC00
NCw2ICs0NCwxMCBAQCBsb29uZ2FyY2gqKQogICBHT09EUkVHPSVyNAogICBCQURSRUc9JXIx
MgogOzsKK3Jpc2N2KikKKyAgR09PRFJFRz0lYTAKKyAgQkFEUkVHPSVhOAorOzsKICopCiAg
IGVjaG8gIlBsZWFzZSBpbXBsZW1lbnQgb3RoZXIgYXJjaGl0ZWN0dXJlIGhlcmUiCiAgIGV4
aXRfdW50ZXN0ZWQKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxm
dGVzdC5oIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0LmgKaW5kZXggNTI5
ZDI5YTM1OTAwLi5hNzgxZTYzMTE4MTAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2tzZWxmdGVzdC5oCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxm
dGVzdC5oCkBAIC00OCw2ICs0OCw3IEBACiAjaW5jbHVkZSA8c3RkbGliLmg+CiAjaW5jbHVk
ZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8c3RkYXJnLmg+CisjaW5jbHVkZSA8c3RyaW5nLmg+
CiAjaW5jbHVkZSA8c3RkaW8uaD4KICNlbmRpZgogCkBAIC03Nyw2ICs3OCw4IEBACiAjZGVm
aW5lIEtTRlRfWFBBU1MgMwogI2RlZmluZSBLU0ZUX1NLSVAgIDQKIAorI2RlZmluZSBfX3By
aW50ZihhLCBiKSAgIF9fYXR0cmlidXRlX18oKGZvcm1hdChwcmludGYsIGEsIGIpKSkKKwog
LyogY291bnRlcnMgKi8KIHN0cnVjdCBrc2Z0X2NvdW50IHsKIAl1bnNpZ25lZCBpbnQga3Nm
dF9wYXNzOwpAQCAtMTI5LDcgKzEzMiw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrc2Z0X3By
aW50X2hlYWRlcih2b2lkKQogc3RhdGljIGlubGluZSB2b2lkIGtzZnRfc2V0X3BsYW4odW5z
aWduZWQgaW50IHBsYW4pCiB7CiAJa3NmdF9wbGFuID0gcGxhbjsKLQlwcmludGYoIjEuLiVk
XG4iLCBrc2Z0X3BsYW4pOworCXByaW50ZigiMS4uJXVcbiIsIGtzZnRfcGxhbik7CiB9CiAK
IHN0YXRpYyBpbmxpbmUgdm9pZCBrc2Z0X3ByaW50X2NudHModm9pZCkKQEAgLTEzNywxMyAr
MTQwLDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrc2Z0X3ByaW50X2NudHModm9pZCkKIAlp
ZiAoa3NmdF9wbGFuICE9IGtzZnRfdGVzdF9udW0oKSkKIAkJcHJpbnRmKCIjIFBsYW5uZWQg
dGVzdHMgIT0gcnVuIHRlc3RzICgldSAhPSAldSlcbiIsCiAJCQlrc2Z0X3BsYW4sIGtzZnRf
dGVzdF9udW0oKSk7Ci0JcHJpbnRmKCIjIFRvdGFsczogcGFzczolZCBmYWlsOiVkIHhmYWls
OiVkIHhwYXNzOiVkIHNraXA6JWQgZXJyb3I6JWRcbiIsCisJcHJpbnRmKCIjIFRvdGFsczog
cGFzczoldSBmYWlsOiV1IHhmYWlsOiV1IHhwYXNzOiV1IHNraXA6JXUgZXJyb3I6JXVcbiIs
CiAJCWtzZnRfY250LmtzZnRfcGFzcywga3NmdF9jbnQua3NmdF9mYWlsLAogCQlrc2Z0X2Nu
dC5rc2Z0X3hmYWlsLCBrc2Z0X2NudC5rc2Z0X3hwYXNzLAogCQlrc2Z0X2NudC5rc2Z0X3hz
a2lwLCBrc2Z0X2NudC5rc2Z0X2Vycm9yKTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIGtz
ZnRfcHJpbnRfbXNnKGNvbnN0IGNoYXIgKm1zZywgLi4uKQorc3RhdGljIGlubGluZSBfX3By
aW50ZigxLCAyKSB2b2lkIGtzZnRfcHJpbnRfbXNnKGNvbnN0IGNoYXIgKm1zZywgLi4uKQog
ewogCWludCBzYXZlZF9lcnJubyA9IGVycm5vOwogCXZhX2xpc3QgYXJnczsKQEAgLTE1NSw3
ICsxNTgsMjAgQEAgc3RhdGljIGlubGluZSB2b2lkIGtzZnRfcHJpbnRfbXNnKGNvbnN0IGNo
YXIgKm1zZywgLi4uKQogCXZhX2VuZChhcmdzKTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lk
IGtzZnRfdGVzdF9yZXN1bHRfcGFzcyhjb25zdCBjaGFyICptc2csIC4uLikKK3N0YXRpYyBp
bmxpbmUgdm9pZCBrc2Z0X3BlcnJvcihjb25zdCBjaGFyICptc2cpCit7CisjaWZuZGVmIE5P
TElCQworCWtzZnRfcHJpbnRfbXNnKCIlczogJXMgKCVkKVxuIiwgbXNnLCBzdHJlcnJvcihl
cnJubyksIGVycm5vKTsKKyNlbHNlCisJLyoKKwkgKiBub2xpYmMgZG9lc24ndCBwcm92aWRl
IHN0cmVycm9yKCkgYW5kIGl0IHNlZW1zCisJICogaW5hcHByb3ByaWF0ZSB0byBhZGQgb25l
LCBqdXN0IHByaW50IHRoZSBlcnJuby4KKwkgKi8KKwlrc2Z0X3ByaW50X21zZygiJXM6ICVk
KVxuIiwgbXNnLCBlcnJubyk7CisjZW5kaWYKK30KKworc3RhdGljIGlubGluZSBfX3ByaW50
ZigxLCAyKSB2b2lkIGtzZnRfdGVzdF9yZXN1bHRfcGFzcyhjb25zdCBjaGFyICptc2csIC4u
LikKIHsKIAlpbnQgc2F2ZWRfZXJybm8gPSBlcnJubzsKIAl2YV9saXN0IGFyZ3M7CkBAIC0x
NjMsMTMgKzE3OSwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQga3NmdF90ZXN0X3Jlc3VsdF9w
YXNzKGNvbnN0IGNoYXIgKm1zZywgLi4uKQogCWtzZnRfY250LmtzZnRfcGFzcysrOwogCiAJ
dmFfc3RhcnQoYXJncywgbXNnKTsKLQlwcmludGYoIm9rICVkICIsIGtzZnRfdGVzdF9udW0o
KSk7CisJcHJpbnRmKCJvayAldSAiLCBrc2Z0X3Rlc3RfbnVtKCkpOwogCWVycm5vID0gc2F2
ZWRfZXJybm87CiAJdnByaW50Zihtc2csIGFyZ3MpOwogCXZhX2VuZChhcmdzKTsKIH0KIAot
c3RhdGljIGlubGluZSB2b2lkIGtzZnRfdGVzdF9yZXN1bHRfZmFpbChjb25zdCBjaGFyICpt
c2csIC4uLikKK3N0YXRpYyBpbmxpbmUgX19wcmludGYoMSwgMikgdm9pZCBrc2Z0X3Rlc3Rf
cmVzdWx0X2ZhaWwoY29uc3QgY2hhciAqbXNnLCAuLi4pCiB7CiAJaW50IHNhdmVkX2Vycm5v
ID0gZXJybm87CiAJdmFfbGlzdCBhcmdzOwpAQCAtMTc3LDcgKzE5Myw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoY29uc3QgY2hhciAqbXNnLCAuLi4p
CiAJa3NmdF9jbnQua3NmdF9mYWlsKys7CiAKIAl2YV9zdGFydChhcmdzLCBtc2cpOwotCXBy
aW50Zigibm90IG9rICVkICIsIGtzZnRfdGVzdF9udW0oKSk7CisJcHJpbnRmKCJub3Qgb2sg
JXUgIiwga3NmdF90ZXN0X251bSgpKTsKIAllcnJubyA9IHNhdmVkX2Vycm5vOwogCXZwcmlu
dGYobXNnLCBhcmdzKTsKIAl2YV9lbmQoYXJncyk7CkBAIC0xOTUsNyArMjExLDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGtzZnRfdGVzdF9yZXN1bHRfZmFpbChjb25zdCBjaGFyICptc2cs
IC4uLikKIAkJa3NmdF90ZXN0X3Jlc3VsdF9mYWlsKGZtdCwgIyNfX1ZBX0FSR1NfXyk7XAog
CX0gd2hpbGUgKDApCiAKLXN0YXRpYyBpbmxpbmUgdm9pZCBrc2Z0X3Rlc3RfcmVzdWx0X3hm
YWlsKGNvbnN0IGNoYXIgKm1zZywgLi4uKQorc3RhdGljIGlubGluZSBfX3ByaW50ZigxLCAy
KSB2b2lkIGtzZnRfdGVzdF9yZXN1bHRfeGZhaWwoY29uc3QgY2hhciAqbXNnLCAuLi4pCiB7
CiAJaW50IHNhdmVkX2Vycm5vID0gZXJybm87CiAJdmFfbGlzdCBhcmdzOwpAQCAtMjAzLDEz
ICsyMTksMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIGtzZnRfdGVzdF9yZXN1bHRfeGZhaWwo
Y29uc3QgY2hhciAqbXNnLCAuLi4pCiAJa3NmdF9jbnQua3NmdF94ZmFpbCsrOwogCiAJdmFf
c3RhcnQoYXJncywgbXNnKTsKLQlwcmludGYoIm9rICVkICMgWEZBSUwgIiwga3NmdF90ZXN0
X251bSgpKTsKKwlwcmludGYoIm9rICV1ICMgWEZBSUwgIiwga3NmdF90ZXN0X251bSgpKTsK
IAllcnJubyA9IHNhdmVkX2Vycm5vOwogCXZwcmludGYobXNnLCBhcmdzKTsKIAl2YV9lbmQo
YXJncyk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgdm9pZCBrc2Z0X3Rlc3RfcmVzdWx0X3NraXAo
Y29uc3QgY2hhciAqbXNnLCAuLi4pCitzdGF0aWMgaW5saW5lIF9fcHJpbnRmKDEsIDIpIHZv
aWQga3NmdF90ZXN0X3Jlc3VsdF9za2lwKGNvbnN0IGNoYXIgKm1zZywgLi4uKQogewogCWlu
dCBzYXZlZF9lcnJubyA9IGVycm5vOwogCXZhX2xpc3QgYXJnczsKQEAgLTIxNywxNCArMjMz
LDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoY29uc3Qg
Y2hhciAqbXNnLCAuLi4pCiAJa3NmdF9jbnQua3NmdF94c2tpcCsrOwogCiAJdmFfc3RhcnQo
YXJncywgbXNnKTsKLQlwcmludGYoIm9rICVkICMgU0tJUCAiLCBrc2Z0X3Rlc3RfbnVtKCkp
OworCXByaW50Zigib2sgJXUgIyBTS0lQICIsIGtzZnRfdGVzdF9udW0oKSk7CiAJZXJybm8g
PSBzYXZlZF9lcnJubzsKIAl2cHJpbnRmKG1zZywgYXJncyk7CiAJdmFfZW5kKGFyZ3MpOwog
fQogCiAvKiBUT0RPOiBob3cgZG9lcyAiZXJyb3IiIGRpZmZlciBmcm9tICJmYWlsIiBvciAi
c2tpcCI/ICovCi1zdGF0aWMgaW5saW5lIHZvaWQga3NmdF90ZXN0X3Jlc3VsdF9lcnJvcihj
b25zdCBjaGFyICptc2csIC4uLikKK3N0YXRpYyBpbmxpbmUgX19wcmludGYoMSwgMikgdm9p
ZCBrc2Z0X3Rlc3RfcmVzdWx0X2Vycm9yKGNvbnN0IGNoYXIgKm1zZywgLi4uKQogewogCWlu
dCBzYXZlZF9lcnJubyA9IGVycm5vOwogCXZhX2xpc3QgYXJnczsKQEAgLTIzMiw3ICsyNDgs
NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQga3NmdF90ZXN0X3Jlc3VsdF9lcnJvcihjb25zdCBj
aGFyICptc2csIC4uLikKIAlrc2Z0X2NudC5rc2Z0X2Vycm9yKys7CiAKIAl2YV9zdGFydChh
cmdzLCBtc2cpOwotCXByaW50Zigibm90IG9rICVkICMgZXJyb3IgIiwga3NmdF90ZXN0X251
bSgpKTsKKwlwcmludGYoIm5vdCBvayAldSAjIGVycm9yICIsIGtzZnRfdGVzdF9udW0oKSk7
CiAJZXJybm8gPSBzYXZlZF9lcnJubzsKIAl2cHJpbnRmKG1zZywgYXJncyk7CiAJdmFfZW5k
KGFyZ3MpOwpAQCAtMjcxLDcgKzI4Nyw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGtzZnRfZXhp
dF9mYWlsKHZvaWQpCiAJCSAga3NmdF9jbnQua3NmdF94ZmFpbCArCVwKIAkJICBrc2Z0X2Nu
dC5rc2Z0X3hza2lwKQogCi1zdGF0aWMgaW5saW5lIGludCBrc2Z0X2V4aXRfZmFpbF9tc2co
Y29uc3QgY2hhciAqbXNnLCAuLi4pCitzdGF0aWMgaW5saW5lIF9fcHJpbnRmKDEsIDIpIGlu
dCBrc2Z0X2V4aXRfZmFpbF9tc2coY29uc3QgY2hhciAqbXNnLCAuLi4pCiB7CiAJaW50IHNh
dmVkX2Vycm5vID0gZXJybm87CiAJdmFfbGlzdCBhcmdzOwpAQCAtMjk4LDcgKzMxNCw3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGtzZnRfZXhpdF94cGFzcyh2b2lkKQogCWV4aXQoS1NGVF9Y
UEFTUyk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgaW50IGtzZnRfZXhpdF9za2lwKGNvbnN0IGNo
YXIgKm1zZywgLi4uKQorc3RhdGljIGlubGluZSBfX3ByaW50ZigxLCAyKSBpbnQga3NmdF9l
eGl0X3NraXAoY29uc3QgY2hhciAqbXNnLCAuLi4pCiB7CiAJaW50IHNhdmVkX2Vycm5vID0g
ZXJybm87CiAJdmFfbGlzdCBhcmdzOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3ZtL2luY2x1ZGUvdGVzdF91dGlsLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rdm0vaW5jbHVkZS90ZXN0X3V0aWwuaAppbmRleCA3ZTYxNGFkYzZjZjQuLjhlNWY0MTNh
NTkzZCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUv
dGVzdF91dGlsLmgKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUv
dGVzdF91dGlsLmgKQEAgLTMzLDcgKzMzLDcgQEAgc3RhdGljIGlubGluZSBpbnQgX25vX3By
aW50Zihjb25zdCBjaGFyICpmb3JtYXQsIC4uLikgeyByZXR1cm4gMDsgfQogI2RlZmluZSBw
cl9pbmZvKC4uLikgX25vX3ByaW50ZihfX1ZBX0FSR1NfXykKICNlbmRpZgogCi12b2lkIHBy
aW50X3NraXAoY29uc3QgY2hhciAqZm10LCAuLi4pIF9fYXR0cmlidXRlX18oKGZvcm1hdChw
cmludGYsIDEsIDIpKSk7Cit2b2lkIF9fcHJpbnRmKDEsIDIpIHByaW50X3NraXAoY29uc3Qg
Y2hhciAqZm10LCAuLi4pOwogI2RlZmluZSBfX1RFU1RfUkVRVUlSRShmLCBmbXQsIC4uLikJ
CQkJXAogZG8gewkJCQkJCQkJXAogCWlmICghKGYpKQkJCQkJCVwKQEAgLTQ2LDkgKzQ2LDkg
QEAgc3NpemVfdCB0ZXN0X3dyaXRlKGludCBmZCwgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3Qg
Y291bnQpOwogc3NpemVfdCB0ZXN0X3JlYWQoaW50IGZkLCB2b2lkICpidWYsIHNpemVfdCBj
b3VudCk7CiBpbnQgdGVzdF9zZXFfcmVhZChjb25zdCBjaGFyICpwYXRoLCBjaGFyICoqYnVm
cCwgc2l6ZV90ICpzaXplcCk7CiAKLXZvaWQgdGVzdF9hc3NlcnQoYm9vbCBleHAsIGNvbnN0
IGNoYXIgKmV4cF9zdHIsCi0JCSBjb25zdCBjaGFyICpmaWxlLCB1bnNpZ25lZCBpbnQgbGlu
ZSwgY29uc3QgY2hhciAqZm10LCAuLi4pCi0JCV9fYXR0cmlidXRlX18oKGZvcm1hdChwcmlu
dGYsIDUsIDYpKSk7Cit2b2lkIF9fcHJpbnRmKDUsIDYpIHRlc3RfYXNzZXJ0KGJvb2wgZXhw
LCBjb25zdCBjaGFyICpleHBfc3RyLAorCQkJCWNvbnN0IGNoYXIgKmZpbGUsIHVuc2lnbmVk
IGludCBsaW5lLAorCQkJCWNvbnN0IGNoYXIgKmZtdCwgLi4uKTsKIAogI2RlZmluZSBURVNU
X0FTU0VSVChlLCBmbXQsIC4uLikgXAogCXRlc3RfYXNzZXJ0KChlKSwgI2UsIF9fRklMRV9f
LCBfX0xJTkVfXywgZm10LCAjI19fVkFfQVJHU19fKQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbW0vbXJlbWFwX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21tL21yZW1hcF90ZXN0LmMKaW5kZXggNWMzNzczZGU5ZjBmLi4xZGJmY2Y2ZGYyNTUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL21yZW1hcF90ZXN0LmMK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vbXJlbWFwX3Rlc3QuYwpAQCAtMzM4
LDcgKzMzOCw3IEBAIHN0YXRpYyBsb25nIGxvbmcgcmVtYXBfcmVnaW9uKHN0cnVjdCBjb25m
aWcgYywgdW5zaWduZWQgaW50IHRocmVzaG9sZF9tYiwKIAkJY2hhciBjID0gKGNoYXIpIHJh
bmQoKTsKIAogCQlpZiAoKChjaGFyICopIGRlc3RfYWRkcilbaV0gIT0gYykgewotCQkJa3Nm
dF9wcmludF9tc2coIkRhdGEgYWZ0ZXIgcmVtYXAgZG9lc24ndCBtYXRjaCBhdCBvZmZzZXQg
JWRcbiIsCisJCQlrc2Z0X3ByaW50X21zZygiRGF0YSBhZnRlciByZW1hcCBkb2Vzbid0IG1h
dGNoIGF0IG9mZnNldCAlbGx1XG4iLAogCQkJCSAgICAgICBpKTsKIAkJCWtzZnRfcHJpbnRf
bXNnKCJFeHBlY3RlZDogJSN4XHQgR290OiAlI3hcbiIsIGMgJiAweGZmLAogCQkJCQkoKGNo
YXIgKikgZGVzdF9hZGRyKVtpXSAmIDB4ZmYpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbW0vcGtleS1oZWxwZXJzLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9tbS9wa2V5LWhlbHBlcnMuaAppbmRleCA5MmYzYmUzZGQ4ZTUuLjFhZjMxNTZhOWRiOCAx
MDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcGtleS1oZWxwZXJzLmgK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcGtleS1oZWxwZXJzLmgKQEAgLTM0
LDcgKzM0LDcgQEAgZXh0ZXJuIGludCB0ZXN0X25yOwogZXh0ZXJuIGludCBpdGVyYXRpb25f
bnI7CiAKICNpZmRlZiBfX0dOVUNfXwotX19hdHRyaWJ1dGVfXygoZm9ybWF0KHByaW50Ziwg
MSwgMikpKQorX19wcmludGYoMSwgMikKICNlbmRpZgogc3RhdGljIGlubGluZSB2b2lkIHNp
Z3NhZmVfcHJpbnRmKGNvbnN0IGNoYXIgKmZvcm1hdCwgLi4uKQogewpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvb3BlbmF0Mi9vcGVuYXQyX3Rlc3QuYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL29wZW5hdDIvb3BlbmF0Ml90ZXN0LmMKaW5kZXggN2ZiOTAy
MDk5ZGU0Li45MDI0NzU0NTMwYjIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL29wZW5hdDIvb3BlbmF0Ml90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvb3BlbmF0Mi9vcGVuYXQyX3Rlc3QuYwpAQCAtMzAwLDcgKzMwMCw3IEBAIHZvaWQgdGVz
dF9vcGVuYXQyX2ZsYWdzKHZvaWQpCiAKIAkJCWtzZnRfcHJpbnRfbXNnKCJvcGVuYXQyIHVu
ZXhwZWN0ZWRseSByZXR1cm5lZCAiKTsKIAkJCWlmIChmZHBhdGgpCi0JCQkJa3NmdF9wcmlu
dF9tc2coIiVkWyclcyddIHdpdGggJVggKCE9ICVYKVxuIiwKKwkJCQlrc2Z0X3ByaW50X21z
ZygiJWRbJyVzJ10gd2l0aCAlWCAoIT0gJWxsWClcbiIsCiAJCQkJCSAgICAgICBmZCwgZmRw
YXRoLCBmZGZsYWdzLAogCQkJCQkgICAgICAgdGVzdC0+aG93LmZsYWdzKTsKIAkJCWVsc2UK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX2ZkaW5m
b190ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9mZGluZm9f
dGVzdC5jCmluZGV4IDRlODZmOTI3ODgwYy4uMDFjYzM3YmY2MTFjIDEwMDY0NAotLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9mZGluZm9fdGVzdC5jCisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMKQEAg
LTYyLDcgKzYyLDcgQEAgc3RhdGljIHZvaWQgZXJyb3JfcmVwb3J0KHN0cnVjdCBlcnJvciAq
ZXJyLCBjb25zdCBjaGFyICp0ZXN0X25hbWUpCiAJCWJyZWFrOwogCiAJY2FzZSBQSURGRF9Q
QVNTOgotCQlrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoIiVzIHRlc3Q6IFBhc3NlZFxuIik7CisJ
CWtzZnRfdGVzdF9yZXN1bHRfcGFzcygiJXMgdGVzdDogUGFzc2VkXG4iLCB0ZXN0X25hbWUp
OwogCQlicmVhazsKIAogCWRlZmF1bHQ6CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9w
aWRmZC9waWRmZF90ZXN0LmMKaW5kZXggMDBhMDdlN2M1NzFjLi5jMDgxYWU5MTMxM2EgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3Rlc3QuYwor
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMKQEAgLTM4
MSwxMyArMzgxLDEzIEBAIHN0YXRpYyBpbnQgdGVzdF9waWRmZF9zZW5kX3NpZ25hbF9zeXNj
YWxsX3N1cHBvcnQodm9pZCkKIAogc3RhdGljIHZvaWQgKnRlc3RfcGlkZmRfcG9sbF9leGVj
X3RocmVhZCh2b2lkICpwcml2KQogewotCWtzZnRfcHJpbnRfbXNnKCJDaGlsZCBUaHJlYWQ6
IHN0YXJ0aW5nLiBwaWQgJWQgdGlkICVkIDsgYW5kIHNsZWVwaW5nXG4iLAorCWtzZnRfcHJp
bnRfbXNnKCJDaGlsZCBUaHJlYWQ6IHN0YXJ0aW5nLiBwaWQgJWQgdGlkICVsZCA7IGFuZCBz
bGVlcGluZ1xuIiwKIAkJCWdldHBpZCgpLCBzeXNjYWxsKFNZU19nZXR0aWQpKTsKIAlrc2Z0
X3ByaW50X21zZygiQ2hpbGQgVGhyZWFkOiBkb2luZyBleGVjIG9mIHNsZWVwXG4iKTsKIAog
CWV4ZWNsKCIvYmluL3NsZWVwIiwgInNsZWVwIiwgc3RyKENISUxEX1RIUkVBRF9NSU5fV0FJ
VCksIChjaGFyICopTlVMTCk7CiAKLQlrc2Z0X3ByaW50X21zZygiQ2hpbGQgVGhyZWFkOiBE
T05FLiBwaWQgJWQgdGlkICVkXG4iLAorCWtzZnRfcHJpbnRfbXNnKCJDaGlsZCBUaHJlYWQ6
IERPTkUuIHBpZCAlZCB0aWQgJWxkXG4iLAogCQkJZ2V0cGlkKCksIHN5c2NhbGwoU1lTX2dl
dHRpZCkpOwogCXJldHVybiBOVUxMOwogfQpAQCAtNDI3LDcgKzQyNyw3IEBAIHN0YXRpYyBp
bnQgY2hpbGRfcG9sbF9leGVjX3Rlc3Qodm9pZCAqYXJncykKIHsKIAlwdGhyZWFkX3QgdDE7
CiAKLQlrc2Z0X3ByaW50X21zZygiQ2hpbGQgKHBpZGZkKTogc3RhcnRpbmcuIHBpZCAlZCB0
aWQgJWRcbiIsIGdldHBpZCgpLAorCWtzZnRfcHJpbnRfbXNnKCJDaGlsZCAocGlkZmQpOiBz
dGFydGluZy4gcGlkICVkIHRpZCAlbGRcbiIsIGdldHBpZCgpLAogCQkJc3lzY2FsbChTWVNf
Z2V0dGlkKSk7CiAJcHRocmVhZF9jcmVhdGUoJnQxLCBOVUxMLCB0ZXN0X3BpZGZkX3BvbGxf
ZXhlY190aHJlYWQsIE5VTEwpOwogCS8qCkBAIC00ODAsMTAgKzQ4MCwxMCBAQCBzdGF0aWMg
dm9pZCB0ZXN0X3BpZGZkX3BvbGxfZXhlYyhpbnQgdXNlX3dhaXRwaWQpCiAKIHN0YXRpYyB2
b2lkICp0ZXN0X3BpZGZkX3BvbGxfbGVhZGVyX2V4aXRfdGhyZWFkKHZvaWQgKnByaXYpCiB7
Ci0Ja3NmdF9wcmludF9tc2coIkNoaWxkIFRocmVhZDogc3RhcnRpbmcuIHBpZCAlZCB0aWQg
JWQgOyBhbmQgc2xlZXBpbmdcbiIsCisJa3NmdF9wcmludF9tc2coIkNoaWxkIFRocmVhZDog
c3RhcnRpbmcuIHBpZCAlZCB0aWQgJWxkIDsgYW5kIHNsZWVwaW5nXG4iLAogCQkJZ2V0cGlk
KCksIHN5c2NhbGwoU1lTX2dldHRpZCkpOwogCXNsZWVwKENISUxEX1RIUkVBRF9NSU5fV0FJ
VCk7Ci0Ja3NmdF9wcmludF9tc2coIkNoaWxkIFRocmVhZDogRE9ORS4gcGlkICVkIHRpZCAl
ZFxuIiwgZ2V0cGlkKCksIHN5c2NhbGwoU1lTX2dldHRpZCkpOworCWtzZnRfcHJpbnRfbXNn
KCJDaGlsZCBUaHJlYWQ6IERPTkUuIHBpZCAlZCB0aWQgJWxkXG4iLCBnZXRwaWQoKSwgc3lz
Y2FsbChTWVNfZ2V0dGlkKSk7CiAJcmV0dXJuIE5VTEw7CiB9CiAKQEAgLTQ5Miw3ICs0OTIs
NyBAQCBzdGF0aWMgaW50IGNoaWxkX3BvbGxfbGVhZGVyX2V4aXRfdGVzdCh2b2lkICphcmdz
KQogewogCXB0aHJlYWRfdCB0MSwgdDI7CiAKLQlrc2Z0X3ByaW50X21zZygiQ2hpbGQ6IHN0
YXJ0aW5nLiBwaWQgJWQgdGlkICVkXG4iLCBnZXRwaWQoKSwgc3lzY2FsbChTWVNfZ2V0dGlk
KSk7CisJa3NmdF9wcmludF9tc2coIkNoaWxkOiBzdGFydGluZy4gcGlkICVkIHRpZCAlbGRc
biIsIGdldHBpZCgpLCBzeXNjYWxsKFNZU19nZXR0aWQpKTsKIAlwdGhyZWFkX2NyZWF0ZSgm
dDEsIE5VTEwsIHRlc3RfcGlkZmRfcG9sbF9sZWFkZXJfZXhpdF90aHJlYWQsIE5VTEwpOwog
CXB0aHJlYWRfY3JlYXRlKCZ0MiwgTlVMTCwgdGVzdF9waWRmZF9wb2xsX2xlYWRlcl9leGl0
X3RocmVhZCwgTlVMTCk7CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3Jlc2N0cmwvTWFrZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL01h
a2VmaWxlCmluZGV4IDUwNzNkYmM5NjEyNS4uMmRlYWMyMDMxZGU5IDEwMDY0NAotLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvTWFrZWZpbGUKQEAgLTEsNiArMSw2IEBACiAjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiAKLUNGTEFHUyA9IC1nIC1XYWxsIC1P
MiAtRF9GT1JUSUZZX1NPVVJDRT0yCitDRkxBR1MgPSAtZyAtV2FsbCAtTzIgLURfRk9SVElG
WV9TT1VSQ0U9MiAtRF9HTlVfU09VUkNFCiBDRkxBR1MgKz0gJChLSERSX0lOQ0xVREVTKQog
CiBURVNUX0dFTl9QUk9HUyA6PSByZXNjdHJsX3Rlc3RzCmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhY2hlLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL2NhY2hlLmMKaW5kZXggZDNjYmI4MjlmZjZhLi5iY2JjYTM1NmQ1NmEg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2FjaGUuYwor
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhY2hlLmMKQEAgLTIwNSwx
MCArMjA1LDExIEBAIGludCBtZWFzdXJlX2NhY2hlX3ZhbHMoc3RydWN0IHJlc2N0cmxfdmFs
X3BhcmFtICpwYXJhbSwgaW50IGJtX3BpZCkKICAqIGNhY2hlX3ZhbDoJCWV4ZWN1dGUgYmVu
Y2htYXJrIGFuZCBtZWFzdXJlIExMQyBvY2N1cGFuY3kgcmVzY3RybAogICogYW5kIHBlcmYg
Y2FjaGUgbWlzcyBmb3IgdGhlIGJlbmNobWFyawogICogQHBhcmFtOgkJcGFyYW1ldGVycyBw
YXNzZWQgdG8gY2FjaGVfdmFsKCkKKyAqIEBzcGFuOgkJYnVmZmVyIHNpemUgZm9yIHRoZSBi
ZW5jaG1hcmsKICAqCiAgKiBSZXR1cm46CQkwIG9uIHN1Y2Nlc3MuIG5vbi16ZXJvIG9uIGZh
aWx1cmUuCiAgKi8KLWludCBjYXRfdmFsKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFy
YW0pCitpbnQgY2F0X3ZhbChzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFtLCBzaXpl
X3Qgc3BhbikKIHsKIAlpbnQgbWVtZmx1c2ggPSAxLCBvcGVyYXRpb24gPSAwLCByZXQgPSAw
OwogCWNoYXIgKnJlc2N0cmxfdmFsID0gcGFyYW0tPnJlc2N0cmxfdmFsOwpAQCAtMjQ1LDcg
KzI0Niw3IEBAIGludCBjYXRfdmFsKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0p
CiAJCWlmIChyZXQpCiAJCQlicmVhazsKIAotCQlpZiAocnVuX2ZpbGxfYnVmKHBhcmFtLT5z
cGFuLCBtZW1mbHVzaCwgb3BlcmF0aW9uLCB0cnVlKSkgeworCQlpZiAocnVuX2ZpbGxfYnVm
KHNwYW4sIG1lbWZsdXNoLCBvcGVyYXRpb24sIHRydWUpKSB7CiAJCQlmcHJpbnRmKHN0ZGVy
ciwgIkVycm9yLXJ1bm5pbmcgZmlsbCBidWZmZXJcbiIpOwogCQkJcmV0ID0gLTE7CiAJCQln
b3RvIHBlX2Nsb3NlOwpAQCAtMjk0LDcgKzI5NSw3IEBAIGludCBzaG93X2NhY2hlX2luZm8o
dW5zaWduZWQgbG9uZyBzdW1fbGxjX3ZhbCwgaW50IG5vX29mX2JpdHMsCiAJcmV0ID0gcGxh
dGZvcm0gJiYgYWJzKChpbnQpZGlmZl9wZXJjZW50KSA+IG1heF9kaWZmX3BlcmNlbnQgJiYK
IAkgICAgICAoY210ID8gKGFicyhhdmdfZGlmZikgPiBtYXhfZGlmZikgOiB0cnVlKTsKIAot
CWtzZnRfcHJpbnRfbXNnKCIlcyBDaGVjayBjYWNoZSBtaXNzIHJhdGUgd2l0aGluICVkJSVc
biIsCisJa3NmdF9wcmludF9tc2coIiVzIENoZWNrIGNhY2hlIG1pc3MgcmF0ZSB3aXRoaW4g
JWx1JSVcbiIsCiAJCSAgICAgICByZXQgPyAiRmFpbDoiIDogIlBhc3M6IiwgbWF4X2RpZmZf
cGVyY2VudCk7CiAKIAlrc2Z0X3ByaW50X21zZygiUGVyY2VudCBkaWZmPSVkXG4iLCBhYnMo
KGludClkaWZmX3BlcmNlbnQpKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0
cmwvY2F0X3Rlc3QuYwppbmRleCAzODQ4ZGZiNDZhYmEuLjIyNGJhODU0NGQ4YSAxMDA2NDQK
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jCisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYwpAQCAtNDEsNyAr
NDEsNyBAQCBzdGF0aWMgaW50IGNhdF9zZXR1cChzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0g
KnApCiAJcmV0dXJuIHJldDsKIH0KIAotc3RhdGljIGludCBjaGVja19yZXN1bHRzKHN0cnVj
dCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0pCitzdGF0aWMgaW50IGNoZWNrX3Jlc3VsdHMo
c3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSwgc2l6ZV90IHNwYW4pCiB7CiAJY2hh
ciAqdG9rZW5fYXJyYXlbOF0sIHRlbXBbNTEyXTsKIAl1bnNpZ25lZCBsb25nIHN1bV9sbGNf
cGVyZl9taXNzID0gMDsKQEAgLTc2LDcgKzc2LDcgQEAgc3RhdGljIGludCBjaGVja19yZXN1
bHRzKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0pCiAJZmNsb3NlKGZwKTsKIAlu
b19vZl9iaXRzID0gY291bnRfYml0cyhwYXJhbS0+bWFzayk7CiAKLQlyZXR1cm4gc2hvd19j
YWNoZV9pbmZvKHN1bV9sbGNfcGVyZl9taXNzLCBub19vZl9iaXRzLCBwYXJhbS0+c3BhbiAv
IDY0LAorCXJldHVybiBzaG93X2NhY2hlX2luZm8oc3VtX2xsY19wZXJmX21pc3MsIG5vX29m
X2JpdHMsIHNwYW4gLyA2NCwKIAkJCSAgICAgICBNQVhfRElGRiwgTUFYX0RJRkZfUEVSQ0VO
VCwgcnVucyAtIDEsCiAJCQkgICAgICAgZ2V0X3ZlbmRvcigpID09IEFSQ0hfSU5URUwsIGZh
bHNlKTsKIH0KQEAgLTk2LDYgKzk2LDcgQEAgaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBj
cHVfbm8sIGludCBuLCBjaGFyICpjYWNoZV90eXBlKQogCWNoYXIgY2JtX21hc2tbMjU2XTsK
IAlpbnQgY291bnRfb2ZfYml0czsKIAljaGFyIHBpcGVfbWVzc2FnZTsKKwlzaXplX3Qgc3Bh
bjsKIAogCS8qIEdldCBkZWZhdWx0IGNibSBtYXNrIGZvciBMMy9MMiBjYWNoZSAqLwogCXJl
dCA9IGdldF9jYm1fbWFzayhjYWNoZV90eXBlLCBjYm1fbWFzayk7CkBAIC0xNDAsNyArMTQx
LDcgQEAgaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyICpj
YWNoZV90eXBlKQogCS8qIFNldCBwYXJhbSB2YWx1ZXMgZm9yIHBhcmVudCB0aHJlYWQgd2hp
Y2ggd2lsbCBiZSBhbGxvY2F0ZWQgYml0bWFzawogCSAqIHdpdGggKG1heF9iaXRzIC0gbikg
Yml0cwogCSAqLwotCXBhcmFtLnNwYW4gPSBjYWNoZV9zaXplICogKGNvdW50X29mX2JpdHMg
LSBuKSAvIGNvdW50X29mX2JpdHM7CisJc3BhbiA9IGNhY2hlX3NpemUgKiAoY291bnRfb2Zf
Yml0cyAtIG4pIC8gY291bnRfb2ZfYml0czsKIAlzdHJjcHkocGFyYW0uY3RybGdycCwgImMy
Iik7CiAJc3RyY3B5KHBhcmFtLm1vbmdycCwgIm0yIik7CiAJc3RyY3B5KHBhcmFtLmZpbGVu
YW1lLCBSRVNVTFRfRklMRV9OQU1FMik7CkBAIC0xNjIsMjMgKzE2MywxNyBAQCBpbnQgY2F0
X3BlcmZfbWlzc192YWwoaW50IGNwdV9ubywgaW50IG4sIGNoYXIgKmNhY2hlX3R5cGUpCiAJ
CXBhcmFtLm1hc2sgPSBsX21hc2tfMTsKIAkJc3RyY3B5KHBhcmFtLmN0cmxncnAsICJjMSIp
OwogCQlzdHJjcHkocGFyYW0ubW9uZ3JwLCAibTEiKTsKLQkJcGFyYW0uc3BhbiA9IGNhY2hl
X3NpemUgKiBuIC8gY291bnRfb2ZfYml0czsKKwkJc3BhbiA9IGNhY2hlX3NpemUgKiBuIC8g
Y291bnRfb2ZfYml0czsKIAkJc3RyY3B5KHBhcmFtLmZpbGVuYW1lLCBSRVNVTFRfRklMRV9O
QU1FMSk7CiAJCXBhcmFtLm51bV9vZl9ydW5zID0gMDsKIAkJcGFyYW0uY3B1X25vID0gc2li
bGluZ19jcHVfbm87Ci0JfSBlbHNlIHsKLQkJcmV0ID0gc2lnbmFsX2hhbmRsZXJfcmVnaXN0
ZXIoKTsKLQkJaWYgKHJldCkgewotCQkJa2lsbChibV9waWQsIFNJR0tJTEwpOwotCQkJZ290
byBvdXQ7Ci0JCX0KIAl9CiAKIAlyZW1vdmUocGFyYW0uZmlsZW5hbWUpOwogCi0JcmV0ID0g
Y2F0X3ZhbCgmcGFyYW0pOworCXJldCA9IGNhdF92YWwoJnBhcmFtLCBzcGFuKTsKIAlpZiAo
cmV0ID09IDApCi0JCXJldCA9IGNoZWNrX3Jlc3VsdHMoJnBhcmFtKTsKKwkJcmV0ID0gY2hl
Y2tfcmVzdWx0cygmcGFyYW0sIHNwYW4pOwogCiAJaWYgKGJtX3BpZCA9PSAwKSB7CiAJCS8q
IFRlbGwgcGFyZW50IHRoYXQgY2hpbGQgaXMgcmVhZHkgKi8KQEAgLTIwOCwxMCArMjAzLDgg
QEAgaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyICpjYWNo
ZV90eXBlKQogCQl9CiAJCWNsb3NlKHBpcGVmZFswXSk7CiAJCWtpbGwoYm1fcGlkLCBTSUdL
SUxMKTsKLQkJc2lnbmFsX2hhbmRsZXJfdW5yZWdpc3RlcigpOwogCX0KIAotb3V0OgogCWNh
dF90ZXN0X2NsZWFudXAoKTsKIAogCXJldHVybiByZXQ7CmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NtdF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9yZXNjdHJsL2NtdF90ZXN0LmMKaW5kZXggY2IyMTk3NjQ3YzZjLi41MGJkYmNl
OWZiYTkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY210
X3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NtdF90ZXN0
LmMKQEAgLTI3LDcgKzI3LDcgQEAgc3RhdGljIGludCBjbXRfc2V0dXAoc3RydWN0IHJlc2N0
cmxfdmFsX3BhcmFtICpwKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IGNoZWNrX3Jl
c3VsdHMoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSwgaW50IG5vX29mX2JpdHMp
CitzdGF0aWMgaW50IGNoZWNrX3Jlc3VsdHMoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpw
YXJhbSwgc2l6ZV90IHNwYW4sIGludCBub19vZl9iaXRzKQogewogCWNoYXIgKnRva2VuX2Fy
cmF5WzhdLCB0ZW1wWzUxMl07CiAJdW5zaWduZWQgbG9uZyBzdW1fbGxjX29jY3VfcmVzYyA9
IDA7CkBAIC01OCw3ICs1OCw3IEBAIHN0YXRpYyBpbnQgY2hlY2tfcmVzdWx0cyhzdHJ1Y3Qg
cmVzY3RybF92YWxfcGFyYW0gKnBhcmFtLCBpbnQgbm9fb2ZfYml0cykKIAl9CiAJZmNsb3Nl
KGZwKTsKIAotCXJldHVybiBzaG93X2NhY2hlX2luZm8oc3VtX2xsY19vY2N1X3Jlc2MsIG5v
X29mX2JpdHMsIHBhcmFtLT5zcGFuLAorCXJldHVybiBzaG93X2NhY2hlX2luZm8oc3VtX2xs
Y19vY2N1X3Jlc2MsIG5vX29mX2JpdHMsIHNwYW4sCiAJCQkgICAgICAgTUFYX0RJRkYsIE1B
WF9ESUZGX1BFUkNFTlQsIHJ1bnMgLSAxLAogCQkJICAgICAgIHRydWUsIHRydWUpOwogfQpA
QCAtNjgsMTYgKzY4LDE3IEBAIHZvaWQgY210X3Rlc3RfY2xlYW51cCh2b2lkKQogCXJlbW92
ZShSRVNVTFRfRklMRV9OQU1FKTsKIH0KIAotaW50IGNtdF9yZXNjdHJsX3ZhbChpbnQgY3B1
X25vLCBpbnQgbiwgY2hhciAqKmJlbmNobWFya19jbWQpCitpbnQgY210X3Jlc2N0cmxfdmFs
KGludCBjcHVfbm8sIGludCBuLCBjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQp
CiB7CisJY29uc3QgY2hhciAqIGNvbnN0ICpjbWQgPSBiZW5jaG1hcmtfY21kOworCWNvbnN0
IGNoYXIgKm5ld19jbWRbQkVOQ0hNQVJLX0FSR1NdOwogCXVuc2lnbmVkIGxvbmcgY2FjaGVf
c2l6ZSA9IDA7CiAJdW5zaWduZWQgbG9uZyBsb25nX21hc2s7CisJY2hhciAqc3Bhbl9zdHIg
PSBOVUxMOwogCWNoYXIgY2JtX21hc2tbMjU2XTsKIAlpbnQgY291bnRfb2ZfYml0czsKLQlp
bnQgcmV0OwotCi0JaWYgKCF2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChDTVRf
U1RSKSkKLQkJcmV0dXJuIC0xOworCXNpemVfdCBzcGFuOworCWludCByZXQsIGk7CiAKIAly
ZXQgPSBnZXRfY2JtX21hc2soIkwzIiwgY2JtX21hc2spOwogCWlmIChyZXQpCkBAIC0xMDUs
MjQgKzEwNiwzNiBAQCBpbnQgY210X3Jlc2N0cmxfdmFsKGludCBjcHVfbm8sIGludCBuLCBj
aGFyICoqYmVuY2htYXJrX2NtZCkKIAkJLmNwdV9ubwkJPSBjcHVfbm8sCiAJCS5maWxlbmFt
ZQk9IFJFU1VMVF9GSUxFX05BTUUsCiAJCS5tYXNrCQk9IH4obG9uZ19tYXNrIDw8IG4pICYg
bG9uZ19tYXNrLAotCQkuc3BhbgkJPSBjYWNoZV9zaXplICogbiAvIGNvdW50X29mX2JpdHMs
CiAJCS5udW1fb2ZfcnVucwk9IDAsCiAJCS5zZXR1cAkJPSBjbXRfc2V0dXAsCiAJfTsKIAot
CWlmIChzdHJjbXAoYmVuY2htYXJrX2NtZFswXSwgImZpbGxfYnVmIikgPT0gMCkKLQkJc3By
aW50ZihiZW5jaG1hcmtfY21kWzFdLCAiJXp1IiwgcGFyYW0uc3Bhbik7CisJc3BhbiA9IGNh
Y2hlX3NpemUgKiBuIC8gY291bnRfb2ZfYml0czsKKworCWlmIChzdHJjbXAoY21kWzBdLCAi
ZmlsbF9idWYiKSA9PSAwKSB7CisJCS8qIER1cGxpY2F0ZSB0aGUgY29tbWFuZCB0byBiZSBh
YmxlIHRvIHJlcGxhY2Ugc3BhbiBpbiBpdCAqLworCQlmb3IgKGkgPSAwOyBiZW5jaG1hcmtf
Y21kW2ldOyBpKyspCisJCQluZXdfY21kW2ldID0gYmVuY2htYXJrX2NtZFtpXTsKKwkJbmV3
X2NtZFtpXSA9IE5VTEw7CisKKwkJcmV0ID0gYXNwcmludGYoJnNwYW5fc3RyLCAiJXp1Iiwg
c3Bhbik7CisJCWlmIChyZXQgPCAwKQorCQkJcmV0dXJuIC0xOworCQluZXdfY21kWzFdID0g
c3Bhbl9zdHI7CisJCWNtZCA9IG5ld19jbWQ7CisJfQogCiAJcmVtb3ZlKFJFU1VMVF9GSUxF
X05BTUUpOwogCi0JcmV0ID0gcmVzY3RybF92YWwoYmVuY2htYXJrX2NtZCwgJnBhcmFtKTsK
KwlyZXQgPSByZXNjdHJsX3ZhbChjbWQsICZwYXJhbSk7CiAJaWYgKHJldCkKIAkJZ290byBv
dXQ7CiAKLQlyZXQgPSBjaGVja19yZXN1bHRzKCZwYXJhbSwgbik7CisJcmV0ID0gY2hlY2tf
cmVzdWx0cygmcGFyYW0sIHNwYW4sIG4pOwogCiBvdXQ6CiAJY210X3Rlc3RfY2xlYW51cCgp
OworCWZyZWUoc3Bhbl9zdHIpOwogCiAJcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJhX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJhX3Rlc3QuYwppbmRleCA0ZDJmMTQ1ODA0YjguLmQz
YmY0MzY4MzQxZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9tYmFfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJh
X3Rlc3QuYwpAQCAtMTIsNyArMTIsNyBAQAogCiAjZGVmaW5lIFJFU1VMVF9GSUxFX05BTUUJ
InJlc3VsdF9tYmEiCiAjZGVmaW5lIE5VTV9PRl9SVU5TCQk1Ci0jZGVmaW5lIE1BWF9ESUZG
X1BFUkNFTlQJNQorI2RlZmluZSBNQVhfRElGRl9QRVJDRU5UCTgKICNkZWZpbmUgQUxMT0NB
VElPTl9NQVgJCTEwMAogI2RlZmluZSBBTExPQ0FUSU9OX01JTgkJMTAKICNkZWZpbmUgQUxM
T0NBVElPTl9TVEVQCQkxMApAQCAtMTQxLDcgKzE0MSw3IEBAIHZvaWQgbWJhX3Rlc3RfY2xl
YW51cCh2b2lkKQogCXJlbW92ZShSRVNVTFRfRklMRV9OQU1FKTsKIH0KIAotaW50IG1iYV9z
Y2hlbWF0YV9jaGFuZ2UoaW50IGNwdV9ubywgY2hhciAqYndfcmVwb3J0LCBjaGFyICoqYmVu
Y2htYXJrX2NtZCkKK2ludCBtYmFfc2NoZW1hdGFfY2hhbmdlKGludCBjcHVfbm8sIGNvbnN0
IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCkKIHsKIAlzdHJ1Y3QgcmVzY3RybF92YWxf
cGFyYW0gcGFyYW0gPSB7CiAJCS5yZXNjdHJsX3ZhbAk9IE1CQV9TVFIsCkBAIC0xNDksNyAr
MTQ5LDcgQEAgaW50IG1iYV9zY2hlbWF0YV9jaGFuZ2UoaW50IGNwdV9ubywgY2hhciAqYndf
cmVwb3J0LCBjaGFyICoqYmVuY2htYXJrX2NtZCkKIAkJLm1vbmdycAkJPSAibTEiLAogCQku
Y3B1X25vCQk9IGNwdV9ubywKIAkJLmZpbGVuYW1lCT0gUkVTVUxUX0ZJTEVfTkFNRSwKLQkJ
LmJ3X3JlcG9ydAk9IGJ3X3JlcG9ydCwKKwkJLmJ3X3JlcG9ydAk9ICJyZWFkcyIsCiAJCS5z
ZXR1cAkJPSBtYmFfc2V0dXAKIAl9OwogCWludCByZXQ7CmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMKaW5kZXggYzdkZTZmNTk3N2Y2Li43NDE1MzNm
MmIwNzUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJt
X3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0
LmMKQEAgLTExLDcgKzExLDcgQEAKICNpbmNsdWRlICJyZXNjdHJsLmgiCiAKICNkZWZpbmUg
UkVTVUxUX0ZJTEVfTkFNRQkicmVzdWx0X21ibSIKLSNkZWZpbmUgTUFYX0RJRkZfUEVSQ0VO
VAk1CisjZGVmaW5lIE1BWF9ESUZGX1BFUkNFTlQJOAogI2RlZmluZSBOVU1fT0ZfUlVOUwkJ
NQogCiBzdGF0aWMgaW50CkBAIC05NSw3ICs5NSw3IEBAIHN0YXRpYyBpbnQgbWJtX3NldHVw
KHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcCkKIAkJcmV0dXJuIEVORF9PRl9URVNUUzsK
IAogCS8qIFNldCB1cCBzaGVtYXRhIHdpdGggMTAwJSBhbGxvY2F0aW9uIG9uIHRoZSBmaXJz
dCBydW4uICovCi0JaWYgKHAtPm51bV9vZl9ydW5zID09IDApCisJaWYgKHAtPm51bV9vZl9y
dW5zID09IDAgJiYgdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3QoIk1CIiwgTlVM
TCkpCiAJCXJldCA9IHdyaXRlX3NjaGVtYXRhKHAtPmN0cmxncnAsICIxMDAiLCBwLT5jcHVf
bm8sCiAJCQkJICAgICBwLT5yZXNjdHJsX3ZhbCk7CiAKQEAgLTEwOSwxNiArMTA5LDE1IEBA
IHZvaWQgbWJtX3Rlc3RfY2xlYW51cCh2b2lkKQogCXJlbW92ZShSRVNVTFRfRklMRV9OQU1F
KTsKIH0KIAotaW50IG1ibV9id19jaGFuZ2Uoc2l6ZV90IHNwYW4sIGludCBjcHVfbm8sIGNo
YXIgKmJ3X3JlcG9ydCwgY2hhciAqKmJlbmNobWFya19jbWQpCitpbnQgbWJtX2J3X2NoYW5n
ZShpbnQgY3B1X25vLCBjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQpCiB7CiAJ
c3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtIHBhcmFtID0gewogCQkucmVzY3RybF92YWwJPSBN
Qk1fU1RSLAogCQkuY3RybGdycAk9ICJjMSIsCiAJCS5tb25ncnAJCT0gIm0xIiwKLQkJLnNw
YW4JCT0gc3BhbiwKIAkJLmNwdV9ubwkJPSBjcHVfbm8sCiAJCS5maWxlbmFtZQk9IFJFU1VM
VF9GSUxFX05BTUUsCi0JCS5id19yZXBvcnQJPSAgYndfcmVwb3J0LAorCQkuYndfcmVwb3J0
CT0gInJlYWRzIiwKIAkJLnNldHVwCQk9IG1ibV9zZXR1cAogCX07CiAJaW50IHJldDsKQEAg
LTEyOSw3ICsxMjgsNyBAQCBpbnQgbWJtX2J3X2NoYW5nZShzaXplX3Qgc3BhbiwgaW50IGNw
dV9ubywgY2hhciAqYndfcmVwb3J0LCBjaGFyICoqYmVuY2htYXJrX2NtZAogCWlmIChyZXQp
CiAJCWdvdG8gb3V0OwogCi0JcmV0ID0gY2hlY2tfcmVzdWx0cyhzcGFuKTsKKwlyZXQgPSBj
aGVja19yZXN1bHRzKERFRkFVTFRfU1BBTik7CiAKIG91dDoKIAltYm1fdGVzdF9jbGVhbnVw
KCk7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0
cmwuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybC5oCmluZGV4
IDgzOGQxYTQzOGYzMy4uYTMzZjQxNGY2MDE5IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmwuaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL3Jlc2N0cmwuaApAQCAtMSw1ICsxLDQgQEAKIC8qIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCi0jZGVmaW5lIF9HTlVfU09VUkNFCiAjaWZuZGVm
IFJFU0NUUkxfSAogI2RlZmluZSBSRVNDVFJMX0gKICNpbmNsdWRlIDxzdGRpby5oPgpAQCAt
MjgsMTYgKzI3LDE2IEBACiAjZGVmaW5lIFJFU0NUUkxfUEFUSAkJIi9zeXMvZnMvcmVzY3Ry
bCIKICNkZWZpbmUgUEhZU19JRF9QQVRICQkiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1
IgogI2RlZmluZSBJTkZPX1BBVEgJCSIvc3lzL2ZzL3Jlc2N0cmwvaW5mbyIKLSNkZWZpbmUg
TDNfUEFUSAkJCSIvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MMyIKLSNkZWZpbmUgTUJfUEFUSAkJ
CSIvc3lzL2ZzL3Jlc2N0cmwvaW5mby9NQiIKLSNkZWZpbmUgTDNfTU9OX1BBVEgJCSIvc3lz
L2ZzL3Jlc2N0cmwvaW5mby9MM19NT04iCi0jZGVmaW5lIEwzX01PTl9GRUFUVVJFU19QQVRI
CSIvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbW9uX2ZlYXR1cmVzIgogCiAjZGVmaW5l
IEFSQ0hfSU5URUwgICAgIDEKICNkZWZpbmUgQVJDSF9BTUQgICAgICAgMgogCiAjZGVmaW5l
IEVORF9PRl9URVNUUwkxCiAKKyNkZWZpbmUgQkVOQ0hNQVJLX0FSR1MJCTY0CisKKyNkZWZp
bmUgREVGQVVMVF9TUEFOCQkoMjUwICogTUIpCisKICNkZWZpbmUgUEFSRU5UX0VYSVQoZXJy
X21zZykJCQlcCiAJZG8gewkJCQkJXAogCQlwZXJyb3IoZXJyX21zZyk7CQlcCkBAIC01Miw3
ICs1MSw2IEBACiAgKiBAY3RybGdycDoJCU5hbWUgb2YgdGhlIGNvbnRyb2wgbW9uaXRvciBn
cm91cCAoY29uX21vbiBncnApCiAgKiBAbW9uZ3JwOgkJTmFtZSBvZiB0aGUgbW9uaXRvciBn
cm91cCAobW9uIGdycCkKICAqIEBjcHVfbm86CQlDUFUgbnVtYmVyIHRvIHdoaWNoIHRoZSBi
ZW5jaG1hcmsgd291bGQgYmUgYmluZGVkCi0gKiBAc3BhbjoJCU1lbW9yeSBieXRlcyBhY2Nl
c3NlZCBpbiBlYWNoIGJlbmNobWFyayBpdGVyYXRpb24KICAqIEBmaWxlbmFtZToJCU5hbWUg
b2YgZmlsZSB0byB3aGljaCB0aGUgby9wIHNob3VsZCBiZSB3cml0dGVuCiAgKiBAYndfcmVw
b3J0OgkJQmFuZHdpZHRoIHJlcG9ydCB0eXBlIChyZWFkcyB2cyB3cml0ZXMpCiAgKiBAc2V0
dXA6CQlDYWxsIGJhY2sgZnVuY3Rpb24gdG8gc2V0dXAgdGVzdCBlbnZpcm9ubWVudApAQCAt
NjIsNyArNjAsNiBAQCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gewogCWNoYXIJCWN0cmxn
cnBbNjRdOwogCWNoYXIJCW1vbmdycFs2NF07CiAJaW50CQljcHVfbm87Ci0Jc2l6ZV90CQlz
cGFuOwogCWNoYXIJCWZpbGVuYW1lWzY0XTsKIAljaGFyCQkqYndfcmVwb3J0OwogCXVuc2ln
bmVkIGxvbmcJbWFzazsKQEAgLTg2LDEwICs4Myw5IEBAIGludCBnZXRfcmVzb3VyY2VfaWQo
aW50IGNwdV9ubywgaW50ICpyZXNvdXJjZV9pZCk7CiBpbnQgbW91bnRfcmVzY3RybGZzKHZv
aWQpOwogaW50IHVtb3VudF9yZXNjdHJsZnModm9pZCk7CiBpbnQgdmFsaWRhdGVfYndfcmVw
b3J0X3JlcXVlc3QoY2hhciAqYndfcmVwb3J0KTsKLWJvb2wgdmFsaWRhdGVfcmVzY3RybF9m
ZWF0dXJlX3JlcXVlc3QoY29uc3QgY2hhciAqcmVzY3RybF92YWwpOworYm9vbCB2YWxpZGF0
ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChjb25zdCBjaGFyICpyZXNvdXJjZSwgY29uc3Qg
Y2hhciAqZmVhdHVyZSk7CiBjaGFyICpmZ3JlcChGSUxFICppbmYsIGNvbnN0IGNoYXIgKnN0
cik7CiBpbnQgdGFza3NldF9iZW5jaG1hcmsocGlkX3QgYm1fcGlkLCBpbnQgY3B1X25vKTsK
LXZvaWQgcnVuX2JlbmNobWFyayhpbnQgc2lnbnVtLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQg
KnVjb250ZXh0KTsKIGludCB3cml0ZV9zY2hlbWF0YShjaGFyICpjdHJsZ3JwLCBjaGFyICpz
Y2hlbWF0YSwgaW50IGNwdV9ubywKIAkJICAgY2hhciAqcmVzY3RybF92YWwpOwogaW50IHdy
aXRlX2JtX3BpZF90b19yZXNjdHJsKHBpZF90IGJtX3BpZCwgY2hhciAqY3RybGdycCwgY2hh
ciAqbW9uZ3JwLApAQCAtOTcsMjEgKzkzLDIxIEBAIGludCB3cml0ZV9ibV9waWRfdG9fcmVz
Y3RybChwaWRfdCBibV9waWQsIGNoYXIgKmN0cmxncnAsIGNoYXIgKm1vbmdycCwKIGludCBw
ZXJmX2V2ZW50X29wZW4oc3RydWN0IHBlcmZfZXZlbnRfYXR0ciAqaHdfZXZlbnQsIHBpZF90
IHBpZCwgaW50IGNwdSwKIAkJICAgIGludCBncm91cF9mZCwgdW5zaWduZWQgbG9uZyBmbGFn
cyk7CiBpbnQgcnVuX2ZpbGxfYnVmKHNpemVfdCBzcGFuLCBpbnQgbWVtZmx1c2gsIGludCBv
cCwgYm9vbCBvbmNlKTsKLWludCByZXNjdHJsX3ZhbChjaGFyICoqYmVuY2htYXJrX2NtZCwg
c3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSk7Ci1pbnQgbWJtX2J3X2NoYW5nZShz
aXplX3Qgc3BhbiwgaW50IGNwdV9ubywgY2hhciAqYndfcmVwb3J0LCBjaGFyICoqYmVuY2ht
YXJrX2NtZCk7CitpbnQgcmVzY3RybF92YWwoY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1h
cmtfY21kLCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFtKTsKK2ludCBtYm1fYndf
Y2hhbmdlKGludCBjcHVfbm8sIGNvbnN0IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCk7
CiB2b2lkIHRlc3RzX2NsZWFudXAodm9pZCk7CiB2b2lkIG1ibV90ZXN0X2NsZWFudXAodm9p
ZCk7Ci1pbnQgbWJhX3NjaGVtYXRhX2NoYW5nZShpbnQgY3B1X25vLCBjaGFyICpid19yZXBv
cnQsIGNoYXIgKipiZW5jaG1hcmtfY21kKTsKK2ludCBtYmFfc2NoZW1hdGFfY2hhbmdlKGlu
dCBjcHVfbm8sIGNvbnN0IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCk7CiB2b2lkIG1i
YV90ZXN0X2NsZWFudXAodm9pZCk7CiBpbnQgZ2V0X2NibV9tYXNrKGNoYXIgKmNhY2hlX3R5
cGUsIGNoYXIgKmNibV9tYXNrKTsKIGludCBnZXRfY2FjaGVfc2l6ZShpbnQgY3B1X25vLCBj
aGFyICpjYWNoZV90eXBlLCB1bnNpZ25lZCBsb25nICpjYWNoZV9zaXplKTsKIHZvaWQgY3Ry
bGNfaGFuZGxlcihpbnQgc2lnbnVtLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKnB0cik7CiBp
bnQgc2lnbmFsX2hhbmRsZXJfcmVnaXN0ZXIodm9pZCk7CiB2b2lkIHNpZ25hbF9oYW5kbGVy
X3VucmVnaXN0ZXIodm9pZCk7Ci1pbnQgY2F0X3ZhbChzdHJ1Y3QgcmVzY3RybF92YWxfcGFy
YW0gKnBhcmFtKTsKK2ludCBjYXRfdmFsKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFy
YW0sIHNpemVfdCBzcGFuKTsKIHZvaWQgY2F0X3Rlc3RfY2xlYW51cCh2b2lkKTsKIGludCBj
YXRfcGVyZl9taXNzX3ZhbChpbnQgY3B1X25vLCBpbnQgbm9fb2ZfYml0cywgY2hhciAqY2Fj
aGVfdHlwZSk7Ci1pbnQgY210X3Jlc2N0cmxfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFy
ICoqYmVuY2htYXJrX2NtZCk7CitpbnQgY210X3Jlc2N0cmxfdmFsKGludCBjcHVfbm8sIGlu
dCBuLCBjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQpOwogdW5zaWduZWQgaW50
IGNvdW50X2JpdHModW5zaWduZWQgbG9uZyBuKTsKIHZvaWQgY210X3Rlc3RfY2xlYW51cCh2
b2lkKTsKIGludCBnZXRfY29yZV9zaWJsaW5nKGludCBjcHVfbm8pOwpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYwppbmRleCBkNTEx
ZGFlYjY4NTEuLjJiYmUzMDQ1YTAxOCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMKQEAgLTEwLDkgKzEwLDYgQEAKICAqLwog
I2luY2x1ZGUgInJlc2N0cmwuaCIKIAotI2RlZmluZSBCRU5DSE1BUktfQVJHUwkJNjQKLSNk
ZWZpbmUgQkVOQ0hNQVJLX0FSR19TSVpFCTY0Ci0KIHN0YXRpYyBpbnQgZGV0ZWN0X3ZlbmRv
cih2b2lkKQogewogCUZJTEUgKmluZiA9IGZvcGVuKCIvcHJvYy9jcHVpbmZvIiwgInIiKTsK
QEAgLTUyLDggKzQ5LDggQEAgaW50IGdldF92ZW5kb3Iodm9pZCkKIAogc3RhdGljIHZvaWQg
Y21kX2hlbHAodm9pZCkKIHsKLQlwcmludGYoInVzYWdlOiByZXNjdHJsX3Rlc3RzIFstaF0g
Wy1iIFwiYmVuY2htYXJrX2NtZCBbb3B0aW9uc11cIl0gWy10IHRlc3QgbGlzdF0gWy1uIG5v
X29mX2JpdHNdXG4iKTsKLQlwcmludGYoIlx0LWIgYmVuY2htYXJrX2NtZCBbb3B0aW9uc106
IHJ1biBzcGVjaWZpZWQgYmVuY2htYXJrIGZvciBNQk0sIE1CQSBhbmQgQ01UXG4iKTsKKwlw
cmludGYoInVzYWdlOiByZXNjdHJsX3Rlc3RzIFstaF0gWy10IHRlc3QgbGlzdF0gWy1uIG5v
X29mX2JpdHNdIFstYiBiZW5jaG1hcmtfY21kIFtvcHRpb25dLi4uXVxuIik7CisJcHJpbnRm
KCJcdC1iIGJlbmNobWFya19jbWQgW29wdGlvbl0uLi46IHJ1biBzcGVjaWZpZWQgYmVuY2ht
YXJrIGZvciBNQk0sIE1CQSBhbmQgQ01UXG4iKTsKIAlwcmludGYoIlx0ICAgZGVmYXVsdCBi
ZW5jaG1hcmsgaXMgYnVpbHRpbiBmaWxsX2J1ZlxuIik7CiAJcHJpbnRmKCJcdC10IHRlc3Qg
bGlzdDogcnVuIHRlc3RzIHNwZWNpZmllZCBpbiB0aGUgdGVzdCBsaXN0LCAiKTsKIAlwcmlu
dGYoImUuZy4gLXQgbWJtLG1iYSxjbXQsY2F0XG4iKTsKQEAgLTcwLDcyICs2Nyw5OCBAQCB2
b2lkIHRlc3RzX2NsZWFudXAodm9pZCkKIAljYXRfdGVzdF9jbGVhbnVwKCk7CiB9CiAKLXN0
YXRpYyB2b2lkIHJ1bl9tYm1fdGVzdChjaGFyICoqYmVuY2htYXJrX2NtZCwgc2l6ZV90IHNw
YW4sCi0JCQkgaW50IGNwdV9ubywgY2hhciAqYndfcmVwb3J0KQorc3RhdGljIGludCB0ZXN0
X3ByZXBhcmUodm9pZCkKIHsKIAlpbnQgcmVzOwogCi0Ja3NmdF9wcmludF9tc2coIlN0YXJ0
aW5nIE1CTSBCVyBjaGFuZ2UgLi4uXG4iKTsKKwlyZXMgPSBzaWduYWxfaGFuZGxlcl9yZWdp
c3RlcigpOworCWlmIChyZXMpIHsKKwkJa3NmdF9wcmludF9tc2coIkZhaWxlZCB0byByZWdp
c3RlciBzaWduYWwgaGFuZGxlclxuIik7CisJCXJldHVybiByZXM7CisJfQogCiAJcmVzID0g
bW91bnRfcmVzY3RybGZzKCk7CiAJaWYgKHJlcykgewotCQlrc2Z0X2V4aXRfZmFpbF9tc2co
IkZhaWxlZCB0byBtb3VudCByZXNjdHJsIEZTXG4iKTsKKwkJc2lnbmFsX2hhbmRsZXJfdW5y
ZWdpc3RlcigpOworCQlrc2Z0X3ByaW50X21zZygiRmFpbGVkIHRvIG1vdW50IHJlc2N0cmwg
RlNcbiIpOworCQlyZXR1cm4gcmVzOworCX0KKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZv
aWQgdGVzdF9jbGVhbnVwKHZvaWQpCit7CisJdW1vdW50X3Jlc2N0cmxmcygpOworCXNpZ25h
bF9oYW5kbGVyX3VucmVnaXN0ZXIoKTsKK30KKworc3RhdGljIHZvaWQgcnVuX21ibV90ZXN0
KGNvbnN0IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCwgaW50IGNwdV9ubykKK3sKKwlp
bnQgcmVzOworCisJa3NmdF9wcmludF9tc2coIlN0YXJ0aW5nIE1CTSBCVyBjaGFuZ2UgLi4u
XG4iKTsKKworCWlmICh0ZXN0X3ByZXBhcmUoKSkgeworCQlrc2Z0X2V4aXRfZmFpbF9tc2co
IkFibm9ybWFsIGZhaWx1cmUgd2hlbiBwcmVwYXJpbmcgZm9yIHRoZSB0ZXN0XG4iKTsKIAkJ
cmV0dXJuOwogCX0KIAotCWlmICghdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3Qo
TUJNX1NUUikgfHwgKGdldF92ZW5kb3IoKSAhPSBBUkNIX0lOVEVMKSkgeworCWlmICghdmFs
aWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3QoIkwzX01PTiIsICJtYm1fdG90YWxfYnl0
ZXMiKSB8fAorCSAgICAhdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3QoIkwzX01P
TiIsICJtYm1fbG9jYWxfYnl0ZXMiKSB8fAorCSAgICAoZ2V0X3ZlbmRvcigpICE9IEFSQ0hf
SU5URUwpKSB7CiAJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiSGFyZHdhcmUgZG9lcyBub3Qg
c3VwcG9ydCBNQk0gb3IgTUJNIGlzIGRpc2FibGVkXG4iKTsKLQkJZ290byB1bW91bnQ7CisJ
CWdvdG8gY2xlYW51cDsKIAl9CiAKLQlyZXMgPSBtYm1fYndfY2hhbmdlKHNwYW4sIGNwdV9u
bywgYndfcmVwb3J0LCBiZW5jaG1hcmtfY21kKTsKKwlyZXMgPSBtYm1fYndfY2hhbmdlKGNw
dV9ubywgYmVuY2htYXJrX2NtZCk7CiAJa3NmdF90ZXN0X3Jlc3VsdCghcmVzLCAiTUJNOiBi
dyBjaGFuZ2VcbiIpOwogCWlmICgoZ2V0X3ZlbmRvcigpID09IEFSQ0hfSU5URUwpICYmIHJl
cykKIAkJa3NmdF9wcmludF9tc2coIkludGVsIE1CTSBtYXkgYmUgaW5hY2N1cmF0ZSB3aGVu
IFN1Yi1OVU1BIENsdXN0ZXJpbmcgaXMgZW5hYmxlZC4gQ2hlY2sgQklPUyBjb25maWd1cmF0
aW9uLlxuIik7CiAKLXVtb3VudDoKLQl1bW91bnRfcmVzY3RybGZzKCk7CitjbGVhbnVwOgor
CXRlc3RfY2xlYW51cCgpOwogfQogCi1zdGF0aWMgdm9pZCBydW5fbWJhX3Rlc3QoY2hhciAq
KmJlbmNobWFya19jbWQsIGludCBjcHVfbm8sIGNoYXIgKmJ3X3JlcG9ydCkKK3N0YXRpYyB2
b2lkIHJ1bl9tYmFfdGVzdChjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQsIGlu
dCBjcHVfbm8pCiB7CiAJaW50IHJlczsKIAogCWtzZnRfcHJpbnRfbXNnKCJTdGFydGluZyBN
QkEgU2NoZW1hdGEgY2hhbmdlIC4uLlxuIik7CiAKLQlyZXMgPSBtb3VudF9yZXNjdHJsZnMo
KTsKLQlpZiAocmVzKSB7Ci0JCWtzZnRfZXhpdF9mYWlsX21zZygiRmFpbGVkIHRvIG1vdW50
IHJlc2N0cmwgRlNcbiIpOworCWlmICh0ZXN0X3ByZXBhcmUoKSkgeworCQlrc2Z0X2V4aXRf
ZmFpbF9tc2coIkFibm9ybWFsIGZhaWx1cmUgd2hlbiBwcmVwYXJpbmcgZm9yIHRoZSB0ZXN0
XG4iKTsKIAkJcmV0dXJuOwogCX0KIAotCWlmICghdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJl
X3JlcXVlc3QoTUJBX1NUUikgfHwgKGdldF92ZW5kb3IoKSAhPSBBUkNIX0lOVEVMKSkgewor
CWlmICghdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3QoIk1CIiwgTlVMTCkgfHwK
KwkgICAgIXZhbGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KCJMM19NT04iLCAibWJt
X2xvY2FsX2J5dGVzIikgfHwKKwkgICAgKGdldF92ZW5kb3IoKSAhPSBBUkNIX0lOVEVMKSkg
ewogCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoIkhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQg
TUJBIG9yIE1CQSBpcyBkaXNhYmxlZFxuIik7Ci0JCWdvdG8gdW1vdW50OworCQlnb3RvIGNs
ZWFudXA7CiAJfQogCi0JcmVzID0gbWJhX3NjaGVtYXRhX2NoYW5nZShjcHVfbm8sIGJ3X3Jl
cG9ydCwgYmVuY2htYXJrX2NtZCk7CisJcmVzID0gbWJhX3NjaGVtYXRhX2NoYW5nZShjcHVf
bm8sIGJlbmNobWFya19jbWQpOwogCWtzZnRfdGVzdF9yZXN1bHQoIXJlcywgIk1CQTogc2No
ZW1hdGEgY2hhbmdlXG4iKTsKIAotdW1vdW50OgotCXVtb3VudF9yZXNjdHJsZnMoKTsKK2Ns
ZWFudXA6CisJdGVzdF9jbGVhbnVwKCk7CiB9CiAKLXN0YXRpYyB2b2lkIHJ1bl9jbXRfdGVz
dChjaGFyICoqYmVuY2htYXJrX2NtZCwgaW50IGNwdV9ubykKK3N0YXRpYyB2b2lkIHJ1bl9j
bXRfdGVzdChjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQsIGludCBjcHVfbm8p
CiB7CiAJaW50IHJlczsKIAogCWtzZnRfcHJpbnRfbXNnKCJTdGFydGluZyBDTVQgdGVzdCAu
Li5cbiIpOwogCi0JcmVzID0gbW91bnRfcmVzY3RybGZzKCk7Ci0JaWYgKHJlcykgewotCQlr
c2Z0X2V4aXRfZmFpbF9tc2coIkZhaWxlZCB0byBtb3VudCByZXNjdHJsIEZTXG4iKTsKKwlp
ZiAodGVzdF9wcmVwYXJlKCkpIHsKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJBYm5vcm1hbCBm
YWlsdXJlIHdoZW4gcHJlcGFyaW5nIGZvciB0aGUgdGVzdFxuIik7CiAJCXJldHVybjsKIAl9
CiAKLQlpZiAoIXZhbGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KENNVF9TVFIpKSB7
CisJaWYgKCF2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdCgiTDNfTU9OIiwgImxs
Y19vY2N1cGFuY3kiKSB8fAorCSAgICAhdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVl
c3QoIkwzIiwgTlVMTCkpIHsKIAkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJIYXJkd2FyZSBk
b2VzIG5vdCBzdXBwb3J0IENNVCBvciBDTVQgaXMgZGlzYWJsZWRcbiIpOwotCQlnb3RvIHVt
b3VudDsKKwkJZ290byBjbGVhbnVwOwogCX0KIAogCXJlcyA9IGNtdF9yZXNjdHJsX3ZhbChj
cHVfbm8sIDUsIGJlbmNobWFya19jbWQpOwpAQCAtMTQzLDggKzE2Niw4IEBAIHN0YXRpYyB2
b2lkIHJ1bl9jbXRfdGVzdChjaGFyICoqYmVuY2htYXJrX2NtZCwgaW50IGNwdV9ubykKIAlp
ZiAoKGdldF92ZW5kb3IoKSA9PSBBUkNIX0lOVEVMKSAmJiByZXMpCiAJCWtzZnRfcHJpbnRf
bXNnKCJJbnRlbCBDTVQgbWF5IGJlIGluYWNjdXJhdGUgd2hlbiBTdWItTlVNQSBDbHVzdGVy
aW5nIGlzIGVuYWJsZWQuIENoZWNrIEJJT1MgY29uZmlndXJhdGlvbi5cbiIpOwogCi11bW91
bnQ6Ci0JdW1vdW50X3Jlc2N0cmxmcygpOworY2xlYW51cDoKKwl0ZXN0X2NsZWFudXAoKTsK
IH0KIAogc3RhdGljIHZvaWQgcnVuX2NhdF90ZXN0KGludCBjcHVfbm8sIGludCBub19vZl9i
aXRzKQpAQCAtMTUzLDQ4ICsxNzYsNTMgQEAgc3RhdGljIHZvaWQgcnVuX2NhdF90ZXN0KGlu
dCBjcHVfbm8sIGludCBub19vZl9iaXRzKQogCiAJa3NmdF9wcmludF9tc2coIlN0YXJ0aW5n
IENBVCB0ZXN0IC4uLlxuIik7CiAKLQlyZXMgPSBtb3VudF9yZXNjdHJsZnMoKTsKLQlpZiAo
cmVzKSB7Ci0JCWtzZnRfZXhpdF9mYWlsX21zZygiRmFpbGVkIHRvIG1vdW50IHJlc2N0cmwg
RlNcbiIpOworCWlmICh0ZXN0X3ByZXBhcmUoKSkgeworCQlrc2Z0X2V4aXRfZmFpbF9tc2co
IkFibm9ybWFsIGZhaWx1cmUgd2hlbiBwcmVwYXJpbmcgZm9yIHRoZSB0ZXN0XG4iKTsKIAkJ
cmV0dXJuOwogCX0KIAotCWlmICghdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3Qo
Q0FUX1NUUikpIHsKKwlpZiAoIXZhbGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KCJM
MyIsIE5VTEwpKSB7CiAJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiSGFyZHdhcmUgZG9lcyBu
b3Qgc3VwcG9ydCBDQVQgb3IgQ0FUIGlzIGRpc2FibGVkXG4iKTsKLQkJZ290byB1bW91bnQ7
CisJCWdvdG8gY2xlYW51cDsKIAl9CiAKIAlyZXMgPSBjYXRfcGVyZl9taXNzX3ZhbChjcHVf
bm8sIG5vX29mX2JpdHMsICJMMyIpOwogCWtzZnRfdGVzdF9yZXN1bHQoIXJlcywgIkNBVDog
dGVzdFxuIik7CiAKLXVtb3VudDoKLQl1bW91bnRfcmVzY3RybGZzKCk7CitjbGVhbnVwOgor
CXRlc3RfY2xlYW51cCgpOwogfQogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
CiB7Ci0JYm9vbCBoYXNfYmVuID0gZmFsc2UsIG1ibV90ZXN0ID0gdHJ1ZSwgbWJhX3Rlc3Qg
PSB0cnVlLCBjbXRfdGVzdCA9IHRydWU7Ci0JY2hhciAqYmVuY2htYXJrX2NtZFtCRU5DSE1B
UktfQVJHU10sIGJ3X3JlcG9ydFs2NF0sIGJtX3R5cGVbNjRdOwotCWNoYXIgYmVuY2htYXJr
X2NtZF9hcmVhW0JFTkNITUFSS19BUkdTXVtCRU5DSE1BUktfQVJHX1NJWkVdOwotCWludCBj
LCBjcHVfbm8gPSAxLCBhcmdjX25ldyA9IGFyZ2MsIGksIG5vX29mX2JpdHMgPSAwOwotCWlu
dCBiZW5faW5kLCBiZW5fY291bnQsIHRlc3RzID0gMDsKLQlzaXplX3Qgc3BhbiA9IDI1MCAq
IE1COworCWJvb2wgbWJtX3Rlc3QgPSB0cnVlLCBtYmFfdGVzdCA9IHRydWUsIGNtdF90ZXN0
ID0gdHJ1ZTsKKwljb25zdCBjaGFyICpiZW5jaG1hcmtfY21kW0JFTkNITUFSS19BUkdTXSA9
IHt9OworCWludCBjLCBjcHVfbm8gPSAxLCBpLCBub19vZl9iaXRzID0gMDsKKwljaGFyICpz
cGFuX3N0ciA9IE5VTEw7CiAJYm9vbCBjYXRfdGVzdCA9IHRydWU7CisJaW50IHRlc3RzID0g
MDsKKwlpbnQgcmV0OwogCi0JZm9yIChpID0gMDsgaSA8IGFyZ2M7IGkrKykgewotCQlpZiAo
c3RyY21wKGFyZ3ZbaV0sICItYiIpID09IDApIHsKLQkJCWJlbl9pbmQgPSBpICsgMTsKLQkJ
CWJlbl9jb3VudCA9IGFyZ2MgLSBiZW5faW5kOwotCQkJYXJnY19uZXcgPSBiZW5faW5kIC0g
MTsKLQkJCWhhc19iZW4gPSB0cnVlOwotCQkJYnJlYWs7Ci0JCX0KLQl9Ci0KLQl3aGlsZSAo
KGMgPSBnZXRvcHQoYXJnY19uZXcsIGFyZ3YsICJodDpiOm46cDoiKSkgIT0gLTEpIHsKKwl3
aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgImh0OmI6bjpwOiIpKSAhPSAtMSkgewog
CQljaGFyICp0b2tlbjsKIAogCQlzd2l0Y2ggKGMpIHsKKwkJY2FzZSAnYic6CisJCQkvKgor
CQkJICogRmlyc3QgbW92ZSBvcHRpbmQgYmFjayB0byB0aGUgKGZpcnN0KSBvcHRhcmcgYW5k
CisJCQkgKiB0aGVuIGJ1aWxkIHRoZSBiZW5jaG1hcmsgY29tbWFuZCB1c2luZyB0aGUKKwkJ
CSAqIHJlbWFpbmluZyBhcmd1bWVudHMuCisJCQkgKi8KKwkJCW9wdGluZC0tOworCQkJaWYg
KGFyZ2MgLSBvcHRpbmQgPj0gQkVOQ0hNQVJLX0FSR1MpCisJCQkJa3NmdF9leGl0X2ZhaWxf
bXNnKCJUb28gbG9uZyBiZW5jaG1hcmsgY29tbWFuZCIpOworCisJCQkvKiBFeHRyYWN0IGJl
bmNobWFyayBjb21tYW5kIGZyb20gY29tbWFuZCBsaW5lLiAqLworCQkJZm9yIChpID0gMDsg
aSA8IGFyZ2MgLSBvcHRpbmQ7IGkrKykKKwkJCQliZW5jaG1hcmtfY21kW2ldID0gYXJndltp
ICsgb3B0aW5kXTsKKwkJCWJlbmNobWFya19jbWRbaV0gPSBOVUxMOworCisJCQlnb3RvIGxh
c3RfYXJnOwogCQljYXNlICd0JzoKIAkJCXRva2VuID0gc3RydG9rKG9wdGFyZywgIiwiKTsK
IApAQCAtMjQzLDYgKzI3MSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
IAkJCXJldHVybiAtMTsKIAkJfQogCX0KK2xhc3RfYXJnOgogCiAJa3NmdF9wcmludF9oZWFk
ZXIoKTsKIApAQCAtMjU0LDI5ICsyODMsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCiAJaWYgKGdldGV1aWQoKSAhPSAwKQogCQlyZXR1cm4ga3NmdF9leGl0X3NraXAo
Ik5vdCBydW5uaW5nIGFzIHJvb3QuIFNraXBwaW5nLi4uXG4iKTsKIAotCWlmIChoYXNfYmVu
KSB7Ci0JCS8qIEV4dHJhY3QgYmVuY2htYXJrIGNvbW1hbmQgZnJvbSBjb21tYW5kIGxpbmUu
ICovCi0JCWZvciAoaSA9IGJlbl9pbmQ7IGkgPCBhcmdjOyBpKyspIHsKLQkJCWJlbmNobWFy
a19jbWRbaSAtIGJlbl9pbmRdID0gYmVuY2htYXJrX2NtZF9hcmVhW2ldOwotCQkJc3ByaW50
ZihiZW5jaG1hcmtfY21kW2kgLSBiZW5faW5kXSwgIiVzIiwgYXJndltpXSk7Ci0JCX0KLQkJ
YmVuY2htYXJrX2NtZFtiZW5fY291bnRdID0gTlVMTDsKLQl9IGVsc2UgewotCQkvKiBJZiBu
byBiZW5jaG1hcmsgaXMgZ2l2ZW4gYnkgIi1iIiBhcmd1bWVudCwgdXNlIGZpbGxfYnVmLiAq
LwotCQlmb3IgKGkgPSAwOyBpIDwgNTsgaSsrKQotCQkJYmVuY2htYXJrX2NtZFtpXSA9IGJl
bmNobWFya19jbWRfYXJlYVtpXTsKLQotCQlzdHJjcHkoYmVuY2htYXJrX2NtZFswXSwgImZp
bGxfYnVmIik7Ci0JCXNwcmludGYoYmVuY2htYXJrX2NtZFsxXSwgIiV6dSIsIHNwYW4pOwot
CQlzdHJjcHkoYmVuY2htYXJrX2NtZFsyXSwgIjEiKTsKLQkJc3RyY3B5KGJlbmNobWFya19j
bWRbM10sICIwIik7Ci0JCXN0cmNweShiZW5jaG1hcmtfY21kWzRdLCAiZmFsc2UiKTsKLQkJ
YmVuY2htYXJrX2NtZFs1XSA9IE5VTEw7Ci0JfQotCi0Jc3ByaW50Zihid19yZXBvcnQsICJy
ZWFkcyIpOwotCXNwcmludGYoYm1fdHlwZSwgImZpbGxfYnVmIik7Ci0KIAlpZiAoIWNoZWNr
X3Jlc2N0cmxmc19zdXBwb3J0KCkpCiAJCXJldHVybiBrc2Z0X2V4aXRfc2tpcCgicmVzY3Ry
bCBGUyBkb2VzIG5vdCBleGlzdC4gRW5hYmxlIFg4Nl9DUFVfUkVTQ1RSTCBjb25maWcgb3B0
aW9uLlxuIik7CiAKQEAgLTI4NSwxMyArMjkxLDI2IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICoqYXJndikKIAogCWZpbHRlcl9kbWVzZygpOwogCisJaWYgKCFiZW5jaG1hcmtfY21k
WzBdKSB7CisJCS8qIElmIG5vIGJlbmNobWFyayBpcyBnaXZlbiBieSAiLWIiIGFyZ3VtZW50
LCB1c2UgZmlsbF9idWYuICovCisJCWJlbmNobWFya19jbWRbMF0gPSAiZmlsbF9idWYiOwor
CQlyZXQgPSBhc3ByaW50Zigmc3Bhbl9zdHIsICIldSIsIERFRkFVTFRfU1BBTik7CisJCWlm
IChyZXQgPCAwKQorCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJPdXQgb2YgbWVtb3J5IVxuIik7
CisJCWJlbmNobWFya19jbWRbMV0gPSBzcGFuX3N0cjsKKwkJYmVuY2htYXJrX2NtZFsyXSA9
ICIxIjsKKwkJYmVuY2htYXJrX2NtZFszXSA9ICIwIjsKKwkJYmVuY2htYXJrX2NtZFs0XSA9
ICJmYWxzZSI7CisJCWJlbmNobWFya19jbWRbNV0gPSBOVUxMOworCX0KKwogCWtzZnRfc2V0
X3BsYW4odGVzdHMgPyA6IDQpOwogCiAJaWYgKG1ibV90ZXN0KQotCQlydW5fbWJtX3Rlc3Qo
YmVuY2htYXJrX2NtZCwgc3BhbiwgY3B1X25vLCBid19yZXBvcnQpOworCQlydW5fbWJtX3Rl
c3QoYmVuY2htYXJrX2NtZCwgY3B1X25vKTsKIAogCWlmIChtYmFfdGVzdCkKLQkJcnVuX21i
YV90ZXN0KGJlbmNobWFya19jbWQsIGNwdV9ubywgYndfcmVwb3J0KTsKKwkJcnVuX21iYV90
ZXN0KGJlbmNobWFya19jbWQsIGNwdV9ubyk7CiAKIAlpZiAoY210X3Rlc3QpCiAJCXJ1bl9j
bXRfdGVzdChiZW5jaG1hcmtfY21kLCBjcHVfbm8pOwpAQCAtMjk5LDUgKzMxOCw2IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlpZiAoY2F0X3Rlc3QpCiAJCXJ1bl9j
YXRfdGVzdChjcHVfbm8sIG5vX29mX2JpdHMpOwogCisJZnJlZShzcGFuX3N0cik7CiAJa3Nm
dF9maW5pc2hlZCgpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9yZXNjdHJsX3ZhbC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9yZXNjdHJsX3ZhbC5jCmluZGV4IGYwZjZjNWY2ZTk4Yi4uODg3ODk2Nzg5MTdiIDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdmFsLmMK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3ZhbC5jCkBA
IC00NjgsNyArNDY4LDkgQEAgcGlkX3QgYm1fcGlkLCBwcGlkOwogCiB2b2lkIGN0cmxjX2hh
bmRsZXIoaW50IHNpZ251bSwgc2lnaW5mb190ICppbmZvLCB2b2lkICpwdHIpCiB7Ci0Ja2ls
bChibV9waWQsIFNJR0tJTEwpOworCS8qIE9ubHkga2lsbCBjaGlsZCBhZnRlciBibV9waWQg
aXMgc2V0IGFmdGVyIGZvcmsoKSAqLworCWlmIChibV9waWQpCisJCWtpbGwoYm1fcGlkLCBT
SUdLSUxMKTsKIAl1bW91bnRfcmVzY3RybGZzKCk7CiAJdGVzdHNfY2xlYW51cCgpOwogCWtz
ZnRfcHJpbnRfbXNnKCJFbmRpbmdcblxuIik7CkBAIC00ODIsOSArNDg0LDExIEBAIHZvaWQg
Y3RybGNfaGFuZGxlcihpbnQgc2lnbnVtLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKnB0cikK
ICAqLwogaW50IHNpZ25hbF9oYW5kbGVyX3JlZ2lzdGVyKHZvaWQpCiB7Ci0Jc3RydWN0IHNp
Z2FjdGlvbiBzaWdhY3Q7CisJc3RydWN0IHNpZ2FjdGlvbiBzaWdhY3QgPSB7fTsKIAlpbnQg
cmV0ID0gMDsKIAorCWJtX3BpZCA9IDA7CisKIAlzaWdhY3Quc2Ffc2lnYWN0aW9uID0gY3Ry
bGNfaGFuZGxlcjsKIAlzaWdlbXB0eXNldCgmc2lnYWN0LnNhX21hc2spOwogCXNpZ2FjdC5z
YV9mbGFncyA9IFNBX1NJR0lORk87CkBAIC01MDQsNyArNTA4LDcgQEAgaW50IHNpZ25hbF9o
YW5kbGVyX3JlZ2lzdGVyKHZvaWQpCiAgKi8KIHZvaWQgc2lnbmFsX2hhbmRsZXJfdW5yZWdp
c3Rlcih2b2lkKQogewotCXN0cnVjdCBzaWdhY3Rpb24gc2lnYWN0OworCXN0cnVjdCBzaWdh
Y3Rpb24gc2lnYWN0ID0ge307CiAKIAlzaWdhY3Quc2FfaGFuZGxlciA9IFNJR19ERkw7CiAJ
c2lnZW1wdHlzZXQoJnNpZ2FjdC5zYV9tYXNrKTsKQEAgLTYyMSw2ICs2MjUsNTYgQEAgbWVh
c3VyZV92YWxzKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0sIHVuc2lnbmVkIGxv
bmcgKmJ3X3Jlc2Nfc3RhcnQpCiAJcmV0dXJuIDA7CiB9CiAKKy8qCisgKiBydW5fYmVuY2ht
YXJrIC0gUnVuIGEgc3BlY2lmaWVkIGJlbmNobWFyayBvciBmaWxsX2J1ZiAoZGVmYXVsdCBi
ZW5jaG1hcmspCisgKgkJICAgaW4gc3BlY2lmaWVkIHNpZ25hbC4gRGlyZWN0IGJlbmNobWFy
ayBzdGRpbyB0byAvZGV2L251bGwuCisgKiBAc2lnbnVtOglzaWduYWwgbnVtYmVyCisgKiBA
aW5mbzoJc2lnbmFsIGluZm8KKyAqIEB1Y29udGV4dDoJdXNlciBjb250ZXh0IGluIHNpZ25h
bCBoYW5kbGluZworICovCitzdGF0aWMgdm9pZCBydW5fYmVuY2htYXJrKGludCBzaWdudW0s
IHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqdWNvbnRleHQpCit7CisJaW50IG9wZXJhdGlvbiwg
cmV0LCBtZW1mbHVzaDsKKwljaGFyICoqYmVuY2htYXJrX2NtZDsKKwlzaXplX3Qgc3BhbjsK
Kwlib29sIG9uY2U7CisJRklMRSAqZnA7CisKKwliZW5jaG1hcmtfY21kID0gaW5mby0+c2lf
cHRyOworCisJLyoKKwkgKiBEaXJlY3Qgc3RkaW8gb2YgY2hpbGQgdG8gL2Rldi9udWxsLCBz
byB0aGF0IG9ubHkgcGFyZW50IHdyaXRlcyB0bworCSAqIHN0ZGlvIChjb25zb2xlKQorCSAq
LworCWZwID0gZnJlb3BlbigiL2Rldi9udWxsIiwgInciLCBzdGRvdXQpOworCWlmICghZnAp
CisJCVBBUkVOVF9FWElUKCJVbmFibGUgdG8gZGlyZWN0IGJlbmNobWFyayBzdGF0dXMgdG8g
L2Rldi9udWxsIik7CisKKwlpZiAoc3RyY21wKGJlbmNobWFya19jbWRbMF0sICJmaWxsX2J1
ZiIpID09IDApIHsKKwkJLyogRXhlY3V0ZSBkZWZhdWx0IGZpbGxfYnVmIGJlbmNobWFyayAq
LworCQlzcGFuID0gc3RydG91bChiZW5jaG1hcmtfY21kWzFdLCBOVUxMLCAxMCk7CisJCW1l
bWZsdXNoID0gIGF0b2koYmVuY2htYXJrX2NtZFsyXSk7CisJCW9wZXJhdGlvbiA9IGF0b2ko
YmVuY2htYXJrX2NtZFszXSk7CisJCWlmICghc3RyY21wKGJlbmNobWFya19jbWRbNF0sICJ0
cnVlIikpCisJCQlvbmNlID0gdHJ1ZTsKKwkJZWxzZSBpZiAoIXN0cmNtcChiZW5jaG1hcmtf
Y21kWzRdLCAiZmFsc2UiKSkKKwkJCW9uY2UgPSBmYWxzZTsKKwkJZWxzZQorCQkJUEFSRU5U
X0VYSVQoIkludmFsaWQgb25jZSBwYXJhbWV0ZXIiKTsKKworCQlpZiAocnVuX2ZpbGxfYnVm
KHNwYW4sIG1lbWZsdXNoLCBvcGVyYXRpb24sIG9uY2UpKQorCQkJZnByaW50ZihzdGRlcnIs
ICJFcnJvciBpbiBydW5uaW5nIGZpbGwgYnVmZmVyXG4iKTsKKwl9IGVsc2UgeworCQkvKiBF
eGVjdXRlIHNwZWNpZmllZCBiZW5jaG1hcmsgKi8KKwkJcmV0ID0gZXhlY3ZwKGJlbmNobWFy
a19jbWRbMF0sIGJlbmNobWFya19jbWQpOworCQlpZiAocmV0KQorCQkJcGVycm9yKCJ3cm9u
Z1xuIik7CisJfQorCisJZmNsb3NlKHN0ZG91dCk7CisJUEFSRU5UX0VYSVQoIlVuYWJsZSB0
byBydW4gc3BlY2lmaWVkIGJlbmNobWFyayIpOworfQorCiAvKgogICogcmVzY3RybF92YWw6
CWV4ZWN1dGUgYmVuY2htYXJrIGFuZCBtZWFzdXJlIG1lbW9yeSBiYW5kd2lkdGggb24KICAq
CQkJdGhlIGJlbmNobWFyawpAQCAtNjI5LDcgKzY4Myw3IEBAIG1lYXN1cmVfdmFscyhzdHJ1
Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFtLCB1bnNpZ25lZCBsb25nICpid19yZXNjX3N0
YXJ0KQogICoKICAqIFJldHVybjoJCTAgb24gc3VjY2Vzcy4gbm9uLXplcm8gb24gZmFpbHVy
ZS4KICAqLwotaW50IHJlc2N0cmxfdmFsKGNoYXIgKipiZW5jaG1hcmtfY21kLCBzdHJ1Y3Qg
cmVzY3RybF92YWxfcGFyYW0gKnBhcmFtKQoraW50IHJlc2N0cmxfdmFsKGNvbnN0IGNoYXIg
KiBjb25zdCAqYmVuY2htYXJrX2NtZCwgc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJh
bSkKIHsKIAljaGFyICpyZXNjdHJsX3ZhbCA9IHBhcmFtLT5yZXNjdHJsX3ZhbDsKIAl1bnNp
Z25lZCBsb25nIGJ3X3Jlc2Nfc3RhcnQgPSAwOwpAQCAtNzA2LDI4ICs3NjAsMzAgQEAgaW50
IHJlc2N0cmxfdmFsKGNoYXIgKipiZW5jaG1hcmtfY21kLCBzdHJ1Y3QgcmVzY3RybF92YWxf
cGFyYW0gKnBhcmFtKQogCiAJa3NmdF9wcmludF9tc2coIkJlbmNobWFyayBQSUQ6ICVkXG4i
LCBibV9waWQpOwogCi0JcmV0ID0gc2lnbmFsX2hhbmRsZXJfcmVnaXN0ZXIoKTsKLQlpZiAo
cmV0KQotCQlnb3RvIG91dDsKLQotCXZhbHVlLnNpdmFsX3B0ciA9IGJlbmNobWFya19jbWQ7
CisJLyoKKwkgKiBUaGUgY2FzdCByZW1vdmVzIGNvbnN0bmVzcyBidXQgbm90aGluZyBtdXRh
dGVzIGJlbmNobWFya19jbWQgd2l0aGluCisJICogdGhlIGNvbnRleHQgb2YgdGhpcyBwcm9j
ZXNzLiBBdCB0aGUgcmVjZWl2aW5nIHByb2Nlc3MsIGl0IGJlY29tZXMKKwkgKiBhcmd2LCB3
aGljaCBpcyBtdXRhYmxlLCBvbiBleGVjKCkgYnV0IHRoYXQncyBhZnRlciBmb3JrKCkgc28g
aXQKKwkgKiBkb2Vzbid0IG1hdHRlciBmb3IgdGhlIHByb2Nlc3MgcnVubmluZyB0aGUgdGVz
dHMuCisJICovCisJdmFsdWUuc2l2YWxfcHRyID0gKHZvaWQgKiliZW5jaG1hcmtfY21kOwog
CiAJLyogVGFza3NldCBiZW5jaG1hcmsgdG8gc3BlY2lmaWVkIGNwdSAqLwogCXJldCA9IHRh
c2tzZXRfYmVuY2htYXJrKGJtX3BpZCwgcGFyYW0tPmNwdV9ubyk7CiAJaWYgKHJldCkKLQkJ
Z290byB1bnJlZ2lzdGVyOworCQlnb3RvIG91dDsKIAogCS8qIFdyaXRlIGJlbmNobWFyayB0
byBzcGVjaWZpZWQgY29udHJvbCZtb25pdG9yaW5nIGdycCBpbiByZXNjdHJsIEZTICovCiAJ
cmV0ID0gd3JpdGVfYm1fcGlkX3RvX3Jlc2N0cmwoYm1fcGlkLCBwYXJhbS0+Y3RybGdycCwg
cGFyYW0tPm1vbmdycCwKIAkJCQkgICAgICByZXNjdHJsX3ZhbCk7CiAJaWYgKHJldCkKLQkJ
Z290byB1bnJlZ2lzdGVyOworCQlnb3RvIG91dDsKIAogCWlmICghc3RybmNtcChyZXNjdHJs
X3ZhbCwgTUJNX1NUUiwgc2l6ZW9mKE1CTV9TVFIpKSB8fAogCSAgICAhc3RybmNtcChyZXNj
dHJsX3ZhbCwgTUJBX1NUUiwgc2l6ZW9mKE1CQV9TVFIpKSkgewogCQlyZXQgPSBpbml0aWFs
aXplX21lbV9id19pbWMoKTsKIAkJaWYgKHJldCkKLQkJCWdvdG8gdW5yZWdpc3RlcjsKKwkJ
CWdvdG8gb3V0OwogCiAJCWluaXRpYWxpemVfbWVtX2J3X3Jlc2N0cmwocGFyYW0tPmN0cmxn
cnAsIHBhcmFtLT5tb25ncnAsCiAJCQkJCSAgcGFyYW0tPmNwdV9ubywgcmVzY3RybF92YWwp
OwpAQCAtNzQyLDcgKzc5OCw3IEBAIGludCByZXNjdHJsX3ZhbChjaGFyICoqYmVuY2htYXJr
X2NtZCwgc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSkKIAkJICAgIHNpemVvZihw
aXBlX21lc3NhZ2UpKSB7CiAJCQlwZXJyb3IoIiMgZmFpbGVkIHJlYWRpbmcgbWVzc2FnZSBm
cm9tIGNoaWxkIHByb2Nlc3MiKTsKIAkJCWNsb3NlKHBpcGVmZFswXSk7Ci0JCQlnb3RvIHVu
cmVnaXN0ZXI7CisJCQlnb3RvIG91dDsKIAkJfQogCX0KIAljbG9zZShwaXBlZmRbMF0pOwpA
QCAtNzUxLDcgKzgwNyw3IEBAIGludCByZXNjdHJsX3ZhbChjaGFyICoqYmVuY2htYXJrX2Nt
ZCwgc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSkKIAlpZiAoc2lncXVldWUoYm1f
cGlkLCBTSUdVU1IxLCB2YWx1ZSkgPT0gLTEpIHsKIAkJcGVycm9yKCIjIHNpZ3F1ZXVlIFNJ
R1VTUjEgdG8gY2hpbGQiKTsKIAkJcmV0ID0gZXJybm87Ci0JCWdvdG8gdW5yZWdpc3RlcjsK
KwkJZ290byBvdXQ7CiAJfQogCiAJLyogR2l2ZSBiZW5jaG1hcmsgZW5vdWdoIHRpbWUgdG8g
ZnVsbHkgcnVuICovCkBAIC03ODAsOCArODM2LDYgQEAgaW50IHJlc2N0cmxfdmFsKGNoYXIg
KipiZW5jaG1hcmtfY21kLCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFtKQogCQl9
CiAJfQogCi11bnJlZ2lzdGVyOgotCXNpZ25hbF9oYW5kbGVyX3VucmVnaXN0ZXIoKTsKIG91
dDoKIAlraWxsKGJtX3BpZCwgU0lHS0lMTCk7CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybGZzLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL3Jlc2N0cmxmcy5jCmluZGV4IGJkMzZlZTIwNjYwMi4uNWViZDQzNjgz
ODc2IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0
cmxmcy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybGZz
LmMKQEAgLTgsNiArOCw5IEBACiAgKiAgICBTYWkgUHJhbmVldGggUHJha2h5YSA8c2FpLnBy
YW5lZXRoLnByYWtoeWFAaW50ZWwuY29tPiwKICAqICAgIEZlbmdodWEgWXUgPGZlbmdodWEu
eXVAaW50ZWwuY29tPgogICovCisjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxsaW1p
dHMuaD4KKwogI2luY2x1ZGUgInJlc2N0cmwuaCIKIAogc3RhdGljIGludCBmaW5kX3Jlc2N0
cmxfbW91bnQoY2hhciAqYnVmZmVyKQpAQCAtMjkxLDU4ICsyOTQsNiBAQCBpbnQgdGFza3Nl
dF9iZW5jaG1hcmsocGlkX3QgYm1fcGlkLCBpbnQgY3B1X25vKQogCXJldHVybiAwOwogfQog
Ci0vKgotICogcnVuX2JlbmNobWFyayAtIFJ1biBhIHNwZWNpZmllZCBiZW5jaG1hcmsgb3Ig
ZmlsbF9idWYgKGRlZmF1bHQgYmVuY2htYXJrKQotICoJCSAgIGluIHNwZWNpZmllZCBzaWdu
YWwuIERpcmVjdCBiZW5jaG1hcmsgc3RkaW8gdG8gL2Rldi9udWxsLgotICogQHNpZ251bToJ
c2lnbmFsIG51bWJlcgotICogQGluZm86CXNpZ25hbCBpbmZvCi0gKiBAdWNvbnRleHQ6CXVz
ZXIgY29udGV4dCBpbiBzaWduYWwgaGFuZGxpbmcKLSAqCi0gKiBSZXR1cm46IHZvaWQKLSAq
Lwotdm9pZCBydW5fYmVuY2htYXJrKGludCBzaWdudW0sIHNpZ2luZm9fdCAqaW5mbywgdm9p
ZCAqdWNvbnRleHQpCi17Ci0JaW50IG9wZXJhdGlvbiwgcmV0LCBtZW1mbHVzaDsKLQljaGFy
ICoqYmVuY2htYXJrX2NtZDsKLQlzaXplX3Qgc3BhbjsKLQlib29sIG9uY2U7Ci0JRklMRSAq
ZnA7Ci0KLQliZW5jaG1hcmtfY21kID0gaW5mby0+c2lfcHRyOwotCi0JLyoKLQkgKiBEaXJl
Y3Qgc3RkaW8gb2YgY2hpbGQgdG8gL2Rldi9udWxsLCBzbyB0aGF0IG9ubHkgcGFyZW50IHdy
aXRlcyB0bwotCSAqIHN0ZGlvIChjb25zb2xlKQotCSAqLwotCWZwID0gZnJlb3BlbigiL2Rl
di9udWxsIiwgInciLCBzdGRvdXQpOwotCWlmICghZnApCi0JCVBBUkVOVF9FWElUKCJVbmFi
bGUgdG8gZGlyZWN0IGJlbmNobWFyayBzdGF0dXMgdG8gL2Rldi9udWxsIik7Ci0KLQlpZiAo
c3RyY21wKGJlbmNobWFya19jbWRbMF0sICJmaWxsX2J1ZiIpID09IDApIHsKLQkJLyogRXhl
Y3V0ZSBkZWZhdWx0IGZpbGxfYnVmIGJlbmNobWFyayAqLwotCQlzcGFuID0gc3RydG91bChi
ZW5jaG1hcmtfY21kWzFdLCBOVUxMLCAxMCk7Ci0JCW1lbWZsdXNoID0gIGF0b2koYmVuY2ht
YXJrX2NtZFsyXSk7Ci0JCW9wZXJhdGlvbiA9IGF0b2koYmVuY2htYXJrX2NtZFszXSk7Ci0J
CWlmICghc3RyY21wKGJlbmNobWFya19jbWRbNF0sICJ0cnVlIikpCi0JCQlvbmNlID0gdHJ1
ZTsKLQkJZWxzZSBpZiAoIXN0cmNtcChiZW5jaG1hcmtfY21kWzRdLCAiZmFsc2UiKSkKLQkJ
CW9uY2UgPSBmYWxzZTsKLQkJZWxzZQotCQkJUEFSRU5UX0VYSVQoIkludmFsaWQgb25jZSBw
YXJhbWV0ZXIiKTsKLQotCQlpZiAocnVuX2ZpbGxfYnVmKHNwYW4sIG1lbWZsdXNoLCBvcGVy
YXRpb24sIG9uY2UpKQotCQkJZnByaW50ZihzdGRlcnIsICJFcnJvciBpbiBydW5uaW5nIGZp
bGwgYnVmZmVyXG4iKTsKLQl9IGVsc2UgewotCQkvKiBFeGVjdXRlIHNwZWNpZmllZCBiZW5j
aG1hcmsgKi8KLQkJcmV0ID0gZXhlY3ZwKGJlbmNobWFya19jbWRbMF0sIGJlbmNobWFya19j
bWQpOwotCQlpZiAocmV0KQotCQkJcGVycm9yKCJ3cm9uZ1xuIik7Ci0JfQotCi0JZmNsb3Nl
KHN0ZG91dCk7Ci0JUEFSRU5UX0VYSVQoIlVuYWJsZSB0byBydW4gc3BlY2lmaWVkIGJlbmNo
bWFyayIpOwotfQotCiAvKgogICogY3JlYXRlX2dycCAtIENyZWF0ZSBhIGdyb3VwIG9ubHkg
aWYgb25lIGRvZXNuJ3QgZXhpc3QKICAqIEBncnBfbmFtZToJTmFtZSBvZiB0aGUgZ3JvdXAK
QEAgLTQ4OCw5ICs0MzksOCBAQCBpbnQgd3JpdGVfYm1fcGlkX3RvX3Jlc2N0cmwocGlkX3Qg
Ym1fcGlkLCBjaGFyICpjdHJsZ3JwLCBjaGFyICptb25ncnAsCiAgKi8KIGludCB3cml0ZV9z
Y2hlbWF0YShjaGFyICpjdHJsZ3JwLCBjaGFyICpzY2hlbWF0YSwgaW50IGNwdV9ubywgY2hh
ciAqcmVzY3RybF92YWwpCiB7Ci0JY2hhciBjb250cm9sZ3JvdXBbMTAyNF0sIHNjaGVtYVsx
MDI0XSwgcmVhc29uWzY0XTsKLQlpbnQgcmVzb3VyY2VfaWQsIHJldCA9IDA7Ci0JRklMRSAq
ZnA7CisJY2hhciBjb250cm9sZ3JvdXBbMTAyNF0sIHJlYXNvblsxMjhdLCBzY2hlbWFbMTAy
NF0gPSB7fTsKKwlpbnQgcmVzb3VyY2VfaWQsIGZkLCBzY2hlbWFfbGVuID0gLTEsIHJldCA9
IDA7CiAKIAlpZiAoc3RybmNtcChyZXNjdHJsX3ZhbCwgTUJBX1NUUiwgc2l6ZW9mKE1CQV9T
VFIpKSAmJgogCSAgICBzdHJuY21wKHJlc2N0cmxfdmFsLCBNQk1fU1RSLCBzaXplb2YoTUJN
X1NUUikpICYmCkBAIC01MTgsMjggKzQ2OCwzOSBAQCBpbnQgd3JpdGVfc2NoZW1hdGEoY2hh
ciAqY3RybGdycCwgY2hhciAqc2NoZW1hdGEsIGludCBjcHVfbm8sIGNoYXIgKnJlc2N0cmxf
dmFsKQogCiAJaWYgKCFzdHJuY21wKHJlc2N0cmxfdmFsLCBDQVRfU1RSLCBzaXplb2YoQ0FU
X1NUUikpIHx8CiAJICAgICFzdHJuY21wKHJlc2N0cmxfdmFsLCBDTVRfU1RSLCBzaXplb2Yo
Q01UX1NUUikpKQotCQlzcHJpbnRmKHNjaGVtYSwgIiVzJWQlYyVzIiwgIkwzOiIsIHJlc291
cmNlX2lkLCAnPScsIHNjaGVtYXRhKTsKKwkJc2NoZW1hX2xlbiA9IHNucHJpbnRmKHNjaGVt
YSwgc2l6ZW9mKHNjaGVtYSksICIlcyVkJWMlc1xuIiwKKwkJCQkgICAgICAiTDM6IiwgcmVz
b3VyY2VfaWQsICc9Jywgc2NoZW1hdGEpOwogCWlmICghc3RybmNtcChyZXNjdHJsX3ZhbCwg
TUJBX1NUUiwgc2l6ZW9mKE1CQV9TVFIpKSB8fAogCSAgICAhc3RybmNtcChyZXNjdHJsX3Zh
bCwgTUJNX1NUUiwgc2l6ZW9mKE1CTV9TVFIpKSkKLQkJc3ByaW50ZihzY2hlbWEsICIlcyVk
JWMlcyIsICJNQjoiLCByZXNvdXJjZV9pZCwgJz0nLCBzY2hlbWF0YSk7Ci0KLQlmcCA9IGZv
cGVuKGNvbnRyb2xncm91cCwgInciKTsKLQlpZiAoIWZwKSB7Ci0JCXNwcmludGYocmVhc29u
LCAiRmFpbGVkIHRvIG9wZW4gY29udHJvbCBncm91cCIpOworCQlzY2hlbWFfbGVuID0gc25w
cmludGYoc2NoZW1hLCBzaXplb2Yoc2NoZW1hKSwgIiVzJWQlYyVzXG4iLAorCQkJCSAgICAg
ICJNQjoiLCByZXNvdXJjZV9pZCwgJz0nLCBzY2hlbWF0YSk7CisJaWYgKHNjaGVtYV9sZW4g
PCAwIHx8IHNjaGVtYV9sZW4gPj0gc2l6ZW9mKHNjaGVtYSkpIHsKKwkJc25wcmludGYocmVh
c29uLCBzaXplb2YocmVhc29uKSwKKwkJCSAic25wcmludGYoKSBmYWlsZWQgd2l0aCByZXR1
cm4gdmFsdWUgOiAlZCIsIHNjaGVtYV9sZW4pOwogCQlyZXQgPSAtMTsKLQogCQlnb3RvIG91
dDsKIAl9CiAKLQlpZiAoZnByaW50ZihmcCwgIiVzXG4iLCBzY2hlbWEpIDwgMCkgewotCQlz
cHJpbnRmKHJlYXNvbiwgIkZhaWxlZCB0byB3cml0ZSBzY2hlbWF0YSBpbiBjb250cm9sIGdy
b3VwIik7Ci0JCWZjbG9zZShmcCk7CisJZmQgPSBvcGVuKGNvbnRyb2xncm91cCwgT19XUk9O
TFkpOworCWlmIChmZCA8IDApIHsKKwkJc25wcmludGYocmVhc29uLCBzaXplb2YocmVhc29u
KSwKKwkJCSAib3BlbigpIGZhaWxlZCA6ICVzIiwgc3RyZXJyb3IoZXJybm8pKTsKIAkJcmV0
ID0gLTE7CiAKLQkJZ290byBvdXQ7CisJCWdvdG8gZXJyX3NjaGVtYV9ub3RfZW1wdHk7CiAJ
fQotCWZjbG9zZShmcCk7CisJaWYgKHdyaXRlKGZkLCBzY2hlbWEsIHNjaGVtYV9sZW4pIDwg
MCkgeworCQlzbnByaW50ZihyZWFzb24sIHNpemVvZihyZWFzb24pLAorCQkJICJ3cml0ZSgp
IGZhaWxlZCA6ICVzIiwgc3RyZXJyb3IoZXJybm8pKTsKKwkJY2xvc2UoZmQpOworCQlyZXQg
PSAtMTsKKworCQlnb3RvIGVycl9zY2hlbWFfbm90X2VtcHR5OworCX0KKwljbG9zZShmZCk7
CiAKK2Vycl9zY2hlbWFfbm90X2VtcHR5OgorCXNjaGVtYVtzY2hlbWFfbGVuIC0gMV0gPSAw
Owogb3V0OgogCWtzZnRfcHJpbnRfbXNnKCJXcml0ZSBzY2hlbWEgXCIlc1wiIHRvIHJlc2N0
cmwgRlMlcyVzXG4iLAogCQkgICAgICAgc2NoZW1hLCByZXQgPyAiICMgIiA6ICIiLApAQCAt
NjA0LDYzICs1NjUsNDYgQEAgY2hhciAqZmdyZXAoRklMRSAqaW5mLCBjb25zdCBjaGFyICpz
dHIpCiAKIC8qCiAgKiB2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdCAtIENoZWNr
IGlmIHJlcXVlc3RlZCBmZWF0dXJlIGlzIHZhbGlkLgotICogQHJlc2N0cmxfdmFsOglSZXF1
ZXN0ZWQgZmVhdHVyZQorICogQHJlc291cmNlOglSZXF1aXJlZCByZXNvdXJjZSAoZS5nLiwg
TUIsIEwzLCBMMiwgTDNfTU9OLCBldGMuKQorICogQGZlYXR1cmU6CVJlcXVpcmVkIG1vbml0
b3IgZmVhdHVyZSAoaW4gbW9uX2ZlYXR1cmVzIGZpbGUpLiBDYW4gb25seSBiZQorICoJCXNl
dCBmb3IgTDNfTU9OLiBNdXN0IGJlIE5VTEwgZm9yIGFsbCBvdGhlciByZXNvdXJjZXMuCiAg
KgotICogUmV0dXJuOiBUcnVlIGlmIHRoZSBmZWF0dXJlIGlzIHN1cHBvcnRlZCwgZWxzZSBm
YWxzZS4gRmFsc2UgaXMgYWxzbwotICogICAgICAgICByZXR1cm5lZCBpZiByZXNjdHJsIEZT
IGlzIG5vdCBtb3VudGVkLgorICogUmV0dXJuOiBUcnVlIGlmIHRoZSByZXNvdXJjZS9mZWF0
dXJlIGlzIHN1cHBvcnRlZCwgZWxzZSBmYWxzZS4gRmFsc2UgaXMKKyAqICAgICAgICAgYWxz
byByZXR1cm5lZCBpZiByZXNjdHJsIEZTIGlzIG5vdCBtb3VudGVkLgogICovCi1ib29sIHZh
bGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KGNvbnN0IGNoYXIgKnJlc2N0cmxfdmFs
KQorYm9vbCB2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChjb25zdCBjaGFyICpy
ZXNvdXJjZSwgY29uc3QgY2hhciAqZmVhdHVyZSkKIHsKKwljaGFyIHJlc19wYXRoW1BBVEhf
TUFYXTsKIAlzdHJ1Y3Qgc3RhdCBzdGF0YnVmOwotCWJvb2wgZm91bmQgPSBmYWxzZTsKIAlj
aGFyICpyZXM7CiAJRklMRSAqaW5mOwogCWludCByZXQ7CiAKLQlpZiAoIXJlc2N0cmxfdmFs
KQorCWlmICghcmVzb3VyY2UpCiAJCXJldHVybiBmYWxzZTsKIAogCXJldCA9IGZpbmRfcmVz
Y3RybF9tb3VudChOVUxMKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gZmFsc2U7CiAKLQlpZiAo
IXN0cm5jbXAocmVzY3RybF92YWwsIENBVF9TVFIsIHNpemVvZihDQVRfU1RSKSkpIHsKLQkJ
aWYgKCFzdGF0KEwzX1BBVEgsICZzdGF0YnVmKSkKLQkJCXJldHVybiB0cnVlOwotCX0gZWxz
ZSBpZiAoIXN0cm5jbXAocmVzY3RybF92YWwsIE1CQV9TVFIsIHNpemVvZihNQkFfU1RSKSkp
IHsKLQkJaWYgKCFzdGF0KE1CX1BBVEgsICZzdGF0YnVmKSkKLQkJCXJldHVybiB0cnVlOwot
CX0gZWxzZSBpZiAoIXN0cm5jbXAocmVzY3RybF92YWwsIE1CTV9TVFIsIHNpemVvZihNQk1f
U1RSKSkgfHwKLQkJICAgIXN0cm5jbXAocmVzY3RybF92YWwsIENNVF9TVFIsIHNpemVvZihD
TVRfU1RSKSkpIHsKLQkJaWYgKCFzdGF0KEwzX01PTl9QQVRILCAmc3RhdGJ1ZikpIHsKLQkJ
CWluZiA9IGZvcGVuKEwzX01PTl9GRUFUVVJFU19QQVRILCAiciIpOwotCQkJaWYgKCFpbmYp
Ci0JCQkJcmV0dXJuIGZhbHNlOwotCi0JCQlpZiAoIXN0cm5jbXAocmVzY3RybF92YWwsIENN
VF9TVFIsIHNpemVvZihDTVRfU1RSKSkpIHsKLQkJCQlyZXMgPSBmZ3JlcChpbmYsICJsbGNf
b2NjdXBhbmN5Iik7Ci0JCQkJaWYgKHJlcykgewotCQkJCQlmb3VuZCA9IHRydWU7Ci0JCQkJ
CWZyZWUocmVzKTsKLQkJCQl9Ci0JCQl9Ci0KLQkJCWlmICghc3RybmNtcChyZXNjdHJsX3Zh
bCwgTUJNX1NUUiwgc2l6ZW9mKE1CTV9TVFIpKSkgewotCQkJCXJlcyA9IGZncmVwKGluZiwg
Im1ibV90b3RhbF9ieXRlcyIpOwotCQkJCWlmIChyZXMpIHsKLQkJCQkJZnJlZShyZXMpOwot
CQkJCQlyZXMgPSBmZ3JlcChpbmYsICJtYm1fbG9jYWxfYnl0ZXMiKTsKLQkJCQkJaWYgKHJl
cykgewotCQkJCQkJZm91bmQgPSB0cnVlOwotCQkJCQkJZnJlZShyZXMpOwotCQkJCQl9Ci0J
CQkJfQotCQkJfQotCQkJZmNsb3NlKGluZik7Ci0JCX0KLQl9CisJc25wcmludGYocmVzX3Bh
dGgsIHNpemVvZihyZXNfcGF0aCksICIlcy8lcyIsIElORk9fUEFUSCwgcmVzb3VyY2UpOwor
CisJaWYgKHN0YXQocmVzX3BhdGgsICZzdGF0YnVmKSkKKwkJcmV0dXJuIGZhbHNlOworCisJ
aWYgKCFmZWF0dXJlKQorCQlyZXR1cm4gdHJ1ZTsKKworCXNucHJpbnRmKHJlc19wYXRoLCBz
aXplb2YocmVzX3BhdGgpLCAiJXMvJXMvbW9uX2ZlYXR1cmVzIiwgSU5GT19QQVRILCByZXNv
dXJjZSk7CisJaW5mID0gZm9wZW4ocmVzX3BhdGgsICJyIik7CisJaWYgKCFpbmYpCisJCXJl
dHVybiBmYWxzZTsKKworCXJlcyA9IGZncmVwKGluZiwgZmVhdHVyZSk7CisJZnJlZShyZXMp
OworCWZjbG9zZShpbmYpOwogCi0JcmV0dXJuIGZvdW5kOworCXJldHVybiAhIXJlczsKIH0K
IAogaW50IGZpbHRlcl9kbWVzZyh2b2lkKQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcnNlcS9wYXJhbV90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
c2VxL3BhcmFtX3Rlc3QuYwppbmRleCBiZjk1MWE0OTBiYjQuLjIwNDAzZDU4MzQ1YyAxMDA2
NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnNlcS9wYXJhbV90ZXN0LmMKKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnNlcS9wYXJhbV90ZXN0LmMKQEAgLTEyMzEs
NyArMTIzMSw3IEBAIHZvaWQgKnRlc3RfbWVtYmFycmllcl93b3JrZXJfdGhyZWFkKHZvaWQg
KmFyZykKIAl9CiAKIAkvKiBXYWl0IGZvciBpbml0aWFsaXphdGlvbi4gKi8KLQl3aGlsZSAo
IWF0b21pY19sb2FkKCZhcmdzLT5wZXJjcHVfbGlzdF9wdHIpKSB7fQorCXdoaWxlICghX19h
dG9taWNfbG9hZF9uKCZhcmdzLT5wZXJjcHVfbGlzdF9wdHIsIF9fQVRPTUlDX0FDUVVJUkUp
KSB7fQogCiAJZm9yIChpID0gMDsgaSA8IGl0ZXJzOyArK2kpIHsKIAkJaW50IHJldDsKQEAg
LTEyOTksMjIgKzEyOTksMjIgQEAgdm9pZCAqdGVzdF9tZW1iYXJyaWVyX21hbmFnZXJfdGhy
ZWFkKHZvaWQgKmFyZykKIAl0ZXN0X21lbWJhcnJpZXJfaW5pdF9wZXJjcHVfbGlzdCgmbGlz
dF9hKTsKIAl0ZXN0X21lbWJhcnJpZXJfaW5pdF9wZXJjcHVfbGlzdCgmbGlzdF9iKTsKIAot
CWF0b21pY19zdG9yZSgmYXJncy0+cGVyY3B1X2xpc3RfcHRyLCAoaW50cHRyX3QpJmxpc3Rf
YSk7CisJX19hdG9taWNfc3RvcmVfbigmYXJncy0+cGVyY3B1X2xpc3RfcHRyLCAoaW50cHRy
X3QpJmxpc3RfYSwgX19BVE9NSUNfUkVMRUFTRSk7CiAKLQl3aGlsZSAoIWF0b21pY19sb2Fk
KCZhcmdzLT5zdG9wKSkgeworCXdoaWxlICghX19hdG9taWNfbG9hZF9uKCZhcmdzLT5zdG9w
LCBfX0FUT01JQ19BQ1FVSVJFKSkgewogCQkvKiBsaXN0X2EgaXMgImFjdGl2ZSIuICovCiAJ
CWNwdV9hID0gcmFuZCgpICUgQ1BVX1NFVFNJWkU7CiAJCS8qCiAJCSAqIEFzIGxpc3RfYiBp
cyAiaW5hY3RpdmUiLCB3ZSBzaG91bGQgbmV2ZXIgc2VlIGNoYW5nZXMKIAkJICogdG8gbGlz
dF9iLgogCQkgKi8KLQkJaWYgKGV4cGVjdF9iICE9IGF0b21pY19sb2FkKCZsaXN0X2IuY1tj
cHVfYl0uaGVhZC0+ZGF0YSkpIHsKKwkJaWYgKGV4cGVjdF9iICE9IF9fYXRvbWljX2xvYWRf
bigmbGlzdF9iLmNbY3B1X2JdLmhlYWQtPmRhdGEsIF9fQVRPTUlDX0FDUVVJUkUpKSB7CiAJ
CQlmcHJpbnRmKHN0ZGVyciwgIk1lbWJhcnJpZXIgdGVzdCBmYWlsZWRcbiIpOwogCQkJYWJv
cnQoKTsKIAkJfQogCiAJCS8qIE1ha2UgbGlzdF9iICJhY3RpdmUiLiAqLwotCQlhdG9taWNf
c3RvcmUoJmFyZ3MtPnBlcmNwdV9saXN0X3B0ciwgKGludHB0cl90KSZsaXN0X2IpOworCQlf
X2F0b21pY19zdG9yZV9uKCZhcmdzLT5wZXJjcHVfbGlzdF9wdHIsIChpbnRwdHJfdCkmbGlz
dF9iLCBfX0FUT01JQ19SRUxFQVNFKTsKIAkJaWYgKHJzZXFfbWVtYmFycmllcl9leHBlZGl0
ZWQoY3B1X2EpICYmCiAJCQkJZXJybm8gIT0gRU5YSU8gLyogbWlzc2luZyBDUFUgKi8pIHsK
IAkJCXBlcnJvcigic3lzX21lbWJhcnJpZXIiKTsKQEAgLTEzMjQsMjcgKzEzMjQsMjcgQEAg
dm9pZCAqdGVzdF9tZW1iYXJyaWVyX21hbmFnZXJfdGhyZWFkKHZvaWQgKmFyZykKIAkJICog
Q3B1IEEgc2hvdWxkIG5vdyBvbmx5IG1vZGlmeSBsaXN0X2IsIHNvIHRoZSB2YWx1ZXMKIAkJ
ICogaW4gbGlzdF9hIHNob3VsZCBiZSBzdGFibGUuCiAJCSAqLwotCQlleHBlY3RfYSA9IGF0
b21pY19sb2FkKCZsaXN0X2EuY1tjcHVfYV0uaGVhZC0+ZGF0YSk7CisJCWV4cGVjdF9hID0g
X19hdG9taWNfbG9hZF9uKCZsaXN0X2EuY1tjcHVfYV0uaGVhZC0+ZGF0YSwgX19BVE9NSUNf
QUNRVUlSRSk7CiAKIAkJY3B1X2IgPSByYW5kKCkgJSBDUFVfU0VUU0laRTsKIAkJLyoKIAkJ
ICogQXMgbGlzdF9hIGlzICJpbmFjdGl2ZSIsIHdlIHNob3VsZCBuZXZlciBzZWUgY2hhbmdl
cwogCQkgKiB0byBsaXN0X2EuCiAJCSAqLwotCQlpZiAoZXhwZWN0X2EgIT0gYXRvbWljX2xv
YWQoJmxpc3RfYS5jW2NwdV9hXS5oZWFkLT5kYXRhKSkgeworCQlpZiAoZXhwZWN0X2EgIT0g
X19hdG9taWNfbG9hZF9uKCZsaXN0X2EuY1tjcHVfYV0uaGVhZC0+ZGF0YSwgX19BVE9NSUNf
QUNRVUlSRSkpIHsKIAkJCWZwcmludGYoc3RkZXJyLCAiTWVtYmFycmllciB0ZXN0IGZhaWxl
ZFxuIik7CiAJCQlhYm9ydCgpOwogCQl9CiAKIAkJLyogTWFrZSBsaXN0X2EgImFjdGl2ZSIu
ICovCi0JCWF0b21pY19zdG9yZSgmYXJncy0+cGVyY3B1X2xpc3RfcHRyLCAoaW50cHRyX3Qp
Jmxpc3RfYSk7CisJCV9fYXRvbWljX3N0b3JlX24oJmFyZ3MtPnBlcmNwdV9saXN0X3B0ciwg
KGludHB0cl90KSZsaXN0X2EsIF9fQVRPTUlDX1JFTEVBU0UpOwogCQlpZiAocnNlcV9tZW1i
YXJyaWVyX2V4cGVkaXRlZChjcHVfYikgJiYKIAkJCQllcnJubyAhPSBFTlhJTyAvKiBtaXNz
aW5nIENQVSovKSB7CiAJCQlwZXJyb3IoInN5c19tZW1iYXJyaWVyIik7CiAJCQlhYm9ydCgp
OwogCQl9CiAJCS8qIFJlbWVtYmVyIGEgdmFsdWUgZnJvbSBsaXN0X2IuICovCi0JCWV4cGVj
dF9iID0gYXRvbWljX2xvYWQoJmxpc3RfYi5jW2NwdV9iXS5oZWFkLT5kYXRhKTsKKwkJZXhw
ZWN0X2IgPSBfX2F0b21pY19sb2FkX24oJmxpc3RfYi5jW2NwdV9iXS5oZWFkLT5kYXRhLCBf
X0FUT01JQ19BQ1FVSVJFKTsKIAl9CiAKIAl0ZXN0X21lbWJhcnJpZXJfZnJlZV9wZXJjcHVf
bGlzdCgmbGlzdF9hKTsKQEAgLTE0MDEsNyArMTQwMSw3IEBAIHZvaWQgdGVzdF9tZW1iYXJy
aWVyKHZvaWQpCiAJCX0KIAl9CiAKLQlhdG9taWNfc3RvcmUoJnRocmVhZF9hcmdzLnN0b3As
IDEpOworCV9fYXRvbWljX3N0b3JlX24oJnRocmVhZF9hcmdzLnN0b3AsIDEsIF9fQVRPTUlD
X1JFTEVBU0UpOwogCXJldCA9IHB0aHJlYWRfam9pbihtYW5hZ2VyX3RocmVhZCwgTlVMTCk7
CiAJaWYgKHJldCkgewogCQllcnJubyA9IHJldDsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3NpZ2FsdHN0YWNrL3Nhcy5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvc2lnYWx0c3RhY2svc2FzLmMKaW5kZXggOThkMzdjYjc0NGZiLi4wNzIyN2ZhYjFjYzkg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NpZ2FsdHN0YWNrL3Nhcy5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NpZ2FsdHN0YWNrL3Nhcy5jCkBAIC0x
MTEsNyArMTExLDcgQEAgaW50IG1haW4odm9pZCkKIAogCS8qIE1ha2Ugc3VyZSBtb3JlIHRo
YW4gdGhlIHJlcXVpcmVkIG1pbmltdW0uICovCiAJc3RhY2tfc2l6ZSA9IGdldGF1eHZhbChB
VF9NSU5TSUdTVEtTWikgKyBTSUdTVEtTWjsKLQlrc2Z0X3ByaW50X21zZygiW05PVEVdXHR0
aGUgc3RhY2sgc2l6ZSBpcyAlbHVcbiIsIHN0YWNrX3NpemUpOworCWtzZnRfcHJpbnRfbXNn
KCJbTk9URV1cdHRoZSBzdGFjayBzaXplIGlzICV1XG4iLCBzdGFja19zaXplKTsKIAogCWtz
ZnRfcHJpbnRfaGVhZGVyKCk7CiAJa3NmdF9zZXRfcGxhbigzKTsKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3N0YXRpY19rZXlzL3Rlc3Rfc3RhdGljX2tleXMuc2gg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zdGF0aWNfa2V5cy90ZXN0X3N0YXRpY19rZXlz
LnNoCmluZGV4IGZjOWY4Y2RlN2Q0Mi4uM2IwZjE3YjgxYWMyIDEwMDc1NQotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9zdGF0aWNfa2V5cy90ZXN0X3N0YXRpY19rZXlzLnNoCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3N0YXRpY19rZXlzL3Rlc3Rfc3RhdGljX2tl
eXMuc2gKQEAgLTYsMTggKzYsMTggQEAKIGtzZnRfc2tpcD00CiAKIGlmICEgL3NiaW4vbW9k
cHJvYmUgLXEgLW4gdGVzdF9zdGF0aWNfa2V5X2Jhc2U7IHRoZW4KLQllY2hvICJzdGF0aWNf
a2V5OiBtb2R1bGUgdGVzdF9zdGF0aWNfa2V5X2Jhc2UgaXMgbm90IGZvdW5kIFtTS0lQXSIK
KwllY2hvICJzdGF0aWNfa2V5czogbW9kdWxlIHRlc3Rfc3RhdGljX2tleV9iYXNlIGlzIG5v
dCBmb3VuZCBbU0tJUF0iCiAJZXhpdCAka3NmdF9za2lwCiBmaQogCiBpZiAhIC9zYmluL21v
ZHByb2JlIC1xIC1uIHRlc3Rfc3RhdGljX2tleXM7IHRoZW4KLQllY2hvICJzdGF0aWNfa2V5
OiBtb2R1bGUgdGVzdF9zdGF0aWNfa2V5cyBpcyBub3QgZm91bmQgW1NLSVBdIgorCWVjaG8g
InN0YXRpY19rZXlzOiBtb2R1bGUgdGVzdF9zdGF0aWNfa2V5cyBpcyBub3QgZm91bmQgW1NL
SVBdIgogCWV4aXQgJGtzZnRfc2tpcAogZmkKIAogaWYgL3NiaW4vbW9kcHJvYmUgLXEgdGVz
dF9zdGF0aWNfa2V5X2Jhc2U7IHRoZW4KIAlpZiAvc2Jpbi9tb2Rwcm9iZSAtcSB0ZXN0X3N0
YXRpY19rZXlzOyB0aGVuCi0JCWVjaG8gInN0YXRpY19rZXk6IG9rIgorCQllY2hvICJzdGF0
aWNfa2V5czogb2siCiAJCS9zYmluL21vZHByb2JlIC1xIC1yIHRlc3Rfc3RhdGljX2tleXMK
IAkJL3NiaW4vbW9kcHJvYmUgLXEgLXIgdGVzdF9zdGF0aWNfa2V5X2Jhc2UKIAllbHNlCkBA
IC0yNSw2ICsyNSw2IEBAIGlmIC9zYmluL21vZHByb2JlIC1xIHRlc3Rfc3RhdGljX2tleV9i
YXNlOyB0aGVuCiAJCS9zYmluL21vZHByb2JlIC1xIC1yIHRlc3Rfc3RhdGljX2tleV9iYXNl
CiAJZmkKIGVsc2UKLQllY2hvICJzdGF0aWNfa2V5OiBbRkFJTF0iCisJZWNobyAic3RhdGlj
X2tleXM6IFtGQUlMXSIKIAlleGl0IDEKIGZpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy90ZHgvLmdpdGlnbm9yZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Rk
eC8uZ2l0aWdub3JlCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4u
NWRiNGQxNWNjNjczCi0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdGR4Ly5naXRpZ25vcmUKQEAgLTAsMCArMSBAQAordGR4X2d1ZXN0X3Rlc3QKZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9uc2xlZXAtbGF0LmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvbnNsZWVwLWxhdC5jCmluZGV4IGViM2U3
OWVkN2I0YS4uZWRiNWFjYWNmMjE0IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy90aW1lcnMvbnNsZWVwLWxhdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3RpbWVycy9uc2xlZXAtbGF0LmMKQEAgLTExOCw3ICsxMTgsNyBAQCBpbnQgbmFub3NsZWVw
X2xhdF90ZXN0KGludCBjbG9ja2lkLCBsb25nIGxvbmcgbnMpCiAJY2xvY2tfZ2V0dGltZShj
bG9ja2lkLCAmZW5kKTsKIAogCWlmICgoKHRpbWVzcGVjX3N1YihzdGFydCwgZW5kKS9jb3Vu
dCktbnMpID4gVU5SRVNPTkFCTEVfTEFURU5DWSkgewotCQlwcmludGYoIkxhcmdlIHJlbCBs
YXRlbmN5OiAlbGxkIG5zIDoiLCAodGltZXNwZWNfc3ViKHN0YXJ0LCBlbmQpL2NvdW50KS1u
cyk7CisJCWtzZnRfcHJpbnRfbXNnKCJMYXJnZSByZWwgbGF0ZW5jeTogJWxsZCBucyA6Iiwg
KHRpbWVzcGVjX3N1YihzdGFydCwgZW5kKS9jb3VudCktbnMpOwogCQlyZXR1cm4gLTE7CiAJ
fQogCkBAIC0xMzIsMjAgKzEzMiwyMyBAQCBpbnQgbmFub3NsZWVwX2xhdF90ZXN0KGludCBj
bG9ja2lkLCBsb25nIGxvbmcgbnMpCiAJfQogCiAJaWYgKGxhdGVuY3kvY291bnQgPiBVTlJF
U09OQUJMRV9MQVRFTkNZKSB7Ci0JCXByaW50ZigiTGFyZ2UgYWJzIGxhdGVuY3k6ICVsbGQg
bnMgOiIsIGxhdGVuY3kvY291bnQpOworCQlrc2Z0X3ByaW50X21zZygiTGFyZ2UgYWJzIGxh
dGVuY3k6ICVsbGQgbnMgOiIsIGxhdGVuY3kvY291bnQpOwogCQlyZXR1cm4gLTE7CiAJfQog
CiAJcmV0dXJuIDA7CiB9CiAKLQorI2RlZmluZSBTS0lQUEVEX0NMT0NLX0NPVU5UIDMKIAog
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewogCWxvbmcgbG9uZyBsZW5ndGg7
CiAJaW50IGNsb2NraWQsIHJldDsKIAorCWtzZnRfcHJpbnRfaGVhZGVyKCk7CisJa3NmdF9z
ZXRfcGxhbihOUl9DTE9DS0lEUyAtIENMT0NLX1JFQUxUSU1FIC0gU0tJUFBFRF9DTE9DS19D
T1VOVCk7CisKIAlmb3IgKGNsb2NraWQgPSBDTE9DS19SRUFMVElNRTsgY2xvY2tpZCA8IE5S
X0NMT0NLSURTOyBjbG9ja2lkKyspIHsKIAogCQkvKiBTa2lwIGNwdXRpbWUgY2xvY2tpZHMg
c2luY2UgbmFub3NsZWVwIHdvbid0IGluY3JlbWVudCBjcHV0aW1lICovCkBAIC0xNTQsOSAr
MTU3LDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJCWNsb2NraWQg
PT0gQ0xPQ0tfSFdTUEVDSUZJQykKIAkJCWNvbnRpbnVlOwogCi0JCXByaW50ZigibnNsZWVw
IGxhdGVuY3kgJS0yNnMgIiwgY2xvY2tzdHJpbmcoY2xvY2tpZCkpOwotCQlmZmx1c2goc3Rk
b3V0KTsKLQogCQlsZW5ndGggPSAxMDsKIAkJd2hpbGUgKGxlbmd0aCA8PSAoTlNFQ19QRVJf
U0VDICogMTApKSB7CiAJCQlyZXQgPSBuYW5vc2xlZXBfbGF0X3Rlc3QoY2xvY2tpZCwgbGVu
Z3RoKTsKQEAgLTE2NywxNCArMTY3LDEyIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoq
YXJndikKIAkJfQogCiAJCWlmIChyZXQgPT0gVU5TVVBQT1JURUQpIHsKLQkJCXByaW50Zigi
W1VOU1VQUE9SVEVEXVxuIik7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAocmV0IDwgMCkg
ewotCQkJcHJpbnRmKCJbRkFJTEVEXVxuIik7Ci0JCQlyZXR1cm4ga3NmdF9leGl0X2ZhaWwo
KTsKKwkJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiJXNcbiIsIGNsb2Nrc3RyaW5nKGNsb2Nr
aWQpKTsKKwkJfSBlbHNlIHsKKwkJCWtzZnRfdGVzdF9yZXN1bHQocmV0ID49IDAsICIlc1xu
IiwKKwkJCQkJIGNsb2Nrc3RyaW5nKGNsb2NraWQpKTsKIAkJfQotCQlwcmludGYoIltPS11c
biIpOwogCX0KLQlyZXR1cm4ga3NmdF9leGl0X3Bhc3MoKTsKKworCWtzZnRfZmluaXNoZWQo
KTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9wb3Np
eF90aW1lcnMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9wb3NpeF90aW1l
cnMuYwppbmRleCA4YTE3YzBlOGQ4MmIuLmQ0OWRkM2ZmZDBkOSAxMDA2NDQKLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3Bvc2l4X3RpbWVycy5jCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9wb3NpeF90aW1lcnMuYwpAQCAtNzYsMjIgKzc2
LDIxIEBAIHN0YXRpYyBpbnQgY2hlY2tfZGlmZihzdHJ1Y3QgdGltZXZhbCBzdGFydCwgc3Ry
dWN0IHRpbWV2YWwgZW5kKQogCiBzdGF0aWMgaW50IGNoZWNrX2l0aW1lcihpbnQgd2hpY2gp
CiB7CisJY29uc3QgY2hhciAqbmFtZTsKIAlpbnQgZXJyOwogCXN0cnVjdCB0aW1ldmFsIHN0
YXJ0LCBlbmQ7CiAJc3RydWN0IGl0aW1lcnZhbCB2YWwgPSB7CiAJCS5pdF92YWx1ZS50dl9z
ZWMgPSBERUxBWSwKIAl9OwogCi0JcHJpbnRmKCJDaGVjayBpdGltZXIgIik7Ci0KIAlpZiAo
d2hpY2ggPT0gSVRJTUVSX1ZJUlRVQUwpCi0JCXByaW50ZigidmlydHVhbC4uLiAiKTsKKwkJ
bmFtZSA9ICJJVElNRVJfVklSVFVBTCI7CiAJZWxzZSBpZiAod2hpY2ggPT0gSVRJTUVSX1BS
T0YpCi0JCXByaW50ZigicHJvZi4uLiAiKTsKKwkJbmFtZSA9ICJJVElNRVJfUFJPRiI7CiAJ
ZWxzZSBpZiAod2hpY2ggPT0gSVRJTUVSX1JFQUwpCi0JCXByaW50ZigicmVhbC4uLiAiKTsK
LQotCWZmbHVzaChzdGRvdXQpOworCQluYW1lID0gIklUSU1FUl9SRUFMIjsKKwllbHNlCisJ
CXJldHVybiAtMTsKIAogCWRvbmUgPSAwOwogCkBAIC0xMDQsMTMgKzEwMywxMyBAQCBzdGF0
aWMgaW50IGNoZWNrX2l0aW1lcihpbnQgd2hpY2gpCiAKIAllcnIgPSBnZXR0aW1lb2ZkYXko
JnN0YXJ0LCBOVUxMKTsKIAlpZiAoZXJyIDwgMCkgewotCQlwZXJyb3IoIkNhbid0IGNhbGwg
Z2V0dGltZW9mZGF5KClcbiIpOworCQlrc2Z0X3BlcnJvcigiQ2FuJ3QgY2FsbCBnZXR0aW1l
b2ZkYXkoKSIpOwogCQlyZXR1cm4gLTE7CiAJfQogCiAJZXJyID0gc2V0aXRpbWVyKHdoaWNo
LCAmdmFsLCBOVUxMKTsKIAlpZiAoZXJyIDwgMCkgewotCQlwZXJyb3IoIkNhbid0IHNldCB0
aW1lclxuIik7CisJCWtzZnRfcGVycm9yKCJDYW4ndCBzZXQgdGltZXIiKTsKIAkJcmV0dXJu
IC0xOwogCX0KIApAQCAtMTIzLDIwICsxMjIsMTggQEAgc3RhdGljIGludCBjaGVja19pdGlt
ZXIoaW50IHdoaWNoKQogCiAJZXJyID0gZ2V0dGltZW9mZGF5KCZlbmQsIE5VTEwpOwogCWlm
IChlcnIgPCAwKSB7Ci0JCXBlcnJvcigiQ2FuJ3QgY2FsbCBnZXR0aW1lb2ZkYXkoKVxuIik7
CisJCWtzZnRfcGVycm9yKCJDYW4ndCBjYWxsIGdldHRpbWVvZmRheSgpIik7CiAJCXJldHVy
biAtMTsKIAl9CiAKLQlpZiAoIWNoZWNrX2RpZmYoc3RhcnQsIGVuZCkpCi0JCXByaW50Zigi
W09LXVxuIik7Ci0JZWxzZQotCQlwcmludGYoIltGQUlMXVxuIik7CisJa3NmdF90ZXN0X3Jl
c3VsdChjaGVja19kaWZmKHN0YXJ0LCBlbmQpID09IDAsICIlc1xuIiwgbmFtZSk7CiAKIAly
ZXR1cm4gMDsKIH0KIAogc3RhdGljIGludCBjaGVja190aW1lcl9jcmVhdGUoaW50IHdoaWNo
KQogeworCWNvbnN0IGNoYXIgKnR5cGU7CiAJaW50IGVycjsKIAl0aW1lcl90IGlkOwogCXN0
cnVjdCB0aW1ldmFsIHN0YXJ0LCBlbmQ7CkBAIC0xNDQsMzEgKzE0MSwzMiBAQCBzdGF0aWMg
aW50IGNoZWNrX3RpbWVyX2NyZWF0ZShpbnQgd2hpY2gpCiAJCS5pdF92YWx1ZS50dl9zZWMg
PSBERUxBWSwKIAl9OwogCi0JcHJpbnRmKCJDaGVjayB0aW1lcl9jcmVhdGUoKSAiKTsKIAlp
ZiAod2hpY2ggPT0gQ0xPQ0tfVEhSRUFEX0NQVVRJTUVfSUQpIHsKLQkJcHJpbnRmKCJwZXIg
dGhyZWFkLi4uICIpOworCQl0eXBlID0gInRocmVhZCI7CiAJfSBlbHNlIGlmICh3aGljaCA9
PSBDTE9DS19QUk9DRVNTX0NQVVRJTUVfSUQpIHsKLQkJcHJpbnRmKCJwZXIgcHJvY2Vzcy4u
LiAiKTsKKwkJdHlwZSA9ICJwcm9jZXNzIjsKKwl9IGVsc2UgeworCQlrc2Z0X3ByaW50X21z
ZygiVW5rbm93biB0aW1lcl9jcmVhdGUoKSB0eXBlICVkXG4iLCB3aGljaCk7CisJCXJldHVy
biAtMTsKIAl9Ci0JZmZsdXNoKHN0ZG91dCk7CiAKIAlkb25lID0gMDsKIAllcnIgPSB0aW1l
cl9jcmVhdGUod2hpY2gsIE5VTEwsICZpZCk7CiAJaWYgKGVyciA8IDApIHsKLQkJcGVycm9y
KCJDYW4ndCBjcmVhdGUgdGltZXJcbiIpOworCQlrc2Z0X3BlcnJvcigiQ2FuJ3QgY3JlYXRl
IHRpbWVyIik7CiAJCXJldHVybiAtMTsKIAl9CiAJc2lnbmFsKFNJR0FMUk0sIHNpZ19oYW5k
bGVyKTsKIAogCWVyciA9IGdldHRpbWVvZmRheSgmc3RhcnQsIE5VTEwpOwogCWlmIChlcnIg
PCAwKSB7Ci0JCXBlcnJvcigiQ2FuJ3QgY2FsbCBnZXR0aW1lb2ZkYXkoKVxuIik7CisJCWtz
ZnRfcGVycm9yKCJDYW4ndCBjYWxsIGdldHRpbWVvZmRheSgpIik7CiAJCXJldHVybiAtMTsK
IAl9CiAKIAllcnIgPSB0aW1lcl9zZXR0aW1lKGlkLCAwLCAmdmFsLCBOVUxMKTsKIAlpZiAo
ZXJyIDwgMCkgewotCQlwZXJyb3IoIkNhbid0IHNldCB0aW1lclxuIik7CisJCWtzZnRfcGVy
cm9yKCJDYW4ndCBzZXQgdGltZXIiKTsKIAkJcmV0dXJuIC0xOwogCX0KIApAQCAtMTc2LDE0
ICsxNzQsMTIgQEAgc3RhdGljIGludCBjaGVja190aW1lcl9jcmVhdGUoaW50IHdoaWNoKQog
CiAJZXJyID0gZ2V0dGltZW9mZGF5KCZlbmQsIE5VTEwpOwogCWlmIChlcnIgPCAwKSB7Ci0J
CXBlcnJvcigiQ2FuJ3QgY2FsbCBnZXR0aW1lb2ZkYXkoKVxuIik7CisJCWtzZnRfcGVycm9y
KCJDYW4ndCBjYWxsIGdldHRpbWVvZmRheSgpIik7CiAJCXJldHVybiAtMTsKIAl9CiAKLQlp
ZiAoIWNoZWNrX2RpZmYoc3RhcnQsIGVuZCkpCi0JCXByaW50ZigiW09LXVxuIik7Ci0JZWxz
ZQotCQlwcmludGYoIltGQUlMXVxuIik7CisJa3NmdF90ZXN0X3Jlc3VsdChjaGVja19kaWZm
KHN0YXJ0LCBlbmQpID09IDAsCisJCQkgInRpbWVyX2NyZWF0ZSgpIHBlciAlc1xuIiwgdHlw
ZSk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTIyMCwyNSArMjE2LDI1IEBAIHN0YXRpYyBpbnQg
Y2hlY2tfdGltZXJfZGlzdHJpYnV0aW9uKHZvaWQpCiAJCS5pdF9pbnRlcnZhbC50dl9uc2Vj
ID0gMTAwMCAqIDEwMDAsCiAJfTsKIAotCXByaW50ZigiQ2hlY2sgdGltZXJfY3JlYXRlKCkg
cGVyIHByb2Nlc3Mgc2lnbmFsIGRpc3RyaWJ1dGlvbi4uLiAiKTsKLQlmZmx1c2goc3Rkb3V0
KTsKLQogCXJlbWFpbiA9IG50aHJlYWRzICsgMTsgIC8qIHdvcmtlciB0aHJlYWRzICsgdGhp
cyB0aHJlYWQgKi8KIAlzaWduYWwoU0lHQUxSTSwgZGlzdHJpYnV0aW9uX2hhbmRsZXIpOwog
CWVyciA9IHRpbWVyX2NyZWF0ZShDTE9DS19QUk9DRVNTX0NQVVRJTUVfSUQsIE5VTEwsICZp
ZCk7CiAJaWYgKGVyciA8IDApIHsKLQkJcGVycm9yKCJDYW4ndCBjcmVhdGUgdGltZXJcbiIp
OworCQlrc2Z0X3BlcnJvcigiQ2FuJ3QgY3JlYXRlIHRpbWVyIik7CiAJCXJldHVybiAtMTsK
IAl9CiAJZXJyID0gdGltZXJfc2V0dGltZShpZCwgMCwgJnZhbCwgTlVMTCk7CiAJaWYgKGVy
ciA8IDApIHsKLQkJcGVycm9yKCJDYW4ndCBzZXQgdGltZXJcbiIpOworCQlrc2Z0X3BlcnJv
cigiQ2FuJ3Qgc2V0IHRpbWVyIik7CiAJCXJldHVybiAtMTsKIAl9CiAKIAlmb3IgKGkgPSAw
OyBpIDwgbnRocmVhZHM7IGkrKykgewotCQlpZiAocHRocmVhZF9jcmVhdGUoJnRocmVhZHNb
aV0sIE5VTEwsIGRpc3RyaWJ1dGlvbl90aHJlYWQsIE5VTEwpKSB7Ci0JCQlwZXJyb3IoIkNh
bid0IGNyZWF0ZSB0aHJlYWRcbiIpOworCQllcnIgPSBwdGhyZWFkX2NyZWF0ZSgmdGhyZWFk
c1tpXSwgTlVMTCwgZGlzdHJpYnV0aW9uX3RocmVhZCwKKwkJCQkgICAgIE5VTEwpOworCQlp
ZiAoZXJyKSB7CisJCQlrc2Z0X3ByaW50X21zZygiQ2FuJ3QgY3JlYXRlIHRocmVhZDogJXMg
KCVkKVxuIiwKKwkJCQkgICAgICAgc3RyZXJyb3IoZXJybm8pLCBlcnJubyk7CiAJCQlyZXR1
cm4gLTE7CiAJCX0KIAl9CkBAIC0yNDcsMjUgKzI0MywzMCBAQCBzdGF0aWMgaW50IGNoZWNr
X3RpbWVyX2Rpc3RyaWJ1dGlvbih2b2lkKQogCXdoaWxlIChfX2F0b21pY19sb2FkX24oJnJl
bWFpbiwgX19BVE9NSUNfUkVMQVhFRCkpOwogCiAJZm9yIChpID0gMDsgaSA8IG50aHJlYWRz
OyBpKyspIHsKLQkJaWYgKHB0aHJlYWRfam9pbih0aHJlYWRzW2ldLCBOVUxMKSkgewotCQkJ
cGVycm9yKCJDYW4ndCBqb2luIHRocmVhZFxuIik7CisJCWVyciA9IHB0aHJlYWRfam9pbih0
aHJlYWRzW2ldLCBOVUxMKTsKKwkJaWYgKGVycikgeworCQkJa3NmdF9wcmludF9tc2coIkNh
bid0IGpvaW4gdGhyZWFkOiAlcyAoJWQpXG4iLAorCQkJCSAgICAgICBzdHJlcnJvcihlcnJu
byksIGVycm5vKTsKIAkJCXJldHVybiAtMTsKIAkJfQogCX0KIAogCWlmICh0aW1lcl9kZWxl
dGUoaWQpKSB7Ci0JCXBlcnJvcigiQ2FuJ3QgZGVsZXRlIHRpbWVyXG4iKTsKKwkJa3NmdF9w
ZXJyb3IoIkNhbid0IGRlbGV0ZSB0aW1lciIpOwogCQlyZXR1cm4gLTE7CiAJfQogCi0JcHJp
bnRmKCJbT0tdXG4iKTsKKwlrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoImNoZWNrX3RpbWVyX2Rp
c3RyaWJ1dGlvblxuIik7CiAJcmV0dXJuIDA7CiB9CiAKIGludCBtYWluKGludCBhcmdjLCBj
aGFyICoqYXJndikKIHsKLQlwcmludGYoIlRlc3RpbmcgcG9zaXggdGltZXJzLiBGYWxzZSBu
ZWdhdGl2ZSBtYXkgaGFwcGVuIG9uIENQVSBleGVjdXRpb24gXG4iKTsKLQlwcmludGYoImJh
c2VkIHRpbWVycyBpZiBvdGhlciB0aHJlYWRzIHJ1biBvbiB0aGUgQ1BVLi4uXG4iKTsKKwlr
c2Z0X3ByaW50X2hlYWRlcigpOworCWtzZnRfc2V0X3BsYW4oNik7CisKKwlrc2Z0X3ByaW50
X21zZygiVGVzdGluZyBwb3NpeCB0aW1lcnMuIEZhbHNlIG5lZ2F0aXZlIG1heSBoYXBwZW4g
b24gQ1BVIGV4ZWN1dGlvbiBcbiIpOworCWtzZnRfcHJpbnRfbXNnKCJiYXNlZCB0aW1lcnMg
aWYgb3RoZXIgdGhyZWFkcyBydW4gb24gdGhlIENQVS4uLlxuIik7CiAKIAlpZiAoY2hlY2tf
aXRpbWVyKElUSU1FUl9WSVJUVUFMKSA8IDApCiAJCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgp
OwpAQCAtMjk0LDUgKzI5NSw1IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
IAlpZiAoY2hlY2tfdGltZXJfZGlzdHJpYnV0aW9uKCkgPCAwKQogCQlyZXR1cm4ga3NmdF9l
eGl0X2ZhaWwoKTsKIAotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOworCWtzZnRfZmluaXNo
ZWQoKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VldmVudC91
ZXZlbnRfZmlsdGVyaW5nLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91ZXZlbnQvdWV2
ZW50X2ZpbHRlcmluZy5jCmluZGV4IDVjZWJmYjM1NjM0NS4uZGJlNTVmM2E2NmY0IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91ZXZlbnQvdWV2ZW50X2ZpbHRlcmlu
Zy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VldmVudC91ZXZlbnRfZmlsdGVy
aW5nLmMKQEAgLTc4LDcgKzc4LDcgQEAgc3RhdGljIGludCB1ZXZlbnRfbGlzdGVuZXIodW5z
aWduZWQgbG9uZyBwb3N0X2ZsYWdzLCBib29sIGV4cGVjdF91ZXZlbnQsCiB7CiAJaW50IHNr
X2ZkLCByZXQ7CiAJc29ja2xlbl90IHNrX2FkZHJfbGVuOwotCWludCBmcmV0ID0gLTEsIHJj
dl9idWZfc3ogPSBfX1VFVkVOVF9CVUZGRVJfU0laRTsKKwlpbnQgcmN2X2J1Zl9zeiA9IF9f
VUVWRU5UX0JVRkZFUl9TSVpFOwogCXVpbnQ2NF90IHN5bmNfYWRkID0gMTsKIAlzdHJ1Y3Qg
c29ja2FkZHJfbmwgc2tfYWRkciA9IHsgMCB9LCByY3ZfYWRkciA9IHsgMCB9OwogCWNoYXIg
YnVmW19fVUVWRU5UX0JVRkZFUl9TSVpFXSA9IHsgMCB9OwpAQCAtMTIxLDYgKzEyMSw3IEBA
IHN0YXRpYyBpbnQgdWV2ZW50X2xpc3RlbmVyKHVuc2lnbmVkIGxvbmcgcG9zdF9mbGFncywg
Ym9vbCBleHBlY3RfdWV2ZW50LAogCiAJaWYgKChzaXplX3Qpc2tfYWRkcl9sZW4gIT0gc2l6
ZW9mKHNrX2FkZHIpKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiSW52YWxpZCBzb2NrZXQgYWRk
cmVzcyBzaXplXG4iKTsKKwkJcmV0ID0gLTE7CiAJCWdvdG8gb25fZXJyb3I7CiAJfQogCkBA
IC0xNDcsMTEgKzE0OCwxMiBAQCBzdGF0aWMgaW50IHVldmVudF9saXN0ZW5lcih1bnNpZ25l
ZCBsb25nIHBvc3RfZmxhZ3MsIGJvb2wgZXhwZWN0X3VldmVudCwKIAlyZXQgPSB3cml0ZV9u
b2ludHIoc3luY19mZCwgJnN5bmNfYWRkLCBzaXplb2Yoc3luY19hZGQpKTsKIAljbG9zZShz
eW5jX2ZkKTsKIAlpZiAocmV0ICE9IHNpemVvZihzeW5jX2FkZCkpIHsKKwkJcmV0ID0gLTE7
CiAJCWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHN5bmNocm9uaXplIHdpdGggcGFyZW50
IHByb2Nlc3NcbiIpOwogCQlnb3RvIG9uX2Vycm9yOwogCX0KIAotCWZyZXQgPSAwOworCXJl
dCA9IDA7CiAJZm9yICg7OykgewogCQlzc2l6ZV90IHI7CiAKQEAgLTE4Nyw3ICsxODksNyBA
QCBzdGF0aWMgaW50IHVldmVudF9saXN0ZW5lcih1bnNpZ25lZCBsb25nIHBvc3RfZmxhZ3Ms
IGJvb2wgZXhwZWN0X3VldmVudCwKIG9uX2Vycm9yOgogCWNsb3NlKHNrX2ZkKTsKIAotCXJl
dHVybiBmcmV0OworCXJldHVybiByZXQ7CiB9CiAKIGludCB0cmlnZ2VyX3VldmVudCh1bnNp
Z25lZCBpbnQgdGltZXMpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91
c2VyX2V2ZW50cy8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9l
dmVudHMvLmdpdGlnbm9yZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAw
MDAuLmY1NzBmZWJkMjExYgotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3VzZXJfZXZlbnRzLy5naXRpZ25vcmUKQEAgLTAsMCArMSw0IEBACithYmlfdGVz
dAorZHluX3Rlc3QKK2Z0cmFjZV90ZXN0CitwZXJmX3Rlc3QK

--------------pgoIIQXok7NiCOCxYvBxRLbq--
