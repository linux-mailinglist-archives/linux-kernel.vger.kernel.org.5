Return-Path: <linux-kernel+bounces-17948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8A825597
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3CC28185A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A942E3FF;
	Fri,  5 Jan 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0CbZkfd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541C2DF87;
	Fri,  5 Jan 2024 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D47C433C9;
	Fri,  5 Jan 2024 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465623;
	bh=GDQF4v54wZnPgM7yvjKM+/Zgu0iQGkcMgCPl0qQ8glk=;
	h=From:To:Cc:Subject:Date:From;
	b=Y0CbZkfd573BnIctxK1xKZNsGndoyaLWpfXpYKXFrJoXV6BKqX7d9/PYm4u3ipQr2
	 xcCb1jAu2ri3WKSUoYu65C5afEOWTr58rqjD7r8SxQoAKQmdqF1+KW6gv0Py2m/vCQ
	 wjWhubpvutggwBVuBL19DZK4w73ysw4a4cxe74rM=
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
Subject: [PATCH 4.19 00/41] 4.19.304-rc1 review
Date: Fri,  5 Jan 2024 15:38:40 +0100
Message-ID: <20240105143813.957669139@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.304-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.304-rc1
X-KernelTest-Deadline: 2024-01-07T14:38+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.304 release.
There are 41 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.304-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.304-rc1

Sarthak Kukreti <sarthakkukreti@chromium.org>
    block: Don't invalidate pagecache for invalid falloc modes

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smbCalcSize()

Dan Carpenter <dan.carpenter@linaro.org>
    usb: fotg210-hcd: delete an incorrect bounds test

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling

Thomas Gleixner <tglx@linutronix.de>
    x86/alternatives: Sync core before enabling interrupts

Rouven Czerwinski <r.czerwinski@pengutronix.de>
    net: rfkill: gpio: set GPIO direction

Fedor Pchelkin <pchelkin@ispras.ru>
    net: 9p: avoid freeing uninit memory in p9pdu_vreadf

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

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Wei Yongjun <weiyongjun1@huawei.com>
    scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

YueHaibing <yuehaibing@huawei.com>
    scsi: bnx2fc: Remove set but not used variable 'oxid'

Haoran Liu <liuhaoran14@163.com>
    Input: ipaq-micro-keys - add error handling for devm_kmemdup

Su Hui <suhui@nfschina.com>
    iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Josef Bacik <josef@toxicpanda.com>
    btrfs: do not allow non subvolume root targets for snapshot

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix NULL deref in asn1_ber_decoder()

Alexis Lothoré <alexis.lothore@bootlin.com>
    pinctrl: at91-pio4: use dedicated lock class for IRQ

Eric Dumazet <edumazet@google.com>
    net: check dev->gso_max_size in gso_features_check()

Heiner Kallweit <hkallweit1@gmail.com>
    net: warn if gso_type isn't set for a GSO SKB

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

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Fix fw tracer first block check

Hu Haowen <xianfengting221@163.com>
    net/mlx5: improve some comments

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh_plink: fix matches_local logic

Heiko Carstens <hca@linux.ibm.com>
    s390/vx: fix save/restore of fpu kernel context

Geert Uytterhoeven <geert+renesas@glider.be>
    reset: Fix crash when freeing non-existent optional resets

Kunwu Chan <chentao@kylinos.cn>
    ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset onLenovo M70/M90

Edward Pacman <edward@edward-p.xyz>
    ALSA: hda/realtek: Add quirk for Lenovo TianYi510Pro-14IOB

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/mach-omap2/id.c                           |  5 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  4 +-
 arch/s390/include/asm/fpu/api.h                    |  2 +-
 arch/x86/kernel/alternative.c                      |  2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |  4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  4 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |  3 +
 drivers/md/dm-integrity.c                          | 11 +--
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  5 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  4 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |  8 ++
 drivers/reset/core.c                               |  3 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  | 12 +--
 drivers/usb/host/fotg210-hcd.c                     |  3 -
 drivers/usb/musb/musb_core.c                       |  3 +-
 drivers/usb/serial/ftdi_sio.c                      |  6 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |  6 +-
 drivers/usb/serial/option.c                        |  5 ++
 fs/afs/dynroot.c                                   | 13 +---
 fs/block_dev.c                                     |  9 ++-
 fs/btrfs/ioctl.c                                   |  9 +++
 fs/cifs/misc.c                                     |  4 +
 fs/cifs/smb2misc.c                                 | 26 +++----
 fs/cifs/smb2pdu.h                                  |  2 +-
 net/8021q/vlan_core.c                              |  9 ++-
 net/9p/protocol.c                                  | 17 ++++-
 net/bluetooth/hci_event.c                          |  3 +-
 net/core/dev.c                                     |  8 ++
 net/ife/ife.c                                      |  1 +
 net/mac80211/mesh_plink.c                          | 10 +--
 net/rfkill/rfkill-gpio.c                           |  8 ++
 net/rose/af_rose.c                                 | 41 ++++++++--
 net/wireless/certs/wens.hex                        | 87 ++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c                      | 30 ++++++++
 35 files changed, 285 insertions(+), 86 deletions(-)



