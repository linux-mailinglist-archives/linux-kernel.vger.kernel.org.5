Return-Path: <linux-kernel+bounces-137405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E7E89E196
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B71F24269
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A5215667A;
	Tue,  9 Apr 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FhBQ6E08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD709156660;
	Tue,  9 Apr 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683831; cv=none; b=m+HSrgG2ZfGJrU5ENPI6zHJ6LiJmDj3XUnwrVdvkCXPlxs6IxzCw3/GElVst3/XvBIRoGOhkD+E46kBVO8UlfJU9SZA0V0OknUvTlpDfbCK7Ujl3UZaq4oxlm/CTwmcE0YelPdbGubJ00ZZvr7ROu1B5jmV5Du8n6gH4jztcpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683831; c=relaxed/simple;
	bh=609ciwvv7duWbkQH06aeu72xgHNHWVySn+bji/ggvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bg/bpM4wz6hZg2U8aQE3pLT/RMMmtpPZ7NToX3y6eDgKaQm7WbgGqW/SldE0RwpKccrr6QBuKOPBJv8kQW6zxBHoOFdknd6eigvxADIT2pjZvNACzVmJ/5Ue6QVc7+7H3b8yA8rgJWF5x+qmPKTvuqFcoHiIoUBPJhGXfJ17x5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FhBQ6E08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98CDC433C7;
	Tue,  9 Apr 2024 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712683831;
	bh=609ciwvv7duWbkQH06aeu72xgHNHWVySn+bji/ggvQE=;
	h=From:To:Cc:Subject:Date:From;
	b=FhBQ6E08/vb5gWyB0bRAuaLHEvDwlnGqbQ1pNoJw+8szkJCGjh1xJuzAiXWQ4Yh3v
	 ykAU4V4+XDEW1EmtF4DQt9Tjpw8f19Uzo0AUZ762zpkOzzYLNebZFczYDwkywwPXfn
	 TlBCUaIbZJF+GGjI8lf3QYfnQTrDjVOuJozW0jWI=
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
Subject: [PATCH 6.1 000/137] 6.1.85-rc2 review
Date: Tue,  9 Apr 2024 19:30:27 +0200
Message-ID: <20240409172805.638917723@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.85-rc2
X-KernelTest-Deadline: 2024-04-11T17:28+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.85 release.
There are 137 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 11 Apr 2024 17:27:40 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.85-rc2

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

David Hildenbrand <david@redhat.com>
    mm/secretmem: fix GUP-fast succeeding on secretmem folios

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: display simult in extra_msg

Davide Caratti <dcaratti@redhat.com>
    mptcp: don't account accept() of non-MPC client as fallback to TCP

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: join: fix dev in check_endpoint

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in smb2_is_network_name_deleted()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in is_valid_oplock_break()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in smb2_is_valid_lease_break()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in smb2_is_valid_oplock_break()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_stats_proc_show()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_stats_proc_write()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_debug_files_proc_show()

Ritvik Budhiraja <rbudhiraja@microsoft.com>
    smb3: retrying on failed server close

Stefan O'Rear <sorear@fastmail.com>
    riscv: process: Fix kernel gp leakage

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix spurious errors from __get/put_kernel_nofault

Sumanth Korikkar <sumanthk@linux.ibm.com>
    s390/entry: align system call table on 8 bytes

Jason A. Donenfeld <Jason@zx2c4.com>
    x86/coco: Require seeding RNG with RDRAND on CoCo systems

Borislav Petkov (AMD) <bp@alien8.de>
    x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

David Hildenbrand <david@redhat.com>
    x86/mm/pat: fix VM_PAT handling in COW mappings

Herve Codina <herve.codina@bootlin.com>
    of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Herve Codina <herve.codina@bootlin.com>
    driver core: Introduce device_link_wait_removal()

I Gede Agastya Darma Laksana <gedeagas22@gmail.com>
    ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Christoffer Sandberg <cs@tuxedo.de>
    ALSA: hda/realtek - Fix inactive headset mic jack

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate payload size in ipc response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't send oplock break if rename fails

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Jeff Layton <jlayton@kernel.org>
    nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Arnd Bergmann <arnd@arndb.de>
    ata: sata_mv: Fix PCI device ID table declaration compilation warning

David Howells <dhowells@redhat.com>
    cifs: Fix caching to try to do open O_WRONLY as rdwr on server

Li Nan <linan122@huawei.com>
    scsi: sd: Unregister device if device_add_disk() failed in sd_probe()

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

Christian Hewitt <christianshewitt@gmail.com>
    drm/panfrost: fix power transition timeout warnings

