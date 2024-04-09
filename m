Return-Path: <linux-kernel+bounces-137404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723889E193
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC261F249CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1E156666;
	Tue,  9 Apr 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSif+24b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334F13C66C;
	Tue,  9 Apr 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683822; cv=none; b=j1sCV1vZV6hlbwNnoXfRAKSFZRFjP3No5cdd7Ar4bL1pA3EaKb/cBvmIX58vyfu0LkM/J7DZ72mrPIqK8kGBOTznoGwINbElOgj8ZOBH4Tioo0wPyCBuuocyPfVC/KtvkfaEpwx9J9skKZfVvrkni6iRrCzWAKDjUmQ9jnT+R14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683822; c=relaxed/simple;
	bh=ADqRUfss5DyUGK8YQRMEOReFjmmWwI6OHYW5G0uKYBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgZk7ct/GJz0KGi8ec3/+hfOOnGSyA/0yxK3o0Onp77dxPUxmVOjOTGJtnBygX0d+D9FY9pC873Swl3+OurN/l9r/kCeQPhdIutcvQCOCYa8AFgQYR5wflshQgRoU3M+gfAt5EpSiNqZPHXmi6o1iiHKkeoQHZ4rmXLNPZuLDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSif+24b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95257C433C7;
	Tue,  9 Apr 2024 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712683821;
	bh=ADqRUfss5DyUGK8YQRMEOReFjmmWwI6OHYW5G0uKYBE=;
	h=From:To:Cc:Subject:Date:From;
	b=tSif+24bjmEjBjc/eQhG5jHtmm0IX5tJN6S8ICJF/FGFMnEqPaV/0q1YtPVWedh0+
	 WTPoUEI1Rs99mGuoO5UhAQRI/vPl0rdQrFGNVMm05eE4CHXQ+d4bNzRFaadPdf5G9g
	 /Xn+cXsaO3p3nS5Muduj+KPu4TRFk4ltMO1N/GLU=
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
Subject: [PATCH 5.15 000/696] 5.15.154-rc2 review
Date: Tue,  9 Apr 2024 19:30:17 +0200
Message-ID: <20240409172909.473227113@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.154-rc2
X-KernelTest-Deadline: 2024-04-11T17:29+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.154 release.
There are 696 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 11 Apr 2024 17:27:40 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.154-rc2

Daniel Sneddon <daniel.sneddon@linux.intel.com>
    KVM: x86: Add BHI_NO

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Mitigate KVM by default

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Add BHI mitigation knob

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Enumerate Branch History Injection (BHI) bug

Daniel Sneddon <daniel.sneddon@linux.intel.com>
    x86/bhi: Define SPEC_CTRL_BHI_DIS_S

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Add support for clearing branch history at syscall entry

Linus Torvalds <torvalds@linux-foundation.org>
    x86/syscall: Don't force use of indirect calls for system calls

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file

min15.li <min15.li@samsung.com>
    nvme: fix miss command type check

Antoine Tenart <atenart@kernel.org>
    gro: fix ownership transfer

David Hildenbrand <david@redhat.com>
    mm/secretmem: fix GUP-fast succeeding on secretmem folios

Davide Caratti <dcaratti@redhat.com>
    mptcp: don't account accept() of non-MPC client as fallback to TCP

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Borislav Petkov (AMD) <bp@alien8.de>
    x86/bugs: Fix the SRSO mitigation on Zen3/4

Stefan O'Rear <sorear@fastmail.com>
    riscv: process: Fix kernel gp leakage

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix spurious errors from __get/put_kernel_nofault

Sumanth Korikkar <sumanthk@linux.ibm.com>
    s390/entry: align system call table on 8 bytes

Borislav Petkov (AMD) <bp@alien8.de>
    x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Herve Codina <herve.codina@bootlin.com>
    of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Herve Codina <herve.codina@bootlin.com>
    driver core: Introduce device_link_wait_removal()

I Gede Agastya Darma Laksana <gedeagas22@gmail.com>
    ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Jann Horn <jannh@google.com>
    fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Jann Horn <jannh@google.com>
    openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached

Jann Horn <jannh@google.com>
    HID: uhid: Use READ_ONCE()/WRITE_ONCE() for ->running

Jeff Layton <jlayton@kernel.org>
    nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Arnd Bergmann <arnd@arndb.de>
    ata: sata_mv: Fix PCI device ID table declaration compilation warning

Arnd Bergmann <arnd@arndb.de>
    scsi: mylex: Fix sysfs buffer lengths

Arnd Bergmann <arnd@arndb.de>
    ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit

Stephen Lee <slee08177@gmail.com>
    ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt711-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt711-sdca: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt5682-sdw: fix locking sequence

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always process TX descriptor ring

Wei Fang <wei.fang@nxp.com>
    net: fec: Set mac_managed_pm during probe

Denis Kirjanov <dkirjanov@suse.de>
    drivers: net: convert to boolean for the mac_managed_pm flag

Oleksij Rempel <linux@rempel-privat.de>
    net: usb: asix: suspend embedded PHY if external is used

Ivan Vecera <ivecera@redhat.com>
    i40e: Enforce software interrupt during busy-poll exit

Ivan Vecera <ivecera@redhat.com>
    i40e: Remove _t suffix from enum type names

Joe Damato <jdamato@fastly.com>
    i40e: Store the irq number in i40e_q_vector

Alexander Stein <alexander.stein@ew.tq-group.com>
    Revert "usb: phy: generic: Get the vbus supply"

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Update manufacturer detail

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Update manufacturer details

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix vf may be used uninitialized in this function warning

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix i40e_count_filters() to count only active/new filters

Su Hui <suhui@nfschina.com>
    octeontx2-pf: check negative error code in otx2_open()

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Fix issue with loading coalesced KPU profiles

Antoine Tenart <atenart@kernel.org>
    udp: prevent local UDP tunnel packets from being GROed

Antoine Tenart <atenart@kernel.org>
    udp: do not transition UDP GRO fraglist partial checksums to unnecessary

Antoine Tenart <atenart@kernel.org>
    udp: do not accept non-tunnel GSO skbs landing in a tunnel

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop interface during shutdown

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: Fix infinite recursion in fib6_dump_done().

Jakub Kicinski <kuba@kernel.org>
    selftests: reuseaddr_conflict: add missing new line at the end of the output

Eric Dumazet <edumazet@google.com>
    erspan: make sure erspan_base_hdr is present in skb->head

Antoine Tenart <atenart@kernel.org>
    selftests: net: gro fwd: update vxlan GRO test expectations

Piotr Wejman <piotrwejman90@gmail.com>
    net: stmmac: fix rx queue priority assignment

Eric Dumazet <edumazet@google.com>
    net/sched: act_skbmod: prevent kernel-infoleak

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Eric Dumazet <edumazet@google.com>
    netfilter: validate user input for expected length

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: flush pending destroy work before exit_net release

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject new basechain after table flag update

Sean Christopherson <seanjc@google.com>
    KVM: x86: Mark target gfn of emulated atomic instruction as dirty

Sean Christopherson <seanjc@google.com>
    KVM: x86: Bail to userspace if emulation of atomic user access faults

Ye Zhang <ye.zhang@rock-chips.com>
    thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

Vlastimil Babka <vbabka@suse.cz>
    mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Ingo Molnar <mingo@kernel.org>
    Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Jens Axboe <axboe@kernel.dk>
    io_uring: ensure '0' is returned on file registration success

Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
    locking/rwsem: Disable preemption while trying for rwsem lock

Mahmoud Adam <mngyadam@amazon.com>
    net/rds: fix possible cp null dereference

Jesper Dangaard Brouer <hawk@kernel.org>
    xen-netfront: Add missing skb_mark_for_recycle

Bastien Nocera <hadess@hadess.net>
    Bluetooth: Fix TOCTOU in HCI debugfs implementation

Hui Wang <hui.wang@canonical.com>
    Bluetooth: hci_event: set the conn encrypted before conn establishes

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

Sean Christopherson <seanjc@google.com>
    x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word

Sandipan Das <sandipan.das@amd.com>
    x86/cpufeatures: Add new word for scattered features

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Arnd Bergmann <arnd@arndb.de>
    dm integrity: fix out-of-range warning

Hariprasad Kelam <hkelam@marvell.com>
    Octeontx2-af: fix pause frame configuration in GMP mode

Andrei Matei <andreimatei1@gmail.com>
    bpf: Protect against int overflow for stack access size

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: call request_irq() after NAPI initialized

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Eric Dumazet <edumazet@google.com>
    tcp: properly terminate timers for kernel sockets

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: handle deferred cc1

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: rfi: fix potential response leaks

Bixuan Cui <cuibixuan@linux.alibaba.com>
    iwlwifi: mvm: rfi: use kmemdup() to replace kzalloc + memcpy

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop PHY during open() error paths

