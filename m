Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCC778BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjHKKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjHKKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78B35A3;
        Fri, 11 Aug 2023 03:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FCDE63525;
        Fri, 11 Aug 2023 10:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4DDC433B9;
        Fri, 11 Aug 2023 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691749053;
        bh=vWBq0f2ZSgf/mW6ovvyTWRbeZ4UCkLWivJimuwHZAwA=;
        h=From:To:Cc:Subject:Date:From;
        b=OJkNzy2FcKp9G+vkSZwZsoTaMZnajnKEpdsJ3zYGf4GUGdjMw2aq2D4Mz9C0XKZUC
         MJIAy9w7dIZL+hKgSWDXBvd9ecrA7tLVKDOTy8nNm4TL6V5dHvq2aYyD3Pho02bluF
         lOMRoIotPh01O4l59CSTGkdd303tPgOxpagnikgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.253
Date:   Fri, 11 Aug 2023 12:17:29 +0200
Message-ID: <2023081129-gains-striking-1702@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.253 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/security-bugs.rst                   |   39 +-
 Makefile                                                      |    2 
 arch/arm/boot/dts/imx35.dtsi                                  |    2 
 arch/arm/boot/dts/imx6qdl.dtsi                                |    6 
 arch/arm/boot/dts/imx6sl.dtsi                                 |    5 
 arch/arm/boot/dts/imx6sll.dtsi                                |   34 +-
 arch/arm/boot/dts/imx6sx.dtsi                                 |    5 
 arch/arm/boot/dts/imx6ul.dtsi                                 |    2 
 arch/arm/boot/dts/imx7d.dtsi                                  |    6 
 arch/arm/boot/dts/imx7s.dtsi                                  |    2 
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts        |    2 
 arch/arm64/include/asm/cputype.h                              |    6 
 arch/arm64/kernel/cpu_errata.c                                |    6 
 arch/powerpc/include/asm/word-at-a-time.h                     |    2 
 arch/powerpc/mm/init_64.c                                     |    3 
 arch/s390/kernel/sthyi.c                                      |    6 
 arch/s390/kvm/intercept.c                                     |    9 
 drivers/acpi/processor_perflib.c                              |   38 ++
 drivers/ata/pata_ns87415.c                                    |    2 
 drivers/base/core.c                                           |   44 +++
 drivers/base/power/power.h                                    |    8 
 drivers/base/power/runtime.c                                  |    6 
 drivers/base/power/wakeirq.c                                  |  111 ++++++-
 drivers/block/loop.c                                          |    2 
 drivers/char/tpm/tpm_tis_core.c                               |   10 
 drivers/cpufreq/intel_pstate.c                                |   14 
 drivers/gpio/gpio-tps68470.c                                  |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                         |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                   |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                 |   13 
 drivers/hwmon/nct7802.c                                       |    2 
 drivers/infiniband/hw/mlx4/qp.c                               |   18 -
 drivers/irqchip/irq-bcm6345-l1.c                              |   14 
 drivers/isdn/hardware/mISDN/hfcpci.c                          |   10 
 drivers/md/bcache/alloc.c                                     |   35 +-
 drivers/md/bcache/bcache.h                                    |    4 
 drivers/md/bcache/btree.c                                     |    6 
 drivers/md/bcache/super.c                                     |    2 
 drivers/md/dm-cache-policy-smq.c                              |   28 +
 drivers/md/dm-raid.c                                          |    9 
 drivers/mtd/nand/raw/meson_nand.c                             |    3 
 drivers/mtd/nand/raw/omap_elm.c                               |   24 -
 drivers/mtd/nand/spi/toshiba.c                                |    4 
 drivers/net/bonding/bond_main.c                               |    5 
 drivers/net/can/usb/gs_usb.c                                  |    2 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c               |    7 
 drivers/net/ethernet/emulex/benet/be_main.c                   |    3 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c     |    5 
 drivers/net/ethernet/xilinx/ll_temac_main.c                   |   16 -
 drivers/net/tap.c                                             |    2 
 drivers/net/team/team.c                                       |    9 
 drivers/net/tun.c                                             |    2 
 drivers/net/usb/cdc_ether.c                                   |   21 +
 drivers/net/usb/usbnet.c                                      |    6 
 drivers/net/usb/zaurus.c                                      |   21 +
 drivers/net/virtio_net.c                                      |    4 
 drivers/net/vxlan.c                                           |   22 -
 drivers/pci/pcie/aspm.c                                       |   55 ++-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                    |    2 
 drivers/platform/x86/msi-laptop.c                             |    8 
 drivers/pwm/pwm-meson.c                                       |   27 -
 drivers/s390/block/dasd_ioctl.c                               |    1 
 drivers/s390/scsi/zfcp_fc.c                                   |    6 
 drivers/scsi/qla2xxx/qla_os.c                                 |    5 
 drivers/staging/ks7010/ks_wlan_net.c                          |    6 
 drivers/tty/serial/8250/8250_dwlib.c                          |    6 
 drivers/tty/serial/sifive.c                                   |    2 
 drivers/usb/core/quirks.c                                     |    4 
 drivers/usb/dwc3/core.c                                       |   20 -
 drivers/usb/dwc3/core.h                                       |    3 
 drivers/usb/dwc3/dwc3-pci.c                                   |    6 
 drivers/usb/host/ohci-at91.c                                  |    8 
 drivers/usb/host/xhci-mtk.c                                   |    1 
 drivers/usb/host/xhci-tegra.c                                 |    8 
 drivers/usb/serial/option.c                                   |    6 
 drivers/usb/serial/usb-serial-simple.c                        |   73 ++---
 fs/btrfs/ctree.c                                              |    2 
 fs/btrfs/disk-io.c                                            |    5 
 fs/btrfs/ioctl.c                                              |    2 
 fs/btrfs/qgroup.c                                             |  116 +++++---
 fs/btrfs/qgroup.h                                             |    1 
 fs/btrfs/transaction.c                                        |   10 
 fs/ceph/caps.c                                                |   17 +
 fs/ceph/debugfs.c                                             |   13 
 fs/ceph/mds_client.c                                          |    5 
 fs/ceph/mds_client.h                                          |   14 
 fs/ceph/super.c                                               |   14 
 fs/dlm/plock.c                                                |  100 +++---
 fs/ext2/ext2.h                                                |   12 
 fs/ext2/super.c                                               |   23 -
 fs/ext4/ext4.h                                                |    2 
 fs/ext4/fsmap.c                                               |    8 
 fs/ext4/ioctl.c                                               |    5 
 fs/ext4/super.c                                               |   25 -
 fs/jbd2/checkpoint.c                                          |  137 ++-------
 fs/jbd2/journal.c                                             |   42 +-
 fs/jbd2/transaction.c                                         |   31 +-
 fs/super.c                                                    |   11 
 fs/sysv/itree.c                                               |    4 
 include/asm-generic/word-at-a-time.h                          |    2 
 include/linux/device.h                                        |    3 
 include/linux/jbd2.h                                          |    2 
 include/linux/pm_wakeirq.h                                    |    9 
 include/net/ipv6.h                                            |    8 
 include/net/vxlan.h                                           |   13 
 include/uapi/linux/blkzoned.h                                 |   10 
 include/uapi/linux/watch_queue.h                              |   55 +++
 kernel/events/core.c                                          |    8 
 kernel/trace/ftrace.c                                         |   75 +++--
 kernel/trace/ring_buffer.c                                    |   22 -
 kernel/trace/trace.c                                          |   21 +
 kernel/trace/trace.h                                          |    2 
 kernel/trace/trace_events.c                                   |   14 
 lib/test_firmware.c                                           |   47 ++-
 net/bluetooth/l2cap_sock.c                                    |    2 
 net/ceph/osd_client.c                                         |   20 -
 net/core/rtnetlink.c                                          |    8 
 net/core/sock.c                                               |   21 -
 net/core/sock_map.c                                           |    2 
 net/dcb/dcbnl.c                                               |    2 
 net/ipv4/tcp_metrics.c                                        |   70 +++-
 net/ipv6/addrconf.c                                           |   14 
 net/ipv6/ip6mr.c                                              |    2 
 net/sched/cls_fw.c                                            |    1 
 net/sched/cls_route.c                                         |    1 
 net/sched/cls_u32.c                                           |   57 +++
 net/sched/sch_mqprio.c                                        |  144 ++++++----
 net/sched/sch_qfq.c                                           |    7 
 net/unix/af_unix.c                                            |    2 
 security/keys/request_key.c                                   |   35 +-
 sound/soc/codecs/cs42l51-i2c.c                                |    6 
 sound/soc/codecs/cs42l51.c                                    |    7 
 sound/soc/codecs/cs42l51.h                                    |    1 
 sound/soc/codecs/wm8904.c                                     |    3 
 sound/soc/fsl/fsl_spdif.c                                     |    2 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh       |    8 
 tools/testing/selftests/rseq/rseq.c                           |   31 +-
 140 files changed, 1441 insertions(+), 829 deletions(-)

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Alexander Aring (3):
      dlm: cleanup plock_op vs plock_xop
      dlm: rearrange async condition return
      fs: dlm: interrupt posix locks only when process is killed

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Andreas Kemnade (1):
      ARM: dts: imx6sll: fixup of operating points

