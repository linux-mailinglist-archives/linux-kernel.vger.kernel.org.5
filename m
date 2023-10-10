Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738A97C40B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjJJUFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjJJUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615213D;
        Tue, 10 Oct 2023 13:04:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D35C433C9;
        Tue, 10 Oct 2023 20:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968251;
        bh=TlE8totk6hnIuHLY8bRCxkiExUtDXWSTY00rj7HnxA8=;
        h=From:To:Cc:Subject:Date:From;
        b=GqKeHgy77PPOA1v1J/Hg4wTRVISX+hzk5UAYwRPQwYUE6UNSmTWYXGjYivvWSVY++
         UY31O6X3fRxgT9nPexUgCFqPsAqS1gX67YvxLYMr8egXTZt9dvEVjZ2PjTF8jvKOVh
         B2mZHcjB4MQSi8vc3eBrxHbFs2yOew2wOQLLw7ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.198
Date:   Tue, 10 Oct 2023 22:03:57 +0200
Message-ID: <2023101058-enchilada-helpless-2a72@gregkh>
X-Mailer: git-send-email 2.42.0
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

I'm announcing the release of the 5.10.198 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/arm/boot/dts/am335x-guardian.dts                             |    9 
 arch/arm/boot/dts/am3517-evm.dts                                  |    2 
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi                  |    2 
 arch/arm/boot/dts/motorola-mapphone-common.dtsi                   |   33 
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi                         |    6 
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi                         |    6 
 arch/arm/boot/dts/omap3-cm-t3517.dts                              |   12 
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi                          |    3 
 arch/arm/boot/dts/omap3-gta04.dtsi                                |    8 
 arch/arm/boot/dts/omap3-ldp.dts                                   |    2 
 arch/arm/boot/dts/omap3-n900.dts                                  |   40 
 arch/arm/boot/dts/omap3-zoom3.dts                                 |   44 
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi                          |   29 
 arch/arm/boot/dts/omap443x.dtsi                                   |    1 
 arch/arm/boot/dts/omap4460.dtsi                                   |    1 
 arch/arm/boot/dts/omap5-cm-t54.dts                                |   64 
 arch/arm64/include/asm/cputype.h                                  |    2 
 arch/mips/alchemy/devboards/db1000.c                              |    4 
 arch/mips/alchemy/devboards/db1200.c                              |    6 
 arch/mips/alchemy/devboards/db1300.c                              |    4 
 arch/parisc/include/asm/ldcw.h                                    |   36 
 arch/parisc/include/asm/ropes.h                                   |    3 
 arch/parisc/include/asm/spinlock_types.h                          |    5 
 arch/parisc/kernel/drivers.c                                      |    2 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/kernel/hw_breakpoint.c                               |    7 
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 arch/x86/kernel/cpu/bugs.c                                        |    4 
 arch/xtensa/boot/Makefile                                         |    3 
 arch/xtensa/boot/lib/zmem.c                                       |    5 
 arch/xtensa/include/asm/core.h                                    |    4 
 arch/xtensa/platforms/iss/network.c                               |    4 
 block/blk-core.c                                                  |    2 
 block/blk-sysfs.c                                                 |    2 
 drivers/acpi/device_pm.c                                          |   29 
 drivers/ata/ahci.c                                                |  111 
 drivers/ata/ahci_brcm.c                                           |    2 
 drivers/ata/ahci_xgene.c                                          |    4 
 drivers/ata/libahci.c                                             |   49 
 drivers/ata/libata-core.c                                         |   41 
 drivers/ata/libata-eh.c                                           |   13 
 drivers/ata/libata-sata.c                                         |    2 
 drivers/ata/libata-scsi.c                                         |    2 
 drivers/ata/libata-transport.c                                    |    9 
 drivers/ata/libata.h                                              |    2 
 drivers/base/regmap/regcache-rbtree.c                             |    3 
 drivers/block/rbd.c                                               |  412 +-
 drivers/bus/ti-sysc.c                                             |   31 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/imx/clk-pll14xx.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/gpio/gpio-aspeed.c                                        |    2 
 drivers/gpio/gpio-pmic-eic-sprd.c                                 |    1 
 drivers/gpio/gpio-pxa.c                                           |    1 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                            |    2 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/busses/i2c-npcm7xx.c                                  |   17 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/infiniband/core/cma.c                                     |    2 
 drivers/infiniband/core/cma_configfs.c                            |    2 
 drivers/infiniband/core/nldev.c                                   |    1 
 drivers/infiniband/core/uverbs_main.c                             |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                |    2 
 drivers/infiniband/hw/mlx5/main.c                                 |    2 
 drivers/infiniband/sw/siw/siw_cm.c                                |   16 
 drivers/input/serio/i8042-acpipnpio.h                             | 1597 ++++++++++
 drivers/input/serio/i8042-x86ia64io.h                             | 1590 ---------
 drivers/input/serio/i8042.h                                       |    2 
 drivers/md/dm-zoned-target.c                                      |   15 
 drivers/media/platform/qcom/venus/core.c                          |   12 
 drivers/media/platform/qcom/venus/core.h                          |   11 
 drivers/media/platform/qcom/venus/firmware.c                      |   28 
 drivers/media/platform/qcom/venus/hfi_venus.c                     |   94 
 drivers/media/platform/qcom/venus/hfi_venus_io.h                  |  114 
 drivers/media/platform/qcom/venus/pm_helpers.c                    |   12 
 drivers/mmc/host/renesas_sdhi_core.c                              |   37 
 drivers/mmc/host/tmio_mmc.h                                       |    1 
 drivers/mmc/host/tmio_mmc_core.c                                  |    8 
 drivers/mtd/ubi/build.c                                           |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                                  |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                               |   31 
 drivers/net/dsa/mv88e6xxx/global1.h                               |    1 
 drivers/net/dsa/mv88e6xxx/global2.c                               |    2 
 drivers/net/dsa/mv88e6xxx/global2.h                               |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |    7 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                |    7 
 drivers/net/ethernet/qlogic/qed/qed_ll2.h                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c                 |    7 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                          |    1 
 drivers/net/team/team.c                                           |   10 
 drivers/net/thunderbolt.c                                         |    3 
 drivers/net/usb/smsc75xx.c                                        |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                                    |   12 
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h                |    6 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c              |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                     |   16 
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c               |    7 
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c                |   13 
 drivers/nvme/host/pci.c                                           |  149 
 drivers/of/dynamic.c                                              |    6 
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/pci/controller/dwc/pcie-qcom.c                            |    2 
 drivers/platform/mellanox/Kconfig                                 |    1 
 drivers/platform/x86/intel_scu_ipc.c                              |   66 
 drivers/power/supply/ucs1002_power.c                              |    3 
 drivers/s390/scsi/zfcp_aux.c                                      |    9 
 drivers/scsi/pm8001/pm8001_hwi.c                                  |    2 
 drivers/scsi/pm8001/pm80xx_hwi.c                                  |    4 
 drivers/scsi/qedf/qedf_io.c                                       |   10 
 drivers/scsi/qedf/qedf_main.c                                     |    7 
 drivers/spi/spi-nxp-fspi.c                                        |    7 
 drivers/spi/spi-zynqmp-gqspi.c                                    |   24 
 drivers/target/target_core_device.c                               |   11 
 drivers/tty/n_gsm.c                                               |    4 
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/video/fbdev/Kconfig                                       |    2 
 drivers/watchdog/iTCO_wdt.c                                       |   26 
 drivers/xen/events/events_base.c                                  |   87 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/extent_io.c                                              |    8 
 fs/btrfs/super.c                                                  |    2 
 fs/ext4/ext4.h                                                    |    2 
 fs/ext4/mballoc.c                                                 |  138 
 fs/nfs/direct.c                                                   |    8 
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nfs/nfs4proc.c                                                 |    4 
 fs/nfs/nfs4state.c                                                |   47 
 fs/nfs/sysfs.c                                                    |   16 
 fs/nfs/write.c                                                    |   23 
 fs/nilfs2/gcinode.c                                               |    6 
 fs/proc/task_nommu.c                                              |   27 
 include/linux/acpi.h                                              |    5 
 include/linux/bpf.h                                               |    2 
 include/linux/btf_ids.h                                           |    2 
 include/linux/cgroup.h                                            |    3 
 include/linux/if_team.h                                           |    2 
 include/linux/libata.h                                            |    4 
 include/linux/netfilter/nf_conntrack_sctp.h                       |    1 
 include/linux/nfs_page.h                                          |    4 
 include/linux/seqlock.h                                           |  104 
 include/net/netfilter/ipv4/nf_reject.h                            |    4 
 include/net/netfilter/ipv6/nf_reject.h                            |    5 
 include/net/netfilter/nf_tables.h                                 |  136 
 include/net/tcp.h                                                 |    6 
 include/uapi/linux/bpf.h                                          |    4 
 include/uapi/linux/netfilter/nf_tables.h                          |    2 
 kernel/bpf/queue_stack_maps.c                                     |   21 
 kernel/dma/debug.c                                                |   20 
 kernel/sched/cpuacct.c                                            |   84 
 kernel/trace/ring_buffer.c                                        |   42 
 kernel/trace/trace.c                                              |   27 
 kernel/trace/trace.h                                              |    2 
 kernel/trace/trace_events.c                                       |    6 
 kernel/trace/trace_events_inject.c                                |    3 
 mm/frame_vector.c                                                 |    6 
 net/bridge/br_forward.c                                           |    4 
 net/bridge/br_input.c                                             |    4 
 net/core/neighbour.c                                              |    4 
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/ipv4/netfilter/ipt_REJECT.c                                   |    3 
 net/ipv4/netfilter/nf_reject_ipv4.c                               |    6 
 net/ipv4/netfilter/nft_reject_ipv4.c                              |    3 
 net/ipv4/route.c                                                  |    4 
 net/ipv4/tcp_input.c                                              |   13 
 net/ipv4/tcp_output.c                                             |    7 
 net/ipv6/netfilter/ip6t_REJECT.c                                  |    2 
 net/ipv6/netfilter/nf_reject_ipv6.c                               |    5 
 net/ipv6/netfilter/nft_reject_ipv6.c                              |    3 
 net/l2tp/l2tp_ip6.c                                               |    2 
 net/ncsi/ncsi-aen.c                                               |    5 
 net/netfilter/ipset/ip_set_core.c                                 |   12 
 net/netfilter/ipvs/ip_vs_sync.c                                   |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                           |   43 
 net/netfilter/nf_tables_api.c                                     |  436 ++
 net/netfilter/nf_tables_core.c                                    |    2 
 net/netfilter/nf_tables_trace.c                                   |    6 
 net/netfilter/nft_exthdr.c                                        |  193 +
 net/netfilter/nft_flow_offload.c                                  |    2 
 net/netfilter/nft_payload.c                                       |   10 
 net/netfilter/nft_reject_inet.c                                   |    6 
 net/netfilter/nft_set_hash.c                                      |   87 
 net/netfilter/nft_set_pipapo.c                                    |  115 
 net/netfilter/nft_set_rbtree.c                                    |  199 -
 net/netfilter/nft_synproxy.c                                      |    4 
 net/netfilter/nft_tproxy.c                                        |    4 
 net/nfc/llcp_core.c                                               |    2 
 net/rds/rdma_transport.c                                          |    8 
 net/rds/tcp_connect.c                                             |    2 
 net/sctp/associola.c                                              |    3 
 net/sctp/socket.c                                                 |    1 
 net/socket.c                                                      |   29 
 net/sunrpc/clnt.c                                                 |    4 
 net/tipc/crypto.c                                                 |    4 
 scripts/mod/file2alias.c                                          |    2 
 security/integrity/ima/Kconfig                                    |   21 
 security/smack/smack.h                                            |    1 
 security/smack/smack_lsm.c                                        |   65 
 sound/pci/hda/hda_intel.c                                         |    1 
 sound/soc/fsl/imx-audmix.c                                        |    2 
 sound/soc/meson/axg-spdifin.c                                     |   49 
 tools/include/linux/btf_ids.h                                     |    2 
 tools/include/uapi/linux/bpf.h                                    |    4 
 tools/perf/util/Build                                             |    6 
 tools/power/cpupower/Makefile                                     |    8 
 tools/power/cpupower/bench/Makefile                               |    2 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 tools/testing/selftests/kselftest_deps.sh                         |   77 
 tools/testing/selftests/net/tls.c                                 |   11 
 213 files changed, 4351 insertions(+), 3187 deletions(-)

