Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F67A603C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjISKxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjISKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:52:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0E1A7;
        Tue, 19 Sep 2023 03:51:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD750C433C9;
        Tue, 19 Sep 2023 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695120698;
        bh=4YkxUJtsG6Ut/YGxhDXSaS1WzW7FGdX79bRIu3r8rJY=;
        h=From:To:Cc:Subject:Date:From;
        b=vLkMw4APuHjL2ItRukure0xc+AmLzZEubY+OWZ3T2B/YzTBKPxQOl75KE7xxpBMws
         CiqTJVsgUrj7BYRbroNKSKo3CkBicvFWhTxKURkSv5H1lOQ76mNEGdhLqmFUGTrLVD
         OOuBusYXZJQksaUNqRpEJD8jW8G/cxBl+3wEkLdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.54
Date:   Tue, 19 Sep 2023 12:51:26 +0200
Message-ID: <2023091926-expediter-shrug-9f31@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.54 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v1/memory.rst                 |    2 
 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml   |    2 
 Documentation/mm/multigen_lru.rst                              |    8 
 Makefile                                                       |    4 
 arch/arc/include/asm/atomic-llsc.h                             |    6 
 arch/arc/include/asm/atomic64-arcv2.h                          |    6 
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi               |    4 
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi              |    2 
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi              |    4 
 arch/arm64/net/bpf_jit_comp.c                                  |    9 
 arch/mips/Makefile                                             |    6 
 arch/parisc/include/asm/led.h                                  |    4 
 arch/sh/boards/mach-ap325rxa/setup.c                           |    2 
 arch/sh/boards/mach-ecovec24/setup.c                           |    6 
 arch/sh/boards/mach-kfr2r09/setup.c                            |    2 
 arch/sh/boards/mach-migor/setup.c                              |    2 
 arch/sh/boards/mach-se/7724/setup.c                            |    6 
 arch/x86/include/asm/virtext.h                                 |    6 
 arch/x86/kvm/svm/avic.c                                        |   59 ++
 arch/x86/kvm/svm/nested.c                                      |    9 
 arch/x86/kvm/svm/sev.c                                         |    9 
 arch/x86/kvm/svm/svm.c                                         |   35 +
 arch/x86/net/bpf_jit_comp.c                                    |   19 
 block/blk-throttle.c                                           |   99 ++--
 drivers/ata/ahci.c                                             |    2 
 drivers/ata/pata_falcon.c                                      |   50 +-
 drivers/ata/pata_ftide010.c                                    |    1 
 drivers/ata/sata_gemini.c                                      |    1 
 drivers/block/null_blk/main.c                                  |   12 
 drivers/bus/mhi/host/pm.c                                      |    5 
 drivers/char/tpm/tpm_crb.c                                     |    5 
 drivers/clk/imx/clk-pll14xx.c                                  |   13 
 drivers/clk/qcom/camcc-sc7180.c                                |    2 
 drivers/clk/qcom/dispcc-sm8450.c                               |   13 
 drivers/clk/qcom/gcc-mdm9615.c                                 |    2 
 drivers/clk/qcom/lpasscc-sc7280.c                              |   16 
 drivers/clk/qcom/mss-sc7180.c                                  |   13 
 drivers/clk/qcom/q6sstop-qcs404.c                              |   15 
 drivers/clk/qcom/turingcc-qcs404.c                             |   13 
 drivers/clocksource/arm_arch_timer.c                           |    7 
 drivers/dma/sh/rz-dmac.c                                       |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                    |   26 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c        |    7 
 drivers/gpu/drm/amd/display/dc/Makefile                        |    1 
 drivers/gpu/drm/amd/display/dc/core/dc.c                       |   68 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c               |    5 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c             |   11 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c        |    9 
 drivers/gpu/drm/ast/ast_post.c                                 |    2 
 drivers/gpu/drm/i915/gt/intel_engine_types.h                   |    1 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c              |    3 
 drivers/gpu/drm/i915/gvt/gtt.c                                 |   27 -
 drivers/gpu/drm/i915/gvt/gtt.h                                 |    1 
 drivers/gpu/drm/i915/i915_request.c                            |    7 
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                              |    9 
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                         |   30 -
 drivers/hwspinlock/qcom_hwspinlock.c                           |    9 
 drivers/input/keyboard/tca6416-keypad.c                        |   31 -
 drivers/input/misc/iqs7222.c                                   |    8 
 drivers/mailbox/qcom-ipcc.c                                    |    4 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                       |  112 +++-
 drivers/mtd/spi-nor/winbond.c                                  |    5 
 drivers/net/dsa/sja1105/sja1105.h                              |    4 
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c               |   93 +--
 drivers/net/dsa/sja1105/sja1105_main.c                         |  120 ++++-
 drivers/net/dsa/sja1105/sja1105_spi.c                          |    4 
 drivers/net/ethernet/adi/adin1110.c                            |   10 
 drivers/net/ethernet/cadence/macb.h                            |    4 
 drivers/net/ethernet/cadence/macb_main.c                       |   18 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                   |    5 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                    |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c             |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                |   19 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c             |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c         |   20 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c     |   14 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c        |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h        |    2 
 drivers/net/ethernet/intel/igb/igb.h                           |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                      |    5 
 drivers/net/ethernet/intel/igbvf/igbvf.h                       |    4 
 drivers/net/ethernet/intel/igc/igc.h                           |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c                   |   28 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c            |   21 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c      |    5 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c              |   26 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   10 
 drivers/net/usb/r8152.c                                        |    3 
 drivers/net/veth.c                                             |    4 
 drivers/parisc/led.c                                           |    4 
 drivers/pinctrl/intel/pinctrl-cherryview.c                     |    5 
 drivers/platform/mellanox/Kconfig                              |    4 
 drivers/platform/mellanox/mlxbf-pmc.c                          |   41 -
 drivers/platform/mellanox/mlxbf-tmfifo.c                       |   90 ++-
 drivers/pwm/pwm-atmel-tcb.c                                    |   70 +-
 drivers/pwm/pwm-lpc32xx.c                                      |   16 
 drivers/s390/crypto/zcrypt_api.c                               |    1 
 drivers/scsi/qla2xxx/qla_attr.c                                |    2 
 drivers/scsi/qla2xxx/qla_dbg.c                                 |    2 
 drivers/scsi/qla2xxx/qla_def.h                                 |   21 
 drivers/scsi/qla2xxx/qla_dfs.c                                 |   10 
 drivers/scsi/qla2xxx/qla_gbl.h                                 |    1 
 drivers/scsi/qla2xxx/qla_init.c                                |  234 ++++++----
 drivers/scsi/qla2xxx/qla_inline.h                              |   57 ++
 drivers/scsi/qla2xxx/qla_iocb.c                                |    1 
 drivers/scsi/qla2xxx/qla_isr.c                                 |    7 
 drivers/scsi/qla2xxx/qla_mbx.c                                 |    7 
 drivers/scsi/qla2xxx/qla_nvme.c                                |    3 
 drivers/scsi/qla2xxx/qla_os.c                                  |   26 -
 drivers/scsi/qla2xxx/qla_target.c                              |   14 
 drivers/soc/qcom/qmi_encdec.c                                  |    4 
 drivers/video/backlight/gpio_backlight.c                       |    3 
 drivers/video/fbdev/ep93xx-fb.c                                |    1 
 drivers/watchdog/intel-mid_wdt.c                               |    1 
 fs/btrfs/disk-io.c                                             |    5 
 fs/btrfs/extent-tree.c                                         |   43 -
 fs/btrfs/inode.c                                               |    7 
 fs/btrfs/relocation.c                                          |   12 
 fs/btrfs/space-info.c                                          |    6 
 fs/btrfs/transaction.c                                         |   26 -
 fs/btrfs/zoned.c                                               |   16 
 fs/ext4/balloc.c                                               |   15 
 fs/ext4/block_validity.c                                       |    8 
 fs/ext4/crypto.c                                               |    4 
 fs/ext4/ext4.h                                                 |    2 
 fs/f2fs/f2fs.h                                                 |   24 -
 fs/f2fs/inline.c                                               |    3 
 fs/f2fs/segment.c                                              |    2 
 fs/fuse/readdir.c                                              |   10 
 fs/gfs2/aops.c                                                 |    4 
 fs/gfs2/log.c                                                  |   25 -
 fs/jbd2/checkpoint.c                                           |   22 
 fs/jbd2/recovery.c                                             |   12 
 fs/nfs/direct.c                                                |   20 
 fs/nfs/pnfs_dev.c                                              |    2 
 fs/smb/client/cached_dir.c                                     |    2 
 fs/smb/client/cifs_dfs_ref.c                                   |  100 +---
 fs/smb/client/cifsglob.h                                       |    1 
 fs/smb/client/connect.c                                        |    1 
 fs/smb/client/fscache.c                                        |    2 
 fs/smb/client/smb2ops.c                                        |   11 
 fs/smb/client/smb2pdu.c                                        |   11 
 fs/smb/common/smb2pdu.h                                        |   22 
 include/linux/bpf.h                                            |   24 -
 include/linux/bpf_verifier.h                                   |   13 
 include/linux/ipv6.h                                           |    1 
 include/linux/micrel_phy.h                                     |    6 
 include/linux/mm_inline.h                                      |    4 
 include/linux/mmzone.h                                         |    8 
 include/linux/skbuff.h                                         |    8 
 include/linux/tca6416_keypad.h                                 |    1 
 include/net/ip.h                                               |    1 
 include/net/ip6_fib.h                                          |   14 
 include/net/ip_fib.h                                           |    5 
 include/net/ip_tunnels.h                                       |   15 
 include/net/ipv6.h                                             |    7 
 include/net/sock.h                                             |   12 
 include/trace/events/fib.h                                     |    5 
 include/trace/events/fib6.h                                    |    5 
 io_uring/io-wq.c                                               |   17 
 io_uring/io-wq.h                                               |    3 
 io_uring/io_uring.c                                            |   31 -
 io_uring/net.c                                                 |    8 
 io_uring/poll.c                                                |    3 
 io_uring/sqpoll.c                                              |   17 
 io_uring/sqpoll.h                                              |    1 
 kernel/bpf/syscall.c                                           |    7 
 kernel/bpf/trampoline.c                                        |   81 ++-
 lib/idr.c                                                      |    2 
 lib/kunit/test.c                                               |    3 
 lib/test_meminit.c                                             |    2 
 lib/test_scanf.c                                               |    2 
 mm/hugetlb_vmemmap.c                                           |   34 -
 mm/memcontrol.c                                                |   10 
 mm/vmscan.c                                                    |   50 +-
 net/core/flow_dissector.c                                      |    3 
 net/core/skbuff.c                                              |   49 --
 net/core/skmsg.c                                               |   12 
 net/core/sock.c                                                |   19 
 net/ethtool/ioctl.c                                            |   10 
 net/hsr/hsr_forward.c                                          |    1 
 net/ipv4/devinet.c                                             |   10 
 net/ipv4/fib_semantics.c                                       |    5 
 net/ipv4/fib_trie.c                                            |    3 
 net/ipv4/inet_hashtables.c                                     |   43 -
 net/ipv4/ip_input.c                                            |    3 
 net/ipv4/route.c                                               |    1 
 net/ipv4/tcp_output.c                                          |    2 
 net/ipv4/udp.c                                                 |    6 
 net/ipv6/addrconf.c                                            |    2 
 net/ipv6/ip6_input.c                                           |    3 
 net/ipv6/route.c                                               |    3 
 net/kcm/kcmsock.c                                              |   15 
 net/mptcp/protocol.c                                           |   23 
 net/netfilter/nfnetlink_osf.c                                  |    8 
 net/netfilter/nft_exthdr.c                                     |   22 
 net/sched/sch_fq_pie.c                                         |   27 -
 net/sched/sch_plug.c                                           |    2 
 net/sched/sch_qfq.c                                            |   22 
 net/sctp/proc.c                                                |    2 
 net/sctp/socket.c                                              |   10 
 net/smc/smc_core.c                                             |    2 
 net/tls/tls_sw.c                                               |    4 
 net/unix/af_unix.c                                             |    2 
 net/unix/scm.c                                                 |    6 
 net/xdp/xsk_diag.c                                             |    3 
 scripts/kconfig/preprocess.c                                   |    3 
 scripts/package/mkspec                                         |    2 
 sound/soc/tegra/tegra210_sfc.c                                 |   31 +
 sound/soc/tegra/tegra210_sfc.h                                 |    4 
 tools/perf/builtin-top.c                                       |    1 
 tools/perf/builtin-trace.c                                     |   15 
 tools/perf/pmu-events/arch/powerpc/power10/cache.json          |    4 
 tools/perf/pmu-events/arch/powerpc/power10/floating_point.json |    7 
 tools/perf/pmu-events/arch/powerpc/power10/frontend.json       |   30 -
 tools/perf/pmu-events/arch/powerpc/power10/marked.json         |   30 -
 tools/perf/pmu-events/arch/powerpc/power10/memory.json         |    6 
 tools/perf/pmu-events/arch/powerpc/power10/metrics.json        |    6 
 tools/perf/pmu-events/arch/powerpc/power10/others.json         |   53 +-
 tools/perf/pmu-events/arch/powerpc/power10/pipeline.json       |   30 -
 tools/perf/pmu-events/arch/powerpc/power10/pmc.json            |    4 
 tools/perf/pmu-events/arch/powerpc/power10/translation.json    |   11 
 tools/perf/tests/shell/stat_bpf_counters.sh                    |    4 
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh               |   28 -
 tools/perf/ui/browsers/hists.c                                 |   60 +-
 tools/perf/util/annotate.c                                     |   10 
 tools/perf/util/header.c                                       |   11 
 tools/testing/selftests/kselftest/runner.sh                    |    3 
 tools/testing/selftests/lib.mk                                 |    4 
 231 files changed, 2115 insertions(+), 1328 deletions(-)

