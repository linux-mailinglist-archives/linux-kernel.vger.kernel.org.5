Return-Path: <linux-kernel+bounces-13863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51B8213C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC111F217B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950023C28;
	Mon,  1 Jan 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VjM1qYb0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEA3C0A;
	Mon,  1 Jan 2024 13:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC77C433C7;
	Mon,  1 Jan 2024 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704114006;
	bh=AjyNzKsePONE7QVaxwrM4JfbDdPl6sV/IFjjConKp5U=;
	h=From:To:Cc:Subject:Date:From;
	b=VjM1qYb0tpe238rNWEYNU2NPMaXEk+qKecT6khNSW1w/hjLII04M5oVzO7JLIMybX
	 4r9VniHmWiYaVUAPNmIvzIRyCB3syoLuF/tYKlAoffzKRO4WMAK0n833bXH0jztg4H
	 mKxs0SxxFyBHEobVpb+98ETfydh52ZEwyJ3kJWuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.70
Date: Mon,  1 Jan 2024 13:00:00 +0000
Message-ID: <2024010101-paving-curry-f065@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.70 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml      |   10 
 Makefile                                                    |    2 
 arch/arm/boot/dts/dra7.dtsi                                 |    2 
 arch/arm/mach-omap2/id.c                                    |    5 
 arch/arm64/kvm/arm.c                                        |    2 
 arch/arm64/kvm/vgic/vgic-init.c                             |   47 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                          |    2 
 arch/arm64/kvm/vgic/vgic.h                                  |    1 
 arch/riscv/include/asm/signal.h                             |    2 
 arch/s390/include/asm/fpu/api.h                             |    2 
 arch/x86/kernel/alternative.c                               |    2 
 arch/x86/net/bpf_jit_comp.c                                 |   46 ++
 arch/x86/xen/Kconfig                                        |    1 
 drivers/block/loop.c                                        |   40 +
 drivers/block/ublk_drv.c                                    |   40 +
 drivers/bluetooth/hci_vhci.c                                |   10 
 drivers/bus/ti-sysc.c                                       |   18 
 drivers/gpio/gpio-dwapb.c                                   |   12 
 drivers/gpio/gpiolib-cdev.c                                 |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    3 
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c           |   12 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c          |    3 
 drivers/gpu/drm/i915/display/intel_atomic.c                 |  193 ---------
 drivers/gpu/drm/i915/display/intel_atomic.h                 |    4 
 drivers/gpu/drm/i915/display/intel_display.c                |   11 
 drivers/gpu/drm/i915/display/intel_fb.c                     |   10 
 drivers/gpu/drm/i915/display/skl_scaler.c                   |  257 ++++++++++++
 drivers/gpu/drm/i915/display/skl_scaler.h                   |   10 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                          |   15 
 drivers/i2c/busses/i2c-aspeed.c                             |   48 +-
 drivers/iio/adc/ti_am335x_adc.c                             |    4 
 drivers/iio/buffer/industrialio-triggered-buffer.c          |   10 
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c              |    4 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                  |    4 
 drivers/input/keyboard/ipaq-micro-keys.c                    |    3 
 drivers/input/misc/soc_button_array.c                       |    5 
 drivers/interconnect/core.c                                 |    3 
 drivers/interconnect/qcom/sm8250.c                          |    1 
 drivers/md/dm-bufio.c                                       |    7 
 drivers/md/dm-integrity.c                                   |   11 
 drivers/md/dm-thin-metadata.c                               |   58 +-
 drivers/md/persistent-data/dm-block-manager.c               |    6 
 drivers/md/persistent-data/dm-block-manager.h               |    1 
 drivers/md/persistent-data/dm-space-map.h                   |    3 
 drivers/md/persistent-data/dm-transaction-manager.c         |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c             |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c     |   17 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c               |  216 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c         |   30 -
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c             |    2 
 drivers/net/ethernet/micrel/ks8851.h                        |    3 
 drivers/net/ethernet/micrel/ks8851_common.c                 |   20 
 drivers/net/ethernet/micrel/ks8851_spi.c                    |   42 +
 drivers/net/ethernet/microsoft/Kconfig                      |    1 
 drivers/net/ethernet/mscc/ocelot_stats.c                    |    8 
 drivers/net/usb/ax88179_178a.c                              |   23 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    4 
 drivers/nvme/host/core.c                                    |    3 
 drivers/pinctrl/pinctrl-at91-pio4.c                         |    8 
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c          |    4 
 drivers/reset/core.c                                        |    8 
 drivers/scsi/aacraid/aacraid.h                              |    1 
 drivers/scsi/aacraid/commsup.c                              |    6 
 drivers/scsi/aacraid/linit.c                                |   14 
 drivers/scsi/aacraid/src.c                                  |   25 -
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                           |    9 
 drivers/scsi/scsi_error.c                                   |    2 
 drivers/thunderbolt/debugfs.c                               |    2 
 drivers/usb/serial/ftdi_sio.c                               |    6 
 drivers/usb/serial/ftdi_sio_ids.h                           |    6 
 drivers/usb/serial/option.c                                 |    5 
 drivers/usb/storage/unusual_devs.h                          |   11 
 fs/afs/cell.c                                               |    6 
 fs/afs/dynroot.c                                            |   31 -
 fs/afs/internal.h                                           |    2 
 fs/afs/volume.c                                             |   26 +
 fs/btrfs/free-space-cache.c                                 |    8 
 fs/btrfs/zoned.c                                            |   26 -
 fs/fuse/fuse_i.h                                            |   15 
 fs/fuse/inode.c                                             |   75 +++
 fs/smb/client/cifs_debug.c                                  |   12 
 fs/smb/client/cifsglob.h                                    |    3 
 fs/smb/client/connect.c                                     |    7 
 fs/smb/client/misc.c                                        |    4 
 fs/smb/client/smb2ops.c                                     |   19 
 fs/smb/client/smb2pdu.c                                     |   29 +
 fs/ubifs/tnc.c                                              |    1 
 include/linux/bpf.h                                         |    3 
 include/linux/damon.h                                       |    3 
 include/linux/dm-bufio.h                                    |    2 
 include/linux/kasan.h                                       |    6 
 include/linux/key-type.h                                    |    1 
 include/linux/mlx5/driver.h                                 |   20 
 include/net/bluetooth/hci_core.h                            |    5 
 include/trace/events/9p.h                                   |   11 
 kernel/bpf/arraymap.c                                       |   58 --
 kernel/trace/synth_event_gen_test.c                         |   11 
 lib/vsprintf.c                                              |   11 
 mm/damon/core.c                                             |    7 
 mm/kasan/report.c                                           |    4 
 net/8021q/vlan_core.c                                       |    9 
 net/9p/protocol.c                                           |   17 
 net/bluetooth/af_bluetooth.c                                |    7 
 net/bluetooth/hci_event.c                                   |   22 -
 net/bluetooth/l2cap_core.c                                  |   21 
 net/bluetooth/mgmt.c                                        |   25 -
 net/bluetooth/smp.c                                         |    7 
 net/core/dev.c                                              |    3 
 net/core/stream.c                                           |    2 
 net/dns_resolver/dns_key.c                                  |   10 
 net/ife/ife.c                                               |    1 
 net/mac80211/cfg.c                                          |    4 
 net/mac80211/mesh_plink.c                                   |   16 
 net/rfkill/rfkill-gpio.c                                    |    8 
 net/rose/af_rose.c                                          |   39 +
 net/wireless/certs/wens.hex                                 |   87 ++++
 net/wireless/core.h                                         |    1 
 net/wireless/nl80211.c                                      |   56 +-
 security/keys/gc.c                                          |   31 -
 security/keys/internal.h                                    |   11 
 security/keys/key.c                                         |   15 
 security/keys/proc.c                                        |    2 
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/soc/codecs/hdmi-codec.c                               |   12 
 sound/soc/fsl/fsl_sai.c                                     |    3 
 sound/usb/quirks.c                                          |    4 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    8 
 134 files changed, 1497 insertions(+), 776 deletions(-)

