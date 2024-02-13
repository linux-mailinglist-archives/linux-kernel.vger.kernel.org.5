Return-Path: <linux-kernel+bounces-63983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E5853799
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97262852D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E785FEFA;
	Tue, 13 Feb 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zadwl/g+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050275F54E;
	Tue, 13 Feb 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845225; cv=none; b=LyclozOCYYIgzXHtTl0ZBRVp5oTFJhWjuG0HNM217mT4yXSv1h3OpDi9IoO6ITmWOXsJ681q2rm7ndN1OtjY0NuBKfLTEeN1wVpth5LVnaaTwODvLSvXP3s9QznwIETWFjkqveab8zTsqbEZJLv/SyOnQ+8Dl1k0PPHI38lV2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845225; c=relaxed/simple;
	bh=PaibcJFPRtDdz4WKXU+yFURy48PyJ/tXNZlaC/fqAWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciDPnjM9CxBx7jZd9/3bymWwQUbnlqcBLSCzO7dMykBW/NU71u+bgK/1zNKWXWiPDXffn1xeKAr2vREV9HZxkzMxXiAgWuedR+W8kSft8JcwjAGA5G1yw9gu30pstIT1CqRxdtEn5thfJX3lCrrUMpOM3s/eRlwpZaHqAMQ8z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zadwl/g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4499AC433C7;
	Tue, 13 Feb 2024 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845224;
	bh=PaibcJFPRtDdz4WKXU+yFURy48PyJ/tXNZlaC/fqAWk=;
	h=From:To:Cc:Subject:Date:From;
	b=zadwl/g+aHgJuKsn+4khMH1b6+2SaiV4NQrlMlHCiKi4wKmpaA0FWGaHozrtXKpBH
	 RG6L3HotB7hBfQ3HHV26Mg8lc/9sAzYvggdPXLE6PlCYJG66JhZeaOIjtOe4ifGg9t
	 AtOHtxjObJQBt5mgzBTfqBJHDI7WyzZ1Ngle3f3U=
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
Subject: [PATCH 6.6 000/121] 6.6.17-rc1 review
Date: Tue, 13 Feb 2024 18:20:09 +0100
Message-ID: <20240213171852.948844634@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.17-rc1
X-KernelTest-Deadline: 2024-02-15T17:18+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.17 release.
There are 121 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.17-rc1

Jens Axboe <axboe@kernel.dk>
    io_uring/net: limit inline multishot retries

Jens Axboe <axboe@kernel.dk>
    io_uring/poll: add requeue return code from poll multishot handling

Jens Axboe <axboe@kernel.dk>
    io_uring/net: un-indent mshot retry path in io_recv_finish()

Jens Axboe <axboe@kernel.dk>
    io_uring/poll: move poll execution helpers higher up

Jens Axboe <axboe@kernel.dk>
    io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers

Aurelien Jarno <aurelien@aurel32.net>
    media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ASoC: amd: Add new dmi entries for acp5x platform"

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Frederic Weisbecker <frederic@kernel.org>
    hrtimer: Report offline hrtimer enqueue

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: dwc3: pci: add support for the Intel Arrow Lake-H

Michal Pecio <michal.pecio@gmail.com>
    xhci: handle isoc Babble and Buffer Overrun events properly

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: process isoc TD properly when there was a transaction error mid TD.

Prashanth K <quic_prashk@quicinc.com>
    usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Prashanth K <quic_prashk@quicinc.com>
    usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

Badhri Jagan Sridharan <badhri@google.com>
    Revert "usb: typec: tcpm: fix cc role at port reset"

Leonard Dallmayr <leonard.dallmayr@mailbox.org>
    USB: serial: cp210x: add ID for IMST iM871A-USB

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom FM101-GL variant

JackBB Wu <wojackbb@gmail.com>
    USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Sean Young <sean@mess.org>
    ALSA: usb-audio: add quirk for RODE NT-USB+

Julian Sikorski <belegdol+github@gmail.com>
    ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Alexander Tsoy <alexander@tsoy.me>
    ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision

Tejun Heo <tj@kernel.org>
    blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Ben Dooks <ben.dooks@codethink.co.uk>
    riscv: declare overflow_stack as exported from traps.c

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix arch_hugetlb_migration_supported() for NAPOT

Xiubo Li <xiubli@redhat.com>
    libceph: just wait for more data to be available on the socket

Xiubo Li <xiubli@redhat.com>
    libceph: rename read_sparse_msg_*() to read_partial_sparse_msg_*()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Flush the tlb when a page directory is freed

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix set_huge_pte_at() for NAPOT mapping

Vincent Chen <vincent.chen@sifive.com>
    riscv: mm: execute local TLB flush after populating vmemmap

Alexandre Ghiti <alexghiti@rivosinc.com>
    mm: Introduce flush_cache_vmap_early()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Improve flush_tlb_kernel_range()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Improve tlb_flush()

Dan Carpenter <dan.carpenter@linaro.org>
    fs/ntfs3: Fix an NULL dereference bug

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: remove scratch_aligned pointer

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: add helper to release pcpu scratch area

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: store index in scratch maps

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: reject direction for ct id

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Implement bounds check for stream encoder creation in DCN301

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix 'panel_cntl' could be null in 'dcn21_set_backlight_level()'

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: restrict match/target protocol to u16

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: reject unused compat flag

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: narrow down revision to unsigned 8-bits

Jakub Kicinski <kuba@kernel.org>
    selftests: cmsg_ipv6: repeat the exact packet

Eric Dumazet <edumazet@google.com>
    ppp_async: limit MRU to 64K

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Paolo Abeni <pabeni@redhat.com>
    selftests: net: let big_tcp test cope with slow env

David Howells <dhowells@redhat.com>
    rxrpc: Fix counting of new acks and nacks

David Howells <dhowells@redhat.com>
    rxrpc: Fix response to PING RESPONSE ACKs to a dead call

David Howells <dhowells@redhat.com>
    rxrpc: Fix delayed ACKs to not set the reference serial number

David Howells <dhowells@redhat.com>
    rxrpc: Fix generation of serial numbers to skip zero

Dan Carpenter <dan.carpenter@linaro.org>
    drm/i915/gvt: Fix uninitialized variable in handle_mmio()

Eric Dumazet <edumazet@google.com>
    inet: read sk->sk_family once in inet_recv_error()

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix out-of-bounds memory access

Loic Prylli <lprylli@netflix.com>
    hwmon: (aspeed-pwm-tacho) mutex for tach reading

Zhipeng Lu <alexious@zju.edu.cn>
    octeontx2-pf: Fix a memleak otx2_sq_init

Zhipeng Lu <alexious@zju.edu.cn>
    atm: idt77252: fix a memleak in open_card_ubr0

Antoine Tenart <atenart@kernel.org>
    tunnels: fix out of bounds access when building IPv6 PMTU error

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Fix mapping for zero copy XDP_TX action

Paolo Abeni <pabeni@redhat.com>
    selftests: net: avoid just another constant wait

Paolo Abeni <pabeni@redhat.com>
    selftests: net: fix tcp listener handling in pmtu.sh

Yujie Liu <yujie.liu@intel.com>
    selftests/net: change shebang to bash to support "source"

Hangbin Liu <liuhangbin@gmail.com>
    selftests/net: convert pmtu.sh to run it in unique namespace

Hangbin Liu <liuhangbin@gmail.com>
    selftests/net: convert unicast_extensions.sh to run it in unique namespace

Paolo Abeni <pabeni@redhat.com>
    selftests: net: cut more slack for gro fwd tests.

Ivan Vecera <ivecera@redhat.com>
    net: atlantic: Fix DMA mapping for PTP hwts ring

Eric Dumazet <edumazet@google.com>
    netdevsim: avoid potential loop in nsim_dev_trap_report_work()

Kees Cook <keescook@chromium.org>
    wifi: brcmfmac: Adjust n_channels usage for __counted_by

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: exit eSR only after the FW does

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix waiting for beacons logic

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix RCU use in TDLS fast-xmit

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix handling of DPP safety error for DMA channels

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Give up if memory attribute protocol returns an error

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msms/dp: fixed link clock divider bits be over written in BPC unknown case

