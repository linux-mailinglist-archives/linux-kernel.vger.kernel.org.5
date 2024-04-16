Return-Path: <linux-kernel+bounces-147561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872F8A7640
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066791F23864
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3B6BFA3;
	Tue, 16 Apr 2024 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9udOsL4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1761E864
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302398; cv=none; b=JQQsmsPox/ox8scyOQEAjxYkHsUXPrIBnM4Mj5IJEaHvnqEAKvTg5MvXoCUqoTyjzKjXBYgmJFFmjB7wmnj681YlXAx90cHttQXQVhUFbDt1gxS6C5/XhBCKobftcNMi2tqynRSpJlnKXPsC/2Wqv3SuRNPRlfFl77FGMMzh/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302398; c=relaxed/simple;
	bh=/gG1Ud4Jh4yyM43jcukle0sEq0SFa7ETYPrFB0mf/2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaDEDaaOBYrVNMUv9PRBIpAwijcGMmr/Sup47oGuIrbcqc7Q4UuWTBtR5xXUqeVV3QgBIeORRf3yFFlggtO41hYJVU0QY4nzPHxyOFJhDhCrnNGUx3XhKUGUKOjw2Lt9MnQnMlC29rQo5CgB2cdIeUq9A+DlY0/6ssVKf8JCGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9udOsL4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302397; x=1744838397;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/gG1Ud4Jh4yyM43jcukle0sEq0SFa7ETYPrFB0mf/2E=;
  b=n9udOsL41BmkuCibE9h4CID+dU8dSimR7nmEbbSmCoK98/ufCzyNEaeg
   EF+xkIC9HEIV6F2G9z+/SBcNGA2ifmuK5AXdjM+gWfI753Bu3hnPkn9RB
   CTk1VrjLRCNrGi9dQ+xNySXDPuISbvPU5IRyjnWp+jK4WcAKdCCTQMhXa
   sx1uKJhaAbDbLDd/O2wU2Yea1EGjzzz/pRD12VuBkWrA5oZUHiFMsTog4
   J9omMeFSD+yIxpxc98Mg8jqQkICYZDBS6K1wRjLPNq89dllfkPB7SteDb
   xU4RFiCBVhBo9nEIGYxTKsjl3R8+XUr5yq6vdPSfNsHEOxGqxZ9XE9skQ
   Q==;
X-CSE-ConnectionGUID: acPouLAhREmrqsj25QRwrA==
X-CSE-MsgGUID: GVBjN1fzR3WzfZ9lIzmNfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914663"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:56 -0700
X-CSE-ConnectionGUID: vxTvYbj+TKutBoMOCnu21w==
X-CSE-MsgGUID: 7FXH+FLdS+inHxaKAAafsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871863"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:56 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 00/74] New Intel CPUID families
Date: Tue, 16 Apr 2024 14:19:02 -0700
Message-ID: <20240416211941.9369-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches on tip/master as of April 16th. See base-commit at end of
this message for exact commit ID.

Intel has been using family 6 almost exclusively for many
years. As a result, Linux has built up infrastructure like
X86_MATCH_INTEL_FAM6_MODEL() to make it easy for model specific code to
use the #defines for each Intel CPU model.

But the reign of family 6 is about to end. Intel will begin using non-zero
values for the extended family field in CPUID(1).EAX. The minimal patch
size approach to handle these would be to clone the FAM6 macros. But
that will get messy as these prolifrate. This approach does not have an
elegant solution if a switch() statement needs to choose between CPUs
from different families.

Dave Hansen suggested that a more general cleanup that provides
CPU #defines that encode all of <vendor, family, model> would make
existing code better, and provide infrastructure that makes it trivial
to incorporate new families.

Big picture view is that code like this:

  if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 6 && c->x86_model == INTEL_FAM6_ICELAKE_X)

can become:

  if (c->x86_vfm == INTEL_ICELAKE_X)

which is:
a)	Simpler
b)	Faster
c)	More resilient (can't forget to check vendor & family along with model)
d)	Code style doesn't change for every new family.

Note that "struct cpuinfo_x86" gains a new xf6_vfm field and the ICELAKE
#define loses the "FAM6_" substring and will be initialized with a macro
that does the bit shuffling to fit X86_VENDOR_INTEL and a family and
model into a "u32":

#define INTEL_ICELAKE_X                 IFM(6, 0x6A) /* Sunny Cove */

New CPUs in other families might look like:

#define INTEL_DOUGLASCOVE		IFM(42, 0x01) /* Adams Lake */
#define INTEL_SHELDONMONT		IFM(73, 0x01) /* Cooper Forest */

[Some folks missed the jokes embedded in these EXAMPLE names/numbers.
For cultural references read/listen/watch "The Hitchhikers Guide to the
Galaxy" by Douglas Adams and "The Big Bang Theory" TV show created by
Chuck Lorre and Bill Prady].

