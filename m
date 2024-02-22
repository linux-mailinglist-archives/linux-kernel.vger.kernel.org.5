Return-Path: <linux-kernel+bounces-76444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B285F76F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E304D1C234BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42247A48;
	Thu, 22 Feb 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g/ftCxnW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4140BFE;
	Thu, 22 Feb 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602593; cv=none; b=PUiJpAiQ16fw6dk3/F9LExl51JKl3d4skxIzFKn+ZXOEdCPhhZhJT+u2J9SG1L+R9aJO3p8ZUya+fz0T8pPX1cK5oeewbdBuHNwtoj0y4FA/hImdBKfMCPGq28o1OLsIoIT+b1U34GOi8gPqQm3BXdj3pJsrHmpgIisacS4nVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602593; c=relaxed/simple;
	bh=0tHsRQRswrfwbHOGlsXKymgvk78DykiKfcFpHPLVFL0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ck8CVWQRXG7/Q89qb2LzBP5L0hbEhcqLto2qF7IBDEZfEILqHxeTfsK2O7x14Fmwk/VYMJPwlD33479VgX1oRnd0BWQg7x92s22nkBpWtD+05MaDsNminICc71mKvJQHpSKXQ2HJsD4Lq4FEyBupDMOZfKaReHrXFBsl5Mn215c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=g/ftCxnW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708602570;
	bh=eJKMj9MzAx/UPAddmEHRKx4nv0dwOyk4fX0en+a1XB4=;
	h=Date:From:To:Cc:Subject:From;
	b=g/ftCxnWPtp08QKaeVRaWn/6wGNU39/8zanGEVZQmCOTgt/fOSC0tnIWXre/EtZkd
	 TUKTRPzp83TLLa0AtWozkD4rfjQ1/gRR3YAefZRVfENPxU3EWPVvTYNpFgmO4+Ywbu
	 JdCsqgSktr5oGEDIra1GzNKb1bHohUr6QehdXkbdB33//UuNmtk5AtDRvLJlY8fieh
	 +5f5Ut6z71aggjDyj3BCmU+qqYSSAMCZTmziWZRhHqgs2JC/7ak1IV/L+lXeHMlr0E
	 UDvZ0iSMO7/uGD3ni89ciPu5/4tdTwjZCjTRg0Amk9Aq8B1BfqMN2VQ0W8JXrm9abd
	 fAgciLdFYPNBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgWdk053Gz4wcL;
	Thu, 22 Feb 2024 22:49:29 +1100 (AEDT)
Date: Thu, 22 Feb 2024 22:49:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 22
Message-ID: <20240222224929.57c7d3ae@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oSDi4WtdvNsW35yRD/G1AZC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oSDi4WtdvNsW35yRD/G1AZC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240221:

New tree: drm-xe

The perf tree gained a build failure so I used the version from
next-20240221.

The drm-misc tree gained a build failure so I used the version from
next-20240221.

The drm-xe tree gained a build failure for which I reverted 3 commits.

The edac tree gained a conflict against the jc_docs tree.

The kvm tree gained a conflict against the drm-xe tree.

The merge of the kvm-arm tree caused a build failure due to an interaction
with the arm64 tree for which I applied a merge fix patch.

The usb tree gained a conflict against the regulator tree.

The kspp tree gained a conflict against the mm tree.

