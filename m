Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E7809A54
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573067AbjLHDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjLHD37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:29:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA6D1716;
        Thu,  7 Dec 2023 19:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702006201;
        bh=VZRnR9IbPL5r3l9+WYFv2EXmYSIzCoCYKl2+3O1Up7k=;
        h=Date:From:To:Cc:Subject:From;
        b=CUSU1XL/JOxAHMeEkVhndv31/xXypOxqo+w0gIFrTn9x7AqVXB6ci0PVwKKuW7qTK
         e+DEnK/pCWglW+J+pJcXEm5SxcQ0Q1hTRRZGZojhOffc4t091V/HCxHqSlHJRTVyQ5
         rWUkyAMpharl8/QEemp/rUHPDrykPE5uipG7xxeWtcxtABeNYZoimYCls9+1yrchsr
         L2jRA6iinMNYwvRSBNw3j8kM2Vh4mKQhqMeXebydPWTDD/KODyvN13M3c9xuxY7Z1j
         oqEB2S5ncgzh6SP/5xXqyZ1TyIsbazkafCXynrh7tUBzHyEXl6VpQwacdt/WnciNwn
         7K/u3jxsfqWug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Smc8T0yWHz4wbn;
        Fri,  8 Dec 2023 14:30:01 +1100 (AEDT)
Date:   Fri, 8 Dec 2023 14:30:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 8
Message-ID: <20231208143000.31a63f1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ISN.fZF4RUE+ffnD1OVcBK/";
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

--Sig_/ISN.fZF4RUE+ffnD1OVcBK/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231207:

The cgroup tree lost its build failure.

The devicetree tree lost all but one of its build failures for which I
have applied a merge fix patch.

