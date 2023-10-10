Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4A7C409A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjJJUEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjJJUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1529B113;
        Tue, 10 Oct 2023 13:03:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11761C433CA;
        Tue, 10 Oct 2023 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968232;
        bh=uKKq4//sYwmv0tNvbSJUjcyOY7XGiGnfc3mfyymDUh4=;
        h=From:To:Cc:Subject:Date:From;
        b=AoZljv5mkrj90Obhv59AY5lP3siPIKQ/jWIkYLEwuaRxUE26RwOaBP7WdPreTBv7g
         9Zh68/ihx5XmpAc4/FanVEL2XADarXvHVw+F1oCfug9Xsae61W8l7dg+flGz5ypi+O
         CNtyWD/ldUSyKh0QexoM6C4OaprmFoFHzlWIKroE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.296
Date:   Tue, 10 Oct 2023 22:03:45 +0200
Message-ID: <2023101045-knickers-preshow-9c49@gregkh>
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

I'm announcing the release of the 4.19.296 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/arm/boot/dts/omap4-droid4-xt894.dts                          |    4 
 arch/mips/alchemy/devboards/db1000.c                              |    4 
 arch/mips/alchemy/devboards/db1200.c                              |    6 
 arch/mips/alchemy/devboards/db1300.c                              |    4 
 arch/parisc/include/asm/ldcw.h                                    |   36 +-
 arch/parisc/include/asm/ropes.h                                   |    3 
 arch/parisc/include/asm/spinlock_types.h                          |    5 
 arch/parisc/kernel/drivers.c                                      |    2 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 drivers/ata/ahci.c                                                |   13 
 drivers/ata/ahci_xgene.c                                          |    4 
 drivers/ata/libahci.c                                             |   49 +--
 drivers/ata/libata-core.c                                         |   60 +++-
 drivers/ata/libata-eh.c                                           |   13 
 drivers/ata/libata-scsi.c                                         |    2 
 drivers/ata/libata-transport.c                                    |    9 
 drivers/ata/libata.h                                              |    2 
 drivers/base/arch_topology.c                                      |    2 
 drivers/base/cacheinfo.c                                          |   18 -
 drivers/base/core.c                                               |    8 
 drivers/base/cpu.c                                                |   34 +-
 drivers/base/firmware_loader/fallback.c                           |    2 
 drivers/base/memory.c                                             |   24 -
 drivers/base/node.c                                               |   34 +-
 drivers/base/platform.c                                           |    2 
 drivers/base/power/sysfs.c                                        |   50 +--
 drivers/base/regmap/regcache-rbtree.c                             |    3 
 drivers/base/soc.c                                                |    8 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/gpio/gpio-aspeed.c                                        |    2 
 drivers/gpio/gpio-pmic-eic-sprd.c                                 |    1 
 drivers/gpio/gpio-pxa.c                                           |    1 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/infiniband/core/cma_configfs.c                            |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                |    2 
 drivers/infiniband/hw/mlx5/main.c                                 |    2 
 drivers/input/serio/i8042-x86ia64io.h                             |    7 
 drivers/media/dvb-frontends/sp8870.c                              |    2 
 drivers/media/tuners/tuner-xc2028.c                               |    2 
 drivers/mtd/ubi/build.c                                           |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |    5 
 drivers/net/ethernet/qlogic/qed/qed_ll2.h                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c                 |    7 
 drivers/net/team/team.c                                           |   10 
 drivers/net/thunderbolt.c                                         |    3 
 drivers/net/usb/smsc75xx.c                                        |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                                    |   12 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c              |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                     |   16 -
 drivers/nvme/host/pci.c                                           |    2 
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/pci/controller/dwc/pcie-qcom.c                            |    2 
 drivers/s390/scsi/zfcp_aux.c                                      |    9 
 drivers/scsi/megaraid/megaraid_sas.h                              |    5 
 drivers/scsi/megaraid/megaraid_sas_base.c                         |   44 ++-
 drivers/scsi/megaraid/megaraid_sas_fusion.c                       |   18 +
 drivers/scsi/qla2xxx/qla_attr.c                                   |    2 
 drivers/scsi/qla2xxx/qla_dbg.c                                    |    2 
 drivers/scsi/qla2xxx/qla_os.c                                     |   45 ++-
 drivers/target/target_core_device.c                               |   11 
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/video/fbdev/Kconfig                                       |    2 
 drivers/watchdog/iTCO_wdt.c                                       |   26 +
 drivers/xen/events/events_base.c                                  |   85 +++---
 drivers/xen/events/events_internal.h                              |    2 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/super.c                                                  |    2 
 fs/ext4/ext4.h                                                    |    2 
 fs/ext4/mballoc.c                                                 |  138 +++++-----
 fs/ext4/namei.c                                                   |   26 +
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nilfs2/gcinode.c                                               |    6 
 include/linux/if_team.h                                           |    2 
 include/linux/libata.h                                            |    6 
 include/linux/netdevice.h                                         |   58 ++--
 include/net/dst.h                                                 |    5 
 include/net/tcp.h                                                 |    6 
 include/uapi/linux/bpf.h                                          |    4 
 kernel/trace/ring_buffer.c                                        |    2 
 net/bridge/br_forward.c                                           |    4 
 net/bridge/br_input.c                                             |    4 
 net/core/dev.c                                                    |   14 -
 net/core/rtnetlink.c                                              |   12 
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/ipv4/route.c                                                  |    4 
 net/ipv4/tcp_input.c                                              |   13 
 net/ipv4/tcp_output.c                                             |    7 
 net/l2tp/l2tp_ip6.c                                               |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                   |    4 
 net/netfilter/nf_tables_api.c                                     |    9 
 net/rds/tcp_connect.c                                             |    2 
 net/sctp/associola.c                                              |    3 
 net/sctp/socket.c                                                 |    1 
 scripts/mod/file2alias.c                                          |    2 
 security/smack/smack.h                                            |    1 
 security/smack/smack_lsm.c                                        |   65 +++-
 sound/pci/hda/hda_intel.c                                         |    1 
 tools/include/uapi/linux/bpf.h                                    |    4 
 tools/power/cpupower/Makefile                                     |    8 
 tools/power/cpupower/bench/Makefile                               |    2 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 tools/testing/selftests/net/tls.c                                 |   11 
 109 files changed, 747 insertions(+), 490 deletions(-)

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Christoph Hellwig (1):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled

Christophe JAILLET (2):
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Damien Le Moal (3):
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-core: Do not register PM operations for SAS ports

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Dinghao Liu (1):
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Dmitry Monakhov (1):
      ext4: mark group as trimmed only if it was fully scanned

Duje Mihanović (1):
      gpio: pxa: disable pinctrl calls for MMP_GPIO

Eric Dumazet (3):
      net: add atomic_long_t to net_device_stats fields
      net: bridge: use DEV_STATS_INC()
      dccp: fix dccp_v4_err()/dccp_v6_err() again

Felix Riemann (1):
      net: Fix unwanted sign extension in netdev_stats_to_stats64()

Greg Kroah-Hartman (5):
      Revert "drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions"
      media: dvb: symbol fixup for dvb_attach() - again
      Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"
      Revert "rtnetlink: Reject negative ifindexes in RTM_NEWLINK"
      Linux 4.19.296

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Gustavo A. R. Silva (2):
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
      wifi: mwifiex: Fix tlv_buf_left calculation

Hannes Reinecke (1):
      ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (4):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning

Ido Schimmel (1):
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Ivan Babrou (1):
      cpupower: add Makefile dependencies for install targets

Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Jie Wang (1):
      net: hns3: add 5ms delay before clear firmware reset irq source

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Jordan Rife (1):
      net: replace calls to sock->ops->connect() with kernel_connect()

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Junxiao Bi (2):
      scsi: megaraid_sas: Fix deadlock on firmware crashdump
      scsi: target: core: Fix deadlock due to recursive locking

Kailang Yang (1):
      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Kees Cook (1):
      selftests/tls: Add {} to avoid static checker warning

Kemeng Shi (1):
      ext4: replace the traditional ternary conditional operator with with max()/min()

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Leon Romanovsky (1):
      RDMA/cma: Fix truncation compilation warning in make_cma_ports

Lukas Bulwahn (1):
      ext4: scope ret locally in ext4_try_to_trim_range()

Lukas Czerner (1):
      ext4: change s_last_trim_minblks type to unsigned long

Manish Rangankar (1):
      scsi: qla2xxx: Remove unsupported ql2xenabledif option

Martin K. Petersen (1):
      scsi: qla2xxx: Add protection mask module parameters

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Mika Westerberg (3):
      watchdog: iTCO_wdt: No need to stop the timer in probe
      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Niklas Cassel (3):
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES
      ata: libata: disallow dev-initiated LPM transitions to unsupported states

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disallow element removal on anonymous sets

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Roberto Sassu (2):
      smack: Retrieve transmuting information in smack_inode_getsecurity()
      smack: Record transmuting in smk_transmuted

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Shay Drory (1):
      RDMA/mlx5: Fix NULL string error

Shida Zhang (1):
      ext4: fix rec_len verify error

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Shivasharan S (2):
      scsi: megaraid_sas: Load balance completions across all MSI-X
      scsi: megaraid_sas: Enable msix_load_balance for Invader and later controllers

Stanislav Fomichev (1):
      bpf: Clarify error expectations from bpf_clone_redirect

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Tony Lindgren (1):
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot

Trond Myklebust (1):
      NFS/pNFS: Report EINVAL errors from connect() to the server

Vishal Goel (1):
      Smack:- Use overlay inode label in smack_inode_copy_up()

Wang Jianchao (2):
      ext4: remove the 'group' parameter of ext4_trim_extent
      ext4: add new helper interface ext4_try_to_trim_range()

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

Werner Sembach (1):
      Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

Xiaoke Wang (1):
      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Xin Long (2):
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Zheng Yejian (2):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

