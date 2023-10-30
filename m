Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0177DBA18
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjJ3Mqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3Mqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:46:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE2B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698670009; x=1730206009;
  h=message-id:from:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=UM2IuPKhME5eryCtH9YNZYBVMtsT6jTFBEyYnKnOTQ0=;
  b=O1aZHayaHKI17LLfswPyau+eCOTqiapx0YM6JmMIYBEW4j+M/65drL4q
   NUw42EYBQw/MBKrDV38Uqi3aqNciK/yHfm+zQllYUHh5dFTQjRVuQY5q5
   8MJZbMz5LEHxwyp6AJ5Hr7Pea8DwZ5VWTMsjGCUxFn/bQAQLmbuC0zfYH
   mTZxDsdtdVD1gLeVUSoyfmPfpmu5k1XTT/IibyFupTC2b3BjEumo75QtZ
   H+YdYdTQu6ujuc8BYwVAIRXKWHpsRw8/12YcibVYsCeou9bwjDDOcdGuc
   iuc3PRv53eVqBwrhqnVOU6zpmqBUNkvmckRv6GkPnR8YEw2fwsmLmEHMB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="387874190"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="387874190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:46:49 -0700
Message-Id: <b7cfad$q4ffmb@fmsmga002-auth.fm.intel.com>
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="877117131"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="877117131"
Received: from ilavreno-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.50.186])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:46:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Date:   Mon, 30 Oct 2023 14:43:48 +0200
Subject: platform-drivers-x86 for v6.7-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v6.7.

Highlights:
 - asus-wmi:		Support for screenpad and solve brightness key
			press duplication
 - int3472:		Eliminate the last use of deprecated GPIO functions
 - mlxbf-pmc:		New HW support
 - msi-ec:		Support new EC configurations
 - thinkpad_acpi:	Support reading aux MAC address during passthrough
 - wmi: 		Fixes & improvements
 - x86-android-tablets:	Detection fix and avoid use of GPIO private APIs
 - Debug & metrics interface improvements
 - Miscellaneous cleanups / fixes / improvements

Regards, i.


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-1

