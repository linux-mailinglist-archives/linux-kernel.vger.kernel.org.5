Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B57C9E75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjJPFKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPFK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:10:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D276ED;
        Sun, 15 Oct 2023 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697433019;
        bh=62yi+0nrCEg2cQ1+OujgXjnuVLVvAInYfKN+B1QO6VI=;
        h=Date:From:To:Cc:Subject:From;
        b=JREoT+SbHkXIATEDw8CmOG1x/CbSiLJclYcykUSKX449BuY3EKB03U1XQ83gQRNGf
         RdsIiilgRMBjTn6YJXZYiKAjo9eYnm6tzl6uRj7I0PKbEjb23F0j5fTTc4c8JRufm3
         lvzkZcjKnY0DO/04mOjE5yD5s2Rw2EdXxZv+gToY3pmqjDLEtJIqGs0rxwA9L3m+0m
         S02dV00N8Cr26IJgh65Dhk4zoha03C1rFBGvWoqv8T143ZPVFQCv0qtlpumn4x5Wgp
         dsesPrdCXBiin8stRSxWBraBQlp0mqpv4fS2ViK/TBfELsbhmxGZeubzS5UXQ45RhI
         fgMMRelMAtMzg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S84tg26bPz4x1p;
        Mon, 16 Oct 2023 16:10:19 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 16:10:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 16
Message-ID: <20231016161018.52ca6244@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fp/CD+.jjedsAa84dW8_iSf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fp/CD+.jjedsAa84dW8_iSf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231013:

The bpf-next tree lost its build failure.

The amdgpu tree still had its build failure so I used the version from
next-20231009.

The tip tree gained a conflict against Linus' tree.

The gpio-brgl tree list its build failure and gained a conflict against
the usb tree.

The rtc tree gained a build failure for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 11658
 9752 files changed, 655083 insertions(+), 200125 deletions(-)

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

