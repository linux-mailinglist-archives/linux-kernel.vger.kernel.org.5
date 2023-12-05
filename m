Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574A8047F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjLEDoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjLEDoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:44:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2170DC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:44:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327ABC433C7;
        Tue,  5 Dec 2023 03:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701747846;
        bh=W5KT1oSi459+d1VDnrkGehq0KhGZz7QGFqHNGQy3ePo=;
        h=From:To:Cc:Subject:Date:From;
        b=kvGSzOuQptOjDxMJu/h/mStBnMQ7BEbBW/s9mug8EaAGPEh5kx1cdp+zWHJcEHhGO
         u0dv2AFTCTVthEGtkkR3XO50GaOTmLPrPCk3dnK2Qy64uR+CPVG+n5coBiakQhQsps
         6Cx08lbp5NpmFaeIPA3RWENciLkwQy4KU7cJxISc=
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
Subject: [PATCH 5.4 00/94] 5.4.263-rc1 review
Date:   Tue,  5 Dec 2023 12:16:28 +0900
Message-ID: <20231205031522.815119918@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.263-rc1
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

This is the start of the stable review cycle for the 5.4.263 release.
There are 94 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.263-rc1

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Retry commands in CQE error recovery

Zheng Yongjun <zhengyongjun3@huawei.com>
    mmc: core: convert comma to semicolon

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Fix task clearing in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Warn of halt or task clear failure

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Increase recovery halt timeout

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: don't warn for disabling a non-existing frequency

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix system crash due to bad pointer access

Bart Van Assche <bvanassche@acm.org>
    scsi: qla2xxx: Use scsi_cmd_to_rq() instead of scsi_cmnd.request

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Introduce the scsi_cmd_to_rq() function

Bart Van Assche <bvanassche@acm.org>
    scsi: qla2xxx: Simplify the code for aborting SCSI commands

Mimi Zohar <zohar@linux.ibm.com>
    ima: detect changes to the backing overlay file

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    ovl: skip overlayfs superblocks at global sync

Amir Goldstein <amir73il@gmail.com>
    ima: annotate iint mutex to avoid lockdep false positive warnings

Helge Deller <deller@gmx.de>
    fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Linus Walleij <linus.walleij@linaro.org>
    mtd: cfi_cmdset_0001: Byte swap OTP info

Jean-Philippe Brucker <jean-philippe@linaro.org>
    mtd: cfi_cmdset_0001: Support the absence of protection registers

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix detection of DAT pages

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/mm: fix phys vs virt confusion in mark_kernel_pXd() functions family

Steve French <stfrench@microsoft.com>
    smb3: fix touch -h of symlink

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix async branch flags

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Adjust sample flags for VM-Exit

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Start TX queues after HW initialization succeeded

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Use pm_runtime_resume_and_get()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix races between ravb_tx_timeout_work() and net related ops

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: Disable FPE MMC interrupts

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

Max Nguyen <maxwell.nguyen@hp.com>
    Input: xpad - add HyperX Clutch Gladiate Support

Filipe Manana <fdmanana@suse.com>
    btrfs: make error messages more clear when getting a chunk map

Jann Horn <jannh@google.com>
    btrfs: send: ensure send_fd is writable

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one when checking chunk map includes logical address

Qu Wenruo <wqu@suse.com>
    btrfs: add dmesg output for first mount and last unmount of a filesystem

Timothy Pearson <tpearson@raptorengineering.com>
    powerpc: Don't clobber f0/vs0 during fp|altivec register save

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
    mmc: block: Do not lose cache flush during CQE error recovery

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Yang Yingliang <yangyingliang@huawei.com>
    firewire: core: fix possible memory leak in create_units()

Maria Yu <quic_aiquny@quicinc.com>
    pinctrl: avoid reload of p state in list iteration

Adrian Hunter <adrian.hunter@intel.com>
    perf inject: Fix GEN_ELF_TEXT_OFFSET for jit

Keith Busch <kbusch@kernel.org>
    io_uring: fix off-by one bvec index

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix wakeup after probe deferral

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix resource leaks on probe deferral

Ricardo Ribalda <ribalda@chromium.org>
    usb: dwc3: set the dma max_seg_size

Oliver Neukum <oneukum@suse.com>
    USB: dwc2: write HCINT with INTMASK applied

