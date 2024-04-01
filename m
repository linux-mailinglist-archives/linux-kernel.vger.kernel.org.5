Return-Path: <linux-kernel+bounces-126847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9D893F09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA91F21B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1A47A57;
	Mon,  1 Apr 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z7z8+1EN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF93F8F4;
	Mon,  1 Apr 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987865; cv=none; b=fqAcMN1ZfRFufbMbFmQULl6aX76oxjo4/N2qnLSYZUtM08zfTp59rQ2INK86jVoBHKMsxwTcOGZbIk7PKpaB1vD+FJBYMMvhIYssN/4Ga1wBtEBkjHGvnaY9KQgb6APuXs1aaeLHZq7JEz1Hhrz7izEmbiM8nqYsGEm4OT8Buwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987865; c=relaxed/simple;
	bh=+9WdLo1cEp3vc9b9atdAliQ5B+YhCyuUjfjsKHLGrL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nDzICZi4jL8Bfm8+Sp+vymvOla7pLvZ/ld1WOKIbQW9cF9hsInZRg+PLAidmbk8jsm+PbRS6cUncrR2P+xvUCXNhCW3nlSD5dzrR9oPfwIMj+R9CxveQGixucB97orcfELUkKj9jrQbrUybp+pEbu7/WWzdqo6pk9Fe+3a3Xvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z7z8+1EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247BBC433C7;
	Mon,  1 Apr 2024 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987865;
	bh=+9WdLo1cEp3vc9b9atdAliQ5B+YhCyuUjfjsKHLGrL4=;
	h=From:To:Cc:Subject:Date:From;
	b=z7z8+1ENxuaWMnaH3G0RuvMHvMxL0xKsg18hoi/RD3MTvzcLag3x9ZhRuLLXBrcSw
	 R7N/LU58F8geIcnkq09S3cdB4Lmh1Uj51QdizJagi9m5pjCzL4FYgaZSDCpGoVQDYE
	 YAV4T0uZzJeUsDFnF+y2uie9r7TurGa28yRX8FdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 6.7 000/432] 6.7.12-rc1 review
Date: Mon,  1 Apr 2024 17:39:47 +0200
Message-ID: <20240401152553.125349965@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.12-rc1
X-KernelTest-Deadline: 2024-04-03T15:26+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Note, this will be the LAST 6.7.y kernel release.  After this one it
will be end-of-life.  Please move to 6.8.y now.

------------------------------------------

This is the start of the stable review cycle for the 6.7.12 release.
There are 432 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.7.12-rc1

Natanael Copa <ncopa@alpinelinux.org>
    tools/resolve_btfids: fix build with musl libc

Kevin Loughlin <kevinloughlin@google.com>
    x86/sev: Skip ROM range scans and validation for SEV-SNP guests

Xingui Yang <yangxingui@huawei.com>
    scsi: libsas: Fix disk not being scanned in after being removed

Muhammad Usama Anjum <usama.anjum@collabora.com>
    scsi: lpfc: Correct size for wqe for memset()

Xingui Yang <yangxingui@huawei.com>
    scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()

Muhammad Usama Anjum <usama.anjum@collabora.com>
    scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: dwc3: pci: Drop duplicate ID

Dave Hansen <dave.hansen@linux.intel.com>
    Revert "x86/bugs: Use fixed addressing for VERW operand"

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bugs: Use fixed addressing for VERW operand

Baoquan He <bhe@redhat.com>
    crash: use macro to add crashk_res into iomem early for specific arch

Borislav Petkov (AMD) <bp@alien8.de>
    x86/bugs: Fix the SRSO mitigation on Zen3/4

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Delay I/O Abort on PCI error

Saurav Kashyap <skashyap@marvell.com>
    scsi: qla2xxx: Change debug message during driver unload

Saurav Kashyap <skashyap@marvell.com>
    scsi: qla2xxx: Fix double free of fcport

Saurav Kashyap <skashyap@marvell.com>
    scsi: qla2xxx: Fix double free of the ha->vp_map pointer

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix command flush on cable pull

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: NVME|FCP prefer flag not being honored

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Update manufacturer detail

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Split FCE|EFT trace control

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix N2N stuck connection

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Prevent command send on chip reset

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi_acpi: Refactor and fix DELL quirk

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Ack unsupported commands

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Check for notifications after init

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Clear EVENT_PENDING under PPM lock

Kyle Tso <kyletso@google.com>
    usb: typec: Return size of buffer if pd_set operation succeeds

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: typec: ucsi: Fix race between typec_switch and role_switch

yuan linyu <yuanlinyu@hihonor.com>
    usb: udc: remove warning when queue disabled ep

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: gadget: LPM flow fix

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: gadget: Fix exiting from clock gating

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix ISOC flow in DDMA mode

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix hibernation flow

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix remote wakeup from hibernation

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix deadlock in port "disable" sysfs attribute

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Add hub_get() and hub_put() routines

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix deadlock in usb_deauthorize_interface()

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Properly set system wakeup

Dan Carpenter <dan.carpenter@linaro.org>
    staging: vc04_services: fix information leak in create_component()

Arnd Bergmann <arnd@arndb.de>
    staging: vc04_services: changen strncpy() to strscpy_pad()

Guilherme G. Piccoli <gpiccoli@igalia.com>
    scsi: core: Fix unremoved procfs host directory regression

Alexander Wetzel <Alexander@wetzel-home.de>
    scsi: sg: Avoid sg device teardown race

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Fix TCG OPAL unlock on system resume

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    scsi: ufs: qcom: Provide default cycles_in_1us value

Duoming Zhou <duoming@zju.edu.cn>
    ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Brett Creeley <brett.creeley@amd.com>
    vfio/pds: Make sure migration file isn't accessed after reset

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu/display: Address kdoc for 'is_psr_su' in 'fill_dc_dirty_rects'

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amdgpu: make damage clips support configurable

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: set odm_combine_policy based on context in dcn32 resource

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    USB: UAS: return ENODEV when submit urbs fail with device not attached

Yongzhi Liu <hyperlyzcs@gmail.com>
    usb: misc: ljca: Fix double free in error handling path

Oliver Neukum <oneukum@suse.com>
    usb: cdc-wdm: close race between read and workqueue

Alexander Stein <alexander.stein@ew.tq-group.com>
    Revert "usb: phy: generic: Get the vbus supply"

Ezra Buehler <ezra.buehler@husqvarnagroup.com>
    mtd: spinand: Add support for 5-byte IDs

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

Roman Li <roman.li@amd.com>
    drm/amd/display: Fix bounds check for dcn35 DcfClocks

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/gt: Reset queue_priority_hint on parking

Jonathon Hall <jonathon.hall@puri.sm>
    drm/i915: Do not match JSL in ehl_combo_pll_div_frac_wa_needed()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/dsb: Fix DSB vblank waits when using VRR

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/dsi: Go back to the previous INIT_OTP/DISPLAY_ON order, mostly

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/vrr: Generate VRR "safe window" for DSB

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/bios: Tolerate devdata==NULL in intel_bios_encoder_supports_dp_dual_mode()

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    drm/i915/hwmon: Fix locking inversion in sysfs getter

Xi Liu <xi.liu@amd.com>
    drm/amd/display: Set DCN351 BB and IP the same as DCN35

George Shen <george.shen@amd.com>
    drm/amd/display: Remove MPC rate control logic from DCN30 and above

Johannes Weiner <hannes@cmpxchg.org>
    drm/amdgpu: fix deadlock while reading mqd from debugfs

