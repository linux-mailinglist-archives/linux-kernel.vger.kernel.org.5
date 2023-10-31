Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6767DD3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjJaRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjJaRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:02:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC9135;
        Tue, 31 Oct 2023 10:02:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36832C433C8;
        Tue, 31 Oct 2023 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771724;
        bh=Yib8PxtihkLY52NAPyUsVxYYZhgDNEIT1WMqHZWXBss=;
        h=From:To:Cc:Subject:Date:From;
        b=jXAFRUiwZAjh3AlRRDvZn4VGJWETPBpwMuGcbbrFsuyjWmFYJo1fnnBiY64ZBBsC7
         AbgClOfYsynE6gyr18+30BIyb1jXSxzAs0Zsq1mvNBz4uiTrehU6cZi2TUtawjZrFn
         M9ZLLqlgOvwn1B1IVeUHjyF+Z+nOsXbwp9kukRzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 00/86] 6.1.61-rc1 review
Date:   Tue, 31 Oct 2023 18:00:25 +0100
Message-ID: <20231031165918.608547597@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.61-rc1
X-KernelTest-Deadline: 2023-11-02T16:59+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.61 release.
There are 86 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.61-rc1

John Sperbeck <jsperbeck@google.com>
    objtool/x86: add missing embedded_insn check

Baokun Li <libaokun1@huawei.com>
    ext4: avoid overlapping preallocations due to overflow

Baokun Li <libaokun1@huawei.com>
    ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow

Baokun Li <libaokun1@huawei.com>
    ext4: add two helper functions extent_logical_end() and pa_logical_end()

David Lazar <dlazar@gmail.com>
    platform/x86: Add s2idle quirk for more Lenovo laptops

Alessandro Carminati <alessandro.carminati@gmail.com>
    clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name

Al Viro <viro@zeniv.linux.org.uk>
    sparc32: fix a braino in fault handling in csum_and_copy_..._user()

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix potential NULL deref

Tony Luck <tony.luck@intel.com>
    x86/cpu: Add model number for Intel Arrow Lake mobile processor

Thomas Gleixner <tglx@linutronix.de>
    x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6UL

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6SLL

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6ULL

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Unmap only if buffer is unmapped from DSP

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Clean buffers on remote invocation failures

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Free DMA handles for RPC calls with no arguments

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Reset metadata buffer to avoid incorrect free

Yujie Liu <yujie.liu@intel.com>
    tracing/kprobes: Fix the description of variable length arguments

Jian Zhang <zhangjian.3032@bytedance.com>
    i2c: aspeed: Fix i2c bus hang in slave read

Alain Volmat <alain.volmat@foss.st.com>
    i2c: stm32f7: Fix PEC handling in case of SMBUS transfers

Herve Codina <herve.codina@bootlin.com>
    i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()

Herve Codina <herve.codina@bootlin.com>
    i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()

Herve Codina <herve.codina@bootlin.com>
    i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()

Robert Hancock <robert.hancock@calian.com>
    iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

Robert Hancock <robert.hancock@calian.com>
    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds

Marek Szyprowski <m.szyprowski@samsung.com>
    iio: exynos-adc: request second interupt only when touchscreen mode is used

Linus Walleij <linus.walleij@linaro.org>
    iio: afe: rescale: Accept only offset channels

Jens Axboe <axboe@kernel.dk>
    io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Haibo Li <haibo.li@mediatek.com>
    kasan: print the original fault addr when access invalid shadow

Khazhismel Kumykov <khazhy@chromium.org>
    blk-throttle: check for overflow in calculate_bytes_allowed

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Introduce manage_shutdown device flag

Michal Schmidt <mschmidt@redhat.com>
    iavf: in iavf_down, disable queues when removing the driver

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Pablo Neira Ayuso <pablo@netfilter.org>
    gtp: fix fragmentation needed check with gso

Pablo Neira Ayuso <pablo@netfilter.org>
    gtp: uapi: fix GTPA_MAX

Fred Chen <fred.chenchen03@gmail.com>
    tcp: fix wrong RTO timeout when received SACK reneging

Douglas Anderson <dianders@chromium.org>
    r8152: Release firmware if we have an error in probe

Douglas Anderson <dianders@chromium.org>
    r8152: Cancel hw_phy_work if we have an error in probe

