Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDF7E49CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjKGUYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjKGUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:24:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27710C0;
        Tue,  7 Nov 2023 12:24:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8072BC433C8;
        Tue,  7 Nov 2023 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699388690;
        bh=1nKDTQDov+VqbdZkrumS1zpeTEigOgJZkjJXe1OGd68=;
        h=From:To:Cc:Subject:Date:From;
        b=x23Q0a5ry8kklneK/7/JclRKpFaDt2vRpfoovt6c2ZDeKmlrxwH6wJzsaT37xFIBB
         z57iLHlRBFjpZinqt9I4xj7axgBKlD8QWNBFqmdO46d1E2g28RyuVLApkWdlXOcd7C
         Iu9VCBoMSwBuLZkvi6eGWQ5H3lShpXYTWCKM8ArQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 000/125] 5.15.138-rc2 review
Date:   Tue,  7 Nov 2023 21:24:45 +0100
Message-ID: <20231107202324.434534294@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.138-rc2
X-KernelTest-Deadline: 2023-11-09T20:23+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.138 release.
There are 125 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 09 Nov 2023 20:22:58 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.138-rc2

Mark Hasemeyer <markhas@chromium.org>
    ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection

Siddharth Vadapalli <s-vadapalli@ti.com>
    misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Intashield IX cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for additional Brainboxes PX cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Fix up PX-803/PX-857

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Fix port count of PX-257

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Intashield IS-100

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Brainboxes UP cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for additional Brainboxes UC cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Remove UC-257 and UC-431

Daniel Starke <daniel.starke@siemens.com>
    tty: n_gsm: fix race condition in status line change on dead connections

Andrey Konovalov <andreyknvl@gmail.com>
    usb: raw-gadget: properly handle interrupted requests

Jimmy Hu <hhhuuu@google.com>
    usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

LihaSika <lihasika@gmail.com>
    usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Vicki Pfau <vi@endrift.com>
    PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Disable ASPM for VI w/ all Intel systems

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Move helper for dynamic speed switch check out of smu13

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: isotp_bind(): do not validate unused address information

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: add local echo tx processing and tx without FC

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: handle wait_event_interruptible() return values

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: check CAN address family in isotp_bind()

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: set max PDU size to 64 kByte

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix boot crash with FLATMEM

Douglas Anderson <dianders@chromium.org>
    r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()

Douglas Anderson <dianders@chromium.org>
    r8152: Check for unplug in rtl_phy_patch_request()

Su Hui <suhui@nfschina.com>
    net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Fix a warning message

Tomas Henzl <thenzl@redhat.com>
    scsi: mpt3sas: Fix in error path

Jorge Maidana <jorgem.linux@gmail.com>
    fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Karolina Stolarek <karolina.stolarek@intel.com>
    drm/ttm: Reorder sys manager cleanup step

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5650: fix the wrong result of key button

Florian Westphal <fw@strlen.de>
    netfilter: nfnetlink_log: silence bogus compiler warning

William A. Kennington III <william@wkennington.com>
    spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0

Su Hui <suhui@nfschina.com>
    fs/ntfs3: Avoid possible memory leak

Gabriel Marcano <gabemarcano@yahoo.com>
    fs/ntfs3: Fix directory element type detection

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Write immediately updated ntfs state

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add ckeck in ni_update_parent()

Arnd Bergmann <arnd@arndb.de>
    fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/85xx: Fix math emulation exception

Zhang Shurong <zhang_shurong@foxmail.com>
    dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    irqchip/stm32-exti: add missing DT IRQ flag translation

Anup Patel <apatel@ventanamicro.com>
    irqchip/riscv-intc: Mark all INTC nodes as initialized

Gustavo A. R. Silva <gustavoars@kernel.org>
    net: sched: cls_u32: Fix allocation size in u32_init()

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: simple-card: fixup asoc_simple_probe() error handling

Juergen Gross <jgross@suse.com>
    x86: Fix .brk attribute in linker script

Hangyu Hua <hbh25y@gmail.com>
    rpmsg: Fix possible refcount leak in rpmsg_register_device_override()

Bjorn Andersson <quic_bjorande@quicinc.com>
    rpmsg: glink: Release driver_override

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rpmsg: Fix calling device_lock() on non-initialized device

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rpmsg: Fix kfree() of static memory on setting driver_override

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rpmsg: Constify local variable in field store macro

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    driver: platform: Add helper for safer setting of driver_override

John Sperbeck <jsperbeck@google.com>
    objtool/x86: add missing embedded_insn check

Baokun Li <libaokun1@huawei.com>
    ext4: avoid overlapping preallocations due to overflow

