Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E986D7FF575
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjK3Q2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjK3Q2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:28:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDBDD40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:28:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BC8C433C7;
        Thu, 30 Nov 2023 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701361739;
        bh=isDNpIiPRav4Af9mDebfQF2EWGCOkfu93BdgmhPjW8k=;
        h=From:To:Cc:Subject:Date:From;
        b=tzunGd5f9SNvF5GT8QkCDbylQbGex16AFWET/iQF/uv7wee8xJNkg01RWLud9E+ap
         0Pl58H0cI1xaXSCBkiNx0efznGPJVYUU6XoiRZ7glfWgMWJZwVVKeE/rb4rc6Spfyz
         FKt+dwejT3jClx+7Naa9/vr7avowtIc630lPFzc8=
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
Subject: [PATCH 6.1 00/82] 6.1.65-rc1 review
Date:   Thu, 30 Nov 2023 16:21:31 +0000
Message-ID: <20231130162135.977485944@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.65-rc1
X-KernelTest-Deadline: 2023-12-02T16:21+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.65 release.
There are 82 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.65-rc1

Keith Busch <kbusch@kernel.org>
    io_uring: fix off-by one bvec index

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix wakeup after probe deferral

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix software node leak on probe errors

Ricardo Ribalda <ribalda@chromium.org>
    usb: dwc3: set the dma max_seg_size

Alexander Stein <alexander.stein@ew.tq-group.com>
    usb: dwc3: Fix default mode initialization

Oliver Neukum <oneukum@suse.com>
    USB: dwc2: write HCINT with INTMASK applied

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: tcpm: Skip hard reset when in error recovery

Lech Perczak <lech.perczak@gmail.com>
    USB: serial: option: don't claim interface 4 for ZTE MF290

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: fix FM101R-GL defines

Victor Fragoso <victorffs@hotmail.com>
    USB: serial: option: add Fibocom L7xx modules

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: Fix deadlock issue during using NCM gadget

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

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: fix race of netvsc and VF register_netdevice

Asuna Yang <spriteovo@gmail.com>
    USB: serial: option: add Luat Air72*U series products

Jan Höppner <hoeppner@linux.ibm.com>
    s390/dasd: protect device queue against concurrent access

Charles Mirabile <cmirabil@redhat.com>
    io_uring/fs: consider link->flags when getting path for LINKAT

Mingzhe Zou <mingzhe.zou@easystack.cn>
    bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race

Song Liu <song@kernel.org>
    md: fix bi_status reporting in md_end_clone_io

Coly Li <colyli@suse.de>
    bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()

Keith Busch <kbusch@kernel.org>
    swiotlb-xen: provide the "max_mapping_size" method

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    arm64: dts: imx8mn-var-som: add 20ms delay to ethernet regulator enable

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix checksum mismatches in the duplicate reply cache

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()

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

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix genpd cleanup

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix V4L2 async notifier error path

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: qcom: Initialise V4L2 async notifier later

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    media: camss: Convert to platform remove callback returning void

Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
    media: camss: Split power domain management

Huacai Chen <chenhuacai@kernel.org>
    MIPS: KVM: Fix a build warning about variable set but not used

Shyam Prasad N <sprasad@microsoft.com>
    cifs: fix leak of iface for primary channel

Shyam Prasad N <sprasad@microsoft.com>
    cifs: account for primary channel in the interface list

Shyam Prasad N <sprasad@microsoft.com>
    cifs: distribute channels across interfaces based on speed

Shyam Prasad N <sprasad@microsoft.com>
    cifs: print last update time for interface list

Steve French <stfrench@microsoft.com>
    smb3: allow dumping session and tcon id to improve stats analysis and debugging

Steve French <stfrench@microsoft.com>
    cifs: minor cleanup of some headers

Peter Zijlstra <peterz@infradead.org>
    lockdep: Fix block chain corruption

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix ACPI platform device leak

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix resource leaks on probe deferral

Christoph Hellwig <hch@lst.de>
    nvmet: nul-terminate the NQNs passed in the connect command

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix adding unsupported cloud filters