Douglas Anderson <dianders@chromium.org>
    r8152: Run the unload routine if we have errors during probe

Douglas Anderson <dianders@chromium.org>
    r8152: Increase USB control msg timeout to 5000ms as per spec

Shigeru Yoshida <syoshida@redhat.com>
    net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()

Dell Jin <dell.jin.code@outlook.com>
    net: ethernet: adi: adin1110: Fix uninitialized variable

Sasha Neftin <sasha.neftin@intel.com>
    igc: Fix ambiguity in the ethtool advertising

Eric Dumazet <edumazet@google.com>
    neighbour: fix various data-races

Mateusz Palczewski <mateusz.palczewski@intel.com>
    igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Kunwu Chan <chentao@kylinos.cn>
    treewide: Spelling fix in comment

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value

Michal Schmidt <mschmidt@redhat.com>
    iavf: initialize waitqueues before starting watchdog_task

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx

Tony Lindgren <tony@atomide.com>
    clk: ti: Fix missing omap5 mcbsp functional clock and aliases

Tony Lindgren <tony@atomide.com>
    clk: ti: Fix missing omap4 mcbsp functional clock and aliases

Hao Ge <gehao@kylinos.cn>
    firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()

Randy Dunlap <rdunlap@infradead.org>
    ARM: OMAP: timer32K: fix all kernel-doc warnings

Lukasz Majczak <lma@semihalf.com>
    drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Disable ASPM for VI w/ all Intel systems

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    drm/i915/pmu: Check if pmu is closed before stopping event

Al Viro <viro@zeniv.linux.org.uk>
    nfsd: lock_rename() needs both directories to live on the same fs

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: add GFP_KERNEL to allocations in mas_expected_entries()

Rik van Riel <riel@surriel.com>
    hugetlbfs: extend hugetlb_vma_lock to private VMAs

Gregory Price <gourry.memverge@gmail.com>
    mm/migrate: fix do_pages_move for compat pointers

Kemeng Shi <shikemeng@huaweicloud.com>
    mm/page_alloc: correct start page when guard page debug is enabled

Rik van Riel <riel@surriel.com>
    hugetlbfs: clear resv_map pointer if mmap fails

Sebastian Ott <sebott@redhat.com>
    mm: fix vm_brk_flags() to not bail out while holding lock

Christopher Obbard <chris.obbard@collabora.com>
    arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards

Christopher Obbard <chris.obbard@collabora.com>
    arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399

Eric Auger <eric.auger@redhat.com>
    vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Alexandru Matei <alexandru.matei@uipath.com>
    vsock/virtio: initialize the_virtio_vsock before using VQs

Xuan Zhuo <xuanzhuo@linux.alibaba.com>
    virtio_pci: fix the common cfg map size

zhenwei pi <pizhenwei@bytedance.com>
    virtio-crypto: handle config changed by work queue

Maximilian Heyne <mheyne@amazon.de>
    virtio-mmio: fix memory leak of vm_dev

Gavin Shan <gshan@redhat.com>
    virtio_balloon: Fix endless deflation and inflation on arm64

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb-lpc: Reallocate memory region to avoid memory overlapping

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb: Return actual parsed size when reading chameleon table

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    pinctrl: qcom: lpass-lpi: fix concurrent register updates

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix runtime PM imbalance on remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix regulator leaks on probe errors

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wcd938x: Simplify with dev_err_probe

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    ASoC: codecs: wcd938x: Convert to platform remove callback returning void

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Fix error propagation for some ioctl commands

Christian Loehle <CLoehle@hyperstone.com>
    mmc: block: ioctl: do write error check for spi

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Align to common busy polling behaviour for mmc ioctls

