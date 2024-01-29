Return-Path: <linux-kernel+bounces-42128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325283FCC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F821C20CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B110949;
	Mon, 29 Jan 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ouHBk2OZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA095FC1D;
	Mon, 29 Jan 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499045; cv=none; b=BTEFK+dukKK1uUGCl+3LDHOftt3kdRBGBgVMa4/+JxiKVc+RQLvP3186BGuLpfuJl/+Uz289EHIx1s1uCzueVvzM8O1y+wQDcU9kgdNbA5q/hWrIWlV3pR/n9IFOEzvRZketWYRvuznlIBarzqh3Zy5smY9jT59MjCuoXHOrBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499045; c=relaxed/simple;
	bh=ljw1vJDkpNbxeE/kTgRy5T3rbLAiWQHuJQ8iBr+iITM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nuTkggnzeegQokgToymbN+vo2GPgvK0FlswHFSnCbG0c6CxlBzGaEOW2WFgv/n63NOcG+uZFAKA5XghMToBF7VtN4RD7dX5xjY+Vw59VGCzlUevN3PXWzTY50OisJeWSzLC64Ep5t4klDF8ErkheTkRt/ixok+qHYzX+Fyxhsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ouHBk2OZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706499031;
	bh=cSykf4RdjBxx3erg8X144ZNAiU86EpSlqlVfSt4EAWs=;
	h=Date:From:To:Cc:Subject:From;
	b=ouHBk2OZeTmvp1DALPJ+Tj8hJIAMxaKJwSd5VWwrGMuip56JVjooqgGyfpun/xQl0
	 mQm5eACxNy3oDA4DBSU4ZigUXA8w9S0U8Wki26+0sB1yOszoUTce/RmJviq+jhpfpy
	 2wRvp4tVqu30g6sqdrmoo6wYwQiiEcuAJjm+liWvpRtXvtgnldUKSBvoTDDr5tiwpy
	 C3N2MG0IIcwrHszlf9I8qDAihEIyIac1k65AK5wNGFn0NMs5a149pkKv2hrzadNqeb
	 vh3IZS/zGk2Ii6TLlTlSe3+DmRkpORfXp8oJ1ow00EaMUbwllbjqMxzxzyqojXKg30
	 IOGD4HRKzfIZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNYj33yctz4wqN;
	Mon, 29 Jan 2024 14:30:31 +1100 (AEDT)
Date: Mon, 29 Jan 2024 14:30:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 29
Message-ID: <20240129143030.16647483@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fHYcPvJ4gDVBzdaHdyO9Qma";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fHYcPvJ4gDVBzdaHdyO9Qma
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240125:

New trees: i2c-host-fixes, i2c-host

The kselftest-fixes tree gained a conflict against the mm-hotfixes tree.

The mm tree lost one build failure but still had the other for which I
applied a patch.

The tip tree gained a build failure so I used the version from
next-20240125.

The leds-lj tree gained a build failure so I used the version from
next-20240125.

The rust tree gained a conflict against the mm tree.

