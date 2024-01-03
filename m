Return-Path: <linux-kernel+bounces-15787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362182323A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692E71C23B03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F71BDF4;
	Wed,  3 Jan 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9XnsWSE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A181C2A6;
	Wed,  3 Jan 2024 17:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FDBC433C7;
	Wed,  3 Jan 2024 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301438;
	bh=iWDm/uqCcFfAVooOCre0dK+73yU/FGPiWXLM0K/uKGo=;
	h=From:To:Cc:Subject:Date:From;
	b=u9XnsWSE9Dlc5sJZmBf7pUdTIOUBCa4E8Pk+eLdStMgqZ/V0BMRO27mdL+vCY8ZtN
	 kAqBxFHyMb6Y5Navy8bzLidPFVoYI6mWr2IrqfynjT55VWBvgen0aP4uqvLIsc4cJP
	 99mQHxxPMDVWeMN5u27AJqajSFEZgnMYmOG5xg+g=
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
Subject: [PATCH 5.15 00/95] 5.15.146-rc1 review
Date: Wed,  3 Jan 2024 17:54:08 +0100
Message-ID: <20240103164853.921194838@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.146-rc1
X-KernelTest-Deadline: 2024-01-05T16:49+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.146 release.
There are 95 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.146-rc1

Jiri Olsa <jolsa@kernel.org>
    bpf: Fix prog_array_map_poke_run map poke update

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    device property: Allow const parameter to dev_fwnode()

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix slowpath of interrupted event

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip set commit for deleted/destroyed sets

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix blocked reader of snapshot buffer

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix wake ups when buffer_percent is set to 100

Baokun Li <libaokun1@huawei.com>
    mm/filemap: avoid buffered read/write race to read inconsistent data

Hyunwoo Kim <v4bel@theori.io>
    Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smbCalcSize()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in SMB2_query_info_init()

Nuno Sa <nuno.sa@analog.com>
    iio: imu: adis16475: add spi_device_id table

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: Introduce spi_get_device_match_data() helper

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    device property: Add const qualifier to device_get_match_data() parameter

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid failed operations when device is disconnected

Justin Chen <justinpopo6@gmail.com>
    net: usb: ax88179_178a: wol optimizations

Justin Chen <justinpopo6@gmail.com>
    net: usb: ax88179_178a: clean up pm calls

Jakub Kicinski <kuba@kernel.org>
    ethernet: constify references to netdev->dev_addr in drivers

Dan Carpenter <dan.carpenter@linaro.org>
    usb: fotg210-hcd: delete an incorrect bounds test

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix occasional boot hang for am3 usb

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong allocation size update in smb2_open()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: lazy v2 lease break on smb2_write()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: send v2 lease break notification for directory

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: downgrade RWH lease caching state to RH for directory

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set v2 lease capability

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set epoch in create context v2 lease

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: have a dependency on cifs ARC4

Krister Johansen <kjlx@templeofstupid.com>
    fuse: share lookup state between submount and its parent

Thomas Gleixner <tglx@linutronix.de>
    x86/alternatives: Sync core before enabling interrupts

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy

Herve Codina <herve.codina@bootlin.com>
    lib/vsprintf: Fix %pfwf when current node refcount == 0

xiongxin <xiongxin@kylinos.cn>
    gpio: dwapb: mask/unmask IRQ when disable/enale it

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Flush posted write only after srst_udelay

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

Alexander Atanasov <alexander.atanasov@virtuozzo.com>
    scsi: core: Always send batch on reset or error handling command

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

Xiao Yao <xiaoyao@rock-chips.com>
    Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Frédéric Danis <frederic.danis@collabora.com>
    Bluetooth: L2CAP: Send reject on command corrupted request

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

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

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smb2_query_reparse_point()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix NULL deref in asn1_ber_decoder()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix intel_atomic_setup_scalers() plane_state handling

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Relocate intel_atomic_setup_scalers()

Luca Coelho <luciano.coelho@intel.com>
    drm/i915/mtl: limit second scaler vertical scaling in ver >= 14

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Kent Gibson <warthog618@gmail.com>
    gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Alexis Lothoré <alexis.lothore@bootlin.com>
    pinctrl: at91-pio4: use dedicated lock class for IRQ

Quan Nguyen <quan@os.amperecomputing.com>
    i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: hdmi-codec: fix missing report for jack initial status

David Howells <dhowells@redhat.com>
    afs: Fix use-after-free due to get/remove race in volume tree

David Howells <dhowells@redhat.com>
    afs: Use refcount_t rather than atomic_t

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

Eric Dumazet <edumazet@google.com>
    net/rose: fix races in rose_kill_by_device()

Zhipeng Lu <alexious@zju.edu.cn>
    ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

Eric Dumazet <edumazet@google.com>
    net: sched: ife: fix potential use-after-free

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Fix fw tracer first block check

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/mlx5e: fix a potential double-free in fs_udp_create_groups

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header"

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header in update funcs"

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh_plink: fix matches_local logic

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


-------------

