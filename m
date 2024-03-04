Return-Path: <linux-kernel+bounces-91315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92146870DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4437B2741A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71237868F;
	Mon,  4 Mar 2024 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qMVq0nJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F798F58;
	Mon,  4 Mar 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588227; cv=none; b=qT7+uSJYIgWb+KRXxlz8roBjB3bpL7KtH0ODbkfyiN4VeVHBOweS5BwZx/iAaL9FlRpzuY0vOH89sQwjSgqejvNk0pdvD0XAkUCJwkNiC8t2vtRLMe2DG9sjo6kjUdQ+LDAr/HIa2f6+yVu+Qa8SQyX4AuASIY+BmhDX1V8GVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588227; c=relaxed/simple;
	bh=+jSwnKygB9wjas5IhMone7QWizEQ2VjGWvDkxj8kx4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMXTypS7maM5Dfl7ilY+MRGIggMHhftoJuclaxtKvJ8hbSUgpCgJgr496/wzOUiBHfPPhO+YgOmC5ZWyf4NzTO5HauBXVk2Al4hdDaXL+f1wAJcJ//8okmY2+JzCPcwY3FjaowvnZt2aHUf3Ix+7ASr/RYceN1ZRJBvEYoVnLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qMVq0nJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D605C433F1;
	Mon,  4 Mar 2024 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588227;
	bh=+jSwnKygB9wjas5IhMone7QWizEQ2VjGWvDkxj8kx4o=;
	h=From:To:Cc:Subject:Date:From;
	b=qMVq0nJ52rL8taoBpvN3+wuRNJg5dLRFgPJ2ZDPoXwJYQs2rUHm81teQV85+94hJA
	 MbUt9jHeZgJL8cCuWe+cZYOf6QBnHVU6D3rmuZNYIROYZuw3ZWPc0z5FjZIuL/CvbO
	 4L/GtXZ2Fvz0Pxp2rPVjXwoKJEfoaozR3JnYBE44=
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
Subject: [PATCH 6.6 000/143] 6.6.21-rc1 review
Date: Mon,  4 Mar 2024 21:22:00 +0000
Message-ID: <20240304211549.876981797@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.21-rc1
X-KernelTest-Deadline: 2024-03-06T21:15+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.21 release.
There are 143 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.21-rc1

Danilo Krummrich <dakr@redhat.com>
    drm/nouveau: don't fini scheduler before entity flush

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: rm subflow with v4/v4mapped addr

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: add mptcp_lib_is_v6

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: update userspace pm test helpers

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: add chk_subflows_total helper

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: add evts_get_info helper

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/entry_32: Add VERW just before userspace transition

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/entry_64: Add VERW just before userspace transition

Ming Lei <ming.lei@redhat.com>
    block: define bvec_iter as __packed __aligned(4)

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: fix resource unwinding order in error path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Arturas Moskvinas <arturas.moskvinas@gmail.com>
    gpio: 74x164: Enable output pins after registers are reset

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/rtas: use correct function name for resetting TCE tables

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Ensure safe user copy of completion record

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Remove shadow Event Log head stored in idxd

Alexander Stein <alexander.stein@ew.tq-group.com>
    phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashes

Kory Maincent <kory.maincent@bootlin.com>
    dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup

Kory Maincent <kory.maincent@bootlin.com>
    dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup

Kory Maincent <kory.maincent@bootlin.com>
    dmaengine: dw-edma: Add HDMA remote interrupt configuration

Kory Maincent <kory.maincent@bootlin.com>
    dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix

Kory Maincent <kory.maincent@bootlin.com>
    dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA

Kory Maincent <kory.maincent@bootlin.com>
    dmaengine: dw-edma: Fix the ch_count hdma callback

Dan Carpenter <dan.carpenter@linaro.org>
    ASoC: cs35l56: fix reversed if statement in cs35l56_dspwait_asp1tx_put()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Drop oob_skb ref before purging queue in GC.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix task hung while purging oob_skb in GC.

NeilBrown <neilb@suse.de>
    NFS: Fix data corruption caused by congestion.

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible deadlock in subflow diag

Davide Caratti <dcaratti@redhat.com>
    mptcp: fix double-free on socket dismantle

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix potential wake-up event loss

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix snd_wnd initialization for passive socket

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: join: add ss mptcp support check

