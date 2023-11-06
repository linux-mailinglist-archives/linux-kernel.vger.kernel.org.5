Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2C7E23EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjKFNQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjKFNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:16:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C799191;
        Mon,  6 Nov 2023 05:16:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55684C433C9;
        Mon,  6 Nov 2023 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276559;
        bh=Y/O9oGnNwtMM6cMZAPVaPhduIL1oYFmH37JCbbejSUE=;
        h=From:To:Cc:Subject:Date:From;
        b=lmwx5yuBxbXZioykne21VSuO3NBIUUV89fjTi3sgcT5zgcyBqnf4IUGyxSCmcTtc3
         4Nh+upMXizmzX6aGrssjy8kVWzGmv7ES5DH87HMVCSUpGqVorgZ5XkjEOdw7ouOJPW
         vNnMCgwEW1TdN66+HgiOyZ9lbh8ly6PCjZSHZn+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 00/88] 6.5.11-rc1 review
Date:   Mon,  6 Nov 2023 14:02:54 +0100
Message-ID: <20231106130305.772449722@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.11-rc1
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

This is the start of the stable review cycle for the 6.5.11 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.11-rc1

Mark Hasemeyer <markhas@chromium.org>
    ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Mark Hasemeyer <markhas@chromium.org>
    ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection

Tony Lindgren <tony@atomide.com>
    serial: core: Fix runtime PM handling for pending tx

Siddharth Vadapalli <s-vadapalli@ti.com>
    misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Francesco Dolcini <francesco.dolcini@toradex.com>
    dt-bindings: serial: rs485: Add rs485-rts-active-high

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

Janne Grunau <j@jannau.net>
    Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

Andrey Konovalov <andreyknvl@gmail.com>
    usb: raw-gadget: properly handle interrupted requests

Jimmy Hu <hhhuuu@google.com>
    usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: tcpm: Add additional checks for contaminant

LihaSika <lihasika@gmail.com>
    usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Vicki Pfau <vi@endrift.com>
    PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Max McCarthy <mmccarthy@mcintoshlabs.com>
    ALSA: usb-audio: add quirk flag to enable native DSD for McIntosh devices

Liam R. Howlett <Liam.Howlett@oracle.com>
    mmap: fix error paths with dup_anon_vma()

Liam R. Howlett <Liam.Howlett@oracle.com>
    mmap: fix vma_iterator in error path of vma_merge()

Ian Rogers <irogers@google.com>
    perf evlist: Avoid frequency mode for the dummy event

Kai-Heng Feng <kai.heng.feng@canonical.com>
    power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint

Benno Lossin <benno.lossin@proton.me>
    rust: types: make `Opaque` be `!Unpin`

Alice Ryhl <aliceryhl@google.com>
    rust: make `UnsafeCell` the outer type in `Opaque`

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Don't use fsleep for PSR exit waits

Al Viro <viro@zeniv.linux.org.uk>
    ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lock

Al Viro <viro@zeniv.linux.org.uk>
    io_uring: kiocb_done() should *not* trust ->ki_pos if ->{read,write}_iter() failed

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix boot crash with FLATMEM

Douglas Anderson <dianders@chromium.org>
    r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()

Douglas Anderson <dianders@chromium.org>
    r8152: Check for unplug in rtl_phy_patch_request()

Su Hui <suhui@nfschina.com>
    net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Jisheng Zhang <jszhang@kernel.org>
    riscv: dts: thead: set dma-noncoherent to soc bus

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Reserve fences for VM update

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Fix a warning message

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: audit log object reset once per table

Icenowy Zheng <uwu@icenowy.me>
    LoongArch: Disable WUC for pgprot_writecombine() like ioremap_wc()

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Export symbol invalid_pud_table for modules building

Tiezhu Yang <yangtiezhu@loongson.cn>
    LoongArch: Use SYM_CODE_* to annotate exception handlers

Luben Tuikov <luben.tuikov@amd.com>
    gpu/drm: Eliminate DRM_SCHED_PRIORITY_UNSET

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Unset context priority is now invalid

