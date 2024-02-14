Return-Path: <linux-kernel+bounces-65339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61C854B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409601F2312B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC455E54;
	Wed, 14 Feb 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14EzFIZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD258135;
	Wed, 14 Feb 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921023; cv=none; b=ErC2Mb6MEv1xLAKoM4SBPRPKDwQ5RU0nC0jfk69JTN2+wPoAgkDKry2ijtEBPq51QMEP3Fo0Sj3z4hA9DcS2IQMVw4VU7wA0qE2hAp44F6N/+4eJ7KboWNbTq1tS3qEnBLCZDt6ObUZDxWbney6Cd3EoRk0Cshm4rGWfSOrQkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921023; c=relaxed/simple;
	bh=RNIomblniSuNjQ7zPXbprVL612eDYO5QFRHpihg1FjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFbH6rCza7zFYo1AT3h+oa9k2LquKomrtO8DrRGCcwG8RVxCYoVVXCqx1sTCS1GQcvthgIuI1TclMlz8uc8syivNqWNV8OZnnjJBtLYjpkDiemM29/QajqCcrE5+z+nim0WuHJXd7pOm2cZbkpn2lR0ixnac18KfkR0TooW0iQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14EzFIZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048F5C43390;
	Wed, 14 Feb 2024 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707921023;
	bh=RNIomblniSuNjQ7zPXbprVL612eDYO5QFRHpihg1FjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=14EzFIZiaXC6z+nnPYXLkL3aNONacBqVkBjaBExJv8kiBa1/KMhxRtb2ZBr0mFAMo
	 PdXQ/fatM0YQd0TEH9rNuMOeU6cA5e/K4UHysz0SC2+lLpL607l1gviw2YfTiTL76H
	 3MgwxPBH2wRUZL/R4WMoNGMbFW23Ml81XC3pbOL8=
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
Subject: [PATCH 6.1 00/65] 6.1.78-rc2 review
Date: Wed, 14 Feb 2024 15:30:19 +0100
Message-ID: <20240214142941.551330912@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.78-rc2
X-KernelTest-Deadline: 2024-02-16T14:29+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.78 release.
There are 65 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.78-rc2

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Sort quirk table entries

Simon Horman <horms@kernel.org>
    net: stmmac: xgmac: use #define for string constants

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
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  58 ++++++++++-
 drivers/net/netdevsim/dev.c                        |   8 +-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/scsi/scsi_error.c                          |   3 +-
 drivers/scsi/scsi_lib.c                            |   4 +-
 drivers/usb/dwc3/host.c                            |   4 +-
 drivers/usb/host/xhci-plat.c                       |   3 +
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
 sound/usb/quirks.c                                 |  38 +++++---
 tools/testing/selftests/net/cmsg_ipv6.sh           |   4 +-
 tools/testing/selftests/net/pmtu.sh                |  18 +++-
 tools/testing/selftests/net/udpgro_fwd.sh          |  14 ++-
 tools/testing/selftests/net/udpgso_bench_rx.c      |   2 +-
 68 files changed, 517 insertions(+), 240 deletions(-)



