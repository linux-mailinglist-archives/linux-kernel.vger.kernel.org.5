Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648C771995
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHGFsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjHGFr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:47:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCD171B;
        Sun,  6 Aug 2023 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691387268;
        bh=PxzU4mOrqf8ajncH2GDvMZxipxqeJ0DkTq1a0VWqIJY=;
        h=Date:From:To:Cc:Subject:From;
        b=en38uvHX8znwyts/mg7XkdmivkFeC0/SzWf0TNYUe/UndH9L0w6wYLXYSAGXQ7G+z
         Aj9TjxLoC4ZhSryBXImaBoT/LDbnrGkAne7thBN/IvCTFr9SMoh20lTwbCVN0IoFnK
         3gNoDQm7FPf7QOGw8RHRvd8BcVli1KVZcbCD0bCzaTYmZ1oyGnJYMApKmC4c0W8w6k
         SlvTmBXNGbyn9f2/W8U1+Vu770sZJeU+5W8t/Shaul2XBH3VN80ECu3E8x0AxmsSeR
         QTTV85vjO+58h7O9hTbT28PY87tUz5UtEMg99U3JUoWfrBm4wD2HLsVaTRemWZU3f7
         GaQOhXQVLafDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RK52D5J5Wz4wy7;
        Mon,  7 Aug 2023 15:47:48 +1000 (AEST)
Date:   Mon, 7 Aug 2023 15:47:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 7
Message-ID: <20230807154747.6e034993@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bpR95KNlbkW/5UhuGA5m7ON";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bpR95KNlbkW/5UhuGA5m7ON
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230804:

The drm-misc tree gained a build failure so I used the version from
next-20230804.

The hyperv tree gained a build failure so I used the version from
next-20230804.

