Return-Path: <linux-kernel+bounces-94096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F38739E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFEC289423
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64A13473B;
	Wed,  6 Mar 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWtF4iFc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E7134740;
	Wed,  6 Mar 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736931; cv=none; b=blJEya6wj7zRCricPfYsQdidMgdVDE8gZzIU4PjI16btnQx+Mr7vt9FVUUUsUhZ4+yY7OWB8x3y/LRKek5wqD2ijmaSGv4VfpKZFrgFNEZWrnwhBskZR9gkvfa9x15Ujvx5qYvJO54mYAnrdUEWNLG4Gg7sxIXG85yydhlGwl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736931; c=relaxed/simple;
	bh=tpNxRRXTyXEvGT8kgUPseEQTik3kbxqqpoHM/2F9l7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGk13F4QTvYhQkoMK2qn1rhn6CklmvSHQvqmOXsQqn0zJsYaeKncKv8RvB6jVutoqHiE8osRObaooz8PadEicgYkgX3TJCinwI4yVym0Fkd5BIJ/bjGHHG5keEHj3UkpxVP8d2XtzPyhCnff3emwHO5Ef0FPQv55DN7oEY9eJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWtF4iFc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcc7f4717fso68794675ad.0;
        Wed, 06 Mar 2024 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736929; x=1710341729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmVxiEtpPvggsfPkwP3gSeIb+Cc3pFsfQo+alH8a0Cc=;
        b=HWtF4iFcYc3BOR0Aj7xMGnS7tseTm8AnhSKAoJhd2oHkgATr+N/FmXD6bcMUTve8R1
         NoScUivRVdNquuICqeKm4swWFq314xu7jeeT6leVlkEEwUa1G3+2CaaTaquO0DP7KJJY
         TForz3NuBeI/IBKDnx5G1rqnvF7z9Cdk4msvM7gy3ZLFsPx7PT5/XJq6QgSDC/kYBRz5
         1dPLnzzuTWdRJSf5dG/r0hm73ujoX8s47i36lMz6mb5D/EPy7EAGMRqpPuIot6ikTukz
         v2HhyLRE0dedqPd9aMLECFT1SNw8uX31QzFLcyESBeq52gbmonNGDHX3J0Zox/gdhESl
         gdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736929; x=1710341729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmVxiEtpPvggsfPkwP3gSeIb+Cc3pFsfQo+alH8a0Cc=;
        b=kGnBsPp5y6KbubSLiYcS7Lyu8lZwD0zAXSmXYkEQJr3IaWaZ4fxQVBlK6vog9kjGeg
         gu2PY3kq4xFnC0On155SQOwCGaRtYFAEjJnUaaSErOnXbtpXTen9fGa1f5SC+aoz5fbG
         KSNAFxdDD/GrZLvKio4wB4bghQfmHtQH9Q+6kK/rtVrWX30XLwRtGfL/NmXonQHrgYbr
         29/9Nj7xCPxeCEN5qsb1lRFuwkhtfh1zkRiTKElnlDJeiVJDaCUOLaoOHaazJICLfGju
         oCo5pUXmYoQnTwSfTJmTqzf/QxqhDnyHUM6JLrWKQN5JZHizIGpYaCXTTbCCk7aoN4YE
         nrOw==
X-Forwarded-Encrypted: i=1; AJvYcCUZCEepS70qxOH4ZfcvKzt9d/p8ck47PghLj428w49wDUfP3VyHw55YblxsMR07W9nVa/l/HKAxEEKAyMDIi6TTwR1Hp/ilFlvSbmGKo0Esg/40vobFfGL+P2jiLA40yJREYggZ
X-Gm-Message-State: AOJu0Yy2X4nDX3NsZgAXwLwB0uQEDG0wTp40z3gCj8RkKc+DvYiO0kmt
	g8q3rKvMGYynlw4o5pii4PNAM1hPiij0PMiIFdTvUBvh1suH1laRik4jrRQRerSWiV1p5OlcFqi
	V9jB3H0AyDNLtct0Jdf1bQiqQAWk=