Ryosuke Yasuoka <ryasuoka@redhat.com>
    nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    USB: UAS: return ENODEV when submit urbs fail with device not attached

Bart Van Assche <bvanassche@acm.org>
    scsi: usb: Stop using the SCSI pointer

Bart Van Assche <bvanassche@acm.org>
    scsi: usb: Call scsi_done() directly

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix deadlock in usb_deauthorize_interface()

Muhammad Usama Anjum <usama.anjum@collabora.com>
    scsi: lpfc: Correct size for wqe for memset()

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

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

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Split FCE|EFT trace control

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix N2N stuck connection

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Prevent command send on chip reset

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Ack unsupported commands

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
    USB: core: Add hub_get() and hub_put() routines

Dan Carpenter <dan.carpenter@linaro.org>
    staging: vc04_services: fix information leak in create_component()

Arnd Bergmann <arnd@arndb.de>
    staging: vc04_services: changen strncpy() to strscpy_pad()

Guilherme G. Piccoli <gpiccoli@igalia.com>
    scsi: core: Fix unremoved procfs host directory regression

Duoming Zhou <duoming@zju.edu.cn>
    ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Tom Chung <chiahsuan.chung@amd.com>
    drm/amd/display: Preserve original aspect ratio in create stream

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/amdgpu: Use drm_mode_copy()

Oliver Neukum <oneukum@suse.com>
    usb: cdc-wdm: close race between read and workqueue

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/gt: Reset queue_priority_hint on parking

Claus Hansen Ries <chr@terma.com>
    net: ll_temac: platform_get_resource replaced by wrong function

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Avoid negative index with array access

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Initialize mmc_blk_ioc_data

Nathan Chancellor <nathan@kernel.org>
    hexagon: vmlinux.lds.S: handle attributes section

Max Filippov <jcmvbkbc@gmail.com>
    exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: zoned: use zone aware sb location for scrub

John Sperbeck <jsperbeck@google.com>
    init: open /initrd.image with O_LARGEFILE

Zi Yan <ziy@nvidia.com>
    mm/migrate: set swap entry values of THP tail pages properly.

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO

Alex Williamson <alex.williamson@redhat.com>
    vfio/fsl-mc: Block calling interrupt handler without trigger

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Create persistent IRQ handlers

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Create persistent INTx handler

Alex Williamson <alex.williamson@redhat.com>
    vfio: Introduce interface to flush virqfd inject workqueue

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Lock external INTx masking ops

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Disable auto-enable of exclusive INTx IRQ

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Nathan Chancellor <nathan@kernel.org>
    powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Tim Schumacher <timschumi@gmx.de>
    efivarfs: Request at most 512 bytes for variable names

Yang Jihong <yangjihong1@huawei.com>
    perf/core: Fix reentry problem in perf_output_read_group()

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Fix a regression in nfsd_setattr()

NeilBrown <neilb@suse.de>
    nfsd: don't call locks_release_private() twice concurrently

NeilBrown <neilb@suse.de>
    nfsd: don't take fi_lock in nfsd_break_deleg_cb()

NeilBrown <neilb@suse.de>
    nfsd: fix RELEASE_LOCKOWNER

Jeff Layton <jlayton@kernel.org>
    nfsd: drop the nfsd_put helper

NeilBrown <neilb@suse.de>
    nfsd: call nfsd_last_thread() before final nfsd_put()

Alexander Aring <aahringo@redhat.com>
    lockd: introduce safe async lock op

NeilBrown <neilb@suse.de>
    NFSD: fix possible oops when nfsd/pool_stats is closed.

Chuck Lever <chuck.lever@oracle.com>
    Documentation: Add missing documentation for EXPORT_OP flags

NeilBrown <neilb@suse.de>
    nfsd: separate nfsd_last_thread() from nfsd_put()

NeilBrown <neilb@suse.de>
    nfsd: Simplify code around svc_exit_thread() call in nfsd()

Tavian Barnes <tavianator@tavianator.com>
    nfsd: Fix creation time serialization order

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add an nfsd4_encode_nfstime4() helper

NeilBrown <neilb@suse.de>
    lockd: drop inappropriate svc_get() from locked_get()

Dan Carpenter <dan.carpenter@linaro.org>
    nfsd: fix double fget() bug in __write_ports_addfd()

Jeff Layton <jlayton@kernel.org>
    nfsd: make a copy of struct iattr before calling notify_change

Dai Ngo <dai.ngo@oracle.com>
    NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop

Jeff Layton <jlayton@kernel.org>
    nfsd: simplify the delayed disposal list code

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Convert filecache to rhltable

Jeff Layton <jlayton@kernel.org>
    nfsd: allow reaping files still under writeback

Jeff Layton <jlayton@kernel.org>
    nfsd: update comment over __nfsd_file_cache_purge

Jeff Layton <jlayton@kernel.org>
    nfsd: don't take/put an extra reference when putting a file

Jeff Layton <jlayton@kernel.org>
    nfsd: add some comments to nfsd_file_do_acquire

Jeff Layton <jlayton@kernel.org>
    nfsd: don't kill nfsd_files because of lease break error

Jeff Layton <jlayton@kernel.org>
    nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator

Jeff Layton <jlayton@kernel.org>
    nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries

Jeff Layton <jlayton@kernel.org>
    nfsd: don't open-code clear_and_wake_up_bit

Jeff Layton <jlayton@kernel.org>
    nfsd: call op_release, even when op_func returns an error

Jeff Layton <jlayton@kernel.org>
    nfsd: don't replace page in rq_pages if it's a continuation of last page

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Protect against filesystem freezing

Chuck Lever <chuck.lever@oracle.com>
    NFSD: copy the whole verifier in nfsd_copy_write_verifier

Jeff Layton <jlayton@kernel.org>
    nfsd: don't fsync nfsd_files on last close

Jeff Layton <jlayton@kernel.org>
    nfsd: fix courtesy client with deny mode handling in nfs4_upgrade_open

Dai Ngo <dai.ngo@oracle.com>
    NFSD: fix problems with cleanup on errors in nfsd4_copy

Jeff Layton <jlayton@kernel.org>
    nfsd: don't hand out delegation on setuid files being opened for write

Dai Ngo <dai.ngo@oracle.com>
    NFSD: fix leaked reference count of nfsd4_ssc_umount_item

Jeff Layton <jlayton@kernel.org>
    nfsd: clean up potential nfsd_file refcount leaks in COPY codepath

Jeff Layton <jlayton@kernel.org>
    nfsd: allow nfsd_file_get to sanely handle a NULL pointer

Dai Ngo <dai.ngo@oracle.com>
    NFSD: enhance inter-server copy cleanup

Jeff Layton <jlayton@kernel.org>
    nfsd: don't destroy global nfs4_file table in per-net shutdown

Jeff Layton <jlayton@kernel.org>
    nfsd: don't free files unconditionally in __nfsd_file_cache_purge

Dai Ngo <dai.ngo@oracle.com>
    NFSD: replace delayed_work with work_struct for nfsd_client_shrinker

Dai Ngo <dai.ngo@oracle.com>
    NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shutdown time

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use set_bit(RQ_DROPME)

Chuck Lever <chuck.lever@oracle.com>
    Revert "SUNRPC: Use RMW bitops in single-threaded hot paths"

Jeff Layton <jlayton@kernel.org>
    nfsd: fix handling of cached open files in nfsd4_open codepath

Jeff Layton <jlayton@kernel.org>
    nfsd: rework refcounting in filecache

Kees Cook <keescook@chromium.org>
    NFSD: Avoid clashing function prototypes

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use only RQ_DROPME to signal the need to drop a reply

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add CB_RECALL_ANY tracepoints

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add delegation reaper to react to low memory condition

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add support for sending CB_RECALL_ANY

Dai Ngo <dai.ngo@oracle.com>
    NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker

Chuck Lever <chuck.lever@oracle.com>
    trace: Relocate event helper files

Jeff Layton <jlayton@kernel.org>
    lockd: fix file selection in nlmsvc_cancel_blocked

Jeff Layton <jlayton@kernel.org>
    lockd: ensure we use the correct file descriptor when unlocking

Jeff Layton <jlayton@kernel.org>
    lockd: set missing fl_flags field when retrieving args

Xiu Jianfeng <xiujianfeng@huawei.com>
    NFSD: Use struct_size() helper in alloc_session()

Jeff Layton <jlayton@kernel.org>
    nfsd: return error if nfs4_setacl fails

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add an nfsd_file_fsync tracepoint

Jeff Layton <jlayton@kernel.org>
    nfsd: fix up the filecache laundrette scheduling

Jeff Layton <jlayton@kernel.org>
    filelock: add a new locks_inode_context accessor function

Jeff Layton <jlayton@kernel.org>
    nfsd: reorganize filecache.c