Roman Kagan <rkagan@amazon.de>
    KVM: x86/pmu: Truncate counter value to allowed width on write


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/omap4-l4-abe.dtsi                |  6 ++
 arch/arm/boot/dts/omap4-l4.dtsi                    |  2 +
 arch/arm/boot/dts/omap5-l4-abe.dtsi                |  6 ++
 arch/arm/mach-omap1/timer32k.c                     | 14 ++---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 10 +++
 arch/sparc/lib/checksum_32.S                       |  2 +-
 arch/x86/include/asm/i8259.h                       |  2 +
 arch/x86/include/asm/intel-family.h                |  2 +
 arch/x86/kernel/acpi/boot.c                        |  3 +
 arch/x86/kernel/i8259.c                            | 38 ++++++++---
 arch/x86/kvm/pmu.h                                 |  6 ++
 arch/x86/kvm/svm/pmu.c                             |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |  4 +-
 block/blk-throttle.c                               |  6 ++
 drivers/ata/libata-scsi.c                          |  5 +-
 drivers/clk/clk.c                                  | 21 ++++---
 drivers/clk/ti/clk-44xx.c                          |  5 ++
 drivers/clk/ti/clk-54xx.c                          |  4 ++
 drivers/crypto/virtio/virtio_crypto_common.h       |  3 +
 drivers/crypto/virtio/virtio_crypto_core.c         | 14 ++++-
 drivers/firewire/sbp2.c                            |  1 +
 drivers/firmware/imx/imx-dsp.c                     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  2 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |  6 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |  9 +++
 drivers/gpu/drm/logicvc/Kconfig                    |  2 +
 drivers/i2c/busses/i2c-aspeed.c                    |  3 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |  9 ++-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |  2 +-
 drivers/i2c/muxes/i2c-mux-gpmux.c                  |  2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  2 +-
 drivers/iio/adc/exynos_adc.c                       | 24 ++++---
 drivers/iio/adc/xilinx-xadc-core.c                 | 39 +++++-------
 drivers/iio/adc/xilinx-xadc.h                      |  2 +
 drivers/iio/afe/iio-rescale.c                      | 19 ++++--
 drivers/mcb/mcb-lpc.c                              | 35 +++++++++--
 drivers/mcb/mcb-parse.c                            | 15 +++--
 drivers/misc/fastrpc.c                             | 34 +++++-----
 drivers/mmc/core/block.c                           | 38 ++++++++---
 drivers/mmc/core/mmc_ops.c                         |  1 +
 drivers/net/ethernet/adi/adin1110.c                |  2 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  7 ++-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       | 35 ++++++++---
 drivers/net/ethernet/realtek/r8169_main.c          |  6 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |  2 +-
 drivers/net/gtp.c                                  |  5 +-
 drivers/net/ieee802154/adf7242.c                   |  5 +-
 drivers/net/usb/r8152.c                            | 11 +++-
 drivers/net/usb/smsc95xx.c                         |  4 +-
 drivers/nvmem/imx-ocotp.c                          |  6 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 17 +++--
 drivers/platform/x86/thinkpad_acpi.c               | 73 ++++++++++++++++++++++
 drivers/scsi/sd.c                                  | 39 +++++++++++-
 drivers/vhost/vhost.c                              |  4 +-
 drivers/virtio/virtio_balloon.c                    |  6 +-
 drivers/virtio/virtio_mmio.c                       | 19 ++++--
 drivers/virtio/virtio_pci_modern_dev.c             |  2 +-
 fs/ext4/mballoc.c                                  | 51 +++++++--------
 fs/ext4/mballoc.h                                  | 14 +++++
 fs/nfsd/vfs.c                                      | 12 ++--
 include/linux/hugetlb.h                            |  6 ++
 include/linux/kasan.h                              |  6 +-
 include/scsi/scsi_device.h                         | 20 +++++-
 include/uapi/linux/gtp.h                           |  2 +-
 io_uring/fdinfo.c                                  | 18 ++++--
 kernel/events/core.c                               |  3 +-
 kernel/trace/trace_kprobe.c                        |  4 +-
 lib/maple_tree.c                                   |  2 +-
 lib/test_maple_tree.c                              | 35 +++++++----
 mm/hugetlb.c                                       | 48 +++++++++++---
 mm/kasan/report.c                                  |  4 +-
 mm/migrate.c                                       | 14 ++++-
 mm/mmap.c                                          |  6 +-
 mm/page_alloc.c                                    |  2 +-
 net/core/neighbour.c                               | 67 ++++++++++----------
 net/ipv4/tcp_input.c                               |  9 +--
 net/vmw_vsock/virtio_transport.c                   | 18 +++++-
 sound/soc/codecs/wcd938x.c                         | 51 ++++++++-------
 tools/include/linux/rwsem.h                        | 40 ++++++++++++
 tools/objtool/check.c                              |  2 +-
 85 files changed, 789 insertions(+), 305 deletions(-)


