Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455F279DF54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjIMFE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIMFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:04:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43558172A;
        Tue, 12 Sep 2023 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694581486;
        bh=Nyf0O91P1UXZcOVZPFN6jfUJr3+HOg5FG1hiFC9rnh8=;
        h=Date:From:To:Cc:Subject:From;
        b=s4kDmU+nwuDIdqP500oMVSKqpHmdyzPCyzGkHcTG8IesuPOF0rgNXqrsLF5HvP0GX
         1s+XstqKrao4IE0FaE34y77WjNBFZfCgc/BoywbQmdc/zB7WKg70SOsxY8VP8MRxrF
         Phj3ystpnNkJX3TAy1dc5ek1AHj3wK2vIGkt5DCXkcs1FjlbC9ic3wsPb8S4vO31f+
         AkRNxhTx8nHIGoOhqZMiT0EMHUAlrOGlrS+nrCIDXzOIKOfso7Lkx/c5UXYkP8v95F
         aLmVdM3k3FEhfn1C4Hvc656Z1CHc15mg5eykF867zOFsg+APyo9DKcqeDqXz51vPjL
         XP2s5GP9kFtuw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlpKV2hQCz4wy7;
        Wed, 13 Sep 2023 15:04:46 +1000 (AEST)
Date:   Wed, 13 Sep 2023 15:04:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 13
Message-ID: <20230913150445.49bee094@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jq+4F.jnOEr43=A/ACFSIa4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jq+4F.jnOEr43=A/ACFSIa4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230912:

The bpf-next tree (I think) gained a boot time warning due to a semantic
interaction with changes in the bpf tree.