Ahmad Fatoum (1):
      clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Alex Henrie (1):
      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Anand Jain (1):
      btrfs: use the correct superblock to compare fsid in btrfs_validate_super

Andreas Gruenbacher (2):
      gfs2: Switch to wait_event in gfs2_logd
      gfs2: low-memory forced flush fixes

Andrew Donnellan (1):
      lib/test_meminit: allocate pages up to order MAX_ORDER

Andrzej Hajda (1):
      drm/i915: mark requests for GuC virtual engines to avoid use-after-free

Andy Shevchenko (1):
      s390/zcrypt: don't leak memory if dev_set_name() fails

Ariel Marcovitch (1):
      idr: fix param name in idr_alloc_cyclic() doc

Arnaldo Carvalho de Melo (4):
      perf trace: Use zfree() to reduce chances of use after free
      perf trace: Really free the evsel->priv area
      perf annotate bpf: Don't enclose non-debug code with an assert()
      perf top: Don't pass an ERR_PTR() directly to perf_session__delete()

Bharath SM (1):
      cifs: update desired access while requesting for directory lease

Björn Töpel (2):
      kselftest/runner.sh: Propagate SIGTERM to runner child
      selftests: Keep symlinks, when possible

Boris Burkov (2):
      btrfs: fix start transaction qgroup rsv double free
      btrfs: free qgroup rsv on io failure

