Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D451378B12F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjH1M6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjH1M6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:58:11 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12F11A;
        Mon, 28 Aug 2023 05:58:08 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-573128cd77dso538905eaf.0;
        Mon, 28 Aug 2023 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693227488; x=1693832288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcC0NwRtz8BRXXrALTbmTwDgHHxjiLSWqbQlSzdPqCI=;
        b=P+J/zFlYxALRku/lmaVBc37/J8hasS/t/kfptHcYUpd1M3USP/IRLUhKVC21CJjhDw
         fP0ZgyX7aKonQLPuXX2o5JujDi7V7tKaZFUYXNfNjDbYW9zXF5jv1AUgMbrL7WY71Fd0
         2tllznmhQfhvcOxFpRYdtKKUaMbJyveok/r/TNiE/3fzt1dCN3HaPuCwzTR3XpOpUE7E
         L1QGa8BDm3vyeZzNYHKnMHPu2a7gbBH+CcdZ/etIMjJBu5UjCWmzMCM/DqkP27Ehmcm2
         Y+RAIXSJ6E2EnQpw4UxPFsa7jw5DxEQw9JvrXw+KAT6FQk0UtkkIMepss59fKL7Cu65y
         cWPQ==
X-Gm-Message-State: AOJu0YwWjdPZtoEzerKRMaA8QKURNHhmmdy1wrcV5LQoqCJY/w1JwxIk
        BVe8MjKy43NpuRgyu2wXg5G/deaaKCYLCyfmrMk6rKyM+Jk=
X-Google-Smtp-Source: AGHT+IHOTjYU+8aWo7ejeABgwwVL58psYEkU8H+PUodCCG8/9ZHjZnk2cLIyVx6aorNUAsVPFlgKhQWMFP57mALY27s=
X-Received: by 2002:a4a:da10:0:b0:56e:6532:467a with SMTP id
 e16-20020a4ada10000000b0056e6532467amr23436697oou.1.1693227487727; Mon, 28
 Aug 2023 05:58:07 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 14:57:53 +0200
Message-ID: <CAJZ5v0jLOQhXnfE2z9OjmYOh=7MPtJ8=OSNSVVAoZ7=brRgqvg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.6-rc1

with top-most commit 422ec6fe2704593c87c14a8ef296d92f6b368c53

 Merge tag 'opp-updates-6.6' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 706a741595047797872e669b3101429ab8d378ef

 Linux 6.5-rc7

to receive power management updates for 6.6-rc1.

These rework cpuidle governors to call tick_nohz_get_sleep_length() less
often and fix one of them, rework hibernation to avoid storing pages
filled with zeros in hibernation images, switch over some cpufreq
drivers to use void remove callbacks, fix and clean up multiple
cpufreq drivers, fix the devfreq core, update the cpupower utility and
make other assorted improvements.

Specifics:

 - Rework the menu and teo cpuidle governors to avoid calling
   tick_nohz_get_sleep_length(), which is likely to become quite
   expensive going forward, too often and improve making decisions
   regarding whether or not to stop the scheduler tick in the teo
   governor (Rafael Wysocki).

 - Improve the performance of cpufreq_stats_create_table() in some
   cases (Liao Chang).

 - Fix two issues in the amd-pstate-ut cpufreq driver (Swapnil Sapkal).

 - Use clamp() helper macro to improve the code readability in
   cpufreq_verify_within_limits() (Liao Chang).

 - Set stale CPU frequency to minimum in intel_pstate (Doug Smythies).

 - Migrate cpufreq drivers for various platforms to use void remove
   callback (Yangtao Li).

 - Add online/offline/exit hooks for Tegra driver (Sumit Gupta).

 - Explicitly include correct DT includes in cpufreq (Rob Herring).

 - Frequency domain updates for qcom-hw driver (Neil Armstrong).

 - Modify AMD pstate driver to return the highest_perf value (Meng Li).

 - Generic cleanups for cppc, mediatek and powernow driver (Liao Chang,
   Konrad Dybcio).

 - Add more platforms to cpufreq-arm driver's blocklist (AngeloGioacchino
   Del Regno and Konrad Dybcio).

 - brcmstb-avs-cpufreq: Fix -Warray-bounds bug (Gustavo A. R. Silva).

 - Add device PM helpers to allow a device to remain powered-on during
   system-wide transitions (Ulf Hansson).

 - Rework hibernation memory snapshotting to avoid storing pages filled
   with zeros in hibernation image files (Brian Geffon).

 - Add check to make sure that CPU latency QoS constraints do not use
   negative values (Clive Lin).

 - Optimize rp->domains memory allocation in the Intel RAPL power
   capping driver (xiongxin).

 - Remove recursion while parsing zones in the arm_scmi power capping
   driver (Cristian Marussi).

 - Fix memory leak in devfreq_dev_release() (Boris Brezillon).

 - Rewrite devfreq_monitor_start() kerneldoc comment (Manivannan
   Sadhasivam).

 - Explicitly include correct DT includes in devfreq (Rob Herring).

 - Remove unused pm_runtime_update_max_time_suspended() extern
   declaration (YueHaibing).

 - Add turbo-boost support to cpupower (Wyes Karny).

 - Add support for amd_pstate mode change to cpupower (Wyes Karny).

 - Fix 'cpupower idle_set' command to accept only numeric values of
   arguments (Likhitha Korrapati).

 - Clean up OPP code and add new frequency related APIs to it (Viresh
   Kumar, Manivannan Sadhasivam).

 - Convert ti cpufreq/opp bindings to json schema (Nishanth Menon).

