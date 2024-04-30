Return-Path: <linux-kernel+bounces-164425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C738B7D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D5A1C23C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938517B4EB;
	Tue, 30 Apr 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmnAM6vA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889C17BB0C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495774; cv=none; b=Oi71cKe2qcBB+QrR7z1PGI4TyMNVZk2wUnf2MVZZEgh8uv1U4yiSoeKoHtmp4JHaa9zZ4e3Z+owGcbLp5IU4uom1VqBHrJdYGz8tqtidWrB8WxPG4WZhHBmYc7gdG0gld4Cl9ieKAatPf7MGxfqheoLagyQWlL9nyZftUnwoxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495774; c=relaxed/simple;
	bh=HRcvpI2ezzKBbjW9f8dqpgmXP7k0gJMpiCOz5DWBB+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3Qgqd3dHR7kHOlcy8iS9u06aL4l4tBp2Znaxo7gNdwjkK82qtpiRM8RFep5Y9k4MTJIxObyE3kdbeWinyDgF1rnL9wfqAQP/OF3AZRI/SevpOky20fX/SS9UPkg0DIL4w6Uc7JFpTj5utl744u8B9RWSZJKYgnz+7uSdT237iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmnAM6vA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495773; x=1746031773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HRcvpI2ezzKBbjW9f8dqpgmXP7k0gJMpiCOz5DWBB+c=;
  b=XmnAM6vA6vHsl8bHK1E+Dnmc0R0Yjv8vilzeH2t/GzbUZ8mVQ28fIntj
   63kE3OfnHpxYkQCZabYVblmMacz6Zh7jXcFHl+hF19Wnr0U590O4+/XTh
   wiomKs8YjW913fBMhIPeJzelTzJoEuRmJICfBsG933lWqKWFXpfuN96PY
   zTySWcj3OB3Suzzppvcsj0VV8xWPSpWdBUNgsSHu9kPssQBW/ZgvmORtW
   sLxzTeL0hPfKw9qdBQxwvBsLw9GR5F8XCLBBpvsFYyggnxNq/oWroWnmH
   qxm3ZvGITpVdOev1qxehOShPQuY7g1tlOT/L2ZIbOJtGA2nJf1CUSPDI3
   g==;
X-CSE-ConnectionGUID: yjij2Z8gR1S0J1CNObdKng==
X-CSE-MsgGUID: tMJnzxjnS5217LLFCgkYrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="13141515"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="13141515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:49:25 -0700
X-CSE-ConnectionGUID: M0ryI9tzSNSm3Y14hnRqvg==
X-CSE-MsgGUID: IQCyXoqyRl+g+60dqcWw7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31230992"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:49:24 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 00/47] New Intel CPUID families
Date: Tue, 30 Apr 2024 09:49:13 -0700
Message-ID: <20240430164913.73473-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

See notes below on which patches can be applied to current cycle x86/cpu
branch, and which would have conflicts with other tip branches or linux-next.

See notes below on which patches can be applied to current cycle x86/cpu
branch, and which would have conflicts with other tip branches or linux-next.

Full cover letter here:
Link: https://lore.kernel.org/all/20240416211941.9369-1-tony.luck@intel.com/

But the tl;dr version is that some surgery is required to make adding
CPUs with new CPUID "family" values elegant.

This series also available with:
 $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git new_families_v5

Signed-off-by: Tony Luck <tony.luck@intel.com>

Changes since v4:
Link: https://lore.kernel.org/all/20240424181245.41141-1-tony.luck@intel.com/

* More patches from this series have been applied to TIP x86/cpu so I
  have dropped them from this posting. Down to 47 from 74. Yay!

* Base commit for this series is now:
        2eda374e883a ("x86/mm: Switch to new Intel CPU model defines")

* PECI patches have been merged into one refactored patch that properly
  converts to using vendor-family-model instead of extracting the model
  from the Intel #define.

* A bunch more Acked-by and Reviewed-by tags applied. Note that Hans
  de Goede explicitly said it was OK to take the patches he has ACked
  through TIP tree. That's 0002..0003, 0005, 0015..0023.

