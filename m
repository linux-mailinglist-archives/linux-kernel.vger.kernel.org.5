Return-Path: <linux-kernel+bounces-99821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF71878DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801D328248D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD32C13C;
	Tue, 12 Mar 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zgj/QXo+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26DA939;
	Tue, 12 Mar 2024 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710218428; cv=none; b=rmNUP/Rh4wg5p7Zpx8JTKWl1ZVVRfsyWV6ykS/2Q2SnUQOOme2j3brLm6wAbwUuQc7YE+lFp0ozBd9qUwYCuUbdAJkCWvvvGmbAZ/sCiRFScLYSO78hGOqboWWERcT5vdXF3AlTFvBHUjKw5gCzkK1QxEycR/ou1A4DdxN5LBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710218428; c=relaxed/simple;
	bh=9RCYoMLbFrQo1S62FuMma2BIsW66vNrXIuIp6Pm/gns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G8VR+9kikXl3p3pzn/WcAPH2CX/Ymn9M3NyIvhfNmZ02J2fJmszRdUhezH7k5mmwOv0kyYlUfaYqIYix9BaeG3MV3iryW46izwtSeqV3lNYAOhchtnm5izTxNSrFo+tF96cyBhH3hB8ByJSyskZd+ne82wlnyA+eKGwlGGoH7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Zgj/QXo+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710218421;
	bh=7NY/YHMc6QMvO0TGnnjSCCpa8JQXXX6tt5k7vpsOyzo=;
	h=Date:From:To:Cc:Subject:From;
	b=Zgj/QXo+G1kTGGk5m7T+Hm+xv0jiOyVhQR72jS+3crui/24BtDtViobMI2N3HICET
	 kOUfDgtO9LXGGDcSfvhtf3ha6xliHN4hMCUGG2sEZl2zsJ3AZrKsx4dmKcEYQOvAbF
	 9PxTsJo+PnflXDiPuoANseqFkatKiHNTMAynal1KMigt1R+jPY5G/a6s9t0YZfmcQp
	 TfhdpzJUrsUNfyY/gtiGYvkyO/vsCjbiPV4nWLwH2ZhPjGQQOXTEEiShUviFWVLYV0
	 ZNUaMWZhDegPHnYP4Oi6tyDBk17RCD7Tzfq1Ox90h4g8ilyFGrL/DOKxGCN2X33XV2
	 WU31E/wzY6F9w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv1Cn3mFDz4wb2;
	Tue, 12 Mar 2024 15:40:21 +1100 (AEDT)
Date: Tue, 12 Mar 2024 15:40:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 12
Message-ID: <20240312154020.5604e362@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j7TGRhlowNcUNWgQKP0DJ8Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j7TGRhlowNcUNWgQKP0DJ8Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240308:

The i2c-host tree gained a build failure so I used the version from
next-20240308.

The hyperv tree gained a build failure for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 11526
 10291 files changed, 536420 insertions(+), 193263 deletions(-)

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

