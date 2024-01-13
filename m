Return-Path: <linux-kernel+bounces-25243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32482CB0A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD25B1F23136
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1E17E8;
	Sat, 13 Jan 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLrAGUFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05A15AF;
	Sat, 13 Jan 2024 09:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE089C43390;
	Sat, 13 Jan 2024 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139703;
	bh=lPcX0J5qRVqaYPlTjXVDkneajbzOqa9R2yhv5MfOCXA=;
	h=From:To:Cc:Subject:Date:From;
	b=cLrAGUFo1wk4z9qmbWKmjQMf5OVuXJymXlBEph7KLuspzqZ+uR1OgmwXtP5OfNKK0
	 08ilQ8ZrqEywCoFNNgWTKLjuWXDqffUopUgPhgiRF/uc+IJxmN1Vl34iFUQWZP2K6o
	 8K4bbLiDjONUX0cuStsAiziYrIpBoKRCqt/9grgs=
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
Subject: [PATCH 4.19 00/25] 4.19.305-rc1 review
Date: Sat, 13 Jan 2024 10:49:41 +0100
Message-ID: <20240113094205.025407355@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.305-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.305-rc1
X-KernelTest-Deadline: 2024-01-15T09:42+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.305 release.
There are 25 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.305-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.305-rc1

Jon Maxwell <jmaxwell37@gmail.com>
    ipv6: remove max_size check inline with ipv4

Eric Dumazet <edumazet@google.com>
    ipv6: make ip6_rt_gc_expire an atomic_t

Eric Dumazet <edumazet@google.com>
    net/dst: use a smaller percpu_counter batch for dst entries accounting

Peter Oskolkov <posk@google.com>
    net: add a route cache full diagnostic message

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Disable ATS for specific Intel IPU E2000 devices

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Extract ATS disabling to a helper function

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Reject tables of unsupported family

ruanmeisi <ruan.meisi@zte.com.cn>
    fuse: nlookup missing decrement in fuse_direntplus_link

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz <jorge@foundries.io>
    mmc: rpmb: fixes pause retune on all RPMB partitions.

Jiajun Xie <jiajun.xie.sh@gmail.com>
    mm: fix unmap_mapping_range high bits shift bug

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm/memory-failure: check the mapcount of the precise page

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Chen Ni <nichen@iscas.ac.cn>
    asix: Add check for usbnet_get_endpoints

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net/qla3xxx: switch from 'pci_' to 'dma_' API

Andrii Staikov <andrii.staikov@intel.com>
    i40e: Restore VF MSI-X state during PCI reset

Ke Xiao <xiaoke@sangfor.com.cn>
    i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne <marc.dionne@auristor.com>
    net: Save and restore msg_namelen in sock_sendmsg

Adrian Cinal <adriancinal@gmail.com>
    net: bcmgenet: Fix FCS generation for fragmented skbuffs

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Hangyu Hua <hbh25y@gmail.com>
    net: sched: em_text: fix possible memory leak in em_text_destroy()

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    i40e: Fix filter input checks to prevent config with invalid values

Siddh Raman Pant <code@siddh.me>
    nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 drivers/firewire/ohci.c                            |  51 ++++++
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/core/host.c                            |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 +++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +
 drivers/net/ethernet/qlogic/qla3xxx.c              | 198 +++++++++------------
 drivers/net/usb/ax88172a.c                         |   4 +-
 drivers/pci/quirks.c                               |  28 ++-
 fs/fuse/dir.c                                      |  10 +-
 include/net/dst_ops.h                              |   6 +-
 include/net/netns/ipv6.h                           |   4 +-
 mm/memory-failure.c                                |   6 +-
 mm/memory.c                                        |   4 +-
 net/core/dst.c                                     |   8 +-
 net/ipv6/route.c                                   |  25 +--
 net/netfilter/nf_tables_api.c                      |  27 +++
 net/nfc/llcp_core.c                                |  39 +++-
 net/sched/em_text.c                                |   4 +-
 net/socket.c                                       |   2 +
 24 files changed, 331 insertions(+), 157 deletions(-)



