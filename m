Return-Path: <linux-kernel+bounces-167308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DC8BA787
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7E21C217F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085E147C78;
	Fri,  3 May 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q5zKOiQ3"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AF1474C6;
	Fri,  3 May 2024 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720682; cv=none; b=Cj2wCXj97FLJtBdw/XNJkjVkB1DsK8GlmN5oXsCh20DOTJug0Xlz60o9eNsdkEjExIGwFVsQF/ozaA+nuDe0E+kdVcQKZvCGnBaHoLz85fAPNwIJkAaI0T9sPu10Yx5k1mP13Ecl3oqRAm3fiVTFqnOS25aBH5gAQT6vZc9QrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720682; c=relaxed/simple;
	bh=5m/rU0sfcd2y7jIELjF3d/d2OQjC0VaAXR1kHvS5ZvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gTMqZDAuRr8nr4cazt/Dh3qjbUZ3reLEsL/zx/83LhksTyAWgSHuws64A+oVM//2bNFOUdOoO+/4Rjes/BKTIPMaQJUVqrRN6+FV9ccHxWZlhcChFyideuP511LK9RABcUUQzFXhKdpt+VfY0lT9AzWzbOfXFYGOho2XvZv4HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Q5zKOiQ3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714720676;
	bh=NulGWgKFKlCWNNX0lr1f4mtsdDHQU+EYdjXHpZqGuNw=;
	h=Date:From:To:Cc:Subject:From;
	b=Q5zKOiQ37uv7SIShkpw6xfdePpaBkaeHqO2fzAX7R+hAneyQCrB5JcOy3gfX6UgWf
	 kfkQBHpjLxCDaFDslOAzQAr4gMc5ekc8FXFZs4yV4VykgNLBKh1lwebjgn04oO/YPk
	 fgxiwMy7r/hbb3ZJG5i3vRwdKpEVrArKv6AyoGjfBaopUe19sQ2rE6BTSWCB9ONkr3
	 JdHcCcks78hN5mN2H/lfdb5GcgWjT3bJ/hNrRikraJVOdeGvINSPDrI5Ca3o0eTCmd
	 +A52IR73pyKReLOPgKB2CSSEU4GlJdGIcSyfj5Evu8fTSO69nbSC/FKwu7AuIyrEfv
	 GlKpDtVNfQviw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW2Fc17Xrz4wyq;
	Fri,  3 May 2024 17:17:56 +1000 (AEST)
Date: Fri, 3 May 2024 17:17:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 3
Message-ID: <20240503171752.5dbcce9c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T7Nmxa.AXbbHYWO9KkdNmxk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/T7Nmxa.AXbbHYWO9KkdNmxk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240502:

The mm tree still had its build failure for which I revreted 2 commits.

The arm tree gained a build failure, so I used the version from
next-20240502.

The vfs-brauner tree gained a conflict against the btrfs tree.

The v4l-dvb-next tree still had its build failure so I used the version
from next-20240430.

The dmi tree still had its build failure for which I reverted a commit.

The bitmap tree gained a conflict against the mm tree.

