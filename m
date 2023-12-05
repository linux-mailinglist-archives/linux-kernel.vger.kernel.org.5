Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4373580469F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjLED3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjLED3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:29:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200ACE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:29:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E74C433C8;
        Tue,  5 Dec 2023 03:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701746984;
        bh=6N5csQBpNr6fblOwOlvgrpsnm+aOlKv4OiGg6wJyhAU=;
        h=From:To:Cc:Subject:Date:From;
        b=SiLyLcdFNRorJDYQrF8gS9tEFuMQ6aUXl2HvXN6h8knGFQRv9ulk/Ko+3RHAEf/7c
         w7CUXHTdkTFuvUo5BMZsNhU10BIcWsL3aRWEd42qhDIEHhfWHPWpYVyiifsjUsu7Up
         B9Rrij4/80LUTU6nYCRGFcIp4MUE54hMEMVUu6ss=
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
Subject: [PATCH 6.1 000/107] 6.1.66-rc1 review
Date:   Tue,  5 Dec 2023 12:15:35 +0900
Message-ID: <20231205031531.426872356@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.66-rc1
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

This is the start of the stable review cycle for the 6.1.66 release.
There are 107 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.66-rc1

Koichiro Den <den@valinux.co.jp>
    x86/apic/msi: Fix misconfigured non-maskable MSI quirk

Juergen Gross <jgross@suse.com>
    x86/xen: fix percpu vcpu_info allocation

Juergen Gross <jgross@suse.com>
    xen: simplify evtchn_do_upcall() call maze

David Woodhouse <dwmw@amazon.co.uk>
    xen: Allow platform PCI interrupt to be shared

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix deadlock on RTL8125 in jumbo mtu mode

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ASPM in case of tx timeout

Ilya Bakoulin <ilya.bakoulin@amd.com>
    drm/amd/display: Fix MPCC 1DLUT programming

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Fix the delta clamping for shaper LUT

Melissa Wen <mwen@igalia.com>
    drm/amd/display: clean code-style issues in dcn30_set_mpc_shaper_3dlut

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Expand kernel doc for DC

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Heiner Kallweit <hkallweit1@gmail.com>
    mmc: core: add helpers mmc_regulator_enable/disable_vqmmc

Dinghao Liu <dinghao.liu@zju.edu.cn>
    drm/amd/pm: fix a memleak in aldebaran_tables_init

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Make context clearing consistent with context mapping

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Disable PCI ATS in legacy passthrough mode

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Add device_block_translation() helper

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Allocate pasid table in device probe path

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Omit devTLB invalidation requests when TES=0

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: don't warn for disabling a non-existing frequency

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Guard against invalid RPTR/WPTR being set

JinZe.Xu <JinZe.Xu@amd.com>
    drm/amd/display: Restore rptr/wptr for DMCUB as workaround

Mark Hasemeyer <markhas@chromium.org>
    spi: Fix null dereference on suspend

Alexandre Ghiti <alexghiti@rivosinc.com>
    drivers: perf: Check find_first_bit() return value

Helge Deller <deller@gmx.de>
    fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom-ep: Add dedicated callback for writing to DBI2 registers

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device

Lukas Wunner <lukas@wunner.de>
    PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card

Haitao Shan <hshan@google.com>
    KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Keep reverse order of operations in ravb_remove()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Stop DMA in case of failures on ravb_open()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Start TX queues after HW initialization succeeded

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Make write access to CXR35 first before accessing other EMAC registers

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Use pm_runtime_resume_and_get()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Check return value of reset_control_deassert()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix races between ravb_tx_timeout_work() and net related ops

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: prevent potential deadlock in rtl8169_close

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Restore TC ingress police rules when interface is up

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Install TC filter rules in hardware based on priority

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: Disable FPE MMC interrupts

Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
    octeontx2-af: Fix possible buffer overflow

Willem de Bruijn <willemb@google.com>
    selftests/net: mptcp: fix uninitialized variable warnings

Willem de Bruijn <willemb@google.com>
    selftests/net: unix: fix unused variable compiler warning

Willem de Bruijn <willemb@google.com>
    selftests/net: fix a char signedness issue

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

Johan Hovold <johan+linaro@kernel.org>
    USB: xhci-plat: fix legacy PHY double init

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix CQM for non-range use

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: add missing support for rs485 devicetree properties

