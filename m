Return-Path: <linux-kernel+bounces-99159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0C87844E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A112CB209AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0947F47;
	Mon, 11 Mar 2024 15:58:25 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6744C93;
	Mon, 11 Mar 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172704; cv=none; b=JGQ69wlFoipq6OjyNnYpXEZT1QaB5uFe9ESWVjCVnvV8Tw/jXBOVMjjkXDp4GGvBsFyxhoaU7SHDYOVJ+ZbaOYHfDwOr31LcLUa8xnJkbjkQHNX36O9gZ7aU7ujFA/DdQnppv6En3xWOv/bfkBj7qqc+drRfKkaNWma+tjODO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172704; c=relaxed/simple;
	bh=2nxETOiO9mxiFAV5cLPiFFpDDpXModxmJIUtJ5PoXE8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tjRnQxCyh1rZ+zqIrGfDCAlWNslpAOZaYSoYgf5JrQwBnQcve8kq1nb4pNE/sA0krCJ94ylXOOBMpe3UQUvpJH9BhJ/NzDmVgaXz4YfQ0BKmHTitRGsWJs9BicWCdwYAIkuG5py4O+wSCDwzugda0MFT0BF1Xqqcdsm0IQ5pSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2219edd959dso1191214fac.0;
        Mon, 11 Mar 2024 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172702; x=1710777502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCl9tuP5zMgYd8m9vYg57pcgObtv9nZXqBTvRU8TNLI=;
        b=ZkzAQhrra9H2jygEkUCst9s+nMGLg72EILIVkjUfa/rHhmGYm4tTUCoCIixCeFGMPR
         67wU4YAFSt995qx04fI92p68N2OjC/qw+Ss14J6ml7giwrq61WR82DC9y0SaI9FA/NeR
         hCldabMvPGAt2NdODL9vzGXu1uBQ1jxn9BDI2pMfT6xsMy/LbEd+XVahMl0X0l9hhA2U
         +l720x8bKRzpLkfgd4mIz5HDtMteVBsnVU3AA7bRwT3uT211+lophKpoXexSFsAzadvw
         BFflABX/NY9c06U6HAvrmmgk4CXLaZYWnodm1fbM5LbC+rABD9+1pmIEoG0X6Cb6H2Zf
         1bnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6NEEDiBihe4TAaUh3rfMukw5/xESWpwA5rYgjtIpxujuEc8fhzSiS7RYvWUz6MIYEGi2pAulsi2lfU/3QuU+V7LD8w+Ztuc81JUkWJnp7BO1wKKbYY+ftbJM8SNBOV+o7Dfb33+vp0w==
X-Gm-Message-State: AOJu0YziXNgJFFRyYJMXGkcRGE22HmkL2lG7ngZfKjkgWSJaN82w5LCf
	qxGsaIMmNS2M7QTrZ8QSoHN1oQN8nitJpo35ZXKZBaJZcjV/yli5OVmY5gdsAb+ge7zmhybjDup
	wQi6nLLAps8xo+ypZAnyFkAkaVdAzBfc0hEg=
X-Google-Smtp-Source: AGHT+IHpQqF7ikqGeG/a+DLKp9e4FP/q+UdW3SkLKtCHuR955eapBrgk1VlbpI1/WtFOvirwUdLI3jSYwXMo6ErNVfA=
X-Received: by 2002:a05:6870:d693:b0:221:8fd1:21d9 with SMTP id
 z19-20020a056870d69300b002218fd121d9mr6802913oap.1.1710172701846; Mon, 11 Mar
 2024 08:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Mar 2024 16:58:10 +0100
Message-ID: <CAJZ5v0h_E0zBPFdv37HkG_zom3g=JWoT9YtjtSKO5Dquh4jb7g@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.9-rc1

with top-most commit 866b554c2d3e067751cc2cbad9ed281db2d47143

 Merge tag 'opp-updates-6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm into pm