I am currently merging 372 trees (counting Linus' and 105 trees of bug
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
Merging origin/master (045395d86acd Merge tag 'cgroup-for-6.9' of git://git=
kernel.org/pub/scm/linux/kernel/git/tj/cgroup)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (ded79af42f11 scripts/gdb/symbols:=
 fix invalid escape sequence warning)
Merging kbuild-current/fixes (b401b621758e Linux 6.8-rc5)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (2c79bd34af13 arm64: prohibit probing on=
 arch_kunwind_consume_entry())
Merging arm-soc-fixes/arm/fixes (1c7cfb6158f6 Merge tag 'riscv-firmware-for=
-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into =
arm/fixes)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging sophgo-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (380cb2f4df78 selftests/powerpc: Fix fpu_signal=
 failures)
Merging s390-fixes/fixes (5ef1dc40ffa6 s390/cio: fix invalid -EBUSY on ccw_=
device_start)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (c8a5c731fd12 net: phy: dp83822: Fix RGMII TX delay config=
uration)
Merging bpf/master (df4793505abd Merge tag 'net-6.8-rc8' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipsec/master (e3fb8e8ba72b net: dsa: microchip: make sure drive str=
ength configuration is not lost by soft reset)
Merging netfilter/main (767146637efc netfilter: nf_conntrack_h323: Add prot=
ection for bmp length out of range)
Merging ipvs/main (767146637efc netfilter: nf_conntrack_h323: Add protectio=
n for bmp length out of range)
Merging wireless/for-next (413dafc8170f wifi: mac80211: only call drv_sta_r=
c_update for uploaded stations)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (eb5c7465c324 RDMA/srpt: fix function pointer cas=
t warnings)
Merging sound-current/for-linus (f5d9ddf1214b Merge tag 'asoc-v6.9' of http=
s://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging sound-asoc-fixes/for-linus (bd73d44d5f54 Merge remote-tracking bran=
ch 'asoc/for-6.8' into asoc-linus)
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (6717ff5533f3 regulator: rk808: fix LDO r=
ange on RK806)
Merging spi-fixes/for-linus (177cddaa5bdf spi: cs42l43: Don't limit native =
CS to the first chip select)
Merging pci-current/for-linus (6613476e225e Linux 6.8-rc1)
Merging driver-core.current/driver-core-linus (b401b621758e Linux 6.8-rc5)
Merging tty.current/tty-linus (3d9319c27ceb Revert "tty: serial: simplify q=
com_geni_serial_send_chunk_fifo()")
Merging usb.current/usb-linus (b234c70fefa7 xhci: Fix failure to detect rin=
g expansion need.)
Merging usb-serial-fixes/usb-linus (d206a76d7d27 Linux 6.8-rc6)
Merging phy/fixes (47b412c1ea77 phy: qcom-qmp-combo: fix type-c switch regi=
stration)
Merging staging.current/staging-linus (6613476e225e Linux 6.8-rc1)
Merging iio-fixes/fixes-togreg (11dadb631007 iio: accel: adxl367: fix I2C F=
IFO data register)
Merging counter-current/counter-current (c83ccdc9586b counter: fix privdata=
 alignment)
Merging char-misc.current/char-misc-linus (a0776c214d47 mei: gsc_proxy: mat=
ch component when GSC is on different bus)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (e8f897f4afef Linux 6.8)
Merging input-current/for-linus (fbf8d7174255 Input: synaptics-rmi4 - fix U=
AF of IRQ domain on driver removal)
Merging crypto-current/master (c0afb6b88fbb crypto: rk3288 - Fix use after =
free in unprepare)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b54761f6e977 kselftest/seccomp: Report each =
expectation we assert as a KTAP test)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (90d35da658da Linux 6.8-rc7)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (e6a30d0c48a1 mtd: rawnand: marvell: fix layout=
s)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (346c84e281a9 media: pwm-ir-tx: Depend on CONFI=
G_HIGH_RES_TIMERS)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (b401b621758e Linux 6.8-rc5)
Merging at91-fixes/at91-fixes (6613476e225e Linux 6.8-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (5abf6dceb066 SEV: disable SEV-ES DebugSwap by def=
ault)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (d206a76d7d27 Linux 6.8-rc6)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (d206a76d7d27 Linux 6.8-rc6)
Merging btrfs-fixes/next-fixes (5aaf38c4aef2 Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (0314cebb29be platform/x86/amd/pmf: Fix mis=
sing error code in amd_pmf_init_smart_pc())
Merging samsung-krzk-fixes/fixes (eab4f56d3e75 ARM: dts: exynos4212-tab3: a=
dd samsung,invert-vclk flag to fimd)
Merging pinctrl-samsung-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging devicetree-fixes/dt/linus (7cb50f6c9fba of: property: fw_devlink: F=
ix stupid bug in remote-endpoint parsing)
Merging dt-krzk-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging scsi-fixes/fixes (ee0017c3ed8a scsi: mpt3sas: Prevent sending diag_=
reset when the controller is ready)
Merging drm-fixes/drm-fixes (b7cc4ff787a5 nouveau: lock the client object t=
ree.)
Merging drm-intel-fixes/for-linux-next-fixes (e8f897f4afef Linux 6.8)
Merging mmc-fixes/fixes (4af59a8df5ea mmc: core: Fix switch on gp3 partitio=
n)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (aa707b615ce1 Drivers: hv: vmbus: make hv=
_bus const)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (a11dd49dcb93 riscv: Sparse-Memory/vmemmap out-o=
f-bounds fix)
Merging riscv-dt-fixes/riscv-dt-fixes (2672031b20f6 riscv: dts: Move BUILTI=
N_DTB_SOURCE to common Kconfig)
Merging riscv-soc-fixes/riscv-soc-fixes (d206a76d7d27 Linux 6.8-rc6)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394)
Merging gpio-brgl-fixes/gpio/for-current (90d35da658da Linux 6.8-rc7)
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging auxdisplay-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (4127caee8961 erofs: apply proper VMA alignment f=
or memory mapped files on THP)
Merging kunit-fixes/kunit-fixes (829388b725f8 kunit: device: Unregister the=
 kunit_bus on shutdown)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (6a9531c3a880 memblock: fix crash when reserve=
d memory is not added to memory)
Merging nfsd-fixes/nfsd-fixes (5ea9a7c5fe41 nfsd: don't take fi_lock in nfs=
d_break_deleg_cb())
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (fdd0ae72b34e perf tools headers: update th=
e asm-generic/unaligned.h copy with the kernel sources)
Merging efi-fixes/urgent (2ce507f57ba9 efivarfs: Drop 'duplicates' bool par=
ameter on efivar_init())
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (2df70149e73e power: supply: bq27xxx-i2c: Do no=
t free non existing IRQ)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (bb04d1335388 iommufd/selftest: Don't check ma=
p/unmap pairing with HUGE_PAGES)
Merging rust-fixes/rust-fixes (b401b621758e Linux 6.8-rc5)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (2a93c6cbd5a7 pmdomain: qcom: rpmhpd: Fix enab=
led_corner aggregation)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (1f78f0901011 i2c: aspeed: Fix th=
e dummy irq expected print)
  1f78f0901011 ("i2c: aspeed: Fix the dummy irq expected print")
  7c16cfd69d51 ("i2c: i801: Avoid potential double call to gpiod_remove_loo=
kup_table")
  ace9dc1d1251 ("i2c: wmt: Fix an error handling path in wmt_i2c_probe()")
  b60b86b55400 ("i2c: i801: Fix using mux_pdev before it's set")
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (16e87fe23d4a nouveau/dmem: han=
dle kcalloc() allocation failure)
Merging mm-stable/mm-stable (58f327f2ce80 filemap: avoid unnecessary major =
faults in filemap_fault())
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in init/main.c
Merging mm-nonmm-stable/mm-nonmm-stable (4bb7be96fc88 kexec: copy only happ=
ens before uchunk goes to zero)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
CONFLICT (content): Merge conflict in arch/riscv/include/asm/ftrace.h
Merging mm/mm-everything (dfbce184ef0a Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (44929bfaceaa kbuild: remove GCC's default -Wpacked=
-bitfield-compat flag)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (0f66dfe7b91d perf annotate: Add comments in t=
he data structures)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (5db52ce55f80 swiotlb: Reinstate page-alignmen=
t for mappings >=3D PAGE_SIZE)
Merging asm-generic/master (5394f1e9b687 arch: define CONFIG_PAGE_SIZE_*KB =
on all architectures)
CONFLICT (content): Merge conflict in arch/hexagon/Kconfig
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (5616fee8981b Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (f1bbc4e9cfa4 Revert "ARM64: Dynamically alloca=
te cpumasks and increase supported CPUs to 512")
CONFLICT (content): Merge conflict in rust/Makefile
Merging arm-perf/for-next/perf (b037e40a6af2 docs: perf: Fix build warning =
of hisi-pcie-pmu.rst)
Merging arm-soc/for-next (00f54c17aac6 Merge branch 'soc/dt' into for-next)
Merging amlogic/for-next (7092cfae086f Merge branch 'v6.9/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (6315946ad242 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (bbfdba3d4757 Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (e46076906722 memory: stm32-fmc2-ebi: keep =
power domain on)
Merging imx-mxs/for-next (edb0d16255f6 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (ba90af39ba57 arm64: dts: mediatek: mt8183-pico6:=
 Fix wake-on-X event node names)
Merging mvebu/for-next (6b6f1082cb46 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (69f4343fc41d Merge branch 'omap-for-v6.9/n8x0-fixes'=
 into for-next)
Merging qcom/for-next (d0e0a21a3cb9 Merge branches 'arm32-for-6.9', 'arm64-=
defconfig-for-6.9', 'arm64-fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' a=
nd 'drivers-for-6.9' into for-next)
Merging renesas/next (01fdf7d6f150 Merge branch 'renesas-dt-bindings-for-v6=
9' into renesas-next)
Merging reset/reset/next (c721f189e89c reset: Instantiate reset GPIO contro=
ller for shared reset-gpios)
Merging rockchip/for-next (24f3ec49401a Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (fb1be31d4042 Merge branches 'fixes', 'next/c=
lk', 'next/drivers', 'next/dt', 'next/dt64' and 'next/soc' into for-next)
Merging scmi/for-linux-next (a2b8119375a1 Merge tags 'vexpress-update-6.9',=
 'ffa-update-6.9' and 'scmi-updates-6.9' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (0f46e1339ef1 MAINTAINERS: Setup proper info for SO=
PHGO vendor support)
Merging stm32/stm32-next (a7b9ab6c880d arm64: dts: st: add video encoder su=
pport to stm32mp255)
Merging sunxi/sunxi/for-next (c1d7282e4e92 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (90d35da658da Linux 6.8-rc7)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (68818060efdb Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (a7f078ac3d97 Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (13269dc6c704 clk: imx: imx8mp: Fix SAI_MCLK_SEL d=
efinition)
Merging clk-renesas/renesas-clk (81a7a88a9806 clk: renesas: r8a779h0: Add R=
PC-IF clock)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (ff25f7f6e90d Merge branch 'loongarch-kvm'=
 into loongarch-next)
CONFLICT (content): Merge conflict in arch/loongarch/Makefile
Merging m68k/for-next (e8a7824856de m68k: defconfig: Update defconfigs for =
v6.8-rc1)
Merging m68knommu/for-next (b401b621758e Linux 6.8-rc5)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (732932220078 mips: cm: Convert __mips_cm_phys_base(=
) to weak function)
Merging openrisc/for-next (7f1e2fc49348 openrisc: Use asm-generic's version=
 of fix_to_virt() & virt_to_fix())
Merging parisc-hd/for-next (26dd48780bd2 parisc: led: Convert to platform r=
emove callback returning void)
Merging powerpc/next (9db2235326c4 powerpc/macio: Make remove callback of m=
acio driver void returned)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (886516fae2b7 RISC-V: fix check for zvkb with tip-o=
f-tree clang)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (28ecaaa5af19 riscv: dts: starfive: jh71=
10: Add camera subsystem nodes)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (b51f4a982f5a Merge branch 'features' into for-next)
Merging sh/for-next (0a2d3ce0031f sh: hd64461: Make setup_hd64461 static)
Merging sparc/for-next (84b76d05828a lib/fonts: Allow Sparc console 8x16 fo=
nt for sparc64 early boot text console)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (7ab7acb68adf xtensa: fix MAKE_PC_FROM_RA se=
cond argument)
Merging bcachefs/for-next (9d7519a7eae6 bcachefs: fix bch_folio_sector padd=
ing)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (a65b40c6858c Merge branch 'for-next-next-v6.8-20240=
305' into for-next-20240305)
Merging ceph/master (321e3c3de53c libceph: init the cursor when preparing s=
parse read in msgr2)
Merging cifs/for-next (3681fe1b0fee cifs: update internal module version nu=
mber for cifs.ko)
CONFLICT (content): Merge conflict in fs/smb/client/file.c
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (a1bafc3109d7 erofs: support compressed inodes over fscac=
he)
Merging exfat/dev (f3cb82f5008f exfat: remove SLAB_MEM_SPREAD flag usage)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (9d7d0eb685f1 Pull fanotify fix to allow freezing of =
tasks waiting for event response.)
Merging ext4/dev (0ecae5410ab5 ext4: initialize sbi->s_freeclusters_counter=
 and sbi->s_dirtyclusters_counter before use in kunit test)
Merging f2fs/dev (e88f4647d82f f2fs: Cast expression type to unsigned long =
in __count_extent_cache())
CONFLICT (content): Merge conflict in fs/f2fs/super.c
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (cdf6ac2a03d2 fuse: get rid of ff->readdir.lock)
CONFLICT (content): Merge conflict in fs/fuse/file.c
CONFLICT (content): Merge conflict in fs/fuse/inode.c
Merging gfs2/for-next (6f18f897e3ff gfs2: Remove unnecessary gfs2_meta_chec=
k_ii argument)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (342c3b87c95b ksmbd: retrieve number of blocks=
 using vfs_getattr in set_file_allocation_info)
Merging nfs/linux-next (e9efd5fe756d NFS: trace the uniquifier of fscache)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (9b350d3e349f NFSD: Clean up nfsd4_encode_replay())
CONFLICT (content): Merge conflict in fs/nfsd/nfs4layouts.c
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (b8a77b9a5f9c mtd: ubi: fix NVMEM over UBI volumes on 32=
-bit systems)
Merging v9fs/9p-next (2a0505cdd8c8 9p: remove SLAB_MEM_SPREAD flag usage)
Merging v9fs-ericvh/ericvh/for-next (be57855f5050 fs/9p: fix dups even in u=
ncached mode)
Merging xfs/for-next (75bcffbb9e75 xfs: shrink failure needs to hold AGI bu=
ffer)
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
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
Merging vfs-brauner/vfs.all (ec0bd2fb770c Merge branch 'vfs.uuid' into vfs.=
all)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
CONFLICT (content): Merge conflict in fs/coredump.c
Applying: fixup for "filelock: split common fields into struct file_lock_co=
re"
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (e7081d5a9d97 Merge branch 'rework/console-flushing=
-fixes' into for-next)
Merging pci/next (c43507cd5816 Merge branch 'pci/controller/qcom')
Merging pstore/for-next/pstore (c8d25d696f52 pstore/zone: Don't clear memor=
y twice)
Merging hid/for-next (f0cd2e82460c Merge branch 'for-6.9/amd-sfh' into for-=
next)
Merging i2c/i2c/for-next (6e999cd37678 Merge branch 'i2c/for-current' into =
i2c/for-next)
  f58418edf0cf ("i2c: aspeed: Fix the dummy irq expected print")
Merging i2c-host/i2c/i2c-host (313d6aa4c648 i2c: i2c-qcom-geni: Parse Error=
 correctly in i2c GSI mode)
$ git reset --hard HEAD^
Merging next-20240308 version of i2c-host
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (8debe3c1295e hwmon: (dell-smm) Add XPS 93=
15 to fan control whitelist)
Merging jc_docs/docs-next (0c8e9b538ed7 docs: verify/bisect: fixes, finetun=
ing, and support for Arch)
Merging v4l-dvb/master (e0b8eb0f6d65 media: visl: Add codec specific variab=
ility on output frames)
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging v4l-dvb-next/master (b14257abe705 media: rcar-isp: Disallow unbind =
of devices)
Merging pm/linux-next (268314880cd4 Merge branch 'pm-tools' into linux-next)
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
Merging cpufreq-arm/cpufreq/arm/linux-next (ad2a91086e28 cpufreq: scmi: Set=
 transition_delay_us)
Merging cpupower/cpupower (a114d9f1f2cf Fix cpupower-frequency-info.1 man p=
age typo)
Merging devfreq/devfreq-next (68a8582befd4 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (ccabbb6768fc pmdomain: renesas: rcar-gen4-sysc: Redu=
ce atomic delays)
Merging opp/opp/linux-next (bde3127675ff dt-bindings: opp: drop maxItems fr=
om inner items)
Merging thermal/thermal/linux-next (1828c1c17bb2 thermal/drivers/rcar_gen3:=
 Add support for R-Car V4M)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (96d9cbe2f2ff RDMA/cm: add timeout to cm_destroy_id w=
ait)
Merging net-next/main (f095fefacdd3 ptp: Move from simple ida to xarray)
CONFLICT (content): Merge conflict in drivers/net/ipa/ipa_smp2p.c
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mvm.h
Merging bpf-next/for-next (d6170e4aaf86 bpf: hardcode BPF_PROG_PACK_SIZE to=
 2MB * num_possible_nodes())
CONFLICT (content): Merge conflict in mm/vmalloc.c
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/progs/ver=
ifier_iterating_callbacks.c
Merging ipsec-next/master (aceb147b20a2 xfrm: Do not allocate stats in the =
driver)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (a4634aa71fee bonding: rate-limit bonding drive=
r inspect messages)
Merging ipvs-next/main (a4634aa71fee bonding: rate-limit bonding driver ins=
pect messages)
Merging bluetooth/master (32652c5a24c9 Bluetooth: btintel: Add support to d=
ownload intermediate loader)
Merging wireless-next/for-next (c2b25092864a Merge branch 'qmc-hdlc')
Merging wpan-next/master (b2d23256615c ieee802154: cfg802154: make wpan_phy=
_class constant)
Merging wpan-staging/staging (b2d23256615c ieee802154: cfg802154: make wpan=
_phy_class constant)
Merging mtd/mtd/next (77bf03252839 mtd: Remove support for Carillo Ranch dr=
iver)
Merging nand/nand/next (aacc2b6a31f0 mtd: rawnand: Ensure continuous reads =
are well disabled)
Merging spi-nor/spi-nor/next (6a9eda34418f mtd: spi-nor: core: set mtd->era=
seregions for non-uniform erase map)
Merging crypto/master (77292bb8ca69 crypto: scomp - remove memcpy if sg_nen=
ts is 1 and pages are lowmem)
Merging drm/drm-next (119b225f01e4 Merge tag 'amd-drm-next-6.9-2024-03-08-1=
' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
  1cb96a8a59c6 ("Revert "drm/amd/pm: resolve reboot exception for si oland"=
")
  34b811a281ba ("drm/amd/display: Prevent potential buffer overflow in map_=
hw_resources")
  5d978e72df5f ("drm/amd/display: check dc_link before dereferencing")
  63fcd306c0a5 ("drm/amdgpu: Enable gpu reset for S3 abort cases on Raven s=
eries")
  68e05b932dcb ("drm/amd/display: handle range offsets in VRR ranges")
  f317c5e58351 ("drm/amdgpu/pm: Fix the error of pwm1_enable setting")
  f53deddb6beb ("drm/amd/swsmu: modify the gfx activity scaling")
  f9e90b1ac63b ("drm/amdgpu/pm: Fix the power1_min_cap value")
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
_hdcp.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_bo.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_bo.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec_queue.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec_queue_type=
s.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_trace.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
CONFLICT (content): Merge conflict in include/uapi/drm/xe_drm.h
Merging drm-exynos/for-linux-next (f112b68f273f Merge v6.8-rc6 into drm-nex=
t)
Merging drm-misc/for-linux-next (838f865802b9 arch/powerpc: Remove <linux/f=
b.h> from backlight code)
Merging amdgpu/drm-next (5eabf0cd2673 drm/amd/display: Removed redundant @ =
symbol to fix kernel-doc warnings in -next repo)
Merging drm-intel/for-linux-next (0e7dd6fe9602 drm/i915: Reuse RPLU cdclk f=
ns for MTL+)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (4be445f5b6b6 drm/msm/dpu: capture snapshot on the=
 first commit_done timeout)
Merging drm-msm-lumag/msm-next-lumag (4be445f5b6b6 drm/msm/dpu: capture sna=
pshot on the first commit_done timeout)
Merging drm-xe/drm-xe-next (89d030804831 drm/xe/hdcp: Fix condition for hdc=
p gsc cs requirement)
  0e6fec6da251 ("drm/xe/kunit: fix link failure with built-in xe")
  1408784b5999 ("drm/xe/xe2: fix 64-bit division in pte_update_size")
  27b5a3f237fe ("drm/xe: Fix ref counting leak on page fault")
  4c47049d93b7 ("drm/xe/guc: Fix missing topology init")
  5224ed586ba7 ("drm/xe: Replace 'grouped target' in Makefile with pattern =
rule")
  af7b93d1d7ee ("drm/xe: Return immediately on tile_init failure")
  e5f276dc1e4c ("drm/xe: Remove obsolete async_ops from struct xe_vm")
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (62861ddcb27e Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (f5d9ddf1214b Merge tag 'asoc-v6.9' of https://git.k=
ernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging ieee1394/for-next (04f082d39b99 firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (bd73d44d5f54 Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-linus)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (2d77f70bb718 Input: imagis - add touch key support)
Merging block/for-next (d5ba465eb78b Merge branch 'io_uring-6.9' into for-n=
ext)
Merging device-mapper/for-next (c45392a8b23c Merge branch 'dm-vdo' into for=
-next)
Merging libata/for-next (c1bc6ed01c16 Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (ccae53aa8aa2 pcmcia: cs: make pcmcia_socket_cla=
ss constant)
Merging mmc/next (faf3b8014c35 mmc: core: make mmc_host_class constant)
CONFLICT (content): Merge conflict in drivers/mmc/core/queue.c
Merging mfd/for-mfd-next (78334c343bef mfd: cs42l43: Fix wrong GPIO_FN_SEL =
and SPI_CLK_CONFIG1 defaults)
Merging backlight/for-backlight-next (b49c1caca529 backlight: pandora_bl: D=
rop unneeded ENOMEM error message)
Merging battery/for-next (4e61f1e9d58f power: supply: core: fix charge_beha=
viour formatting)
Merging regulator/for-next (9405d7f91774 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (8f49397828ee Automated merge of 'dev' into 'next')
CONFLICT (content): Merge conflict in security/security.c
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (85445b964290 integrity: eliminate unneces=
sary "Problem loading X.509 certificate" msg)
Merging selinux/next (a1fc79343abb selinux: fix style issues in security/se=
linux/ss/symtab.c)
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (6fa6b796e037 tpm: tis_i2c: Add compatible string nuvoto=
n,npct75x)
Merging watchdog/master (6fe5aabf7fc6 watchdog: intel-mid_wdt: Get platform=
 data via dev_get_platdata())
Merging iommu/next (f379a7e9c3b5 Merge branches 'arm/mediatek', 'arm/renesa=
s', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (3b8b8f8a4375 dt-bindings: display: samsung,exy=
nos-mixer: Fix 'regs' typo)
  3b8b8f8a4375 ("dt-bindings: display: samsung,exynos-mixer: Fix 'regs' typ=
o")
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/tri=
vial-devices.yaml
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (f36cabd85207 Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (e146918ba7bc Merge branch into tip/master: 'x86/tdx')
  e0a1284b293b ("time/kunit: Use correct format specifier")
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
CONFLICT (content): Merge conflict in kernel/workqueue.c
Merging clockevents/timers/drivers/next (c819dbd07832 dt-bindings: timer: A=
dd support for cadence TTC PWM)
Merging edac/edac-for-next (fc8235a79d73 Merge ras/edac-misc into for-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Applying: fix up for "RAS: Introduce AMD Address Translation Library"
Merging ftrace/for-next (a641f0533adb tracing: Decrement the snapshot if th=
e snapshot trigger fails to register)
Merging rcu/rcu/next (3add00be5fe5 Merge branches 'rcu-doc.2024.02.14a', 'r=
cu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'r=
cu-misc.2024.02.14a' into rcu.2024.02.26a)
Merging kvm/next (7d8942d8e738 Merge tag 'kvm-x86-guest_memfd_fixes-6.8' of=
 https://github.com/kvm-x86/linux into HEAD)
CONFLICT (content): Merge conflict in arch/loongarch/Kconfig
Merging kvm-arm/next (4a09ddb8333a Merge branch kvm-arm64/kerneldoc into kv=
marm/next)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_arm.h
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Applying: fix up for "arm64/sysreg: Add register fields for ID_AA64DFR1_EL1"
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (d8c0831348e7 KVM: riscv: selftests: Add Z=
acas extension to get-reg-list test)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
Merging kvm-x86/next (964d0c614c7f Merge branch 'hyperv')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/sev.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/include/k=
vm_util_base.h
Merging xen-tip/linux-next (fa765c4b4aed xen/events: close evtchn after map=
ping cleanup)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (b111131e3ec7 Merge branch 'for-6.9' into for-n=
ext)
Merging drivers-x86/for-next (f5fed715e05d Merge tag 'platform-drivers-x86-=
v6.8-4' into pdx86/for-next)
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (8a0a62941a04 firmware: =
coreboot: Replace tag with id table in driver struct)
Merging hsi/for-next (3693760295e8 HSI: ssi_protocol: fix struct members ke=
rnel-doc warnings)
Merging leds-lj/for-leds-next (45066c4bbe8c leds: ncp5623: Add MS suffix to=
 time defines)
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (6aeb8850e0f3 device: core: Log warnin=
g for devices pending deferred probe on timeout)
Merging usb/usb-next (d99e42ce6b83 Merge tag 'usb-serial-6.9-rc1' of https:=
//git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/reg=
ulator/qcom,usb-vbus-regulator.yaml
Merging thunderbolt/next (b8a730836c6b thunderbolt: Constify the struct dev=
ice_type usage)
Merging usb-serial/usb-next (b1a8da9ff139 USB: serial: cp210x: add pid/vid =
for TDK NC0110013M and MM0110113M)
Merging tty/tty-next (d6c0d892b44c dt-bindings: serial: stm32: add power-do=
mains property)
Merging char-misc/char-misc-next (367b3560e10b binder: remove redundant var=
iable page_addr)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (a4f3057d19ff coresight-tpda: Change qcom,dsb-elemen=
t-size to qcom,dsb-elem-bits)
Merging fastrpc/for-next (6613476e225e Linux 6.8-rc1)
Merging fpga/for-next (b1a91ca25f15 fpga: remove redundant checks for bridg=
e ops)
Merging icc/icc-next (d1c16491134c Merge branch 'icc-sm7150' into icc-next)
Merging iio/togreg (f9d49338744b Merge branch 'togreg-cleanup' into togreg)
Merging phy-next/next (00ca8a15dafa phy: constify of_phandle_args in xlate)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
c
Merging soundwire/next (e17aae16acf5 soundwire: Use snd_soc_substream_to_rt=
d() to obtain rtd)
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (7447d911af69 vfio/fsl-mc: Block calling interrupt handle=
r without trigger)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging w1/for-next (d97d263132a6 w1: w1-gpio: Convert to platform remove c=
allback returning void)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (68bb540b1aef staging: greybus: Replaces direc=
tive __attribute__((packed)) by __packed as suggested by checkpatch)
Merging counter-next/counter-next (d5b71a36a6af MAINTAINERS: Update email a=
ddresses for William Breathitt Gray)
Merging siox/siox/for-next (db418d5f1ca5 siox: bus-gpio: Simplify using dev=
m_siox_* functions)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (716141d366f4 dmaengine: of: constify of_phandle_arg=
s in of_dma_find_controller())
Merging cgroup/for-next (13eb1d6e1cfc Merge branch 'for-6.8-fixes' into for=
-next)
Merging scsi/for-next (7b020ab8a009 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (52d8210ea45d Merge patch series "Update lpfc to =
revision 14.4.0.1")
Merging vhost/linux-next (ac20046227aa virtio-net: add cond_resched() to th=
e command waiting loop)
Merging rpmsg/for-next (929654e8f1ad Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
CONFLICT (content): Merge conflict in drivers/remoteproc/imx_dsp_rproc.c
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (8636f19c2d1f gpio: sysfs: repair export re=
turning -EPERM on 1st attempt)
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (ab4ca601bad1 gpio: nomadik: Fix debugfs without d=
ebugfs)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (a6f06b909fee pinctrl: renesas: All=
ow the compiler to optimize away sh_pfc_pm)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (dd6c6d57ab61 pwm: imx-tpm: fix probe crash due to=
 access registers without clock)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (5d94da7ff00e kselftest: Add basic test for probing =
the rust sample modules)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (806cb2270237 kunit: Annotate _MSG assertion varia=
nts with gnu printf specifiers)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (f0109900462d dt-bindings: rtc: zynqmp: Add support fo=
r Versal/Versal NET SoCs)
Merging nvdimm/libnvdimm-for-next (d9212b35da52 dax: remove SLAB_MEM_SPREAD=
 flag usage)
Merging at24/at24/for-next (6613476e225e Linux 6.8-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (56af94aace8a samples: user-trap: fix stri=
ct-aliasing warning)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (6613476e225e Linux 6.8-rc1)
Merging nvmem/for-next (6613476e225e Linux 6.8-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (65530a174ea3 hv: vmbus: Convert to platform rem=
ove callback returning void)
Merging auxdisplay/for-next (d8abf9d4ea35 auxdisplay: seg-led-gpio: Import =
linedisp namespace)
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (2ec11b5d6d90 bus: mhi: host: pci_generic: constify mo=
dem_telit_fn980_hw_v1_config)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (73bf93edeeea cxl/core: use sysfs_emit() for attr's _show(=
))
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (021bc4b9d7ed virt: efi_secret: Convert to platform remove=
 callback returning void)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (78e2606d5f55 Merge branch 'slab/for-6.9/slab-fl=
ag-cleanups' into slab/for-next)
Merging random/master (1f719a2f3fa6 Merge tag 'net-6.8-rc4' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging landlock/next (a17c60e533f5 samples/landlock: Don't error out if a =
file path cannot be opened)
Merging rust/rust-next (768409cff6cc rust: upgrade to Rust 1.76.0)
Merging sysctl/sysctl-next (4f1136a55dc8 scripts: check-sysctl-docs: handle=
 per-namespace sysctls)
Merging execve/for-next/execve (725d50261285 exec: Simplify remove_arg_zero=
() error path)
Merging bitmap/bitmap-for-next (fd8ed16c2419 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (6c069c8d3cfc overflow: Change DEFINE_FLEX to ta=
ke __counted_by member)
CONFLICT (content): Merge conflict in drivers/net/ethernet/intel/ice/ice_li=
b.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/intel/ice/ice_xs=
k.c
CONFLICT (content): Merge conflict in lib/Makefile
CONFLICT (content): Merge conflict in scripts/Makefile.lib
Applying: fix up for "overflow: Change DEFINE_FLEX to take __counted_by mem=
ber"
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)
Applying: Revert "mshyperv: Introduce hv_get_hypervisor_version function"

--Sig_/j7TGRhlowNcUNWgQKP0DJ8Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv3LQACgkQAVBC80lX
0GyGCAf/Zl7mmVGgGGtQR6LXPV0mBte7Oxtwu2ihm8DztpMnkbf5NSPhq+/VMQrN
zJ9TU+FjktCk33bvu50PmaG/q6Lov4DaCJ7OacYVsDMXRjduWSTJtN+YEODL6Bw+
HgIJu90uKjp6N8wyA1GB+KduLxXhldENu7D4tDiu7cTFE/PZWXK63PbU6QNkjTwd
qJKeaiU43OgnkLLljWQVt73i06jq4tw8W/bB89VhwjLCKgLG9OTc2+jidRMsIyGR
88PeQKNckaLh/WnQGScrKL/jh5r6TI3dbRkhzsygDwCCejXqXXt8QNnBJ3YW1qWl
Jo/k3yVw2vA6yiQB4CIgHf/BmjfAhw==
=8Kjh
-----END PGP SIGNATURE-----

--Sig_/j7TGRhlowNcUNWgQKP0DJ8Z--

