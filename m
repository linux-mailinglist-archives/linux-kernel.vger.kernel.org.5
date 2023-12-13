Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA15811E34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjLMTIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjLMTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:08:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C751D46
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:08:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B4CC43391;
        Wed, 13 Dec 2023 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494483;
        bh=tqYhaVTQ35UHMEvdH6InA6wJfrMigM2dqZOUjNY18L0=;
        h=From:To:Cc:Subject:Date:From;
        b=Prw2VePgsfwiSTnjrioUaVHONLZ6P1vcP7kmcxUtKMbVX8iJIe2Qm3XETVtnwtdmY
         zNRLHy4nSvlILl/UoyZxZ/wxfA0sIOdmRu4dgzESnrhKi+BBr3N5jSSkhCscNgxH+A
         yury2ejgHy/ccOZkP2oRdtkzd/7db2nfLRs7Gdj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.143
Date:   Wed, 13 Dec 2023 20:06:03 +0100
Message-ID: <2023121303-parameter-slapstick-7ab4@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

I'm announcing the release of the 5.15.143 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-optee-devices         |    9 
 Documentation/process/howto.rst                           |    2 
 Documentation/translations/it_IT/process/howto.rst        |    2 
 Documentation/translations/ja_JP/howto.rst                |    2 
 Documentation/translations/ko_KR/howto.rst                |    2 
 Documentation/translations/zh_CN/process/howto.rst        |    2 
 Documentation/translations/zh_TW/process/howto.rst        |    2 
 Makefile                                                  |    2 
 arch/arm/boot/dts/imx28-xea.dts                           |    1 
 arch/arm/boot/dts/imx6ul-pico.dtsi                        |    2 
 arch/arm/boot/dts/imx7s.dtsi                              |    8 
 arch/arm/mach-imx/mmdc.c                                  |    7 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                 |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                 |    4 
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |    2 
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts              |    2 
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts               |    4 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                  |    2 
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts               |   50 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |    8 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            |   90 ++---
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts           |   12 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                  |  242 +++++++-------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                  |    6 
 arch/mips/Kconfig                                         |    2 
 arch/mips/include/asm/mach-loongson64/boot_param.h        |    3 
 arch/mips/loongson64/env.c                                |   10 
 arch/mips/loongson64/init.c                               |    5 
 arch/riscv/kernel/traps_misaligned.c                      |    6 
 arch/s390/mm/pgtable.c                                    |    2 
 arch/x86/kernel/cpu/amd.c                                 |    3 
 arch/x86/kvm/svm/svm.c                                    |    8 
 drivers/android/binder.c                                  |    1 
 drivers/base/devcoredump.c                                |   86 ++++
 drivers/base/regmap/regcache.c                            |    3 
 drivers/gpio/gpiolib-sysfs.c                              |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c               |   49 +-
 drivers/hwmon/acpi_power_meter.c                          |    4 
 drivers/hwmon/nzxt-kraken2.c                              |    4 
 drivers/hwtracing/coresight/coresight-etm4x-core.c        |   13 
 drivers/i2c/busses/i2c-designware-common.c                |   16 
 drivers/infiniband/core/umem.c                            |    6 
 drivers/infiniband/hw/bnxt_re/main.c                      |    2 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                |   13 
 drivers/infiniband/hw/irdma/hw.c                          |   10 
 drivers/infiniband/hw/irdma/main.c                        |    2 
 drivers/infiniband/hw/irdma/main.h                        |    2 
 drivers/infiniband/hw/irdma/verbs.c                       |   28 +
 drivers/infiniband/hw/irdma/verbs.h                       |    1 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                    |    7 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                    |   37 +-
 drivers/md/md.c                                           |  174 +++++-----
 drivers/misc/mei/client.c                                 |    4 
 drivers/net/arcnet/arcdevice.h                            |    2 
 drivers/net/arcnet/com20020-pci.c                         |   89 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c              |    1 
 drivers/net/ethernet/broadcom/tg3.c                       |   42 ++
 drivers/net/ethernet/broadcom/tg3.h                       |    4 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c         |   29 +
 drivers/net/ethernet/intel/i40e/i40e_main.c               |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c   |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c       |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c       |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c |    6 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h           |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c           |   16 
 drivers/net/ethernet/realtek/r8169_main.c                 |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c              |   45 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h              |    4 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c       |    3 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c         |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c           |    1 
 drivers/net/hyperv/Kconfig                                |    1 
 drivers/net/usb/r8152.c                                   |  110 +++---
 drivers/nvme/host/nvme.h                                  |    5 
 drivers/nvme/host/pci.c                                   |   16 
 drivers/of/dynamic.c                                      |    5 
 drivers/parport/parport_pc.c                              |   21 +
 drivers/platform/mellanox/mlxbf-bootctl.c                 |   39 +-
 drivers/platform/mellanox/mlxbf-pmc.c                     |   14 
 drivers/platform/surface/aggregator/core.c                |    5 
 drivers/platform/x86/Kconfig                              |    2 
 drivers/platform/x86/asus-nb-wmi.c                        |   46 +-
 drivers/platform/x86/asus-wmi.c                           |  118 +++---
 drivers/platform/x86/asus-wmi.h                           |   10 
 drivers/platform/x86/wmi.c                                |   56 ++-
 drivers/scsi/be2iscsi/be_main.c                           |    1 
 drivers/tee/optee/device.c                                |   17 
 drivers/tty/serial/8250/8250_early.c                      |    1 
 drivers/tty/serial/8250/8250_omap.c                       |   14 
 drivers/tty/serial/amba-pl011.c                           |  112 +++---
 drivers/tty/serial/sc16is7xx.c                            |   12 
 drivers/usb/gadget/function/f_hid.c                       |    7 
 drivers/usb/host/xhci-pci.c                               |    2 
 drivers/usb/typec/class.c                                 |    5 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                         |    7 
 fs/btrfs/disk-io.c                                        |    1 
 fs/btrfs/super.c                                          |    5 
 fs/cifs/cifsfs.c                                          |    4 
 fs/cifs/smb2ops.c                                         |    2 
 fs/nilfs2/sufile.c                                        |   42 ++
 fs/nilfs2/the_nilfs.c                                     |    6 
 include/linux/cpuhotplug.h                                |    1 
 include/linux/hrtimer.h                                   |    4 
 include/linux/kallsyms.h                                  |    7 
 include/linux/kprobes.h                                   |    7 
 include/linux/perf_event.h                                |    2 
 include/linux/platform_data/x86/asus-wmi.h                |    1 
 include/linux/stmmac.h                                    |    1 
 include/net/genetlink.h                                   |    7 
 include/rdma/ib_umem.h                                    |    9 
 include/rdma/ib_verbs.h                                   |    1 
 include/uapi/linux/perf_event.h                           |    5 
 io_uring/io_uring.c                                       |   64 ---
 kernel/cpu.c                                              |    8 
 kernel/events/core.c                                      |   80 +++-
 kernel/events/ring_buffer.c                               |    5 
 kernel/kallsyms.c                                         |    2 
 kernel/kprobes.c                                          |    4 
 kernel/time/hrtimer.c                                     |   33 -
 kernel/trace/ring_buffer.c                                |   19 -
 kernel/trace/trace.c                                      |  177 ++++------
 mm/filemap.c                                              |    2 
 net/core/drop_monitor.c                                   |    4 
 net/core/filter.c                                         |   19 +
 net/core/scm.c                                            |    6 
 net/ipv4/ip_gre.c                                         |   11 
 net/ipv4/tcp_input.c                                      |    6 
 net/ipv6/ip6_fib.c                                        |    6 
 net/netfilter/ipset/ip_set_core.c                         |   14 
 net/netfilter/nf_tables_api.c                             |    5 
 net/netfilter/nft_dynset.c                                |   13 
 net/netfilter/nft_set_pipapo.c                            |    3 
 net/netfilter/xt_owner.c                                  |   16 
 net/netlink/genetlink.c                                   |    3 
 net/packet/af_packet.c                                    |   16 
 net/packet/internal.h                                     |    2 
 net/psample/psample.c                                     |    3 
 scripts/checkstack.pl                                     |    8 
 scripts/kconfig/symbol.c                                  |   14 
 sound/core/pcm.c                                          |    1 
 sound/pci/hda/patch_realtek.c                             |    1 
 sound/soc/codecs/wm_adsp.c                                |    8 
 sound/usb/mixer_quirks.c                                  |   30 +
 tools/include/uapi/linux/perf_event.h                     |    5 
 147 files changed, 1539 insertions(+), 1045 deletions(-)