on top of commit f0a0fc10abb062d122db5ac4ed42f6d1ca342649

 cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call =
back

to receive power management updates for 6.9-rc1.

From the functional perspective, the most significant change here is the
addition of support for Energy Models that can be updated dynamically
at run time.  There is also the addition of LZ4 compression support for
hibernation, the new preferred core support in amd-pstate, new platforms
support in the Intel RAPL driver, new model-specific EPP handling in
intel_pstate and more.

Apart from that, the cpufreq default transition delay is reduced from
10 ms to 2 ms (along with some related adjustments), the system suspend
statistics code undergoes a significant rework and there is a usual
bunch of fixes and code cleanups all over.

Specifics:

 - Allow the Energy Model to be updated dynamically (Lukasz Luba).

 - Add support for LZ4 compression algorithm to the hibernation image
   creation and loading code (Nikhil V).

 - Fix and clean up system suspend statistics collection (Rafael
   Wysocki).

 - Simplify device suspend and resume handling in the power management
   core code (Rafael Wysocki).

 - Fix PCI hibernation support description (Yiwei Lin).

 - Make hibernation take set_memory_ro() return values into account as
   appropriate (Christophe Leroy).

 - Set mem_sleep_current during kernel command line setup to avoid an
   ordering issue with handling it (Maulik Shah).

 - Fix wake IRQs handling when pm_runtime_force_suspend() is used as a
   driver's system suspend callback (Qingliang Li).

 - Simplify pm_runtime_get_if_active() usage and add a replacement for
   pm_runtime_put_autosuspend() (Sakari Ailus).

 - Add a tracepoint for runtime_status changes tracking (Vilas Bhat).

 - Fix section title markdown in the runtime PM documentation (Yiwei
   Lin).

 - Enable preferred core support in the amd-pstate cpufreq driver (Meng
   Li).

 - Fix min_perf assignment in amd_pstate_adjust_perf() and make the
   min/max limit perf values in amd-pstate always stay within the
   (highest perf, lowest perf) range (Tor Vic, Meng Li).

 - Allow intel_pstate to assign model-specific values to strings used in
   the EPP sysfs interface and make it do so on Meteor Lake (Srinivas
   Pandruvada).

 - Drop long-unused cpudata::prev_cummulative_iowait from the
   intel_pstate cpufreq driver (Jiri Slaby).

 - Prevent scaling_cur_freq from exceeding scaling_max_freq when the
   latter is an inefficient frequency (Shivnandan Kumar).

 - Change default transition delay in cpufreq to 2ms (Qais Yousef).

 - Remove references to 10ms minimum sampling rate from comments in the
   cpufreq code (Pierre Gondois).

 - Honour transition_latency over transition_delay_us in cpufreq (Qais
   Yousef).

 - Stop unregistering cpufreq cooling on CPU hot-remove (Viresh Kumar).

 - General enhancements / cleanups to ARM cpufreq drivers (tianyu2,
   N=C3=ADcolas F. R. A. Prado, Erick Archer, Arnd Bergmann, Anastasia
   Belova).

 - Update cpufreq-dt-platdev to block/approve devices (Richard Acayan).

 - Make the SCMI cpufreq driver get a transition delay value from
   firmware (Pierre Gondois).

 - Prevent the haltpoll cpuidle governor from shrinking guest
   poll_limit_ns below grow_start (Parshuram Sangle).

 - Avoid potential overflow in integer multiplication when computing
   cpuidle state parameters (C Cheng).

 - Adjust MWAIT hint target C-state computation in the ACPI cpuidle
   driver and in intel_idle to return a correct value for C0 (He
   Rongguang).

 - Address multiple issues in the TPMI RAPL driver and add support for
   new platforms (Lunar Lake-M, Arrow Lake) to Intel RAPL (Zhang Rui).

 - Fix freq_qos_add_request() return value check in dtpm_cpu (Daniel
   Lezcano).

 - Fix kernel-doc for dtpm_create_hierarchy() (Yang Li).

 - Fix file leak in get_pkg_num() in x86_energy_perf_policy (Samasth
   Norway Ananda).

 - Fix cpupower-frequency-info.1 man page typo (Jan Kratochvil).

 - Fix a couple of warnings in the OPP core code related to W=3D1
   builds (Viresh Kumar).

 - Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h (Viresh
   Kumar).

 - Extend dev_pm_opp_data with turbo support (Sibi Sankar).

 - dt-bindings: drop maxItems from inner items (David Heidelberg).

