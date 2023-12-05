Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A938047A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjLEDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:40:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BDDD3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:40:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8159EC433CA;
        Tue,  5 Dec 2023 03:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701747643;
        bh=NjJvqoytWXD2V/RsA6tnjq0ClaI32NmWVtRaYlqOtT0=;
        h=From:To:Cc:Subject:Date:From;
        b=xNFxPgpgqZAs9bFTW3SDUQfcRRDgJB/1t8JkkXNs/KbJvRx9lRHcflMxpjwzKSI24
         8pX6iSwIVtmO7/chL0T3DwD41G4d+BqW3twuyxe1d5VFh/f1I0f4DNt4GKNeIcQlAv
         JwpFmsUAyVjDEapttOuVTKncUez5/IX4y4NgO298=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: [PATCH 5.15 00/67] 5.15.142-rc1 review
Date:   Tue,  5 Dec 2023 12:16:45 +0900
Message-ID: <20231205031519.853779502@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.142-rc1
X-KernelTest-Deadline: 2023-12-07T03:15+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.142 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.142-rc1

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix deadlock on RTL8125 in jumbo mtu mode

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ASPM in case of tx timeout

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Heiner Kallweit <hkallweit1@gmail.com>
    mmc: core: add helpers mmc_regulator_enable/disable_vqmmc

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Make context clearing consistent with context mapping

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Omit devTLB invalidation requests when TES=0

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: don't warn for disabling a non-existing frequency

Steve French <stfrench@microsoft.com>
    smb3: fix caching of ctime on setxattr

Jeff Layton <jlayton@kernel.org>
    fs: add ctime accessors infrastructure

Helge Deller <deller@gmx.de>
    fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Mark Hasemeyer <markhas@chromium.org>
    ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-pci-dev: don't use the community key on APL Chromebooks

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-pci-dev: add parameter to override topology filename

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-pci-dev: use community key on all Up boards

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: Move soc_intel_is_foo() helpers to a generic header

Steve French <stfrench@microsoft.com>
    smb3: fix touch -h of symlink

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Move _GNU_SOURCE define into Makefile

Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
    selftests/resctrl: Add missing SPDX license to Makefile

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix async branch flags

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Stop DMA in case of failures on ravb_open()

Phil Edworthy <phil.edworthy@renesas.com>
    ravb: Support separate Line0 (Desc), Line1 (Err) and Line2 (Mgmt) irqs

Phil Edworthy <phil.edworthy@renesas.com>
    ravb: Separate handling of irq enable/disable regs into feature

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Start TX queues after HW initialization succeeded

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Use pm_runtime_resume_and_get()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Check return value of reset_control_deassert()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix races between ravb_tx_timeout_work() and net related ops

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: prevent potential deadlock in rtl8169_close

Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    Revert "workqueue: remove unused cancel_work()"

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: Disable FPE MMC interrupts

Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
    octeontx2-af: Fix possible buffer overflow

Willem de Bruijn <willemb@google.com>
    selftests/net: ipsec: fix constant out of range

Dmitry Antipov <dmantipov@yandex.ru>
    uapi: propagate __struct_group() attributes to the container union

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-eth: increase the needed headroom to account for alignment

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

Niklas Neronin <niklas.neronin@linux.intel.com>
    usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Change configuration warnings to notices

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: fix race of netvsc and VF register_netdevice

Patrick Wang <patrick.wang.shcn@gmail.com>
    rcu: Avoid tracing a few functions executed in stop machine

Xin Long <lucien.xin@gmail.com>
    vlan: move dev_put into vlan_dev_uninit

Xin Long <lucien.xin@gmail.com>
    vlan: introduce vlan_dev_free_egress_priority

Max Nguyen <maxwell.nguyen@hp.com>
    Input: xpad - add HyperX Clutch Gladiate Support

Filipe Manana <fdmanana@suse.com>
    btrfs: make error messages more clear when getting a chunk map

Jann Horn <jannh@google.com>
    btrfs: send: ensure send_fd is writable

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one when checking chunk map includes logical address

Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
    btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

Qu Wenruo <wqu@suse.com>
    btrfs: add dmesg output for first mount and last unmount of a filesystem

Helge Deller <deller@gmx.de>
    parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes

Timothy Pearson <tpearson@raptorengineering.com>
    powerpc: Don't clobber f0/vs0 during fp|altivec register save

Abdul Halim, Mohd Syazwan <mohd.syazwan.abdul.halim@intel.com>
    iommu/vt-d: Add MTL to quirk list to skip TE disabling

