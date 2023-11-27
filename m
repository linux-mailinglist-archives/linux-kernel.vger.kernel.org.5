Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2164C7F981F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjK0EFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0EFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:05:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF0E8;
        Sun, 26 Nov 2023 20:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701057948;
        bh=vZmj8ANuc72BpYfRDgSsyNuRTtPZS88fpYKsx4EHNho=;
        h=Date:From:To:Cc:Subject:From;
        b=GWVM8ymfSuJ6NblCAU5rRrpn+L+sEvVvVKXFgjeM5z6aSTD2FbSEJ0Wvrs2zGYYEU
         W1y6rsed+aJtJgjEbQXJyjpPUobeK5v+xfTYhD/oUjE8eXmSO9iNLNcruLwhlqV7jI
         Rqbtq/joav40LGgftJHdN+WHlAYk7Umh7g1SalbQdfUmHiAiWCyffOWXDOzcRyS3BE
         b5SpeKcoVngHF3t6142FRBdw4ChHfpsngdfClP+dcjCm8prR+vXoJBodew5Yni55Ah
         TiGuBE/S6dZrnFSl0Gh7qzpkatA9Bk0mmtM1YbYGqJA+NDa8Hcm86W0uoZUCXKkWy9
         P094AgfpuqLPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SdsSr0Jxzz4wd4;
        Mon, 27 Nov 2023 15:05:48 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 15:05:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 27
Message-ID: <20231127150547.461d8bac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cHdKXkHyy72PmiQ9YYkjUbO";
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

--Sig_/cHdKXkHyy72PmiQ9YYkjUbO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231124:

The drm-misc-fixes tree gained a build failure so I used the version
from next-20231124.

The mm tree gained build failures for which I applied patches.

The vfs-brauner tree gained conflicts against the btrfs tree.

The drm-misc tree gained a build failure so I used the version from
next-20231124.

The tty tree gained a conflict against the powerpc tree.

The slab tree gained a conflict against the mm tree.