Chengming Zhou (1):
      null_blk: fix poll request timeout handling

Chris Lew (1):
      soc: qcom: qmi_encdec: Restrict string length in decode

Chris Paterson (1):
      arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

Christian Marangi (1):
      hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation

Christophe JAILLET (1):
      tpm_crb: Fix an error handling path in crb_acpi_add()

Ciprian Regus (1):
      net:ethernet:adi:adin1110: Fix forwarding offload

Corinna Vinschen (1):
      igb: disable virtualization features on 82580

Damien Le Moal (2):
      ata: sata_gemini: Add missing MODULE_DESCRIPTION
      ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Dmitry Baryshkov (1):
      clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Dmitry Torokhov (2):
      Input: tca6416-keypad - always expect proper IRQ number in i2c client
      Input: tca6416-keypad - fix interrupt enable disbalance

Eric Dumazet (14):
      net: add SKB_HEAD_ALIGN() helper
      net: remove osize variable in __alloc_skb()
      net: factorize code in kmalloc_reserve()
      net: deal with integer overflows in kmalloc_reserve()
      net/sched: fq_pie: avoid stalls in fq_pie_timer()
      sctp: annotate data-races around sk->sk_wmem_queued
      ipv4: annotate data-races around fi->fib_dead
      net: read sk->sk_family once in sk_mc_loop()
      net: use sk_forward_alloc_get() in sk_get_meminfo()
      net: annotate data-races around sk->sk_forward_alloc
      mptcp: annotate data-races around msk->rmem_fwd_alloc
      gve: fix frag_list chaining
      ip_tunnels: use DEV_STATS_INC()
      ipv6: fix ip6_sock_set_addr_preferences() typo

