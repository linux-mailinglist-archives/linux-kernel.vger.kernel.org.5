Return-Path: <linux-kernel+bounces-19739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA605827236
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741A41F231F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D734C3D0;
	Mon,  8 Jan 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euS/T12c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90454B5AE;
	Mon,  8 Jan 2024 15:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EBAC433C7;
	Mon,  8 Jan 2024 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726625;
	bh=7IAvqQYSs2EztcmQZyYat4TDJAihAqDgSMneNqSzeSk=;
	h=From:To:Cc:Subject:Date:From;
	b=euS/T12cfK9zhSJKvrP0yOppS+/VE9ZJOtZ30wDYPs/E8QRYrwsEKPv5ZDy7wmoZp
	 oSwgzykujBN8C16UzhUJvKZjY3m+4KlVfI7J1WcZmRvOHDOcyJPJgL2iTG7OXbOw5q
	 03MXAgr/yX8v72mCviEHpPFTbzBXLeO3RkWQKipE=
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
Subject: [PATCH 6.6 000/124] 6.6.11-rc1 review
Date: Mon,  8 Jan 2024 16:07:06 +0100
Message-ID: <20240108150602.976232871@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.11-rc1
X-KernelTest-Deadline: 2024-01-10T15:06+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.11 release.
There are 124 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.11-rc1

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Comment CSID dt_id field

Alison Schofield <alison.schofield@intel.com>
    cxl/memdev: Hold region_rwsem during inject and clear poison ops

Dave Jiang <dave.jiang@intel.com>
    cxl/hdm: Fix a benign lockdep splat

Dave Jiang <dave.jiang@intel.com>
    cxl: Add cxl_num_decoders_committed() usage to cxl_test

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz <jorge@foundries.io>
    mmc: rpmb: fixes pause retune on all RPMB partitions.

Ziyang Huang <hzyitc@outlook.com>
    mmc: meson-mx-sdhc: Fix initialization frozen issue

Joshua Ashton <joshua@froggi.es>
    drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/display: add nv12 bounding box

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: skip gpu_info fw loading on navi12

Jiajun Xie <jiajun.xie.sh@gmail.com>
    mm: fix unmap_mapping_range high bits shift bug

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Fix atomic xfer check for non-preempt config

Jinghao Jia <jinghao7@illinois.edu>
    x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Yu Zhao <yuzhao@google.com>
    mm/mglru: skip special VMAs in lru_gen_look_around()

Eric Dumazet <edumazet@google.com>
    net: constify sk_dst_get() and __sk_dst_get() argument

duanqiangwen <duanqiangwen@net-swift.com>
    net: libwx: fix memory leak on free page

Ira Weiny <ira.weiny@intel.com>
    cxl/pmu: Ensure put_device on pmu devices

Eric Dumazet <edumazet@google.com>
    net: prevent mss overflow in skb_segment()

Haren Myneni <haren@linux.ibm.com>
    powerpc/pseries/vas: Migration suspend waits for no in-progress open windows

Yong-Xuan Wang <yongxuan.wang@sifive.com>
    RISCV: KVM: update external interrupt atomically for IMSIC swfile

Yang Yingliang <yangyingliang@huawei.com>
    dmaengine: fsl-edma: fix wrong pointer check in fsl_edma3_attach_pd()

Guanjun <guanjun@linux.alibaba.com>
    dmaengine: idxd: Protect int_handle field in hw descriptor

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml

Alison Schofield <alison.schofield@intel.com>
    kernel/resource: Increment by align value in get_free_mem_region()

Alison Schofield <alison.schofield@intel.com>
    cxl/core: Always hold region_rwsem while reading poison lists

Dave Jiang <dave.jiang@intel.com>
    cxl: Add cxl_decoders_committed() helper

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: Increase num voltage states to 40

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Call intel_pre_plane_updates() also for pipes getting enabled

Alex Bee <knaerzche@gmail.com>
    clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name

Finley Xiao <finley.xiao@rock-chips.com>
    clk: rockchip: rk3128: Fix aclk_peri_src's parent

Su Hui <suhui@nfschina.com>
    phy: sunplus: return negative error code in sp_usb_phy_probe

Michael Walle <mwalle@kernel.org>
    phy: mediatek: mipi: mt8183: fix minimal supported frequency

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Support enforce_cache_coherency only for empty domains

Nuno Sa <nuno.sa@analog.com>
    iio: imu: adis16475: use bit numbers in assign_bit()

