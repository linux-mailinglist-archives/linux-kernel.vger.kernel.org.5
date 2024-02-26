Return-Path: <linux-kernel+bounces-80611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772F866A54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B53B1C22112
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0771B951;
	Mon, 26 Feb 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="psvzMWph"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3681BC5C;
	Mon, 26 Feb 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930517; cv=none; b=NK4CwjCcNIxThWGB9oRtL939MWolJyKGAO8XVb4QuA/F+/V4qG/LbnAV1kGIycygbOVuh1qgT9iB1nG74oUnHkG7mEbIzR7kfsxR1uHemmLCjJcB2gjJVgYNcvpaoDfHNhyPpYRPSriVJBF8b7R7IR/y2k6snh2KD1le8yXOMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930517; c=relaxed/simple;
	bh=0IA9tPWxKE8iFXjgFqXNJ8PwxnMLW3SIkqocj6MtLAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ANXuwe+AfgfNmly/yuI/sCIPCBzjQl4jHE/ym8yGPQyatUDLyVl0JJ6QVgWGHFA+Jm+O0STJQw45BjOcbIaBL97TJI5rVm2AaZgFeJNLPjq8dETpGm51kPSBZ1FmavaKCcoKDD24YY5CI5EKgCr8D8umdlr3+006Ksy2CjscUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=psvzMWph; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708930510;
	bh=WCxqs5Ir8l8tpyNkp1jwRdizYzRRpMLPxLFZUVvyhRw=;
	h=Date:From:To:Cc:Subject:From;
	b=psvzMWphBLJZq6cmpwquIuI8HDKkZjp5Szb6TAE6FC8kHrRdcGVueoUBhTCVITbXc
	 1PpblnEL0GYjracXAHylL///HH+sr/FRXzPGM43kz9E8RJnL6XXL8eVZhmCTuSFYja
	 ao/tFRisXuNpOdPl11Rv5U6DXLGHEOJs+BxRAina0+LxA8u5x+0sy53RoZZyizCNQL
	 VwehBHxGNM3q8mdv2lqdFL3MH7lyoFJBtRYpf9RsEyKHUqqfWUcTI10O9bZC+sC6Ey
	 zMJaXd3kVbQ6mL51+e6plddMEk3venuntur/w2zrruPFTb28SXEZBheO1c2qDaPjj7
	 3X6dClwVQpwLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjrwG4Z3Pz4wc8;
	Mon, 26 Feb 2024 17:55:10 +1100 (AEDT)
Date: Mon, 26 Feb 2024 17:55:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 26
Message-ID: <20240226175509.37fa57da@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bBNgaT7lzBg50mNtdUnptUg";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/bBNgaT7lzBg50mNtdUnptUg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240223:

The mm-nonmm-stable tree gained a conflict against the risc-v-fixes tree.

The perf tree still had its build failure so I removed the object tree
and rebuilt it which worked.

The fuse tree gained a conflict against Linus' tree.

The vfs-brauner tree gained conflictis against the bcachefs and cifs trees.

The backlight tree gained a build failure so I used the version from
next-20240223.

The tip tree gained a conflict against the workqueues tree.

The rcu tree gained a conflict against the pm tree.

The gpio-brgl tree still had its build failure so I used the version from
next-20240222.

The kspp tree gained a conflict against the kbuild tree.