Eric Huang <jinhuieric.huang@amd.com>
    drm/amdkfd: fix TLB flush after unmap for GFX9.4.2

Jocelyn Falempe <jfalempe@redhat.com>
    drm/vmwgfx: Create debugfs ttm_resource_manager entry only if needed

Claus Hansen Ries <chr@terma.com>
    net: ll_temac: platform_get_resource replaced by wrong function

Duoming Zhou <duoming@zju.edu.cn>
    nouveau/dmem: handle kcalloc() allocation failure

Ye Zhang <ye.zhang@rock-chips.com>
    thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

Damien Le Moal <dlemoal@kernel.org>
    block: Do not force full zone append completion in req_bio_endio()

Liming Sun <limings@nvidia.com>
    sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Avoid negative index with array access

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Initialize mmc_blk_ioc_data

Romain Naour <romain.naour@skf.com>
    mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode

Edward Liaw <edliaw@google.com>
    selftests/mm: fix ARM related issue with fork after pthread_create

Edward Liaw <edliaw@google.com>
    selftests/mm: sigbus-wp test requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM

Johannes Weiner <hannes@cmpxchg.org>
    mm: cachestat: fix two shmem bugs

Nathan Chancellor <nathan@kernel.org>
    hexagon: vmlinux.lds.S: handle attributes section

Max Filippov <jcmvbkbc@gmail.com>
    exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: cdev: sanitize the label before requesting the interrupt

Harry Wentland <harry.wentland@amd.com>
    Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR"

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: handle debugfs names more carefully

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: don't always use FW dump trig

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: disable MLO for the time being

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: add a flag to disable wireless extensions

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: zoned: use zone aware sb location for scrub

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: zoned: don't skip block groups with 100% zone unusable

Tavian Barnes <tavianator@tavianator.com>
    btrfs: fix race in read_extent_buffer_pages()

Anand Jain <anand.jain@oracle.com>
    btrfs: validate device maj:min during open

Carlos Maiolino <cem@kernel.org>
    tmpfs: fix race on handling dquot rbtree

Zev Weiss <zev@bewilderbeest.net>
    ARM: prctl: reject PR_SET_MDWE on pre-ARMv6

Zev Weiss <zev@bewilderbeest.net>
    prctl: generalize PR_SET_MDWE support check to be per-arch

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Reinstate soft limit for initrd loading

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Cast away type warning in use of max()

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Add missing boot_params for mixed mode compat entry

John Sperbeck <jsperbeck@google.com>
    init: open /initrd.image with O_LARGEFILE

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: add locks to kcontrols

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: remove digital gain kcontrol

Chris Park <chris.park@amd.com>
    drm/amd/display: Prevent crash when disable stream

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Suppress old PLL pipe_mask checks for MG/TC/TBT PLLs

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Include the PLL name in the debug messages

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Try to preserve the current shared_dpll for fastset on type-c ports

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Replace a memset() with zero initialization

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Use named initializers for DPLL info

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Stop printing pipe name as hex

Kan Liang <kan.liang@linux.intel.com>
    perf top: Use evsel's cpus to replace user_requested_cpus

Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
    mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530

Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
    mfd: intel-lpss: Switch to generalized quirk table

Anand Jain <anand.jain@oracle.com>
    btrfs: do not skip re-registration for the mounted device

Vitaly Chikunov <vt@altlinux.org>
    selftests/mm: Fix build with _FORTIFY_SOURCE

Muhammad Usama Anjum <usama.anjum@collabora.com>
    selftests/mm: gup_test: conform test to TAP format output

Zoltan HERPAI <wigyori@uid0.hu>
    pwm: img: fix pwm clock lookup

Oleksandr Tymoshenko <ovt@google.com>
    efi: fix panic in kdump kernel

Adamos Ttofari <attofari@amazon.de>
    x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

Thomas Gleixner <tglx@linutronix.de>
    x86/mpparse: Register APIC address only once

KONDO KAZUMA(近藤　和真) <kazuma-kondo@nec.com>
    efi/libstub: fix efi_random_alloc() to allocate memory at alloc_min or higher address

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address

Biju Das <biju.das.jz@bp.renesas.com>
    irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type

Biju Das <biju.das.jz@bp.renesas.com>
    irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()

Biju Das <biju.das.jz@bp.renesas.com>
    irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index

Biju Das <biju.das.jz@bp.renesas.com>
    irqchip/renesas-rzg2l: Flush posted write in irq_eoi()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    irqchip/renesas-rzg2l: Implement restriction when writing ISCR register

John Ogness <john.ogness@linutronix.de>
    printk: Update @console_may_schedule in console_trylock_spinning()

Nicolin Chen <nicolinc@nvidia.com>
    iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

Will Deacon <will@kernel.org>
    swiotlb: Fix alignment checks when both allocation and DMA masks are present

Will Deacon <will@kernel.org>
    swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()

Will Deacon <will@kernel.org>
    swiotlb: Fix double-allocation of slots due to broken alignment handling

André Rösti <an.roesti@gmail.com>
    entry: Respect changes to system call number by trace_sys_enter()

Yongqiang Liu <liuyongqiang13@huawei.com>
    ARM: 9359/1: flush: check if the folio is reserved for no-mapping addresses

Ard Biesheuvel <ardb@kernel.org>
    ARM: 9352/1: iwmmxt: Remove support for PJ4/PJ4B cores

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clocksource/drivers/arm_global_timer: Fix maximum prescaler value

Ard Biesheuvel <ardb@kernel.org>
    x86/sev: Fix position dependent variable references in startup code

Borislav Petkov (AMD) <bp@alien8.de>
    x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT

Josef Bacik <josef@toxicpanda.com>
    btrfs: fix deadlock with fiemap and extent locking

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtw88: 8821cu: Fix connection failure

Linus Torvalds <torvalds@linux-foundation.org>
    Fix memory leak in posix_clock_open()

Jiawei Wang <me@jwang.link>
    ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Call mixed mode boot services on the firmware's stack

Li Ma <li.ma@amd.com>
    drm/amd/swsmu: modify the gfx activity scaling

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/display: handle range offsets in VRR ranges

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Don't explode when the dig port we don't have an AUX CH

Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
    iio: imu: inv_mpu6050: fix FIFO parsing when empty

Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
    iio: imu: inv_mpu6050: fix frequency setting when chip is off

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Avoid potential double call to gpiod_remove_lookup_table

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Fix using mux_pdev before it's set

Cosmin Tanislav <demonsingur@gmail.com>
    iio: accel: adxl367: fix I2C FIFO data register

Cosmin Tanislav <demonsingur@gmail.com>
    iio: accel: adxl367: fix DEVID read after reset

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed

Vlastimil Babka <vbabka@suse.cz>
    mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Fabio Estevam <festevam@denx.de>
    ARM: imx_v6_v7_defconfig: Restore CONFIG_BACKLIGHT_CLASS_DEVICE

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix kernel panic caused by incorrect error handling

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add Headset Mic supported Acer NB platform

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Douglas Anderson <dianders@chromium.org>
    Revert "tty: serial: simplify qcom_geni_serial_send_chunk_fifo()"

Nicolas Pitre <nico@fluxnic.net>
    vt: fix unicode buffer corruption when deleting characters

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point H DID

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point S DID

Yicong Yang <yangyicong@hisilicon.com>
    serial: port: Don't suspend if the port is still busy

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Pass proper arguments to scm call

Hans de Goede <hdegoede@redhat.com>
    misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume

