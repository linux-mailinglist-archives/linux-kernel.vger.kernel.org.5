Return-Path: <linux-kernel+bounces-142113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229898A27B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F91F220C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B24AEE0;
	Fri, 12 Apr 2024 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oPHkYtC+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0AB1DDDB;
	Fri, 12 Apr 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905770; cv=none; b=P0UzrCrCSKhUa/xAd08GruM0WOVrZE+MkMv7UDbEtSR/ZMGBefWjV5UUQa/LSl0b0QZMUFfUaywJ3cEp3XxtN34UXIJRmElrPPee9G64nX38fTpDjjMCtm+UhDchA288mDV8RqxhEjIK70qUuQUsJPgop3xv4KiTZybXKBnom+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905770; c=relaxed/simple;
	bh=MsRWgMEAPjj6uZ5B/mPrHl+w2tMn46Ak6d1kpHA/oaI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dvX6QYSCvxEbRgSToxQLJsJnBRci10z0CzmF9dzyyvkokl6ZJobwukYuH02N+JSxr24+LXlQwY2tVD4YJfEabuXV8sd506QnnBvnNmCRVr5/WfGBhuIq1pXaetE1N0eT2pfIFyKQouowINCbakPhlROG+bU4uctP9Uk/JtOHC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oPHkYtC+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712905764;
	bh=a5w4sWtsvnFFzt68R+JbFIa4i3RlJ9zPJex1JlfUlDk=;
	h=Date:From:To:Cc:Subject:From;
	b=oPHkYtC+i7GMp181oUG0nt6KmjOdeaSvam/joFhpwXNE8YI4F9C5JL0et7o2XZKI8
	 1OJYDo8gy5vF3XeN/pYBtb6Rw5QmOPgxA8jRNOGA77EFf9oHyvlEhWc7i9uNHNj46+
	 sHFrAFUsQnu3qVseg5nVN6ke7DIt5fakNzwz8GgeyI6Pczd9V3ckpBPTYEFQZ07NEv
	 u+C2M5GeI6pdRlG4bkfddXV/pa+7VVgc2U85mP4/yUMLjgoONgxteEsIIzMQzH/a04
	 D5MtmO872Q3nKMakDWcuXKLq5oGPbPR+NTcSZgKWdLRATe2/J0cx829K2wlv0hMEsP
	 8PPU9KhTITW9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG73R6VKtz4wcR;
	Fri, 12 Apr 2024 17:09:23 +1000 (AEST)
Date: Fri, 12 Apr 2024 17:09:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 12
Message-ID: <20240412170923.57cf5b18@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VXAxiWpUoDkwCBLhnzLCGI3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/VXAxiWpUoDkwCBLhnzLCGI3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240411:

The net tree lost its build failure.

The mm tree gained 2 build failures for which I applied patches.

The perf tree still had its build failure, but doing a clean then
rebuilding works.

The hid tree lost its build failure.

The net-next tree gained a conflict against the nfsd-fixes tree.
The net-next tree lost its build failure.

The modules tree gained a conflict against the mm tree.

The kvm tree gained a build failure for which I applied a partial revert
of a commit.

The kvm-x86 tree gained a conflict against the kvm tree.

The usb tree gained a conflict against the usb.current tree.

The tty tree still had its build failure, so I used the version from
next-20240410.

The fpga tree gained a build failure so I used the version from
next-20240411.

The scsi-mkp tree gained a build failure so I used the version from
next-20240411.