Akira Yokosawa (1):
      docs/process/howto: Replace C89 with C11

Alex Bee (1):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3399

Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

AngeloGioacchino Del Regno (3):
      arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
      arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory
      arm64: dts: mediatek: mt8183: Move thermal-zones to the root node

Armin Wolf (2):
      platform/x86: wmi: Skip blocks with zero instances
      hwmon: (acpi_power_meter) Fix 4.29 MW bug

Arnd Bergmann (1):
      ARM: PL011: Fix DMA support

Bin Li (1):
      ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Boerge Struempfel (1):
      gpiolib: sysfs: Fix error handling on failed export

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Check vendor in the AMD microcode callback

Brett Creeley (1):
      ionic: Fix dim work handling in split interrupt mode

Cameron Williams (1):
      parport: Add support for Brainboxes IX/UC/PX parallel cards

Carlos Llamas (1):
      binder: fix memory leaks of spam and pending work

Christophe JAILLET (1):
      hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()

ChunHao Lin (1):
      r8169: fix rtl8125b PAUSE frames blasting when suspended

Claudio Imbrenda (1):
      KVM: s390/mm: Properly reset no-dat

Clément Léger (1):
      riscv: fix misaligned access handling of C.SWSP and C.SDSP

Daniel Borkmann (1):
      packet: Move reference count in packet_sock to atomic_long_t

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