X-Google-Smtp-Source: AGHT+IFEz63kHYXC2rhbp19P9du4armBuyylycN0KrLw/cYdd8BlbL0laO1hE4ba4obK9Kyeli+TC3SVg8A9yuvyxGU=
X-Received: by 2002:a17:903:292:b0:1dc:2755:16e4 with SMTP id
 j18-20020a170903029200b001dc275516e4mr6275438plr.22.1709736928523; Wed, 06
 Mar 2024 06:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305112824.448003471@linuxfoundation.org> <qhj5qeusshc52ltonxlhvcrhwdjnpki3x5gbrbbuymyvubmh76@uyu4ypl52glc>
In-Reply-To: <qhj5qeusshc52ltonxlhvcrhwdjnpki3x5gbrbbuymyvubmh76@uyu4ypl52glc>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 6 Mar 2024 15:55:16 +0100
Message-ID: <CADo9pHh6=O828ktpe0XauwMmXkjPk3koqm2x1f2zq3j7j5fPsg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 6 mars 2024 kl 12:47 skrev Ricardo B. Marliere <ricardo@marliere.ne=
t>:
>
> On  5 Mar 11:28, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.7.9 release.
> > There are 161 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> > Anything received after that time might be too late.
>
> Hi Greg!
>
> All good in my system, no regressions.
>
> Tested-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> Thank you,
> -       Ricardo.
>
>
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.9-rc3.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------
> > Pseudo-Shortlog of commits:
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Linux 6.7.9-rc3
> >
> > Danilo Krummrich <dakr@redhat.com>
> >     drm/nouveau: don't fini scheduler before entity flush
> >
> > Geliang Tang <tanggeliang@kylinos.cn>
> >     selftests: mptcp: rm subflow with v4/v4mapped addr
> >
> > Geliang Tang <geliang.tang@linux.dev>
> >     selftests: mptcp: add mptcp_lib_is_v6
> >
> > Geliang Tang <geliang.tang@linux.dev>
> >     selftests: mptcp: update userspace pm test helpers
> >
> > Geliang Tang <geliang.tang@linux.dev>
> >     selftests: mptcp: add chk_subflows_total helper
> >
> > Geliang Tang <geliang.tang@linux.dev>
> >     selftests: mptcp: add evts_get_info helper
> >
> > Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >     KVM/VMX: Move VERW closer to VMentry for MDS mitigation
> >
> > Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >     KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
> >
> > Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >     x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
> >
> > Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >     x86/entry_32: Add VERW just before userspace transition
> >
> > Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >     x86/entry_64: Add VERW just before userspace transition
> >
> > Ming Lei <ming.lei@redhat.com>
> >     block: define bvec_iter as __packed __aligned(4)
> >
> > Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >     gpio: fix resource unwinding order in error path
> >
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     gpiolib: Fix the error path order in gpiochip_add_data_with_key()
> >
> > Arturas Moskvinas <arturas.moskvinas@gmail.com>
> >     gpio: 74x164: Enable output pins after registers are reset
> >
> > Nathan Lynch <nathanl@linux.ibm.com>
> >     powerpc/rtas: use correct function name for resetting TCE tables
> >
> > Gaurav Batra <gbatra@linux.vnet.ibm.com>
> >     powerpc/pseries/iommu: IOMMU table is not initialized for kdump ove=
r SR-IOV
> >
> > Fenghua Yu <fenghua.yu@intel.com>
> >     dmaengine: idxd: Ensure safe user copy of completion record
> >
> > Fenghua Yu <fenghua.yu@intel.com>
> >     dmaengine: idxd: Remove shadow Event Log head stored in idxd
> >
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >     phy: qcom-qmp-usb: fix v3 offsets data
> >
> > Yang Yingliang <yangyingliang@huawei.com>
> >     phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR()
> >
> > Alexander Stein <alexander.stein@ew.tq-group.com>
> >     phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashe=
s
> >
> > Kory Maincent <kory.maincent@bootlin.com>
> >     dmaengine: dw-edma: eDMA: Add sync read before starting the DMA tra=
nsfer in remote setup
> >
> > Kory Maincent <kory.maincent@bootlin.com>
> >     dmaengine: dw-edma: HDMA: Add sync read before starting the DMA tra=
nsfer in remote setup
> >
> > Kory Maincent <kory.maincent@bootlin.com>
> >     dmaengine: dw-edma: Add HDMA remote interrupt configuration
> >
> > Kory Maincent <kory.maincent@bootlin.com>
> >     dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
> >
> > Kory Maincent <kory.maincent@bootlin.com>
> >     dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
> >
> > Kory Maincent <kory.maincent@bootlin.com>
> >     dmaengine: dw-edma: Fix the ch_count hdma callback
> >
> > Dan Carpenter <dan.carpenter@linaro.org>
> >     ASoC: cs35l56: fix reversed if statement in cs35l56_dspwait_asp1tx_=
put()
> >
> > Kuniyuki Iwashima <kuniyu@amazon.com>
> >     af_unix: Drop oob_skb ref before purging queue in GC.
> >
> > Kuniyuki Iwashima <kuniyu@amazon.com>
> >     af_unix: Fix task hung while purging oob_skb in GC.
> >
> > NeilBrown <neilb@suse.de>
> >     NFS: Fix data corruption caused by congestion.
> >
> > Peter Ujfalusi <peter.ujfalusi@gmail.com>
> >     mfd: twl6030-irq: Revert to use of_match_device()
> >
> > Paolo Abeni <pabeni@redhat.com>
> >     mptcp: fix possible deadlock in subflow diag
> >
> > Davide Caratti <dcaratti@redhat.com>
> >     mptcp: fix double-free on socket dismantle
> >
> > Paolo Abeni <pabeni@redhat.com>
> >     mptcp: fix potential wake-up event loss
> >
> > Paolo Abeni <pabeni@redhat.com>
> >     mptcp: fix snd_wnd initialization for passive socket
> >
> > Geliang Tang <tanggeliang@kylinos.cn>
> >     selftests: mptcp: join: add ss mptcp support check
> >
> > Paolo Abeni <pabeni@redhat.com>
> >     mptcp: push at DSS boundaries
> >
> > Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >     mptcp: avoid printing warning once on client side
> >
> > Geliang Tang <tanggeliang@kylinos.cn>
> >     mptcp: map v4 address to v6 when destroying subflow
> >
> > Paolo Bonzini <pbonzini@redhat.com>
> >     x86/cpu/intel: Detect TME keyid bits before setting MTRR mask regis=
ters
> >
> > Paolo Bonzini <pbonzini@redhat.com>
> >     x86/cpu: Allow reducing x86_phys_bits during early_identify_cpu()
> >
> > Jiri Bohac <jbohac@suse.cz>
> >     x86/e820: Don't reserve SETUP_RNG_SEED in e820
> >
> > Byungchul Park <byungchul@sk.com>
> >     mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone inde=
x
> >
> > Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> >     mm/debug_vm_pgtable: fix BUG_ON with pud advanced test
> >
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >     fprobe: Fix to allocate entry_data_size buffer with rethook instanc=
es
> >
> > Bjorn Andersson <quic_bjorande@quicinc.com>
> >     pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
> >
> > Cristian Marussi <cristian.marussi@arm.com>
> >     pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal
> >
> > Tim Schumacher <timschumi@gmx.de>
> >     efivarfs: Request at most 512 bytes for variable names
> >
> > Nicolin Chen <nicolinc@nvidia.com>
> >     iommufd: Fix protection fault in iommufd_test_syz_conv_iova
> >
> > Nicolin Chen <nicolinc@nvidia.com>
> >     iommufd: Fix iopt_access_list_id overwrite bug
> >
> > Nathan Chancellor <nathan@kernel.org>
> >     kbuild: Add -Wa,--fatal-warnings to as-instr invocation
> >
> > Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >     power: supply: mm8013: select REGMAP_I2C
> >
> > Samuel Holland <samuel.holland@sifive.com>
> >     riscv: Fix enabling cbo.zero when running in M-mode
> >
> > Zong Li <zong.li@sifive.com>
> >     riscv: add CALLER_ADDRx support
> >
> > Nathan Chancellor <nathan@kernel.org>
> >     RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH
> >
> > Xiubo Li <xiubli@redhat.com>
> >     ceph: switch to corrected encoding of max_xattr_size in mdsmap
> >
> > Elad Nachman <enachman@marvell.com>
> >     mmc: sdhci-xenon: fix PHY init clock stability
> >
> > Elad Nachman <enachman@marvell.com>
> >     mmc: sdhci-xenon: add timeout for PHY init complete
> >
> > Ivan Semenov <ivan@semenov.dev>
> >     mmc: core: Fix eMMC initialization with 1-bit bus connection
> >
> > Christophe Kerello <christophe.kerello@foss.st.com>
> >     mmc: mmci: stm32: fix DMA API overlapping mappings warning
> >
> > Curtis Klein <curtis.klein@hpe.com>
> >     dmaengine: fsl-qdma: init irq after reg initialization
> >
> > Joy Zou <joy.zou@nxp.com>
> >     dmaengine: fsl-edma: correct calculation of 'nbytes' in multi-fifo =
scenario
> >
> > Tadeusz Struk <tstruk@gigaio.com>
> >     dmaengine: ptdma: use consistent DMA masks
> >
> > Ard Biesheuvel <ardb@kernel.org>
> >     crypto: arm64/neonbs - fix out-of-bounds access on short input
> >
> > Peng Ma <peng.ma@nxp.com>
> >     dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read
> >
> > Rob Clark <robdclark@chromium.org>
> >     soc: qcom: pmic_glink: Fix boot when QRTR=3Dm
> >
> > Ryan Lin <tsung-hua.lin@amd.com>
> >     drm/amd/display: Add monitor patch for specific eDP
> >
> > Ma Jun <Jun.Ma2@amd.com>
> >     drm/amdgpu/pm: Fix the power1_min_cap value
> >
> > Matthew Auld <matthew.auld@intel.com>
> >     drm/buddy: fix range bias
> >
> > Alex Deucher <alexander.deucher@amd.com>
> >     Revert "drm/amd/pm: resolve reboot exception for si oland"
> >
> > Filipe Manana <fdmanana@suse.com>
> >     btrfs: send: don't issue unnecessary zero writes for trailing hole
> >
> > David Sterba <dsterba@suse.com>
> >     btrfs: dev-replace: properly validate device names
> >
> > Filipe Manana <fdmanana@suse.com>
> >     btrfs: fix double free of anonymous device after snapshot creation =
failure
> >
> > Johannes Berg <johannes.berg@intel.com>
> >     wifi: nl80211: reject iftype change with mesh ID change
> >
> > Elad Nachman <enachman@marvell.com>
> >     mtd: rawnand: marvell: fix layouts
> >
> > Nhat Pham <nphamcs@gmail.com>
> >     mm: cachestat: fix folio read-after-free in cache walk
> >
> > Alexander Ofitserov <oficerovas@altlinux.org>
> >     gtp: fix use-after-free and null-ptr-deref in gtp_newlink()
> >
> > Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >     landlock: Fix asymmetric private inodes referring
> >
> > Johan Hovold <johan+linaro@kernel.org>
> >     Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
> >
> > Willian Wang <git@willian.wang>
> >     ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8
> >
> > Eniac Zhang <eniac-xw.zhang@hp.com>
> >     ALSA: hda/realtek: fix mute/micmute LED For HP mt440
> >
> > Hans Peter <flurry123@gmx.ch>
> >     ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)
> >
> > Gergo Koteles <soyer@irl.hu>
> >     ALSA: hda/realtek: tas2781: enable subwoofer volume control
> >
> > Jay Ajit Mate <jay.mate15@gmail.com>
> >     ALSA: hda/realtek: Fix top speaker connection on Dell Inspiron 16 P=
lus 7630
> >
> > Takashi Iwai <tiwai@suse.de>
> >     ALSA: ump: Fix the discard error code from snd_ump_legacy_open()
> >
> > Takashi Sakamoto <o-takashi@sakamocchi.jp>
> >     ALSA: firewire-lib: fix to check cycle continuity
> >
> > Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >     tomoyo: fix UAF write bug in tomoyo_write_control()
> >
> > Saravana Kannan <saravanak@google.com>
> >     of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing
> >
> > Sid Pranjale <sidpranjale127@protonmail.com>
> >     drm/nouveau: keep DMA buffers required for suspend/resume
> >
> > Filipe Manana <fdmanana@suse.com>
> >     btrfs: fix race between ordered extent completion and fiemap
> >
> > Dimitris Vlachos <dvlachos@ics.forth.gr>
> >     riscv: Sparse-Memory/vmemmap out-of-bounds fix
> >
> > Alexandre Ghiti <alexghiti@rivosinc.com>
> >     riscv: Fix pte_leaf_size() for NAPOT
> >
> > Alexandre Ghiti <alexghiti@rivosinc.com>
> >     Revert "riscv: mm: support Svnapot in huge vmap"
> >
> > Vadim Shakirov <vadim.shakirov@syntacore.com>
> >     drivers: perf: ctr_get_width function for legacy is not defined
> >
> > Vadim Shakirov <vadim.shakirov@syntacore.com>
> >     drivers: perf: added capabilities for legacy PMU
> >
> > Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >     drm/amd/display: Prevent potential buffer overflow in map_hw_resour=
ces
> >
> > David Howells <dhowells@redhat.com>
> >     afs: Fix endless loop in directory parsing
> >
> > Jiri Slaby (SUSE) <jirislaby@kernel.org>
> >     fbcon: always restore the old font data in fbcon_do_set_font()
> >
> > Thierry Reding <treding@nvidia.com>
> >     drm/tegra: Remove existing framebuffer only if we support display
> >
> > Conor Dooley <conor@kernel.org>
> >     RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPU=
s
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revi=
sion
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: Fix for initializing ASP1 mixer registers
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: Don't add the same register patch multiple times
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->compo=
nent
> >
> > Alexandre Ghiti <alexghiti@rivosinc.com>
> >     riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> >
> > Yangyu Chen <cyy@cyyself.name>
> >     riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
> >
> > Mikko Perttunen <mperttunen@nvidia.com>
> >     gpu: host1x: Skip reset assert on Tegra186
> >
> > Colin Ian King <colin.i.king@gmail.com>
> >     ASoC: qcom: Fix uninitialized pointer dmactl
> >
> > Takashi Iwai <tiwai@suse.de>
> >     ALSA: Drop leftover snd-rtctimer stuff from Makefile
> >
> > Richard Fitzgerald <rf@opensource.cirrus.com>
> >     ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET
> >
> > Hans de Goede <hdegoede@redhat.com>
> >     power: supply: bq27xxx-i2c: Do not free non existing IRQ
> >
> > Arnd Bergmann <arnd@arndb.de>
> >     efi/capsule-loader: fix incorrect allocation size
> >
> > Jisheng Zhang <jszhang@kernel.org>
> >     riscv: tlb: fix __p*d_free_tlb()
> >
> > Sabrina Dubroca <sd@queasysnail.net>
> >     tls: fix use-after-free on failed backlog decryption
> >
> > Sabrina Dubroca <sd@queasysnail.net>
> >     tls: separate no-async decryption request handling from async
> >
> > Sabrina Dubroca <sd@queasysnail.net>
> >     tls: fix peeking with sync+async decryption
> >
> > Sabrina Dubroca <sd@queasysnail.net>
> >     tls: decrement decrypt_pending if no async completion will be calle=
d
> >
> > Lukasz Majewski <lukma@denx.de>
> >     net: hsr: Use correct offset for HSR TLV values in supervisory HSR =
frames
> >
> > Oleksij Rempel <o.rempel@pengutronix.de>
> >     igb: extend PTP timestamp adjustments to i211
> >
> > Lin Ma <linma@zju.edu.cn>
> >     rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back
> >
> > Jakub Kicinski <kuba@kernel.org>
> >     tools: ynl: fix handling of multiple mcast groups
> >
> > Florian Westphal <fw@strlen.de>
> >     netfilter: bridge: confirm multicast packets before passing them up=
 the stack