Hui Wang <hui.wang@canonical.com>
    serial: sc16is7xx: Put IOControl register into regmap_volatile

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    auxdisplay: hd44780: move cursor home after clear display command

Max Nguyen <maxwell.nguyen@hp.com>
    Input: xpad - add HyperX Clutch Gladiate Support

David Sterba <dsterba@suse.com>
    btrfs: fix 64bit compat send ioctl arguments not initializing version member

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
    parisc: Mark altinstructions read-only and 32-bit aligned

Helge Deller <deller@gmx.de>
    parisc: Ensure 32-bit alignment on parisc unwind section

Helge Deller <deller@gmx.de>
    parisc: Mark jump_table naturally aligned

Helge Deller <deller@gmx.de>
    parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes

Helge Deller <deller@gmx.de>
    parisc: Mark lock_aligned variables 16-byte aligned on SMP

Helge Deller <deller@gmx.de>
    parisc: Use natural CPU alignment for bug_table

Helge Deller <deller@gmx.de>
    parisc: Mark ex_table entries 32-bit aligned in uaccess.h

Helge Deller <deller@gmx.de>
    parisc: Mark ex_table entries 32-bit aligned in assembly.h

Timothy Pearson <tpearson@raptorengineering.com>
    powerpc: Don't clobber f0/vs0 during fp|altivec register save

Nicholas Piggin <npiggin@gmail.com>
    KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers

Abdul Halim, Mohd Syazwan <mohd.syazwan.abdul.halim@intel.com>
    iommu/vt-d: Add MTL to quirk list to skip TE disabling

Markus Weippert <markus@gekmihesg.de>
    bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Christian König <christian.koenig@amd.com>
    dma-buf: fix check in dma_resv_add_fence

Gautham R. Shenoy <gautham.shenoy@amd.com>
    cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()

Lukasz Luba <lukasz.luba@arm.com>
    powercap: DTPM: Fix unneeded conversions to micro-Watts

Ewan D. Milne <emilne@redhat.com>
    nvme: check for valid nvme_identify_ns() before using it

Wu Bo <bo.wu@vivo.com>
    dm verity: don't perform FEC for failed readahead IO

Wu Bo <bo.wu@vivo.com>
    dm verity: initialize fec io before freeing it

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix ABM disablement

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Update min Z8 residency time to 2100 for DCN314

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: Use DRAM speed from validation for dummy p-state

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Remove min_dst_y_next_start check for Z8

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: Include udelay when waiting for INBOX0 ACK

Alex Sierra <alex.sierra@amd.com>
    drm/amdgpu: Force order between a read and write to the same address

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Enable PCIe PME from D3

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Fix system start for ATA devices

Damien Le Moal <dlemoal@kernel.org>
    scsi: Change SCSI device boolean fields to single bit flags

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

Kornel Dulęba <korneld@chromium.org>
    mmc: sdhci-pci-gli: Disable LPM during initialization

Yang Yingliang <yangyingliang@huawei.com>
    firewire: core: fix possible memory leak in create_units()

Maria Yu <quic_aiquny@quicinc.com>
    pinctrl: avoid reload of p state in list iteration

Paulo Alcantara <pc@manguebit.com>
    smb: client: report correct st_size for SMB and NFS symlinks

David Howells <dhowells@redhat.com>
    cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved

David Howells <dhowells@redhat.com>
    cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/xen/enlighten.c                           |   2 +-
 arch/parisc/include/asm/alternative.h              |   9 +-
 arch/parisc/include/asm/assembly.h                 |   1 +
 arch/parisc/include/asm/bug.h                      |  30 +-
 arch/parisc/include/asm/jump_label.h               |   8 +-
 arch/parisc/include/asm/ldcw.h                     |   2 +-
 arch/parisc/include/asm/uaccess.h                  |   1 +
 arch/parisc/include/uapi/asm/errno.h               |   2 -
 arch/parisc/kernel/vmlinux.lds.S                   |   1 +
 arch/powerpc/kernel/fpu.S                          |  13 +
 arch/powerpc/kernel/process.c                      |   6 +-
 arch/powerpc/kernel/vector.S                       |   2 +
 arch/powerpc/platforms/pseries/iommu.c             |   8 +-
 arch/s390/mm/page-states.c                         |   6 +
 arch/x86/entry/common.c                            |   2 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/kernel/apic/msi.c                         |   8 +-
 arch/x86/kvm/lapic.c                               |   4 +
 arch/x86/kvm/vmx/vmx.c                             |   4 +-
 arch/x86/xen/enlighten.c                           |   8 +-
 arch/x86/xen/enlighten_hvm.c                       |   2 +-
 arch/x86/xen/xen-ops.h                             |   2 +-
 drivers/ata/libata-scsi.c                          |   9 +-
 drivers/auxdisplay/hd44780_common.c                |  10 +-
 drivers/cpufreq/amd-pstate.c                       |   4 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  32 +-
 drivers/dma-buf/dma-resv.c                         |   2 +-
 drivers/firewire/core-device.c                     |  11 +-
 drivers/firewire/sbp2.c                            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   8 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  11 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |  19 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   6 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  37 +-
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   8 +-
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h   |   7 +
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  15 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   3 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |  25 ++
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |   9 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |   7 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |  14 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |   5 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |   5 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |   5 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  30 ++
 .../drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h |   2 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   5 +-
 drivers/input/joystick/xpad.c                      |   2 +
 drivers/iommu/intel/dmar.c                         |  18 +
 drivers/iommu/intel/iommu.c                        |  71 +++-
 drivers/md/bcache/btree.c                          |   2 +-
 drivers/md/dm-verity-fec.c                         |   3 +-
 drivers/md/dm-verity-target.c                      |   7 +-
 drivers/md/dm-verity.h                             |   6 -
 drivers/mmc/core/block.c                           |   2 +
 drivers/mmc/core/core.c                            |   9 +-
 drivers/mmc/core/regulator.c                       |  41 ++
 drivers/mmc/host/cqhci-core.c                      |  44 +--
 drivers/mmc/host/sdhci-pci-gli.c                   |  54 +--
 drivers/mmc/host/sdhci-sprd.c                      |  25 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   8 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   9 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   9 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_switch.c |   6 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  13 +-
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   1 -
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   9 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 440 +++++++++++++++------
 drivers/net/ethernet/realtek/r8169_main.c          |  23 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  69 ++--
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |   4 +
 drivers/nvme/host/core.c                           |   9 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  17 +
 drivers/pci/quirks.c                               |  12 +
 drivers/perf/riscv_pmu_sbi.c                       |   5 +
 drivers/pinctrl/core.c                             |   6 +-
 drivers/powercap/dtpm_cpu.c                        |   6 +-
 drivers/powercap/dtpm_devfreq.c                    |  11 +-
 drivers/scsi/sd.c                                  |   9 +-
 drivers/spi/spi.c                                  |  56 ++-
 drivers/tty/serial/sc16is7xx.c                     |   5 +
 drivers/usb/core/config.c                          |  85 ++--
 drivers/usb/host/xhci-plat.c                       |  29 +-
 drivers/video/fbdev/sticore.h                      |   2 +-
 drivers/xen/events/events_base.c                   |  22 +-
 drivers/xen/platform-pci.c                         |   5 +-
 fs/btrfs/disk-io.c                                 |   1 +
 fs/btrfs/ioctl.c                                   |   1 +
 fs/btrfs/ref-verify.c                              |   2 +
 fs/btrfs/send.c                                    |   2 +-
 fs/btrfs/super.c                                   |   5 +-
 fs/btrfs/volumes.c                                 |   9 +-
 fs/smb/client/inode.c                              |   2 +
 fs/smb/client/smb2ops.c                            |  13 +-
 include/linux/dma-fence.h                          |  15 +
 include/linux/irq.h                                |  24 +-
 include/linux/mmc/host.h                           |   3 +
 include/linux/spi/spi.h                            |   1 +
 include/scsi/scsi_device.h                         |  12 +-
 include/uapi/linux/stddef.h                        |   2 +-
 include/xen/events.h                               |   3 +-
 kernel/irq/debugfs.c                               |   1 -
 kernel/irq/msi.c                                   |  12 +-
 lib/errname.c                                      |   6 -
 net/ipv4/igmp.c                                    |   6 +-
 net/wireless/core.h                                |   1 +
 net/wireless/nl80211.c                             |  50 ++-
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_realtek.c                      |  12 +
 tools/arch/parisc/include/uapi/asm/errno.h         |   2 -
 tools/testing/selftests/net/af_unix/diag_uid.c     |   1 -
 tools/testing/selftests/net/cmsg_sender.c          |   2 +-
 tools/testing/selftests/net/ipsec.c                |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  11 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |  11 +-
 134 files changed, 1282 insertions(+), 571 deletions(-)


