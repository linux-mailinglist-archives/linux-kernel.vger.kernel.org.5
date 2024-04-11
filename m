Return-Path: <linux-kernel+bounces-139854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81658A0875
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E4A1F23732
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571E13CABF;
	Thu, 11 Apr 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RtQIIXUu"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3C13CA8D;
	Thu, 11 Apr 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816877; cv=none; b=pV5vUa6JIAVU1PdkA7AV7EVe+KHvaZ8XrnfMUx5zDHwC5pplqzoWttxwivGM63ObgOvGRhU2NV3VtzC/MGiGNL7zd4+ND8jd1cuNq2rw+HUriCJnxkAr6A7zjaqQl3N9DVGXyvllgjgCj92M8YEiildj/TkW0B5z373aFJ+BPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816877; c=relaxed/simple;
	bh=IHcOUE4Axej/hCqIXI9/0QDrj0pg0TyHt/jprAB9MjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UykVwjGucdvCnTzDVWQmB2l74qSZrHhKXQQUz3Rm+zBcVOPkZFvGmfGxBd89xFIKlpxm2qBAsI4YDwH1dkzG74qXtcoF1xeFf9cXgkYqyJd9k1hRGwUGpQRMOefRjKpXwypPYmsuVhocwi5tQASStuPGBGvnOqhylGQxZNbl/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RtQIIXUu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712816869;
	bh=gbBQZKgRmP4ZH2Mt41cGwFyv1vLEZBzE288WtWMMtKA=;
	h=Date:From:To:Cc:Subject:From;
	b=RtQIIXUuI564hzyvjlJ5Xui1/cBlEtc4fBNrMwSdO8HYsemKoUGvRv9wF/Wr7dXUb
	 Ko5pzRFQ+bhTPFZFRZR2xSgkU/LlI14DpfLV2Yox1hKIsqMulUXb4isHdwiuwvVjvi
	 QAx2amNlhGnf33l1FlS3tEjfw1gIV3pFTvfP9/WLyUHvKP4q84JJZbQ/qb1OP8RxHQ
	 bJV2GB5wdqAECNfA+buj5kOW9fPoO99RxGU1qFe4OJPeoQQBS6XrTKjK1ewUjGoosr
	 5PJtTKja9d/We/BhfaGmt2+eGsQvNc//tUGY13gVa3FB1+G1hwFaowwuKTj94oFgRz
	 WXlnaV2kib8BA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFV9x4qYZz4wc5;
	Thu, 11 Apr 2024 16:27:49 +1000 (AEST)
Date: Thu, 11 Apr 2024 16:27:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 11
Message-ID: <20240411162749.718135fa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6dKfV.14XJN=X87hf=Ht=ms";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6dKfV.14XJN=X87hf=Ht=ms
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240410:

The net tree gained a build failure, so I used the version from
next-20240410.

The perf tree still had its build failure, but doing a clean then
rebuilding works.

The risc-v tree gained a conflict against the rust-fixes tree.

The riscv-dt tree gained a conflict against the risc-v tree.

The hid tree gained a build failure so I used the version from
next-20240410.

The net-next tree still had its build failure for which I reverted a commit.

The tip tree lost its build failure.

The tty tree gained a conflict against the tty.current tree and a build
failure, so I used the version from next-20240410.