> >
> > Ignat Korchagin <ignat@cloudflare.com>
> >     netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_vali=
date()
> >
> > Zijun Hu <quic_zijuhu@quicinc.com>
> >     Bluetooth: qca: Fix triggering coredump implementation
> >
> > Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> >     Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT
> >
> > Zijun Hu <quic_zijuhu@quicinc.com>
> >     Bluetooth: qca: Fix wrong event type for patch config command
> >
> > Kai-Heng Feng <kai.heng.feng@canonical.com>
> >     Bluetooth: Enforce validation on max value of connection interval
> >
> > Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >     Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST
> >
> > Zijun Hu <quic_zijuhu@quicinc.com>
> >     Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
> >
> > Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >     Bluetooth: hci_sync: Fix accept_list when attempting to suspend
> >
> > Ying Hsu <yinghsu@chromium.org>
> >     Bluetooth: Avoid potential use-after-free in hci_error_reset
> >
> > Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> >     Bluetooth: hci_sync: Check the correct flag before starting a scan
> >
> > Jakub Raczynski <j.raczynski@samsung.com>
> >     stmmac: Clear variable when destroying workqueue
> >
> > Justin Iurman <justin.iurman@uliege.be>
> >     uapi: in6: replace temporary label with rfc9486
> >
> > Oleksij Rempel <o.rempel@pengutronix.de>
> >     net: lan78xx: fix "softirq work is pending" error
> >
> > Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >     net: usb: dm9601: fix wrong return value in dm9601_mdio_read
> >
> > Jakub Kicinski <kuba@kernel.org>
> >     veth: try harder when allocating queue memory
> >
> > Oleksij Rempel <o.rempel@pengutronix.de>
> >     lan78xx: enable auto speed configuration for LAN7850 if no EEPROM i=
s detected
> >
> > Eric Dumazet <edumazet@google.com>
> >     ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
> >
> > Jakub Kicinski <kuba@kernel.org>
> >     net: veth: clear GRO when clearing XDP even when down
> >
> > Doug Smythies <dsmythies@telus.net>
> >     cpufreq: intel_pstate: fix pstate limits enforcement for adjust_per=
f call back
> >
> > Yunjian Wang <wangyunjian@huawei.com>
> >     tun: Fix xdp_rxq_info's queue_index when detaching
> >
> > Vladimir Oltean <vladimir.oltean@nxp.com>
> >     net: dpaa: fman_memac: accept phy-interface-type =3D "10gbase-r" in=
 the device tree