Fedor Pchelkin (1):
      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info

Filipe Manana (1):
      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART

Florian Westphal (2):
      net: fib: avoid warn splat in flow dissector
      netfilter: nftables: exthdr: fix 4-byte stack OOB write

Gabe Teeger (1):
      drm/amd/display: Remove wait while locked

Geert Uytterhoeven (1):
      platform/mellanox: NVSW_SN2201 should depend on ACPI

Geetha sowjanya (1):
      octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler

Greg Kroah-Hartman (1):
      Linux 6.1.54

Guangguan Wang (1):
      net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add

Gurchetan Singh (1):
      drm/virtio: Conditionally allocate virtio_gpu_fence

Hamza Mahfooz (2):
      drm/amd/display: prevent potential division by zero errors
      drm/amdgpu: register a dirty framebuffer callback for fbcon

Hangyu Hua (2):
      net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hao Chen (2):
      net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
      net: hns3: fix debugfs concurrency issue between kfree buffer and read

Harini Katakam (1):
      net: macb: Enable PTP unicast

Hayes Wang (1):
      r8152: check budget for r8152_poll()

Helge Deller (2):
      parisc: led: Fix LAN receive and transmit LEDs
      parisc: led: Reduce CPU overhead for disk & lan LED computation

Hien Huynh (1):
      dmaengine: sh: rz-dmac: Fix destination and source data size setting