Non-merge commits (relative to Linus' tree): 9000
 8396 files changed, 411176 insertions(+), 163733 deletions(-)

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
Merging origin/master (70ff1fe626a1 Merge tag 'docs-6.8-fixes3' of git://gi=
t.lwn.net/linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (e0f617170dc6 init/Kconfig: lower =
GCC version check for -Warray-bounds)
Merging kbuild-current/fixes (b401b621758e Linux 6.8-rc5)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
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
Merging powerpc-fixes/fixes (20c8c4dafe93 KVM: PPC: Book3S HV: Fix L2 guest=
 reboot failure due to empty 'arch_compat')
Merging s390-fixes/fixes (5ef1dc40ffa6 s390/cio: fix invalid -EBUSY on ccw_=
device_start)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (2a770cdc4382 tun: Fix xdp_rxq_info's queue_index when det=
aching)
Merging bpf/master (dced881ead78 Merge branch 'check-bpf_func_state-callbac=
k_depth-when-pruning-states')
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (359e54a93ab4 l2tp: pass correct message length to i=
p6_append_data)
Merging ipvs/main (40b9385dd8e6 enic: Avoid false positive under FORTIFY_SO=
URCE)
Merging wireless/for-next (413dafc8170f wifi: mac80211: only call drv_sta_r=
c_update for uploaded stations)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (eb5c7465c324 RDMA/srpt: fix function pointer cas=
t warnings)
Merging sound-current/for-linus (0ac32a396e4f ALSA: hda/realtek: Add specia=
l fixup for Lenovo 14IRP8)
Merging sound-asoc-fixes/for-linus (eba2eb2495f4 ASoC: soc-card: Fix missin=
g locking in snd_soc_card_get_kcontrol())
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (e5d40e9afd84 regulator: max5970: Fix reg=
ulator child node name)
Merging spi-fixes/for-linus (078d62de433b spi: cadence-qspi: add system-wid=
e suspend and resume callbacks)
Merging pci-current/for-linus (6613476e225e Linux 6.8-rc1)
Merging driver-core.current/driver-core-linus (b401b621758e Linux 6.8-rc5)
Merging tty.current/tty-linus (3b69e32e151b serial: amba-pl011: Fix DMA tra=
nsmission in RS485 mode)
Merging usb.current/usb-linus (69f89168b310 usb: typec: tpcm: Fix issues wi=
th power being removed during reset)
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
Merging crypto-current/master (1c0cf6d19690 crypto: arm64/neonbs - fix out-=
of-bounds access on short input)
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
Merging hwmon-fixes/hwmon (cf5ad17ee6a4 hwmon: (nct6775) Fix access to temp=
erature configuration registers)
  cf5ad17ee6a4 ("hwmon: (nct6775) Fix access to temperature configuration r=
egisters")
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (daeacfa75d08 Merge branch 'for-6.8/cxl-cper' into =
for-6.8/cxl)
  d08431235df0 ("acpi/ghes: Remove CXL CPER notifications")
CONFLICT (content): Merge conflict in drivers/cxl/acpi.c
Merging btrfs-fixes/next-fixes (eb90d142fc1b Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (2c88c16dc20e erofs: fix handling kern_mount() fail=
ure)
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
Merging scsi-fixes/fixes (9ddf190a7df7 scsi: jazz_esp: Only build if SCSI c=
ore is builtin)
Merging drm-fixes/drm-fixes (72fa02fdf833 nouveau: add an ioctl to report v=
ram usage)
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
Merging risc-v-fixes/fixes (d82f32202e0d RISC-V: Ignore V from the riscv,is=
a DT property on older T-Head CPUs)
Merging riscv-dt-fixes/riscv-dt-fixes (ce6b6d151396 riscv: dts: sifive: add=
 missing #interrupt-cells to pmic)
Merging riscv-soc-fixes/riscv-soc-fixes (bf456162601f Merge branches 'riscv=
-cache-fixes' and 'riscv-firmware-fixes' into riscv-soc-fixes)
  8bbccdd8c264 ("cache: ax45mp_cache: Align end size to cache boundary in a=
x45mp_dma_cache_wback()")
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
Merging pmdomain-fixes/fixes (eb5555d422d0 pmdomain: arm: Fix NULL derefere=
nce on scmi_perf_domain removal)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (cf8281b1aeab i2c: imx: when bein=
g a target, mark the last read as processed)
  cf8281b1aeab ("i2c: imx: when being a target, mark the last read as proce=
ssed")
Merging drm-misc-fixes/for-linux-next-fixes (f79ee78767ca soc: qcom: pmic_g=
link: Fix boot when QRTR=3Dm)
Merging mm-stable/mm-stable (c44ed5b7596f writeback: remove a use of write_=
cache_pages() from do_writepages())
Merging mm-nonmm-stable/mm-nonmm-stable (2932fb0a927d list: leverage list_i=
s_head() for list_entry_is_head())
CONFLICT (content): Merge conflict in arch/riscv/include/asm/ftrace.h
Merging mm/mm-everything (e599ac4eab99 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (5270316c9fec kbuild: Use -fmin-function-alignment =
when available)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (b482f5f8e016 perf tests: Add option to run te=
sts in parallel)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (83ffbed67207 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (e8e5eae6f56d Merge branch 'for-next/stage1-lpa=
2' into for-next/core)
Merging arm-perf/for-next/perf (fd185a245155 perf/arm_cspmu: Add devicetree=
 support)
Merging arm-soc/for-next (d6f69171ea30 soc: document merges)
Merging amlogic/for-next (15e1567404d7 Merge branch 'v6.9/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (6315946ad242 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (412c6bd2c649 Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (ae1e06fb62c3 memory: tegra: Fix indentatio=
n)
Merging imx-mxs/for-next (45ccd182719b Merge branch 'imx/defconfig' into fo=
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
Merging renesas/next (06a019816e51 Merge branch 'renesas-dts-for-v6.9' into=
 renesas-next)
Merging reset/reset/next (c721f189e89c reset: Instantiate reset GPIO contro=
ller for shared reset-gpios)
Merging rockchip/for-next (504c4c60e70b Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (8b9d2e71b42c Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (a2b8119375a1 Merge tags 'vexpress-update-6.9',=
 'ffa-update-6.9' and 'scmi-updates-6.9' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (0f46e1339ef1 MAINTAINERS: Setup proper info for SO=
PHGO vendor support)
Merging stm32/stm32-next (7fd195f01ae5 ARM: dts: stm32: lxa-tac: reduce RGM=
II interface drive strength)
Merging sunxi/sunxi/for-next (c1d7282e4e92 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (58ea7e692a9e Merge branch 'tee_bus_type_for_v6.9' into ne=
xt)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (d4dca68e4b2c Merge branch 'ti-k3-config-next' into ti-n=
ext)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (948d9ddad423 Merge branch 'clk-mobileye' into clk-nex=
t)
Merging clk-imx/for-next (6613476e225e Linux 6.8-rc1)
Merging clk-renesas/renesas-clk (81a7a88a9806 clk: renesas: r8a779h0: Add R=
PC-IF clock)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (f0f5c4894f89 LoongArch: KVM: Streamline k=
vm_check_cpucfg() and improve comments)
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (b401b621758e Linux 6.8-rc5)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (188942f05ce4 tty: mips_ejtag_fdc: Fix passing incom=
patible pointer type warning)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (a5c8a00bb269 parisc: Fix csum_ipv6_magic on 64-=
bit systems)
Merging powerpc/next (a3e1820186b5 powerpc: pmi: Convert to platform remove=
 callback returning void)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (45e0b0fd6dc5 riscv: defconfig: Enable mmc and dma =
drivers for T-Head TH1520)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (5669bb5a16a0 riscv: dts: microchip: add=
 specific compatible for mpfs pdma)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (ea5872e0bbe1 Merge branch 'features' into for-next)
Merging sh/for-next (0a2d3ce0031f sh: hd64461: Make setup_hd64461 static)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (7ab7acb68adf xtensa: fix MAKE_PC_FROM_RA se=
cond argument)
Merging bcachefs/for-next (26494335d114 bcachefs: improve move_gap())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (2653677ec901 Merge branch 'for-next-next-v6.8-20240=
222' into for-next-20240222)
Merging ceph/master (dbc347ef7f0c ceph: add ceph_cap_unlink_work to fire ch=
eck_caps() immediately)
Merging cifs/for-next (09d77130a24b smb: client: move most of reparse point=
 handling code to common file)
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
Merging f2fs/dev (78adee727011 f2fs: introduce get_available_block_count() =
for cleanup)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (33771e1143a9 fuse: implement passthrough for mmap)
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
Merging xfs/for-next (4b2f459d8625 xfs: fix SEEK_HOLE/DATA for regions with=
 active COW extents)
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
Merging vfs-brauner/vfs.all (872365adb67a Merge branch 'vfs.uuid' into vfs.=
all)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
CONFLICT (content): Merge conflict in fs/nfsd/nfs4layouts.c
CONFLICT (content): Merge conflict in fs/smb/client/file.c
CONFLICT (content): Merge conflict in init/main.c
Applying: fixup for "filelock: split common fields into struct file_lock_co=
re"
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (e7081d5a9d97 Merge branch 'rework/console-flushing=
-fixes' into for-next)
Merging pci/next (5b52c9afa3dd Merge branch 'pci/misc')
Merging pstore/for-next/pstore (98bc7e26e14f pstore/zone: Add a null pointe=
r check to the psz_kmsg_read)
Merging hid/for-next (8f0a3ff87887 Merge branch 'for-6.9/nintendo' into for=
-next)
Merging i2c/i2c/for-next (87aec499368d i2c: imx: when being a target, mark =
the last read as processed)
Merging i2c-host/i2c/i2c-host (48acf8292280 i2c: Remove redundant compariso=
n in npcm_i2c_reg_slave)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (5b1d7a0f904b hwmon: (sis5595) drop unused=
 DIV_TO_REG function)
Merging jc_docs/docs-next (32ed7930304c Merge branch 'docs-fixes' into docs=
-mw)
Merging v4l-dvb/master (8c64f4cdf4e6 media: edia: dvbdev: fix a use-after-f=
ree)
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging v4l-dvb-next/master (e0b8eb0f6d65 media: visl: Add codec specific v=
ariability on output frames)
Merging pm/linux-next (b9dcbdb099e4 Merge branches 'pm-cpufreq', 'pm-sleep'=
, 'pm-runtime', 'pm-em' and 'pm-tools' into linux-next)
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
Merging rdma/for-next (14b526f55ba5 RDMA/uverbs: Remove flexible arrays fro=
m struct *_filter)
Merging net-next/main (d662c5b3ce6d tools: ynl: fix header guards)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mvm.h
Merging bpf-next/for-next (2ab256e93249 bpf: add is_async_callback_calling_=
insn() helper)
Merging ipsec-next/master (1476de6d2b57 xfrm: Simplify the allocation of sl=
ab caches in xfrm_policy_init)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (a4634aa71fee bonding: rate-limit bonding drive=
r inspect messages)
Merging ipvs-next/main (26f4dac11775 netfilter: x_tables: Use unsafe_memcpy=
() for 0-sized destination)
Merging bluetooth/master (75518da8cf76 Bluetooth: hci_qca: don't use IS_ERR=
_OR_NULL() with gpiod_get_optional())
Merging wireless-next/for-next (a4634aa71fee bonding: rate-limit bonding dr=
iver inspect messages)
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
Merging crypto/master (a24e3b583ea2 crypto: rockchip - fix to check return =
value)
Merging drm/drm-next (40d47c5fb4f2 Merge tag 'amd-drm-next-6.9-2024-02-19' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_acp=
i.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/h=
w_sequencer_private.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/resour=
ce/dcn35/dcn35_resource.c
Applying: drm/ttm: initialise places
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (9ac4beb7578a Merge tag 'drm-misc-next-20=
24-02-15' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (32ca5ebfde9a drm/i915: Fix possible null p=
ointer dereference after drm_dbg_printer conversion)
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_syncobj.c
Merging amdgpu/drm-next (21db6199f201 drm/amd/display: fix null-pointer der=
eference on edid reading)
  145242ed6f3f ("drm/amd/display: Fix memory leak in dm_sw_fini()")
  1d55183c2cd9 ("drm/amd/display: Fix potential null pointer dereference in=
 dc_dmub_srv")
  21db6199f201 ("drm/amd/display: fix null-pointer dereference on edid read=
ing")
  4af4d2c275ae ("drm/amd/display: Only allow dig mapping to pwrseq in new a=
sic")
  b75a1da662eb ("drm/amd/display: fix input states translation error for dc=
n35 & dcn351")
  c9aef4f6c6d7 ("drm/amd/display: adjust few initialization order in dm")
Merging drm-intel/for-linux-next (0be4e0a5203d drm/i915: Fix doc build issu=
e on intel_cdclk.c)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ffa0c87f172b drm/msm/mdp5: drop global_state_lock)
Merging drm-msm-lumag/msm-next-lumag (e3b1f369db5a drm/msm/dpu: Add X1E8010=
0 support)
Merging drm-xe/drm-xe-next (a9e483dda3ef drm/xe: Don't support execlists in=
 xe_gt_tlb_invalidation layer)
  0f688c0eb63a ("drm/xe: Return 2MB page size for compact 64k PTEs")
  15f0e0c2c46d ("drm/xe: Add XE_VMA_PTE_64K VMA flag")
  19adaccef8b2 ("drm/xe: Fix xe_vma_set_pte_size")
  bb619d71224e ("drm/xe: Fix modpost warning on xe_mocs kunit module")
  e5626eb80026 ("drm/xe/xe_gt_idle: Drop redundant newline in name")
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec_queue.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec_queue_type=
s.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm_types.h
CONFLICT (content): Merge conflict in include/uapi/drm/xe_drm.h
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (cfe1cab458f0 Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (a55bc334d3df ALSA: pcm_oss: ump: Use automatic clea=
nup of kfree())
Merging ieee1394/for-next (41ebb53b1bff firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (51c4c1717a69 Merge remote-tracking branch 'aso=
c/for-6.9' into asoc-next)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (d03f030115fe Input: gameport - make gameport_bus const)
Merging block/for-next (571484af24f7 Merge branch 'for-6.9/block' into for-=
next)
CONFLICT (content): Merge conflict in block/blk.h
CONFLICT (content): Merge conflict in include/linux/sched.h
Merging device-mapper/for-next (6006301c6a83 Merge branch 'dm-6.8' into for=
-next)
Merging libata/for-next (c1bc6ed01c16 Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (1bec7691b327 pcmcia: ds: make pcmcia_bus_type c=
onst)
Merging mmc/next (25e69172db8a mmc: davinci_mmc: Drop dangling variable)
CONFLICT (content): Merge conflict in drivers/mmc/core/queue.c
Merging mfd/for-mfd-next (ec0131916367 dt-bindings: mfd: Convert atmel-flex=
com to json-schema)
Merging backlight/for-backlight-next (3c40590fafd4 backlight: lm3630a: Use =
backlight_get_brightness helper in update_status)
$ git reset --hard HEAD^
Merging next-20240223 version of backlight
Merging battery/for-next (7b46b60944d7 power: supply: core: constify the st=
ruct device_type usage)
Merging regulator/for-next (78e0d079ab38 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (d4f294b33790 Automated merge of 'dev' into 'next')
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
Merging devicetree/for-next (08a5b9fe7714 dt-bindings: vendor-prefixes: Add=
 missing prefixes used in compatibles)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/tri=
vial-devices.yaml
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (8d742874e776 Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (e7f108402128 Merge branch into tip/master: 'x86/tdx')
CONFLICT (content): Merge conflict in kernel/workqueue.c
Merging clockevents/timers/drivers/next (ec64db6955c5 dt-bindings: timer: a=
dd Ralink SoCs system tick counter)
Merging edac/edac-for-next (22b6c326a81d Merge remote-tracking branches 'ra=
s/edac-misc', 'ras/edac-drivers' and 'ras/edac-amd-atl' into edac-for-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging ftrace/for-next (a641f0533adb tracing: Decrement the snapshot if th=
e snapshot trigger fails to register)
Merging rcu/rcu/next (10395f8cfef8 tracing: Select new NEED_TASKS_RCU Kconf=
ig option)
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
Merging kvm/next (0cbca1bf44a0 x86: irq: unconditionally define KVM interru=
pt vectors)
Merging kvm-arm/next (e6af5cb22efe Merge branch kvm-arm64/misc into kvmarm/=
next)
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Applying: fix up for "arm64/sysreg: Add register fields for ID_AA64DFR1_EL1"
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (f072b272aa27 RISC-V: KVM: Use correct res=
tricted types)
Merging kvm-x86/next (b82879c81b4f Merge branch 'xen')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/sev.c
Merging xen-tip/linux-next (fa765c4b4aed xen/events: close evtchn after map=
ping cleanup)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (43a567462aac Merge branch 'for-6.9' into for-n=
ext)
Merging drivers-x86/for-next (c5211eacf332 platform/x86: ideapad-laptop: su=
pport Fn+R dual-function key)
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (8a0a62941a04 firmware: =
coreboot: Replace tag with id table in driver struct)
Merging hsi/for-next (3693760295e8 HSI: ssi_protocol: fix struct members ke=
rnel-doc warnings)
Merging leds-lj/for-leds-next (3e7b2b9309cd leds: sgm3140: Add missing time=
r cleanup and flash gpio control)
  5a436f4dadf1 ("leds: Introduce ExpressWire library")
  c7cbca7886a9 ("leds: ktd2692: Convert to use ExpressWire library")
CONFLICT (content): Merge conflict in drivers/leds/flash/Kconfig
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (01aacda0b10e Merge tag 'sysfs_hidden_=
attribute_groups-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/=
gregkh/driver-core into driver-core-next)
Merging usb/usb-next (e89fbb5bc21a ASoC: Revert "ASoC: dt-bindings: Update =
example for enabling USB offload on SM8250")
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/reg=
ulator/qcom,usb-vbus-regulator.yaml
CONFLICT (content): Merge conflict in drivers/usb/roles/class.c
Merging thunderbolt/next (b4734507ac55 thunderbolt: Improve DisplayPort tun=
nel setup process to be more robust)
Merging usb-serial/usb-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging tty/tty-next (1643281347f8 serial: pmac_zilog: Convert to platform =
remove callback returning void)
Merging char-misc/char-misc-next (d4551c189d6e Merge tag 'iio-for-6.9a' of =
http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-nex=
t)
Merging accel/habanalabs-next (570a7f66cc7a accel/habanalabs: modify pci he=
alth check)
Merging coresight/next (c099fdd218a0 coresight: tpdm: Fix build break due t=
o uninitialised field)
Merging fastrpc/for-next (5169a077f22a misc: fastrpc: Pass proper arguments=
 to scm call)
Merging fpga/for-next (ff49b00e9621 fpga: dfl: make dfl_bus_type const)
Merging icc/icc-next (6025a81ae63e Merge branch 'icc-cleanup' into icc-next)
Merging iio/togreg (3cc5ebd3a2d6 iio: imu: bmi323: Add ACPI Match Table)
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
Merging counter-next/counter-next (b6dce0452a02 counter: fix privdata align=
ment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (716141d366f4 dmaengine: of: constify of_phandle_arg=
s in of_dma_find_controller())
Merging cgroup/for-next (8d4c171f451d docs: cgroup-v1: add missing code-blo=
ck tags)
Merging scsi/for-next (d970d094663a Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (9f3dbcb5632d scsi: csiostor: Avoid function poin=
ter casts)
Merging vhost/linux-next (fd0b29af02bb Documentation: Add reconnect process=
 for VDUSE)
Merging rpmsg/for-next (929654e8f1ad Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
CONFLICT (content): Merge conflict in drivers/remoteproc/imx_dsp_rproc.c
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (7bb5f3a7ca88 gpio: sim: use for_each_hwgpi=
o())
  4a7b0850fc7a ("dt-bindings: cros-ec: Add properties for GPIO controller")
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
$ git reset --hard HEAD^
Merging next-20240222 version of gpio-brgl
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
[master 3277349afadd] next-20240222/gpio-brgl
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (9a04a5769a6d Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (a6f06b909fee pinctrl: renesas: All=
ow the compiler to optimize away sh_pfc_pm)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (ee230c19e174 pwm: dwc: simplify error handling)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (ae638551ab64 selftests/resctrl: Add non-contiguous =
CBMs CAT test)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (717083f66450 kunit: make kunit_bus_type const)
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
Merging rust/rust-next (e944171070b6 rust: add `container_of!` macro)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
Merging sysctl/sysctl-next (4f1136a55dc8 scripts: check-sysctl-docs: handle=
 per-namespace sysctls)
Merging execve/for-next/execve (d3f0d7bbaefd exec: Delete unnecessary state=
ments in remove_arg_zero())
Merging bitmap/bitmap-for-next (fd8ed16c2419 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (c427b1a5e0f8 sparc: vdso: Disable UBSAN instrum=
entation)
CONFLICT (content): Merge conflict in scripts/Makefile.lib
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/bBNgaT7lzBg50mNtdUnptUg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXcNc0ACgkQAVBC80lX
0Gyr3wf+Kg01noxN58U81eelv4n2TyXMN9ZPtc3vhsQDFY1djx2RczRCZaRFc/6p
lkIntZcGhK3J3jxKv64zMUdCtrjhkWjKEzkJ/brasYY9sc4eoUnOSofJStdaGbLc
J5GXOrXdDfuOqOcADWDMJeJG+KIsCFTs+RExLELnDhbNY548NKQn4hGxqx6DsfjM
f/jnteXhJutNa30DODh88KbvMNw770t+seiK4hcn8TrUHiB7iXkyef4dRe2T99uo
0r5EQufzOXkHVN69MIA3MkpJ7RKw4B445u+wm17ZidPFe3qpIscxv4/LviGzeLhM
Qea2VFmKEyXIXgQDdluxwXLTud44+w==
=/dJT
-----END PGP SIGNATURE-----

--Sig_/bBNgaT7lzBg50mNtdUnptUg--

