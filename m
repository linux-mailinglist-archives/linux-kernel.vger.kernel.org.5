Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC17E49CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjKGUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjKGUZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19410C9;
        Tue,  7 Nov 2023 12:25:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69E9C433C8;
        Tue,  7 Nov 2023 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699388701;
        bh=5Ce80YGpw/+XQjGc7BmPiSkUhe9XorkDcnRQ+RaDV7A=;
        h=From:To:Cc:Subject:Date:From;
        b=0He6jD3ICugiSmadvz5+0cUi4Cyn6BTf9I1bl51UA90LdY9y/zRWg+h2ypYHvaN8p
         bwgInJfHSbsFHwtZcKjVNDRb1R8a813kJvKthxfahhFmWFntbdSxh2oz/YoHe/MV01
         MPr6OhU76382IfL+w2lr9sseQ79la3SfbSOFtuiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.10 00/91] 5.10.200-rc2 review
Date:   Tue,  7 Nov 2023 21:24:57 +0100
Message-ID: <20231107202447.670990820@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.200-rc2
X-KernelTest-Deadline: 2023-11-09T20:24+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.10.200 release.
There are 91 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 09 Nov 2023 20:24:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.200-rc2

Mark Hasemeyer <markhas@chromium.org>
    ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Intashield IS-100

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Brainboxes UP cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for additional Brainboxes UC cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Remove UC-257 and UC-431

Andrey Konovalov <andreyknvl@gmail.com>
    usb: raw-gadget: properly handle interrupted requests

LihaSika <lihasika@gmail.com>
    usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Vicki Pfau <vi@endrift.com>
    PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Lukas Magel <lukas.magel@posteo.net>
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

Patrick Menschel <menschel.p@posteo.de>
    can: isotp: Add error message if txqueuelen is too small

Patrick Menschel <menschel.p@posteo.de>
    can: isotp: add symbolic error message to isotp_module_init()

Patrick Menschel <menschel.p@posteo.de>
    can: isotp: change error format from decimal to symbolic error names

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix boot crash with FLATMEM

Su Hui <suhui@nfschina.com>
    net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Fix a warning message

Tomas Henzl <thenzl@redhat.com>
    scsi: mpt3sas: Fix in error path

Jorge Maidana <jorgem.linux@gmail.com>
    fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5650: fix the wrong result of key button

Florian Westphal <fw@strlen.de>
    netfilter: nfnetlink_log: silence bogus compiler warning

William A. Kennington III <william@wkennington.com>
    spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0

Arnd Bergmann <arnd@arndb.de>
    fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Zhang Shurong <zhang_shurong@foxmail.com>
    dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    irqchip/stm32-exti: add missing DT IRQ flag translation

Gustavo A. R. Silva <gustavoars@kernel.org>
    net: sched: cls_u32: Fix allocation size in u32_init()

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

Chao Yu <chao@kernel.org>
    f2fs: fix to do sanity check on inode type during garbage collection

Steve French <stfrench@microsoft.com>
    smbdirect: missing rc checks while waiting for rdma events

Wang Hai <wanghai38@huawei.com>
    kobject: Fix slab-out-of-bounds in fill_kobj_path()

Thomas Gleixner <tglx@linutronix.de>
    x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Robert Hancock <robert.hancock@calian.com>
    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    iio: adc: xilinx: use more devres helpers and remove remove()

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    iio: adc: xilinx: use helper variable for &pdev->dev

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

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1

Lukasz Majczak <lma@semihalf.com>
    drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: renesas_sdhi: use custom mask for TMIO_MASK_ALL

Kemeng Shi <shikemeng@huaweicloud.com>
    mm/page_alloc: correct start page when guard page debug is enabled

Maximilian Heyne <mheyne@amazon.de>
    virtio-mmio: fix memory leak of vm_dev

Gavin Shan <gshan@redhat.com>
    virtio_balloon: Fix endless deflation and inflation on arm64

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb-lpc: Reallocate memory region to avoid memory overlapping

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb: Return actual parsed size when reading chameleon table