Diffstat:

 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |  10 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   1 +
 arch/arm/boot/dts/dra7.dtsi                        |   2 +-
 arch/arm/mach-omap2/id.c                           |   5 +
 arch/arm64/kvm/arm.c                               |   2 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |   5 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   2 +-
 arch/arm64/kvm/vgic/vgic.h                         |   1 +
 arch/s390/include/asm/fpu/api.h                    |   2 +-
 arch/x86/kernel/alternative.c                      |   2 +-
 arch/x86/net/bpf_jit_comp.c                        |  46 ++++
 drivers/base/property.c                            |  13 +-
 drivers/bus/ti-sysc.c                              |  18 +-
 drivers/gpio/gpio-dwapb.c                          |  12 +-
 drivers/gpio/gpiolib-cdev.c                        |  16 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        | 193 +---------------
 drivers/gpu/drm/i915/display/intel_atomic.h        |   4 -
 drivers/gpu/drm/i915/display/skl_scaler.c          | 257 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/skl_scaler.h          |  14 +-
 drivers/i2c/busses/i2c-aspeed.c                    |  48 ++--
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  10 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   4 +-
 drivers/iio/imu/adis16475.c                        | 129 +++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   4 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |   3 +
 drivers/input/misc/soc_button_array.c              |   5 +
 drivers/interconnect/core.c                        |   3 +
 drivers/interconnect/qcom/sm8250.c                 |   1 +
 drivers/md/dm-integrity.c                          |  11 +-
 drivers/net/ethernet/actions/owl-emac.c            |   2 +-
 drivers/net/ethernet/adaptec/starfire.c            |  10 +-
 drivers/net/ethernet/alacritech/slicoss.c          |   2 +-
 drivers/net/ethernet/alteon/acenic.c               |   4 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   2 +-
 drivers/net/ethernet/amd/nmclan_cs.c               |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   2 +-
 drivers/net/ethernet/apm/xgene-v2/mac.c            |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c  |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  |   2 +-
 drivers/net/ethernet/apple/bmac.c                  |   8 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |   6 +-
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c |   2 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  |   4 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |   4 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h  |   2 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c        |   4 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c   |   4 +-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   |   2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   5 +-
 drivers/net/ethernet/broadcom/b44.c                |   6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h  |   3 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h    |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/calxeda/xgmac.c               |   2 +-
 drivers/net/ethernet/chelsio/cxgb/gmac.h           |   2 +-
 drivers/net/ethernet/chelsio/cxgb/pm3393.c         |   2 +-
 drivers/net/ethernet/chelsio/cxgb/vsc7326.c        |   2 +-
 drivers/net/ethernet/chelsio/cxgb3/common.h        |   2 +-
 drivers/net/ethernet/chelsio/cxgb3/xgmac.c         |   2 +-
 drivers/net/ethernet/cisco/enic/enic_pp.c          |   2 +-
 drivers/net/ethernet/dlink/dl2k.c                  |   2 +-
 drivers/net/ethernet/dnet.c                        |   6 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h        |   2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 drivers/net/ethernet/ethoc.c                       |   2 +-
 drivers/net/ethernet/fealnx.c                      |   2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   4 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   8 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.h   |   2 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |   8 +-
 drivers/net/ethernet/freescale/fman/fman_memac.h   |   2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |   8 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.h    |   2 +-
 drivers/net/ethernet/freescale/fman/mac.h          |   2 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |   2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |   2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |   5 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   2 +-
 drivers/net/ethernet/i825xx/sun3_82586.c           |   2 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_hw.c          |   2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_hw.h          |   2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   2 +-
 drivers/net/ethernet/marvell/mvneta.c              |   4 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |   6 +-
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |   2 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   2 +-
 drivers/net/ethernet/micrel/ks8842.c               |   2 +-
 drivers/net/ethernet/micrel/ks8851.h               |   3 +
 drivers/net/ethernet/micrel/ks8851_common.c        |  22 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |  42 ++--
 drivers/net/ethernet/micrel/ksz884x.c              |   4 +-
 drivers/net/ethernet/microsoft/Kconfig             |   1 +
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |   3 +-
 drivers/net/ethernet/neterion/s2io.c               |   2 +-
 drivers/net/ethernet/neterion/s2io.h               |   2 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   6 +-
 drivers/net/ethernet/nxp/lpc_eth.c                 |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h      |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h          |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.h           |   4 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |   2 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |   2 +-
 drivers/net/ethernet/rdc/r6040.c                   |  12 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h  |   2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c    |   3 +-
 drivers/net/ethernet/sfc/ef10.c                    |   4 +-
 drivers/net/ethernet/sfc/ef10_sriov.c              |   2 +-
 drivers/net/ethernet/sfc/ef10_sriov.h              |   6 +-
 drivers/net/ethernet/sfc/net_driver.h              |   2 +-
 drivers/net/ethernet/sfc/siena_sriov.c             |   2 +-
 drivers/net/ethernet/sfc/siena_sriov.h             |   2 +-
 drivers/net/ethernet/sis/sis900.c                  |   2 +-
 drivers/net/ethernet/smsc/smsc911x.c               |   2 +-
 drivers/net/ethernet/smsc/smsc9420.c               |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |   4 +-
 drivers/net/ethernet/sun/sunbmac.c                 |   2 +-
 drivers/net/ethernet/sun/sunqe.c                   |   2 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c      |   2 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac.h         |   2 +-
 drivers/net/ethernet/ti/tlan.c                     |   4 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   3 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   7 +-
 drivers/net/ethernet/xircom/xirc2ps_cs.c           |   2 +-
 drivers/net/phy/mscc/mscc_main.c                   |   2 +-
 drivers/net/usb/aqc111.c                           |   2 +-
 drivers/net/usb/ax88179_178a.c                     | 224 +++++++++---------
 drivers/net/usb/catc.c                             |   2 +-
 drivers/net/usb/dm9601.c                           |   3 +-
 drivers/net/usb/mcs7830.c                          |   3 +-
 drivers/net/usb/sr9700.c                           |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   4 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   8 +
 drivers/reset/core.c                               |   8 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   9 +-
 drivers/scsi/scsi_error.c                          |   2 +
 drivers/spi/spi.c                                  |  12 +
 drivers/usb/host/fotg210-hcd.c                     |   3 -
 drivers/usb/serial/ftdi_sio.c                      |   6 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +-
 drivers/usb/serial/option.c                        |   5 +
 fs/Kconfig                                         |   4 +-
 fs/afs/cell.c                                      |  67 +++---
 fs/afs/cmservice.c                                 |   2 +-
 fs/afs/dynroot.c                                   |  31 +--
 fs/afs/internal.h                                  |  18 +-
 fs/afs/proc.c                                      |   6 +-
 fs/afs/rxrpc.c                                     |  26 ++-
 fs/afs/server.c                                    |  40 ++--
 fs/afs/vl_list.c                                   |  19 +-
 fs/afs/volume.c                                    |  47 +++-
 fs/cifs/misc.c                                     |   4 +
 fs/cifs/smb2misc.c                                 |  26 +--
 fs/cifs/smb2ops.c                                  |  26 ++-
 fs/cifs/smb2pdu.c                                  |  29 ++-
 fs/cifs/smb2pdu.h                                  |   2 +-
 fs/fuse/fuse_i.h                                   |  15 ++
 fs/fuse/inode.c                                    |  75 +++++-
 fs/ksmbd/oplock.c                                  | 115 ++++++++-
 fs/ksmbd/oplock.h                                  |   8 +-
 fs/ksmbd/smb2misc.c                                |  15 +-
 fs/ksmbd/smb2ops.c                                 |   9 +-
 fs/ksmbd/smb2pdu.c                                 |  61 ++---
 fs/ksmbd/smb2pdu.h                                 |   1 +
 fs/ksmbd/vfs.c                                     |   3 +
 fs/ksmbd/vfs_cache.c                               |  13 +-
 fs/ksmbd/vfs_cache.h                               |   3 +
 include/linux/bpf.h                                |   3 +
 include/linux/key-type.h                           |   1 +
 include/linux/property.h                           |   9 +-
 include/linux/qed/qed_eth_if.h                     |   2 +-
 include/linux/qed/qed_if.h                         |   2 +-
 include/linux/qed/qed_rdma_if.h                    |   3 +-
 include/linux/spi/spi.h                            |   3 +
 include/net/bluetooth/hci_core.h                   |   5 +
 include/trace/events/afs.h                         |  26 +--
 kernel/bpf/arraymap.c                              |  58 +----
 kernel/trace/ring_buffer.c                         | 136 ++++-------
 kernel/trace/synth_event_gen_test.c                |  11 +
 kernel/trace/trace.c                               |  20 +-
 lib/vsprintf.c                                     |  11 +-
 mm/filemap.c                                       |   9 +
 net/8021q/vlan_core.c                              |   9 +-
 net/9p/protocol.c                                  |  17 +-
 net/bluetooth/af_bluetooth.c                       |   7 +-
 net/bluetooth/hci_event.c                          |   3 +-
 net/bluetooth/l2cap_core.c                         |  21 +-
 net/bluetooth/mgmt.c                               |  25 +-
 net/bluetooth/smp.c                                |   7 +
 net/core/dev.c                                     |   3 +
 net/dns_resolver/dns_key.c                         |  10 +-
 net/ife/ife.c                                      |   1 +
 net/mac80211/mesh_plink.c                          |  10 +-
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/rfkill/rfkill-gpio.c                           |   8 +
 net/rose/af_rose.c                                 |  41 +++-
 net/wireless/certs/wens.hex                        |  87 +++++++
 security/keys/gc.c                                 |  31 ++-
 security/keys/internal.h                           |  11 +-
 security/keys/key.c                                |  15 +-
 security/keys/proc.c                               |   2 +-
 sound/soc/codecs/hdmi-codec.c                      |  12 +-
 sound/usb/quirks.c                                 |   4 +-
 244 files changed, 1807 insertions(+), 1089 deletions(-)