Baokun Li <libaokun1@huawei.com>
    ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow

Baokun Li <libaokun1@huawei.com>
    ext4: add two helper functions extent_logical_end() and pa_logical_end()

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/mm: Fix RESERVE_BRK() for older binutils

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/mm: Simplify RESERVE_BRK()

Thomas Gleixner <tglx@linutronix.de>
    x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Shailend Chand <shailend@google.com>
    gve: Fix GFP flags when allocing pages

Linus Walleij <linus.walleij@linaro.org>
    iio: afe: rescale: Accept only offset channels

Liam Beguin <liambeguin@gmail.com>
    iio: afe: rescale: add offset support

Liam Beguin <liambeguin@gmail.com>
    iio: afe: rescale: expose scale processing function

Liam Beguin <liambeguin@gmail.com>
    iio: afe: rescale: reorder includes

Alessandro Carminati <alessandro.carminati@gmail.com>
    clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name

Al Viro <viro@zeniv.linux.org.uk>
    sparc32: fix a braino in fault handling in csum_and_copy_..._user()

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix potential NULL deref

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6UL

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6SLL

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6ULL

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Clean buffers on remote invocation failures

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

Haibo Li <haibo.li@mediatek.com>
    kasan: print the original fault addr when access invalid shadow

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

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx

Hao Ge <gehao@kylinos.cn>
    firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()

Lukasz Majczak <lma@semihalf.com>
    drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Alexandru Matei <alexandru.matei@uipath.com>
    vsock/virtio: initialize the_virtio_vsock before using VQs

Stefano Garzarella <sgarzare@redhat.com>
    vsock/virtio: add support for device suspend/resume

Stefano Garzarella <sgarzare@redhat.com>
    vsock/virtio: factor our the code to initialize and delete VQs

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    drm/i915/pmu: Check if pmu is closed before stopping event

Al Viro <viro@zeniv.linux.org.uk>
    nfsd: lock_rename() needs both directories to live on the same fs

Gregory Price <gourry.memverge@gmail.com>
    mm/migrate: fix do_pages_move for compat pointers

Kemeng Shi <shikemeng@huaweicloud.com>
    mm/page_alloc: correct start page when guard page debug is enabled

Eric Auger <eric.auger@redhat.com>
    vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Maximilian Heyne <mheyne@amazon.de>
    virtio-mmio: fix memory leak of vm_dev

Gavin Shan <gshan@redhat.com>
    virtio_balloon: Fix endless deflation and inflation on arm64

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb-lpc: Reallocate memory region to avoid memory overlapping

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb: Return actual parsed size when reading chameleon table

Paolo Abeni <pabeni@redhat.com>
    mptcp: more conservative check for zero probes

Eric Dumazet <edumazet@google.com>
    tcp: cleanup tcp_remove_empty_skb() use

