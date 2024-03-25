Return-Path: <linux-kernel+bounces-116377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA855889987
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AC42C28AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E467D12E1CD;
	Mon, 25 Mar 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FVxc49Zw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F71494C7;
	Mon, 25 Mar 2024 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331288; cv=none; b=l9poO2GAAmjdff5qHJJ7/VliIYXSp/rZ/hk9HnbzRXvH947IZeFijCRIvner4P0G3gYym9N/pqUUhk57H4aksp9EaLOwfRDWmtCXStC0Jeibgox6Z0GqZkEchGugs/evKH7/QjxwuDf8brpf/tqrBjxSZ56Fmk0yO9Q4qPLXqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331288; c=relaxed/simple;
	bh=tXBAgV6oY4OdBxaUIzr52/oilkhaNV6uSE2Hy8y6XXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OvlMO/rOAbyb2ihwrYaoo6M8L9uR36M1LV0+0kMwdxhBeX4E3gkIeOyPHbu/4YFLqcH9o8BkGeruIYtxzwQpO0te4AkbNXa245VNtNbBRiARpiAZ8WIq9+EcHFucn+ccRlX/3XexIQXSkH88M5sWFq5JljnDFbCRcIT1/XXfoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FVxc49Zw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711331282;
	bh=WmlZlb4HuIj261WtcBE5YkthzXZIm38caB7Ti2LOJsI=;
	h=Date:From:To:Cc:Subject:From;
	b=FVxc49ZwZKkMgOEMuE4T1lF0XIzbQ9+t8pa4/Twc4MZsHfb1BL1gVSTckmazQQPfv
	 WYhr0tmKjmQuT5EnnPKL80BX67VI8JkpSp/W3J27xfm3QSjVT6KduZ7XsgDYhMhX9u
	 tHIh0vQKKEqBj9sym8IMEIJ1tcw4Ugfgf43vzrd1axo+dYAIqnACT8L7NlMVMbvuwI
	 3J0l0XOAx71YJ/d4xhZcwfL3QziDE66GdYarcf523g5Qa4gLkG+KJ8USO2hUZBo41H
	 SrZXiWzfGKYMNVivtjGxCjEIQeFf1JgaRC48wo6S8HbpDRs89376aKTaAEXiYxveuY
	 6+PLYwOA9HHwg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2wmy60kJz4wc1;
	Mon, 25 Mar 2024 12:48:02 +1100 (AEDT)
Date: Mon, 25 Mar 2024 12:48:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 25
Message-ID: <20240325124802.03f68f20@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pTQ+4mATSi+uQyzkS4j.keE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pTQ+4mATSi+uQyzkS4j.keE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240322:

The perf tree lost its build failure.

The random tree gained a build failure so I used the version from
next-20240322.