Markus Weippert <markus@gekmihesg.de>
    bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Wu Bo <bo.wu@vivo.com>
    dm verity: don't perform FEC for failed readahead IO

Mikulas Patocka <mpatocka@redhat.com>
    dm-verity: align struct dm_verity_fec_io properly

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Headset Mic VREF to 100%

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Disable power-save on KONTRON SinglePC

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Be sure to wait while busy in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Do not lose cache flush during CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Retry commands in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Fix task clearing in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Warn of halt or task clear failure

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Increase recovery halt timeout

Yang Yingliang <yangyingliang@huawei.com>
    firewire: core: fix possible memory leak in create_units()

Maria Yu <quic_aiquny@quicinc.com>
    pinctrl: avoid reload of p state in list iteration

Adrian Hunter <adrian.hunter@intel.com>
    perf inject: Fix GEN_ELF_TEXT_OFFSET for jit


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/parisc/include/uapi/asm/errno.h               |  2 -
 arch/powerpc/kernel/fpu.S                          | 13 ++++
 arch/powerpc/kernel/vector.S                       |  2 +
 arch/powerpc/platforms/pseries/iommu.c             |  8 +-
 drivers/cpufreq/imx6q-cpufreq.c                    | 32 ++++----
 drivers/firewire/core-device.c                     | 11 +--
 drivers/input/joystick/xpad.c                      |  2 +
 drivers/iommu/intel/dmar.c                         | 18 +++++
 drivers/iommu/intel/iommu.c                        |  6 +-
 drivers/md/bcache/btree.c                          |  2 +-
 drivers/md/dm-verity-fec.c                         |  3 +-
 drivers/md/dm-verity-target.c                      |  4 +-
 drivers/md/dm-verity.h                             |  6 --
 drivers/mmc/core/block.c                           |  2 +
 drivers/mmc/core/core.c                            |  9 ++-
 drivers/mmc/core/regulator.c                       | 41 ++++++++++
 drivers/mmc/host/cqhci-core.c                      | 44 +++++------
 drivers/mmc/host/sdhci-sprd.c                      | 25 ++++++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  8 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  7 +-
 drivers/net/ethernet/realtek/r8169_main.c          | 23 +++++-
 drivers/net/ethernet/renesas/ravb.h                |  4 +
 drivers/net/ethernet/renesas/ravb_main.c           | 91 ++++++++++++++++++----
 drivers/net/ethernet/renesas/ravb_ptp.c            |  6 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |  4 +
 drivers/net/hyperv/netvsc_drv.c                    | 25 +++---
 drivers/pinctrl/core.c                             |  6 +-
 drivers/usb/core/config.c                          | 85 ++++++++++----------
 drivers/video/fbdev/sticore.h                      |  2 +-
 fs/btrfs/disk-io.c                                 |  1 +
 fs/btrfs/ref-verify.c                              |  2 +
 fs/btrfs/send.c                                    |  2 +-
 fs/btrfs/super.c                                   |  5 +-
 fs/btrfs/volumes.c                                 |  9 ++-
 fs/cifs/cifsfs.c                                   |  1 +
 fs/cifs/xattr.c                                    |  5 +-
 fs/inode.c                                         | 16 ++++
 include/linux/fs.h                                 | 45 ++++++++++-
 include/linux/mmc/host.h                           |  3 +
 include/linux/platform_data/x86/soc.h              | 65 ++++++++++++++++
 include/linux/workqueue.h                          |  1 +
 include/uapi/linux/stddef.h                        |  2 +-
 kernel/rcu/tree_plugin.h                           |  8 +-
 kernel/workqueue.c                                 |  9 +++
 lib/errname.c                                      |  6 --
 net/8021q/vlan.h                                   |  2 +-
 net/8021q/vlan_dev.c                               | 15 +++-
 net/8021q/vlan_netlink.c                           |  7 +-
 net/ipv4/igmp.c                                    |  6 +-
 sound/pci/hda/hda_intel.c                          |  2 +
 sound/pci/hda/patch_realtek.c                      | 12 +++
 sound/soc/intel/common/soc-intel-quirks.h          | 51 +-----------
 sound/soc/sof/sof-pci-dev.c                        | 62 +++++++++++----
 tools/arch/parisc/include/uapi/asm/errno.h         |  2 -
 tools/perf/util/genelf.h                           |  4 +-
 tools/perf/util/intel-pt.c                         |  2 +
 tools/testing/selftests/net/ipsec.c                |  4 +-
 tools/testing/selftests/resctrl/Makefile           |  4 +-
 tools/testing/selftests/resctrl/resctrl.h          |  1 -
 62 files changed, 606 insertions(+), 249 deletions(-)


