Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8307E4FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKHEtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjKHEtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:49:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643913A;
        Tue,  7 Nov 2023 20:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699418938;
        bh=Nwq9vPUc3B9UZb9aa7ebALjCL6eJ6C4RaERZ/VyM1sg=;
        h=Date:From:To:Cc:Subject:From;
        b=qnvyuMr7a0sJgBXLAw8s6D6+MsJSBd5UuO5eMfjGRNfNRhl8ag5wB4AMXKNFqVTaJ
         j6npAOGzx9/zrHFJkMi0YXf8/ANv3kaZxO7zTA7TYpkwYv8GyK/O2kfrkW922vcofs
         Yg97+ZWsDzrbGq+Cxf3gqzdS1/bJBeLYKPNOjUGsmjosclW7UJXVOxxUU1T2IiDJbs
         tfp6GTlEv+VYxOORk0FPAcY50ICV76i9rd/M2oWP2a0RrSrYSO0DdtwVK5T67edHtX
         ObbzEPwwM6OidY6q7WqALSM98Cx9xHUrdrGonkM4ZTlgBonLz+5tNsByu1G/FLSTsV
         o6yO2brVVMYWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SQCKQ0v2Dz4x5s;
        Wed,  8 Nov 2023 15:48:58 +1100 (AEDT)
Date:   Wed, 8 Nov 2023 15:48:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 8
Message-ID: <20231108154856.6a8dd367@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VBG.1AFdhXOk=cG+3r=Y7EH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VBG.1AFdhXOk=cG+3r=Y7EH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any material not destined to be merged before v6.7-rc1
into your linux-next included branches until after v6.7-rc1 has been
released. Bug fixes are always welcome.

Changes since 20231107:

