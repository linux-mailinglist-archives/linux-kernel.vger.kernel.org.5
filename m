Return-Path: <linux-kernel+bounces-28895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8583044E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1921F25F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAD1DDCB;
	Wed, 17 Jan 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMCb1y/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872F1DDCF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489968; cv=none; b=tUdy83j33tEybbdB9U5K3MdEyD2kyPd6ErrZ15Tq50e/RFXBGklY51d4/FL/wvmMfSARBYeeiCIW4qTgWVQmWA/9txCFXVWjdrTCL7/bquAe7g4nwUyvLezpW37OyZC+7LNWfm9jDcDvSkIRwUNlGzh6w3LCf+dVE4204KP51/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489968; c=relaxed/simple;
	bh=RuGCaJSXBiJ0//hsmZaWSf72Mp5fLLf9i+OWOkaFlGs=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding; b=rC4EA+PS7peOqhCyMKRJfDXvHxgkbwq0VdGfzeSA1Al9Kn5ShSRUpDKfDLdy2n/aVj25c/gNJYmGgWWOBBBq8fyZvT+xouGVCZXPmEP/ZbPdR5zuKvjI2M5KCw6PBfTjfoHD35JxbOEUkHES+DeFAB2y+CTE31K4inbHQXmjxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMCb1y/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C85C433C7;
	Wed, 17 Jan 2024 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705489968;
	bh=RuGCaJSXBiJ0//hsmZaWSf72Mp5fLLf9i+OWOkaFlGs=;
	h=Date:From:To:Cc:Subject:From;
	b=aMCb1y/kR4PsjfT8ejXuUf4UcHmPWnB/0Rz199+RnpSvm9yiLbIEgwbgUAjlEEyeA
	 J+36fjRkhtKj/OA3eYNKm9Fm57K2etb23rCF1U/dzYD4ITOGPSRsoJ36KanH8cx8qB
	 cfc4m4sQzjTCKi9bk4ffD9Se5E9CxMulTyUq7k1I=
Date: Wed, 17 Jan 2024 12:12:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.8-rc1
Message-ID: <Zae2LeqyFdjqb8mV@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.8-rc1

for you to fetch changes up to e3977e0609a07d86406029fceea0fd40d7849368:

  Revert "kernfs: convert kernfs_idr_lock to an irq safe raw spinlock" (2024-01-11 11:51:27 +0100)

----------------------------------------------------------------
Driver core changes for 6.8-rc1

Here are the set of driver core and kernfs changes for 6.8-rc1.  Nothing
major in here this release cycle, just lots of small cleanups and some
tweaks on kernfs that in the very end, got reverted and will come back
in a safer way next release cycle.

Included in here are:
  - more driver core 'const' cleanups and fixes
  - fw_devlink=rpm is now the default behavior
  - kernfs tiny changes to remove some string functions
  - cpu handling in the driver core is updated to work better on many
    systems that add topologies and cpus after booting
  - other minor changes and cleanups

All of the cpu handling patches have been acked by the respective
maintainers and are coming in here in one series.  Everything has been
in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
      kernfs: fix reference to renamed function

Al Viro (1):
      kernfs: d_obtain_alias(NULL) will do the right thing...

Alexander Graf (1):
      initramfs: Expose retained initrd as sysfs file

Andrea Righi (1):
      kernfs: convert kernfs_idr_lock to an irq safe raw spinlock

Andy Shevchenko (1):
      device property: Implement device_is_big_endian()

Christophe JAILLET (2):
      base: soc: Remove usage of the deprecated ida_simple_xx() API
      software node: Remove usage of the deprecated ida_simple_xx() API

Greg Kroah-Hartman (8):
      driver core: make device_is_dependent() static
      Merge tag 'device_is_big_endian-6.8-rc1' into driver-core-next
      driver core: bus: make bus_sort_breadthfirst() take a const pointer
      driver core: bus: constantify subsys_register() calls
      driver core: container: make container_subsys const
      driver core: mark remaining local bus_type variables as const
      EDAC: constantify the struct bus_type usage
      PM: clk: make pm_clk_add_notifier() take a const pointer

Gregory Price (1):
      base/node.c: initialize the accessor list before registering

James Morse (13):
      arch_topology: Make register_cpu_capacity_sysctl() tolerant to late CPUs
      x86: intel_epb: Don't rely on link order
      ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv
      drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
      drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
      drivers: base: Implement weak arch_unregister_cpu()
      drivers: base: Move cpu_dev_init() after node_dev_init()
      drivers: base: Print a warning instead of panic() when register_cpu() fails
      arm64: setup: Switch over to GENERIC_CPU_DEVICES using arch_register_cpu()
      x86/topology: Switch over to GENERIC_CPU_DEVICES
      LoongArch: Switch over to GENERIC_CPU_DEVICES
      LoongArch: Use the __weak version of arch_unregister_cpu()
      riscv: Switch over to GENERIC_CPU_DEVICES

