Return-Path: <linux-kernel+bounces-135379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77989BFBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AF1C2125F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA07BB1F;
	Mon,  8 Apr 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xq97B3id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6867641E;
	Mon,  8 Apr 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581200; cv=none; b=KoxWQ0Pu1jFByDBkuwf/hjOaybBrO7ziLiJ5D33vPyXdZO+lz9y1n6l62uTjL1t5DDHMnU1/muawRGK3VRA7EhE7mG4HtRqohUvRN1fkJxE9lY1Tgjy/FgEGfJfJMtKEpMjAlupuKWNFzogshl3p70YZ3iPl3MyiZ8zw6k/LnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581200; c=relaxed/simple;
	bh=Icg+qDFy22P0dV9l6RblXyC9XQYVJQl3LSbQY7r0YQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mAAQ6XdXpvo+h/JIV56d+uAYu5frfDopXPnFgeOlACE0RG6ipEeLajVgTtN3UOHATgWU0rPoHJ6FZfLzyLTAxzd27GOFo6FTsmTxgNfX3UsZNh2uobPR0VXn35d7naFig6aadB0eaTi2OyhFwcuEZVrwYjPbhCmCenu1P2zYWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xq97B3id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF6EC43390;
	Mon,  8 Apr 2024 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581199;
	bh=Icg+qDFy22P0dV9l6RblXyC9XQYVJQl3LSbQY7r0YQo=;
	h=From:To:Cc:Subject:Date:From;
	b=Xq97B3idlCkjEkYu5/xR/8JabVVgCpRIrJ6h1ZsXcRJexAeKNwBb/z/0za8+/cip/
	 FoIwGsC4dDOBoTCicwNop593Cda/hodpHyNiB2f3nF9Tyoz8JwP/w2K+/czljVuTS1
	 F0O3kjzuz34rohFGSwzI5EBigPJDWEIad2FfqINo=
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
Subject: [PATCH 6.6 000/252] 6.6.26-rc1 review
Date: Mon,  8 Apr 2024 14:54:59 +0200
Message-ID: <20240408125306.643546457@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.26-rc1
X-KernelTest-Deadline: 2024-04-10T12:53+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.26 release.
There are 252 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.26-rc1

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Remap kernel text read-only before dropping NX attribute

Ard Biesheuvel <ardb@kernel.org>
    x86/sev: Move early startup code into .head.text section

Ard Biesheuvel <ardb@kernel.org>
    x86/sme: Move early SME kernel encryption handling into .head.text

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Add generic support for parsing mem_encrypt=

Hou Wenlong <houwenlong.hwl@antgroup.com>
    x86/head/64: Move the __head definition to <asm/init.h>

Andrii Nakryiko <andrii@kernel.org>
    bpf: support deferring bpf_link dealloc to after RCU grace period

Andrii Nakryiko <andrii@kernel.org>
    bpf: put uprobe link's path and task in release callback

Davide Caratti <dcaratti@redhat.com>
    mptcp: don't account accept() of non-MPC client as fallback to TCP

Davide Caratti <dcaratti@redhat.com>
    mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: connect: fix shellcheck warnings

Sergey Shtylyov <s.shtylyov@omp.ru>
    of: module: prevent NULL pointer dereference in vsnprintf()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "x86/mpparse: Register APIC address only once"

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Enable only one CCS for compute workload

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Do not generate the command streamer for all the CCS

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Disable HW load balancing for CCS

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
    smb: client: fix potential UAF in cifs_dump_full_key()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_stats_proc_show()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_stats_proc_write()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_debug_files_proc_show()

Ritvik Budhiraja <rbudhiraja@microsoft.com>
    smb3: retrying on failed server close

Paulo Alcantara <pc@manguebit.com>
    smb: client: serialise cifs_construct_tcon() with cifs_mount_mutex

Paulo Alcantara <pc@manguebit.com>
    smb: client: handle DFS tcons in cifs_construct_tcon()

Stefan O'Rear <sorear@fastmail.com>
    riscv: process: Fix kernel gp leakage

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix spurious errors from __get/put_kernel_nofault

