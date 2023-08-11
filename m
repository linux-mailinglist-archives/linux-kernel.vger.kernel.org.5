Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B30778D17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjHKLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHKLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF810C9;
        Fri, 11 Aug 2023 04:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B7C661290;
        Fri, 11 Aug 2023 11:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF92C433C8;
        Fri, 11 Aug 2023 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691752107;
        bh=jl3Bg0cNMbd7Ks1QiF0j3HvoLjjtB9Ya3uOX1ZOw9yI=;
        h=From:To:Cc:Subject:Date:From;
        b=z0hUNArW9E3z1gQWm82lPF8pxsbh0LivSHMBmAVIm1zheBq/QQ99ysTf1y7Aki3ud
         2GMRteFtZB0fevBa0BMlk0Nnv+BczT4iAXGVjENXSaxbLVu7jgdi6Sgtz5rY5sVm9d
         yvwO3LrkVrIeIgdT0rALKdo3zMWS4A4wbsj13uM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.45
Date:   Fri, 11 Aug 2023 13:08:22 +0200
Message-ID: <2023081123-ion-ferment-1ce5@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.45 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                         |    4 
 Makefile                                                       |    2 
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts         |    2 
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts    |    2 
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts    |    2 
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi          |    4 
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts         |    4 
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts         |    4 
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                      |    2 
 arch/arm64/kernel/fpsimd.c                                     |    9 
 arch/arm64/kernel/ptrace.c                                     |    8 
 arch/powerpc/include/asm/word-at-a-time.h                      |    2 
 arch/powerpc/kernel/trace/ftrace_mprofile.S                    |    9 
 arch/powerpc/mm/init_64.c                                      |    3 
 arch/s390/kernel/sthyi.c                                       |    6 
 arch/s390/kvm/intercept.c                                      |    9 
 arch/x86/hyperv/hv_init.c                                      |   21 ++
 arch/x86/include/asm/cpufeatures.h                             |    1 
 arch/x86/include/asm/processor.h                               |    2 
 arch/x86/kernel/cpu/amd.c                                      |   19 +
 arch/x86/kernel/traps.c                                        |    2 
 drivers/block/rbd.c                                            |   28 +-
 drivers/clk/imx/clk-imx93.c                                    |    2 
 drivers/firmware/arm_scmi/mailbox.c                            |    4 
 drivers/firmware/arm_scmi/smc.c                                |   21 +-
 drivers/firmware/smccc/soc_id.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c               |  104 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                     |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                        |   89 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                        |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                       |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   15 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                  |    5 
 drivers/gpu/drm/amd/include/atomfirmware.h                     |   63 +++++-
 drivers/gpu/drm/i915/display/intel_display.c                   |   28 --
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c                       |    8 
 drivers/gpu/drm/i915/gt/intel_gt_regs.h                        |   16 -
 drivers/gpu/drm/i915/gt/intel_lrc.c                            |    6 
 drivers/gpu/drm/i915/i915_active.c                             |   99 ++++++---
 drivers/gpu/drm/i915/i915_request.c                            |   11 +
 drivers/gpu/drm/imx/ipuv3-crtc.c                               |    2 
 drivers/gpu/drm/ttm/ttm_bo.c                                   |    3 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |   50 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h                    |    8 
 drivers/isdn/hardware/mISDN/hfcpci.c                           |   10 
 drivers/mtd/nand/raw/fsl_upm.c                                 |    2 
 drivers/mtd/nand/raw/meson_nand.c                              |    3 
 drivers/mtd/nand/raw/omap_elm.c                                |   24 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c                |   45 ++--
 drivers/mtd/nand/spi/toshiba.c                                 |    4 
 drivers/net/dsa/bcm_sf2.c                                      |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      |   59 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                  |    6 
 drivers/net/ethernet/intel/ice/ice_main.c                      |   18 +
 drivers/net/ethernet/korina.c                                  |    3 
 drivers/net/ethernet/marvell/prestera/prestera_pci.c           |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c  |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c              |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c               |   20 -
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c              |  103 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h             |    1 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c              |   29 ++
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c      |    5 
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h                  |   16 +
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c                     |   19 +
 drivers/net/ethernet/qlogic/qed/qed_fcoe.h                     |   17 +
 drivers/net/ethernet/qlogic/qed/qed_hw.c                       |   26 ++
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c                    |   19 +
 drivers/net/ethernet/qlogic/qed/qed_iscsi.h                    |    8 
 drivers/net/ethernet/qlogic/qed/qed_l2.c                       |   19 +
 drivers/net/ethernet/qlogic/qed/qed_l2.h                       |   24 ++
 drivers/net/ethernet/qlogic/qed/qed_main.c                     |    6 
 drivers/net/ethernet/socionext/netsec.c                        |   11 +
 drivers/net/ethernet/xilinx/ll_temac_main.c                    |   12 -
 drivers/net/ipa/ipa_table.c                                    |   24 +-
 drivers/net/tap.c                                              |    2 
 drivers/net/tun.c                                              |    2 
 drivers/net/usb/cdc_ether.c                                    |   21 ++
 drivers/net/usb/usbnet.c                                       |    6 
 drivers/net/usb/zaurus.c                                       |   21 ++
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c             |    6 
 drivers/s390/net/qeth_core.h                                   |    1 
 drivers/s390/net/qeth_core_main.c                              |    2 
 drivers/s390/net/qeth_l2_main.c                                |    9 
 drivers/s390/net/qeth_l3_main.c                                |    8 
 drivers/s390/scsi/zfcp_fc.c                                    |    6 
 drivers/scsi/storvsc_drv.c                                     |    4 
 fs/btrfs/block-group.c                                         |   51 +++-
 fs/btrfs/block-group.h                                         |    4 
 fs/btrfs/free-space-tree.c                                     |   24 +-
 fs/ceph/mds_client.c                                           |    4 
 fs/ceph/mds_client.h                                           |    5 
 fs/ceph/super.c                                                |   10 
 fs/erofs/zdata.c                                               |    7 
 fs/exfat/balloc.c                                              |    6 
 fs/exfat/dir.c                                                 |   36 +--
 fs/ext2/ext2.h                                                 |   12 -
 fs/ext2/super.c                                                |   23 --
 fs/f2fs/f2fs.h                                                 |    1 
 fs/f2fs/file.c                                                 |    5 
 fs/f2fs/node.c                                                 |   14 +
 fs/f2fs/super.c                                                |   43 ++--
 fs/file.c                                                      |   18 +
 fs/ntfs3/attrlist.c                                            |    4 
 fs/open.c                                                      |    2 
 fs/super.c                                                     |   11 -
 fs/sysv/itree.c                                                |    4 
 include/asm-generic/word-at-a-time.h                           |    2 
 include/linux/f2fs_fs.h                                        |    1 
 include/net/inet_sock.h                                        |    7 
 include/net/ip.h                                               |    2 
 include/net/route.h                                            |    4 
 include/net/vxlan.h                                            |    4 
 io_uring/io_uring.c                                            |   23 +-
 io_uring/timeout.c                                             |    2 
 kernel/bpf/cpumap.c                                            |   35 ++-
 kernel/events/core.c                                           |    8 
 kernel/trace/bpf_trace.c                                       |   17 +
 lib/Makefile                                                   |    6 
 lib/debugobjects.c                                             |    9 
 lib/test_bitmap.c                                              |    8 
 mm/memcontrol.c                                                |   19 -
 net/bluetooth/l2cap_sock.c                                     |    2 
 net/ceph/osd_client.c                                          |   20 +
 net/core/bpf_sk_storage.c                                      |    5 
 net/core/rtnetlink.c                                           |    8 
 net/core/sock.c                                                |   45 ++--
 net/core/sock_map.c                                            |    2 
 net/dcb/dcbnl.c                                                |    2 
 net/dccp/ipv6.c                                                |    4 
 net/ipv4/inet_diag.c                                           |    4 
 net/ipv4/ip_output.c                                           |    8 
 net/ipv4/ip_sockglue.c                                         |    2 
 net/ipv4/raw.c                                                 |    2 
 net/ipv4/route.c                                               |    4 
 net/ipv4/tcp_ipv4.c                                            |    4 
 net/ipv4/tcp_metrics.c                                         |   70 ++++--
 net/ipv6/ip6mr.c                                               |    2 
 net/ipv6/ping.c                                                |    2 
 net/ipv6/raw.c                                                 |    6 
 net/ipv6/route.c                                               |    7 
 net/ipv6/tcp_ipv6.c                                            |    9 
 net/ipv6/udp.c                                                 |    4 
 net/l2tp/l2tp_ip6.c                                            |    2 
 net/mptcp/sockopt.c                                            |    2 
 net/netfilter/nft_socket.c                                     |    2 
 net/netfilter/xt_socket.c                                      |    4 
 net/packet/af_packet.c                                         |   12 -
 net/sched/cls_fw.c                                             |    1 
 net/sched/cls_route.c                                          |    1 
 net/sched/cls_u32.c                                            |   57 ++++-
 net/sched/sch_taprio.c                                         |   15 +
 net/smc/af_smc.c                                               |    2 
 net/unix/af_unix.c                                             |    2 
 net/wireless/scan.c                                            |    2 
 net/xdp/xsk.c                                                  |    2 
 net/xfrm/xfrm_policy.c                                         |    2 
 rust/bindings/bindings_helper.h                                |    1 
 rust/kernel/allocator.rs                                       |   74 +++++--
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh        |    8 
 tools/testing/selftests/rseq/rseq.c                            |   28 ++
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json |   25 ++
 166 files changed, 1597 insertions(+), 644 deletions(-)

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Aleksa Sarai (1):
      open: make RESOLVE_CACHED correctly test for O_TMPFILE

