Return-Path: <linux-kernel+bounces-19465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A5826D62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837411C22300
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052132577E;
	Mon,  8 Jan 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNoWA/8K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4162575B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704715494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sun+r2tcYX/W4sYRW5ZK8dcc22WD7fKilClUHTX1T50=;
	b=XNoWA/8KM0q3upE21Fbt86b2ZA3a3x7hSyx5HmDcIDnBqWRu7UDQOHsYRdWHKALl9h0EIe
	szMLnpBsrMNVtaYG0iKignWXi5tJKmSiMSifPC2FsE642zZdpXgdnQUR9DOGvCVeUOFTJi
	FN71jIlkVaImyemIHUxu0R5nr38pZ/U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-eCB0EPSGOHijGLE_bp_pGw-1; Mon, 08 Jan 2024 07:04:53 -0500
X-MC-Unique: eCB0EPSGOHijGLE_bp_pGw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a28911570cfso76321666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715492; x=1705320292;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sun+r2tcYX/W4sYRW5ZK8dcc22WD7fKilClUHTX1T50=;
        b=Z/9GDDe9gKzZThFiDHhoDay/6ewydPOMJkaLBnApbh/FPSrRGBzV/6sHXkENu10IRH
         nU+qsZB6LFsizCno5o0GPszCvCxxL1CogLCBQOX+H89fQw+6/+fb1M3o7KNs5RxBGRtP
         ap88wf5T1d5jelR8Arpvg52VLfpBgUuQEllcoRClUt52pTKVG72QvC9AKfiCJFdg+cGv
         5V5H7N8T6KQZPX9TptNMw+wc1bf5x9SXYCsez+aYwijoLiCcoVpcgX1R4f8dtZPLGX3C
         D6Ft8gS4b+ZgP9XoZYcG1p/u4gjqMVFt3Bb0Jkg5y2l/u64n4HHUlLbPFUjnYLflm90X
         U4Og==
X-Gm-Message-State: AOJu0YwiU7Hwy2Gdwe2waIJLRUwsXjZob74rs/0sroWy+zdOJLAqsnFB
	dIg0utVRzDyRbdsJmdyLOS0EWpIhQLNxdt7DVk0JlzjL75T6J5/oSvQQilQ87b88dsN2fC9byfn
	Mg7/C5QQkyTgH25I/EnijPOznGdq+xpB8
X-Received: by 2002:a17:906:fd86:b0:a28:abc4:344d with SMTP id xa6-20020a170906fd8600b00a28abc4344dmr1702345ejb.151.1704715492229;
        Mon, 08 Jan 2024 04:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwde8LT8o/49Ff9biWae0a78SsGau0LkUtlIjPlke1Oqiql9yJqvRGrrmYIso8baT3aBf30A==
X-Received: by 2002:a17:906:fd86:b0:a28:abc4:344d with SMTP id xa6-20020a170906fd8600b00a28abc4344dmr1702336ejb.151.1704715491785;
        Mon, 08 Jan 2024 04:04:51 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906608900b00a2689e28445sm3841716ejj.106.2024.01.08.04.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 04:04:51 -0800 (PST)
Message-ID: <8fc798ad-7235-467e-a31f-a79ae33a4324@redhat.com>
Date: Mon, 8 Jan 2024 13:04:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.8-1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for 6.8.

Highlights:
 -  Intel PMC / PMT / TPMI / uncore-freq / vsec improvements and
    new platform support
 -  AMD PMC / PMF improvements and new platform support
 -  AMD ACPI based Wifi band RFI mitigation feature (WBRF)
 -  WMI bus driver cleanups and improvements (Armin Wolf)
 -  acer-wmi Predator PHN16-71 support
 -  New Silicom network appliance EC LEDs / GPIOs driver

Regards,

Hans