Non-merge commits (relative to Linus' tree): 9804
 9482 files changed, 680592 insertions(+), 239314 deletions(-)

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

I am currently merging 373 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (bcf28f9e63d4 selftests/vDSO: fix =
runtime errors on LoongArch)
Merging kbuild-current/fixes (89e5462bb5ae kconfig: Fix typo HEIGTH to HEIG=
HT)
Merging arc-current/for-curr (e67572cd2204 Linux 6.9-rc6)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (50449ca66cc5 arm64: hibernate: Fix leve=
l3 translation fault in swsusp_save())
Merging arm-soc-fixes/arm/fixes (e845bcc8cfda Merge tag 'riscv-soc-fixes-fo=
r-v6.9-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux =
into arm/fixes)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging sophgo-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (49a940dbdc31 powerpc/pseries/iommu: LPAR panic=
s during boot up with a frozen PE)
Merging s390-fixes/fixes (7bbe449d0bdb s390/paes: Reestablish retry loop in=
 paes)
Merging fscrypt-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging fsverity-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging net/main (545c494465d2 Merge tag 'net-6.9-rc7' of git://git.kernel.=
org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (3e9bc0472b91 Merge branch 'bpf: Add BPF_PROG_TYPE_CGROU=
P_SKB attach type enforcement in BPF_LINK_CREATE')
Merging ipsec/master (b6d2e438e16c xfrm: Correct spelling mistake in xfrm.h=
 comment)
Merging netfilter/main (8a2e4d37afb8 s390/qeth: Fix kernel panic after sett=
ing hsuid)
Merging ipvs/main (8a2e4d37afb8 s390/qeth: Fix kernel panic after setting h=
suid)
Merging wireless/for-next (52afb15e9d9a Merge tag 'net-6.9-rc6' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (ed30a4a51bb1 Linux 6.9-rc5)
Merging sound-current/for-linus (fdb3f29dfe0d ALSA: hda/realtek: Fix build =
error without CONFIG_PM)
Merging sound-asoc-fixes/for-linus (c5782bb5468a ASoC: meson: tdm fixes)
Merging regmap-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging regulator-fixes/for-linus (ff33132605c1 regulator: change devm_regu=
lator_get_enable_optional() stub to return Ok)
Merging spi-fixes/for-linus (4756fa529b2f spi: fix null pointer dereference=
 within spi_sync)
Merging pci-current/for-linus (4cece7649650 Linux 6.9-rc1)
Merging driver-core.current/driver-core-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging tty.current/tty-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging usb.current/usb-linus (ae11f04b452b usb: typec: tcpm: Check for por=
t partner validity before consuming it)
Merging usb-serial-fixes/usb-linus (582ee2f9d268 USB: serial: option: add T=
elit FN920C04 rmnet compositions)
Merging phy/fixes (bf6e4ee5c436 phy: ti: tusb1210: Resolve charger-det cras=
h if charger psy is unregistered)
Merging staging.current/staging-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging iio-fixes/fixes-togreg (4108a30f1097 mei: me: add lunar lake point =
M DID)
Merging counter-current/counter-current (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc.current/char-misc-linus (00e7d3bea2ce dyndbg: fix old BUG=
_ON in >control parser)
Merging soundwire-fixes/fixes (e67572cd2204 Linux 6.9-rc6)
Merging thunderbolt-fixes/fixes (e67572cd2204 Linux 6.9-rc6)
Merging input-current/for-linus (0537c8eef4f6 Input: amimouse - mark driver=
 struct with __refdata to prevent section mismatch)
Merging crypto-current/master (5a7e89d3315d crypto: iaa - Fix nr_cpus < nr_=
iaa case)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (72d7cb5c190b selftests/harness: Prevent infi=
nite loop due to Assert in FIXTURE_TEARDOWN)
Merging dmaengine-fixes/fixes (e67572cd2204 Linux 6.9-rc6)
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
Merging kvm-fixes/master (16c20208b9c2 Merge tag 'kvmarm-fixes-6.9-2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (175f2f5bcdfc KVM: s390: Check kvm pointer whe=
n testing KVM_CAP_S390_HPAGE_1M)
Merging hwmon-fixes/hwmon (4cece7649650 Linux 6.9-rc1)
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (5d211c709059 cxl: Fix cxl_endpoint_get_perf_coordi=
nate() support for RCH)
Merging btrfs-fixes/next-fixes (dd11e0f129c3 Merge branch 'misc-6.9' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (75961ffb5cb3 swiotlb: initialise restr=
icted pool list_head when SWIOTLB_DYNAMIC=3Dy)
Merging drivers-x86-fixes/fixes (515a3c3a5489 platform/x86: ISST: Add Grand=
 Ridge to HPM CPU list)
Merging samsung-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pinctrl-samsung-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging devicetree-fixes/dt/linus (dab6bc78e981 of: module: add buffer over=
flow check in of_modalias())
Merging dt-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging scsi-fixes/fixes (961990efc608 scsi: sd: Only print updates to perm=
anent stream count)
Merging drm-fixes/drm-fixes (e67572cd2204 Linux 6.9-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (e67572cd2204 Linux 6.9-rc6)
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
Merging rust-fixes/rust-fixes (e67572cd2204 Linux 6.9-rc6)
Merging v9fs-fixes/fixes/next (d05dcfdf5e16  fs/9p: mitigate inode collisio=
ns)
Merging w1-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pmdomain-fixes/fixes (39cd87c4eb2b Linux 6.9-rc2)
Merging overlayfs-fixes/ovl-fixes (77a28aa47687 ovl: relax WARN_ON in ovl_v=
erify_area())
Merging i2c-host-fixes/i2c/i2c-host-fixes (e67572cd2204 Linux 6.9-rc6)
Merging sparc-fixes/for-linus (6613476e225e Linux 6.8-rc1)
Merging clk-fixes/clk-fixes (aacb99de1099 clk: samsung: Revert "clk: Use de=
vice_get_match_data()")
Merging drm-misc-fixes/for-linux-next-fixes (da85f0aaa9f2 drm/panel: ili934=
1: Use predefined error codes)
Merging mm-stable/mm-stable (72801513b2bf mm: set pageblock_order to HPAGE_=
PMD_ORDER in case with !CONFIG_HUGETLB_PAGE but THP enabled)
Merging mm-nonmm-stable/mm-nonmm-stable (e02577872ff5 crash: add prefix for=
 crash dumping messages)
Merging mm/mm-everything (3c2a0d2f0ca0 foo)
Applying: Revert "mm/vmscan: avoid split lazyfree THP during shrink_folio_l=
ist()"
Applying: Revert "mm/rmap: integrate PMD-mapped folio splitting into pagewa=
lk loop"
Merging kbuild/for-next (060ef2b42249 kconfig: remove 'optional' property s=
upport)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (8c618b58c89c perf test: Reintroduce -p/--para=
llel and make -S/--sequential the default)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (c93f261dfc39 Documentation/core-api: add swio=
tlb documentation)
Merging asm-generic/master (5394f1e9b687 arch: define CONFIG_PAGE_SIZE_*KB =
on all architectures)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (15b7967c1ef1 Merge branches 'amba', 'cfi', 'clkdev', =
'fixes' and 'misc' into for-next)
$ git reset --hard HEAD^
Merging next-20240502 version of arm
Merging arm64/for-next/core (7befe2ef9384 Merge branches 'for-next/acpi', '=
for-next/kbuild', 'for-next/misc', 'for-next/mm', 'for-next/perf' and 'for-=
next/tlbi' into for-next/core)
Merging arm-perf/for-next/perf (4052ce07d5d7 perf/arm-spe: Assign parents f=
or event_source device)
Merging arm-soc/for-next (fa8870d46ddf soc: document merges)
Merging amlogic/for-next (2b952b1d0a54 Merge branch 'v6.10/defconfig' into =
for-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (c44211af1aa9 ARM: dts: aspeed: Add ASRock E3C256D4=
I BMC)
Merging at91/at91-next (fa8e55345b64 Merge branch 'microchip-dt64' into at9=
1-next)
Merging broadcom/next (3d83aa97a6f7 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (bf11908757ee memory: mtk-smi: fix module a=
utoloading)
Merging imx-mxs/for-next (8c4bf8c96748 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (7f6f45a762c3 Merge branches 'v6.9-next/soc' and =
'v6.9-next/dts64' into for-next)
Merging mvebu/for-next (058bfa0ead87 arm64: dts: marvell: cn9130-crb: drop =
unneeded "status")
Merging omap/for-next (5856330c3d56 Merge branch 'drivers-ti-sysc-for-v6.10=
' into for-next)
Merging qcom/for-next (1d0a6cdb7d77 Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-fixes-for-6.9', 'arm64-for-6.10', 'clk-fixes-f=
or-6.9', 'clk-for-6.10', 'drivers-fixes-for-6.9' and 'drivers-for-6.10' int=
o for-next)
Merging renesas/next (1e2995ef0bb8 Merge branch 'renesas-dts-for-v6.10' int=
o renesas-next)
Merging reset/reset/next (6d89df61650d reset: ti-sci: Convert to platform r=
emove callback returning void)
Merging rockchip/for-next (8dabf52bd8db Merge branch 'v6.10-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (ec19533517d5 Merge branch 'next/dt64' into f=
or-next)
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
Merging ti/ti-next (f532f2375771 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2dc107360e22 dts: zynqmp: add properties for TCM i=
n remoteproc)
Merging clk/clk-next (15daa68811f4 Merge branch 'clk-imx' into clk-next)
Merging clk-imx/for-next (f5072cffb35c clk: imx: imx8mp: Convert to platfor=
m remove callback returning void)
Merging clk-renesas/renesas-clk (5add5ebc4e35 clk: renesas: r9a08g045: Add =
support for power domains)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (f3334ebb8a2a LoongArch: Lately init pmu a=
fter smp is online)
Merging m68k/for-next (bd622532f7b3 m68k: amiga: Use str_plural() to fix Co=
ccinelle warning)
Merging m68knommu/for-next (2595108e5842 m68k: Avoid CONFIG_COLDFIRE switch=
 in uapi header)
Merging microblaze/next (58d647506c92 microblaze: Remove early printk call =
from cpuinfo-static.c)
Merging mips/mips-next (40e20fbccfb7 MIPS: SGI-IP27: micro-optimize arch_in=
it_irq())
Merging openrisc/for-next (4dc70e1aadfa openrisc: Move FPU state out of pt_=
regs)
Merging parisc-hd/for-next (487fa28fa8b6 parisc: Define sigset_t in parisc =
uapi header)
Merging powerpc/next (1fcd25473337 MAINTAINERS: MMU GATHER: Update Aneesh's=
 address)
Merging powerpc-kdump-hotplug/topic/kdump-hotplug (849599b702ef powerpc/cra=
sh: add crash memory hotplug support)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (0a16a1728790 riscv: select ARCH_HAS_FAST_MULTIPLIE=
R)
CONFLICT (content): Merge conflict in Documentation/rust/arch-support.rst
Merging riscv-dt/riscv-dt-for-next (8fd63d81a760 riscv: dts: microchip: add=
 pac1934 power-monitor to icicle)
CONFLICT (content): Merge conflict in arch/riscv/Makefile
Merging riscv-soc/riscv-soc-for-next (16d9122246cc Merge branch 'riscv-conf=
ig' into riscv-soc-for-next)
Merging s390/for-next (1bc9e285c78a Merge branch 'features' into for-next)
Merging sh/for-next (21b8651502d5 sh: boot: Add proper forward declarations)
Merging sparc/for-next (48d85acdaa52 sparc: chmc: Convert to platform remov=
e callback returning void)
Merging uml/next (919e3ece7f5a um: virtio_uml: Convert to platform remove c=
allback returning void)
CONFLICT (content): Merge conflict in arch/um/include/shared/um_malloc.h
Merging xtensa/xtensa-for-next (b7cf2a1d9881 xtensa: remove redundant flush=
_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros)
Merging bcachefs/for-next (36c2e90c4a0b bcachefs: bch2_dev_have_ref())
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (d49e9f686546 Merge branch 'for-next-next-v6.9-20240=
503' into for-next-20240503)
Merging ceph/master (d3e046930679 MAINTAINERS: remove myself as a Reviewer =
for Ceph)
Merging cifs/for-next (ae4f73e84cb1 smb: smb2pdu.h: Avoid -Wflex-array-memb=
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
Merging gfs2/for-next (50760f778119 gfs2: Convert gfs2_aspace_writepage() t=
o use a folio)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (bc642d7bfdac ksmbd: fix uninitialized symbol =
'share' in smb2_tree_connect())
Merging nfs/linux-next (24457f1be29f nfs: Handle error of rpc_proc_register=
() in nfs_net_init().)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (e308c853b2a4 NFSD: Add COPY status code to OFFLOAD_=
STATUS response)
Merging ntfs3/master (24f6f5020b0b fs/ntfs3: Mark volume as dirty if xattr =
is broken)
Merging orangefs/for-next (9bf93dcfc453 Julia Lawall reported this null poi=
nter dereference, this should fix it.)
Merging overlayfs/overlayfs-next (096802748ea1 ovl: remove upper umask hand=
ling from ovl_create_upper())
Merging ubifs/next (b8a77b9a5f9c mtd: ubi: fix NVMEM over UBI volumes on 32=
-bit systems)
Merging v9fs/9p-next (2a0505cdd8c8 9p: remove SLAB_MEM_SPREAD flag usage)
Merging v9fs-ericvh/ericvh/for-next (4cece7649650 Linux 6.9-rc1)
Merging xfs/for-next (21255afdd729 xfs: do not allocate the entire delalloc=
 extent in xfs_bmapi_write)
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
CONFLICT (content): Merge conflict in fs/btrfs/disk-io.c
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
Merging i2c-host/i2c/i2c-host (856cd5f13de7 i2c: designware: Create shared =
header hosting driver name)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging dmi/dmi-for-next (868577e6bfe1 firmware: dmi: Stop decoding on brok=
en entry)
Applying: Revert "firmware: dmi: Stop decoding on broken entry"
Merging hwmon-staging/hwmon-next (1d4d6733594d hwmon: (npcm750-pwm-fan) Rem=
ove another unused field in struct npcm7xx_cooling_device)
Merging jc_docs/docs-next (404b444fbb3d Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (4a7d735191de media: dw2102: fix coding style issues)
Merging v4l-dvb-next/master (5c883a709ef5 media: verisilicon: Correct a typ=
o in H1_REG_MAD_CTRL_MAD_THRESHOLD)
$ git reset --hard HEAD^
Merging next-20240430 version of v4l-dvb-next
Merging pm/linux-next (058b3af4882a Merge branches 'acpica', 'acpi-scan' an=
d 'acpi-resource' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (fde234239d16 dt-bindings: cpufr=
eq: cpufreq-qcom-hw: Add SM4450 compatibles)
Merging cpupower/cpupower (55f9f60852ef tools/power/cpupower: Fix Pstate fr=
equency reporting on AMD Family 1Ah CPUs)
Merging devfreq/devfreq-next (6f3c0cfe2aa5 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (0cebf7cb2d70 pmdomain: core: Don't clear suspended_c=
ount at genpd_prepare())
Merging opp/opp/linux-next (4cece7649650 Linux 6.9-rc1)
Merging thermal/thermal/linux-next (734b5def91b5 thermal/drivers/loongson2:=
 Add Loongson-2K2000 support)
Merging dlm/next (7b72ab2c6a46 dlm: return -ENOMEM if ls_recover_buf fails)
Merging rdma/for-next (fd3af5e21866 RDMA/mlx5: Track DCT, DCI and REG_UMR Q=
Ps as diver_detail resources.)
Merging net-next/main (ec6f25bc8aba selftests/net: skip partial checksum pa=
ckets in csum test)
CONFLICT (content): Merge conflict in drivers/of/property.c
CONFLICT (content): Merge conflict in include/linux/slab.h
Merging bpf-next/for-next (087d757fb473 libbpf: fix ring_buffer__consume_n(=
) return result logic)
Merging ipsec-next/master (dcf280ea0aad Merge remote branch 'xfrm: Introduc=
e direction attribute for SA')
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (5c7d0f260187 Bluetooth: HCI: Fix potential null-p=
tr-deref)
  f90ac18d01cd ("arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node")
Merging wireless-next/for-next (8886b6d681f2 wifi: qtnfmac: Remove generic =
ndo_get_stats64)
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (6277967d872e mtd: mchp23k256: drop unneeded MODULE_AL=
IAS)
Merging nand/nand/next (6819db94e1cd mtd: rawnand: hynix: fixed typo)
Merging spi-nor/spi-nor/next (c84b3925c7d6 mtd: spi-nor: replace unnecessar=
y div64_u64() with div_u64())
Merging crypto/master (ed265f7fd9a6 crypto: x86/aes-gcm - simplify GCM hash=
 subkey derivation)
Merging drm/drm-next (f03eee5fc922 Merge tag 'drm-xe-next-fixes-2024-05-02'=
 of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next)
Merging drm-exynos/for-linux-next (2236a61bd491 Merge tag 'mediatek-drm-nex=
t-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/lin=
ux into drm-next)
Merging drm-misc/for-linux-next (be3f3042391d drm: zynqmp_dpsub: Always reg=
ister bridge)
Merging amdgpu/drm-next (0a92269d1a91 drm/amdgpu: remove ip dump reg_count =
variable)
Merging drm-intel/for-linux-next (8e056b50d92a drm/i915/audio: Fix audio ti=
me stamp programming for DP)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (104e548a7c97 drm/msm/mdp4: use drmm-managed alloc=
ation for mdp4_plane)
Merging drm-msm-lumag/msm-next-lumag (104e548a7c97 drm/msm/mdp4: use drmm-m=
anaged allocation for mdp4_plane)
Merging drm-xe/drm-xe-next (8ad0e1810bf2 drm/xe/gt: Fix assert in L3 bank m=
ask generation)
  06e7139a034f ("drm/xe: Fix unexpected backmerge results")
  3d44d67c441a ("drm/xe/vm: prevent UAF in rebind_work_func()")
  4caf410766ad ("drm/xe: Merge 16021540221 and 18034896535 WAs")
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (ce4a7ae84a58 fbdev: offb: replace of_node_put with =
__free(device_node))
Merging regmap/for-next (991b5e2aad87 regmap: kunit: Fix an NULL vs IS_ERR(=
) check)
Merging sound/for-next (e7aeb238026c ALSA: aoa: soundbus: i2sbus: pcm: use =
'time_left' variable with wait_for_completion_timeout())
Merging ieee1394/for-next (e447f9e094a2 firewire: core: add tracepoint even=
t for handling bus reset)
Merging sound-asoc/for-next (ea1aac8c37ae Merge remote-tracking branch 'aso=
c/for-6.10' into asoc-next)
Merging modules/modules-next (3c2c250cb3a5 bpf: remove CONFIG_BPF_JIT depen=
dency on CONFIG_MODULES of)
CONFLICT (content): Merge conflict in arch/powerpc/mm/mem.c
CONFLICT (content): Merge conflict in kernel/module/main.c
Merging input/next (7b4e0b39182c Input: cyapa - add missing input core lock=
ing to suspend/resume functions)
Merging block/for-next (1c16609710aa Merge branch 'for-6.10/block' into for=
-next)
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
Merging mfd/for-mfd-next (7fcb2977c0b5 dt-bindings: mfd: Convert lp873x.txt=
 to json-schema)
CONFLICT (content): Merge conflict in drivers/mfd/intel-lpss-pci.c
Merging backlight/for-backlight-next (4da294108e38 backlight: sky81452-back=
light: Remove unnecessary call to of_node_get())
Merging battery/for-next (50f0ff7c8cc4 power: supply: bq27xxx: Move health =
reading out of update loop)
Merging regulator/for-next (d3ff4628b912 Merge remote-tracking branch 'regu=
lator/for-6.10' into regulator-next)
Merging security/next (67889688e05b MAINTAINERS: update the LSM file list)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (9fa8e7625008 ima: add crypto agility supp=
ort for template-hash algorithm)
Merging selinux/next (4b60f3cd1134 Automated merge of 'dev' into 'next')
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
Merging devicetree/for-next (9b4a5ae6be9b dt-bindings: Drop unnecessary quo=
tes on keys)
  828215066d88 ("dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node")
CONFLICT (content): Merge conflict in drivers/of/dynamic.c
CONFLICT (content): Merge conflict in drivers/of/property.c
Merging dt-krzk/for-next (3d679a406f3a Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/for-next (0ac39d85a741 mailbox: zynqmp: Enable Bufferless I=
PI usage on Versal-based SOC's)
Merging spi/for-next (02ca3b9791ef Merge remote-tracking branch 'spi/for-6.=
10' into spi-next)
Merging tip/master (9699b5214fb3 Merge branch into tip/master: 'x86/timers')
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/st/stm32mp251.dtsi
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (03db22b93a01 Merge ras/edac-urgent into for-nex=
t)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (e7d6f9dff52c rcu/nocb: Remove buggy bypass lock conte=
ntion mitigation)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging kvm/next (a96cb3bf390e Merge x86 bugfixes from Linux 6.9-rc3)
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/svm.c
Applying: fixup for "KVM: VMX: Move posted interrupt descriptor out of VMX =
code"
Merging kvm-arm/next (5099601bb8df Merge branch kvm-arm64/pkvm-6.10 into kv=
marm-master/next)
Merging kvms390/next (39cd87c4eb2b Linux 6.9-rc2)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (5ef2f3d4e747 KVM: riscv: selftests: Add c=
ommandline option for SBI PMU test)
Merging kvm-x86/next (04b1c6b4841d Merge branches 'fixes', 'generic', 'misc=
', 'mmu', 'selftests', 'selftests_utils' and 'vmx')
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/aarch64/p=
sci_test.c
Merging xen-tip/linux-next (802600ebdf23 x86/xen: return a sane initial api=
c id when running as PV guest)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (24283babc61f Merge branch 'for-6.9-fixes' into=
 for-next)
Merging drivers-x86/for-next (76f09e22027f platform/x86: ISST: Support SST-=
BF and SST-TF per level)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging chrome-platform/for-next (2fbe479c0024 platform/chrome: cros_ec: Ha=
ndle events during suspend after resume completion)
Merging chrome-platform-firmware/for-firmware-next (7f20f21c22aa firmware: =
google: cbmem: drop driver owner initialization)
Merging hsi/for-next (c076486b6a28 HSI: omap_ssi_port: Convert to platform =
remove callback returning void)
Merging leds-lj/for-leds-next (f2994f5341e0 leds: mt6370: Remove unused fie=
ld 'reg_cfgs' from 'struct mt6370_priv')
Merging ipmi/for-next (999dff3c1393 ipmi: kcs_bmc_npcm7xx: Convert to platf=
orm remove callback returning void)
Merging driver-core/driver-core-next (e5019b14230a Merge 6.9-rc5 into drive=
r-core-next)
Merging usb/usb-next (080e73c9411b usb: xhci: compact 'trb_in_td()' argumen=
ts)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/core.c
Merging thunderbolt/next (a3dc6d82de9b thunderbolt: Correct trace output of=
 firmware connection manager packets)
Merging usb-serial/usb-next (39cd87c4eb2b Linux 6.9-rc2)
Merging tty/tty-next (660a70809856 Merge 6.9-rc5 into tty-next)
CONFLICT (content): Merge conflict in include/linux/kfifo.h
CONFLICT (content): Merge conflict in lib/kfifo.c
Merging char-misc/char-misc-next (33075a03f47b Merge tag 'mhi-for-6.10' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (9b47d9982d1d hwtracing: hisi_ptt: Assign parent for=
 event_source device)
Merging fastrpc/for-next (4cece7649650 Linux 6.9-rc1)
Merging fpga/for-next (b7c0e1ecee40 fpga: region: add owner module and take=
 its refcount)
Merging icc/icc-next (230d05b1179f interconnect: qcom: qcm2290: Fix mas_sno=
c_bimc QoS port assignment)
Merging iio/togreg (9900e7a54764 iio: temperature: mcp9600: Fix temperature=
 reading for negative values)
Merging phy-next/next (9c79b779643e phy: rockchip: fix CONFIG_TYPEC depende=
ncy)
Merging soundwire/next (a36ec5f7625d soundwire: intel_ace2x: simplify check=
_wake())
Merging extcon/extcon-next (abe83c4e5e4f extcon: realtek: Remove unused of_=
gpio.h)
Merging gnss/gnss-next (0bbac3facb5d Linux 6.9-rc4)
Merging vfio/next (848e447e000c vfio/cdx: add interrupt support)
Merging w1/for-next (cde37a5bdb0e w1: gpio: Don't use "proxy" headers)
Merging spmi/spmi-next (539a47de89d6 spmi: pmic-arb: Fix of_irq_get_byname(=
) error checking)
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
Merging vhost/linux-next (88199634e516 vduse: enable Virtio-net device type)
CONFLICT (content): Merge conflict in drivers/virtio/virtio_mem.c
Merging rpmsg/for-next (0496190c4d42 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (5539287ca656 gpio: brcmstb: add support fo=
r gpio-ranges)
Merging gpio-intel/for-next (ecc4b1418e23 gpio: Add Intel Granite Rapids-D =
vGPIO driver)
Merging pinctrl/for-next (077895d14a6b Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (5d10a157ebe0 pinctrl: baytrail: Add pinconf=
 group for uart3)
Merging pinctrl-renesas/renesas-pinctrl (cd27553b0dee pinctrl: renesas: rzg=
2l: Limit 2.5V power supply to Ethernet interfaces)
Merging pinctrl-samsung/for-next (e5b3732a9654 pinctrl: samsung: drop redun=
dant drvdata assignment)
Merging pwm/pwm/for-next (b664fc60d7f8 dt-bindings: pwm: snps,dw-apb-timers=
: Do not require pwm-cells twice)
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (693fe2f6a9ea selftests: kselftest: Make ksft_exit f=
unctions return void instead of int)
CONFLICT (content): Merge conflict in tools/testing/selftests/mm/soft-dirty=
c
Merging kunit/test (4cece7649650 Linux 6.9-rc1)
Merging kunit-next/kunit (2168e528f867 kunit: bail out early in __kunit_tes=
t_suites_init() if there are no suites to test)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (1c431b92e21b dt-bindings: rtc: convert trivial device=
s into dtschema)
Merging nvdimm/libnvdimm-for-next (41147b006be2 dax: remove redundant assig=
nment to variable rc)
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
Merging cxl/next (d99f13843237 cxl/cper: Remove duplicated GUID defines)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (4b2543f7e1e6 efi: libstub: only free priv.runtime_map whe=
n allocated)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (4a8dd3b3d550 Merge branch 'slab/for-6.10/cleanu=
p' into slab/for-next)
Merging random/master (7b1bcd6b50a6 virt: vmgenid: add support for devicetr=
ee bindings)
CONFLICT (content): Merge conflict in drivers/virt/vmgenid.c
Merging landlock/next (d6a07bb3c18c MAINTAINERS: Add G=C3=BCnther Noack as =
Landlock reviewer)
Merging rust/rust-next (2c1092853f16 rust: kernel: remove usage of `allocat=
or_api` unstable feature)
Merging sysctl/sysctl-next (a35dd3a786f5 sysctl: drop now unnecessary out-o=
f-bounds check)
Merging execve/for-next/execve (10e29251be0e binfmt_elf_fdpic: fix /proc/<p=
id>/auxv)
Merging bitmap/bitmap-for-next (1b6ef2812522 bitops: Optimize fns() for imp=
roved performance)
CONFLICT (content): Merge conflict in include/linux/bitops.h
Merging hte/for-next (297f26dbf870 hte: tegra-194: Convert to platform remo=
ve callback returning void)
Merging kspp/for-next/kspp (7d78a7773355 string: Add additional __realloc_s=
ize() annotations for "dup" helpers)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (0adab2b6b733 tools/nolibc: add support for uname(2))
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (4cece7649650 Linux 6.9-rc1)
Merging turbostat/next (6b9cd589464f tools/power turbostat: version 2024.04=
27)
Merging refactor-heap/refactor-heap (940c306fd779 bcachefs: Remove heap-rel=
ated macros and switch to generic min_heap)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/T7Nmxa.AXbbHYWO9KkdNmxk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0j6AACgkQAVBC80lX
0GwlBAf+LHT4Ti98iCNsh+z0fTQPciha80CKDF+A03xJmEDR2+P08RPArJDLAnmR
xmG4u4fpA9/eJoHDh3yvzbqsVkby2ZEOLuM2SEwAHo3f4vr3F+M62h7PULMRcRCy
jytcmlfr8/kbhiMsF14vCMDId922uSO4yEN4KxA0o/ijvfR+eSDiY8fNKbi2xaNt
edsmB26Z4puRJCfoG/d9dst5AoudEnNPc/fVOEFSv3mO+PXv1+VcBNeChsURJvui
op+zg0mXF9eMaRe3QDj6herSBXCpzh5P2MeZ9gwOQ1ACEPD8XN3rFyOoACea5YXs
J3lNxXFp7aGaMBivlyWQt6cOsrA5lQ==
=RsGU
-----END PGP SIGNATURE-----

--Sig_/T7Nmxa.AXbbHYWO9KkdNmxk--