Thanks!


---------------

AngeloGioacchino Del Regno (1):
      cpufreq: blocklist MSM8998 in cpufreq-dt-platdev

Ben Hutchings (1):
      cpupower: Bump soname version

Boris Brezillon (1):
      PM / devfreq: Fix leak in devfreq_dev_release()

Brian Geffon (1):
      PM: hibernate: don't store zero pages in the image file

Clive Lin (1):
      PM: QoS: Add check to make sure CPU latency is non-negative

Cristian Marussi (1):
      powercap: arm_scmi: Remove recursion while parsing zones

Doug Smythies (1):
      cpufreq: intel_pstate: set stale CPU frequency to minimum

Gustavo A. R. Silva (1):
      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Konrad Dybcio (2):
      cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev
      cpufreq: mediatek-hw: Remove unused define

Liao Chang (6):
      cpufreq: Prefer to print cpuid in MIN/MAX QoS register error message
      cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.
      cpufreq: cppc: Set fie_disabled to FIE_DISABLED if fails to
create kworker_fie
      cpufreq: stats: Improve the performance of cpufreq_stats_create_table()
      cpufreq: Use clamp() helper macro to improve the code readability
      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()

Likhitha Korrapati (1):
      cpupower: Fix cpuidle_set to accept only numeric values for
idle-set operation.

Manivannan Sadhasivam (6):
      OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
      PM / devfreq: Reword the kernel-doc comment for
devfreq_monitor_start() API
      OPP: Introduce dev_pm_opp_get_freq_indexed() API
      OPP: Fix potential null ptr dereference in
dev_pm_opp_get_required_pstate()
      OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
      dt-bindings: opp: Increase maxItems for opp-hz property

Meng Li (1):
      cpufreq: amd-pstate-ut: Modify the function to get the highest_perf value

Neil Armstrong (2):
      dt-bindings: cpufreq: qcom-hw: add a 4th frequency domain
      cpufreq: qcom-cpufreq-hw: add support for 4 freq domains

Nishanth Menon (2):
      dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
      dt-bindings: cpufreq: Convert ti-cpufreq to json schema

Rafael J. Wysocki (8):
      cpuidle: teo: Update idle duration estimate when choosing shallower state
      cpuidle: teo: Avoid stopping the tick unnecessarily when bailing out
      cpuidle: teo: Drop utilized from struct teo_cpu
      cpuidle: teo: Do not call tick_nohz_get_sleep_length() upfront
      cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases
      cpuidle: teo: Gather statistics regarding whether or not to stop the tick
      cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases
      cpuidle: teo: Avoid unnecessary variable assignments

Rob Herring (2):
      cpufreq: Explicitly include correct DT includes
      PM / devfreq: Explicitly include correct DT includes

Sumit Gupta (2):
      cpufreq: tegra194: add online/offline hooks
      cpufreq: tegra194: remove opp table in exit hook

Swapnil Sapkal (2):
      cpufreq: amd-pstate-ut: Remove module parameter access
      cpufreq: amd-pstate-ut: Fix kernel panic when loading the driver

Ulf Hansson (1):
      PM: sleep: Add helpers to allow a device to remain powered-on

Viresh Kumar (5):
      OPP: Rearrange entries in pm_opp.h
      OPP: Add dev_pm_opp_find_freq_exact_indexed()
      OPP: Update _read_freq() to return the correct frequency
      OPP: Reuse dev_pm_opp_get_freq_indexed()
      OPP: Fix argument name in doc comment

Wyes Karny (5):
      cpupower: Recognise amd-pstate active mode driver
      cpupower: Add is_valid_path API
      cpupower: Add EPP value change support
      cpupower: Add support for amd_pstate mode change
      cpupower: Add turbo-boost support in cpupower

Yangtao Li (19):
      cpufreq: sun50i: Convert to platform remove callback returning void
      cpufreq: dt: Convert to platform remove callback returning void
      cpufreq: qcom-cpufreq-hw: Convert to platform remove callback