Paolo Abeni <pabeni@redhat.com>
    mptcp: push at DSS boundaries

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    mptcp: avoid printing warning once on client side

Geliang Tang <tanggeliang@kylinos.cn>
    mptcp: map v4 address to v6 when destroying subflow

Paolo Bonzini <pbonzini@redhat.com>
    x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Jiri Bohac <jbohac@suse.cz>
    x86/e820: Don't reserve SETUP_RNG_SEED in e820

Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
    mm/debug_vm_pgtable: fix BUG_ON with pud advanced test

Bjorn Andersson <quic_bjorande@quicinc.com>
    pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Tim Schumacher <timschumi@gmx.de>
    efivarfs: Request at most 512 bytes for variable names

Nicolin Chen <nicolinc@nvidia.com>
    iommufd: Fix iopt_access_list_id overwrite bug

Nathan Chancellor <nathan@kernel.org>
    kbuild: Add -Wa,--fatal-warnings to as-instr invocation

Zong Li <zong.li@sifive.com>
    riscv: add CALLER_ADDRx support

Nathan Chancellor <nathan@kernel.org>
    RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: fix PHY init clock stability

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: add timeout for PHY init complete

Ivan Semenov <ivan@semenov.dev>
    mmc: core: Fix eMMC initialization with 1-bit bus connection

Christophe Kerello <christophe.kerello@foss.st.com>
    mmc: mmci: stm32: fix DMA API overlapping mappings warning

Curtis Klein <curtis.klein@hpe.com>
    dmaengine: fsl-qdma: init irq after reg initialization

Joy Zou <joy.zou@nxp.com>
    dmaengine: fsl-edma: correct calculation of 'nbytes' in multi-fifo scenario

Tadeusz Struk <tstruk@gigaio.com>
    dmaengine: ptdma: use consistent DMA masks

Ard Biesheuvel <ardb@kernel.org>
    crypto: arm64/neonbs - fix out-of-bounds access on short input

Peng Ma <peng.ma@nxp.com>
    dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Rob Clark <robdclark@chromium.org>
    soc: qcom: pmic_glink: Fix boot when QRTR=m

Ryan Lin <tsung-hua.lin@amd.com>
    drm/amd/display: Add monitor patch for specific eDP

Matthew Auld <matthew.auld@intel.com>
    drm/buddy: fix range bias

Alex Deucher <alexander.deucher@amd.com>
    Revert "drm/amd/pm: resolve reboot exception for si oland"

Filipe Manana <fdmanana@suse.com>
    btrfs: send: don't issue unnecessary zero writes for trailing hole

David Sterba <dsterba@suse.com>
    btrfs: dev-replace: properly validate device names

Filipe Manana <fdmanana@suse.com>
    btrfs: fix double free of anonymous device after snapshot creation failure

Johannes Berg <johannes.berg@intel.com>
    wifi: nl80211: reject iftype change with mesh ID change

Elad Nachman <enachman@marvell.com>
    mtd: rawnand: marvell: fix layouts

Nhat Pham <nphamcs@gmail.com>
    mm: cachestat: fix folio read-after-free in cache walk

Alexander Ofitserov <oficerovas@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Mickaël Salaün <mic@digikod.net>
    landlock: Fix asymmetric private inodes referring

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

Willian Wang <git@willian.wang>
    ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8

Eniac Zhang <eniac-xw.zhang@hp.com>
    ALSA: hda/realtek: fix mute/micmute LED For HP mt440

Hans Peter <flurry123@gmx.ch>
    ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/realtek: tas2781: enable subwoofer volume control

Takashi Iwai <tiwai@suse.de>
    ALSA: ump: Fix the discard error code from snd_ump_legacy_open()

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix to check cycle continuity

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tomoyo: fix UAF write bug in tomoyo_write_control()

Saravana Kannan <saravanak@google.com>
    of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between ordered extent completion and fiemap

Dimitris Vlachos <dvlachos@ics.forth.gr>
    riscv: Sparse-Memory/vmemmap out-of-bounds fix

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix pte_leaf_size() for NAPOT

Alexandre Ghiti <alexghiti@rivosinc.com>
    Revert "riscv: mm: support Svnapot in huge vmap"

Vadim Shakirov <vadim.shakirov@syntacore.com>
    drivers: perf: ctr_get_width function for legacy is not defined

Vadim Shakirov <vadim.shakirov@syntacore.com>
    drivers: perf: added capabilities for legacy PMU

