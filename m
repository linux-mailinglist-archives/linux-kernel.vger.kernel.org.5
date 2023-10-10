Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401D77C40A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbjJJUE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJJUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC610A;
        Tue, 10 Oct 2023 13:04:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78928C433C7;
        Tue, 10 Oct 2023 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968239;
        bh=9GvcD93QNjgbKNRjZrVVF8Z2jLW2w4vUEiJTTND8rJw=;
        h=From:To:Cc:Subject:Date:From;
        b=uLEtGlAE+0QqV8MdbXo7Jw7wYuthG/N7I7IPJvsJW28d7vmPohZbhpaC9iKuFyK+L
         orjU8GApz9EbP1yxIr0/8z/+KQB7oDXOkkmHLcE4B6sqkFNApWbxxAIHKbdzwvI7fQ
         BxY3x2U7VnnbcBDxuoE4iwEkAUiAh7/XWygcms7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.258
Date:   Tue, 10 Oct 2023 22:03:51 +0200
Message-ID: <2023101052-drearily-scrabble-c5d4@gregkh>
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

I'm announcing the release of the 5.4.258 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
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
 arch/parisc/include/asm/ldcw.h                                    |   36 
 arch/parisc/include/asm/ropes.h                                   |    3 
 arch/parisc/include/asm/spinlock_types.h                          |    5 
 arch/parisc/kernel/drivers.c                                      |    2 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/kernel/hw_breakpoint.c                               |    9 
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 arch/xtensa/boot/Makefile                                         |    3 
 arch/xtensa/boot/lib/zmem.c                                       |    5 
 arch/xtensa/include/asm/core.h                                    |    4 
 arch/xtensa/platforms/iss/network.c                               |    4 
 drivers/ata/ahci.c                                                |    9 
 drivers/ata/libahci.c                                             |   35 
 drivers/ata/libata-core.c                                         |   60 +
 drivers/ata/libata-eh.c                                           |   13 
 drivers/ata/libata-scsi.c                                         |    2 
 drivers/ata/libata-transport.c                                    |    9 
 drivers/ata/libata.h                                              |    2 
 drivers/base/regmap/regcache-rbtree.c                             |    3 
 drivers/block/rbd.c                                               |  420 +++++-----
 drivers/bus/ti-sysc.c                                             |   22 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/gpio/gpio-aspeed.c                                        |    2 
 drivers/gpio/gpio-pmic-eic-sprd.c                                 |    1 
 drivers/gpio/gpio-pxa.c                                           |    1 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c           |   69 +
 drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h            |    1 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/infiniband/core/cma_configfs.c                            |    2 
 drivers/infiniband/core/nldev.c                                   |    1 
 drivers/infiniband/core/uverbs_main.c                             |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                |    2 
 drivers/infiniband/hw/mlx5/main.c                                 |    2 
 drivers/infiniband/sw/siw/siw_cm.c                                |   16 
 drivers/input/serio/i8042-x86ia64io.h                             |    7 
 drivers/mtd/ubi/build.c                                           |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                                  |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                               |   31 
 drivers/net/dsa/mv88e6xxx/global1.h                               |    1 
 drivers/net/dsa/mv88e6xxx/global2.c                               |    2 
 drivers/net/dsa/mv88e6xxx/global2.h                               |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |    5 
 drivers/net/ethernet/intel/i40e/i40e_dcb.c                        |    4 
 drivers/net/ethernet/intel/i40e/i40e_dcb.h                        |    3 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                        |   61 -
 drivers/net/ethernet/intel/i40e/i40e_prototype.h                  |   10 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                |  319 ++++---
 drivers/net/ethernet/qlogic/qed/qed_ll2.h                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c                 |    7 
 drivers/net/team/team.c                                           |   10 
 drivers/net/thunderbolt.c                                         |    3 
 drivers/net/usb/smsc75xx.c                                        |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                                    |   12 
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h                |    6 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c              |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                     |   16 
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c               |    7 
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c                |   13 
 drivers/nvme/host/pci.c                                           |    2 
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/pci/controller/dwc/pcie-qcom.c                            |    2 
 drivers/s390/scsi/zfcp_aux.c                                      |    9 
 drivers/scsi/qla2xxx/qla_init.c                                   |   21 
 drivers/scsi/qla2xxx/qla_target.c                                 |   12 
 drivers/spi/spi-nxp-fspi.c                                        |    7 
 drivers/target/target_core_device.c                               |   11 
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/video/fbdev/Kconfig                                       |    2 
 drivers/watchdog/iTCO_wdt.c                                       |   26 
 drivers/xen/events/events_base.c                                  |   85 +-
 drivers/xen/events/events_internal.h                              |    2 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/super.c                                                  |    2 
 fs/ext4/ext4.h                                                    |    2 
 fs/ext4/mballoc.c                                                 |  138 +--
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nfs/internal.h                                                 |    4 
 fs/nfs/nfs4state.c                                                |   10 
 fs/nfs/nfs4trace.h                                                |   93 ++
 fs/nfs/super.c                                                    |   35 
 fs/nilfs2/gcinode.c                                               |    6 
 include/linux/if_team.h                                           |    2 
 include/linux/libata.h                                            |    6 
 include/linux/netfilter/nf_conntrack_sctp.h                       |    1 
 include/net/tcp.h                                                 |    6 
 include/uapi/linux/bpf.h                                          |    4 
 kernel/bpf/queue_stack_maps.c                                     |   21 
 kernel/trace/ring_buffer.c                                        |    5 
 kernel/trace/trace.c                                              |   27 
 kernel/trace/trace.h                                              |    2 
 kernel/trace/trace_events.c                                       |    6 
 net/bridge/br_forward.c                                           |    4 
 net/bridge/br_input.c                                             |    4 
 net/core/neighbour.c                                              |    4 
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/ipv4/route.c                                                  |    4 
 net/ipv4/tcp_input.c                                              |   13 
 net/ipv4/tcp_output.c                                             |    7 
 net/l2tp/l2tp_ip6.c                                               |    2 
 net/ncsi/ncsi-aen.c                                               |    5 
 net/netfilter/ipset/ip_set_core.c                                 |   12 
 net/netfilter/ipvs/ip_vs_sync.c                                   |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                           |   43 -
 net/netfilter/nf_tables_api.c                                     |    9 
 net/nfc/llcp_core.c                                               |    2 
 net/rds/rdma_transport.c                                          |    8 
 net/rds/tcp_connect.c                                             |    2 
 net/sctp/associola.c                                              |    3 
 net/sctp/socket.c                                                 |    1 
 net/socket.c                                                      |   29 
 net/sunrpc/clnt.c                                                 |    1 
 scripts/mod/file2alias.c                                          |    2 
 security/integrity/ima/Kconfig                                    |   20 
 security/smack/smack.h                                            |    1 
 security/smack/smack_lsm.c                                        |   65 +
 sound/pci/hda/hda_intel.c                                         |    1 
 sound/soc/fsl/imx-audmix.c                                        |    2 
 sound/soc/meson/axg-spdifin.c                                     |   49 -
 tools/include/uapi/linux/bpf.h                                    |    4 
 tools/power/cpupower/Makefile                                     |    8 
 tools/power/cpupower/bench/Makefile                               |    2 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 tools/testing/selftests/net/tls.c                                 |   11 
 133 files changed, 1426 insertions(+), 809 deletions(-)