Non-merge commits (relative to Linus' tree): 4755
 4879 files changed, 186736 insertions(+), 120339 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf. After the final fixups (if any), I do
an x86_64 modules_install followed by builds for x86_64 allnoconfig,
powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
defconfig and htmldocs. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 369 trees (counting Linus' and 103 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (9875c0beb8ad Merge tag 'media/v6.9-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (12ee0bb78565 mm,swapops: update c=
heck in is_pfn_swap_entry for hwpoison entries)
Merging kbuild-current/fixes (89e5462bb5ae kconfig: Fix typo HEIGTH to HEIG=
HT)
Merging arc-current/for-curr (ebfc2fd8873b ARC: Fix typos)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (e3ba51ab24fd arm64: tlb: Fix TLBI RANGE=
 operand)
Merging arm-soc-fixes/arm/fixes (011d79ef1cfa MAINTAINERS: Change Krzysztof=
 Kozlowski's email address)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging sophgo-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (36ba64b4cbc6 selftests/powerpc/papr-vpd: Fix m=
issing variable initialization)
Merging s390-fixes/fixes (378ca2d2ad41 s390/entry: align system call table =
on 8 bytes)
Merging fscrypt-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging fsverity-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging net/main (19fa4f2a85d7 r8169: fix LED-related deadlock on module re=
moval)
$ git reset --hard HEAD^
Merging next-20240410 version of net
Merging bpf/master (6648e613226e bpf, skmsg: Fix NULL pointer dereference i=
n sk_psock_skb_ingress_enqueue)
Merging ipsec/master (bccb798e07f8 octeontx2-pf: Fix transmit scheduler res=
ource leak)
Merging netfilter/main (1bc83a019bbe netfilter: nf_tables: discard table fl=
ag update with pending basechain deletion)
Merging ipvs/main (7eaf837a4eb5 netfilter: nf_tables: Fix a memory leak in =
nf_tables_updchain)
Merging wireless/for-next (9ef369973cd2 wifi: cfg80211: fix the order of ar=
guments for trace events of the tx_rx_evt class)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (b68e1acb5834 RDMA/cm: Print the old state when c=
m_destroy_id gets timeout)
Merging sound-current/for-linus (0b6f0ff01a4a ALSA: hda/tas2781: correct th=
e register for pow calibrated data)
Merging sound-asoc-fixes/for-linus (2e411e939da9 ASoC: cs35l56: Fixes to ha=
ndling of ASP1 config)
Merging regmap-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging regulator-fixes/for-linus (68adb581a39a regulator: vqmmc-ipq4019: f=
ix module autoloading)
Merging spi-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging pci-current/for-linus (302b84e84d10 Revert "PCI: Mark LSI FW643 to =
avoid bus reset")
Merging driver-core.current/driver-core-linus (4cece7649650 Linux 6.9-rc1)
Merging tty.current/tty-linus (9cf7ea2eeb74 serial: core: Clearing the circ=
ular buffer before NULLifying it)
Merging usb.current/usb-linus (eed04fa96c48 usb: dwc2: host: Fix dereferenc=
e issue in DDMA completion flow.)
Merging usb-serial-fixes/usb-linus (d206a76d7d27 Linux 6.8-rc6)
Merging phy/fixes (47b3e2f3914a phy: qcom: m31: match requested regulator n=
ame with dt schema)
Merging staging.current/staging-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging iio-fixes/fixes-togreg (74a72baf204f iio:imu: adis16475: Fix sync m=
ode setting)
Merging counter-current/counter-current (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc.current/char-misc-linus (fec50db7033e Linux 6.9-rc3)
Merging soundwire-fixes/fixes (63dc588e7af1 soundwire: amd: fix for wake in=
terrupt handling for clockstop mode)
Merging thunderbolt-fixes/fixes (dcd12acaf384 thunderbolt: Avoid notify PM =
core about runtime PM resume)
Merging input-current/for-linus (57ed9567e63b Merge branch 'next' into for-=
linus)
Merging crypto-current/master (5a7e89d3315d crypto: iaa - Fix nr_cpus < nr_=
iaa case)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (72d7cb5c190b selftests/harness: Prevent infi=
nite loop due to Assert in FIXTURE_TEARDOWN)
Merging dmaengine-fixes/fixes (f221033f5c24 dmaengine: idxd: Fix oops durin=
g rmmod on single-CPU platforms)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (21c9fb611c25 mtd: diskonchip: work around ubsa=
n link failure)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (d353c3c34af0 media: mediatek: vcodec: support =
36 bits physical address)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (4370b673ccf2 MIPS: scall: Save thread_info.s=
yscall unconditionally on entry)
Merging at91-fixes/at91-fixes (4cece7649650 Linux 6.9-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (9bc60f733839 Merge tag 'kvm-riscv-fixes-6.9-1' of=
 https://github.com/kvm-riscv/linux into HEAD)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (4cece7649650 Linux 6.9-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (7bcf809b1e78 cxl: Add checks to access_coordinate =
calculation to fail missing data)
Merging btrfs-fixes/next-fixes (07475cc36e03 Merge branch 'misc-6.9' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (e71c84816925 platform/x86: lg-laptop: fix =
%s null argument warning)
Merging samsung-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pinctrl-samsung-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging devicetree-fixes/dt/linus (de164a7f1924 nios2: Only use built-in de=
vicetree blob if configured to do so)
Merging dt-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging scsi-fixes/fixes (ca91259b775f scsi: core: Fix handling of SCMD_FAI=
L_IF_RECOVERING)
Merging drm-fixes/drm-fixes (718c4fb221db nouveau: fix devinit paths to onl=
y handle display on GSP.)
Merging drm-intel-fixes/for-linux-next-fixes (dcd8992e47f1 drm/i915/vrr: Di=
sable VRR when using bigjoiner)
Merging mmc-fixes/fixes (ace323f80b9b mmc: sdhci-of-dwcmshc: th1520: Increa=
se tuning loop count to 128)
Merging rtc-fixes/rtc-fixes (4cece7649650 Linux 6.9-rc1)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (30d18df6567b Drivers: hv: vmbus: Don't f=
ree ring buffers that couldn't be re-encrypted)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (a373a36fb6b0 Merge patch the fixes from "riscv:=
 64-bit NOMMU fixes and enhancements")
Merging riscv-dt-fixes/riscv-dt-fixes (0f74c64f0a9f riscv: dts: starfive: R=
emove PMIC interrupt info for Visionfive 2 board)
Merging riscv-soc-fixes/riscv-soc-fixes (c90847bcbfb6 cache: sifive_ccache:=
 Partially convert to a platform driver)
Merging fpga-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging spdx/spdx-linus (4cece7649650 Linux 6.9-rc1)
Merging gpio-brgl-fixes/gpio/for-current (e43c2feb8f32 Merge tag 'intel-gpi=
o-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-=
intel into gpio/for-current)
Merging gpio-intel-fixes/fixes (ace0ebe5c98d gpio: crystalcove: Use -ENOTSU=
PP consistently)
Merging pinctrl-intel-fixes/fixes (5d10a157ebe0 pinctrl: baytrail: Add pinc=
onf group for uart3)
Merging auxdisplay-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging erofs-fixes/fixes (7557d296ad43 MAINTAINERS: erofs: add myself as r=
eviewer)
Merging kunit-fixes/kunit-fixes (cfedfb24c9dd kunit: configs: Enable CONFIG=
_DAMON_DBGFS_DEPRECATED for --alltests)
Merging memblock-fixes/fixes (592447f6cb3c memblock tests: fix undefined re=
ference to `BIT')
Merging nfsd-fixes/nfsd-fixes (10396f4df8b7 nfsd: hold a lighter-weight cli=
ent reference over CB_RECALL_ANY)
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (25e973a0e077 perf annotate: Make sure to c=
all symbol__annotate2() in TUI)
Merging efi-fixes/urgent (decd347c2a75 x86/efistub: Reinstate soft limit fo=
r initrd loading)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (452d8950db3e power: rt9455: hide unused rt9455=
_boost_voltage_values)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (39cd87c4eb2b Linux 6.9-rc2)
Merging rust-fixes/rust-fixes (761a8f0a776b rust: make mutually exclusive w=
ith CFI_CLANG)
Merging v9fs-fixes/fixes/next (7a84602297d3 9p: explicitly deny setlease at=
tempts)
Merging w1-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pmdomain-fixes/fixes (39cd87c4eb2b Linux 6.9-rc2)
Merging overlayfs-fixes/ovl-fixes (77a28aa47687 ovl: relax WARN_ON in ovl_v=
erify_area())
Merging i2c-host-fixes/i2c/i2c-host-fixes (fec50db7033e Linux 6.9-rc3)
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging clk-fixes/clk-fixes (754e5287c7d5 Merge branch 'clk-rpm' into clk-f=
ixes)
Merging drm-misc-fixes/for-linux-next-fixes (4c08f01934ab drm/vmwgfx: Enabl=
e DMA mappings with SEV)
Merging mm-stable/mm-stable (4e2e36129225 Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (39cd87c4eb2b Linux 6.9-rc2)
Merging mm/mm-everything (b8a0eda144c2 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in arch/x86/mm/numa_32.c
Merging kbuild/for-next (bfa8f18691ed Merge tag 'scsi-misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (9c3e9af74326 perf metrics: Remove the "No_gro=
up" metric group)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (a1255ccab8ec swiotlb: do not set total_used t=
o 0 in swiotlb_create_debugfs_files())
Merging asm-generic/master (5394f1e9b687 arch: define CONFIG_PAGE_SIZE_*KB =
on all architectures)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (5616fee8981b Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (fec50db7033e Linux 6.9-rc3)
Merging arm-perf/for-next/perf (8f9f5041c646 perf/arm-cmn: Set PMU device p=
arent)
Merging arm-soc/for-next (011d79ef1cfa MAINTAINERS: Change Krzysztof Kozlow=
ski's email address)
Merging amlogic/for-next (4ee46d40d625 Merge branch 'v6.10/arm64-dt' into f=
or-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (fa8e55345b64 Merge branch 'microchip-dt64' into at9=
1-next)
Merging broadcom/next (ebe9ff485efc Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (e23359d88a81 dt-bindings: memory-controlle=
rs: add Samsung S5Pv210 SoC DMC)
Merging imx-mxs/for-next (6cf256f63478 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (d5eba7ed3ce9 Merge branch 'v6.9-next/dts64' into=
 for-next)
Merging mvebu/for-next (058bfa0ead87 arm64: dts: marvell: cn9130-crb: drop =
unneeded "status")
Merging omap/for-next (2a1e301bf479 Merge branch 'omap-for-v6.10/dt' into f=
or-next)
Merging qcom/for-next (3cd1977804fb Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-for-6.10', 'clk-fixes-for-6.9' and 'drivers-fo=
r-6.10' into for-next)
Merging renesas/next (957eed54b7b6 Merge branch 'renesas-dts-for-v6.10' int=
o renesas-next)
Merging reset/reset/next (6d89df61650d reset: ti-sci: Convert to platform r=
emove callback returning void)
Merging rockchip/for-next (2d98359980ee Merge branch 'v6.10-clk/next' into =
for-next)
Merging samsung-krzk/for-next (b7b2fe24038b Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (26f0f850b2d9 Merge branch 'for-next/scmi/updat=
es', tags 'ffa-fix-6.9' and 'scmi-fixes-6.9' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (89a7056ed4f7 riscv: dts: sophgo: add sdcard suppor=
t for milkv duo)
Merging stm32/stm32-next (b12a916d30dc ARM: dts: stm32: add heartbeat led f=
or stm32mp157c-ed1)
Merging sunxi/sunxi/for-next (c1d7282e4e92 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (60757f1264a2 Merge branch 'tee_ts_for_v6.10' into next)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (592695bed5f8 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-dts-next' and 'ti-keystone-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (7869ec4a5f1b Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (13269dc6c704 clk: imx: imx8mp: Fix SAI_MCLK_SEL d=
efinition)
Merging clk-renesas/renesas-clk (c0516eb4cf04 clk: renesas: r8a779h0: Add t=
imer clocks)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (a07c772fa658 LoongArch: Include linux/siz=
es.h in addrspace.h to prevent build errors)
  a07c772fa658 ("LoongArch: Include linux/sizes.h in addrspace.h to prevent=
 build errors")
Merging m68k/for-next (70d830e337f9 m68k: Calculate THREAD_SIZE from THREAD=
_SIZE_ORDER)
Merging m68knommu/for-next (d677c24fccee m68k: Avoid CONFIG_COLDFIRE switch=
 in uapi header)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (4cece7649650 Linux 6.9-rc1)
Merging openrisc/for-next (7f1e2fc49348 openrisc: Use asm-generic's version=
 of fix_to_virt() & virt_to_fix())
Merging parisc-hd/for-next (e8f897f4afef Linux 6.8)
Merging powerpc/next (8884fc918f6a powerpc: Fix fatal warnings flag for LLV=
M's integrated assembler)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (ba5ea59f768f riscv: Do not save the scratch CSR du=
ring suspend)
  36d37f11f555 ("export.h: remove include/asm-generic/export.h")
CONFLICT (content): Merge conflict in Documentation/rust/arch-support.rst
Merging riscv-dt/riscv-dt-for-next (5db2c4dc413e riscv: dts: add initial ca=
nmv-k230 and k230-evb dts)
CONFLICT (content): Merge conflict in arch/riscv/Makefile
Merging riscv-soc/riscv-soc-for-next (16d9122246cc Merge branch 'riscv-conf=
ig' into riscv-soc-for-next)
Merging s390/for-next (9fb83b5a1bdb Merge branch 'features' into for-next)
Merging sh/for-next (4cece7649650 Linux 6.9-rc1)
Merging sparc/for-next (84b76d05828a lib/fonts: Allow Sparc console 8x16 fo=
nt for sparc64 early boot text console)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (11cca8ccf2c3 tty: xtensa/iss: Use min() to =
fix Coccinelle warning)
Merging bcachefs/for-next (9b31152fd74e bcachefs: btree_node_scan: Respect =
member.data_allowed)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (7218664bf91d Merge branch 'for-next-next-v6.9-20240=
409' into for-next-20240409)
Merging ceph/master (825b82f6b82a ceph: set correct cap mask for getattr re=
quest for read)
Merging cifs/for-next (bedddc9309fa smb: client: Fix hang in smb2_reconnect)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging erofs/dev (b351756059e3 erofs: derive fsid from on-disk UUID for .s=
tatfs() if possible)
Merging exfat/dev (6397cc21e5c0 exfat: move extend valid_size into ->page_m=
kwrite())
Merging exportfs/exportfs-next (e8f897f4afef Linux 6.8)
Merging ext3/for_next (172dc02ca6ec Merge UDF time conversion fix.)
Merging ext4/dev (0ecae5410ab5 ext4: initialize sbi->s_freeclusters_counter=
 and sbi->s_dirtyclusters_counter before use in kunit test)
Merging f2fs/dev (bf3a69c6861f Merge tag 'for-linus-6.9-ofs1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/hubcap/linux)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (cdf6ac2a03d2 fuse: get rid of ff->readdir.lock)
Merging gfs2/for-next (2613499753ca gfs2: Fix lru_count accounting)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (405ac6a57277 Merge tag '6.9-rc2-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (24457f1be29f nfs: Handle error of rpc_proc_register=
() in nfs_net_init().)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (e5ca63b09c65 nfsd: optimise recalculate_deny_mode()=
 for a common case)
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (b8a77b9a5f9c mtd: ubi: fix NVMEM over UBI volumes on 32=
-bit systems)
Merging v9fs/9p-next (2a0505cdd8c8 9p: remove SLAB_MEM_SPREAD flag usage)
Merging v9fs-ericvh/ericvh/for-next (4cece7649650 Linux 6.9-rc1)
Merging xfs/for-next (e23d7e82b707 xfs: allow cross-linking special files w=
ithout project quota)
Merging zonefs/for-next (567e629fd296 zonefs: convert zonefs to use the new=
 mount api)
Merging iomap/iomap-for-next (3ac974796e5d iomap: fix short copy in iomap_w=
rite_iter())
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (d94f52ebf44e Merge branch 'vfs.rw' into vfs.al=
l)
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (a2b4cab9da77 Merge branch 'for-6.10' into for-next)
Merging pci/next (ced360f2a021 Merge branch 'pci/dt-bindings')
Merging pstore/for-next/pstore (80b735d01bbb pstore/blk: replace deprecated=
 strncpy with strscpy)
Merging hid/for-next (d7d4406ddd93 Merge branch 'for-6.10/hid-bpf' into for=
-next)
$ git reset --hard HEAD^
Merging next-20240410 version of hid
Merging i2c/i2c/for-next (5ceeabb0eb2e Merge tag 'i2c-host-fixes-6.9-rc3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/f=
or-current)
Merging i2c-host/i2c/i2c-host (a43939d2d96a i2c: ocores: convert to ioport_=
map() for IORESOURCE_IO)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (db85dba9fee5 hwmon: (aspeed-g6-pwm-tach) =
Convert to platform remove callback returning void)
Merging jc_docs/docs-next (8819b60eed72 docs/zh_CN: Add dev-tools/kmemleak =
Chinese translation)
Merging v4l-dvb/master (b14257abe705 media: rcar-isp: Disallow unbind of de=
vices)
Merging v4l-dvb-next/master (b14257abe705 media: rcar-isp: Disallow unbind =
of devices)
Merging pm/linux-next (9d16ca96a3b1 Merge branch 'pm-sleep' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (4cece7649650 Linux 6.9-rc1)
Merging cpupower/cpupower (4cece7649650 Linux 6.9-rc1)
Merging devfreq/devfreq-next (6f3c0cfe2aa5 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (02e2a4b3638c cpuidle: psci: Update init level to cor=
e_initcall())
Merging opp/opp/linux-next (4cece7649650 Linux 6.9-rc1)
Merging thermal/thermal/linux-next (1828c1c17bb2 thermal/drivers/rcar_gen3:=
 Add support for R-Car V4M)
Merging dlm/next (92d59adfaf71 dlm: do message processing in softirq contex=
t)
Merging rdma/for-next (f10242b3da90 RDMA/mana_ib: Use struct mana_ib_queue =
for RAW QPs)
Merging net-next/main (414e576fb08f Merge branch 'selftests-move-bpf-offloa=
d-test-from-bpf-to-net')
Applying: Revert "tcp: more struct tcp_sock adjustments"
Merging bpf-next/for-next (d0a2ba197bcb selftests/bpf: Add tests for atomic=
s in bpf_arena.)
Merging ipsec-next/master (267e31750ae8 Merge branch 'phy-listing-link_topo=
logy-tracking')
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (75fe062ce2c7 Bluetooth: add experimental BT_POLL_=
ERRQUEUE socket option)
Merging wireless-next/for-next (d26a0a66f929 wifi: brcmfmac: Fix spelling m=
istake "ivalid" -> "invalid")
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (3ef4600f1226 mtd: maps: sa1100-flash: Prefer struct_s=
ize over open coded arithmetic)
Merging nand/nand/next (6819db94e1cd mtd: rawnand: hynix: fixed typo)
Merging spi-nor/spi-nor/next (4cece7649650 Linux 6.9-rc1)
Merging crypto/master (4ad27a8be9db crypto: jitter - Replace http with http=
s)
Merging drm/drm-next (1f913730e7c7 Merge tag 'drm-misc-next-2024-04-05' of =
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next)
Merging drm-exynos/for-linux-next (6633c7d2fd31 drm/exynos: mixer: drop dri=
ver owner initialization)
Merging drm-misc/for-linux-next (fe6660b661c3 drm/nouveau/dp: Don't probe e=
DP ports twice harder)
Merging amdgpu/drm-next (526b184e8883 drm/amdgpu: differentiate external re=
v id for gfx 11.5.0)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/clk_mg=
r/dcn35/dcn35_clk_mgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n351/dcn351_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu_v14_0_0_ppsmc.h
Merging drm-intel/for-linux-next (8f6372a4d690 drm/i915/mtl: Add DP FEC BS =
jitter WA)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_cd=
clk.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ps=
r.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (9dc23cba0927 drm/msm/adreno: Set highest_bank_bit=
 for A619)
Merging drm-msm-lumag/msm-next-lumag (ab556156cafa drm/msm: drop A6xx heade=
r)
Merging drm-xe/drm-xe-next (ac321eb46e85 drm/xe: Add xe_guc_ads.c to uses_g=
enerated_oob)
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_bo.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_device_types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
CONFLICT (content): Merge conflict in include/uapi/drm/xe_drm.h
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (fb3b9c2d217f video: logo: Drop full path of the inp=
ut filename in generated file)
Merging regmap/for-next (8a8317f92770 regmap: kunit: Add some test cases an=
d a few small)
Merging sound/for-next (a9b16d591874 Merge branch 'topic/emu10k1-fix' into =
for-next)
Merging ieee1394/for-next (0d4149e5e9b0 firewire: ohci: use pci_irq_vector(=
) to retrieve allocated interrupt line)
Merging sound-asoc/for-next (6500db441480 Merge remote-tracking branch 'aso=
c/for-6.10' into asoc-next)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (8984e0b56923 Input: adafruit-seesaw - only report butto=
ns that changed state)
Merging block/for-next (ab067438bbfb Merge branch 'for-6.10/io_uring' into =
for-next)
CONFLICT (content): Merge conflict in io_uring/io_uring.c
CONFLICT (content): Merge conflict in io_uring/rw.c
Applying: fix up for "mm: switch mm->get_unmapped_area() to a flag"
Merging device-mapper/for-next (6bd1e0b331dd dm-crypt: export sysfs of all =
workqueues)
Merging libata/for-next (dcf2653ac12f dt-bindings: ata: ahci-da850: Convert=
 to dtschema)
Merging pcmcia/pcmcia-next (ccae53aa8aa2 pcmcia: cs: make pcmcia_socket_cla=
ss constant)
Merging mmc/next (bce42d6108c9 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (e42199bf13d4 mfd: intel-lpss: Switch over to MSI =
interrupts)
CONFLICT (content): Merge conflict in drivers/mfd/intel-lpss-pci.c
Merging backlight/for-backlight-next (946ced827e6c backlight: mp3309c: Fix =
signedness bug in mp3309c_parse_fwnode())
Merging battery/for-next (50f0ff7c8cc4 power: supply: bq27xxx: Move health =
reading out of update loop)
Merging regulator/for-next (15f992fa81eb Merge remote-tracking branch 'regu=
lator/for-6.10' into regulator-next)
Merging security/next (4cece7649650 Linux 6.9-rc1)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (5e2e4d0ea5c2 evm: Rename is_unsupported_f=
s to is_unsupported_hmac_fs)
Merging selinux/next (d6fc1ee0b6c1 Automated merge of 'dev' into 'next')
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (6999f8229e59 keys: Fix overwrite of key expiration on i=
nstantiation)
Merging watchdog/master (6fe5aabf7fc6 watchdog: intel-mid_wdt: Get platform=
 data via dev_get_platdata())
Merging iommu/next (c404f55c26fc iommu: Validate the PASID in iommu_attach_=
device_pasid())
Merging audit/next (4cece7649650 Linux 6.9-rc1)
Merging devicetree/for-next (cc8940a01557 dt-bindings: usb: mtk-xhci: add c=
ompatible for MT7988)
  680ee54f272e ("dt-bindings: PCI: rockchip,rk3399-pcie: add missing maxIte=
ms to ep-gpios")
Merging dt-krzk/for-next (364be3ecd30d Merge branch 'next/dt' into for-next)
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (f0884837d837 Merge remote-tracking branch 'spi/for-6.=
10' into spi-next)
Merging tip/master (a32eb217ad73 Merge branch into tip/master: 'x86/shstk')
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (8e95536e9495 Merge branch ras/edac-misc into fo=
r-next)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (8942ebe9e183 rcutorture: Make rcutorture support srcu=
 double call test)
Merging kvm/next (9bc60f733839 Merge tag 'kvm-riscv-fixes-6.9-1' of https:/=
/github.com/kvm-riscv/linux into HEAD)
Merging kvm-arm/next (29b0075ed61c KVM: selftests: Fix __GUEST_ASSERT() for=
mat warnings in ARM's arch timer test)
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (8e936e98718f RISC-V: KVM: Fix APLIC in_cl=
rip[x] read emulation)
Merging kvm-x86/next (f10f3621ad80 Merge branches 'fixes', 'generic', 'misc=
', 'mmu', 'selftests', 'svm' and 'vmx')
Merging xen-tip/linux-next (d277f9d82802 xen/events: increment refcnt only =
if event channel is refcounted)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (8a8a4bfdbe85 Merge branch 'for-6.10' into for-=
next)
Merging drivers-x86/for-next (88c0ef69dd88 platform/x86: asus-wmi: cleanup =
main struct to avoid some holes)
Merging chrome-platform/for-next (70a5f3005008 platform/chrome: cros_ec_lpc=
: add quirks for the Framework Laptop (AMD))
Merging chrome-platform-firmware/for-firmware-next (7f20f21c22aa firmware: =
google: cbmem: drop driver owner initialization)
Merging hsi/for-next (4cece7649650 Linux 6.9-rc1)
Merging leds-lj/for-leds-next (ca66b10a11da leds: simatic-ipc-leds-gpio: Ad=
d support for module BX-59A)
Merging ipmi/for-next (739bf2135f87 char: ipmi: handle HAS_IOPORT dependenc=
ies)
Merging driver-core/driver-core-next (0bb322be5d38 driver core: Remove unus=
ed platform_notify, platform_notify_remove)
Merging usb/usb-next (1a395af9d53c usb: typec: ucsi_glink: drop special han=
dling for CCI_BUSY)
Merging thunderbolt/next (9a966517a830 thunderbolt: Enable NVM upgrade supp=
ort on Intel Maple Ridge)
Merging usb-serial/usb-next (b1a8da9ff139 USB: serial: cp210x: add pid/vid =
for TDK NC0110013M and MM0110113M)
Merging tty/tty-next (fff4a5d5609d serial: ar933x: Remove unneeded static s=
tructure)
CONFLICT (content): Merge conflict in drivers/tty/serial/serial_core.c
$ git reset --hard HEAD^
Merging next-20240410 version of tty
Merging char-misc/char-misc-next (fec50db7033e Linux 6.9-rc3)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (a4f3057d19ff coresight-tpda: Change qcom,dsb-elemen=
t-size to qcom,dsb-elem-bits)
Merging fastrpc/for-next (4cece7649650 Linux 6.9-rc1)
Merging fpga/for-next (4d2bc3f7dea4 fpga: tests: use KUnit devices instead =
of platform devices)
Merging icc/icc-next (7af14fe58e5e Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (27eea4778db8 iio: adc: ad7944: simplify adi,spi-mode pr=
operty parsing)
Merging phy-next/next (0338e1d2f933 MAINTAINERS: Add phy-gs101-ufs file to =
Tensor GS101.)
Merging soundwire/next (5b3f661b2449 soundwire: intel_ace2x: set the clock =
source)
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (7447d911af69 vfio/fsl-mc: Block calling interrupt handle=
r without trigger)
Merging w1/for-next (cde37a5bdb0e w1: gpio: Don't use "proxy" headers)
Merging spmi/spmi-next (897268aef3fa spmi: pmic-arb: Replace three IS_ERR()=
 calls by null pointer checks in spmi_pmic_arb_probe())
Merging staging/staging-next (18f44de63f88 staging: greybus: change strncpy=
() to strscpy_pad())
Merging counter-next/counter-next (916baadd293a counter: ti-ecap-capture: U=
tilize COUNTER_COMP_FREQUENCY macro)
Merging siox/siox/for-next (db418d5f1ca5 siox: bus-gpio: Simplify using dev=
m_siox_* functions)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (4665be0e952f dmaengine: pch_dma: remove unused func=
tion chan2parent)
Merging cgroup/for-next (a24e3b7d27c6 docs: cgroup-v1: Fix description for =
css_online)
Merging scsi/for-next (2c02be75463d Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (e63350dae44f Merge patch series "Improve the cod=
e for showing commands in debugfs")
Merging vhost/linux-next (5b9f214d0540 vhost: Merge tag 'vduse-virtio-net' =
into vhost)
Merging rpmsg/for-next (4d5aabb68439 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (1685f72a6dcc gpiolib: Do not mention legac=
y GPIOF_* in the code)
Merging gpio-intel/for-next (ace0ebe5c98d gpio: crystalcove: Use -ENOTSUPP =
consistently)
Merging pinctrl/for-next (07bd48cca03b Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (5d10a157ebe0 pinctrl: baytrail: Add pinconf=
 group for uart3)
Merging pinctrl-renesas/renesas-pinctrl (aa43c15a790c pinctrl: renesas: rzg=
2l: Execute atomically the interrupt configuration)
Merging pinctrl-samsung/for-next (4184e4912ca6 dt-bindings: pinctrl: samsun=
g: drop unused header with register constants)
Merging pwm/pwm/for-next (858fbbf538a6 pwm: bcm2835: Drop open coded varian=
t of devm_clk_rate_exclusive_get())
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (f8a3e7c8a5aa tracing/selftests: Default to verbose =
mode when running in kselftest)
Merging kunit/test (4cece7649650 Linux 6.9-rc1)
Merging kunit-next/kunit (82b0beff3497 kunit: Add tests for fault)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (8b59a11fb8e6 rtc: nuvoton: Modify part number value)
Merging nvdimm/libnvdimm-for-next (d9212b35da52 dax: remove SLAB_MEM_SPREAD=
 flag usage)
Merging at24/at24/for-next (4cece7649650 Linux 6.9-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (56af94aace8a samples: user-trap: fix stri=
ct-aliasing warning)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (4cece7649650 Linux 6.9-rc1)
Merging nvmem/for-next (4cece7649650 Linux 6.9-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (f2580a907e5c x86/hyperv: Use Hyper-V entropy to=
 seed guest random number generator)
Merging auxdisplay/for-next (c352a0410726 auxdisplay: seg-led-gpio: Convert=
 to platform remove callback returning void)
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (813e0ae613d6 bus: mhi: host: Add mhi_power_down_keep_=
dev() API to support system suspend/hibernation)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (ed1ff2fba7af Merge branch 'for-6.9/cxl-einj' into for-6.9=
/cxl)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (bf87a149828e efi: Clear up misconceptions about a maximum=
 variable name size)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (5aa5c7b9a09d mm/slub: remove duplicate initiali=
zation for early_kmem_cache_node_alloc())
Merging random/master (4cece7649650 Linux 6.9-rc1)
Merging landlock/next (028243655456 fs/ioctl: Add a comment to keep the log=
ic in sync with LSM policies)
  5b5c05340e67 ("fs: Return ENOTTY if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPA=
TH fail")
Merging rust/rust-next (8db31d3f3bd5 rust: workqueue: add `#[pin_data]` to =
`Work`)
Merging sysctl/sysctl-next (4f1136a55dc8 scripts: check-sysctl-docs: handle=
 per-namespace sysctls)
Merging execve/for-next/execve (5248f4097308 binfmt: replace deprecated str=
ncpy)
Merging bitmap/bitmap-for-next (fd8ed16c2419 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (9c573cd31343 randomize_kstack: Improve entropy =
diffusion)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (4cece7649650 Linux 6.9-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (4cece7649650 Linux 6.9-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/6dKfV.14XJN=X87hf=Ht=ms
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXguUACgkQAVBC80lX
0GywVAf/fzAMeQ7CH+xtL6dUwFOhyCYaz1X9/RWoJwi929nswXvw0H47LlFpOm+y
scSOTd9ugbDUl/ZnJWRPcUujlmxcY//oacGsJ4qsQ45Ik+EhVEt8+rd+9lIzS7KS
woUMyTftKxOFJl5T+yBVywKywMRfrJTsC9rEq56Vlg3QT2C0fxrNm9Ew8951L5dZ
V0IuB384EBDfRqeJSWGwO+yqmQPaqGnhSDd33z7ZMZnVCX4b5J6ppLO6tA650b96
FX5YM8tEz95BIAD2XdflLszCYwuT+FaqsYWSmsnaEx69+9JC4P3DTXJXPmIhg38x
2jg+LD4UORFB2CH/+pwH37ir4Swqdg==
=N5PY
-----END PGP SIGNATURE-----

--Sig_/6dKfV.14XJN=X87hf=Ht=ms--

