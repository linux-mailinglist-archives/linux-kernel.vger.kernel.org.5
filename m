Return-Path: <linux-kernel+bounces-13414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EED820570
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4920FB2122F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACDB8827;
	Sat, 30 Dec 2023 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOMyPzwm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A38473;
	Sat, 30 Dec 2023 12:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CCAC433C7;
	Sat, 30 Dec 2023 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938105;
	bh=DJia6lfwP8M3JSLZyrWRKvnAMWYMnYvpbyN+0m4gUs8=;
	h=From:To:Cc:Subject:Date:From;
	b=DOMyPzwm3yH0IOE9E0a1FPT3X+p+ULpyRAZ8Pg6qPH8n6Toi1T4Lh2rNWMzO9Rspm
	 ThM5n5x5UUDCzI0Nm/uWG/avlk6ZL2PizE73HGW1PjamHAeQpFemWfouQcIfe9vm6x
	 SH8IBv7Fv8tTYC/JkJObNBlLMjxnKdWZbOE+0Kzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.1 000/112] 6.1.70-rc1 review
Date: Sat, 30 Dec 2023 11:58:33 +0000
Message-ID: <20231230115806.714618407@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.70-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.70-rc1
X-KernelTest-Deadline: 2024-01-01T11:58+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.70 release.
There are 112 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.70-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.70-rc1

Léo Lam <leo@leolam.fr>
    wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix CQM for non-range use

Krister Johansen <kjlx@templeofstupid.com>
    fuse: share lookup state between submount and its parent

SeongJae Park <sj@kernel.org>
    mm/damon/core: make damon_start() waits until kdamond_fn() starts

Thomas Gleixner <tglx@linutronix.de>
    x86/alternatives: Sync core before enabling interrupts

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Add a non-locking primitive for kvm_vgic_vcpu_destroy()

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Simplify kvm_vgic_destroy()

Yaxiong Tian <tianyaxiong@kylinos.cn>
    thunderbolt: Fix memory leak in margining_port_remove()

Herve Codina <herve.codina@bootlin.com>
    lib/vsprintf: Fix %pfwf when current node refcount == 0

xiongxin <xiongxin@kylinos.cn>
    gpio: dwapb: mask/unmask IRQ when disable/enale it

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Flush posted write only after srst_udelay

Nam Cao <namcao@linutronix.de>
    pinctrl: starfive: jh7100: ignore disabled device tree nodes

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

Alexander Atanasov <alexander.atanasov@virtuozzo.com>
    scsi: core: Always send batch on reset or error handling command

Martin K. Petersen <martin.petersen@oracle.com>
    Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity"

Geliang Tang <geliang.tang@linux.dev>
    selftests: mptcp: join: fix subflow_send_ack lookup

Ming Lei <ming.lei@redhat.com>
    ublk: move ublk_cancel_dev() out of ub->mutex

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    ubifs: fix possible dereference after free

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: no longer count fresh BG region as zone unusable

Aric Cyr <aric.cyr@amd.com>
    Revert "drm/amd/display: Do not set DRR on pipe commit"

Li Lingfeng <lilingfeng3@huawei.com>
    dm thin metadata: Fix ABBA deadlock by resetting dm_bufio_client

Mauricio Faria de Oliveira <mfo@canonical.com>
    loop: do not enforce max_loop hard limit by (new) default

Heiko Stuebner <heiko.stuebner@vrull.eu>
    RISC-V: Fix do_notify_resume / do_work_pending prototype

JP Kobryn <inwardvessel@gmail.com>
    9p: prevent read overrun in protocol dump tracepoint

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Reject async flips with bigjoiner

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smbCalcSize()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in SMB2_query_info_init()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOB in cifs_dump_detail()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in cifsd when receiving compounded resps

Fabio Estevam <festevam@denx.de>
    dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Ronald Wahl <ronald.wahl@raritan.com>
    net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski <r.czerwinski@pengutronix.de>
    net: rfkill: gpio: set GPIO direction

Fedor Pchelkin <pchelkin@ispras.ru>
    net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Christoffer Sandberg <cs@tuxedo.de>
    Input: soc_button_array - add mapping for airplane mode button

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid failed operations when device is disconnected

