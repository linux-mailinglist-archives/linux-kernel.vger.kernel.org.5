Return-Path: <linux-kernel+bounces-130844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD836897DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27791C21A56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34B1CD06;
	Thu,  4 Apr 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mr3y+SLL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C81C6B8;
	Thu,  4 Apr 2024 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198682; cv=none; b=ssNXpH45BCeJlixcdVCEvXxx9qKnNSfCsL510Pj4/tmbZzaV2ugKo4pWR9fTQVLtr7tKmYBBPc2QgbaS7YuYkLxCWlzqJK6Xwn+NhTBNk6ZXhEOWmrZ0/pr5s1f7ZQJLfXwkhBUQCKBgxG9xgpYeCr2HalTDodlqXDpH5tovkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198682; c=relaxed/simple;
	bh=3ndvD+lKNqgmdV/04CxuO0Eu1vxZVFdIfttDfimKhuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=llDM8wbO5rBr4h9ROYlL+rMXYuwl3Ez9hZsqVOd0WV4fKh+rw+eCMyYWGz8OqFcbdragc9b9rAoO6zJZMRCNinB8usE601FML3zPrVP1UBezpthtLe1Hcz2QEKtgMvsN1nHqITHNR5tJD9fyPVqPjLftAxsySZx0+vDJwe9VGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mr3y+SLL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712198676;
	bh=4lutsQ826G2W9ANvKXcQ+/tWQriG4XRTfWoaRCghad0=;
	h=Date:From:To:Cc:Subject:From;
	b=mr3y+SLL7WadRx/Udp9W/Toqk/ADyLe3iud8WN18lusWkUTuVw5ghLwgn2boeofjh
	 xrbgwanUK5kbZFmEdV013Z6lnhSFC3OeJiPuu9dMZL9bwwU4QNAvCdd6qdTQywWhYc
	 QtySjTPw3GaZ8IWrNo6c5J0lFQjPUiNGBmCt0zmRYdcwcYMxTIVhJmZ0yTn5Q9SuLL
	 FyokTvw7eY5LlANny7WzsWA56mF07YARhz+9NYHkrr7x/G+lwwzIShSSTWE2km9+gK
	 Q3C64QICPNU4UbukzH+ok+oOs6tsEFm7S+AzQlqbLBKBXVp87D2wJiSCanjdAIh1Bp
	 QbcucAnYMlGWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V95Yc1TgBz4wck;
	Thu,  4 Apr 2024 13:44:36 +1100 (AEDT)
Date: Thu, 4 Apr 2024 13:44:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 4
Message-ID: <20240404134435.2a842dc7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OSpbANkuRWzA9pbiRUwTAhs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/OSpbANkuRWzA9pbiRUwTAhs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240403:

The perf tree still had its build failure, but doing a clean then
rebuilding works.

The vfs-brauner tree gained a build failure for which I applied a patch.

The drm-misc tree lost its build failure.

The dt-krzk tree gained a conflict against the aspeed tree.