Sumanth Korikkar <sumanthk@linux.ibm.com>
    s390/entry: align system call table on 8 bytes

Edward Liaw <edliaw@google.com>
    selftests/mm: include strings.h for ffsl

David Hildenbrand <david@redhat.com>
    mm/secretmem: fix GUP-fast succeeding on secretmem folios

Mark Brown <broonie@kernel.org>
    arm64/ptrace: Use saved floating point state type to determine SVE layout

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event

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

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: hold io_buffer_list reference over mmap

Jens Axboe <axboe@kernel.dk>
    io_uring: use private workqueue for exit work

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: protect io_buffer_list teardown with a reference

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: get rid of bl->is_ready

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: get rid of lower BGID lists

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

Kent Gibson <warthog618@gmail.com>
    gpio: cdev: fix missed label sanitizing in debounce_setup()

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: cdev: check for NULL labels when sanitizing them for irqs

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix typo in assignment

Jeff Layton <jlayton@kernel.org>
    nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Disable preemption when using patch_map()

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: SOF: amd: fix for false dsp interrupts

Arnd Bergmann <arnd@arndb.de>
    ata: sata_mv: Fix PCI device ID table declaration compilation warning

Thomas Richter <tmricht@linux.ibm.com>
    s390/pai: fix sampling event removal for PMU device driver

Thomas Richter <tmricht@linux.ibm.com>
    s390/pai: rework paiXXX_start and paiXXX_stop functions

Thomas Richter <tmricht@linux.ibm.com>
    s390/pai: cleanup event initialization

Thomas Richter <tmricht@linux.ibm.com>
    s390/pai_crypto: remove per-cpu variable assignement in event initialization

Thomas Richter <tmricht@linux.ibm.com>
    s390/pai: initialize event count once at initialization

Huai-Yuan Liu <qq810974084@gmail.com>
    spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe

David Howells <dhowells@redhat.com>
    cifs: Fix caching to try to do open O_WRONLY as rdwr on server

Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    Revert "ALSA: emu10k1: fix synthesizer sample playback position and caching"

Li Nan <linan122@huawei.com>
    scsi: sd: Unregister device if device_add_disk() failed in sd_probe()

Arnd Bergmann <arnd@arndb.de>
    scsi: mylex: Fix sysfs buffer lengths

Arnd Bergmann <arnd@arndb.de>
    ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: maple: Fix uninitialized symbol 'ret' warnings

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: amd: acp: fix for acp_init function error handling

Jaewon Kim <jaewon02.kim@samsung.com>
    spi: s3c64xx: Use DMA mode from fifo size

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: determine the fifo depth only once

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: allow full FIFO masks

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: define a magic value

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: remove else after return

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: explicitly include <linux/bits.h>

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: sort headers alphabetically

Sam Protsenko <semen.protsenko@linaro.org>
    spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro

Stephen Lee <slee08177@gmail.com>
    ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt722-sdca-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt712-sdca-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt711-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt711-sdca: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt5682-sdw: fix locking sequence

Rob Clark <robdclark@chromium.org>
    drm/prime: Unbreak virtgpu dma-buf export

Dave Airlie <airlied@redhat.com>
    nouveau/uvmm: fix addr/range calcs for remap operations

Christian Hewitt <christianshewitt@gmail.com>
    drm/panfrost: fix power transition timeout warnings

Simon Trimmer <simont@opensource.cirrus.com>
    ALSA: hda: cs35l56: Add ACPI device match tables

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: maple: Fix cache corruption in regcache_maple_drop()

Victor Isaev <victor@torrio.net>
    RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ

Pu Lehui <pulehui@huawei.com>
    drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()

Dominique Martinet <asmadeus@codewreck.org>
    9p: Fix read/write debug statements to report server reply

Jann Horn <jannh@google.com>
    fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Ashish Kalra <ashish.kalra@amd.com>
    KVM: SVM: Add support for allowing zero SEV ASIDs

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Use unsigned integers when dealing with ASIDs

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always update error counters

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always process TX descriptor ring

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Let IP-specific receive function to interrogate descriptors

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: Minor flow correction in e1000_shutdown function

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: Workaround for sporadic MDI error on Meteor Lake systems