Jan Sokolowski <jan.sokolowski@intel.com>
    i40e: use ERR_PTR error print in i40e messages

Will Deacon <will@kernel.org>
    arm64: mm: Fix "rodata=on" when CONFIG_RODATA_FULL_DEFAULT_ENABLED=y

Zhenhua Huang <quic_zhenhuah@quicinc.com>
    mm,kfence: decouple kfence from page granularity mapping judgement

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

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF

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

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Andrzej Hajda <andrzej.hajda@intel.com>
    drm/i915: do not clean GT table on error path

Chen Ni <nichen@iscas.ac.cn>
    ata: pata_isapnp: Add missing error check for devm_ioport_map()

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Fix memory leak during interface down

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


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/xen/enlighten.c                           |   3 +-
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   1 +
 arch/arm64/include/asm/kfence.h                    |  10 +
 arch/arm64/include/asm/setup.h                     |  17 +-
 arch/arm64/mm/mmu.c                                |  61 ++++
 arch/arm64/mm/pageattr.c                           |  12 +-
 arch/mips/kvm/mmu.c                                |   3 +-
 drivers/acpi/resource.c                            |   7 +
 drivers/ata/pata_isapnp.c                          |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.c                 |  11 -
 drivers/gpu/drm/i915/i915_driver.c                 |   4 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   7 +
 drivers/gpu/drm/panel/panel-simple.c               |  13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  14 +-
 drivers/hid/hid-core.c                             |  12 +-
 drivers/hid/hid-debug.c                            |   3 +
 drivers/md/bcache/btree.c                          |   4 +-
 drivers/md/bcache/sysfs.c                          |   2 +-
 drivers/md/bcache/writeback.c                      |  22 +-
 drivers/md/dm-delay.c                              |  17 +-
 drivers/md/md.c                                    |   3 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |  20 +-
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |  20 +-
 drivers/media/platform/qcom/camss/camss.c          |  86 +++---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  14 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  11 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  40 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 299 ++++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  42 +--
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  20 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  66 +++--
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/wireguard/device.c                     |   4 +-
 drivers/net/wireguard/receive.c                    |  12 +-
 drivers/net/wireguard/send.c                       |   3 +-
 drivers/nvme/target/fabrics-cmd.c                  |   4 +
 drivers/s390/block/dasd.c                          |  24 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |   3 +
 drivers/usb/dwc2/hcd_intr.c                        |  15 +-
 drivers/usb/dwc3/core.c                            |   2 +
 drivers/usb/dwc3/drd.c                             |   2 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  65 +++--
 drivers/usb/serial/option.c                        |  11 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   9 +
 drivers/xen/swiotlb-xen.c                          |   1 +
 fs/afs/dynroot.c                                   |   4 +-
 fs/afs/internal.h                                  |   1 +
 fs/afs/server_list.c                               |   2 +-
 fs/afs/super.c                                     |   2 +
 fs/afs/vl_rotate.c                                 |  10 +
 fs/ext4/extents_status.c                           | 306 +++++++++++++++------
 fs/nfsd/cache.h                                    |   3 +-
 fs/nfsd/nfscache.c                                 |  65 +++--
 fs/nfsd/nfssvc.c                                   |  15 +-
 fs/smb/client/cifs_debug.c                         |  22 +-
 fs/smb/client/cifs_ioctl.h                         |   8 +-
 fs/smb/client/cifsfs.h                             |   4 +-
 fs/smb/client/cifsglob.h                           |   9 +-
 fs/smb/client/connect.c                            |   6 +
 fs/smb/client/ioctl.c                              |  25 ++
 fs/smb/client/sess.c                               | 112 +++++++-
 fs/smb/client/smb2ops.c                            |   6 +
 include/linux/hid.h                                |   3 +
 io_uring/fs.c                                      |   2 +-
 io_uring/rsrc.c                                    |   2 +-
 kernel/locking/lockdep.c                           |   3 +-
 mm/kfence/core.c                                   |   4 +
 net/ipv4/route.c                                   |   2 +-
 net/smc/af_smc.c                                   |   8 +-
 76 files changed, 1162 insertions(+), 518 deletions(-)