Alex Lu (1):
      Bluetooth: Add more enc key size check

Alexander Atanasov (1):
      scsi: core: Always send batch on reset or error handling command

Alexis Lothoré (1):
      pinctrl: at91-pio4: use dedicated lock class for IRQ

Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Andrew Davis (1):
      ARM: dts: dra7: Fix DRA7 L3 NoC node register size

Andy Shevchenko (1):
      HID: i2c-hid: acpi: Unify ACPI ID tables format

Aric Cyr (1):
      Revert "drm/amd/display: Do not set DRR on pipe commit"

Arnd Bergmann (3):
      kasan: disable kasan_non_canonical_hook() for HW tags
      Bluetooth: hci_event: shut up a false-positive warning
      x86/xen: add CPU dependencies for 32-bit build

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Christoffer Sandberg (1):
      Input: soc_button_array - add mapping for airplane mode button

Clint Taylor (1):
      drm/i915/mtl: Add MTL for remapping CCS FBs

Clément Villeret (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG GV302XA

David Howells (5):
      afs: Fix the dynamic root's d_delete to always delete unused dentries
      afs: Fix dynamic root lookup DNS check
      keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry
      afs: Fix overwriting of result of DNS query
      afs: Fix use-after-free due to get/remove race in volume tree

David Lechner (1):
      iio: triggered-buffer: prevent possible freeing of wrong buffer

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Edward Adam Davis (1):
      wifi: mac80211: check if the existing link config remains unchanged

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

Geliang Tang (1):
      selftests: mptcp: join: fix subflow_send_ack lookup

Greg Kroah-Hartman (1):
      Linux 6.1.70

Hamza Mahfooz (1):
      drm/amd/display: fix hw rotated modes when PSR-SU is enabled

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (1):
      s390/vx: fix save/restore of fpu kernel context

Heiko Stuebner (1):
      RISC-V: Fix do_notify_resume / do_work_pending prototype

Herve Codina (1):
      lib/vsprintf: Fix %pfwf when current node refcount == 0

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

JP Kobryn (1):
      9p: prevent read overrun in protocol dump tracepoint

Javier Carrasco (1):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Jeremie Knuesel (1):
      ALSA: usb-audio: Increase delay in MOTU M quirk

Jerome Brunet (1):
      ASoC: hdmi-codec: fix missing report for jack initial status

Jiri Olsa (1):
      bpf: Fix prog_array_map_poke_run map poke update

Johannes Berg (5):
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order
      wifi: cfg80211: fix CQM for non-range use

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid failed operations when device is disconnected

Kent Gibson (1):
      gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Konstantin Meskhidze (1):
      ubifs: fix possible dereference after free

Krister Johansen (1):
      fuse: share lookup state between submount and its parent

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Li Lingfeng (1):
      dm thin metadata: Fix ABBA deadlock by resetting dm_bufio_client

Liu Jian (1):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Luca Coelho (1):
      drm/i915/mtl: limit second scaler vertical scaling in ver >= 14

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Léo Lam (1):
      wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)

