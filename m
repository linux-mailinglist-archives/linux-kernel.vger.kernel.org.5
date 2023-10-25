Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730687D67E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjJYKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjJYKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:08:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093EDD;
        Wed, 25 Oct 2023 03:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12C6C433C7;
        Wed, 25 Oct 2023 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698228523;
        bh=XhpMQvffvkD0c3yJdbhJs05g0RSmVTw7ZgFDy3YHH0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=GEtwWvPPCasZdYhUaEGfrNLXy4AAHv2WZ7E1pr6rbBaWZ8iyt+C/pkfaJJnn4JhXU
         Hy7wXdyUDtGuSx3bPIytTCbnRX3mx8BjkN0Gk7WI7yL2ndeF9IgHu4G2YPD48k3Frz
         X2/8pZOS846lKVXTBl5oFrM42Sv6avkII26HS3Rk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.259
Date:   Wed, 25 Oct 2023 12:08:38 +0200
Message-ID: <2023102539-remix-footgear-ff61@gregkh>
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

I'm announcing the release of the 5.4.259 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/sysctl/net.rst                 |   18 +-
 Makefile                                                 |    2 
 arch/arm/boot/dts/omap4-droid4-xt894.dts                 |    1 
 arch/powerpc/include/asm/nohash/32/pte-8xx.h             |    7 
 arch/powerpc/include/asm/nohash/64/pgtable.h             |    2 
 arch/powerpc/include/asm/nohash/pgtable.h                |    2 
 arch/s390/pci/pci_dma.c                                  |   15 +
 arch/x86/include/asm/msr-index.h                         |    4 
 arch/x86/kernel/cpu/amd.c                                |    8 
 arch/x86/kvm/lapic.c                                     |    8 
 drivers/acpi/irq.c                                       |    7 
 drivers/acpi/resource.c                                  |  121 +++++++++++++--
 drivers/ata/libata-eh.c                                  |    2 
 drivers/base/regmap/regmap.c                             |    2 
 drivers/bluetooth/hci_vhci.c                             |    3 
 drivers/dma/mediatek/mtk-uart-apdma.c                    |    3 
 drivers/dma/stm32-mdma.c                                 |    4 
 drivers/gpio/gpio-timberdale.c                           |    5 
 drivers/gpio/gpio-vf610.c                                |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c           |   16 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c              |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                       |   12 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                  |    2 
 drivers/hid/hid-holtek-kbd.c                             |    4 
 drivers/hid/hid-logitech-hidpp.c                         |    3 
 drivers/hid/hid-multitouch.c                             |    4 
 drivers/i2c/i2c-mux.c                                    |    2 
 drivers/iio/pressure/bmp280-core.c                       |    2 
 drivers/iio/pressure/dps310.c                            |    8 
 drivers/iio/pressure/ms5611_core.c                       |    2 
 drivers/infiniband/hw/cxgb4/cm.c                         |    3 
 drivers/input/joystick/xpad.c                            |    2 
 drivers/input/misc/powermate.c                           |    1 
 drivers/input/mouse/elantech.c                           |    1 
 drivers/input/mouse/synaptics.c                          |    1 
 drivers/mcb/mcb-core.c                                   |   10 -
 drivers/mcb/mcb-parse.c                                  |    2 
 drivers/mmc/core/mmc.c                                   |    2 
 drivers/mmc/core/sdio.c                                  |    8 
 drivers/mtd/maps/physmap-core.c                          |   11 +
 drivers/mtd/nand/raw/qcom_nandc.c                        |    2 
 drivers/mtd/nand/spi/micron.c                            |    2 
 drivers/net/ethernet/intel/i40e/i40e_common.c            |    4 
 drivers/net/ethernet/intel/ice/ice_lib.c                 |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c           |    5 
 drivers/net/ethernet/marvell/sky2.h                      |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c |    4 
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                |    7 
 drivers/net/ethernet/renesas/ravb_main.c                 |    6 
 drivers/net/ieee802154/ca8210.c                          |   17 --
 drivers/net/tun.c                                        |    7 
 drivers/net/usb/dm9601.c                                 |    7 
 drivers/net/usb/smsc95xx.c                               |    2 
 drivers/net/xen-netback/interface.c                      |    3 
 drivers/phy/motorola/phy-mapphone-mdm6600.c              |   38 ++--
 drivers/pwm/pwm-hibvt.c                                  |    1 
 drivers/regulator/core.c                                 |    6 
 drivers/usb/core/hub.c                                   |   28 ++-
 drivers/usb/core/hub.h                                   |    2 
 drivers/usb/dwc3/core.c                                  |   39 ++++
 drivers/usb/gadget/function/f_ncm.c                      |   26 ++-
 drivers/usb/gadget/udc/udc-xilinx.c                      |   20 +-
 drivers/usb/host/xhci-ring.c                             |    4 
 drivers/usb/musb/musb_debugfs.c                          |    2 
 drivers/usb/musb/musb_host.c                             |    9 -
 drivers/usb/serial/option.c                              |    7 
 fs/btrfs/extent-tree.c                                   |    6 
 fs/btrfs/ioctl.c                                         |    4 
 fs/btrfs/tree-log.c                                      |    2 
 fs/ceph/inode.c                                          |    4 
 fs/overlayfs/copy_up.c                                   |    2 
 fs/quota/dquot.c                                         |   66 ++++----
 include/linux/ioport.h                                   |    7 
 include/linux/mcb.h                                      |    1 
 include/linux/netdevice.h                                |    2 
 include/linux/perf_event.h                               |    1 
 include/linux/quota.h                                    |    4 
 include/linux/quotaops.h                                 |    2 
 include/net/bluetooth/hci_core.h                         |    2 
 include/net/bluetooth/hci_mon.h                          |    2 
 include/net/netns/xfrm.h                                 |    1 
 include/net/tcp.h                                        |    3 
 include/trace/events/neigh.h                             |    4 
 kernel/cgroup/cgroup-v1.c                                |    5 
 kernel/events/core.c                                     |   39 ++++
 kernel/trace/trace_events.c                              |    1 
 kernel/workqueue.c                                       |    8 
 lib/test_meminit.c                                       |    2 
 net/bluetooth/hci_conn.c                                 |   72 +++++---
 net/bluetooth/hci_core.c                                 |    8 
 net/bluetooth/hci_event.c                                |   33 +++-
 net/bluetooth/hci_sock.c                                 |    3 
 net/ceph/messenger.c                                     |    4 
 net/core/pktgen.c                                        |   14 -
 net/ipv4/esp4.c                                          |    4 
 net/ipv4/fib_semantics.c                                 |   14 +
 net/ipv4/tcp_output.c                                    |   25 ++-
 net/ipv4/tcp_recovery.c                                  |    2 
 net/ipv6/esp6.c                                          |    4 
 net/ipv6/xfrm6_policy.c                                  |    4 
 net/mac80211/tx.c                                        |    3 
 net/netfilter/ipvs/ip_vs_sync.c                          |    4 
 net/netfilter/nft_payload.c                              |    2 
 net/netfilter/nft_set_rbtree.c                           |    2 
 net/nfc/llcp_core.c                                      |   30 +--
 net/nfc/nci/core.c                                       |    5 
 net/nfc/nci/spi.c                                        |    2 
 net/rds/tcp_connect.c                                    |    2 
 net/rds/tcp_listen.c                                     |    2 
 net/rfkill/rfkill-gpio.c                                 |    4 
 net/sched/sch_hfsc.c                                     |   18 +-
 net/socket.c                                             |    6 
 net/wireless/nl80211.c                                   |    2 
 net/xfrm/xfrm_interface_core.c                           |   22 +-
 net/xfrm/xfrm_policy.c                                   |    6 
 sound/soc/pxa/pxa-ssp.c                                  |    2 
 116 files changed, 725 insertions(+), 311 deletions(-)

