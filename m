Return-Path: <linux-kernel+bounces-126883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9C8942F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D08B225ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C910481D7;
	Mon,  1 Apr 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6GVCDvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982A433DA;
	Mon,  1 Apr 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990659; cv=none; b=OxP7Qm2lNVjq1mLrLnZd7C7QX73c4HFysFx6vanUp3xTui6OZNu6ksnL8PjmSl3rFSNJcoFhPjA2KGtEGLBrhIfh/7RFGryMNyQY0VNEXOR2muECbmDnCYAx3lTS7cJwrGJGXLBSxHy4pbk0NrwxcyJNF8htR5/7AK+r5ljhheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990659; c=relaxed/simple;
	bh=4oIPdon1kiYyKLNoOVFpv4bTHmprzc2QXWzQdeROt34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZudXkDxpv9aBnxfpXd5JcKPJ5/dFW+4YbPDASYJpIcnCXdC2ictDO6Bg8LUZeYYTpvCDcgyM/pUNupjCklN2kv+o4/tZJb/vHrEzsQ4DRL6NpwtRQx6Vmlxy8JGD1bwJf7S78t9VU9TrdyXv1XSsA4wL6x7OhI6PVHypboZofzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6GVCDvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15CCC433F1;
	Mon,  1 Apr 2024 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990659;
	bh=4oIPdon1kiYyKLNoOVFpv4bTHmprzc2QXWzQdeROt34=;
	h=From:To:Cc:Subject:Date:From;
	b=T6GVCDvfot4q25nygcMLUMQgkFqZjUD6NJtXmpUyuY+8/nZAzLHie3Vuef0ilmEvZ
	 MjKgGGYK5VjLXEWjfEn/FNl0zgAR6663unNRDyrrd7p1QNIW64Dbj6WQ8dLAeXNnYW
	 1WDwDdAZ2ItU7SRQBxkDBzJ6E+7tkA1fqDsViI68=
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
Subject: [PATCH 6.1 000/272] 6.1.84-rc1 review
Date: Mon,  1 Apr 2024 17:43:10 +0200
Message-ID: <20240401152530.237785232@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.84-rc1
X-KernelTest-Deadline: 2024-04-03T15:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.84 release.
There are 272 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.84-rc1

Natanael Copa <ncopa@alpinelinux.org>
    tools/resolve_btfids: fix build with musl libc

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix deadlock in usb_deauthorize_interface()

Kevin Loughlin <kevinloughlin@google.com>
    x86/sev: Skip ROM range scans and validation for SEV-SNP guests

Xingui Yang <yangxingui@huawei.com>
    scsi: libsas: Fix disk not being scanned in after being removed

Xingui Yang <yangxingui@huawei.com>
    scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()

Muhammad Usama Anjum <usama.anjum@collabora.com>
    scsi: lpfc: Correct size for wqe for memset()

Muhammad Usama Anjum <usama.anjum@collabora.com>
    scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()

Sabrina Dubroca <sd@queasysnail.net>
    tls: fix use-after-free on failed backlog decryption

Kim Phillips <kim.phillips@amd.com>
    x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Delay I/O Abort on PCI error

Saurav Kashyap <skashyap@marvell.com>
    scsi: qla2xxx: Change debug message during driver unload

Saurav Kashyap <skashyap@marvell.com>
    scsi: qla2xxx: Fix double free of fcport

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

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Fix TCG OPAL unlock on system resume

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix deadlock in port "disable" sysfs attribute

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Add hub_get() and hub_put() routines

Dan Carpenter <dan.carpenter@linaro.org>
    staging: vc04_services: fix information leak in create_component()

Arnd Bergmann <arnd@arndb.de>
    staging: vc04_services: changen strncpy() to strscpy_pad()

Guilherme G. Piccoli <gpiccoli@igalia.com>
    scsi: core: Fix unremoved procfs host directory regression

