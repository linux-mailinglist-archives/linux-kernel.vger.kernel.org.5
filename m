Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED078BED4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjH2GxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjH2GxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:53:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E071CC0;
        Mon, 28 Aug 2023 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693291981;
        bh=LBjKcJ4t9pj/S9HHdp6fCXFNL48z8MbNbD5PYppCfG4=;
        h=Date:From:To:Cc:Subject:From;
        b=QMNeHZJOoo292HLemQDaVdkYRYf+jawT806/hjuYCwP4JSnISUvgRWuMoiM8kZ/mY
         14AzfYmNEWlfct7SULcmvtLJ2RmpgTxvF2KZzDn5l1OhOc4IUDkbfQ28qUSF0nEis7
         /pREwJnt9Qv5UpMS+TaE8S+rdzoflxPT/L4mD3VguQczb3VVklVA4nqKJfInLrOM55
         H6/weqQua+9VpBwlNKg8z+SYUIofs6u1n3SJFS/rikGCFh8Io5bhriswnzP92OgiqC
         BLfveFiDzQ4QnpqTooIum5o8Vsm6TVlm6+zLYWupcaaB9dfV+Ef2dMupywVbnxT38V
         EU1UdrPpk8YoQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZdRK3T7cz4wxR;
        Tue, 29 Aug 2023 16:53:01 +1000 (AEST)
Date:   Tue, 29 Aug 2023 16:53:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 29
Message-ID: <20230829165300.4f5d0a4e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kROGfHGN_I4DLjZgy_68tii";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kROGfHGN_I4DLjZgy_68tii
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do *not* include material destined for v6.7 in your linux-next
included branches until *after* v6.6-rc1 has been released.  Also,
do *not* rebase you linu-next included branches onto v6.5.

Changes since 20230828:

The devicetree tree gained a conflict against the net-next tree.

The bitmap tree gained a boot failure so I used the verison from
next-20230828.

