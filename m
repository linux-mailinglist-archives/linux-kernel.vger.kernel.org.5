Return-Path: <linux-kernel+bounces-94124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4C873A44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564FF28939D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212F13C9CA;
	Wed,  6 Mar 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKElw2oW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14913C9CC;
	Wed,  6 Mar 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737566; cv=none; b=rO6Ffa3MHbMgQSvAE0C+onCn0H0H4KpRaxtE/xh9kTqd4C5JtFdrVILyax/vxXMCEo/ubGj9r+4rGN7CUXoPz+6HB09vKwSmYTxam5uF36EO8mqwV59z/z/XqUwSvGs2dS1b+XZ7RkB7wuJ47m+pfAk/c3A+F4T1rOwEa28aCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737566; c=relaxed/simple;
	bh=8OE29Ukt6+StVctd+UxjMi7Rs7yFGVfQhWzY/+b5gq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VB7BkjeW1S00To04yxGVPtLfsGyHNT+NGZlVx0zrm0uJlDD58SLmrVHfIGx+FzNJFWm3UgNGzG9779PfkRBn4flMpjbV8u+P+xyEbI2YTiFHppHQNOKrOgmqs9ijrIuA65tFALoqeZUqe3QEZ8NbODcUogY3eHqHH+iiOGEhlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKElw2oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148A8C433C7;
	Wed,  6 Mar 2024 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737566;
	bh=8OE29Ukt6+StVctd+UxjMi7Rs7yFGVfQhWzY/+b5gq8=;
	h=From:To:Cc:Subject:Date:From;
	b=wKElw2oW5SZVO68QIM6N+AbR2g5N6mI/BolcW64CXjjMrG+vyqJMVhGP+DFzlSeBM
	 bLN8D4kYamWW9+wVsokq22VMpmGjrhofd+cmBN5WvTv3E+VOjuQqTnBr0HYdTdzS1M
	 w+eJ6sUc8wnXrH7V0hNgrdrUnaBlvwO5S1INlauE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.9
