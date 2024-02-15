Return-Path: <linux-kernel+bounces-66273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45102855991
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658CB1C21FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0537484;
	Thu, 15 Feb 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vEjJ3wfU"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39693C17;
	Thu, 15 Feb 2024 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707969147; cv=none; b=QdS21Ri1/Oazi1LQncOQ8PhxP12mWdEYeoJh1W7RpmK3Ugl7sooKcEstXOKXpUr54b9fW6Mwg913i6h6lb5qRiIg+mnn0uYfw+m5a1HAZLGMH6QYSBUHWkTXahKSmE0vNVeg3MsXpix79smOju0oaQHYx6Bga6QtLpE4Ii+uFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707969147; c=relaxed/simple;
	bh=jENojFNbIYndskn4PnRXLlOOPpnd6keM6V6nmBtSKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Yq/W5LqVYuFnbRxcloGzWUi/0FYSKXdcmiZB1c4xnGDJ+PIEPkgksiQGEcAFfe3rooaX8S1rl6/cltzD7PpIljVbLFfJXHwS3+qdrviI7u5b/WZrduiQyqW3IZFdh2RJ8wNjbbGkSZ1tqOV8trb2p79+Fwet1xhOdwEm9k3FM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vEjJ3wfU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707969141;
	bh=eys21kOVpptbbBZlMfCp+HJxST2LGwjDmGkwyasf4Tk=;
	h=Date:From:To:Cc:Subject:From;
	b=vEjJ3wfUrWEQKxBVHQ3itDqpXq8WS/K35rkP9FlBmMUWEnvPScypkzb+B+MojTv6t
	 8FbVB2GoFsFY3Ugz2GQa8wW1Guy7envAVjU4UKQBQpZ5ytD6+KD/hmtvcpsXSeT+8M
	 6ONOu2fRnl3QgvAl3n25m4DwRwQyTvOapC/O5P727PHilrvuHW7duRYdTskCGjhfGX
	 hwCyj4D0X5rt528XOSBdeTGwVjasWFdmWezoTpSsWNsdxkUlLMe5ILtVMp9vpqI7mU
	 DDA40e6jkbS63Gep/AUEtd8TEMfx1/K6jwhNcEZKP1y55AVm7etYqcI74Qw93LCroo
	 wDkOG6R+n50gQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tb1NN6XTSz4wcN;
	Thu, 15 Feb 2024 14:52:20 +1100 (AEDT)
Date: Thu, 15 Feb 2024 14:52:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 15
Message-ID: <20240215145219.4e528771@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9xb0L8042ywVSDaZsAjrnE1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9xb0L8042ywVSDaZsAjrnE1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240214:

The mm tree lost its build failure.

The vfs-brauner tree gained a conflict against the bcachefs tree.

The w1 tree gained a semantic conflict against the tty tree.

