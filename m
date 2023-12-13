Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0D811E30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjLMTIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjLMTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:08:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B46D187
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:07:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D74C433CB;
        Wed, 13 Dec 2023 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494478;
        bh=4Kn0P/l6SJj9mUoUTstG8tZ6XDp19bnjnKqBUdSeM20=;
        h=From:To:Cc:Subject:Date:From;
        b=S3WtQA8mThKw9zY2LsEMKjqUUSL1fJReh1EkoYjjLHw5JAYRZo87IzGij+gVhkwvr
         pelfEEhEji7xCVFOV/bKyUiTyyjpIU00dU2b3AVTcUI+9UY3WpqVCrWrK796+FcMVr
         56mm0XelpPHhFlZU/8uY0caqCD8AveIKrbi/ANPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.204
Date:   Wed, 13 Dec 2023 20:05:55 +0100
Message-ID: <2023121355-compel-nervy-1208@gregkh>
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

I'm announcing the release of the 5.10.204 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-optee-devices         |    9 
 Documentation/ABI/testing/sysfs-platform-asus-wmi         |    9 
 Makefile                                                  |    2 
 arch/arm/boot/dts/imx7s.dtsi                              |    8 
 arch/arm/mach-imx/mmdc.c                                  |    7 
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |    2 
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts              |    2 
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts               |    4 
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts               |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            |    2 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                  |    6 
 arch/mips/Kconfig                                         |    2 
 arch/mips/include/asm/mach-loongson64/boot_param.h        |    3 
 arch/mips/loongson64/env.c                                |   10 
 arch/mips/loongson64/init.c                               |    5 
 arch/riscv/kernel/traps_misaligned.c                      |    6 
 arch/s390/mm/pgtable.c                                    |    2 
 arch/x86/kernel/cpu/amd.c                                 |    3 
 drivers/base/devcoredump.c                                |   86 +++
 drivers/gpio/gpiolib-sysfs.c                              |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c               |   10 
 drivers/hwmon/acpi_power_meter.c                          |    4 
 drivers/i2c/busses/i2c-designware-common.c                |   16 
 drivers/infiniband/hw/bnxt_re/main.c                      |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                    |    2 
 drivers/misc/mei/client.c                                 |    4 
 drivers/mmc/core/core.c                                   |    2 
 drivers/mmc/core/mmc_ops.c                                |    3 
 drivers/mmc/core/mmc_ops.h                                |    1 
 drivers/net/arcnet/arcdevice.h                            |    2 
 drivers/net/arcnet/com20020-pci.c                         |  117 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c              |    1 
 drivers/net/ethernet/broadcom/tg3.c                       |   42 +
 drivers/net/ethernet/broadcom/tg3.h                       |    4 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c         |   29 +
 drivers/net/ethernet/intel/i40e/i40e_main.c               |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c |    6 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h           |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c           |   16 
 drivers/net/ethernet/realtek/r8169_main.c                 |    7 
 drivers/net/hyperv/Kconfig                                |    1 
 drivers/of/base.c                                         |  328 +++++++-------
 drivers/of/dynamic.c                                      |   22 
 drivers/of/fdt.c                                          |   17 
 drivers/of/irq.c                                          |   14 
 drivers/of/overlay.c                                      |   16 
 drivers/of/platform.c                                     |   10 
 drivers/of/property.c                                     |   66 +-
 drivers/parport/parport_pc.c                              |   21 
 drivers/platform/mellanox/mlxbf-bootctl.c                 |   39 +
 drivers/platform/x86/Kconfig                              |    2 
 drivers/platform/x86/asus-nb-wmi.c                        |   57 +-
 drivers/platform/x86/asus-wmi.c                           |  194 +++++++-
 drivers/platform/x86/asus-wmi.h                           |    9 
 drivers/scsi/be2iscsi/be_main.c                           |    1 
 drivers/tee/optee/device.c                                |   17 
 drivers/tty/serial/8250/8250_early.c                      |    1 
 drivers/tty/serial/8250/8250_omap.c                       |   14 
 drivers/tty/serial/amba-pl011.c                           |  112 ++--
 drivers/tty/serial/sc16is7xx.c                            |   12 
 drivers/usb/gadget/function/f_hid.c                       |    7 
 drivers/usb/host/xhci-pci.c                               |    2 
 drivers/usb/typec/class.c                                 |    5 
 fs/btrfs/disk-io.c                                        |    1 
 fs/btrfs/super.c                                          |    5 
 fs/cifs/cifsfs.c                                          |    4 
 fs/cifs/smb2ops.c                                         |    2 
 fs/nilfs2/sufile.c                                        |   42 +
 fs/nilfs2/the_nilfs.c                                     |    6 
 include/linux/cpuhotplug.h                                |    1 
 include/linux/hrtimer.h                                   |    4 
 include/linux/of.h                                        |   63 +-
 include/linux/perf_event.h                                |    2 
 include/linux/platform_data/x86/asus-wmi.h                |    5 
 include/net/genetlink.h                                   |    3 
 include/uapi/linux/perf_event.h                           |    5 
 io_uring/io_uring.c                                       |   55 --
 kernel/cpu.c                                              |    8 
 kernel/events/core.c                                      |   80 ++-
 kernel/events/ring_buffer.c                               |    5 
 kernel/time/hrtimer.c                                     |   33 -
 kernel/trace/ring_buffer.c                                |   19 
 kernel/trace/trace.c                                      |  177 ++-----
 net/core/drop_monitor.c                                   |    4 
 net/core/filter.c                                         |   19 
 net/core/scm.c                                            |    6 
 net/ipv4/ip_gre.c                                         |   11 
 net/ipv4/tcp_input.c                                      |    6 
 net/ipv6/ip6_fib.c                                        |    6 
 net/netfilter/ipset/ip_set_core.c                         |   14 
 net/netfilter/nft_set_pipapo.c                            |    3 
 net/netfilter/xt_owner.c                                  |   16 
 net/netlink/af_netlink.c                                  |    4 
 net/netlink/genetlink.c                                   |   35 +
 net/packet/af_packet.c                                    |   16 
 net/packet/internal.h                                     |    2 
 net/psample/psample.c                                     |    3 
 scripts/checkstack.pl                                     |    8 
 scripts/kconfig/symbol.c                                  |   14 
 sound/core/pcm.c                                          |    1 
 sound/pci/hda/patch_realtek.c                             |    1 
 sound/soc/codecs/wm_adsp.c                                |    8 
 tools/include/uapi/linux/perf_event.h                     |    5 
 104 files changed, 1352 insertions(+), 776 deletions(-)

