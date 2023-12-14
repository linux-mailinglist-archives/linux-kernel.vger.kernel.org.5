Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C998126F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443162AbjLNFda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjLNFd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:33:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F8BD;
        Wed, 13 Dec 2023 21:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702532009;
        bh=ueTc87wi/WZqUixGMvvyEJm99xkO19d01bALgaeDbhM=;
        h=Date:From:To:Cc:Subject:From;
        b=e6aY0IjCAUW4tFNEwcWoFFcLuGjrFKQ6AtdvNdoRagHTjqKAJlaFkiiiTCubFndUH
         1eL4LQhd96R8P5O5Wa0T6O52+5sTZ8JpWnImUppVJBPfUIKKdgln/LTPUVTuj4tz62
         aW1iRbgHaF05nup9zbIAejUZ2eBXQ5WgfSFZ87ptz3rDPxbzR9a8ugSMxZdZEG+DGq
         OnhkQVjS3ssIRDx+pd7KJeSBbeLX7hdFIyQueQUHbTKdOLLVuYkyFCqWejCocGeB+4
         Wpmj3p2pTXmsV9u0xteAZimXOBJrYDZnEUkxNboLZKhZj3jNDo+Je3bhaYAG94JHzl
         SkYTxhIm6kcAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrLc90jFsz4wcJ;
        Thu, 14 Dec 2023 16:33:29 +1100 (AEDT)
Date:   Thu, 14 Dec 2023 16:33:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 14
Message-ID: <20231214163327.50094c39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ePP4w2Q_wS9c7Ng/+jSCWPw";
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

--Sig_/ePP4w2Q_wS9c7Ng/+jSCWPw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20231213:

The arm-perf tree lost its build failure.

The aspeed tree lost its build failure.

The net-next tree gained a conflict against the net tree.