Alex Lu <alex_lu@realsil.com.cn>
    Bluetooth: Add more enc key size check

Xiao Yao <xiaoyao@rock-chips.com>
    Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Frédéric Danis <frederic.danis@collabora.com>
    Bluetooth: L2CAP: Send reject on command corrupted request

Hyunwoo Kim <v4bel@theori.io>
    Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Clément Villeret <clement.villeret@gmail.com>
    ALSA: hda/realtek: Add quirk for ASUS ROG GV302XA

Reinhard Speyerer <rspmn@arcor.de>
    USB: serial: option: add Quectel RM500Q R13 firmware support

Slark Xiao <slark_xiao@163.com>
    USB: serial: option: add Foxconn T99W265 with new baseline

Alper Ak <alperyasinak1@gmail.com>
    USB: serial: option: add Quectel EG912Y module support

Mark Glover <mark.glover@actisense.com>
    USB: serial: ftdi_sio: update Actisense PIDs constant names

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix certs build to not depend on file order

Chen-Yu Tsai <wens@kernel.org>
    wifi: cfg80211: Add my certificate

Tasos Sahanidis <tasos@tasossah.com>
    usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G3

Jeremie Knuesel <knuesel@gmail.com>
    ALSA: usb-audio: Increase delay in MOTU M quirk

David Lechner <dlechner@baylibre.com>
    iio: triggered-buffer: prevent possible freeing of wrong buffer

Wadim Egorov <w.egorov@phytec.de>
    iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Wei Yongjun <weiyongjun1@huawei.com>
    scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Haoran Liu <liuhaoran14@163.com>
    Input: ipaq-micro-keys - add error handling for devm_kmemdup

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8250: Enable sync_state

Su Hui <suhui@nfschina.com>
    iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Mike Tipton <quic_mdtipton@quicinc.com>
    interconnect: Treat xlate() returning NULL node as an error

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix ADL+ tiled plane stride when the POT stride is smaller than the original

Clint Taylor <clinton.a.taylor@intel.com>
    drm/i915/mtl: Add MTL for remapping CCS FBs

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/dpt: Only do the POT stride remap when using DPT

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix intel_atomic_setup_scalers() plane_state handling

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Relocate intel_atomic_setup_scalers()

Luca Coelho <luciano.coelho@intel.com>
    drm/i915/mtl: limit second scaler vertical scaling in ver >= 14

Maurizio Lombardi <mlombard@redhat.com>
    nvme-pci: fix sleeping function called from interrupt context

Kent Gibson <warthog618@gmail.com>
    gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Alexis Lothoré <alexis.lothore@bootlin.com>
    pinctrl: at91-pio4: use dedicated lock class for IRQ

Arnd Bergmann <arnd@arndb.de>
    x86/xen: add CPU dependencies for 32-bit build

Quan Nguyen <quan@os.amperecomputing.com>
    i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: hdmi-codec: fix missing report for jack initial status

David Howells <dhowells@redhat.com>
    afs: Fix use-after-free due to get/remove race in volume tree

David Howells <dhowells@redhat.com>
    afs: Fix overwriting of result of DNS query

David Howells <dhowells@redhat.com>
    keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

Eric Dumazet <edumazet@google.com>
    net: check dev->gso_max_size in gso_features_check()

David Howells <dhowells@redhat.com>
    afs: Fix dynamic root lookup DNS check

David Howells <dhowells@redhat.com>
    afs: Fix the dynamic root's d_delete to always delete unused dentries

Liu Jian <liujian56@huawei.com>
    net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Yury Norov <yury.norov@gmail.com>
    net: mana: select PAGE_POOL

Arnd Bergmann <arnd@arndb.de>
    Bluetooth: hci_event: shut up a false-positive warning

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix deadlock in vhci_send_frame

Eric Dumazet <edumazet@google.com>
    net/rose: fix races in rose_kill_by_device()

Zhipeng Lu <alexious@zju.edu.cn>
    ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

Eric Dumazet <edumazet@google.com>
    net: sched: ife: fix potential use-after-free