Date: Wed,  6 Mar 2024 15:05:59 +0000
Message-ID: <2024030600-vineyard-divisible-6a94@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.9 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/x86/mds.rst                            |   38 +-
 Makefile                                                  |    2 
 arch/arm64/crypto/aes-neonbs-glue.c                       |   11 
 arch/powerpc/include/asm/rtas.h                           |    4 
 arch/powerpc/kernel/rtas.c                                |    9 
 arch/powerpc/platforms/pseries/iommu.c                    |  156 +++++++----
 arch/riscv/Kconfig                                        |    1 
 arch/riscv/include/asm/csr.h                              |    2 
 arch/riscv/include/asm/ftrace.h                           |    5 
 arch/riscv/include/asm/hugetlb.h                          |    2 
 arch/riscv/include/asm/pgalloc.h                          |   20 +
 arch/riscv/include/asm/pgtable-64.h                       |    2 
 arch/riscv/include/asm/pgtable.h                          |    6 
 arch/riscv/include/asm/vmalloc.h                          |   61 ----
 arch/riscv/kernel/Makefile                                |    2 
 arch/riscv/kernel/cpufeature.c                            |   17 +
 arch/riscv/kernel/return_address.c                        |   48 +++
 arch/riscv/mm/hugetlbpage.c                               |    2 
 arch/x86/entry/entry_32.S                                 |    3 
 arch/x86/entry/entry_64.S                                 |   11 
 arch/x86/entry/entry_64_compat.S                          |    1 
 arch/x86/include/asm/entry-common.h                       |    1 
 arch/x86/include/asm/nospec-branch.h                      |   12 
 arch/x86/kernel/cpu/bugs.c                                |   15 -
 arch/x86/kernel/cpu/common.c                              |    4 
 arch/x86/kernel/cpu/intel.c                               |  178 ++++++------
 arch/x86/kernel/e820.c                                    |    8 
 arch/x86/kernel/nmi.c                                     |    3 
 arch/x86/kvm/vmx/run_flags.h                              |    7 
 arch/x86/kvm/vmx/vmenter.S                                |    9 
 arch/x86/kvm/vmx/vmx.c                                    |   20 +
 drivers/bluetooth/btqca.c                                 |    2 
 drivers/bluetooth/hci_bcm4377.c                           |    3 
 drivers/bluetooth/hci_qca.c                               |   22 +
 drivers/cpufreq/intel_pstate.c                            |    3 
 drivers/dma/dw-edma/dw-edma-v0-core.c                     |   17 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c                     |   39 +-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h                     |    2 
 drivers/dma/fsl-edma-common.c                             |    2 
 drivers/dma/fsl-qdma.c                                    |   21 -
 drivers/dma/idxd/cdev.c                                   |    2 
 drivers/dma/idxd/debugfs.c                                |    2 
 drivers/dma/idxd/idxd.h                                   |    1 
 drivers/dma/idxd/init.c                                   |   15 -
 drivers/dma/idxd/irq.c                                    |    3 
 drivers/dma/ptdma/ptdma-dmaengine.c                       |    2 
 drivers/firmware/efi/capsule-loader.c                     |    2 
 drivers/gpio/gpio-74x164.c                                |    4 
 drivers/gpio/gpiolib.c                                    |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    6 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c        |    5 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                |   29 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c         |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c           |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c      |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c      |    9 
 drivers/gpu/drm/drm_buddy.c                               |   10 
 drivers/gpu/drm/nouveau/nouveau_drm.c                     |    5 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c            |    4 
 drivers/gpu/drm/tegra/drm.c                               |   23 +
 drivers/gpu/host1x/dev.c                                  |   15 -
 drivers/gpu/host1x/dev.h                                  |    6 
 drivers/iommu/iommufd/io_pagetable.c                      |    9 
 drivers/iommu/iommufd/selftest.c                          |   27 +
 drivers/mfd/twl6030-irq.c                                 |   10 
 drivers/mmc/core/mmc.c                                    |    2 
 drivers/mmc/host/mmci_stm32_sdmmc.c                       |   24 +
 drivers/mmc/host/sdhci-xenon-phy.c                        |   48 ++-
 drivers/mtd/nand/raw/marvell_nand.c                       |   13 
 drivers/mtd/nand/spi/gigadevice.c                         |    6 
 drivers/net/ethernet/freescale/fman/fman_memac.c          |   18 -
 drivers/net/ethernet/intel/ice/ice_dpll.c                 |   91 +++++-
 drivers/net/ethernet/intel/igb/igb_ptp.c                  |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c         |    4 
 drivers/net/gtp.c                                         |   12 
 drivers/net/tun.c                                         |    1 
 drivers/net/usb/dm9601.c                                  |    2 
 drivers/net/usb/lan78xx.c                                 |    5 
 drivers/net/veth.c                                        |   40 +-
 drivers/of/property.c                                     |    2 
 drivers/perf/riscv_pmu.c                                  |   18 -
 drivers/perf/riscv_pmu_legacy.c                           |   10 
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c            |    2 
 drivers/phy/qualcomm/phy-qcom-m31.c                       |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                   |   10 
 drivers/pmdomain/arm/scmi_perf_domain.c                   |    3 
 drivers/pmdomain/qcom/rpmhpd.c                            |    7 
 drivers/power/supply/Kconfig                              |    1 
 drivers/power/supply/bq27xxx_battery_i2c.c                |    4 
 drivers/soc/qcom/pmic_glink.c                             |   21 -
 drivers/spi/spi-cadence-quadspi.c                         |   11 
 drivers/video/fbdev/core/fbcon.c                          |    8 
 fs/afs/dir.c                                              |    4 
 fs/btrfs/dev-replace.c                                    |   24 +
 fs/btrfs/disk-io.c                                        |   22 -
 fs/btrfs/disk-io.h                                        |    2 
 fs/btrfs/extent_io.c                                      |  103 ++++++-
 fs/btrfs/ioctl.c                                          |    2 
 fs/btrfs/send.c                                           |   17 -
 fs/btrfs/transaction.c                                    |    2 
 fs/ceph/mdsmap.c                                          |    7 
 fs/ceph/mdsmap.h                                          |    6 
 fs/efivarfs/vars.c                                        |   17 -
 fs/nfs/write.c                                            |    4 
 include/linux/bvec.h                                      |    2 
 include/linux/netfilter.h                                 |    1 
 include/net/mctp.h                                        |    1 
 include/sound/soc-card.h                                  |    2 
 include/uapi/linux/in6.h                                  |    2 
 kernel/trace/fprobe.c                                     |   14 -
 lib/nlattr.c                                              |    4 
 mm/debug_vm_pgtable.c                                     |    8 
 mm/filemap.c                                              |   51 +--
 mm/migrate.c                                              |    8 
 net/bluetooth/hci_core.c                                  |    7 
 net/bluetooth/hci_event.c                                 |   13 
 net/bluetooth/hci_sync.c                                  |    7 
 net/bluetooth/l2cap_core.c                                |    8 
 net/bridge/br_netfilter_hooks.c                           |   96 ++++++
 net/bridge/netfilter/nf_conntrack_bridge.c                |   30 ++
 net/core/rtnetlink.c                                      |   11 
 net/hsr/hsr_forward.c                                     |    2 
 net/ipv4/ip_tunnel.c                                      |   28 +-
 net/ipv6/addrconf.c                                       |    7 
 net/mctp/route.c                                          |   10 
 net/mptcp/diag.c                                          |    3 
 net/mptcp/options.c                                       |    2 
 net/mptcp/pm_userspace.c                                  |   10 
 net/mptcp/protocol.c                                      |   52 +++
 net/mptcp/protocol.h                                      |   21 -
 net/netfilter/nf_conntrack_core.c                         |    1 
 net/netfilter/nft_compat.c                                |   20 +
 net/netlink/af_netlink.c                                  |    2 
 net/tls/tls_sw.c                                          |   40 ++
 net/unix/garbage.c                                        |   21 -
 net/wireless/nl80211.c                                    |    2 
 scripts/Kconfig.include                                   |    2 
 scripts/Makefile.compiler                                 |    2 
 security/landlock/fs.c                                    |    4 
 security/tomoyo/common.c                                  |    3 
 sound/core/Makefile                                       |    1 
 sound/core/ump.c                                          |    4 
 sound/firewire/amdtp-stream.c                             |    2 
 sound/pci/hda/patch_realtek.c                             |   33 ++
 sound/soc/codecs/cs35l45.c                                |    2 
 sound/soc/codecs/cs35l56-shared.c                         |    8 
 sound/soc/codecs/cs35l56.c                                |  195 ++++++++++++-
 sound/soc/codecs/cs35l56.h                                |    1 
 sound/soc/fsl/fsl_xcvr.c                                  |   12 
 sound/soc/qcom/lpass-cdc-dma.c                            |    2 
 sound/soc/soc-card.c                                      |   24 +
 tools/net/ynl/lib/ynl.c                                   |    1 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh        |   16 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh           |  196 ++++++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh            |   15 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh        |    8 
 tools/testing/selftests/net/mptcp/userspace_pm.sh         |   86 ++----
 158 files changed, 1877 insertions(+), 812 deletions(-)