Andrzej Hajda (1):
      driver core: add device probe log helper

Andy Shevchenko (1):
      driver core: Annotate dev_err_probe() with __must_check

Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Arnd Bergmann (1):
      ata: pata_ns87415: mark ns87560_tf_read static

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix OOB available bytes for ECC

Bart Van Assche (2):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h
      loop: Select I/O scheduler 'none' from inside add_disk()

Bjorn Helgaas (1):
      PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Chao Yu (1):
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Chengfeng Ye (1):
      mISDN: hfcpci: Fix potential deadlock on &hc->lock

Chunfeng Yun (1):
      PM / wakeirq: support enabling wake-up irq after runtime_suspend called

Chunguang Xu (1):
      ext4: rename journal_dev to s_journal_dev inside ext4_sb_info

Colin Ian King (1):
      pwm: meson: Remove redundant assignment to variable fin_freq

Coly Li (1):
      bcache: remove 'int n' from parameter list of bch_bucket_alloc_set()

D Scott Phillips (2):
      arm64: Add AMPERE1 to the Spectre-BHB affected list
      arm64: Fix bit-shifting UB in the MIDR_CPU_MODEL() macro

Dan Carpenter (3):
      RDMA/mlx4: Make check for invalid flags stricter
      Revert "usb: xhci: tegra: Fix error check"
      net: ll_temac: fix error checking of irq_of_parse_and_map()