The drm-misc tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 4427
 1907 files changed, 354449 insertions(+), 27039 deletions(-)

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
Merging origin/master (3669558bdf35 Merge tag 'for-6.6-rc1-tag' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (b933c63ebd3f pidfd: prevent a ker=
nel-doc warning)
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
Merging m68k-current/for-linus (eb1e6ccdcf78 zorro: Include zorro.h in name=
s.c)
Merging powerpc-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging s390-fixes/fixes (e5b7ca09e9aa Merge tag 's390-6.6-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/s390/linux)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (8cdd9f1aaedf ipv6: fix ip6_sock_set_addr_preferences() ty=
po)
Merging bpf/master (214bfd267f49 bpf, cgroup: fix multiple kernel-doc warni=
ngs)
Merging ipsec/master (f7c4e3e5d4f6 xfrm: interface: use DEV_STATS_INC())
Merging netfilter/main (7153a404fb70 Merge tag 'nf-23-09-06' of https://git=
.kernel.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging ipvs/main (931abcdcad10 Merge branch 'mlxsw-fixes')
Merging wireless/for-next (37c20b2effe9 wifi: cfg80211: fix cqm_config acce=
ss race)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging sound-current/for-linus (091c2848b0f7 ALSA: core: Use dev_name of c=
ard_dev as debugfs directory name)
Merging sound-asoc-fixes/for-linus (ec83a0b39a20 ASoC: rt5640: Fix various =
IRQ handling issues)
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
Merging iio-fixes/fixes-togreg (528a8891a8a5 iio: pressure: dps310: Adjust =
Timeout Settings)
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
Merging v4l-dvb-fixes/fixes (e7f2e65699e2 media: vcodec: Fix potential arra=
y out-of-bounds in encoder queue_setup)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (6eaae1980760 Linux 6.5-rc3)
Merging at91-fixes/at91-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (d5ad9aae13dc selftests/rseq: Fix build with undef=
ined __weak)
Merging kvms390-fixes/master (c2fceb59bbda KVM: s390: pv: fix index value o=
f replaced ASCE)
Merging hwmon-fixes/hwmon (0bb80ecc33a8 Linux 6.6-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (55b8ff06a0c7 cxl/pci: Replace host_bridge->native_=
aer with pcie_aer_is_native())
Merging btrfs-fixes/next-fixes (b4156063ffa6 Merge branch 'misc-6.6' into n=
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
Merging drm-intel-fixes/for-linux-next-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging mmc-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-mw1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging riscv-dt-fixes/riscv-dt-fixes (3e8bd1ba29f5 riscv: dts: starfive: f=
ix NOR flash reserved-data partition size)
Merging riscv-soc-fixes/riscv-soc-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl-fixes/gpio/for-current (0bb80ecc33a8 Linux 6.6-rc1)
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
Merging perf-current/perf-tools (45fc4628c15a perf parse-events: Fix driver=
 config term)
Merging efi-fixes/urgent (d6c221df1e32 efi/unaccepted: Use ACPI reclaim mem=
ory for unaccepted memory table)
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
Merging genpd-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (c900529f3d91 Merge drm/drm-fix=
es into drm-misc-fixes)
Merging mm-stable/mm-stable (0bb80ecc33a8 Linux 6.6-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (0bb80ecc33a8 Linux 6.6-rc1)
Merging mm/mm-everything (c5484f632de8 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (45fc4628c15a perf parse-events: Fix driver co=
nfig term)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (f875db4f20f4 Revert "dma-contiguous: check fo=
r memory region overlap")
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
Merging qcom/for-next (9c573e27d40a Merge branches 'arm64-defconfig-for-6.6=
', 'arm64-fixes-for-6.5', 'arm64-for-6.6', 'clk-for-6.6', 'drivers-for-6.6'=
 and 'dts-for-6.6' into for-next)
Merging renesas/next (f1f80f16cf65 Merge branches 'renesas-drivers-for-v6.7=
' and 'renesas-dts-for-v6.7' into renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (6d1fa8808888 Merge branch 'v6.5-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (a942a9ea19e3 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (7c2ca202fd35 Merge branches 'for-next/vexpress=
/fixes', 'for-next/scmi/fixes', 'for-next/scmi/updates' and 'for-next/pcc/u=
pdates' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux=
 into for-linux-next)
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
Merging clk/clk-next (3b8ca9c17912 Merge branch 'clk-fixes' into clk-next)
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
Merging parisc-hd/for-next (08700ec70504 linux/export: fix reference to exp=
orted functions for parisc64)
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
Merging bcachefs/for-next (b616e09415ca bcachefs: Add a missing prefetch in=
clude)
Applying: bcachefs: convert to dynamically allocated shrinkers
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (324718ddddc4 fscrypt: improve the "Encryption mod=
es and usage" section)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (1886ed000c2e Merge branch 'for-next-next-v6.6-20230=
911' into for-next-20230911)
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
Merging ksmbd/ksmbd-for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging nfs/linux-next (2dde18cd1d8f Linux 6.5)
Merging nfs-anna/linux-next (c12ee918adaa NFSv4.1: fix pnfs MDS=3DDS sessio=
n trunking)
Merging nfsd/nfsd-next (bc0cdaf85b24 nfsd: Don't reset the write verifier o=
n a commit EAGAIN)
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
Merging i2c/i2c/for-next (6bd4bef7f554 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (80369d9e1f2f hwmon: (sch5627) Document be=
haviour of limit registers)
Merging jc_docs/docs-next (86a0adc029d3 Documentation/sphinx: fix Python st=
ring escapes)
Merging v4l-dvb/master (9a5d660fdb25 media: ivsc: Add ACPI dependency)
Merging v4l-dvb-next/master (4c420b729238 media: ivsc: Depend on VIDEO_DEV)
Merging pm/linux-next (b5eda4c9c923 Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (16567117aa0c cpufreq: Add QCM64=
90 to cpufreq-dt-platdev blocklist)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging genpd/next (864de5b78119 genpd: Merge branch genpd_dt into next)
Merging opp/opp/linux-next (e576a9a8603f dt-bindings: cpufreq: Convert ti-c=
pufreq to json schema)
Merging thermal/thermal/linux-next (edd220b33f47 thermal: core: Drop therma=
l_zone_device_register())
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging net-next/main (8fc8911b6696 Merge branch 'tcp-backlog-processing-op=
tims')
Merging bpf-next/for-next (5bbb9e1f0835 Merge branch 'bpf-x64-fix-tailcall-=
infinite-loop')
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging netfilter-next/main (73be7fb14e83 Merge tag 'net-6.6-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-compil=
e-time-configuration')
Merging bluetooth/master (58093c0b14a3 Bluetooth: ISO: Set CIS bit only for=
 devices with CIS support)
Merging wireless-next/for-next (2cf254c1e24f wifi: iwlwifi: increase number=
 of RX buffers for EHT devices)
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
Merging drm-misc/for-linux-next (8569c3154538 drm/i915: Move the size compu=
tations to drm buddy)
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
Merging drm-intel/for-linux-next (6b711386d133 drm/i915/gt: rename DBG() to=
 GTT_TRACE())
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
Merging sound/for-next (091c2848b0f7 ALSA: core: Use dev_name of card_dev a=
s debugfs directory name)
Merging ieee1394/for-next (2dde18cd1d8f Linux 6.5)
Merging sound-asoc/for-next (5b7fa01cd783 Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-next)
Merging modules/modules-next (33c24bee4b78 kallsyms: Add more debug output =
for selftest)
Merging input/next (305dd7645503 Input: wdt87xx_i2c - use device core to cr=
eate driver-specific device attributes)
Merging block/for-next (a30edd242a49 Merge branch 'io_uring-futex' into for=
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
Merging battery/for-next (b92f5e4fccc2 power: supply: bq24257_charger: Clea=
nup OF/ID table terminators)
Merging regulator/for-next (451e85e29c9d Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (55e2b69649be kexec_lock: Replace kexec_mu=
tex() by kexec_lock() in two comments)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (34df25517a9b selinux: Annotate struct sidtab_str_cach=
e with __counted_by)
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
Merging tip/master (f4245833f91c Merge branch into tip/master: 'x86/tdx')
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
Merging ipmi/for-next (29aa98d0fe01 Merge tag 'for-linus-2023083101' of git=
://git.kernel.org/pub/scm/linux/kernel/git/hid/hid)
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
Merging rpmsg/for-next (569e93d37475 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (a5c612b9dbe1 pinctrl: da9062: don't includ=
e private GPIOLIB header)
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (2eb6e8b8bcf5 Merge branch 'devel' into for-next)
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
Merging kspp/for-next/kspp (5f536ac6a5a7 LoadPin: Annotate struct dm_verity=
_loadpin_trusted_root_digest with __counted_by)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging iommufd/for-next (0bb80ecc33a8 Linux 6.6-rc1)

--Sig_/jq+4F.jnOEr43=A/ACFSIa4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUBQu0ACgkQAVBC80lX
0GyqDgf/Yck2e3eUc9QPLwYC2it/EXq+r6jv9KdAyWNPb5IiaFfP/EdDQ8Y+5U4+
fpqtg6Wi7xISTFotP/4mLlRmFFL1T2LpDkE1ejN1lQnK1jLjSyCjcI7bZ6NkFQSe
O6FCo4Wk6DZaTdiiHH4Row+R/dz+hdiG+l9ILHW0mZLOTx+a2XdOfpeEmB7eXuCp
7m1es6Fe7JbmZ2w81uTo1wfNyCzO/xfWPeEzAohKdYqXavSSMvQyCpLxp3THsQEB
7z0lTyCH4o0RUa97tFclkOZ5Aj/13VZSe0pqejROrfifFQEG1DeeLYxcN7/HY1uC
2N4jhIP+omdGReMe3t6egX0WIOYKtg==
=sDFY
-----END PGP SIGNATURE-----

--Sig_/jq+4F.jnOEr43=A/ACFSIa4--
