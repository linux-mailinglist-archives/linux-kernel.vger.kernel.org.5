Return-Path: <linux-kernel+bounces-4689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C28180A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760611F24B22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7BB848E;
	Tue, 19 Dec 2023 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kn8td9Y6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692818472;
	Tue, 19 Dec 2023 04:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702960865;
	bh=Z4y2d9fYh3T72y+TCPz203JuUX25ooMIXWWNqcEx0Ng=;
	h=Date:From:To:Cc:Subject:From;
	b=kn8td9Y6mvsyS0q6iqF7Femd3flkEFm4AXKy3mLHdc23gDvv/2izujwD2PZa5Ucb5
	 M83pPHohdNW7UZ2Tjdi6f9+Zsq1zOoHf8nZlY0d4CezkCjuxONtcdJecRxi2uxcoCS
	 Hhz2EYegs5wAFJSmhmKKyUb6QzE1FZd6rqIeUue5e/HVZ9zGY1GojKpLKqDV/wGVpw
	 qU3KywK/ElZ/sIQEzRLFHC2TOxpPGW0Xedv727/lyowhel28PR8J/mI6wCiJoVi5Z5
	 KFbJEPRcy31+lZsiMwTlGPvdxJdHNvVU7QEKP1PLG1qUqWW54EmAzHR/HOXulqbfPZ
	 A9kFcTBY0CRPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvPCP19P7z4wnv;
	Tue, 19 Dec 2023 15:41:05 +1100 (AEDT)
Date: Tue, 19 Dec 2023 15:41:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 19
Message-ID: <20231219154103.0ade50bc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TieEN2MQR496/IGoxaKvyKL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TieEN2MQR496/IGoxaKvyKL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231218:

The pm tree gained a build failure so I used the version from
next-20231218.

The thermal tree gained a build failure so I used the version from
next-20231218.

The header_cleanup tree lost its build failures but gained another for
which I applied a patch.