Model specific "if" statements then follow the same pattern
regardless of family:

  if (c->x86_vfm == INTEL_DOUGLASCOVE || c->x86_vfm == INTEL_SHELDONMONT) {
  }

If needed these could even appear in the same switch statement:

	switch (c->x86_vfm) {
	case INTEL_ICELAKE_X:
		...
	case INTEL_DOUGLASCOVE:
		...
	case INTEL_SHELDONMONT:
		...
	}

The existing X86_MATCH_INTEL_FAM6_MODEL() can be replaced with a new
X86_MATCH_VFM() macro.

Update can happen in phases:

1) Add infrastructure macros, new "x86_vfm" field, new CPU #defines
   Patches 0001 .. 0003

2) arch/x86 update from old to new
   Patches 0004 .. 0039

3) Other treewide updates from old to new
   Patches 0040 .. 0072

4) Delete the old INTEL_FAM6 and X86_MATCH_INTEL_FAM6 macros (when
   all of 0001 .. 0072 have been applied)
   Patches 0073 .. 0074

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Link: v1: https://lore.kernel.org/all/20240328163746.243023-1-tony.luck@intel.com/

v2: Just changed parts 1 & 2 to rearrange the vendor, family, model
fields in x86_vfm so that model is in the least significant bits with
family and vendor each in more significant bits so that ranges of models
could be used in "if" and "switch" statements.

v3: Added Thomas Gleixner's reviewed-by to parts 1-3. Shuffled parts
4-72 so that arch/x86 files appear before other changes scattered around
the source tree.

