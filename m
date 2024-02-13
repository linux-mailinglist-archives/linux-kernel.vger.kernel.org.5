Return-Path: <linux-kernel+bounces-62925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB628527ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437DD1F22CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED78A93D;
	Tue, 13 Feb 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZIdL0mFs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09374AD24;
	Tue, 13 Feb 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797296; cv=none; b=KpOxCtMun6tRyjfLZZHgav/u7Wsp1d/N+eJVdLULI5SfFH6MExhmRZQrXQfIb+012q81MooeHh4z8dPzXEuo+yj14WuARrP+kMFakxj9K6A059oaoncCxSadY8TT8i94efS5byiNFgFhNxQydCrIF9k8Hp2wIvPHb6tD8jTbuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797296; c=relaxed/simple;
	bh=NPzS+Gc4eapT9r6vzxGoinzbbDN61GhOUu58UUEd/mc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AtpR7s9pBQZsuEsYWB1RwmS6zfHUnMxKOMEBAdpo7wKbtM8FriqNGZaXMO3QHUjZRUtz7eO0EsbqXIHS5RdgEu7h/o0PmhcXQDrQd+c1BDGtDcpN8UNDEKpzHyBTK9BmH4dGcip6+YwqXzW53/9z/MQ6fNfEkSZspPWz26VCte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZIdL0mFs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707797290;
	bh=mGnHZmfw6Chh/KxP3SY3CvZYTjYlixp1h3zIf3wfbKA=;
	h=Date:From:To:Cc:Subject:From;
	b=ZIdL0mFsXTeJV5Q9aIP292+ItvqxMFGkZIUlwHKbTmaCSxCM8EeRTqu/yOk+K1dwc
	 iH9TociRT1S1MXaZa6mQzYxa8aCnNANuxiFkpaQX3ZeNbD3QtOIPEHf04VgbBeqo7N
	 TyHaZlE6142QrJ88CkR/e7jlHasweshA0e+gqZ8q5OC9/Yic3lwV2iV8SN33N2Tq+5
	 kF7yekZD8ep2g0BaQuA0aKkmgNwJCb88lmp06HRjus6qrEroca0uSWYhu5DMTn5nQk
	 /xEiti5713yHffEpXDqX/RiHpemxGJsyL39htBjo5wJz/prNG+aXWuZC6yXPWc5knE
	 rRTitlhk0jAEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYnqZ0zZWz4wcl;
	Tue, 13 Feb 2024 15:08:10 +1100 (AEDT)
Date: Tue, 13 Feb 2024 15:08:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 13
Message-ID: <20240213150809.3c95d2f8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TMgqnlNTir+bt3.=dUxYEkc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TMgqnlNTir+bt3.=dUxYEkc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240212:

New trees: auxdisplay-as, auxdisplay-fixes

The bcachefs tree lost its build failure.

The vfs-brauner tree lost its build failure and gained conflict against
the bcachefs tree.

The wireless-next tree gained conflict against the pm tree.

The drm-misc tree lost its build failure but gained another so I used
the version from next-20240209.

