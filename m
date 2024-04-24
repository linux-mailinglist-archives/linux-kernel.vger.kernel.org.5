Return-Path: <linux-kernel+bounces-156709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1048F8B0728
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71D9B2369F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA715956F;
	Wed, 24 Apr 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I4Z2cNWJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6B158210;
	Wed, 24 Apr 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954085; cv=none; b=r2x7NgStL8nY8jhB3pOeP6l6AS1dk4N57XDvatXL+KC/OFKCc7U0MEt1lDrIGk8BKczsB0njr1YOj+rCGsEMNJ9ByQbIFPlszb5xZguHxq1cDuPz7FdECAMbvFqCho43qMLBHQlMUUfA1x5ea1blh7LzFDhwc9pkcBmJqo9PSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954085; c=relaxed/simple;
	bh=FZVCtk8qVzT6bCiVW7GxBSK5Lc6yl/B4SOQCajhSg/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DKOh6ST+aTI1xsYmPPvkssIdAf3PY4cQEFj4LOpNijJJxzwHHLbdwDEqzI2wuh8Lcrlcqi4GaE02QvxMBL2qj1NKsc8cafHoNY4WRgMFsBnbW/WKZYcNwvKsSLorWBLPiVM1LjS6EEggywPoyJayKytFFhaU9AFn+sQOk0rDiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=I4Z2cNWJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713954075;
	bh=M+HkcyLGgrKJ3L1LLNeaRGG9ga8saXlMZWjSYT5ZLCs=;
	h=Date:From:To:Cc:Subject:From;
	b=I4Z2cNWJ/alfcSCy9E9h3vXjtOVVO855I9yPbZkFirAAjLpZ6cYBzbydWvTJfcEWY
	 Njp7vdzxQEcOSUF+V+RQfB83j9UNtEgmvKum3j8893M/iBR3BYBfdjWCMBb49CglnZ
	 ZnFgs/Xa/UgHMRJJ1SocoKkYTHbmJ0cZMU2uTAtBSF4+P65EApEUARTSYFV5WhqOY/
	 IotnlaJITTizgFfg0iGe1ZYIbnZ9vjhj7tMAUgU71Cj1XEq10pFu2gWLwW+jhMVofD
	 yGEtLnIGYF7KQtkNZXyFbiQQM6WMgZN7aj+IfadEiqzgsm3dTh84B9ZQzWUFWRKZnZ
	 AR7BjNSmJJZUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPZlH1zqdz4wZx;
	Wed, 24 Apr 2024 20:21:15 +1000 (AEST)
Date: Wed, 24 Apr 2024 20:21:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 24
Message-ID: <20240424202112.4fc0e0d4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qf6HOUJyW3c85g76d0NsWm+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Qf6HOUJyW3c85g76d0NsWm+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next release tomorrow.

Changes since 20240423:

New tree:	powerpc-kdump-hotplug

The gpio-brgl-fixes tree lost its build failure.

The mm tree still had its build failure for which I applied a patch.

The nfsd tree gained a conflict against the nfsd-fixes tree.

The vfs-brauner tree gained a conflict against the erofs-fixes tree.

The modules tree gained conflicts against the mm tree.  It also was
involved in a boot failure, so I used the version from next-20240423.

The devicetree tree gained a conflict against the net-next, stm32 trees.

The rcu tree gained a conflict against the modules tree.