Xiaolei Wang <xiaolei.wang@windriver.com>
    dmaengine: fsl-edma: Add judgment on enabling round robin arbitration

Xiaolei Wang <xiaolei.wang@windriver.com>
    dmaengine: fsl-edma: Do not suspend and resume the masked dma channel when the system is sleeping

Jai Luthra <j-luthra@ti.com>
    dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data

Ronald Wahl <rwahl@gmx.de>
    dmaengine: ti: k3-psil-am62: Fix SPI PDMA data

Andrew Davis <afd@ti.com>
    phy: ti: gmii-sel: Fix register offset when parent is not a syscon node

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: vsie: fix wrong VIR 37 when MSO is used

Jisheng Zhang <jszhang@kernel.org>
    riscv: don't probe unaligned access speed if already done

Frederic Weisbecker <frederic@kernel.org>
    rcu/tasks-trace: Handle new PF_IDLE semantics

Frederic Weisbecker <frederic@kernel.org>
    rcu/tasks: Handle new PF_IDLE semantics

Frederic Weisbecker <frederic@kernel.org>
    rcu: Introduce rcu_cpu_online()

Peter Zijlstra <peterz@infradead.org>
    rcu: Break rcu_node_0 --> &rq->__lock order

Dan Carpenter <dan.carpenter@linaro.org>
    ACPI: thermal: Fix acpi_thermal_unregister_thermal_zone() cleanup

Moshe Shemesh <moshe@nvidia.com>
    RDMA/mlx5: Fix mkey cache WQ flush

Marek Vasut <marex@denx.de>
    clk: si521xx: Increase stack based print buffer size in probe

Alex Williamson <alex.williamson@redhat.com>
    vfio/mtty: Overhaul mtty interrupt handling

Longfang Liu <liulongfang@huawei.com>
    crypto: hisilicon/qm - fix EQ/AEQ interrupt issue

Svyatoslav Pankratov <svyatoslav.pankratov@intel.com>
    crypto: qat - fix double free during reset

Eric Biggers <ebiggers@google.com>
    crypto: xts - use 'spawn' for underlying single-block cipher

Ian Rogers <irogers@google.com>
    bpftool: Align output skeleton ELF code

Denys Zagorui <dzagorui@cisco.com>
    bpftool: Fix -Wcast-qual warning

Eric Dumazet <edumazet@google.com>
    tcp: derive delack_max from rto_min

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix genpd cleanup

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix V4L2 async notifier error path

Tirthendu Sarkar <tirthendu.sarkar@intel.com>
    xsk: add multi-buffer support for sockets sharing umem

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm/memory-failure: pass the folio and the page to collect_procs()

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm: convert DAX lock/unlock page to lock/unlock folio

Thomas Lange <thomas@corelatus.se>
    net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Wait for operating mode to be applied

Chen Ni <nichen@iscas.ac.cn>
    asix: Add check for usbnet_get_endpoints

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-af: Re-enable MAC TX in otx2_stop processing

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-af: Always configure NIX TX link credits based on max frame size

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix invalid link access in dumping SMC-R connections

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Xuan Zhuo <xuanzhuo@linux.alibaba.com>
    virtio_net: fix missing dma unmap for resize

Eric Dumazet <edumazet@google.com>
    virtio_net: avoid data-races on dev->stats fields

John Johansen <john.johansen@canonical.com>
    apparmor: Fix move_mount mediation by detecting if source is detached

Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
    igc: Fix hicredit calculation

Andrii Staikov <andrii.staikov@intel.com>
    i40e: Restore VF MSI-X state during PCI reset

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-toacodec: Fix event generation

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Validate written enum values

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-toacodec: Validate written enum values

Ke Xiao <xiaoke@sangfor.com.cn>
    i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne <marc.dionne@auristor.com>
    net: Save and restore msg_namelen in sock_sendmsg

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_immediate: drop chain reference counter on error

Brad Cowie <brad@faucet.nz>
    netfilter: nf_nat: fix action not being set for all ct states

Adrian Cinal <adriancinal@gmail.com>
    net: bcmgenet: Fix FCS generation for fragmented skbuffs

Zhipeng Lu <alexious@zju.edu.cn>
    sfc: fix a double-free bug in efx_probe_filters

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Hangbin Liu <liuhangbin@gmail.com>
    selftests: bonding: do not set port down when adding to bond

Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
    net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Fix PCI error on system resume