Jaegeuk Kim (2):
      f2fs: flush inode if atomic file is aborted
      f2fs: avoid false alarm of circular locking

Jeff LaBundy (1):
      Input: iqs7222 - configure power mode before triggering ATI

Jian Shen (1):
      net: hns3: fix tx timeout issue

Jie Wang (1):
      net: hns3: remove GSO partial feature bit

Jijie Shao (1):
      net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue

Jinjie Ruan (1):
      kunit: Fix wild-memory-access bug in kunit_free_suite_set()

Johan Hovold (6):
      clk: qcom: camcc-sc7180: fix async resume during probe
      clk: qcom: turingcc-qcs404: fix missing resume during probe
      clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors
      clk: qcom: lpasscc-sc7280: fix missing resume during probe
      clk: qcom: q6sstop-qcs404: fix missing resume during probe
      clk: qcom: mss-sc7180: fix missing resume during probe

John Fastabend (1):
      bpf, sockmap: Fix skb refcnt race after locking changes

Jonathan Marek (1):
      mailbox: qcom-ipcc: fix incorrect num_chans counting

Josef Bacik (1):
      btrfs: set page extent mapped after read_folio in relocate_one_page

Kajol Jain (4):
      perf vendor events: Update the JSON/events descriptions for power10 platform
      perf vendor events: Drop some of the JSON/events for power10 platform
      perf vendor events: Drop STORES_PER_INST metric event for power10 platform
      perf test stat_bpf_counters_cgrp: Fix shellcheck issue about logical operators

Kalesh Singh (2):
      Multi-gen LRU: fix per-zone reclaim
      Multi-gen LRU: avoid race in inc_min_seq()

Katya Orlova (1):
      smb: propagate error code of extract_sharename()

Konstantin Meskhidze (1):
      kconfig: fix possible buffer overflow

Krzysztof Kozlowski (1):
      dt-bindings: clock: xlnx,versal-clk: drop select:false

