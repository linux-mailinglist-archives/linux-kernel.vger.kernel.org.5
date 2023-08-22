Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF6783B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjHVICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjHVIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:01:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B331A2;
        Tue, 22 Aug 2023 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692691280;
        bh=P03J4tbqvsBDchGbnLZm740f9Qs+h1g0QYZGS5J8U/A=;
        h=Date:From:To:Cc:Subject:From;
        b=P1mh81gUP+9hGn7QZdUplPRlTzWiysGTZfLahUP7xyqYibY+SOVxvHk3j3Q/mmOZh
         ADRjMhhZ5N4D6CXYMs35P3ZWbbd4zqzVW3x4rLACo5EpFgtvyjSuIxc5zHJdgKMCDS
         80PaZdbMCi9bNDx7QeLrvNnLNX+Smyf8qxQAXAdDVUqJnQfXKdv6ZNwTfMKuncX5MV
         m7KVM+Jcc3hbyz+lH6BkmGSD/oWyg3oZJ/RhQPxGBWPgiW83aFz2R/gUfNybpSaRut
         FeazdpGYAy0Vi27Jy0yj4qKDSJeqC3qNnoRcadcsK8DjNYk7eexpm0nHySPByrCRGV
         H14gYJh0/yF2Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVMHN4HXZz4wZs;
        Tue, 22 Aug 2023 18:01:20 +1000 (AEST)
Date:   Tue, 22 Aug 2023 18:01:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 22
Message-ID: <20230822180117.321a83f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_8jYPeoYD2t6TaVlXCOwAXt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_8jYPeoYD2t6TaVlXCOwAXt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230821:

The mm-stable tree gained a conflict against the arc-current tree.

The mm tree gained a build failure for which I reverted a commit.

The powerpc tree gained a conflict against the mm-stable tree.

The vfs-brauner tree gained a conflict against the djw-vfs tree.

The nand tree lost its build failure.

The block tree gained a conflict against the djw-vfs, vfs-brauner trees.

The phy-next tree still had its build failure so I used the version
from next-20230817.

The dmaengine tree gained a conflict against Linus' tree.

The scsi-mkp tree gained a build failure so I used the version from
next-20230821.

The nvmem tree still had its build failure so I used the version from
next-20230809.

The efi tree gained a build failure so I used the version from
next-20230821.

The rust tree gained a conflict against the kunit-next tree.