Abhinav Kumar (1):
      drm/msm/dsi: skip the wait for video mode done if not applicable

Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Amelie Delaunay (1):
      dmaengine: stm32-mdma: abort resume if no ongoing transfer

Andy Shevchenko (1):
      Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"

Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Artem Chernyshev (1):
      RDMA/cxgb4: Check skb value for failure to allocate

Avri Altman (1):
      mmc: core: Capture correct oemid-bits for eMMC cards

Bagas Sanjaya (1):
      Documentation: sysctl: align cells in second content column

Benjamin Berg (1):
      wifi: cfg80211: avoid leaking stack data into trace

Benoît Monin (1):
      USB: serial: option: add entry for Sierra EM9191 with new firmware

Bibek Kumar Patro (1):
      mtd: rawnand: qcom: Unmap the right resource upon probe failure

Borislav Petkov (AMD) (1):
      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Chengfeng Ye (1):
      gpio: timberdale: Fix potential deadlock on &tgpio->lock

Christophe Leroy (2):
      powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
      powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Clément Léger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched()

Damien Le Moal (1):
      ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Dan Carpenter (4):
      mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
      ixgbe: fix crash with empty VF macvlan list
      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
      ASoC: pxa: fix a memory leak in probe()

Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Dmitry Torokhov (1):
      pinctrl: avoid unsafe code pattern in find_pinctrl()