The following changes since commit 70681aa0746ae61d7668b9f651221fad5e30c71e:

  platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback (2023-12-29 15:31:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-1

for you to fetch changes up to 236f7d8034ff401d02fa6d74bae494a2b54e1834:

  platform/x86/amd/pmc: Modify SMU message port for latest AMD platform (2024-01-02 13:40:31 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.8-1

Highlights:
 -  Intel PMC / PMT / TPMI / uncore-freq / vsec improvements and
    new platform support
 -  AMD PMC / PMF improvements and new platform support
 -  AMD ACPI based Wifi band RFI mitigation feature (WBRF)
 -  WMI bus driver cleanups and improvements (Armin Wolf)
 -  acer-wmi Predator PHN16-71 support
 -  New Silicom network appliance EC LEDs / GPIOs driver

The following is an automated git shortlog grouped by driver:

ACPI:
 -  scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]

Add Silicom Platform Driver:
 - Add Silicom Platform Driver

Documentation/driver-api:
 -  Add document about WBRF mechanism

ISST:
 -  Process read/write blocked feature status

Merge tag 'platform-drivers-x86-amd-wbrf-v6.8-1' into review-hans:
 - Merge tag 'platform-drivers-x86-amd-wbrf-v6.8-1' into review-hans

Merge tag 'platform-drivers-x86-v6.7-3' into pdx86/for-next:
 - Merge tag 'platform-drivers-x86-v6.7-3' into pdx86/for-next

Merge tag 'platform-drivers-x86-v6.7-6' into pdx86/for-next:
 - Merge tag 'platform-drivers-x86-v6.7-6' into pdx86/for-next

Remove "X86 PLATFORM DRIVERS - ARCH" from MAINTAINERS:
 - Remove "X86 PLATFORM DRIVERS - ARCH" from MAINTAINERS

acer-wmi:
 -  add fan speed monitoring for Predator PHN16-71
 -  Depend on ACPI_VIDEO instead of selecting it
 -  Add platform profile and mode key support for Predator PHN16-71

asus-laptop:
 -  remove redundant braces in if statements

asus-wmi:
 -  Convert to platform remove callback returning void

clk:
 -  x86: lpss-atom: Drop unneeded 'extern' in the header

dell-smbios-wmi:
 -  Stop using WMI chardev
 -  Use devm_get_free_pages()

hp-bioscfg:
 -  Removed needless asm-generic

hp-wmi:
 -  Convert to platform remove callback returning void

intel-uncore-freq:
 -  Add additional client processors

intel-wmi-sbl-fw-update:
 -  Use bus-based WMI interface

intel/pmc:
 -  Call pmc_get_low_power_modes from platform init

ips:
 -  Remove unused debug code

platform/mellanox:
 -  mlxbf-tmfifo: Remove unnecessary bool conversion

platform/x86/amd:
 -  Add support for AMD ACPI based Wifi band RFI mitigation feature

platform/x86/amd/pmc:
 -  Modify SMU message port for latest AMD platform
 -  Add 1Ah family series to STB support list
 -  Add idlemask support for 1Ah family
 -  call amd_pmc_get_ip_info() during driver probe
 -  Add VPE information for AMDI000A platform
 -  Send OS_HINT command for AMDI000A platform

platform/x86/amd/pmf:
 -  Return a status code only as a constant in two functions
 -  Return directly after a failed apmf_if_call() in apmf_sbios_heartbeat_notify()
 -  dump policy binary data
 -  Add capability to sideload of policy binary
 -  Add facility to dump TA inputs
 -  Make source_as_str() as non-static
 -  Add support to update system state
 -  Add support update p3t limit
 -  Add support to get inputs from other subsystems
 -  change amd_pmf_init_features() call sequence
 -  Add support for PMF Policy Binary
 -  Change return type of amd_pmf_set_dram_addr()
 -  Add support for PMF-TA interaction
 -  Add PMF TEE interface

platform/x86/dell:
 -  alienware-wmi: Use kasprintf()

platform/x86/intel-uncore-freq:
 -  Process read/write blocked feature status

platform/x86/intel/pmc:
 -  Add missing extern
 -  Add Lunar Lake M support to intel_pmc_core driver
 -  Add Arrow Lake S support to intel_pmc_core driver
 -  Add ssram_init flag in PMC discovery in Meteor Lake
 -  Move common code to core.c
 -  Add PSON residency counter for Alder Lake
 -  Add regmap for Tiger Lake H PCH
 -  Add PSON residency counter
 -  Fix in mtl_punit_pmt_init()
 -  Fix in pmc_core_ssram_get_pmc()
 -  Show Die C6 counter on Meteor Lake
 -  Add debug attribute for Die C6 counter
 -  Read low power mode requirements for MTL-M and MTL-P
 -  Retrieve LPM information using Intel PMT
 -  Display LPM requirements for multiple PMCs
 -  Find and register PMC telemetry entries
 -  Cleanup SSRAM discovery
 -  Allow pmc_core_ssram_init to fail

platform/x86/intel/pmc/arl:
 -  Add GBE LTR ignore during suspend

platform/x86/intel/pmc/lnl:
 -  Add GBE LTR ignore during suspend

platform/x86/intel/pmc/mtl:
 -  Use return value from pmc_core_ssram_init()

platform/x86/intel/pmt:
 -  telemetry: Export API to read telemetry
 -  Add header to struct intel_pmt_entry

platform/x86/intel/tpmi:
 -  Move TPMI ID definition
 -  Modify external interface to get read/write state
 -  Don't create devices for disabled features

platform/x86/intel/vsec:
 -  Add support for Lunar Lake M
 -  Add base address field
 -  Add intel_vsec_register
 -  Assign auxdev parent by argument
 -  Use cleanup.h
 -  remove platform_info from vsec device structure
 -  Move structures to header
 -  Remove unnecessary return
 -  Fix xa_alloc memory leak

platform/x86/intel/wmi:
 -  thunderbolt: Use bus-based WMI interface

silicom-platform:
 -  Fix spelling mistake "platfomr" -> "platform"

wmi:
 -  linux/wmi.h: fix Excess kernel-doc description warning
 -  Simplify get_subobj_info()
 -  Decouple ACPI notify handler from wmi_block_list
 -  Create WMI bus device first
 -  Use devres for resource handling
 -  Remove ACPI handlers after WMI devices
 -  Remove unused variable in address space handler
 -  Remove chardev interface
 -  Remove debug_event module param
 -  Remove debug_dump_wdg module param
 -  Add to_wmi_device() helper macro
 -  Add wmidev_block_set()

x86-android-tablets:
 -  Fix an IS_ERR() vs NULL check in probe
 -  Fix backlight ctrl for Lenovo Yoga Tab 3 Pro YT3-X90F
 -  Add audio codec info for Lenovo Yoga Tab 3 Pro YT3-X90F
 -  Add support for SPI device instantiation

----------------------------------------------------------------
Andy Shevchenko (2):
      clk: x86: lpss-atom: Drop unneeded 'extern' in the header
      platform/x86: Remove "X86 PLATFORM DRIVERS - ARCH" from MAINTAINERS

Armin Wolf (15):
      platform/x86: wmi: Add wmidev_block_set()
      platform/x86: wmi: Add to_wmi_device() helper macro
      platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI interface
      platform/x86/intel/wmi: thunderbolt: Use bus-based WMI interface
      platform/x86: wmi: Remove debug_dump_wdg module param
      platform/x86: wmi: Remove debug_event module param
      platform/x86: dell-smbios-wmi: Use devm_get_free_pages()
      platform/x86: dell-smbios-wmi: Stop using WMI chardev
      platform/x86: wmi: Remove chardev interface
      platform/x86: wmi: Remove unused variable in address space handler
      platform/x86: wmi: Remove ACPI handlers after WMI devices
      platform/x86: wmi: Use devres for resource handling
      platform/x86: wmi: Create WMI bus device first
      platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
      platform/x86: wmi: Simplify get_subobj_info()

Christophe JAILLET (1):
      platform/x86/dell: alienware-wmi: Use kasprintf()

Colin Ian King (1):
      platform/x86: silicom-platform: Fix spelling mistake "platfomr" -> "platform"

Dan Carpenter (1):
      platform/x86: x86-android-tablets: Fix an IS_ERR() vs NULL check in probe

David E. Box (18):
      platform/x86/intel/vsec: Fix xa_alloc memory leak
      platform/x86/intel/vsec: Remove unnecessary return
      platform/x86/intel/vsec: Move structures to header
      platform/x86/intel/vsec: remove platform_info from vsec device structure
      platform/x86/intel/vsec: Use cleanup.h
      platform/x86/intel/vsec: Assign auxdev parent by argument
      platform/x86/intel/vsec: Add base address field
      platform/x86/intel/pmt: Add header to struct intel_pmt_entry
      platform/x86/intel/pmt: telemetry: Export API to read telemetry
      platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
      platform/x86/intel/pmc: Cleanup SSRAM discovery
      platform/x86/intel/pmc/mtl: Use return value from pmc_core_ssram_init()
      platform/x86/intel/pmc: Find and register PMC telemetry entries
      platform/x86/intel/pmc: Add debug attribute for Die C6 counter
      platform/x86/intel/pmc: Show Die C6 counter on Meteor Lake
      platform/x86/intel/pmc/arl: Add GBE LTR ignore during suspend
      platform/x86/intel/pmc/lnl: Add GBE LTR ignore during suspend
      platform/x86/intel/pmc: Add missing extern

Edson Juliano Drosdeck (1):
      platform/x86: asus-laptop: remove redundant braces in if statements

Gayatri Kammela (1):
      platform/x86/intel/vsec: Add intel_vsec_register

Hans de Goede (7):
      ACPI: scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]
      platform/x86: x86-android-tablets: Add support for SPI device instantiation
      platform/x86: x86-android-tablets: Add audio codec info for Lenovo Yoga Tab 3 Pro YT3-X90F
      platform/x86: x86-android-tablets: Fix backlight ctrl for Lenovo Yoga Tab 3 Pro YT3-X90F
      Merge tag 'platform-drivers-x86-v6.7-3' into pdx86/for-next
      Merge tag 'platform-drivers-x86-amd-wbrf-v6.8-1' into review-hans
      Merge tag 'platform-drivers-x86-v6.7-6' into pdx86/for-next