Adam Ford (1):
      bus: ti-sysc: Fix missing AM35xx SoC matching

Ahmed S. Darwish (1):
      seqlock: Prefix internal seqcount_t-only macros with a "do_"

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Andrey Ryabinin (1):
      sched/cpuacct: Fix user/system in shown cpuacct.usage*

Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Arnaldo Carvalho de Melo (1):
      perf build: Define YYNOMEM as YYNOABORT for bison < 3.81

Arnd Bergmann (3):
      seqlock: avoid -Wshadow warnings
      wifi: iwlwifi: dbg_ini: fix structure packing
      ima: rework CONFIG_IMA dependency block

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Wolsieffer (2):
      proc: nommu: /proc/<pid>/maps: release mmap read lock
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Coddington (2):
      NFS: Cleanup unused rpc_clnt variable
      NFS: rename nfs_client_kset to nfs_kset

Benjamin Gray (1):
      powerpc/watchpoints: Disable preemption in thread_change_pc()

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Bryan O'Donoghue (3):
      media: venus: core: Add io base variables for each block
      media: venus: hfi,pm,firmware: Convert to block relative addressing
      media: venus: core: Add differentiator IS_V6(core)

Carl Philipp Klemm (1):
      ARM: dts: motorola-mapphone: Add 1.2GHz OPP