Christoph Hellwig <hch@lst.de>
    xfs: respect the stable writes flag on the RT device

Christoph Hellwig <hch@lst.de>
    xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags

Darrick J. Wong <djwong@kernel.org>
    xfs: dquot recovery does not validate the recovered dquot

Darrick J. Wong <djwong@kernel.org>
    xfs: clean up dqblk extraction

Dave Chinner <dchinner@redhat.com>
    xfs: inode recovery does not validate the recovered inode

Anthony Iliopoulos <ailiop@suse.com>
    xfs: fix again select in kconfig XFS_ONLINE_SCRUB_STATS

Omar Sandoval <osandov@fb.com>
    xfs: fix internal error from AGFL exhaustion

Leah Rumancik <leah.rumancik@gmail.com>
    xfs: up(ic_sema) if flushing data device fails

Christoph Hellwig <hch@lst.de>
    xfs: only remap the written blocks in xfs_reflink_end_cow_extent

Long Li <leo.lilong@huawei.com>
    xfs: abort intent items when recovery intents fail

Long Li <leo.lilong@huawei.com>
    xfs: factor out xfs_defer_pending_abort

Catherine Hoang <catherine.hoang@oracle.com>
    xfs: allow read IO and FICLONE to run concurrently

Christoph Hellwig <hch@lst.de>
    xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space

Cheng Lin <cheng.lin130@zte.com.cn>
    xfs: introduce protection for drop nlink

Darrick J. Wong <djwong@kernel.org>
    xfs: make sure maxlen is still congruent with prod when rounding down

Darrick J. Wong <djwong@kernel.org>
    xfs: fix units conversion error in xfs_bmap_del_extent_delay

Darrick J. Wong <djwong@kernel.org>
    xfs: rt stubs should return negative errnos when rt disabled

Darrick J. Wong <djwong@kernel.org>
    xfs: prevent rt growfs when quota is enabled

Darrick J. Wong <djwong@kernel.org>
    xfs: hoist freeing of rt data fork extent mappings

Darrick J. Wong <djwong@kernel.org>
    xfs: bump max fsgeom struct version

Catherine Hoang <catherine.hoang@oracle.com>
    MAINTAINERS: add Catherine as xfs maintainer for 6.6.y

Miguel Ojeda <ojeda@kernel.org>
    rust: upgrade to Rust 1.73.0

Miguel Ojeda <ojeda@kernel.org>
    rust: print: use explicit link in documentation

Miguel Ojeda <ojeda@kernel.org>
    rust: task: remove redundant explicit link

Miguel Ojeda <ojeda@kernel.org>
    rust: upgrade to Rust 1.72.1

Miguel Ojeda <ojeda@kernel.org>
    rust: arc: add explicit `drop()` around `Box::from_raw()`

Shyam Prasad N <sprasad@microsoft.com>
    cifs: failure to add channel on iface should bump up weight

Shyam Prasad N <sprasad@microsoft.com>
    cifs: avoid redundant calls to disable multichannel

Tony Lindgren <tony@atomide.com>
    phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Frank Li <Frank.Li@nxp.com>
    dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

James Clark <james.clark@arm.com>
    perf evlist: Fix evlist__new_default() for > 1 core PMU

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA

Jai Luthra <j-luthra@ti.com>
    dmaengine: ti: k3-udma: Report short packet errors

Guanhua Gao <guanhua.gao@nxp.com>
    dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Baokun Li <libaokun1@huawei.com>
    ext4: regenerate buddy after block freeing failed if under fc replay


-------------

