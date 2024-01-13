Return-Path: <linux-kernel+bounces-25246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C5182CB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CCE28423C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE311C8D;
	Sat, 13 Jan 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ux9HXG6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A4C8DD;
	Sat, 13 Jan 2024 09:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A73C43390;
	Sat, 13 Jan 2024 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139914;
	bh=oruQ3odV3XikhSv+lu4LhQpjyJW3piBdTSBn1DkTGU8=;
	h=From:To:Cc:Subject:Date:From;
	b=ux9HXG6JT3iO3LI7T0db9/M6I0oAXvULKocHaj7Uv7Lfp8ymRGKWyHG9d+tS9M0dy
	 xB+qEVVeM9jKEdkWJAy4tkJUy5J7HtjIerwIoVd1yngmjrNEowf+GE70IOfcv08hh5
	 3f1UizyEOPoaffvIKFbekrGAjisASWykRuwmXKJo=
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
Subject: [PATCH 5.10 00/43] 5.10.208-rc1 review
Date: Sat, 13 Jan 2024 10:49:39 +0100
Message-ID: <20240113094206.930684111@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.208-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.208-rc1
X-KernelTest-Deadline: 2024-01-15T09:42+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.208 release.
There are 43 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.208-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.208-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "nvme: use command_id instead of req->tag in trace_nvme_complete_rq()"

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Disable ATS for specific Intel IPU E2000 devices

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Extract ATS disabling to a helper function

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Reject tables of unsupported family

Wander Lairson Costa <wander@redhat.com>
    drm/qxl: fix UAF on handle creation

Jon Maxwell <jmaxwell37@gmail.com>
    ipv6: remove max_size check inline with ipv4

John Fastabend <john.fastabend@gmail.com>
    net: tls, update curr on splice as well

Aditya Gupta <adityag@linux.ibm.com>
    powerpc: update ppc_save_regs to save current r1 in pt_regs

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz <jorge@foundries.io>
    mmc: rpmb: fixes pause retune on all RPMB partitions.

Ziyang Huang <hzyitc@outlook.com>
    mmc: meson-mx-sdhc: Fix initialization frozen issue

Jiajun Xie <jiajun.xie.sh@gmail.com>
    mm: fix unmap_mapping_range high bits shift bug

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Fix atomic xfer check for non-preempt config

Jinghao Jia <jinghao7@illinois.edu>
    x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

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
    ASoC: meson: g12a-toacodec: Fix event generation

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Validate written enum values

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-toacodec: Validate written enum values

Ke Xiao <xiaoke@sangfor.com.cn>
    i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne <marc.dionne@auristor.com>
    net: Save and restore msg_namelen in sock_sendmsg

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_immediate: drop chain reference counter on error

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add loop check helper function

Adrian Cinal <adriancinal@gmail.com>
    net: bcmgenet: Fix FCS generation for fragmented skbuffs

Zhipeng Lu <alexious@zju.edu.cn>
    sfc: fix a double-free bug in efx_probe_filters

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
    net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Hangyu Hua <hbh25y@gmail.com>
    net: sched: em_text: fix possible memory leak in em_text_destroy()

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    i40e: Fix filter input checks to prevent config with invalid values

Khaled Almahallawy <khaled.almahallawy@intel.com>
    drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix marking couple of structure as __packed

Siddh Raman Pant <code@siddh.me>
    nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Siddhesh Dharme <siddheshdharme18@gmail.com>
    ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Sarthak Kukreti <sarthakkukreti@chromium.org>
    block: Don't invalidate pagecache for invalid falloc modes

Edward Adam Davis <eadavis@qq.com>
    keys, dns: Fix missing size check of V1 server-list header


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 arch/powerpc/kernel/ppc_save_regs.S                |   6 +-
 arch/x86/kernel/kprobes/core.c                     |   3 +-
 drivers/firewire/ohci.c                            |  51 ++++++
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |   2 +-
 drivers/gpu/drm/qxl/qxl_dumb.c                     |   5 +-
 drivers/gpu/drm/qxl/qxl_gem.c                      |  25 ++-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |   6 +-
 drivers/i2c/i2c-core.h                             |   4 +-
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/core/host.c                            |   1 +
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |  26 +--
 drivers/mmc/host/sdhci-sprd.c                      |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 +++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |   4 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              | 198 +++++++++------------
 drivers/net/ethernet/sfc/rx_common.c               |   4 +-
 drivers/net/usb/ax88172a.c                         |   4 +-
 drivers/nvme/host/trace.h                          |   2 +-
 drivers/pci/quirks.c                               |  28 ++-
 fs/block_dev.c                                     |  21 ++-
 include/net/dst_ops.h                              |   2 +-
 mm/memory-failure.c                                |   6 +-
 mm/memory.c                                        |   4 +-
 net/core/dst.c                                     |   8 +-
 net/core/sock.c                                    |  12 +-
 net/dns_resolver/dns_key.c                         |  19 +-
 net/ipv6/route.c                                   |  13 +-
 net/netfilter/nf_tables_api.c                      |  57 +++++-
 net/netfilter/nft_immediate.c                      |   2 +-
 net/nfc/llcp_core.c                                |  39 +++-
 net/sched/em_text.c                                |   4 +-
 net/socket.c                                       |   2 +
 net/tls/tls_sw.c                                   |   2 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/meson/g12a-toacodec.c                    |   5 +-
 sound/soc/meson/g12a-tohdmitx.c                    |   8 +-
 43 files changed, 429 insertions(+), 228 deletions(-)



