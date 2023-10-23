Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA287D29D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjJWF6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWF6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:58:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A261FD52;
        Sun, 22 Oct 2023 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698040713;
        bh=MkNG2BdjnyjR6Nc+8qIQN5HaCeHXpuaUmEtz5U7jOG4=;
        h=Date:From:To:Cc:Subject:From;
        b=Ddhx0Yhf2/C5PmRMJbDYWvYXzfri2bl8pQZUIg2ptDIn2NB4q/exAqO1daz7eXxoS
         VOjF7YvJ3XzABkZ2Tj8x19Hqfvs/wVymVjyizOr0ZaKNa2FJRBDbDJSgB1/2yC8jrE
         /aOa6420l1lflEWZPRUquTi/RlICC+JrUSAizntYpPHErsPfegJNjUp4AL46zvMdYO
         BPjQ4wGvAxT15aPKM9FWkxqxlSiiIASeMPjfwTUttStO/Ddjy4jEVS07cQVoA/Fm5O
         PxT/I2bk57GL132qZhMLcjHchvJ6FeTL5XM9zVklGJXZk0Vcjm3CfU2Ps36LxwczH9
         yAwnH1IM2UKUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDPd545SJz4wx7;
        Mon, 23 Oct 2023 16:58:33 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 16:58:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 23
Message-ID: <20231023165831.30d525ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6fsD0mrYU0Qiw8zdlVsZL0r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6fsD0mrYU0Qiw8zdlVsZL0r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231020:

The pci tree gained a build failure so I used the version from
next-20231020.

The drm tree still had the amdgpu tree build failure for which I applied
some supplied patches.

The block tree gained a conflict against Linus' tree.

The ftrace tree gained a build failure so I used the version from
next-20231020.

The tty tree gained a conflict against the asm-generic tree.

The staging tree gained a conflict against the net-next tree.

The bitmap tree lost its build failure.

The iommufd tree gained a conflict against the iommu tree.