David Howells (1):
      uapi: General notification queue definitions

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Dmitry Baryshkov (1):
      drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Eric Dumazet (12):
      net: annotate data-races around sk->sk_max_pacing_rate
      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Filipe Manana (5):
      btrfs: fix race between quota disable and relocation
      btrfs: fix extent buffer leak after tree mod log failure at split_node()
      btrfs: check for commit error at btrfs_attach_transaction_barrier()
      btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
      btrfs: fix race between quota disable and quota assign ioctls

Gaosheng Cui (1):
      drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Georg Müller (1):
      perf test uprobe_from_different_cu: Skip if there is no gcc

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (4):
      Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Revert "driver core: Annotate dev_err_probe() with __must_check"
      Linux 5.4.253

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Heiko Carstens (1):
      KVM: s390: fix sthyi error handling

Heiner Kallweit (1):
      pwm: meson: fix handling of period/duty if greater than UINT_MAX

Ilpo Järvinen (2):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race

Ilya Dryomov (1):
      libceph: fix potential hang in ceph_osdc_notify()

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Jan Kara (2):
      fs: Protect reconfiguration of sb read-write from racing writes
      ext2: Drop fragment support

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jeff Layton (2):
      ceph: show tasks waiting on caps in debugfs caps file
      ceph: use kill_anon_super helper

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jiri Benc (1):
      vxlan: calculate correct header length for GPE