Non-merge commits (relative to Linus' tree): 8210
 8256 files changed, 388528 insertions(+), 212541 deletions(-)

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
Merging origin/master (2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (9238ca68a856 selftests: secretmem=
: floor the memory size to the multiple of page_size)
Merging kbuild-current/fixes (98b1cc82c4af Linux 6.7-rc2)
Merging arc-current/for-curr (9a733dc4fbee ARC: add hugetlb definitions)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (3c0696076aad arm64: mm: Always make sw-=
dirty PTEs hw-dirty in pte_modify)
Merging arm-soc-fixes/arm/fixes (d73ad797c83b Merge tag 'reset-fixes-for-v6=
.7' of git://git.pengutronix.de/pza/linux into arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (03191fb3db3d m68k: lib: Include <linux/libg=
cc.h> for __muldi3())
Merging powerpc-fixes/fixes (d2441d3e8c0c MAINTAINERS: powerpc: Add Aneesh =
& Naveen)
Merging s390-fixes/fixes (e6b2dab41888 s390/vx: fix save/restore of fpu ker=
nel context)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (979e90173af8 Merge branch 'mptcp-misc-fixes')
Merging bpf/master (117211aa739a bpf: Add missing BPF_LINK_TYPE invocations)
Merging ipsec/master (76df934c6d5f MAINTAINERS: Add netdev subsystem profil=
e link)
Merging netfilter/main (1ae4cd3cbdd0 Merge branch 'bnxt_en-misc-fixes')
Merging ipvs/main (1ae4cd3cbdd0 Merge branch 'bnxt_en-misc-fixes')
Merging wireless/for-next (400f6ebbc175 wifi: iwlwifi: pcie: don't synchron=
ize IRQs from IRQ)
Merging wpan/master (83fcf26b00d7 ieee802154: Give the user the association=
 list)
Merging rdma-fixes/for-rc (a39b6ac3781d Linux 6.7-rc5)
Merging sound-current/for-linus (ae53e2198cb8 ALSA: hda/realtek: Add quirks=
 for ASUS Zenbook 2023 Models)
Merging sound-asoc-fixes/for-linus (f32c80d34249 ASoC: tas2781: check the v=
alidity of prm_no/cfg_no)
Merging regmap-fixes/for-linus (fea88064445a regmap: fix bogus error on reg=
cache_sync success)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (fc70d643a2f6 spi: atmel: Fix clock issue when =
using devices with different polarities)
Merging pci-current/for-linus (5df12742b7e3 Revert "PCI: acpiphp: Reassign =
resources on bridge if necessary")
Merging driver-core.current/driver-core-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty.current/tty-linus (a39b6ac3781d Linux 6.7-rc5)
Merging usb.current/usb-linus (7fbcd195e2b8 usb: fotg210-hcd: delete an inc=
orrect bounds test)
Merging usb-serial-fixes/usb-linus (06f22cd6635b USB: serial: option: add Q=
uectel RM500Q R13 firmware support)
Merging phy/fixes (2a9c713825b3 phy: sunplus: return negative error code in=
 sp_usb_phy_probe)
Merging staging.current/staging-linus (98b1cc82c4af Linux 6.7-rc2)
Merging iio-fixes/fixes-togreg (1e8787459bfd iio: core: fix memleak in iio_=
device_register_sysfs)
Merging counter-current/counter-current (a39b6ac3781d Linux 6.7-rc5)
Merging char-misc.current/char-misc-linus (1e37bf84afac nvmem: brcm_nvram: =
store a copy of NVRAM content)
Merging soundwire-fixes/fixes (393cae5f32d6 soundwire: intel_ace2x: fix AC =
timing setting for ACE2.x)
Merging thunderbolt-fixes/fixes (f0b94c1c5c79 thunderbolt: Fix minimum allo=
cated USB 3.x and PCIe bandwidth)
Merging input-current/for-linus (c3d1610345b7 Input: xpad - add Razer Wolve=
rine V2 support)
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
Merging omap-fixes/fixes (c72b9c33ef96 ARM: OMAP2+: Fix null pointer derefe=
rence and memory leak in omap_soc_device_init)
Merging kvm-fixes/master (4cdf351d3630 KVM: SVM: Update EFER software model=
 on CR0 trap for SEV-ES)
Merging kvms390-fixes/master (27072b8e18a7 KVM: s390/mm: Properly reset no-=
dat)
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
Merging drivers-x86-fixes/fixes (7bcd032370f8 platform/x86: intel_ips: fix =
kernel-doc formatting)
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (136c6531ba12 dt-bindings: display: adi,a=
dv75xx: Document #sound-dai-cells)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (77a672556096 scsi: ufs: core: Store min and max c=
lk freq from OPP table)
Merging drm-fixes/drm-fixes (ceb6a6f023fd Linux 6.7-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (ceb6a6f023fd Linux 6.7-rc6)
Merging mmc-fixes/fixes (1036f69e2513 mmc: core: Cancel delayed work before=
 releasing host)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (a39b6ac3781d Linux 6.7-rc5)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (eb46a0076501 riscv: Check if the code to patch =
lies in the exit section)
Merging riscv-dt-fixes/riscv-dt-fixes (79997eda0d31 riscv: dts: microchip: =
move timebase-frequency to mpfs.dtsi)
Merging riscv-soc-fixes/riscv-soc-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (a39b6ac3781d Linux 6.7-rc5)
Merging gpio-brgl-fixes/gpio/for-current (ceb6a6f023fd Linux 6.7-rc6)
Merging gpio-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging erofs-fixes/fixes (62b241efff99 MAINTAINERS: erofs: add EROFS webpa=
ge)
Merging kunit-fixes/kunit-fixes (1bddcf77ce66 kunit: test: Avoid cast warni=
ng when adding kfree() as an action)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (1227561c2ffb NFSD: Revert 738401a9bd1ac34ccd=
5723d69640a4adbb1a4bc0)
Merging irqchip-fixes/irq/irqchip-fixes (b673fe1a6229 MAINTAINERS: Remove m=
yself from the general IRQ subsystem maintenance)
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (b16937474874 perf list: Fix JSON segfault =
by setting the used skip_duplicate_pmus callback)
Merging efi-fixes/urgent (50d7cdf7a9b1 efi/x86: Avoid physical KASLR on old=
er Dell systems)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (f37669119423 power: supply: cw2015: correct ti=
me_to_empty units in sysfs)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (6f9c4d8c468c iommufd: Do not UAF during iommu=
fd_put_object())
Merging rust-fixes/rust-fixes (cfd96726e611 rust: docs: fix logo replacemen=
t)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pmdomain-fixes/fixes (0cb19e50a911 pmdomain: arm: Avoid polling for=
 scmi_perf_domain)
Merging overlayfs-fixes/ovl-fixes (413ba91089c7 ovl: fix dentry reference l=
eak after changes to underlying layers)
Merging drm-misc-fixes/for-linux-next-fixes (aca58eac52b8 drm/bridge: ti-sn=
65dsi86: Never store more than msg->size bytes in AUX xfer)
Merging mm-stable/mm-stable (d9d9bd979cce maple_tree: change return type of=
 mas_split_final_node as void.)
Merging mm-nonmm-stable/mm-nonmm-stable (fc0fbad122a7 merge mm-hotfixes-sta=
ble into mm-nonmm-stable to pick up depended-upon changes)
Merging mm/mm-everything (b960ce977c11 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (1809d3a7b51a scripts: Introduce a default git.orde=
rFile)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (a61f89bf76ef perf top: Uniform the event name=
 for the hybrid machine)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (b07bc2347672 dma-mapping: clear dev->dma_mem =
to NULL after freeing it)
Merging asm-generic/master (d6e81532b10d Hexagon: Make pfn accessors static=
s inlines)
CONFLICT (content): Merge conflict in arch/mips/include/asm/traps.h
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (f1ff4ced177d Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (fdd44642dc72 Merge branch 'for-next/fixes' int=
o for-next/core)
Merging arm-perf/for-next/perf (bb339db4d363 arm: perf: Fix ARCH=3Darm buil=
d with GCC)
Merging arm-soc/for-next (16bcd9a4a332 Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (7406f70924e6 Merge branch 'v6.8/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e60f7a99d378 ARM: dts: aspeed: minerva: add sgpio =
line name)
Merging at91/at91-next (58f72e7817f1 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (4a23d0f9814c memory: tegra: Protect SID ov=
erride call under CONFIG_IOMMU_API)
Merging imx-mxs/for-next (4db02d61a81e Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (0ea5e8402a47 Merge branches 'omap-for-v6.8/dt', 'oma=
p-for-v6.8/defconfig' and 'omap-for-v6.8/maintainers' into for-next)
Merging qcom/for-next (452e8fdfae6c Merge branches 'arm32-for-6.8', 'arm64-=
defconfig-for-6.8', 'arm64-for-6.8', 'clk-for-6.8', 'drivers-fixes-for-6.7'=
 and 'drivers-for-6.8' into for-next)
Applying: fix up for "of: Stop circularly including of_device.h and of_plat=
form.h"
Merging renesas/next (a4ce2434e9bb Merge branches 'renesas-drivers-for-v6.8=
' and 'renesas-dts-for-v6.8' into renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (242278ed93dd Merge branch 'v6.8-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (1b97a284a293 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (7c2d214ab5b9 Merge tag 'scmi-updates-6.8' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (769e4b077b2e ARM: multi_v7_defconfig: enable STM3=
2 DCMIPP media support)
Merging sunxi/sunxi/for-next (d4d29dd858bb Merge branch 'sunxi/dt-for-6.8' =
into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (8ebef8a28749 Merge branch for-6.8/arm/dt into for-n=
ext)
Merging ti/ti-next (bfb1d67c6f85 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (21d01d5afbc8 Merge remote-tracking branch 'zynqmp/=
soc' into for-next)
Merging clk/clk-next (7aaac8b1f0cd Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (144f1b70ea9e dt-bindings: clock: support i.MX93 A=
NATOP clock module)
Merging clk-renesas/renesas-clk (515f05da372a clk: renesas: r9a08g045: Add =
clock and reset support for ETH0 and ETH1)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (e2f7b3d8b4b3 LoongArch: BPF: Fix uncondit=
ional bswap instructions)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (ceb6a6f023fd Linux 6.7-rc6)
Merging microblaze/next (ffb0399437ef microblaze: defconfig: Enable the Mar=
vell phy driver)
Merging mips/mips-next (01940cd4a6b9 MIPS: SGI-IP27: hubio: fix nasid kerne=
l-doc warning)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (33cc938e65a9 Linux 6.7-rc4)
Merging powerpc/next (8fc63a91e785 Merge branch 'smp-topo' into next)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (f352a28cc2fb Merge patch series "riscv: report mor=
e ISA extensions through hwprobe")
Merging riscv-dt/riscv-dt-for-next (56b10953da7e riscv: dts: starfive: Enab=
le SDIO wifi on JH7100 boards)
CONFLICT (content): Merge conflict in arch/riscv/boot/dts/sophgo/cv1800b.dt=
si
Applying: fixup for "riscv: dts: sophgo: Separate compatible specific for C=
V1800B soc"
Merging riscv-soc/riscv-soc-for-next (a3ee4347490b Merge branch 'riscv-cach=
e-for-next' into riscv-soc-for-next)
Merging s390/for-next (5e191539a5ee Merge branch 'features' into for-next)
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (791beae7335c xtensa: Use PCI_HEADER_TYPE_MF=
D instead of literal)
Merging bcachefs/for-next (f5470472504d bcachefs: kill __bch2_btree_iter_pe=
ek_upto_and_restart())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (0fc24a6549f9 fscrypt: update comment for do_remov=
e_key())
Merging afs/afs-next (f1302568cc65 afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (9bd44dbd2924 Merge branch 'for-next-next-v6.7-20231=
215' into for-next-20231215)
Merging ceph/master (d30d7c57a64d ceph: select FS_ENCRYPTION_ALGS if FS_ENC=
RYPTION)
Merging cifs/for-next (d5a4971d029e cifs: do not let cifs_chan_update_iface=
 deallocate channels)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (0ee3a0d59e00 erofs: enable sub-page compressed block sup=
port)
Merging exfat/dev (6dfb1f0dfdb0 exfat: do not zero the extended part)
Merging ext3/for_next (46ee834035ac Pull quota cleanup from Chao Yu.)
Merging ext4/dev (6c02757c9360 jbd2: fix soft lockup in journal_finish_inod=
e_data_buffers())
Merging f2fs/dev (394e7f4dbb32 f2fs: don't set FI_PREALLOCATED_ALL for part=
ial write)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (dd00aaeb3432 gfs2: Use GL_NOBLOCK flag for non-block=
ing lookups)
Merging jfs/jfs-next (cca974daeb6c jfs: fix shift-out-of-bounds in dbJoin)
Merging ksmbd/ksmbd-for-next (8b8cd4beea4f Merge tag '6.7-rc5-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (9637daa85f69 svcrdma: Increase the per-transport rw=
_ctx count)
Merging ntfs3/master (652483bfbc45 fs/ntfs3: Fix c/mtime typo)
Applying: ntfs3: align struct ATTR_LIST_ENTRY
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (ff49bf186757 net: 9p: avoid freeing uninit memory in =
p9pdu_vreadf)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (98bdbf60cca8 Merge tag 'repair-quota-6.8_2023-12-15' =
of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xf=
s-6.8-mergeB)
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
Merging vfs-brauner/vfs.all (85ddc21d198b Merge branch 'vfs.iov_iter' into =
vfs.all)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/subpage.c
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in include/linux/blk_types.h
Applying: linux-next: manual merge of the vfs-brauner tree with the btrfs t=
ree
Merging vfs/for-next (3f95c5b76257 Merge branch 'work.minix' into for-next)
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (ab9345f3fb21 Merge branch 'pci/controller/vmd')
Merging pstore/for-next/pstore (24a0b5e196cf pstore: inode: Use cleanup.h f=
or struct pstore_private)
Merging hid/for-next (dad2d654c822 Merge branch 'for-6.7/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (382561d16854 i2c: ocores: Move system PM hooks to=
 the NOIRQ phase)
Merging i3c/i3c/next (b4da37db3e2c i3c: master: Fix build error)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (db79be9d9707 hwmon: (pmbus) Add support f=
or MPS Multi-phase mp2856/mp2857 controller)
Merging jc_docs/docs-next (0c3ebff53595 scripts: kernel-doc: Clarify missin=
g struct member description)
Merging v4l-dvb/master (a00b3f296eac media: mediatek: vcodec: Set the suppo=
rted vp9 profile for each platform)
Merging v4l-dvb-next/master (efa28efd9cba media: rkisp1: resizer: Stop manu=
al allocation of v4l2_subdev_state)
Merging pm/linux-next (fbcc41b78701 Merge branches 'pm-cpuidle', 'pm-cpufre=
q' and 'pm-sleep' into linux-next)
$ git reset --hard HEAD^
Merging next-20231218 version of pm
Merging cpufreq-arm/cpufreq/arm/linux-next (c4a5118a3ae1 cpufreq: scmi: pro=
cess the result of devm_of_clk_add_hw_provider())
Merging cpupower/cpupower (997bbf2accf6 tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
Merging pmdomain/next (d6948c13b663 PM: domains: Move genpd and its governo=
r to the pmdomain subsystem)
Merging opp/opp/linux-next (19cc8b1819a4 OPP: Check for invalid OPP in dev_=
pm_opp_find_level_ceil())
Merging thermal/thermal/linux-next (829509c37d9c thermal/thermal_of: Allow =
rebooting after critical temp)
$ git reset --hard HEAD^
Merging next-20231218 version of thermal
Merging dlm/next (0c08699744d2 dlm: implement EXPORT_OP_ASYNC_LOCK)
Merging rdma/for-next (4f973e211b3b IB/ipoib: Fix mcast list locking)
Merging net-next/main (509afc745270 Merge branch 'tools-net-ynl-add-sub-mes=
sage-support-to-ynl')
Merging bpf-next/for-next (8e432e6197ce bpf: Ensure precise is reset to fal=
se in __mark_reg_const_zero())
CONFLICT (content): Merge conflict in include/linux/skbuff.h
CONFLICT (modify/delete): tools/net/ynl/generated/netdev-user.c deleted in =
HEAD and modified in bpf-next/for-next.  Version bpf-next/for-next of tools=
/net/ynl/generated/netdev-user.c left in tree.
$ git rm -f tools/net/ynl/generated/netdev-user.c
Merging ipsec-next/master (aadbd27f9674 net: phy: correctly check soft_rese=
t ret ONLY if defined for PHY)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_la=
rge and use it in rtnl_getlink)
Merging ipvs-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_large a=
nd use it in rtnl_getlink)
Merging bluetooth/master (dea290e2e36b Bluetooth: af_bluetooth: Fix Use-Aft=
er-Free in bt_sock_recvmsg)
Merging wireless-next/for-next (c5a3f56fcdb0 Merge tag 'ath-next-20231215' =
of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath)
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (83fcf26b00d7 ieee802154: Give the user the as=
sociation list)
Merging mtd/mtd/next (a7d84a2e7663 mtd: maps: vmu-flash: Fix the (mtd core)=
 switch to ref counters)
Merging nand/nand/next (2b8aa4c3e6a5 mtd: rawnand: diskonchip: fix a potent=
ial double free in doc_probe)
Merging spi-nor/spi-nor/next (c692ba6de1c5 mtd: spi-nor: micron-st: Add sup=
port for mt25qu01g)
Merging crypto/master (c480a421a4fa crypto: octeontx2 - Fix cptvf driver cl=
eanup)
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
Merging drm/drm-next (a0a28956b46e Merge tag 'amd-drm-next-6.8-2023-12-08' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (897da484d1c7 drm/exynos: fix accidental =
on-stack copy of exynos_drm_plane)
Merging drm-misc/for-linux-next (8a53e29fe05c drm/imagination: Fix error pa=
th in pvr_vm_create_context)
Merging amdgpu/drm-next (669080888691 drm/amd/display: Revert " drm/amd/dis=
play: Use channel_width =3D 2 for vram table 3.0")
Merging drm-intel/for-linux-next (716c3cf21784 drm/i915/display: Remove dea=
d code around intel_atomic_helper->free_list)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d4ca26ac4be0 drm/msm/dp: call dp_display_get_next=
_bridge() during probe)
Applying: fix up for "drm/exec: Pass in initial # of objects"
Merging drm-msm-lumag/msm-next-lumag (d4ca26ac4be0 drm/msm/dp: call dp_disp=
lay_get_next_bridge() during probe)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (13366c25125e fbdev: amba-clcd: Delete the old CLCD =
driver)
CONFLICT (modify/delete): drivers/video/fbdev/amba-clcd.c deleted in fbdev/=
for-next and modified in HEAD.  Version HEAD of drivers/video/fbdev/amba-cl=
cd.c left in tree.
CONFLICT (modify/delete): drivers/video/fbdev/vermilion/vermilion.c deleted=
 in fbdev/for-next and modified in HEAD.  Version HEAD of drivers/video/fbd=
ev/vermilion/vermilion.c left in tree.
$ git rm -f drivers/video/fbdev/amba-clcd.c drivers/video/fbdev/vermilion/v=
ermilion.c
Merging regmap/for-next (a2d43f711790 Merge remote-tracking branch 'regmap/=
for-6.8' into regmap-next)
Merging sound/for-next (c7e37b07cc75 ALSA: au88x0: fixed a typo)
Merging ieee1394/for-next (c12d7aa7ffa4 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (86237bd324c2 Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-next)
Merging modules/modules-next (4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging input/next (c67f8a13be4e Input: da9063 - use dev_err_probe())
Merging block/for-next (9d1282ca9724 Merge branch 'for-6.8/block' into for-=
next)
Merging device-mapper/for-next (5d6f447b07d5 MAINTAINERS: remove stale info=
 for DEVICE-MAPPER)
Merging libata/for-next (804901fdd637 ata: pata_pxa: convert not to use dma=
_request_slave_channel())
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (72cd89517fa0 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (03d790f04fb2 mfd: intel-lpss: Fix the fractional =
clock divider flags)
Merging backlight/for-backlight-next (7d84a63a39b7 backlight: hx8357: Conve=
rt to agnostic GPIO API)
Merging battery/for-next (b55d073e6501 power: supply: bq256xx: fix some pro=
blem in bq256xx_hw_init)
Merging regulator/for-next (ad663ce67804 regulator: qcom_smd: Add LDO5 MP54=
96 regulator)
Merging security/next (ec4e9d630a64 calipso: fix memory leak in netlbl_cali=
pso_add_pass())
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
CONFLICT (content): Merge conflict in include/linux/security.h
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
Merging integrity/next-integrity (b4af096b5df5 KEYS: encrypted: Add check f=
or strsep)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (3c1e09d533db selinux: remove the wrong comment about =
multithreaded process handling)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (ebf2d4e8e582 tpm: nuvoton: Use i2c_get_match_data())
Merging watchdog/master (70ec8691764f dt-bindings: watchdog: qcom,pm8916-wd=
t: add parent spmi node to example)
Merging iommu/next (4e631678d251 Merge branches 'apple/dart', 'arm/rockchip=
', 'arm/smmu', 'virtio', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging audit/next (24fade412acf Automated merge of 'dev' into 'next')
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (fbce94a444fb mailbox: qcom-apcs-ipc: re-organize =
compatibles with fallbacks)
Merging spi/for-next (0ae0d521bb6f Merge remote-tracking branch 'spi/for-6.=
8' into spi-next)
Merging tip/master (032ba4d28e4d Merge branch into tip/master: 'x86/tdx')
Merging clockevents/timers/drivers/next (d25e52a7eb36 clocksource/drivers/c=
adence-ttc: Fix some kernel-doc warnings)
Merging edac/edac-for-next (448709b58867 Merge edac-urgent into for-next)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (e1742fa172d5 Merge probes/for-next)
Merging rcu/rcu/next (f1242ec0ad8f doc: Update checklist.rst discussion of =
callback execution)
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
Merging kvm/next (8ed26ab8d591 KVM: clean up directives to compile out irqf=
ds)
CONFLICT (content): Merge conflict in include/linux/pagemap.h
Applying: fs: Convert error_remove_page to error_remove_folio
Applying: fix up for "KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-spe=
cific backing memory"
Merging kvm-arm/next (53d5486114ae Merge branch kvm-arm64/fgt-rework into k=
vmarm-master/next)
Merging kvms390/next (26fb87ffa9d9 s390/uvdevice: Report additional-data le=
ngth for attestation)
Merging kvm-ppc/topic/ppc-kvm (180c6b072bf3 KVM: PPC: Book3S HV nestedv2: D=
o not cancel pending decrementer exception)
Merging kvm-riscv/riscv_kvm_next (4ad9843e1ea0 RISCV: KVM: update external =
interrupt atomically for IMSIC swfile)
Merging kvm-x86/next (f2a3fb7234e5 Merge branches 'fixes', 'generic', 'hype=
rv', 'lam', 'misc', 'mmu', 'pmu', 'selftests', 'svm' and 'xen')
Merging xen-tip/linux-next (7f3da4b698bc xen/events: fix error code in xen_=
bind_pirq_msi_to_irq())
Merging percpu/for-next (1e653a292c26 Merge branch 'for-6.8' into for-next)
Merging workqueues/for-next (4a6c5607d450 workqueue: Make sure that wq_unbo=
und_cpumask is never empty)
Merging drivers-x86/for-next (ed289b98c2ae Merge tag 'platform-drivers-x86-=
amd-wbrf-v6.8-1' into review-hans)
CONFLICT (content): Merge conflict in drivers/platform/x86/wmi.c
Merging chrome-platform/for-next (57eb6dcd32cf platform/chrome/wilco_ec: Re=
move usage of the deprecated ida_simple_xx() API)
Merging chrome-platform-firmware/for-firmware-next (ecea08916418 firmware: =
coreboot: framebuffer: Avoid invalid zero physical address)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (40cfa414e7f9 leds: sun50i-a100: Avoid divisi=
on-by-zero warning)
Merging ipmi/for-next (c5d03a0d8461 ipmi: Use regspacings passed as a modul=
e parameter)
Merging driver-core/driver-core-next (532888a59505 driver core: Better adve=
rtise dev_err_probe())
Merging usb/usb-next (e9158c7e5533 usb: typec: tcpm: Parse Accessory Mode i=
nformation)
Merging thunderbolt/next (2cd3da4e3745 thunderbolt: Add support for Intel L=
unar Lake)
Merging usb-serial/usb-next (a39b6ac3781d Linux 6.7-rc5)
Merging tty/tty-next (43f012df3c1e tty: serial: 8250: Set RS422 interface b=
y default to fix Moxa RS422/RS485 PCIe boards)
Merging char-misc/char-misc-next (08b3485540d9 greybus: gb-beagleplay: Remo=
ve use of pad bytes)
CONFLICT (content): Merge conflict in drivers/android/binder_alloc.c
Merging accel/habanalabs-next (dfbf6719ccb4 accel/habanalabs/gaudi2: avoid =
overriding existing undefined opcode data)
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging fpga/for-next (5496fb8eedd6 drivers/fpga: use standard array-copy f=
unction)
Merging icc/icc-next (da7667aef4cf Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (2dfef50589ae iio: adc: ad7091r: Align arguments to func=
tion call parenthesis)
Merging phy-next/next (7f6f9e0def00 phy: qcom-qmp-usb: Add Qualcomm SDX75 U=
SB3 PHY support)
Merging soundwire/next (becfce5233a7 soundwire: amd: drop bus freq calculat=
ion and set 'max_clk_freq')
Merging extcon/extcon-next (7803680964c0 extcon: qcom-spmi-misc: don't use =
kernel-doc marker for comment)
Merging gnss/gnss-next (0cbbbe09d49b gnss: ubx: add support for the reset g=
pio)
Merging vfio/next (946cff255dfa Merge branches 'v6.8/vfio/debugfs', 'v6.8/v=
fio/pds' and 'v6.8/vfio/type1-account' into v6.8/vfio/next)
Merging w1/for-next (efc19c44aa44 w1: amd_axi_w1: Explicitly include correc=
t DT includes)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (5e8cdb6f6ebe staging: rtl8192e: rename variab=
le HTInitializeHTInfo)
Merging counter-next/counter-next (8e21e4693d85 MAINTAINERS: add myself as =
counter watch events tool maintainer)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (70f008fb3ea9 dmaengine: dmatest: prevent using swio=
tlb buffer with nobounce parameter)
Merging cgroup/for-next (b7aaea747923 Merge branch 'for-6.8' into for-next)
Merging scsi/for-next (6bdc5fb22b8e Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (ed340d13aa1d Merge patch series "scsi: hisi_sas:=
 Minor fixes and cleanups")
Merging vhost/linux-next (b8e079244992 virtio_blk: fix snprintf truncation =
compiler warning)
Merging rpmsg/for-next (ff9af5732fe7 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (40aa7e290b8e Merge tag 'intel-gpio-v6.8-1'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel int=
o gpio/for-next)
Merging gpio-intel/for-next (92fc925f8386 gpio: tangier: simplify locking u=
sing cleanup helpers)
Merging pinctrl/for-next (6aac7cb9bb62 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (ebe7f3393784 pinctrl: intel: Add Intel Mete=
or Point pin controller and GPIO support)
Merging pinctrl-renesas/renesas-pinctrl (9e5889c68d99 pinctrl: renesas: rzg=
2l: Add input enable to the Ethernet pins)
Merging pinctrl-samsung/for-next (6cf96df77338 pinctrl: samsung: add exynos=
autov920 pinctrl)
Merging pwm/for-next (2cc2cb184833 pwm: Stop referencing pwm->chip)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (130a83879954 selftests: sched: Remove initializatio=
n to 0 for a static variable)
Merging kunit/test (b85ea95d0864 Linux 6.7-rc1)
Merging kunit-next/kunit (342fb9789267 kunit: Reset test->priv after each p=
aram iteration)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (dc0684adf3b6 rtc: Add driver for Nuvoton ma35d1 rtc c=
ontroller)
Merging nvdimm/libnvdimm-for-next (9ea459e477dc libnvdimm: remove kernel-do=
c warnings:)
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
Merging cxl/next (5d09c63f11f0 cxl/hdm: Remove broken error path)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (94f7f6182c72 efivarfs: automatically update super block f=
lag)
Merging unicode/for-next (807f06d1074d ecryptfs: Reject casefold directory =
inodes)
Merging slab/slab/for-next (f7eb801fcdb1 Merge branch 'slab/for-6.8/slub-ho=
ok-cleanups' into slab/for-next)
CONFLICT (content): Merge conflict in mm/kasan/quarantine.c
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (a50156fe3dcb landlock: Document IOCTL support)
Merging rust/rust-next (71479eee9da8 rust: Suppress searching builtin sysro=
ot)
Merging sysctl/sysctl-next (a6fd07f80ab7 coda: Remove the now superfluous s=
entinel elements from ctl_table array)
Merging execve/for-next/execve (0a8a952a75f2 ELF, MAINTAINERS: specifically=
 mention ELF)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging bitmap/bitmap-for-next (5e95ee6fd52b sh: mach-x3proto: optimize ils=
el_enable())
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (a75b3809dce2 qnx4: Use get_directory_fname() in=
 qnx4_match())
Merging kspp-gustavo/for-next/kspp (617ab3c357d2 init: Kconfig: Disable -Ws=
tringop-overflow for GCC-11)
Merging nolibc/nolibc (d543d9ddf593 selftests/nolibc: disable coredump via =
setrlimit)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (b2b67c997bf7 iommufd: Organize the mock domain al=
loc functions closer to Joerg's tree)
Merging devicetree/for-next (2726b01362a5 Merge branch 'dt/header-fixes-for=
-next' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/con=
nector/usb-connector.yaml
Merging header_cleanup/header_cleanup (4490eab3c3b5 fixup! Kill sched.h dep=
endency on rcupdate.h)
CONFLICT (content): Merge conflict in arch/x86/include/asm/paravirt_types.h
CONFLICT (content): Merge conflict in arch/x86/include/asm/percpu.h
Applying: drm: using mul_u32_u32() requires linux/math64.h
Applying: fixup for s390 and "rseq: Split out rseq.h from sched.h"

--Sig_/TieEN2MQR496/IGoxaKvyKL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWBHt8ACgkQAVBC80lX
0Gzq6ggApPkhGAFrH++tYdjqBNuKdB5lPIL8JU0GcBeUcFH03VceYnjc5FUNpRmU
OkJND6mdDm2V/Ww7R9/bc6G4tQuy+MVJaSkfmqioBUi7QhFJaXC81PVQNdKrjebX
XJTKlmsLWZ9OEEGllbjesN2HERPq/buH8BJ+BeN0yENnxcYVn6bKb1EehVRGCv97
Ae10kMqbQoQGaBrDSDOwYgTZ1b9XtwA3uKMZlWYglRpWrkQWeWASyX53KpfnuuaP
ERlaiCG/8iah1azRs5Tro4dGb7UywlJ5y+884qpGa+FvCObKQ39mP/CtWRFM+v1Z
QZe/OgoB6zp88cL4vNqXIw1nUbo8qg==
=S0MN
-----END PGP SIGNATURE-----

--Sig_/TieEN2MQR496/IGoxaKvyKL--