Duoming Zhou (1):
      dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Eric Dumazet (6):
      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: interface: use DEV_STATS_INC()
      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
      tun: prevent negative ifindex
      ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Filipe Manana (1):
      btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1

Florian Westphal (1):
      netfilter: nft_payload: fix wrong mac header matching

Gavrilov Ilia (1):
      net: pktgen: Fix interface flags printing

Geert Uytterhoeven (2):
      neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
      mtd: physmap-core: Restore map_rom fallback

Greg Kroah-Hartman (2):
      lib/test_meminit: fix off-by-one error in test_pages()
      Linux 5.4.259

Haibo Chen (2):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode
      gpio: vf610: set value before the direction to avoid a glitch

Hans de Goede (3):
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
      ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA

Heiner Kallweit (1):
      i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Hui Wang (1):
      ACPI: resources: Add DMI-based legacy IRQ override quirk

Jan Kara (1):
      quota: Fix slow quotaoff

Javier Carrasco (2):
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
      Input: powermate - fix use-after-free in powermate_config_complete

Jeff Layton (1):
      overlayfs: set ctime when setting mtime and atime

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jesse Brandeburg (1):
      ice: fix over-shifted variable

Jim Mattson (1):
      KVM: x86: Mask LVTPC when handling a PMI

Johan Hovold (1):
      regmap: fix NULL deref on lookup

John Garry (2):
      resource: Add irqresource_disabled()
      ACPI: Drop acpi_dev_irqresource_disabled()

Jordan Rife (2):
      net: prevent address rewrite in kernel_bind()
      libceph: use kernel_connect()

Jorge Sanjuan Garcia (1):
      mcb: remove is_added flag from mcb_device struct

Josef Bacik (2):
      btrfs: initialize start_slot in btrfs_log_prealloc_extents
      btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Josua Mayer (1):
      net: rfkill: gpio: prevent value glitch during probe

Kai Uwe Broulik (1):
      drm: panel-orientation-quirks: Add quirk for One Mix 2S

Kees Cook (2):
      sky2: Make sure there is at least one frag_addr available
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Kellen Renshaw (1):
      ACPI: resource: Add ASUS model S5402ZA to quirks

Konstantin Meskhidze (1):
      drm/vmwgfx: fix typo of sizeof argument

Krishna Kurapati (1):
      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Krzysztof Kozlowski (1):
      nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

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

Manish Chopra (1):
      qed: fix LL2 RX buffer allocation

Martin Fuzzey (1):
      drm: etvnaviv: fix bad backport leading to warning

Martin Kurbanov (1):
      mtd: spinand: micron: correct bitmask for ecc status

Matthias Berndt (1):
      Input: xpad - add PXN V900 support

Michal Koutný (1):
      cgroup: Remove duplicates in cgroup v1 tasks file

Michal Schmidt (1):
      i40e: prevent crash on probe if hw registers have invalid values

Michał Mirosław (1):
      regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

Neal Cardwell (1):
      tcp: fix excessive TLP and RACK timeouts from HZ rounding

Nicolas Dichtel (1):
      dev_forward_skb: do not scrub skb mark within the same name space

Niklas Schnelle (1):
      s390/pci: fix iommu bitmap allocation

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: .deactivate fails if element has expired

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA

Pedro Tammela (1):
      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Peter Zijlstra (1):
      perf: Disallow mis-matched inherited group reads

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Rahul Rameshbabu (1):
      HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Ricardo Cañuelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Sunil V L (1):
      ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Tamim Khan (3):
      ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA
      ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA
      ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA

Thinh Nguyen (1):
      usb: dwc3: Soft reset phy on probe for host

Tony Lindgren (4):
      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
      phy: mapphone-mdm6600: Fix runtime disable on probe
      phy: mapphone-mdm6600: Fix runtime PM for remove
      phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Uwe Kleine-König (1):
      pwm: hibvt: Explicitly set .polarity in .get_state()

Waiman Long (1):
      workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

Wen Gong (1):
      wifi: mac80211: allow transmitting EAPOL frames with tainted key

Wesley Cheng (1):
      usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

Xingxing Luo (2):
      usb: musb: Get the musb_qh poniter after musb_giveback
      usb: musb: Modify the "HWVers" register address

Xiubo Li (1):
      ceph: fix incorrect revoked caps assert in ceph_fill_file_size()

Ying Hsu (1):
      Bluetooth: Avoid redundant authentication

Yoshihiro Shimoda (2):
      ravb: Fix up dma_free_coherent() call in ravb_remove()
      ravb: Fix use-after-free issue in ravb_tx_timeout_work()

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