Alex Elder (1):
      net: ipa: only reset hashed tables when supported

Alexander Stein (1):
      drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning

Alexandra Winter (1):
      s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Amir Tzin (1):
      net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set

Andi Shyti (1):
      drm/i915/gt: Cleanup aux invalidation registers

Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix OOB available bytes for ECC

Benjamin Gaignard (1):
      arm64: dts: freescale: Fix VPU G2 clock

Benjamin Poirier (1):
      vxlan: Fix nexthop hash size

Boqun Feng (1):
      rust: allocator: Prevent mis-aligned allocation

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Do not leak quotient data after a division by 0

Chao Yu (2):
      f2fs: fix to do sanity check on direct node in truncate_dnode()
      f2fs: don't reset unchangable mount option in f2fs_remount()

Chengfeng Ye (1):
      mISDN: hfcpci: Fix potential deadlock on &hc->lock

Christophe JAILLET (1):
      mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Cristian Marussi (1):
      firmware: arm_scmi: Fix chan_free cleanup on SMC

Dan Carpenter (1):
      net: ll_temac: fix error checking of irq_of_parse_and_map()

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Eric Dumazet (16):
      net: annotate data-races around sk->sk_reserved_mem
      net: annotate data-race around sk->sk_txrehash
      net: annotate data-races around sk->sk_max_pacing_rate
      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
      net: annotate data-races around sk->sk_mark
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      net: annotate data-races around sk->sk_priority
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Filipe Manana (1):
      btrfs: remove BUG_ON()'s in add_new_free_space()