Thanks!


---------------

Anastasia Belova (1):
      cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return =
value

Arnd Bergmann (1):
      cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency

C Cheng (1):
      cpuidle: Avoid potential overflow in integer multiplication

Christophe Leroy (1):
      PM: hibernate: Don't ignore return from set_memory_ro()

Daniel Lezcano (1):
      powercap: dtpm_cpu: Fix error check against freq_qos_add_request()

David Heidelberg (1):
      dt-bindings: opp: drop maxItems from inner items

Erick Archer (1):
      Documentation: power: Use kcalloc() instead of kzalloc()

He Rongguang (1):
      cpuidle: ACPI/intel: fix MWAIT hint target C-state computation

Jan Kratochvil (1):
      Fix cpupower-frequency-info.1 man page typo

Jiri Slaby (SUSE) (1):
      cpufreq: intel_pstate: remove cpudata::prev_cummulative_iowait

Lukasz Luba (24):
      PM: EM: Add missing newline for the message log
      PM: EM: Extend em_cpufreq_update_efficiencies() argument list
      PM: EM: Find first CPU active while updating OPP efficiency
      PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
      PM: EM: Introduce em_compute_costs()
      PM: EM: Check if the get_cost() callback is present in em_compute_cos=
ts()
      PM: EM: Split the allocation and initialization of the EM table
      PM: EM: Introduce runtime modifiable table
      PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
      PM: EM: Add functions for memory allocations for new EM tables
      PM: EM: Introduce em_dev_update_perf_domain() for EM updates
      PM: EM: Add em_perf_state_from_pd() to get performance states table
      PM: EM: Add performance field to struct em_perf_state and optimize
      PM: EM: Support late CPUs booting and capacity adjustment
      PM: EM: Optimize em_cpu_energy() and remove division
      powercap/dtpm_cpu: Use new Energy Model interface to get table
      powercap/dtpm_devfreq: Use new Energy Model interface to get table
      drivers/thermal/cpufreq_cooling: Use new Energy Model interface
      drivers/thermal/devfreq_cooling: Use new Energy Model interface
      PM: EM: Change debugfs configuration to use runtime EM table data
      PM: EM: Remove old table
      PM: EM: Add em_dev_compute_costs()
      Documentation: EM: Update with runtime modification design
      PM: EM: Fix nr_states warnings in static checks

Maulik Shah (1):
      PM: suspend: Set mem_sleep_current during kernel command line setup

Meng Li (9):
      x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion
      ACPI: CPPC: Add helper to get the highest performance value
      cpufreq: amd-pstate: Enable amd-pstate preferred core support
      ACPI: cpufreq: Add highest perf change notification
      cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamic=
ally
      Documentation: amd-pstate: introduce amd-pstate preferred core
      Documentation: introduce amd-pstate preferrd core mode kernel
command line options
      Documentation: PM: amd-pstate: Fix section title underline
      cpufreq: amd-pstate: adjust min/max limit perf

Nikhil V (4):
      PM: hibernate: Rename lzo* to make it generic
      PM: hibernate: Move to crypto APIs for LZO compression
      PM: hibernate: Add support for LZ4 compression for hibernation
      PM: hibernate: Support to select compression algorithm

N=C3=ADcolas F. R. A. Prado (2):
      cpufreq: mediatek-hw: Wait for CPU supplies before probing
      cpufreq: mediatek-hw: Don't error out if supply is not found