Shigeru Yoshida <syoshida@redhat.com>
    net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Fix graceful exit during PFC configuration failure

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Correct snprintf truncation handling for fw_version buffer

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Fix fw tracer first block check

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/mlx5e: fix a potential double-free in fs_udp_create_groups

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix a race in command alloc flow

Shay Drory <shayd@nvidia.com>
    net/mlx5: Re-organize mlx5_cmd struct

Tariq Toukan <tariqt@nvidia.com>
    net/mlx5: Prevent high-rate FW commands from populating all slots

Tariq Toukan <tariqt@nvidia.com>
    net/mlx5: Introduce and use opcode getter in command interface

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header"

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header in update funcs"

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh_plink: fix matches_local logic

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh: check element parsing succeeded

Edward Adam Davis <eadavis@qq.com>
    wifi: mac80211: check if the existing link config remains unchanged

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock

Heiko Carstens <hca@linux.ibm.com>
    s390/vx: fix save/restore of fpu kernel context

Geert Uytterhoeven <geert+renesas@glider.be>
    reset: Fix crash when freeing non-existent optional resets

Kunwu Chan <chentao@kylinos.cn>
    ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Andrew Davis <afd@ti.com>
    ARM: dts: dra7: Fix DRA7 L3 NoC node register size

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix hw rotated modes when PSR-SU is enabled

Mario Limonciello <mario.limonciello@amd.com>
    HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    HID: i2c-hid: acpi: Unify ACPI ID tables format

Jiri Olsa <jolsa@kernel.org>
    bpf: Fix prog_array_map_poke_run map poke update

Arnd Bergmann <arnd@arndb.de>
    kasan: disable kasan_non_canonical_hook() for HW tags


-------------