Peter Collingbourne <pcc@google.com>
    serial: 8250_dw: Do not reclock if already at correct rate

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix failure to detect ring expansion need.

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: port: Don't try to peer unused USB ports based on location

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Fix handling of zero block length packets

RD Babiera <rdbabiera@google.com>
    usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group

Alan Stern <stern@rowland.harvard.edu>
    USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform

Nirmoy Das <nirmoy.das@intel.com>
    drm/i915: Check before removing mm notifier

Rickard x Andersson <rickaran@axis.com>
    tty: serial: imx: Fix broken RS485

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Fix the error of pwm1_enable setting

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Use .flush() call to wake up readers

Paolo Bonzini <pbonzini@redhat.com>
    SEV: disable SEV-ES DebugSwap by default

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()

Sean Christopherson <seanjc@google.com>
    KVM: x86: Mark target gfn of emulated atomic instruction as dirty

Edmund Raile <edmund.raile@proton.me>
    firewire: ohci: prevent leak of left-over IRQ on unbind

Kees Cook <keescook@chromium.org>
    init/Kconfig: lower GCC version check for -Warray-bounds

Max Nguyen <maxwell.nguyen@hp.com>
    Input: xpad - add additional HyperX Controller Identifiers

Waiman Long <longman@redhat.com>
    cgroup/cpuset: Fix a memory leak in update_exclusive_cpumask()

Kamalesh Babulal <kamalesh.babulal@oracle.com>
    cgroup/cpuset: Fix retval in update_cpumask()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Fix NULL pointer dereference in tb_port_update_credits()

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Vlastimil Babka <vbabka@suse.cz>
    mm, mmap: fix vma_merge() case 7 with vma_ops->close

Nathan Chancellor <nathan@kernel.org>
    xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Eric Biggers <ebiggers@google.com>
    Revert "crypto: pkcs7 - remove sha1 support"

Andrey Skvortsov <andrej.skvortzov@gmail.com>
    crypto: sun8i-ce - Fix use after free in unprepare

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: rk3288 - Fix use after free in unprepare

Karol Herbst <kherbst@redhat.com>
    drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf

Dave Airlie <airlied@redhat.com>
    nouveau: lock the client object tree.

