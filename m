Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952C280470D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbjLEDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjLEDeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:34:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1EAD3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:34:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AF5C433C8;
        Tue,  5 Dec 2023 03:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701747259;
        bh=vVVH/VGrm9XY0zh7JsrKNhHpvqkJjA4InNCCBNls2Fw=;
        h=From:To:Cc:Subject:Date:From;
        b=1VOkcMfL2sU3MC8oqwQvJ7vGuGxJjYbLlthf2g0RwCLdI5XNcmrw4kjpiwtoqV7qH
         h8+JzWK7GK9SIeZfKlXbfoGhszmGkv3IShzeFk7V9Zod9i4L7fy7vuVCTHXPTbsrna
         dmxQQNBGVb6kxMOrIUD4VPMZFFAUqM/FS2v+3UbA=
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
Subject: [PATCH 5.10 000/135] 5.10.203-rc1 review
Date:   Tue,  5 Dec 2023 12:15:21 +0900
Message-ID: <20231205031530.557782248@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.203-rc1
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

This is the start of the stable review cycle for the 5.10.203 release.
There are 135 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.203-rc1

Saravana Kannan <saravanak@google.com>
    driver core: Release all resources during unbind before updating device links

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix deadlock on RTL8125 in jumbo mtu mode

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ASPM in case of tx timeout

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Heiner Kallweit <hkallweit1@gmail.com>
    mmc: core: add helpers mmc_regulator_enable/disable_vqmmc

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

Steve French <stfrench@microsoft.com>
    smb3: fix caching of ctime on setxattr

Jeff Layton <jlayton@kernel.org>
    fs: add ctime accessors infrastructure

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: don't use ATRM for external devices

Rajat Jain <rajatja@google.com>
    driver core: Move the "removable" attribute from USB to core

Amir Goldstein <amir73il@gmail.com>
    ima: annotate iint mutex to avoid lockdep false positive warnings

Helge Deller <deller@gmx.de>
    fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Siddharth Vadapalli <s-vadapalli@ti.com>
    misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Kishon Vijay Abraham I <kishon@ti.com>
    misc: pci_endpoint_test: Add deviceID for AM64 and J7200

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix detection of DAT pages

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/mm: fix phys vs virt confusion in mark_kernel_pXd() functions family

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

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: prevent potential deadlock in rtl8169_close

Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    Revert "workqueue: remove unused cancel_work()"

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: Disable FPE MMC interrupts

Willem de Bruijn <willemb@google.com>
    selftests/net: mptcp: fix uninitialized variable warnings

Willem de Bruijn <willemb@google.com>
    selftests/net: ipsec: fix constant out of range

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
    mmc: block: Do not lose cache flush during CQE error recovery

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

Ricardo Ribalda <ribalda@chromium.org>
    usb: dwc3: set the dma max_seg_size

Alexander Stein <alexander.stein@ew.tq-group.com>
    usb: dwc3: Fix default mode initialization

Oliver Neukum <oneukum@suse.com>
    USB: dwc2: write HCINT with INTMASK applied

Lech Perczak <lech.perczak@gmail.com>
    USB: serial: option: don't claim interface 4 for ZTE MF290

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: fix FM101R-GL defines

Victor Fragoso <victorffs@hotmail.com>
    USB: serial: option: add Fibocom L7xx modules

Mingzhe Zou <mingzhe.zou@easystack.cn>
    bcache: fixup lock c->root error

Mingzhe Zou <mingzhe.zou@easystack.cn>
    bcache: fixup init dirty data errors

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

Mingzhe Zou <mingzhe.zou@easystack.cn>
    bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race

Coly Li <colyli@suse.de>
    bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()

Keith Busch <kbusch@kernel.org>
    swiotlb-xen: provide the "max_mapping_size" method

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: simple-card: fixup asoc_simple_probe() error handling

