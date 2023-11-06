Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1397E22DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjKFNGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKFNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:06:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0884BF;
        Mon,  6 Nov 2023 05:06:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB382C433C7;
        Mon,  6 Nov 2023 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275975;
        bh=WXuxPgXy8LQmO8VLBdhhMhGxOJhijd/UZE8/NmcYXJo=;
        h=From:To:Cc:Subject:Date:From;
        b=Pg3gMGRDiPxMK3NVp18IZZJN82RitqH2IeHPgAVTqLJ5HVbo2mAndyzJkM02CH5Nh
         ql/ScZKsecPypcIFJWQ/6Tfch+9CYOHmAoGPPuDOQri6UpDSIfqfTibfIImFoNKWZW
         yxtPWZiqBMFIdUbONNR9qgnoQ7TL1+5jbdL467rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 00/48] 4.14.329-rc1 review
Date:   Mon,  6 Nov 2023 14:02:51 +0100
Message-ID: <20231106130257.862199836@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.329-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.329-rc1
X-KernelTest-Deadline: 2023-11-08T13:02+00:00
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

This is the start of the stable review cycle for the 4.14.329 release.
There are 48 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.329-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.329-rc1

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

George Kennedy <george.kennedy@oracle.com>
    vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF

Christoph Hellwig <hch@lst.de>
    remove the sx8 block driver

Arnd Bergmann <arnd@arndb.de>
    ata: ahci: fix enum constants for gcc-13

Su Hui <suhui@nfschina.com>
    net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

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

Arnd Bergmann <arnd@arndb.de>
    fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Zhang Shurong <zhang_shurong@foxmail.com>
    dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    irqchip/stm32-exti: add missing DT IRQ flag translation

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
    driver: platform: Add helper for safer setting of driver_override

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/mm: Fix RESERVE_BRK() for older binutils

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/mm: Simplify RESERVE_BRK()

Thomas Gleixner <tglx@linutronix.de>
    x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Al Viro <viro@zeniv.linux.org.uk>
    nfsd: lock_rename() needs both directories to live on the same fs

Chao Yu <chao@kernel.org>
    f2fs: fix to do sanity check on inode type during garbage collection

Wang Hai <wanghai38@huawei.com>
    kobject: Fix slab-out-of-bounds in fill_kobj_path()

Lukasz Majczak <lma@semihalf.com>
    drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Nick Desaulniers <ndesaulniers@google.com>
    ARM: 8933/1: replace Sun/Solaris style flag on section directive

Trond Myklebust <trondmy@gmail.com>
    NFS: Don't call generic_error_remove_page() while holding locks

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix potential NULL deref

Herve Codina <herve.codina@bootlin.com>
    i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()

Herve Codina <herve.codina@bootlin.com>
    i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()

Herve Codina <herve.codina@bootlin.com>
    i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Pablo Neira Ayuso <pablo@netfilter.org>
    gtp: uapi: fix GTPA_MAX

Fred Chen <fred.chenchen03@gmail.com>
    tcp: fix wrong RTO timeout when received SACK reneging

Douglas Anderson <dianders@chromium.org>
    r8152: Increase USB control msg timeout to 5000ms as per spec

Mateusz Palczewski <mateusz.palczewski@intel.com>
    igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Kunwu Chan <chentao@kylinos.cn>
    treewide: Spelling fix in comment

Gavin Shan <gshan@redhat.com>
    virtio_balloon: Fix endless deflation and inflation on arm64

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb-lpc: Reallocate memory region to avoid memory overlapping

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb: Return actual parsed size when reading chameleon table


-------------