Duoming Zhou <duoming@zju.edu.cn>
    ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Roger Quadros <rogerq@kernel.org>
    usb: dwc3-am62: fix module unload/reload behavior

Ladislav Michl <ladis@linux-mips.org>
    usb: dwc3-am62: Rename private data

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    USB: UAS: return ENODEV when submit urbs fail with device not attached

Oliver Neukum <oneukum@suse.com>
    usb: cdc-wdm: close race between read and workqueue

Alexander Stein <alexander.stein@ew.tq-group.com>
    Revert "usb: phy: generic: Get the vbus supply"

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/gt: Reset queue_priority_hint on parking

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/bios: Tolerate devdata==NULL in intel_bios_encoder_supports_dp_dual_mode()

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

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Avoid negative index with array access

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Initialize mmc_blk_ioc_data

Romain Naour <romain.naour@skf.com>
    mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode

Nathan Chancellor <nathan@kernel.org>
    hexagon: vmlinux.lds.S: handle attributes section

Max Filippov <jcmvbkbc@gmail.com>
    exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: don't always use FW dump trig

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: zoned: use zone aware sb location for scrub

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: zoned: don't skip block groups with 100% zone unusable

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Cast away type warning in use of max()

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Add missing boot_params for mixed mode compat entry

John Sperbeck <jsperbeck@google.com>
    init: open /initrd.image with O_LARGEFILE

Zi Yan <ziy@nvidia.com>
    mm/migrate: set swap entry values of THP tail pages properly.

Ard Biesheuvel <ardb@kernel.org>
    x86/sev: Fix position dependent variable references in startup code

Borislav Petkov (AMD) <bp@alien8.de>
    x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT

Borislav Petkov (AMD) <bp@alien8.de>
    x86/coco: Get rid of accessor functions

Borislav Petkov (AMD) <bp@alien8.de>
    x86/coco: Export cc_vendor

Alex Williamson <alex.williamson@redhat.com>
    vfio/fsl-mc: Block calling interrupt handler without trigger

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Create persistent IRQ handlers

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Create persistent INTx handler

Alex Williamson <alex.williamson@redhat.com>
    vfio: Introduce interface to flush virqfd inject workqueue

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Disable auto-enable of exclusive INTx IRQ

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Chengming Zhou <zhouchengming@bytedance.com>
    blk-mq: release scheduler resource when request completes

Tony Battersby <tonyb@cybernetics.com>
    block: Fix page refcounts for unaligned buffers in __bio_release_pages()

Rickard x Andersson <rickaran@axis.com>
    tty: serial: imx: Fix broken RS485

Zoltan HERPAI <wigyori@uid0.hu>
    pwm: img: fix pwm clock lookup

Oleksandr Tymoshenko <ovt@google.com>
    efi: fix panic in kdump kernel

Adamos Ttofari <attofari@amazon.de>
    x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

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

David Laight <David.Laight@ACULAB.COM>
    minmax: add umin(a, b) and umax(a, b)

André Rösti <an.roesti@gmail.com>
    entry: Respect changes to system call number by trace_sys_enter()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clocksource/drivers/arm_global_timer: Fix maximum prescaler value

Charan Teja Kalla <quic_charante@quicinc.com>
    iommu: Avoid races around default domain allocations

Jiawei Wang <me@jwang.link>
    ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"

Jakub Kicinski <kuba@kernel.org>
    net: tls: handle backlogging of crypto requests

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Call mixed mode boot services on the firmware's stack

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/display: handle range offsets in VRR ranges

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Avoid potential double call to gpiod_remove_lookup_table

Cosmin Tanislav <demonsingur@gmail.com>
    iio: accel: adxl367: fix I2C FIFO data register

Cosmin Tanislav <demonsingur@gmail.com>
    iio: accel: adxl367: fix DEVID read after reset

