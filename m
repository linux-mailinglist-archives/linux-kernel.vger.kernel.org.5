Return-Path: <linux-kernel+bounces-87944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0209A86DB51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80128283802
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075853375;
	Fri,  1 Mar 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MLBEfJnC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2851C2B;
	Fri,  1 Mar 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709272635; cv=none; b=d0Qzukb4I1lxyvG4Twxg8sxKqDF+Rqtmd8t3oTA9Q6/4GFhZpwTKl8zq7yO93VJ81VDNx0BfRfuexrWu8MWWL268CgMmkHKFoDiElS9+/N1yuEUAN9nnElR1Xr4MET5FEePeuUpRcJFklFt4KpNQtarVKNV84zskJbUvJV+RhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709272635; c=relaxed/simple;
	bh=y76zfICqFwAZw1iQ59HfIn2/iMdt9SwMVd0DEKWPYGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V1tXVCZbEIvDJsS2d3XJoM4VoUoiJ4gwMo1szrsq8oTZr//UGAEJ6UAKsHaT0NFwdQVfZzYg5z1FqbqxKb/153Q0qVnb4WtbsL7OdRh2XI3lbVHSu4XsVVzRqt4tBuTcU3j2e9siK4hTqGLShneGqIo9q8A0VsY7tdEtH3aU8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MLBEfJnC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709272628;
	bh=LXo2J0oV9enYrKFsII3ETyaS65GW1aGsOtje5gvDfoo=;
	h=Date:From:To:Cc:Subject:From;
	b=MLBEfJnCR1iMufMX7bLBJwp0+VUQ0VFRuCenE/ejzdxBzwcFRPQcM55hHLYL9wmF+
	 8mF/e6jYIS/PMyljUniKr/UEbU/kQl0ZlprqcePfDDxSiVXYyKj3vWEDePHRSF7RKo
	 tSv/pUBr+vK/a1dLB48c6sbyNDD+T3RkMH/8Ik0or2B+aNpdwtQuyCnvPUtUJx6On9
	 zAP9N4bhi3tu+T2lDzgzJfp0o5DBkVssRVtfTKRgQHCu/xFXNXHzcCBykdM0EXOJDo
	 CRJaXFlRWsqpbl1WHNT3cOAuGhA8VeMD/fWTWg7q0Xvb3aNYMyecYFT+vc9DhBYB6Y
	 PvqJMFtDpDTYQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmHRS0J7qz4wc1;
	Fri,  1 Mar 2024 16:57:08 +1100 (AEDT)
Date: Fri, 1 Mar 2024 16:57:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 1
Message-ID: <20240301165705.07d9b52c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4QfZLql3FfNzC2VY=bwQagC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4QfZLql3FfNzC2VY=bwQagC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240229:

The next-next tree gained a build failure for which I reverted a commit.

The backlight tree still had its build failure so I used the version from
next-20240223.

The drivers-x86 tree gained a conflict against Linus' tree.

The vhost tree lost its build failure.

The rust tree gained conflicts against the arm64 and mm-nonmm-stable trees.

The kspp tree gained a conflict against the bcachefs tree.

