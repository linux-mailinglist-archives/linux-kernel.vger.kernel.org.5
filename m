Return-Path: <linux-kernel+bounces-161852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02948B5236
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E82A28140D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22E134B0;
	Mon, 29 Apr 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zsmogzv8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075513AC5;
	Mon, 29 Apr 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375261; cv=none; b=n7f92Oz4uvZ4jgSxgXvhftL5zxdpfUXcZBACl9RHugtTThWHgrbnaXveHzTUZ5McWZ9xENEj7Z53Cb4ArQcofYV6fp/vCh1q9XebcWM7GU9ZcyOJWB+YtlIPS0LGZDKCB4jmZ1OS/7l1KJl0nNRog5JcpvASqBUyNJGXjiZwQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375261; c=relaxed/simple;
	bh=VyilO5Q84VrlRfSI6Ks9YgZZ9renOQrtXWadhoxGB9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n8OYzXpKAL/zjd3TYUPxsOt3BGSjDfjqSpIi4A2OXdVHCNf0X61UJtAPhtFL5yMJoxefwfiL9zM4/6ZAJ7w70t34F7lcPtLIHOgZ77lDR0PksYBv7sRaRaHKd6OmC4JR/aH0bbvCsWBrgNVi6zB8P3lNPprODoxTsaNOeIdBubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Zsmogzv8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714375250;
	bh=LVfw8L89ddcXGpPNYJM1a0wwok2I48Qalmc/4oGfIyw=;
	h=Date:From:To:Cc:Subject:From;
	b=Zsmogzv8Kd0rZCQ6zWxyMECB5V5aKDS3dhwpmP79nDWludrRFRkIHv36lPG8nU1/D
	 Ms0rMkygCWmty5eGiB+lKSuT71xitvjhDq9jbUW62EpaUSfGAC3ji1NF+hIxhvNQCc
	 ghBPBpetJL+cm01vlpjYJ/JW3aDQ/Y6S4WpwkSnoTWyU/WlNUskZM7LqjT39LrgMuW
	 5/OpGiequlcGtaZJTPDHi5/OSsaSpIlodWpaLkkllBpBST9RQMXNBk/HoKiy/fSbUY
	 tJFCy5bdyPlu1y4Ws2cKxQbkAQC0mAUUdQ1NWiM+rIjheXdLztyE1ZQS5Wkog2iRXM
	 8VpkV2dDf4Ymg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSZVp68fyz4wyf;
	Mon, 29 Apr 2024 17:20:50 +1000 (AEST)
Date: Mon, 29 Apr 2024 17:20:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 29
Message-ID: <20240429172049.511167ab@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EVlH8O79F7_fH7B8v1x5Wfq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/EVlH8O79F7_fH7B8v1x5Wfq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240426:

New tree: turbostat

The net-next tree gained a conflict against the mm tree.

The bpf-next tree gained a conflict against the net tree.

The drm-xe tree gained a conflict against the drm tree.

The iommu tree gained a conflict against the pm tree.

The modules tree still has its boot failure for which I applied a
supplied patch.

The random tree gained a conflict against the pm tree.

