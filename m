Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6207D6803
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjJYKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjJYKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FC11F;
        Wed, 25 Oct 2023 03:14:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD07C433C7;
        Wed, 25 Oct 2023 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698228889;
        bh=8cLisZbTfoPxtp2wHHn7wvKV6qdqmCcbXJJUXnBSrZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=c+J+WzLF4NrTgMtg2YIxObkZuu3+wHrv28QRCVJz1drrQKCEZUxvE9ZnoRE91gU13
         /qdlm7ts0vjq1NISOsABHwGgwabryPxoPQ2iCVGNkoA1zJkC1culkT1VNnUFeDFab+
         fXEMkdrGWjsr49+1h1gaaSFiN7+LvRxdcrSlmvCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.137
Date:   Wed, 25 Oct 2023 12:14:44 +0200
Message-ID: <2023102545-staining-shaking-b65f@gregkh>
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

I'm announcing the release of the 5.15.137 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/sysctl/net.rst                               |   18 
 Makefile                                                               |    2 
 arch/arm/boot/dts/motorola-mapphone-common.dtsi                        |    1 
 arch/powerpc/include/asm/book3s/32/kup.h                               |   37 -
 arch/powerpc/include/asm/book3s/32/mmu-hash.h                          |   77 ++
 arch/powerpc/include/asm/interrupt.h                                   |    6 
 arch/powerpc/include/asm/kup.h                                         |    5 
 arch/powerpc/kernel/entry_32.S                                         |   39 +
 arch/powerpc/kernel/head_32.h                                          |    6 
 arch/powerpc/kernel/head_book3s_32.S                                   |    4 
 arch/powerpc/kernel/interrupt.c                                        |    3 
 arch/powerpc/mm/book3s32/kuep.c                                        |   10 
 arch/s390/pci/pci_dma.c                                                |   15 
 arch/x86/boot/compressed/sev.c                                         |   10 
 arch/x86/events/Makefile                                               |    2 
 arch/x86/events/intel/lbr.c                                            |  273 ----------
 arch/x86/events/perf_event.h                                           |   62 ++
 arch/x86/events/utils.c                                                |  217 +++++++
 arch/x86/kernel/sev-shared.c                                           |   53 +
 arch/x86/kernel/sev.c                                                  |   30 +
 arch/x86/kvm/lapic.c                                                   |    8 
 drivers/acpi/irq.c                                                     |    7 
 drivers/ata/libata-core.c                                              |    2 
 drivers/ata/libata-eh.c                                                |    2 
 drivers/base/regmap/regmap.c                                           |    2 
 drivers/bluetooth/btusb.c                                              |    1 
 drivers/bluetooth/hci_vhci.c                                           |    3 
 drivers/gpio/gpio-timberdale.c                                         |    5 
 drivers/gpio/gpio-vf610.c                                              |    4 
 drivers/gpu/drm/drm_atomic_helper.c                                    |   17 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                         |   16 
 drivers/gpu/drm/i915/gem/i915_gem_mman.c                               |    1 
 drivers/hid/hid-holtek-kbd.c                                           |    4 
 drivers/hid/hid-multitouch.c                                           |    4 
 drivers/i2c/i2c-mux.c                                                  |    2 
 drivers/iio/accel/bmc150-accel-core.c                                  |    4 
 drivers/iio/adc/ad7192.c                                               |   29 -
 drivers/iio/adc/at91-sama5d2_adc.c                                     |    4 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c              |    6 
 drivers/iio/industrialio-core.c                                        |   61 ++
 drivers/mmc/core/mmc.c                                                 |    2 
 drivers/mmc/core/sdio.c                                                |    8 
 drivers/mmc/host/mtk-sd.c                                              |    6 
 drivers/mtd/maps/physmap-core.c                                        |   11 
 drivers/mtd/nand/raw/arasan-nand-controller.c                          |   16 
 drivers/mtd/nand/raw/marvell_nand.c                                    |   23 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                           |    9 
 drivers/mtd/nand/raw/qcom_nandc.c                                      |    2 
 drivers/mtd/nand/spi/micron.c                                          |    2 
 drivers/net/bonding/bond_main.c                                        |    2 
 drivers/net/dsa/bcm_sf2.c                                              |   24 
 drivers/net/ethernet/intel/i40e/i40e_common.c                          |    4 
 drivers/net/ethernet/intel/ice/ice_lib.c                               |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                              |   15 
 drivers/net/ethernet/marvell/sky2.h                                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c               |    2 
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c                       |   10 
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c                  |   19 
 drivers/net/ethernet/netronome/nfp/flower/main.h                       |    2 
 drivers/net/ethernet/netronome/nfp/flower/metadata.c                   |    2 
 drivers/net/ethernet/netronome/nfp/flower/offload.c                    |   24 
 drivers/net/ethernet/netronome/nfp/flower/qos_conf.c                   |   20 
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                              |    7 
 drivers/net/tun.c                                                      |    7 
 drivers/net/usb/smsc95xx.c                                             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                            |    3 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c                   |   16 
 drivers/nvme/host/pci.c                                                |    3 
 drivers/nvme/host/rdma.c                                               |    3 
 drivers/nvme/target/tcp.c                                              |    7 
 drivers/phy/motorola/phy-mapphone-mdm6600.c                            |   38 -
 drivers/pinctrl/core.c                                                 |   16 
 drivers/platform/surface/surface_platform_profile.c                    |    3 
 drivers/platform/x86/asus-nb-wmi.c                                     |    3 
 drivers/platform/x86/asus-wmi.h                                        |    2 
 drivers/platform/x86/touchscreen_dmi.c                                 |   23 
 drivers/regulator/core.c                                               |    6 
 drivers/s390/cio/css.c                                                 |    6 
 drivers/tty/serial/8250/8250_omap.c                                    |   93 +--
 drivers/usb/serial/option.c                                            |    7 
 fs/btrfs/ctree.c                                                       |   52 +
 fs/btrfs/extent-tree.c                                                 |    6 
 fs/btrfs/ioctl.c                                                       |    4 
 fs/btrfs/tree-log.c                                                    |    2 
 fs/fs-writeback.c                                                      |   11 
 fs/ksmbd/vfs_cache.c                                                   |    4 
 fs/nfs/nfs4proc.c                                                      |    2 
 fs/nfs/pnfs.c                                                          |   33 -
 fs/ntfs3/fsntfs.c                                                      |    6 
 fs/ntfs3/index.c                                                       |    3 
 fs/ntfs3/xattr.c                                                       |    7 
 fs/overlayfs/copy_up.c                                                 |    2 
 fs/xfs/xfs_iops.c                                                      |   34 -
 fs/xfs/xfs_symlink.c                                                   |   29 -
 include/linux/iio/iio.h                                                |   14 
 include/linux/netdevice.h                                              |    1 
 include/linux/perf_event.h                                             |    1 
 include/net/bluetooth/hci_core.h                                       |    2 
 include/net/bluetooth/hci_mon.h                                        |    2 
 include/net/ip_fib.h                                                   |    1 
 include/net/netns/xfrm.h                                               |    1 
 include/net/tcp.h                                                      |    3 
 include/trace/events/neigh.h                                           |    4 
 include/uapi/linux/perf_event.h                                        |    2 
 kernel/events/core.c                                                   |   39 +
 kernel/trace/trace_events.c                                            |    1 
 lib/Kconfig.debug                                                      |    5 
 net/bluetooth/hci_conn.c                                               |   72 +-
 net/bluetooth/hci_core.c                                               |    8 
 net/bluetooth/hci_event.c                                              |   33 -
 net/bluetooth/hci_sock.c                                               |    3 
 net/core/dev.c                                                         |   58 +-
 net/core/drop_monitor.c                                                |    2 
 net/core/netpoll.c                                                     |    4 
 net/core/pktgen.c                                                      |   14 
 net/ipv4/esp4.c                                                        |    4 
 net/ipv4/fib_semantics.c                                               |   15 
 net/ipv4/fib_trie.c                                                    |    4 
 net/ipv4/tcp_ipv4.c                                                    |    1 
 net/ipv4/tcp_output.c                                                  |   25 
 net/ipv4/tcp_recovery.c                                                |    2 
 net/ipv6/esp6.c                                                        |    4 
 net/ipv6/xfrm6_policy.c                                                |    4 
 net/mac80211/tx.c                                                      |    3 
 net/mctp/route.c                                                       |   33 +
 net/netfilter/nft_payload.c                                            |    2 
 net/netfilter/nft_set_rbtree.c                                         |    2 
 net/nfc/nci/spi.c                                                      |    2 
 net/rfkill/rfkill-gpio.c                                               |    4 
 net/sched/sch_hfsc.c                                                   |   18 
 net/wireless/nl80211.c                                                 |    2 
 net/wireless/scan.c                                                    |    4 
 net/xfrm/xfrm_interface_core.c                                         |   22 
 net/xfrm/xfrm_policy.c                                                 |    6 
 sound/soc/codecs/wcd938x-sdw.c                                         |   27 
 sound/soc/codecs/wcd938x.c                                             |    6 
 sound/soc/pxa/pxa-ssp.c                                                |    2 
 tools/include/uapi/linux/perf_event.h                                  |    2 
 tools/perf/util/branch.c                                               |    4 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |   13 
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh                  |    4 
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh                 |    4 
 142 files changed, 1443 insertions(+), 746 deletions(-)