Non-merge commits (relative to Linus' tree): 10732
 12162 files changed, 509544 insertions(+), 181316 deletions(-)

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

I am currently merging 364 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (f7757129e3de Merge tag 'v6.5-p3' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (395794d4780e maple_tree: disable =
mas_wr_append() when other readers are possible)
Merging kbuild-current/fixes (6ccbd7fd4746 alpha: remove __init annotation =
from exported page_is_ram())
Merging arc-current/for-curr (58d9ceb7d9f5 ARC: pt_regs: create seperate ty=
pe for ecr)
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
Merging m68k-current/for-linus (922a9bd13810 m68k: Fix invalid .section syn=
tax)
Merging powerpc-fixes/fixes (4f3175979e62 powerpc/rtas_flash: allow user co=
py to flash block cache objects)
Merging s390-fixes/fixes (388acb471662 s390/ptrace: add missing linux/const=
.h include)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (d1cdbf66e18c MAINTAINERS: add entry for macsec)
Merging bpf/master (23d775f12dcd net: dsa: mv88e6xxx: Wait for EEPROM done =
before HW reset)
Merging ipsec/master (f3ec2b5d879e xfrm: don't skip free of empty state in =
acquire policy)
Merging netfilter/main (820a38d8f2cb Merge branch '40GbE' of git://git.kern=
el.org/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging ipvs/main (820a38d8f2cb Merge branch '40GbE' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging wireless/for-next (b98c16107cc1 wifi: mac80211: limit reorder_buf_f=
iltered to avoid UBSAN warning)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (2ccdd1b13c59 Linux 6.5-rc6)
Merging sound-current/for-linus (46cdff2369cb ALSA: hda/realtek - Remodifie=
d 3k pull low procedure)
Merging sound-asoc-fixes/for-linus (4206719a3d18 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (52a93d39b17d Linux 6.5-rc5)
Merging regulator-fixes/for-linus (d989e498295b Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (1f8fe2939440 Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (cc22522fd55e PCI: acpiphp: Use pci_assign_un=
assigned_bridge_resources() only for non-root bus)
Merging driver-core.current/driver-core-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging tty.current/tty-linus (b320441c04c9 Merge tag 'tty-6.5-rc7' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty)
Merging usb.current/usb-linus (2ccdd1b13c59 Linux 6.5-rc6)
Merging usb-serial-fixes/usb-linus (d245aedc0077 USB: serial: simple: sort =
driver entries)
Merging phy/fixes (52a93d39b17d Linux 6.5-rc5)
Merging staging.current/staging-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging iio-fixes/fixes-togreg (34477b2d710a iio: dac: ad3552r: Correct dev=
ice IDs)
Merging counter-current/counter-current (2ccdd1b13c59 Linux 6.5-rc6)
Merging char-misc.current/char-misc-linus (2ccdd1b13c59 Linux 6.5-rc6)
Merging soundwire-fixes/fixes (52a93d39b17d Linux 6.5-rc5)
Merging thunderbolt-fixes/fixes (2ccdd1b13c59 Linux 6.5-rc6)
Merging input-current/for-linus (eb09074bdb05 Input: i8042 - add quirk for =
TUXEDO Gemini 17 Gen1/Clevo PD70PN)
Merging crypto-current/master (080aa61e370b crypto: fix uninit-value in af_=
alg_free_resources)
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
Merging drivers-x86-fixes/fixes (20feb0c1aab8 platform/mellanox: Fix mlxbf-=
tmfifo not handling all virtio CONSOLE notifications)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (7882541ca06d of/platform: increase refco=
unt of fwnode)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (c422fbd5cb58 scsi: ufs: ufs-qcom: Clear qunipro_g=
4_sel for HW major version > 5)
Merging drm-fixes/drm-fixes (706a74159504 Linux 6.5-rc7)
Merging drm-intel-fixes/for-linux-next-fixes (706a74159504 Linux 6.5-rc7)
Merging mmc-fixes/fixes (58abdd80b93b mmc: f-sdh30: fix order of function c=
alls in sdhci_f_sdh30_remove)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (ca09f772ccca riscv: Handle zicsr/zifencei issue=
 between gcc and binutils)
Merging riscv-dt-fixes/riscv-dt-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging gpio-brgl-fixes/gpio/for-current (706a74159504 Linux 6.5-rc7)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (4da3c7183e18 erofs: drop unnecessary WARN_ON() i=
n erofs_kill_sb())
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (706a74159504 Linux 6.5-rc7)
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
Merging drm-misc-fixes/for-linux-next-fixes (f19df6e4de64 drm/panfrost: Ski=
p speed binning on EOPNOTSUPP)
Merging mm-stable/mm-stable (a644b0abbfe1 mm: convert split_huge_pages_pid(=
) to use a folio)
CONFLICT (content): Merge conflict in arch/arc/Kconfig
CONFLICT (content): Merge conflict in arch/parisc/mm/ioremap.c
Merging mm-nonmm-stable/mm-nonmm-stable (3d0b71398490 kstrtox: consistently=
 use _tolower())
Merging mm/mm-everything (359c8e0f06a2 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Applying: Revert "mm: remove enum page_entry_size"
Merging kbuild/for-next (bd964ab4f21f MAINTAINERS: Add usr/ (initramfs gene=
ration) to KBUILD)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (64917f4df048 perf trace: Use heuristic when d=
eciding if a syscall tracepoint "const char *" field is really a string)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (d069ed288ac7 swiotlb: optimize get_max_slots(=
))
Merging asm-generic/master (6e8d96909a23 asm-generic: partially revert "Uni=
fy uapi bitsperlong.h for arm64, riscv and loongarch")
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (05652576a762 Merge branches 'for-next/cpufeatu=
re', 'for-next/docs', 'for-next/entry', 'for-next/errata', 'for-next/misc',=
 'for-next/mm', 'for-next/perf' and 'for-next/selftests' into for-next/core)
Merging arm-perf/for-next/perf (1aa3d0274a4a arm_pmu: acpi: Add a represent=
ative platform device for TRBE)
Merging arm-soc/for-next (9ca4a7768615 Merge branch 'arm/fixes' into for-ne=
xt)
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
Merging stm32/stm32-next (0b5198b3421d ARM: multi_v7_defconfig: Add SCMI re=
gulator support)
Merging sunxi/sunxi/for-next (aa333f5e8461 Merge branch 'sunxi/dt-for-6.6' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (4451dac4c4a5 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (d0857dc9b22d Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (7cd073eddcd4 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (bd0f6c57c2b3 Merge branch 'clk-allwinner' into clk-ne=
xt)
CONFLICT (modify/delete): drivers/clk/qcom/lcc-mdm9615.c deleted in HEAD an=
d modified in clk/clk-next.  Version clk/clk-next of drivers/clk/qcom/lcc-m=
dm9615.c left in tree.
$ git rm -f drivers/clk/qcom/lcc-mdm9615.c
Merging clk-imx/for-next (72d00e560d10 clk: imx: pll14xx: dynamically confi=
gure PLL for 393216000/361267200Hz)
Merging clk-renesas/renesas-clk (708cb698ffa2 clk: renesas: rcar-gen3: Add =
ADG clocks)
Merging csky/linux-next (c8171a86b274 csky: Fixup -Wmissing-prototypes warn=
ing)
CONFLICT (content): Merge conflict in arch/csky/abiv2/cacheflush.c
Merging loongarch/loongarch-next (5020c5f9d5f7 LoongArch: Add kernel addres=
s sanitizer support)
Merging m68k/for-next (eb1e6ccdcf78 zorro: Include zorro.h in names.c)
Merging m68knommu/for-next (cf18ecd34f71 m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0e9a2a228a1a microblaze: Explicitly include correc=
t DT includes)
Merging mips/mips-next (ed07f6c26f9c Mips: loongson3_defconfig: Enable ast =
drm driver by default)
Merging openrisc/for-next (232ba1630c66 openrisc: Make pfn accessors static=
s inlines)
Merging parisc-hd/for-next (557fefd16958 parisc: Avoid ioremap() for same a=
ddresss in iosapic_register())
Merging powerpc/next (0f71dcfb4aef powerpc/ftrace: Add support for -fpatcha=
ble-function-entry)
CONFLICT (content): Merge conflict in arch/powerpc/Kconfig
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (174e8ac0272d riscv: alternatives: fix a typo in co=
mment)
Merging riscv-dt/riscv-dt-for-next (a3ce3ff28385 riscv: dts: change TH1520 =
files to dual license)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (48c9fdfa55dd Merge branch 'vfio-ap' into for-next)
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
Merging btrfs/for-next (8a757010644f Merge branch 'for-next-next-v6.5-20230=
821' into for-next-20230821)
Merging ceph/master (e6e284323079 libceph: fix potential hang in ceph_osdc_=
notify())
Merging cifs/for-next (264193aae7e9 fs/jfs: Use common ucs2 upper case tabl=
e)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (6e5dbf9c5d28 erofs: don't warn dedupe and fragments feat=
ures anymore)
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (f2023a603f74 Pull ext2 kerneldoc fixes from Matthew.)
Merging ext4/dev (9744b58f04b7 ext4: drop dio overwrite only flag and assoc=
iated warning)
Merging f2fs/dev (5c13e2388bf3 f2fs: avoid false alarm of circular locking)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (7d875e66859a fuse: invalidate dentry on EEXIST creat=
es or ENOENT deletes)
Merging gfs2/for-next (f38991711041 gfs2: prevent gfs2_logd from spinning)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (7089235ab14e ksmbd: fix `force create mode' a=
nd `force directory mode')
Merging nfs/linux-next (895cedc17919 xprtrdma: Remap Receive buffers after =
a reconnect)
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (25e11eec116a SUNRPC: Remove unused declarations)
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
Merging vfs-brauner/vfs.all (23073948e247 Merge branch 'vfs.fs_context' int=
o vfs.all)
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/ext4/super.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/f2fs/xattr.c
CONFLICT (content): Merge conflict in fs/super.c
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (cb65d08d735e Merge branch 'for-6.6' into for-next)
Merging pci/next (3f7f17a73c37 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (af58740d8b06 pstore: Fix kernel-doc warning)
Merging hid/for-next (4efade20f50c Merge branch 'for-6.6/elan' into for-nex=
t)
CONFLICT (content): Merge conflict in .mailmap
Merging i2c/i2c/for-next (8ab7725b6bfb Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (300098637900 i3c: master: svc: Do not check for 0 ret=
urn after calling platform_get_irq())
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (e7593bda6a2e hwmon: pmbus: Fix -EIO seen =
on pli1209)
Merging jc_docs/docs-next (21b25bd111be docs/zh_CN: correct regi_chg(),regi=
_add() to region_chg(),region_add())
Merging v4l-dvb/master (b7ec3212a73a media: bttv: convert to vb2)
Merging v4l-dvb-next/master (8ba283f6c929 media: v4l: Use correct dependenc=
y for camera sensor drivers)
Merging pm/linux-next (abb51b0e3f33 Merge branch 'pm-devfreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (e613d8cff547 cpufreq: cppc: Set=
 fie_disabled to FIE_DISABLED if fails to create kworker_fie)
Merging cpupower/cpupower (af75504c3896 cpupower: Add Georgian translation =
to Makefile LANGUAGES)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging genpd/next (4f6c9832613b genpd: imx: scu-pd: initialize is_off acco=
rding to HW state)
Merging opp/opp/linux-next (e576a9a8603f dt-bindings: cpufreq: Convert ti-c=
pufreq to json schema)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (a3d85fcf268e fs: dlm: don't use RCOM_NAMES for version de=
tection)
Merging rdma/for-next (bb6d73d9add6 RDMA/irdma: Prevent zero-length STAG re=
gistration)
Merging net-next/main (7eb6deb3f556 Revert "pds_core: Fix some kernel-doc c=
omments")
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fs_ene=
t/fs_enet.h
CONFLICT (content): Merge conflict in include/net/inet_sock.h
Merging bpf-next/for-next (d56518380085 Merge branch 'bpf-add-multi-uprobe-=
link')
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (58dbd6428a68 RDMA/mlx5: Handles RoCE MACsec st=
eering rules addition and deletion)
CONFLICT (modify/delete): drivers/net/ethernet/mellanox/mlx5/core/en_accel/=
macsec_fs.c deleted in mlx5-next/mlx5-next and modified in HEAD.  Version H=
EAD of drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c left in=
 tree.
CONFLICT (content): Merge conflict in include/linux/mlx5/driver.h
$ git rm -f drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
Applying: fix up for "net/mlx5e: Move MACsec flow steering operations to be=
 used as core library"
Merging netfilter-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-c=
ompile-time-configuration')
Merging ipvs-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-compil=
e-time-configuration')
Merging bluetooth/master (1d7b78b23888 Bluetooth: ISO: Add support for peri=
odic adv reports processing)
Merging wireless-next/for-next (f585f4ab0b99 wifi: rtw89: regd: update regu=
latory map to R64-R43)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (000412e4bb7e mtd: spear_smi: Use helper function devm=
_clk_get_enabled())
Merging nand/nand/next (2c11ea7bee31 mtd: rawnand: orion: Use helper functi=
on devm_clk_get_optional_enabled())
CONFLICT (content): Merge conflict in drivers/mtd/nand/raw/qcom_nandc.c
Merging spi-nor/spi-nor/next (69d50d0461a1 mtd: spi-nor: nxp-spifi: Use hel=
per function devm_clk_get_enabled())
Merging crypto/master (5ce0bc68e0ee crypto: engine - Remove crypto_engine_c=
tx)
Merging drm/drm-next (cacaeb27ade4 Merge tag 'amd-drm-next-6.6-2023-08-18' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
  ef35c7ba6041 ("Revert "Revert "drm/amdgpu/display: change pipe policy for=
 DCN 2.0""")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfxhub_v1_=
2.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_debug.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_device=
_queue_manager.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n314/dcn314_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
Merging drm-misc/for-linux-next (ff065eaf5502 drm/ttm/tests: Require MMU wh=
en testing)
Merging amdgpu/drm-next (38518054183f drm/amdgpu: Fix the return for gpu mo=
de1_reset)
Merging drm-intel/for-linux-next (cacaeb27ade4 Merge tag 'amd-drm-next-6.6-=
2023-08-18' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (34b149ecae85 drm/msm/a6xx: Bail out early if sett=
ing GPU OOB fails)
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (2ccdd1b13c59 Linux 6.5-rc6)
Merging regmap/for-next (26fc7cfa30d6 Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-next)
Merging sound/for-next (17a1eab7b70d ALSA: hda/tas2781: Fix PM refcount unb=
alance at tas2781_hda_bind())
CONFLICT (content): Merge conflict in sound/soc/codecs/cs35l56.c
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (e69dadf638e6 Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (a6846234f458 ARM: module: Use module_init_lay=
out_section() to spot init sections)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (c8cf0a99e7d8 Merge branch 'for-6.6/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/super.c
CONFLICT (content): Merge conflict in lib/raid6/test/Makefile
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (0e1bd497ca37 ata: pata_imx: Use helper function de=
vm_clk_get_enabled())
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (5ae4b0d8875c mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR=
010450)
Merging mfd/for-mfd-next (09ae9adeda9e mfd: rz-mtu3: Replace raw_spin_lock-=
>spin_lock())
Merging backlight/for-backlight-next (dfd122fe8591 backlight: lp855x: Drop =
ret variable in brightness change function)
Merging battery/for-next (7e6311f04b41 power: supply: qcom_pmi8998_charger:=
 fix charger status)
CONFLICT (content): Merge conflict in drivers/power/supply/rt5033_charger.c
Applying: fixup for "power: Explicitly include correct DT includes"
Merging regulator/for-next (d0557612e887 Merge remote-tracking branch 'regu=
lator/for-6.6' into regulator-next)
Merging security/next (8e4672d6f902 lsm: constify the 'file' parameter in s=
ecurity_binder_transfer_file())
CONFLICT (content): Merge conflict in security/security.c
Merging apparmor/apparmor-next (efea5b0dcc43 apparmor: remove unused PROF_*=
 macros)
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
Merging tpmdd/next (218a2680624c certs: Reference revocation list for all k=
eyrings)
Merging watchdog/master (266da53c35fc watchdog: sama5d4: readout initial st=
ate)
Merging iommu/next (d8fe59f11096 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
Merging audit/next (b1a0f64cc65e audit: move trailing statements to next li=
ne)
Merging devicetree/for-next (7ceb60ece856 dt-bindings: pps: pps-gpio: Conve=
rt to yaml)
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (52d3c16f130e Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (b7f14d10ea96 Merge branch into tip/master: 'x86/sev')
CONFLICT (content): Merge conflict in arch/s390/Kconfig
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
Applying: fix up for "mm: Make pte_mkwrite() take a VMA"
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (ce53ad81ed36 EDAC/igen6: Fix the issue of no er=
ror events)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (7c1130ea5cae test: ftrace: Fix kprobe test for eve=
ntfs)
Merging rcu/rcu/next (94e70d269433 Merge branch 'csd-lock.2023.07.14b' into=
 HEAD)
Merging kvm/next (d5ad9aae13dc selftests/rseq: Fix build with undefined __w=
eak)
Merging kvm-arm/next (01f5d0506e6d Merge branch kvm-arm64/6.6/pmu-fixes int=
o kvmarm-master/next)
Merging kvms390/next (b1d8b21681db KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-riscv/riscv_kvm_next (477069398ed6 KVM: riscv: selftests: Add g=
et-reg-list test)
Merging kvm-x86/next (fff2e47e6c3b Merge branch 'misc')
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/include/t=
est_util.h
Merging xen-tip/linux-next (187b4c0d34e3 xen: Fix one kernel-doc comment)
Merging percpu/for-next (abf773b6fafc Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (c076af902bdf Merge branch 'for-6.6' into for-n=
ext)
Merging drivers-x86/for-next (65c6ea33e7f6 Merge remote-tracking branch 'pd=
x86/platform-drivers-x86-simatic-ipc' into review-hans)
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
Merging driver-core/driver-core-next (f7bb242601de drivers: base: test: Add=
 missing MODULE_* macros to root device tests)
Merging usb/usb-next (bbb9e06d2c64 Merge 6.5-rc6 into usb-next)
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
Merging usb-serial/usb-next (974e2f6a0554 USB: serial: xr: add TIOCGRS485 a=
nd TIOCSRS485 ioctls)
Merging tty/tty-next (642073c306e6 Merge commit b320441c04c9 ("Merge tag 't=
ty-6.5-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty") i=
nto tty-next)
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/fs_pd.h
CONFLICT (content): Merge conflict in arch/powerpc/platforms/8xx/mpc885ads_=
setup.c
CONFLICT (content): Merge conflict in arch/powerpc/platforms/8xx/tqm8xx_set=
up.c
CONFLICT (content): Merge conflict in arch/powerpc/sysdev/fsl_soc.c
Merging char-misc/char-misc-next (e75850b4573a Merge 6.5-rc6 into char-misc=
-next)
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
Merging icc/icc-next (e0d855b5761d Merge branch 'icc-enable-mask' into icc-=
next)
Merging iio/togreg (14b7447cec15 Documentation: ABI: testing: admv8818: add=
 bypass)
Merging phy-next/next (a11ecceaf41d phy: fsl-imx8mq-usb: add dev_err_probe =
if getting vbus failed)
$ git reset --hard HEAD^
Merging next-20230817 version of phy-next
Merging soundwire/next (e66f91a2d10b soundwire: intel_auxdevice: add hybrid=
 IDA-based device_number allocation)
Merging extcon/extcon-next (d20a3a8a32e3 extcon: cht_wc: add POWER_SUPPLY d=
ependency)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (2d12d18f14d9 vfio/pds: fix return value in pds_vfio_get_=
lm_file())
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (656ae4f48a6f staging: fieldbus: arcx-anybus: =
Remove redundant of_match_ptr())
Merging counter-next/counter-next (39266b642ccd counter: rz-mtu3-cnt: Reord=
er locking sequence for consistency)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (8cae66574398 dmaengine: idxd: Fix issues with PRS d=
isable sysfs knob)
CONFLICT (content): Merge conflict in drivers/dma/mcf-edma.c
Merging cgroup/for-next (78d44b824ed0 cgroup: Avoid -Wstringop-overflow war=
nings)
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/.gitig=
nore
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/Makefi=
le
Applying: Revert "cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHE=
D"
Merging scsi/for-next (7da4622a53ea Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (091462cb57e4 Merge patch series "libsas: Some ti=
dy-up")
$ git reset --hard HEAD^
Merging next-20230821 version of scsi-mkp
Merging vhost/linux-next (1a08d66726dc virtio_net: merge dma operations whe=
n filling mergeable buffers)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (569e93d37475 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (91043f559313 gpio: cdev: wake up lineevent=
 poll() on device unbind)
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (647bef49feb3 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (83f7586f3b36 pinctrl: tegra: Switch to use =
DEFINE_NOIRQ_DEV_PM_OPS() helper)
Merging pinctrl-renesas/renesas-pinctrl (3a629cf4f0e6 Merge tag 'renesas-pi=
nctrl-fixes-for-v6.5-tag2' into renesas-pinctrl)
Merging pinctrl-samsung/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pwm/for-next (3ccb179aa40d pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (13eb52f6293d selftests: cachestat: test for cachest=
at availability)
Merging kunit/test (06c2afb862f9 Linux 6.5-rc1)
Merging kunit-next/kunit (25e324bc9cf2 kunit: fix struct kunit_attr header)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (dac783784848 rtc: tps65910: Remove redundant dev_warn=
() and do not check for 0 return after calling platform_get_irq())
Merging nvdimm/libnvdimm-for-next (08ca6906a4b7 nvdimm: Fix dereference aft=
er free in register_nvdimm_pmu())
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (da1a091db061 ntb: check tx descriptors outstanding in=
stead of head/tail for tx queue)
Merging seccomp/for-next/seccomp (46822860a5a9 seccomp: Add missing kerndoc=
 notations)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (0e4a8e9e49ea nvmem: core: Notify when a new layout =
is registered)
$ git reset --hard HEAD^
Merging next-20230809 version of nvmem
Merging xarray/main (cbc02854331e XArray: Do not return sibling entries fro=
m xa_load())
Merging hyperv/hyperv-next (bb9b0e46b84c hv: hyperv.h: Replace one-element =
array with flexible-array member)
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
Merging efi/next (61f6c7a3228c efi/runtime-wrappers: Clean up white space a=
nd add __init annotation)
$ git reset --hard HEAD^
Merging next-20230821 version of efi
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
Merging bitmap/bitmap-for-next (5b914afcd166 bitmap: Fix a typo ("identify =
map"))
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (2ddd3cac1fa9 nsproxy: Convert nsproxy.count to =
refcount_t)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (938315d721db tools/nolibc: avoid undesired casts in =
the __sysret() macro)
CONFLICT (content): Merge conflict in tools/include/nolibc/stdio.h
CONFLICT (content): Merge conflict in tools/testing/selftests/nolibc/nolibc=
-test.c
Merging iommufd/for-next (eb501c2d96cf iommufd/selftest: Don't leak the pla=
tform device memory when unloading the module)

--Sig_/_8jYPeoYD2t6TaVlXCOwAXt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTka00ACgkQAVBC80lX
0Gy8xwf9FW/5PIIMCsL1W98LLny6zJS6CyqmIAvFSTO/1nAbbK6iSOOsNhY5Bjir
6ydq1keySKzjgRLhsF1h4ATRGM+m9AEMTWTLJIyeixRd68eablZ2WRprzSF8QkaW
XsoOIL8lBmJLLkBc7U0efqxKFSa3QH8jcv0ytBSW50YfWW5Z+BXS92VMUpqWZB8A
oS2Eh3WPRd0oYMy2E2D7q7s3aE4K+oaDYx+qEP7hEimm1Zxglv+fZhG1FMonpNyl
dRQIrR3ma5TIkvydXoAjYdmCXPrGAr3oDh/JyRUASMLq4od8LQKpoGTn6wBJ52wT
TZGlep+ahc8tNE2w/1mb0f79rw/aXQ==
=T3T7
-----END PGP SIGNATURE-----

--Sig_/_8jYPeoYD2t6TaVlXCOwAXt--
