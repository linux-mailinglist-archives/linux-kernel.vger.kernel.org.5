Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714B78DD82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbjH3SvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245310AbjH3PI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:08:28 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:08:23 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A0E8;
        Wed, 30 Aug 2023 08:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0DE9B81F6C;
        Wed, 30 Aug 2023 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B249C433C7;
        Wed, 30 Aug 2023 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407769;
        bh=V/dVIeItFs0WrWvCVm7c78uY8/rtubncwO74HD+XYiU=;
        h=From:To:Cc:Subject:Date:From;
        b=YDiKyMJwBfCanBe6NKakdmrs7iI7Gj4gTApvfHYG8h6jhJPVqQTDqFNMaqUQPksm0
         tnppjZK7HjflGbuQDBlOfkFE/kCIh3RniUeG95UjMB2wjhXJpXLzPxtH/Hc5EqZ1wI
         TgY7IjrNqb2X9l85bTTBSexcggKsmUBWyFrAGoVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.293
Date:   Wed, 30 Aug 2023 17:02:42 +0200
Message-ID: <2023083043-preface-compel-9b05@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.293 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 arch/mips/include/asm/cpu-features.h                         |   21 
 arch/mips/include/asm/dec/prom.h                             |    2 
 arch/powerpc/Kconfig                                         |    1 
 arch/powerpc/Kconfig.debug                                   |    4 
 arch/powerpc/Makefile                                        |   24 
 arch/powerpc/include/asm/book3s/32/mmu-hash.h                |    6 
 arch/powerpc/include/asm/book3s/64/mmu.h                     |    9 
 arch/powerpc/include/asm/mmu-40x.h                           |   68 
 arch/powerpc/include/asm/mmu-44x.h                           |  153 -
 arch/powerpc/include/asm/mmu-8xx.h                           |  244 --
 arch/powerpc/include/asm/mmu-book3e.h                        |  313 ---
 arch/powerpc/include/asm/mmu.h                               |   14 
 arch/powerpc/include/asm/nohash/32/mmu-40x.h                 |   68 
 arch/powerpc/include/asm/nohash/32/mmu-44x.h                 |  153 +
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h                 |  244 ++
 arch/powerpc/include/asm/nohash/32/mmu.h                     |   23 
 arch/powerpc/include/asm/nohash/64/mmu.h                     |   12 
 arch/powerpc/include/asm/nohash/mmu-book3e.h                 |  313 +++
 arch/powerpc/include/asm/nohash/mmu.h                        |   11 
 arch/powerpc/include/asm/page.h                              |   14 
 arch/powerpc/include/asm/stackprotector.h                    |   34 
 arch/powerpc/kernel/Makefile                                 |    2 
 arch/powerpc/kernel/asm-offsets.c                            |    3 
 arch/powerpc/kernel/cpu_setup_fsl_booke.S                    |    2 
 arch/powerpc/kernel/rtas_flash.c                             |    6 
 arch/powerpc/kvm/e500.h                                      |    2 
 arch/powerpc/mm/Makefile                                     |   10 
 arch/powerpc/mm/dump_hashpagetable.c                         |  550 ------
 arch/powerpc/mm/dump_linuxpagetables-8xx.c                   |   82 
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c              |  115 -
 arch/powerpc/mm/dump_linuxpagetables-generic.c               |   82 
 arch/powerpc/mm/dump_linuxpagetables.c                       |  373 ----
 arch/powerpc/mm/dump_linuxpagetables.h                       |   19 
 arch/powerpc/mm/pgtable-radix.c                              |    4 
 arch/powerpc/mm/ptdump/8xx.c                                 |   82 
 arch/powerpc/mm/ptdump/Makefile                              |    9 
 arch/powerpc/mm/ptdump/bats.c                                |  173 +
 arch/powerpc/mm/ptdump/book3s64.c                            |  115 +
 arch/powerpc/mm/ptdump/hashpagetable.c                       |  550 ++++++
 arch/powerpc/mm/ptdump/ptdump.c                              |  373 ++++
 arch/powerpc/mm/ptdump/ptdump.h                              |   19 
 arch/powerpc/mm/ptdump/segment_regs.c                        |   64 
 arch/powerpc/mm/ptdump/shared.c                              |   82 
 arch/powerpc/platforms/powermac/Makefile                     |    1 
 arch/x86/kernel/cpu/topology.c                               |    5 
 arch/x86/kernel/fpu/xstate.c                                 |    8 
 block/partitions/amiga.c                                     |    9 
 drivers/base/regmap/regmap-i2c.c                             |    4 
 drivers/dma-buf/sw_sync.c                                    |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                       |    6 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |    4 
 drivers/gpu/drm/radeon/radeon_cs.c                           |    3 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-quirks.c                                     |    1 
 drivers/iio/Kconfig                                          |    1 
 drivers/iio/Makefile                                         |    1 
 drivers/iio/adc/stx104.c                                     |   96 -
 drivers/iio/addac/Kconfig                                    |    8 
 drivers/iio/addac/Makefile                                   |    6 
 drivers/irqchip/irq-mips-gic.c                               |   65 
 drivers/md/dm-integrity.c                                    |    4 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c           |    2 
 drivers/media/platform/mtk-vpu/mtk_vpu.c                     |    6 
 drivers/mmc/core/block.c                                     |   11 
 drivers/mmc/host/bcm2835.c                                   |    5 
 drivers/mmc/host/jz4740_mmc.c                                |    1 
 drivers/mmc/host/meson-gx-mmc.c                              |   18 
 drivers/mmc/host/mxcmmc.c                                    |    4 
 drivers/mmc/host/renesas_sdhi_core.c                         |   62 
 drivers/mmc/host/s3cmci.c                                    |    1 
 drivers/mmc/host/sdhci-msm.c                                 |    2 
 drivers/mmc/host/sdhci-pltfm.c                               |    1 
 drivers/mmc/host/sdhci-s3c.c                                 |    4 
 drivers/mmc/host/sdhci_f_sdh30.c                             |    4 
 drivers/mmc/host/sunxi-mmc.c                                 |    4 
 drivers/mmc/host/tmio_mmc.c                                  |   48 
 drivers/mmc/host/tmio_mmc.h                                  |    4 
 drivers/mmc/host/tmio_mmc_core.c                             |   92 -
 drivers/mmc/host/wbsd.c                                      |    2 
 drivers/net/bonding/bond_alb.c                               |    6 
 drivers/net/ethernet/ibm/ibmveth.c                           |    2 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                   |   16 
 drivers/net/ethernet/intel/igb/igb_ptp.c                     |   24 
 drivers/net/phy/broadcom.c                                   |   13 
 drivers/net/team/team.c                                      |    4 
 drivers/net/virtio_net.c                                     |    4 
 drivers/pci/hotplug/acpiphp_glue.c                           |    9 
 drivers/pcmcia/rsrc_nonstatic.c                              |    2 
 drivers/scsi/raid_class.c                                    |   48 
 drivers/scsi/snic/snic_disc.c                                |    3 
 drivers/tty/serial/8250/8250_port.c                          |    1 
 drivers/tty/serial/fsl_lpuart.c                              |    2 
 drivers/usb/dwc3/dwc3-qcom.c                                 |   69 
 drivers/video/fbdev/core/sysimgblt.c                         |   64 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                        |    4 
 drivers/virtio/virtio_mmio.c                                 |   23 
 fs/btrfs/volumes.c                                           |    3 
 fs/cifs/file.c                                               |    2 
 fs/dlm/lock.c                                                |   53 
 fs/dlm/plock.c                                               |   89 
 fs/dlm/recover.c                                             |   39 
 fs/gfs2/super.c                                              |   26 
 fs/jfs/jfs_dmap.c                                            |    3 
 fs/jfs/jfs_txnmgr.c                                          |    5 
 fs/jfs/namei.c                                               |    5 
 fs/nfsd/nfs4state.c                                          |   11 
 fs/quota/dquot.c                                             |    5 
 fs/udf/unicode.c                                             |    2 
 include/linux/clk.h                                          |   80 
 include/linux/raid_class.h                                   |    4 
 include/linux/virtio_net.h                                   |    4 
 include/media/v4l2-mem2mem.h                                 |   18 
 include/net/bonding.h                                        |   25 
 include/net/sock.h                                           |   11 
 kernel/sched/rt.c                                            |    5 
 kernel/trace/trace.c                                         |    9 
 kernel/trace/trace_irqsoff.c                                 |    3 
 kernel/trace/trace_sched_wakeup.c                            |    2 
 lib/clz_ctz.c                                                |   32 
 lib/mpi/longlong.h                                           |   36 
 lib/test_firmware.c                                          |   37 
 net/batman-adv/bat_v_elp.c                                   |    3 
 net/batman-adv/bat_v_ogm.c                                   |    7 
 net/batman-adv/hard-interface.c                              |   14 
 net/batman-adv/soft-interface.c                              |    3 
 net/batman-adv/translation-table.c                           |    1 
 net/batman-adv/types.h                                       |    6 
 net/bluetooth/l2cap_core.c                                   |    5 
 net/core/rtnetlink.c                                         |    5 
 net/core/sock.c                                              |    2 
 net/dccp/proto.c                                             |   20 
 net/ipv4/ip_vti.c                                            |    4 
 net/ipv4/tcp_timer.c                                         |    4 
 net/ipv6/ip6_vti.c                                           |    4 
 net/key/af_key.c                                             |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                               |   74 
 net/netfilter/nf_conntrack_proto_sctp.c                      |    6 
 net/netfilter/nf_queue.c                                     |    2 
 net/netfilter/nft_dynset.c                                   |    3 
 net/sched/sch_api.c                                          |   53 
 net/sctp/socket.c                                            |    2 
 net/unix/af_unix.c                                           |    9 
 net/xfrm/Makefile                                            |    2 
 net/xfrm/xfrm_interface.c                                    |  996 -----------
 net/xfrm/xfrm_interface_core.c                               |  996 +++++++++++
 net/xfrm/xfrm_user.c                                         |   13 
 security/integrity/ima/Kconfig                               |    2 
 sound/pci/emu10k1/emufx.c                                    |  112 -
 sound/soc/codecs/rt5665.c                                    |    2 
 sound/soc/meson/axg-tdm-formatter.c                          |   42 
 sound/usb/quirks-table.h                                     |   29 
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh |    3 
 tools/testing/selftests/net/forwarding/tc_flower.sh          |    8 
 154 files changed, 4345 insertions(+), 3856 deletions(-)

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Alexander Aring (5):
      dlm: improve plock logging if interrupted
      fs: dlm: add pid to debug log
      fs: dlm: change plock interrupted message to debug again
      fs: dlm: use dlm_plock_info for do_unlock_close
      fs: dlm: fix mismatch of plock results from userspace