Hangyu Hua <hbh25y@gmail.com>
    net: sched: em_text: fix possible memory leak in em_text_destroy()

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: fix receive packet race condition

Eugen Hristev <eugen.hristev@collabora.com>
    ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset

Chancel Liu <chancel.liu@nxp.com>
    ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Check VLAN EtherType mask

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Check VLAN TCI mask

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Report VLAN EtherType matching back to user

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    i40e: Fix filter input checks to prevent config with invalid values

Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
    ice: Shut down VSI with "link-down-on-close" enabled

Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
    ice: Fix link_down_on_close message

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    drm/i915/perf: Update handling of MMIO triggered reports

Khaled Almahallawy <khaled.almahallawy@intel.com>
    drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix marking couple of structure as __packed

Siddh Raman Pant <code@siddh.me>
    nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: set transport offset from mac header for netdev/egress

Douglas Anderson <dianders@chromium.org>
    drm/bridge: ps8640: Fix size mismatch warning w/ len

Douglas Anderson <dianders@chromium.org>
    drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer

Douglas Anderson <dianders@chromium.org>
    drm/bridge: parade-ps8640: Never store more than msg->size bytes in AUX xfer

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

Jeffrey Hugo <quic_jhugo@quicinc.com>
    accel/qaic: Implement quirk for SOC_HW_VERSION

Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
    accel/qaic: Fix GEM import path code

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL

Shyam Prasad N <sprasad@microsoft.com>
    cifs: do not depend on release_iface for maintaining iface_list

Shyam Prasad N <sprasad@microsoft.com>
    cifs: cifs_chan_is_iface_active should be called with chan_lock held

Jocelyn Falempe <jfalempe@redhat.com>
    drm/mgag200: Fix gamma lut not initialized for G200ER, G200EV, G200SE

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"

Paolo Abeni <pabeni@redhat.com>
    mptcp: prevent tcp diag from closing listener subflows

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: pbn_div need be updated for hotplug event

Siddhesh Dharme <siddheshdharme18@gmail.com>
    ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook

Aabish Malik <aabishmalik3337@gmail.com>
    ALSA: hda/realtek: enable SND_PCI_QUIRK for hp pavilion 14-ec1xxx series

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: remove sound controls in unbind

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: move set_drv_data outside tasdevice_init

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: do not use regcache

