Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F998045C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjLEDVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjLEDVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:21:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D63D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:21:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68925C433C7;
        Tue,  5 Dec 2023 03:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701746466;
        bh=wwcrCvfN9n7gsAtiOozjpmb/pH/mnqP2lIfrbbzLOrM=;
        h=From:To:Cc:Subject:Date:From;
        b=Y4RYTq2D+dcWGCTmV0d7laHBLWxII7f+3azHOKVThiB7TgxkoHECpzm0gojRojuqz
         TU0nsq4ckL+EXteJr2OJ6AnR9Gysmp8Z5KbKY6ZmQIh0PsabsiSPYwvgqW131TrzrB
         MiAyFrkmAmNwVYIKD9diNBu2A8bvzioyRHf58HcU=
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
Subject: [PATCH 6.6 000/134] 6.6.5-rc1 review
Date:   Tue,  5 Dec 2023 12:14:32 +0900
Message-ID: <20231205031535.163661217@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.5-rc1
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

This is the start of the stable review cycle for the 6.6.5 release.
There are 134 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.5-rc1

Sean Christopherson <seanjc@google.com>
    vfio: Drop vfio_file_iommu_group() stub to fudge around a KVM wart

Juergen Gross <jgross@suse.com>
    x86/xen: fix percpu vcpu_info allocation

Brett Creeley <brett.creeley@amd.com>
    vfio/pds: Fix possible sleep while in atomic context

Brett Creeley <brett.creeley@amd.com>
    vfio/pds: Fix mutex lock->magic != lock warning

Ilya Bakoulin <ilya.bakoulin@amd.com>
    drm/amd/display: Fix MPCC 1DLUT programming

Camille Cho <camille.cho@amd.com>
    drm/amd/display: Simplify brightness initialization

Swapnil Patel <swapnil.patel@amd.com>
    drm/amd/display: Reduce default backlight min from 5 nits to 1 nits

Sherry Wang <yao.wang1@amd.com>
    drm/amd/display: refactor ILR to make it work

Daniel Mentz <danielmentz@google.com>
    iommu: Fix printk arg in of_iommu_get_resv_regions()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    drm/amd/pm: fix a memleak in aldebaran_tables_init

Ayush Jain <ayush.jain3@amd.com>
    cpufreq/amd-pstate: Only print supported EPP values for performance governor

Wyes Karny <wyes.karny@amd.com>
    cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update

Yang Yingliang <yangyingliang@huawei.com>
    drm/panel: nt36523: fix return value check in nt36523_probe()

xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
    drm/panel: starry-2081101qfh032011-53g: Fine tune the panel power sequence

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915/gsc: Mark internal GSC engine with reserved uabi class

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Make context clearing consistent with context mapping

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Disable PCI ATS in legacy passthrough mode

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Omit devTLB invalidation requests when TES=0

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Agustin Gutierrez <agustin.gutierrez@amd.com>
    drm/amd/display: Remove power sequencing check

Ian Chen <ian.chen@amd.com>
    drm/amd/display: Refactor edp power control

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device

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

Dave Ertman <david.m.ertman@intel.com>
    ice: Fix VF Reset paths when interface in a failed over aggregate

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: af_unix stream sockets need to hold ref for pair sock

Jakub Kicinski <kuba@kernel.org>
    ethtool: don't propagate EOPNOTSUPP from dumps

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix races between ravb_tx_timeout_work() and net related ops

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: prevent potential deadlock in rtl8169_close

Michael Roth <michael.roth@amd.com>
    efi/unaccepted: Fix off-by-one when checking for overlapping ranges

Gustavo A. R. Silva <gustavoars@kernel.org>
    neighbour: Fix __randomize_layout crash in struct neighbour

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Restore TC ingress police rules when interface is up

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

Hou Tao <houtao1@huawei.com>
    bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-eth: recycle the RX buffer only after all processing done

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-eth: increase the needed headroom to account for alignment

Greg Ungerer <gerg@kernel.org>
    net: dsa: mv88e6xxx: fix marvell 6350 probe crash