Marc Zyngier (3):
      KVM: arm64: vgic: Simplify kvm_vgic_destroy()
      KVM: arm64: vgic: Add a non-locking primitive for kvm_vgic_vcpu_destroy()
      KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy

Mario Limonciello (1):
      HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Martin K. Petersen (1):
      Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity"

Mauricio Faria de Oliveira (2):
      loop: do not enforce max_loop hard limit by (new) default
      loop: deprecate autoloading callback loop_probe()

Maurizio Lombardi (1):
      nvme-pci: fix sleeping function called from interrupt context

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Ming Lei (1):
      ublk: move ublk_cancel_dev() out of ub->mutex

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Nam Cao (1):
      pinctrl: starfive: jh7100: ignore disabled device tree nodes

Naohiro Aota (1):
      btrfs: zoned: no longer count fresh BG region as zone unusable

Paulo Alcantara (4):
      smb: client: fix OOB in cifsd when receiving compounded resps
      smb: client: fix potential OOB in cifs_dump_detail()
      smb: client: fix OOB in SMB2_query_info_init()
      smb: client: fix OOB in smbCalcSize()

Quan Nguyen (1):
      i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

SeongJae Park (1):
      mm/damon/core: make damon_start() waits until kdamond_fn() starts

Shay Drory (1):
      net/mlx5: Re-organize mlx5_cmd struct

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Shigeru Yoshida (1):
      net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Steven Rostedt (Google) (1):
      tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Suman Ghosh (1):
      octeontx2-pf: Fix graceful exit during PFC configuration failure

Tariq Toukan (2):
      net/mlx5: Introduce and use opcode getter in command interface
      net/mlx5: Prevent high-rate FW commands from populating all slots

Tasos Sahanidis (1):
      usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G3

Thomas Gleixner (1):
      x86/alternatives: Sync core before enabling interrupts

Tony Lindgren (1):
      bus: ti-sysc: Flush posted write only after srst_udelay

Ville Syrjälä (5):
      drm/i915: Relocate intel_atomic_setup_scalers()
      drm/i915: Fix intel_atomic_setup_scalers() plane_state handling
      drm/i915/dpt: Only do the POT stride remap when using DPT
      drm/i915: Fix ADL+ tiled plane stride when the POT stride is smaller than the original
      drm/i915: Reject async flips with bigjoiner

Vlad Buslov (2):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"

Vladimir Oltean (1):
      net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Yaxiong Tian (1):
      thunderbolt: Fix memory leak in margining_port_remove()

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

Yury Norov (1):
      net: mana: select PAGE_POOL

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

xiongxin (1):
      gpio: dwapb: mask/unmask IRQ when disable/enale it


