Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18B7D6788
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjJYJv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJYJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:51:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81326128;
        Wed, 25 Oct 2023 02:51:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D9C433C9;
        Wed, 25 Oct 2023 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698227508;
        bh=03REafUVNtt5jBRjx+Agg7QAQ6pZP8qh3S27vFK0XiA=;
        h=From:To:Cc:Subject:Date:From;
        b=cD82fNM1JxnZxeZ/tvKGfk072lmZKpt+MdA2ltk8I62WD6fJxw3ZiV7z7dA7Lx2NY
         c1PZTHJAOWY7cTYjTfZpNlfy1KNvOXv0gbsAmsve3fj46CCSp5LPuTYijQyYWX2uRr
         x+2vHZwW7j7GoNMZEiBGOc13QStnShJqStSTO4rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.297
Date:   Wed, 25 Oct 2023 11:51:40 +0200
Message-ID: <2023102541-maritime-payday-8e59@gregkh>
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

I'm announcing the release of the 4.19.297 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 
 arch/arm/boot/dts/omap4-droid4-xt894.dts       |    1 
 arch/powerpc/include/asm/nohash/64/pgtable.h   |    2 
 arch/s390/pci/pci_dma.c                        |   15 ++++
 arch/x86/include/asm/msr-index.h               |    4 +
 arch/x86/kernel/alternative.c                  |   13 ++++
 arch/x86/kernel/cpu/amd.c                      |    8 ++
 arch/x86/kvm/lapic.c                           |    8 +-
 drivers/acpi/irq.c                             |    7 +-
 drivers/ata/libata-eh.c                        |    2 
 drivers/base/regmap/regmap.c                   |    2 
 drivers/bluetooth/hci_vhci.c                   |    3 
 drivers/cpuidle/cpuidle.c                      |   12 ++-
 drivers/dma/stm32-mdma.c                       |    4 +
 drivers/gpio/gpio-timberdale.c                 |    5 -
 drivers/gpio/gpio-vf610.c                      |    4 -
 drivers/gpu/drm/drm_panel_orientation_quirks.c |   16 +++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c    |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c             |   12 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c        |    2 
 drivers/hid/hid-holtek-kbd.c                   |    4 +
 drivers/hid/hid-logitech-hidpp.c               |    3 
 drivers/i2c/i2c-mux.c                          |    2 
 drivers/iio/pressure/bmp280-core.c             |    2 
 drivers/iio/pressure/ms5611_core.c             |    2 
 drivers/infiniband/hw/cxgb4/cm.c               |    3 
 drivers/input/joystick/xpad.c                  |    2 
 drivers/input/misc/powermate.c                 |    1 
 drivers/input/mouse/elantech.c                 |    1 
 drivers/input/mouse/synaptics.c                |    1 
 drivers/mcb/mcb-core.c                         |   10 ---
 drivers/mcb/mcb-parse.c                        |    2 
 drivers/mmc/core/mmc.c                         |    2 
 drivers/mtd/nand/raw/qcom_nandc.c              |    2 
 drivers/mtd/nand/spi/micron.c                  |    2 
 drivers/net/ethernet/intel/i40e/i40e_common.c  |    4 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    5 -
 drivers/net/ethernet/marvell/sky2.h            |    2 
 drivers/net/ieee802154/ca8210.c                |   17 -----
 drivers/net/usb/dm9601.c                       |    7 +-
 drivers/net/usb/smsc95xx.c                     |    2 
 drivers/net/xen-netback/interface.c            |    3 
 drivers/phy/motorola/phy-mapphone-mdm6600.c    |    1 
 drivers/usb/core/hub.c                         |   28 +++++++-
 drivers/usb/core/hub.h                         |    2 
 drivers/usb/dwc3/core.c                        |   39 ++++++++++++
 drivers/usb/gadget/function/f_ncm.c            |   26 ++++++--
 drivers/usb/gadget/udc/udc-xilinx.c            |   20 +++---
 drivers/usb/host/xhci-ring.c                   |    4 -
 drivers/usb/musb/musb_debugfs.c                |    2 
 drivers/usb/musb/musb_host.c                   |    9 ++
 drivers/usb/serial/option.c                    |    7 ++
 fs/btrfs/extent-tree.c                         |    6 -
 fs/btrfs/ioctl.c                               |    4 -
 fs/btrfs/tree-log.c                            |    2 
 fs/ceph/inode.c                                |    4 -
 fs/overlayfs/copy_up.c                         |    2 
 fs/quota/dquot.c                               |   66 ++++++++++++--------
 include/linux/indirect_call_wrapper.h          |   51 ++++++++++++++++
 include/linux/mcb.h                            |    1 
 include/linux/netdevice.h                      |    2 
 include/linux/perf_event.h                     |    1 
 include/linux/quota.h                          |    4 -
 include/linux/quotaops.h                       |    2 
 include/net/bluetooth/hci_core.h               |    2 
 include/net/netns/xfrm.h                       |    1 
 include/net/tcp.h                              |    3 
 kernel/cgroup/cgroup-v1.c                      |    5 -
 kernel/events/core.c                           |   39 ++++++++++--
 kernel/sched/idle.c                            |   22 ++----
 kernel/trace/trace_events.c                    |    1 
 kernel/workqueue.c                             |    8 +-
 net/bluetooth/hci_conn.c                       |   72 +++++++++++++---------
 net/bluetooth/hci_core.c                       |    8 +-
 net/bluetooth/hci_event.c                      |   33 ++++++++--
 net/bluetooth/hci_sock.c                       |    3 
 net/ceph/messenger.c                           |   79 ++++++++++++-------------
 net/core/pktgen.c                              |   14 ++--
 net/ipv4/esp4.c                                |    4 -
 net/ipv4/tcp_output.c                          |   25 ++++++-
 net/ipv4/tcp_recovery.c                        |    2 
 net/ipv6/esp6.c                                |    4 -
 net/ipv6/xfrm6_policy.c                        |    4 -
 net/mac80211/tx.c                              |    3 
 net/netfilter/ipvs/ip_vs_sync.c                |    4 -
 net/netfilter/nft_payload.c                    |    2 
 net/netfilter/nft_set_rbtree.c                 |    2 
 net/nfc/llcp_core.c                            |   30 +++------
 net/nfc/nci/core.c                             |    5 +
 net/nfc/nci/spi.c                              |    2 
 net/rds/tcp_connect.c                          |    2 
 net/rds/tcp_listen.c                           |    2 
 net/rfkill/rfkill-gpio.c                       |    4 -
 net/sched/sch_hfsc.c                           |   18 ++++-
 net/socket.c                                   |   77 +++++++++++++++++-------
 net/wireless/nl80211.c                         |    2 
 net/xfrm/xfrm_interface_core.c                 |   22 +++---
 net/xfrm/xfrm_policy.c                         |    6 -
 sound/soc/pxa/pxa-ssp.c                        |    2 
 99 files changed, 680 insertions(+), 318 deletions(-)

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