Greg Ungerer <gerg@kernel.org>
    net: dsa: mv88e6xxx: fix marvell 6350 switch probing

Oldřich Jedlička <oldium.pro@gmail.com>
    wifi: mac80211: do not pass AP_VLAN vif pointer to drivers during flush

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: rswitch: Fix missing dev_kfree_skb_any() in error path

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: rswitch: Fix return value in rswitch_start_xmit()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: rswitch: Fix type of ret in rswitch_start_xmit()

Stanislav Fomichev <sdf@google.com>
    netdevsim: Don't accept device bound programs

Dan Carpenter <dan.carpenter@linaro.org>
    media: v4l2-subdev: Fix a 64bit bug

Antonio Borneo <antonio.borneo@foss.st.com>
    pinctrl: stm32: fix array read out of bound

Chen Ni <nichen@iscas.ac.cn>
    pinctrl: stm32: Add check for devm_kcalloc

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix CQM for non-range use

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: recycle freed mapped buffer ring entries

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: defer release of mapped buffer rings

Jens Axboe <axboe@kernel.dk>
    io_uring: enable io_mem_alloc/free to be used in other parts

David Sterba <dsterba@suse.com>
    btrfs: fix 64bit compat send ioctl arguments not initializing version member

Qu Wenruo <wqu@suse.com>
    btrfs: free the allocated memory if btrfs_alloc_page_array() fails

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

Ritesh Harjani (IBM) <ritesh.list@gmail.com>
    ext2: Fix ki_pos update for DIO buffered-io fallback case

Markus Weippert <markus@gekmihesg.de>
    bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Robin Murphy <robin.murphy@arm.com>
    iommu: Avoid more races around device probe

Jens Axboe <axboe@kernel.dk>
    io_uring: don't guard IORING_OFF_PBUF_RING with SETUP_NO_MMAP

Christian König <christian.koenig@amd.com>
    dma-buf: fix check in dma_resv_add_fence

Gautham R. Shenoy <gautham.shenoy@amd.com>
    cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()

Lukasz Luba <lukasz.luba@arm.com>
    powercap: DTPM: Fix unneeded conversions to micro-Watts

Dave Airlie <airlied@redhat.com>
    nouveau: find the smallest page allocation to cover a buffer alloc.

Jens Axboe <axboe@kernel.dk>
    io_uring: free io_buffer_list entries via RCU

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix incorrect cache invalidation for mm notification

Jens Axboe <axboe@kernel.dk>
    io_uring: don't allow discontig pages for IORING_SETUP_NO_MMAP

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Use acpi_video_device for cooling-dev driver data

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix deadlock on RTL8125 in jumbo mtu mode

Ewan D. Milne <emilne@redhat.com>
    nvme: check for valid nvme_identify_ns() before using it

Wu Bo <bo.wu@vivo.com>
    dm verity: don't perform FEC for failed readahead IO

Wu Bo <bo.wu@vivo.com>
    dm verity: initialize fec io before freeing it

Zhongwei <zhongwei.zhang@amd.com>
    drm/amd/display: force toggle rate wa for first link training for a retimer

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

Candice Li <candice.li@amd.com>
    drm/amdgpu: Update EEPROM I2C address for smu v13_0_0

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix memory overflow in the IB test

Alex Sierra <alex.sierra@amd.com>
    drm/amdgpu: Force order between a read and write to the same address

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: correct the amdgpu runtime dereference usage count

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Enable PCIe PME from D3

Peter Wang <peter.wang@mediatek.com>
    scsi: ufs: core: Clear cmd if abort succeeds in MCQ mode

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Fix system start for ATA devices

Damien Le Moal <dlemoal@kernel.org>
    scsi: Change SCSI device boolean fields to single bit flags

Mikulas Patocka <mpatocka@redhat.com>
    dm-verity: align struct dm_verity_fec_io properly