Jeff Layton <jlayton@kernel.org>
    nfsd: remove the pages_flushed statistic from filecache

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix licensing header in filecache.c

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use rhashtable for managing nfs4_file objects

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor find_file()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up find_or_add_file()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add a nfsd4_file_hash_remove() helper

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd4_init_file()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Update file_hashtbl() helpers

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use const pointers as parameters to fh_ helpers

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace delegation revocations

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace stateids returned via DELEGRETURN

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfs4_preprocess_stateid_op() call sites

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Flesh out a documenting comment for filecache.c

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Pass the target nfsd_file to nfsd_commit()

David Disseldorp <ddiss@suse.de>
    exportfs: use pr_debug for unreachable debug statements

Jeff Layton <jlayton@kernel.org>
    nfsd: allow disabling NFSv2 at compile time

Jeff Layton <jlayton@kernel.org>
    nfsd: move nfserrno() to vfs.c

Jeff Layton <jlayton@kernel.org>
    nfsd: ignore requests to disable unsupported versions

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Finish converting the NFSv3 GETACL result encoder

Colin Ian King <colin.i.king@gmail.com>
    NFSD: Remove redundant assignment to variable host_err

Anna Schumaker <Anna.Schumaker@Netapp.com>
    NFSD: Simplify READ_PLUS

Jeff Layton <jlayton@kernel.org>
    nfsd: use locks_inode_context helper

Jeff Layton <jlayton@kernel.org>
    lockd: use locks_inode_context helper

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix reads with a non-zero offset that don't end on a page boundary

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix trace_nfsd_fh_verify_err() crasher

Jeff Layton <jlayton@kernel.org>
    nfsd: put the export reference in nfsd4_verify_deleg_dentry

Jeff Layton <jlayton@kernel.org>
    nfsd: fix use-after-free in nfsd_file_do_acquire tracepoint

Jeff Layton <jlayton@kernel.org>
    nfsd: fix net-namespace logic in __nfsd_file_cache_purge

Jeff Layton <jlayton@kernel.org>
    nfsd: ensure we always call fh_verify_error tracepoint

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    NFSD: unregister shrinker when nfsd_init_net() fails

Jeff Layton <jlayton@kernel.org>
    nfsd: rework hashtable handling in nfsd_do_file_acquire

Jeff Layton <jlayton@kernel.org>
    nfsd: fix nfsd_file_unhash_and_dispose

Gaosheng Cui <cuigaosheng1@huawei.com>
    fanotify: Remove obsoleted fanotify_event_has_path()

Gaosheng Cui <cuigaosheng1@huawei.com>
    fsnotify: remove unused declaration

Al Viro <viro@zeniv.linux.org.uk>
    fs/notify: constify path

Jeff Layton <jlayton@kernel.org>
    nfsd: extra checks when freeing delegation stateids

Jeff Layton <jlayton@kernel.org>
    nfsd: make nfsd4_run_cb a bool return function

Jeff Layton <jlayton@kernel.org>
    nfsd: fix comments about spinlock handling with delegations

Jeff Layton <jlayton@kernel.org>
    nfsd: only fill out return pointer on success in nfsd4_lookup_stateid

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Cap rsize_bop result based on send buffer size

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Rename the fields in copy_stateid_t

ChenXiaoSong <chenxiaosong2@huawei.com>
    nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_file_cache_stats_fops

ChenXiaoSong <chenxiaosong2@huawei.com>
    nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_reply_cache_stats_fops

ChenXiaoSong <chenxiaosong2@huawei.com>
    nfsd: use DEFINE_SHOW_ATTRIBUTE to define client_info_fops

ChenXiaoSong <chenxiaosong2@huawei.com>
    nfsd: use DEFINE_SHOW_ATTRIBUTE to define export_features_fops and supported_enctypes_fops

ChenXiaoSong <chenxiaosong2@huawei.com>
    nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Pack struct nfsd4_compoundres

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove unused nfsd4_compoundargs::cachetype field

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove "inline" directives on op_rsize_bop helpers

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfs4svc_encode_compoundres()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up WRITE arg decoders

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use xdr_inline_decode() to decode NFSv3 symlinks

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor common code out of dirlist helpers

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Parametrize how much of argsize should be zeroed

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add shrinker to reap courtesy clients on low memory condition

Dai Ngo <dai.ngo@oracle.com>
    NFSD: keep track of the number of courtesy clients in the system

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Make nfsd4_remove() wait before returning NFS4ERR_DELAY

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd_setattr()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add a mechanism to wait for a DELEGRETURN

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add tracepoints to report NFSv4 callback completions

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace NFSv4 COMPOUND tags

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Replace dprintk() call site in fh_verify()

Gaosheng Cui <cuigaosheng1@huawei.com>
    nfsd: remove nfsd4_prepare_cb_recall() declaration

Jeff Layton <jlayton@kernel.org>
    nfsd: clean up mounted_on_fileid handling

NeilBrown <neilb@suse.de>
    NFSD: drop fname and flen args from nfsd_create_locked()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Increase NFSD_MAX_OPS_PER_COMPOUND

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    nfsd: Propagate some error code returned by memdup_user()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    nfsd: Avoid some useless tests

Jinpeng Cui <cui.jinpeng2@zte.com.cn>
    NFSD: remove redundant variable status

Olga Kornievskaia <kolga@netapp.com>
    NFSD enforce filehandle check for source file in COPY

Wolfram Sang <wsa+renesas@sang-engineering.com>
    lockd: move from strlcpy with unused retval to strscpy

Wolfram Sang <wsa+renesas@sang-engineering.com>
    NFSD: move from strlcpy with unused retval to strscpy

Al Viro <viro@zeniv.linux.org.uk>
    nfsd_splice_actor(): handle compound pages

NeilBrown <neilb@suse.de>
    NFSD: fix regression with setting ACLs.

NeilBrown <neilb@suse.de>
    NFSD: discard fh_locked flag and fh_lock/fh_unlock

NeilBrown <neilb@suse.de>
    NFSD: use (un)lock_inode instead of fh_(un)lock for file operations

NeilBrown <neilb@suse.de>
    NFSD: use explicit lock/unlock for directory ops

NeilBrown <neilb@suse.de>
    NFSD: reduce locking in nfsd_lookup()

NeilBrown <neilb@suse.de>
    NFSD: only call fh_unlock() once in nfsd_link()

NeilBrown <neilb@suse.de>
    NFSD: always drop directory lock in nfsd_unlink()

NeilBrown <neilb@suse.de>
    NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before returning.

NeilBrown <neilb@suse.de>
    NFSD: add posix ACLs to struct nfsd_attrs

NeilBrown <neilb@suse.de>
    NFSD: add security label to struct nfsd_attrs

NeilBrown <neilb@suse.de>
    NFSD: set attributes when creating symlinks

NeilBrown <neilb@suse.de>
    NFSD: introduce struct nfsd_attrs

Jeff Layton <jlayton@kernel.org>
    NFSD: verify the opened dentry after setting a delegation

Jeff Layton <jlayton@kernel.org>
    NFSD: drop fh argument from alloc_init_deleg

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Move copy offload callback arguments into a separate structure

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add nfsd4_send_cb_offload()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove kmalloc from nfsd4_do_async_copy()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd4_do_copy()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Replace boolean fields in struct nfsd4_copy

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Make nfs4_put_copy() static

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Reorder the fields in struct nfsd4_op

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Shrink size of struct nfsd4_copy

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Shrink size of struct nfsd4_copy_notify

Chuck Lever <chuck.lever@oracle.com>
    NFSD: nfserrno(-ENOMEM) is nfserr_jukebox

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix strncpy() fortify warning

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd4_encode_readlink()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use xdr_pad_size()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Simplify starting_len

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Optimize nfsd4_encode_readv()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add an nfsd4_read::rd_eof field

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up SPLICE_OK in nfsd4_encode_read()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Optimize nfsd4_encode_fattr()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Optimize nfsd4_encode_operation()

Jeff Layton <jlayton@kernel.org>
    nfsd: silence extraneous printk on nfsd.ko insertion

Dai Ngo <dai.ngo@oracle.com>
    NFSD: limit the number of v4 clients to 1024 per 1GB of system memory

Dai Ngo <dai.ngo@oracle.com>
    NFSD: keep track of the number of v4 clients in the system

Dai Ngo <dai.ngo@oracle.com>
    NFSD: refactoring v4 specific code to a helper in nfs4state.c

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Ensure nf_inode is never dereferenced

Chuck Lever <chuck.lever@oracle.com>
    NFSD: NFSv4 CLOSE should release an nfsd_file immediately

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Move nfsd_file_trace_alloc() tracepoint

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Separate tracepoints for acquire and create

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up unused code after rhashtable conversion

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Convert the filecache to use rhashtable

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Set up an rhashtable for the filecache

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Replace the "init once" mechanism

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove nfsd_file::nf_hashval

