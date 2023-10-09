Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEA7BD2C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbjJIFRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJIFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:17:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A269F;
        Sun,  8 Oct 2023 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696828660;
        bh=1v5zr8+D4x3/I7+5xVT4MIb8rDVLI1m/PeJFjmnkoRY=;
        h=Date:From:To:Cc:Subject:From;
        b=atE0Af/W0kJiJeTW2lbst0eMSlZys01oR6x6hnyp/GBVHAoEFNoLGrodQjEqa+KXz
         qAT0vpVQX8e2B9LC4IELbtxgIFUJK7e1ABW9oTxCnE2TXJoaWuWySNigtzMB7opkay
         q9qdTsZU5OME2n7bgLnyVTuL5zbji7b0y9Xr8r4hYiTFL+k5V0nqmUToQ+mbAgq0mQ
         Q41RtixxP9foEFyuwNCjf9riOziXKpEzKEkoLO2yuZI6l5KlWOmSvARmDJrME7UdKH
         BAQADQv20UB/6PdNuNN1k9U4K27PegujHNTULPi4z+CyTbOgbpg3i+gyp+tTvANDYw
         WXUBYBEahquGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3nNN0ddHz4xS7;
        Mon,  9 Oct 2023 16:17:40 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 16:17:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 9
Message-ID: <20231009161738.1c1ad66b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.0iD.SJITuvw9k89xBRnkq3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.0iD.SJITuvw9k89xBRnkq3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231006:

The scmi tree lost its build failure.

Tthe vfs-brauner tree gained several conflicts against the btrfs tree
that were too complex, so I dropped the vfs-brauner tree for today.

The pci tree lost its build failure.

The vl4-dvb-next gained a bad automatic merge resolution due to a
duplictaed patch for which I applied a fix patch.

The block tree gained conflicts against the asm-generic tree.

The tip tree gained a conflict against the pci tree.