Lech Perczak <lech.perczak@gmail.com>
    USB: serial: option: don't claim interface 4 for ZTE MF290

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: fix FM101R-GL defines

Victor Fragoso <victorffs@hotmail.com>
    USB: serial: option: add Fibocom L7xx modules

Rand Deeb <rand.sec96@gmail.com>
    bcache: prevent potential division by zero error

Coly Li <colyli@suse.de>
    bcache: check return value from btree_node_alloc_replacement()

Mikulas Patocka <mpatocka@redhat.com>
    dm-delay: fix a race between delay_presuspend and delay_bio

Long Li <longli@microsoft.com>
    hv_netvsc: Mark VF as slave before exposing it to user-mode

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix race of register_netdevice_notifier and VF register

Asuna Yang <spriteovo@gmail.com>
    USB: serial: option: add Luat Air72*U series products

Jan Höppner <hoeppner@linux.ibm.com>
    s390/dasd: protect device queue against concurrent access

Coly Li <colyli@suse.de>
    bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA

Andrew Murray <andrew.murray@arm.com>
    KVM: arm64: limit PMU version to PMUv3 for ARMv8.1

Andrew Murray <andrew.murray@arm.com>
    arm64: cpufeature: Extract capped perfmon fields

Zhang Yi <yi.zhang@huawei.com>
    ext4: make sure allocate pending entry not fail

Baokun Li <libaokun1@huawei.com>
    ext4: fix slab-use-after-free in ext4_es_insert_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: using nofail preallocation in ext4_es_insert_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: using nofail preallocation in ext4_es_insert_delayed_block()

Baokun Li <libaokun1@huawei.com>
    ext4: using nofail preallocation in ext4_es_remove_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: use pre-allocated es in __es_remove_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: use pre-allocated es in __es_insert_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: factor out __es_alloc_extent() and __es_free_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: add a new helper to check if es must be kept

Huacai Chen <chenhuacai@loongson.cn>
    MIPS: KVM: Fix a build warning about variable set but not used

Christoph Hellwig <hch@lst.de>
    nvmet: nul-terminate the NQNs passed in the connect command

Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
    nvmet: remove unnecessary ctrl parameter

David Howells <dhowells@redhat.com>
    afs: Fix file locking on R/O volumes to operate in local mode

David Howells <dhowells@redhat.com>
    afs: Return ENOENT if no cell DNS record can be found

Samuel Holland <samuel.holland@sifive.com>
    net: axienet: Fix check for partial TX checksum

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: propagate the correct speed and duplex status

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: handle the corner-case during tx completion

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: handle corner-case during sfp hotplug

Stefano Stabellini <sstabellini@kernel.org>
    arm/xen: fix xen_vcpu_info allocation alignment

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kunwu Chan <chentao@kylinos.cn>
    ipv4: Correct/silence an endian warning in __ip_do_redirect

Charles Yi <be286@163.com>
    HID: fix HID device resource race between HID core and debugging support

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: core: store the unique system identifier in hid_device

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Chen Ni <nichen@iscas.ac.cn>
    ata: pata_isapnp: Add missing error check for devm_ioport_map()

Marek Vasut <marex@denx.de>
    drm/panel: simple: Fix Innolux G101ICE-L01 timings

Marek Vasut <marex@denx.de>
    drm/panel: simple: Fix Innolux G101ICE-L01 bus flags

David Howells <dhowells@redhat.com>
    afs: Make error on cell lookup failure consistent with OpenAFS

Nathan Chancellor <nathan@kernel.org>
    PCI: keystone: Drop __init from ks_pcie_add_pcie_{ep,port}()

Christopher Bednarz <christopher.n.bednarz@intel.com>
    RDMA/irdma: Prevent zero-length STAG registration

