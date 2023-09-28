Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C67B11B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjI1Er7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Er4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:47:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94E139;
        Wed, 27 Sep 2023 21:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695876462;
        bh=BJgfeHxkhrTflasqEcmMprbizwAo1WEF9A/Vg3+nr5U=;
        h=Date:From:To:Cc:Subject:From;
        b=b9eoZobBjnUylOGTjRqm5HOMMsVZ4VXH01UgeMxyemhh7HJ6RTEofN9K5r9/BLMyN
         b1en+r8pWBwnA7bZ7fYvw/Dn5HS9ABp6VSQi3+rEN5E463eWPzTTczc3qtkBdYD6Im
         1LwhiCIZeB7IBPnp92XkNVl+RMC3QVgu5mi6UzMN4m66hxquoR3cyDsGPRi0YFLDLQ
         ggsZZGtLWXYxf1inHl/b+d4fCojdAqWZAj7/X9eExS4USOoQHi6CLEuClKN0XbTg8y
         8GZrVQ5USJ6rww051q+ktcVk9DGW0VtI9couuTF7i59Gj2xRGsfAfjP0JkoHLiKzG6
         0or4FjOpMAxDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rx1Dt19YTz4xQV;
        Thu, 28 Sep 2023 14:47:42 +1000 (AEST)
Date:   Thu, 28 Sep 2023 14:47:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 28
Message-ID: <20230928144740.4cace8ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TmlNTdj7sydsV56mjIASJHk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TmlNTdj7sydsV56mjIASJHk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230927:

The vfs-brauner tree gained a conflict against the mm tree and a semantic
conflict against the bcachfs tree.  It also gained a build failure,
so I used the version from next-20230927.

The rdma tree gained a conflict against the rdma-fixes tree.

The drm tree gained a conflict against the drm-misc-fixes tree.