Non-merge commits (relative to Linus' tree): 9933
 7914 files changed, 585974 insertions(+), 175178 deletions(-)

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
Merging origin/master (94f6f0550c62 Linux 6.6-rc5)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (d9dba6bcdb1b hugetlbfs: close rac=
e between MADV_DONTNEED and page fault)
Merging kbuild-current/fixes (8a749fd1a872 Linux 6.6-rc4)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (2dde18cd1d8f Linux 6.5)
Merging arm64-fixes/for-next/fixes (4785aa802853 cpuidle, ACPI: Evaluate LP=
I arch_flags for broadcast timer)
Merging arm-soc-fixes/arm/fixes (886d1f1f8f5f Merge tag 'renesas-fixes-for-=
v6.6-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel into arm/fixes)
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
Merging net/main (776fe19953b0 ice: block default rule setting on LAG inter=
face)
Merging bpf/master (37345b8535b4 selftests/bpf: Make seen_tc* variable test=
s more robust)
Merging ipsec/master (cc9b364bb1d5 xfrm6: fix inet6_dev refcount underflow =
problem)
Merging netfilter/main (a2e52554c710 Merge branch 'ravb-fix-use-after-free-=
issues')
Merging ipvs/main (a2e52554c710 Merge branch 'ravb-fix-use-after-free-issue=
s')
Merging wireless/for-next (22061bfc57fe wifi: iwlwifi: mvm: Fix incorrect u=
sage of scan API)
Merging wpan/master (f990874b1c98 ieee802154: ca8210: Fix a potential UAF i=
n ca8210_probe)
Merging rdma-fixes/for-rc (c38d23a54445 RDMA/core: Require admin capabiliti=
es to set system parameters)
Merging sound-current/for-linus (3a4c155108a8 Merge tag 'asoc-fix-v6.6-rc5'=
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
Merging pci-current/for-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging driver-core.current/driver-core-linus (8a749fd1a872 Linux 6.6-rc4)
Merging tty.current/tty-linus (b3fa3cf02e3c ASoC: ti: ams-delta: Fix cx8180=
1_receive() argument types)
Merging usb.current/usb-linus (cf97c5e0f7dd xhci: Preserve RsvdP bits in ER=
STBA register correctly)
Merging usb-serial-fixes/usb-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging phy/fixes (11395c32f9e9 phy: qualcomm: Fix typos in comments)
Merging staging.current/staging-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging iio-fixes/fixes-togreg (fd39d9668f2c iio: pressure: ms5611: ms5611_=
prom_is_valid false negative bug)
Merging counter-current/counter-current (df8fdd01c98b counter: microchip-tc=
b-capture: Fix the use of internal GCLK logic)
Merging char-misc.current/char-misc-linus (ffd1f150fffe Merge tag 'iio-fixe=
s-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (3b6c4a11bf2b soundwire: bus: Make IRQ handli=
ng conditionally built)
Merging thunderbolt-fixes/fixes (ec4405ed9203 thunderbolt: Call tb_switch_p=
ut() once DisplayPort bandwidth request is finished)
Merging input-current/for-linus (423622a90abb Input: goodix - ensure int GP=
IO is in input for gpio_count =3D=3D 1 && gpio_int_idx =3D=3D 0 case)
Merging crypto-current/master (152d0bcdf1ef dm crypt: Fix reqsize in crypt_=
iv_eboiv_gen)
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
Merging v4l-dvb-fixes/fixes (1146bec0ca34 media: mediatek: vcodec: Fix enco=
der access NULL pointer)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (8a749fd1a872 Linux 6.6-rc4)
Merging at91-fixes/at91-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging omap-fixes/fixes (7eeca8ccd106 ARM: OMAP: timer32K: fix all kernel-=
doc warnings)
Merging kvm-fixes/master (5804c19b80bf Merge tag 'kvm-riscv-fixes-6.6-1' of=
 https://github.com/kvm-riscv/linux into HEAD)
Merging kvms390-fixes/master (f87ef5723536 KVM: s390: fix gisa destroy oper=
ation might lead to cpu stalls)
Merging hwmon-fixes/hwmon (6465e260f487 Linux 6.6-rc3)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (c66650d29764 cxl/acpi: Annotate struct cxl_cxims_d=
ata with __counted_by)
Merging btrfs-fixes/next-fixes (1d47db6d16d0 Merge branch 'misc-6.6' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (5b44abbc39ca platform/x86: hp-wmi:: Mark d=
river struct with __refdata to prevent section mismatch warning)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (19007c629c63 dt-bindings: trivial-device=
s: Fix MEMSIC MXC4005 compatible string)
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (b481f644d917 scsi: zfcp: Fix a double put in zfcp=
_port_enqueue())
Merging drm-fixes/drm-fixes (67f35a41d374 Merge tag 'drm-misc-fixes-2023-10=
-05' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
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
Merging fpga-fixes/fixes (605731744e46 fpga: m10bmc-sec: Change contact for=
 secure update driver)
Merging spdx/spdx-linus (8a749fd1a872 Linux 6.6-rc4)
Merging gpio-brgl-fixes/gpio/for-current (f9315f17bf77 gpio: aspeed: fix th=
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
Merging irqchip-fixes/irq/irqchip-fixes (b673fe1a6229 MAINTAINERS: Remove m=
yself from the general IRQ subsystem maintenance)
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
Merging rust-fixes/rust-fixes (0c47d21ad978 rust: fix bindgen build error w=
ith fstrict-flex-arrays)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pmdomain-fixes/fixes (767881c470b3 pmdomain: imx: scu-pd: correct D=
MA2 channel)
Merging overlayfs-fixes/ovl-fixes (c7242a45cb8c ovl: fix NULL pointer defer=
 when encoding non-decodable lower fid)
Merging drm-misc-fixes/for-linux-next-fixes (b83ce9cb4a46 dma-buf: add dma_=
fence_timestamp helper)
Merging mm-stable/mm-stable (2b76550922a8 mm/ksm: document pages_skipped sy=
sfs knob)
Merging mm-nonmm-stable/mm-nonmm-stable (c37e56cac3d6 crash_core.c: remove =
unneeded functions)
Merging mm/mm-everything (b047300156a4 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (ffa46bbc5892 kbuild: rpm-pkg: generate kernel.spec=
 in rpmbuild/SPECS/)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (f2d87895cbc4 perf intel-pt: Fix async branch =
flags)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (2d5780bbef8d swiotlb: fix the check whether a=
 device has used software IO TLB)
Merging asm-generic/master (f82060480095 asm-generic: Fix spelling of archi=
tecture)
CONFLICT (modify/delete): arch/ia64/kernel/setup.c deleted in asm-generic/m=
aster and modified in HEAD.  Version HEAD of arch/ia64/kernel/setup.c left =
in tree.
$ git rm -f arch/ia64/kernel/setup.c
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (c7368ddba2ff ARM: 9326/1: make <linux/uaccess.h> self=
-contained for ARM)
Merging arm64/for-next/core (cb87774a1857 Merge branches 'for-next/sve-remo=
ve-pseudo-regs', 'for-next/backtrace-ipi', 'for-next/kselftest' and 'for-ne=
xt/feat_sve_b16b16' into for-next/core)
Merging arm-perf/for-next/perf (21b61fe48c2f drivers/perf: hisi: Update HiS=
ilicon PMU maintainers)
Merging arm-soc/for-next (6adca18b3e9d Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (01fecb1fae12 Merge branch 'v6.7/arm64-dt' into fo=
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
Merging omap/for-next (6cbb48e497a2 Merge branch 'fixes' into for-next)
Merging qcom/for-next (870b52222042 Merge branches 'arm64-defconfig-for-6.7=
', 'arm64-fixes-for-6.6', 'arm64-for-6.7', 'clk-for-6.7', 'drivers-for-6.7'=
 and 'dts-for-6.7' into for-next)
Merging renesas/next (6697d652b00f Merge branches 'renesas-arm-defconfig-fo=
r-v6.7', 'renesas-dt-bindings-for-v6.7' and 'renesas-dts-for-v6.7' into ren=
esas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (fcd71ba3fccd Merge branch 'v6.6-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (06726ae3ad34 Merge branch 'next/defconfig' i=
nto for-next)
Merging scmi/for-linux-next (ecd99c584e3f Merge branches 'for-next/scmi/upd=
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
Merging ti/ti-next (08ac7fef7150 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0f133188d6b8 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (78fd9cf91630 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (3e8008fcf6b7 clk: renesas: rzg2l: Remove C=
PG_SDHI_DSEL from generic header)
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (2c10cda4b777 LoongArch: KVM: Add maintain=
ers for LoongArch KVM)
Merging m68k/for-next (48ceb35e7268 m68k: defconfig: Update virt_defconfig =
for v6.6-rc3)
Merging m68knommu/for-next (b4febef3c490 m68k: 68000: fix warning in timer =
code)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (4d0f332a6fb6 MIPS: Remove dead code in relocate_new=
_kernel)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (ce9ecca0238b Linux 6.6-rc2)
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
Merging fscrypt/for-next (1e58a542360c fscrypt: rename fscrypt_info =3D> fs=
crypt_inode_info)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (5a68c9e489ff fixup opened/in_use in find_fsid_by_de=
vice())
CONFLICT (content): Merge conflict in fs/btrfs/super.c
Merging ceph/master (0f86954ebe31 libceph: use kernel_connect())
Merging cifs/for-next (0f8d2b9f7779 cifs: Add client version details to NTL=
M authenticate message)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (91b1ad0815fb erofs: release ztailpacking pclusters prope=
rly)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (236a8af4baf6 Pull slow quota off fix.)
Merging ext4/dev (a37d4c46392e ext4: fix racy may inline data check in dio =
write)
Merging f2fs/dev (3e729e50d01e f2fs: preload extent_cache for POSIX_FADV_WI=
LLNEED)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (ae3024a4c499 docs/fuse-io: Document the usage of DIR=
ECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (bfa77a880f11 gfs2: More aggressive page fault-in)
Merging jfs/jfs-next (05d9ea1ceb62 jfs: fix array-index-out-of-bounds in di=
Alloc)
Merging ksmbd/ksmbd-for-next (94f6f0550c62 Linux 6.6-rc5)
Merging nfs/linux-next (6465e260f487 Linux 6.6-rc3)
Merging nfs-anna/linux-next (dd1b2026323a nfs: decrement nrequests counter =
before releasing the req)
Merging nfsd/nfsd-next (5e6dfb18b778 NFSD: Fix frame size warning in svc_ex=
port_parse())
Merging ntfs3/master (e4494770a5ca fs/ntfs3: Avoid possible memory leak)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (3745b09fdb81 ovl: Add documentation on ne=
sting of overlayfs mounts)
Merging ubifs/next (017c73a34a66 ubi: Refuse attaching if mtd's erasesize i=
s 0)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (4e69f490d211 Merge tag 'xfs-fstrim-busy-tag' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.6-fixesC)
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
Merging vfs-brauner/vfs.all (1095f96e1eb2 Merge branch 'vfs.super' into vfs=
.all)
CONFLICT (content): Merge conflict in fs/btrfs/accessors.h
CONFLICT (content): Merge conflict in fs/btrfs/block-group.c
CONFLICT (content): Merge conflict in fs/btrfs/delayed-ref.c
CONFLICT (content): Merge conflict in fs/btrfs/disk-io.c
CONFLICT (content): Merge conflict in fs/btrfs/ordered-data.h
CONFLICT (content): Merge conflict in fs/btrfs/print-tree.c
CONFLICT (content): Merge conflict in fs/btrfs/qgroup.c
CONFLICT (add/add): Merge conflict in fs/btrfs/raid-stripe-tree.c
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/btrfs/sysfs.c
CONFLICT (content): Merge conflict in fs/btrfs/transaction.c
CONFLICT (content): Merge conflict in fs/btrfs/transaction.h
CONFLICT (content): Merge conflict in fs/btrfs/volumes.c
CONFLICT (content): Merge conflict in fs/btrfs/volumes.h
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
CONFLICT (content): Merge conflict in include/uapi/linux/btrfs_tree.h
$ git merge --abort
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (5834f8e72b1b Merge branch 'rework/nbcon-base' into=
 for-next)
Merging pci/next (d6813697fe26 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (5ee1a4304799 docs: pstore-blk.rst: fix typo=
, s/console/ftrace)
Merging hid/for-next (dac501397b9d HID: logitech-hidpp: Fix kernel crash on=
 receiver USB disconnect)
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
Merging v4l-dvb-next/master (e822993f9c37 media: imon: fix access to invali=
d resource for the second interface)
Applying: v4l-dvb-next: fix up for bad automatic merge.
Merging pm/linux-next (72870e645501 Merge branch 'acpi-thermal' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (823a6d9e79fc dt-bindings: cpufr=
eq: cpufreq-qcom-hw: add SDM670 compatible)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (e50fa1a5ac52 PM / devfreq: exynos-ppmu: Use d=
evice_get_match_data())
Merging pmdomain/next (d0d17c9d854d pmdomain: Merge branch fixes into next)
CONFLICT (content): Merge conflict in drivers/soc/apple/Kconfig
Merging opp/opp/linux-next (184ff4f72163 OPP: Fix -Wunsequenced in _of_add_=
opp_table_v1())
Merging thermal/thermal/linux-next (edd220b33f47 thermal: core: Drop therma=
l_zone_device_register())
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (964168970cef IB/hfi1: Annotate struct tid_rb_node wi=
th __counted_by)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/mr.c
Merging net-next/main (19537e125cc7 net: bcmgenet: Remove custom ndo_poll_c=
ontroller())
Merging bpf-next/for-next (84cb9cbd911a bpf: Annotate struct bpf_stack_map =
with __counted_by)
Merging ipsec-next/master (e377240a8eb0 Merge  branch 'xfrm: Support GRO de=
capsulation for ESP in UDP encapsulation')
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
CONFLICT (content): Merge conflict in include/linux/mlx5/device.h
Merging netfilter-next/main (48533eca606e net: sock_dequeue_err_skb() optim=
ization)
Merging ipvs-next/main (48533eca606e net: sock_dequeue_err_skb() optimizati=
on)
Merging bluetooth/master (3ef20de6b2a8 Bluetooth: btrtl: Ignore error retur=
n for hci_devcd_register())
Merging wireless-next/for-next (48533eca606e net: sock_dequeue_err_skb() op=
timization)
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
Merging crypto/master (8468516f9f93 crypto: pkcs7 - remove md4 md5 x.509 su=
pport)
Merging drm/drm-next (389af786f92e Merge tag 'drm-intel-next-2023-09-29' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_fw.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_drv.h
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (c1698c73f4aa drm: exynos: dsi: Convert to =
platform remove callback returning void)
Merging amdgpu/drm-next (c8e7df374ba2 drm/amdgpu: Annotate struct amdgpu_bo=
_list with __counted_by)
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
Merging drm-intel/for-linux-next (3385375be6f2 drm/i915/ddi: Remove redunda=
nt intel_connector NULL check)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ce9ecca0238b Linux 6.6-rc2)
Merging drm-msm-lumag/msm-next-lumag (50c47e58d49e dt-bindings: display: ms=
m: Make "additionalProperties: true" explicit)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/dpu1/dpu_hw_=
interrupts.h
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (c1a8d1d0edb7 fbdev: atyfb: only use ioremap_uc() on=
 i386 and ia64)
Merging regmap/for-next (596210de90a9 Merge remote-tracking branch 'regmap/=
for-6.7' into regmap-next)
Merging sound/for-next (5eb4ff884f72 ALSA: hda: Add code_loading parameter =
to stream setup)
Merging ieee1394/for-next (a464d2f75fa1 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (c1874bbffc13 Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-next)
CONFLICT (content): Merge conflict in sound/pci/hda/cs35l41_hda.c
Merging modules/modules-next (3111add7f414 module: Annotate struct module_n=
otes_attrs with __counted_by)
CONFLICT (content): Merge conflict in scripts/mod/modpost.c
Applying: fix up for "module: Make is_valid_name() return bool"
Merging input/next (68ede283a1d8 Input: axp20x-pek - avoid needless newline=
 removal)
Merging block/for-next (32462f30d324 Merge branch 'for-6.7/io_uring' into f=
or-next)
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
Merging libata/for-next (b8b8b4e0c052 ata: ahci: Add Intel Alder Lake-P AHC=
I controller to low power chipsets list)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (09b59829715b mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (89c8e0520d2d mfd: intel-m10-bmc: Change contact f=
or ABI docs)
Merging backlight/for-backlight-next (a4464092f2c5 backlight: led_bl: Remov=
e redundant of_match_ptr())
Merging battery/for-next (3f26d8b6d1cb power: supply: rt5033_charger: Repla=
ce "&pdev->dev" by "charger->dev" in probe)
Merging regulator/for-next (f9a1d31874c3 Merge remote-tracking branch 'regu=
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
Merging tpmdd/next (ea72883a3bf1 tpm: Fix typo in tpmrm class definition)
Merging watchdog/master (ce9ecca0238b Linux 6.6-rc2)
Merging iommu/next (49750f867b2a Merge branches 'iommu/fixes', 'arm/tegra',=
 's390', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging audit/next (97f576eb38ae audit: Annotate struct audit_chunk with __=
counted_by)
Merging devicetree/for-next (00d589ace5f4 dt-bindings: writing-schema: add =
example for multiple DT_SCHEMA_FILES)
Merging dt-krzk/for-next (d896029c9726 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (a1b75cc557de Merge remote-tracking branch 'spi/for-6.=
7' into spi-next)
Merging tip/master (e5f83f51a48f Merge branch into tip/master: 'x86/tdx')
CONFLICT (content): Merge conflict in include/linux/pci_ids.h
Merging clockevents/timers/drivers/next (0a8b07c77ea0 clocksource: Explicit=
ly include correct DT includes)
Merging edac/edac-for-next (0fd934580ea3 EDAC/versal: Add a Xilinx Versal m=
emory controller driver)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (fc1653abba0d Merge probes/for-next)
Merging rcu/rcu/next (a39f1278430a rculist.h: docs: Fix wrong function summ=
ary)
CONFLICT (content): Merge conflict in Documentation/filesystems/proc.rst
Merging kvm/next (5804c19b80bf Merge tag 'kvm-riscv-fixes-6.6-1' of https:/=
/github.com/kvm-riscv/linux into HEAD)
Merging kvm-arm/next (7e6587baafc0 Merge branch kvm-arm64/misc into kvmarm/=
next)
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-ppc/topic/ppc-kvm (476652297f94 docs: powerpc: Document nested =
KVM on POWER)
Merging kvm-riscv/riscv_kvm_next (071ef070ca77 KVM: riscv: selftests: Selec=
tively filter-out AIA registers)
Merging kvm-x86/next (86701e115030 Merge branches 'apic', 'docs', 'fpu', 'm=
isc', 'mmu', 'pmu', 'selftests', 'svm' and 'xen')
Merging xen-tip/linux-next (0fc6ff5a0f04 xen/efi: refactor deprecated strnc=
py)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (b73f0490191b Merge branch 'for-6.6-fixes' into=
 for-next)
Merging drivers-x86/for-next (8df012a7f513 platform/x86/intel/tpmi: Add deb=
ugfs support for read/write blocked)
Merging chrome-platform/for-next (2f3dd39e2b49 platform/chrome: cros_ec_pro=
to: Mark outdata as const)
Merging chrome-platform-firmware/for-firmware-next (0bb80ecc33a8 Linux 6.6-=
rc1)
Merging hsi/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (ed84d55d5115 leds: tca6507: Don't use fixed =
GPIO base)
Merging ipmi/for-next (b00839ca4cca ipmi: refactor deprecated strncpy)
Merging driver-core/driver-core-next (36b2d7dd5a8a driver core: platform: A=
nnotate struct irq_affinity_devres with __counted_by)
Merging usb/usb-next (f49449fbc21e usb: gadget: u_ether: Replace netif_stop=
_queue with netif_device_detach)
Merging thunderbolt/next (0c35ac182569 thunderbolt: Apply USB 3.x bandwidth=
 quirk only in software connection manager)
Merging usb-serial/usb-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging tty/tty-next (cfb5e0cece70 serial: initialize retinfo in uart_get_i=
nfo())
CONFLICT (content): Merge conflict in drivers/tty/serial/serial_core.c
Merging char-misc/char-misc-next (d712d205210c rapidio: make all 'class' st=
ructures const)
Merging accel/habanalabs-next (6369a5b649ec accel/habanalabs/gaudi2: fix sp=
mu mask creation)
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (8c966aadcc02 fpga: Use device_get_match_data())
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
Merging extcon/extcon-next (da886ba84479 extcon: max77843: add device-tree =
compatible string)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (f9af5ad0f5b5 vfio/cdx: Add parentheses between bitwise A=
ND expression and logical NOT)
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (25d367506a28 staging: rtl8192e: Remove unused=
 file rtllib_debug.h)
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
Merging gpio-brgl/gpio/for-next (b57587f11f81 gpio: vf610: simplify code by=
 dropping data check)
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (8d6fa5ed8f97 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (3013c7f7780d pinctrl: denverton: Replace MO=
DULE_ALIAS() with MODULE_DEVICE_TABLE())
Merging pinctrl-renesas/renesas-pinctrl (4f6019485a4a pinctrl: renesas: rzg=
2l: Add RZ/G3S support)
Merging pinctrl-samsung/for-next (4e1e21117e7e pinctrl: samsung: Annotate s=
truct exynos_muxed_weint_data with __counted_by)
Merging pwm/for-next (4aae44f65827 pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (f1020c687153 selftests: firmware: remove duplicate =
unneeded defines)
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
Merging rust/rust-next (b2516f7af9d2 rust: kernel: remove `#[allow(clippy::=
new_ret_no_self)]`)
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
Merging hte/for-next (06eaa531f2dd hte: tegra194: improve the GPIO-related =
comment)
Merging kspp/for-next/kspp (6b607a3a311a mailbox: zynqmp: Annotate struct z=
ynqmp_ipi_pdata with __counted_by)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (2b4f2eeb388d Merge tag 'nolibc-next.2023.10.05a' of =
https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc into no=
libc)
Merging iommufd/for-next (474d9f32766a iommufd: Fix spelling errors in comm=
ents)

--Sig_/.0iD.SJITuvw9k89xBRnkq3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjjPIACgkQAVBC80lX
0GyyZwgAgN9JgNzDvxTwt0BfY9odVzB/aqXmfedv4DZXek9XKzrKZEZZ1ztO93A7
FhddP3HKZBLALqmU1IrY7neODjcfwh9ZikHUogKAdP/nlY//3g86WeVXlx9AontQ
PYSISsKQMz1KFMSKuC8tothM97bGLUf2YTtRW6PAeN0O11raXxPMSRZi0Dv5ti/5
UzBqL3qwXAvRpaABvTaoq2SmKvZ+0G88QdzJGmybprqz96b91omIskDSnk55Z9kR
gps6C5ATAHBt7BFmbAeJaddOVKd++HkFIldY2mRfuujzDuZKNXvkPyqe3LJzOsnu
+5GIZyV40AKv7Sz8bBvdnkRTdOLKug==
=FlHu
-----END PGP SIGNATURE-----

--Sig_/.0iD.SJITuvw9k89xBRnkq3--
