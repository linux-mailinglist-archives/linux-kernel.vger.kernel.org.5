Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD82768A96
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGaEJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGaEJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:09:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F65E9;
        Sun, 30 Jul 2023 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690776565;
        bh=cwSxk+BpZPfmB+ABCszVMZpRnSIc4AIe/9crandzOZI=;
        h=Date:From:To:Cc:Subject:From;
        b=ehgQE7KMCzcMn8hLlNKaaT6j1ocCQXR+7ifkqOA/yxSb+W5uvjHDU/3EqdZ6xVORk
         fNHZBxXmLdiIgpJ5TDGwS5maZi90oS8mG17XX3Y5BEN1fzS6PkD2Vgr7fMCFEFYqpu
         5IwvJCOkviMLvYHMZFAqCR9pfHpToTSDDtpREO5ISOAqTjEYIyOuVqTrG1ixnIKMr2
         SrEoKNy0nKds7r6EQASVKNzqSlTnOpDEk7RbY93e240nd1RGmT0XCGFf4ubKlmp4R9
         3HO1WBopZVpcsZkqUHs5yMZichWXdciVI4cKzUwbJYX5UOLlf/BTwO30dFcuk1EYq+
         x1rRENLZhUvNw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDl9x1FnKz4wqW;
        Mon, 31 Jul 2023 14:09:25 +1000 (AEST)
Date:   Mon, 31 Jul 2023 14:09:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 31
Message-ID: <20230731140924.5d45b2b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_iYLrVJmEuB5VAKAgL3bK1R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_iYLrVJmEuB5VAKAgL3bK1R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230728:

The s390 tree gained a conflict against the mm tree.

The net-next tree gained conflicts against the net tree.

