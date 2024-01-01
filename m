Return-Path: <linux-kernel+bounces-13865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4168213C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5688282249
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43C53AA;
	Mon,  1 Jan 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqtlrHwF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18186AA0;
	Mon,  1 Jan 2024 13:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E62C433C9;
	Mon,  1 Jan 2024 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704114016;
	bh=X5vQ14h9V/4S1ScGKgeHZAZTkuWgOdPdt0ngY4uJ3xY=;
	h=From:To:Cc:Subject:Date:From;
	b=jqtlrHwFt3YHhYwAW//tfFwaC0ILjvMLqnRxVUk2Fd5la3GD71IQLUqtR4QcU1kX3
	 LPebo+CZK9JMmn1c9w+qcaBkSFPoy2V+hcdZWVBPXv1smCjw0T1ZuY+4NsDnuFjaUc
	 qKR+C02ISlOzAnFYgwiiCLCtwb+RJkVL436Mlm7s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.9
Date: Mon,  1 Jan 2024 13:00:07 +0000
Message-ID: <2024010107-discharge-anime-d43d@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.9 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml             |   10 
 Makefile                                                           |    2 
 arch/arm/boot/dts/ti/omap/am33xx.dtsi                              |    1 
 arch/arm/boot/dts/ti/omap/dra7.dtsi                                |    2 
 arch/arm/mach-omap2/id.c                                           |    5 
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi       |    3 
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts       |    3 
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts       |    2 
 arch/arm64/kvm/arm.c                                               |    2 
 arch/arm64/kvm/vgic/vgic-init.c                                    |   47 ++-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                 |    2 
 arch/arm64/kvm/vgic/vgic.h                                         |    1 
 arch/s390/include/asm/fpu/api.h                                    |    2 
 arch/x86/kernel/alternative.c                                      |   14 -
 arch/x86/kernel/head_64.S                                          |   16 +
 arch/x86/net/bpf_jit_comp.c                                        |   46 +++
 arch/x86/xen/Kconfig                                               |    1 
 drivers/bluetooth/hci_vhci.c                                       |   10 
 drivers/bus/ti-sysc.c                                              |   18 +
 drivers/gpio/gpio-dwapb.c                                          |   12 
 drivers/gpio/gpiolib-cdev.c                                        |   16 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                             |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                  |    3 
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                       |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c          |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c                  |   12 
 drivers/gpu/drm/drm_auth.c                                         |    3 
 drivers/gpu/drm/drm_debugfs.c                                      |   10 
 drivers/gpu/drm/drm_file.c                                         |   40 ++
 drivers/gpu/drm/drm_ioctl.c                                        |    3 
 drivers/gpu/drm/i915/display/g4x_dp.c                              |   10 
 drivers/gpu/drm/i915/display/intel_crt.c                           |    2 
 drivers/gpu/drm/i915/display/intel_crtc_state_dump.c               |    3 
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                       |    3 
 drivers/gpu/drm/i915/display/intel_ddi.c                           |   22 -
 drivers/gpu/drm/i915/display/intel_display.c                       |   12 
 drivers/gpu/drm/i915/display/intel_display_types.h                 |    2 
 drivers/gpu/drm/i915/display/intel_dmc.c                           |   43 +++
 drivers/gpu/drm/i915/display/intel_dp.c                            |    3 
 drivers/gpu/drm/i915/display/intel_dp_link_training.c              |   35 +-
 drivers/gpu/drm/i915/i915_hwmon.c                                  |    4 
 drivers/gpu/drm/nouveau/nouveau_drm.c                              |    5 
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                                |    6 
 drivers/i2c/busses/i2c-aspeed.c                                    |   48 ++-
 drivers/i2c/busses/i2c-qcom-geni.c                                 |    8 
 drivers/iio/accel/kionix-kx022a.c                                  |   37 +-
 drivers/iio/adc/imx93_adc.c                                        |    4 
 drivers/iio/adc/meson_saradc.c                                     |   16 +
 drivers/iio/adc/ti_am335x_adc.c                                    |    4 
 drivers/iio/buffer/industrialio-triggered-buffer.c                 |   10 
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c                     |    4 
 drivers/iio/imu/adis16475.c                                        |  117 +++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                         |    4 
 drivers/iio/magnetometer/tmag5273.c                                |    2 
 drivers/input/keyboard/ipaq-micro-keys.c                           |    3 
 drivers/input/misc/soc_button_array.c                              |    5 
 drivers/interconnect/core.c                                        |    3 
 drivers/interconnect/qcom/sm8250.c                                 |    1 
 drivers/md/dm-integrity.c                                          |   11 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                    |    5 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                      |   11 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                       |    4 
 drivers/net/ethernet/intel/ice/ice_lag.c                           |    2 
 drivers/net/ethernet/intel/ice/ice_lib.c                           |    7 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c            |   17 +
 drivers/net/ethernet/mediatek/mtk_wed_wo.c                         |    3 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                      |   12 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c         |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c                |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c          |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                    |   10 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                  |    3 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c         |   31 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c |    4 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                    |    2 
 drivers/net/ethernet/micrel/ks8851.h                               |    3 
 drivers/net/ethernet/micrel/ks8851_common.c                        |   20 -
 drivers/net/ethernet/micrel/ks8851_spi.c                           |   42 ++-
 drivers/net/ethernet/microsoft/Kconfig                             |    1 
 drivers/net/ethernet/mscc/ocelot_stats.c                           |   16 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c              |    2 
 drivers/net/phy/phy_device.c                                       |    6 
 drivers/net/usb/ax88179_178a.c                                     |   23 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                    |    4 
 drivers/net/wireless/mediatek/mt76/dma.c                           |   10 
 drivers/nvme/host/core.c                                           |    3 
 drivers/nvmem/brcm_nvram.c                                         |  134 +++++++---
 drivers/pinctrl/pinctrl-at91-pio4.c                                |    8 
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c                 |    4 
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c                 |    4 
 drivers/platform/x86/intel/pmc/core.c                              |    2 
 drivers/reset/core.c                                               |    8 
 drivers/scsi/aacraid/aacraid.h                                     |    1 
 drivers/scsi/aacraid/commsup.c                                     |    6 
 drivers/scsi/aacraid/linit.c                                       |   14 -
 drivers/scsi/aacraid/src.c                                         |   25 -
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                                  |    9 
 drivers/scsi/scsi_error.c                                          |    2 
 drivers/spi/spi-atmel.c                                            |   92 ++++++
 drivers/spi/spi-cadence.c                                          |    1 
 drivers/spi/spi-imx.c                                              |   15 -
 drivers/thunderbolt/debugfs.c                                      |    2 
 drivers/ufs/core/ufshcd.c                                          |    3 
 drivers/ufs/host/ufs-qcom.c                                        |    6 
 drivers/usb/fotg210/fotg210-hcd.c                                  |    3 
 drivers/usb/serial/ftdi_sio.c                                      |    6 
 drivers/usb/serial/ftdi_sio_ids.h                                  |    6 
 drivers/usb/serial/option.c                                        |    5 
 drivers/usb/storage/unusual_devs.h                                 |   11 
 drivers/usb/typec/ucsi/ucsi_glink.c                                |    2 
 fs/afs/cell.c                                                      |    6 
 fs/afs/dynroot.c                                                   |   31 +-
 fs/afs/internal.h                                                  |    2 
 fs/afs/volume.c                                                    |   26 +
 fs/btrfs/disk-io.c                                                 |   28 ++
 fs/btrfs/qgroup.c                                                  |   96 +++----
 fs/btrfs/qgroup.h                                                  |    9 
 fs/btrfs/transaction.c                                             |    2 
 fs/btrfs/transaction.h                                             |    3 
 fs/nfsd/nfsctl.c                                                   |    9 
 fs/nfsd/nfsd.h                                                     |    1 
 fs/nfsd/nfssvc.c                                                   |    2 
 fs/smb/client/cifs_debug.c                                         |   12 
 fs/smb/client/cifsglob.h                                           |    3 
 fs/smb/client/connect.c                                            |    7 
 fs/smb/client/misc.c                                               |    4 
 fs/smb/client/smb2ops.c                                            |   19 -
 fs/smb/client/smb2pdu.c                                            |   29 +-
 include/drm/drm_file.h                                             |   13 
 include/linux/bpf.h                                                |    3 
 include/linux/damon.h                                              |   16 +
 include/linux/ieee80211.h                                          |    3 
 include/linux/key-type.h                                           |    1 
 include/net/bluetooth/hci_core.h                                   |    9 
 include/net/ip6_fib.h                                              |   64 ----
 include/net/sock.h                                                 |    5 
 include/trace/events/9p.h                                          |   11 
 kernel/bpf/arraymap.c                                              |   58 ----
 kernel/trace/ring_buffer.c                                         |  130 ++-------
 kernel/trace/synth_event_gen_test.c                                |   11 
 lib/vsprintf.c                                                     |   11 
 mm/damon/core.c                                                    |  102 +++----
 net/8021q/vlan_core.c                                              |    9 
 net/9p/protocol.c                                                  |   17 -
 net/bluetooth/af_bluetooth.c                                       |    7 
 net/bluetooth/hci_event.c                                          |   30 +-
 net/bluetooth/l2cap_core.c                                         |   21 +
 net/bluetooth/mgmt.c                                               |   25 +
 net/bluetooth/smp.c                                                |    7 
 net/core/dev.c                                                     |    3 
 net/core/skbuff.c                                                  |    2 
 net/core/sock_map.c                                                |    2 
 net/core/stream.c                                                  |    2 
 net/dns_resolver/dns_key.c                                         |   10 
 net/ife/ife.c                                                      |    1 
 net/ipv6/ip6_fib.c                                                 |   55 ----
 net/ipv6/route.c                                                   |    6 
 net/mac80211/cfg.c                                                 |    4 
 net/mac80211/driver-ops.c                                          |    6 
 net/mac80211/mesh_plink.c                                          |   16 -
 net/mac80211/mlme.c                                                |    4 
 net/rfkill/rfkill-gpio.c                                           |    8 
 net/rose/af_rose.c                                                 |   39 ++
 net/sunrpc/svc_xprt.c                                              |    5 
 net/wireless/certs/wens.hex                                        |   87 ++++++
 security/keys/gc.c                                                 |   31 +-
 security/keys/internal.h                                           |   11 
 security/keys/key.c                                                |   15 -
 security/keys/proc.c                                               |    2 
 sound/pci/hda/patch_realtek.c                                      |    1 
 sound/pci/hda/tas2781_hda_i2c.c                                    |    4 
 sound/soc/codecs/hdmi-codec.c                                      |   12 
 sound/soc/codecs/tas2781-fmwlib.c                                  |   14 -
 sound/soc/fsl/fsl_sai.c                                            |    3 
 sound/usb/quirks.c                                                 |    4 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                    |    8 
 183 files changed, 1676 insertions(+), 906 deletions(-)

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

