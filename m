Return-Path: <linux-kernel+bounces-3778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E38170FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E9283970
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775551D12F;
	Mon, 18 Dec 2023 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMbvX2cy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49C129ED2;
	Mon, 18 Dec 2023 13:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A516C433C8;
	Mon, 18 Dec 2023 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907580;
	bh=HNcdmoRCj9yZjecLR4RJho+3iZE79Q8SjH1iV5TJMlw=;
	h=From:To:Cc:Subject:Date:From;
	b=RMbvX2cyOyTw1CaaNgUjfmTrXzAt7cMaCuiqYPbN5tDc9mExeGGWLdJzHv4pRz6d0
	 fns8s7qY7ozhB+ksjJ6xPLf/FPR4eZI+pGwsde8MOqPOL2Su+OXJf8Zs0m3FHZP5JB
	 zam/q17fqD503LiznavAVZ1Ux+cQxjSbnT5jWf6M=
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
Subject: [PATCH 4.19 00/36] 4.19.303-rc1 review
Date: Mon, 18 Dec 2023 14:51:10 +0100
Message-ID: <20231218135041.876499958@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.303-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.303-rc1
X-KernelTest-Deadline: 2023-12-20T13:50+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.303 release.
There are 36 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.303-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.303-rc1

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Be sure to wait while busy in CQE error recovery

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix memory leak of free page

Florent Revest <revest@chromium.org>
    team: Fix use-after-free when an option instance allocation fails

James Houghton <jthoughton@google.com>
    arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Baokun Li <libaokun1@huawei.com>
    ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Mark Rutland <mark.rutland@arm.com>
    perf: Fix perf_event_validate_size() lockdep splat

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

Oliver Neukum <oneukum@suse.com>
    HID: add ALWAYS_POLL quirk for Apple kb

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: intel_telemetry: Fix kernel doc descriptions

Coly Li <colyli@suse.de>
    bcache: avoid NULL checking to c->root in run_cache_set()

Coly Li <colyli@suse.de>
    bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()

Coly Li <colyli@suse.de>
    bcache: avoid oversize memory allocation by small stripe_size

Ming Lei <ming.lei@redhat.com>
    blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

Jens Axboe <axboe@kernel.dk>
    cred: switch to using atomic_long_t

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Hyunwoo Kim <v4bel@theori.io>
    appletalk: Fix Use-After-Free in atalk_ioctl

Andrew Halaney <ahalaney@redhat.com>
    net: stmmac: Handle disabled MDIO busses from devicetree

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    net: stmmac: use dev_err_probe() for reporting mdio bus registration failure

Eric Dumazet <edumazet@google.com>
    net: prevent mss overflow in skb_segment()

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

 Makefile                                          |  4 +-
 arch/arm64/include/asm/pgtable.h                  |  6 +++
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S    | 17 ++++--
 block/blk-throttle.c                              |  2 +
 drivers/atm/solos-pci.c                           |  8 +--
 drivers/hid/hid-asus.c                            | 25 +++++++--
 drivers/hid/hid-multitouch.c                      |  5 ++
 drivers/hid/hid-quirks.c                          |  1 +
 drivers/md/bcache/bcache.h                        |  1 +
 drivers/md/bcache/btree.c                         |  7 +++
 drivers/md/bcache/super.c                         |  4 +-
 drivers/mmc/core/core.c                           |  2 +
 drivers/mmc/core/mmc_ops.c                        |  5 +-
 drivers/mmc/core/mmc_ops.h                        |  2 +
 drivers/net/ethernet/qlogic/qed/qed_cxt.c         |  1 +
 drivers/net/ethernet/qualcomm/qca_debug.c         | 17 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c           | 20 ++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  6 ++-
 drivers/net/team/team.c                           |  4 +-
 drivers/net/usb/qmi_wwan.c                        |  1 +
 drivers/pci/hotplug/acpiphp_glue.c                |  9 ++--
 drivers/platform/x86/intel_telemetry_core.c       |  4 +-
 fs/ext4/mballoc.c                                 |  4 ++
 include/asm-generic/qspinlock.h                   |  2 +-
 include/linux/cred.h                              |  6 +--
 kernel/cred.c                                     | 66 +++++++++++------------
 kernel/events/core.c                              | 10 ++++
 kernel/trace/ring_buffer.c                        |  2 +
 net/appletalk/ddp.c                               |  9 ++--
 net/atm/ioctl.c                                   |  7 ++-
 net/core/skbuff.c                                 |  3 +-
 net/ipv4/tcp_output.c                             |  6 +++
 net/rose/af_rose.c                                |  4 +-
 net/vmw_vsock/virtio_transport_common.c           |  2 +-
 scripts/sign-file.c                               | 12 ++---
 36 files changed, 197 insertions(+), 89 deletions(-)