Vlastimil Babka <vbabka@suse.cz>
    mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix kernel panic caused by incorrect error handling

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add Headset Mic supported Acer NB platform

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Nicolas Pitre <nico@fluxnic.net>
    vt: fix unicode buffer corruption when deleting characters

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point H DID

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point S DID

Hans de Goede <hdegoede@redhat.com>
    misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume

Peter Collingbourne <pcc@google.com>
    serial: 8250_dw: Do not reclock if already at correct rate

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: port: Don't try to peer unused USB ports based on location

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Fix handling of zero block length packets

Alan Stern <stern@rowland.harvard.edu>
    USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform

Nirmoy Das <nirmoy.das@intel.com>
    drm/i915: Check before removing mm notifier

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Fix the error of pwm1_enable setting

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Use .flush() call to wake up readers

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()

Sean Christopherson <seanjc@google.com>
    KVM: x86: Mark target gfn of emulated atomic instruction as dirty

Kees Cook <keescook@chromium.org>
    init/Kconfig: lower GCC version check for -Warray-bounds

Nathan Chancellor <nathan@kernel.org>
    xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Michael Kelley <mhklinux@outlook.com>
    Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject constant set with timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow anonymous set with timeout flag

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout

Jakub Kicinski <kuba@kernel.org>
    tls: fix race between tx work scheduling and socket close

Hans de Goede <hdegoede@redhat.com>
    platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    cpufreq: brcmstb-avs-cpufreq: fix up "add check for cpufreq_cpu_get's return value"

Anton Altaparmakov <anton@tuxera.com>
    x86/pm: Work around false positive kmemleak report in msr_build_context()

Mikulas Patocka <mpatocka@redhat.com>
    dm snapshot: fix lockup in dm_exception_table_exit

Leo Ma <hanghong.ma@amd.com>
    drm/amd/display: Fix noise issue on HDMI AV mute

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Return the correct HDCP error code

Philip Yang <Philip.Yang@amd.com>
    drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1064: asm1166: don't limit reported ports

Andrey Jr. Melnikov <temnota.am@gmail.com>
    ahci: asm1064: correct count of reported ports

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: access device through ctx instead of peer

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: check for dangling peer via is_dead instead of empty list

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Define the __io_aw() hook as mmiowb()

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Change __my_cpu_offset definition to avoid mis-optimization

Steven Rostedt (Google) <rostedt@goodmis.org>
    net: hns3: tracing: fix hclgevf trace event strings

Steven Rostedt (Google) <rostedt@goodmis.org>
    NFSD: Fix nfsd_clid_class use of __string_len() macro

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Update the Zenbleed microcode revisions

Marek Szyprowski <m.szyprowski@samsung.com>
    cpufreq: dt: always allocate zeroed cpumask

Eugene Korenevsky <ekorenevsky@astralinux.ru>
    cifs: open_cached_dir(): add FILE_READ_EA to desired access

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

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Disable virqfds on cleanup

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Lock external INTx masking ops

Reinette Chatre <reinette.chatre@intel.com>
    vfio/pci: Remove negative check on unsigned vector

Reinette Chatre <reinette.chatre@intel.com>
    vfio/pci: Consolidate irq cleanup on MSI/MSI-X disable

Jason Gunthorpe <jgg@ziepe.ca>
    vfio: Use GFP_KERNEL_ACCOUNT for userspace persistent allocations

Michael Kelley <mhklinux@outlook.com>
    PCI: hv: Fix ring buffer size calculation

Niklas Cassel <cassel@kernel.org>
    PCI: dwc: endpoint: Fix advertised resizable BAR size

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Enable BDF to SID translation properly

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version

Nathan Chancellor <nathan@kernel.org>
    kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1

Josef Bacik <josef@toxicpanda.com>
    nfs: fix UAF in direct writes

Sam Ravnborg <sam@ravnborg.org>
    sparc32: Fix parport build with sparc32

Rob Herring <robh@kernel.org>
    sparc: Explicitly include correct DT includes

