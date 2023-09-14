Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BD79F879
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjINCwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjINCwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:52:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B910C3;
        Wed, 13 Sep 2023 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694659929;
        bh=B4Iwua31T8H43gzn/olbcSD5f8E95TvydlrpKupKrG4=;
        h=Date:From:To:Cc:Subject:From;
        b=j0p6okyh3YAxC3mM05Nrq4hFL+bOR1ClaRyZILIABB8bp3GsLJiQhcNsJteXdyT32
         yjfBD8OH+DExCXggVgni5x3Vzp+/MXGCV3u79F2XAtbOE0sr2/VXN/Nisb6skPwdoe
         wxTq+X3u9wHeQWNGxR6qbpHzd2lElr7rALNp8fNqZaS6nGn59yg2bZ1k0xOQ9RlRsH
         0KgyuxnbwuIxzyVCTeQEmwAnW8nrlam0LwQYPo37UFucQdahl1gmhDDpNq9/oIAGZg
         YuHJJMLnC8rXgD4mWWyLi3ZvP8P++VC/j8gvQsgl7VLwDuyMkoAt4RhrTwyKcDwM9I
         /SqkMlNAdv4tQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmML13wtXz4wZw;
        Thu, 14 Sep 2023 12:52:09 +1000 (AEST)
Date:   Thu, 14 Sep 2023 12:52:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 14
Message-ID: <20230914125207.5b2d1a05@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bchTyZuSIFYRo2ib8pr/Ren";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bchTyZuSIFYRo2ib8pr/Ren
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230913:

The wireless-next tree gained a conflist against Linus' tree.

The kspp tree gained a build failure so I used the version from
next-20230913.

