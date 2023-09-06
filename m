Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B37933BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbjIFCYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjIFCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:24:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0519E1A8;
        Tue,  5 Sep 2023 19:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693967059;
        bh=wIyNf2wFLG7oHxGkVrkQo8UmxNT7pheY7Py2ylLrSkk=;
        h=Date:From:To:Cc:Subject:From;
        b=Dptp2NsklXLCl3caRRELTn3GrOBpev1XoufaKZSVAahUBV4ltPtGg72PTEuQqxmxJ
         BTMANP34E8IISseMaPmmlXfRJu37tosmIkSrnlvIyyMGn+nwyZszsrArItPF42AyYJ
         nBCwAJ/8drsnvuHtALM5kOCwYshxkw8MWQsLlpcllcSmHft0bY7yTQDs2tbT82t5NC
         EdZYZ6w7oH//13B3HNXA7Ol+dWpRv/Gw44IstvF21x4Nfwb26/qQCn0mtPfVa5UVQz
         jVj/IeLL0yYE/Xnux2PBXgMLdvY9NQ++EOzIHahjkMaY5HvAzLTvINHN/O84CrFglv
         dBmDlDsoQeePA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RgR5b1JyDz4wy1;
        Wed,  6 Sep 2023 12:24:19 +1000 (AEST)
Date:   Wed, 6 Sep 2023 12:24:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 6
Message-ID: <20230906122417.61e8f203@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T.QFEcSlPCSj/OzY/ys3kjk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T.QFEcSlPCSj/OzY/ys3kjk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do *not* include material destined for v6.7 in your linux-next
included branches until *after* v6.6-rc1 has been released.  Also,
do *not* rebase you linu-next included branches onto v6.5.

Changes since 20230905:

The mailbox tree lost its build failure.

The scsi-mkp tree gained a conflict against the mm tree.