Chuck Lever <chuck.lever@oracle.com>
    NFSD: nfsd_file_hash_remove can compute hashval

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor __nfsd_file_close_inode()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: nfsd_file_unhash can compute hashval from nf->nf_inode

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove lockdep assertion from unhash_and_release_locked()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: No longer record nf_hashval in the trace log

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Never call nfsd_file_gc() in foreground paths

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix the filecache LRU shrinker

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Leave open files out of the filecache LRU

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace filecache LRU activity

Chuck Lever <chuck.lever@oracle.com>
    NFSD: WARN when freeing an item still linked via nf_lru

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Hook up the filecache stat file

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Zero counters when the filecache is re-initialized

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Record number of flush calls

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Report the number of items evicted by the LRU walk

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd_file_lru_scan()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd_file_gc()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add nfsd_file_lru_dispose_list() helper

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Report average age of filecache items

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Report count of freed filecache items

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Report count of calls to nfsd_file_acquire()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Report filecache LRU size

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Demote a WARN to a pr_warn()

Colin Ian King <colin.i.king@gmail.com>
    nfsd: remove redundant assignment to variable len

Zhang Jiaming <jiaming@nfschina.com>
    NFSD: Fix space and spelling mistake

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Instrument fh_verify()

Benjamin Coddington <bcodding@redhat.com>
    NLM: Defend against file_lock changes after vfs_test_lock()

Xin Gao <gaoxin@cdjrlc.com>
    fsnotify: Fix comment typo

Amir Goldstein <amir73il@gmail.com>
    fanotify: introduce FAN_MARK_IGNORE

Amir Goldstein <amir73il@gmail.com>
    fanotify: cleanups for fanotify_mark() input validations

Amir Goldstein <amir73il@gmail.com>
    fanotify: prepare for setting event flags in ignore mask

Oliver Ford <ojford@gmail.com>
    fs: inotify: Fix typo in inotify comment

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Decode NFSv4 birth time attribute

Amir Goldstein <amir73il@gmail.com>
    fanotify: refine the validation checks on non-dir inode mask

NeilBrown <neilb@suse.de>
    NFS: restore module put when manager exits.

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix potential use-after-free in nfsd_file_put()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: nfsd_file_put() can sleep

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add documenting comment for nfsd4_release_lockowner()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Modernize nfsd4_release_lockowner()

Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
    nfsd: Fix null-ptr-deref in nfsd_fill_super()

Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
    nfsd: Unregister the cld notifier when laundry_wq create failed

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Use RMW bitops in single-threaded hot paths

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace filecache opens

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Move documenting comment for nfsd4_process_open2()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix whitespace

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove dprintk call sites from tail of nfsd4_open()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Instantiate a struct file when creating a regular NFSv4 file

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd_open_verified()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove do_nfsd_create()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor NFSv4 OPEN(CREATE)

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor NFSv3 CREATE

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd_create_setattr()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Avoid calling fh_drop_write() twice in do_nfsd_create()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd3_proc_create()

Dai Ngo <dai.ngo@oracle.com>
    NFSD: Show state of courtesy client in client info

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add support for lock conflict to courteous server

Dai Ngo <dai.ngo@oracle.com>
    fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict

Dai Ngo <dai.ngo@oracle.com>
    fs/lock: add helper locks_owner_has_blockers to check for blockers

Dai Ngo <dai.ngo@oracle.com>
    NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add support for share reservation conflict to courteous server

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add courteous server support for thread with only delegation

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd_splice_actor()

Vasily Averin <vvs@openvz.org>
    fanotify: fix incorrect fmode_t casts

Amir Goldstein <amir73il@gmail.com>
    fsnotify: consistent behavior for parent not watching children

Amir Goldstein <amir73il@gmail.com>
    fsnotify: introduce mark type iterator

Amir Goldstein <amir73il@gmail.com>
    fanotify: enable "evictable" inode marks

Amir Goldstein <amir73il@gmail.com>
    fanotify: use fsnotify group lock helpers

Amir Goldstein <amir73il@gmail.com>
    fanotify: implement "evictable" inode marks

Amir Goldstein <amir73il@gmail.com>
    fanotify: factor out helper fanotify_mark_update_flags()

Amir Goldstein <amir73il@gmail.com>
    fanotify: create helper fanotify_mark_user_flags()

Amir Goldstein <amir73il@gmail.com>
    fsnotify: allow adding an inode mark without pinning inode

Amir Goldstein <amir73il@gmail.com>
    dnotify: use fsnotify group lock helpers

Amir Goldstein <amir73il@gmail.com>
    nfsd: use fsnotify group lock helpers

Amir Goldstein <amir73il@gmail.com>
    inotify: use fsnotify group lock helpers

Amir Goldstein <amir73il@gmail.com>
    fsnotify: create helpers for group mark_mutex lock

Amir Goldstein <amir73il@gmail.com>
    fsnotify: make allow_dups a property of the group

Amir Goldstein <amir73il@gmail.com>
    fsnotify: pass flags argument to fsnotify_alloc_group()

Amir Goldstein <amir73il@gmail.com>
    inotify: move control flags from mask to mark flags

Dai Ngo <dai.ngo@oracle.com>
    fs/lock: documentation cleanup. Replace inode->i_lock with flc_lock.

Amir Goldstein <amir73il@gmail.com>
    fanotify: do not allow setting dirent events in mask of non-dir

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Clean up nfsd_file_put()

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Fix a write performance regression

Bang Li <libang.linuxer@gmail.com>
    fsnotify: remove redundant parameter judgment

Amir Goldstein <amir73il@gmail.com>
    fsnotify: optimize FS_MODIFY events with no ignored masks

Amir Goldstein <amir73il@gmail.com>
    fsnotify: fix merge with parent's ignored mask

Jakob Koschel <jakobkoschel@gmail.com>
    nfsd: fix using the correct variable for sizeof()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up _lm_ operation names

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove CONFIG_NFSD_V3

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Move svc_serv_ops::svo_function into struct svc_serv

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove svc_serv_ops::svo_module

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Remove svc_shutdown_net()

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Rename svc_close_xprt()

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Rename svc_create_xprt()

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Remove svo_shutdown method

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Merge svc_do_enqueue_xprt() into svc_enqueue_xprt()

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Remove the .svo_enqueue_xprt method

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove NFSD_PROC_ARGS_* macros

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Streamline the rare "found" case

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Skip extra computation for RC_NOCACHE case

Chuck Lever <chuck.lever@oracle.com>
    orDate: Thu Sep 30 19:19:57 2021 -0400

Ondrej Valousek <ondrej.valousek.xm@renesas.com>
    nfsd: Add support for the birth time attribute

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Deprecate NFS_OFFSET_MAX

Amir Goldstein <amir73il@gmail.com>
    fsnotify: invalidate dcache before IN_DELETE event

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Move fill_pre_wcc() and fill_post_wcc()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace boot verifier resets

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Rename boot verifier functions

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up the nfsd_net::nfssvc_boot field

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Write verifier might go backwards

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: De-duplicate net_generic(SVC_NET(rqstp), nfsd_net_id)

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd_vfs_write()

Jeff Layton <jeff.layton@primarydata.com>
    nfsd: Retry once in nfsd_open on an -EOPENSTALE return

Jeff Layton <jeff.layton@primarydata.com>
    nfsd: Add errno mapping for EREMOTEIO

Peng Tao <tao.peng@primarydata.com>
    nfsd: map EBADF

Vasily Averin <vvs@virtuozzo.com>
    nfsd4: add refcount for nfsd4_blocked_lock

J. Bruce Fields <bfields@redhat.com>
    nfs: block notification on fs with its own ->lock

Chuck Lever <chuck.lever@oracle.com>
    NFSD: De-duplicate nfsd4_decode_bitmap4()

J. Bruce Fields <bfields@redhat.com>
    nfsd: improve stateid access bitmask documentation

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Combine XDR error tracepoints

NeilBrown <neilb@suse.de>
    NFSD: simplify per-net file cache management

Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    NFSD: Fix inconsistent indenting

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Remove be32_to_cpu() from DRC hash function

NeilBrown <neilb@suse.de>
    NFS: switch the callback service back to non-pooled.

NeilBrown <neilb@suse.de>
    lockd: use svc_set_num_threads() for thread start and stop

NeilBrown <neilb@suse.de>
    SUNRPC: always treat sv_nrpools==1 as "not pooled"

NeilBrown <neilb@suse.de>
    SUNRPC: move the pool_map definitions (back) into svc.c

NeilBrown <neilb@suse.de>
    lockd: rename lockd_create_svc() to lockd_get()