I am currently merging 368 trees (counting Linus' and 105 trees of bug
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
Merging origin/master (58720809f527 Linux 6.6-rc6)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (836ff2cb6c5c selftests/clone3: Fi=
x broken test under !CONFIG_TIME_NS)
Merging kbuild-current/fixes (8a749fd1a872 Linux 6.6-rc4)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (2dde18cd1d8f Linux 6.5)
Merging arm64-fixes/for-next/fixes (4785aa802853 cpuidle, ACPI: Evaluate LP=
I arch_flags for broadcast timer)
Merging arm-soc-fixes/arm/fixes (26de14831cf6 IXP4xx MAINTAINERS entries)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (eb1e6ccdcf78 zorro: Include zorro.h in name=
s.c)
Merging powerpc-fixes/fixes (ff9e8f415136 powerpc/mm: Allow ARCH_FORCE_MAX_=
ORDER up to 12)
Merging s390-fixes/fixes (5c95bf274665 s390/cert_store: fix string length h=
andling)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (883f0dc0e4f6 Merge branch 'ovs-selftests')
Merging bpf/master (a307f5a24924 bpf: Avoid unnecessary -EBUSY from htab_lo=
ck_bucket)
Merging ipsec/master (513f61e21933 net: ipv4: fix return value check in esp=
_remove_trailer)
Merging netfilter/main (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging ipvs/main (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git://=
git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging wireless/for-next (f2ac54ebf856 net: rfkill: reduce data->mtx scope=
 in rfkill_fop_open)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (94f6f0550c62 Linux 6.6-rc5)
Merging sound-current/for-linus (4a63e68a2951 ALSA: usb-audio: Fix micropho=
ne sound on Nexigo webcam.)
Merging sound-asoc-fixes/for-linus (9c97790a07dc ASoC: dwc: Fix non-DT inst=
antiation)
Merging regmap-fixes/for-linus (7a795ac8d49e regmap: rbtree: Fix wrong regi=
ster marked as in-cache when creating new node)
Merging regulator-fixes/for-linus (6e800968f6a7 regulator/core: Revert "fix=
 kobject release warning and memory leak in regulator_register()")
Merging spi-fixes/for-linus (2ec8b0109790 spi: npcm-fiu: Fix UMA reads when=
 dummy.nbytes =3D=3D 0)
Merging pci-current/for-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging driver-core.current/driver-core-linus (8a749fd1a872 Linux 6.6-rc4)
Merging tty.current/tty-linus (b3fa3cf02e3c ASoC: ti: ams-delta: Fix cx8180=
1_receive() argument types)
Merging usb.current/usb-linus (c9ca8de2eb15 usb: typec: ucsi: Use GET_CAPAB=
ILITY attributes data to set power supply scope)
Merging usb-serial-fixes/usb-linus (064f6e2ba9eb USB: serial: option: add e=
ntry for Sierra EM9191 with new firmware)
Merging phy/fixes (089667aaaa6a phy: realtek: Realtek PHYs should depend on=
 ARCH_REALTEK)
Merging staging.current/staging-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging iio-fixes/fixes-togreg (e2bd8c28b9bd iio: adc: xilinx-xadc: Correct=
 temperature offset/scale for UltraScale)
Merging counter-current/counter-current (df8fdd01c98b counter: microchip-tc=
b-capture: Fix the use of internal GCLK logic)
Merging char-misc.current/char-misc-linus (ffd1f150fffe Merge tag 'iio-fixe=
s-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (3b6c4a11bf2b soundwire: bus: Make IRQ handli=
ng conditionally built)
Merging thunderbolt-fixes/fixes (ec4405ed9203 thunderbolt: Call tb_switch_p=
ut() once DisplayPort bandwidth request is finished)
Merging input-current/for-linus (5c15c60e7be6 Input: powermate - fix use-af=
ter-free in powermate_config_complete)
Merging crypto-current/master (152d0bcdf1ef dm crypt: Fix reqsize in crypt_=
iv_eboiv_gen)
Merging vfio-fixes/for-linus (c777b11d34e0 vfio/mdev: Fix a null-ptr-deref =
bug for mdev_unregister_parent())
Merging kselftest-fixes/fixes (6f874fa021df selftests: Fix wrong TARGET in =
kselftest top level Makefile)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (3fa53518ad41 dmaengine: fsl-edma: fix all ch=
annels requested when call fsl_edma3_xlate())
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (5279f4a9eed3 mtd: rawnand: qcom: Unmap the rig=
ht resource upon probe failure)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (c46f16f156ac media: i2c: ov8858: Don't set fwn=
ode in the driver)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (8a749fd1a872 Linux 6.6-rc4)
Merging at91-fixes/at91-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging omap-fixes/fixes (0b9a4a67c60d clk: ti: Fix missing omap5 mcbsp fun=
ctional clock and aliases)
Merging kvm-fixes/master (ba8c993c3748 x86/cpu: amd: fix warning in W=3D1 b=
uild)
Merging kvms390-fixes/master (f87ef5723536 KVM: s390: fix gisa destroy oper=
ation might lead to cpu stalls)
Merging hwmon-fixes/hwmon (6465e260f487 Linux 6.6-rc3)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (c66650d29764 cxl/acpi: Annotate struct cxl_cxims_d=
ata with __counted_by)
Merging btrfs-fixes/next-fixes (dcb1886a86a4 Merge branch 'misc-6.6' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (51064b7acf66 platform/x86: wmi: Update MAI=
NTAINERS entry)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (19007c629c63 dt-bindings: trivial-device=
s: Fix MEMSIC MXC4005 compatible string)
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (a20c4350c6a1 scsi: ufs: core: Correct clear TM er=
ror log)
Merging drm-fixes/drm-fixes (30873697b837 Merge tag 'amd-drm-fixes-6.6-2023=
-10-11' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (94f6f0550c62 Linux 6.6-rc5)
Merging mmc-fixes/fixes (84ee19bffc93 mmc: core: Capture correct oemid-bits=
 for eMMC cards)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging hyperv-fixes/hyperv-fixes (42999c904612 hv/hv_kvp_daemon:Support fo=
r keyfile based connection profile)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (3fec323339a4 drivers: perf: Fix panic in riscv =
SBI mmap support)
Merging riscv-dt-fixes/riscv-dt-fixes (cf98fe6b579e riscv: dts: starfive: v=
isionfive 2: correct spi's ss pin)
Merging riscv-soc-fixes/riscv-soc-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga-fixes/fixes (6a935361500a fpga: Fix memory leak for fpga_regio=
n_test_class_find())
Merging spdx/spdx-linus (8a749fd1a872 Linux 6.6-rc4)
Merging gpio-brgl-fixes/gpio/for-current (94f6f0550c62 Linux 6.6-rc5)
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
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (f38f547314b8 perf dlfilter: Add a test for=
 object_code())
Merging efi-fixes/urgent (0d3ad1917996 efi: fix memory leak in krealloc fai=
lure handling)
Merging zstd-fixes/zstd-linus (f064f4e5ecb1 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (8894b4325488 power: supply: qcom_battmgr: fix =
enable request endianness)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging rust-fixes/rust-fixes (344b6c0a7514 rust: fix bindgen build error w=
ith fstrict-flex-arrays)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pmdomain-fixes/fixes (767881c470b3 pmdomain: imx: scu-pd: correct D=
MA2 channel)
Merging overlayfs-fixes/ovl-fixes (beae836e9c61 ovl: temporarily disable ap=
pending lowedirs)
Merging drm-misc-fixes/for-linux-next-fixes (4366faf43308 drm/nouveau/disp:=
 fix DP capable DSM connectors)
Merging mm-stable/mm-stable (2b76550922a8 mm/ksm: document pages_skipped sy=
sfs knob)
Merging mm-nonmm-stable/mm-nonmm-stable (c37e56cac3d6 crash_core.c: remove =
unneeded functions)
Merging mm/mm-everything (2ae6ac8b1d58 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (ffa46bbc5892 kbuild: rpm-pkg: generate kernel.spec=
 in rpmbuild/SPECS/)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (a16afcc58a8c perf cs-etm: Fix incorrect or mi=
ssing decoder for raw trace)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (2d5780bbef8d swiotlb: fix the check whether a=
 device has used software IO TLB)
Merging asm-generic/master (f82060480095 asm-generic: Fix spelling of archi=
tecture)
CONFLICT (modify/delete): arch/ia64/include/asm/cpu.h deleted in asm-generi=
c/master and modified in HEAD.  Version HEAD of arch/ia64/include/asm/cpu.h=
 left in tree.
CONFLICT (modify/delete): arch/ia64/kernel/setup.c deleted in asm-generic/m=
aster and modified in HEAD.  Version HEAD of arch/ia64/kernel/setup.c left =
in tree.
CONFLICT (modify/delete): arch/ia64/kernel/topology.c deleted in asm-generi=
c/master and modified in HEAD.  Version HEAD of arch/ia64/kernel/topology.c=
 left in tree.
$ git rm -f arch/ia64/kernel/setup.c
$ git rm -f arch/ia64/include/asm/cpu.h arch/ia64/kernel/topology.c
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (c7368ddba2ff ARM: 9326/1: make <linux/uaccess.h> self=
-contained for ARM)
Merging arm64/for-next/core (c19b7014aaae Merge branch 'for-next/feat_lse12=
8' into for-next/core)
Merging arm-perf/for-next/perf (0abe7f61c28d docs/perf: Add ampere_cspmu to=
 toctree to fix a build warning)
Merging arm-soc/for-next (cda3f5e2e089 soc: document merges)
Merging amlogic/for-next (996fc07dce79 Merge branch 'v6.7/defconfig' into f=
or-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (32d514b6de63 ARM: dts: aspeed: mtmitchell: Add I2C=
 NVMe alias port)
Merging at91/at91-next (3cec9514911c ARM: dts: at91: sam9x60_curiosity: Add=
 mandatory dt property for RTT)
Merging broadcom/next (61641804ab35 Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (09de3691daab memory: Use device_get_match_=
data())
Merging imx-mxs/for-next (fa81543ef854 Merge branch 'imx/defconfig' into fo=
r-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/freescale/imx93.d=
tsi
Merging mediatek/for-next (e2a38d710912 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (93e6b023e552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (cb1114df7bb0 Merge branch 'fixes' into for-next)
Merging qcom/for-next (870b52222042 Merge branches 'arm64-defconfig-for-6.7=
', 'arm64-fixes-for-6.6', 'arm64-for-6.7', 'clk-for-6.7', 'drivers-for-6.7'=
 and 'dts-for-6.7' into for-next)
Merging renesas/next (11476f31ceaf Merge branch 'renesas-dts-for-v6.7' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (45dc525cfcd3 Merge branch 'v6.7-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (dac677d8e797 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (b98e85977c50 Merge branches 'for-next/scmi/upd=
ates', 'for-next/ffa/updates', 'for-next/vexpress/updates' and 'for-next/pc=
c/updates' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/li=
nux into for-linux-next)
Merging stm32/stm32-next (1aeb02d3f2c5 ARM: dts: stm32: add SDIO pinctrl sl=
eep support on stm32f7 boards)
Merging sunxi/sunxi/for-next (c3f7c14856eb riscv: dts: allwinner: convert i=
sa detection to new properties)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (650220c2b474 Merge branch for-6.7/arm64/dt into for=
-next)
Merging ti/ti-next (6c1e5a8266dd Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0f133188d6b8 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (b7c08e5d3824 Merge branch 'clk-doc' into clk-next)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (4bce4bedbe6d clk: renesas: r9a08g045: Add =
clock and reset support for SDHI1 and SDHI2)
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (2c10cda4b777 LoongArch: KVM: Add maintain=
ers for LoongArch KVM)
Merging m68k/for-next (48ceb35e7268 m68k: defconfig: Update virt_defconfig =
for v6.6-rc3)
Merging m68knommu/for-next (49827634a69b m68k: 68000: fix warning in timer =
code)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (4d0f332a6fb6 MIPS: Remove dead code in relocate_new=
_kernel)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (ce9ecca0238b Linux 6.6-rc2)
Merging powerpc/next (c7e0d9bb9154 powerpc: Only define __parse_fpscr() whe=
n required)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-dt/riscv-dt-for-next (81b5948cf1a7 riscv: dts: starfive: conv=
ert isa detection to new properties)
Merging riscv-soc/riscv-soc-for-next (22dedf8f4570 soc/microchip: mpfs-sys-=
controller: Convert to platform remove callback returning void)
Merging s390/for-next (a8dbae76e7bc Merge branch 'features' into for-next)
Merging sh/for-next (246f80a0b17f sh: push-switch: Reorder cleanup operatio=
ns to avoid use-after-free bug)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (a83a72730c33 xtensa: import ESP32S3 core va=
riant)
Merging bcachefs/for-next (1a97b93a13f8 bcachefs: Fix changing durability u=
sing sysfs)
Applying: bcachefs: convert to dynamically allocated shrinkers
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (3e7807d5a7d7 fscrypt: rename fscrypt_info =3D> fs=
crypt_inode_info)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (c6e8f898f56f btrfs: open code timespec64 in struct =
btrfs_inode)
Merging ceph/master (07bb00ef00ac ceph: fix type promotion bug on 32bit sys=
tems)
Merging cifs/for-next (bde45b6aa521 Add definition for new smb3.1.1 command=
 type)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (78a50b6a4166 erofs: fix inode metadata space layout desc=
ription in documentation)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (21cdd81765e7 Pull fsnotify cleanup.)
Merging ext4/dev (a37d4c46392e ext4: fix racy may inline data check in dio =
write)
Merging f2fs/dev (3e729e50d01e f2fs: preload extent_cache for POSIX_FADV_WI=
LLNEED)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (ae3024a4c499 docs/fuse-io: Document the usage of DIR=
ECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (18e0c7817d45 gfs2: No longer use 'extern' in functio=
n declarations)
Merging jfs/jfs-next (a779ed754e52 jfs: define xtree root and page independ=
ently)
Merging ksmbd/ksmbd-for-next (b0e493f09ffc ksmbd: fix kernel-doc comment of=
 ksmbd_vfs_setxattr())
Merging nfs/linux-next (9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes'=
 of git://git.samba.org/ksmbd)
Merging nfs-anna/linux-next (6a6d4644ce93 NFS: Fix potential oops in nfs_in=
ode_remove_request())
Merging nfsd/nfsd-next (2ce5c9d08168 svcrdma: Fix tracepoint printk format)
Merging ntfs3/master (e4494770a5ca fs/ntfs3: Avoid possible memory leak)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (fbaf916f84f4 ovl: Add documentation on ne=
sting of overlayfs mounts)
Merging ubifs/next (017c73a34a66 ubi: Refuse attaching if mtd's erasesize i=
s 0)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (cbc06310c36f xfs: reinstate the old i_version counter=
 as STATX_CHANGE_COOKIE)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (684f7e6d28e8 iomap: Spelling s/preceeding/pre=
ceding/g)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (216b1c1577a6 Merge branch 'vfs.super' into vfs=
.all)
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/namei.c
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
Applying: bcachefs: convert to new timestamp accessors
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (a26f18f291f6 Merge branch 'rework/misc-cleanups' i=
nto for-next)
Merging pci/next (87a836d6fc7a Merge branch 'pci/misc')
Merging pstore/for-next/pstore (a19d48f7c5d5 pstore/platform: Add check for=
 kstrdup)
Merging hid/for-next (d4ce72c23d31 Merge branch 'for-6.7/selftests' into fo=
r-next)
Merging i2c/i2c/for-next (f168a3309a18 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (57ec42b9a1b7 i3c: Fix typo "Provisional ID" to "Provi=
sioned ID")
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (443f18550476 hwmon: (adt7475) Add support=
 for Imon readout on ADT7490)
Merging jc_docs/docs-next (f949cb759051 docs/zh_TW: update contents for zh_=
TW)
Merging v4l-dvb/master (2c1bae27df78 media: qcom: camss: Fix pm_domain_on s=
equence in probe)
Merging v4l-dvb-next/master (94e27fbeca27 media: cec: meson: always include=
 meson sub-directory in Makefile)
Applying: v4l-dvb-next: fix up for bad automatic merge.
Merging pm/linux-next (8134843f53ba Merge branch 'thermal-intel' into linux=
-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (21135104a67e cpufreq: ARM_BRCMS=
TB_AVS_CPUFREQ cannot be used with ARM_SCMI_CPUFREQ)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (e50fa1a5ac52 PM / devfreq: exynos-ppmu: Use d=
evice_get_match_data())
Merging pmdomain/next (38a88d52dd37 pmdomain: Use device_get_match_data())
CONFLICT (content): Merge conflict in drivers/soc/apple/Kconfig
Merging opp/opp/linux-next (4cd8fe213512 OPP: No need to defer probe from _=
opp_attach_genpd())
Merging thermal/thermal/linux-next (edd220b33f47 thermal: core: Drop therma=
l_zone_device_register())
Merging dlm/next (eb53c01873ca MAINTAINERS: Update dlm maintainer and web p=
age)
Merging rdma/for-next (5ac388db27c4 RDMA/irdma: Add support to re-register =
a memory region)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/mr.c
Merging net-next/main (c49bba011b51 Merge branch 'ptp-multiple-readers')
CONFLICT (content): Merge conflict in net/mac80211/key.c
Merging bpf-next/for-next (0e10fd4b7a6d Merge branch 'Open-coded task_vma i=
ter')
Merging ipsec-next/master (efedce336d71 Merge branch 'xfrm: policy: replace=
 session decode with flow dissector')
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
Merging netfilter-next/main (35715ac13a77 Merge branch 'tls-cleanups')
Merging ipvs-next/main (35715ac13a77 Merge branch 'tls-cleanups')
Merging bluetooth/master (8fa4c368ba69 Bluetooth: ISO: Copy BASE if service=
 data matches EIR_BAA_SERVICE_UUID)
Merging wireless-next/for-next (b650981501bf wifi: rtw89: mac: do bf_monito=
r only if WiFi 6 chips)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (3cff177fc279 mtd: map_ram: prevent use of point and u=
npoint when NO_XIP is set)
Merging nand/nand/next (48919c6c4838 mtd: rawnand: remove 'nand_exit_status=
_op()' prototype)
Merging spi-nor/spi-nor/next (8f407eda173f mtd: spi-nor: atmel: add at25ff3=
21a entry)
Merging crypto/master (5b90073defd1 crypto: hisilicon/qm - alloc buffer to =
set and get xqc)
Merging drm/drm-next (389af786f92e Merge tag 'drm-intel-next-2023-09-29' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_fw.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_drv.h
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (0ddd30471a5d drm/panel: st7703: Fix timing=
s when entering/exiting sleep)
CONFLICT (modify/delete): arch/ia64/include/asm/fb.h deleted in HEAD and mo=
dified in drm-misc/for-linux-next.  Version drm-misc/for-linux-next of arch=
/ia64/include/asm/fb.h left in tree.
$ git rm -f arch/ia64/include/asm/fb.h
Applying: fix up for "drm: Add HPD state to drm_connector_oob_hotplug_event=
()"
Merging amdgpu/drm-next (cd90511557fd drm/amdgpu/vkms: fix a possible null =
pointer dereference)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dis=
covery.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_gfx=
.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_ras=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_doorbe=
ll.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_mqd_ma=
nager.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_svm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_topolo=
gy.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn32/=
dcn32_resource.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n20/dcn20_fpu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/d=
ce110/dce110_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/d=
cn20/dcn20_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/include/kgd_kfd_i=
nterface.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/amdgpu_pm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu_v13_0_6_pmfw.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu_v13_0_6_ppsmc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/smu_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu11/si=
enna_cichlid_ppt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
$ git reset --hard HEAD^
Merging next-20231009 version of amdgpu
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dis=
covery.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_gfx=
.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_mqd_ma=
nager.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_svm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_topolo=
gy.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce110=
/dce110_hw_sequencer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn20/=
dcn20_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn32/=
dcn32_resource.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/include/kgd_kfd_i=
nterface.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/amdgpu_pm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu_v13_0_6_ppsmc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/smu_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu11/si=
enna_cichlid_ppt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
[master 26abd32a4148] next-20231009/amdgpu
Merging drm-intel/for-linux-next (34d8311f4a1c drm/i915/dsb: Re-instate DSB=
 for LUT updates)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d3b4075b173f drm/msm/dp: use correct lifetime dev=
ice for devm_drm_bridge_add)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/dpu1/dpu_hw_=
interrupts.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/dpu1/dpu_kms=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/mdp4/mdp4_km=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/mdp5/mdp5_km=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/msm_drv.c
Merging drm-msm-lumag/msm-next-lumag (d3b4075b173f drm/msm/dp: use correct =
lifetime device for devm_drm_bridge_add)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (c1a8d1d0edb7 fbdev: atyfb: only use ioremap_uc() on=
 i386 and ia64)
Merging regmap/for-next (7b4d73072bcc Merge remote-tracking branch 'regmap/=
for-6.7' into regmap-next)
Merging sound/for-next (2b17b489e47a ALSA: scarlett2: Add Focusrite Clarett=
 2Pre and 4Pre USB support)
Merging ieee1394/for-next (a464d2f75fa1 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (e38ab5e537b0 Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-next)
CONFLICT (content): Merge conflict in sound/pci/hda/cs35l41_hda.c
Merging modules/modules-next (3111add7f414 module: Annotate struct module_n=
otes_attrs with __counted_by)
CONFLICT (content): Merge conflict in scripts/mod/modpost.c
Applying: fix up for "module: Make is_valid_name() return bool"
Merging input/next (6cd256694afe Input: tegra-kbc - use device_get_match_da=
ta())
Merging block/for-next (b7f443536443 Merge branch 'for-6.7/block' into for-=
next)
CONFLICT (content): Merge conflict in arch/alpha/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in arch/arm/tools/syscall.tbl
CONFLICT (content): Merge conflict in arch/arm64/include/asm/unistd.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/unistd32.h
CONFLICT (modify/delete): arch/ia64/kernel/syscalls/syscall.tbl deleted in =
HEAD and modified in block/for-next.  Version block/for-next of arch/ia64/k=
ernel/syscalls/syscall.tbl left in tree.
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
CONFLICT (content): Merge conflict in arch/xtensa/kernel/syscalls/syscall.t=
bl
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
$ git rm -f arch/ia64/kernel/syscalls/syscall.tbl
Merging device-mapper/for-next (1d99b7e95035 dm thin: Use the extent alloca=
tor for data blocks)
Merging libata/for-next (2da4c5e24e86 ata: libata-core: Improve ata_dev_pow=
er_set_active())
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (a2b8fa785358 mmc: jz4740: Use device_get_match_data())
Merging mfd/for-mfd-next (b5cd5e72a71e mfd: qcom-spmi-pmic: Switch to EXPOR=
T_SYMBOL_GPL())
Merging backlight/for-backlight-next (40da4737717b backlight: pwm_bl: Disab=
le PWM on shutdown, suspend and remove)
Merging battery/for-next (b3c3a197baf2 power: supply: cpcap: Drop non-DT dr=
iver matching)
Merging regulator/for-next (80e3e6f2037d Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (e50856067289 lsm: fix a spelling mistake)
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (c1f30e80ce2c ima: annotate iint mutex to =
avoid lockdep false positive warnings)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (19c1c9916dbf selinux: simplify avtab_insert_node() pr=
ototype)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (1c8b86a3799f Merge tag 'xsa441-6.6-tag' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/xen/tip)
Merging watchdog/master (db7673e6d578 Watchdog: marvell_gti_wdt: Remove red=
undant dev_err_probe() for platform_get_irq())
Merging iommu/next (52e9fd0e9a6b Merge branches 'arm/tegra', 's390', 'x86/a=
md' and 'core' into next)
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging audit/next (97f576eb38ae audit: Annotate struct audit_chunk with __=
counted_by)
Merging devicetree/for-next (00d589ace5f4 dt-bindings: writing-schema: add =
example for multiple DT_SCHEMA_FILES)
Merging dt-krzk/for-next (d896029c9726 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (713e934b7415 Merge remote-tracking branch 'spi/for-6.=
7' into spi-next)
Merging tip/master (541c0b0e9d0a Merge branch into tip/master: 'x86/tdx')
CONFLICT (content): Merge conflict in arch/x86/kernel/smpboot.c
CONFLICT (content): Merge conflict in include/linux/pci_ids.h
Merging clockevents/timers/drivers/next (0a8b07c77ea0 clocksource: Explicit=
ly include correct DT includes)
Merging edac/edac-for-next (0fd934580ea3 EDAC/versal: Add a Xilinx Versal m=
emory controller driver)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (fc1653abba0d Merge probes/for-next)
Merging rcu/rcu/next (c06828f759e8 srcu: Explain why callbacks invocations =
can't run concurrently)
Merging kvm/next (ba8c993c3748 x86/cpu: amd: fix warning in W=3D1 build)
Merging kvm-arm/next (cad9fde0c878 Merge branch kvm-arm64/mops into kvmarm/=
next)
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-ppc/topic/ppc-kvm (476652297f94 docs: powerpc: Document nested =
KVM on POWER)
CONFLICT (file location): Documentation/powerpc/kvm-nested.rst added in kvm=
-ppc/topic/ppc-kvm inside a directory that was renamed in HEAD, suggesting =
it should perhaps be moved to Documentation/arch/powerpc/kvm-nested.rst.
Merging kvm-riscv/riscv_kvm_next (62d0c458f828 KVM: riscv: selftests: get-r=
eg-list print_reg should never fail)
Merging kvm-x86/next (2bf2d3d16b8d Merge branches 'apic', 'docs', 'fpu', 'm=
isc', 'mmu', 'pmu', 'selftests', 'svm' and 'xen')
Merging xen-tip/linux-next (0fc6ff5a0f04 xen/efi: refactor deprecated strnc=
py)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (ef3e4fbc60e3 Merge branch 'for-6.6-fixes' into=
 for-next)
Merging drivers-x86/for-next (8abba0894466 platform/x86: msi-ec: Add more E=
C configs)
Merging chrome-platform/for-next (466f70fb1b10 platform/chrome: kunit: make=
 EC protocol tests independent)
Merging chrome-platform-firmware/for-firmware-next (0bb80ecc33a8 Linux 6.6-=
rc1)
Merging hsi/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (e0e29e434cdc leds: trigger: netdev: Move siz=
e check in set_device_name)
Merging ipmi/for-next (b00839ca4cca ipmi: refactor deprecated strncpy)
Merging driver-core/driver-core-next (36b2d7dd5a8a driver core: platform: A=
nnotate struct irq_affinity_devres with __counted_by)
Merging usb/usb-next (1034cc423f1b gpio: update Intel LJCA USB GPIO driver)
Merging thunderbolt/next (274baf695b08 thunderbolt: Add DP IN added last in=
 the head of the list of DP resources)
Merging usb-serial/usb-next (8a749fd1a872 Linux 6.6-rc4)
Merging tty/tty-next (dd976a97d15b tty/sysrq: replace smp_processor_id() wi=
th get_cpu())
CONFLICT (content): Merge conflict in drivers/tty/serial/serial_core.c
Merging char-misc/char-misc-next (d712d205210c rapidio: make all 'class' st=
ructures const)
Merging accel/habanalabs-next (4db74c0fdeb8 accel/habanalabs/gaudi2: fix sp=
mu mask creation)
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (9fffb8240581 misc: fastrpc: Clean buffers on remo=
te invocation failures)
Merging fpga/for-next (33f9b8812262 fpga: versal: Add support for 44-bit DM=
A operations)
Merging icc/icc-next (9330bf741fda Merge branch 'icc-misc' into icc-next)
Merging iio/togreg (73006239ef23 iio: resolver: ad2s1210: remove of_match_p=
tr())
Merging phy-next/next (03c866cab420 dt-bindings: phy: Convert PXA1928 USB/H=
SIC PHY to DT schema)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/phy=
/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
Merging soundwire/next (95b0f3aa71eb soundwire: qcom: Log clk_get("iface") =
failures)
Merging extcon/extcon-next (da886ba84479 extcon: max77843: add device-tree =
compatible string)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (bd885fcf28da vfio: Fix smatch errors in vfio_combine_iov=
a_ranges())
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (25d367506a28 staging: rtl8192e: Remove unused=
 file rtllib_debug.h)
Merging counter-next/counter-next (631c15d5f14d counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (8bf914570650 dmaengine: mmp_tdma: drop unused varia=
ble 'of_id')
Merging cgroup/for-next (ca2332016d31 Merge branch 'for-6.6-fixes' into for=
-next)
Merging scsi/for-next (e2187116a4dc Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (af46076d6640 Merge patch series "lpfc: Update lp=
fc to revision 14.2.0.15")
Merging vhost/linux-next (1acfe2c12258 virtio_ring: fix avail_wrap_counter =
in virtqueue_add_packed)
Merging rpmsg/for-next (a7d272979d3a Merge branches 'hwspinlock' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (8c85a102fc4e gpiolib: provide gpio_device_=
get_base())
CONFLICT (content): Merge conflict in drivers/gpio/gpio-ljca.c
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (c766fd3059c0 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (8d751da9f1d7 pinctrl: intel: fetch communit=
y only when we need it)
Merging pinctrl-renesas/renesas-pinctrl (583d80732055 pinctrl: renesas: rzn=
1: Convert to platform remove callback returning void)
Merging pinctrl-samsung/for-next (8aec97decfd0 pinctrl: samsung: do not off=
set pinctrl numberspaces)
Merging pwm/for-next (4bb36d126cb3 pwm: samsung: Document new member .chann=
el in struct samsung_pwm_chip)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (508934b5d15a selftests/resctrl: Move run_benchmark(=
) to a more fitting file)
Merging kunit/test (0bb80ecc33a8 Linux 6.6-rc1)
Merging kunit-next/kunit (8040345fdae4 kunit: test: Fix the possible memory=
 leak in executor_test)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (dc71c03b0a29 dt-bindings: rtc: microcrystal,rv3032: D=
ocument wakeup-source property)
Merging nvdimm/libnvdimm-for-next (dd6cad2dcb58 testing: nvdimm: make struc=
t class structures constant)
Merging at24/at24/for-next (4791146e9055 eeprom: at24: add ST M24C32-D Addi=
tional Write lockable page support)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (ce9ecca0238b Linux 6.6-rc2)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (d79c910284d2 Merge branch 'nvmem-fixes' into nvmem-=
for-next)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (0724869ede9c bus: mhi: host: pci_generic: add support=
 for Telit FE990 modem)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (b691118f2c44 Merge remote-tracking branch 'linux-efi/urge=
nt' into efi/next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/slab/for-next (e050a704f3c3 Merge branch 'slab/for-6.6/hotfixe=
s' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (96e033d649b3 landlock: Document Landlock's network s=
upport)
Merging rust/rust-next (a7135d107547 rust: Use grep -Ev rather than relying=
 on GNU grep)
Merging sysctl/sysctl-next (ccee9a2a8c00 intel drm: Remove now superfluous =
sentinel element from ctl_table array)
Merging execve/for-next/execve (21ca59b365c0 binfmt_misc: enable sandboxed =
mounts)
Merging bitmap/bitmap-for-next (b9c957f55444 bitmap: move bitmap_*_region()=
 functions to bitmap.h)
Merging hte/for-next (091ac92dc79e hte: tegra194: Switch to LATE_SIMPLE_DEV=
_PM_OPS())
Merging kspp/for-next/kspp (faed498d0db7 hardening: x86: drop reference to =
removed config AMD_IOMMU_V2)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging iommufd/for-next (c97d1b20d383 iommu/vt-d: Add domain_alloc_user op)
CONFLICT (content): Merge conflict in include/linux/iommu.h
Applying: Revert "rtc: at91rm9200: Convert to platform remove callback retu=
rning void"

--Sig_/fp/CD+.jjedsAa84dW8_iSf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUsxboACgkQAVBC80lX
0Gx4Cgf/Zw9AjfTjepk9BdcgoH6ZuCYPU0W6/KYvVX0r1qTOCpj4Mak98A10FX8t
iJ7h65Ee7N03D1ohh+JJgzk4jhsbHYxtjI6USF0nCd0Kj2KT1Ma1WOksNAlp+lyt
fxlBznQ0vN6YMgNfwSKkThqtWhjF3Lgvv/dlfKBPmKJ3wFbO1EBhM5WwPbVQeyDC
QihSjlQDH74Go7ax7t6/CDtB/JZDJMJPpnG3p3sXBi2rjz9EP4c5oxdAC9KGX/JJ
TtHAaH4okL5QqprhkrEdN0q+s3ogKqJJ2T+Q1Rmk15QP6IgyCXRWol20vCYCHdwa
lC1T8q/5U7jS07rqEteXw3miJommYQ==
=UdOE
-----END PGP SIGNATURE-----

--Sig_/fp/CD+.jjedsAa84dW8_iSf--
