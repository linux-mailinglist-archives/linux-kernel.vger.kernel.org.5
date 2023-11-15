Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB57EBAED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjKOB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:28:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D0C9;
        Tue, 14 Nov 2023 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700011675;
        bh=xPVRqEJcVh+sG8Rz8FnirT6Pta8231Z35wV2IVR6koc=;
        h=Date:From:To:Cc:Subject:From;
        b=ZEFxptZ7asBYAJgvNek1NDjPu2bO8c1MQrWEvxzTea5MiFZXUNYXIAXk90OLjXQdJ
         US5AM1JINPpJBo5uxQMFcIVS4ZfWI+eY6O4x5vKPuXh9ILakRx466BsrIn8sMpoo6j
         ZvglMFnMP4cZvewr4V1E1hsZMWQDuJWtJpSobfZGGjLh12x58KNh4ZqUzXuFKkIpMX
         4+hxOVL+fonupnsPzdXGhbJdJJB5pdAKSED/HHNilx/6+6vvXCug8GRP2jlN6jp6gF
         BAEPES+nSEsLdFhOEdGhiSPHiDOZhCb69qjSf1B41eYdKjab9YZwTNdQBntbxMyEa/
         i5y1OHvzLEjQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVQXC2Vc2z4xDB;
        Wed, 15 Nov 2023 12:27:55 +1100 (AEDT)
Date:   Wed, 15 Nov 2023 12:27:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 15
Message-ID: <20231115122752.6b12654a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2EB2oG=wH8ZKwTDoCFK_Ehw";
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

--Sig_/2EB2oG=wH8ZKwTDoCFK_Ehw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231114:

The pinctrl tree lost its build failure.

Non-merge commits (relative to Linus' tree): 1096
 1258 files changed, 40632 insertions(+), 73793 deletions(-)

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

I am currently merging 369 trees (counting Linus' and 105 trees of bug
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
Merging origin/master (9bacdd8996c7 Merge tag 'for-6.7-rc1-tag' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (d5cb258cc385 kexec-fix-kexec_file=
-dependencies-fix)
Merging kbuild-current/fixes (1c41041124bd Merge tag 'i3c/for-6.7' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/i3c/linux)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (2dde18cd1d8f Linux 6.5)
Merging arm64-fixes/for-next/fixes (4785aa802853 cpuidle, ACPI: Evaluate LP=
I arch_flags for broadcast timer)
Merging arm-soc-fixes/arm/fixes (736a4aad8a9f Merge tag 'renesas-fixes-for-=
v6.6-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel into arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (03191fb3db3d m68k: lib: Include <linux/libg=
cc.h> for __muldi3())
Merging powerpc-fixes/fixes (644b6025bcaf powerpc/rtas: Fix ppc_rtas_rmo_bu=
f_show() kernel-doc)
Merging s390-fixes/fixes (ffc253263a13 Linux 6.6)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (4b7b492615cf af_unix: fix use-after-free in unix_stream_r=
ead_actor())
Merging bpf/master (e2e57d637aa5 selftests/bpf: add more test cases for che=
ck_cfg())
Merging ipsec/master (de5724ca38fd xfrm: fix a data-race in xfrm_lookup_wit=
h_ifid())
Merging netfilter/main (80abbe8a8263 netfilter: nat: fix ipv6 nat redirect =
with mapped and scoped addresses)
Merging ipvs/main (a63b6622120c net/sched: act_ct: additional checks for ou=
tdated flows)
Merging wireless/for-next (7a934b5cc3f4 wifi: mt76: mt7921: fix 6GHz disabl=
ed by the missing default CLC config)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (b85ea95d0864 Linux 6.7-rc1)
Merging sound-current/for-linus (713f040cd222 ALSA: hda/realtek - Enable in=
ternal speaker of ASUS K6500ZC)
Merging sound-asoc-fixes/for-linus (37e6fd0cebf0 ASoC: wm8974: Correct boos=
t mixer inputs)
Merging regmap-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging pci-current/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging driver-core.current/driver-core-linus (b85ea95d0864 Linux 6.7-rc1)
Merging tty.current/tty-linus (b85ea95d0864 Linux 6.7-rc1)
Merging usb.current/usb-linus (1a229d8690a0 Revert "usb: phy: add usb phy n=
otify port status API")
Merging usb-serial-fixes/usb-linus (b85ea95d0864 Linux 6.7-rc1)
Merging phy/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging staging.current/staging-linus (b85ea95d0864 Linux 6.7-rc1)
Merging iio-fixes/fixes-togreg (bce3ab29a6c0 iio: common: ms_sensors: ms_se=
nsors_i2c: fix humidity conversion time table)
Merging counter-current/counter-current (58720809f527 Linux 6.6-rc6)
Merging char-misc.current/char-misc-linus (b85ea95d0864 Linux 6.7-rc1)
Merging soundwire-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging thunderbolt-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging input-current/for-linus (cdd5b5a9761f Merge branch 'next' into for-=
linus)
Merging crypto-current/master (9aedd10fe384 crypto: ahash - Set using_shash=
 for cloned ahash wrapper over shash)
Merging vfio-fixes/for-linus (c777b11d34e0 vfio/mdev: Fix a null-ptr-deref =
bug for mdev_unregister_parent())
Merging kselftest-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (7c1b1906229d mtd: spinand: gigadevice: Fix the=
 get ecc status issue)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging at91-fixes/at91-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging omap-fixes/fixes (0b9a4a67c60d clk: ti: Fix missing omap5 mcbsp fun=
ctional clock and aliases)
Merging kvm-fixes/master (ffc253263a13 Linux 6.6)
Merging kvms390-fixes/master (27072b8e18a7 KVM: s390/mm: Properly reset no-=
dat)
Merging hwmon-fixes/hwmon (58ebe7fb6eb2 hwmon: max31827: include regulator =
header)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (8f61d48c83f6 tools/testing/cxl: Slow down the mock=
 firmware transfer)
Merging btrfs-fixes/next-fixes (d3933152442b btrfs: make OWNER_REF_KEY type=
 value smallest among inline refs)
Merging vfs-fixes/fixes (dc32464a5fe4 ceph_wait_on_conflict_unlink(): grab =
reference before dropping ->d_lock)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (8f51593cdcab dt: dt-extract-compatibles:=
 Don't follow symlinks when walking tree)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (097c06394c83 scsi: qla2xxx: Fix double free of ds=
d_list during driver load)
Merging drm-fixes/drm-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging drm-intel-fixes/for-linux-next-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging mmc-fixes/fixes (015c9cbcf0ad mmc: sdhci-pci-gli: GL9750: Mask the =
replay timer timeout of AER)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (b85ea95d0864 Linux 6.7-rc1)
Merging hyperv-fixes/hyperv-fixes (7e8037b099c0 x86/hyperv: Fix the detecti=
on of E820_TYPE_PRAM in a Gen2 VM)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3ca112b71f35 Merge tag 'probes-fixes-v6.7-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging riscv-dt-fixes/riscv-dt-fixes (cf98fe6b579e riscv: dts: starfive: v=
isionfive 2: correct spi's ss pin)
Merging riscv-soc-fixes/riscv-soc-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga-fixes/fixes (03d4bf9ff34a fpga: Fix memory leak for fpga_regio=
n_test_class_find())
Merging spdx/spdx-linus (d2f51b3516da Merge tag 'rtc-6.7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging gpio-brgl-fixes/gpio/for-current (b85ea95d0864 Linux 6.7-rc1)
Merging gpio-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-intel-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging erofs-fixes/fixes (41087f71cde0 erofs: simplify erofs_read_inode())
Merging kunit-fixes/kunit-fixes (1bddcf77ce66 kunit: test: Avoid cast warni=
ng when adding kfree() as an action)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (05493c522dd3 NFSD: Fix checksum mismatches i=
n the duplicate reply cache)
Merging irqchip-fixes/irq/irqchip-fixes (b673fe1a6229 MAINTAINERS: Remove m=
yself from the general IRQ subsystem maintenance)
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (fed3a1be6433 Merge tag 'perf-tools-fixes-f=
or-v6.6-2-2023-10-20' into perf-tools-next)
Merging efi-fixes/urgent (c03d21f05e76 Merge 3rd batch of EFI fixes into ef=
i/urgent)
Merging zstd-fixes/zstd-linus (f064f4e5ecb1 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging rust-fixes/rust-fixes (cfd96726e611 rust: docs: fix logo replacemen=
t)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pmdomain-fixes/fixes (b131329b9bfb pmdomain: amlogic: Fix mask for =
the second NNA mem PD domain)
Merging overlayfs-fixes/ovl-fixes (37f32f526438 ovl: fix memory leak in ovl=
_parse_param())
Merging drm-misc-fixes/for-linux-next-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging mm-stable/mm-stable (b85ea95d0864 Linux 6.7-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (b85ea95d0864 Linux 6.7-rc1)
Merging mm/mm-everything (d1ed28d868a0 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (5f56cb030e4b kbuild: support 'userldlibs' syntax)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (6512b6aa237d perf bpf: Don't synthesize BPF e=
vents when disabled)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (53c87e846e33 swiotlb: fix out-of-bounds TLB a=
llocations with CONFIG_SWIOTLB_DYNAMIC)
Merging asm-generic/master (550087a0ba91 hexagon: Remove unusable symbols f=
rom the ptrace.h uapi)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (c7368ddba2ff ARM: 9326/1: make <linux/uaccess.h> self=
-contained for ARM)
Merging arm64/for-next/core (f86128050d2d arm64/syscall: Remove duplicate d=
eclaration)
Merging arm-perf/for-next/perf (b805cafc604b perf: hisi: Fix use-after-free=
 when register pmu fails)
Merging arm-soc/for-next (1b52f65d88ad Merge branch 'soc/defconfig' into fo=
r-next)
Merging amlogic/for-next (996fc07dce79 Merge branch 'v6.7/defconfig' into f=
or-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (3be891e01a89 Merge branches 'defconfig-for-v6.7', =
'dt-for-v6.7' and 'soc-for-v6.7' into for-next)
Merging at91/at91-next (3cec9514911c ARM: dts: at91: sam9x60_curiosity: Add=
 mandatory dt property for RTT)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging imx-mxs/for-next (fa81543ef854 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (93e6b023e552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (cb1114df7bb0 Merge branch 'fixes' into for-next)
Merging qcom/for-next (2b05c2dc230b Merge branches 'arm64-defconfig-for-6.7=
', 'arm64-fixes-for-6.6', 'arm64-for-6.7', 'clk-for-6.7', 'drivers-for-6.7'=
 and 'dts-for-6.7' into for-next)
Merging renesas/next (49d9ceae0384 Merge branch 'renesas-dts-for-v6.8' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (043d3ef3344a Merge branch 'v6.8-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (6479f40a10f7 arm64: dts: exynos: add gpio-ke=
y node for exynosautov9-sadk)
Merging scmi/for-linux-next (fb38611ae869 Merge branch 'for-next/scmi/updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging stm32/stm32-next (1aeb02d3f2c5 ARM: dts: stm32: add SDIO pinctrl sl=
eep support on stm32f7 boards)
Merging sunxi/sunxi/for-next (c3f7c14856eb riscv: dts: allwinner: convert i=
sa detection to new properties)
Merging tee/next (71946be7f76b Merge branch 'optee_rem_custom_wq_for_v6.8' =
into next)
Merging tegra/for-next (650220c2b474 Merge branch for-6.7/arm64/dt into for=
-next)
Merging ti/ti-next (b85ea95d0864 Linux 6.7-rc1)
Merging xilinx/for-next (7d2da28125ce Merge branch 'zynqmp/dt' into for-nex=
t)
Merging clk/clk-next (0a6d7f8275f2 Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (4bce4bedbe6d clk: renesas: r9a08g045: Add =
clock and reset support for SDHI1 and SDHI2)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (1d375d65466e selftests/bpf: Enable cpu v4=
 tests for LoongArch)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (b85ea95d0864 Linux 6.7-rc1)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (0c7f7f50ed23 prctl: Temporarily disable prctl(P=
R_SET_MDWE) on parisc)
Merging powerpc/next (707df298cbde Merge tag 'powerpc-6.7-1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (3ca112b71f35 Merge tag 'probes-fixes-v6.7-rc1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging riscv-dt/riscv-dt-for-next (b99df6281891 riscv: dts: sophgo: remove=
 address-cells from intc node)
Merging riscv-soc/riscv-soc-for-next (22dedf8f4570 soc/microchip: mpfs-sys-=
controller: Convert to platform remove callback returning void)
Merging s390/for-next (02e790ee3077 s390/mm: make pte_free_tlb() similar to=
 pXd_free_tlb())
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (a83a72730c33 xtensa: import ESP32S3 core va=
riant)
Merging bcachefs/for-next (924bd6061521 bcachefs: Improved backpointer mess=
ages in fsck)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (15baf55481de fscrypt: track master key presence s=
eparately from secret)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (b2013ba733b7 Merge branch 'for-next-next-v6.7-20231=
113' into for-next-20231113)
Merging ceph/master (272c77505d84 libceph: check the data length when spars=
e-read finishes)
Merging cifs/for-next (5eef12c4e323 cifs: fix lock ordering while disabling=
 multichannel)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (1a0ac8bd7a4f erofs: fix erofs_insert_workgroup() lockref=
 usage)
Merging exfat/dev (1373ca10ec04 exfat: fix ctime is not updated)
Merging ext3/for_next (7f680e5f256f Pull ext2 conversion of directory code =
to folios.)
Merging ext4/dev (91562895f803 ext4: properly sync file size update after O=
_SYNC direct IO)
Merging f2fs/dev (9bacdd8996c7 Merge tag 'for-6.7-rc1-tag' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (18437366a3a1 fuse: share lookup state between submou=
nt and its parent)
Merging gfs2/for-next (8d859dc44163 gfs2: Fix inode_go_instantiate descript=
ion)
Merging jfs/jfs-next (5afb50b46a98 jfs: fix shift-out-of-bounds in dbJoin)
Merging ksmbd/ksmbd-for-next (b85ea95d0864 Linux 6.7-rc1)
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (77ba5b340b7c NFSD: Make the file_delayed_close work=
queue UNBOUND)
Merging ntfs3/master (e4494770a5ca fs/ntfs3: Avoid possible memory leak)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (faf50fcba906 ovl: stop using d_alloc_anon=
()/d_instantiate_anon())
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (ce0708796420 9p/net: fix possible memory leak in p9_c=
heck_errors())
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (7930d9e10370 xfs: recovery should not clear di_flushi=
ter unconditionally)
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
Merging vfs-brauner/vfs.all (97f46be6c2b0 Merge branch 'vfs.super' into vfs=
.all)
Merging vfs/for-next (1aee9158bc97 nfsd: lock_rename() needs both directori=
es to live on the same fs)
Merging printk/for-next (b4908d68609b Merge branch 'for-6.7' into for-next)
Merging pci/next (b85ea95d0864 Linux 6.7-rc1)
Merging pstore/for-next/pstore (1d49dee6b691 pstore/ram: Fix crash when set=
ting number of cpus to an odd number)
Merging hid/for-next (55ec92989f9b Merge branch 'for-6.6/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (382561d16854 i2c: ocores: Move system PM hooks to=
 the NOIRQ phase)
Merging i3c/i3c/next (b85ea95d0864 Linux 6.7-rc1)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (782ca7b8b1ce hwmon: Fix some kernel-doc c=
omments)
CONFLICT (content): Merge conflict in drivers/hwmon/ltc2991.c
Merging jc_docs/docs-next (b85ea95d0864 Linux 6.7-rc1)
Merging v4l-dvb/master (3e238417254b media: nuvoton: VIDEO_NPCM_VCD_ECE sho=
uld depend on ARCH_NPCM)
Merging v4l-dvb-next/master (3e238417254b media: nuvoton: VIDEO_NPCM_VCD_EC=
E should depend on ARCH_NPCM)
Merging pm/linux-next (305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging cpufreq-arm/cpufreq/arm/linux-next (5b5b5806f223 cpufreq: qcom-nvme=
m: Introduce cpufreq for ipq95xx)
Merging cpupower/cpupower (b85ea95d0864 Linux 6.7-rc1)
Merging devfreq/devfreq-next (b85ea95d0864 Linux 6.7-rc1)
Merging pmdomain/next (9e0cceadb7a5 pmdomain: Merge branch fixes into next)
Merging opp/opp/linux-next (5306fe37284c opp: ti: Use device_get_match_data=
())
Merging thermal/thermal/linux-next (9618efe343ea thermal/qcom/tsens: Drop o=
ps_v0_1)
Merging dlm/next (eb53c01873ca MAINTAINERS: Update dlm maintainer and web p=
age)
Merging rdma/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging net-next/main (89cdf9d55601 Merge tag 'net-6.7-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf-next/for-next (81427a62a221 Merge branch 'bpf-add-support-for-c=
group1-bpf-part')
Merging ipsec-next/master (eefed7662ff2 xfrm: policy: fix layer 4 flowi dec=
oding)
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
Merging netfilter-next/main (ef113733c288 bareudp: use ports to lookup rout=
e)
Merging ipvs-next/main (9cdee0634769 netfilter: nf_tables: Carry reset bool=
ean in nft_set_dump_ctx)
Merging bluetooth/master (0783375f2c56 Bluetooth: ISO: Allow binding a PA s=
ync socket)
Merging wireless-next/for-next (0a78bb64a499 wifi: rtw89: pci: update inter=
rupt mitigation register for 8922AE)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (b85ea95d0864 Linux 6.7-rc1)
Merging nand/nand/next (f52221d55d8d mtd: rawnand: txx9ndfmc: Convert to pl=
atform remove callback returning void)
Merging spi-nor/spi-nor/next (6823a8383420 mtd: spi-nor: micron-st: use SFD=
P table for mt25qu512a)
Merging crypto/master (a312e07a65fb crypto: adiantum - flush destination pa=
ge before unmapping)
Merging drm/drm-next (b85ea95d0864 Linux 6.7-rc1)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (2e122362d25e iosys-map: Rename locals used=
 inside macros)
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_drv.c
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_ipc.c
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_job.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/scheduler/sched_main.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/tests/drm_mm_test.c
Merging amdgpu/drm-next (8473bfdcb5b1 drm/amdgpu: fix error handling in amd=
gpu_vm_init)
Merging drm-intel/for-linux-next (dd99d5b1ab93 drm/i915/dp: Tune down FEC d=
etection timeout error message)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (b08d26dac1a1 drm/msm/a7xx: actually use a7xx stat=
e registers)
Merging drm-msm-lumag/msm-next-lumag (d3b4075b173f drm/msm/dp: use correct =
lifetime device for devm_drm_bridge_add)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (8b01ee6ce9bf fbdev: imxfb: add '*/' on a separate l=
ine in block comment)
Merging regmap/for-next (d958d97848a6 regmap: kunit: add noinc write test)
Merging sound/for-next (713f040cd222 ALSA: hda/realtek - Enable internal sp=
eaker of ASUS K6500ZC)
Merging ieee1394/for-next (c12d7aa7ffa4 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (f40795b8a522 Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-next)
Merging modules/modules-next (4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging input/next (28d3fe323547 Input: walkera0701 - use module_parport_dr=
iver macro to simplify the code)
Merging block/for-next (8aa6053114f3 Merge branch 'for-6.7/block' into for-=
next)
Merging device-mapper/for-next (9793c269da6c dm crypt: account large pages =
in cc->n_allocated_pages)
Merging libata/for-next (0e533cba3801 dt-bindings: ata: tegra: Disallow und=
efined properties)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (33dabe920f1a Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (2b481822446e mfd: lpc_ich: Mark *_gpio_offsets da=
ta with const)
Merging backlight/for-backlight-next (d5272d39995f dt-bindings: backlight: =
Add brightness-levels related common properties)
Merging battery/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging regulator/for-next (753e4d5c433d regulator: add under-voltage suppo=
rt (part 2))
Merging security/next (00eb7bd699cc mailmap: update/replace my old email ad=
dresses)
Merging apparmor/apparmor-next (6cede10161be apparmor: Fix some kernel-doc =
comments)
Merging integrity/next-integrity (b836c4d29f27 ima: detect changes to the b=
acking overlay file)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (c99896b23640 selinux: update filenametr_hash() to use=
 full_name_hash())
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (03acb9ccec3f keys: Remove unused extern declarations)
Merging watchdog/master (b85ea95d0864 Linux 6.7-rc1)
Merging iommu/next (e8cca466a84a Merge branches 'iommu/fixes', 'arm/tegra',=
 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd', 'core' and 's390' into next)
Merging audit/next (022732e3d846 audit: Send netlink ACK before setting con=
nection in auditd_set)
Merging devicetree/for-next (fe612629746c dt-bindings: soc: fsl: cpm_qe: cp=
m1-scc-qmc: Add support for QMC HDLC)
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (96cb7a4e296d dt-bindings: mailbox: qcom-ipcc: doc=
ument the SM8650 Inter-Processor Communication Controller)
Merging spi/for-next (6f9da1817188 Add STM32F7 SPI support)
Merging tip/master (bd491c7d78a7 Merge x86/paravirt into tip/master)
Merging clockevents/timers/drivers/next (c28ca80ba3b5 clocksource: ep93xx: =
Add driver for Cirrus Logic EP93xx)
Merging edac/edac-for-next (6f15b178cd63 EDAC/versal: Add a Xilinx Versal m=
emory controller driver)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (e1742fa172d5 Merge probes/for-next)
Merging rcu/rcu/next (68f721e904b2 rcu: Restrict access to RCU CPU stall no=
tifiers)
Merging kvm/next (6c370dc65374 Merge branch 'kvm-guestmemfd' into HEAD)
Merging kvm-arm/next (123f42f0ad68 Merge branch kvm-arm64/pmu_pmcr_n into k=
vmarm/next)
Merging kvms390/next (70fea3019516 KVM: s390: add tracepoint in gmap notifi=
er)
Merging kvm-ppc/topic/ppc-kvm (707df298cbde Merge tag 'powerpc-6.7-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging kvm-riscv/riscv_kvm_next (d9c00f44e5de KVM: riscv: selftests: Add S=
BI DBCN extension to get-reg-list test)
Merging kvm-x86/next (45b890f7689e Merge tag 'kvmarm-6.7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging xen-tip/linux-next (3bdb0ac350fe xen/events: remove some simple hel=
pers from events_base.c)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (d5ce8f4ed90b Merge branch 'for-6.7' into for-n=
ext)
Merging drivers-x86/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging chrome-platform/for-next (d131f1f3b459 platform/chrome: sensorhub: =
Implement quickselect for median calculation)
Merging chrome-platform-firmware/for-firmware-next (ecea08916418 firmware: =
coreboot: framebuffer: Avoid invalid zero physical address)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (b9604be24158 leds: lp5521: Add an error chec=
k in lp5521_post_init_device)
Merging ipmi/for-next (bc3012f4e3a9 Merge tag 'v6.7-p1' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging driver-core/driver-core-next (b85ea95d0864 Linux 6.7-rc1)
Merging usb/usb-next (b85ea95d0864 Linux 6.7-rc1)
Merging thunderbolt/next (655b8af57d31 thunderbolt: Remove duplicated re-as=
signment of pointer 'out')
Merging usb-serial/usb-next (b85ea95d0864 Linux 6.7-rc1)
Merging tty/tty-next (b85ea95d0864 Linux 6.7-rc1)
Merging char-misc/char-misc-next (b85ea95d0864 Linux 6.7-rc1)
Merging accel/habanalabs-next (631808095a82 Merge tag 'amd-drm-next-6.7-202=
3-10-27' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging coresight/next (5ce62920de12 coresight: etm4x: Fix width of CCITMIN=
 field)
Merging fastrpc/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging fpga/for-next (d79eed22ba97 fpga: versal: Add support for 44-bit DM=
A operations)
Merging icc/icc-next (b85ea95d0864 Linux 6.7-rc1)
Merging iio/togreg (89e2233386a5 iio: proximity: sx9324: Switch to device_p=
roperty_match_property_string())
Merging phy-next/next (b85ea95d0864 Linux 6.7-rc1)
Merging soundwire/next (b85ea95d0864 Linux 6.7-rc1)
Merging extcon/extcon-next (b85ea95d0864 Linux 6.7-rc1)
Merging gnss/gnss-next (b85ea95d0864 Linux 6.7-rc1)
Merging vfio/next (2b88119e35b0 vfio/mtty: Enable migration support)
Merging w1/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (b85ea95d0864 Linux 6.7-rc1)
Merging counter-next/counter-next (7904cdf1397c counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (b85ea95d0864 Linux 6.7-rc1)
Merging cgroup/for-next (e76d28bdf9ba cgroup/rstat: Reduce cpu_lock hold ti=
me in cgroup_rstat_flush_locked())
Merging scsi/for-next (88eed215d016 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (e439e4a62a8e scsi: ufs: qcom-ufs: dt-bindings: D=
ocument the SM8650 UFS Controller)
Merging vhost/linux-next (e07754e0a1ea vhost-vdpa: fix use after free in vh=
ost_vdpa_probe())
Merging rpmsg/for-next (6dc66a309673 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging gpio-intel/for-next (fb77e8a85915 Merge patch series "Use the stand=
ard _PM_OPS() export macro in Intel Tangier GPIO driver")
Merging pinctrl/for-next (92034367fc97 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (c5860e4a2737 pinctrl: intel: Add a generic =
Intel pin control platform driver)
Merging pinctrl-renesas/renesas-pinctrl (583d80732055 pinctrl: renesas: rzn=
1: Convert to platform remove callback returning void)
Merging pinctrl-samsung/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging pwm/for-next (d27abbfd4888 pwm: Fix double shift bug)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (b85ea95d0864 Linux 6.7-rc1)
Merging kunit/test (b85ea95d0864 Linux 6.7-rc1)
Merging kunit-next/kunit (b85ea95d0864 Linux 6.7-rc1)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (b85ea95d0864 Linux 6.7-rc1)
Merging nvdimm/libnvdimm-for-next (9ea459e477dc libnvdimm: remove kernel-do=
c warnings:)
Merging at24/at24/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (31c65705a8cf perf/benchmark: fix seccomp_=
unotify benchmark for 32-bit)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging nvmem/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (23816724fdbd kdb: Corrects comment for kdballoc=
env)
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (83c5dcf78ab9 bus: mhi: host: Add alignment check for =
event ring read pointer)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (5d09c63f11f0 cxl/hdm: Remove broken error path)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (5329aa5101f7 efivarfs: Add uid/gid mount options)
Merging unicode/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging slab/slab/for-next (dd374e220ba4 slub: Update frozen slabs document=
ations in the source)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (f12f8f84509a selftests/landlock: Add tests for FS to=
pology changes with network rules)
Merging rust/rust-next (3857af38e57a docs: rust: add "The Rust experiment" =
section)
Merging sysctl/sysctl-next (8b793bcda61f watchdog: move softlockup_panic ba=
ck to early_param)
Merging execve/for-next/execve (21ca59b365c0 binfmt_misc: enable sandboxed =
mounts)
Merging bitmap/bitmap-for-next (bdcb37a5d8de buildid: reduce header file de=
pendencies for module)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (1ee60356c2dc gcc-plugins: randstruct: Only warn=
 about true flexible arrays)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (b85ea95d0864 Linux 6.7-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (b2b67c997bf7 iommufd: Organize the mock domain al=
loc functions closer to Joerg's tree)

--Sig_/2EB2oG=wH8ZKwTDoCFK_Ehw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVUHpgACgkQAVBC80lX
0Gw4lwf/YvN0J41Kld/G272S9hW/nPvijK4bVWa991KCVt37RY+eliARKgMDu8/I
ghlEC4DDRyboz9asf6KY/lwLUz46GoFSgRJOg6yxwHzhJIcckGGIJqaeM6/OKKX5
ltrVduxQFUKa80qbmKh1yQNzWmfdojNfhMmWdElThPqS5Bt3a9xSvS+/hjKR3+nh
NZW7j3pVEjGMmmXSDWZ/GvIptiVTUS5fpPe4fAdw3atmOi5goHVHt8SUivfehkd/
jv+kqCGNGgWXKnsitmkJ3oHuTHk7LJdLubOF3jmF8hUmwUYsOsMCeAEDcvexcYVg
K24UIoJLkoHyyeTPjW77amtWIgd1lA==
=eHzv
-----END PGP SIGNATURE-----

--Sig_/2EB2oG=wH8ZKwTDoCFK_Ehw--
