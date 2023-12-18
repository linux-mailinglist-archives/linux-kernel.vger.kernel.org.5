Return-Path: <linux-kernel+bounces-3777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570C8170DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0AA1C22B09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D281D150;
	Mon, 18 Dec 2023 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J3DtA0nl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213431D12F;
	Mon, 18 Dec 2023 13:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA44C433C8;
	Mon, 18 Dec 2023 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907495;
	bh=eZKmGMJ7sIrZOFHe3BiyHmtwQb8aCdsQ155Btda4VcU=;
	h=From:To:Cc:Subject:Date:From;
	b=J3DtA0nlwasLFxiVBY8KXWrSQwRb/VXkOf+RjrNe1dwDm0478d4CoW4oxbLvCvkSd
	 H2wEfhKrxOClIKOxiPfy7LsDqgh5kX0MV1vg54cKXHAcF7Jl64Vwgy5/D1vYG5eZKG
	 JxGLGmeBCt3e4x2cVyiqnK7jslpsO9bBWbKCuxAM=
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
Subject: [PATCH 4.14 00/26] 4.14.334-rc1 review
Date: Mon, 18 Dec 2023 14:51:02 +0100
Message-ID: <20231218135040.665690087@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.334-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.334-rc1
X-KernelTest-Deadline: 2023-12-20T13:50+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.14.334 release.
There are 26 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.334-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.334-rc1

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix memory leak of free page

Florent Revest <revest@chromium.org>
    team: Fix use-after-free when an option instance allocation fails

Baokun Li <libaokun1@huawei.com>
    ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: add const to read-only outgoing usb buffer

Lech Perczak <lech.perczak@gmail.com>
    net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Linus Torvalds <torvalds@linux-foundation.org>
    asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Aoba K <nexp_0x17@outlook.com>
    HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: reset the backlight brightness level on resume

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: intel_telemetry: Fix kernel doc descriptions

Coly Li <colyli@suse.de>
    bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()

Ming Lei <ming.lei@redhat.com>
    blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

Jens Axboe <axboe@kernel.dk>
    cred: switch to using atomic_long_t

Hyunwoo Kim <v4bel@theori.io>
    appletalk: Fix Use-After-Free in atalk_ioctl

Nikolay Kuratov <kniv@yandex-team.ru>
    vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Yusong Gao <a869920004@gmail.com>
    sign-file: Fix incorrect return values check

Dong Chenchen <dongchenchen2@huawei.com>
    net: Remove acked SYN flag from packet in the transmit queue correctly

Dinghao Liu <dinghao.liu@zju.edu.cn>
    qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Hyunwoo Kim <v4bel@theori.io>
    net/rose: Fix Use-After-Free in rose_ioctl

Hyunwoo Kim <v4bel@theori.io>
    atm: Fix Use-After-Free in do_vcc_ioctl

Chengfeng Ye <dg573847474@gmail.com>
    atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Chengfeng Ye <dg573847474@gmail.com>
    atm: solos-pci: Fix potential deadlock on &cli_queue_lock

Stefan Wahren <wahrenst@gmx.net>
    qca_spi: Fix reset behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Fix ethtool -G iface tx behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Prevent crash on TX ring changes


-------------

Diffstat:

 Makefile                                       |  4 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  9 +++-
 block/blk-throttle.c                           |  2 +
 drivers/atm/solos-pci.c                        |  8 ++--
 drivers/hid/hid-asus.c                         | 25 ++++++++--
 drivers/hid/hid-multitouch.c                   |  5 ++
 drivers/md/bcache/btree.c                      |  7 +++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c      |  1 +
 drivers/net/ethernet/qualcomm/qca_debug.c      | 17 +++----
 drivers/net/ethernet/qualcomm/qca_spi.c        | 20 +++++++-
 drivers/net/team/team.c                        |  4 +-
 drivers/net/usb/qmi_wwan.c                     |  1 +
 drivers/platform/x86/intel_telemetry_core.c    |  4 +-
 fs/ext4/mballoc.c                              |  4 ++
 include/asm-generic/qspinlock.h                |  2 +-
 include/linux/cred.h                           |  6 +--
 kernel/cred.c                                  | 66 +++++++++++++-------------
 kernel/trace/ring_buffer.c                     |  2 +
 net/appletalk/ddp.c                            |  9 ++--
 net/atm/ioctl.c                                |  7 ++-
 net/ipv4/tcp_output.c                          |  6 +++
 net/rose/af_rose.c                             |  4 +-
 net/vmw_vsock/virtio_transport_common.c        |  2 +-
 scripts/sign-file.c                            | 12 ++---
 24 files changed, 152 insertions(+), 75 deletions(-)