Non-merge commits (relative to Linus' tree): 907
 1021 files changed, 26012 insertions(+), 11755 deletions(-)

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
Merging origin/master (4cece7649650 Linux 6.9-rc1)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (1e183e67e263 hexagon: vmlinux.lds=
S: handle attributes section)
Merging kbuild-current/fixes (bfa8f18691ed Merge tag 'scsi-misc' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
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
Merging s390-fixes/fixes (b0546776ad3f Merge tag 'printk-for-6.9' of git://=
git.kernel.org/pub/scm/linux/kernel/git/printk/linux)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (c04f7dfe6ec2 ipv6: Fix address dump when IPv6 is disabled=
 on an interface)
Merging bpf/master (122fdbd2a030 bpf: verifier: reject addr_space_cast insn=
 without arena)
Merging ipsec/master (f411e2500592 Merge tag 'linux-can-fixes-for-6.9-20240=
319' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can)
Merging netfilter/main (f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging ipvs/main (7eaf837a4eb5 netfilter: nf_tables: Fix a memory leak in =
nf_tables_updchain)
Merging wireless/for-next (10b890ee21a5 MAINTAINERS: wifi: add git tree for=
 Realtek WiFi drivers)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (eb5c7465c324 RDMA/srpt: fix function pointer cas=
t warnings)
Merging sound-current/for-linus (188ab4bfd29d ASoC: SOF: ipc4-topology: sup=
port NHLT device type)
Merging sound-asoc-fixes/for-linus (4cd1939cf2e1 Merge remote-tracking bran=
ch 'asoc/for-6.8' into asoc-linus)
Merging regmap-fixes/for-linus (2f0dbb24f78a regmap: kunit: Ensure that cha=
nged bytes are actually different)
Merging regulator-fixes/for-linus (a1f9fa6fcbb3 Merge remote-tracking branc=
h 'regulator/for-6.8' into regulator-linus)
Merging spi-fixes/for-linus (a20ad45008a7 spi: spi-mt65xx: Fix NULL pointer=
 access in interrupt handler)
Merging pci-current/for-linus (705c1da8fa48 Merge tag 'pci-v6.9-changes' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci)
Merging driver-core.current/driver-core-linus (bfa8f18691ed Merge tag 'scsi=
-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging tty.current/tty-linus (bfa8f18691ed Merge tag 'scsi-misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging usb.current/usb-linus (bfa8f18691ed Merge tag 'scsi-misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging usb-serial-fixes/usb-linus (d206a76d7d27 Linux 6.8-rc6)
Merging phy/fixes (47b412c1ea77 phy: qcom-qmp-combo: fix type-c switch regi=
stration)
Merging staging.current/staging-linus (bfa8f18691ed Merge tag 'scsi-misc' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging iio-fixes/fixes-togreg (11dadb631007 iio: accel: adxl367: fix I2C F=
IFO data register)
Merging counter-current/counter-current (c83ccdc9586b counter: fix privdata=
 alignment)
Merging char-misc.current/char-misc-linus (bfa8f18691ed Merge tag 'scsi-mis=
c' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (e8f897f4afef Linux 6.8)
Merging input-current/for-linus (57ed9567e63b Merge branch 'next' into for-=
linus)
Merging crypto-current/master (5a7e89d3315d crypto: iaa - Fix nr_cpus < nr_=
iaa case)
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
Merging kvm-fixes/master (bf3a69c6861f Merge tag 'for-linus-6.9-ofs1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (d206a76d7d27 Linux 6.8-rc6)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (d206a76d7d27 Linux 6.8-rc6)
Merging btrfs-fixes/next-fixes (100b83b218ec Merge branch 'misc-6.9' into n=
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
Merging drm-fixes/drm-fixes (e8f897f4afef Linux 6.8)
Merging drm-intel-fixes/for-linux-next-fixes (e8f897f4afef Linux 6.8)
Merging mmc-fixes/fixes (4af59a8df5ea mmc: core: Fix switch on gp3 partitio=
n)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (1f1dc442c57e mshyperv: Introduce hv_numa=
_node_to_pxm_info())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (a11dd49dcb93 riscv: Sparse-Memory/vmemmap out-o=
f-bounds fix)
Merging riscv-dt-fixes/riscv-dt-fixes (2672031b20f6 riscv: dts: Move BUILTI=
N_DTB_SOURCE to common Kconfig)
Merging riscv-soc-fixes/riscv-soc-fixes (d206a76d7d27 Linux 6.8-rc6)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (bfa8f18691ed Merge tag 'scsi-misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging gpio-brgl-fixes/gpio/for-current (90d35da658da Linux 6.8-rc7)
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging auxdisplay-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (e8f897f4afef Linux 6.8)
Merging kunit-fixes/kunit-fixes (829388b725f8 kunit: device: Unregister the=
 kunit_bus on shutdown)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (6a9531c3a880 memblock: fix crash when reserve=
d memory is not added to memory)
Merging nfsd-fixes/nfsd-fixes (6978bd6a9138 SUNRPC: Revert 561141dd49438221=
7bace4d1a51d08168420eace)
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (0f66dfe7b91d perf annotate: Add comments i=
n the data structures)
Merging efi-fixes/urgent (2ce507f57ba9 efivarfs: Drop 'duplicates' bool par=
ameter on efivar_init())
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (bb04d1335388 iommufd/selftest: Don't check ma=
p/unmap pairing with HUGE_PAGES)
Merging rust-fixes/rust-fixes (b401b621758e Linux 6.8-rc5)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (2a93c6cbd5a7 pmdomain: qcom: rpmhpd: Fix enab=
led_corner aggregation)
Merging overlayfs-fixes/ovl-fixes (77a28aa47687 ovl: relax WARN_ON in ovl_v=
erify_area())
Merging i2c-host-fixes/i2c/i2c-host-fixes (a5894bc48f64 i2c: i801: Fix a re=
factoring that broke a touchpad on Lenovo P1)
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (2295bd846765 dma-buf: Fix NULL=
 pointer dereference in sanitycheck())
Merging mm-stable/mm-stable (71919308943d Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (78c3925c048c Merge tag 'soc-late-6=
9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging mm/mm-everything (ac1a4aa21814 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (bfa8f18691ed Merge tag 'scsi-misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (1bbeaf83dd7b Merge tag 'perf-tools-for-v6.9-2=
024-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (14cebf689a78 swiotlb: Reinstate page-alignmen=
t for mappings >=3D PAGE_SIZE)
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
Merging qcom/for-next (6d5a4668a830 Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-fixes-for-6.8', 'arm64-fixes-for-6.9', 'arm64-=
for-6.10', 'clk-for-6.9' and 'drivers-for-6.10' into for-next)
Merging renesas/next (01fdf7d6f150 Merge branch 'renesas-dt-bindings-for-v6=
9' into renesas-next)
Merging reset/reset/next (c721f189e89c reset: Instantiate reset GPIO contro=
ller for shared reset-gpios)
Merging rockchip/for-next (24f3ec49401a Merge branch 'v6.9-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (fb1be31d4042 Merge branches 'fixes', 'next/c=
lk', 'next/drivers', 'next/dt', 'next/dt64' and 'next/soc' into for-next)
Merging scmi/for-linux-next (6d3e135e2055 Merge branches 'for-next/ffa/fixe=
s' and 'for-next/scmi/fixes' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/sudeep.holla/linux into for-linux-next)
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
Merging clk/clk-next (3066c521be9d Merge branches 'clk-samsung', 'clk-imx',=
 'clk-rockchip', 'clk-clkdev' and 'clk-rate-exclusive' into clk-next)
Merging clk-imx/for-next (13269dc6c704 clk: imx: imx8mp: Fix SAI_MCLK_SEL d=
efinition)
Merging clk-renesas/renesas-clk (81a7a88a9806 clk: renesas: r8a779h0: Add R=
PC-IF clock)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (18b722527e2c Merge branch 'loongarch-kvm'=
 into loongarch-next)
Merging m68k/for-next (e8a7824856de m68k: defconfig: Update defconfigs for =
v6.8-rc1)
Merging m68knommu/for-next (b401b621758e Linux 6.8-rc5)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (732932220078 mips: cm: Convert __mips_cm_phys_base(=
) to weak function)
Merging openrisc/for-next (7f1e2fc49348 openrisc: Use asm-generic's version=
 of fix_to_virt() & virt_to_fix())
Merging parisc-hd/for-next (e8f897f4afef Linux 6.8)
Merging powerpc/next (5c4233cc0920 powerpc/kdump: Split KEXEC_CORE and CRAS=
H_DUMP dependency)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (a9ad73295cc1 riscv: Fix syscall wrapper for >word-=
size arguments)
Merging riscv-dt/riscv-dt-for-next (28ecaaa5af19 riscv: dts: starfive: jh71=
10: Add camera subsystem nodes)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (64c3431808bd s390/entry: compare gmap asce to determ=
ine guest/host fault)
Merging sh/for-next (1e21acb7fbfb sh: hd64461: Make setup_hd64461() static)
Merging sparc/for-next (84b76d05828a lib/fonts: Allow Sparc console 8x16 fo=
nt for sparc64 early boot text console)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (7ab7acb68adf xtensa: fix MAKE_PC_FROM_RA se=
cond argument)
Merging bcachefs/for-next (f07bcae93535 bcachefs: fix misplaced newline in =
__bch2_inode_unpacked_to_text())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (18f539b4e9d2 Merge branch 'for-next-next-v6.9-20240=
318' into for-next-20240318)
Merging ceph/master (825b82f6b82a ceph: set correct cap mask for getattr re=
quest for read)
Merging cifs/for-next (bda0b06c0263 smb3: add trace event for mknod)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (a1bafc3109d7 erofs: support compressed inodes over fscac=
he)
Merging exfat/dev (dc38fdc51ba6 exfat: remove duplicate update parent dir)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (9d7d0eb685f1 Pull fanotify fix to allow freezing of =
tasks waiting for event response.)
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
Merging ksmbd/ksmbd-for-next (23956900041d Merge tag 'v6.9-rc-smb3-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (719fcafe07c1 nfs: fix panic when nfs4_ff_layout_pre=
pare_ds() fails)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (9b350d3e349f NFSD: Clean up nfsd4_encode_replay())
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (b8a77b9a5f9c mtd: ubi: fix NVMEM over UBI volumes on 32=
-bit systems)
Merging v9fs/9p-next (2a0505cdd8c8 9p: remove SLAB_MEM_SPREAD flag usage)
Merging v9fs-ericvh/ericvh/for-next (acade3ac5c19 fs/9p: remove redundant p=
ointer v9ses)
Merging xfs/for-next (0c6ca06aad84 xfs: quota radix tree allocations need t=
o be NOFS on insert)
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
Merging vfs-brauner/vfs.all (70f0231d2dc2 Merge branch 'vfs.misc' into vfs.=
all)
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (a2b4cab9da77 Merge branch 'for-6.10' into for-next)
Merging pci/next (705c1da8fa48 Merge tag 'pci-v6.9-changes' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/pci/pci)
Merging pstore/for-next/pstore (c8d25d696f52 pstore/zone: Don't clear memor=
y twice)
Merging hid/for-next (139b4c37e9cb MAINTAINERS: update Benjamin's email add=
ress)
Merging i2c/i2c/for-next (e593a4a2d3ad dt-bindings: i2c: qcom,i2c-cci: Fix =
OV7251 'data-lanes' entries)
Merging i2c-host/i2c/i2c-host (6d7c1c58c11c i2c: riic: Add support for R9A0=
9G057 SoC)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (8debe3c1295e hwmon: (dell-smm) Add XPS 93=
15 to fan control whitelist)
Merging jc_docs/docs-next (b8cfda5c9065 docs: verify/bisect: remove a level=
 of indenting)
Merging v4l-dvb/master (b14257abe705 media: rcar-isp: Disallow unbind of de=
vices)
Merging v4l-dvb-next/master (b14257abe705 media: rcar-isp: Disallow unbind =
of devices)
Merging pm/linux-next (fbd88dd05780 Merge tag 'pm-6.9-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging cpufreq-arm/cpufreq/arm/linux-next (a8e949d41c72 cpufreq: scmi: Ena=
ble boost support)
Merging cpupower/cpupower (a114d9f1f2cf Fix cpupower-frequency-info.1 man p=
age typo)
Merging devfreq/devfreq-next (68a8582befd4 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (ccabbb6768fc pmdomain: renesas: rcar-gen4-sysc: Redu=
ce atomic delays)
Merging opp/opp/linux-next (13c8cf339e1a dt-bindings: opp: drop maxItems fr=
om inner items)
Merging thermal/thermal/linux-next (1828c1c17bb2 thermal/drivers/rcar_gen3:=
 Add support for R-Car V4M)
Merging dlm/next (c53309b912fd dlm: add comments about forced waiters reset)
Merging rdma/for-next (96d9cbe2f2ff RDMA/cm: add timeout to cm_destroy_id w=
ait)
Merging net-next/main (537c2e91d354 Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/netdev/net)
Merging bpf-next/for-next (9187210eee7d Merge tag 'net-next-6.9' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (aceb147b20a2 xfrm: Do not allocate stats in the =
driver)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (60482ab92867 Bluetooth: ISO: Don't reject BT_ISO_=
QOS if parameters are unset)
Merging wireless-next/for-next (c2b25092864a Merge branch 'qmc-hdlc')
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (09888e973cc9 Merge tag 'nand/for-6.9' into mtd/next)
Merging nand/nand/next (4120aa0e3961 mtd: rawnand: Ensure continuous reads =
are well disabled)
Merging spi-nor/spi-nor/next (6a9eda34418f mtd: spi-nor: core: set mtd->era=
seregions for non-uniform erase map)
Merging crypto/master (6a8dbd71a706 Revert "crypto: remove CONFIG_CRYPTO_ST=
ATS")
Merging drm/drm-next (4cece7649650 Linux 6.9-rc1)
Merging drm-exynos/for-linux-next (119b225f01e4 Merge tag 'amd-drm-next-6.9=
-2024-03-08-1' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-misc/for-linux-next (5d4e8ae6e57b nouveau/gsp: don't check devi=
nit disable on GSP.)
Merging amdgpu/drm-next (0355b24bdec3 drm/amd: Flush GFXOFF requests in pre=
pare stage)
Merging drm-intel/for-linux-next (1bfc03b13752 drm/i915: Remove special han=
dling for !RCS_MASK())
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (4be445f5b6b6 drm/msm/dpu: capture snapshot on the=
 first commit_done timeout)
Merging drm-msm-lumag/msm-next-lumag (4be445f5b6b6 drm/msm/dpu: capture sna=
pshot on the first commit_done timeout)
Merging drm-xe/drm-xe-next (008aa86a09ba drm/xe: Remove redundant functions=
 to get xe)
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (e8f897f4afef Linux 6.8)
Merging regmap/for-next (62861ddcb27e Merge remote-tracking branch 'regmap/=
for-6.9' into regmap-next)
Merging sound/for-next (188ab4bfd29d ASoC: SOF: ipc4-topology: support NHLT=
 device type)
Merging ieee1394/for-next (4cece7649650 Linux 6.9-rc1)
Merging sound-asoc/for-next (4cd1939cf2e1 Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-linus)
Merging modules/modules-next (d1909c022173 module: Don't ignore errors from=
 set_memory_XX())
Merging input/next (81c32343d04f Input: xpad - add support for Snakebyte GA=
MEPADs)
Merging block/for-next (4138f0228833 Merge tag 'vfio-v6.9-rc1' of https://g=
ithub.com/awilliam/linux-vfio)
Merging device-mapper/for-next (b4d78cfeb304 dm-integrity: align the outgoi=
ng bio in integrity_recheck)
Merging libata/for-next (c1bc6ed01c16 Merge remote-tracking branch 'libata/=
for-6.9' into HEAD)
Merging pcmcia/pcmcia-next (ccae53aa8aa2 pcmcia: cs: make pcmcia_socket_cla=
ss constant)
Merging mmc/next (faf3b8014c35 mmc: core: make mmc_host_class constant)
Merging mfd/for-mfd-next (78334c343bef mfd: cs42l43: Fix wrong GPIO_FN_SEL =
and SPI_CLK_CONFIG1 defaults)
Merging backlight/for-backlight-next (b49c1caca529 backlight: pandora_bl: D=
rop unneeded ENOMEM error message)
Merging battery/for-next (4cece7649650 Linux 6.9-rc1)
Merging regulator/for-next (a1f9fa6fcbb3 Merge remote-tracking branch 'regu=
lator/for-6.8' into regulator-linus)
Merging security/next (8f49397828ee Automated merge of 'dev' into 'next')
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (85445b964290 integrity: eliminate unneces=
sary "Problem loading X.509 certificate" msg)
Merging selinux/next (a1fc79343abb selinux: fix style issues in security/se=
linux/ss/symtab.c)
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (2900d362b5b5 keys: Fix overwrite of key expiration on i=
nstantiation)
Merging watchdog/master (6fe5aabf7fc6 watchdog: intel-mid_wdt: Get platform=
 data via dev_get_platdata())
Merging iommu/next (f379a7e9c3b5 Merge branches 'arm/mediatek', 'arm/renesa=
s', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (7e98fe49f889 dt-bindings: soc: imx: fsl,imx-an=
atop: add imx6q regulators)
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (a20ad45008a7 spi: spi-mt65xx: Fix NULL pointer access=
 in interrupt handler)
Merging tip/master (02ad32afaf75 Merge branch into tip/master: 'x86/shstk')
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (fc8235a79d73 Merge ras/edac-misc into for-next)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (3add00be5fe5 Merge branches 'rcu-doc.2024.02.14a', 'r=
cu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'r=
cu-misc.2024.02.14a' into rcu.2024.02.26a)
Merging kvm/next (c20722c412f1 Documentation: kvm/sev: clarify usage of KVM=
_MEMORY_ENCRYPT_OP)
Merging kvm-arm/next (4a09ddb8333a Merge branch kvm-arm64/kerneldoc into kv=
marm/next)
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (d8c0831348e7 KVM: riscv: selftests: Add Z=
acas extension to get-reg-list test)
Merging kvm-x86/next (964d0c614c7f Merge branch 'hyperv')
Merging xen-tip/linux-next (d277f9d82802 xen/events: increment refcnt only =
if event channel is refcounted)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (b111131e3ec7 Merge branch 'for-6.9' into for-n=
ext)
Merging drivers-x86/for-next (16f8091b4917 platform/x86/intel/pmc: Improve =
PKGC residency counters debug)
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (8a0a62941a04 firmware: =
coreboot: Replace tag with id table in driver struct)
Merging hsi/for-next (4cece7649650 Linux 6.9-rc1)
Merging leds-lj/for-leds-next (45066c4bbe8c leds: ncp5623: Add MS suffix to=
 time defines)
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (bfa8f18691ed Merge tag 'scsi-misc' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging usb/usb-next (bfa8f18691ed Merge tag 'scsi-misc' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging thunderbolt/next (b8a730836c6b thunderbolt: Constify the struct dev=
ice_type usage)
Merging usb-serial/usb-next (b1a8da9ff139 USB: serial: cp210x: add pid/vid =
for TDK NC0110013M and MM0110113M)
Merging tty/tty-next (bfa8f18691ed Merge tag 'scsi-misc' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging char-misc/char-misc-next (bfa8f18691ed Merge tag 'scsi-misc' of git=
://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (a4f3057d19ff coresight-tpda: Change qcom,dsb-elemen=
t-size to qcom,dsb-elem-bits)
Merging fastrpc/for-next (6613476e225e Linux 6.8-rc1)
Merging fpga/for-next (b1a91ca25f15 fpga: remove redundant checks for bridg=
e ops)
Merging icc/icc-next (7af14fe58e5e Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (a696ab17dafe Merge branch 'togreg-cleanup' into HEAD)
Merging phy-next/next (00ca8a15dafa phy: constify of_phandle_args in xlate)
Merging soundwire/next (e17aae16acf5 soundwire: Use snd_soc_substream_to_rt=
d() to obtain rtd)
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (7447d911af69 vfio/fsl-mc: Block calling interrupt handle=
r without trigger)
Merging w1/for-next (d97d263132a6 w1: w1-gpio: Convert to platform remove c=
allback returning void)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (bfa8f18691ed Merge tag 'scsi-misc' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging counter-next/counter-next (eca588187f91 counter: ti-eqep: Convert t=
o platform remove callback returning void)
Merging siox/siox/for-next (db418d5f1ca5 siox: bus-gpio: Simplify using dev=
m_siox_* functions)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (716141d366f4 dmaengine: of: constify of_phandle_arg=
s in of_dma_find_controller())
Merging cgroup/for-next (13eb1d6e1cfc Merge branch 'for-6.8-fixes' into for=
-next)
Merging scsi/for-next (af180c0880f9 scsi: scsi_debug: Maintain write statis=
tics per group number)
Merging scsi-mkp/for-next (52d8210ea45d Merge patch series "Update lpfc to =
revision 14.4.0.1")
Merging vhost/linux-next (894452180d73 vduse: enable Virtio-net device type)
Merging rpmsg/for-next (1f61cb44e5be Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (8636f19c2d1f gpio: sysfs: repair export re=
turning -EPERM on 1st attempt)
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (34675dc3a7c6 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (a6f06b909fee pinctrl: renesas: All=
ow the compiler to optimize away sh_pfc_pm)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (58d03770ac5f pwm: img: fix pwm clock lookup)
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (5d94da7ff00e kselftest: Add basic test for probing =
the rust sample modules)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (806cb2270237 kunit: Annotate _MSG assertion varia=
nts with gnu printf specifiers)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (f7cee094fb3b MAINTAINER: Include linux-arm-msm for Qu=
alcomm RTC patches)
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
Merging hyperv/hyperv-next (f2580a907e5c x86/hyperv: Use Hyper-V entropy to=
 seed guest random number generator)
Merging auxdisplay/for-next (5d9e12972259 auxdisplay: img-ascii-lcd: Conver=
t to platform remove callback returning void)
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (2ec11b5d6d90 bus: mhi: host: pci_generic: constify mo=
dem_telit_fn980_hw_v1_config)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (ed1ff2fba7af Merge branch 'for-6.9/cxl-einj' into for-6.9=
/cxl)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (bada36a9fa96 x86/efistub: Add missing boot_params for mix=
ed mode compat entry)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (78e2606d5f55 Merge branch 'slab/for-6.9/slab-fl=
ag-cleanups' into slab/for-next)
Merging random/master (6fba9af4a847 x86/coco: Require seeding RNG with RDRA=
ND on CoCo systems)
$ git reset --hard HEAD^
Merging next-20240322 version of random
Merging landlock/next (a17c60e533f5 samples/landlock: Don't error out if a =
file path cannot be opened)
Merging rust/rust-next (768409cff6cc rust: upgrade to Rust 1.76.0)
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
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/pTQ+4mATSi+uQyzkS4j.keE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYA19IACgkQAVBC80lX
0Gz1TQf7Bh89lNLbDgHdgi1IHM9n5Tzy4a3GYGLXM9omJ9Td76mDXj85I6ATxwzU
7ZhjIgudgnC09thr05H0FiYqK2s+yJJkd3pPu6ccjwcumF33Mcz7fHGoOevJkfuF
caGXfVZcbizBuXyDL7RVcudFipIzPclvrjhaQBtP4dpEN86ZD+SaliHKl0eCB8eT
fVGuN6pFQHEt2kQp/LrUM0XB0dBOumdoJM+BEbWhFW4Il0KEwutTguFX1POapuoK
rRaIZCvpbhCKXw2IxGDy0fxqUE//aK1hT6goxvHnGKgSH2hpT6LnRutxMasDC18l
4gDgWbO7570JNv0qtiPfw0U5oZog5A==
=vNWA
-----END PGP SIGNATURE-----

--Sig_/pTQ+4mATSi+uQyzkS4j.keE--