* Re-ordered remaining patches like this:
  0001..0023: Have Acked/Reviewed tags and do not conflict with any
              patches currently in the linux-next tree.
  0024..0037: Awaiting Acks (though there are a few x86 patches in this
              set, and I'm the maintainer for the four EDAC patches,
              I'm fine with those going through TIP).
  0038..0045: Conflict with linux-next. I will fix post v6.10-rc1
  0046..0047: Delete unused INTEL_FAM6 stuff. Must wait until all
              other patches have been applied.

Tony Luck (47):
  tpm: Switch to new Intel CPU model defines
  platform/x86/intel/ifs: Switch to new Intel CPU model defines
  media: atomisp: Switch to new Intel CPU model defines
  ASoC: Intel: avs: es8336: Switch to new Intel CPU model defines
  platform/x86: intel_scu_wdt: Switch to new Intel CPU model defines
  KVM: x86/pmu: Switch to new Intel CPU model defines
  KVM: VMX: Switch to new Intel CPU model defines
  cpufreq: Switch to new Intel CPU model defines
  intel_idle: Switch to new Intel CPU model defines
  PCI: PM: Switch to new Intel CPU model defines
  powercap: intel_rapl: Switch to new Intel CPU model defines
  ASoC: Intel: Switch to new Intel CPU model defines
  thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model
    defines
  x86/platform/intel-mid: Switch to new Intel CPU model defines
  platform/x86: intel_speed_select_if: Switch to new Intel CPU model
    defines
  platform/x86: intel-uncore-freq: Switch to new Intel CPU model defines
  platform/x86: intel_ips: Switch to new Intel CPU model defines
  platform/x86: intel_telemetry: Switch to new Intel CPU model defines
  platform/x86: intel: telemetry: Switch to new Intel CPU model defines
  platform/x86: intel_turbo_max_3: Switch to new Intel CPU model defines
  platform/x86: p2sb: Switch to new Intel CPU model defines
  platform/x86/intel: pmc: Switch to new Intel CPU model defines
  platform/x86/intel/pmc: Switch to new Intel CPU model defines
  crypto: x86/poly1305 - Switch to new Intel CPU model defines
  crypto: x86/twofish - Switch to new Intel CPU model defines
  x86/cpu/intel: Switch to new Intel CPU model defines
  x86/PCI: Switch to new Intel CPU model defines
  x86/virt/tdx: Switch to new Intel CPU model defines
  perf/x86/intel: Switch to new Intel CPU model defines
  x86/platform/atom: Switch to new Intel CPU model defines
  x86/cpu: Switch to new Intel CPU model defines
  x86/boot: Switch to new Intel CPU model defines
  EDAC/i10nm: Switch to new Intel CPU model defines
  EDAC, pnd2: Switch to new Intel CPU model defines
  EDAC/sb_edac: Switch to new Intel CPU model defines
  EDAC/skx: Switch to new Intel CPU model defines
  extcon: axp288: Switch to new Intel CPU model defines
  ACPI: LPSS: Switch to new Intel CPU model defines
  cpufreq: intel_pstate: Switch to new Intel CPU model defines
  powercap: intel_rapl: Switch to new Intel CPU model defines
  tools/power/turbostat: Switch to new Intel CPU model defines
  platform/x86: ISST: Switch to new Intel CPU model defines
  perf/x86/rapl: Switch to new Intel CPU model defines
  peci, hwmon: Switch to new Intel CPU model defines
  ACPI: x86: Switch to new Intel CPU model defines
  x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
  x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines

 .../atomisp/include/linux/atomisp_platform.h  |  27 +--
 include/linux/peci-cpu.h                      |  24 ++
 include/linux/peci.h                          |   6 +-
 include/linux/platform_data/x86/soc.h         |  12 +-
 arch/x86/include/asm/cpu_device_id.h          |  28 +--
 arch/x86/include/asm/intel-family.h           |  85 +------
 drivers/char/tpm/tpm.h                        |   2 +-
 drivers/char/tpm/tpm_tis_core.h               |   2 +-
 drivers/peci/internal.h                       |   6 +-
 arch/x86/boot/cpucheck.c                      |   2 +-
 arch/x86/crypto/poly1305_glue.c               |   4 +-
 arch/x86/crypto/twofish_glue_3way.c           |  10 +-
 arch/x86/events/intel/core.c                  | 212 +++++++++---------
 arch/x86/events/rapl.c                        |  84 +++----
 arch/x86/kernel/cpu/intel.c                   | 108 +++++----
 arch/x86/kvm/pmu.c                            |   8 +-
 arch/x86/kvm/vmx/vmx.c                        |  20 +-
 arch/x86/pci/intel_mid_pci.c                  |   4 +-
 arch/x86/platform/atom/punit_atom_debug.c     |  11 +-
 arch/x86/platform/intel-mid/intel-mid.c       |   7 +-
 arch/x86/virt/vmx/tdx/tdx.c                   |   8 +-
 drivers/acpi/acpi_lpss.c                      |   4 +-
 drivers/acpi/x86/utils.c                      |  42 ++--
 drivers/cpufreq/intel_pstate.c                |  90 ++++----
 drivers/cpufreq/speedstep-centrino.c          |   8 +-
 drivers/edac/i10nm_base.c                     |  20 +-
 drivers/edac/pnd2_edac.c                      |   4 +-
 drivers/edac/sb_edac.c                        |  14 +-
 drivers/edac/skx_base.c                       |   2 +-
 drivers/extcon/extcon-axp288.c                |   2 +-
 drivers/hwmon/peci/cputemp.c                  |   8 +-
 drivers/idle/intel_idle.c                     | 116 +++++-----
 drivers/pci/pci-mid.c                         |   4 +-
 drivers/peci/core.c                           |   5 +-
 drivers/peci/cpu.c                            |  21 +-
 drivers/peci/device.c                         |   3 +-
 drivers/platform/x86/intel/ifs/core.c         |  15 +-
 drivers/platform/x86/intel/pmc/core.c         |  46 ++--
 drivers/platform/x86/intel/pmc/pltdrv.c       |  16 +-
 .../intel/speed_select_if/isst_if_common.c    |   4 +-
 .../intel/speed_select_if/isst_if_mbox_msr.c  |   2 +-
 .../platform/x86/intel/telemetry/debugfs.c    |   4 +-
 drivers/platform/x86/intel/telemetry/pltdrv.c |   4 +-
 drivers/platform/x86/intel/turbo_max_3.c      |   4 +-
 .../intel/uncore-frequency/uncore-frequency.c |  56 ++---
 drivers/platform/x86/intel_ips.c              |   3 +-
 drivers/platform/x86/intel_scu_wdt.c          |   2 +-
 drivers/platform/x86/p2sb.c                   |   2 +-
 drivers/powercap/intel_rapl_common.c          | 118 +++++-----
 drivers/powercap/intel_rapl_msr.c             |  16 +-
 drivers/thermal/intel/intel_soc_dts_thermal.c |   2 +-
 drivers/thermal/intel/intel_tcc_cooling.c     |  30 +--
 sound/soc/intel/avs/boards/es8336.c           |   8 +-
 tools/power/x86/turbostat/turbostat.c         | 161 +++++++------
 54 files changed, 716 insertions(+), 790 deletions(-)


base-commit: 2eda374e883ad297bd9fe575a16c1dc850346075
-- 
2.44.0