Pu Lehui <pulehui@huawei.com>
    drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Dominique Martinet <asmadeus@codewreck.org>
    9p: Fix read/write debug statements to report server reply

Jann Horn <jannh@google.com>
    fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Ashish Kalra <ashish.kalra@amd.com>
    KVM: SVM: Add support for allowing zero SEV ASIDs

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Use unsigned integers when dealing with ASIDs

Sean Christopherson <seanjc@google.com>
    KVM: SVM: WARN, but continue, if misc_cg_set_capacity() fails

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
    KVM: SVM: enhance info printk's in SEV init

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always update error counters

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always process TX descriptor ring

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Let IP-specific receive function to interrogate descriptors

Wei Fang <wei.fang@nxp.com>
    net: fec: Set mac_managed_pm during probe

Denis Kirjanov <dkirjanov@suse.de>
    drivers: net: convert to boolean for the mac_managed_pm flag

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: prepare rtl_hw_aspm_clkreq_enable for usage in atomic context

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: use spinlock to protect access to registers Config2 and Config5

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: use spinlock to protect mac ocp register access

Ivan Vecera <ivecera@redhat.com>
    i40e: Enforce software interrupt during busy-poll exit

Ivan Vecera <ivecera@redhat.com>
    i40e: Remove _t suffix from enum type names

Joe Damato <jdamato@fastly.com>
    i40e: Store the irq number in i40e_q_vector

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Flush GFXOFF requests in prepare stage

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Add concept of running prepare_suspend() sequence for IP blocks

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Evict resources during PM ops prepare() callback

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix vf may be used uninitialized in this function warning

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix i40e_count_filters() to count only active/new filters

Aleksandr Mishin <amishin@t-argos.ru>
    octeontx2-af: Add array index check

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

Atlas Yu <atlas.yu@canonical.com>
    r8169: skip DASH fw status checks when DASH is disabled

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop interface during shutdown

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: Fix infinite recursion in fib6_dump_done().

Jakub Kicinski <kuba@kernel.org>
    selftests: reuseaddr_conflict: add missing new line at the end of the output

Eric Dumazet <edumazet@google.com>
    erspan: make sure erspan_base_hdr is present in skb->head

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix VF MAC filter removal

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Borislav Petkov (AMD) <bp@alien8.de>
    x86/bugs: Fix the SRSO mitigation on Zen3/4

Antoine Tenart <atenart@kernel.org>
    gro: fix ownership transfer

Antoine Tenart <atenart@kernel.org>
    selftests: net: gro fwd: update vxlan GRO test expectations

Aleksandr Mishin <amishin@t-argos.ru>
    net: phy: micrel: Fix potential null pointer dereference

Horatiu Vultur <horatiu.vultur@microchip.com>
    net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping

Piotr Wejman <piotrwejman90@gmail.com>
    net: stmmac: fix rx queue priority assignment

Eric Dumazet <edumazet@google.com>
    net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()

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

Ingo Molnar <mingo@kernel.org>
    Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Marco Pinna <marco.pinn95@gmail.com>
    vsock/virtio: fix packet delivery to tap device

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid the interface always configured as random address

Mahmoud Adam <mngyadam@amazon.com>
    net/rds: fix possible cp null dereference

Jesper Dangaard Brouer <hawk@kernel.org>
    xen-netfront: Add missing skb_mark_for_recycle

Bastien Nocera <hadess@hadess.net>
    Bluetooth: Fix TOCTOU in HCI debugfs implementation

Hui Wang <hui.wang@canonical.com>
    Bluetooth: hci_event: set the conn encrypted before conn establishes

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: add quirk for broken address properties

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: qca: fix device-address endianness

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

Johan Hovold <johan+linaro@kernel.org>
    Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"

Sean Christopherson <seanjc@google.com>
    x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Fix host-programmed guest events in nVHE

Sandipan Das <sandipan.das@amd.com>
    perf/x86/amd/lbr: Use freeze based on availability

Sandipan Das <sandipan.das@amd.com>
    x86/cpufeatures: Add new word for scattered features

Arnd Bergmann <arnd@arndb.de>
    dm integrity: fix out-of-range warning

Florian Westphal <fw@strlen.de>
    inet: inet_defrag: prevent sk release while still in use

Hariprasad Kelam <hkelam@marvell.com>
    Octeontx2-af: fix pause frame configuration in GMP mode

Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
    net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

David Howells <dhowells@redhat.com>
    cifs: Fix duplicate fscache cookie warnings

Andrei Matei <andreimatei1@gmail.com>
    bpf: Protect against int overflow for stack access size

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: call request_irq() after NAPI initialized

Sabrina Dubroca <sd@queasysnail.net>
    tls: get psock ref after taking rxlock to avoid leak