Gao Xiang (1):
      erofs: fix wrong primary bvec selection on deduplicated extents

Geert Uytterhoeven (1):
      clk: imx93: Propagate correct error in imx93_clocks_probe()

Georg Müller (1):
      perf test uprobe_from_different_cu: Skip if there is no gcc

Greg Kroah-Hartman (2):
      Revert "drm/i915: Disable DC states for all commits"
      Linux 6.1.45

Guchun Chen (1):
      drm/ttm: check null pointer before accessing when swapping

Heiko Carstens (1):
      KVM: s390: fix sthyi error handling

Hou Tao (2):
      bpf, cpumap: Handle skb as well when clean up ptr_ring
      bpf, cpumap: Make sure kthread is running before map update returns

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Ilya Dryomov (2):
      libceph: fix potential hang in ceph_osdc_notify()
      rbd: prevent busy loop when requesting exclusive lock

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Jan Kara (2):
      fs: Protect reconfiguration of sb read-write from racing writes
      ext2: Drop fragment support

Janusz Krzysztofik (1):
      drm/i915: Fix premature release of request's reusable memory

Jens Axboe (1):
      io_uring: gate iowait schedule on having pending requests

Jianbo Liu (3):
      net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
      net/mlx5: fs_core: Make find_closest_ft more generic
      net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio

Jiri Olsa (2):
      bpf: Disable preemption in bpf_perf_event_output
      bpf: Disable preemption in bpf_event_output

Johan Jonker (2):
      mtd: rawnand: rockchip: fix oobfree offset and description
      mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

Jonas Gorski (1):
      prestera: fix fallback to previous version on same major version

Konstantin Khorenko (1):
      qed: Fix scheduling in a tasklet while getting stats

Krzysztof Kozlowski (1):
      firmware: arm_scmi: Drop OF node reference in the transport channel setup

Kuniyuki Iwashima (1):
      net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

Laszlo Ersek (2):
      net: tun_chr_open(): set sk_uid from current_fsuid()
      net: tap_open(): set sk_uid from current_fsuid()

Lijo Lazar (1):
      drm/amdgpu: Use apt name for FW reserved region

Lin Ma (3):
      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
      net: dcb: choose correct policy to parse DCB_ATTR_BCN

Linus Torvalds (1):
      file: reinstate f_pos locking optimization for regular files

Luben Tuikov (1):
      drm/amdgpu: Remove unnecessary domain argument

Mark Brown (5):
      net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
      arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE
      arm64/fpsimd: Clear SME state in the target task when setting the VL
      arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
      arm64/ptrace: Don't enable SVE when setting streaming SVE

Michael Chan (1):
      bnxt_en: Fix max_mtu setting for multi-buf XDP

Michael Kelley (2):
      scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
      x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction

Namjae Jeon (1):
      exfat: check if filename entries exceeds max filename length

Naveen N Rao (1):
      powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Olivier Maignial (1):
      mtd: spinand: toshiba: Fix ecc_get_status

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

Pavel Begunkov (1):
      io_uring: annotate offset timeout races

Peichen Huang (1):
      drm/amd/display: skip CLEAR_PAYLOAD_ID_TABLE if device mst_en is 0

Peter Zijlstra (1):
      perf: Fix function pointer case

Prince Kumar Maurya (1):
      fs/sysv: Null check to prevent null-ptr-deref bug

Punit Agrawal (1):
      firmware: smccc: Fix use of uninitialised results structure

Rafal Rogalski (1):
      ice: Fix RDMA VSI removal during queue rebuild

Robin Murphy (4):
      iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
      iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
      iommu/arm-smmu-v3: Add explicit feature for nesting
      iommu/arm-smmu-v3: Document nesting-related errata

Rodrigo Siqueira (1):
      drm/amd/display: Ensure that planes are in the same order

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Roman Gushchin (1):
      mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Sean Christopherson (1):
      selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Shay Drory (1):
      net/mlx5: Free irqs only on shutdown callback

Somnath Kotur (1):
      bnxt_en: Fix page pool logic for page size >= 64K

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Sungjong Seo (1):
      exfat: release s_lock before calling dir_emit()

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Tetsuo Handa (2):
      fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_load_attr_list()
      debugobjects: Recheck debug_objects_enabled before reporting

Tim Harvey (2):
      arm64: dts: imx8mm-venice-gw7903: disable disp_blk_ctrl
      arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl

Tomas Glozar (1):
      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

Tong Liu01 (1):
      drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2

Xiubo Li (1):
      ceph: defer stopping mdsc delayed_work

Yangtao Li (1):
      f2fs: fix to set flush_merge opt and show noflush_merge

Yashwanth Varakala (2):
      arm64: dts: phycore-imx8mm: Label typo-fix of VPU
      arm64: dts: phycore-imx8mm: Correction in gpio-line-names

Yuanjun Gong (3):
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
      net: dsa: fix value check in bcm_sf2_sw_probe()
      net: korina: handle clk prepare error in korina_probe()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Yury Norov (1):
      lib/bitmap: workaround const_eval test build failure

Zhengchao Shao (3):
      net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
      net/mlx5: fix potential memory leak in mlx5e_init_rep_rx

gaoming (1):
      exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

ndesaulniers@google.com (1):
      word-at-a-time: use the same return type for has_zero regardless of endianness

valis (3):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