Non-merge commits (relative to Linus' tree): 13159
 10880 files changed, 727076 insertions(+), 262934 deletions(-)

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
Merging origin/master (fe3cfe869d5e Merge tag 'phy-fixes-6.6' of git://git.=
kernel.org/pub/scm/linux/kernel/git/phy/linux-phy)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (0567c025f778 mm/damon/lru_sort: a=
void divide-by-zero in hot threshold calculation)
Merging kbuild-current/fixes (8a749fd1a872 Linux 6.6-rc4)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (2dde18cd1d8f Linux 6.5)
Merging arm64-fixes/for-next/fixes (4785aa802853 cpuidle, ACPI: Evaluate LP=
I arch_flags for broadcast timer)
Merging arm-soc-fixes/arm/fixes (eaf16b92b18c Merge tag 'omap-fixes-audio-c=
lock-and-modem-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tml=
ind/linux-omap into arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (eb1e6ccdcf78 zorro: Include zorro.h in name=
s.c)
Merging powerpc-fixes/fixes (f9bc9bbe8afd powerpc/qspinlock: Fix stale prop=
agated yield_cpu)
Merging s390-fixes/fixes (c1ae1c59c8c6 s390/pci: fix iommu bitmap allocatio=
n)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (d2a0fc372aca tcp: fix wrong RTO timeout when received SAC=
K reneging)
Merging bpf/master (e661451ce4e6 bpf: Fold smp_mb__before_atomic() into ato=
mic_set_release())
Merging ipsec/master (de5724ca38fd xfrm: fix a data-race in xfrm_lookup_wit=
h_ifid())
Merging netfilter/main (d2a0fc372aca tcp: fix wrong RTO timeout when receiv=
ed SACK reneging)
Merging ipvs/main (2915240eddba neighbor: tracing: Move pin6 inside CONFIG_=
IPV6=3Dy section)
Merging wireless/for-next (f2ac54ebf856 net: rfkill: reduce data->mtx scope=
 in rfkill_fop_open)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (94f6f0550c62 Linux 6.6-rc5)
Merging sound-current/for-linus (7c05b44e1a50 ALSA: hda: intel-dsp-config: =
Fix JSL Chromebook quirk detection)
Merging sound-asoc-fixes/for-linus (e8ecffd9962f ASoC: da7219: Correct the =
process of setting up Gnd switch in AAD)
Merging regmap-fixes/for-linus (7a795ac8d49e regmap: rbtree: Fix wrong regi=
ster marked as in-cache when creating new node)
Merging regulator-fixes/for-linus (6e800968f6a7 regulator/core: Revert "fix=
 kobject release warning and memory leak in regulator_register()")
Merging spi-fixes/for-linus (c3aa5cb264a3 spi: nxp-fspi: use the correct io=
remap function)
Merging pci-current/for-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging driver-core.current/driver-core-linus (8a749fd1a872 Linux 6.6-rc4)
Merging tty.current/tty-linus (58720809f527 Linux 6.6-rc6)
Merging usb.current/usb-linus (21a68b69f7c1 Merge tag 'usb-serial-6.6-rc7' =
of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into us=
b-linus)
Merging usb-serial-fixes/usb-linus (52480e1f1a25 USB: serial: option: add F=
ibocom to DELL custom modem FM101R-GL)
Merging phy/fixes (089667aaaa6a phy: realtek: Realtek PHYs should depend on=
 ARCH_REALTEK)
Merging staging.current/staging-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging iio-fixes/fixes-togreg (bee448390e51 iio: afe: rescale: Accept only=
 offset channels)
Merging counter-current/counter-current (58720809f527 Linux 6.6-rc6)
Merging char-misc.current/char-misc-linus (3e4a7afde492 Merge tag 'iio-fixe=
s-for-6.6b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (58720809f527 Linux 6.6-rc6)
Merging thunderbolt-fixes/fixes (ec4405ed9203 thunderbolt: Call tb_switch_p=
ut() once DisplayPort bandwidth request is finished)
Merging input-current/for-linus (5c15c60e7be6 Input: powermate - fix use-af=
ter-free in powermate_config_complete)
Merging crypto-current/master (b11950356c4b KEYS: asymmetric: Fix sign/veri=
fy on pkcs1pad without a hash)
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
Merging kvm-fixes/master (2b3f2325e71f Merge tag 'kvm-x86-selftests-6.6-fix=
es' of https://github.com/kvm-x86/linux into HEAD)
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
Merging drivers-x86-fixes/fixes (99c09c985e59 platform/mellanox: mlxbf-tmfi=
fo: Fix a warning message)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (19007c629c63 dt-bindings: trivial-device=
s: Fix MEMSIC MXC4005 compatible string)
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (097c06394c83 scsi: qla2xxx: Fix double free of ds=
d_list during driver load)
Merging drm-fixes/drm-fixes (8b35ce3f7a96 Merge tag 'mediatek-drm-fixes-202=
31017' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linu=
x into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (e339c6d628fe drm/i915: Retry =
gtt fault when out of fence registers)
Merging mmc-fixes/fixes (84ee19bffc93 mmc: core: Capture correct oemid-bits=
 for eMMC cards)
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
Merging fpga-fixes/fixes (6a935361500a fpga: Fix memory leak for fpga_regio=
n_test_class_find())
Merging spdx/spdx-linus (8a749fd1a872 Linux 6.6-rc4)
Merging gpio-brgl-fixes/gpio/for-current (479ac419206b gpiolib: acpi: Add m=
issing memset(0) to acpi_get_gpiod_from_data())
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
Merging perf-current/perf-tools (4fa008a2db48 tools build: Fix llvm feature=
 detection, still used by bpftool)
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
Merging pmdomain-fixes/fixes (767881c470b3 pmdomain: imx: scu-pd: correct D=
MA2 channel)
Merging overlayfs-fixes/ovl-fixes (beae836e9c61 ovl: temporarily disable ap=
pending lowedirs)
Merging drm-misc-fixes/for-linux-next-fixes (d3df66fd9855 drm/amdgpu: Remov=
e redundant call to priority_is_valid())
Merging mm-stable/mm-stable (158978945f31 mm: perform the mapping_map_writa=
ble() check after call_mmap())
Merging mm-nonmm-stable/mm-nonmm-stable (5176140c5094 ocfs2: fix a typo in =
a comment)
Merging mm/mm-everything (3b9dd7f083dc Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (7715d094a5c3 kbuild: unify no-compiler-targets and=
 no-sync-config-targets)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (c4a852635edd perf data: Increase RLIMIT_NOFIL=
E limit when open too many files in perf_data__create_dir())
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
$ git rm -f arch/ia64/kernel/setup.c arch/ia64/include/asm/cpu.h arch/ia64/=
kernel/topology.c
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (c7368ddba2ff ARM: 9326/1: make <linux/uaccess.h> self=
-contained for ARM)
Merging arm64/for-next/core (f165830779c7 Merge branch 'for-next/misc' into=
 for-next/core)
Merging arm-perf/for-next/perf (3b9a22d345ff drivers: perf: arm_pmuv3: Drop=
 some unused arguments from armv8_pmu_init())
Merging arm-soc/for-next (4138246fc35b soc: document merges)
Merging amlogic/for-next (996fc07dce79 Merge branch 'v6.7/defconfig' into f=
or-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (3be891e01a89 Merge branches 'defconfig-for-v6.7', =
'dt-for-v6.7' and 'soc-for-v6.7' into for-next)
Merging at91/at91-next (3cec9514911c ARM: dts: at91: sam9x60_curiosity: Add=
 mandatory dt property for RTT)
Merging broadcom/next (61641804ab35 Merge branch 'drivers/next' into next)
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
Merging qcom/for-next (23a40d342f56 Merge branches 'arm64-defconfig-for-6.7=
', 'arm64-fixes-for-6.6', 'arm64-for-6.7', 'clk-for-6.7', 'drivers-for-6.7'=
 and 'dts-for-6.7' into for-next)
Merging renesas/next (11476f31ceaf Merge branch 'renesas-dts-for-v6.7' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (fd1299bf9ce8 Merge branch 'v6.7-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (b7df1b3a7a1b Merge branch 'next/dt' into for=
-next)
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
Merging ti/ti-next (2234981539e7 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (7d2da28125ce Merge branch 'zynqmp/dt' into for-nex=
t)
Merging clk/clk-next (f6abdcb2444f Merge branch 'clk-mediatek' into clk-nex=
t)
Merging clk-imx/for-next (2838820800dc clk: imx: imx8qm/qxp: add more resou=
rces to whitelist)
Merging clk-renesas/renesas-clk (4bce4bedbe6d clk: renesas: r9a08g045: Add =
clock and reset support for SDHI1 and SDHI2)
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (2c10cda4b777 LoongArch: KVM: Add maintain=
ers for LoongArch KVM)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (efd91d2142ed m68k: 68000: fix warning in timer =
code)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (4b7d3ab44565 MIPS: AR7: remove platform)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (864309f73f4d parisc/pdc: Add width field to str=
uct pdc_model)
Merging powerpc/next (1c7b4bc375c2 Merge branch fixes into next)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-dt/riscv-dt-for-next (81b5948cf1a7 riscv: dts: starfive: conv=
ert isa detection to new properties)
Merging riscv-soc/riscv-soc-for-next (22dedf8f4570 soc/microchip: mpfs-sys-=
controller: Convert to platform remove callback returning void)
Merging s390/for-next (063cb3ab2dd1 Merge branch 'features' into for-next)
Merging sh/for-next (246f80a0b17f sh: push-switch: Reorder cleanup operatio=
ns to avoid use-after-free bug)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (a83a72730c33 xtensa: import ESP32S3 core va=
riant)
Merging bcachefs/for-next (7413ab70cbc1 bcachefs: Refactor memcpy into dire=
ct assignment)
Applying: bcachefs: convert to dynamically allocated shrinkers
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (15baf55481de fscrypt: track master key presence s=
eparately from secret)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (c6e8f898f56f btrfs: open code timespec64 in struct =
btrfs_inode)
Merging ceph/master (07bb00ef00ac ceph: fix type promotion bug on 32bit sys=
tems)
Merging cifs/for-next (647f3a88f0d1 Add definition for new smb3.1.1 command=
 type)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (07ab48016117 erofs: simplify compression configuration p=
arser)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (482a57af3d5b Pull fanotify fixup to disallow sb mark=
s for overlayfs.)
Merging ext4/dev (c388da1dad59 ext4: properly sync file size update after O=
_SYNC direct IO)
Merging f2fs/dev (3e729e50d01e f2fs: preload extent_cache for POSIX_FADV_WI=
LLNEED)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (ae3024a4c499 docs/fuse-io: Document the usage of DIR=
ECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (bd85b86b7eed gfs2: Two quota=3Daccount mode fixes)
Merging jfs/jfs-next (a779ed754e52 jfs: define xtree root and page independ=
ently)
Merging ksmbd/ksmbd-for-next (beb0fc696ef1 ksmbd: add support for surrogate=
 pair conversion)
Merging nfs/linux-next (58720809f527 Linux 6.6-rc6)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (3fd2ca5be07f svcrdma: Fix tracepoint printk format)
Merging ntfs3/master (e4494770a5ca fs/ntfs3: Avoid possible memory leak)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (0b41c33dd34b ovl: Add documentation on ne=
sting of overlayfs mounts)
Merging ubifs/next (017c73a34a66 ubi: Refuse attaching if mtd's erasesize i=
s 0)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (cbc06310c36f xfs: reinstate the old i_version counter=
 as STATX_CHANGE_COOKIE)
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
Merging vfs-brauner/vfs.all (687818a05578 Merge branch 'vfs.super' into vfs=
.all)
CONFLICT (content): Merge conflict in fs/ntfs3/inode.c
CONFLICT (content): Merge conflict in fs/ntfs3/namei.c
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
Applying: bcachefs: convert to new timestamp accessors
Merging vfs/for-next (1aee9158bc97 nfsd: lock_rename() needs both directori=
es to live on the same fs)
Merging printk/for-next (a26f18f291f6 Merge branch 'rework/misc-cleanups' i=
nto for-next)
Merging pci/next (f88d62edcda2 Merge branch 'pci/misc')
$ git reset --hard HEAD^
Merging next-20231020 version of pci
Merging pstore/for-next/pstore (a19d48f7c5d5 pstore/platform: Add check for=
 kstrdup)
Merging hid/for-next (d4ce72c23d31 Merge branch 'for-6.7/selftests' into fo=
r-next)
Merging i2c/i2c/for-next (5b4b16adb1a5 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (57ec42b9a1b7 i3c: Fix typo "Provisional ID" to "Provi=
sioned ID")
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (443f18550476 hwmon: (adt7475) Add support=
 for Imon readout on ADT7490)
Merging jc_docs/docs-next (f949cb759051 docs/zh_TW: update contents for zh_=
TW)
Merging v4l-dvb/master (94e27fbeca27 media: cec: meson: always include meso=
n sub-directory in Makefile)
Merging v4l-dvb-next/master (48016737a9af media: platform: cadence: select =
MIPI_DPHY dependency)
Merging pm/linux-next (90a7afcd5098 Merge branch 'acpi-scan' into linux-nex=
t)
Merging cpufreq-arm/cpufreq/arm/linux-next (5cbd528f6132 cpufreq: qcom-nvme=
m: add support for IPQ8064)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (8f0cd531ee18 dt-bindings: devfreq: event: roc=
kchip,dfi: Add rk3588 support)
Merging pmdomain/next (55089e1fb2d8 pmdomain: qcom: rpmhpd: Drop the ->opp_=
to_performance_state() callback)
CONFLICT (content): Merge conflict in drivers/soc/apple/Kconfig
Merging opp/opp/linux-next (35e0964e4876 dt-bindings: opp: opp-v2-kryo-cpu:=
 Document named opp-microvolt property)
Merging thermal/thermal/linux-next (5437d14d94c8 thermal/drivers/mediatek/l=
vts_thermal: Update calibration data documentation)
Merging dlm/next (eb53c01873ca MAINTAINERS: Update dlm maintainer and web p=
age)
Merging rdma/for-next (07f06e0e5cd9 RDMA/hns: Fix init failure of RoCE VF a=
nd HIP08)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/mr.c
Merging net-next/main (5e3704030b24 Merge branch 'bnxt_en-next')
Merging bpf-next/for-next (cf559a416f9b Merge branch 'bpf-fixes-for-per-cpu=
-kptr')
Merging ipsec-next/master (efedce336d71 Merge branch 'xfrm: policy: replace=
 session decode with flow dissector')
Merging mlx5-next/mlx5-next (82f9378c443c net/mlx5: Handle IPsec steering u=
pon master unbind/bind)
Merging netfilter-next/main (5e3704030b24 Merge branch 'bnxt_en-next')
Merging ipvs-next/main (c4eee56e14fe net: skb_find_text: Ignore patterns ex=
tending past 'to')
Merging bluetooth/master (8a589c6d138e Bluetooth: hci_sync: Fix Opcode prin=
ts in bt_dev_dbg/err)
Merging wireless-next/for-next (05ac1a198a63 wifi: wilc1000: use vmm_table =
as array in wilc struct)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (6135e730f81d mtd: Use device_get_match_data())
Merging nand/nand/next (6dc597401cf5 mtd: rawnand: Remove unused of_gpio.h =
inclusion)
Merging spi-nor/spi-nor/next (6823a8383420 mtd: spi-nor: micron-st: use SFD=
P table for mt25qu512a)
Merging crypto/master (a2786e8bdd02 crypto: qcom-rng - Add missing dependen=
cy on hw_random)
Merging drm/drm-next (035fdc38c1f6 Merge tag 'mediatek-drm-next-6.7' of htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-ne=
xt)
CONFLICT (modify/delete): arch/ia64/include/asm/fb.h deleted in HEAD and mo=
dified in drm/drm-next.  Version drm/drm-next of arch/ia64/include/asm/fb.h=
 left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/d=
ce110/dce110_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/hwss/d=
cn20/dcn20_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu11/si=
enna_cichlid_ppt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/gen8_engine_c=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_drv.h
$ git rm -f arch/ia64/include/asm/fb.h
Applying: fix up for "drm: Add HPD state to drm_connector_oob_hotplug_event=
()"
Applying: drm/amd/display: Reduce stack size by splitting function
Applying: drm/amd/display: Fix stack size issue on DML2
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (c2635c0ec8b4 arm64: defconfig: Enable ILIT=
EK_ILI9882T panel)
Merging amdgpu/drm-next (5b2c54e0d0ea drm/amd/display: Fix stack size issue=
 on DML2)
Merging drm-intel/for-linux-next (213c43676beb drm/i915/mtl: Remove the 'fo=
rce_probe' requirement for Meteor Lake)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (b08d26dac1a1 drm/msm/a7xx: actually use a7xx stat=
e registers)
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
Merging fbdev/for-next (f2b7d103df27 fbdev: offb: Simplify offb_init_fb())
Merging regmap/for-next (7b4d73072bcc Merge remote-tracking branch 'regmap/=
for-6.7' into regmap-next)
Merging sound/for-next (39cd06e3f7b7 Merge tag 'asoc-v6.7' of https://git.k=
ernel.org/pub/scm/linux/kernel/git/broonie/sound into for-next)
Merging ieee1394/for-next (a464d2f75fa1 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (386fc7c12a80 Merge remote-tracking branch 'aso=
c/for-6.7' into asoc-next)
Merging modules/modules-next (3111add7f414 module: Annotate struct module_n=
otes_attrs with __counted_by)
CONFLICT (content): Merge conflict in scripts/mod/modpost.c
Applying: fix up for "module: Make is_valid_name() return bool"
Merging input/next (6cd256694afe Input: tegra-kbc - use device_get_match_da=
ta())
Merging block/for-next (8aa6053114f3 Merge branch 'for-6.7/block' into for-=
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
CONFLICT (content): Merge conflict in drivers/nvme/target/tcp.c
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
$ git rm -f arch/ia64/kernel/syscalls/syscall.tbl
Merging device-mapper/for-next (1d99b7e95035 dm thin: Use the extent alloca=
tor for data blocks)
Merging libata/for-next (0e533cba3801 dt-bindings: ata: tegra: Disallow und=
efined properties)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (a2b8fa785358 mmc: jz4740: Use device_get_match_data())
Merging mfd/for-mfd-next (b5cd5e72a71e mfd: qcom-spmi-pmic: Switch to EXPOR=
T_SYMBOL_GPL())
Merging backlight/for-backlight-next (40da4737717b backlight: pwm_bl: Disab=
le PWM on shutdown, suspend and remove)
Merging battery/for-next (469d31745b9f power: reset: vexpress: Use device_g=
et_match_data())
Merging regulator/for-next (405c56cd47c4 Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (e50856067289 lsm: fix a spelling mistake)
Merging apparmor/apparmor-next (157a3537d6bc apparmor: Fix regression in mo=
unt mediation)
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
Merging iommu/next (5b9fdb13c0fb Merge branches 'arm/tegra', 'arm/smmu', 's=
390', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next)
CONFLICT (modify/delete): arch/s390/pci/pci_dma.c deleted in iommu/next and=
 modified in HEAD.  Version HEAD of arch/s390/pci/pci_dma.c left in tree.
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
$ git rm -f arch/s390/pci/pci_dma.c
Merging audit/next (97f576eb38ae audit: Annotate struct audit_chunk with __=
counted_by)
Merging devicetree/for-next (07a37547bd17 dt-bindings: arm: cpus: Add Qualc=
omm Kryo 465)
Merging dt-krzk/for-next (d896029c9726 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (9936214f22e4 Merge remote-tracking branch 'spi/for-6.=
7' into spi-next)
Merging tip/master (a040e853ea66 Merge branch into tip/master: 'x86/tdx')
CONFLICT (content): Merge conflict in arch/alpha/kernel/syscalls/syscall.tbl
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/x86-stub=
.c
CONFLICT (content): Merge conflict in include/linux/pci_ids.h
Merging clockevents/timers/drivers/next (0a8b07c77ea0 clocksource: Explicit=
ly include correct DT includes)
Merging edac/edac-for-next (0fd934580ea3 EDAC/versal: Add a Xilinx Versal m=
emory controller driver)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (4e6d16da50fa Merge probes/for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/user_events/a=
bi_test.c
$ git reset --hard HEAD^
Merging next-20231020 version of ftrace
CONFLICT (content): Merge conflict in tools/testing/selftests/user_events/a=
bi_test.c
[master 3652deca1ec1] next-20231020/ftrace
Merging rcu/rcu/next (5df10099418f srcu: Explain why callbacks invocations =
can't run concurrently)
Merging kvm/next (2b3f2325e71f Merge tag 'kvm-x86-selftests-6.6-fixes' of h=
ttps://github.com/kvm-x86/linux into HEAD)
Merging kvm-arm/next (c0e1ad686021 Merge branch kvm-arm64/stage2-vhe-load i=
nto kvmarm/next)
CONFLICT (content): Merge conflict in arch/arm64/kvm/arm.c
Merging kvms390/next (70fea3019516 KVM: s390: add tracepoint in gmap notifi=
er)
Merging kvm-ppc/topic/ppc-kvm (b7bce570430e powerpc/kvm: Force cast endiann=
ess of KVM shared regs)
CONFLICT (file location): Documentation/powerpc/kvm-nested.rst added in kvm=
-ppc/topic/ppc-kvm inside a directory that was renamed in HEAD, suggesting =
it should perhaps be moved to Documentation/arch/powerpc/kvm-nested.rst.
Merging kvm-riscv/riscv_kvm_next (62d0c458f828 KVM: riscv: selftests: get-r=
eg-list print_reg should never fail)
Merging kvm-x86/next (ec2f1daad460 Merge branches 'apic', 'docs', 'misc', '=
mmu', 'svm' and 'xen')
Merging xen-tip/linux-next (2c269f42d0f3 xen-pciback: Consider INTx disable=
d when MSI/MSI-X is enabled)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (d5ce8f4ed90b Merge branch 'for-6.7' into for-n=
ext)
Merging drivers-x86/for-next (3f720b21ec5a platform/x86/amd/pmc: Add dump_c=
ustom_stb module parameter)
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
Merging usb/usb-next (5220d8b04a84 dt-bindings: usb: gpio-sbu-mux: Make 'mo=
de-switch' not required)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/usb=
/ti,tps6598x.yaml
Merging thunderbolt/next (3e36528c1127 thunderbolt: Configure asymmetric li=
nk if needed and bandwidth allows)
Merging usb-serial/usb-next (8a749fd1a872 Linux 6.6-rc4)
Merging tty/tty-next (0059bc9a29e0 console: fix up ARM screen_info referenc=
e)
CONFLICT (modify/delete): arch/ia64/kernel/setup.c deleted in HEAD and modi=
fied in tty/tty-next.  Version tty/tty-next of arch/ia64/kernel/setup.c lef=
t in tree.
CONFLICT (modify/delete): drivers/firmware/pcdp.c deleted in HEAD and modif=
ied in tty/tty-next.  Version tty/tty-next of drivers/firmware/pcdp.c left =
in tree.
$ git rm -f arch/ia64/kernel/setup.c drivers/firmware/pcdp.c
Merging char-misc/char-misc-next (2399cde86e0f Merge tag 'counter-updates-f=
or-6.7a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into =
char-misc-next)
Merging accel/habanalabs-next (08057253366d Merge tag 'drm-habanalabs-next-=
2023-10-10' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linu=
x into drm-next)
Merging coresight/next (4708eada8bd6 hwtracing: hisi_ptt: Add dummy callbac=
k pmu::read())
Merging fastrpc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging fpga/for-next (d79eed22ba97 fpga: versal: Add support for 44-bit DM=
A operations)
Merging icc/icc-next (d4c720a19e9a Merge branch 'icc-platform-remove' into =
icc-next)
Merging iio/togreg (89e2233386a5 iio: proximity: sx9324: Switch to device_p=
roperty_match_property_string())
Merging phy-next/next (03c866cab420 dt-bindings: phy: Convert PXA1928 USB/H=
SIC PHY to DT schema)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/phy=
/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
Merging soundwire/next (4ea2b6d3128e soundwire: dmi-quirks: update HP Omen =
match)
Merging extcon/extcon-next (b3edc3463d64 extcon: realtek: add the error han=
dler for nvmem_cell_read)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (bd885fcf28da vfio: Fix smatch errors in vfio_combine_iov=
a_ranges())
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (875be090928d staging: qlge: Retire the driver)
CONFLICT (modify/delete): drivers/staging/qlge/qlge_devlink.c deleted in st=
aging/staging-next and modified in HEAD.  Version HEAD of drivers/staging/q=
lge/qlge_devlink.c left in tree.
$ git rm -f drivers/staging/qlge/qlge_devlink.c
Merging counter-next/counter-next (7904cdf1397c counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (03f25d53b145 dmaengine: stm32-mdma: correct desc pr=
ep when channel running)
Merging cgroup/for-next (b9a477034b11 Merge branch 'for-6.7' into for-next)
Merging scsi/for-next (e0b9142e933d Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (2bbeb8d12404 scsi: core: Handle depopulation and=
 restoration in progress)
Merging vhost/linux-next (5788c7aa2e75 vdpa_sim: implement .reset_map suppo=
rt)
Merging rpmsg/for-next (2cf7b3e8fb72 Merge branches 'hwspinlock-next' and '=
rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (dc850faa28ee hte: tegra194: don't access s=
truct gpio_chip)
CONFLICT (content): Merge conflict in drivers/gpio/gpio-ljca.c
CONFLICT (content): Merge conflict in drivers/gpio/gpio-vf610.c
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (a64f16de8076 Merge branch 'devel' into for-next)
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
Merging kselftest/next (5247e6dbed00 selftests/resctrl: Fix MBM test failur=
e when MBA unavailable)
CONFLICT (content): Merge conflict in tools/testing/selftests/clone3/clone3=
.c
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
Merging nvmem/for-next (24bd074c417b nvmem: Use device_get_match_data())
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (dd712d3d4580 kgdb: Flush console before enterin=
g kgdb on panic)
Merging hmm/hmm (0bb80ecc33a8 Linux 6.6-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (b910ee376ab3 bus: mhi: ep: Do not allocate event ring=
 element on stack)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (5329aa5101f7 efivarfs: Add uid/gid mount options)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/slab/for-next (e050a704f3c3 Merge branch 'slab/for-6.6/hotfixe=
s' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (8b729be04c8f landlock: Document Landlock's network s=
upport)
Merging rust/rust-next (a7135d107547 rust: Use grep -Ev rather than relying=
 on GNU grep)
Merging sysctl/sysctl-next (ccee9a2a8c00 intel drm: Remove now superfluous =
sentinel element from ctl_table array)
Merging execve/for-next/execve (21ca59b365c0 binfmt_misc: enable sandboxed =
mounts)
Merging bitmap/bitmap-for-next (bdcb37a5d8de buildid: reduce header file de=
pendencies for module)
Merging hte/for-next (091ac92dc79e hte: tegra194: Switch to LATE_SIMPLE_DEV=
_PM_OPS())
Merging kspp/for-next/kspp (8d7af820310c MAINTAINERS: Include stackleak pat=
hs in hardening entry)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging iommufd/for-next (dc7ce51ff885 iommufd/selftest: Test IOMMU_HWPT_GE=
T_DIRTY_BITMAP_NO_CLEAR flag)
CONFLICT (content): Merge conflict in drivers/iommu/intel/pasid.c
CONFLICT (content): Merge conflict in include/linux/iommu.h

--Sig_/6fsD0mrYU0Qiw8zdlVsZL0r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU2C4cACgkQAVBC80lX
0Gxf5gf9EHwquvBzJ8vzJvw/OpUnTzekJ1jzyhHdlw/qvam6JT4B03vFttl9M59j
8zDN6toQO4VIVEIxysT9ToPqyg9WVOZce9z45tmyWSlNd4P57/tuekPiry1iR9Pu
vMBsfOW8Hnp9Qi5wSyGcifcIpx1yZN8jga27YYpWgL2CnyZa4kQWMva2d8vnU0d1
XN3y5owt2ydyWDXP524Wqfi9HanKT6amvv3KDv3bHw51PAYzAe91v21lC9jnAmt9
w1vKUXHuJ6IBb6JOFaTu6kq46Macvfs+p6Coz5FOjWcpuOyh+4uZA+tRBEAW7C6e
4Z4jtT5jJswrUaN8oRhYbmO1A8VXgA==
=7qEG
-----END PGP SIGNATURE-----

--Sig_/6fsD0mrYU0Qiw8zdlVsZL0r--
