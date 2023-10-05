Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829877B9E17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjJEN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjJEN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F156199D;
        Wed,  4 Oct 2023 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696477505;
        bh=zTzRl02Kilt4bWfERtoV21LrYNKME5rebF6CRFKSxx8=;
        h=Date:From:To:Cc:Subject:From;
        b=ELiK8HmAxToaSTIuFC8EtgmPGv4a4H3lXOfmvXU0NRy0lnp8bOLE1NlGgwUaoXYi6
         r1VdknantYhYibWd3oHnoO6SsnUoDNEzbAhudlzZQVzDEVxcND7ck7sOpipQdv4S2O
         Ah0hnZli1Mr0Ct7mpdKEyP/ztehAnE3OoYJVzRymVozrbg1iRY73ig/Z4vJw+m2LCZ
         2AT4BmBZoHXMfHpf+BXzXpikfDF7z/bexI5zi8wOWgGwbv5CIyfpIZfPK/W1ee1/pI
         cWlRJiqnvSo0Nay8yup/J+XnTso4vdWQ0wVEOZ3gvIwqJTxgTBETyN63zqWpYDB7Dx
         ZIM5ikNHctX8g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1HWP37FVz4xLw;
        Thu,  5 Oct 2023 14:45:05 +1100 (AEDT)
Date:   Thu, 5 Oct 2023 14:45:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 5
Message-ID: <20231005144504.0b6fa8db@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MkhHBRiM/kFVzMxkgQ8g+Jr";
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

--Sig_/MkhHBRiM/kFVzMxkgQ8g+Jr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231004:

The mm tree lost its build failure.

The btrfs tree gained a conflict against the btrfs-fixes tree.

The kvm-arm tree gained a build failure so I used the version from
next-20231004.

The usb tree lost its build failure.

