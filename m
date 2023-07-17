Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D23755A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGQDqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGQDqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:46:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A27134;
        Sun, 16 Jul 2023 20:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689565591;
        bh=h1qNDn9LDsd0Hq/RgGYxM9tcytAl7u9zwDpk4Hw9gSY=;
        h=Date:From:To:Cc:Subject:From;
        b=SEw+kJOBLshSGwyVzU/UWQ6I4XmW95zE7JCFGlEqeMtw5fDx7RS/cCzxf9JAr4333
         oV8W6XDHrjkYHVXxKLjDQaDEoTuU5jkKw4v1ya73q8bz0NAM9Hbp4KKUgq7lUkBuAn
         u8wRTT/e9KRKrB8aOOwn0pE5jUqqX229hQvg7tCgpkukyaF7xaxyk3gqLb1+8/qL+1
         oKSBLWyf7s680G8tEjMFOvLbCGxjVkGD2KSZ4iDNZL+CUsvjnFinbRwT9OsYDvSw7J
         ftkLelPFz7MDhfa8mkKZGjYkwZLI53GyfpEMKzLfQq6dJ0AUyCQpTvuN10ZPF6rESd
         n58Wna0xv09Rw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R47Kz3p2yz4wxP;
        Mon, 17 Jul 2023 13:46:31 +1000 (AEST)
Date:   Mon, 17 Jul 2023 13:46:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 17
Message-ID: <20230717134628.232a029a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZS6C+qU8pxZ8QTON2_S1OGs";
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

--Sig_/ZS6C+qU8pxZ8QTON2_S1OGs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230714:

The pm tree lost its build failure.

The bluetooth tree still had its build failure for which I reverted a commi=
t.

The cgroup tree gained a semantic conflict against the tip tree.

