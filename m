Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426AC7C4097
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjJJUEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbjJJUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:03:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF35135;
        Tue, 10 Oct 2023 13:03:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6324DC433C7;
        Tue, 10 Oct 2023 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968223;
        bh=k7SryXN724bxGn0nu+CSRV6XEWCIBF6cULLJpZDOpig=;
        h=From:To:Cc:Subject:Date:From;
        b=eadOLinwxPb7V8+KqMVaNtnmVqb1KM7egHHcwoEvUGWc3J170xgGmsKXiuBNzB5oJ
         6ZsUelGy1Hm7bmUodI+7ArLoFbFN9UjDQGdy6zk3zGU397b0kn3PzdAYv2XtSFDOFd
         RUu+S3EmNwjCgwVJDqchaFHJOSmAO+an5+laKXg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.327
Date:   Tue, 10 Oct 2023 22:03:39 +0200
Message-ID: <2023101040-reattach-dubbed-fd03@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

I'm announcing the release of the 4.14.327 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/parisc/include/asm/ldcw.h                                    |   36 ++-
 arch/parisc/include/asm/ropes.h                                   |    3 
 arch/parisc/include/asm/spinlock_types.h                          |    5 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 arch/xtensa/boot/Makefile                                         |    3 
 arch/xtensa/boot/lib/zmem.c                                       |    5 
 drivers/ata/ahci.c                                                |   13 +
 drivers/ata/ahci_xgene.c                                          |    4 
 drivers/ata/libahci.c                                             |   49 ++---
 drivers/ata/libata-core.c                                         |   58 ++++--
 drivers/ata/libata-eh.c                                           |   13 -
 drivers/ata/libata-scsi.c                                         |    2 
 drivers/base/regmap/regcache-rbtree.c                             |    3 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/gpio/gpio-aspeed.c                                        |    2 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/infiniband/core/cma_configfs.c                            |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                |    2 
 drivers/infiniband/hw/mlx5/main.c                                 |    2 
 drivers/media/dvb-frontends/sp8870.c                              |    2 
 drivers/media/tuners/tuner-xc2028.c                               |    2 
 drivers/mtd/ubi/build.c                                           |    7 
 drivers/net/team/team.c                                           |   10 -
 drivers/net/usb/smsc75xx.c                                        |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                                    |   12 +
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c              |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                     |   16 -
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/s390/scsi/zfcp_aux.c                                      |    9 
 drivers/target/target_core_device.c                               |   11 -
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/tty/vt/vc_screen.c                                        |   11 -
 drivers/video/fbdev/Kconfig                                       |    2 
 drivers/watchdog/iTCO_wdt.c                                       |   26 ++
 drivers/xen/events/events_base.c                                  |   92 +++++-----
 drivers/xen/events/events_internal.h                              |    4 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/super.c                                                  |    2 
 fs/ext4/namei.c                                                   |   26 +-
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nilfs2/gcinode.c                                               |    6 
 include/linux/if_team.h                                           |    2 
 include/linux/libata.h                                            |    6 
 kernel/trace/ring_buffer.c                                        |    2 
 net/core/rtnetlink.c                                              |   12 -
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/ipv4/route.c                                                  |    4 
 net/ipv4/tcp_input.c                                              |   13 +
 net/l2tp/l2tp_ip6.c                                               |    2 
 net/sched/sch_hfsc.c                                              |    2 
 net/sctp/associola.c                                              |    3 
 net/sctp/socket.c                                                 |    1 
 scripts/mod/file2alias.c                                          |    2 
 tools/power/cpupower/Makefile                                     |    8 
 tools/power/cpupower/bench/Makefile                               |    2 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 63 files changed, 345 insertions(+), 222 deletions(-)

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Budimir Markovic (1):
      net/sched: sch_hfsc: Ensure inner classes have fsc curve

Christophe JAILLET (2):
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Damien Le Moal (2):
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Dinghao Liu (1):
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Eric Dumazet (1):
      dccp: fix dccp_v4_err()/dccp_v6_err() again

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Greg Kroah-Hartman (3):
      media: dvb: symbol fixup for dvb_attach() - again
      Revert "rtnetlink: Reject negative ifindexes in RTM_NEWLINK"
      Linux 4.14.327

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Gustavo A. R. Silva (1):
      wifi: mwifiex: Fix tlv_buf_left calculation

Hannes Reinecke (1):
      ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (3):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: iosapic.c: Fix sparse warnings
      parisc: irq: Make irq_stack_union static to avoid sparse warning

Ido Schimmel (1):
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Ivan Babrou (1):
      cpupower: add Makefile dependencies for install targets

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Leon Romanovsky (1):
      RDMA/cma: Fix truncation compilation warning in make_cma_ports

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Max Filippov (1):
      xtensa: boot/lib: fix function prototypes

Mika Westerberg (2):
      watchdog: iTCO_wdt: No need to stop the timer in probe
      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running

Neal Cardwell (1):
      tcp: fix delayed ACKs for MSS boundary condition

Niklas Cassel (3):
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES
      ata: libata: disallow dev-initiated LPM transitions to unsupported states

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Randy Dunlap (1):
      xtensa: boot: don't add include-dirs

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Shay Drory (1):
      RDMA/mlx5: Fix NULL string error

Shida Zhang (1):
      ext4: fix rec_len verify error

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Trond Myklebust (1):
      NFS/pNFS: Report EINVAL errors from connect() to the server

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