Non-merge commits (relative to Linus' tree): 1110
 1170 files changed, 29178 insertions(+), 20921 deletions(-)

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
Merging origin/master (13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/vfs/vfs)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (a2b67b6fe611 kexec-fix-kexec_file=
-dependencies-fix)
Merging kbuild-current/fixes (04714e55eb72 kconfig: avoid an infinite loop =
in oldconfig/syncconfig)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (2dde18cd1d8f Linux 6.5)
Merging arm64-fixes/for-next/fixes (4785aa802853 cpuidle, ACPI: Evaluate LP=
I arch_flags for broadcast timer)
Merging arm-soc-fixes/arm/fixes (736a4aad8a9f Merge tag 'renesas-fixes-for-=
v6.6-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel into arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
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
Merging net/main (115c0f4d5857 idpf: fix potential use-after-free in idpf_t=
so())
Merging bpf/master (d84b139f53e8 selftests/bpf: Fix broken build where char=
 is unsigned)
Merging ipsec/master (de5724ca38fd xfrm: fix a data-race in xfrm_lookup_wit=
h_ifid())
Merging netfilter/main (016b9332a334 netlink: fill in missing MODULE_DESCRI=
PTION())
Merging ipvs/main (a63b6622120c net/sched: act_ct: additional checks for ou=
tdated flows)
Merging wireless/for-next (55c900477f5b net: fill in MODULE_DESCRIPTION()s =
under drivers/net/)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (94f6f0550c62 Linux 6.6-rc5)
Merging sound-current/for-linus (df42ee7e22f0 ALSA: hda: Add ASRock X670E T=
aichi to denylist)
Merging sound-asoc-fixes/for-linus (45f2f28bd498 ASoC: SOF: sof-client: tri=
vial: fix comment typo)
Merging regmap-fixes/for-linus (f33804f1597d Merge remote-tracking branch '=
regmap/for-6.6' into regmap-linus)
Merging regulator-fixes/for-linus (bc00d9f3813a regulator: qcom-rpmh: Fix s=
mps4 regulator for pm8550ve)
Merging spi-fixes/for-linus (14c4fb111a39 Merge remote-tracking branch 'spi=
/for-6.6' into spi-linus)
Merging pci-current/for-linus (27beb3ca347f Merge tag 'pci-v6.7-changes' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci)
Merging driver-core.current/driver-core-linus (d2f51b3516da Merge tag 'rtc-=
6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging tty.current/tty-linus (d2f51b3516da Merge tag 'rtc-6.7' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging usb.current/usb-linus (1a229d8690a0 Revert "usb: phy: add usb phy n=
otify port status API")
Merging usb-serial-fixes/usb-linus (52480e1f1a25 USB: serial: option: add F=
ibocom to DELL custom modem FM101R-GL)
Merging phy/fixes (05d3ef8bba77 Linux 6.6-rc7)
Merging staging.current/staging-linus (be3ca57cfb77 Merge tag 'media/v6.7-1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging iio-fixes/fixes-togreg (bce3ab29a6c0 iio: common: ms_sensors: ms_se=
nsors_i2c: fix humidity conversion time table)
Merging counter-current/counter-current (58720809f527 Linux 6.6-rc6)
Merging char-misc.current/char-misc-linus (be3ca57cfb77 Merge tag 'media/v6=
.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging soundwire-fixes/fixes (58720809f527 Linux 6.6-rc6)
Merging thunderbolt-fixes/fixes (ec4405ed9203 thunderbolt: Call tb_switch_p=
ut() once DisplayPort bandwidth request is finished)
Merging input-current/for-linus (cdd5b5a9761f Merge branch 'next' into for-=
linus)
Merging crypto-current/master (9aedd10fe384 crypto: ahash - Set using_shash=
 for cloned ahash wrapper over shash)
Merging vfio-fixes/for-linus (c777b11d34e0 vfio/mdev: Fix a null-ptr-deref =
bug for mdev_unregister_parent())
Merging kselftest-fixes/fixes (cf5a103c98a6 selftests/user_events: Fix abi_=
test for BE archs)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (58720809f527 Linux 6.6-rc6)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (f6ca3fb6978f mtd: rawnand: Ensure the nand chi=
p supports cached reads)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (c46f16f156ac media: i2c: ov8858: Don't set fwn=
ode in the driver)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (8a749fd1a872 Linux 6.6-rc4)
Merging at91-fixes/at91-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging omap-fixes/fixes (0b9a4a67c60d clk: ti: Fix missing omap5 mcbsp fun=
ctional clock and aliases)
Merging kvm-fixes/master (ffc253263a13 Linux 6.6)
Merging kvms390-fixes/master (f87ef5723536 KVM: s390: fix gisa destroy oper=
ation might lead to cpu stalls)
Merging hwmon-fixes/hwmon (9da2901c4733 hwmon: (pmbus/mp2975) Move PGOOD fi=
x)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (8f61d48c83f6 tools/testing/cxl: Slow down the mock=
 firmware transfer)
Merging btrfs-fixes/next-fixes (db2fc5f63a3a Merge branch 'misc-6.7' into n=
ext-fixes)
Merging vfs-fixes/fixes (dc32464a5fe4 ceph_wait_on_conflict_unlink(): grab =
reference before dropping ->d_lock)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (3bde7ec13c97 platform/x86: Add s2idle quir=
k for more Lenovo laptops)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (19007c629c63 dt-bindings: trivial-device=
s: Fix MEMSIC MXC4005 compatible string)
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (097c06394c83 scsi: qla2xxx: Fix double free of ds=
d_list during driver load)
Merging drm-fixes/drm-fixes (44117828ed5c Merge tag 'amd-drm-fixes-6.6-2023=
-10-25' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (4cbed7702eb7 drm/i915/pmu: Ch=
eck if pmu is closed before stopping event)
Merging mmc-fixes/fixes (015c9cbcf0ad mmc: sdhci-pci-gli: GL9750: Mask the =
replay timer timeout of AER)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (58720809f527 Linux 6.6-rc6)
Merging hyperv-fixes/hyperv-fixes (42999c904612 hv/hv_kvp_daemon:Support fo=
r keyfile based connection profile)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3fec323339a4 drivers: perf: Fix panic in riscv =
SBI mmap support)
Merging riscv-dt-fixes/riscv-dt-fixes (cf98fe6b579e riscv: dts: starfive: v=
isionfive 2: correct spi's ss pin)
Merging riscv-soc-fixes/riscv-soc-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga-fixes/fixes (03d4bf9ff34a fpga: Fix memory leak for fpga_regio=
n_test_class_find())
Merging spdx/spdx-linus (d2f51b3516da Merge tag 'rtc-6.7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging gpio-brgl-fixes/gpio/for-current (05d3ef8bba77 Linux 6.6-rc7)
Merging gpio-intel-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-intel-fixes/fixes (2d325e54d9e2 pinctrl: baytrail: fix debo=
unce disable case)
Merging erofs-fixes/fixes (3048102d9d68 erofs: update documentation)
Merging kunit-fixes/kunit-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (0d32a6bbb8e7 NFSD: Fix zero NFSv4 READ resul=
ts when RQ_SPLICE_OK is not set)
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
Merging battery-fixes/fixes (8894b4325488 power: supply: qcom_battmgr: fix =
enable request endianness)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging rust-fixes/rust-fixes (cfd96726e611 rust: docs: fix logo replacemen=
t)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pmdomain-fixes/fixes (b131329b9bfb pmdomain: amlogic: Fix mask for =
the second NNA mem PD domain)
Merging overlayfs-fixes/ovl-fixes (beae836e9c61 ovl: temporarily disable ap=
pending lowedirs)
Merging drm-misc-fixes/for-linux-next-fixes (0e8b9f258bae drm/qxl: prevent =
memory leak)
Merging mm-stable/mm-stable (be3ca57cfb77 Merge tag 'media/v6.7-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging mm-nonmm-stable/mm-nonmm-stable (be3ca57cfb77 Merge tag 'media/v6.7=
-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging mm/mm-everything (9489317c7277 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (5f56cb030e4b kbuild: support 'userldlibs' syntax)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (fed3a1be6433 Merge tag 'perf-tools-fixes-for-=
v6.6-2-2023-10-20' into perf-tools-next)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (a409d9600959 dma-mapping: fix dma_addressing_=
limited() if dma_range_map can't cover all system RAM)
Merging asm-generic/master (550087a0ba91 hexagon: Remove unusable symbols f=
rom the ptrace.h uapi)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (c7368ddba2ff ARM: 9326/1: make <linux/uaccess.h> self=
-contained for ARM)
Merging arm64/for-next/core (403edfa43628 arm64/arm: arm_pmuv3: perf: Don't=
 truncate 64-bit registers)
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
Merging drivers-memory/for-next (09de3691daab memory: Use device_get_match_=
data())
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
Merging renesas/next (fb39831a07ec Merge branch 'renesas-fixes-for-v6.6' in=
to renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (043d3ef3344a Merge branch 'v6.8-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (b7df1b3a7a1b Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (93a72958a951 Merge branch 'for-next/ffa/fixes'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into f=
or-linux-next)
Merging stm32/stm32-next (1aeb02d3f2c5 ARM: dts: stm32: add SDIO pinctrl sl=
eep support on stm32f7 boards)
Merging sunxi/sunxi/for-next (c3f7c14856eb riscv: dts: allwinner: convert i=
sa detection to new properties)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (650220c2b474 Merge branch for-6.7/arm64/dt into for=
-next)
Merging ti/ti-next (2234981539e7 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (7d2da28125ce Merge branch 'zynqmp/dt' into for-nex=
t)
Merging clk/clk-next (0a6d7f8275f2 Merge branch 'clk-cleanup' into clk-next)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (4bce4bedbe6d clk: renesas: r9a08g045: Add =
clock and reset support for SDHI1 and SDHI2)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (99070159221b LoongArch: Support PREEMPT_D=
YNAMIC with static keys)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (2508b608f402 m68k: 68000: fix warning in timer =
code)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (4b7d3ab44565 MIPS: AR7: remove platform)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (166b0110d1ee parisc/pgtable: Do not drop upper =
5 address bits of physical address)
Merging powerpc/next (707df298cbde Merge tag 'powerpc-6.7-1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (e0c0a7c35f67 riscv: select ARCH_PROC_KCORE_TEXT)
CONFLICT (content): Merge conflict in arch/riscv/include/asm/csr.h
CONFLICT (content): Merge conflict in arch/riscv/kernel/irq.c
Merging riscv-dt/riscv-dt-for-next (b99df6281891 riscv: dts: sophgo: remove=
 address-cells from intc node)
Merging riscv-soc/riscv-soc-for-next (22dedf8f4570 soc/microchip: mpfs-sys-=
controller: Convert to platform remove callback returning void)
Merging s390/for-next (02e790ee3077 s390/mm: make pte_free_tlb() similar to=
 pXd_free_tlb())
Merging sh/for-next (63f1ee206170 locking/atomic: sh: Use generic_cmpxchg_l=
ocal for arch_cmpxchg_local())
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (a83a72730c33 xtensa: import ESP32S3 core va=
riant)
Merging bcachefs/for-next (c7046ed0cf9b bcachefs: Improve stripe checksum e=
rror message)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (15baf55481de fscrypt: track master key presence s=
eparately from secret)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (c6e8f898f56f btrfs: open code timespec64 in struct =
btrfs_inode)
Merging ceph/master (87cbdc270d48 libceph: check data length when sparse re=
ad finishes)
CONFLICT (content): Merge conflict in fs/ceph/inode.c
Merging cifs/for-next (0bffeed013ec smb3: more minor cleanups for session h=
andling routines)
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
Merging f2fs/dev (1e7bef5f90ed f2fs: finish previous checkpoints before ret=
urning from remount)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (513dfacefd71 fuse: share lookup state between submou=
nt and its parent)
Merging gfs2/for-next (0cdc6f44e9fd gfs2: don't withdraw if init_threads() =
got interrupted)
Merging jfs/jfs-next (5afb50b46a98 jfs: fix shift-out-of-bounds in dbJoin)
Merging ksmbd/ksmbd-for-next (b5fcfb5619e6 ksmbd: fix kernel-doc comment of=
 ksmbd_vfs_kern_path_locked())
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (3fd2ca5be07f svcrdma: Fix tracepoint printk format)
Merging ntfs3/master (e4494770a5ca fs/ntfs3: Avoid possible memory leak)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (24e16e385f22 ovl: add support for appendi=
ng lowerdirs one by one)
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (ce0708796420 9p/net: fix possible memory leak in p9_c=
heck_errors())
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (14a537983b22 xfs: allow read IO and FICLONE to run co=
ncurrently)
CONFLICT (content): Merge conflict in fs/xfs/libxfs/xfs_rtbitmap.c
CONFLICT (content): Merge conflict in fs/xfs/xfs_rtalloc.c
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
Merging vfs-brauner/vfs.all (bb04c104612f Merge branch 'vfs.f_fsid' into vf=
s.all)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting.rst
Merging vfs/for-next (1aee9158bc97 nfsd: lock_rename() needs both directori=
es to live on the same fs)
Merging printk/for-next (b4908d68609b Merge branch 'for-6.7' into for-next)
Merging pci/next (27beb3ca347f Merge tag 'pci-v6.7-changes' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/pci/pci)
Merging pstore/for-next/pstore (a19d48f7c5d5 pstore/platform: Add check for=
 kstrdup)
Merging hid/for-next (55ec92989f9b Merge branch 'for-6.6/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (b871ee43a733 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (9fd00df05e81 i3c: master: handle IBIs in order they c=
ame)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (0f564130e5c7 hwmon: (aquacomputer_d5next)=
 Check if temp sensors of legacy devices are connected)
Merging jc_docs/docs-next (cf63348b4c45 scripts/kernel-doc: Fix the regex f=
or matching -Werror flag)
Merging v4l-dvb/master (3e238417254b media: nuvoton: VIDEO_NPCM_VCD_ECE sho=
uld depend on ARCH_NPCM)
Merging v4l-dvb-next/master (3e238417254b media: nuvoton: VIDEO_NPCM_VCD_EC=
E should depend on ARCH_NPCM)
Merging pm/linux-next (742513f48261 Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (5b5b5806f223 cpufreq: qcom-nvme=
m: Introduce cpufreq for ipq95xx)
Merging cpupower/cpupower (6feb1a964119 cpupower: fix reference to nonexist=
ent document)
Merging devfreq/devfreq-next (8f0cd531ee18 dt-bindings: devfreq: event: roc=
kchip,dfi: Add rk3588 support)
Merging pmdomain/next (9e0cceadb7a5 pmdomain: Merge branch fixes into next)
Merging opp/opp/linux-next (5306fe37284c opp: ti: Use device_get_match_data=
())
Merging thermal/thermal/linux-next (9618efe343ea thermal/qcom/tsens: Drop o=
ps_v0_1)
Merging dlm/next (eb53c01873ca MAINTAINERS: Update dlm maintainer and web p=
age)
Merging rdma/for-next (2ef422f063b7 IB/mlx5: Fix init stage error handling =
to avoid double free of same QP and UAF)
Merging net-next/main (ff269e2cd5ad Merge tag 'net-next-6.7-followup' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf-next/for-next (ff269e2cd5ad Merge tag 'net-next-6.7-followup' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
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
Merging wireless-next/for-next (cc54d2e2c58a MAINTAINERS: Remove linuxwwan@=
intel.com mailing list)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (565fe150624e mtd: cfi_cmdset_0001: Byte swap OTP info)
Merging nand/nand/next (5a985960a4dd mtd: rawnand: meson: check return valu=
e of devm_kasprintf())
Merging spi-nor/spi-nor/next (6823a8383420 mtd: spi-nor: micron-st: use SFD=
P table for mt25qu512a)
Merging crypto/master (a312e07a65fb crypto: adiantum - flush destination pa=
ge before unmapping)
Merging drm/drm-next (9ccde17d4655 Merge tag 'amd-drm-next-6.7-2023-11-03' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_bio=
s.c
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (94565e95e247 drm/ssd130x: Fix possible uni=
nitialized usage of crtc_state variable)
Merging amdgpu/drm-next (20238a2cc9a6 drm/amdgpu: add RAS reset/query opera=
tions for XGMI v6_4)
Merging drm-intel/for-linux-next (9506fba463fc drm/i915/tc: Fix -Wformat-tr=
uncation in intel_tc_port_init)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (b08d26dac1a1 drm/msm/a7xx: actually use a7xx stat=
e registers)
Merging drm-msm-lumag/msm-next-lumag (d3b4075b173f drm/msm/dp: use correct =
lifetime device for devm_drm_bridge_add)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (d458382207d8 fb: omapfb/tpd12s015: Convert to platf=
orm remove callback returning void)
Merging regmap/for-next (f33804f1597d Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-linus)
Merging sound/for-next (df42ee7e22f0 ALSA: hda: Add ASRock X670E Taichi to =
denylist)
Merging ieee1394/for-next (c12d7aa7ffa4 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (45f2f28bd498 ASoC: SOF: sof-client: trivial: f=
ix comment typo)
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
Merging battery/for-next (469d31745b9f power: reset: vexpress: Use device_g=
et_match_data())
Merging regulator/for-next (8af4b4efdac9 Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (e50856067289 lsm: fix a spelling mistake)
Merging apparmor/apparmor-next (6cede10161be apparmor: Fix some kernel-doc =
comments)
Merging integrity/next-integrity (b836c4d29f27 ima: detect changes to the b=
acking overlay file)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (f5bbdeda34c6 Automated merge of 'dev' into 'next')
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (03acb9ccec3f keys: Remove unused extern declarations)
Merging watchdog/master (9d08e5909c81 dt-bindings: watchdog: Add support fo=
r Amlogic C3 and S4 SoCs)
Merging iommu/next (e8cca466a84a Merge branches 'iommu/fixes', 'arm/tegra',=
 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd', 'core' and 's390' into next)
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
CONFLICT (content): Merge conflict in drivers/iommu/iommufd/selftest.c
CONFLICT (content): Merge conflict in include/linux/iommu.h
Merging audit/next (47846d51348d audit: don't take task_lock() in audit_exe=
_compare() code path)
Merging devicetree/for-next (fe612629746c dt-bindings: soc: fsl: cpm_qe: cp=
m1-scc-qmc: Add support for QMC HDLC)
Merging dt-krzk/for-next (d896029c9726 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/for-next (96cb7a4e296d dt-bindings: mailbox: qcom-ipcc: doc=
ument the SM8650 Inter-Processor Communication Controller)
Merging spi/for-next (14c4fb111a39 Merge remote-tracking branch 'spi/for-6.=
6' into spi-linus)
Merging tip/master (e2e7af5cc8ab Merge branch into tip/master: 'x86/urgent')
Merging clockevents/timers/drivers/next (c28ca80ba3b5 clocksource: ep93xx: =
Add driver for Cirrus Logic EP93xx)
Merging edac/edac-for-next (6f15b178cd63 EDAC/versal: Add a Xilinx Versal m=
emory controller driver)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (e1742fa172d5 Merge probes/for-next)
Merging rcu/rcu/next (7939f0d7b28c rcu: Restrict access to RCU CPU stall no=
tifiers)
Merging kvm/next (45b890f7689e Merge tag 'kvmarm-6.7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
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
Merging xen-tip/linux-next (ebbf7f070078 acpi/processor: sanitize _OSC/_PDC=
 capabilities for Xen dom0)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (d5ce8f4ed90b Merge branch 'for-6.7' into for-n=
ext)
Merging drivers-x86/for-next (94ace9eda882 platform/x86: inspur-platform-pr=
ofile: Add platform profile support)
Merging chrome-platform/for-next (47ea0ddb1f56 platform/chrome: cros_ec_lpc=
: Separate host command and irq disable)
Merging chrome-platform-firmware/for-firmware-next (0bb80ecc33a8 Linux 6.6-=
rc1)
Merging hsi/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (b9604be24158 leds: lp5521: Add an error chec=
k in lp5521_post_init_device)
Merging ipmi/for-next (bc3012f4e3a9 Merge tag 'v6.7-p1' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging driver-core/driver-core-next (d2f51b3516da Merge tag 'rtc-6.7' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging usb/usb-next (d2f51b3516da Merge tag 'rtc-6.7' of git://git.kernel.=
org/pub/scm/linux/kernel/git/abelloni/linux)
Merging thunderbolt/next (a558892b3456 thunderbolt: Fix one kernel-doc comm=
ent)
Merging usb-serial/usb-next (8a749fd1a872 Linux 6.6-rc4)
Merging tty/tty-next (d2f51b3516da Merge tag 'rtc-6.7' of git://git.kernel.=
org/pub/scm/linux/kernel/git/abelloni/linux)
Merging char-misc/char-misc-next (be3ca57cfb77 Merge tag 'media/v6.7-1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging accel/habanalabs-next (631808095a82 Merge tag 'amd-drm-next-6.7-202=
3-10-27' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging coresight/next (5ce62920de12 coresight: etm4x: Fix width of CCITMIN=
 field)
Merging fastrpc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga/for-next (d79eed22ba97 fpga: versal: Add support for 44-bit DM=
A operations)
Merging icc/icc-next (d4c720a19e9a Merge branch 'icc-platform-remove' into =
icc-next)
Merging iio/togreg (89e2233386a5 iio: proximity: sx9324: Switch to device_p=
roperty_match_property_string())
Merging phy-next/next (d688c8264b8e phy: Remove duplicated include in phy-r=
alink-usb.c)
Merging soundwire/next (4ea2b6d3128e soundwire: dmi-quirks: update HP Omen =
match)
Merging extcon/extcon-next (b3edc3463d64 extcon: realtek: add the error han=
dler for nvmem_cell_read)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (2b88119e35b0 vfio/mtty: Enable migration support)
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (be3ca57cfb77 Merge tag 'media/v6.7-1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging counter-next/counter-next (7904cdf1397c counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (03f25d53b145 dmaengine: stm32-mdma: correct desc pr=
ep when channel running)
Merging cgroup/for-next (b9a477034b11 Merge branch 'for-6.7' into for-next)
Merging scsi/for-next (88eed215d016 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (a75a16c62a25 scsi: ufs: core: Leave space for 'M=
erging vhost/linux-next (e07754e0a1ea vhost-vdpa: fix use after free in vho=
st_vdpa_probe())
Merging rpmsg/for-next (6dc66a309673 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (5be55473a064 pinctrl: tegra: drop the wrap=
per around pinctrl_gpio_request())
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (63bffc2d3a99 pinctrl: Use device_get_match_data())
Merging pinctrl-intel/for-next (8d751da9f1d7 pinctrl: intel: fetch communit=
y only when we need it)
Merging pinctrl-renesas/renesas-pinctrl (583d80732055 pinctrl: renesas: rzn=
1: Convert to platform remove callback returning void)
Merging pinctrl-samsung/for-next (8aec97decfd0 pinctrl: samsung: do not off=
set pinctrl numberspaces)
Merging pwm/for-next (40592064a1a5 pwm: samsung: Document new member .chann=
el in struct samsung_pwm_chip)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (5247e6dbed00 selftests/resctrl: Fix MBM test failur=
e when MBA unavailable)
Merging kunit/test (0bb80ecc33a8 Linux 6.6-rc1)
Merging kunit-next/kunit (8040345fdae4 kunit: test: Fix the possible memory=
 leak in executor_test)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (cfb67623ce28 dt-bindings: rtc: Add Mstar SSD202D RTC)
Merging nvdimm/libnvdimm-for-next (9ea459e477dc libnvdimm: remove kernel-do=
c warnings:)
Merging at24/at24/for-next (3774740fb221 eeprom: at24: add ST M24C64-D Addi=
tional Write lockable page support)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (31c65705a8cf perf/benchmark: fix seccomp_=
unotify benchmark for 32-bit)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (23816724fdbd kdb: Corrects comment for kdballoc=
env)
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (12606ba1d46b bus: mhi: ep: Do not allocate event ring=
 element on stack)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (5d09c63f11f0 cxl/hdm: Remove broken error path)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (5329aa5101f7 efivarfs: Add uid/gid mount options)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/slab/for-next (90f055df1121 mm/slub: refactor calculate_order(=
) and calc_slab_order())
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
Merging hte/for-next (fc62d5e214df hte: Use kasprintf() instead of fixed bu=
ffer formatting)
Merging kspp/for-next/kspp (9cca73d7b4bf hwmon: (acpi_power_meter) replace =
open-coded kmemdup_nul)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (b2b67c997bf7 iommufd: Organize the mock domain al=
loc functions closer to Joerg's tree)

--Sig_/VBG.1AFdhXOk=cG+3r=Y7EH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVLEzgACgkQAVBC80lX
0GzboAf+KrClDMhmm59+W3S4xbGY1qTcHiphpBiHsgkIRXbW90gcKMwm8BDTd2rw
aSwPCyR8vvkuHOFQ9NitpLaoVnZwREUi79RyiEl1GHv4LMIkO4yaRCiIVft9UQM5
I43oyvlcJDzR6zmaDtHuvO5+2y+RFmSLGr6rS4E1rnPCUBFYAvg10WYq36tGq7wr
xfJp+yBrvnIpEbNuRMl74ys79jt7WHefociSZGkbpCC+Riq2LWPYvnlU6PPcsvjf
wa8VeDnvYLWHeSSQ9uGt6/1aUZB8/AajjOg3GgGSEzG+LXojXMHR5SzspjXN4TCp
ERnM7ENH5gTjg+y3Q71ls9xTa32S0w==
=YAJZ
-----END PGP SIGNATURE-----

--Sig_/VBG.1AFdhXOk=cG+3r=Y7EH--