Non-merge commits (relative to Linus' tree): 10280
 9413 files changed, 468452 insertions(+), 182714 deletions(-)

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

I am currently merging 369 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (87adedeba51a Merge tag 'net-6.8-rc7' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (adc20ebbeac5 mailmap: fix Kishon'=
s email)
Merging kbuild-current/fixes (b401b621758e Linux 6.8-rc5)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (6613476e225e Linux 6.8-rc1)
Merging arm64-fixes/for-next/fixes (d7b77a0d565b arm64/sme: Restore SMCR_EL=
1.EZT0 on exit from suspend)
Merging arm-soc-fixes/arm/fixes (dcb8e53e339e Merge tag 'renesas-fixes-for-=
v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel into arm/fixes)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging sophgo-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (fad87dbd4815 powerpc/rtas: use correct functio=
n name for resetting TCE tables)
Merging s390-fixes/fixes (5ef1dc40ffa6 s390/cio: fix invalid -EBUSY on ccw_=
device_start)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (640f41ed33b5 dpll: fix build failure due to rcu_dereferen=
ce_check() on unknown type)
Merging bpf/master (dced881ead78 Merge branch 'check-bpf_func_state-callbac=
k_depth-when-pruning-states')
Merging ipsec/master (1a807e46aa93 xfrm: Avoid clang fortify warning in cop=
y_to_user_tmpl())
Merging netfilter/main (6523cf516c55 selftests: netfilter: add bridge connt=
rack + multicast test case)
Merging ipvs/main (40b9385dd8e6 enic: Avoid false positive under FORTIFY_SO=
URCE)
Merging wireless/for-next (413dafc8170f wifi: mac80211: only call drv_sta_r=
c_update for uploaded stations)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (eb5c7465c324 RDMA/srpt: fix function pointer cas=
t warnings)
Merging sound-current/for-linus (17c6a0c986fb Merge tag 'asoc-fix-v6.8-rc5'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (f8b0127aca8c ASoC: Intel: bytcr_rt5640:=
 Add an extra entry for the Chuwi Vi8 tablet)
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (e5d40e9afd84 regulator: max5970: Fix reg=
ulator child node name)
Merging spi-fixes/for-linus (6415c7fe7cf4 spi: Drop mismerged fix)
Merging pci-current/for-linus (6613476e225e Linux 6.8-rc1)
Merging driver-core.current/driver-core-linus (b401b621758e Linux 6.8-rc5)
Merging tty.current/tty-linus (d206a76d7d27 Linux 6.8-rc6)
Merging usb.current/usb-linus (d206a76d7d27 Linux 6.8-rc6)
Merging usb-serial-fixes/usb-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging phy/fixes (d4c08d8b23b2 phy: qcom-qmp-usb: fix v3 offsets data)
Merging staging.current/staging-linus (6613476e225e Linux 6.8-rc1)
Merging iio-fixes/fixes-togreg (11dadb631007 iio: accel: adxl367: fix I2C F=
IFO data register)
Merging counter-current/counter-current (c83ccdc9586b counter: fix privdata=
 alignment)
Merging char-misc.current/char-misc-linus (daaf5286b6d2 mei: Add Meteor Lak=
e support for IVSC device)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (d3d17e23d1a0 thunderbolt: Fix NULL pointer=
 dereference in tb_port_update_credits())
Merging input-current/for-linus (4255447ad34c Input: i8042 - add Fujitsu Li=
febook U728 to i8042 quirk table)
Merging crypto-current/master (183420038444 crypto: sun8i-ce - Fix use afte=
r free in unprepare)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b54761f6e977 kselftest/seccomp: Report each =
expectation we assert as a KTAP test)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (df2515a17914 dmaengine: ptdma: use consisten=
t DMA masks)
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
Merging kvm-fixes/master (5ef1d8c1ddbf KVM: SVM: Flush pages under kvm->loc=
k to fix UAF in svm_register_enc_region())
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
Merging drivers-x86-fixes/fixes (427c70dec738 platform/x86: thinkpad_acpi: =
Only update profile if successfully converted)
Merging samsung-krzk-fixes/fixes (eab4f56d3e75 ARM: dts: exynos4212-tab3: a=
dd samsung,invert-vclk flag to fimd)
Merging pinctrl-samsung-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging devicetree-fixes/dt/linus (4e06ec0774f5 dt-bindings: ufs: samsung,e=
xynos-ufs: Add size constraints on "samsung,sysreg")
Merging dt-krzk-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging scsi-fixes/fixes (ee0017c3ed8a scsi: mpt3sas: Prevent sending diag_=
reset when the controller is ready)
Merging drm-fixes/drm-fixes (d206a76d7d27 Linux 6.8-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (01bb1ae35006 drm/i915: Check =
before removing mm notifier)
Merging mmc-fixes/fixes (09e23823ae9a mmc: sdhci-xenon: add timeout for PHY=
 init complete)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (a11dd49dcb93 riscv: Sparse-Memory/vmemmap out-o=
f-bounds fix)
Merging riscv-dt-fixes/riscv-dt-fixes (ce6b6d151396 riscv: dts: sifive: add=
 missing #interrupt-cells to pmic)
Merging riscv-soc-fixes/riscv-soc-fixes (d206a76d7d27 Linux 6.8-rc6)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (6613476e225e Linux 6.8-rc1)
Merging gpio-brgl-fixes/gpio/for-current (ae366ba8576d gpiolib: Handle no p=
in_ranges in gpiochip_generic_config())
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging auxdisplay-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (56ee7db31187 erofs: fix refcount on the metabuf =
used for inode lookup)
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
Merging iommufd-fixes/for-rc (510325e5ac5f selftests/iommu: fix the config =
fragment)
Merging rust-fixes/rust-fixes (b401b621758e Linux 6.8-rc5)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (2a93c6cbd5a7 pmdomain: qcom: rpmhpd: Fix enab=
led_corner aggregation)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (cf8281b1aeab i2c: imx: when bein=
g a target, mark the last read as processed)
Merging drm-misc-fixes/for-linux-next-fixes (c70703320e55 drm/tests/drm_bud=
dy: add alloc_range_bias test)
Applying: drm/tests/buddy: fix print format
Merging mm-stable/mm-stable (c44ed5b7596f writeback: remove a use of write_=
cache_pages() from do_writepages())
Merging mm-nonmm-stable/mm-nonmm-stable (2932fb0a927d list: leverage list_i=
s_head() for list_entry_is_head())
CONFLICT (content): Merge conflict in arch/riscv/include/asm/ftrace.h
Merging mm/mm-everything (3bc02e1b9746 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (5270316c9fec kbuild: Use -fmin-function-alignment =
when available)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (ef5de1613d7d perf pmu: Fix a potential memory=
 leak in perf_pmu__lookup())
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (b9fa16949d18 dma-direct: Leak pages on dma_se=
t_decrypted() failure)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (b9920fdd5a75 ARM: 9352/1: iwmmxt: Remove support for =
PJ4/PJ4B cores)
Merging arm64/for-next/core (46bff2a4b205 Merge branch 'for-next/misc' into=
 for-next/core)
Merging arm-perf/for-next/perf (fd185a245155 perf/arm_cspmu: Add devicetree=
 support)
Merging arm-soc/for-next (c6e9e225d498 soc: document merges)
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
Merging mvebu/for-next (33649b804911 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (bf3ab90b6b4e Merge branch 'omap-for-v6.9/soc' into f=
or-next)
Merging qcom/for-next (f6265e31fc71 Merge branches 'arm32-for-6.9', 'arm64-=
defconfig-for-6.9', 'arm64-fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' a=
nd 'drivers-for-6.9' into for-next)
Merging renesas/next (06a019816e51 Merge branch 'renesas-dts-for-v6.9' into=
 renesas-next)
Merging reset/reset/next (c721f189e89c reset: Instantiate reset GPIO contro=
ller for shared reset-gpios)
Merging rockchip/for-next (fd72b744c3fa Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (8b9d2e71b42c Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (a2b8119375a1 Merge tags 'vexpress-update-6.9',=
 'ffa-update-6.9' and 'scmi-updates-6.9' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (0f46e1339ef1 MAINTAINERS: Setup proper info for SO=
PHGO vendor support)
Merging stm32/stm32-next (a7b9ab6c880d arm64: dts: st: add video encoder su=
pport to stm32mp255)
Merging sunxi/sunxi/for-next (c1d7282e4e92 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (58ea7e692a9e Merge branch 'tee_bus_type_for_v6.9' into ne=
xt)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (68818060efdb Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (bf11aa74218c Merge branch 'clk-devm' into clk-next)
Merging clk-imx/for-next (13269dc6c704 clk: imx: imx8mp: Fix SAI_MCLK_SEL d=
efinition)
Merging clk-renesas/renesas-clk (81a7a88a9806 clk: renesas: r8a779h0: Add R=
PC-IF clock)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (a6be9b65a61e LoongArch: Add kernel livepa=
tching support)
CONFLICT (content): Merge conflict in arch/loongarch/Makefile
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (b401b621758e Linux 6.8-rc5)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (af43e871c936 MIPS: mipsregs: Parse fp and sp regist=
er by name in parse_r)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (0568b6f0d863 parisc: Strip upper 32 bit of sum =
in csum_ipv6_magic for 64-bit builds)
Merging powerpc/next (cb615bbe5526 powerpc/32: fix ADB_CUDA kconfig warning)
CONFLICT (content): Merge conflict in arch/powerpc/mm/pgtable_32.c
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (886516fae2b7 RISC-V: fix check for zvkb with tip-o=
f-tree clang)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (d0653996b7ea dt-bindings: pwm: opencore=
s: Add compatible for StarFive JH8100)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (6a42aaf8e867 Merge branch 'features' into for-next)
Merging sh/for-next (0a2d3ce0031f sh: hd64461: Make setup_hd64461 static)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (7ab7acb68adf xtensa: fix MAKE_PC_FROM_RA se=
cond argument)
Merging bcachefs/for-next (5623a6d19a76 bcachefs: Buffered write path now c=
an avoid the inode lock)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (2653677ec901 Merge branch 'for-next-next-v6.8-20240=
222' into for-next-20240222)
Merging ceph/master (51d31149a88b ceph: switch to corrected encoding of max=
_xattr_size in mdsmap)
Merging cifs/for-next (ac79e0d1b4d4 cifs: update internal module version nu=
mber for cifs.ko)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (b401b621758e Linux 6.8-rc5)
Merging exfat/dev (f3cb82f5008f exfat: remove SLAB_MEM_SPREAD flag usage)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (21fea055bb74 Pull UDF mount API conversion)
Merging ext4/dev (1f85b452e07c ext4: verify s_clusters_per_group even witho=
ut bigalloc)
Merging f2fs/dev (80d3964e8874 f2fs: allow to mount if cap is 100)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (3474d2f1d4b4 virtiofs: drop __exit from virtio_fs_sy=
sfs_exit())
CONFLICT (content): Merge conflict in fs/fuse/inode.c
Merging gfs2/for-next (6b89b6af459f Merge tag 'gfs2-v6.8-rc2-revert' of git=
://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (342c3b87c95b ksmbd: retrieve number of blocks=
 using vfs_getattr in set_file_allocation_info)
Merging nfs/linux-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (26102396d4e0 NFSD: Document nfsd_setattr() fill-att=
ributes behavior)
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (3ce485803da1 mtd: ubi: provide NVMEM layer over UBI vol=
umes)
Merging v9fs/9p-next (be3193e58ec2 9p: Fix read/write debug statements to r=
eport server reply)
Merging v9fs-ericvh/ericvh/for-next (be57855f5050 fs/9p: fix dups even in u=
ncached mode)
Merging xfs/for-next (601f8bc2440a Merge tag 'xfs-6.8-fixes-4' into xfs-for=
-next)
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
Merging vfs-brauner/vfs.all (df619d9f2c48 Merge branch 'vfs.uuid' into vfs.=
all)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
CONFLICT (content): Merge conflict in fs/nfsd/nfs4layouts.c
CONFLICT (content): Merge conflict in fs/smb/client/file.c
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
CONFLICT (content): Merge conflict in init/main.c
Applying: fixup for "filelock: split common fields into struct file_lock_co=
re"
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (e7081d5a9d97 Merge branch 'rework/console-flushing=
-fixes' into for-next)
Merging pci/next (a66f2b4a4d36 Merge branch 'pci/qcom')
Merging pstore/for-next/pstore (98bc7e26e14f pstore/zone: Add a null pointe=
r check to the psz_kmsg_read)
Merging hid/for-next (f0cd2e82460c Merge branch 'for-6.9/amd-sfh' into for-=
next)
Merging i2c/i2c/for-next (d206a76d7d27 Linux 6.8-rc6)
Merging i2c-host/i2c/i2c-host (197ecadad842 i2c: designware: Implement gene=
ric polling mode code for Wangxun 10Gb NIC)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (5b1d7a0f904b hwmon: (sis5595) drop unused=
 DIV_TO_REG function)
Merging jc_docs/docs-next (fe2562582bff docs: Restore "smart quotes" for qu=
otes)
Merging v4l-dvb/master (8c64f4cdf4e6 media: edia: dvbdev: fix a use-after-f=
ree)
  87f7f576e3d8 ("media: arm64: dts: st: add video encoder support to stm32m=
p255")
  d96a6119e332 ("media: arm64: dts: st: add video decoder support to stm32m=
p255")
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging v4l-dvb-next/master (e0b8eb0f6d65 media: visl: Add codec specific v=
ariability on output frames)
Merging pm/linux-next (07a90c3d9150 Merge branches 'acpi-resource', 'acpi-m=
isc' and 'acpi-apei' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (3093fa33539b cpufreq: qcom-hw: =
add CONFIG_COMMON_CLK dependency)
Merging cpupower/cpupower (babb46746cc5 Fix cpupower-frequency-info.1 man p=
age typo)
Merging devfreq/devfreq-next (b401b621758e Linux 6.8-rc5)
Merging pmdomain/next (04581ea2b237 pmdomain: Merge branch fixes into next)
Merging opp/opp/linux-next (ace4b31b297d cpufreq: Move dev_pm_opp_{init|fre=
e}_cpufreq_table() to pm_opp.h)
Merging thermal/thermal/linux-next (9ac53d5532cc thermal/drivers/sun8i: Don=
't fail probe due to zone registration failure)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (14b526f55ba5 RDMA/uverbs: Remove flexible arrays fro=
m struct *_filter)
Merging net-next/main (65f5dd4f02a8 Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/netdev/net)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mvm.h
Applying: Revert "tcp: remove some holes in struct tcp_sock"
Merging bpf-next/for-next (0270d69121ba Merge branch 'create-shadow-types-f=
or-struct_ops-maps-in-skeletons')
Merging ipsec-next/master (aceb147b20a2 xfrm: Do not allocate stats in the =
driver)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (a4634aa71fee bonding: rate-limit bonding drive=
r inspect messages)
Merging ipvs-next/main (26f4dac11775 netfilter: x_tables: Use unsafe_memcpy=
() for 0-sized destination)
Merging bluetooth/master (57a12da5c1b7 Bluetooth: btrtl: fix out of bounds =
memory access)
Merging wireless-next/for-next (416eb60317c6 bitfield: suppress "dubious: x=
 & !y" sparse warning)
Merging wpan-next/master (42683294cc0a ieee802154: ca8210: Drop spurious WQ=
_UNBOUND from alloc_ordered_workqueue() call)
Merging wpan-staging/staging (42683294cc0a ieee802154: ca8210: Drop spuriou=
s WQ_UNBOUND from alloc_ordered_workqueue() call)
Merging mtd/mtd/next (77bf03252839 mtd: Remove support for Carillo Ranch dr=
iver)
Merging nand/nand/next (65a7f244b156 mtd: rawnand: hynix: remove @nand_tech=
nology kernel-doc description)
Merging spi-nor/spi-nor/next (6a9eda34418f mtd: spi-nor: core: set mtd->era=
seregions for non-uniform erase map)
Merging crypto/master (a24e3b583ea2 crypto: rockchip - fix to check return =
value)
Merging drm/drm-next (ca7a1d0d18ac Merge tag 'drm-intel-next-2024-02-27-1' =
of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
_hdcp.c
Applying: drm/i915: fix applying placement flag
Merging drm-exynos/for-linux-next (40d47c5fb4f2 Merge tag 'amd-drm-next-6.9=
-2024-02-19' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-misc/for-linux-next (9cb3542aeeac drm/imx/dcss: fix resource si=
ze calculation)
Merging amdgpu/drm-next (1761d9a688ba amd/amdkfd: remove unused parameter)
Merging drm-intel/for-linux-next (12531c8c0a37 drm/i915: Simplify aux_ch_to=
_digital_port())
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (18397519cb62 drm/msm/adreno: Add A702 support)
Merging drm-msm-lumag/msm-next-lumag (e3b1f369db5a drm/msm/dpu: Add X1E8010=
0 support)
Merging drm-xe/drm-xe-next (b9b7db490892 drm/xe: Add LRC parsing for more G=
PU instructions)
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (62861ddcb27e Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (7dba48a474e6 ALSA: control_led: Use guard() for loc=
king)
Merging ieee1394/for-next (41ebb53b1bff firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (61e90a2095cf Merge remote-tracking branch 'aso=
c/for-6.9' into asoc-next)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (d03f030115fe Input: gameport - make gameport_bus const)
Merging block/for-next (0e6bdcf9a83d Merge branch 'for-6.9/block' into for-=
next)
CONFLICT (content): Merge conflict in block/blk.h
CONFLICT (content): Merge conflict in include/linux/sched.h
Merging device-mapper/for-next (6006301c6a83 Merge branch 'dm-6.8' into for=
-next)
Merging libata/for-next (c1bc6ed01c16 Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (1bec7691b327 pcmcia: ds: make pcmcia_bus_type c=
onst)
Merging mmc/next (6e860b05a0cb mmc: Merge branch fixes into next)
CONFLICT (content): Merge conflict in drivers/mmc/core/queue.c
Merging mfd/for-mfd-next (ec0131916367 dt-bindings: mfd: Convert atmel-flex=
com to json-schema)
Merging backlight/for-backlight-next (3c40590fafd4 backlight: lm3630a: Use =
backlight_get_brightness helper in update_status)
$ git reset --hard HEAD^
Merging next-20240223 version of backlight
Merging battery/for-next (9a451f1b028e power: supply: bq2415x_charger: repo=
rt online status)
Merging regulator/for-next (65e49e977035 Merge remote-tracking branch 'regu=
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
Merging tpmdd/next (27eaacc62ade tpm: tis_i2c: Add compatible string nuvoto=
n,npct75x)
Merging watchdog/master (41bccc98fb79 Linux 6.8-rc2)
Merging iommu/next (43400fa1ca4c Merge branches 'iommu/fixes', 'arm/mediate=
k', 'arm/renesas', 'x86/amd' and 'core' into next)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (1447c13051c7 dt-bindings: lcdif: Do not requir=
e power-domains for i.MX6ULL)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/tri=
vial-devices.yaml
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (bf790d87088a Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (0398d5b4e81a Merge branch into tip/master: 'x86/tdx')
CONFLICT (content): Merge conflict in kernel/workqueue.c
Merging clockevents/timers/drivers/next (c819dbd07832 dt-bindings: timer: A=
dd support for cadence TTC PWM)
Merging edac/edac-for-next (3513ecaa685c Merge ras/edac-amd-atl into for-ne=
xt)
CONFLICT (content): Merge conflict in Documentation/index.rst
Applying: fix up for "RAS: Introduce AMD Address Translation Library"
Merging ftrace/for-next (a641f0533adb tracing: Decrement the snapshot if th=
e snapshot trigger fails to register)
Merging rcu/rcu/next (87c256b5ce36 rcu: Add lockdep checks and kernel-doc h=
eader to rcu_softirq_qs())
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
Merging kvm/next (0cbca1bf44a0 x86: irq: unconditionally define KVM interru=
pt vectors)
CONFLICT (content): Merge conflict in arch/loongarch/Kconfig
Merging kvm-arm/next (16d120d23aad Merge branch kvm-arm64/misc into kvmarm/=
next)
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Applying: fix up for "arm64/sysreg: Add register fields for ID_AA64DFR1_EL1"
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (f072b272aa27 RISC-V: KVM: Use correct res=
tricted types)
Merging kvm-x86/next (6a108bdc4913 Merge branch 'xen')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/sev.c
Merging xen-tip/linux-next (fa765c4b4aed xen/events: close evtchn after map=
ping cleanup)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (b111131e3ec7 Merge branch 'for-6.9' into for-n=
ext)
Merging drivers-x86/for-next (36c45cfc5cb3 platform/x86: intel_scu_ipcutil:=
 Make scu static)
CONFLICT (content): Merge conflict in drivers/platform/x86/amd/pmf/tee-if.c
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (8a0a62941a04 firmware: =
coreboot: Replace tag with id table in driver struct)
Merging hsi/for-next (3693760295e8 HSI: ssi_protocol: fix struct members ke=
rnel-doc warnings)
Merging leds-lj/for-leds-next (3e7b2b9309cd leds: sgm3140: Add missing time=
r cleanup and flash gpio control)
CONFLICT (content): Merge conflict in drivers/leds/flash/Kconfig
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (01aacda0b10e Merge tag 'sysfs_hidden_=
attribute_groups-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/=
gregkh/driver-core into driver-core-next)
Merging usb/usb-next (a560a5672826 Merge v6.8-rc6 into usb-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/reg=
ulator/qcom,usb-vbus-regulator.yaml
Merging thunderbolt/next (b8a730836c6b thunderbolt: Constify the struct dev=
ice_type usage)
Merging usb-serial/usb-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging tty/tty-next (13a44ba0dca8 Merge 6.8-rc6 into tty-next)
Merging char-misc/char-misc-next (d4551c189d6e Merge tag 'iio-for-6.9a' of =
http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-nex=
t)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (a4f3057d19ff coresight-tpda: Change qcom,dsb-elemen=
t-size to qcom,dsb-elem-bits)
Merging fastrpc/for-next (5169a077f22a misc: fastrpc: Pass proper arguments=
 to scm call)
Merging fpga/for-next (b1a91ca25f15 fpga: remove redundant checks for bridg=
e ops)
Merging icc/icc-next (d1c16491134c Merge branch 'icc-sm7150' into icc-next)
Merging iio/togreg (b3ac08486714 Merge branch 'togreg-cleanup' into togreg)
Merging phy-next/next (00ca8a15dafa phy: constify of_phandle_args in xlate)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
c
Merging soundwire/next (81a7d0c4d059 soundwire: bus_type: make sdw_bus_type=
 const)
Merging extcon/extcon-next (16c6e3aff8d7 extcon: intel-mrfld: Don't shadow =
error from devm_extcon_dev_allocate())
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (701ab935859f vfio/nvgrace-gpu: Add vfio pci variant modu=
le for grace hopper)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging w1/for-next (d97d263132a6 w1: w1-gpio: Convert to platform remove c=
allback returning void)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (455c5e12a3b7 staging: gdm724x: constantify th=
e struct device_type usage)
Merging counter-next/counter-next (3bb282ef1149 counter: constify the struc=
t device_type usage)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (716141d366f4 dmaengine: of: constify of_phandle_arg=
s in of_dma_find_controller())
Merging cgroup/for-next (13eb1d6e1cfc Merge branch 'for-6.8-fixes' into for=
-next)
Merging scsi/for-next (7b020ab8a009 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (b914227e4215 Merge patch series "Pass data lifet=
ime information to SCSI disk devices")
CONFLICT (content): Merge conflict in fs/iomap/buffered-io.c
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vhost/linux-next (ac20046227aa virtio-net: add cond_resched() to th=
e command waiting loop)
Merging rpmsg/for-next (4789630c555f Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
CONFLICT (content): Merge conflict in drivers/remoteproc/imx_dsp_rproc.c
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (90680213a662 gpiolib: Fix the error path o=
rder in gpiochip_add_data_with_key())
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (c041b1b66c2f Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (a6f06b909fee pinctrl: renesas: All=
ow the compiler to optimize away sh_pfc_pm)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (9e3440d2d57b pwm: dwc: simplify error handling)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (539cd3f4da3f selftests: lib.mk: Do not process TEST=
_GEN_MODS_DIR)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (806cb2270237 kunit: Annotate _MSG assertion varia=
nts with gnu printf specifiers)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (c12e67e076cb rtc: max31335: fix interrupt status reg)
Merging nvdimm/libnvdimm-for-next (bc22374c96d9 device-dax: make dax_bus_ty=
pe const)
Merging at24/at24/for-next (6613476e225e Linux 6.8-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (56af94aace8a samples: user-trap: fix stri=
ct-aliasing warning)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (6e8ba95e17ee slimbus: core: Remove usage of the d=
eprecated ida_simple_xx() API)
Merging nvmem/for-next (6b475e23544a nvmem: meson-efuse: fix function point=
er type mismatch)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/for-next (a9bcd02fa422 auxdisplay: Add driver for MAX695=
x 7-segment LED controllers)
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
Merging efi/next (841c35169323 Linux 6.8-rc4)
Merging unicode/for-next (101c3fad29d7 libfs: Drop generic_set_encrypted_ci=
_d_ops)
Merging slab/slab/for-next (e3757988c829 Merge branch 'slab/for-6.9/slab-fl=
ag-cleanups' into slab/for-next)
Merging random/master (1f719a2f3fa6 Merge tag 'net-6.8-rc4' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging landlock/next (bdbf17bc7d65 landlock: Document IOCTL support)
Merging rust/rust-next (768409cff6cc rust: upgrade to Rust 1.76.0)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
CONFLICT (content): Merge conflict in rust/Makefile
Merging sysctl/sysctl-next (4f1136a55dc8 scripts: check-sysctl-docs: handle=
 per-namespace sysctls)
Merging execve/for-next/execve (d3f0d7bbaefd exec: Delete unnecessary state=
ments in remove_arg_zero())
Merging bitmap/bitmap-for-next (fd8ed16c2419 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (64ae6a89e868 string: Convert helpers selftest t=
o KUnit)
CONFLICT (content): Merge conflict in lib/Makefile
CONFLICT (content): Merge conflict in scripts/Makefile.lib
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/4QfZLql3FfNzC2VY=bwQagC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhbjEACgkQAVBC80lX
0GyNogf+PnCll5PTndAGPCWXczG5LfMmn6gO0XQULNyzroagAYeWqUvsGshXNzHS
gWU2xMUj56HEpI7Gt3QA31WrDbBzWh5EBE/UmjscRdlMcyELNUswH2PCtPQOmmwl
mel6A16i3r+/3wD4bYMwSm7KhIuxFezcvUxxRwtGe9bfO0FhRAH8waW1xsOU6Y/Q
fOnahBG27K2ZLDfM2U+DaPyZVZenbPg2oQ3YEceikg+dNgnFc4JYms4rh7RsMoVd
P0GCmViBrAxihedk4NiD5alGxmO7QSMyvwkna2tPiYhDQLi0BfF1uh1AZsMCB3VW
0BsrSat6dHZqbsmeTbN4TUi40rLg9w==
=TIFK
-----END PGP SIGNATURE-----

--Sig_/4QfZLql3FfNzC2VY=bwQagC--