Parshuram Sangle (1):
      cpuidle: haltpoll: do not shrink guest poll_limit_ns below grow_start

Pierre Gondois (4):
      cpufreq: Remove references to 10ms min sampling rate
      firmware: arm_scmi: Populate perf commands rate_limit
      firmware: arm_scmi: Populate fast channel rate_limit
      cpufreq: scmi: Set transition_delay_us

Qais Yousef (2):
      cpufreq: Change default transition delay to 2ms
      cpufreq: Honour transition_latency over transition_delay_us

Qingliang Li (1):
      PM: sleep: wakeirq: fix wake irq warning in system suspend

Rafael J. Wysocki (13):
      PM: sleep: Use bool for all 1-bit fields in struct dev_pm_info
      PM: sleep: Simplify dpm_suspended_list walk in dpm_resume()
      PM: sleep: Relocate two device PM core functions
      PM: sleep: stats: Use array of suspend step names
      PM: sleep: stats: Use an array of step failure counters
      PM: sleep: stats: Use unsigned int for success and failure counters
      PM: sleep: stats: Define suspend_stats next to the code using it
      PM: sleep: stats: Call dpm_save_failed_step() at most once per phase
      PM: sleep: stats: Use locking in dpm_save_failed_dev()
      PM: sleep: stats: Log errors right after running suspend callbacks
      PM: sleep: Move some assignments from under a lock
      PM: sleep: Move devices to new lists earlier in each suspend phase
      PM: sleep: Call dpm_async_fn() directly in each suspend phase

Richard Acayan (1):
      cpufreq: dt-platdev: block SDM670 in cpufreq-dt-platdev

RinHizakura (1):
      Documentation: PM: Fix PCI hibernation support description

Sakari Ailus (2):
      PM: runtime: Simplify pm_runtime_get_if_active() usage
      PM: runtime: Add pm_runtime_put_autosuspend() replacement

Samasth Norway Ananda (1):
      tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Shivnandan Kumar (1):
      cpufreq: Limit resolving a frequency to policy min/max

Sibi Sankar (1):
      OPP: Extend dev_pm_opp_data with turbo support

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Allow model specific EPPs
      cpufreq: intel_pstate: Update default EPPs for Meteor Lake

Sumeet Pawnikar (1):
      powercap: intel_rapl: Add support for Arrow Lake

Tor Vic (1):
      cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_per=
f()

Vilas Bhat (1):
      PM: runtime: add tracepoint for runtime_status changes

Viresh Kumar (4):
      cpufreq: Don't unregister cpufreq cooling on CPU hotplug
      cpufreq: Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h
      OPP: debugfs: Fix warning with W=3D1 builds
      OPP: debugfs: Fix warning around icc_get_name()

Yang Li (1):
      powercap: dtpm: Fix kernel-doc for dtpm_create_hierarchy() function

Yiwei Lin (1):
      Documentation: PM: Fix runtime_pm.rst markdown syntax

Zhang Rui (5):
      powercap: intel_rapl: Fix a NULL pointer dereference
      powercap: intel_rapl: Fix locking in TPMI RAPL
      powercap: intel_rapl_tpmi: Fix a register bug
      powercap: intel_rapl_tpmi: Fix System Domain probing
      powercap: intel_rapl: Add support for Lunar Lake-M paltform

tianyu2 (1):
      cpufreq: imx6: use regmap to read ocotp register