Alex Deucher (1):
      Revert "drm/amd/pm: resolve reboot exception for si oland"

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Alexander Stein (1):
      phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashes

Alexandre Ghiti (3):
      riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
      Revert "riscv: mm: support Svnapot in huge vmap"
      riscv: Fix pte_leaf_size() for NAPOT

Andy Shevchenko (1):
      gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Aneesh Kumar K.V (IBM) (1):
      mm/debug_vm_pgtable: fix BUG_ON with pud advanced test

Ard Biesheuvel (1):
      crypto: arm64/neonbs - fix out-of-bounds access on short input

Arkadiusz Kubalewski (4):
      ice: fix dpll input pin phase_adjust value updates
      ice: fix dpll and dpll_pin data access on PF reset
      ice: fix dpll periodic work data updates on PF reset
      ice: fix pin phase adjust updates on PF reset

Arnd Bergmann (1):
      efi/capsule-loader: fix incorrect allocation size

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Bartosz Golaszewski (1):
      gpio: fix resource unwinding order in error path

Bjorn Andersson (1):
      pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Byungchul Park (1):
      mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index

Christophe Kerello (1):
      mmc: mmci: stm32: fix DMA API overlapping mappings warning

Colin Ian King (1):
      ASoC: qcom: Fix uninitialized pointer dmactl