> >
> > Jeremy Kerr <jk@codeconstruct.com.au>
> >     net: mctp: take ownership of skb in mctp_local_output
> >
> > Florian Westphal <fw@strlen.de>
> >     net: ip_tunnel: prevent perpetual headroom growth
> >
> > Florian Westphal <fw@strlen.de>
> >     netlink: add nla be16/32 types to minlen array
> >
> > Ryosuke Yasuoka <ryasuoka@redhat.com>
> >     netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter
> >
> > Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >     spi: cadence-qspi: remove system-wide suspend helper calls from run=
time PM hooks
> >
> > Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >     spi: cadence-qspi: fix pointer reference in runtime PM hooks
> >
> > Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >     ice: fix pin phase adjust updates on PF reset
> >
> > Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >     ice: fix dpll periodic work data updates on PF reset
> >
> > Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >     ice: fix dpll and dpll_pin data access on PF reset
> >
> > Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >     ice: fix dpll input pin phase_adjust value updates
> >
> > Yochai Hagvi <yochai.hagvi@intel.com>
> >     ice: fix connection state of DPLL and out pin
> >
> > Han Xu <han.xu@nxp.com>
> >     mtd: spinand: gigadevice: Fix the get ecc status issue
> >
> > Josef Bacik <josef@toxicpanda.com>
> >     btrfs: fix deadlock with fiemap and extent locking
> >
> >
> > -------------
> >
> > Diffstat:
> >
> >  Documentation/arch/x86/mds.rst                     |  34 +++-
> >  Makefile                                           |   4 +-
> >  arch/arm64/crypto/aes-neonbs-glue.c                |  11 ++
> >  arch/powerpc/include/asm/rtas.h                    |   4 +-
> >  arch/powerpc/kernel/rtas.c                         |   9 +-
> >  arch/powerpc/platforms/pseries/iommu.c             | 156 +++++++++++--=
----
> >  arch/riscv/Kconfig                                 |   1 -
> >  arch/riscv/include/asm/csr.h                       |   2 +
> >  arch/riscv/include/asm/ftrace.h                    |   5 +
> >  arch/riscv/include/asm/hugetlb.h                   |   2 +
> >  arch/riscv/include/asm/pgalloc.h                   |  20 ++-
> >  arch/riscv/include/asm/pgtable-64.h                |   2 +-
> >  arch/riscv/include/asm/pgtable.h                   |   6 +-
> >  arch/riscv/include/asm/vmalloc.h                   |  61 +------
> >  arch/riscv/kernel/Makefile                         |   2 +
> >  arch/riscv/kernel/cpufeature.c                     |  17 +-
> >  arch/riscv/kernel/return_address.c                 |  48 +++++
> >  arch/riscv/mm/hugetlbpage.c                        |   2 +
> >  arch/x86/entry/entry_32.S                          |   3 +
> >  arch/x86/entry/entry_64.S                          |  11 ++
> >  arch/x86/entry/entry_64_compat.S                   |   1 +
> >  arch/x86/include/asm/entry-common.h                |   1 -
> >  arch/x86/include/asm/nospec-branch.h               |  12 --
> >  arch/x86/kernel/cpu/bugs.c                         |  15 +-
> >  arch/x86/kernel/cpu/common.c                       |   4 +-
> >  arch/x86/kernel/cpu/intel.c                        | 178 ++++++++++---=
------
> >  arch/x86/kernel/e820.c                             |   8 +-
> >  arch/x86/kernel/nmi.c                              |   3 -
> >  arch/x86/kvm/vmx/run_flags.h                       |   7 +-
> >  arch/x86/kvm/vmx/vmenter.S                         |   9 +-
> >  arch/x86/kvm/vmx/vmx.c                             |  20 ++-
> >  drivers/bluetooth/btqca.c                          |   2 +-
> >  drivers/bluetooth/hci_bcm4377.c                    |   3 +-
> >  drivers/bluetooth/hci_qca.c                        |  22 ++-
> >  drivers/cpufreq/intel_pstate.c                     |   3 +
> >  drivers/dma/dw-edma/dw-edma-v0-core.c              |  17 ++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c              |  39 +++--
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h              |   2 +-
> >  drivers/dma/fsl-edma-common.c                      |   2 +-
> >  drivers/dma/fsl-qdma.c                             |  25 +--
> >  drivers/dma/idxd/cdev.c                            |   2 +-
> >  drivers/dma/idxd/debugfs.c                         |   2 +-
> >  drivers/dma/idxd/idxd.h                            |   1 -
> >  drivers/dma/idxd/init.c                            |  15 +-
> >  drivers/dma/idxd/irq.c                             |   3 +-
> >  drivers/dma/ptdma/ptdma-dmaengine.c                |   2 -
> >  drivers/firmware/efi/capsule-loader.c              |   2 +-
> >  drivers/gpio/gpio-74x164.c                         |   4 +-
> >  drivers/gpio/gpiolib.c                             |  12 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   6 +-
> >  drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c |   5 +
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  29 +++
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   9 +-
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   9 +-
> >  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   9 +-
> >  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   9 +-
> >  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   9 +-
> >  drivers/gpu/drm/drm_buddy.c                        |  10 ++
> >  drivers/gpu/drm/nouveau/nouveau_drm.c              |   5 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |   4 +-
> >  drivers/gpu/drm/tegra/drm.c                        |  23 ++-
> >  drivers/gpu/host1x/dev.c                           |  15 +-
> >  drivers/gpu/host1x/dev.h                           |   6 +
> >  drivers/iommu/iommufd/io_pagetable.c               |   9 +-
> >  drivers/iommu/iommufd/selftest.c                   |  27 ++-
> >  drivers/mfd/twl6030-irq.c                          |  10 +-
> >  drivers/mmc/core/mmc.c                             |   2 +
> >  drivers/mmc/host/mmci_stm32_sdmmc.c                |  24 +++
> >  drivers/mmc/host/sdhci-xenon-phy.c                 |  48 ++++-
> >  drivers/mtd/nand/raw/marvell_nand.c                |  13 +-
> >  drivers/mtd/nand/spi/gigadevice.c                  |   6 +-
> >  drivers/net/ethernet/freescale/fman/fman_memac.c   |  18 +-
> >  drivers/net/ethernet/intel/ice/ice_dpll.c          |  91 ++++++++--
> >  drivers/net/ethernet/intel/igb/igb_ptp.c           |   5 +-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   4 +-
> >  drivers/net/gtp.c                                  |  12 +-
> >  drivers/net/tun.c                                  |   1 +
> >  drivers/net/usb/dm9601.c                           |   2 +-
> >  drivers/net/usb/lan78xx.c                          |   5 +-
> >  drivers/net/veth.c                                 |  40 ++---
> >  drivers/of/property.c                              |   2 +-
> >  drivers/perf/riscv_pmu.c                           |  18 +-
> >  drivers/perf/riscv_pmu_legacy.c                    |  10 +-
> >  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     |   2 +-
> >  drivers/phy/qualcomm/phy-qcom-m31.c                |   2 +-
> >  drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  10 +-
> >  drivers/pmdomain/arm/scmi_perf_domain.c            |   3 +
> >  drivers/pmdomain/qcom/rpmhpd.c                     |   7 +-
> >  drivers/power/supply/Kconfig                       |   1 +
> >  drivers/power/supply/bq27xxx_battery_i2c.c         |   4 +-
> >  drivers/soc/qcom/pmic_glink.c                      |  21 +--
> >  drivers/spi/spi-cadence-quadspi.c                  |  11 +-
> >  drivers/video/fbdev/core/fbcon.c                   |   8 +-
> >  fs/afs/dir.c                                       |   4 +-
> >  fs/btrfs/dev-replace.c                             |  24 ++-
> >  fs/btrfs/disk-io.c                                 |  22 +--
> >  fs/btrfs/disk-io.h                                 |   2 +-
> >  fs/btrfs/extent_io.c                               | 165 +++++++++++++=
+---
> >  fs/btrfs/ioctl.c                                   |   2 +-
> >  fs/btrfs/send.c                                    |  17 +-
> >  fs/btrfs/transaction.c                             |   2 +-
> >  fs/ceph/mdsmap.c                                   |   7 +-
> >  fs/ceph/mdsmap.h                                   |   6 +-
> >  fs/efivarfs/vars.c                                 |  17 +-
> >  fs/nfs/write.c                                     |   4 +-
> >  include/linux/bvec.h                               |   2 +-
> >  include/linux/netfilter.h                          |   1 +
> >  include/net/mctp.h                                 |   1 +
> >  include/sound/soc-card.h                           |   2 +
> >  include/uapi/linux/in6.h                           |   2 +-
> >  kernel/trace/fprobe.c                              |  14 +-
> >  lib/nlattr.c                                       |   4 +
> >  mm/debug_vm_pgtable.c                              |   8 +
> >  mm/filemap.c                                       |  51 +++---
> >  mm/migrate.c                                       |   8 +
> >  net/bluetooth/hci_core.c                           |   7 +-
> >  net/bluetooth/hci_event.c                          |  13 +-
> >  net/bluetooth/hci_sync.c                           |   7 +-
> >  net/bluetooth/l2cap_core.c                         |   8 +-
> >  net/bridge/br_netfilter_hooks.c                    |  96 ++++++++++
> >  net/bridge/netfilter/nf_conntrack_bridge.c         |  30 ++++
> >  net/core/rtnetlink.c                               |  11 +-
> >  net/hsr/hsr_forward.c                              |   2 +-
> >  net/ipv4/ip_tunnel.c                               |  28 ++-
> >  net/ipv6/addrconf.c                                |   7 +-
> >  net/mctp/route.c                                   |  10 +-
> >  net/mptcp/diag.c                                   |   3 +
> >  net/mptcp/options.c                                |   2 +-
> >  net/mptcp/pm_userspace.c                           |  10 ++
> >  net/mptcp/protocol.c                               |  52 +++++-
> >  net/mptcp/protocol.h                               |  21 +--
> >  net/netfilter/nf_conntrack_core.c                  |   1 +
> >  net/netfilter/nft_compat.c                         |  20 +++
> >  net/netlink/af_netlink.c                           |   2 +-
> >  net/tls/tls_sw.c                                   |  40 +++--
> >  net/unix/garbage.c                                 |  21 +--
> >  net/wireless/nl80211.c                             |   2 +
> >  scripts/Kconfig.include                            |   2 +-
> >  scripts/Makefile.compiler                          |   2 +-
> >  security/landlock/fs.c                             |   4 +-
> >  security/tomoyo/common.c                           |   3 +-
> >  sound/core/Makefile                                |   1 -
> >  sound/core/ump.c                                   |   4 +-
> >  sound/firewire/amdtp-stream.c                      |   2 +-
> >  sound/pci/hda/patch_realtek.c                      |  33 +++-
> >  sound/soc/codecs/cs35l45.c                         |   2 +-
> >  sound/soc/codecs/cs35l56-shared.c                  |   8 +-
> >  sound/soc/codecs/cs35l56.c                         | 195 +++++++++++++=
+++++---
> >  sound/soc/codecs/cs35l56.h                         |   1 +
> >  sound/soc/fsl/fsl_xcvr.c                           |  12 +-
> >  sound/soc/qcom/lpass-cdc-dma.c                     |   2 +-
> >  sound/soc/soc-card.c                               |  24 ++-
> >  tools/net/ynl/lib/ynl.c                            |   1 +
> >  tools/testing/selftests/net/mptcp/mptcp_connect.sh |  16 +-
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 192 ++++++++++++-=
-------
> >  tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  15 ++
> >  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   8 +-
> >  tools/testing/selftests/net/mptcp/userspace_pm.sh  |  86 +++++----
> >  158 files changed, 1922 insertions(+), 829 deletions(-)
> >
> >
> >
>