Alexander Stein (1):
      Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"

Andrii Staikov (1):
      i40e: fix misleading debug logs

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Benjamin Coddington (1):
      nfsd: Fix race to FREE_STATEID and cl_revoked

Biju Das (1):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'

Christophe Leroy (6):
      powerpc/mm: move platform specific mmu-xxx.h in platform directories
      powerpc/mm: Move pgtable_t into platform headers
      powerpc/mm: dump segment registers on book3s/32
      powerpc/mm: dump block address translation on book3s/32
      powerpc: Move page table dump files in a dedicated subdirectory
      powerpc/32: add stack protector support

Cosmin Tanislav (1):
      iio: add addac subdirectory

Eric Dumazet (3):
      net: do not allow gso_size to be set to GSO_BY_FRAGS
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()

Eyal Birger (1):
      xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Greg Kroah-Hartman (1):
      Linux 4.19.293

Gustavo A. R. Silva (1):
      MIPS: dec: prom: Address -Warray-bounds warning

Hangbin Liu (1):
      bonding: fix macvlan over alb bond support

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Helge Deller (1):
      lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Ido Schimmel (2):
      selftests: forwarding: tc_flower: Relax success criterion
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Igor Mammedov (2):
      PCI: acpiphp: Reassign resources on bridge if necessary
      PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Immad Mir (2):
      FS: JFS: Fix null-ptr-deref Read in txBegin
      FS: JFS: Check for read-only mounted filesystem in txBegin

