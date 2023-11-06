Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BDE7E2457
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKFNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjKFNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:20:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047FF3;
        Mon,  6 Nov 2023 05:20:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6591C433C9;
        Mon,  6 Nov 2023 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276839;
        bh=BKslk4kLb4kIE6pgY6XMhUZCElFQA0qWt/pVcV+TD94=;
        h=From:To:Cc:Subject:Date:From;
        b=0E017bUZ9F7voxwyN6ev4HT5cfbnNn4EjaT4mzAsmI5TqiECZA/z6o60J/PnVNlgG
         GirgqL8e4zdO5/M8ynbs0EOV+bS05cROVVK3CHu28/NmhcVCd9bDgU1QCeqUq4PcW8
         Eqk86nkJYEWsSttiIK03rQy5YNGWHk5V2pvhVe+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 00/74] 5.4.260-rc1 review
Date:   Mon,  6 Nov 2023 14:03:20 +0100
Message-ID: <20231106130301.687882731@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.260-rc1
X-KernelTest-Deadline: 2023-11-08T13:03+00:00
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

This is the start of the stable review cycle for the 5.4.260 release.
There are 74 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.260-rc1

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Intashield IS-100

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Brainboxes UP cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for additional Brainboxes UC cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Remove UC-257 and UC-431

LihaSika <lihasika@gmail.com>
    usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Vicki Pfau <vi@endrift.com>
    PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    Revert "ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver"

Sagi Grimberg <sagi@grimberg.me>
    nvmet-tcp: Fix a possible UAF in queue intialization setup

Sagi Grimberg <sagi@grimberg.me>
    nvmet-tcp: move send/recv error handling in the send/recv methods instead of call-sites

Christoph Hellwig <hch@lst.de>
    remove the sx8 block driver

Arnd Bergmann <arnd@arndb.de>
    ata: ahci: fix enum constants for gcc-13

Su Hui <suhui@nfschina.com>
    net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Fix a warning message

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e

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

Szilard Fabian <szfabian@bluemarch.art>
    Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

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

Baokun Li <libaokun1@huawei.com>
    ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow

Baokun Li <libaokun1@huawei.com>
    ext4: avoid overlapping preallocations due to overflow

Baokun Li <libaokun1@huawei.com>
    ext4: add two helper functions extent_logical_end() and pa_logical_end()

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/mm: Fix RESERVE_BRK() for older binutils

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/mm: Simplify RESERVE_BRK()

Al Viro <viro@zeniv.linux.org.uk>
    nfsd: lock_rename() needs both directories to live on the same fs

Chao Yu <chao@kernel.org>
    f2fs: fix to do sanity check on inode type during garbage collection

Steve French <stfrench@microsoft.com>
    smbdirect: missing rc checks while waiting for rdma events

Wang Hai <wanghai38@huawei.com>
    kobject: Fix slab-out-of-bounds in fill_kobj_path()

Jinjie Ruan <ruanjinjie@huawei.com>
    arm64: fix a concurrency issue in emulation_proc_handler()

Lukasz Majczak <lma@semihalf.com>
    drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Thomas Gleixner <tglx@linutronix.de>
    x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Alessandro Carminati <alessandro.carminati@gmail.com>
    clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix potential NULL deref

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6UL

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6SLL

Peng Fan <peng.fan@nxp.com>
    nvmem: imx: correct nregs for i.MX6ULL

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

Pablo Neira Ayuso <pablo@netfilter.org>
    gtp: fix fragmentation needed check with gso

Pablo Neira Ayuso <pablo@netfilter.org>
    gtp: uapi: fix GTPA_MAX

Fred Chen <fred.chenchen03@gmail.com>
    tcp: fix wrong RTO timeout when received SACK reneging

Douglas Anderson <dianders@chromium.org>
    r8152: Cancel hw_phy_work if we have an error in probe

Douglas Anderson <dianders@chromium.org>
    r8152: Run the unload routine if we have errors during probe