for you to fetch changes up to 94ace9eda88229c73698b8dd8d3c06dd0831319c:

  platform/x86: inspur-platform-profile: Add platform profile support (2023-10-27 16:14:47 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.7-1

Highlights:
 - asus-wmi:		Support for screenpad and solve brightness key
			press duplication
 - int3472:		Eliminate the last use of deprecated GPIO functions
 - mlxbf-pmc:		New HW support
 - msi-ec:		Support new EC configurations
 - thinkpad_acpi:	Support reading aux MAC address during passthrough
 - wmi: 		Fixes & improvements
 - x86-android-tablets:	Detection fix and avoid use of GPIO private APIs
 - Debug & metrics interface improvements
 - Miscellaneous cleanups / fixes / improvements

The following is an automated shortlog grouped by driver:

acer-wmi:
 -  Remove void function return

amd/hsmp:
 -  add support for metrics tbl
 -  create plat specific struct
 -  Fix iomem handling
 -  improve the error log

amd/pmc:
 -  Add dump_custom_stb module parameter
 -  Add PMFW command id to support S2D force flush
 -  Handle overflow cases where the num_samples range is higher
 -  Use flex array when calling amd_pmc_stb_debugfs_open_v2()

asus-wireless:
 -  Replace open coded acpi_match_acpi_device()

asus-wmi:
 -  add support for ASUS screenpad
 -  Do not report brightness up/down keys when also reported by acpi_video

gpiolib: acpi:
 -  Add a ignore interrupt quirk for Peaq C1010
 -  Check if a GPIO is listed in ignore_interrupt earlier

hp-bioscfg:
 -  Annotate struct bios_args with __counted_by

inspur-platform-profile:
 -  Add platform profile support

int3472:
 -  Add new skl_int3472_fill_gpiod_lookup() helper
 -  Add new skl_int3472_gpiod_get_from_temp_lookup() helper
 -  Stop using gpiod_toggle_active_low()
 -  Switch to devm_get_gpiod()

intel: bytcrc_pwrsrc:
 -  Convert to platform remove callback returning void

intel/ifs:
 -  Add new CPU support
 -  Add new error code
 -  ARRAY BIST for Sierra Forest
 -  Gen2 scan image loading
 -  Gen2 Scan test support
 -  Metadata validation for start_chunk
 -  Refactor image loading code
 -  Store IFS generation number
 -  Validate image size

intel_speed_select_if:
 -  Remove hardcoded map size
 -  Use devm_ioremap_resource

intel/tpmi:
 -  Add debugfs support for read/write blocked
 -  Add defines to get version information

intel-uncore-freq:
 -  Ignore minor version change

ISST:
 -  Allow level 0 to be not present
 -  Ignore minor version change
 -  Use fuse enabled mask instead of allowed levels

mellanox:
 -  Fix misspelling error in routine name
 -  Rename some init()/exit() functions for consistent naming

mlxbf-bootctl:
 -  Convert to platform remove callback returning void

mlxbf-pmc:
 -  Add support for BlueField-3

mlxbf-tmfifo:
 -  Convert to platform remove callback returning void

mlx-Convert to platform remove callback returning void:
 - mlx-Convert to platform remove callback returning void

mlxreg-hotplug:
 -  Convert to platform remove callback returning void

mlxreg-io:
 -  Convert to platform remove callback returning void

mlxreg-lc:
 -  Convert to platform remove callback returning void

msi-ec:
 -  Add more EC configs
 -  rename fn_super_swap

nvsw-sn2201:
 -  Convert to platform remove callback returning void

sel3350-Convert to platform remove callback returning void:
 - sel3350-Convert to platform remove callback returning void

siemens: simatic-ipc-batt-apollolake:
 -  Convert to platform remove callback returning void

siemens: simatic-ipc-batt:
 -  Convert to platform remove callback returning void

siemens: simatic-ipc-batt-elkhartlake:
 -  Convert to platform remove callback returning void

siemens: simatic-ipc-batt-f7188x:
 -  Convert to platform remove callback returning void

siemens: simatic-ipc-batt:
 -  Simplify simatic_ipc_batt_remove()

surface: acpi-notify:
 -  Convert to platform remove callback returning void

surface: aggregator:
 -  Annotate struct ssam_event with __counted_by

surface: aggregator-cdev:
 -  Convert to platform remove callback returning void

surface: aggregator-registry:
 -  Convert to platform remove callback returning void

surface: dtx:
 -  Convert to platform remove callback returning void

surface: gpe:
 -  Convert to platform remove callback returning void

surface: hotplug:
 -  Convert to platform remove callback returning void

surface: surface3-wmi:
 -  Convert to platform remove callback returning void

think-lmi:
 -  Add bulk save feature
 -  Replace kstrdup() + strreplace() with kstrdup_and_replace()
 -  Use strreplace() to replace a character by nul

thinkpad_acpi:
 -  Add battery quirk for Thinkpad X120e
 -  replace deprecated strncpy with memcpy
 -  sysfs interface to auxmac

tools/power/x86/intel-speed-select:
 -  Display error for core-power support
 -  Increase max CPUs in one request
 -  No TRL for non compute domains
 -  Sanitize integer arguments
 -  turbo-mode enable disable swapped
 -  Update help for TRL
 -  Use cgroup isolate for CPU 0
 -  v1.18 release

wmi:
 -  Decouple probe deferring from wmi_block_list
 -  Decouple WMI device removal from wmi_block_list
 -  Fix opening of char device
 -  Fix probe failure when failing to register WMI devices
 -  Fix refcounting of WMI devices in legacy functions

x86-android-tablets:
 -  Add a comment about x86_android_tablet_get_gpiod()
 -  Create a platform_device from module_init()
 -  Drop "linux,power-supply-name" from lenovo_yt3_bq25892_0_props[]
 -  Fix Lenovo Yoga Tablet 2 830F/L vs 1050F/L detection
 -  Remove invalid_aei_gpiochip from Peaq C1010
 -  Remove invalid_aei_gpiochip support
 -  Stop using gpiolib private APIs
 -  Use platform-device as gpio-keys parent

xo15-ebook:
 -  Replace open coded acpi_match_acpi_device()

Merges:
 -  Merge branch 'pdx86/platform-drivers-x86-int3472' into review-ilpo
 -  Merge branch 'pdx86/platform-drivers-x86-mellanox-init' into review-ilpo
 -  Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-ilpo
 -  Merge remote-tracking branch 'pdx86/platform-drivers-x86-android-tablets' into review-hans

----------------------------------------------------------------
Ai Chao (1):
      platform/x86: inspur-platform-profile: Add platform profile support

Andy Shevchenko (4):
      platform/x86: think-lmi: Replace kstrdup() + strreplace() with kstrdup_and_replace()
      platform/x86: think-lmi: Use strreplace() to replace a character by nul
      platform/x86: xo15-ebook: Replace open coded acpi_match_acpi_device()
      platform/x86: asus-wireless: Replace open coded acpi_match_acpi_device()

Armin Wolf (6):
      platform/x86/amd/hsmp: Fix iomem handling
      platform/x86: wmi: Decouple probe deferring from wmi_block_list
      platform/x86: wmi: Fix refcounting of WMI devices in legacy functions
      platform/x86: wmi: Fix probe failure when failing to register WMI devices
      platform/x86: wmi: Fix opening of char device
      platform/x86: wmi: Decouple WMI device removal from wmi_block_list

Bartosz Golaszewski (1):
      platform/x86: int3472: Add new skl_int3472_gpiod_get_from_temp_lookup() helper

David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Edson Juliano Drosdeck (1):
      platform/x86: acer-wmi: Remove void function return

Fernando Eckhardt Valle (1):
      platform/x86: thinkpad_acpi: sysfs interface to auxmac

Geert Uytterhoeven (1):
      platform/mellanox: NVSW_SN2201 should depend on ACPI

Hans de Goede (15):
      gpiolib: acpi: Check if a GPIO is listed in ignore_interrupt earlier
      gpiolib: acpi: Add a ignore interrupt quirk for Peaq C1010
      platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip from Peaq C1010
      platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip support
      platform/x86: x86-android-tablets: Create a platform_device from module_init()
      platform/x86: x86-android-tablets: Stop using gpiolib private APIs
      platform/x86: x86-android-tablets: Use platform-device as gpio-keys parent
      platform/x86: x86-android-tablets: Drop "linux,power-supply-name" from lenovo_yt3_bq25892_0_props[]
      platform/x86: x86-android-tablets: Add a comment about x86_android_tablet_get_gpiod()
      Merge remote-tracking branch 'pdx86/platform-drivers-x86-android-tablets' into review-hans
      platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830F/L vs 1050F/L detection
      platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
      platform/x86: int3472: Stop using gpiod_toggle_active_low()
      platform/x86: int3472: Switch to devm_get_gpiod()
      platform/x86: asus-wmi: Do not report brightness up/down keys when also reported by acpi_video

Ilpo Järvinen (3):
      Merge branch 'pdx86/platform-drivers-x86-int3472' into review-ilpo
      Merge branch 'pdx86/platform-drivers-x86-mellanox-init' into review-ilpo
      Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-ilpo

Jithu Joseph (9):
      platform/x86/intel/ifs: Store IFS generation number
      platform/x86/intel/ifs: Refactor image loading code
      platform/x86/intel/ifs: Gen2 scan image loading
      platform/x86/intel/ifs: Gen2 Scan test support
      platform/x86/intel/ifs: Validate image size
      platform/x86/intel/ifs: Metadata validation for start_chunk
      platform/x86/intel/ifs: Add new CPU support
      platform/x86/intel/ifs: Add new error code
      platform/x86/intel/ifs: ARRAY BIST for Sierra Forest

Justin Stitt (1):
      platform/x86: thinkpad_acpi: replace deprecated strncpy with memcpy

Kees Cook (2):
      platform/x86: hp-bioscfg: Annotate struct bios_args with __counted_by
      platform/surface: aggregator: Annotate struct ssam_event with __counted_by

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Luke D. Jones (2):
      platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode
      platform/x86: asus-wmi: add support for ASUS screenpad

Mark Pearson (1):
      platform/x86: think-lmi: Add bulk save feature

Nikita Kravets (2):
      platform/x86: msi-ec: rename fn_super_swap
      platform/x86: msi-ec: Add more EC configs

Olli Asikainen (1):
      platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

Shravan Kumar Ramani (3):
      platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
      platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
      platform/mellanox: mlxbf-pmc: Add support for BlueField-3

Shyam Sundar S K (4):
      platform/x86/amd/pmc: Add PMFW command id to support S2D force flush
      platform/x86/amd/pmc: Use flex array when calling amd_pmc_stb_debugfs_open_v2()
      platform/x86/amd/pmc: Handle overflow cases where the num_samples range is higher
      platform/x86/amd/pmc: Add dump_custom_stb module parameter

Srinivas Pandruvada (16):
      platform/x86: ISST: Use fuse enabled mask instead of allowed levels
      platform/x86: ISST: Allow level 0 to be not present
      platform/x86: intel_speed_select_if: Remove hardcoded map size
      platform/x86: intel_speed_select_if: Use devm_ioremap_resource
      platform/x86/intel/tpmi: Add defines to get version information
      platform/x86: ISST: Ignore minor version change
      platform/x86/intel-uncore-freq: Ignore minor version change
      platform/x86/intel/tpmi: Add debugfs support for read/write blocked
      tools/power/x86/intel-speed-select: Sanitize integer arguments
      tools/power/x86/intel-speed-select: Update help for TRL
      tools/power/x86/intel-speed-select: turbo-mode enable disable swapped
      tools/power/x86/intel-speed-select: No TRL for non compute domains
      tools/power/x86/intel-speed-select: Display error for core-power support
      tools/power/x86/intel-speed-select: Increase max CPUs in one request
      tools/power/x86/intel-speed-select: Use cgroup isolate for CPU 0
      tools/power/x86/intel-speed-select: v1.18 release

Suma Hegde (3):
      platform/x86/amd/hsmp: create plat specific struct
      platform/x86/amd/hsmp: add support for metrics tbl
      platform/x86/amd/hsmp: improve the error log

Uwe Kleine-König (21):
      platform/surface: surface3-wmi: Convert to platform remove callback returning void
      platform/surface: acpi-notify: Convert to platform remove callback returning void
      platform/surface: aggregator-cdev: Convert to platform remove callback returning void
      platform/surface: aggregator-registry: Convert to platform remove callback returning void
      platform/surface: dtx: Convert to platform remove callback returning void
      platform/surface: gpe: Convert to platform remove callback returning void
      platform/surface: hotplug: Convert to platform remove callback returning void
      platform/mellanox: mlxbf-bootctl: Convert to platform remove callback returning void
      platform/mellanox: mlxbf-tmfifo: Convert to platform remove callback returning void
      platform/mellanox: mlxreg-hotplug: Convert to platform remove callback returning void
      platform/mellanox: mlxreg-io: Convert to platform remove callback returning void
      platform/mellanox: mlxreg-lc: Convert to platform remove callback returning void
      platform/mellanox: nvsw-sn2201: Convert to platform remove callback returning void
      platform/x86/intel: bytcrc_pwrsrc: Convert to platform remove callback returning void
      platform/x86: mlx-platform: Convert to platform remove callback returning void
      platform/x86: sel3350-platform: Convert to platform remove callback returning void
      platform/x86/siemens: simatic-ipc-batt: Simplify simatic_ipc_batt_remove()
      platform/x86/siemens: simatic-ipc-batt: Convert to platform remove callback returning void
      platform/x86/siemens: simatic-ipc-batt-apollolake: Convert to platform remove callback returning void
      platform/x86/siemens: simatic-ipc-batt-elkhartlake: Convert to platform remove callback returning void
      platform/x86/siemens: simatic-ipc-batt-f7188x: Convert to platform remove callback returning void

Vadim Pasternak (3):
      platform: mellanox: Fix a resource leak in an error handling path in probing flow
      platform: mellanox: Rename some init()/exit() functions for consistent naming
      platform: mellanox: Fix misspelling error in routine name

 .../ABI/testing/sysfs-class-firmware-attributes    |  30 +
 .../admin-guide/laptops/thinkpad-acpi.rst          |  20 +
 Documentation/arch/x86/amd_hsmp.rst                |  18 +
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/include/uapi/asm/amd_hsmp.h               | 109 +++
 drivers/gpio/gpiolib-acpi.c                        |  30 +-
 drivers/platform/mellanox/Kconfig                  |   5 +-
 drivers/platform/mellanox/mlxbf-bootctl.c          |   6 +-
 drivers/platform/mellanox/mlxbf-pmc.c              | 727 +++++++++++++++++++--
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  96 ++-
 drivers/platform/mellanox/mlxreg-hotplug.c         |   6 +-
 drivers/platform/mellanox/mlxreg-io.c              |   6 +-
 drivers/platform/mellanox/mlxreg-lc.c              |   8 +-
 drivers/platform/mellanox/nvsw-sn2201.c            |   6 +-
 drivers/platform/surface/surface3-wmi.c            |   5 +-
 drivers/platform/surface/surface_acpi_notify.c     |   6 +-
 drivers/platform/surface/surface_aggregator_cdev.c |   5 +-
 .../platform/surface/surface_aggregator_registry.c |   5 +-
 drivers/platform/surface/surface_dtx.c             |   5 +-
 drivers/platform/surface/surface_gpe.c             |   6 +-
 drivers/platform/surface/surface_hotplug.c         |   6 +-
 drivers/platform/x86/Kconfig                       |  11 +
 drivers/platform/x86/Makefile                      |   3 +
 drivers/platform/x86/acer-wmi.c                    |   2 -
 drivers/platform/x86/amd/hsmp.c                    | 241 ++++++-
 drivers/platform/x86/amd/pmc/pmc.c                 |  88 ++-
 drivers/platform/x86/asus-nb-wmi.c                 |  25 +
 drivers/platform/x86/asus-wireless.c               |  12 +-
 drivers/platform/x86/asus-wmi.c                    | 133 ++++
 drivers/platform/x86/asus-wmi.h                    |   1 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c         |   2 +-
 drivers/platform/x86/inspur_platform_profile.c     | 216 ++++++
 drivers/platform/x86/intel/bytcrc_pwrsrc.c         |   5 +-
 drivers/platform/x86/intel/ifs/core.c              |  15 +-
 drivers/platform/x86/intel/ifs/ifs.h               |  64 +-
 drivers/platform/x86/intel/ifs/load.c              | 158 ++++-
 drivers/platform/x86/intel/ifs/runtest.c           |  72 +-
 .../platform/x86/intel/int3472/clk_and_regulator.c |  54 +-
 drivers/platform/x86/intel/int3472/common.h        |   7 +-
 drivers/platform/x86/intel/int3472/discrete.c      | 103 ++-
 drivers/platform/x86/intel/int3472/led.c           |  24 +-
 .../x86/intel/speed_select_if/isst_if_mmio.c       |  21 +-
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |  21 +-
 drivers/platform/x86/intel/tpmi.c                  |  81 ++-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |  18 +-
 drivers/platform/x86/mlx-platform.c                |  34 +-
 drivers/platform/x86/msi-ec.c                      | 483 +++++++++++++-
 drivers/platform/x86/msi-ec.h                      |   4 +-
 drivers/platform/x86/sel3350-platform.c            |   6 +-
 .../x86/siemens/simatic-ipc-batt-apollolake.c      |   6 +-
 .../x86/siemens/simatic-ipc-batt-elkhartlake.c     |   6 +-
 .../platform/x86/siemens/simatic-ipc-batt-f7188x.c |   6 +-
 drivers/platform/x86/siemens/simatic-ipc-batt.c    |   9 +-
 drivers/platform/x86/siemens/simatic-ipc-batt.h    |   4 +-
 drivers/platform/x86/think-lmi.c                   | 214 ++++--
 drivers/platform/x86/think-lmi.h                   |  16 +
 drivers/platform/x86/thinkpad_acpi.c               |  96 ++-
 drivers/platform/x86/wmi.c                         | 263 +++++---
 drivers/platform/x86/x86-android-tablets/asus.c    |   1 +
 drivers/platform/x86/x86-android-tablets/core.c    | 132 ++--
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  29 +-
 drivers/platform/x86/x86-android-tablets/other.c   |  11 +-
 .../x86/x86-android-tablets/x86-android-tablets.h  |   7 +-
 drivers/platform/x86/xo15-ebook.c                  |   9 +-
 include/linux/intel_tpmi.h                         |   6 +
 include/linux/platform_data/x86/asus-wmi.h         |   4 +
 include/linux/surface_aggregator/controller.h      |   2 +-
 include/trace/events/intel_ifs.h                   |  16 +-
 tools/power/x86/intel-speed-select/isst-config.c   | 213 ++++--
 tools/power/x86/intel-speed-select/isst-daemon.c   |   3 +-
 tools/power/x86/intel-speed-select/isst.h          |   3 +-
 71 files changed, 3347 insertions(+), 719 deletions(-)
 create mode 100644 drivers/platform/x86/inspur_platform_profile.c
