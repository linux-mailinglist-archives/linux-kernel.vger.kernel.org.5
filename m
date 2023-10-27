Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D072D7D9A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbjJ0Nww convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbjJ0Nwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:52:51 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD29D;
        Fri, 27 Oct 2023 06:52:48 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5841a3ffd50so320920eaf.1;
        Fri, 27 Oct 2023 06:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414768; x=1699019568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOw2sHayZQAv0zp3D5aF67SnlMqlF8Mky8ykAXabTqs=;
        b=EYKhc+yJpABlTqLVU0s8kIVt453mR1YG/GD5eWVQW86LQwXs70fbhYk2z2KRq/yJf8
         qzPJMg6Gb8XgQ70hqTQwjReHQp1MLPosKsU7AWg4T8gsYzNAVI8Xlc0gv9KANyLwNqwv
         ReRRBZErdWV8GbbqHHm86wDFRA5xM+GNt1lXF+EH8Zl6u1mykQEoKqjrZkPxeLrf8LEQ
         Dbr8qn2zXtlZtSCcCfSl1YWB4UKuSX024RgfzchgGvXIj01VXbRimLbOZK0qtX7l19La
         XoFpLXbmiz+aRd4suvd/Heq5QfRDGLiPDAhn3KvZ7Bk1NzAw71d6CJ3Q2bAedF5wWbxK
         jdSg==
X-Gm-Message-State: AOJu0YxIkW7Yh0JuGfbC1eN+x/qCbGghRSV6p0+JNfFWqyJOPSEjFc/4
        Hk/Od21NSx6YfvRcmCKUi/+5M3kqB7t3THoz/aqmbqRg8ps=
X-Google-Smtp-Source: AGHT+IHtYELVF/nW6gH9FBDjgFigolRsF5S7KQzG8DztatDv97DOyoyzEBwCyLeIrcdl/Q6IV3qt5vpiBSHDJs2/pf0=
X-Received: by 2002:a4a:d68a:0:b0:584:1080:f0a5 with SMTP id
 i10-20020a4ad68a000000b005841080f0a5mr3001266oot.1.1698414767634; Fri, 27 Oct
 2023 06:52:47 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Oct 2023 15:52:36 +0200
Message-ID: <CAJZ5v0iBWcy2LyeXE0vxqKZOWBK5yWgofktygEvo4B3=6J8Wjg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
 pm-6.7-rc1

with top-most commit bf224871c27a7c7e2146d667176977ffe3752750

 Merge branches 'pm-sleep', 'powercap' and 'pm-tools'

on top of commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1

 Linux 6.6-rc7

to receive power management updates for 6.7-rc1.

These add new hardware support (new Qualcomm SoC versions in cpufreq,
RK3568/RK3588 in devfreq), extend the OPP (operating performance points)
framework, improve cpufreq governors, fix issues and clean up code (most
of the changes are in cpufreq and devfreq).

Specifics:

 - Add support for several Qualcomm SoC versions and other similar
   changes (Christian Marangi, Dmitry Baryshkov, Luca Weiss, Neil
   Armstrong, Richard Acayan, Robert Marko, Rohit Agarwal, Stephan
   Gerhold and Varadarajan Narayanan).

 - Clean up the tegra cpufreq driver (Sumit Gupta).

 - Use of_property_read_reg() to parse "reg" in pmac32 driver (Rob
   Herring).

 - Add support for TI's am62p5 Soc (Bryan Brattlof).

 - Make ARM_BRCMSTB_AVS_CPUFREQ depends on !ARM_SCMI_CPUFREQ (Florian
   Fainelli).

 - Update Kconfig to mention i.MX7 as well (Alexander Stein).

 - Revise global turbo disable check in intel_pstate (Srinivas
   Pandruvada).

 - Carry out initialization of sg_cpu in the schedutil cpufreq governor
   in one loop (Liao Chang).

 - Simplify the condition for storing 'down_threshold' in the
   conservative cpufreq governor (Liao Chang).

 - Use fine-grained mutex in the userspace cpufreq governor (Liao
   Chang).

 - Move is_managed indicator in the userspace cpufreq governor into a
   per-policy structure (Liao Chang).

 - Rebuild sched-domains when removing cpufreq driver (Pierre Gondois).

 - Fix buffer overflow detection in trans_stats() (Christian Marangi).

 - Switch to dev_pm_opp_find_freq_(ceil/floor)_indexed() APIs to support
   specific devices like UFS which handle multiple clocks through OPP
   (Operating Performance Point) framework (Manivannan Sadhasivam).

 - Add perf support to the Rockchip DFI (DDR Monitor Module) devfreq-
   event driver:
   * Generalize rockchip-dfi.c to support new RK3568/RK3588 using
     different DDR type (Sascha Hauer).
   * Convert DT binding document format to yaml (Sascha Hauer).
   * Add perf support for DFI (a unit suitable for measuring DDR
     utilization) to rockchip-dfi.c to extend DFI usage (Sascha Hauer).

 - Add locking to the OPP handling code in the Mediatek CCI devfreq
   driver, because the voltage of shared OPP might be changed by
   multiple drivers (Mark Tseng, Dan Carpenter).

 - Use device_get_match_data() in the Samsung Exynos PPMU devfreq-event
   driver (Rob Herring).

 - Extend support for the opp-level beyond required-opps (Ulf Hansson).

 - Add dev_pm_opp_find_level_floor() (Krishna chaitanya chundru).

 - dt-bindings: Allow opp-peak-kBpsfor kryo CPUs, support Qualcomm Krait
   SoCs and document named opp-microvolt property (Bjorn Andersson,
   Dmitry Baryshkov and Christian Marangi).

 - Fix -Wunsequenced warning _of_add_opp_table_v1() (Nathan Chancellor).

 - General cleanup of OPP code (Viresh Kumar).

 - Use __get_safe_page() rather than touching the list in hibernation
   snapshot code (Brian Geffon).

 - Fix symbol export for _SIMPLE_ variants of _PM_OPS() (Raag Jadav).

 - Clean up sync_read handling in snapshot_write_next() (Brian Geffon).

 - Fix kerneldoc comments for swsusp_check() and swsusp_close() to
   better match code (Christoph Hellwig).

 - Downgrade BIOS locked limits pr_warn() in the Intel RAPL power
   capping driver to pr_debug() (Ville Syrjälä).

 - Change the minimum python version for the intel_pstate_tracer utility
   from 2.7 to 3.6 (Doug Smythies).

