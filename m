Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8B77CBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjHOLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjHOLqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:46:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E06B10F2;
        Tue, 15 Aug 2023 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692099971;
        bh=1Kl40O1tJUSfeN47jfrtjAM/lMaT+aeIVlqg9k9G1qk=;
        h=Date:From:To:Cc:Subject:From;
        b=pN+8jvzUKWCSuqmLb+ltsFWmIemiNiAd7LMxVg4fw45SFj7+4Q0lWeAmEV8UDmteM
         tC7CjIIl/foGtytJzsynUZKmKUoWBK9JtXUBb9rGQ3s0T+h2HGQruXhyeDvA734tf9
         WEvaXVPDSQHTTcXphNPZYGubgrSyk8auWkRl7SpVKhQ0yanGXWkg0d0nvjpzV2+g0Y
         ZmZoxuKOARLuQIQd+QCmhWlumyHy9CGPhsHGTNrelSxCR0i6Oh332WEkFtCYUX79W3
         ouL3VXHogXWd+7tq3muL5OgcLqDlJrFuPYeAfsq3azVRqN9aqxs3G0u6soLJRQoP8U
         90HCkOfdwauRg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ8c32pRXz4wZs;
        Tue, 15 Aug 2023 21:46:11 +1000 (AEST)
Date:   Tue, 15 Aug 2023 21:46:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 15
Message-ID: <20230815214610.0b097d68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4IX_r1Rm.hI=tj.WUfswG92";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4IX_r1Rm.hI=tj.WUfswG92
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230809:

The mm-stable tree gained a conflict against Linus' tree.

The mm tree lost its build failure.

The scmi tree gained a conflict against the arm-soc tree.

The csky tree gained a conflict against the mm tree.

The nfsd tree gained a conflict against the nfsd-fixes tree.

The vfs-brauner tree gained conflicts against the btrfs and f2fs trees.

The hid tree gained a conflict against Linus' tree.

The i2c tree gained a conflict against the i2c-host-fixes tree.

The mlx5-next tree gained conflicts against Linus' tree and the net-next
tree.

The block tree gained a conflict against the loongarch tree.

The tip tree gained conflicts against the mm-stable and vfs-brauner
trees and a semantic conflict against the mm tree.

The kvm-x86 tree gained conflicts against the kvm-riscv tree.

The driver-core tree gained two build failures so I used the version
from next-20230809.

The vhost tree gained a conflict against the net-next tree.

The fsi tree gained a conflict against the char-misc tree.

The nvmem tree gained a build failure so I used the version from
next-20230809.

The iommufd tree gained a semantic conflict against the iommu tree.