Aleksandr Loktionov (1):
      i40e: Remove scheduling while atomic possibility

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Amanda Liu (1):
      drm/amd/display: Reinstate LFC optimization

Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Anthony Koo (1):
      drm/amd/display: Fix LFC multiplier changing erratically

Arnd Bergmann (2):
      wifi: iwlwifi: dbg_ini: fix structure packing
      ima: rework CONFIG_IMA dependency block

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Gray (1):
      powerpc/watchpoints: Annotate atomic context in more places

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Christoph Hellwig (1):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled

Christophe JAILLET (2):
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Chuck Lever (1):
      NFS4: Trace state recovery operation

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
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()
      net: fix possible store tearing in neigh_periodic_work()

Fabio Estevam (1):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Felix Fietkau (1):
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Greg Kroah-Hartman (2):
      Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"
      Linux 5.4.258

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Gustavo A. R. Silva (2):
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
      wifi: mwifiex: Fix tlv_buf_left calculation

Hamza Mahfooz (1):
      drm/amd/display: prevent potential division by zero errors

Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (4):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning

Himanshu Madhani (1):
      scsi: qla2xxx: Fix update_fcport for current_topology

Ilya Dryomov (4):
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Ivan Babrou (1):
      cpupower: add Makefile dependencies for install targets

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Jerome Brunet (1):
      ASoC: meson: spdifin: start hw on dai probe

Jie Wang (1):
      net: hns3: add 5ms delay before clear firmware reset irq source

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Jordan Rife (2):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Kailang Yang (1):
      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Karen Sornek (1):
      i40e: Fix warning message and call stack during rmmod i40e driver

Kees Cook (1):
      selftests/tls: Add {} to avoid static checker warning

Kemeng Shi (1):
      ext4: replace the traditional ternary conditional operator with with max()/min()

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Leon Romanovsky (2):
      RDMA/core: Require admin capabilities to set system parameters
      RDMA/cma: Fix truncation compilation warning in make_cma_ports

Lukas Bulwahn (1):
      ext4: scope ret locally in ext4_try_to_trim_range()

Lukas Czerner (1):
      ext4: change s_last_trim_minblks type to unsigned long

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Mika Westerberg (3):
      watchdog: iTCO_wdt: No need to stop the timer in probe
      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Niklas Cassel (3):
      ata: libata: disallow dev-initiated LPM transitions to unsupported states
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disallow element removal on anonymous sets

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Quinn Tran (1):
      scsi: qla2xxx: Fix deletion race condition

Randy Dunlap (2):
      xtensa: iss/network: make functions static
      xtensa: boot: don't add include-dirs

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Roberto Sassu (2):
      smack: Record transmuting in smk_transmuted
      smack: Retrieve transmuting information in smack_inode_getsecurity()

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Shay Drory (1):
      RDMA/mlx5: Fix NULL string error

Shengjiu Wang (1):
      ASoC: imx-audmix: Fix return error with devm_clk_get()

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Stanislav Fomichev (1):
      bpf: Clarify error expectations from bpf_clone_redirect

Stefan Assmann (3):
      i40e: improve locking of mac_filter_hash
      i40e: always propagate error value in i40e_set_vsi_promisc()
      i40e: fix return of uninitialized aq_ret in i40e_set_vsi_promisc

Steven Rostedt (Google) (2):
      tracing: Increase trace array ref count on enable and filter files
      ring-buffer: Update "shortest_full" in polling

Sylwia Wnuczko (1):
      i40e: Fix for persistent lldp support

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Tony Lindgren (2):
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Trond Myklebust (5):
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      NFS: Add a helper nfs_client_for_each_server()
      NFSv4: Fix a nfs4_state_manager() race
      NFS: Fix a race in __nfs_list_for_each_server()

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

Xin Long (3):
      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Zheng Yejian (2):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