Henry Shi (1):
      platform/x86: Add Silicom Platform Driver

Ilpo Järvinen (1):
      platform/x86: ips: Remove unused debug code

Jules Irenge (1):
      platform/mellanox: mlxbf-tmfifo: Remove unnecessary bool conversion

Ma Jun (2):
      Documentation/driver-api: Add document about WBRF mechanism
      platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature

Markus Elfring (2):
      platform/x86/amd/pmf: Return directly after a failed apmf_if_call() in apmf_sbios_heartbeat_notify()
      platform/x86/amd/pmf: Return a status code only as a constant in two functions

Rajvi Jingar (11):
      platform/x86/intel/pmc: Display LPM requirements for multiple PMCs
      platform/x86/intel/vsec: Add support for Lunar Lake M
      platform/x86/intel/pmc: Fix in pmc_core_ssram_get_pmc()
      platform/x86/intel/pmc: Fix in mtl_punit_pmt_init()
      platform/x86/intel/pmc: Add PSON residency counter
      platform/x86/intel/pmc: Add regmap for Tiger Lake H PCH
      platform/x86/intel/pmc: Add PSON residency counter for Alder Lake
      platform/x86/intel/pmc: Move common code to core.c
      platform/x86/intel/pmc: Add ssram_init flag in PMC discovery in Meteor Lake
      platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver
      platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver

Randy Dunlap (1):
      platform/x86: wmi: linux/wmi.h: fix Excess kernel-doc description warning

Shyam Sundar S K (18):
      platform/x86/amd/pmf: Add PMF TEE interface
      platform/x86/amd/pmf: Add support for PMF-TA interaction
      platform/x86/amd/pmf: Change return type of amd_pmf_set_dram_addr()
      platform/x86/amd/pmf: Add support for PMF Policy Binary
      platform/x86/amd/pmf: change amd_pmf_init_features() call sequence
      platform/x86/amd/pmf: Add support to get inputs from other subsystems
      platform/x86/amd/pmf: Add support update p3t limit
      platform/x86/amd/pmf: Add support to update system state
      platform/x86/amd/pmf: Make source_as_str() as non-static
      platform/x86/amd/pmf: Add facility to dump TA inputs
      platform/x86/amd/pmf: Add capability to sideload of policy binary
      platform/x86/amd/pmf: dump policy binary data
      platform/x86/amd/pmc: Send OS_HINT command for AMDI000A platform
      platform/x86/amd/pmc: Add VPE information for AMDI000A platform
      platform/x86/amd/pmc: call amd_pmc_get_ip_info() during driver probe
      platform/x86/amd/pmc: Add idlemask support for 1Ah family
      platform/x86/amd/pmc: Add 1Ah family series to STB support list
      platform/x86/amd/pmc: Modify SMU message port for latest AMD platform

