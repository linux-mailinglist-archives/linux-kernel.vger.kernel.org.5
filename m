Return-Path: <linux-kernel+bounces-63978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7D853756
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A515B22AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92B5FF06;
	Tue, 13 Feb 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PzYncmrG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F55FBB5;
	Tue, 13 Feb 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845052; cv=none; b=Dl2yUwTgW++HdJ1LVXp1V/OMI/9V/Q5vMwy2matLx8kf8nBhTKu5DQqTD9r3tE642EXOdvWJQhXM7W1DRZ7ZG3yd0roGYVzswUjXSH3GE4lrjBHB26jeR+s9lcRs/dHM2j4YgO0gn6MA697FieULaq5uwqW92snJSD/lld78X8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845052; c=relaxed/simple;
	bh=x2zqOmNG6BRFCRzdIxbAVRNBSLhD4v0wlRDm1bQ3Yb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4lS0C3auie4y4GGix1fNzDbAKzkTCbvSSnKQQ2UHtyiJcKbTukyf/ZnWpJO/BgJd39pzv6lY+0rPFtB1sqCAe9vw+tpDsZCnNI/wJ4DEA8aaqFcYYD5tvu6spEem30z5VtGYNdns7iVUpB2Uek99fBvUeSHRFPAoxqL0uH8jsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PzYncmrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DE1C433C7;
	Tue, 13 Feb 2024 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845052;
	bh=x2zqOmNG6BRFCRzdIxbAVRNBSLhD4v0wlRDm1bQ3Yb8=;
	h=From:To:Cc:Subject:Date:From;
	b=PzYncmrGHATf9IxvVtvMWOSOplDYBZBNiMCLOv8B538WS1MWf43IdCc5eogXzHAQt
	 L90ewzEtgjbK+L+VQmFKfiQ2mnjv4fW/fH/ltZ+g9cDwt1d+R1ozGrrnDpUbDI+yke
	 qHNVgk7UAwvelMzvyQajCCcPyVWlry90ARD5rJTY=
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
Subject: [PATCH 6.1 00/64] 6.1.78-rc1 review
Date: Tue, 13 Feb 2024 18:20:46 +0100
Message-ID: <20240213171844.702064831@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.78-rc1
X-KernelTest-Deadline: 2024-02-15T17:18+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.78 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.78-rc1

Jiri Wiesner <jwiesner@suse.de>
    clocksource: Skip watchdog check for large watchdog intervals

Jens Axboe <axboe@kernel.dk>
    block: treat poll queue enter similarly to timeouts

Sheng Yong <shengyong@oppo.com>
    f2fs: add helper to check compression level

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/irdma: Fix support for 64k pages

Prathu Baronia <prathubaronia2011@gmail.com>
    vhost: use kzalloc() instead of kmalloc() followed by memset()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ASoC: amd: Add new dmi entries for acp5x platform"

Jens Axboe <axboe@kernel.dk>
    io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Frederic Weisbecker <frederic@kernel.org>
    hrtimer: Report offline hrtimer enqueue

Michal Pecio <michal.pecio@gmail.com>
    xhci: handle isoc Babble and Buffer Overrun events properly

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: process isoc TD properly when there was a transaction error mid TD.

Prashanth K <quic_prashk@quicinc.com>
    usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Prashanth K <quic_prashk@quicinc.com>
    usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK

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

Francesco Dolcini <francesco.dolcini@toradex.com>
    mtd: parsers: ofpart: add workaround for #size-cells 0

Alexander Aring <aahringo@redhat.com>
    fs: dlm: don't put dlm_local_addrs on heap

Tejun Heo <tj@kernel.org>
    blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

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

David Howells <dhowells@redhat.com>
    rxrpc: Fix response to PING RESPONSE ACKs to a dead call

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

Paolo Abeni <pabeni@redhat.com>
    selftests: net: avoid just another constant wait

Paolo Abeni <pabeni@redhat.com>
    selftests: net: cut more slack for gro fwd tests.