Jiawen Wu <jiawenwu@trustnetic.com>
    net: libwx: fix memory leak on msix entry

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Headset Mic VREF to 100%

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Disable power-save on KONTRON SinglePC

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Also check for VGA converter in eDP probe

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

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Kornel Dulęba <korneld@chromium.org>
    mmc: sdhci-pci-gli: Disable LPM during initialization

Yang Yingliang <yangyingliang@huawei.com>
    firewire: core: fix possible memory leak in create_units()

Maria Yu <quic_aiquny@quicinc.com>
    pinctrl: avoid reload of p state in list iteration

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix possible deadlock in smb2_open

Paulo Alcantara <pc@manguebit.com>
    smb: client: report correct st_size for SMB and NFS symlinks

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix missing mode bits for SMB symlinks

David Howells <dhowells@redhat.com>
    cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved

David Howells <dhowells@redhat.com>
    cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved

Takashi Iwai <tiwai@suse.de>
    leds: class: Don't expose color sysfs entry


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-led          |   9 --
 Makefile                                           |   4 +-
 arch/parisc/include/asm/alternative.h              |   9 +-
 arch/parisc/include/asm/assembly.h                 |   1 +
 arch/parisc/include/asm/bug.h                      |  30 ++--
 arch/parisc/include/asm/jump_label.h               |   8 +-
 arch/parisc/include/asm/ldcw.h                     |   2 +-
 arch/parisc/include/asm/uaccess.h                  |   1 +
 arch/parisc/include/uapi/asm/errno.h               |   2 -
 arch/parisc/kernel/vmlinux.lds.S                   |   1 +
 arch/powerpc/kernel/fpu.S                          |  13 ++
 arch/powerpc/kernel/process.c                      |   6 +-
 arch/powerpc/kernel/vector.S                       |   2 +
 arch/powerpc/platforms/pseries/iommu.c             |   8 +-
 arch/s390/mm/page-states.c                         |   6 +
 arch/x86/xen/enlighten.c                           |   6 +-
 arch/x86/xen/xen-ops.h                             |   2 +-
 drivers/acpi/acpi_video.c                          |  14 +-
 drivers/acpi/scan.c                                |   7 +-
 drivers/ata/libata-scsi.c                          |   9 +-
 drivers/cpufreq/amd-pstate.c                       |  71 +++++++--
 drivers/cpufreq/imx6q-cpufreq.c                    |   2 +-
 drivers/dma-buf/dma-resv.c                         |   2 +-
 drivers/firewire/core-device.c                     |  11 +-
 drivers/firewire/sbp2.c                            |   6 +-
 drivers/firmware/efi/unaccepted_memory.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  21 +++
 drivers/gpu/drm/amd/display/dc/dc.h                |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   4 -
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   |   3 +-
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   6 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  15 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h          |   1 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   8 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  11 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |   1 +
 .../display/dc/link/protocols/link_dp_capability.c |  14 +-
 .../amd/display/dc/link/protocols/link_dp_phy.c    |   3 +-
 .../link_dp_training_fixed_vs_pe_retimer.c         |   6 +-
 .../dc/link/protocols/link_edp_panel_control.c     |  62 ++++++--
 .../dc/link/protocols/link_edp_panel_control.h     |   4 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   1 +
 .../drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h |   2 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   5 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  28 +++-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |  39 ++---
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   5 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36523.c      |   4 +-
 drivers/iommu/intel/dmar.c                         |  18 +++
 drivers/iommu/intel/iommu.c                        |   9 +-
 drivers/iommu/intel/svm.c                          |  26 ++++
 drivers/iommu/iommu.c                              |  20 +--
 drivers/iommu/of_iommu.c                           |  14 +-
 drivers/leds/led-class.c                           |  14 --
 drivers/md/bcache/btree.c                          |   2 +-
 drivers/md/dm-verity-fec.c                         |   3 +-
 drivers/md/dm-verity-target.c                      |   7 +-
 drivers/md/dm-verity.h                             |   6 -
 drivers/mmc/core/block.c                           |   2 +
 drivers/mmc/core/core.c                            |   9 +-
 drivers/mmc/host/cqhci-core.c                      |  44 +++---
 drivers/mmc/host/sdhci-pci-gli.c                   |  54 ++++---
 drivers/mmc/host/sdhci-sprd.c                      |  25 +++
 drivers/net/dsa/mv88e6xxx/chip.c                   |  26 +++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  16 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           | 122 +++++++++------
 drivers/net/ethernet/intel/ice/ice_lag.h           |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  20 +++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  25 +++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   9 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 120 ++++++++++++---
 drivers/net/ethernet/realtek/r8169_main.c          |   9 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  69 ++++++---
 drivers/net/ethernet/renesas/rswitch.c             |  22 +--
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +-
 drivers/net/netdevsim/bpf.c                        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   4 +-
 drivers/nvme/host/core.c                           |   9 ++
 drivers/pinctrl/core.c                             |   6 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  13 +-
 drivers/powercap/dtpm_cpu.c                        |   6 +-
 drivers/powercap/dtpm_devfreq.c                    |  11 +-
 drivers/scsi/sd.c                                  |   9 +-
 drivers/ufs/core/ufshcd.c                          |  13 ++
 drivers/vfio/pci/pds/pci_drv.c                     |   4 +-
 drivers/vfio/pci/pds/vfio_dev.c                    |  30 ++--
 drivers/vfio/pci/pds/vfio_dev.h                    |   2 +-
 fs/btrfs/disk-io.c                                 |   1 +
 fs/btrfs/extent_io.c                               |  11 +-
 fs/btrfs/ioctl.c                                   |   1 +
 fs/btrfs/ref-verify.c                              |   2 +
 fs/btrfs/send.c                                    |   2 +-
 fs/btrfs/super.c                                   |   5 +-
 fs/btrfs/volumes.c                                 |   9 +-
 fs/ext2/file.c                                     |   1 -
 fs/smb/client/inode.c                              |   4 +-
 fs/smb/client/smb2ops.c                            |  13 +-
 fs/smb/server/smb2pdu.c                            |  47 +++---
 fs/smb/server/smbacl.c                             |   7 +-
 fs/smb/server/smbacl.h                             |   2 +-
 fs/smb/server/vfs.c                                |  68 +++++----
 fs/smb/server/vfs.h                                |  10 +-
 include/linux/amd-pstate.h                         |   4 +
 include/linux/dma-fence.h                          |  15 ++
 include/linux/io_uring_types.h                     |   3 +
 include/linux/iommu.h                              |   1 +
 include/linux/skmsg.h                              |   1 +
 include/linux/vfio.h                               |   8 +-
 include/net/af_unix.h                              |   1 +
 include/net/neighbour.h                            |   2 +-
 include/scsi/scsi_device.h                         |  12 +-
 include/uapi/linux/stddef.h                        |   2 +-
 include/uapi/linux/v4l2-subdev.h                   |   2 +-
 io_uring/io_uring.c                                |  59 +++----
 io_uring/io_uring.h                                |   3 +
 io_uring/kbuf.c                                    | 169 ++++++++++++++++++---
 io_uring/kbuf.h                                    |   5 +
 kernel/bpf/memalloc.c                              |   2 +
 lib/errname.c                                      |   6 -
 net/core/skmsg.c                                   |   2 +
 net/ethtool/netlink.c                              |   1 +
 net/ipv4/igmp.c                                    |   6 +-
 net/mac80211/driver-ops.h                          |   9 +-
 net/unix/af_unix.c                                 |   2 -
 net/unix/unix_bpf.c                                |   5 +
 net/wireless/core.h                                |   1 +
 net/wireless/nl80211.c                             |  50 +++---
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_realtek.c                      |  12 ++
 tools/arch/parisc/include/uapi/asm/errno.h         |   2 -
 tools/testing/selftests/net/af_unix/diag_uid.c     |   1 -
 tools/testing/selftests/net/cmsg_sender.c          |   2 +-
 tools/testing/selftests/net/ipsec.c                |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  11 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |  11 +-
 153 files changed, 1333 insertions(+), 624 deletions(-)


