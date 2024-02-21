Return-Path: <linux-kernel+bounces-74747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D485D896
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB692822ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F769D24;
	Wed, 21 Feb 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xptMGF0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771769961;
	Wed, 21 Feb 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520486; cv=none; b=Mvqw1Xb61nT7kIN56NH4joWM6+DVm47SJDAG8RicyHAuejmgRa42rg+zcgjAID8Z10R433tixbT0dnOaQ0lEsvxECatnSolYbcIlUR4WFpqzi/Sp+0DADF4r5pnRZtn8YEJnd1V03Ro0zHuuQh9uRwLpnXZ8iWVod4EIX/VTFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520486; c=relaxed/simple;
	bh=gVG2OFTJpKzw+o+KXjybmo9937kO19CABktD3Os7xX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vc1pvqZk4qI/ziToD5p/hA4BcFHEYBYwnGymNJcITgPNPcmQlgY8sShkrpXLy09o5IVsY91JQxE7ISXowgVgi5z2dPZ8Ysh80MKilH6OSKAEfRCPCBOvPp+b9nbDlLAtks6mm+G7Kzc/5FYatwsVuLjIsP2qzhPvBMay/h4i/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xptMGF0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6509AC43394;
	Wed, 21 Feb 2024 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708520485;
	bh=gVG2OFTJpKzw+o+KXjybmo9937kO19CABktD3Os7xX0=;
	h=From:To:Cc:Subject:Date:From;
	b=xptMGF0xd0oBIsTBkzHY8Twq5O/Sc9v/jbqq8OKvjXHOMQqarKvPJ+298ihBbNFr4
	 YO/VjPYwTxDcdclVcR+6QpXNAS+f3GN8NNRXTzhuhuQxYcy1+juNMwQq8LHkDfNPlI
	 uDEbjooRXe6N3skuA54wWIo154JCE2dXBOxo45W4=
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
	allen.lkml@gmail.com
Subject: [PATCH 6.6 000/338] 6.6.18-rc2 review
Date: Wed, 21 Feb 2024 14:01:21 +0100
Message-ID: <20240221125953.770767246@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.18-rc2
X-KernelTest-Deadline: 2024-02-23T13:00+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.18 release.
There are 338 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.18-rc2

Dan Carpenter <dan.carpenter@linaro.org>
    tracing: Fix a NULL vs IS_ERR() bug in event_subsystem_dir()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Make system_callback() function static

Vegard Nossum <vegard.nossum@oracle.com>
    Documentation/arch/ia64/features.rst: fix kernel-feat directive

Borislav Petkov (AMD) <bp@alien8.de>
    x86/barrier: Do not serialize MSR accesses on AMD

Mikulas Patocka <mpatocka@redhat.com>
    dm: limit the number of targets and parameter size area

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential bug in end_buffer_async_write

Saravana Kannan <saravanak@google.com>
    of: property: Add in-ports/out-ports support to of_graph_get_port_parent()

Linus Torvalds <torvalds@linuxfoundation.org>
    sched/membarrier: reduce the ability to hammer on sys_membarrier

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Increase section and file alignment to 4k/512

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Split off PE/COFF .data section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Drop PE/COFF .reloc section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Construct PE/COFF .text section from assembler

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Derive file size from _edata symbol

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Define setup size in linker script

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Set EFI handover offset directly in header asm

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Grab kernel_info offset from zoffset header directly

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Drop references to startup_64

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Drop redundant code setting the root device

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Omit compression buffer from PE/COFF image memory footprint

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Remove the 'bugger off' message

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Drop alignment flags from PE section headers

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Disregard setup header of loaded image

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Drop EFI stub .bss from .data section

NeilBrown <neilb@suse.de>
    nfsd: don't take fi_lock in nfsd_break_deleg_cb()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Keep all directory links at 1

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove fsnotify*() functions from lookup()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Restructure eventfs_inode structure to be more condensed

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Warn if an eventfs_inode is freed without is_freed being set

Linus Torvalds <torvalds@linux-foundation.org>
    eventfs: Get rid of dentry pointers without refcounts

Linus Torvalds <torvalds@linux-foundation.org>
    eventfs: Clean up dentry ops and add revalidate function

Linus Torvalds <torvalds@linux-foundation.org>
    eventfs: Remove unused d_parent pointer field

Linus Torvalds <torvalds@linux-foundation.org>
    tracefs: dentry lookup crapectomy

Linus Torvalds <torvalds@linux-foundation.org>
    tracefs: Avoid using the ei->dentry pointer unnecessarily

Linus Torvalds <torvalds@linux-foundation.org>
    eventfs: Initialize the tracefs inode properly

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracefs: Zero out the tracefs_inode when allocating it

Linus Torvalds <torvalds@linux-foundation.org>
    tracefs: remove stale update_gid code

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Save directory inodes in the eventfs_inode structure

Erick Archer <erick.archer@gmx.com>
    eventfs: Use kcalloc() instead of kzalloc()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Do not create dentries nor inodes in iterate_shared

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Have the inodes all for files and directories all be the same

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Shortcut eventfs_iterate() by skipping entries already read

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Read ei->entries before ei->children in eventfs_iterate()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Do ctx->pos update for all iterations in eventfs_iterate()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracefs/eventfs: Use root and instance inodes as default ownership

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Stop using dcache_readdir() for getdents()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove "lookup" parameter from create_dir/file_dentry()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Fix bitwise fields for "is_events"

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracefs: Check for dentry->d_inode exists in set_gid()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Fix file and directory uid and gid ownership

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Have event files and directories default to parent uid and gid