Non-merge commits (relative to Linus' tree): 5431
 5796 files changed, 221966 insertions(+), 164005 deletions(-)

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

I am currently merging 370 trees (counting Linus' and 105 trees of bug
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
Merging origin/master (9ace34a8e446 Merge tag 'cgroup-for-6.7-rc4-fixes' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (98c985984f88 kexec: select CRYPTO=
 from KEXEC_FILE instead of depending on it)
Merging kbuild-current/fixes (98b1cc82c4af Linux 6.7-rc2)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (f5259997f3e8 arm64: Avoid enabling KPTI=
 unnecessarily)
Merging arm-soc-fixes/arm/fixes (b0b2981c49ff Merge tag 'ffa-fixes-6.7' of =
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/f=
ixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (03191fb3db3d m68k: lib: Include <linux/libg=
cc.h> for __muldi3())
Merging powerpc-fixes/fixes (4b3338aaa74d powerpc/ftrace: Fix stack teardow=
n in ftrace_no_trace)
Merging s390-fixes/fixes (aab1f809d754 scripts/checkstack.pl: match all sta=
ck sizes for s390)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (b0a930e8d90c vsock/virtio: fix "comparison of distinct po=
inter types lacks a cast" warning)
Merging bpf/master (1499b89289bf net: dsa: microchip: provide a list of val=
id protocols for xmit handler)
Merging ipsec/master (76df934c6d5f MAINTAINERS: Add netdev subsystem profil=
e link)
Merging netfilter/main (7ae836a3d630 netfilter: xt_owner: Fix for unsafe ac=
cess of sk->sk_socket)
Merging ipvs/main (54d4434da824 Merge branch 'hv_netvsc-fix-race-of-netvsc-=
vf-register-and-slave-bit')
Merging wireless/for-next (91fdb30ddfdb net: libwx: fix memory leak on msix=
 entry)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (e3e82fcb79ee RDMA/irdma: Avoid free the non-cqp_=
request scratch)
Merging sound-current/for-linus (634e5e1e06f5 ALSA: hda/realtek: Add quirk =
for Lenovo Yoga Pro 7)
Merging sound-asoc-fixes/for-linus (a0ffa8115e1e ASoC: cs35l45: Prevents sp=
inning during runtime suspend)
Merging regmap-fixes/for-linus (fea88064445a regmap: fix bogus error on reg=
cache_sync success)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (7a733e060bd2 spi: cadence: revert "Add SPI tra=
nsfer delays")
Merging pci-current/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging driver-core.current/driver-core-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty.current/tty-linus (e92fad024929 serial: 8250_dw: Add ACPI ID fo=
r Granite Rapids-D UART)
Merging usb.current/usb-linus (61890dc28f7d usb: gadget: f_hid: fix report =
descriptor allocation)
Merging usb-serial-fixes/usb-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging phy/fixes (2a9c713825b3 phy: sunplus: return negative error code in=
 sp_usb_phy_probe)
Merging staging.current/staging-linus (98b1cc82c4af Linux 6.7-rc2)
Merging iio-fixes/fixes-togreg (408d4b33c244 iio: adc: MCP3564: fix hardwar=
e identification logic)
Merging counter-current/counter-current (58720809f527 Linux 6.6-rc6)
Merging char-misc.current/char-misc-linus (b7c1e53751cb nvmem: Do not expec=
t fixed layouts to grab a layout driver)
Merging soundwire-fixes/fixes (393cae5f32d6 soundwire: intel_ace2x: fix AC =
timing setting for ACE2.x)
Merging thunderbolt-fixes/fixes (ac43c9122e42 thunderbolt: Fix memory leak =
in margining_port_remove())
Merging input-current/for-linus (42b8ff477202 Input: amimouse - convert to =
platform remove callback returning void)
Merging crypto-current/master (9aedd10fe384 crypto: ahash - Set using_shash=
 for cloned ahash wrapper over shash)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (54bed6bafa0f dmaengine: stm32-dma: avoid bit=
field overflow assertion)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (7c1b1906229d mtd: spinand: gigadevice: Fix the=
 get ecc status issue)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (32138be394e5 Merge tag 'media-renesas-fixes-20=
231113' of git://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.gi=
t)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (a58a173444a6 MIPS: kernel: Clear FPU states =
when setting up kernel threads)
Merging at91-fixes/at91-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging omap-fixes/fixes (c72b9c33ef96 ARM: OMAP2+: Fix null pointer derefe=
rence and memory leak in omap_soc_device_init)
Merging kvm-fixes/master (ffc253263a13 Linux 6.6)
Merging kvms390-fixes/master (27072b8e18a7 KVM: s390/mm: Properly reset no-=
dat)
Merging hwmon-fixes/hwmon (35fe2ad259a3 hwmon: (nzxt-kraken2) Fix error han=
dling path in kraken2_probe())
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (8f61d48c83f6 tools/testing/cxl: Slow down the mock=
 firmware transfer)
Merging btrfs-fixes/next-fixes (cdec1b57f10a Merge branch 'misc-6.7' into n=
ext-fixes)
Merging vfs-fixes/fixes (dc32464a5fe4 ceph_wait_on_conflict_unlink(): grab =
reference before dropping ->d_lock)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (3494a594315b platform/mellanox: Check devm=
_hwmon_device_register_with_groups() return value)
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (136c6531ba12 dt-bindings: display: adi,a=
dv75xx: Document #sound-dai-cells)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (235f2b548d7f scsi: be2iscsi: Fix a memleak in bei=
scsi_init_wrb_handle())
Merging drm-fixes/drm-fixes (33924328498e Merge tag 'drm-intel-fixes-2023-1=
2-01-1' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (9f269070abe9 drm/i915: correc=
t the input parameter on _intel_dsb_commit())
Merging mmc-fixes/fixes (1036f69e2513 mmc: core: Cancel delayed work before=
 releasing host)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (98b1cc82c4af Linux 6.7-rc2)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (ed5b7cfd7839 riscv: errata: andes: Probe for IO=
CP only once in boot stage)
Merging riscv-dt-fixes/riscv-dt-fixes (79997eda0d31 riscv: dts: microchip: =
move timebase-frequency to mpfs.dtsi)
Merging riscv-soc-fixes/riscv-soc-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging gpio-brgl-fixes/gpio/for-current (95dd1e34ff5b gpiolib: sysfs: Fix =
error handling on failed export)
Merging gpio-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging erofs-fixes/fixes (62b241efff99 MAINTAINERS: erofs: add EROFS webpa=
ge)
Merging kunit-fixes/kunit-fixes (1bddcf77ce66 kunit: test: Avoid cast warni=
ng when adding kfree() as an action)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (bf51c52a1f3c NFSD: Fix checksum mismatches i=
n the duplicate reply cache)
Merging irqchip-fixes/irq/irqchip-fixes (b673fe1a6229 MAINTAINERS: Remove m=
yself from the general IRQ subsystem maintenance)
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (b16937474874 perf list: Fix JSON segfault =
by setting the used skip_duplicate_pmus callback)
Merging efi-fixes/urgent (01b1e3ca0e5c efi/unaccepted: Fix off-by-one when =
checking for overlapping ranges)
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
Merging overlayfs-fixes/ovl-fixes (37f32f526438 ovl: fix memory leak in ovl=
_parse_param())
Merging drm-misc-fixes/for-linux-next-fixes (5a6c9a05e55c drm: Fix FD owner=
ship check in drm_master_check_perm())
Merging mm-stable/mm-stable (33cc938e65a9 Linux 6.7-rc4)
Merging mm-nonmm-stable/mm-nonmm-stable (33cc938e65a9 Linux 6.7-rc4)
Merging mm/mm-everything (7ce92f1b1538 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (6262afa10ef7 kconfig: default to zero if int/hex s=
ymbol lacks default property)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (01261d8a0f08 perf thread: Add missing RC_CHK_=
EQUAL)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (53c87e846e33 swiotlb: fix out-of-bounds TLB a=
llocations with CONFIG_SWIOTLB_DYNAMIC)
Merging asm-generic/master (d6e81532b10d Hexagon: Make pfn accessors static=
s inlines)
CONFLICT (content): Merge conflict in arch/mips/include/asm/traps.h
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (f1ff4ced177d Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (c98dade03b8a Merge branches 'for-next/fixes', =
'for-next/cpufeature', 'for-next/kbuild', 'for-next/misc', 'for-next/mm', '=
for-next/perf' and 'for-next/rip-vpipt' into for-next/core)
Merging arm-perf/for-next/perf (46fe448ec3b7 perf: fsl_imx8_ddr: Add driver=
 support for i.MX8DXL DDR Perf)
Merging arm-soc/for-next (5c69f40cff48 soc: document merges)
Merging amlogic/for-next (093098370b46 Merge branch 'v6.8/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (ecab6c95f79b ARM: dts: aspeed: asrock: Add ASRock =
X570D4U BMC)
Merging at91/at91-next (b766b70117ac Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (4a23d0f9814c memory: tegra: Protect SID ov=
erride call under CONFIG_IOMMU_API)
Merging imx-mxs/for-next (8c3c7094bf5b Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (93e6b023e552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (0ea5e8402a47 Merge branches 'omap-for-v6.8/dt', 'oma=
p-for-v6.8/defconfig' and 'omap-for-v6.8/maintainers' into for-next)
Merging qcom/for-next (adcad44bd1c7 Merge branches 'arm32-for-6.8', 'arm64-=
for-6.8', 'clk-for-6.8', 'drivers-fixes-for-6.7' and 'drivers-for-6.8' into=
 for-next)
Merging renesas/next (a89ef75a0104 Merge branch 'renesas-dts-for-v6.8' into=
 renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (52e1d2603e7d Merge branch 'v6.8-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (91180a4ad659 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (d6c1868380d1 Merge branch 'for-next/scmi/updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging stm32/stm32-next (9a7308232a11 ARM: dts: stm32: add SPI support on =
STM32F746)
Merging sunxi/sunxi/for-next (715a9e70bdd4 Merge branch 'sunxi/clk-for-6.8'=
 into sunxi/for-next)
Merging tee/next (b6e275057b25 Merge branch 'kern_priv_shm_for_v6.8' into n=
ext)
Merging tegra/for-next (650220c2b474 Merge branch for-6.7/arm64/dt into for=
-next)
Merging ti/ti-next (362622bfcf48 Merge branches 'ti-k3-dts-next' and 'ti-dr=
ivers-soc-next' into ti-next)
Merging xilinx/for-next (1d4723dec415 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (78140324e480 Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (144f1b70ea9e dt-bindings: clock: support i.MX93 A=
NATOP clock module)
Merging clk-renesas/renesas-clk (5f9e29b9159a clk: renesas: rzg2l-cpg: Reus=
e code in rzg2l_cpg_reset())
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (27dd0d2870c4 LoongArch: BPF: Fix uncondit=
ional bswap instructions)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (33cc938e65a9 Linux 6.7-rc4)
Merging microblaze/next (ffb0399437ef microblaze: defconfig: Enable the Mar=
vell phy driver)
Merging mips/mips-next (33cc938e65a9 Linux 6.7-rc4)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (33cc938e65a9 Linux 6.7-rc4)
Merging powerpc/next (27951e1d8274 powerpc/pseries/memhp: Log more error co=
nditions in add path)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging riscv-dt/riscv-dt-for-next (0678df827182 riscv: dts: microchip: add=
 the mpfs' system controller qspi & associated flash)
CONFLICT (content): Merge conflict in arch/riscv/boot/dts/sophgo/cv1800b.dt=
si
Applying: fixup for "riscv: dts: sophgo: Separate compatible specific for C=
V1800B soc"
Merging riscv-soc/riscv-soc-for-next (d06e9ec2adc4 Merge branch 'riscv-soc-=
drivers-for-next' into riscv-soc-for-next)
Merging s390/for-next (99babaaa23b2 Merge branch 'features' into for-next)
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (791beae7335c xtensa: Use PCI_HEADER_TYPE_MF=
D instead of literal)
Merging bcachefs/for-next (79995d0cfcc8 bcachefs: Improve error message whe=
n finding wrong btree node)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (33cc938e65a9 Linux 6.7-rc4)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (4f96fbafeb31 Merge branch 'for-next-next-v6.7-20231=
206' into for-next-20231206)
Merging ceph/master (d30d7c57a64d ceph: select FS_ENCRYPTION_ALGS if FS_ENC=
RYPTION)
Merging cifs/for-next (04909192ada3 cifs: reconnect worker should take refe=
rence on server struct unconditionally)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (06dc62fb1936 erofs: enable sub-page compressed block sup=
port)
Merging exfat/dev (19a481032091 exfat: using hweight instead of internal lo=
gic)
Merging ext3/for_next (301846bb8c88 Merge fanotify fsid changes from Amir.)
Merging ext4/dev (619f75dae2cf ext4: fix warning in ext4_dio_write_end_io())
Merging f2fs/dev (d346fa09abff f2fs: sysfs: support discard_io_aware)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (9fd6b6bdb5a4 gfs2: rgrp: fix kernel-doc warnings)
Merging jfs/jfs-next (cca974daeb6c jfs: fix shift-out-of-bounds in dbJoin)
Merging ksmbd/ksmbd-for-next (67ad3444166b ksmbd: fix wrong name of SMB2_CR=
EATE_ALLOCATION_SIZE)
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (1001cf6ba276 svcrdma: Update some svcrdma DMA-relat=
ed tracepoints)
Merging ntfs3/master (652483bfbc45 fs/ntfs3: Fix c/mtime typo)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (2c3ef4f89ced ovl: initialize ovl_copy_up_=
ctx.destname inside ovl_do_copy_up())
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (69cc23eb3a0b net: 9p: avoid freeing uninit memory in =
p9pdu_vreadf)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (9c235dfc3d3f xfs: dquot recovery does not validate th=
e recovered dquot)
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
Merging vfs-brauner/vfs.all (eeadfb967a72 Merge branch 'vfs.iov_iter' into =
vfs.all)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/subpage.c
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in include/linux/blk_types.h
Applying: linux-next: manual merge of the vfs-brauner tree with the btrfs t=
ree
Merging vfs/for-next (bbe6a7c899e7 bch2_ioctl_subvolume_destroy(): fix lock=
ing)
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (b8d0cad57d3f Merge branch 'pci/switchtec')
Merging pstore/for-next/pstore (5281ff48b192 Merge branch 'for-linus/pstore=
' into for-next/pstore)
Merging hid/for-next (dddc7049b9da Merge branch 'for-6.8/selftests' into fo=
r-next)
Merging i2c/i2c/for-next (382561d16854 i2c: ocores: Move system PM hooks to=
 the NOIRQ phase)
Merging i3c/i3c/next (b4da37db3e2c i3c: master: Fix build error)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (7f722bd0c777 dt-bindings: hwmon: Increase=
 max number of io-channels)
Merging jc_docs/docs-next (d254d263f6c8 docs: submitting-patches: improve t=
he base commit explanation)
Merging v4l-dvb/master (a00b3f296eac media: mediatek: vcodec: Set the suppo=
rted vp9 profile for each platform)
Merging v4l-dvb-next/master (3b8551e73271 media: wave5: add OF and V4L_MEM2=
MEM_DRIVERS dependencies)
Merging pm/linux-next (169769cb3761 Merge branch 'acpi-utils-fix' into linu=
x-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c4a5118a3ae1 cpufreq: scmi: pro=
cess the result of devm_of_clk_add_hw_provider())
Merging cpupower/cpupower (997bbf2accf6 tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (4920ee6dcfaf PM / devfreq: Convert to use sys=
fs_emit_at() API)
Merging pmdomain/next (833811353f70 pmdomain: xilinx/zynqmp: Convert to pla=
tform remove callback returning void)
Merging opp/opp/linux-next (19cc8b1819a4 OPP: Check for invalid OPP in dev_=
pm_opp_find_level_ceil())
Merging thermal/thermal/linux-next (9618efe343ea thermal/qcom/tsens: Drop o=
ps_v0_1)
Merging dlm/next (0c08699744d2 dlm: implement EXPORT_OP_ASYNC_LOCK)
Merging rdma/for-next (b7a2768a1cc3 RDMA/siw: Call orq_get_current if possi=
ble)
Merging net-next/main (87e839c82cc3 net: wangxun: fix changing mac failed w=
hen running)
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/d=
wmac5.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/d=
wmac5.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/d=
wxgmac2_core.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/h=
wif.h
Merging bpf-next/for-next (483af466e4ee Merge branch 'bpf-fix-verification-=
of-indirect-var-off-stack-access')
Merging ipsec-next/master (aadbd27f9674 net: phy: correctly check soft_rese=
t ret ONLY if defined for PHY)
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
Merging netfilter-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_la=
rge and use it in rtnl_getlink)
Merging ipvs-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_large a=
nd use it in rtnl_getlink)
Merging bluetooth/master (b640347284c0 Bluetooth: Fix bogus check for re-au=
th no supported with non-ssp)
Merging wireless-next/for-next (db7fac15eaf0 wifi: rtw89: mac: refine SER s=
etting during WiFi CPU power on)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (b85ea95d0864 Linux 6.7-rc1)
Merging nand/nand/next (3c8260ce7663 mtd: rawnand: brcmnand: exec_op implem=
entation)
Merging spi-nor/spi-nor/next (c692ba6de1c5 mtd: spi-nor: micron-st: Add sup=
port for mt25qu01g)
Merging crypto/master (ce852f1308ac crypto: sa2ul - Return crypto_aead_setk=
ey to transfer the error)
Merging drm/drm-next (5edfd7d94b03 Merge tag 'amd-drm-next-6.8-2023-12-01' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (67a5f0ff3429 drm/edp-panel: Move the KDC p=
anel to a separate group)
Merging amdgpu/drm-next (47c4533543af drm/amdgpu: Enable event log on MES 1=
1)
Merging drm-intel/for-linux-next (10690b8a49bc drm/i915/display: Add intel_=
fb_bo_framebuffer_fini)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (07e6de738aa6 drm/msm/a690: Fix reg values for a69=
0)
Merging drm-msm-lumag/msm-next-lumag (e843ca2f30e6 drm/msm/dpu: correct clk=
 bit for WB2 block)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (64a1aed0aa07 fbdev: mmp: Fix typo and wording in co=
de comment)
Merging regmap/for-next (a2d43f711790 Merge remote-tracking branch 'regmap/=
for-6.8' into regmap-next)
Merging sound/for-next (1ccffc2f760a ASoC: SOF: Intel: pci-mtl: add HDA_ARL=
 PCI support)
Merging ieee1394/for-next (c12d7aa7ffa4 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (2c91a4616c10 Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-next)
Merging modules/modules-next (4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging input/next (3717194f2492 Input: gpio-keys - add system suspend supp=
ort for dedicated wakeirqs)
Merging block/for-next (2932169948e5 Merge branch 'for-6.8/io_uring' into f=
or-next)
Merging device-mapper/for-next (e842b578396b dm-integrity: don't modify bio=
's immutable bio_vec in integrity_metadata())
Merging libata/for-next (804901fdd637 ata: pata_pxa: convert not to use dma=
_request_slave_channel())
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (72cd89517fa0 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (7bb6a356ed63 dt-bindings: mfd: pm8008: Clean up e=
xample node names)
Merging backlight/for-backlight-next (769ff5283f0d backlight: ili922x: Add =
an error code check in ili922x_write())
Merging battery/for-next (b55d073e6501 power: supply: bq256xx: fix some pro=
blem in bq256xx_hw_init)
Merging regulator/for-next (16e5ac127d8d regulator: event: Add regulator ne=
tlink event support)
Merging security/next (ec4e9d630a64 calipso: fix memory leak in netlbl_cali=
pso_add_pass())
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
Merging integrity/next-integrity (b836c4d29f27 ima: detect changes to the b=
acking overlay file)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (3c1e09d533db selinux: remove the wrong comment about =
multithreaded process handling)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (c2d5304e6c64 Merge tag 'platform-drivers-x86-v6.7-2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86)
Merging watchdog/master (b85ea95d0864 Linux 6.7-rc1)
Merging iommu/next (263219b72e28 Merge branches 'iommu/fixes', 'apple/dart'=
, 'virtio', 'x86/amd' and 'core' into next)
Merging audit/next (24fade412acf Automated merge of 'dev' into 'next')
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (96cb7a4e296d dt-bindings: mailbox: qcom-ipcc: doc=
ument the SM8650 Inter-Processor Communication Controller)
Merging spi/for-next (227a1530aa8a Merge remote-tracking branch 'spi/for-6.=
8' into spi-next)
Merging tip/master (e88255c7a26a Merge branch into tip/master: 'x86/percpu')
Merging clockevents/timers/drivers/next (d25e52a7eb36 clocksource/drivers/c=
adence-ttc: Fix some kernel-doc warnings)
Merging edac/edac-for-next (a69badad736c EDAC, pnd2: Sort headers alphabeti=
cally)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (e1742fa172d5 Merge probes/for-next)
Merging rcu/rcu/next (e50e0836738d Merge tag 'rcu-next-v6.8' of ../neeraj-l=
inux into HEAD)
Merging kvm/next (e9e60c82fe39 selftests/kvm: fix compilation on non-x86_64=
 platforms)
CONFLICT (content): Merge conflict in include/linux/pagemap.h
Applying: fs: Convert error_remove_page to error_remove_folio
Applying: fix up for "KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-spe=
cific backing memory"
Merging kvm-arm/next (307c5436c3f4 Merge branch kvm-arm64/lpa2 into kvmarm-=
master/next)
Merging kvms390/next (26fb87ffa9d9 s390/uvdevice: Report additional-data le=
ngth for attestation)
Merging kvm-ppc/topic/ppc-kvm (98b1cc82c4af Linux 6.7-rc2)
Merging kvm-riscv/riscv_kvm_next (d9c00f44e5de KVM: riscv: selftests: Add S=
BI DBCN extension to get-reg-list test)
Merging kvm-x86/next (1ab097653e4d Merge branches 'fixes', 'generic', 'hype=
rv', 'lam', 'misc', 'mmu', 'pmu', 'selftests' and 'svm')
Merging xen-tip/linux-next (7f3da4b698bc xen/events: fix error code in xen_=
bind_pirq_msi_to_irq())
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (4a6c5607d450 workqueue: Make sure that wq_unbo=
und_cpumask is never empty)
Merging drivers-x86/for-next (3799b5d2323d platform/x86: asus-laptop: remov=
e redundant braces in if statements)
CONFLICT (content): Merge conflict in drivers/platform/x86/wmi.c
Merging chrome-platform/for-next (d131f1f3b459 platform/chrome: sensorhub: =
Implement quickselect for median calculation)
Merging chrome-platform-firmware/for-firmware-next (ecea08916418 firmware: =
coreboot: framebuffer: Avoid invalid zero physical address)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (430545cd13d0 leds: gpio: Add kernel log if d=
evm_fwnode_gpiod_get() fails)
Merging ipmi/for-next (c5d03a0d8461 ipmi: Use regspacings passed as a modul=
e parameter)
Merging driver-core/driver-core-next (00bf46412010 riscv: convert to use ar=
ch_cpu_is_hotpluggable())
Merging usb/usb-next (522c35e08b53 ARM: dts: bcm2711: Add BCM2711 xHCI supp=
ort)
Merging thunderbolt/next (655b8af57d31 thunderbolt: Remove duplicated re-as=
signment of pointer 'out')
Merging usb-serial/usb-next (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty/tty-next (d804987153e7 serial: 8250_dw: Decouple DLF register c=
heck from UCV)
Merging char-misc/char-misc-next (96d1d578dec1 android: binder: fix a kerne=
l-doc enum warning)
CONFLICT (content): Merge conflict in drivers/android/binder_alloc.c
Merging accel/habanalabs-next (dfbf6719ccb4 accel/habanalabs/gaudi2: avoid =
overriding existing undefined opcode data)
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging fpga/for-next (5496fb8eedd6 drivers/fpga: use standard array-copy f=
unction)
Merging icc/icc-next (9d0f61b0aab1 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (9f4e9ffee974 iio: light: pa1203001: Drop ACPI_PTR() pro=
tection.)
Merging phy-next/next (7f6f9e0def00 phy: qcom-qmp-usb: Add Qualcomm SDX75 U=
SB3 PHY support)
Merging soundwire/next (55d50ace6b88 soundwire: generic_bandwidth_allocatio=
n use bus->params.max_dr_freq)
Merging extcon/extcon-next (d03a7005d968 extcon: usbc-tusb320: Set interrup=
t polarity based on device-tree)
Merging gnss/gnss-next (98b1cc82c4af Linux 6.7-rc2)
Merging vfio/next (946cff255dfa Merge branches 'v6.8/vfio/debugfs', 'v6.8/v=
fio/pds' and 'v6.8/vfio/type1-account' into v6.8/vfio/next)
Merging w1/for-next (0ca9223fe9f7 w1: gpio: rename pointer to driver data f=
rom pdata to ddata)
Merging spmi/spmi-next (0a080ab6bc28 spmi: mediatek: add device id check)
Merging staging/staging-next (149261d378d0 staging: vc04_services: Do not p=
ass NULL to vchiq_log_error())
Merging counter-next/counter-next (7904cdf1397c counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (306f5df81fcc dmaengine: apple-admac: Keep upper bit=
s of REG_BUS_WIDTH)
Merging cgroup/for-next (b7aaea747923 Merge branch 'for-6.8' into for-next)
Merging scsi/for-next (45d0d7374dce Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (e78e59acfb69 Merge patch series "scsi: Convert t=
o platform remove callback returning" void)
Merging vhost/linux-next (b8e079244992 virtio_blk: fix snprintf truncation =
compiler warning)
Merging rpmsg/for-next (3f978d9889a2 remoteproc: k3-dsp: Convert to platfor=
m remove callback returning void)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (c598dc3bc41e gpio: sim: fix the email addr=
ess in MODULE_AUTHOR())
Merging gpio-intel/for-next (92fc925f8386 gpio: tangier: simplify locking u=
sing cleanup helpers)
Merging pinctrl/for-next (c88c6f2a2502 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6191e49de389 pinctrl: baytrail: Simplify co=
de with cleanup helpers)
Merging pinctrl-renesas/renesas-pinctrl (dc99d4c8ac46 dt-bindings: pinctrl:=
 renesas: Drop unneeded quotes)
Merging pinctrl-samsung/for-next (b77f5ef8ebe4 pinctrl: samsung: add irq_se=
t_affinity() for non wake up external gpio interrupt)
Merging pwm/for-next (6d0589a70587 pwm: Stop referencing pwm->chip)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (130a83879954 selftests: sched: Remove initializatio=
n to 0 for a static variable)
Merging kunit/test (b85ea95d0864 Linux 6.7-rc1)
Merging kunit-next/kunit (c8613be11989 kunit: debugfs: Handle errors from a=
lloc_string_stream())
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (3d762e21d563 rtc: cmos: Use ACPI alarm for non-Intel =
x86 systems too)
Merging nvdimm/libnvdimm-for-next (9ea459e477dc libnvdimm: remove kernel-do=
c warnings:)
Merging at24/at24/for-next (c692086d74a0 dt-bindings: at24: add ROHM BR24G0=
4)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (31c65705a8cf perf/benchmark: fix seccomp_=
unotify benchmark for 32-bit)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
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
Merging mhi/mhi-next (d63ddfb78b23 bus: mhi: ep: Add support for interrupt =
moderation timer)
Merging memblock/for-next (e96c6b8f212a memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (5d09c63f11f0 cxl/hdm: Remove broken error path)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (772043f7ae47 efi/loongarch: Use load address to calculate=
 kernel entry address)
Merging unicode/for-next (807f06d1074d ecryptfs: Reject casefold directory =
inodes)
Merging slab/slab/for-next (f7eb801fcdb1 Merge branch 'slab/for-6.8/slub-ho=
ok-cleanups' into slab/for-next)
CONFLICT (content): Merge conflict in mm/kasan/quarantine.c
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (1c8f324fd1e2 landlock: Document IOCTL support)
Merging rust/rust-next (3857af38e57a docs: rust: add "The Rust experiment" =
section)
Merging sysctl/sysctl-next (5cfe1d126ae3 sysctl: constify standard sysctl t=
ables)
CONFLICT (content): Merge conflict in include/linux/perf_event.h
CONFLICT (content): Merge conflict in ipc/ipc_sysctl.c
CONFLICT (content): Merge conflict in kernel/events/core.c
Applying: fixup for "sysctl: treewide: constify ctl_table_root::permissions"
Merging execve/for-next/execve (0a8a952a75f2 ELF, MAINTAINERS: specifically=
 mention ELF)
Merging bitmap/bitmap-for-next (27c82f14e6d2 lib/find: optimize find_*_bit_=
wrap)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (ac7110d883ff atags_proc: Add __counted_by for s=
truct buffer and use struct_size())
Merging kspp-gustavo/for-next/kspp (617ab3c357d2 init: Kconfig: Disable -Ws=
tringop-overflow for GCC-11)
Merging nolibc/nolibc (b85ea95d0864 Linux 6.7-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (b2b67c997bf7 iommufd: Organize the mock domain al=
loc functions closer to Joerg's tree)
Merging devicetree/for-next (5b6e9b194839 Merge branch 'dt/header-fixes-for=
-next' into for-next)
Applying: amd_axi_w1: include the correct files

--Sig_/ISN.fZF4RUE+ffnD1OVcBK/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVyjbgACgkQAVBC80lX
0GxzgAgAoPxTrhyr0DH2UAGgBCUN0jN8mLdkmjrZvbcgQMUmFeDVvMIIfvs9Y2Bv
Ve1pa4kVzLvn9KR0sW97XouwzUCq6MOAjaAeAGGoYBNrGOWMnHNJIdJV7OnPAxa8
+hwG5/GGL6lxDy4vOPNhjgo6vPvL6mygCgpKDkAMEDD0Z48h5Trd7iPaREQl2YfA
nEvotOf5MyVI6Mh5D8pDRuFLHCn6xlvJ3UOJ76Tt5FuUUbykqXcD21uJsRkIeozY
7p/HnxYYrmPbe5/V+QLj5IbQ9WJI6RQwQNZ0mkxo8EkN1QKQ8vyAXlci03RAurEZ
AY7dCO8tRoht2szhMYYVd5lXKCR8nw==
=nRvi
-----END PGP SIGNATURE-----

--Sig_/ISN.fZF4RUE+ffnD1OVcBK/--
