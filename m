Return-Path: <linux-kernel+bounces-49182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7158466E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943141C24318
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC1EAF2;
	Fri,  2 Feb 2024 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CzCz77YC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14769E54E;
	Fri,  2 Feb 2024 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847253; cv=none; b=tLxI+HrOLCLmStCAHnMfeMMpvnmwYFq42veiUHxKUliIc6WHPCHLVFYu/6vEAlOp+r/QCGC89wbQ7ihsfJJmN1IufndKm4laJF4qq34yr4n/1VCF1hjFYnmItc9iRPSoWsf2wiW4R1aRryRqPBGXE31NSs2h0ZwnP1zasZqQo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847253; c=relaxed/simple;
	bh=+45mM4HUecZdjzeMsai0mOCKuhdXrC/v9dlgqlcR9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JWxKV1c1v517S24IjtV9DdjTyqn3XTsPmt7STcUJck3N8QI4UHjmsywSW6g7tHtyelc6AbF/pMYq5Oo9avoD3Xyr0jCFDuuMn1Z4pRku65Ii0q/0JsdYZ1nH5x1YaWvi67Cy0wYRvnG6AgWjvHYeJre8i6NFQvdJaty5eGBwlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=CzCz77YC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706847247;
	bh=fmDXtZa5eBvVM4go2h32bnECCy9hlp3RvWcpsSjsLNU=;
	h=Date:From:To:Cc:Subject:From;
	b=CzCz77YCcfYDSHXKXKZXmJ8Q/e/JZ3kQvDCEbj6DEhxd3Jkjk3l//vWCnnSxaSGSv
	 hSfo1F6E8JUIwc4Vss0pmN5xcHGL+Olxlap/eD9idgZ79ZKO4aREuvxZYxJeV88g6S
	 R5AYpA1RAMIkdFYQd13pORbz93+oQK4HQfNGvDJLSECcgI13EwptXGSYJWYG3je9A4
	 6toVN4CIgV6GLVgbuXRXRXQgy4/gw49gZM/0fbDnwWQUYDNIvFdOD6pCYM/P3RysCb
	 HJB2J1/nd2vBVvFEVuh9HR3sHy6aoO+glQakSAkipZCRTT7m60TIVb1dcDKMja4FnA
	 WtLqbsYoai8CA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TR2TW1F5bz4wcM;
	Fri,  2 Feb 2024 15:14:07 +1100 (AEDT)
Date: Fri, 2 Feb 2024 15:14:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 2
Message-ID: <20240202151406.23f379d3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/19EtE/22t1GufyQFojzmm99";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/19EtE/22t1GufyQFojzmm99
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20240201:

The mm tree still had its build failure for which I applied a spuulied patc=
h.

The bpf-next tree lost its runtime warnings.

The ieee1394 tree gained a build failure so I dropped it for today.

The modules tree gained a build failure for which I applied a hack patch.

The leds-lj tree still had its build failure so I used the version from
next-20240125.