Non-merge commits (relative to Linus' tree): 8294
 7797 files changed, 362875 insertions(+), 150264 deletions(-)

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

I am currently merging 370 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (39133352cbed Merge tag 'for-linus' of git://git.kern=
el.org/pub/scm/virt/kvm/kvm)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (262ee4198b24 mm, vmscan: prevent =
infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations)
Merging kbuild-current/fixes (b401b621758e Linux 6.8-rc5)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (d7b77a0d565b arm64/sme: Restore SMCR_EL=
1.EZT0 on exit from suspend)
Merging arm-soc-fixes/arm/fixes (704dccec0d49 arm64: dts: qcom: Fix interru=
pt-map cell sizes)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging sophgo-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (20c8c4dafe93 KVM: PPC: Book3S HV: Fix L2 guest=
 reboot failure due to empty 'arch_compat')
Merging s390-fixes/fixes (723a2cc8d69d s390: use the correct count for __io=
write64_copy())
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (14dec56fdd4c MAINTAINERS: Add framer headers to NETWORKIN=
G [GENERAL])
Merging bpf/master (4cd12c6065df bpf, sockmap: Fix NULL pointer dereference=
 in sk_psock_verdict_data_ready())
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (40b9385dd8e6 enic: Avoid false positive under FORTI=
FY_SOURCE)
Merging ipvs/main (40b9385dd8e6 enic: Avoid false positive under FORTIFY_SO=
URCE)
Merging wireless/for-next (1b7d9ab3e666 MAINTAINERS: wifi: Add N: ath1*k en=
tries to match .yaml files)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (eb5c7465c324 RDMA/srpt: fix function pointer cas=
t warnings)
Merging sound-current/for-linus (67c3d7717efb ALSA: hda/realtek: fix mute/m=
icmute LED For HP mt440)
Merging sound-asoc-fixes/for-linus (1382d8b55129 ASoC: qcom: Fix uninitiali=
zed pointer dmactl)
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (e5d40e9afd84 regulator: max5970: Fix reg=
ulator child node name)
Merging spi-fixes/for-linus (269e31aecdd0 spi-mxs: Fix chipselect glitch)
Merging pci-current/for-linus (6613476e225e Linux 6.8-rc1)
Merging driver-core.current/driver-core-linus (b401b621758e Linux 6.8-rc5)
Merging tty.current/tty-linus (3b69e32e151b serial: amba-pl011: Fix DMA tra=
nsmission in RS485 mode)
Merging usb.current/usb-linus (69f89168b310 usb: typec: tpcm: Fix issues wi=
th power being removed during reset)
Merging usb-serial-fixes/usb-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging phy/fixes (d4c08d8b23b2 phy: qcom-qmp-usb: fix v3 offsets data)
Merging staging.current/staging-linus (6613476e225e Linux 6.8-rc1)
Merging iio-fixes/fixes-togreg (78367c32bebf iio: adc: ad4130: only set GPI=
O_CTRL if pin is unused)
Merging counter-current/counter-current (c83ccdc9586b counter: fix privdata=
 alignment)
Merging char-misc.current/char-misc-linus (daaf5286b6d2 mei: Add Meteor Lak=
e support for IVSC device)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (d3d17e23d1a0 thunderbolt: Fix NULL pointer=
 dereference in tb_port_update_credits())
Merging input-current/for-linus (4255447ad34c Input: i8042 - add Fujitsu Li=
febook U728 to i8042 quirk table)
Merging crypto-current/master (c0ec2a712daf crypto: virtio/akcipher - Fix s=
tack overflow on memcpy)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b54761f6e977 kselftest/seccomp: Report each =
expectation we assert as a KTAP test)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (a79f949a5ce1 dmaengine: fsl-edma: correct ma=
x_segment_size setting)
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
Merging kvm-fixes/master (c48617fbbe83 Merge tag 'kvmarm-fixes-6.8-3' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (cf5ad17ee6a4 hwmon: (nct6775) Fix access to temp=
erature configuration registers)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (daeacfa75d08 Merge branch 'for-6.8/cxl-cper' into =
for-6.8/cxl)
Merging btrfs-fixes/next-fixes (eb90d142fc1b Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (2c88c16dc20e erofs: fix handling kern_mount() fail=
ure)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (1abdf288b0ef platform/x86: touchscreen_dmi=
: Add info for the TECLAST X16 Plus tablet)
Merging samsung-krzk-fixes/fixes (eab4f56d3e75 ARM: dts: exynos4212-tab3: a=
dd samsung,invert-vclk flag to fimd)
Merging pinctrl-samsung-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging devicetree-fixes/dt/linus (4e06ec0774f5 dt-bindings: ufs: samsung,e=
xynos-ufs: Add size constraints on "samsung,sysreg")
Merging dt-krzk-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging scsi-fixes/fixes (9ddf190a7df7 scsi: jazz_esp: Only build if SCSI c=
ore is builtin)
Merging drm-fixes/drm-fixes (b401b621758e Linux 6.8-rc5)
Merging drm-intel-fixes/for-linux-next-fixes (fb1e881273f4 drm/i915/tv: Fix=
 TV mode)
Merging mmc-fixes/fixes (6b1ba3f9040b mmc: mmci: stm32: fix DMA API overlap=
ping mappings warning)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (b4a5e636dd91 Merge patch series "RISC-V: Fix CO=
NFIG_AS_HAS_OPTION_ARCH with tip of tree LLVM")
  481860974faa ("tty: hvc: Don't enable the RISC-V SBI console by default")
Merging riscv-dt-fixes/riscv-dt-fixes (ce6b6d151396 riscv: dts: sifive: add=
 missing #interrupt-cells to pmic)
Merging riscv-soc-fixes/riscv-soc-fixes (bf456162601f Merge branches 'riscv=
-cache-fixes' and 'riscv-firmware-fixes' into riscv-soc-fixes)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (6613476e225e Linux 6.8-rc1)
Merging gpio-brgl-fixes/gpio/for-current (ae366ba8576d gpiolib: Handle no p=
in_ranges in gpiochip_generic_config())
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging auxdisplay-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (d9281660ff3f erofs: relaxed temporary buffers al=
location on readahead)
Merging kunit-fixes/kunit-fixes (4b758d70257d kunit: make kunit_bus_type co=
nst)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (6a9531c3a880 memblock: fix crash when reserve=
d memory is not added to memory)
Merging nfsd-fixes/nfsd-fixes (5ea9a7c5fe41 nfsd: don't take fi_lock in nfs=
d_break_deleg_cb())
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging perf-current/perf-tools (fdd0ae72b34e perf tools headers: update th=
e asm-generic/unaligned.h copy with the kernel sources)
Merging efi-fixes/urgent (e258b85f1c3c efivarfs: Request at most 512 bytes =
for variable names)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (2df70149e73e power: supply: bq27xxx-i2c: Do no=
t free non existing IRQ)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (7adc0c1cfa77 iommufd: Reject non-zero data_ty=
pe if no data_len is provided)
Merging rust-fixes/rust-fixes (b401b621758e Linux 6.8-rc5)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (eb5555d422d0 pmdomain: arm: Fix NULL derefere=
nce on scmi_perf_domain removal)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (eb9f7f654f25 i2c: i801: Fix bloc=
k process call transactions)
Merging drm-misc-fixes/for-linux-next-fixes (ed683b9bb91f sparc: Fix undefi=
ned reference to fb_is_primary_device)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tests/drm_buddy_test.c
Merging mm-stable/mm-stable (b401b621758e Linux 6.8-rc5)
Merging mm-nonmm-stable/mm-nonmm-stable (b401b621758e Linux 6.8-rc5)
Merging mm/mm-everything (cbe1db134989 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (ba3b759fb688 kconfig: lxdialog: fix cursor render =
in checklist)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (81377de00f11 perf list: For metricgroup only =
list include description)
$ git reset --hard HEAD^
Merging next-20240221 version of perf
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (8790fade1a19 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (a7434a69f872 Merge branches 'for-next/kselftes=
t', 'for-next/documentation' and 'for-next/sysreg' into for-next/core)
Merging arm-perf/for-next/perf (fd185a245155 perf/arm_cspmu: Add devicetree=
 support)
Merging arm-soc/for-next (37156e9b9974 soc: document merges)
Merging amlogic/for-next (15e1567404d7 Merge branch 'v6.9/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e60f7a99d378 ARM: dts: aspeed: minerva: add sgpio =
line name)
Merging at91/at91-next (859f600457cc Merge branch 'clk-microchip' into at91=
-next)
Merging broadcom/next (412c6bd2c649 Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (2f542c937c48 dt-bindings: memory-controlle=
rs: narrow regex for unit address to hex numbers)
Merging imx-mxs/for-next (d93b6c641bc9 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (ba90af39ba57 arm64: dts: mediatek: mt8183-pico6:=
 Fix wake-on-X event node names)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (0012c1958460 Merge branches 'sgx-for-v6.9' and 'omap=
-for-v6.9/soc' into for-next)
Merging qcom/for-next (f6265e31fc71 Merge branches 'arm32-for-6.9', 'arm64-=
defconfig-for-6.9', 'arm64-fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' a=
nd 'drivers-for-6.9' into for-next)
Merging renesas/next (8da5df713f13 Merge branch 'renesas-dts-for-v6.9' into=
 renesas-next)
Merging reset/reset/next (c721f189e89c reset: Instantiate reset GPIO contro=
ller for shared reset-gpios)
Merging rockchip/for-next (504c4c60e70b Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (d9e0e7c68345 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (f49191cdf834 Merge branches 'for-next/vexpress=
/updates', 'for-next/ffa/updates' and 'for-next/scmi/updates' of git://git.=
kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (41bccc98fb79 Linux 6.8-rc2)
Merging stm32/stm32-next (7fd195f01ae5 ARM: dts: stm32: lxa-tac: reduce RGM=
II interface drive strength)
Merging sunxi/sunxi/for-next (5db172482d9d Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (58ea7e692a9e Merge branch 'tee_bus_type_for_v6.9' into ne=
xt)
Merging tegra/for-next (fc9699999179 Merge branch for-6.8/arm64/dt into for=
-next)
Merging ti/ti-next (d4dca68e4b2c Merge branch 'ti-k3-config-next' into ti-n=
ext)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (efe5a1b888ab Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (6613476e225e Linux 6.8-rc1)
Merging clk-renesas/renesas-clk (81a7a88a9806 clk: renesas: r8a779h0: Add R=
PC-IF clock)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (8fb82f66d156 LoongArch: KVM: Streamline k=
vm_check_cpucfg() and improve comments)
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (b401b621758e Linux 6.8-rc5)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (3c35da51f77e MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE=
())
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (3a34e3fcdd83 parisc: Fix csum_ipv6_magic on 64-=
bit systems)
Merging powerpc/next (b22ea627225b powerpc/perf: Power11 Performance Monito=
ring support)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (cb4ede926134 riscv: Avoid code duplication with ge=
neric bitops implementation)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (5669bb5a16a0 riscv: dts: microchip: add=
 specific compatible for mpfs pdma)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (dca9f6083f5c Merge branch 'features' into for-next)
Merging sh/for-next (0a2d3ce0031f sh: hd64461: Make setup_hd64461 static)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (7ab7acb68adf xtensa: fix MAKE_PC_FROM_RA se=
cond argument)
Merging bcachefs/for-next (c887148ebf99 thread_with_file: add f_ops.flush)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (d3a7bd420076 fscrypt: clear keyring before callin=
g key_put())
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (d3cfdbb1ea50 Merge branch 'for-next-next-v6.8-20240=
213' into for-next-20240213)
Merging ceph/master (dbc347ef7f0c ceph: add ceph_cap_unlink_work to fire ch=
eck_caps() immediately)
Merging cifs/for-next (f4d3c180328f smb: client: retry compound request wit=
hout reusing lease)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (aa12a790d31b erofs: make erofs_{err,info}() support NULL=
 sb parameter)
Merging exfat/dev (3a7845041eb7 exfat: fix appending discontinuous clusters=
 to empty file)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (21fea055bb74 Pull UDF mount API conversion)
Merging ext4/dev (ec9d669eba4c ext4: make ext4_set_iomap() recognize IOMAP_=
DELALLOC map type)
Merging f2fs/dev (48238f7bb552 f2fs: introduce get_available_block_count() =
for cleanup)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (6b89b6af459f Merge tag 'gfs2-v6.8-rc2-revert' of git=
://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (b401b621758e Linux 6.8-rc5)
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
Merging ubifs/next (adbf4c4954e3 ubi: block: fix memleak in ubiblock_create=
())
Merging v9fs/9p-next (be3193e58ec2 9p: Fix read/write debug statements to r=
eport server reply)
Merging v9fs-ericvh/ericvh/for-next (be57855f5050 fs/9p: fix dups even in u=
ncached mode)
Merging xfs/for-next (7d5ba7ca6a45 xfs: use kvfree in xfs_ioc_getfsmap())
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
Merging vfs-brauner/vfs.all (e28390d0ee70 Merge branch 'vfs.uuid' into vfs.=
all)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
CONFLICT (content): Merge conflict in fs/nfsd/nfs4layouts.c
CONFLICT (content): Merge conflict in init/main.c
Applying: fixup for "filelock: split common fields into struct file_lock_co=
re"
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (e7081d5a9d97 Merge branch 'rework/console-flushing=
-fixes' into for-next)
Merging pci/next (5b52c9afa3dd Merge branch 'pci/misc')
Merging pstore/for-next/pstore (69f381e67d6f pstore/zone: Add a null pointe=
r check to the psz_kmsg_read)
Merging hid/for-next (8f0a3ff87887 Merge branch 'for-6.9/nintendo' into for=
-next)
Merging i2c/i2c/for-next (67ec505fae32 Merge tag 'i2c-host-fixes-6.8-rc5' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/f=
or-current)
Merging i2c-host/i2c/i2c-host (48acf8292280 i2c: Remove redundant compariso=
n in npcm_i2c_reg_slave)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (479e9bf3416a dt-bindings: hwmon: nuvoton,=
nct6775: Add compatible value for NCT6799)
Merging jc_docs/docs-next (32ed7930304c Merge branch 'docs-fixes' into docs=
-mw)
Merging v4l-dvb/master (8c64f4cdf4e6 media: edia: dvbdev: fix a use-after-f=
ree)
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging v4l-dvb-next/master (e0b8eb0f6d65 media: visl: Add codec specific v=
ariability on output frames)
Merging pm/linux-next (4cb5c331c4df Merge branch 'acpi-misc' into linux-nex=
t)
Merging cpufreq-arm/cpufreq/arm/linux-next (3093fa33539b cpufreq: qcom-hw: =
add CONFIG_COMMON_CLK dependency)
Merging cpupower/cpupower (babb46746cc5 Fix cpupower-frequency-info.1 man p=
age typo)
Merging devfreq/devfreq-next (b401b621758e Linux 6.8-rc5)
Merging pmdomain/next (713240877a26 pmdomain: renesas: Adjust the waiting t=
ime to cover the worst case)
Merging opp/opp/linux-next (ace4b31b297d cpufreq: Move dev_pm_opp_{init|fre=
e}_cpufreq_table() to pm_opp.h)
Merging thermal/thermal/linux-next (5314b1543787 thermal/drivers/exynos: Us=
e set_trips ops)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (aafe4cc50969 RDMA/rxe: Remove unused 'iova' paramete=
r from rxe_mr_init_user)
Merging net-next/main (26b2a265d888 Merge branch 'net-phy-marvell-88q2xxx-a=
dd-driver-for-the-marvell-88q2220-phy')
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mvm.h
Merging bpf-next/for-next (a3c70a3cf11e bpf: Shrink size of struct bpf_map/=
bpf_array.)
Merging ipsec-next/master (1476de6d2b57 xfrm: Simplify the allocation of sl=
ab caches in xfrm_policy_init)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (26f4dac11775 netfilter: x_tables: Use unsafe_m=
emcpy() for 0-sized destination)
Merging ipvs-next/main (26f4dac11775 netfilter: x_tables: Use unsafe_memcpy=
() for 0-sized destination)
Merging bluetooth/master (452481b004a5 Bluetooth: btintel: Print Firmware S=
equencer information)
Merging wireless-next/for-next (f3ec64394763 wifi: wilc1000: revert reset l=
ine logic flip)
Merging wpan-next/master (2373699560a7 mac802154: Avoid new associations wh=
ile disassociating)
Merging wpan-staging/staging (2373699560a7 mac802154: Avoid new association=
s while disassociating)
Merging mtd/mtd/next (18af7e357033 mtd: flashchip: explicitly include <linu=
x/wait.h>)
Merging nand/nand/next (4bd14b2fd8a8 mtd: spinand: esmt: Extend IDs to 5 by=
tes)
Merging spi-nor/spi-nor/next (3c0e1dfa703c MAINTAINERS: change my mail to t=
he kernel.org one)
Merging crypto/master (7d42e097607c crypto: qat - resolve race condition du=
ring AER recovery)
Merging drm/drm-next (9ac4beb7578a Merge tag 'drm-misc-next-2024-02-15' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/d=
cn21/dcn21_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/h=
w_sequencer_private.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/resour=
ce/dcn35/dcn35_resource.c
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (9ac4beb7578a Merge tag 'drm-misc-next-20=
24-02-15' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (583f2bdc8a44 MAINTAINERS: Create entry for=
 Renesas RZ DRM drivers)
Applying: drm/ttm: initialise places
$ git reset --hard HEAD^
Merging next-20240221 version of drm-misc
Applying: drm/ttm: initialise places
[master de3496e295dc] next-20240221/drm-misc
Merging amdgpu/drm-next (31e0a586f338 drm/amdgpu: add MMHUB 3.3.1 support)
Merging drm-intel/for-linux-next (bf7626f19d6f drm/i915/tv: Fix TV mode)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ffa0c87f172b drm/msm/mdp5: drop global_state_lock)
Merging drm-msm-lumag/msm-next-lumag (ffa0c87f172b drm/msm/mdp5: drop globa=
l_state_lock)
Merging drm-xe/drm-xe-next (6c36da2323f3 drm/xe: Implement VM snapshot supp=
ort for BO's and userptr)
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
Applying: Revert "drm/i915: Convert REG_GENMASK* to fixed-width GENMASK_*"
Applying: Revert "bits: Introduce fixed-type BIT"
Applying: Revert "bits: introduce fixed-type genmasks"
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (cfe1cab458f0 Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (3fdecc7d9aca Merge branch 'for-linus' into for-next)
Merging ieee1394/for-next (41ebb53b1bff firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (74caf2e40fd2 Merge remote-tracking branch 'aso=
c/for-6.9' into asoc-next)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (d03f030115fe Input: gameport - make gameport_bus const)
Merging block/for-next (40192a566897 Merge branch 'for-6.9/block' into for-=
next)
CONFLICT (content): Merge conflict in block/blk.h
CONFLICT (content): Merge conflict in include/linux/sched.h
Merging device-mapper/for-next (10e8baf7b3eb Merge branch 'dm-vdo-wip' into=
 for-next)
Merging libata/for-next (c1bc6ed01c16 Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (1bec7691b327 pcmcia: ds: make pcmcia_bus_type c=
onst)
Merging mmc/next (25e69172db8a mmc: davinci_mmc: Drop dangling variable)
CONFLICT (content): Merge conflict in drivers/mmc/core/queue.c
Merging mfd/for-mfd-next (d5132d176d6f mfd: rc5t583: Convert to use maple t=
ree register cache)
Merging backlight/for-backlight-next (770c0f4975fd dt-bindings: backlight: =
qcom-wled: Fix bouncing email addresses)
Merging battery/for-next (9e6047c01159 power: supply: axp288_fuel_gauge: De=
ny ROCK Pi X)
Merging regulator/for-next (78e0d079ab38 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (b6fc98c0707b Automated merge of 'dev' into 'next')
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (85445b964290 integrity: eliminate unneces=
sary "Problem loading X.509 certificate" msg)
Merging selinux/next (7c655bee5cd8 selinux: only filter copy-up xattrs foll=
owing initialization)
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (4a25541b236f tpm: tis_i2c: Add compatible string nuvoto=
n,npct75x)
Merging watchdog/master (41bccc98fb79 Linux 6.8-rc2)
Merging iommu/next (9672be5db16e Merge branches 'iommu/fixes', 'arm/mediate=
k', 'arm/renesas', 'x86/amd' and 'core' into next)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (2ff94f7ce292 docs: dt: writing-schema: documen=
t expectations on example DTS)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/tri=
vial-devices.yaml
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (a87e24a02426 Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (c56ac217a3c0 Merge branch into tip/master: 'x86/vdso')
Merging clockevents/timers/drivers/next (97454a65d56b clocksource: arm_glob=
al_timer: fix non-kernel-doc comment)
Merging edac/edac-for-next (22b6c326a81d Merge remote-tracking branches 'ra=
s/edac-misc', 'ras/edac-drivers' and 'ras/edac-amd-atl' into edac-for-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging ftrace/for-next (4af12c95cbe8 Merge probes/for-next)
Merging rcu/rcu/next (b4c7a9cd36e1 rcutorture: Enable RCU priority boosting=
 for TREE09)
Merging kvm/next (687d8f4c3dea Merge branch 'kvm-kconfig')
Merging kvm-arm/next (9e00a15ec81e Merge branch kvm-arm64/vm-configuration =
into kvmarm/next)
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Merging kvms390/next (7b2411e79367 KVM: s390: fix virtual vs physical addre=
ss confusion)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (f072b272aa27 RISC-V: KVM: Use correct res=
tricted types)
Merging kvm-x86/next (21dbc438dde6 Merge branches 'asyncpf', 'asyncpf_abi',=
 'fixes', 'generic', 'misc', 'mmu', 'pmu', 'svm', 'vmx' and 'xen')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/sev.c
Applying: fixup for code moving to arch/x86/include/uapi/asm/kvm.h
Merging xen-tip/linux-next (fa765c4b4aed xen/events: close evtchn after map=
ping cleanup)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (948b37b6a41e Merge branch 'for-6.9-bh-conversi=
ons' into for-next)
Merging drivers-x86/for-next (c5211eacf332 platform/x86: ideapad-laptop: su=
pport Fn+R dual-function key)
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (8a0a62941a04 firmware: =
coreboot: Replace tag with id table in driver struct)
Merging hsi/for-next (a0e35a173a86 hsi: hsi_core: make hsi_bus_type const)
Merging leds-lj/for-leds-next (12ce20e02e53 leds: trigger: netdev: Fix kern=
el panic on interface rename trig notify)
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (07749061b837 Merge 6.8-rc5 into drive=
r-core-next)
Merging usb/usb-next (3bf0514dc6f3 Revert "xhci: add helper to stop endpoin=
t and wait for completion")
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/reg=
ulator/qcom,usb-vbus-regulator.yaml
CONFLICT (content): Merge conflict in drivers/usb/roles/class.c
Merging thunderbolt/next (b4734507ac55 thunderbolt: Improve DisplayPort tun=
nel setup process to be more robust)
Merging usb-serial/usb-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging tty/tty-next (1643281347f8 serial: pmac_zilog: Convert to platform =
remove callback returning void)
Merging char-misc/char-misc-next (8d11c6d9b14f Merge 6.8-rc5 into char-misc=
-next)
Merging accel/habanalabs-next (570a7f66cc7a accel/habanalabs: modify pci he=
alth check)
Merging coresight/next (c099fdd218a0 coresight: tpdm: Fix build break due t=
o uninitialised field)
Merging fastrpc/for-next (5169a077f22a misc: fastrpc: Pass proper arguments=
 to scm call)
Merging fpga/for-next (ff49b00e9621 fpga: dfl: make dfl_bus_type const)
Merging icc/icc-next (b9a9c447277f Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (3cc5ebd3a2d6 iio: imu: bmi323: Add ACPI Match Table)
CONFLICT (content): Merge conflict in drivers/of/property.c
Merging phy-next/next (505dfc6ba84c phy: ti: tusb1210: Define device IDs)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
c
Merging soundwire/next (81a7d0c4d059 soundwire: bus_type: make sdw_bus_type=
 const)
Merging extcon/extcon-next (b401b621758e Linux 6.8-rc5)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (78f70c02bdbc vfio/virtio: fix virtio-pci dependency)
Merging w1/for-next (d97d263132a6 w1: w1-gpio: Convert to platform remove c=
allback returning void)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (455c5e12a3b7 staging: gdm724x: constantify th=
e struct device_type usage)
Merging counter-next/counter-next (b6dce0452a02 counter: fix privdata align=
ment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (35b78e2eef2d dt-bindings: renesas,rcar-dmac: Add r8=
a779h0 support)
Merging cgroup/for-next (8d4c171f451d docs: cgroup-v1: add missing code-blo=
ck tags)
Merging scsi/for-next (d970d094663a Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (9f3dbcb5632d scsi: csiostor: Avoid function poin=
ter casts)
Merging vhost/linux-next (f16d65124380 vdpa/mlx5: Add mkey leak detection)
Merging rpmsg/for-next (929654e8f1ad Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
CONFLICT (content): Merge conflict in drivers/remoteproc/imx_dsp_rproc.c
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (56c608c9e773 gpio: Add ChromeOS EC GPIO dr=
iver)
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (9a04a5769a6d Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (a6f06b909fee pinctrl: renesas: All=
ow the compiler to optimize away sh_pfc_pm)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (801de0882d8a pwm: dwc: simplify error handling)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (6f1a214d446b selftests: sched: Fix spelling mistake=
 "hiearchy" -> "hierarchy")
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (08c454e26daa kunit: Mark filter* params as rw)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (6613476e225e Linux 6.8-rc1)
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
Merging auxdisplay/for-next (34ddc83dc720 auxdisplay: linedisp: Add support=
 for overriding character mapping)
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (f0397e27d120 Revert "bus: mhi: core: Add support for =
reading MHI info from device")
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (73bf93edeeea cxl/core: use sysfs_emit() for attr's _show(=
))
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (841c35169323 Linux 6.8-rc4)
Merging unicode/for-next (367122c529f3 libfs: Attempt exact-match compariso=
n first during casefolded lookup)
Merging slab/slab/for-next (360cda4b91b8 Merge branch 'slab/for-6.9/optimiz=
e-get-freelist' into slab/for-next)
Merging random/master (1f719a2f3fa6 Merge tag 'net-6.8-rc4' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging landlock/next (28c2be13a1e0 landlock: Document IOCTL support)
Merging rust/rust-next (e3c3d34507c7 docs: rust: Add description of Rust do=
cumentation test as KUnit ones)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
Merging sysctl/sysctl-next (cec030ec414e MAINTAINERS: Update sysctl tree lo=
cation)
Merging execve/for-next/execve (15fd1dc3dadb fs: binfmt_elf_efpic: don't us=
e missing interpreter's properties)
Merging bitmap/bitmap-for-next (071ad962baf5 bitmap: Step down as a reviewe=
r)
CONFLICT (content): Merge conflict in drivers/block/null_blk/main.c
CONFLICT (content): Merge conflict in drivers/tty/serial/sc16is7xx.c
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (e3508eabe0cc x86/vdso: Move vDSO to mmap region)
CONFLICT (content): Merge conflict in scripts/Makefile.lib
CONFLICT (content): Merge conflict in scripts/Makefile.ubsan
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)
Applying: fix up for "arm64/sysreg: Add register fields for ID_AA64DFR1_EL1"

--Sig_/oSDi4WtdvNsW35yRD/G1AZC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXXNMkACgkQAVBC80lX
0GyPhwf+KRPnN1J5uZlmFIS4I7q6gX1zw2qOB/YlrpMBoU1lNTdeUkU7/JexndLt
XbnOptjjXDQeZvnWAAGKR9saZP0a7ik8QClAeAx6FBXBfZY6txoGfTY7flGP86Nx
DChwdJUDvKsYBsnBwM3CXupoH+950rM/0sAB7Cac79O2lm0oE8rv0CzFahpx2J8l
E8R7QhGIX2Db+ub+BTHD6o0i8UjlMkpTKE0NB709SU6vIL2VR3xXW4l1S0Er9pMH
JLIv6qe5RY/TcmmXo5LJ6r+VsWTegoB49xmGwQdvDuCZIfdKaGBOggmlcYVVm1YF
5US/jISnzKbSeGk1uoFZFu/ixj93oQ==
=DeLs
-----END PGP SIGNATURE-----

--Sig_/oSDi4WtdvNsW35yRD/G1AZC--