Non-merge commits (relative to Linus' tree): 2489


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

I am currently merging 360 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (5b8d6e853949 Merge tag 'xtensa-20230716' of https://=
github.com/jcmvbkbc/linux-xtensa)
Merging fixes/fixes (d528014517f2 Revert ".gitignore: ignore *.cover and *.=
mbx")
Merging mm-hotfixes/mm-hotfixes-unstable (92d4fa336aa9 mm-shmem-fix-race-in=
-shmem_undo_range-w-thp-fix)
Merging kbuild-current/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (2b951b0efbaa ARM: 9297/1: vfp: avoid unbalanced =
stack on 'success' return path)
Merging arm64-fixes/for-next/fixes (55b87b749963 arm64: Fix HFGxTR_EL2 fiel=
d naming)
Merging arm-soc-fixes/arm/fixes (6722e46513e0 bus: ixp4xx: fix IXP4XX_EXP_T=
1_MASK)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (4055eabe04a2 m68k: defconfig: Update defcon=
figs for v6.4-rc1)
Merging powerpc-fixes/fixes (cf53564b11ce powerpc/mm/book3s64/hash/4k: Add =
pmd_same callback for 4K page size)
Merging s390-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (0dd1805fe498 Merge branch 'net-fix-kernel-doc-problems-in=
-include-net')
Merging bpf/master (9840036786d9 gso: fix dodgy bit handling for GSO_UDP_L4)
Merging ipsec/master (57010b8ece28 xfrm: Silence warnings triggerable by ba=
d packets)
Merging netfilter/main (9d0aba98316d gve: unify driver name usage)
Merging ipvs/main (1a7d09a737a0 Merge tag 'nf-23-06-27' of git://git.kernel=
.org/pub/scm/linux/kernel/git/netfilter/nf)
Merging wireless/for-next (f1a0898b5d6a wifi: iwlwifi: mvm: spin_lock_bh() =
to fix lockdep regression)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (e77ac83ee5fd RDMA/irdma: Fix data race on CQP re=
quest done)
Merging sound-current/for-linus (69ea4c9d02b7 ALSA: hda/realtek - remove 3k=
 pull low procedure)
Merging sound-asoc-fixes/for-linus (5c4bad3bc8b5 Merge remote-tracking bran=
ch 'asoc/for-6.4' into asoc-linus)
Merging regmap-fixes/for-linus (963b54df82b6 regmap-irq: Fix out-of-bounds =
access when allocating config buffers)
Merging regulator-fixes/for-linus (91ca9066e0a4 Merge remote-tracking branc=
h 'regulator/for-6.4' into regulator-linus)
Merging spi-fixes/for-linus (2aa892b69539 Merge remote-tracking branch 'spi=
/for-6.4' into spi-linus)
Merging pci-current/for-linus (37540db221e1 MAINTAINERS: Add Manivannan Sad=
hasivam as DesignWare PCIe driver maintainer)
Merging driver-core.current/driver-core-linus (06c2afb862f9 Linux 6.5-rc1)
Merging tty.current/tty-linus (06c2afb862f9 Linux 6.5-rc1)
Merging usb.current/usb-linus (06c2afb862f9 Linux 6.5-rc1)
Merging usb-serial-fixes/usb-linus (06c2afb862f9 Linux 6.5-rc1)
Merging phy/fixes (8932089b566c phy: qcom-snps-femto-v2: use qcom_snps_hsph=
y_suspend/resume error code)
Merging staging.current/staging-linus (06c2afb862f9 Linux 6.5-rc1)
Merging iio-fixes/fixes-togreg (48faabfb3634 dt-bindings: iio: adi,ad74115:=
 remove ref from -nanoamp)
Merging counter-current/counter-current (9b53a1342216 counter: Fix menuconf=
ig "Counter support" submenu entries disappearance)
Merging char-misc.current/char-misc-linus (06c2afb862f9 Linux 6.5-rc1)
Merging soundwire-fixes/fixes (7891d0a5ce6f soundwire: amd: Fix a check for=
 errors in probe())
Merging thunderbolt-fixes/fixes (6995e2de6891 Linux 6.4)
Merging input-current/for-linus (eb09074bdb05 Input: i8042 - add quirk for =
TUXEDO Gemini 17 Gen1/Clevo PD70PN)
Merging crypto-current/master (0b7ec177b589 crypto: algif_hash - Fix race b=
etween MORE and non-MORE sends)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (569f8b501b17 selftests/arm64: fix build fail=
ure during the "emit_tests" step)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (d2a257684758 dmaengine: mcf-edma: Fix a pote=
ntial un-allocated memory access)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (ea690ad78dd6 mtd: rawnand: rockchip: Align hwe=
cc vs. raw page helper layouts)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (f2702d8e53d8 media: verisilicon: change confus=
ingly named relaxed register access)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging at91-fixes/at91-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (2623b3dc875a Merge tag 'kvmarm-fixes-6.4-4' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (a746b3689546 hwmon: (aquacomputer_d5next) Fix in=
correct PWM value readout)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (0e99e96b85fc cxl/acpi: Return 'rc' instead of '0' =
in cxl_parse_cfmws())
Merging btrfs-fixes/next-fixes (a14ea7d5b756 Merge branch 'misc-6.5' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (676b7c5ecab3 platform/x86: serial-multi-in=
stantiate: Auto detect IRQ resource for CSC3551)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (0bb8f49cd2cc of: Preserve "of-display" d=
evice name for compatibility)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (f4d1a8e01190 scsi: storvsc: Handle SRB status val=
ue 0x30)
Merging drm-fixes/drm-fixes (38d88d5e97c9 Merge tag 'amd-drm-fixes-6.5-2023=
-07-12' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (113899c2669d drm/i915: Fix on=
e wrong caching mode enum usage)
Merging mmc-fixes/fixes (5def5c1c15bf mmc: sdhci-f-sdh30: Replace with sdhc=
i_pltfm)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (06c2afb862f9 Linux 6.5-rc1)
Merging hyperv-fixes/hyperv-fixes (55e544e1a922 x86/hyperv: Improve code fo=
r referencing hyperv_pcpu_input_arg)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (ab2dbc7acced RISC-V: Don't include Zicsr or Zif=
encei in I from ACPI)
Merging riscv-dt-fixes/riscv-dt-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (06c2afb862f9 Linux 6.5-rc1)
Merging gpio-brgl-fixes/gpio/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (18bddc5b6703 erofs: fix fsdax unavailability for=
 chunk-based regular files)
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (d7dbed457c2e nfsd: Fix creation time seriali=
zation order)
Merging irqchip-fixes/irq/irqchip-fixes (6fe5c68ee6a1 irqchip/gic-v3: Worka=
round for GIC-700 erratum 2941627)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (963293ff058c tools headers arm64: Sync arm=
64's cputype.h with the kernel sources)
Merging efi-fixes/urgent (36e4fc57fc16 efi: Bump stub image version for mac=
OS HVF compatibility)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (06c2afb862f9 Linux 6.5-rc1)
Merging rust-fixes/rust-fixes (ac9a78681b92 Linux 6.4-rc1)
Merging v9fs-fixes/fixes/next (95f41d878100 fs/9p: Fix a datatype used with=
 V9FS_DIRECT_IO)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (05abb3be91d8 dma-buf/dma-resv:=
 Stop leaking on krealloc() failure)
Merging mm-stable/mm-stable (06c2afb862f9 Linux 6.5-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (06c2afb862f9 Linux 6.5-rc1)
Merging mm/mm-everything (155d2239f23c Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (3685a5b63db1 kbuild: Enable -Wenum-conversion by d=
efault)
Merging clang-format/clang-format (06c2afb862f9 Linux 6.5-rc1)
Merging perf/perf-tools-next (bcd981db12e6 perf test: Fix event parsing tes=
t when PERF_PMU_CAP_EXTENDED_HW_TYPE isn't supported.)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (8ac04063354a swiotlb: reduce the number of ar=
eas to match actual memory pool size)
Merging asm-generic/master (4dd595c34c4b syscalls: Remove file path comment=
s from headers)
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (1faf70485ea9 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (893b24181b4c arm64: sme: Use STR P to clear FF=
R context field in streaming SVE mode)
Merging arm-perf/for-next/perf (dea0f4146f66 docs: perf: Fix warning from '=
make htmldocs' in hisi-pmu.rst)
Merging arm-soc/for-next (6722e46513e0 bus: ixp4xx: fix IXP4XX_EXP_T1_MASK)
Merging amlogic/for-next (76483eaf2109 Merge branch 'v6.6/arm64-dt' into fo=
r-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
Merging aspeed/for-next (a43f3e970a1d ARM: dts: aspeed: Add AST2600 VUARTs)
Merging at91/at91-next (47508c7ba8db Merge branches 'microchip-dt64' and 'a=
t91-dt' into at91-next)
Merging broadcom/next (0d8d8753ede0 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (3d7cfb8d6142 memory: tegra: make icc_set_b=
w return zero if BWMGR not supported)
Merging imx-mxs/for-next (89c016c82e46 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (54fbc0260c64 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (f581c395fcb8 Merge branches 'omap-for-v6.5/ti-sysc' =
and 'omap-for-v6.5/cleanup' into for-next)
Merging qcom/for-next (ffe79ac138e1 Merge branches 'arm64-defconfig-for-6.6=
', 'arm64-fixes-for-6.5', 'arm64-for-6.6', 'clk-for-6.6', 'drivers-for-6.6'=
 and 'dts-for-6.6' into for-next)
Merging renesas/next (3b5ba33b4d1d Merge branch 'renesas-dts-for-v6.6' into=
 renesas-next)
Merging reset/reset/next (afb39e2bd36a reset: mpfs: select AUXILIARY_BUS)
Merging rockchip/for-next (256b22ad54be Merge branch 'v6.6-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (f822ca919181 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (16f6bdd81f19 Merge branches 'for-next/juno/fix=
es', 'for-next/juno/updates' and 'for-next/vexpress/updates' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next)
Merging stm32/stm32-next (2f38de940f07 ARM: dts: stm32: Add missing detach =
mailbox for DHCOR SoM)
Merging sunxi/sunxi/for-next (1bcb932283c9 Merge branch 'sunxi/dt-for-6.5' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (e6a235bdf712 Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (18a70fe4eff4 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (6008eee2c754 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (f679e89acdd3 clk: tegra: Avoid calling an uninitializ=
ed function)
Merging clk-imx/for-next (878b02d5f3b5 clk: imx: clk-imx8mp: improve error =
handling in imx8mp_clocks_probe())
Merging clk-renesas/renesas-clk (bbceb13ce2c7 clk: renesas: rzg2l: Simplify=
 .determine_rate())
Merging csky/linux-next (6ee1ffdc1838 csky: pgtable: Fixup update_mmu_cache=
 for abiv2)
Merging loongarch/loongarch-next (06351cc358ea LoongArch: Fix module reloca=
tion error with binutils 2.41)
Merging m68k/for-next (4055eabe04a2 m68k: defconfig: Update defconfigs for =
v6.4-rc1)
Merging m68knommu/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (06c2afb862f9 Linux 6.5-rc1)
Merging openrisc/for-next (dceaafd66881 openrisc: Union fpcsr and oldmask i=
n sigcontext to unbreak userspace ABI)
Merging parisc-hd/for-next (6995e2de6891 Linux 6.4)
Merging powerpc/next (06c2afb862f9 Linux 6.5-rc1)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (471aba2e4760 riscv: sigcontext: Correct the commen=
t of sigreturn)
Merging riscv-dt/riscv-dt-for-next (ef6012f301f7 riscv: dts: Enable device-=
tree overlay support for starfive devices)
Merging riscv-soc/riscv-soc-for-next (1fcaaa1d489c riscv: Kconfig: Add sele=
ct ARM_AMBA to SOC_STARFIVE)
Merging s390/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging uml/next (6032aca0deb9 um: make stub data pages size tweakable)
Merging xtensa/xtensa-for-next (a160e9414d8a xtensa: fix unaligned and load=
/store configuration interaction)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (324718ddddc4 fscrypt: improve the "Encryption mod=
es and usage" section)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (cc87d1d73c34 Merge branch 'for-next-next-v6.5-20230=
713' into for-next-20230713)
Merging ceph/master (a282a2f10539 libceph: harden msgr2.1 frame segment len=
gth checks)
Merging cifs/for-next (7b06b57ba3ca smb: add missing create options for O_D=
IRECT and O_SYNC flags)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (06c2afb862f9 Linux 6.5-rc1)
Merging exfat/dev (ff84772fd45d exfat: release s_lock before calling dir_em=
it())
Merging ext3/for_next (eccf9ae28312 Pull patch forbiding superblock / mount=
 marks on internal kernel mounts.)
Merging ext4/dev (7c79210b15ef ext4: fix off by one issue in ext4_mb_choose=
_next_group_best_avail())
Merging f2fs/dev (06c2afb862f9 Linux 6.5-rc1)
Merging fsverity/for-next (456ae5fe9b44 fsverity: move sysctl registration =
out of signature.c)
Merging fuse/for-next (6a567e920fd0 fuse: ioctl: translate ENOSYS in outarg)
Merging gfs2/for-next (94c76955e86a Merge tag 'gfs2-v6.4-rc5-fixes' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging jfs/jfs-next (95e2b352c03b FS: JFS: Check for read-only mounted fil=
esystem in txBegin)
Merging ksmbd/ksmbd-for-next (956cd69868ee ksmbd: check if a mount point is=
 crossed during path lookup)
Merging nfs/linux-next (5b4a82a0724a Revert "NFSv4: Retry LOCK on OLD_STATE=
ID during delegation return")
Merging nfs-anna/linux-next (43439d858bba NFSv4.2: Fix a potential double f=
ree with READ_PLUS)
Merging nfsd/nfsd-next (5951fa2ed11b SUNRPC: Use a per-transport receive bi=
o_vec array)
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (0a3bf81dbcb2 ovl: auto generate uuid for =
new overlay filesystems)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging xfs/for-next (ed04a91f718e xfs: fix uninit warning in xfs_growfs_da=
ta)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (447a0bc108e4 iomap: drop me [hch] from MAINTA=
INERS for iomap)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (0d6aeec73f8c selftests: add OFD lock tests)
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs-brauner/vfs.all (c62e19541f8b Merge branches 'vfs.readdir', 'vf=
s.misc', 'vfs.ctime', 'vfs.fchmodat2' and 'fs.proc.uapi' into vfs.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (16dc0cdc1b71 Merge branch 'for-6.6' into for-next)
Merging pci/next (ffb9381f49da Merge branch 'pci/misc')
Merging pstore/for-next/pstore (efe5be6664c8 pstore: Replace crypto API com=
pression with zlib_deflate library calls)
Merging hid/for-next (5eb5c80feb93 Merge branch 'for-6.5/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (6537ed3904a3 i2c: mpc: Drop unused variable)
Merging i3c/i3c/next (49b472ebc61d i3c: master: svc: add NACK check after s=
tart byte sent)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (96e4fb748d75 hwmon: (nct6775) Change labe=
ls for nct6799)
Merging jc_docs/docs-next (67b3f564cb1e time: add kernel-doc in time.c)
Merging v4l-dvb/master (06c2afb862f9 Linux 6.5-rc1)
Merging v4l-dvb-next/master (d7b13edd4cb4 media: v4l2-core: Fix a potential=
 resource leak in v4l2_fwnode_parse_link())
Merging pm/linux-next (a648a2d354da Merge branch 'thermal-intel' into linux=
-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (9d4807ffe9ef cpufreq: omap: Con=
vert to platform remove callback returning void)
Merging cpupower/cpupower (d7de5d8e403a cpupower: Bump soname version)
Merging devfreq/devfreq-next (a83bfdca8b20 PM / devfreq: mtk-cci: Fix varia=
ble deferencing before NULL check)
Merging opp/opp/linux-next (06c2afb862f9 Linux 6.5-rc1)
Merging thermal/thermal/linux-next (57c9eaa4de53 thermal/drivers/qcom/temp-=
alarm: Use dev_err_probe)
Merging dlm/next (fc4ea4229c2b fs: dlm: remove filter local comms on close)
Merging rdma/for-next (f877f22ac1e9 RDMA/irdma: Implement egress VLAN prior=
ity)
Merging net-next/main (68af900072c1 gve: trivial spell fix Recive to Receiv=
e)
Merging bpf-next/for-next (def3833fc602 Merge branch 'net-stmmac-replace-bo=
olean-fields-in-plat_stmmacenet_data-with-flags')
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/main (b8e39b38487e netlink: Make use of __assign_bit=
() API)
Merging ipvs-next/main (61dc651cdfe8 Merge tag 'nf-next-23-06-26' of git://=
git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next)
Merging bluetooth/master (2ba6216b8b37 Bluetooth: btmtk: Fix kernel crash w=
hen processing coredump)
Applying: Revert "Bluetooth: hci_sock: Forward credentials to monitor"
Merging wireless-next/for-next (31b5a547622b wifi: ieee80211: fix erroneous=
 NSTR bitmap size checks)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (de2a5d52f2c0 dt-bindings: mtd: Add SEAMA partition bi=
ndings)
Merging nand/nand/next (c3519aed2a3f dt-bindings: nand: meson: support for =
512B ECC step size)
Merging spi-nor/spi-nor/next (4b0cb4e7ab2f dt-bindings: mtd: spi-nor: clari=
fy the need for spi-nor compatibles)
Merging crypto/master (635e4674e184 crypto: hisilicon/hpre - ensure private=
 key less than n)
Merging drm/drm-next (6725f3322807 Merge tag 'drm-misc-next-fixes-2023-07-0=
6' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (c2268daa65fb drm/panel: ld9040: Register a=
 backlight device)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
Merging amdgpu/drm-next (093b21f43173 Revert "drm/amdgpu: update kernel vcn=
 ring test")
Merging drm-intel/for-linux-next (290d16104575 Revert "drm/i915: use locali=
zed __diag_ignore_all() instead of per file")
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay_power_well.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/selftests/mock_g=
em_device.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (cd036d542afb drm/msm/a6xx: Add A610 speedbin supp=
ort)
Merging drm-msm-lumag/msm-next-lumag (1275b21a6c54 drm/msm/dsi: Enable BURS=
T_MODE for command mode for DSI 6G v1.3+)
Merging etnaviv/etnaviv/next (295b6c02f84b drm/etnaviv: slow down FE idle p=
olling)
Merging fbdev/for-next (53a90ae81a33 fbdev: imxfb: remove unneeded labels)
Merging regmap/for-next (c9a823624863 Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-next)
Merging sound/for-next (7e9f28398a6e ALSA: Explicitly include correct DT in=
cludes)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (d70a6ca2ec1b Merge remote-tracking branch 'aso=
c/for-6.6' into asoc-next)
Merging modules/modules-next (9ce170cef669 kernel: params: Remove unnecessa=
ry =E2=80=980=E2=80=99 values from err)
Merging input/next (677232f879f2 Input: iqs7211 - point to match data direc=
tly)
Merging block/for-next (ccb3e3adc0af Merge branch 'for-6.6/block' into for-=
next)
Merging device-mapper/for-next (7aa303bf1bd2 dm raid: protect md_stop() wit=
h 'reconfig_mutex')
Merging libata/for-next (fd3ac6e80497 dt-bindings: phy: rockchip: rk3588 ha=
s two reset lines)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (e8e2c7b0e695 mmc: davinci: Make SDIO irq truly optional)
Merging mfd/for-mfd-next (b90e33b6116a mfd: wm8998: Update to use maple tre=
e register cache)
Merging backlight/for-backlight-next (a33677b9211b backlight: led_bl: Take =
led_access lock when required)
Merging battery/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging regulator/for-next (702c86f21c14 Merge remote-tracking branch 'regu=
lator/for-6.6' into regulator-next)
Merging security/next (c31288e56c1a evm: Support multiple LSMs providing an=
 xattr)
Merging apparmor/apparmor-next (afad53575a93 apparmor: use passed in gfp fl=
ags in aa_alloc_null())
Merging integrity/next-integrity (95526d13038c ima: Fix build warnings)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (5b0eea835d4e selinux: introduce an initial SID for ea=
rly boot processes)
Merging smack/next (2c085f3a8f23 smack: Record transmuting in smk_transmute=
d)
Merging tomoyo/master (1c7873e33645 mm: lock newly mapped VMA with correcte=
d ordering)
Merging tpmdd/next (0ec1b5bea32b tpm,tpm_tis: Disable interrupts after 1000=
 unhandled IRQs)
Merging watchdog/master (2500df55a615 dt-bindings: watchdog: Add Loongson-1=
 watchdog)
Merging iommu/next (a5003e75a171 Merge branches 'iommu/fixes', 'arm/rockchi=
p', 'x86/amd' and 'core' into next)
Merging audit/next (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree/for-next (31e9f406efae dt-bindings: soc: qcom: stats: Up=
date maintainer email)
Merging dt-krzk/for-next (9d5d7ad3d517 Merge branch 'next/dt-bindings' into=
 for-next)
Merging mailbox/mailbox-for-next (1b712f18c461 mailbox: ti-msgmgr: Fill non=
-message tx data fields with 0x0)
Merging spi/for-next (abe075e6c87f Merge remote-tracking branch 'spi/for-6.=
6' into spi-next)
Merging tip/master (1399419a8db7 Merge branch into tip/master: 'sched/core')
Merging clockevents/timers/drivers/next (8b5bf64c89c7 clocksource/drivers/c=
adence-ttc: Fix memory leak in ttc_timer_probe)
Merging edac/edac-for-next (852667c317ae Merge ras/edac-drivers into for-ne=
xt)
Merging irqchip/irq/irqchip-next (a82f3119d543 Merge branch irq/misc-6.5 in=
to irq/irqchip-next)
Merging ftrace/for-next (61c692f56fec Merge tools/for-next)
Merging rcu/rcu/next (ddf5d3eda2df Merge branch 'csd-lock.2023.07.14b' into=
 HEAD)
Merging kvm/next (255006adb3da Merge tag 'kvm-x86-vmx-6.5' of https://githu=
b.com/kvm-x86/linux into HEAD)
Merging kvm-arm/next (192df2aa0113 KVM: arm64: Fix misuse of KVM_ARM_VCPU_P=
OWER_OFF bit index)
Merging kvms390/next (db54dfc9f71c s390/uv: Update query for secret-UVCs)
Merging kvm-riscv/riscv_kvm_next (07f225b58424 RISC-V: KVM: Remove unneeded=
 semicolon)
Merging kvm-x86/next (88bb466c9dec Merge branches 'generic', 'misc', 'mmu',=
 'selftests', 'svm', 'vmx' and 'pmu')
Merging xen-tip/linux-next (21a235bce123 xen/virtio: Fix NULL deref when a =
bridge of PCI root bus has no parent)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (6dc917b44525 Merge branch 'for-6.5-fixes' into=
 for-next)
Merging drivers-x86/for-next (9204fc5071bf platform/x86: hp-bioscfg: MAINTA=
INERS)
Merging chrome-platform/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging hsi/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (7a2b85a76b05 leds: simatic-ipc-leds-gpio: Fi=
x comment style in SPDX header)
Merging ipmi/for-next (b02bb79eee07 ipmi: fix potential deadlock on &kcs_bm=
c->lock)
Merging driver-core/driver-core-next (06c2afb862f9 Linux 6.5-rc1)
Merging usb/usb-next (06c2afb862f9 Linux 6.5-rc1)
Merging thunderbolt/next (481012b479fe thunderbolt: Add test case for 3 Dis=
playPort tunnels)
Merging usb-serial/usb-next (06c2afb862f9 Linux 6.5-rc1)
Merging tty/tty-next (06c2afb862f9 Linux 6.5-rc1)
Merging char-misc/char-misc-next (06c2afb862f9 Linux 6.5-rc1)
Merging accel/habanalabs-next (e6f49e96bc57 accel/habanalabs: refactor erro=
r info reset)
Merging coresight/next (6c50384ef8b9 hwtracing: hisi_ptt: Fix potential sle=
ep in atomic context)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (7617b957c6dd fpga: Explicitly include correct DT inc=
ludes)
Merging icc/icc-next (f381b13bb770 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (d9b431026523 dt-bindings: iio: adc: qcom,spmi-adc7: use=
 predefined channel ids)
Merging phy-next/next (76009ee76e05 phy: zynqmp: Allow variation in refclk =
rate)
Merging soundwire/next (06c2afb862f9 Linux 6.5-rc1)
Merging extcon/extcon-next (94da3da96c35 dt-bindings: extcon: wlf,arizona: =
drop unneeded quotes)
Merging gnss/gnss-next (06c2afb862f9 Linux 6.5-rc1)
Merging vfio/next (ff598081e5b9 vfio/mdev: Move the compat_class initializa=
tion to module init)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (06c2afb862f9 Linux 6.5-rc1)
Merging counter-next/counter-next (9b53a1342216 counter: Fix menuconfig "Co=
unter support" submenu entries disappearance)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (1b13e52c0c76 dmaengine: xilinx: dma: remove arch de=
pendency)
Merging cgroup/for-next (ceddae22cd08 cgroup: remove obsolete comment above=
 struct cgroupstats)
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/.gitig=
nore
CONFLICT (content): Merge conflict in tools/testing/selftests/cgroup/Makefi=
le
Applying: Revert "cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHE=
D"
Merging scsi/for-next (f4d1a8e01190 scsi: storvsc: Handle SRB status value =
0x30)
Merging scsi-mkp/for-next (e152a616c886 scsi: ufs: ufs-mediatek: Add MCQ su=
pport for MTK platform)
Merging vhost/linux-next (373abdba01d4 vdpa_sim: offer VHOST_BACKEND_F_ENAB=
LE_AFTER_DRIVER_OK)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (2f9b31c95d55 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (0f93a345aa42 gpiolib: order includes alpha=
betically in gpiolib.h)
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (04e601f2a71c Merge tag 'renesas-pinctrl-fixes-for=
-v6.5-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-=
drivers into fixes)
Merging pinctrl-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-renesas/renesas-pinctrl (bf8da305fef9 pinctrl: renesas: rzv=
2m: Use devm_clk_get_enabled())
Merging pinctrl-samsung/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pwm/for-next (92554cdd428f dt-bindings: pwm: convert pwm-bcm2835 bi=
ndings to YAML)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (feac01aaf677 selftests: prctl: Add new prctl test f=
or PR_SET_NAME)
Merging kunit/test (06c2afb862f9 Linux 6.5-rc1)
Merging kunit-next/kunit (06c2afb862f9 Linux 6.5-rc1)
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (1b733a9ebc3d rtc: Add rtc driver for the Loongson fam=
ily chips)
Merging nvdimm/libnvdimm-for-next (1ea7ca1b0901 dax: enable dax fault handl=
er to report VM_FAULT_HWPOISON)
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (994def29acc5 ntb: Remove error checking for debugfs_c=
reate_dir())
Merging seccomp/for-next/seccomp (f373d301908a perf/benchmark: add a new be=
nchmark for seccom_unotify)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (3a7e4daf7aea dt-bindings: nvmem: qfprom: Add compat=
ible for MSM8226)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (a494aef23dfc PCI: hv: Replace retarget_msi_inte=
rrupt_params with hyperv_pcpu_input_arg)
Merging auxdisplay/auxdisplay (def85dce1451 auxdisplay: Switch i2c drivers =
back to use .probe())
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (06c2afb862f9 Linux 6.5-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (d0184830e611 bus: mhi: host: use vmalloc_array and vc=
alloc)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (2e28a798c309 efi/libstub: Disable PCI DMA before grabbing=
 the EFI memory map)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (2ad1099bb36d Merge branch 'slab/for-6.6/random_kmall=
oc' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (35ca42399297 selftests/landlock: Add hostfs tests)
Merging rust/rust-next (d2e3115d7171 rust: error: `impl Debug` for `Error` =
with `errname()` integration)
Merging sysctl/sysctl-next (06c2afb862f9 Linux 6.5-rc1)
Merging execve/for-next/execve (aa88054b7090 binfmt_elf: fix comment typo s=
/reset/regset/)
Merging bitmap/bitmap-for-next (7e281084b62c lib: test for_each_numa_cpus())
Merging hte/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging kspp/for-next/kspp (ec7633de404e sparc: mark __arch_xchg() as __alw=
ays_inline)
Merging kspp-gustavo/for-next/kspp (221a4b56ec70 sparc: openpromio: Address=
 -Warray-bounds warning)
Merging iommufd/for-next (06c2afb862f9 Linux 6.5-rc1)

--Sig_/ZS6C+qU8pxZ8QTON2_S1OGs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0uZQACgkQAVBC80lX
0GxpjwgAgyjIIqX15U/wxiyjrbptXfY9VB/k/IlqDIJDukDjMzPkyUISrFkcgrWj
cIwroOnwSki7CijF6FvIzQWKcwu7AIhc5LwwxPUWLA2FUfZET1FJK3pTfLBAuSE8
ZpoYcvOgAxuuixQ4oSOgNg4TKj9ZTu7fjLgaxHbfo8YbkZKi4Yuuu4zMwD67Ut7a
MeFmWu11iwDNllC8moySv+VRa0KYGKfbQQck4e3EGrkpWbDT5ysErvh9yTfgVtOd
GTmr/3Mm4DZ9+qUWHC+OMPYrkiOEs2tikAeLbna4vetyas7RNelODnLF5IGeqxO6
ihm4ARzg7fexzG6jAXiAsBup+ac7cg==
=vQRU
-----END PGP SIGNATURE-----

--Sig_/ZS6C+qU8pxZ8QTON2_S1OGs--