Chengfeng Ye (1):
      tipc: fix a potential deadlock on &tx->lock

Chengming Zhou (3):
      sched/cpuacct: Fix charge percpu cpuusage
      sched/cpuacct: Optimize away RCU read lock
      cgroup: Fix suspicious rcu_dereference_check() usage warning

Christoph Hellwig (3):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
      nvme-pci: factor the iod mempool creation into a helper
      nvme-pci: factor out a nvme_pci_alloc_dev helper

Christophe JAILLET (2):
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Damien Le Moal (3):
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-core: Do not register PM operations for SAS ports

Dan Carpenter (3):
      power: supply: ucs1002: fix error code in ucs1002_get_property()
      net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()
      of: dynamic: Fix potential memory leak in of_changeset_action()

Daniel Starke (1):
      Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Dikshita Agarwal (2):
      media: venus: hfi: Define additional 6xx registers
      media: venus: hfi: Add a 6xx boot logic

Dinghao Liu (2):
      spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Dmitry Monakhov (1):
      ext4: mark group as trimmed only if it was fully scanned

Duje Mihanović (1):
      gpio: pxa: disable pinctrl calls for MMP_GPIO

Eric Dumazet (3):
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()
      net: fix possible store tearing in neigh_periodic_work()

Fabio Estevam (1):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Fedor Pchelkin (1):
      dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Felix Fietkau (1):
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Florian Westphal (10):
      netfilter: nf_tables: don't skip expired elements during walk
      netfilter: nf_tables: don't fail inserts if duplicate has expired
      netfilter: nf_tables: defer gc run if previous batch is still pending
      netfilter: nf_tables: fix memleak when more than 255 elements expired
      netfilter: nf_tables: add and use nft_sk helper
      netfilter: nf_tables: add and use nft_thoff helper
      netfilter: exthdr: add support for tcp option removal
      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure
      netfilter: nf_tables: fix kdoc warnings after gc rework
      netfilter: nftables: exthdr: fix 4-byte stack OOB write