Diffstat:

 Documentation/process/changes.rst                  |   2 +-
 MAINTAINERS                                        |   1 +
 Makefile                                           |   4 +-
 arch/arc/include/asm/cacheflush.h                  |   1 +
 arch/arm/include/asm/cacheflush.h                  |   2 +
 arch/csky/abiv1/inc/abi/cacheflush.h               |   1 +
 arch/csky/abiv2/inc/abi/cacheflush.h               |   1 +
 arch/m68k/include/asm/cacheflush_mm.h              |   1 +
 arch/mips/include/asm/cacheflush.h                 |   2 +
 arch/nios2/include/asm/cacheflush.h                |   1 +
 arch/parisc/include/asm/cacheflush.h               |   1 +
 arch/riscv/include/asm/cacheflush.h                |   3 +-
 arch/riscv/include/asm/hugetlb.h                   |   3 +
 arch/riscv/include/asm/sbi.h                       |   3 -
 arch/riscv/include/asm/stacktrace.h                |   5 +
 arch/riscv/include/asm/tlb.h                       |   8 +-
 arch/riscv/include/asm/tlbflush.h                  |  17 +-
 arch/riscv/kernel/sbi.c                            |  32 ++--
 arch/riscv/mm/hugetlbpage.c                        |  78 +++++++-
 arch/riscv/mm/init.c                               |   4 +
 arch/riscv/mm/tlbflush.c                           | 156 +++++++++-------
 arch/sh/include/asm/cacheflush.h                   |   1 +
 arch/sparc/include/asm/cacheflush_32.h             |   1 +
 arch/sparc/include/asm/cacheflush_64.h             |   1 +
 arch/x86/lib/getuser.S                             |  24 +--
 arch/x86/lib/putuser.S                             |  20 +--
 arch/xtensa/include/asm/cacheflush.h               |   6 +-
 block/blk-iocost.c                                 |   7 +
 drivers/atm/idt77252.c                             |   2 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  10 +-
 drivers/dma/fsl-qdma.c                             |  27 ++-
 drivers/dma/ti/k3-udma.c                           |  10 +-
 drivers/firmware/efi/libstub/efistub.h             |   3 +-
 drivers/firmware/efi/libstub/kaslr.c               |   2 +-
 drivers/firmware/efi/libstub/randomalloc.c         |  12 +-
 drivers/firmware/efi/libstub/x86-stub.c            |  25 +--
 drivers/firmware/efi/libstub/x86-stub.h            |   4 +-
 drivers/firmware/efi/libstub/zboot.c               |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |  63 ++++---
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   4 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   5 -
 drivers/gpu/drm/msm/dp/dp_link.c                   |  22 ++-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |   3 +
 drivers/hwmon/aspeed-pwm-tacho.c                   |   7 +
 drivers/hwmon/coretemp.c                           |  40 +++--
 drivers/input/keyboard/atkbd.c                     |  13 +-
 drivers/input/serio/i8042-acpipnpio.h              |   6 +
 drivers/media/pci/solo6x10/solo6x10-offsets.h      |  10 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  13 ++
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   1 +
 drivers/net/ethernet/engleder/tsnep_main.c         |  16 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  14 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  57 +++++-
 drivers/net/netdevsim/dev.c                        |   8 +-
 drivers/net/ppp/ppp_async.c                        |   4 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   6 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/scsi/scsi_error.c                          |   3 +-
 drivers/scsi/scsi_lib.c                            |   4 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   4 +
 drivers/usb/dwc3/host.c                            |   4 +-
 drivers/usb/host/xhci-plat.c                       |   3 +
 drivers/usb/host/xhci-ring.c                       |  80 +++++++--
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/usb/typec/tcpm/tcpm.c                      |   3 +-
 fs/ext4/mballoc.c                                  |  20 +++
 fs/ntfs3/ntfs_fs.h                                 |   2 +-
 fs/smb/client/sess.c                               |   2 +
 fs/smb/client/smb2pdu.c                            |   2 +-
 fs/xfs/Kconfig                                     |   2 +-
 fs/xfs/libxfs/xfs_alloc.c                          |  27 ++-
 fs/xfs/libxfs/xfs_bmap.c                           |  21 +--
 fs/xfs/libxfs/xfs_defer.c                          |  38 ++--
 fs/xfs/libxfs/xfs_defer.h                          |   2 +-
 fs/xfs/libxfs/xfs_inode_buf.c                      |   3 +
 fs/xfs/libxfs/xfs_rtbitmap.c                       |  33 ++++
 fs/xfs/libxfs/xfs_sb.h                             |   2 +-
 fs/xfs/xfs_bmap_util.c                             |  24 +--
 fs/xfs/xfs_dquot.c                                 |   5 +-
 fs/xfs/xfs_dquot_item_recover.c                    |  21 ++-
 fs/xfs/xfs_file.c                                  |  63 +++++--
 fs/xfs/xfs_inode.c                                 |  24 +++
 fs/xfs/xfs_inode.h                                 |  17 ++
 fs/xfs/xfs_inode_item_recover.c                    |  14 +-
 fs/xfs/xfs_ioctl.c                                 |  34 ++--
 fs/xfs/xfs_iops.c                                  |   7 +
 fs/xfs/xfs_log.c                                   |  23 +--
 fs/xfs/xfs_log_recover.c                           |   2 +-
 fs/xfs/xfs_reflink.c                               |   5 +
 fs/xfs/xfs_rtalloc.c                               |  33 +++-
 fs/xfs/xfs_rtalloc.h                               |  27 +--
 include/asm-generic/cacheflush.h                   |   6 +
 include/linux/ceph/messenger.h                     |   2 +-
 include/linux/dmaengine.h                          |   3 +-
 include/linux/hrtimer.h                            |   4 +-
 include/trace/events/rxrpc.h                       |   8 +-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 io_uring/io_uring.h                                |   7 +
 io_uring/net.c                                     |  54 ++++--
 io_uring/poll.c                                    |  39 ++--
 kernel/time/hrtimer.c                              |   3 +
 mm/percpu.c                                        |   8 +-
 net/ceph/messenger_v1.c                            |  33 ++--
 net/ceph/messenger_v2.c                            |   4 +-
 net/ceph/osd_client.c                              |   9 +-
 net/ipv4/af_inet.c                                 |   6 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/mac80211/mlme.c                                |   3 +-
 net/mac80211/tx.c                                  |   7 +-
 net/netfilter/nft_compat.c                         |  17 +-
 net/netfilter/nft_ct.c                             |   3 +
 net/netfilter/nft_set_pipapo.c                     | 108 +++++------
 net/netfilter/nft_set_pipapo.h                     |  18 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  17 +-
 net/rxrpc/ar-internal.h                            |  37 +++-
 net/rxrpc/call_event.c                             |  12 +-
 net/rxrpc/call_object.c                            |   1 +
 net/rxrpc/conn_event.c                             |  10 +-
 net/rxrpc/input.c                                  | 115 ++++++++++--
 net/rxrpc/output.c                                 |   8 +-
 net/rxrpc/proc.c                                   |   2 +-
 net/rxrpc/rxkad.c                                  |   4 +-
 net/tipc/bearer.c                                  |   6 +
 net/unix/garbage.c                                 |  11 ++
 rust/alloc/alloc.rs                                |  21 ---
 rust/alloc/boxed.rs                                |  56 ++++--
 rust/alloc/lib.rs                                  |  13 +-
 rust/alloc/raw_vec.rs                              |  30 ++--
 rust/alloc/vec/drain_filter.rs                     | 199 ---------------------
 rust/alloc/vec/extract_if.rs                       | 115 ++++++++++++
 rust/alloc/vec/mod.rs                              | 110 ++++++------
 rust/alloc/vec/spec_extend.rs                      |   8 +-
 rust/compiler_builtins.rs                          |   1 +
 rust/kernel/print.rs                               |   1 +
 rust/kernel/sync/arc.rs                            |   2 +-
 rust/kernel/task.rs                                |   2 +-
 scripts/min-tool-version.sh                        |   2 +-
 sound/soc/amd/acp-config.c                         |  15 +-
 sound/usb/quirks.c                                 |   6 +
 tools/perf/util/evlist.c                           |   9 +-
 tools/testing/selftests/net/big_tcp.sh             |   4 +-
 tools/testing/selftests/net/cmsg_ipv6.sh           |   4 +-
 tools/testing/selftests/net/pmtu.sh                |  52 +++---
 tools/testing/selftests/net/udpgro_fwd.sh          |  14 +-
 tools/testing/selftests/net/udpgso_bench_rx.c      |   2 +-
 tools/testing/selftests/net/unicast_extensions.sh  |  93 +++++-----
 156 files changed, 1686 insertions(+), 1003 deletions(-)