Conor Dooley (1):
      RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs

Cristian Marussi (1):
      pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal

Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

Dan Carpenter (1):
      ASoC: cs35l56: fix reversed if statement in cs35l56_dspwait_asp1tx_put()

Danilo Krummrich (1):
      drm/nouveau: don't fini scheduler before entity flush

David Howells (1):
      afs: Fix endless loop in directory parsing

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Dimitris Vlachos (1):
      riscv: Sparse-Memory/vmemmap out-of-bounds fix

Dmitry Baryshkov (1):
      phy: qcom-qmp-usb: fix v3 offsets data

Doug Smythies (1):
      cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

Elad Nachman (3):
      mtd: rawnand: marvell: fix layouts
      mmc: sdhci-xenon: add timeout for PHY init complete
      mmc: sdhci-xenon: fix PHY init clock stability

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt440

Eric Dumazet (1):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Fenghua Yu (2):
      dmaengine: idxd: Remove shadow Event Log head stored in idxd
      dmaengine: idxd: Ensure safe user copy of completion record

Filipe Manana (3):
      btrfs: fix race between ordered extent completion and fiemap
      btrfs: fix double free of anonymous device after snapshot creation failure
      btrfs: send: don't issue unnecessary zero writes for trailing hole

Florian Westphal (3):
      netlink: add nla be16/32 types to minlen array
      net: ip_tunnel: prevent perpetual headroom growth
      netfilter: bridge: confirm multicast packets before passing them up the stack

Gaurav Batra (1):
      powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV

Geliang Tang (7):
      mptcp: map v4 address to v6 when destroying subflow
      selftests: mptcp: join: add ss mptcp support check
      selftests: mptcp: add evts_get_info helper
      selftests: mptcp: add chk_subflows_total helper
      selftests: mptcp: update userspace pm test helpers
      selftests: mptcp: add mptcp_lib_is_v6
      selftests: mptcp: rm subflow with v4/v4mapped addr

Gergo Koteles (1):
      ALSA: hda/realtek: tas2781: enable subwoofer volume control

Greg Kroah-Hartman (1):
      Linux 6.7.9

Han Xu (1):
      mtd: spinand: gigadevice: Fix the get ecc status issue

Hans Peter (1):
      ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)

Hans de Goede (1):
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Ignat Korchagin (1):
      netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

Jakub Kicinski (3):
      net: veth: clear GRO when clearing XDP even when down
      veth: try harder when allocating queue memory
      tools: ynl: fix handling of multiple mcast groups

Jakub Raczynski (1):
      stmmac: Clear variable when destroying workqueue

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jay Ajit Mate (1):
      ALSA: hda/realtek: Fix top speaker connection on Dell Inspiron 16 Plus 7630

Jeremy Kerr (1):
      net: mctp: take ownership of skb in mctp_local_output

Jiri Bohac (1):
      x86/e820: Don't reserve SETUP_RNG_SEED in e820

Jiri Slaby (SUSE) (1):
      fbcon: always restore the old font data in fbcon_do_set_font()

Jisheng Zhang (1):
      riscv: tlb: fix __p*d_free_tlb()

Johan Hovold (1):
      Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Jonas Dreßler (1):
      Bluetooth: hci_sync: Check the correct flag before starting a scan

Joy Zou (1):
      dmaengine: fsl-edma: correct calculation of 'nbytes' in multi-fifo scenario

Justin Iurman (1):
      uapi: in6: replace temporary label with rfc9486

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Kory Maincent (6):
      dmaengine: dw-edma: Fix the ch_count hdma callback
      dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
      dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
      dmaengine: dw-edma: Add HDMA remote interrupt configuration
      dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
      dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup

Kuniyuki Iwashima (2):
      af_unix: Fix task hung while purging oob_skb in GC.
      af_unix: Drop oob_skb ref before purging queue in GC.

Lin Ma (1):
      rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix accept_list when attempting to suspend
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Lukasz Majewski (1):
      net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames

Ma Jun (1):
      drm/amdgpu/pm: Fix the power1_min_cap value