Jens Axboe <axboe@kernel.dk>
    io_uring/net: correctly handle multishot recvmsg retry setup

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    PCI/AER: Block runtime suspend when handling errors

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

Josua Mayer <josua@solid-run.com>
    hwmon: (amc6821) add of_match table

Mickaël Salaün <mic@digikod.net>
    landlock: Warn once if a Landlock action is requested while disabled

Christian Gmeiner <cgmeiner@igalia.com>
    drm/etnaviv: Restore some id values

Dominique Martinet <dominique.martinet@atmark-techno.com>
    mmc: core: Fix switch on gp3 partition

Ryan Roberts <ryan.roberts@arm.com>
    mm: swap: fix race between free_swap_and_cache() and swapoff()

Huang Ying <ying.huang@intel.com>
    swap: comments get_swap_device() with usage rule

Fedor Pchelkin <pchelkin@ispras.ru>
    mac802154: fix llsec key resources release in mac802154_llsec_key_del

Nathan Chancellor <nathan@kernel.org>
    powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Yu Kuai <yukuai3@huawei.com>
    dm-raid: fix lockdep waring in "pers->hot_add_disk"

Jarred White <jarredwhite@linux.microsoft.com>
    ACPI: CPPC: Use access_width over bit_width for system memory accesses

Paul Menzel <pmenzel@molgen.mpg.de>
    PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PM: Drain runtime-idle callbacks before driver removal

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: always free reserved space for extent records

Peter Collingbourne <pcc@google.com>
    serial: Lock console when calling into driver before registration

Jameson Thies <jthies@google.com>
    usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros

Miklos Szeredi <mszeredi@redhat.com>
    fuse: don't unhash root

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix root lookup with nonzero generation

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
    clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays

Maulik Shah <quic_mkshah@quicinc.com>
    PM: suspend: Set mem_sleep_current during kernel command line setup

Shivnandan Kumar <quic_kshivnan@quicinc.com>
    cpufreq: Limit resolving a frequency to policy min/max

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

Arseniy Krasnov <avkrasnov@salutedevices.com>
    mtd: rawnand: meson: fix scrambling mode value in command macro

Zhang Yi <yi.zhang@huawei.com>
    ubi: correct the calculation of fastmap size

Richard Weinberger <richard@nod.at>
    ubi: Check for too small LEB size in VTBL code

Matthew Wilcox (Oracle) <willy@infradead.org>
    ubifs: Set page uptodate in the correct place

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

Svyatoslav Pankratov <svyatoslav.pankratov@intel.com>
    crypto: qat - fix double free during reset

Randy Dunlap <rdunlap@infradead.org>
    sparc: vDSO: fix return value of __setup handler

Randy Dunlap <rdunlap@infradead.org>
    sparc64: NMI watchdog: fix return value of __setup handler

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/smp: Increase nr_cpu_ids to include the boot CPU

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core

Tor Vic <torvic9@mailbox.org>
    cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()

Sean Christopherson <seanjc@google.com>
    KVM: Always flush async #PF workqueue when vCPU is being destroyed

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Expand MUST_CONNECT flag to always require an enabled link

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Rename pad variable to clarify intent

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Add num_links flag to media_pad

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Fix flags handling when creating pad links

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: mc: Add local pad to pipeline regardless of the link state

Gui-Dong Han <2045gemini@gmail.com>
    media: xc4000: Fix atomicity violation in xc4000_get_frequency

Philipp Stanner <pstanner@redhat.com>
    pci_iounmap(): Fix MMIO mapping leak

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: fix NULL pointer dereference in I2C instantiation

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

Zheng Wang <zyytlz.wz@163.com>
    wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Thomas Gleixner <tglx@linutronix.de>
    timers: Rename del_timer_sync() to timer_delete_sync()

Thomas Gleixner <tglx@linutronix.de>
    timers: Use del_timer_sync() even on UP