Non-merge commits (relative to Linus' tree): 9247
 7209 files changed, 563099 insertions(+), 164458 deletions(-)

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
Merging origin/master (ba7d997a2a29 Merge tag 'linux-kselftest-fixes-6.6-rc=
5' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (43e8ca8891f0 hugetlbfs: close rac=
e between MADV_DONTNEED and page fault)
Merging kbuild-current/fixes (8a749fd1a872 Linux 6.6-rc4)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (6995e2de6891 Linux 6.4)
Merging arm64-fixes/for-next/fixes (4785aa802853 cpuidle, ACPI: Evaluate LP=
I arch_flags for broadcast timer)
Merging arm-soc-fixes/arm/fixes (d75e870c32f6 arm64: defconfig: enable sysc=
on-poweroff driver)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (eb1e6ccdcf78 zorro: Include zorro.h in name=
s.c)
Merging powerpc-fixes/fixes (58b33e78a317 selftests/powerpc: Fix emit_tests=
 to work with run_kselftest.sh)
Merging s390-fixes/fixes (5c95bf274665 s390/cert_store: fix string length h=
andling)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (513dbc10cfc1 page_pool: fix documentation typos)
Merging bpf/master (1eb3dee16a52 Merge tag 'for-netdev' of https://git.kern=
el.org/pub/scm/linux/kernel/git/bpf/bpf)
Merging ipsec/master (cc9b364bb1d5 xfrm6: fix inet6_dev refcount underflow =
problem)
Merging netfilter/main (51e7a66666e0 ibmveth: Remove condition to recompute=
 TCP header checksum.)
Merging ipvs/main (51e7a66666e0 ibmveth: Remove condition to recompute TCP =
header checksum.)
Merging wireless/for-next (22061bfc57fe wifi: iwlwifi: mvm: Fix incorrect u=
sage of scan API)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (374012b00457 RDMA/mlx5: Fix mkey cache possible =
deadlock on cleanup)
Merging sound-current/for-linus (9c1a3f432b62 Merge tag 'asoc-fix-v6.6-rc4'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus)
Merging sound-asoc-fixes/for-linus (1426b9ba7c45 ASoC: dt-bindings: fsl,mic=
fil: Document #sound-dai-cells)
Merging regmap-fixes/for-linus (7a795ac8d49e regmap: rbtree: Fix wrong regi=
ster marked as in-cache when creating new node)
Merging regulator-fixes/for-linus (6e800968f6a7 regulator/core: Revert "fix=
 kobject release warning and memory leak in regulator_register()")
Merging spi-fixes/for-linus (2ec8b0109790 spi: npcm-fiu: Fix UMA reads when=
 dummy.nbytes =3D=3D 0)
Merging pci-current/for-linus (c82458101d54 PCI/PM: Mark devices disconnect=
ed if upstream PCIe link is down on resume)
Merging driver-core.current/driver-core-linus (8a749fd1a872 Linux 6.6-rc4)
Merging tty.current/tty-linus (560706eff7c8 serial: 8250_omap: Fix errors w=
ith no_console_suspend)
Merging usb.current/usb-linus (cf97c5e0f7dd xhci: Preserve RsvdP bits in ER=
STBA register correctly)
Merging usb-serial-fixes/usb-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging phy/fixes (11395c32f9e9 phy: qualcomm: Fix typos in comments)
Merging staging.current/staging-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging iio-fixes/fixes-togreg (f2b9f9ef9a02 iio: pressure: ms5611: ms5611_=
prom_is_valid false negative bug)
Merging counter-current/counter-current (df8fdd01c98b counter: microchip-tc=
b-capture: Fix the use of internal GCLK logic)
Merging char-misc.current/char-misc-linus (fc5bf78b1ae0 Merge tag 'coresigh=
t-fixes-v6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/=
linux into char-misc-linus)
Merging soundwire-fixes/fixes (3b6c4a11bf2b soundwire: bus: Make IRQ handli=
ng conditionally built)
Merging thunderbolt-fixes/fixes (308092d08085 thunderbolt: Restart XDomain =
discovery handshake after failure)
Merging input-current/for-linus (423622a90abb Input: goodix - ensure int GP=
IO is in input for gpio_count =3D=3D 1 && gpio_int_idx =3D=3D 0 case)
Merging crypto-current/master (21155620fbf2 crypto: sm2 - Fix crash caused =
by uninitialized context)
Merging vfio-fixes/for-linus (c777b11d34e0 vfio/mdev: Fix a null-ptr-deref =
bug for mdev_unregister_parent())
Merging kselftest-fixes/fixes (6f874fa021df selftests: Fix wrong TARGET in =
kselftest top level Makefile)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (01f1ae2733e2 dmaengine: mediatek: Fix deadlo=
ck caused by synchronize_irq())
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (5279f4a9eed3 mtd: rawnand: qcom: Unmap the rig=
ht resource upon probe failure)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (6bd01c4299d4 staging: media: tegra-video: fix =
infinite recursion regression)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (8a749fd1a872 Linux 6.6-rc4)
Merging at91-fixes/at91-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging omap-fixes/fixes (06f114cf7cbe Merge branches 'fixes-mapphone' and =
'fixes-ti-sysc' into fixes)
Merging kvm-fixes/master (5804c19b80bf Merge tag 'kvm-riscv-fixes-6.6-1' of=
 https://github.com/kvm-riscv/linux into HEAD)
Merging kvms390-fixes/master (f87ef5723536 KVM: s390: fix gisa destroy oper=
ation might lead to cpu stalls)
Merging hwmon-fixes/hwmon (6465e260f487 Linux 6.6-rc3)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (c66650d29764 cxl/acpi: Annotate struct cxl_cxims_d=
ata with __counted_by)
Merging btrfs-fixes/next-fixes (8bf2ca6da0c6 Merge branch 'misc-6.6' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (34c271e778c1 platform/x86: touchscreen_dmi=
: Add info for the BUSH Bush Windows tablet)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (cee66375b7f4 dt-bindings: media: renesas=
,vin: Fix field-even-active spelling)
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (b481f644d917 scsi: zfcp: Fix a double put in zfcp=
_port_enqueue())
Merging drm-fixes/drm-fixes (8a749fd1a872 Linux 6.6-rc4)
Merging drm-intel-fixes/for-linux-next-fixes (1fbb6c1d88c4 drm/i915: Invali=
date the TLBs on each GT)
Merging mmc-fixes/fixes (84ee19bffc93 mmc: core: Capture correct oemid-bits=
 for eMMC cards)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging hyperv-fixes/hyperv-fixes (cfc7461a60e3 hyperv: reduce size of ms_h=
yperv_info)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (9f564b92cf6d riscv: Only consider swbp/ss handl=
ers for correct privileged mode)
Merging riscv-dt-fixes/riscv-dt-fixes (1558209533f1 riscv: dts: starfive: v=
isionfive 2: Fix uart0 pins sort order)
Merging riscv-soc-fixes/riscv-soc-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga-fixes/fixes (6465e260f487 Linux 6.6-rc3)
Merging spdx/spdx-linus (8a749fd1a872 Linux 6.6-rc4)
Merging gpio-brgl-fixes/gpio/for-current (fdf957514cdb gpio: aspeed: fix th=
e GPIO number passed to pinctrl_gpio_set_config())
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
Merging irqchip-fixes/irq/irqchip-fixes (9b8df572ba3f irqchip: renesas-rzg2=
l: Fix logic to clear TINT interrupt source)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (f38f547314b8 perf dlfilter: Add a test for=
 object_code())
Merging efi-fixes/urgent (8dbe33956d96 efi/unaccepted: Make sure unaccepted=
 table is mapped)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (8894b4325488 power: supply: qcom_battmgr: fix =
enable request endianness)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging rust-fixes/rust-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pmdomain-fixes/fixes (e2ad626f8f40 pmdomain: Rename the genpd subsy=
stem to pmdomain)
Merging overlayfs-fixes/ovl-fixes (c7242a45cb8c ovl: fix NULL pointer defer=
 when encoding non-decodable lower fid)
Merging drm-misc-fixes/for-linux-next-fixes (d59e75eef52d drm/nouveau: exec=
: report max pushs through getparam)
Merging mm-stable/mm-stable (dc68badcede4 mm: mlock: update mlock_pte_range=
 to handle large folio)
Merging mm-nonmm-stable/mm-nonmm-stable (c37e56cac3d6 crash_core.c: remove =
unneeded functions)
Merging mm/mm-everything (6e8af6af1673 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (367df0e19c67 modpost: factor out the common boiler=
plate of section_rel(a))
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (f2d87895cbc4 perf intel-pt: Fix async branch =
flags)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (2d5780bbef8d swiotlb: fix the check whether a=
 device has used software IO TLB)
Merging asm-generic/master (ccab211af3c2 syscalls: Cleanup references to sy=
s_lookup_dcookie())
CONFLICT (modify/delete): arch/ia64/kernel/setup.c deleted in asm-generic/m=
aster and modified in HEAD.  Version HEAD of arch/ia64/kernel/setup.c left =
in tree.
$ git rm -f arch/ia64/kernel/setup.c
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (cfb61170032b Merge branch 'for-next/feat_sve_b=
16b16' into for-next/core)
Merging arm-perf/for-next/perf (21b61fe48c2f drivers/perf: hisi: Update HiS=
ilicon PMU maintainers)
Merging arm-soc/for-next (01c6c516771b Merge branch 'soc/defconfig' into fo=
r-next)
Merging amlogic/for-next (90307906b16a Merge branch 'v6.7/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (b51f63b7c71d ARM: dts: aspeed: Minerva: Add Facebo=
ok Minerva CMC board)
Merging at91/at91-next (3cec9514911c ARM: dts: at91: sam9x60_curiosity: Add=
 mandatory dt property for RTT)
Merging broadcom/next (0595ec8ac636 Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (387bb6fdd0af dt-bindings: memory-controlle=
rs: Make "additionalProperties: true" explicit)
Merging imx-mxs/for-next (7ff3609efc0d Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (ce9ecca0238b Linux 6.6-rc2)
Merging mvebu/for-next (93e6b023e552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (de2733f7ad6f Merge branch 'omap-for-v6.7/dt' into fo=
r-next)
Merging qcom/for-next (870b52222042 Merge branches 'arm64-defconfig-for-6.7=
', 'arm64-fixes-for-6.6', 'arm64-for-6.7', 'clk-for-6.7', 'drivers-for-6.7'=
 and 'dts-for-6.7' into for-next)
Merging renesas/next (152c71433da2 Merge branches 'renesas-arm-defconfig-fo=
r-v6.7', 'renesas-arm-soc-for-v6.7', 'renesas-drivers-for-v6.7', 'renesas-d=
t-bindings-for-v6.7' and 'renesas-dts-for-v6.7' into renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (fcd71ba3fccd Merge branch 'v6.6-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (5d7f4a3445e7 Merge branch 'next/defconfig' i=
nto for-next)
Merging scmi/for-linux-next (05f3d080cad5 Merge branches 'for-next/scmi/upd=
ates', 'for-next/ffa/updates', 'for-next/vexpress/updates' and 'for-next/pc=
c/updates' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/li=
nux into for-linux-next)
Merging stm32/stm32-next (565c88ae53c5 ARM: dts: stm32: omit unused pinctrl=
 groups from stm32mp15 dtb files)
Merging sunxi/sunxi/for-next (ce63e97b674d ARM: dts: sunxi: add support for=
 Anbernic RG-Nano)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (c62440bd774b Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (3eaab2f9d880 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0f133188d6b8 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (78fd9cf91630 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (87882525e5dd clk: renesas: r8a7795: Consti=
fy r8a7795_*_clks)
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (2c10cda4b777 LoongArch: KVM: Add maintain=
ers for LoongArch KVM)
Merging m68k/for-next (0c316da2164c m68k: Replace GPL 2.0+ README.legal boi=
lerplate with SPDX)
Merging m68knommu/for-next (b4febef3c490 m68k: 68000: fix warning in timer =
code)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (8a749fd1a872 Linux 6.6-rc4)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (289e0fe7d897 parisc: Restore __ldcw_align for P=
A-RISC 2.0 processors)
Merging powerpc/next (c945e6f453a3 powerpc/configs: Remove ReiserFS from de=
fconfig)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-dt/riscv-dt-for-next (af571133f7ae riscv: dts: starfive: add =
assigned-clock* to limit frquency)
Merging riscv-soc/riscv-soc-for-next (22dedf8f4570 soc/microchip: mpfs-sys-=
controller: Convert to platform remove callback returning void)
Merging s390/for-next (a8dbae76e7bc Merge branch 'features' into for-next)
Merging sh/for-next (246f80a0b17f sh: push-switch: Reorder cleanup operatio=
ns to avoid use-after-free bug)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (be4c06af49fe xtensa: import ESP32S3 core va=
riant)
Merging bcachefs/for-next (1a97b93a13f8 bcachefs: Fix changing durability u=
sing sysfs)
Applying: bcachefs: convert to dynamically allocated shrinkers
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (5b1188847180 fscrypt: support crypto data unit si=
ze less than filesystem block size)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (395e098935ed Merge branch 'for-next-next-v6.6-20230=
925' into for-next-20230925)
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/btrfs/transaction.h
Merging ceph/master (57d162061344 ceph: remove unnecessary IS_ERR() check i=
n ceph_fname_to_usr())
Merging cifs/for-next (9a79315011d8 cifs: Add client version details to NTL=
M authenticate message)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (91b1ad0815fb erofs: release ztailpacking pclusters prope=
rly)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (bceef326bc87 udf: Avoid unneeded variable length arr=
ay in struct fileIdentDesc)
Merging ext4/dev (7fda67e8c3ab ext4: fix rec_len verify error)
Merging f2fs/dev (3e729e50d01e f2fs: preload extent_cache for POSIX_FADV_WI=
LLNEED)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (ae3024a4c499 docs/fuse-io: Document the usage of DIR=
ECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (bfa77a880f11 gfs2: More aggressive page fault-in)
Merging jfs/jfs-next (05d9ea1ceb62 jfs: fix array-index-out-of-bounds in di=
Alloc)
Merging ksmbd/ksmbd-for-next (8a749fd1a872 Linux 6.6-rc4)
Merging nfs/linux-next (6465e260f487 Linux 6.6-rc3)
Merging nfs-anna/linux-next (dd1b2026323a nfs: decrement nrequests counter =
before releasing the req)
Merging nfsd/nfsd-next (21787f4226e9 NFSD: Fix frame size warning in svc_ex=
port_parse())
Merging ntfs3/master (e4494770a5ca fs/ntfs3: Avoid possible memory leak)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (27d6a73be736 ovl: Add documentation on ne=
sting of overlayfs mounts)
Merging ubifs/next (017c73a34a66 ubi: Refuse attaching if mtd's erasesize i=
s 0)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (59c71548cf10 Merge tag 'fix-fix-iunlink-6.6_2023-09-2=
5' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into=
 xfs-6.6-fixesB)
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
Merging vfs-brauner/vfs.all (530d23ed060f Merge branch 'vfs.super' into vfs=
.all)
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
Applying: Revert "block: Remove blkdev_get_by_*() functions"
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (5834f8e72b1b Merge branch 'rework/nbcon-base' into=
 for-next)
Merging pci/next (87ab156b7bb2 Merge branch 'pci/endpoint')
Merging pstore/for-next/pstore (5ee1a4304799 docs: pstore-blk.rst: fix typo=
, s/console/ftrace)
Merging hid/for-next (eccf294b0dd2 Merge branch 'for-6.7/cp2112' into for-n=
ext)
Merging i2c/i2c/for-next (b5d463c0eecb Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (cab63f648876 i3c: Fix potential refcount leak in i3c_=
master_register_new_i3c_devs)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (443f18550476 hwmon: (adt7475) Add support=
 for Imon readout on ADT7490)
Merging jc_docs/docs-next (9553632bddce docs/hw-vuln: Update desc of best e=
ffort mode)
Merging v4l-dvb/master (2c1bae27df78 media: qcom: camss: Fix pm_domain_on s=
equence in probe)
Merging v4l-dvb-next/master (72666b8ca7dd media: atomisp: Drop atomisp-ov56=
93 sensor driver)
CONFLICT (content): Merge conflict in drivers/media/pci/intel/ivsc/Kconfig
Merging pm/linux-next (087dbcb21272 Merge branch 'pm-sleep-fixes' into linu=
x-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (823a6d9e79fc dt-bindings: cpufr=
eq: cpufreq-qcom-hw: add SDM670 compatible)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (8a749fd1a872 Linux 6.6-rc4)
Merging pmdomain/next (d0d17c9d854d pmdomain: Merge branch fixes into next)
CONFLICT (content): Merge conflict in drivers/soc/apple/Kconfig
Merging opp/opp/linux-next (3c4746e28af1 OPP: Extend support for the opp-le=
vel beyond required-opps)
Merging thermal/thermal/linux-next (edd220b33f47 thermal: core: Drop therma=
l_zone_device_register())
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (964168970cef IB/hfi1: Annotate struct tid_rb_node wi=
th __counted_by)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/mr.c
Merging net-next/main (f8e5b7786237 Merge branch 'chelsio-annotate-structs-=
with-__counted_by')
Merging bpf-next/for-next (3157b7ce14bb Merge branch 'selftest/bpf, riscv: =
Improved cross-building support')
Merging ipsec-next/master (5fa4704d14b2 xfrm: Remove unused function declar=
ations)
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
CONFLICT (content): Merge conflict in include/linux/mlx5/device.h
Merging netfilter-next/main (c1fec890458a ethernet/intel: Use list_for_each=
_entry() helper)
Merging ipvs-next/main (0201409079b9 net: spider_net: Use size_add() in cal=
l to struct_size())
Merging bluetooth/master (6be21d987868 Bluetooth: Fix a refcnt underflow pr=
oblem for hci_conn)
Merging wireless-next/for-next (f0fb62e090bd wifi: rtlwifi: use unsigned lo=
ng for rtl_bssid_entry timestamp)
CONFLICT (content): Merge conflict in drivers/staging/rtl8723bs/os_dep/ioct=
l_cfg80211.c
CONFLICT (content): Merge conflict in net/mac80211/cfg.c
CONFLICT (content): Merge conflict in net/mac80211/key.c
CONFLICT (content): Merge conflict in net/wireless/nl80211.c
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
Merging crypto/master (5ec12f1c7bac crypto: engine - Make crypto_engine_exi=
t() return void)
Merging drm/drm-next (caacbdc28f54 Merge tag 'drm-intel-gt-next-2023-09-28'=
 of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_fw.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_drv.h
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (407c0ad5b19a drm/panfrost: Implement gener=
ic DRM object RSS reporting function)
Merging amdgpu/drm-next (9cff0879aefe drm/amd/pm: Add GC v9.4.3 thermal lim=
its to hwmon)
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
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
Merging drm-intel/for-linux-next (07f9cfe2ef6c drm/i915/dp_mst: Make sure p=
bn_div is up-to-date after sink reconnect)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ce9ecca0238b Linux 6.6-rc2)
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (c1a8d1d0edb7 fbdev: atyfb: only use ioremap_uc() on=
 i386 and ia64)
Merging regmap/for-next (596210de90a9 Merge remote-tracking branch 'regmap/=
for-6.7' into regmap-next)
Merging sound/for-next (c258bcc289e6 ALSA: hda: cirrus_scodec: fix an error=
 code)
Merging ieee1394/for-next (a464d2f75fa1 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (823e57bf938a Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-next)
CONFLICT (content): Merge conflict in sound/pci/hda/cs35l41_hda.c
Merging modules/modules-next (3111add7f414 module: Annotate struct module_n=
otes_attrs with __counted_by)
CONFLICT (content): Merge conflict in scripts/mod/modpost.c
Applying: fix up for "module: Make is_valid_name() return bool"
Merging input/next (68ede283a1d8 Input: axp20x-pek - avoid needless newline=
 removal)
Merging block/for-next (6f0566f375ea Merge branch 'for-6.7/block' into for-=
next)
CONFLICT (modify/delete): arch/ia64/kernel/syscalls/syscall.tbl deleted in =
HEAD and modified in block/for-next.  Version block/for-next of arch/ia64/k=
ernel/syscalls/syscall.tbl left in tree.
$ git rm -f arch/ia64/kernel/syscalls/syscall.tbl
Merging device-mapper/for-next (656c29f18ca8 dm thin: Use the extent alloca=
tor for data blocks)
Merging libata/for-next (b8b8b4e0c052 ata: ahci: Add Intel Alder Lake-P AHC=
I controller to low power chipsets list)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (09b59829715b mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (36270a259962 mfd: max8998: Simplify obtaining I2C=
 match data and drop max8998_i2c_get_driver_data())
Merging backlight/for-backlight-next (a4464092f2c5 backlight: led_bl: Remov=
e redundant of_match_ptr())
Merging battery/for-next (3f26d8b6d1cb power: supply: rt5033_charger: Repla=
ce "&pdev->dev" by "charger->dev" in probe)
Merging regulator/for-next (f9a1d31874c3 Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (e50856067289 lsm: fix a spelling mistake)
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (91e326563ee3 ima: rework CONFIG_IMA depen=
dency block)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (19c1c9916dbf selinux: simplify avtab_insert_node() pr=
ototype)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (ea72883a3bf1 tpm: Fix typo in tpmrm class definition)
Merging watchdog/master (ce9ecca0238b Linux 6.6-rc2)
Merging iommu/next (8e5ab3f54a10 Merge branches 'iommu/fixes', 'arm/tegra',=
 's390' and 'x86/amd' into next)
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging audit/next (97f576eb38ae audit: Annotate struct audit_chunk with __=
counted_by)
Merging devicetree/for-next (00d589ace5f4 dt-bindings: writing-schema: add =
example for multiple DT_SCHEMA_FILES)
Merging dt-krzk/for-next (d896029c9726 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (ea229d080d57 Merge remote-tracking branch 'spi/for-6.=
7' into spi-next)
Merging tip/master (da870b528c78 Merge branch into tip/master: 'x86/tdx')
Merging clockevents/timers/drivers/next (0a8b07c77ea0 clocksource: Explicit=
ly include correct DT includes)
Merging edac/edac-for-next (ce53ad81ed36 EDAC/igen6: Fix the issue of no er=
ror events)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (fc1653abba0d Merge probes/for-next)
Merging rcu/rcu/next (9adde744c8a8 rculist.h: docs: Fix wrong function summ=
ary)
CONFLICT (content): Merge conflict in Documentation/filesystems/proc.rst
Merging kvm/next (5804c19b80bf Merge tag 'kvm-riscv-fixes-6.6-1' of https:/=
/github.com/kvm-riscv/linux into HEAD)
Merging kvm-arm/next (91a7707cf79c Merge branch kvm-arm64/mops into kvmarm/=
next)
$ git reset --hard HEAD^
Merging next-20231004 version of kvm-arm
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-ppc/topic/ppc-kvm (476652297f94 docs: powerpc: Document nested =
KVM on POWER)
Merging kvm-riscv/riscv_kvm_next (071ef070ca77 KVM: riscv: selftests: Selec=
tively filter-out AIA registers)
Merging kvm-x86/next (8cd6d6724eae Merge branches 'apic', 'docs', 'fpu', 'm=
isc', 'mmu', 'pmu', 'selftests', 'svm' and 'xen')
Merging xen-tip/linux-next (0fc6ff5a0f04 xen/efi: refactor deprecated strnc=
py)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (b73f0490191b Merge branch 'for-6.6-fixes' into=
 for-next)
Merging drivers-x86/for-next (49d371ab9d2c platform/x86/siemens: simatic-ip=
c-batt-f7188x: Convert to platform remove callback returning void)
Merging chrome-platform/for-next (7396a5b980fd platform/chrome/wilco_ec: te=
lemetry: Convert to platform remove callback returning void)
Merging chrome-platform-firmware/for-firmware-next (0bb80ecc33a8 Linux 6.6-=
rc1)
Merging hsi/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (685f192b3a0a leds: turris-omnia: Add support=
 for enabling/disabling HW gamma correction)
Merging ipmi/for-next (b00839ca4cca ipmi: refactor deprecated strncpy)
Merging driver-core/driver-core-next (8a749fd1a872 Linux 6.6-rc4)
Merging usb/usb-next (03cf2af41b37 Revert "phy: qcom-qmp-usb: Add Qualcomm =
SDX75 USB3 PHY support")
Merging thunderbolt/next (0c35ac182569 thunderbolt: Apply USB 3.x bandwidth=
 quirk only in software connection manager)
Merging usb-serial/usb-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging tty/tty-next (0d447e927ee8 dt-bindings: sc16is7xx: convert to YAML)
CONFLICT (content): Merge conflict in drivers/tty/serial/serial_core.c
Merging char-misc/char-misc-next (8a749fd1a872 Linux 6.6-rc4)
Merging accel/habanalabs-next (6369a5b649ec accel/habanalabs/gaudi2: fix sp=
mu mask creation)
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (6465e260f487 Linux 6.6-rc3)
Merging icc/icc-next (6ac3f01201fa Merge branch 'icc-debugfs' into icc-next)
Merging iio/togreg (5e99f692d4e3 staging: iio: resolver: ad2s1210: fix not =
restoring sample gpio in channel read)
Merging phy-next/next (56156a76e765 phy: qualcomm: phy-qcom-eusb2-repeater:=
 Add tuning overrides)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/phy=
/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-m31.c
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
.c
Merging soundwire/next (95b0f3aa71eb soundwire: qcom: Log clk_get("iface") =
failures)
Merging extcon/extcon-next (8aa54dde624c dt-bindings: usb: Add Realtek DHC =
RTD SoC Type-C)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (f9af5ad0f5b5 vfio/cdx: Add parentheses between bitwise A=
ND expression and logical NOT)
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (eb507641d0be staging: vt6655: Type encoding i=
nfo dropped from variable "byRFType")
Merging counter-next/counter-next (631c15d5f14d counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (90a6c030f506 dmaengine: xilinx: xdma: Use resource_=
size() in xdma_probe())
Merging cgroup/for-next (783a8334ec1c cgroup/cpuset: Cleanup signedness iss=
ue in cpu_exclusive_check())
Merging scsi/for-next (1da615d7f96f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (5ef104b749e8 scsi: fnic: Clean up some inconsist=
ent indenting)
Merging vhost/linux-next (1acfe2c12258 virtio_ring: fix avail_wrap_counter =
in virtqueue_add_packed)
Merging rpmsg/for-next (6ffa306ee97c Merge branches 'hwspinlock-next' and '=
rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (0c42fc96cc02 arm: omap1: ams-delta: stop u=
sing gpiochip_find())
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (c0ee40d1e19e Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (cec422ab8c1e pinctrl: denverton: Enable pla=
tform device in the absence of ACPI enumeration)
Merging pinctrl-renesas/renesas-pinctrl (c385256611b1 pinctrl: renesas: rzg=
2l: Rename rzg2l_gpio_configs[])
Merging pinctrl-samsung/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pwm/for-next (4aae44f65827 pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (078a2ead544c selftests/rseq: fix kselftest Clang bu=
ild warnings)
Merging kunit/test (0bb80ecc33a8 Linux 6.6-rc1)
Merging kunit-next/kunit (8040345fdae4 kunit: test: Fix the possible memory=
 leak in executor_test)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (e005a9b35b46 rtc: brcmstb-waketimer: support level al=
arm_irq)
Merging nvdimm/libnvdimm-for-next (fd86eff33898 libnvdimm: Annotate struct =
nd_region with __counted_by)
Merging at24/at24/for-next (997a29bbb1e0 eeprom: at24: Annotate struct at24=
_data with __counted_by)
Merging ntb/ntb-next (643982232860 ntb: Check tx descriptors outstanding in=
stead of head/tail for tx queue)
Merging seccomp/for-next/seccomp (ce9ecca0238b Linux 6.6-rc2)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (ee73a9fae540 nvmem: add explicit config option to r=
ead old syntax fixed OF cells)
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
Merging slab/slab/for-next (90f055df1121 mm/slub: refactor calculate_order(=
) and calc_slab_order())
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (96e033d649b3 landlock: Document Landlock's network s=
upport)
Merging rust/rust-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging sysctl/sysctl-next (d12ff982e72d c-sky: Remove now superfluous sent=
inel element from ctl_talbe array)
CONFLICT (modify/delete): arch/ia64/kernel/crash.c deleted in HEAD and modi=
fied in sysctl/sysctl-next.  Version sysctl/sysctl-next of arch/ia64/kernel=
/crash.c left in tree.
$ git rm -f arch/ia64/kernel/crash.c
Merging execve/for-next/execve (553e41d1bc95 binfmt_elf_fdpic: clean up deb=
ug warnings)
Merging bitmap/bitmap-for-next (bcafd8b927ed bitmap: Remove dead code, i.e.=
 bitmap_copy_le())
Merging hte/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging kspp/for-next/kspp (692c013e8f37 accessibility: speakup: refactor d=
eprecated strncpy)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging iommufd/for-next (474d9f32766a iommufd: Fix spelling errors in comm=
ents)

--Sig_/MkhHBRiM/kFVzMxkgQ8g+Jr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUeMUAACgkQAVBC80lX
0Gz4NQf+O1xkk00mI8N7wxQDtLF/xhjcdSgPIyOEreV1MahTPMi9qdQ5WZlkokn8
RUFdK9BkI48VkinVfiWaY+PyJB7XTLhmNf0pWNT7Owc2U/4QW+KJrzWfH6LebLeq
/6ngmy6AyG6P0mzAVNBZOdpNitOClNd/XqJlcSLzYPphgINtig6wjDgDwea8z+Rm
TnujZ/ji+LpEwsG0Zg+fdPJ5nuqFzkmOThKh5R4/q9pDPJUSxaDfP22dfh2qcDeT
SgFJe7TNGETjmKaC8wKI8I81EAJQWuqOxSvahobmcDzgU0FvpZZ2F1DzgYTbw1A2
kcQx47ffoTu//Eq0RErU9yjdFFYS2g==
=Mzaf
-----END PGP SIGNATURE-----

--Sig_/MkhHBRiM/kFVzMxkgQ8g+Jr--