Geert Uytterhoeven (1):
      ARM: dts: motorola-mapphone: Drop second ti,wlcore compatible value

Gireesh Hiremath (1):
      ARM: dts: am335x: Guardian: Update beeper label

Greg Kroah-Hartman (3):
      Revert "clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz"
      Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"
      Linux 5.10.198

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Gustavo A. R. Silva (2):
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
      wifi: mwifiex: Fix tlv_buf_left calculation

Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Hannes Reinecke (1):
      ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones

Hans Verkuil (1):
      media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (4):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning

Huacai Chen (1):
      Input: i8042 - rename i8042-x86ia64io.h to i8042-acpipnpio.h

Ilya Dryomov (4):
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

Ivan Babrou (1):
      cpupower: add Makefile dependencies for install targets

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

Jan Engelhardt (1):
      netfilter: use actual socket sk for REJECT action

Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Javed Hasan (1):
      scsi: qedf: Add synchronization between I/O completions and abort

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Jerome Brunet (1):
      ASoC: meson: spdifin: start hw on dai probe

Jian Shen (1):
      net: hns3: only enable unicast promisc when mac table full

Jie Wang (1):
      net: hns3: add 5ms delay before clear firmware reset irq source

Jiri Olsa (1):
      bpf: Fix BTF_ID symbol generation collision

Johan Hovold (1):
      spi: zynqmp-gqspi: fix clock imbalance on probe failure

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Jordan Rife (2):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Josh Poimboeuf (2):
      x86/srso: Fix srso_show_state() side effect
      x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Julien Panis (1):
      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Kailang Yang (1):
      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Kees Cook (1):
      selftests/tls: Add {} to avoid static checker warning

Kemeng Shi (1):
      ext4: replace the traditional ternary conditional operator with with max()/min()

Konrad Dybcio (1):
      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Krzysztof Kozlowski (1):
      ARM: dts: omap: correct indentation

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Leon Hwang (1):
      bpf: Fix tr dereferencing

Leon Romanovsky (2):
      RDMA/core: Require admin capabilities to set system parameters
      RDMA/cma: Fix truncation compilation warning in make_cma_ports

Lukas Bulwahn (1):
      ext4: scope ret locally in ext4_try_to_trim_range()

Lukas Czerner (1):
      ext4: change s_last_trim_minblks type to unsigned long

Mario Limonciello (2):
      ata: ahci: Rename board_ahci_mobile
      ACPI: Check StorageD3Enable _DSD property in ACPI code

