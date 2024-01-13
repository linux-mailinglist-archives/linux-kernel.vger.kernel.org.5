Return-Path: <linux-kernel+bounces-25244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646882CB16
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60421B21711
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CC63C3;
	Sat, 13 Jan 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uOvvN8w1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4324A33;
	Sat, 13 Jan 2024 09:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A2C433C7;
	Sat, 13 Jan 2024 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139735;
	bh=Wfl1F+s/9o9pthnwPMjwXpLVQGwnTyPuipFm5azoD8I=;
	h=From:To:Cc:Subject:Date:From;
	b=uOvvN8w1jrQeE+4eQHL5UoIbZCLc0urcYZOFqTSu+vxoQbwB1HYAAc0OLgqeAu4Bt
	 mCp9L+zhtPJk0prY4WtBcaTHnuLmbCCNc21MBy0eltxer3IU8av6niPkMqkyXtjY4X
	 vv3XHt1LelYjKa6A71/Cf9PaXXFrliCW9sp0oWV4=
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
Subject: [PATCH 5.4 00/38] 5.4.267-rc1 review
Date: Sat, 13 Jan 2024 10:49:36 +0100
Message-ID: <20240113094206.455533180@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.267-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.267-rc1
X-KernelTest-Deadline: 2024-01-15T09:42+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.267 release.
There are 38 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.267-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.267-rc1

Jon Maxwell <jmaxwell37@gmail.com>
    ipv6: remove max_size check inline with ipv4

Eric Dumazet <edumazet@google.com>
    ipv6: make ip6_rt_gc_expire an atomic_t

Eric Dumazet <edumazet@google.com>
    net/dst: use a smaller percpu_counter batch for dst entries accounting

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Disable ATS for specific Intel IPU E2000 devices

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Extract ATS disabling to a helper function

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Reject tables of unsupported family

John Fastabend <john.fastabend@gmail.com>
    net: tls, update curr on splice as well

Douglas Anderson <dianders@chromium.org>
    ath10k: Get rid of "per_ce_irq" hw param

Douglas Anderson <dianders@chromium.org>
    ath10k: Keep track of which interrupts fired, don't poll them

Rakesh Pillai <pillair@codeaurora.org>
    ath10k: Add interrupt summary based CE processing

Douglas Anderson <dianders@chromium.org>
    ath10k: Wait until copy complete is actually done before completing

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz <jorge@foundries.io>
    mmc: rpmb: fixes pause retune on all RPMB partitions.

Jiajun Xie <jiajun.xie.sh@gmail.com>
    mm: fix unmap_mapping_range high bits shift bug

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Fix atomic xfer check for non-preempt config

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm/memory-failure: check the mapcount of the precise page

Thomas Lange <thomas@corelatus.se>
    net: Implement missing SO_TIMESTAMPING_NEW cmsg support

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

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Validate written enum values

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: meson: g12a: extract codec-to-codec utils

Ke Xiao <xiaoke@sangfor.com.cn>
    i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne <marc.dionne@auristor.com>
    net: Save and restore msg_namelen in sock_sendmsg

Adrian Cinal <adriancinal@gmail.com>
    net: bcmgenet: Fix FCS generation for fragmented skbuffs

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Vadim Fedorenko <vadfed@meta.com>
    net-timestamp: extend SOF_TIMESTAMPING_OPT_ID to HW timestamps

Marc Kleine-Budde <mkl@pengutronix.de>
    can: raw: add support for SO_MARK

Marc Kleine-Budde <mkl@pengutronix.de>
    can: raw: add support for SO_TXTIME/SCM_TXTIME

Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
    net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

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
 drivers/firewire/ohci.c                            |  51 +++++
 drivers/i2c/i2c-core.h                             |   4 +-
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/core/host.c                            |   1 +
 drivers/mmc/host/sdhci-sprd.c                      |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +
 drivers/net/ethernet/qlogic/qla3xxx.c              | 198 ++++++++----------
 drivers/net/usb/ax88172a.c                         |   4 +-
 drivers/net/wireless/ath/ath10k/ce.c               |  79 +++----
 drivers/net/wireless/ath/ath10k/ce.h               |  15 +-
 drivers/net/wireless/ath/ath10k/core.c             |  13 --
 drivers/net/wireless/ath/ath10k/hw.h               |   3 -
 drivers/net/wireless/ath/ath10k/snoc.c             |  19 +-
 drivers/net/wireless/ath/ath10k/snoc.h             |   1 +
 drivers/pci/quirks.c                               |  28 ++-
 include/net/dst_ops.h                              |   6 +-
 include/net/netns/ipv6.h                           |   4 +-
 mm/memory-failure.c                                |   6 +-
 mm/memory.c                                        |   4 +-
 net/can/raw.c                                      |  12 +-
 net/core/dst.c                                     |  12 +-
 net/core/sock.c                                    |  12 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/route.c                                   |  25 +--
 net/netfilter/nf_tables_api.c                      |  27 +++
 net/nfc/llcp_core.c                                |  39 +++-
 net/sched/em_text.c                                |   4 +-
 net/socket.c                                       |   2 +
 net/tls/tls_sw.c                                   |   2 +
 sound/soc/meson/Kconfig                            |   4 +
 sound/soc/meson/Makefile                           |   2 +
 sound/soc/meson/g12a-tohdmitx.c                    | 227 +++++----------------
 sound/soc/meson/meson-codec-glue.c                 | 149 ++++++++++++++
 sound/soc/meson/meson-codec-glue.h                 |  32 +++
 41 files changed, 658 insertions(+), 412 deletions(-)