Christophe Leroy (1):
      powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Clément Léger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched()

Damien Le Moal (1):
      ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Dan Carpenter (3):
      ixgbe: fix crash with empty VF macvlan list
      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
      ASoC: pxa: fix a memory leak in probe()

Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Dmitry Torokhov (1):
      pinctrl: avoid unsafe code pattern in find_pinctrl()

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Eric Dumazet (4):
      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: interface: use DEV_STATS_INC()
      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Filipe Manana (1):
      btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1

Florian Westphal (1):
      netfilter: nft_payload: fix wrong mac header matching

Gavrilov Ilia (1):
      net: pktgen: Fix interface flags printing

Greg Kroah-Hartman (1):
      Linux 4.19.297

Haibo Chen (1):
      gpio: vf610: set value before the direction to avoid a glitch

Hans de Goede (1):
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Heiner Kallweit (1):
      i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Jan Kara (1):
      quota: Fix slow quotaoff

Javier Carrasco (2):
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
      Input: powermate - fix use-after-free in powermate_config_complete

Jeff Layton (2):
      libceph: fix unaligned accesses in ceph_entity_addr handling
      overlayfs: set ctime when setting mtime and atime

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jim Mattson (1):
      KVM: x86: Mask LVTPC when handling a PMI

Johan Hovold (1):
      regmap: fix NULL deref on lookup

Jordan Rife (3):
      net: prevent rewrite of msg_name in sock_sendmsg()
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

Kirill A. Shutemov (1):
      x86/alternatives: Disable KASAN in apply_alternatives()

Konstantin Meskhidze (1):
      drm/vmwgfx: fix typo of sizeof argument

Krishna Kurapati (1):
      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

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

Neal Cardwell (1):
      tcp: fix excessive TLP and RACK timeouts from HZ rounding

Nicolas Dichtel (1):
      dev_forward_skb: do not scrub skb mark within the same name space

Niklas Schnelle (1):
      s390/pci: fix iommu bitmap allocation

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: .deactivate fails if element has expired

Paolo Abeni (2):
      indirect call wrappers: helpers to speed-up indirect calls of builtin
      net: use indirect calls helpers at the socket layer

Pedro Tammela (1):
      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Peter Zijlstra (2):
      sched,idle,rcu: Push rcu_idle deeper into the idle path
      perf: Disallow mis-matched inherited group reads

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Randy Dunlap (1):
      net: fix kernel-doc warnings for socket.c

Ricardo Cañuelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Sunil V L (1):
      ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Thinh Nguyen (1):
      usb: dwc3: Soft reset phy on probe for host

Tony Lindgren (2):
      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
      phy: mapphone-mdm6600: Fix runtime PM for remove

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

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