Alisa-Dariana Roman (1):
      iio: adc: ad7192: Correct reference voltage

Andy Shevchenko (1):
      Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"

Anshuman Khandual (1):
      perf: Add irq and exception return branch types

Antoine Tenart (1):
      net: introduce a function to check if a netdev name is in use

Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Armin Wolf (1):
      platform/surface: platform_profile: Propagate error if profile registration fails

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Avri Altman (1):
      mmc: core: Capture correct oemid-bits for eMMC cards

Bagas Sanjaya (1):
      Documentation: sysctl: align cells in second content column

Ben Greear (1):
      wifi: iwlwifi: Ensure ack flag is properly cleared.

Benjamin Berg (1):
      wifi: cfg80211: avoid leaking stack data into trace

Benoît Monin (1):
      USB: serial: option: add entry for Sierra EM9191 with new firmware

Bibek Kumar Patro (1):
      mtd: rawnand: qcom: Unmap the right resource upon probe failure

Borislav Petkov (AMD) (1):
      x86/sev: Disable MMIO emulation from user mode

Chengfeng Ye (1):
      gpio: timberdale: Fix potential deadlock on &tgpio->lock

Christophe Leroy (2):
      powerpc/32s: Remove capability to disable KUEP at boottime
      powerpc/32s: Do kuep_lock() and kuep_unlock() in assembly