Jisheng Zhang (1):
      usb: dwc3: don't reset device side if dwc3 was configured as host-only

Joe Thornber (1):
      dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Johan Hovold (2):
      USB: serial: simple: sort driver entries
      PM: sleep: wakeirq: fix wake irq arming

Jonas Gorski (1):
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Krzysztof Kozlowski (1):
      ARM: dts: imx: Align L2 cache-controller nodename with dtschema

Laszlo Ersek (2):
      net: tun_chr_open(): set sk_uid from current_fsuid()
      net: tap_open(): set sk_uid from current_fsuid()

Lin Ma (3):
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
      net: dcb: choose correct policy to parse DCB_ATTR_BCN

Linus Torvalds (1):
      ftrace: Store the order of pages allocated in ftrace_page

Maciej Żenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Marcos Paulo de Souza (2):
      btrfs: qgroup: remove one-time use variables for quota_root checks
      btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not enabled

Mark Brown (1):
      ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Mauro Carvalho Chehab (2):
      jbd2: fix kernel-doc markups
      drivers: core: fix kernel-doc markup for dev_err_probe()

Maxim Mikityanskiy (1):
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Michael Jeanson (1):
      selftests/rseq: check if libc rseq support is registered

Michał Mirosław (1):
      driver code: print symbolic error code

Mirsad Goran Todorovac (2):
      test_firmware: prevent race conditions by a correct implementation of locking
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Nilesh Javali (1):
      scsi: qla2xxx: Array index may go out of bound

Oliver Neukum (1):
      USB: serial: simple: add Kaufmann RKS+CAN VCP

Olivier Maignial (1):
      mtd: spinand: toshiba: Fix ecc_get_status

Pedro Tammela (1):
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Peng Fan (1):
      ARM: dts: imx: add usb alias

Peter Zijlstra (1):
      perf: Fix function pointer case

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Prince Kumar Maurya (1):
      fs/sysv: Null check to prevent null-ptr-deref bug

Qu Wenruo (1):
      btrfs: qgroup: catch reserved space leaks at unmount time

Rafael J. Wysocki (3):
      ACPI: processor: perflib: Use the "no limit" frequency QoS
      ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily
      cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rob Clark (1):
      drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Sean Christopherson (1):
      selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Shengjiu Wang (1):
      ARM: dts: imx6sll: Make ssi node name same as other platforms

Stefan Haberland (1):
      s390/dasd: fix hanging device after quiesce/resume

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Steven Rostedt (VMware) (2):
      ftrace: Add information on number of page groups allocated
      ftrace: Check if pages were allocated before calling free_pages()

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Tomas Glozar (1):
      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

Uwe Kleine-König (1):
      pwm: meson: Simplify duplicated per-channel tracking

Vladimir Oltean (2):
      net/sched: mqprio: refactor nlattr parsing to a separate function
      net/sched: mqprio: add extack to mqprio_parse_nlattr()

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Xianting Tian (1):
      jbd2: fix incorrect code style

Xiubo Li (1):
      ceph: defer stopping mdsc delayed_work

Xu Yang (1):
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yang Yingliang (1):
      net: ll_temac: Switch to use dev_err_probe() helper

Ye Bin (1):
      scsi: qla2xxx: Fix inconsistent format argument type in qla_os.c

Yu Kuai (1):
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Yuanjun Gong (3):
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Zhang Shurong (1):
      staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Zhang Yi (2):
      jbd2: remove redundant buffer io error checks
      jbd2: recheck chechpointing non-dirty buffer

Zheng Wang (1):
      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zheng Yejian (3):
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

Zhengchao Shao (1):
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

Zhihao Cheng (2):
      jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint
      ext4: Fix reusing stale buffer heads from last failed mounting

ndesaulniers@google.com (1):
      word-at-a-time: use the same return type for has_zero regardless of endianness

valis (3):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