Non-merge commits (relative to Linus' tree): 4776
 2191 files changed, 360805 insertions(+), 30045 deletions(-)

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

I am currently merging 366 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (aed8aee11130 Merge tag 'pmdomain-v6.6-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (ff9c40b17507 mips: use nth_page()=
 in place of direct struct page manipulation)
Merging kbuild-current/fixes (6ccbd7fd4746 alpha: remove __init annotation =
from exported page_is_ram())
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (6995e2de6891 Linux 6.4)
Merging arm64-fixes/for-next/fixes (8bd795fedb84 arm64: csum: Fix OoB acces=
s in IP checksum code for negative lengths)
Merging arm-soc-fixes/arm/fixes (3c78dbf25135 Merge tag 'qcom-arm64-fixes-f=
or-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into =
arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (010d358b9087 m68k: sun3/3x: Add and use "su=
n3.h")
Merging powerpc-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging s390-fixes/fixes (e5b7ca09e9aa Merge tag 's390-6.6-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/s390/linux)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (bc6ed2fa24b1 igb: clean up in all error paths when enabli=
ng SR-IOV)
Merging bpf/master (8a19edd4fa6f selftests/bpf: Fix kprobe_multi_test/attac=
h_override test)
Merging ipsec/master (f7c4e3e5d4f6 xfrm: interface: use DEV_STATS_INC())
Merging netfilter/main (7153a404fb70 Merge tag 'nf-23-09-06' of https://git=
.kernel.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging ipvs/main (931abcdcad10 Merge branch 'mlxsw-fixes')
Merging wireless/for-next (6e48ebffc2db wifi: mac80211: fix mesh id corrupt=
ion on 32 bit systems)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging sound-current/for-linus (26f7111abd8e ALSA: usb-audio: mixer: Remov=
e temporary string use in parse_clock_source_unit)
Merging sound-asoc-fixes/for-linus (cf0ba445f5e4 ASoC: codecs: aw88395: Fix=
 some error codes)
Merging regmap-fixes/for-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging regulator-fixes/for-linus (6223e073db78 regulator: Fix voltage rang=
e selection)
Merging spi-fixes/for-linus (9855d60cfc72 spi: intel-pci: Add support for G=
ranite Rapids SPI serial flash)
Merging pci-current/for-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging driver-core.current/driver-core-linus (fd6f7ad2fd4d driver core: re=
turn an error when dev_set_name() hasn't happened)
Merging tty.current/tty-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging usb.current/usb-linus (f26a679ed799 usb: typec: ucsi: Fix NULL poin=
ter dereference)
Merging usb-serial-fixes/usb-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging phy/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging.current/staging-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging iio-fixes/fixes-togreg (00be24c416e4 iio: light: vcnl4000: Don't po=
wer on/off chip in config)
Merging counter-current/counter-current (df8fdd01c98b counter: microchip-tc=
b-capture: Fix the use of internal GCLK logic)
Merging char-misc.current/char-misc-linus (98a158166360 Revert "comedi: add=
 HAS_IOPORT dependencies")
Merging soundwire-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging thunderbolt-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging input-current/for-linus (1ac731c529cd Merge branch 'next' into for-=
linus)
Merging crypto-current/master (ba22e81872c1 crypto: powerpc/chacha20,poly13=
05-p10 - Add dependency on VSX)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (7e021da80f48 selftests: tracing: Fix to unmo=
unt tracefs for recovering environment)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (9836a987860e mtd: spinand: micron: correct bit=
mask for ecc status)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (6eaae1980760 Linux 6.5-rc3)
Merging at91-fixes/at91-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging omap-fixes/fixes (06f114cf7cbe Merge branches 'fixes-mapphone' and =
'fixes-ti-sysc' into fixes)
Merging kvm-fixes/master (d5ad9aae13dc selftests/rseq: Fix build with undef=
ined __weak)
Merging kvms390-fixes/master (c2fceb59bbda KVM: s390: pv: fix index value o=
f replaced ASCE)
Merging hwmon-fixes/hwmon (0bb80ecc33a8 Linux 6.6-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (55b8ff06a0c7 cxl/pci: Replace host_bridge->native_=
aer with pcie_aer_is_native())
Merging btrfs-fixes/next-fixes (850c8ce8d391 Merge branch 'misc-6.6' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (4106a70ddad5 platform/x86: asus-wmi: Suppo=
rt 2023 ROG X16 tablet mode)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (55e95bfccf6d of: dynamic: Fix potential =
memory leak in of_changeset_action())
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (812fe6420a6e scsi: storvsc: Handle additional SRB=
 status values)
Merging drm-fixes/drm-fixes (afaf2b38025a Merge tag 'drm-misc-next-fixes-20=
23-09-11' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (7c95ec3b5947 drm/i915: Only c=
heck eDP HPD when AUX CH is shared)
Merging mmc-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (8eb8fe67e2c8 riscv: errata: fix T-Head dcache.c=
va encoding)
Merging riscv-dt-fixes/riscv-dt-fixes (1558209533f1 riscv: dts: starfive: v=
isionfive 2: Fix uart0 pins sort order)
Merging riscv-soc-fixes/riscv-soc-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl-fixes/gpio/for-current (2d48c30176fa MAINTAINERS: gpio-re=
gmap: make myself a maintainer of it)
Merging gpio-intel-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-intel-fixes/fixes (2d325e54d9e2 pinctrl: baytrail: fix debo=
unce disable case)
Merging erofs-fixes/fixes (75a5221630fe erofs: fix memory leak of LZMA glob=
al compressed deduplication)
Merging kunit-fixes/kunit-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (88956eabfdea NFSD: fix possible oops when nf=
sd/pool_stats is closed.)
Merging irqchip-fixes/irq/irqchip-fixes (cfa1f9db6d60 dt-bindings: interrup=
t-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells'=
 property)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (c2122b687c21 tools headers UAPI: Update to=
ols's copy of drm.h headers)
Merging efi-fixes/urgent (560f54eaa44c efi/x86: Disable buggy QueryVariable=
Info() on HP ProBook x360)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (4ec7b666fb42 power: vexpress: fix -Wvoid-point=
er-to-enum-cast warning)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging rust-fixes/rust-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pmdomain-fixes/fixes (e2ad626f8f40 pmdomain: Rename the genpd subsy=
stem to pmdomain)
Merging drm-misc-fixes/for-linux-next-fixes (c900529f3d91 Merge drm/drm-fix=
es into drm-misc-fixes)
Merging mm-stable/mm-stable (0bb80ecc33a8 Linux 6.6-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (0bb80ecc33a8 Linux 6.6-rc1)
Merging mm/mm-everything (c7934e3f58e5 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (45fc4628c15a perf parse-events: Fix driver co=
nfig term)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (8556f6921c28 swiotlb: fix the check whether a=
 device has used software IO TLB)
Merging asm-generic/master (6e8d96909a23 asm-generic: partially revert "Uni=
fy uapi bitsperlong.h for arm64, riscv and loongarch")
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (e1df27213941 Merge branch 'for-next/selftests'=
 into for-next/core)
Merging arm-perf/for-next/perf (21b61fe48c2f drivers/perf: hisi: Update HiS=
ilicon PMU maintainers)
Merging arm-soc/for-next (42ed07054d75 soc: document merges)
Merging amlogic/for-next (929266f846b3 Merge branch 'v6.7/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (05f42491c813 ARM: dts: aspeed: bonnell: Add reserv=
ed memory for TPM event log)
Merging at91/at91-next (b04dba7c1c30 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (a70e8c9ff89a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging imx-mxs/for-next (246e2cc22265 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (a8e364c2c428 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (6387fcbea64f Merge branch 'omap-for-v6.6/ti-sysc' in=
to for-next)
Merging qcom/for-next (f6f46954a711 Merge branches 'clk-for-6.7' and 'drive=
rs-for-6.7' into for-next)
Merging renesas/next (f1f80f16cf65 Merge branches 'renesas-drivers-for-v6.7=
' and 'renesas-dts-for-v6.7' into renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (6d1fa8808888 Merge branch 'v6.5-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (a942a9ea19e3 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (a184af4d455d Merge branches 'for-next/scmi/fix=
es', 'for-next/scmi/updates' and 'for-next/pcc/updates' of git://git.kernel=
.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (c848f884d1b4 ARM: dts: stm32: Add Octavo OSD32MP1=
-RED board)
Merging sunxi/sunxi/for-next (aa333f5e8461 Merge branch 'sunxi/dt-for-6.6' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (c62440bd774b Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging xilinx/for-next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging clk/clk-next (78fd9cf91630 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (72d00e560d10 clk: imx: pll14xx: dynamically confi=
gure PLL for 393216000/361267200Hz)
Merging clk-renesas/renesas-clk (f3ea14c6a243 clk: renesas: r9a06g032: Use =
for_each_compatible_node())
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (91f3eb2e7791 LoongArch: Don't inline kasa=
n_mem_to_shadow()/kasan_shadow_to_mem())
Merging m68k/for-next (eb1e6ccdcf78 zorro: Include zorro.h in names.c)
Merging m68knommu/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (e7513eccb7d7 MIPS: TXx9: Do PCI error checks on own=
 line)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging powerpc/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-dt/riscv-dt-for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-soc/riscv-soc-for-next (78a03b9f8e6b riscv: Kconfig: Add sele=
ct ARM_AMBA to SOC_STARFIVE)
Merging s390/for-next (06fc3b0d2251 s390/vmem: do not silently ignore mappi=
ng limit)
Merging sh/for-next (246f80a0b17f sh: push-switch: Reorder cleanup operatio=
ns to avoid use-after-free bug)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (03ce34cf8f50 xtensa: add XIP-aware MTD supp=
ort)
Merging bcachefs/for-next (d3410e0003a7 bcachefs: Heap allocate btree_trans)
Applying: bcachefs: convert to dynamically allocated shrinkers
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (324718ddddc4 fscrypt: improve the "Encryption mod=
es and usage" section)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (1886ed000c2e Merge branch 'for-next-next-v6.6-20230=
911' into for-next-20230911)
CONFLICT (content): Merge conflict in fs/btrfs/delayed-ref.c
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/btrfs/transaction.c
Merging ceph/master (ce0d5bd3a6c1 ceph: make num_fwd and num_retry to __u32)
Merging cifs/for-next (05d0f8f55ad6 smb3: move server check earlier when se=
tting channel sequence number)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (91b1ad0815fb erofs: release ztailpacking pclusters prope=
rly)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (d3cc1b0be258 quota: explicitly forbid quota files fr=
om being encrypted)
Merging ext4/dev (147d4a092e9a jbd2: Remove page size assumptions)
Merging f2fs/dev (3669558bdf35 Merge tag 'for-6.6-rc1-tag' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (f73016b63b09 fuse: conditionally fill kstat in fuse_=
do_statx())
Merging gfs2/for-next (4f575b4604de gfs2: Fix another freeze/thaw hang)
Merging jfs/jfs-next (0225e10972fa jfs: validate max amount of blocks befor=
e allocation.)
Merging ksmbd/ksmbd-for-next (59d8d24f4610 ksmbd: fix passing freed memory =
'aux_payload_buf')
Merging nfs/linux-next (2dde18cd1d8f Linux 6.5)
Merging nfs-anna/linux-next (806a3bc421a1 NFSv4.1: fix pnfs MDS=3DDS sessio=
n trunking)
Merging nfsd/nfsd-next (11d1df89720e lockd: add doc to enable EXPORT_OP_ASY=
NC_LOCK)
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (724768a39374 ovl: fix incorrect fdput() o=
n aio completion)
Merging ubifs/next (017c73a34a66 ubi: Refuse attaching if mtd's erasesize i=
s 0)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (c1950a111dd8 fs/xfs: Fix typos in comments)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (4aa8cdd5e523 iomap: handle error conditions m=
ore gracefully in iomap_to_bh)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (460ff2c3c768 Merge branch 'vfs.super' into vfs=
.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (189f53ec6668 Merge branch 'for-6.6-fixup' into for=
-next)
Merging pci/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pstore/for-next/pstore (94160062396d pstore: Base compression input=
 buffer size on estimated compressed size)
Merging hid/for-next (bd0ffb67f8d3 Merge branch 'for-6.6/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (637f33a4fe86 i2c: cadence: Fix the kernel-doc war=
nings)
Merging i3c/i3c/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (80369d9e1f2f hwmon: (sch5627) Document be=
haviour of limit registers)
Merging jc_docs/docs-next (86a0adc029d3 Documentation/sphinx: fix Python st=
ring escapes)
Merging v4l-dvb/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging v4l-dvb-next/master (0835b195d034 media: ivsc: Depend on VIDEO_DEV)
Merging pm/linux-next (b5eda4c9c923 Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (16567117aa0c cpufreq: Add QCM64=
90 to cpufreq-dt-platdev blocklist)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging pmdomain/next (ae3a94e4adee pmdomain: starfive: Add JH7110 AON PMU =
support)
Merging opp/opp/linux-next (e576a9a8603f dt-bindings: cpufreq: Convert ti-c=
pufreq to json schema)
Merging thermal/thermal/linux-next (edd220b33f47 thermal: core: Drop therma=
l_zone_device_register())
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging net-next/main (ca5ab9638e92 Merge branch 'selftests-classid')
Merging bpf-next/for-next (558c50cc3b13 docs/bpf: update out-of-date doc in=
 BPF flow dissector)
Applying: bpf: Skip unit_size checking for global per-cpu allocator
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging netfilter-next/main (73be7fb14e83 Merge tag 'net-6.6-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-compil=
e-time-configuration')
Merging bluetooth/master (c0c68490dadb Bluetooth: ISO: Set CIS bit only for=
 devices with CIS support)
Merging wireless-next/for-next (e160ab85166e wifi: mac80211: don't return u=
nset power in ieee80211_get_tx_power())
CONFLICT (content): Merge conflict in drivers/staging/rtl8723bs/os_dep/ioct=
l_cfg80211.c
CONFLICT (content): Merge conflict in net/wireless/nl80211.c
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (8ffd18a6744b mtd: lpddr_cmds: Add literal suffix)
Merging nand/nand/next (48919c6c4838 mtd: rawnand: remove 'nand_exit_status=
_op()' prototype)
Merging spi-nor/spi-nor/next (69d50d0461a1 mtd: spi-nor: nxp-spifi: Use hel=
per function devm_clk_get_enabled())
Merging crypto/master (85b9bf9a514d Revert "dt-bindings: crypto: qcom,prng:=
 Add SM8450")
Merging drm/drm-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (fc71f615fd08 drm/amd/display: Fix -Wuninit=
ialized in dm_helpers_dp_mst_send_payload_allocation())
CONFLICT (content): Merge conflict in drivers/gpu/drm/mediatek/mtk_dpi.c
Merging amdgpu/drm-next (addd7aef251c drm/amdgpu: add remap_hdp_registers c=
allback for nbio 7.11)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dis=
covery.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_mqd_ma=
nager_v11.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn32/=
dcn32_resource.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu_v13_0_6_ppsmc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/smu_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
Merging drm-intel/for-linux-next (3072a24c778a drm/i915: Introduce crtc_sta=
te->enhanced_framing)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (34b149ecae85 drm/msm/a6xx: Bail out early if sett=
ing GPU OOB fails)
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (2dde18cd1d8f Linux 6.5)
Merging regmap/for-next (d3601857e14d regmap: debugfs: Fix a erroneous chec=
k after snprintf())
Merging sound/for-next (26f7111abd8e ALSA: usb-audio: mixer: Remove tempora=
ry string use in parse_clock_source_unit)
Merging ieee1394/for-next (2dde18cd1d8f Linux 6.5)
Merging sound-asoc/for-next (afe49745efb0 Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-next)
Merging modules/modules-next (33c24bee4b78 kallsyms: Add more debug output =
for selftest)
Merging input/next (305dd7645503 Input: wdt87xx_i2c - use device core to cr=
eate driver-specific device attributes)
Merging block/for-next (d975b468819a Merge branch 'io_uring-futex' into for=
-next)
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (fa2259a59966 ata: libata: Cleanup inline DMA helpe=
r functions)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging mfd/for-mfd-next (9aab92bc3a89 mfd: mc13xxx: Simplify device data f=
etching in probe())
Merging backlight/for-backlight-next (a4464092f2c5 backlight: led_bl: Remov=
e redundant of_match_ptr())
Merging battery/for-next (bbaa6ffa5b6c power: supply: core: Use blocking_no=
tifier_call_chain to avoid RCU complaint)
Merging regulator/for-next (451e85e29c9d Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (64fc9526147c lsm: constify 'bprm' parameter in secur=
ity_bprm_committing_creds())
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (55e2b69649be kexec_lock: Replace kexec_mu=
tex() by kexec_lock() in two comments)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (9d140885e35d selinux: hweight optimization in avtab_r=
ead_item)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (ea72883a3bf1 tpm: Fix typo in tpmrm class definition)
Merging watchdog/master (8c776a0401f1 watchdog: Add support for Amlogic-T7 =
SoCs)
Merging iommu/next (d8fe59f11096 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
Merging audit/next (97f576eb38ae audit: Annotate struct audit_chunk with __=
counted_by)
Merging devicetree/for-next (d117ca218b16 Merge branch 'dt/header-cleanups-=
for-6.6' into dt/next)
Merging dt-krzk/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (678466ba6891 Merge remote-tracking branch 'spi/for-6.=
7' into spi-next)
Merging tip/master (3598e2142f49 Merge branch into tip/master: 'x86/tdx')
Merging clockevents/timers/drivers/next (0a8b07c77ea0 clocksource: Explicit=
ly include correct DT includes)
Merging edac/edac-for-next (ce53ad81ed36 EDAC/igen6: Fix the issue of no er=
ror events)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (fc1653abba0d Merge probes/for-next)
Merging rcu/rcu/next (94e70d269433 Merge branch 'csd-lock.2023.07.14b' into=
 HEAD)
Merging kvm/next (d011151616e7 Merge branch 'kvm-x86-mmu-6.6' into HEAD)
Merging kvm-arm/next (169c0f23cacc KVM: arm64: Properly return allocated EL=
2 VA from hyp_alloc_private_va_range())
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-riscv/riscv_kvm_next (477069398ed6 KVM: riscv: selftests: Add g=
et-reg-list test)
Merging kvm-x86/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging xen-tip/linux-next (475505975093 xen: simplify evtchn_do_upcall() c=
all maze)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (96796025f400 Merge branch 'for-6.6' into for-n=
ext)
Merging drivers-x86/for-next (2c97d3e55b70 platform/x86: asus-wmi: add supp=
ort for ASUS screenpad)
Merging chrome-platform/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging chrome-platform-firmware/for-firmware-next (0bb80ecc33a8 Linux 6.6-=
rc1)
Merging hsi/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (baca986e1f2c leds: aw2013: Enable pull-up su=
pply for interrupt and I2C)
Merging ipmi/for-next (b00839ca4cca ipmi: refactor deprecated strncpy)
Merging driver-core/driver-core-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging usb/usb-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging thunderbolt/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging usb-serial/usb-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging tty/tty-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging char-misc/char-misc-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (1a22ec09a2c1 fpga: region: make fpga_region_class a =
static const structure)
Merging icc/icc-next (6ac3f01201fa Merge branch 'icc-debugfs' into icc-next)
Merging iio/togreg (22da192f43f7 iio: pressure: ms5637: Use i2c_get_match_d=
ata())
Merging phy-next/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging soundwire/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging extcon/extcon-next (d20a3a8a32e3 extcon: cht_wc: add POWER_SUPPLY d=
ependency)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (642265e22ecc vfio/pds: Send type for SUSPEND_STATUS comm=
and)
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging counter-next/counter-next (631c15d5f14d counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging cgroup/for-next (78d44b824ed0 cgroup: Avoid -Wstringop-overflow war=
nings)
Merging scsi/for-next (bd198f03568f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (d32533d30e21 scsi: ufs: core: Poll HCS.UCRDY bef=
ore issuing a UIC command)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_dfs.c
Merging vhost/linux-next (1acfe2c12258 virtio_ring: fix avail_wrap_counter =
in virtqueue_add_packed)
Merging rpmsg/for-next (d1a8ac11ee72 remoteproc: mediatek: Refine ipi handl=
er error message)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (7777fa924754 gpio: eic-sprd: use a helper =
variable for &pdev->dev)
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (020e9c593a0d Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (2d325e54d9e2 pinctrl: baytrail: fix debounc=
e disable case)
Merging pinctrl-renesas/renesas-pinctrl (21c11421db1f pinctrl: renesas: r8a=
7779: s/LSBC/LBSC/)
Merging pinctrl-samsung/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pwm/for-next (4aae44f65827 pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (3f3f384139ed selftests: Keep symlinks, when possibl=
e)
Merging kunit/test (0bb80ecc33a8 Linux 6.6-rc1)
Merging kunit-next/kunit (9076bc476d7e kunit: Fix possible memory leak in k=
unit_filter_suites())
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging nvdimm/libnvdimm-for-next (08ca6906a4b7 nvdimm: Fix dereference aft=
er free in register_nvdimm_pmu())
Merging at24/at24/for-next (4cdc5dbbc1df eeprom: at24: Drop at24_get_chip_d=
ata())
Merging ntb/ntb-next (643982232860 ntb: Check tx descriptors outstanding in=
stead of head/tail for tx queue)
Merging seccomp/for-next/seccomp (46822860a5a9 seccomp: Add missing kerndoc=
 notations)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (284930a0146a x86/hyperv: Remove duplicate inclu=
de)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (0724869ede9c bus: mhi: host: pci_generic: add support=
 for Telit FE990 modem)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (b691118f2c44 Merge remote-tracking branch 'linux-efi/urge=
nt' into efi/next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/slab/for-next (46a9ea668190 mm/slab_common: fix slab_caches li=
st corruption after kmem_cache_destroy())
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (2a2015495142 selftests/landlock: Fix a resource leak)
Merging rust/rust-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging sysctl/sysctl-next (53f3811dfd5e sysctl: Use ctl_table_size as stop=
ping criteria for list macro)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (bcafd8b927ed bitmap: Remove dead code, i.e.=
 bitmap_copy_le())
Merging hte/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging kspp/for-next/kspp (366c47121bf6 uapi: stddef.h: Fix header guard l=
ocation)
$ git reset --hard HEAD^
Merging next-20230913 version of kspp
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging iommufd/for-next (0bb80ecc33a8 Linux 6.6-rc1)

--Sig_/bchTyZuSIFYRo2ib8pr/Ren
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCdVcACgkQAVBC80lX
0GwOCgf/QJDW4XHPhkNP808Il28dcsrwtzlxBmMhsufS64QYPMwWZssE916nziPf
LWndG/U0m24vPzcu51qtoPfUt7VMc8ZCjte4mPlGYv8dyqUZBhEIGzyO8XA4G7Iu
BPLS/06bxpbxnu7qQeoXRpTO0HRYUL+ZuMhHODl0WmZs9bLTopstGLRxRP4gIM2o
zuUHXcLqY0ezbqN9oPOXUFq3BP44fev22h8u9guJxC2rsNoJQukRR/OK0wzhxBmq
+lzQo1Ho5H4WFCdqr3xNyhnTwLhiOD3wMB4vz1s4fWT6s+Boa1z558+blp819Wwg
kqCPV6rvyXCDTL/QMYpgYXgMjNsV2g==
=MpXk
-----END PGP SIGNATURE-----

--Sig_/bchTyZuSIFYRo2ib8pr/Ren--