Mark Zhang (1):
      RDMA/cma: Initialize ib_sa_multicast structure to 0 when join

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Michal Grzedzicki (2):
      scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command
      scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command

Mika Westerberg (3):
      watchdog: iTCO_wdt: No need to stop the timer in probe
      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Ming Lei (1):
      block: fix use-after-free of q->q_usage_counter

Nathan Chancellor (1):
      drm/mediatek: Fix backport issue in mtk_drm_gem_prime_vmap()

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

Niklas Cassel (2):
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Pablo Neira Ayuso (18):
      netfilter: nf_tables: integrate pipapo into commit protocol
      netfilter: nf_tables: GC transaction API to avoid race with control plane
      netfilter: nf_tables: adapt set backend to use GC transaction API
      netfilter: nft_set_hash: mark set element as dead when deleting from packet path
      netfilter: nf_tables: remove busy mark and gc batch API
      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list
      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
      netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
      netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: disallow element removal on anonymous sets
      netfilter: nf_tables: unregister flowtable hooks on netns exit
      netfilter: nf_tables: double hook unregistration in netns path
      netfilter: nft_exthdr: break evaluation if setting TCP option fails
      netfilter: nf_tables: disallow rule removal from chain binding

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Paul Menzel (2):
      ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
      ata: ahci: Add support for AMD A85 FCH (Hudson D4)

Peter Zijlstra (1):
      seqlock: Rename __seqprop() users

Phil Sutter (3):
      netfilter: nft_exthdr: Support SCTP chunks
      netfilter: nft_exthdr: Search chunks in SCTP packets only
      netfilter: nft_exthdr: Fix for unsafe packet data read

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Qu Wenruo (1):
      btrfs: reset destination buffer when read_extent_buffer() gets invalid range

Randy Dunlap (2):
      xtensa: iss/network: make functions static
      xtensa: boot: don't add include-dirs

Ricardo B. Marliere (1):
      selftests: fix dependency checker script

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Rob Herring (1):
      arm64: Add Cortex-A520 CPU part definition

Roberto Sassu (2):
      smack: Record transmuting in smk_transmuted
      smack: Retrieve transmuting information in smack_inode_getsecurity()

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Sebastian Andrzej Siewior (2):
      locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI

Sergey Senozhatsky (1):
      dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock

Shay Drory (1):
      RDMA/mlx5: Fix NULL string error

Shengjiu Wang (1):
      ASoC: imx-audmix: Fix return error with devm_clk_get()

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Stanislav Fomichev (1):
      bpf: Clarify error expectations from bpf_clone_redirect

Stephen Boyd (4):
      platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
      platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()
      platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
      platform/x86: intel_scu_ipc: Fail IPC send if still busy

Steven Rostedt (Google) (4):
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have event inject files inc the trace array ref count
      ring-buffer: Do not attempt to read past "commit"
      ring-buffer: Update "shortest_full" in polling

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Tony Lindgren (5):
      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
      ARM: dts: motorola-mapphone: Configure lower temperature passive cooling
      ARM: dts: Unify pwm-omap-dmtimer node names
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Trond Myklebust (6):
      NFS: Use the correct commit info in nfs_join_page_group()
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      Revert "SUNRPC dont update timeout value on connection reset"
      NFSv4: Fix a state manager thread deadlock regression
      NFSv4: Fix a nfs4_state_manager() race

Vishal Goel (1):
      Smack:- Use overlay inode label in smack_inode_copy_up()

Vlastimil Babka (1):
      ring-buffer: remove obsolete comment for free_buffer_page()

Wang Jianchao (2):
      ext4: remove the 'group' parameter of ext4_trim_extent
      ext4: add new helper interface ext4_try_to_trim_range()

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

Werner Fischer (1):
      ata: ahci: Add Elkhart Lake AHCI controller

Werner Sembach (1):
      Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

William A. Kennington III (1):
      i2c: npcm7xx: Fix callback completion ordering

Wolfram Sang (5):
      mmc: renesas_sdhi: probe into TMIO after SCC parameters have been setup
      mmc: renesas_sdhi: populate SCC pointer at the proper place
      mmc: tmio: support custom irq masks
      mmc: renesas_sdhi: register irqs before registering controller
      mmc: renesas_sdhi: only reset SCC when its pointer is populated

Xiao Liang (1):
      netfilter: nft_exthdr: Fix non-linear header modification

Xiaoke Wang (1):
      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Xin Long (3):
      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Zheng Yejian (3):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()
      ring-buffer: Fix bytes info in per_cpu buffer stats

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