Srinivas Pandruvada (6):
      platform/x86/intel/tpmi: Don't create devices for disabled features
      platform/x86/intel/tpmi: Modify external interface to get read/write state
      platform/x86/intel/tpmi: Move TPMI ID definition
      platform/x86: ISST: Process read/write blocked feature status
      platform/x86/intel-uncore-freq: Process read/write blocked feature status
      platform/x86: intel-uncore-freq: Add additional client processors

SungHwan Jung (3):
      platform/x86: acer-wmi: Add platform profile and mode key support for Predator PHN16-71
      platform/x86: acer-wmi: Depend on ACPI_VIDEO instead of selecting it
      platform/x86: acer-wmi: add fan speed monitoring for Predator PHN16-71

Tanzir Hasan (1):
      platform/x86: hp-bioscfg: Removed needless asm-generic

Uwe Kleine-König (2):
      platform/x86: asus-wmi: Convert to platform remove callback returning void
      platform/x86: hp-wmi: Convert to platform remove callback returning void

Xi Pardee (3):
      platform/x86:intel/pmc: Call pmc_get_low_power_modes from platform init
      platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
      platform/x86/intel/pmc: Read low power mode requirements for MTL-M and MTL-P

 Documentation/ABI/testing/sysfs-platform-silicom   |   29 +
 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/pmf.rst                  |   24 +
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/wbrf.rst                  |   78 ++
 MAINTAINERS                                        |    9 -
 drivers/acpi/scan.c                                |    1 +
 drivers/platform/mellanox/mlxbf-tmfifo.c           |    2 +-
 drivers/platform/x86/Kconfig                       |   19 +-
 drivers/platform/x86/Makefile                      |    3 +
 drivers/platform/x86/acer-wmi.c                    |  377 +++++++-
 drivers/platform/x86/amd/Kconfig                   |   14 +
 drivers/platform/x86/amd/Makefile                  |    1 +
 drivers/platform/x86/amd/pmc/pmc.c                 |   25 +-
 drivers/platform/x86/amd/pmc/pmc.h                 |    1 +
 drivers/platform/x86/amd/pmf/Kconfig               |    1 +
 drivers/platform/x86/amd/pmf/Makefile              |    3 +-
 drivers/platform/x86/amd/pmf/acpi.c                |   56 +-
 drivers/platform/x86/amd/pmf/core.c                |   54 +-
 drivers/platform/x86/amd/pmf/pmf.h                 |  203 ++++
 drivers/platform/x86/amd/pmf/spc.c                 |  158 +++
 drivers/platform/x86/amd/pmf/sps.c                 |    5 +-
 drivers/platform/x86/amd/pmf/tee-if.c              |  472 +++++++++
 drivers/platform/x86/amd/wbrf.c                    |  317 ++++++
 drivers/platform/x86/asus-laptop.c                 |    3 +-
 drivers/platform/x86/asus-wmi.c                    |    5 +-
 drivers/platform/x86/dell/alienware-wmi.c          |    4 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c        |  171 +++-
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c       |    1 -
 drivers/platform/x86/hp/hp-wmi.c                   |    6 +-
 drivers/platform/x86/intel/pmc/Kconfig             |    1 +
 drivers/platform/x86/intel/pmc/Makefile            |    2 +-
 drivers/platform/x86/intel/pmc/adl.c               |    4 +
 drivers/platform/x86/intel/pmc/arl.c               |  729 ++++++++++++++
 drivers/platform/x86/intel/pmc/cnp.c               |    2 +
 drivers/platform/x86/intel/pmc/core.c              |  269 ++++--
 drivers/platform/x86/intel/pmc/core.h              |   89 +-
 drivers/platform/x86/intel/pmc/core_ssram.c        |  267 +++++-
 drivers/platform/x86/intel/pmc/icl.c               |   10 +-
 drivers/platform/x86/intel/pmc/lnl.c               |  549 +++++++++++
 drivers/platform/x86/intel/pmc/mtl.c               |   86 +-
 drivers/platform/x86/intel/pmc/spt.c               |   10 +-
 drivers/platform/x86/intel/pmc/tgl.c               |   48 +-
 drivers/platform/x86/intel/pmt/class.c             |   43 +-
 drivers/platform/x86/intel/pmt/class.h             |   30 +-
 drivers/platform/x86/intel/pmt/crashlog.c          |    2 +-
 drivers/platform/x86/intel/pmt/telemetry.c         |  193 +++-
 drivers/platform/x86/intel/pmt/telemetry.h         |  126 +++
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |   25 +
 drivers/platform/x86/intel/tpmi.c                  |   35 +-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |   15 +
 .../x86/intel/uncore-frequency/uncore-frequency.c  |   13 +
 drivers/platform/x86/intel/vsec.c                  |  129 +--
 drivers/platform/x86/intel/vsec.h                  |   45 +-
 drivers/platform/x86/intel/wmi/sbl-fw-update.c     |   13 +-
 drivers/platform/x86/intel/wmi/thunderbolt.c       |    3 +-
 drivers/platform/x86/intel_ips.c                   |   33 -
 drivers/platform/x86/silicom-platform.c            | 1004 ++++++++++++++++++++
 drivers/platform/x86/wmi.c                         |  492 +++-------
 drivers/platform/x86/x86-android-tablets/core.c    |   62 ++
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  124 ++-
 .../x86/x86-android-tablets/x86-android-tablets.h  |    9 +
 include/linux/acpi_amd_wbrf.h                      |   91 ++
 include/linux/intel_tpmi.h                         |   18 +-
 include/linux/platform_data/x86/clk-lpss.h         |    2 +-
 include/linux/wmi.h                                |   20 +-
 66 files changed, 5842 insertions(+), 795 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-silicom
 create mode 100644 Documentation/admin-guide/pmf.rst
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/pmf/spc.c
 create mode 100644 drivers/platform/x86/amd/pmf/tee-if.c
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 drivers/platform/x86/intel/pmc/arl.c
 create mode 100644 drivers/platform/x86/intel/pmc/lnl.c
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h
 create mode 100644 drivers/platform/x86/silicom-platform.c
 create mode 100644 include/linux/acpi_amd_wbrf.h


