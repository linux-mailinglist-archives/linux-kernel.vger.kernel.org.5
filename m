Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41B578D90A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjH3ScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245318AbjH3PKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:10:07 -0400
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:10:02 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7EFE8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E5375CE1E0C;
        Wed, 30 Aug 2023 15:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C180DC433C7;
        Wed, 30 Aug 2023 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407776;
        bh=a1+WMlabkA1OTasJnlcWKxskJdJ7ko8wG4RBAIExWyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CG9AMQrx04OWZUoMqw5usxpRg3sg9DelrMA685Kw59WDY6OL3dkkHuyOSnShuC7tK
         g3nxgi9fuUXr1cTg5GMzOUR3Us2ui+7MYjZ6fzsyEN4zJ7ZZauFx87QxqLtoTNirdD
         fncaNyH9a33cbZGaBX1lhP1nfk4NpQyadquQDbP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.255
Date:   Wed, 30 Aug 2023 17:02:48 +0200
Message-ID: <2023083048-entomb-daybed-bae9@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.255 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/sysctl/vm.rst                      |    9 
 Documentation/power/runtime_pm.rst                           |    6 
 MAINTAINERS                                                  |    2 
 Makefile                                                     |    2 
 arch/arm/boot/dts/imx23.dtsi                                 |    2 
 arch/arm/boot/dts/imx28.dtsi                                 |    2 
 arch/arm/boot/dts/imx6qdl.dtsi                               |    2 
 arch/arm/boot/dts/imx6sx.dtsi                                |    8 
 arch/arm/boot/dts/imx6ul.dtsi                                |    2 
 arch/arm/boot/dts/imx7s.dtsi                                 |    9 
 arch/mips/include/asm/cpu-features.h                         |   21 
 arch/mips/include/asm/dec/prom.h                             |    2 
 arch/powerpc/kernel/rtas_flash.c                             |    6 
 arch/powerpc/mm/kasan/Makefile                               |    1 
 arch/x86/kernel/fpu/xstate.c                                 |    8 
 drivers/base/power/runtime.c                                 |   49 
 drivers/base/regmap/regmap-i2c.c                             |    4 
 drivers/bus/ti-sysc.c                                        |   12 
 drivers/clk/clk-devres.c                                     |   13 
 drivers/dma-buf/sw_sync.c                                    |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                       |    6 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |    4 
 drivers/gpu/drm/radeon/radeon_cs.c                           |    3 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-quirks.c                                     |    1 
 drivers/i2c/busses/i2c-bcm-iproc.c                           |   11 
 drivers/iio/Kconfig                                          |    1 
 drivers/iio/Makefile                                         |    1 
 drivers/iio/adc/Kconfig                                      |   16 
 drivers/iio/adc/Makefile                                     |    1 
 drivers/iio/adc/stx104.c                                     |  375 ----
 drivers/iio/addac/Kconfig                                    |   24 
 drivers/iio/addac/Makefile                                   |    7 
 drivers/iio/addac/stx104.c                                   |  415 ++++
 drivers/interconnect/core.c                                  |   77 
 drivers/interconnect/internal.h                              |   42 
 drivers/iommu/amd_iommu_types.h                              |    4 
 drivers/irqchip/irq-mips-gic.c                               |   65 
 drivers/leds/trigger/ledtrig-netdev.c                        |    3 
 drivers/md/dm-integrity.c                                    |    4 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c           |    2 
 drivers/media/platform/mtk-vpu/mtk_vpu.c                     |    6 
 drivers/mmc/core/block.c                                     |    7 
 drivers/mmc/host/bcm2835.c                                   |    4 
 drivers/mmc/host/sdhci_f_sdh30.c                             |   68 
 drivers/mmc/host/sunxi-mmc.c                                 |    4 
 drivers/mmc/host/wbsd.c                                      |    2 
 drivers/net/bonding/bond_alb.c                               |    6 
 drivers/net/can/vxcan.c                                      |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                             |    8 
 drivers/net/ethernet/broadcom/bgmac.c                        |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                 |    2 
 drivers/net/ethernet/ibm/ibmveth.c                           |    2 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                   |   16 
 drivers/net/ethernet/intel/igb/igb_ptp.c                     |   24 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c          |    3 
 drivers/net/ipvlan/ipvlan_main.c                             |    3 
 drivers/net/macsec.c                                         |   70 
 drivers/net/phy/broadcom.c                                   |   13 
 drivers/net/team/team.c                                      |    4 
 drivers/net/veth.c                                           |    5 
 drivers/net/virtio_net.c                                     |    4 
 drivers/pci/hotplug/acpiphp_glue.c                           |    9 
 drivers/pcmcia/rsrc_nonstatic.c                              |    2 
 drivers/pinctrl/pinctrl-rza2.c                               |   17 
 drivers/scsi/raid_class.c                                    |   48 
 drivers/scsi/snic/snic_disc.c                                |    3 
 drivers/tty/serial/8250/8250_port.c                          |    1 
 drivers/tty/serial/fsl_lpuart.c                              |    4 
 drivers/usb/chipidea/ci_hdrc_imx.c                           |    5 
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
 fs/nfs/nfs4proc.c                                            |    9 
 fs/nfsd/nfs4state.c                                          |   11 
 fs/overlayfs/ovl_entry.h                                     |    9 
 fs/quota/dquot.c                                             |    5 
 fs/udf/unicode.c                                             |    2 
 include/drm/drm_dp_helper.h                                  |    2 
 include/linux/clk.h                                          |   80 
 include/linux/interconnect.h                                 |   12 
 include/linux/mm.h                                           |    2 
 include/linux/pm_runtime.h                                   |   12 
 include/linux/raid_class.h                                   |    4 
 include/linux/virtio_net.h                                   |    4 
 include/linux/wait.h                                         |    2 
 include/media/v4l2-mem2mem.h                                 |   18 
 include/net/bonding.h                                        |   25 
 include/net/rtnetlink.h                                      |    4 
 include/net/sock.h                                           |   11 
 include/sound/core.h                                         |    3 
 include/trace/events/rpm.h                                   |    6 
 kernel/sysctl.c                                              |    8 
 kernel/trace/trace.c                                         |    9 
 kernel/trace/trace_irqsoff.c                                 |    3 
 kernel/trace/trace_kprobe.c                                  |    3 
 kernel/trace/trace_probe_tmpl.h                              |   18 
 kernel/trace/trace_sched_wakeup.c                            |    2 
 kernel/trace/trace_uprobe.c                                  |    3 
 lib/clz_ctz.c                                                |   32 
 lib/radix-tree.c                                             |    1 
 mm/filemap.c                                                 |  160 +
 net/batman-adv/bat_v_elp.c                                   |    3 
 net/batman-adv/bat_v_ogm.c                                   |    7 
 net/batman-adv/hard-interface.c                              |   14 
 net/batman-adv/netlink.c                                     |    3 
 net/batman-adv/soft-interface.c                              |    3 
 net/batman-adv/translation-table.c                           |    1 
 net/batman-adv/types.h                                       |    6 
 net/bluetooth/l2cap_core.c                                   |    5 
 net/core/rtnetlink.c                                         |   29 
 net/core/sock.c                                              |    2 
 net/dccp/proto.c                                             |   20 
 net/ipv4/ip_vti.c                                            |    4 
 net/ipv4/tcp_timer.c                                         |    4 
 net/ipv6/ip6_vti.c                                           |    4 
 net/key/af_key.c                                             |    4 
 net/ncsi/ncsi-manage.c                                       |    3 
 net/ncsi/ncsi-rsp.c                                          |    6 
 net/netfilter/ipvs/ip_vs_ctl.c                               |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                      |    6 
 net/netfilter/nft_dynset.c                                   |    3 
 net/sched/sch_api.c                                          |   53 
 net/sctp/socket.c                                            |    2 
 net/unix/af_unix.c                                           |    9 
 net/xfrm/Makefile                                            |    2 
 net/xfrm/xfrm_interface.c                                    |  987 -----------
 net/xfrm/xfrm_interface_core.c                               |  987 +++++++++++
 net/xfrm/xfrm_user.c                                         |   13 
 security/integrity/ima/Kconfig                               |    2 
 sound/core/init.c                                            |    1 
 sound/core/pcm_memory.c                                      |   99 -
 sound/hda/hdac_device.c                                      |    2 
 sound/hda/hdac_regmap.c                                      |    7 
 sound/pci/emu10k1/emufx.c                                    |  112 -
 sound/pci/hda/patch_realtek.c                                |    9 
 sound/soc/codecs/rt5665.c                                    |    2 
 sound/soc/fsl/fsl_sai.c                                      |  149 +
 sound/soc/fsl/fsl_sai.h                                      |   60 
 sound/soc/meson/axg-tdm-formatter.c                          |   42 
 sound/usb/quirks-table.h                                     |   29 
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh |    3 
 tools/testing/selftests/net/forwarding/tc_flower.sh          |    8 
 153 files changed, 2936 insertions(+), 2208 deletions(-)

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

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Andrey Skvortsov (1):
      clk: Fix slab-out-of-bounds error in devm_clk_release()