David Howells <dhowells@redhat.com>
    afs: Fix endless loop in directory parsing

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    fbcon: always restore the old font data in fbcon_do_set_font()

Thierry Reding <treding@nvidia.com>
    drm/tegra: Remove existing framebuffer only if we support display

Conor Dooley <conor@kernel.org>
    RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revision

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Fix for initializing ASP1 mixer registers

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Don't add the same register patch multiple times

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->component

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION

Colin Ian King <colin.i.king@gmail.com>
    ASoC: qcom: Fix uninitialized pointer dmactl

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: qcom: convert not to use asoc_xxx()

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: soc.h: convert asoc_xxx() to snd_soc_xxx()

Takashi Iwai <tiwai@suse.de>
    ALSA: Drop leftover snd-rtctimer stuff from Makefile

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx-i2c: Do not free non existing IRQ

Arnd Bergmann <arnd@arndb.de>
    efi/capsule-loader: fix incorrect allocation size

Sabrina Dubroca <sd@queasysnail.net>
    tls: fix use-after-free on failed backlog decryption

Sabrina Dubroca <sd@queasysnail.net>
    tls: separate no-async decryption request handling from async

Sabrina Dubroca <sd@queasysnail.net>
    tls: fix peeking with sync+async decryption

Sabrina Dubroca <sd@queasysnail.net>
    tls: decrement decrypt_pending if no async completion will be called

Lukasz Majewski <lukma@denx.de>
    net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames

Oleksij Rempel <o.rempel@pengutronix.de>
    igb: extend PTP timestamp adjustments to i211

Lin Ma <linma@zju.edu.cn>
    rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Jakub Kicinski <kuba@kernel.org>
    tools: ynl: fix handling of multiple mcast groups

Florian Westphal <fw@strlen.de>
    netfilter: bridge: confirm multicast packets before passing them up the stack

Ignat Korchagin <ignat@cloudflare.com>
    netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: qca: Fix triggering coredump implementation

Janaki Ramaiah Thota <quic_janathot@quicinc.com>
    Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: qca: Fix wrong event type for patch config command

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix accept_list when attempting to suspend

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid potential use-after-free in hci_error_reset

Jonas Dreßler <verdre@v0yd.nl>
    Bluetooth: hci_sync: Check the correct flag before starting a scan

Jakub Raczynski <j.raczynski@samsung.com>
    stmmac: Clear variable when destroying workqueue

Justin Iurman <justin.iurman@uliege.be>
    uapi: in6: replace temporary label with rfc9486

Oleksij Rempel <o.rempel@pengutronix.de>
    net: lan78xx: fix "softirq work is pending" error

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jakub Kicinski <kuba@kernel.org>
    veth: try harder when allocating queue memory

Oleksij Rempel <o.rempel@pengutronix.de>
    lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Jakub Kicinski <kuba@kernel.org>
    net: veth: clear GRO when clearing XDP even when down

Doug Smythies <dsmythies@telus.net>
    cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

Yunjian Wang <wangyunjian@huawei.com>
    tun: Fix xdp_rxq_info's queue_index when detaching

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dpaa: fman_memac: accept phy-interface-type = "10gbase-r" in the device tree

Jeremy Kerr <jk@codeconstruct.com.au>
    net: mctp: take ownership of skb in mctp_local_output

Florian Westphal <fw@strlen.de>
    net: ip_tunnel: prevent perpetual headroom growth

Florian Westphal <fw@strlen.de>
    netlink: add nla be16/32 types to minlen array

Ryosuke Yasuoka <ryasuoka@redhat.com>
    netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Théo Lebrun <theo.lebrun@bootlin.com>
    spi: cadence-qspi: fix pointer reference in runtime PM hooks

Han Xu <han.xu@nxp.com>
    mtd: spinand: gigadevice: Fix the get ecc status issue

Ming Lei <ming.lei@redhat.com>
    ublk: move ublk_cancel_dev() out of ub->mutex

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong allocation size update in smb2_open()

Linus Walleij <linus.walleij@linaro.org>
    ASoC: cs35l34: Fix GPIO name and drop legacy include

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    ubifs: fix possible dereference after free

Josef Bacik <josef@toxicpanda.com>
    btrfs: fix deadlock with fiemap and extent locking


-------------