David Howells (1):
      cifs: Fix non-availability of dedup breaking generic/304

David Thompson (1):
      mlxbf-bootctl: correctly identify secure boot with development keys

Dinghao Liu (3):
      net: bnxt: fix a potential use-after-free in bnxt_init_tc
      ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
      scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Douglas Anderson (5):
      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
      r8152: Add RTL8152_INACCESSIBLE checks to more loops
      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()

Eric Dumazet (2):
      ipv6: fix potential NULL deref in fib6_add()
      tcp: do not accept ACK of bytes we never sent

Eugen Hristev (2):
      arm64: dts: mediatek: mt7622: fix memory node warning check
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties

Fabio Estevam (2):
      ARM: dts: imx6ul-pico: Describe the Ethernet PHY clock
      ARM: dts: imx28-xea: Pass the 'model' property

Florian Westphal (1):
      netfilter: nft_set_pipapo: skip inactive elements during set walk

Francesco Dolcini (1):
      platform/surface: aggregator: fix recv_buf() return value

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Kingston drives

Greg Kroah-Hartman (2):
      Revert "btrfs: add dmesg output for first mount and last unmount of a filesystem"
      Linux 5.15.143

Hans de Goede (4):
      platform/x86: asus-wmi: Simplify tablet-mode-switch probing
      platform/x86: asus-wmi: Simplify tablet-mode-switch handling
      platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code
      platform/x86: asus-wmi: Fix kbd_dock_devid tablet-switch reporting

Heiko Carstens (1):
      checkstack: fix printed address

Hsin-Yi Wang (1):
      arm64: dts: mt8183: kukui: Fix underscores in node names

Hugh Dickins (1):
      mm: fix oops when filemap_map_pmd() without prealloc_pte

Ido Schimmel (2):
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ivan Vecera (1):
      i40e: Fix unexpected MFS warning message

JP Kobryn (1):
      kprobes: consistent rcu api usage for kretprobe holder

Jack Wang (4):
      RDMA/rtrs-srv: Do not unconditionally enable irq
      RDMA/rtrs-clt: Start hb after path_up
      RDMA/rtrs-clt: Fix the max_send_wr setting
      RDMA/rtrs-clt: Remove the warnings for req in_use check

Jakub Kicinski (1):
      net: add missing kdoc for struct genl_multicast_group::flags

Jan Bottorff (1):
      i2c: designware: Fix corrupted memory seen in the ISR

Jason Zhang (1):
      ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Jianheng Zhang (1):
      net: stmmac: fix FPE events losing

Jiaxun Yang (2):
      MIPS: Loongson64: Reserve vgabios memory on boot
      MIPS: Loongson64: Enable DMA noncoherent support

Jiri Olsa (1):
      kallsyms: Make kallsyms_on_each_symbol generally available

John Fastabend (1):
      bpf: sockmap, updating the sg structure should also update curr

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Junxian Huang (1):
      RDMA/hns: Fix unnecessary err return when using invalid congest control algorithm

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Konstantin Aladyshev (1):
      usb: gadget: f_hid: fix report descriptor allocation

Krzysztof Kozlowski (2):
      arm64: dts: mediatek: align thermal zone node names with dtschema
      arm64: dts: mediatek: add missing space before {

Kunwu Chan (3):
      platform/mellanox: Add null pointer checks for devm_kasprintf()
      platform/mellanox: Check devm_hwmon_device_register_with_groups() return value
      ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Luca Ceresoli (1):
      of: dynamic: Fix of_reconfig_get_state_change() return value documentation

Luke D. Jones (2):
      platform/x86: asus-wmi: Adjust tablet/lidflip handling to use enum
      platform/x86: asus-wmi: Add support for ROG X13 tablet mode

Mario Limonciello (1):
      platform/x86: wmi: Allow duplicate GUIDs for drivers that use struct wmi_driver

Masahiro Yamada (1):
      kconfig: fix memory leak from range properties

Mathias Nyman (1):
      Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

Matthias Reichl (1):
      regmap: fix bogus error on regcache_sync success

Md Haris Iqbal (3):
      RDMA/rtrs-srv: Check return values while processing info request
      RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
      RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Mike Marciniszyn (1):
      RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz

Mukesh Ojha (2):
      devcoredump : Serialize devcd_del work
      devcoredump: Send uevent once devcd is ready

Mustafa Ismail (2):
      RDMA/irdma: Do not modify to SQD on error
      RDMA/irdma: Add wait for suspend on SQD

Namhyung Kim (2):
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf/core: Add a new read format to get a number of lost samples

Nathan Rossi (1):
      arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bail out on mismatching dynset and set expressions
      netfilter: nf_tables: validate family when identifying table via handle

Paulo Alcantara (1):
      smb: client: fix potential NULL deref in parse_dfs_referrals()

Pavel Begunkov (2):
      io_uring: fix mutex_unlock with unreferenced ctx
      io_uring/af_unix: disable sending io_uring over sockets

Peng Fan (1):
      arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb

Peter Zijlstra (1):
      perf: Fix perf_event_validate_size()

Petr Pavlu (3):
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a possible race when disabling buffered events

Phil Sutter (1):
      netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Philipp Zabel (1):
      ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Prike Liang (1):
      drm/amdgpu: correct the amdgpu runtime dereference usage count

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Rahul Bhansali (1):
      octeontx2-af: Update Tx link register range

Randy Dunlap (1):
      hv_netvsc: rndis_filter needs to select NLS

Ronald Wahl (3):
      serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
      serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
      serial: 8250_omap: Add earlycon support for the AM654 UART controller

Ryusuke Konishi (2):
      nilfs2: fix missing error check for sb_set_blocksize call
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Sarah Grant (1):
      ALSA: usb-audio: Add Pioneer DJM-450 mixer controls

Sean Christopherson (1):
      KVM: SVM: Update EFER software model on CR0 trap for SEV-ES

Shannon Nelson (1):
      ionic: fix snprintf format length warning

Shifeng Li (1):
      RDMA/irdma: Avoid free the non-cqp_request scratch

Shigeru Yoshida (1):
      ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c

Steve Sistare (1):
      vdpa/mlx5: preserve CVQ vringh index

Steven Rostedt (Google) (4):
      tracing: Always update snapshot buffer size
      tracing: Disable snapshot buffer when stopping instance tracers
      ring-buffer: Force absolute timestamp on discard of event
      tracing: Stop current tracer when resizing buffer

Su Hui (2):
      misc: mei: client.c: return negative error code in mei_cl_write
      misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Subbaraya Sundeep (2):
      octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
      octeontx2-af: Check return value of nix_get_nixlf before using nixlf

Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

Thomas Gleixner (1):
      hrtimers: Push pending hrtimers away from outgoing CPU earlier

Thomas Reichinger (1):
      arcnet: restoring support for multiple Sohard Arcnet cards

Uwe Kleine-König (2):
      coresight: etm4x: Make etm4_remove_dev() return void
      coresight: etm4x: Remove bogous __exit annotation for some functions

Ye Bin (1):
      md: introduce md_ro_state

Yonglong Liu (1):
      net: hns: fix fake link up on xge port

Yu Kuai (1):
      md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()

YuanShang (1):
      drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Zheng Yejian (1):
      tracing: Set actual size after ring buffer resize

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_npa_register_reporters

