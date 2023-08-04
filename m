Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B7C76F8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjHDE2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHDE2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:28:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08474200;
        Thu,  3 Aug 2023 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691123317;
        bh=RRAVMuHpL2obZ9Ujx1AONtkHu+0YfE4PpCRl7JaKNAA=;
        h=Date:From:To:Cc:Subject:From;
        b=L2zyAyCM/7kmzbBawMIEHoou10WPB2ZZl1j4hP2EAw4+kijsUiBkPIOxkZLRWyiUU
         BYT5s3Au5QKboTNN5SK/PS+7X33PJZYJy6fy9XUcOhu2IBZnN5AB1S3swN6WOMMD4n
         y8CVbQ+4jfQxvUzbD8VVrYmDPKhG4kETkdBl1a5BLVX6/136baAzvrJi66BQ0Z1Knz
         eCyYwQg8g1hVt0nGvByKcqJ3LJ1pRgOexxkRjW/F08XpSpbTQeTXqrK3i0sI4eH5I0
         L1cNQcpBr27bN77yEHvWPzvpeB0/KXAsg1/KnZMf4u4xIntlZtbxQBiRUadvEAxLFV
         iZd3lPfgcZMAw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RHCQF2lFlz4wbj;
        Fri,  4 Aug 2023 14:28:37 +1000 (AEST)
Date:   Fri, 4 Aug 2023 14:28:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 4
Message-ID: <20230804142835.0cd9527f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cst5qb=9WSVh191kEhsvdtR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cst5qb=9WSVh191kEhsvdtR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230803:

Non-merge commits (relative to Linus' tree): 6364
 8009 files changed, 223683 insertions(+), 98228 deletions(-)

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
Merging origin/master (999f6631866e Merge tag 'net-6.5-rc5' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (b4abfc1902d6 selftests: cgroup: f=
ix test_kmem_basic slab1 check)
Merging kbuild-current/fixes (238353088e9b scripts/kallsyms: Fix build fail=
ure by setting errno before calling getline())
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (89a65c3f170e arm64/ptrace: Flush FP sta=
te when setting ZT0)
Merging arm-soc-fixes/arm/fixes (d21afb098c51 Merge tag 'socfpga_dts_fix_fo=
r_v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux int=
o arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (faafd6ca7e6e memory: tegra: make icc_se=
t_bw return zero if BWMGR not supported)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (4055eabe04a2 m68k: defconfig: Update defcon=
figs for v6.4-rc1)
Merging powerpc-fixes/fixes (86582e6189dd powerpc/powermac: Use early_* IO =
variants in via_calibrate_decr())
Merging s390-fixes/fixes (388acb471662 s390/ptrace: add missing linux/const=
.h include)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (999f6631866e Merge tag 'net-6.5-rc5' of git://git.kernel.=
org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (999f6631866e Merge tag 'net-6.5-rc5' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipsec/master (f3ec2b5d879e xfrm: don't skip free of empty state in =
acquire policy)
Merging netfilter/main (c5ccff70501d Merge branch 'net-sched-bind-logic-fix=
es-for-cls_fw-cls_u32-and-cls_route')
Merging ipvs/main (d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout=
 callback)
Merging wireless/for-next (16e455a465fc wifi: brcmfmac: Fix field-spanning =
write in brcmf_scan_params_v2_to_v1())
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (186b169cf1e4 RDMA/umem: Set iova in ODP flow)
Merging sound-current/for-linus (3b9adfbba5af Merge tag 'asoc-fix-v6.5-rc3'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (530f8cc7796f Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging regulator-fixes/for-linus (a2e962a071bc Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (90afd74c0ee2 Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (b607aa1edc9c Revert "PCI: acpiphp: Reassign =
resources on bridge if necessary")
Merging driver-core.current/driver-core-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging tty.current/tty-linus (7d695d83767c serial: core: Fix serial_base_m=
atch() after fixing controller port name)
Merging usb.current/usb-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging usb-serial-fixes/usb-linus (d245aedc0077 USB: serial: simple: sort =
driver entries)
Merging phy/fixes (5d0c230f1de8 Linux 6.5-rc4)
Merging staging.current/staging-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging iio-fixes/fixes-togreg (8a4629055ef5 iio: cros_ec: Fix the allocati=
on size for cros_ec_command)
Merging counter-current/counter-current (aead78125a98 tools/counter: Makefi=
le: Replace rmdir by rm to avoid make,clean failure)
Merging char-misc.current/char-misc-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging soundwire-fixes/fixes (5d0c230f1de8 Linux 6.5-rc4)
Merging thunderbolt-fixes/fixes (583893a66d73 thunderbolt: Fix Thunderbolt =
3 display flickering issue on 2nd hot plug onwards)
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
Merging dmaengine-fixes/fixes (c3633b42923d dmaengine: xilinx: xdma: Fix ty=
po)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c6abce60338a mtd: rawnand: fsl_upm: Fix an off=
-by one test in fun_exec_op())
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (6d00f4ec1205 media: uvcvideo: Fix menu count h=
andling for userspace XU mappings)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (6eaae1980760 Linux 6.5-rc3)
Merging at91-fixes/at91-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (5a7591176c47 KVM: selftests: Expand x86's sregs t=
est to cover illegal CR0 values)
Merging kvms390-fixes/master (c2fceb59bbda KVM: s390: pv: fix index value o=
f replaced ASCE)
Merging hwmon-fixes/hwmon (5d0c230f1de8 Linux 6.5-rc4)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (ad64f5952ce3 cxl/memdev: Only show sanitize sysfs =
files when supported)
Merging btrfs-fixes/next-fixes (d3099c02c165 Merge branch 'misc-6.5' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (1cd0302be564 ACPI: scan: Create platform d=
evice for CS35L56)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (ffc59c6414f9 dt-bindings: serial: Remove=
 obsolete nxp,lpc1850-uart.txt)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (9426d3cef500 scsi: core: Fix legacy /proc parsing=
 buffer overflow)
Merging drm-fixes/drm-fixes (5d0c230f1de8 Linux 6.5-rc4)
Merging drm-intel-fixes/for-linux-next-fixes (0bc057eae261 Merge tag 'gvt-f=
ixes-2023-08-02' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (5def5c1c15bf mmc: sdhci-f-sdh30: Replace with sdhc=
i_pltfm)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (ed0cf84e9cc4 vmbus_testing: fix wrong py=
thon syntax for integer value comparison)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (9d3e8e1ff0d8 riscv: Start of DRAM should at lea=
st be aligned on PMD size for the direct mapping)
Merging riscv-dt-fixes/riscv-dt-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging gpio-brgl-fixes/gpio/for-current (5a78d5db9c90 gpio: sim: mark the =
GPIO chip as a one that can sleep)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (4da3c7183e18 erofs: drop unnecessary WARN_ON() i=
n erofs_kill_sb())
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (101df45e7ec3 nfsd: Fix reading via splice)
Merging irqchip-fixes/irq/irqchip-fixes (6fe5c68ee6a1 irqchip/gic-v3: Worka=
round for GIC-700 erratum 2941627)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (07d2b820fd75 perf test parse-events: Test =
complex name has required event format)
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
Merging rust-fixes/rust-fixes (b859eee7f965 rust: fix bindgen build error w=
ith UBSAN_BOUNDS_STRICT)
Merging v9fs-fixes/fixes/next (e6ab0b914c12 fs/9p: Remove unused extern dec=
laration)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging genpd-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging i2c-host-fixes/i2c/andi-for-current (dcd14feb235b i2c: designware: =
Handle invalid SMBus block data response length value)
Merging drm-misc-fixes/for-linux-next-fixes (421dabcad1c6 drm/nouveau: remo=
ve unused tu102_gr_load() function)
Merging mm-stable/mm-stable (6eaae1980760 Linux 6.5-rc3)
Merging mm-nonmm-stable/mm-nonmm-stable (6eaae1980760 Linux 6.5-rc3)
Merging mm/mm-everything (731cfea6a0d5 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/memory.c
Merging kbuild/for-next (1f0ecfe3424a kconfig: nconf: Add search jump featu=
re)
Merging clang-format/clang-format (06c2afb862f9 Linux 6.5-rc1)
Merging perf/perf-tools-next (f6b8436bede3 perf hists browser: Fix the numb=
er of entries for 'e' key)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (1395706a1490 swiotlb: search the software IO =
TLB only if the device makes use of it)
Merging asm-generic/master (4dd595c34c4b syscalls: Remove file path comment=
s from headers)
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (1faf70485ea9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (7f1ce879f0ef Merge branches 'for-next/cpufeatu=
re', 'for-next/docs', 'for-next/errata', 'for-next/misc', 'for-next/mm', 'f=
or-next/perf' and 'for-next/selftests' into for-next/core)
Merging arm-perf/for-next/perf (ac18ea1a8935 perf/arm-cmn: Add CMN-700 r3 s=
upport)
Merging arm-soc/for-next (d99c8ba18cb8 Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (f590814603bf Merge branch 'v6.6/arm-mach' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (a43f3e970a1d ARM: dts: aspeed: Add AST2600 VUARTs)
Merging at91/at91-next (b04dba7c1c30 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (0d8d8753ede0 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (f7812cdabb82 dt-bindings: net: davicom,dm9=
000: convert to DT schema)
Merging imx-mxs/for-next (c4173500f783 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (54fbc0260c64 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (3099f78e0ed9 Merge branch 'omap-for-v6.6/dt' into fo=
r-next)
Merging qcom/for-next (a8726072d7bf Merge branches 'arm64-defconfig-for-6.6=
', 'arm64-fixes-for-6.5', 'arm64-for-6.6', 'clk-for-6.6', 'drivers-for-6.6'=
 and 'dts-for-6.6' into for-next)
Merging renesas/next (13512fa6af4a Merge branch 'renesas-dts-for-v6.6' into=
 renesas-next)
Merging reset/reset/next (38d09b989721 reset: hisilicon: Use dev_err_probe =
instead of dev_err)
Merging rockchip/for-next (9785658bddf3 Merge branch 'v6.6-armsoc/defconfig=
64' into for-next)
Merging samsung-krzk/for-next (084752e50db3 Merge branch 'next/drivers' int=
o for-next)
Merging scmi/for-linux-next (e1b68ed58b3b Merge branches 'for-next/juno/upd=
ates', 'for-next/vexpress/updates' and 'for-next/scmi/updates' of git://git=
.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (2f38de940f07 ARM: dts: stm32: Add missing detach =
mailbox for DHCOR SoM)
Merging sunxi/sunxi/for-next (267845be12b5 Merge branch 'sunxi/clk-for-6.6'=
 into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (77a4cfe28fb8 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (402d49d10efa Merge branches 'ti-drivers-soc-next', 'ti-=
k3-config-next', 'ti-k3-dts-next' and 'ti-keystone-next' into ti-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging xilinx/for-next (54272cb46cb5 Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (335eca6a1c2d Merge branch 'clk-versa' into clk-next)
CONFLICT (modify/delete): drivers/clk/qcom/lcc-mdm9615.c deleted in HEAD an=
d modified in clk/clk-next.  Version clk/clk-next of drivers/clk/qcom/lcc-m=
dm9615.c left in tree.
$ git rm -f drivers/clk/qcom/lcc-mdm9615.c
Merging clk-imx/for-next (2deed4cda3b7 clk: imx: clk-gpr-mux: Simplify .det=
ermine_rate())
Merging clk-renesas/renesas-clk (dec57795efc4 clk: renesas: r8a77965: Add 3=
DGE and ZG support)
Merging csky/linux-next (57427df33d5f csky: fix old style declaration in mo=
dule.c)
Merging loongarch/loongarch-next (37343c6c2e35 LoongArch: Add kernel addres=
s sanitizer support)
Merging m68k/for-next (922a9bd13810 m68k: Fix invalid .section syntax)
Merging m68knommu/for-next (721636972799 m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0e9a2a228a1a microblaze: Explicitly include correc=
t DT includes)
Merging mips/mips-next (f11a99674132 MIPS: Loongson64: Fix more __iomem att=
ributes)
Merging openrisc/for-next (dceaafd66881 openrisc: Union fpcsr and oldmask i=
n sigcontext to unbreak userspace ABI)
Merging parisc-hd/for-next (99b2f159b6e7 parisc: unaligned: Add required sp=
aces after ',')
Merging powerpc/next (7f96539437ea powerpc/kexec: fix minor typo)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (471aba2e4760 riscv: sigcontext: Correct the commen=
t of sigreturn)
Merging riscv-dt/riscv-dt-for-next (e7c304c0346d riscv: dts: starfive: jh71=
10: add the node and pins configuration for tdm)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (6b1f3de86748 Merge branch 'features' into for-next)
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
Merging btrfs/for-next (280e8efe97fc Merge branch 'for-next-next-v6.5-20230=
729' into for-next-20230729)
Merging ceph/master (e6e284323079 libceph: fix potential hang in ceph_osdc_=
notify())
Merging cifs/for-next (11260c3d608b smb: client: fix dfs link mount against=
 w2k8)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (8c53383377ba erofs: boost negative xattr lookup with blo=
om filter)
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (cce89350d0f9 Pull fsnotify cleanup.)
Merging ext4/dev (9d3de7ee192a ext4: fix rbtree traversal bug in ext4_mb_us=
e_preallocated)
Merging f2fs/dev (10c7134ee440 f2fs: compress: don't {,de}compress non-full=
 cluster)
Merging fsverity/for-next (adcb53e3ee05 fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (6a567e920fd0 fuse: ioctl: translate ENOSYS in outarg)
Merging gfs2/for-next (dd162bd9e69b gfs: Don't use GFP_NOFS in gfs2_unstuff=
_dinode)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (5d0c230f1de8 Linux 6.5-rc4)
Merging nfs/linux-next (5b4a82a0724a Revert "NFSv4: Retry LOCK on OLD_STATE=
ID during delegation return")
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (6e9163162722 exportfs: remove kernel-doc warnings i=
n exportfs)
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (0a3bf81dbcb2 ovl: auto generate uuid for =
new overlay filesystems)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging xfs/for-next (f6250e205691 xfs: convert flex-array declarations in =
xfs attr shortform objects)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (a67371b7aee9 Merge tag 'iomap-per-block-dirty=
-tracking' of https://github.com/riteshharjani/linux into iomap-6.6-merge)
Merging djw-vfs/vfs-for-next (59ba4fdd2d1f fs: wait for partially frozen fi=
lesystems)
Merging file-locks/locks-next (72bb0abc3492 locks: fix KASAN: use-after-fre=
e in trace_event_raw_event_filelock_lock)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (6766515669bf Merge branch 'vfs.super' into vfs=
.all)
Applying: Revert "quota: mark dquot_load_quota_sb static"
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (82515ab6aeb3 Merge branch 'rework/misc-cleanups' i=
nto for-next)
Merging pci/next (417acbdb96e2 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (438b805003a0 pstore: Replace crypto API com=
pression with zlib_deflate library calls)
Merging hid/for-next (5eb5c80feb93 Merge branch 'for-6.5/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (6537ed3904a3 i2c: mpc: Drop unused variable)
Merging i2c-host/i2c/andi-for-next (54b4b9b74530 dt-bindings: i2c: arb-gpio=
-challange: convert to DT schema)
Merging i3c/i3c/next (574ca75f8d29 i3c: Explicitly include correct DT inclu=
des)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (cb7022b8976e hwmon: Add driver for Renesa=
s HS3001)
Merging jc_docs/docs-next (7a6b9e79234a docs: move mips under arch)
Merging v4l-dvb/master (06c2afb862f9 Linux 6.5-rc1)
Merging v4l-dvb-next/master (38d6a03d2511 media: go7007: Remove redundant i=
f statement)
Merging pm/linux-next (8a3c19975d99 Merge branch 'pm-cpuidle' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (e520d0b6be95 cpufreq: brcmstb-a=
vs-cpufreq: Fix -Warray-bounds bug)
Merging cpupower/cpupower (99481d2195bf cpupower: Fix cpuidle_set to accept=
 only numeric values for idle-set operation.)
Merging devfreq/devfreq-next (c46de2fb4ad9 PM / devfreq: Reword the kernel-=
doc comment for devfreq_monitor_start() API)
Merging genpd/next (a6a67e5a13f6 genpd: Makefile: build imx)
Merging opp/opp/linux-next (c2add32ce452 dt-bindings: opp: Increase maxItem=
s for opp-hz property)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (dc52cd2eff4a fs: dlm: fix F_CANCELLK to cancel pending re=
quest)
Merging rdma/for-next (693e1cdebb50 RDMA/irdma: Cleanup and rename irdma_ne=
tdev_vlan_ipv6())
Merging net-next/main (6f9bad6b2d7d eth: dpaa: add missing net/xdp.h includ=
e)
Merging bpf-next/for-next (6f9bad6b2d7d eth: dpaa: add missing net/xdp.h in=
clude)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/main (f5fbd3246c06 Merge branch '100GbE' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/tnguy/nex t-queue)
Merging ipvs-next/main (2303fae13064 net: skbuff: remove unused HAVE_HW_TIM=
E_STAMP feature define)
Merging bluetooth/master (c8573f208a12 Bluetooth: Remove unused declaration=
 amp_read_loc_info())
CONFLICT (content): Merge conflict in net/bluetooth/hci_core.c
Merging wireless-next/for-next (904b102f1ebb Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (d2236f6219fa mtdblock: make warning messages ratelimi=
ted)
Merging nand/nand/next (4622daf4b5c8 mtd: rawnand: meson: fix build error)
Merging spi-nor/spi-nor/next (aa517a29d645 mtd: spi-nor: spansion: switch c=
ypress_nor_get_page_size() to use vreg_offset)
Merging crypto/master (3de0152bf26f crypto: caam - Remove messages related =
to memory allocation failure)
Merging drm/drm-next (52920704df87 Merge tag 'drm-misc-next-2023-07-27' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (e4774e9968b2 drm/doc: fix underline for se=
ction "DRM Sync Objects")
Merging amdgpu/drm-next (7ea1db28119e drm/radeon: Prefer strscpy over strlc=
py calls in radeon_atombios.c)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_gem=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/atom.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_debug.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n314/dcn314_fpu.c
Merging drm-intel/for-linux-next (d823445b09a2 drm/i915/uncore: fix race ar=
ound i915->params.mmio_debug)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/selftests/mock_g=
em_device.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (cd036d542afb drm/msm/a6xx: Add A610 speedbin supp=
ort)
Merging drm-msm-lumag/msm-next-lumag (57a1ca6cf73b drm/msm/dpu: fix DSC 1.2=
 enc subblock length)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/dpu1/dpu_cor=
e_perf.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/msm_mdss.c
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (87ac8777d424 fbdev: mx3fb: Remove the driver)
CONFLICT (modify/delete): drivers/video/fbdev/mx3fb.c deleted in fbdev/for-=
next and modified in HEAD.  Version HEAD of drivers/video/fbdev/mx3fb.c lef=
t in tree.
$ git rm -f drivers/video/fbdev/mx3fb.c
Merging regmap/for-next (5d481ddb6a73 regmap: Merge up fixes from Linus' tr=
ee)
Merging sound/for-next (cfad53a99d94 ALSA: hda: cs35l41: Print amp configur=
ation after bind)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (f3b9d041f57b Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (a6846234f458 ARM: module: Use module_init_lay=
out_section() to spot init sections)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (ba6396fc67ca Merge branch 'for-6.6/io_uring' into f=
or-next)
CONFLICT (content): Merge conflict in fs/super.c
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (caea958926c3 ata: sata_rcar: Convert to platform r=
emove callback returning void)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (e8e2c7b0e695 mmc: davinci: Make SDIO irq truly optional)
Merging mfd/for-mfd-next (b90e33b6116a mfd: wm8998: Update to use maple tre=
e register cache)
Merging backlight/for-backlight-next (a33677b9211b backlight: led_bl: Take =
led_access lock when required)
Merging battery/for-next (7e6311f04b41 power: supply: qcom_pmi8998_charger:=
 fix charger status)
Merging regulator/for-next (dcff6f8d84e9 Merge remote-tracking branch 'regu=
lator/for-6.6' into regulator-next)
Merging security/next (bd1f5934e460 lsm: add comment block for security_sk_=
classify_flow LSM hook)
CONFLICT (content): Merge conflict in security/security.c
Merging apparmor/apparmor-next (afad53575a93 apparmor: use passed in gfp fl=
ags in aa_alloc_null())
Merging integrity/next-integrity (56dc986a6b20 ima: require signed IMA poli=
cy when UEFI secure boot is enabled)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (f01dd5904519 selinux: move debug functions into debug=
 configuration)
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (a959dbd98d1a tomoyo: add format attributes to functi=
ons)
Merging tpmdd/next (2353032d292e tpm: Disable RNG for all AMD fTPMs)
Merging watchdog/master (fdf0eaf11452 Linux 6.5-rc2)
Merging iommu/next (a5003e75a171 Merge branches 'iommu/fixes', 'arm/rockchi=
p', 'x86/amd' and 'core' into next)
Merging audit/next (bf98354280bf audit: correct audit_filter_inodes() defin=
ition)
Merging devicetree/for-next (3e82150697d9 dt-bindings: Update Guru Das Srin=
agesh's email address)
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (79c7610beef3 Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (a9a23d636162 Merge x86/cleanups into tip/master)
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
Merging kvm/next (5a7591176c47 KVM: selftests: Expand x86's sregs test to c=
over illegal CR0 values)
Merging kvm-arm/next (3b4e3afb2032 Merge branch kvm-arm64/6.6/misc into kvm=
arm-master/next)
Merging kvms390/next (db54dfc9f71c s390/uv: Update query for secret-UVCs)
Merging kvm-riscv/riscv_kvm_next (07f225b58424 RISC-V: KVM: Remove unneeded=
 semicolon)
Merging kvm-x86/next (240f73689188 Merge branch 'misc')
Merging xen-tip/linux-next (c04e9894846c xen: speed up grant-table reclaim)
Merging percpu/for-next (58a83cc5f904 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (2ef92cb3bc82 Merge branch 'for-6.5-fixes' into=
 for-next)
Merging drivers-x86/for-next (9204fc5071bf platform/x86: hp-bioscfg: MAINTA=
INERS)
Merging chrome-platform/for-next (0a329167220a platform/chrome: cros_ec_lpc=
: Sync filesystem on EC panic)
Merging chrome-platform-firmware/for-firmware-next (0979e7e3cfd7 MAINTAINER=
S: Add drivers/firmware/google/ entry)
Merging hsi/for-next (7ebf243a2018 hsi: omap_ssi: Explicitly include correc=
t DT includes)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7a2b85a76b05 leds: simatic-ipc-leds-gpio: Fi=
x comment style in SPDX header)
Merging ipmi/for-next (b02bb79eee07 ipmi: fix potential deadlock on &kcs_bm=
c->lock)
Merging driver-core/driver-core-next (5d0c230f1de8 Linux 6.5-rc4)
Merging usb/usb-next (98a9e32bdf25 Merge 6.5-rc4 into usb-next)
Merging thunderbolt/next (6dacc6db4628 thunderbolt: Set variable tmu_params=
 storage class specifier to static)
Merging usb-serial/usb-next (974e2f6a0554 USB: serial: xr: add TIOCGRS485 a=
nd TIOCSRS485 ioctls)
Merging tty/tty-next (426263d5fb40 tty: synclink_gt: mark as BROKEN)
Merging char-misc/char-misc-next (1346e9331abe Merge 6.5-rc4 into char-misc=
-next)
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (c00701125cf3 coresight: trbe: Directly use ID_AA64D=
FR0_EL1_TraceBuffer_IMP)
Merging fastrpc/for-next (64227235abd9 misc: fastrpc: Pass proper scm argum=
ents for static process init)
Merging fpga/for-next (3969f6458f78 fpga: add configuration for the FPGA KU=
nit test suites.)
Merging icc/icc-next (768c42cd9acb Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (c09ddcdd4dd3 iio: adc: fix the return value handle for =
platform_get_irq())
Merging phy-next/next (e7379477f447 phy: starfive: StarFive PHYs should dep=
end on ARCH_STARFIVE)
Merging soundwire/next (3f92da3ea448 soundwire: Explicitly include correct =
DT includes)
Merging extcon/extcon-next (a635f91c71d9 dt-bindings: extcon: siliconmitus,=
sm5502-muic: document connector)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (73e2f19da508 kvm/vfio: avoid bouncing the mutex when add=
ing and deleting groups)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (0e21a9d29d8b Merge 6.5-rc4 into staging-next)
Merging counter-next/counter-next (71ab2f343f1f counter: rz-mtu3-cnt: Reord=
er locking sequence for consistency)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (0f264ab788ed dt-bindings: dmaengine: at_xdmac: add =
compatible with microchip,sam9x7)
Merging cgroup/for-next (7f828eacc4bb cgroup: fix obsolete function name in=
 cgroup_destroy_locked())
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/.gitig=
nore
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/Makefi=
le
Applying: Revert "cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHE=
D"
Merging scsi/for-next (a4b47f608a6c Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (6cae9a3910ac Merge patch series "Multiple cleanu=
p patches for the UFS driver")
Merging vhost/linux-next (373abdba01d4 vdpa_sim: offer VHOST_BACKEND_F_ENAB=
LE_AFTER_DRIVER_OK)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (af2010496de7 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (87d0688483f5 gpio: xra1403: remove redunda=
nt of_match_ptr())
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (0919b5b0cec0 Merge branch 'devel' into for-next)
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
Merging kselftest/next (7e4bf0c1d0f7 selftests:prctl: add set-process-name =
to .gitignore)
Merging kunit/test (06c2afb862f9 Linux 6.5-rc1)
Merging kunit-next/kunit (5a175d369c70 kunit: fix wild-memory-access bug in=
 kunit_filter_suites())
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (3c87b351809f rtc: rv3028: Add support for "aux-voltag=
e-chargeable" property)
Merging nvdimm/libnvdimm-for-next (fd774e36fe87 nvdimm: Explicitly include =
correct DT includes)
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (994def29acc5 ntb: Remove error checking for debugfs_c=
reate_dir())
Merging seccomp/for-next/seccomp (7d5cb68af638 perf/benchmark: add a new be=
nchmark for seccom_unotify)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (c8efcf7a86eb nvmem: add new NXP QorIQ eFuse driver)
Merging xarray/main (cbc02854331e XArray: Do not return sibling entries fro=
m xa_load())
Merging hyperv/hyperv-next (a494aef23dfc PCI: hv: Replace retarget_msi_inte=
rrupt_params with hyperv_pcpu_input_arg)
Merging auxdisplay/auxdisplay (def85dce1451 auxdisplay: Switch i2c drivers =
back to use .probe())
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (06c2afb862f9 Linux 6.5-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (14a2714085ac docs: ABI: sysfs-bus-mhi: Update contact=
 info)
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
Merging rust/rust-next (bd83e4370c6e scripts: `make rust-analyzer` for out-=
of-tree modules)
Merging sysctl/sysctl-next (c233d7a19814 sysctl: Add size arg to __register=
_sysctl_init)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (94b154766896 lib: test for_each_numa_cpus())
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (66d882a2adf1 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (06c2afb862f9 Linux 6.5-rc1)
Merging iommufd/for-next (c157fd886199 vfio: Support IO page table replacem=
ent)
CONFLICT (content): Merge conflict in drivers/iommu/iommufd/device.c
Applying: fix for "iommufd: Move putting a hwpt to a helper function"

--Sig_/cst5qb=9WSVh191kEhsvdtR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTMfnMACgkQAVBC80lX
0GwwGgf/Z+5Lq3MVYhk3mx203ImaQORwdtcseCmNRMTbq87IXAGvKqjI3MUCLoDE
VRWbbVhZi0QuimzEA5ik59pnS/wwRuYhW0OKfOfPF9mhIbuvoUr2PjY9TbmuwVn7
rA1OcdeE077kpoht1i3ez3vfDfQXUX3kpZwN7hO9qveAcz6hYMvVCtFM8e+njdPU
XOSdHSa3bVqqOG3nVQrpxAgRmle0eli0Z1FSTGdynHtJw744S2lNzQv4O0N42lcg
X+BCerffPETkIiShrUe9t4q2zNrjPw+JfoYeWnOMi0/Vxvr8bVHETDjqtkwK18kp
VNxgQDHIzzjnS37iQE3Ug+fsq3mxtQ==
=f5kI
-----END PGP SIGNATURE-----

--Sig_/cst5qb=9WSVh191kEhsvdtR--