Masami Hiramatsu (Google) (1):
      fprobe: Fix to allocate entry_data_size buffer with rethook instances

Matthew Auld (1):
      drm/buddy: fix range bias

Matthieu Baerts (NGI0) (1):
      mptcp: avoid printing warning once on client side

Mickaël Salaün (1):
      landlock: Fix asymmetric private inodes referring

Mikko Perttunen (1):
      gpu: host1x: Skip reset assert on Tegra186

Ming Lei (1):
      block: define bvec_iter as __packed __aligned(4)

Nathan Chancellor (2):
      RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH
      kbuild: Add -Wa,--fatal-warnings to as-instr invocation

Nathan Lynch (1):
      powerpc/rtas: use correct function name for resetting TCE tables

NeilBrown (1):
      NFS: Fix data corruption caused by congestion.

Nhat Pham (1):
      mm: cachestat: fix folio read-after-free in cache walk

Nicolin Chen (2):
      iommufd: Fix iopt_access_list_id overwrite bug
      iommufd: Fix protection fault in iommufd_test_syz_conv_iova

Oleksij Rempel (3):
      lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected
      net: lan78xx: fix "softirq work is pending" error
      igb: extend PTP timestamp adjustments to i211

Paolo Abeni (4):
      mptcp: push at DSS boundaries
      mptcp: fix snd_wnd initialization for passive socket
      mptcp: fix potential wake-up event loss
      mptcp: fix possible deadlock in subflow diag

Paolo Bonzini (2):
      x86/cpu: Allow reducing x86_phys_bits during early_identify_cpu()
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Pawan Gupta (5):
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Peter Ujfalusi (1):
      mfd: twl6030-irq: Revert to use of_match_device()

Richard Fitzgerald (8):
      ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET
      ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->component
      ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
      ASoC: cs35l56: Don't add the same register patch multiple times
      ASoC: cs35l56: Fix for initializing ASP1 mixer registers
      ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revision
      ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization
      ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()

Rob Clark (1):
      soc: qcom: pmic_glink: Fix boot when QRTR=m

Ryan Lin (1):
      drm/amd/display: Add monitor patch for specific eDP

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Sabrina Dubroca (4):
      tls: decrement decrypt_pending if no async completion will be called
      tls: fix peeking with sync+async decryption
      tls: separate no-async decryption request handling from async
      tls: fix use-after-free on failed backlog decryption

Samuel Holland (1):
      riscv: Fix enabling cbo.zero when running in M-mode

Saravana Kannan (1):
      of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing

Sid Pranjale (1):
      drm/nouveau: keep DMA buffers required for suspend/resume

Srinivasan Shanmugam (1):
      drm/amd/display: Prevent potential buffer overflow in map_hw_resources

Tadeusz Struk (1):
      dmaengine: ptdma: use consistent DMA masks

Takashi Iwai (2):
      ALSA: Drop leftover snd-rtctimer stuff from Makefile
      ALSA: ump: Fix the discard error code from snd_ump_legacy_open()

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix to check cycle continuity

Tetsuo Handa (1):
      tomoyo: fix UAF write bug in tomoyo_write_control()

Thierry Reding (1):
      drm/tegra: Remove existing framebuffer only if we support display

Thomas Weißschuh (1):
      power: supply: mm8013: select REGMAP_I2C

Théo Lebrun (2):
      spi: cadence-qspi: fix pointer reference in runtime PM hooks
      spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

Vadim Shakirov (2):
      drivers: perf: added capabilities for legacy PMU
      drivers: perf: ctr_get_width function for legacy is not defined

Vladimir Oltean (1):
      net: dpaa: fman_memac: accept phy-interface-type = "10gbase-r" in the device tree

Willian Wang (1):
      ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8

Xiubo Li (1):
      ceph: switch to corrected encoding of max_xattr_size in mdsmap

Yang Yingliang (1):
      phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR()

Yangyu Chen (1):
      riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yochai Hagvi (1):
      ice: fix connection state of DPLL and out pin

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching

Zijun Hu (3):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
      Bluetooth: qca: Fix wrong event type for patch config command
      Bluetooth: qca: Fix triggering coredump implementation

Zong Li (1):
      riscv: add CALLER_ADDRx support