The amdgpu tree gained a build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 5774
 5998 files changed, 287961 insertions(+), 116901 deletions(-)

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
Merging origin/master (716f4aaa7b48 Merge tag 'vfs-6.8-rc5.fixes' of git://=
git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (8d4f3d0dad0d mm/memblock: add MEM=
BLOCK_RSRV_NOINIT into flagname[] array)
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
Merging powerpc-fixes/fixes (1c57b9f63ab3 powerpc: 85xx: mark local functio=
ns static)
Merging s390-fixes/fixes (124468af7e76 s390/configs: update default configu=
rations)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (5b3fbd61b9d1 net: sysfs: Fix /sys/class/net/<iface> path =
for statistics)
Merging bpf/master (577e4432f3ac tcp: add sanity checks to rx zerocopy)
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (5a8cdf6fd860 netfilter: nft_set_pipapo: remove scra=
tch_aligned pointer)
Merging ipvs/main (5a8cdf6fd860 netfilter: nft_set_pipapo: remove scratch_a=
ligned pointer)
Merging wireless/for-next (b7198383ef2d wifi: iwlwifi: mvm: fix a crash whe=
n we run out of stations)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (fdfa083549de RDMA/srpt: Support specifying the s=
rpt_service_guid parameter)
Merging sound-current/for-linus (e5aa6d51a2ef ALSA: hda/cs35l56: select int=
ended config FW_CS_DSP)
Merging sound-asoc-fixes/for-linus (f7fe85b229bc ASoC: amd: yc: Fix non-fun=
ctional mic on Lenovo 82UU)
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (46d5baf046ab MAINTAINERS: repair entry f=
or MICROCHIP MCP16502 PMIC DRIVER)
Merging spi-fixes/for-linus (8f44e3808200 spi: intel-pci: Add support for L=
unar Lake-M SPI serial flash)
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
Merging char-misc.current/char-misc-linus (51c161008e04 Merge tag 'icc-6.8-=
rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-=
misc-linus)
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
Merging mips-fixes/mips-fixes (59be5c358501 mips: Call lose_fpu(0) before i=
nitializing fcr31 in mips_set_personality_nan)
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
Merging btrfs-fixes/next-fixes (c94bd41cb0b6 Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (7e4a205fe56b Revert "get rid of DCACHE_GENOCIDE")
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (1abdf288b0ef platform/x86: touchscreen_dmi=
: Add info for the TECLAST X16 Plus tablet)
Merging samsung-krzk-fixes/fixes (eab4f56d3e75 ARM: dts: exynos4212-tab3: a=
dd samsung,invert-vclk flag to fimd)
Merging pinctrl-samsung-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging devicetree-fixes/dt/linus (8f1e0d791b52 of: property: Add in-ports/=
out-ports support to of_graph_get_port_parent())
Merging dt-krzk-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging scsi-fixes/fixes (17e94b258541 scsi: ufs: core: Remove the ufshcd_r=
elease() in ufshcd_err_handling_prepare())
Merging drm-fixes/drm-fixes (841c35169323 Linux 6.8-rc4)
Merging drm-intel-fixes/for-linux-next-fixes (ad26d56d0807 drm/i915/dp: Lim=
it SST link rate to <=3D8.1Gbps)
Merging mmc-fixes/fixes (cc9432c4fb15 mmc: slot-gpio: Allow non-sleeping GP=
IO ro)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3951f6add519 riscv: Fix arch_tlbbatch_flush() b=
y clearing the batch cpumask)
Merging riscv-dt-fixes/riscv-dt-fixes (6613476e225e Linux 6.8-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (a9d022ae8c4f Merge branch 'riscv-s=
oc-drivers-fixes' into riscv-soc-fixes)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (6613476e225e Linux 6.8-rc1)
Merging gpio-brgl-fixes/gpio/for-current (841c35169323 Linux 6.8-rc4)
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
Merging efi-fixes/urgent (1ad55cecf22f x86/efistub: Use 1:1 file:memory map=
ping for PE/COFF .compat section)
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
Merging pmdomain-fixes/fixes (c41336f4d690 pmdomain: mediatek: fix race con=
ditions with genpd)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (32e9b680de4b i2c: i2c-qcom-geni:=
 Correct I2C TRE sequence)
Merging drm-misc-fixes/for-linux-next-fixes (2c80a2b715df nouveau/svm: fix =
kvcalloc() argument order)
Merging mm-stable/mm-stable (54be6c6c5ae8 Linux 6.8-rc3)
Merging mm-nonmm-stable/mm-nonmm-stable (54be6c6c5ae8 Linux 6.8-rc3)
Merging mm/mm-everything (579a90ce2e8e Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (a8fdabe1e15d kbuild: deb-pkg: call more misc debhe=
lper commands)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (c7ba9d18ae47 perf srcline: Add missed addr2li=
ne closes)
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
Merging amlogic/for-next (0dd3ee311255 Linux 6.7)
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
Merging mediatek/for-next (99d100e00144 arm64: dts: mediatek: mt7622: add m=
issing "device_type" to memory nodes)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (0012c1958460 Merge branches 'sgx-for-v6.9' and 'omap=
-for-v6.9/soc' into for-next)
Merging qcom/for-next (f7b0172f074a Merge branches 'arm32-for-6.9', 'arm64-=
defconfig-for-6.9', 'arm64-fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' a=
nd 'drivers-for-6.9' into for-next)
Merging renesas/next (91487349a9c3 Merge branch 'renesas-dts-for-v6.9' into=
 renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (13c241737fc0 Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (e7ed5a0ec5bb Merge branches 'fixes', 'next/c=
lk', 'next/defconfig', 'next/drivers', 'next/dt', 'next/dt64' and 'next/soc=
' into for-next)
Merging scmi/for-linux-next (99f798bdfb75 Merge tags 'scmi-fixes-6.8' and '=
ffa-fixes-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux into for-linux-next)
Merging sophgo/for-next (41bccc98fb79 Linux 6.8-rc2)
Merging stm32/stm32-next (bda732fda193 ARM: dts: stm32: fix DSI peripheral =
clock on stm32mp15 boards)
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
Merging clk-renesas/renesas-clk (5aaa139b9a03 clk: renesas: r8a779h0: Add I=
2C clocks)
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
Merging powerpc/next (41bccc98fb79 Linux 6.8-rc2)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (cb4ede926134 riscv: Avoid code duplication with ge=
neric bitops implementation)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/bitops.h
Merging riscv-dt/riscv-dt-for-next (5669bb5a16a0 riscv: dts: microchip: add=
 specific compatible for mpfs pdma)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (e4618114eb74 Merge branch 'features' into for-next)
Merging sh/for-next (6613476e225e Linux 6.8-rc1)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (a03cd7602a09 xtensa: don't produce FDPIC ou=
tput with fdpic toolchain)
Merging bcachefs/for-next (92e51c8c41e3 bcachefs: Track iter->ip_allocated =
at bch2_trans_copy_iter())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (d3a7bd420076 fscrypt: clear keyring before callin=
g key_put())
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (c76800fdde78 Merge branch 'for-next-next-v6.8-20240=
206' into for-next-20240206)
Merging ceph/master (07045648c07c ceph: always check dir caps asynchronousl=
y)
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
Merging xfs/for-next (881f78f47255 xfs: remove conditional building of rt g=
eometry validator functions)
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
Merging vfs-brauner/vfs.all (2bd8e615a5c3 Merge branch 'vfs.uuid' into vfs.=
all)
CONFLICT (content): Merge conflict in fs/bcachefs/super-io.c
CONFLICT (content): Merge conflict in fs/nfsd/nfs4layouts.c
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (e7081d5a9d97 Merge branch 'rework/console-flushing=
-fixes' into for-next)
Merging pci/next (cc24b2d080dc Merge branch 'pci/endpoint')
Merging pstore/for-next/pstore (69f381e67d6f pstore/zone: Add a null pointe=
r check to the psz_kmsg_read)
Merging hid/for-next (b582e8c3ccc7 Merge branch 'for-6.8/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (957bd221ac7b Merge tag 'i2c-host-fixes-6.8-rc3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/f=
or-current)
Merging i2c-host/i2c/i2c-host (857cc04cdf50 i2c: i801: Add helper i801_get_=
block_len)
Merging i3c/i3c/next (4fa0888f6f3e i3c: document hotjoin sysfs entry)
Merging hwmon-staging/hwmon-next (1c365b5017d0 hwmon: (oxp-sensors) Add sup=
port for Ayaneo Air Plus 7320u.)
Merging jc_docs/docs-next (5372fdcfd25e Merge branch 'docs-fixes' into docs=
-mw)
  b66140d8e43f ("docs: filesystems: fix typo in docs")
Merging v4l-dvb/master (feb8831be9d4 media: ov08x40: Reduce start streaming=
 time)
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging v4l-dvb-next/master (8c64f4cdf4e6 media: edia: dvbdev: fix a use-af=
ter-free)
Merging pm/linux-next (a3589a70b933 Merge branch 'pm-sleep' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (eaffb10b51bf cpufreq: mediatek-=
hw: Don't error out if supply is not found)
Merging cpupower/cpupower (0086ffec768b tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
Merging pmdomain/next (d99abefade74 media: venus: Convert to dev_pm_domain_=
attach|detach_list() for vcodec)
Merging opp/opp/linux-next (ace4b31b297d cpufreq: Move dev_pm_opp_{init|fre=
e}_cpufreq_table() to pm_opp.h)
Merging thermal/thermal/linux-next (5314b1543787 thermal/drivers/exynos: Us=
e set_trips ops)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (aafe4cc50969 RDMA/rxe: Remove unused 'iova' paramete=
r from rxe_mr_init_user)
Merging net-next/main (0f37666d87d2 Merge branch 'net-avoid-slow-rcu')
Merging bpf-next/for-next (68bc61c26cac bpf: Allow compiler to inline most =
of bpf_local_storage_lookup())
Merging ipsec-next/master (1476de6d2b57 xfrm: Simplify the allocation of sl=
ab caches in xfrm_policy_init)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (970cb1ceda17 Merge branch 'phy-package')
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
Merging drm/drm-next (0de62399883d Merge tag 'drm-misc-next-2024-02-08' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
  87399f1ff922 ("media: tc358743: register v4l2 async device only after suc=
cessful setup")
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (f8e4806e0dfa Merge tag 'drm-misc-next-20=
24-01-11' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (247f2ee4498c drm/xe: Fix a missing argumen=
t to drm_err_printer)
Applying: drm/ttm: initialise places
$ git reset --hard HEAD^
Merging next-20240209 version of drm-misc
Applying: drm/ttm: initialise places
Merging amdgpu/drm-next (1b4117725703 Revert "drm/amd: flush any delayed gf=
xoff on suspend entry")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/d=
cn21/dcn21_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/h=
w_sequencer_private.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/resour=
ce/dcn35/dcn35_resource.c
Merging drm-intel/for-linux-next (cd1f0d3df26a drm/i915/dvo: Use sizeof(*va=
riable) instead of sizeof(type))
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
Merging sound/for-next (e129d6c9ac71 ALSA: doc: Use DEFINE_SIMPLE_DEV_PM_OP=
S())
Merging ieee1394/for-next (41ebb53b1bff firewire: core: fix build failure d=
ue to the caller of fw_csr_string())
Merging sound-asoc/for-next (3235757ccda0 Merge remote-tracking branch 'aso=
c/for-6.9' into asoc-next)
Merging modules/modules-next (157285397f6a lib/test_kmod: fix kernel-doc wa=
rnings)
Merging input/next (d03f030115fe Input: gameport - make gameport_bus const)
Merging block/for-next (f8c9abbb8fa6 Merge branch 'for-6.9/block' into for-=
next)
CONFLICT (content): Merge conflict in block/blk.h
Merging device-mapper/for-next (2727bad6a6d1 dm vdo volume-index: fix an as=
sert statement in start_restoring_volume_sub_index())
Merging libata/for-next (7627a0edef54 ata: ahci: Drop low power policy boar=
d type)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (40d83f40c44b mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (d5132d176d6f mfd: rc5t583: Convert to use maple t=
ree register cache)
Merging backlight/for-backlight-next (770c0f4975fd dt-bindings: backlight: =
qcom-wled: Fix bouncing email addresses)
Merging battery/for-next (aa08a0d10f5e power: supply: axp20x_usb_power: ena=
ble usb_type reporting)
Merging regulator/for-next (3240695334aa Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Merging security/next (54be6c6c5ae8 Linux 6.8-rc3)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (1ed4b5631002 Revert "KEYS: encrypted: Add=
 check for strsep")
Merging selinux/next (7c655bee5cd8 selinux: only filter copy-up xattrs foll=
owing initialization)
Merging smack/next (f0816d4332c3 ramfs: Initialize security of in-memory in=
odes)
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (cebb9ce9b939 tpm/tpm_ftpm_tee: fix all kernel-doc warni=
ngs)
Merging watchdog/master (41bccc98fb79 Linux 6.8-rc2)
Merging iommu/next (3294375f40f3 Merge branches 'arm/renesas', 'x86/amd' an=
d 'core' into next)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (db7f204f5092 MAINTAINERS: of: Add Saravana Kan=
nan)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/tri=
vial-devices.yaml
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (7bf8e2dd6d5c Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (f2361f2bcbb4 Merge branch into tip/master: 'x86/vdso')
Merging clockevents/timers/drivers/next (0076a37a426b dt-bindings: timer: r=
enesas,tmu: Document input capture interrupt)
Merging edac/edac-for-next (2f412b51fb42 Merge ras/edac-amd-atl into for-ne=
xt)
Merging ftrace/for-next (4af12c95cbe8 Merge probes/for-next)
Merging rcu/rcu/next (c7fef2f0578d tsc: Check for sockets instead of CPUs t=
o make code match comment)
Merging kvm/next (e45964771007 x86/coco: Define cc_vendor without CONFIG_AR=
CH_HAS_CC_PLATFORM)
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
Merging xen-tip/linux-next (841c35169323 Linux 6.8-rc4)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (bf52b1ac6ab4 async: Use a dedicated unbound wo=
rkqueue with raised min_active)
Merging drivers-x86/for-next (d16c9a3d97d1 Merge tag 'platform-drivers-x86-=
v6.8-2' into pdx/for-next)
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
Merging thunderbolt/next (dec6a613574c thunderbolt: Remove usage of the dep=
recated ida_simple_xx() API)
Merging usb-serial/usb-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging tty/tty-next (6cc3028f797a tty: vt: decrypt magic constants in vc_i=
s_control())
Merging char-misc/char-misc-next (e21817acb23e Merge 6.8-rc3 into char-misc=
-next)
Merging accel/habanalabs-next (dddb2e526a36 accel/habanalabs: use kcalloc()=
 instead of kzalloc())
Merging coresight/next (1bbe0a247e5d coresight: etm4x: Set skip_power_up in=
 etm4_init_arch_data function)
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
Merging w1/for-next (56552c1a412f dt-bindings: w1: UART 1-Wire bus)
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
Merging scsi/for-next (59828c7b5975 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (a0bcad233fd6 scsi: core: Make scsi_bus_type cons=
t)
Merging vhost/linux-next (f16d65124380 vdpa/mlx5: Add mkey leak detection)
Merging rpmsg/for-next (929654e8f1ad Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
CONFLICT (content): Merge conflict in drivers/remoteproc/imx_dsp_rproc.c
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (5e6284444024 gpio: mark unsafe gpio_chip m=
anipulators as deprecated)
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (da98bf28ca30 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (fea58424e252 pinctrl: renesas: pin=
ctrl-rzg2l: Add the missing port pins P19 to P28)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (ab105bfee277 pwm: bcm2835: Drop write-only member=
 of driver private data)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (6a71770442b5 selftests: livepatch: Test livepatchin=
g a heavily called syscall)
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
Merging nvmem/for-next (a0cfd5e99782 dt-bindings: nvmem: Convert xlnx,zynqm=
p-nvmem.txt to yaml)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (c52391fafcef auxdisplay: img-ascii-lcd: Use =
device_get_match_data())
Merging auxdisplay-as/for-next (6613476e225e Linux 6.8-rc1)
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
Merging sysctl/sysctl-next (6613476e225e Linux 6.8-rc1)
Merging execve/for-next/execve (15fd1dc3dadb fs: binfmt_elf_efpic: don't us=
e missing interpreter's properties)
Merging bitmap/bitmap-for-next (071ad962baf5 bitmap: Step down as a reviewe=
r)
CONFLICT (content): Merge conflict in drivers/tty/serial/sc16is7xx.c
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (4e053671927f hardening: drop obsolete DRM_LEGAC=
Y from config fragment)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)
Applying: fixup for "drm/amd: Stop evicting resources on APUs in suspend"

--Sig_/TMgqnlNTir+bt3.=dUxYEkc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXK6ykACgkQAVBC80lX
0Gwbdwf/X6/aq3Fy8Kuid5vNtzIMmk9ItToJlhV2Gxcxw59UPZbmcVHwbUQg+puW
hLQB42DAbcHsQkJuFkpMLleJ4bJHFIaIZ6YGGiukM2G7u4PJpDsU98HRCrPFV6Dj
of4RV/ES7WfrKU1/PXG9yuHaFV4WCiyWE11WOxHeQgG30j4RVPqxarX0Uqg4W7om
rnHkCr+4spsM8kv/42MDQG0uMpA4FH8rltm7uogYcX8I6Xk3W7+RylSv+aW2JSyb
VEi39VzWmaGe5v2NuSCwe9vmvVHonwo76dVkDs33ywfyRHTcMxi/YHK8Nx3VUp0m
e+ebPNyWtGY4rpLVwFvDKxqIDP538Q==
=t7du
-----END PGP SIGNATURE-----

--Sig_/TMgqnlNTir+bt3.=dUxYEkc--