Chunhai Guo (1):
      fs-writeback: do not requeue a clean inode having skipped pages

Clément Léger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched()

Damien Le Moal (2):
      ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
      ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Dan Carpenter (2):
      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
      ASoC: pxa: fix a memory leak in probe()

Darrick J. Wong (1):
      xfs: don't expose internal symlink metadata buffers to the vfs

Dinghao Liu (1):
      s390/cio: fix a memleak in css_alloc_subchannel

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Eric Dumazet (5):
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: interface: use DEV_STATS_INC()
      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
      tun: prevent negative ifindex
      ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Filipe Manana (4):
      btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
      btrfs: error out when COWing block using a stale transaction
      btrfs: error when COWing block from a root that is being deleted
      btrfs: error out when reallocating block for defrag using a stale transaction

Florian Westphal (1):
      netfilter: nft_payload: fix wrong mac header matching

Francis Laniel (1):
      selftests/ftrace: Add new test case which checks non unique symbol

Gavrilov Ilia (1):
      net: pktgen: Fix interface flags printing

Geert Uytterhoeven (3):
      neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
      mtd: physmap-core: Restore map_rom fallback
      serial: 8250: omap: Move uart_write() inside PM section

Greg Kroah-Hartman (1):
      Linux 5.15.137

Gustavo A. R. Silva (1):
      wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

Haibo Chen (2):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode
      gpio: vf610: set value before the direction to avoid a glitch

Hangbin Liu (1):
      ipv4/fib: send notify when delete source address routes

Hans de Goede (2):
      platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e
      platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events

Heiner Kallweit (1):
      i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Hyeonggon Yoo (1):
      lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default

Ilan Peer (1):
      wifi: cfg80211: Fix 6GHz scan configuration

JP Kobryn (1):
      perf/x86/lbr: Filter vsyscall addresses

Jakub Kicinski (1):
      net: fix ifname in netlink ntf during netns move

Jeff Layton (1):
      overlayfs: set ctime when setting mtime and atime

Jeremy Kerr (2):
      mctp: Allow local delivery to the null EID
      mctp: perform route lookups under a RCU read-side lock

Jesse Brandeburg (2):
      ice: fix over-shifted variable
      ice: reset first in crash dump kernels

Jim Mattson (1):
      KVM: x86: Mask LVTPC when handling a PMI

Jinjie Ruan (1):
      net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()

Jiri Wiesner (1):
      bonding: Return pointer to data after pull on skb

Joerg Roedel (2):
      x86/sev: Check IOBM for IOIO exceptions from user-space
      x86/sev: Check for user-space IOIO pointing to kernel space