Jesse Brandeburg <jesse.brandeburg@intel.com>
    intel: legacy: field get conversion

Jesse Brandeburg <jesse.brandeburg@intel.com>
    intel: add bit macro includes where needed

Ivan Vecera <ivecera@redhat.com>
    i40e: Remove circular header dependencies and fix headers

Ivan Vecera <ivecera@redhat.com>
    i40e: Split i40e_osdep.h

Ivan Vecera <ivecera@redhat.com>
    i40e: Move memory allocation structures to i40e_alloc.h

Ivan Vecera <ivecera@redhat.com>
    i40e: Simplify memory allocation functions

Ivan Vecera <ivecera@redhat.com>
    virtchnl: Add header dependencies

Ivan Vecera <ivecera@redhat.com>
    i40e: Refactor I40E_MDIO_CLAUSE* macros

Ivan Vecera <ivecera@redhat.com>
    i40e: Remove back pointer from i40e_hw structure

Ivan Vecera <ivecera@redhat.com>
    i40e: Enforce software interrupt during busy-poll exit

Ivan Vecera <ivecera@redhat.com>
    i40e: Remove _t suffix from enum type names

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Flush GFXOFF requests in prepare stage

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Add concept of running prepare_suspend() sequence for IP blocks

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Evict resources during PM ops prepare() callback

Chris Park <chris.park@amd.com>
    drm/amd/display: Prevent crash when disable stream

Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
    drm/amd/display: Fix DPSTREAM CLK on and off sequence

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Check for notifications after init

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: typec: ucsi: Fix race between typec_switch and role_switch

Alexander Wetzel <Alexander@wetzel-home.de>
    scsi: sg: Avoid sg device teardown race

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

Duoming Zhou <duoming@zju.edu.cn>
    ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.

Jakub Kicinski <kuba@kernel.org>
    selftests: reuseaddr_conflict: add missing new line at the end of the output

Eric Dumazet <edumazet@google.com>
    erspan: make sure erspan_base_hdr is present in skb->head

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix VF MAC filter removal

Petr Oros <poros@redhat.com>
    ice: fix enabling RX VLAN filtering

Antoine Tenart <atenart@kernel.org>
    gro: fix ownership transfer

Antoine Tenart <atenart@kernel.org>
    selftests: net: gro fwd: update vxlan GRO test expectations

Michael Krummsdorf <michael.krummsdorf@tq-group.com>
    net: dsa: mv88e6xxx: fix usable ports on 88e6020

Aleksandr Mishin <amishin@t-argos.ru>
    net: phy: micrel: Fix potential null pointer dereference

Wei Fang <wei.fang@nxp.com>
    net: fec: Set mac_managed_pm during probe

Duanqiang Wen <duanqiangwen@net-swift.com>
    net: txgbe: fix i2c dev name cannot match clkdev

Horatiu Vultur <horatiu.vultur@microchip.com>
    net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping

Piotr Wejman <piotrwejman90@gmail.com>
    net: stmmac: fix rx queue priority assignment

Eric Dumazet <edumazet@google.com>
    net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45()

Eric Dumazet <edumazet@google.com>
    net/sched: act_skbmod: prevent kernel-infoleak

Will Deacon <will@kernel.org>
    KVM: arm64: Ensure target address is granule-aligned for range TLBI

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Eric Dumazet <edumazet@google.com>
    netfilter: validate user input for expected length

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: discard table flag update with pending basechain deletion

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: flush pending destroy work before exit_net release

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject new basechain after table flag update

Borislav Petkov (AMD) <bp@alien8.de>
    x86/bugs: Fix the SRSO mitigation on Zen3/4

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/nospec: Refactor UNTRAIN_RET[_*]

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Disentangle rethunk-dependent options

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Improve i-cache locality for alias mitigation

Marco Pinna <marco.pinn95@gmail.com>
    vsock/virtio: fix packet delivery to tap device

Haiyang Zhang <haiyangz@microsoft.com>
    net: mana: Fix Rx DMA datasize and skb_over_panic

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid the interface always configured as random address

