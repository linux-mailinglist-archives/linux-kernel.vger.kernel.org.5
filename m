Return-Path: <linux-kernel+bounces-17953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5C8255FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE351C2092E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD52D7B5;
	Fri,  5 Jan 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAxWaIbk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F882E823;
	Fri,  5 Jan 2024 14:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DACAC433C8;
	Fri,  5 Jan 2024 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465877;
	bh=Chji7DP1X85btWS8auRF9obg7devjketpXmsbR5ffoc=;
	h=From:To:Cc:Subject:Date:From;
	b=fAxWaIbkQPXPp2wbUhtwzrz1kLMHkhizEFc4CLbNVd/6wI17Plh24GNKHLxOCpKBW
	 WcVKj8D8/9rtB7Tifs47NIVH3iXnJ9JrQVXwtVLTms+JNTeIXmDMoCxWJE5xLTL9a9
	 D+qoKMjgbzZsIqXIZJhaEQHs6DIG3pFXU1gRrK+Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.206
Date: Fri,  5 Jan 2024 15:42:26 +0100
Message-ID: <2024010527-revision-ended-aea2@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.206 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml   |   10 
 Makefile                                                 |    2 
 arch/arm/boot/dts/am33xx.dtsi                            |    1 
 arch/arm/mach-omap2/id.c                                 |    5 
 arch/mips/Kconfig                                        |    2 
 arch/mips/include/asm/mach-loongson64/boot_param.h       |    3 
 arch/mips/loongson64/env.c                               |   10 
 arch/s390/include/asm/fpu/api.h                          |    2 
 arch/x86/kernel/alternative.c                            |    2 
 drivers/bus/ti-sysc.c                                    |   18 +
 drivers/i2c/busses/i2c-aspeed.c                          |   48 ++--
 drivers/iio/adc/ti_am335x_adc.c                          |    4 
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c           |    4 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c               |    4 
 drivers/input/keyboard/ipaq-micro-keys.c                 |    3 
 drivers/input/misc/soc_button_array.c                    |    5 
 drivers/interconnect/core.c                              |    3 
 drivers/md/dm-integrity.c                                |   11 -
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c          |    5 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c      |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c          |    2 
 drivers/net/ethernet/micrel/ks8851.h                     |    3 
 drivers/net/ethernet/micrel/ks8851_common.c              |   20 -
 drivers/net/ethernet/micrel/ks8851_spi.c                 |   42 ++-
 drivers/pinctrl/pinctrl-at91-pio4.c                      |    8 
 drivers/reset/core.c                                     |    3 
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                        |    9 
 drivers/scsi/scsi.c                                      |    2 
 drivers/scsi/scsi_error.c                                |   34 +--
 drivers/scsi/scsi_lib.c                                  |   38 ++-
 drivers/scsi/scsi_logging.c                              |   18 -
 drivers/scsi/scsi_priv.h                                 |    1 
 drivers/spi/spi-atmel.c                                  |  133 +++---------
 drivers/usb/host/fotg210-hcd.c                           |    3 
 drivers/usb/serial/ftdi_sio.c                            |    6 
 drivers/usb/serial/ftdi_sio_ids.h                        |    6 
 drivers/usb/serial/option.c                              |    5 
 fs/afs/cell.c                                            |    6 
 fs/afs/dynroot.c                                         |   31 +-
 fs/btrfs/ioctl.c                                         |    9 
 fs/cifs/misc.c                                           |    4 
 fs/cifs/smb2misc.c                                       |   26 --
 fs/cifs/smb2ops.c                                        |   26 +-
 fs/cifs/smb2pdu.c                                        |   29 ++
 fs/cifs/smb2pdu.h                                        |    2 
 include/linux/key-type.h                                 |    1 
 include/net/bluetooth/hci_core.h                         |    5 
 include/net/bluetooth/mgmt.h                             |    2 
 include/scsi/scsi_cmnd.h                                 |   29 ++
 include/scsi/scsi_device.h                               |   16 -
 kernel/trace/ring_buffer.c                               |   12 -
 kernel/trace/synth_event_gen_test.c                      |   11 +
 kernel/trace/trace.c                                     |   20 +
 lib/vsprintf.c                                           |   11 -
 net/8021q/vlan_core.c                                    |    9 
 net/9p/client.c                                          |    7 
 net/9p/protocol.c                                        |   17 +
 net/bluetooth/af_bluetooth.c                             |    7 
 net/bluetooth/hci_event.c                                |    3 
 net/bluetooth/l2cap_core.c                               |   21 +
 net/bluetooth/mgmt.c                                     |   35 ++-
 net/bluetooth/smp.c                                      |  161 ++++++++-------
 net/bluetooth/smp.h                                      |    6 
 net/core/dev.c                                           |    8 
 net/dns_resolver/dns_key.c                               |   10 
 net/ife/ife.c                                            |    1 
 net/mac80211/mesh_plink.c                                |   10 
 net/netfilter/nf_tables_api.c                            |    2 
 net/rfkill/rfkill-gpio.c                                 |    8 
 net/rose/af_rose.c                                       |   39 +++
 net/wireless/certs/wens.hex                              |   87 ++++++++
 security/keys/gc.c                                       |   31 +-
 security/keys/internal.h                                 |   11 -
 security/keys/key.c                                      |   15 -
 security/keys/proc.c                                     |    2 
 sound/pci/hda/patch_hdmi.c                               |    2 
 78 files changed, 778 insertions(+), 443 deletions(-)