Adrian Hunter (1):
      mmc: block: Be sure to wait while busy in CQE error recovery

Alex Bee (1):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3399

Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

AngeloGioacchino Del Regno (2):
      arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
      arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory

Armin Wolf (1):
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

Eric Dumazet (2):
      ipv6: fix potential NULL deref in fib6_add()
      tcp: do not accept ACK of bytes we never sent

Eugen Hristev (1):
      arm64: dts: mediatek: mt7622: fix memory node warning check

Florian Westphal (1):
      netfilter: nft_set_pipapo: skip inactive elements during set walk

Greg Kroah-Hartman (2):
      Revert "btrfs: add dmesg output for first mount and last unmount of a filesystem"
      Linux 5.10.204

Hans de Goede (6):
      platform/x86: asus-nb-wmi: Allow configuring SW_TABLET_MODE method with a module option
      platform/x86: asus-nb-wmi: Add tablet_mode_sw=lid-flip quirk for the TP200s
      platform/x86: asus-wmi: Simplify tablet-mode-switch probing
      platform/x86: asus-wmi: Simplify tablet-mode-switch handling
      platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code
      platform/x86: asus-wmi: Fix kbd_dock_devid tablet-switch reporting

Heiko Carstens (1):
      checkstack: fix printed address

Ido Schimmel (4):
      netlink: don't call ->netlink_bind with table lock held
      genetlink: add CAP_NET_ADMIN test for multicast bind
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ivan Vecera (1):
      i40e: Fix unexpected MFS warning message

Jack Wang (1):
      RDMA/rtrs-clt: Remove the warnings for req in_use check

Jan Bottorff (1):
      i2c: designware: Fix corrupted memory seen in the ISR

Jason Zhang (1):
      ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Jiaxun Yang (2):
      MIPS: Loongson64: Reserve vgabios memory on boot
      MIPS: Loongson64: Enable DMA noncoherent support

John Fastabend (1):
      bpf: sockmap, updating the sg structure should also update curr

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Konstantin Aladyshev (1):
      usb: gadget: f_hid: fix report descriptor allocation

Kunwu Chan (1):
      ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Lee Jones (1):
      of: base: Fix some formatting issues and provide missing descriptions

Luca Ceresoli (1):
      of: dynamic: Fix of_reconfig_get_state_change() return value documentation

Luke D. Jones (4):
      asus-wmi: Add dgpu disable method
      platform/x86: asus-wmi: Adjust tablet/lidflip handling to use enum
      platform/x86: asus-wmi: Add support for ROG X13 tablet mode
      platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute

Masahiro Yamada (1):
      kconfig: fix memory leak from range properties

Mathias Nyman (1):
      Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

Mukesh Ojha (2):
      devcoredump : Serialize devcd_del work
      devcoredump: Send uevent once devcd is ready

Namhyung Kim (2):
      perf/core: Add a new read format to get a number of lost samples
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources

Paulo Alcantara (1):
      smb: client: fix potential NULL deref in parse_dfs_referrals()

Pavel Begunkov (1):
      io_uring/af_unix: disable sending io_uring over sockets

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

Randy Dunlap (1):
      hv_netvsc: rndis_filter needs to select NLS

Rob Herring (2):
      of: Fix kerneldoc output formatting
      of: Add missing 'Return' section in kerneldoc comments

Ronald Wahl (3):
      serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
      serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
      serial: 8250_omap: Add earlycon support for the AM654 UART controller

Ryusuke Konishi (2):
      nilfs2: fix missing error check for sb_set_blocksize call
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Samuel Čavoj (1):
      platform/x86: asus-wmi: Add support for SW_TABLET_MODE on UX360

Shannon Nelson (1):
      ionic: fix snprintf format length warning

Shigeru Yoshida (1):
      ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Steven Rostedt (Google) (4):
      tracing: Always update snapshot buffer size
      tracing: Disable snapshot buffer when stopping instance tracers
      ring-buffer: Force absolute timestamp on discard of event
      tracing: Stop current tracer when resizing buffer

Su Hui (2):
      misc: mei: client.c: return negative error code in mei_cl_write
      misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Subbaraya Sundeep (1):
      octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam

Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

Thomas Gleixner (1):
      hrtimers: Push pending hrtimers away from outgoing CPU earlier

Thomas Reichinger (1):
      arcnet: restoring support for multiple Sohard Arcnet cards

Tong Zhang (1):
      net: arcnet: com20020 fix error handling

Yonglong Liu (1):
      net: hns: fix fake link up on xge port

YuanShang (1):
      drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Zheng Yejian (1):
      tracing: Set actual size after ring buffer resize