Andy Gospodarek (1):
      bnxt_en: do not map packet buffers twice

Arnd Bergmann (2):
      Bluetooth: hci_event: shut up a false-positive warning
      x86/xen: add CPU dependencies for 32-bit build

Benjamin Bigler (1):
      spi: spi-imx: correctly configure burst length when using dma

Boris Burkov (1):
      btrfs: free qgroup pertrans reserve on transaction abort

Can Guo (1):
      scsi: ufs: core: Let the sq_lock protect sq_tail_slot access

Carolina Jubran (1):
      net/mlx5e: XDP, Drop fragmented packets larger than MTU size

ChanWoo Lee (1):
      scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Chris Mi (1):
      net/mlx5e: Decrease num_block_tc when unblock tc offload

Christoffer Sandberg (1):
      Input: soc_button_array - add mapping for airplane mode button

Chuck Lever (1):
      SUNRPC: Revert 5f7fc5d69f6e92ec0b38774c387f5cf7812c5806

Chukun Pan (1):
      arm64: dts: allwinner: h616: update emac for Orange Pi Zero 3

Clément Villeret (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG GV302XA

Dan Carpenter (3):
      net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
      net/mlx5e: Fix error codes in alloc_branch_attr()
      usb: fotg210-hcd: delete an incorrect bounds test

Daniel Golle (1):
      net: phy: skip LED triggers on PHYs on SFP modules

Dave Ertman (1):
      ice: alter feature support check for SRIOV and LAG

David Ahern (1):
      net/ipv6: Revert remove expired routes with a separated list of routes

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

Felix Fietkau (1):
      wifi: mt76: fix crash with WED rx support enabled

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geert Uytterhoeven (1):
      reset: Fix crash when freeing non-existent optional resets

Geliang Tang (1):
      selftests: mptcp: join: fix subflow_send_ack lookup

George Stark (1):
      iio: adc: meson: add separate config for axg SoC family

Gergo Koteles (2):
      ALSA: hda/tas2781: select program 0, conf 0 by default
      ASoC: tas2781: check the validity of prm_no/cfg_no

Greg Kroah-Hartman (1):
      Linux 6.6.9

Haibo Chen (1):
      iio: adc: imx93: add four channels for imx93 adc

Hamza Mahfooz (1):
      drm/amd/display: fix hw rotated modes when PSR-SU is enabled

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (1):
      s390/vx: fix save/restore of fpu kernel context

Herve Codina (1):
      lib/vsprintf: Fix %pfwf when current node refcount == 0

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Imre Deak (1):
      drm/i915/mtl: Fix HDMI/DP PLL clock selection

JP Kobryn (1):
      9p: prevent read overrun in protocol dump tracepoint

Jacob Keller (1):
      ice: stop trashing VF VSI aggregator node ID information

Jani Nikula (1):
      drm/i915/edp: don't write to DP_LINK_BW_SET when using rate select

Javier Carrasco (2):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table
      iio: tmag5273: fix temperature offset

Jeremie Knuesel (1):
      ALSA: usb-audio: Increase delay in MOTU M quirk

Jerome Brunet (1):
      ASoC: hdmi-codec: fix missing report for jack initial status

Jianbo Liu (1):
      net/mlx5e: Fix overrun reported by coverity

Jiri Olsa (1):
      bpf: Fix prog_array_map_poke_run map poke update

Johan Hovold (1):
      usb: typec: ucsi: fix gpio-based orientation detection

Johannes Berg (7):
      wifi: ieee80211: don't require protected vendor action frames
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: don't re-add debugfs during reconfig
      wifi: mac80211: check defragmentation succeeded
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

John Fastabend (1):
      bpf: syzkaller found null ptr deref in unix_bpf proto add

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid failed operations when device is disconnected

Karthik Poosa (1):
      drm/i915/hwmon: Fix static analysis tool reported issues

Kent Gibson (1):
      gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Lai Peter Jun Ann (1):
      net: stmmac: fix incorrect flag check in timestamp interrupt

Larysa Zaremba (1):
      ice: Fix PF with enabled XDP going no-carrier after reset

Lingkai Dong (1):
      drm: Fix FD ownership check in drm_master_check_perm()

Liu Jian (1):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()

Louis Chauvet (1):
      spi: atmel: Fix clock issue when using devices with different polarities

Luiz Augusto von Dentz (3):
      Bluetooth: Fix not notifying when connection encryption changes
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Marc Zyngier (3):
      KVM: arm64: vgic: Simplify kvm_vgic_destroy()
      KVM: arm64: vgic: Add a non-locking primitive for kvm_vgic_vcpu_destroy()
      KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Martin K. Petersen (1):
      Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity"

Mathieu Desnoyers (1):
      ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

Matti Vaittinen (1):
      iio: kx022a: Fix acceleration value scaling

Maurizio Lombardi (1):
      nvme-pci: fix sleeping function called from interrupt context

Michal Schmidt (1):
      ice: fix theoretical out-of-bounds access in ethtool link modes

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Miquel Raynal (2):
      spi: atmel: Do not cancel a transfer upon any signal
      spi: atmel: Prevent spi transfers from being killed

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Nam Cao (3):
      pinctrl: starfive: jh7110: ignore disabled device tree nodes
      pinctrl: starfive: jh7100: ignore disabled device tree nodes
      spi: cadence: revert "Add SPI transfer delays"

NeilBrown (1):
      nfsd: call nfsd_last_thread() before final nfsd_put()

Nuno Sa (1):
      iio: imu: adis16475: add spi_device_id table

Paulo Alcantara (4):
      smb: client: fix OOB in cifsd when receiving compounded resps
      smb: client: fix potential OOB in cifs_dump_detail()
      smb: client: fix OOB in SMB2_query_info_init()
      smb: client: fix OOB in smbCalcSize()

Qu Wenruo (2):
      btrfs: qgroup: iterate qgroups without memory allocation for qgroup_reserve()
      btrfs: qgroup: use qgroup_iterator in qgroup_convert_meta()

Quan Nguyen (1):
      i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Rafał Miłecki (1):
      nvmem: brcm_nvram: store a copy of NVRAM content

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Rajvi Jingar (1):
      platform/x86/intel/pmc: Fix hang in pmc_core_send_ltr_ignore()

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

SeongJae Park (2):
      mm/damon/core: use number of passed access sampling as a timer
      mm/damon/core: make damon_start() waits until kdamond_fn() starts

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Shigeru Yoshida (1):
      net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Steven Rostedt (Google) (3):
      ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()
      ring-buffer: Fix slowpath of interrupted event
      tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Suman Ghosh (1):
      octeontx2-pf: Fix graceful exit during PFC configuration failure

Tasos Sahanidis (1):
      usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G3

Thomas Gleixner (3):
      x86/alternatives: Sync core before enabling interrupts
      x86/alternatives: Disable interrupts and sync when optimizing NOPs in place
      x86/smpboot/64: Handle X2APIC BIOS inconsistency gracefully

Thomas Weißschuh (1):
      net: avoid build bug in skb extension length calculation

Tony Lindgren (2):
      ARM: dts: Fix occasional boot hang for am3 usb
      bus: ti-sysc: Flush posted write only after srst_udelay

Tvrtko Ursulin (1):
      drm: Update file owner during use

Ville Syrjälä (4):
      drm/i915: Fix FEC state dump
      drm/i915: Introduce crtc_state->enhanced_framing
      drm/i915: Reject async flips with bigjoiner
      drm/i915/dmc: Don't enable any pipe DMC events

Vlad Buslov (3):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"
      net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

Vladimir Oltean (2):
      net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above
      net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Yang Yingliang (1):
      i2c: qcom-geni: fix missing clk_disable_unprepare() and geni_se_resources_off()

Yaxiong Tian (1):
      thunderbolt: Fix memory leak in margining_port_remove()

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

Yury Norov (1):
      net: mana: select PAGE_POOL

ZhenGuo Yin (1):
      drm/amdgpu: re-create idle bo's PTE during VM state machine reset

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

xiongxin (1):
      gpio: dwapb: mask/unmask IRQ when disable/enale it