Alexander Atanasov (1):
      scsi: core: Always send batch on reset or error handling command

Alexis Lothoré (1):
      pinctrl: at91-pio4: use dedicated lock class for IRQ

Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Archie Pusaka (1):
      Bluetooth: use inclusive language in SMP

Bart Van Assche (3):
      scsi: core: Introduce scsi_get_sector()
      scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request
      scsi: core: Use a structure member to track the SCSI command submitter

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Christoffer Sandberg (1):
      Input: soc_button_array - add mapping for airplane mode button

Dan Carpenter (1):
      usb: fotg210-hcd: delete an incorrect bounds test

Dan Sneddon (2):
      spi: atmel: Switch to transfer_one transfer method
      spi: atmel: Fix CS and initialization bug

David Howells (4):
      afs: Fix the dynamic root's d_delete to always delete unused dentries
      afs: Fix dynamic root lookup DNS check
      keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry
      afs: Fix overwriting of result of DNS query

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Fabio Estevam (1):
      dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geert Uytterhoeven (1):
      reset: Fix crash when freeing non-existent optional resets

Greg Kroah-Hartman (2):
      Revert "MIPS: Loongson64: Enable DMA noncoherent support"
      Linux 5.10.206

Hangyu Hua (1):
      9p/net: fix possible memory leak in p9_check_errors()

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (1):
      s390/vx: fix save/restore of fpu kernel context

Heiner Kallweit (1):
      net: warn if gso_type isn't set for a GSO SKB

Herve Codina (1):
      lib/vsprintf: Fix %pfwf when current node refcount == 0

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Javier Carrasco (1):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Johannes Berg (2):
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

Josef Bacik (1):
      btrfs: do not allow non subvolume root targets for snapshot

Kai Vehmanen (2):
      ALSA: hda/hdmi: Add quirk to force pin connectivity on NUC10
      ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Liu Jian (1):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Luiz Augusto von Dentz (3):
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
      Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg
      Bluetooth: SMP: Fix crash when receiving new connection when debug is enabled

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Martin K. Petersen (2):
      scsi: core: Add scsi_prot_ref_tag() helper
      scsi: core: Make scsi_get_lba() return the LBA

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Namjae Jeon (1):
      ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Pablo Neira Ayuso (1):
      netfilter: nf_tables: skip set commit for deleted/destroyed sets

Paulo Alcantara (4):
      smb: client: fix OOB in smb2_query_reparse_point()
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in SMB2_query_info_init()
      smb: client: fix OOB in smbCalcSize()

Quan Nguyen (1):
      i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Rahul Rameshbabu (1):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Shifeng Li (1):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Steven Rostedt (Google) (3):
      tracing / synthetic: Disable events after testing in synth_event_gen_test_init()
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      tracing: Fix blocked reader of snapshot buffer

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Thomas Gleixner (1):
      x86/alternatives: Sync core before enabling interrupts

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write only after srst_udelay
      ARM: dts: Fix occasional boot hang for am3 usb

Ville Baillie (1):
      spi: atmel: Fix PDC transfer setup bug

Vlad Buslov (1):
      Revert "net/mlx5e: fix double free of encap_header"

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources


