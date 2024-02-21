Return-Path: <linux-kernel+bounces-74095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2985CFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF011F23B28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FC39FCF;
	Wed, 21 Feb 2024 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pUszjs2M"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D1383BF;
	Wed, 21 Feb 2024 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494181; cv=none; b=LJALPc3YR26uemfDrnu+n5fglogVX59jlVXghfj/rTR+eyA1MvvPi1LfnDVEioYbJEIZRej43sHH16eQpEanoYHct2EmAY1VE8XCTYxzNQTaA9KKew3zHVoLmton3Ual7bQ/KA5FXqGCCFI9FdRON0Qpn4VFJTi5rc0QHTQZr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494181; c=relaxed/simple;
	bh=dmlnRcHjXAGijOvvw4Ll6Mud8mNK92Xw08ve2f6xRkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Sg6A7+I5BWnJTdbgPU8/UM9cEID888m1gX6soDJHB7zcsrd6zrp8LvPnM8wE/daSWyujGrNnKl1Nb0z3CcC796ORy1ZbBMDKXWBMu8eZ8ldb4yZJKMhaoUYHb6q5JtXqOVH7/mRbLaWpVHGXxM07uwt7i3JcvXon81tUp/5RVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pUszjs2M; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708494175;
	bh=DVK2PXvbWJ4Foto4dfdKwJHzkV/3WyvK7nYKyX53H90=;
	h=Date:From:To:Cc:Subject:From;
	b=pUszjs2MTAmruK7emu9AJpHVeaCvv+PweIzRTqiDxEUTyLPOIsoQ3C7kobSZJ68kf
	 +Q9Tzzgb4FGymLqlgMqF+716o3kfBfwzC+3QYuBGWNIImP8BsC1jhGZ9cif/ZqMPII
	 WJvc5mG3pikm5NlxnBlTxpiKL/WaGwp9j3PCCq4aamWiJahWEfCSYMRS1qY1nff3B4
	 /h5RtXUllrnI4ZafBr6PzD/9AeLMROBd4P4mP5Mp7E32PPwstjlDw2nw/T2mbYjEMp
	 TIQqHZwOrz0aFM7qVai76c0xbmZR5X7FlWz3C2vj37+PcaQhiGY9K8vRGzBe9HtYF1
	 oZBQ8nhnGjMSg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TflYC0sr0z4wcF;
	Wed, 21 Feb 2024 16:42:55 +1100 (AEDT)
Date: Wed, 21 Feb 2024 16:42:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 21
Message-ID: <20240221164254.274e27b2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sSXQGBfQExN1jfQwNlhV/P1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/sSXQGBfQExN1jfQwNlhV/P1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240220:

The drm-misc-fixes tree gained a conflict against Linus' tree.

The vfs-brauner tree gained a conflict against the mm tree.

The bitmap tree gained a conflict against the block tree.

Non-merge commits (relative to Linus' tree): 7840
 7532 files changed, 347453 insertions(+), 146135 deletions(-)

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
Merging origin/master (fca7526b7d89 drm/tests/drm_buddy: fix build failure =
on 32-bit targets)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (0eb702ab51ac mm/debug_vm_pgtable:=
 fix BUG_ON with pud advanced test)
Merging kbuild-current/fixes (b401b621758e Linux 6.8-rc5)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (d7b77a0d565b arm64/sme: Restore SMCR_EL=
1.EZT0 on exit from suspend)
Merging arm-soc-fixes/arm/fixes (78b6f8e7379b dtc: Enable dtc interrupt_pro=
vider check)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging sophgo-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (20c8c4dafe93 KVM: PPC: Book3S HV: Fix L2 guest=
 reboot failure due to empty 'arch_compat')
Merging s390-fixes/fixes (124468af7e76 s390/configs: update default configu=
rations)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (23f9c2c066e7 docs: netdev: update the link to the CI repo)
Merging bpf/master (5c138a8a4abe selftests/bpf: Add negtive test cases for =
task iter)
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (40b9385dd8e6 enic: Avoid false positive under FORTI=
FY_SOURCE)
Merging ipvs/main (84443741faab netfilter: nf_tables: fix bidirectional off=
load regression)
Merging wireless/for-next (f78c1375339a wifi: nl80211: reject iftype change=
 with mesh ID change)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (eb5c7465c324 RDMA/srpt: fix function pointer cas=
t warnings)
Merging sound-current/for-linus (49cbb7b7d36e ALSA: ump: Fix the discard er=
ror code from snd_ump_legacy_open())
Merging sound-asoc-fixes/for-linus (0db0c1770834 ASoC: cs35l56: Workaround =
for ACPI with broken spk-id-gpios property)
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
Merging kvm-fixes/master (9895ceeb5cd6 Merge tag 'kvmarm-fixes-6.8-2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (841c35169323 Linux 6.8-rc4)
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
Merging drm-intel-fixes/for-linux-next-fixes (b401b621758e Linux 6.8-rc5)
Merging mmc-fixes/fixes (6b1ba3f9040b mmc: mmci: stm32: fix DMA API overlap=
ping mappings warning)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3951f6add519 riscv: Fix arch_tlbbatch_flush() b=
y clearing the batch cpumask)
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
Merging iommufd-fixes/for-rc (28b9f669e10f iommufd/iova_bitmap: Consider pa=
ge offset for the pages to be pinned)
Merging rust-fixes/rust-fixes (b401b621758e Linux 6.8-rc5)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (eb5555d422d0 pmdomain: arm: Fix NULL derefere=
nce on scmi_perf_domain removal)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (eb9f7f654f25 i2c: i801: Fix bloc=
k process call transactions)
Merging drm-misc-fixes/for-linux-next-fixes (eb0d253ff9c7 accel/ivpu: Don't=
 enable any tiles by default on VPU40xx)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tests/drm_buddy_test.c
Merging mm-stable/mm-stable (b401b621758e Linux 6.8-rc5)
Merging mm-nonmm-stable/mm-nonmm-stable (b401b621758e Linux 6.8-rc5)
Merging mm/mm-everything (e36e2a37ad2e Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (ba3b759fb688 kconfig: lxdialog: fix cursor render =
in checklist)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (81901fc0640d perf build: Cleanup perf registe=
r configuration)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (8790fade1a19 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (19cf01c42e5b Merge branch 'for-next/stage1-lpa=
2' into for-next/core)
Merging arm-perf/for-next/perf (fd185a245155 perf/arm_cspmu: Add devicetree=
 support)
Merging arm-soc/for-next (37156e9b9974 soc: document merges)
Merging amlogic/for-next (8026dced77f2 Merge branch 'v6.9/arm64-dt' into fo=
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
Merging renesas/next (0c096fb42ae5 Merge branch 'renesas-dts-for-v6.9' into=
 renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
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
Merging ti/ti-next (0ad5d338af6d Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (efe5a1b888ab Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (6613476e225e Linux 6.8-rc1)
Merging clk-renesas/renesas-clk (81a7a88a9806 clk: renesas: r8a779h0: Add R=
PC-IF clock)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (cca5efe77a6a LoongArch: vDSO: Disable UBS=
AN instrumentation)
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
Merging powerpc/next (3281366a8e79 uapi/auxvec: Define AT_HWCAP3 and AT_HWC=
AP4 aux vector, entries)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (cb4ede926134 riscv: Avoid code duplication with ge=
neric bitops implementation)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (5669bb5a16a0 riscv: dts: microchip: add=
 specific compatible for mpfs pdma)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (cba7aa7faf86 Merge branch 'features' into for-next)
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
Merging cifs/for-next (0ab0a5fed476 cifs: allow changing password during re=
mount)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (aa12a790d31b erofs: make erofs_{err,info}() support NULL=
 sb parameter)
Merging exfat/dev (3a7845041eb7 exfat: fix appending discontinuous clusters=
 to empty file)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (21174ac99fe4 Pull MAINTAINER file git tree addition.)
Merging ext4/dev (ec9d669eba4c ext4: make ext4_set_iomap() recognize IOMAP_=
DELALLOC map type)
Merging f2fs/dev (21ec68234826 f2fs: fix to avoid potential panic during re=
covery)
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
Merging xfs/for-next (49c379d3a72a xfs: use kvfree for buf in xfs_ioc_getbm=
ap)
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
Merging vfs-brauner/vfs.all (b630a177e61d Merge branch 'vfs.uuid' into vfs.=
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
Merging hwmon-staging/hwmon-next (e6b33455c319 MAINTAINERS: Drop redundant =
hwmon entries)
Merging jc_docs/docs-next (920290fe2a18 Merge branch 'docs-fixes' into docs=
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
Merging net-next/main (4934446297c2 Merge tag 'linux-can-next-for-6.9-20240=
220' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next)
Merging bpf-next/for-next (7648f0c91eaa selftests/bpf: Remove empty TEST_CU=
STOM_PROGS)
Merging ipsec-next/master (1476de6d2b57 xfrm: Simplify the allocation of sl=
ab caches in xfrm_policy_init)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (219eee9c0d16 net: skbuff: add overflow debug c=
heck to pull/push helpers)
Merging ipvs-next/main (f77581bfda24 Merge branch 'add-multi-buff-support-f=
or-xdp-running-in-generic-mode')
Merging bluetooth/master (25956d989c60 Bluetooth: hci_sync: Fix UAF on crea=
te_le_conn_complete)
Merging wireless-next/for-next (dd66185c23f7 wifi: wilc1000: add missing re=
ad critical sections around vif list traversal)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mvm.h
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
Merging drm-misc/for-linux-next (1f4c6f11a557 drm/ci: mark universal-plane-=
sanity as failing on SC7180)
Applying: drm/ttm: initialise places
Merging amdgpu/drm-next (31e0a586f338 drm/amdgpu: add MMHUB 3.3.1 support)
Merging drm-intel/for-linux-next (bf7626f19d6f drm/i915/tv: Fix TV mode)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (41c177cf3541 Merge tag 'drm-misc-next-2024-02-08'=
 into msm-next)
Merging drm-msm-lumag/msm-next-lumag (ffa0c87f172b drm/msm/mdp5: drop globa=
l_state_lock)
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (cfe1cab458f0 Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (52592932405c ALSA: oxfw: add support for Miglia Har=
mony Audio)
Merging ieee1394/for-next (41ebb53b1bff firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (db38c4ba8be6 Merge remote-tracking branch 'aso=
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
Merging libata/for-next (1ab5b472493f Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (1bec7691b327 pcmcia: ds: make pcmcia_bus_type c=
onst)
Merging mmc/next (25e69172db8a mmc: davinci_mmc: Drop dangling variable)
CONFLICT (content): Merge conflict in drivers/mmc/core/queue.c
Merging mfd/for-mfd-next (d5132d176d6f mfd: rc5t583: Convert to use maple t=
ree register cache)
Merging backlight/for-backlight-next (770c0f4975fd dt-bindings: backlight: =
qcom-wled: Fix bouncing email addresses)
Merging battery/for-next (a9b254892ce1 power: supply: axp288_fuel_gauge: Ad=
d STCK1A* Intel Compute Sticks to the deny-list)
Merging regulator/for-next (32ca2f8f6696 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (1fc5baf574b7 Automated merge of 'dev' into 'next')
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
Merging iommu/next (05f64ad28da1 Merge branches 'arm/mediatek', 'arm/renesa=
s', 'x86/amd' and 'core' into next)
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
Merging spi/for-next (55072343f1df Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (c56ac217a3c0 Merge branch into tip/master: 'x86/vdso')
Merging clockevents/timers/drivers/next (9256cec7b4f3 clocksource/drivers/a=
rm_global_timer: Remove stray tab)
Merging edac/edac-for-next (4cc8411bb56d Merge edac-amd-atl into for-next)
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
Merging kvm-x86/next (ca19f5c9d3c3 Merge branches 'asyncpf', 'asyncpf_abi',=
 'fixes', 'generic', 'misc', 'mmu', 'pmu', 'svm', 'vmx' and 'xen')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/sev.c
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Applying: fixup for code moving to arch/x86/include/uapi/asm/kvm.h
Merging xen-tip/linux-next (fa765c4b4aed xen/events: close evtchn after map=
ping cleanup)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (fd0a68a2337b workqueue, irq_work: Build fix fo=
r !CONFIG_IRQ_WORK)
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
Merging fastrpc/for-next (6613476e225e Linux 6.8-rc1)
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
Merging pinctrl/for-next (b3b8c7865c27 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (97191e536c37 pinctrl: renesas: r8a=
779h0: Add Audio pins, groups, functions)
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
Merging slimbus/for-next (04b945e4cf81 slimbus: qcom-ngd-ctrl: Make QMI mes=
sage rules const)
Merging nvmem/for-next (2c8df24cc166 nvmem: mtk-efuse: Drop NVMEM device na=
me)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/for-next (34ddc83dc720 auxdisplay: linedisp: Add support=
 for overriding character mapping)
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (ceeb64f41fe6 bus: mhi: host: Add tracing support)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (73bf93edeeea cxl/core: use sysfs_emit() for attr's _show(=
))
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (841c35169323 Linux 6.8-rc4)
Merging unicode/for-next (367122c529f3 libfs: Attempt exact-match compariso=
n first during casefolded lookup)
Merging slab/slab/for-next (7d2ec24bd8a5 Merge branch 'slab/for-6.9/optimiz=
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
Merging kspp/for-next/kspp (f0f427340429 leaking_addresses: Provide mechani=
sm to scan binary files)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/sSXQGBfQExN1jfQwNlhV/P1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVjV4ACgkQAVBC80lX
0Gy4Lwf+Npm+IUxfpm2VifpXl0w9ktpPtFXbmuQeXJzUqpyTL9S51hkyeCs75szE
wzji8+1OcNZRrRcSRFmcR7p4oVKXhCF2RWSbBTzg01izPiFI7xWhgh1OCTyN7Lqb
eK4DkLIDYvicoTmKQWxAY0oObYQKs1wO6GnfYpXypS2CadtB3o7WEwwpAzcxpiYM
xA8hydz0VPebyPP4GBy3zLxToM6A5jcU+8gsbL0NaDTOSS+DGPvOYTkdrxCFYGsZ
sGoJcTpXffdpNdT+SCV4ZGR9uPF/+93nG2MnyMOQ/emt/R3rS+Rq9C2FqO16Yh4i
snjmD0E/MmwMgWf6K1nHWFc1BhP7qQ==
=EhtG
-----END PGP SIGNATURE-----

--Sig_/sSXQGBfQExN1jfQwNlhV/P1--