Non-merge commits (relative to Linus' tree): 1590
 1815 files changed, 285045 insertions(+), 25715 deletions(-)

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

I am currently merging 365 trees (counting Linus' and 104 trees of bug
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
Merging origin/master (65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (9268f370c2cc mm-shmem-fix-race-in=
-shmem_undo_range-w-thp-fix)
Merging kbuild-current/fixes (6ccbd7fd4746 alpha: remove __init annotation =
from exported page_is_ram())
Merging arc-current/for-curr (c40cad3b0aa4 ARC: boot log: fix warning)
Merging arm-current/fixes (6995e2de6891 Linux 6.4)
Merging arm64-fixes/for-next/fixes (7625df9f4b25 perf: CXL: fix mismatched =
number of counters mask)
Merging arm-soc-fixes/arm/fixes (3c78dbf25135 Merge tag 'qcom-arm64-fixes-f=
or-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into =
arm/fixes)
Merging davinci-current/davinci/for-current (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory-fixes/fixes (faafd6ca7e6e memory: tegra: make icc_se=
t_bw return zero if BWMGR not supported)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (eb1e6ccdcf78 zorro: Include zorro.h in name=
s.c)
Merging powerpc-fixes/fixes (4f3175979e62 powerpc/rtas_flash: allow user co=
py to flash block cache objects)
Merging s390-fixes/fixes (e5b7ca09e9aa Merge tag 's390-6.6-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/s390/linux)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (29fe7a1b6271 octeontx2-af: Fix truncation of smq in CN10K=
 NIX AQ enqueue mbox handler)
Merging bpf/master (a454d84ee20b bpf, sockmap: Fix skb refcnt race after lo=
cking changes)
Merging ipsec/master (d3287e4038ca Revert "net: macsec: preserve ingress fr=
ame ordering")
Merging netfilter/main (29fe7a1b6271 octeontx2-af: Fix truncation of smq in=
 CN10K NIX AQ enqueue mbox handler)
Merging ipvs/main (931abcdcad10 Merge branch 'mlxsw-fixes')
Merging wireless/for-next (d5a93b7d2877 wifi: mwifiex: Sanity check tlv_len=
 and tlv_bitmap_len)
Merging wpan/master (9a43827e876c net: dpaa2-mac: add 25gbase-r support)
Merging rdma-fixes/for-rc (2ccdd1b13c59 Linux 6.5-rc6)
Merging sound-current/for-linus (86496fd4a2fa ALSA: seq: Fix snd_seq_expand=
_var_event() call to user-space)
Merging sound-asoc-fixes/for-linus (d9a1beeb9043 Merge remote-tracking bran=
ch 'asoc/for-6.5' into asoc-linus)
Merging regmap-fixes/for-linus (52a93d39b17d Linux 6.5-rc5)
Merging regulator-fixes/for-linus (41f02a383ac6 Merge remote-tracking branc=
h 'regulator/for-6.5' into regulator-linus)
Merging spi-fixes/for-linus (578464679f33 spi: sun6i: fix RX data corruptio=
n in DMA mode)
Merging pci-current/for-linus (26641b3f22ab PCI: Fix CONFIG_PCI_DYNAMIC_OF_=
NODES kconfig dependencies)
Merging driver-core.current/driver-core-linus (3f86ed6ec0b3 Merge tag 'arc-=
6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging tty.current/tty-linus (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging usb.current/usb-linus (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging usb-serial-fixes/usb-linus (706a74159504 Linux 6.5-rc7)
Merging phy/fixes (52a93d39b17d Linux 6.5-rc5)
Merging staging.current/staging-linus (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging iio-fixes/fixes-togreg (523268c1a8ac iio: cros_ec: fix an use-after=
-free in cros_ec_sensors_push_data())
Merging counter-current/counter-current (df8fdd01c98b counter: microchip-tc=
b-capture: Fix the use of internal GCLK logic)
Merging char-misc.current/char-misc-linus (3f86ed6ec0b3 Merge tag 'arc-6.6-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging soundwire-fixes/fixes (52a93d39b17d Linux 6.5-rc5)
Merging thunderbolt-fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging input-current/for-linus (1ac731c529cd Merge branch 'next' into for-=
linus)
Merging crypto-current/master (ba22e81872c1 crypto: powerpc/chacha20,poly13=
05-p10 - Add dependency on VSX)
Merging vfio-fixes/for-linus (4752354af710 vfio/type1: check pfn valid befo=
re converting to struct page)
Merging kselftest-fixes/fixes (569f8b501b17 selftests/arm64: fix build fail=
ure during the "emit_tests" step)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (2ccdd1b13c59 Linux 6.5-rc6)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (c6abce60338a mtd: rawnand: fsl_upm: Fix an off=
-by one test in fun_exec_op())
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (e7f2e65699e2 media: vcodec: Fix potential arra=
y out-of-bounds in encoder queue_setup)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (6eaae1980760 Linux 6.5-rc3)
Merging at91-fixes/at91-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (d5ad9aae13dc selftests/rseq: Fix build with undef=
ined __weak)
Merging kvms390-fixes/master (c2fceb59bbda KVM: s390: pv: fix index value o=
f replaced ASCE)
Merging hwmon-fixes/hwmon (9c53fb0ad1ac hwmon: (asus-ec-sensosrs) fix mutex=
 path for X670E Hero)
Merging nvdimm-fixes/libnvdimm-fixes (e98d14fa7315 tools/testing/nvdimm: Dr=
op empty platform remove function)
Merging cxl-fixes/fixes (ad64f5952ce3 cxl/memdev: Only show sanitize sysfs =
files when supported)
Merging btrfs-fixes/next-fixes (84e31c126aee Merge branch 'misc-6.5' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (0848cab765c6 platform/mellanox: Fix mlxbf-=
tmfifo not handling all virtio CONSOLE notifications)
Merging samsung-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-samsung-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging devicetree-fixes/dt/linus (591b00cc4fcf dt-bindings: irqchip: conve=
rt st,stih407-irq-syscfg to DT schema)
Merging dt-krzk-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging scsi-fixes/fixes (812fe6420a6e scsi: storvsc: Handle additional SRB=
 status values)
Merging drm-fixes/drm-fixes (2dde18cd1d8f Linux 6.5)
Merging drm-intel-fixes/for-linux-next-fixes (2dde18cd1d8f Linux 6.5)
Merging mmc-fixes/fixes (58abdd80b93b mmc: f-sdh30: fix order of function c=
alls in sdhci_f_sdh30_remove)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (fdf0eaf11452 Linux 6.5-rc2)
Merging hyperv-fixes/hyperv-fixes (6ad0f2f91ad1 Drivers: hv: vmbus: Remove =
unused extern declaration vmbus_ontimer())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-mw1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging riscv-dt-fixes/riscv-dt-fixes (602afaaa6ef9 riscv: dts: starfive: f=
ix NOR flash reserved-data partition size)
Merging riscv-soc-fixes/riscv-soc-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging fpga-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging spdx/spdx-linus (7a1415eebeec Merge tag 'm68knommu-for-v6.6' of git=
://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu)
Merging gpio-brgl-fixes/gpio/for-current (6e39c1ac6881 gpio: sim: pass the =
GPIO device's software node to irq domain)
Merging gpio-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl-intel-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging erofs-fixes/fixes (4da3c7183e18 erofs: drop unnecessary WARN_ON() i=
n erofs_kill_sb())
Merging kunit-fixes/kunit-fixes (06c2afb862f9 Linux 6.5-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (9e46e4dcd9d6 mm,memblock: reset memblock.rese=
rved to system init state to prevent UAF)
Merging nfsd-fixes/nfsd-fixes (8073a98e9532 NFSD: Fix a thinko introduced b=
y recent trace point changes)
Merging irqchip-fixes/irq/irqchip-fixes (6fe5c68ee6a1 irqchip/gic-v3: Worka=
round for GIC-700 erratum 2941627)
Merging renesas-fixes/fixes (4c188fa183eb arm64: dts: renesas: rzg2l: Updat=
e overfow/underflow IRQ names for MTU3 channels)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf-tools (45fc4628c15a perf parse-events: Fix driver=
 config term)
Merging efi-fixes/urgent (8b94da92559f x86/efistub: Fix PCI ROM preservatio=
n in mixed mode)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (205f4cf3136f power: supply: ab8500: Set typing=
 and props)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (b7c822fa6b77 iommufd: Set end correctly when =
doing batch carry)
Merging rust-fixes/rust-fixes (3fa7187eceee rust: macros: vtable: fix `HAS_=
*` redefinition (`gen_const_name`))
Merging v9fs-fixes/fixes/next (2dde18cd1d8f Linux 6.5)
Merging w1-fixes/fixes (06c2afb862f9 Linux 6.5-rc1)
Merging genpd-fixes/fixes (12acb348fa45 cpuidle: psci: Move enabling OSI mo=
de after power domains creation)
Merging drm-misc-fixes/for-linux-next-fixes (7583028d359d drm: gm12u320: Fi=
x the timeout usage for usb_bulk_msg())
Merging mm-stable/mm-stable (2374b401b0e0 Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (3f86ed6ec0b3 Merge tag 'arc-6.6-rc=
1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging mm/mm-everything (839cadadb256 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (a3b7039bb2b2 kconfig: fix possible buffer overflow)
Merging clang-format/clang-format (5d0c230f1de8 Linux 6.5-rc4)
Merging perf/perf-tools-next (45fc4628c15a perf parse-events: Fix driver co=
nfig term)
Merging compiler-attributes/compiler-attributes (5d0c230f1de8 Linux 6.5-rc4)
Merging dma-mapping/for-next (765aa6b3a462 dma-pool: remove a __maybe_unuse=
d label in atomic_pool_expand)
Merging asm-generic/master (6e8d96909a23 asm-generic: partially revert "Uni=
fy uapi bitsperlong.h for arm64, riscv and loongarch")
Merging arc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging arm/for-next (133789d4a458 Revert part of ae1f8d793a19 ("ARM: 9304/=
1: add prototype for function called only from asm"))
Merging arm64/for-next/core (e1df27213941 Merge branch 'for-next/selftests'=
 into for-next/core)
Merging arm-perf/for-next/perf (21b61fe48c2f drivers/perf: hisi: Update HiS=
ilicon PMU maintainers)
Merging arm-soc/for-next (42ed07054d75 soc: document merges)
Merging amlogic/for-next (413f5c02929b Merge branch 'v6.6/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (eaf935fa48ec soc: apple: mailbox: Ren=
ame config symbol to APPLE_MAILBOX)
CONFLICT (content): Merge conflict in drivers/soc/apple/Makefile
Merging aspeed/for-next (05f42491c813 ARM: dts: aspeed: bonnell: Add reserv=
ed memory for TPM event log)
Merging at91/at91-next (b04dba7c1c30 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (a70e8c9ff89a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging drivers-memory/for-next (35bd78cf2522 memory: tegra: add MC client =
for Tegra234 GPU)
Merging imx-mxs/for-next (246e2cc22265 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (f6925844c82a Merge branch 'v6.4-next/soc' into f=
or-next)
Merging mvebu/for-next (a8e364c2c428 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (6387fcbea64f Merge branch 'omap-for-v6.6/ti-sysc' in=
to for-next)
Merging qcom/for-next (9c573e27d40a Merge branches 'arm64-defconfig-for-6.6=
', 'arm64-fixes-for-6.5', 'arm64-for-6.6', 'clk-for-6.6', 'drivers-for-6.6'=
 and 'dts-for-6.6' into for-next)
Merging renesas/next (13512fa6af4a Merge branch 'renesas-dts-for-v6.6' into=
 renesas-next)
Merging reset/reset/next (417a3a5ae44a reset: ti: syscon: remove unneeded c=
all to platform_set_drvdata())
Merging rockchip/for-next (6d1fa8808888 Merge branch 'v6.5-armsoc/dtsfixes'=
 into for-next)
Merging samsung-krzk/for-next (7a736a6b2c9b Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (84f64289860a Merge branch 'pcc_type4' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-=
next)
Merging stm32/stm32-next (da50d4f56078 ARM: dts: stm32: Add Octavo OSD32MP1=
-RED board)
Merging sunxi/sunxi/for-next (aa333f5e8461 Merge branch 'sunxi/dt-for-6.6' =
into sunxi/for-next)
Merging tee/next (6a8b7e801054 tee: optee: Use kmemdup() to replace kmalloc=
 + memcpy)
Merging tegra/for-next (c62440bd774b Merge branch for-6.6/arm64/dt into for=
-next)
Merging ti/ti-next (d0857dc9b22d Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (7cd073eddcd4 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (41680df0975e Merge branch 'clk-qcom' into clk-next)
Merging clk-imx/for-next (72d00e560d10 clk: imx: pll14xx: dynamically confi=
gure PLL for 393216000/361267200Hz)
Merging clk-renesas/renesas-clk (708cb698ffa2 clk: renesas: rcar-gen3: Add =
ADG clocks)
Merging csky/linux-next (5195c35ac4f0 csky: Fixup compile error)
Merging loongarch/loongarch-next (68800bf8cd1a LoongArch: Update Loongson-3=
 default config file)
Merging m68k/for-next (eb1e6ccdcf78 zorro: Include zorro.h in names.c)
Merging m68knommu/for-next (cf18ecd34f71 m68k: coldfire: dma_timer: ERROR: =
"foo __init bar" should be "foo __init bar")
Merging microblaze/next (0d2b49479bf9 microblaze: Make virt_to_pfn() a stat=
ic inline)
Merging mips/mips-next (e7513eccb7d7 MIPS: TXx9: Do PCI error checks on own=
 line)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (1d6dd37668f8 parisc: shmparam.h: Document alias=
ing requirements of PA-RISC)
Merging powerpc/next (85a616416e9e macintosh/ams: linux/platform_device.h i=
s needed)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (44c28940e24b Merge patch "RISC-V: Add ptrace suppo=
rt for vectors")
CONFLICT (add/add): Merge conflict in Documentation/bpf/linux-notes.rst
Merging riscv-dt/riscv-dt-for-next (a3ce3ff28385 riscv: dts: change TH1520 =
files to dual license)
Merging riscv-soc/riscv-soc-for-next (30fb4784483b soc: starfive: Add JH711=
0 AON PMU support)
Merging s390/for-next (06fc3b0d2251 s390/vmem: do not silently ignore mappi=
ng limit)
Merging sh/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging uml/next (974b808d85ab um: virt-pci: fix missing declaration warnin=
g)
Merging xtensa/xtensa-for-next (03ce34cf8f50 xtensa: add XIP-aware MTD supp=
ort)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (324718ddddc4 fscrypt: improve the "Encryption mod=
es and usage" section)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (330c15bebcb4 Merge branch 'for-next-next-v6.5-20230=
824' into for-next-20230824)
Merging ceph/master (ce0d5bd3a6c1 ceph: make num_fwd and num_retry to __u32)
Merging cifs/for-next (aa1488188a62 cifs: update internal module version nu=
mber for cifs.ko)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (91b1ad0815fb erofs: release ztailpacking pclusters prope=
rly)
Merging exfat/dev (b3a62a988600 exfat: support create zero-size directory)
Merging ext3/for_next (d3cc1b0be258 quota: explicitly forbid quota files fr=
om being encrypted)
Merging ext4/dev (768d612f7982 ext4: fix slab-use-after-free in ext4_es_ins=
ert_extent())
Merging f2fs/dev (708283abf896 Merge tag 'dmaengine-6.6-rc1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (f73016b63b09 fuse: conditionally fill kstat in fuse_=
do_statx())
Merging gfs2/for-next (0e072cac92d0 gfs2: change qd_slot_count to qd_slot_r=
ef)
Merging jfs/jfs-next (0225e10972fa jfs: validate max amount of blocks befor=
e allocation.)
Merging ksmbd/ksmbd-for-next (f5069159f32c ksmbd: remove experimental warni=
ng)
Merging nfs/linux-next (895cedc17919 xprtrdma: Remap Receive buffers after =
a reconnect)
Merging nfs-anna/linux-next (c4a123d2e8c4 pNFS: Fix assignment of xprtdata.=
cred)
Merging nfsd/nfsd-next (b38a6023da6a Documentation: Add missing documentati=
on for EXPORT_OP flags)
Merging ntfs3/master (44b4494d5c59 fs/ntfs3: Correct mode for label entry i=
nside /proc/fs/ntfs3/)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (724768a39374 ovl: fix incorrect fdput() o=
n aio completion)
Merging ubifs/next (b5fda08ef213 ubifs: Fix memleak when insert_old_idx() f=
ailed)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (2dde18cd1d8f Linux 6.5)
Merging xfs/for-next (c1950a111dd8 fs/xfs: Fix typos in comments)
Merging zonefs/for-next (8812387d0569 zonefs: set FMODE_CAN_ODIRECT instead=
 of a dummy direct_IO method)
Merging iomap/iomap-for-next (377698d4abe2 Merge tag 'xfs-async-dio.6-2023-=
08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA)
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (f505786d6915 Merge branch 'vfs.fs_context' int=
o vfs.all)
Merging vfs/for-next (cff4b23c731a Merge branch 'work.lock_rename_child' in=
to for-next)
Merging printk/for-next (cb65d08d735e Merge branch 'for-6.6' into for-next)
Merging pci/next (b6f6167ea8a4 Merge tag 'pci-v6.6-changes' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/pci/pci)
Merging pstore/for-next/pstore (94160062396d pstore: Base compression input=
 buffer size on estimated compressed size)
Merging hid/for-next (bd0ffb67f8d3 Merge branch 'for-6.6/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (6bd4bef7f554 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6e13d6528be2 i3c: master: svc: fix probe failure when=
 no i3c device exist)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (919a83d020a8 hwmon: (tmp513) Simplify pro=
be())
Merging jc_docs/docs-next (c63594f2d666 Docu: genericirq.rst: fix irq-examp=
le)
Merging v4l-dvb/master (9a5d660fdb25 media: ivsc: Add ACPI dependency)
Merging v4l-dvb-next/master (4c420b729238 media: ivsc: Depend on VIDEO_DEV)
Merging pm/linux-next (ea4f9c37f752 Merge tag 'pm-6.6-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging cpufreq-arm/cpufreq/arm/linux-next (16567117aa0c cpufreq: Add QCM64=
90 to cpufreq-dt-platdev blocklist)
Merging cpupower/cpupower (af75504c3896 cpupower: Add Georgian translation =
to Makefile LANGUAGES)
Merging devfreq/devfreq-next (5693d077595d PM / devfreq: Fix leak in devfre=
q_dev_release())
Merging genpd/next (5e536362f6ab genpd: ti: Use for_each_node_with_property=
() simplify code logic)
Merging opp/opp/linux-next (e576a9a8603f dt-bindings: cpufreq: Convert ti-c=
pufreq to json schema)
Merging thermal/thermal/linux-next (1ef5a9f61457 thermal/drivers/tegra-bpmp=
: Check if BPMP supports trip points)
Merging dlm/next (7c53e847ff5e dlm: fix plock lookup when using multiple lo=
ckspaces)
Merging rdma/for-next (f5acc36b0714 IB/hfi1: Reduce printing of errors duri=
ng driver shut down)
Merging net-next/main (bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf-next/for-next (bd6c11bc43c4 Merge tag 'net-next-6.6' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (a94fd40a18ae xfrm: delete not-needed clear to ze=
ro of encap_oa)
Merging mlx5-next/mlx5-next (58dbd6428a68 RDMA/mlx5: Handles RoCE MACsec st=
eering rules addition and deletion)
Merging netfilter-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-c=
ompile-time-configuration')
Merging ipvs-next/main (c2e5f4fd1148 Merge branch 'netconsole-enable-compil=
e-time-configuration')
Merging bluetooth/master (2595dd981e74 Bluetooth: ISO: Fix handling of list=
en for unicast)
Merging wireless-next/for-next (b32add2d20ea Merge branch '1GbE' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging wpan-next/master (18b849f12dcc ieee802154: ca8210: Remove stray gpi=
od_unexport() call)
Merging wpan-staging/staging (18b849f12dcc ieee802154: ca8210: Remove stray=
 gpiod_unexport() call)
Merging mtd/mtd/next (54a3f6e89fbb Merge tag 'nand/for-6.6' into mtd/next)
Merging nand/nand/next (b9283ac01a27 dt-bindings: mtd: amlogic,meson-nand: =
drop unneeded quotes)
Merging spi-nor/spi-nor/next (69d50d0461a1 mtd: spi-nor: nxp-spifi: Use hel=
per function devm_clk_get_enabled())
Merging crypto/master (85b9bf9a514d Revert "dt-bindings: crypto: qcom,prng:=
 Add SM8450")
Merging drm/drm-next (3698a75f5a98 Merge tag 'drm-intel-next-fixes-2023-08-=
24' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-misc/for-linux-next (45dc8fc07d01 fbdev/g364fb: fix build failu=
re with mips)
Merging amdgpu/drm-next (173df1eaa8a9 Revert "drm/amd/pm: disable the SMU13=
 OD feature support temporarily")
Merging drm-intel/for-linux-next (5eefc5307c98 drm/i915: mark requests for =
GuC virtual engines to avoid use-after-free)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (34b149ecae85 drm/msm/a6xx: Bail out early if sett=
ing GPU OOB fails)
Merging drm-msm-lumag/msm-next-lumag (d93cf453f51d drm/msm/dpu: fix the irq=
 index in dpu_encoder_phys_wb_wait_for_commit_done)
Merging etnaviv/etnaviv/next (88c31d2dd191 drm/etnaviv: fix error code in e=
vent_alloc())
Merging fbdev/for-next (2dde18cd1d8f Linux 6.5)
Merging regmap/for-next (26fc7cfa30d6 Merge remote-tracking branch 'regmap/=
for-6.6' into regmap-next)
Merging sound/for-next (86496fd4a2fa ALSA: seq: Fix snd_seq_expand_var_even=
t() call to user-space)
Merging ieee1394/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging sound-asoc/for-next (d9a1beeb9043 Merge remote-tracking branch 'aso=
c/for-6.5' into asoc-linus)
Merging modules/modules-next (33c24bee4b78 kallsyms: Add more debug output =
for selftest)
Merging input/next (54116d442e00 Input: rpckbd - fix the return value handl=
e for platform_get_irq())
Merging block/for-next (e7151bd1d070 Merge branch 'block-6.6' into for-next)
Merging device-mapper/for-next (1e4ab7b4c881 dm cache policy smq: ensure IO=
 doesn't prevent cleaner policy progress)
Merging libata/for-next (27fd071040e3 ata: libata-core: Disable NCQ_TRIM on=
 Micron 1100 drives)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (98ac9e4fc07f mmc: atmel-mci: Move card detect gpio polari=
ty quirk to gpiolib)
Merging mfd/for-mfd-next (9aab92bc3a89 mfd: mc13xxx: Simplify device data f=
etching in probe())
Merging backlight/for-backlight-next (a4464092f2c5 backlight: led_bl: Remov=
e redundant of_match_ptr())
Merging battery/for-next (7e6311f04b41 power: supply: qcom_pmi8998_charger:=
 fix charger status)
Merging regulator/for-next (41f02a383ac6 Merge remote-tracking branch 'regu=
lator/for-6.5' into regulator-linus)
Merging security/next (8e4672d6f902 lsm: constify the 'file' parameter in s=
ecurity_binder_transfer_file())
Merging apparmor/apparmor-next (8884ba07786c apparmor: fix invalid referenc=
e on profile->disconnected)
Merging integrity/next-integrity (55e2b69649be kexec_lock: Replace kexec_mu=
tex() by kexec_lock() in two comments)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (1df83cbf23a2 selinux: prevent KMSAN warning in selinu=
x_inet_conn_request())
Merging smack/next (3ad49d37cf57 smackfs: Prevent underflow in smk_set_cips=
o())
Merging tomoyo/master (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging tpmdd/next (8f7f35e5aa6f tpm: Enable hwrng only for Pluton on AMD C=
PUs)
Merging watchdog/master (8c776a0401f1 watchdog: Add support for Amlogic-T7 =
SoCs)
Merging iommu/next (d8fe59f11096 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
Merging audit/next (b1a0f64cc65e audit: move trailing statements to next li=
ne)
Merging devicetree/for-next (d117ca218b16 Merge branch 'dt/header-cleanups-=
for-6.6' into dt/next)
Merging dt-krzk/for-next (f418e00ab433 Merge branch 'next/qcom-pinctrl' int=
o for-next)
Merging mailbox/mailbox-for-next (a493208079e2 mailbox: qcom-ipcc: fix inco=
rrect num_chans counting)
Merging spi/for-next (578464679f33 spi: sun6i: fix RX data corruption in DM=
A mode)
Merging tip/master (262a6c3bc6e1 Merge branch into tip/master: 'perf/urgent=
')
Merging clockevents/timers/drivers/next (0a8b07c77ea0 clocksource: Explicit=
ly include correct DT includes)
Merging edac/edac-for-next (ce53ad81ed36 EDAC/igen6: Fix the issue of no er=
ror events)
Merging irqchip/irq/irqchip-next (19b5a44bee16 irqchip: Add support for Aml=
ogic-C3 SoCs)
Merging ftrace/for-next (fc1653abba0d Merge probes/for-next)
Merging rcu/rcu/next (94e70d269433 Merge branch 'csd-lock.2023.07.14b' into=
 HEAD)
Merging kvm/next (d011151616e7 Merge branch 'kvm-x86-mmu-6.6' into HEAD)
Merging kvm-arm/next (169c0f23cacc KVM: arm64: Properly return allocated EL=
2 VA from hyp_alloc_private_va_range())
Merging kvms390/next (899e2206f46a KVM: s390: pv: Allow AP-instructions for=
 pv-guests)
Merging kvm-riscv/riscv_kvm_next (477069398ed6 KVM: riscv: selftests: Add g=
et-reg-list test)
Merging kvm-x86/next (63cfea1efaa0 Merge branch 'misc')
CONFLICT (add/add): Merge conflict in arch/x86/kvm/mmu/page_track.h
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/svm.c
Merging xen-tip/linux-next (475505975093 xen: simplify evtchn_do_upcall() c=
all maze)
Merging percpu/for-next (3fcf62f24c80 Merge branch 'for-6.6' into for-next)
Merging workqueues/for-next (96796025f400 Merge branch 'for-6.6' into for-n=
ext)
Merging drivers-x86/for-next (acce85a7dd28 platform/x86: asus-wmi: correcti=
ons to egpu safety check)
Merging chrome-platform/for-next (0820debb7d48 platform/chrome: chromeos_ac=
pi: print hex string for ACPI_TYPE_BUFFER)
Merging chrome-platform-firmware/for-firmware-next (0979e7e3cfd7 MAINTAINER=
S: Add drivers/firmware/google/ entry)
Merging hsi/for-next (7ebf243a2018 hsi: omap_ssi: Explicitly include correc=
t DT includes)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (baca986e1f2c leds: aw2013: Enable pull-up su=
pply for interrupt and I2C)
Merging ipmi/for-next (29aa98d0fe01 Merge tag 'for-linus-2023083101' of git=
://git.kernel.org/pub/scm/linux/kernel/git/hid/hid)
Merging driver-core/driver-core-next (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging usb/usb-next (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging thunderbolt/next (a3f6445842e5 Documentation/ABI: thunderbolt: Repl=
ace 01.org in contact)
Merging usb-serial/usb-next (4d9488b294e1 USB: serial: option: add FOXCONN =
T99W368/T99W373 product)
Merging tty/tty-next (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging char-misc/char-misc-next (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging accel/habanalabs-next (ef8b0cb1ba37 accel/habanalabs: fix ETR/ETF f=
lush logic)
CONFLICT (content): Merge conflict in drivers/accel/habanalabs/common/haban=
alabs.h
Merging coresight/next (c0a232f1e19e coresight: trbe: Fix TRBE potential sl=
eep in atomic context)
Merging fastrpc/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging fpga/for-next (1a22ec09a2c1 fpga: region: make fpga_region_class a =
static const structure)
Merging icc/icc-next (6ac3f01201fa Merge branch 'icc-debugfs' into icc-next)
Merging iio/togreg (14b7447cec15 Documentation: ABI: testing: admv8818: add=
 bypass)
Merging phy-next/next (691525074db9 phy: exynos5-usbdrd: Add Exynos850 supp=
ort)
Merging soundwire/next (8c4c9a9ae5af soundwire: intel_ace2x: add DAI hw_par=
ams/prepare/hw_free callbacks)
Merging extcon/extcon-next (d20a3a8a32e3 extcon: cht_wc: add POWER_SUPPLY d=
ependency)
Merging gnss/gnss-next (fdf0eaf11452 Linux 6.5-rc2)
Merging vfio/next (642265e22ecc vfio/pds: Send type for SUSPEND_STATUS comm=
and)
Merging w1/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging staging/staging-next (3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging counter-next/counter-next (631c15d5f14d counter: chrdev: remove a t=
ypo in header file comment)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (72f5801a4e2b dmaengine: fsl-edma: integrate v3 supp=
ort)
Merging cgroup/for-next (78d44b824ed0 cgroup: Avoid -Wstringop-overflow war=
nings)
Merging scsi/for-next (1540a5c0c05f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (d32533d30e21 scsi: ufs: core: Poll HCS.UCRDY bef=
ore issuing a UIC command)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_dfs.c
Merging vhost/linux-next (1acfe2c12258 virtio_ring: fix avail_wrap_counter =
in virtqueue_add_packed)
Merging rpmsg/for-next (569e93d37475 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (ac9a78681b92 Linux 6.4-rc1)
Merging gpio-brgl/gpio/for-next (3d0957b07e27 gpio: pca953x: add support fo=
r TCA9538)
Merging gpio-intel/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pinctrl/for-next (b4e880a8d840 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (d5301c90716a pinctrl: cherryview: fix addre=
ss_space_handler() argument)
Merging pinctrl-renesas/renesas-pinctrl (3a629cf4f0e6 Merge tag 'renesas-pi=
nctrl-fixes-for-v6.5-tag2' into renesas-pinctrl)
Merging pinctrl-samsung/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging pwm/for-next (4aae44f65827 pwm: lpc32xx: Remove handling of PWM cha=
nnels)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (f4e4ada58699 selftests/ftrace: Correctly enable eve=
nt in instance-event.tc)
Merging kunit/test (06c2afb862f9 Linux 6.5-rc1)
Merging kunit-next/kunit (9076bc476d7e kunit: Fix possible memory leak in k=
unit_filter_suites())
Merging livepatching/for-next (ac4890f97211 Merge branch 'for-6.5/core' int=
o for-next)
Merging rtc/rtc-next (7130856f5605 rtc: twl: add NVRAM support)
Merging nvdimm/libnvdimm-for-next (08ca6906a4b7 nvdimm: Fix dereference aft=
er free in register_nvdimm_pmu())
Merging at24/at24/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging ntb/ntb-next (643982232860 ntb: Check tx descriptors outstanding in=
stead of head/tail for tx queue)
Merging seccomp/for-next/seccomp (46822860a5a9 seccomp: Add missing kerndoc=
 notations)
Merging fsi/next (f04d61a379d6 fsi: fix some spelling mistakes in comment)
Merging slimbus/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging nvmem/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (284930a0146a x86/hyperv: Remove duplicate inclu=
de)
Merging auxdisplay/auxdisplay (35b464e32c8b auxdisplay: hd44780: move curso=
r home after clear display command)
Merging kgdb/kgdb/for-next (b6464883f45a kdb: move kdb_send_sig() declarati=
on to a better header file)
Merging hmm/hmm (06c2afb862f9 Linux 6.5-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (0724869ede9c bus: mhi: host: pci_generic: add support=
 for Telit FE990 modem)
Merging memblock/for-next (0f5e4adb608c memblock: report failures when memb=
lock_can_resize is not set)
Merging cxl/next (fe77cc2e5a6a cxl: Fix one kernel-doc comment)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (fa0aa919ef44 efi/x86: Move EFI runtime call setup/teardow=
n helpers out of line)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/slab/for-next (3d053e806043 Merge branch 'slab/for-6.6/random_=
kmalloc' into slab/for-next)
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (2a2015495142 selftests/landlock: Fix a resource leak)
Merging rust/rust-next (4af84c6a85c6 rust: init: update expanded macro expl=
anation)
Merging sysctl/sysctl-next (53f3811dfd5e sysctl: Use ctl_table_size as stop=
ping criteria for list macro)
Merging execve/for-next/execve (fdf0eaf11452 Linux 6.5-rc2)
Merging bitmap/bitmap-for-next (bcafd8b927ed bitmap: Remove dead code, i.e.=
 bitmap_copy_le())
Merging hte/for-next (06c2afb862f9 Linux 6.5-rc1)
Merging kspp/for-next/kspp (5f536ac6a5a7 LoadPin: Annotate struct dm_verity=
_loadpin_trusted_root_digest with __counted_by)
Merging kspp-gustavo/for-next/kspp (4d8cbf6dbcda fs: omfs: Use flexible-arr=
ay member in struct omfs_extent)
Merging nolibc/nolibc (556fb7131e03 tools/nolibc: avoid undesired casts in =
the __sysret() macro)
Merging iommufd/for-next (eb501c2d96cf iommufd/selftest: Don't leak the pla=
tform device memory when unloading the module)

--Sig_/T.QFEcSlPCSj/OzY/ys3kjk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT34tEACgkQAVBC80lX
0Gyewwf/Yktj3R7kYJrLyx1DjvDyxthObUAiRF+Rbz82vFHWiRoSMqffgOPjX0ua
q4eeoseo//7pOTyN1V/Q9CAjtz1Q9zWwPWpgfmv+1oQv0KAWNNJKck8kih+46RXe
tLA8bYTAQN1ZU0rpPPHYWQXBgaG3eoUf9UaHlMy1N2NDZrEimhR/n2TvJt5sjcnD
6C5cdR6uxX5NxHetGoZHA9/oh1Ktpf/1wZTf+hwnfDm4BEwRJzbptuVOiVHOiY1e
/X85GaobGkjLcRlP93rMHk2LiJgtUDqmgT5gJ6kWjkMj4CoHbl6y4eU88fwEuiEL
r5zLTRn4By433HNBaDn2dt5U+le2Sw==
=5Jtg
-----END PGP SIGNATURE-----

--Sig_/T.QFEcSlPCSj/OzY/ys3kjk--