Douglas Anderson <dianders@chromium.org>
    r8152: Increase USB control msg timeout to 5000ms as per spec

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

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: marvell: Ensure program page operations are successful


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |    2 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi     |    1 -
 arch/arm/boot/dts/am335x-boneblack-wireless.dts    |    1 +
 arch/arm/boot/dts/am335x-boneblue.dts              |    1 +
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts    |    1 +
 arch/arm/boot/dts/am335x-evm.dts                   |    3 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |    2 +-
 arch/arm/boot/dts/am335x-lxm.dts                   |    2 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi  |    2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     |    2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |    4 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |    2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |    6 +-
 arch/arm/boot/dts/am33xx.dtsi                      |    3 +-
 arch/arm/boot/dts/am4372.dtsi                      |    3 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |    2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |    4 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |    5 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |    2 +-
 arch/arm64/kernel/armv8_deprecated.c               |    6 +-
 arch/x86/include/asm/i8259.h                       |    2 +
 arch/x86/include/asm/setup.h                       |   46 +-
 arch/x86/kernel/acpi/boot.c                        |    3 +
 arch/x86/kernel/i8259.c                            |   38 +-
 arch/x86/kernel/vmlinux.lds.S                      |    2 +-
 drivers/ata/ahci.h                                 |  241 +--
 drivers/base/driver.c                              |   69 +
 drivers/base/platform.c                            |   28 +-
 drivers/block/Kconfig                              |    9 -
 drivers/block/Makefile                             |    2 -
 drivers/block/sx8.c                                | 1586 --------------------
 drivers/clk/clk.c                                  |   21 +-
 drivers/dma/ste_dma40.c                            |    1 +
 drivers/gpu/drm/drm_dp_mst_topology.c              |    6 +-
 drivers/i2c/busses/i2c-aspeed.c                    |    3 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |    9 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |    2 +-
 drivers/i2c/muxes/i2c-mux-gpmux.c                  |    2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |    2 +-
 drivers/iio/adc/exynos_adc.c                       |   24 +-
 drivers/input/mouse/synaptics.c                    |    1 +
 drivers/input/rmi4/rmi_smbus.c                     |   50 +-
 drivers/input/serio/i8042-x86ia64io.h              |    8 +
 drivers/irqchip/irq-stm32-exti.c                   |    1 +
 drivers/mcb/mcb-lpc.c                              |   35 +-
 drivers/mcb/mcb-parse.c                            |   15 +-
 drivers/mtd/nand/raw/marvell_nand.c                |   23 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    2 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   35 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    4 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |    2 +-
 drivers/net/gtp.c                                  |    5 +-
 drivers/net/ieee802154/adf7242.c                   |    5 +-
 drivers/net/usb/r8152.c                            |   10 +-
 drivers/nvme/target/tcp.c                          |   50 +-
 drivers/nvmem/imx-ocotp.c                          |    6 +-
 drivers/pci/quirks.c                               |    8 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |   21 +-
 drivers/platform/x86/asus-wmi.h                    |    2 +-
 drivers/rpmsg/qcom_glink_native.c                  |    1 +
 drivers/rpmsg/rpmsg_core.c                         |   37 +-
 drivers/rpmsg/rpmsg_internal.h                     |    5 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    4 +-
 drivers/spi/spi-npcm-fiu.c                         |    5 +-
 drivers/tty/serial/8250/8250_pci.c                 |  122 +-
 drivers/usb/storage/unusual_cypress.h              |    2 +-
 drivers/video/fbdev/aty/atyfb_base.c               |    4 +
 drivers/video/fbdev/uvesafb.c                      |    2 +-
 drivers/virtio/virtio_balloon.c                    |    6 +-
 drivers/virtio/virtio_mmio.c                       |   19 +-
 fs/cifs/smbdirect.c                                |   14 +-
 fs/ext4/mballoc.c                                  |   51 +-
 fs/ext4/mballoc.h                                  |   14 +
 fs/f2fs/gc.c                                       |    3 +-
 fs/nfsd/vfs.c                                      |   12 +-
 include/linux/device.h                             |    2 +
 include/linux/pci_ids.h                            |    1 +
 include/linux/platform_device.h                    |    6 +-
 include/linux/rpmsg.h                              |   14 +-
 include/uapi/linux/gtp.h                           |    2 +-
 kernel/events/core.c                               |    3 +-
 lib/kobject.c                                      |   12 +-
 net/core/neighbour.c                               |   67 +-
 net/ipv4/tcp_input.c                               |    9 +-
 net/netfilter/nfnetlink_log.c                      |    2 +-
 sound/soc/codecs/rt5645.c                          |    2 +
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |   13 +
 90 files changed, 850 insertions(+), 2029 deletions(-)