Eric Dumazet <edumazet@google.com>
    tcp: remove dead code from tcp_sendmsg_locked()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    pinctrl: qcom: lpass-lpi: fix concurrent register updates

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix runtime PM imbalance on remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix resource leaks on bind errors


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/powerpc/kernel/head_fsl_booke.S              |   2 +-
 arch/powerpc/kernel/setup-common.c                |   2 +
 arch/powerpc/mm/mem.c                             |   1 -
 arch/sparc/lib/checksum_32.S                      |   2 +-
 arch/x86/include/asm/i8259.h                      |   2 +
 arch/x86/include/asm/setup.h                      |  46 ++-
 arch/x86/kernel/acpi/boot.c                       |   3 +
 arch/x86/kernel/i8259.c                           |  38 +-
 arch/x86/kernel/setup.c                           |   5 -
 arch/x86/kernel/vmlinux.lds.S                     |   2 +-
 drivers/base/driver.c                             |  69 ++++
 drivers/base/platform.c                           |  28 +-
 drivers/clk/clk.c                                 |  21 +-
 drivers/dma/ste_dma40.c                           |   1 +
 drivers/firmware/imx/imx-dsp.c                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  19 +
 drivers/gpu/drm/amd/amdgpu/vi.c                   |   2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c             |   6 +-
 drivers/gpu/drm/i915/i915_pmu.c                   |   9 +
 drivers/gpu/drm/ttm/ttm_device.c                  |   8 +-
 drivers/i2c/busses/i2c-aspeed.c                   |   3 +-
 drivers/i2c/busses/i2c-stm32f7.c                  |   9 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c             |   2 +-
 drivers/i2c/muxes/i2c-mux-gpmux.c                 |   2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c               |   2 +-
 drivers/iio/adc/exynos_adc.c                      |  24 +-
 drivers/iio/adc/xilinx-xadc-core.c                |  39 +-
 drivers/iio/adc/xilinx-xadc.h                     |   2 +
 drivers/iio/afe/iio-rescale.c                     | 162 ++++++--
 drivers/input/mouse/synaptics.c                   |   1 +
 drivers/input/rmi4/rmi_smbus.c                    |  50 +--
 drivers/irqchip/irq-riscv-intc.c                  |  10 +-
 drivers/irqchip/irq-stm32-exti.c                  |   1 +
 drivers/mcb/mcb-lpc.c                             |  35 +-
 drivers/mcb/mcb-parse.c                           |  15 +-
 drivers/misc/fastrpc.c                            |  10 +-
 drivers/misc/pci_endpoint_test.c                  |   4 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c        |   2 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e.h            |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |   2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c      |   6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c      |  35 +-
 drivers/net/ethernet/realtek/r8169_main.c         |   6 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c |   2 +-
 drivers/net/gtp.c                                 |   5 +-
 drivers/net/ieee802154/adf7242.c                  |   5 +-
 drivers/net/usb/r8152.c                           |  18 +-
 drivers/net/usb/smsc95xx.c                        |   4 +-
 drivers/nvmem/imx-ocotp.c                         |   6 +-
 drivers/pci/quirks.c                              |   8 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c          |  17 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c          |  21 +-
 drivers/rpmsg/qcom_glink_native.c                 |   2 +
 drivers/rpmsg/rpmsg_core.c                        |  37 +-
 drivers/rpmsg/rpmsg_internal.h                    |   5 +-
 drivers/rpmsg/rpmsg_ns.c                          |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c              |   4 +-
 drivers/spi/spi-npcm-fiu.c                        |   5 +-
 drivers/tty/n_gsm.c                               |   2 +
 drivers/tty/serial/8250/8250_pci.c                | 327 +++++++++++++++-
 drivers/usb/gadget/legacy/raw_gadget.c            |  26 +-
 drivers/usb/storage/unusual_cypress.h             |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                     |   3 +
 drivers/vhost/vhost.c                             |   4 +-
 drivers/video/fbdev/aty/atyfb_base.c              |   4 +
 drivers/video/fbdev/uvesafb.c                     |   2 +-
 drivers/virtio/virtio_balloon.c                   |   6 +-
 drivers/virtio/virtio_mmio.c                      |  19 +-
 fs/ext4/mballoc.c                                 |  51 ++-
 fs/ext4/mballoc.h                                 |  14 +
 fs/nfsd/vfs.c                                     |  12 +-
 fs/ntfs3/attrib.c                                 |   6 +-
 fs/ntfs3/attrlist.c                               |  15 +-
 fs/ntfs3/bitmap.c                                 |   3 +-
 fs/ntfs3/dir.c                                    |   6 +-
 fs/ntfs3/frecord.c                                |   8 +-
 fs/ntfs3/fslog.c                                  |   6 +-
 fs/ntfs3/fsntfs.c                                 |  13 +-
 fs/ntfs3/super.c                                  |   2 +-
 include/linux/device/driver.h                     |   2 +
 include/linux/iio/afe/rescale.h                   |  36 ++
 include/linux/kasan.h                             |   6 +-
 include/linux/pci_ids.h                           |   1 +
 include/linux/platform_device.h                   |   6 +-
 include/linux/rpmsg.h                             |  14 +-
 include/net/tcp.h                                 |   2 +-
 include/uapi/linux/can/isotp.h                    |  25 +-
 include/uapi/linux/gtp.h                          |   2 +-
 kernel/events/core.c                              |   3 +-
 kernel/trace/trace_kprobe.c                       |   4 +-
 mm/kasan/report.c                                 |   4 +-
 mm/migrate.c                                      |  14 +-
 mm/page_alloc.c                                   |   2 +-
 net/can/isotp.c                                   | 438 ++++++++++++++--------
 net/core/neighbour.c                              |  67 ++--
 net/ipv4/tcp.c                                    |  19 +-
 net/ipv4/tcp_input.c                              |   9 +-
 net/mptcp/protocol.c                              |  12 +-
 net/netfilter/nfnetlink_log.c                     |   2 +-
 net/sched/cls_u32.c                               |   2 +-
 net/vmw_vsock/virtio_transport.c                  | 215 +++++++----
 sound/hda/intel-dsp-config.c                      |   6 +
 sound/soc/codecs/rt5645.c                         |   2 +
 sound/soc/codecs/wcd938x.c                        |  52 ++-
 sound/soc/generic/simple-card.c                   |   6 +-
 tools/objtool/check.c                             |   2 +-
 109 files changed, 1648 insertions(+), 678 deletions(-)