David Rau <David.Rau.opensource@dm.renesas.com>
    ASoC: da7219: Correct the process of setting up Gnd switch in AAD

Tomas Henzl <thenzl@redhat.com>
    scsi: mpt3sas: Fix in error path

Jorge Maidana <jorgem.linux@gmail.com>
    fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Dan Carpenter <dan.carpenter@linaro.org>
    fbdev: omapfb: fix some error codes

Karolina Stolarek <karolina.stolarek@intel.com>
    drm/ttm: Reorder sys manager cleanup step

Vasily Gorbik <gor@linux.ibm.com>
    s390/kasan: handle DCSS mapping in memory holes

Roy Chateau <roy.chateau@mep-info.com>
    ASoC: codecs: tas2780: Fix log of failed reset via I2C.

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5650: fix the wrong result of key button

Kuan-Wei Chiu <visitorckw@gmail.com>
    efi: fix memory leak in krealloc failure handling

Nikolay Borisov <nik.borisov@suse.com>
    x86/efistub: Don't try to print after ExitBootService()

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5: Bridge, fix peer entry ageing in LAG mode

Florian Westphal <fw@strlen.de>
    netfilter: nfnetlink_log: silence bogus compiler warning

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: soc-dapm: Add helper for comparing widget name

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
    fs/ntfs3: Do not allow to change label if volume is read-only

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Fix alternative boot searching

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add more attributes checks in mi_enum_attr()

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

Ondrej Jirman <megi@xff.cz>
    media: i2c: ov8858: Don't set fwnode in the driver

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/85xx: Fix math emulation exception

Ondrej Zary <linux@zary.sk>
    ata: pata_parport: fit3: implement IDE command set registers

Ondrej Zary <linux@zary.sk>
    ata: pata_parport: add custom version of wait_after_reset

Zhang Shurong <zhang_shurong@foxmail.com>
    dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    irqchip/stm32-exti: add missing DT IRQ flag translation

Anup Patel <apatel@ventanamicro.com>
    irqchip/riscv-intc: Mark all INTC nodes as initialized

Haibo Chen <haibo.chen@nxp.com>
    can: flexcan: remove the auto stop mode for IMX93

Haibo Chen <haibo.chen@nxp.com>
    arm64: dts: imx93: add the Flex-CAN stop mode by GPR

Gustavo A. R. Silva <gustavoars@kernel.org>
    net: sched: cls_u32: Fix allocation size in u32_init()

Antoine Gennart <gennartan@disroot.org>
    ASoC: tlv320adc3xxx: BUG: Correct micbias setting

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: core: Do not call link_exit() on uninitialized rtd objects

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl-asoc-card: use integer type for fll_id and pll_id

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: tmc-etr: Disable warnings for allocation failures

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: simple-card: fixup asoc_simple_probe() error handling

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: sof_sdw: add support for SKU 0B14


-------------