Saravana Kannan <saravanak@google.com>
    driver core: Release all resources during unbind before updating device links


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arm/xen/enlighten.c                          |   3 +-
 arch/arm64/include/asm/cpufeature.h               |  23 ++
 arch/arm64/include/asm/sysreg.h                   |   6 +
 arch/arm64/kvm/sys_regs.c                         |  10 +
 arch/mips/kvm/mmu.c                               |   3 +-
 arch/powerpc/kernel/fpu.S                         |  13 +
 arch/powerpc/kernel/vector.S                      |   2 +
 arch/s390/mm/page-states.c                        |  14 +-
 drivers/acpi/resource.c                           |   7 +
 drivers/ata/pata_isapnp.c                         |   3 +
 drivers/base/dd.c                                 |   4 +-
 drivers/cpufreq/imx6q-cpufreq.c                   |  32 +--
 drivers/firewire/core-device.c                    |  11 +-
 drivers/gpu/drm/panel/panel-simple.c              |  13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c       |  14 +-
 drivers/hid/hid-core.c                            |  16 +-
 drivers/hid/hid-debug.c                           |   3 +
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c          |   6 +
 drivers/infiniband/hw/i40iw/i40iw_type.h          |   2 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c         |  10 +-
 drivers/input/joystick/xpad.c                     |   2 +
 drivers/md/bcache/btree.c                         |   6 +-
 drivers/md/bcache/sysfs.c                         |   2 +-
 drivers/md/dm-delay.c                             |  17 +-
 drivers/md/dm-verity-fec.c                        |   3 +-
 drivers/md/dm-verity-target.c                     |   4 +-
 drivers/md/dm-verity.h                            |   6 -
 drivers/mmc/core/block.c                          |   2 +
 drivers/mmc/core/core.c                           |  15 +-
 drivers/mmc/host/cqhci.c                          |  44 ++--
 drivers/mmc/host/sdhci-sprd.c                     |  25 ++
 drivers/mtd/chips/cfi_cmdset_0001.c               |  29 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c          |  14 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c      |  11 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |  14 +-
 drivers/net/ethernet/renesas/ravb_main.c          |  20 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c    |   4 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |   2 +-
 drivers/net/hyperv/netvsc_drv.c                   |  41 ++-
 drivers/net/usb/ax88179_178a.c                    |   4 +-
 drivers/nvme/target/core.c                        |  21 +-
 drivers/nvme/target/fabrics-cmd.c                 |  15 +-
 drivers/nvme/target/nvmet.h                       |   5 +-
 drivers/pci/controller/dwc/pci-keystone.c         |   8 +-
 drivers/pinctrl/core.c                            |   6 +-
 drivers/s390/block/dasd.c                         |  24 +-
 drivers/scsi/qla2xxx/qla_def.h                    |   3 -
 drivers/scsi/qla2xxx/qla_isr.c                    |   5 -
 drivers/scsi/qla2xxx/qla_os.c                     |  39 +--
 drivers/usb/dwc2/hcd_intr.c                       |  15 +-
 drivers/usb/dwc3/core.c                           |   2 +
 drivers/usb/dwc3/dwc3-qcom.c                      |  17 +-
 drivers/usb/serial/option.c                       |  11 +-
 drivers/video/fbdev/sticore.h                     |   2 +-
 fs/afs/dynroot.c                                  |   4 +-
 fs/afs/super.c                                    |   2 +
 fs/afs/vl_rotate.c                                |  10 +
 fs/btrfs/disk-io.c                                |   1 +
 fs/btrfs/send.c                                   |   2 +-
 fs/btrfs/super.c                                  |   5 +-
 fs/btrfs/volumes.c                                |   9 +-
 fs/cifs/cifsfs.c                                  |   1 +
 fs/ext4/extents_status.c                          | 306 +++++++++++++++-------
 fs/io_uring.c                                     |   2 +-
 fs/overlayfs/super.c                              |   5 +-
 fs/sync.c                                         |   3 +-
 include/linux/fs.h                                |   2 +
 include/linux/hid.h                               |   5 +
 include/scsi/scsi_cmnd.h                          |   6 +
 net/ipv4/igmp.c                                   |   6 +-
 net/ipv4/route.c                                  |   2 +-
 security/integrity/iint.c                         |  48 +++-
 security/integrity/ima/ima_api.c                  |   5 +
 security/integrity/ima/ima_main.c                 |  16 +-
 security/integrity/integrity.h                    |   2 +
 sound/pci/hda/hda_intel.c                         |   2 +
 sound/pci/hda/patch_realtek.c                     |  12 +
 tools/perf/util/genelf.h                          |   4 +-
 tools/perf/util/intel-pt.c                        |  13 +-
 80 files changed, 790 insertions(+), 320 deletions(-)