Non-merge commits (relative to Linus' tree): 8469
 8410 files changed, 563149 insertions(+), 195299 deletions(-)

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

I am currently merging 372 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (e67572cd2204 Linux 6.9-rc6)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (de50568a6bfb mm/vmalloc: fix retu=
rn value of vb_alloc if size is 0)
Merging kbuild-current/fixes (89e5462bb5ae kconfig: Fix typo HEIGTH to HEIG=
HT)
Merging arc-current/for-curr (61231eb8113c ARC: [plat-hsdk]: Remove misplac=
ed interrupt-cells property)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (50449ca66cc5 arm64: hibernate: Fix leve=
l3 translation fault in swsusp_save())
Merging arm-soc-fixes/arm/fixes (daa1bd43e56b Merge tag 'mtk-soc-fixes-for-=
v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux int=
o for-next)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging sophgo-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (210cfef57926 selftests/powerpc/papr-vpd: Fix m=
issing variable initialization)
Merging s390-fixes/fixes (b961ec10b9f9 s390/vdso: Add CFI for RA register t=
o asm macro vdso_func)
Merging fscrypt-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging fsverity-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging net/main (b2ff42c6d3ab Merge tag 'for-netdev' of https://git.kernel=
org/pub/scm/linux/kernel/git/bpf/bpf)
Merging bpf/master (b2ff42c6d3ab Merge tag 'for-netdev' of https://git.kern=
el.org/pub/scm/linux/kernel/git/bpf/bpf)
Merging ipsec/master (8b06a24bb625 xfrm: fix possible derferencing in error=
 path)
Merging netfilter/main (52afb15e9d9a Merge tag 'net-6.9-rc6' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipvs/main (52afb15e9d9a Merge tag 'net-6.9-rc6' of git://git.kernel=
org/pub/scm/linux/kernel/git/netdev/net)
Merging wireless/for-next (52afb15e9d9a Merge tag 'net-6.9-rc6' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (ed30a4a51bb1 Linux 6.9-rc5)
Merging sound-current/for-linus (15c7e87aa88f ALSA: emu10k1: make E-MU FPGA=
 writes potentially more reliable)
Merging sound-asoc-fixes/for-linus (bda16500dd0b ASoC: rt715-sdca: volume s=
tep modification)
Merging regmap-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging regulator-fixes/for-linus (ff33132605c1 regulator: change devm_regu=
lator_get_enable_optional() stub to return Ok)
Merging spi-fixes/for-linus (7430764f5a85 spi: hisi-kunpeng: Delete the dum=
p interface of data registers in debugfs)
Merging pci-current/for-linus (4cece7649650 Linux 6.9-rc1)
Merging driver-core.current/driver-core-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging tty.current/tty-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging usb.current/usb-linus (f2004e82abb6 usb: typec: qcom-pmic: fix pdph=
y start() error handling)
Merging usb-serial-fixes/usb-linus (582ee2f9d268 USB: serial: option: add T=
elit FN920C04 rmnet compositions)
Merging phy/fixes (bf6e4ee5c436 phy: ti: tusb1210: Resolve charger-det cras=
h if charger psy is unregistered)
Merging staging.current/staging-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging iio-fixes/fixes-togreg (d7230b995246 iio: invensense: fix timestamp=
 glitches when switching frequency)
Merging counter-current/counter-current (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc.current/char-misc-linus (4108a30f1097 mei: me: add lunar =
lake point M DID)
Merging soundwire-fixes/fixes (63dc588e7af1 soundwire: amd: fix for wake in=
terrupt handling for clockstop mode)
Merging thunderbolt-fixes/fixes (ed30a4a51bb1 Linux 6.9-rc5)
Merging input-current/for-linus (be81415a32ef Input: xpad - add support for=
 ASUS ROG RAIKIRI)
Merging crypto-current/master (5a7e89d3315d crypto: iaa - Fix nr_cpus < nr_=
iaa case)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (72d7cb5c190b selftests/harness: Prevent infi=
nite loop due to Assert in FIXTURE_TEARDOWN)
Merging dmaengine-fixes/fixes (f221033f5c24 dmaengine: idxd: Fix oops durin=
g rmmod on single-CPU platforms)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (d2d73a6dd173 mtd: limit OTP NVMEM cell parse t=
o non-NAND devices)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (d353c3c34af0 media: mediatek: vcodec: support =
36 bits physical address)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (0bbac3facb5d Linux 6.9-rc4)
Merging at91-fixes/at91-fixes (1fe5e0a31e62 ARM: dts: microchip: at91-sama7=
g54_curiosity: Replace regulator-suspend-voltage with the valid property)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (44ecfa3e5f1c Merge branch 'svm' of https://github=
com/kvm-x86/linux into HEAD)
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (4cece7649650 Linux 6.9-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (4b759dd57655 cxl/core: Fix potential payload size =
confusion in cxl_mem_get_poison())
Merging btrfs-fixes/next-fixes (3550bc7dc848 Merge branch 'misc-6.9' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (f609e7b1b49e platform/x86/amd/pmc: Extend =
Framework 13 quirk to more BIOSes)
Merging samsung-krzk-fixes/fixes (da244c16ac58 clk: samsung: Revert "clk: U=
se device_get_match_data()")
Merging pinctrl-samsung-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging devicetree-fixes/dt/linus (dab6bc78e981 of: module: add buffer over=
flow check in of_modalias())
Merging dt-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging scsi-fixes/fixes (961990efc608 scsi: sd: Only print updates to perm=
anent stream count)
Merging drm-fixes/drm-fixes (3a8534035c07 Merge tag 'drm-xe-fixes-2024-04-2=
5' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (ed30a4a51bb1 Linux 6.9-rc5)
Merging mmc-fixes/fixes (e027e72ecc16 mmc: moxart: fix handling of sgm->con=
sumed, otherwise WARN_ON triggers)
Merging rtc-fixes/rtc-fixes (4cece7649650 Linux 6.9-rc1)
Merging gnss-fixes/gnss-linus (0bbac3facb5d Linux 6.9-rc4)
Merging hyperv-fixes/hyperv-fixes (fb836d64a2ea hv/vmbus_drv: rename hv_acp=
i_init() to vmbus_init())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (6beb6bc5a81e Merge patch series "RISC-V: Test t=
h.sxstatus.MAEE bit before enabling MAEE")
Merging riscv-dt-fixes/riscv-dt-fixes (e0503d47e93d riscv: dts: starfive: v=
isionfive 2: Remove non-existing I2S hardware)
Merging riscv-soc-fixes/riscv-soc-fixes (3aa20d1f7bcb firmware: microchip: =
clarify that sizes and addresses are in hex)
Merging fpga-fixes/fixes (54435d1f21b3 fpga: dfl-pci: add PCI subdevice ID =
for Intel D5005 card)
Merging spdx/spdx-linus (4cece7649650 Linux 6.9-rc1)
Merging gpio-brgl-fixes/gpio/for-current (c714fcdf5b75 Merge tag 'intel-gpi=
o-v6.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-=
intel into gpio/for-current)
Merging gpio-intel-fixes/fixes (7d045025a24b gpio: tangier: Use correct typ=
e for the IRQ chip data)
Merging pinctrl-intel-fixes/fixes (5d10a157ebe0 pinctrl: baytrail: Add pinc=
onf group for uart3)
Merging auxdisplay-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging erofs-fixes/fixes (7af2ae1b1531 erofs: reliably distinguish block b=
ased and fscache mode)
Merging kunit-fixes/kunit-fixes (cfedfb24c9dd kunit: configs: Enable CONFIG=
_DAMON_DBGFS_DEPRECATED for --alltests)
Merging memblock-fixes/fixes (592447f6cb3c memblock tests: fix undefined re=
ference to `BIT')
Merging nfsd-fixes/nfsd-fixes (18180a4550d0 NFSD: Fix nfsd4_encode_fattr4()=
 crasher)
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (1cebd7f74976 tools/include: Sync arm64 asm=
/cputype.h with the kernel sources)
Merging efi-fixes/urgent (1c5a1627f481 efi/unaccepted: touch soft lockup du=
ring memory accept)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (1e0fb1136461 power: supply: mt6360_charger: Fi=
x of_match for usb-otg-vbus regulator)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (2760c51b8040 iommufd: Add config needed for i=
ommufd_fail_nth)
Merging rust-fixes/rust-fixes (19843452dca4 rust: remove `params` from `mod=
ule` macro example)
Merging v9fs-fixes/fixes/next (d05dcfdf5e16  fs/9p: mitigate inode collisio=
ns)
Merging w1-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pmdomain-fixes/fixes (39cd87c4eb2b Linux 6.9-rc2)
Merging overlayfs-fixes/ovl-fixes (77a28aa47687 ovl: relax WARN_ON in ovl_v=
erify_area())
Merging i2c-host-fixes/i2c/i2c-host-fixes (ed30a4a51bb1 Linux 6.9-rc5)
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging clk-fixes/clk-fixes (f8981b0d5295 Merge tag 'qcom-clk-fixes-for-6.9=
' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fi=
xes)
Merging drm-misc-fixes/for-linux-next-fixes (27906e5d7824 drm/ttm: Print th=
e memory decryption status just once)
Merging mm-stable/mm-stable (72801513b2bf mm: set pageblock_order to HPAGE_=
PMD_ORDER in case with !CONFIG_HUGETLB_PAGE but THP enabled)
Merging mm-nonmm-stable/mm-nonmm-stable (95982a76bb50 crash: add prefix for=
 crash dumping messages)
  14c7095a68e0 ("LoongArch/tlb: fix "error: parameter 'ptep' set but not us=
ed" due to __tlb_remove_tlb_entry()")
Merging mm/mm-everything (0e7486112abe foo)
Merging kbuild/for-next (060ef2b42249 kconfig: remove 'optional' property s=
upport)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (8c618b58c89c perf test: Reintroduce -p/--para=
llel and make -S/--sequential the default)
  cd88c11c6d89 ("tools lib rbtree: Pick some improvements from the kernel r=
btree code")
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (a1255ccab8ec swiotlb: do not set total_used t=
o 0 in swiotlb_create_debugfs_files())
Merging asm-generic/master (5394f1e9b687 arch: define CONFIG_PAGE_SIZE_*KB =
on all architectures)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (5616fee8981b Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (7befe2ef9384 Merge branches 'for-next/acpi', '=
for-next/kbuild', 'for-next/misc', 'for-next/mm', 'for-next/perf' and 'for-=
next/tlbi' into for-next/core)
Merging arm-perf/for-next/perf (4052ce07d5d7 perf/arm-spe: Assign parents f=
or event_source device)
Merging arm-soc/for-next (daa1bd43e56b Merge tag 'mtk-soc-fixes-for-v6.9' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into for-n=
ext)
Merging amlogic/for-next (2b952b1d0a54 Merge branch 'v6.10/defconfig' into =
for-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (fa8e55345b64 Merge branch 'microchip-dt64' into at9=
1-next)
Merging broadcom/next (3d83aa97a6f7 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (bf11908757ee memory: mtk-smi: fix module a=
utoloading)
Merging imx-mxs/for-next (8c4bf8c96748 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (086035cda928 arm64: dts: mediatek: mt8188: add l=
vts definitions)
  244490a729c6 ("soc: mediatek: mtk-svs: Append "-thermal" to thermal zone =
names")
  a452af6b1e66 ("soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS")
Merging mvebu/for-next (058bfa0ead87 arm64: dts: marvell: cn9130-crb: drop =
unneeded "status")
Merging omap/for-next (5856330c3d56 Merge branch 'drivers-ti-sysc-for-v6.10=
' into for-next)
Merging qcom/for-next (99376e9b6f12 Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-fixes-for-6.9', 'arm64-for-6.10', 'clk-fixes-f=
or-6.9', 'clk-for-6.10', 'drivers-fixes-for-6.9' and 'drivers-for-6.10' int=
o for-next)
Merging renesas/next (1e2995ef0bb8 Merge branch 'renesas-dts-for-v6.10' int=
o renesas-next)
Merging reset/reset/next (6d89df61650d reset: ti-sci: Convert to platform r=
emove callback returning void)
Merging rockchip/for-next (8dabf52bd8db Merge branch 'v6.10-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (f19aa4422b2c Merge branch 'fixes' into for-n=
ext)
Merging scmi/for-linux-next (146928437fcb Merge tags 'scmi-updates-6.10' an=
d 'ffa-updates-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/sudee=
p.holla/linux into for-linux-next)
Merging sophgo/for-next (1eba0b61be72 riscv: dts: sophgo: add reserved memo=
ry node for CV1800B)
Merging stm32/stm32-next (dccdbccb7045 arm64: dts: st: correct masks for GI=
C PPI interrupts on stm32mp25)
Merging sunxi/sunxi/for-next (547c853141d1 Merge branch 'sunxi/dt-for-6.10'=
 into sunxi/for-next)
Merging tee/next (60757f1264a2 Merge branch 'tee_ts_for_v6.10' into next)
Merging tegra/for-next (2fd759c1796c Merge branch for-6.10/arm64/defconfig =
into for-next)
Merging ti/ti-next (4c4ee097c795 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-dts-next' and 'ti-keystone-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (92e92dc84e17 Merge branch 'clk-scmi' into clk-next)
Merging clk-imx/for-next (5224b189462f clk: imx: add i.MX95 BLK CTL clk dri=
ver)
Merging clk-renesas/renesas-clk (5add5ebc4e35 clk: renesas: r9a08g045: Add =
support for power domains)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (f3334ebb8a2a LoongArch: Lately init pmu a=
fter smp is online)
Merging m68k/for-next (70d830e337f9 m68k: Calculate THREAD_SIZE from THREAD=
_SIZE_ORDER)
Merging m68knommu/for-next (2a92aed55942 m68k: Avoid CONFIG_COLDFIRE switch=
 in uapi header)
Merging microblaze/next (58d647506c92 microblaze: Remove early printk call =
from cpuinfo-static.c)
Merging mips/mips-next (40e20fbccfb7 MIPS: SGI-IP27: micro-optimize arch_in=
it_irq())
Merging openrisc/for-next (4dc70e1aadfa openrisc: Move FPU state out of pt_=
regs)
Merging parisc-hd/for-next (ce25c853020c parisc: Move sigset_t typedef to p=
arisc uapi header)
Merging powerpc/next (f318c8be797f powerpc/ptdump: Fix walk_vmemmap() to al=
so print first vmemmap entry)
Merging powerpc-kdump-hotplug/topic/kdump-hotplug (849599b702ef powerpc/cra=
sh: add crash memory hotplug support)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0a16a1728790 riscv: select ARCH_HAS_FAST_MULTIPLIE=
R)
CONFLICT (content): Merge conflict in Documentation/rust/arch-support.rst
Merging riscv-dt/riscv-dt-for-next (d866a7ef7a6e riscv: dts: thead: Fix nod=
e ordering in TH1520 device tree)
CONFLICT (content): Merge conflict in arch/riscv/Makefile
Merging riscv-soc/riscv-soc-for-next (16d9122246cc Merge branch 'riscv-conf=
ig' into riscv-soc-for-next)
Merging s390/for-next (cd67fe6dd7fc Merge branch 'shared-zeropage' into for=
-next)
Merging sh/for-next (4cece7649650 Linux 6.9-rc1)
Merging sparc/for-next (48d85acdaa52 sparc: chmc: Convert to platform remov=
e callback returning void)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (11cca8ccf2c3 tty: xtensa/iss: Use min() to =
fix Coccinelle warning)
Merging bcachefs/for-next (59ac1888a9c6 bcachefs: uninline set_btree_iter_d=
ontneed())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (d0af553021b4 Merge branch 'for-next-next-v6.9-20240=
425' into for-next-20240425)
Merging ceph/master (d3e046930679 MAINTAINERS: remove myself as a Reviewer =
for Ceph)
Merging cifs/for-next (8f03ed91d75e smb: smb2pdu.h: Avoid -Wflex-array-memb=
er-not-at-end warnings)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging erofs/dev (b351756059e3 erofs: derive fsid from on-disk UUID for .s=
tatfs() if possible)
Merging exfat/dev (f19257997d9c exfat: zero the reserved fields of file and=
 stream extension dentries)
Merging exportfs/exportfs-next (e8f897f4afef Linux 6.8)
Merging ext3/for_next (7ca906c7f7e5 Pull ext2 and isofs removal to PageErro=
r bit.)
Merging ext4/dev (0ecae5410ab5 ext4: initialize sbi->s_freeclusters_counter=
 and sbi->s_dirtyclusters_counter before use in kunit test)
Merging f2fs/dev (3763f9effcdc f2fs: use helper to print zone condition)
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (fa7e19337908 fuse: Add initial support for fs-verity)
Merging gfs2/for-next (1e86044402c4 gfs2: Remove and replace gfs2_glock_que=
ue_work)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (e67572cd2204 Linux 6.9-rc6)
Merging nfs/linux-next (24457f1be29f nfs: Handle error of rpc_proc_register=
() in nfs_net_init().)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (06cd86b25b98 SUNRPC: Remove comment for sp_lock)
Merging ntfs3/master (24f6f5020b0b fs/ntfs3: Mark volume as dirty if xattr =
is broken)
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (b8a77b9a5f9c mtd: ubi: fix NVMEM over UBI volumes on 32=
-bit systems)
Merging v9fs/9p-next (2a0505cdd8c8 9p: remove SLAB_MEM_SPREAD flag usage)
Merging v9fs-ericvh/ericvh/for-next (4cece7649650 Linux 6.9-rc1)
Merging xfs/for-next (08e012a62de8 xfs: Remove unused function xrep_dir_sel=
f_parent)
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
Merging vfs-brauner/vfs.all (eea3260250ea Merge branch 'vfs.iomap' into vfs=
all)
Merging vfs/for-next (7c98f7cb8fda remove call_{read,write}_iter() function=
s)
Merging printk/for-next (a2b4cab9da77 Merge branch 'for-6.10' into for-next)
Merging pci/next (ccd0bdb57e31 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (9dd12ed95c2d pstore/blk: replace deprecated=
 strncpy with strscpy)
Merging hid/for-next (d82775b90601 Merge branch 'for-6.10/sony' into for-ne=
xt)
Merging i2c/i2c/for-next (5deb5b56bccb i2c: smbus: fix NULL function pointe=
r dereference)
Merging i2c-host/i2c/i2c-host (8d49135d177d i2c: thunderx: Adding ioclk sup=
port)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging dmi/dmi-for-next (cf770af5645a firmware: dmi-id: add a release call=
back function)
Merging hwmon-staging/hwmon-next (2ba3ec0d5d4a hwmon: (nzxt-kraken3) Add su=
pport for NZXT Kraken 2023 (standard and Elite) models)
Merging jc_docs/docs-next (fcb5bcefdbfb Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (71b3ed53b08d media: atomisp: Implement link_setup()=
 op for ISP subdev MC entity)
Merging v4l-dvb-next/master (eb005c801ec7 media: mediatek: vcodec: Only fre=
e buffer VA that is not NULL)
Merging pm/linux-next (e4bf39aed884 Merge branches 'acpi-tools', 'acpi-prop=
erty' and 'acpi-docs' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (fde234239d16 dt-bindings: cpufr=
eq: cpufreq-qcom-hw: Add SM4450 compatibles)
Merging cpupower/cpupower (4cece7649650 Linux 6.9-rc1)
Merging devfreq/devfreq-next (6f3c0cfe2aa5 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (0cebf7cb2d70 pmdomain: core: Don't clear suspended_c=
ount at genpd_prepare())
Merging opp/opp/linux-next (4cece7649650 Linux 6.9-rc1)
Merging thermal/thermal/linux-next (734b5def91b5 thermal/drivers/loongson2:=
 Add Loongson-2K2000 support)
Merging dlm/next (7b72ab2c6a46 dlm: return -ENOMEM if ls_recover_buf fails)
Merging rdma/for-next (f88320b698ad RDMA/mana_ib: Fix missing ret value)
Merging net-next/main (5c4c0edca68a tools: ynl: don't append doc of missing=
 type directly to the type)
CONFLICT (content): Merge conflict in drivers/of/property.c
CONFLICT (content): Merge conflict in include/linux/slab.h
Merging bpf-next/for-next (6e25bcf06af0 bpf_helpers.h: Define bpf_tail_call=
_static when building with GCC)
CONFLICT (content): Merge conflict in include/linux/filter.h
CONFLICT (content): Merge conflict in kernel/bpf/core.c
Merging ipsec-next/master (aeb48a428d7d udpencap: Remove Obsolete UDP_ENCAP=
_ESPINUDP_NON_IKE Support)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (0a0f9014b784 Bluetooth: qca: fix wcn3991 device a=
ddress check)
CONFLICT (content): Merge conflict in drivers/bluetooth/btqca.c
Merging wireless-next/for-next (cc1380dd1882 wifi: brcmfmac: remove unused =
brcmf_usb_image struct)
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (6277967d872e mtd: mchp23k256: drop unneeded MODULE_AL=
IAS)
Merging nand/nand/next (6819db94e1cd mtd: rawnand: hynix: fixed typo)
Merging spi-nor/spi-nor/next (4cece7649650 Linux 6.9-rc1)
Merging crypto/master (ed265f7fd9a6 crypto: x86/aes-gcm - simplify GCM hash=
 subkey derivation)
Merging drm/drm-next (2236a61bd491 Merge tag 'mediatek-drm-next-6.10' of ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-n=
ext)
  22bf0bc04d27 ("drm/xe: call free_gsc_pkt only once on action add failure")
  6e7a41762479 ("drm/amd/display: Set color_mgmt_changed to true on unsuspe=
nd")
  7e38ccb5276f ("drm/amdkfd: Fix eviction fence handling")
  81bf14519a8c ("drm/amdkfd: make sure VM is ready for updating operations")
  a99641e38704 ("drm/xe: Remove sysfs only once on action add failure")
  e53a1713de31 ("drm/amdgpu: Fix leak when GPU memory allocation fails")
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_guc_ct.c
Merging drm-exynos/for-linux-next (2236a61bd491 Merge tag 'mediatek-drm-nex=
t-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/lin=
ux into drm-next)
Merging drm-misc/for-linux-next (c72211751870 drm: xlnx: zynqmp_dpsub: Fix =
compilation error)
Merging amdgpu/drm-next (aa463cc850c4 drm/amd/display: Fix CFLAGS for dml2_=
core_dcn4_calcs.o)
  2476c6bd950e ("drm/amdgpu/vpe: fix vpe dpm setup failed")
  26de73bc0a73 ("drm/amdgpu: Fix the ring buffer size for queue VM flush")
  63335b383a0a ("drm/amdkfd: Add VRAM accounting for SVM migration")
  69bc7a8a61aa ("drm/amdgpu/pm: Remove gpu_od if it's an empty directory")
  7b19f1f3466f ("drm/amdgpu: Assign correct bits for SDMA HDP flush")
  a522ec528cc7 ("drm/amdgpu/umsch: don't execute umsch test when GPU is in =
reset/suspend")
  e0a9bbeea002 ("drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3")
  e76691f45a60 ("drm/amdgpu: Update BO eviction priorities")
  f88da7fbf665 ("drm/amdgpu/mes: fix use-after-free issue")
  f989ecccdf6b ("drm/amdkfd: Fix rescheduling of restore worker")
  fa7bb2cac0f7 ("drm/amd/pm: Restore config space after reset")
Merging drm-intel/for-linux-next (b55f3bbab891 drm/{i915, xe}: Implement fb=
dev emulation as in-kernel client)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (104e548a7c97 drm/msm/mdp4: use drmm-managed alloc=
ation for mdp4_plane)
Merging drm-msm-lumag/msm-next-lumag (104e548a7c97 drm/msm/mdp4: use drmm-m=
anaged allocation for mdp4_plane)
Merging drm-xe/drm-xe-next (98ad158e5434 drm/xe: Delete PT update selftest)
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/compat-i915-header=
s/i915_drv.h
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (ce4a7ae84a58 fbdev: offb: replace of_node_put with =
__free(device_node))
Merging regmap/for-next (991b5e2aad87 regmap: kunit: Fix an NULL vs IS_ERR(=
) check)
Merging sound/for-next (6b844f0626fc Merge branch 'topic/emu10k1-fix' into =
for-next)
Merging ieee1394/for-next (a3d0ba225eb1 firewire: core: replace local macro=
s with common inline functions for isochronous packet header)
Merging sound-asoc/for-next (efdfbbc4dcc8 Merge remote-tracking branch 'aso=
c/for-6.10' into asoc-next)
Merging modules/modules-next (fe0f5056b4fa bpf: remove CONFIG_BPF_JIT depen=
dency on CONFIG_MODULES of)
CONFLICT (content): Merge conflict in arch/powerpc/mm/mem.c
CONFLICT (content): Merge conflict in kernel/module/main.c
Applying: linux-next: boot failure after merge of the modules tree
Merging input/next (9e0631695eac input: pm8xxx-vibrator: add new SPMI vibra=
tor support)
Merging block/for-next (518f377c90e5 Merge branch 'for-6.10/io_uring' into =
for-next)
CONFLICT (content): Merge conflict in io_uring/io_uring.c
CONFLICT (content): Merge conflict in io_uring/rw.c
Applying: fix up for "mm: switch mm->get_unmapped_area() to a flag"
Merging device-mapper/for-next (83637d9017b2 dm-crypt: don't set WQ_CPU_INT=
ENSIVE for WQ_UNBOUND crypt_queue)
Merging libata/for-next (9e6938e14ea5 ata: libata-core: Remove ata_exec_int=
ernal_sg())
Merging pcmcia/pcmcia-next (ccae53aa8aa2 pcmcia: cs: make pcmcia_socket_cla=
ss constant)
Merging mmc/next (e38063b94324 mmc: atmel-mci: Switch to use dev_err_probe(=
))
Merging mfd/for-mfd-next (0398a09c7b13 mfd: bd71828: Remove commented code =
lines)
CONFLICT (content): Merge conflict in drivers/mfd/intel-lpss-pci.c
Merging backlight/for-backlight-next (df012cf5c42e backlight: otm3225a: Dro=
p driver owner assignment)
Merging battery/for-next (50f0ff7c8cc4 power: supply: bq27xxx: Move health =
reading out of update loop)
Merging regulator/for-next (84c1815e46bd Merge remote-tracking branch 'regu=
lator/for-6.10' into regulator-next)
Merging security/next (74560bb3685b lsm: remove the now superfluous sentine=
l element from ctl_table array)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (9fa8e7625008 ima: add crypto agility supp=
ort for template-hash algorithm)
Merging selinux/next (d6fc1ee0b6c1 Automated merge of 'dev' into 'next')
Merging smack/next (69b6d71052b5 Smack: use init_task_smack() in smack_cred=
_transfer())
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (3c6e94beeacd Documentation: tpm_tis)
Merging watchdog/master (0bbac3facb5d Linux 6.9-rc4)
Merging iommu/next (ef6e717d93c7 Merge branches 'arm/renesas', 'x86/amd', '=
core' and 'x86/vt-d' into next)
CONFLICT (content): Merge conflict in drivers/acpi/scan.c
CONFLICT (content): Merge conflict in drivers/iommu/amd/amd_iommu.h
Merging audit/next (4cece7649650 Linux 6.9-rc1)
Merging devicetree/for-next (669430b183fc of: property: fw_devlink: Add sup=
port for "power-supplies" binding)
CONFLICT (content): Merge conflict in drivers/of/dynamic.c
CONFLICT (content): Merge conflict in drivers/of/property.c
Merging dt-krzk/for-next (3d679a406f3a Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (83deebfc4b1a Merge remote-tracking branch 'spi/for-6.=
10' into spi-next)
Merging tip/master (0a2f1c12ac13 Merge branch into tip/master: 'x86/shstk')
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/st/stm32mp251.dtsi
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (03db22b93a01 Merge ras/edac-urgent into for-nex=
t)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (b93b7b4635f1 ftrace: Asynchronous grace period for re=
gister_ftrace_direct())
CONFLICT (content): Merge conflict in arch/Kconfig
Merging kvm/next (a96cb3bf390e Merge x86 bugfixes from Linux 6.9-rc3)
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/svm.c
Merging kvm-arm/next (135c8fabdedd Merge branch kvm-arm64/lpi-xa-cache into=
 kvmarm-master/next)
Merging kvms390/next (39cd87c4eb2b Linux 6.9-rc2)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (5ef2f3d4e747 KVM: riscv: selftests: Add c=
ommandline option for SBI PMU test)
Merging kvm-x86/next (7b076c6a308e Merge branches 'fixes', 'generic', 'misc=
', 'mmu', 'selftests' and 'vmx')
Merging xen-tip/linux-next (d277f9d82802 xen/events: increment refcnt only =
if event channel is refcounted)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (24283babc61f Merge branch 'for-6.9-fixes' into=
 for-next)
Merging drivers-x86/for-next (88c0ef69dd88 platform/x86: asus-wmi: cleanup =
main struct to avoid some holes)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging chrome-platform/for-next (c8f460d991df platform/chrome: cros_ec_lpc=
: add quirks for the Framework Laptop (AMD))
Merging chrome-platform-firmware/for-firmware-next (7f20f21c22aa firmware: =
google: cbmem: drop driver owner initialization)
Merging hsi/for-next (c076486b6a28 HSI: omap_ssi_port: Convert to platform =
remove callback returning void)
Merging leds-lj/for-leds-next (fd05e3698649 leds: mt6360: Fix the second LE=
D can not enable torch mode by V4L2)
Merging ipmi/for-next (999dff3c1393 ipmi: kcs_bmc_npcm7xx: Convert to platf=
orm remove callback returning void)
Merging driver-core/driver-core-next (e5019b14230a Merge 6.9-rc5 into drive=
r-core-next)
Merging usb/usb-next (3f12222a4beb usb: dwc3: core: Fix compile warning on =
s390 gcc in dwc3_get_phy call)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/core.c
Applying: fix up for "usb: misc: onboard_hub: rename to onboard_dev"
Merging thunderbolt/next (a3dc6d82de9b thunderbolt: Correct trace output of=
 firmware connection manager packets)
Merging usb-serial/usb-next (39cd87c4eb2b Linux 6.9-rc2)
Merging tty/tty-next (660a70809856 Merge 6.9-rc5 into tty-next)
CONFLICT (content): Merge conflict in include/linux/kfifo.h
CONFLICT (content): Merge conflict in lib/kfifo.c
Merging char-misc/char-misc-next (e22810ab3f5e mei: bus: constify the struc=
t mei_cl_bus_type usage)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (ba8c06fe7e16 coresight: tpiu: Convert to platform r=
emove callback returning void)
Merging fastrpc/for-next (4cece7649650 Linux 6.9-rc1)
Merging fpga/for-next (b7c0e1ecee40 fpga: region: add owner module and take=
 its refcount)
Merging icc/icc-next (230d05b1179f interconnect: qcom: qcm2290: Fix mas_sno=
c_bimc QoS port assignment)
Merging iio/togreg (b80ad8e3cd27 iio: adc: ti-ads131e08: Use device_for_eac=
h_child_node_scoped() to simplify error paths.)
Merging phy-next/next (9c79b779643e phy: rockchip: fix CONFIG_TYPEC depende=
ncy)
Merging soundwire/next (a36ec5f7625d soundwire: intel_ace2x: simplify check=
_wake())
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (0bbac3facb5d Linux 6.9-rc4)
Merging vfio/next (82b951e6fbd3 vfio/pci: fix potential memory leak in vfio=
_intx_enable())
Merging w1/for-next (cde37a5bdb0e w1: gpio: Don't use "proxy" headers)
Merging spmi/spmi-next (ee2098c0b512 spmi: pmic-arb: Add multi bus support)
Merging staging/staging-next (75ff53c44f5e staging: vc04_services: Drop com=
pleted TODO item)
Merging counter-next/counter-next (89d5d9e95008 counter: Don't use "proxy" =
headers)
Merging siox/siox/for-next (db418d5f1ca5 siox: bus-gpio: Simplify using dev=
m_siox_* functions)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (700b2e1eccb4 dmaengine: xilinx: xdma: fix module au=
toloading)
Merging cgroup/for-next (b7d56d953a67 cgroup/cpuset: Remove outdated commen=
t in sched_partition_write())
Merging scsi/for-next (8c5220c43ba0 Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in block/blk-settings.c
CONFLICT (content): Merge conflict in include/linux/blkdev.h
Merging scsi-mkp/for-next (aca061774bc4 scsi: mpi3mr: Fix some kernel-doc w=
arnings in scsi_bsg_mpi3mr.h)
Merging vhost/linux-next (24ddee0ff8c3 Merge tag 'stable/vduse-virtio-net' =
into vhost)
CONFLICT (content): Merge conflict in drivers/virtio/virtio_mem.c
Merging rpmsg/for-next (87f678f813d9 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (5539287ca656 gpio: brcmstb: add support fo=
r gpio-ranges)
Merging gpio-intel/for-next (ecc4b1418e23 gpio: Add Intel Granite Rapids-D =
vGPIO driver)
Merging pinctrl/for-next (f3953d6d4f60 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (5d10a157ebe0 pinctrl: baytrail: Add pinconf=
 group for uart3)
Merging pinctrl-renesas/renesas-pinctrl (cd27553b0dee pinctrl: renesas: rzg=
2l: Limit 2.5V power supply to Ethernet interfaces)
Merging pinctrl-samsung/for-next (4184e4912ca6 dt-bindings: pinctrl: samsun=
g: drop unused header with register constants)
Merging pwm/pwm/for-next (6144744bb9a8 pwm: meson: Use mul_u64_u64_div_u64(=
) for frequency calculating)
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (693fe2f6a9ea selftests: kselftest: Make ksft_exit f=
unctions return void instead of int)
CONFLICT (content): Merge conflict in tools/testing/selftests/mm/soft-dirty=
c
Merging kunit/test (4cece7649650 Linux 6.9-rc1)
Merging kunit-next/kunit (aa892c2e7919 kunit: string-stream-test: use KUNIT=
_DEFINE_ACTION_WRAPPER)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (1c431b92e21b dt-bindings: rtc: convert trivial device=
s into dtschema)
Merging nvdimm/libnvdimm-for-next (41147b006be2 dax: remove redundant assig=
nment to variable rc)
  57456adef68d ("ndtest: Convert to platform remove callback returning void=
")
Merging at24/at24/for-next (4cece7649650 Linux 6.9-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (39cd87c4eb2b Linux 6.9-rc2)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (b12bd525ca6e slimbus: qcom-ngd-ctrl: Add timeout =
for wait operation)
Merging nvmem/for-next (9e29a1dba59b nvmem: meson-mx-efuse: Remove nvmem_de=
vice from efuse struct)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (f2580a907e5c x86/hyperv: Use Hyper-V entropy to=
 seed guest random number generator)
Merging auxdisplay/for-next (93ee235f55d3 auxdisplay: charlcd: Don't rebuil=
d when CONFIG_PANEL_BOOT_MESSAGE=3Dy)
Merging kgdb/kgdb/for-next (b2aba15ad6f9 serial: kgdboc: Fix NMI-safety pro=
blems from keyboard reset code)
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (48f98496b1de bus: mhi: host: pci_generic: Add generic=
 edl_trigger to allow devices to enter EDL mode)
Merging memblock/for-next (e5d1fdecfaf8 mm/memblock: remove empty dummy ent=
ry)
Merging cxl/next (62dba604a488 cxl/hdm: Debug, use decoder name function)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (cda30c6542c8 efi: Clear up misconceptions about a maximum=
 variable name size)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (b3d8a8e87014 slub: use count_partial_free_appro=
x() in slab_out_of_memory())
Merging random/master (7b1bcd6b50a6 virt: vmgenid: add support for devicetr=
ee bindings)
CONFLICT (content): Merge conflict in drivers/virt/vmgenid.c
Merging landlock/next (dc792a74600a fs/ioctl: Add a comment to keep the log=
ic in sync with LSM policies)
Merging rust/rust-next (2c1092853f16 rust: kernel: remove usage of `allocat=
or_api` unstable feature)
Merging sysctl/sysctl-next (a35dd3a786f5 sysctl: drop now unnecessary out-o=
f-bounds check)
Merging execve/for-next/execve (10e29251be0e binfmt_elf_fdpic: fix /proc/<p=
id>/auxv)
Merging bitmap/bitmap-for-next (36a71c558b3e sched/topology: Optimize topol=
ogy_span_sane())
Merging hte/for-next (297f26dbf870 hte: tegra-194: Convert to platform remo=
ve callback returning void)
Merging kspp/for-next/kspp (99803fb635e4 hardening: Refresh KCFI options, a=
dd some more)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (0adab2b6b733 tools/nolibc: add support for uname(2))
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (4cece7649650 Linux 6.9-rc1)
Merging turbostat/next (c9d066401193 tools/power turbostat: version 2024.04=
27)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/EVlH8O79F7_fH7B8v1x5Wfq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYvSlEACgkQAVBC80lX
0GxxdQf+KDNcdBDWYCL5oXD8AhxKfdeJKDloT81em9GwZFLwYmwSNbgP5+x6ZdRL
BLd5KPw46v9nnJeuq2ZoiYydTvFEEoInmam+dZ48bmKCbQsQmDMoIfXGePdhy5rS
Ee7s/l9+fxBd40+GCS05ed98YxpDgdC+axPpUbJ3QckkoAMBvjoak8tYBUNDxJyG
xy5G+Ub9zsdwBUbVO6JbxhcehyFaei85B+hSPkh/BA3zl580E2ccG0kOSBhN1SCh
39BeFLlejx+8Ue/OQsipgiIh8UNiDOK8dx9IdOpM49GTuaZDttLXYYtMrs+o9w66
6KjUqkLw69fMz1fRDKsyFjNZwP4piw==
=8HWO
-----END PGP SIGNATURE-----

--Sig_/EVlH8O79F7_fH7B8v1x5Wfq--