Beau Belgrave <beaub@linux.microsoft.com>
    eventfs: Fix events beyond NAME_MAX blocking tasks

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Make sure that parent->d_inode is locked in creating files/dirs

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Do not allow NULL parent to eventfs_start_creating()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Do not invalidate dentry in create_file/dir_dentry()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove expectation that ei->is_freed means ei->dentry == NULL

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Use simple_recursive_removal() to clean up dentries

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove special processing of dput() of events directory

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Delete eventfs_inode when the last dentry is freed

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Hold eventfs_mutex when calling callback functions

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Save ownership and mode

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Test for ei->is_freed when accessing ei->dentry

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Have a free_ei() that just frees the eventfs_inode

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove "is_freed" union with rcu head

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Fix kerneldoc of eventfs_remove_rec()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove extra dget() in eventfs_create_events_dir()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Fix typo in eventfs_inode union comment

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Fix WARN_ON() in create_file_dentry()

Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    tracefs/eventfs: Modify mismatched function name

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Fix failure path in eventfs_create_events_dir()

Nathan Chancellor <nathan@kernel.org>
    eventfs: Use ERR_CAST() in eventfs_create_events_dir()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Use eventfs_remove_events_dir()

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove eventfs_file and just use eventfs_inode

Steven Rostedt (Google) <rostedt@goodmis.org>
    Revert "eventfs: Remove "is_freed" union with rcu head"

Steven Rostedt (Google) <rostedt@goodmis.org>
    Revert "eventfs: Save ownership and mode"

Steven Rostedt (Google) <rostedt@goodmis.org>
    Revert "eventfs: Delete eventfs_inode when the last dentry is freed"

Steven Rostedt (Google) <rostedt@goodmis.org>
    Revert "eventfs: Use simple_recursive_removal() to clean up dentries"

Steven Rostedt (Google) <rostedt@goodmis.org>
    Revert "eventfs: Check for NULL ef in eventfs_set_attr()"

Steven Rostedt (Google) <rostedt@goodmis.org>
    Revert "eventfs: Do not allow NULL parent to eventfs_start_creating()"

Helge Deller <deller@gmx.de>
    parisc: Fix random data corruption from exception handler

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Missing gc cancellations fixed

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix performance regression in swap operation

Damien Le Moal <dlemoal@kernel.org>
    block: fix partial zone append completion handling in req_bio_endio()

Junxiao Bi <junxiao.bi@oracle.com>
    md: bypass block throttle for superblock update

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Inform kmemleak of saved_cmdlines allocation

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef

Oleg Nesterov <oleg@redhat.com>
    fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()

Konrad Dybcio <konrad.dybcio@linaro.org>
    pmdomain: core: Move the unused cleanup to a _sync initcall

Oleksij Rempel <o.rempel@pengutronix.de>
    can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Ziqi Zhao <astrajoan@yahoo.com>
    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

Maxime Jayat <maxime.jayat@mobile-devices.fr>
    can: netlink: Fix TDCO calculation using the old data bittiming

Nuno Sa <nuno.sa@analog.com>
    of: property: fix typo in io-channels

Vegard Nossum <vegard.nossum@oracle.com>
    docs: kernel_feat.py: fix build error for missing files

Jan Kara <jack@suse.cz>
    blk-wbt: Fix detection of dirty-throttled tasks

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Fix earlycon parameter if KASAN enabled

Prakash Sangappa <prakash.sangappa@oracle.com>
    mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Oscar Salvador <osalvador@suse.de>
    fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Rishabh Dave <ridave@redhat.com>
    ceph: prevent use-after-free in encode_cap_msg()

Shradha Gupta <shradhagupta@linux.microsoft.com>
    hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Petr Tesarik <petr@tesarici.cz>
    net: stmmac: protect updates of 64-bit statistics counters

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Sinthu Raja <sinthu.raja@ti.com>
    net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Sinthu Raja <sinthu.raja@ti.com>
    net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio

Christian Brauner <brauner@kernel.org>
    fs: relax mount_setattr() permission checks

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Fix Makefile compiler options for clang

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Fix uninitialized bucket/data->bucket_size warning

John Kacur <jkacur@redhat.com>
    tools/rtla: Exit with EXIT_SUCCESS when help is invoked

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Fix clang warning about mount_point var size

limingming3 <limingming890315@gmail.com>
    tools/rtla: Replace setting prio with nice for SCHED_OTHER

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Remove unused sched_getattr() function

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rv: Fix Makefile compiler options for clang

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rv: Fix curr_reactor uninitialized variable

Mario Limonciello <mario.limonciello@amd.com>
    ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8

Gergo Koteles <soyer@irl.hu>
    ASoC: tas2781: add module parameter to tascodec_init()

Curtis Malainey <cujomalainey@chromium.org>
    ASoC: SOF: IPC3: fix message bounds on ipc ops

Easwar Hariharan <eahariha@linux.microsoft.com>
    arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Mark Brown <broonie@kernel.org>
    arm64/signal: Don't assume that TIF_SVE means we saved SVE state

Fred Ai <fred.ai@bayhubtech.com>
    mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be detected by BIOS

Damien Le Moal <dlemoal@kernel.org>
    zonefs: Improve error handling

Sebastian Ene <sebastianene@google.com>
    KVM: arm64: Fix circular locking dependency

Steve French <stfrench@microsoft.com>
    smb: Fix regression in writes when non-standard maximum write size negotiated

Paulo Alcantara <pc@manguebit.com>
    smb: client: set correct id, uid and cruid for multiuser automounts

Mohammad Rahimi <rahimi.mhmmd@gmail.com>
    thunderbolt: Fix setting the CNS bit in ROUTER_CS_5

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems

Doug Berger <opendmb@gmail.com>
    irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: mvm: fix a crash when we run out of stations

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix wiphy delayed work queueing

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fix double-free bug

Daniel de Villiers <daniel.devilliers@corigine.com>
    nfp: flower: prevent re-adding mac index for bonded port

James Hershaw <james.hershaw@corigine.com>
    nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag

Daniel Basilio <daniel.basilio@corigine.com>
    nfp: use correct macro for LengthSelect in BAR config

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: algif_hash - Remove bogus SGL free on zero-length error path

Kim Phillips <kim.phillips@amd.com>
    crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix data corruption in dsync block recovery for small block sizes

Shuming Fan <shumingf@realtek.com>
    ALSA: hda/realtek: add IDs for Dell dual spk platform

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Add quirk for SWS JS201D

Eniac Zhang <eniac-xw.zhang@hp.com>
    ALSA: hda/realtek: fix mute/micmute LED For HP mt645

Alexander Stein <alexander.stein@ew.tq-group.com>
    mmc: slot-gpio: Allow non-sleeping GPIO ro

Jens Axboe <axboe@kernel.dk>
    io_uring/net: fix multishot accept overflow handling

Steve Wahl <steve.wahl@hpe.com>
    x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Mingwei Zhang <mizhang@google.com>
    KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl

Prasad Pandit <pjp@fedoraproject.org>
    KVM: x86: make KVM_REQ_NMI request iff NMI pending for vcpu

Andrei Vagin <avagin@google.com>
    x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Aleksander Mazur <deweloper@wp.pl>
    x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    serial: mxs-auart: fix tx

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    serial: core: introduce uart_port_tx_flags()

Shrikanth Hegde <sshegde@linux.ibm.com>
    powerpc/pseries: fix accuracy of stolen time

David Engraf <david.engraf@sysgo.com>
    powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E

Naveen N Rao <naveen@kernel.org>
    powerpc/64: Set task pt_regs->link to the LR value on scv entry

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: prevent infinite while() loop in port startup

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: fail probe if clock crystal is unstable

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: improve crystal stable clock detection

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: set default value when reading clock ready bit

Hui Zhou <hui.zhou@corigine.com>
    nfp: flower: fix hardware offload for the transfer layer port

Hui Zhou <hui.zhou@corigine.com>
    nfp: flower: add hardware offload check for post ct entry

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads

Vincent Donnefort <vdonnefort@google.com>
    ring-buffer: Clean ring_buffer_poll_wait() error return

Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
    hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Tom Chung <chiahsuan.chung@amd.com>
    drm/amd/display: Preserve original aspect ratio in create stream

Nathan Chancellor <nathan@kernel.org>
    drm/amd/display: Increase frame-larger-than for all display_mode_vba files

Fangzhi Zuo <jerry.zuo@amd.com>
    drm/amd/display: Fix MST Null Ptr for RV

Thong <thong.thai@amd.com>
    drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolution

Philip Yang <Philip.Yang@amd.com>
    drm/prime: Support page array >= 4GB

Zhikai Zhai <zhikai.zhai@amd.com>
    drm/amd/display: Add align done check

Rob Clark <robdclark@chromium.org>
    drm/msm: Wire up tlb ops

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Sean Young <sean@mess.org>
    media: rc: bpf attach/detach requires write permission

Eugen Hristev <eugen.hristev@collabora.com>
    pmdomain: mediatek: fix race conditions with genpd

Sam Protsenko <semen.protsenko@linaro.org>
    iio: pressure: bmp280: Add missing bmp085 to SPI id table

Randy Dunlap <rdunlap@infradead.org>
    iio: imu: bno055: serdev requires REGMAP

Nuno Sa <nuno.sa@analog.com>
    iio: imu: adis: ensure proper DMA alignment

Nuno Sa <nuno.sa@analog.com>
    iio: adc: ad_sigma_delta: ensure proper DMA alignment

Mario Limonciello <mario.limonciello@amd.com>
    iio: accel: bma400: Fix a compilation problem

Nuno Sa <nuno.sa@analog.com>
    iio: commom: st_sensors: ensure proper DMA alignment

Dinghao Liu <dinghao.liu@zju.edu.cn>
    iio: core: fix memleak in iio_device_register_sysfs

zhili.liu <zhili.liu@ucas.com.cn>
    iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

David Schiller <david.schiller@jku.at>
    staging: iio: ad5933: fix type mismatch regression

Tejun Heo <tj@kernel.org>
    Revert "workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()"

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to search structure fields correctly

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to set arg size and fmt after setting type from BTF

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to show a parse error for bad type for $comm

Thorsten Blum <thorsten.blum@toblux.com>
    tracing/synthetic: Fix trace_string() return value

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix wasted memory in saved_cmdlines logic

Daniel Bristot de Oliveira <bristot@kernel.org>
    tracing/timerlat: Move hrtimer_init to timerlat_fd open()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Baokun Li <libaokun1@huawei.com>
    ext4: fix double-free of blocks due to wrong extents moved_len

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Mark all sessions as invalid in cb_remove

Carlos Llamas <cmllamas@google.com>
    binder: signal epoll threads of self-work

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wcd938x: handle deferred probe

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add speaker pin verbtable for Dell dual speaker platform

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Mark Brown <broonie@kernel.org>
    usb: typec: tpcm: Fix issues with power being removed during reset

Nathan Chancellor <nathan@kernel.org>
    modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS

Masahiro Yamada <masahiroy@kernel.org>
    linux/init: remove __memexit* annotations

Nathan Chancellor <nathan@kernel.org>
    um: Fix adding '-no-pie' for clang

Jan Beulich <jbeulich@suse.com>
    xen-netback: properly sync TX responses

Helge Deller <deller@gmx.de>
    parisc: BTLB: Fix crash when setting up BTLB at CPU bringup

Esben Haabendal <esben@geanix.com>
    net: stmmac: do not clear TBS enable bit on link up/down

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Fedor Pchelkin <pchelkin@ispras.ru>
    nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Nathan Chancellor <nathan@kernel.org>
    kbuild: Fix changing ELF file type for output of gen_btf for big endian