Michael Kelley <mhklinux@outlook.com>
    Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject constant set with timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow anonymous set with timeout flag

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Use freesync when `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found

Audra Mitchell <audra@redhat.com>
    workqueue: Shorten events_freezable_power_efficient name

Jani Nikula <jani.nikula@intel.com>
    drm/bridge: lt8912b: do not return negative values from .get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/bridge: lt8912b: clear the EDID property on failures

Jani Nikula <jani.nikula@intel.com>
    drm/bridge: lt8912b: use drm_bridge_edid_read()

Jani Nikula <jani.nikula@intel.com>
    drm/bridge: add ->edid_read hook and drm_bridge_edid_read()

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Create persistent INTx handler

Alex Williamson <alex.williamson@redhat.com>
    vfio: Introduce interface to flush virqfd inject workqueue

Zack Rusin <zack.rusin@broadcom.com>
    drm/ttm: Make sure the mapped tt pages are decrypted when needed

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: Demote vendor-specific attach/detach messages to info

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: cfg80211: Use WSEC to set SAE password

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmfmac: add per-vendor feature detection callback

Anton Altaparmakov <anton@tuxera.com>
    x86/pm: Work around false positive kmemleak report in msr_build_context()

Mikulas Patocka <mpatocka@redhat.com>
    dm snapshot: fix lockup in dm_exception_table_exit

Leo Ma <hanghong.ma@amd.com>
    drm/amd/display: Fix noise issue on HDMI AV mute

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Return the correct HDCP error code

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Fix idle check for shared firmware state

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: Update odm when ODM combine is changed on an otg master pipe with no plane

Dillon Varone <dillon.varone@amd.com>
    drm/amd/display: Init DPPCLK from SMU on dcn32

Dillon Varone <dillon.varone@amd.com>
    drm/amd/display: Add dml2 copy functions

Josip Pavic <josip.pavic@amd.com>
    drm/amd/display: Allow dirty rects to be sent to dmub when abm is active

Sohaib Nadeem <sohaib.nadeem@amd.com>
    drm/amd/display: Override min required DCFCLK in dml1_validate

Relja Vojvodic <relja.vojvodic@amd.com>
    drm/amd/display: Add ODM check during pipe split/merge validation

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Check the validity of overdiver power limit

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Fix NULL pointer dereference when get power limit

Philip Yang <Philip.Yang@amd.com>
    drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Swapnil Patel <swapnil.patel@amd.com>
    drm/amd/display: Change default size for dummy plane in DML2

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1064: asm1166: don't limit reported ports

Andrey Jr. Melnikov <temnota.am@gmail.com>
    ahci: asm1064: correct count of reported ports

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: access device through ctx instead of peer

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: check for dangling peer via is_dead instead of empty list

Yuli Wang <wangyuli@uniontech.com>
    LoongArch/crypto: Clean up useless assignment operations

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Define the __io_aw() hook as mmiowb()

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Change __my_cpu_offset definition to avoid mis-optimization

David Hildenbrand <david@redhat.com>
    virtio: reenable config if freezing device failed

Feng Liu <feliu@nvidia.com>
    virtio: Define feature bit for administration virtqueue

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix potencial out-of-bounds when buffer offset is invalid

Alison Schofield <alison.schofield@intel.com>
    cxl/trace: Properly initialize cxl_poison region name

Steven Rostedt (Google) <rostedt@goodmis.org>
    net: hns3: tracing: fix hclgevf trace event strings

Steven Rostedt (Google) <rostedt@goodmis.org>
    drm/i915: Add missing ; to __assign_str() macros in tracepoint code

Steven Rostedt (Google) <rostedt@goodmis.org>
    NFSD: Fix nfsd_clid_class use of __string_len() macro

Dragos Tatulea <dtatulea@nvidia.com>
    net: esp: fix bad handling of pages from page_pool

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Update the Zenbleed microcode revisions

Jens Axboe <axboe@kernel.dk>
    io_uring/waitid: always remove waitid entry for cancel all

Jens Axboe <axboe@kernel.dk>
    io_uring/futex: always remove futex entry for cancel all

Marek Szyprowski <m.szyprowski@samsung.com>
    cpufreq: dt: always allocate zeroed cpumask

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Constrain even more when continuous reads are enabled

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Ensure all continuous terms are always in sync

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Add a helper for calculating a page index

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Fix and simplify again the continuous read derivations

Eugene Korenevsky <ekorenevsky@astralinux.ru>
    cifs: open_cached_dir(): add FILE_READ_EA to desired access

Shyam Prasad N <sprasad@microsoft.com>
    cifs: reduce warning log level for server not advertising interfaces

Dan Carpenter <dan.carpenter@linaro.org>
    cifs: make cifs_chan_update_iface() a void function

Dan Carpenter <dan.carpenter@linaro.org>
    cifs: delete unnecessary NULL checks in cifs_chan_update_iface()

Shyam Prasad N <sprasad@microsoft.com>
    cifs: make sure server interfaces are requested only for SMB3+

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent kernel bug at submit_bh_wbc()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix failure to detect DAT corruption in btree and direct mappings

Sunmin Jeong <s_min.jeong@samsung.com>
    f2fs: truncate page cache before clearing flags when aborting atomic write

Sunmin Jeong <s_min.jeong@samsung.com>
    f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag

Bart Van Assche <bvanassche@acm.org>
    Revert "block/mq-deadline: use correct way to throttling write requests"

Qiang Zhang <qiang4.zhang@intel.com>
    memtest: use {READ,WRITE}_ONCE in memory scanning

Ley Foon Tan <leyfoon.tan@starfivetech.com>
    clocksource/drivers/timer-riscv: Clear timer interrupt on timer initialization

Jani Nikula <jani.nikula@intel.com>
    drm/vc4: hdmi: do not return negative values from .get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/imx/ipuv3: do not return negative values from .get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/exynos: do not return negative values from .get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/panel: do not return negative error codes from drm_panel_get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/probe-helper: warn about negative .get_modes()

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: fix reference counting on zcrypt card objects

Sean Anderson <sean.anderson@linux.dev>
    soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Anderson <sean.anderson@linux.dev>
    soc: fsl: qbman: Always disable interrupts when taking cgr_lock

Alexander Aring <aahringo@redhat.com>
    dlm: fix user space lkb refcounting

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix full_waiters_pending in poll

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix resetting of shortest_full

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not set shortest_full when full target is hit

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix waking up ring buffer readers

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: clean rings on NO_MMAP alloc fail

Jens Axboe <axboe@kernel.dk>
    io_uring/rw: return IOU_ISSUE_SKIP_COMPLETE for multishot retry

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    platform/x86/intel/tpmi: Change vsec offset to u64

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: replace generic_fillattr with vfs_getattr

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm,tpm_tis: Avoid warning splat at shutdown

Alex Williamson <alex.williamson@redhat.com>
    vfio/fsl-mc: Block calling interrupt handler without trigger

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Create persistent IRQ handlers

Christian Brauner <brauner@kernel.org>
    eventfd: simplify eventfd_signal()

Christian Brauner <brauner@kernel.org>
    i915: make inject_virtual_interrupt() void

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Disable virqfds on cleanup

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Lock external INTx masking ops

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Disable auto-enable of exclusive INTx IRQ

Frank Wunderlich <frank-w@public-files.de>
    thermal/drivers/mediatek: Fix control buffer enablement on MT7896

Steve French <stfrench@microsoft.com>
    cifs: allow changing password during remount

Bharath SM <bharathsm@microsoft.com>
    cifs: prevent updating file size from server if we have a read/write lease

Paulo Alcantara <pc@manguebit.com>
    smb: client: stop revalidating reparse points unnecessarily

Michael Kelley <mhklinux@outlook.com>
    PCI: hv: Fix ring buffer size calculation

Niklas Cassel <cassel@kernel.org>
    PCI: dwc: endpoint: Fix advertised resizable BAR size

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Enable BDF to SID translation properly

Nathan Chancellor <nathan@kernel.org>
    kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1

Benjamin Coddington <bcodding@redhat.com>
    NFS: Read unlock folio on nfs_page_create_from_folio() error

Josef Bacik <josef@toxicpanda.com>
    nfs: fix UAF in direct writes

Sam Ravnborg <sam@ravnborg.org>
    sparc32: Fix parport build with sparc32

Johan Hovold <johan+linaro@kernel.org>
    PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix mshot io-wq checks

Jens Axboe <axboe@kernel.dk>
    io_uring/net: correctly handle multishot recvmsg retry setup

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    PCI/AER: Block runtime suspend when handling errors

Johannes Berg <johannes.berg@intel.com>
    debugfs: fix wait/cancellation handling during remove

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Fix 8bit characters from direct synth

Wayne Chang <waynec@nvidia.com>
    usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Wayne Chang <waynec@nvidia.com>
    phy: tegra: xusb: Add API to retrieve the port number of phy

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    slimbus: core: Remove usage of the deprecated ida_simple_xx() API

Jerome Brunet <jbrunet@baylibre.com>
    nvmem: meson-efuse: fix function pointer type mismatch

Maximilian Heyne <mheyne@amazon.de>
    ext4: fix corruption during on-line resize

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix io_queue_proc modifying req->flags

Josua Mayer <josua@solid-run.com>
    hwmon: (amc6821) add of_match table

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix mshot read defer taskrun cqe posting

Mickaël Salaün <mic@digikod.net>
    landlock: Warn once if a Landlock action is requested while disabled

Christian Gmeiner <cgmeiner@igalia.com>
    drm/etnaviv: Restore some id values

Christian Marangi <ansuelsmth@gmail.com>
    leds: trigger: netdev: Fix kernel panic on interface rename trig notify

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    Bluetooth: btnxpuart: Fix btnxpuart_close

Dominique Martinet <dominique.martinet@atmark-techno.com>
    mmc: core: Fix switch on gp3 partition

Ryan Roberts <ryan.roberts@arm.com>
    mm: swap: fix race between free_swap_and_cache() and swapoff()

Fedor Pchelkin <pchelkin@ispras.ru>
    mac802154: fix llsec key resources release in mac802154_llsec_key_del

Tony Battersby <tonyb@cybernetics.com>
    block: Fix page refcounts for unaligned buffers in __bio_release_pages()

Nathan Chancellor <nathan@kernel.org>
    powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Yu Kuai <yukuai3@huawei.com>
    dm-raid: fix lockdep waring in "pers->hot_add_disk"

Yu Kuai <yukuai3@huawei.com>
    dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape

Yu Kuai <yukuai3@huawei.com>
    dm-raid: add a new helper prepare_suspend() in md_personality

Yu Kuai <yukuai3@huawei.com>
    md/dm-raid: don't call md_reap_sync_thread() directly

Yu Kuai <yukuai3@huawei.com>
    dm-raid: really frozen sync_thread during suspend

Yu Kuai <yukuai3@huawei.com>
    md: add a new helper reshape_interrupted()

Yu Kuai <yukuai3@huawei.com>
    md: export helper md_is_rdwr()

Yu Kuai <yukuai3@huawei.com>
    md: export helpers to stop sync_thread

Yu Kuai <yukuai3@huawei.com>
    md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume

Jarred White <jarredwhite@linux.microsoft.com>
    ACPI: CPPC: Use access_width over bit_width for system memory accesses

Paul Menzel <pmenzel@molgen.mpg.de>
    PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PM: Drain runtime-idle callbacks before driver removal

Nick Morrow <morrownr@gmail.com>
    wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: always free reserved space for extent records

Peter Collingbourne <pcc@google.com>
    serial: Lock console when calling into driver before registration

Jonas Gorski <jonas.gorski@gmail.com>
    serial: core: only stop transmit when HW fifo is empty

Roger Quadros <rogerq@kernel.org>
    usb: dwc3-am62: Disable wakeup at remove

Roger Quadros <rogerq@kernel.org>
    usb: dwc3-am62: fix module unload/reload behavior

Jameson Thies <jthies@google.com>
    usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros

Miklos Szeredi <mszeredi@redhat.com>
    fuse: don't unhash root

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix root lookup with nonzero generation

Miklos Szeredi <mszeredi@redhat.com>
    fuse: replace remaining make_bad_inode() with fuse_make_bad()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: tmio: avoid concurrent runs of mmc_request_done()

Qingliang Li <qingliang.li@mediatek.com>
    PM: sleep: wakeirq: fix wake irq warning in system suspend

Toru Katagiri <Toru.Katagiri@tdk.com>
    USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

David Woodhouse <dwmw@amazon.co.uk>
    KVM: x86/xen: inject vCPU upcall vector when local APIC is enabled

Aurélien Jacobs <aurel@gnuage.org>
    USB: serial: option: add MeiG Smart SLM320 product

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: track capability/opmode NSS separately

Christian Häggström <christian.haggstrom@orexplore.com>
    USB: serial: cp210x: add ID for MGP Instruments PDS100

Cameron Williams <cang1@live.co.uk>
    USB: serial: add device ID for VeriFone adapter

Daniel Vogelbacher <daniel@chaospixel.com>
    USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/fsl: Fix mfpmr build errors with newer binutils

Prashanth K <quic_prashk@quicinc.com>
    usb: xhci: Add error handling in xhci_map_urb_for_dma

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq9574: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays

Brett Creeley <brett.creeley@amd.com>
    vfio/pds: Always clear the save/restore FDs on reset

Maulik Shah <quic_mkshah@quicinc.com>
    PM: suspend: Set mem_sleep_current during kernel command line setup

Shivnandan Kumar <quic_kshivnan@quicinc.com>
    cpufreq: Limit resolving a frequency to policy min/max

Akira Yokosawa <akiyks@gmail.com>
    docs: Restore "smart quotes" for quotes

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    iio: adc: rockchip_saradc: use mask for write_enable bitfield

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2

Gui-Dong Han <2045gemini@gmail.com>
    md/raid5: fix atomicity violation in raid5_cache_count

Guenter Roeck <linux@roeck-us.net>
    parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Guenter Roeck <linux@roeck-us.net>
    parisc: Fix csum_ipv6_magic on 64-bit systems

Guenter Roeck <linux@roeck-us.net>
    parisc: Fix csum_ipv6_magic on 32-bit systems

Guenter Roeck <linux@roeck-us.net>
    parisc: Fix ip_fast_csum

John David Anglin <dave.anglin@bell.net>
    parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

Guenter Roeck <linux@roeck-us.net>
    parisc/unaligned: Rewrite 64-bit inline assembly of emulate_ldd()

Breno Leitao <leitao@debian.org>
    x86/nmi: Fix the inverse "in NMI handler" check

Heming Zhao <heming.zhao@suse.com>
    md/md-bitmap: fix incorrect usage for sb_index

Arseniy Krasnov <avkrasnov@salutedevices.com>
    mtd: rawnand: meson: fix scrambling mode value in command macro

Zhang Yi <yi.zhang@huawei.com>
    ubi: correct the calculation of fastmap size

Richard Weinberger <richard@nod.at>
    ubi: Check for too small LEB size in VTBL code

Matthew Wilcox (Oracle) <willy@infradead.org>
    ubifs: Set page uptodate in the correct place

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    mfd: twl: Select MFD_CORE

Bernd Schubert <bschubert@ddn.com>
    fuse: fix VM_MAYSHARE and direct_io_allow_mmap

Jan Kara <jack@suse.cz>
    fat: fix uninitialized field in nostale filehandles

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: support non-power-of-two CONFIG_NR_CPUS

Arnd Bergmann <arnd@arndb.de>
    kasan/test: avoid gcc warning for intentional overflow

Damien Le Moal <dlemoal@kernel.org>
    block: Clear zone limits for a non-zoned stacked queue

Baokun Li <libaokun1@huawei.com>
    ext4: correct best extent lstart adjustment logic

SeongJae Park <sj@kernel.org>
    selftests/mqueue: Set timeout to 180 seconds

Damian Muszynski <damian.muszynski@intel.com>
    crypto: qat - resolve race condition during AER recovery

Damian Muszynski <damian.muszynski@intel.com>
    crypto: qat - change SLAs cleanup flow at shutdown

Randy Dunlap <rdunlap@infradead.org>
    sparc: vDSO: fix return value of __setup handler

Randy Dunlap <rdunlap@infradead.org>
    sparc64: NMI watchdog: fix return value of __setup handler

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/smp: Increase nr_cpu_ids to include the boot CPU

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core

Zhang Rui <rui.zhang@intel.com>
    powercap: intel_rapl_tpmi: Fix System Domain probing

Zhang Rui <rui.zhang@intel.com>
    powercap: intel_rapl_tpmi: Fix a register bug

Zhang Rui <rui.zhang@intel.com>
    powercap: intel_rapl: Fix locking in TPMI RAPL

Zhang Rui <rui.zhang@intel.com>
    powercap: intel_rapl: Fix a NULL pointer dereference

Zhang Rui <rui.zhang@intel.com>
    thermal/intel: Fix intel_tcc_get_temp() to support negative CPU temperature

Tor Vic <torvic9@mailbox.org>
    cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port mapping

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port mapping

Sean Christopherson <seanjc@google.com>
    KVM: Always flush async #PF workqueue when vCPU is being destroyed

Li Lingfeng <lilingfeng3@huawei.com>
    md: use RCU lock to protect traversal in md_spares_need_change()

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Expand MUST_CONNECT flag to always require an enabled link

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Rename pad variable to clarify intent

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Add num_links flag to media_pad

Marek Vasut <marex@denx.de>
    media: nxp: imx8-isi: Check whether crossbar pad is non-NULL before access

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Fix flags handling when creating pad links

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Add local pad to pipeline regardless of the link state

Gui-Dong Han <2045gemini@gmail.com>
    media: xc4000: Fix atomicity violation in xc4000_get_frequency

Philipp Stanner <pstanner@redhat.com>
    pci_iounmap(): Fix MMIO mapping leak

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix the lifetime of the bo cursor memory

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: fix NULL pointer dereference in I2C instantiation

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8450-hdk: correct AMIC4 and AMIC5 microphones

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix possible null pointer derefence with invalid contexts

Duje Mihanović <duje.mihanovic@skole.hr>
    arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()

Amit Pundir <amit.pundir@linaro.org>
    clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Joakim Zhang <joakim.zhang@cixtech.com>
    remoteproc: virtio: Fix wdg cannot recovery remote processor

Krishna chaitanya chundru <quic_krichai@quicinc.com>
    arm64: dts: qcom: sc7280: Add additional MSI interrupts

Hidenori Kobayashi <hidenorik@chromium.org>
    media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmfmac: avoid invalid list operation when vendor attach fails

Zheng Wang <zyytlz.wz@163.com>
    wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Unmap the surface before resetting it on a plane state

Jim Mattson <jmattson@google.com>
    KVM: x86: Use a switch statement and macros in __feature_translate()

Jim Mattson <jmattson@google.com>
    KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   4 +-
 Documentation/arch/x86/amd-memory-encryption.rst   |  16 +-
 Documentation/conf.py                              |   6 +-
 .../userspace-api/media/mediactl/media-types.rst   |  11 +-
 Makefile                                           |   4 +-
 arch/arm/Kconfig                                   |   4 +-
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts      |   2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 arch/arm/include/asm/mman.h                        |  14 ++
 arch/arm/kernel/Makefile                           |   2 -
 arch/arm/kernel/iwmmxt.S                           |  51 ++--
 arch/arm/kernel/pj4-cp0.c                          | 135 -----------
 arch/arm/mm/flush.c                                |   3 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  12 +-
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   2 +
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |   4 +-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   2 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   2 +-
 arch/hexagon/kernel/vmlinux.lds.S                  |   1 +
 arch/loongarch/crypto/crc32-loongarch.c            |   2 -
 arch/loongarch/include/asm/Kbuild                  |   1 +
 arch/loongarch/include/asm/io.h                    |   2 +
 arch/loongarch/include/asm/percpu.h                |   7 +-
 arch/loongarch/include/asm/qspinlock.h             |  18 --
 arch/parisc/include/asm/assembly.h                 |  18 +-
 arch/parisc/include/asm/checksum.h                 |  10 +-
 arch/parisc/include/asm/mman.h                     |  14 ++
 arch/parisc/kernel/unaligned.c                     |  27 +--
 arch/powerpc/include/asm/reg_fsl_emb.h             |  11 +-
 arch/powerpc/kernel/prom.c                         |  12 +
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/sparc/include/asm/parport.h                   | 259 +--------------------
 arch/sparc/include/asm/parport_64.h                | 256 ++++++++++++++++++++
 arch/sparc/kernel/nmi.c                            |   2 +-
 arch/sparc/vdso/vma.c                              |   7 +-
 arch/x86/Kconfig                                   |  13 --
 arch/x86/boot/compressed/efi_mixed.S               |  29 ++-
 arch/x86/coco/core.c                               |   7 +-
 arch/x86/include/asm/asm-prototypes.h              |   1 +
 arch/x86/include/asm/asm.h                         |  14 ++
 arch/x86/include/asm/coco.h                        |   8 +-
 arch/x86/include/asm/crash_core.h                  |   2 +
 arch/x86/include/asm/mem_encrypt.h                 |  15 +-
 arch/x86/include/asm/nospec-branch.h               |  21 +-
 arch/x86/include/asm/sev.h                         |   4 +-
 arch/x86/include/asm/suspend_32.h                  |  10 +-
 arch/x86/include/asm/x86_init.h                    |   3 +-
 arch/x86/kernel/cpu/amd.c                          |  10 +-
 arch/x86/kernel/eisa.c                             |   3 +-
 arch/x86/kernel/fpu/xstate.c                       |   5 +-
 arch/x86/kernel/fpu/xstate.h                       |  14 +-
 arch/x86/kernel/kprobes/core.c                     |  11 +-
 arch/x86/kernel/mpparse.c                          |  10 +-
 arch/x86/kernel/nmi.c                              |   2 +-
 arch/x86/kernel/probe_roms.c                       |  10 -
 arch/x86/kernel/setup.c                            |   3 +-
 arch/x86/kernel/sev-shared.c                       |  12 +-
 arch/x86/kernel/sev.c                              |  31 ++-
 arch/x86/kernel/x86_init.c                         |   2 +
 arch/x86/kvm/cpuid.c                               |  21 +-
 arch/x86/kvm/hyperv.c                              |   2 +-
 arch/x86/kvm/lapic.c                               |   5 +-
 arch/x86/kvm/reverse_cpuid.h                       |  33 ++-
 arch/x86/kvm/svm/sev.c                             |  25 +-
 arch/x86/kvm/x86.c                                 |  10 +
 arch/x86/kvm/xen.c                                 |   4 +-
 arch/x86/kvm/xen.h                                 |  18 ++
 arch/x86/lib/retpoline.S                           |  11 +-
 arch/x86/mm/mem_encrypt_amd.c                      |  18 ++
 arch/x86/mm/mem_encrypt_identity.c                 |  38 ++-
 block/bio.c                                        |   7 +-
 block/blk-mq.c                                     |   9 +-
 block/blk-settings.c                               |   4 +
 block/mq-deadline.c                                |   3 +-
 crypto/asymmetric_keys/mscode_parser.c             |   3 +
 crypto/asymmetric_keys/pkcs7_parser.c              |   4 +
 crypto/asymmetric_keys/public_key.c                |   3 +-
 crypto/asymmetric_keys/signature.c                 |   2 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |   8 +
 crypto/testmgr.h                                   |  80 +++++++
 drivers/accel/habanalabs/common/device.c           |   2 +-
 drivers/accessibility/speakup/synth.c              |   4 +-
 drivers/acpi/cppc_acpi.c                           |  31 ++-
 drivers/ata/ahci.c                                 |   5 -
 drivers/ata/libata-eh.c                            |   5 +-
 drivers/ata/libata-scsi.c                          |   9 +
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/bluetooth/btnxpuart.c                      |   3 +
 drivers/char/tpm/tpm_tis_core.c                    |   3 +-
 drivers/clk/qcom/gcc-ipq5018.c                     |   3 +
 drivers/clk/qcom/gcc-ipq6018.c                     |   2 +
 drivers/clk/qcom/gcc-ipq8074.c                     |   2 +
 drivers/clk/qcom/gcc-ipq9574.c                     |   1 +
 drivers/clk/qcom/gcc-sdm845.c                      |   1 +
 drivers/clk/qcom/mmcc-apq8084.c                    |   2 +
 drivers/clk/qcom/mmcc-msm8974.c                    |   2 +
 drivers/clocksource/arm_global_timer.c             |   2 +-
 drivers/clocksource/timer-riscv.c                  |   3 +
 drivers/cpufreq/amd-pstate.c                       |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |  34 +--
 drivers/crypto/intel/qat/qat_common/adf_aer.c      |  22 +-
 drivers/crypto/intel/qat/qat_common/adf_rl.c       |  20 +-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |   4 +-
 drivers/cxl/core/trace.h                           |  14 +-
 drivers/firewire/ohci.c                            |   2 +
 drivers/firmware/efi/efi.c                         |   2 +
 drivers/firmware/efi/libstub/randomalloc.c         |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c            |   1 +
 drivers/fpga/dfl.c                                 |   2 +-
 drivers/gpio/gpiolib-cdev.c                        |  38 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  46 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  60 +++--
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |  14 ++
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  30 +--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c   |  54 +++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h   |  14 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c   |   5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  19 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.h  |   5 +
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c  |  32 +++
 .../drm/amd/display/dc/dcn321/dcn321_resource.c    |   2 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  16 +-
 .../amd/display/dc/dml2/dml2_translation_helper.c  |  24 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c |  53 ++++-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h |   7 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   3 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  41 ++--
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  12 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |  41 ----
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  48 +---
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  41 ----
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |  20 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |   3 +
 .../amd/display/modules/info_packet/info_packet.c  |  13 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  12 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  19 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  19 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  31 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  18 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |   2 -
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   5 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |  24 +-
 drivers/gpu/drm/drm_bridge.c                       |  46 +++-
 drivers/gpu/drm/drm_panel.c                        |  17 +-
 drivers/gpu/drm/drm_probe_helper.c                 |   7 +
 drivers/gpu/drm/drm_syncobj.c                      |   6 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |   9 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   4 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |   3 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  46 +++-
 .../drm/i915/display/intel_display_power_well.c    |  17 +-
 drivers/gpu/drm/i915/display/intel_display_trace.h |   6 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      | 200 +++++++++-------
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |   4 +
 drivers/gpu/drm/i915/display/intel_dsb.c           |  14 ++
 drivers/gpu/drm/i915/display/intel_vrr.c           |   7 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   3 +
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   3 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   3 +
 drivers/gpu/drm/i915/gvt/interrupt.c               |  13 +-
 drivers/gpu/drm/i915/i915_hwmon.c                  |  37 +--
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |   4 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/client.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  12 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   2 +-
 drivers/gpu/drm/nouveau/nvkm/core/client.c         |   1 +
 drivers/gpu/drm/nouveau/nvkm/core/object.c         |  26 ++-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  13 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |  13 ++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  17 +-
 drivers/hwmon/amc6821.c                            |  11 +
 drivers/i2c/busses/i2c-i801.c                      |   6 +-
 drivers/iio/accel/adxl367.c                        |   8 +-
 drivers/iio/accel/adxl367_i2c.c                    |   2 +-
 drivers/iio/adc/rockchip_saradc.c                  |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   5 +
 drivers/infiniband/hw/mlx5/devx.c                  |   2 +-
 drivers/input/joystick/xpad.c                      |   6 +
 drivers/iommu/dma-iommu.c                          |   9 +
 drivers/irqchip/irq-renesas-rzg2l.c                |  93 +++++---
 drivers/leds/trigger/ledtrig-netdev.c              |   4 +-
 drivers/md/dm-raid.c                               |  93 ++++++--
 drivers/md/dm-snap.c                               |   4 +-
 drivers/md/md-bitmap.c                             |   9 +-
 drivers/md/md.c                                    |  82 +++++--
 drivers/md/md.h                                    |  38 ++-
 drivers/md/raid5.c                                 |  46 +++-
 drivers/media/mc/mc-entity.c                       |  93 ++++++--
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |   4 +-
 drivers/media/tuners/xc4000.c                      |   4 +-
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/intel-lpss-pci.c                       |  28 ++-
 drivers/mfd/intel-lpss.c                           |   9 +-
 drivers/mfd/intel-lpss.h                           |  14 +-
 drivers/misc/fastrpc.c                             |  10 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |  21 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/misc/ocxl/file.c                           |   2 +-
 drivers/mmc/core/block.c                           |  14 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  28 ++-
 drivers/mmc/host/sdhci-omap.c                      |   3 +
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +
 drivers/mtd/nand/raw/meson_nand.c                  |   2 +-
 drivers/mtd/nand/raw/nand_base.c                   |  87 ++++---
 drivers/mtd/ubi/fastmap.c                          |   7 +-
 drivers/mtd/ubi/vtbl.c                             |   6 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   8 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |   2 +-
 drivers/net/wireguard/netlink.c                    |  10 +-
 .../broadcom/brcm80211/brcmfmac/bca/core.c         |  15 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  60 ++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |   2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |  33 ++-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |   3 +
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.c    |   1 +
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.c   |  14 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |  39 ++--
 .../broadcom/brcm80211/brcmfmac/wcc/core.c         |  16 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  15 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   2 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   7 +
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |  46 ++--
 drivers/nvmem/meson-efuse.c                        |  25 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   7 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  41 +++-
 drivers/pci/controller/pci-hyperv.c                |   3 +-
 drivers/pci/pci-driver.c                           |   7 +
 drivers/pci/pcie/err.c                             |  20 ++
 drivers/pci/quirks.c                               |   2 +
 drivers/phy/tegra/xusb.c                           |  13 ++
 drivers/platform/x86/intel/tpmi.c                  |   9 +-
 drivers/powercap/intel_rapl_common.c               |  34 ++-
 drivers/powercap/intel_rapl_msr.c                  |   8 +-
 drivers/powercap/intel_rapl_tpmi.c                 |  15 ++
 drivers/pwm/pwm-img.c                              |   4 +-
 drivers/remoteproc/remoteproc_virtio.c             |   6 +-
 drivers/s390/cio/vfio_ccw_chp.c                    |   2 +-
 drivers/s390/cio/vfio_ccw_drv.c                    |   4 +-
 drivers/s390/cio/vfio_ccw_ops.c                    |   6 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |   2 +-
 drivers/s390/crypto/zcrypt_api.c                   |   2 +
 drivers/scsi/hosts.c                               |   7 +-
 drivers/scsi/libsas/sas_expander.c                 |  51 ++--
 drivers/scsi/lpfc/lpfc_bsg.c                       |   4 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |  14 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   2 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |   2 +-
 drivers/scsi/qla2xxx/qla_init.c                    | 128 +++++-----
 drivers/scsi/qla2xxx/qla_iocb.c                    |  68 ++++--
 drivers/scsi/qla2xxx/qla_mbx.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  10 +
 drivers/scsi/scsi_scan.c                           |  34 +++
 drivers/scsi/sd.c                                  |  23 +-
 drivers/scsi/sg.c                                  |   4 +-
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/fsl/qbman/qman.c                       |  25 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |  16 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   5 +-
 drivers/tee/optee/device.c                         |   3 +-
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 .../int340x_thermal/processor_thermal_device.c     |   8 +-
 .../intel/int340x_thermal/processor_thermal_rapl.c |   8 +-
 drivers/thermal/intel/intel_tcc.c                  |  12 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   8 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |   3 +
 drivers/thunderbolt/switch.c                       |   3 +
 drivers/tty/serial/8250/8250_dw.c                  |   6 +-
 drivers/tty/serial/8250/8250_port.c                |   6 -
 drivers/tty/serial/fsl_lpuart.c                    |   7 +-
 drivers/tty/serial/imx.c                           |  22 +-
 drivers/tty/serial/max310x.c                       |   7 +-
 drivers/tty/serial/qcom_geni_serial.c              |  10 +-
 drivers/tty/serial/serial_core.c                   |  12 +
 drivers/tty/serial/serial_port.c                   |  25 +-
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/ufs/host/ufs-qcom.c                        |   6 +-
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/hub.c                             |  23 +-
 drivers/usb/core/hub.h                             |   2 +
 drivers/usb/core/port.c                            |  43 +++-
 drivers/usb/core/sysfs.c                           |  16 +-
 drivers/usb/dwc2/core.h                            |  14 ++
 drivers/usb/dwc2/core_intr.c                       |  72 ++++--
 drivers/usb/dwc2/gadget.c                          |  10 +
 drivers/usb/dwc2/hcd.c                             |  49 +++-
 drivers/usb/dwc2/hcd_ddma.c                        |  17 +-
 drivers/usb/dwc2/hw.h                              |   2 +-
 drivers/usb/dwc2/platform.c                        |   2 +-
 drivers/usb/dwc3/core.c                            |   2 +
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/dwc3/dwc3-am62.c                       |  13 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   2 -
 drivers/usb/dwc3/gadget.c                          |  10 +
 drivers/usb/dwc3/host.c                            |  11 +
 drivers/usb/gadget/function/f_fs.c                 |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |   2 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |  39 ++--
 drivers/usb/host/xhci-ring.c                       |   8 +-
 drivers/usb/host/xhci.c                            |   2 +
 drivers/usb/misc/usb-ljca.c                        |  22 +-
 drivers/usb/phy/phy-generic.c                      |   7 -
 drivers/usb/serial/cp210x.c                        |   4 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/storage/isd200.c                       |  23 +-
 drivers/usb/storage/uas.c                          |  28 ++-
 drivers/usb/typec/altmodes/displayport.c           |  18 +-
 drivers/usb/typec/class.c                          |   7 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   7 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  56 ++++-
 drivers/usb/typec/ucsi/ucsi.h                      |   4 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  71 +++---
 drivers/usb/typec/ucsi/ucsi_glink.c                |  14 ++
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   6 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |   9 +-
 drivers/vfio/pci/pds/lm.c                          |  13 ++
 drivers/vfio/pci/pds/lm.h                          |   1 +
 drivers/vfio/pci/pds/vfio_dev.c                    |   4 +-
 drivers/vfio/pci/vfio_pci_core.c                   |   6 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  | 190 +++++++++------
 drivers/vfio/platform/vfio_platform_irq.c          | 105 ++++++---
 drivers/vfio/virqfd.c                              |  21 ++
 drivers/vhost/vdpa.c                               |   4 +-
 drivers/vhost/vhost.c                              |  10 +-
 drivers/vhost/vhost.h                              |   2 +-
 drivers/virt/acrn/ioeventfd.c                      |   2 +-
 drivers/virtio/virtio.c                            |  10 +-
 drivers/xen/privcmd.c                              |   2 +-
 fs/aio.c                                           |  10 +-
 fs/btrfs/block-group.c                             |   3 +-
 fs/btrfs/extent_io.c                               |  75 ++++--
 fs/btrfs/qgroup.c                                  |  10 +-
 fs/btrfs/scrub.c                                   |  12 +-
 fs/btrfs/volumes.c                                 |  69 +++++-
 fs/debugfs/inode.c                                 |  25 +-
 fs/dlm/user.c                                      |  10 +-
 fs/eventfd.c                                       |  11 +-
 fs/exec.c                                          |   1 +
 fs/ext4/mballoc.c                                  |  17 +-
 fs/ext4/resize.c                                   |   3 +-
 fs/f2fs/f2fs.h                                     |   1 +
 fs/f2fs/segment.c                                  |   4 +-
 fs/fat/nfs.c                                       |   6 +
 fs/fuse/dir.c                                      |   6 +-
 fs/fuse/file.c                                     |   8 +-
 fs/fuse/fuse_i.h                                   |   1 -
 fs/fuse/inode.c                                    |   7 +-
 fs/nfs/direct.c                                    |  11 +-
 fs/nfs/read.c                                      |   2 +
 fs/nfs/write.c                                     |   2 +-
 fs/nfsd/trace.h                                    |   2 +-
 fs/nilfs2/btree.c                                  |   9 +-
 fs/nilfs2/direct.c                                 |   9 +-
 fs/nilfs2/inode.c                                  |   2 +-
 fs/smb/client/cached_dir.c                         |   3 +-
 fs/smb/client/cifs_debug.c                         |   2 +
 fs/smb/client/cifsglob.h                           |   5 +
 fs/smb/client/cifsproto.h                          |   8 +-
 fs/smb/client/connect.c                            |   6 +-
 fs/smb/client/file.c                               |   8 +-
 fs/smb/client/fs_context.c                         |  27 ++-
 fs/smb/client/inode.c                              |  17 +-
 fs/smb/client/readdir.c                            | 133 +++++------
 fs/smb/client/sess.c                               |  45 ++--
 fs/smb/client/smb2ops.c                            |   2 +
 fs/smb/client/smb2pdu.c                            |  10 +-
 fs/smb/server/smb2misc.c                           |  26 ++-
 fs/smb/server/smb2pdu.c                            | 228 +++++++++++-------
 fs/smb/server/smb_common.c                         |  11 +-
 fs/smb/server/vfs.c                                |  12 +-
 fs/ubifs/file.c                                    |  13 +-
 include/drm/drm_bridge.h                           |  33 +++
 include/drm/drm_modeset_helper_vtables.h           |   3 +-
 include/drm/ttm/ttm_tt.h                           |   9 +-
 include/linux/cpufreq.h                            |  15 +-
 include/linux/eventfd.h                            |   4 +-
 include/linux/gfp.h                                |   9 +
 include/linux/hyperv.h                             |  22 +-
 include/linux/intel_rapl.h                         |   6 +
 include/linux/intel_tcc.h                          |   2 +-
 include/linux/libata.h                             |   1 +
 include/linux/mman.h                               |   8 +
 include/linux/mtd/spinand.h                        |   2 +-
 include/linux/nfs_fs.h                             |   1 +
 include/linux/oid_registry.h                       |   4 +
 include/linux/phy/tegra/xusb.h                     |   1 +
 include/linux/ring_buffer.h                        |   1 +
 include/linux/serial_core.h                        |   3 +-
 include/linux/skbuff.h                             |  10 +
 include/linux/vfio.h                               |   2 +
 include/media/media-entity.h                       |   2 +
 include/net/cfg80211.h                             |   2 +
 include/net/cfg802154.h                            |   1 +
 include/scsi/scsi_driver.h                         |   1 +
 include/scsi/scsi_host.h                           |   1 +
 include/uapi/linux/virtio_config.h                 |   8 +-
 init/Kconfig                                       |   6 +-
 init/initramfs.c                                   |   2 +-
 io_uring/futex.c                                   |   1 +
 io_uring/io_uring.c                                |   5 +-
 io_uring/net.c                                     |   5 +-
 io_uring/poll.c                                    |  19 +-
 io_uring/rw.c                                      |   4 +
 io_uring/waitid.c                                  |   7 +-
 kernel/bounds.c                                    |   2 +-
 kernel/cgroup/cpuset.c                             |   8 +-
 kernel/crash_core.c                                |   8 +
 kernel/dma/swiotlb.c                               |  37 +--
 kernel/entry/common.c                              |   8 +-
 kernel/module/Kconfig                              |   5 +
 kernel/power/suspend.c                             |   1 +
 kernel/printk/printk.c                             |  27 ++-
 kernel/sys.c                                       |   7 +-
 kernel/time/posix-clock.c                          |  16 +-
 kernel/trace/ring_buffer.c                         | 233 ++++++++++--------
 kernel/trace/trace.c                               |  21 +-
 kernel/workqueue.c                                 |   2 +-
 lib/pci_iomap.c                                    |   2 +-
 mm/compaction.c                                    |   7 +-
 mm/filemap.c                                       |  16 ++
 mm/kasan/kasan_test.c                              |   3 +-
 mm/memcontrol.c                                    |  10 +-
 mm/memtest.c                                       |   4 +-
 mm/mmap.c                                          |  10 +-
 mm/page_alloc.c                                    |  10 +-
 mm/shmem_quota.c                                   |  10 +-
 mm/swapfile.c                                      |  13 +-
 mm/vmpressure.c                                    |   2 +-
 mm/vmscan.c                                        |   5 +-
 net/bluetooth/hci_core.c                           |   6 +-
 net/bluetooth/hci_sync.c                           |   5 +-
 net/ipv4/esp4.c                                    |   8 +-
 net/ipv6/esp6.c                                    |   8 +-
 net/mac80211/cfg.c                                 |   7 +-
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/rate.c                                |   2 +-
 net/mac80211/sta_info.h                            |   6 +-
 net/mac80211/vht.c                                 |  46 ++--
 net/mac802154/llsec.c                              |  18 +-
 net/netfilter/nf_tables_api.c                      |   7 +
 net/wireless/wext-core.c                           |   7 +-
 net/xfrm/xfrm_user.c                               |   3 +
 samples/vfio-mdev/mtty.c                           |   4 +-
 scripts/Makefile.extrawarn                         |   2 +
 security/landlock/syscalls.c                       |  18 +-
 security/smack/smack_lsm.c                         |  12 +-
 sound/pci/hda/patch_realtek.c                      |  13 +-
 sound/pci/hda/tas2781_hda_i2c.c                    |  83 ++++---
 sound/sh/aica.c                                    |  17 +-
 sound/soc/amd/yc/acp6x-mach.c                      |   7 -
 tools/include/linux/btf_ids.h                      |   2 +
 tools/perf/builtin-top.c                           |   4 +-
 tools/testing/selftests/mm/gup_test.c              |  67 +++---
 tools/testing/selftests/mm/soft-dirty.c            |   2 +-
 tools/testing/selftests/mm/split_huge_page_test.c  |   2 +-
 tools/testing/selftests/mm/uffd-common.c           |   3 +
 tools/testing/selftests/mm/uffd-common.h           |   2 +
 tools/testing/selftests/mm/uffd-unit-tests.c       |  13 +-
 tools/testing/selftests/mqueue/setting             |   1 +
 tools/testing/selftests/net/mptcp/diag.sh          |   6 +-
 .../selftests/wireguard/qemu/arch/riscv32.config   |   1 +
 .../selftests/wireguard/qemu/arch/riscv64.config   |   1 +
 virt/kvm/async_pf.c                                |  31 ++-
 virt/kvm/eventfd.c                                 |   4 +-
 486 files changed, 5040 insertions(+), 2801 deletions(-)