Francis Laniel <flaniel@linux.microsoft.com>
    selftests/ftrace: Add new test case which checks non unique symbol


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/powerpc/kernel/setup-common.c                 |   2 +
 arch/powerpc/mm/mem.c                              |   1 -
 arch/sparc/lib/checksum_32.S                       |   2 +-
 arch/x86/include/asm/i8259.h                       |   2 +
 arch/x86/include/asm/setup.h                       |  46 +--
 arch/x86/kernel/acpi/boot.c                        |   3 +
 arch/x86/kernel/i8259.c                            |  38 +-
 arch/x86/kernel/setup.c                            |   5 -
 arch/x86/kernel/vmlinux.lds.S                      |   2 +-
 drivers/base/driver.c                              |  69 ++++
 drivers/base/platform.c                            |  28 +-
 drivers/clk/clk.c                                  |  21 +-
 drivers/dma/ste_dma40.c                            |   1 +
 drivers/gpu/drm/drm_dp_mst_topology.c              |   6 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   3 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |   9 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   2 +-
 drivers/i2c/muxes/i2c-mux-gpmux.c                  |   2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |   2 +-
 drivers/iio/adc/exynos_adc.c                       |  24 +-
 drivers/iio/adc/xilinx-xadc-core.c                 | 179 ++++-----
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/rmi4/rmi_smbus.c                     |  50 ++-
 drivers/irqchip/irq-stm32-exti.c                   |   1 +
 drivers/mcb/mcb-lpc.c                              |  35 +-
 drivers/mcb/mcb-parse.c                            |  15 +-
 drivers/misc/fastrpc.c                             |  10 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   3 +-
 drivers/mmc/host/tmio_mmc.h                        |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   2 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  35 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   4 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |   2 +-
 drivers/net/gtp.c                                  |   5 +-
 drivers/net/ieee802154/adf7242.c                   |   5 +-
 drivers/net/usb/r8152.c                            |  11 +-
 drivers/net/usb/smsc95xx.c                         |   4 +-
 drivers/nvmem/imx-ocotp.c                          |   6 +-
 drivers/pci/quirks.c                               |   8 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  21 +-
 drivers/rpmsg/qcom_glink_native.c                  |   2 +
 drivers/rpmsg/rpmsg_core.c                         |  37 +-
 drivers/rpmsg/rpmsg_internal.h                     |   5 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   4 +-
 drivers/spi/spi-npcm-fiu.c                         |   5 +-
 drivers/tty/serial/8250/8250_pci.c                 | 122 +++++-
 drivers/usb/gadget/legacy/raw_gadget.c             |  26 +-
 drivers/usb/storage/unusual_cypress.h              |   2 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   4 +
 drivers/video/fbdev/uvesafb.c                      |   2 +-
 drivers/virtio/virtio_balloon.c                    |   6 +-
 drivers/virtio/virtio_mmio.c                       |  19 +-
 fs/cifs/smbdirect.c                                |  14 +-
 fs/ext4/mballoc.c                                  |  51 +--
 fs/ext4/mballoc.h                                  |  14 +
 fs/f2fs/gc.c                                       |   3 +-
 include/linux/device/driver.h                      |   2 +
 include/linux/kasan.h                              |   6 +-
 include/linux/pci_ids.h                            |   1 +
 include/linux/platform_device.h                    |   6 +-
 include/linux/rpmsg.h                              |  14 +-
 include/uapi/linux/can/isotp.h                     |  25 +-
 include/uapi/linux/gtp.h                           |   2 +-
 kernel/events/core.c                               |   3 +-
 kernel/trace/trace_kprobe.c                        |   4 +-
 lib/kobject.c                                      |  12 +-
 mm/kasan/report.c                                  |   4 +-
 mm/page_alloc.c                                    |   2 +-
 net/can/isotp.c                                    | 446 +++++++++++++--------
 net/core/neighbour.c                               |  67 ++--
 net/ipv4/tcp_input.c                               |   9 +-
 net/netfilter/nfnetlink_log.c                      |   2 +-
 net/sched/cls_u32.c                                |   2 +-
 sound/hda/intel-dsp-config.c                       |   6 +
 sound/soc/codecs/rt5645.c                          |   2 +
 tools/objtool/check.c                              |   2 +-
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |  13 +
 80 files changed, 1053 insertions(+), 572 deletions(-)