Jing Xia (1):
      class: fix use-after-free in class_register()

Kees Cook (3):
      kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
      kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
      kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to strscpy()

Max Kellermann (2):
      kernel/cgroup: use kernfs_create_dir_ns()
      fs/kernfs/dir: obey S_ISGID

Mukesh Ojha (1):
      fs/sysfs/dir.c : Fix typo in comment

Randy Dunlap (2):
      driver core: class: fix Excess kernel-doc description warning
      driver core: device.h: fix Excess kernel-doc description warning

Russell King (Oracle) (8):
      x86/topology: remove arch_*register_cpu() exports
      Loongarch: remove arch_*register_cpu() exports
      drivers: base: add arch_cpu_is_hotpluggable()
      arm64: convert to arch_cpu_is_hotpluggable()
      x86/topology: use weak version of arch_unregister_cpu()
      x86/topology: convert to use arch_cpu_is_hotpluggable()
      LoongArch: convert to use arch_cpu_is_hotpluggable()
      riscv: convert to use arch_cpu_is_hotpluggable()

Sakari Ailus (3):
      acpi: property: Let args be NULL in __acpi_node_get_property_reference
      software node: Let args be NULL in software_node_get_reference_args
      device property: fwnode_property_get_reference_args allows NULL args now

Saravana Kannan (1):
      driver core: Enable fw_devlink=rpm by default

Tejun Heo (1):
      Revert "kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"

Uwe Kleine-König (2):
      driver core: Emit reason for pending deferred probe
      driver core: Better advertise dev_err_probe()

 Documentation/ABI/testing/sysfs-firmware-initrd |  8 ++++
 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 arch/arm64/Kconfig                              |  1 +
 arch/arm64/include/asm/cpu.h                    |  1 -
 arch/arm64/kernel/setup.c                       | 13 +-----
 arch/loongarch/Kconfig                          |  2 +
 arch/loongarch/kernel/topology.c                | 42 +----------------
 arch/riscv/Kconfig                              |  1 +
 arch/riscv/kernel/setup.c                       | 18 +------
 arch/x86/Kconfig                                |  2 +
 arch/x86/include/asm/cpu.h                      |  4 --
 arch/x86/kernel/cpu/intel_epb.c                 |  2 +-
 arch/x86/kernel/topology.c                      | 33 +------------
 drivers/acpi/Kconfig                            |  1 -
 drivers/acpi/acpi_processor.c                   | 18 -------
 drivers/acpi/property.c                         |  4 ++
 drivers/base/arch_topology.c                    | 38 ++++++++++-----
 drivers/base/auxiliary.c                        |  2 +-
 drivers/base/bus.c                              |  8 ++--
 drivers/base/class.c                            |  1 +
 drivers/base/container.c                        |  2 +-
 drivers/base/core.c                             | 13 +++---
 drivers/base/cpu.c                              | 39 ++++++++++++----
 drivers/base/dd.c                               |  2 +-
 drivers/base/init.c                             |  2 +-
 drivers/base/isa.c                              |  2 +-
 drivers/base/memory.c                           |  2 +-
 drivers/base/node.c                             | 11 +++--
 drivers/base/power/clock_ops.c                  |  2 +-
 drivers/base/power/domain.c                     |  2 +-
 drivers/base/property.c                         |  1 +
 drivers/base/soc.c                              |  6 +--
 drivers/base/swnode.c                           | 11 +++--
 drivers/edac/edac_device.h                      |  2 +-
 drivers/edac/edac_device_sysfs.c                |  2 +-
 drivers/edac/edac_module.c                      |  4 +-
 drivers/edac/edac_pci_sysfs.c                   |  2 +-
 fs/kernfs/dir.c                                 | 62 +++++++++++++++----------
 fs/kernfs/file.c                                |  2 +-
 fs/kernfs/mount.c                               |  3 --
 fs/sysfs/dir.c                                  |  2 +-
 include/linux/container.h                       |  2 +-
 include/linux/cpu.h                             |  5 ++
 include/linux/device.h                          |  8 ++--
 include/linux/device/bus.h                      |  2 +-
 include/linux/device/class.h                    |  2 -
 include/linux/edac.h                            |  4 +-
 include/linux/pm_clock.h                        |  4 +-
 include/linux/property.h                        | 26 +++++++++++
 init/initramfs.c                                | 18 ++++++-
 kernel/cgroup/cgroup-v1.c                       |  2 +-
 kernel/cgroup/cgroup.c                          | 35 +++-----------
 kernel/cgroup/cpuset.c                          |  2 +-
 53 files changed, 234 insertions(+), 254 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-initrd