Non-merge commits (relative to Linus' tree): 5139
 5213 files changed, 199137 insertions(+), 124106 deletions(-)

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

I am currently merging 369 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (00dcf5d862e8 Merge tag 'acpi-6.9-rc4' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (2f61e5f50dcb fork: defer linking =
file vma until vma is fully initialized)
Merging kbuild-current/fixes (89e5462bb5ae kconfig: Fix typo HEIGTH to HEIG=
HT)
Merging arc-current/for-curr (ebfc2fd8873b ARC: Fix typos)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (e3ba51ab24fd arm64: tlb: Fix TLBI RANGE=
 operand)
Merging arm-soc-fixes/arm/fixes (011d79ef1cfa MAINTAINERS: Change Krzysztof=
 Kozlowski's email address)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging sophgo-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (36ba64b4cbc6 selftests/powerpc/papr-vpd: Fix m=
issing variable initialization)
Merging s390-fixes/fixes (378ca2d2ad41 s390/entry: align system call table =
on 8 bytes)
Merging fscrypt-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging fsverity-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging net/main (2ae9a8972ce0 Merge tag 'net-6.9-rc4' of git://git.kernel.=
org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (6648e613226e bpf, skmsg: Fix NULL pointer dereference i=
n sk_psock_skb_ingress_enqueue)
Merging ipsec/master (bccb798e07f8 octeontx2-pf: Fix transmit scheduler res=
ource leak)
Merging netfilter/main (6db5dc7b351b netfilter: flowtable: incorrect pppoe =
tuple)
Merging ipvs/main (7eaf837a4eb5 netfilter: nf_tables: Fix a memory leak in =
nf_tables_updchain)
Merging wireless/for-next (9ef369973cd2 wifi: cfg80211: fix the order of ar=
guments for trace events of the tx_rx_evt class)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (b68e1acb5834 RDMA/cm: Print the old state when c=
m_destroy_id gets timeout)
Merging sound-current/for-linus (0b6f0ff01a4a ALSA: hda/tas2781: correct th=
e register for pow calibrated data)
Merging sound-asoc-fixes/for-linus (2e411e939da9 ASoC: cs35l56: Fixes to ha=
ndling of ASP1 config)
Merging regmap-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging regulator-fixes/for-linus (68adb581a39a regulator: vqmmc-ipq4019: f=
ix module autoloading)
Merging spi-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging pci-current/for-linus (302b84e84d10 Revert "PCI: Mark LSI FW643 to =
avoid bus reset")
Merging driver-core.current/driver-core-linus (156539fd6501 Documentation: =
embargoed-hardware-issues.rst: Add myself for Power)
  156539fd6501 ("Documentation: embargoed-hardware-issues.rst: Add myself f=
or Power")
Merging tty.current/tty-linus (1aa4ad4eb695 serial: core: Fix missing shutd=
own and startup for serial base port)
Merging usb.current/usb-linus (34b990e9bb54 usb: misc: onboard_usb_hub: Dis=
able the USB hub clock on failure)
Merging usb-serial-fixes/usb-linus (d206a76d7d27 Linux 6.8-rc6)
Merging phy/fixes (47b3e2f3914a phy: qcom: m31: match requested regulator n=
ame with dt schema)
Merging staging.current/staging-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging iio-fixes/fixes-togreg (74a72baf204f iio:imu: adis16475: Fix sync m=
ode setting)
Merging counter-current/counter-current (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc.current/char-misc-linus (ebaed6d4def8 peci: linux/peci.h:=
 fix Excess kernel-doc description warning)
Merging soundwire-fixes/fixes (63dc588e7af1 soundwire: amd: fix for wake in=
terrupt handling for clockstop mode)
Merging thunderbolt-fixes/fixes (dcd12acaf384 thunderbolt: Avoid notify PM =
core about runtime PM resume)
Merging input-current/for-linus (57ed9567e63b Merge branch 'next' into for-=
linus)
Merging crypto-current/master (5a7e89d3315d crypto: iaa - Fix nr_cpus < nr_=
iaa case)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (72d7cb5c190b selftests/harness: Prevent infi=
nite loop due to Assert in FIXTURE_TEARDOWN)
Merging dmaengine-fixes/fixes (f221033f5c24 dmaengine: idxd: Fix oops durin=
g rmmod on single-CPU platforms)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (21c9fb611c25 mtd: diskonchip: work around ubsa=
n link failure)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (d353c3c34af0 media: mediatek: vcodec: support =
36 bits physical address)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (4370b673ccf2 MIPS: scall: Save thread_info.s=
yscall unconditionally on entry)
Merging at91-fixes/at91-fixes (4cece7649650 Linux 6.9-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (49ff3b4aec51 KVM: x86/pmu: Do not mask LVTPC when=
 handling a PMI on AMD platforms)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (4cece7649650 Linux 6.9-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (7bcf809b1e78 cxl: Add checks to access_coordinate =
calculation to fail missing data)
Merging btrfs-fixes/next-fixes (07475cc36e03 Merge branch 'misc-6.9' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (e71c84816925 platform/x86: lg-laptop: fix =
%s null argument warning)
Merging samsung-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pinctrl-samsung-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging devicetree-fixes/dt/linus (de164a7f1924 nios2: Only use built-in de=
vicetree blob if configured to do so)
Merging dt-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging scsi-fixes/fixes (ca91259b775f scsi: core: Fix handling of SCMD_FAI=
L_IF_RECOVERING)
Merging drm-fixes/drm-fixes (1bafeaf26264 Merge tag 'drm-xe-fixes-2024-04-1=
1' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (dcd8992e47f1 drm/i915/vrr: Di=
sable VRR when using bigjoiner)
Merging mmc-fixes/fixes (ace323f80b9b mmc: sdhci-of-dwcmshc: th1520: Increa=
se tuning loop count to 128)
Merging rtc-fixes/rtc-fixes (4cece7649650 Linux 6.9-rc1)
Merging gnss-fixes/gnss-linus (54be6c6c5ae8 Linux 6.8-rc3)
Merging hyperv-fixes/hyperv-fixes (30d18df6567b Drivers: hv: vmbus: Don't f=
ree ring buffers that couldn't be re-encrypted)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (a373a36fb6b0 Merge patch the fixes from "riscv:=
 64-bit NOMMU fixes and enhancements")
Merging riscv-dt-fixes/riscv-dt-fixes (0f74c64f0a9f riscv: dts: starfive: R=
emove PMIC interrupt info for Visionfive 2 board)
Merging riscv-soc-fixes/riscv-soc-fixes (6b0856ee585d cache: sifive_ccache:=
 Silence unused variable warning)
Merging fpga-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging spdx/spdx-linus (4cece7649650 Linux 6.9-rc1)
Merging gpio-brgl-fixes/gpio/for-current (e43c2feb8f32 Merge tag 'intel-gpi=
o-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-=
intel into gpio/for-current)
Merging gpio-intel-fixes/fixes (ace0ebe5c98d gpio: crystalcove: Use -ENOTSU=
PP consistently)
Merging pinctrl-intel-fixes/fixes (5d10a157ebe0 pinctrl: baytrail: Add pinc=
onf group for uart3)
Merging auxdisplay-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging erofs-fixes/fixes (7557d296ad43 MAINTAINERS: erofs: add myself as r=
eviewer)
Merging kunit-fixes/kunit-fixes (cfedfb24c9dd kunit: configs: Enable CONFIG=
_DAMON_DBGFS_DEPRECATED for --alltests)
Merging memblock-fixes/fixes (592447f6cb3c memblock tests: fix undefined re=
ference to `BIT')
Merging nfsd-fixes/nfsd-fixes (f488138b5267 NFSD: fix endianness issue in n=
fsd4_encode_fattr4)
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (25e973a0e077 perf annotate: Make sure to c=
all symbol__annotate2() in TUI)
Merging efi-fixes/urgent (decd347c2a75 x86/efistub: Reinstate soft limit fo=
r initrd loading)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (452d8950db3e power: rt9455: hide unused rt9455=
_boost_voltage_values)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (39cd87c4eb2b Linux 6.9-rc2)
Merging rust-fixes/rust-fixes (761a8f0a776b rust: make mutually exclusive w=
ith CFI_CLANG)
Merging v9fs-fixes/fixes/next (7a84602297d3 9p: explicitly deny setlease at=
tempts)
Merging w1-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pmdomain-fixes/fixes (39cd87c4eb2b Linux 6.9-rc2)
Merging overlayfs-fixes/ovl-fixes (77a28aa47687 ovl: relax WARN_ON in ovl_v=
erify_area())
Merging i2c-host-fixes/i2c/i2c-host-fixes (fec50db7033e Linux 6.9-rc3)
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging clk-fixes/clk-fixes (d3e8a91a848a clk: mediatek: mt7988-infracfg: f=
ix clocks for 2nd PCIe port)
Merging drm-misc-fixes/for-linux-next-fixes (4c08f01934ab drm/vmwgfx: Enabl=
e DMA mappings with SEV)
Merging mm-stable/mm-stable (4e2e36129225 Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (39cd87c4eb2b Linux 6.9-rc2)
Merging mm/mm-everything (ed7c95c95397 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
  925cc828a1ef ("fix-missing-vmalloch-includes-fix-3")
CONFLICT (content): Merge conflict in arch/x86/mm/numa_32.c
Applying: fix up for ""mm: add per-order mTHP anon_alloc and anon_alloc_fal=
lback counters"
Merging kbuild/for-next (bfa8f18691ed Merge tag 'scsi-misc' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (9c3e9af74326 perf metrics: Remove the "No_gro=
up" metric group)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (a1255ccab8ec swiotlb: do not set total_used t=
o 0 in swiotlb_create_debugfs_files())
Merging asm-generic/master (5394f1e9b687 arch: define CONFIG_PAGE_SIZE_*KB =
on all architectures)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (5616fee8981b Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (fec50db7033e Linux 6.9-rc3)
Merging arm-perf/for-next/perf (8f9f5041c646 perf/arm-cmn: Set PMU device p=
arent)
Merging arm-soc/for-next (011d79ef1cfa MAINTAINERS: Change Krzysztof Kozlow=
ski's email address)
Merging amlogic/for-next (4ee46d40d625 Merge branch 'v6.10/arm64-dt' into f=
or-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (fa8e55345b64 Merge branch 'microchip-dt64' into at9=
1-next)
Merging broadcom/next (ebe9ff485efc Merge branch 'drivers/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (bf11908757ee memory: mtk-smi: fix module a=
utoloading)
Merging imx-mxs/for-next (6cf256f63478 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (67d5303fe655 Merge branch 'v6.9-next/dts64' into=
 for-next)
Merging mvebu/for-next (058bfa0ead87 arm64: dts: marvell: cn9130-crb: drop =
unneeded "status")
Merging omap/for-next (2a1e301bf479 Merge branch 'omap-for-v6.10/dt' into f=
or-next)
Merging qcom/for-next (3cd1977804fb Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-for-6.10', 'clk-fixes-for-6.9' and 'drivers-fo=
r-6.10' into for-next)
Merging renesas/next (957eed54b7b6 Merge branch 'renesas-dts-for-v6.10' int=
o renesas-next)
Merging reset/reset/next (6d89df61650d reset: ti-sci: Convert to platform r=
emove callback returning void)
Merging rockchip/for-next (56f939cce5e1 Merge branch 'v6.10-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (b7b2fe24038b Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (a4200c1395dc Merge branches 'for-next/scmi/upd=
ates' and 'for-next/ffa/updates', tags 'ffa-fix-6.9' and 'scmi-fixes-6.9' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for=
-linux-next)
Merging sophgo/for-next (65fcc08b4cfe riscv: dts: sophgo: cv18xx: Add i2c d=
evices)
Merging stm32/stm32-next (b12a916d30dc ARM: dts: stm32: add heartbeat led f=
or stm32mp157c-ed1)
Merging sunxi/sunxi/for-next (c1d7282e4e92 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (60757f1264a2 Merge branch 'tee_ts_for_v6.10' into next)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (592695bed5f8 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-dts-next' and 'ti-keystone-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (deb01ebcc734 Merge branch 'clk-loongson' into clk-nex=
t)
Merging clk-imx/for-next (13269dc6c704 clk: imx: imx8mp: Fix SAI_MCLK_SEL d=
efinition)
Merging clk-renesas/renesas-clk (c0516eb4cf04 clk: renesas: r8a779h0: Add t=
imer clocks)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (a07c772fa658 LoongArch: Include linux/siz=
es.h in addrspace.h to prevent build errors)
Merging m68k/for-next (70d830e337f9 m68k: Calculate THREAD_SIZE from THREAD=
_SIZE_ORDER)
Merging m68knommu/for-next (d677c24fccee m68k: Avoid CONFIG_COLDFIRE switch=
 in uapi header)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (4cece7649650 Linux 6.9-rc1)
Merging openrisc/for-next (68b70ab43cec openrisc: Move FPU state out of pt_=
regs)
Merging parisc-hd/for-next (e8f897f4afef Linux 6.8)
Merging powerpc/next (8884fc918f6a powerpc: Fix fatal warnings flag for LLV=
M's integrated assembler)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (ba5ea59f768f riscv: Do not save the scratch CSR du=
ring suspend)
CONFLICT (content): Merge conflict in Documentation/rust/arch-support.rst
Merging riscv-dt/riscv-dt-for-next (5db2c4dc413e riscv: dts: add initial ca=
nmv-k230 and k230-evb dts)
CONFLICT (content): Merge conflict in arch/riscv/Makefile
Merging riscv-soc/riscv-soc-for-next (16d9122246cc Merge branch 'riscv-conf=
ig' into riscv-soc-for-next)
Merging s390/for-next (9fb83b5a1bdb Merge branch 'features' into for-next)
Merging sh/for-next (4cece7649650 Linux 6.9-rc1)
Merging sparc/for-next (84b76d05828a lib/fonts: Allow Sparc console 8x16 fo=
nt for sparc64 early boot text console)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (11cca8ccf2c3 tty: xtensa/iss: Use min() to =
fix Coccinelle warning)
Merging bcachefs/for-next (1189bdda6c99 bcachefs: Fix __bch2_btree_and_jour=
nal_iter_init_node_iter())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (7218664bf91d Merge branch 'for-next-next-v6.9-20240=
409' into for-next-20240409)
Merging ceph/master (d3e046930679 MAINTAINERS: remove myself as a Reviewer =
for Ceph)
Merging cifs/for-next (4e996f9d30cb smb: client: Fix hang in smb2_reconnect)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging erofs/dev (b351756059e3 erofs: derive fsid from on-disk UUID for .s=
tatfs() if possible)
Merging exfat/dev (6397cc21e5c0 exfat: move extend valid_size into ->page_m=
kwrite())
Merging exportfs/exportfs-next (e8f897f4afef Linux 6.8)
Merging ext3/for_next (172dc02ca6ec Merge UDF time conversion fix.)
Merging ext4/dev (0ecae5410ab5 ext4: initialize sbi->s_freeclusters_counter=
 and sbi->s_dirtyclusters_counter before use in kunit test)
Merging f2fs/dev (bf3a69c6861f Merge tag 'for-linus-6.9-ofs1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/hubcap/linux)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (cdf6ac2a03d2 fuse: get rid of ff->readdir.lock)
Merging gfs2/for-next (cac2ca6ca549 gfs2: Fix do_xmote locking error)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (405ac6a57277 Merge tag '6.9-rc2-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (24457f1be29f nfs: Handle error of rpc_proc_register=
() in nfs_net_init().)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (e5ca63b09c65 nfsd: optimise recalculate_deny_mode()=
 for a common case)
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (b8a77b9a5f9c mtd: ubi: fix NVMEM over UBI volumes on 32=
-bit systems)
Merging v9fs/9p-next (2a0505cdd8c8 9p: remove SLAB_MEM_SPREAD flag usage)
Merging v9fs-ericvh/ericvh/for-next (4cece7649650 Linux 6.9-rc1)
Merging xfs/for-next (e23d7e82b707 xfs: allow cross-linking special files w=
ithout project quota)
Merging zonefs/for-next (567e629fd296 zonefs: convert zonefs to use the new=
 mount api)
Merging iomap/iomap-for-next (3ac974796e5d iomap: fix short copy in iomap_w=
rite_iter())
Merging djw-vfs/vfs-for-next (ce85a1e04645 xfs: stabilize fs summary counte=
rs for online fsck)
Merging file-locks/locks-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6-=
mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging iversion/iversion-next (e0152e7481c6 Merge tag 'riscv-for-linus-6.6=
-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux)
Merging vfs-brauner/vfs.all (7dad3e0bd4e4 Merge branch 'vfs.super' into vfs=
all)
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (a2b4cab9da77 Merge branch 'for-6.10' into for-next)
Merging pci/next (ced360f2a021 Merge branch 'pci/dt-bindings')
Merging pstore/for-next/pstore (9dd12ed95c2d pstore/blk: replace deprecated=
 strncpy with strscpy)
Merging hid/for-next (a8d38c4a9f9f Merge branch 'for-6.10/hid-bpf' into for=
-next)
Merging i2c/i2c/for-next (5ceeabb0eb2e Merge tag 'i2c-host-fixes-6.9-rc3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/f=
or-current)
Merging i2c-host/i2c/i2c-host (ab9713bb8844 i2c: i801: Fix missing Kconfig =
dependency)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging hwmon-staging/hwmon-next (db85dba9fee5 hwmon: (aspeed-g6-pwm-tach) =
Convert to platform remove callback returning void)
Merging jc_docs/docs-next (8819b60eed72 docs/zh_CN: Add dev-tools/kmemleak =
Chinese translation)
Merging v4l-dvb/master (4cece7649650 Linux 6.9-rc1)
Merging v4l-dvb-next/master (71b3ed53b08d media: atomisp: Implement link_se=
tup() op for ISP subdev MC entity)
Merging pm/linux-next (53c477378d23 Merge branch 'acpica' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (4cece7649650 Linux 6.9-rc1)
Merging cpupower/cpupower (4cece7649650 Linux 6.9-rc1)
Merging devfreq/devfreq-next (6f3c0cfe2aa5 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (02e2a4b3638c cpuidle: psci: Update init level to cor=
e_initcall())
Merging opp/opp/linux-next (4cece7649650 Linux 6.9-rc1)
Merging thermal/thermal/linux-next (1828c1c17bb2 thermal/drivers/rcar_gen3:=
 Add support for R-Car V4M)
Merging dlm/next (92d59adfaf71 dlm: do message processing in softirq contex=
t)
Merging rdma/for-next (dfcdb38b21e4 RDMA/rxe: Return the correct errno)
Merging net-next/main (94426ed2137a Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/netdev/net)
CONFLICT (content): Merge conflict in include/trace/events/rpcgss.h
Merging bpf-next/for-next (c53e853c2d81 Merge branch 'export send_recv_data=
')
Merging ipsec-next/master (267e31750ae8 Merge branch 'phy-listing-link_topo=
logy-tracking')
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (e00fc2700a3f Bluetooth: btusb: Fix triggering cor=
edump implementation for QCA)
  01841038e1d2 ("Bluetooth: Fix memory leak in hci_req_sync_complete()")
  2151391668d9 ("Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are =
unset")
  289bfd91fcf2 ("Bluetooth: SCO: Fix not validating setsockopt user input")
  35d2c39b23ff ("Bluetooth: hci_sock: Fix not validating setsockopt user in=
put")
  5a5010485400 ("Bluetooth: ISO: Fix not validating setsockopt user input")
  a95f9d212d1b ("Bluetooth: L2CAP: Fix not validating setsockopt user input=
")
  b191fb7a3075 ("Bluetooth: hci_sync: Fix using the same interval and windo=
w for Coded PHY")
  e6bb15dbae90 ("Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNE=
CTED bit")
  ee77912bc0bb ("Bluetooth: RFCOMM: Fix not validating setsockopt user inpu=
t")
Merging wireless-next/for-next (d26a0a66f929 wifi: brcmfmac: Fix spelling m=
istake "ivalid" -> "invalid")
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (3ef4600f1226 mtd: maps: sa1100-flash: Prefer struct_s=
ize over open coded arithmetic)
Merging nand/nand/next (6819db94e1cd mtd: rawnand: hynix: fixed typo)
Merging spi-nor/spi-nor/next (4cece7649650 Linux 6.9-rc1)
Merging crypto/master (4ad27a8be9db crypto: jitter - Replace http with http=
s)
Merging drm/drm-next (6e1f415e7129 Merge tag 'drm-misc-next-2024-04-10' of =
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next)
Merging drm-exynos/for-linux-next (6633c7d2fd31 drm/exynos: mixer: drop dri=
ver owner initialization)
Merging drm-misc/for-linux-next (42118c5f6853 drm/i915: Add SIZE_HINTS prop=
erty for cursors)
Merging amdgpu/drm-next (526b184e8883 drm/amdgpu: differentiate external re=
v id for gfx 11.5.0)
  029faefb7302 ("drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2")
  05e40141685f ("drm/amdgpu: clear set_q_mode_offs when VM changed")
  108ab31be9d5 ("drm/amdgpu/umsch: reinitialize write pointer in hw init")
  24e9727b39ca ("drm/amd/display: Do not recursively call manual trigger pr=
ogramming")
  27e718ac8b81 ("drm/amd/display: fix disable otg wa logic in DCN316")
  2dbe9c2b2685 ("drm/amd/display: add DCN 351 version for microcode load")
  364b1c1de6de ("drm/amd/display: Adjust dprefclk by down spread percentage=
")
  4a5b171299e5 ("drm/amd/display: always reset ODM mode in context when add=
ing first plane")
  526b184e8883 ("drm/amdgpu: differentiate external rev id for gfx 11.5.0")
  7c1d9e10e664 ("drm/amd/pm: fix the high voltage issue after unload")
  8966c3167402 ("drm/amdgpu : Increase the mes log buffer size as per new M=
ES FW version")
  91bc86011661 ("drm/amdgpu: Fix VCN allocation in CPX partition")
  af1c41858da1 ("drm/amd/display: Return max resolution supported by DWB")
  cd409dbc6986 ("drm/amdgpu: Refine IB schedule error logging")
  cf82a80a1456 ("drm/amd/display: Skip on writeback when it's not applicabl=
e")
  d045f4ad7700 ("drm/amd/swsmu: Update smu v14.0.0 headers to be 14.0.1 com=
patible")
  d6d6561f936b ("drm/amdgpu: fix incorrect number of active RBs for gfx11")
  d7f148764355 ("drm/amdgpu: always force full reset for SOC21")
  df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")
  dfb15c4ab586 ("amd/amdkfd: sync all devices to wait all processes being e=
victed")
  e58acb7613aa ("drm/amdgpu : Add mes_log_enable to control mes log feature=
")
  f5a3507c4abf ("drm/amdgpu: add smu 14.0.1 discovery support")
  fedb6ae49758 ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n351/dcn351_fpu.c
Merging drm-intel/for-linux-next (578ff98403ce drm/i915: Allow bigjoiner fo=
r MST)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_cd=
clk.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
_mst.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ps=
r.c
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (9dc23cba0927 drm/msm/adreno: Set highest_bank_bit=
 for A619)
Merging drm-msm-lumag/msm-next-lumag (ab556156cafa drm/msm: drop A6xx heade=
r)
Merging drm-xe/drm-xe-next (4209d635a823 drm/xe: Remove devcoredump during =
driver release)
  117de185edf2 ("drm/xe/display: Fix double mutex initialization")
  34820967ae7b ("drm/xe/xe_migrate: Cast to output precision before multipl=
ying operands")
  883232b47b81 ("drm/xe/hwmon: Cast result to output precision on left shif=
t of operand")
  dc30c6e7149b ("drm/xe: Label RING_CONTEXT_CONTROL as masked")
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_bo.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_device_types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_exec.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
CONFLICT (content): Merge conflict in include/uapi/drm/xe_drm.h
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (fb3b9c2d217f video: logo: Drop full path of the inp=
ut filename in generated file)
Merging regmap/for-next (8a8317f92770 regmap: kunit: Add some test cases an=
d a few small)
Merging sound/for-next (a9b16d591874 Merge branch 'topic/emu10k1-fix' into =
for-next)
Merging ieee1394/for-next (0d4149e5e9b0 firewire: ohci: use pci_irq_vector(=
) to retrieve allocated interrupt line)
Merging sound-asoc/for-next (f8cfa515170f Merge remote-tracking branch 'aso=
c/for-6.10' into asoc-next)
Merging modules/modules-next (68881525ba29 mm: introduce execmem_alloc() an=
d execmem_free())
CONFLICT (content): Merge conflict in kernel/module/main.c
Merging input/next (8984e0b56923 Input: adafruit-seesaw - only report butto=
ns that changed state)
Merging block/for-next (7ed173281653 Merge branch 'for-6.10/io_uring' into =
for-next)
CONFLICT (content): Merge conflict in io_uring/io_uring.c
CONFLICT (content): Merge conflict in io_uring/rw.c
Applying: fix up for "mm: switch mm->get_unmapped_area() to a flag"
Merging device-mapper/for-next (44078156fc77 dm: use queue_limits_set)
Merging libata/for-next (dcf2653ac12f dt-bindings: ata: ahci-da850: Convert=
 to dtschema)
Merging pcmcia/pcmcia-next (ccae53aa8aa2 pcmcia: cs: make pcmcia_socket_cla=
ss constant)
Merging mmc/next (bce42d6108c9 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (fb9d85a9698e mfd: Tidy Kconfig dependency's paren=
theses)
CONFLICT (content): Merge conflict in drivers/mfd/intel-lpss-pci.c
Merging backlight/for-backlight-next (9db7677e33b6 backlight: otm3225a: Dro=
p driver owner assignment)
Merging battery/for-next (50f0ff7c8cc4 power: supply: bq27xxx: Move health =
reading out of update loop)
Merging regulator/for-next (15f992fa81eb Merge remote-tracking branch 'regu=
lator/for-6.10' into regulator-next)
Merging security/next (4cece7649650 Linux 6.9-rc1)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (5e2e4d0ea5c2 evm: Rename is_unsupported_f=
s to is_unsupported_hmac_fs)
Merging selinux/next (d6fc1ee0b6c1 Automated merge of 'dev' into 'next')
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (6999f8229e59 keys: Fix overwrite of key expiration on i=
nstantiation)
Merging watchdog/master (6fe5aabf7fc6 watchdog: intel-mid_wdt: Get platform=
 data via dev_get_platdata())
Merging iommu/next (c404f55c26fc iommu: Validate the PASID in iommu_attach_=
device_pasid())
Merging audit/next (4cece7649650 Linux 6.9-rc1)
Merging devicetree/for-next (3cef9e08b6f4 dt-bindings: usb: mtk-xhci: add c=
ompatible for MT7988)
Merging dt-krzk/for-next (364be3ecd30d Merge branch 'next/dt' into for-next)
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (637ced031d3c Merge remote-tracking branch 'spi/for-6.=
10' into spi-next)
Merging tip/master (b4ba814ae4a4 Merge branch into tip/master: 'x86/shstk')
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (8e95536e9495 Merge branch ras/edac-misc into fo=
r-next)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (8942ebe9e183 rcutorture: Make rcutorture support srcu=
 double call test)
  56544e22cc3a ("fs/proc: remove redundant comments from /proc/bootconfig")
  e6f3a323fcfa ("fs/proc: Skip bootloader comment if no embedded kernel par=
ameters")
Merging kvm/next (415efaaf0d97 KVM: SEV: use u64_to_user_ptr throughout)
Applying: fix up for "mm: replace set_pte_at_notify() with just set_pte_at(=
)"
Merging kvm-arm/next (29b0075ed61c KVM: selftests: Fix __GUEST_ASSERT() for=
mat warnings in ARM's arch timer test)
Merging kvms390/next (00de073e2420 KVM: s390: selftest: memop: Fix undefine=
d behavior)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (8e936e98718f RISC-V: KVM: Fix APLIC in_cl=
rip[x] read emulation)
Merging kvm-x86/next (f10f3621ad80 Merge branches 'fixes', 'generic', 'misc=
', 'mmu', 'selftests', 'svm' and 'vmx')
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/svm.c
Merging xen-tip/linux-next (d277f9d82802 xen/events: increment refcnt only =
if event channel is refcounted)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (8a8a4bfdbe85 Merge branch 'for-6.10' into for-=
next)
Merging drivers-x86/for-next (88c0ef69dd88 platform/x86: asus-wmi: cleanup =
main struct to avoid some holes)
Merging chrome-platform/for-next (70a5f3005008 platform/chrome: cros_ec_lpc=
: add quirks for the Framework Laptop (AMD))
Merging chrome-platform-firmware/for-firmware-next (7f20f21c22aa firmware: =
google: cbmem: drop driver owner initialization)
Merging hsi/for-next (4cece7649650 Linux 6.9-rc1)
Merging leds-lj/for-leds-next (de6b3fd4bbc9 leds: trigger: netdev: Remove n=
ot needed call to led_set_brightness in deactivate)
  da8310b24223 ("video: backlight: Make backlight_class constant")
Merging ipmi/for-next (6b4c04178660 ipmi: kcs_bmc_npcm7xx: Convert to platf=
orm remove callback returning void)
Merging driver-core/driver-core-next (0bb322be5d38 driver core: Remove unus=
ed platform_notify, platform_notify_remove)
Merging usb/usb-next (1a395af9d53c usb: typec: ucsi_glink: drop special han=
dling for CCI_BUSY)
CONFLICT (modify/delete): drivers/usb/misc/onboard_usb_hub.c deleted in usb=
/usb-next and modified in HEAD.  Version HEAD of drivers/usb/misc/onboard_u=
sb_hub.c left in tree.
$ git rm -f drivers/usb/misc/onboard_usb_hub.c
Applying: fix up for "usb: misc: onboard_hub: rename to onboard_dev"
Merging thunderbolt/next (9a966517a830 thunderbolt: Enable NVM upgrade supp=
ort on Intel Maple Ridge)
Merging usb-serial/usb-next (b1a8da9ff139 USB: serial: cp210x: add pid/vid =
for TDK NC0110013M and MM0110113M)
Merging tty/tty-next (fff4a5d5609d serial: ar933x: Remove unneeded static s=
tructure)
CONFLICT (content): Merge conflict in drivers/tty/serial/serial_core.c
$ git reset --hard HEAD^
Merging next-20240410 version of tty
Merging char-misc/char-misc-next (fec50db7033e Linux 6.9-rc3)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (a4f3057d19ff coresight-tpda: Change qcom,dsb-elemen=
t-size to qcom,dsb-elem-bits)
Merging fastrpc/for-next (4cece7649650 Linux 6.9-rc1)
Merging fpga/for-next (5d04660b29fb fpga: ice40-spi: Remove unused of_gpio.=
h)
$ git reset --hard HEAD^
Merging next-20240411 version of fpga
Merging icc/icc-next (7af14fe58e5e Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (27eea4778db8 iio: adc: ad7944: simplify adi,spi-mode pr=
operty parsing)
Merging phy-next/next (0338e1d2f933 MAINTAINERS: Add phy-gs101-ufs file to =
Tensor GS101.)
Merging soundwire/next (4cd5ea6de156 soundwire: intel_init: resume all devi=
ces on exit.)
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (54be6c6c5ae8 Linux 6.8-rc3)
Merging vfio/next (7447d911af69 vfio/fsl-mc: Block calling interrupt handle=
r without trigger)
Merging w1/for-next (cde37a5bdb0e w1: gpio: Don't use "proxy" headers)
Merging spmi/spmi-next (897268aef3fa spmi: pmic-arb: Replace three IS_ERR()=
 calls by null pointer checks in spmi_pmic_arb_probe())
Merging staging/staging-next (18f44de63f88 staging: greybus: change strncpy=
() to strscpy_pad())
Merging counter-next/counter-next (916baadd293a counter: ti-ecap-capture: U=
tilize COUNTER_COMP_FREQUENCY macro)
Merging siox/siox/for-next (db418d5f1ca5 siox: bus-gpio: Simplify using dev=
m_siox_* functions)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (4665be0e952f dmaengine: pch_dma: remove unused func=
tion chan2parent)
Merging cgroup/for-next (a24e3b7d27c6 docs: cgroup-v1: Fix description for =
css_online)
Merging scsi/for-next (99033e81ab05 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (8e50d1ee8f4c Merge patch series "convert SCSI to=
 atomic queue limits, part 1 (v3)")
$ git reset --hard HEAD^
Merging next-20240411 version of scsi-mkp
Merging vhost/linux-next (5b9f214d0540 vhost: Merge tag 'vduse-virtio-net' =
into vhost)
Merging rpmsg/for-next (4d5aabb68439 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (1685f72a6dcc gpiolib: Do not mention legac=
y GPIOF_* in the code)
Merging gpio-intel/for-next (d8a26a18d971 gpiolib: acpi: Check for errors f=
irst in acpi_find_gpio())
Merging pinctrl/for-next (07bd48cca03b Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (5d10a157ebe0 pinctrl: baytrail: Add pinconf=
 group for uart3)
Merging pinctrl-renesas/renesas-pinctrl (aa43c15a790c pinctrl: renesas: rzg=
2l: Execute atomically the interrupt configuration)
Merging pinctrl-samsung/for-next (4184e4912ca6 dt-bindings: pinctrl: samsun=
g: drop unused header with register constants)
Merging pwm/pwm/for-next (858fbbf538a6 pwm: bcm2835: Drop open coded varian=
t of devm_clk_rate_exclusive_get())
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (4f4ade6863ce selftests/clone3: Correct log message =
for waitpid() failures)
CONFLICT (content): Merge conflict in tools/testing/selftests/timers/valid-=
adjtimex.c
Merging kunit/test (4cece7649650 Linux 6.9-rc1)
Merging kunit-next/kunit (82b0beff3497 kunit: Add tests for fault)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (8b59a11fb8e6 rtc: nuvoton: Modify part number value)
Merging nvdimm/libnvdimm-for-next (d9212b35da52 dax: remove SLAB_MEM_SPREAD=
 flag usage)
Merging at24/at24/for-next (4cece7649650 Linux 6.9-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (39cd87c4eb2b Linux 6.9-rc2)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (b12bd525ca6e slimbus: qcom-ngd-ctrl: Add timeout =
for wait operation)
Merging nvmem/for-next (ea8f9ec2bbb7 nvmem: core: switch to use device_add_=
groups())
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (f2580a907e5c x86/hyperv: Use Hyper-V entropy to=
 seed guest random number generator)
Merging auxdisplay/for-next (93ee235f55d3 auxdisplay: charlcd: Don't rebuil=
d when CONFIG_PANEL_BOOT_MESSAGE=3Dy)
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (813e0ae613d6 bus: mhi: host: Add mhi_power_down_keep_=
dev() API to support system suspend/hibernation)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (ed1ff2fba7af Merge branch 'for-6.9/cxl-einj' into for-6.9=
/cxl)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (bf87a149828e efi: Clear up misconceptions about a maximum=
 variable name size)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (5aa5c7b9a09d mm/slub: remove duplicate initiali=
zation for early_kmem_cache_node_alloc())
Merging random/master (4cece7649650 Linux 6.9-rc1)
Merging landlock/next (028243655456 fs/ioctl: Add a comment to keep the log=
ic in sync with LSM policies)
Merging rust/rust-next (8db31d3f3bd5 rust: workqueue: add `#[pin_data]` to =
`Work`)
Merging sysctl/sysctl-next (4f1136a55dc8 scripts: check-sysctl-docs: handle=
 per-namespace sysctls)
Merging execve/for-next/execve (c82389947d90 tracing: Add sched_prepare_exe=
c tracepoint)
Merging bitmap/bitmap-for-next (fd8ed16c2419 bitmap: Step down as a reviewe=
r)
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (9c573cd31343 randomize_kstack: Improve entropy =
diffusion)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (4cece7649650 Linux 6.9-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (4cece7649650 Linux 6.9-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)
Applying: fixup for "mm: swap: introduce swap_free_nr() for batched swap_fr=
ee()"

--Sig_/VXAxiWpUoDkwCBLhnzLCGI3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYY3iMACgkQAVBC80lX
0GwMVQf/abn+1bo+L8UZaeVMv0LwdX4ctI8UAOUx9zrvgzqZWFuAlCfGsO7yo6ae
dmQlGl2Jb1LJYXkJ9yC6SyB3mQwmcVZKtPdQubSjh03p4aA7jykcbvu36J7FCsEL
EltmHXk+Op0HOebDKrVoI+cqXneWyl8yuPFNngof4YMSeEZyLaGTtoE/0af/IAVt
C0TRKioRWNs0n4qpk6qDlSXGWkmSJIr2BFNvBpXzAn+TbkwzM+pcUrdiOuuAj3kP
UY7xy+7eqHwJVsfcj1idBoRs48Z7GL3JXWczOTarabZHdb++UbGRMGf3DngJ8ZN2
h0sgfQr+u6M76C/Krby41pdf5+JC8w==
=2Abd
-----END PGP SIGNATURE-----

--Sig_/VXAxiWpUoDkwCBLhnzLCGI3--