Diffstat:

 .../devicetree/bindings/serial/rs485.yaml          |   4 +
 Makefile                                           |   4 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   4 +-
 arch/loongarch/include/asm/io.h                    |   5 +-
 arch/loongarch/include/asm/linkage.h               |   8 +
 arch/loongarch/include/asm/pgtable-bits.h          |   4 +-
 arch/loongarch/kernel/entry.S                      |   4 +-
 arch/loongarch/kernel/genex.S                      |  16 +-
 arch/loongarch/kernel/setup.c                      |  10 +-
 arch/loongarch/mm/init.c                           |   9 +-
 arch/loongarch/mm/tlbex.S                          |  36 +--
 arch/powerpc/kernel/head_85xx.S                    |   2 +-
 arch/powerpc/kernel/setup-common.c                 |   2 +
 arch/powerpc/mm/mem.c                              |   1 -
 arch/riscv/boot/dts/thead/th1520.dtsi              |   1 +
 arch/s390/boot/vmem.c                              |   7 +-
 drivers/ata/pata_parport/fit3.c                    |  14 +-
 drivers/ata/pata_parport/pata_parport.c            |  68 ++++-
 drivers/bluetooth/hci_bcm4377.c                    |   5 +
 drivers/dma/ste_dma40.c                            |   1 +
 drivers/firmware/efi/efi.c                         |   8 +-
 drivers/firmware/efi/libstub/x86-stub.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   5 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |   3 +-
 drivers/gpu/drm/ttm/ttm_device.c                   |   8 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   3 +-
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/rmi4/rmi_smbus.c                     |  50 ++--
 drivers/irqchip/irq-riscv-intc.c                   |  10 +-
 drivers/irqchip/irq-stm32-exti.c                   |   1 +
 drivers/media/i2c/ov8858.c                         |  10 +-
 drivers/misc/pci_endpoint_test.c                   |   4 +
 drivers/net/can/flexcan/flexcan-core.c             |  46 +--
 drivers/net/can/flexcan/flexcan.h                  |   2 -
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   2 +
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |  11 +
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  25 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.h   |   3 +
 .../ethernet/mellanox/mlx5/core/esw/bridge_priv.h  |   1 +
 drivers/net/usb/r8152.c                            |   7 +
 drivers/pci/quirks.c                               |   8 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  21 +-
 drivers/power/supply/power_supply_core.c           |   8 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   4 +-
 drivers/spi/spi-npcm-fiu.c                         |   5 +-
 drivers/tty/n_gsm.c                                |   2 +
 drivers/tty/serial/8250/8250_pci.c                 | 327 ++++++++++++++++++++-
 drivers/tty/serial/serial_core.c                   |   2 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |  26 +-
 drivers/usb/storage/unusual_cypress.h              |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   5 +
 drivers/video/fbdev/aty/atyfb_base.c               |   4 +
 drivers/video/fbdev/omap/omapfb_main.c             |   4 +-
 drivers/video/fbdev/uvesafb.c                      |   2 +-
 fs/ceph/mds_client.c                               |   2 +-
 fs/ntfs3/attrib.c                                  |   6 +-
 fs/ntfs3/attrlist.c                                |  15 +-
 fs/ntfs3/bitmap.c                                  |   3 +-
 fs/ntfs3/dir.c                                     |   6 +-
 fs/ntfs3/frecord.c                                 |   8 +-
 fs/ntfs3/fslog.c                                   |   6 +-
 fs/ntfs3/fsntfs.c                                  |  13 +-
 fs/ntfs3/record.c                                  |  68 ++++-
 fs/ntfs3/super.c                                   |  33 ++-
 include/drm/gpu_scheduler.h                        |   3 +-
 include/linux/pci_ids.h                            |   1 +
 include/linux/power_supply.h                       |   2 +-
 include/sound/soc-dapm.h                           |   1 +
 include/sound/soc.h                                |   2 +
 io_uring/rw.c                                      |   2 +-
 mm/mmap.c                                          |  40 ++-
 net/netfilter/nf_tables_api.c                      |  50 ++--
 net/netfilter/nfnetlink_log.c                      |   2 +-
 net/sched/cls_u32.c                                |   2 +-
 rust/kernel/types.rs                               |  21 +-
 sound/hda/intel-dsp-config.c                       |   6 +
 sound/soc/codecs/da7219-aad.c                      |  11 +-
 sound/soc/codecs/rt5645.c                          |   2 +
 sound/soc/codecs/tas2780.c                         |   2 +-
 sound/soc/codecs/tlv320adc3xxx.c                   |   4 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  12 +-
 sound/soc/generic/simple-card.c                    |   6 +-
 sound/soc/intel/boards/sof_sdw.c                   |  10 +
 sound/soc/soc-component.c                          |   1 +
 sound/soc/soc-core.c                               |  20 +-
 sound/soc/soc-dapm.c                               |  12 +
 sound/soc/sof/sof-pci-dev.c                        |   7 +
 sound/usb/quirks.c                                 |   2 +
 tools/perf/util/evlist.c                           |   5 +-
 tools/testing/selftests/netfilter/nft_audit.sh     |  46 +++
 92 files changed, 973 insertions(+), 297 deletions(-)