José Relvas <josemonsantorelvas@gmail.com>
    ALSA: hda/realtek: Apply headset jack quirk for non-bass alc287 thinkpads

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct documentation of fw_csr_string() kernel API

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix the logic in security_inode_getsecctx()

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix default return value of the socket_getpeersec_*() hooks

David McFarland <corngood@gmail.com>
    drm/amd: Don't init MEC2 firmware when it fails to load

Friedrich Vock <friedrich.vock@gmx.de>
    drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Sebastian Ott <sebott@redhat.com>
    drm/virtio: Set segment size for virtio_gpu device

Keqi Wang <wangkeqi_chris@163.com>
    connector/cn_proc: revert "connector: Fix proc_event_num_listeners count not cleared"

Rob Clark <robdclark@chromium.org>
    Revert "drm/msm/gpu: Push gpu lock down past runpm"

Mario Limonciello <mario.limonciello@amd.com>
    Revert "drm/amd: flush any delayed gfxoff on suspend entry"

Lee Duncan <lduncan@suse.com>
    scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: Revert "media: rkisp1: Drop IRQF_SHARED"

Michael Ellerman <mpe@ellerman.id.au>
    Revert "powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add"

Paolo Abeni <pabeni@redhat.com>
    mptcp: really cope with fastopen race

Geliang Tang <geliang@kernel.org>
    mptcp: check addrs list in userspace_pm_get_local_id

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix rcv space initialization

Paolo Abeni <pabeni@redhat.com>
    mptcp: drop the push_pending field

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: add mptcp_lib_kill_wait

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: allow changing subtests prefix

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: increase timeout to 30 min

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Mangle

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Filter in v6

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Filter

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix data re-injection from stale subflow

Arnd Bergmann <arnd@arndb.de>
    kallsyms: ignore ARMv4 thunks along with others

Radek Krejci <radek.krejci@oracle.com>
    modpost: trim leading spaces when processing source files list

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Fix block process call transactions

Arnd Bergmann <arnd@arndb.de>
    i2c: pasemi: split driver into two separate modules

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/kasan: Limit KASAN thread size increase to 32KB

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors

Bibo Mao <maobibo@loongson.cn>
    irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_alloc()

Viken Dadhaniya <quic_vdadhani@quicinc.com>
    i2c: qcom-geni: Correct I2C TRE sequence

Dan Carpenter <dan.carpenter@linaro.org>
    cifs: fix underflow in parse_server_interfaces()

Cosmin Tanislav <demonsingur@gmail.com>
    iio: adc: ad4130: only set GPIO_CTRL if pin is unused

Cosmin Tanislav <demonsingur@gmail.com>
    iio: adc: ad4130: zero-initialize clock init data

Alex Williamson <alex.williamson@redhat.com>
    PCI: Fix active state requirement in PME polling

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "kobject: Remove redundant checks for whether ktype is NULL"

Jiangfeng Xiao <xiaojiangfeng@huawei.com>
    powerpc/kasan: Fix addr error caused by page alignment

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    powerpc/6xx: set High BAT Enable flag on G2_LE cores

Gaurav Batra <gbatra@linux.ibm.com>
    powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add

Saravana Kannan <saravanak@google.com>
    driver core: fw_devlink: Improve detection of overlapping cycles

Zhipeng Lu <alexious@zju.edu.cn>
    media: ir_toy: fix a memleak in irtoy_tx

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8550: Enable sync_state

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc8180x: Mark CO0 BCM keepalive

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

Udipto Goswami <quic_ugoswami@quicinc.com>
    usb: core: Prevent null pointer dereference in update_port_device_state

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: core: handle power lost in workqueue

yuan linyu <yuanlinyu@hihonor.com>
    usb: f_mass_storage: forbid async queue when shutdown happen

Oliver Neukum <oneukum@suse.com>
    USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi_acpi: Fix command completion handling

Sean Anderson <sean.anderson@seco.com>
    usb: ulpi: Fix debugfs directory leak

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi: Add missing ppm_lock

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Do not register input devices until after hid_hw_start

Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>
    HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Johan Hovold <johan+linaro@kernel.org>
    HID: i2c-hid-of: fix NULL-deref on failed power up

Benjamin Tissoires <bentiss@kernel.org>
    HID: bpf: actually free hdev memory after attaching a HID-BPF program

Benjamin Tissoires <bentiss@kernel.org>
    HID: bpf: remove double fdget()

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

David Senoner <seda18@rolmail.net>
    ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

Helge Deller <deller@gmx.de>
    parisc: Prevent hung tasks when printing inventory on serial console

Techno Mooney <techno.mooney@gmail.com>
    ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt, dm-verity: disable tasklets

Dave Airlie <airlied@redhat.com>
    nouveau: offload fence uevents work to workqueue

Michael Kelley <mhklinux@outlook.com>
    scsi: storvsc: Fix ring buffer size calculation

Nico Pache <npache@redhat.com>
    selftests: mm: fix map_hugetlb failure on 64K page size systems

Audra Mitchell <audra@redhat.com>
    selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 flag

Zach O'Keefe <zokeefe@google.com>
    mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Muhammad Usama Anjum <usama.anjum@collabora.com>
    selftests/mm: switch to bash from sh

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/trigger: Fix to return error if failed to alloc snapshot

Samuel Holland <samuel.holland@sifive.com>
    scs: add CONFIG_MMU dependency for vfree_atomic()

Ryan Roberts <ryan.roberts@arm.com>
    selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix waiting for queues of all VSIs to be disabled

Ivan Vecera <ivecera@redhat.com>
    i40e: Do not allow untrusted VF to remove administratively set MAC

Jiaxun Yang <jiaxun.yang@flygoat.com>
    mm/memory: Use exception ip to search exception tables