Mahmoud Adam <mngyadam@amazon.com>
    net/rds: fix possible cp null dereference

Jesper Dangaard Brouer <hawk@kernel.org>
    xen-netfront: Add missing skb_mark_for_recycle

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: join: fix dev in check_endpoint

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release batch on table validation from abort path

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

Uros Bizjak <ubizjak@gmail.com>
    x86/bpf: Fix IP after emitting call depth accounting

Sean Christopherson <seanjc@google.com>
    x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Christian Göttsche <cgzones@googlemail.com>
    selinux: avoid dereference of garbage after mount failure

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Fix host-programmed guest events in nVHE

Anup Patel <apatel@ventanamicro.com>
    RISC-V: KVM: Fix APLIC in_clrip[x] read emulation

Anup Patel <apatel@ventanamicro.com>
    RISC-V: KVM: Fix APLIC setipnum_le/be write emulation

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: cdev: sanitize the label before requesting the interrupt

Masahiro Yamada <masahiroy@kernel.org>
    modpost: do not make find_tosym() return NULL

Jack Brennen <jbrennen@google.com>
    modpost: Optimize symbol search from linear to binary search

Sandipan Das <sandipan.das@amd.com>
    perf/x86/amd/lbr: Use freeze based on availability

Sandipan Das <sandipan.das@amd.com>
    x86/cpufeatures: Add new word for scattered features

Sandipan Das <sandipan.das@amd.com>
    perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Add X86_FEATURE_ZEN1

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Get rid of amd_erratum_1054[]

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Move Zenbleed check to the Zen2 init function

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Carve out the erratum 1386 fix

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Add ZenX generations flags

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when detecting delalloc ranges during fiemap

Filipe Manana <fdmanana@suse.com>
    btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given

Ingo Molnar <mingo@kernel.org>
    Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Peter Xu <peterx@redhat.com>
    mm/treewide: replace pud_large() with pud_leaf()

Arnd Bergmann <arnd@arndb.de>
    dm integrity: fix out-of-range warning

Tejas Upadhyay <tejas.upadhyay@intel.com>
    drm/i915/mtl: Update workaround 14018575942

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/xelpg: Extend some workarounds/tuning to gfx version 12.74

Tejas Upadhyay <tejas.upadhyay@intel.com>
    drm/i915/mtl: Update workaround 14016712196

Matt Roper <matthew.d.roper@intel.com>
    drm/i915: Replace several IS_METEORLAKE with proper IP version checks

Matt Roper <matthew.d.roper@intel.com>
    drm/i915: Eliminate IS_MTL_GRAPHICS_STEP

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/xelpg: Call Xe_LPG workaround functions based on IP version

Matt Roper <matthew.d.roper@intel.com>
    drm/i915: Consolidate condition for Wa_22011802037

Matt Roper <matthew.d.roper@intel.com>
    drm/i915: Tidy workaround definitions

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/dg2: Drop pre-production GT workarounds

Florian Westphal <fw@strlen.de>
    inet: inet_defrag: prevent sk release while still in use

Hariprasad Kelam <hkelam@marvell.com>
    Octeontx2-af: fix pause frame configuration in GMP mode

Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
    net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

Justin Chen <justin.chen@broadcom.com>
    net: bcmasp: Bring up unimac after PHY link up

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip netdev hook unregistration if table is dormant

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject table flag and netdev basechain updates

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject destroy command to remove basechain hooks

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

Ido Schimmel <idosch@nvidia.com>
    selftests: vxlan_mdb: Fix failures with old libnet

Bjørn Mork <bjorn@mork.no>
    net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Eric Dumazet <edumazet@google.com>
    tcp: properly terminate timers for kernel sockets

Ravi Gunasekaran <r-gunasekaran@ti.com>
    net: hsr: hsr_slave: Fix the promiscuous mode in offload mode

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: handle deferred cc1

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Remove stale comment about Tx timestamping

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix memory corruption bug with suspend and rebuild

Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
    ice: realloc VSI stats arrays