Ivan Vecera <ivecera@redhat.com>
    net: atlantic: Fix DMA mapping for PTP hwts ring

Eric Dumazet <edumazet@google.com>
    netdevsim: avoid potential loop in nsim_dev_trap_report_work()

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix waiting for beacons logic

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix handling of DPP safety error for DMA channels

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msms/dp: fixed link clock divider bits be over written in BPC unknown case

Shyam Prasad N <sprasad@microsoft.com>
    cifs: failure to add channel on iface should bump up weight

Tony Lindgren <tony@atomide.com>
    phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Frank Li <Frank.Li@nxp.com>
    dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

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

 Makefile                                           |   4 +-
 block/blk-core.c                                   |  11 ++-
 block/blk-iocost.c                                 |   7 ++
 drivers/atm/idt77252.c                             |   2 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  10 +-
 drivers/dma/fsl-qdma.c                             |  27 ++----
 drivers/dma/ti/k3-udma.c                           |  10 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   4 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   5 -
 drivers/gpu/drm/msm/dp/dp_link.c                   |  22 +++--
 drivers/gpu/drm/msm/dp/dp_reg.h                    |   3 +
 drivers/hwmon/aspeed-pwm-tacho.c                   |   7 ++
 drivers/hwmon/coretemp.c                           |  40 ++++----
 drivers/infiniband/hw/irdma/verbs.c                |   2 +-
 drivers/input/keyboard/atkbd.c                     |  13 ++-
 drivers/input/serio/i8042-acpipnpio.h              |   6 ++
 drivers/mtd/parsers/ofpart_core.c                  |  19 ++++
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  13 +++
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  14 ++-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  57 ++++++++++-
 drivers/net/netdevsim/dev.c                        |   8 +-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/scsi/scsi_error.c                          |   3 +-
 drivers/scsi/scsi_lib.c                            |   4 +-
 drivers/usb/dwc3/host.c                            |   4 +-
 drivers/usb/host/xhci-plat.c                       |   3 +
 drivers/usb/host/xhci-ring.c                       |  80 ++++++++++++---
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/vhost/vhost.c                              |   5 +-
 fs/dlm/lowcomms.c                                  |  38 +++-----
 fs/ext4/mballoc.c                                  |  20 ++++
 fs/f2fs/compress.c                                 |  27 ++++++
 fs/f2fs/f2fs.h                                     |   2 +
 fs/f2fs/super.c                                    |   4 +-
 fs/ntfs3/ntfs_fs.h                                 |   2 +-
 fs/smb/client/sess.c                               |   2 +
 include/linux/dmaengine.h                          |   3 +-
 include/linux/hrtimer.h                            |   4 +-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 io_uring/net.c                                     |   1 +
 kernel/time/clocksource.c                          |  25 ++++-
 kernel/time/hrtimer.c                              |   3 +
 net/ipv4/af_inet.c                                 |   6 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/mac80211/mlme.c                                |   3 +-
 net/netfilter/nft_compat.c                         |  17 +++-
 net/netfilter/nft_ct.c                             |   3 +
 net/netfilter/nft_set_pipapo.c                     | 108 ++++++++++-----------
 net/netfilter/nft_set_pipapo.h                     |  18 +++-
 net/netfilter/nft_set_pipapo_avx2.c                |  17 ++--
 net/rxrpc/conn_event.c                             |   8 ++
 net/tipc/bearer.c                                  |   6 ++
 net/unix/garbage.c                                 |  11 +++
 sound/soc/amd/acp-config.c                         |  15 +--
 sound/usb/quirks.c                                 |   6 ++
 tools/testing/selftests/net/cmsg_ipv6.sh           |   4 +-
 tools/testing/selftests/net/pmtu.sh                |  18 +++-
 tools/testing/selftests/net/udpgro_fwd.sh          |  14 ++-
 tools/testing/selftests/net/udpgso_bench_rx.c      |   2 +-
 70 files changed, 566 insertions(+), 239 deletions(-)