Non-merge commits (relative to Linus' tree): 11586
 13024 files changed, 571616 insertions(+), 205005 deletions(-)

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

I am currently merging 365 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (6f49693a6c85 Merge tag 'smp-core-2023-08-28' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (d7257f1886f2 memcontrol: ensure m=
emcg acquired by id is properly set up)
Merging kbuild-current/fixes (6ccbd7fd4746 alpha: remove __init annotation =
from exported page_is_ram())
Merging arc-current/for-curr (c40cad3b0aa4 ARC: boot log: fix warning)
Merging arm-current/fixes (6995e2de6891 Linux 6.4)
Merging arm64-fixes/for-next/fixes (2f43f549cd0b arm64/ptrace: Ensure that =
the task sees ZT writes on first use)
Merging arm-soc-fixes/arm/fixes (3c78dbf25135 Merge tag 'qcom-arm64-fixes-f=
or-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into =
arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (faafd6ca7e6e memory: tegra: make icc_se=
t_bw return zero if BWMGR not supported)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (eb1e6ccdcf78 zorro: Include zorro.h in name=
s.c)
Merging powerpc-fixes/fixes (4f3175979e62 powerpc/rtas_flash: allow user co=
py to flash block cache objects)
Merging s390-fixes/fixes (388acb471662 s390/ptrace: add missing linux/const=
.h include)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (90ca51e8c654 r8169: fix ASPM-related issues on a number o=
f systems with NIC version from RTL8168h)
Merging bpf/master (90ca51e8c654 r8169: fix ASPM-related issues on a number=
 of systems with NIC version from RTL8168h)
Merging ipsec/master (f3ec2b5d879e xfrm: don't skip free of empty state in =
acquire policy)
Merging netfilter/main (931abcdcad10 Merge branch 'mlxsw-fixes')
Merging ipvs/main (931abcdcad10 Merge branch 'mlxsw-fixes')
Merging wireless/for-next (b98c16107cc1 wifi: mac80211: limit reorder_buf_f=
iltered to avoid UBSAN warning)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (2ccdd1b13c59 Linux 6.5-rc6)
Merging sound-current/for-linus (d81c203e6178 Merge tag 'asoc-fix-v6.5-merg=
e-window' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound =
into for-linus)
Merging sound-asoc-fixes/for-linus (06b0a4a133af Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (52a93d39b17d Linux 6.5-rc5)
Merging regulator-fixes/for-linus (0a3f2be91c48 Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (1690a28dff8b Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (cc22522fd55e PCI: acpiphp: Use pci_assign_un=
assigned_bridge_resources() only for non-root bus)
Merging driver-core.current/driver-core-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging tty.current/tty-linus (b320441c04c9 Merge tag 'tty-6.5-rc7' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty)
Merging usb.current/usb-linus (2ccdd1b13c59 Linux 6.5-rc6)
Merging usb-serial-fixes/usb-linus (706a74159504 Linux 6.5-rc7)
Merging phy/fixes (52a93d39b17d Linux 6.5-rc5)
Merging staging.current/staging-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging iio-fixes/fixes-togreg (34477b2d710a iio: dac: ad3552r: Correct dev=
ice IDs)
Merging counter-current/counter-current (2ccdd1b13c59 Linux 6.5-rc6)
Merging char-misc.current/char-misc-linus (2ccdd1b13c59 Linux 6.5-rc6)
Merging soundwire-fixes/fixes (52a93d39b17d Linux 6.5-rc5)
Merging thunderbolt-fixes/fixes (706a74159504 Linux 6.5-rc7)
Merging input-current/for-linus (eb09074bdb05 Input: i8042 - add quirk for =
TUXEDO Gemini 17 Gen1/Clevo PD70PN)
Merging crypto-current/master (85b9bf9a514d Revert "dt-bindings: crypto: qc=
om,prng: Add SM8450")
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (569f8b501b17 selftests/arm64: fix build fail=
ure during the "emit_tests" step)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (2ccdd1b13c59 Linux 6.5-rc6)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c6abce60338a mtd: rawnand: fsl_upm: Fix an off=
-by one test in fun_exec_op())
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
Merging hwmon-fixes/hwmon (9c53fb0ad1ac hwmon: (asus-ec-sensosrs) fix mutex=
 path for X670E Hero)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (ad64f5952ce3 cxl/memdev: Only show sanitize sysfs =
files when supported)
Merging btrfs-fixes/next-fixes (84e31c126aee Merge branch 'misc-6.5' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (0848cab765c6 platform/mellanox: Fix mlxbf-=
tmfifo not handling all virtio CONSOLE notifications)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (7882541ca06d of/platform: increase refco=
unt of fwnode)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (812fe6420a6e scsi: storvsc: Handle additional SRB=
 status values)
Merging drm-fixes/drm-fixes (2dde18cd1d8f Linux 6.5)
Merging drm-intel-fixes/for-linux-next-fixes (1dcc437427bb drm/i915: Fix HP=
D polling, reenabling the output poll work as needed)
Merging mmc-fixes/fixes (58abdd80b93b mmc: f-sdh30: fix order of function c=
alls in sdhci_f_sdh30_remove)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (ef21fa7c198e riscv: Fix build errors using binu=
tils2.37 toolchains)
Merging riscv-dt-fixes/riscv-dt-fixes (602afaaa6ef9 riscv: dts: starfive: f=
ix NOR flash reserved-data partition size)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging gpio-brgl-fixes/gpio/for-current (6e39c1ac6881 gpio: sim: pass the =
GPIO device's software node to irq domain)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (4da3c7183e18 erofs: drop unnecessary WARN_ON() i=
n erofs_kill_sb())
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (8073a98e9532 NFSD: Fix a thinko introduced b=
y recent trace point changes)
Merging irqchip-fixes/irq/irqchip-fixes (6fe5c68ee6a1 irqchip/gic-v3: Worka=
round for GIC-700 erratum 2941627)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (53663f4103ff Merge tag 'nfs-for-6.5-2' of =
git://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging efi-fixes/urgent (8b94da92559f x86/efistub: Fix PCI ROM preservatio=
n in mixed mode)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (205f4cf3136f power: supply: ab8500: Set typing=
 and props)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (b7c822fa6b77 iommufd: Set end correctly when =
doing batch carry)
Merging rust-fixes/rust-fixes (3fa7187eceee rust: macros: vtable: fix `HAS_=
*` redefinition (`gen_const_name`))
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging genpd-fixes/fixes (12acb348fa45 cpuidle: psci: Move enabling OSI mo=
de after power domains creation)
Merging drm-misc-fixes/for-linux-next-fixes (0c3b063ef413 drm/drm_connector=
: Provide short description of param 'supported_colorspaces')
Merging mm-stable/mm-stable (52ae298e3e5c maple_tree: shrink struct maple_t=
ree)
CONFLICT (content): Merge conflict in arch/arc/Kconfig
CONFLICT (content): Merge conflict in arch/parisc/mm/ioremap.c
Merging mm-nonmm-stable/mm-nonmm-stable (dce8f8ed1de1 document while_each_t=
hread(), change first_tid() to use for_each_thread())
Merging mm/mm-everything (69d5f96a448e Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (bda09c0e14a4 Documentation/llvm: refresh docs)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (eeb6b12992c4 perf jevents: Don't append Unit =
to desc)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (d069ed288ac7 swiotlb: optimize get_max_slots(=
))
Merging asm-generic/master (6e8d96909a23 asm-generic: partially revert "Uni=
fy uapi bitsperlong.h for arm64, riscv and loongarch")
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (e1df27213941 Merge branch 'for-next/selftests'=
 into for-next/core)
Merging arm-perf/for-next/perf (21b61fe48c2f drivers/perf: hisi: Update HiS=
ilicon PMU maintainers)
Merging arm-soc/for-next (e46ee69a8c52 soc: document merges)
Merging amlogic/for-next (413f5c02929b Merge branch 'v6.6/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (05f42491c813 ARM: dts: aspeed: bonnell: Add reserv=
ed memory for TPM event log)
Merging at91/at91-next (b04dba7c1c30 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (a70e8c9ff89a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (35bd78cf2522 memory: tegra: add MC client =
for Tegra234 GPU)
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
Merging renesas/next (13512fa6af4a Merge branch 'renesas-dts-for-v6.6' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (6d1fa8808888 Merge branch 'v6.5-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (7a736a6b2c9b Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (5626b9a9fbe0 Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
Merging stm32/stm32-next (da50d4f56078 ARM: dts: stm32: Add Octavo OSD32MP1=
-RED board)
Merging sunxi/sunxi/for-next (aa333f5e8461 Merge branch 'sunxi/dt-for-6.6' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (4451dac4c4a5 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (d0857dc9b22d Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (7cd073eddcd4 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (c539c5c0a7cc Merge branch 'clk-lmk' into clk-next)
Merging clk-imx/for-next (72d00e560d10 clk: imx: pll14xx: dynamically confi=
gure PLL for 393216000/361267200Hz)
Merging clk-renesas/renesas-clk (708cb698ffa2 clk: renesas: rcar-gen3: Add =
ADG clocks)
Merging csky/linux-next (c8171a86b274 csky: Fixup -Wmissing-prototypes warn=
ing)
CONFLICT (content): Merge conflict in arch/csky/abiv2/cacheflush.c
Merging loongarch/loongarch-next (633ff041f064 LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (eb1e6ccdcf78 zorro: Include zorro.h in names.c)
Merging m68knommu/for-next (cf18ecd34f71 m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0d2b49479bf9 microblaze: Make virt_to_pfn() a stat=
ic inline)
Merging mips/mips-next (be87eab1320e MIPS: Add identifier names to argument=
s of die() declaration)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
CONFLICT (content): Merge conflict in arch/openrisc/mm/ioremap.c
Merging parisc-hd/for-next (77e0ddf097d6 parisc: ccio-dma: Create private r=
unway procfs root entry)
Merging powerpc/next (4c33bf147249 powerpc/mm/book3s64: Use 256M as the upp=
er limit with coherent device memory attached)
CONFLICT (content): Merge conflict in arch/powerpc/Kconfig
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (9f944d2e0ab3 riscv: Require FRAME_POINTER for some=
 configurations)
Merging riscv-dt/riscv-dt-for-next (a3ce3ff28385 riscv: dts: change TH1520 =
files to dual license)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (020ca957a616 Merge branch 'features' into for-next)
CONFLICT (content): Merge conflict in arch/s390/Kconfig
Merging sh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (a160e9414d8a xtensa: fix unaligned and load=
/store configuration interaction)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (324718ddddc4 fscrypt: improve the "Encryption mod=
es and usage" section)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (330c15bebcb4 Merge branch 'for-next-next-v6.5-20230=
824' into for-next-20230824)
Merging ceph/master (e6a28d6303a9 libceph: do not include crypto/algapi.h)
Merging cifs/for-next (6c50eaff1a4b smb3: allow controlling length of time =
directory entries are cached with dir leases)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (91b1ad0815fb erofs: release ztailpacking pclusters prope=
rly)
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (f2023a603f74 Pull ext2 kerneldoc fixes from Matthew.)
Merging ext4/dev (768d612f7982 ext4: fix slab-use-after-free in ext4_es_ins=
ert_extent())
CONFLICT (content): Merge conflict in fs/ext4/super.c
Merging f2fs/dev (3b7166121402 f2fs: use finish zone command when closing a=
 zone)
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/f2fs/xattr.c
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (7d875e66859a fuse: invalidate dentry on EEXIST creat=
es or ENOENT deletes)
Merging gfs2/for-next (0c7b3cb2302d gfs2: Sanitize kthread stopping)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (feacded69901 ksmbd: replace one-element array=
 with flex-array member in struct smb2_ea_info)
Merging nfs/linux-next (895cedc17919 xprtrdma: Remap Receive buffers after =
a reconnect)
Merging nfs-anna/linux-next (11ef962ec884 NFSv4.2: fix handling of COPY ERR=
_OFFLOAD_NO_REQ)
Merging nfsd/nfsd-next (7cdb3c020421 Documentation: Add missing documentati=
on for EXPORT_OP flags)
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (adcd459ff805 ovl: validate superblock in =
OVL_FS())
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (c1950a111dd8 fs/xfs: Fix typos in comments)
CONFLICT (content): Merge conflict in fs/xfs/scrub/scrub.c
CONFLICT (content): Merge conflict in fs/xfs/xfs_super.c
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (377698d4abe2 Merge tag 'xfs-async-dio.6-2023-=
08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (74f6f5912693 locks: fix KASAN: use-after-fre=
e in trace_event_raw_event_filelock_lock)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (f505786d6915 Merge branch 'vfs.fs_context' int=
o vfs.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (cb65d08d735e Merge branch 'for-6.6' into for-next)
Merging pci/next (ea925d9d8062 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (af58740d8b06 pstore: Fix kernel-doc warning)
Merging hid/for-next (bdf2236ba9f2 Merge branch 'for-6.6/logitech' into for=
-next)
CONFLICT (content): Merge conflict in .mailmap
Merging i2c/i2c/for-next (f9ea75e087b8 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (c6a755045892 i3c: master: Fix SETDASA process)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (919a83d020a8 hwmon: (tmp513) Simplify pro=
be())
Merging jc_docs/docs-next (c63594f2d666 Docu: genericirq.rst: fix irq-examp=
le)
Merging v4l-dvb/master (b7ec3212a73a media: bttv: convert to vb2)
Merging v4l-dvb-next/master (bf01dd96201a media: uvcvideo: Fix OOB read)
Merging pm/linux-next (07b618ec9d7a Merge branch 'pm' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (de0e85b29edf cpufreq: tegra194:=
 remove opp table in exit hook)
Merging cpupower/cpupower (af75504c3896 cpupower: Add Georgian translation =
to Makefile LANGUAGES)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging genpd/next (5e536362f6ab genpd: ti: Use for_each_node_with_property=
() simplify code logic)
Merging opp/opp/linux-next (e576a9a8603f dt-bindings: cpufreq: Convert ti-c=
pufreq to json schema)
Merging thermal/thermal/linux-next (1ef5a9f61457 thermal/drivers/tegra-bpmp=
: Check if BPMP supports trip points)
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (f5acc36b0714 IB/hfi1: Reduce printing of errors duri=
ng driver shut down)
Merging net-next/main (6c9cfb853063 net: ethernet: mtk_wed: minor change in=
 wed_{tx,rx}info_show)
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fs_ene=
t/fs_enet.h
Merging bpf-next/for-next (8be6f88b9d3f inet: fix IP_TRANSPARENT error hand=
ling)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (58dbd6428a68 RDMA/mlx5: Handles RoCE MACsec st=
eering rules addition and deletion)
Merging netfilter-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-c=
ompile-time-configuration')
Merging ipvs-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-compil=
e-time-configuration')
Merging bluetooth/master (75d095daab9f Bluetooth: btusb: add shutdown funct=
ion for QCA6174)
Merging wireless-next/for-next (b32add2d20ea Merge branch '1GbE' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (54a3f6e89fbb Merge tag 'nand/for-6.6' into mtd/next)
Merging nand/nand/next (b9283ac01a27 dt-bindings: mtd: amlogic,meson-nand: =
drop unneeded quotes)
Merging spi-nor/spi-nor/next (69d50d0461a1 mtd: spi-nor: nxp-spifi: Use hel=
per function devm_clk_get_enabled())
Merging crypto/master (85b9bf9a514d Revert "dt-bindings: crypto: qcom,prng:=
 Add SM8450")
Merging drm/drm-next (3698a75f5a98 Merge tag 'drm-intel-next-fixes-2023-08-=
24' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-ci/topic/drm-ci (7eba34e03988 drm: Add initial ci/ subdirectory)
Merging drm-misc/for-linux-next (4b2fd81f2af7 accel/ivpu: refactor deprecat=
ed strncpy)
Merging amdgpu/drm-next (38518054183f drm/amdgpu: Fix the return for gpu mo=
de1_reset)
Merging drm-intel/for-linux-next (cfd48ad8c4a9 drm/i915: Fix HPD polling, r=
eenabling the output poll work as needed)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (34b149ecae85 drm/msm/a6xx: Bail out early if sett=
ing GPU OOB fails)
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (6ee2f6aa5687 fbdev/core: Use list_for_each_entry() =
helper)
Merging regmap/for-next (26fc7cfa30d6 Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-next)
Merging sound/for-next (d81c203e6178 Merge tag 'asoc-fix-v6.5-merge-window'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (ff2ef72b755c Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (33c24bee4b78 kallsyms: Add more debug output =
for selftest)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (ba1a4af884a6 Merge branch 'for-6.6/io_uring' into f=
or-next)
CONFLICT (content): Merge conflict in fs/super.c
CONFLICT (content): Merge conflict in lib/raid6/test/Makefile
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (8847d42d7a02 ata: pata_falcon: add data_swab optio=
n to byte-swap disk data)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (98ac9e4fc07f mmc: atmel-mci: Move card detect gpio polari=
ty quirk to gpiolib)
Merging mfd/for-mfd-next (09ae9adeda9e mfd: rz-mtu3: Replace raw_spin_lock-=
>spin_lock())
Merging backlight/for-backlight-next (dfd122fe8591 backlight: lp855x: Drop =
ret variable in brightness change function)
Merging battery/for-next (7e6311f04b41 power: supply: qcom_pmi8998_charger:=
 fix charger status)
CONFLICT (content): Merge conflict in drivers/power/supply/rt5033_charger.c
Applying: fixup for "power: Explicitly include correct DT includes"
Merging regulator/for-next (6488774b5d9a Merge remote-tracking branch 'regu=
lator/for-6.6' into regulator-next)
Merging security/next (8e4672d6f902 lsm: constify the 'file' parameter in s=
ecurity_binder_transfer_file())
CONFLICT (content): Merge conflict in security/security.c
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (55e2b69649be kexec_lock: Replace kexec_mu=
tex() by kexec_lock() in two comments)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (1df83cbf23a2 selinux: prevent KMSAN warning in selinu=
x_inet_conn_request())
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (254a8ed6aab3 tomoyo: remove unused function declarat=
ion)
Merging tpmdd/next (cceb64e335ae tpm_crb: Fix an error handling path in crb=
_acpi_add())
Merging watchdog/master (8c776a0401f1 watchdog: Add support for Amlogic-T7 =
SoCs)
Merging iommu/next (d8fe59f11096 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
Merging audit/next (b1a0f64cc65e audit: move trailing statements to next li=
ne)
Merging devicetree/for-next (d117ca218b16 Merge branch 'dt/header-cleanups-=
for-6.6' into dt/next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/net/xilinx_gmii=
2rgmii.txt deleted in HEAD and modified in devicetree/for-next.  Version de=
vicetree/for-next of Documentation/devicetree/bindings/net/xilinx_gmii2rgmi=
i.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (27c418ed9b71 Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (c43963bb847e Merge branch into tip/master: 'x86/sev')
CONFLICT (content): Merge conflict in arch/s390/Kconfig
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
Applying: fix up for "mm: Make pte_mkwrite() take a VMA"
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (ce53ad81ed36 EDAC/igen6: Fix the issue of no er=
ror events)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (f940e482b0f8 Merge probes/for-next)
CONFLICT (content): Merge conflict in kernel/trace/trace.c
Merging rcu/rcu/next (94e70d269433 Merge branch 'csd-lock.2023.07.14b' into=
 HEAD)
Merging kvm/next (d5ad9aae13dc selftests/rseq: Fix build with undefined __w=
eak)
Merging kvm-arm/next (169c0f23cacc KVM: arm64: Properly return allocated EL=
2 VA from hyp_alloc_private_va_range())
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-riscv/riscv_kvm_next (477069398ed6 KVM: riscv: selftests: Add g=
et-reg-list test)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/include/t=
est_util.h
Merging kvm-x86/next (e2013f46ee2e Merge branch 'misc')
Merging xen-tip/linux-next (475505975093 xen: simplify evtchn_do_upcall() c=
all maze)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (c076af902bdf Merge branch 'for-6.6' into for-n=
ext)
Merging drivers-x86/for-next (ecaa1867b524 platform/x86: ideapad-laptop: Ad=
d support for keyboard backlights using KBLC ACPI symbol)
Merging chrome-platform/for-next (0820debb7d48 platform/chrome: chromeos_ac=
pi: print hex string for ACPI_TYPE_BUFFER)
Merging chrome-platform-firmware/for-firmware-next (0979e7e3cfd7 MAINTAINER=
S: Add drivers/firmware/google/ entry)
Merging hsi/for-next (7ebf243a2018 hsi: omap_ssi: Explicitly include correc=
t DT includes)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (baca986e1f2c leds: aw2013: Enable pull-up su=
pply for interrupt and I2C)
Merging ipmi/for-next (d40f09c1a230 ipmi_si: fix -Wvoid-pointer-to-enum-cas=
t warning)
Merging driver-core/driver-core-next (29c8ab79e91d driver core: Call in rev=
ersed order in device_platform_notify_remove())
Merging usb/usb-next (895ed7eb263d Merge tag 'usb-serial-6.6-rc1' of https:=
//git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next)
CONFLICT (modify/delete): Documentation/ABI/testing/sysfs-bus-umc deleted i=
n usb/usb-next and modified in HEAD.  Version HEAD of Documentation/ABI/tes=
ting/sysfs-bus-umc left in tree.
CONFLICT (modify/delete): Documentation/ABI/testing/sysfs-class-uwb_rc-wusb=
hc deleted in usb/usb-next and modified in HEAD.  Version HEAD of Documenta=
tion/ABI/testing/sysfs-class-uwb_rc-wusbhc left in tree.
$ git rm -f Documentation/ABI/testing/sysfs-bus-umc Documentation/ABI/testi=
ng/sysfs-class-uwb_rc-wusbhc
Merging thunderbolt/next (a3f6445842e5 Documentation/ABI: thunderbolt: Repl=
ace 01.org in contact)
Merging usb-serial/usb-next (4d9488b294e1 USB: serial: option: add FOXCONN =
T99W368/T99W373 product)
Merging tty/tty-next (ebf05c7dc92c tty: shrink the size of struct tty_struc=
t by 40 bytes)
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/fs_pd.h
CONFLICT (content): Merge conflict in arch/powerpc/platforms/8xx/mpc885ads_=
setup.c
CONFLICT (content): Merge conflict in arch/powerpc/platforms/8xx/tqm8xx_set=
up.c
CONFLICT (content): Merge conflict in arch/powerpc/sysdev/fsl_soc.c
Merging char-misc/char-misc-next (704e2c6107f1 Merge tag 'icc-6.6-rc1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next)
CONFLICT (content): Merge conflict in Documentation/ABI/testing/sysfs-bus-f=
si-devices-sbefifo
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (64227235abd9 misc: fastrpc: Pass proper scm argum=
ents for static process init)
Merging fpga/for-next (1a22ec09a2c1 fpga: region: make fpga_region_class a =
static const structure)
Merging icc/icc-next (6ac3f01201fa Merge branch 'icc-debugfs' into icc-next)
Merging iio/togreg (14b7447cec15 Documentation: ABI: testing: admv8818: add=
 bypass)
Merging phy-next/next (691525074db9 phy: exynos5-usbdrd: Add Exynos850 supp=
ort)
Merging soundwire/next (8c4c9a9ae5af soundwire: intel_ace2x: add DAI hw_par=
ams/prepare/hw_free callbacks)
Merging extcon/extcon-next (d20a3a8a32e3 extcon: cht_wc: add POWER_SUPPLY d=
ependency)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (642265e22ecc vfio/pds: Send type for SUSPEND_STATUS comm=
and)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (aee17df05ea3 staging: rtl8192e: Annotate stru=
ct rtllib_txb with __counted_by)
Merging counter-next/counter-next (39266b642ccd counter: rz-mtu3-cnt: Reord=
er locking sequence for consistency)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (72f5801a4e2b dmaengine: fsl-edma: integrate v3 supp=
ort)
CONFLICT (content): Merge conflict in drivers/dma/mcf-edma-main.c
Merging cgroup/for-next (78d44b824ed0 cgroup: Avoid -Wstringop-overflow war=
nings)
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/.gitig=
nore
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/Makefi=
le
Applying: Revert "cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHE=
D"
Merging scsi/for-next (8bfe8fedf494 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (15924b050363 scsi: fnic: Replace sgreset tag wit=
h max_tag_id)
CONFLICT (content): Merge conflict in drivers/scsi/fnic/fnic.h
Merging vhost/linux-next (1049323f971d virtio_ring: fix avail_wrap_counter =
in virtqueue_add_packed)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (569e93d37475 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (3d0957b07e27 gpio: pca953x: add support fo=
r TCA9538)
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (b4e880a8d840 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (d5301c90716a pinctrl: cherryview: fix addre=
ss_space_handler() argument)
Merging pinctrl-renesas/renesas-pinctrl (3a629cf4f0e6 Merge tag 'renesas-pi=
nctrl-fixes-for-v6.5-tag2' into renesas-pinctrl)
Merging pinctrl-samsung/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pwm/for-next (4aae44f65827 pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (9b1db732866b selftests: cachestat: use proper sysca=
ll number macro)
Merging kunit/test (06c2afb862f9 Linux 6.5-rc1)
Merging kunit-next/kunit (25e324bc9cf2 kunit: fix struct kunit_attr header)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (7130856f5605 rtc: twl: add NVRAM support)
Merging nvdimm/libnvdimm-for-next (08ca6906a4b7 nvdimm: Fix dereference aft=
er free in register_nvdimm_pmu())
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (643982232860 ntb: Check tx descriptors outstanding in=
stead of head/tail for tx queue)
Merging seccomp/for-next/seccomp (46822860a5a9 seccomp: Add missing kerndoc=
 notations)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (0991afbe4b18 nvmem: core: Notify when a new layout =
is registered)
Merging xarray/main (cbc02854331e XArray: Do not return sibling entries fro=
m xa_load())
Merging hyperv/hyperv-next (284930a0146a x86/hyperv: Remove duplicate inclu=
de)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (06c2afb862f9 Linux 6.5-rc1)
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
Merging slab/for-next (66489e5487b7 Merge branch 'slab/for-6.6/random_kmall=
oc' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (246c713a3655 landlock: Annotate struct landlock_rule=
 with __counted_by)
Merging rust/rust-next (4af84c6a85c6 rust: init: update expanded macro expl=
anation)
CONFLICT (content): Merge conflict in rust/kernel/init.rs
Merging sysctl/sysctl-next (53f3811dfd5e sysctl: Use ctl_table_size as stop=
ping criteria for list macro)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (3e360ea65320 bitmap: move bitmap_*_region()=
 functions to bitmap.h)
$ git reset --hard HEAD^
Merging next-20230828 version of bitmap
Merging hte/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging kspp/for-next/kspp (5f536ac6a5a7 LoadPin: Annotate struct dm_verity=
_loadpin_trusted_root_digest with __counted_by)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (556fb7131e03 tools/nolibc: avoid undesired casts in =
the __sysret() macro)
CONFLICT (content): Merge conflict in tools/include/nolibc/stdio.h
CONFLICT (content): Merge conflict in tools/testing/selftests/nolibc/nolibc=
-test.c
Merging iommufd/for-next (eb501c2d96cf iommufd/selftest: Don't leak the pla=
tform device memory when unloading the module)

--Sig_/kROGfHGN_I4DLjZgy_68tii
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTtlcwACgkQAVBC80lX
0GyiHwgAoVNSidQR8fMGsYJDTWq3vYfEQaSopmk6z9sXB6ksY5354M4FaVhakkTH
vliFRTXM3dxjvICU/E7R4uiBLBHCUQNxijcKijrLjEwtLMcdYF5Ps8pxloitiiRg
yGWSfETJOkc1ywNRtsc3bSfnl+0W+qo6MUCqzwv2nCYsRuPbpNynxV/0ZV2YzDtv
tVx7ZgCITm+convUCzOb5MxXfCg4ACihSAuvqY1Ze4KZUdDOOZvbsn5XWWMBE6m5
hNtdPRU3o1qrhJCGe2g3q/ny5QakeKlVOaWgzcUKi5870AAEpWjrAweeuOBCshFv
bpWK1q4LSjCR4EPkgYc02SANpEeh+Q==
=OPnS
-----END PGP SIGNATURE-----

--Sig_/kROGfHGN_I4DLjZgy_68tii--