Non-merge commits (relative to Linus' tree): 3094
 3447 files changed, 125014 insertions(+), 77912 deletions(-)

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

I am currently merging 368 trees (counting Linus' and 103 trees of bug
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
Merging origin/master (41b9fb381a48 Merge tag 'net-6.8-rc3' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (2dde18cd1d8f Linux 6.5)
Merging mm-hotfixes/mm-hotfixes-unstable (bbac2bacc158 mm/zswap: don't retu=
rn LRU_SKIP if we have dropped lru lock)
Merging kbuild-current/fixes (bfef491df670 kconfig: initialize sym->curr.tr=
i to 'no' for all symbol types again)
Merging arc-current/for-curr (861deac3b092 Linux 6.7-rc7)
Merging arm-current/fixes (f54e8634d136 ARM: 9330/1: davinci: also select P=
INCTRL)
Merging arm64-fixes/for-next/fixes (c7767f5c43df arm64: vdso32: Remove unus=
ed vdso32-offsets.h)
Merging arm-soc-fixes/arm/fixes (1b5af823d703 soc/tegra: fix build failure =
on Tegra241)
Merging davinci-current/davinci/for-current (6613476e225e Linux 6.8-rc1)
Merging drivers-memory-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging sophgo-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (6b9c045b0602 m68k: defconfig: Update defcon=
figs for v6.7-rc1)
Merging powerpc-fixes/fixes (18f14afe2816 powerpc/64s: Increase default sta=
ck size to 32KB)
Merging s390-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (4e192be1a225 Merge tag 'batadv-net-pullrequest-20240201' =
of git://git.open-mesh.org/linux-merge)
Merging bpf/master (577e4432f3ac tcp: add sanity checks to rx zerocopy)
Merging ipsec/master (983a73da1f99 xfrm: Pass UDP encapsulation in TX packe=
t offload)
Merging netfilter/main (8059918a1377 netfilter: nft_ct: sanitize layer 3 an=
d 4 protocol number in custom expectations)
Merging ipvs/main (8059918a1377 netfilter: nft_ct: sanitize layer 3 and 4 p=
rotocol number in custom expectations)
Merging wireless/for-next (aa125f229076 wifi: iwlwifi: remove extra kernel-=
doc)
Merging wpan/master (b85ea95d0864 Linux 6.7-rc1)
Merging rdma-fixes/for-rc (80dde187f734 RDMA/bnxt_re: Add a missing check i=
n bnxt_qplib_query_srq)
Merging sound-current/for-linus (d4ea2bd1bb50 Merge tag 'asoc-fix-v6.8-rc2-=
2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into fo=
r-linus)
Merging sound-asoc-fixes/for-linus (e81fdba02086 ALSA: Various fixes for Ci=
rrus Logic CS35L56 support)
Merging regmap-fixes/for-linus (8b921545ddc6 Merge remote-tracking branch '=
regmap/for-6.7' into regmap-linus)
Merging regulator-fixes/for-linus (a3fa9838e814 regulator (max5970): Fix IR=
Q handler)
Merging spi-fixes/for-linus (6500ad28fd5d spi: sh-msiof: avoid integer over=
flow in constants)
Merging pci-current/for-linus (925bd5e08106 MAINTAINERS: Add Manivannan Sad=
hasivam as PCI Endpoint maintainer)
Merging driver-core.current/driver-core-linus (98323e9d7017 topology: Set c=
apacity_freq_ref in all cases)
Merging tty.current/tty-linus (b35f8dbbce81 serial: max310x: prevent infini=
te while() loop in port startup)
Merging usb.current/usb-linus (f2e5d3de7e1f usb: typec: tcpm: fix the PD di=
sabled case)
Merging usb-serial-fixes/usb-linus (b4a1f4eaf1d7 USB: serial: option: add F=
ibocom FM101-GL variant)
Merging phy/fixes (7104ba0f1958 phy: ti: phy-omap-usb2: Fix NULL pointer de=
reference for SRP)
Merging staging.current/staging-linus (6613476e225e Linux 6.8-rc1)
Merging iio-fixes/fixes-togreg (6f6c72acddf4 iio: move LIGHT_UVA and LIGHT_=
UVB to the end of iio_modifier)
Merging counter-current/counter-current (6613476e225e Linux 6.8-rc1)
Merging char-misc.current/char-misc-linus (97830f3c3088 binder: signal epol=
l threads of self-work)
Merging soundwire-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging thunderbolt-fixes/fixes (ec4d82f855ce thunderbolt: Fix setting the =
CNS bit in ROUTER_CS_5)
Merging input-current/for-linus (2b9c3eb32a69 Input: bcm5974 - check endpoi=
nt type before starting traffic)
Merging crypto-current/master (c5a2f74db71a crypto: caam - fix asynchronous=
 hash)
Merging vfio-fixes/for-linus (4ea95c04fa6b vfio: Drop vfio_file_iommu_group=
() stub to fudge around a KVM wart)
Merging kselftest-fixes/fixes (b54761f6e977 kselftest/seccomp: Report each =
expectation we assert as a KTAP test)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (a22fe1d6dec7 dmaengine: fix is_slave_directi=
on() return false when DMA_DEV_TO_DEV)
Merging backlight-fixes/for-backlight-fixes (6613476e225e Linux 6.8-rc1)
Merging mtd-fixes/mtd/fixes (7c1b1906229d mtd: spinand: gigadevice: Fix the=
 get ecc status issue)
Merging mfd-fixes/for-mfd-fixes (6613476e225e Linux 6.8-rc1)
Merging v4l-dvb-fixes/fixes (346c84e281a9 media: pwm-ir-tx: Depend on CONFI=
G_HIGH_RES_TIMERS)
Merging reset-fixes/reset/fixes (4a6756f56bcf reset: Fix crash when freeing=
 non-existent optional resets)
Merging mips-fixes/mips-fixes (59be5c358501 mips: Call lose_fpu(0) before i=
nitializing fcr31 in mips_set_personality_nan)
Merging at91-fixes/at91-fixes (6613476e225e Linux 6.8-rc1)
Merging omap-fixes/fixes (9b6a51aab5f5 ARM: dts: Fix occasional boot hang f=
or am3 usb)
Merging kvm-fixes/master (a9ef277488cf x86/kvm: Fix SEV check in sev_map_pe=
rcpu_data())
Merging kvms390-fixes/master (83303a4c776c KVM: s390: fix cc for successful=
 PQAP)
Merging hwmon-fixes/hwmon (915644189c22 hwmon: (pmbus/mp2975) Correct comme=
nt inside 'mp2975_read_byte_data')
Merging nvdimm-fixes/libnvdimm-fixes (33908660e814 ACPI: NFIT: Fix incorrec=
t calculation of idt size)
Merging cxl-fixes/fixes (6be99530c92c x86/numa: Fix the sort compare func u=
sed in numa_fill_memblks())
Merging btrfs-fixes/next-fixes (c94bd41cb0b6 Merge branch 'misc-6.8' into n=
ext-fixes)
Merging vfs-fixes/fixes (485053bb81c8 fix ufs_get_locked_folio() breakage)
Merging dma-mapping-fixes/for-linus (d5090484b021 swiotlb: do not try to al=
locate a TLB bigger than MAX_ORDER pages)
Merging drivers-x86-fixes/fixes (1abdf288b0ef platform/x86: touchscreen_dmi=
: Add info for the TECLAST X16 Plus tablet)
Merging samsung-krzk-fixes/fixes (eab4f56d3e75 ARM: dts: exynos4212-tab3: a=
dd samsung,invert-vclk flag to fimd)
Merging pinctrl-samsung-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging devicetree-fixes/dt/linus (607aad1e4356 of: unittest: Fix compile i=
n the non-dynamic case)
Merging dt-krzk-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging scsi-fixes/fixes (f4469f385835 scsi: storvsc: Fix ring buffer size =
calculation)
Merging drm-fixes/drm-fixes (41bccc98fb79 Linux 6.8-rc2)
Merging drm-intel-fixes/for-linux-next-fixes (41bccc98fb79 Linux 6.8-rc2)
Merging mmc-fixes/fixes (41bccc98fb79 Linux 6.8-rc2)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (41bccc98fb79 Linux 6.8-rc2)
Merging hyperv-fixes/hyperv-fixes (564eac2860bd hv_utils: Allow implicit IC=
TIMESYNCFLAG_SYNC)
Merging soc-fsl-fixes/fix (06c2afb862f9 Linux 6.5-rc1)
Merging risc-v-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging riscv-dt-fixes/riscv-dt-fixes (6613476e225e Linux 6.8-rc1)
Merging riscv-soc-fixes/riscv-soc-fixes (a9d022ae8c4f Merge branch 'riscv-s=
oc-drivers-fixes' into riscv-soc-fixes)
Merging fpga-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging spdx/spdx-linus (6613476e225e Linux 6.8-rc1)
Merging gpio-brgl-fixes/gpio/for-current (41bccc98fb79 Linux 6.8-rc2)
Merging gpio-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pinctrl-intel-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging erofs-fixes/fixes (d9281660ff3f erofs: relaxed temporary buffers al=
location on readahead)
Merging kunit-fixes/kunit-fixes (1a9f2c776d14 Documentation: KUnit: Update =
the instructions on how to test static functions)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (6a9531c3a880 memblock: fix crash when reserve=
d memory is not added to memory)
Merging nfsd-fixes/nfsd-fixes (ccbca118ef1a NFSv4.1: Assign the right value=
 for initval and retries for rpc timeout)
Merging renesas-fixes/fixes (9eab43facdad soc: renesas: ARCH_R9A07G043 depe=
nds on !RISCV_ISA_ZICBOM)
Merging perf-current/perf-tools (fdd0ae72b34e perf tools headers: update th=
e asm-generic/unaligned.h copy with the kernel sources)
Merging efi-fixes/urgent (aa0e784dea7c efi/libstub: Add one kernel-doc comm=
ent)
Merging zstd-fixes/zstd-linus (77618db34645 zstd: Fix array-index-out-of-bo=
unds UBSAN warning)
Merging battery-fixes/fixes (d0266d7ab161 Revert "power: supply: qcom_battm=
gr: Register the power supplies after PDR is up")
Merging uml-fixes/fixes (73a23d771033 um: harddog: fix modular build)
Merging iommufd-fixes/for-rc (6613476e225e Linux 6.8-rc1)
Merging rust-fixes/rust-fixes (6613476e225e Linux 6.8-rc1)
Merging v9fs-fixes/fixes/next (6613476e225e Linux 6.8-rc1)
Merging w1-fixes/fixes (6613476e225e Linux 6.8-rc1)
Merging pmdomain-fixes/fixes (c41336f4d690 pmdomain: mediatek: fix race con=
ditions with genpd)
Merging overlayfs-fixes/ovl-fixes (420332b94119 ovl: mark xwhiteouts direct=
ory with overlay.opaque=3D'x')
Merging i2c-host-fixes/i2c/i2c-host-fixes (9189526c46f2 MAINTAINERS: Update=
 i2c host drivers repository)
Merging drm-misc-fixes/for-linux-next-fixes (1c1914d6e8c6 dma-buf: heaps: D=
on't track CMA dma-buf pages under RssFile)
Merging mm-stable/mm-stable (6613476e225e Linux 6.8-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (6613476e225e Linux 6.8-rc1)
Merging mm/mm-everything (ec2dacea82ce Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Applying: stackdepot: fix -Wstringop-overflow warning
Merging kbuild/for-next (bd768db42ef6 kbuild: deb-pkg: call more misc debhe=
lper commands)
Merging clang-format/clang-format (5a205c6a9f79 clang-format: Update with v=
6.7-rc4's `for_each` macro list)
Merging perf/perf-tools-next (7727d59de44e perf tools: Add -H short option =
for --hierarchy)
Merging compiler-attributes/compiler-attributes (2993eb7a8d34 Compiler Attr=
ibutes: counted_by: fixup clang URL)
Merging dma-mapping/for-next (7c65aa3cc072 dma-debug: fix kernel-doc warnin=
gs)
Merging asm-generic/master (34b2321cc648 MAINTAINERS: Add Andreas Larsson a=
s co-maintainer for arch/sparc)
Merging arc/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging arm/for-next (8790fade1a19 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (1b20d0486a60 arm64: Fix silcon-errata.rst form=
atting)
Merging arm-perf/for-next/perf (bb339db4d363 arm: perf: Fix ARCH=3Darm buil=
d with GCC)
Merging arm-soc/for-next (de4b6d6705a7 Merge branch 'soc/defconfig' into fo=
r-next)
Merging amlogic/for-next (0dd3ee311255 Linux 6.7)
Merging asahi-soc/asahi-soc/for-next (ffc253263a13 Linux 6.6)
Merging aspeed/for-next (e60f7a99d378 ARM: dts: aspeed: minerva: add sgpio =
line name)
Merging at91/at91-next (6613476e225e Linux 6.8-rc1)
Merging broadcom/next (412c6bd2c649 Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (6613476e225e Linux 6.8-rc1)
Merging drivers-memory/for-next (2f542c937c48 dt-bindings: memory-controlle=
rs: narrow regex for unit address to hex numbers)
Merging imx-mxs/for-next (a136406ec0c3 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (9802b60bd6d8 Merge branch 'v6.6-next/soc' into f=
or-next)
Merging mvebu/for-next (476887312c60 Merge branch 'mvebu/drivers' into mveb=
u/for-next)
Merging omap/for-next (0012c1958460 Merge branches 'sgx-for-v6.9' and 'omap=
-for-v6.9/soc' into for-next)
Merging qcom/for-next (24b0e1192539 Merge branches 'arm32-for-6.9', 'arm64-=
defconfig-for-6.9', 'arm64-fixes-for-6.8', 'arm64-for-6.9', 'clk-for-6.9' a=
nd 'drivers-for-6.9' into for-next)
Merging renesas/next (6fc5bb9da080 Merge branches 'renesas-arm-defconfig-fo=
r-v6.9', 'renesas-drivers-for-v6.9', 'renesas-dt-bindings-for-v6.9' and 're=
nesas-dts-for-v6.9' into renesas-next)
Merging reset/reset/next (c3c46acd5be9 dt-bindings: reset: hisilicon,hi3660=
-reset: Drop providers and consumers from example)
Merging rockchip/for-next (a3c323226362 Merge branch 'v6.9-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (8f5b7dbc644d Revert "arm64: dts: exynos: Add=
 SPI nodes for Exynos850")
Merging scmi/for-linux-next (99f798bdfb75 Merge tags 'scmi-fixes-6.8' and '=
ffa-fixes-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux into for-linux-next)
Merging sophgo/for-next (41bccc98fb79 Linux 6.8-rc2)
Merging stm32/stm32-next (bda732fda193 ARM: dts: stm32: fix DSI peripheral =
clock on stm32mp15 boards)
Merging sunxi/sunxi/for-next (38ed19495066 Merge branch 'sunxi/dt-for-6.9' =
into sunxi/for-next)
Merging tee/next (84ec4fd88831 Merge branch 'tee_iov_iter_for_v6.8' into ne=
xt)
Merging tegra/for-next (b762ac6498e6 Merge branch for-6.9/soc into for-next)
  d820100a1bde ("soc/tegra: Fix build failure on Tegra241")
Merging ti/ti-next (6613476e225e Linux 6.8-rc1)
Merging xilinx/for-next (0ee74e0d7b97 Merge remote-tracking branch 'git/zyn=
qmp/dt' into for-next)
Merging clk/clk-next (efe5a1b888ab Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (f52f00069888 clk: imx: pll14xx: change naming of =
fvco to fout)
Merging clk-renesas/renesas-clk (096311157d2a clk: renesas: r8a779g0: Fix P=
CIe clock name)
Merging csky/linux-next (2c40c1c6adab Merge tag 'usb-6.7-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging loongarch/loongarch-next (48ef9e87b407 LoongArch: KVM: Add returns =
to SIMD stubs)
Merging m68k/for-next (6b9c045b0602 m68k: defconfig: Update defconfigs for =
v6.7-rc1)
Merging m68knommu/for-next (41bccc98fb79 Linux 6.8-rc2)
Merging microblaze/next (6613476e225e Linux 6.8-rc1)
Merging mips/mips-next (6613476e225e Linux 6.8-rc1)
Merging openrisc/for-next (c289330331eb openrisc: Remove kernel-doc marker =
from ioremap comment)
Merging parisc-hd/for-next (3bb4e1d02e7a parisc: Show kernel unaligned memo=
ry accesses)
Merging powerpc/next (44a1aad2fe6c Merge branch 'topic/ppc-kvm' into next)
Merging soc-fsl/next (fb9c384625dd bus: fsl-mc: fsl-mc-allocator: Drop a wr=
ite-only variable)
Merging risc-v/for-next (cb4ede926134 riscv: Avoid code duplication with ge=
neric bitops implementation)
Merging riscv-dt/riscv-dt-for-next (2db68ddbf33a riscv: dts: starfive: beag=
lev-starlight: Setup phy reset gpio)
Merging riscv-soc/riscv-soc-for-next (6613476e225e Linux 6.8-rc1)
Merging s390/for-next (8eb3db95a8c8 Merge branch 'features' into for-next)
Merging sh/for-next (6613476e225e Linux 6.8-rc1)
Merging uml/next (83aec96c631e um: Mark 32bit syscall helpers as clobbering=
 memory)
Merging xtensa/xtensa-for-next (a03cd7602a09 xtensa: don't produce FDPIC ou=
tput with fdpic toolchain)
Merging bcachefs/for-next (46f394768bf2 bcachefs: btree node prefetching in=
 check_topology)
Merging pidfd/for-next (a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fscrypt/for-next (5befc19caec9 fscrypt: explicitly require that ino=
de->i_blkbits be set)
Merging afs/afs-next (abcbd3bfbbfe afs: trace: Log afs_make_call(), includi=
ng server address)
Merging btrfs/for-next (932ab07c383e Merge branch 'for-next-next-v6.8-20240=
108' into for-next-20240108)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
Merging ceph/master (ded080c86b3f rbd: don't move requests to the running l=
ist on errors)
Merging cifs/for-next (bb1ec303384b smb: client: parse uid, gid, mode and d=
ev from WSL reparse points)
Merging configfs/for-next (4425c1d9b44d configfs: improve item creation per=
formance)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (aa12a790d31b erofs: make erofs_{err,info}() support NULL=
 sb parameter)
Merging exfat/dev (0991abeddefa exfat: fix zero the unwritten part for dio =
read)
Merging exportfs/exportfs-next (42c3732fa807 fs: Create a generic is_dot_do=
tdot() utility)
Merging ext3/for_next (cd04011c5859 Merge fsnotify optimization & cleanup f=
rom Amir.)
Merging ext4/dev (68da4c44b994 ext4: fix inconsistent between segment fstri=
m and full fstrim)
Merging f2fs/dev (f31438c16879 f2fs: fix to avoid potential panic during re=
covery)
Merging fsverity/for-next (919dc320956e fsverity: skip PKCS#7 parser when k=
eyring is empty)
Merging fuse/for-next (3f29f1c336c0 fuse: disable FOPEN_PARALLEL_DIRECT_WRI=
TES with FUSE_DIRECT_IO_ALLOW_MMAP)
Merging gfs2/for-next (acd2d246f4b2 gfs2: Fix LOOKUP_RCU support in gfs2_dr=
evalidate)
Merging jfs/jfs-next (e42e29cc4423 Revert "jfs: fix shift-out-of-bounds in =
dbJoin")
Merging ksmbd/ksmbd-for-next (41bccc98fb79 Linux 6.8-rc2)
Merging nfs/linux-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging nfs-anna/linux-next (57331a59ac0d NFSv4.1: Use the nfs_client's rpc=
 timeouts for backchannel)
Merging nfsd/nfsd-next (6c1c91f97746 nfsd: Simplify the allocation of slab =
caches in nfsd_file_cache_init)
Merging ntfs3/master (622cd3daa8ea fs/ntfs3: Slightly simplify ntfs_inode_p=
rintk())
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (d17bb4620f90 overlayfs.rst: fix ReST form=
atting)
Merging ubifs/next (adbf4c4954e3 ubi: block: fix memleak in ubiblock_create=
())
Merging v9fs/9p-next (ff49bf186757 net: 9p: avoid freeing uninit memory in =
p9pdu_vreadf)
Merging v9fs-ericvh/ericvh/for-next (be57855f5050 fs/9p: fix dups even in u=
ncached mode)
Merging xfs/for-next (881f78f47255 xfs: remove conditional building of rt g=
eometry validator functions)
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
Merging vfs-brauner/vfs.all (6d3af66d84ce Merge branch 'vfs.netfs' into vfs=
all)
Merging vfs/for-next (052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat)
Merging printk/for-next (6c3a34e38436 Merge branch 'for-6.8' into for-next)
Merging pci/next (95bf9132f8b4 Merge branch 'pci/dpc')
Merging pstore/for-next/pstore (69f381e67d6f pstore/zone: Add a null pointe=
r check to the psz_kmsg_read)
Merging hid/for-next (a54f72c74c2d Merge branch 'for-6.8/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (41bccc98fb79 Linux 6.8-rc2)
Merging i2c-host/i2c/i2c-host (2f9af34c79ff i2c: hisi: Add clearing tx aemp=
ty interrupt operation)
Merging i3c/i3c/next (4fa0888f6f3e i3c: document hotjoin sysfs entry)
Merging hwmon-staging/hwmon-next (6120fec68e78 hwmon: ltc4282: add support =
for the LTC4282 chip)
Merging jc_docs/docs-next (5c7944ca7b13 coding-style: Add guidance to prefe=
r dev_dbg)
Merging v4l-dvb/master (41bccc98fb79 Linux 6.8-rc2)
Merging v4l-dvb-next/master (feb8831be9d4 media: ov08x40: Reduce start stre=
aming time)
  592bb51d048c ("media: atomisp: Adjust for v4l2_subdev_state handling chan=
ges in 6.8")
CONFLICT (content): Merge conflict in drivers/staging/media/atomisp/pci/ato=
misp_cmd.c
Merging pm/linux-next (7543bfcb6b1a Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (eaffb10b51bf cpufreq: mediatek-=
hw: Don't error out if supply is not found)
Merging cpupower/cpupower (0086ffec768b tools cpupower bench: Override CFLA=
GS assignments)
Merging devfreq/devfreq-next (aed5ed595960 PM / devfreq: Synchronize devfre=
q_monitor_[start/stop])
Merging pmdomain/next (90a7463fae9e pmdomain: renesas: r8a779h0-sysc: Add r=
8a779h0 support)
Merging opp/opp/linux-next (ace4b31b297d cpufreq: Move dev_pm_opp_{init|fre=
e}_cpufreq_table() to pm_opp.h)
Merging thermal/thermal/linux-next (5314b1543787 thermal/drivers/exynos: Us=
e set_trips ops)
Merging dlm/next (5beebc1dda47 dlm: update format header reflect current fo=
rmat)
Merging rdma/for-next (a400073ce3dd RDMA/mlx5: Delete unused mlx5_ib_copy_p=
as prototype)
Merging net-next/main (cacfd6bfc381 Merge branch 'dpll-expose-lock-status-e=
rror-value-to-user')
Merging bpf-next/for-next (943b043aeecc selftests/bpf: Fix bench runner SIG=
SEGV)
Merging ipsec-next/master (ab1e1a38de24 xfrm6_tunnel: Use KMEM_CACHE instea=
d of kmem_cache_create)
Merging mlx5-next/mlx5-next (d727d27db536 RDMA/mlx5: Expose register c0 for=
 RDMA device)
Merging netfilter-next/main (5264ab612e28 selftests/net: calibrate txtimest=
amp)
Merging ipvs-next/main (5264ab612e28 selftests/net: calibrate txtimestamp)
Merging bluetooth/master (64692e12507b Bluetooth: qca: Fix wrong event type=
 for patch config command)
Merging wireless-next/for-next (3fbf61207c66 Revert "mlx5 updates 2023-12-2=
0")
Merging wpan-next/master (2373699560a7 mac802154: Avoid new associations wh=
ile disassociating)
Merging wpan-staging/staging (2373699560a7 mac802154: Avoid new association=
s while disassociating)
Merging mtd/mtd/next (98d4fda8f2d4 Merge tag 'nand/for-6.8' into mtd/next)
Merging nand/nand/next (023e6aad7e5e mtd: rawnand: s3c2410: fix Excess stru=
ct member description kernel-doc warnings)
Merging spi-nor/spi-nor/next (3c0e1dfa703c MAINTAINERS: change my mail to t=
he kernel.org one)
Merging crypto/master (4d314d27130b dt-bindings: crypto: ice: Document SC71=
80 inline crypto engine)
Merging drm/drm-next (41bccc98fb79 Linux 6.8-rc2)
Merging drm-ci/topic/drm-ci (ad6bfe1b66a5 drm: ci: docs: fix build warning =
- add missing escape)
Merging drm-exynos/for-linux-next (41bccc98fb79 Linux 6.8-rc2)
Merging drm-misc/for-linux-next (1f1626ac0428 drm/ttm: fix ttm pool initial=
ization for no-dma-device drivers)
Merging amdgpu/drm-next (9217b91c6458 drm/amdgpu: Reset IH OVERFLOW_CLEAR b=
it)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
Merging drm-intel/for-linux-next (fe4c6ff50c68 drm/i915/xe2lpd: Move regist=
ers to PICA)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (d4ca26ac4be0 drm/msm/dp: call dp_display_get_next=
_bridge() during probe)
Merging drm-msm-lumag/msm-next-lumag (d4ca26ac4be0 drm/msm/dp: call dp_disp=
lay_get_next_bridge() during probe)
Merging etnaviv/etnaviv/next (c9959996a8fc drm/etnaviv: add sensitive state=
 for PE_RT_ADDR_4_PIPE(3, 0|1) address)
Merging fbdev/for-next (72fee6b0a3a4 fbdev: Restrict FB_SH_MOBILE_LCDC to S=
uperH)
Merging regmap/for-next (a1214cdfe92b Merge branch 'regmap-linus' into regm=
ap-next)
Merging sound/for-next (8b87a7863fa5 Merge branch 'topic/format-kunit' into=
 for-next)
Merging ieee1394/for-next (7e9ce9dfce16 firewire: Convert snprintf/sprintf =
to sysfs_emit)
$ git reset --hard HEAD^
Merging sound-asoc/for-next (e5739397e067 Merge remote-tracking branch 'aso=
c/for-6.9' into asoc-next)
Merging modules/modules-next (bacf2c5f7681 lib/test_kmod: fix kernel-doc wa=
rnings)
Merging input/next (7d0f351da460 Input: matrix_keypad - switch to using man=
aged resources)
Merging block/for-next (b48b5a7c9bc1 Merge branch 'block-deadline' into for=
-next)
Merging device-mapper/for-next (4eacc39d5529 dm-crypt, dm-verity: disable t=
asklets)
Merging libata/for-next (c8474c7273ac Merge remote-tracking branch 'libata/=
for-6.8-fixes' into for-next)
Merging pcmcia/pcmcia-next (4f733de8b78a pcmcia: tcic: remove unneeded "&" =
in call to setup_timer())
Merging mmc/next (4e99ffb173fa mmc: core Drop BLK_BOUNCE_HIGH)
Merging mfd/for-mfd-next (1e0ea9e75ff3 mfd: wm831x: Remove redundant foreve=
r while loop)
Merging backlight/for-backlight-next (3b75d271e161 backlight: hx8357: Fix p=
otential NULL pointer dereference)
Merging battery/for-next (cad1e6df54ca power: supply: wm8350: Use devm_powe=
r_supply_register() helper)
Merging regulator/for-next (a2fc922ece40 Merge remote-tracking branch 'regu=
lator/for-6.9' into regulator-next)
Applying: selftests: disable TEST_KALLSYMS_D for now
Merging security/next (5a287d3d2b9d lsm: fix default return value of the so=
cket_getpeersec_*() hooks)
Merging apparmor/apparmor-next (8ead196be219 apparmor: Fix memory leak in u=
npack_profile())
Merging integrity/next-integrity (1ed4b5631002 Revert "KEYS: encrypted: Add=
 check for strsep")
Merging selinux/next (90593caf7db7 selinux: reduce the object class calcula=
tions at inode init time)
Merging smack/next (f0816d4332c3 ramfs: Initialize security of in-memory in=
odes)
Merging tomoyo/master (0bb80ecc33a8 Linux 6.6-rc1)
Merging tpmdd/next (cebb9ce9b939 tpm/tpm_ftpm_tee: fix all kernel-doc warni=
ngs)
Merging watchdog/master (41bccc98fb79 Linux 6.8-rc2)
Merging iommu/next (fae6e669cdc5 drm/tegra: Do not assume that a NULL domai=
n means no DMA IOMMU)
Merging audit/next (aa13b709084a audit: use KMEM_CACHE() instead of kmem_ca=
che_create())
Merging devicetree/for-next (85f838adad54 dt-bindings: fpga: Convert fpga-r=
egion binding to yaml)
Merging dt-krzk/for-next (8c82b4eef297 ARM: dts: sti: minor whitespace clea=
nup around '=3D')
Merging mailbox/for-next (cd795fb0c352 mailbox: mtk-cmdq: Add CMDQ driver s=
upport for mt8188)
Merging spi/for-next (0f10defa67e3 Merge remote-tracking branch 'spi/for-6.=
9' into spi-next)
Merging tip/master (b2803076903a Merge branch into tip/master: 'x86/mm')
Merging clockevents/timers/drivers/next (0076a37a426b dt-bindings: timer: r=
enesas,tmu: Document input capture interrupt)
Merging edac/edac-for-next (a771287a8e19 Merge branch 'edac-drivers' into e=
dac-for-next)
Merging ftrace/for-next (4af12c95cbe8 Merge probes/for-next)
Merging rcu/rcu/next (bc31e6cb27a9 rcu-tasks: Eliminate deadlocks involving=
 do_exit() and RCU tasks)
Merging kvm/next (a9ef277488cf x86/kvm: Fix SEV check in sev_map_percpu_dat=
a())
Merging kvm-arm/next (93c28484d2a0 Merge branch kvm-arm64/kerneldoc into kv=
marm/next)
Merging kvms390/next (10f7b1dcdfe0 KVM: s390: cpu model: Use proper define =
for facility mask size)
Merging kvm-ppc/topic/ppc-kvm (180c6b072bf3 KVM: PPC: Book3S HV nestedv2: D=
o not cancel pending decrementer exception)
Merging kvm-riscv/riscv_kvm_next (4d0e8f9a361b KVM: riscv: selftests: Add Z=
fa extension to get-reg-list test)
Merging kvm-x86/next (f0f3b810edda Merge branches 'generic', 'misc', 'pmu' =
and 'selftests')
Merging xen-tip/linux-next (2d2db7d40254 xen/gntdev: Fix the abuse of under=
lying struct page in DMA-buf import)
Merging percpu/for-next (2d9ad81ef935 Merge branch 'for-6.8-fixes' into for=
-next)
Merging workqueues/for-next (d49e20ca05ef Merge branch 'for-6.9' into for-n=
ext)
Merging drivers-x86/for-next (682c259a8496 platform/x86/intel/ifs: Remove u=
nnecessary initialization of 'ret')
Merging chrome-platform/for-next (6613476e225e Linux 6.8-rc1)
Merging chrome-platform-firmware/for-firmware-next (6613476e225e Linux 6.8-=
rc1)
Merging hsi/for-next (fa72d143471d HSI: omap_ssi: Remove usage of the depre=
cated ida_simple_xx() API)
Merging leds-lj/for-leds-next (54602f38551e leds: Make flash and multicolor=
 dependencies unconditional)
$ git reset --hard HEAD^
Merging next-20240125 version of leds-lj
Merging ipmi/for-next (296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc)
Merging driver-core/driver-core-next (f297a3844aa0 driver core: component: =
fix spellos)
Merging usb/usb-next (f1a27f081c1f usb: typec: qcom-pmic-typec: allow diffe=
rent implementations for the port backend)
Merging thunderbolt/next (dec6a613574c thunderbolt: Remove usage of the dep=
recated ida_simple_xx() API)
Merging usb-serial/usb-next (6613476e225e Linux 6.8-rc1)
Merging tty/tty-next (fccc9d9233f9 tty: serial: uartps: Add rs485 support t=
o uartps driver)
Merging char-misc/char-misc-next (390b60f7638a mei: pxp: add dependency on =
Xe driver)
Merging accel/habanalabs-next (dddb2e526a36 accel/habanalabs: use kcalloc()=
 instead of kzalloc())
Merging coresight/next (60e5f23dc5d6 coresight: ultrasoc-smb: Use guards to=
 cleanup)
Merging fastrpc/for-next (6613476e225e Linux 6.8-rc1)
Merging fpga/for-next (6613476e225e Linux 6.8-rc1)
Merging icc/icc-next (7158ba962f41 Merge branch 'icc-fixes' into icc-next)
Merging iio/togreg (a0295c1bd4a7 iio: frequency: admfm2000: New driver)
Merging phy-next/next (25ee21fc97db phy: qcom: sgmii-eth: move PCS register=
s to separate header)
CONFLICT (content): Merge conflict in drivers/phy/qualcomm/phy-qcom-qmp-usb=
c
Merging soundwire/next (0707496ff4e4 soundwire: stream: add missing const t=
o Documentation)
Merging extcon/extcon-next (7803680964c0 extcon: qcom-spmi-misc: don't use =
kernel-doc marker for comment)
Merging gnss/gnss-next (41bccc98fb79 Linux 6.8-rc2)
Merging vfio/next (78f70c02bdbc vfio/virtio: fix virtio-pci dependency)
Merging w1/for-next (6613476e225e Linux 6.8-rc1)
Merging spmi/spmi-next (b85ea95d0864 Linux 6.7-rc1)
Merging staging/staging-next (ce54e9342124 staging: Remove board staging co=
de)
Merging counter-next/counter-next (0b3bbd8f9baf counter: linux/counter.h: f=
ix Excess kernel-doc description warning)
Merging mux/for-next (44c026a73be8 Linux 6.4-rc3)
Merging dmaengine/next (93bdff7bb83a dmaengine: ti: k3-psil-j721s2: Add ent=
ry for CSI2RX)
Merging cgroup/for-next (8d4c171f451d docs: cgroup-v1: add missing code-blo=
ck tags)
Merging scsi/for-next (890d900e7fec Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (3f90ac7138ed Merge patch series "scsi: Allow scs=
i_execute users to request retries")
Merging vhost/linux-next (f16d65124380 vdpa/mlx5: Add mkey leak detection)
Merging rpmsg/for-next (99f59b148871 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (0bb80ecc33a8 Linux 6.6-rc1)
Merging gpio-brgl/gpio/for-next (6933ba529d06 gpio: improve the API contrac=
t for setting direction)
CONFLICT (content): Merge conflict in Documentation/userspace-api/index.rst
Merging gpio-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl/for-next (47eed1127d2a dt-bindings: pinctrl: amlogic: narro=
w regex for unit address to hex numbers)
Merging pinctrl-intel/for-next (6613476e225e Linux 6.8-rc1)
Merging pinctrl-renesas/renesas-pinctrl (fea58424e252 pinctrl: renesas: pin=
ctrl-rzg2l: Add the missing port pins P19 to P28)
Merging pinctrl-samsung/for-next (6613476e225e Linux 6.8-rc1)
Merging pwm/pwm/for-next (979c6fe7e799 dt-bindings: pxa-pwm: Convert to YAM=
L)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (6a71770442b5 selftests: livepatch: Test livepatchin=
g a heavily called syscall)
Merging kunit/test (6613476e225e Linux 6.8-rc1)
Merging kunit-next/kunit (6613476e225e Linux 6.8-rc1)
Merging livepatching/for-next (602bf1830798 Merge branch 'for-6.7' into for=
-next)
Merging rtc/rtc-next (14688f1a91e1 rtc: nuvoton: Compatible with NCT3015Y-R=
 and NCT3018Y-R)
Merging nvdimm/libnvdimm-for-next (a085a5eb6594 acpi/nfit: Use sysfs_emit()=
 for all attributes)
Merging at24/at24/for-next (6613476e225e Linux 6.8-rc1)
Merging ntb/ntb-next (9341b37ec17a ntb_perf: Fix printk format)
Merging seccomp/for-next/seccomp (8e3c9f9f3a07 selftests/seccomp: user_noti=
fication_addfd check nextfd is available)
Merging fsi/next (c5eeb63edac9 fsi: Fix panic on scom file read)
Merging slimbus/for-next (04b945e4cf81 slimbus: qcom-ngd-ctrl: Make QMI mes=
sage rules const)
Merging nvmem/for-next (a0cfd5e99782 dt-bindings: nvmem: Convert xlnx,zynqm=
p-nvmem.txt to yaml)
Merging xarray/main (2a15de80dd0f idr: fix param name in idr_alloc_cyclic()=
 doc)
Merging hyperv/hyperv-next (ce9ecca0238b Linux 6.6-rc2)
Merging auxdisplay/auxdisplay (c52391fafcef auxdisplay: img-ascii-lcd: Use =
device_get_match_data())
Merging kgdb/kgdb/for-next (4f41d30cd6dc kdb: Fix a potential buffer overfl=
ow in kdb_local())
Merging hmm/hmm (6613476e225e Linux 6.8-rc1)
Merging cfi/cfi/next (06c2afb862f9 Linux 6.5-rc1)
Merging mhi/mhi-next (8ddf54a32111 bus: mhi: host: Read PK HASH dynamically)
Merging memblock/for-next (2159bd4e9057 memblock: Return NUMA_NO_NODE inste=
ad of -1 to improve code readability)
Merging cxl/next (73bf93edeeea cxl/core: use sysfs_emit() for attr's _show(=
))
Merging zstd/zstd-next (3f832dfb8a8e zstd: fix g_debuglevel export warning)
Merging efi/next (4afa688d7141 efi: memmap: fix kernel-doc warnings)
Merging unicode/for-next (367122c529f3 libfs: Attempt exact-match compariso=
n first during casefolded lookup)
Merging slab/slab/for-next (7d2ec24bd8a5 Merge branch 'slab/for-6.9/optimiz=
e-get-freelist' into slab/for-next)
Merging random/master (615d30064886 Merge tag 'trace-v6.8-rc1' of git://git=
kernel.org/pub/scm/linux/kernel/git/trace/linux-trace)
Merging landlock/next (2f8bb71d737c landlock: Document IOCTL support)
Merging rust/rust-next (f090f0d0eea9 rust: sync: update integer types in Co=
ndVar)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
Merging sysctl/sysctl-next (6613476e225e Linux 6.8-rc1)
Merging execve/for-next/execve (41bccc98fb79 Linux 6.8-rc2)
Merging bitmap/bitmap-for-next (071ad962baf5 bitmap: Step down as a reviewe=
r)
CONFLICT (content): Merge conflict in drivers/tty/serial/sc16is7xx.c
Merging hte/for-next (b85ea95d0864 Linux 6.7-rc1)
Merging kspp/for-next/kspp (19b070fefd0d VMCI: Fix memcpy() run-time warnin=
g in dg_dispatch_as_host())
Merging kspp-gustavo/for-next/kspp (6613476e225e Linux 6.8-rc1)
Merging nolibc/nolibc (6613476e225e Linux 6.8-rc1)
Merging tsm/tsm-next (f4738f56d1dc virt: tdx-guest: Add Quote generation su=
pport using TSM_REPORTS)
Merging iommufd/for-next (6613476e225e Linux 6.8-rc1)
Merging header_cleanup/header_cleanup (5f4c01f1e3c7 spinlock: Fix failing b=
uild for PREEMPT_RT)

--Sig_/19EtE/22t1GufyQFojzmm99
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8bA4ACgkQAVBC80lX
0GxLTQgAiWfzTwHER+woJG4XYpkX/aDmcajS6m8nOWE+luDMk19lMdhqZPZOgzu1
mzlgAa23iliGcfbMDFxrrwYJhvZaQs6etzq3SsGhp2VyRiFoTS131IxWmsDsno0y
CV8KVMGevP4Bx6TERAiG1BTk9aaXdBiDmb7Vlr1kW/MmSvsNwEz95eQwSdHPWxPc
1eH0sGKdPl0yvdfdKT7nTiXQOb+sn+7KcItBASinkvQMrqecNj+TgOP1d62iOPbs
cHEP7h194L3OtR8mIQypI+6sVorqv41PLA3ONYPUuSkJYTGC479eEABrWKcQ9rO3
7GCXzYFsBVAHOPa+CHv/UgJT0C7+Bg==
=0NBu
-----END PGP SIGNATURE-----

--Sig_/19EtE/22t1GufyQFojzmm99--