Steven Zou <steven.zou@intel.com>
    ice: Refactor FW data type and fix bitmap casting issue

Simon Trimmer <simont@opensource.cirrus.com>
    ALSA: hda: cs35l56: Set the init_done flag before component_add()

Benjamin Berg <benjamin.berg@intel.com>
    wifi: iwlwifi: mvm: include link ID when releasing frames

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: disable multi rx queue for 9000

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: rfi: fix potential response leaks

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop PHY during open() error paths

Jakub Kicinski <kuba@kernel.org>
    tools: ynl: fix setting presence bits in simple nests

Ryosuke Yasuoka <ryasuoka@redhat.com>
    nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Artem Savkov <asavkov@redhat.com>
    arm64: bpf: fix 32bit unconditional bswap

Pavel Sakharov <p.sakharov@ispras.ru>
    dma-buf: Fix NULL pointer dereference in sanitycheck()

Puranjay Mohan <puranjay12@gmail.com>
    bpf, arm64: fix bug in BPF_LDX_MEMSX

Ilya Leoshkevich <iii@linux.ibm.com>
    s390/bpf: Fix bpf_plt pointer arithmetic

Hangbin Liu <liuhangbin@gmail.com>
    scripts/bpf_doc: Use silent mode when exec make cmd

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Pre-populate the cursor physical dma address

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/i915/display: Use i915_gem_object_get_dma_address to get dma address


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   2 +
 arch/arm64/kernel/ptrace.c                         |   5 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  11 +-
 arch/arm64/net/bpf_jit_comp.c                      |   4 +-
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +-
 arch/riscv/include/asm/uaccess.h                   |   4 +-
 arch/riscv/include/uapi/asm/auxvec.h               |   2 +-
 arch/riscv/kernel/patch.c                          |   8 +
 arch/riscv/kernel/process.c                        |   3 -
 arch/riscv/kvm/aia_aplic.c                         |  37 +-
 arch/s390/boot/vmem.c                              |   2 +-
 arch/s390/include/asm/pgtable.h                    |   4 +-
 arch/s390/kernel/entry.S                           |   1 +
 arch/s390/kernel/perf_pai_crypto.c                 |  48 +--
 arch/s390/kernel/perf_pai_ext.c                    |  43 +--
 arch/s390/mm/gmap.c                                |   2 +-
 arch/s390/mm/hugetlbpage.c                         |   4 +-
 arch/s390/mm/pageattr.c                            |   2 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/s390/mm/vmem.c                                |   6 +-
 arch/s390/net/bpf_jit_comp.c                       |  46 +--
 arch/sparc/mm/init_64.c                            |   2 +-
 arch/x86/boot/compressed/Makefile                  |   2 +-
 arch/x86/boot/compressed/misc.c                    |   1 +
 arch/x86/boot/compressed/sev.c                     |   3 +
 arch/x86/coco/core.c                               |  41 ++
 arch/x86/events/amd/core.c                         |  24 +-
 arch/x86/events/amd/lbr.c                          |  16 +-
 arch/x86/events/intel/ds.c                         |   8 +-
 arch/x86/include/asm/asm-prototypes.h              |   1 +
 arch/x86/include/asm/boot.h                        |   1 +
 arch/x86/include/asm/coco.h                        |   2 +
 arch/x86/include/asm/cpufeature.h                  |   8 +-
 arch/x86/include/asm/cpufeatures.h                 |  16 +-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/init.h                        |   2 +
 arch/x86/include/asm/mem_encrypt.h                 |   8 +-
 arch/x86/include/asm/nospec-branch.h               |  71 ++--
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/sev.h                         |  10 +-
 arch/x86/kernel/cpu/amd.c                          | 129 +++++--
 arch/x86/kernel/cpu/bugs.c                         |   5 +-
 arch/x86/kernel/cpu/mce/core.c                     |   4 +-
 arch/x86/kernel/cpu/scattered.c                    |   1 +
 arch/x86/kernel/head64.c                           |   3 +-
 arch/x86/kernel/mpparse.c                          |  10 +-
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/kernel/sev-shared.c                       |  23 +-
 arch/x86/kernel/sev.c                              |  14 +-
 arch/x86/kernel/vmlinux.lds.S                      |   7 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/reverse_cpuid.h                       |   2 +
 arch/x86/kvm/svm/sev.c                             |  45 ++-
 arch/x86/kvm/trace.h                               |  10 +-
 arch/x86/lib/retpoline.S                           | 165 ++++----
 arch/x86/mm/fault.c                                |   4 +-
 arch/x86/mm/ident_map.c                            |  23 +-
 arch/x86/mm/init_64.c                              |   4 +-
 arch/x86/mm/kasan_init_64.c                        |   2 +-
 arch/x86/mm/mem_encrypt_identity.c                 |  44 +--
 arch/x86/mm/pat/memtype.c                          |  49 ++-
 arch/x86/mm/pat/set_memory.c                       |   6 +-
 arch/x86/mm/pgtable.c                              |   2 +-
 arch/x86/mm/pti.c                                  |   2 +-
 arch/x86/net/bpf_jit_comp.c                        |   2 +-
 arch/x86/power/hibernate.c                         |   2 +-
 arch/x86/xen/mmu_pv.c                              |   4 +-
 drivers/acpi/acpica/dbnames.c                      |   8 +-
 drivers/ata/sata_mv.c                              |  63 ++-
 drivers/ata/sata_sx4.c                             |   6 +-
 drivers/base/core.c                                |  26 +-
 drivers/base/regmap/regcache-maple.c               |   6 +-
 drivers/bluetooth/btqca.c                          |   8 +-
 drivers/bluetooth/hci_qca.c                        |  19 +-
 drivers/dma-buf/st-dma-fence-chain.c               |   6 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   8 +
 drivers/firmware/efi/libstub/efistub.h             |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c            |  11 +-
 drivers/gpio/gpiolib-cdev.c                        |  58 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  43 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  10 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  11 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   1 +
 drivers/gpu/drm/drm_prime.c                        |   7 +-
 drivers/gpu/drm/i915/Makefile                      |   1 +
 drivers/gpu/drm/i915/display/intel_cursor.c        |   6 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   1 +
 drivers/gpu/drm/i915/display/intel_fb_pin.c        |  10 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   5 +-
 drivers/gpu/drm/i915/gem/i915_gem_create.c         |   4 +-
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |  10 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  21 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt.h                 |  31 ++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c        |  39 ++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h        |  13 +
 drivers/gpu/drm/i915/gt/intel_gt_mcr.c             |   7 +-
 drivers/gpu/drm/i915/gt/intel_gt_regs.h            |   6 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  38 +-
 drivers/gpu/drm/i915/gt/intel_mocs.c               |  23 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |   6 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |  20 +-
 drivers/gpu/drm/i915/gt/intel_reset.h              |   2 +
 drivers/gpu/drm/i915/gt/intel_rps.c                |   2 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        | 422 +++++++--------------
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |  26 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   6 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |   2 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   4 -
 drivers/gpu/drm/i915/i915_perf.c                   |  11 +-
 drivers/gpu/drm/i915/intel_clock_gating.c          |   8 -
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   6 +-
 drivers/md/dm-integrity.c                          |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |   2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  28 +-
 drivers/net/ethernet/freescale/fec_main.c          |  11 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  19 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
 drivers/net/ethernet/intel/e1000/e1000_hw.c        |  46 +--
 drivers/net/ethernet/intel/e1000e/80003es2lan.c    |   3 +-
 drivers/net/ethernet/intel/e1000e/82571.c          |   3 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   7 +-
 drivers/net/ethernet/intel/e1000e/hw.h             |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  56 +--
 drivers/net/ethernet/intel/e1000e/mac.c            |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  35 +-
 drivers/net/ethernet/intel/e1000e/phy.c            | 191 ++++++----
 drivers/net/ethernet/intel/e1000e/phy.h            |   2 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c        |   4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c        |  10 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |  63 ++-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   2 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h       |  24 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_debug.h       |  47 +++
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.h        |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c         |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h         |   4 +
 drivers/net/ethernet/intel/i40e/i40e_io.h          |  16 +
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h     |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  70 ++--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   3 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h       |  59 ---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |   5 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  89 +++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx_common.h |   2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  54 +--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  47 +--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   4 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.h         |   4 +
 drivers/net/ethernet/intel/iavf/iavf_common.c      |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   5 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c        |   1 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   1 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   3 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  74 ++--
 drivers/net/ethernet/intel/ice/ice_switch.c        |  24 +-
 drivers/net/ethernet/intel/ice/ice_switch.h        |   4 +-
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  18 +-
 drivers/net/ethernet/intel/igb/e1000_82575.c       |  29 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c        |  19 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c         |   2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c         |  18 +-
 drivers/net/ethernet/intel/igb/e1000_phy.c         |  13 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   8 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   4 +-
 drivers/net/ethernet/intel/igbvf/mbx.c             |   1 +
 drivers/net/ethernet/intel/igbvf/netdev.c          |  33 +-
 drivers/net/ethernet/intel/igc/igc_i225.c          |   1 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 -
 drivers/net/ethernet/intel/igc/igc_phy.c           |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  30 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |  19 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  31 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  18 +
 drivers/net/ethernet/microchip/lan743x_main.h      |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  40 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  33 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +-
 drivers/net/phy/micrel.c                           |  31 +-
 drivers/net/usb/ax88179_178a.c                     |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  31 +-
 drivers/net/wwan/t7xx/t7xx_cldma.c                 |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   9 +-
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c              |   8 +-
 drivers/net/xen-netfront.c                         |   1 +
 drivers/of/dynamic.c                               |  12 +
 drivers/of/module.c                                |   8 +
 drivers/perf/riscv_pmu.c                           |   4 +
 drivers/s390/net/qeth_core_main.c                  |  38 +-
 drivers/scsi/myrb.c                                |  20 +-
 drivers/scsi/myrs.c                                |  24 +-
 drivers/scsi/sd.c                                  |   2 +-
 drivers/scsi/sg.c                                  |   4 +-
 drivers/spi/spi-pci1xxxx.c                         |   2 +
 drivers/spi/spi-s3c64xx.c                          |  80 ++--
 drivers/usb/typec/ucsi/ucsi.c                      |  10 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |  14 +
 fs/btrfs/extent_io.c                               | 208 +++++++---
 fs/btrfs/inode.c                                   |  22 +-
 fs/nfsd/nfs4state.c                                |   7 +-
 fs/pipe.c                                          |  17 +-
 fs/smb/client/cached_dir.c                         |   6 +-
 fs/smb/client/cifs_debug.c                         |   6 +
 fs/smb/client/cifsfs.c                             |  11 +
 fs/smb/client/cifsglob.h                           |  17 +-
 fs/smb/client/connect.c                            |  45 ++-
 fs/smb/client/dir.c                                |  15 +
 fs/smb/client/file.c                               | 111 +++++-
 fs/smb/client/fs_context.c                         |   6 +-
 fs/smb/client/fs_context.h                         |  12 +
 fs/smb/client/fscache.c                            |  16 +-
 fs/smb/client/fscache.h                            |   6 +
 fs/smb/client/inode.c                              |   2 +
 fs/smb/client/ioctl.c                              |   6 +-
 fs/smb/client/misc.c                               |   2 +
 fs/smb/client/smb1ops.c                            |   4 +-
 fs/smb/client/smb2misc.c                           |   4 +
 fs/smb/client/smb2ops.c                            |  11 +-
 fs/smb/client/smb2pdu.c                            |   2 +-
 fs/smb/server/ksmbd_netlink.h                      |   3 +-
 fs/smb/server/mgmt/share_config.c                  |   7 +-
 fs/smb/server/smb2ops.c                            |  10 +-
 fs/smb/server/smb2pdu.c                            |   3 +-
 fs/smb/server/transport_ipc.c                      |  37 ++
 fs/vboxsf/super.c                                  |   3 +-
 include/kvm/arm_pmu.h                              |   2 +-
 include/linux/avf/virtchnl.h                       |   5 +
 include/linux/bpf.h                                |  16 +-
 include/linux/device.h                             |   1 +
 include/linux/io_uring_types.h                     |   1 -
 include/linux/secretmem.h                          |   4 +-
 include/linux/skbuff.h                             |   7 +-
 include/linux/udp.h                                |  28 ++
 include/net/bluetooth/hci.h                        |   9 +
 include/net/inet_connection_sock.h                 |   1 +
 include/net/mana/mana.h                            |   1 -
 include/net/sock.h                                 |   7 +
 io_uring/io_uring.c                                |  18 +-
 io_uring/kbuf.c                                    | 116 ++----
 io_uring/kbuf.h                                    |   8 +-
 kernel/bpf/syscall.c                               |  35 +-
 kernel/bpf/verifier.c                              |   5 +
 kernel/trace/bpf_trace.c                           |  10 +-
 mm/memory.c                                        |   4 +
 net/9p/client.c                                    |  10 +-
 net/ax25/ax25_dev.c                                |   2 +-
 net/bluetooth/hci_debugfs.c                        |  64 ++--
 net/bluetooth/hci_event.c                          |  25 ++
 net/bluetooth/hci_sync.c                           |   5 +-
 net/bridge/netfilter/ebtables.c                    |   6 +
 net/core/gro.c                                     |   3 +-
 net/core/sock_map.c                                |   6 +
 net/hsr/hsr_slave.c                                |   3 +-
 net/ipv4/inet_connection_sock.c                    |  33 +-
 net/ipv4/inet_fragment.c                           |  70 +++-
 net/ipv4/ip_fragment.c                             |   2 +-
 net/ipv4/ip_gre.c                                  |   5 +
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/tcp.c                                     |   2 +
 net/ipv4/udp.c                                     |   7 +
 net/ipv4/udp_offload.c                             |  23 +-
 net/ipv6/ip6_fib.c                                 |  14 +-
 net/ipv6/ip6_gre.c                                 |   3 +
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 +-
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/udp_offload.c                             |   8 +-
 net/mptcp/protocol.c                               | 106 ++----
 net/mptcp/subflow.c                                |   2 +
 net/netfilter/nf_tables_api.c                      |  92 ++++-
 net/nfc/nci/core.c                                 |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/act_skbmod.c                             |  10 +-
 net/sched/sch_api.c                                |   2 +-
 net/sunrpc/svcsock.c                               |  10 +-
 net/tls/tls_sw.c                                   |   7 +-
 net/vmw_vsock/virtio_transport.c                   |   3 +-
 scripts/bpf_doc.py                                 |   4 +-
 scripts/mod/Makefile                               |   4 +-
 scripts/mod/modpost.c                              |  73 +---
 scripts/mod/modpost.h                              |  25 ++
 scripts/mod/symsearch.c                            | 199 ++++++++++
 security/selinux/selinuxfs.c                       |  12 +-
 sound/pci/emu10k1/emu10k1_callback.c               |   7 +-
 sound/pci/hda/cs35l56_hda.c                        |   4 +-
 sound/pci/hda/cs35l56_hda_i2c.c                    |  13 +-
 sound/pci/hda/cs35l56_hda_spi.c                    |  13 +-
 sound/pci/hda/patch_realtek.c                      |   3 +-
 sound/soc/amd/acp/acp-pci.c                        |   5 +-
 sound/soc/codecs/rt5682-sdw.c                      |   4 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |   4 +-
 sound/soc/codecs/rt711-sdw.c                       |   4 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |   5 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |   4 +-
 sound/soc/codecs/wm_adsp.c                         |   3 +-
 sound/soc/soc-ops.c                                |   2 +-
 sound/soc/sof/amd/acp.c                            |   8 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   2 +-
 tools/net/ynl/ynl-gen-c.py                         |   7 +-
 tools/testing/selftests/mm/vm_util.h               |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  85 +++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +-
 tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
 tools/testing/selftests/net/test_vxlan_mdb.sh      | 205 ++++++----
 tools/testing/selftests/net/udpgro_fwd.sh          |  10 +-
 343 files changed, 3828 insertions(+), 2302 deletions(-)