Diffstat:

 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |  10 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/dra7.dtsi                        |   2 +-
 arch/arm/mach-omap2/id.c                           |   5 +
 arch/arm64/kvm/arm.c                               |   2 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |  47 ++--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   2 +-
 arch/arm64/kvm/vgic/vgic.h                         |   1 +
 arch/riscv/include/asm/signal.h                    |   2 +-
 arch/s390/include/asm/fpu/api.h                    |   2 +-
 arch/x86/kernel/alternative.c                      |   2 +-
 arch/x86/net/bpf_jit_comp.c                        |  46 ++++
 arch/x86/xen/Kconfig                               |   1 +
 drivers/block/loop.c                               |  36 ++-
 drivers/block/ublk_drv.c                           |  40 ++--
 drivers/bluetooth/hci_vhci.c                       |  10 +-
 drivers/bus/ti-sysc.c                              |  18 +-
 drivers/gpio/gpio-dwapb.c                          |  12 +-
 drivers/gpio/gpiolib-cdev.c                        |  16 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  12 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   3 +
 drivers/gpu/drm/i915/display/intel_atomic.c        | 193 +---------------
 drivers/gpu/drm/i915/display/intel_atomic.h        |   4 -
 drivers/gpu/drm/i915/display/intel_display.c       |  11 +
 drivers/gpu/drm/i915/display/intel_fb.c            |  10 +-
 drivers/gpu/drm/i915/display/skl_scaler.c          | 257 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/skl_scaler.h          |  10 +-
 drivers/hid/i2c-hid/i2c-hid-acpi.c                 |  15 +-
 drivers/i2c/busses/i2c-aspeed.c                    |  48 ++--
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  10 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   4 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |   3 +
 drivers/input/misc/soc_button_array.c              |   5 +
 drivers/interconnect/core.c                        |   3 +
 drivers/interconnect/qcom/sm8250.c                 |   1 +
 drivers/md/dm-bufio.c                              |   7 +
 drivers/md/dm-integrity.c                          |  11 +-
 drivers/md/dm-thin-metadata.c                      |  58 ++---
 drivers/md/persistent-data/dm-block-manager.c      |   6 +
 drivers/md/persistent-data/dm-block-manager.h      |   1 +
 drivers/md/persistent-data/dm-space-map.h          |   3 +-
 .../md/persistent-data/dm-transaction-manager.c    |   3 +
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   5 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 216 +++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 +--
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   2 +-
 drivers/net/ethernet/micrel/ks8851.h               |   3 +
 drivers/net/ethernet/micrel/ks8851_common.c        |  20 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |  42 ++--
 drivers/net/ethernet/microsoft/Kconfig             |   1 +
 drivers/net/ethernet/mscc/ocelot_stats.c           |   8 +-
 drivers/net/usb/ax88179_178a.c                     |  23 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   4 +-
 drivers/nvme/host/core.c                           |   3 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   8 +
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |   4 +-
 drivers/reset/core.c                               |   8 +-
 drivers/scsi/aacraid/aacraid.h                     |   1 -
 drivers/scsi/aacraid/commsup.c                     |   6 +-
 drivers/scsi/aacraid/linit.c                       |  14 --
 drivers/scsi/aacraid/src.c                         |  25 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   9 +-
 drivers/scsi/scsi_error.c                          |   2 +
 drivers/thunderbolt/debugfs.c                      |   2 +-
 drivers/usb/serial/ftdi_sio.c                      |   6 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +-
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/storage/unusual_devs.h                 |  11 +
 fs/afs/cell.c                                      |   6 +-
 fs/afs/dynroot.c                                   |  31 +--
 fs/afs/internal.h                                  |   2 +
 fs/afs/volume.c                                    |  26 ++-
 fs/btrfs/free-space-cache.c                        |   8 +-
 fs/btrfs/zoned.c                                   |  26 +--
 fs/fuse/fuse_i.h                                   |  15 ++
 fs/fuse/inode.c                                    |  75 +++++-
 fs/smb/client/cifs_debug.c                         |  12 +-
 fs/smb/client/cifsglob.h                           |   3 +-
 fs/smb/client/connect.c                            |   7 +-
 fs/smb/client/misc.c                               |   4 +
 fs/smb/client/smb2ops.c                            |  19 +-
 fs/smb/client/smb2pdu.c                            |  29 ++-
 fs/ubifs/tnc.c                                     |   1 +
 include/linux/bpf.h                                |   3 +
 include/linux/damon.h                              |   3 +
 include/linux/dm-bufio.h                           |   2 +
 include/linux/kasan.h                              |   6 +-
 include/linux/key-type.h                           |   1 +
 include/linux/mlx5/driver.h                        |  20 +-
 include/net/bluetooth/hci_core.h                   |   5 +
 include/trace/events/9p.h                          |  11 +-
 kernel/bpf/arraymap.c                              |  58 +----
 kernel/trace/synth_event_gen_test.c                |  11 +
 lib/vsprintf.c                                     |  11 +-
 mm/damon/core.c                                    |   7 +
 mm/kasan/report.c                                  |   4 +-
 net/8021q/vlan_core.c                              |   9 +-
 net/9p/protocol.c                                  |  17 +-
 net/bluetooth/af_bluetooth.c                       |   7 +-
 net/bluetooth/hci_event.c                          |  22 +-
 net/bluetooth/l2cap_core.c                         |  21 +-
 net/bluetooth/mgmt.c                               |  25 +-
 net/bluetooth/smp.c                                |   7 +
 net/core/dev.c                                     |   3 +
 net/core/stream.c                                  |   2 +-
 net/dns_resolver/dns_key.c                         |  10 +-
 net/ife/ife.c                                      |   1 +
 net/mac80211/cfg.c                                 |   4 +-
 net/mac80211/mesh_plink.c                          |  16 +-
 net/rfkill/rfkill-gpio.c                           |   8 +
 net/rose/af_rose.c                                 |  39 +++-
 net/wireless/certs/wens.hex                        |  87 +++++++
 net/wireless/core.h                                |   1 +
 net/wireless/nl80211.c                             |  56 +++--
 security/keys/gc.c                                 |  31 ++-
 security/keys/internal.h                           |  11 +-
 security/keys/key.c                                |  15 +-
 security/keys/proc.c                               |   2 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/hdmi-codec.c                      |  12 +-
 sound/soc/fsl/fsl_sai.c                            |   3 +
 sound/usb/quirks.c                                 |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   8 +-
 134 files changed, 1494 insertions(+), 777 deletions(-)