Non-merge commits (relative to Linus' tree): 2777
 3411 files changed, 149448 insertions(+), 99893 deletions(-)

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
Merging origin/master (d2da77f431ac Merge tag 'parisc-for-6.7-rc3' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (c874ad0bd5a5 kexec-fix-kexec_file=
-dependencies-fix)
Merging kbuild-current/fixes (98b1cc82c4af Linux 6.7-rc2)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (2dde18cd1d8f Linux 6.5)
Merging arm64-fixes/for-next/fixes (c0a857420405 arm64: add dependency betw=
een vmlinuz.efi and Image)
Merging arm-soc-fixes/arm/fixes (736a4aad8a9f Merge tag 'renesas-fixes-for-=
v6.6-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel into arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (03191fb3db3d m68k: lib: Include <linux/libg=
cc.h> for __muldi3())
Merging powerpc-fixes/fixes (98b1cc82c4af Linux 6.7-rc2)
Merging s390-fixes/fixes (aab1f809d754 scripts/checkstack.pl: match all sta=
ck sizes for s390)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (ccf49cebe595 Merge branch 'dpaa2-eth-fixes')
Merging bpf/master (c0c6bde586c7 netdevsim: Don't accept device bound progr=
ams)
Merging ipsec/master (76df934c6d5f MAINTAINERS: Add netdev subsystem profil=
e link)
Merging netfilter/main (54d4434da824 Merge branch 'hv_netvsc-fix-race-of-ne=
tvsc-vf-register-and-slave-bit')
Merging ipvs/main (54d4434da824 Merge branch 'hv_netvsc-fix-race-of-netvsc-=
vf-register-and-slave-bit')
Merging wireless/for-next (00f7d153f335 wifi: mac80211: handle 320 MHz in i=
eee80211_ht_cap_ie_to_sta_ht_cap)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (2b78832f50c4 RDMA/irdma: Fix UAF in irdma_sc_ccq=
_get_cqe_info())
Merging sound-current/for-linus (732c678eb021 ALSA: hda: cs35l56: Enable lo=
w-power hibernation mode on SPI)
Merging sound-asoc-fixes/for-linus (1805a6d269be ASoC: SOF: Extend the enab=
led DSP core handling)
Merging regmap-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging pci-current/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging driver-core.current/driver-core-linus (98b1cc82c4af Linux 6.7-rc2)
Merging tty.current/tty-linus (58ac1b379979 ARM: PL011: Fix DMA support)
Merging usb.current/usb-linus (090472ed9c92 Merge tag 'usb-6.7-rc3' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging usb-serial-fixes/usb-linus (da90e45d5afc USB: serial: option: add L=
uat Air72*U series products)
Merging phy/fixes (0f40d5099cd6 phy: ti: gmii-sel: Fix register offset when=
 parent is not a syscon node)
Merging staging.current/staging-linus (98b1cc82c4af Linux 6.7-rc2)
Merging iio-fixes/fixes-togreg (1cd2fe4fd63e iio: imu: adis16475: use bit n=
umbers in assign_bit())
Merging counter-current/counter-current (58720809f527 Linux 6.6-rc6)
Merging char-misc.current/char-misc-linus (98b1cc82c4af Linux 6.7-rc2)
Merging soundwire-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging thunderbolt-fixes/fixes (480713b1ba8e thunderbolt: Only add device =
router DP IN to the head of the DP resource list)
Merging input-current/for-linus (936e4d49ecbc Input: atkbd - skip ATKBD_CMD=
_GETID in translated mode)
Merging crypto-current/master (9aedd10fe384 crypto: ahash - Set using_shash=
 for cloned ahash wrapper over shash)
Merging vfio-fixes/for-linus (c777b11d34e0 vfio/mdev: Fix a null-ptr-deref =
bug for mdev_unregister_parent())
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
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging at91-fixes/at91-fixes (b85ea95d0864 Linux 6.7-rc1)
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
Merging btrfs-fixes/next-fixes (1472b846cf93 Merge branch 'misc-6.7' into n=
ext-fixes)
Merging vfs-fixes/fixes (dc32464a5fe4 ceph_wait_on_conflict_unlink(): grab =
reference before dropping ->d_lock)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (a6584711e64d platform/x86: intel_telemetry=
: Fix kernel doc descriptions)
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (8f51593cdcab dt: dt-extract-compatibles:=
 Don't follow symlinks when walking tree)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (b09d7f8fd50f scsi: sd: Fix system start for ATA d=
evices)
Merging drm-fixes/drm-fixes (b3ca8a08d8ed Merge tag 'drm-intel-fixes-2023-1=
1-23' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (0561794b6b64 drm/i915: do not=
 clean GT table on error path)
Merging mmc-fixes/fixes (477865af60b2 mmc: sdhci-sprd: Fix vqmmc not shutti=
ng down after the card was pulled)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (98b1cc82c4af Linux 6.7-rc2)
Merging hyperv-fixes/hyperv-fixes (18286883e779 x86/hyperv: Use atomic_try_=
cmpxchg() to micro-optimize hv_nmi_unknown())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3ca112b71f35 Merge tag 'probes-fixes-v6.7-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging riscv-dt-fixes/riscv-dt-fixes (e80ed63affc9 riscv: dts: sophgo: rem=
ove address-cells from intc node)
Merging riscv-soc-fixes/riscv-soc-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (d2f51b3516da Merge tag 'rtc-6.7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging gpio-brgl-fixes/gpio/for-current (b85ea95d0864 Linux 6.7-rc1)
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
Merging perf-current/perf-tools (57686a72da08 tools: Disable __packed attri=
bute compiler warning due to -Werror=3Dattributes)
Merging efi-fixes/urgent (c03d21f05e76 Merge 3rd batch of EFI fixes into ef=
i/urgent)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (f37669119423 power: supply: cw2015: correct ti=
me_to_empty units in sysfs)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (98594181944d iommufd/selftest: Fix _test_mock=
_dirty_bitmaps())
Merging rust-fixes/rust-fixes (cfd96726e611 rust: docs: fix logo replacemen=
t)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pmdomain-fixes/fixes (98b1cc82c4af Linux 6.7-rc2)
Merging overlayfs-fixes/ovl-fixes (37f32f526438 ovl: fix memory leak in ovl=
_parse_param())
Merging drm-misc-fixes/for-linux-next-fixes (39d5b6a64ace drm/bridge: panel=
: Check device dependency before managing device link)
$ git reset --hard HEAD^
Merging next-20231124 version of drm-misc-fixes
Merging mm-stable/mm-stable (5b7ad877e4d8 Merge tag 'afs-fixes-20231124' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs)
Merging mm-nonmm-stable/mm-nonmm-stable (5b7ad877e4d8 Merge tag 'afs-fixes-=
20231124' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-f=
s)
Merging mm/mm-everything (c1d0151716c6 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (054b2ccd5f4e kbuild: buildtar: always make modules=
_install)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (acbf6de674ef perf vendor events riscv: Add St=
arFive Dubhe-80 JSON file)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (53c87e846e33 swiotlb: fix out-of-bounds TLB a=
llocations with CONFIG_SWIOTLB_DYNAMIC)
Merging asm-generic/master (5da694bdf0e4 Merge branch 'asm-generic-prototyp=
es' into asm-generic)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (c7368ddba2ff ARM: 9326/1: make <linux/uaccess.h> self=
-contained for ARM)
Merging arm64/for-next/core (f86128050d2d arm64/syscall: Remove duplicate d=
eclaration)
Merging arm-perf/for-next/perf (b805cafc604b perf: hisi: Fix use-after-free=
 when register pmu fails)
Merging arm-soc/for-next (1b52f65d88ad Merge branch 'soc/defconfig' into fo=
r-next)
Merging amlogic/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e9be9b34b841 ARM: dts: aspeed: Add ASRock E3C256D4=
I BMC)
Merging at91/at91-next (b766b70117ac Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (0d6c918011ce memory: tegra: Skip SID progr=
amming if SID registers aren't set)
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
Merging renesas/next (19c4da034485 Merge branch 'renesas-dts-for-v6.8' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (2a883579c894 Merge branch 'v6.8-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (64041620130c Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (b419bd935f13 Merge branch 'for-next/scmi/updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging stm32/stm32-next (9a7308232a11 ARM: dts: stm32: add SPI support on =
STM32F746)
Merging sunxi/sunxi/for-next (715a9e70bdd4 Merge branch 'sunxi/clk-for-6.8'=
 into sunxi/for-next)
Merging tee/next (352b5f33b950 Merge branch 'ffa_notif_for_v6.8' into next)
Merging tegra/for-next (650220c2b474 Merge branch for-6.7/arm64/dt into for=
-next)
Merging ti/ti-next (2b27ce85624e Merge branch 'ti-keystone-dts-next' into t=
i-next)
Merging xilinx/for-next (1d4723dec415 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (b85ea95d0864 Linux 6.7-rc1)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (5ab16198b431 clk: renesas: r8a779g0: Add P=
CIe clocks)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (c517fd2738f4 Docs/zh_CN/LoongArch: Update=
 links in LoongArch introduction.rst)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (98b1cc82c4af Linux 6.7-rc2)
Merging microblaze/next (ffb0399437ef microblaze: defconfig: Enable the Mar=
vell phy driver)
Merging mips/mips-next (b85ea95d0864 Linux 6.7-rc1)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (43266838515d parisc: Reduce size of the bug_tab=
le on 64-bit kernel by half)
Merging powerpc/next (4958b3a7bb0f powerpc/xics: Check return value of kasp=
rintf in icp_native_map_one_cpu)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (3ca112b71f35 Merge tag 'probes-fixes-v6.7-rc1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging riscv-dt/riscv-dt-for-next (b85ea95d0864 Linux 6.7-rc1)
Merging riscv-soc/riscv-soc-for-next (94f4018bc9f3 Merge branch 'riscv-cach=
e-for-next' into riscv-soc-for-next)
Merging s390/for-next (e9304ad4e23b Merge branch 'features' into for-next)
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (a83a72730c33 xtensa: import ESP32S3 core va=
riant)
Merging bcachefs/for-next (c7b82aeee88a bcachefs: Kill journal_seq/gc args =
to bch2_dev_usage_update_m())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (15baf55481de fscrypt: track master key presence s=
eparately from secret)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (f931faf024dd Merge branch 'for-next-next-v6.7-20231=
124' into for-next-20231124)
Merging ceph/master (d30d7c57a64d ceph: select FS_ENCRYPTION_ALGS if FS_ENC=
RYPTION)
Merging cifs/for-next (63cd106a61ae cifs: Set the file size after doing cop=
ychunk_range)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (1a0ac8bd7a4f erofs: fix erofs_insert_workgroup() lockref=
 usage)
Merging exfat/dev (1373ca10ec04 exfat: fix ctime is not updated)
Merging ext3/for_next (8abc712ea486 ext2: Fix ki_pos update for DIO buffere=
d-io fallback case)
Merging ext4/dev (91562895f803 ext4: properly sync file size update after O=
_SYNC direct IO)
Merging f2fs/dev (6bc40e44f1dd Merge tag 'ovl-fixes-6.7-rc2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/overlayfs/vfs)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (18437366a3a1 fuse: share lookup state between submou=
nt and its parent)
Merging gfs2/for-next (8d859dc44163 gfs2: Fix inode_go_instantiate descript=
ion)
Merging jfs/jfs-next (cca974daeb6c jfs: fix shift-out-of-bounds in dbJoin)
Merging ksmbd/ksmbd-for-next (cd80ce7e68f1 ksmbd: don't update ->op_state a=
s OPLOCK_STATE_NONE on error)
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (cfbb856d3fa9 svcrdma: Clean up locking)
Merging ntfs3/master (ffc253263a13 Linux 6.6)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (2c3ef4f89ced ovl: initialize ovl_copy_up_=
ctx.destname inside ovl_do_copy_up())
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (ce0708796420 9p/net: fix possible memory leak in p9_c=
heck_errors())
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
Merging vfs-brauner/vfs.all (c859e96e7d12 Merge branch 'vfs.fscache' into v=
fs.all)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/subpage.c
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/buffer.c
Merging vfs/for-next (bbe6a7c899e7 bch2_ioctl_subvolume_destroy(): fix lock=
ing)
Merging printk/for-next (b4908d68609b Merge branch 'for-6.7' into for-next)
Merging pci/next (b85ea95d0864 Linux 6.7-rc1)
Merging pstore/for-next/pstore (1d49dee6b691 pstore/ram: Fix crash when set=
ting number of cpus to an odd number)
Merging hid/for-next (8674f6b6cdba Merge branch 'for-6.7/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (382561d16854 i2c: ocores: Move system PM hooks to=
 the NOIRQ phase)
Merging i3c/i3c/next (b4da37db3e2c i3c: master: Fix build error)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (f90313944188 hwmon: (nct6775) Fix fan spe=
ed set failure in automatic mode)
Merging jc_docs/docs-next (7c49ca6b0213 Documentation: Fix filename typo in=
 ftrace doc)
Merging v4l-dvb/master (98b1cc82c4af Linux 6.7-rc2)
Merging v4l-dvb-next/master (a00b3f296eac media: mediatek: vcodec: Set the =
supported vp9 profile for each platform)
Merging pm/linux-next (9795b7a7c21e Merge branch 'acpi-thermal' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (8f96e29aae31 pmdomain: qcom: rp=
mpd: Set GENPD_FLAG_ACTIVE_WAKEUP)
Merging cpupower/cpupower (b85ea95d0864 Linux 6.7-rc1)
Merging devfreq/devfreq-next (b85ea95d0864 Linux 6.7-rc1)
Merging pmdomain/next (62b14b9e86a1 firmware: arm_scpi: Move power-domain d=
river to the pmdomain dir)
Merging opp/opp/linux-next (c394212c6714 OPP: Don't set OPP recursively for=
 a parent genpd)
Merging thermal/thermal/linux-next (9618efe343ea thermal/qcom/tsens: Drop o=
ps_v0_1)
Merging dlm/next (0c08699744d2 dlm: implement EXPORT_OP_ASYNC_LOCK)
Merging rdma/for-next (640233258e5b RDMA/rtrs: Use %pe to print errors)
Merging net-next/main (dba1b8a7ab68 mm/page_pool: catch page_pool memory le=
aks)
Merging bpf-next/for-next (e8a339b5235e selftests/bpf: Add lazy global subp=
rog validation tests)
Merging ipsec-next/master (aadbd27f9674 net: phy: correctly check soft_rese=
t ret ONLY if defined for PHY)
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
Merging netfilter-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_la=
rge and use it in rtnl_getlink)
Merging ipvs-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_large a=
nd use it in rtnl_getlink)
Merging bluetooth/master (1b70ac811a14 Bluetooth: Add documentation to expo=
rted functions in lib)
Merging wireless-next/for-next (0cc3f50f42d2 wifi: nl80211: Documentation u=
pdate for NL80211_CMD_PORT_AUTHORIZED event)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (b85ea95d0864 Linux 6.7-rc1)
Merging nand/nand/next (acb1fd579efb mtd: rawnand: meson: initialize clock =
register)
Merging spi-nor/spi-nor/next (9b3eae3486c8 docs: mtd: spi-nor: drop obsolet=
e info)
Merging crypto/master (cc03a934c5da dt-bindings: crypto: convert Inside Sec=
ure SafeXcel to the json-schema)
Merging drm/drm-next (221d6546bd16 Merge tag 'drm-intel-next-2023-11-23' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_hw_37xx.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
_mst.c
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (38f922a563aa drm/sched: Reverse run-queue =
priority enumeration)
$ git reset --hard HEAD^
Merging next-20231124 version of drm-misc
Merging amdgpu/drm-next (699d392903c3 drm/amdgpu: Add function parameter 'x=
cc_mask' not described in 'amdgpu_vm_flush_compute_tlb')
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_mst_types.c
Merging drm-intel/for-linux-next (b90fccfb5cde drm/i915: Move the SDP split=
 debug spew to the correct place)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (07e6de738aa6 drm/msm/a690: Fix reg values for a69=
0)
Merging drm-msm-lumag/msm-next-lumag (d3b4075b173f drm/msm/dp: use correct =
lifetime device for devm_drm_bridge_add)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (64a1aed0aa07 fbdev: mmp: Fix typo and wording in co=
de comment)
Merging regmap/for-next (1957b92aaff0 regmap: fix regmap_noinc_write() desc=
ription)
Merging sound/for-next (26257869672f ALSA: hda: Refer to correct stream ind=
ex at loops)
Merging ieee1394/for-next (c12d7aa7ffa4 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (dd352f19c91c Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-next)
Merging modules/modules-next (4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging input/next (fedfa36d045a Input: cap11xx - remove unnecessary IRQ pa=
rsing)
Merging block/for-next (da59b416ba80 Merge branch 'block-6.7' into for-next)
Merging device-mapper/for-next (13648e04a9b8 dm-crypt: start allocating wit=
h MAX_ORDER)
Merging libata/for-next (804901fdd637 ata: pata_pxa: convert not to use dma=
_request_slave_channel())
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (078ebb647090 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (95f44ef666a6 dt-bindings: mfd: qcom,spmi-pmic: Ad=
d pm8916 vm-bms and lbc)
Merging backlight/for-backlight-next (58793f263abc backlight: pwm_bl: Use d=
ev_err_probe)
Merging battery/for-next (b55d073e6501 power: supply: bq256xx: fix some pro=
blem in bq256xx_hw_init)
Merging regulator/for-next (753e4d5c433d regulator: add under-voltage suppo=
rt (part 2))
Merging security/next (afe576a62062 MAINTAINERS: add an entry for the lockd=
own LSM)
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
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
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
Merging selinux/next (ae254858ce07 selinux: introduce an initial SID for ea=
rly boot processes)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (c2d5304e6c64 Merge tag 'platform-drivers-x86-v6.7-2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86)
Merging watchdog/master (b85ea95d0864 Linux 6.7-rc1)
Merging iommu/next (e8cca466a84a Merge branches 'iommu/fixes', 'arm/tegra',=
 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd', 'core' and 's390' into next)
Merging audit/next (24fade412acf Automated merge of 'dev' into 'next')
Merging devicetree/for-next (1080b5c0c1a6 of: fix recursion typo in kernel =
doc)
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (96cb7a4e296d dt-bindings: mailbox: qcom-ipcc: doc=
ument the SM8650 Inter-Processor Communication Controller)
Merging spi/for-next (4c3ff31a85e3 spi: axi-spi-engine improvements)
Merging tip/master (c8f4d9018606 Merge branch into tip/master: 'sched/core')
Merging clockevents/timers/drivers/next (c28ca80ba3b5 clocksource: ep93xx: =
Add driver for Cirrus Logic EP93xx)
Merging edac/edac-for-next (5f57b717ccce EDAC/pci_sysfs: Use PCI_HEADER_TYP=
E_MASK instead of literals)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (e1742fa172d5 Merge probes/for-next)
Merging rcu/rcu/next (68f721e904b2 rcu: Restrict access to RCU CPU stall no=
tifiers)
Merging kvm/next (e9e60c82fe39 selftests/kvm: fix compilation on non-x86_64=
 platforms)
CONFLICT (content): Merge conflict in include/linux/pagemap.h
Applying: fs: Convert error_remove_page to error_remove_folio
Applying: fix up for "KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-spe=
cific backing memory"
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
Merging xen-tip/linux-next (7bf9a6b46549 arm/xen: fix xen_vcpu_info allocat=
ion alignment)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (4a6c5607d450 workqueue: Make sure that wq_unbo=
und_cpumask is never empty)
Merging drivers-x86/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging chrome-platform/for-next (d131f1f3b459 platform/chrome: sensorhub: =
Implement quickselect for median calculation)
Merging chrome-platform-firmware/for-firmware-next (ecea08916418 firmware: =
coreboot: framebuffer: Avoid invalid zero physical address)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (8171710be2d0 leds: max5970: Add support for =
max5970)
Merging ipmi/for-next (c5d03a0d8461 ipmi: Use regspacings passed as a modul=
e parameter)
Merging driver-core/driver-core-next (98b1cc82c4af Linux 6.7-rc2)
Merging usb/usb-next (6acba0345b68 usb:gadget:uvc Do not use worker thread =
to pump isoc usb requests)
Merging thunderbolt/next (655b8af57d31 thunderbolt: Remove duplicated re-as=
signment of pointer 'out')
Merging usb-serial/usb-next (98b1cc82c4af Linux 6.7-rc2)
Merging tty/tty-next (ab58841ab9fc tty: srmcons: use 'buf' directly in srmc=
ons_do_write())
CONFLICT (content): Merge conflict in drivers/tty/hvc/hvc_console.h
Merging char-misc/char-misc-next (98b1cc82c4af Linux 6.7-rc2)
Merging accel/habanalabs-next (ce06bc9d7209 accel/habanalabs: expose module=
 id through sysfs)
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging fpga/for-next (5496fb8eedd6 drivers/fpga: use standard array-copy f=
unction)
Merging icc/icc-next (feaf241ae2da Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (6543f376ec8a iio: buffer: document known issue)
Merging phy-next/next (772dd70a5ed6 phy: core: Remove usage of the deprecat=
ed ida_simple_xx() API)
Merging soundwire/next (a7ae05ef3561 soundwire: qcom: set controller id to =
hw master id)
Merging extcon/extcon-next (b85ea95d0864 Linux 6.7-rc1)
Merging gnss/gnss-next (98b1cc82c4af Linux 6.7-rc2)
Merging vfio/next (2b88119e35b0 vfio/mtty: Enable migration support)
Merging w1/for-next (271c81935801 w1: Add AXI 1-wire host driver for AMD pr=
ogrammable logic IP core)
Merging staging/staging-next (b43d958fbc23 staging: vchiq_arm: move state d=
ump to debugfs)
Merging counter-next/counter-next (7904cdf1397c counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (306f5df81fcc dmaengine: apple-admac: Keep upper bit=
s of REG_BUS_WIDTH)
Merging cgroup/for-next (42d2580377e0 Merge branch 'for-6.8' into for-next)
Merging scsi/for-next (d85d85eab615 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (6bae38ddd3a8 Merge patch series "scsi: arcmsr: s=
upport Areca ARC-1688 Raid controller")
Merging vhost/linux-next (e07754e0a1ea vhost-vdpa: fix use after free in vh=
ost_vdpa_probe())
Merging rpmsg/for-next (cae0e61beb7a arm64: dts: imx8mp: Add reserve-memory=
 nodes for DSP)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (e6d71c7878bc dt-bindings: gpio: brcmstb: d=
rop unneeded quotes)
Merging gpio-intel/for-next (92fc925f8386 gpio: tangier: simplify locking u=
sing cleanup helpers)
Merging pinctrl/for-next (ccdd55384156 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6191e49de389 pinctrl: baytrail: Simplify co=
de with cleanup helpers)
Merging pinctrl-renesas/renesas-pinctrl (583d80732055 pinctrl: renesas: rzn=
1: Convert to platform remove callback returning void)
Merging pinctrl-samsung/for-next (904140fa4553 dt-bindings: pinctrl: samsun=
g: use Exynos7 fallbacks for newer wake-up controllers)
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
Merging rtc/rtc-next (3d762e21d563 rtc: cmos: Use ACPI alarm for non-Intel =
x86 systems too)
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
Merging memblock/for-next (e96c6b8f212a memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (5d09c63f11f0 cxl/hdm: Remove broken error path)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (5329aa5101f7 efivarfs: Add uid/gid mount options)
Merging unicode/for-next (c1869dbd2957 Merge branch 'unicode/negative-dentr=
ies' into unicode/for-next)
Merging slab/slab/for-next (7eec549256f2 Merge branch 'slab/for-6.8/slab-re=
moval' into slab/for-next)
CONFLICT (content): Merge conflict in mm/kasan/quarantine.c
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (323f65ded48d landlock: Document IOCTL support)
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
Merging kspp-gustavo/for-next/kspp (1b56c90018f0 Makefile: Enable -Wstringo=
p-overflow globally)
Merging nolibc/nolibc (b85ea95d0864 Linux 6.7-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (b2b67c997bf7 iommufd: Organize the mock domain al=
loc functions closer to Joerg's tree)
Applying: powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANS=
PARENT_HUGEPAGE
Applying: sparc: turn off Werror for now

--Sig_/cHdKXkHyy72PmiQ9YYkjUbO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVkFZsACgkQAVBC80lX
0Gy6TAf7BZ2aP6j7PcU9BNII1S3aGc4J+1xL98brlJ52oHaTxAyrtFT7spRYDs8e
MwmzfGStUdp4rf9J5U8i4x+CnJVg1wIg/kD9kHB5HAL5oiZkSM+QSrBMBGKZVq58
B4PLG44hfFwxzgWtZtICdMjSiMlRC6zu7E4DyqepG9IYXnL0fLrCTYoRagF3ZE8x
VAqtCrJfFWKGEMHGDbEY1e72DdnzsFp0j2oiOk9dZxRzILdHrK9UC6dYLsPwHSN2
irAS2TISC0Hp7eupjI7Nj15qU9l+HrfeBNf/Nw9dh92i4B2FjqF6j9PpKPX7SN6c
BWhSGNrhXmF9M8L3jHJjaa616RXkyQ==
=voGD
-----END PGP SIGNATURE-----

--Sig_/cHdKXkHyy72PmiQ9YYkjUbO--