Non-merge commits (relative to Linus' tree): 9188
 10533 files changed, 330851 insertions(+), 148406 deletions(-)

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

I am currently merging 366 trees (counting Linus' and 105 trees of bug
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
Merging origin/master (2ccdd1b13c59 Linux 6.5-rc6)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (7a8abf373f29 mm: multi-gen LRU: d=
on't spin during memcg release)
Merging kbuild-current/fixes (6ccbd7fd4746 alpha: remove __init annotation =
from exported page_is_ram())
Merging arc-current/for-curr (4d3696801bad ARC: -Wmissing-prototype warning=
 fixes)
Merging arm-current/fixes (6995e2de6891 Linux 6.4)
Merging arm64-fixes/for-next/fixes (69af56ae56a4 arm64/fpsimd: Sync and zer=
o pad FPSIMD state for streaming SVE)
Merging arm-soc-fixes/arm/fixes (6e6d847a8ce1 soc: aspeed: socinfo: Add kfr=
ee for kstrdup)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (faafd6ca7e6e memory: tegra: make icc_se=
t_bw return zero if BWMGR not supported)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (922a9bd13810 m68k: Fix invalid .section syn=
tax)
Merging powerpc-fixes/fixes (86582e6189dd powerpc/powermac: Use early_* IO =
variants in via_calibrate_decr())
Merging s390-fixes/fixes (388acb471662 s390/ptrace: add missing linux/const=
.h include)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (855067defa36 selftests: mirror_gre_changes: Tighten up th=
e TTL test match)
Merging bpf/master (9ebbb29db9ca Merge branch 'x86/bugs' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/tip/tip)
Merging ipsec/master (f3ec2b5d879e xfrm: don't skip free of empty state in =
acquire policy)
Merging netfilter/main (cc941e548bff net: phy: fix IRQ-based wake-on-lan ov=
er hibernate / power off)
Merging ipvs/main (829c6524d672 net: pcs: Add missing put_device call in mi=
ic_create)
Merging wireless/for-next (06f2ab86a5b6 wifi: ath12k: Fix buffer overflow w=
hen scanning with extraie)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (2ccdd1b13c59 Linux 6.5-rc6)
Merging sound-current/for-linus (7c761166399b ALSA: hda/cs8409: Support new=
 Dell Dolphin Variants)
Merging sound-asoc-fixes/for-linus (8a60e83d19a7 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (52a93d39b17d Linux 6.5-rc5)
Merging regulator-fixes/for-linus (b81f77a4fa88 Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (e5baf3f03be8 Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (cc22522fd55e PCI: acpiphp: Use pci_assign_un=
assigned_bridge_resources() only for non-root bus)
Merging driver-core.current/driver-core-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging tty.current/tty-linus (04c7f60ca477 serial: core: Fix serial core p=
ort id, including multiport devices)
Merging usb.current/usb-linus (2ccdd1b13c59 Linux 6.5-rc6)
Merging usb-serial-fixes/usb-linus (d245aedc0077 USB: serial: simple: sort =
driver entries)
Merging phy/fixes (52a93d39b17d Linux 6.5-rc5)
Merging staging.current/staging-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging iio-fixes/fixes-togreg (34477b2d710a iio: dac: ad3552r: Correct dev=
ice IDs)
Merging counter-current/counter-current (aead78125a98 tools/counter: Makefi=
le: Replace rmdir by rm to avoid make,clean failure)
Merging char-misc.current/char-misc-linus (2ccdd1b13c59 Linux 6.5-rc6)
Merging soundwire-fixes/fixes (52a93d39b17d Linux 6.5-rc5)
Merging thunderbolt-fixes/fixes (2ccdd1b13c59 Linux 6.5-rc6)
Merging input-current/for-linus (eb09074bdb05 Input: i8042 - add quirk for =
TUXEDO Gemini 17 Gen1/Clevo PD70PN)
Merging crypto-current/master (0b7ec177b589 crypto: algif_hash - Fix race b=
etween MORE and non-MORE sends)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (569f8b501b17 selftests/arm64: fix build fail=
ure during the "emit_tests" step)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (422dbc66b770 dmaengine: xilinx: xdma: Fix ty=
po)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c6abce60338a mtd: rawnand: fsl_upm: Fix an off=
-by one test in fun_exec_op())
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (2908042a37b5 media: imx: imx7-media-csi: Fix a=
pplying format constraints)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (6eaae1980760 Linux 6.5-rc3)
Merging at91-fixes/at91-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (d5ad9aae13dc selftests/rseq: Fix build with undef=
ined __weak)
Merging kvms390-fixes/master (c2fceb59bbda KVM: s390: pv: fix index value o=
f replaced ASCE)
Merging hwmon-fixes/hwmon (56b930dcd88c hwmon: (aquacomputer_d5next) Add se=
lective 200ms delay after sending ctrl report)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (ad64f5952ce3 cxl/memdev: Only show sanitize sysfs =
files when supported)
Merging btrfs-fixes/next-fixes (02aff77b978e Merge branch 'misc-6.5' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (2b6aa6610dc9 platform/x86: lenovo-ymc: Onl=
y bind on machines with a convertible DMI chassis-type)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (ffc59c6414f9 dt-bindings: serial: Remove=
 obsolete nxp,lpc1850-uart.txt)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (ef222f551e7c scsi: qedf: Fix firmware halt over s=
uspend and resume)
Merging drm-fixes/drm-fixes (2ccdd1b13c59 Linux 6.5-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (423ffe62c06a drm/i915: fix di=
splay probe for IVB Q and IVB D GT2 server)
Merging mmc-fixes/fixes (cf3f15b8c660 mmc: sunplus: Fix error handling in s=
pmmc_drv_probe())
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (7e3811521dc3 riscv: Implement flush_cache_vmap(=
))
Merging riscv-dt-fixes/riscv-dt-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging gpio-brgl-fixes/gpio/for-current (2fc8d02058db MAINTAINERS: add con=
tent regex for gpio-regmap)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (4da3c7183e18 erofs: drop unnecessary WARN_ON() i=
n erofs_kill_sb())
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (c96e2a695e00 sunrpc: set the bv_offset of fi=
rst bvec in svc_tcp_sendmsg)
Merging irqchip-fixes/irq/irqchip-fixes (6fe5c68ee6a1 irqchip/gic-v3: Worka=
round for GIC-700 erratum 2941627)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (374a7f47bf40 Merge tag '6.5-rc5-ksmbd-serv=
er' of git://git.samba.org/ksmbd)
Merging efi-fixes/urgent (36e4fc57fc16 efi: Bump stub image version for mac=
OS HVF compatibility)
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
Merging v9fs-fixes/fixes/next (e6ab0b914c12 fs/9p: Remove unused extern dec=
laration)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging genpd-fixes/fixes (12acb348fa45 cpuidle: psci: Move enabling OSI mo=
de after power domains creation)
Merging i2c-host-fixes/i2c/andi-for-current (9a5adaf694f5 i2c: hisi: Only h=
andle the interrupt of the driver's transfer)
Merging drm-misc-fixes/for-linux-next-fixes (e8470c0a7bca drm/panel: simple=
: Fix AUO G121EAN01 panel timings according to the docs)
Merging mm-stable/mm-stable (5fb2ea3111f4 powerpc/book3s64/radix: add debug=
 message to give more details of vmemmap allocation)
CONFLICT (content): Merge conflict in arch/parisc/mm/ioremap.c
Merging mm-nonmm-stable/mm-nonmm-stable (290931e2b83c x86/kernel: increase =
kcov coverage under arch/x86/kernel folder)
Merging mm/mm-everything (f8a7ed854c1a Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (45a7371d5be2 docs: kbuild: Document search jump fe=
ature)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (55b290501928 Merge remote-tracking branch 'to=
rvalds/master' into perf-tools-next)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (d069ed288ac7 swiotlb: optimize get_max_slots(=
))
Merging asm-generic/master (cdea694d7616 asm-generic: partially revert "Uni=
fy uapi bitsperlong.h for arm64, riscv and loongarch")
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (a6f307c20d64 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (78a2dc32d20a Merge branches 'for-next/cpufeatu=
re', 'for-next/docs', 'for-next/entry', 'for-next/errata', 'for-next/misc',=
 'for-next/mm', 'for-next/perf' and 'for-next/selftests' into for-next/core)
Merging arm-perf/for-next/perf (ac18ea1a8935 perf/arm-cmn: Add CMN-700 r3 s=
upport)
Merging arm-soc/for-next (eac502461628 soc: document merges)
Merging amlogic/for-next (f590814603bf Merge branch 'v6.6/arm-mach' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (8eb02f6fdd01 ARM: dts: aspeed: bonnell: Add reserv=
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
Merging omap/for-next (ca55cf3d7b52 Merge branch 'omap-for-v6.5/fixes' into=
 for-next)
Merging qcom/for-next (b9a263d90a2c Merge branches 'arm64-defconfig-for-6.6=
', 'arm64-fixes-for-6.5', 'arm64-for-6.6', 'clk-for-6.6', 'drivers-for-6.6'=
 and 'dts-for-6.6' into for-next)
Merging renesas/next (13512fa6af4a Merge branch 'renesas-dts-for-v6.6' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (bcd6a683ddaa Merge branch 'v6.6-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (4124fbc4b4b1 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (45e5b76801e1 Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
CONFLICT (content): Merge conflict in drivers/firmware/arm_scmi/perf.c
Merging stm32/stm32-next (06113b7ac2df ARM: dts: st: Add gpio-ranges for st=
m32f769-pinctrl)
Merging sunxi/sunxi/for-next (aa333f5e8461 Merge branch 'sunxi/dt-for-6.6' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (77a4cfe28fb8 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (d0857dc9b22d Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (7cd073eddcd4 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (bd0f09c12e99 Merge branch 'clk-allwinner' into clk-ne=
xt)
CONFLICT (modify/delete): drivers/clk/qcom/lcc-mdm9615.c deleted in HEAD an=
d modified in clk/clk-next.  Version clk/clk-next of drivers/clk/qcom/lcc-m=
dm9615.c left in tree.
$ git rm -f drivers/clk/qcom/lcc-mdm9615.c
Merging clk-imx/for-next (72d00e560d10 clk: imx: pll14xx: dynamically confi=
gure PLL for 393216000/361267200Hz)
Merging clk-renesas/renesas-clk (dec57795efc4 clk: renesas: r8a77965: Add 3=
DGE and ZG support)
Merging csky/linux-next (c8171a86b274 csky: Fixup -Wmissing-prototypes warn=
ing)
CONFLICT (content): Merge conflict in arch/csky/abiv2/cacheflush.c
Merging loongarch/loongarch-next (5020c5f9d5f7 LoongArch: Add kernel addres=
s sanitizer support)
Merging m68k/for-next (922a9bd13810 m68k: Fix invalid .section syntax)
Merging m68knommu/for-next (7c53e18ee74e m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0e9a2a228a1a microblaze: Explicitly include correc=
t DT includes)
Merging mips/mips-next (f11a99674132 MIPS: Loongson64: Fix more __iomem att=
ributes)
Merging openrisc/for-next (232ba1630c66 openrisc: Make pfn accessors static=
s inlines)
Merging parisc-hd/for-next (7a894c873747 parisc: Fix CONFIG_TLB_PTLOCK to w=
ork with lightweight spinlock checks)
Merging powerpc/next (cd50430ceb35 macintosh/ams: mark ams_init() static)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (174e8ac0272d riscv: alternatives: fix a typo in co=
mment)
Merging riscv-dt/riscv-dt-for-next (f331eb1f5454 riscv: dts: starfive: jh71=
10: Fix GMAC configuration)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (63b9eab21ad8 Merge branch 'features' into for-next)
CONFLICT (content): Merge conflict in arch/s390/Kconfig
Merging sh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (a160e9414d8a xtensa: fix unaligned and load=
/store configuration interaction)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (324718ddddc4 fscrypt: improve the "Encryption mod=
es and usage" section)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (6099857b7d15 Merge branch 'for-next-next-v6.5-20230=
814' into for-next-20230814)
Merging ceph/master (e6e284323079 libceph: fix potential hang in ceph_osdc_=
notify())
Merging cifs/for-next (7b38f6ddc97b smb3: display network namespace in debu=
g information)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (c23df8256b55 erofs: refine warning messages for zdata I/=
Os)
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (70a58515e2ff Merge UDF aops cleanup.)
Merging ext4/dev (9d3de7ee192a ext4: fix rbtree traversal bug in ext4_mb_us=
e_preallocated)
Merging f2fs/dev (0cc81b1ad512 f2fs: should update REQ_TIME for direct writ=
e)
Merging fsverity/for-next (adcb53e3ee05 fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (91ec6c85599b Revert "fuse: in fuse_flush only wait i=
f someone wants the return code")
Merging gfs2/for-next (9f9a7f057f07 gfs2: journal flush threshold fixes and=
 cleanup)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (cdd143e4c508 ksmbd: switch to use kmemdup_nul=
() helper)
Merging nfs/linux-next (5b4a82a0724a Revert "NFSv4: Retry LOCK on OLD_STATE=
ID during delegation return")
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (f5797323270d SUNRPC: Clean up svc_set_num_threads)
CONFLICT (content): Merge conflict in net/sunrpc/svcsock.c
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (adcd459ff805 ovl: validate superblock in =
OVL_FS())
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging xfs/for-next (f6250e205691 xfs: convert flex-array declarations in =
xfs attr shortform objects)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (377698d4abe2 Merge tag 'xfs-async-dio.6-2023-=
08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (72bb0abc3492 locks: fix KASAN: use-after-fre=
e in trace_event_raw_event_filelock_lock)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (24a62491bb89 Merge branch 'vfs.autofs' into vf=
s.all)
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/f2fs/xattr.c
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (b7661f87eda0 Merge branch 'for-6.6' into for-next)
Merging pci/next (b2c47cd73629 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (fe8c3623ab06 pstore/ram: Check start of emp=
ty przs during init)
Merging hid/for-next (c4cc8dab2d33 Merge branch 'for-6.6/steelseries' into =
for-next)
CONFLICT (content): Merge conflict in .mailmap
Merging i2c/i2c/for-next (8ab7725b6bfb Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
CONFLICT (content): Merge conflict in drivers/i2c/busses/i2c-hisi.c
Merging i2c-host/i2c/andi-for-next (7a34bab2daea i2c: synquacer: Use dev_er=
r_probe in probe function)
Merging i3c/i3c/next (300098637900 i3c: master: svc: Do not check for 0 ret=
urn after calling platform_get_irq())
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (fc8df28be715 hwmon: (nsa320-hwmon) Remove=
 redundant of_match_ptr())
Merging jc_docs/docs-next (90cd0c18573a doc: update params of memhp_default=
_state=3D)
Merging v4l-dvb/master (29006e196a56 media: pci: intel: ivsc: Add CSI submo=
dule)
Merging v4l-dvb-next/master (b7ec3212a73a media: bttv: convert to vb2)
Merging pm/linux-next (e8cde28ba512 Merge branch 'pm-tools' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (d3dec5bb61ce cpufreq: amd-pstat=
e-ut: Modify the function to get the highest_perf value)
Merging cpupower/cpupower (99481d2195bf cpupower: Fix cpuidle_set to accept=
 only numeric values for idle-set operation.)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging genpd/next (fe38a2d570df MAINTAINERS: adjust file entry in STARFIVE=
 JH71XX PMU CONTROLLER DRIVER)
Merging opp/opp/linux-next (c2add32ce452 dt-bindings: opp: Increase maxItem=
s for opp-hz property)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (a3d85fcf268e fs: dlm: don't use RCOM_NAMES for version de=
tection)
Merging rdma/for-next (d952f54d01ec RDMA/hns: Remove unused declaration hns=
_roce_modify_srq())
Merging net-next/main (479b322ee6fe net: dsa: mv88e6060: add phylink_get_ca=
ps implementation)
Merging bpf-next/for-next (83a89c4b6ae9 selftests/bpf: Clean up fmod_ret in=
 bench_rename test script)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (2d297d20ace8 RDMA/mlx5: Handles RoCE MACsec st=
eering rules addition and deletion)
CONFLICT (modify/delete): drivers/net/ethernet/mellanox/mlx5/core/en_accel/=
macsec_fs.c deleted in mlx5-next/mlx5-next and modified in HEAD.  Version H=
EAD of drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c left in=
 tree.
CONFLICT (content): Merge conflict in include/linux/mlx5/driver.h
$ git rm -f drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
Applying: fix up for "net/mlx5e: Move MACsec flow steering operations to be=
 used as core library"
Merging netfilter-next/main (b98a5aa7e4c2 Merge branch 'net-remove-redundan=
t-initialization-owner')
Merging ipvs-next/main (b98a5aa7e4c2 Merge branch 'net-remove-redundant-ini=
tialization-owner')
Merging bluetooth/master (b5793de3cfae Bluetooth: hci_conn: avoid checking =
uninitialized CIG/CIS ids)
Merging wireless-next/for-next (81083076a007 Merge tag 'wireless-next-2023-=
08-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-n=
ext)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (264725e35fbc mtd: Clean refcounting with MTD_PARTITIO=
NED_MASTER)
Merging nand/nand/next (3549fecd10d2 mtd: rawnand: vf610_nfc: Do not check =
0 for platform_get_irq())
Merging spi-nor/spi-nor/next (aa517a29d645 mtd: spi-nor: spansion: switch c=
ypress_nor_get_page_size() to use vreg_offset)
Merging crypto/master (91cb1e1432b3 crypto: jitter - Add clarifying comment=
s to Jitter Entropy RCT cutoff values)
Merging drm/drm-next (2b9d7b651522 Merge tag 'drm-intel-next-2023-08-10' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_debug.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n314/dcn314_fpu.c
Merging drm-misc/for-linux-next (f5d8f9c0d8b4 drm/panel: JDI LT070ME05000 s=
implify with dev_err_probe())
Merging amdgpu/drm-next (6be2ad4f0073 drm/amdgpu: don't allow userspace to =
create a doorbell BO)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_device=
_queue_manager.c
Merging drm-intel/for-linux-next (95c23e2085f2 drm/i915/dp: Fix LT debug pr=
int in SDP CRC enable)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d93cf453f51d drm/msm/dpu: fix the irq index in dp=
u_encoder_phys_wb_wait_for_commit_done)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/dpu1/dpu_cor=
e_perf.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/msm_mdss.c
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (87ac8777d424 fbdev: mx3fb: Remove the driver)
CONFLICT (content): Merge conflict in drivers/video/fbdev/Kconfig
CONFLICT (modify/delete): drivers/video/fbdev/mx3fb.c deleted in fbdev/for-=
next and modified in HEAD.  Version HEAD of drivers/video/fbdev/mx3fb.c lef=
t in tree.
$ git rm -f drivers/video/fbdev/mx3fb.c
Merging regmap/for-next (26fc7cfa30d6 Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-next)
Merging sound/for-next (ff7a0b4016cb ALSA: dice: add stream format paramete=
rs for Weiss devices)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (52a3cd64f03b Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (a6846234f458 ARM: module: Use module_init_lay=
out_section() to spot init sections)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (bc1b17592bbd Merge branch 'for-6.6/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/super.c
CONFLICT (content): Merge conflict in lib/raid6/test/Makefile
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (caea958926c3 ata: sata_rcar: Convert to platform r=
emove callback returning void)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (13433b9e2723 mmc: core: Cleanup mmc_sd_num_wr_blocks() fu=
nction)
Merging mfd/for-mfd-next (3d2b5d02738e dt-bindings: mfd: stericsson,db8500-=
prcmu: Add missing unevaluatedProperties for each regulator)
Merging backlight/for-backlight-next (fe1328b5b2a0 backlight: gpio_backligh=
t: Drop output GPIO direction check for initial power state)
Merging battery/for-next (7e6311f04b41 power: supply: qcom_pmi8998_charger:=
 fix charger status)
Merging regulator/for-next (4483b65be2c2 Merge remote-tracking branch 'regu=
lator/for-6.6' into regulator-next)
Merging security/next (6672efbb685f lsm: constify the 'target' parameter in=
 security_capget())
CONFLICT (content): Merge conflict in security/security.c
Merging apparmor/apparmor-next (efea5b0dcc43 apparmor: remove unused PROF_*=
 macros)
Merging integrity/next-integrity (55e2b69649be kexec_lock: Replace kexec_mu=
tex() by kexec_lock() in two comments)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (e49be9bc7c1b selinux: use unsigned iterator in nlmsgt=
ab code)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (254a8ed6aab3 tomoyo: remove unused function declarat=
ion)
Merging tpmdd/next (2ccdd1b13c59 Linux 6.5-rc6)
Merging watchdog/master (8a504bd61ec7 watchdog: starfive: Remove #ifdef gua=
rds for PM related functions)
Merging iommu/next (b2b57855813d Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/renesas', 'arm/rockchip', 'unisoc', 'x86/vt-d', 'x86/amd' and 'core=
' into next)
Merging audit/next (b59bc6e37237 audit: fix possible soft lockup in __audit=
_inode_child())
Merging devicetree/for-next (2b9583244aad of: unittest: Remove redundant of=
_match_ptr())
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (a9ca0d5d5006 Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (855484a68d16 Merge x86/microcode into tip/master)
CONFLICT (content): Merge conflict in arch/s390/Kconfig
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
Applying: fix up for "mm: Make pte_mkwrite() take a VMA"
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (ce53ad81ed36 EDAC/igen6: Fix the issue of no er=
ror events)
Merging irqchip/irq/irqchip-next (a82f3119d543 Merge branch irq/misc-6.5 in=
to irq/irqchip-next)
Merging ftrace/for-next (7c1130ea5cae test: ftrace: Fix kprobe test for eve=
ntfs)
Merging rcu/rcu/next (13e3e81ac928 rcu-tasks: Fix boot-time RCU tasks debug=
-only deadlock)
Merging kvm/next (d5ad9aae13dc selftests/rseq: Fix build with undefined __w=
eak)
Merging kvm-arm/next (3b4e3afb2032 Merge branch kvm-arm64/6.6/misc into kvm=
arm-master/next)
Merging kvms390/next (b275d8313217 KVM: s390: selftests: Add selftest for s=
ingle-stepping)
Merging kvm-riscv/riscv_kvm_next (477069398ed6 KVM: riscv: selftests: Add g=
et-reg-list test)
Merging kvm-x86/next (240f73689188 Merge branch 'misc')
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/include/t=
est_util.h
Merging xen-tip/linux-next (c04e9894846c xen: speed up grant-table reclaim)
Merging percpu/for-next (abf773b6fafc Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (c076af902bdf Merge branch 'for-6.6' into for-n=
ext)
Merging drivers-x86/for-next (65c6ea33e7f6 Merge remote-tracking branch 'pd=
x86/platform-drivers-x86-simatic-ipc' into review-hans)
CONFLICT (content): Merge conflict in drivers/watchdog/Kconfig
Merging chrome-platform/for-next (0820debb7d48 platform/chrome: chromeos_ac=
pi: print hex string for ACPI_TYPE_BUFFER)
Merging chrome-platform-firmware/for-firmware-next (0979e7e3cfd7 MAINTAINER=
S: Add drivers/firmware/google/ entry)
Merging hsi/for-next (7ebf243a2018 hsi: omap_ssi: Explicitly include correc=
t DT includes)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (841165267827 leds: qcom-lpg: Drop assignment=
 to struct pwmchip::base)
Applying: Revert "leds: pca995x: Add support for PCA995X chips"
Merging ipmi/for-next (b02bb79eee07 ipmi: fix potential deadlock on &kcs_bm=
c->lock)
Merging driver-core/driver-core-next (699fb50d9903 drivers: base: Free devm=
 resources when unregistering a device)
$ git reset --hard HEAD^
Merging next-20230809 version of driver-core
Merging usb/usb-next (bbb9e06d2c64 Merge 6.5-rc6 into usb-next)
Merging thunderbolt/next (a3f6445842e5 Documentation/ABI: thunderbolt: Repl=
ace 01.org in contact)
Merging usb-serial/usb-next (974e2f6a0554 USB: serial: xr: add TIOCGRS485 a=
nd TIOCSRS485 ioctls)
Merging tty/tty-next (e67d7f60d238 tty: gdm724x: simplify gdm_tty_write())
CONFLICT (content): Merge conflict in arch/powerpc/platforms/8xx/mpc885ads_=
setup.c
CONFLICT (content): Merge conflict in arch/powerpc/platforms/8xx/tqm8xx_set=
up.c
CONFLICT (content): Merge conflict in arch/powerpc/sysdev/fsl_soc.c
Merging char-misc/char-misc-next (e75850b4573a Merge 6.5-rc6 into char-misc=
-next)
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (484281bd5b98 hwtracing: hisi_ptt: Use pci_dev_id() =
to simplify the code)
Merging fastrpc/for-next (64227235abd9 misc: fastrpc: Pass proper scm argum=
ents for static process init)
Merging fpga/for-next (1a22ec09a2c1 fpga: region: make fpga_region_class a =
static const structure)
Merging icc/icc-next (768c42cd9acb Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (14b7447cec15 Documentation: ABI: testing: admv8818: add=
 bypass)
Merging phy-next/next (7451eecf1ef8 phy: marvell pxa-usb: fix Wvoid-pointer=
-to-enum-cast warning)
Merging soundwire/next (e66f91a2d10b soundwire: intel_auxdevice: add hybrid=
 IDA-based device_number allocation)
Merging extcon/extcon-next (d20a3a8a32e3 extcon: cht_wc: add POWER_SUPPLY d=
ependency)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (73e2f19da508 kvm/vfio: avoid bouncing the mutex when add=
ing and deleting groups)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (656ae4f48a6f staging: fieldbus: arcx-anybus: =
Remove redundant of_match_ptr())
Merging counter-next/counter-next (71ab2f343f1f counter: rz-mtu3-cnt: Reord=
er locking sequence for consistency)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (0f264ab788ed dt-bindings: dmaengine: at_xdmac: add =
compatible with microchip,sam9x7)
Merging cgroup/for-next (82b90b6c5b38 cgroup:namespace: Remove unused cgrou=
p_namespaces_init())
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/.gitig=
nore
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/Makefi=
le
Applying: Revert "cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHE=
D"
Merging scsi/for-next (7da4622a53ea Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (a18e81d17a7e scsi: ufs: ufs-pci: Add support for=
 QEMU)
Merging vhost/linux-next (1a08d66726dc virtio_net: merge dma operations whe=
n filling mergeable buffers)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (af2010496de7 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (a40fe1ffb69b gpio: sim: simplify gpio_sim_=
device_config_live_store())
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (dfe014e7b5bc Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-renesas/renesas-pinctrl (95eb19869401 pinctrl: renesas: rzg=
2l: Use devm_clk_get_enabled() helper)
Merging pinctrl-samsung/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pwm/for-next (3ccb179aa40d pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (2b2fe6052dd0 selftests/rseq: Use rseq_unqual_scalar=
_typeof in macros)
Merging kunit/test (06c2afb862f9 Linux 6.5-rc1)
Merging kunit-next/kunit (582eb3aeed2d kunit: replace KUNIT_TRIGGER_STATIC_=
STUB maro with KUNIT_STATIC_STUB_REDIRECT)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (4f3688dca150 rtc: remove redundant of_match_ptr())
Merging nvdimm/libnvdimm-for-next (feb72e9b2082 nvdimm/pfn_dev: Avoid unnec=
essary endian conversion)
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (994def29acc5 ntb: Remove error checking for debugfs_c=
reate_dir())
Merging seccomp/for-next/seccomp (fbc5d382407e selftests/seccomp: Handle ar=
m32 corner cases better)
Merging fsi/next (f432b1cf7820 fsi: fix some spelling mistakes in comment)
CONFLICT (content): Merge conflict in drivers/fsi/fsi-core.c
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (0e4a8e9e49ea nvmem: core: Notify when a new layout =
is registered)
$ git reset --hard HEAD^
Merging next-20230809 version of nvmem
Merging xarray/main (cbc02854331e XArray: Do not return sibling entries fro=
m xa_load())
Merging hyperv/hyperv-next (5d0c230f1de8 Linux 6.5-rc4)
Merging auxdisplay/auxdisplay (def85dce1451 auxdisplay: Switch i2c drivers =
back to use .probe())
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
Merging efi/next (f6e6e95ce162 efi/riscv: libstub: Fix comment about absolu=
te relocation)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (66489e5487b7 Merge branch 'slab/for-6.6/random_kmall=
oc' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (35ca42399297 selftests/landlock: Add hostfs tests)
Merging rust/rust-next (08ab786556ff rust: bindgen: upgrade to 0.65.1)
Merging sysctl/sysctl-next (d6ea45102f22 sysctl: Use ctl_table_size as stop=
ping criteria for list macro)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (5b914afcd166 bitmap: Fix a typo ("identify =
map"))
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (429e2140a119 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (06c2afb862f9 Linux 6.5-rc1)
Merging iommufd/for-next (23a1b46f15d5 iommufd/selftest: Make the mock iomm=
u driver into a real driver)
CONFLICT (content): Merge conflict in drivers/iommu/iommufd/device.c
Applying: fix for "iommufd: Move putting a hwpt to a helper function"
Applying: fix up for "iommufd/selftest: Make the mock iommu driver into a r=
eal driver"

--Sig_/4IX_r1Rm.hI=tj.WUfswG92
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbZYIACgkQAVBC80lX
0GzM6Qf/b/LmL7nzh3PSIyqeEKfU2My+mCXMeisTn+vEbShoFOCh353VhmSt0dd0
DYMvp8cFZL1bsmxeNDGRB8IEyo2R9rIHp2tm1THB3bSbs0NW8/7HKa7aNeZ3bXwY
+JqXGZvMyDR4cle8+Ab4vVsnkbzLIvvGJCYec84HiQY5SQgWiY9+r24sTWvg7qZd
v3u/Wvumw0ikR2VdtLPHAIk5zbruZ3ZcqQbh+j5CjjcA5uYK2s/Oj2Vs7iPaRvXH
8ejRt+80Xidu4vGuR3felbPyeUiZMGjYbLCcDiIdQ9aB9jBXWBToDzaBO0fMoSRv
P+a3q0j33H02qIiW8+WCqNHTUTIdGw==
=2VYA
-----END PGP SIGNATURE-----

--Sig_/4IX_r1Rm.hI=tj.WUfswG92--
