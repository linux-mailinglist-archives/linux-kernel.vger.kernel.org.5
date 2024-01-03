Return-Path: <linux-kernel+bounces-15188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87F5822818
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B00E284E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2AA1798F;
	Wed,  3 Jan 2024 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oICsI/fn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B1171CC;
	Wed,  3 Jan 2024 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704260419;
	bh=EqJDEMti7B8y0E0l9ZiokNlukW9sI//CRgpa/bc+k7w=;
	h=Date:From:To:Cc:Subject:From;
	b=oICsI/fnMxMn+jqnHNIY0hBhRjXQnDaQfFFxpiDbAQkGxnczARJPt7pKE6OOH9gwr
	 1mkIJ83fyL1kdDdrmBSGlfdt7qxK59/PskOl4baxpPW1/Cap7xkqADRwWhKqfbxOFD
	 Qsj1JA0ZWG8LOxBPo5HPKunFjnLmG1LZcyZQ0O+MnfOSid+y4CJWBkRTMRJMMZfyIa
	 l5mJXYKy8TKSViej42RHm22veIs3TCuF8YCSRSgp4WvLee0GItB1IIYmY5FrCX5ETz
	 gucIL8h3CvkxhX1HIAPFgMRzmUxP5D6AYcYEKYYfl6UaM8ZQ7h76y59+bObT8FxcMI
	 6CaW+/lIeV/oA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4dpq3JXVz4wc8;
	Wed,  3 Jan 2024 16:40:19 +1100 (AEDT)
Date: Wed, 3 Jan 2024 16:40:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 3
Message-ID: <20240103164017.290f0cb3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+rcsZ/8ntCZLhIQ46Us9Ull";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+rcsZ/8ntCZLhIQ46Us9Ull
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240102:

Removed trees:	irqchip-fixes, irqchip	at the owner's request

The arm-soc tree gained a conflict against the arm-perf tree.

A warning in the drm tree build is now a failure (I stopped building
with CONFIG_WERROR=3Dn), so I applied a patch.

The backlight tree still has its build failure so I used the version
from next-20231221.

