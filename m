Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378C7780693
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358278AbjHRHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358313AbjHRHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:49:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81BF3A84;
        Fri, 18 Aug 2023 00:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692344977;
        bh=twmVLDYXNsK/f2jLOAztlfp1JiTYZY7kGefXlGlzcFM=;
        h=Date:From:To:Cc:Subject:From;
        b=jFRjWK3TcCw9RtvuPDmXlmiRtebItcqwbaOG2239fdIXBn8tSPU8IF3ej/lXx0MDG
         NZOjPLzWlCJiODjKJk+TgDs4ZDchZ30vfLZCo4JkTuaOgFrQFrWW1hzlLzud7reL8S
         Cm9IbI5Q9PG48/QV9P80XHdlZbm4GEu1sDhIAQLROjMXS4HnWJY0C5fR/l92lpOPj7
         zoiqxOqUJ06pF/D60myA7dazD4sMJw0pavtBYfBLfnzXsVxiwBvgz3H38ecXsflT7O
         omXTlukW+ib0ZKMP4EyUG5TyRasqUo1PLPvooF6Nec35UlsV2WJLslxv6xpU5KB89f
         Zi4BWRCEd+GPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRvCj5yHRz4wxm;
        Fri, 18 Aug 2023 17:49:37 +1000 (AEST)
Date:   Fri, 18 Aug 2023 17:49:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 18
Message-ID: <20230818174937.5fe84253@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w7XoeWn4Y_F2ekLlWOjMdhn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w7XoeWn4Y_F2ekLlWOjMdhn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230817:

The net-next tree gained conflicts against the net and powerpc trees.

The drm tree gained a conflict against the drm-fixes tree.

The sound tree gained a conflict against the sound-asoc-fixes tree and
a build failure so I used the version from next-20230817.

The tty tree gained a conflict against the powerpc tree.

The phy-next tree gained a build failure so I used the version from
next-20230817.

The pinctrl-renesas gained conflicts against with the pinctrl tree.

The nvmem tree still had its build failure so I used the version from
next-20230809.