Kuniyuki Iwashima (9):
      af_unix: Fix data-races around user->unix_inflight.
      af_unix: Fix data-race around unix_tot_inflight.
      af_unix: Fix data-races around sk->sk_shutdown.
      af_unix: Fix data race around sk->sk_err.
      ipv6: Remove in6addr_any alternatives.
      tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).
      tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
      tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Liang Chen (1):
      veth: Fixing transmit return status for dropped packets

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Linus Walleij (1):
      mtd: spi-nor: Correct flags for Winbond w25q128

Liu Jian (2):
      net: ipv4: fix one memleak in __inet_del_ifa()
      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Liu Ying (1):
      drm/mxsfb: Disable overlay plane in mxsfb_plane_overlay_atomic_disable()

Luís Henriques (1):
      ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}

Maciej W. Rozycki (2):
      MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install' regression
      MIPS: Only fiddle with CHECKFLAGS if `need-compiler'

Magnus Karlsson (1):
      xsk: Fix xsk_diag use-after-free error during socket cleanup

Manish Rangankar (1):
      scsi: qla2xxx: Remove unsupported ql2xenabledif option

Marco Felsch (1):
      clk: imx: pll14xx: align pdiv with reference manual

Martin KaFai Lau (1):
      bpf: Remove prog->active check for bpf_lsm and bpf_iter

Masahiro Yamada (2):
      kbuild: rpm-pkg: define _arch conditionally
      kbuild: do not run depmod for 'make modules_sign'

Melissa Wen (1):
      drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma

Michael Schmitz (1):
      ata: pata_falcon: fix IO base selection for Q40

Michal Hocko (1):
      memcg: drop kmem.limit_in_bytes

Muchun Song (1):
      mm: hugetlb_vmemmap: fix a race between vmemmap pmd split

Namhyung Kim (5):
      perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test
      perf hists browser: Fix hierarchy mode header
      perf test shell stat_bpf_counters: Fix test on Intel
      perf tools: Handle old data in PERF_RECORD_ATTR
      perf hists browser: Fix the number of entries for 'e' key

Naohiro Aota (2):
      btrfs: zoned: do not zone finish data relocation block group
      btrfs: zoned: re-enable metadata over-commit for zoned mode

Nathan Chancellor (1):
      lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()

Nilesh Javali (1):
      scsi: qla2xxx: Fix smatch warn for qla_init_iocb_limit()

Oleksij Rempel (1):
      net: phy: micrel: Correct bit assignments for phy_device flags

Olga Zaborska (3):
      igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Paulo Alcantara (1):
      cifs: use fs_context for automounts

Pavel Begunkov (6):
      io_uring: always lock in io_apoll_task_func
      io_uring: revert "io_uring fix multishot accept ordering"
      io_uring/net: don't overflow multishot accept
      io_uring: break out of iowq iopoll on teardown
      io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used
      io_uring: Don't set affinity on a dying sqpoll thread

Pavel Kozlov (1):
      ARC: atomics: Add compiler barrier to atomic operations...

Petr Tesarik (1):
      sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Qiang Yu (1):
      bus: mhi: host: Skip MHI reset if device is in RDDM

Quan Tian (1):
      net/ipv6: SKB symmetric hash should incorporate transport ports

Quinn Tran (12):
      scsi: qla2xxx: Adjust IOCB resource on qpair create
      scsi: qla2xxx: Limit TMF to 8 per function
      scsi: qla2xxx: Fix deletion race condition
      scsi: qla2xxx: fix inconsistent TMF timeout
      scsi: qla2xxx: Fix command flush during TMF
      scsi: qla2xxx: Fix erroneous link up failure
      scsi: qla2xxx: Turn off noisy message log
      scsi: qla2xxx: Fix session hang in gnl
      scsi: qla2xxx: Fix TMF leak through
      scsi: qla2xxx: Flush mailbox commands on chip reset
      scsi: qla2xxx: Error code did not return to upper layer
      scsi: qla2xxx: Fix firmware resource tracking

Raag Jadav (2):
      pinctrl: cherryview: fix address_space_handler() argument
      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Saeed Mahameed (1):
      net/mlx5: Free IRQ rmap and notifier on kernel shutdown

Sascha Hauer (1):
      net: macb: fix sleep inside spinlock

Sean Christopherson (11):
      x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()
      drm/i915/gvt: Verify pfn is "valid" before dereferencing "struct page"
      drm/i915/gvt: Put the page reference obtained by KVM's gfn_to_pfn()
      drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()
      KVM: SVM: Take and hold ir_list_lock when updating vCPU's Physical ID entry
      KVM: SVM: Don't inject #UD if KVM attempts to skip SEV guest insn
      KVM: SVM: Get source vCPUs from source VM for SEV-ES intrahost migration
      KVM: nSVM: Check instead of asserting on nested TSC scaling support
      KVM: nSVM: Load L1's TSC multiplier based on L1 state, not L2 state
      KVM: SVM: Set target pCPU during IRTE update if target vCPU is running
      KVM: SVM: Skip VMSA init in sev_es_init_vmcb() if pointer is NULL

Sebastian Andrzej Siewior (2):
      bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
      bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.

Sheetal (1):
      ASoC: tegra: Fix SFC conversion for few rates

Shigeru Yoshida (2):
      kcm: Destroy mutex in kcm_exit_net()
      kcm: Fix memory leak in error path of kcm_sendmsg()

Shravan Kumar Ramani (2):
      platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
      platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events

Sriram Yagnaraman (2):
      ipv4: ignore dst hint for multipath routes
      ipv6: ignore dst hint for multipath routes

Steve French (1):
      send channel sequence number in SMB3 requests after reconnects

Thomas Zimmermann (2):
      fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
      drm/ast: Fix DRAM init on AST2200

Trond Myklebust (1):
      NFS: Fix a potential data corruption

Uwe Kleine-König (3):
      pwm: atmel-tcb: Convert to platform remove callback returning void
      pwm: atmel-tcb: Harmonize resource allocation order
      pwm: atmel-tcb: Fix resource freeing in error path and remove

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Vincent Whitchurch (1):
      net: stmmac: fix handling of zero coalescing tx-usecs

Vladimir Oltean (8):
      net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
      net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
      net: dsa: sja1105: complete tc-cbs offload support on SJA1110
      net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
      net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()
      net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry
      net: dsa: sja1105: serialize sja1105_port_mcast_flood() with other FDB accesses
      net: dsa: sja1105: block FDB accesses that are concurrent with a switch reset

Vladimir Zapolskiy (1):
      pwm: lpc32xx: Remove handling of PWM channels

Walter Chang (1):
      clocksource/drivers/arm_arch_timer: Disable timer before programming CVAL

Wander Lairson Costa (1):
      netfilter: nfnetlink_osf: avoid OOB read

Wang Jianjian (1):
      ext4: add correct group descriptors and reserved GDT blocks to system zone

Wenjing Liu (1):
      drm/amd/display: always switch off ODM before committing more streams

Werner Fischer (1):
      ata: ahci: Add Elkhart Lake AHCI controller

Wesley Chalmers (1):
      drm/amd/display: Fix a bug when searching for insert_above_mpcc

William Zhang (4):
      mtd: rawnand: brcmnand: Fix crash during the panic_write
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller

Yang Yingliang (1):
      net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address

Ying Liu (1):
      backlight: gpio_backlight: Drop output GPIO direction check for initial power state

Yisen Zhuang (1):
      net: hns3: fix the port information display when sfp is absent

Yu Kuai (2):
      blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
      blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()

Yu Zhao (1):
      mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folios[]

Zhang Yi (2):
      jbd2: fix checkpoint cleanup performance regression
      jbd2: correct the end of the journal recovery scan range

Zhihao Cheng (1):
      jbd2: check 'jh->b_transaction' before removing it from checkpoint

Ziyang Xuan (1):
      hsr: Fix uninit-value access in fill_frame_info()

ruanmeisi (1):
      fuse: nlookup missing decrement in fuse_direntplus_link

valis (1):
      net: sched: sch_qfq: Fix UAF in qfq_dequeue()