Non-merge commits (relative to Linus' tree): 6703
 8336 files changed, 232535 insertions(+), 101892 deletions(-)

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
Merging origin/master (52a93d39b17d Linux 6.5-rc5)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (00784220ade0 selftests: cgroup: f=
ix test_kmem_basic less than error)
Merging kbuild-current/fixes (238353088e9b scripts/kallsyms: Fix build fail=
ure by setting errno before calling getline())
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (69af56ae56a4 arm64/fpsimd: Sync and zer=
o pad FPSIMD state for streaming SVE)
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
Merging net/main (52417a95ff2d ionic: Add missing err handling for queue re=
config)
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
Merging sound-current/for-linus (4d84f763f7e1 Merge tag 'asoc-fix-v6.5-rc4'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (d785331c1799 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging regulator-fixes/for-linus (3b69b612a3da Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (f441bb6211aa Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (3bfc37d92687 Revert "PCI: mvebu: Mark driver=
 as BROKEN")
Merging driver-core.current/driver-core-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging tty.current/tty-linus (dfe2aeb226fd serial: 8250: Fix oops for port=
->pm on uart_change_pm())
Merging usb.current/usb-linus (3ddaa6a27457 usb: dwc3: Properly handle proc=
essing of pending events)
Merging usb-serial-fixes/usb-linus (d245aedc0077 USB: serial: simple: sort =
driver entries)
Merging phy/fixes (5d0c230f1de8 Linux 6.5-rc4)
Merging staging.current/staging-linus (5d0c230f1de8 Linux 6.5-rc4)
Merging iio-fixes/fixes-togreg (34477b2d710a iio: dac: ad3552r: Correct dev=
ice IDs)
Merging counter-current/counter-current (aead78125a98 tools/counter: Makefi=
le: Replace rmdir by rm to avoid make,clean failure)
Merging char-misc.current/char-misc-linus (51a26bb02ae5 Merge tag 'icc-6.5-=
rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-=
misc-linus)
Merging soundwire-fixes/fixes (5d0c230f1de8 Linux 6.5-rc4)
Merging thunderbolt-fixes/fixes (596a5123cc78 thunderbolt: Fix memory leak =
in tb_handle_dp_bandwidth_request())
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
Merging hwmon-fixes/hwmon (f38963b9cd06 hwmon: (pmbus/bel-pfe) Enable PMBUS=
_SKIP_STATUS_CHECK for pfe1100)
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
Merging drm-fixes/drm-fixes (1958b0f95a35 Merge tag 'drm-intel-fixes-2023-0=
8-03' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (0bc057eae261 Merge tag 'gvt-f=
ixes-2023-08-02' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (5def5c1c15bf mmc: sdhci-f-sdh30: Replace with sdhc=
i_pltfm)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
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
Merging nfsd-fixes/nfsd-fixes (3b816601e279 nfsd: Fix race to FREE_STATEID =
and cl_revoked)
Merging irqchip-fixes/irq/irqchip-fixes (6fe5c68ee6a1 irqchip/gic-v3: Worka=
round for GIC-700 erratum 2941627)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (c1a515d3c027 Merge tag 'perf-tools-fixes-f=
or-v6.5-2-2023-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/perf=
/perf-tools)
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
Merging rust-fixes/rust-fixes (b05544884300 rust: fix bindgen build error w=
ith UBSAN_BOUNDS_STRICT)
Merging v9fs-fixes/fixes/next (e6ab0b914c12 fs/9p: Remove unused extern dec=
laration)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging genpd-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging i2c-host-fixes/i2c/andi-for-current (dcd14feb235b i2c: designware: =
Handle invalid SMBus block data response length value)
Merging drm-misc-fixes/for-linux-next-fixes (3c6bd1b7e204 Revert "drm/bridg=
e: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
Merging mm-stable/mm-stable (5d0c230f1de8 Linux 6.5-rc4)
Merging mm-nonmm-stable/mm-nonmm-stable (5d0c230f1de8 Linux 6.5-rc4)
Merging mm/mm-everything (700b8557a875 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (1f0ecfe3424a kconfig: nconf: Add search jump featu=
re)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (bf1842996aaa Merge remote-tracking branch 'to=
rvalds/master' into perf-tools-next)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (1395706a1490 swiotlb: search the software IO =
TLB only if the device makes use of it)
Merging asm-generic/master (4dd595c34c4b syscalls: Remove file path comment=
s from headers)
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (1faf70485ea9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (3168eb5f051f Merge branches 'for-next/cpufeatu=
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
Merging broadcom/next (a70e8c9ff89a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (35bd78cf2522 memory: tegra: add MC client =
for Tegra234 GPU)
Merging imx-mxs/for-next (2cc1e9247703 Merge branch 'imx/defconfig' into fo=
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
Merging samsung-krzk/for-next (4124fbc4b4b1 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (cff088d87434 Merge tag 'scmi-updates-6.6' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (2f38de940f07 ARM: dts: stm32: Add missing detach =
mailbox for DHCOR SoM)
Merging sunxi/sunxi/for-next (8bd9496071ba Merge branch 'sunxi/dt-for-6.6' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (77a4cfe28fb8 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (b55834640eb1 tMerge branch 'ti-k3-dts-next' into ti-nex=
t)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging xilinx/for-next (7cd073eddcd4 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (735a8a71d250 Merge branch 'clk-fixes' into clk-next)
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
Merging loongarch/loongarch-next (6881cf6f2c2d LoongArch: Add kernel addres=
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
Merging parisc-hd/for-next (6995e2de6891 Linux 6.4)
Merging powerpc/next (7f96539437ea powerpc/kexec: fix minor typo)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (471aba2e4760 riscv: sigcontext: Correct the commen=
t of sigreturn)
Merging riscv-dt/riscv-dt-for-next (8384087a4223 riscv: dts: starfive: Add =
QSPI controller node for StarFive JH7110 SoC)
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
Merging cifs/for-next (f6a691685962 Merge tag '6.5-rc4-smb3-client-fix' of =
git://git.samba.org/sfrench/cifs-2.6)
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
Merging f2fs/dev (418a5e7f0886 Revert "f2fs: clean up w/ sbi->log_sectors_p=
er_block")
Merging fsverity/for-next (adcb53e3ee05 fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (6a567e920fd0 fuse: ioctl: translate ENOSYS in outarg)
Merging gfs2/for-next (376e82757bd5 gfs: Don't use GFP_NOFS in gfs2_unstuff=
_dinode)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (f47c2be385d0 ksmbd: switch to use kmemdup_nul=
() helper)
Merging nfs/linux-next (5b4a82a0724a Revert "NFSv4: Retry LOCK on OLD_STATE=
ID during delegation return")
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (2bcc7607b3ec fs: lockd: avoid possible wrong NULL p=
arameter)
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
Merging iomap/iomap-for-next (377698d4abe2 Merge tag 'xfs-async-dio.6-2023-=
08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (72bb0abc3492 locks: fix KASAN: use-after-fre=
e in trace_event_raw_event_filelock_lock)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (272af00d6825 Merge branch 'vfs.fixes' into vfs=
.all)
Applying: Revert "quota: mark dquot_load_quota_sb static"
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (82515ab6aeb3 Merge branch 'rework/misc-cleanups' i=
nto for-next)
Merging pci/next (417acbdb96e2 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (fe8c3623ab06 pstore/ram: Check start of emp=
ty przs during init)
Merging hid/for-next (5eb5c80feb93 Merge branch 'for-6.5/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (6537ed3904a3 i2c: mpc: Drop unused variable)
Merging i2c-host/i2c/andi-for-next (012d4d9a4683 i2c: mux: ltc4306: Remove =
an unnecessary ternary operator)
Merging i3c/i3c/next (574ca75f8d29 i3c: Explicitly include correct DT inclu=
des)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (d3c83a2fefc0 hwmon: (nct6775) Additional =
TEMP registers for nct6799)
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
Merging net-next/main (c35e927cbe09 net: omit ndo_hwtstamp_get() call when =
possible in dev_set_hwtstamp_phylib())
Merging bpf-next/for-next (1e8e2efb3402 bpf: change bpf_alu_sign_string and=
 bpf_movsx_string to static)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/main (f5fbd3246c06 Merge branch '100GbE' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/tnguy/nex t-queue)
Merging ipvs-next/main (2303fae13064 net: skbuff: remove unused HAVE_HW_TIM=
E_STAMP feature define)
Merging bluetooth/master (581a9cf0ee75 Bluetooth: hci_conn: Fix hci_le_set_=
cig_params)
CONFLICT (content): Merge conflict in net/bluetooth/hci_core.c
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
Merging crypto/master (b9a281f1f72b hwrng: xgene: Add explicit io.h include)
Merging drm/drm-next (3d00c59d1477 Merge tag 'amd-drm-next-6.6-2023-07-28' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_debug.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n314/dcn314_fpu.c
Merging drm-misc/for-linux-next (82d750e9d2f5 drm/nouveau: debugfs: impleme=
nt DRM GPU VA debugfs)
$ git reset --hard HEAD^
Merging next-20230804 version of drm-misc
Merging amdgpu/drm-next (7ea1db28119e drm/radeon: Prefer strscpy over strlc=
py calls in radeon_atombios.c)
Merging drm-intel/for-linux-next (26e60294e8ea drm/i915/sdvo: fix panel_typ=
e initialization)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/selftests/mock_g=
em_device.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (cd036d542afb drm/msm/a6xx: Add A610 speedbin supp=
ort)
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
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
Merging sound/for-next (d700a1163350 Merge branch 'topic/intel-hda' into fo=
r-next)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (e3ac810f5c0c Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (a6846234f458 ARM: module: Use module_init_lay=
out_section() to spot init sections)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (0b8bc1a9b566 Merge branch 'for-6.6/block' into for-=
next)
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
Merging regulator/for-next (31ccb3ef2529 Merge remote-tracking branch 'regu=
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
Merging selinux/next (c50e125d0571 selinux: avoid implicit conversions in s=
ervices code)
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (7b9ef666f27a tomoyo: refactor deprecated strncpy)
Merging tpmdd/next (7cd8126c2e6b tpm: Disable RNG for all AMD fTPMs)
Merging watchdog/master (fdf0eaf11452 Linux 6.5-rc2)
Merging iommu/next (a5003e75a171 Merge branches 'iommu/fixes', 'arm/rockchi=
p', 'x86/amd' and 'core' into next)
Merging audit/next (bf98354280bf audit: correct audit_filter_inodes() defin=
ition)
Merging devicetree/for-next (66a4210bc82e of: Move of_device_{add,register,=
unregister} to platform.c)
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (120f54bdb883 Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (5a9c45c016fc Merge branch into tip/master: 'x86/mm')
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
Merging percpu/for-next (abf773b6fafc Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (2ef92cb3bc82 Merge branch 'for-6.5-fixes' into=
 for-next)
Merging drivers-x86/for-next (9204fc5071bf platform/x86: hp-bioscfg: MAINTA=
INERS)
Merging chrome-platform/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging chrome-platform-firmware/for-firmware-next (0979e7e3cfd7 MAINTAINER=
S: Add drivers/firmware/google/ entry)
Merging hsi/for-next (7ebf243a2018 hsi: omap_ssi: Explicitly include correc=
t DT includes)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7a2b85a76b05 leds: simatic-ipc-leds-gpio: Fi=
x comment style in SPDX header)
Merging ipmi/for-next (b02bb79eee07 ipmi: fix potential deadlock on &kcs_bm=
c->lock)
Merging driver-core/driver-core-next (0ce7c12e88cf kernfs: attach uuid for =
every kernfs and report it in fsid)
Merging usb/usb-next (d9216d3ef538 usb: dwc3: dwc3-octeon: Add SPDX header =
and copyright)
Merging thunderbolt/next (6dacc6db4628 thunderbolt: Set variable tmu_params=
 storage class specifier to static)
Merging usb-serial/usb-next (974e2f6a0554 USB: serial: xr: add TIOCGRS485 a=
nd TIOCSRS485 ioctls)
Merging tty/tty-next (593135f09368 8250_men_mcb: remove unnecessary cast wh=
en reading register)
Merging char-misc/char-misc-next (abe8ff435fb6 firmware: stratix10-rsu: que=
ry spt addresses)
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (28a03fae6e52 coresight: dummy: simplify the code wi=
th module_platform_driver)
Merging fastrpc/for-next (64227235abd9 misc: fastrpc: Pass proper scm argum=
ents for static process init)
Merging fpga/for-next (3969f6458f78 fpga: add configuration for the FPGA KU=
nit test suites.)
Merging icc/icc-next (768c42cd9acb Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (6d9c5ae6a70c dt-bindings: iio: admv1014: make all regs =
required)
Merging phy-next/next (e7379477f447 phy: starfive: StarFive PHYs should dep=
end on ARCH_STARFIVE)
Merging soundwire/next (3f92da3ea448 soundwire: Explicitly include correct =
DT includes)
Merging extcon/extcon-next (d20a3a8a32e3 extcon: cht_wc: add POWER_SUPPLY d=
ependency)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (73e2f19da508 kvm/vfio: avoid bouncing the mutex when add=
ing and deleting groups)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (1422b526fba9 staging: rtl8712: fix race condi=
tion)
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
Merging kunit-next/kunit (1c9fd080dffe kunit: fix uninitialized variables b=
ug in attributes filtering)
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
Merging hyperv/hyperv-next (3a5274c555c2 x86/hyperv: Add hyperv-specific ha=
ndling for VMMCALL under SEV-ES)
$ git reset --hard HEAD^
Merging next-20230804 version of hyperv
Merging auxdisplay/auxdisplay (def85dce1451 auxdisplay: Switch i2c drivers =
back to use .probe())
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (06c2afb862f9 Linux 6.5-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (efe47a18e43f bus: mhi: host: allow MHI client drivers=
 to provide the firmware via a pointer)
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

--Sig_/bpR95KNlbkW/5UhuGA5m7ON
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQhYMACgkQAVBC80lX
0GyV7wf+IHBR9UkYBoiJhJil/8H/XoWtQndCwgRte8uXYcLhx/C1D/oyoWeSA/+f
DwbyGzDHQ5WOZSifO55e4DaJ8Ad9+eFF50Dt3dMWp1i6LTYpqoZ7FhFLGg2cc7F5
deAAarOYq372WmDmzmQOcYENQz+adXV5GFNCAQ2OagIfq+G2gz+MMoMYPG6tTGOv
DgXmuVILWv4rpCou70RXbYY0M1eHc0xM9oSSlDbPvJKfIsMf2PIxQsxcBVTr0yZN
8k8Kre+F4RHhkePa+rd8y89KjRZDWkxV07GVfx4S0WXFSO04573QQeeYZtsXHB9p
9eT3Y8skqh0qvuXCnb7cv5WoALbzMw==
=5yON
-----END PGP SIGNATURE-----

--Sig_/bpR95KNlbkW/5UhuGA5m7ON--