Al Viro <viro@zeniv.linux.org.uk>
    nfsd: lock_rename() needs both directories to live on the same fs

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

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ccs: Correctly initialise try compose rectangle

Peter Zijlstra <peterz@infradead.org>
    lockdep: Fix block chain corruption

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix ACPI platform device leak

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix resource leaks on probe deferral

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

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: avoid data corruption caused by decline

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

Eric Dumazet <edumazet@google.com>
    wireguard: use DEV_STATS_INC()

Marek Vasut <marex@denx.de>
    drm/panel: simple: Fix Innolux G101ICE-L01 timings

Marek Vasut <marex@denx.de>
    drm/panel: simple: Fix Innolux G101ICE-L01 bus flags

Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
    drm/panel: auo,b101uan08.3: Fine tune the panel power sequence

Shuijing Li <shuijing.li@mediatek.com>
    drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence

David Howells <dhowells@redhat.com>
    afs: Make error on cell lookup failure consistent with OpenAFS

David Howells <dhowells@redhat.com>
    afs: Fix afs_server_list to be cleaned up with RCU

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Harald Freudenberger <freude@linux.ibm.com>
    s390/ap: fix AP bus crash on early config change callback invocation

Neil Armstrong <narmstrong@baylibre.com>
    tty: serial: meson: retrieve port FIFO size from DT

Takashi Iwai <tiwai@suse.de>
    media: imon: fix access to invalid resource for the second interface

Axel Lin <axel.lin@ingics.com>
    i2c: sun6i-p2wi: Prevent potential division by zero

Qu Huang <qu.huang@linux.dev>
    drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Patrick Thompson <ptf@google.com>
    net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Nathan Chancellor <nathan@kernel.org>
    PCI: keystone: Drop __init from ks_pcie_add_pcie_{ep,port}()

