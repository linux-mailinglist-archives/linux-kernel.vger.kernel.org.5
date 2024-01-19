Return-Path: <linux-kernel+bounces-30696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851B832327
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0DA280F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C66FAF;
	Fri, 19 Jan 2024 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ctK5JjCM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6917610B;
	Fri, 19 Jan 2024 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629083; cv=none; b=O15h5cI5ffyHulQxgo2vkbBZgdnRLkpR7uMhJJX5F4Scs/bp11mVN6NQMQVgz4lZJNVnaCCOlMffJFzHk4OOHmZT2syWlMwdbKwOgRM2hi8ore/idqLL6S6yy+15SjkEfIPJaeQ21aqe8Z+WZBCVGL2OV4D5AdaonevHVXvZ4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629083; c=relaxed/simple;
	bh=PwuVV3PmSAlXz7/HNmWPcaGDafk53MjssscL9l/Zdpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GBkTji9pcgnSnE4yqb5UpaYZ3GtLSWOqIyvirQRG/XSHYRPbzbxgFNZkP5TAEiNIf1ydNKg4KxP6UaGEVstA0kb7NF3qctD/xv3/xeMwFPCH2bSyA4BA6im75OhSQpBcYnFs4ltJJGaMo/TX6K1lmAV3p3ZXiI/Vidq57gqBOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ctK5JjCM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705629078;
	bh=BHumgmeoSgn0MIn2KWCojOmNLEjyDQjQm+JiEC+W8rg=;
	h=Date:From:To:Cc:Subject:From;
	b=ctK5JjCMkmxyochpuF9EMnw91GhWruLvwZ7AyKMpBijRxZqpXyvY2qWtTCVyyhD55
	 jdQ5h5PMaRygYUjQX3TiU34vBXii6iS3+V96FrIgi15fTudVrepdQEEAz5UyzM8nwB
	 w/FEfejBv/b0CPWlUnEcjaS7adPDCZBVpW4FthstXwd33FwO1MxvhetkhbWZkzh+I8
	 O6ThpmQ8qwFu2Ne/udHq/7DJoA77xKaLp2BdNUdOT6KNPlCa6IlvMB/4fp9HZg9KAf
	 rtZW6z+ZcJOCjxBauwv1Br84r2Zzgzbte/RQPZVylH6lrtv+C4YowC6S30jTU/4nqN
	 IZKNdx8Y0Xjbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TGMzB0DPhz4wnv;
	Fri, 19 Jan 2024 12:51:17 +1100 (AEDT)
Date: Fri, 19 Jan 2024 12:51:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 19
Message-ID: <20240119125117.5192ce2b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mpnq=qXqq+FMHXfPTZrQuV6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mpnq=qXqq+FMHXfPTZrQuV6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

News: the merge window has opened, so please do not add any material
intended for v6.9 to your linux-next included branches until asfter
v6.8-rc1 has been released.

Changes since 20240118:

Non-merge commits (relative to Linus' tree): 1763
 2007 files changed, 57711 insertions(+), 48863 deletions(-)

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

I am currently merging 371 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (b0d326da462e Merge tag 'sched-urgent-2024-01-18' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (da864b7c9eb3 selftests/mm: switch=
 to bash from sh)
Merging kbuild-current/fixes (753547de0dae linux/export: Ensure natural ali=
gnment of kcrctab array)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (3c0696076aad arm64: mm: Always make sw-=
dirty PTEs hw-dirty in pte_modify)
Merging arm-soc-fixes/arm/fixes (643fe70e7bcd ARM: sun9i: smp: fix return c=
ode check of of_property_match_string)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (6b9c045b0602 m68k: defconfig: Update defcon=
figs for v6.7-rc1)
Merging powerpc-fixes/fixes (d2441d3e8c0c MAINTAINERS: powerpc: Add Aneesh =
& Naveen)
Merging s390-fixes/fixes (3d940bb18183 s390: update defconfigs)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (925781a471d8 Merge tag 'nf-24-01-18' of git://git.kernel.=
org/pub/scm/linux/kernel/git/netfilter/nf)
Merging bpf/master (35ac085a94ef Merge branch 'tighten-up-arg-ctx-type-enfo=
rcement')
Merging ipsec/master (1982a2a02c91 xfrm: Clear low order bits of ->flowi4_t=
os in decode_session4().)
Merging netfilter/main (d6938c1c76c6 ipvs: avoid stat macros calls from pre=
emptible context)
Merging ipvs/main (b29be0ca8e81 netfilter: nft_immediate: drop chain refere=
nce counter on error)
Merging wireless/for-next (bcbc84af1183 wifi: mac80211: fix race condition =
on enabling fast-xmit)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (a39b6ac3781d Linux 6.7-rc5)
Merging sound-current/for-linus (fb3c007fde80 ALSA: hda/realtek: Enable hea=
dset mic on Lenovo M70 Gen5)
Merging sound-asoc-fixes/for-linus (6db342158dbd Merge remote-tracking bran=
ch 'asoc/for-6.7' into asoc-linus)
Merging regmap-fixes/for-linus (fea88064445a regmap: fix bogus error on reg=
cache_sync success)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (fc70d643a2f6 spi: atmel: Fix clock issue when =
using devices with different polarities)
Merging pci-current/for-linus (0ee2030af4e3 MAINTAINERS: Orphan Cadence PCI=
e IP)
Merging driver-core.current/driver-core-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty.current/tty-linus (a39b6ac3781d Linux 6.7-rc5)
Merging usb.current/usb-linus (610a9b8f49fb Linux 6.7-rc8)
Merging usb-serial-fixes/usb-linus (610a9b8f49fb Linux 6.7-rc8)
Merging phy/fixes (2a9c713825b3 phy: sunplus: return negative error code in=
 sp_usb_phy_probe)
Merging staging.current/staging-linus (98b1cc82c4af Linux 6.7-rc2)
Merging iio-fixes/fixes-togreg (45ad6eb5f557 iio: imu: bno055: serdev requi=
res REGMAP)
Merging counter-current/counter-current (a39b6ac3781d Linux 6.7-rc5)
Merging char-misc.current/char-misc-linus (610a9b8f49fb Linux 6.7-rc8)
Merging soundwire-fixes/fixes (393cae5f32d6 soundwire: intel_ace2x: fix AC =
timing setting for ACE2.x)
Merging thunderbolt-fixes/fixes (0dd3ee311255 Linux 6.7)
Merging input-current/for-linus (58f65f9db7e0 Input: atkbd - use ab83 as id=
 when skipping the getid command)
Merging crypto-current/master (9aedd10fe384 crypto: ahash - Set using_shash=
 for cloned ahash wrapper over shash)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (4ee632c82d2d dmaengine: fsl-edma: fix DMA ch=
annel leak in eDMAv4)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (7c1b1906229d mtd: spinand: gigadevice: Fix the=
 get ecc status issue)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (60a031b64984 media: i2c: thp7312: select CONFI=
G_FW_LOADER)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (a39b6ac3781d Linux 6.7-rc5)
Merging at91-fixes/at91-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (0dd3ee311255 Linux 6.7)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (2539b15d504c hwmon: (npcm750-pwm-fan) Fix crash =
observed when instantiating nuvoton,npcm750-pwm-fan)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (ceb6a6f023fd Linux 6.7-rc6)
Merging btrfs-fixes/next-fixes (4f9d4cf13b08 Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (485053bb81c8 fix ufs_get_locked_folio() breakage)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (b20712e85330 Revert "platform/x86: p2sb: A=
llow p2sb_bar() calls during PCI device probe")
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (136c6531ba12 dt-bindings: display: adi,a=
dv75xx: Document #sound-dai-cells)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (04c116e2bdfc scsi: ufs: core: Let the sq_lock pro=
tect sq_tail_slot access)
Merging drm-fixes/drm-fixes (0dd3ee311255 Linux 6.7)
Merging drm-intel-fixes/for-linux-next-fixes (0dd3ee311255 Linux 6.7)
Merging mmc-fixes/fixes (8abf77c88929 mmc: sdhci-sprd: Fix eMMC init failur=
e after hw reset)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (a39b6ac3781d Linux 6.7-rc5)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (b8b2711336f0 riscv: Fix set_direct_map_default_=
noflush() to reset _PAGE_EXEC)
Merging riscv-dt-fixes/riscv-dt-fixes (e1b91b84ea27 riscv: dts: sophgo: sep=
arate sg2042 mtime and mtimecmp to fit aclint format)
Merging riscv-soc-fixes/riscv-soc-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging gpio-brgl-fixes/gpio/for-current (efb8235bfdbe gpiolib: revert the =
attempt to protect the GPIO device list with an rwsem)
Merging gpio-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging erofs-fixes/fixes (2b872b0f466d erofs: Don't use certain unnecessar=
y folio_*() functions)
Merging kunit-fixes/kunit-fixes (1bddcf77ce66 kunit: test: Avoid cast warni=
ng when adding kfree() as an action)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (1d9cabe2817e SUNRPC: use request size to ini=
tialize bio_vec in svc_udp_sendto())
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (d988c9f511af MAINTAINERS: Add Namhyung as =
tools/perf/ co-maintainer)
Merging efi-fixes/urgent (0e9ce09fde3a riscv/efistub: Tighten ELF relocatio=
n check)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (f37669119423 power: supply: cw2015: correct ti=
me_to_empty units in sysfs)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (861deac3b092 Linux 6.7-rc7)
Merging rust-fixes/rust-fixes (cfd96726e611 rust: docs: fix logo replacemen=
t)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pmdomain-fixes/fixes (0cb19e50a911 pmdomain: arm: Avoid polling for=
 scmi_perf_domain)
Merging overlayfs-fixes/ovl-fixes (413ba91089c7 ovl: fix dentry reference l=
eak after changes to underlying layers)
Merging drm-misc-fixes/for-linux-next-fixes (a20f1b02bafc drm/bridge: parad=
e-ps8640: Make sure we drop the AUX mutex in the error case)
Merging mm-stable/mm-stable (1b1934dbbdcf Merge tag 'docs-6.8-2' of git://g=
it.lwn.net/linux)
Merging mm-nonmm-stable/mm-nonmm-stable (1b1934dbbdcf Merge tag 'docs-6.8-2=
' of git://git.lwn.net/linux)
Merging mm/mm-everything (0a368f746bf8 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (6185d32170b6 kbuild: deb-pkg: use debian/<package>=
 for tmpdir)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (d988c9f511af MAINTAINERS: Add Namhyung as too=
ls/perf/ co-maintainer)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (d93cca2f3109 asm-generic: Fix 32 bit __generic_=
cmpxchg_local)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (8790fade1a19 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (1b20d0486a60 arm64: Fix silcon-errata.rst form=
atting)
Merging arm-perf/for-next/perf (bb339db4d363 arm: perf: Fix ARCH=3Darm buil=
d with GCC)
Merging arm-soc/for-next (6905b2bcfacd Merge branch 'soc/dt' into for-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/mediatek/mt8183.d=
tsi
Merging amlogic/for-next (0dd3ee311255 Linux 6.7)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e60f7a99d378 ARM: dts: aspeed: minerva: add sgpio =
line name)
Merging at91/at91-next (58f72e7817f1 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (365fcc03b632 memory: ti-emif-pm: Convert t=
o platform remove callback returning void)
Merging imx-mxs/for-next (4db02d61a81e Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (3571685e5445 Merge branch 'fixes' into for-next)
Merging qcom/for-next (4f6a031a1c8d Merge branches 'arm32-for-6.8', 'arm64-=
defconfig-for-6.8', 'arm64-for-6.8', 'clk-for-6.8' and 'drivers-for-6.8' in=
to for-next)
Applying: fix up for "of: Stop circularly including of_device.h and of_plat=
form.h"
Merging renesas/next (a4ce2434e9bb Merge branches 'renesas-drivers-for-v6.8=
' and 'renesas-dts-for-v6.8' into renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (3a40bdf5fbe2 Merge branch 'v6.8-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (1b97a284a293 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (69ed67014c40 Merge branches 'for-next/scmi/fix=
es' and 'for-next/ffa/fixes' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (769e4b077b2e ARM: multi_v7_defconfig: enable STM3=
2 DCMIPP media support)
Merging sunxi/sunxi/for-next (d4d29dd858bb Merge branch 'sunxi/dt-for-6.8' =
into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (5e6333ef8ea5 Merge branch for-6.8/arm/dt into for-n=
ext)
Merging ti/ti-next (bfb1d67c6f85 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (a346958e1180 ARM: zynq: slcr: fix function prototy=
pe kernel-doc warnings)
Merging clk/clk-next (4f964cfef39d Merge branch 'clk-rs9' into clk-next)
Merging clk-imx/for-next (f52f00069888 clk: imx: pll14xx: change naming of =
fvco to fout)
Merging clk-renesas/renesas-clk (515f05da372a clk: renesas: r9a08g045: Add =
clock and reset support for ETH0 and ETH1)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (efe1f329f78a Merge branch 'loongarch-kvm'=
 into loongarch-next)
Applying: LoongArch: KVM: Fix build due to API changes
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (ceb6a6f023fd Linux 6.7-rc6)
Merging microblaze/next (ffb0399437ef microblaze: defconfig: Enable the Mar=
vell phy driver)
Merging mips/mips-next (3c1e5abcda64 MIPS: Alchemy: Fix an out-of-bound acc=
ess in db1550_dev_setup())
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (47bd91340b0f parisc/unalignement: Add check to =
test EFAULT ret value)
Merging powerpc/next (44a1aad2fe6c Merge branch 'topic/ppc-kvm' into next)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (080c4324fa5e riscv: optimize ELF relocation functi=
on in riscv)
Merging riscv-dt/riscv-dt-for-next (56b10953da7e riscv: dts: starfive: Enab=
le SDIO wifi on JH7100 boards)
Merging riscv-soc/riscv-soc-for-next (a3ee4347490b Merge branch 'riscv-cach=
e-for-next' into riscv-soc-for-next)
Merging s390/for-next (8eb3db95a8c8 Merge branch 'features' into for-next)
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (a03cd7602a09 xtensa: don't produce FDPIC ou=
tput with fdpic toolchain)
Merging bcachefs/for-next (1d1edd147cbd bcachefs: opts->compression can now=
 also be applied in the background)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (c919330dd578 f2fs: fix double free of f2fs_sb_inf=
o)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (932ab07c383e Merge branch 'for-next-next-v6.8-20240=
108' into for-next-20240108)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
Merging ceph/master (5e9658a2b6b4 rbd: don't move requests to the running l=
ist on errors)
Merging cifs/for-next (bd6abaf3d1b8 cifs: update iface_last_update on each =
query-and-update)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (aa12a790d31b erofs: make erofs_{err,info}() support NULL=
 sb parameter)
Merging exfat/dev (0991abeddefa exfat: fix zero the unwritten part for dio =
read)
Merging exportfs/exportfs-next (4213483e1c20 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (46ee834035ac Pull quota cleanup from Chao Yu.)
Merging ext4/dev (68da4c44b994 ext4: fix inconsistent between segment fstri=
m and full fstrim)
Merging f2fs/dev (70d201a40823 Merge tag 'f2fs-for-6.8-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (55d695cad2f6 gfs2: Fix LOOKUP_RCU support in gfs2_dr=
evalidate)
Merging jfs/jfs-next (a280c9ceeca7 jfs: Add missing set_freezable() for fre=
ezable kthread)
Merging ksmbd/ksmbd-for-next (77bebd186442 ksmbd: only v2 leases handle the=
 directory)
Merging nfs/linux-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (17419aefcbfd nfsd: rename nfsd_last_thread() to nfs=
d_destroy_serv())
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
Merging v9fs-ericvh/ericvh/for-next (5254c0cbc92d Merge tag 'block-6.7-2023=
-12-22' of git://git.kernel.dk/linux)
Merging xfs/for-next (d61b40bf15ce xfs: fix backwards logic in xfs_bmap_all=
oc_account)
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
Merging vfs-brauner/vfs.all (cd51dcb4290a Merge branch 'vfs.netfs' into vfs=
all)
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (7119ca35ee4a Merge branch 'pci/misc')
Merging pstore/for-next/pstore (24a0b5e196cf pstore: inode: Use cleanup.h f=
or struct pstore_private)
Merging hid/for-next (eafe1e3ad354 Merge branch 'for-6.8/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (c5eb372fe3e6 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
CONFLICT (modify/delete): drivers/video/fbdev/intelfb/intelfb_i2c.c deleted=
 in HEAD and modified in i2c/i2c/for-next.  Version i2c/i2c/for-next of dri=
vers/video/fbdev/intelfb/intelfb_i2c.c left in tree.
$ git rm -f drivers/video/fbdev/intelfb/intelfb_i2c.c
Merging i3c/i3c/next (4fa0888f6f3e i3c: document hotjoin sysfs entry)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (2539b15d504c hwmon: (npcm750-pwm-fan) Fix=
 crash observed when instantiating nuvoton,npcm750-pwm-fan)
Merging jc_docs/docs-next (ead8467f96d6 docs, kprobes: Add loongarch as sup=
ported architecture)
Merging v4l-dvb/master (60a031b64984 media: i2c: thp7312: select CONFIG_FW_=
LOADER)
Merging v4l-dvb-next/master (60a031b64984 media: i2c: thp7312: select CONFI=
G_FW_LOADER)
Merging pm/linux-next (d8e6ba025f5e Merge tag 'thermal-6.8-rc1-2' of git://=
git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging cpufreq-arm/cpufreq/arm/linux-next (0990319a0400 cpufreq: armada-8k=
: Fix parameter type warning)
Merging cpupower/cpupower (997bbf2accf6 tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
Merging pmdomain/next (d6948c13b663 PM: domains: Move genpd and its governo=
r to the pmdomain subsystem)
Merging opp/opp/linux-next (dcfec12b6798 OPP: Rename 'rate_clk_single')
Merging thermal/thermal/linux-next (5314b1543787 thermal/drivers/exynos: Us=
e set_trips ops)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (d24b923f1d69 RDMA/bnxt_re: Fix error code in bnxt_re=
_create_cq())
Merging net-next/main (3e7aeb78ab01 Merge tag 'net-next-6.8' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf-next/for-next (3fbf61207c66 Revert "mlx5 updates 2023-12-20")
Merging ipsec-next/master (3e7aeb78ab01 Merge tag 'net-next-6.8' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (a7fe0881d9b7 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (42a7889a1931 Merge branch 'selftests-tcp-ao')
Merging bluetooth/master (6061d66bd0e5 Bluetooth: Remove usage of the depre=
cated ida_simple_xx() API)
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
Merging crypto/master (b8910630c967 crypto: iaa - Account for cpu-less numa=
 nodes)
Merging drm/drm-next (205e18c13545 nouveau/gsp: handle engines in runl with=
out nonstall interrupts.)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (18c376eca10d drm/exynos: gsc: minor fix =
for loop iteration in gsc_runtime_resume)
Merging drm-misc/for-linux-next (1f1626ac0428 drm/ttm: fix ttm pool initial=
ization for no-dma-device drivers)
Merging amdgpu/drm-next (0cd2bc06de72 drm/amd/pm: enable amdgpu smu send me=
ssage log)
Merging drm-intel/for-linux-next (84b5ece64477 drm/i915: Drop -Wstringop-ov=
erflow)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d4ca26ac4be0 drm/msm/dp: call dp_display_get_next=
_bridge() during probe)
Merging drm-msm-lumag/msm-next-lumag (d4ca26ac4be0 drm/msm/dp: call dp_disp=
lay_get_next_bridge() during probe)
Merging etnaviv/etnaviv/next (f1a925152c85 drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (9a9895fd7f79 fbdev: vt8500lcdfb: Remove unnecessary=
 print function dev_err())
Merging regmap/for-next (632cdb1dab49 Merge remote-tracking branch 'regmap/=
for-6.8' into regmap-next)
Merging sound/for-next (fb3c007fde80 ALSA: hda/realtek: Enable headset mic =
on Lenovo M70 Gen5)
Merging ieee1394/for-next (986c20bb3e67 firewire: core: fill model field in=
 modalias of unit device for legacy layout of configuration ROM)
Merging sound-asoc/for-next (6db342158dbd Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-linus)
Merging modules/modules-next (4515d08a742c kernel/module: improve documenta=
tion for try_module_get())
Merging input/next (52c4e5985a73 Input: driver for Adafruit Seesaw Gamepad)
Merging block/for-next (f98861364291 Merge branch 'for-6.8/block' into for-=
next)
Merging device-mapper/for-next (5d6f447b07d5 MAINTAINERS: remove stale info=
 for DEVICE-MAPPER)
Merging libata/for-next (fa7280e5dd81 MAINTAINERS: Add Niklas Cassel as lib=
ata maintainer)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (5d4021334748 mmc: xenon: Add ac5 support via bounce buffe=
r)
Merging mfd/for-mfd-next (284d16c456e5 mfd: ti_am335x_tscadc: Fix TI SoC de=
pendencies)
Merging backlight/for-backlight-next (7d84a63a39b7 backlight: hx8357: Conve=
rt to agnostic GPIO API)
Merging battery/for-next (05599b5f56b7 Merge power-supply fixes for 6.7 cyc=
le)
Merging regulator/for-next (94cc3087aac4 dt-bindings: regulator: Convert ti=
,tps65132 to YAML)
Merging security/next (f1bb47a31dff lsm: new security_file_ioctl_compat() h=
ook)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (c00f94b3a5be overlay: disable EVM)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (bbf5a1d0e5d0 selinux: Fix error priority for bind wit=
h AF_UNSPEC on PF_INET6 socket)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (2b6fad7a900d tpm: cr50: fix kernel-doc warning and spel=
ling)
Merging watchdog/master (9546b21ea672 watchdog: mlx_wdt: fix all kernel-doc=
 warnings)
Merging iommu/next (75f74f85a42e Merge branches 'apple/dart', 'arm/rockchip=
', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging audit/next (24fade412acf Automated merge of 'dev' into 'next')
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (5d81c811f371 Merge remote-tracking branch 'spi/for-6.=
8' into spi-next)
Merging tip/master (dc053699f17c Merge branch into tip/master: 'x86/tdx')
Merging clockevents/timers/drivers/next (c0c4579d79d0 clocksource/drivers/e=
p93xx: Fix error handling during probe)
Merging edac/edac-for-next (e6e10e8939e0 Merge branch 'edac-misc' into edac=
-for-next)
Merging ftrace/for-next (4af12c95cbe8 Merge probes/for-next)
CONFLICT (content): Merge conflict in fs/tracefs/inode.c
Merging rcu/rcu/next (7dfb03dd24d4 Merge branches 'doc.2023.12.13a', 'tortu=
re.2023.11.23a', 'fixes.2023.12.13a', 'rcu-tasks.2023.12.12b' and 'srcu.202=
3.12.13a' into rcu-merge.2023.12.13a)
Merging kvm/next (1c6d984f523f x86/kvm: Do not try to disable kvmclock if i=
t was not enabled)
Merging kvm-arm/next (040113fa32f2 KVM: arm64: Add missing memory barriers =
when switching to pKVM's hyp pgd)
Merging kvms390/next (10f7b1dcdfe0 KVM: s390: cpu model: Use proper define =
for facility mask size)
Merging kvm-ppc/topic/ppc-kvm (180c6b072bf3 KVM: PPC: Book3S HV nestedv2: D=
o not cancel pending decrementer exception)
Merging kvm-riscv/riscv_kvm_next (aad86da229bc RISC-V: KVM: selftests: Add =
get-reg-list test for STA registers)
Merging kvm-x86/next (1c6d984f523f x86/kvm: Do not try to disable kvmclock =
if it was not enabled)
Merging xen-tip/linux-next (2d2db7d40254 xen/gntdev: Fix the abuse of under=
lying struct page in DMA-buf import)
Merging percpu/for-next (1e653a292c26 Merge branch 'for-6.8' into for-next)
Merging workqueues/for-next (1a65a6d17cbc workqueue: Add rcu lock check at =
the end of work item execution)
Merging drivers-x86/for-next (236f7d8034ff platform/x86/amd/pmc: Modify SMU=
 message port for latest AMD platform)
Merging chrome-platform/for-next (57eb6dcd32cf platform/chrome/wilco_ec: Re=
move usage of the deprecated ida_simple_xx() API)
Merging chrome-platform-firmware/for-firmware-next (09aeaabebdaf firmware: =
coreboot: Convert to platform remove callback returning void)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (4289e434c46c leds: trigger: netdev: Add core=
 support for hw not supporting fallback to LED sw control)
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (e3977e0609a0 Revert "kernfs: convert =
kernfs_idr_lock to an irq safe raw spinlock")
Merging usb/usb-next (933bb7b878dd usb: typec: tipd: fix use of device-spec=
ific init function)
Merging thunderbolt/next (04b99eac389a thunderbolt: Reduce retry timeout to=
 speed up boot for some devices)
Merging usb-serial/usb-next (a39b6ac3781d Linux 6.7-rc5)
Merging tty/tty-next (0c84bea0cabc serial: sc16is7xx: refactor EFR lock)
Merging char-misc/char-misc-next (5850edccec30 android: removed duplicate l=
inux/errno)
Merging accel/habanalabs-next (a9f07790a4b2 accel/habanalabs: fix informati=
on leak in sec_attest_info())
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging fpga/for-next (c849ecb2ae84 fpga: zynq-fpga: Convert to platform re=
move callback returning void)
Merging icc/icc-next (869b601db3b7 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (b1a1eaf61836 Merge tag 'iio-for-6.8b' of https://git.ke=
rnel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next)
Merging phy-next/next (2029e71482fc phy: ti: j721e-wiz: Add SGMII support i=
n WIZ driver for J784S4)
Merging soundwire/next (becfce5233a7 soundwire: amd: drop bus freq calculat=
ion and set 'max_clk_freq')
Merging extcon/extcon-next (7803680964c0 extcon: qcom-spmi-misc: don't use =
kernel-doc marker for comment)
Merging gnss/gnss-next (0cbbbe09d49b gnss: ubx: add support for the reset g=
pio)
Merging vfio/next (78f70c02bdbc vfio/virtio: fix virtio-pci dependency)
Merging w1/for-next (93c4bb3666a3 w1: ds2433: add support for ds28ec20 eepr=
om)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (0a46c21c21c1 Staging: rtl8192e: Rename variab=
le OpMode)
Merging counter-next/counter-next (49ca40f8d6ce counter: linux/counter.h: f=
ix Excess kernel-doc description warning)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (3d0b2176e042 dmaengine: xilinx: xdma: statify xdma_=
prep_interleaved_dma)
Merging cgroup/for-next (b7aaea747923 Merge branch 'for-6.8' into for-next)
Merging scsi/for-next (b829681baf2b Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (7d1ae55ffed0 scsi: MAINTAINERS: Update ibmvscsi_=
tgt maintainer)
Merging vhost/linux-next (f16d65124380 vdpa/mlx5: Add mkey leak detection)
Merging rpmsg/for-next (ff9af5732fe7 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (1979a2807547 gpiolib: replace the GPIO dev=
ice mutex with a read-write semaphore)
Merging gpio-intel/for-next (92fc925f8386 gpio: tangier: simplify locking u=
sing cleanup helpers)
Merging pinctrl/for-next (0ef4b05e2dfb Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (ebe7f3393784 pinctrl: intel: Add Intel Mete=
or Point pin controller and GPIO support)
Merging pinctrl-renesas/renesas-pinctrl (9e5889c68d99 pinctrl: renesas: rzg=
2l: Add input enable to the Ethernet pins)
Merging pinctrl-samsung/for-next (6cf96df77338 pinctrl: samsung: add exynos=
autov920 pinctrl)
Merging pwm/pwm/for-next (9320fc509b87 pwm: jz4740: Don't use dev_err_probe=
() in .request())
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (ee9793be08b1 tracing/selftests: Add ownership modif=
ication tests for eventfs)
Merging kunit/test (b85ea95d0864 Linux 6.7-rc1)
Merging kunit-next/kunit (539e582a375d kunit: Fix some comments which were =
mistakenly kerneldoc)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (14688f1a91e1 rtc: nuvoton: Compatible with NCT3015Y-R=
 and NCT3018Y-R)
Merging nvdimm/libnvdimm-for-next (a085a5eb6594 acpi/nfit: Use sysfs_emit()=
 for all attributes)
Merging at24/at24/for-next (c692086d74a0 dt-bindings: at24: add ROHM BR24G0=
4)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (98b1cc82c4af Linux 6.7-rc2)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging nvmem/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (c52391fafcef auxdisplay: img-ascii-lcd: Use =
device_get_match_data())
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (01bd694ac2f6 bus: mhi: host: Drop chan lock before qu=
euing buffers)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (73bf93edeeea cxl/core: use sysfs_emit() for attr's _show(=
))
CONFLICT (content): Merge conflict in drivers/acpi/apei/ghes.c
CONFLICT (content): Merge conflict in include/linux/acpi.h
CONFLICT (content): Merge conflict in lib/fw_table.c
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (4afa688d7141 efi: memmap: fix kernel-doc warnings)
Merging unicode/for-next (7f29d6780929 ovl: Reject mounting case-insensitiv=
e filesystems)
Merging slab/slab/for-next (61d7e367f8bc Merge branch 'slab/for-6.8/slub-ho=
ok-cleanups' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (da1218753806 landlock: Document IOCTL support)
Merging rust/rust-next (711cbfc71765 docs: rust: Clarify that 'rustup overr=
ide' applies to build directory)
Merging sysctl/sysctl-next (561429807d50 sysctl: remove struct ctl_path)
Merging execve/for-next/execve (38132920f430 exec: remove useless comment)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging bitmap/bitmap-for-next (071ad962baf5 bitmap: Step down as a reviewe=
r)
CONFLICT (content): Merge conflict in drivers/tty/serial/sc16is7xx.c
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (a75b3809dce2 qnx4: Use get_directory_fname() in=
 qnx4_match())
Merging kspp-gustavo/for-next/kspp (5ea9350aab7e init: Kconfig: Disable -Ws=
tringop-overflow for GCC-11)
Merging nolibc/nolibc (d543d9ddf593 selftests/nolibc: disable coredump via =
setrlimit)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (47f2bd2ff382 iommufd/selftest: Check the bus type=
 during probe)
Merging devicetree/for-next (8ee03a40e9f9 Merge branch 'dt/header-fixes-for=
-next' into for-next)
Merging header_cleanup/header_cleanup (1e2f2d31997a Kill sched.h dependency=
 on rcupdate.h)

--Sig_/mpnq=qXqq+FMHXfPTZrQuV6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWp1ZUACgkQAVBC80lX
0Gy0wgf/enaj8KSI2L508WKGtE9ne6yjCUyqYttJ20clLv1pHeHSyU0qWlEzswjp
q21q3vyNegXdq2pb/LBiiO6GxOBQdll2/YVhOoTEmFpdTuND2iJT1wgNzCk0KVKn
TAFWQcg5urWYYGBYSmjYp3aNAlyY9Jzj6L7xeQk+Mjx4UJ65+WNsGGc4cOYlasmX
BrUiM2FgpL58jnu4drvTmwE6RSfL05CUS9aDWZ4gW1X0lvkSPb0ZRRW7ZA650NHx
o/0U+T47fA/Y1D9YLDJXw5Np3kYu8/r2+PQS629JKerRu99kFYkQio7XmRbeyzKV
KKH+sXmvAjo6fTLu15Bk4rE0QOOK6w==
=NGRz
-----END PGP SIGNATURE-----

--Sig_/mpnq=qXqq+FMHXfPTZrQuV6--