Non-merge commits (relative to Linus' tree): 3301
 3644 files changed, 129521 insertions(+), 62758 deletions(-)

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
Merging origin/master (c85af715cac0 Merge tag 'vboxsf-v6.9-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/hansg/linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (f5ea04e4e7d4 selftests/mm: includ=
e strings.h for ffsl)
Merging kbuild-current/fixes (89e5462bb5ae kconfig: Fix typo HEIGTH to HEIG=
HT)
Merging arc-current/for-curr (ebfc2fd8873b ARC: Fix typos)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (b017a0cea627 arm64/ptrace: Use saved fl=
oating point state type to determine SVE layout)
Merging arm-soc-fixes/arm/fixes (1c7cfb6158f6 Merge tag 'riscv-firmware-for=
-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into =
arm/fixes)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging sophgo-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (380cb2f4df78 selftests/powerpc: Fix fpu_signal=
 failures)
Merging s390-fixes/fixes (378ca2d2ad41 s390/entry: align system call table =
on 8 bytes)
Merging fscrypt-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging fsverity-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging net/main (0a6380cb4c6b net: bcmgenet: Reset RBUF on first open)
Merging bpf/master (ff9105993240 bpf, sockmap: Prevent lock inversion deadl=
ock in map delete elem)
Merging ipsec/master (5f563c31ff0c net: dsa: mt7530: fix improper frames on=
 all 25MHz and 40MHz XTAL MT7530)
Merging netfilter/main (15fba562f7a9 netfilter: arptables: Select NETFILTER=
_FAMILY_ARP when building arp_tables.c)
Merging ipvs/main (7eaf837a4eb5 netfilter: nf_tables: Fix a memory leak in =
nf_tables_updchain)
Merging wireless/for-next (50108c352db7 Merge tag 'net-6.9-rc2' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (b68e1acb5834 RDMA/cm: Print the old state when c=
m_destroy_id gets timeout)
Merging sound-current/for-linus (c4e51e424e2c ALSA: line6: Zero-initialize =
message buffers)
Merging sound-asoc-fixes/for-linus (e29fb6e4a482 Merge remote-tracking bran=
ch 'asoc/for-6.8' into asoc-linus)
Merging regmap-fixes/for-linus (eaa03486d932 regmap: maple: Fix uninitializ=
ed symbol 'ret' warnings)
Merging regulator-fixes/for-linus (a469158eaf8f regulator: tps65132: Add of=
_match table)
Merging spi-fixes/for-linus (1f886a7bfb3f spi: mchp-pci1xxx: Fix a possible=
 null pointer dereference in pci1xxx_spi_probe)
Merging pci-current/for-linus (302b84e84d10 Revert "PCI: Mark LSI FW643 to =
avoid bus reset")
Merging driver-core.current/driver-core-linus (4cece7649650 Linux 6.9-rc1)
Merging tty.current/tty-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging usb.current/usb-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging usb-serial-fixes/usb-linus (d206a76d7d27 Linux 6.8-rc6)
Merging phy/fixes (4cece7649650 Linux 6.9-rc1)
Merging staging.current/staging-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging iio-fixes/fixes-togreg (6b8cffdc4a31 iio: accel: mxc4005: Reset chi=
p on probe() and resume())
Merging counter-current/counter-current (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc.current/char-misc-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging soundwire-fixes/fixes (63dc588e7af1 soundwire: amd: fix for wake in=
terrupt handling for clockstop mode)
Merging thunderbolt-fixes/fixes (c032cdd48b29 thunderbolt: Do not create Di=
splayPort tunnels on adapters of the same router)
Merging input-current/for-linus (57ed9567e63b Merge branch 'next' into for-=
linus)
Merging crypto-current/master (5a7e89d3315d crypto: iaa - Fix nr_cpus < nr_=
iaa case)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (224fe424c356 selftests: dmabuf-heap: add con=
fig file for the test)
Merging dmaengine-fixes/fixes (9140ce47872b idma64: Don't try to serve inte=
rrupts when device is powered off)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (b0a53dc56c14 mtd: limit OTP NVMEM Cell parse t=
o non Nand devices)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (d353c3c34af0 media: mediatek: vcodec: support =
36 bits physical address)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (4cece7649650 Linux 6.9-rc1)
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
Merging cxl-fixes/fixes (f7c52345ccc9 cxl/core: Fix initialization of mbox_=
cmd.size_out in get event)
Merging btrfs-fixes/next-fixes (1b0c71a8839a Merge branch 'misc-6.9' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging samsung-krzk-fixes/fixes (c51102b6a279 MAINTAINERS: Change Krzyszto=
f Kozlowski's email address)
Merging pinctrl-samsung-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging devicetree-fixes/dt/linus (de164a7f1924 nios2: Only use built-in de=
vicetree blob if configured to do so)
Merging dt-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging scsi-fixes/fixes (2a26a11e9c25 scsi: ufs: core: Fix MCQ mode dev co=
mmand timeout)
Merging drm-fixes/drm-fixes (39cd87c4eb2b Linux 6.9-rc2)
Merging drm-intel-fixes/for-linux-next-fixes (99f855082f22 drm/i915/mst: Re=
ject FEC+MST on ICL)
Merging mmc-fixes/fixes (f8def10f73a5 mmc: sdhci-msm: pervent access to sus=
pended controller)
Merging rtc-fixes/rtc-fixes (4cece7649650 Linux 6.9-rc1)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (1f1dc442c57e mshyperv: Introduce hv_numa=
_node_to_pxm_info())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (7115ff4a8bfe riscv: compat_vdso: align VDSOAS b=
uild log)
Merging riscv-dt-fixes/riscv-dt-fixes (0f74c64f0a9f riscv: dts: starfive: R=
emove PMIC interrupt info for Visionfive 2 board)
Merging riscv-soc-fixes/riscv-soc-fixes (c90847bcbfb6 cache: sifive_ccache:=
 Partially convert to a platform driver)
Merging fpga-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging spdx/spdx-linus (4cece7649650 Linux 6.9-rc1)
Merging gpio-brgl-fixes/gpio/for-current (e8acd2d209a3 gpiolib: Fix trigger=
ing "kobject: 'gpiochipX' is not initialized, yet" kobject_get() errors)
Merging gpio-intel-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pinctrl-intel-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging auxdisplay-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging erofs-fixes/fixes (7557d296ad43 MAINTAINERS: erofs: add myself as r=
eviewer)
Merging kunit-fixes/kunit-fixes (cfedfb24c9dd kunit: configs: Enable CONFIG=
_DAMON_DBGFS_DEPRECATED for --alltests)
Merging memblock-fixes/fixes (6a9531c3a880 memblock: fix crash when reserve=
d memory is not added to memory)
Merging nfsd-fixes/nfsd-fixes (c8efe0eb6732 SUNRPC: Fix a slow server-side =
memory leak with RPC-over-TCP)
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (0f66dfe7b91d perf annotate: Add comments i=
n the data structures)
Merging efi-fixes/urgent (decd347c2a75 x86/efistub: Reinstate soft limit fo=
r initrd loading)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (4cece7649650 Linux 6.9-rc1)
Merging rust-fixes/rust-fixes (01848eee20c6 docs: rust: fix improper render=
ing in Arch Support page)
Merging v9fs-fixes/fixes/next (7a84602297d3 9p: explicitly deny setlease at=
tempts)
Merging w1-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pmdomain-fixes/fixes (2a93c6cbd5a7 pmdomain: qcom: rpmhpd: Fix enab=
led_corner aggregation)
Merging overlayfs-fixes/ovl-fixes (77a28aa47687 ovl: relax WARN_ON in ovl_v=
erify_area())
Merging i2c-host-fixes/i2c/i2c-host-fixes (d1ef7a9ca867 i2c: i801: Fix a re=
factoring that broke a touchpad on Lenovo P1)
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging clk-fixes/clk-fixes (7f1dd39aedfc clk: Provide !COMMON_CLK dummy fo=
r devm_clk_rate_exclusive_get())
Merging drm-misc-fixes/for-linux-next-fixes (fddf09273807 drm/display: fix =
typo)
Merging mm-stable/mm-stable (4e2e36129225 Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (39cd87c4eb2b Linux 6.9-rc2)
Merging mm/mm-everything (756ded70213d Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (bfa8f18691ed Merge tag 'scsi-misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (4962e1949608 perf beauty: Move uapi/linux/vho=
st.h copy out of the directory used to build perf)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (a1255ccab8ec swiotlb: do not set total_used t=
o 0 in swiotlb_create_debugfs_files())
Merging asm-generic/master (5394f1e9b687 arch: define CONFIG_PAGE_SIZE_*KB =
on all architectures)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (5616fee8981b Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (1d63d1d9e5c5 perf: starfive: fix 64-bit only C=
OMPILE_TEST condition)
Merging arm-perf/for-next/perf (b037e40a6af2 docs: perf: Fix build warning =
of hisi-pcie-pmu.rst)
Merging arm-soc/for-next (72ebb41b88f9 soc: fsl: dpio: fix kcalloc() argume=
nt order)
Merging amlogic/for-next (4cece7649650 Linux 6.9-rc1)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (4cece7649650 Linux 6.9-rc1)
Merging broadcom/next (bbfdba3d4757 Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (e23359d88a81 dt-bindings: memory-controlle=
rs: add Samsung S5Pv210 SoC DMC)
Merging imx-mxs/for-next (6cf256f63478 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (7825bf5e9af2 Merge branches 'v6.9-next/soc' and =
'v6.9-next/dts64' into for-next)
Merging mvebu/for-next (058bfa0ead87 arm64: dts: marvell: cn9130-crb: drop =
unneeded "status")
Merging omap/for-next (69f4343fc41d Merge branch 'omap-for-v6.9/n8x0-fixes'=
 into for-next)
Merging qcom/for-next (9973bb4fffba Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-for-6.10', 'clk-fixes-for-6.9' and 'drivers-fo=
r-6.10' into for-next)
Merging renesas/next (a31e004a082c Merge branch 'renesas-dts-for-v6.10' int=
o renesas-next)
Merging reset/reset/next (6d89df61650d reset: ti-sci: Convert to platform r=
emove callback returning void)
Merging rockchip/for-next (3220b4905e1e Merge branch 'v6.10-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (3c1146718332 Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (417d46e7ad2e Merge branches 'for-next/ffa/fixe=
s', 'for-next/scmi/fixes' and 'for-next/scmi/updates' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (89a7056ed4f7 riscv: dts: sophgo: add sdcard suppor=
t for milkv duo)
Merging stm32/stm32-next (a7b9ab6c880d arm64: dts: st: add video encoder su=
pport to stm32mp255)
Merging sunxi/sunxi/for-next (c1d7282e4e92 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (746ef0fac697 Merge branch 'optee_convert_platform_remove_=
callback_for_v6.10' into next)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (4cece7649650 Linux 6.9-rc1)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (e53b2bb3ae07 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (13269dc6c704 clk: imx: imx8mp: Fix SAI_MCLK_SEL d=
efinition)
Merging clk-renesas/renesas-clk (9c8515858521 clk: renesas: r8a779h0: Add S=
CIF clocks)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (18b722527e2c Merge branch 'loongarch-kvm'=
 into loongarch-next)
Merging m68k/for-next (70d830e337f9 m68k: Calculate THREAD_SIZE from THREAD=
_SIZE_ORDER)
Merging m68knommu/for-next (57337aff95b1 m68k: Avoid CONFIG_COLDFIRE switch=
 in uapi header)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (4cece7649650 Linux 6.9-rc1)
Merging openrisc/for-next (7f1e2fc49348 openrisc: Use asm-generic's version=
 of fix_to_virt() & virt_to_fix())
Merging parisc-hd/for-next (e8f897f4afef Linux 6.8)
Merging powerpc/next (5c4233cc0920 powerpc/kdump: Split KEXEC_CORE and CRAS=
H_DUMP dependency)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (4cece7649650 Linux 6.9-rc1)
Merging riscv-dt/riscv-dt-for-next (4cece7649650 Linux 6.9-rc1)
Merging riscv-soc/riscv-soc-for-next (4cece7649650 Linux 6.9-rc1)
Merging s390/for-next (bd6d8a36b4b7 Merge branch 'fixes' into for-next)
Merging sh/for-next (4cece7649650 Linux 6.9-rc1)
Merging sparc/for-next (84b76d05828a lib/fonts: Allow Sparc console 8x16 fo=
nt for sparc64 early boot text console)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (0e60f0b75884 xtensa: fix MAKE_PC_FROM_RA se=
cond argument)
Merging bcachefs/for-next (09d4c2acbf4c bcachefs: reconstruct_inode())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (b59c910ca7d4 Merge branch 'for-next-next-v6.9-20240=
328' into for-next-20240328)
  16b265d574c7 ("btrfs: qgroup: correctly model root qgroup rsv in convert")
  49514f133c10 ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume o=
perations")
  79bc0330ea11 ("btrfs: record delayed inode root in transaction")
  8a9fbee85827 ("btrfs: make btrfs_clear_delalloc_extent() free delalloc re=
serve")
  99e563e30c41 ("btrfs: qgroup: convert PREALLOC to PERTRANS after record_r=
oot_in_trans")
  c22750cb802e ("btrfs: always clear PERTRANS metadata during commit")
Merging ceph/master (825b82f6b82a ceph: set correct cap mask for getattr re=
quest for read)
Merging cifs/for-next (e0e50401cc39 smb: client: fix potential UAF in cifs_=
signal_cifsd_for_reconnect())
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging erofs/dev (1c89beb9534d erofs: do not use pagepool in z_erofs_gbuf_=
growsize())
Merging exfat/dev (d7ed5232f0f1 exfat: fix timing of synchronizing bitmap a=
nd inode)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (3a42e042d2c3 Pull udf strscpy() conversion.)
Merging ext4/dev (0ecae5410ab5 ext4: initialize sbi->s_freeclusters_counter=
 and sbi->s_dirtyclusters_counter before use in kunit test)
Merging f2fs/dev (bf3a69c6861f Merge tag 'for-linus-6.9-ofs1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/hubcap/linux)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (cdf6ac2a03d2 fuse: get rid of ff->readdir.lock)
Merging gfs2/for-next (6f18f897e3ff gfs2: Remove unnecessary gfs2_meta_chec=
k_ii argument)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (5ed11af19e56 ksmbd: do not set SMB2_GLOBAL_CA=
P_ENCRYPTION for SMB 3.1.1)
Merging nfs/linux-next (719fcafe07c1 nfs: fix panic when nfs4_ff_layout_pre=
pare_ds() fails)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (175254780e6f sunrpc: removed redundant procp check)
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
Merging vfs-brauner/vfs.all (281cb6e9cb05 Merge branch 'vfs.netfs' into vfs=
all)
  0e74485c814a ("nilfs2: fix out-of-range warning")
  528aa74c091d ("9p: Clean up a kdoc warning.")
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (a2b4cab9da77 Merge branch 'for-6.10' into for-next)
Merging pci/next (6c6ca4d09c49 Merge branch 'pci/enumeration')
Merging pstore/for-next/pstore (80b735d01bbb pstore/blk: replace deprecated=
 strncpy with strscpy)
Merging hid/for-next (8006ea023772 Merge branch 'for-6.10/playstation' into=
 for-next)
Merging i2c/i2c/for-next (39cd87c4eb2b Linux 6.9-rc2)
Merging i2c-host/i2c/i2c-host (71b494e043d2 i2c: i801: Call i2c_register_sp=
d for muxed child segments)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (826eb58fbd77 hwmon: (pmbus/mp2975) Use i2=
c_get_match_data())
Merging jc_docs/docs-next (9e192b39a599 docs/zh_CN: Add dev-tools/ubsan Chi=
nese translation)
Merging v4l-dvb/master (b14257abe705 media: rcar-isp: Disallow unbind of de=
vices)
Merging v4l-dvb-next/master (b14257abe705 media: rcar-isp: Disallow unbind =
of devices)
Merging pm/linux-next (731369c312d5 Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (a8e949d41c72 cpufreq: scmi: Ena=
ble boost support)
Merging cpupower/cpupower (4cece7649650 Linux 6.9-rc1)
Merging devfreq/devfreq-next (6f3c0cfe2aa5 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (ccabbb6768fc pmdomain: renesas: rcar-gen4-sysc: Redu=
ce atomic delays)
Merging opp/opp/linux-next (13c8cf339e1a dt-bindings: opp: drop maxItems fr=
om inner items)
Merging thermal/thermal/linux-next (1828c1c17bb2 thermal/drivers/rcar_gen3:=
 Add support for R-Car V4M)
Merging dlm/next (ca0dcef7cf6c dlm: Simplify the allocation of slab caches =
in dlm_lowcomms_msg_cache_create)
Merging rdma/for-next (f10242b3da90 RDMA/mana_ib: Use struct mana_ib_queue =
for RAW QPs)
Merging net-next/main (34c58c89feb3 Merge branch 'gve-ring-size-changes')
CONFLICT (content): Merge conflict in net/ipv4/ip_gre.c
Merging bpf-next/for-next (519e1de94b71 Merge branch 'add-internal-only-bpf=
-per-cpu-instruction')
Merging ipsec-next/master (537c2e91d354 Merge git://git.kernel.org/pub/scm/=
linux/kernel/git/netdev/net)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (3e3fa13686bf Bluetooth: ISO: Handle PA sync when =
no BIGInfo reports are generated)
Merging wireless-next/for-next (0ccf50df61f9 Merge tag 'ath-next-20240402' =
of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mac80211.c
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (1162bc2f8f5d mtd: partitions: redboot: Added conversi=
on of operands to a larger type)
Merging nand/nand/next (6819db94e1cd mtd: rawnand: hynix: fixed typo)
Merging spi-nor/spi-nor/next (4cece7649650 Linux 6.9-rc1)
Merging crypto/master (a9a72140536f hwrng: mxc-rnga - Drop usage of platfor=
m_driver_probe())
Merging drm/drm-next (39cd87c4eb2b Linux 6.9-rc2)
Merging drm-exynos/for-linux-next (4cece7649650 Linux 6.9-rc1)
Merging drm-misc/for-linux-next (45c734fdd43d drm/panthor: Don't return NUL=
L from panthor_vm_get_heap_pool())
Merging amdgpu/drm-next (d7f148764355 drm/amdgpu: always force full reset f=
or SOC21)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c.c
Merging drm-intel/for-linux-next (c19278d6fb9d drm/i915: Use debugfs_create=
_bool() for "i915_bigjoiner_force_enable")
  5a1da42b50f3 ("drm/i915/dp: Fix the computation for compressed_bpp for DI=
SPLAY < 13")
  7a51a2aa2384 ("drm/i915/dp: Fix DSC state HW readout for SST connectors")
  b52c4093b0c9 ("drm/i915/psr: Move writing early transport pipe src")
  b648ce2a28ba ("drm/i915/mst: Reject FEC+MST on ICL")
  c9c92f286dbd ("drm/i915/mst: Limit MST+DSC to TGL+")
  d37b3dac68e2 ("drm/i915/psr: Fix intel_psr2_sel_fetch_et_alignment usage")
  ddf8a8bbb564 ("drm/i915/dp: Remove support for UHBR13.5")
  f3b899f0b4b1 ("drm/i915/psr: Calculate PIPE_SRCSZ_ERLY_TPT value")
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ps=
r.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (4be445f5b6b6 drm/msm/dpu: capture snapshot on the=
 first commit_done timeout)
Merging drm-msm-lumag/msm-next-lumag (4be445f5b6b6 drm/msm/dpu: capture sna=
pshot on the first commit_done timeout)
Merging drm-xe/drm-xe-next (34820967ae7b drm/xe/xe_migrate: Cast to output =
precision before multiplying operands)
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_bo.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (688cf5986658 fbdev: sisfb: hide unused variables)
Merging regmap/for-next (58479bdbce84 Merge remote-tracking branch 'regmap/=
for-6.10' into regmap-next)
Merging sound/for-next (b7e1e969c887 Merge branch 'topic/sound-devel-6.10' =
into for-next)
Merging ieee1394/for-next (44d8095ba9eb firewire: ohci: use pci_irq_vector(=
) to retrieve allocated interrupt line)
Merging sound-asoc/for-next (d12808ad2d75 Merge remote-tracking branch 'aso=
c/for-6.10' into asoc-next)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (8984e0b56923 Input: adafruit-seesaw - only report butto=
ns that changed state)
Merging block/for-next (c0055efa0a19 Merge branch 'for-6.10/block' into for=
-next)
CONFLICT (content): Merge conflict in io_uring/io_uring.c
CONFLICT (content): Merge conflict in io_uring/rw.c
Applying: fix up for "mm: switch mm->get_unmapped_area() to a flag"
Merging device-mapper/for-next (8e91c2342351 dm integrity: fix out-of-range=
 warning)
Merging libata/for-next (dcf2653ac12f dt-bindings: ata: ahci-da850: Convert=
 to dtschema)
Merging pcmcia/pcmcia-next (ccae53aa8aa2 pcmcia: cs: make pcmcia_socket_cla=
ss constant)
Merging mmc/next (c522e525eb09 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (e42199bf13d4 mfd: intel-lpss: Switch over to MSI =
interrupts)
CONFLICT (content): Merge conflict in drivers/mfd/intel-lpss-pci.c
Merging backlight/for-backlight-next (946ced827e6c backlight: mp3309c: Fix =
signedness bug in mp3309c_parse_fwnode())
Merging battery/for-next (50f0ff7c8cc4 power: supply: bq27xxx: Move health =
reading out of update loop)
Merging regulator/for-next (1c02bfce2012 Merge remote-tracking branch 'regu=
lator/for-6.10' into regulator-next)
Merging security/next (4cece7649650 Linux 6.9-rc1)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (9150b4ce55a6 ima: define an init_module c=
ritical data record)
Merging selinux/next (078f764d76b1 Automated merge of 'dev' into 'next')
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
Merging devicetree/for-next (57b7d5d315e2 dt-bindings: display: atmel,lcdc:=
 convert to dtschema)
Merging dt-krzk/for-next (bd4f7797dcdb Merge branch 'next/dt' into for-next)
CONFLICT (modify/delete): arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-mine=
rva-cmc.dts deleted in HEAD and modified in dt-krzk/for-next.  Version dt-k=
rzk/for-next of arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dt=
s left in tree.
$ git rm -f arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (6a75550ad6ab Merge remote-tracking branch 'spi/for-6.=
10' into spi-next)
Merging tip/master (034dd140a6d8 Merge branch into tip/master: 'x86/shstk')
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (7132365e62fb Merge ras/edac-misc into for-next)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (1fe1448b0f2b ftrace: Asynchronous grace period for re=
gister_ftrace_direct())
Merging kvm/next (9bc60f733839 Merge tag 'kvm-riscv-fixes-6.9-1' of https:/=
/github.com/kvm-riscv/linux into HEAD)
Merging kvm-arm/next (29b0075ed61c KVM: selftests: Fix __GUEST_ASSERT() for=
mat warnings in ARM's arch timer test)
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (8e936e98718f RISC-V: KVM: Fix APLIC in_cl=
rip[x] read emulation)
Merging kvm-x86/next (964d0c614c7f Merge branch 'hyperv')
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/include/x=
86_64/processor.h
Merging xen-tip/linux-next (d277f9d82802 xen/events: increment refcnt only =
if event channel is refcounted)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (ca5422a309a9 Merge branch 'for-6.9-fixes' into=
 for-next)
Merging drivers-x86/for-next (c868f11664bd platform/x86: MAINTAINERS: drop =
Daniel Oliveira Nascimento)
Merging chrome-platform/for-next (d91ca83599cd platform/chrome: cros_kbd_le=
d_backlight: provide ID table for avoiding fallback match)
Merging chrome-platform-firmware/for-firmware-next (7f20f21c22aa firmware: =
google: cbmem: drop driver owner initialization)
Merging hsi/for-next (4cece7649650 Linux 6.9-rc1)
Merging leds-lj/for-leds-next (ca66b10a11da leds: simatic-ipc-leds-gpio: Ad=
d support for module BX-59A)
Merging ipmi/for-next (740d0a267c8d ipmi: Convert from tasklet to BH workqu=
eue)
Merging driver-core/driver-core-next (0bb322be5d38 driver core: Remove unus=
ed platform_notify, platform_notify_remove)
Merging usb/usb-next (5bab5dc780c9 Merge 6.9-rc2 into usb-next)
Merging thunderbolt/next (39cd87c4eb2b Linux 6.9-rc2)
Merging usb-serial/usb-next (b1a8da9ff139 USB: serial: cp210x: add pid/vid =
for TDK NC0110013M and MM0110113M)
Merging tty/tty-next (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc/char-misc-next (39cd87c4eb2b Linux 6.9-rc2)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (a4f3057d19ff coresight-tpda: Change qcom,dsb-elemen=
t-size to qcom,dsb-elem-bits)
Merging fastrpc/for-next (4cece7649650 Linux 6.9-rc1)
Merging fpga/for-next (f6c86fdf3716 fpga: altera-cvp: Remove an unused fiel=
d in struct altera_cvp_conf)
Merging icc/icc-next (7af14fe58e5e Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (27eea4778db8 iio: adc: ad7944: simplify adi,spi-mode pr=
operty parsing)
Merging phy-next/next (e298ae7caafc phy: qcom: qmp-combo: fix duplicate ret=
urn in qmp_v4_configure_dp_phy)
Merging soundwire/next (2a9c6ff5ca5a soundwire: intel: add intel_free_strea=
m() back)
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (7447d911af69 vfio/fsl-mc: Block calling interrupt handle=
r without trigger)
Merging w1/for-next (cde37a5bdb0e w1: gpio: Don't use "proxy" headers)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (a103e5ad2199 Merge 6.9-rc2 into staging-next)
Merging counter-next/counter-next (916baadd293a counter: ti-ecap-capture: U=
tilize COUNTER_COMP_FREQUENCY macro)
Merging siox/siox/for-next (db418d5f1ca5 siox: bus-gpio: Simplify using dev=
m_siox_* functions)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (8b7149803af1 MAINTAINERS: Drop Gustavo Pimentel as =
EDMA Reviewer)
Merging cgroup/for-next (4793cb599b1b selftests: cgroup: skip test_cgcore_l=
esser_ns_open when cgroup2 mounted without nsdelegate)
Merging scsi/for-next (31974fcad708 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (0ff10cb7f818 scsi: libsas: Fix declaration of nc=
q priority attributes)
Merging vhost/linux-next (894452180d73 vduse: enable Virtio-net device type)
Merging rpmsg/for-next (7aa94fb965d4 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (1685f72a6dcc gpiolib: Do not mention legac=
y GPIOF_* in the code)
Merging gpio-intel/for-next (4cece7649650 Linux 6.9-rc1)
Merging pinctrl/for-next (9ca691f95646 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (4cece7649650 Linux 6.9-rc1)
Merging pinctrl-renesas/renesas-pinctrl (aa43c15a790c pinctrl: renesas: rzg=
2l: Execute atomically the interrupt configuration)
Merging pinctrl-samsung/for-next (4184e4912ca6 dt-bindings: pinctrl: samsun=
g: drop unused header with register constants)
Merging pwm/pwm/for-next (b33d3801b304 pwm: Don't check pointer for being n=
on-NULL after use)
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (e1e4db64728f kselftest/clone3: Make test names for =
set_tid test stable)
Merging kunit/test (4cece7649650 Linux 6.9-rc1)
Merging kunit-next/kunit (4cece7649650 Linux 6.9-rc1)
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
Merging auxdisplay/for-next (16934de47da7 auxdisplay: linedisp: Group displ=
ay drivers together)
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
Merging slab/slab/for-next (9198ffbd2b49 mm/slub: Reduce memory consumption=
 in extreme scenarios)
Merging random/master (4cece7649650 Linux 6.9-rc1)
Merging landlock/next (2c5b58d63bed fs/ioctl: Add a comment to keep the log=
ic in sync with the Landlock LSM)
Merging rust/rust-next (a321f3ad0a5d rust: str: add {make,to}_{upper,lower}=
case() to CString)
Merging sysctl/sysctl-next (4f1136a55dc8 scripts: check-sysctl-docs: handle=
 per-namespace sysctls)
Merging execve/for-next/execve (5248f4097308 binfmt: replace deprecated str=
ncpy)
Merging bitmap/bitmap-for-next (fd8ed16c2419 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (231dc3f0c936 lkdtm/bugs: Improve warning messag=
e for compilers without counted_by support)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (4cece7649650 Linux 6.9-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (4cece7649650 Linux 6.9-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)
Applying: fixup for "netfs, 9p: Implement helpers for new write code"

--Sig_/OSpbANkuRWzA9pbiRUwTAhs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYOFBMACgkQAVBC80lX
0Gwd1wf/fmc+JISSfbPZu/aoGb/tyXyGZM5JB624p1BYhAFFuJsI8KFLQ9GtT57X
YH2e3MQGZxyf98K8dxFJNMHK5AdeNWoFBUu9FHxK0GpIZF9AUI4eZGW9+kTXEI2+
FYJwSO0XgzyK5y5/JPBSDsbgmK2uDucRknfr9ZyLgEcoV7QN7fMbWAs/KwetSUYA
atH/eBKDxXT38nRGmEMyacu6S28qUG3watVdVoV7kOEVJZ5sjeww7t8GybZyawur
n9sPR+F7UXlsgU7gGSdJ8g9ryc5KgL3phEiJ1ixOJ5b6gKHH6cu9WWsaPq3vRnnr
KfEki0H/iiPwciD5eB5uRCSuy6VpRw==
=A5AW
-----END PGP SIGNATURE-----

--Sig_/OSpbANkuRWzA9pbiRUwTAhs--

