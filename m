Return-Path: <linux-kernel+bounces-15790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A718232A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C8D1F24D17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABFA1C291;
	Wed,  3 Jan 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o4NW/ZTe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531A1BDF1;
	Wed,  3 Jan 2024 17:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5C1C433C8;
	Wed,  3 Jan 2024 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301782;
	bh=LRQg88uT0Fh/vm3WQhOXrY4/vD/NT8hpHmZspJQmSyI=;
	h=From:To:Cc:Subject:Date:From;
	b=o4NW/ZTeYHu+aDRoSCuxm2oPROV/QK/WZbHfUzwXt+1K6eMT5vLvelsYlxyO3C3Zt
	 Nr9Kl1mLUySTPgoEsYtdgVmxr4snFCtEhbDNondk80PU7gOAB0f71yh0qGiujhYfpS
	 ts/l+OKyxy3Uf11Ho1GFKvITHpQpJ41Zcs4pgn7g=
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
Subject: [PATCH 5.10 00/75] 5.10.206-rc1 review
Date: Wed,  3 Jan 2024 17:54:41 +0100
Message-ID: <20240103164842.953224409@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.206-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.206-rc1
X-KernelTest-Deadline: 2024-01-05T16:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.206 release.
There are 75 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.206-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.206-rc1

Ville Baillie <villeb@bytesnap.co.uk>
    spi: atmel: Fix PDC transfer setup bug

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: SMP: Fix crash when receiving new connection when debug is enabled

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "MIPS: Loongson64: Enable DMA noncoherent support"

Francis Laniel <flaniel@linux.microsoft.com>
    tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip set commit for deleted/destroyed sets

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix blocked reader of snapshot buffer

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix wake ups when buffer_percent is set to 100

Alexander Atanasov <alexander.atanasov@virtuozzo.com>
    scsi: core: Always send batch on reset or error handling command

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Use a structure member to track the SCSI command submitter

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: core: Make scsi_get_lba() return the LBA

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Introduce scsi_get_sector()

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: core: Add scsi_prot_ref_tag() helper

Dan Sneddon <dan.sneddon@microchip.com>
    spi: atmel: Fix CS and initialization bug

Dan Sneddon <dan.sneddon@microchip.com>
    spi: atmel: Switch to transfer_one transfer method

Hyunwoo Kim <v4bel@theori.io>
    Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smbCalcSize()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in SMB2_query_info_init()

Dan Carpenter <dan.carpenter@linaro.org>
    usb: fotg210-hcd: delete an incorrect bounds test

Xiao Yao <xiaoyao@rock-chips.com>
    Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Archie Pusaka <apusaka@chromium.org>
    Bluetooth: use inclusive language in SMP

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix occasional boot hang for am3 usb

Hangyu Hua <hbh25y@gmail.com>
    9p/net: fix possible memory leak in p9_check_errors()

Thomas Gleixner <tglx@linutronix.de>
    x86/alternatives: Sync core before enabling interrupts

Herve Codina <herve.codina@bootlin.com>
    lib/vsprintf: Fix %pfwf when current node refcount == 0

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Flush posted write only after srst_udelay

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

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

Josef Bacik <josef@toxicpanda.com>
    btrfs: do not allow non subvolume root targets for snapshot

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix NULL deref in asn1_ber_decoder()

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: Add quirk to force pin connectivity on NUC10

Alexis Lothoré <alexis.lothore@bootlin.com>
    pinctrl: at91-pio4: use dedicated lock class for IRQ

Quan Nguyen <quan@os.amperecomputing.com>
    i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

David Howells <dhowells@redhat.com>
    afs: Fix overwriting of result of DNS query

David Howells <dhowells@redhat.com>
    keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

Eric Dumazet <edumazet@google.com>
    net: check dev->gso_max_size in gso_features_check()

Heiner Kallweit <hkallweit1@gmail.com>
    net: warn if gso_type isn't set for a GSO SKB

David Howells <dhowells@redhat.com>
    afs: Fix dynamic root lookup DNS check

David Howells <dhowells@redhat.com>
    afs: Fix the dynamic root's d_delete to always delete unused dentries

Liu Jian <liujian56@huawei.com>
    net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

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

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header"

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh_plink: fix matches_local logic

Heiko Carstens <hca@linux.ibm.com>
    s390/vx: fix save/restore of fpu kernel context

Geert Uytterhoeven <geert+renesas@glider.be>
    reset: Fix crash when freeing non-existent optional resets