J. Bruce Fields (1):
      nfsd4: kill warnings on testing stateids with mismatched clientids

Jakob Koschel (1):
      dlm: replace usage of found with dedicated list iterator variable

Jakub Kicinski (1):
      net: remove bond_slave_has_mac_rcu()

Jamal Hadi Salim (1):
      net/sched: fix a qdisc modification with ambiguous command request

Jan Kara (2):
      quota: Properly disable quotas when add_dquot_ref() fails
      udf: Fix uninitialized array access for some pathnames

Jason Wang (1):
      virtio-net: set queues after driver_ok

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Jerome Brunet (2):
      mmc: meson-gx: remove useless lock
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Jiaxun Yang (4):
      irqchip/mips-gic: Use raw spinlock for gic_lock
      MIPS: cpu-features: Enable octeon_cache by cpu_type
      MIPS: cpu-features: Use boot_cpu_type for CPU type based features
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Johan Hovold (1):
      USB: dwc3: qcom: fix NULL-deref on suspend

Josip Pavic (1):
      drm/amd/display: do not wait for mpc idle if tg is disabled

Junwei Hu (1):
      ipvs: Improve robustness to the ipvs sysctl

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Lin Ma (4):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      xfrm: add NULL check in xfrm_update_ae_params
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure

Marc Zyngier (1):
      irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Mark Brown (1):
      regmap: Account for register length in SMBus I/O limits