Non-merge commits (relative to Linus' tree): 6906
 7119 files changed, 321067 insertions(+), 196585 deletions(-)

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

I am currently merging 371 trees (counting Linus' and 105 trees of bug
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
Merging origin/master (5bd7ef53ffe5 Merge tag 'pull-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (4380b26f913e kunit: kasan_test: d=
isable fortify string checker on kmalloc_oob_memset)
Applying: Revert "maple_tree: do not preallocate nodes for slot stores"
Merging kbuild-current/fixes (98b1cc82c4af Linux 6.7-rc2)
Merging arc-current/for-curr (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (3c0696076aad arm64: mm: Always make sw-=
dirty PTEs hw-dirty in pte_modify)
Merging arm-soc-fixes/arm/fixes (fd1e5745f87a Merge tag 'v6.7-rockchip-dtsf=
ixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchi=
p into arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (03191fb3db3d m68k: lib: Include <linux/libg=
cc.h> for __muldi3())
Merging powerpc-fixes/fixes (4b3338aaa74d powerpc/ftrace: Fix stack teardow=
n in ftrace_no_trace)
Merging s390-fixes/fixes (b1a6a1a77f06 s390/scm: fix virtual vs physical ad=
dress confusion)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (9702817384aa Revert "tcp: disable tcp_autocorking for soc=
ket when TCP_NODELAY flag is set")
Merging bpf/master (e307b5a845c5 octeontx2-af: Fix pause frame configuratio=
n)
Merging ipsec/master (76df934c6d5f MAINTAINERS: Add netdev subsystem profil=
e link)
Merging netfilter/main (1ae4cd3cbdd0 Merge branch 'bnxt_en-misc-fixes')
Merging ipvs/main (54d4434da824 Merge branch 'hv_netvsc-fix-race-of-netvsc-=
vf-register-and-slave-bit')
Merging wireless/for-next (cd607f2cbbbe wifi: mt76: fix crash with WED rx s=
upport enabled)
Merging wpan/master (2d1c882d4434 Merge tag 'mlx5-fixes-2023-10-12' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging rdma-fixes/for-rc (a39b6ac3781d Linux 6.7-rc5)
Merging sound-current/for-linus (33071422714a ALSA: hda/tas2781: handle mis=
sing EFI calibration data)
Merging sound-asoc-fixes/for-linus (dc96528b176f ASoC: cs42l43: Don't enabl=
e bias sense during type detect)
Merging regmap-fixes/for-linus (fea88064445a regmap: fix bogus error on reg=
cache_sync success)
Merging regulator-fixes/for-linus (b85ea95d0864 Linux 6.7-rc1)
Merging spi-fixes/for-linus (e9b220aeacf1 spi: spi-imx: correctly configure=
 burst length when using dma)
Merging pci-current/for-linus (7ff2b7a1821b PCI/ASPM: Add pci_disable_link_=
state_locked() lockdep assert)
Merging driver-core.current/driver-core-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty.current/tty-linus (a39b6ac3781d Linux 6.7-rc5)
Merging usb.current/usb-linus (da48708e8733 Merge tag 'thunderbolt-for-v6.7=
-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt =
into usb-linus)
Merging usb-serial-fixes/usb-linus (2cc14f52aeb7 Linux 6.7-rc3)
Merging phy/fixes (2a9c713825b3 phy: sunplus: return negative error code in=
 sp_usb_phy_probe)
Merging staging.current/staging-linus (98b1cc82c4af Linux 6.7-rc2)
Merging iio-fixes/fixes-togreg (408d4b33c244 iio: adc: MCP3564: fix hardwar=
e identification logic)
Merging counter-current/counter-current (a39b6ac3781d Linux 6.7-rc5)
Merging char-misc.current/char-misc-linus (76101fa0c0a9 Merge tag 'iio-fixe=
s-for-6.7a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (393cae5f32d6 soundwire: intel_ace2x: fix AC =
timing setting for ACE2.x)
Merging thunderbolt-fixes/fixes (f0b94c1c5c79 thunderbolt: Fix minimum allo=
cated USB 3.x and PCIe bandwidth)
Merging input-current/for-linus (c3d1610345b7 Input: xpad - add Razer Wolve=
rine V2 support)
Merging crypto-current/master (9aedd10fe384 crypto: ahash - Set using_shash=
 for cloned ahash wrapper over shash)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (4ee632c82d2d dmaengine: fsl-edma: fix DMA ch=
annel leak in eDMAv4)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (7c1b1906229d mtd: spinand: gigadevice: Fix the=
 get ecc status issue)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (32138be394e5 Merge tag 'media-renesas-fixes-20=
231113' of git://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.gi=
t)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (a39b6ac3781d Linux 6.7-rc5)
Merging at91-fixes/at91-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging omap-fixes/fixes (c72b9c33ef96 ARM: OMAP2+: Fix null pointer derefe=
rence and memory leak in omap_soc_device_init)
Merging kvm-fixes/master (4cdf351d3630 KVM: SVM: Update EFER software model=
 on CR0 trap for SEV-ES)
Merging kvms390-fixes/master (27072b8e18a7 KVM: s390/mm: Properly reset no-=
dat)
Merging hwmon-fixes/hwmon (a39b6ac3781d Linux 6.7-rc5)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (8f61d48c83f6 tools/testing/cxl: Slow down the mock=
 firmware transfer)
Merging btrfs-fixes/next-fixes (cdec1b57f10a Merge branch 'misc-6.7' into n=
ext-fixes)
Merging vfs-fixes/fixes (485053bb81c8 fix ufs_get_locked_folio() breakage)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (7bcd032370f8 platform/x86: intel_ips: fix =
kernel-doc formatting)
Merging samsung-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging pinctrl-samsung-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging devicetree-fixes/dt/linus (136c6531ba12 dt-bindings: display: adi,a=
dv75xx: Document #sound-dai-cells)
Merging dt-krzk-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging scsi-fixes/fixes (235f2b548d7f scsi: be2iscsi: Fix a memleak in bei=
scsi_init_wrb_handle())
Merging drm-fixes/drm-fixes (a39b6ac3781d Linux 6.7-rc5)
Merging drm-intel-fixes/for-linux-next-fixes (e6861d8264cd drm/i915/edp: do=
n't write to DP_LINK_BW_SET when using rate select)
Merging mmc-fixes/fixes (1036f69e2513 mmc: core: Cancel delayed work before=
 releasing host)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (98b1cc82c4af Linux 6.7-rc2)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (eb46a0076501 riscv: Check if the code to patch =
lies in the exit section)
Merging riscv-dt-fixes/riscv-dt-fixes (79997eda0d31 riscv: dts: microchip: =
move timebase-frequency to mpfs.dtsi)
Merging riscv-soc-fixes/riscv-soc-fixes (b85ea95d0864 Linux 6.7-rc1)
Merging fpga-fixes/fixes (b85ea95d0864 Linux 6.7-rc1)
Merging spdx/spdx-linus (a39b6ac3781d Linux 6.7-rc5)
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
Merging efi-fixes/urgent (50d7cdf7a9b1 efi/x86: Avoid physical KASLR on old=
er Dell systems)
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
Merging drm-misc-fixes/for-linux-next-fixes (6c9dbee84cd0 drm/panel: ltk050=
h3146w: Set burst mode for ltk050h3148w)
Merging mm-stable/mm-stable (d9d9bd979cce maple_tree: change return type of=
 mas_split_final_node as void.)
Merging mm-nonmm-stable/mm-nonmm-stable (fc0fbad122a7 merge mm-hotfixes-sta=
ble into mm-nonmm-stable to pick up depended-upon changes)
Merging mm/mm-everything (042a6de0ab2c Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (44028378399f gen_compile_commands.py: fix path res=
olve with symlinks in it)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (1bc479d665bc perf hisi-ptt: Fix one memory le=
akage in hisi_ptt_process_auxtrace_event())
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (53c87e846e33 swiotlb: fix out-of-bounds TLB a=
llocations with CONFIG_SWIOTLB_DYNAMIC)
Merging asm-generic/master (d6e81532b10d Hexagon: Make pfn accessors static=
s inlines)
CONFLICT (content): Merge conflict in arch/mips/include/asm/traps.h
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (f1ff4ced177d Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (34b0bd1a02c7 Merge branch 'for-next/fixes' int=
o for-next/core)
Merging arm-perf/for-next/perf (f56bb3de66bc MAINTAINERS: add maintainers f=
or DesignWare PCIe PMU driver)
Merging arm-soc/for-next (52cff57c4356 Merge branch 'arm/fixes' into for-ne=
xt)
Merging amlogic/for-next (4b87b5f60812 Merge branch 'v6.8/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e17770a3388e ARM: dts: aspeed: Harma: Add Meta Har=
ma (AST2600) BMC)
Merging at91/at91-next (58f72e7817f1 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (62a3c97f8167 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (4a23d0f9814c memory: tegra: Protect SID ov=
erride call under CONFIG_IOMMU_API)
Merging imx-mxs/for-next (8c3c7094bf5b Merge branch 'imx/dt64' into for-nex=
t)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (ca8454133d38 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (0ea5e8402a47 Merge branches 'omap-for-v6.8/dt', 'oma=
p-for-v6.8/defconfig' and 'omap-for-v6.8/maintainers' into for-next)
Merging qcom/for-next (fc538f5c65c2 Merge branches 'arm32-for-6.8', 'arm64-=
defconfig-for-6.8', 'arm64-for-6.8', 'clk-for-6.8', 'drivers-fixes-for-6.7'=
 and 'drivers-for-6.8' into for-next)
Applying: fix up for "of: Stop circularly including of_device.h and of_plat=
form.h"
Merging renesas/next (a4ce2434e9bb Merge branches 'renesas-drivers-for-v6.8=
' and 'renesas-dts-for-v6.8' into renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (f3038f517d8e Merge branch 'v6.8-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (20c61794a302 Merge branch 'next/drivers' int=
o for-next)
Merging scmi/for-linux-next (7c2d214ab5b9 Merge tag 'scmi-updates-6.8' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (9a7308232a11 ARM: dts: stm32: add SPI support on =
STM32F746)
Merging sunxi/sunxi/for-next (715a9e70bdd4 Merge branch 'sunxi/clk-for-6.8'=
 into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (650220c2b474 Merge branch for-6.7/arm64/dt into for=
-next)
Merging ti/ti-next (1f66e787a614 Merge branches 'ti-k3-dts-next' and 'ti-k3=
-config-next' into ti-next)
Merging xilinx/for-next (21d01d5afbc8 Merge remote-tracking branch 'zynqmp/=
soc' into for-next)
Merging clk/clk-next (78140324e480 Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (144f1b70ea9e dt-bindings: clock: support i.MX93 A=
NATOP clock module)
Merging clk-renesas/renesas-clk (515f05da372a clk: renesas: r9a08g045: Add =
clock and reset support for ETH0 and ETH1)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (e2f7b3d8b4b3 LoongArch: BPF: Fix uncondit=
ional bswap instructions)
Merging m68k/for-next (03191fb3db3d m68k: lib: Include <linux/libgcc.h> for=
 __muldi3())
Merging m68knommu/for-next (a39b6ac3781d Linux 6.7-rc5)
Merging microblaze/next (ffb0399437ef microblaze: defconfig: Enable the Mar=
vell phy driver)
Merging mips/mips-next (01940cd4a6b9 MIPS: SGI-IP27: hubio: fix nasid kerne=
l-doc warning)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (33cc938e65a9 Linux 6.7-rc4)
Merging powerpc/next (27951e1d8274 powerpc/pseries/memhp: Log more error co=
nditions in add path)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (f352a28cc2fb Merge patch series "riscv: report mor=
e ISA extensions through hwprobe")
Merging riscv-dt/riscv-dt-for-next (56b10953da7e riscv: dts: starfive: Enab=
le SDIO wifi on JH7100 boards)
CONFLICT (content): Merge conflict in arch/riscv/boot/dts/sophgo/cv1800b.dt=
si
Applying: fixup for "riscv: dts: sophgo: Separate compatible specific for C=
V1800B soc"
Merging riscv-soc/riscv-soc-for-next (b9a58c68ea4e Merge branch 'riscv-cach=
e-for-next' into riscv-soc-for-next)
Merging s390/for-next (9e81a2e6f94c Merge branch 'features' into for-next)
Merging sh/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (791beae7335c xtensa: Use PCI_HEADER_TYPE_MF=
D instead of literal)
Merging bcachefs/for-next (eabfeffdd839 bcachefs: bch2_trans_srcu_lock() sh=
ould be static)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (0fc24a6549f9 fscrypt: update comment for do_remov=
e_key())
Merging afs/afs-next (f1302568cc65 afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (dd555d646448 Merge branch 'for-next-next-v6.7-20231=
213' into for-next-20231213)
Merging ceph/master (d30d7c57a64d ceph: select FS_ENCRYPTION_ALGS if FS_ENC=
RYPTION)
Merging cifs/for-next (3a42709fa909 smb: client: fix OOB in smb2_query_repa=
rse_point())
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (6b07eb162932 erofs: enable sub-page compressed block sup=
port)
Merging exfat/dev (6dfb1f0dfdb0 exfat: do not zero the extended part)
Merging ext3/for_next (46ee834035ac Pull quota cleanup from Chao Yu.)
Merging ext4/dev (6c02757c9360 jbd2: fix soft lockup in journal_finish_inod=
e_data_buffers())
Merging f2fs/dev (d346fa09abff f2fs: sysfs: support discard_io_aware)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (9fd6b6bdb5a4 gfs2: rgrp: fix kernel-doc warnings)
Merging jfs/jfs-next (cca974daeb6c jfs: fix shift-out-of-bounds in dbJoin)
Merging ksmbd/ksmbd-for-next (8b8cd4beea4f Merge tag '6.7-rc5-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (f003a717ae90 nfs: Convert nfs_symlink() to use a fo=
lio)
Merging nfs-anna/linux-next (379e4adfddd6 NFSv4.1: fixup use EXCHGID4_FLAG_=
USE_PNFS_DS for DS server)
Merging nfsd/nfsd-next (59392e03bfaa svcrdma: Move the svc_rdma_cc_init() c=
all)
Merging ntfs3/master (652483bfbc45 fs/ntfs3: Fix c/mtime typo)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (93496a8afc35 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (75690493591f ubifs: ubifs_link: Fix wrong name len calc=
ulating when UBIFS is encrypted)
Merging v9fs/9p-next (ff49bf186757 net: 9p: avoid freeing uninit memory in =
p9pdu_vreadf)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (18793e050504 xfs: move xfs_ondisk.h to libxfs/)
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
Merging vfs-brauner/vfs.all (205e4a2dcc37 Merge branch 'vfs.iov_iter' into =
vfs.all)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/subpage.c
CONFLICT (content): Merge conflict in fs/btrfs/super.c
CONFLICT (content): Merge conflict in fs/buffer.c
CONFLICT (content): Merge conflict in include/linux/blk_types.h
Applying: linux-next: manual merge of the vfs-brauner tree with the btrfs t=
ree
Merging vfs/for-next (3f95c5b76257 Merge branch 'work.minix' into for-next)
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (67e04d921cb6 Merge branch 'pci/switchtec')
Merging pstore/for-next/pstore (24a0b5e196cf pstore: inode: Use cleanup.h f=
or struct pstore_private)
Merging hid/for-next (96930896ab11 Merge branch 'for-6.8/nintendo' into for=
-next)
Merging i2c/i2c/for-next (382561d16854 i2c: ocores: Move system PM hooks to=
 the NOIRQ phase)
Merging i3c/i3c/next (b4da37db3e2c i3c: master: Fix build error)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (dfaacc77d787 dt-bindings: hwmon: gpio-fan=
: Convert txt bindings to yaml)
Merging jc_docs/docs-next (50709576d81b Documentation: Destage TEE subsyste=
m documentation)
Merging v4l-dvb/master (a00b3f296eac media: mediatek: vcodec: Set the suppo=
rted vp9 profile for each platform)
Merging v4l-dvb-next/master (efa28efd9cba media: rkisp1: resizer: Stop manu=
al allocation of v4l2_subdev_state)
Merging pm/linux-next (a5166a012448 Merge branches 'acpi-misc', 'acpi-soc' =
and 'acpi-numa' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c4a5118a3ae1 cpufreq: scmi: pro=
cess the result of devm_of_clk_add_hw_provider())
Merging cpupower/cpupower (997bbf2accf6 tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (4920ee6dcfaf PM / devfreq: Convert to use sys=
fs_emit_at() API)
Merging pmdomain/next (05ce71929efc PM: domains: Drop the unused pm_genpd_o=
pp_to_performance_state())
Merging opp/opp/linux-next (19cc8b1819a4 OPP: Check for invalid OPP in dev_=
pm_opp_find_level_ceil())
Merging thermal/thermal/linux-next (9618efe343ea thermal/qcom/tsens: Drop o=
ps_v0_1)
Merging dlm/next (0c08699744d2 dlm: implement EXPORT_OP_ASYNC_LOCK)
Merging rdma/for-next (07f830ae4913 RDMA/bnxt_re: Adds MSN table capability=
 for Gen P7 adapters)
Merging net-next/main (604ca8ee7bdc Merge branch 'virtio-net-dynamic-coales=
cing-moderation')
CONFLICT (content): Merge conflict in drivers/net/ethernet/broadcom/bnxt/bn=
xt.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/broadcom/bnxt/bn=
xt_ptp.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/fw_reset.c
Merging bpf-next/for-next (733763285acf Merge branch 'bpf-token-support-in-=
libbpf-s-bpf-object')
Merging ipsec-next/master (aadbd27f9674 net: phy: correctly check soft_rese=
t ret ONLY if defined for PHY)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_la=
rge and use it in rtnl_getlink)
Merging ipvs-next/main (ac40916a3f72 rtnetlink: introduce nlmsg_new_large a=
nd use it in rtnl_getlink)
Merging bluetooth/master (19921189d442 Bluetooth: Add more enc key size che=
ck)
Merging wireless-next/for-next (afd549903ea9 wifi: iwlegacy: Add null point=
er check to il_leds_init())
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (83fcf26b00d7 ieee802154: Give the user the as=
sociation list)
Merging mtd/mtd/next (b85ea95d0864 Linux 6.7-rc1)
Merging nand/nand/next (3c8260ce7663 mtd: rawnand: brcmnand: exec_op implem=
entation)
Merging spi-nor/spi-nor/next (c692ba6de1c5 mtd: spi-nor: micron-st: Add sup=
port for mt25qu01g)
Merging crypto/master (99bd99d3e3a7 crypto: algif_skcipher - Fix stream cip=
her chaining)
Merging drm/drm-next (a0a28956b46e Merge tag 'amd-drm-next-6.8-2023-12-08' =
of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (7347fb4e7db1 dt-bindings: display: samsu=
ng,exynos-mixer: Fix 'regs' typo)
Merging drm-misc/for-linux-next (b1a2aa9bcbb8 drm: ci: Update xfails)
Merging amdgpu/drm-next (65d2765d6291 drm/amdgpu: warn when there are still=
 mappings when a BO is destroyed v2)
Merging drm-intel/for-linux-next (8cd53c6b200e drm/i915: Simplify intel_ddi=
_compute_min_voltage_level())
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (236fa3873de8 drm/ci: remove rebase-merge director=
y)
Applying: fix up for "drm/exec: Pass in initial # of objects"
Merging drm-msm-lumag/msm-next-lumag (8ecdc6966aef drm/ci: uprev mesa versi=
on: fix kdl commit fetch)
Merging etnaviv/etnaviv/next (925b10728f20 drm/etnaviv: disable MLCG and pu=
lse eater on GPU reset)
Merging fbdev/for-next (13366c25125e fbdev: amba-clcd: Delete the old CLCD =
driver)
CONFLICT (modify/delete): drivers/video/fbdev/amba-clcd.c deleted in fbdev/=
for-next and modified in HEAD.  Version HEAD of drivers/video/fbdev/amba-cl=
cd.c left in tree.
CONFLICT (modify/delete): drivers/video/fbdev/vermilion/vermilion.c deleted=
 in fbdev/for-next and modified in HEAD.  Version HEAD of drivers/video/fbd=
ev/vermilion/vermilion.c left in tree.
$ git rm -f drivers/video/fbdev/amba-clcd.c drivers/video/fbdev/vermilion/v=
ermilion.c
Merging regmap/for-next (a2d43f711790 Merge remote-tracking branch 'regmap/=
for-6.8' into regmap-next)
Merging sound/for-next (1ccffc2f760a ASoC: SOF: Intel: pci-mtl: add HDA_ARL=
 PCI support)
Merging ieee1394/for-next (c12d7aa7ffa4 firewire: Annotate struct fw_node w=
ith __counted_by)
Merging sound-asoc/for-next (52acb65a3e78 Merge remote-tracking branch 'aso=
c/for-6.8' into asoc-next)
Merging modules/modules-next (4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-f=
ixes' of git://git.samba.org/ksmbd)
Merging input/next (302393f6def1 Input: vivaldi - convert to use sysfs_emit=
_at() API)
Merging block/for-next (fa40384aced4 Merge branch 'for-6.8/block' into for-=
next)
Merging device-mapper/for-next (7f1e151e3ed4 MAINTAINERS: remove stale info=
 for DEVICE-MAPPER)
Merging libata/for-next (804901fdd637 ata: pata_pxa: convert not to use dma=
_request_slave_channel())
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (72cd89517fa0 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (03d790f04fb2 mfd: intel-lpss: Fix the fractional =
clock divider flags)
Merging backlight/for-backlight-next (7d84a63a39b7 backlight: hx8357: Conve=
rt to agnostic GPIO API)
Merging battery/for-next (b55d073e6501 power: supply: bq256xx: fix some pro=
blem in bq256xx_hw_init)
Merging regulator/for-next (a142ae76e1e1 regulator: Convert to platform rem=
ove callback)
Merging security/next (ec4e9d630a64 calipso: fix memory leak in netlbl_cali=
pso_add_pass())
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
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
Merging integrity/next-integrity (b4af096b5df5 KEYS: encrypted: Add check f=
or strsep)
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
Merging iommu/next (ef17ca0186ad Merge branches 'apple/dart', 'virtio', 'x8=
6/amd' and 'core' into next)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging audit/next (24fade412acf Automated merge of 'dev' into 'next')
Merging dt-krzk/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging mailbox/for-next (fbce94a444fb mailbox: qcom-apcs-ipc: re-organize =
compatibles with fallbacks)
Merging spi/for-next (3eae3373d868 Merge remote-tracking branch 'spi/for-6.=
8' into spi-next)
Merging tip/master (09a8b70c495f Merge branch into tip/master: 'x86/sgx')
Merging clockevents/timers/drivers/next (d25e52a7eb36 clocksource/drivers/c=
adence-ttc: Fix some kernel-doc warnings)
Merging edac/edac-for-next (a69badad736c EDAC, pnd2: Sort headers alphabeti=
cally)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (e1742fa172d5 Merge probes/for-next)
Merging rcu/rcu/next (bf05d5105026 Merge branches 'doc.2023.11.23a', 'tortu=
re.2023.11.23a', 'fixes.2023.12.12b', 'rcu-tasks.2023.12.12b' and 'srcu.202=
3.12.12b' into rcu-merge.2023.12.12a)
Merging kvm/next (8ed26ab8d591 KVM: clean up directives to compile out irqf=
ds)
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
Merging kvm-x86/next (f2a3fb7234e5 Merge branches 'fixes', 'generic', 'hype=
rv', 'lam', 'misc', 'mmu', 'pmu', 'selftests', 'svm' and 'xen')
Merging xen-tip/linux-next (7f3da4b698bc xen/events: fix error code in xen_=
bind_pirq_msi_to_irq())
Merging percpu/for-next (33cc938e65a9 Linux 6.7-rc4)
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
Merging leds-lj/for-leds-next (40cfa414e7f9 leds: sun50i-a100: Avoid divisi=
on-by-zero warning)
Merging ipmi/for-next (c5d03a0d8461 ipmi: Use regspacings passed as a modul=
e parameter)
Merging driver-core/driver-core-next (7c41da586e9f driver core: Emit reason=
 for pending deferred probe)
Merging usb/usb-next (51920207674e usb: fotg210-udc: fix function kernel-do=
c comments)
Merging thunderbolt/next (655b8af57d31 thunderbolt: Remove duplicated re-as=
signment of pointer 'out')
Merging usb-serial/usb-next (2cc14f52aeb7 Linux 6.7-rc3)
Merging tty/tty-next (e045e18dbf3e Merge 6.7-rc5 into tty-next)
Merging char-misc/char-misc-next (e909abe885e2 Merge tag 'coresight-next-v6=
.8' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into c=
har-misc-next)
CONFLICT (content): Merge conflict in drivers/android/binder_alloc.c
Merging accel/habanalabs-next (dfbf6719ccb4 accel/habanalabs/gaudi2: avoid =
overriding existing undefined opcode data)
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging fpga/for-next (5496fb8eedd6 drivers/fpga: use standard array-copy f=
unction)
Merging icc/icc-next (4bd79ce1a365 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (9f4e9ffee974 iio: light: pa1203001: Drop ACPI_PTR() pro=
tection.)
Merging phy-next/next (7f6f9e0def00 phy: qcom-qmp-usb: Add Qualcomm SDX75 U=
SB3 PHY support)
Merging soundwire/next (55d50ace6b88 soundwire: generic_bandwidth_allocatio=
n use bus->params.max_dr_freq)
Merging extcon/extcon-next (7803680964c0 extcon: qcom-spmi-misc: don't use =
kernel-doc marker for comment)
Merging gnss/gnss-next (98b1cc82c4af Linux 6.7-rc2)
Merging vfio/next (946cff255dfa Merge branches 'v6.8/vfio/debugfs', 'v6.8/v=
fio/pds' and 'v6.8/vfio/type1-account' into v6.8/vfio/next)
Merging w1/for-next (efc19c44aa44 w1: amd_axi_w1: Explicitly include correc=
t DT includes)
Merging spmi/spmi-next (0a080ab6bc28 spmi: mediatek: add device id check)
Merging staging/staging-next (345586fed2e0 staging: rtl8192e: renamed varia=
ble IOTPeer)
Merging counter-next/counter-next (a39b6ac3781d Linux 6.7-rc5)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (70f008fb3ea9 dmaengine: dmatest: prevent using swio=
tlb buffer with nobounce parameter)
Merging cgroup/for-next (b7aaea747923 Merge branch 'for-6.8' into for-next)
Merging scsi/for-next (45d0d7374dce Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (e78e59acfb69 Merge patch series "scsi: Convert t=
o platform remove callback returning" void)
Merging vhost/linux-next (b8e079244992 virtio_blk: fix snprintf truncation =
compiler warning)
Merging rpmsg/for-next (7641890179f9 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (d22f93c6a0df gpio: sim: implement the dbg_=
show() callback)
Merging gpio-intel/for-next (92fc925f8386 gpio: tangier: simplify locking u=
sing cleanup helpers)
Merging pinctrl/for-next (977f293b0b84 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (6191e49de389 pinctrl: baytrail: Simplify co=
de with cleanup helpers)
CONFLICT (content): Merge conflict in drivers/pinctrl/intel/pinctrl-baytrai=
l.c
Merging pinctrl-renesas/renesas-pinctrl (0c22012758ea pinctrl: renesas: rzg=
2l: Add input enable to the Ethernet pins)
Merging pinctrl-samsung/for-next (6cf96df77338 pinctrl: samsung: add exynos=
autov920 pinctrl)
Merging pwm/for-next (2cc2cb184833 pwm: Stop referencing pwm->chip)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (130a83879954 selftests: sched: Remove initializatio=
n to 0 for a static variable)
Merging kunit/test (b85ea95d0864 Linux 6.7-rc1)
Merging kunit-next/kunit (b285ba6f8cc1 kunit: test: Use an action wrapper i=
nstead of a cast)
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
Merging fsi/next (4c968e3b4763 fsi: sbefifo: Handle pending write command)
Merging slimbus/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging nvmem/for-next (82c6ba6a7d96 nvmem: brcm_nvram: store a copy of NVR=
AM content)
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
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (5d09c63f11f0 cxl/hdm: Remove broken error path)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (94f7f6182c72 efivarfs: automatically update super block f=
lag)
Merging unicode/for-next (807f06d1074d ecryptfs: Reject casefold directory =
inodes)
Merging slab/slab/for-next (f7eb801fcdb1 Merge branch 'slab/for-6.8/slub-ho=
ok-cleanups' into slab/for-next)
CONFLICT (content): Merge conflict in mm/kasan/quarantine.c
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (a50156fe3dcb landlock: Document IOCTL support)
Merging rust/rust-next (d9857c16cfc6 rust: Suppress searching builtin sysro=
ot)
Merging sysctl/sysctl-next (a6fd07f80ab7 coda: Remove the now superfluous s=
entinel elements from ctl_table array)
Merging execve/for-next/execve (0a8a952a75f2 ELF, MAINTAINERS: specifically=
 mention ELF)
Merging bitmap/bitmap-for-next (27c82f14e6d2 lib/find: optimize find_*_bit_=
wrap)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (a75b3809dce2 qnx4: Use get_directory_fname() in=
 qnx4_match())
Merging kspp-gustavo/for-next/kspp (617ab3c357d2 init: Kconfig: Disable -Ws=
tringop-overflow for GCC-11)
Merging nolibc/nolibc (d543d9ddf593 selftests/nolibc: disable coredump via =
setrlimit)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (b2b67c997bf7 iommufd: Organize the mock domain al=
loc functions closer to Joerg's tree)
Merging devicetree/for-next (b492af27d0c8 Merge branch 'dt/header-fixes-for=
-next' into for-next)
Applying: ntfs3: align struct ATTR_LIST_ENTRY

--Sig_/ePP4w2Q_wS9c7Ng/+jSCWPw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV6k6cACgkQAVBC80lX
0GyF9Qf/fJRLFU/uwhVx3t+j6m1Y1S7/qI0RdKtNhG+fFapGGRDFSb+0pPGoWe3D
b1rtU744W9tAKpYqMqDkzT5Ksz/9oSb3yBsc0X2qEazHxKvSPrdG5nRulT1h5Our
Ch+niT9vx9y0QjWl60ZtwWFU+MihYN1R/Pw/maH9A9OZQy7PQjQhQ4rmPgRDcSmn
RYR+Xg5+omYlBxSkxFw8OR4y9YE9bRX3/34pXqNLSqf/8hdmnXhsrZ/c9p2Dz0t9
ILs6mwcNWqxNuS/9le5a6XkTfAv2BZqVZyvYTMmHCSAJEV99ctzwQhFNzrRG94MZ
PH7ZpNp8BJ0N5JDEBmBW02BTUqSIjA==
=8c0w
-----END PGP SIGNATURE-----

--Sig_/ePP4w2Q_wS9c7Ng/+jSCWPw--