Non-merge commits (relative to Linus' tree): 2012
 2307 files changed, 79246 insertions(+), 60346 deletions(-)

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

I am currently merging 366 trees (counting Linus' and 102 trees of bug
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
Merging origin/master (4854cf9c61d0 Merge tag 'mips-fixes_6.8_1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/mips/linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (fba99235aca2 mm/madvise: don't fo=
rget to leave lazy MMU mode in madvise_cold_or_pageout_pte_range())
Merging kbuild-current/fixes (10a73af98880 modpost: avoid using the alias a=
ttribute)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (3c0696076aad arm64: mm: Always make sw-=
dirty PTEs hw-dirty in pte_modify)
Merging arm-soc-fixes/arm/fixes (0d1d824a4ac1 Merge tag 'samsung-fixes-6.8'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/fix=
es)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (6b9c045b0602 m68k: defconfig: Update defcon=
figs for v6.7-rc1)
Merging powerpc-fixes/fixes (18f14afe2816 powerpc/64s: Increase default sta=
ck size to 32KB)
Merging s390-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (62b424810535 net: lan966x: Fix port configuration when us=
ing SGMII interface)
Merging bpf/master (62b424810535 net: lan966x: Fix port configuration when =
using SGMII interface)
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (a2933a8759a6 selftests: bonding: do not test arp/ns=
 target with mode balance-alb/tlb)
Merging ipvs/main (b29be0ca8e81 netfilter: nft_immediate: drop chain refere=
nce counter on error)
Merging wireless/for-next (1b023d475ae9 wifi: mac80211: Drop WBRF debugging=
 statements)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (80dde187f734 RDMA/bnxt_re: Add a missing check i=
n bnxt_qplib_query_srq)
Merging sound-current/for-linus (eeca59a6e8e6 ALSA: usb-audio: Support read=
-only clock selector control)
Merging sound-asoc-fixes/for-linus (7c70825d1603 ASoC: qcom: volume fixes a=
nd codec cleanups)
Merging regmap-fixes/for-linus (8b921545ddc6 Merge remote-tracking branch '=
regmap/for-6.7' into regmap-linus)
Merging regulator-fixes/for-linus (a67e1f0bd456 regulator: ti-abb: don't us=
e devm_platform_ioremap_resource_byname for shared interrupt register)
Merging spi-fixes/for-linus (8c2ae772fe08 spi: fix finalize message on erro=
r return)
Merging pci-current/for-linus (6613476e225e Linux 6.8-rc1)
Merging driver-core.current/driver-core-linus (6613476e225e Linux 6.8-rc1)
Merging tty.current/tty-linus (b35f8dbbce81 serial: max310x: prevent infini=
te while() loop in port startup)
Merging usb.current/usb-linus (f2e5d3de7e1f usb: typec: tcpm: fix the PD di=
sabled case)
Merging usb-serial-fixes/usb-linus (610a9b8f49fb Linux 6.7-rc8)
Merging phy/fixes (4e4a1183f281 phy: lan966x: Add missing serdes mux entry)
Merging staging.current/staging-linus (6613476e225e Linux 6.8-rc1)
Merging iio-fixes/fixes-togreg (6f6c72acddf4 iio: move LIGHT_UVA and LIGHT_=
UVB to the end of iio_modifier)
Merging counter-current/counter-current (6613476e225e Linux 6.8-rc1)
Merging char-misc.current/char-misc-linus (6613476e225e Linux 6.8-rc1)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging input-current/for-linus (180a8f12c21f Input: goodix - accept ACPI r=
esources with gpio_count =3D=3D 3 && gpio_int_idx =3D=3D 0)
Merging crypto-current/master (c5a2f74db71a crypto: caam - fix asynchronous=
 hash)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (93ffe3f1e97d kselftest/seccomp: Report each =
expectation we assert as a KTAP test)
CONFLICT (content): Merge conflict in tools/testing/selftests/core/close_ra=
nge_test.c
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (0650006a93a2 dmaengine: fsl-qdma: Remove a u=
seless devm_kfree())
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (7c1b1906229d mtd: spinand: gigadevice: Fix the=
 get ecc status issue)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (b32431b75321 media: vb2: refactor setting flag=
s and caps, fix missing cap)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (59be5c358501 mips: Call lose_fpu(0) before i=
nitializing fcr31 in mips_set_personality_nan)
Merging at91-fixes/at91-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (0dd3ee311255 Linux 6.7)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (915644189c22 hwmon: (pmbus/mp2975) Correct comme=
nt inside 'mp2975_read_byte_data')
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (d76779dd3681 cxl/region=EF=BC=9AFix overflow issue=
 in alloc_hpa())
Merging btrfs-fixes/next-fixes (c94bd41cb0b6 Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (485053bb81c8 fix ufs_get_locked_folio() breakage)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (1abdf288b0ef platform/x86: touchscreen_dmi=
: Add info for the TECLAST X16 Plus tablet)
Merging samsung-krzk-fixes/fixes (eab4f56d3e75 ARM: dts: exynos4212-tab3: a=
dd samsung,invert-vclk flag to fimd)
Merging pinctrl-samsung-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging devicetree-fixes/dt/linus (6154fb9c2134 kselftest: dt: Stop relying=
 on dirname to improve performance)
Merging dt-krzk-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging scsi-fixes/fixes (f4469f385835 scsi: storvsc: Fix ring buffer size =
calculation)
Merging drm-fixes/drm-fixes (987940f05735 Merge tag 'drm-misc-fixes-for-v6.=
8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos =
into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (f9f031dd21a7 drm/i915/psr: On=
ly allow PSR in LPSP mode on HSW non-ULT)
Merging mmc-fixes/fixes (8abf77c88929 mmc: sdhci-sprd: Fix eMMC init failur=
e after hw reset)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (a39b6ac3781d Linux 6.7-rc5)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging riscv-dt-fixes/riscv-dt-fixes (a75f0b6e6f74 riscv: dts: sophgo: sep=
arate sg2042 mtime and mtimecmp to fit aclint format)
  a75f0b6e6f74 ("riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to =
fit aclint format")
Merging riscv-soc-fixes/riscv-soc-fixes (a9d022ae8c4f Merge branch 'riscv-s=
oc-drivers-fixes' into riscv-soc-fixes)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (6613476e225e Linux 6.8-rc1)
Merging gpio-brgl-fixes/gpio/for-current (84aef4ed5970 gpio: eic-sprd: Clea=
r interrupt after set the interrupt type)
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (d9281660ff3f erofs: relaxed temporary buffers al=
location on readahead)
Merging kunit-fixes/kunit-fixes (1a9f2c776d14 Documentation: KUnit: Update =
the instructions on how to test static functions)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (6a9531c3a880 memblock: fix crash when reserve=
d memory is not added to memory)
Merging nfsd-fixes/nfsd-fixes (edcf9725150e nfsd: fix RELEASE_LOCKOWNER)
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging perf-current/perf-tools (becc24e96ad4 perf vendor events intel: Ald=
erlake/sapphirerapids metric fixes)
Merging efi-fixes/urgent (9ec96d83b3d3 efi/libstub: Add one kernel-doc comm=
ent)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (d0266d7ab161 Revert "power: supply: qcom_battm=
gr: Register the power supplies after PDR is up")
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (6613476e225e Linux 6.8-rc1)
Merging rust-fixes/rust-fixes (6613476e225e Linux 6.8-rc1)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (c41336f4d690 pmdomain: mediatek: fix race con=
ditions with genpd)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/for-current (cf10015a24f3 Merge tag 'execve-v6.8=
-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux)
Merging drm-misc-fixes/for-linux-next-fixes (27d19268cf39 accel/ivpu: Impro=
ve recovery and reset support)
Merging mm-stable/mm-stable (6613476e225e Linux 6.8-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (6613476e225e Linux 6.8-rc1)
Merging mm/mm-everything (6b32a8e4da27 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Applying: fix up for "crash: remove dependency of FA_DUMP on CRASH_DUMP"
Merging kbuild/for-next (bd768db42ef6 kbuild: deb-pkg: call more misc debhe=
lper commands)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (7727d59de44e perf tools: Add -H short option =
for --hierarchy)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
  34b2321cc648 ("MAINTAINERS: Add Andreas Larsson as co-maintainer for arch=
/sparc")
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (8790fade1a19 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (1b20d0486a60 arm64: Fix silcon-errata.rst form=
atting)
Merging arm-perf/for-next/perf (bb339db4d363 arm: perf: Fix ARCH=3Darm buil=
d with GCC)
Merging arm-soc/for-next (0d1d824a4ac1 Merge tag 'samsung-fixes-6.8' of htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/fixes)
Merging amlogic/for-next (0dd3ee311255 Linux 6.7)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e60f7a99d378 ARM: dts: aspeed: minerva: add sgpio =
line name)
Merging at91/at91-next (58f72e7817f1 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (2f542c937c48 dt-bindings: memory-controlle=
rs: narrow regex for unit address to hex numbers)
Merging imx-mxs/for-next (4db02d61a81e Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (0012c1958460 Merge branches 'sgx-for-v6.9' and 'omap=
-for-v6.9/soc' into for-next)
Merging qcom/for-next (f70a1e7dd74f Merge branches 'arm32-for-6.9', 'arm64-=
fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' and 'drivers-for-6.9' into f=
or-next)
Merging renesas/next (66d34ad1da6f Merge branch 'renesas-arm-defconfig-for-=
v6.9' into renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (a3c323226362 Merge branch 'v6.9-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (819ce8ab3d99 Merge branch 'next/drivers' int=
o for-next)
Merging scmi/for-linux-next (99f798bdfb75 Merge tags 'scmi-fixes-6.8' and '=
ffa-fixes-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux into for-linux-next)
Merging stm32/stm32-next (bda732fda193 ARM: dts: stm32: fix DSI peripheral =
clock on stm32mp15 boards)
Merging sunxi/sunxi/for-next (0fd213473de8 Merge branch 'sunxi/clk-for-6.9'=
 into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (5e6333ef8ea5 Merge branch for-6.8/arm/dt into for-n=
ext)
Merging ti/ti-next (6613476e225e Linux 6.8-rc1)
Merging xilinx/for-next (c0f708f5cda9 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (6613476e225e Linux 6.8-rc1)
Merging clk-imx/for-next (f52f00069888 clk: imx: pll14xx: change naming of =
fvco to fout)
Merging clk-renesas/renesas-clk (4ae2c995c433 clk: renesas: mstp: Remove ob=
solete clkdev registration)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (48ef9e87b407 LoongArch: KVM: Add returns =
to SIMD stubs)
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (6613476e225e Linux 6.8-rc1)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (6613476e225e Linux 6.8-rc1)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (94a54e4eb439 bcachefs: Fix build for parisc by =
avoiding __multi3())
Merging powerpc/next (44a1aad2fe6c Merge branch 'topic/ppc-kvm' into next)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (cb4ede926134 riscv: Avoid code duplication with ge=
neric bitops implementation)
Merging riscv-dt/riscv-dt-for-next (8d01f741a046 riscv: dts: starfive: jh71=
10: Add PWM node and pins configuration)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (8eb3db95a8c8 Merge branch 'features' into for-next)
Merging sh/for-next (6613476e225e Linux 6.8-rc1)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (a03cd7602a09 xtensa: don't produce FDPIC ou=
tput with fdpic toolchain)
Merging bcachefs/for-next (d2fda304bb73 bcachefs: __lookup_dirent() works i=
n snapshot, not subvol)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (c919330dd578 f2fs: fix double free of f2fs_sb_inf=
o)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (932ab07c383e Merge branch 'for-next-next-v6.8-20240=
108' into for-next-20240108)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
Merging ceph/master (ded080c86b3f rbd: don't move requests to the running l=
ist on errors)
Merging cifs/for-next (0a59780dbecb smb: client: introduce SMB2_OP_QUERY_WS=
L_EA)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (aa12a790d31b erofs: make erofs_{err,info}() support NULL=
 sb parameter)
Merging exfat/dev (0991abeddefa exfat: fix zero the unwritten part for dio =
read)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (cd04011c5859 Merge fsnotify optimization & cleanup f=
rom Amir.)
Merging ext4/dev (68da4c44b994 ext4: fix inconsistent between segment fstri=
m and full fstrim)
Merging f2fs/dev (70d201a40823 Merge tag 'f2fs-for-6.8-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (acd2d246f4b2 gfs2: Fix LOOKUP_RCU support in gfs2_dr=
evalidate)
Merging jfs/jfs-next (a280c9ceeca7 jfs: Add missing set_freezable() for fre=
ezable kthread)
Merging ksmbd/ksmbd-for-next (8c6f6a76465a Merge tag '6.8-rc2-smb3-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (1110eff8e65d NFSD: Remove redundant cb_seq_status i=
nitialization)
Merging ntfs3/master (ddb17dc880ee fs/ntfs3: Use kvfree to free memory allo=
cated by kvmalloc)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (adbf4c4954e3 ubi: block: fix memleak in ubiblock_create=
())
Merging v9fs/9p-next (ff49bf186757 net: 9p: avoid freeing uninit memory in =
p9pdu_vreadf)
Merging v9fs-ericvh/ericvh/for-next (be57855f5050 fs/9p: fix dups even in u=
ncached mode)
Merging xfs/for-next (d8d222e09dab xfs: read only mounts with fsopen mount =
API are busted)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (3ac974796e5d iomap: fix short copy in iomap_w=
rite_iter())
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (5628f06c9a98 Merge branch 'vfs.fs' into vfs.al=
l)
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (6613476e225e Linux 6.8-rc1)
Merging pstore/for-next/pstore (24a0b5e196cf pstore: inode: Use cleanup.h f=
or struct pstore_private)
Merging hid/for-next (53cc9efee5e9 Merge branch 'for-6.8/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (7a396820222d Merge tag 'v6.8-rc-part2-smb-client'=
 of git://git.samba.org/sfrench/cifs-2.6)
Merging i2c-host/i2c/for-next (cf10015a24f3 Merge tag 'execve-v6.8-rc2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux)
Merging i3c/i3c/next (4fa0888f6f3e i3c: document hotjoin sysfs entry)
Merging hwmon-staging/hwmon-next (909d8d33f8b4 hwmon: Drop non-functional I=
2C_CLASS_HWMON support for drivers w/o detect())
Merging jc_docs/docs-next (d546978e0c07 docs: admin-guide: remove obsolete =
advice related to SLAB allocator)
Merging v4l-dvb/master (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-next/master (04447d48afd3 media: mediatek: vcodec: drop exc=
ess struct members descriptions)
Merging pm/linux-next (7c67bc59f33e Merge branch 'pm-sleep' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (63814f381165 cpufreq: mediatek-=
hw: Don't error out if supply is not found)
Merging cpupower/cpupower (0086ffec768b tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
Merging pmdomain/next (1b140ba95a41 pmdomain: Merge branch fixes into next)
Merging opp/opp/linux-next (ace4b31b297d cpufreq: Move dev_pm_opp_{init|fre=
e}_cpufreq_table() to pm_opp.h)
Merging thermal/thermal/linux-next (5314b1543787 thermal/drivers/exynos: Us=
e set_trips ops)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (a400073ce3dd RDMA/mlx5: Delete unused mlx5_ib_copy_p=
as prototype)
Merging net-next/main (beb53f32698f Merge branch 'txgbe-irq_domain')
Merging bpf-next/for-next (beb53f32698f Merge branch 'txgbe-irq_domain')
Merging ipsec-next/master (ab1e1a38de24 xfrm6_tunnel: Use KMEM_CACHE instea=
d of kmem_cache_create)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (5ca1a5153a28 tipc: node: remove Excess struct =
member kernel-doc warnings)
Merging ipvs-next/main (42a7889a1931 Merge branch 'selftests-tcp-ao')
Merging bluetooth/master (64692e12507b Bluetooth: qca: Fix wrong event type=
 for patch config command)
Merging wireless-next/for-next (3fbf61207c66 Revert "mlx5 updates 2023-12-2=
0")
Merging wpan-next/master (2373699560a7 mac802154: Avoid new associations wh=
ile disassociating)
Merging wpan-staging/staging (2373699560a7 mac802154: Avoid new association=
s while disassociating)
Merging mtd/mtd/next (98d4fda8f2d4 Merge tag 'nand/for-6.8' into mtd/next)
Merging nand/nand/next (023e6aad7e5e mtd: rawnand: s3c2410: fix Excess stru=
ct member description kernel-doc warnings)
Merging spi-nor/spi-nor/next (3c0e1dfa703c MAINTAINERS: change my mail to t=
he kernel.org one)
Merging crypto/master (4d314d27130b dt-bindings: crypto: ice: Document SC71=
80 inline crypto engine)
Merging drm/drm-next (6613476e225e Linux 6.8-rc1)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (6613476e225e Linux 6.8-rc1)
Merging drm-misc/for-linux-next (1f1626ac0428 drm/ttm: fix ttm pool initial=
ization for no-dma-device drivers)
Merging amdgpu/drm-next (362936d613e8 amdgpu/drm: Use vram manager for virt=
ualization page retirement)
  0d50f4048de9 ("drm/amd/pm: udpate smu v13.0.6 message permission")
  1630c6ded587 ("drm/amd/display: "Enable IPS by default"")
  3295580d4683 ("drm/amd/display: Fix uninitialized variable usage in core_=
link_ 'read_dpcd() & write_dpcd()' functions")
  42ffb3c396b5 ("drm/amdgpu/pm: Fix the power source flag error")
  60818ed76577 ("drm/amd/display: Add IPS checks before dcn register access=
")
  67bbf55bd3c7 ("drm/amd/display: Disable ips before dc interrupt setting")
  6add38716548 ("drm/amd/pm: Fetch current power limit from FW")
  8352ca1090d1 ("drm/amd/amdgpu: Assign GART pages to AMD device mapping")
  85155f5b55b5 ("drm/amd: Add a DC debug mask for IPS")
  9bfb1a538a25 ("drm/amdgpu: Fix null pointer dereference")
  9c3f6e2c4ee0 ("drm/amdgpu: Show vram vendor only if available")
  a25dea474a24 ("drm/amd/display: Add Replay IPS register for DMUB command =
table")
  ac9c748362fd ("drm/amd/display: Allow IPS2 during Replay")
  bba8200a184a ("drm/amd/pm: update the power cap setting")
  ca01082353d4 ("drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs")
  e0eb08dcec0f ("drm/amdgpu: Avoid fetching vram vendor information")
  f980579c29a6 ("drm/amd/display: Replay + IPS + ABM in Full Screen VPB")
  fc8f5a29d4cf ("drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
Merging drm-intel/for-linux-next (84b5ece64477 drm/i915: Drop -Wstringop-ov=
erflow)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d4ca26ac4be0 drm/msm/dp: call dp_display_get_next=
_bridge() during probe)
Merging drm-msm-lumag/msm-next-lumag (d4ca26ac4be0 drm/msm/dp: call dp_disp=
lay_get_next_bridge() during probe)
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (0dd3ee311255 Linux 6.7)
Merging regmap/for-next (a1214cdfe92b Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (aa8e3ef4fe53 ALSA: hda/realtek: Add quirks for vari=
ous HP ENVY models)
Merging ieee1394/for-next (dd754748f1be firewire: Convert snprintf/sprintf =
to sysfs_emit)
Merging sound-asoc/for-next (01dffdcaa094 ASoC: dt-bindings: audio-graph-po=
rt: Drop type from "clocks")
Merging modules/modules-next (4515d08a742c kernel/module: improve documenta=
tion for try_module_get())
Merging input/next (ab30e1a93c07 Input: 88pm80x_onkey - add SPDX and drop G=
PL boilerplate)
Merging block/for-next (b48b5a7c9bc1 Merge branch 'block-deadline' into for=
-next)
Merging device-mapper/for-next (5d6f447b07d5 MAINTAINERS: remove stale info=
 for DEVICE-MAPPER)
Merging libata/for-next (3f105cfbe8a3 Merge remote-tracking branch 'libata/=
for-6.8-fixes' into for-next)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (5d4021334748 mmc: xenon: Add ac5 support via bounce buffe=
r)
Merging mfd/for-mfd-next (1e0ea9e75ff3 mfd: wm831x: Remove redundant foreve=
r while loop)
Merging backlight/for-backlight-next (3b75d271e161 backlight: hx8357: Fix p=
otential NULL pointer dereference)
Merging battery/for-next (4c5d387d79a6 power: supply: twl4030_madc: Use dev=
m_power_supply_register() helper)
Merging regulator/for-next (fad5e0b6d357 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (15e8e6a8fe07 security: fix the logic in security_ino=
de_getsecctx())
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (1ed4b5631002 Revert "KEYS: encrypted: Add=
 check for strsep")
Merging selinux/next (90593caf7db7 selinux: reduce the object class calcula=
tions at inode init time)
Merging smack/next (f0816d4332c3 ramfs: Initialize security of in-memory in=
odes)
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (610347effc2e Merge tag 'Wstringop-overflow-for-6.8-rc2'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux)
Merging watchdog/master (9546b21ea672 watchdog: mlx_wdt: fix all kernel-doc=
 warnings)
Merging iommu/next (75f74f85a42e Merge branches 'apple/dart', 'arm/rockchip=
', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (e20cd62b1f17 of: property: Make 'no port node =
found' output a debug message)
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (f333f63bf3e3 Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (fa26ddf600d2 Merge branch into tip/master: 'irq/core')
$ git reset --hard HEAD^
Merging next-20240125 version of tip
Merging clockevents/timers/drivers/next (c0c4579d79d0 clocksource/drivers/e=
p93xx: Fix error handling during probe)
Merging edac/edac-for-next (71c2bab9c258 Merge ras/edac-amd-atl into for-ne=
xt)
Merging ftrace/for-next (4af12c95cbe8 Merge probes/for-next)
Merging rcu/rcu/next (bc31e6cb27a9 rcu-tasks: Eliminate deadlocks involving=
 do_exit() and RCU tasks)
Merging kvm/next (1c6d984f523f x86/kvm: Do not try to disable kvmclock if i=
t was not enabled)
Merging kvm-arm/next (87bbb6a32237 Merge branch kvm-arm64/misc into kvmarm/=
next)
Merging kvms390/next (10f7b1dcdfe0 KVM: s390: cpu model: Use proper define =
for facility mask size)
Merging kvm-ppc/topic/ppc-kvm (180c6b072bf3 KVM: PPC: Book3S HV nestedv2: D=
o not cancel pending decrementer exception)
Merging kvm-riscv/riscv_kvm_next (4d0e8f9a361b KVM: riscv: selftests: Add Z=
fa extension to get-reg-list test)
Merging kvm-x86/next (1c6d984f523f x86/kvm: Do not try to disable kvmclock =
if it was not enabled)
Merging xen-tip/linux-next (2d2db7d40254 xen/gntdev: Fix the abuse of under=
lying struct page in DMA-buf import)
Merging percpu/for-next (1e653a292c26 Merge branch 'for-6.8' into for-next)
Merging workqueues/for-next (e563d0a7cdc1 workqueue: Break up enum definiti=
ons and give names to the types)
Merging drivers-x86/for-next (3f399b5d7189 platform/x86: wmi: Use ACPI devi=
ce name in netlink event)
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (6613476e225e Linux 6.8-=
rc1)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds-lj/for-leds-next (54602f38551e leds: Make flash and multicolor=
 dependencies unconditional)
$ git reset --hard HEAD^
Merging next-20240125 version of leds-lj
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (6613476e225e Linux 6.8-rc1)
Merging usb/usb-next (f1a27f081c1f usb: typec: qcom-pmic-typec: allow diffe=
rent implementations for the port backend)
Merging thunderbolt/next (dec6a613574c thunderbolt: Remove usage of the dep=
recated ida_simple_xx() API)
Merging usb-serial/usb-next (a39b6ac3781d Linux 6.7-rc5)
Merging tty/tty-next (6613476e225e Linux 6.8-rc1)
Merging char-misc/char-misc-next (6613476e225e Linux 6.8-rc1)
Merging accel/habanalabs-next (dddb2e526a36 accel/habanalabs: use kcalloc()=
 instead of kzalloc())
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (6613476e225e Linux 6.8-rc1)
Merging fpga/for-next (c849ecb2ae84 fpga: zynq-fpga: Convert to platform re=
move callback returning void)
Merging icc/icc-next (869b601db3b7 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (1856922150fc MAINTAINERS: add IIO GTS tests)
Merging phy-next/next (f7c6249d76f1 phy: armada-38x: add mux value for gbe =
port 0 on serdes 0)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
c
Merging soundwire/next (0707496ff4e4 soundwire: stream: add missing const t=
o Documentation)
Merging extcon/extcon-next (7803680964c0 extcon: qcom-spmi-misc: don't use =
kernel-doc marker for comment)
Merging gnss/gnss-next (0cbbbe09d49b gnss: ubx: add support for the reset g=
pio)
Merging vfio/next (78f70c02bdbc vfio/virtio: fix virtio-pci dependency)
Merging w1/for-next (6613476e225e Linux 6.8-rc1)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (ce54e9342124 staging: Remove board staging co=
de)
Merging counter-next/counter-next (0b3bbd8f9baf counter: linux/counter.h: f=
ix Excess kernel-doc description warning)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (8fcc3f7dbdae dmaengine: xilinx_dma: check for inval=
id vdma interleaved parameters)
Merging cgroup/for-next (8d4c171f451d docs: cgroup-v1: add missing code-blo=
ck tags)
Merging scsi/for-next (f4469f385835 scsi: storvsc: Fix ring buffer size cal=
culation)
Merging scsi-mkp/for-next (a34fc8c7361c scsi: mpt3sas: Update driver versio=
n to 48.100.00.00)
Merging vhost/linux-next (f16d65124380 vdpa/mlx5: Add mkey leak detection)
Merging rpmsg/for-next (99f59b148871 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (42969726a19f Documentation: gpio: describe=
 uAPI behaviour for unsupported config)
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (0ef4b05e2dfb Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (9e5889c68d99 pinctrl: renesas: rzg=
2l: Add input enable to the Ethernet pins)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (979c6fe7e799 dt-bindings: pxa-pwm: Convert to YAM=
L)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (6a71770442b5 selftests: livepatch: Test livepatchin=
g a heavily called syscall)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (6613476e225e Linux 6.8-rc1)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (14688f1a91e1 rtc: nuvoton: Compatible with NCT3015Y-R=
 and NCT3018Y-R)
Merging nvdimm/libnvdimm-for-next (a085a5eb6594 acpi/nfit: Use sysfs_emit()=
 for all attributes)
Merging at24/at24/for-next (6613476e225e Linux 6.8-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (0c6f28a84431 selftests/seccomp: user_noti=
fication_addfd check nextfd is available)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (04b945e4cf81 slimbus: qcom-ngd-ctrl: Make QMI mes=
sage rules const)
Merging nvmem/for-next (a0cfd5e99782 dt-bindings: nvmem: Convert xlnx,zynqm=
p-nvmem.txt to yaml)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (c52391fafcef auxdisplay: img-ascii-lcd: Use =
device_get_match_data())
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (01bd694ac2f6 bus: mhi: host: Drop chan lock before qu=
euing buffers)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (73bf93edeeea cxl/core: use sysfs_emit() for attr's _show(=
))
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (4afa688d7141 efi: memmap: fix kernel-doc warnings)
Merging unicode/for-next (367122c529f3 libfs: Attempt exact-match compariso=
n first during casefolded lookup)
Merging slab/slab/for-next (55f3fdd627cc Merge branch 'slab/for-6.9/optimiz=
e-get-freelist' into slab/for-next)
Merging random/master (615d30064886 Merge tag 'trace-v6.8-rc1' of git://git=
kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging landlock/next (bcfc924a6a33 landlock: Document IOCTL support)
Merging rust/rust-next (f090f0d0eea9 rust: sync: update integer types in Co=
ndVar)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
Merging sysctl/sysctl-next (6613476e225e Linux 6.8-rc1)
Merging execve/for-next/execve (90383cc07895 exec: Distinguish in_execve fr=
om in_exec)
Merging bitmap/bitmap-for-next (071ad962baf5 bitmap: Step down as a reviewe=
r)
CONFLICT (content): Merge conflict in drivers/tty/serial/sc16is7xx.c
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (34b82a2fb747 lkdtm/bugs: In lkdtm_HUNG_TASK() u=
se BUG(), not BUG_ON(1))
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/fHYcPvJ4gDVBzdaHdyO9Qma
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW3G9YACgkQAVBC80lX
0GwTUwf/QRvHNhGjsNkna4u3G2tGq3jUG5mxd0TNHNtu8Ojq5qI8GU2kiwoJEBEy
h8nzPciZ+iA1+xxYSVsNBcRwfS/oyYhvnt8Sj/Wl7ZMBK2H3J5MXWpNa48uPl7LY
iwcyiafnnMF2msiTUg80dmpJ997I4QGRhczuehnxj3rMEvaJ/ejDMvovjqd7vHa5
qlsMsq/mr8erAn5cBppMhZAFJq86U5Aor9xAd85zxLrH6CimRy8u8r08hQw9yhaU
fiDyOtr9490AwjwXsIHh76hD0qKKnMNbA6mgc9pnO/oq2znr0PM0HgV9Y+iaUF6U
T7i4y5MDw2POseUx3BMAO1AhwNdcYA==
=nEdi
-----END PGP SIGNATURE-----

--Sig_/fHYcPvJ4gDVBzdaHdyO9Qma--