Diffstat:

 Documentation/arch/x86/mds.rst                     |  34 +++-
 Makefile                                           |   4 +-
 arch/arm64/crypto/aes-neonbs-glue.c                |  11 ++
 arch/powerpc/include/asm/rtas.h                    |   4 +-
 arch/powerpc/kernel/rtas.c                         |   9 +-
 arch/powerpc/platforms/pseries/iommu.c             | 156 +++++++++++------
 arch/riscv/Kconfig                                 |   1 -
 arch/riscv/include/asm/ftrace.h                    |   5 +
 arch/riscv/include/asm/hugetlb.h                   |   2 +
 arch/riscv/include/asm/pgtable.h                   |   6 +-
 arch/riscv/include/asm/vmalloc.h                   |  61 +------
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpufeature.c                     |  15 ++
 arch/riscv/kernel/return_address.c                 |  48 +++++
 arch/riscv/mm/hugetlbpage.c                        |   2 +
 arch/x86/entry/entry_32.S                          |   3 +
 arch/x86/entry/entry_64.S                          |  11 ++
 arch/x86/entry/entry_64_compat.S                   |   1 +
 arch/x86/include/asm/entry-common.h                |   1 -
 arch/x86/include/asm/nospec-branch.h               |  12 --
 arch/x86/kernel/cpu/bugs.c                         |  15 +-
 arch/x86/kernel/cpu/intel.c                        | 178 ++++++++++---------
 arch/x86/kernel/e820.c                             |   8 +-
 arch/x86/kernel/nmi.c                              |   3 -
 arch/x86/kvm/vmx/run_flags.h                       |   7 +-
 arch/x86/kvm/vmx/vmenter.S                         |   9 +-
 arch/x86/kvm/vmx/vmx.c                             |  20 ++-
 drivers/block/ublk_drv.c                           |  40 +++--
 drivers/bluetooth/btqca.c                          |   2 +-
 drivers/bluetooth/hci_bcm4377.c                    |   3 +-
 drivers/bluetooth/hci_qca.c                        |  22 ++-
 drivers/cpufreq/intel_pstate.c                     |   3 +
 drivers/dma/dw-edma/dw-edma-v0-core.c              |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-core.c              |  39 +++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h              |   2 +-
 drivers/dma/fsl-edma-common.c                      |   2 +-
 drivers/dma/fsl-qdma.c                             |  25 +--
 drivers/dma/idxd/cdev.c                            |   2 +-
 drivers/dma/idxd/debugfs.c                         |   2 +-
 drivers/dma/idxd/idxd.h                            |   1 -
 drivers/dma/idxd/init.c                            |  15 +-
 drivers/dma/idxd/irq.c                             |   3 +-
 drivers/dma/ptdma/ptdma-dmaengine.c                |   2 -
 drivers/firmware/efi/capsule-loader.c              |   2 +-
 drivers/gpio/gpio-74x164.c                         |   4 +-
 drivers/gpio/gpiolib.c                             |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  29 +++
 drivers/gpu/drm/drm_buddy.c                        |  10 ++
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   5 +-
 drivers/gpu/drm/tegra/drm.c                        |  23 ++-
 drivers/iommu/iommufd/io_pagetable.c               |   9 +-
 drivers/mmc/core/mmc.c                             |   2 +
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  24 +++
 drivers/mmc/host/sdhci-xenon-phy.c                 |  48 ++++-
 drivers/mtd/nand/raw/marvell_nand.c                |  13 +-
 drivers/mtd/nand/spi/gigadevice.c                  |   6 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |  18 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   4 +-
 drivers/net/gtp.c                                  |  12 +-
 drivers/net/tun.c                                  |   1 +
 drivers/net/usb/dm9601.c                           |   2 +-
 drivers/net/usb/lan78xx.c                          |   5 +-
 drivers/net/veth.c                                 |  40 ++---
 drivers/of/property.c                              |   2 +-
 drivers/perf/riscv_pmu.c                           |  18 +-
 drivers/perf/riscv_pmu_legacy.c                    |  10 +-
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     |   2 +-
 drivers/pmdomain/qcom/rpmhpd.c                     |   7 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   4 +-
 drivers/soc/qcom/pmic_glink.c                      |  21 +--
 drivers/spi/spi-cadence-quadspi.c                  |   6 +-
 drivers/video/fbdev/core/fbcon.c                   |   8 +-
 fs/afs/dir.c                                       |   4 +-
 fs/btrfs/dev-replace.c                             |  24 ++-
 fs/btrfs/disk-io.c                                 |  22 +--
 fs/btrfs/disk-io.h                                 |   2 +-
 fs/btrfs/extent_io.c                               | 165 ++++++++++++++---
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/btrfs/send.c                                    |  17 +-
 fs/btrfs/transaction.c                             |   2 +-
 fs/efivarfs/vars.c                                 |  17 +-
 fs/nfs/write.c                                     |   4 +-
 fs/smb/server/smb2pdu.c                            |  36 ++--
 fs/ubifs/tnc.c                                     |   1 +
 include/linux/bvec.h                               |   2 +-
 include/linux/netfilter.h                          |   1 +
 include/net/mctp.h                                 |   1 +
 include/sound/soc-card.h                           |   6 +-
 include/sound/soc.h                                |  42 +++--
 include/uapi/linux/in6.h                           |   2 +-
 lib/nlattr.c                                       |   4 +
 mm/debug_vm_pgtable.c                              |   8 +
 mm/filemap.c                                       |  51 +++---
 net/bluetooth/hci_core.c                           |   7 +-
 net/bluetooth/hci_event.c                          |  13 +-
 net/bluetooth/hci_sync.c                           |   7 +-
 net/bluetooth/l2cap_core.c                         |   8 +-
 net/bridge/br_netfilter_hooks.c                    |  96 ++++++++++
 net/bridge/netfilter/nf_conntrack_bridge.c         |  30 ++++
 net/core/rtnetlink.c                               |  11 +-
 net/hsr/hsr_forward.c                              |   2 +-
 net/ipv4/ip_tunnel.c                               |  28 ++-
 net/ipv6/addrconf.c                                |   7 +-
 net/mctp/route.c                                   |  10 +-
 net/mptcp/diag.c                                   |   3 +
 net/mptcp/options.c                                |   2 +-
 net/mptcp/pm_userspace.c                           |  10 ++
 net/mptcp/protocol.c                               |  52 +++++-
 net/mptcp/protocol.h                               |  21 +--
 net/netfilter/nf_conntrack_core.c                  |   1 +
 net/netfilter/nft_compat.c                         |  20 +++
 net/netlink/af_netlink.c                           |   2 +-
 net/tls/tls_sw.c                                   |  40 +++--
 net/unix/garbage.c                                 |  21 +--
 net/wireless/nl80211.c                             |   2 +
 scripts/Kconfig.include                            |   2 +-
 scripts/Makefile.compiler                          |   2 +-
 security/landlock/fs.c                             |   4 +-
 security/tomoyo/common.c                           |   3 +-
 sound/core/Makefile                                |   1 -
 sound/core/ump.c                                   |   4 +-
 sound/firewire/amdtp-stream.c                      |   2 +-
 sound/pci/hda/patch_realtek.c                      |  32 +++-
 sound/soc/codecs/cs35l34.c                         |   4 +-
 sound/soc/codecs/cs35l56-shared.c                  |   8 +-
 sound/soc/codecs/cs35l56.c                         | 195 ++++++++++++++++++---
 sound/soc/codecs/cs35l56.h                         |   1 +
 sound/soc/fsl/fsl_xcvr.c                           |  12 +-
 sound/soc/qcom/apq8016_sbc.c                       |   8 +-
 sound/soc/qcom/apq8096.c                           |   8 +-
 sound/soc/qcom/common.c                            |   6 +-
 sound/soc/qcom/lpass-cdc-dma.c                     |  18 +-
 sound/soc/qcom/lpass-platform.c                    |  50 +++---
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   4 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  10 +-
 sound/soc/qcom/qdsp6/q6routing.c                   |   4 +-
 sound/soc/qcom/sc7180.c                            |  18 +-
 sound/soc/qcom/sc7280.c                            |  26 +--
 sound/soc/qcom/sc8280xp.c                          |   8 +-
 sound/soc/qcom/sdm845.c                            |  36 ++--
 sound/soc/qcom/sdw.c                               |   6 +-
 sound/soc/qcom/sm8250.c                            |  10 +-
 sound/soc/qcom/storm.c                             |   4 +-
 sound/soc/soc-card.c                               |  24 ++-
 sound/soc/soc-utils.c                              |   4 +-
 tools/net/ynl/lib/ynl.c                            |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  16 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 192 ++++++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  15 ++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   8 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  86 +++++----
 153 files changed, 1900 insertions(+), 904 deletions(-)