Andrii Staikov (1):
      i40e: fix misleading debug logs

Ankit Nautiyal (1):
      drm/display/dp: Fix the DP DSC Receiver cap size

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Arnd Bergmann (1):
      radix tree: remove unused variable

Benjamin Coddington (2):
      NFSv4: Fix dropped lock for racing OPEN and delegation return
      nfsd: Fix race to FREE_STATEID and cl_revoked

Benjamin Gray (1):
      powerpc/kasan: Disable KCOV in KASAN code

Biju Das (2):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
      pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}

Chengfeng Ye (1):
      i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue

Christian Brauner (1):
      ovl: check type and offset of struct vfsmount in ovl_entry

Christian Marangi (1):
      leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename

Clayton Yager (1):
      macsec: Fix traffic counters/statistics

Colin Ian King (1):
      ALSA: pcm: Check for null pointer of pointer substream before dereferencing it

Cosmin Tanislav (1):
      iio: add addac subdirectory

Eric Dumazet (4):
      macsec: use DEV_STATS_INC()
      net: do not allow gso_size to be set to GSO_BY_FRAGS
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()

Eyal Birger (1):
      xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Georgi Djakov (3):
      interconnect: Move internal structs into a separate file
      interconnect: Add helpers for enabling/disabling a path
      interconnect: Do not skip aggregation for disabled paths