Non-merge commits (relative to Linus' tree): 7298
 7444 files changed, 518857 insertions(+), 177297 deletions(-)

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

I am currently merging 371 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (9d1ddab261f3 Merge tag '6.9-rc5-smb-client-fixes' of=
 git://git.samba.org/sfrench/cifs-2.6)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (bab29f1a77ba maple_tree: fix mas_=
empty_area_rev() null pointer dereference)
CONFLICT (content): Merge conflict in tools/testing/selftests/kselftest_har=
ness.h
Merging kbuild-current/fixes (89e5462bb5ae kconfig: Fix typo HEIGTH to HEIG=
HT)
Merging arc-current/for-curr (61231eb8113c ARC: [plat-hsdk]: Remove misplac=
ed interrupt-cells property)
Merging arm-current/fixes (0c66c6f4e21c ARM: 9359/1: flush: check if the fo=
lio is reserved for no-mapping addresses)
Merging arm64-fixes/for-next/fixes (50449ca66cc5 arm64: hibernate: Fix leve=
l3 translation fault in swsusp_save())
Merging arm-soc-fixes/arm/fixes (011d79ef1cfa MAINTAINERS: Change Krzysztof=
 Kozlowski's email address)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging sophgo-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging m68k-current/for-linus (e8a7824856de m68k: defconfig: Update defcon=
figs for v6.8-rc1)
Merging powerpc-fixes/fixes (210cfef57926 selftests/powerpc/papr-vpd: Fix m=
issing variable initialization)
Merging s390-fixes/fixes (412050af2ea3 s390/mm: Fix clearing storage keys f=
or huge pages)
Merging fscrypt-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging fsverity-current/for-current (4cece7649650 Linux 6.9-rc1)
Merging net/main (a44f2eb106a4 tools: ynl: don't ignore errors in NLMSG_DON=
E messages)
Merging bpf/master (5bcf0dcbf906 xdp: use flags field to disambiguate broad=
cast redirect)
Merging ipsec/master (8b06a24bb625 xfrm: fix possible derferencing in error=
 path)
Merging netfilter/main (a9176f7c66f0 Merge branch 'mlxsw-fixes')
Merging ipvs/main (7eaf837a4eb5 netfilter: nf_tables: Fix a memory leak in =
nf_tables_updchain)
Merging wireless/for-next (91112fc6212a wifi: iwlwifi: mvm: fix link ID man=
agement)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (ed30a4a51bb1 Linux 6.9-rc5)
Merging sound-current/for-linus (f25f17dc5c6a ALSA: seq: ump: Fix conversio=
n from MIDI2 to MIDI1 UMP messages)
Merging sound-asoc-fixes/for-linus (f2602fba4723 ASoC: cs35l56: Avoid stati=
c analysis warning of uninitialised variable)
Merging regmap-fixes/for-linus (fec50db7033e Linux 6.9-rc3)
Merging regulator-fixes/for-linus (96e20adc43c4 regulator: change stubbed d=
evm_regulator_get_enable to return Ok)
Merging spi-fixes/for-linus (7430764f5a85 spi: hisi-kunpeng: Delete the dum=
p interface of data registers in debugfs)
Merging pci-current/for-linus (4cece7649650 Linux 6.9-rc1)
Merging driver-core.current/driver-core-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging tty.current/tty-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging usb.current/usb-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging usb-serial-fixes/usb-linus (582ee2f9d268 USB: serial: option: add T=
elit FN920C04 rmnet compositions)
Merging phy/fixes (bf6e4ee5c436 phy: ti: tusb1210: Resolve charger-det cras=
h if charger psy is unregistered)
Merging staging.current/staging-linus (39cd87c4eb2b Linux 6.9-rc2)
Merging iio-fixes/fixes-togreg (74a72baf204f iio:imu: adis16475: Fix sync m=
ode setting)
Merging counter-current/counter-current (39cd87c4eb2b Linux 6.9-rc2)
Merging char-misc.current/char-misc-linus (ed30a4a51bb1 Linux 6.9-rc5)
Merging soundwire-fixes/fixes (63dc588e7af1 soundwire: amd: fix for wake in=
terrupt handling for clockstop mode)
Merging thunderbolt-fixes/fixes (ed30a4a51bb1 Linux 6.9-rc5)
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
Merging btrfs-fixes/next-fixes (08487fb4f2bd Merge branch 'misc-6.9' into n=
ext-fixes)
Merging vfs-fixes/fixes (aa23317d0268 qibfs: fix dentry leak)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (f609e7b1b49e platform/x86/amd/pmc: Extend =
Framework 13 quirk to more BIOSes)
Merging samsung-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging pinctrl-samsung-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging devicetree-fixes/dt/linus (dab6bc78e981 of: module: add buffer over=
flow check in of_modalias())
Merging dt-krzk-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging scsi-fixes/fixes (ca91259b775f scsi: core: Fix handling of SCMD_FAI=
L_IF_RECOVERING)
Merging drm-fixes/drm-fixes (ed30a4a51bb1 Linux 6.9-rc5)
Merging drm-intel-fixes/for-linux-next-fixes (ed30a4a51bb1 Linux 6.9-rc5)
Merging mmc-fixes/fixes (ace323f80b9b mmc: sdhci-of-dwcmshc: th1520: Increa=
se tuning loop count to 128)
Merging rtc-fixes/rtc-fixes (4cece7649650 Linux 6.9-rc1)
Merging gnss-fixes/gnss-linus (0bbac3facb5d Linux 6.9-rc4)
Merging hyperv-fixes/hyperv-fixes (fb836d64a2ea hv/vmbus_drv: rename hv_acp=
i_init() to vmbus_init())
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (a373a36fb6b0 Merge patch the fixes from "riscv:=
 64-bit NOMMU fixes and enhancements")
Merging riscv-dt-fixes/riscv-dt-fixes (e0503d47e93d riscv: dts: starfive: v=
isionfive 2: Remove non-existing I2S hardware)
Merging riscv-soc-fixes/riscv-soc-fixes (6b0856ee585d cache: sifive_ccache:=
 Silence unused variable warning)
Merging fpga-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging spdx/spdx-linus (4cece7649650 Linux 6.9-rc1)
Merging gpio-brgl-fixes/gpio/for-current (ed30a4a51bb1 Linux 6.9-rc5)
Merging gpio-intel-fixes/fixes (7d045025a24b gpio: tangier: Use correct typ=
e for the IRQ chip data)
Merging pinctrl-intel-fixes/fixes (5d10a157ebe0 pinctrl: baytrail: Add pinc=
onf group for uart3)
Merging auxdisplay-fixes/fixes (4cece7649650 Linux 6.9-rc1)
Merging erofs-fixes/fixes (569a48fed355 erofs: reliably distinguish block b=
ased and fscache mode)
Merging kunit-fixes/kunit-fixes (cfedfb24c9dd kunit: configs: Enable CONFIG=
_DAMON_DBGFS_DEPRECATED for --alltests)
Merging memblock-fixes/fixes (592447f6cb3c memblock tests: fix undefined re=
ference to `BIT')
Merging nfsd-fixes/nfsd-fixes (7d32b207859f Revert "NFSD: Convert the callb=
ack workqueue to use delayed_work")
Merging renesas-fixes/fixes (8c987693dc2d ARM: dts: renesas: rcar-gen2: Add=
 missing #interrupt-cells to DA9063 nodes)
Merging perf-current/perf-tools (1cebd7f74976 tools/include: Sync arm64 asm=
/cputype.h with the kernel sources)
Merging efi-fixes/urgent (decd347c2a75 x86/efistub: Reinstate soft limit fo=
r initrd loading)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (1e0fb1136461 power: supply: mt6360_charger: Fi=
x of_match for usb-otg-vbus regulator)
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (2760c51b8040 iommufd: Add config needed for i=
ommufd_fail_nth)
Merging rust-fixes/rust-fixes (56b70b91a161 rust: remove `params` from `mod=
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
Merging drm-misc-fixes/for-linux-next-fixes (a386c3041045 drm/atomic-helper=
: fix parameter order in drm_format_conv_state_copy() call)
Merging mm-stable/mm-stable (640958fde130 Merge branch 'master' into mm-sta=
ble)
Merging mm-nonmm-stable/mm-nonmm-stable (0bbac3facb5d Linux 6.9-rc4)
Merging mm/mm-everything (2541ee5668b0 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Applying: fixup for "writeback: support retrieving per group debug writebac=
k stats of bdi"
Merging kbuild/for-next (dd934396afdc kconfig: use menu_for_each_entry() to=
 traverse menu tree)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (e7a8074d2f62 tools include UAPI: Sync linux/v=
host.h with the kernel sources)
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
Merging arm-soc/for-next (011d79ef1cfa MAINTAINERS: Change Krzysztof Kozlow=
ski's email address)
Merging amlogic/for-next (2b952b1d0a54 Merge branch 'v6.10/defconfig' into =
for-next)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (0c30853731ec ARM: dts: aspeed: x4tf: Add dts for a=
sus x4tf project)
Merging at91/at91-next (fa8e55345b64 Merge branch 'microchip-dt64' into at9=
1-next)
Merging broadcom/next (0696ed223eb6 Merge branch 'devicetree/next' into nex=
t)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (bf11908757ee memory: mtk-smi: fix module a=
utoloading)
Merging imx-mxs/for-next (b7c6f4085cba Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (374b2883cf13 Merge branch 'v6.9-next/dts64' into=
 for-next)
Merging mvebu/for-next (058bfa0ead87 arm64: dts: marvell: cn9130-crb: drop =
unneeded "status")
Merging omap/for-next (2a1e301bf479 Merge branch 'omap-for-v6.10/dt' into f=
or-next)
Merging qcom/for-next (c6b2b55174cd Merge branches 'arm32-for-6.10', 'arm64=
-defconfig-for-6.10', 'arm64-fixes-for-6.9', 'arm64-for-6.10', 'clk-fixes-f=
or-6.9', 'clk-for-6.10', 'drivers-fixes-for-6.9' and 'drivers-for-6.10' int=
o for-next)
Merging renesas/next (1e2995ef0bb8 Merge branch 'renesas-dts-for-v6.10' int=
o renesas-next)
Merging reset/reset/next (6d89df61650d reset: ti-sci: Convert to platform r=
emove callback returning void)
Merging rockchip/for-next (8dabf52bd8db Merge branch 'v6.10-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (a74fbb1dc2c6 Merge branch 'next/clk' into fo=
r-next)
Merging scmi/for-linux-next (04f3d8db0b2c Merge branches 'for-next/scmi/upd=
ates' and 'for-next/ffa/updates' of git://git.kernel.org/pub/scm/linux/kern=
el/git/sudeep.holla/linux into for-linux-next)
Merging sophgo/for-next (1eba0b61be72 riscv: dts: sophgo: add reserved memo=
ry node for CV1800B)
Merging stm32/stm32-next (b12a916d30dc ARM: dts: stm32: add heartbeat led f=
or stm32mp157c-ed1)
Merging sunxi/sunxi/for-next (8f328223944a Merge branch 'sunxi/dt-for-6.10'=
 into sunxi/for-next)
Merging tee/next (60757f1264a2 Merge branch 'tee_ts_for_v6.10' into next)
Merging tegra/for-next (c85c30fad06d Merge branch for-6.9/arm64/dt into for=
-next)
Merging ti/ti-next (592695bed5f8 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-dts-next' and 'ti-keystone-dts-next' into ti-next)
Merging xilinx/for-next (2d81f5ef567c Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (92e92dc84e17 Merge branch 'clk-scmi' into clk-next)
Merging clk-imx/for-next (5224b189462f clk: imx: add i.MX95 BLK CTL clk dri=
ver)
Merging clk-renesas/renesas-clk (44019387fce2 clk: renesas: r9a07g043: Add =
clock and reset entry for PLIC)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (5409ade5a799 LoongArch: Fix callchain par=
se error with kernel tracepoint events)
  5743c278400a ("LoongArch: Fix a build error due to __tlb_remove_tlb_entry=
()")
Merging m68k/for-next (70d830e337f9 m68k: Calculate THREAD_SIZE from THREAD=
_SIZE_ORDER)
Merging m68knommu/for-next (2a92aed55942 m68k: Avoid CONFIG_COLDFIRE switch=
 in uapi header)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (40e20fbccfb7 MIPS: SGI-IP27: micro-optimize arch_in=
it_irq())
Merging openrisc/for-next (4dc70e1aadfa openrisc: Move FPU state out of pt_=
regs)
Merging parisc-hd/for-next (e8f897f4afef Linux 6.8)
Merging powerpc/next (f318c8be797f powerpc/ptdump: Fix walk_vmemmap() to al=
so print first vmemmap entry)
Merging powerpc-kdump-hotplug/topic/kdump-hotplug (849599b702ef powerpc/cra=
sh: add crash memory hotplug support)
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
Merging s390/for-next (d30edd25a7b5 Merge branch 'shared-zeropage' into for=
-next)
Merging sh/for-next (4cece7649650 Linux 6.9-rc1)
Merging sparc/for-next (48d85acdaa52 sparc: chmc: Convert to platform remov=
e callback returning void)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (11cca8ccf2c3 tty: xtensa/iss: Use min() to =
fix Coccinelle warning)
Merging bcachefs/for-next (711f072a8f7f bcachefs: Clean up inode alloc)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (8c62f31eddb7 fscrypt: shrink the size of struct f=
scrypt_inode_info slightly)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (33e209409638 Merge branch 'for-next-next-v6.9-20240=
419' into for-next-20240419)
Merging ceph/master (d3e046930679 MAINTAINERS: remove myself as a Reviewer =
for Ceph)
Merging cifs/for-next (59b7e31117bc smb: smb2pdu.h: Avoid -Wflex-array-memb=
er-not-at-end warnings)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging erofs/dev (b351756059e3 erofs: derive fsid from on-disk UUID for .s=
tatfs() if possible)
Merging exfat/dev (d7ed5232f0f1 exfat: fix timing of synchronizing bitmap a=
nd inode)
Merging exportfs/exportfs-next (e8f897f4afef Linux 6.8)
Merging ext3/for_next (7ca906c7f7e5 Pull ext2 and isofs removal to PageErro=
r bit.)
Merging ext4/dev (0ecae5410ab5 ext4: initialize sbi->s_freeclusters_counter=
 and sbi->s_dirtyclusters_counter before use in kunit test)
Merging f2fs/dev (06b206d9e2b4 f2fs: remove unnecessary block size check in=
 init_f2fs_fs())
Merging fsverity/for-next (8e43fb06e10d fsverity: remove hash page spin loc=
k)
Merging fuse/for-next (fa7e19337908 fuse: Add initial support for fs-verity)
Merging gfs2/for-next (29efef6907aa gfs2: Remove and replace gfs2_glock_que=
ue_work)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (71b1543c83d6 Merge tag '6.9-rc5-ksmbd-fixes' =
of git://git.samba.org/ksmbd)
Merging nfs/linux-next (24457f1be29f nfs: Handle error of rpc_proc_register=
() in nfs_net_init().)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (6251e2abfc40 lockd: host: Remove unnecessary statem=
ents=EF=BC=87host =3D NULL;=EF=BC=87)
CONFLICT (content): Merge conflict in fs/nfsd/nfs4callback.c
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
Merging xfs/for-next (6a94b1acda7e xfs: reinstate delalloc for RT inodes (i=
f sb_rextsize =3D=3D 1))
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
Merging vfs-brauner/vfs.all (4efbdf2eca99 Merge branch 'vfs.iomap' into vfs=
all)
CONFLICT (content): Merge conflict in fs/erofs/super.c
Merging vfs/for-next (7c98f7cb8fda remove call_{read,write}_iter() function=
s)
Merging printk/for-next (a2b4cab9da77 Merge branch 'for-6.10' into for-next)
Merging pci/next (ccd0bdb57e31 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (9dd12ed95c2d pstore/blk: replace deprecated=
 strncpy with strscpy)
Merging hid/for-next (d82775b90601 Merge branch 'for-6.10/sony' into for-ne=
xt)
Merging i2c/i2c/for-next (5ceeabb0eb2e Merge tag 'i2c-host-fixes-6.9-rc3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/f=
or-current)
Merging i2c-host/i2c/i2c-host (8d49135d177d i2c: thunderx: Adding ioclk sup=
port)
Merging i3c/i3c/next (8f06fb458539 i3c: Make i3c_bus_type const)
Merging dmi/dmi-for-next (cf770af5645a firmware: dmi-id: add a release call=
back function)
Merging hwmon-staging/hwmon-next (e723f6ca39fb hwmon: jc42: Remove I2C_CLAS=
S_SPD support)
Merging jc_docs/docs-next (2309181eb018 Merge branch 'docs-fixes' into docs=
-next)
Merging v4l-dvb/master (71b3ed53b08d media: atomisp: Implement link_setup()=
 op for ISP subdev MC entity)
Merging v4l-dvb-next/master (71b3ed53b08d media: atomisp: Implement link_se=
tup() op for ISP subdev MC entity)
Merging pm/linux-next (e62751a8c70c Merge branch 'acpi-pm' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (39eaf5212441 cpufreq: dt-platde=
v: eliminate uses of of_node_put())
Merging cpupower/cpupower (4cece7649650 Linux 6.9-rc1)
Merging devfreq/devfreq-next (6f3c0cfe2aa5 PM / devfreq: rk3399_dmc: Conver=
t to platform remove callback returning void)
Merging pmdomain/next (0cebf7cb2d70 pmdomain: core: Don't clear suspended_c=
ount at genpd_prepare())
Merging opp/opp/linux-next (4cece7649650 Linux 6.9-rc1)
Merging thermal/thermal/linux-next (1828c1c17bb2 thermal/drivers/rcar_gen3:=
 Add support for R-Car V4M)
Merging dlm/next (7b72ab2c6a46 dlm: return -ENOMEM if ls_recover_buf fails)
Merging rdma/for-next (349e85995228 RDMA/hns: Modify the print level of CQE=
 error)
Merging net-next/main (8d03c1534d4a Merge branch 'selftests-drv-net-support=
-testing-with-a-remote-system')
CONFLICT (content): Merge conflict in drivers/of/property.c
Merging bpf-next/for-next (a7de265cb2d8 bpf: Fix typos in comments)
Merging ipsec-next/master (aeb48a428d7d udpencap: Remove Obsolete UDP_ENCAP=
_ESPINUDP_NON_IKE Support)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/netdev/net)
Merging ipvs-next/main (ed1f164038b5 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/netdev/net)
Merging bluetooth/master (958efeeef2d3 Bluetooth: Remove 3 repeated macro d=
efinitions)
Merging wireless-next/for-next (b0d2d8f996c1 wifi: mac80211: handle link ID=
 during management Tx)
CONFLICT (content): Merge conflict in net/mac80211/chan.c
Merging wpan-next/master (9187210eee7d Merge tag 'net-next-6.9' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging wpan-staging/staging (9187210eee7d Merge tag 'net-next-6.9' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mtd/mtd/next (6277967d872e mtd: mchp23k256: drop unneeded MODULE_AL=
IAS)
Merging nand/nand/next (6819db94e1cd mtd: rawnand: hynix: fixed typo)
Merging spi-nor/spi-nor/next (4cece7649650 Linux 6.9-rc1)
Merging crypto/master (543ea178fbfa crypto: x86/aes-xts - optimize size of =
instructions operating on lengths)
Merging drm/drm-next (0208ca55aa9c Backmerge tag 'v6.9-rc5' into drm-next)
Merging drm-exynos/for-linux-next (5d2c7cc9c1b3 drm/exynos: mixer: drop dri=
ver owner initialization)
Merging drm-misc/for-linux-next (6abe93b621ab drm/v3d: Fix race-condition b=
etween sysfs/fdinfo and interrupt handler)
Merging amdgpu/drm-next (d60dc4dd7241 drm/amdgpu: Add interface to reserve =
bad page)
Merging drm-intel/for-linux-next (6068bc209ac8 drm/i915/dsi: pass display t=
o register macros instead of implicit variable)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (3e5a516f3bf1 Merge tag 'phy_dp_modes_6.10' into m=
sm-next-lumag)
Merging drm-msm-lumag/msm-next-lumag (104e548a7c97 drm/msm/mdp4: use drmm-m=
anaged allocation for mdp4_plane)
Merging drm-xe/drm-xe-next (869e54d4d54b drm/xe: make xe_pm_runtime_lockdep=
_map a static struct)
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_device_types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/xe/xe_vm_types.h
Merging etnaviv/etnaviv/next (b735ee173f84 drm/etnaviv: Restore some id val=
ues)
Merging fbdev/for-next (fb3b9c2d217f video: logo: Drop full path of the inp=
ut filename in generated file)
Merging regmap/for-next (991b5e2aad87 regmap: kunit: Fix an NULL vs IS_ERR(=
) check)
Merging sound/for-next (3a56855bb549 ALSA: scarlett2: Zero initialize ret i=
n scarlett2_ag_target_ctl_get())
Merging ieee1394/for-next (0d4149e5e9b0 firewire: ohci: use pci_irq_vector(=
) to retrieve allocated interrupt line)
Merging sound-asoc/for-next (239a45349780 Merge remote-tracking branch 'aso=
c/for-6.10' into asoc-next)
Merging modules/modules-next (41ca2e5a670b bpf: remove CONFIG_BPF_JIT depen=
dency on CONFIG_MODULES of)
CONFLICT (content): Merge conflict in arch/powerpc/mm/mem.c
CONFLICT (content): Merge conflict in kernel/module/main.c
$ git reset --hard HEAD^
Merging next-20240423 version of modules
CONFLICT (content): Merge conflict in kernel/module/main.c
[master af5214ede1c1] next-20240423/modules
Merging input/next (9e0631695eac input: pm8xxx-vibrator: add new SPMI vibra=
tor support)
Merging block/for-next (12c12fbada5c Merge branch 'for-6.10/block' into for=
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
Merging mmc/next (bce42d6108c9 mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (0398a09c7b13 mfd: bd71828: Remove commented code =
lines)
CONFLICT (content): Merge conflict in drivers/mfd/intel-lpss-pci.c
Merging backlight/for-backlight-next (df012cf5c42e backlight: otm3225a: Dro=
p driver owner assignment)
Merging battery/for-next (50f0ff7c8cc4 power: supply: bq27xxx: Move health =
reading out of update loop)
Merging regulator/for-next (f7638784bd0c Merge remote-tracking branch 'regu=
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
Merging iommu/next (d02a66d84baa Merge branches 'memory-observability' and =
'core' into next)
CONFLICT (content): Merge conflict in drivers/iommu/amd/amd_iommu.h
Merging audit/next (4cece7649650 Linux 6.9-rc1)
Merging devicetree/for-next (669430b183fc of: property: fw_devlink: Add sup=
port for "power-supplies" binding)
CONFLICT (content): Merge conflict in drivers/of/dynamic.c
CONFLICT (content): Merge conflict in drivers/of/property.c
Merging dt-krzk/for-next (adfecb01c288 Merge branches 'next/dt' and 'next/d=
t64' into for-next)
Merging mailbox/for-next (8df6bab6cb9a mailbox: imx: support i.MX95 Generic=
/ELE/V2X MU)
Merging spi/for-next (5343a65e03e4 Merge remote-tracking branch 'spi/for-6.=
10' into spi-next)
Merging tip/master (5a04007fb7a9 Merge branch into tip/master: 'x86/shstk')
Merging clockevents/timers/drivers/next (8248ca30ef89 clocksource/drivers/t=
imer-riscv: Clear timer interrupt on timer initialization)
Merging edac/edac-for-next (8e95536e9495 Merge branch ras/edac-misc into fo=
r-next)
Merging ftrace/for-next (7604256cecef tracing: Add __string_src() helper to=
 help compilers not to get confused)
Merging rcu/rcu/next (b93b7b4635f1 ftrace: Asynchronous grace period for re=
gister_ftrace_direct())
Merging kvm/next (a96cb3bf390e Merge x86 bugfixes from Linux 6.9-rc3)
CONFLICT (content): Merge conflict in arch/x86/kvm/svm/svm.c
Merging kvm-arm/next (47de86165eea Merge branch kvm-arm64/nv-eret-pauth int=
o kvmarm-master/next)
Merging kvms390/next (39cd87c4eb2b Linux 6.9-rc2)
Merging kvm-ppc/topic/ppc-kvm (41bccc98fb79 Linux 6.8-rc2)
Merging kvm-riscv/riscv_kvm_next (f1c48c1ec735 RISC-V: KVM: selftests: Add =
ebreak test support)
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
Merging chrome-platform/for-next (70a5f3005008 platform/chrome: cros_ec_lpc=
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
Merging usb/usb-next (0d31ea587709 Merge 6.9-rc5 into usb-next)
Applying: fix up for "usb: misc: onboard_hub: rename to onboard_dev"
Merging thunderbolt/next (d4d336f8c4d5 thunderbolt: No need to loop over al=
l retimers if access fails)
Merging usb-serial/usb-next (39cd87c4eb2b Linux 6.9-rc2)
Merging tty/tty-next (660a70809856 Merge 6.9-rc5 into tty-next)
Merging char-misc/char-misc-next (7732ce06ed8a Merge tag 'iio-for-6.10a' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-n=
ext)
Merging accel/habanalabs-next (576d7cc5a9e2 accel: constify the struct devi=
ce_type usage)
Merging coresight/next (d6fc00d0f640 coresight: etm4x: Fix access to resour=
ce selector registers)
Merging fastrpc/for-next (4cece7649650 Linux 6.9-rc1)
Merging fpga/for-next (b7c0e1ecee40 fpga: region: add owner module and take=
 its refcount)
Merging icc/icc-next (230d05b1179f interconnect: qcom: qcm2290: Fix mas_sno=
c_bimc QoS port assignment)
Merging iio/togreg (b80ad8e3cd27 iio: adc: ti-ads131e08: Use device_for_eac=
h_child_node_scoped() to simplify error paths.)
Merging phy-next/next (9c79b779643e phy: rockchip: fix CONFIG_TYPEC depende=
ncy)
Merging soundwire/next (4cd5ea6de156 soundwire: intel_init: resume all devi=
ces on exit.)
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
Merging dmaengine/next (98f2233a5c20 dmaengine: pl08x: Use kcalloc() instea=
d of kzalloc())
Merging cgroup/for-next (04d63da4da53 cgroup/cpuset: Fix incorrect top_cpus=
et flags)
Merging scsi/for-next (99033e81ab05 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (f92141e18c8b Merge patch series "convert SCSI to=
 atomic queue limits, part 1 (v3)")
CONFLICT (content): Merge conflict in block/blk-settings.c
CONFLICT (content): Merge conflict in include/linux/blkdev.h
Merging vhost/linux-next (24ddee0ff8c3 Merge tag 'stable/vduse-virtio-net' =
into vhost)
CONFLICT (content): Merge conflict in drivers/virtio/virtio_mem.c
Merging rpmsg/for-next (0e8de59db6c3 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (8a7a61032587 gpiolib: Get rid of never fal=
se gpio_is_valid() calls)
Merging gpio-intel/for-next (1736df17fea0 gpiolib: acpi: Set label for IRQ =
only lines)
Merging pinctrl/for-next (85fb4a0fad95 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (5d10a157ebe0 pinctrl: baytrail: Add pinconf=
 group for uart3)
Merging pinctrl-renesas/renesas-pinctrl (21fc4d195922 pinctrl: renesas: r8a=
779h0: Add INTC-EX pins, groups, and function)
Merging pinctrl-samsung/for-next (4184e4912ca6 dt-bindings: pinctrl: samsun=
g: drop unused header with register constants)
Merging pwm/pwm/for-next (8f33f980dcfe dt-bindings: pwm: mediatek,pwm-disp:=
 add compatible for mt8365 SoC)
Merging ktest/for-next (07283c1873a4 ktest: force $buildonly =3D 1 for 'mak=
e_warnings_file' test type)
Merging kselftest/next (00ab560eb0e3 selftests: Mark ksft_exit_fail_perror(=
) as __noreturn)
Merging kunit/test (4cece7649650 Linux 6.9-rc1)
Merging kunit-next/kunit (63761ec5971e kunit: unregister the device on erro=
r)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (1c431b92e21b dt-bindings: rtc: convert trivial device=
s into dtschema)
Merging nvdimm/libnvdimm-for-next (d9212b35da52 dax: remove SLAB_MEM_SPREAD=
 flag usage)
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
Merging kgdb/kgdb/for-next (5b6d8ef6f056 kdb: Use str_plural() to fix Cocci=
nelle warning)
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (813e0ae613d6 bus: mhi: host: Add mhi_power_down_keep_=
dev() API to support system suspend/hibernation)
Merging memblock/for-next (e5d1fdecfaf8 mm/memblock: remove empty dummy ent=
ry)
Merging cxl/next (87971c973f5c cxl/hdm: dev_warn() on unsupported mixed mod=
e decoder)
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (cda30c6542c8 efi: Clear up misconceptions about a maximum=
 variable name size)
Merging unicode/for-next (0131c1f3cce7 unicode: make utf8 test count static)
Merging slab/slab/for-next (b3d8a8e87014 slub: use count_partial_free_appro=
x() in slab_out_of_memory())
Merging random/master (2668e3ae2ef3 Merge tag 'scsi-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging landlock/next (dc792a74600a fs/ioctl: Add a comment to keep the log=
ic in sync with LSM policies)
Merging rust/rust-next (2c1092853f16 rust: kernel: remove usage of `allocat=
or_api` unstable feature)
Merging sysctl/sysctl-next (12e78b868481 sysctl: drop now unnecessary out-o=
f-bounds check)
Merging execve/for-next/execve (a9c3475dd67b Replace macro "ARCH_HAVE_EXTRA=
_ELF_NOTES" with kconfig)
Merging bitmap/bitmap-for-next (36a71c558b3e sched/topology: Optimize topol=
ogy_span_sane())
Merging hte/for-next (297f26dbf870 hte: tegra-194: Convert to platform remo=
ve callback returning void)
Merging kspp/for-next/kspp (716bc9b1c255 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (0adab2b6b733 tools/nolibc: add support for uname(2))
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (4cece7649650 Linux 6.9-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/Qf6HOUJyW3c85g76d0NsWm+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYo3RgACgkQAVBC80lX
0Gz7QQf9G44msd6EIhQvuwwdU36tENey4eqUoIXD9NoEbFTS9RnYdtJ4WFhb3yky
xwsNkonv/rRD3UISHC5Kg3HgNyL5KwbdJ2+MtleuHxPR3DoD8dxLDFLLDI1PznN6
Oxq3nUe61LXqOTXQyWSKQZEfzmUDDWkFC8ln34PN8+UiU/wtfL6PLF8fAoJzDFO9
KWueWYETi6qa05yFKOA8OGAnSVijM+kZeo1hkyBWbtmaXuyfOJ2y5UrXxupO0Bq0
w+cS0McEP0yNG23S6IIfncl/hwF7MeohbbfoKC8YBeIprrhfoJD7/l+63+RZ5eY8
1Ug0jrfzvcOx5rTRpngUv84F2udReQ==
=cF7I
-----END PGP SIGNATURE-----

--Sig_/Qf6HOUJyW3c85g76d0NsWm+--