Kunwu Chan <chentao@kylinos.cn>
    ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smb2_query_reparse_point()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE


-------------

Diffstat:

 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |  10 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   1 +
 arch/arm/mach-omap2/id.c                           |   5 +
 arch/mips/Kconfig                                  |   2 -
 arch/mips/include/asm/mach-loongson64/boot_param.h |   3 +-
 arch/mips/loongson64/env.c                         |  10 +-
 arch/s390/include/asm/fpu/api.h                    |   2 +-
 arch/x86/kernel/alternative.c                      |   2 +-
 drivers/bus/ti-sysc.c                              |  18 ++-
 drivers/i2c/busses/i2c-aspeed.c                    |  48 ++++--
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   4 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |   3 +
 drivers/input/misc/soc_button_array.c              |   5 +
 drivers/interconnect/core.c                        |   3 +
 drivers/interconnect/qcom/sm8250.c                 |   1 +
 drivers/md/dm-integrity.c                          |  11 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   5 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   2 +-
 drivers/net/ethernet/micrel/ks8851.h               |   3 +
 drivers/net/ethernet/micrel/ks8851_common.c        |  22 +--
 drivers/net/ethernet/micrel/ks8851_spi.c           |  42 ++++--
 drivers/pinctrl/pinctrl-at91-pio4.c                |   8 +
 drivers/reset/core.c                               |   3 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   9 +-
 drivers/scsi/scsi.c                                |   2 +-
 drivers/scsi/scsi_error.c                          |  34 ++---
 drivers/scsi/scsi_lib.c                            |  38 +++--
 drivers/scsi/scsi_logging.c                        |  18 ++-
 drivers/scsi/scsi_priv.h                           |   1 +
 drivers/spi/spi-atmel.c                            | 133 +++++------------
 drivers/usb/host/fotg210-hcd.c                     |   3 -
 drivers/usb/serial/ftdi_sio.c                      |   6 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +-
 drivers/usb/serial/option.c                        |   5 +
 fs/afs/cell.c                                      |   6 +-
 fs/afs/dynroot.c                                   |  31 ++--
 fs/btrfs/ioctl.c                                   |   9 ++
 fs/cifs/misc.c                                     |   4 +
 fs/cifs/smb2misc.c                                 |  26 ++--
 fs/cifs/smb2ops.c                                  |  26 ++--
 fs/cifs/smb2pdu.c                                  |  29 +++-
 fs/cifs/smb2pdu.h                                  |   2 +-
 include/linux/key-type.h                           |   1 +
 include/net/bluetooth/hci_core.h                   |   5 +
 include/net/bluetooth/mgmt.h                       |   2 +-
 include/scsi/scsi_cmnd.h                           |  29 +++-
 include/scsi/scsi_device.h                         |  16 +-
 kernel/trace/ring_buffer.c                         |  12 +-
 kernel/trace/synth_event_gen_test.c                |  11 ++
 kernel/trace/trace.c                               |  20 ++-
 kernel/trace/trace_kprobe.c                        |  74 ++++++++++
 kernel/trace/trace_probe.h                         |   1 +
 lib/vsprintf.c                                     |  11 +-
 net/8021q/vlan_core.c                              |   9 +-
 net/9p/client.c                                    |   7 +-
 net/9p/protocol.c                                  |  17 ++-
 net/bluetooth/af_bluetooth.c                       |   7 +-
 net/bluetooth/hci_event.c                          |   3 +-
 net/bluetooth/l2cap_core.c                         |  21 ++-
 net/bluetooth/mgmt.c                               |  35 +++--
 net/bluetooth/smp.c                                | 161 +++++++++++----------
 net/bluetooth/smp.h                                |   6 +-
 net/core/dev.c                                     |   8 +
 net/dns_resolver/dns_key.c                         |  10 +-
 net/ife/ife.c                                      |   1 +
 net/mac80211/mesh_plink.c                          |  10 +-
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/rfkill/rfkill-gpio.c                           |   8 +
 net/rose/af_rose.c                                 |  41 +++++-
 net/wireless/certs/wens.hex                        |  87 +++++++++++
 security/keys/gc.c                                 |  31 ++--
 security/keys/internal.h                           |  11 +-
 security/keys/key.c                                |  15 +-
 security/keys/proc.c                               |   2 +-
 sound/pci/hda/patch_hdmi.c                         |   2 +
 81 files changed, 857 insertions(+), 446 deletions(-)