Jiaxun Yang <jiaxun.yang@flygoat.com>
    ptrace: Introduce exception_ip arch hook

Guenter Roeck <linux@roeck-us.net>
    MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Arnd Bergmann <arnd@arndb.de>
    nouveau/svm: fix kvcalloc() argument order

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path for statistics

Alexey Khoroshilov <khoroshilov@ispras.ru>
    ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: ppc4xx: Drop write-only variable

Jakub Kicinski <kuba@kernel.org>
    net: tls: fix returned read length with async decrypt

Sabrina Dubroca <sd@queasysnail.net>
    net: tls: fix use-after-free with partial reads and async decrypt

Jakub Kicinski <kuba@kernel.org>
    net: tls: handle backlogging of crypto requests

Jakub Kicinski <kuba@kernel.org>
    tls: fix race between tx work scheduling and socket close

Jakub Kicinski <kuba@kernel.org>
    tls: fix race between async notify and socket close

Jakub Kicinski <kuba@kernel.org>
    net: tls: factor out tls_*crypt_async_wait()

Sabrina Dubroca <sd@queasysnail.net>
    tls: extract context alloc/initialization out of tls_set_sw_offload

Horatiu Vultur <horatiu.vultur@microchip.com>
    lan966x: Fix crash when adding interface under a lag

Aaron Conole <aconole@redhat.com>
    net: openvswitch: limit the number of recursions from action sets

Ido Schimmel <idosch@nvidia.com>
    selftests: forwarding: Fix bridge locked port test flakiness

Ido Schimmel <idosch@nvidia.com>
    selftests: forwarding: Suppress grep warnings

Ido Schimmel <idosch@nvidia.com>
    selftests: bridge_mdb: Use MDB get instead of dump

Ido Schimmel <idosch@nvidia.com>
    selftests: forwarding: Fix bridge MDB test flakiness

Ido Schimmel <idosch@nvidia.com>
    selftests: forwarding: Fix layer 2 miss test flakiness

Ido Schimmel <idosch@nvidia.com>
    selftests: net: Fix bridge backup port test flakiness

Hangbin Liu <liuhangbin@gmail.com>
    selftests/net: convert test_bridge_backup_port.sh to run it in unique namespace

Hojin Nam <hj96.nam@samsung.com>
    perf: CXL: fix mismatched cpmu event opcode

Lukas Bulwahn <lukas.bulwahn@gmail.com>
    ALSA: hda/cs35l56: select intended config FW_CS_DSP

Saravana Kannan <saravanak@google.com>
    of: property: Improve finding the supplier of a remote-endpoint property

Saravana Kannan <saravanak@google.com>
    of: property: Improve finding the consumer of a remote-endpoint property

Parav Pandit <parav@nvidia.com>
    devlink: Fix command annotation documentation

Magnus Karlsson <magnus.karlsson@intel.com>
    bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY

Chuck Lever <chuck.lever@oracle.com>
    net/handshake: Fix handshake_req_destroy_test1

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: SOF: ipc3-topology: Fix pipeline tear down logic

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: iwlwifi: Fix some error codes

Sean Christopherson <seanjc@google.com>
    KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test

Carlos Song <carlos.song@nxp.com>
    spi: imx: fix the burst length at DMA mode and CPU mode

Rob Clark <robdclark@chromium.org>
    drm/msm/gem: Fix double resv lock aquire

Christian A. Ehrhardt <lk@c--e.de>
    of: unittest: Fix compile in the non-dynamic case

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: selftests: Avoid infinite loop in hyperv_features when invtsc is missing

Sean Christopherson <seanjc@google.com>
    KVM: selftests: Delete superfluous, unused "stage" variable in AMX test

Hu Yadi <hu.yadi@h3c.com>
    selftests/landlock: Fix fs_test build with old libc

Saravana Kannan <saravanak@google.com>
    driver core: Fix device_link_flag_is_sync_state_only()

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't drop extent_map for free space inode on write error

Filipe Manana <fdmanana@suse.com>
    btrfs: reject encoded write if inode has nodatasum flag set

Filipe Manana <fdmanana@suse.com>
    btrfs: don't reserve space for checksums when writing to nocow files

David Sterba <dsterba@suse.com>
    btrfs: send: return EOPNOTSUPP on unknown flags

Boris Burkov <boris@bur.io>
    btrfs: forbid deleting live subvol qgroup

Qu Wenruo <wqu@suse.com>
    btrfs: do not ASSERT() if the newly created subvolume already got read

Boris Burkov <boris@bur.io>
    btrfs: forbid creating subvol qgroups

Filipe Manana <fdmanana@suse.com>
    btrfs: do not delete unused block group if it may be used soon

Filipe Manana <fdmanana@suse.com>
    btrfs: add and use helper to check if block group is used

Linus Torvalds <torvalds@linux-foundation.org>
    update workarounds for gcc "asm goto" issue

Linus Torvalds <torvalds@linux-foundation.org>
    work around gcc bugs with 'asm goto' with outputs


-------------