Greg Kroah-Hartman (1):
      Linux 5.4.255

Gustavo A. R. Silva (1):
      MIPS: dec: prom: Address -Warray-bounds warning

Hangbin Liu (1):
      bonding: fix macvlan over alb bond support

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Hariprasad Kelam (1):
      octeontx2-af: SDP: fix receive link config

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

Jakub Kicinski (2):
      net: validate veth and vxcan peer ifindexes
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

Jerome Brunet (1):
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Jiaxun Yang (4):
      irqchip/mips-gic: Use raw spinlock for gic_lock
      MIPS: cpu-features: Enable octeon_cache by cpu_type
      MIPS: cpu-features: Use boot_cpu_type for CPU type based features
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Joel Savitz (1):
      Documentation/sysctl: document page_lock_unfairness

Johan Hovold (1):
      USB: dwc3: qcom: fix NULL-deref on suspend

Josip Pavic (1):
      drm/amd/display: do not wait for mpc idle if tg is disabled

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kishon Vijay Abraham I (1):
      iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Lin Ma (4):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      xfrm: add NULL check in xfrm_update_ae_params
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure

Linus Torvalds (1):
      mm: allow a controlled amount of unfairness in the page lock

Lu Wei (1):
      ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Marc Zyngier (1):
      irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Marek Vasut (1):
      ARM: dts: imx7s: Drop dma-apb interrupt-names

Mark Brown (1):
      regmap: Account for register length in SMBus I/O limits

Masami Hiramatsu (Google) (1):
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Matus Gajdos (1):
      ASoC: fsl_sai: Disable bit clock with transmitter

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Michał Mirosław (1):
      PM-runtime: add tracepoints for usage_count changes

Mikulas Patocka (2):
      dm integrity: increase RECALC_SECTORS to improve recalculate speed
      dm integrity: reduce vmalloc space footprint on 32-bit architectures

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: disallow object maps

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Randy Dunlap (1):
      IMA: allow/fix UML builds

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Ruan Jinjie (2):
      net: bgmac: Fix return value check for fixed_phy_register()
      net: bcmgenet: Fix return value check for fixed_phy_register()

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Sakari Ailus (1):
      PM: runtime: Add pm_runtime_get_if_active()

Sandeep Maheswaram (1):
      usb: dwc3: qcom: Add helper functions to enable,disable wake irqs

Sergey Shtylyov (2):
      mmc: bcm2835: fix deferred probing
      mmc: sunxi: fix deferred probing

Shengjiu Wang (2):
      ASoC: fsl_sai: Refine enable/disable TE/RE sequence in trigger()
      ASoC: fsl_sai: Add new added registers and new bit definition

Sherry Sun (1):
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Stefan Wahren (1):
      ARM: dts: imx: Adjust dma-apbh node name

Steven Rostedt (VMware) (1):
      tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Takashi Iwai (6):
      ALSA: hda: Fix unhandled register update during auto-suspend period
      ALSA: pcm: Set per-card upper limit of PCM buffer allocations
      ALSA: pcm: Use SG-buffer only when direct DMA is available
      ALSA: pcm: Fix potential data race at PCM memory allocation helpers
      ALSA: pcm: Fix build error on m68k and others
      Revert "ALSA: pcm: Use SG-buffer only when direct DMA is available"

Tang Bin (1):
      virtio-mmio: Use to_virtio_mmio_device() to simply code

Thomas Zimmermann (2):
      fbdev: Improve performance of sys_imageblit()
      fbdev: Fix sys_imageblit() for arbitrary image widths

Tony Lindgren (3):
      bus: ti-sysc: Improve reset to work with modules with no sysconfig
      bus: ti-sysc: Flush posted write on enable before reset
      serial: 8250: Fix oops for port->pm on uart_change_pm()

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Tuo Li (2):
      gfs2: Fix possible data races in gfs2_show_options()
      ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()

Vijay Khemka (1):
      net/ncsi: Fix gma flag setting after response

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

William Breathitt Gray (5):
      iio: adc: stx104: Utilize iomap interface
      iio: adc: stx104: Implement and utilize register structures
      iio: stx104: Move to addac subdirectory
      iio: addac: stx104: Fix race condition for stx104_write_raw()
      iio: addac: stx104: Fix race condition when converting analog-to-digital

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

Xiaolei Wang (2):
      ARM: dts: imx: Set default tuning step for imx7d usdhc
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Xu Yang (1):
      usb: chipidea: imx: don't request QoS for imx8ulp

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (3):
      mmc: sdhci_f_sdh30: convert to devm_platform_ioremap_resource
      virtio-mmio: convert to devm_platform_ioremap_resource
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

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

dengxiang (2):
      ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760
      ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