Edward Adam Davis <eadavis@qq.com>
    keys, dns: Fix missing size check of V1 server-list header


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 arch/powerpc/platforms/pseries/vas.c               |  51 ++++-
 arch/powerpc/platforms/pseries/vas.h               |   2 +
 arch/riscv/kernel/cpufeature.c                     |   4 +
 arch/riscv/kvm/aia_imsic.c                         |  13 ++
 arch/s390/kvm/vsie.c                               |   4 -
 arch/x86/events/intel/core.c                       |   7 +-
 arch/x86/kernel/kprobes/core.c                     |   3 +-
 crypto/xts.c                                       |  23 +-
 drivers/accel/qaic/mhi_controller.c                |  15 +-
 drivers/accel/qaic/qaic_data.c                     |   6 +-
 drivers/acpi/thermal.c                             |   4 +-
 drivers/clk/clk-si521xx.c                          |   4 +-
 drivers/clk/rockchip/clk-rk3128.c                  |  22 +-
 drivers/crypto/hisilicon/qm.c                      | 117 ++++------
 drivers/crypto/intel/qat/qat_common/adf_aer.c      |   3 +-
 drivers/cxl/core/hdm.c                             |   9 +-
 drivers/cxl/core/mbox.c                            |   2 +-
 drivers/cxl/core/memdev.c                          |  31 ++-
 drivers/cxl/core/pmu.c                             |   2 +-
 drivers/cxl/core/port.c                            |   7 +
 drivers/cxl/core/region.c                          |   5 -
 drivers/cxl/cxl.h                                  |   1 +
 drivers/dma/fsl-edma-main.c                        |  12 +-
 drivers/dma/idxd/submit.c                          |  14 +-
 drivers/dma/ti/k3-psil-am62.c                      |  12 +-
 drivers/dma/ti/k3-psil-am62a.c                     |  12 +-
 drivers/firewire/ohci.c                            |  51 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  11 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   4 +
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h   |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 110 +++++++++-
 .../amd/display/modules/info_packet/info_packet.c  |  13 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |   7 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   4 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   3 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  39 +++-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |   5 +
 drivers/gpu/drm/mgag200/mgag200_g200er.c           |   5 +
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           |   5 +
 drivers/gpu/drm/mgag200/mgag200_g200se.c           |   5 +
 drivers/gpu/drm/mgag200/mgag200_mode.c             |  10 +-
 drivers/i2c/i2c-core.h                             |   4 +-
 drivers/iio/imu/adis16475.c                        |   4 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   2 +
 drivers/iommu/intel/iommu.c                        |   5 +-
 drivers/iommu/intel/iommu.h                        |   3 +
 .../media/platform/qcom/camss/camss-csid-gen2.c    |  14 +-
 drivers/media/platform/qcom/camss/camss.c          |  45 ++--
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/core/host.c                            |   1 +
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |  26 +--
 drivers/mmc/host/sdhci-sprd.c                      |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  12 +-
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  42 +++-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  17 ++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 118 +---------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   9 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 +
 drivers/net/ethernet/realtek/r8169_main.c          |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  65 ++++--
 drivers/net/ethernet/sfc/rx_common.c               |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  82 +------
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   1 -
 drivers/net/usb/ax88172a.c                         |   4 +-
 drivers/net/virtio_net.c                           |  90 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  17 +-
 drivers/pci/pci.c                                  |   6 +
 drivers/pci/pci.h                                  |   2 +
 drivers/pci/pcie/aspm.c                            |  19 ++
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c     |   2 +-
 drivers/phy/sunplus/phy-sunplus-usb2.c             |   2 +-
 drivers/phy/ti/phy-gmii-sel.c                      |   5 +-
 fs/dax.c                                           |  24 +--
 fs/smb/client/cifsglob.h                           |   1 -
 fs/smb/client/connect.c                            |   9 +-
 fs/smb/client/smb2ops.c                            |  34 ++-
 include/linux/dax.h                                |  10 +-
 include/linux/hisi_acc_qm.h                        |   1 +
 include/net/netfilter/nf_tables_ipv4.h             |   2 +-
 include/net/sock.h                                 |   4 +-
 include/net/tcp.h                                  |   2 +
 include/net/xdp_sock.h                             |   2 +
 kernel/rcu/rcu.h                                   |   2 +
 kernel/rcu/tasks.h                                 |  32 ++-
 kernel/rcu/tree.c                                  |  43 +++-
 kernel/resource.c                                  |   4 +-
 mm/memory-failure.c                                |  52 ++---
 mm/memory.c                                        |   4 +-
 mm/vmscan.c                                        |  13 +-
 net/core/skbuff.c                                  |   3 +-
 net/core/sock.c                                    |  12 +-
 net/dns_resolver/dns_key.c                         |  19 +-
 net/ipv4/tcp.c                                     |   3 +-
 net/ipv4/tcp_output.c                              |  16 +-
 net/mptcp/subflow.c                                |  13 ++
 net/netfilter/nf_nat_ovs.c                         |   3 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/netfilter/nft_immediate.c                      |   2 +-
 net/nfc/llcp_core.c                                |  39 +++-
 net/sched/em_text.c                                |   4 +-
 net/smc/smc_diag.c                                 |   3 +-
 net/socket.c                                       |   2 +
 net/xdp/xsk.c                                      |   2 +-
 net/xdp/xsk_buff_pool.c                            |   3 +
 samples/vfio-mdev/mtty.c                           | 237 +++++++++++++-------
 security/apparmor/apparmorfs.c                     |   1 +
 security/apparmor/mount.c                          |   4 +
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/pci/hda/tas2781_hda_i2c.c                    | 240 +++++++++++----------
 sound/soc/codecs/tas2781-comlib.c                  |   4 +-
 sound/soc/codecs/tas2781-i2c.c                     |   2 +
 sound/soc/fsl/fsl_rpmsg.c                          |  10 +-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c        |   2 +-
 sound/soc/meson/g12a-toacodec.c                    |   5 +-
 sound/soc/meson/g12a-tohdmitx.c                    |   8 +-
 tools/bpf/bpftool/gen.c                            |  15 +-
 tools/testing/cxl/Kbuild                           |   1 +
 tools/testing/cxl/cxl_core_exports.c               |   7 +
 tools/testing/cxl/test/cxl.c                       |   5 +-
 .../net/bonding/bond-arp-interval-causes-panic.sh  |   6 +-
 135 files changed, 1449 insertions(+), 844 deletions(-)