NeilBrown <neilb@suse.de>
    lockd: introduce lockd_put()

NeilBrown <neilb@suse.de>
    lockd: move svc_exit_thread() into the thread

NeilBrown <neilb@suse.de>
    lockd: move lockd_start_svc() call into lockd_create_svc()

NeilBrown <neilb@suse.de>
    lockd: simplify management of network status notifiers

NeilBrown <neilb@suse.de>
    lockd: introduce nlmsvc_serv

NeilBrown <neilb@suse.de>
    NFSD: simplify locking for network notifier.

NeilBrown <neilb@suse.de>
    SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()

NeilBrown <neilb@suse.de>
    NFSD: Make it possible to use svc_set_num_threads_sync

NeilBrown <neilb@suse.de>
    NFSD: narrow nfsd_mutex protection in nfsd thread

NeilBrown <neilb@suse.de>
    SUNRPC: use sv_lock to protect updates to sv_nrthreads.

NeilBrown <neilb@suse.de>
    nfsd: make nfsd_stats.th_cnt atomic_t

NeilBrown <neilb@suse.de>
    SUNRPC: stop using ->sv_nrthreads as a refcount

NeilBrown <neilb@suse.de>
    SUNRPC/NFSD: clean up get/put functions.

NeilBrown <neilb@suse.de>
    SUNRPC: change svc_get() to return the svc.

NeilBrown <neilb@suse.de>
    NFSD: handle errors better in write_ports_addfd()

Eric W. Biederman <ebiederm@xmission.com>
    exit: Rename module_put_and_exit to module_put_and_kthread_exit

Eric W. Biederman <ebiederm@xmission.com>
    exit: Implement kthread_exit

Amir Goldstein <amir73il@gmail.com>
    fanotify: wire up FAN_RENAME event

Amir Goldstein <amir73il@gmail.com>
    fanotify: report old and/or new parent+name in FAN_RENAME event

Amir Goldstein <amir73il@gmail.com>
    fanotify: record either old name new name or both for FAN_RENAME

Amir Goldstein <amir73il@gmail.com>
    fanotify: record old and new parent and name in FAN_RENAME event

Amir Goldstein <amir73il@gmail.com>
    fanotify: support secondary dir fh and name in fanotify_info

Amir Goldstein <amir73il@gmail.com>
    fanotify: use helpers to parcel fanotify_info buffer

Amir Goldstein <amir73il@gmail.com>
    fanotify: use macros to get the offset to fanotify_info buffer

Amir Goldstein <amir73il@gmail.com>
    fsnotify: generate FS_RENAME event with rich information

Amir Goldstein <amir73il@gmail.com>
    fanotify: introduce group flag FAN_REPORT_TARGET_FID

Amir Goldstein <amir73il@gmail.com>
    fsnotify: separate mark iterator type from object type enum

Amir Goldstein <amir73il@gmail.com>
    fsnotify: clarify object type argument

Gabriel Krisman Bertazi <krisman@collabora.com>
    ext4: fix error code saved on super block during file system abort

J. Bruce Fields <bfields@redhat.com>
    nfsd4: remove obselete comment

Changcheng Deng <deng.changcheng@zte.com.cn>
    NFSD:fix boolreturn.cocci warning

J. Bruce Fields <bfields@redhat.com>
    nfsd: update create verifier comment

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Change return value type of .pc_encode

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Replace the "__be32 *p" parameter to .pc_encode

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Save location of NFSv4 COMPOUND status

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Change return value type of .pc_decode

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Replace the "__be32 *p" parameter to .pc_decode

Colin Ian King <colin.king@canonical.com>
    NFSD: Initialize pointer ni with NULL and not plain integer 0

NeilBrown <neilb@suse.de>
    NFSD: simplify struct nfsfh

NeilBrown <neilb@suse.de>
    NFSD: drop support for ancient filehandles

NeilBrown <neilb@suse.de>
    NFSD: move filehandle format declarations out of "uapi".

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Optimize DRC bucket pruning

Chuck Lever <chuck.lever@oracle.com>
    NFS: Move NFS protocol display macros to global header

Chuck Lever <chuck.lever@oracle.com>
    NFS: Move generic FS show macros to global header

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Tracepoints should display tk_pid and cl_clid as a fixed-size field

Chuck Lever <chuck.lever@oracle.com>
    NFS: Remove unnecessary TRACE_DEFINE_ENUM()s

Gabriel Krisman Bertazi <krisman@collabora.com>
    docs: Document the FAN_FS_ERROR event

Gabriel Krisman Bertazi <krisman@collabora.com>
    ext4: Send notifications on error

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Allow users to request FAN_FS_ERROR events

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Emit generic error info for error event

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Report fid info for file related file system errors

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: WARN_ON against too large file handles

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Add helpers to decide whether to report FID/DFID

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Wrap object_fh inline space in a creator macro

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Support merging of error events

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Support enqueueing of error events

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Pre-allocate pool of error events

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Reserve UAPI bits for FAN_FS_ERROR

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Support FS_ERROR event type

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Require fid_mode for any non-fd event

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Encode empty file handle when no inode is provided

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Allow file handle encoding for unhashed events

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Support null inode event in fanotify_dfid_inode

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Pass group argument to free_event

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Protect fsnotify_handle_inode_event from no-inode events

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Retrieve super block from the data field

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Add wrapper around fsnotify_add_event

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Add helper to detect overflow_event

Gabriel Krisman Bertazi <krisman@collabora.com>
    inotify: Don't force FS_IN_IGNORED

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Split fsid check from other fid mode checks

Gabriel Krisman Bertazi <krisman@collabora.com>
    fanotify: Fold event size calculation to its own function

Gabriel Krisman Bertazi <krisman@collabora.com>
    fsnotify: Don't insert unmergeable events in hashtable

Amir Goldstein <amir73il@gmail.com>
    fsnotify: clarify contract for create event hooks

Amir Goldstein <amir73il@gmail.com>
    fsnotify: pass dentry instead of inode data

Amir Goldstein <amir73il@gmail.com>
    fsnotify: pass data_type to fsnotify_name()

Peter Zijlstra <peterz@infradead.org>
    x86/static_call: Add support for Jcc tail-calls

Peter Zijlstra <peterz@infradead.org>
    x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions

Peter Zijlstra <peterz@infradead.org>
    x86/alternatives: Introduce int3_emulate_jcc()

Thomas Gleixner <tglx@linutronix.de>
    x86/asm: Differentiate between code and function alignment

Peter Zijlstra <peterz@infradead.org>
    arch: Introduce CONFIG_FUNCTION_ALIGNMENT

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/rfds: Mitigate Register File Data Sampling (RFDS)

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    Documentation/hw-vuln: Add documentation for RFDS

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Sean Christopherson <seanjc@google.com>
    KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/entry_32: Add VERW just before userspace transition

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/entry_64: Add VERW just before userspace transition

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bugs: Add asm helpers for executing VERW

H. Peter Anvin (Intel) <hpa@zytor.com>
    x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Limit stage2_apply_range() batch size to largest block

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Work out supported block level at compile time

Rickard x Andersson <rickaran@axis.com>
    tty: serial: imx: Fix broken RS485

John Ogness <john.ogness@linutronix.de>
    printk: Update @console_may_schedule in console_trylock_spinning()

Nicolin Chen <nicolinc@nvidia.com>
    iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

John Garry <john.garry@huawei.com>
    dma-iommu: add iommu_dma_opt_mapping_size()

John Garry <john.garry@huawei.com>
    dma-mapping: add dma_opt_mapping_size()

Will Deacon <will@kernel.org>
    swiotlb: Fix alignment checks when both allocation and DMA masks are present

David Laight <David.Laight@ACULAB.COM>
    minmax: add umin(a, b) and umax(a, b)

André Rösti <an.roesti@gmail.com>
    entry: Respect changes to system call number by trace_sys_enter()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clocksource/drivers/arm_global_timer: Fix maximum prescaler value

Jarred White <jarredwhite@linux.microsoft.com>
    ACPI: CPPC: Use access_width over bit_width for system memory accesses

Maximilian Heyne <mheyne@amazon.de>
    xen/events: close evtchn after mapping cleanup

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Avoid potential double call to gpiod_remove_lookup_table

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix kernel panic caused by incorrect error handling

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Nicolas Pitre <nico@fluxnic.net>
    vt: fix unicode buffer corruption when deleting characters

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point H DID

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point S DID

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

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Use .flush() call to wake up readers

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()

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

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    cpufreq: brcmstb-avs-cpufreq: fix up "add check for cpufreq_cpu_get's return value"

Geert Uytterhoeven <geert+renesas@glider.be>
    net: ravb: Add R-Car Gen4 support

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

Steven Rostedt (Google) <rostedt@goodmis.org>
    net: hns3: tracing: fix hclgevf trace event strings