Sabrina Dubroca <sd@queasysnail.net>
    tls: adjust recv return with async crypto and failed copy to userspace

Sabrina Dubroca <sd@queasysnail.net>
    tls: recv: process_rx_list shouldn't use an offset with kvec

Jian Shen <shenjian15@huawei.com>
    net: hns3: mark unexcuted loopback test result as UNEXECUTED

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: fix kernel crash when devlink reload during pf initialization

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix index limit to support all queue stats

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Bjørn Mork <bjorn@mork.no>
    net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Eric Dumazet <edumazet@google.com>
    tcp: properly terminate timers for kernel sockets

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: handle deferred cc1

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: rfi: fix potential response leaks

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop PHY during open() error paths

Ryosuke Yasuoka <ryasuoka@redhat.com>
    nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Pavel Sakharov <p.sakharov@ispras.ru>
    dma-buf: Fix NULL pointer dereference in sanitycheck()

Hangbin Liu <liuhangbin@gmail.com>
    scripts/bpf_doc: Use silent mode when exec make cmd


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/spectre.rst      |  48 +++++++-
 Documentation/admin-guide/kernel-parameters.txt    |  12 ++
 Makefile                                           |   4 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   2 +
 arch/riscv/include/asm/uaccess.h                   |   4 +-
 arch/riscv/kernel/process.c                        |   3 -
 arch/s390/kernel/entry.S                           |   1 +
 arch/x86/Kconfig                                   |  25 ++++
 arch/x86/coco/core.c                               |  41 +++++++
 arch/x86/entry/common.c                            |  10 +-
 arch/x86/entry/entry_64.S                          |  61 ++++++++++
 arch/x86/entry/entry_64_compat.S                   |  16 +++
 arch/x86/entry/syscall_32.c                        |  21 +++-
 arch/x86/entry/syscall_64.c                        |  19 ++-
 arch/x86/entry/syscall_x32.c                       |  10 +-
 arch/x86/events/amd/core.c                         |   4 +-
 arch/x86/events/amd/lbr.c                          |  16 ++-
 arch/x86/include/asm/asm-prototypes.h              |   1 +
 arch/x86/include/asm/coco.h                        |   2 +
 arch/x86/include/asm/cpufeature.h                  |   8 +-
 arch/x86/include/asm/cpufeatures.h                 |  15 ++-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/msr-index.h                   |   9 +-
 arch/x86/include/asm/nospec-branch.h               |  37 +++++-
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/syscall.h                     |  11 +-
 arch/x86/kernel/cpu/bugs.c                         | 121 +++++++++++++++++--
 arch/x86/kernel/cpu/common.c                       |  24 ++--
 arch/x86/kernel/cpu/mce/core.c                     |   4 +-
 arch/x86/kernel/cpu/scattered.c                    |   2 +
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/kvm/reverse_cpuid.h                       |   5 +-
 arch/x86/kvm/svm/sev.c                             |  60 ++++++----
 arch/x86/kvm/trace.h                               |  10 +-
 arch/x86/kvm/vmx/vmenter.S                         |   2 +
 arch/x86/kvm/x86.c                                 |   2 +-
 arch/x86/lib/retpoline.S                           |   6 +-
 arch/x86/mm/ident_map.c                            |  23 +---
 arch/x86/mm/pat/memtype.c                          |  49 +++++---
 drivers/acpi/acpica/dbnames.c                      |   8 +-
 drivers/ata/sata_mv.c                              |  63 +++++-----
 drivers/ata/sata_sx4.c                             |   6 +-
 drivers/base/core.c                                |  26 +++-
 drivers/bluetooth/btqca.c                          |   8 +-
 drivers/bluetooth/hci_qca.c                        |  19 ++-
 drivers/dma-buf/st-dma-fence-chain.c               |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  38 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  10 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   1 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   6 +-
 drivers/md/dm-integrity.c                          |   2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  11 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  19 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
 drivers/net/ethernet/intel/i40e/i40e.h             |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  14 ++-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |   3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  82 +++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  45 ++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +--
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  31 +++--
 drivers/net/ethernet/microchip/lan743x_main.c      |  18 +++
 drivers/net/ethernet/microchip/lan743x_main.h      |   4 +
 drivers/net/ethernet/realtek/r8169_main.c          | 131 +++++++++++++++++----
 drivers/net/ethernet/renesas/ravb_main.c           |  33 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 +++++--
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 ++++--
 drivers/net/phy/micrel.c                           |  31 +++--
 drivers/net/usb/asix_devices.c                     |   4 +-
 drivers/net/usb/ax88179_178a.c                     |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   8 +-
 drivers/net/wwan/t7xx/t7xx_cldma.c                 |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   9 +-
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c              |   8 +-
 drivers/net/xen-netfront.c                         |   1 +
 drivers/nvme/host/core.c                           |   4 +-
 drivers/nvme/host/ioctl.c                          |   3 +-
 drivers/nvme/host/nvme.h                           |   2 +-
 drivers/nvme/target/passthru.c                     |   3 +-
 drivers/of/dynamic.c                               |  12 ++
 drivers/perf/riscv_pmu.c                           |   4 +
 drivers/s390/net/qeth_core_main.c                  |  38 +++++-
 drivers/scsi/myrb.c                                |  20 ++--
 drivers/scsi/myrs.c                                |  24 ++--
 drivers/scsi/sd.c                                  |   2 +-
 fs/nfsd/nfs4state.c                                |   7 +-
 fs/pipe.c                                          |  17 ++-
 fs/smb/client/cached_dir.c                         |   6 +-
 fs/smb/client/cifs_debug.c                         |   6 +
 fs/smb/client/cifsfs.c                             |  11 ++
 fs/smb/client/cifsglob.h                           |  17 ++-
 fs/smb/client/connect.c                            |   2 +
 fs/smb/client/dir.c                                |  15 +++
 fs/smb/client/file.c                               | 111 ++++++++++++++---
 fs/smb/client/fscache.c                            |  16 ++-
 fs/smb/client/fscache.h                            |   6 +
 fs/smb/client/inode.c                              |   2 +
 fs/smb/client/misc.c                               |   2 +
 fs/smb/client/smb1ops.c                            |   4 +-
 fs/smb/client/smb2misc.c                           |   4 +
 fs/smb/client/smb2ops.c                            |  11 +-
 fs/smb/client/smb2pdu.c                            |   2 +-
 fs/smb/server/ksmbd_netlink.h                      |   3 +-
 fs/smb/server/mgmt/share_config.c                  |   7 +-
 fs/smb/server/smb2ops.c                            |  10 +-
 fs/smb/server/smb2pdu.c                            |   3 +-
 fs/smb/server/transport_ipc.c                      |  37 ++++++
 fs/vboxsf/super.c                                  |   3 +-
 include/kvm/arm_pmu.h                              |   2 +-
 include/linux/device.h                             |   1 +
 include/linux/secretmem.h                          |   4 +-
 include/linux/skbuff.h                             |   7 +-
 include/linux/udp.h                                |  28 +++++
 include/net/bluetooth/hci.h                        |   9 ++
 include/net/inet_connection_sock.h                 |   1 +
 include/net/sock.h                                 |   7 ++
 kernel/bpf/verifier.c                              |   5 +
 mm/memory.c                                        |   4 +
 net/9p/client.c                                    |  10 +-
 net/bluetooth/hci_debugfs.c                        |  64 ++++++----
 net/bluetooth/hci_event.c                          |  25 ++++
 net/bluetooth/hci_sync.c                           |   5 +-
 net/bridge/netfilter/ebtables.c                    |   6 +
 net/core/gro.c                                     |   3 +-
 net/core/sock_map.c                                |   6 +
 net/ipv4/inet_connection_sock.c                    |  33 ++++--
 net/ipv4/inet_fragment.c                           |  70 +++++++++--
 net/ipv4/ip_fragment.c                             |   2 +-
 net/ipv4/ip_gre.c                                  |   5 +
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/tcp.c                                     |   2 +
 net/ipv4/udp.c                                     |   7 ++
 net/ipv4/udp_offload.c                             |  23 ++--
 net/ipv6/ip6_fib.c                                 |  14 +--
 net/ipv6/ip6_gre.c                                 |   3 +
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 +-
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/udp_offload.c                             |   8 +-
 net/mptcp/protocol.c                               |   3 -
 net/mptcp/subflow.c                                |   2 +
 net/netfilter/nf_tables_api.c                      |  13 +-
 net/nfc/nci/core.c                                 |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/act_skbmod.c                             |  10 +-
 net/sched/sch_api.c                                |   2 +-
 net/tls/tls_sw.c                                   |   7 +-
 net/vmw_vsock/virtio_transport.c                   |   3 +-
 scripts/bpf_doc.py                                 |   4 +-
 sound/pci/hda/patch_realtek.c                      |   3 +-
 sound/soc/codecs/rt5682-sdw.c                      |   4 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |   4 +-
 sound/soc/codecs/rt711-sdw.c                       |   4 +-
 sound/soc/soc-ops.c                                |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   7 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   7 +-
 tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |  10 +-
 167 files changed, 1799 insertions(+), 555 deletions(-)