---------------

 Documentation/admin-guide/kernel-parameters.txt    |  16 +
 Documentation/admin-guide/pm/amd-pstate.rst        |  59 ++-
 .../devicetree/bindings/opp/opp-v2-base.yaml       |   2 -
 Documentation/power/energy-model.rst               | 183 +++++++-
 Documentation/power/opp.rst                        |   2 +-
 Documentation/power/pci.rst                        |   2 +-
 Documentation/power/runtime_pm.rst                 |  23 +-
 Documentation/translations/zh_CN/power/opp.rst     |   2 +-
 arch/x86/Kconfig                                   |   5 +-
 arch/x86/kernel/acpi/cstate.c                      |   4 +-
 drivers/accel/ivpu/ivpu_pm.c                       |   2 +-
 drivers/acpi/cppc_acpi.c                           |  13 +
 drivers/acpi/processor_driver.c                    |   6 +
 drivers/base/power/main.c                          | 267 +++++-------
 drivers/base/power/runtime.c                       |  36 +-
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/cpufreq/Kconfig.arm                        |   1 +
 drivers/cpufreq/amd-pstate.c                       | 200 ++++++++-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq.c                          |  32 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |   1 -
 drivers/cpufreq/imx6q-cpufreq.c                    |  45 +-
 drivers/cpufreq/intel_pstate.c                     |  46 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |  19 +-
 drivers/cpufreq/scmi-cpufreq.c                     |  26 ++
 drivers/cpuidle/driver.c                           |   3 +-
 drivers/cpuidle/governors/haltpoll.c               |   9 +-
 drivers/firmware/arm_scmi/driver.c                 |   5 +-
 drivers/firmware/arm_scmi/perf.c                   |  53 ++-
 drivers/firmware/arm_scmi/powercap.c               |  12 +-
 drivers/firmware/arm_scmi/protocols.h              |   4 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   5 +-
 drivers/gpu/drm/xe/xe_pm.c                         |   2 +-
 drivers/idle/intel_idle.c                          |   3 +-
 drivers/media/i2c/ccs/ccs-core.c                   |   2 +-
 drivers/media/i2c/ov64a40.c                        |   2 +-
 drivers/media/i2c/thp7312.c                        |   2 +-
 drivers/net/ipa/ipa_smp2p.c                        |   2 +-
 drivers/opp/core.c                                 |   1 +
 drivers/opp/debugfs.c                              |  14 +-
 drivers/pci/pci.c                                  |   2 +-
 drivers/powercap/dtpm.c                            |   2 +-
 drivers/powercap/dtpm_cpu.c                        |  43 +-
 drivers/powercap/dtpm_devfreq.c                    |  34 +-
 drivers/powercap/intel_rapl_common.c               |  36 +-
 drivers/powercap/intel_rapl_msr.c                  |   8 +-
 drivers/powercap/intel_rapl_tpmi.c                 |  15 +
 drivers/thermal/cpufreq_cooling.c                  |  45 +-
 drivers/thermal/devfreq_cooling.c                  |  49 ++-
 .../intel/int340x_thermal/processor_thermal_rapl.c |   8 +-
 include/acpi/cppc_acpi.h                           |   5 +
 include/linux/amd-pstate.h                         |  10 +
 include/linux/cpufreq.h                            |  40 +-
 include/linux/energy_model.h                       | 166 +++++---
 include/linux/intel_rapl.h                         |   6 +
 include/linux/pm.h                                 |  30 +-
 include/linux/pm_opp.h                             |  18 +
 include/linux/pm_runtime.h                         |  30 +-
 include/linux/scmi_protocol.h                      |   8 +
 include/linux/suspend.h                            |  74 +---
 include/trace/events/rpm.h                         |  42 ++
 kernel/power/Kconfig                               |  26 +-
 kernel/power/energy_model.c                        | 473 +++++++++++++++++=
+---
 kernel/power/hibernate.c                           | 107 ++++-
 kernel/power/main.c                                | 182 +++++---
 kernel/power/power.h                               |  23 +-
 kernel/power/snapshot.c                            |  25 +-
 kernel/power/suspend.c                             |   9 +-
 kernel/power/swap.c                                | 197 +++++----
 kernel/power/user.c                                |   4 +-
 sound/hda/hdac_device.c                            |   2 +-
 tools/power/cpupower/man/cpupower-frequency-info.1 |   2 +-
 .../x86_energy_perf_policy.c                       |   1 +
 74 files changed, 2115 insertions(+), 725 deletions(-)