Martin Hundebøll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Masahiro Yamada (3):
      mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
      mmc: tmio: move tmio_mmc_set_clock() to platform hook
      powerpc: remove leftover code of old GCC version checks

Michael Ellerman (2):
      powerpc/64s/radix: Fix soft dirty tracking
      ibmveth: Use dcbf rather than dcbfl

Michael Schmitz (1):
      block: fix signed int overflow in Amiga partition support

Mikulas Patocka (2):
      dm integrity: increase RECALC_SECTORS to improve recalculate speed
      dm integrity: reduce vmalloc space footprint on 32-bit architectures

Mirsad Goran Todorovac (1):
      test_firmware: prevent race conditions by a correct implementation of locking

Nathan Chancellor (1):
      lib/mpi: Eliminate unused umul_ppmm definitions for MIPS

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Naveen N Rao (1):
      powerpc: Fail build if using recordmcount with binutils v2.37

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: disallow object maps

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Pietro Borrello (1):
      sched/rt: pick_next_rt_entity(): check list_entry

Randy Dunlap (1):
      IMA: allow/fix UML builds

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Sandeep Maheswaram (1):
      usb: dwc3: qcom: Add helper functions to enable,disable wake irqs

Sergey Shtylyov (2):
      mmc: bcm2835: fix deferred probing
      mmc: sunxi: fix deferred probing

Sherry Sun (1):
      tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Stephen Boyd (1):
      mmc: Remove dev_err() usage after platform_get_irq()

Sven Eckelmann (2):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Tang Bin (1):
      virtio-mmio: Use to_virtio_mmio_device() to simply code

Thomas Zimmermann (2):
      fbdev: Improve performance of sys_imageblit()
      fbdev: Fix sys_imageblit() for arbitrary image widths

Tony Lindgren (1):
      serial: 8250: Fix oops for port->pm on uart_change_pm()

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Tuo Li (1):
      gfs2: Fix possible data races in gfs2_show_options()

Vamsi Krishna Brahmajosyula (1):
      netfilter: nf_queue: fix socket leak

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

William Breathitt Gray (4):
      iio: adc: stx104: Utilize iomap interface
      iio: adc: stx104: Implement and utilize register structures
      iio: addac: stx104: Fix race condition for stx104_write_raw()
      iio: addac: stx104: Fix race condition when converting analog-to-digital

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      virtio-mmio: convert to devm_platform_ioremap_resource

Ye Bin (1):
      quota: fix warning in dqgrab()

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

Yogesh (1):
      fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yunfei Dong (1):
      media: v4l2-mem2mem: add lock to protect parameter num_rdy

Zhang Rui (1):
      x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

Zhang Shurong (2):
      ASoC: rt5665: add missed regulator_bulk_disable
      fbdev: fix potential OOB read in fast_imageblit()

Zheng Yejian (1):
      tracing: Fix memleak due to race between current_tracer and trace

Zhengchao Shao (3):
      xfrm: fix slab-use-after-free in decode_session6
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

Zhengping Jiang (1):
      Bluetooth: L2CAP: Fix use-after-free

Zhu Wang (2):
      scsi: snic: Fix double free in snic_tgt_create()
      scsi: core: raid_class: Remove raid_component_add()

Ziyang Xuan (1):
      team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

dengxiang (1):
      ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