Tony Luck (74):
  x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
  x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
  x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h
  x86/cpu/vfm: Update arch/x86/crypto/poly1305_glue.c
  x86/cpu/vfm: Update arch/x86/crypto/twofish_glue_3way.c
  x86/cpu/vfm: Update arch/x86/events/intel/cstate.c
  x86/cpu/vfm: Update arch/x86/events/intel/lbr.c
  x86/cpu/vfm: Update arch/x86/events/intel/pt.c
  x86/cpu/vfm: Update arch/x86/events/intel/uncore.c
  x86/cpu/vfm: Update arch/x86/events/intel/uncore_nhmex.c
  x86/cpu/vfm: Update arch/x86/events/intel/uncore_snbep.c
  x86/cpu/vfm: Update arch/x86/events/msr.c
  x86/cpu/vfm: Update arch/x86/events/rapl.c
  x86/cpu/vfm: Update arch/x86/kernel/apic/apic.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/aperfmperf.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/bugs.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/common.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/intel.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/intel_epb.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/match.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/core.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/intel.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/severity.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/microcode/intel.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/resctrl/core.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/resctrl/pseudo_lock.c
  x86/cpu/vfm: Update arch/x86/kernel/smpboot.c
  x86/cpu/vfm: Update arch/x86/kernel/tsc.c
  x86/cpu/vfm: Update arch/x86/kernel/tsc_msr.c
  x86/cpu/vfm: Update arch/x86/kvm/pmu.c
  x86/cpu/vfm: Update arch/x86/kvm/vmx/vmx.c
  x86/cpu/vfm: Update arch/x86/mm/init.c
  x86/cpu/vfm: Update arch/x86/pci/intel_mid_pci.c
  x86/cpu/vfm: Update arch/x86/virt/vmx/tdx/tdx.c
  x86/cpu/vfm: Update arch/x86/events/intel/core.c
  x86/cpu/vfm: Update arch/x86/platform/intel-mid/intel-mid.c
  x86/cpu/vfm: Update arch/x86/platform/atom/punit_atom_debug.c
  x86/cpu/vfm: Update arch/x86/events/intel/core.c
  x86/cpu/vfm: Update arch/x86/boot/cpucheck.c
  x86/cpu/vfm: Update drivers/acpi/acpi_lpss.c
  x86/cpu/vfm: Update drivers/acpi/x86/utils.c
  x86/cpu/vfm: Update tpm files
  x86/cpu/vfm: Update drivers/cpufreq/intel_pstate.c
  x86/cpu/vfm: Update drivers/cpufreq/speedstep-centrino.c
  x86/cpu/vfm: Update drivers/edac/i10nm_base.c
  x86/cpu/vfm: Update drivers/edac/pnd2_edac.c
  x86/cpu/vfm: Update drivers/edac/sb_edac.c
  x86/cpu/vfm: Update drivers/edac/skx_base.c
  x86/cpu/vfm: Update drivers/extcon/extcon-axp288.c
  x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
  x86/cpu/vfm: Update drivers/idle/intel_idle.c
  x86/cpu/vfm: Update drivers/pci/pci-mid.c
  x86/cpu/vfm: Update drivers/peci/cpu.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/ifs/core.c
  x86/cpu/vfm: Update drivers/platform/x86/intel_ips.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/pmc/core.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/pmc/pltdrv.c
  x86/cpu/vfm: Update drivers/platform/x86/intel_scu_wdt.c
  x86/cpu/vfm: Update
    drivers/platform/x86/intel/speed_select_if/isst_if_common.c
  x86/cpu/vfm: Update
    drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/telemetry/debugfs.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/telemetry/pltdrv.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/turbo_max_3.c
  x86/cpu/vfm: Update
    drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
  x86/cpu/vfm: Update drivers/platform/x86/p2sb.c
  x86/cpu/vfm: Update drivers/powercap/intel_rapl_common.c
  x86/cpu/vfm: Update drivers/powercap/intel_rapl_msr.c
  x86/cpu/vfm: Update
    drivers/staging/media/atomisp/include/linux/atomisp_platform.h
  x86/cpu/vfm: Update intel_soc_dts_thermal.c
  x86/cpu/vfm: Update drivers/thermal/intel/intel_tcc_cooling.c
  x86/cpu/vfm: Update sound/soc/intel/avs/boards/es8336.c
  x86/cpu/vfm: Update tools/power/x86/turbostat/turbostat.c
  x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
  x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines

 .../atomisp/include/linux/atomisp_platform.h  |  26 +--
 include/linux/peci-cpu.h                      |   1 +
 include/linux/platform_data/x86/soc.h         |  12 +-
 arch/x86/include/asm/cpu_device_id.h          | 103 +++++++--
 arch/x86/include/asm/intel-family.h           | 167 +++++++-------
 arch/x86/include/asm/processor.h              |  12 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_core.h               |   2 +-
 arch/x86/boot/cpucheck.c                      |   2 +-
 arch/x86/crypto/poly1305_glue.c               |   3 +-
 arch/x86/crypto/twofish_glue_3way.c           |  10 +-
 arch/x86/events/intel/core.c                  | 212 +++++++++---------
 arch/x86/events/intel/cstate.c                | 144 ++++++------
 arch/x86/events/intel/lbr.c                   |   3 +-
 arch/x86/events/intel/pt.c                    |  11 +-
 arch/x86/events/intel/uncore.c                | 100 ++++-----
 arch/x86/events/intel/uncore_nhmex.c          |   3 +-
 arch/x86/events/intel/uncore_snbep.c          |   5 +-
 arch/x86/events/msr.c                         | 131 +++++------
 arch/x86/events/rapl.c                        |  90 ++++----
 arch/x86/kernel/apic/apic.c                   |  38 ++--
 arch/x86/kernel/cpu/aperfmperf.c              |  17 +-
 arch/x86/kernel/cpu/bugs.c                    |  29 +--
 arch/x86/kernel/cpu/common.c                  | 154 +++++++------
 arch/x86/kernel/cpu/intel.c                   | 115 +++++-----
 arch/x86/kernel/cpu/intel_epb.c               |  12 +-
 arch/x86/kernel/cpu/match.c                   |   5 +-
 arch/x86/kernel/cpu/mce/core.c                |   5 +-
 arch/x86/kernel/cpu/mce/intel.c               |  20 +-
 arch/x86/kernel/cpu/mce/severity.c            |   9 +-
 arch/x86/kernel/cpu/microcode/intel.c         |   4 +-
 arch/x86/kernel/cpu/resctrl/core.c            |   9 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  21 +-
 arch/x86/kernel/smpboot.c                     |   6 +-
 arch/x86/kernel/tsc.c                         |   5 +-
 arch/x86/kernel/tsc_msr.c                     |  14 +-
 arch/x86/kvm/pmu.c                            |   8 +-
 arch/x86/kvm/vmx/vmx.c                        |  20 +-
 arch/x86/mm/init.c                            |  16 +-
 arch/x86/pci/intel_mid_pci.c                  |   4 +-
 arch/x86/platform/atom/punit_atom_debug.c     |  11 +-
 arch/x86/platform/intel-mid/intel-mid.c       |   7 +-
 arch/x86/virt/vmx/tdx/tdx.c                   |   7 +-
 drivers/acpi/acpi_lpss.c                      |   4 +-
 drivers/acpi/x86/utils.c                      |  42 ++--
 drivers/cpufreq/intel_pstate.c                |  90 ++++----
 drivers/cpufreq/speedstep-centrino.c          |   8 +-
 drivers/edac/i10nm_base.c                     |  20 +-
 drivers/edac/pnd2_edac.c                      |   4 +-
 drivers/edac/sb_edac.c                        |  14 +-
 drivers/edac/skx_base.c                       |   2 +-
 drivers/extcon/extcon-axp288.c                |   2 +-
 drivers/hwmon/peci/cputemp.c                  |   7 +-
 drivers/idle/intel_idle.c                     | 116 +++++-----
 drivers/pci/pci-mid.c                         |   4 +-
 drivers/peci/cpu.c                            |  28 +--
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
 sound/soc/intel/avs/boards/es8336.c           |   7 +-
 tools/power/x86/turbostat/turbostat.c         | 161 +++++++------
 74 files changed, 1261 insertions(+), 1146 deletions(-)


base-commit: 367dc2b68007e8ca00a0d8dc9afb69bff5451ae7
-- 
2.44.0