Non-merge commits (relative to Linus' tree): 6575
 6679 files changed, 307442 insertions(+), 125487 deletions(-)

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
Merging origin/master (7e90b5c295ec Merge tag 'trace-tools-v6.8-rc4' of git=
://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (321d8e233e9d mm/damon/sysfs-schem=
es: handle schemes sysfs dir removal before commit_schemes_quota_goals)
Merging kbuild-current/fixes (41b9fb381a48 Merge tag 'net-6.8-rc3' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (50572064ec71 perf/arm-cmn: Workaround A=
mpereOneX errata AC04_MESH_1 (incorrect child count))
Merging arm-soc-fixes/arm/fixes (1b5af823d703 soc/tegra: fix build failure =
on Tegra241)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging sophgo-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (6b9c045b0602 m68k: defconfig: Update defcon=
figs for v6.7-rc1)
Merging powerpc-fixes/fixes (0846dd77c834 powerpc/iommu: Fix the missing io=
mmu_group_put() during platform domain attach)
Merging s390-fixes/fixes (124468af7e76 s390/configs: update default configu=
rations)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (9b23fceb4158 ethernet: cpts: fix function pointer cast wa=
rnings)
Merging bpf/master (e37243b65d52 bpf, scripts: Correct GPL license name)
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (5a8cdf6fd860 netfilter: nft_set_pipapo: remove scra=
tch_aligned pointer)
Merging ipvs/main (5a8cdf6fd860 netfilter: nft_set_pipapo: remove scratch_a=
ligned pointer)
Merging wireless/for-next (b7198383ef2d wifi: iwlwifi: mvm: fix a crash whe=
n we run out of stations)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (5ba4e6d5863c RDMA/qedr: Fix qedr_create_user_qp =
error flow)
Merging sound-current/for-linus (852d432a14db ALSA: hda/realtek: cs35l41: F=
ix order and duplicates in quirks table)
Merging sound-asoc-fixes/for-linus (0db0c1770834 ASoC: cs35l56: Workaround =
for ACPI with broken spk-id-gpios property)
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (e5d40e9afd84 regulator: max5970: Fix reg=
ulator child node name)
Merging spi-fixes/for-linus (269e31aecdd0 spi-mxs: Fix chipselect glitch)
Merging pci-current/for-linus (41044d536068 PCI: Fix active state requireme=
nt in PME polling)
Merging driver-core.current/driver-core-linus (3ca8fbabcceb Revert "kobject=
: Remove redundant checks for whether ktype is NULL")
Merging tty.current/tty-linus (7be50f2e8f20 serial: mxs-auart: fix tx)
Merging usb.current/usb-linus (7d708c145b26 Revert "usb: dwc3: Support EBC =
feature of DWC_usb31")
Merging usb-serial-fixes/usb-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging phy/fixes (734550d60cdf phy: qualcomm: eusb2-repeater: Rework init =
to drop redundant zero-out loop)
Merging staging.current/staging-linus (6613476e225e Linux 6.8-rc1)
Merging iio-fixes/fixes-togreg (78367c32bebf iio: adc: ad4130: only set GPI=
O_CTRL if pin is unused)
Merging counter-current/counter-current (6613476e225e Linux 6.8-rc1)
Merging char-misc.current/char-misc-linus (e20f378d993b nvmem: include bit =
index in cell sysfs file name)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (ec4d82f855ce thunderbolt: Fix setting the =
CNS bit in ROUTER_CS_5)
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
Merging dmaengine-fixes/fixes (9ba17defd9ed dmaengine: fsl-edma: correct ca=
lculation of 'nbytes' in multi-fifo scenario)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (e6a30d0c48a1 mtd: rawnand: marvell: fix layout=
s)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (346c84e281a9 media: pwm-ir-tx: Depend on CONFI=
G_HIGH_RES_TIMERS)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (8fa507083388 mm/memory: Use exception ip to =
search exception tables)
Merging at91-fixes/at91-fixes (6613476e225e Linux 6.8-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (e45964771007 x86/coco: Define cc_vendor without C=
ONFIG_ARCH_HAS_CC_PLATFORM)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (841c35169323 Linux 6.8-rc4)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (2e82c63333c2 cxl/test: Add support for qos_class c=
hecking)
Merging btrfs-fixes/next-fixes (4f28045e1bdf Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (7e4a205fe56b Revert "get rid of DCACHE_GENOCIDE")
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
Merging scsi-fixes/fixes (379a58caa199 scsi: fnic: Move fnic_fnic_flush_tx(=
) to a work queue)
Merging drm-fixes/drm-fixes (841c35169323 Linux 6.8-rc4)
Merging drm-intel-fixes/for-linux-next-fixes (ad26d56d0807 drm/i915/dp: Lim=
it SST link rate to <=3D8.1Gbps)
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
Merging riscv-soc-fixes/riscv-soc-fixes (a9d022ae8c4f Merge branch 'riscv-s=
oc-drivers-fixes' into riscv-soc-fixes)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (6613476e225e Linux 6.8-rc1)
Merging gpio-brgl-fixes/gpio/for-current (2df8aa3cad40 gpiolib: add gpio_de=
vice_get_label() stub for !GPIOLIB)
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging auxdisplay-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (d9281660ff3f erofs: relaxed temporary buffers al=
location on readahead)
Merging kunit-fixes/kunit-fixes (829388b725f8 kunit: device: Unregister the=
 kunit_bus on shutdown)
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
Merging battery-fixes/fixes (30d529786241 power: supply: mm8013: select REG=
MAP_I2C)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (28b9f669e10f iommufd/iova_bitmap: Consider pa=
ge offset for the pages to be pinned)
Merging rust-fixes/rust-fixes (6613476e225e Linux 6.8-rc1)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (eb5555d422d0 pmdomain: arm: Fix NULL derefere=
nce on scmi_perf_domain removal)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (eb9f7f654f25 i2c: i801: Fix bloc=
k process call transactions)
Merging drm-misc-fixes/for-linux-next-fixes (a64056bb5a32 drm/tests/drm_bud=
dy: add alloc_contiguous test)
Merging mm-stable/mm-stable (841c35169323 Linux 6.8-rc4)
Merging mm-nonmm-stable/mm-nonmm-stable (841c35169323 Linux 6.8-rc4)
Merging mm/mm-everything (53c85376359e Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
  3004524ad6c5 ("mm/damon/sysfs-schemes: handle schemes sysfs dir removal b=
efore commit_schemes_quota_goals")
  3498f26103a5 ("mm/zswap: invalidate duplicate entry when !zswap_enabled")
  36c20ffbf9d0 ("mm/swap: fix race when skipping swapcache")
  4349cdf7ec5c ("lib/Kconfig.debug: TEST_IOV_ITER depends on MMU")
  64181693b8ef ("kasan: guard release_free_meta() shadow access with kasan_=
arch_is_ready()")
  77d92649cb08 ("mm/memblock: add MEMBLOCK_RSRV_NOINIT into flagname[] arra=
y")
  8b9708661553 ("selftests/mm: uffd-unit-test check if huge page size is 0")
  9b3aa86dfddc ("mm/swap_state: update zswap LRU's protection range with th=
e folio locked")
  c229c27c33e6 ("mm/swap_state: update zswap LRU's protection range with th=
e folio locked")
  d57f0bf4b785 ("mm/swap_state: update zswap LRU's protection range with th=
e folio locked (fix)")
  d778af9692df ("mm/damon/core: check apply interval in damon_do_apply_sche=
mes()")
  fabffe22aa32 ("mm: memcontrol: clarify swapaccount=3D0 deprecation warnin=
g")
CONFLICT (content): Merge conflict in mm/zswap.c
Merging kbuild/for-next (5604538b1213 kconfig: do not imply the type of cho=
ice value)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (6d6be5eb45b4 perf metric: Don't remove scale =
from counts)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (8790fade1a19 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (f735966ee23c Merge branches 'for-next/reorg-va=
-space' and 'for-next/rust-for-arm64' into for-next/core)
Merging arm-perf/for-next/perf (fd185a245155 perf/arm_cspmu: Add devicetree=
 support)
Merging arm-soc/for-next (de4b6d6705a7 Merge branch 'soc/defconfig' into fo=
r-next)
Merging amlogic/for-next (c1fd40a19005 Merge branch 'v6.9/arm64-dt' into fo=
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
Merging mediatek/for-next (e630c7b0b6a6 arm64: dts: mediatek: replace under=
scores in node names)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (0012c1958460 Merge branches 'sgx-for-v6.9' and 'omap=
-for-v6.9/soc' into for-next)
Merging qcom/for-next (2b3f57690f30 Merge branches 'arm32-for-6.9', 'arm64-=
defconfig-for-6.9', 'arm64-fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' a=
nd 'drivers-for-6.9' into for-next)
Merging renesas/next (28bcd294c39d Merge branches 'renesas-dt-bindings-for-=
v6.9' and 'renesas-dts-for-v6.9' into renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (504c4c60e70b Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (e7ed5a0ec5bb Merge branches 'fixes', 'next/c=
lk', 'next/defconfig', 'next/drivers', 'next/dt', 'next/dt64' and 'next/soc=
' into for-next)
Merging scmi/for-linux-next (99f798bdfb75 Merge tags 'scmi-fixes-6.8' and '=
ffa-fixes-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux into for-linux-next)
Merging sophgo/for-next (41bccc98fb79 Linux 6.8-rc2)
Merging stm32/stm32-next (7fd195f01ae5 ARM: dts: stm32: lxa-tac: reduce RGM=
II interface drive strength)
Merging sunxi/sunxi/for-next (5db172482d9d Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (b762ac6498e6 Merge branch for-6.9/soc into for-next)
Merging ti/ti-next (bc805e337f69 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (efe5a1b888ab Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (6613476e225e Linux 6.8-rc1)
Merging clk-renesas/renesas-clk (46fb5dd9ca28 clk: renesas: r9a07g04[34]: F=
ix typo for sel_shdi variable)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (cca5efe77a6a LoongArch: vDSO: Disable UBS=
AN instrumentation)
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (841c35169323 Linux 6.8-rc4)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (841c35169323 Linux 6.8-rc4)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (82b143aeb169 Revert "parisc: Only list existing=
 CPUs in cpu_possible_mask")
Merging powerpc/next (14ce0dbb5627 powerpc: ibmebus: make ibmebus_bus_type =
const)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (cb4ede926134 riscv: Avoid code duplication with ge=
neric bitops implementation)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (5669bb5a16a0 riscv: dts: microchip: add=
 specific compatible for mpfs pdma)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (520a2cee1fbc Merge branch 'features' into for-next)
Merging sh/for-next (6613476e225e Linux 6.8-rc1)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (a03cd7602a09 xtensa: don't produce FDPIC ou=
tput with fdpic toolchain)
Merging bcachefs/for-next (a1f717efef35 thread_with_file: Fix missing va_en=
d())
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
Merging cifs/for-next (6a17baa9c937 smb3: allow files to be created with ba=
ckslash in name)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (aa12a790d31b erofs: make erofs_{err,info}() support NULL=
 sb parameter)
Merging exfat/dev (0991abeddefa exfat: fix zero the unwritten part for dio =
read)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (3461c4f52504 Pull quota rcu annotations and qtree lo=
op detection code.)
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
Merging ksmbd/ksmbd-for-next (841c35169323 Linux 6.8-rc4)
Merging nfs/linux-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (e36ddb3c9164 NFSD: Document the phases of CREATE_SE=
SSION)
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (adbf4c4954e3 ubi: block: fix memleak in ubiblock_create=
())
Merging v9fs/9p-next (be3193e58ec2 9p: Fix read/write debug statements to r=
eport server reply)
Merging v9fs-ericvh/ericvh/for-next (be57855f5050 fs/9p: fix dups even in u=
ncached mode)
Merging xfs/for-next (9ee85f235efe xfs: ensure submit buffers on LSN bounda=
ries in error handlers)
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
Merging vfs-brauner/vfs.all (2bd8e615a5c3 Merge branch 'vfs.uuid' into vfs.=
all)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
CONFLICT (content): Merge conflict in fs/nfsd/nfs4layouts.c
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (e7081d5a9d97 Merge branch 'rework/console-flushing=
-fixes' into for-next)
Merging pci/next (3ab548e487fc Merge branch 'pci/misc')
Merging pstore/for-next/pstore (69f381e67d6f pstore/zone: Add a null pointe=
r check to the psz_kmsg_read)
Merging hid/for-next (8f0a3ff87887 Merge branch 'for-6.9/nintendo' into for=
-next)
Merging i2c/i2c/for-next (957bd221ac7b Merge tag 'i2c-host-fixes-6.8-rc3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/f=
or-current)
Merging i2c-host/i2c/i2c-host (48acf8292280 i2c: Remove redundant compariso=
n in npcm_i2c_reg_slave)
Merging i3c/i3c/next (4fa0888f6f3e i3c: document hotjoin sysfs entry)
Merging hwmon-staging/hwmon-next (74d0d066bfaf hwmon: (pmbus/ir38064) Use P=
MBUS_REGULATOR_ONE to declare regulator)
Merging jc_docs/docs-next (6fca09b64f2e docs: dev-tools: checkpatch.rst: Fi=
x grammar)
Merging v4l-dvb/master (feb8831be9d4 media: ov08x40: Reduce start streaming=
 time)
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging v4l-dvb-next/master (8c64f4cdf4e6 media: edia: dvbdev: fix a use-af=
ter-free)
Merging pm/linux-next (0adb9b4f4415 Merge branch 'pm-em' into linux-next)
CONFLICT (content): Merge conflict in drivers/pci/pci.c
Merging cpufreq-arm/cpufreq/arm/linux-next (eaffb10b51bf cpufreq: mediatek-=
hw: Don't error out if supply is not found)
Merging cpupower/cpupower (0086ffec768b tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
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
Merging net-next/main (d1d77120bc28 net: phy: dp83826: support TX data volt=
age tuning)
Merging bpf-next/for-next (a4561f5afef8 bpf: Use O(log(N)) binary search to=
 find line info record)
Merging ipsec-next/master (1476de6d2b57 xfrm: Simplify the allocation of sl=
ab caches in xfrm_policy_init)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (f77581bfda24 Merge branch 'add-multi-buff-supp=
ort-for-xdp-running-in-generic-mode')
Merging ipvs-next/main (5264ab612e28 selftests/net: calibrate txtimestamp)
Merging bluetooth/master (1405ad2e8a9d Bluetooth: hci_conn: Always use sk_t=
imeo as conn_timeout)
Merging wireless-next/for-next (182094411e29 wifi: iwlwifi: mvm: check own =
capabilities for EMLSR)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/mvm.h
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/tx.c
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
Merging crypto/master (e8829ef1f73f crypto: rsa - restrict plaintext/cipher=
text values more)
Merging drm/drm-next (b344e64fbda3 Merge tag 'amd-drm-next-6.9-2024-02-09' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/h=
w_sequencer_private.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/resour=
ce/dcn35/dcn35_resource.c
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (f8e4806e0dfa Merge tag 'drm-misc-next-20=
24-01-11' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (aa1267e673fe drm: ci: use clk_ignore_unuse=
d for apq8016)
Applying: drm/ttm: initialise places
Merging amdgpu/drm-next (efc11f34e25f drm/amdgpu: support psp ip block disc=
overy for psp v14)
Merging drm-intel/for-linux-next (1b923307a1b0 drm/i915: Enable fastboot ac=
ross the board)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (41c177cf3541 Merge tag 'drm-misc-next-2024-02-08'=
 into msm-next)
Merging drm-msm-lumag/msm-next-lumag (3b56d27ba157 drm/msm/dsi: Document DS=
C related pclk_rate and hdisplay calculations)
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (cfe1cab458f0 Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (d7bf73809849 ALSA: seq: fix function cast warnings)
Merging ieee1394/for-next (41ebb53b1bff firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (5f97ce009a7f Merge remote-tracking branch 'aso=
c/for-6.9' into asoc-next)
Merging modules/modules-next (157285397f6a lib/test_kmod: fix kernel-doc wa=
rnings)
Merging input/next (d03f030115fe Input: gameport - make gameport_bus const)
Merging block/for-next (03d8e37dfd70 Merge branch 'for-6.9/io_uring' into f=
or-next)
CONFLICT (content): Merge conflict in block/blk.h
CONFLICT (content): Merge conflict in include/linux/sched.h
Merging device-mapper/for-next (4162ae412cbf dm vdo string-utils: change fr=
om uds_ to vdo_ namespace)
Merging libata/for-next (4d253afdd92e Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (0deb3c2ac936 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (d5132d176d6f mfd: rc5t583: Convert to use maple t=
ree register cache)
Merging backlight/for-backlight-next (770c0f4975fd dt-bindings: backlight: =
qcom-wled: Fix bouncing email addresses)
Merging battery/for-next (14c5678720bd power: reset: syscon-poweroff: Use d=
evm_register_sys_off_handler(POWER_OFF))
Merging regulator/for-next (9281b5c2a969 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (97280fa1ed94 Automated merge of 'dev' into 'next')
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (1ed4b5631002 Revert "KEYS: encrypted: Add=
 check for strsep")
Merging selinux/next (7c655bee5cd8 selinux: only filter copy-up xattrs foll=
owing initialization)
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (cebb9ce9b939 tpm/tpm_ftpm_tee: fix all kernel-doc warni=
ngs)
Merging watchdog/master (41bccc98fb79 Linux 6.8-rc2)
Merging iommu/next (3294375f40f3 Merge branches 'arm/renesas', 'x86/amd' an=
d 'core' into next)
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
Merging spi/for-next (3f4df502f5b4 Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (7376e4679540 Merge branch into tip/master: 'x86/vdso')
Merging clockevents/timers/drivers/next (69518264da62 dt-bindings: timer: r=
enesas: ostm: Document RZ/Five SoC)
Merging edac/edac-for-next (8fe11c7a20eb Merge ras/edac-misc into for-next)
Merging ftrace/for-next (4af12c95cbe8 Merge probes/for-next)
Merging rcu/rcu/next (5ce7264a2557 rcutorture: Disable KPROBES to permit Ta=
sks Rude RCU testing)
Merging kvm/next (687d8f4c3dea Merge branch 'kvm-kconfig')
Merging kvm-arm/next (160ab417fdd0 Merge branch kvm-arm64/misc into kvmarm/=
next)
Merging kvms390/next (10f7b1dcdfe0 KVM: s390: cpu model: Use proper define =
for facility mask size)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (f072b272aa27 RISC-V: KVM: Use correct res=
tricted types)
Merging kvm-x86/next (7455665a3521 Merge branches 'asyncpf', 'asyncpf_abi',=
 'fixes', 'generic', 'misc', 'mmu', 'pmu', 'selftests', 'svm' and 'vmx')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/sev.c
Merging xen-tip/linux-next (fa765c4b4aed xen/events: close evtchn after map=
ping cleanup)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (2f34d7337d98 workqueue: Fix queue_work_on() wi=
th BH workqueues)
Merging drivers-x86/for-next (c5211eacf332 platform/x86: ideapad-laptop: su=
pport Fn+R dual-function key)
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (e3c5df138169 firmware: =
coreboot: make coreboot_bus_type const)
Merging hsi/for-next (a0e35a173a86 hsi: hsi_core: make hsi_bus_type const)
Merging leds-lj/for-leds-next (12ce20e02e53 leds: trigger: netdev: Fix kern=
el panic on interface rename trig notify)
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (f297a3844aa0 driver core: component: =
fix spellos)
Merging usb/usb-next (88bae831f381 usb: typec: ucsi: Add qcm6490-pmic-glink=
 as needing PDOS quirk)
Merging thunderbolt/next (e96efb1191de thunderbolt: Correct typo in host_re=
set parameter)
Merging usb-serial/usb-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging tty/tty-next (6cc3028f797a tty: vt: decrypt magic constants in vc_i=
s_control())
Merging char-misc/char-misc-next (e21817acb23e Merge 6.8-rc3 into char-misc=
-next)
Merging accel/habanalabs-next (dddb2e526a36 accel/habanalabs: use kcalloc()=
 instead of kzalloc())
Merging coresight/next (c099fdd218a0 coresight: tpdm: Fix build break due t=
o uninitialised field)
Merging fastrpc/for-next (6613476e225e Linux 6.8-rc1)
Merging fpga/for-next (ff49b00e9621 fpga: dfl: make dfl_bus_type const)
Merging icc/icc-next (b9a9c447277f Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (a0295c1bd4a7 iio: frequency: admfm2000: New driver)
Merging phy-next/next (bc25f0b57133 phy: ti: gmii-sel: add resume support)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
c
Merging soundwire/next (9282cfa2eb08 soundwire: intel_auxdevice: remove red=
undant assignment to variable link_flags)
Merging extcon/extcon-next (7803680964c0 extcon: qcom-spmi-misc: don't use =
kernel-doc marker for comment)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (78f70c02bdbc vfio/virtio: fix virtio-pci dependency)
Merging w1/for-next (178cf9db9e6d w1: add UART w1 bus driver)
Applying: fixup for "w1: add UART w1 bus driver"
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (ce54e9342124 staging: Remove board staging co=
de)
Merging counter-next/counter-next (295afc57e51c counter: make counter_bus_t=
ype const)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (de7d9cb3b064 dmaengine: fsl-edma: integrate TCD64 s=
upport for i.MX95)
Merging cgroup/for-next (8d4c171f451d docs: cgroup-v1: add missing code-blo=
ck tags)
Merging scsi/for-next (d916827cb6ee Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (a0bcad233fd6 scsi: core: Make scsi_bus_type cons=
t)
Merging vhost/linux-next (f16d65124380 vdpa/mlx5: Add mkey leak detection)
Merging rpmsg/for-next (929654e8f1ad Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
CONFLICT (content): Merge conflict in drivers/remoteproc/imx_dsp_rproc.c
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (e3f927f2b0a2 Documentation: gpio: consiste=
ntly use logical line value terminology)
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (b3b8c7865c27 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (fea58424e252 pinctrl: renesas: pin=
ctrl-rzg2l: Add the missing port pins P19 to P28)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (ab105bfee277 pwm: bcm2835: Drop write-only member=
 of driver private data)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (345e8abe4c35 selftests/resctrl: Get domain id from =
cache id)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (76021a887a50 kunit: Mark filter* params as rw)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (14688f1a91e1 rtc: nuvoton: Compatible with NCT3015Y-R=
 and NCT3018Y-R)
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
Merging auxdisplay/for-next (4fdcbb88b1a8 dt-bindings: auxdisplay: hit,hd44=
780: use defines for GPIO flags)
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
Merging landlock/next (305aea29fd67 landlock: Document IOCTL support)
Merging rust/rust-next (f090f0d0eea9 rust: sync: update integer types in Co=
ndVar)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
Merging sysctl/sysctl-next (cec030ec414e MAINTAINERS: Update sysctl tree lo=
cation)
Merging execve/for-next/execve (15fd1dc3dadb fs: binfmt_elf_efpic: don't us=
e missing interpreter's properties)
Merging bitmap/bitmap-for-next (071ad962baf5 bitmap: Step down as a reviewe=
r)
CONFLICT (content): Merge conflict in drivers/tty/serial/sc16is7xx.c
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (e9ae38cda7dc overflow: Introduce wrapping_assig=
n_add() and wrapping_assign_sub())
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/9xb0L8042ywVSDaZsAjrnE1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXNinMACgkQAVBC80lX
0GzYmgf/UxofHdE86EjT9X5zwPZxCfrPumPjTcWmB5z6/3C8vXOLOhVf4NKRhmwq
4PC9E0NkSDJHWU+bQl00B/xHbNJbgF0XJSPSFOjlAHfc5CKb6rS0+fQ4yn2O84VN
wLxfHvFnSqQwy9ooTdOsBVRqianOWxHQIOCMaaZAMwhBeeZ/bE/f0NNg6s1+gXYk
H9ihLgMpif8GDDbJD4Gr/LadstKIQGyOzAodCLpJ/VWhbGH3cLiB8aXeeUD4KErG
u8M1oNuggB+pxNZ/HmZoBMv6HF+cFazg3ckNmxixixoyJT2ypjk6fqKHIL0gLYZC
EaqjQjpd6mdjHioVO0pXdqGNF7y27Q==
=hhYY
-----END PGP SIGNATURE-----

--Sig_/9xb0L8042ywVSDaZsAjrnE1--