Steven Rostedt (Google) <rostedt@goodmis.org>
    NFSD: Fix nfsd_clid_class use of __string_len() macro

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Update the Zenbleed microcode revisions

Marek Szyprowski <m.szyprowski@samsung.com>
    cpufreq: dt: always allocate zeroed cpumask

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent kernel bug at submit_bh_wbc()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix failure to detect DAT corruption in btree and direct mappings

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

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: fix reference counting on zcrypt card objects

Sean Anderson <sean.anderson@linux.dev>
    soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Anderson <sean.anderson@seco.com>
    soc: fsl: qbman: Add CGR update function

Sean Anderson <sean.anderson@seco.com>
    soc: fsl: qbman: Add helper for sanity checking cgr ops

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

Niklas Cassel <cassel@kernel.org>
    PCI: dwc: endpoint: Fix advertised resizable BAR size

Nathan Chancellor <nathan@kernel.org>
    kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1

Josef Bacik <josef@toxicpanda.com>
    nfs: fix UAF in direct writes

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

Yu Kuai <yukuai3@huawei.com>
    dm-raid: fix lockdep waring in "pers->hot_add_disk"

Paul Menzel <pmenzel@molgen.mpg.de>
    PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/DPC: Quirk PIO log size for certain Intel Root Ports

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/ASPM: Make Intel DG2 L1 acceptable latency unlimited

Bjorn Helgaas <bhelgaas@google.com>
    PCI: Work around Intel I210 ROM BAR overlap defect

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PM: Drain runtime-idle callbacks before driver removal

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: Drop pci_device_remove() test of pci_dev->driver

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Peter Collingbourne <pcc@google.com>
    serial: Lock console when calling into driver before registration

Petr Mladek <pmladek@suse.com>
    printk/console: Split out code that enables default console

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

Peter Collingbourne <pcc@google.com>
    kasan: test: add memcpy test that avoids out-of-bounds write

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

Sean Christopherson <seanjc@google.com>
    KVM: Always flush async #PF workqueue when vCPU is being destroyed

Gui-Dong Han <2045gemini@gmail.com>
    media: xc4000: Fix atomicity violation in xc4000_get_frequency

Philipp Stanner <pstanner@redhat.com>
    pci_iounmap(): Fix MMIO mapping leak

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