Diffstat:

 Makefile                                          |    4 +-
 arch/arm/boot/bootp/init.S                        |    2 +-
 arch/arm/boot/compressed/big-endian.S             |    2 +-
 arch/arm/boot/compressed/head.S                   |    2 +-
 arch/arm/boot/compressed/piggy.S                  |    2 +-
 arch/arm/mm/proc-arm1020.S                        |    2 +-
 arch/arm/mm/proc-arm1020e.S                       |    2 +-
 arch/arm/mm/proc-arm1022.S                        |    2 +-
 arch/arm/mm/proc-arm1026.S                        |    2 +-
 arch/arm/mm/proc-arm720.S                         |    2 +-
 arch/arm/mm/proc-arm740.S                         |    2 +-
 arch/arm/mm/proc-arm7tdmi.S                       |    2 +-
 arch/arm/mm/proc-arm920.S                         |    2 +-
 arch/arm/mm/proc-arm922.S                         |    2 +-
 arch/arm/mm/proc-arm925.S                         |    2 +-
 arch/arm/mm/proc-arm926.S                         |    2 +-
 arch/arm/mm/proc-arm940.S                         |    2 +-
 arch/arm/mm/proc-arm946.S                         |    2 +-
 arch/arm/mm/proc-arm9tdmi.S                       |    2 +-
 arch/arm/mm/proc-fa526.S                          |    2 +-
 arch/arm/mm/proc-feroceon.S                       |    2 +-
 arch/arm/mm/proc-mohawk.S                         |    2 +-
 arch/arm/mm/proc-sa110.S                          |    2 +-
 arch/arm/mm/proc-sa1100.S                         |    2 +-
 arch/arm/mm/proc-v6.S                             |    2 +-
 arch/arm/mm/proc-v7.S                             |    2 +-
 arch/arm/mm/proc-v7m.S                            |    4 +-
 arch/arm/mm/proc-xsc3.S                           |    2 +-
 arch/arm/mm/proc-xscale.S                         |    2 +-
 arch/x86/include/asm/i8259.h                      |    2 +
 arch/x86/include/asm/setup.h                      |   46 +-
 arch/x86/kernel/acpi/boot.c                       |    3 +
 arch/x86/kernel/i8259.c                           |   38 +-
 arch/x86/kernel/vmlinux.lds.S                     |    2 +-
 drivers/ata/ahci.h                                |  226 +--
 drivers/base/driver.c                             |   69 +
 drivers/base/platform.c                           |   28 +-
 drivers/block/Kconfig                             |    9 -
 drivers/block/Makefile                            |    2 -
 drivers/block/sx8.c                               | 1746 ---------------------
 drivers/dma/ste_dma40.c                           |    1 +
 drivers/gpu/drm/drm_dp_mst_topology.c             |    6 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c             |    2 +-
 drivers/i2c/muxes/i2c-mux-gpmux.c                 |    2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c               |    2 +-
 drivers/input/mouse/synaptics.c                   |    1 +
 drivers/input/rmi4/rmi_smbus.c                    |   50 +-
 drivers/irqchip/irq-stm32-exti.c                  |    1 +
 drivers/mcb/mcb-lpc.c                             |   35 +-
 drivers/mcb/mcb-parse.c                           |   15 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c        |    2 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c      |    6 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c |    2 +-
 drivers/net/usb/r8152.c                           |    7 +-
 drivers/pci/quirks.c                              |    9 +-
 drivers/platform/x86/asus-wmi.h                   |    2 +-
 drivers/rpmsg/qcom_glink_native.c                 |    1 +
 drivers/rpmsg/rpmsg_core.c                        |   34 +-
 drivers/rpmsg/rpmsg_internal.h                    |    5 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c              |    4 +-
 drivers/tty/serial/8250/8250_pci.c                |  122 +-
 drivers/tty/vt/vc_screen.c                        |    9 +-
 drivers/usb/storage/unusual_cypress.h             |    2 +-
 drivers/video/fbdev/aty/atyfb_base.c              |    4 +
 drivers/video/fbdev/uvesafb.c                     |    2 +-
 drivers/virtio/virtio_balloon.c                   |    6 +-
 fs/f2fs/gc.c                                      |    3 +-
 fs/nfs/write.c                                    |    3 +-
 fs/nfsd/vfs.c                                     |   12 +-
 include/linux/device.h                            |    2 +
 include/linux/pci_ids.h                           |    1 +
 include/linux/platform_device.h                   |    6 +-
 include/linux/rpmsg.h                             |   14 +-
 include/uapi/linux/gtp.h                          |    2 +-
 kernel/events/core.c                              |    3 +-
 lib/kobject.c                                     |   12 +-
 net/ipv4/tcp_input.c                              |    9 +-
 net/netfilter/nfnetlink_log.c                     |    2 +-
 sound/soc/codecs/rt5645.c                         |    2 +
 sound/soc/generic/simple-card.c                   |    6 +-
 81 files changed, 598 insertions(+), 2046 deletions(-)


