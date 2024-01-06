Return-Path: <linux-kernel+bounces-18538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF8825EED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A0B21707
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508105393;
	Sat,  6 Jan 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCvp1vwG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB79522B;
	Sat,  6 Jan 2024 08:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B47C433C8;
	Sat,  6 Jan 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704530429;
	bh=R13mqU8EaLNP3tE9bzAgyS5koy9i++ys16W2MBIXLhg=;
	h=From:To:Cc:Subject:Date:From;
	b=FCvp1vwGOM29FvaVymlndaAEYcSz4UghV+bt4kFyDTPDKdCXGEgAYY7h4kSOpqNit
	 WzvTglELBVWuRolxNeAsdFBXGVO3WjPCo+jq6Q9r+kjVAmEj4igTMn7yTertBKoRdp
	 f5rCCPgozwUQXn9fkAVZT1no05JnyrlRxSrAK760=
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
Subject: [PATCH 4.14 00/20] 4.14.335-rc2 review
Date: Sat,  6 Jan 2024 09:40:23 +0100
Message-ID: <20240106084013.773696451@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.335-rc2
X-KernelTest-Deadline: 2024-01-08T08:40+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.14.335 release.
There are 20 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 08 Jan 2024 08:40:01 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.335-rc2

Sarthak Kukreti <sarthakkukreti@chromium.org>
    block: Don't invalidate pagecache for invalid falloc modes

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

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

Haoran Liu <liuhaoran14@163.com>
    Input: ipaq-micro-keys - add error handling for devm_kmemdup

Su Hui <suhui@nfschina.com>
    iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Liu Jian <liujian56@huawei.com>
    net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Zhipeng Lu <alexious@zju.edu.cn>
    ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

Eric Dumazet <edumazet@google.com>
    net: sched: ife: fix potential use-after-free

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh_plink: fix matches_local logic

Heiko Carstens <hca@linux.ibm.com>
    s390/vx: fix save/restore of fpu kernel context

Kunwu Chan <chentao@kylinos.cn>
    ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init


-------------

Diffstat:

 Makefile                                        |  4 +-
 arch/arm/mach-omap2/id.c                        |  5 ++
 arch/s390/include/asm/fpu/api.h                 |  2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c  |  4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      |  4 +-
 drivers/input/keyboard/ipaq-micro-keys.c        |  3 +
 drivers/md/dm-integrity.c                       | 11 ++--
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c |  5 +-
 drivers/usb/serial/ftdi_sio.c                   |  6 +-
 drivers/usb/serial/ftdi_sio_ids.h               |  6 +-
 drivers/usb/serial/option.c                     |  5 ++
 fs/block_dev.c                                  |  9 ++-
 net/8021q/vlan_core.c                           |  9 ++-
 net/9p/protocol.c                               | 17 +++--
 net/bluetooth/hci_event.c                       |  3 +-
 net/ife/ife.c                                   |  1 +
 net/mac80211/mesh_plink.c                       | 10 +--
 net/rfkill/rfkill-gpio.c                        |  8 +++
 net/wireless/certs/wens.hex                     | 87 +++++++++++++++++++++++++
 19 files changed, 167 insertions(+), 32 deletions(-)