Lin Yujun <linyujun809@huawei.com>
    Documentation/hw-vuln: Update spectre doc


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 +
 .../admin-guide/filesystem-monitoring.rst          |   74 ++
 Documentation/admin-guide/hw-vuln/index.rst        |    1 +
 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |  104 ++
 Documentation/admin-guide/hw-vuln/spectre.rst      |   66 +-
 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |   39 +-
 Documentation/core-api/dma-api.rst                 |   14 +
 Documentation/filesystems/locking.rst              |   10 +-
 Documentation/filesystems/nfs/exporting.rst        |   33 +
 Documentation/x86/mds.rst                          |   34 +-
 MAINTAINERS                                        |    7 +
 Makefile                                           |    8 +-
 arch/Kconfig                                       |   24 +
 arch/arm/boot/dts/mmp2-brownstone.dts              |    2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |    2 +
 arch/arm64/include/asm/kvm_pgtable.h               |   18 +-
 arch/arm64/include/asm/stage2_pgtable.h            |   20 -
 arch/arm64/kvm/mmu.c                               |    9 +-
 arch/hexagon/kernel/vmlinux.lds.S                  |    1 +
 arch/ia64/Kconfig                                  |    1 +
 arch/ia64/Makefile                                 |    2 +-
 arch/openrisc/kernel/dma.c                         |   16 +-
 arch/parisc/include/asm/assembly.h                 |   18 +-
 arch/parisc/include/asm/checksum.h                 |   10 +-
 arch/powerpc/include/asm/reg_fsl_emb.h             |   11 +-
 arch/powerpc/lib/Makefile                          |    2 +-
 arch/riscv/include/asm/uaccess.h                   |    4 +-
 arch/riscv/kernel/process.c                        |    3 -
 arch/s390/kernel/entry.S                           |    1 +
 arch/sparc/kernel/nmi.c                            |    2 +-
 arch/sparc/vdso/vma.c                              |    7 +-
 arch/x86/Kconfig                                   |   38 +
 arch/x86/boot/compressed/head_64.S                 |    8 +
 arch/x86/entry/common.c                            |    6 +-
 arch/x86/entry/entry.S                             |   23 +
 arch/x86/entry/entry_32.S                          |    3 +
 arch/x86/entry/entry_64.S                          |   72 ++
 arch/x86/entry/entry_64_compat.S                   |    4 +
 arch/x86/entry/syscall_32.c                        |   21 +-
 arch/x86/entry/syscall_64.c                        |   19 +-
 arch/x86/entry/syscall_x32.c                       |   10 +-
 arch/x86/include/asm/asm-prototypes.h              |    1 +
 arch/x86/include/asm/asm.h                         |    5 +
 arch/x86/include/asm/cpufeature.h                  |    8 +-
 arch/x86/include/asm/cpufeatures.h                 |   18 +-
 arch/x86/include/asm/disabled-features.h           |    3 +-
 arch/x86/include/asm/entry-common.h                |    1 -
 arch/x86/include/asm/linkage.h                     |   12 +-
 arch/x86/include/asm/msr-index.h                   |   19 +-
 arch/x86/include/asm/nospec-branch.h               |   64 +-
 arch/x86/include/asm/required-features.h           |    3 +-
 arch/x86/include/asm/suspend_32.h                  |   10 +-
 arch/x86/include/asm/syscall.h                     |   10 +-
 arch/x86/include/asm/text-patching.h               |   31 +
 arch/x86/kernel/alternative.c                      |   56 +-
 arch/x86/kernel/cpu/amd.c                          |   10 +-
 arch/x86/kernel/cpu/bugs.c                         |  360 ++++--
 arch/x86/kernel/cpu/common.c                       |   77 +-
 arch/x86/kernel/cpu/mce/core.c                     |    4 +-
 arch/x86/kernel/cpu/scattered.c                    |    1 +
 arch/x86/kernel/kprobes/core.c                     |   38 +-
 arch/x86/kernel/nmi.c                              |    3 -
 arch/x86/kernel/static_call.c                      |   50 +-
 arch/x86/kvm/cpuid.c                               |   29 +-
 arch/x86/kvm/reverse_cpuid.h                       |   45 +-
 arch/x86/kvm/svm/sev.c                             |   18 +-
 arch/x86/kvm/vmx/run_flags.h                       |    7 +-
 arch/x86/kvm/vmx/vmenter.S                         |   11 +-
 arch/x86/kvm/vmx/vmx.c                             |   12 +-
 arch/x86/kvm/x86.c                                 |   17 +-
 arch/x86/lib/retpoline.S                           |    5 +-
 arch/x86/mm/ident_map.c                            |   23 +-
 block/blk-settings.c                               |    4 +
 crypto/algboss.c                                   |    4 +-
 drivers/accessibility/speakup/synth.c              |    4 +-
 drivers/acpi/acpica/dbnames.c                      |    8 +-
 drivers/acpi/cppc_acpi.c                           |   27 +-
 drivers/ata/ahci.c                                 |    5 -
 drivers/ata/sata_mv.c                              |   63 +-
 drivers/ata/sata_sx4.c                             |    6 +-
 drivers/base/core.c                                |   26 +-
 drivers/base/cpu.c                                 |    8 +
 drivers/base/power/wakeirq.c                       |    4 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |    2 +
 drivers/clk/qcom/gcc-ipq8074.c                     |    2 +
 drivers/clk/qcom/gcc-sdm845.c                      |    1 +
 drivers/clk/qcom/mmcc-apq8084.c                    |    2 +
 drivers/clk/qcom/mmcc-msm8974.c                    |    2 +
 drivers/clocksource/arm_global_timer.c             |    2 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |    5 +-
 drivers/cpufreq/cpufreq-dt.c                       |    2 +-
 drivers/crypto/qat/qat_common/adf_aer.c            |   23 +-
 drivers/firmware/efi/vars.c                        |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |    3 +
 drivers/gpu/drm/drm_panel.c                        |   17 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |    9 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |    3 +
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |    3 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |    3 +
 drivers/gpu/drm/imx/parallel-display.c             |    4 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   14 +-
 drivers/hid/uhid.c                                 |   20 +-
 drivers/hwmon/amc6821.c                            |   11 +
 drivers/i2c/busses/i2c-i801.c                      |    4 +-
 drivers/infiniband/core/cm_trace.h                 |    2 +-
 drivers/infiniband/core/cma_trace.h                |    2 +-
 drivers/iommu/dma-iommu.c                          |   15 +
 drivers/iommu/iova.c                               |    5 +
 drivers/md/dm-integrity.c                          |    2 +-
 drivers/md/dm-raid.c                               |    2 +
 drivers/md/dm-snap.c                               |    4 +-
 drivers/media/tuners/xc4000.c                      |    4 +-
 drivers/misc/mei/hw-me-regs.h                      |    2 +
 drivers/misc/mei/pci-me.c                          |    2 +
 drivers/mmc/core/block.c                           |   14 +-
 drivers/mmc/host/tmio_mmc_core.c                   |    2 +
 drivers/mtd/nand/raw/meson_nand.c                  |    2 +-
 drivers/mtd/ubi/fastmap.c                          |    7 +-
 drivers/mtd/ubi/vtbl.c                             |    6 +
 drivers/net/ethernet/freescale/fec_main.c          |   11 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |    8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |    8 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   14 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |    3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   82 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    5 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   34 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |   16 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |    2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   31 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   11 +-
 drivers/net/ethernet/renesas/ravb_main.c           |    8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   40 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   38 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    2 +-
 drivers/net/usb/asix.h                             |    3 +
 drivers/net/usb/asix_devices.c                     |   20 +-
 drivers/net/wireguard/netlink.c                    |   10 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   12 +-
 drivers/net/xen-netfront.c                         |    1 +
 drivers/nvme/host/core.c                           |    6 +-
 drivers/nvmem/meson-efuse.c                        |   25 +-
 drivers/of/dynamic.c                               |   12 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |    7 +-
 drivers/pci/pci-driver.c                           |   23 +-
 drivers/pci/pcie/dpc.c                             |   15 +-
 drivers/pci/pcie/err.c                             |   20 +
 drivers/pci/quirks.c                               |  100 ++
 drivers/pci/setup-res.c                            |    8 +-
 drivers/phy/tegra/xusb.c                           |   13 +
 drivers/s390/crypto/zcrypt_api.c                   |    2 +
 drivers/s390/net/qeth_core_main.c                  |   38 +-
 drivers/scsi/hosts.c                               |    7 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |    2 +-
 drivers/scsi/myrb.c                                |   20 +-
 drivers/scsi/myrs.c                                |   24 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   14 +-
 drivers/scsi/qla2xxx/qla_def.h                     |    2 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |    2 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |    2 +-
 drivers/scsi/qla2xxx/qla_init.c                    |  128 +--
 drivers/scsi/qla2xxx/qla_iocb.c                    |   68 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |    2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |    2 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   10 +
 drivers/slimbus/core.c                             |    4 +-
 drivers/soc/fsl/qbman/qman.c                       |   98 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   16 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |    5 +-
 drivers/tee/optee/device.c                         |    3 +-
 drivers/thermal/devfreq_cooling.c                  |    2 +-
 drivers/tty/serial/8250/8250_port.c                |    6 -
 drivers/tty/serial/fsl_lpuart.c                    |    7 +-
 drivers/tty/serial/imx.c                           |   22 +-
 drivers/tty/serial/sc16is7xx.c                     |   15 +-
 drivers/tty/serial/serial_core.c                   |   12 +
 drivers/tty/vt/vt.c                                |    2 +-
 drivers/usb/class/cdc-wdm.c                        |    6 +-
 drivers/usb/core/hub.c                             |   23 +-
 drivers/usb/core/hub.h                             |    2 +
 drivers/usb/core/port.c                            |    5 +-
 drivers/usb/core/sysfs.c                           |   16 +-
 drivers/usb/dwc2/core.h                            |   14 +
 drivers/usb/dwc2/core_intr.c                       |   72 +-
 drivers/usb/dwc2/gadget.c                          |   10 +
 drivers/usb/dwc2/hcd.c                             |   49 +-
 drivers/usb/dwc2/hcd_ddma.c                        |   17 +-
 drivers/usb/dwc2/hw.h                              |    2 +-
 drivers/usb/dwc2/platform.c                        |    2 +-
 drivers/usb/gadget/function/f_ncm.c                |    2 +-
 drivers/usb/gadget/udc/core.c                      |    4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |   39 +-
 drivers/usb/host/xhci.c                            |    2 +
 drivers/usb/phy/phy-generic.c                      |    7 -
 drivers/usb/serial/cp210x.c                        |    4 +
 drivers/usb/serial/ftdi_sio.c                      |    2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/option.c                        |    6 +
 drivers/usb/storage/isd200.c                       |   23 +-
 drivers/usb/storage/scsiglue.c                     |    1 -
 drivers/usb/storage/uas.c                          |   81 +-
 drivers/usb/storage/usb.c                          |    4 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   42 +-
 drivers/usb/typec/ucsi/ucsi.h                      |    4 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |    7 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  |  188 +--
 drivers/vfio/platform/vfio_platform_irq.c          |  106 +-
 drivers/vfio/virqfd.c                              |   21 +
 drivers/xen/events/events_base.c                   |    5 +-
 fs/Kconfig                                         |    2 +-
 fs/aio.c                                           |    8 +-
 fs/btrfs/scrub.c                                   |   12 +-
 fs/btrfs/volumes.c                                 |    2 +-
 fs/cifs/connect.c                                  |    2 +-
 fs/exec.c                                          |    1 +
 fs/exportfs/expfs.c                                |    8 +-
 fs/ext4/mballoc.c                                  |   17 +-
 fs/ext4/resize.c                                   |    3 +-
 fs/ext4/super.c                                    |   10 +-
 fs/fat/nfs.c                                       |    6 +
 fs/fuse/dir.c                                      |    4 +
 fs/fuse/fuse_i.h                                   |    1 -
 fs/fuse/inode.c                                    |    7 +-
 fs/ksmbd/smb2pdu.c                                 |   10 +-
 fs/lockd/host.c                                    |    2 +-
 fs/lockd/svc.c                                     |  223 ++--
 fs/lockd/svc4proc.c                                |   29 +-
 fs/lockd/svclock.c                                 |   31 +-
 fs/lockd/svcproc.c                                 |   30 +-
 fs/lockd/svcsubs.c                                 |    4 +-
 fs/lockd/xdr.c                                     |  152 ++-
 fs/lockd/xdr4.c                                    |  153 ++-
 fs/locks.c                                         |   85 +-
 fs/nfs/callback.c                                  |   96 +-
 fs/nfs/callback_xdr.c                              |    5 +-
 fs/nfs/direct.c                                    |   11 +-
 fs/nfs/export.c                                    |    9 +-
 fs/nfs/nfs4state.c                                 |    2 +-
 fs/nfs/nfs4trace.h                                 |  477 +-------
 fs/nfs/nfstrace.h                                  |  269 +----
 fs/nfs/pnfs.h                                      |    4 -
 fs/nfs/write.c                                     |    2 +-
 fs/nfsd/Kconfig                                    |   27 +-
 fs/nfsd/Makefile                                   |    8 +-
 fs/nfsd/acl.h                                      |    6 +-
 fs/nfsd/blocklayout.c                              |    1 +
 fs/nfsd/blocklayoutxdr.c                           |    1 +
 fs/nfsd/cache.h                                    |    2 +-
 fs/nfsd/export.h                                   |    1 -
 fs/nfsd/filecache.c                                | 1192 +++++++++++---------
 fs/nfsd/filecache.h                                |   19 +-
 fs/nfsd/flexfilelayout.c                           |    3 +-
 fs/nfsd/lockd.c                                    |    2 +-
 fs/nfsd/netns.h                                    |   34 +-
 fs/nfsd/nfs2acl.c                                  |   55 +-
 fs/nfsd/nfs3acl.c                                  |   83 +-
 fs/nfsd/nfs3proc.c                                 |  212 +++-
 fs/nfsd/nfs3xdr.c                                  |  444 +++-----
 fs/nfsd/nfs4acl.c                                  |   46 +-
 fs/nfsd/nfs4callback.c                             |  125 +-
 fs/nfsd/nfs4idmap.c                                |    9 +-
 fs/nfsd/nfs4layouts.c                              |    4 +-
 fs/nfsd/nfs4proc.c                                 |  986 +++++++++-------
 fs/nfsd/nfs4recover.c                              |   12 +-
 fs/nfsd/nfs4state.c                                | 1049 +++++++++++++----
 fs/nfsd/nfs4xdr.c                                  | 1115 +++++++++---------
 fs/nfsd/nfscache.c                                 |   63 +-
 fs/nfsd/nfsctl.c                                   |  146 ++-
 fs/nfsd/nfsd.h                                     |   35 +-
 fs/nfsd/nfsfh.c                                    |  264 ++---
 fs/nfsd/nfsfh.h                                    |  145 ++-
 fs/nfsd/nfsproc.c                                  |  121 +-
 fs/nfsd/nfssvc.c                                   |  263 ++---
 fs/nfsd/nfsxdr.c                                   |  178 ++-
 fs/nfsd/state.h                                    |   59 +-
 fs/nfsd/stats.c                                    |   16 +-
 fs/nfsd/stats.h                                    |    4 +-
 fs/nfsd/trace.h                                    |  692 ++++++++++--
 fs/nfsd/vfs.c                                      |  822 +++++++-------
 fs/nfsd/vfs.h                                      |   56 +-
 fs/nfsd/xdr.h                                      |   35 +-
 fs/nfsd/xdr3.h                                     |   61 +-
 fs/nfsd/xdr4.h                                     |   81 +-
 fs/nfsd/xdr4cb.h                                   |    6 +
 fs/nilfs2/btree.c                                  |    9 +-
 fs/nilfs2/direct.c                                 |    9 +-
 fs/nilfs2/inode.c                                  |    2 +-
 fs/notify/dnotify/dnotify.c                        |   15 +-
 fs/notify/fanotify/fanotify.c                      |  363 ++++--
 fs/notify/fanotify/fanotify.h                      |  212 +++-
 fs/notify/fanotify/fanotify_user.c                 |  441 ++++++--
 fs/notify/fdinfo.c                                 |   16 +-
 fs/notify/fsnotify.c                               |  177 +--
 fs/notify/fsnotify.h                               |    4 -
 fs/notify/group.c                                  |   36 +-
 fs/notify/inotify/inotify.h                        |   11 +-
 fs/notify/inotify/inotify_fsnotify.c               |    7 +-
 fs/notify/inotify/inotify_user.c                   |   53 +-
 fs/notify/mark.c                                   |  137 ++-
 fs/notify/notification.c                           |   14 +-
 fs/open.c                                          |   42 +
 fs/pipe.c                                          |   17 +-
 fs/ubifs/file.c                                    |   13 +-
 fs/vboxsf/super.c                                  |    3 +-
 include/asm-generic/vmlinux.lds.h                  |    4 +-
 include/linux/cpu.h                                |    2 +
 include/linux/device.h                             |    1 +
 include/linux/dma-map-ops.h                        |    1 +
 include/linux/dma-mapping.h                        |    5 +
 include/linux/dnotify.h                            |    2 +-
 include/linux/exportfs.h                           |   17 +-
 include/linux/fanotify.h                           |   31 +-
 include/linux/fs.h                                 |   26 +
 include/linux/fsnotify.h                           |   70 +-
 include/linux/fsnotify_backend.h                   |  356 +++++-
 include/linux/gfp.h                                |    9 +
 include/linux/hyperv.h                             |   22 +-
 include/linux/iova.h                               |    2 +
 include/linux/kthread.h                            |    1 +
 include/linux/linkage.h                            |    4 +-
 include/linux/lockd/lockd.h                        |   10 +-
 include/linux/lockd/xdr.h                          |   27 +-
 include/linux/lockd/xdr4.h                         |   29 +-
 include/linux/minmax.h                             |   17 +
 include/linux/module.h                             |    6 +-
 include/linux/nfs.h                                |    8 -
 include/linux/nfs4.h                               |   17 +
 include/linux/nfs_fs.h                             |    1 +
 include/linux/nfs_ssc.h                            |    4 +-
 include/linux/pci.h                                |    1 +
 include/linux/phy/tegra/xusb.h                     |    1 +
 include/linux/ring_buffer.h                        |    1 +
 include/linux/secretmem.h                          |    4 +-
 include/linux/sunrpc/svc.h                         |   93 +-
 include/linux/sunrpc/svc_xprt.h                    |   11 +-
 include/linux/sunrpc/svcsock.h                     |    7 +-
 include/linux/sunrpc/xdr.h                         |    2 +
 include/linux/timer.h                              |   18 +-
 include/linux/udp.h                                |   28 +
 include/linux/vfio.h                               |    2 +
 include/net/cfg802154.h                            |    1 +
 include/net/inet_connection_sock.h                 |    1 +
 include/net/sock.h                                 |    7 +
 include/soc/fsl/qman.h                             |    9 +
 include/trace/events/rpcgss.h                      |   18 +-
 include/trace/events/rpcrdma.h                     |   44 +-
 include/trace/events/sunrpc.h                      |   74 +-
 include/trace/misc/fs.h                            |  122 ++
 include/trace/misc/nfs.h                           |  387 +++++++
 include/trace/{events => misc}/rdma.h              |    0
 include/trace/misc/sunrpc.h                        |   18 +
 include/uapi/linux/fanotify.h                      |   29 +
 include/uapi/linux/nfsd/nfsfh.h                    |  115 --
 init/initramfs.c                                   |    2 +-
 io_uring/io_uring.c                                |    2 +-
 kernel/audit_fsnotify.c                            |    8 +-
 kernel/audit_tree.c                                |    2 +-
 kernel/audit_watch.c                               |    5 +-
 kernel/bounds.c                                    |    2 +-
 kernel/bpf/verifier.c                              |    5 +
 kernel/dma/mapping.c                               |   12 +
 kernel/dma/swiotlb.c                               |   11 +-
 kernel/entry/common.c                              |    8 +-
 kernel/events/core.c                               |    9 +
 kernel/kthread.c                                   |   23 +-
 kernel/locking/rwsem.c                             |   14 +-
 kernel/module.c                                    |    8 +-
 kernel/power/suspend.c                             |    1 +
 kernel/printk/printk.c                             |   63 +-
 kernel/time/timer.c                                |  160 +--
 kernel/trace/ring_buffer.c                         |  233 ++--
 kernel/trace/trace.c                               |   21 +-
 lib/Kconfig.debug                                  |    1 +
 lib/pci_iomap.c                                    |    2 +-
 lib/test_kasan.c                                   |   21 +-
 mm/compaction.c                                    |    7 +-
 mm/memtest.c                                       |    4 +-
 mm/migrate.c                                       |    6 +-
 mm/page_alloc.c                                    |   10 +-
 mm/swapfile.c                                      |   25 +-
 mm/vmscan.c                                        |    5 +-
 net/bluetooth/bnep/core.c                          |    2 +-
 net/bluetooth/cmtp/core.c                          |    2 +-
 net/bluetooth/hci_debugfs.c                        |   64 +-
 net/bluetooth/hci_event.c                          |   25 +
 net/bluetooth/hidp/core.c                          |    2 +-
 net/bridge/netfilter/ebtables.c                    |    6 +
 net/core/skbuff.c                                  |    6 +-
 net/core/sock_map.c                                |    6 +
 net/ipv4/inet_connection_sock.c                    |   14 +
 net/ipv4/ip_gre.c                                  |    5 +
 net/ipv4/netfilter/arp_tables.c                    |    4 +
 net/ipv4/netfilter/ip_tables.c                     |    4 +
 net/ipv4/tcp.c                                     |    2 +
 net/ipv4/udp.c                                     |    7 +
 net/ipv4/udp_offload.c                             |   20 +-
 net/ipv6/ip6_fib.c                                 |   14 +-
 net/ipv6/ip6_gre.c                                 |    3 +
 net/ipv6/netfilter/ip6_tables.c                    |    4 +
 net/ipv6/udp.c                                     |    2 +-
 net/ipv6/udp_offload.c                             |    8 +-
 net/mac80211/cfg.c                                 |    5 +-
 net/mac802154/llsec.c                              |   18 +-
 net/mptcp/protocol.c                               |    3 -
 net/mptcp/subflow.c                                |    3 +
 net/netfilter/nf_tables_api.c                      |   20 +-
 net/nfc/nci/core.c                                 |    5 +
 net/rds/rdma.c                                     |    2 +-
 net/sched/act_skbmod.c                             |   10 +-
 net/sunrpc/svc.c                                   |  227 ++--
 net/sunrpc/svc_xprt.c                              |   68 +-
 net/sunrpc/svcsock.c                               |   24 +-
 net/sunrpc/xdr.c                                   |   22 +
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c         |    2 +-
 net/xfrm/xfrm_user.c                               |    3 +
 scripts/Makefile.extrawarn                         |    2 +
 security/landlock/syscalls.c                       |   18 +-
 security/smack/smack_lsm.c                         |   12 +-
 sound/pci/hda/patch_realtek.c                      |    9 +-
 sound/sh/aica.c                                    |   17 +-
 sound/soc/codecs/rt5682-sdw.c                      |    4 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |    4 +-
 sound/soc/codecs/rt711-sdw.c                       |    4 +-
 sound/soc/soc-ops.c                                |    2 +-
 tools/objtool/check.c                              |    3 +-
 tools/testing/selftests/mqueue/setting             |    1 +
 tools/testing/selftests/net/mptcp/diag.sh          |    6 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |    7 +
 tools/testing/selftests/net/reuseaddr_conflict.c   |    2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |   10 +-
 virt/kvm/async_pf.c                                |   31 +-
 445 files changed, 11948 insertions(+), 6886 deletions(-)