Non-merge commits (relative to Linus' tree): 10168
 11375 files changed, 359634 insertions(+), 167597 deletions(-)

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
Merging origin/master (16931859a650 Merge tag 'nfsd-6.5-4' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/cel/linux)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (795208ee483a mm: multi-gen LRU: d=
on't spin during memcg release)
Merging kbuild-current/fixes (6ccbd7fd4746 alpha: remove __init annotation =
from exported page_is_ram())
Merging arc-current/for-curr (42f51fb24fd3 ARC: atomics: Add compiler barri=
er to atomic operations...)
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
Merging net/main (820a38d8f2cb Merge branch '40GbE' of git://git.kernel.org=
/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging bpf/master (23d775f12dcd net: dsa: mv88e6xxx: Wait for EEPROM done =
before HW reset)
Merging ipsec/master (f3ec2b5d879e xfrm: don't skip free of empty state in =
acquire policy)
Merging netfilter/main (de4c5efeeca7 Merge tag 'nf-23-08-16' of https://git=
.kernel.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging ipvs/main (de4c5efeeca7 Merge tag 'nf-23-08-16' of https://git.kern=
el.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging wireless/for-next (609a1bcd7beb wifi: iwlwifi: mvm: add dependency =
for PTP clock)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (2ccdd1b13c59 Linux 6.5-rc6)
Merging sound-current/for-linus (46cdff2369cb ALSA: hda/realtek - Remodifie=
d 3k pull low procedure)
Merging sound-asoc-fixes/for-linus (19cf853660c2 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (52a93d39b17d Linux 6.5-rc5)
Merging regulator-fixes/for-linus (d116c6476551 Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (71a158b9fe09 Merge remote-tracking branch 'spi=
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
Merging counter-current/counter-current (2ccdd1b13c59 Linux 6.5-rc6)
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
Merging btrfs-fixes/next-fixes (94643ba49f48 Merge branch 'misc-6.5' into n=
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
Merging drm-fixes/drm-fixes (c611589b4259 drm/qxl: fix UAF on handle creati=
on)
Merging drm-intel-fixes/for-linux-next-fixes (423ffe62c06a drm/i915: fix di=
splay probe for IVB Q and IVB D GT2 server)
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
Merging gpio-brgl-fixes/gpio/for-current (3386fb86ecde gpiolib: fix referen=
ce leaks when removing GPIO chips still in use)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (4da3c7183e18 erofs: drop unnecessary WARN_ON() i=
n erofs_kill_sb())
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (16931859a650 Merge tag 'nfsd-6.5-4' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
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
Merging drm-misc-fixes/for-linux-next-fixes (50b6f2c82977 Revert "drm/edid:=
 Fix csync detailed mode parsing")
Merging mm-stable/mm-stable (5fb2ea3111f4 powerpc/book3s64/radix: add debug=
 message to give more details of vmemmap allocation)
CONFLICT (content): Merge conflict in arch/parisc/mm/ioremap.c
Merging mm-nonmm-stable/mm-nonmm-stable (7de09a5ffc68 x86/kernel: increase =
kcov coverage under arch/x86/kernel folder)
Merging mm/mm-everything (c9b65572fef3 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in arch/x86/Kconfig
CONFLICT (add/add): Merge conflict in kernel/Kconfig.kexec
CONFLICT (content): Merge conflict in kernel/kexec_file.c
Merging kbuild/for-next (45a7371d5be2 docs: kbuild: Document search jump fe=
ature)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (042c126a3e2c perf trace: Use heuristic when d=
eciding if a syscall tracepoint "const char *" field is really a string)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (d069ed288ac7 swiotlb: optimize get_max_slots(=
))
Merging asm-generic/master (6e8d96909a23 asm-generic: partially revert "Uni=
fy uapi bitsperlong.h for arm64, riscv and loongarch")
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (bb675d6f7493 Merge branches 'for-next/cpufeatu=
re', 'for-next/docs', 'for-next/entry', 'for-next/errata', 'for-next/misc',=
 'for-next/mm', 'for-next/perf' and 'for-next/selftests' into for-next/core)
Merging arm-perf/for-next/perf (f4e2bd91ddf5 perf/imx_ddr: don't enable cou=
nter0 if none of 4 counters are used)
Merging arm-soc/for-next (9ca4a7768615 Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (413f5c02929b Merge branch 'v6.6/drivers' into for=
-next)
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
Merging omap/for-next (6387fcbea64f Merge branch 'omap-for-v6.6/ti-sysc' in=
to for-next)
Merging qcom/for-next (7e854e3da299 Merge branches 'arm64-defconfig-for-6.6=
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
Merging tegra/for-next (c8504390ec7f Merge branch for-6.6/arm64/dt into for=
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
Merging m68k/for-next (922a9bd13810 m68k: Fix invalid .section syntax)
Merging m68knommu/for-next (7c53e18ee74e m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0e9a2a228a1a microblaze: Explicitly include correc=
t DT includes)
Merging mips/mips-next (ed07f6c26f9c Mips: loongson3_defconfig: Enable ast =
drm driver by default)
Merging openrisc/for-next (232ba1630c66 openrisc: Make pfn accessors static=
s inlines)
Merging parisc-hd/for-next (0031b84a06fd parisc: Use page table locks only =
if DEBUG_KERNEL is enabled)
Merging powerpc/next (9a32584bc108 powerpc/ptrace: Split gpr32_set_common)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (174e8ac0272d riscv: alternatives: fix a typo in co=
mment)
Merging riscv-dt/riscv-dt-for-next (a3ce3ff28385 riscv: dts: change TH1520 =
files to dual license)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (d17e733e8480 Merge branch 'features' into for-next)
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
Merging btrfs/for-next (6f8d91d537fe Merge branch 'for-next-next-v6.5-20230=
817' into for-next-20230817)
Merging ceph/master (e6e284323079 libceph: fix potential hang in ceph_osdc_=
notify())
Merging cifs/for-next (270d73e6507f smb: client: fix null auth)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (80b45c60a9e7 erofs: adapt folios for z_erofs_read_folio(=
))
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (e9d69270eb3d Pull ext2 block number overflow fix.)
Merging ext4/dev (9d3de7ee192a ext4: fix rbtree traversal bug in ext4_mb_us=
e_preallocated)
Merging f2fs/dev (0cc81b1ad512 f2fs: should update REQ_TIME for direct writ=
e)
Merging fsverity/for-next (adcb53e3ee05 fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (82c36218a9b0 fuse: cache btime)
Merging gfs2/for-next (584e70f20bd0 gfs2: prevent gfs2_logd from spinning)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (ec5d7b6a2d35 ksmbd: fix `force create mode' a=
nd `force directory mode')
Merging nfs/linux-next (7a832eba84ef xprtrdma: Remap Receive buffers after =
a reconnect)
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (fcae6e733c07 NFSD: da_addr_body field missing in so=
me GETDEVICEINFO replies)
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
Merging vfs-brauner/vfs.all (6be51a71655d Merge branch 'vfs.fs_context' int=
o vfs.all)
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/f2fs/xattr.c
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (cb65d08d735e Merge branch 'for-6.6' into for-next)
Merging pci/next (3f7f17a73c37 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (104fd0b5e948 pstore: Support record sizes l=
arger than kmalloc() limit)
Merging hid/for-next (ae52944d003b Merge branch 'for-6.5/upstream-fixes' in=
to for-next)
CONFLICT (content): Merge conflict in .mailmap
Merging i2c/i2c/for-next (8ab7725b6bfb Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
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
Merging cpufreq-arm/cpufreq/arm/linux-next (e613d8cff547 cpufreq: cppc: Set=
 fie_disabled to FIE_DISABLED if fails to create kworker_fie)
Merging cpupower/cpupower (af75504c3896 cpupower: Add Georgian translation =
to Makefile LANGUAGES)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging genpd/next (4f6c9832613b genpd: imx: scu-pd: initialize is_off acco=
rding to HW state)
Merging opp/opp/linux-next (c2add32ce452 dt-bindings: opp: Increase maxItem=
s for opp-hz property)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (a3d85fcf268e fs: dlm: don't use RCOM_NAMES for version de=
tection)
Merging rdma/for-next (213d2b9bb2d6 RDMA/bnxt_re: Protect the PD table bitm=
ap)
Merging net-next/main (f54a2a132a9d Merge tag 'for-netdev' of https://git.k=
ernel.org/pub/scm/linux/kernel/git/bpf/bpf-next)
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fs_ene=
t/fs_enet.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/sfc/tc.c
Merging bpf-next/for-next (f54a2a132a9d Merge tag 'for-netdev' of https://g=
it.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next)
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
Merging netfilter-next/main (950fe35831af Merge branch 'ipv6-expired-routes=
')
Merging ipvs-next/main (950fe35831af Merge branch 'ipv6-expired-routes')
Merging bluetooth/master (f0835e7404b7 Bluetooth: ISO: Use defer setup to s=
eparate PA sync and BIG sync)
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
Merging drm/drm-next (a8b273a8fd9c Merge tag 'amd-drm-next-6.6-2023-08-11' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
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
u_v13_0_0_ppt.c
Merging drm-misc/for-linux-next (ff065eaf5502 drm/ttm/tests: Require MMU wh=
en testing)
Merging amdgpu/drm-next (ef35c7ba6041 Revert "Revert "drm/amdgpu/display: c=
hange pipe policy for DCN 2.0"")
  ef35c7ba6041 ("Revert "Revert "drm/amdgpu/display: change pipe policy for=
 DCN 2.0""")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_0_ppt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
Merging drm-intel/for-linux-next (4ebf43d0488f drm/i915: Eliminate has_4til=
e feature flag)
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
Merging fbdev/for-next (0650d5098f8b fbdev: goldfishfb: Do not check 0 for =
platform_get_irq())
Merging regmap/for-next (26fc7cfa30d6 Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-next)
Merging sound/for-next (01ed7f3535a2 ALSA: core: Drop snd_device_initialize=
())
CONFLICT (content): Merge conflict in sound/soc/codecs/cs35l56.c
$ git reset --hard HEAD^
Merging next-20230817 version of sound
CONFLICT (content): Merge conflict in sound/soc/codecs/cs35l56.c
[master cff66d4464ce] next-20230817/sound
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (278e590d75c8 Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (a6846234f458 ARM: module: Use module_init_lay=
out_section() to spot init sections)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (441cba897395 Merge branch 'for-6.6/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/super.c
CONFLICT (content): Merge conflict in lib/raid6/test/Makefile
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (0e1bd497ca37 ata: pata_imx: Use helper function de=
vm_clk_get_enabled())
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (899171dc4e7c mmc: sdhci-pltfm: Rename sdhci_pltfm_registe=
r())
Merging mfd/for-mfd-next (956a2c4d0048 mfd: rz-mtu3: Remove duplicated incl=
ude module.h)
Merging backlight/for-backlight-next (fe1328b5b2a0 backlight: gpio_backligh=
t: Drop output GPIO direction check for initial power state)
Merging battery/for-next (7e6311f04b41 power: supply: qcom_pmi8998_charger:=
 fix charger status)
Merging regulator/for-next (a96267b11727 Merge remote-tracking branch 'regu=
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
Merging watchdog/master (8a504bd61ec7 watchdog: starfive: Remove #ifdef gua=
rds for PM related functions)
Merging iommu/next (9c84d6461897 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
Merging audit/next (b1a0f64cc65e audit: move trailing statements to next li=
ne)
Merging devicetree/for-next (abe916c5430a dt: dt-check-compatible: Find str=
uct of_device_id instances with compiler annotations)
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (5f2deac00ebe Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (94434109afe0 Merge branch into tip/master: 'x86/sev')
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
Merging rcu/rcu/next (98545332bf8d torture: Make torture.sh refscale testin=
g qualify verbose_batched)
Merging kvm/next (d5ad9aae13dc selftests/rseq: Fix build with undefined __w=
eak)
Merging kvm-arm/next (6951f4169ec3 Merge branch kvm-arm64/tlbi-range into k=
vmarm-master/next)
Merging kvms390/next (b275d8313217 KVM: s390: selftests: Add selftest for s=
ingle-stepping)
Merging kvm-riscv/riscv_kvm_next (477069398ed6 KVM: riscv: selftests: Add g=
et-reg-list test)
Merging kvm-x86/next (fff2e47e6c3b Merge branch 'misc')
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
Merging leds-lj/for-leds-next (179507fcd5e4 leds: pca995x: Fix MODULE_DEVIC=
E_TABLE for OF)
Merging ipmi/for-next (d40f09c1a230 ipmi_si: fix -Wvoid-pointer-to-enum-cas=
t warning)
Merging driver-core/driver-core-next (f7bb242601de drivers: base: test: Add=
 missing MODULE_* macros to root device tests)
Merging usb/usb-next (bbb9e06d2c64 Merge 6.5-rc6 into usb-next)
Merging thunderbolt/next (a3f6445842e5 Documentation/ABI: thunderbolt: Repl=
ace 01.org in contact)
Merging usb-serial/usb-next (974e2f6a0554 USB: serial: xr: add TIOCGRS485 a=
nd TIOCSRS485 ioctls)
Merging tty/tty-next (e67d7f60d238 tty: gdm724x: simplify gdm_tty_write())
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/fs_pd.h
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
Merging coresight/next (a4621fd1d4fd coresight: etm4x: Ensure valid drvdata=
 and clock before clk_put())
Merging fastrpc/for-next (64227235abd9 misc: fastrpc: Pass proper scm argum=
ents for static process init)
Merging fpga/for-next (1a22ec09a2c1 fpga: region: make fpga_region_class a =
static const structure)
Merging icc/icc-next (768c42cd9acb Merge branch 'icc-fixes' into icc-next)
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
Merging vfio/next (a881b496941f vfio: align capability structures)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (656ae4f48a6f staging: fieldbus: arcx-anybus: =
Remove redundant of_match_ptr())
Merging counter-next/counter-next (39266b642ccd counter: rz-mtu3-cnt: Reord=
er locking sequence for consistency)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (0f264ab788ed dt-bindings: dmaengine: at_xdmac: add =
compatible with microchip,sam9x7)
Merging cgroup/for-next (78d44b824ed0 cgroup: Avoid -Wstringop-overflow war=
nings)
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
Merging gpio-brgl/gpio/for-next (ba0294df2dbd gpio: sim: replace memmove() =
+ strstrip() with skip_spaces() + strim())
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (4b13242647ca Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (34393c367872 pinctrl: intel: Switch to use =
exported namespace)
Merging pinctrl-renesas/renesas-pinctrl (1eb1e00e5d99 pinctrl: renesas: rza=
2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function=
})
CONFLICT (content): Merge conflict in drivers/pinctrl/renesas/pinctrl-rza2.c
CONFLICT (content): Merge conflict in drivers/pinctrl/renesas/pinctrl-rzg2l=
.c
CONFLICT (content): Merge conflict in drivers/pinctrl/renesas/pinctrl-rzv2m=
.c
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
Merging kunit-next/kunit (582eb3aeed2d kunit: replace KUNIT_TRIGGER_STATIC_=
STUB maro with KUNIT_STATIC_STUB_REDIRECT)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (dac783784848 rtc: tps65910: Remove redundant dev_warn=
() and do not check for 0 return after calling platform_get_irq())
Merging nvdimm/libnvdimm-for-next (08ca6906a4b7 nvdimm: Fix dereference aft=
er free in register_nvdimm_pmu())
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (994def29acc5 ntb: Remove error checking for debugfs_c=
reate_dir())
Merging seccomp/for-next/seccomp (46822860a5a9 seccomp: Add missing kerndoc=
 notations)
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
Merging sysctl/sysctl-next (53f3811dfd5e sysctl: Use ctl_table_size as stop=
ping criteria for list macro)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (5b914afcd166 bitmap: Fix a typo ("identify =
map"))
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (5d207e83ca41 lkdtm: Add FAM_BOUNDS test for __c=
ounted_by)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (938315d721db tools/nolibc: avoid undesired casts in =
the __sysret() macro)
CONFLICT (content): Merge conflict in tools/include/nolibc/stdio.h
CONFLICT (content): Merge conflict in tools/testing/selftests/nolibc/nolibc=
-test.c
Merging iommufd/for-next (a6572120cca7 iommu/vt-d: Implement hw_info for io=
mmu capability query)
CONFLICT (content): Merge conflict in include/linux/iommu.h
Applying: fix up for "iommufd/selftest: Make the mock iommu driver into a r=
eal driver"

--Sig_/w7XoeWn4Y_F2ekLlWOjMdhn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTfIpEACgkQAVBC80lX
0GzHhAgAhKhkBI6wj7MsoRcn2tYQ1ePRgjm0OA44oq0Bvc8E+XzOS+xtR01aznwE
ZbqOlEM153Bh3XxYKaYn9pAPXUy/cjnhQnHgOObv2JVPdMQLHyyfIl9WD+JrCn5k
KWlNdd7s6sJtUhE3vZDRGQ9S+diENj1FlQzpKTeEVu+Q6UsIP4kpimSf/OeiK0s9
jsiNKujs0Y1K7yS+X8rg0RmhiBi585GXfejDiQuAeQFlADYqFbfuQTX2mXKScB2a
DRJ2mGMGAVPtXUUx86JIYRGvPV+hrO3OVLwNclgzm81gnm/+ECSM/OOpmKtxdW6Y
lWV/P9VPoVkff1iF0Ck9ePOs0sFapQ==
=Cqv1
-----END PGP SIGNATURE-----

--Sig_/w7XoeWn4Y_F2ekLlWOjMdhn--