Non-merge commits (relative to Linus' tree): 11171
 10141 files changed, 532736 insertions(+), 246193 deletions(-)

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
Merging origin/master (610a9b8f49fb Linux 6.7-rc8)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (a26c0ec3981f mm: shrinker: use kv=
zalloc_node() from memcg_expand_one_shrinker_map())
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
Merging m68k-current/for-linus (03191fb3db3d m68k: lib: Include <linux/libg=
cc.h> for __muldi3())
Merging powerpc-fixes/fixes (d2441d3e8c0c MAINTAINERS: powerpc: Add Aneesh =
& Naveen)
Merging s390-fixes/fixes (3d940bb18183 s390: update defconfigs)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (61fa2493ca76 selftests: bonding: do not set port down whe=
n adding to bond)
Merging bpf/master (7c5e046bdcb2 Merge tag 'net-6.7-rc7' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipsec/master (76df934c6d5f MAINTAINERS: Add netdev subsystem profil=
e link)
Merging netfilter/main (7315dc1e122c netfilter: nf_tables: skip set commit =
for deleted/destroyed sets)
Merging ipvs/main (1ae4cd3cbdd0 Merge branch 'bnxt_en-misc-fixes')
Merging wireless/for-next (0a3d898ee9a8 wifi: mac80211: add/remove driver d=
ebugfs entries as appropriate)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (a39b6ac3781d Linux 6.7-rc5)
Merging sound-current/for-linus (18a434f32fa6 ALSA: hda/realtek: fix mute/m=
icmute LEDs for a HP ZBook)
Merging sound-asoc-fixes/for-linus (38744c3fa001 ASoC: mediatek: mt8186: fi=
x AUD_PAD_TOP register and offset)
Merging regmap-fixes/for-linus (fea88064445a regmap: fix bogus error on reg=
cache_sync success)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (fc70d643a2f6 spi: atmel: Fix clock issue when =
using devices with different polarities)
Merging pci-current/for-linus (1ce7d3dbed19 Revert "PCI/ASPM: Remove pcie_a=
spm_pm_state_change()")
Merging driver-core.current/driver-core-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty.current/tty-linus (a39b6ac3781d Linux 6.7-rc5)
Merging usb.current/usb-linus (ab241a0ab5ab Merge tag 'usb-serial-6.7-rc6' =
of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into us=
b-linus)
Merging usb-serial-fixes/usb-linus (610a9b8f49fb Linux 6.7-rc8)
Merging phy/fixes (2a9c713825b3 phy: sunplus: return negative error code in=
 sp_usb_phy_probe)
Merging staging.current/staging-linus (98b1cc82c4af Linux 6.7-rc2)
Merging iio-fixes/fixes-togreg (6d4850f80654 iio: magnetometer: rm3100: add=
 boundary check for the value read from RM3100_REG_TMRC)
Merging counter-current/counter-current (a39b6ac3781d Linux 6.7-rc5)
Merging char-misc.current/char-misc-linus (159f5bdadcdd debugfs: initialize=
 cancellations earlier)
Merging soundwire-fixes/fixes (393cae5f32d6 soundwire: intel_ace2x: fix AC =
timing setting for ACE2.x)
Merging thunderbolt-fixes/fixes (610a9b8f49fb Linux 6.7-rc8)
Merging input-current/for-linus (ea3715941a9b Input: soc_button_array - add=
 mapping for airplane mode button)
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
Merging v4l-dvb-fixes/fixes (32138be394e5 Merge tag 'media-renesas-fixes-20=
231113' of git://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.gi=
t)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (a39b6ac3781d Linux 6.7-rc5)
Merging at91-fixes/at91-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (ef5b28372c56 Merge tag 'kvm-riscv-fixes-6.7-1' of=
 https://github.com/kvm-riscv/linux into kvm-master)
Merging kvms390-fixes/master (fe752331d4b3 KVM: s390: vsie: fix race during=
 shadow creation)
Merging hwmon-fixes/hwmon (a39b6ac3781d Linux 6.7-rc5)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (ef3d5cf9c59c cxl/pmu: Ensure put_device on pmu dev=
ices)
Merging btrfs-fixes/next-fixes (cdec1b57f10a Merge branch 'misc-6.7' into n=
ext-fixes)
Merging vfs-fixes/fixes (485053bb81c8 fix ufs_get_locked_folio() breakage)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (70681aa0746a platform/x86/intel/pmc: Move =
GBE LTR ignore to suspend callback)
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (136c6531ba12 dt-bindings: display: adi,a=
dv75xx: Document #sound-dai-cells)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (04c116e2bdfc scsi: ufs: core: Let the sq_lock pro=
tect sq_tail_slot access)
Merging drm-fixes/drm-fixes (d4b6e7f582e2 Merge tag 'drm-intel-fixes-2023-1=
2-21' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (ee11d2d37f5c drm/i915/perf: U=
pdate handling of MMIO triggered reports)
Merging mmc-fixes/fixes (1036f69e2513 mmc: core: Cancel delayed work before=
 releasing host)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (a39b6ac3781d Linux 6.7-rc5)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3b5c14361d61 riscv: Fix set_direct_map_default_=
noflush() to reset _PAGE_EXEC)
Merging riscv-dt-fixes/riscv-dt-fixes (79997eda0d31 riscv: dts: microchip: =
move timebase-frequency to mpfs.dtsi)
Merging riscv-soc-fixes/riscv-soc-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (a39b6ac3781d Linux 6.7-rc5)
Merging gpio-brgl-fixes/gpio/for-current (610a9b8f49fb Linux 6.7-rc8)
Merging gpio-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging erofs-fixes/fixes (62b241efff99 MAINTAINERS: erofs: add EROFS webpa=
ge)
Merging kunit-fixes/kunit-fixes (1bddcf77ce66 kunit: test: Avoid cast warni=
ng when adding kfree() as an action)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (bd018b98ba84 SUNRPC: Revert 5f7fc5d69f6e92ec=
0b38774c387f5cf7812c5806)
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (b16937474874 perf list: Fix JSON segfault =
by setting the used skip_duplicate_pmus callback)
Merging efi-fixes/urgent (01638431c465 efi/x86: Fix the missing KASLR_FLAG =
bit in boot_params->hdr.loadflags)
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
Merging drm-misc-fixes/for-linux-next-fixes (11f9eb899ecc drm/mgag200: Fix =
gamma lut not initialized for G200ER, G200EV, G200SE)
Merging mm-stable/mm-stable (501a06fe8e4c zswap: memcontrol: implement zswa=
p writeback disabling)
Merging mm-nonmm-stable/mm-nonmm-stable (29166371ef67 kdump: remove redunda=
nt DEFAULT_CRASH_KERNEL_LOW_SIZE)
Merging mm/mm-everything (e4a0928955d6 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (385ab28c42fa kbuild: deb-pkg: use build ID instead=
 of debug link for dbg package)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (58824fa0087e perf annotate: Add --insn-stat o=
ption for debugging)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (b07bc2347672 dma-mapping: clear dev->dma_mem =
to NULL after freeing it)
Merging asm-generic/master (d6e81532b10d Hexagon: Make pfn accessors static=
s inlines)
CONFLICT (content): Merge conflict in arch/mips/include/asm/traps.h
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (f1ff4ced177d Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (0686ea6e698d Merge branch 'for-next/fixes' int=
o for-next/core)
Merging arm-perf/for-next/perf (bb339db4d363 arm: perf: Fix ARCH=3Darm buil=
d with GCC)
Merging arm-soc/for-next (f54398b56b11 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/kernel/perf_event_v6.c
Merging amlogic/for-next (cbd0342d28dc Merge branch 'v6.8/arm64-dt' into fo=
r-next)
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
Merging scmi/for-linux-next (2d5fc3b92ca5 Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
Merging stm32/stm32-next (769e4b077b2e ARM: multi_v7_defconfig: enable STM3=
2 DCMIPP media support)
Merging sunxi/sunxi/for-next (d4d29dd858bb Merge branch 'sunxi/dt-for-6.8' =
into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (5e6333ef8ea5 Merge branch for-6.8/arm/dt into for-n=
ext)
Merging ti/ti-next (bfb1d67c6f85 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (21d01d5afbc8 Merge remote-tracking branch 'zynqmp/=
soc' into for-next)
Merging clk/clk-next (9a6f78dbad07 Merge branch 'clk-imx' into clk-next)
Merging clk-imx/for-next (f52f00069888 clk: imx: pll14xx: change naming of =
fvco to fout)
Merging clk-renesas/renesas-clk (515f05da372a clk: renesas: r9a08g045: Add =
clock and reset support for ETH0 and ETH1)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (118e10cd893d LoongArch: KVM: Add LASX (25=
6bit SIMD) support)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (ceb6a6f023fd Linux 6.7-rc6)
Merging microblaze/next (ffb0399437ef microblaze: defconfig: Enable the Mar=
vell phy driver)
Merging mips/mips-next (8e1803900ef1 MIPS: Remove unused shadow GPR support=
 from vector irq setup)
CONFLICT (content): Merge conflict in arch/mips/kernel/traps.c
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (33cc938e65a9 Linux 6.7-rc4)
Merging powerpc/next (44a1aad2fe6c Merge branch 'topic/ppc-kvm' into next)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (f352a28cc2fb Merge patch series "riscv: report mor=
e ISA extensions through hwprobe")
Merging riscv-dt/riscv-dt-for-next (56b10953da7e riscv: dts: starfive: Enab=
le SDIO wifi on JH7100 boards)
Merging riscv-soc/riscv-soc-for-next (a3ee4347490b Merge branch 'riscv-cach=
e-for-next' into riscv-soc-for-next)
Merging s390/for-next (efbee6221e03 Merge branch 'features' into for-next)
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (791beae7335c xtensa: Use PCI_HEADER_TYPE_MF=
D instead of literal)
Merging bcachefs/for-next (50603706df67 bcachefs: Combine .trans_trigger, .=
atomic_trigger)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (2a0e85719892 fs: move fscrypt keyring destruction=
 to after ->put_super)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (c8b36fa20ab3 Merge branch 'for-next-next-v6.7-20240=
102' into for-next-20240102)
Merging ceph/master (d30d7c57a64d ceph: select FS_ENCRYPTION_ALGS if FS_ENC=
RYPTION)
Merging cifs/for-next (f3f8dabd54ec smb: client: handle special files and s=
ymlinks in SMB3 POSIX)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (640d17df5cf2 erofs: avoid debugging output for (de)compr=
essed data)
Merging exfat/dev (6dfb1f0dfdb0 exfat: do not zero the extended part)
Merging ext3/for_next (46ee834035ac Pull quota cleanup from Chao Yu.)
Merging ext4/dev (6c02757c9360 jbd2: fix soft lockup in journal_finish_inod=
e_data_buffers())
Merging f2fs/dev (c3c2d45b9050 f2fs: show more discard status by sysfs)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (e345b87b0b04 gfs2: Fix freeze consistency check in l=
og_write_header)
Merging jfs/jfs-next (a280c9ceeca7 jfs: Add missing set_freezable() for fre=
ezable kthread)
Merging ksmbd/ksmbd-for-next (c0c1bc12e6a2 ksmbd: vfs: fix all kernel-doc w=
arnings)
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (9bf4b41b79a3 nfsd: rename nfsd_last_thread() to nfs=
d_destroy_serv())
Merging ntfs3/master (4cdfb6e7bc9c fs/ntfs3: Disable ATTR_LIST_ENTRY size c=
heck)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (ff49bf186757 net: 9p: avoid freeing uninit memory in =
p9pdu_vreadf)
Merging v9fs-ericvh/ericvh/for-next (5254c0cbc92d Merge tag 'block-6.7-2023=
-12-22' of git://git.kernel.dk/linux)
Merging xfs/for-next (bcdfae6ee520 xfs: use the op name in trace_xlog_inten=
t_recovery_failed)
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
Merging vfs-brauner/vfs.all (aee755dd0219 Merge branch 'vfs.netfs' into vfs=
.all)
CONFLICT (content): Merge conflict in fs/afs/write.c
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/subpage.c
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/buffer.c
Applying: linux-next: manual merge of the vfs-brauner tree with the btrfs t=
ree
Applying: fixup for "netfs: Provide a writepages implementation"
Merging vfs/for-next (b345389b921f Merge branch 'work.misc' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting.rst
CONFLICT (content): Merge conflict in fs/overlayfs/copy_up.c
CONFLICT (content): Merge conflict in fs/tracefs/inode.c
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (2afb41864fbd Merge branch 'pci/dt-bindings')
Merging pstore/for-next/pstore (24a0b5e196cf pstore: inode: Use cleanup.h f=
or struct pstore_private)
Merging hid/for-next (a8f7bb9e1277 Merge branch 'for-6.8/elan' into for-nex=
t)
Merging i2c/i2c/for-next (172b695a1e5e Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (b4da37db3e2c i3c: master: Fix build error)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (887599b9201a hwmon: (lm75) Add AMS AS6200=
 temperature sensor)
Merging jc_docs/docs-next (7418ec5b151f docs: translations: add translation=
s links when they exist)
Merging v4l-dvb/master (02d4e62ae245 media: i2c: mt9m114: use fsleep() in p=
lace of udelay())
Merging v4l-dvb-next/master (02d4e62ae245 media: i2c: mt9m114: use fsleep()=
 in place of udelay())
Merging pm/linux-next (c0e52ad85f5f Merge branch 'thermal' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c4a5118a3ae1 cpufreq: scmi: pro=
cess the result of devm_of_clk_add_hw_provider())
Merging cpupower/cpupower (997bbf2accf6 tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
Merging pmdomain/next (d6948c13b663 PM: domains: Move genpd and its governo=
r to the pmdomain subsystem)
Merging opp/opp/linux-next (ab7a781fd6f8 OPP: Fix _set_required_opps when o=
pp is NULL)
Merging thermal/thermal/linux-next (5314b1543787 thermal/drivers/exynos: Us=
e set_trips ops)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (63a43a675cb9 RDMA/erdma: Add hardware statistics sup=
port)
Merging net-next/main (8dc4c4100065 xsk: make struct xsk_cb_desc available =
outside CONFIG_XDP_SOCKETS)
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
Applying: fix up for "net: phy: aquantia: add firmware load support"
Merging bpf-next/for-next (5abde6246522 bpf: Avoid unnecessary use of comma=
 operator in verifier)
Merging ipsec-next/master (aadbd27f9674 net: phy: correctly check soft_rese=
t ret ONLY if defined for PHY)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (42a7889a1931 Merge branch 'selftests-tcp-ao')
Merging ipvs-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_large a=
nd use it in rtnl_getlink)
Merging bluetooth/master (c7ee0bc8db32 Bluetooth: btnxpuart: Resolve TX tim=
eout error in power save stress test)
Merging wireless-next/for-next (968509128207 wifi: iwlwifi: replace ENOTSUP=
P with EOPNOTSUPP)
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
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
Merging drm/drm-next (92242716ee92 Merge tag 'drm-habanalabs-next-2023-12-1=
9' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into dr=
m-next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/display/mediate=
k/mediatek,mdp-rdma.yaml deleted in HEAD and modified in drm/drm-next.  Ver=
sion drm/drm-next of Documentation/devicetree/bindings/display/mediatek/med=
iatek,mdp-rdma.yaml left in tree.
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/dis=
play/mediatek/mediatek,padding.yaml
CONFLICT (content): Merge conflict in drivers/accel/qaic/qaic_data.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dm=
c.c
$ git rm -f Documentation/devicetree/bindings/display/mediatek/mediatek,mdp=
-rdma.yaml
Applying: fix up for "drm/i915: Replace custom intel runtime_pm tracker wit=
h ref_tracker library"
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (f22b8e47aef3 drm/exynos: gsc: minor fix =
for loop iteration in gsc_runtime_resume)
Merging drm-misc/for-linux-next (eee706839333 drm/imagination: pvr_device.h=
: fix all kernel-doc warnings)
Merging amdgpu/drm-next (87825c860eb8 drm/amdgpu: re-create idle bo's PTE d=
uring VM state machine reset)
Merging drm-intel/for-linux-next (e7b2d82d420a drm/i915/bios: remove some u=
nused leftover declarations)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d4ca26ac4be0 drm/msm/dp: call dp_display_get_next=
_bridge() during probe)
Merging drm-msm-lumag/msm-next-lumag (d4ca26ac4be0 drm/msm/dp: call dp_disp=
lay_get_next_bridge() during probe)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (844d06e31272 video/sticore: Remove info field from =
STI struct)
CONFLICT (modify/delete): drivers/video/fbdev/amba-clcd.c deleted in fbdev/=
for-next and modified in HEAD.  Version HEAD of drivers/video/fbdev/amba-cl=
cd.c left in tree.
CONFLICT (modify/delete): drivers/video/fbdev/vermilion/vermilion.c deleted=
 in fbdev/for-next and modified in HEAD.  Version HEAD of drivers/video/fbd=
ev/vermilion/vermilion.c left in tree.
$ git rm -f drivers/video/fbdev/amba-clcd.c drivers/video/fbdev/vermilion/v=
ermilion.c
Merging regmap/for-next (632cdb1dab49 Merge remote-tracking branch 'regmap/=
for-6.8' into regmap-next)
Merging sound/for-next (b5cb53fd3277 ALSA: hda/tas2781: add fixup for Lenov=
o 14ARB7)
Merging ieee1394/for-next (0be7f07d134d firewire: core: change modalias of =
unit device with backward incompatibility)
Merging sound-asoc/for-next (eadc73f77dee Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-next)
Merging modules/modules-next (4515d08a742c kernel/module: improve documenta=
tion for try_module_get())
Merging input/next (992bbc9e9ab9 Input: iqs269a - add support for OTP varia=
nts)
Merging block/for-next (1a174a661fcb Merge branch 'for-6.8/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/btrfs/zoned.h
Merging device-mapper/for-next (5d6f447b07d5 MAINTAINERS: remove stale info=
 for DEVICE-MAPPER)
Merging libata/for-next (fa7280e5dd81 MAINTAINERS: Add Niklas Cassel as lib=
ata maintainer)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (77e01b49e35f mmc: core: Add HS400 tuning in HS400es initi=
alization)
Merging mfd/for-mfd-next (03d790f04fb2 mfd: intel-lpss: Fix the fractional =
clock divider flags)
Merging backlight/for-backlight-next (f7baa9ccef93 backlight: mp3309c: Rena=
me  pwm_apply_state() to pwm_apply_might_sleep())
$ git reset --hard HEAD^
Merging next-20231221 version of backlight
Merging battery/for-next (b150a703b56f power: supply: bq24190_charger: Add =
support for BQ24296)
Merging regulator/for-next (67ba055dd775 regulator: Reuse LINEAR_RANGE() in=
 REGULATOR_LINEAR_RANGE())
Merging security/next (f1bb47a31dff lsm: new security_file_ioctl_compat() h=
ook)
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
CONFLICT (content): Merge conflict in arch/alpha/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in arch/arm/tools/syscall.tbl
CONFLICT (content): Merge conflict in arch/arm64/include/asm/unistd32.h
CONFLICT (content): Merge conflict in arch/m68k/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in arch/microblaze/kernel/syscalls/sysca=
ll.tbl
CONFLICT (content): Merge conflict in arch/mips/kernel/syscalls/syscall_n32=
.tbl
CONFLICT (content): Merge conflict in arch/mips/kernel/syscalls/syscall_n64=
.tbl
CONFLICT (content): Merge conflict in arch/mips/kernel/syscalls/syscall_o32=
.tbl
CONFLICT (content): Merge conflict in arch/parisc/kernel/syscalls/syscall.t=
bl
CONFLICT (content): Merge conflict in arch/powerpc/kernel/syscalls/syscall.=
tbl
CONFLICT (content): Merge conflict in arch/s390/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in arch/sh/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in arch/sparc/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/xtensa/kernel/syscalls/syscall.t=
bl
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in security/selinux/hooks.c
CONFLICT (content): Merge conflict in security/smack/smack_lsm.c
CONFLICT (content): Merge conflict in tools/perf/arch/mips/entry/syscalls/s=
yscall_n64.tbl
CONFLICT (content): Merge conflict in tools/perf/arch/powerpc/entry/syscall=
s/syscall.tbl
CONFLICT (content): Merge conflict in tools/perf/arch/s390/entry/syscalls/s=
yscall.tbl
CONFLICT (content): Merge conflict in tools/perf/arch/x86/entry/syscalls/sy=
scall_64.tbl
Applying: fix up for "LSM: wireup Linux Security Module syscalls"
Merging apparmor/apparmor-next (a7e405a2de69 apparmor: add missing params t=
o aa_may_ptrace kernel-doc comments)
Merging integrity/next-integrity (c00f94b3a5be overlay: disable EVM)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (cc2a7341994a selinux: fix style issues in security/se=
linux/include/initial_sid_to_string.h)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (ebf2d4e8e582 tpm: nuvoton: Use i2c_get_match_data())
Merging watchdog/master (9546b21ea672 watchdog: mlx_wdt: fix all kernel-doc=
 warnings)
Merging iommu/next (174ec3867900 Merge branches 'apple/dart', 'arm/rockchip=
', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging audit/next (24fade412acf Automated merge of 'dev' into 'next')
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (fbce94a444fb mailbox: qcom-apcs-ipc: re-organize =
compatibles with fallbacks)
Merging spi/for-next (79cdd3ab8ceb Merge remote-tracking branch 'spi/for-6.=
8' into spi-next)
Merging tip/master (659c07b7699a Merge x86/sev into tip/master)
Merging clockevents/timers/drivers/next (c0c4579d79d0 clocksource/drivers/e=
p93xx: Fix error handling during probe)
Merging edac/edac-for-next (e6e10e8939e0 Merge branch 'edac-misc' into edac=
-for-next)
Merging ftrace/for-next (b390dcd7620e Merge probes/for-next)
Merging rcu/rcu/next (7dfb03dd24d4 Merge branches 'doc.2023.12.13a', 'tortu=
re.2023.11.23a', 'fixes.2023.12.13a', 'rcu-tasks.2023.12.12b' and 'srcu.202=
3.12.13a' into rcu-merge.2023.12.13a)
Merging kvm/next (8ed26ab8d591 KVM: clean up directives to compile out irqf=
ds)
CONFLICT (content): Merge conflict in include/linux/pagemap.h
CONFLICT (content): Merge conflict in io_uring/io_uring.c
Applying: fs: Convert error_remove_page to error_remove_folio
Applying: fix up for "KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-spe=
cific backing memory"
Applying: LoongArch: KVM: Fix build due to API changes
Merging kvm-arm/next (958b3a359c5d Merge branch kvm-arm64/vgic-6.8 into kvm=
arm-master/next)
Merging kvms390/next (10f7b1dcdfe0 KVM: s390: cpu model: Use proper define =
for facility mask size)
Merging kvm-ppc/topic/ppc-kvm (180c6b072bf3 KVM: PPC: Book3S HV nestedv2: D=
o not cancel pending decrementer exception)
Merging kvm-riscv/riscv_kvm_next (aad86da229bc RISC-V: KVM: selftests: Add =
get-reg-list test for STA registers)
Merging kvm-x86/next (f2a3fb7234e5 Merge branches 'fixes', 'generic', 'hype=
rv', 'lam', 'misc', 'mmu', 'pmu', 'selftests', 'svm' and 'xen')
Merging xen-tip/linux-next (861deac3b092 Linux 6.7-rc7)
Merging percpu/for-next (1e653a292c26 Merge branch 'for-6.8' into for-next)
Merging workqueues/for-next (4a6c5607d450 workqueue: Make sure that wq_unbo=
und_cpumask is never empty)
Merging drivers-x86/for-next (810bad6e055c platform/x86: hp-bioscfg: Remove=
d needless asm-generic)
CONFLICT (content): Merge conflict in drivers/platform/x86/intel/pmc/adl.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel/pmc/cnp.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel/pmc/core.h
CONFLICT (content): Merge conflict in drivers/platform/x86/intel/pmc/mtl.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel/pmc/tgl.c
CONFLICT (content): Merge conflict in drivers/platform/x86/wmi.c
Merging chrome-platform/for-next (57eb6dcd32cf platform/chrome/wilco_ec: Re=
move usage of the deprecated ida_simple_xx() API)
Merging chrome-platform-firmware/for-firmware-next (09aeaabebdaf firmware: =
coreboot: Convert to platform remove callback returning void)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (4289e434c46c leds: trigger: netdev: Add core=
 support for hw not supporting fallback to LED sw control)
Merging ipmi/for-next (9bd9fbd9032a ipmi: Remove usage of the deprecated id=
a_simple_xx() API)
Merging driver-core/driver-core-next (c810729fe647 kernfs: fix reference to=
 renamed function)
Merging usb/usb-next (e7d3b9f28654 usb: yurex: Fix inconsistent locking bug=
 in yurex_read())
Merging thunderbolt/next (04b99eac389a thunderbolt: Reduce retry timeout to=
 speed up boot for some devices)
Merging usb-serial/usb-next (a39b6ac3781d Linux 6.7-rc5)
Merging tty/tty-next (43f012df3c1e tty: serial: 8250: Set RS422 interface b=
y default to fix Moxa RS422/RS485 PCIe boards)
Merging char-misc/char-misc-next (b1a1eaf61836 Merge tag 'iio-for-6.8b' of =
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-ne=
xt)
CONFLICT (content): Merge conflict in drivers/android/binder_alloc.c
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
Merging vfio/next (daca194876a9 vfio/virtio: Declare virtiovf_pci_aer_reset=
_done() static)
Merging w1/for-next (93c4bb3666a3 w1: ds2433: add support for ds28ec20 eepr=
om)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (9ebffbe2ad12 Staging: rtl8192e: Rename functi=
on rtllib_DisableNetMonitorMode())
Merging counter-next/counter-next (49ca40f8d6ce counter: linux/counter.h: f=
ix Excess kernel-doc description warning)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (3d0b2176e042 dmaengine: xilinx: xdma: statify xdma_=
prep_interleaved_dma)
Merging cgroup/for-next (b7aaea747923 Merge branch 'for-6.8' into for-next)
Merging scsi/for-next (2f7eb2d2d9f8 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (45a2c87f28ad scsi: ufs: core: Simplify ufshcd_au=
to_hibern8_update())
Merging vhost/linux-next (7bd0e37a67fb virtio_net: Fix "=E2=80=98%d=E2=80=
=99 directive writing between 1 and 11 bytes into a region of size 10" warn=
ings)
Merging rpmsg/for-next (ff9af5732fe7 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (f34fd6ee1be8 gpio: dwapb: Use generic requ=
est, free and set_config)
Merging gpio-intel/for-next (92fc925f8386 gpio: tangier: simplify locking u=
sing cleanup helpers)
Merging pinctrl/for-next (0ef4b05e2dfb Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (ebe7f3393784 pinctrl: intel: Add Intel Mete=
or Point pin controller and GPIO support)
Merging pinctrl-renesas/renesas-pinctrl (9e5889c68d99 pinctrl: renesas: rzg=
2l: Add input enable to the Ethernet pins)
Merging pinctrl-samsung/for-next (6cf96df77338 pinctrl: samsung: add exynos=
autov920 pinctrl)
Merging pwm/for-next (9a216587a03d pwm: Add pwm_apply_state() compatibility=
 stub)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (ee9793be08b1 tracing/selftests: Add ownership modif=
ication tests for eventfs)
Merging kunit/test (b85ea95d0864 Linux 6.7-rc1)
Merging kunit-next/kunit (342fb9789267 kunit: Reset test->priv after each p=
aram iteration)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (dc0684adf3b6 rtc: Add driver for Nuvoton ma35d1 rtc c=
ontroller)
Merging nvdimm/libnvdimm-for-next (ecb5659aa1ad acpi/nfit: Use sysfs_emit()=
 for all attributes)
Merging at24/at24/for-next (c692086d74a0 dt-bindings: at24: add ROHM BR24G0=
4)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (31c65705a8cf perf/benchmark: fix seccomp_=
unotify benchmark for 32-bit)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging nvmem/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (c52391fafcef auxdisplay: img-ascii-lcd: Use =
device_get_match_data())
Merging kgdb/kgdb/for-next (23816724fdbd kdb: Corrects comment for kdballoc=
env)
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (01bd694ac2f6 bus: mhi: host: Drop chan lock before qu=
euing buffers)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (11c839320287 Merge branch 'for-6.8/cxl-cdat' into for-6.8=
/cxl)
CONFLICT (content): Merge conflict in include/linux/acpi.h
CONFLICT (content): Merge conflict in lib/fw_table.c
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (4afa688d7141 efi: memmap: fix kernel-doc warnings)
Merging unicode/for-next (807f06d1074d ecryptfs: Reject casefold directory =
inodes)
Merging slab/slab/for-next (bc21ce75d6ad Merge branch 'slab/for-6.8/slub-ho=
ok-cleanups' into slab/for-next)
CONFLICT (content): Merge conflict in include/linux/slab.h
CONFLICT (content): Merge conflict in mm/kasan/quarantine.c
CONFLICT (modify/delete): mm/slab.c deleted in slab/slab/for-next and modif=
ied in HEAD.  Version HEAD of mm/slab.c left in tree.
CONFLICT (content): Merge conflict in mm/slab_common.c
$ git rm -f mm/slab.c
Applying: fix up for "mm/slab: move kfree() from slab_common.c to slub.c"
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (d822583c4a34 landlock: Document IOCTL support)
Merging rust/rust-next (711cbfc71765 docs: rust: Clarify that 'rustup overr=
ide' applies to build directory)
Merging sysctl/sysctl-next (561429807d50 sysctl: remove struct ctl_path)
Merging execve/for-next/execve (0a8a952a75f2 ELF, MAINTAINERS: specifically=
 mention ELF)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging bitmap/bitmap-for-next (6ae0831c4b17 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (a75b3809dce2 qnx4: Use get_directory_fname() in=
 qnx4_match())
Merging kspp-gustavo/for-next/kspp (617ab3c357d2 init: Kconfig: Disable -Ws=
tringop-overflow for GCC-11)
Merging nolibc/nolibc (d543d9ddf593 selftests/nolibc: disable coredump via =
setrlimit)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (ca4a310350b8 iommu/vt-d: Add iotlb flush for nest=
ed domain)
Merging devicetree/for-next (2726b01362a5 Merge branch 'dt/header-fixes-for=
-next' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/con=
nector/usb-connector.yaml
Merging header_cleanup/header_cleanup (1e2f2d31997a Kill sched.h dependency=
 on rcupdate.h)
CONFLICT (content): Merge conflict in arch/x86/include/asm/paravirt_types.h
CONFLICT (content): Merge conflict in arch/x86/include/asm/percpu.h

--Sig_/+rcsZ/8ntCZLhIQ46Us9Ull
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWU80EACgkQAVBC80lX
0GzFaQf/X3292YH1+E3rml2cGrgKy5LjL8XTgq/my7MU3heKoHcHoM9kdy6sbPXm
Xyces58ZeaRAo0WAB9CmhTaKdFGLLesUyiDiMB0v33e/TLnSt3mhVMMS41bqO6dI
ZZwaJmhwimaRRi39F7wNVY6b3pu2GqpCH7th0Sv42BrLVxADJRUBjZ7Ymh1JXr1L
0bbwdwT0NiaioF3BzkRUtBMbASccRuu/T7Aj3/O9QRpFyHtebOv2QRfSqatXWMU4
VIz9zWwcCMGa6vHdn6mgcSR6q05uhl9vbFMB22spUVfPADH4eyxyn2xtTne+k4v1
nK3W5aOy8cEc17R7dRnY0dp/PpNSqQ==
=fNbE
-----END PGP SIGNATURE-----

--Sig_/+rcsZ/8ntCZLhIQ46Us9Ull--