Non-merge commits (relative to Linus' tree): 5076
 6624 files changed, 184956 insertions(+), 74994 deletions(-)

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
Merging origin/master (5d0c230f1de8 Linux 6.5-rc4)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (2113dd11c80a nilfs2: fix use-afte=
r-free of nilfs_root in dirtying inodes via iput)
Merging kbuild-current/fixes (238353088e9b scripts/kallsyms: Fix build fail=
ure by setting errno before calling getline())
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (003e6b56d780 ACPI/IORT: Remove erroneou=
s id_count check in iort_node_get_rmr_info())
Merging arm-soc-fixes/arm/fixes (92d39d018347 dt-bindings: serial: atmel,at=
91-usart: update compatible for sam9x60)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (faafd6ca7e6e memory: tegra: make icc_se=
t_bw return zero if BWMGR not supported)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (4055eabe04a2 m68k: defconfig: Update defcon=
figs for v6.4-rc1)
Merging powerpc-fixes/fixes (41a506ef71eb powerpc/ftrace: Create a dummy st=
ackframe to fix stack unwind)
Merging s390-fixes/fixes (0c02cc576eac KVM: s390: fix sthyi error handling)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (37e3cecb4cdf Merge branch 'net-data-races')
Merging bpf/master (bcc29b7f5af6 bpf: Add length check for SK_DIAG_BPF_STOR=
AGE_REQ_MAP_FD parsing)
Merging ipsec/master (6018a266279b ip_vti: fix potential slab-use-after-fre=
e in decode_session6)
Merging netfilter/main (5416d7925e6e dt-bindings: net: rockchip-dwmac: fix =
{tx|rx}-delay defaults/range in schema)
Merging ipvs/main (d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout=
 callback)
Merging wireless/for-next (456b5e85d8a5 MAINTAINERS: add Jeff as ath10k, at=
h11k and ath12k maintainer)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (ae463563b7a1 RDMA/irdma: Report correct WC error)
Merging sound-current/for-linus (3b9adfbba5af Merge tag 'asoc-fix-v6.5-rc3'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (006672b2ad59 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (6eaae1980760 Linux 6.5-rc3)
Merging regulator-fixes/for-linus (cf9baae9e4f2 Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (d582427c8914 Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (b607aa1edc9c Revert "PCI: acpiphp: Reassign =
resources on bridge if necessary")
Merging driver-core.current/driver-core-linus (6eaae1980760 Linux 6.5-rc3)
Merging tty.current/tty-linus (748c5ea8b879 serial: 8250_dw: Preserve origi=
nal value of DLF register)
Merging usb.current/usb-linus (7f2327666a90 usb: misc: ehset: fix wrong if =
condition)
Merging usb-serial-fixes/usb-linus (d245aedc0077 USB: serial: simple: sort =
driver entries)
Merging phy/fixes (13c088cf3657 phy: hisilicon: Fix an out of bounds check =
in hisi_inno_phy_probe())
Merging staging.current/staging-linus (5f1c7031e044 staging: ks7010: potent=
ial buffer overflow in ks_wlan_set_encode_ext())
Merging iio-fixes/fixes-togreg (8a4629055ef5 iio: cros_ec: Fix the allocati=
on size for cros_ec_command)
Merging counter-current/counter-current (aead78125a98 tools/counter: Makefi=
le: Replace rmdir by rm to avoid make,clean failure)
Merging char-misc.current/char-misc-linus (f8ea95021022 misc/genalloc: Name=
 subpools by of_node_full_name())
Merging soundwire-fixes/fixes (7891d0a5ce6f soundwire: amd: Fix a check for=
 errors in probe())
Merging thunderbolt-fixes/fixes (6995e2de6891 Linux 6.4)
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
Merging dmaengine-fixes/fixes (d2a257684758 dmaengine: mcf-edma: Fix a pote=
ntial un-allocated memory access)
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
Merging cxl-fixes/fixes (c4b53e8ad3a7 cxl/region: Remove else after return =
statement)
Merging btrfs-fixes/next-fixes (d3099c02c165 Merge branch 'misc-6.5' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (c21733754cd6 platform/x86: huawei-wmi: Sil=
ence ambient light sensor)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (ffc59c6414f9 dt-bindings: serial: Remove=
 obsolete nxp,lpc1850-uart.txt)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (d4e026534577 scsi: pm80xx: Fix error return code =
in pm8001_pci_probe())
Merging drm-fixes/drm-fixes (9a767faa9477 Merge tag 'drm-msm-fixes-2023-07-=
27' of https://gitlab.freedesktop.org/drm/msm into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (e354f6773311 drm/i915: Fix an=
 error handling path in igt_write_huge())
Merging mmc-fixes/fixes (5def5c1c15bf mmc: sdhci-f-sdh30: Replace with sdhc=
i_pltfm)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (ed0cf84e9cc4 vmbus_testing: fix wrong py=
thon syntax for integer value comparison)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (ab2dbc7acced RISC-V: Don't include Zicsr or Zif=
encei in I from ACPI)
Merging riscv-dt-fixes/riscv-dt-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging gpio-brgl-fixes/gpio/for-current (6eaae1980760 Linux 6.5-rc3)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (fdf0eaf11452 Linux 6.5-rc2)
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
Merging perf-current/perf-tools (98ce8e4a9dcf perf test uprobe_from_differe=
nt_cu: Skip if there is no gcc)
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
Merging rust-fixes/rust-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging v9fs-fixes/fixes/next (e6ab0b914c12 fs/9p: Remove unused extern dec=
laration)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging genpd-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (ee31742bf176 drm/imx/ipuv3: Fi=
x front porch adjustment upon hactive aligning)
Merging mm-stable/mm-stable (6eaae1980760 Linux 6.5-rc3)
Merging mm-nonmm-stable/mm-nonmm-stable (6eaae1980760 Linux 6.5-rc3)
Merging mm/mm-everything (707b8ff4f061 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/memory.c
Merging kbuild/for-next (783c55ae7a95 kbuild: rpm-pkg: skip build dependenc=
y check on non-rpm systems)
Merging clang-format/clang-format (06c2afb862f9 Linux 6.5-rc1)
Merging perf/perf-tools-next (681f34d52b96 perf diff: Replaces some ',' as =
separator with the more usual ';')
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (8ac04063354a swiotlb: reduce the number of ar=
eas to match actual memory pool size)
Merging asm-generic/master (4dd595c34c4b syscalls: Remove file path comment=
s from headers)
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (1faf70485ea9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (6eaae1980760 Linux 6.5-rc3)
Merging arm-perf/for-next/perf (ac18ea1a8935 perf/arm-cmn: Add CMN-700 r3 s=
upport)
Merging arm-soc/for-next (d99c8ba18cb8 Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (76483eaf2109 Merge branch 'v6.6/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (a43f3e970a1d ARM: dts: aspeed: Add AST2600 VUARTs)
Merging at91/at91-next (84c408c841a3 MAINTAINERS: update Claudiu Beznea's e=
mail address)
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
Merging omap/for-next (f581c395fcb8 Merge branches 'omap-for-v6.5/ti-sysc' =
and 'omap-for-v6.5/cleanup' into for-next)
Merging qcom/for-next (ed66e0bbd91a Merge branches 'arm64-defconfig-for-6.6=
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
Merging sunxi/sunxi/for-next (1bcb932283c9 Merge branch 'sunxi/dt-for-6.5' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (77a4cfe28fb8 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (897aebaf0d58 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-dts-next' and 'ti-keystone-next' into ti-next)
Merging xilinx/for-next (54272cb46cb5 Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (335eca6a1c2d Merge branch 'clk-versa' into clk-next)
Merging clk-imx/for-next (2deed4cda3b7 clk: imx: clk-gpr-mux: Simplify .det=
ermine_rate())
Merging clk-renesas/renesas-clk (dec57795efc4 clk: renesas: r8a77965: Add 3=
DGE and ZG support)
Merging csky/linux-next (57427df33d5f csky: fix old style declaration in mo=
dule.c)
Merging loongarch/loongarch-next (54b9a87ddcc9 LoongArch: Allow building wi=
th kcov coverage)
Merging m68k/for-next (922a9bd13810 m68k: Fix invalid .section syntax)
Merging m68knommu/for-next (cdff93a49cc4 m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0e9a2a228a1a microblaze: Explicitly include correc=
t DT includes)
Merging mips/mips-next (f11a99674132 MIPS: Loongson64: Fix more __iomem att=
ributes)
Merging openrisc/for-next (dceaafd66881 openrisc: Union fpcsr and oldmask i=
n sigcontext to unbreak userspace ABI)
Merging parisc-hd/for-next (6995e2de6891 Linux 6.4)
Merging powerpc/next (fdf0eaf11452 Linux 6.5-rc2)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (471aba2e4760 riscv: sigcontext: Correct the commen=
t of sigreturn)
Merging riscv-dt/riscv-dt-for-next (e7c304c0346d riscv: dts: starfive: jh71=
10: add the node and pins configuration for tdm)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (6394d4e92b7c Merge branch 'features' into for-next)
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
Merging ceph/master (588159009d5b rbd: retrieve and check lock owner twice =
before blocklisting)
Merging cifs/for-next (d31e3792919e Merge tag '6.5-rc3-smb3-client-fixes' o=
f git://git.samba.org/sfrench/cifs-2.6)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (68252fd8890e erofs: boost negative xattr lookup with blo=
om filter)
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (eccf9ae28312 Pull patch forbiding superblock / mount=
 marks on internal kernel mounts.)
Merging ext4/dev (9d3de7ee192a ext4: fix rbtree traversal bug in ext4_mb_us=
e_preallocated)
Merging f2fs/dev (10c7134ee440 f2fs: compress: don't {,de}compress non-full=
 cluster)
Merging fsverity/for-next (456ae5fe9b44 fsverity: move sysctl registration =
out of signature.c)
Merging fuse/for-next (6a567e920fd0 fuse: ioctl: translate ENOSYS in outarg)
Merging gfs2/for-next (c6fa6b6c07c8 gfs2: increase usage of folio_next_inde=
x() helper)
Merging jfs/jfs-next (6e2bda2c192d jfs: fix invalid free of JFS_IP(ipimap)-=
>i_imap in diUnmount)
Merging ksmbd/ksmbd-for-next (f40125c0a160 Merge tag '6.5-rc3-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (5b4a82a0724a Revert "NFSv4: Retry LOCK on OLD_STATE=
ID during delegation return")
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (f75bfe7ceaa9 SUNRPC: Reduce thread wake-up rate whe=
n receiving large RPC messages)
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
Merging vfs-brauner/vfs.all (4ce0966ed7c0 Merge branch 'vfs.super' into vfs=
.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (82515ab6aeb3 Merge branch 'rework/misc-cleanups' i=
nto for-next)
Merging pci/next (692860726644 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (438b805003a0 pstore: Replace crypto API com=
pression with zlib_deflate library calls)
Merging hid/for-next (5eb5c80feb93 Merge branch 'for-6.5/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (6537ed3904a3 i2c: mpc: Drop unused variable)
Merging i3c/i3c/next (574ca75f8d29 i3c: Explicitly include correct DT inclu=
des)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (cb7022b8976e hwmon: Add driver for Renesa=
s HS3001)
Merging jc_docs/docs-next (c35211059b77 docs: Integrate rustdoc generation =
into htmldocs)
Merging v4l-dvb/master (06c2afb862f9 Linux 6.5-rc1)
Merging v4l-dvb-next/master (38d6a03d2511 media: go7007: Remove redundant i=
f statement)
Merging pm/linux-next (cbda924b739d Merge branch 'powercap' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (fd459406b99d cpufreq: omap: Con=
vert to platform remove callback returning void)
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
Merging net-next/main (64a37272fa5f team: Remove NULL check before dev_{put=
, hold})
CONFLICT (content): Merge conflict in net/dsa/port.c
CONFLICT (content): Merge conflict in net/xdp/xsk.c
Merging bpf-next/for-next (fb213ecbb8ac docs/bpf: Fix malformed documentati=
on)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/main (f5fbd3246c06 Merge branch '100GbE' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/tnguy/nex t-queue)
Merging ipvs-next/main (2303fae13064 net: skbuff: remove unused HAVE_HW_TIM=
E_STAMP feature define)
Merging bluetooth/master (dd338bea1ff1 Bluetooth: btnxpuart: Add support fo=
r AW693 chipset)
CONFLICT (content): Merge conflict in net/bluetooth/hci_core.c
Merging wireless-next/for-next (b2090d93d4b6 wifi: brcmsmac: remove unused =
data type)
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
Merging drm-misc/for-linux-next (a0c64d153d68 drm: Fix references to drm_pl=
ane_helper_check_state())
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
Merging drm-intel/for-linux-next (14c8fca214a2 drm/i915/color: Downscale de=
gamma lut values read from hardware)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/selftests/mock_g=
em_device.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (cd036d542afb drm/msm/a6xx: Add A610 speedbin supp=
ort)
Merging drm-msm-lumag/msm-next-lumag (be4dacf4eee1 drm/msm/dsi: Reuse QCM22=
90 14nm DSI PHY configuration for SM6125)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (6995e2de6891 Linux 6.4)
Merging regmap/for-next (5d481ddb6a73 regmap: Merge up fixes from Linus' tr=
ee)
Merging sound/for-next (2ad27caab445 ALSA: bcd2000: refactor deprecated str=
ncpy)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (c8fabd88371b Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (4b49df654cd0 samples/hw_breakpoint: mark samp=
le_hbp as static)
Merging input/next (92e24e0e57f7 Input: psmouse - add delay when deactivati=
ng for SMBus mode)
Merging block/for-next (e98acd815ebf Merge branch 'for-6.6/block' into for-=
next)
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (a424eada69fb ata: sata_sil24: fix parameter type o=
f sil24_exec_polled_cmd())
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (e8e2c7b0e695 mmc: davinci: Make SDIO irq truly optional)
Merging mfd/for-mfd-next (b90e33b6116a mfd: wm8998: Update to use maple tre=
e register cache)
Merging backlight/for-backlight-next (a33677b9211b backlight: led_bl: Take =
led_access lock when required)
Merging battery/for-next (af73fd32b4f2 power: reset: oxnas-restart: remove =
obsolete restart driver)
Merging regulator/for-next (1519454ab768 Merge remote-tracking branch 'regu=
lator/for-6.6' into regulator-next)
Merging security/next (faf302f5a213 security: Fix ret values doc for securi=
ty_inode_init_security())
Merging apparmor/apparmor-next (afad53575a93 apparmor: use passed in gfp fl=
ags in aa_alloc_null())
Merging integrity/next-integrity (6eaae1980760 Linux 6.5-rc3)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (f01dd5904519 selinux: move debug functions into debug=
 configuration)
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (a959dbd98d1a tomoyo: add format attributes to functi=
ons)
Merging tpmdd/next (513253f8c293 tpm_tis: Explicitly check for error code)
Merging watchdog/master (fdf0eaf11452 Linux 6.5-rc2)
Merging iommu/next (a5003e75a171 Merge branches 'iommu/fixes', 'arm/rockchi=
p', 'x86/amd' and 'core' into next)
Merging audit/next (bf98354280bf audit: correct audit_filter_inodes() defin=
ition)
Merging devicetree/for-next (e251a4e28a27 dt-bindings: usb: connector: disa=
llow additional properties)
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (e9695c04759b Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (a48c5d5d9822 Merge branch into tip/master: 'x86/mm')
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (c545f5e41225 EDAC/i10nm: Skip the absent memory=
 controllers)
Merging irqchip/irq/irqchip-next (a82f3119d543 Merge branch irq/misc-6.5 in=
to irq/irqchip-next)
Merging ftrace/for-next (61c692f56fec Merge tools/for-next)
Merging rcu/rcu/next (b6736f287910 Revert "checkpatch: Error out if depreca=
ted RCU API used")
Merging kvm/next (5a7591176c47 KVM: selftests: Expand x86's sregs test to c=
over illegal CR0 values)
Merging kvm-arm/next (3b4e3afb2032 Merge branch kvm-arm64/6.6/misc into kvm=
arm-master/next)
Merging kvms390/next (db54dfc9f71c s390/uv: Update query for secret-UVCs)
Merging kvm-riscv/riscv_kvm_next (07f225b58424 RISC-V: KVM: Remove unneeded=
 semicolon)
Merging kvm-x86/next (d406b4578401 Merge branch 'svm')
Merging xen-tip/linux-next (c04e9894846c xen: speed up grant-table reclaim)
Merging percpu/for-next (58a83cc5f904 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (2ef92cb3bc82 Merge branch 'for-6.5-fixes' into=
 for-next)
Merging drivers-x86/for-next (9204fc5071bf platform/x86: hp-bioscfg: MAINTA=
INERS)
Merging chrome-platform/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging chrome-platform-firmware/for-firmware-next (0979e7e3cfd7 MAINTAINER=
S: Add drivers/firmware/google/ entry)
Merging hsi/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7a2b85a76b05 leds: simatic-ipc-leds-gpio: Fi=
x comment style in SPDX header)
Merging ipmi/for-next (b02bb79eee07 ipmi: fix potential deadlock on &kcs_bm=
c->lock)
Merging driver-core/driver-core-next (6eaae1980760 Linux 6.5-rc3)
Merging usb/usb-next (ba0b3af70630 usb: ohci-st: Use devm_platform_get_and_=
ioremap_resource())
Merging thunderbolt/next (481012b479fe thunderbolt: Add test case for 3 Dis=
playPort tunnels)
Merging usb-serial/usb-next (974e2f6a0554 USB: serial: xr: add TIOCGRS485 a=
nd TIOCSRS485 ioctls)
Merging tty/tty-next (9b4e18f032db serial: st-asc: Use devm_platform_get_an=
d_ioremap_resource())
Merging char-misc/char-misc-next (fdf0eaf11452 Linux 6.5-rc2)
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (04e8429c5b4f coresight: Fix all W=3D1 build warning=
s)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (3969f6458f78 fpga: add configuration for the FPGA KU=
nit test suites.)
Merging icc/icc-next (768c42cd9acb Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (1240c94ce819 iio: adc: Explicitly include correct DT in=
cludes)
Merging phy-next/next (e7379477f447 phy: starfive: StarFive PHYs should dep=
end on ARCH_STARFIVE)
Merging soundwire/next (3f92da3ea448 soundwire: Explicitly include correct =
DT includes)
Merging extcon/extcon-next (a635f91c71d9 dt-bindings: extcon: siliconmitus,=
sm5502-muic: document connector)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (094671300fea docs: vfio: Add vfio device cdev descriptio=
n)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (c928e84ce577 Staging: rtl8192e: Rename functi=
on RxTsDeleteBA)
Merging counter-next/counter-next (ba8d5d2b9f39 counter: Declare counter_pr=
iv() to be const)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (1b13e52c0c76 dmaengine: xilinx: dma: remove arch de=
pendency)
Merging cgroup/for-next (a3fdeeb3f1c1 cgroup: fix obsolete comment above cg=
roup_create())
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/.gitig=
nore
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/Makefi=
le
Applying: Revert "cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHE=
D"
Merging scsi/for-next (d82cd15be581 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (a615e93d6cfe scsi: iscsi: Remove unused extern d=
eclaration iscsi_lookup_iface())
Merging vhost/linux-next (373abdba01d4 vdpa_sim: offer VHOST_BACKEND_F_ENAB=
LE_AFTER_DRIVER_OK)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (af2010496de7 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (c456c4d9707a gpio: eic-sprd: remove unneed=
ed platform_set_drvdata() call)
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (173b67f16e13 Merge branch 'devel' into for-next)
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
Merging kunit-next/kunit (e588586675f6 kunit: Add documentation of KUnit te=
st attributes)
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
Merging mhi/mhi-next (d0184830e611 bus: mhi: host: use vmalloc_array and vc=
alloc)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (2e28a798c309 efi/libstub: Disable PCI DMA before grabbing=
 the EFI memory map)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (66489e5487b7 Merge branch 'slab/for-6.6/random_kmall=
oc' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (35ca42399297 selftests/landlock: Add hostfs tests)
Merging rust/rust-next (7c74839b2acc rust: alloc: Add realloc and alloc_zer=
oed to the GlobalAlloc impl)
Merging sysctl/sysctl-next (06c2afb862f9 Linux 6.5-rc1)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (94b154766896 lib: test for_each_numa_cpus())
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (66d882a2adf1 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (6ae3f51825e3 fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (06c2afb862f9 Linux 6.5-rc1)
Merging iommufd/for-next (c157fd886199 vfio: Support IO page table replacem=
ent)
CONFLICT (content): Merge conflict in drivers/iommu/iommufd/device.c
Applying: fix for "iommufd: Move putting a hwpt to a helper function"

--Sig_/_iYLrVJmEuB5VAKAgL3bK1R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTHM/QACgkQAVBC80lX
0GxZWQf+LlYX3bChAHZfdTEsn9TREt0FpeNz4aDRnQSzw01k7/xPdCtoWoBCy9rL
+im6bsymKkaJmtYRKH9T67vfEtebj5fzckA8EvB1Hi1chqHs6Ynx2F03vngVAR3V
syyY8mgymqRiQQMIXEUMmVjtXeSUvMsk0Zt4HzkdCUCfe1syufQ65a/TTMM1l6c+
QlmzyJdJhV2Iq/pjfbKmz45mJCgeJ7zJ6zQR+e50q63NxrXVCscqkZ8kuPw26YP9
gxi1u0ypEb/PcM+9e69d1hX0ZFCKyw8QzhteDx1+qYdHowZxs1pYQORxKSiLT6Hu
uisl62Pv8vLr4Bk+aWdk8OlbqFXZzA==
=0Ph5
-----END PGP SIGNATURE-----

--Sig_/_iYLrVJmEuB5VAKAgL3bK1R--