Christopher Bednarz <christopher.n.bednarz@intel.com>
    RDMA/irdma: Prevent zero-length STAG registration


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-bus-usb            |  11 -
 Documentation/ABI/testing/sysfs-devices-removable  |  17 ++
 Makefile                                           |   4 +-
 arch/arm/xen/enlighten.c                           |   3 +-
 arch/mips/kvm/mmu.c                                |   3 +-
 arch/parisc/include/uapi/asm/errno.h               |   2 -
 arch/powerpc/kernel/fpu.S                          |  13 +
 arch/powerpc/kernel/vector.S                       |   2 +
 arch/s390/mm/page-states.c                         |  14 +-
 drivers/acpi/resource.c                            |   7 +
 drivers/ata/pata_isapnp.c                          |   3 +
 drivers/base/core.c                                |  28 ++
 drivers/base/dd.c                                  |   4 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  32 ++-
 drivers/firewire/core-device.c                     |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   6 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   7 +
 drivers/gpu/drm/panel/panel-simple.c               |  13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  14 +-
 drivers/hid/hid-core.c                             |  16 +-
 drivers/hid/hid-debug.c                            |   3 +
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |   5 +
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |   6 +
 drivers/infiniband/hw/i40iw/i40iw_type.h           |   2 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |  10 +-
 drivers/input/joystick/xpad.c                      |   2 +
 drivers/iommu/intel/iommu.c                        |   2 +-
 drivers/md/bcache/btree.c                          |   6 +-
 drivers/md/bcache/sysfs.c                          |   2 +-
 drivers/md/bcache/writeback.c                      |  22 +-
 drivers/md/dm-delay.c                              |  17 +-
 drivers/md/dm-verity-fec.c                         |   3 +-
 drivers/md/dm-verity-target.c                      |   4 +-
 drivers/md/dm-verity.h                             |   6 -
 drivers/media/i2c/smiapp/smiapp-core.c             |   2 +-
 drivers/media/rc/imon.c                            |   6 +
 drivers/misc/pci_endpoint_test.c                   |  12 +
 drivers/mmc/core/block.c                           |   2 +
 drivers/mmc/core/core.c                            |  15 +-
 drivers/mmc/core/regulator.c                       |  41 +++
 drivers/mmc/host/cqhci.c                           |  44 +--
 drivers/mmc/host/sdhci-sprd.c                      |  25 ++
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  14 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  11 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  14 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   8 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   7 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  23 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  20 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |   4 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  66 +++--
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/wireguard/device.c                     |   4 +-
 drivers/net/wireguard/receive.c                    |  12 +-
 drivers/net/wireguard/send.c                       |   3 +-
 drivers/nvme/target/core.c                         |  21 +-
 drivers/nvme/target/fabrics-cmd.c                  |  15 +-
 drivers/nvme/target/nvmet.h                        |   5 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   8 +-
 drivers/pinctrl/core.c                             |   6 +-
 drivers/s390/block/dasd.c                          |  24 +-
 drivers/s390/crypto/ap_bus.c                       |   4 +
 drivers/scsi/qla2xxx/qla_os.c                      |  14 +-
 drivers/tty/serial/meson_uart.c                    |   2 +
 drivers/usb/core/config.c                          |  85 +++---
 drivers/usb/core/hub.c                             |  13 +-
 drivers/usb/core/sysfs.c                           |  24 --
 drivers/usb/dwc2/hcd_intr.c                        |  15 +-
 drivers/usb/dwc3/core.c                            |   2 +
 drivers/usb/dwc3/drd.c                             |   2 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  52 +++-
 drivers/usb/serial/option.c                        |  11 +-
 drivers/video/fbdev/sticore.h                      |   2 +-
 drivers/xen/swiotlb-xen.c                          |   1 +
 fs/afs/dynroot.c                                   |   4 +-
 fs/afs/internal.h                                  |   1 +
 fs/afs/server_list.c                               |   2 +-
 fs/afs/super.c                                     |   2 +
 fs/afs/vl_rotate.c                                 |  10 +
 fs/btrfs/disk-io.c                                 |   1 +
 fs/btrfs/ref-verify.c                              |   2 +
 fs/btrfs/send.c                                    |   2 +-
 fs/btrfs/super.c                                   |   5 +-
 fs/btrfs/volumes.c                                 |   9 +-
 fs/cifs/cifsfs.c                                   |   1 +
 fs/cifs/xattr.c                                    |   5 +-
 fs/ext4/extents_status.c                           | 306 +++++++++++++++------
 fs/inode.c                                         |  16 ++
 fs/nfsd/vfs.c                                      |  12 +-
 include/linux/device.h                             |  37 +++
 include/linux/fs.h                                 |  45 ++-
 include/linux/hid.h                                |   5 +
 include/linux/mmc/host.h                           |   3 +
 include/linux/platform_data/x86/soc.h              |  65 +++++
 include/linux/usb.h                                |   7 -
 include/linux/workqueue.h                          |   1 +
 include/scsi/scsi_cmnd.h                           |   6 +
 io_uring/io_uring.c                                |   2 +-
 kernel/locking/lockdep.c                           |   3 +-
 kernel/workqueue.c                                 |   9 +
 lib/errname.c                                      |   6 -
 net/ipv4/igmp.c                                    |   6 +-
 net/ipv4/route.c                                   |   2 +-
 net/smc/af_smc.c                                   |   8 +-
 security/integrity/iint.c                          |  48 +++-
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_realtek.c                      |  12 +
 sound/soc/generic/simple-card.c                    |   6 +-
 sound/soc/intel/common/soc-intel-quirks.h          |  51 +---
 sound/soc/sof/sof-pci-dev.c                        |  62 ++++-
 tools/arch/parisc/include/uapi/asm/errno.h         |   2 -
 tools/perf/util/genelf.h                           |   4 +-
 tools/perf/util/intel-pt.c                         |  13 +-
 tools/testing/selftests/net/ipsec.c                |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  11 +-
 118 files changed, 1232 insertions(+), 518 deletions(-)