Diffstat:

 .../ABI/testing/sysfs-class-net-statistics         |   48 +-
 Documentation/arch/arm64/silicon-errata.rst        |    7 +
 Documentation/arch/ia64/features.rst               |    2 +-
 Documentation/networking/devlink/devlink-port.rst  |    2 +-
 Documentation/sphinx/kernel_feat.py                |    2 +-
 Makefile                                           |    4 +-
 arch/Kconfig                                       |    1 +
 arch/arc/include/asm/jump_label.h                  |    4 +-
 arch/arm/include/asm/jump_label.h                  |    4 +-
 arch/arm64/include/asm/alternative-macros.h        |    4 +-
 arch/arm64/include/asm/cputype.h                   |    4 +
 arch/arm64/include/asm/jump_label.h                |    4 +-
 arch/arm64/kernel/cpu_errata.c                     |    3 +
 arch/arm64/kernel/fpsimd.c                         |    2 +-
 arch/arm64/kernel/signal.c                         |    4 +-
 arch/arm64/kvm/pkvm.c                              |   27 +-
 arch/csky/include/asm/jump_label.h                 |    4 +-
 arch/loongarch/include/asm/jump_label.h            |    4 +-
 arch/loongarch/mm/kasan_init.c                     |    3 +
 arch/mips/include/asm/checksum.h                   |    3 +-
 arch/mips/include/asm/jump_label.h                 |    4 +-
 arch/mips/include/asm/ptrace.h                     |    2 +
 arch/mips/kernel/ptrace.c                          |    7 +
 arch/parisc/Kconfig                                |    1 -
 arch/parisc/include/asm/assembly.h                 |    1 +
 arch/parisc/include/asm/extable.h                  |   64 +
 arch/parisc/include/asm/jump_label.h               |    4 +-
 arch/parisc/include/asm/special_insns.h            |    6 +-
 arch/parisc/include/asm/uaccess.h                  |   48 +-
 arch/parisc/kernel/cache.c                         |    6 +-
 arch/parisc/kernel/drivers.c                       |    3 +
 arch/parisc/kernel/unaligned.c                     |   44 +-
 arch/parisc/mm/fault.c                             |   11 +-
 arch/powerpc/include/asm/jump_label.h              |    4 +-
 arch/powerpc/include/asm/reg.h                     |    2 +
 arch/powerpc/include/asm/thread_info.h             |    2 +-
 arch/powerpc/include/asm/uaccess.h                 |   12 +-
 arch/powerpc/kernel/cpu_setup_6xx.S                |   20 +-
 arch/powerpc/kernel/cpu_specs_e500mc.h             |    3 +-
 arch/powerpc/kernel/interrupt_64.S                 |    4 +-
 arch/powerpc/kernel/irq_64.c                       |    2 +-
 arch/powerpc/mm/kasan/init_32.c                    |    1 +
 arch/powerpc/platforms/pseries/lpar.c              |    8 +-
 arch/riscv/include/asm/hwcap.h                     |    4 +-
 arch/riscv/include/asm/jump_label.h                |    4 +-
 arch/s390/include/asm/jump_label.h                 |    4 +-
 arch/sparc/include/asm/jump_label.h                |    4 +-
 arch/um/Makefile                                   |    4 +-
 arch/um/include/asm/cpufeature.h                   |    2 +-
 arch/x86/Kconfig.cpu                               |    2 +-
 arch/x86/boot/Makefile                             |    2 +-
 arch/x86/boot/compressed/vmlinux.lds.S             |    6 +-
 arch/x86/boot/header.S                             |  211 ++--
 arch/x86/boot/setup.ld                             |   14 +-
 arch/x86/boot/tools/build.c                        |  273 +---
 arch/x86/include/asm/barrier.h                     |   18 -
 arch/x86/include/asm/cpufeature.h                  |    2 +-
 arch/x86/include/asm/cpufeatures.h                 |    2 +-
 arch/x86/include/asm/jump_label.h                  |    6 +-
 arch/x86/include/asm/processor.h                   |   18 +
 arch/x86/include/asm/rmwcc.h                       |    2 +-
 arch/x86/include/asm/special_insns.h               |    2 +-
 arch/x86/include/asm/uaccess.h                     |   10 +-
 arch/x86/kernel/cpu/amd.c                          |    3 +
 arch/x86/kernel/cpu/common.c                       |    7 +
 arch/x86/kernel/cpu/hygon.c                        |    3 +
 arch/x86/kernel/fpu/signal.c                       |   13 +-
 arch/x86/kvm/svm/svm_ops.h                         |    6 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |    2 +-
 arch/x86/kvm/vmx/vmx.c                             |    4 +-
 arch/x86/kvm/vmx/vmx_ops.h                         |    6 +-
 arch/x86/kvm/x86.c                                 |    3 +-
 arch/x86/mm/ident_map.c                            |   23 +-
 arch/xtensa/include/asm/jump_label.h               |    4 +-
 block/blk-mq.c                                     |    9 +-
 block/blk-wbt.c                                    |    4 +-
 crypto/algif_hash.c                                |    5 +-
 drivers/android/binder.c                           |   10 +
 drivers/base/core.c                                |   15 +-
 drivers/base/power/domain.c                        |    2 +-
 drivers/connector/cn_proc.c                        |    5 +-
 drivers/crypto/ccp/sev-dev.c                       |   10 +-
 drivers/firewire/core-device.c                     |    7 +-
 drivers/firmware/efi/libstub/Makefile              |    7 -
 drivers/firmware/efi/libstub/x86-stub.c            |   46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    9 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |    6 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |    5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    2 -
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |    5 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |    6 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |    7 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |    6 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |    6 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    4 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    6 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    6 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |    6 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   14 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    6 +-
 .../display/dc/link/protocols/link_dp_training.c   |    5 +-
 drivers/gpu/drm/drm_prime.c                        |    2 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |    4 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   11 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   32 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |    7 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |   26 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |    1 +
 drivers/gpu/drm/nouveau/nouveau_svm.c              |    2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |    1 +
 drivers/hid/bpf/hid_bpf_dispatch.c                 |   83 +-
 drivers/hid/bpf/hid_bpf_dispatch.h                 |    4 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c                |   40 +-
 drivers/hid/i2c-hid/i2c-hid-of.c                   |    1 +
 drivers/hid/wacom_sys.c                            |   63 +-
 drivers/hid/wacom_wac.c                            |    9 +-
 drivers/i2c/busses/Makefile                        |    6 +-
 drivers/i2c/busses/i2c-i801.c                      |    4 +-
 drivers/i2c/busses/i2c-pasemi-core.c               |    6 +
 drivers/i2c/busses/i2c-qcom-geni.c                 |   16 +-
 drivers/iio/accel/Kconfig                          |    2 +
 drivers/iio/adc/ad4130.c                           |   12 +-
 drivers/iio/imu/bno055/Kconfig                     |    1 +
 drivers/iio/industrialio-core.c                    |    5 +-
 drivers/iio/light/hid-sensor-als.c                 |    1 +
 drivers/iio/magnetometer/rm3100-core.c             |   10 +-
 drivers/iio/pressure/bmp280-spi.c                  |    1 +
 drivers/interconnect/qcom/sc8180x.c                |    1 +
 drivers/interconnect/qcom/sm8550.c                 |    1 +
 drivers/irqchip/irq-brcmstb-l2.c                   |    5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   62 +-
 drivers/irqchip/irq-loongson-eiointc.c             |    2 +-
 drivers/md/dm-core.h                               |    2 +
 drivers/md/dm-crypt.c                              |   38 +-
 drivers/md/dm-ioctl.c                              |    3 +-
 drivers/md/dm-table.c                              |    9 +-
 drivers/md/dm-verity-target.c                      |   26 +-
 drivers/md/dm-verity.h                             |    1 -
 drivers/md/md.c                                    |    7 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |    2 +-
 drivers/media/rc/bpf-lirc.c                        |    6 +-
 drivers/media/rc/ir_toy.c                          |    2 +
 drivers/media/rc/lirc_dev.c                        |    5 +-
 drivers/media/rc/rc-core-priv.h                    |    2 +-
 drivers/misc/fastrpc.c                             |    2 +-
 drivers/mmc/core/slot-gpio.c                       |    6 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   30 +
 drivers/net/bonding/bond_main.c                    |    5 +-
 drivers/net/can/dev/netlink.c                      |    2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   38 +-
 .../net/ethernet/microchip/lan966x/lan966x_lag.c   |    9 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |   46 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    1 +
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   56 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   15 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   15 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |   15 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   15 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  125 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  136 +-
 drivers/net/ethernet/ti/cpsw.c                     |    2 +
 drivers/net/ethernet/ti/cpsw_new.c                 |    3 +
 drivers/net/hyperv/netvsc.c                        |    5 +-
 drivers/net/hyperv/netvsc_drv.c                    |   82 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   15 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    4 +
 drivers/net/xen-netback/netback.c                  |  100 +-
 drivers/of/property.c                              |   65 +-
 drivers/of/unittest.c                              |   12 +-
 drivers/pci/pci.c                                  |   37 +-
 drivers/perf/cxl_pmu.c                             |    2 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |   15 +-
 drivers/pmdomain/renesas/r8a77980-sysc.c           |    3 +-
 drivers/s390/net/qeth_l3_main.c                    |    9 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |   20 +-
 drivers/scsi/storvsc_drv.c                         |   12 +-
 drivers/spi/spi-imx.c                              |    9 +-
 drivers/spi/spi-ppc4xx.c                           |    5 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    2 +-
 drivers/thunderbolt/tb_regs.h                      |    2 +-
 drivers/thunderbolt/usb4.c                         |    2 +-
 drivers/tty/serial/max310x.c                       |   53 +-
 drivers/tty/serial/mxs-auart.c                     |    5 +-
 drivers/usb/chipidea/ci.h                          |    2 +
 drivers/usb/chipidea/core.c                        |   44 +-
 drivers/usb/common/ulpi.c                          |    2 +-
 drivers/usb/core/hub.c                             |   46 +-
 drivers/usb/dwc3/gadget.c                          |    6 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   20 +-
 drivers/usb/typec/tcpm/tcpm.c                      |    3 +-
 drivers/usb/typec/ucsi/ucsi.c                      |    2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |   17 +-
 fs/btrfs/block-group.c                             |   49 +-
 fs/btrfs/block-group.h                             |    7 +
 fs/btrfs/delalloc-space.c                          |   29 +-
 fs/btrfs/disk-io.c                                 |   13 +-
 fs/btrfs/inode.c                                   |   26 +-
 fs/btrfs/ioctl.c                                   |    5 +
 fs/btrfs/qgroup.c                                  |   14 +
 fs/btrfs/send.c                                    |    2 +-
 fs/ceph/caps.c                                     |    3 +-
 fs/ext4/mballoc.c                                  |   39 +-
 fs/ext4/move_extent.c                              |    6 +-
 fs/hugetlbfs/inode.c                               |   19 +-
 fs/namespace.c                                     |   11 +-
 fs/nfsd/nfs4state.c                                |   11 +-
 fs/nilfs2/file.c                                   |    8 +-
 fs/nilfs2/recovery.c                               |    7 +-
 fs/nilfs2/segment.c                                |    8 +-
 fs/proc/array.c                                    |   10 +-
 fs/smb/client/connect.c                            |   14 +-
 fs/smb/client/fs_context.c                         |   11 +
 fs/smb/client/namespace.c                          |   16 +
 fs/smb/client/smb2ops.c                            |    2 +-
 fs/smb/server/smb2pdu.c                            |    8 +-
 fs/tracefs/event_inode.c                           | 1310 +++++++++-----------
 fs/tracefs/inode.c                                 |  276 ++---
 fs/tracefs/internal.h                              |   60 +-
 fs/zonefs/file.c                                   |   42 +-
 fs/zonefs/super.c                                  |   66 +-
 include/asm-generic/vmlinux.lds.h                  |    6 -
 include/linux/backing-dev-defs.h                   |    7 +-
 include/linux/compiler-gcc.h                       |   20 +
 include/linux/compiler_types.h                     |   11 +-
 include/linux/iio/adc/ad_sigma_delta.h             |    4 +-
 include/linux/iio/common/st_sensors.h              |    4 +-
 include/linux/iio/imu/adis.h                       |    3 +-
 include/linux/init.h                               |    3 -
 include/linux/lsm_hook_defs.h                      |    4 +-
 include/linux/netfilter/ipset/ip_set.h             |    4 +
 include/linux/ptrace.h                             |    4 +
 include/linux/serial_core.h                        |   32 +-
 include/linux/trace_events.h                       |    2 +-
 include/linux/tracefs.h                            |   73 +-
 include/net/tls.h                                  |    5 -
 include/sound/tas2781.h                            |    1 +
 init/Kconfig                                       |    9 +
 io_uring/net.c                                     |    5 +-
 kernel/sched/membarrier.c                          |    6 +
 kernel/trace/ftrace.c                              |   10 +
 kernel/trace/ring_buffer.c                         |    2 +-
 kernel/trace/trace.c                               |   85 +-
 kernel/trace/trace.h                               |    4 +-
 kernel/trace/trace_btf.c                           |    4 +-
 kernel/trace/trace_events.c                        |  311 +++--
 kernel/trace/trace_events_synth.c                  |    3 +-
 kernel/trace/trace_events_trigger.c                |    6 +-
 kernel/trace/trace_osnoise.c                       |    6 +-
 kernel/trace/trace_probe.c                         |   32 +-
 kernel/trace/trace_probe.h                         |    3 +-
 kernel/workqueue.c                                 |    8 +-
 lib/kobject.c                                      |   24 +-
 mm/backing-dev.c                                   |    2 +-
 mm/memory.c                                        |    4 +-
 mm/page-writeback.c                                |    4 +-
 mm/userfaultfd.c                                   |   15 +-
 net/can/j1939/j1939-priv.h                         |    3 +-
 net/can/j1939/main.c                               |    2 +-
 net/can/j1939/socket.c                             |   46 +-
 net/handshake/handshake-test.c                     |    5 +-
 net/hsr/hsr_device.c                               |    4 +-
 net/mac80211/tx.c                                  |    5 +-
 net/mptcp/pm_userspace.c                           |   13 +-
 net/mptcp/protocol.c                               |   25 +-
 net/mptcp/protocol.h                               |    7 +-
 net/mptcp/subflow.c                                |    4 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   14 +-
 net/netfilter/ipset/ip_set_core.c                  |   39 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   19 +-
 net/netfilter/ipset/ip_set_list_set.c              |   13 +-
 net/netfilter/nft_set_pipapo_avx2.c                |    2 +-
 net/nfc/nci/core.c                                 |    4 +
 net/openvswitch/flow_netlink.c                     |   49 +-
 net/tls/tls_sw.c                                   |  217 ++--
 net/wireless/core.c                                |    1 +
 samples/bpf/asm_goto_workaround.h                  |    8 +-
 scripts/link-vmlinux.sh                            |    9 +-
 scripts/mksysmap                                   |   13 +-
 scripts/mod/modpost.c                              |   18 +-
 scripts/mod/sumversion.c                           |    7 +-
 security/security.c                                |   45 +-
 sound/pci/hda/Kconfig                              |    4 +-
 sound/pci/hda/patch_conexant.c                     |   18 +
 sound/pci/hda/patch_cs8409.c                       |    1 +
 sound/pci/hda/patch_realtek.c                      |   20 +-
 sound/pci/hda/tas2781_hda_i2c.c                    |    2 +-
 sound/soc/amd/yc/acp6x-mach.c                      |   14 +
 sound/soc/codecs/rt5645.c                          |    1 +
 sound/soc/codecs/tas2781-comlib.c                  |    3 +-
 sound/soc/codecs/tas2781-i2c.c                     |    2 +-
 sound/soc/codecs/wcd938x.c                         |    2 +-
 sound/soc/sof/ipc3-topology.c                      |   69 +-
 sound/soc/sof/ipc3.c                               |    2 +-
 tools/arch/x86/include/asm/rmwcc.h                 |    2 +-
 tools/include/linux/compiler_types.h               |    4 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |   50 +-
 tools/testing/selftests/kvm/x86_64/amx_test.c      |    4 +-
 .../testing/selftests/kvm/x86_64/hyperv_features.c |    9 +-
 tools/testing/selftests/landlock/fs_test.c         |   11 +-
 .../selftests/mm/charge_reserved_hugetlb.sh        |    2 +-
 tools/testing/selftests/mm/ksm_tests.c             |    2 +-
 tools/testing/selftests/mm/map_hugetlb.c           |    7 +
 tools/testing/selftests/mm/va_high_addr_switch.sh  |    6 +
 tools/testing/selftests/mm/write_hugetlb_memory.sh |    2 +-
 .../selftests/net/forwarding/bridge_locked_port.sh |    4 +-
 .../testing/selftests/net/forwarding/bridge_mdb.sh |  192 ++-
 .../selftests/net/forwarding/tc_flower_l2_miss.sh  |    8 +-
 tools/testing/selftests/net/mptcp/config           |    3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   10 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   11 +-
 tools/testing/selftests/net/mptcp/settings         |    2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   31 +-
 .../selftests/net/test_bridge_backup_port.sh       |  394 +++---
 tools/tracing/rtla/Makefile                        |    7 +-
 tools/tracing/rtla/src/osnoise_hist.c              |    9 +-
 tools/tracing/rtla/src/osnoise_top.c               |    6 +-
 tools/tracing/rtla/src/timerlat_hist.c             |    9 +-
 tools/tracing/rtla/src/timerlat_top.c              |    6 +-
 tools/tracing/rtla/src/utils.c                     |   14 +-
 tools/tracing/rtla/src/utils.h                     |    2 +
 tools/verification/rv/Makefile                     |    7 +-
 tools/verification/rv/src/in_kernel.c              |    2 +-
 329 files changed, 4093 insertions(+), 3172 deletions(-)