Johan Hovold (5):
      regmap: fix NULL deref on lookup
      ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
      ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors
      ASoC: codecs: wcd938x: drop bogus bind error handling
      ASoC: codecs: wcd938x: fix unbind tear down order

Josef Bacik (2):
      btrfs: initialize start_slot in btrfs_log_prealloc_extents
      btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Josua Mayer (1):
      net: rfkill: gpio: prevent value glitch during probe

Juntong Deng (1):
      selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error

Kai Uwe Broulik (1):
      drm: panel-orientation-quirks: Add quirk for One Mix 2S

Kees Cook (2):
      sky2: Make sure there is at least one frag_addr available
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Keith Busch (1):
      nvme-pci: add BOGUS_NID for Intel 0a54 device

Konstantin Komarov (1):
      fs/ntfs3: fix deadlock in mark_as_free_ex

Krzysztof Kozlowski (1):
      nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Luiz Augusto von Dentz (3):
      Bluetooth: hci_event: Fix coding style
      Bluetooth: hci_core: Fix build warnings
      Bluetooth: hci_event: Fix using memcmp when comparing keys

Ma Ke (3):
      net: ipv4: fix return value check in esp_remove_trailer
      net: ipv6: fix return value check in esp_remove_trailer
      HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Maher Sanalla (1):
      net/mlx5: Handle fw tracer change ownership event based on MTRC

Manish Chopra (1):
      qed: fix LL2 RX buffer allocation

Martin Kurbanov (1):
      mtd: spinand: micron: correct bitmask for ecc status

Maurizio Lombardi (1):
      nvme-rdma: do not try to stop unallocated queues

Michael Ellerman (1):
      powerpc/47x: Fix 47x syscall return crash

Michal Schmidt (1):
      i40e: prevent crash on probe if hw registers have invalid values

Michał Mirosław (1):
      regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

Miquel Raynal (5):
      iio: Un-inline iio_buffer_enabled()
      iio: core: Hide read accesses to iio_dev->currentmode
      mtd: rawnand: pl353: Ensure program page operations are successful
      mtd: rawnand: marvell: Ensure program page operations are successful
      mtd: rawnand: arasan: Ensure program page operations are successful

Namjae Jeon (1):
      ksmbd: not allow to open file if delelete on close bit is set

Neal Cardwell (1):
      tcp: fix excessive TLP and RACK timeouts from HZ rounding

Niklas Schnelle (1):
      s390/pci: fix iommu bitmap allocation

Nuno Sá (1):
      iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs

Olga Kornievskaia (1):
      NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server

Pablo Neira Ayuso (3):
      netfilter: nft_set_rbtree: .deactivate fails if element has expired
      netfilter: nf_tables: do not remove elements if set backend implements .abort
      netfilter: nf_tables: revert do not remove elements if set backend implements .abort

Pablo Sun (1):
      mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Paolo Abeni (1):
      tcp: check mptcp-level constraints for backlog coalescing

Pedro Tammela (1):
      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Peter Zijlstra (1):
      perf: Disallow mis-matched inherited group reads

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Rahul Rameshbabu (1):
      HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Renan Guilherme Lebre Ramos (1):
      platform/x86: touchscreen_dmi: Add info for the Positivo C4128B

Rocky Liao (1):
      Bluetooth: btusb: add shutdown function for QCA6174

Sagi Grimberg (1):
      nvmet-tcp: Fix a possible UAF in queue intialization setup

Sandipan Das (1):
      perf/x86: Move branch classifier

Simon Ser (1):
      drm/atomic-helper: relax unregistered connector check

Sunil V L (1):
      ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Tony Lindgren (6):
      serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()
      serial: 8250_omap: Fix errors with no_console_suspend
      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
      phy: mapphone-mdm6600: Fix runtime disable on probe
      phy: mapphone-mdm6600: Fix runtime PM for remove
      phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Trond Myklebust (1):
      pNFS: Fix a hang in nfs4_evict_inode()

Tzung-Bi Shih (1):
      iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

Ville Syrjälä (1):
      drm/i915: Retry gtt fault when out of fence registers

Wen Gong (1):
      wifi: mac80211: allow transmitting EAPOL frames with tainted key

Wolfram Sang (1):
      net: move from strlcpy with unused retval to strscpy

Yanguo Li (1):
      nfp: flower: avoid rmmod nfp crash issues

Ying Hsu (1):
      Bluetooth: Avoid redundant authentication

Zeng Heng (1):
      fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

Ziqi Zhao (1):
      fs/ntfs3: Fix possible null-pointer dereference in hdr_find_e()

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