Thanks!


---------------

Alexander Stein (1):
      cpufreq: arm: Kconfig: Add i.MX7 to supported SoC for ARM_IMX_CPUFREQ_DT

Bjorn Andersson (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps

Brian Geffon (2):
      PM: hibernate: Use __get_safe_page() rather than touching the list
      PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Bryan Brattlof (2):
      cpufreq: dt-platdev: add am62p5 to blocklist
      cpufreq: ti-cpufreq: Add opp support for am62p5 SoCs

Christian Marangi (4):
      dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property
      cpufreq: stats: Fix buffer overflow detection in trans_stats()
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
      cpufreq: qcom-nvmem: add support for IPQ8064

Christoph Hellwig (1):
      PM: hibernate: fix the kerneldoc comment for swsusp_check() and
swsusp_close()

Dan Carpenter (1):
      PM / devfreq: mediatek: unlock on error in mtk_ccifreq_target()

Dmitry Baryshkov (3):
      dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm Krait SoCs
      cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
      cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu

Doug Smythies (1):
      tools/power/x86/intel_pstate_tracer: python minimum version

Florian Fainelli (1):
      cpufreq: ARM_BRCMSTB_AVS_CPUFREQ cannot be used with ARM_SCMI_CPUFREQ

Krishna chaitanya chundru (1):
      OPP: Add dev_pm_opp_find_level_floor()

Liao Chang (4):
      cpufreq: schedutil: Merge initialization code of sg_cpu in single loop
      cpufreq: conservative: Simplify the condition of storing 'down_threshold'
      cpufreq: userspace: Use fine-grained mutex in userspace governor
      cpufreq: userspace: Move is_managed indicator into per-policy structure

Luca Weiss (1):
      cpufreq: Add QCM6490 to cpufreq-dt-platdev blocklist

Manivannan Sadhasivam (1):
      PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs

Mark Tseng (1):
      PM / devfreq: mediatek: protect oop in critical session

Nathan Chancellor (1):
      OPP: Fix -Wunsequenced in _of_add_opp_table_v1()

Neil Armstrong (1):
      dt-bindings: cpufreq: qcom-hw: document SM8650 CPUFREQ Hardware

Pierre Gondois (1):
      cpufreq: Rebuild sched-domains when removing cpufreq driver

Raag Jadav (1):
      PM: sleep: Fix symbol export for _SIMPLE_ variants of _PM_OPS()

Richard Acayan (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible

Rob Herring (2):
      cpufreq: pmac32: Use of_property_read_reg() to parse "reg"
      PM / devfreq: exynos-ppmu: Use device_get_match_data()

Robert Marko (2):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ6018
      cpufreq: qcom-nvmem: add support for IPQ6018

Rohit Agarwal (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75 compatible

Sascha Hauer (22):
      PM / devfreq: rockchip-dfi: Make pmu regmap mandatory
      PM / devfreq: rockchip-dfi: Embed desc into private data struct
      PM / devfreq: rockchip-dfi: use consistent name for private data struct
      PM / devfreq: rockchip-dfi: Add SoC specific init function
      PM / devfreq: rockchip-dfi: dfi store raw values in counter struct
      PM / devfreq: rockchip-dfi: Use free running counter
      PM / devfreq: rockchip-dfi: introduce channel mask
      PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE defines
      PM / devfreq: rockchip-dfi: Clean up DDR type register defines
      PM / devfreq: rockchip-dfi: Add RK3568 support
      PM / devfreq: rockchip-dfi: Handle LPDDR2 correctly
      PM / devfreq: rockchip-dfi: Handle LPDDR4X
      PM / devfreq: rockchip-dfi: Pass private data struct to internal functions
      PM / devfreq: rockchip-dfi: Prepare for multiple users
      PM / devfreq: rockchip-dfi: give variable a better name
      PM / devfreq: rockchip-dfi: Add perf support
      PM / devfreq: rockchip-dfi: make register stride SoC specific
      PM / devfreq: rockchip-dfi: account for multiple DDRMON_CTRL registers
      PM / devfreq: rockchip-dfi: add support for RK3588
      dt-bindings: devfreq: event: convert Rockchip DFI binding to yaml
      dt-bindings: devfreq: event: rockchip,dfi: Add rk3568 support
      dt-bindings: devfreq: event: rockchip,dfi: Add rk3588 support

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Revise global turbo disable check

Stephan Gerhold (4):
      cpufreq: dt: platdev: Add MSM8909 to blocklist
      dt-bindings: cpufreq: qcom-nvmem: Document MSM8909
      cpufreq: qcom-nvmem: Simplify driver data allocation
      cpufreq: qcom-nvmem: Add MSM8909

Sumit Gupta (4):
      cpufreq: tegra194: fix warning due to missing opp_put
      cpufreq: tegra194: save CPU data to avoid repeated SMP calls
      cpufreq: tegra194: use refclk delta based loop instead of udelay
      cpufreq: tegra194: remove redundant AND with cpu_online_mask

Ulf Hansson (6):
      PM: domains: Introduce dev_pm_domain_set_performance_state()
      PM: domains: Implement the ->set_performance_state() callback for genpd
      OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
      OPP: Extend dev_pm_opp_data with a level
      OPP: Switch to use dev_pm_domain_set_performance_state()
      OPP: Extend support for the opp-level beyond required-opps

Varadarajan Narayanan (2):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ5332
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ9574

Ville Syrjälä (1):
      powercap: intel_rapl: Downgrade BIOS locked limits pr_warn() to pr_debug()

Viresh Kumar (7):
      OPP: Remove doc style comments for internal routines
      OPP: debugfs: Fix warning with W=1 builds
      OPP: Fix formatting of if/else block
      OPP: Add _link_required_opps() to avoid code duplication
      OPP: Reorder code in _opp_set_required_opps_genpd()
      OPP: Remove genpd_virt_dev_lock
      OPP: No need to defer probe from _opp_attach_genpd()

---------------

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   4 +
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |   8 +-
 .../bindings/devfreq/event/rockchip,dfi.yaml       |  74 ++
 .../bindings/devfreq/event/rockchip-dfi.txt        |  18 -
 .../memory-controllers/rockchip,rk3399-dmc.yaml    |   2 +-
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |  36 +-
 drivers/base/power/common.c                        |  21 +
 drivers/base/power/domain.c                        |  33 +-
 drivers/cpufreq/Kconfig.arm                        |   6 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   4 +
 drivers/cpufreq/cpufreq.c                          |   3 +-
 drivers/cpufreq/cpufreq_conservative.c             |   3 +-
 drivers/cpufreq/cpufreq_stats.c                    |  14 +-
 drivers/cpufreq/cpufreq_userspace.c                |  76 +-
 drivers/cpufreq/intel_pstate.c                     |   6 +-
 drivers/cpufreq/pmac32-cpufreq.c                   |   7 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 208 +++++-
 drivers/cpufreq/tegra194-cpufreq.c                 | 153 ++--
 drivers/cpufreq/ti-cpufreq.c                       |   1 +
 drivers/devfreq/devfreq.c                          |  14 +-
 drivers/devfreq/event/exynos-ppmu.c                |  13 +-
 drivers/devfreq/event/rockchip-dfi.c               | 814 ++++++++++++++++++---
 drivers/devfreq/mtk-cci-devfreq.c                  |   9 +-
 drivers/devfreq/rk3399_dmc.c                       |  10 +-
 drivers/opp/core.c                                 | 231 +++---
 drivers/opp/debugfs.c                              |   2 +-
 drivers/opp/of.c                                   |  74 +-
 drivers/opp/opp.h                                  |   4 +-
 drivers/powercap/intel_rapl_common.c               |   2 +-
 include/linux/cpufreq.h                            |   8 -
 include/linux/pm.h                                 |  45 +-
 include/linux/pm_domain.h                          |   6 +
 include/linux/pm_opp.h                             |  40 +-
 include/soc/rockchip/rk3399_grf.h                  |   9 +-
 include/soc/rockchip/rk3568_grf.h                  |  13 +
 include/soc/rockchip/rk3588_grf.h                  |  18 +
 include/soc/rockchip/rockchip_grf.h                |  18 +
 kernel/power/snapshot.c                            |  16 +-
 kernel/power/swap.c                                |   4 +-
 kernel/sched/cpufreq_schedutil.c                   |  66 +-
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  12 +-
 41 files changed, 1540 insertions(+), 565 deletions(-)