returning void
      cpufreq: vexpress: Convert to platform remove callback returning void
      cpufreq: imx6q: Convert to platform remove callback returning void
      cpufreq: mediatek-hw: Convert to platform remove callback returning void
      cpufreq: scpi: Convert to platform remove callback returning void
      cpufreq: tegra194: Convert to platform remove callback returning void
      cpufreq: brcmstb-avs-cpufreq: Convert to platform remove
callback returning void
      cpufreq: imx-cpufreq-dt: Convert to platform remove callback
returning void
      cpufreq: davinci: Convert to platform remove callback returning void
      cpufreq: raspberrypi: Convert to platform remove callback returning void
      cpufreq: pcc-cpufreq: Convert to platform remove callback returning void
      cpufreq: kirkwood: Convert to platform remove callback returning void
      cpufreq: qcom-nvmem: Convert to platform remove callback returning void
      cpufreq: tegra186: Convert to platform remove callback returning void
      cpufreq: acpi: Convert to platform remove callback returning void
      cpufreq: qoriq: Convert to platform remove callback returning void
      cpufreq: omap: Convert to platform remove callback returning void

YueHaibing (1):
      PM: runtime: Remove unsued extern declaration of
pm_runtime_update_max_time_suspended()

xiongxin (1):
      powercap: intel_rapl: Optimize rp->domains memory allocation

---------------

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   5 +-
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 132 ------------
 .../bindings/opp/operating-points-v2-ti-cpu.yaml   |  92 ++++++++
 .../devicetree/bindings/opp/opp-v2-base.yaml       |   2 +-
 .../bindings/opp/ti,omap-opp-supply.yaml           | 101 +++++++++
 .../bindings/opp/ti-omap5-opp-supply.txt           |  63 ------
 drivers/cpufreq/acpi-cpufreq.c                     |   6 +-
 drivers/cpufreq/amd-pstate-ut.c                    |  50 ++---
 drivers/cpufreq/armada-37xx-cpufreq.c              |   4 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |  12 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  13 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   7 +
 drivers/cpufreq/cpufreq-dt.c                       |   5 +-
 drivers/cpufreq/cpufreq.c                          |   8 +-
 drivers/cpufreq/cpufreq_stats.c                    |   3 +-
 drivers/cpufreq/davinci-cpufreq.c                  |   6 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   6 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   6 +-
 drivers/cpufreq/intel_pstate.c                     |   5 +
 drivers/cpufreq/kirkwood-cpufreq.c                 |   6 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   9 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   2 -
 drivers/cpufreq/omap-cpufreq.c                     |   6 +-
 drivers/cpufreq/pcc-cpufreq.c                      |   6 +-
 drivers/cpufreq/powernow-k8.c                      |   3 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |   2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c              |   1 -
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   8 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   7 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   6 +-
 drivers/cpufreq/raspberrypi-cpufreq.c              |   6 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   7 +-
 drivers/cpufreq/sti-cpufreq.c                      |   2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   6 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |   6 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |  35 ++-
 drivers/cpufreq/ti-cpufreq.c                       |   2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c             |   6 +-
 drivers/cpuidle/governors/gov.h                    |  14 ++
 drivers/cpuidle/governors/menu.c                   |  65 +++---
 drivers/cpuidle/governors/teo.c                    | 235 +++++++++++++--------
 drivers/devfreq/devfreq.c                          |  10 +-
 drivers/devfreq/imx-bus.c                          |   2 +-
 drivers/devfreq/imx8m-ddrc.c                       |   2 +-
 drivers/devfreq/mtk-cci-devfreq.c                  |   1 -
 drivers/devfreq/tegra30-devfreq.c                  |   2 +-
 drivers/opp/core.c                                 | 117 ++++++++--
 drivers/opp/cpu.c                                  |   4 +-
 drivers/powercap/arm_scmi_powercap.c               | 159 ++++++++------
 drivers/powercap/intel_rapl_common.c               |   2 +-
 include/linux/cpufreq.h                            |  16 +-
 include/linux/pm_opp.h                             |  62 ++++--
 include/linux/pm_runtime.h                         |   2 -
 include/linux/pm_wakeup.h                          |  10 +
 kernel/power/qos.c                                 |   9 +-
 kernel/power/snapshot.c                            | 187 ++++++++++++----
 tools/power/cpupower/Makefile                      |   2 +-
 tools/power/cpupower/lib/cpupower.c                |   7 +
 tools/power/cpupower/lib/cpupower_intern.h         |   1 +
 tools/power/cpupower/utils/cpuidle-set.c           |  16 +-
 tools/power/cpupower/utils/cpupower-set.c          |  65 +++++-
 tools/power/cpupower/utils/helpers/helpers.h       |  11 +
 tools/power/cpupower/utils/helpers/misc.c          |  57 ++++-
 63 files changed, 1097 insertions(+), 613 deletions(-)