Non-merge commits (relative to Linus' tree): 7835
 5929 files changed, 521194 insertions(+), 145996 deletions(-)

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
Merging origin/master (633b47cb009d Merge tag 'scsi-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (3f00ae8a711a mmap: fix error path=
s with dup_anon_vma())
Merging kbuild-current/fixes (28d49e171676 Documentation: kbuild: explain h=
andling optional dependencies)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (6995e2de6891 Linux 6.4)
Merging arm64-fixes/for-next/fixes (44a5b6b5c7fe arm64: Document missing us=
erspace visible fields in ID_AA64ISAR2_EL1)
Merging arm-soc-fixes/arm/fixes (a16d7a3d4624 Merge tag 'aspeed-6.6-maintai=
ners' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc into arm/fi=
xes)
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
Merging net/main (a59addacf899 drivers/net: process the result of hdlc_open=
() and add call of hdlc_close() in uhdlc_close())
Merging bpf/master (81335f90e8a8 bpf: unconditionally reset backtrack_state=
 masks on global func exit)
Merging ipsec/master (cc9b364bb1d5 xfrm6: fix inet6_dev refcount underflow =
problem)
Merging netfilter/main (ecf4392600dd Merge tag 'nf-23-09-20' of https://git=
.kernel.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging ipvs/main (4e4b1798cc90 vxlan: Add missing entries to vxlan_get_siz=
e())
Merging wireless/for-next (22061bfc57fe wifi: iwlwifi: mvm: Fix incorrect u=
sage of scan API)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (374012b00457 RDMA/mlx5: Fix mkey cache possible =
deadlock on cleanup)
Merging sound-current/for-linus (d93eeca627db ALSA: hda/realtek - ALC287 me=
rge RTK codec with CS CS35L41 AMP)
Merging sound-asoc-fixes/for-linus (2b21207afd06 ASoC: fsl-asoc-card: use i=
nteger type for fll_id and pll_id)
Merging regmap-fixes/for-linus (7a795ac8d49e regmap: rbtree: Fix wrong regi=
ster marked as in-cache when creating new node)
Merging regulator-fixes/for-linus (6e800968f6a7 regulator/core: Revert "fix=
 kobject release warning and memory leak in regulator_register()")
Merging spi-fixes/for-linus (3b4e5194138b dt-bindings: spi: fsl-imx-cspi: D=
ocument missing entries)
Merging pci-current/for-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging driver-core.current/driver-core-linus (6465e260f487 Linux 6.6-rc3)
Merging tty.current/tty-linus (29346e217b8a Revert "tty: n_gsm: fix UAF in =
gsm_cleanup_mux")
Merging usb.current/usb-linus (6465e260f487 Linux 6.6-rc3)
Merging usb-serial-fixes/usb-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging phy/fixes (11395c32f9e9 phy: qualcomm: Fix typos in comments)
Merging staging.current/staging-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging iio-fixes/fixes-togreg (9352321402f4 iio: adc: ad7192: Correct refe=
rence voltage)
Merging counter-current/counter-current (df8fdd01c98b counter: microchip-tc=
b-capture: Fix the use of internal GCLK logic)
Merging char-misc.current/char-misc-linus (0e4cac557531 misc: rtsx: Fix som=
e platforms can not boot and move the l1ss judgment to probe)
Merging soundwire-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging thunderbolt-fixes/fixes (308092d08085 thunderbolt: Restart XDomain =
discovery handshake after failure)
Merging input-current/for-linus (e28a0974d749 Input: xpad - add HyperX Clut=
ch Gladiate Support)
Merging crypto-current/master (21155620fbf2 crypto: sm2 - Fix crash caused =
by uninitialized context)
Merging vfio-fixes/for-linus (c777b11d34e0 vfio/mdev: Fix a null-ptr-deref =
bug for mdev_unregister_parent())
Merging kselftest-fixes/fixes (6f874fa021df selftests: Fix wrong TARGET in =
kselftest top level Makefile)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (5279f4a9eed3 mtd: rawnand: qcom: Unmap the rig=
ht resource upon probe failure)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (263cb0cc5aba media: imx-mipi-csis: Remove an i=
ncorrect fwnode_handle_put() call)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (ef8f8f04a0b2 MIPS: Alchemy: only build mmc s=
upport helpers if au1xmmc is enabled)
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
Merging btrfs-fixes/next-fixes (bcfb98cbdfee Merge branch 'misc-6.6' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (bc3b6f59463b MAINTAINERS: Add x86 platform=
 drivers patchwork)
Merging samsung-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-samsung-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging devicetree-fixes/dt/linus (11b1c9cda5d0 dt-bindings: riscv: cpus: A=
dd missing additionalProperties on interrupt-controller node)
Merging dt-krzk-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging scsi-fixes/fixes (b481f644d917 scsi: zfcp: Fix a double put in zfcp=
_port_enqueue())
Merging drm-fixes/drm-fixes (69390f3528f5 MAINTAINERS: update nouveau maint=
ainers)
Merging drm-intel-fixes/for-linux-next-fixes (907ef0398c93 i915/guc: Get ru=
ntime pm in busyness worker only if already active)
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
Merging fpga-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging spdx/spdx-linus (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl-fixes/gpio/for-current (26d9e5640d21 gpio: pmic-eic-sprd:=
 Add can_sleep flag for PMIC EIC chip)
Merging gpio-intel-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl-intel-fixes/fixes (2d325e54d9e2 pinctrl: baytrail: fix debo=
unce disable case)
Merging erofs-fixes/fixes (f939aeea7ab7 erofs: allow empty device tags in f=
latdev mode)
Merging kunit-fixes/kunit-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (55122e0130e5 memblock tests: fix warning =E2=
=80=98struct seq_file=E2=80=99 declared inside parameter list)
Merging nfsd-fixes/nfsd-fixes (88956eabfdea NFSD: fix possible oops when nf=
sd/pool_stats is closed.)
Merging irqchip-fixes/irq/irqchip-fixes (9b8df572ba3f irqchip: renesas-rzg2=
l: Fix logic to clear TINT interrupt source)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (e47749f1796d perf jevent: fix core dump on=
 software events on s390)
Merging efi-fixes/urgent (8dbe33956d96 efi/unaccepted: Make sure unaccepted=
 table is mapped)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (488ef44c068e power: supply: rk817: Fix node re=
fcount leak)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (0bb80ecc33a8 Linux 6.6-rc1)
Merging rust-fixes/rust-fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (0bb80ecc33a8 Linux 6.6-rc1)
Merging pmdomain-fixes/fixes (e2ad626f8f40 pmdomain: Rename the genpd subsy=
stem to pmdomain)
Merging overlayfs-fixes/ovl-fixes (724768a39374 ovl: fix incorrect fdput() =
on aio completion)
Merging drm-misc-fixes/for-linux-next-fixes (645d694559ca accel/ivpu: Use c=
ached buffers for FW loading)
Merging mm-stable/mm-stable (ce9ecca0238b Linux 6.6-rc2)
Merging mm-nonmm-stable/mm-nonmm-stable (ce9ecca0238b Linux 6.6-rc2)
Merging mm/mm-everything (63b5dffa6668 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/shmem.c
Applying: fix for "fs/proc/task_mmu: hide unused pagemap_scan_backout_range=
() function"
Merging kbuild/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (f9cdeb58a9cf perf evlist: Avoid frequency mod=
e for the dummy event)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (2d5780bbef8d swiotlb: fix the check whether a=
 device has used software IO TLB)
Merging asm-generic/master (43ff221426d3 Merge tag 'tag-remove-ia64' of git=
://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux into asm-generic)
CONFLICT (modify/delete): arch/ia64/kernel/setup.c deleted in asm-generic/m=
aster and modified in HEAD.  Version HEAD of arch/ia64/kernel/setup.c left =
in tree.
$ git rm -f arch/ia64/kernel/setup.c
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (bf6547d8715b Merge branches 'for-next/sve-remo=
ve-pseudo-regs', 'for-next/backtrace-ipi' and 'for-next/kselftest' into for=
-next/core)
Merging arm-perf/for-next/perf (21b61fe48c2f drivers/perf: hisi: Update HiS=
ilicon PMU maintainers)
Merging arm-soc/for-next (a16d7a3d4624 Merge tag 'aspeed-6.6-maintainers' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc into arm/fixes)
Merging amlogic/for-next (929266f846b3 Merge branch 'v6.7/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (b51f63b7c71d ARM: dts: aspeed: Minerva: Add Facebo=
ok Minerva CMC board)
Merging at91/at91-next (4d25c04fc1fe ARM: dts: at91: sama5d29_curiosity: Ad=
d device tree for sama5d29_curiosity board)
Merging broadcom/next (a70e8c9ff89a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (c1f2c81631df memory: atmel-ebi: Annotate s=
truct atmel_ebi_dev with __counted_by)
Merging imx-mxs/for-next (7ff3609efc0d Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (93e6b023e552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (de2733f7ad6f Merge branch 'omap-for-v6.7/dt' into fo=
r-next)
Merging qcom/for-next (033d6c239515 Merge branches 'arm64-defconfig-for-6.7=
', 'arm64-fixes-for-6.6', 'arm64-for-6.7', 'clk-for-6.7', 'drivers-for-6.7'=
 and 'dts-for-6.7' into for-next)
Merging renesas/next (e3de1a23ef40 Merge branches 'renesas-arm-defconfig-fo=
r-v6.7', 'renesas-arm-soc-for-v6.7', 'renesas-drivers-for-v6.7', 'renesas-d=
t-bindings-for-v6.7' and 'renesas-dts-for-v6.7' into renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (6d1fa8808888 Merge branch 'v6.5-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (4399e5a4a1aa Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (10c05acef2d2 Merge branches 'for-next/scmi/fix=
es', 'for-next/ffa/fixes', 'for-next/scmi/updates', 'for-next/vexpress/upda=
tes' and 'for-next/pcc/updates' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (682656ca763a ARM: dts: stm32: omit unused pinctrl=
 groups from stm32mp15 dtb files)
Merging sunxi/sunxi/for-next (b3eaec0789d8 riscv: dts: allwinner: d1: Add P=
MU event node)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (c62440bd774b Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (d8cce0d5ba4a firmware: ti_sci: refactor deprecated strn=
cpy)
Merging xilinx/for-next (68d0db38a90f arm64: dts: xilinx: Apply overlays to=
 base dtbs)
Merging clk/clk-next (78fd9cf91630 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging clk-renesas/renesas-clk (87882525e5dd clk: renesas: r8a7795: Consti=
fy r8a7795_*_clks)
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (17dcae78a04e Merge branch 'loongarch-kvm'=
 into loongarch-next)
Merging m68k/for-next (0c316da2164c m68k: Replace GPL 2.0+ README.legal boi=
lerplate with SPDX)
Merging m68knommu/for-next (581c32d1678d m68k: 68000: fix warning in timer =
code)
Merging microblaze/next (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mips/mips-next (6465e260f487 Linux 6.6-rc3)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (289e0fe7d897 parisc: Restore __ldcw_align for P=
A-RISC 2.0 processors)
Merging powerpc/next (c945e6f453a3 powerpc/configs: Remove ReiserFS from de=
fconfig)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-dt/riscv-dt-for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging riscv-soc/riscv-soc-for-next (22dedf8f4570 soc/microchip: mpfs-sys-=
controller: Convert to platform remove callback returning void)
Merging s390/for-next (a8dbae76e7bc Merge branch 'features' into for-next)
Merging sh/for-next (246f80a0b17f sh: push-switch: Reorder cleanup operatio=
ns to avoid use-after-free bug)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (e31ca0a83d66 Merge branch 'xtensa-6.6-fixes=
' into xtensa-for-next)
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
Merging ceph/master (0b207d02bd9a rbd: take header_rwsem in rbd_dev_refresh=
() only when updating)
Merging cifs/for-next (6465e260f487 Linux 6.6-rc3)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (91b1ad0815fb erofs: release ztailpacking pclusters prope=
rly)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (d1d3fcb324ec udf: Annotate struct udf_bitmap with __=
counted_by)
Merging ext4/dev (7fda67e8c3ab ext4: fix rec_len verify error)
Merging f2fs/dev (3e729e50d01e f2fs: preload extent_cache for POSIX_FADV_WI=
LLNEED)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (ae3024a4c499 docs/fuse-io: Document the usage of DIR=
ECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (16d54c9eea4f gfs2: More aggressive page fault-in)
Merging jfs/jfs-next (0225e10972fa jfs: validate max amount of blocks befor=
e allocation.)
Merging ksmbd/ksmbd-for-next (73f949ea87c7 ksmbd: check iov vector index in=
 ksmbd_conn_write())
Merging nfs/linux-next (2dde18cd1d8f Linux 6.5)
Merging nfs-anna/linux-next (26e8bfa30dac SUNRPC/TLS: Lock the lower_xprt d=
uring the tls handshake)
Merging nfsd/nfsd-next (ea3f13fb3e66 NFSD: simplify error paths in nfsd_svc=
())
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (898a0be0436c ovl: Add documentation on ne=
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
Merging iomap/iomap-for-next (381c043233e6 iomap: add a workaround for racy=
 i_size updates on block devices)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (ceb9b9787790 Merge branch 'vfs.super' into vfs=
.all)
CONFLICT (content): Merge conflict in fs/xfs/xfs_buf.c
Applying: Revert "block: Remove blkdev_get_by_*() functions"
$ git reset --hard HEAD^
Merging next-20230927 version of vfs-brauner
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (5834f8e72b1b Merge branch 'rework/nbcon-base' into=
 for-next)
Merging pci/next (87ab156b7bb2 Merge branch 'pci/endpoint')
Merging pstore/for-next/pstore (5ee1a4304799 docs: pstore-blk.rst: fix typo=
, s/console/ftrace)
Merging hid/for-next (c01db7054615 Merge branch 'for-6.6/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (b5d463c0eecb Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (cab63f648876 i3c: Fix potential refcount leak in i3c_=
master_register_new_i3c_devs)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (443f18550476 hwmon: (adt7475) Add support=
 for Imon readout on ADT7490)
Merging jc_docs/docs-next (1f597b1a6ec2 docs: security: Confidential comput=
ing intro and threat model for x86 virtualization)
Merging v4l-dvb/master (2c1bae27df78 media: qcom: camss: Fix pm_domain_on s=
equence in probe)
Merging v4l-dvb-next/master (72666b8ca7dd media: atomisp: Drop atomisp-ov56=
93 sensor driver)
Merging pm/linux-next (a2577d67cb05 Merge branch 'pm-sleep' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (0361e81f3170 dt-bindings: cpufr=
eq: qcom-cpufreq-nvmem: document IPQ9574)
Merging cpupower/cpupower (0bb80ecc33a8 Linux 6.6-rc1)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging pmdomain/next (da384a1380ab pmdomain: qcom: rpmhpd: Add support for=
 SM7150 rpmh clocks)
CONFLICT (content): Merge conflict in drivers/soc/apple/Kconfig
Merging opp/opp/linux-next (d1f97b7149af OPP: debugfs: Fix warning with W=
=3D1 builds)
Merging thermal/thermal/linux-next (edd220b33f47 thermal: core: Drop therma=
l_zone_device_register())
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (8dc0fd2f5693 RDMA/ipoib: Add support for XDR speed i=
n ethtool)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/mr.c
Merging net-next/main (5a1b322cb0b7 Merge branch 'mlxsw-multicast')
Merging bpf-next/for-next (0e73ef1d8c09 Merge branch 'bpf: Add missed stats=
 for kprobes')
Merging ipsec-next/master (3a69ab875233 Merge branch 'ionic-better-tx-sg=3D=
handling')
Merging mlx5-next/mlx5-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging netfilter-next/main (b3af9c0e89ca Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/bpf/bpf-next)
Merging ipvs-next/main (0201409079b9 net: spider_net: Use size_add() in cal=
l to struct_size())
Merging bluetooth/master (0a9113316083 Bluetooth: btusb: Add RTW8852BE devi=
ce 13d3:3570 to device tables)
Merging wireless-next/for-next (2a1c5c7de468 wifi: mac80211: expand __ieee8=
0211_data_to_8023() status)
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
Merging crypto/master (1c43c0f1f84a crypto: x86/sha - load modules based on=
 CPU features)
Merging drm/drm-next (f107ff76a8c2 Merge tag 'drm-misc-next-2023-09-11-1' o=
f git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/accel/ivpu/ivpu_fw.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_drv.h
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (a4ead6e37e32 drm/nouveau/kms/nv50: hide un=
used variables)
CONFLICT (content): Merge conflict in drivers/accel/qaic/qaic_data.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_conne=
ctor.c
Merging amdgpu/drm-next (90295cf73b6a drm/amd: Drop error message about fai=
ling to load DMUB firmware)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dis=
covery.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_gfx=
.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_svm.c
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
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu_v13_0_6_ppsmc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/smu_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c
Merging drm-intel/for-linux-next (f83b94d23770 drm/i915/dsb: Use DEwake to =
combat PkgC latency)
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
Merging sound/for-next (f5cc9cdfc96f ALSA: usx2y: Annotate struct snd_usx2y=
_urb_seq with __counted_by)
Merging ieee1394/for-next (a464d2f75fa1 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (ad484cc98f2c ASoC: remove asoc_xxx() compatibl=
e macro)
CONFLICT (content): Merge conflict in sound/pci/hda/cs35l41_hda.c
Merging modules/modules-next (3111add7f414 module: Annotate struct module_n=
otes_attrs with __counted_by)
Merging input/next (c50fdc48643a Input: wm97xx-core - convert to platform r=
emove callback returning void)
Merging block/for-next (6ed50b760bec Merge branch 'io_uring-futex' into for=
-next)
CONFLICT (modify/delete): arch/ia64/kernel/syscalls/syscall.tbl deleted in =
HEAD and modified in block/for-next.  Version block/for-next of arch/ia64/k=
ernel/syscalls/syscall.tbl left in tree.
$ git rm -f arch/ia64/kernel/syscalls/syscall.tbl
Merging device-mapper/for-next (3110b72d9cca dm: shortcut the calls to line=
ar_map and stripe_map)
Merging libata/for-next (f940258b63da ata: libata: Cleanup inline DMA helpe=
r functions)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (09b59829715b mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (f747b627d395 mfd: stm32-timers: Add support for i=
nterrupts)
Merging backlight/for-backlight-next (a4464092f2c5 backlight: led_bl: Remov=
e redundant of_match_ptr())
Merging battery/for-next (43ee22422db5 power: supply: mm8013: Fix error cod=
e in mm8013_probe())
Merging regulator/for-next (25451539808c Merge remote-tracking branch 'regu=
lator/for-6.7' into regulator-next)
Merging security/next (41e845628511 cred: add get_cred_many and put_cred_ma=
ny)
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (91e326563ee3 ima: rework CONFIG_IMA depen=
dency block)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (9d140885e35d selinux: hweight optimization in avtab_r=
ead_item)
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (ea72883a3bf1 tpm: Fix typo in tpmrm class definition)
Merging watchdog/master (ce9ecca0238b Linux 6.6-rc2)
Merging iommu/next (83653d850805 Merge branches 'iommu/fixes', 'arm/tegra',=
 'x86/amd' and 'core' into next)
Merging audit/next (97f576eb38ae audit: Annotate struct audit_chunk with __=
counted_by)
Merging devicetree/for-next (bc17fd92c1eb dt-bindings: interrupt-controller=
: qcom,pdc: document qcom,sm4450-pdc)
Merging dt-krzk/for-next (d896029c9726 Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (c0e5800e60f6 Merge remote-tracking branch 'spi/for-6.=
7' into spi-next)
Merging tip/master (1924ebcc1b22 Merge branch into tip/master: 'x86/asm')
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
Merging kvm-arm/next (1f66f1246bfa Merge branch kvm-arm64/6.6/misc into kvm=
arm-master/next)
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-ppc/topic/ppc-kvm (476652297f94 docs: powerpc: Document nested =
KVM on POWER)
Merging kvm-riscv/riscv_kvm_next (071ef070ca77 KVM: riscv: selftests: Selec=
tively filter-out AIA registers)
Merging kvm-x86/next (5804c19b80bf Merge tag 'kvm-riscv-fixes-6.6-1' of htt=
ps://github.com/kvm-riscv/linux into HEAD)
Merging xen-tip/linux-next (0fc6ff5a0f04 xen/efi: refactor deprecated strnc=
py)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (f1df12bd27f6 Merge branch 'for-6.7-rust-bindin=
gs' into for-next)
Merging drivers-x86/for-next (6cb9c8637c67 platform/x86: think-lmi: Use str=
replace() to replace a character by nul)
Merging chrome-platform/for-next (1aa8df90f456 platform/chrome: wilco_ec: A=
nnotate struct ec_event_queue with __counted_by)
Merging chrome-platform-firmware/for-firmware-next (0bb80ecc33a8 Linux 6.6-=
rc1)
Merging hsi/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (685f192b3a0a leds: turris-omnia: Add support=
 for enabling/disabling HW gamma correction)
Merging ipmi/for-next (b00839ca4cca ipmi: refactor deprecated strncpy)
Merging driver-core/driver-core-next (6465e260f487 Linux 6.6-rc3)
Merging usb/usb-next (6465e260f487 Linux 6.6-rc3)
Merging thunderbolt/next (0c35ac182569 thunderbolt: Apply USB 3.x bandwidth=
 quirk only in software connection manager)
Merging usb-serial/usb-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging tty/tty-next (c980248179d6 serial: xilinx_uartps: Use port lock wra=
ppers)
Merging char-misc/char-misc-next (6465e260f487 Linux 6.6-rc3)
Merging accel/habanalabs-next (38519d8ecee7 accel/habanalabs: minor cosmeti=
c update to habanalabs.h)
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging icc/icc-next (6ac3f01201fa Merge branch 'icc-debugfs' into icc-next)
Merging iio/togreg (9dc03309fe9b iio: ad4310: Replace devm_clk_register() w=
ith devm_clk_hw_register())
Merging phy-next/next (56156a76e765 phy: qualcomm: phy-qcom-eusb2-repeater:=
 Add tuning overrides)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-m31.c
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
.c
Merging soundwire/next (95b0f3aa71eb soundwire: qcom: Log clk_get("iface") =
failures)
Merging extcon/extcon-next (ce9ecca0238b Linux 6.6-rc2)
Merging gnss/gnss-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging vfio/next (642265e22ecc vfio/pds: Send type for SUSPEND_STATUS comm=
and)
Merging w1/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging staging/staging-next (eb507641d0be staging: vt6655: Type encoding i=
nfo dropped from variable "byRFType")
Merging counter-next/counter-next (631c15d5f14d counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (0bb80ecc33a8 Linux 6.6-rc1)
Merging cgroup/for-next (105f3fe9188b cgroup/cpuset: Extend test_cpuset_prs=
.sh to test remote partition)
Merging scsi/for-next (82e1f0070c0c Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (5ef104b749e8 scsi: fnic: Clean up some inconsist=
ent indenting)
Merging vhost/linux-next (1acfe2c12258 virtio_ring: fix avail_wrap_counter =
in virtqueue_add_packed)
Merging rpmsg/for-next (1a93ced18d7b Merge branches 'hwspinlock-next' and '=
rproc-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (3a7fd473bd5d mtd: rawnand: ingenic: move t=
he GPIO quirk to gpiolib-of.c)
Merging gpio-intel/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging pinctrl/for-next (b5d808409c20 Merge branch 'devel' into for-next)
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
Merging kunit-next/kunit (ee5f8cc2770b kunit: Reset test status on each par=
am iteration)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging nvdimm/libnvdimm-for-next (fd86eff33898 libnvdimm: Annotate struct =
nd_region with __counted_by)
Merging at24/at24/for-next (997a29bbb1e0 eeprom: at24: Annotate struct at24=
_data with __counted_by)
Merging ntb/ntb-next (643982232860 ntb: Check tx descriptors outstanding in=
stead of head/tail for tx queue)
Merging seccomp/for-next/seccomp (ce9ecca0238b Linux 6.6-rc2)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (c52b640214d7 nvmem: qfprom: Mark core clk as option=
al)
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
Merging slab/slab/for-next (3cf4b36b634f Merge branch 'slab/for-6.7/orders-=
cleanup' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (2a2015495142 selftests/landlock: Fix a resource leak)
Merging rust/rust-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging sysctl/sysctl-next (d12ff982e72d c-sky: Remove now superfluous sent=
inel element from ctl_talbe array)
CONFLICT (modify/delete): arch/ia64/kernel/crash.c deleted in HEAD and modi=
fied in sysctl/sysctl-next.  Version sysctl/sysctl-next of arch/ia64/kernel=
/crash.c left in tree.
$ git rm -f arch/ia64/kernel/crash.c
Merging execve/for-next/execve (ff7a65492c4c elf, uapi: Remove struct tag '=
dynamic')
Merging bitmap/bitmap-for-next (bcafd8b927ed bitmap: Remove dead code, i.e.=
 bitmap_copy_le())
Merging hte/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging kspp/for-next/kspp (e7ff7d8b56c0 MAINTAINERS: hardening: Add Gustav=
o as Reviewer)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (0bb80ecc33a8 Linux 6.6-rc1)
Merging iommufd/for-next (474d9f32766a iommufd: Fix spelling errors in comm=
ents)

--Sig_/TmlNTdj7sydsV56mjIASJHk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUVBWwACgkQAVBC80lX
0GzRjgf8CBgoJ5xX9sHYs2CL6UngYhw2Ie1A+g8lOiEXF8il1Z10pGp7XoaPXEaJ
SVqiyIl+spQPmBmh2/0zHp69dyc7AExAS5yOdK8F33dzpcyB8Ql3R/r2j5wMA1g5
c6elaK9aOoL/OtAG9BjJ1kKJM8JAWWD4YGHmvPxZuNuCJ+4ppAa/BX09Ek5TgHon
6KfuKCVakuhoYUbq1msk3ckNIM6MrhhVBj4TUrhZ6VSzuoEm87TKkLrrKoYKbRY7
+OO4+ikeKxX08auFKaMruHrCWhxkgZJ06LgEq3wOKqDW9ESbV8fhwStFXaczzsOF
gm1QhBkBlQIL5NMlKoJMwmPqg6b0gA==
=4oYE
-----END PGP SIGNATURE-----

--Sig_/TmlNTdj7sydsV56mjIASJHk--