Thomas Gleixner <tglx@linutronix.de>
    timers: Update kernel-doc for various functions

Jim Mattson <jmattson@google.com>
    KVM: x86: Use a switch statement and macros in __feature_translate()

Jim Mattson <jmattson@google.com>
    KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace

Sean Christopherson <seanjc@google.com>
    KVM: x86: Update KVM-only leaf handling to allow for 100% KVM-only leafs

Borislav Petkov <bp@suse.de>
    x86/bugs: Use sysfs_emit()

Kim Phillips <kim.phillips@amd.com>
    x86/cpu: Support AMD Automatic IBRS


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/spectre.rst      |  17 +-
 Documentation/admin-guide/kernel-parameters.txt    |  10 +-
 .../userspace-api/media/mediactl/media-types.rst   |  11 +-
 Documentation/x86/amd-memory-encryption.rst        |  16 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/mmp2-brownstone.dts              |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  12 +-
 arch/hexagon/kernel/vmlinux.lds.S                  |   1 +
 arch/loongarch/include/asm/io.h                    |   2 +
 arch/loongarch/include/asm/percpu.h                |   7 +-
 arch/parisc/include/asm/assembly.h                 |  18 +-
 arch/parisc/include/asm/checksum.h                 |  10 +-
 arch/parisc/kernel/unaligned.c                     |  27 +--
 arch/powerpc/include/asm/reg_fsl_emb.h             |  11 +-
 arch/powerpc/kernel/prom.c                         |  12 +
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/sparc/crypto/crop_devid.c                     |   2 +-
 arch/sparc/include/asm/floppy_32.h                 |   2 +-
 arch/sparc/include/asm/floppy_64.h                 |   2 +-
 arch/sparc/include/asm/parport.h                   | 258 +--------------------
 arch/sparc/include/asm/parport_64.h                | 256 ++++++++++++++++++++
 arch/sparc/kernel/apc.c                            |   2 +-
 arch/sparc/kernel/auxio_32.c                       |   1 -
 arch/sparc/kernel/auxio_64.c                       |   3 +-
 arch/sparc/kernel/central.c                        |   2 +-
 arch/sparc/kernel/chmc.c                           |   3 +-
 arch/sparc/kernel/ioport.c                         |   2 +-
 arch/sparc/kernel/leon_kernel.c                    |   2 -
 arch/sparc/kernel/leon_pci.c                       |   3 +-
 arch/sparc/kernel/leon_pci_grpci1.c                |   3 +-
 arch/sparc/kernel/leon_pci_grpci2.c                |   4 +-
 arch/sparc/kernel/nmi.c                            |   2 +-
 arch/sparc/kernel/of_device_32.c                   |   2 +-
 arch/sparc/kernel/of_device_64.c                   |   4 +-
 arch/sparc/kernel/of_device_common.c               |   4 +-
 arch/sparc/kernel/pci.c                            |   3 +-
 arch/sparc/kernel/pci_common.c                     |   3 +-
 arch/sparc/kernel/pci_fire.c                       |   3 +-
 arch/sparc/kernel/pci_impl.h                       |   1 -
 arch/sparc/kernel/pci_msi.c                        |   2 +
 arch/sparc/kernel/pci_psycho.c                     |   4 +-
 arch/sparc/kernel/pci_sun4v.c                      |   3 +-
 arch/sparc/kernel/pmc.c                            |   2 +-
 arch/sparc/kernel/power.c                          |   3 +-
 arch/sparc/kernel/prom_irqtrans.c                  |   1 +
 arch/sparc/kernel/psycho_common.c                  |   1 +
 arch/sparc/kernel/sbus.c                           |   3 +-
 arch/sparc/kernel/time_32.c                        |   1 -
 arch/sparc/mm/io-unit.c                            |   3 +-
 arch/sparc/mm/iommu.c                              |   5 +-
 arch/sparc/vdso/vma.c                              |   7 +-
 arch/x86/Kconfig                                   |  13 --
 arch/x86/boot/compressed/efi_mixed.S               |  29 ++-
 arch/x86/coco/core.c                               |  20 +-
 arch/x86/coco/tdx/tdx.c                            |   2 +-
 arch/x86/include/asm/asm.h                         |  14 ++
 arch/x86/include/asm/coco.h                        |  10 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/mem_encrypt.h                 |  15 +-
 arch/x86/include/asm/msr-index.h                   |   2 +
 arch/x86/include/asm/sev.h                         |   4 +-
 arch/x86/include/asm/suspend_32.h                  |  10 +-
 arch/x86/include/asm/x86_init.h                    |   3 +-
 arch/x86/kernel/cpu/amd.c                          |  10 +-
 arch/x86/kernel/cpu/bugs.c                         | 138 +++++------
 arch/x86/kernel/cpu/common.c                       |  19 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   2 +-
 arch/x86/kernel/eisa.c                             |   3 +-
 arch/x86/kernel/fpu/xstate.c                       |   5 +-
 arch/x86/kernel/fpu/xstate.h                       |  14 +-
 arch/x86/kernel/kprobes/core.c                     |  11 +-
 arch/x86/kernel/probe_roms.c                       |  10 -
 arch/x86/kernel/setup.c                            |   3 +-
 arch/x86/kernel/sev-shared.c                       |  12 +-
 arch/x86/kernel/sev.c                              |  31 ++-
 arch/x86/kernel/x86_init.c                         |   2 +
 arch/x86/kvm/cpuid.c                               |  29 ++-
 arch/x86/kvm/lapic.c                               |   5 +-
 arch/x86/kvm/reverse_cpuid.h                       |  42 +++-
 arch/x86/kvm/svm/sev.c                             |  18 +-
 arch/x86/kvm/x86.c                                 |  10 +
 arch/x86/kvm/xen.c                                 |   2 +-
 arch/x86/kvm/xen.h                                 |  18 ++
 arch/x86/mm/mem_encrypt_amd.c                      |  18 ++
 arch/x86/mm/mem_encrypt_identity.c                 |  38 ++-
 block/bio.c                                        |  11 +-
 block/blk-mq.c                                     |  33 ++-
 block/blk-settings.c                               |   4 +
 block/mq-deadline.c                                |   3 +-
 drivers/accessibility/speakup/synth.c              |   4 +-
 drivers/acpi/cppc_acpi.c                           |  31 ++-
 drivers/ata/ahci.c                                 |   5 -
 drivers/ata/libata-eh.c                            |   5 +-
 drivers/ata/libata-scsi.c                          |   9 +
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |   2 +
 drivers/clk/qcom/gcc-ipq8074.c                     |   2 +
 drivers/clk/qcom/gcc-sdm845.c                      |   1 +
 drivers/clk/qcom/mmcc-apq8084.c                    |   2 +
 drivers/clk/qcom/mmcc-msm8974.c                    |   2 +
 drivers/clocksource/arm_global_timer.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                       |   2 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   5 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/crypto/qat/qat_common/adf_aer.c            |  23 +-
 drivers/firmware/efi/efi.c                         |   2 +
 drivers/firmware/efi/libstub/randomalloc.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  19 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  12 +-
 drivers/gpu/drm/drm_panel.c                        |  17 +-
 drivers/gpu/drm/drm_probe_helper.c                 |   7 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |   9 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   4 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |   3 +
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   3 +
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   3 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   3 +
 drivers/gpu/drm/imx/parallel-display.c             |   4 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  12 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  14 +-
 drivers/hwmon/amc6821.c                            |  11 +
 drivers/i2c/busses/i2c-i801.c                      |   4 +-
 drivers/iio/accel/adxl367.c                        |   8 +-
 drivers/iio/accel/adxl367_i2c.c                    |   2 +-
 drivers/iommu/dma-iommu.c                          |   9 +
 drivers/iommu/iommu.c                              |   3 +
 drivers/irqchip/irq-renesas-rzg2l.c                |  93 +++++---
 drivers/md/dm-raid.c                               |   2 +
 drivers/md/dm-snap.c                               |   4 +-
 drivers/md/raid5.c                                 |  14 +-
 drivers/media/mc/mc-entity.c                       |  93 ++++++--
 drivers/media/tuners/xc4000.c                      |   4 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |  21 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/mmc/core/block.c                           |  14 +-
 drivers/mmc/host/sdhci-omap.c                      |   3 +
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +
 drivers/mtd/nand/raw/meson_nand.c                  |   2 +-
 drivers/mtd/ubi/fastmap.c                          |   7 +-
 drivers/mtd/ubi/vtbl.c                             |   6 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   8 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |   2 +-
 drivers/net/wireguard/netlink.c                    |  10 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  15 +-
 drivers/nvmem/meson-efuse.c                        |  25 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   7 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 153 ++++++------
 drivers/pci/controller/pci-hyperv.c                |   3 +-
 drivers/pci/pci-driver.c                           |   7 +
 drivers/pci/pcie/err.c                             |  20 ++
 drivers/pci/quirks.c                               |   2 +
 drivers/phy/tegra/xusb.c                           |  13 ++
 drivers/platform/x86/p2sb.c                        |  23 +-
 drivers/pwm/pwm-img.c                              |   4 +-
 drivers/remoteproc/remoteproc_virtio.c             |   6 +-
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
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  10 +
 drivers/scsi/scsi_scan.c                           |  34 +++
 drivers/scsi/sd.c                                  |  25 +-
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/fsl/qbman/qman.c                       |  25 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |  16 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   5 +-
 drivers/tee/optee/device.c                         |   3 +-
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 drivers/tty/serial/8250/8250_dw.c                  |   6 +-
 drivers/tty/serial/8250/8250_port.c                |   6 -
 drivers/tty/serial/fsl_lpuart.c                    |   7 +-
 drivers/tty/serial/imx.c                           |  22 +-
 drivers/tty/serial/max310x.c                       |   7 +-
 drivers/tty/serial/serial_core.c                   |  12 +
 drivers/tty/vt/vt.c                                |   2 +-
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
 drivers/usb/dwc3/dwc3-am62.c                       |  90 ++++---
 drivers/usb/gadget/function/f_ncm.c                |   2 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |  39 ++--
 drivers/usb/host/xhci.c                            |   2 +
 drivers/usb/phy/phy-generic.c                      |   7 -
 drivers/usb/serial/cp210x.c                        |   4 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/storage/isd200.c                       |  23 +-
 drivers/usb/storage/uas.c                          |  28 ++-
 drivers/usb/typec/class.c                          |   7 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  56 ++++-
 drivers/usb/typec/ucsi/ucsi.h                      |   4 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  71 +++---
 drivers/vfio/container.c                           |   2 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |   7 +-
 drivers/vfio/pci/vfio_pci_config.c                 |   6 +-
 drivers/vfio/pci/vfio_pci_core.c                   |   7 +-
 drivers/vfio/pci/vfio_pci_igd.c                    |   2 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  | 218 ++++++++++-------
 drivers/vfio/pci/vfio_pci_rdwr.c                   |   2 +-
 drivers/vfio/platform/vfio_platform_irq.c          | 106 ++++++---
 drivers/vfio/virqfd.c                              |  23 +-
 fs/aio.c                                           |   8 +-
 fs/btrfs/block-group.c                             |   3 +-
 fs/btrfs/qgroup.c                                  |  10 +-
 fs/btrfs/scrub.c                                   |  12 +-
 fs/btrfs/volumes.c                                 |   2 +-
 fs/exec.c                                          |   1 +
 fs/ext4/mballoc.c                                  |  17 +-
 fs/ext4/resize.c                                   |   3 +-
 fs/f2fs/f2fs.h                                     |   1 +
 fs/f2fs/segment.c                                  |   4 +-
 fs/fat/nfs.c                                       |   6 +
 fs/fuse/dir.c                                      |   4 +
 fs/fuse/fuse_i.h                                   |   1 -
 fs/fuse/inode.c                                    |   7 +-
 fs/nfs/direct.c                                    |  11 +-
 fs/nfs/write.c                                     |   2 +-
 fs/nfsd/trace.h                                    |   2 +-
 fs/nilfs2/btree.c                                  |   9 +-
 fs/nilfs2/direct.c                                 |   9 +-
 fs/nilfs2/inode.c                                  |   2 +-
 fs/smb/client/cached_dir.c                         |   3 +-
 fs/smb/server/smb2pdu.c                            |  10 +-
 fs/ubifs/file.c                                    |  13 +-
 include/drm/drm_modeset_helper_vtables.h           |   3 +-
 include/linux/cpufreq.h                            |  15 +-
 include/linux/gfp.h                                |   9 +
 include/linux/hyperv.h                             |  22 +-
 include/linux/libata.h                             |   1 +
 include/linux/minmax.h                             |  17 ++
 include/linux/nfs_fs.h                             |   1 +
 include/linux/phy/tegra/xusb.h                     |   1 +
 include/linux/ring_buffer.h                        |   1 +
 include/linux/timer.h                              |  18 +-
 include/linux/vfio.h                               |   2 +
 include/media/media-entity.h                       |   2 +
 include/net/cfg802154.h                            |   1 +
 include/scsi/scsi_driver.h                         |   1 +
 include/scsi/scsi_host.h                           |   1 +
 init/Kconfig                                       |   6 +-
 init/initramfs.c                                   |   2 +-
 io_uring/net.c                                     |   3 +-
 kernel/bounds.c                                    |   2 +-
 kernel/dma/swiotlb.c                               |  11 +-
 kernel/entry/common.c                              |   8 +-
 kernel/power/suspend.c                             |   1 +
 kernel/printk/printk.c                             |  27 ++-
 kernel/time/timer.c                                | 160 +++++++------
 kernel/trace/ring_buffer.c                         | 233 +++++++++++--------
 kernel/trace/trace.c                               |  21 +-
 lib/pci_iomap.c                                    |   2 +-
 mm/compaction.c                                    |   7 +-
 mm/kasan/kasan_test.c                              |   3 +-
 mm/memtest.c                                       |   4 +-
 mm/migrate.c                                       |   6 +-
 mm/page_alloc.c                                    |  10 +-
 mm/swapfile.c                                      |  25 +-
 mm/vmscan.c                                        |   5 +-
 net/bluetooth/hci_core.c                           |   6 +-
 net/bluetooth/hci_sync.c                           |   5 +-
 net/mac80211/cfg.c                                 |   5 +-
 net/mac802154/llsec.c                              |  18 +-
 net/netfilter/nf_tables_api.c                      |   7 +
 net/tls/tls_sw.c                                   |  60 +++--
 net/xfrm/xfrm_user.c                               |   3 +
 scripts/Makefile.extrawarn                         |   2 +
 security/landlock/syscalls.c                       |  18 +-
 security/smack/smack_lsm.c                         |  12 +-
 sound/pci/hda/patch_realtek.c                      |  13 +-
 sound/sh/aica.c                                    |  17 +-
 sound/soc/amd/yc/acp6x-mach.c                      |   7 -
 tools/include/linux/btf_ids.h                      |   2 +
 tools/testing/selftests/mqueue/setting             |   1 +
 tools/testing/selftests/net/mptcp/diag.sh          |   6 +-
 virt/kvm/async_pf.c                                |  31 ++-
 305 files changed, 3011 insertions(+), 1673 deletions(-)



